package AbbyyLingvo;
use strict;
use warnings FATAL => 'all';
use utf8;
use Encode qw(decode encode);
use Moose;
use REST::Client;
use JSON qw(to_json from_json);
use v5.22;
use Settings::ApiKeys qw(ABBYY_LINGVO_API_KEY);

has 'client', is=>'ro', default => sub {return state $version = REST::Client->new()}, lazy=>1;

=pod

=head1 NAME

AbbyyLingvo - REST API for Abbyy Lingvo

=head1 SYNOPSIS

=head1 PUBLIC INTERFACE

=over 4

=cut


=item new()

create an instance of the Abbyy Lingvo connection.

    # with default params
    my $AbbyyLingvo = AbbyyLingvo->new();

=cut

sub new{
    my $self = shift;
    $self = $self->SUPER::new(@_);
    my $auth = '/api/v1.1/authenticate';
    my $url = 'https://developers.lingvolive.com';
    my $auth_header = {
        Authorization => "Basic ".ABBYY_LINGVO_API_KEY,
    };
    my $response = $self->client()->POST("$url$auth",'',$auth_header);
    if ($response->responseCode() == 200) {
        my $token = $response->responseContent();
        $self->{authToken} = {
            Authorization => "Bearer $token"
        };
    }
    else{
        die "There is an error during authorisation. The error ".($response->responseCode())."\n";
    }
    return $self;
}

sub _post{
    my $self = shift;
    my $action = shift;
    my $json = to_json(shift);
    my $response = $self->client()->POST($self->url()."/$action", $json);
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

=back

=cut

1;