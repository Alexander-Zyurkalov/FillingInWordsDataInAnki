#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use ANKI;
use Data::Dumper;
use ANKI::Note;
system('chcp 65001');

my $anki = ANKI->new();

if ($anki->getVersion() < 6 ) {
     die "Wrong version of ANKI Connect\n";
}
# $anki -> sync();
# print Dumper $anki->getDeckNames();

# my $node = ANKI::Note->new(id => 1);
# print $node->isa('ANKI::Note');

## checks whether utf-8 symbols can be used to find notes;
print Dumper $anki->findNotesWithInfo(query => "verb_translation:\"быть;*\"");

1;
