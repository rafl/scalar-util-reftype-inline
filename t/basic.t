use strict;
use warnings;
use Test::More;

use Scalar::Util::reftype::Inline;

use Scalar::Util ();

is(reftype([]), 'ARRAY');
is(reftype(bless []), 'ARRAY');

done_testing;
