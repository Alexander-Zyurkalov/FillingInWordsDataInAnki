package AbbyyLingvo;
use strict;
use warnings FATAL => 'all';
use utf8;
use Encode qw(decode encode);
use Moose;
use REST::Client;
use JSON;
use v5.22;
use Settings::ApiKeys qw(ABBYY_LINGVO_API_KEY);

has 'url', default => 'https://developers.lingvolive.com', is=>'ro';
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
    $self->SUPER::new(@_);
    # $self->{_token} = $self->_post('api/v1.1/authenticate', {
    #
    # });
     # ABBYY_LINGVO_API_KEY;
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