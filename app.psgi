use strict;
use warnings;
use utf8;

use Mojolicious::Lite;
use Project::Libs;
use Plack::Builder;
use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Encode qw( encode decode );
use Data::Dumper;

#use FetchRecipesFromRakuten;
#use FetchRecipesFromCookpad;

get '/' => 'index';

app->start;

__DATA__

@@ layouts/default.html.ep
<html>
    <head><title><%= $title %></title></head>
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css" rel="stylesheet">
    <link href="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">
    <link href="/stylesheets/lightbox.css" rel="stylesheet">
    <body>
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
        <script src="//netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js"></script>
        <script src="/javascripts/lightbox.js"></script>
        <div class="container-fluid">
            <div class="hero-unit">
                <div class="page-header">
                    <h1>Recipin :) <small>You can find your favorite recipe.</small></h1>
                </div>
            </div>
            <div class="row-fluid">
                <h1><%= $title %></h1>
                <%= content %>
            </div>
            <div class="hero-unit">
                <p>&copy; 1ch.project</p>
            </div>
        </div>
    </boby>
</html>

@@ index.html.ep
% layout 'default', title => 'レシピ検索';
<form class="form-search" action="<%= url_for('search') %>" method="get">
    <input type="text" name="data" class="search-query" style="height:30; width:300" placeholder="Input your favorite ingredient">
    <button type="submit" class="btn btn-warning">検索</button>
</form>
