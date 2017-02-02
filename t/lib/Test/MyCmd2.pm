package Test::MyCmd2;
use Moose;
extends 'MooseX::App::Cmd';

has verbose => (
    isa           => 'Str',
    is            => 'ro',
    required      => 0,
    documentation => 'rnon equired option field',
);
1;
