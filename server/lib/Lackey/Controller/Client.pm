package Lackey::Controller::Client;
use Moose;
use namespace::autoclean;

use Try::Tiny;

BEGIN { extends 'Catalyst::Controller::REST' }

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(
  namespace => 'client',
  default   => 'application/json',
);

=head1 NAME

Lackey::Controller::Client - Client API Controller for Lackey

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

## start of our Chained actions
sub database : Chained('/') PathPart('client') CaptureArgs(1) {
  my ($self, $c, $database) = @_;

  my $schema = $c->model($database);
  
  if ($schema) {
    $c->stash({
      schema => $schema,
      params => $c->req->parameters,
    });
  } else {
    $self->status_bad_request(
      $c,
      message => "Database doesn't exist",
    );
    $c->detach();
  }
} 
 
## initial URL pathpart, grabs all posts
sub table : Chained('database') PathPart('') Args(1) ActionClass('REST') {
  my ( $self, $c, $table ) = @_;

  $self->process_table($c,$table);
  $self->process_search($c);
} 

## as you know, C::C::REST needs an HTTP method defined for each action you want serialized through it.
## this doesn't do much more than grab the posts that are pre-serialized (in the perl data structure sense) and serialize
## them to our desired format (XML, JSON, etc.)
sub table_GET {
  my ( $self, $c ) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};
  my $results = $c->stash->{results};

  my $result_count = $results->count;
  if ($result_count == 0){
    return $self->status_ok( $c, entity => { count => 0, records => [] });
  } elsif ($result_count == 1) {
    return $self->status_ok( $c, entity => $self->process_entity($results->first()) );
  } else {
    return $self->status_ok( $c, entity => $self->process_entity($results) );  
  }
}

sub table_POST {
  my ($self, $c) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};
  my $results = $c->stash->{results};

  my $error;
  my $result = try {
    return $results->find_or_create({},{ key => 'primary' });
  } catch {
    $error = "$_";
    return undef;
  };

  if ($error) {
    return $self->status_bad_request( $c, message => $error );
  } else {
    my $uri =  $c->req->uri; 
    my $location = $uri->scheme . '://' . $uri->host . ':' . $uri->port . $uri->path . '/' . $result->id;
    return $self->status_created(
      $c,
      entity => $self->process_entity($result),
      location => $location,
    );    
  }
}

sub table_id : Chained('database') PathPart('') Args(2) ActionClass('REST') {
  my ( $self, $c, $table, $id ) = @_;

  $self->process_table($c,$table);
  $self->process_id($c,$id);
}

sub table_id_GET {
  my ( $self, $c ) = @_;
  $self->process_search($c);
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};
  my $results = $c->stash->{results};

  my $result_count = $results->count;
  if ($result_count == 0){
    return $self->status_not_found($c, message => "Cannot find what you were looking for!", );
  } elsif ($result_count == 1) {
    return $self->status_ok( $c, entity => $self->process_entity($results->first()) );
  } else {
    return $self->status_ok( $c, entity => $self->process_entity($results) );  
  }
}

sub table_id_PUT {
  my ($self, $c) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};

  my $error;
  my $result = $schema->first();

  $error = "No record exists for the given ID" unless $result;

  try {
    $result->update($params);
    $result->discard_changes();
  } catch {
    $error = "$_";
  } unless $error;

  if ($error) {
    return $self->status_bad_request( $c, message => $error );
  } else {
    return $self->status_ok( $c, entity => $self->process_entity($result) );    
  }
}

sub table_id_DELETE {
  my ($self, $c) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};

  my $error;
  my $result = $schema->first();

  $error = "No record exists for the given ID" unless $result;
  
  try {
    $result->delete();
  } catch {
    $error = "`$_";
  } unless $error;

  if ($error) {
    return $self->status_bad_request( $c, message => $error );
  } else {
    return $self->status_ok( $c, entity => $self->process_entity($result) );    
  }
}


sub table_id_relationship : Chained('database') PathPart('') Args(3) ActionClass('REST') {
  my ( $self, $c, $table, $id, $relationship ) = @_;

  $self->process_table($c,$table);
  $self->process_id($c,$id);
  $self->process_relationship($c,$relationship);
}

sub table_id_relationship_GET {
  my ( $self, $c ) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};
  my $results = $c->stash->{results};
  my $error = $c->stash->{error} || "Cannot find what you were looking for!";

  my $result_count = defined $results ? $results->count : 0;
  if ($result_count == 0){
    return $self->status_not_found($c, message => $error, );
  } elsif ($result_count == 1) {
    return $self->status_ok( $c, entity => $self->process_entity($results->first()) );
  } else {
    return $self->status_ok( $c, entity => $self->process_entity($results) );  
  }
}


=head1 PROCESSORS

=head2 process_table

Uses the table parameter to select the table to be queried

=cut
sub process_table {
  my ($self, $c, $table) = @_;
  my $schema = $c->stash->{schema};

  try {
    $schema = $schema->resultset($table);
  } catch {
    $schema = undef;
  };

  unless (defined $schema) {
    $self->status_bad_request(
      $c,
      message => "Table doesn't exist",
    );
    $c->detach();
  } 

  #Stash the specified schema
  $c->stash({
    schema          => $schema,
    page            => delete $c->req->parameters->{page},
    rows            => delete $c->req->parameters->{rows},
    content_type    => delete $c->req->parameters->{content_type},    
  });
}

=head2 process_id

Uses the id parameter to narrow the resultset search to a single record

=cut
sub process_id {
  my ($self, $c, $id) = @_;
  my $schema = $c->stash->{schema};

  $schema = $schema->search({ id => $id });
  $c->stash({ schema => $schema });
}


=head2 process_search

=cut
sub process_search {
  my ($self, $c) = @_;
  my $rows = $c->stash->{rows} || 10;
  my $page = $c->stash->{page} || 1;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};

  my $results = $schema->search($params,{ rows => $rows, page => $page });
  $c->stash({ schema => $schema, results => $results });
}

=head2 process_relationships

=cut
sub process_relationship {
  my ($self, $c, $relationship) = @_;
  my $schema = $c->stash->{schema};
  my $params = $c->stash->{params};

  my $error;
  try {
    $schema = $schema->search_related($relationship,$params);
  } catch {
    $error = "$_";
    #set schema to undef so we throw the error
    $schema = undef;
  };
  
  $c->stash({ results => $schema, (defined $error ? ( error => $error ) : ()) });
}

=head2 process_entity

Generic value mapper from DBIx Row/ResultSet -> Hash

=cut
sub process_entity {
  my ($self, $data) = @_;
  if (ref $data && UNIVERSAL::can($data,'isa')){
    if ($data->isa('DBIx::Class::Row')) {
      $data = { count => 1, records => [{$data->get_columns()}] };
    } elsif ($data->isa('DBIx::Class::ResultSet')){
      my @results = map { { $_->get_columns } } $data->all();
      $data = { count => scalar @results, records => \@results };
    }
  }

  return $data;
}

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
