#!/usr/bin/env perl
package SylSpace::Controller::InstructorInstructoradd;
use Mojolicious::Lite;
use lib qw(.. ../..); ## make syntax checking easier
use strict;

use SylSpace::Model::Model qw(sudo instructoradd);
use SylSpace::Model::Controller qw(global_redirect standard);

################################################################

post '/instructor/instructoradd' => sub {
  my $c = shift;
  (my $course = standard( $c )) or return global_redirect($c);

  sudo( $course, $c->session->{uemail} );

  my $ne=$c->req->body_params->param('newiemail');

  instructoradd( $course, $ne );
  $c->flash( message => "set $ne instructor" )->redirect_to('/instructor/instructorlist')
};

1;
