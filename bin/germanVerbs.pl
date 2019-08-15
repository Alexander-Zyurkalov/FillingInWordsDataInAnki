#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';
use ANKI;
use AbbyyLingvo;
use v5.10;
use Data::Dumper;
use JSON;
my $abbyy = AbbyyLingvo->new;

my $anki = ANKI->new;
my @notes = $anki->findNotesWithInfo(query=>'"note:German words and phrases" deck:German verb_translation:1');

foreach my $note (@notes) {
    my $word = $note->common_fields->german;
    say $word;

    my @data = $abbyy->getWordForms( word => $word );
    my %result = parse_word_forms( @data );

    my $present = $result{'Verb, intransitives'}{'Indikativ, Präsens, Aktiv'};

    # my $note->verb_fields() = $note->verb_fields(); #ANKI::Note::Fields::Verb->new(verb_translation=>'делать');

    $note->verb_fields()->ich_mache_example('ich '.$present->{ich});
    $note->verb_fields()->ich_mache($present->{ich});
    $note->verb_fields()->du_machst_example('du '.$present->{du});
    $note->verb_fields()->du_machst($present->{du});

    $note->verb_fields()->er_macht_example('er '.$present->{'er/sie/es'});
    $note->verb_fields()->er_macht($present->{er});
    $note->verb_fields()->es_macht_example('es '.$present->{'er/sie/es'});
    $note->verb_fields()->es_macht($present->{es});
    $note->verb_fields()->sie_macht_example('sie '.$present->{'er/sie/es'});
    $note->verb_fields()->sie_macht($present->{'er/sie/es'});

    $note->verb_fields()->wir_machen_example('wir '.$present->{wir});
    $note->verb_fields()->wir_machen($present->{wir});
    $note->verb_fields()->ihr_macht_example('ihr '.$present->{ihr});
    $note->verb_fields()->ihr_macht($present->{ihr});
    $note->verb_fields()->sie_machen_example('Sie '.$present->{sie});
    $note->verb_fields()->sie_machen($present->{sie});
    $note->verb_fields()->sie_machen2_example('sie '.$present->{sie});
    $note->verb_fields()->sie_machen2($present->{sie});
    say to_json {$note->getUpdateRequest()};
}
$anki->updateNoteFields( notes => \@notes );

sub parse_word_forms {
    my %result;
    foreach my $level1 (@_) {
        foreach my $level2 ( @$level1 ) {
            if ($level2->{PartOfSpeech} eq 'Verb') {
                if ($level2->{ParadigmJson}->{Grammar} eq 'Verb, intransitives') {
                    $result{'Verb, intransitives'} = parse_groups( @{$level2->{ParadigmJson}->{Groups}} );
                }
                elsif($level2->{ParadigmJson}->{Grammar} eq 'Verb, transitives') {
                    $result{'Verb, transitives'} = parse_groups( @{$level2->{ParadigmJson}->{Groups}} );
                }
            }
            else {}
        }
    }
    return %result;
}

sub parse_groups{
    my %result;
    foreach my $group (@_) {
        if ($group->{Name} eq 'Indikativ, Präsens, Aktiv') {
            $result{'Indikativ, Präsens, Aktiv'} = parse_table(@{$group->{Table}})
        }
    }
    return \%result;
}

sub parse_table {
    my %result;
    foreach my $row (@_) {
        foreach my $column ( @$row ) {
            $result{$column->{Prefix}=~s/ +$//r} = $column->{Value};
        }
    }
    return \%result;
}