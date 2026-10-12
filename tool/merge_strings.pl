# Dev helper: append the entries in <additions> before the closing "};" of <strings file>.
#   perl tool/merge_strings.pl lib/localization/strings_en.dart additions.txt
my ($target, $add) = @ARGV;
local $/;
open my $a, '<:raw', $add or die "no $add";
my $extra = <$a>;
close $a;
open my $t, '<:raw', $target or die "no $target";
my $src = <$t>;
close $t;
$src =~ s/\r?\n\};\s*\z/\n$extra};\n/ or die 'closing brace not found';
open my $o, '>:raw', $target or die;
print $o $src;
close $o;
