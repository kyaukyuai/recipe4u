use strict;
use inc::Module::Install;

name 'FetechRecipesFrom';
license 'perl';
all_from 'lib/FetchRecipes.pm';
all_from 'lib/FetchRecipes/FromRakuten.pm';
all_from 'lib/FetchRecipes/FromCookpad.pm';
auto_set_repository;
auto_provides;
cpanfile;
WriteAll;
