#!/usr/bin/perl -w
#
# IMAP/IMAPS authenticator for Squid
# Copyright (C) 2012 Nishant Sharma <codemarauder@gmail.com>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111, USA.
#

use Authen::Simple::IMAP;

$|=1;

if ( @ARGV != 2){
	print STDERR "Usage: $0 imap(s)://imaps-server maildomain\n";
	exit 1;
}

my $server = shift @ARGV;
my $domain = shift @ARGV;
my $protocol = 'IMAP';
$protocol = 'IMAPS' if $server =~ m/imaps:\/\//;
$server =~ s/^imap(.*)\/\/(.*)$/$2/;

while (<>){
	my ($username, $password) = split(/\s+/);
	$username =~ s/%([0-9a-f][0-9a-f])/pack("H2",$1)/gie;
	my $supplieddomain = $username;
	$supplieddomain =~ s/^(.*)\@(.*)$/$2/;

	if ($supplieddomain ne $domain){
		print "ERR\n";
		next;
	}
	
	$password =~ s/%([0-9a-f][0-9a-f])/pack("H2",$1)/gie;

	my $imap = Authen::Simple::IMAP->new(
			host => $server,
			protocol => $protocol,
			timeout => 15,
		);

	if (!$imap){
		print "ERR Server not responding\n";
		next;
	}

	if ($imap->authenticate($username, $password)){
		print "OK\n";
	}
	else{
		print "ERR\n";
	}	
	undef $imap;
}
