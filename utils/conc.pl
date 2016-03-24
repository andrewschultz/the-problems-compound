
readConcept("Compound");
readConcept("Slicker-City");

#######################################
#prints the results
#
sub printResults
{
my $fails = 0;
my $totals = 0;

for $x (keys %any)
{
  $totals++;
#  print "Looking at $x:\n";
  if (!$expl{$x}) { print "$x needs explanation.\n"; $fails++; }
  if (!$conc{$x}) { print "$x needs concept definition.\n"; $fails++; }
}

print "Concepts test for $_[0]: ";

if ($fails) { print "Test failed, $fails failures of $totals.\n"; }
else { print "Test succeeded! All $totals passed."; }

print "\n";

}

########################################
#reads in concepts
#
sub readConcept
{

%expl = ();
%conc = ();
%any = ();

$source = "c:/games/inform/$_[0].inform/source/story.ni";
open(A, $source) || do { print "No source file $source.\n"; return; };

while ($a = <A>)
{
  if ($a =~ /^table of explanations.*concepts/) { $inTable = 1; <A>; next; }
  if ($a !~ /[a-z]/i) { $inTable = 0; next; }
  chomp($a);
  if ($inTable == 1) { $b = $a; $b =~ s/\t.*//g; $b = wordtrim($b); $expl{$b} = $any{$b} = 1; next; }
  if ($a =~ /is a (privately-named |)?concept/)
  {
    $b = $a; $b =~ s/ is a (privately-named |)?concept.*//g; $b = wordtrim($b); $conc{$b} = $any{$b} = 1; next;
  }
}

close(A);

printResults($_[0]);

}

sub wordtrim
{
  my $temp = lc($_[0]);
  $temp =~ s/^the //g;
  $temp =~ s/^a thing called //g;
  $temp =~ s/^a //g;
  return $temp;
}