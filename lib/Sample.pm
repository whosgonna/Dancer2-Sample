package Sample;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Sample' };
};

get '/rand' => sub {
    my $rand = 1 + int rand(10);
    template 'rand' => {
        random_var => $rand,
        title      => 'Randomish'
    };
};

get '/rand/:upper_limit' => sub {
    my $max  = route_parameters->get('upper_limit');
    my $rand = 1 + int rand($max);
    template 'rand' => {
        random_var => $rand,
        title      => 'Randomish'
    }
};

true;
