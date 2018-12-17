#!/usr/bin/perl

use Modern::Perl;
use Test::More tests => 2;

use GPIO::Relay::DoubleLatch;
use GPIO::Relay::SingleLatch;


my $gpioOn  = 26;
my $gpioOff = 19;

# Test inheritance

my GPIO::Relay::SingleLatch $sl = GPIO::Relay::SingleLatch->new($gpioOn);
ok($sl->isa('GPIO::Relay'),
  "GPIO::Relay::SingleLatch isa GPIO::Relay");


my GPIO::Relay::DoubleLatch $dl = GPIO::Relay::DoubleLatch->new($gpioOn, $gpioOff);
ok($dl->isa('GPIO::Relay'),
  "GPIO::Relay::DoubleLatch isa GPIO::Relay");

done_testing;
