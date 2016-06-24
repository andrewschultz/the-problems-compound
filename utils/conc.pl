use Win32::Clipboard;

$clip = Win32::Clipboard::new();

@dirs = ("Compound", "Slicker-City");

my $codeToClipboard = 0;
my $printErrCode = 0;
my $printErrors = 1;

while ($count <= $#ARGV)
{
  $a = @ARGV[$count];
  for ($a)
  {
    /^-?o$/ && do { $order = 1; $count++; next; };
    /^-?t$/ && do { $printTest = 1; $count++; next; };
    /^-?ps$/ && do { $printSuccess = 1; $count++; next; };
    /^-?pc$/ && do { @dirs = ("Compound"); $count++; next; };
    /^-?sc$/ && do { @dirs = ("Slicker-City"); $count++; next; };
	/^-?as$/ && do { @dirs = ("Slicker-City", "Compound"); $count++; next; };
	/^-?[cve]+$/ && do
	{
	  $codeToClipboard = $printErrCode = $printErrors = 0;
	  if ($a =~ /c/) { $codeToClipboard = 1; }
	  if ($a =~ /e/) { $printErrCode = 1; }
	  if ($a =~ /v/) { $printErrors = 1; }
	  $count++;
	  next;
	};
	/^[a-z][a-z-]+$/i && do
	{
	  print "Note that this assumes the idiom written properly e.g. show business vs business show.";
	  @cranks = split(/,/, @ARGV[0]); foreach $mycon (@cranks) { crankOutCode($mycon); } exit;
	};
	usage();
  }
}

for $thisproj (@dirs) { if ($order) { checkOrder($thisproj); } else { readConcept($thisproj); } }

sub crankOutCode
{
  $temp = $_[0]; $temp =~ s/-/ /g;
  $bkwd = join(" ", reverse(split(/ /, $temp)));
  if ($a)
  {
    $a .= "\n";
  $a .= "\[activation of $temp\]\n$temp is a concept in conceptville. understand \"$bkwd\" as $temp. howto is \"\[fill-in-here\]\". \[search string: cv]\n$temp\t\"$temp is when you \[fill-in-here\].\" \[search string: xadd\]\n";
  $clip->Set($a);
  print "To clipboard:\n$a";
  }
  else
  {
    print "No code to clipboard.\n";
  }
}

#debugging routine to dump the hashes
sub dumpHashes
{
  print "EXPL:\n"; for $x (sort keys %expl) { print "$x\n"; }
  print "ANY:\n"; for $x (sort keys %any) { print "$x\n"; }
  print "CONC:\n"; for $x (sort keys %conc) { print "$x\n"; }
}

#######################################
#prints the results
#
sub printResults
{
my $fails = 0;
my $totals = 0;
my $errMsg = "";

#dumpHashes();
for $x (sort keys %any)
{
  $thisFailed = 0;
  $totals++;
  $xmod = $x; $xmod =~ s/\*//g;
  #print "Looking at $x:\n";
  if (!$expl{$x}) { $errMsg .= "$xmod needs explanation.\n"; $explErr .= "$xmod\t\"$xmod is when you [fill-in-here].\"\n"; $fails++; $thisFailed = 1; }
  if (!$conc{$x})
  {
	$errMsg .= "$xmod needs concept definition.\n";
    if ($x =~ /\*/)
	{
    $y1 = join(" ", reverse(split(/\*/, $x)));
    $y = join(" ", split(/\*/, $x));
	$concErr .= "$xmod is a concept in conceptville. Understand \"$y\" and \"$y1\" as $xmod. howto is \"[fill-in-here]\".\n";
	}
	else
	{
    $y = join(" ", reverse(split(/ /, $x)));
	$concErr .= "$xmod is a concept in conceptville. Understand \"$y\" as $xmod. howto is \"[fill-in-here]\".\n";
	}
	$fails++;
	$thisFailed = 1;
  }
  if (!$activ{$x}) { $errMsg .= "$xmod needs activation.\n"; $activErr .= "\[activation of $xmod\]\n"; $fails++; $thisFailed = 1; }
  if (($thisFailed == 0) && ($printSuccess)) { print "$x succeeded.\n"; }
}

  print "TEST RESULTS:concepts-$_[0],0,$fails,$totals,$errMsg\n";

  if ($fails) { print "Test failed, $fails failures of $totals."; }
  else { print "Test succeeded! All $totals passed."; }

  print "\n";
  my $authErr;
  my $needAlf = 0; my $authfail = 0; my $authsucc = 0;
  my $numauth = scalar keys %auth;
  if ($numauth)
  {


  for $q (sort keys %auth)
  {
    if ($gotText{$q} == 0) { print "$q needs xp-text.\n"; $authfail++; $authErr .= "$q\t\"[fix-this]\"\n"; $errMsg = 1; next; }
	#elsif ($authtab{$q} < $lastLine) { print "$q is out of order in the author explanations, $authtab{$q} vs $lastLine, $auth{$q}.\n"; $authfail++; $needAlf = 1;}
	else { $authsucc++; }
	$lastLine = $authtab{$q};	
  }
  if ($needAlf) { print "talf.pl may help straighten things out.\n"; }

  print "TEST RESULTS:$_[0] authors matching,0,$authfail,$authsucc,0,$numauth\n";
  }

  if ($errMsg)
  {
  if ($printErrors) { print "$errMsg"; if (!$codeToClipboard) { print "Run with -c to put code to clipboard.\n"; } }
  my $bigString = "Basic cut-and-paste (fill-in-here throws an error on purpose so I fix it) :\n";
  if ($activErr) { $bigString .= "ACTIVATIONS:\n$activErr"; }
  if ($explErr) { $bigString .= "EXPLANATIONS:\n$explErr"; }
  if ($concErr) { $bigString .= "CONCEPTS:\n$concErr"; }
  if ($authErr) { $bigString .= "AUTHORS:\n$authErr"; }
  if ($codeToClipboard)
  {
    $clip->Set($bigString);
    print "Errors found. Suggested code sent to clipboard.\n";
  }
  if ($printErrCode)
  {
    print $bigString;
  }
  } else { print "No errors in $_[0]. Nothing sent to clipboard.\n"; }

  if (!$errMsg) { $errMsg = "All okay!"; } else { $errMsg =~ s/\n/<br>/g; $errMsg =~ s/<br>$//g; }

}

sub checkOrder
{
  my @ex;
  my @co;
  my $expls;
  my $concs;
  my $ordFail = 0;
  
  my $source = "c:/games/inform/$_[0].inform/source/story.ni";

  open(A, "$source") || die ("Can't open $source.");

  my $line = 0;
  my $writeGameObjErrRes = 0;
  my $objAlf = 0;
  $objSuc = 0;

  while ($a = <A>)
  {
    $line++;
	if ($a =~ /alfbyroom/) { <A>; $line++; $objAlf = checkGameObjExpl($line); $writeGameObjErrRes = 1; next; }
    if (($a =~ /is a.* author\. pop/) && ($a !~ /^\[/)) { $b = $a; $b =~ s/ is (a|an) .*//g; chomp($b); $auth{$b} = $line; next; }
	if (($expls) && ($a !~ /[a-z]/i)) { $expls = 0; next; }
	if (($concs) && ($a =~ /end concepts/)) { $concs = 0; next; }
    if ($a =~ /xx(add|auth|slb|bks|bkj)/) { $line++; <A>; $expls = 1; next; }
    if ($a =~ /\[xxcv\]/) { $line++; <A>; $concs = 1; next; }
	if ($expls) { chomp($a); $a =~ s/\t.*//g; $a = cutArt($a); push (@ex, $a); next; }
	if (($concs) && ($a =~ /concept.in/)) { chomp($a); $a =~ s/ is a .*concept.*//g; $a = cutArt($a); push (@co, $a); next; }
  }

  for (0..$#ex)
  {
    #print lc(@ex[$_]) . " =? " . lc(@co[$_]) . "\n";
    if (lc(@ex[$_]) ne lc(@co[$_]))
	{
	  $ordFail++;
	  if ((!$detail) && ($match - $lastMatch == 1)) { next; }
      print "$_ ($ordFail): @ex[$_] vs @co[$_]";
	  for $match (0..$#co)
	  {
	    if (lc(@ex[$_]) eq lc(@co[$match]))
	    {
		  print " (#$match)";
		  if ($match - $lastMatch == 1) { print " (in order)"; $inOrder++; }
		  $lastMatch = $match;
		}
	  }
	  if ($lw ne "") { print " (last working=@ex[$lw])"; }
	  print "\n";
	} else { $lw = $_; }
  }

  if ($ordFail)
  {
    print "$ordFail failed";
	if ($inOrder)
	{
	  $remain = $ordFail - $inOrder;
	  print ", but $inOrder are nice and consecutive. That means there might really be $remain or fewer changes to make";
	}
	print ".\n      EXPLANATIONS vs CONCEPTS above\n";
  }
  else
  {
    print "Ordering (" . ($#ex+1) . ") all matched for $_[0].\n";
  }
  if ($printTest) { print "TEST RESULTS:$_[0] ordering,0,$ordFail,0,run conc.pl -o\n"; }

  if ($writeGameObjErrRes)
  {
    print "TEST RESULTS:$_[0] explanation alphabetizing,0,$objAlf,$objSuc\n";
  }
  if (scalar keys %auth == 0) { return; }
  $gots = scalar keys %gotText;

  my $authOops = 0;
  foreach $q (sort {$auth{$a} <=> $auth{$b}} keys %auth)
  {
    if ($q le $lastAuth) { print "$lastAuth/$q is not correctly alphabetized in the defines. Look at line $auth{$q}. $lastAuth is at $auth{$lastAuth}.\n"; push(@authErr, "$q/$auth{$q}"); $authFail++; }
	if ($gots) { if ($q !~ / xp-text is /) { print "$q needs xp-text.\n"; push(@authErr, "$q/$auth{$q}"); } }
	$lastAuth = $q;
	$authAlf++;
  }
  
  $lastAuthLine="";
  if (scalar(keys %auth))
  {
    my $authFail = 0;
    if (($#authErr == -1) && ($authOops == 0)) { push(@authErr, "ALL OKAY"); } else { $authFail = $#authErr + 1 + $authOops; }
    print "TEST RESULTS:$_[0] author order checks,0,$authFail,$authAlf," . join("<br />", @authErr) . "\n";
	if ($authFail) { print "talf.pl may fix things.\n"; }
  }
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
  if (($a =~ /is a.* author\. pop/) && ($a !~ /^\[/)) { $b = $a; $b =~ s/ is (an|a) .*//g; chomp($b); if ($a =~ /xp-text is /) { $gotText{$b} = 1; } elsif ($a =~ /\"/) { print "Probable typo for $b.\n"; } $auth{$b} = $line; next; }
  if ($inBookTable)
  {
    if ($a !~ /[a-z]/i) { $inBookTable = 0; next; }
    $b = $a; chomp($b); $b = wordtrim($b); $b =~ s/\t.*//g; $activ{$b} = 1; $any{$b} = 1; next;
  }
  if ($inAuthTable)
  {
    if ($a !~ /[a-z]/i) { $inAuthTable = 0; next; }
    $b = $a; chomp($b); $b =~ s/\t.*//g; $authtab{$b} = $line; next;
  }
  if ($a =~ /xxauth/) { $inAuthTable = 1; <A>; $line++; next; }
  if ($a =~ /section misc concept\(s\)/) { $concepts = $line; }
  if ($a =~ /^table of (book jungle|life shelf)/) { $xadd = $line; $inBookTable = 1; <A>; next; }
  if ($a =~ /^table of explanations.*concepts/) { $xadd = $line; $inTable = 1; <A>; next; }
  if ($a !~ /[a-z]/i) { $inTable = 0; next; }
  chomp($a); $a = cutArt($a);
  if ($a =~ /is a concept in lalaland/)
  {
    $a =~ s/ is a concept in lalaland.*//g;
	$a = wordtrim($a);
	$conc{$a} = 1;
	$activ{$a} = 1;
	$any{$a} = 1;
  }
  $b = $a;
  while ($b =~ /\[activation of/)
  {
    $b =~ s/.*?\[activation of //; $c = $b;
	$c =~ s/\].*//g;
	$activ{wordtrim($c)} = 1; $any{wordtrim($c)} = 1;
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

#################################
#cutArt cuts the leading article off
#
sub cutArt
{
  my $die = 0;
  my $temp = $_[0];
  if ($temp =~ /^a (thing\t|for )/) { return $_[0]; } #A for effort is a special case
  $temp =~ s/^(a thing called |a |the )//gi;
  return $temp;
}

sub checkGameObjExpl
{
  my $compare = "";
  my $locCount = 0;
  my $c1;
  my $c2;
  my $initLines = $lines;
  my $gameObjErr = 0;

  while ($a = <A>)
  {
    $lines++;
	if ($a !~ /[a-z]/i) { last; }
    if ($a =~ /\[start/)
	{
	  $curLoc = $a; chomp($curLoc); $curLoc =~ s/.*\[start (of )?//g; $curLoc =~ s/\].*//g;
	  $locCount = 0;
	  $compare = $a; next;
	}
	if (!$compare) { next; }
	$c1 = alfPrep($a);
	$c2 = alfPrep($compare);
	if ($c2 gt $c1)
	{
	  chomp($c1);
	  chomp($c2);
	  $gameObjErr++;
	  $locCount++;
	  print "$linesToRet($gameObjErr): $c2 should be after $c1 ($curLoc, $locCount).\n";
	}
	$compare = $a;
  }
  $objSuc = $lines - $initLines - $gameObjErr;
  return $gameObjErr;
}

sub alfPrep
{
  my $temp = lc($_[0]);
  $temp =~ s/\t.*//g;
  if ($temp eq "a thing") { return $temp; }
  $temp =~ s/^(a |the )//i;
  return $temp;
}

sub usage
{
print<<EOT;
-c = error code to clipboard
-e = print errors not error code
-v = verbosely print code
(any combination is okay too)
-t = print with test results so nightly build can process it
(-)ps = print success
(-)pc = PC only
(-)sc = SC only
(-)as = PC and SC (default)
(-)o = check order
CURRENT TESTS: conc.pl -pc, conc.pl -t -o -spc, conc.pl -sc, conc.pl -t -o -sc
EOT
exit;
}
