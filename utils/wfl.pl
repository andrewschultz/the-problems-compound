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

my $output = "c:/games/inform/compound.inform/source/flip.txt";
my $track = "c:/games/inform/compound.inform/source/fliptrack.txt";

if (!@ARGV[0]) { die ("Need a word to flip."); }
while ($count <= $#ARGV)
{
$a = @ARGV[$count];

for ($a)
{
 /^-f$/ && do { $overlook = 1; $count++; next; };
 /^-t$/ && do { runFileTest(); exit; };
 /^-2$/ && do { $override = 1; $count++; next; };
 /^-d$/ && do { $dicURL = 1; $count++; next; };
 /^-o$/ && do { print "Opening $output.\n"; `$output`; exit; };
 /^-oo$/ && do { print "Opening $track.\n"; `$track`; exit; };
 /^-np$/ && do { $dicURLPrint = 0; $count++; next; };
 /^-\?$/ && do { usage(); exit; };
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
 { if ($overlook) { print "Redoing $_[0], found in line $isDone{$_[0]} in flip.txt.\n"; } else { print "$_[0] repeated, line $isDone{$_[0]} in flip.txt.\n"; return; } }
 else
 { print "$_[0] not done yet.\n"; }
 $flip = $_[0];
 for $q (sort keys %isDone) { if (($_[0] =~ /$q/) && ($_[0] ne $q)) { print "$_[0] contains already-done word $q\n"; } }

if ($dicURL) { `\"C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\" http:\/\/idioms.thefreedictionary.com\/$flip`; }

open(B, ">>$output");
open(C, ">>$track");

print C "========$flip\n";

if ($dicURLPrint) { print C "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe\" http:\/\/idioms.thefreedictionary.com\/$flip\n"; }

print B "========$flip\n";

open(A, "c:/writing/dict/brit-1word.txt");

while ($a = <A>)
{
  chomp($a); $a = lc($a);
  if (($a =~ /^$flip/i) || ($a =~ /$flip$/i))
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
  elsif ($a =~ /^$flip/i)
  {
    $b = $a; $b =~ s/(.*)($flip)$/$2-$1/g;
	$c = $a; $c =~ s/$flip$//g;
	if ($b)
	{
    print B "$a to $b";
	if ($word{$c}) { print " *** word"; $wordy++; }
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
    if ($a =~ /^=/) { $errs++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs still to look through.\n"); }
  print "TEST RESULTS:Alec reversal to read,0,$errs,0,<a href=\"file:///$output\">here</a>\n";
  $errs = 0;
  open(A, "$track");
  while ($a = <A>)
  {
    if ($a =~ /firefox/) { $errs++; }
  }
  close(A);
  if (!$errs) { print ("Output is looked through!\n"); } else { print ("$errs still to look through.\n"); }
  print "TEST RESULTS:Alec links to read,0,$errs,0,<a href=\"file:///$track\">here</a>\n";
}

sub usage
{
print<<EOT;
-d = find idiom at the free dictionary
-f = force trying and overlook if it's there
-np = don't print URL to tracking file (default is on)
-o = open the output file
-oo = open the tracking file
EOT
exit;
}