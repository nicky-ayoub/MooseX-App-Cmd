package Test::MyCmd2::Command::foo::bar;
use Moose;
extends qw/Test::MyCmd2::Command::foo/;

   has foo => (
        traits => [qw(Getopt)],
        isa => 'Str',
        is  => 'rw',
        documentation => 'foo bar arg foo',
        default => sub{'lefoobar'},
    );


1;

