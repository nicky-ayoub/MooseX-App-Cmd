package Test::MyCmd3::Command::bark::growl;
use Moose;

extends 'MooseX::App::Cmd::Command';

=head1 NAME

Test::MyCmd3::Command::bark - required field is used

=cut

has wow => (
    isa           => "Str",
    is            => "ro",
    required      => 1,
    documentation => "required option field",
);

sub execute {
    my ( $self, $opt, $arg ) = @_;

    die "my dog name barks with a growl " . $self->wow . "\n";
}

1;
