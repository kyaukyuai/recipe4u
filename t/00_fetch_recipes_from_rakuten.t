use utf8;
use warnings;
use strict;
use Test::More;
use Data::Dumper;

use constant {
    RECIPE_COUNT => 10,
    RECIPE_BASIC_URL => 'http://recipe.rakuten.co.jp/search/',
};

use_ok("FetchRecipesFromRakuten");

foreach my $test(
    sub {
        # check instance
        my $rakuten = FetchRecipesFromRakuten->new('tomato');
        ok(defined $rakuten->{keyword});
        ok(defined $rakuten->{search_url});
        is($rakuten->{keyword}, "tomato", "keyword is valid");
        is($rakuten->{search_url}, RECIPE_BASIC_URL . $rakuten->{keyword}, "search url is valid");

        # check _fetch_contents
        $rakuten = FetchRecipesFromRakuten->new('tomato');
        can_ok($rakuten, "_fetch_original_contents");
        unlike($rakuten->_fetch_original_contents, qr/ERROR/);
        like(FetchRecipesFromRakuten->new('')->_fetch_original_contents, qr/ERROR/);

        # check fetech_recipes
        FetchRecipesFromRakuten->new('tomato')->fetch_recipes;
    }
) { $test->(); }

done_testing();
