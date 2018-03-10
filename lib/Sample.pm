package Sample;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Sample' };
};

get '/rand'               => \&random;
get '/rand/:upper_limit?' => \&random;

sub random {
    my $max  = route_parameters->get('upper_limit') // 10;
    my $rand = 1 + int rand($max);
    template 'rand' => {
        max        => $max,
        random_var => $rand,
        title      => 'Randomish'
    }
}

true;
