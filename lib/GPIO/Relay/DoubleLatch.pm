#!/usr/bin/perl
#
# Copyright (C) 2016 Koha-Suomi
#
# This file is part of emb-relays.
#
# emb-relays is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# emb-relays is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with emb-relays.  If not, see <http://www.gnu.org/licenses/>.

package GPIO::Relay::DoubleLatch;

our $VERSION ='0.03';

use Modern::Perl;
use Time::HiRes;

use GPIO;

sub new {
    my ($class, $RELAY_ON_GPIO, $RELAY_OFF_GPIO) = @_;
    my $self = {};

    $self->{relayOnPort} = $RELAY_ON_GPIO;
    $self->{relayOffPort} = $RELAY_OFF_GPIO;
    
    return bless $self, $class;
}

sub switchOn {
    my ($self) = @_;

    my $relayOnGPIO = GPIO->new($self->{relayOnPort});

    $relayOnGPIO->turnOn();
    Time::HiRes::sleep(0.01);
    $relayOnGPIO->turnOff();
}

sub switchOff {
    my ($self) = @_;

    my $relayOffGPIO = GPIO->new($self->{relayOffPort});

    $relayOffGPIO->turnOn();
    Time::HiRes::sleep(0.01);
    $relayOffGPIO->turnOff();
}

1;
