package Test::MyCmd2::Command::foo::bar;
use Moose;
extends qw/MooseX::App::Cmd::Command/;

use constant opt_spec => (
  [ foo => "lefoo" ],
);

1;

