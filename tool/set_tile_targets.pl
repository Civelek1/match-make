# Dev helper used while balancing: perl tool/set_tile_targets.pl level=target ...
# Sets every tile (non-obstacle) objective target of the given levels.
my %t = map { split /=/ } @ARGV;
for my $f (glob('lib/data/content/*_chapter.dart')) {
  open my $in, '<', $f or die; my @l = <$in>; close $in;
  my $cur = '';
  for (@l) {
    $cur = $1 if /^    id: '([a-z_]+)',/;
    if (/ObjectiveData\(/ && !/tileTypeId: '(crate|ice|chain)'/ && exists $t{$cur}) { s/target: \d+/target: $t{$cur}/ }
  }
  open my $out, '>', $f or die; print $out @l; close $out;
}
