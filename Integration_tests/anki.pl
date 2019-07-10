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

############################################################################################
# check updating fields
my $id = $notes[0]->id();
my $note1 = $notes[0];
$note1->common_fields()->example1_translation('Где он (находится)?1');
$anki->updateNoteFields(notes=>[$note1]);
my ($note2) = $anki->getNotesInfo(notes => [$id]);

is  $note1->common_fields()->example1_translation(),
    $note2->common_fields()->example1_translation(),
    'the fields should be changed after updating';

$note1->common_fields()->example1_translation('Где он (находится)?'); # get back the values
$anki->updateNoteFields(notes=>[$note2]);
############################################################################################

done_testing();
1;
