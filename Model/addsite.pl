#!/usr/bin/env perl
use strict;
use common::sense;
use utf8;
use warnings FATAL => qw{ uninitialized };
use autodie;

use feature ':5.20';
use feature 'signatures';
no warnings qw(experimental::signatures);

################################################################

use lib '../..';

use SylSpace::Model::Webcourse qw(_webcoursemake _webcourseremove _webcourseshow );
use SylSpace::Model::Model qw(:DEFAULT instructornewenroll);

my $usage= "usage: $0 sitename [finc3600-2018-risik-webster] instructoremail\n";

(@ARGV) or die $usage;
($#ARGV==1) or die $usage;

my ($subdomain, $iemail) = @ARGV;

## $subdomain =~ s{.syllabus.space$}{};
my $count = () = $subdomain =~ /\./g;
($count == 1) or die "Sorry, you need exactly one period in your new sitename";


$subdomain= lc($subdomain);
$iemail= lc($iemail);

_webcoursemake( $subdomain );
instructornewenroll($subdomain, $iemail);

print "successfully created website $subdomain with instructor $iemail\n";

print "
  ## if the domain is fake, please run `wildcardhosts.pl yourfakedomain.com` after you add a site.
";
}