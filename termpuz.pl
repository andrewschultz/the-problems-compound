$okays = 0;

if (@ARGV[0] eq "r") { psol("abadface"); }
elsif (@ARGV[0] eq "dw") { $debug = 1; psol("bcdbaffb"); }
else { psol("@ARGV[0]"); }

#psol("");

print "$okays of $totals.\n";

sub psol
{
  my $consec;
  if (length($_[0]) < 8)
  {
    psol($_[0] . "a");
    psol($_[0] . "b");
    psol($_[0] . "c");
    psol($_[0] . "d");
    psol($_[0] . "e");
    psol($_[0] . "f");
    return;
  }
  $totals++;
  @x = split(//, $_[0]);

  #if (@x[6] ne "c") { return; }

# question 3
  if ((@x[2] eq "a") && (@x[0] ne "a")) { return; }
  if ((@x[2] eq "b") && (@x[1] ne "a")) { return; }
  if ((@x[2] eq "c") && (@x[3] ne "a")) { return; }
  if ((@x[2] eq "d") && (@x[4] ne "a")) { return; }
  if ((@x[2] eq "e") && (@x[6] ne "a")) { return; }
  if ((@x[2] eq "f") && (@x[7] ne "a")) { return; }

if ($debug == 1) { print "Past q3.\n"; }

#question 5
  if ((@x[4] eq "a") && (@x[0] ne "f")) { return; }
  if ((@x[4] eq "b") && (@x[1] ne "e")) { return; }
  if ((@x[4] eq "c") && (@x[2] ne "d")) { return; }
  if ((@x[4] eq "d") && (@x[3] ne "c")) { return; }
  if ((@x[4] eq "f") && (@x[5] ne "a")) { return; }

if ($debug == 1) { print "Past q5.\n"; }

#question 1 consecutive right answers
  my $consec = 0;
  for (0..6)
  {
    if (@x[$_] eq @x[$_+1]) { $consec++; }
  }
  if ($consec != ord(@x[0]) - ord('a')) { return; }

#question 2 more than one right answer
  my %lethash;
  my $dupes = 0;

  for (0..8) { $lethash{@x[$_]}++; }
  for $k (keys %lethash)
  {
    if ($lethash{$k} > 1) { $dupes++; }
  }
  if (@x[6] eq "c")
  {
    for ('a' .. 'f')
	{
	  if (!$lethash{$_}) { return; }
	}
  }


  if ($dupes != ord(@x[1]) - ord('a')) { return; }


# questions 4 and 8
  my $as = $_[0] =~ tr/a//;

  my $aans = ord(@x[3]) - ord('a');
  #print "$as $aans\n";
  if ($aans != $as) { return; }

  my $vs = $as;
  $vs += $_[0] =~ tr/e//;
  my $vans = ord(@x[7]) - ord('a');

  if ($vans != $vs) { return; }

#  if (@x[2] == 0)
  print "$_[0]\n";
  $okays++;
}