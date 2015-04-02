#!/usr/bin/perl

use strict;

my $check = `/bin/find $ENV{WORKSPACE} -name '*.rb' -type f -exec /bin/ruby -wc {} \\; 2>&1 1>/dev/null`;

die "Syntax Errors Found:\n$check\n" if $check ne "";

print "Syntax OK\n";
