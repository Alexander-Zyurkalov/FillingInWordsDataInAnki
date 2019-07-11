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
# getUpdateRequest should return correct REST request for updating verb fields
my $verb_fields = ANKI::Note::Fields::Verb->new(
    verb_translation   => "быть; существовать",
    ich_mache          => "bin",
);
$note->verb_fields($verb_fields);
my $expected2 = {
    'action' => 'updateNoteFields',
    'version' => 6,
    'params' => {
        'note' => {
            'id' => 1514547547030,
            'fields' => {
                'ich_mache_sound' => undef,
                'ich_mache' => 'bin',
                'er_macht' => undef,
                'wir_machen_sound' => undef,
                'sie_machen_sound' => undef,
                'sie_macht_sound' => undef,
                'sie_machen_translation' => undef,
                'ich_mache_example' => undef,
                'es_macht' => undef,
                'ihr_macht_example' => undef,
                'example1_sound' => undef,
                'example1_is_ready' => undef,
                'sie_macht' => undef,
                'wir_machen_example' => undef,
                'sie_machen2_translation' => undef,
                'es_macht_example' => undef,
                'ihr_macht_translation' => undef,
                'german' => 'sein',
                'sie_macht_example' => undef,
                'er_macht_translation' => undef,
                'example1' => undef,
                'sie_machen2_sound' => undef,
                'ihr_macht_sound' => undef,
                'example2_translation' => undef,
                'ihr_macht' => undef,
                'sie_machen' => undef,
                'du_machst_example' => undef,
                'example2_sound' => undef,
                'du_machst_translation' => undef,
                'es_macht_translation' => undef,
                'sie_macht_translation' => undef,
                'example2' => undef,
                'sie_machen_example' => undef,
                'sound' => '[sound:pronunciation_de_sein.mp3]',
                'du_machst_sound' => undef,
                'sie_machen2_example' => undef,
                'es_macht_sound' => undef,
                'ich_mache_translation' => undef,
                'verb_translation' => 'быть; существовать',
                'sie_machen2' => undef,
                'example1_translation' => undef,
                'er_macht_example' => undef,
                'wir_machen_translation' => undef,
                'er_macht_sound' => undef,
                'wir_machen' => undef,
                'du_machst' => undef,
                'example2_is_ready' => undef,
                'priority' => 2
            },
        }
    }
};
is_deeply {$note->getUpdateRequest()}, $expected2,
    "getUpdateRequest should return correct REST request for updating verb fields";

done_testing();
