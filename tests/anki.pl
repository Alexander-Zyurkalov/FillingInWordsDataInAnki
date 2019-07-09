#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use ANKI;
use ANKI::Note;

my $anki = ANKI->new();


############################################################################################
# the client must be the same every time it is called
my $client1 = $anki->client;
my $client2 = $anki->client;
is $client1, $client2, "the client must be the same every time it is called";


done_testing();

