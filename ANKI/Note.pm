package ANKI::Note;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;
use ANKI::Note::Verb

has 'id', is=>'ro', required => 1;
has 'anki', is=>'ro', required => 1;
has 'modelName', is=>'ro', required => 1;
has 'fields', is=>'ro', required => 0;
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
1;