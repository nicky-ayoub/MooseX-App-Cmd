#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use Test::Fatal;
use Data::Dumper;
use lib 't/lib';

BEGIN { use_ok('Test::MyCmd2') };

my $app = Test::MyCmd2->new({});

isa_ok( $app, "MooseX::App::Cmd" );
isa_ok( $app, "App::Cmd" );

diag (Dumper($app));

my ( $cmd, $opt, @args ) = $app->prepare_command(qw/--verbose foo --moose bar --foo --not_an_arg/);

diag('=' x 50);
diag (Dumper($cmd));
diag (Dumper($opt));
diag (Dumper(\@args));
diag('=' x 50);

diag (Dumper($app->global_options));
is_deeply( $app->global_options, { verbose => 1 }, "global opts" );


ok( $app->can('verbose'), "has verbosity" );

if ( $app->can('verbose') ) {
    is( $app->verbose, 1, "verbose is set" );
}
isa_ok( $cmd, "MooseX::App::Cmd::Command" );
my @command_names = ($cmd->command_names);
;
diag('=' x 50);
diag(Dumper \@command_names);
diag('=' x 50);
is( ($cmd->command_names)[0], "bar", "dispatched to a nested command" );

isa_ok( $cmd->app, "MooseX::App::Cmd::Subdispatch" );

ok( $cmd->app->can('moose'), "subdispatcher has global option moose" );
is( $cmd->app->moose, 1 , "subdispatcher has global option moose and its value is 1" );

is_deeply( \@args, [], 'All args consumed' );

is_deeply( $opt, { foo => => 1 } );

is( exception { $app->prepare_command( 'foo' ) },
    undef,
    'run default subcommand for command' );
