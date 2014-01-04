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

use FetchRecipes;
use FetchRecipes::FromRakuten;
use FetchRecipes::FromCookpad;

get '/search' => sub {
        my $self = shift;

        # get parameters
        my $service   = $self->param('service');
        my $keyword   = $self->param('keyword');
        my $callback||= $self->param('callback');

        my $recipe;

        if ($service eq "rakuten") {
                $recipe = new FetchRecipes::FromRakuten($keyword)->fetch_recipes;
        } elsif ($service eq "cookpad") {
                $recipe = new FetchRecipes::FromCookpad($keyword)->fetch_recipes;
        } else {
                $recipe = { Usage => "http://recipe4u.herokuapp.com/search/?service=(rakuten|cookpad)&keyword=search_word" };
        }

        if ($callback) {
                $recipe = $callback . "(" . JSON->new->ascii->encode($recipe) . ");";
        } else {
                $recipe = JSON->new->ascii->encode($recipe);
        }

        $self->stash(
                'result' => $recipe,
        );

        $self->render();

};

app->start;

__DATA__

@@ search.json.ep
<%== $result %>
