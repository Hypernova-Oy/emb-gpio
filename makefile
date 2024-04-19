programName=emb-gpio
confDir=etc/$(programName)
systemdServiceDir=etc/systemd/system


debianPackages=perl cpanminus
debianPackagedPerlModules=libmodern-perl-perl libimage-imlib2-perl libnet-ssleay-perl libxml-libxml-perl libhipi-perl


#Macro to check the exit code of a make expression and possibly not fail on warnings
RC      := test $$? -lt 100 


build: compile

restart:

install: installPackages build configure perlDeploy serviceEnable

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

test:
	prove -Ilib -I. t/*.t

configure:

unconfigure:

serviceEnable:

serviceDisable:

clean:
	./Build realclean

uninstall: unconfigure serviceDisable clean

