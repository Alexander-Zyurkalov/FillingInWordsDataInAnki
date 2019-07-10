#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use ANKI;
use Data::Dumper;
use ANKI::Note;
use Test::More;

system('chcp 65001');

############################################################################################
# checks whether it is version 6
my $anki = ANKI->new();
is $anki->getVersion(), 6, "it should be version 6";

############################################################################################
# checks whether it is version 6
is scalar(grep {$_ eq 'German'} $anki->getDeckNames()), 1, 'German should exist among decks';

############################################################################################
# checks whether utf-8 symbols can be used to find notes;
my @notes = $anki->findNotesWithInfo(query => "verb_translation:\"быть;*\"");
is $notes[0]->common_fields()->example1_translation(), 'Где он (находится)?', "it should return correct utf8 symbols";

done_testing();
1;
