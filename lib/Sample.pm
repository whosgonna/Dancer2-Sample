package Sample;
use Dancer2;
use Dancer2::Plugin::Database;

our $VERSION = '0.1';

get '/' => sub {
    template 'index' => { 'title' => 'Sample' };
};

get '/rand'               => \&random;
get '/rand/:upper_limit?' => \&random;
get 'history'             => \&history;

any [qw( get post )] => 'set_name' => \&set_name;


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
        lastq      => $last->{num},
        title      => 'Randomish'
    }
}


sub history {
    my $last10 = database->selectall_arrayref(
        'SELECT * FROM numbers ORDER BY timestamp DESC LIMIT 10',
        { Slice => {} }
    );
    template 'history' => {
        history => $last10,
        title   => 'Last 10 Results'
    }
}


sub set_name {
    my $input_name = body_parameters->get('name');
    
    if ($input_name) {
        session display_name => $input_name;
    };
    
    template 'set_name' => {
        title => 'Set Username',
    };
}


true;
