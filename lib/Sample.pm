package Sample;
use Dancer2;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Sample' };
};

get '/rand' => sub {
    my $rand = 1 + int rand(10);
    return $rand;
};

true;
