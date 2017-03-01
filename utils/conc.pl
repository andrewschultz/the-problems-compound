#############################################
#conc.pl
#
#concept dredger for Alec Smart games
#
#usually I've just created [activation of] or written a new BTP book
#
#usage -o tracks order of concepts/tables
#      -c to clipboard
#      -pc/sc/btp runs (-a all)
#
#      -nt/-t toggles test result printing
#called from talf

use strict;
use warnings;

use Win32::Clipboard;

my $clip = Win32::Clipboard::new();

my @dirs = ("Compound", "Slicker-City", "Buck-the-Past");

my @okays = ("buster ball", "hunter savage", "trust brain", "good herb", "freak out" );

###############################
#options
my $codeToClipboard = 0;
my $printErrCode = 0;
my $printErrors = 1;
my $printTest = 0;
my $order = 0;
my $readConcepts = 1;
my $printSuccess = 0;
my $addStart = 0;
my $cvStart = 0;

#############################
#hashes
my %any;
my %expl;
my %auth;
my %conc;
my %activ;
my %gotText;
my %authTab;
my %okdup;
my %lineNum;

#################################
#arrays
my @dumbErrors = ();

######################counters
my $objSuc = 0;
my $count = 0;
my $authFail = 0;
my $asterisks = 0;
my $astString = "";

while ($count <= $#ARGV)
{
  $a = $ARGV[$count];
  for ($a)
  {
    /^-?[or]+$/ && do {
	  $order = ($a =~ /o/);
	  $readConcepts = ($a =~ /r/);
	  $count++;
	  next;
	  };
    /^-?nt$/ && do { $printTest = 0; $count++; next; };
    /^-?t$/ && do { $printTest = 1; $count++; next; };
    /^-?ps$/ && do { $printSuccess = 1; $count++; next; };
    /^-?pc$/ && do { @dirs = ("Compound"); $count++; next; };
    /^-?sc$/ && do { @dirs = ("Slicker-City"); $count++; next; };
    /^-?(bp|btp)$/ && do { @dirs = ("Buck-the-Past"); $count++; next; };
	/^-?as$/ && do { @dirs = ("Slicker-City", "Compound"); $count++; next; };
	/^-?a3$/ && do { @dirs = ("Slicker-City", "Compound", "Buck-the-Past"); $count++; next; };
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
	  my @cranks = split(/,/, $ARGV[0]); foreach my $mycon (@cranks) { crankOutCode($mycon); } exit;
	};
	usage();
  }
}

for (@okays) { $okdup{$_} = 1; }

for my $thisproj (@dirs)
{
  if ($order) { checkOrder($thisproj); }
  if ($readConcepts) { readConcept($thisproj); }
}

sub crankOutCode
{
  my $temp = $_[0]; $temp =~ s/-/ /g;
  my $bkwd = join(" ", reverse(split(/ /, lc($temp))));
  if ($a)
  {
    $a .= "\n";
  $a .= "\[activation of +$temp\]\n$temp is a concept in conceptville. understand \"$bkwd\" as $temp. howto is \"\[fill-in-here\]\". \[search string: cv]\n$temp\t\"$temp is when you \[fill-in-here\].\" \[search string: xadd\]\n";
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
  print "EXPL:\n"; for my $x (sort keys %expl) { print "$x\n"; }
  print "ANY:\n"; for my $x (sort keys %any) { print "$x\n"; }
  print "CONC:\n"; for my $x (sort keys %conc) { print "$x\n"; }
}

#######################################
#prints the results
#
sub printResults
{
my $fails = 0;
my $totals = 0;
my $errMsg = "";
my $activErr;
my $explErr;
my $concErr;
my $authErr;
my $y;
my $y1;
my $lastLine = 0;

#dumpHashes();
my %gotyet;
for my $x (sort keys %any)
{
  my $thisFailed = 0;
  $totals++;
  if ($x =~ /\*/) { print "Warning remove asterisk at line $activ{$x}.\n"; }
  my $xmod = $x; $xmod =~ s/\*//g;
  if ($gotyet{$xmod}) { print "Oops, $xmod looks like an almost-duplicate with asterisks there/missing.\n"; }
  $gotyet{$xmod} = 1;
  #print "Looking at $x:\n";
  if (!$expl{$xmod})
  {
    $errMsg .= "$xmod ($lineNum{$xmod}) needs explanation.\n";
	$explErr .= "$xmod\t\"$xmod is when you [fill-in-here].\"\n";
	$fails++; $thisFailed = 1;
  }
  if (!$conc{$xmod})
  {
	$errMsg .= "$xmod ($lineNum{$xmod}) needs concept definition.\n";
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
	$fails++; $thisFailed = 1;
  }
  if (!$activ{$x})
  {
    $errMsg .= "$xmod ($lineNum{$xmod}) needs activation.\n";
	$activErr .= "\[activation of $xmod\]\n";
	$fails++; $thisFailed = 1;
  }
  if (($thisFailed == 0) && ($printSuccess)) { print "$x succeeded.\n"; }
  if (($thisFailed) && ($x !~ /[ \*]/))
  {
    print "You may want a space or asterisk in $x (line $any{$x}) to see where it can be divided. Asterisk disappears with the object name.\n";
  }
}

  if ($asterisks) { print "TEST RESULTS: asterisks-$_[0],0,$asterisks,0,$astString"; }
  print "TEST RESULTS:concepts-$_[0],0,$fails,$totals,$errMsg\n";

  if ($fails)
  {
    print "XXADD starts at $addStart.\n";
    print "XXCV starts at $cvStart.\n";
	print "Test failed, $fails failures of $totals.";
  }
  else { print "Test succeeded! All $totals passed."; }

  print "\n";
  my $needAlf = 0; my $authFail = 0; my $authsucc = 0;
  my $numauth = scalar keys %auth;
  if ($numauth)
  {

  for my $q (sort keys %auth)
  {
    if ($gotText{$q} == 0) { print "$q needs xp-text.\n"; $authFail++; $authErr .= "$q\t\"[fix-this]\"\n"; $errMsg = 1; next; }
	#elsif ($authtab{$q} < $lastLine) { print "$q is out of order in the author explanations, $authtab{$q} vs $lastLine, $auth{$q}.\n"; $authFail++; $needAlf = 1;}
	else { $authsucc++; }
	$lastLine = $authTab{$q};
  }
  if ($needAlf) { print "talf.pl may help straighten things out.\n"; }

  print "TEST RESULTS:$_[0] authors matching,0,$authFail,$authsucc,0,$numauth\n";
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
  } else { print "No errors in this run for $_[0]. Nothing sent to clipboard.\n"; }

  if (!$errMsg) { $errMsg = "All okay!"; } else { $errMsg =~ s/\n/<br>/g; $errMsg =~ s/<br>$//g; }

  $errMsg = "";

  if ($#dumbErrors > -1)
  {
    print "#####################Remove error-text from line(s) " . join(", ", @dumbErrors) . ".\n";
  }

}

sub checkOrder
{
  my @ex;
  my @co;
  my $expls;
  my $concs;
  my $ordFail = 0;
  my $lastConcept = "";

  my $source = "c:/games/inform/$_[0].inform/source/story.ni";

  open(A, "$source") || die ("Can't open $source.");

  my $line = 0;
  my $writeGameObjErrRes = 0;
  my $objAlf = 0;
  my $lastComp = 0;
  $objSuc = 0;
  my $origLine;
  my $lw = "";
  my @authErrs;
  my $lastMatch = 0;
  my $match = 0;
  my $conceptOrdErr = 0;

  while ($a = <A>)
  {
    $origLine = $a;
    $line++;
	if ($a =~ /alfbyroom/) { <A>; $line++; $objAlf = checkGameObjExpl($line); $writeGameObjErrRes = 1; $line = $.; print next; }
    if (($a =~ /is a.* author\. pop/) && ($a !~ /^\[/)) { $b = $a; $b =~ s/ is (a|an) .*//g; chomp($b); $auth{$b} = $line; next; }
	if (($expls) && ($a !~ /[a-z]/i)) { $expls = 0; next; }
	if (($concs) && ($a =~ /end concepts/)) { $concs = 0; next; }
    if ($a =~ /xx(add|auth|slb|bks|bkj)/) { $line++; <A>; $expls = 1; next; }
    if ($a =~ /\[xxcv\]/) { $line++; <A>; $concs = 1; next; }
	if ($expls)
	{
	  chomp($a);
	  $a =~ s/\t.*//g;
	  $a = cutArt($a);
	  push (@ex, $a);
	  if (!$lineNum{$a}) { $lineNum{$a} = $.; }
	  if ($origLine =~ /\[start/)
	  {
	    $lastComp = "";
      }
	  else
	  {
        if (lc($a) le lc($lastComp)) { print "($line) Order flip $a vs $lastComp\n"; $ordFail++; }
	    $lastComp = $a;
      }
	  next;
	}
	if ($concs)
	{
	  if ($a =~ /^(chapter|section|book|part|volume)/i) { $lastConcept = ""; }
	  if ($a =~ /concept.in/)
	  {
	    chomp($a);
		$a =~ s/ is a .*concept.*//g;
		$a = cutArt($a);
		push (@co, $a);
	    if (lc($a) le $lastConcept)
		{
		  if (!$conceptOrdErr)
		  { print "================concept order errors\n"; }
		  $conceptOrdErr++;
		  print "$a out of order at line $., comes after $lastConcept.\n";
        }
		$lastConcept = lc($a);
	    next;
	  }
	}
  }
  if ($ordFail) { print "  EXPLANATIONS table order mistakes above ($ordFail)\n"; }

  $ordFail = 0;
  my $inOrder = 0;
  for (0..$#ex)
  {
    #print lc(@ex[$_]) . " =? " . lc(@co[$_]) . "\n";
    if (lc($ex[$_]) ne lc($co[$_]))
	{
	  $ordFail++;
	  if ($match - $lastMatch == 1) { next; }
      printf("$_ ($ordFail): $ex[$_] %s vs $co[$_] %s", $lineNum{$ex[$_]} ? "($lineNum{$ex[$_]})" : "", $lineNum{$co[$_]} ? "($lineNum{$co[$_]})" : "");
	  for my $match (0..$#co)
	  {
	    if (lc($ex[$_]) eq lc($co[$match]))
	    {
		  print " (#$match)";
		  if ($match - $lastMatch == 1) { print " (in order)"; $inOrder++; }
		  $lastMatch = $match;
		}
	  }
	  if ($lw ne "") { print " (last working=$ex[$lw])"; }
	  print "\n";
	} else { $lw = $_; }
  }

  if ($ordFail)
  {
    print "$ordFail failed";
	if ($conceptOrdErr) { print ", but maybe fix the concept definitions first"; }
	if ($inOrder)
	{
	  my $remain = $ordFail - $inOrder;
	  print ", but $inOrder are nice and consecutive. That means there might really be $remain or fewer changes to make";
	}
	print ".\n      EXPLANATIONS vs CONCEPTS above\n";
  }
  else
  {
    print "Ordering (" . ($#ex+1) . ") all matched for $_[0].\n";
  }
  if ($printTest) { print "TEST RESULTS:$_[0] ordering,$ordFail,0,0,run conc.pl -o\n"; }
  if ($printTest) { print "TEST RESULTS:$_[0] concept order errors,$conceptOrdErr,0,0,\n"; }

  if ($writeGameObjErrRes)
  {
    print "TEST RESULTS:$_[0] explanation alphabetizing,0,$objAlf,$objSuc\n";
  }
  if (scalar keys %auth == 0) { return; }
  my $gots = scalar keys %gotText;

  my $authOops = 0;
  my $authAlf = 0;
  my $lastAuth = "";

  foreach my $q (sort {$auth{$a} <=> $auth{$b}} keys %auth)
  {
    if ($q le $lastAuth) { print "$lastAuth/$q is not correctly alphabetized in the defines. Look at line $auth{$q}. $lastAuth is at $auth{$lastAuth}.\n"; push(@authErrs, "$q/$auth{$q}"); $authFail++; }
	if ($gots) { if ($q !~ / xp-text is /) { print "$q needs xp-text.\n"; push(@authErrs, "$q/$auth{$q}"); } }
	$lastAuth = $q;
	$authAlf++;
  }


  if (scalar(keys %auth))
  {
    $authFail = 0;
    if (($#authErrs == -1) && ($authOops == 0)) { push(@authErrs, "ALL OKAY"); } else { $authFail = $#authErrs + 1 + $authOops; }
    print "TEST RESULTS:$_[0] author order checks,0,$authFail,$authAlf," . join("<br />", @authErrs) . "\n";
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
%activ = ();
$asterisks = 0;
$astString = "";

my $inTable = 0;

my $source = "c:/games/inform/$_[0].inform/source/story.ni";
open(A, $source) || do { print "No source file $source.\n"; return; };

my $line = 0;

my $inAuthTable = 0;

my $lineIn;
my $tmpVar;

@dumbErrors = ();

while ($lineIn = <A>)
{
  if ($lineIn =~ /(EXPLANATIONS:|CONCEPTS:|fill-in-here throws)/) { push (@dumbErrors, $.); next; }
  if (($lineIn =~ /is a.* author\. pop/) && ($lineIn !~ /^\[/)) { $tmpVar = $lineIn; $tmpVar =~ s/ is (an|a) .*//g; chomp($tmpVar); if ($lineIn =~ /xp-text is /) { $gotText{$tmpVar} = 1; } elsif ($lineIn =~ /\"/) { print "Probable typo for $tmpVar.\n"; } $auth{$tmpVar} = $line; next; }
  if ($inAuthTable)
  {
    if ($lineIn !~ /[a-z]/i) { $inAuthTable = 0; next; }
    $tmpVar = $lineIn; chomp($tmpVar); $tmpVar =~ s/\t.*//g; $authTab{$tmpVar} = $line; next;
  }
  if ($lineIn =~ /xxadd/) { $addStart = $.; }
  if ($lineIn =~ /xxcv/) { $cvStart = $.; }
  if ($lineIn =~ /xxauth/) { $inAuthTable = 1; <A>; $line++; next; }
  if ($lineIn =~ /^table of explanations.*concepts/) { $inTable = 1; <A>; next; }
  if ($lineIn !~ /[a-z]/i) { $inTable = 0; next; }
  chomp($lineIn); $lineIn = cutArt($lineIn);
  if ($lineIn =~ /is a concept in lalaland/) # concept definitions
  {
    $lineIn =~ s/ is a concept in lalaland.*//g;
	$lineIn = wordtrim($lineIn);
	$conc{$lineIn} = 1;
	$any{$lineIn} = 1;
	if (!defined($lineNum{$lineIn})) { $lineNum{$lineIn} = $.; }
	# the concept is activated by default, so we need to add this line.
	$activ{$lineIn} = $.;
  }
  $tmpVar = $lineIn;
  while ($tmpVar =~ /\[activation of/) # "activation of" in source code
  {
    $tmpVar =~ s/.*?\[activation of //;
	if ($tmpVar =~ /\*/) { my $tmpVar2 = $tmpVar; $tmpVar2 =~ s/\].*//; $asterisks++; $astString .= "$tmpVar2($.)\n"; }
	my $c = $tmpVar;
	$c =~ s/\].*//g;
	if ($c eq "conc-name entry") { next; }
	$c = wordtrim($c);
	if (defined($activ{$c}) && !defined($okdup{$c})) { print "Warning line $. double defines $c from $lineNum{$c}.\n"; }
	$activ{$c} = $.;
	$any{wordtrim($c)} = $.;
	$lineNum{$c} = $.;
  }
  if ($inTable)
  {
    $tmpVar = $lineIn;
	$tmpVar =~ s/\t.*//g;
	$tmpVar = wordtrim($tmpVar);
	$expl{$tmpVar} = $any{$tmpVar} = 1;
	if (!defined($lineNum{$tmpVar})) { $lineNum{$tmpVar} = $.; }
	next;
  }
  if ($lineIn =~ /^a thing called /) { $lineIn =~ s/^a thing called //i; }
  if (($lineIn =~ /is a (privately-named |risque |)?concept/) && ($lineIn !~ /\t/)) #prevents  "is a concept" in source text from false flag
  {
    $tmpVar = $lineIn; $tmpVar =~ s/ is a (privately-named |risque |)?concept.*//g; $tmpVar = wordtrim($tmpVar); $conc{$tmpVar} = $any{$tmpVar} = $.;
	if (!defined($lineNum{$tmpVar})) { $lineNum{$tmpVar} = $.; }
	if ($lineIn =~ /\[ac\]/) { $activ{$tmpVar} = $.; } # [ac] says it's activated somewhere else
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
  $temp =~ s/\*//g;
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
  my $initLines = $.;
  my $gameObjErr = 0;
  my $line;
  my $curLoc;

  while ($line = <A>)
  {
	if ($line !~ /[a-z]/i) { last; }
    if ($line =~ /\[start/)
	{
	  $curLoc = $line; chomp($curLoc); $curLoc =~ s/.*\[start (of )?//g; $curLoc =~ s/\].*//g;
	  $locCount = 0;
	  $compare = $line; next;
	}
	if (!$compare) { next; }
	chomp($line);
	chomp($compare);
	$c1 = alfPrep($line);
	$c2 = alfPrep($compare);
	if ($c2 gt $c1)
	{
	  print "$c1 vs $c2, $line vs $compare\n";
	  chomp($c1);
	  chomp($c2);
	  $gameObjErr++;
	  $locCount++;
	  print "$.($gameObjErr): $c2 should be after $c1 ($curLoc, $locCount).\n";
	}
	$compare = $line;
  }
  $objSuc = $. - $initLines - $gameObjErr;
  return $gameObjErr;
}

sub alfPrep
{
  my $temp = lc($_[0]);
  chomp($temp);
  $temp =~ s/\t.*//g;
  if ($temp eq "a thing") { return $temp; }
  $temp =~ s/^(a |the )//i;
  return $temp;
}

sub usage
{
print<<EOT;
CONC.PL usage
===================================
-c = error code to clipboard
-e = print errors not error code
-v = verbosely print code
(any combination is okay too)
-t = print with test results so nightly build can process it
(-)ps = print success
(-)pc = PC only
(-)sc = SC only
(-)btp = BTP only
(-)as = PC and SC and BTP (default)
(-)o = check order
CURRENT TESTS: conc.pl -pc, conc.pl -t -o -as, conc.pl -sc, conc.pl -t -o -sc
EOT
exit;
}
