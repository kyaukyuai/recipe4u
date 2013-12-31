requires 'WWW::Mechanize';
requires 'HTML::TreeBuilder::XPath';
requires 'Encode';
requires 'FindBin::libs';
requires 'Project::Libs';
requires 'JSON';
requires 'JSON::XS';
requires 'YAML';

# for web app
requires 'Mojolicious::Lite';
requires 'Plack', '1.0000';
requires 'Server::Starter';
requires 'Starman';
requires 'Net::Server::SS::PreFork';
requires 'DBI', '1.6';

on 'test' => sub {
    requires 'Test::More';
    requires 'Devel::Cover';
    requires 'TAP::Formatter::JUnit';
    requires 'Test::Name::FromLine';
};

on 'develop' => sub {
    requires 'Module::Install';
    requires 'Module::Install::CPANfile';
    requires 'Module::Install::AuthorTests';
    requires 'Module::Install::Repository';
    requires 'Module::Install::ReadmeFromPod';
};
