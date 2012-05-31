squid-perl-hacks
================

Squid related Perl scripts

1. imap-auth.pl
===============

Squid's basic auth helper for authentication against IMAP and IMAPS servers.

IMAP:
=====
imap-auth.pl imap://imap.myserver.com mymaildomain.com

IMAPS:
======
imap-auth.pl imaps://imap.google.com mymaildomain.com

maildomain argument is required to prevent users from authenticating with their other domain accounts
on the same server.

e.g.
Your domain, say mydomain.com, has it's mail hosted with google. You don't want users to authenticate
with some random gmail account.


This is the first attempt at creating any helper for squid.
report bugs to: codemarauder [at] gmail [dot] com
