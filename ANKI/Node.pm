package ANKI::Node;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;

has 'id', is=>'ro', required => 1;
# has 'anki', is=>'ro', required => 1;


sub update {
    my $self = shift;
    my $action = {
        "action"  => "updateNoteFields",
        "version" => $ANKI::version,
        "params"  => {
            "note" => {
                "id"     => $self->id,
                "fields" => {
                    "Front" => "new front content",
                    "Back"  => "new back content"
                }
            }
        }
    };
    # $self->anki->updateNode($self);
}
1;