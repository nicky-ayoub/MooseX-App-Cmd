package MooseX::App::Cmd::Subdispatch;

our $VERSION = '0.33';

use Moose;
use Getopt::Long::Descriptive ();
use namespace::autoclean;
extends 'Moose::Object', 'App::Cmd::Subdispatch';
with 'MooseX::Getopt';

1;

