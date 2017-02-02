package MooseX::App::Cmd::Subdispatch;

our $VERSION = '0.34';

use Moose;
use MooseX::NonMoose;
extends qw/App::Cmd::Subdispatch /;
with 'MooseX::Getopt';


1;
