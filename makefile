programName=emb-gpio
confDir=etc/$(programName)
systemdServiceDir=etc/systemd/system


debianPackages=perl cpanminus
debianPackagedPerlModules=libmodern-perl-perl libimage-imlib2-perl libnet-ssleay-perl


#Macro to check the exit code of a make expression and possibly not fail on warnings
RC      := test $$? -lt 100 


build: compile

restart:

install: installPackages build configure hipiInstall perlDeploy serviceEnable

installPackages:
	sudo apt install -y $(debianPackages)
	sudo apt install -y $(debianPackagedPerlModules)

perlDeploy:
	./Build installdeps
	./Build install

compile:
	#Build Perl modules
	perl Build.PL
	./Build

hipiInstall:
	#hipi-install is stale, using cpan
	#Upgrade HiPi or install it
	#hipi-upgrade || ( wget http://raspberry.znix.com/hipifiles/hipi-install && cat hipi-install-correct-answers | sudo perl hipi-install )
	#hipi-upgrade can malfunction and cannot pull the latest Perl modules, so manually check their existence.
	cpanm HiPi

test:
	prove -Ilib -I. t/*.t

configure:

unconfigure:

serviceEnable:

serviceDisable:

clean:
	./Build realclean

uninstall: unconfigure serviceDisable clean

