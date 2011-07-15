use strict;
use warnings;
use Test::More;

use Scalar::Util::reftype::Inline;

use Scalar::Util ();

is(reftype([]), 'ARRAY');
is(reftype(bless []), 'ARRAY');

my $val = bless [], "affe";
my $ret1 =      ( reftype($val) eq "ARRAY" )   ? 1 : 0;
my $ret2 = grep { reftype($val) eq "ARRAY" } 5 ? 1 : 0;
is ($ret2, $ret1);

done_testing;
