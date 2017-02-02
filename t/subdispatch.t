#!/usr/bin/perl

use strict;
use warnings;

use Test::More 'no_plan';

use Test::Fatal;
use Data::Dumper;
use lib 't/lib';

BEGIN { use_ok('Test::MyCmd2') };

my $app = Test::MyCmd2->new({});

diag (Dumper($app));

my ( $cmd, $opt, @args ) = $app->prepare_command(qw/--verbose foo --moose bar --foo/);

diag (Dumper($cmd));
diag (Dumper($opt));
diag (Dumper(\@args));

diag (Dumper($app->global_options));
is_deeply( $app->global_options, { verbose => 1 }, "global opts" );

isa_ok( $cmd, "App::Cmd::Command" );

is( ($cmd->command_names)[0], "bar", "dispatched to a nested command" );

isa_ok( $cmd->app, "MooseX::App::Cmd::Subdispatch" );

is_deeply( $cmd->app->global_options, { moose => 1 }, "subdispatcher global options" );

is_deeply( \@args, [] );

is_deeply( $opt, { foo => => 1 } );

is( exception { $app->prepare_command( 'foo' ) },
    undef,
    'run default subcommand for command' );
