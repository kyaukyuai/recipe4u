package FetchRecipesFromRakuten;

use warnings;
use strict;
use utf8;

our $VERSION = '0.01';

use WWW::Mechanize;
use HTML::TreeBuilder::XPath;
use Encode qw( encode decode );
use Data::Dumper;

use constant {
    RECIPE_COUNT     => 30,
    RECIPE_BASIC_URL => 'http://recipe.rakuten.co.jp/search/',
};

sub new {
    my $class = shift;
    my ($keyword) = @_;
    my $search_url = RECIPE_BASIC_URL . $keyword;

    my $self = {
        keyword    => $keyword,
        search_url => $search_url,
    };
    return bless $self, $class;
};

sub _fetch_original_contents {
    my $self = shift;
    my $origin;

    eval {
        my $mech = WWW::Mechanize->new(
            agent      => "recipe bot 0.01",
            cookie_jar => undef,
        );
        $mech->get($self->{search_url});
        $origin = HTML::TreeBuilder::XPath->new();
        $origin->parse(encode('utf-8', $mech->content));
    };
    if($@) {
        return "_fetch_web_contents ERROR: " . $@;
    }
    return $origin;
};

sub fetch_recipes {
    my $self    = shift;
    my $origin  = $self->_fetch_original_contents;
    my $recipes = [];
    for (my $i = 0; $i < RECIPE_COUNT; $i++){
        push $recipes, {title => "", image => "", url => ""}
    }
    my $count;

    # fetch recipe title
    $count = 0;
    foreach my $title ($origin->findnodes('//*[@class="cateRankTtl"]/a')) {
        $recipes->[$count]->{title} = decode('utf-8', $title->as_text);
        $count ++;
        last if $count eq RECIPE_COUNT;
    }
    foreach my $title ($origin->findnodes('//*[@class="recipeHead clearfix"]/h3/a')) {
        $recipes->[$count]->{title} = decode('utf-8', $title->as_text);
        $count ++;
        last if $count eq RECIPE_COUNT;
    }

    # fetch recipe images
    $count = 0;
    foreach my $image ($origin->findnodes('//*[@class="cateRankImage"]/a/img/@src')) {
        $recipes->[$count]->{image} = decode("utf-8", $image->{_value});
        $count ++;
        last if $count eq RECIPE_COUNT;
    }
    foreach my $image ($origin->findnodes('//*[@class="recipeImg"]/a/img/@src')) {
        $recipes->[$count]->{image} = decode('utf-8', $image->{_value});
        $count ++;
        last if $count eq RECIPE_COUNT;
    }

    # fetch recipe url 
    $count = 0;
    foreach my $url ($origin->findnodes('//*[@class="cateRankImage"]/a/@href')) {
        $recipes->[$count]->{url} = 'http://recipe.rakuten.co.jp' . $url->{_value};
        $count ++;
        last if $count eq RECIPE_COUNT;
    }
    foreach my $url ($origin->findnodes('//*[@class="recipeImg"]/a/@href')) {
        $recipes->[$count]->{url} = 'http://recipe.rakuten.co.jp' . $url->{_value};
        $count ++;
        last if $count eq RECIPE_COUNT;
    }

    return $recipes;
};

1;

=pod
$recipe = { 
            recipes => [{
                recipe => {
                            title => "a",
                            image => "b",
                            url   => "c",
                },
            
           }]
          }
=cut

=head1 AUTHOR

Yuya Kakui E<lt>mail@kakuiyuya.com<gt>

=cut
