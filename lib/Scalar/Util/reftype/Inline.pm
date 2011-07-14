use strict;
use warnings;

package Scalar::Util::reftype::Inline;

use Devel::CallChecker;
use XSLoader;

XSLoader::load(__PACKAGE__);

sub reftype { die 42 }

sub import {
    $^H{ __PACKAGE__ . '/reftype' } = 1;
    my $caller = caller;
    no strict 'refs';
    *{ join q{::} => $caller, 'reftype' } = \&reftype;
}

sub unimport {
    $^H{ __PACKAGE__ . '/reftype' } = 0;
}

1;
