#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use AbbyyLingvo;

my $lingvo = AbbyyLingvo->new();

############################################################################################
# Authorisation should work
like $lingvo->{authToken}->{Authorization}, qr/^Bearer \w+$/, "Authorisation should work";

############################################################################################
# WordForms test
use Data::Dumper;
print Dumper $lingvo->getWordForms(word=>'machen');

done_testing();
