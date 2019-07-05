package ANKI::Note::Fields;
use strict;
use warnings FATAL => 'all';
use Moose;
use ANKI;
use ANKI::Note;

has 'german', isa=>"Str", is=>'rw';
has 'priority', isa=>"Int", is=>'rw';


1;