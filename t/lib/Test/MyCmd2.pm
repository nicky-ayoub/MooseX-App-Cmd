package Test::MyCmd2;
use Moose;
extends 'MooseX::App::Cmd';

sub global_opt_spec {
  [ 'verbose+' => "Verbosity" ],
}

1;
