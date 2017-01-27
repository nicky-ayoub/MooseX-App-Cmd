package Test::MyCmd::Command::bark;
use Moose;

extends 'MooseX::App::Cmd::Subdispatch';

=head1 NAME

Test::MyCmd::Command::bark - required field is used

=cut

has wow => (
    isa           => "Str",
    is            => "ro",
    required      => 1,
    documentation => "required option field",
);

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die "my dog name barks " . $self->wow . "\n";
}

1;
