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

        my $recipe = new FetchRecipesFromRakuten($keyword)->fetch_recipes;

        $self->stash(
            'result' => JSON->new->ascii->encode($recipe),
        );

        $self->render();

} => 'search';

app->start;

__DATA__

@@ search.html.ep
<%= $result %>
