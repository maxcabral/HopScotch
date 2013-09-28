use strict;
use warnings;

use Lackey;

my $app = Lackey->apply_default_middlewares(Lackey->psgi_app);
$app;

