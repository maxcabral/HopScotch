package Lackey::Controller::Root;
use Moose;
use namespace::autoclean;

use Try::Tiny;
use URI::Escape;
use Lackey::Util::Database;

BEGIN { extends 'Catalyst::Controller' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=head1 NAME

Lackey::Controller::Root - Root Controller for Lackey

=head1 DESCRIPTION

[enter your description here]

=cut

=head1 METHODS

=cut

sub begin : Private {
  my ($self, $c) = @_;
}

=head2 index

The root page (/)

=cut
sub index : Path : Args(0) {
  my ( $self, $c ) = @_;

  if ($c->req->method eq 'POST'){
    warn "POST";
    $c->forward('index_POST');
    $c->detach();
  }

  my @nav_columns = (
    {
      url => '/project/DB',
      text => 'Lackey DB',
    },
  );

  my $all_projects = $c->model("DB::Project")->search();
  while (my $project = $all_projects->next) {
    push @nav_columns, { url => $c->uri_for_action('database',[$project->name]), text => $project->name };
  }

  $c->stash({
    section_name => 'All Projects',
    nav_columns  => \@nav_columns,
  });
}

sub index_POST :Private {
  my ($self, $c) = @_;
  my $params = $c->req->parameters;

  my $example = {
    user => [
      { name => 'name', datatype => 'text', not_null => 1 },
      { name => 'address', datatype => 'text', not_null => 0 },
      { name => 'auth_id', datatype => 'int', not_null => 1 },
    ],
    auth => [
      { name => 'email', datatype => 'text' },
      { name => 'password', datatype => 'text', },
    ],
    beverage => [
      { name => 'bar_id', datatype => 'int', not_null => 1 },
      { name => 'drink_type', datatype =>'text', not_null => 1 },
      { name => 'drink_sub_type', datatype =>'text', not_null => 0 },
      { name => 'name', datatype =>'text', not_null => 1 },
      { name => 'drink_style', datatype =>'text', not_null => 1 },
      { name => 'ingredients', datatype =>'text', not_null => 1 },
      { name => 'price_serving', datatype =>'text', not_null => 1 },
      { name => 'price_unit', datatype =>'text', not_null => 1 },
      { name => 'abv', datatype =>'text', not_null => 1 },
    ],
    food => [
      { name => 'bar_id', datatype => 'int', not_null => 1 },
      { name => 'food_type', datatype =>'text', not_null => 1 },
      { name => 'food_sub_type', datatype =>'text', not_null => 0 },
      { name => 'name', datatype =>'text', not_null => 1 },
      { name => 'food_style', datatype =>'text', not_null => 0 },
      { name => 'ingredients', datatype =>'text', not_null => 1 },
      { name => 'price_serving', datatype =>'text', not_null => 1 },
      { name => 'price_unit', datatype =>'text', not_null => 1 },
    ],
    bar => [
      { name => 'name', datatype =>'text', not_null => 1, },
      { name => 'location', datatype =>'text', not_null => 1, },
      { name => 'hours', datatype =>'text', not_null => 1, },
      { name => 'happy_hour', datatype =>'text', not_null => 1, },
    ],
    checkin => [
      { name => 'bar_id', datatype =>'int', not_null => 1, },
      { name => 'user_id', datatype =>'int', not_null => 1, },
    ],
  };

  my $db_creator = Lackey::Util::Database->new(
    tables => $example,
    database => 'hopster',
  );
  
  try {
    $db_creator->build_database();
    $db_creator->load_database();
    $c->model("DB::Project")->create({ name => 'hopster', description => 'Hopster DB' })
  } catch {
    warn "$_";
  };
   
  $c->res->redirect($c->uri_for_action('index'));
}

sub database_chain : Chained : PathPart('project') : CaptureArgs(1) {
  my ($self, $c, $project) = @_;
  my $db = $c->model("$project");
  
  $c->go('default') unless $db;

  $c->stash({ project => $project, schema => $db });
}

sub database : Chained('database_chain') : PathPart('') : Args(0) {
  my ($self, $c) = @_;
  my $project = $c->stash->{project};
  my $db = $c->stash->{schema};

  #Build the nav columns by mapping the schmea infomration for the table into the expected hash data structure
  #Urls rely on the DBIx::Class schema table name but we want to display the actual table name as well in the view.
  #Hence the gibberish below.
  my $registrations = $db->schema->source_registrations;
  my @nav_columns = map {
    { url => $c->uri_for_action('table',[$project,$_]), text => $_ . '/' . $registrations->{$_}->name }
  } sort { lc($a) cmp lc($b) } keys %$registrations;

  $c->stash({
    back_url     => $c->uri_for_action('index'),
    nav_columns  => \@nav_columns ,
    section_name => $project,    
  });
  use Data::Dumper;
#  warn Dumper $db->schema->source_registrations;
}

sub table_chain : Chained('database_chain') : PathPart('table') : CaptureArgs(1) {
  my ($self, $c, $table) = @_;
  my $project = $c->stash->{project};
  my $db;

  try {
    $db = $c->stash->{schema}->resultset($table);
  } catch {
  
  };
  $c->go('default') unless $db;

  $c->stash({ project => $project, table => $table, schema => $db });
}

sub table : Chained('table_chain') : PathPart('') : Args(0) {
  my ($self, $c,) = @_;
  my $project = $c->stash->{project};
  my $table = $c->stash->{table};
  my $db = $c->stash->{schema};

  $c->go('default') unless $db;

  $c->stash({
    back_url     => $c->uri_for_action('database',[$project]),
#    nav_columns  => \@nav_columns ,
    section_name => $table,
  });
}

=head2 default

Standard 404 error page

=cut

sub default :Path {
    my ( $self, $c ) = @_;
    $c->response->body( 'Page not found' );
    $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
