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

package GPIO;

our $VERSION = "0.03";

use Modern::Perl;
use HiPi::Device::GPIO;
use HiPi qw( :rpi );

sub new {
    my $class = shift;

    my $self = {};
    $self->{pin} = shift;

    my $dev = HiPi::Device::GPIO->new();
    $dev->export_pin($self->{pin});
    my $pin = $dev->get_pin($self->{pin});
    $pin->mode(RPI_PINMODE_OUTP);

    $self->{pin} = $pin;
    $self->{dev} = $dev;
    
    return bless $self, $class;
}

sub DESTROY {
    my ($self) = @_;

    if ($self->{dev} && defined($self->{pin})) {
        $self->{dev}->unexport_pin($self->{pin});
    }
}

sub turnOff {
    my ($self) = @_;
    my $pin = $self->{pin};
    $pin->value(0);
}
sub turnOn {
    my ($self) = @_;
    my $pin = $self->{pin};
    $pin->value(2);
}

1;
