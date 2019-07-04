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
has 'test', default => 'test', is=>'rw';
has 'client', is=>'ro', default => sub {return REST::Client->new()};

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

sub sync{
    my $self = shift;
    $self->_post(
        {action=>'sync', version=>$version}
    );
}

sub getVersion {
    my $self = shift;
    if (exists $self->{version}){
        return $self->{version};
    }
    print "getting version";
    $self->{version} = $self->_post({
        "action"=> "version",
        "version" => $version
    });
    return $self->{version};
}

1;