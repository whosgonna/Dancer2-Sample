package Sample;
use Dancer2;
use Dancer2::Plugin::Database;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Sample' };
};

get '/rand'               => \&random;
get '/rand/:upper_limit?' => \&random;

sub random {
    my $max  = route_parameters->get('upper_limit') // 10;
    my $rand = 1 + int rand($max);
    my $last = database->selectrow_hashref(
        'SELECT * FROM numbers ORDER BY timestamp DESC LIMIT 1'
    );
    database->quick_insert('numbers',
        { timestamp => time, max_num => $max, num => $rand }
    );
    template 'rand' => {
        max        => $max,
        random_var => $rand,
        last       => $last->{num},
        title      => 'Randomish'
    }
}

true;
