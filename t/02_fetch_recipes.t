use utf8;
use warnings;
use strict;
use Test::More;
use Data::Dumper;

use_ok("FetchRecipes");

foreach my $test(
    sub {
        # check instance
        ## rakuten
        my $rakuten_fetcher = FetchRecipes->new( { service => 'rakuten', keyword => 'tomato' } );
        is($rakuten_fetcher->{service}, "rakuten", "rakuten ver.: service is valid");
        is($rakuten_fetcher->{keyword}, "tomato", "rakuten ver.: keyword is valid");
        is($rakuten_fetcher->{conf}->{basic_url}, "http://recipe.rakuten.co.jp/", "rakuten ver.: basic_url is valid");
        is($rakuten_fetcher->{conf}->{search_url}, "http://recipe.rakuten.co.jp/search/", "rakuten ver.: search_url is valid");
        ## cookpad
        my $cookpad_fetcher = FetchRecipes->new( { service => 'cookpad', keyword => 'orange' } );
        is($cookpad_fetcher->{service}, "cookpad", "cookpad ver.: service is valid");
        is($cookpad_fetcher->{keyword}, "orange", "cookpad ver.: keyword is valid");
        is($cookpad_fetcher->{conf}->{basic_url}, "http://cookpad.com/", "cookpad ver.: basic_url is valid");
        is($cookpad_fetcher->{conf}->{search_url}, "http://cookpad.com/search/", "cookpad ver.: search_url is valid");
        ## irrgegular
        my $irregular_fetcher = FetchRecipes->new();
        is($irregular_fetcher->{service}, "rakuten", "irregualr ver.: service is valid");
        is($irregular_fetcher->{keyword}, "", "irregualr ver.: keyword is valid");
        is($irregular_fetcher->{conf}->{basic_url}, "http://recipe.rakuten.co.jp/", "irregualr ver.: basic_url is valid");
        is($irregular_fetcher->{conf}->{search_url}, "http://recipe.rakuten.co.jp/search/", "irregualr ver.: search_url is valid");

        # check _fetch_original_contents
        can_ok($rakuten_fetcher, "_fetch_original_contents");
        can_ok($cookpad_fetcher, "_fetch_original_contents");
        unlike(FetchRecipes->new( { service => 'rakuten', keyword => 'tomato' } )->_fetch_original_contents, qr/ERROR/);
        like(FetchRecipes->new()->_fetch_original_contents, qr/ERROR/);
        unlike(FetchRecipes->new( { service => 'cookpad', keyword => 'tomato' } )->_fetch_original_contents, qr/ERROR/);
    }
) { $test->(); }

done_testing();
