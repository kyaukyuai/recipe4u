package FetchRecipes::FromCookpad;

use warnings;
use strict;
use utf8;

our $VERSION = '0.01';

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Encode qw( encode decode );

use base qw( FetchRecipes );
use Data::Dumper;

sub new {
    my $class = shift;
    my $self = $class->SUPER::new( { service => "cookpad", keyword => shift } );
    return $self;
};

sub fetch_recipes {
    my $self    = shift;
    my $origin  = $self->_fetch_original_contents;
    my @recipes = ();
    my @titles  = ();
    my @images  = ();
    my @urls    = ();

    # fetch titles
    foreach my $title ($origin->findnodes('//*[@class="title font16"]/a')) {
        push @titles, decode('utf-8', $title->as_text);
    }

    # fetch images
    foreach my $image ($origin->findnodes('//*[@class="recipe-image wide"]/a/img/@src')) {
        push @images, decode("utf-8", $image->{_value});
    }

    # fetch urls 
    foreach my $url ($origin->findnodes('//*[@class="title font16"]/a/@href')) {
        push @urls, $url->{_value};
    }

    for (my $i = 0; $i < $#titles; $i++){
        my $recipe = {
                recipe => {
                        title => $titles[$i],
                        image => $images[$i],
                        url   => $urls[$i],
                }
        };
        push @recipes, $recipe;
    }

    return { 
            keyword => $self->{keyword},
            hits    => $#titles,
            recipes => [@recipes],
    };
};

1;

=head1 AUTHOR

Yuya Kakui E<lt>mail@kakuiyuya.com<gt>

=cut
