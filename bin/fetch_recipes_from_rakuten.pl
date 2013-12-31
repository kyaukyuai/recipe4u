#!perl
use strict;
use warnings;

use Encode;
use JSON::XS;
use Pod::Usage;
use FindBin::libs;

use FetchRecipes;
use FetchRecipes::FromRakuten;

my $search_word = $ARGV[0]
    or pod2usage(-1);

my $recipe = FetchRecipes::FromRakuten->new($search_word)->fetch_recipes;

print encode_json $recipe;

__END__

=head1 NAME

fetch_recipes_from_rakuten.pl - fetch recipes from rakuten recipe (http://recipe.rakuten.co.jp/)

=head1 SYNOPSIS

    fetch_recipes_from_rakuten.pl "your_search_keyword" > result.json

    ex.) fetch_recipes_from_rakuten.pl "tomato" > tomato_recipe.json

=cut
