package Test::MyCmd2::Command::foo::bar;
use Moose;
extends qw/Test::MyCmd2::Command::foo/;

use constant opt_spec => (
  [ foo => "lefoobar" ],
);

1;

