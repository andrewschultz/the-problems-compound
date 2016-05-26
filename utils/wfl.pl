###########################################
#wfl.pl
#searches for words to flip eg
#
#usage
#
#wfl.pl try,ever,then
#
#try might give sultry and trying
#

my $dicURLPrint = 1;

my $autoSort = 1;

my $output = "c:\\games\\inform\\compound.inform\\source\\flip.txt";
my $track = "c:\\games\\inform\\compound.inform\\source\\fliptrack.txt";

my $chrome = "C:\\Users\\Andrew\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe";
my $ffox = "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe";
my $opera = "C:\\Program Files (x86)\\Opera\\launcher.exe";

my $webapp = $chrome;

my $wa = "alf";

if (!@ARGV[0]) { print "Need a word to flip, but here are diagnostics:\n"; countChunks(); countURLs(); exit; }

while ($count <= $#ARGV)
{
$a = @ARGV[$count];

for ($a)
{
  /^-f$/ && do { $overlook = 1; $count++; next; };
  /^(-e|e)$/ && do { `\"c:\\Program Files (x86)\\Notepad++\\notepad++.exe\" $0 `; exit; };
  /^-ao$/ && do { alfOut(); exit; };
  /^-at$/ && do { alfTrack(); exit; };
  /^-ct$/ && do { countChunks(); exit; };
  /^-a$/ && do { alfOut(); alfTrack(); print "Sorting went ok for flip.txt and fliptrack.txt.\n"; exit; };
  /^-ff$/ && do { $webapp = $ffox; $count++; next; };
  /^-gc$/ && do { $webapp = $chrome; $count++; next; };
  /^-op$/ && do { $webapp = $opera; $count++; next; };
  /^-i$/ && do { idiomSearch(@ARGV[$count+1]); exit; };
  /^-l$/ && do { $wa = "word"; $count++; next; exit; };
  /^-t$/ && do { runFileTest(); countChunks(); exit; };
  /^-2$/ && do { $override = 1; $count++; next; };
  /^(#|-|)[0-9]+$/ && do { $temp = @ARGV[$count]; $temp =~ s/^[#-]//g; idiomSearch($temp); exit; };
  /^-d$/ && do { $dicURL = 1; $count++; next; };
  /^-du$/ && do { trim(); exit; };
  /^-?o$/ && do { print "Opening $output.\n"; `$output`; exit; };
  /^-?oo$/ && do { print "Opening $track.\n"; `$track`; exit; };
  /^-np$/ && do { $dicURLPrint = 0; $count++; next; };
  /^-\!$/ && do { countChunks(); countURLs(); exit; };
 / ^-\?$/ && do { usage(); exit; };
  if ($flipData) { print "Only one flip data allowed. Use comma separators.\n"; exit; }
  else
  {
    if ($a =~ /^(\"?)[,a-z]+$/)
    {
      if (length($a) == 1) { print ("Length must be at least 2.\n"); exit; }
      if ((length($a) == 2) && (!$override)) { print ("-2 flag must be used for 2-letter word.\n"); exit; }
	  $flipData =$a; $count++; print "Flip data = $flipData\n"; next; }
     }
  print "Bad flag, $a.\n"; usage();
}
}


@flipAry = split(/,/, lc($flipData));

initWordCheck();
initDupeRead();

$autoSort = 0;
for $q (@flipAry)
{
readOneWord($q);
}

if ($shouldSort || $autoSort)
{
  if ($addedSomething) { alfOut(); }
  #print "$shouldAlphabetize = should alphabetize\n";
  if ($shouldAlphabetize) { alfTrack(); }
  countChunks();
  countURLs();
}

###########################################
#initWordCheck = mark all words so we can focus on the good stuff
sub initWordCheck
{

open(A, "c:/writing/dict/brit-1$wa.txt");

while ($a = <A>)
{
  chomp($a); $a = lc($a);
  $word{$a} = 1;
}

close(A);

}

###########################################
#initDupeRead = see what's already been done. Separate function or else it will be run several times.
sub initDupeRead
{
open(B, "c:/games/inform/compound.inform/source/fliptrack.txt");
while ($b = <B>)
{
  $lineNum++;
  if (($b =~ /==/) && ($b !~ /=Found/)) { $b =~ s/^=*//g; chomp($b); if (!$isDone{$b}) { $isDone{$b} = $lineNum; } else { print "Warning $b at $lineNum and $isDone{$b}.\n"; } }
}

close(B);
}

###########################################
#readOneWord reads one word and possible flips
sub readOneWord
{
  my $wordLength = 0;
  my $t = $_[0];

  $found = 0;
  $wordy = 0;

  if ($isDone{$_[0]})
 {
   if ($overlook)
   {
     open(Q, "$output");
	 while ($q = <Q>)
	 {
	   if ($q =~ /for $t$/)
	   { print "$t is not erased from flip.txt, returning.\n"; close(Q); return; }
	 }
	 close(Q);
     print "Redoing $t, found in line $isDone{$t} in flip.txt.\n";
   }
   else
   { print "$t repeated, line $isDone{$t} in fliptrack.txt. Use -f to override.\n"; return; }
 }
 else
 { $shouldAlphabetize = 1; print "$t not done yet.\n"; }
 $shouldSort = 1;
 $flip = $t;
 for $q (sort keys %isDone)
 {
   if (($t =~ /$q/) && ($_[0] ne $q)) { print "$t contains already-done word $q\n"; }
   if (($q =~ /$t/) && ($_[0] ne $q)) { print "$t contained by already-done word $q\n"; }
  }

if ($dicURL) { `\"$webapp\" http:\/\/idioms.thefreedictionary.com\/$flip`; }

open(B, ">>$output");

if ($shouldAlphabetize)
{
open(C, ">>$track");
print C "========$flip\n";
if ($dicURLPrint) { print C "\"$webapp\" http:\/\/idioms.thefreedictionary.com\/$flip\n"; }
}

close(C);

my $bigLongBit = "";

open(A, "c:/writing/dict/brit-1$wa.txt");

while ($a = <A>)
{
  chomp($a); $a = lc($a);
  if ($a =~ /^$flip/i)
  {
    $b = $a; $b =~ s/^($flip)(.*)/$2-$1/gi;
	$c = $a; $c =~ s/^$flip//gi;
  }
  elsif ($a =~ /$flip$/i)
  {
    $b = $a; $b =~ s/(.*)($flip)$/$2-$1/g;
	$c = $a; $c =~ s/$flip$//g;
  }
  else { next; }
  $wordLength = length($a);
  $bigLongBit .= "$a to $b";
  if ($word{$c}) { $bigLongBit .= " *** word"; $wordy++; }
  if (($oldLength != $wordLength) && ($wa eq "word")) { $bigLongBit .= " ($wordLength)"; $oldLength = $wordLength; }
  $bigLongBit .= "\n";
  $found++;
}

close(A);
my $firstLine = "========$flip ($found)\n";

if ($bigLongBit)
{
print B $firstLine;
print B $bigLongBit;
print B "====Found $found/$wordy for $flip\n";
print "====Found $found/$wordy for $flip\n";
$addedSomething = 1;
} else { print "====found nothing for $flip, so I'm adding nothing to the file.\n"; }
close(B);
}

sub runFileTest
{
  my $errs = 0;
  my $lines = 0;
  open(A, "$output");
  while ($a = <A>)
  {
    $lines++;
	if ($a =~ /[a-z]/) { $meaningLines++; }
    if ($a =~ /^====Found/) { $errs++; <A>; $curLines = 0; }
    elsif (($a =~ /^====/) && ($curLines)) { $errs++; $curLines = 0; }
	else { $curLines++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs word flips still to look through.\n"); }
  print "TEST RESULTS:Alec reversal to read,10,$errs,0,<a href=\"file:///$output\">here</a>, $lines lines\n";
  $errs = 0;
  open(A, "$track");
  while ($a = <A>)
  {
    if ($a =~ /idioms.thefreedictionary.com/) { $errs++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs idiom links still to look through. Less critical now I went through manually.\n"); }
  print "TEST RESULTS:Alec links to read,10,$errs,0,<a href=\"file:///$track\">here</a>\n";
  if (!$meaningLines) { print "$output is clear! Well done!"; } else { print "Still $meaningLines words to look through.\n"; }
  print "TEST RESULTS: Alec flip lines to read,2000,$meaningLines,0,<a href=\"file:///$output\">here</a>\n";
}

sub trim
{
  open(A, "$track");
  while ($a = <A>)
  {
    $lines++;
    $b = $a; chomp($b); if ($already{$b}) { next; }
	push(@undup, $a);
	$already{$b} = 1;
  }
  close(A);
  open(A, ">$track");
  for (@undup) { print A "$_"; }
  close(A);
  print "$lines before, " . ($#undup+1) . " after.\n";
}

sub alfOut
{
  my $lastStr;
  my $foundAny;
  open(A, "$output") || die ("No $output");
  open(B, ">$output-alf");
  my @bigAry;
  while ($a = <A>)
  {
    $cur .= $a;
    if ($a =~ /^=+Found/) { push(@bigAry, $cur); $cur = ""; }
	if ($a =~ /[a-z]/) { $lastStr = $a; $foundAny = 1; }
  }
  if (($lastStr !~ /=/) && ($foundAny)) { die "flip.txt is corrupt, bailing sorting routine. This probably means you need ====Found word(2/1) at the end\n"; }
  if ($cur =~ /[a-z]/i) { push(@bigAry, $cur); }
  #for (@bigAry) { my $x = $_; $x =~ s/\n.*//g; print "$x: " . crs($_) . "\n"; }
  print B sort { crs($a) <=> crs($b) } @bigAry;
  close(A);
  close(B);
  if (-s $output != -s "$output-alf") { print "Oops size mismatch: " . (-s $output) . " vs " . (-s "$output-alf") . "\n"; return; }
  `copy $output-alf $output`;
}

sub alfTrack
{
  my $stillAlf = 1;
  open(A, "$track") || die ("No $track");
  open(B, ">$track-alf");
  while ($a = <A>)
  {
    if ($a !~ /^=/)
	{
	  if ($stillAlf) { $x = pop(@alf) . $a; print B sort(@alf); }
	  last;
	}
    push (@alf, $a);
  }
  if ($x)
  {
  @alf = ($x);
  while ($a = <A>)
  {
    $b = <A>;
	push(@alf, "$a$b");
  }
  }
  print B sort(@alf);
  close(A);
  close(B);
  if (-s $track != -s "$track-alf") { print "Oops size mismatch: " . (-s $track) . " vs " . (-s "$track-alf") . "\n"; return; }
  `copy $track-alf $track`;
}

sub countChunks
{
  my @sizes;
  open(A, "$output");
  while ($a = <A>)
  {
    if ($a =~ /==Found/i) { chomp($a); $b = $a; $b =~ s/.*for //g; $a =~ s/\/.*//g; $a =~ s/.* //g; push(@sizes, $a); push(@titles, $b); }
  }
  close(A);
  if ($#sizes > -1) { print "Words to finagle: " . join(", ", @titles) . "\n"; print "Listed chunk sizes: " . join(", ", @sizes) . ".\n"; }
  
  @sizes = ();
  open(A, "$output");
  while ($a = <A>)
  {
    if ($a =~ /^=/i) { if ($thisChunk) { push(@sizes, $thisChunk); $thisChunk = 0; } }
	else { $thisChunk++; }
  }
  if ($thisChunk) { print "Warning, file ended wrong, should end with ====Found. This will give an extra actual chunk.\n"; push(@sizes, $thisChunk); }
  close(A);
  if ($#sizes > -1) { $totes = eval join '+', @sizes; print "Actual chunk sizes: " . join(", ", @sizes) . ". Total = $totes in " . ($#sizes + 1) . ".\n"; }
}

sub idiomSearch
{
  open(A, "$track");
  my @redo = ();
  if ($_[0] =~ /[^0-9]/) { print "Need a number for idiom search.\n"; return; }
  my $toDo = $_[0];
  my $idiomsDone = 0;
  my $undone = 0;
  while ($a = <A>)
  {
    if ($a =~ /^=/) { push (@redo, $a); }
	elsif ($idiomsDone < $toDo) { chomp($a); print "$a\n"; `$a`; $idiomsDone++; }
	else { if ($a =~ /http/) { $undone++; } push (@redo, $a); }
  }
  close(A);
  open(A, ">$track");
  for (@redo) { print A $_; }
  close(A);
  if ($undone == 0)
  {
    if ($idiomsDone == 0) { print "Nothing to do!\n"; }
	elsif ($idiomsDone < $toDo) { print "I was only able to do $idiomsDone of $toDo. But good news is, all ideas are cleared!\n"; }
	elsif ($undone == 0) { print "Yay! you've cleared the stack of words to check and hit the number left on the head.\n"; }
    else { "All finished!\n"; }
  }
  else
  {
  print "$undone left undone still.\n";
  }
  alfTrack();
}

sub countURLs
{
  my $urls = 0;
  open(A, "$track");
  while ($a = <A>)
  {
    if ($a =~ /idioms.thefreedictionary.com/) { $urls++; }
  }
  if (!$urls)
  {
    print "All URLs checked.\n";
  }
  else
  {
    print "$urls total URLs to check.\n";
  }
  close(A);
}

sub crs
{
my $total = $_[0] =~ tr/\n/\n/;
return $total;
}

sub usage
{
print<<EOT;
-2 = override 2-letter word
-at = alphabetizes fliptrack.txt up to where you have spare links
-ao = organizes flip.txt by size
-ct = count chunks in outfile
-a = organizes both (-at + -ao) & counts chunks
-du = trim duplicates in fliptrack.txt
-d = find idiom at the free dictionary
-e = edit the source
-f = force trying and overlook if it's there
-np = don't print URL to tracking file (default is on)
-o = open the output file
-oo = open the tracking file
-ff, -gc, -op picks web browser
-l = sort words by length (brit-1word) vs by alphabetical
-t = test how much is left to do big-picture (URLs and words)
-? = this usage here
EOT
exit;
}

#SUB is something to try