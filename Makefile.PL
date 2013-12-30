use strict;
use inc::Module::Install;

name 'FetechRecipesFrom';
license 'perl'
all_from 'lib/FetchRecipesFromRakuten.pm';
all_from 'lib/FetchRecipesFromCookpad.pm';
auto_set_repository;
auto_provides;
cpanfile;
WriteAll;
