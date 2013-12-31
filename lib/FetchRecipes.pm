package FetchRecipes;

use warnings;
use strict;
use utf8;

our $VERSION = '0.01';

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Encode qw( encode decode );
use YAML;
use Data::Dumper;

sub new {
    my $class  = shift;
    my ($argv) = @_;

    my $service = $argv->{service} || "rakuten";
    my $keyword = $argv->{keyword} || "";
    my $conf    = YAML::LoadFile("config/recipe4u.yaml");

    my $self = {
        service => $service,
        keyword => $keyword,
        conf    => $conf->{$service},
    };
    return bless $self, $class;
};

sub _fetch_original_contents {
    my $self = shift;
    my $origin;

    eval {
        my $mech = WWW::Mechanize->new(
            agent      => "recipe bot 0.01",
            cookie_jar => undef,
        );
        $mech->get($self->{conf}->{search_url} . $self->{keyword});
        $origin = HTML::TreeBuilder::XPath->new();
        $origin->parse(encode('utf-8', $mech->content));
    };
    if($@) {
        return "_fetch_web_contents ERROR: " . $@;
    }
    return $origin;
};
