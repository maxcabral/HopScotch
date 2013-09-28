package Lackey::Util::Database;

use Moose;

use DBI;
use FindBin;
use Moose::Util::TypeConstraints qw( enum );
use Try::Tiny;

has 'database' => (
  is        => 'ro',
  isa       => 'Str',
  required  => 1,
);

has 'tables' => (
  is        => 'ro',
  isa       => 'HashRef[ArrayRef]',
  required  => 1,
);

has 'engine' => (
  is        => 'ro',
  isa       => 'Str',
  default   => 'SQLite',
);

has 'db_storage_path' => (
  is        => 'ro',
  isa       => 'Str',
  default   => "$FindBin::Bin/lib/Lackey/Model/",
);

has 'dsn' => (
  is        => 'ro',
  isa       => 'Str',
  builder   => '_build_dsn',
  lazy      => 1,
);

sub _build_dsn {
  my ($self) = @_;
  my $ret_val;
  
  if ($self->engine eq 'SQLite'){
    $ret_val = 'dbi:SQLite:' . $self->db_storage_path . $self->database . '.db';
  } else {
    die "Unsupported engine";
  }
  
  return $ret_val;
}

has 'handle' => (
  is        => 'ro',
  isa       => 'DBI::db',
  lazy      => 1,
  builder   => '_build_handle',
);

sub _build_handle {
  my ($self) = @_;
  return DBI->connect( $self->dsn, undef, undef ) or die $DBI::errstr;
}

sub build_database {
  my ($self) = @_;

  warn "Building db";
  while (my ($table, $fields) = each %{$self->tables}){
    warn "process tables";
    my $statement = "CREATE TABLE $table (\nid INTEGER PRIMARY KEY\n";
    foreach my $field (@{$fields}){    
      warn "process fields";
      $statement .= ', ' . $field->{name} . ' ' . $field->{datatype} . ( $field->{not_null} ? ' NOT NULL' : '' ) . "\n"; 
    }
    $statement .= ")";
    warn $statement;
    $self->handle->do($statement) or die $self->handle->errstr;
  }                                
}

sub load_database {
  my ($self) = @_;
  my $script_path = $FindBin::Bin . '/script/lackey_create.pl';
  my $schema_name = lcfirst($self->database);
  my $command = "$script_path model $schema_name DBIC::Schema Lackey::$schema_name create=static " . $self->dsn;
  warn $command;
  `$command`;
};

1;
