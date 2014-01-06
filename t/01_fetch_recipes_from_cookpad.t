use utf8;
use warnings;
use strict;
use Test::More;
use Data::Dumper;

use_ok("FetchRecipes::FromCookpad");

foreach my $test(
    sub {
        # check instance
        my $cookpad_fetcher = FetchRecipes::FromCookpad->new('tomato');
        is($cookpad_fetcher->{service}, "cookpad", "cookpad ver.: service is valid");
        is($cookpad_fetcher->{keyword}, "tomato", "cookpad ver.: keyword is valid");
        is($cookpad_fetcher->{conf}->{basic_url}, "http://cookpad.com/", "cookpad ver.: basic_url is valid");
        is($cookpad_fetcher->{conf}->{search_url}, "http://cookpad.com/search/", "cookpad ver.: search_url is valid");
        can_ok($cookpad_fetcher, "_fetch_original_contents");
        unlike(FetchRecipes::FromCookpad->new('tomato')->_fetch_original_contents, qr/ERROR/);
        can_ok($cookpad_fetcher, "fetch_recipes");
        # check fetech_recipes
        my $recipes = FetchRecipes::FromCookpad->new('tomato')->fetch_recipes;
        ok(defined $recipes);
        ok(defined $recipes->{keyword});
        is($recipes->{keyword}, "tomato");
        ok(defined $recipes->{recipes});
        cmp_ok(ref($recipes->{recipes}), 'eq', 'ARRAY');
        ok(defined $recipes->{hits});
        like($recipes->{hits}, qr/\d+/);
    }
) { $test->(); }

done_testing();
