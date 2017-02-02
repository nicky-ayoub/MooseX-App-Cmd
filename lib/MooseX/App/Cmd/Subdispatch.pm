package MooseX::App::Cmd::Subdispatch;

our $VERSION = '0.33';

use Moose;
use Getopt::Long::Descriptive ();
use namespace::autoclean;
extends 'Moose::Object', 'App::Cmd::Subdispatch';
with 'MooseX::Getopt';

has usage => (
    is        => 'ro',
    required  => 1,
    metaclass => 'NoGetopt',
    isa       => 'Object',
);

has app => (
    is        => 'ro',
    required  => 1,
    metaclass => 'NoGetopt',
    isa       => 'MooseX::App::Cmd',
);
override _process_args => sub {
    my ($class, $args) = @_;
    local @ARGV = @{$args};

    my $config_from_file;
    if ($class->meta->does_role('MooseX::ConfigFromFile')) {
        local @ARGV = @ARGV;

        my $configfile;
        my $opt_parser;
        {
            ## no critic (Modules::RequireExplicitInclusion)
            $opt_parser
                = Getopt::Long::Parser->new( config => ['pass_through'] );
        }
        $opt_parser->getoptions( 'configfile=s' => \$configfile );
        if (not defined $configfile
            and $class->can('_get_default_configfile'))
        {
            $configfile = $class->_get_default_configfile();
        }

        if (defined $configfile) {
            $config_from_file = $class->get_config_from_file($configfile);
        }
    }

    my %processed = $class->_parse_argv(
        params => { argv => \@ARGV },
        options => [ $class->_attrs_to_options($config_from_file) ],
    );

    return (
        $processed{params},
        $processed{argv},
        usage => $processed{usage},

        # params from CLI are also fields in MooseX::Getopt
        $config_from_file
            ? (%$config_from_file, %{ $processed{params} })
            : %{ $processed{params} },
    );
};

sub _usage_format {    ## no critic (ProhibitUnusedPrivateSubroutines)
    return shift->usage_desc;
}
## no critic (Modules::RequireExplicitInclusion)
__PACKAGE__->meta->make_immutable();
1;
