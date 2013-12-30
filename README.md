# It's a recipe search for you.

[![Build Status](https://travis-ci.org/kyaukyuai/recipe4u.png?branch=master)](https://travis-ci.org/kyaukyuai/recipe4u)
[![Coverage Status](https://coveralls.io/repos/kyaukyuai/recipe4u/badge.png?branch=master)](https://coveralls.io/r/kyaukyuai/recipe4u?branch=master)

### It is compatible with following services.

* Rakuten
* Cookpad

How to use
-----

### CUI Ver.

    % cpanm Carton
    % carton
    % carton exec -- perl bin/fetch_recipes_from_rakuten.pl search_word > recipe.json
    % carton exec -- perl bin/fetch_recipes_from_cookpad.pl search_word > recipe.json

### Web Ver.
