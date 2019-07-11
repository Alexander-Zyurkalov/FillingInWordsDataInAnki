#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use AbbyyLingvo;

my $lingvo = AbbyyLingvo->new();


############################################################################################
# the client must be the same every time it is called
my $client1 = $lingvo->client;
my $client2 = $lingvo->client;
is $client1, $client2, "the client must be the same every time it is called";

############################################################################################
# Authorisation should work
like $lingvo->{authToken}->{Authorization}, qr/^Bearer \w+$/, "Authorisation should work";

done_testing();
