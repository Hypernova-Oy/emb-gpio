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

package GPIO::Relay::SingleLatch;

=encoding utf8

=head1 NAME

    GPIO::Relay::SingleLatch - Single-latch relay API

=head1 DESCRIPTION

    A single latch relay needs to be added to the GPIO-pins.

=cut

use Modern::Perl;

use HiPi::GPIO;
use HiPi qw( :rpi );

use parent 'GPIO::Relay'; #This is needed for ->isa('GPIO::Relay') -checks

=head2 new

    my GPIO::Relay::SingleLatch $relay = GPIO::Relay::SingleLatch->new(23);

The new relay forces itself to the off-position during init.

 @param1 {Integer} BCM/GPIO pin which is wired to the relay's on-pin.

=cut

sub new {
    my ($class, $RELAY_ON_GPIO) = @_;
    my $self = bless({}, $class);

    $self->{relayOnPin} = $RELAY_ON_GPIO;
    $self->{gpio} = HiPi::GPIO->new();
    $self->{gpio}->set_pin_mode( $self->{relayOnPin} , RPI_MODE_OUTPUT);

    $self->switchOff();
    return $self;
}

sub switchOn {
    my ($self) = @_;
    $self->{gpio}->set_pin_level( $self->{relayOnPin}, 1 );
}

sub switchOff {
    my ($self) = @_;
    $self->{gpio}->set_pin_level( $self->{relayOnPin}, 0 );
}

1;
