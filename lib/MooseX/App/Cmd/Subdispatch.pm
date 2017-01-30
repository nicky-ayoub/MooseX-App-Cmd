package MooseX::App::Cmd::Subdispatch;

our $VERSION = '0.34';

use Moose;
use Getopt::Long::Descriptive ();
use namespace::autoclean;
extends 'Moose::Object', 'App::Cmd::Subdispatch';
with 'MooseX::Getopt';

1;
