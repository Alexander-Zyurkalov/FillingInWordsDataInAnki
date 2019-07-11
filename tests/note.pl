#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use Test::More;
use ANKI;
use ANKI::Note;
use ANKI::Note::Fields::CommonFields;
use Data::Dumper;

############################################################################################
# Checking whether it is created correctly with correct types.
my $common_fields = ANKI::Note::Fields::CommonFields->new(
    german   => "sein",
    sound    => "[sound:pronunciation_de_sein.mp3]",
    priority => 2,
);
my $note = ANKI::Note->new( id=>1514547547030, modelName => 'German words and phrases', common_fields=>$common_fields);
isa_ok($note,"ANKI::Note");
isa_ok($note->common_fields,"ANKI::Note::Fields::CommonFields");

############################################################################################
# getUpdateRequest should return correct REST request for updating common fields
my $expected = {
    'action' => 'updateNoteFields',
    'version' => 6,
    'params' => {
        'note' => {
            'id' => 1514547547030,
            'fields' => {
                'example1_is_ready' => undef,
                'example2' => undef,
                'priority' => 2,
                'example2_is_ready' => undef,
                'example1_translation' => undef,
                'example2_translation' => undef,
                'example2_sound' => undef,
                'example1' => undef,
                'sound' => '[sound:pronunciation_de_sein.mp3]',
                'german' => 'sein',
                'example1_sound' => undef
            },
        }
    }
};
is_deeply {$note->getUpdateRequest()}, $expected,
    "getUpdateRequest should return correct REST request for updating common fields";

############################################################################################

done_testing();
