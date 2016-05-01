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

my $output = "c:\\games\\inform\\compound.inform\\source\\flip.txt";
my $track = "c:\\games\\inform\\compound.inform\\source\\fliptrack.txt";

if (!@ARGV[0]) { die ("Need a word to flip."); }

while ($count <= $#ARGV)
{
$a = @ARGV[$count];

for ($a)
{
  /^-f$/ && do { $overlook = 1; $count++; next; };
  /^(-e|e)$/ && do { `\"c:\\Program Files (x86)\\Notepad++\\notepad++.exe\" $0 `; exit; };
  /^-ao$/ && do { alfOut(); exit; };
  /^-at$/ && do { alfTrack(); exit; };
  /^-a$/ && do { alfOut(); alfTrack(); exit; };
  /^-i$/ && do { idiomSearch(@ARGV[$count+1]); exit; };
  /^-t$/ && do { runFileTest(); exit; };
  /^-2$/ && do { $override = 1; $count++; next; };
  /^(#|-|)[0-9]+$/ && do { $temp = @ARGV[$count]; $temp =~ s/^[#-]//g; idiomSearch($temp); exit; };
  /^-d$/ && do { $dicURL = 1; $count++; next; };
  /^-du$/ && do { trim(); exit; };
  /^-o$/ && do { print "Opening $output.\n"; `$output`; exit; };
  /^-oo$/ && do { print "Opening $track.\n"; `$track`; exit; };
  /^-np$/ && do { $dicURLPrint = 0; $count++; next; };
 / ^-\?$/ && do { usage(); exit; };
  if ($flipData) { print "Only one flip data allowed. Use comma separators.\n"; exit; }
  else
  {
    if ($a =~ /^[,a-z]+$/)
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

for $q (@flipAry)
{
readOneWord($q);
}

###########################################
#initWordCheck = mark all words so we can focus on the good stuff
sub initWordCheck
{

open(A, "c:/writing/dict/brit-1word.txt");

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

  $found = 0;
  $wordy = 0;

  if ($isDone{$_[0]})
 { if ($overlook) { print "Redoing $_[0], found in line $isDone{$_[0]} in flip.txt.\n"; } else { print "$_[0] repeated, line $isDone{$_[0]} in flip.txt. Use -f to override.\n"; return; } }
 else
 { print "$_[0] not done yet.\n"; }
 $flip = $_[0];
 for $q (sort keys %isDone)
 {
   if (($_[0] =~ /$q/) && ($_[0] ne $q)) { print "$_[0] contains already-done word $q\n"; }
   if (($q =~ /$_[0]/) && ($_[0] ne $q)) { print "$q contained by already-done word $_[0]\n"; }
  }

if ($dicURL) { `\"C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\" http:\/\/idioms.thefreedictionary.com\/$flip`; }

open(B, ">>$output");

if (!$overlook)
{
open(C, ">>$track");
print C "========$flip\n";
if ($dicURLPrint) { print C "\"C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\" http:\/\/idioms.thefreedictionary.com\/$flip\n"; }
}

close(C);

print B "========$flip\n";

open(A, "c:/writing/dict/brit-1word.txt");

while ($a = <A>)
{
  chomp($a); $a = lc($a);
  if ($a =~ /^$flip/i)
  {
    $b = $a; $b =~ s/^($flip)(.*)/$2-$1/gi;
	$c = $a; $c =~ s/^$flip//gi;
	if ($b)
	{
    print B "$a to $b";
	if ($word{$c}) { print B " *** word"; $wordy++; }
	print B "\n";
    $found++;
	}
  }
  elsif ($a =~ /$flip$/i)
  {
    $b = $a; $b =~ s/(.*)($flip)$/$2-$1/g;
	$c = $a; $c =~ s/$flip$//g;
	if ($b)
	{
    print B "$a to $b";
	if ($word{$c}) { print B " *** word"; $wordy++; }
	print B "\n";
    $found++;
	}
  }
}

close(A);
print B "====Found $found/$wordy for $flip\n";
print "====Found $found/$wordy for $flip\n";
close(B);
}

sub runFileTest
{
  my $errs = 0;
  open(A, "$output");
  while ($a = <A>)
  {
    if ($a =~ /^====Found/) { $errs++; <A>; }
    elsif ($a =~ /^====/) { $errs++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs word flips still to look through.\n"); }
  print "TEST RESULTS:Alec reversal to read,100,$errs,0,<a href=\"file:///$output\">here</a>\n";
  $errs = 0;
  open(A, "$track");
  while ($a = <A>)
  {
    if ($a =~ /firefox/) { $errs++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs idiom links still to look through. Less critical now I went through manually.\n"); }
  print "TEST RESULTS:Alec links to read,100,$errs,0,<a href=\"file:///$track\">here</a>\n";
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
  open(A, "$output") || die ("No $output");
  open(B, ">$output-alf");
  my @bigAry;
  while ($a = <A>)
  {
    $cur .= $a;
    if ($a =~ /^====Found/) { push(@bigAry, $cur); $cur = ""; }
  }
  if ($cur =~ /[a-z]/i) { push(@bigAry, $cur); }
  print B sort { length $a <=> length $b } @bigAry;
  close(A);
  close(B);
  if (-s $output != -s "$output-alf") { print "Oops size mismatch\n"; return; }
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
  @alf = ($x);
  while ($a = <A>)
  {
    $b = <A>;
	push(@alf, "$a$b");
  }
  print B sort(@alf);
  close(A);
  close(B);
  if (-s $track != -s "$track-alf") { print "Oops size mismatch\n"; return; }
  `copy $track-alf $track`;
}

sub idiomSearch
{
  open(A, "$track");
  my @redo = ();
  if ($_[0] =~ /[^0-9]/) { print "Need a number for idiom search.\n"; return; }
  my $toDo = $_[0];
  my $idiomsDone = 0;
  while ($a = <A>)
  {
    if ($a =~ /^=/) { push (@redo, $a); }
	elsif ($idiomsDone < $toDo) { chomp($a); print "$a\n"; `$a`; $idiomsDone++; }
	else { push (@redo, $a); }
  }
  close(A);
  open(A, ">$track");
  for (@redo) { print A $_; }
  close(A);
}

sub usage
{
print<<EOT;
-2 = override 2-letter word
-at = alphabetizes fliptrack.txt up to where you have spare links
-ao = organizes flip.txt by size
-a = organizes both (-at + -ao)
-du = trim duplicates in fliptrack.txt
-d = find idiom at the free dictionary
-e = edit the source
-f = force trying and overlook if it's there
-np = don't print URL to tracking file (default is on)
-o = open the output file
-oo = open the tracking file
-t = test how much is left to do big-picture (URLs and words)
-? = this usage here
EOT
exit;
}