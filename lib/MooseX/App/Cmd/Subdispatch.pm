package MooseX::App::Cmd::Subdispatch;

our $VERSION = '0.33';

use Moose;
use Getopt::Long::Descriptive ();
use namespace::autoclean;
extends 'Moose::Object', 'App::Cmd::Subdispatch';
with 'MooseX::Getopt';

#has usage => (
#    is        => 'ro',
#    required  => 1,
#    metaclass => 'NoGetopt',
#    isa       => 'Object',
#);

has app => (
    is        => 'ro',
    required  => 1,
    metaclass => 'NoGetopt',
    isa       => 'MooseX::App::Cmd',
    builder   => '_build_app',
);

sub _build_app { $_[0]{app} };

=method prepare

  my $subcmd = $subdispatch->prepare($app, @args);

An overridden version of L<App::Cmd::Command/prepare> that performs a new
dispatch cycle.

=cut

override 'prepare' => sub  {
	my ($class, $app, @args) = @_;

	my $self = $class->new({ app => $app });

	my ($subcommand, $opt, @sub_args) = $self->get_command(@args);

  $self->set_global_options($opt);

	if (defined $subcommand) {
    return $self->_prepare_command($subcommand, $opt, @sub_args);
  } else {
    if (@args) {
      return $self->_bad_command(undef, $opt, @sub_args);
    } else {
      return $self->_prepare_default_command($opt, @sub_args);
    }
  }
};

override '_plugin_prepare' => sub {
  my ($self, $plugin, @args) = @_;
  return $plugin->prepare($self->choose_parent_app($self->app, $plugin), @args);
};



=method choose_parent_app

  $subcmd->prepare(
    $subdispatch->choose_parent_app($app, $opt, $plugin),
    @$args
  );

A method that chooses whether the parent app or the subdispatch is going to be
C<< $cmd->app >>.

=cut

sub choose_parent_app {
	my ( $self, $app, $plugin ) = @_;

	if (
    $plugin->isa("App::Cmd::Command::commands")
    or $plugin->isa("App::Cmd::Command::help")
    or scalar keys %{ $self->global_options }
  ) {
		return $self;
	} else {
		return $app;
	}
}

sub _usage_format {    ## no critic (ProhibitUnusedPrivateSubroutines)
    return shift->usage_desc;
}

## no critic (Modules::RequireExplicitInclusion)
__PACKAGE__->meta->make_immutable();
1;
