package Lackey::View::AdminView;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.html',
    render_die => 1,
);

=head1 NAME

Lackey::View::AdminView - TT View for Lackey

=head1 DESCRIPTION

TT View for Lackey.

=head1 SEE ALSO

L<Lackey>

=head1 AUTHOR

Maxwell Cabral

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
