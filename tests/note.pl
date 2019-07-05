#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use ANKI;
use ANKI::Note;
use ANKI::Note::Fields;

my $anki = ANKI->new();

#######
# Checking whether it is created correctly with correct types.
my $standard_fields = ANKI::Note::Fields->new(german=>"sein", priority=>2);
my $note = ANKI::Note->new( id=>1, anki=>$anki, modelName => 'Default', fields=>[$standard_fields]);
isa_ok($note,"ANKI::Note");
isa_ok($note->fields,"ARRAY");
isa_ok($note->fields->[0],"ANKI::Note::Fields");


done_testing();
