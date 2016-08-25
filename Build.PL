use Modern::Perl;
use Module::Build;

my $build = Module::Build->new
    (
     module_name => 'GPIO',
     dist_author => 'Joonas Kylmälä <joonas.kylmala@jns.fi>',
     dist_abstract => 'Easy way to interact with GPIO pins',

     build_requires => {
	 'Modern::Perl' => '1',
     },

     requires => {
	 'Modern::Perl' => '1',
	 'HiPi::Device::GPIO' => '0.50',
	 'HiPi::Constant' => '0.20',
     }

    );

$build->create_build_script;
