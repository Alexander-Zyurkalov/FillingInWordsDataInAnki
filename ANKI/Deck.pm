package ANKI::Deck;
use strict;
use warnings FATAL => 'all';
use Moose;


sub deckNames{
    print $ANKI::client;
}

sub static_method{
    print "static\n";

}

1;