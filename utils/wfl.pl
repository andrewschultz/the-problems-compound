###########################################
# wfl.pl
#
# WordFLip.pl
# searches for words to flip eg
#
#usage
#
#wfl.pl try,ever,then
#
#try might give sultry and trying
#

use strict;
use warnings;
use Win32;
use Win32::Clipboard;
use List::MoreUtils qw(uniq);

my $dicURLPrint = 1;

my $autoSort = 1;

my $output = "c:\\games\\inform\\compound.inform\\source\\flip.txt";
my $track  = "c:\\games\\inform\\compound.inform\\source\\fliptrack.txt";
my $sz     = "c:\\games\\inform\\compound.inform\\source\\wfl-sz.txt";

my $chrome =
  "C:\\Users\\Andrew\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe";
my $ffox  = "C:\\Program Files (x86)\\Mozilla Firefox\\firefox.exe";
my $opera = "C:\\Program Files (x86)\\Opera\\launcher.exe";

my @vow = ( '', 'a', 'e', 'i', 'o', 'u', 'y' );
my @cons = (
  '',  'b', 'c', 'd', 'f', 'g', 'h', 'j', 'k', 'l', 'm', 'n',
  'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'y', 'z'
);
my @alllet = sort( uniq( ( @cons, @vow ) ) );
#######################options
my %didSoFar;
my $bailLog      = 0;
my $shouldSort   = 0;
my $overlook     = 0;
my $override     = 0;
my $dicURL       = 0;
my $alphabetical = 1;
my $flipData     = "";
my @flipAry;
my $ignoreY     = 0;
my $ignoreBlank = 0;

my $webapp = $ffox;

my $wa = "alf";

##################helper variables
my %isDone;
my %word;
my %timesFlipped;
my %needChecked;
my $checkWarnYet      = 0;
my $addedSomething    = 0;
my $shouldAlphabetize = 0;
my $count             = 0;
my $wordsAdded        = 0;
my $urlsAdded         = 0;
my $warn              = 0;
my $addToFound        = 0;
my $addActWords       = 0;
my $clipboard         = 0;

while ( $count <= $#ARGV ) {
  my $a1 = $ARGV[$count];
  my $a2 = defined( $ARGV[ $count + 1 ] ) ? $ARGV[ $count + 1 ] : "";

  for ($a1) {
    /^-?f$/ && do { $overlook = 1; $count++; next; };
    /^-?(uf|fu)$/ && do { $overlook = 1; $dicURL = 1; $count++; next; };
    /^-?e$/
      && do { `\"c:\\Program Files (x86)\\Notepad++\\notepad++.exe\" $0 `; exit; };
    /^-?an$/ && do { $alphabetical = !$alphabetical; $count++; next; };
    /^-?(dl|dlq|dlog)(x)?$/
      && do { $bailLog = ( $a1 =~ /x/ ); dailyLog( $a1 !~ /q/ ); exit; };
    /^-?el$/ && do { `$sz`; exit; };
    /^-?(c|b|cb)$/ && do { scourClipboard(); $clipboard = 1; $count++; next; };
    /^-?ao$/       && do { alfOut();         exit; };
    /^-?at$/       && do { alfTrack();       exit; };
    /^-?ct$/       && do { countChunks();    exit; };
    /^-??a$/       && do {
      alfOut();
      alfTrack();
      print "Sorting went ok for flip.txt and fliptrack.txt.\n";
      exit;
    };
    /^-?ff$/      && do { $webapp = $ffox;   $count++; next; };
    /^-?(gc|ch)$/ && do { $webapp = $chrome; $count++; next; };
    /^-?op$/      && do { $webapp = $opera;  $count++; next; };
    /^-?i$/ && do { idiomSearch($a2); exit; };
    /^-?l$/   && do { $wa          = "word"; $count++; next; };
    /^-?n?y$/ && do { $ignoreY     = 1;      $count++; next; };
    /^-?nb$/  && do { $ignoreBlank = 1;      $count++; next; };
    /^-?t$/ && do { runFileTest(); countChunks(); exit; };
    /^-2$/ && do { $override = 1; $count++; next; };
    /^(#|-|)[0-9]+$/ && do {
      my $temp = $ARGV[$count];
      $temp =~ s/^[#-]//g;
      idiomSearch($temp);
      exit;
    };
    /^-?d$/ && do { $dicURL = 1; $count++; next; };
    /^-?du$/ && do { trim(); exit; };
    /^-?e?o$/ && do { print "Opening $output.\n"; `$output`; exit; };
    /^-?oo$/  && do { print "Opening $track.\n";  `$track`;  exit; };
    /^-?oof$/
      && do { print "Fixing tracking file.\n"; fixTrackingFile(); exit; };
    /^-?np$/ && do { $dicURLPrint = 0; $count++; next; };
    /^-?\!$/ && do { countChunks();       countURLs(); exit; };
    /^-?\?$/ && do { usage();             exit; };
    /^--/    && do { usage();             exit; };
    /^-/     && do { print "Bad flag.\n"; usage();     exit; };

    if ( length($a1) == 1 ) {
      print("Length must be at least 2. ? for help.\n");
      exit;
    }
    if ( ( length($a1) == 2 ) && ( !$override ) ) {
      print("-2 flag must be used for 2-letter word.\n");
      exit;
    }
    my @csvArray = split( /,/, $a1 );
    for my $csv (@csvArray) {
      my $vowelCount = ( $csv =~ tr/CVB// );
      if ( $vowelCount > 2 ) {
        print("You can only have two of CVB--$a1 has more than one. Bailing.");
        exit;
      }
    }

    if ($flipData) {
      if ( !$warn ) {
        print "Usually, we use comma separators, but I'll let it slide.\n";
        $warn = 1;
      }
      $flipData .= ",$a1";
      $count++;
      next;
    }
    else { $flipData = $a1; $count++; next; }
    print "Bad flag, $a1.\n";
    usage();
  }
}

if ( !$flipData && ( $#flipAry == -1 ) ) {
  print "You need a word to flip. Without one, I'll just spew diagnostics:\n";
  countChunks();
  countURLs();
  exit;
}

print("NOTE: . converted to ,\n") if $flipData =~ /\./;
@flipAry = split( /[,\.]/, $flipData ) if !$clipboard;
@flipAry = sort(@flipAry);

my @flipAry2 = ();

my $temp;

if ($ignoreY) {
  @cons = grep { $_ ne 'y' } @cons;
  @vow  = grep { $_ ne 'y' } @vow;
}

if ($ignoreBlank) {
  @cons = grep { $_ ne '' } @cons;
  @vow  = grep { $_ ne '' } @vow;
}

my @consnb = @cons;
shift(@consnb);
my @vownb = @vow;
shift(@vownb);

for my $toFlip (@flipAry) {
  if ( $toFlip =~ /[CVB]/ ) {
    @flipAry2 = ( @flipAry2, fullArray($toFlip) );
  }
  else {
    push( @flipAry2, $toFlip );
  }
}

# die( join( ' ', @flipAry2 ) . "\nTotal: " . ( scalar @flipAry2 ) );

my %flipDupeChecker;

@flipAry = uniq(@flipAry2);

if ( $#flipAry < $#flipAry2 ) {
  for (@flipAry2) {
    $flipDupeChecker{$_}++;
  }
  my @flipDupes =
    grep { $flipDupeChecker{$_} > 1 } ( sort keys %flipDupeChecker );
  print "Weeded out "
    . ( $#flipAry2 - $#flipAry )
    . " duplicates: "
    . join( " ", map { "$_(" . ( $flipDupeChecker{$_} - 1 ) . ")" } @flipDupes )
    . ".\n";
}

initWordCheck();
initDupeRead();

$autoSort = 0;

my %dupCheck;

readFlipFile();
exit();
for my $q (@flipAry) {
  if ( ( !$override ) && ( length($q) <= 2 ) ) {
    print ""
      . (
      length($q) == 0
      ? "(skipping blank entry)"
      : "$q is too short. Use -2 to retry."
      ) . "\n";
    next;
  }
  if ( $dupCheck{$q} ) {
    print "Tried $q twice on the command line. Skipping.\n";
    next;
  }
  readOneWord($q);
}

if ( $shouldSort || $autoSort ) {
  if ($addedSomething) { alfOut(); }

  #print "$shouldAlphabetize = should alphabetize\n";
  if ($shouldAlphabetize) { alfTrack(); }
  countChunks();
  countURLs();
  if ($wordsAdded) {
    print "$wordsAdded word";
    print "s" if ( $wordsAdded != 1 );
    print
      " added total, $addToFound tries added, $addActWords good-bet words.\n";
  }
  if ($urlsAdded) {
    print "$urlsAdded URL";
    print "s" if ( $urlsAdded != 1 );
    print " added total.\n";
  }
}

if ($addToFound) {
  open( A, $sz ) || die("Can't add to found.");
  open( B, ">$sz.bak" );
  while ( $a = <A> ) {
    if ( $a =~ /^incr/ ) {
      my $newTot = $a;
      $newTot =~ s/.*=//;
      $newTot += $addToFound;
      print B "incr=$newTot\n";
    }
    else {
      print B $a;
    }
  }
  close(A);
  close(B);
  `copy $sz.bak $sz`;
}

sub dailyLog {
  print "Logging line in $sz. Use -x to bail.\n";
  my $wflsz     = wflSize();
  my $incr      = 0;
  my $origSize  = 0;
  my $chg       = 0;
  my $writeToSz = $_[0];

  open( A, $sz );
  open( B, ">$sz.bak" ) if $writeToSz;
  while ( $a = <A> ) {

    if ( $a =~ /^incr/ ) {
      $incr = $a;
      $incr =~ s/.*=//;
      chomp($incr);
      print B "incr=0\n" if $writeToSz;
    }
    elsif ( $a =~ /^size/ ) {
      $origSize = $a;
      $origSize =~ s/.*=//;
      chomp($origSize);
      print B "size=$wflsz\n" if $writeToSz;
    }
    else {
      if ( $a =~ / has / ) {
        $chg = $a;
        chomp($chg);
        $chg =~ s/.* //g;
      }
      print B $a if $writeToSz;
    }
  }
  close(A);
  $chg = $origSize - $wflsz + $incr;
  if ( !$writeToSz ) {
    print(
"$incr added, $origSize day start, $wflsz current size, total delta today is $chg.\n"
    );
    return;
  }
  die( "#" . scalar localtime( time() ) . " changed $chg has $wflsz\n" )
    if ($bailLog);
  print B "#" . scalar localtime( time() ) . " changed $chg has $wflsz\n";
  close(B);
  `copy $sz.bak $sz`;
  exit();
}

sub wflSize {
  my $c;
  my $eq = 0;
  open( C, $output );
  while ( $c = <C> ) {
    if ( $c =~ /^=/ ) { $eq++; }
  }
  my $temp = $. - $eq;
  return $temp;
}

###########################################
#initWordCheck = mark all words so we can focus on the good stuff
sub initWordCheck {

  open( A, "c:/writing/dict/brit-1$wa.txt" );

  while ( $a = <A> ) {
    chomp($a);
    $a = lc($a);
    $word{$a} = 1;
  }

  close(A);

}

###########################################
#initDupeRead = see what's already been done. Separate function or else it will be run several times.
sub initDupeRead {
  my $lineNum;
  open( B, "c:/games/inform/compound.inform/source/fliptrack.txt" );
  while ( $b = <B> ) {
    $lineNum++;
    if ( ( $b =~ /==/ ) && ( $b !~ /=Found/ ) ) {
      $b =~ s/^=*//g;
      chomp($b);
      if ( !$isDone{$b} ) { $isDone{$b} = $lineNum; }
      else                { print "Warning $b at $lineNum and $isDone{$b}.\n"; }
    }
  }

  close(B);
}

###########################################
#readOneWord reads one word and possible flips
sub readOneWord {
  my $wordLength = 0;
  my $t          = lc( $_[0] );
  my $flip;

  my $found = 0;
  my $wordy = 0;

  if ( defined( $didSoFar{ $_[0] } ) ) {
    print "Tried to redo $_[0] from cmd line input. Skipping.\n";
    return;
  }
  $didSoFar{ $_[0] } = 1;

  if ( $isDone{ $_[0] } ) {
    if ($overlook) {
      open( Q, "$output" );
      while ( my $q = <Q> ) {
        if ( $q =~ /for $t$/ ) {
          print "$t is not erased from flip.txt, returning.\n";
          close(Q);
          return;
        }
      }
      close(Q);
      print "Redoing $t, found in line $isDone{$t} in flip.txt.\n";
    }
    else {
      print "$t repeated, "
        . (
        defined( $isDone{ $_[0] } )
          && ( $isDone{ $_[0] } == -1 )
        ? "earlier this run"
        : "line $isDone{$t} in fliptrack.txt"
        ) . ". Use -f to override, -fu/-uf to add idiom URL search.\n";
      return;
    }
  }
  else {
    $shouldAlphabetize = 1;
    print "$t not done yet.\n";
  }
  $shouldSort = 1;
  $flip       = $t;
  for my $q ( sort keys %isDone ) {
    if ( ( $t =~ /$q/ ) && ( $_[0] ne $q ) ) {
      print "$t contains already-done word $q ($isDone{$q}).\n";
    }
    if ( ( $q =~ /$t/ ) && ( $_[0] ne $q ) ) {
      print "$t contained by already-done word $q ($isDone{$q}).\n";
    }
  }

# force the URL only if we've seen it before. Otherwise it goes in the to-do list.
  if ( $dicURL && $isDone{$flip} ) {
    `\"$webapp\" http:\/\/idioms.thefreedictionary.com\/$flip`;
  }

  if ( !$checkWarnYet && warnSaveBeforeCopying() ) {
    $checkWarnYet = 1;
    `$output`;
    Win32::MsgBox( "Save flip.txt before copying over",
      0, "Less annoying than overwriting" );
  }

  open( B, ">>$output" );

  my $bigLongBit = "";
  my $endBit     = "";
  my $thisLine   = "";

  open( A, "c:/writing/dict/brit-1$wa.txt" );

  my $b;
  my $c;
  my $oldLength = 0;

  while ( $a = <A> ) {
    chomp($a);
    $a = lc($a);
    if ( $a =~ /^$flip/i ) {
      $b = $a;
      $b =~ s/^($flip)(.*)/$2-$1/gi;
      $c = $a;
      $c =~ s/^$flip//gi;
    }
    elsif ( $a =~ /$flip$/i ) {
      $b = $a;
      $b =~ s/(.*)($flip)$/$2-$1/g;
      $c = $a;
      $c =~ s/$flip$//g;
    }
    else { next; }
    $wordLength = length($a);
    $thisLine   = "$a to $b";
    if ( $word{$c} ) { $thisLine .= " *** word"; $wordy++; }
    if ( ( $oldLength != $wordLength ) && ( $wa eq "word" ) ) {
      $thisLine .= " ($wordLength)";
      $oldLength = $wordLength;
    }
    $thisLine .= "\n";
    if ( ( $thisLine !~ /\*/ ) && ( $wa ne "word" ) ) {
      $bigLongBit .= $thisLine;
    }
    else { $endBit .= $thisLine; }
    $found++;
  }

  $bigLongBit = "$endBit$bigLongBit";

  close(A);
  my $firstLine = "========$flip ($found)\n";

  if ($bigLongBit) {
    print B $firstLine;
    print B $bigLongBit;
    print B "====Found $found/$wordy for $flip\n";
    print "====Found $found/$wordy for $flip\n";
    $addToFound  += $found;
    $addActWords += $wordy;

    $addedSomething = 1;
    $wordsAdded++;

    if ( !$isDone{$flip} ) {
      $timesFlipped{$flip} = 1;
    }
    else {
      $timesFlipped{$flip}++;
    }

  }
  else {
    print
"====found nothing for $flip\nso I'm adding nothing to the output or tracking file.\n";
  }
  close(B);
}

sub runFileTest {
  my $errs  = 0;
  my $lines = 0;
  my $curLines;
  my $meaningLines;

  open( A, "$output" );
  while ( $a = <A> ) {
    $lines++;
    if ( ( $a =~ /[a-z]/ ) && ( $a !~ /^==/ ) ) { $meaningLines++; }
    if ( $a =~ /^====Found/ ) { $errs++; <A>; $curLines = 0; }
    elsif ( ( $a =~ /^====/ ) && ($curLines) ) { $errs++; $curLines = 0; }
    else                                       { $curLines++; }
  }
  close(A);
  if   ( !$errs ) { print("Output is looked through!\n"); }
  else            { print("$errs word flips still to look through.\n"); }
  print
"TEST RESULTS:Alec reversal to read,10,$errs,0,<a href=\"file:///$output\">here</a>, $lines lines\n";
  $errs = 0;
  open( A, "$track" );
  while ( $a = <A> ) {
    if ( $a =~ /idioms.thefreedictionary.com/ ) { $errs++; }
  }
  close(A);
  if ( !$errs ) { print("Output is looked through!\n"); }
  else {
    print(
"$errs idiom links still to look through. Less critical now I went through manually.\n"
    );
  }
  print
"TEST RESULTS:Alec links to read,10,$errs,0,<a href=\"file:///$track\">here</a>\n";
  if ( !$meaningLines ) { print "$output is clear! Well done!"; }
  else { print "Still $meaningLines words to look through.\n"; }
  print
"TEST RESULTS: Alec flip lines to read,2000,$meaningLines,0,<a href=\"file:///$output\">here</a>\n";
}

sub trim {
  my @undup;
  my %already;
  my $lines = 0;

  open( A, "$track" );
  while ( $a = <A> ) {
    $lines++;
    $b = $a;
    chomp($b);
    if ( $already{$b} ) { next; }
    push( @undup, $a );
    $already{$b} = 1;
  }
  close(A);
  open( A, ">$track" );
  for (@undup) { print A "$_"; }
  close(A);
  print "$lines before, " . ( $#undup + 1 ) . " after.\n";
}

sub alfOut {
  my $cur;
  my $lastStr;
  my $foundAny;
  open( A, "$output" ) || die("No $output");
  open( B, ">$output-alf" );
  my @bigAry;
  while ( $a = <A> ) {
    $cur .= $a;
    if ( $a =~ /^=+Found/ ) { push( @bigAry, $cur ); $cur = ""; }
    if ( $a =~ /[a-z]/ ) { $lastStr = $a; $foundAny = 1; }
  }
  if ( ( $lastStr !~ /=/ ) && ($foundAny) ) {
    die
"flip.txt is corrupt, bailing sorting routine. This probably means you need ====Found word(2/1) at the end\n";
  }
  if ( $cur =~ /[a-z]/i ) { push( @bigAry, $cur ); }

  #for (@bigAry) { my $x = $_; $x =~ s/\n.*//g; print "$x: " . crs($_) . "\n"; }

  print B sort { crs($a) <=> crs($b) } @bigAry;
  close(A);
  close(B);
  if ( -s $output != -s "$output-alf" ) {
    print "Oops size mismatch in alf-out: "
      . ( -s $output ) . " vs "
      . ( -s "$output-alf" ) . "\n";
    return;
  }
  `copy $output-alf $output`;
}

sub alfTrack {
  my $stillAlf = 1;
  my @alf;
  my $x;

  open( A, "$track" );
  open( B, ">$track-alf" );
  while ( $a = <A> ) {
    if ( $a =~ /^=/ ) { last; }
    print B $a;
  }
  close(A);
  for $x ( sort keys %timesFlipped ) {
    my $str = "=" x 20 + $x + " " + $timesFlipped{$x};
    if ( defined( $needChecked{$x} ) ) { $str .= " *"; }
    print B $str;
  }
  print B ";\n";
  close(B);
  if ( -s $track != -s "$track-alf" ) {
    print "Oops size mismatch in alf-track: "
      . ( -s $track ) . " vs "
      . ( -s "$track-alf" ) . "\n";
    return;
  }
  `copy $track-alf $track`;
}

sub countChunks {
  my %titles;
  my @sizes;
  my @actsizes;
  my @goodies;
  my $totalWords;
  my $thisChunk = 0;
  my $rwChunk   = 0;

  open( A, "$output" );
  while ( $a = <A> ) {
    if ( $a =~ /==Found/i ) {
      chomp($a);
      $b = $a;
      $b =~ s/.*for //g;
      $a =~ s/\/.*//g;
      $a =~ s/.* //g;
      push( @sizes, $a );
      $titles{$b} = $a;
    }
  }
  close(A);

  if ( $#sizes > -1 ) {
    my $temp = scalar keys %titles;
    print "$temp total words.\n";
    print "Alphabetical list: " . join( ", ", sort keys %titles ) . "\n";
    print "By-size list: "
      . join( ", ", sort { $titles{$a} <=> $titles{$b} } keys %titles ) . "\n";
  }
  else {
    print "All words checked.\n";
  }

  open( A, "$output" );
  while ( $a = <A> ) {
    if ( $a =~ /^=/i ) {
      if ($thisChunk) {
        push( @actsizes, $thisChunk );
        push( @goodies,  $rwChunk );
        $thisChunk = 0;
        $rwChunk   = 0;
      }
    }
    else {
      $thisChunk++;
      if ( $a =~ /\*/ ) { $rwChunk++; }
    }
  }
  if ($thisChunk) {
    print
"Warning, file ended wrong, should end with ====Found. This will give an extra actual chunk.\n";
    push( @actsizes, $thisChunk );
  }
  close(A);
  if ( $#actsizes != $#sizes ) {
    die
"================\nWARNING: size arrays not equal. This shouldn't happen, but it did. Likely problem is deleting ===found line.\n================I can't read the data, so I'm bailing.\n================\n";
  }
  if ( $#sizes > -1 ) {
    print "Chunk sizes (2 words/1): ";
    for ( 0 .. $#actsizes ) {
      if ( $_ > 0 ) { print ", "; }
      $totalWords += $actsizes[$_];
      print $actsizes[$_];
      if ( $goodies[$_] ) { print "/$goodies[$_]"; }
      if ( $sizes[$_] != $actsizes[$_] ) { print " ($sizes[$_])"; }
    }
    print "\n";
    if ($totalWords) { print "Total flip-words left: $totalWords\n"; }
  }
}

sub idiomSearch {
  open( A, "$track" );
  my @redo   = ();
  my @header = ();
  if ( $_[0] =~ /[^0-9]/ ) {
    print "Need a number for idiom search.\n";
    return;
  }
  my $toDo       = $_[0];
  my $idiomsDone = 0;
  my $undone     = 0;
  my $app;

  while ( $a = <A> ) {
    if ( $a =~ /^APP=/ ) { $app = $a; $app =~ s/^APP=//g; chomp($app); }
    if ( $a =~ /^(#|APP=)/ ) { push( @header, $a ); next; }  # header info first
    if ( ( $idiomsDone < $toDo ) && ( $a =~ /^CHECK/ ) ) {
      chomp($a);
      print "$a\n";
      $a =~ s/^CHECK/\"$app\"/g;
      print "$a\n";
      `$a`;
      $idiomsDone++;
    }
    else {
      if ( $a =~ /http/ ) { $undone++; }
      push( @redo, $a );
    }
  }
  close(A);
  open( A, ">$track" );
  for (@header) { print A $_; }
  for (@redo)   { print A $_; }
  close(A);
  if ( $undone == 0 ) {
    if ( $idiomsDone == 0 ) { print "Nothing to do!\n"; return; }
    elsif ( $idiomsDone < $toDo ) {
      print
"I was only able to do $idiomsDone of $toDo. But good news is, all ideas are cleared!\n";
    }
    elsif ( $undone == 0 ) {
      print
"Yay! you've cleared the stack of words to check and hit the number left on the head.\n";
    }
    else { print "All finished!\n"; }
  }
  else {
    print "$undone left undone still.\n";
  }
  alfTrack();
}

sub countURLs {
  my %urls;
  my $thisUrl;
  my $urlsFound = 0;

  open( A, "$track" );
  while ( $a = <A> ) {
    if ( $a =~ /^=/ ) { $urlsFound++; }
    if ( $a =~ /idioms.thefreedictionary.com/ ) {
      chomp($a);
      $thisUrl = $a;
      $thisUrl =~ s/.*[\\\/]//;
      $urls{$thisUrl} = 1;
    }
  }
  my $temp = scalar keys %urls;
  if ( $temp == 0 ) {
    print "All URLs checked.\n";
  }
  else {
    print "$temp total URLs to check: "
      . ( join( ", ", sort keys %urls ) ) . "\n";
  }
  print "$urlsFound total URLs found by this script.\n";
  close(A);
}

sub crs {
  my $total = $_[0] =~ tr/\n/\n/;
  if ( $_[0] =~ /^========/ ) {
    $total--;
  }    # ignore the line starting with ======== which isn't really a word switch
  return $total;
}

sub warnSaveBeforeCopying() {
  open( C, 'C:\Users\Andrew\AppData\Roaming\Notepad++\session.xml' );
  my $c;
  while ( $c = <C>
    ) #this is to check if the file is in an unsaved state, which just got increasingly annoying over the years
  {
    if ( $c =~ /flip.txt/ ) {
      if ( $c =~ /backupFilePath=\"c:/i ) {
        close(C);
        return 1;
      }
      last;
    }
  }
  close(C);
  return 0;
}

sub fixTrackingFile {
  my %trax;

  open( A, "$track" );
  open( B, ">$track.out" );
  while ( $a = <A> ) {
    if ( $trax{$a} ) { print "Removed duplicate line $.: $a"; }
    else {
      print B $a;
      $trax{$a} = 1;
    }
  }
  close(A);
  close(B);
  if ( -s $track != -s "$track.out" ) {
    `copy $track.out $track`;
  }
  else {
    print "Nothing changed, not copying back over.\n";
  }
}

sub fullArray {

  return ( $_[0] ) if $_[0] !~ /[VCB]/;

  my @tempArray = ();
  my $tempParam = "";
  my $temp      = "";

  ( my $focusString = $_[0] ) =~ s/^[a-z]*//;
  $focusString =~ s/[a-z].*//;

  my @sprayArray = ();

  @sprayArray = @alllet if $focusString =~ /B/;
  @sprayArray = @cons   if $focusString =~ /C/;
  @sprayArray = @vow    if $focusString =~ /V/;
  @sprayArray = grep { $_ ne 'y' } @sprayArray if $focusString =~ /^[BCV]-/;
  @sprayArray = grep { $_ ne '' } @sprayArray  if $focusString =~ /^[BCV]=/;
  @sprayArray = grep { $_ ne '' && $_ ne 'y' } @sprayArray
    if $focusString =~ /^[BCV]\//;

  for $temp (@sprayArray) {
    $tempParam = $_[0];
    $tempParam =~ s/[VCB]([=\/-])?/$temp/;
    @tempArray = ( @tempArray, fullArray($tempParam) );
  }
  return @tempArray;
}

sub scourClipboard {
  my $clip = Win32::Clipboard::new();
  my $x    = $clip->Get();
  @flipAry = ( @flipAry, split( /[, \n\r]+/, $x ) );

}

sub readFlipFile {
  my @q;
  open( A, $track );
  while ( $a = <A> ) {
    chomp($a);
    $a =~ s/^=+//;
    @q = split( / /, $a );
    $timesFlipped{ $q[0] } = ( $#q ? $q[1] : 1 );
    if ( defined( $q[2] ) && ( $q[2] eq "*" ) ) { $needChecked{ $q[0] } = 1; }
  }
}

sub usage {
  print <<EOT;
-2 = override 2-letter word
-an = toggles alphabetizing in "Words to Finagle"
-at = alphabetizes fliptrack.txt up to where you have spare links
-ao = organizes flip.txt by size
-ct = count chunks in outfile
-a = organizes both (-at + -ao) & counts chunks
-c/-b/-cb = clipboard
-du = trim duplicates in fliptrack.txt
-d = find idiom at the free dictionary
-f = force trying and overlook if it's there
-np = don't print URL to tracking file (default is on)
-ff, -(gc/ch), -op picks web browser
-l = sort words by length (brit-1word) vs by alphabetical
-t = test how much is left to do big-picture (URLs and words)
-(n)y = remove y from list (V or C, in caps, looks through all vowels/consonants) (-nb ignores blanks)
-e = edit the source, -el = edit the log
-dl/dlog = send to daily log wfl-sz.txt, reset so-far (usually done in a script) (x = bail) (dlq = show total)
-o/-eo = open the output file
-oo = open the tracking file, oof = fix it
-sz = show size file so far
-? = this usage here
EOT
  exit;
}

#SUB is something to try
