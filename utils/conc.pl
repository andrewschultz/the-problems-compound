#############################################
#conc.pl
#
#concept dredger for Alec Smart games
#
#usage -o tracks order of concepts/tables
#      -c to clipboard
#      -pc/sc/btp runs (-a all)
#
#      -nt/-t toggles test result printing
#called from talf
#
#todo: if word isn't split up, try to
#todo: define a default outside of "my @dirs" below in conc-aux.txt
#todo: also have spare file organize things better to ditch hard coded arrays

use strict;
use warnings;

use Win32::Clipboard;

my $clip = Win32::Clipboard::new();

my @dirs = ("Buck-the-Past");

##############could move this to a spare file but there are few enough for now

my $np = "\"C:\\Program Files (x86)\\Notepad++\\notepad++.exe\"";

my $i7 = "C:\\Program Files (x86)\\Inform 7\\Inform7\\Extensions\\Andrew Schultz";
my $dupeFile = __FILE__; $dupeFile =~ s/.pl$/-dupe.txt/;
my $auxFile = __FILE__; $auxFile =~ s/.pl$/-aux.txt/;

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
my $addEnd = 0;
my $cvEnd = 0;
my $detailAlpha = 1;
my $openStoryFile = 0;
my $printAllDiff = 0;
my $defaultToGeneral = 1;
my $defaultRoom = "general concepts";
my $readDupe = 1;
my $openLowestLine = 0;
my $roomConcCompare = 0;
my $rcVerbose = 0;
my $verboseCutPaste = 0;
my $launchMinorErrs = 0;
my $roomToFile = 0;
my $launchRoomFile = 0;
my $outputRoomFile = 0;

#############################
#hashes
my %any;
my %expl;
my %auth;
my %conc;
my %activ;
my %gotText;
my %authTab;
my %okDup;
my %lineNum;
my %fileLineErr;
my %fillConc;
my %fillExpl;
my %needSpace;
my %minorErrs;

my %tableDetHash;

my %fileHash;

my %roomIndex;
my %conceptIndex;
my %concToRoom;
my %concTableLine;

$tableDetHash{"Compound"} = "xxjmt,xxbgw";
$tableDetHash{"Buck-the-Past"} = "!xxtia";

my $source = __FILE__;

#################################
#arrays
my @dumbErrors = ();
my @fillIn = ();

my $fileToOpen = "";

######################counters
my $objSuc = 0;
my $count = 0;
my $authFail = 0;
my $asterisks = 0;
my $astString = "";
my $nuline = 0;
my $warnedYet = 0;
my $gameObjTot = 0;
my $needsAlf = 0;

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
    /^-?a$/ && do { $printAllDiff = 1; $count++; next; };
    /^-?e$/ && do
	{
	  my $cmd = "start \"\" $np $source";
	  `$cmd`;
	  exit();
    };
    /^-?nt$/ && do { $printTest = 0; $count++; next; };
    /^-?t$/ && do { $printTest = 1; $count++; next; };
    /^-?d$/ && do { $defaultRoom = $ARGV[$count+1]; $defaultRoom =~ s/[-\._]/ /g; $count+= 2; next; };
    /^-?ps$/ && do { $printSuccess = 1; $count++; next; };
    /^-?nd$/ && do { $readDupe = 0; $count++; next; };
    /^--$/ && do { $openLowestLine = 0; $count++; next; };
	/^-?f([lo]*)?$/ && do { $roomToFile = 1; $launchRoomFile = ($a =~ /l/); $outputRoomFile = ($a =~ /o/); $count++; next; };
    /^-?ed$/ && do { `$dupeFile`; exit(); };
    /^-?ng$/ && do { $defaultToGeneral = 0; $count++; next; };
    /^-?dg$/ && do { $defaultToGeneral = 1; $count++; next; };
    /^-?rc(v)?$/ && do { $roomConcCompare = 1; $rcVerbose = ($a =~ /v/); $count++; next; };
    /^-?pc$/ && do { @dirs = ("Compound"); $count++; next; };
    /^-?sc$/ && do { @dirs = ("Slicker-City"); $count++; next; };
    /^-?(bp|btp)$/ && do { @dirs = ("Buck-the-Past"); $count++; next; };
    /^-?vcp$/ && do { $verboseCutPaste = 1; $count++; next; };
    /^-?bs$/ && do { @dirs = ("btp-st"); $count++; next; };
    /^-?b2$/ && do { @dirs = ("Buck-the-Past", "btp-st"); $count++; next; };
	/^-?a2$/ && do { @dirs = ("Slicker-City", "Compound"); $count++; next; };
	/^-?a3$/ && do { @dirs = ("Slicker-City", "Compound", "Buck-the-Past"); $count++; next; };
	/^-?a4$/ && do { @dirs = ("Compound", "Slicker-City", "Buck-the-Past", "btp-st"); $count++; next; };
	/^-?as$/ && do { @dirs = ("Slicker-City", "Compound", "Buck-the-Past", "seeker-status"); $count++; next; };
	/^-?[cv0nlm]+$/ && do
	{
	  $codeToClipboard = $printErrCode = $printErrors = 0;
	  if ($a =~ /c/) { $codeToClipboard = 1; }
	  if ($a =~ /0/) { $printErrCode = 1; }
	  if ($a =~ /v/) { $printErrors = 1; }
	  if ($a =~ /n/) { $openStoryFile = 0; }
	  if ($a =~ /l/) { $openStoryFile = 1; }
	  if ($a =~ /m/) { $launchMinorErrs = 1; }
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

readAux();

if ($readDupe) { readOkayDupes(); }

for my $thisProj (@dirs)
{
  #die "$order $readConcepts $detailAlpha $roomConcCompare\n";
  getRoomIndices($thisProj);
  if ($roomToFile) { roomToFile($thisProj); }
  if ($order) { checkOrder($thisProj); }
  if ($readConcepts) { readConcept($thisProj); }
  if ($detailAlpha) { checkTableDetail($thisProj); }
  if ($roomConcCompare) { compareRoomIndex($thisProj); }
}

printGlobalResults();

##############################################subroutines

sub checkTableDetail
{
  if (!defined($tableDetHash{$_[0]})) { return; }

  my $a2;
  my $a3;
  my $lastAlf = "";
  my $inTable = 0;

  if (!defined($fileHash{$_[0]}))
  {
    print "Need to define a file array for project $_[0].\n";
	return;
  }

  my @toRead = @{$fileHash{$_[0]}};
  my $lastFirstTab = "";
  my $thisFirstTab = "";
  my $needActive = 0;
  my %needActHash;
  my @stuff = split(/,/, $tableDetHash{$_[0]});

  for (@stuff) { if ($_ =~ /^!/) { $_ = ~ s/^!//; $needActHash{$_} = 0; } else { $needActHash{$_} = 1; } }

  for my $file (@toRead)
  {
  open(A, "$file") || die ("No $file.");

  OUTER:
  while ($a = <A>)
  {
  if ($a =~ /^table/)
  {
    for (@stuff) { if ($a =~ /$_/) { $inTable = $_; <A>; $lastAlf = ""; $needActive = ($needActHash{$_} == 1); next OUTER; } }
  }
  if ($a !~ /[a-z]/i) { $inTable = ""; $lastFirstTab = ""; next; }
  if ($inTable)
  {
    if ($a =~ /\[na\]/) { next; }
    chomp($a);
    if ($a =~ /\t/)
	{
	  $thisFirstTab = $a; $thisFirstTab =~ s/\t.*//;
	  if ($thisFirstTab lt $lastFirstTab) { print "BAD ORDER: $.: $thisFirstTab vs $lastFirstTab\n"; }
	  elsif (lc($thisFirstTab) eq lc($lastFirstTab)) { print "EQUAL: $.: $thisFirstTab vs $lastFirstTab\n"; }
      $lastFirstTab = $thisFirstTab;
    }
	if ($needActive)
	{
    if (($a !~ /activation of/) && ($needActive)) { print "Warning: line $. has no ACTIVATION OF.\n"; next; }
	$a3 = "zzzzzz";
	$a = lc($a);
	while ($a =~ /activation of /)
	{
    $a =~ s/.*?activation of //; $a2 = $a; $a2 =~ s/\].*//;
	if ($a3 ge $a2) { $a3 = $a2; }
	}
    if (lc($a3) le lc($lastAlf))
	{
	  $needsAlf = 1;
	  print "$a3 ($. $inTable) may be out of order vs $lastAlf.\n";
	  unless($openLowestLine && defined($minorErrs{$file}) && ($minorErrs{$file} < $.))
	  { $minorErrs{$file} = $.; }
    }
	}
	$lastAlf = $a3;
  }
  }
  close(A);
  }
  if ($needsAlf) { print "To alphabetize automatically, (talf.pl pc/sc/bt?).\n"; }
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
  if (!$expl{$xmod})
  {
    ($fileToOpen, $nuline) = findExplLine($x, $_[0], 1);
	if (($nuline ne "????") && ($nuline !~ /failed/))
	{
	  if (!defined($fileLineErr{$fileToOpen}) || (!$openLowestLine && ($fileLineErr{$fileToOpen} < $nuline)))
	  { $fileLineErr{$fileToOpen} = $nuline; }
	}
    $errMsg .= "$xmod ($lineNum{$x}) needs explanation" . (defined($fillExpl{$x}) ? " filled in" : "") . ": guess = line $nuline\n";
	$explErr .= "$xmod\t\"$xmod is when you [fill-in-here].\"";
	if (!defined($concTableLine{$concToRoom{$xmod}})) { $explErr .= " \[start of $concToRoom{$xmod}\]"; }
	$explErr .= "\n";
	$fails++; $thisFailed = 1;
  }
  if (!$conc{$xmod})
  {
    ($fileToOpen, $nuline) = findExplLine($x, $_[0], 2);
	if (($nuline ne "????") && ($nuline !~ /failed/))
	{
	  if (!defined($fileLineErr{$fileToOpen}) || (!$openLowestLine && ($fileLineErr{$fileToOpen} < $nuline)))
	  { $fileLineErr{$fileToOpen} = $nuline; } }
	$errMsg .= "$xmod ($lineNum{$x}) needs concept definition" . (defined($fillConc{$x}) ? " filled in" : "") . ": guess = line $nuline\n";
	if (defined($concToRoom{$xmod}))
	{
	if (!defined($conceptIndex{$concToRoom{$xmod}}) && ($concToRoom{$xmod} ne "general concepts")) # bad code but I can't figure a way to sort out general/concepts
	{
	$concErr .= "section $concToRoom{$xmod} concepts\n\n";
	}
	}
    if ($x =~ /\*/)
	{
    $y1 = join(" ", reverse(split(/\*/, $x)));
    $y = join(" ", split(/\*/, $x));
	$concErr .= "$xmod is a concept in conceptville. Understand \"$y\" and \"$y1\" as $xmod. howto is \"[fill-in-here]\".\n\n";
	}
	else
	{
    $y = join(" ", reverse(split(/ /, $x)));
	$concErr .= "$xmod is a concept in conceptville. Understand \"$y\" as $xmod. howto is \"[fill-in-here]\".\n\n";
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

  if ($printTest)
  {
    print "TEST RESULTS:asterisks-$_[0],0,$asterisks,0,$astString";
	print "TEST RESULTS:concepts-$_[0],0,$fails,$totals,$errMsg\n";
  }
  else
  {
    print "Asterisks: $astString\nErrors:$errMsg\n";
  }

  if ($fails)
  {
    print "XXADD starts at $addStart, ends at $addEnd.\n";
    print "XXCV starts at $cvStart, ends at $cvEnd.\n";
	printf("Test failed, $fails failure%s of $totals.", $fails==1 ? "" : "s");
  }
  else { print "Main concept-sorting test succeeded! All $totals passed."; }

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

  if (scalar keys %needSpace)
  {
    printf("Add spaces or \[ok\] (%d total) to understanding synonyms at %s%s\n", scalar keys %needSpace, join(", ", map { "$needSpace{$_}($_}" } sort { $needSpace{$a} <=> $needSpace{$b} } keys %needSpace), $launchMinorErrs ? "" : " (-lm to launch)");
	if ($printTest) { printf("TEST RESULTS: needspace-$_[0],%d,0,0,%s\n", scalar keys %needSpace, join(" / ", map { "$needSpace{$_}" } sort keys %needSpace)); }
  }
  if (scalar keys %fillExpl)
  {
    printf("Fill in explanation text (%d total) at %s%s\n", scalar keys %fillExpl, join(", ", map { "$fillExpl{$_}($_}" } sort { $fillExpl{$a} <=> $fillExpl{$b} } sort keys %fillExpl), $launchMinorErrs ? "" : " (-lm to launch)");
	if ($printTest) { printf("TEST RESULTS: fillin-expl-$_[0],%d,0,0,%s\n", scalar keys %fillExpl, join(" / ", map { "$fillExpl{$_}" } sort { $fillExpl{$a} <=> $fillExpl{$b} } keys %fillExpl)); }
  }
  if (scalar keys %fillConc)
  {
    printf("Fill in concept text (%d total) at %s%s\n", scalar keys %fillConc, join(", ", map { "$fillConc{$_}($_}" } sort { $fillConc{$a} <=> $fillConc{$b} } sort keys %fillConc), $launchMinorErrs ? "" : " (-lm to launch)");
    if ($printTest) { printf("TEST RESULTS: fillin-conc-$_[0],%d,0,0,%s\n", scalar keys %fillConc, join(" / ", map { "$fillConc{$_}" } sort { $fillConc{$a} <=> $fillConc{$b} } keys %fillConc)); }
  }

  if ($errMsg)
  {
  if ($printErrors) { print "$errMsg"; if (!$codeToClipboard) { print "Run with -c to put code to clipboard.\n"; } }
  my $bigString = $verboseCutPaste ? "Basic cut-and-paste (fill-in-here throws an error on purpose so I fix it) :\n" : "";
  if ($activErr) { $bigString .= ($verboseCutPaste ? "ACTIVATIONS:\n" : "") . $activErr; }
  if ($explErr) { $bigString .= ($verboseCutPaste ? "EXPLANATIONS:\n" : "") . $explErr; }
  if ($concErr) { $bigString .= ($verboseCutPaste ? "CONCEPTS:\n" : "") . $concErr; }
  if ($authErr) { $bigString .= ($verboseCutPaste ? "AUTHORS:\n" : "") . $authErr; }
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
}

sub printGlobalResults
{
  if ($#dumbErrors > -1)
  {
    print "#####################Remove error-text from line(s) " . join(", ", @dumbErrors) . ".\n";
  }

  if ($#fillIn > -1)
  {
    print "Zap fill-in text at line(s) " . join(", ", @fillIn) . ".\n";
  }

  if (scalar keys %fileLineErr || scalar keys %minorErrs)
  {
    if ($openStoryFile)
	{
	for my $thisFile (keys %fileLineErr)
	{
	if (!defined($fileLineErr{$thisFile}) || ($fileLineErr{$thisFile} !~ /[0-9]/)) { print "Maybe an error: $thisFile has a non numerical launch line.\n"; next; }
    my $cmd = "$np \"$thisFile\" -n$fileLineErr{$thisFile}";
	print "Running $cmd\n";
	`$cmd`;
	}
	if ($launchMinorErrs)
	{
	for my $thisFile (keys %minorErrs)
	{
	if (defined($fileLineErr{$thisFile})) { next; }
    my $cmd = "$np \"$thisFile\" -n$minorErrs{$thisFile}";
	`$cmd`;
	}
    }
	}
	else
	{
	  print "Use -l to launch the story file for direct editing.\n";
    }
  }
  if ((scalar keys %minorErrs) && (!scalar keys %fileLineErr) && (!$launchMinorErrs))
  { print "Use -m to launch file lines for minor errors.\n"; }
}

sub checkOrder
{
  my @ex;
  my @co;
  my $expls;
  my $concs;
  my $ordFail = 0;
  my $lastConcept = "";
  my $file;

  if (!defined($fileHash{$_[0]}))
  {
    print "Need to define a file array for project $_[0].\n";
	return;
  }

  my @toRead = @{$fileHash{$_[0]}};

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

  for $file (@toRead)
  {
  open(A, "$file") || die ("Can't open $file.");

  while ($a = <A>)
  {
    $origLine = $a;
	if ($a =~ /alfbyroom/) { <A>; $objAlf = checkGameObjExpl($.); $writeGameObjErrRes = 1; print next; }
    if (($a =~ /is a.* author\. pop/) && ($a !~ /^\[/)) { $b = $a; $b =~ s/ is (a|an) .*//g; chomp($b); $auth{$b} = $.; next; }
	if (($expls) && ($a !~ /[a-z]/i)) { $expls = 0; next; }
	if (($concs) && ($a =~ /end concepts/)) { $concs = 0; next; }
    if ($a =~ /xx(add|auth|slb|bks|bkj)/) { <A>; $expls = 1; next; }
    if ($a =~ /\[xxcv\]/) { <A>; $concs = 1; next; }
	if ($expls)
	{
	  chomp($a);
	  $a =~ s/\t.*//g;
	  $a = lc(cutArt($a));
	  push (@ex, $a);
	  if (!$lineNum{$a}) { $lineNum{$a} = $.; }
	  if ($origLine =~ /\[start/)
	  {
	    $lastComp = "";
      }
	  else
	  {
        if (lc($a) le lc($lastComp)) { print "($.) Order flip $a vs $lastComp\n"; $ordFail++; }
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
		$a = lc(cutArt($a));
		push (@co, $a);
	    if ($a le $lastConcept)
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

  close(A);

  }

  if ($ordFail) { print "  EXPLANATIONS table order mistakes above ($ordFail)\n"; }

  $ordFail = 0;
  my $inOrder = 0;
  my $printThisOut = 1;
  my $lastCo = 0;
  my $lastEx = 0;
  for (0..$#ex)
  {
    $printThisOut = 1;
    #print lc(@ex[$_]) . " =? " . lc(@co[$_]) . "\n";
    if ((!defined($co[$_])) || (lc($ex[$_]) ne lc($co[$_])))
	{
	  my $temp = 0;
	  if (defined($co[$_])) { $temp = defined($lineNum{$co[$_]}) ? $lineNum{$co[$_]} : 0; }

	  $ordFail++;
	  if ($match - $lastMatch == 1) { next; }
	  $printThisOut = !($lastCo - $temp == -1); #(($lastCo - $lineNum{$co[$_]} == -1) ||
	  #print "$lastCo $lineNum{$co[$_]} $lastEx $lineNum{$ex[$_]}\n";
	  $printThisOut |= $printAllDiff;
	  if ($printThisOut)
	  {
	  if (defined($co[$_])) { $temp = defined($lineNum{$co[$_]}) ? $lineNum{$co[$_]} : "none"; }
	  printf("$_ ($ordFail): $ex[$_] %s vs %s", defined($lineNum{$ex[$_]}) && $lineNum{$ex[$_]} ? "($lineNum{$ex[$_]})" : "",
	  defined($co[$_]) ? "$co[$_] ($temp)" : "(nothing)");
	  #defined($co[$_]) ? "$co[$_] ($lineNum{$co[$_]})" : "");
	  }
	  if (defined($co[$_]) && defined($lineNum{$co[$_]}))
	  {
	    if (!defined($fileLineErr{$toRead[0]}) || (!$openLowestLine && ($fileLineErr{$toRead[0]} < $lineNum{$co[$_]})))
	    {
		  $fileLineErr{$toRead[0]} = $lineNum{$co[$_]};
        }
	  }
	  for my $match (0..$#co)
	  {
	    if (lc($ex[$_]) eq lc($co[$match]))
	    {
		  if ($printThisOut) { print " (#$match)"; }
		  if ($match - $lastMatch == 1) { if ($printThisOut) { print " (in order)"; } $inOrder++; }
		  $lastMatch = $match;
	  if (defined($co[$_]) && defined($lineNum{$co[$_]})) { $lastCo = $lineNum{$co[$_]}; }
	  if (defined($lineNum{$ex[$_]})) { $lastEx = $lineNum{$ex[$_]}; }
		}
	  }
	  if ($printThisOut)
	  {
	  if ($lw ne "") { print " (last working=$ex[$lw])"; }
	  print "\n";
	  }
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

  if ($writeGameObjErrRes && $printTest)
  {
    print "TEST RESULTS:$_[0] explanation alphabetizing,0,$ordFail,$objSuc\n";
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
my $curRoom = "general concepts";
$asterisks = 0;
$astString = "";

my $tempRoom;

my $inTable = 0;
my $inRoomSect = 0;

my @files = ("c:/games/inform/$_[0].inform/source/story.ni");
my $file;

if (lc($_[0]) eq "compound") { push(@files, "$i7\\compound tables.i7x"); }

for $file (@files)
{
open(X, $file) || do { print "No source file $file.\n"; return; };

my $line = 0;

my $inAuthTable = 0;

my $inAdd = 0;

my $lineIn;
my $tmpVar;

my $everRoomSect = 0;
my $forceRoom = "";

@dumbErrors = ();

while ($lineIn = <X>)
{
  $tempRoom = "";
  chomp($lineIn);
  if ($lineIn =~ /\[end rooms\]/) { $inRoomSect = 0; next; }
  if ($lineIn =~ /\[start rooms\]/) { $inRoomSect = 1; $everRoomSect = 1; next; }
  if ($lineIn =~ /^\[/) { next; }
  if ($lineIn =~ /\[temproom (of )?/i) { $tempRoom = lc($lineIn); $tempRoom =~ s/.*\[temproom (of )?//; $tempRoom =~ s/\].*//; $forceRoom = ""; }
  if ($lineIn =~ /\[forceroom /i) { $forceRoom = lc($lineIn); $forceRoom =~ s/.*\[forceroom //; $forceRoom =~ s/\].*//; }
  if ($lineIn =~ /(EXPLANATIONS:|CONCEPTS:|fill-in-here throws)/) { push (@dumbErrors, $.); next; }
  if (($lineIn =~ /is a.* author\. pop/) && ($lineIn !~ /^\[/)) { $tmpVar = $lineIn; $tmpVar =~ s/ is (an|a) .*//g; chomp($tmpVar); if ($lineIn =~ /xp-text is /) { $gotText{$tmpVar} = 1; } elsif ($lineIn =~ /\"/) { print "Probable typo for $tmpVar.\n"; } $auth{$tmpVar} = $line; next; }
  if ($inAuthTable)
  {
    if ($lineIn !~ /[a-z]/i) { $inAuthTable = 0; next; }
    $tmpVar = $lineIn; chomp($tmpVar); $tmpVar =~ s/\t.*//g; $authTab{$tmpVar} = $line; next;
  }
  if ($lineIn =~ /xxadd/) { $addStart = $.; $inAdd = 1; }
  if ($lineIn =~ /xxcv/) { $cvStart = $.; }
  if ($lineIn =~ /xxauth/) { $inAuthTable = 1; <A>; $line++; next; }
  if ($lineIn =~ /^table of explanations.*concepts/) { $inTable = 1; <X>; next; }
  if ($lineIn !~ /[a-z]/i) { $inTable = 0; if ($inAdd) { $addEnd = $.; $inAdd = 0; } next; }
  if (($lineIn =~ /^part /) && ($inRoomSect)) { $curRoom = lc($lineIn); $curRoom =~ s/^part +//; $forceRoom = ""; next; }
  $lineIn = cutArt($lineIn);
  if ($lineIn =~ /is a concept in (lalaland|conceptville)/) # concept definitions
  {
    $cvEnd = $.;
  }
  if ($lineIn =~ /is a concept in lalaland/) # concept definitions
  {
    $lineIn =~ s/ is a concept in lalaland.*//g;
	$lineIn = wordtrim($lineIn);
    if (!defined($concToRoom{$lineIn})) { $concToRoom{$lineIn} = "general concepts"; }
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
	if ($tmpVar =~ /\*/)
	{
	  my $tmpVar2 = $tmpVar;
	  $tmpVar2 =~ s/\].*//;
	  if ($tmpVar2 =~ /\*/)
	  {
	  $tmpVar2 =~ s/\*/ /;
	  $asterisks++;
	  $astString .= "$tmpVar2($.)\n";
	  }
    }
	my $c = $tmpVar;
	$c =~ s/\].*//g;
	if ($c eq "conc-name entry") { next; }
	$c = wordtrim($c);
	if (!defined($concToRoom{$c}))
	{
	if ($tempRoom)
	{
	$concToRoom{$c} = $tempRoom;
	}
	elsif ($inRoomSect)
	{
	$concToRoom{$c} = $curRoom;
	}
	elsif ($forceRoom)
	{
	$concToRoom{$c} = $forceRoom;
	}
	else
	{
	$concToRoom{$c} = "general concepts";
	}
	}
	if (defined($activ{$c}) && !defined($okDup{$c})) { print "Warning line $. double defines $c from $lineNum{$c}.\n"; }
	$activ{$c} = $.;
	$any{$c} = $.;
	$lineNum{$c} = $.;
  }
  if ($inTable)
  {
    $tmpVar = $lineIn;
	$tmpVar =~ s/\t.*//g;
	$tmpVar = wordtrim($tmpVar);
	$expl{$tmpVar} = $any{$tmpVar} = 1;
	if ($lineIn =~ /fill-in-here/) { $fillExpl{$tmpVar} = $.; }
	if (!defined($lineNum{$tmpVar})) { $lineNum{$tmpVar} = $.; }
	next;
  }
  if ($lineIn =~ /^a thing called /) { $lineIn =~ s/^a thing called //i; }
  if (($lineIn =~ /is a (privately-named |risque |)?concept/) && ($lineIn !~ /\t/)) #prevents  "is a concept" in source text from false flag
  {
    $tmpVar = $lineIn; $tmpVar =~ s/ is a (privately-named |risque |)?concept.*//g; $tmpVar = wordtrim($tmpVar); $conc{$tmpVar} = $any{$tmpVar} = $.;
	if ($lineIn =~ /fill-in-here/)
	{
	  $fillConc{$tmpVar} = $.;
	  unless ($openLowestLine && defined($minorErrs{$tmpVar})) { $minorErrs{$file} = $.;}
    }
	if (($lineIn =~ /\"[a-z]+\"[^\.]/i) && ($lineIn !~ /\[ok\]/))
	{
	  $needSpace{$tmpVar} = $.;
	  unless ($openLowestLine && defined($minorErrs{$tmpVar})) { $minorErrs{$file} = $.; }
    }
	if (!defined($lineNum{$tmpVar})) { $lineNum{$tmpVar} = $.; }
	if ($lineIn =~ /\[ac\]/) { $activ{$tmpVar} = $.; } # [ac] says it's activated somewhere else
	next;
  }
  if ($lineIn =~ /\[fill-in-here\]/)
  {
    $nuline = $.;
	unless ($openLowestLine && defined($fileLineErr{$file}))
	{ $fileLineErr{$file} = $.; }
	push (@fillIn, "$file-$.");
	#elsif ($lineIn =~ /is a concept in /) { $lineIn =~ s/ is a line in .*//; chomp($lineIn); $fillConc{$lineIn} = $.; }
	next;
  }
}

close(X);
if (!$everRoomSect) { warn ("No room section start found."); }
}

printResults($_[0]);

}

sub wordtrim
{
  my $temp = lc($_[0]);
  $temp =~ s/^the //g;
  $temp =~ s/^a thing called //g;
  $temp =~ s/^a //g;
  $temp =~ s/\*/ /g;
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
  my $gameObjCur = 0;
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
	  #print "$c1 vs $c2, $line vs $compare\n";
	  chomp($c1);
	  chomp($c2);
	  $gameObjTot++;
	  $gameObjCur++;
	  $locCount++;
	  if (($gameObjCur == 1) && ($gameObjTot > 1)) { print "=" x 80 . "\n"; }
	  print "$.($gameObjCur,$gameObjTot): $c2 should be after $c1 ($curLoc, $locCount).\n";
	}
	$compare = $line;
  }
  $objSuc = $. - $initLines - $gameObjCur;
  return $gameObjCur;
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

###########################
#some magic #s here, $_[0] = search string, $_[1] = file, $_[2] = 1 means exp, 2 means conc definition, 3 means activation
sub findExplLine
{
  my $actRoom = "";
  my $curRoom = $defaultToGeneral ? $defaultRoom : "";
  my $toFind = 0;
  my $startSearch = 0;
  my $amClose = 0;
  my $begunRooms = 1;
  my $doneRooms = 0;
  my $anyRooms = 0;

  if (!defined($fileHash{$_[1]}))
  {
    print "Need to define a file array for project $_[0].\n";
	return;
  }

  my @toRead = @{$fileHash{$_[1]}};
  my $file;
  my $type = ($_[2] == 2 ? "concept definition" : "explanation");
  my $line;

  OUTER:
  for $file (@toRead)
  {
  open(B, $file);
  while ($line = <B>)
  {
	if ($line =~ /^\[start rooms\]/i) { $begunRooms = 1; $doneRooms = 0; next; }
    if (($line =~ /^part /i) && ($begunRooms) && (!$doneRooms)) { $line =~ s/ *\[.*//; $begunRooms = 1; $curRoom = $line; $curRoom =~ s/^part //i; next; }
	$line =~ s/\*/ /g; # ugh, a bad hack but it will have to do to read asterisk'd files
	if ($line =~ /^\[end rooms\]/i) { $doneRooms = 1; $curRoom = $defaultRoom; next; }
	if ($line =~ /activation of $_[0]/i)
	{
	  chomp($curRoom);
	  $actRoom = $curRoom;
	  if ($line =~ /\[temproom/) { $actRoom = lc($line); chomp($actRoom); $actRoom =~ s/.*\[temproom +(of +)?//; $actRoom =~ s/\].*//; }
	  close(B);
	  last OUTER;
    }
  }

  if (!$warnedYet)
  {
    if (!$doneRooms) { warn("You need \[end rooms\] in the source somewhere.\n"); }
    if (!$begunRooms) { warn("You need \[start rooms\] in the source somewhere.\n"); }
    $warnedYet = 1;
  }

  close(B);
  }


  if (!$actRoom)
  {#print "$_[0] FAILED / $defaultToGeneral / $. / $_[2] / $curRoom\n";
    return ("(failed)", "????");
  }

  for my $file(@toRead)
  {
  #print "Opening $file for $_[0], $actRoom, $type\n";
  open(B, $file) || die ("No $file");

  my $inXX = 0;
  while ($a = <B>)
  {
    if ($_[2] == 1)
	{
    if ($a =~ /xxadd/) { $inXX = 1; }
    if ($inXX && ($a =~ /\[start of $actRoom/i))
	{
	  $startSearch = $.;
	  $amClose = 1;
	}
	elsif ($inXX && $amClose && ($a =~ /\[start of /))
	{
	  my $retVal = $.;
	  close(B);
	  return ($file, $retVal);
	}
	}
	else
	{
	if ($a =~ /^(chapter|section) $actRoom/i) { $startSearch = $.; $amClose = 1; next; }
	}
	if ($amClose)
	{
	  chomp($a);
	  if ($_[2] == 2)
	  {
	  if  ($a =~ /^to say/) { <B>; next; }
	  $a =~ s/^a thing called //i;
	  $a =~ s/^the //i;
	  if ($a =~ /^(part|section|chapter|volume|book) /i)
	  { my $retVal = $.; close(B); return ($file, $retVal); }
	  if (lc($a) ge lc($_[0])) { my $retVal = $.; close(B); return ($file, $retVal); }
	  }
	  elsif ($_[2] == 1)
	  {
	  $a =~ s/\t.*//;
	  if ($a !~ /[a-z]/i) { my $retVal = $.; close(B); return ($file, $retVal); }
	  if ($a =~ /\[start of/i) { my $retVal = $.; close(B); return ($file, $retVal); }
	  if (lc($a) ge lc($_[0])) { my $retVal = $.; close(B); return ($file, $retVal); }
	  }
	}
  }
  close(B);
  }
  printf("Couldn't find %s line for $_[0]/$actRoom in $_[1] files. May need \[start of $actRoom\] in %s.\n", $_[2] == 1 ? "room-concept-list" : "table-of-explanations start", $_[2] != 1 ? "room-concept-list" : "table-of-explanations start");
  my $highestBelow = 0;
  my $lowestAbove = 0;
  my $approxLine = $roomIndex{lc($actRoom)};
  #for (sort keys %roomIndex) { print "$_ $roomIndex{$_}\n"; }
  #for (sort keys %conceptIndex) { print "$_ $conceptIndex{$_}\n"; }
  if ($_[2] == 1)
  {
  #look for the room just after the room your idea is in, then go there to insert your room in the table of explanations
  for (sort { $roomIndex{$a} <=> $roomIndex{$b} } keys %roomIndex)
  {
    if (($roomIndex{$_} > $approxLine) && defined($concTableLine{$_})) { return ($toRead[0], $concTableLine{$_}); }
  }
  for (sort { $roomIndex{$b} <=> $roomIndex{$a} } keys %roomIndex)
  {
    if (($roomIndex{$_} < $approxLine) && defined($concTableLine{$_})) { return ($toRead[0], $concTableLine{$_}); }
  }
  }
  if ($_[2] == 2)
  {
  for (sort { $roomIndex{$a} <=> $roomIndex{$b} } keys %roomIndex)
  {
    if (($roomIndex{$_} > $approxLine) && defined($conceptIndex{$_})) { return ($toRead[0], $conceptIndex{$_}); }
  }
  for (sort { $roomIndex{$b} <=> $roomIndex{$a} } keys %roomIndex)
  {
    if (($roomIndex{$_} < $approxLine) && defined($conceptIndex{$_})) { return ($toRead[0], $conceptIndex{$_}); }
  }
  }
  return ($toRead[0], "????");
}

sub readOkayDupes
{
  my $line;
  open(A, "$dupeFile") || die ("Can't open $dupeFile.");
  while ($line = <A>)
  {
    if ($line =~ /^#/) { next; }
    if ($line =~ /^;/) { last; }
    chomp($line);
	$okDup{lc($line)} = 1;
  }
  close(A);
}

sub readAux
{
  open(A, $auxFile) || die ("No $auxFile");
  my $line;

  while ($line = <A>)
  {
	chomp($line);
    my @ary = split(/\t/, $line);
	my $idx = shift(@ary);
	$fileHash{$idx} = \@ary;
	#print "$idx -> @{$fileHash{$idx}}\n";
  }
}

sub getRoomIndices
{
  my $line;
  my $inConcepts = 0;
  my $tempStr;
  my $begunRooms = 0;
  my $doneRooms = 0;
  my $inConceptTable = 0;
  my @toRead = @{$fileHash{$_[0]}};

  $roomIndex{"general concepts"} = 1;

  open(A, $toRead[0]);

  while ($line = <A>)
  {
    if ($line =~ /\[xxadd\]/i) { $inConceptTable = 1; <A>; next; }
    if ($line !~ /[a-z]/i) { $inConceptTable = 0; next; }
	if ($inConceptTable)
	{
	  if ($line =~ /\[start of/i)
	  {
	    my $idea = lc($line); $idea =~ s/.*\[start of //;
		chomp($idea);
		$idea =~ s/\].*//;
		$concTableLine{$idea} = $.;
	  }
    }
	if ($line =~ /^\[start rooms\]/i) { $begunRooms = 1; $doneRooms = 0; next; }
    if (($line =~ /^part /i) && ($begunRooms) && (!$doneRooms))
	{
	  chomp($line);
	  $line =~ s/ *\[.*//;
	  $begunRooms = 1;
	  $tempStr = lc($line);
	  $tempStr =~ s/^part //i;
	  $roomIndex{$tempStr} = $.;
	  next;
    }
	$line =~ s/\*/ /g; # ugh, a bad hack but it will have to do to read asterisk'd files
	if ($line =~ /\[xxcv\]/) { $inConcepts = 1; next; }
	if ($inConcepts)
	{
      if ($line =~ /^volume/i) { $inConcepts = 0; next; }
	  if ($line =~ /^section .* concepts/i)
	  {
        chomp($line);
		$tempStr = lc($line);
		$tempStr =~ s/^section *//i;
		$tempStr =~ s/ *concepts//i;
		$conceptIndex{$tempStr} = $.;
		#print "$line -> $tempStr\n";
		next;
      }
	}
  }
  close(A);
}

sub compareRoomIndex
{
  my $explanationOrderDetail = 0;
  my $explainOrdErrors = 0;
  my $checkRoomMatchup = 0;
  my $conc;
  my $concSortFail = 0;
  my $inExp = 0;
  my $lastSortRoom = "";
  my $commentBit = "";
  my $lastLine = 0;
  my $initWarn = 0;
  my $proofStr = "";
  my %ideaHash;
  my $detailLineToOpen = 0;

  my $lastConc = 0;
  my $lastRoom = 0;
  my $lastConcName = "";

  my $line;
  my @toRead = @{$fileHash{$_[0]}};

  open(A, $toRead[0]);

  while ($line = <A>)
  {
	if ($line =~ /\[xxadd\]/i) { $checkRoomMatchup = 1; }
    if ($line =~ /^table of explanations/) { $proofStr = "proofreading at line $. for $line"; <A>; $inExp = 1; $lastLine = ""; $lastSortRoom = ""; next; }
	if ($line !~ /[a-z]/) { $checkRoomMatchup = 0; $inExp = 0; if ($proofStr) { print "PASSED $proofStr"; $proofStr = ""; } next; }
	if ($inExp)
	{
	  chomp($line);
	  $line = lc($line);
	  if ($line =~ /\[start (of )?/)
	  {
	    $commentBit = $line;
		$commentBit =~ s/.*\[start (of )?//;
		$commentBit =~ s/\].*//;
		$lastLine = $line;
	    $lastLine =~ s/\t.*//;
		#for (sort keys %roomIndex) { print "$_ $roomIndex{$_}\n"; } die();
		if (!defined($roomIndex{$commentBit}) && !defined($roomIndex{$lastSortRoom}))
		{
		  warn("Line $. $commentBit/$lastSortRoom nothing defined. Probably forgot to initialize something.");
		  $explainOrdErrors++;
		}
		else
		{
		if (!defined($roomIndex{$commentBit})) { if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; } warn("Line $. ($commentBit) current comment has no room start.\n"); $explainOrdErrors++; }
		if (!defined($roomIndex{$lastSortRoom})) { if ($lastSortRoom) { if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; } warn("Line $. ($lastSortRoom) last room has no room start.\n"); $explainOrdErrors++; } }
		elsif (defined($roomIndex{$commentBit}) && (!defined($roomIndex{$commentBit}) || ($roomIndex{$commentBit} < $roomIndex{$lastSortRoom})))
        {
		  if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; }
		  $explainOrdErrors++;
		  print "$.: room $commentBit(index " . (defined($roomIndex{$commentBit}) ? $roomIndex{$commentBit} : "N/A") . ") should be behind last room of $lastSortRoom(index $roomIndex{$lastSortRoom})";
		  if (defined($roomIndex{$commentBit}))
		  {
		  my $justAfterCandidate = "";
		  my $justAfterLine = 0;
		  my $rm;
		  for $rm (keys %roomIndex)
		  {
		    if (($roomIndex{$rm} > $justAfterLine) && ($roomIndex{$rm} < $roomIndex{$commentBit}))
			{
			  $justAfterCandidate = $rm;
			  $justAfterLine = $roomIndex{$rm};
			}
		  }
          if ($justAfterCandidate) { print ", maybe shifted just ahead of $justAfterCandidate(index $roomIndex{$justAfterCandidate})"; }
		  }
		  print ".\n";
        }
		}
		$lastSortRoom = $commentBit;
      }
	  elsif (cutArt($line) le cutArt($lastLine))
	  {
	    if (($commentBit eq "") && (!$initWarn)) { if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; } warn("Line $. forgot to initialize something.\n"); $initWarn = 1; $explainOrdErrors++; }
	    $line =~ s/\t.*//;
		if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; }
		my $lastLineCut = $lastLine;
		$lastLineCut =~ s/\t.*//;
	    printf("$.: %s alphabetically behind %s.\n", $line, $lastLineCut);
		$lastLine = $line;
	  }
	  else
	  {
	    $line =~ s/\t.*//;
	  }
	  $lastLine = $line;
	  if ($checkRoomMatchup)
	  {
	    my $idea = $line; $idea =~ s/\t.*//; chomp($idea); $idea = cutArt($idea);
		if ((!defined($concToRoom{$idea})) || ($concToRoom{$idea} ne $commentBit))
		{
		  if ($proofStr) { print "ERRORS $proofStr"; $proofStr = ""; }
		  $explanationOrderDetail++;
		  print "$.: $idea (" . (defined($lineNum{$idea}) ? "$lineNum{$idea}" : "NO LINE NUM") . ") codesectioned to " . (defined($concToRoom{$idea}) ? $concToRoom{$idea} : "(NO ROOM FOR CONCEPT)") . " " . (defined($concToRoom{$idea}) && defined($roomIndex{$concToRoom{$idea}}) ? "" : " (UNDEFINED ROOM)") . " but defined as concept in $commentBit.\n";
		  $ideaHash{$lineNum{$idea}}++;
		  if ((!$detailLineToOpen) || ($detailLineToOpen > $lineNum{$idea}))
		  {
		    $detailLineToOpen = $lineNum{$idea};
		  }
		}
	  }
	}
  }

  if ($detailLineToOpen && (!$fileLineErr{$toRead[0]})) { $fileLineErr{$toRead[0]} = $detailLineToOpen; } #detailLineToOpen is used so we open the first line number that fails when we show the list

  close(A);

  if (scalar keys %roomIndex == 0)
  {
    print "Oops, no room lines are defined for $_[0], so it's not worth running a test.\n";
  }

  if (scalar keys %conceptIndex == 0)
  {
    print "Oops, no concept lines are defined for $_[0], so it's not worth running a test.\n";
  }

  if ($printTest) { print "TEST RESULTS:$_[0] explain order,$explainOrdErrors,0,0,(none)\n"; }

  my $temp = join(" / ", map { "$_" . ($ideaHash{$_} > 1 ? "*" : "") } sort { $a <=> $b } keys %ideaHash);
  if (scalar keys %ideaHash) { print "Fill in explanation text at " . join(" / ", map { "$_" . ($ideaHash{$_} > 1 ? "*" : "") } sort { $a <=> $b } keys %ideaHash) . ", or " . (scalar keys %ideaHash) . " lines.\n"; }

  if ($printTest) { print "TEST RESULTS:$_[0] explain order detail,$explanationOrderDetail,0,0,$temp\n"; }

  my $banner = "CONCEPT DEFINITION ANALYSIS\n";

  for $conc (sort { $roomIndex{$a} <=> $roomIndex{$b} } keys %roomIndex)
  {
    unless (defined($conceptIndex{$conc}))
	{
	  if ($rcVerbose) { print "No concepts unique to $conc($roomIndex{$conc}).\n"; }
	  next;
    }
	if ($conceptIndex{$conc} < $lastConc) { if ($banner) { print "ERRORS in $banner"; $banner = ""; } print "$conc(rm $roomIndex{$conc}, conc $conceptIndex{$conc}) is out of order vs $lastConcName(rm $lastRoom, conc $lastConc).\n"; $concSortFail++; }
	else
	{
	  if ($rcVerbose) { print "$conc: $roomIndex{$conc} vs $conceptIndex{$conc}\n"; }
    }
	$lastRoom = $roomIndex{$conc};
    $lastConc = $conceptIndex{$conc};
	$lastConcName = $conc;
  }

  if ($banner) { print "PASSED: $banner"; }

  if ($printTest) { print "TEST RESULTS:$_[0]-conc-sort,$concSortFail,0,0\n"; }

  my $conceptNoRooms = 0;
  for $conc (sort keys %conceptIndex)
  {
    if ($conc eq "general") { next; }
    unless(defined($roomIndex{$conc})) { print "$conc($conceptIndex{$conc}) has section in concept index but no part in room index.\n"; $conceptNoRooms++; }
  }
  if ($printTest) { print "TEST RESULTS:$_[0] concepts w/o rooms,$conceptNoRooms,0,0,n/a\n"; }
  close(A);
}

sub roomToFile
{
  my $fullFile = "c:\\games\\inform\\$_[0].inform\\source\\file-order.txt";
  open(A, ">$fullFile");
  for (sort { $roomIndex{$a} <=> $roomIndex{$b} } keys %roomIndex)
  {
    print A "$_ line $roomIndex{$_}\n";
    if ($outputRoomFile) { print "$_ line $roomIndex{$_}\n"; }
  }
  close(A);
  if ($launchRoomFile) { `$fullFile`; }
}

sub usage
{
print<<EOT;
CONC.PL usage
===================================
-- = open with first line error instead of last
-a = show all errors even likely redundant consecutive ones
-e = edit source
(can combine below)
-c = error code to clipboard
-0 = print errors not error code
-l/-n = launch story file (or not) after
-v = verbosely print code
-f(l) = put rooms to file (l launches)
-m = launch minor errors if there is no major error
(any combination is okay too)
-t = print with test results so nightly build can process it
-nd = no allowed duplicates (-ed edits)
-vcp = verbose cut paste (off by default, not recommended)
(-)rc(v) = room coordination (v = verbose)
(-)ps = print success
(-)pc = PC only, (-)sc = SC only, (-)btp = BTP only
(-)a234 = PC and SC and BTP and BTP-spring (default)
(-)o = check order, (-)r = read concepts order too
CURRENT TESTS: conc.pl -pc, conc.pl -t -o -as, conc.pl -sc, conc.pl -t -o -sc
EOT
exit;
}
