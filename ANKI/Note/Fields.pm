package ANKI::Note::Fields;
use strict;
use warnings FATAL => 'all';
use Moose::Role;
use ANKI;
use ANKI::Note;

has 'german', is=>'rw', required=>1;
has 'sound', is=>'rw', required=>0;
has 'priority', is=>'rw', required=>0;
has 'example1', is=>'rw', required=>0;
has 'example2', is=>'rw', required=>0;
has 'example1_sound', is=>'rw', required=>0;
has 'example2_sound', is=>'rw', required=>0;
has 'example1_translation', required=>0, is=>'ro';
has 'example2_translation', required=>0, is=>'ro';
has 'example1_is_ready', is=>'rw', required=>0;
has 'example2_is_ready', is=>'rw', required=>0;

requires qw(getUpdateRequest);

1;