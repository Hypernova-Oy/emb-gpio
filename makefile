programName=emb-gpio
confDir=etc/$(programName)
systemdServiceDir=etc/systemd/system


#Macro to check the exit code of a make expression and possibly not fail on warnings
RC      := test $$? -lt 100 


build: compile

install: build configure hipiInstall perlDeploy serviceEnable

perlDeploy:
	./Build installdeps
	./Build install

compile:
	#Build Perl modules
	perl Build.PL
	./Build

hipiInstall:
	#Upgrade HiPi or install it
	hipi-upgrade || ( cd ~ && wget http://raspberry.znix.com/hipifiles/hipi-install && echo 'n' | sudo perl hipi-install )

test:

configure:

unconfigure:

serviceEnable:

serviceDisable:

clean:
	./Build realclean

uninstall: unconfigure serviceDisable clean

