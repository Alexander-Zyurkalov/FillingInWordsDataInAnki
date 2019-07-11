package ANKI::Note;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;
use ANKI::Note::Fields;

=pod

=head1 SYNOPSIS

later

=head1 PUBLIC INTERFACE

later

=over 4

=cut


has 'id', is=>'ro', required => 1;
has 'modelName', is=>'ro', required => 1;

=item common_fields

The set of fields those are common for all types of words, either verbs or nouns or others.

=cut
has 'common_fields', is=>'rw', required => 1, isa=>'ANKI::Note::Fields::CommonFields';
has 'verb_fields', is=>'rw', required => 0, isa=>'ANKI::Note::Fields::Verb';
has 'tags', is=>'ro';

sub new{
    my $self = shift;
    $self->SUPER::new(@_);
}

sub getUpdateRequest {
    my $self = shift;
    my %action = (
        "action"  => "updateNoteFields",
        "version" => $ANKI::version,
        "params"  => {
            "note" => {
                "id"     => $self->id,
                "fields" => {
                    $self->common_fields()->getUpdateRequest(),
                    defined $self->verb_fields() ? $self->verb_fields()->getUpdateRequest() : (),
                },
            }
        }
    );
    return %action;
}

=back

=cut

1;