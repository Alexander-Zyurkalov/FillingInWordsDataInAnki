#!/usr/bin/perl
use strict;
use warnings;
use Test::More;
use ANKI;
use ANKI::Note;

my $anki = ANKI->new();


#######
# the client must be the same every time it is called
my $client1 = $anki->client;
my $client2 = $anki->client;
is $client1, $client2, "the client must be the same every time it is called";

#######
# initial list of prepared actions
is_deeply $anki->actions, [], "initial array must be empty";

#######
# initial list of prepared actions
$anki->addFieldUpdatingAction(note => ANKI::Note->new( id=>1, anki=>$anki, modelName => 'Default'));
is scalar @{$anki->actions}, 1, "adding a note";


done_testing();

