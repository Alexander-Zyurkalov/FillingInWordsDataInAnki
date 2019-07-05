package ANKI::Note;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;
use ANKI::Note::Fields::Verb;

=pod

=head1 SYNOPSIS

later

=head1 PUBLIC INTERFACE

later

=over 4

=cut


has 'id', is=>'ro', required => 1;
has 'anki', is=>'ro', required => 1;
has 'modelName', is=>'ro', required => 1;

=item fields

we use set of fields since a word can be a verb and a noun at the same time
and we need to handle them is one entity but different cards.

=cut
has 'fields', is=>'ro', required => 1, isa=>'ArrayRef[ANKI::Note::Fields]';

has 'tags', is=>'ro';

sub new{
    my $self = shift;
    $self->SUPER::new(@_);
}

sub initSubClass {
    # return ANKI::Note::Verb->new(@_);
}

sub updateNoteFields {
    # my $self = shift;
    # $self->fields()->update();
    # my $action = {
    #     "action"  => "updateNoteFields",
    #     "version" => $ANKI::version,
    #     "params"  => {
    #         "note" => {
    #             "id"     => $self->id,
    #             "fields" => {
    #                 "Front" => "new front content",
    #                 "Back"  => "new back content"
    #             }
    #         }
    #     }
    # };
    # $self->anki->updateNode($self);
}

=back

=cut

1;