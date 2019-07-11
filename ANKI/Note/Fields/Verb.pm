package ANKI::Note::Fields::Verb;
use warnings FATAL => 'all';
use strict;
use Moose;
use ANKI::Note;
with "ANKI::Note::Fields";

has 'verb_translation', is=>'rw', required=>1;

has 'ich_mache_example', is=>'rw', required=>0;
has 'ich_mache_translation', is=>'rw', required=>0;
has 'ich_mache', is=>'rw', required=>0;
has 'ich_mache_sound', is=>'rw', required=>0;

has 'du_machst_example', is=>'rw', required=>0;
has 'du_machst_translation', is=>'rw', required=>0;
has 'du_machst', is=>'rw', required=>0;
has 'du_machst_sound', is=>'rw', required=>0;

has 'er_macht_example', is=>'rw', required=>0;
has 'er_macht_translation', is=>'rw', required=>0;
has 'er_macht', is=>'rw', required=>0;
has 'er_macht_sound', is=>'rw', required=>0;

has 'es_macht_example', is=>'rw', required=>0;
has 'es_macht_translation', is=>'rw', required=>0;
has 'es_macht', is=>'rw', required=>0;
has 'es_macht_sound', is=>'rw', required=>0;

has 'sie_macht_example', is=>'rw', required=>0;
has 'sie_macht_translation', is=>'rw', required=>0;
has 'sie_macht', is=>'rw', required=>0;
has 'sie_macht_sound', is=>'rw', required=>0;

has 'wir_machen_example', is=>'rw', required=>0;
has 'wir_machen_translation', is=>'rw', required=>0;
has 'wir_machen', is=>'rw', required=>0;
has 'wir_machen_sound', is=>'rw', required=>0;

has 'ihr_macht_example', is=>'rw', required=>0;
has 'ihr_macht_translation', is=>'rw', required=>0;
has 'ihr_macht', is=>'rw', required=>0;
has 'ihr_macht_sound', is=>'rw', required=>0;

has 'sie_machen_example', is=>'rw', required=>0;
has 'sie_machen_translation', is=>'rw', required=>0;
has 'sie_machen', is=>'rw', required=>0;
has 'sie_machen_sound', is=>'rw', required=>0;

has 'sie_machen2_example', is=>'rw', required=>0;
has 'sie_machen2_translation', is=>'rw', required=>0;
has 'sie_machen2', is=>'rw', required=>0;
has 'sie_machen2_sound', is=>'rw', required=>0;


sub getUpdateRequest {
    my $self = shift;
    my %request = (
        verb_translation => $self->verb_translation(),
        ich_mache_example => $self->ich_mache_example(),
        ich_mache_translation => $self->ich_mache_translation(),
        ich_mache => $self->ich_mache(),
        ich_mache_sound => $self->ich_mache_sound(),
        du_machst_example => $self->du_machst_example(),
        du_machst_translation => $self->du_machst_translation(),
        du_machst => $self->du_machst(),
        du_machst_sound => $self->du_machst_sound(),
        er_macht_example => $self->er_macht_example(),
        er_macht_translation => $self->er_macht_translation(),
        er_macht => $self->er_macht(),
        er_macht_sound => $self->er_macht_sound(),
        es_macht_example => $self->es_macht_example(),
        es_macht_translation => $self->es_macht_translation(),
        es_macht => $self->es_macht(),
        es_macht_sound => $self->es_macht_sound(),
        sie_macht_example => $self->sie_macht_example(),
        sie_macht_translation => $self->sie_macht_translation(),
        sie_macht => $self->sie_macht(),
        sie_macht_sound => $self->sie_macht_sound(),
        wir_machen_example => $self->wir_machen_example(),
        wir_machen_translation => $self->wir_machen_translation(),
        wir_machen => $self->wir_machen(),
        wir_machen_sound => $self->wir_machen_sound(),
        ihr_macht_example => $self->ihr_macht_example(),
        ihr_macht_translation => $self->ihr_macht_translation(),
        ihr_macht => $self->ihr_macht(),
        ihr_macht_sound => $self->ihr_macht_sound(),
        sie_machen_example => $self->sie_machen_example(),
        sie_machen_translation => $self->sie_machen_translation(),
        sie_machen => $self->sie_machen(),
        sie_machen_sound => $self->sie_machen_sound(),
        sie_machen2_example => $self->sie_machen2_example(),
        sie_machen2_translation => $self->sie_machen2_translation(),
        sie_machen2 => $self->sie_machen2(),
        sie_machen2_sound => $self->sie_machen2_sound(),
    );
    return %request;
}

1;

