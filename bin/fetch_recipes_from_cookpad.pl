#!perl
use strict;
use warnings;

use Encode;
use JSON::XS;
use Pod::Usage;
use FindBin::libs;

use FetchRecipes;
use FetchRecipes::FromCookpad;

my $search_word = $ARGV[0]
    or pod2usage(-1);

my $recipe = FetchRecipes::FromCookpad->new($search_word)->fetch_recipes;

print encode_json $recipe;

__END__

=head1 NAME

fetch_recipes_from_cookpad.pl - fetch recipes from cookpad recipe (http://cookpad.com/)

=head1 SYNOPSIS

    fetch_recipes_from_cookpad.pl "your_search_keyword" > result.json

    ex.) fetch_recipes_from_cookpad.pl "tomato" > tomato_recipe.json

=cut
