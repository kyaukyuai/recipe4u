use utf8;
use warnings;
use strict;
use Test::More;
use Data::Dumper;

use_ok("FetchRecipes::FromRakuten");

foreach my $test(
    sub {
        # check instance
        my $rakuten_fetcher = FetchRecipes::FromRakuten->new('tomato');
        is($rakuten_fetcher->{service}, "rakuten", "rakuten ver.: service is valid");
        is($rakuten_fetcher->{keyword}, "tomato", "rakuten ver.: keyword is valid");
        is($rakuten_fetcher->{conf}->{basic_url}, "http://recipe.rakuten.co.jp/", "rakuten ver.: basic_url is valid");
        is($rakuten_fetcher->{conf}->{search_url}, "http://recipe.rakuten.co.jp/search/", "rakuten ver.: search_url is valid");
        can_ok($rakuten_fetcher, "_fetch_original_contents");
        unlike(FetchRecipes::FromRakuten->new('tomato')->_fetch_original_contents, qr/ERROR/);
        like(FetchRecipes::FromRakuten->new()->_fetch_original_contents, qr/ERROR/);
        can_ok($rakuten_fetcher, "fetch_recipes");
        # check fetech_recipes
        ok(defined FetchRecipes::FromRakuten->new('tomato')->fetch_recipes);
    }
) { $test->(); }

done_testing();
