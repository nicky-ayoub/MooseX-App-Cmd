package Test::MyCmd2::Command::foo;
use Moose;

extends qw/MooseX::App::Cmd::Subdispatch Test::MyCmd2::Command /;

use constant plugin_search_path => __PACKAGE__;

use constant global_opt_spec => (
  [ 'moose' => "lefoo" ],
);

1;
