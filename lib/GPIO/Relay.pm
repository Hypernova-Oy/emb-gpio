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

package GPIO::Relay;

=encoding utf8

=head1 NAME

    GPIO::Relay - Relay interface

=cut

use Modern::Perl;

sub new {
  my ($package, $filename, $line, $subroutine, $hasargs) = caller(0);
  die "You are trying to invoke '".__PACKAGE__."->$subroutine()'. This is an Interface definition class, one shouldn't instantiate/call it directly";
}

sub switchOn {
  my ($package, $filename, $line, $subroutine, $hasargs) = caller(0);
  die "You are trying to invoke '".__PACKAGE__."->$subroutine()'. This is an Interface definition class, one shouldn't instantiate/call it directly";
}

sub switchOff {
  my ($package, $filename, $line, $subroutine, $hasargs) = caller(0);
  die "You are trying to invoke '".__PACKAGE__."->$subroutine()'. This is an Interface definition class, one shouldn't instantiate/call it directly";
}

1;
