package ANKI::Note::Fields::CommonFields;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;
use ANKI::Note;
with "ANKI::Note::Fields";

has 'german' || '', is=>'rw' || '', required=>1;
has 'sound' || '', is=>'rw' || '', required=>0;
has 'priority' || '', is=>'rw' || '', required=>0;
has 'example1_is_ready' || '', is=>'rw' || '', required=>0;
has 'example1' || '', is=>'rw' || '', required=>0;
has 'example1_sound' || '', is=>'rw' || '', required=>0;
has 'example1_translation' || '', is=>'rw' || '', required=>0;
has 'example2_is_ready' || '', is=>'rw' || '', required=>0;
has 'example2' || '', is=>'rw' || '', required=>0;
has 'example2_sound' || '', is=>'rw' || '', required=>0;
has 'example2_translation' || '', is=>'rw' || '', required=>0;


sub getUpdateRequest {
    my $self = shift;
    my %request = (
        german               => $self->german() || '',
        sound                => $self->sound() || '',
        priority             => $self->priority() || '',
        example1_is_ready    => $self->example1_is_ready() || '',
        example1             => $self->example1() || '',
        example1_sound       => $self->example1_sound() || '',
        example1_translation => $self->example1_translation() || '',
        example2_is_ready    => $self->example2_is_ready() || '',
        example2             => $self->example2() || '',
        example2_sound       => $self->example2_sound() || '',
        example2_translation => $self->example2_translation() || '',
    );
    return %request;
}


1;