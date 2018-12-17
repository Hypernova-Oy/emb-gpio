#!/usr/bin/perl
#
# Copyright (C) 2018 Hypernova Oy
# Copyright (C) 2016 Koha-Suomi
#
# This file is part of emb-gpio.
#
# emb-gpio is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# emb-gpio is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with emb-gpio.  If not, see <http://www.gnu.org/licenses/>.

package GPIO::Relay::DoubleLatch;

=encoding utf8

=head1 NAME

    GPIO::Relay::DoubleLatch - Double-latch relay API

=head1 DESCRIPTION

    A double latch relay needs to be added to the GPIO-pins.
    It needs separate GPIO-pins to drive the ON and OFF -pins.

=cut

use Modern::Perl;
use Time::HiRes;

use HiPi::GPIO;
use HiPi qw( :rpi );

use parent 'GPIO::Relay'; #This is needed for ->isa('GPIO::Relay') -checks

=head2 new

    my GPIO::Relay::DoubleLatch $relay = GPIO::Relay::DoubleLatch->new(23);

The new relay forces itself to the off-position during init.

 @param1 {Integer} GPIO pin which is wired to the relay's on-pin.
 @param2 {Integer} GPIO pin which is wired to the relay's off-pin.
 @param3 {Double}  In floating seconds. How long one of the relay coils must be kept energized, for the relay to switch states?
                   Defaults to   0.01   (10 milliseconds)

=cut

sub new {
    my ($class, $gpioOnPin, $gpioOffPin, $gpioHoldDurationMs) = @_;
    my $self = bless({}, $class);

    $self->{relayHoldDurationMs} = $gpioHoldDurationMs || 0.01;
    $self->{relayOnPin} = $gpioOnPin;
    $self->{relayOffPin} = $gpioOffPin;
    $self->{gpio} = HiPi::GPIO->new();
    $self->{gpio}->set_pin_mode( $self->{relayOnPin},  RPI_MODE_OUTPUT);
    $self->{gpio}->set_pin_mode( $self->{relayOffPin}, RPI_MODE_OUTPUT);

    #Make sure the relay is in a resetted state
    $self->{gpio}->set_pin_level( $self->{relayOnPin}, 0 ); #ON-pin is not pulling on
    $self->switchOff();                                     #OFF-pin triggered to make sure the relay is in off-state
    return $self;
}

sub switchOn {
    my ($self) = @_;

    $self->{gpio}->set_pin_level( $self->{relayOnPin}, 1 );
    Time::HiRes::sleep($self->{relayHoldDurationMs});
    $self->{gpio}->set_pin_level( $self->{relayOnPin}, 0 );
}

sub switchOff {
    my ($self) = @_;

    $self->{gpio}->set_pin_level( $self->{relayOffPin}, 1 );
    Time::HiRes::sleep($self->{relayHoldDurationMs});
    $self->{gpio}->set_pin_level( $self->{relayOffPin}, 0 );
}

1;
