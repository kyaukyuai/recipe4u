use strict;
use warnings;
use utf8;

use Mojolicious::Lite;
use Project::Libs;
use Plack::Builder;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Encode qw( encode decode );
use JSON;
use JSON::XS;
use Data::Dumper;

use FetchRecipesFromRakuten;
use FetchRecipesFromCookpad;

get '/search' => sub {
    my $self = shift;

    # get parameters
    my $service = $self->param('service');
    my $keyword = $self->param('keyword');
    my $recipe;

    if ($service eq "rakuten") {
        $recipe = new FetchRecipesFromRakuten($keyword)->fetch_recipes;
    } elsif ($service eq "cookpad") {
        $recipe = new FetchRecipesFromCookpad($keyword)->fetch_recipes;
    } else {
        $recipe = { Usage => "http://recipe4u.herokuapp.com/search/?service=(rakuten|cookpad)&keyword=search_word" };
    }

    $self->stash(
        'result' => JSON->new->ascii->encode($recipe),
    );

    $self->render();

} => 'search';

app->start;

__DATA__

@@ search.html.ep
<%= $result %>
