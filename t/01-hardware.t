#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 3;

use GPIO::Relay::DoubleLatch;
use GPIO::Relay::SingleLatch;


my $gpioOn  = 26;
my $gpioOff = 19;

subtest "Single-latch relay", \&singleLatchRelay;
sub singleLatchRelay {
  plan tests => 2;

  my GPIO::Relay::SingleLatch $sl = GPIO::Relay::SingleLatch->new($gpioOn);

  ok(defined $sl->switchOn(),
    "Single-latch relay switched on");

  sleep(1);

  ok(defined $sl->switchOff(),
    "Single-latch relay switched off");
}

subtest "Double-latch relay", \&doubleLatchRelayDefaults;
sub doubleLatchRelayDefaults {
  plan tests => 2;

  my GPIO::Relay::DoubleLatch $sl = GPIO::Relay::DoubleLatch->new($gpioOn, $gpioOff);

  ok(defined $sl->switchOn(),
    "Double-latch relay switched on");

  sleep(1);

  ok(defined $sl->switchOff(),
    "Double-latch relay switched off");
}

subtest "Double-latch relay", \&doubleLatchRelay;
sub doubleLatchRelay {
  plan tests => 2;

  my GPIO::Relay::DoubleLatch $sl = GPIO::Relay::DoubleLatch->new($gpioOn, $gpioOff, 1.75); #1.75 is not a good value for normal use! Default should be just fine.

  ok(defined $sl->switchOn(),
    "Double-latch relay switched on");

  sleep(1);

  ok(defined $sl->switchOff(),
    "Double-latch relay switched off");
}

done_testing;
