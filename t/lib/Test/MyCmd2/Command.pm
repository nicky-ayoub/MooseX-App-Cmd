package Test::MyCmd2::Command;
use Moose;
extends qw/MooseX::App::Cmd::Command/;

has 'verbose' => (
    traits        => [qw(Getopt)],
    isa           => 'Bool',
    is            => 'ro',
    documentation => 'Verbosity',
);

1;
