use Win32::Clipboard;

$clip = Win32::Clipboard::new();

if (@ARGV[0] eq "") { readConcept("Compound"); readConcept("Slicker-City"); }
elsif (@ARGV[0] eq "pc") { readConcept("Compound"); }
elsif (@ARGV[0] eq "sc") { readConcept("Slicker-City"); }
else { print "Note that this assumes the idiom written properly e.g. show business vs business show."; foreach $x (@ARGV[0]) { crankOutCode($x); } exit; }

sub crankOutCode
{
  $temp = $_[0]; $temp =~ s/-/ /g;
  $bkwd = join(" ", reverse(split(/ /, $temp)));
  if ($a) { $a .= "\n"; }
  $a .= "\[activation of $temp\]\n$temp is a concept in conceptville. understand \"$bkwd\" as $temp. howto is \"fill this in here\". \[search for cv]\n$temp\t\"$temp is when you .\" \[search for xadd\]\n";
  $clip->Set($a);
  print "To clipboard:\n$a";
}

#######################################
#prints the results
#
sub printResults
{
my $fails = 0;
my $totals = 0;
my $errMsg = "";

for $x (keys %any)
{
  $totals++;
#  print "Looking at $x:\n";
  if (!$expl{$x}) { $errMsg .= "$x needs explanation.\n"; $fails++; }
  if (!$conc{$x}) { $errMsg .= "$x needs concept definition.\n"; $fails++; }
  if (!$activ{$x}) { $errMsg .= "$x needs activation.\n"; $fails++; }
}

print "$errMsg";

if (!$errMsg) { $errMsg = "All okay!"; } else { $errMsg =~ s/\n/<br>/g; $errMsg =~ s/<br>$//g; }

print "TEST RESULTS:concepts-$_[0],0,$fails,$totals,$errMsg\n";

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
  $line++;
  if ($a =~ /section misc concept\(s\)/) { $concepts = $line; }
  if ($a =~ /^table of explanations.*concepts/) { $xadd = $line; $inTable = 1; <A>; next; }
  if ($a !~ /[a-z]/i) { $inTable = 0; next; }
  chomp($a); $a = lc($a);
  if ($a =~ /is a concept in lalaland/)
  {
    $a =~ s/ is a concept in lalaland.*//g;
	$conc{$a} = 1;
	$activ{$a} = 1;
	$any{$a} = 1;
  }
  $b = $a;
  while ($b =~ /\[activation of/)
  {
    $b =~ s/.*?\[activation of //; $c = $b;
	$c =~ s/\].*//g;
	$activ{$c} = 1; $any{$c} = 1;
  }
  if ($inTable == 1) { $b = $a; $b =~ s/\t.*//g; $b = wordtrim($b); $expl{$b} = $any{$b} = 1; next; }
  if ($a =~ /is a (privately-named |)?concept/)
  {
    $b = $a; $b =~ s/ is a (privately-named |)?concept.*//g; $b = wordtrim($b); $conc{$b} = $any{$b} = 1;
	if ($a =~ /\[ac\]/) { $activ{$b} = 1; } # [ac] says it's activated somewhere else
	next;
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