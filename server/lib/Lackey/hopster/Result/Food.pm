use utf8;
package Lackey::hopster::Result::Food;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Lackey::hopster::Result::Food

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<food>

=cut

__PACKAGE__->table("food");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 bar_id

  data_type: 'int'
  is_nullable: 0

=head2 food_type

  data_type: 'text'
  is_nullable: 0

=head2 food_sub_type

  data_type: 'text'
  is_nullable: 1

=head2 name

  data_type: 'text'
  is_nullable: 0

=head2 food_style

  data_type: 'text'
  is_nullable: 1

=head2 ingredients

  data_type: 'text'
  is_nullable: 0

=head2 price_serving

  data_type: 'text'
  is_nullable: 0

=head2 price_unit

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "bar_id",
  { data_type => "int", is_nullable => 0 },
  "food_type",
  { data_type => "text", is_nullable => 0 },
  "food_sub_type",
  { data_type => "text", is_nullable => 1 },
  "name",
  { data_type => "text", is_nullable => 0 },
  "food_style",
  { data_type => "text", is_nullable => 1 },
  "ingredients",
  { data_type => "text", is_nullable => 0 },
  "price_serving",
  { data_type => "text", is_nullable => 0 },
  "price_unit",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.07035 @ 2013-09-28 16:05:28
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FcRz05y/C9JSbnY3Eei+tw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
