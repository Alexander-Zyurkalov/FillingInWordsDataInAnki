package ANKI;

use strict;
use warnings FATAL => 'all';
use utf8;
use Encode qw(decode encode);
use Moose;
use REST::Client;
use JSON;
use v5.22;
our $version = 6;

has 'url', default => 'http://localhost:8765', is=>'rw';
has 'client', is=>'ro', default => sub {return state $version = REST::Client->new()}, lazy=>1;

=pod

=head1 NAME

ANKI - REST API for ANKI Connect

=head1 SYNOPSIS

=head1 PUBLIC INTERFACE

=over 4

=cut


=item new()

create an instance of the ANKI connection.

    # with default params
    my $anki = ANKI->new();

    # in case another url is required
    my $anki = ANKI->new(url => 'http://192.168.0.1:8765');

=cut

sub new{
    my $self = shift;
    $self->SUPER::new(@_);
}

sub getDeckNames{
    my $self = shift;

    return map { encode 'utf8', $_ } @{$self->_post ( {
        "action" => "deckNames",
        "version" => $version
    })};

}

=item getNotesInfo()

get data belonged to list of notes

    my $noteList = $anki->notesInfo(notes => [1483959289817, 1483959291695]);

    returns $Node, $Node...;

=cut
sub getNotesInfo{
    my $self = shift;
    my %params = @_;
    my $notes = $params{notes};
    return map{
        ANKI::Note->new(
            id            => $_->{noteId},
            modelName     => $_->{modelName},
            common_fields => ANKI::Note::Fields->new(
                german               => encode('utf8', $_->{fields}->{german}->{value}),
                sound                => encode('utf8', $_->{fields}->{sound}->{value}),
                priority             => encode('utf8', $_->{fields}->{priority}->{value}),
                example1_is_ready    => encode('utf8', $_->{fields}->{example1_is_ready}->{value}),
                example1             => encode('utf8', $_->{fields}->{example1}->{value}),
                example1_sound       => encode('utf8', $_->{fields}->{example1_sound}->{value}),
                example1_translation => encode('utf8', $_->{fields}->{example1_translation}->{value}),
                example2_is_ready    => encode('utf8', $_->{fields}->{example2_is_ready}->{value}),
                example2             => encode('utf8', $_->{fields}->{example2}->{value}),
                example2_sound       => encode('utf8', $_->{fields}->{example2_sound}->{value}),
                example2_translation => encode('utf8', $_->{fields}->{example2_translation}->{value}),
            )
        )
    } @{$self->_post ({
        action => "notesInfo",
        version => $version,
        params => {
            notes => $notes
        }
    })};
}

=item findNodes()

find a list of ID's.

    # with default params
    my @list = $anki->findNotes(query => "\"note:German words and phrases\"");

    #result example:
    #[1483959289817, 1483959291695]

=cut

sub findNotes{
    my $self = shift;
    my %params = @_;
    my $query = $params{query};

    return
        @{
            $self->_post ({
                action => "findNotes",
                version => $version,
                params => {
                    "query" => $query
                }
            })
        };
}

=item findNotesWithInfo()

find a list of ID's and get data immediately

=cut

sub findNotesWithInfo{
    my $self = shift;
    return $self->getNotesInfo(notes => [$self->findNotes(@_)]);
}

sub _post{
    my $self = shift;
    my $json = to_json(shift);
    my $response = $self->client()->POST($self->url, $json);
    if ($response -> responseCode() == 200) {
        my $json_answer = $response->responseContent();
        my $result = from_json($json_answer);
        if (defined $result->{error}){
            die "Error!".$result->{error}."\n";
        }
        return $self->{version} = $result->{result};
    }
    else {
        die "Wrong respond ".($response->responseCode())."\n";
    }
}

=item sync

=cut

sub sync{
    my $self = shift;
    $self->_post(
        {action=>'sync', version=>$version}
    );
}

#TODO change it so that it was created by Moose via "has"
sub getVersion {
    my $self = shift;
    if (exists $self->{version}){
        return $self->{version};
    }
    $self->{version} = $self->_post({
        "action"=> "version",
        "version" => $version
    });
    return $self->{version};
}

=back

=cut

1;