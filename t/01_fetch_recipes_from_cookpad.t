use utf8;
use warnings;
use strict;
use Test::More;
use Data::Dumper;

use constant {
    RECIPE_SEARCH_URL => 'http://cookpad.com/search/',
};

use_ok("FetchRecipesFromCookpad");

foreach my $test(
    sub {
        # check instance
        my $cookpad = FetchRecipesFromCookpad->new('tomato');
        can_ok($cookpad, "_fetch_original_contents");
        can_ok($cookpad, "fetch_recipes");
        ok(defined $cookpad->{keyword});
        ok(defined $cookpad->{search_url});
        is($cookpad->{keyword}, "tomato", "keyword is valid");
        is($cookpad->{search_url}, RECIPE_SEARCH_URL . $cookpad->{keyword}, "search url is valid");

        # check _fetch_contents
        $cookpad = FetchRecipesFromCookpad->new('tomato');
        unlike($cookpad->_fetch_original_contents, qr/ERROR/);

        # check fetech_recipes
        ok(defined FetchRecipesFromCookpad->new('tomato')->fetch_recipes);
    }
) { $test->(); }

done_testing();
