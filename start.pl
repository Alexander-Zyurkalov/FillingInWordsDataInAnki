#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use ANKI;
use Data::Dumper;
use ANKI::Node;
system('chcp 65001');

my $anki = ANKI->new();

if ($anki->getVersion() != 6 ) {
     die "Wrong version of ANKI Connect\n";
}
print $anki->getVersion();
# $anki -> sync();
print Dumper $anki->getDeckNames();

my $node = ANKI::Node->new(id => 1);
print $node->isa('ANKI::Node');

print "OK\n";

1;
