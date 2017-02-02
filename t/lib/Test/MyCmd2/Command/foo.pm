package Test::MyCmd2::Command::foo;
use Moose;

extends qw/Test::MyCmd2::Command /;

use constant plugin_search_path => __PACKAGE__;

has moose => (
    traits        => [qw(Getopt)],
    isa           => 'Bool',
    is            => 'rw',
    documentation => 'bar arg moose',
    default       => sub {1},
);


1;
