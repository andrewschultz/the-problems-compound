"The Problems Compound" by Andrew Schultz

the story headline is "A Direction of Sense: changing what's-thats to that's-whats"

[Compound Tables.i7x now has a list of a lot of the random text in this game that was originally in the main file. It should be included with the GitHub project, or with the bundled release.

to search through this file, two x's at the start of a comment will delinate major points I revisit.

  other tables begin with xx and you can search for them. That way. Or with xx (first letter) in most cases. I put spaces in the index below so your first hit won't be, well, the index.
  bad guy worries, basher bible advice, horrible books, horrendous songs, sid's viewpoints, jerk girl talk, sleep stories

  2x add = stuff referred to tangentially and its explanations.
  2x cv = conceptville, where concepts you don't know about are, is not a table but contains all the definitions with how to get the concept in-game
  2x trt = ring tries (good ending)
  2x tht = hammer tries (best ending)

  if you are searching for how concepts are triggered, search for activation of, with a left bracket before it.
]

to say fill-in-here:
	say "!!";

volume initialization

Release along with an interpreter.

Release along with cover art.

use the serial comma.

use American dialect.

the release number is 3.

section compiler limits

[without these numbers being increased, the I7 would be translated to I6, but the I6 compiler would complain. That's what happens when a game gets bigger than intended. Often times I'll build in release to make sure things are okay, then I'll forget to build in debug, when things may go boom.]

use MAX_ACTIONS of 210.

use MAX_OBJECTS of 800.

use MAX_SYMBOLS of 25000.

use MAX_STATIC_DATA of 200000.

use MAX_PROP_TABLE_SIZE of 310000.

section compiler debug limits - not for release

use MAX_OBJECTS of 840. [+40]

use MAX_SYMBOLS of 28000. [+3000]

use MAX_PROP_TABLE_SIZE of 330000. [+20000]

book includes

include Basic Screen Effects by Emily Short.

include Conditional Undo by Jesse McGrew.

[debug table switch]
include Compound Tables by Andrew Schultz.

include In-Game Mapping by Andrew Schultz.

include Trivial Niceties by Andrew Schultz.

chapter quips

include Reactable Quips Modified by Michael Martin.
include Quip-based Conversation Modified by Michael Martin. [his extensions must be listed in this order]

section more of my own modifications and definitions

Before asking someone to try doing something (this is the can't order others around rule):
	say "You're just not very good at giving orders, at all. [one of]People look at you funny whether you're polite or urgent about it. Worse, others less smart than you are far better at it. You'll be glad just to feel less ordered around once this is through.[paragraph break]In fact, you used to feel guilt-tripped GIVEing someone something, even something you needed to--'What! So you want something from me?' But not any more.[paragraph break]TLDR: maybe you can GIVE people stuff, but orders are out.[or]Your best bet is to GIVE people something.[stopping]" instead;

the reject commanding for talking rule is not listed in any rulebook.

a quip can be permissible. a quip is usually not permissible.

a quip can be talked-thru. a quip is usually not talked-thru.

a quip can be jerky. a quip is usually not jerky.

Include (- Switches z; -) after "ICL Commands" in "Output.i6t".

section yes no stub

[this is for custom yes/no responses]

Include (-
[ YesOrNo i j;
	for (::) {
		#Ifdef TARGET_ZCODE;
		if (location == nothing || parent(player) == nothing) read buffer parse;
		else read buffer parse DrawStatusLine;
		j = parse->1;
		#Ifnot; ! TARGET_GLULX;
		KeyboardPrimitive(buffer, parse);
		j = parse-->0;
		#Endif; ! TARGET_
		if (j) { ! at least one word entered
			i = parse-->1;
			if (i == YES1__WD or YES2__WD or YES3__WD) rtrue;
			if (i == NO1__WD or NO2__WD or NO3__WD) rfalse;
		}
		if (((+ qbc_litany +) ~= (+ table of no conversation +)) && (i == RECAP__WD))
		{
		  print "(This is a quick yes/no question. After, you can get back to the main conversation.) >";
		  return;
		}
		if ( (+ qbc_litany +) == (+ table of weasel talk +) )
		{ print "'No weaseling. Ha ha.' "; }
		else
		{
		print "Please answer Yes or No (Y or N for short also works). ";
		}
		print "> ";
	}
];
-) instead of "Yes/No Questions" in "Parser.i6t"

section language verb replacement

Include (-
Replace LanguageVerb;

Constant RECAP__WD = 'recap';

-) after "Definitions.i6t".

Include (-
[ LanguageVerb i;
	switch (i) {
	  'i//','inv','inventory':
			   print "take inventory";
	  't//', 'talk//', 'talk', 'talk to':   if (parse-->0 == 2) { print "talk"; } else { print "talk to";};
	  'l//':   print "look";
	  'x//':   print "examine";
	  'z//':   print "wait";
	  default: rfalse;
	}
	rtrue;
];
-) after "Language.i6t".

chapter debug tests - not for release

include Property Checking by Emily Short.

[the run property checks at the start of play rule is not listed in any rulebook.]

[include Object Response Tests by Juhana Leinonen.]

section when play begins debugging

[To set the parser trace to (N - a number): (- parser_trace={N}; -).

First when play begins: set the parser trace to 6.]

[when play begins (this is the debugging stuff first thing rule):
	rulesAll;]

the set debug first rule is listed first in the when play begins rules.

when play begins (this is the set debug first rule):
	now ignore-wait is true;
	let one-true be false;
	repeat with RM running through rooms:
		if map region of RM is nothing:
			say "[RM] needs a region.";
			now one-true is true;
[	if one-true is false:
		say "DEBUG TEST: All rooms have regions.";]
	anno-check;
	now debug-state is true;
	[rulesOn;]
	[rulesAll;]

book when play begins

when play begins (this is the maximize wins rule):
	repeat through table of logic game wins:
		if max-won of the-game entry < num-wins entry:
			now max-won of the-game entry is num-wins entry;
		increment max-game-wins;
	let temp be 0;
	repeat with Q running through logic-games:
		increase temp by max-won of Q;
	continue the action;

when play begins (this is the initialize jerks rule):
	let temp be 0;
	now the RQ options prologue is "The available options[if qbc_litany is table of jt] for [last-jerk][end if] are:";
	now all clients are in Nominal Fen;
	sort table of fingerings in random order;
	while number of not specified clients > 0:
		let Q be a random not specified client;
		increment temp;
		choose row temp in table of fingerings;
		now jerky-guy entry is Q;
		now my-quip entry is jerky;
		now Q is specified;
		[d "[jerky-guy entry] = [blackmail entry].";]
	sort table of fingerings in random order;
	choose row 7 in table of fingerings;
	let f-cur-row be 0;
	let first-cli be a random client;
	now first-cli is ordered;
	let this-cli be first-cli;
	let next-cli be Buddy Best;
	while number of unordered clients > 0:
		now next-cli is a random unordered client;
		now next-c of this-cli is next-cli;
		now next-cli is ordered;
		d "[this-cli] -> [next-cli]";
		now this-cli is next-cli;
	now next-c of next-cli is first-cli;
	d "[next-cli] -> [first-cli]";

when play begins (this is the sort ALL the tables rule) :
	repeat through table of sleep stories: [ok, throw in basic initializations here]
		if there is no b4-done entry:
			now b4-done entry is false;
		if there is no now-done entry:
			now now-done entry is false;
		if there is no af-done entry:
			now af-done entry is false;
	sort the table of bad guy worries in random order;
	sort the table of bible references in random order;
	sort the table of incisive sid viewpoints in random order;
	sort the table of dutch-blab in random order;
	sort the table of sleep stories in random order;
	sort the table of horrendous books in random order;
	sort the table of horrendous songs in random order;
	sort the table of jerk-macho-talk in random order;
	continue the action;

when play begins (this is the initialize bad room viewing rule):
	let room-index be 0;
	repeat with RM running through rooms in Just Ideas Now:
		if RM is Camp Concentration:
			next;
		increment room-index;
		now point-view of RM is room-index;
	now switch-to-bad is room-index;
	repeat with RM running through rooms in Bad Ends:
		increment room-index;
		now point-view of RM is room-index;
	increment room-index;
	now point-view of Camp Concentration is room-index;
	now idea-rooms is room-index;

to choose-swearing:
	let qq be swear-decide;
	if started-yet is true:
		say "swear choice: [qq].";
	if qq is 2:
		say "You hear someone moan 'Great, another indecisive type! We'll go easy with the tough language. I guess.'[paragraph break]";
		now allow-swears is false;
	else if qq is 1:
		say "You hear someone sniff. 'Oh, good, someone at least willing to TRY the heavy-hitting stuff.'[paragraph break]";
		now allow-swears is true;
	else if qq is 3:
		now allow-swears is true;
		if started-yet is true:
			say "[line break]Going with swears.";
	else if qq is 4:
		now allow-swears is false;
		if started-yet is true:
			say "[line break]Going with no swears.";
	else:
		say "You hear a far-off voice: 'Great. No freakin['] profanity. Sorry, FLIPPIN[']. In case they're extra sensitive.'";
		now allow-swears is false;

when play begins (this is the main story introduction and initialization rule):
	force-status;
	say "The Problems Compound may contain minor profanity/innuendo that is not critical to the story. Type Y or YES if this is okay. Typing N or NO will provide alternate text.";
	choose-swearing;
	wfak;
	say "Also, The Problems Compound has minimal support for screen readers. In particular, it makes one puzzle less nightmarish. Are you using a screen reader?";
	if the player no-consents:
		now screen-read is true;
	else:
		now screen-read is false;
	if screen-read is false:
		say "Also, how thick are your glasses, if you have them? How much acne--? Wait, no, that's irrelevant. Not that people aren't mean about looks, but when you're stuck, you're stuck. Let's...let's get on with things.[paragraph break]";
		wfak;
	say "It's not [i]The Phantom Tollbooth[r]'s fault your umpteenth re-reading fell flat earlier this evening. Perhaps now you're really too old for it to give you a boost, especially since you're in advanced high school classes. Classes where you learn about the Law of Diminishing Returns.[paragraph break]Or how protagonists gain character through conflict--conflict much tougher than class discussions you barely have energy for. It's all so frustrating--you hate small talk, but you still talk small, and there's no way around. You pick the book up--you shouldn't have chucked it on the floor. Back to the bookcase...";
	wfak;
	say "[line break]Odd. Why's a bookmark wedged there? You always read the book in one go!";
	wfak;
	say "[line break]That's not a bookmark. It's a ticket to some place called the Problems Compound, just off Smart Street. And it has your name on it! FOR ALEC SMART. Too bad it's missing directions.";
	wfak;
	say "[line break][if debug-state is true])[else]>[end if] TAKE TICKET. PUT BOOK ON SHELF. GO GET A DRINK OF WATER";
	wfak;
	say "[paragraph break]The end of the hallway keeps getting farther away. You start to run, which makes it worse. You close your eyes until, exhausted, you catch your breath. The hallway's gone.";
	set the pronoun him to Guy Sweet;
	now right hand status line is "[your-mood]";
	now left hand status line is "[lhs]";
	now started-yet is true;

to say lhs:
	say "[location of player]";
	if print-exits is false:
		continue the action;
	say ":";
	if player is in service community:
		say " NW NE SE SW N S E W";
	else if number of viable directions is 0:
		say " NO EXITS";
	else:
		if up is viable:
			say " U";
		if down is viable:
			say " D";
		if north is viable:
			say " N";
		if south is viable:
			say " S";
		if east is viable:
			say " E";
		if west is viable:
			say " W";
		if northwest is viable:
			say " NW";
		if northeast is viable:
			say " NE";
		if southwest is viable:
			say " SW";
		if southeast is viable:
			say " SE";
		if inside is viable:
			say " IN";
		if outside is viable:
			say " OUT";

to say your-mood:
	if cookie-eaten is true:
		say "WAY TOO COOL";
	else if off-eaten is true:
		say "NO FUNNY STUFF";
	else if greater-eaten is true:
		say "PUZZLES? PFF";
	else if brownie-eaten is true:
		say "GIVIN['] 110%";
	else if player is in Smart Street:
		say "Just Starting";
	else if player is in Round Lounge:
		say "First Puzzle";
	else if mrlp is beginning:
		say "[if player is in Tension Surface]T[else]Near t[end if]he Arch";
	else if mrlp is outer bounds:
		if trail paper is off-stage:
			if your-tix is 0:
				say "Find trouble?";
			else:
				say "[your-tix]/4 ticketies";
		else if terry sally is in pressure pier:
			say "[if player is in pressure pier]By[else]Go See[end if] Terry";
		else if wacker weed is in lalaland:
			say "Not much here";
		else:
			say "1 task here?";
		the rule succeeds;
	else if mrlp is rejected rooms:
		say "EXIT[if number of viable directions > 1]S[end if]: ";
		say "[unless the room north of location of player is nowhere]N [end if]";
		say "[unless the room south of location of player is nowhere]S [end if]";
		say "[unless the room east of location of player is nowhere]E [end if]";
		say "[unless the room west of location of player is nowhere]W [end if]";
	else if mrlp is Dream:
		say "Dreaming";
	else if player is in Freak Control:
		say "Final Chat";
	else if player is in Nominal Fen and silly boris is in Nominal Fen:
		if qbc_litany is table of jt:
			say "[last-jerk]";
		else:
			say "7[']s a crowd";
	else if player is in Chipper Wood and p-c is true:
		say "Chasing";
	else if player is in Belt Below:
		say "[unless terminal is in Belt Below]Cheats below[else if terminal is examined]Puzzling[else]";
	else if player is in A Great Den:
		say "Spoilerville";
	else if player is in Airy Station:
		say "Big Send Off";
	else if player is in out mist:
		say "ESCAPE";
	else:
		say "[the score]/[maxmax][if questions field is visited][bro-sco][end if]";

to say maxmax:
	say "[maximum score]";
	if maximum score < maximum-maximum:
		say "-[maximum-maximum]";

to say bro-sco:
	if bros-left > 0:
		say ", [3 - bros-left] Bro[if bros-left is not 2]s[end if]";

section read what's been done

when play begins (this is the read options file rule):
	if file of verb-unlocks exists:
		read file of verb-unlocks into table of verb-unlocks;
	let found-brownie be false;
	repeat through table of verb-unlocks:
		if brief entry matches the regular expression "brownie":
			now found-brownie is true;
	if found-brownie is false:
		say "NOTE: it looks like you have played an old version of The Problems Compound. It's strongly recommended you find and erase a file called pcverbs, or pcverbs.glkdata, to get the full experience. TPC is perfectly playable without it, but completionists may miss an alternative bad ending visible only in release 3.";
		wfak;
	repeat through table of verb-unlocks:
		if brief entry is a brief listed in table of verb-unlocks:
			if found entry is true:
				prep-action "[brief entry]";

to prep-action (inte - indexed text):
	if inte is a brief listed in table of verbmatches:
		choose row with brief of inte in table of verbmatches;
		if there is a what-to-do entry:
			consider the what-to-do entry;
	else:
		say "BUG. [inte] should be in table of verbmatches. Please report to [email].";

the file of verb-unlocks is called "pcverbs".

table of vu - verb-unlocks [tvu]
brief (indexed text)	found	expound	jumpable	descr (indexed text)	conc [conc is for backwards compatibility]
"anno"	false	true	false	"ANNO to show annotations, or JUMP to jump to a bunch of rejected rooms, as a sort of director's cut."	0
"duck"	false	true	true	"DUCK SITTING to skip to Tension Surface."	0
"knock"	false	true	true	"KNOCK HARD to get to Pressure Pier."	0
"figure"	false	true	true	"FIGURE A CUT to skip past Terry Sally to the [jc]."	0
"fancy"	false	true	true	"FANCY PASSING to skip to the Questions Field with the brothers gone."	0
"track"	false	true	true	"TRACK BEATEN to reveal the Nominal Fen puzzle spoilers on examining the Finger Index."	0
"notice"	false	true	true	"NOTICE ADVANCE to skip to Questions Field, with the brothers and Nominal Fen solved."	0
"cookie"	false	false	false	"Eating the cookie on tray B unlocked a few concepts."	0
"greater"	false	false	false	"Eating the greater cheese on tray B unlocked a few concepts."	0
"off"	false	false	false	"Eating the off cheese on tray B unlocked a few concepts."	0
"brownie"	false	false	false	"Eating the brownie on tray B unlocked a few concepts."	0
"good"	false	false	false	"You found a good ending!"	0
"great"	false	false	false	"You found the great ending!"	0	[this must be last right now]

[rules are necessary since sometimes we may want to toggle more than one concept]

table of verbmatches
brief (indexed text)	what-to-do (rule)
"anno"	--
"duck"	ducksit rule
"knock"	knockhard rule
"figure"	figurecut rule
"fancy"	fancypass rule
"track"	trackbeaten rule
"notice"	advnot rule
"cookie"	cookie-ate rule
"greater"	greater-ate rule
"off"	off-ate rule
"brownie"	brownie-ate rule
"good"	wis-rec rule
"great"	wis-rec rule

this is the ducksit rule:
	move sitting duck to lalaland;

this is the knockhard rule:
	move hard knock to lalaland;

this is the figurecut rule:
	move cut a figure to lalaland;

this is the fancypass rule:
	move passing fancy to lalaland;

this is the trackbeaten rule:
	move beaten track to lalaland;

this is the advnot rule:
	move advance notice to lalaland;

this is the cookie-ate rule:
	move Snap Decision to lalaland;
	move Something Mean to lalaland;

this is the off-ate rule:
	move guttersnipe to lalaland;
	move Snap Decision to lalaland;
	move Complain Cant to lalaland;

this is the brownie-ate rule:
	move curry favor to lalaland;
	move salad days to lalaland;
	move chowderhead to lalaland;
	move gravy train to lalaland;
	move much flatter to lalaland;

this is the greater-ate rule:
	move Snap Decision to lalaland;
	move People Power to lalaland;

this is the wis-rec rule:
	move received wisdom to lalaland;

to unlock-verb (t - text):
	let j be indexed text;
	repeat through table of verb-unlocks:
		now j is "[brief entry]";
		if j matches the regular expression "[t]":
			prep-action j;
			if found entry is true:
				continue the action;
			if expound entry is true:
				if brief entry is "notice":
					ital-say "you've also unlocked NOTICE ADVANCE, to clear both the jerks and brothers on restart.";
				else:
					ital-say "you have just unlocked a new verb!";
					say "On restarting, you may now [descr entry][line break]";
			now found entry is true;
			write file of verb-unlocks from table of verb-unlocks;
			continue the action;
	say "BUG! I tried to add a verb for [t] but failed[if player is in freak control and accel-ending]. It's strongly likely that you have a saved file from version 2 of The Problems Compound, and you can/should just delete it. L[else]l[end if]Let me know at [email] as this should not have happened.";

to decide whether (t - text) is unlock-verified:
	repeat through table of verb-unlocks:
		if brief entry matches the regular expression "[t]":
			if found entry is false:
				if in-verbs is true:
					decide no;
				say "You don't seem to have unlocked [t in upper case] yet. Are you sure you wish to go ahead?";
				unless the player yes-consents:
					say "OK. You can try this again, if you want. There's no penalty.";
					decide no;
				say "Okay. You can undo this command if you change your mind.";
				now found entry is true;
			decide yes;
	decide no;

book people and things

crocking relates one thing to another.

a thing can be helpy. a thing is usually not helpy.

check taking a helpy thing:
	if number of carried helpy things > 0:
		say "You can only carry one item from the stall at a time." instead;

a room can be only-out. a room is usually not only-out.

a room can be cheat-surveyed. a room is usually not cheat-surveyed.

a room can be endfound. a room is usually not endfound.

a person can be surveyable, baiter-aligned, enforcing, or unaffected. a person is usually unaffected.

Procedural rule: ignore the print final score rule.

a thing can be abstract. a thing is usually not abstract.

a client is a kind of person. a client is usually male. a client can be specified. a client is usually not specified. a client has text called clue-letter. [specified = how to sort clients in the table]

a client can be minted. a client is usually not minted.

a client can be unordered or ordered. a client is usually unordered. [this is for sorting clients by whom you talk to]

before examining a client when know-jerks is false:
	say "They all seem so similar and intimidating right now." instead;

chapter misc defs for later

a concept is a kind of thing. description of a concept is usually "[bug]"

a concept has text called howto. howto of a concept is "(need text)".
a concept has text called gtxt.

a concept can be explained. a concept is usually not explained.

a drinkable is a kind of thing.
does the player mean drinking a drinkable: it is very likely.

a smokable is a kind of thing.

a hintable is a kind of thing.

a logic-game is a kind of thing. a logic-game has a number called times-won. times-won of a logic-game is usually 0. a logic-game has a number called max-won.

a logic-game can be tried. a logic-game is usually not tried.

volume stubs

section nicety stubs

[* screen reading space]

to say sr-space:
	if screen-read is true:
		say " ";

to say stwid:
	now allow-swears is whether or not allow-swears is false;

section rerouting verb tries

[* to make sure that the player is clued as to what they're doing wrong, too many words etc.]

the last-command is indexed text that varies.

understand "man/boy/dude/guy/fellow" as a person when the item described is male and the item described is not Alec Smart.
understand "woman/girl/lady" as a person when the item described is female.

allow-swears is a truth state that varies.

screen-read is a truth state that varies.

started-yet is a truth state that varies.

parser error flag is a truth state that varies.

Rule for printing a parser error when the latest parser error is the only understood as far as error:
	let nw be number of words in the player's command;
	if nw > 6:
		now nw is 6;
	say "That command seemed like it was longer than it needed to be. You may wish to cut a word or two down. Push 1 to retry [word number 1 in the player's command in upper case][if nw > 1], or a higher number to re-try only the first [nw] words of your command[end if]. Or just push any other key to try another command.";
	let Q be the chosen letter;
	d "[Q] vs 49 vs [48 + nw], [nw].";
	if Q >= 49 and Q <= 48 + nw: [since it's ascii, 49 = the number 1]
		now parser error flag is true;
		now the last-command is "[word number 1 in the player's command]";
		let temp be 50;
		while temp <= Q:
			now the last-command is "[the last-command] [word number temp - 48 in the player's command]";
			increment temp;
		say "OK, new command: [the last-command in upper case].";
		the rule succeeds;
	else:
		say "OK. If you change your mind, you can up-arrow and backspace to erase the last word.";
	the rule succeeds;

to cut-command-down:
	say "[line break]";
	now parser error flag is true;
	now the last-command is "[word number 1 in the player's command]";

Rule for reading a command when the parser error flag is true:
	d "Reading [last-command].";
	now the parser error flag is false;
	change the text of the player's command to the last-command.

section pronoun stubs

[* this is to say "it" for an item you receive]

to it-take (myt - a thing):
	now player has myt;
	set the pronoun it to myt;

section debug stubs

[* these all must be in release section since release code uses them trivially at points. Beta = for beta testers, Debug-state is my own debugging, stop-on-bug is for me in case something bad happens.]

in-beta is a truth state that varies.

debug-state is a truth state that varies. debug-state is false.

stop-on-bug is a truth state that varies. stop-on-bug is false.

to say bug:
	if debug-state is true:
		if stop-on-bug is true:
			say "OOPS! A programmer-testing-killing bug.";
			end the story;
	say "BUG! If you let me know at [email] or report the bug at [my-repo] I'd be grateful. If you can include [if currently transcripting]the current[else]a[end if] transcript, even better. Thanks, and sorry, though--you may get in my ABOUT section for finding this!";
	unless currently transcripting:
		say "You're not currently transcripting, but you can try to cut and paste text, or you can undo a few times, TRANSCRIPT and then redo."

to say email:
	say "blurglecruncheon@gmail.com";

to say my-repo:
	say "http://github.com/andrewschultz/the-problems-compound"

section printing exits

[* this is a heckish thing where we don't want to clue exits we programmatically need to "allow" like you can't go back to the Court of Contempt]

print-exits is a truth state that varies.

definition: a direction (called myd) is viable:
	if the player is in freak control:
		decide no;
	if the player is in round lounge:
		if myd is up:
			decide yes;
		decide no;
	if player is in tension surface:
		if myd is outside:
			decide no;
	if player is in pressure pier: [outer bounds]
		if myd is south:
			decide no;
	if player is in joint strip:
		if myd is south and Terry Sally is in lalaland:
			decide no;
	if player is in questions field :
		if myd is west and circular is not off-stage:
			decide no;
	if player is in scheme pyramid and contract-signed is false:
		if myd is north:
			decide no;
	if player is in idiot village:
		if player has bad face and idol is not in lalaland:
			if myd is east or myd is northeast:
				decide yes;
	if player is in service community:
		if noun is inside or noun is outside or noun is up or noun is down:
			decide no;
		decide yes;
	if the room myd of the location of the player is nowhere:
		decide no;
	decide yes;

exits-mentioned is a truth state that varies.

[after printing the locale description (this is the print exits rule) :
[	if number of viable directions is 0 and mrlp is not Dream Sequence:
		say "Uh-oh. You can't go anywhere. I goofed." instead;]
	if print-exits is true or mrlp is rejected rooms:
		if exits-mentioned is false:
			if number of viable directions is 0:
				say "No viable exits.";
			else:
				say "[if mrlp is not rejected rooms]List of exits[one of](toggle with PE)[or][stopping]: [end if]You can go [list of viable directions].";
			now exits-mentioned is true;
	continue the action;]

section peing

peing is an action out of world.

[* toggle displaying exits ]

understand the command "pe" as something new.

understand "pe" as peing.

carry out peing:
	now print-exits is whether or not print-exits is false;
	say "The Problems Compound now [if print-exits is true]displays[else]does not display[end if] exits in the upper left of the header[if screen-read is true]. EXITS may be a better option if you are using a screen reader, though[end if][if mrlp is rejected rooms and screen-read is false]. This information may be redundant for the Director's Cut section, but it'll be there back in the game proper[end if].";
	the rule succeeds;

section procedurality

[* this decides whether or not we should exclude from "instead of doing anything." Jumpiness = beginning warps, to avoid talking to Guy, and procedural stuff is stuff that has generic responses we should accept to break up conversation ]

to decide whether the action is jumpy:
	if figureacuting, yes;
	if knockharding, yes;
	if ducksitting, yes;
	if noticeadvanceing, yes;
	if fancypassing, yes;
	if trackbeatening, yes;
	no;

to decide whether the action is procedural: [aip]
	if examining, yes;
	if attacking, yes;
	if saying yes, yes;
	if saying no, yes;
	if dropping, yes;
	if looking, yes;
	if listening, yes;
	no;

to decide whether the action is undrastic:
	if examining, decide yes;
	if explaining, decide yes;
	decide no;

section shorthand regions

[* to save space on variables later ]

to decide what region is imr of (x - a thing):
	if x is off-stage:
		decide on nothing;
	decide on map region of location of x;

to decide what region is mrlp:
	decide on map region of location of player.

volume about the player

Alec Smart is a person. the player is Alec Smart.

check examining alec when accel-ending:
	if cookie-eaten is true:
		say "Well, you know looks don't matter now. You're pretty sure you can take either tack. 'Even a guy looking like ME can have confidence' or, well, just having confidence.[paragraph break]Still, probably above average. Yup." instead;
	else if greater-eaten is true:
		say "You look like you deserve to look better than you do, which is pretty good." instead;
	else if off-eaten is true:
		say "You scowl to yourself that looks don't matter, but you''d rather hang around people who scowl as much as you. Unless they're trying to imitate you." instead;

description of Alec Smart is "[one of]You, Alec Smart, are just sort of average looking. You hope. You guess. But you know people who think they're average are below average, whether or not they know that bit of research.[paragraph break]In any case, looking at yourself tends to make you over-think, and you have enough thinking to do[or]You hope you're un-ugly enough to be a likable everyteen. Others take worse heat for their looks. Not that that makes you feel better[stopping]. You are pretty sure you've got a [if player has bad face]bad face[else]face of loss[end if] on."

volume actions

book meta verbs already in game

report restoring the game:
	say "Story restore![paragraph break]";
	continue the action;

book redefining verbs

chapter yes no

the block saying no rule is not listed in any rulebook.
the block saying yes rule is not listed in any rulebook.

instead of saying no:
	say "[no-yes]"

instead of saying yes:
	say "[no-yes]"

yes-yet is a truth state that varies.

to say no-yes:
	let ono be true;
	if current action is saying yes:
		now ono is false;
	if accel-ending:
		say "[if ono is true]You reject several pointless actions you were never going to do anyway. It feels good[else]Yeah. You feel more confident, now[end if].";
		continue the action;
	if player is in pot chamber:
		say "Nancy Reagan would be [if ono is true]proud[else]ashamed[end if].";
		continue the action;
	if not-conversing:
		say "You always feel pushed around being asked a yes-or-no question. Like you can't say what you really want to say, not that you were sure anyway (you don't need to say yes or no here, but you can RECAP to see a list of options).";
	else:
		say "[one of]You freeze up. Was that a rhetorical question just now? Where did it come from? [or][stopping]Your nos and yesses never quiiite meant what they hoped to mean. Sometimes it's a relief not to be forced to say an essay, but other times--man, others seem to be better with those short words than you are.";
	if yes-yet is false:
		now yes-yet is true;
		say "[bracket]NOTE: you don't need to answer rhetorical questions, and I tried to avoid them, but characters may ask you a few.[close bracket][line break]";

chapter cutting

the block cutting rule is not listed in any rulebook.

before cutting:
	if noun is worm:
		say "Its outside shell is too hard. Maybe work at it from the inside, or metaphorically." instead;
	if noun is caps:
		say "You need to transform the hammer so it can break the lock caps." instead;
	if noun is wax:
		say "You're not terribly musical. Well, you're not down with funky music." instead;
	if noun is a person:
		say "You don't have any sharp objects, and cutting someone down verbally is out." instead;
	if noun is scenery and player is in freak control:
		try attacking noun instead;
	say "You have nothing with which to [activation of cut a deal]." instead;

chapter throwing at

the futile to throw things at inanimate objects rule is not listed in any rulebook.
the block throwing at rule is not listed in any rulebook.

check throwing it at:
	if second noun is hatch:
		if player is on chair:
			say "You don't need to throw it--you can just take a good swing!";
			try attacking hatch instead;
		say "Thunk! The [noun] hits the hatch, which wobbles a bit, but doesn't jar it loose. As you pick it up, you wonder[one of][or] again[stopping]: you could--but maybe if you were a bit closer..." instead;
	if second noun is chair:
		say "The chair isn't blocking your way. The hatch is." instead;
	say "Throwing stuff generally won't work in this game."

chapter score

to decide what number is abc:
	decide on the number of people in lalaland;

the maximum score is 18.

maximum-maximum is a number that varies. maximum-maximum is 21.

opt-yet is a truth state that varies.

to inc-max:
	increment maximum score;
	increment the score;
	now the last notified score is the score;
	if opt-yet is false:
		ital-say "You just found an optional point that may help get the very best ending. There are [maximum-maximum - maximum score] left[terminal-2].";
		now opt-yet is true;
	else if maximum score < maximum-maximum:
		ital-say "That's another optional point. Good going[terminal-2].";

to say terminal-2:
	if player is in the belt below:
		say ". Also, I got the idea for this puzzle from something else even tougher and more clever. XP TERMINAL to see the details";

check requesting the score:
	if greater-eaten is true:
		say "You're more worried about scoring points with the right people than in some silly game." instead;
	if cookie-eaten is true:
		say "It's probably pretty good, but you're too cool for numbery nonsense." instead;
	if off-eaten is true:
		say "Oh man. You don't need yet another number assigned to your performance." instead;
	if greater-eaten is true:
		say "Whatever your score is, you have intangibles above that." instead;
	if mrlp is rejected rooms:
		let uan be number of unvisited rooms in mrlp;
		say "You have [uan in words] rejected room[if uan is not 1]s[end if] to visit here (JUMP back once you're finished,) and ";
		if window bay is unvisited:
			say "you haven't found the place that lets you see the hidden ones and the fake-bad-end scenes.";
		else:
			say "you've seen [number of visited rooms in just ideas now in words] rooms in the view of points.";
		the rule succeeds;
	if player is in smart street:
		say "You don't need to worry about score yet. You've just got here." instead;
	if player is in round lounge:
		say "Score isn't as important as finding a way out. So you could say you've got 0 for 1 right now." instead;
	if mrlp is beginning:
		if tension surface is visited and variety garden is visited:
			say "You need to go forward from the tension surface somehow." instead;
		say "You've got a task or two, but still not enough to really keep score of what you're doing yet." instead;
	if mrlp is Dream Sequence:
		say "This is one of those nightmares where your score may be negative, if that's possible." instead;
	if mrlp is outer:
		if Terry Sally is not in lalaland:
			if your-tix is 4:
				say "The trail paper is probably what Terry Sally wants." instead;
			if your-tix > 0:
				say "You have [your-tix in words] of the four boo-ticketies you need." instead;
			say "You need to go looking for trouble. I mean, not too much, but enough to show you're not square." instead;
	say "You have scored [score] point[if score is not 1]s[end if] and need [maximum score] to win[if maximum score < maximum-maximum], or [maximum-maximum] for[else] with[end if] the best ending";
	if number of map-pinged rooms > 1:
		say ", and you've also been to [number of map-pinged rooms] or [number of rooms in bad ends] rooms";
	say ".";
	say "[line break]";
	if player is in out mist:
		say "You need to modify the worm ring somehow." instead;
	if player is in airy station:
		say "You need to modify the hammer somehow." instead;
	if Questions Field is unvisited:
		say "You haven't gotten near the [bad-guy]'s hideout yet. So maybe you need to explore a bit more." instead;
	if qp-hint is true and quiz pop is not in lalaland:
		say "You need some way to get past the question/exclamation mark guard combination. It's like--I don't know. A big ol['] pop quiz or something." instead;
	if player has crocked half and thoughts idol is not in lalaland:
		say "You haven't found what the crocked half's clue is, either." instead;
	if player is in freak control:
		say "[if qbc_litany is table of no conversation]You need to get the [bad-guy]'s attention somehow[else]Don't worry. There's no way to 'lose' this conversation[end if].";
	if bros-left is 0 and boris is in lalaland:
		say "You've helped the Brothers and [j-co]. It's time to meet the [bad-guy][if score < 20 and player does not have legend of stuff], unless you want to take care of a few special things first[end if]." instead;
	say "You have currently helped [if bros-left is 3]none[else if bros-left is 0]all[else][3 - bros-left in words][end if] of the Keeper Brothers[if idol is in lalaland], and you've rid Idiot Village of the Thoughts Idol, too![else].[end if]";
	if number of endfound rooms > 0:
		say "Also, if you're keeping track of that sort of thing, you've found [number of endfound rooms] bad end[if number of endfound rooms is not 1]s[end if] out of [number of rooms in Bad Ends]: [list of endfound rooms]." instead;
	the rule succeeds;

chapter waking verb

the block waking rule is not listed in any rulebook.
the block waking up rule is not listed in any rulebook.

before waking:
	if noun is not player:
		say "You can't wake anyone else up." instead;
	try waking up instead;

before waking up:
	if mrlp is dream sequence:
		say "[one of]As you wake up, someone walks by and mentions how people who sleep on benches just encourage robbers, and if they had nothing worth taking, that's lazy too[or]You wake up, expecting that horrible person from the first time, again, but there's nothing[stopping].";
		leave-dream;
		the rule succeeds;
	say "This is dream-ish, but no, you're not dreaming. Even if you were, that never works in your dreams. Something horrible happens first, and then you wake up." instead;

to leave-dream:
	now last-dream-loc is location of player;
	move player to Warmer Bench;
	if location of face of loss is bullpen: [this is a bad hack but it sort of needs to be done]
		now player has face of loss;
	if location of bad face is bullpen: [this is a bad hack but it sort of needs to be done]
		now player has bad face;
	if location of opener eye is bullpen: [this is a bad hack but it sort of needs to be done]
		now player has opener eye;
	if location of lifted face is bullpen: [this is a bad hack but it sort of needs to be done]
		now player has lifted face;
	repeat with Q running through things in bullpen:
		now player has Q;

chapter waiting

check waiting (this is the caught napping rule):
	if p-c is true:
		say "Percy takes a pause, too." instead;
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if player is in down ground and slept-through is false:
		say "[one of]You attempt to loiter in this seedy area in order to get in trouble or something, but no dice.[or]Still, nobody comes to break up your loitering.[or]You reflect if you want to get zapped for loitering, maybe you need to do better than just hang around.[or]Hm, you wonder what is even lazier than standing around.[stopping]" instead;
	if player is in Meal Square:
		say "You wait, but [activation of loaf around] fails to appear." instead; [temproom meal square]
	if player is in Joint Strip:
		say "With the Stool Toad around, you fear a booming [activation of do dope]!" instead; [temproom joint strip]
	if player is in Soda Club:
		say "Er, be." instead;
	if player is in airy station:
		say "The mentality crowd cheers some more! They're glad you don't want to leave right away, and they know you'll figure what to do with the hammer, eventually." instead;
	say "[activation of wait your turn]." instead;

every turn when player is in tense past and tense present is not visited:
	say "Torpor. You can't do much besides LOOK or WAIT or THINK.";

to move-dream-ahead:
	say "You let the dream sequence take its course. As usual, time spins out of control for you.";
	if player is in tense present:
		now player is in tense future;
	else if player is in tense future:
		now player is in tense past;
		increment nar-count;
		if nar-count > number of rows in table of sleep stories:
			now nar-count is 1;
	else if player is in tense past:
		now player is in tense present;
	else:
		say "BUG. You should be moved somewhere else.";

slept-through is a truth state that varies.

chapter burning

the block burning rule is not listed in any rulebook.

check burning:
	if player is in judgment pass:
		say "You have no matches with which to, err, [activation of pass the torch]. Ha ha." instead; [temproom judgment pass]
	if noun is poory pot:
		say "You don't have any matches. Or guts to try even the mild stuff." instead;
	if noun is wacker weed:
		say "You don't have any matches. Or guts to defy Pusher Penn." instead;
	say "You have neither matches nor pyromaniac desires." instead;

chapter dropping

drop-warn is a truth state that varies.

rule for deciding whether all includes a thing when dropping:
	now drop-warn is true;
	it does not;

check dropping opener eye:
	say "You can't un-know what you learned from the [bad-eaten]." instead;

check dropping face of loss:
	say "You're frowning enough, probably, why make it worse?" instead;

check dropping smokable:
	say "[activation of roach dropping] would be really, really unsanitary here." instead; [temproom pot chamber]

check dropping bad face:
	say "You wonder if you should drop the act, but--it may not be a total act any more." instead;

check dropping gesture token:
	say "It seems worthless, but you never know. Anyway, it's harmless at worst in your pocket." instead;

check dropping when player is in Round Lounge:
	if noun is off tee:
		say "But you made it with your own hands! It must be useful for something. You hope." instead;
	if noun is stick or noun is screw:
		say "You can't think of any reason to drop that. It seems no better or worse than the [if noun is screw]stick[else]screw[end if] to help you get out of here." instead;

check dropping the proof of burden:
	say "No. There's a part of you that always sort of believed what the proof said, even if it's said kind of snide. Most of the time, you just hear disbelief you're smart and you can't deal, but there may be help here." instead;

check dropping boo tickety:
	if drop-ticket is false:
		now drop-ticket is true;
		say "As you drop the ticket, you feel a tap on your shoulder. The Stool Toad, again![paragraph break]'Son, I'm going to have to write you up.' And he does. [if your-tix is 4]And he notices your status as a repeat offender, mumbling that's a stupid way to push him over the edge![else]He gives you what you've dropped, plus a new boo tickety.[end if]";
		get-ticketed "dropping a ticket you had";
		do nothing instead;
	else:
		say "Either the Stool Toad will have given up on you, or he'll really get to bust you for a repeat offense. Neither seems to help you." instead;

check dropping long string:
	if player is in disposed well:
		say "(dropping it down the well)[line break]";
		try inserting long string into yards hole instead;

check dropping (this is the general dropping rule):
	if noun is pocket pick:
		say "'Aw, c'mon,' you hear the Word Weasel say, in your head[if player is in variety garden]. You think it was in your head[end if]." instead;
	if noun is dreadful penny:
		say "The penny doesn't drop on any puzzle you want to solve." instead;
	if noun is minimum bear:
		say "No. It's just cute enough not to abandon[if your-tix < 4 and litter-clue is true], and dropping it wouldn't feel like LITTERING[end if]. It's somebody's. But whose?" instead;
	if noun is trail paper:
		say "No way. You should return that to Terry Sally!" instead;
	if noun is cooler or noun is haha:
		if your-tix >= 4:
			say "Now you're living on the edge with four ticketies, you're confident you can get away with dropping a drink to avoid getting busted by the Stool Toad.";
			now noun is in lalaland instead;
		if Erin is in lalaland:
			say "You don't want to drink it, and nobody else seems to want it. So you throw it away, instead.";
			now noun is in lalaland instead;
	if noun is story fish:
		say "Maybe you could PLAY it at the right moment to annoy someone who deserves it." instead;
	if noun is mind of peace or noun is relief light or noun is trade of tricks:
		say "No! This is too valuable. It might not be yours, but someone can use it." instead;
	if noun is cold contract:
		say "It's yours. You're bound to [if contract-signed is true]it [']til you sign it or find someone who can[else]return it, now it's signed[end if]. The Labor Child has records in triplicate." instead;
	if noun is money seed:
		say "It'd vanish." instead;
	if noun is sound safe:
		say "It'd probably make a terrible clang." instead;
	if noun is reasoning circular:
		say "You don't want to drop it because it is probably valuable, and it's probably valuable because you don't want to drop it." instead;
	if noun is a smokable:
		say "Your fingerprints would be on it, and you'd probably get busted." instead;
	if noun is poetic wax:
		say "It'd be tough to wipe off your fingers, and it'd be a mess just lying around." instead;
	if noun is fourth-blossom:
		say "It would probably die, not being whole." instead;
	if noun is legend of stuff:
		say "It just won't let you. Weird." instead;
	if noun is crocked half:
		say "Nah, why litter." instead;
	if noun is rattle:
		if player is in truth home:
			say "It'd make a bit of noise that way, but not enough." instead;
		say "You'd like to ditch the rattle, but you wonder if it might annoy someone else even more." instead;
	say "You don't need to leave anything lying around. In fact, you shouldn't[if your-tix < 4 and litter-clue is true], unless you want to annoy authority figures who may not actually care about the environment anyway[end if]." instead;

chapter buying

the block buying rule is not listed in any rulebook.

understand "buy [text]" as a mistake ("If you want a[n-dr] drink, you'll need to talk to Ally Stout.") when player is in Soda Club.

to say n-dr:
	say "[if cooler is in lalaland or brew is in lalaland]nother[end if]"

check buying:
	if noun is officer petty:
		say "He can probably be paid off, but the question is, with what?" instead;
	if noun is stool toad:
		say "He can probably be paid off, but not by you." instead;
	if noun is female:
		say "Just the suggestion is horrible. Really. I felt skanky even coding this reject." instead;
	if noun is a person:
		say "Everyone seems richer than you. Anyway, you always sort of hated politicians buying stuff." instead;
	if noun is baiter master:
		say "His currency is flattery, which you can't do right." instead;
	if noun is a logic-game:
		say "'Nonsense! And deprive the next person who needs help? Besides, you'd get bored of it. Unless you're REALLY lame.'" instead;
	say "You might need to GIVE someone an item to get something, but BUYing is not necessary." instead;

chapter burning

the block burning rule is not listed in any rulebook.

understand the command "smoke" as something new.

understand "smoke [something]" as burning.

check burning:
	if noun is a smokable:
		if player is in temper keep and noun is poory pot:
			say "Might be better to get the pot into the room's air flow somehow." instead;
		say "Even if you had something to light it with, which you don't and won't, you know you apparently need to keep the smoke in longer than a real cigarette. Too much. Anyway, the Compound has been trippy enough" instead;
	say "A fit of pyromania won't exactly set the Compound on fire, especially since you don't have--and won't find--the tools." instead;

smoking is an action applying to one thing.

understand "smoke with [person]" as smoking.

check smoking:
	if noun is fritz:
		if player has weed:
			say "You'll probably want to GIVE the weed to Fritz." instead;
		if weed is off-stage:
			say "Nothing to smoke." instead;
		say "Pusher Penn only gave him enough for one person. Plus, you'd probably do it wrong." instead;
	if noun is pusher penn:
		say "The acute social observer Oshea Jackson once posited that the main barriers to success for someone in Pusher Penn's position was getting high off one's own supply." instead;
	if noun is enforcing:
		say "That's a bad idea. For your health and your freedom." instead;

chapter jumping

jump-from-room is a room that varies. jump-from-room is Smart Street.

jump-to-room is a room that varies. jump-to-room is One Route.

instead of jumping:
	if player is in round lounge:
		if player is on person chair:
			say "[ev-ju]You're actually worried you might hit your head on the ceiling. You consider jumping to grab the crack in the hatch and swing it open Indiana Jones style, but...no. You'd need to push it open a bit more first[one of].[paragraph break]NOTE: if you want to jump off, just EXIT or DOWN works[or][stopping]." instead;
		say "[ev-ju]You jump for the hatch, but you don't get close." instead;
	if player is in tension surface:
		say "[ev-ju][if mush is in lalaland]You can just enter the arch[else]No, it's too far to jump over the mouth[end if]." instead;
	if player is in disposed well:
		if anno-allow is true:
			say "No, not in the well. To somewhere far away.[paragraph break]";
		else:
			try entering yards hole instead;
	if anno-allow is true:
		if accel-ending:
			say "That [bad-eaten] you ate was enough of a mental jump. You don't have time for silly details--well, not until you restart the game." instead;
		say "[one of]You jump farther than you could've imagined[or]You've got the hang of jumping, now[stopping].";
		if mrlp is Rejected:
			now jump-to-room is location of player;
			move player to jump-from-room;
		else:
			now jump-from-room is location of player;
			move player to jump-to-room;
		the rule succeeds;
	let any-jumps be false;
	repeat through table of vu:
		if jumpable entry is true:
			if any-jumps is false:
				say "You can make the following jumps[if player is not in smart street] on restart[end if]:[line break]";
				now any-jumps is true;
			say "[2da][descr entry][line break]";
	if any-jumps is false:
		say "You're not ready to form hasty conclusions."

to say ev-ju:
	if anno-allow is true:
		say "(JUMPing to the director's cut is blocked here due to in--game hinting. The rooms beyond, and to either side of, Tension Surface should all be okay.)[paragraph break]";

chapter thinking

think-score is a truth state that varies.

instead of thinking:
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if finger index is examined and silly boris is in Nominal Fen:
		say "Hmm. You remember the finger index[if know-jerks is true] and the seven [j-co], [list of clients in nominal fen][end if].";
		say "[finger-say]." instead;
	if think-score is false:
		say "NOTE: THINK will redirect to SCORE in the future, unless you really only have one specific task remaining.[paragraph break]";
		now think-score is true;
	say "[one of]You take a [activation of second thought]. Then you take another, but you reflect it wasn't as good. OR WAS IT? So you just[or]You[stopping] think about what you've accomplished...";
	try requesting the score instead;

pot-not-weed is a truth state that varies.

chapter waving

the block waving hands rule is not listed in any rulebook.

understand the command "wave [something]" as something new.

carry out waving hands:
	say "You [activation of wave a flag] as ineffective--yours never achieved the gravitas others['] seemed to have.";
	the rule succeeds;

chapter swearing

understand the commands "cuss" and "curse" and "swear" as something new.
understand "cuss" and "curse" and "swear" as swearing obscenely when allow-swears is true.
understand "cuss" and "curse" and "swear" as swearing mildly when allow-swears is false.

big-swear is a truth state that varies.

instead of swearing mildly:
	now big-swear is false;
	try do-swearing;

instead of swearing obscenely:
	now big-swear is true;
	try do-swearing;

do-swearing is an action applying to nothing.

toad-swear is a truth state that varies.

hypoc-swear is a number that varies.

petty-swear is a truth state that varies.

carry out do-swearing:
	unless accel-ending:
		if hypoc-swear is 0:
			say "A voice in your head reminds you of your gross, gross hypocrisy in swearing when you opted for no profanity, but dang it, you're confused and frustrated.[paragraph break]";
		else if hypoc-swear is 1:
			say "The 'hypocrisy' of swearing feels a bit less, now. Yes, you're allowed to change your mind. And...well...you know how people can manipulate with the threat of a swear, or saying, don't make me swear.[paragraph break]";
		else:
			say "It's almost getting a bit boring breaking the rules again.";
		if hypoc-swear < 2:
			increment hypoc-swear;
	if player is in Soda Club:
		say "You reckon that's how people are supposed to cuss in a bar, er, club, but you can't give that word the right oomph." instead;
	if player is in Classic Cult:
		say "That'd be extra rude in a place like this." instead;
	if player is in chipper wood and Cute Percy is in chipper wood:
		say "Percy smirks[if p-c is true]. 'That won't do any good!'[else].[end if]" instead;
	if player is in belt and terminal is in belt:
		say "Sorry, man. I didn't mean for it to be THIS hard." instead;
	if player is in joint strip:
		if toad-swear is false:
			now toad-swear is true;
			say "'It's a damn shame. Kids thinking they're tougher than they are. I had a lot more to swear ABOUT when I was a kid.'" instead;
		say "'Repeat offender? Cutting up for the fun of it? Off you go!'";
		ship-off in-dignity heap instead;
	if player is in judgment pass and officer petty is in judgment pass:
		if petty-swear is false:
			now petty-swear is true;
			say "'You get one of those, kid. One more than you deserve.'" instead;
		say "'It's a damn shame, kid probably scared of doing anything useful, can't even understand a warning.'";
		ship-off in-dignity heap instead;
	if player is in idiot village or player is in service community:
		if thoughts idol is in idiot village:
			say "Before you can say it, or think it too long, the Thoughts Idol shakes its head at you." instead;
	if player is in freak control:
		say "That gets the [bad-guy]'s attention. 'DUDE!' he says. 'REALLY, dude! Some respect for authority? I mean, don't respect stupid authority but I *** need to *** concentrate, here. My job's not *** easy and anyone who just swears frivolously to grab attention--well, they don't GET IT, y'know? Besides, you sounded lame when you said that.' As you're pulled away by guards you hadn't seen before, the '[activation of freak out]' sign catches your eye. Perhaps there was another way to annoy him, without letting him be so self-righteous."; [temproom freak control]
		ship-off in-dignity heap instead;
	if mrlp is endings:
		say "Don't give up! You're so close!" instead;
	if big-swear is false:
		say "That's a wishy-washy swear--it wouldn't seem to do you any good if you [if allow-swears is true]dis[else]en[end if]abled profanity in this game." instead;
	say "[if allow-swears is false]You mumble a swear under your breath, remembering full well you didn't want to hear it from others[else]Much as you'd like it to, your profanity has no oomph[end if]." instead;

chapter thinking

check thinking:
	say "Whenever you think, a voice in your head is sort of like a tax. 'You better think straight! Don't let your mind wander!'" instead;

chapter sleeping

the block sleeping rule is not listed in any rulebook.

understand the command "lie" and "lie down" as something new.
understand "lie" and "lie down" as sleeping.

check sleeping:
	tick-up;
	if mrlp is Dream Sequence:
		say "You already are. You may want to wake up, instead. Or maybe if you wait, things will shift." instead;
	if player is on warmer bench:
		say "The bench feels good. You drift [if last-dream-loc is visited]back [end if]off.";
		go-to-dream;
		the rule succeeds;
	if player is in Down Ground:
		say "You feel especially apathetic here. Yes, it's a good place to drift off[if slept-through is true], with no chance of another [activation of dream ticket][end if]."; [temproom down ground]
		if last-dream-loc is visited:
			say "[line break]You slip back into the old dream.";
		go-to-dream;
		the rule succeeds;
	if mrlp is Beginning and Variety Garden is visited:
		say "Man! It's almost too comfy here... when you wake up, a weird frog-shaped humanoid is shaking you. 'Boy! Some of [']em never get this far! Coulda died of cold, or laziness-related poverty or -- well, something. But there's a place for you, where you'll LEARN from this.'";
		ship-off Maintenance High;
		the rule succeeds;
	if mrlp is rejected rooms:
		say "Oh no, this extra material isn't THAT boring, is it?" instead;
	if player is in classic cult:
		say "It's relaxing here, but not that relaxing." instead;
	if player is in temper keep and sal-sleepy is true:
		say "You don't want to join Sal." instead;
	if player is in truth home and Sid Lew is in truth home:
		say "Tough with all that noise." instead;
	if Down Ground is unvisited and jump-level < 2:
		say "You're nowhere near tired. You're curious what could be ahead." instead;
	if player is in A Great Den:
		say "The crib's too small for sleeping." instead;
	if player is in freak control:
		say "But the excitement is close!" instead;
	if player is in service community:
		say "Not with the idol staring you down!" instead;
	if player is in out mist:
		say "Maybe sleep and your bedroom are just ahead." instead;
	if player is in airy station:
		say "Too much adulation is tiring, but not that tiring." instead;
	say "This doesn't look like the place to retreat for a nap. In fact, not many places do." instead;

to go-to-dream:
	now all carried things are in bullpen;
	now all worn things are in bullpen;
	move player to last-dream-loc;

chapter pushing and pulling

the can't push what's fixed in place rule is not listed in any rulebook.
the can't pull what's fixed in place rule is not listed in any rulebook.

the can't push scenery rule is not listed in any rulebook.
the can't push people rule is not listed in any rulebook.

the can't pull scenery rule is not listed in any rulebook.
the can't pull people rule is not listed in any rulebook.

a thing can be push-to-pull. a thing is usually push-to-pull.

Alec Smart is not push-to-pull.

pulledfirst is a truth state that varies.

check pulling:
	if noun is alec smart:
		say "You've been pulling yourself apart mentally enough." instead;
	if noun is push-to-pull:
		now pulledfirst is true;
		try pushing noun instead;
	say "[im-im]pull." instead; [this shouldn't happen]

check pushing:
	if noun is alec smart:
		say "Pushy people do say you don't push yourself enough." instead;
	if noun is ring:
		say "Ring [push-pull], [push-pull] ring... no, you need to do something else to the ring.";
	else if noun is a person:
		say "Physical force will work out poorly.";
	else if noun is vent:
		try opening vent;
	else:
		say "[im-im][push-pull].";
	now pulledfirst is false;
	the rule succeeds;

to say push-pull:
	say "[if pulledfirst is true]pull[else]push[end if]";

chapter taking

the can't take what's fixed in place rule is not listed in any rulebook.

the can't take scenery rule is not listed in any rulebook.

before taking a person:
	if noun is weasel:
		say "It is too small and mobile." instead;
	if noun is monkey:
		say "It neither needs or deserves that." instead;
	say "You're not strong enough for the sort of WWF moves required to move a person." instead;

check taking:
	if noun is tray a or noun is tray b:
		say "Man. It's heavy. That might cause a [activation of strike a balance]." instead; [temproom meal square]
	if noun is scenery or noun is fixed in place:
		if noun is in freak control:
			say "Vandalism, while direct, won't get rid of the guy running all the machines here." instead;
		say "[im-im]take." instead;

to say im-im:
	say "That's either impractical or impossible, or both, to "

chapter climbing

Understand "climb on [something]" as climbing.

the block climbing rule is not listed in any rulebook.

check climbing:
	if noun is chase paper or noun is hatch or noun is person chair:
		try entering noun instead;
	if noun is intuition counter:
		say "[if petty is in judgment pass]Oh, Officer Petty would get you for that one![else][one of]You climb on the Intuition Counter, and suddenly, stuff that seemed clear for years is all muddled and confused. You quickly step down, and your thoughts return to normal.[or]No way. Not again.[stopping]" instead;
	if noun is the nine yards hole:
		say "No footholds or handholds. You'd be stuck.";
	if noun is fright stage:
		say "[if dutch is in speaking plain]There's not room enough for you. Well, there is, but you'd get shouted down quickly. It's not that tall, but it's still a [activation of platform shoes].[else]You're too busy to shout platitudes right now. You could do better than Uncle Dutch and Turk Young, but really, you're thinking bigger than that[end if]." instead; [temproom speaking plain]
	if noun is thoughts idol:
		say "No way. It probably has weird rays and stuff. Or anti-weird rays." instead;
	if location of player is round lounge:
		say "Hm. Maybe. You need to get up somehow, but you seem to need a tool or tools." instead;
	say "You don't need to climb a lot here. Or, really, at all." instead;

check entering fright stage:
	try climbing fright stage instead;

chapter tying

the block tying rule is not listed in any rulebook.

check tying it to:
	if noun is second noun:
		if noun is boo tickety:
			say "You can fold them together once you have enough pieces." instead;
		say "Tautology." instead;
	if second noun is hole:
		try tying noun to stick instead;
	if noun is hole:
		try tying stick to second noun instead;
	if noun is long string or second noun is long string:
		say "The string seems to resist being tied into knots. [if fish is off-stage]Perhaps it is useful more as a lure[else]It seemed to work more as a lure to get the fish[end if]." instead;
	if noun is stick and second noun is screw:
		make-tee instead;
	if noun is screw and second noun is stick:
		make-tee instead;
	if noun is screw and second noun is hole: [shouldnt be necessary any more]
		make-tee instead;
	if noun is hole and second noun is screw:
		make-tee instead;
	if noun is off tee and second noun is hatch:
		try attacking hatch instead;
	if noun is hatch and second noun is off tee:
		try attacking hatch instead;
	if second noun is tray a or second noun is tray b:
		say "[if noun is edible]You don't need to put food back on the trays[else]Only food belongs on the trays[end if]." instead;
	say "That doesn't seem to work." instead;

does the player mean putting it on tray a: it is likely.

chapter smelling

the block smelling rule is not listed in any rulebook.

before smelling when accel-ending:
	say "You give a disdainful sniff." instead;

check smelling (this is the smelling a thing rule):
	if noun is the player:
		say "That never works. People who smell bad are used to their own smells, but if you're caught sniffing yourself, whew." instead;
	if noun is a client:
		say "[one of]You can't quite catch it--wait--[activation of liverwurst]. But of course[or]Liverwurst, still[stopping][if condition mint is not in lalaland]. Boy, you always need a pill or something after eating that[end if]." instead; [temproom nominal fen]
	if noun is poor dirt:
		say "The dirt doesn't smell of anything much." instead;
	if noun is poetic wax:
		say "You're sure you've smelled it before, and it's good and bad and a bit beyond you." instead;
	if noun is flower wall:
		say "Smells nice. Cancels out the [if earth of salt is in Vision Tunnel]now-gone salt[else]salt, almost[end if]." instead;
	if noun is mouth mush or noun is earth of salt:
		say "It doesn't smell horrible, though you don't have a very [activation of nose picking]." instead; [temproom tension surface]
	if noun is fritz:
		say "You'd rather not risk it." instead;
	if noun is bear:
		say "It smells kind of dirty." instead;
	if noun is poory pot:
		say "It smells like some cheap air freshener you bought once." instead;
	if noun is wacker weed:
		say "It doesn't smell dangerous to brain cells, but it is." instead;
	if noun is tray a:
		say "Not distinctive, but Tray B..." instead;
	if noun is tray b:
		say "It smells like a [activation of house special] you remember. Not good special." instead; [temproom meal square]
	if noun is fish:
		say "The story fish is thankfully not organic enough to stink, or boy, WOULD it." instead;
	if noun is a person:
		say "You've had people give YOU the smell test, but somehow, even when you passed, you still failed." instead;

check smelling (this is the smelling a place rule): [see above for people]
	if player is in Nominal Fen:
		if silly boris is in lalaland:
			say "No more queasy smell." instead;
		try smelling silly boris instead;
	if player is in down ground:
		say "It smells okay here, but maybe that's because you're not too close to Fritz the On." instead;
	if player is in temper keep:
		say "[if sal-sleepy is false]You can understand why Volatile Sal is upset about smells, but you don't understand why he thinks it's other people.[else]Much nicer now with the poory pot in the vent.[end if]" instead;
	if player is in joint strip:
		say "It smells like [activation of killer weed], which strangely (or not) hasn't been effective on the stickweed.[paragraph break][if off-the-path is true]But you can't go off the path again with the Stool Toad watching you[else]You're tempted to check what's off the path, to the north or east[end if]." instead; [temproom joint strip]
	if player is in pressure pier:
		say "A faint smell of various foods to the west." instead;
	if player is in meal square:
		say "So many foods mix here, it's hard to pick anything individually. Overall, smells pretty nice, though." instead;
	if player is in soda club:
		say "Faint cologne and perfume. Enough to make you cringe, but you've heard bars can smell worse. Though you know nothing about fragrances. I mean, you use deodorant and all, but..." instead;
	if player is in classic cult:
		say "Nice and floral. Almost too nice. Is this part of how they sucker people in?" instead;
	if player is in court of contempt:
		say "Buddy Best sniffs back, louder." instead;
	if player is in speaking plain:
		say "The advice you're hearing thankfully only stinks metaphorically." instead;
	if player is in pot chamber:
		say "You take a whiff, against your better judgement, but it doesn't smell like sewage. Whew. In fact, it smells less weird than the Joint Strip." instead;
	if player is in freak control:
		say "Unusually sterile." instead;
	if player is in discussion block:
		say "You try to sniff and have Big Opinions about art, but it's too hard." instead;
	say "Nothing really smells too bad. You worry for a second it's because nothing smells worse than you." instead;

chapter looking

chapter listening

the block listening rule is not listed in any rulebook.

before listening when accel-ending:
	say "You've had enough of meekly listening to others. You'll be listening to yourself from now on." instead;

check listening (this is the listening to a thing rule):
	if noun is jerks:
		say "The [j-co] babble on about random [activation of junk mail]. It just piles up!" instead; [temproom nominal fen]
	if noun is fritz:
		say "Fritz mumbles to himself [if fritz has wacker weed]about buying a fancy [activation of clip joint] to not waste ANY leaves[else if Nominal Fen is visited]about being [activation of high and dry][else if fritz has bear]a bit more happily now he has minimum bear[else]nervously[end if]." instead; [temproom down ground]
	if noun is stool toad:
		say "The Stool Toad gives a few tch-tch-tches under his breath." instead;
	if noun is Cute Percy:
		say "Now that you appear to be listening, Percy is quiet." instead;
	if noun is petty:
		say "Officer Petty gives off the occasional HMPH." instead;
	if noun is labor child:
		say "The Labor Child yacks into an unseen headpiece." instead;
	if noun is a person:
		say "Maybe you should TALK TO them instead." instead;

jerk-close-listen is a truth state that varies.

check listening (this is the listening in a place rule):
	if qbc_litany is table of generic-jerk talk:
		now jerk-close-listen is true;
		say "You listen in a bit closer, so if your accusations disquieted the [j-co] enough, you'll know." instead;
	if player is in chipper wood:
		if Cute Percy is in chipper wood:
			try listening to Cute Percy instead;
	if player is in Classic Cult:
		say "That stereotypical 'OM' noise which fools nobody any more. The Goodes pretty clearly haven't taken any marketing clues from any big televangelist, and they seem happy just helping people feel at ease." instead;
	if player is in idiot village:
		say "You hear a faint duh-duh-duh. But wait a minute. Maybe it's there to ward off people who think they're a little too smart, and Idiot Village is not so stupid after all." instead;
	if player is in Nominal Fen and Silly Boris is in Nominal Fen:
		say "Hard not to listen.";
		the rule succeeds;
	if player is in Tension Surface and mush is in Tension Surface:
		say "The arch makes a slight tapping noise as it dances from side to side." instead;
	if player is in Soda Club:
		say "Under some [one of]punk[or]New Wave[or]Disco[or]oldies[or]popular[or]alternative[or]classical[in random order] tune you really should know, you think you hear some really hearty arguments about really dumb stuff." instead;
	if player is in scheme pyramid:
		try listening to labor child instead;
	if player is in joint strip:
		try listening to stool toad instead;
	if player is in judgment and petty is in judgment:
		try listening to petty instead;
	if player is in speaking plain and dutch is in speaking plain:
		say "Hard NOT to listen to Dutch and Turk, really." instead;
	if player is in truth home and Sid Lew is in truth home:
		say "[one of]'See there, Lee Bull? This guy sits and listens. Right?' Before you can agree, Sid Lew continues. Strictly speaking, everything he says is true, but he tends to weight this or that more than he should...[or]Sid Lew continues to spew truths, with his own unique weighting of what is important.[stopping]" instead;
	if player is in Discussion Block:
		if phil is in Discussion Block:
			say "[one of]M[or]More m[stopping]usic from the song torch!";
			try examining song torch instead;
	if player is in freak control:
		if noun is baiter:
			say "He says nothing." instead;
		if noun is list bucket:
			say "It's probably better to examine it[if list bucket is examined], as you already did[end if]." instead;
		say "Each machine emits its own individualized [activation of grunt work], you suspect, to impress visitors." instead; [temproom freak control]
	if player is in discussion block:
		say "The song torch is playing.[line break]";
		try examining song torch instead;
	if player is in pot chamber:
		say "You hear nothing. Were you expecting to hear a [activation of crack pipe]?" instead; [temproom pot chamber]
	if player is in out mist:
		say "You can't hear anyone chasing you. That's good." instead;
	if player is in airy station:
		say "The crowd certainly makes their [activation of herd mentality]! The cheering's nice, but--it's a bit old. You wonder if you've done THAT much." instead;
	say "There's a bit of nervous tension, but there always is. You're used to that now, well, almost." instead;

chapter searching

the can't search unless container or supporter rule is not listed in any rulebook.

search-x-warn is a truth state that varies.

check searching:
	if search-x-warn is false:
		now search-x-warn is true;
		say "Searching is equivalent to examining in the game. So you can just type EXAMINE or, if you're into the whole brevity thing, X (WHATEVER).";
	try examining the noun instead;

chapter eating

Procedural rule while eating something: ignore the carrying requirements rule.

understand the command "chew" as something new.

understand "chew [something]" as eating.

the can't eat unless edible rule is not listed in any rulebook.

lolly-eaten is a truth state that varies.

check eating:
	if noun is earth of salt:
		say "[taste-poor]." instead;
	if noun is tickety:
		say "It's not big enough to be a [activation of meal ticket]." instead; [temproom pressure pier]
	if noun is lolly:
		if lolly-eaten is true:
			say "It--well, you don't it'd be as bad as you imagined." instead;
		now lolly-eaten is true;
		say "You gag on it. What did you expect? As you lose consciousness, you think you see two [activation of devil's food] besides [toad-mb-know], snickering at your naivete, and that they actually CAUGHT someone with that."; [temproom meal square]
		ship-off Maintenance High instead;
	if noun is iron waffle:
		say "No, it's iron. Plus, it's bigger than a whole pie, so how would it fit in your pie hole?" instead;
	if noun is a person:
		say "This isn't that sort of game." instead;
	d "[noun]";
	say "Even if you were terribly hungry...no." instead;

the block tasting rule is not listed in any rulebook.

check tasting:
	try eating the noun instead;

chapter removing

the can't take off what's not worn rule is not listed in any rulebook.

check removing:
	if noun is tee:
		say "You don't need to take it apart." instead;
	if noun is a person:
		say "You don't have the authority or strength." instead;
	say "REMOVEing isn't really used in this game. Try to TAKE or PUSH something instead."

chapter wearing

the can't wear what's not clothing rule is not listed in any rulebook.

check wearing:
	if noun is mind of peace:
		say "You're not sure how to, and you're not sure if you need it the most of anyone here, either." instead;
	say "Thankfully, you don't need to worry about style in this game. Anything you need to wear, you'll do so automatically." instead;

chapter unlocking

does the player mean unlocking hatch with tee: it is likely.

check unlocking:
	if noun is hatch:
		if second noun is tee:
			try opening hatch instead;
		say "The hatch is already slightly ajar, so maybe you could pull it open further. As-is, the [noun] can't quite reach it." instead;

the can't unlock without a lock rule is not listed in any rulebook.
the can't unlock without the correct key rule is not listed in any rulebook.
the can't unlock what's already unlocked rule is not listed in any rulebook.

check unlocking:
	if player is in airy station:
		say "The locks are too intricate to pick, and you have no key. Maybe you can be more direct." instead;
	say "There are no locks in this game. Well, nothing you need to get through." instead;

chapter touching

understand "tag [thing]" as touching.
understand "pet [thing]" as touching.

check touching:
	if noun is hammer:
		say "It doesn't feel unusual, but maybe you can change it." instead;
	if noun is worm:
		say "It feels pliable, like you could manipulate it--no, that's too complex a word." instead;
	if noun is earth of salt:
		say "Ew. No." instead;
	if noun is bench:
		say "Mm. Nice. Warm. But not burning-hot." instead;
	if noun is Alec:
		say "You took a year longer than most to find out what that meant. You're still embarrassed by that." instead;
	if noun is Cute Percy:
		say "You'll need to [if p-c is true]catch him[else]ENTER the chase paper[end if]." instead;
	if noun is business monkey:
		say "The monkey seems friendly, but this is not a petting zoo." instead;
	if noun is a person:
		say "That wouldn't be a [activation of poke fun]. It might even be a [activation of touch base]." instead;
	say "You can just TAKE something if you want to." instead;

chapter inserting

check inserting it into:
	if second noun is Alec Smart:
		try eating noun instead;
	try tying noun to second noun instead;

chapter taking inventory

check taking inventory (this is the adjust sleep rule) :
	if mrlp is dream sequence:
		say "You are carrying: (well, mentally anyway)[line break]  [if player is in tense past]Regret of past mistakes[else if player is in tense future]the weight of indecision[else]understanding of future failures but none of their solutions[end if][paragraph break]" instead;

the print standard inventory rule is not listed in any rulebook.

carry out taking inventory:
	if mrlp is rejected rooms:
		say "You aren't interested in your stuff here. More your surroundings." instead;
	now all things carried by the player are marked for listing;
	now all exprs are not marked for listing;
	now thought of school is not marked for listing;
	if number of marked for listing things is 0:
		say "You're not carrying anything.";
	else:
		issue library message taking inventory action number 2;
		say ":[line break]";
		list the contents of the player, with newlines, indented, including contents, listing marked items only, giving inventory information, with extra indentation.

check taking inventory (this is the new standard inventory rule):
	if accel-ending:
		say "You have a new outlook on life, and you're ready to show it. No more silly [activation of face off], either." instead; [temproom meal square]

after taking inventory:
	if player carries bad face:
		say "You're wearing a bad face";
		now bad face is mentioned;
	else if player carries face of loss:
		say "You're wearing a face of loss";
		now face of loss is mentioned;
	else if player carries lifted face:
		say "You're got a lifted face";
		now lifted face is mentioned;
	else if player carries opener eye:
		say "Your opener eye is revealing how things REALLY are";
		now opener eye is mentioned;
	else:
		say "You're expressionless, which is a BUG";
	now thought of school is mentioned;
	say ", and there's that thought of school kicking around, too.";
	if quiz pop is in lalaland and baiter is not in lalaland:
		say "[line break]You also remember that ring-brass number from the Quiz Pop bottle. It may come in handy.[line break]";
	continue the action;

chapter kissing

the block kissing rule is not listed in any rulebook.

check kissing:
	if noun is erin:
		say "The Stool Toad would probably be on you like a cheap suit." instead;
	if noun is Ally Stout:
		say "If he does like men, you reflect, he could do a lot better than you." instead;
	if noun is faith or noun is grace:
		say "Whether or not they took extreme vows of celibacy or whatever, well, this isn't that sort of game. Plus the other sister might beat you up for your indiscretion. Or just report you to the Stool Toad." instead;
	if noun is a bro:
		say "He needs something to hold, yes, but more like an object." instead;
	if noun is labor child:
		say "He's probably had enough people pinch his cheeks, and besides, he'd probably delegate bullies to get revenge on you." instead;
	if noun is officer or noun is toad:
		say "Ugh, no." instead;
	if noun is baiter master:
		say "Someone more clever and ironic than you could skeeve the you know what out of him, and it'd be fun, but you can't." instead;
	if noun is monkey:
		say "As a businessprimate, it doesn't have time for romance. Even with its own species." instead;
	if noun is a client:
		say "[if finger index is examined]That's not his secret. Or, well, it's not the one the Labor Child is blackmailing him with. Not that either secret is wrong, just, people can be mean[else]This is not the way to make friends[end if]." instead;
	if noun is a person:
		say "You don't need to open yourself to gay-bashing. Despite tolerance making huge jumps in the last few years, that stuff still HAPPENS in high school, because." instead;
	if noun is minimum bear:
		say "You're too old for that. You think." instead;
	if noun is language machine:
		say "No. You remember a story about another kid who loved his calculator too much, and what happened to him. The guy who told it liked to brag about his 60 inch TV. I mean, the one his parents bought for him." instead;
	say "Icky." instead;

chapter talking

check talking to alec:
	if cookie is in lalaland:
		say "You take time to discuss to yourself how people are dumber than they used to be before you had that Cutter Cookie." instead;
	if greater cheese is in lalaland:
		say "You mutter to yourself about how lame your self-talk used to be." instead;
	if off cheese is in lalaland:
		say "You grumble to yourself. You feel real hard to hang with." instead;
	say "You've already taken heat for talking to yourself, especially from people who give themselves pep talks before the big game. But with people around or no, it's a bad habit. Socially, at least." instead;

understand "ask [person]" as talking to.
understand "ask [person] about " as talking to.

understand "ask [text]" as a mistake ("You can say ASK NPC, or if there is just one person, ASK will work.")

understand "talk [text]" as a mistake ("There's nobody named that, or you threw in an odd preposition. You can say TALK TO NPC, or if there is just one person, TALK will work.")

check asking it about:
	say "TALK TO [noun] is the main syntax for talking, so I'll switch to that.";
	try talking to noun instead;

chapter turning

before turning:
	if noun is worm ring:
		say "If you turned it, you still wouldn't be able to get inside it. You'll need to do something else to the worm--well, the ring." instead;
	if noun is a person:
		say "You are worried enough about changing yourself. No time to try to change other people[tnn]." instead;
	else:
		say "Weird. It feels like [the noun] tries to [activation of u-turn][tnn]."

to say tnn:
	say "[one of] (TURN is not needed in The Problems Compound)[or][stopping]";

understand the command "screw" as something new.

understand "screw [something] into/on [something]" as tying it to.

does the player mean tying the screw to something: it is very likely.
does the player mean tying the screw to the stick: it is very likely.
does the player mean tying the stick to the screw: it is very likely.

chapter showing

the block showing rule is not listed in any rulebook.

show-give is a truth state that varies.

check showing it to:
	if show-give is false:
		ital-say "NOTE: showing/displaying/presenting and giving are functionally equivalent in this game.";
		now show-give is true;
	try giving noun to second noun instead;

chapter going

understand "ws" as southwest.
understand "es" as southeast.

understand "wn" as northwest.
understand "en" as northeast.

before going (this is the diagonals are wrong 99% of the time rule) :
	if player is in idiot village or player is in service community:
		continue the action;
	if p-c is false and player is not in joint strip:
		if noun is southeast or noun is northeast or noun is southwest or noun is northwest:
			say "You don't need to use diagonal directions in this game unless they're specifically mentioned. Hopefully this makes it simpler for you." instead;

before going up (this is the default reject up rule):
	if location of player is round lounge or location of player is variety garden:
		continue the action;
	if room up of location of player is nowhere:
		say "You don't need to go up anywhere [if player is in smart street]except for, well, the next room[else]besides A Round Lounge[end if]." instead;

before going down:
	if player is in chipper and percy is in chipper:
		say "Percy says 'Oop! Not [']til you get past me.' How'd he KNOW?" instead;
	if room down of location of player is nowhere:
		say "You've felt like you wanted to sink into the ground, but it's physically impossible." instead;

chapter singing

the block singing rule is not listed in any rulebook.

check singing:
	if player is in chipper wood:
		say "It's a nice wood, but despite it being a [activation of woodstock], you aren't really inspired to sing." instead; [temproom chipper wood]
	if player is in Discussion Block:
		say "[if phil is in Discussion Block]You don't want to hear Phil's critique of your singing[else]You still can't compete with the song torch[end if]." instead;
	if player has poetic wax:
		say "It's poetic wax, not [activation of wax lyrical]." instead; [temproom discussion block]
	if player is in Classic Cult:
		say "You sense singing may be overdoing it for the cult here." instead;
	say "Once you scrunch up [activation of face the music] needed, you realize never were the artsy type. And the songs you want to sing are always out of fashion." instead;

chapter examining

to say my-outlook:
	say "The outlook seems [if score < 5]confusing[else if score < 12]promising[else if player is in freak control]tense[else if freak control is visited]quite good, if you can just figure the last thing[else]very good indeed--you must be close[end if]"

understand "examine" as examining.

does the player mean examining the face of loss: it is very unlikely.

does the player mean examining the player: it is likely.

rule for supplying a missing noun when examining:
	now the noun is Alec Smart;

check examining a direction:
	if noun is up:
		say "There's no [activation of clouds of suspicion], but you still feel someone's out to get you." instead;
	if noun is out:
		say "[my-outlook]." instead;
	say "You generally don't need to look in directions. If a location is specified, you can go that way." instead;

chapter drinking

the block drinking rule is not listed in any rulebook.

got-pop is a truth state that varies.

check drinking:
	if noun is stream:
		say "Aww. This game hasn't opened your consciousness enough?" instead;
	if noun is bottle of quiz pop:
		if got-pop is true:
			say "You already did. It was character-building enough." instead;
		if player is in the belt below:
			if terminal is in the belt below:
				say "Hm. No. You can solve the terminal's logic buster without physical stimulation." instead;
		if player is not in Questions Field:
			say "You don't feel any great challenge coming on. That stuff looks potent. You don't want to waste it." instead;
		if bros-left > 0:
			say "You think about swigging the pop, but the questions the Brothers have is for help, not facts." instead;
		now got-pop is true;
		now quiz pop is in lalaland;
		say "Glug, glug. It tastes nasty. But suddenly your mind is whizzing with memories of people who out-talked you, and your realize how they did it and why. The quiz pop dissolves as you drink the last drop, leaving a paper scrap with a number to [activation of brass ring] in case of dissatisfaction and/or great need. It's a catchy number and no problem to remember." instead; [temproom questions field]
	if noun is haha brew:
		say "You take a small sip. The foul sour taste is truly unfunny." instead;
	if noun is cooler wine:
		say "You take a small sip. It doesn't taste so hot. But it's probably better than breadfruit, whatever that is." instead;
	if noun is a person:
		say "Oh, come on, this isn't [i]Twilight[r]." instead;
	say "That's not drinkable." instead;

chapter going to

understand the command "go to" as something new.
understand the command "goto" as something new.
understand the command "gt" as something new.

gotoing is an action applying to one thing.

understand "goto [any room]" as gotoing.
understand "go to [any room]" as gotoing.
understand "gt [any room]" as gotoing.

gotothinging is an action applying to one visible thing.

does the player mean gotoing guy sweet: it is likely. [prevent horrid disambiguation]

understand "goto [any thing]" as gotothinging.
understand "go to [any thing]" as gotothinging.
understand "gt [any thing]" as gotothinging.

a thing can be unchaseable. a thing is usually not unchaseable.

carry out gotothinging:
	let mrlg be map region of location of noun;
	if noun is off-stage or mrlg is nothing or mrlg is meta-rooms:
		say "[if noun is a person]They aren't[else]That isn't[end if] around right now." instead;
	if noun is unchaseable:
		say "Sorry, you'll have to find [if noun is a person]them[else]that[end if] on your own." instead;
	say "(going to [location of noun])[line break]";
	try gotoing location of noun instead;

carry out gotoing:
	let mrlg be map region of noun;
	if mrlg is nothing or mrlg is meta-rooms:
		say "Congratulations! You discovered an off-stage room. But I can't let you get there." instead;
	d "Trying location [noun].";
	if accel-ending:
		say "[if cookie-eaten is true]Nonsense. Forward![else if off-eaten is true]Ugh. Why would you want to go THERE again? It was no fun the first time.[else]You know what's important, and the past is so over. Only north to the [bad-guy] will do![end if]" instead;
	if p-c is true:
		say "EXIT the chase first." instead;
	if noun is location of player:
		say "You're already there. I mean, here." instead;
	if player is in Out Mist:
		say "Since you're being chased, backtracking would be a bad idea." instead;
	if player is in airy station:
		say "You can go home again--in fact, you're ready to--but you can't go back again." instead;
	if player is in freak control:
		say "No wimping out! This is the final confrontation." instead;
	if player is in Soda Club:
		if player has a drinkable:
			try going north instead;
	if noun is service community:
		if idol is in lalaland:
			say "No need to go back." instead;
		say "You'll need to navigate that by yourself." instead;
	if player is in service community:
		say "So many ways to go! The Service Community expands everywhere. You need to just pick a direction." instead;
	if noun is service community:
		say "[if idol is in lalaland]No need, now you've dispatched the Thoughts Idol[else]You need to plan a path to get rid of the Thoughts Idol[end if].";
	if bros-left is 0 and mrlg is outer bounds:
		say "You don't need to go that far back. You're close to Freak Control, you know it." instead;
	if noun is Soda Club and player is not in joint strip:
		say "You'll have to walk by that nosy Stool Toad directly[if trail paper is in lalaland], not that you need to go back[end if]." instead;
	if noun is not a room:
		say "You need to specify a room or a thing." instead;
	if noun is court of contempt and reasoning circular is not off-stage:
		say "You can't go back. You could, but Buddy Best would scream you back outside." instead;
	if noun is unvisited:
		say "You haven't visited [noun] yet." instead;
	if mrlp is dream sequence or mrlg is dream sequence:
		say "GO TO is invalid for the dream sequence." instead;
	if mrlp is rejected rooms or mrlg is rejected rooms:
		say "GO TO is invalid for the director's cut rooms." instead;
	if mrlp is outer bounds:
		if mrlg is beginning:
			say "No going back." instead;
	if noun is smart street and player is not in smart street:
		say "No going back." instead;
	if noun is round lounge and player is not in round lounge:
		say "No going back." instead;
	if mrlp is main chunk:
		if mrlg is not main chunk and mrlg is not outer bounds:
			say "No going back." instead;
	move player to noun;
	the rule succeeds;

chapter examining

a thing can be examined. a thing is usually not examined.

check examining (this is the don't examine directions rule) :
	if noun is up:
		say "The sky is not falling. Whew." instead;
	if noun is down:
		say "The earth is not crumbling. Whew." instead;
	if noun is a direction:
		say "You don't need to look in directions. Nothing will physically ambush you if you just go that way." instead;

after examining (this is the say it's examined rule):
	if noun provides the property examined:
		now noun is examined;
	if noun is back brush or noun is aside brush or noun is off brush:
		check-all-brush;
	continue the action;

xrooming is an action applying to one visible thing.

understand "x [any room]" as xrooming.

check xrooming:
	if noun is location of player:
		say "X (ROOM) is equivalent to LOOK in the Problems Compound.";
		try looking instead;
	if noun is visited:
		say "You've been there, but you can't see that far[x-room-n].";
	else:
		say "You haven't gotten there yet, and you can't see that far[x-room-n].";

to say x-room-n:
	say "[one of]. X ROOM is really just the same as LOOK for the room you're in, and you don't need to look ahead or behind[or][stopping]"

chapter attacking

the block attacking rule is not listed in any rulebook.

understand the command "kick" as something new.

understand "kick [thing]" as attacking.

check attacking:
	if noun is player:
		say "You don't want to embarrass yourself like that." instead;
	if mrlp is rejected rooms:
		say "With the pressure of defeating the [bad-guy] off, you don't feel violent in the slightest." instead;
	if noun is tee:
		say "Instead of breaking the tee, maybe you can use it to break something else." instead;
	if noun is mouth mush:
		say "How? By stepping on it and falling into it? Smooth." instead;
	if noun is arch:
		say "[if mush is in Tension Surface]Maybe you could do a flying karate-leap to touch the arch, but you'd fall into the mouth mush, so no[else]You should really just ENTER it now[end if]." instead;
	if noun is gen-brush or noun is off brush or noun is back brush or noun is aside brush:
		say "Beating that brush would be beating around the brush." instead;
	if noun is fund hedge:
		say "'Vandalism is subject to fines and incarceration,' the Labor Child warns you as you take a swing. You [if money seed is off-stage]can probably just take what you need[else]already got the money seed[end if]." instead;
	if noun is pusher penn:
		say "'What [activation of dopamine]! Fighting isn't a natural high! [activation of vice admiral]!' You are beaten up and turned over to the proper authorities."; [temproom pot chamber]
		ship-off Fight Fair instead;
	if noun is ally stout:
		say "'[activation of hit the bottle]!' Ally yells. The Stool Toad rushes in to subdue and gaffle you. 'Doesn't look like he'd be rowdy. Or that it'd do much good. Still...off he goes.'"; [temproom soda club]
		ship-off A Beer Pound instead;
	if noun is a logic-game or noun is game shell:
		say "'Dude! I don't care about the logic games, but they're, like, someone's PROPERTY! And lashing out like that doesn't make you any less, um...' As you wait, you're grabbed from behind. It's some giant toad in a police uniform. Weird. 'There's a place for disrespectful troublemakers like you.'";
		ship-off Hut Ten instead;
	if noun is insanity terminal:
		say "Break a computer? Maybe you just need a computer break." instead;
	if noun is torch or noun is book bank:
		if phil is in Discussion Block or art is in Discussion Block:
			say "'VANDAL!' shouts [if phil is not in Discussion Block]Art[else if art is not in Discussion Block]Phil[else]the pair of impresarios[end if]. 'You don't realize how priceless it is!' Law enforcement arrives. There's only one place for unartistic lummoxes like you.";
		else:
			say "An alarm blasts as you take your first swing! You try to run, but Officer Petty is quickly on the scene to send you elsewhere." instead;
		ship-off Hut Ten instead;
	if noun is thoughts idol:
		say "You feel weirdly paralyzed as you get too close. As you're frozen, you hear the voice of Officer Petty mumbling 'Another fool who thought he was smart.' He dumps you in a quasi-military area, and if you thought you had a break from ad hoc philosophizing, you'd be wrong.";
		ship-off Hut Ten instead;
	if noun is Labor Child:
		say "'Help! Officers!' The Labor Child searches for a hidden button, and you can only assume a hidden alarm has gone off. The Stool Toad and [if judgment pass is visited]Officer Petty[else]another man[end if] block the exit. 'Kid, give [']im the lecture! The one the boss loves!' It's one you don't. The adults give you the lecture about picking on someone smaller than you and mention that you aren't the first but you're the worst. 'Good job! [bg] will be pleased!' the Labor Child says as you're carried away.";
		ship-off Fight Fair instead;
	if player is in Freak Control and noun is scenery:
		say "'Dude. REALLY? It's not like I don't have spares,' says the [bad-guy] as you pound away. 'No damage done? No. But it's the intent that matters. I don't know how you got in here but you'll be going somewhere far away.' Ouch--you needed to do something that didn't just kill one machine.";
		ship-off Criminals' Harbor instead;
	if noun is Percy:
		say "You can't get close to him. '[activation of play it cool]!' he mocks you." instead; [temproom chipper wood]
	if noun is Baiter:
		say "Of course, with all those screens, he saw you well before you got close. He whirls and smacks you. Stunned, you offer no resistance as guards appear and take you away to where those who commit the worst crimes... 'Dude! If you wanted to talk, just TALK. I mean, you can't be too boring, but don't be all...' You don't hear the rest.";
		ship-off Punishment Capitol instead;
	if noun is enforcing:
		say "'ATTACKING A LAW ENFORCEMENT OFFICER?' Ouch. You should've known better. And [the noun] lets you know that in utterly needless detail, explaining just because you had no chance of beating him up doesn't mean it's not a very serious crime indeed.[paragraph break]It's almost a relief when he has finished shipping you off.";
		ship-off Punishment Capitol instead;
	if noun is a bro:
		say "'Silently, [noun] grabs you. [if bros-left is 1]Even without his brothers, it's a quick affair[else]His brothers hold you[end if]. He's apologetic--but he'd have liked to work with you, and violence is violence, and his job is his job. He realizes he is not so important, but anyone trying to break past him must have SOMETHING bad on their mind.";
		ship-off Punishment Capitol instead;
	if noun is spoon table:
		say "Making a [activation of hash table] would not be [activation of order n]. Err, in order." instead; [temproom Meal Square]
	if noun is list bucket:
		say "You didn't come so far only to -- wait for it -- kick the bucket. Surely there's a better way to get the [bad-guy]'s attention." instead;
	if noun is scenery and noun is in freak control:
		say "[activation of breaking and entering]? Nah, there's a better way to get the [bad-guy]'s attention." instead; [temproom freak control]
	if noun is Young Turk or noun is Uncle Dutch:
		say "'[activation of hate speech]! SPEECH HATE!' Turk and Dutch cry in unison. You're no match for both of them, or the Stool Toad, who appears in short order. 'There's not much worse than speech hate, son. Even if it's not very effective. Looking at you, I had a bad feeling you might be full of it.' The Toad blathers on about how he really just hates your actions and not you, and it's almost a relief when you're dumped off..."; [temproom speaking plain]
		ship-off Punishment Capitol instead;
	if noun is a person:
		if noun is female:
			say "Attacking people unprovoked is uncool, but attacking females is doubly uncool. You may not feel big and strong, but with that recent growth spurt, you're bigger than you used to be. The Stool Toad's quick on the scene, and while his knight-in-shining-armor act goes way overboard, to the point [noun] says that's enough--well, that doesn't change what you did.";
			ship-off Criminals' Harbor instead;
		if noun is baiter-aligned:
			say "'If you can't respect authority, at least respect those who do!' [toad-mb-know] waddles over.";
			ship-off shape ship instead;
		say "You begin to lash out, but [if know-jerks is true]the [j-g][else][the noun][end if] says 'Hey! What's your problem?' [toad-mb-know] blusters over. 'YOU! THE NEW KID!' You flinch. 'SUDDEN MOVEMENTS, EH? THERE'S ONLY ONE PLACE TO REFORM VIOLENT TYPES LIKE YOU.' You--you should've KNOWN better than to lash out, but...";
		ship-off Fight Fair instead;
	if noun is language machine:
		say "[if wax is in lalaland]After you were so nice to it? That's rough, man[else]No, it needs compassion, here[end if]." instead;
	if noun is jerks or noun is a client:
		if allow-swears is true:
			say "It'd take fifteen minutes to [activation of jerk off], and with seven, why, you'd feel indecent afterwards." instead; [temproom nominal fen]
		say "You've been suckered into lashing out before, but these guys--well, you've faced more annoying, truth be told." instead;
	if noun is return carriage:
		say "The return carriage is an [activation of case insensitive]." instead; [temproom airy station]
	if noun is ring:
		say "BONG! You didn't expect anything so musical. Or so robust, or full. But it probably needs you to act on it more subtly." instead;
	if mrlp is endings:
		say "You don't need violence right now[if player is in station]. Well, maybe the right sort against the caps[end if]." instead;
	say "Best not to make a [activation of force of habit]. Especially not against people. Fortunately, you didn't get arrested this time." instead;

to say toad-mb-know:
	say "[if down ground is visited]the Stool Toad[else]A big scary important greenish looking half-man[end if]"

return-room is a room that varies.

to ship-off (X - a room):
	let ZZ be location of player;
	if X is map-pinged and Shape Ship is not map-pinged:
		say "You hear a voice. 'Repeat offender. Same sort of thing. [X] didn't work before. Try something new.'";
		ship-off Shape Ship;
		continue the action;
	say "[b][X][r][paragraph break]";
	now X is map-pinged;
	if X is a room-loc listed in table of ending-places:
		choose row with room-loc of X in table of ending-places;
		say "[room-fun entry][paragraph break]";
	else:
		say "BUG! [X] isn't listed but should be.";
	say "Wait, no, that's not quite how it happened. It was tempting to step over the line, and people always tell you you might, but it was just a thought. Perhaps something less drastic...";
	wfak;
	move player to ZZ, without printing a room description;
	say "[b]Back at [ZZ][r][line break]"

table of ending-places
room-loc	room-fun
Fight Fair	"The fellow in charge, the [activation of boss fight], places you against someone slightly stronger, quicker, and savvier than you. He beats you up rather easily, assuring you that just because you're smart doesn't mean you needed to lack any physical prowess. Your opponent then goes to face someone stronger than him.[paragraph break]Everyone quietly nurses his [activation of sore loser] at night before repeating the next day. And the next." [temproom fight fair]
Maintenance High	"You're given the lecture about how attempts to rehabilitate you cost society even if they work out pretty quickly. Did I say the lecture? I meant, many different lectures, dedicated to helping you (or others) one day becoming a [activation of self sufficient]. Which are equally painful whether they're familiar or unfamiliar. Those who fall asleep get an extra dose. Those who stay awake are berated for not following through." [temproom maintenance high]
Criminals' Harbor	"You're given the lecture about how you'll be performing drudgework until your attempts at obvious crime are sucked out of you and you gain enough [activation of hate crime] to be useful to society. Your overseer and his prison-enforcers (the [activation of gangplank], because of their weapons) keep babbling about how it's equally bad if you get sick of his lectures or used to them. You're going down a bad road, etc., so forth." [temproom criminals' harbor]
Punishment Capitol	"You're given the lecture about how just because you did something really majorly wrong doesn't mean you're a big thinker. In fact you're perfect trainees for the [activation of prisoners of war], which nobody explains to you what it's about. Then you're told to sit and think deeply about that for a good long while." [temproom punishment capitol]
Hut Ten	"The basic training isn't too bad. You seem to do everything right, except for the stuff you do wrong, and the [activation of corporal punishment] gets on your case for that. There's so much to do, and you only make mistakes 5% of the time, maybe, but boy do the people who get it right come down hard on you when you miss. You do the same to others, but it's DIFFERENT when you do. No, really." [temproom hut ten]
A Beer Pound	"The admissions officer gives you a worksheet to fill out about how and why you can't hold your liquor." [temproom a beer pound]
In-Dignity Heap	"Here a fellow named [activation of steel will] lectures you on weighty matters such as why he'll have to get more abusive but still won't be as effective because eventually you'll build up a tolerance to abuse, and that's better than a tolerance to alcohol, but not as good as not needing one in the first place." [temproom in-dignity heap]
Shape Ship	"After a brief trip to the [activation of courtship], where you're deemed unsuitable for stable relationships, you spend months toiling pointlessly with others who acquired too many boo ticketies. Some fellow called the [activation of scholarship] booms out instructions, telling you self-awareness doesn't come for FREE, you know, and grumblers will be subjected to the heat of the [activation of censorship]. You actually strike up a few good friendships, and you all vow to take more fun silly risks when you get back home.[paragraph break]But as the days pass, the whens change to ifs." [temproom shape ship]

chapter giving

Understand "give [something preferably held] to [thing]" as giving it to.
[the below seems logical but is disabled as it wreaks havoc with syntax e.g. GIVE TOKEN]
[Understand "give [thing] [something preferably held]" as giving it to (with nouns reversed).]

does the player mean giving to a person: it is very likely.

understand the command "present" as something new.
understand the command "show" as something new.
understand the command "display" as something new.

understand the commands "show" and "present" and "display" as "give".

give-obj-warn is a truth state that varies.

section before giving stubs

[this is largely to redirect giving to non-persons]

before giving to (this is the warn against giving to nonperson rule):
	if second noun is not a person:
		if give-obj-warn is false:
			say "(NOTE: instead of GIVEing to an inanimate object, you may wish to PUT X ON/IN Y instead.)[line break]";
			now give-obj-warn is true;

before giving to the rogue arch (this is the arch not mush rule):
	if mouth mush is in lalaland:
		say "You've paid your way through. You can just enter the arch." instead;
	say "The rogue arch hasn't paid any attention to you, so you give [the noun] to the mouth mush instead.";
	try giving noun to mouth mush instead;

before giving to googly bowl:
	try giving noun to Faith Goode instead;

before giving to machine:
	say "(putting [unless noun is plural-named]it[else]those[end if] on the machine instead)";
	try putting noun on machine instead;

the block giving rule is not listed in any rulebook.

[the warn against giving to nonperson rule is listed first in the before giving to rulebook.]

book check/before giving

[there were too many CHECK GIVING rules and there were too many possibilities for fun stuff. So I thought I would put everything in order here.]

[#16 on github]

chapter big stuff

the can't give to yourself rule is not listed in any rulebook.

instead of giving to alec smart:
	d "[noun].";
	if player does not have noun:
		try taking noun;
	say "You check your possessions. Yup, still got [if noun is plural-named]those[else]that[end if].";

before giving when accel-ending:
	say "You're not feeling charitable at all. You just want to get through with things, here." instead;

chapter what if sal is asleep

before giving to sal when sal-sleepy is true:
	say "He doesn't complain. But then again, he doesn't react at all, because he's asleep, and he can't accept gifts." instead;

chapter item based [these see us giving specific items to specific characters. They come first.]

check giving smokable to: [poory pot or wacker weed]
	if second noun is stool toad:
		say "The Stool Toad jumps a whole foot in the air. 'How DARE you--on my turf--by me! OFFICER PETTY!' [if judgment pass is visited]Officer Petty[else]A man with a less fancy uniform[end if] rushes in and handcuffs you. You hear them talking about hitting the bar after work as a subordinate takes you to the...";
		ship-off Criminals' Harbor instead;
	if second noun is Officer Petty:
		say "Officer Petty begins a quick cuff em and stuff em routine while remarking how that stuff impairs your judgement, and you seemed kind of weird anyway. He summons the Stool Toad for backup, not that he's needed, but just to make your perp walk a little more humiliating.";
		ship-off Criminals' Harbor instead;
	if second noun is volatile sal:
		say "[if noun is poory pot]Sal might be offended by that. As if he is the one causing the smell. Maybe if you can make it so the poory pot can take over the whole room...[else]Sal would probably tell you he's no druggie.[end if]" instead;
	if second noun is Sid Lew:
		say "That might mellow him out, but it also might start him lecturing on anti-pot laws. Which you don't want, regardless of his stance." instead;
	if second noun is Sly Moore:
		say "'That might help my audience enjoy my tricks more, but I'd wind up doing [']em a bit worse.'" instead;
	if second noun is Lee Bull:
		say "Lee shrugs helplessly. That's not active enough to disrupt Sid's barrage of chatter." instead;
	if second noun is faith or second noun is grace:
		say "That's probably not the sort of incense or decoration they want to use[if fourth-blossom is in lalaland]. You restored the blossom, anyway[else]. The bowl seems more for flowers[end if]." instead;
	if second noun is Pusher Penn:
		say "[if noun is weed]'Nope. No reneging.'[else]'Nonsense. That's your pay.'[end if]" instead;
	if second noun is Fritz the On:
		if noun is poory pot:
			say "'Whoah! That stuff doesn't do it for me any more,' mutters Fritz." instead;
		say "You look every which way for the Stool Toad, then put your finger to your lips as you hand Fritz the packet. He's surprisingly quick converting it to something smokable and hands you a coin back--a dreadful penny. Proper payment for the cheap stuff. 'Dude! Once I find my lighter I totally won't [activation of high off the hog] from you. Can't wait for my [activation of puff piece]...nothing beats it for feeling good!' You're not sure you want [activation of roll a joint], but Fritz's gratitude seems genuine. 'I'd give you [activation of drag along] if i could light it...' After searching himself for a source of flame, Fritz mumbles an apology and runs off."; [temproom down ground]
		increment the score;
		now wacker weed is in lalaland;
		now fritz is in lalaland;
		it-take dreadful penny;
		the rule succeeds;

does the player mean giving a drinkable to erin: it is likely.

check giving drinkable to:
	if second noun is Ally Stout:
		say "He might be insulted if you give it back." instead;
	if second noun is Erin:
		unless erin-hi is talked-thru or Erin is babbled-out:
			say "Erin ignores your offer. Perhaps if you talked to her first, she might be more receptive." instead;
		say "Erin looks outraged. 'This?! Are you trying to make me boring like you?! Plus you got that drink for free, so some GIFT! HONESTLY! After I opened my heart to you!' She takes your drink and sloshes it in your face before running off.";
		wfak;
		now noun is in lalaland;
		activate-drink-check;
		chase-erin instead;
	say "This is a BUG. You shouldn't be able to carry liquor out of the Soda Club." instead;

section giving items in intro

check giving face of loss to:
	say "You get the sense pity won't get you very far, here." instead;

check giving bad face to:
	say "[if stared-idol is true]You already gave it to the idol, which seemed to deserve it. Maybe the [bad-guy] deserved it more, but you probably can't[else]You'll pull the bad face out when you need to[end if]." instead;

check giving gesture token to:
	if second noun is weasel:
		now gesture token is in lalaland;
		annotize gesture token;
		now player has the pocket pick;
		set the pronoun it to weasel;
		say "It tucks away the token with a sniff. 'Well, it's not much--but, very well, I'll let you in my work study program. I won't even charge interest. Have this pocket pick. It'll help you DIG to find stuff. You can try it here, with the poor dirt!'" instead;
	if second noun is mush:
		say "'Pfft. Petty bribery. I need forms. Signed forms.'" instead;
	if second noun is guy sweet:
		say "'I've got plenty of those! Anyway, these games are free. And if I charged, it'd be more than THAT.'" instead;

to annotize (toanno - a thing):
	if ever-anno is true:
		repeat through table of annotations:
			if there is an exam-thing entry:
				if toanno is exam-thing entry and anno-num entry is 0:
					increment cur-anno;
					now anno-num entry is cur-anno;
					if anno-allow is true:
						say "Annotation [cur-anno] inserted for [the toanno] if you'd like: NOTE [cur-anno] to see it.";

check giving burden to:
	if second noun is mush:
		if burden-signed is true:
			say "With a horrible SCHLURP, the mouth mush vacuums the signed burden away from you. You hear digestive noises, then a burp, and an 'Ah!'[paragraph break]'That'll do. Okay, you stupid arch, stay put. And YOU--wait a few seconds before walking through. I'm just as alive as you are.' You're too stunned to step right away, and after the mush burbles into plain ground, you take a few seconds to make sure the Rogue Arch is motionless.";
			now burden is in lalaland;
			now mouth mush is in lalaland;
			set the pronoun it to rogue arch;
			the rule succeeds;
		say "'It's not properly signed! And it's not officially a proof [']til it is!'" instead;
	if second noun is weasel:
		if burden-signed is true:
			say "'That's my signature. Don't wear it out.'" instead;
		unless weasel-baiter is talked-thru or weasel is babbled-out:
			say "'Oh no! You obviously need a little help being more social, but you haven't listened to me enough yet. That'll help. Totally.'" instead;
		say "The weasel makes a big show about how it would normally charge for this sort of thing, but then, signing for you means it'll feel less guilty rejecting an actual charity since it already did something for someone. It makes you sign a disclaimer in turn, absolving it if you do anything dumb. 'Ain't I a [activation of animal welfare]?'[paragraph break]Well, the proof is signed now."; [temproom variety garden]
		set the pronoun it to weasel;
		now burden-signed is true instead;

section giving items from surface

check giving pick to:
	if second noun is mouth mush:
		say "'Thanks, but I floss regularly.'" instead;
	if second noun is weasel:
		say "'No! It's yours now! I'm not strong enough for manual labor, anyway. But you are.' It grins brightly." instead;

section giving items from outskirts

check giving the condition mint to:
	if second noun is baiter master:
		say "You could picture him giving you something worthless and making you do something. You could also him getting mad and making you apologize for offering something so flimsy." instead;
	if second noun is fritz:
		say "Fritz's breath could use a little sprucing up, but the mint would be a little TOO little." instead;
	if second noun is volatile sal:
		say "'Hm, if you had one like three feet cubed, it'd make the room smell nicer. But you don't.' He pushes you away before you can ask if he means three on each side or three total." instead;
	if second noun is buddy best:
		say "'Look, I know from dinner mints. I steal [']em all the time when I go out to eat. I deserve to. And that's a pretty lame dinner mint.'" instead;
	if second noun is art or second noun is phil:
		say "He sniffs. 'I'm sure it's perfectly tasty for SOME people.'" instead;
	if second noun is language machine:
		try inserting mint into machine instead;
	if second noun is grace goode:
		say "Refreshing mints belong in a bowl and all, but the googly bowl [if fourth-blossom is in lalaland]already has[else]needs[end if] something a bit more." instead;
	if second noun is labor child:
		say "He's too big to get excited over candy. Especially cheap candy like that." instead;
	if second noun is a bro:
		say "'Mmm. That might help me feel a bit better. But not for long enough. I...well, save it for someone who'd appreciate its taste.'" instead;
	if second noun is terry sally:
		say "'Ooh, brave. ANYONE can steal a cheap mint.'" instead;
	if second noun is thoughts idol:
		say "The idol has a mouth, but I doubt it could eat the mint, or appreciate it." instead;
	if second noun is worm ring:
		say "That wouldn't fill it much. You need to change the ring." instead;
	if second noun is mentality crowd:
		say "You did pretty well, but you have no idea how to split the one mint among such a large crowd." instead;
	if second noun is sly moore:
		if talked-to-sly is true:
			say "Maybe it would've been a good way to break the ice, but he doesn't need that now." instead;
		now mint is in lalaland;
		now talked-to-sly is true;
		say "'Oh, hey, thanks! I'm Sly Moore.'" instead;
	if second noun is not a person:
		say "No way for the mint to be digested." instead;
	if second noun is Erin Sack:
		say "That'd imply her breath was bad. Uncool." instead;
	if second noun is percy:
		continue the action;
	if second noun is baiter-aligned:
		say "[the second noun] is a bit above the condition mint, and how it might help them feel forgiven or put away shame." instead;
	if second noun is enforcing:
		say "That's not substantial enough for an officer of the law." instead;
	if second noun is not a client:
		say "Your offer is declined. [if mint is examined]They don't seem to have any silly shame that can be absolved easily[else]Maybe looking at the mint will help decide why[end if]." instead;
	if finger index is not examined:
		say "The [j-co] seem nasty enough, you don't want to share even a mint with any of them. Maybe if you found some way to empathize with them." instead;
	choose row with jerky-guy of second noun in table of fingerings;
	if suspect entry is 1:
		say "[second noun] is a bit too nervous around you, as you already figured his secret." instead;
	say "[second noun] accepts your offer gratefully, and you discuss the list with him. 'Oh dear,' he says, 'I must be [clue-letter of second noun].'[paragraph break]You assure him his secret is safe with you.";
	now second noun is minted;
	now mint is in lalaland;
	now suspect entry is 2;
	the rule succeeds;

check giving minimum bear to (this is the fun stuff if you give the bear to someone else rule) :
	if second noun is Stool Toad:
		say "'DO I LOOK LIKE A SOFTIE?'" instead;
	if second noun is Fritz the On:
		say "'Dude! Minimum Bear!' he says, snatching it from you. 'I--I gotta give you something to thank you.' And he does. 'Here's a boo tickety I got for, like, not minding right. I've got so many, I won't miss it.'";
		now Fritz has minimum bear;
		if Terry Sally is in lalaland:
			say "[line break]Fritz starts mumbling about the generosity of someone coming back to do nice things for the sake of being nice and strts complaining enough about how people who don't do this sort of thing that you wish you hadn't." instead;
		if your-tix >= 4:
			say "[line break]Before you can decline Fritz's offer because you have too many already, he begins mumbling something about a revolution of the oppressed. It's enough to alert the Stool Toad.";
		if your-tix is 3:
			say "[line break]'Whoah, dude! You have almost as many ticketies as me!' Fritz blurts, before you can shush him.";
		get-ticketed "giving Fritz his dumb bear he keeps losing";
		the rule succeeds;
	if second noun is Terry Sally:
		say "A momentary expression of rage crosses his face. 'Is this some sort of joke? You'd have to be whacked out to like that.'" instead;
	if second noun is erin:
		say "'Aww. That's so sweet. Or it would've been if I was still eight.'" instead;
	if second noun is a bro: [note that this *is* possible if you perform other lawbreaking tasks]
		say "He gazes at it wistfully. 'No, I'm too old. I better be.'" instead;

check giving tickety to:
	if second noun is Fritz:
		say "'No way, dude. I already have too many[unless fritz has minimum bear]. But I can give you one if you like[else]. Keep the one I gave you[end if].'" instead;
	if second noun is Terry Sally:
		say "'Not bad. But you still need [4 - your-tix in words] more.'" instead;
	if second noun is Erin:
		say "She is not impressed by your attempts to be a Bad Boy." instead;
	if second noun is Ally Stout:
		say "[one of]A sardonic laugh. 'Tough customer, eh? We better not give you the REAL stuff, then!'[or]He ignores you the second time.[stopping]" instead;
	if second noun is stool toad:
		say "You consider it, but it'd be embarrassing to get another tickety. Or not even be important enough for one." instead;

check giving the trail paper to:
	if second noun is Fritz:
		say "'That's not the kind of trips I go in for, dude.'" instead;
	if second noun is Terry Sally:
		now trail paper is in lalaland;
		choose row with response of terry-west in table of Terry Sally talk;
		now enabled entry is 0;
		terry-sug;
		say "'Eh, you've done enough. Here, I'll shred the evidence. So you don't get caught later. Say, after all that goofing around, you might be hungry. Look around in Meal Square. There's some food that'll fix you quick. Need anything else? No? Okay.' He walks off.";
		unlock-verb "figure";
		now Terry Sally is in lalaland;
		annotize erin sack;
		annotize ally stout;
		the rule succeeds;
	if second noun is Erin:
		say "She shrugs and mentions she's been better places." instead;
	if second noun is Ally Stout:
		say "She is unimpressed with your attempt at being a Bad Boy." instead;
	if second noun is Stool Toad:
		say "He might put two and two together and arrest you." instead;

check giving dreadful penny to:
	if second noun is labor child:
		say "That's small stuff for him. He'd probably rather be doing business." instead;
	if second noun is enforcing:
		say "'Such blatant bribery! And small thinking, too.'" instead;
	if second noun is faith or second noun is grace:
		say "'We need no monetary donations. Big or small. [goo-heal].'" instead;
	if second noun is pusher penn:
		now player has poory pot;
		now penny is in lalaland;
		say "'Most excellent! It's not the profit so much as the trust. Now, you look like you haven't tried the good herb before. No offense. So let's start you with the...' he sniffs, 'aromatic stuff. It's poor-y pot, but it'll do. Seller assumes no liability if user is too wussy to keep smoke in lungs for effective amount of time, yada, yada.' You try to say you weren't intending to smoke it, anyway.";
		increment the score;
		set the pronoun it to the poory pot;
		the rule succeeds;

to say goo-heal:
	say "The googly bowl [unless fourth-blossom is in lalaland]must be[else]is[end if] healed, and that is most important"

check giving quiz pop to: [couldn't figure where to put this]
	say "No. The pop seems...unusual. You worked to get it." instead;

section giving items from west

check giving the fish to:
	if second noun is buddy best:
		say "'Really. I don't have time for stories.'" instead;
	if second noun is uncle dutch or noun is turk young:
		say "'It was marketable once. To total suckers.'" instead;
	if second noun is a bro:
		say "That would depress [second noun] even more." instead;
	if second noun is sal:
		say "'Well, that fish doesn't stink like it should, but something here still does.'" instead;
	say "It's far too tacky to give, even as a joke. You probably just want to TALK to it to get it going." instead;

check giving mind of peace to:
	if second noun is Brother Blood:
		now mind of peace is in lalaland;
		now brother blood is in lalaland;
		say "Brother Blood takes the mind and gazes at it from all different angles. He smiles. 'Yeah...yeah. Some people are just mean. Nothing you can do to brush [']em off but brush [']em off. I mean, I knew that, but I KNOW it now.'[paragraph break]'Thank you!' he says, squeezing your arm a bit too hard. 'Oops, sorry, let's try that again.' The other arm works better. 'I'm--I'm not just good for snarling and yelling at people and pushing them around, like the [bad-guy] said. I'm more than that. So I guess I need to go find myself or something.'";
		check-left;
		annotize brother blood;
		the rule succeeds;

check giving trade of tricks to:
	if second noun is Brother Big:
		now brother big is in lalaland;
		now trade of tricks is in lalaland;
		say "'Wow! All these things I never learned before! Was it really--did people really--yes, they did.' You read through with him, [if trade of tricks is examined]re-[end if]appreciating all the things you'd fallen for and won't again.[paragraph break]'I won't be suckered again. Well, not as badly, or as often.'";
		check-left;
		annotize brother big;
		the rule succeeds;

check giving money seed to:
	if second noun is sly moore:
		say "'I'm not the farmer here. The monkey, though...'" instead;
	if second noun is language machine:
		say "The Standard Bog is no place to grow anything." instead;
	if second noun is Fritz the On:
		say "'Whoah, I don't farm materialistic stuff.'" instead;
	if second noun is officer petty or second noun is stool toad:
		say "'I'm in the business of keeping people in line. I'm paid well enough.'" instead;
	if second noun is faith or second noun is grace:
		say "'Our bowl cannot grow flowers. Especially not from something so--material. It can only accept them.'" instead;
	if second noun is business monkey:
		say "The business monkey grabs it eagerly, stuffing it into the soil.";
		wfak;
		say "[line break]As both actions were rather half-[abr] to say the least, you are completely unsurprised to see, not a full blossom, but a fourth of one spring up--one quadrant from above, instead of, well, a blossom one-fourth the length or size it should be. He plucks it and offers it to you--very generous, you think, as you accept it. As you do, three others pop up, and he pockets them.";
		increment the score;
		now player has the fourth-blossom;
		set the pronoun it to the business monkey;
		now money seed is in lalaland;
		the rule succeeds;

to say abr:
	say "[if allow-swears is true]assed[else]brained[end if]"

check giving cold contract to:
	if second noun is labor child:
		continue the action;
	if contract-signed is true:
		say "It's already signed. No point." instead;
	if second noun is sly moore:
		say "[if talked-to-sly is true]Sly[else]He[end if] looks confused, but the Business Monkey looks over curiously." instead;
	if second noun is generic-jerk:
		say "You're just glad they aren't forcing YOU to sign anything." instead;
	if second noun is not business monkey:
		say "You can't bring yourself to sucker a person into signing this. Regardless of how nice they may (not) be." instead;

check giving the cold contract to the business monkey:
	if contract-signed is true:
		say "You already did." instead;
	if money seed is not in lalaland:
		say "The monkey looks at it, smiles and shrugs. It seems to trust you, but not enough to sign a contract, yet." instead;
	say "You feel only momentary guilt at having the business monkey sign such a contract. After all, it binds the [i]person[r] to the terms. And is a monkey a person? Corporations, maybe, but monkeys, certainly not, despite any genetic similarities! The monkey eagerly pulls a pen from an inside pocket, then signs and returns the contract.";
	set the pronoun it to the business monkey;
	increment the score;
	now contract-signed is true;
	the rule succeeds;

check giving the cold contract to the labor child:
	if contract-signed is false:
		say "'Trying to exploit a defenseless kid! Shame on you! I need that signature, and I need it NOW!'" instead;
	now cold contract is in lalaland;
	say "'Excellent! You now have a customer in your pipeline. You will receive 5% of whatever he buys from us in the future. Oh, and you may go IN to the back room.'" instead;

section giving items from north

check giving relief light to:
	if second noun is Brother Soul:
		now relief light is in lalaland;
		now brother soul is in lalaland;
		say "'Thank you! My soul is less heavy and dark now. I believe I have a higher purpose than just blocking people.'";
		check-left;
		annotize brother soul;
		the rule succeeds;

instead of giving the long tag to:
	try giving reasoning circular to second noun;

check giving Reasoning Circular to:
	if second noun is a bro:
		say "He's not searching for that. He's searching for something real." instead;
	if second noun is dutch or second noun is turk or second noun is child:
		say "Oh, he's long since mastered THAT." instead;
	if second noun is Stool Toad:
		say "'BASIC TRAINING! I completed that long ago. Some of my colleagues haven't, yet.'" instead;
	if second noun is Officer Petty:
		now Officer Petty is in lalaland;
		now the Reasoning Circular is in lalaland;
		say "A tear starts to form in Officer Petty's eye. 'Really? I...well, this definitely isn't bribery! I've cultivated a nice [activation of scofflaw] at people who get simple stuff wrong, but I always felt there was more. I could have more complex reasons to put people down. I really CAN follow a [activation of career threatening]! I CAN be clever and still play the Maybe I Didn't Go to a Fancy School card. Thank...' He looks at the Reasoning Circular again. 'Wait, wait. Maybe you wouldn't have gotten anything out of this invitation anyway. So it's not so generous.' Officer Petty beams at his newfound profundity before shuffling off."; [temproom judgment pass]
		increment the score;
		annotize officer petty;
		the rule succeeds;
	if second noun is Fritz:
		say "'Whoah! Cosmic!'" instead;

check giving trick hat to:
	if second noun is Lee Bull:
		say "Thing is, he KNOWS all the tricks. He just can't use them." instead;
	if second noun is Sid Lew or noun is stool toad:
		say "He's awful enough with what he's got." instead;
	if second noun is faith goode or noun is grace goode:
		say "Then they might become a charismatic cult, and that wouldn't be good." instead;
	if second noun is Sly Moore:
		say "You give [if talked-to-sly is false]the magician[else]You give Sly Moore[end if] the trick hat. He adjusts it ten times until it feels right, which is pretty silly, since it's completely circular. But once he wears it, his eyes open. 'Oh...that's how you...and that's how you...'[paragraph break]All the magic tricks he failed at, before, work now[if talked-to-sly is false]. 'Oh, hey, I'm Sly Moore, by the way.'[else].[end if]";
		wfak;
		say "[line break]'Can...can I keep the hat?' You nod. It was sort of tough to carry, and it didn't really suit you. Sly shakes your hand. 'Thanks so much! Oh, hey, here's a gift for you. From a far-off exotic place. A trap-rattle.'[paragraph break]You accept it without thought. Sly tries a trick with the hat (got it,) then without it (almost, but much better,) then excuses himself to brush up on magic tricks.";
		wfak;
		it-take trap rattle;
		now trick hat is in lalaland;
		increment the score;
		now sly moore is in lalaland;
		say "[line break]And once you take a step, thought is hard. Rattle, rattle. But you can't give it back, now. Still, maybe it'll be more useful for you than Sly.";
		annotize Sly Moore;
		the rule succeeds;

check giving wax to:
	ignore the can't give what you haven't got rule;
	if second noun is Lee Bull or second noun is Sid Lew:
		say "[one of]Sid Lew begins an extremely boring, but loud, discourse on a poet you never heard of and never want to hear of again. The sort of poet who would not want his work read or discussed quietly[or]No, the poetic wax doesn't belong here. It'll only temporarily plug Lee's ears or (eww) Sid's mouth[stopping]." instead;
	if second noun is grace goode or second noun is faith goode:
		say "[one of]Faith and Grace begin humming a tune too wonderful to remember to remember. You feel refreshed after hearing it, but you can't remember why[or]You feel greedy, for some reason, giving [second noun] the Poetic Wax. But you don't know why[stopping]." instead;
	if second noun is Stool Toad:
		say "He booms 'I can't arrest you for slovenliness, young man. But you're well on your way to trouble.'" instead;
	if second noun is Pusher Penn:
		say "[one of]'Yo, yo, hit me with the beatbox!' he cries. 'I gots tales of...' but he tails off before you can get your fists up to your mouth. 'Okay, man. Be wack.'[or]Nah, you funked out the first time.[stopping]" instead;
	if second noun is Buddy Best:
		say "'I'm not some neat freak. But geez, that stuff's just gross.'" instead;
	if second noun is Ally Stout:
		say "'The Stool Toad would LOVE to find a health violation. Put that away.'" instead;
	if second noun is Cute Percy:
		say "You can't get near enough to him." instead;
	if second noun is Labor Child:
		say "He squirms. The [i]thought[r] of getting something like that over his practical, getting-ahead clothes!" instead;
	if second noun is Officer Petty:
		say "'You'll have to work a little harder to bribe me. Well, if I [i]could[r] be bribed. A thoughtful gift, on the other hand...'" instead;
	if second noun is Sly Moore:
		say "Sly examines the wax, waves at it and tries to make it disappear, and fails." instead;
	if second noun is Art Fine or second noun is Harmonic Phil:
		say "'Nonsense! It is I who might bequeath it on you. Until then, do not sully it with your prying fingers!'" instead;
	if second noun is Volatile Sal:
		say "[one of]'Yo, man, ear wax probably doesn't smell as bad as whatever, but still. No.'[or]Sal doesn't seem open to the wax. It DOES look a bit stinky.[stopping]" instead;
	if second noun is a client:
		say "The [j-co] mutter something about how decent people don't pick their ears, much less their nose, and certainly not THAT much." instead;
	if second noun is fritz the on:
		say "Fritz moans. The poetry he's thinking of is probably pretty whacked, so best not to torture him." instead;
	if second noun is turk young or second noun is uncle dutch:
		say "[one of]As you approach them with a bit of the wax, they boom 'We once knew a worthless old bum. Not then, but he's now and then some. Learned weird stuff instead of getting ahead. So he was so smart he was dumb.'[or]'Roses are Red! Violets are blue! We're both gung ho...but why aren't you?' They're running out.[or]They both make a 'pay up' gesture. Looks like you've had all the artistic inspiration they're willing to give.[stopping]";
		now no-dutch is true instead;
	else if second noun is erin:
		say "That would gross her out. Deservedly, but still. Guys would come to her 'rescue' and probably gaffle you or something." instead;

section giving items from east

check giving the trap rattle to: [you can't get the trap rattle until you've gotten past Sly Moore, which means being nice to the machine and also getting the wax and vanishing the discussion block]
	if second noun is fritz:
		say "'Not groovy music, man.'" instead;
	if second noun is grace goode:
		say "'That is too noisy for here.'" instead;
	if second noun is labor child:
		say "'That's for BABIES.'" instead;
	if second noun is Sid Lew:
		say "He recoils in fear for a second, then booms 'WHY WOULD I WANT THAT.' It's not really a question." instead;
	if second noun is Lee Bull:
		say "Sid Lew continues his abuse. At first Lee Bull seems to take it, but then--rattle, rattle. It distracts Sid Lew enough, Lee Bull finds his voice. Animated, he shows up every hole in Sid Lew's seductive but wrong arguments. He begins hitting Sid Lew on the head with the trap rattle until Sid Lew runs out, grousing Lee doesn't DESERVE [activation of right to privacy], and he won't USE it, but..."; [temproom truth home]
		wfak;
		say "[line break]Lee Bull shakes the rattle some more. You see something fall out. '[activation of mass production],' says Lee. 'It helps people with bottled up ideas see their way through to organize them, with their unique life view! I better star some [activation of assembly line] before it decays...' Lee begins to write. And write. He hands you the first page--and wow! All the clever life hacks you learn just from the introduction! It's too much, though. You fall asleep as your mind processes it all, with incidents from your own life suddenly making sense."; [temproom truth home]
		wfak;
		say "[line break]When you wake up, Lee Bull has written several copies of a small, but fully bound book. He gives it to you and shakes your hand. THE TRADE OF TRICKS, it's called. '[activation of thp] is particularly intoxicating,' he says, 'but I'm too tired to explain it.' He leaves to his own private quarters."; [temproom truth home]
		now Lee Bull is in lalaland;
		now Sid Lew is in lalaland;
		now trap rattle is in lalaland;
		it-take trade of tricks;
		increment the score;
		annotize lee bull;
		annotize sid lew;
		the rule succeeds;
	if second noun is dutch or second noun is turk:
		say "They're making enough hoopla as-is." instead;
	if second noun is pusher penn:
		say "'You wanna alert the COPS?'" instead;
	if second noun is volatile sal:
		say "'Oh, great. Noise AND smell!'" instead;
	if second noun is a bro:
		say "[second noun] stares blankly. He doesn't have anyone to trap, so it isn't that useful." instead;

check giving fourth-blossom to:
	if second noun is faith or second noun is grace:
		say "'We must perform the ritual.' They cover the googly bowl with their hands. You hear a whirring and squelching, then soft humming.";
		wfak;
		say "[line break]'It is done! The bowl is whole! And here is thanks for you, who found the last component.' They hand you a fragile, translucent miniature brain. 'A mind of peace.'[paragraph break]";
		get-mind;
		the rule succeeds;
	if second noun is art fine or second noun is harmonic phil:
		say "He takes a dainty sniff. 'It's nice, but no imagination went into it.'" instead;
	if second noun is a bro:
		say "He looks momentarily comforted but says, 'No. I need something that will last. And change me.'" instead;
	if second noun is monkey:
		say "The business monkey points at you, to say you own the blossom now." instead;
	say "You don't know if [the second noun] would appreciate the fourth-blossom[if second noun is baiter-aligned]. Well, actually, you're 99.9% sure not[end if]." instead;

section giving items from below

check giving legend of stuff to:
	if second noun is a bro:
		say "They'd hear it for sure, if they read that while they were supposed to be working." instead;
	say "The Legend of Stuff feels stuck to you." instead;

check giving crocked half to:
	if second noun is idol:
		say "The idol seems to shake a bit as you wave the crocked half at it." instead;
	if player is in out mist:
		say "Maybe you could've used the crocked half earlier, somewhere." instead;
	if thoughts idol is in lalaland:
		say "The crocked half is useless now you've beaten the idol, but nah, keep it. It has sentimental value";
	else:
		say "[if second noun is a baiter-aligned person]Don't let it fall in the wrong hands. You went through a lot to get it[else]It's yours, to figure what to do with[end if]";
	say "." instead;

chapter person based

[these kick in before giving X to Y, but it's a smaller section so I put them here.]

check giving to Brother Big:
	if noun is a smokable:
		say "'That might give me too-crazy ideas. I need something I can study.'" instead;
	if noun is poetic wax:
		say "'I am too clumsy to write poetry.'" instead;
	if noun is Trick Hat:
		say "It doesn't even close to fit him. Too bad! Anyway, he could maybe use some real education and not just a magic boost." instead;
	if noun is Mind of Peace:
		say "'I need education, not peace. However, that may be perfect for Brother Blood.'" instead;
	if noun is Relief Light:
		say "'I need specific relief from my own lack of knowledge. However, that may be perfect for Brother Soul.'" instead;

check giving to Brother Soul:
	if noun is a smokable:
		say "'That works to inspire some people, but probably not for me.'" instead;
	if noun is poetic wax:
		say "'If I were cheerier, that might help me write decent poetry. But alas, I am not, yet.'" instead;
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is mind of peace:
		say "'That would be perfect for Brother Blood. But any peace I have would be temporary. I would still need relief.'" instead;

check giving to Brother Blood:
	if noun is a smokable:
		say "'That might give me a short-term fix, but I need something permanent.'" instead;
	if noun is poetic wax:
		say "'I am scared of what I might write.'" instead;
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is relief light:
		say "'That would be perfect for Brother Soul. But it might only give me temporary relief from my violent worries.'" instead;

chapter big one and default

[this is a catch-all]

procedural rule while giving:
	if second noun is idol or second noun is worm ring or second noun is return carriage or second noun is mentality crowd:
		ignore the can't give to a non-person rule;

check giving (this is the default for giving to people organized by room rule) :
	if second noun is Guy Sweet: [smart street]
		if noun is token: [second noun must be Guy Sweet]
			say "'No, I don't want [if noun is gesture token]it back. I have plenty. You might need it[else]that. Or anything from you, really. I'm here to help YOU[end if].'" instead;
		say "There's some awkward gesturing before and after you realize Guy doesn't particularly need or want [the noun]." instead;
	if second noun is arch: [tension surface]
		if mush is in lalaland:
			say "The arch doesn't react. Which is sort of a good thing." instead;
		say "As you try, the mush coughs, somehow." instead;
		try giving noun to mush instead;
	if second noun is weasel: [variety garden]
		say "'I don't know what I can do with that. I suppose I could re-sell it at a markup, if it were worth anything, which I don't think it is. No offense.'" instead;
	if second noun is Fritz the On: [down ground]
		say "Fritz rambles about material possessions bringing you down for a bit. [if fritz has minimum bear]You've given him enough[else]That can't be what he wants[end if]." instead;
	if second noun is Stool Toad: [joint strip]
		say "'NO BRIBERY! Plus, that looks worthless. No offense.'" instead;
	if second noun is Ally Stout: [soda club]
		say "'Thanks, but no thanks. I do okay enough with tips.'" instead;
	if second noun is Erin Sack:
		say "That seems like a weak gift idea. Not the sort of thing you give someone in a bar. Uh, club." instead;
	if second noun is Buddy Best:
		say "'I'm sure there's a good thought behind that. Well, there better be. It doesn't seem too useful to me.'" instead;
	if second noun is Cute Percy:
		say "'Ha!' he says. 'If I took that, you'd be in a great position to catch me. Nice try!'" instead;
	if second noun is business monkey:
		say "The business monkey shrugs its shoulders." instead;
	if second noun is dutch or second noun is turk:
		if noun is dreadful penny:
			say "'NOT FOR US BIG THINKERS', booms [second noun]." instead;
		say "'GIFTS AFTER THE SHOW,' booms [second noun]." instead;
	if second noun is pusher penn:
		say "'Not useful in my line of business.'" instead;
	if second noun is a client:
		say "[second noun] would rather spend time talking with his friends. Yet for all their loud talking, they don't seem confident." instead;
	if second noun is art fine or second noun is harmonic phil:
		if noun is fish:
			say "[if phil is in discussion block]Phil smirks, but [end if]Art looks horrified." instead;
		if noun is sound safe:
			say "[if phil is in discussion block]Art smirks, but [end if]Phil looks horrified." instead;
		say "'I'm not sure how that fits in with the decor.'" instead;
	if second noun is Sly Moore:
		say "[sly-s] says 'That's nice for someone else, maybe, but I can't use it for magic stuff.'" instead;
	if second noun is Sid Lew:
		say "Sid arglebargles about possessions weighing you down, especially worthless ones. He'd rather have your time." instead;
	if second noun is Volatile Sal:
		say "Sal sniffs, not the I'm-too-good sniff but the sniff he'd rather take care of the smell." instead;
	if second noun is Lee Bull:
		say "Sid's arguments, combined with any clutter, would be too much. Lee needs something different. Something that can defend and counterattack." instead;
	if second noun is labor child:
		say "'Wasting my time with small things? No!'" instead;
	if second noun is faith or second noun is grace:
		say "'Thank you, but we lead a minimalist lifestyle here. [goo-heal]." instead;
	if second noun is Brother Blood:
		say "'No, I need something to calm me down.'" instead;
	if second noun is Brother Big:
		say "'Alas, that is not educational enough for me.'" instead;
	if second noun is Brother Soul:
		say "'No, I need something to dispel this sad darkness in my soul.'" instead;
	if second noun is language machine:
		if poetic wax is in lalaland:
			say "[no-pos]." instead;
		say "The language machine has no arms, so you decide to PUT it ON.";
		try putting noun on language machine instead;
	if second noun is Officer Petty:
		say "'NO BRIBERY! Besides, that's not worth anything. But, uh, it's perfectly legal to give me something that might help my career.'" instead;
	if second noun is worm ring or second noun is return carriage:
		say "No, you need to do something to the [second noun] to leave the Problems Compound successfully." instead;
	if second noun is mentality crowd:
		say "Aw, shucks, you gave them enough." instead;
	if second noun is thoughts idol:
		say "The Thoughts Idol wants nothing physical. Just your fear and thoughts." instead;

give-put-warn is a truth state that varies.

check giving (this is the default fall-through giving rule) :
	if second noun is not a person and give-put-warn is false:
		ital-say "it may work better to GIVE stuff to people or living things. For inanimate objects, try PUT X ON/IN Y.";
		now give-put-warn is true instead;
	say "As you reach for that, [the second noun] blinks and looks at you. No, you don't see how they'd want THAT." instead;

[end check giving rules block -- if you grep, nothing should be below here until the testing section]

book common irregular verbs

chapter exitsing

exitsing is an action out of world.

understand the command "ex/exits" as something new.

understand "ex" and "exits" as exitsing.

carry out exitsing:
	let got-one be false;
	if player is in round lounge:
		say "The hatch above. Well, once you figure how." instead;
	if player is in idiot village and player has bad face and idol is in idiot village:
		say "You can exit to the west, and you might've, earlier, but--you may want to poke around Idiot Village in even some crazy diagonal directions." instead;
	if player is in service community:
		say "You can go pretty much any which way, including diagonally, but you sense that there's only one right way out." instead;
	if mrlp is dream sequence:
		say "There is no escape. You can WAKE, or you can THINK or WAIT to see where the dream goes." instead;
	if player is in freak control:
		say "There's no backing out. You'll want to find a way to take down the [bad-guy]." instead;
	if mrlp is endings:
		say "It looks like you have a small puzzle on how to get out of here." instead;
	repeat with G running through directions:
		if G is viable:
			now got-one is true;
			if G is inside or G is outside:
				say "You can go [if G is inside]in[else]out[end if] to";
			else:
				say "To the [G] is";
			say " [if room G of location of player is visited][the room G of location of player][else]somewhere you haven't been[end if].";
	if got-one is false:
		say "There are no directional exits. You may need a trick or a specific command to get out.";
	the rule succeeds;

chapter xyzzying

xyzzying is an action out of world.

understand the command "xyzzy" as something new.
understand the command "plugh" as something new.

understand "xyzzy" as xyzzying.
understand "plugh" as xyzzying.

carry out xyzzying:
	if player is in freak control:
		say "[one of]Freak Control metamorphs into a basketball court, and try as you might, you can't stop the [bad-guy] from calling fouls constantly in his favor. You feel compelled to play well past when it's not fun, and even when it's not fun for the [bad-guy] to complain any more. To be fair, he DOES let you clean up in garbage time because he's generous and/or bored. Oh. The score?[paragraph break]105-69, of course.[paragraph break]Wait, none of that happened. But you need more than just one word, here. Try two.[or]You don't want to risk a scenario where the [bad-guy] gets a 105 on a test and you get a 69. That'd be wack.[stopping]" instead;
	if player is in out mist:
		say "The ring glows briefly." instead;
	if player is in airy station:
		say "The hammer glows briefly." instead;
	say "A hollow voice booms '[one of][activation of spelling disaster][or][activation of captain obvious][or][activation of no-nonsense][or][activation of comedy of errors][cycling]!'";
	the rule succeeds;

chapter diging

diging is an action applying to one thing.

understand the command "dig" as something new.

understand "dig [something]" as diging.
understand "dig" as diging.

does the player mean diging the poor dirt: it is likely.
does the player mean diging the earth of salt: it is likely.
does the player mean diging the mouth mush: it is likely.
does the player mean diging the t-surf when mouth mush is in lalaland: it is likely.

dirt-dug is a truth state that varies.

rule for supplying a missing noun when diging:
	if player does not have pocket pick:
		say "Nothing to dig with. You try to dig things generally, but it doesn't work[if player is in down ground]. Not even with Fritz around[end if]." instead;
	if player is in garden:
		now the noun is poor dirt;
	else if player is in Vision Tunnel:
		if earth of salt is in Vision Tunnel:
			now noun is earth of salt;
		else:
			now noun is flower wall;
	else if player is in Tension Surface:
		if mush is in Tension Surface:
			now noun is mush;
		else:
			now noun is arch;

carry out diging:
	if noun is Fritz:
		say "You were warned about trying to dig people like Fritz, but you fail to do so, so--no harm, no foul." instead;
	if noun is a person:
		say "Yeah, that's the problem, you don't quite dig other people, but you'd like to." instead;
	if player does not have pocket pick:
		say "You have nothing to dig with." instead;
	if noun is t-surf:
		say "Doing that to a tension surface may release too much pressure. You're pretty good in science, so you worry about these things." instead;
	if noun is poor dirt:
		if dirt-dug is true:
			say "'[activation of man enough]!' says the Weasel, leaving you feeling not man enough." instead; [temproom variety garden]
		say "'Ah, the [activation of work of art]!' the Weasel says as you begin. It throws on a few more aphorisms about exercise and experience and advice that, well, motivate you not to take breaks. 'You've paid off your debt now.'"; [temproom variety garden]
		now dirt-dug is true;
		the rule succeeds;
	if noun is mouth mush:
		say "[one of]Before you can strike, the mouth mush coughs so forcefully, it blows you back. While its breath is surprisingly fresh, it's pretty clear you can't use the pick as a weapon.[or]The mouth mush can defend itself well enough.[stopping]" instead;
	if noun is arch:
		say "It's too big for the pick to make a dent." instead;
	if noun is flower wall:
		say "The flower wall is too pretty to damage. Plus it might collapse." instead;
	if noun is earth of salt:
		now player has the proof of burden;
		choose row with response of weasel-sign in table of weasel talk;
		now weasel is not babbled-out;
		now enabled entry is 1;
		now earth of salt is in lalaland;
		set the pronoun it to proof of burden;
		now pocket pick is in lalaland;
		choose row with response of weasel-pick-oops in table of weasel talk;
		now permit entry is 1;
		choose row with response of weasel-pick-hey in table of weasel talk;
		now permit entry is 1;
		say "With your pocket pick, the work is steady and clean, if arduous. Your cheap pocket pick starts splitting off--why couldn't the earth of salt been [activation of scum of earth] or something easier to hack at?--and it snaps in two with the final blow.[paragraph break]Beneath is a thin plaque. But not just any plaque: a PROOF OF BURDEN. You wipe it off and pick it up, then you bury the pocket pick, which is not only broken but also rusted." instead; [temproom vision tunnel]
	say "That's not soft enough." instead;
	the rule succeeds.

chapter italing

italing is an action applying to nothing.

understand the command "ital" as something new.

understand "ital" as italing.

ital-conc is a truth state that varies.

carry out italing:
	now ital-conc is whether or not ital-conc is false;
	say "Italic concepts are now [on-off of ital-conc].";
	the rule succeeds;

chapter explaining

explaining is an action applying to one visible thing.

understand the command "explain" as something new.
understand the command "xp" as something new.

[understand the command "explain [any thing]" as something new.
understand the command "xp [any thing]" as something new.]

understand "explain [any explainable thing]" as explaining.
understand "xp [any explainable thing]" as explaining.

understand the command "explain [any room]" as something new.
understand the command "xp [any room]" as something new.

understand "explain [any xpable room]" as explaining.
understand "xp [any xpable room]" as explaining.

definition: a room (called mr) is xpable:
	if mr is visited, decide yes;
	let rmr be map region of mr;
	if mr is freak control and questions field is visited:
		decide yes;
	if mr is Nominal fen and pier is visited:
		decide yes;
	if mr is round lounge:
		if jump-level > 0:
			decide yes;
	if rmr is beginning:
		if jump-level > 2:
			decide yes;
	if rmr is outer bounds:
		if jump-level > 2:
			decide yes;

expl-hint is a truth state that varies.

told-xpoff is a truth state that varies;

check explaining when player is in freak control (this is the don't explain when you can clue in FC rule) :
	if noun is power trip or noun is freak out:
		if qbc_litany is table of no conversation:
			say "You don't need to ask for explanations, here. You need to do something." instead;

carry out explaining:
	if debug-state is true:
		now all rooms are visited;
	if accel-ending:
		say "Hmph. You don't want explanations. You put first things first, now, and you just need to get through." instead;
	let found-yet be false;
	if noun is not explainable and noun is not a room:
		say "That doesn't need any special explanation. I think/hope." instead;
	let myt be table of explanations;
	if noun is a room:
		now myt is table of room explanations;
		repeat through table of room explanations:
			if noun is room-to-exp entry:
				say "[exp-text entry][line break]";
				now found-yet is true;
				if noun provides the property explained:
					now noun is explained;
	else:
		d "not room.";
		repeat through table of explanations:
			if noun is exp-thing entry:
				if anno-allow is true and told-xpoff is false:
					now told-xpoff is true;
				if anno-allow is false or no-basic-anno is false:
					say "[exp-text entry][line break]";
					if noun provides the property explained:
						now noun is explained;
				now found-yet is true;
[	repeat through table of explanations:
		if noun is exp-thing entry:
			if anno-allow is true and told-xpoff is false:
				now told-xpoff is true;
			if anno-allow is false or no-basic-anno is false:
				say "[exp-text entry][line break]";
			now found-yet is true;]
	if found-yet is false:
		say "There should be an explanation, but there isn't.";
		the rule succeeds;
	if noun is a room:
		choose row with room-to-exp of noun in myt;
	else:
		choose row with exp-thing of noun in myt;
	if there is an exp-anno entry:
		if anno-allow is false:
			if expl-hint is false:
				now expl-hint is true;
				say "[line break][i][bracket]NOTE: [if ever-anno is true]typing ANNO and explaining again will let you see more details notes on this item and others[else]once you finish the game, you'll get a command that will annotate this more fully, beyond the basics[end if].[close bracket][r][line break]";
			the rule succeeds;
		if there is an exp-text entry:
			say "[line break]";
		say "[exp-anno entry][line break]";
	the rule succeeds.

carry out explaining the player:
	if debug-state is true:
		if out mist is unvisited or airy station is unvisited:
			now all rooms are visited;
		let count be 0;
		repeat with Q running through explainable things:
			if Q is not an exp-thing listed in table of explanations:
				increment count;
				say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) needs an explanation.";
[			else:
				choose row with exp-thing of Q in table of explanations;
				if there is an exp-anno entry:
					say "[Q] has additional explanation.";]
		if count is 0:
			say "Yay! No unexplained things.";
		now count is 0;
		repeat with Q running through rooms not in meta-rooms:
			if Q is not a room-to-exp listed in table of room explanations:
				increment count;
				say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) needs an explanation.";
			else:
				if there is an exp-anno corresponding to a room-to-exp of Q in table of room explanations:
					say "Move anno of [Q] to the table of annotations.";
					increment count;
				unless there is an exp-text corresponding to a room-to-exp of Q in table of room explanations:
					increment count;
					say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) is in the table but needs an explanation.";
		if count is 0:
			say "Yay! No un/over-explained rooms.";
		unless the player's command includes "me":
			the rule succeeds;

section xring

xring is an action out of world.

understand the command "xr" as something new.

understand "xr" as xring.

carry out xring:
	try explaining location of Alec instead;

section xbing

last-bad-room is a room that varies. last-bad-room is smart street.

xbing is an action out of world.

understand the command "xb" as something new.

understand "xb" as xbing.

carry out xbing:
	if last-bad-room is smart street, say "You haven't hit a fake death yet, so there's no bad room to use XB on.";
	try explaining last-bad-room instead;

section explaining rules

does the player mean explaining the player when debug-state is true: it is very likely.

[does the player mean explaining the location of the player when debug-state is false: it is likely.

does the player mean explaining the Insanity Terminal: it is very likely.
does the player mean explaining the fright stage: it is unlikely.

does the player mean explaining a concept in lalaland: it is likely.]

does the player mean explaining something visible: it is likely.

section rxing [e.g. xp without an argument]

rxing is an action applying to nothing.

carry out rxing:
	d "Explaining [location of player].";
	repeat through table of room explanations:
		if room-to-exp entry is location of player:
			say "[exp-text entry][line break]";
			the rule succeeds;
	say "This room needs an explanation.";
	the rule succeeds;

understand "xp" as rxing.
understand "explain" as rxing.

section what is explainable

definition: a thing (called x) is explainable:
	if x is a logic-game, decide no;
	if x is a room, decide yes;
	if x is generic-jerk, decide no;
	if x is a direction, decide no;
	if debug-state is true and x is off-stage, decide yes; [it is going on stage at some point]
	if x is in bullpen, decide yes; [bullpen is for items 'lost' during sleep]
	if x is in lalaland, decide yes;
	if x is in conceptville and debug-state is true, decide yes; [can it ever be in play? In debug, we need to know]
	if x is part of towers of hanoi or x is part of broke flat or x is part of games counter or x is games counter or x is games, decide no;
	if x is t-surf, decide no;
	if x is stool toad and down ground is visited, decide yes; [he does show up before you get to Joint Strip]
	if x is in pressure pier:
		if x is water-scen or x is stall-scen, decide no;
	if x is in disposed well:
		if x is scen-home or x is scen-church, decide no;
	if x is gen-brush or x is hole, decide no;
	if x is nametag or x is bar-scen or x is writing, decide no;
	if x is lcd frown, decide no;
	if player carries x, decide yes;
	if x is Baiter Master, decide yes;
	if x is not off-stage:
		let mrlx be map region of location of x;
		if mrlx is Dream Sequence, decide no;
	if location of x is visited, decide yes;
	decide no;

understand "explain [text]" and "xp [text]" as a mistake ("You've come across nothing like that, yet. Or perhaps it is way in the past by now.")

after explaining out puzzle: [just below, the dots explanation asks a question, if you want it spoiled]
	if the player yes-consents:
		say "[one of][or]Oh no! Forgot already? [stopping]From the lower right, go up-left two, right 3, down-left 3, up 3. It's part of 'outside the box' thinking. But you can also roll a paper into a cylinder so one line goes through, or you can assume the dots have height and draw three gently sloping lines back and forth.";
	else:
		say "Okay."

table of explanations [toe] [alfbyroom]
exp-thing	exp-text	exp-anno
bad knot	"A bad knot is hard to untangle. You wouldn't say it's not bad to untangle. And 'not bad' can have several connotations, itself, from strong to faint praise. So you can tie yourself up thinking of what it means."	--
Broke Flat	"Flat Broke means out of money."	"This was originally a location until I discovered A Round Lounge."
chess board	"Despite being a really good chess player, this always fooled me. I started with a queen in the corner as a kid and got run around, but then as an adult I recognized the virtue of going for an easy solution (no queens in the center) and seeing why it didn't work."	"Starting by disallowing the center 16 squares helped a lot--by sheer number, that's 21/23 squares each queen sees, not 25/27, and then placing any of the queens in the four 2x2 corners makes rows 3-6 unable to match up. Also, I didn't understand symmetry arguments e.g. it's useful to see if we can have a queen 2 from any corner, or one 3 from a corner. It's important not to think of this as 'laziness' if we can start building general principles or eliminate enough cases."
face of loss	"Loss of face means humiliation or loss of respect. A face of loss isn't an official idiom, but here it means you're just sad. You've lost some fun and curiosity."	"This is something I didn't discover until release 2. What's the best way for Alec to seem upset? In retrospect, 'a bad face' should've clicked things earlier, but it happened eventually."
Game Shell	"A shell game is where an operator and possibly an assistant rig a game so that mugs think it's an easy win, but they can't. The most popular one is when they hide a bean under a hollowed shell and shift them around."	"The game shell is a shell game of its own. No matter how much you solve, you won't impress Guy Sweet, and you won't--well--figure the real puzzles you want to, beyond logic etc."
gesture token	"A token gesture is something done as a bare minimum of acknowledgement."	"There were all sorts of tokens this could have been. I decided on gesture because, well, you get something for doing the bare minimum."
hangman	"The strategy of hangman always interested me. I enjoyed finding tough words or even seeing how people squabbled over the rules: how many misses, etc. Of course, there is One Best Strategy, well, until you are up against people who know tricky words."	"Hangman was a late edition to release 3. I remember feeling guilty writing a PERL script to see what words were remaining when I had one guess left in an online game, but it was educational, for all that. And so I think it may be rather neat to look at in any case."
logic puzzles	"I remember marking up books of logic puzzles but thinking they could never ever be practical. I remember having a grease pen over clear plastic so the books could be reused, but I also remember the patterns geting a bit tedious. It wasn't until someone showed me a sample LSAT years later that I thought, really, these are the same thing. Or it's the same process of elimination. Suddenly lawyers seemed less intimidating."	--
match sticks	"I've always enjoyed match stick problems and how some just don't seem likely. While the general trick if not too many are moved is to shift the original picture onto the new one, somehow, there are creative ones with many shifts."	--
necklace	"The seven-link necklace really only has three possibilities: center, next to center, and next to edge, the edge being clearly silly. That said, I felt clever being able to work out the two-link problem on my own way back when, so I put it here."	--
Nim	"Nim was always the toughest to prove, and my 8th-grade self wiped out in Beyond Zork and I had to watch the trees for hints. Once I learned about Strong Induction, the proof made sense. Though I was still impressed anyone would come up with it."	--
out puzzle	"These aren't a pun, but it's something mathy people see a lot of, and motivational speakers tend to abuse it. If you'd like the solution to the four lines to draw to connect all the points, and even other smart-aleck answers, say yes."	--
river boat	"I remember being fooled by the river boat as a kid and then realizing the moves were forced. I was glad to find some variations and even make a decent one in my experimental game Turn Around for the Apollo 18 tribute. It's not big on story, but I like the puzzles and tricks."	--
Rubik's Cube	"The Rubik's Cube is always something I was supposed to be good at. My sister three years older than me bought a solving book I figured I'd be old enough to look at in three years. I never did. Not til I was an adult did I see the methods, and I was surprised how piecemeal and orderly it was. I also remember being very very jealous of Will Smith solving it in an episode of Fresh Prince of Bel Air."	"The Rubik's Cube also has a theme of two things flipped making a big, big difference. That last pair is always a tricky one."
thought of school	"A school of thought is a particular way of thinking held by a specific group. Alec doesn't fit in with any, and so his thought of school is a bit intimidating. Also, a thought of school is generally not about the more philosophical things. If schools do focus on that, people tend not to think too hard about them. They just go ahead and do."
Towers of Hanoi	"ToH is a basic computer science problem, and I remember someone I respected raving how hard it was, and being disappointed how easy the recursive solution was: N to peg X = n-1 to peg Y, bottom to peg X, n-1 to peg Z. That said, it's just awful in practice."	--
off tee	"To tee off is to yell or punch out at someone."	-- [start of a round lounge]
person chair	"A chairperson is someone in charge of things. The person chair is, on the other hand, anonymous and plain."	--
Plan Hatch	"To hatch a plan is to figure a way to do something."	"This was the first real 'puzzle,' and it's not meant to be much of a puzzle. But there are plenty of escape the locked room ideas, and so I wanted to show Alec as learning at least a minimum. I was worried the round stick/screw might be too similar, but I really liked the switched where a noun became a verb and vice versa."
round screw	"To screw around is to do silly unproductive stuff."	--
round stick	"To stick around is to move nowhere."	--
Mouth Mush	"A mush-mouth is someone who talks unclearly or uses weak words."	-- [start of tension surface]
Absence of Leaves	"Leaves of absence means taking time off."	"I wanted Variety Garden to be plain, but I didn't know how to do it without implementation. This looked like a good joke in release 1, but it wasn't until release 2 that I really found the idea of brush, which is hard to tell apart, anyway." [start of variety garden]
aside brush	"To brush aside is to ignore someone as you move past them."	--
back brush	"To brush back is to repel someone or keep them out."	--
off brush	"To brush off is to ignore. It's more ignoring someone's ideas than ignoring them fully."	--
pocket pick	"A pickpocket is a thief."	"The pocket pick is also about the least possibly valuable item you could steal."
proof of burden	"The burden of proof means: you need to come up with evidence to prove your point."	"I had the idea of some sort of document early on, and the Burden of Proof always fascinated me as something others needed less than I did."
Rogue Arch	"An arch-rogue is a big bad guy, obviously inappropriate for early in the story."	--
earth of salt	"Salt of the earth means a great person. It's from back when salt was more valuable."	"This was earth of scum, but I decided that salt would be better, because it'd be more visual, and also it should be something nice and likable but it wasn't." [start of vision tunnel]
Flower Wall	"A wallflower is someone who doesn't participate socially."	"I had trouble with what this should be in the Vision Tunnel, but when I found it I realized it showed Alec being social."
picture hole	"Seeing the whole picture means you see everything."	--
Poor Dirt	"Dirt poor means especially not rich."	--
Basher Bible	"A bible basher is someone who quotes scripture too much. The reverse means a compendium of ways to try and gain power over people and put them down."	"I simply can't believe this one took so much to find! The idea is, people who sell you on your own inadequacy are at least as destructive as, well, Bible-Bashers. But they put on a show and make their audience glad THEY'RE not the ones being cut down, yet." [start of pressure pier]
boo tickety	"Tickety-boo means okay, all right, etc."	"I like the contrast of being told 'Boo!' with the horrible places you're shipped off to, elsewhere. Also, it makes it clear small mistakes are okay."
a side stand	"To stand aside is to get out of the way."	"I had trouble with what was supporting the Basher Bible, until I stumbled on this. I'd thought of a stand for a while, but it seemed like there were too many choices. Then I realized I could just give a different figure of speech if you tried different things."
trail paper	"A paper trail is evidence in white-collar crimes. People often have to piece it together."	--
assignment plum	"A plum assignment is giving someone a particularly prestigious, noticeable, easy or lucrative job. It's one everyone wants." [start of meal square]
basted lamb	"To be lambasted is to be yelled at very loudly."
charred pie	"A pie chart is a graphic that represents percents as part of a pie/circle divided into arcs."
condition mint	"Mint condition is brand new."	"The mint was buggy until release 3, but it was one of the first foods that made me realize Meal Square could be an important location."
cutter cookie	"Cookie-cutter means predictable and formulaic."	"I wound up getting rid of most of the foods I planned for release 1, but I added the whole 'Alec goes bad' on a whim and it went pretty well."
gagging lolly	"Lollygagging is waiting around."	"This is one of the worst puns with the silliest deaths. I'm proud of it!"
greater cheese	"A cheese grater chops up cheese. Also, you do become a bit of a grater if you eat it."	"This was the second of the post-comp bad foods added. It occurred to me that there are lots of ways to be a jerk."
iron waffle	"A waffle iron is what you put batter in to make a waffle. But a waffle is also what you use when you don't know what to say. An iron waffle, then, would be something to say when you don't know what to say--but it is hard to take down."	"Alec of course would not have the confidence to make or use an iron waffle."
Off Cheese	"To cheese someone off is to annoy them."	"I was pleased to see Hulk Handsome wrote Cheesed Off, which I think you'll like, too. Thankfully I checked PC into github before Ryan Veeder's Exposition for Good Interactive Fiction, so I think we can say the two of us both had our own takes on the pun. This was the first of the post-comp bad foods added. It's a failure for Alec in the sense that he becomes the sort of complainer he might be impressed by, but they're not actually BETTER than he is."
opener eye	"An eye-opener is something that makes you realize things. The bad grammar here indicates that your eye, more open, is not really that way, or it's open the wrong way."
picture of a dozen bakers	"A baker's dozen is thirteen, thus counting for the illusion."	"I have no idea what this illusion would look like if drawn, but I wanted to put it there."
points brownie	"Brownie points are uinofficial credit for helping or flattering someone."	"It occurred to me it could be horrible for Alec to try and make friends with the [bad-guy] and thus get the totally wrong ending. I think there's a lot of that, that people like the [bad-guy] try to convince you they're on your side, and so forth. Writing the ending squicked me out more than I thought it would."
spoon table	"A tablespoon is a small measure of something, usually for a recipe."	"The table is bigger than a spoon of course. It originally supported the Basher Bible but seemed more appropriate in Meal Square once I found a replacememt."
thyme burger	"BurgerTime is a retro arcade game where Peter Pepper, the protagonist, goes around shaking pepper at enemies and stepping on burgers to prepare them."	"This is a dumb joke I enjoyed."
Tray A	"Just a tray, contrasted with Tray B."	--
Tray B	"Eating anything on it may betray who you really are."	"This is another thing that dropped out in release 2 and I couldn't believe it was that simple. People were disappointed I didn't clue that it was such a bad idea to eat the Cutter Cookie."
up gum	"To gum up is to slow down a process, often to a halt. I do like cheap silly deaths, too."	"It's always tough to judge if something is too obvious to include or too obvious not to. The main thing is, make sure you do it right with a few side joke riffs. I'm pleased with how I moved in the law enforcement here."
dreadful penny	"A penny dreadful is a trashy novel."	-- [start of down ground]
warmer bench	"A bench warmer is someone who doesn't get into the action, especially in a sports game."	"This may have been fueled by the sleep I needed trying to meet the IFComp deadline. But I've always wanted to try writing a side-dream world, and the idea of SLEEPing into the tense future/past/perfect came quite early on."
fly bar	"A barfly is someone who goes around to bars and gets drunk."	"This was a candidate for the bar name, but it seemed too obvious." [start of joint strip]
Minimum Bear	"Bare minimum is the very least you need to do to get by."	"The old Office Space routine about the bare minimum has stayed with me, especially because I worried about doing the bare minimum to seem I wasn't doing the bare minimum."
Pigeon Stool	"A stool pigeon is someone who tattles."	"The Stool Toad came first, but there was the question of what he sat on."
stickweed	"Stickweed is a generic term for wild plants with various odd fruit, like ragweed (thanks, dictionary.com)."	"I can't believe it took me three releases to find this! It's a nice little cheapo, though."
cooler wine	"A wine cooler is very low in alcohol content."	"I think there's no shortage of silly drink names, and I remember high school days of people poking someone for actually getting wasted on wine coolers." [start of soda club]
haha brew	"Brouhaha is a commotion or noise."	"Puns make me giggle much more than alcohol ever could. Also, the sort of laughs alcohol gives are frequently not too pleasant."
Rehearsal Dress	"A dress rehearsal is the final staging of the play before the audience sees it."	"I'm generally suspicious of fashion that Just Seems Right. The dress is intended to be tasteful but maybe too much in the general style."
chase paper	"A paper chase is excessive paperwork. In this case, work not strictly needed to reach Cute Percy."	"I love puns riffing on bureaucracy, and this was a good one. I'm pleased with this puzzle because it's a simple parity one based on actual physical reality. Too often you can go diagonally 1.4 times as fast as straight. This is neat for Reti's endgame puzzle, but not physically realistic. And I liked having a realistic puzzle in the middle of the abstract murk." [start of chipper wood]
bad face	"The bad face will help you face a bad...something. Also, 'bad' in the Michael Jackson sense of, I did/can do something cool."	"This is meant to show Alec's emotional development. He's figured out something tough, and he's confident about that. But he also doesn't need this to go through the Compound." [start of the belt below]
energy waist	"To waste energy is to do something without positive result. Or it can mean a machine is inefficient."
Insanity Terminal	"Terminal insanity is having no chance to regain sanity[if terminal is in lalaland]. As for the puzzle: it is inspired by Jim Propp's Self-Referential Aptitude Test, which is well worth a look (http://faculty.uml.edu/jpropp/srat.html is one place to find it,) but a good deal more complex[end if]."	"I always wanted to write a puzzle like this, but yeah, in release 1, it was dropped in there."
crocked half	"Half-crocked means drunk."	"This was a bugging doodle for a while until I found something better. You need a lot of placements like that, sometimes." [start of A Great Den]
legend of stuff	"The Stuff of Legend means a book about great tales of yore, as opposed to the scribble-hint-book you get."	"This was another thing that sounded great but didn't seem to fit in anywhere--or seemed too obvious--until I decided to go ahead with the puzzle. It appeared in release 2, taking the functionality of the notes crib."
notes crib	"To crib notes is to copy from someone who was at a lecture."	--
Story Fish	"A fish story is a long winding story."	"The story fish was based on Billy Big Mouth Bass and meant to be as funny-if-it's-not-real." [start of disposed well]
yards hole	"The whole nine yards means everything."	"I have a feeling I missed some idioms, but this one I like because it really can be visualized."
blossoms	"Now that the blossoms are in place, well, it'd be mean to say a blossom is 'some blah.' Oops."	"Flowers are always a safe bet for showing life and decency and all. Just don't make it too cheesy." [start of classic cult]
Googly bowl	"To bowl a googly is to throw someone for a loop."	"I remember a Jerry Seinfeld American Express commercial where he looks to 'learn the lingo' and winds up saying 'That was a wicked googly!' It's still stuck with me, that and the one where goes over $20 filling up for gas but then flashes his card triumphantly. Oh, and the one where he has 31 cents to buy a stamp and has everything except an extra penny."
mind of peace	"Peace of mind means being able to think."	--
Trade of Tricks	"Tricks of the Trade are things that outsiders to a specialty probably don't know that are a bit out of the range of common sense."	"I've read a lot of tricks-of-trade books but most of them are about how you can sucker other people. I have read very few how not to get suckered books, so I decided to put one in here." [start of truth home]
Cold contract	"To contract a cold is to get sick. Also, the contract is pretty cold-blooded."	-- [start of scheme pyramid]
Deal Clothes	"To close the deal means to agree to terms."	"I have a special love for the homonyms I found. They required leaps on my part, and I searched them out aggressively."
fund hedge	"A hedge fund is for super rich people to get even richer."	--
money seed	"Seed money helps an investment. Of course, very few seeds are shaped like a dollar bill."	--
Finger Index	"The index finger is the one next to your thumb. Also, to finger someone means to point them out."	"We've all had secret notes and tabs on everyone else in junior high, and we've been on them or worried about them. This was a sort of slam book. I do think that having tabs on others is something we carry to adulthood, and it helps more in a career than it should." [start of accountable hold]
Sound Safe	"Safe, sound means being out of trouble. Also, the safe isn't very sound, as it's easy to open."	--
Fright Stage	"Stage fright is being scared to get out in front of a crowd."	"I've never been a fan of scaring someone into action. I often feel that people who say they are don't really want to help someone, or never learned it doesn't work." [start of speaking plain]
relief light	"Light relief would be a silly joke."	-- [start of temper keep]
Spleen Vent	"To vent one's spleen is to let our your anger."	"I knew you needed to stuff something down that vent for a while, but I didn't know what."
case basket	"A basket case is a slightly nasty term for someone who doesn't get out much and isn't very good socially." [start of court of contempt]
long tag	"To tag along is to follow behind."	"Between this and a long string, I thought I overused long in the flips, so I was glad I found the Circular."
the Reasoning Circular	"Circular Reasoning is, for instance, I'm smart because I'm clever because I'm smart."	"This might be my favorite flip. It means the obviousd of what you said, and also it rationalizes seeing what you want to see."
Drug Gateway	"A gateway drug leads you to bigger drugs, but here, the gateway may be blocking you from them."	"Drug humor can be in iffy taste, and making Alec a mule felt iffy, but he does need to learn there are some rules worth breaking, or things worth trying. Besides, Fritz deserves a bit of help." [start of walker street]
long string	"To string along someone is to keep them trying or asking for more."	"The string obviously had possibilities for moving somewhere. I thought about making a maze with a string, but Jim Aikin sort of did that in [i]The White Bull[r]."
Mistake Grave	"A grave mistake is a very bad mistake indeed."	"The mistake grave is deliberately nasty to people who don't take enough risks. That's their fault, but it is also the fault of people who take a lot of risks and are jerks about it and set bad examples and convince you you have to be exciting to take big risks."
Language Machine	"Machine Language is very low-level, unreadable (without training) code of bits. No English or anything."	"Some people objected to the machine as being about parser versus choice, but I tried largely to stay away from that. I just liked the image of making a machine happy. And in general I feel it's better to find what sort of game you can write that hasn't been written yet, instead of worrying what art can or should be. I hoped the general silliness would make this clear, but in release 2 I tried to touch things up to avoid misunderstandings." [start of standard bog]
Law Sods	"Sod's Law is also known as Murphy's Law, especially in the UK. In other words, what can go wrong, will. However, Murphy's Law was really that people will always find a reasonable way to do something wrong, though people now use the two interchangeably in the US. TMYK!"
Trick Hat	"A hat trick, in hockey or soccer, is scoring three times."	"This was originally just lying around, then you wore it to do something--but I wanted Alec not to have to rely on any tricks to beat the [bad-guy]."
Witch Sand	"A sandwich is two pieces of bread with something in between."
Poory Pot	"Potpourri, which smells good. Of course, I've read about pipe and cigar snobs who babble on about aromas and such, and apparently there are marijuana snobs too in this progressive time! Perhaps there always were."	"I'm aware of the mispronunciation, but when I was a kid, that's how I mispronounced it, too." [start of pot chamber]
wacker weed	"A weed whacker is the slang for a gardening tool to cut weeds."	"I like the thought of poor Fritz reduced to buying generics, though I suspect he doesn't have a sophisticated palate. It took a while before I accepted that I was going to put drugs in my game, but the more I've learned of the War on Drugs, the more I've seen it's not really about health--and the dealers often aren't really concerned much with clients['] rights or safety."
Book Bank	"A bankbook records numbers and is very un-literary."	"This was a book crack, but a bank feels more contrary to literature." [start of discussion block]
Poetic Wax	"To wax poetic is to, well, rhapsodize with poems or song or whatever. It's slightly less gross than wax."	"There are quack creams for everything these days. Why not for creativity, too? And why not have it work in an imaginary land?"
Song Torch	"A Torch Song is about looking back on a love you can't quite let go of. The Song Torch is more cynical than that, being a bit rougher on its subjects, and, well, actually torching them."	"This was the Song Swan in release 1, which was something, but I think the Song Torch is a bit more focused on pop songs, and besides, I already had a mechanical talking animal with the Story Fish."
Intuition Counter	"Counterintuition means the opposite of what you'd expect. Wait, that could mean counterintuition could mean something crazy. If something's counterintuitive, it works the opposite way you'd expect it to on first glance."	"There are lots of counters that could've been included, but I like how this makes the person intuiting unapproachable, whether or not their assumptions make immediate sense." [start of judgment pass]
Ability Suit	"Suitability means appropriateness. And the suit is not appropriate for the monkey."	"The suit is, of course, contrastable with the Labor Child's clothes as a bit of a hint." [start of idiot village]
fourth-blossom	"To blossom fourth is to grow."	"I have a sense I left a few number pun/flips on the table, but I got this one, I think."
lifted face	"Facelifted means you had surgery done on your face, though Alec's lifted more naturally."	--
service memorial	"A memorial service is what is held to remember someone fondly."
Thoughts Idol	"Idle thoughts, e.g., a wandering mind, are what it purports to oppose."	"I was disappointed the Compound didn't have enough surveillance, and I wanted to put it in the Village, but I didn't want it to just be there. And I wanted a way to beat it."
Trap Rattle	"A rattle trap is a cheap car."	"This felt like the weakest of my items to barter until I realized what it could be used for. I like that, apparently, rattles are for babies, but it shuts up petulant attention-hogging."
against rails	"If someone rails against something, they're upset with it."	"These were in the Variety Garden until release 2, when I realized they'd be better off somewhere more mechanical--oh, and I found the brush, too." [start of freak control]
call curtain	"A curtain call is when someone comes back out after lots of applause."	--
duty desk	"Desk duty is often what police officers are demoted to after a negative incident on the street."	--
frenzy feed	"A feed(ing) frenzy is a vicious attack, physical or emotional, by animal predators or people."	--
incident miner	"A minor incident is not a big deal, but the incident miner makes a big deal of small things."	--
Language Sign	"Sign language is how people communicate with the deaf."	"The language sign is pretty forceful. Plus, I wanted another easy way to tell the player what to do, though they could look around if they wanted to."
list bucket	"A bucket list has things to do before you die."	"This was a big engine in pushing changes for release 2. The [bad-guy] was just sort of there in release 1. But I spruced him up, and I needed something plausible that didn't throw you the list of items to look at too directly."
shot screen	"A screenshot is a graphical capture of what's on your computer screen at the moment."	--
Twister Brain	"The opposite of a brain twister, where someone derives a conclusion from a fact, the brain has a set conclusion and twists and weights facts to line up with them."	--
Witness Eye	"Someone at the scene of the crime."	--
worm ring	"A ringworm is a form of parasite."	"This was originally the wood worm, and it needed to become a whole worm, but I didn't see how to do it. I decided eventually to say it was a whole worm, but you needed to un-bend it, somehow." [start of out mist]
hammer	"The hammer can be three things[ham-desc]."	"Figuring what the hammer should be was a design puzzle for sure. I got a lot of bad puns from it, but the idea of actually having a puzzle that uses word-flipping seemed like a nice way to end the game." [start of airy station]
lock caps	"I THINK YOU KNOW WHAT CAPS LOCK IS, BUT HERE'S A DEMONSTRATION OF WHAT HAPPENS IF YOU LEAVE IT ON."	"I love a joke about all caps, and I needed some way to prevent you from getting in the carriage immediately."
mentality crowd	"Crowd mentality is when everyone believes and does the same thing."
Return Carriage	"Carriage Return is going back to the start of a new line in a document with text. And you are sort of going back to the start, too."	"The Return Carriage was originally the Snowflake Special. That's a good phrase, but it didn't feel right here. The Carriage is obvious, for what it is."
maple	"This is a bad one, with 'LE MAP' if you examine it. Yup. That's it." [start of muster pass]
pen fountain	"A fountain pen is (these days) a typical pen. You don't have to dip it in ink to keep writing. It's less exotic than a pen fountain, of course." [start of Eternal Hope Springs]
consciousness stream	"Stream of consciousness is a form of writing that relies heavily on inner monologue."	"It turns out that Nigel Jayne wrote a game called Gaia's Web which features a Consciousness Stream that actually blends into the game better, so you should definitely give that a check." [start of Brains Beat]
View of Points	"Points of view are opinions." [start of Window Bay]

table of explanations (continued) [toe] [alfbyroom] [the people]
exp-thing	exp-text	exp-anno
Alec Smart	"A smart alec is someone who always has a clever quip."	-- [start of smart street]
Guy Sweet	"Guy Sweet is more of a candy-[a-word] than a sweet guy, but 'sweet guy' is such a terrible compliment as-is. To yourself or others."	--
Word Weasel	"A weasel word is something that seems to mean more than it should."	"I like stories with talking animals, and at Alec's age, people look down on them, so it made sense to subvert that with a mean talking animal." [start of variety garden]
Terry Sally	"Terry Sally has two possible translations: salutary or solitary. He is sort of in between salutary (greeting) and solitary (alone) which fits in with how he probably doesn't get to see many people, but he's social when he does."	"Terry Sally was just the Howdy Boy before release 3. But I wanted to make the Compound a bit more personable." [start of pressure pier]
Fritz the On	"On the fritz means on the blink."	"I'm proud of finding this preposition at the end. I do like poking fun at thinking you're cosmically in tune but aren't. He's probably the NPC I have the most affection for, whether or not you actually do anything to save him." [start of down ground]
Stool Toad	"A toadstool is a mushroom."	"The ST has no proper name because he is a shadowy authority figure. Plus, he's very lazy, just sitting there." [start of joint strip]
Ally Stout	"A stout ally is someone who is on your side no matter what. Ally is, I'm afraid, a bit of a fake."	"The Punch Sucker was the bartender's name through release 2, but it always felt a bit contrived and more like a customer. Ally's name makes it obvious he's, well, on everyone's side." [start of soda club]
Erin Sack	"Saccharine means uncomfortably sweet."	"As much as I liked Liver Lily, this captures things better. Both men and women can be saccharine like this to get you to agree with them. I suppose Aaron Sack would've been an alternative, too."
Cain Reyes	"To raise Cain is to be loud."	-- [start of nominal fen]
Dandy Jim	"Jim Dandy is something excellent."	--
jerks	"[if allow-swears is false]A collective groan is when everyone groans at once[else]. A circle jerk is people getting together and stroking each other's egos. Or, well, something else[end if]. Pick one of the [j-co] by name to see details."	"Figuring out jerk names that fit the puzzle was an arduous thing, and I had many false starts in the final week before IFComp. The result was probably a few actual bugs slipping through."
Paul Kast	"To cast a pall is to give an air of unhappiness."	--
Quiz Pop	"A pop quiz is when a teacher gives an unannounced quiz on materials."	"Of course, we've all had caffeinated cram-sessions for a big paper or exam. Here this is a reward for stuff done."
Silly Boris	"Bore us silly."	--
Warm Luke	"Lukewarm is not really warm."	--
Warner Dyer	"A dire warner has a message for you to keep away."	--
Wash White	"To whitewash is to wipe clean."	--
Cute Percy	"To persecute someone is to make them suffer for who they are[if cute percy is in lalaland]and right per se means literally right, but that's not what matters[end if]."	"Percy was the Assassination Character pre-release 3, but the problem is, he never got close to killing anyone. Still, the name gave me laughs." [start of chipper wood]
Faith Goode	"Good faith."	"Coding Faith and Grace as doing the same thing was something I didn't do in release 1, but then it was a matter of saying if the second noun is Grace, then the second noun is Faith. Or is it the other way around? Well, in either case, if I'd given myself the time, I'd have figured it out." [start of classic cult]
Grace Goode	"Good grace."	--
Lee Bull	"A bully is someone who hurts others physically or emotionally. The opposite of Lee Bull. Sid Lew is referring to 'bull' as his last name as what is to be made fun of. Also, fool-proof means no way to break it, but a Proof Fool could be someone who relies too much on a sure thing before doing anything."	"I kept the Truth Home names abstract and was pleased when Lee Bull dropped out." [start of truth home]
Sid Lew	"Lucid means clear and sensible. Sid Lew relies on tricks to win his conversation."	"I figured Sid Lew while trawling for Slicker City author names, and then I said, well, he's good enough to be a character. When I re-vetted PC, I noticed the Truth Home, which was implemented near the end of release 1, still had abstract names. So I got Sid. But that left the Proof Fool needing a name."
Labor Child	"Child labor is about putting children to tough manual labor."	"I remember many classmates from well-off families who just knew how to manipulate others to get what they wanted. The labor child is like that. The person can hate or love school. The important thing is to be able to play that confidence game." [start of scheme pyramid]
Turk Young	"A Young Turk is a brave rebel."	"I also thought of the YouTube channel Young Turks, where sometimes they cut logical corners for stances I agree with or generally want to." [start of speaking plain]
Uncle Dutch	"A Dutch Uncle gives useful advice."	"This was an idiom I wasn't aware of, but one thing that drives me up the wall is the whole good cop bad cop act, especially where the good cop isn't very good. That's the case here."
Volatile Sal	"Sal volatile is given to wake up unconscious people with its smell."	"Paul Lee in his review mentioned that Volatile Sal was the person he felt most like out of all the NPC's, and I bet he is not the only one. We've all complained about something...or stayed up later than we should worrying...without doing anything." [start of temper keep]
Brother Big	"Big Brother is the character from Orwell's 1984."	-- [start of questions field]
Brother Blood	"A blood brother is someone related by blood or who has sworn an oath of loyalty to someone else."	--
Brother Soul	"A soul brother is one who has very similar opinions to you."	--
Buddy Best	"A best buddy is your favorite friend."	"Buddy Best is probably my favorite NPC aligned with the [bad-guy]. Of course, his 'gift' is really just a self-promotional item." [start of court of contempt]
Pusher Penn	"A pen pusher is someone working at a boring job."	"We don't know Penn's first name. It could be Mark Penn, but that name was a bit too famous--pollster for Hillary Clinton. I think he's shadowy enough, as drug dealers can be, that no first name is appropriate." [start of Pot Chamber]
Art Fine	"Why, fine art, of course. Highfalutin['] stuff, not easy to understand."	"I figured Art out early, but he needed a companion. Phil balanced him nicely and I realized books vs music was a good comparison." [start of discussion block]
Harmonic Phil	"Many orchestras bill themselves as philharmonic. I suppose they could be anti-harmonic, but an Auntie character felt a bit stereotyped, and Auntie feels a bit too charged. Also, Phil Gotsche becomes got your fill, but he doesn't ever get his fill of talking."	--
Officer Petty	"A petty officer is actually reasonably far up in the hierarchy, the equivalent of a sergeant."	"This name made me giggle when I thought of it, and it still does. Perhaps it's too obvious. OP has no first name because he is a Shadow Authority Figure." [start of judgment pass]
Business Monkey	"Monkey business is general silliness."	-- [start of idiot village]
Sly Moore	"More sly = slyer = cleverer."	"I had a lot of fun putting his random clumsy acts together, and I hope you had fun reading them"
Baiter Master	"[if allow-swears is true]Masturbater is someone who--pleasures himself, and it's sort of humblebragging, because the Baiter Master is also great at winning arguments by tactics like, well, playing dumb[else]Messiah Complex means someone believes they're the chosen one, but Complex Messiah could mean they'll save you, but it's not that easy[end if]."	"I had the idea for the bad guy early on, and I wanted to make sure he wasn't anyone specific, though of course certain patterns you see among annoying people need to be exposed." [start of Freak Control]
Francis Pope	"Pope Francis is the current pope as of this game's writing."	"I have a favorable impression of Pope Francis for saying things that need to be said and not double-talking a lot. He may not be perfect, but he does seem to encourage decency in general without ranting and raving. Many people in power (elected or corporate, 'hard' or 'soft' power) could learn from that." [start of Tuff Butt Fair]
Flames Fan	"To fan the flames is to keep things going. The Flames Fan knows when to poke an argument that's about to die down."	"Originally the Flames Fan was one of the [j-co], but then he wound up being the only one without a proper name. He would've made a good F, but I needed someone less abstract. So Cain Reyes slipped in." [start of Ill Falls]
Cards of the House	"The house of cards is something that falls down easily." [start of Humor Gallows]

table of explanations (continued) [this is stuff referred to tangentially, concepts but not actually objects in the game] [xxadd]
exp-thing	exp-text	exp-anno
abuse testing	"Abuse testing means trying to break things with stuff a tester wouldn't usually try, or that they know has broken their own game. Testing abuse is--well, most abuse can feel a bit testing, or trying." [start of general concepts]
Advance Notice	"Advance notice is letting someone know ahead of time."
beaten track	"The beaten track is an experience most everyone's had. To track the beaten, in this case, is to figure who is diverging from 'proper' behavior, where."
break silence	"To break silence is to start talking again."
Captain Obvious	"Captain Obvious is someone who always states what's readily apparent. Captain has a sarcastic meaning, here."
clouds of suspicion	"Clouds of suspicion are a simile for mistrust."
Comedy of Errors	"A comedy of errors is so much going wrong it's funny. Errors of comedy would be so much wrong there's nothing to laugh at."
Compound Problems	"Compound problems are problems that aren't simple or can't be dealt with simply, or that build together to leave someone totally overwhelmed."
cut a deal	"To cut a deal is to make a business arrangement, often favorably. To deal a cut is just to knife someone."
Cut a Figure	"To cut a figure is to make a strong impression."
face the music	"To face the music is to realize you've come up short."
Force of Habit	"Force of habit is what causes you to do something with minimal thinking, for better or worse."
Hard Knock	"A hard knock is physical wear and tear, or being hit hard, versus just knocking at a door."
herd mentality	"A herd mentality is when everyone follows what everyone else is doing."
No-Nonsense	"No-nonsense means, well, not taking any silliness."
passing fancy	"A passing fancy is something that distracts you and is fun for a bit but you forget about it. To fancy passing means to want to go quickly, or fancy passing may just be something in sports."
poke fun	"To poke fun is to make a joke, but poke can mean a lot of things--putter around, meddle, or maybe poke a friend to get their attention."
second thought	"A second thought is looking at something another way, whether to your aid or detriment."
Sitting Duck	"A sitting duck is someone just waiting to be taking advantage of. But if you duck sitting, you aren't waiting."
Spelling Disaster	"Disaster spelling is, well, consonants clumped together. Spelling disaster is leading to bad news."
touch base	"To touch base is to get back to someone or return their call, especially if it's been a while. Versus a base touch, base being mean, so it's a bit more creepy."
turn of phrase	"A turn of phrase is clever wording. A phrase of turn is, well, what's at the command prompt, or, any wording."
u-turn	"A u-turn is when a car swivels in a huge circle to reverse direction. So if something tries to turn you, it bounces back."
wait your turn	"This means not to do anything til someone else goes first. But in this case the game wants you to turn your wait into something else."
wave a flag	"To wave a flag is to give up. To flag something is to note it as particularly productive or unproductive."
acceptable	"Acceptable means good enough. Though sometimes it might not, if someone is just being diplomatic. Able, Except means you're pretty good but have big flaws. So both can feel like backhand compliments." [start of smart street]
beat off	"To beat off is to, well, pleasure oneself. People who are off-beat are often accused of this, among other things, in high school."
Buster Ball	"A ball buster is someone who really presses you hard, verbally or physically. Because the groin is the worst place to have pressure."
Confidence Games	"Confidence games are where someone gains someone else's trust to rip them off. It can be as simple as a shell game or as complex as an investment scheme. Of course, Alec has confidence with logic games but not much else."
first world problems	"The phrase 'first world problems' often is used to mock relatively small-seeming issues."
good egg	"A good egg is a nice person. To egg, or egg on, is to bait someone into doing something you want them to."
Hunter Savage	"A savage hunter is, well, someone with no mercy. Yup, I like the 'dirty' tangential bad guy better, too."
knockwurst	"Knockwurst is a kind of sausage."
Mind Games	"Mind games are messing with people's mind with lies or half-truths. A games mind might be more inclined to abstract puzzles."
power games	"Power games are when people use manipulation to take charge, or when people struggle to control a business, often without voting involved."
charity	"Charity is giving to others while expecting (in theory) nothing in return." [start of a round lounge]
nose picking	"Nose picking is -- not the best habit. A picking nose would be a discerning sense of smell." [start of tension surface]
Animal Welfare	"Animal welfare is concern for animals who often can't help themselves. Welfare has a slightly perjorative definition in the US these days, e.g. people on welfare are lazy, or someone giving it is very generous indeed, more than they need to be." [start of variety garden]
brush up	"To brush up is to refresh your memory of something."
brush with greatness	"A brush with greatness means meeting someone important or doing something potentially awesome."
dirt nap	"Taking a dirt nap means dying."
man enough	"Man enough means being able to stand up for yourself. Okay, it's a bit sexist, but people who say it mean to be annoying. 'Enough, man' just means stop it."
poor taste	"Poor taste means potentially offensive or classless."
sagebrush	"Sagebrush is another form of brush. It's often found in the desert."
work of art	"A work of art is something nice and beautiful. The art of work is--well, the term can be abused to make work seem more exciting than it is."
scum of earth	"Scum of earth is the worst possible person or close to it." [start of vision tunnel]
Bible Belt	"The Bible Belt is a very religious area of the USA." [start of pressure pier]
Boy Howdy	"Boy Howdy is a colloquial expression of surprise."
fish out of water	"A fish out of water is someone or something out of place."
meal ticket	"A meal ticket is something you own that will help you advance socially or economically. It could be physical, or a piece of knowledge, or clout."
palatable	"Palatable means not too tasteless."
take a stand	"To take a stand is to have a firm moral position. To take the stand is slang for being summoned for interrogation in a court of law."
apple pie order	"Apple-Pie Order means very well organized." [start of meal square]
arch deluxe	"The Arch Deluxe was a menu item at McDonald's that was advertised heavily but sold poorly."
astray	"Tray S is astray. In other words, it strayed from Meal Square."
Bowled Over	"Bowled over means unable to deal with things. Over-bold means too confident."
caveat	"A caveat is a stated warning or exception. In other words, something works well, except for certain cases."
coffee break	"A coffee break is when someone drinks coffee while away from work. Break Coffee is about getting very type a."
defeat	"Defeat is, well, a clue you'll lose the game existentially if you eat any of the foods on Tray B."
devil's food	"Devil's food is a rich chocolate layer cake."
ex-tray	"Tray X is an ex-tray."
face off	"An off face probably doesn't look right, but a face off is when you challenge someone, like the game forces you to in the accelerated Tray B endings."
food for thought	"Food for thought is something to think about. Thought for food is thinking too much about food."
Forgive	"Forgive is a clue as to whom to give the mint to, but the person must be forgivable."
gobbling down	"Gobbling down is eating food quickly."
Growing Pains	"Growing pains are temporary setbacks that help you get going. Pain's growing is just a complaint."
hallway	"A hallway is a connection between two rooms."
hash table	"A hash table is used in computer programming as a way to relate non-number values quickly to other things, e.g. people to phone numbers--it's a bit more advanced than arrays."
house special	"The house special is an item on the menu priced to attract people. It is different from the Specialty of the House."
impaler	"An impaler is someone who kills people with sharp objects like swords."
just deserts	"Just deserts means getting what you deserve. After eating the 'sophisticated' cheese, Alec doesn't deserve to enjoy other foods."
loaf around	"To loaf around is to wait with no real purpose."
No-Shame	"No shame means a person isn't embarrassed by anything to the point where it's dangerous. The reverse (Shame? No!) is more, there's a healthier way to look at things than through shame."
order n	"Order n is computer science terminology for taking linear time. For instance, some sorting functions are array n-squared, and some are n log n."
pig out	"To pig out is to eat everything you see. The reverse is an admonishment to leave."
potty	"A potty is a kids['] word for where you go to the bathroom."
quarter pounder	"A quarter pounder is a popular burger at McDonalds."
quisling	"A quisling is a very uncomplimentary word named for Victor Quisling, who worked with the Nazis against his home country of Norway in World War II."
raising hell	"Raising hell means to complain in pretty much any available way."
Snap Decision	"A decision made reflexively, versus a conscious decision to snap e.g. just quit holding back."
Spur of the Moment	"Spur of the moment means you're finally pushed to do something. If you wonder if it's the moment of the spur , you're probably thinking too hard for it to be the spur of the moment."
strike a balance	"To strike a balance is to find a satisfactory compromise. A strike can alo mean--well, your balance went on strike, or you'd fall over."
tea tray	"Trat T is a tea tray. To go with food."
time consuming	"Time consuming means something that takes a long time, though you eat quickly."
treat like dirt	"To treat someone like dirt is to be very nasty to them."
trefoil	"A trefoil is, for easiest visualization, a three-leaf clover."
Beach Bum	"A beach bum is someone who wanders on the beach. Maybe he lives there in a shack too." [start of down ground]
brain trust	"A brain trust is a group of people that help make a decision. A trust-brain, though not an English phrase, might mean a mind that can't make its own decisions."
clip joint	"A clip joint is a place that overcharges customers. A joint clip will help Fritz save on purchases so none is wasted."
Double Jeopardy	"Double jeopardy is being tried for the same crime twice. Making your jeopardy double is just putting you at twice the risk."
drag along	"To drag someone along is to take them with despite their reluctance."
Dream Ticket	"A pair of candidates who, running together, have extremely broad appeal they wouldn't have alone. In Alec's dreams, he's often ganged up on by two people or groups who triangulate him rather differently."
Grammar Police	"Grammar police are people who argue trivial grammar points when something is clear, or there's a much bigger cogent argument. In the Stool Toad's case, he deliberately uses bad grammar for emphasis, like on a 'hard-boiled' cop show."
ground up	"Ground up can mean making something from nothing, or modest resources. But it also means physically ground up, like putting food in a blender."
high and dry	"High and dry means in a good safe position."
high off the hog	"High on the hog means living wealthily. To hog the high would be if Fritz didn't share his, um, stuff."
high roller	"A high roller is someone with a lot of money and prestige."
joint statement	"A joint statement is something made and agreed on by a group of people."
puff piece	"A puff piece is a fawning newspaper article that makes someone out to be better than they really are. A peace puff from smoking marijuana is (we can assume) less socially motivated."
roll a joint	"A joint role is something done together. Rolling a joint is the act of creating a marijuana cigarette."
sleeper cell	"A group of people who blen into a community until they can commit an act of terrorism."
advice	"Advice is, well, telling someone what they should or shouldn't do. A vice ad would be as well, only for the worse." [start of joint strip]
bullfrog	"A bullfrog is not quite a toad. And bull means nonsense. The Stool Toad is probably in no danger of being mistaken for Frog or Toad from Arnold Lobel's nice books."
case a joint	"To case a joint is to search a place thoroughly."
do dope	"To do dope is to use drugs."
job security	"Job security means you have a job it is hard to lose."
killer weed	"Killer weed is slang for especially good marijuana."
Moral Support	"Moral support is helping someone even if you don't have concrete advice. SUPPORT MORAL is, well, a slogan that pushes people around."
Pigeon English	"Pigeon English is broken, grammatically poor English."
stop smoking	"To stop smoking is to quit smoking cigarettes. The Smoking Stop means a place where people can smoke without being harassed."
strip search	"To strip search someone is to remove their clothes to look for something on them, or in them."
bargain	"Gin bar can go to two things: to barge in, or a bargain." [start of soda club]
beer nuts	"Beer nuts is slang for peanuts."
boot licker	"A boot licker is someone who flatters too much."
brew a plot	"To brew a plot is to plan something subversive."
genuine	"Genuine is, well, real and true. Both Ally Stout and his drinks are superficial, as wine is generally not made by machine."
Gin Rummy	"Gin Rummy is a card game, generally not the sort associated with wild binge drinking."
Hip Rose	"Rose hips are ingredients found in tea, which is too non-alcoholic for the Soda Club. Hip is, of course, cool or desirable or with-it."
hit the bottle	"To hit the bottle is to drink."
punch drunk	"Punch drunk is when you are stunned from physical blows."
punch line	"The punch line is the final line in a joke."
punch out	"To punch out someone is to beat them up."
punch ticket	"To get your ticket punched, or punch your ticket, is to get killed."
rum go	"A rum go is an unforeseen unusual experience, as opposed to 'GO' anything which indicates general motivation."
speakeasy	"A speakeasy is a place where illegal alcohol is served."
striptease	"A striptease is, well, what happens at a strip club, where someone slowly removes their clothes."
Sucker Punch	"A sucker punch is an unexpected hit."
tea party	"A tea party is usually non-alcoholic, and people mind their manners. Well, unless it's the political sort, but I won't touch that any further. I really don't want to. I've said enough already."
teetotal	"Teetotal means alcohol-free."
adult content	"Adult content relates to nontrivial sex or violence." [start of Nominal Fen]
air jordan	"Air Jordan is an expensive athletic shoe named after Michael Jordan, maybe the greatest basketball player ever."
anal	"Anal is short for anal-retentive, or over worried about details."
anapest	"Anapest is a common beat for a poem. It can seem singsong."
Anne Frank	"Anne Frank wrote [i]The Diary of Anne Frank[r], a story about a Jewish family hiding from the Nazis in World War II."
ballets	"Ballets are dances that are not especially masculine to enjoy. 'Let's ball' refers to playing more aggressive, masculine sports."
Bandanna	"A bandanna is a scarf you tie around your head. Some people find it rebellious, others not rebellious enough."
beaker	"A beaker is what you pour liquids into in a science experiment."
bechdel	"The Bechdel test is if an author has two females talking about things other than men or sex. Del Beck fails miserably, of course."
beer guts	"Beer guts are increased weight from drinking too much beer."
belial	"Belial is a fallen angel, in some cases, possibly Satan."
Benedict Arnold	"Benedict Arnold was a traitor in the US Revolutionary War."
benevolent	"Benevolent means doing things to help people."
benjamin	"Benjamin is slang for a 100 dollar bill, which features Benjamin Frankin. Jammin['] is old slang for cool."
Bernoulli	"The Bernoulli family were famous and accomplished mathematicians and scientists from around 1700."
Black Mark	"A black mark is something indicating bad behavior."
body slamming	"Body slamming is a particularly painful wrestling move where you pretty much throw a person to the ground."
bognor regis	"Bognor Regis is a town on the south coast of England."
bonhomie	"Bonhomie is just generally being pleasant and fun to be around."
borat	"Borat is Sacha Baren-Cohen's fictitious character who sends up American and European culture."
boring	"Boring is, well, not interesting."
bouncing betty	"Bouncing betty is slang for a land mine."
box score	"A box score describes the basic individual statistics from a sporting event."
broccoli	"Broccoli is a vegetable."
cacophony	"Cacophony is a loud noise."
call girl	"A call girl is a paid female escort."
Cary Grant	"Cary Grant is a movie star from the 40s and 50s."
case sensitive	"Case sensitive means paying attention to capitalization."
casually	"Casually means not really in-depth."
category	"A category is a logical class to divide someone into. In here, Kate fits into an obvious one, but she doesn't quite live up or down to it."
caveman	"A caveman is a pejorative term for someone not very advanced, or someone who doesn't care about their appearance."
cirrhosis	"Cirrhosis is a disease of the liver, often bought on by drinking."
clean break	"A clean break from something is leaving quickly and for good. The jerks haven't broken with their 'clean' secrets yet."
club players	"Club player are pretty good at a sport or game, but they aren't really good."
co-ed	"Co-ed means having males and females in classes together."
cojones	"Cojones is guts--well, a foot below guts, for males. Having cojones means having courage."
commie	"Commie is short for Communist--in this case, MeCom is a private business for your own profit, or the political opposite."
Cotton Candy	"Cotton candy is stringy sugary stuff, often bundled together in a soft ball. People eat it at circuses and fairs and movies a lot."
covfefe	"Covfefe is a nonsense word tweeted out by Donald Trump, probably a typo for coverage."
default	"Default is what you do in the absence of anything else. It can also mean to go broke."
defecate	"To defecate is, well, activity #2 in the bathroom."
dilute	"Dilute means watered down or having lost power."
dirty word	"A dirty word is profanity. 'Word' on its own is slang for agreement."
dust up	"A dust up is a fight."
eBay	"Yes, eBay is not just a website where people sell things, but a verb."
electrocute	"If someone is electrocuted, they're filled with an often lethal dose of electrical current."
enhance	"To enhance is to make better."
evidence	"Evidence is something that supports a conclusion: for instance, a fingerprint is evidence in a robbery or murder case."
expat	"An ex-pat is someone who no longer lives in the country where they were born."
flounder	"To flounder is to try and fail without any progress. It's also the name of a fish."
fluoridated	"Fluoridated water is a subject of many silly conspiracy theories."
full grown	"Full grown means mature, physically or mentally."
gangbusters	"Gangbusters is outdated slang for awesome."
glenn beck	"Glenn Beck is a commentator who was canned by Fox News for too many conspiracy theories."
gorgeous	"Gorgeous is, well, beautiful."
grown up	"Grown up means, well, you've learned and matured."
halfling	"A halfling is a D&D character class, half elf, half human, for instance."
hara-kiri	"Hara-kiri is Japanese ritual suicide."
henry clay	"Henry Clay was a 19th century American statesman who did nearly everything except get elected President."
hidey hole	"A hidey hole is somewhere you can go so you won't be found."
High Fidelity	"High fidelity means music that is translated clearly. It's also a movie staring John Cusack with a famous scene I won't spoil."
Hillary	"Hillary refers to Hillary Clinton, here, and the conspiracy theories directed at her."
hittite	"A Hittite is a now-extinct race of people in the Bible."
homer winslow	"Homer Winslow was the painter of the famous [i]Whistler's Mother[r]."
Howard Stern	"Howard Stern is a long-time radio personality with loud provocative opinions."
humphrey davy	"Humphrey Davy was an 18th century scientist."
Jack London	"Jack London generally wrote about tales of the Wild, especially in Alaska."
james dean	"James dean is an actor from the 50s, in such movies as [i]Rebel Without a Cause[r]"
jeremiad	"A jeremiad is a prolonged rant."
jerk around	"To jerk someone around is to pester them physically or mentally."
jerk off	"To jerk off is to gratify oneself carnally."
jerry built	"Jerry-built means put together hastily."
jim beam	"Jim Beam is a brand of whiskey."
jimmy buffett	"Jimmy Buffett is the sort of singer you either love or hate. He has made some catchy tunes."
johnny rotten	"Johnny Rotten was the lead singer of the Sex Pistols."
joint committee	"A joint committee is a group of legislators from different parts of US Congress."
journeyman	"A journeyman is someone who is maybe not spectacular but who has paid his dues in his field."
junk mail	"Junk mail means letters and fliers you didn't ask for that appear in your (physical or electronic) mailbox anyway."
keepin	"Keepin['] is, well, keeping, or letting someone stay."
kevin spacey	"Kevin spacey is the actor who played Keyser Söze in [u-sus]."
Keyser Soze	"Keyser Söze is the shadowy antagonist of [u-sus]."
kohlrabi	"Kohlrabi is a vegetable."
Laverne and Shirley	"Laverne and Shirley was a TV show from the 70s and 80s about two single female roommates."
Leicester Square	"Leicester Square is in London."
less well	"Less well means, well, not as good as something else. It's a slight mispronunciation of 'Wallace,' but not too much in context. I hope."
lie detector	"A lie detector is something that uses readings from your nerves to detect lies."
lily liver	"A lily-liver is someone who is afraid to go out and do risky things."
Liverwurst	"Liverwurst is a sort of meat which I found tastes nice until it really doesn't, and it's a bit greasy, too. 'Worst liver' may be an exaggeration, but the jerks are not living well."
long johns	"Long johns are pajamas with legs."
lovelies	"Lovelies is a term of endearment."
magnate	"A magnate is a powerful businessperson."
manicured	"Manicured fingernails are generally for women, so Manny being cured of non-masculinity is contradictory."
Mary Sue	"A Mary Sue is a character who is too unbelievably nice. It comes from the tour de force short story A Trekkie's Tale."
mascara	"Mascara is basic make-up for women."
melodious	"Melodious means nice-sounding."
meretricious	"Meretricious means superficially attractive or insincere."
mike drop	"Mike drop is an internet term meaning you've won the argument and there's nothing left to say."
mollycoddling	"Mollycoddling is being overprotective of someone."
monte carlo	"Monte Carlo is a place where you can go to gamble. A Monte Carlo simulation also runs random events many times when it is too hard to calculate probability directly."
mortify	"To mortify someone is to shock their sensibilities."
musical chairs	"Musical chairs is a game where X people run in circles til the music stops, then they try for X-1 chairs, until X is 1."
nancy spungen	"Nancy Spungen was Sid Vicious's lover. He was the bassist for the Sex Pistols."
nihilist	"A nihilist is someone who believes nothing matters."
no-brew	"No brew means no alcohol."
Nolan Ryan	"Nolan Ryan is the Major League Baseball career strikeouts and no-hitters leader."
nookie	"Nookie is sexual activity."
Nose Candy	"Nose candy is slang for cocaine."
Notre Dame	"Notre Dame is a famous Catholic university."
numb bore	"Barnum can become number or numb bore, each of which is less exciting than a carinval barker."
Olive	"Black and green olives are the two main different kinds of olives."
olive drab	"Olive drab is what army privates wear for basic training."
Patrick Henry	"Patrick Henry was a martyr of the American Revolution."
Paul Ryan	"Paul Ryan was the Speaker of the House as of 2017 in the USA."
Pepper	"Black pepper is the ground-up stuff. Green and bell peppers are not especially spicy. Serrano peppers taste hotter."
persephone	"Persephone is the princess of the mythological underworld."
Peter Pan	"Peter Pan is the hero of J. M. Barrie's novel and play, who never grows up."
Plaintiff	"A plaintiff is the party bringing the charge in a court case."
planetary	"Planetary relates to either the Earth, or all the planets in the Solar System."
playboy	"Playboy is probably the most famous 'adult' magazine. It's not particularly raunchy, but people often joke they read it for the articles."
pocket pool	"Pocket pool is a euphemism for self-pleasure."
Pollyanna	"A Pollyanna is someone who is ridiculously optimistic."
Polygamy	"Polygamy is having more than one mate."
polyphony	"Polyphony is music with two things happening at once."
pop cherry	"To pop a cherry is to take someone's virginity."
Potter Stewart	"Potter Stewart was a US Supreme who said he'd know obscenity when he saw it."
pound meat	"To pound your meat is to, well, touch your genitals."
quaalude	"A quaalude is a drug (methaquinone) now in low supply since it is illegal."
Ralph Lauren	"Ralph Lauren is a fashion designer."
record keeper	"A record keeper is someone who keeps track of facts and details."
rectally	"Rectally means up the butt."
recur	"To recur is to happen or appear continually."
red rose	"A white, red, blue or black rose is something that might grow in a garden."
restore	"To restore is to make something more like new, to remove its blemishes."
ring finger	"The ring finger is the one between the middle and the pinky."
rosetta	"The Rosetta Stone helped people translate ancient languages when it was unearthed."
run by	"To run by is to talk to someone and not stay for long."
rusty nail	"Stepping on a rusty nail can give you tetanus."
sausage fest	"A sausage fest is a congregation of males with no females."
says mo	"Says mo['] means someone says or talks more, as opposed to Moses being quiet."
Sharp Barb	"A sharp barb is a stinging, clever insult."
shock jock	"A shock jock is someone who provides deliberately insulting opinions to a wide audience, often on radio."
six-pack	"A six-pack usually refers to six cans of beer held together by plastic rings."
social norms	"Social norms are what is generally expected of people's behavior."
spencer tracy	"Spencer Tracy was a movie actor/leading man in the 1930's and 40's."
spotted dick	"Spotted dick is a sort of sweet pudding."
sweeney todd	"Sweeney Todd was a fictitious murderous barber."
sympathetic	"Sympathetic means caring and willing to listen."
tallywhacker	"A tallywhacker is slang for a male sexual organ."
tear-jerk	"The jerks['] tears may seem a bit fake, and a tear-jerker is something that tries to manipulate you into crying."
terabyte	"A terabyte is a large amount of memory: specifically, 2^40 bytes."
teriyaki	"Teriyaki is a Japanese sauce, or it can be meat cooked in that sauce over an open grill."
terrapin	"A terrapin is a fancy name for a turtle, which is slow and has a shell."
tiebreaker	"A tiebreaker is something used to separate two teams or people that are evenly matched."
turret	"A turret is a small tower, or a side compartment to a plane."
water sports	"Water sports is...well, visit Urban Dictionary to learn it's more than just water polo."
wesley so	"Wesley So became one of the youngest American chess grandmasters ever."
whistler's mother	"Whistler's Mother is a famous painting of an old lady, the mother of the artist."
you buy	"A bayou is a tributary (river leading to bigger water), and the reverse pronunciation is 'you buy.'"
Character Assassination	"Character assassination is an attempt to tarnish someone's good reputation." [start of chipper wood]
Play it Cool	"To play it cool is not to lose your temper. Of course, Percy's chase may make you want to lose your temper."
Sweetheart Deal	"A sweetheart deal is something that works very well for both sides, often obtained unethically. Telling someone to deal often means they have to settle for being ripped off."
woodstock	"Woodstock was a big several day long music party back in 1970."
Terminal Illness	"A terminal illness is one which is bound to be fatal. Illness can also mean full of insults, e.g. very 'ill,' as kids these days say. And said, even in my day!" [start of the belt below]
waste breath	"To waste breath is to speak in vain."
Fish for a Compliment	"To fish for a compliment is to try to manipulate someone into saying something nice." [start of disposed well]
Well Done	"Well done means good job, but 'done' is also a synonym for dead, because you'd fall down the well if you tried to enter it."
cargo cult	"A cargo cult is when islanders cut off from the first world use various instruments and devices to try to get planes filled with material goods to land." [start of classic cult]
crisis	"A crisis is when things are going wrong and something needs to be done, or it will get even worse."
cult status	"Cult status is when a work of art (or person) achieves popularity among a narrow segment of the population. This may or may not be deserved."
defrock	"To defrock is to remove someone's role as priest."
good herb	"The good herb is slang for marijuana."
grace period	"A grace period is time given for someone to learn or understand something, or even to return a book late to the library."
personality cult	"A personality cult is when someone uses a forceful personality to control how others think. It is hard to leave. It can range in size from Jonestown to Stalin in the USSR."
assembly line	"An assembly line is where each person or machine has a specific sub-job in creating a larger product." [start of truth home]
ideological	"Ideological means fixated on specific political ideas and not willing to listen to others."
loser	"A loser is someone who gets things wrong all the time."
mass production	"Mass production is a procedure of efficiently creating many of the same thing using standardized design."
pathologic	"Pathologic behavior is compulsive and anti-social."
psychotherapy	"Psychotherapy is seeing a trained professional for emotional and mental issues."
right to privacy	"Right to privacy is considered a basic human right in democratic societies. It means you have the right to be left alone and not to be arrested for arbitrary reasons."
showerproof	"Showerproof means rain can't get through material."
sid vicious	"Sid Vicious was bassist for the Sex Pistols."
technology	"Technology is, well, newer and better machines."
thp	"Two hundred proof means pure grain alcohol."
turing machine	"A Turing machine is, to oversimplify, a mathematical model of computation."
whole truth	"The whole truth means nothing left out from an explanation."
age four	"Age four is, well, four years old. It is too young to forage." [start of scheme pyramid]
army brat	"An army brat is the child of a military officer. They would be more likely to move than most children."
baby boomer	"The Baby Boomers were the generation born just after World War II. Sometimes referred to as 'The Greatest Generation.'"
bookworm	"A bookworm is someone who reads a lot. A worm is, well, unflattering to call someone."
business casual	"Business casual is less dressy office wear, usually meaning no suit."
child support	"Child support is what one separated spouse pays to another to take care of a child."
labor of love	"A labor of love is something done for its own sake, not for worldly advancement."
slush fund	"A slush fund is money raised for undesignated and often unethical purposes."
code golf	"Code golf is when people are given a task to perform, writing in as few characters of code as possible." [start of speaking plain]
Cry Uncle	"To cry uncle is to surrender, to give up."
Dutch Act	"The Dutch Act is suicide[dutch-off]."
Dutch Courage	"Dutch courage comes from alcoholic refreshment[dutch-off]."
Dutch Reckoning	"Dutch Reckoning is a bill that's too high[dutch-off]."
Dutch Treat	"A Dutch treat is where everyone pays his own way[dutch-off]."
fearlessness	"Fearlessness means scared of nothing. Lessness fear is being scared of becoming less."
hate speech	"Hate speech is talk disparaging someone based on gender, ethnicity, religion or sexual orientation."
platform shoes	"Platform shoes have a big block under them to make you look taller."
Rust Belt	"The Rust Belt defines a working-class rural area in the Midwest, where slicksters like Dutch and Turk would not feel at home."
Show Business	"Show business is the act of entertainment, and the business show's is (purportedly) more practical."
show off	"To show off is to brag about yourself, and the implication is an 'off' show (not as good as it should be) is bad without that."
show our work	"If you show your work, you are showing all the steps to how you got your conclusion."
Stand the Pace	"If you can't stand the pace, it's too fast for you. Turk and Dutch pace the stand because they need a break."
sound asleep	"Sound asleep means, well, hard to wake up." [start of temper keep]
venturesome	"Venturesome means willing to go places."
brass ring	"To grab the brass ring is to achieve a dream goal. It refers to the brass ring on merry-go-rounds." [start of questions field]
Brother's Keepers	"'Am I my brother's keeper?' is what Cain said after killing Abel. The implication is, why should I care about anyone else? The brothers are blackmailed into caring too much--or not being able to help each other just walk off."
contempt of congress	"Contempt of Congress is when someone refuses to answer certain questions before Congress."
foster brother	"A foster brother is a brother not related by birth."
attorney general	"An Attorney General is the highest ranking lawyer in a country or state." [start of court of contempt]
bosom buddy	"A bosom buddy is a best friend."
fair enough	"Fair Enough is what you can say to tell someone you agree with them partially. It has a negative connotation."
lemon law	"A lemon law is something that lets you get your car back if it breaks down quickly after you buy it."
nutcase	"A nutcase is a pejorative term for someone who is crazy, clinical or otherwise, as opposed to Buddy Best's claims he just studies a lot."
prosecutor	"A prosecutor is a lawyer who tries cases for people bringing a legal or civil complaint."
readjust	"To readjust is to try to come to grips with a situation."
Bound and Determined	"Bound and determined means you're set on doing something. A determined bound is set to prevent you from doing something." [start of walker street]
drive into the ground	"To drive something into the ground is to make the point far too obviously and long."
Driving Crazy	"Driving someone crazy is usually not literal, but it means you are annoying them a lot, enough they may want to lash back."
Watkins Glen	"Watkins Glen is a famous racecourse in upstate New York."
wood pusher	"A wood pusher is a chessplayer who plays by rote, so, sort of a double whammy of no fun."
bog down	"If someone or something is bogged down, its progress (physical or mental) is slow or stuck." [start of standard bog]
spell disaster	"To spell disaster is to mean a lot of trouble for someone."
bum a cigarette	"To bum a cigarette is to ask someone for one of theirs. 'A cigarette bum' indicates Penn's disdain for more legal smokables." [start of pot chamber]
crack pipe	"A crack pipe is used to smoke crack cocaine, which is even more illegal and risky than marijuana."
crack up	"To crack up is to lose sanity. To crack down is to oppress someone, or arrest people for possession of contraband. To crack a joke is to tell a joke."
dopamine	"Dopamine is a naturally produced chemical that makes people feel better."
go to pot	"To go to pot is to fall apart due to lack of upkeep."
kilo	"A kilo (gram) is a measure of cocaine. It's a lot, especially since one gram can keep someone fixed for a while."
pop pills	"To pop pills is to take them indiscriminately."
roach dropping	"A roach is a marijuana cigarette or a bug that appears around dirt. A roach dropping, well, what the roach leaves behind."
time capsule	"A time capsule is something people bury for others to dig up much later. A capsule is also what drugs can come in."
vice admiral	"A vice admiral is a high ranking military officer."
weed out	"To weed out people is to create a test to show they are inadequate."
artifact	"An artifact is, in programming, something left over that can be gotten rid of." [start of discussion block]
babel fish	"The babel fish is an item in The Hitchhiker's Guide to the Galaxy (the game and the book) which translates between galactic languages."
Block Arguments	"To block arguments is not to hear an opposing point of view."
Block Creativity	"To block creativity is to get in the way of someone imagining things."
chamber music	"Chamber music is music from an orchestra."
Coals to Newcastle	"Coals to Newcastle means a pointless action. In this case, there are no dark rooms, so you don't need a torch. Reducing a new castle to coals is, of course, pointless, too."
counterculture	"Counterculture is a group of people who live deliberately opposed to society at large."
creative act	"A creative act is when you do something meaningful, spontaneous and unexpected."
Elevator Music	"Elevator music is soft, boring, inoffensive music that plays in elevators. Phil and Art want the play to be a bit more exciting."
lovecraft	"HP Lovecraft is an eponymous writer of horror stories."
philistine	"A philistine is someone who doesn't appreciate the arts."
Play Dumb	"To play dumb is to pretend you don't know something you do, to avoid criticism or to catch someone off-guard. Of course, Phil and Art, after saying this, treat you like you're kind of dumb. Or you can't even ask the name of the play."
shelving the thought	"Shelving the thought means putting aside what you were thinking."
Steal This Book	"Steal This Book was a countercultural guide by Abbie Hoffman. Book this steal refers to 'booking' suspects for a transgression, e.g. a parking fine or ticket."
wax lyrical	"To wax lyrical is to talk endlessly and enthusiastically about something."
world record	"A world record is the best or most someone's ever done something."
career threatening	"Something career threatening may risk not only your job but your ability to get other equal or better jobs. A threatening career is--well, a bit of a racket." [start of judgment pass]
countermand	"To countermand is to order against doing something."
pass the torch	"To pass the torch is to hand off knowledge or responsibility to the next person."
scofflaw	"A scofflaw is someone who breaks minor rules. Perhaps they jaywalk or litter."
Candidate Dummy	"A dummy candidate is one who is there to give the illusion of dissent or choice, or one who siphons off votes from the chosen opponent. The person may, in fact, be quite clever." [start of idiot village]
code monkey	"A code monkey is someone who writes programming code for a living."
grease monkey	"A grease monkey is a manual laborer, especially with machines."
serve you right	"'Serve(s) you right' means you got what you deserved."
village people	"The Village People were a disco band from the 70s. The message when you go west (one of their hit songs) refers to three of their other hit songs."
idle gossip	"Idle gossip is talking about others behind their backs, with no real purpose." [start of service community]
artemis fowl	"Artemis fowl is the intelligent, cocky hero of Eoin Colfer's seven-book series. He's everything the [bad-guy] thinks he is, and more." [start of freak control]
autocratic	"Autocratic means having one person firmly in control."
beholder of the eye	"'Beauty is in the eye of the beholder' is a cliche meaning we see the nice things we want. Here Alec is worried he's seeing oppresion that gives him an excuse to fear."
benefactor	"A benefactor is someone who provides support, emotional or financial."
Beyond Belief	"Beyond belief means something you can't possibly believe in, but belief beyond means more faith than you thought you could have."
breadwinner	"A breadwinner is the member of the family who makes all or most of the money."
Break Jail	"A jailbreak means getting out of jail. Though to break someone is to destroy their spirit."
Break Monotony	"To break (the) monotony is to get a change from something boring."
breaking and entering	"Breaking and entering means forcing your way in somewhere, usually past a security system."
busy work	"Busy work is often given to someone just to keep them occupied."
butter up	"To butter someone up is to flatter them."
carry over	"To carry over is to do or be more than your initial impression."
chowderhead	"A chowderhead is someone who makes silly mistakes."
City Slicker	"A city slicker is what rural people may call someone more urban. It's also the reverse of the name of the sequel to PC."
cruise control	"Cruise control is when you set a car to go at a certain speed. A person on cruise control is going through life and not trying anything new."
curry favor	"To curry favor is to try to get on someone's good side."
Daily Show	"The Daily Show is a very popular comedy/political commentary show on Comedy Central."
degenerate	"Degenerate means without moral values. D is short for defense."
difference of opinion	"A difference of opinion means people disagree but not violently. The [bad-guy] is emphasizing he doesn't think much of you."
disorder	"Disorder means a mess, while an order is telling someone what to do and a dis is an insult. Basically, the [bad-guy] is saying, insulting people for being disorganized helps them get organized. Well, it never helped me."
dual vision	"Dual vision is seeing two things at once, often due to a blow to the head or alcohol intoxication."
elitist	"Elitist means snobbish or stuck-up."
energy crisis	"An energy crisis is when a community doesn't have enough electrical power, or oil, or whatever."
evil eye	"The evil eye is staring at someone to make them uncomfortable."
Ezra Pound	"Ezra Pound was an influential Modernist poet."
face facts	"To face facts is to see the sad truth. In this case, the [bad-guy] is telling you he's telling the truth, which is often--inaccurate. Or it means he's been lying before."
fanatic	"A fanatic is someone who is obsessed about something."
fatigue duty	"Fatigue duty is the drudge work low-ranking members of the military get."
fawn over	"To fawn over is to flatter someone."
following my gut	"Following my gut means relying on instinct."
Freak Out	"To freak out is to make a much bigger emotional display than seems really necessary."
gravy train	"A gravy train is a method for getting rich."
grunt work	"Grunt work is unchallenging work."
guttersnipe	"A guttersnipe is someone of the lowest class, brought up in squalor. To snipe is to take cheap shots, and if you're in the gutter, so much the worse."
half right	"Half right is when you are, well, half right. Being half right is often worse than making a ridiculous statement, because it's more believable. Your right half is your better side."
Howard Dean	"Howard Dean was a candidate for the 2004 US Democratic Party nomination. After placing 3rd in the Iowa caucuses, he had an infamous 'Dean Scream' at a rally with supporters, which sounded worse than it was, because he was close to a microphone that picked it up. Which made him the butt of many jokes for a week. The media realised that everyone was yelling a week later, but the story was too ingrained by then.[paragraph break]DISCLAIMER: the author voted for Dean in the 2004 primary, and seeing/recalling this episode has unlocked how and why some other people acted the way they have over the years."
infomania	"Infomania is always wanting new info. The [bad-guy] pretends he doesn't want it, but it's just fun to have. Mania info is, in this case, malicious gossip about people different the wrong way."
informally	"Informally means without rigid structure, or in a friendly manner."
John Hancock	"Your John Hancock is your signature."
John Oliver	"John Oliver hosts [i]Last Week with John Oliver[r], a popular political satire and commentary show on HBO."
John Stewart	"John Stewart was the longtime host of [i]The Daily Show[r], which became a staple of political satire and commentary."
Johns Hopkins	"Johns Hopkins is a university with a prestigious medical school and pre-med program."
King Henry	"King Henry VIII of England had six wives."
laughingstock	"A laughingstock is someone everyone laughs at. But stock laughing is canned laughter, reflexive laughter at a joke you heard before, or maybe even a laugh track."
Leading Question	"A leading question is one designed to provoke a certain answer. The term is usually used in a court of law."
mistruth	"A mistruth is, well, a statement that's false."
mug shot	"The shot mug may look shot, or beaten-up, but mug shots--photographs of apprehended suspects--are generally very unflattering. Hence the flattering portrait of the [bad-guy] on the mug."
narcissist	"A narcissist is someone that puts their own needs too far ahead of others. This can mean hogging attention or shutting other people who rely on them out."
off the record	"Off the Record means something said privately, often negative. Record the Off means to bring something wrong or different into the open."
order of operations	"Order of operations is how, for instance, a calculator or program prioritizes multiplication, addition, etc. without parentheses."
oscar wilde	"Oscar Wilde was a wit and playwright known for one-liners that poked fun at the human condition."
pad accounts	"To pad accounts is to perform an illegal or unethical manipulation of a company's money, to give yourself more."
paddywagon	"A paddywagon is a police car that carries arrested people."
pea brain	"A pea brain is a mean name for someone who is not very smart."
pharisee	"A pharisee is someone who gives the trappings of morality but is not."
polygraph	"A polygraph is a lie detector. The [bad-guy] is probably looking for lies that aren't there."
Power Trip	"A power trip is when someone is so overcome with their own power, they do mean things to show it off."
pratfall	"A pratfall is a physical fall, or a humiliating error in general."
psychoanalyst	"An analyst is someone who examines data and makes conclusions. Or it could be a psychoanalyst, who interprets a client's concerns and offers solutions.."
putin	"Vladimir Putin is the autocratic leader of Russia as of 2017. He is also alleged to have helped Donald Trump's 2016 Presidential campaign. The tune being whistled is the Russian (former Soviet) national anthem."
race baiting	"Race baiting is when someone mocks another person for their ethnicity."
reactionary	"Reactionary means aggressively wanting things to be how they were, or you thought they were."
red alert	"Red alert is when an enemy attack appears imminent."
relief	"Relief means a break from something, or it can also mean reenforcements."
running gag	"A running gag is a joke that keeps popping up."
salad days	"Salad days are a time when things are going well."
scuzz bucket	"A scuzz, or scum, bucket is a person who is just plain dirty or disgusting. The [bad-guy] is not obviously physically like this."
see if i care	"See if I Care is said to show indifference to a bully or nuisance."
see you later	"See you later is a way to say good-bye."
serve one right	"To serve one right is to give someone what they deserved, usually to their detriment."
sly dog	"'You sly dog' is a compliment for someone who is very subtly clever."
stake a claim	"To stake a claim is to claim ownership of something."
stand out	"To stand out is to be different from the rest."
stupor	"A stupor is when you are conscious but not really aware of what's going on."
taste buds	"Taste buds are what you use to experience the sensation of taste."
Trevor Noah	"Trevor Noah is the current (as of 2017) host of [i]The Daily Show[r], which has become a staple of political satire and commentary."
Tucker Max	"Tucker Max was alleged to have spanwed the 'fratire' genre, which features cynical 'tell it like it is' writing full of sex and hedonism and self-centeredness. It's the reading equivalent of sitting next to a guy bragging at a bar for a long time. An intelligent guy, sure, but that just lets him bang on longer. Imagine PG Wodehouse's Bertie Wooster without any heart."
Wallace Shawn	"Wallace Shawn is the actor who played Vizzini ('INCONCEIVABLE!') in The Princess Bride. He's also a critically acclaimed writer."
Wire Fraud	"Wire fraud is a financial crime designed to cheat people out of money."
zeroin	"To zero in is to focus, and you do, on getting out of the Break Jail."
mistracing	"Mistracing means to trace incorrectly. In this case, to trace your way back to the worm ring." [start of out mist]
mystify	"To mystify is to confuse someone greatly."
case insensitive	"Case insensitive means not worrying if a letter is in upper or lower case. In other words, not needing caps-lock." [start of airy station]
clear waivers	"To clear waivers in pro sports is when your team releases you and no other team signs you."
gangplank	"A gangplank leads out of a boat and into the sea. So it is a method of killing prisoners no longer useful." [start of criminals' harbor]
hate crime	"Hate crime is an illegal act directed specifically against victims based on gender, sexual orientation, race or religion."
Boss Fight	"A boss fight is a confrontation with an important adversary in a more traditional game, while the Fight Boss has you do stuff worse than level grinding." [start of fight fair]
Sore Loser	"A sore loser is someone who is not gracious enough to admit defeat. A loser sore is often what you get when you lose a fight, especially one someone else started."
corporal punishment	"Corporal punishment is any form of bodily physical punishment." [start of hut ten]
generalist	"A generalist is someone who focuses on the big picture."
steel will	"A steel will means you don't bend to others." [start of in-dignity heap]
self sufficient	"Self-sufficient is when you can take care of yourself without outside help." [start of maintenance high]
prisoners of war	"Prisoners of war are people captured in combat. Using prisoners to help with a war is not very Geneva Convention." [start of punishment capitol]
Censorship	"Censorship is institutionalized shutting people up or repressing what they have to say." [start of shape ship]
Courtship	"Courtship is when you start trying to get the attention of a potential romantic partner."
Scholarship	"A scholarship is a money grant given towards education. The Ship Scholar, contrarily, says nothing is free."
road pizza	"Road pizza is poor helpless animals that have been hit by traffic." [start of rage road]
Complain Cant	"Cant means a tendency towards something, so someone with a complain cant would only say 'can't complain' very ironically." [start of endgame]
Much Flatter	"If your world is much flatter, it isn't very exciting. But to flatter much is to over-compliment people, which makes things [i]seem[r] exciting for a bit."
People Power	"People power was a rallying cry in demonstrations against the authoritarianism of, well, power people."
Received Wisdom	"Received wisdom is generally accepted knowledge which is often not true, such as how we only use 10% of our brain. Gustave Flaubert wrote a fun book called The Dictionary of Received Wisdom that makes fun of many such examples. For instance, a hamlet is always charming."
Something Mean	"Mean something = talk or act with purpose. Something mean = well, nastiness."

to say u-sus:
	say "the film [italic type]The Usual Suspects[roman type]"

to say dutch-off:
	say "[one of]. This is viewed, according to idioms.freedictionary.com, as insulting to the Dutch. It certainly isn't flattering[or]. Again, potentially not the politest[stopping]"

table of room explanations [tore]
room-to-exp	exp-text	exp-anno
Smart Street	"Street Smart means knowing your way around tricky people and situations. Alec is not, to start."
A Round Lounge	"To lounge around is to sit and do nothing--the opposite of what you want to do here."
Tension Surface	"Surface Tension is a scientific phenomenon where water can stay over the top of a glass."
Vision Tunnel	"Tunnel vision is only being able to see certain things--particularly what's just in front of you--due to mental or physical blocks."
Variety Garden	"Garden variety means ordinary."
Pressure Pier	"Peer pressure is when others in your social circle try to get you to do something."
Meal Square	"A square meal is a full meal."
Down Ground	"Ground down means worn out."
Joint Strip	"A strip joint is a gentlemen's club. Under 18 are not let in, and it's not just because of alcohol."
Soda Club	"Club soda is tonic water e.g. water with bubbles and no flavoring."
Nominal Fen	"Phenomenal means really awesome. But the fen is pretty plain[if boris is in lalaland]. Marshmallow means soft[end if]."
Chipper Wood	"A wood chipper puts in logs and spits out small wood chips. It's hard to be chipper (happy) if you get stuck in one." [west-ish]
Disposed Well	"To be well disposed is to be agreeable."
Truth Home	"A home truth is an unpleasant fact about oneself."
A Great Den	"To denigrate someone is to cut them down. This used to be Bottom Rock (rock bottom is the very bottom, usually emotionally more than physically,) but that felt too transparent."
The Belt Below	"Below the belt describes a cheap shot, more specifically, a low punch in boxing."
Classic Cult	"A cult classic is a movie that appeals to a small but devoted audience."
Scheme Pyramid	"A pyramid scheme is where one person gets multiple clients to pay into an 'investment' for later, and they find several, and so forth."
Accountable Hold	"To hold accountable is to place the blame or praise on someone."
Judgment Pass	"To pass judgment is to, well, judge." [east-ish]
Idiot Village	"The village idiot is the person everyone looks down on. On whom everyone looks down. Oh, never mind."
Service Community	"Community service is doing good without expecting pay. Although it can also be ordered charity work in place of jail time, for minor crimes like vandalism."
Speaking Plain	"Plain speaking doesn't use many tricks." [north-ish]
Walker Street	"A streetwalker is--well, a woman of the night. And walking is, well, less 'fast' or exciting or daring than driving."
Pot Chamber	"A chamber pot is the predecessor of the toilet."
Standard Bog	"Bog standard means boring and average."
Court of Contempt	"Contempt of court is when someone refuses to speak when ordered, or they speak out of turn."
Questions Field	"To field questions is to listen to what people have to ask."
Discussion Block	"To block discussion is to no longer allow talking on a subject."
Temper Keep	"To keep your temper means not to lash out at anyone."
Freak Control	"A control freak is a micromanager who insists people do things a certain way."
Airy Station	"Stationary is standing still. Oh, and the homonym people often wonder about: stationery is stuff you write letters on." [endings]
Out Mist	"If someone missed out, it means they didn't get to see or do something neat."
Punishment Capitol	"Capital punishment is the death penalty, an eye for an eye and so forth." ["loser" locs]
Hut Ten	"Ten-hut is military parlance for ATTENTION!"
A Beer Pound	"To pound a beer is to drink a beer."
In-Dignity Heap	"To heap indignity on someone is to shame them and make them look bad."
Shape Ship	"Ship-shape means orderly."
Criminals' Harbor	"To harbor criminals is to protect them from the law."
Maintenance High	"High Maintenance means you need constant watching over."
Fight Fair	"A fair fight is when two people are evenly matched."
Tense Past	"Past tense is I knew, versus I know/I will know." [sleepytime]
Tense Present	"Present tense is I know, versus I knew/I will know."
Tense Future	"Past tense is I will know, versus I knew/I know."
Route	"Route One is the most direct way through." [rejected locations]
Muster Pass	"To pass muster is to be good enough."
Chicken Free Range	"A free range chicken is one that is not cooped up in a henhouse."
Tuff Butt Fair	"Fair but tough means--well, hopefully, a balanced view of things."
Ill Falls	"If someone falls ill, they get sick."
Eternal Hope Springs	"'Hope springs eternal in the human breast' is a line from Alexander Pope's [i]Essay on Man[r]."
Brains Beat	"To beat your brains is to strain for an idea."
Rage Road	"Road rage is when drivers are upset at traffic jams or other drivers['] actions."
Mine Land	"A land mine is something hidden that explodes if you step on it."
Humor Gallows	"Gallows humor is a laugh when you're facing something very bad indeed."
Madness March	"March Madness is the 68-team knockout-style college basketball tournament held every year in, well, March. It's 68 and not 64 because mo['] games mo['] money, I mean, a few more teams get to make it in and play in a preliminary round."
Window Bay	"A bay window is pretty much from floor to ceiling."
Camp Concentration	"Well, the reverse is a very large tragedy indeed." [just-ideas rooms]
Expectations Meet	"To meet expectations is to do as well as you hoped."
Perilous Siege	"The Siege Perilous is where only Galahad got to sit."
Robbery Highway	"Highway robbery is slang for a very unfair price."
Space of Waste	"A waste of space is something that doesn't belong where it is."
Clown Class	"The class clown is the one who makes jokes or is the butt of them."
Everything Hold	"To hold everything is to do nothing and wait."
Shoulder Square	"Square Shoulders means strong."

to say ham-desc:
	let grt be indexed text;
	now grt is "great";
	choose row with brief of grt in table of verb-unlocks;
	say "[if found entry is true]: AWAY HAMMER = hammer away = keep trying, HOME HAMMER = hammer home = to make a point forcefully, LOCK HAMMER = hammer lock = a wrestling hold[else] I can't spoil yet[end if]";

chapter xpoffing

xpoffing is an action out of world.

understand the command "xpoff" as something new.

understand "xpoff" as xpoffing when ever-anno is true.

no-basic-anno is a truth state that varies.

carry out xpoffing:
	unless anno-check is true or "anno" is unlock-verified:
		say "You may've stumbled on a command you shouldn't be aware of yet. This is meant to be used in conjunction with the ANNO command. So I'm going to reject it until you specifically ANNO." instead;
	now told-xpoff is true;
	now no-basic-anno is whether or not no-basic-anno is true;
	say "Basic explanations now [if no-basic-anno is true]don't [end if]appear with ANNO annotations.";
	the rule succeeds;

chapter noteing

noteflating is an action out of world.

notenuming is an action applying to a number.

roomnoteing is an action applying to one visible thing.

notethinging is an action applying to one visible thing.

understand the command "note" as something new.

understand "note" as noteflating when anno-allow is true.

understand "note [any thing]" as notethinging when anno-allow is true.

understand "note [number]" as notenuming when anno-allow is true.

understand "note [any room]" as roomnoteing when anno-allow is true.

understand "note" and "note [text]" as a mistake ("NOTE can only be used while ANNO is on.") when anno-allow is false.

carry out notethinging:
	if there is an exam-thing of noun in table of annotations:
		choose row with exam-thing of noun in table of annotations;
		if location of noun is visited:
			say "Notes for [noun]: [anno-long entry][line break]";
		else:
			say "You haven't seen this item yet, so I'm not going to give you the annotation yet.";
		the rule succeeds;
	say "No special notes there. XP is probably all you can get." instead;

carry out roomnoteing:
	if there is an anno-loc of noun in table of annotations:
		choose row with anno-loc of noun in table of annotations;
		if noun is visited:
			say "Notes for [anno-loc entry]: [anno-long entry][line break]";
		else:
			say "You haven't seen this room yet, so I'm not going to give you the annotation yet.";
		the rule succeeds;
	say "Well, there should be a note for this room, but there isn't." instead;

carry out noteflating:
	say "You should be able to NOTE (location) for any location you visited with annotations on. In addition, you should be able to NOTE (item) or NOTE (number) for the number of an item.";
	say "[line break]";
	if cur-anno > 1:
		say "Here is a list of the notes so far:[line break]";
		repeat with X running from 1 to cur-anno:
			show-anno X;
	else if cur-anno is 1:
		say "There is only one note so far.";
		show-anno 1;
	else:
		say "You haven't examined any items with annotations yet. If you used them successfully and forget to examine them, they will appear in the long list.";
	the rule succeeds;

to show-anno (X - a number):
	unless there is an anno-num of X in table of annotations:
		say "Oops, there should be a footnote for that, but there is not. [bug]";
		continue the action;
	choose row with anno-num of X in table of annotations;
	say "[X]. [exam-thing entry][line break]";

carry out notenuming:
	if the number understood < 1 or the number understood > cur-anno:
		if cur-anno is 0:
			say "Nothing to annotate yet!" instead;
		if cur-anno is 1:
			say "There's only one annotation, #1, so far. Explore a bit more!" instead;
		say "You need a number between 1 and [cur-anno]." instead;
	unless there is an anno-num of number understood in table of annotations:
		say "Oops, there should be a footnote for that, but there is not. [bug]";
		continue the action;
	choose row with anno-num of number understood in table of annotations;
	say "Notes for [exam-thing entry]: [anno-long entry][line break]";
	the rule succeeds;

chapter verbing

verbing is an action out of world.

understand the command "v" as something new.
understand the command "verb" as something new.
understand the command "verbs" as something new.
understand the command "command" as something new.
understand the command "commands" as something new.

understand "v" as verbing.
understand "verb" as verbing.
understand "verbs" as verbing.
understand "command" as verbing.
understand "commands" as verbing.

to say 2da:
	say "[if screen-read is false]--[end if]";

to say equal-line:
	say "[if screen-read is false]==========[end if]";

in-verbs is a truth state that varies.

this is the special-verb rule:
	if mrlp is Dream Sequence:
		if in-meta is false:
			say "There aren't too many verbs in the Dream Sequence.";
			say "THINK or WAIT/Z moves the dream, and you can also LOOK. Your 'inventory' is strictly mental.";
			say "You can also WAKE[if caught-sleeping is true], which is the only way to get out now the Stool Toad caught you[end if].";
		the rule succeeds;
	if player is in freak control:
		if in-meta is false:
			say "There may be a special command or two you need to get the [bad-guy]'s attention.";
		the rule succeeds;
	if player is in out mist:
		if in-meta is false:
			say "There may be a special command or three you need to manipulate the worm-ring more, well, enterable.";
		the rule succeeds;
	if player is in airy station:
		if in-meta is false:
			say "There may be a special command or three you need to manipulate the hammer into something more powerful.";
		the rule succeeds;
	the rule fails;

to say sr-sp:
	say "[if screen-read is true] [end if]";

carry out verbing:
	consider the special-verb rule;
	if the rule succeeded:
		say "This is a slightly restricted area, so you don't need extra verbs." instead;
	say "[one of]The Problems Compound has tried to avoid guess-the-verb situations and keep the parser simple.[line break][or][stopping]Verbs needed in The Problems Compound include:[paragraph break]";
	now in-verbs is true;
	if player is in smart street:
		say "[2da]PLAY/TRY any of the games in the shell.";
	say "[2da]directions ([b]N, S, E, W, IN, OUT, ENTER[r] something, and occasionally [b]U[r] and [b]D[r])[line break]";
	say "[2da][b]OPEN X[r] (no WITH second noun needed)[line break]";
	say "[2da][b]GT[r] or [b]GO TO[r] lets you go to a room you've been to.[line break]";
	say "[2da][b]GIVE X TO Y[r] for people, [b]PUT X ON/IN Y[r] or [b]ATTACH X TO Y[r] for inanimate objects.[line break]";
	say "[2da][b]TALK/T[r] talks to the only other person in the room. [b]TALK TO X[r] is needed if there is more than one.[line break]";
	if "anno" is unlock-verified or anno-check is true:
		say "[2da][b]ANNO[r] toggles annotations, which are currently [on-off of anno-check], [b]NOTE[r] lets you recall an area or item, and [b]JUMP[r] will send you between the director's cut area and the main area.";
	if jerk-who-short is true and silly boris is not in lalaland:
		say "[2da][b]WHO[r] tells the [j-co]['] names. [b]THINK[r] reminds you who likes what. [b]SKIP[r] skips to the next jerk to accuse.";
		say "[2da][b]SHORT[r] abbreviates the conversation topics.";
	if know-babble is true:
		say "[2da][b]BROOK BABBLING[r] lets you talk to someone and skip over a conversation's details[if ever-babbled is true]. It can be shortened to B[sr-space]B, with or without a space[end if]. You can even specify a person if there's more than one to talk to, e.g. [b]BROOK HIM[r] or [b]BB HER[r].[line break]";
	if player is in belt below and terminal is in belt below and x-term-yet is true:
		say "[2da]X 1-8 is a shortcut to read an individual question in the Insanity Terminal's puzzle.";
	say "[2da]specific items may mention a verb to use in [b]CAPS[r], e.g 'You can [b]SHOOT[r] the gun' or 'You can [b]SHOOT[r] the gun [b]AT[r] something,' but otherwise, prepositions aren't necessary.";
	say "[2da]conversations use numbered options, and you often need to end them before using standard verbs. [b]RECAP[r] shows your options.";
	say "[2da]other standard parser verbs apply, and some may provide alternate solutions, but you should be able to win without them.";
	say "[2da][b]EXITS[r] shows the exits. While these should be displayed in the room text, you can see where they lead if you've been there. [b]PE[r] also toggles showing them in the header.";
	say "[2da][b]META[r] describes additional commands not critical to winning the game[if verbs-unlocked], and V[sr-sp]X gives verbs you unlocked[end if], but this list is long enough.";
	if in-beta is true:
		say "Beta testers have debug commands. See debug commands too?";
		if the player yes-consents:
			list-debug-cmds;
	now in-verbs is false;
	the rule succeeds;

to decide whether verbs-unlocked: [I could probably check "duck sitting" but best to be thorough]
	repeat through table of vu:
		if found entry is true and expound entry is true, decide yes;
	decide no;

to list-debug-cmds:
	say "[line break]DEBUG COMMANDS: ================[line break][2da]J jumps you to the next bit from the Street, Lounge, Surface or Pier.[line break][2da]MONTY toggles every-move actions like listening and smelling. It may be more for programming testing[line break][2da]ACBYE/CTC/CTP gets rid of Cute Percy and chase paper.[line break][2da]JERK tells you what to do with the [j-co].[line break][2da]JFIX fixes the [j-co] puzzle[line break][2da]JGO gets rid of them[line break][2da]BROBYE kicks the Keeper Brothers out.[2da]VIC gives regular victory, VICX gives extra good victory[line break][2da]FIN shows the finger-index cheat code for the [j-co][line break]";

chapter vxing

vxing is an action out of world.

understand the command "vx" as something new.
understand the command "v x" as something new.

understand "vx" as vxing.
understand "v x" as vxing.

carry out vxing:
	unless verbs-unlocked:
		say "You haven't unlocked any jump verbs yet." instead;
	say "This is a list of extra jump verbs. They're not valid past Smart Street, though hopefully the rejects are interesting.";
	repeat through table of vu:
		if found entry is true:
			if brief entry is "anno":
				say "[b]ANNO[r] toggles if annotations are on. Once it is, you can [b]NOTE[r] a room or object. You can also [b]JUMP[r] to or from a director's cut area[if mrlp is rejected rooms], where you are now[else if route is visited], which you've already been to[end if].";
			if brief entry is "track":
				say "[2da]TRACK BEATEN doesn't jump physically, but it does let you solve the jerks' puzzle.";
	repeat through table of vu:
		if found entry is true:
			if brief entry is not "track" and brief entry is not "anno":
				say "[2da][descr entry][line break]";
	the rule succeeds;

chapter metaing

metaing is an action out of world.

understand the command "meta" as something new.

understand "meta" as metaing.

in-meta is a truth state that varies.

carry out metaing:
	now in-meta is true;
	consider the special-verb rule;
	now in-meta is false;
	if the rule succeeded:
		say "This is a slightly restricted area, so if you're stuck, meta-verbs won't help. See them anyway?";
		if the player yes-consents:
			do nothing;
		else:
			say "OK." instead;
	say "Meta-commands:[line break]";
	say "[2da]you can also type [b]ABOUT[r] or [b]CREDITS[r] or [b]HISTORY[r] or [b]TECH[r] to see information on the game's history.";
	say "[2da][b]XP/EXPLAIN[r] (any object or room) gives a brief description. XR explains the current room name[if last-bad-room is not smart street], and [b]XB[r] shows the last 'bad' room[end if]. [b]XP[r] can also explain a concept[one of], e.g. when Guy Sweet says 'you have a Games Mind,' you can [b]XP GAMES MIND[r] or XP [b]MIND GAMES[r][or][stopping]. This is more for general information than game hinting. You can also use [b]ITAL[r] to toggle italics for silly flippable ideas(currently [on-off of ital-conc]).";
	say "[2da][b]HELP/HINT/HINTS/WALKTHROUGH[r] will redirect you to the PDF and HTML hints that come with the game. [b]THINK/SCORE[r] gives very broad, general hinting.";
	if cur-anno > 0:
		say "[2da]NOTE (number or text) displays a previous note you uncovered." instead;
	the rule succeeds;

chapter hinting

understand "help [text]" as a mistake ("[if-stuck]").
understand "hint [text]" as a mistake ("[if-stuck]").
understand "hints [text]" as a mistake ("[if-stuck]").
understand "walkthrough [text]" as a mistake ("[if-stuck]").

understand "help" as a mistake ("[if-stuck]").
understand "hint" as a mistake ("[if-stuck]").
understand "hints" as a mistake ("[if-stuck]").
understand "walkthrough" as a mistake ("[if-stuck]").

to say if-stuck:
	say "If you're stuck, the game should come with a brute-force HTML walkthrough, an Invisiclues-style HTML document, and a PDF document with a map followed by move-by-move walkthrough[if player has legend of stuff]. Also, you can just read the Legend of Stuff. If that's flaky, please do report a bug at [email][end if][paragraph break]SCORE gives very broad general hinting.[no line break]";

chapter creditsing

creditsing is an action out of world.

understand the command "credits" as something new.

understand "credits" as creditsing.

carry out creditsing:
	say "I was able to bounce technical and non-technical ideas off several other people. Wade Clarke (not Clark Wade,) Marco Innocenti, Hugo Labrande, Juhana Leinonen, Brian Rushton and Matt Weiner offered testing and general encouragement and insight on what was a VERY short deadline given the game's size. An anonymous tester provided other direction.[paragraph break]";
	say "Jason Lautzenheiser's work on Genstein's Trizbort app (www.trizbort.com) was invaluable for big-picture planning and for adding in ideas I wasn't ready to code. If you are writing a parser game, I recommend it. (Disclaimer: I am a contributor, too.)[paragraph break]";
	say "====IN-COMP THANKS:[line break]";
	say "I'd also like to thank non-competitors who alerted me to flaws/bugs in the comp version: Olly Kirk, Paul Lee, Michael Martin, David Welbourn and Al Golden. Competitors offered both praise and criticism which helped add features and polish to the post-comp release.";
	say "[line break]====POST-COMP THANKS:[line break]";
	say "Thanks to Neil Butters and Joey Jones for finding lots of fixables present in the comp and post-comp release. Wade and Juhana came back for more.[line break]Thanks to Alex Butterfield and Hugo Labrande for our games of code tennis, which is basically, try and do something every other day, or the other guy scores a point. Hugo worked with me more on a 'related project,' but a lot of things I pinged him with were relevant here. I recommend code tennis for anyone who needs motivation.";
	say "[line break]====GENERAL HELP:[line break]";
	say "Many people gave valuable help along the way with ideas big and small. Robert DeFord, Harry Giles and Steven Watson had ideas for the white paper and direction, as did the Interactive Fiction Faction, a private Google group. They include Hanon Ondricek, Robert Patten, Miguel Garza, Matt Goh, Jim Warrenfeltz and Joseph Geipel.[paragraph break][paragraph break]Many websites and resources helped me discover silly phrases. TECH has this.";
	the rule succeeds;

chapter abouting

abouting is an action out of world.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	say "The Problems Compound is meant to be less puzzly than my previous efforts. If you need to see verbs, type VERBS. Though there's no hint command, a walkthrough should be included with the game.";
	say "[line break]TPC is not intended to be esoteric or profound, but I hope it takes a funny tack on being overwhelmed and not quite able to deal with some social stuff, yet. The general atmosphere of silliness was inspired by Hulk Handsome's very fun 2012 IFComp entry, [i]In a Manner of Speaking[r], and leans heavily on my 'researching' a website that you can find in TECH. Actually, Yakov Smirnoff's 'reversal' jokes, while much gentler than this game, probably inspired me in some way to look at...this sort of thing.";
	say "[line break]As for more direct help, CREDITS lists my testers first, because they put up with some [activation of abuse testing] (bugs, vagaries) etc. whether or not they were abuse-testing. They helped make the game less rocky and found bugs that saved me time when I had (yet again) procrastinated.[paragraph break]Also, if you want, HISTORY will contain details about the game's history, and TECH will describe some technical stuff you may find helpful in your own games.";
	say "[line break]One other thing. If you find bugs, send them at [email] or visit the repository for the game at [my-repo]. If you can take a transcript of how it happens, use the TRANSCRIPT command and attach the file. Oh, also, I'm on twitter as @ned_yompus.";
	the rule succeeds;

chapter historying

historying is an action out of world.

understand the command "history" as something new.

understand "history" as historying.

carry out historying:
	say "I originally thought up this game in November of 2013. It had a completely different name, which I like a lot, but it didn't fit. PC went through several other names which sounded good but not good enough. The basic idea behind most room names etc. was unchanged.[paragraph break]I wanted to riff on some facet of language without being as abstract and obscure as Ugly Oafs, or as puzzly as the Stale Tales Slate or Threediopolis. The ideas poured in slowly, often by accident. Sometimes I'd overhear stuff, or I'd read an article or book, and there it was. Other times, I'd see a word I was sure had to work some way.[paragraph break]There were enough ideas that didn't fit my story line that [if you-already-won]went into Slicker City and Buck the Past, the sequels[else]sequels, listed when you win, or at IFDB[end if].";
	say "Nuts-and-bolts details can be found in the latest release's included notes.";
	the rule succeeds;

to decide whether you-already-won:
	let X be the number of rows in the table of vu;
	choose row x in the table of vu;
	if found entry is true, decide yes;
	choose row x - 1 in the table of vu;
	if found entry is true, decide yes;
	decide no;

chapter teching

teching is an action out of world.

understand the command "tech" as something new.

understand "tech" as teching.

carry out teching:
	say "Technical implements for testing The Problems Compound are http://toastball.net/glulx-strings/, which you can save locally to determine the strings in a Glulx file. This can help you proofread or whatever, or even (if you're testing and want a sneak peek) see what should happen next.";
	say "I also used BitBucket at https://bitbucket.org/ to store The Problems Compound's source and binaries when I needed to keep it private before the comp. I like BitBucket a lot, but I love GitHub's tracking that graphs how much you've done.";
	say "Zarf's Python scripts for unit testing were also super handy post-comp. I wish I'd tried them beforehand.";
	say "I also used a list of English words to parse with PERL. It wasn't til too late that I created a script that checked for flipped words and possibilities.";
	say "The most helpful website was www.thefreedictionary.com with its idioms search/subdomain idioms.thefreedictionary.com. https://en.wiktionary.org/wiki/Category:English_idioms was also handy. Various compound word lists gave me ideas, too.";
	the rule succeeds;

chapter signing

signing is an action applying to one thing.

understand the command "sign" as something new.

understand "sign [something]" as signing.

carry out signing:
	if noun is burden:
		say "[if burden-signed is true]You've already got the Weasel's signature! [else]It says you can't sign it yourself, and you aren't good at forging. [end if]Besides, you have no pen." instead;
	if noun is cold contract:
		say "No way. Maybe if some fast talker shoved it in your face, you would sign it to shut them up, but that's not the case here." instead;
	if noun is language sign:
		say "It's nowhere near close enough. Perhaps you need to do something else gimmicky." instead;
	say "You aren't famous or popular enough for your signature to mean anything, and besides, you have no pen, anyway." instead;

volume new rule (re-)definitions

the can't exit when not inside anything rule is not listed in any rulebook.

the can't go that way rule is not listed in any rulebook.

check exiting:
	if p-c is true:
		now p-c is false;
		say "You exit the chase paper." instead;
	if location of player is only-out:
		continue the action;
	if number of viable directions is 0: [see section printing exits for what a viable direction is]
		if player is in out mist:
			say "You'd only get further lost--or caught. Perhaps you need to figure a way into the worm." instead;
		if player is in airy station:
			say "The crowd is really expecting you to enter the Return Carriage." instead;
		say "There's no way to exit. It looks like you've got a bit of a puzzle to find one." instead;
	else if number of viable directions is 1:
		let Q be a random viable direction;
		try going Q instead;
	else:
		say "There's more than one direction to exit: [list of viable directions]." instead;

check going:
	if noun is down and the room down of location of player is nowhere:
		say "You don't often need to go down." instead;
	if noun is up and the room up of location of player is nowhere:
		if location of player is variety garden:
			say "Even if you had wings, you'd probably fly into [activation of brush up] that'd remind you you don't REALLY know how to use them."; [temproom variety garden]
			the rule succeeds;
		say "You don't often need to go up." instead;
	if noun is outside:
		if number of viable directions is 1:
			let Q be a random viable direction;
			if Q is not outside:
				try going Q instead;
		else:
			say "There's no way to go outside." instead;
	if noun is inside:
		if the room inside of location of player is nowhere:
			say "There's either nowhere, or more than one place." instead;
	if the room noun of location of player is nowhere:
		say "You can't go that way." instead;

to check-all-brush:
	if sagebrush is in lalaland:
		if brush with greatness is not in lalaland:
			say "[line break]The more you look at the brush, the more you realize you'll never achieve any [activation of brush with greatness]. Time to [if pocket pick is off-stage]see what the Weasel wants[else]get along with whatever you need to do[end if]."; [temproom variety garden]
		continue the action;
	if off brush is examined and back brush is examined and aside brush is examined and up brush is in lalaland:
		say "[line break]Wow! You know so much about brush, you're a [activation of sagebrush], now. The knowledge is a bit dry, but you're glad to have it, all the same."; [temproom variety garden]

volume dialogues

[a quip can be permissible. a quip is usually permissible.]

to reallow (q - a quip):
	repeat through qbc_litany:
		if response entry is q:
			now enabled entry is 1;

to decide what number is conv-left of (x - a person):
	let top-left be 0;
	repeat through litany of x:
		if enabled entry > 0 and permit entry > 0:
			increment top-left;
	decide on top-left;

check talking to (this is the make sure of small talk rule):
	if litany of noun is table of no conversation:
		say "You can't think of any small talk." instead;
	if conv-left of noun is 1:
		say "You don't have anything left to say except hello, good-bye. But here's a summary: ";
		choose row with babbler of noun in table of npc talk summaries;
		if there is a convo-recap entry:
			say "[convo-recap entry][line break]";
		else:
			say "[babble-recap entry][line break]";
		if there is a babble-reward entry:
			say "[line break]You also got a [babble-reward entry], which you [if babble-reward entry is in lalaland]dealt with, yay[else]need to figure what to do with[end if].";
		the rule succeeds;
	now anything-said-yet is false;

anything-said-yet is a truth state that varies.

after quipping:
	now current quip is talked-thru;
	now anything-said-yet is true;

the basic RQ out of range rule is not listed in any rulebook.

An RQ out of range rule for a number (called max) (this is the redone basic RQ out of range rule): say "[if max is 1]You've only got one choice left, the number 1. Type RECAP to see it, though it's probably just saying good-bye.[else][bracket]Whoah! You'd love to think of something awesome and random and creative, but all you can think of are the choices from 1-[max]. Type RECAP to relist the options.[close bracket][line break][end if]".

the block asking rule is not listed in any rulebook.

the block answering rule is not listed in any rulebook.

to decide whether convo-left:
	let got-one be false;
	if not-conversing:
		say "(note--there's a small programming bug I'd like to know about, if possible, at [email], though it shouldn't impact the game.)[paragraph break]";
		decide yes;
	repeat through qbc_litany:
		d "[prompt entry] [enabled entry].";
		if enabled entry is not 0:
			decide yes;
	decide no;

before doing something when qbc_litany is not table of no conversation (this is the Alec is usually forced to talk rule) :
	if current action is qbc responding with:
		continue the action;
	if qbc_litany is table of legend of stuff talk:
		if current action is examining legend of stuff:
			say "You already are!" instead;
		say "You close the Legend of Stuff for now. Back to adventuring.";
		terminate the conversation;
		continue the action;
	if current action is thinking or current action is listening:
		if qbc_litany is table of generic-jerk talk:
			continue the action;
	unless convo-left:
		say "[bracket]NOTE: it looks like you hit an unexpected conversational dead end. I'll kick you out so you can continue the game. Please let me know how this happened at [email] so I can fix it.[close bracket][paragraph break]";
		terminate the conversation;
		continue the action;
	if action is jumpy:
		if qbc_litany is table of guy sweet talk:
			say "Whoah! You could totally do that. But not while you're talking. You'll need to say goodbye to Guy first." instead;
		say "You suddenly realize you could've gotten started quicker, but you're in a conversation now." instead;
	if current action is sleeping:
		say "That'd be a bit insulting. People have yawned around you before, but...you can't do it back to them." instead;
	if current action is listening:
		say "Well, you just did, and now it's your turn to respond." instead;
	if current action is smelling:
		say "Others can throw you off with a well-timed sniff, but not vice versa." instead;
	if current action is saying yes or current action is saying no:
		say "You don't need to say yes or no unless you're directly asked a yes/no question." instead;
	if current action is going:
		if the room noun of location of player is nowhere:
			say "You can't escape the conversation running nowhere! Well, you can't really escape it running anywhere, either. You're not good at slick exits. [note-recap]" instead;
		if qbc_litany is table of Ally Stout talk:
			say "Ally Stout, with other customers to serve, is actually glad to be spared hi-bye small talk.";
			terminate the conversation;
			continue the action;
		if qbc_litany is table of Buddy Best talk:
			say "'What?! No, you don't understand, [i]I[r]'d be blowing off [i]YOU[r]! He throws a magazine at you as he exits, then slams the door to Temper Keep. You pick up the literature--it's called the Reasoning Circular, and it's got a long tag that looks like some sort of ticket.";
			terminate the conversation;
			continue the action;
		if qbc_litany is table of fritz talk:
			say "Fritz barely notices you wandering off to end the conversation.";
			terminate the conversation;
			continue the action;
		if qbc_litany is table of officer petty talk:
			if noun is east:
				say "Oh no. That can't possibly work." instead;
			say "'YOUNG MAN! SHOW AN OFFICER SOME RESPECT!' Man, how'd he KNOW?" instead;
		if qbc_litany is table of stool toad talk:
			say "'YOUNG MAN! DON'T GO WANDERING OFF!'" instead;
		say "You don't have the guts to ditch someone in the middle of a conversation, unless they're REALLY busy or REALLY self-absorbed. [note-recap]" instead;
	if current action is talking to:
		if noun is Alec Smart:
			say "That might bug [the last-talked]. RECAP, or choose a number to talk." instead;
		say "You're already in a conversation with [the last-talked]." instead;
	if current action is attacking:
		say "You've been baited into fights before, but there's been nothing TOO bad here." instead;
	if current action is taking inventory:
		continue the action;
	if current action is giving the mind of peace to:
		if second noun is brother blood:
			terminate the conversation;
			continue the action;
	if current action is giving the relief light to:
		if second noun is brother soul:
			terminate the conversation;
			continue the action;
	if current action is giving the trade of tricks to:
		if second noun is brother big:
			terminate the conversation;
			continue the action;
	if qbc_litany is table of jt:
		if current action is skiping or current action is shorting or current action is whoing:
			continue the action;
	say "You get distracted, but you've never had the power to break a conversation off. [note-recap]" instead;

to say note-recap:
	say "(NOTE: to see dialog options, type RECAP[if qbc_litany is table of jt], SHORT to shorten your questions for readability, THINK to recall the Finger Index, SKIP to [nl-skip]move on immediately from a jerk you accused, 1234567 to order your accusations from the last jerk talked to, or WHO to recall the [j-co]['] names. Currently you can choose [convo-nums][end if])[line break]";

to say nl-skip:
	say "[if skip-after-accuse is true]no longer [end if]";

to say convo-nums:
	let temp be 0;
	repeat through the qbc_litany:
		if the enabled entry > 0:
			increment temp;
	if temp is 1:
		say "only 1";
	else:
		say "1-[temp]";

volume annotations

chapter annoing

anno-allow is a truth state that varies.

ever-anno is a truth state that varies.

anno-check is a truth state that varies.

annoing is an action out of world.

understand the command "anno" as something new.

understand "anno" as annoing.

understand "anno [number]" as notenuming when anno-allow is true. [if it went earlier with notenuming it'd get overwritten]

understand "anno [any room]" as roomnoteing when anno-allow is true.

carry out annoing:
	unless anno-check is true or "anno" is unlock-verified or ever-anno is true:
		say "This is the command for annotations, which are usually only for after you win the game. While it has no spoilers, and it can be toggled, it may be a distraction. Are you sure you want to activate annotations?";
		now anno-check is true;
		unless the player yes-consents:
			say "OK. This warning won't appear again." instead;
	now anno-allow is whether or not anno-allow is false;
	now ever-anno is true;
	say "Now annotations are [if anno-allow is true]on[else]off[end if]";
	let oh-looky be 0;
	repeat through table of annotations:
		if there is an exam-thing entry:
			if there is an anno-loc entry and anno-loc entry is location of player and anno-num entry is 0:
				increment oh-looky;
				increment cur-anno;
				now anno-num entry is cur-anno;
	if oh-looky > 0:
		say ", and, in fact, there's [oh-looky in words] to check right here ";
		if oh-looky is 1:
			say "([cur-anno])";
		else:
			say "([cur-anno - oh-looky + 1] to [cur-anno])";
	say "[if route is unvisited]. You may [one of]also[or]still[stopping] wish to [b]JUMP[r] to the director's cut area for a lot of notes[end if].";
	follow the show annos rule;
	the rule succeeds;
	[showme whether or not anno-allow is true;] [commented this code for later reference. It's handy.]

cur-anno is a number that varies. cur-anno is usually 0.

section the triggers

after printing the locale description (this is the show annos rule):
	if anno-allow is true:
		let myloc be location of player;
		repeat through table of annotations:
			if myloc is anno-loc entry:
				if anno-num entry is 0:
					say "(ROOM ANNO) [anno-long entry][line break]";
					now anno-num entry is -1;
				continue the action;
		if mrlp is rejected rooms:
			ital-say "There should be an annotation for this room, but there isn't.";
	continue the action;

after examining (this is the annotate things rule):
	if anno-allow is true:
		d "anno-ing [noun].";
		repeat through table of annotations:
			if there is an exam-thing entry and noun is exam-thing entry:
				if anno-num entry is 0:
					increment cur-anno;
					say "([cur-anno]) [anno-long entry][line break]";
					now anno-num entry is cur-anno;
	continue the action;

section the table

table of annotations [toa]
anno-num	exam-thing	anno-loc	anno-long (text)
0	--	Smart Street	"The idea for Smart Street came surprisingly late, but the reverse made total sense. The main point is that Alec may not be street smart, but people often assume he'll wind up somewhere around clever people. And of course Alec does not feel at home even though it shares a name with him." [very start]
0	--	A Round Lounge	"This came to me pretty late. I'm never quite sure how to start games. It always seems the best idea comes at the end, and yet on the other hand it's not fully comforting that I know how my story will end. I wanted you to start pretty normally, but move to progressively odder places."
0	--	Tension Surface	"This may've been a throwaway idea at first, but it grew on me as a noun that I hadn't used. You can examine the MOUTH MUSH for more commentary." [start intro]
0	--	Variety Garden	"The title was just for silliness until release 2, when I added varieties of brush. Basically, the garden has a lot of variety of brush, but not really quality, or nothing interesting. Originally there was a Stream of Consciousness and Train of Thought here, but these were placeholders and they didn't really flip. But they helped me until I found things. Like the Word Weasel, which didn't come until later, but I always liked that phrase. I went through a bunch of vegetables to put in the garden before I found an animal would do just as well."
0	--	Vision Tunnel	"I'm pleased with the flip here from 'tunnel vision' as the vision tunnel opens you up to the different ways to see things."
0	--	Pressure Pier	"This shuffled around a bit until I found someone who was adequate for pressuring you, as opposed to just talking you down. That was Terry Sally, who was the Howdy Boy for a long time. And, in fact, he was just 'there' in Sense Common for a while. Early I took a 'best/worst remaining pun' approach to the map, but as I started writing code and sending the game to testers, I realized how it could make more sense." [start outskirts]
0	--	Meal Square	"This was the Tactics Stall (bumped to Slicker City then Buck the Past) for a while, until I had enough food items for a separate area, and then I didn't have enough time to implement tactical items. I needed a place to put them. 'Sink kitchen' didn't quite work, but eventually I found this. The dozen bakers were my first scenery implemented, and I'm quite pleased at the bad pun. Also, the Gagging Lolly was the first silly-death thing I implemented."
0	--	Down Ground	"Some locations didn't make the cut, but they helped me figure out better ones. However, Down Ground was one of the first and most reliable. It was behind Rejection Retreat, which--well--didn't fit the pattern, though it was another name I liked[if ever-anno is false].[paragraph break]You can now JUMP to or from random areas that didn't quite make it. Actually, you could've once you turned on annotation mode. But now you know you can[end if]."
0	--	Joint Strip	"Sometimes the names just fall into your lap. It's pretty horrible and silly either way, isn't it? I don't smoke pot myself, but I can't resist minor drug humor, and between Reefer Madness and Cheech and Chong, and people too stridently opposed to or in favor of drug legalization, there is a lot of fertile ground out there."
0	--	Soda Club	"[one of]I forget what medieval text I read that made me figure out the Sinister Bar, but that's what it was in release 1. Some authors in the forum said, well, this is a bit awkward, and they were right, but it was the best idea I had and not worth holding up the game for a year. The thing is: it was an obvious weakness, but I had confidence I'd figure it out post-release. ANNO CLUB for more.[or]Then one day at the grocery store, I saw club soda, thought--could it be that easy? Having an ironic title for a speakeasy? It was! And I'd probably seen it before, but it didn't click.[paragraph break]There's a lesson here. I've spent a lot of time wondering if an idea is too complex or too simple, or too good to be true. And of course you can't be overconfident, but if it feels right, if feels right. Easy ideas don't fall out every day, but when they do, don't turn them down or worry if you haven't done enough to deserve them.[paragraph break]Of course, I'd probably have seen Soda Club if I started earlier. But that's another lesson.[cycling]"
0	--	Tense Past	"These three rooms fell pretty quickly once I heard 'past tense.' Dreams have often been a source of helplessness for me, with one 'favorite' flavor being me as my younger self knowing what I know now, knowing I'd get cut down for using that knowledge. That snafu has grown amusing over the years, but it wasn't as a teen." [sleepytime rooms]
0	--	Tense Present	"Of course we've all had dreams about stuff we can't do now, or issues that keep coming up. I'd like to think that my bad dreams, once I confronted them, let me exaggerate things for humor in everday conversation. Still, it's been a developing process."
0	--	Tense Future	"We all worry about the future and what it will be, and we get it wrong, but that doesn't make it any less scary. I included this once I saw that dreams and fears could be traced into three segments: how you messed up, how you are messing up, and how you won't be able to stop messing up."
0	--	Nominal Fen	"The Nominal Fen was the Jerk Circle for a long time until the end of release 3, when I started cleaning up names. Then I realized I hadn't used the Mellow Marsh, which was great for after the jerks left. But what about before? I plowed through various types of terrain. Fen stuck, and nominal worked well especially because I couldn't quite describe a fen. Also, the idea of Jerk Circle made me laugh until I realized it might be a bit too icky to see too much, so I decided to break it off. Even with the Groan Collective as an adequate non-risque replacement. This way, the locations make (relative) sense even with the jerks/groaneres gone. Of course, when you know the 'other' name is Jerk Circle, there are still connotations. But the image of one person starting to groan encouraging others is very apt. Once I saw how the NPCs could interact, I felt even more amused." [main area]
0	--	Chipper Wood	"I got the idea for this when reminded of a certain Coen Brothers movie. The contrast of violence and happiness in the title made me realize it was a better choice than Rage Road, which it replaced." [west-a-ways first]
0	--	Disposed Well	"This was originally the preserved well, and the Belt Below was below it. There was going to be a Barrel of the Bottom that opened, but it seemed too far-fetched. So I just went with a well where you couldn't quite reach something."
0	--	Classic Cult	"Of course, a cult never calls itself a cult these days. It just--emphasizes things society doesn't. Which is seductive, since we all should do it on our own, and we'd all love to find something quick and simple that helps us. But whether the thinking is New or Old, it remains. It can be dogma, even if people say it all exciting.[paragraph break]Plus I cringe when someone replies 'That's classic!' to a joke that's a bit too well-worn or even mean-spirited."
0	--	Truth Home	"Of course, the truth home has lots of truth--it's just all misused. And I liked the idea of a name that sounds a bit superior but isn't. Sid and Lee felt like they should have abstract names--and they did until release three, when I realized they were the last two that didn't. I had put their original names in Slicker City as authors, but when I looked at the list of 100+ to see who might be a good character for SC and didn't deserve to get lost in the random shuffle, I realized they could go in PC."
0	--	Scheme Pyramid	"I find pyramid schemes endlessly funny in theory, though their cost is real and sad. They're worse than lotteries. I'd originally intended to have more people here, but it didn't work out that way. The Labor Child does have a 'downline' of his own, in the other kids he's blackmailing."
0	--	Accountable Hold	"I'm critical of Big Business and people who think they've done a lot more than they have because they have a good network they don't give much back to. In particular, if someone talks about accountability, it's a sad but safe bet that in a minute they will start blaming less powerful people for things out of their control. There's a certain confidence you need for business, but too often it turns into bluster. In this case the only people held accountable are the jerks, for unusual things they like."
0	--	The Belt Below	"I wanted a seedy underbelly. And I got one. I didn't know what it was for, and certainly, it didn't all come together in the initial release. I just found a puzzle with a week before IFComp, and I got it to work. But the room name spurred me to make a puzzle that FELT unfair. In subsequent releases, I cleaned it up a bit."
0	--	A Great Den	"I forget when the idea of giving you a powerful item if you got abstract puzzles came to me. But I wanted the item to be powerful and cleverly named. I don't know if the room was at first (Bottom Rock). I wasn't sure where I could put a crib, because I couldn't implement a bedroom, but then I realized it could be just dropped anywhere, to show the Problems Compound is not for babies--or maybe to insinuate that hints are for babies. I mean, for the [bad-guy] to insinuate, not me. I use them a lot, too. Sometimes it's the difference between being blocked and seeing the author was quite close to their original vision, and with A Great Den/Bottom Rock, I spent a few sessions thinking I'd like to do something, but I didn't know what. Eventually, the word 'den' seemed pliable, and from then it was a matter of finding words beginning with DEN."
0	--	Judgment Pass	"This seemed as good a generic place-you-need-a-puzzle-to-get-by as any. Especially since I wanted solutions to focus around outsmarting instead of violence or pushing someone out of the way. I just needed someone officious to be blocking you, and that was Officer Petty." [east-ish]
0	--	Idiot Village	"Of course, the people here aren't total idiots, even if they are very silly. But I liked the idea of turning 'village idiot' on its head, as well as having a caste of 'outs' who maybe weren't stupid but let themselves be treated that way."
0	--	Service Community	"I liked the idea of an underclass that needs to rebel, and Idiot Village was good enough for getting the game out there. But then while playing Kingdom of Loathing, which has 'inspired' a lot of my 'jokes,' the Community Service challenge path's name kept pinging me. About the hundredth time, I smacked my head and said, oh, of course."
0	--	Speaking Plain	"The people here do go in for plain speaking, but that doesn't mean it's good speaking. In general, Alec is assaulted by a bunch of people who want to convince him they're wasting their time speaking to him than the other way around. They act like advertisements, to me. I no longer feel as trapped as I used to between people bossing you around with plain speech versus people bossing you around with lofty speech, but I remember it being very painful." [north-ish]
0	--	Temper Keep	"Temper Keep is one of those ideas that came relatively late, but once it did, I had a few adjectives and verbs that tipped me off to a quick puzzle that should be in there."
0	--	Questions Field	"This was originally the Way of Right, which was sort of close to Freak Control, but then close to release I was searching for other names and this popped up. I liked it better--the three Brothers are asking questions, first of you and then of why they're there and how they could leave--and it seemed less generic. And of course they're hearing questions--loaded ones. So it stayed."
0	--	Court of Contempt	"As someone intimidated and confused by all the yelling that went on in law-firm shows when I was younger, and as someone who thought I never could, any sort of court always seemed fearful to me. What would I be doing there? I was shocked when I got my first parking ticket and went in to protest that it was relatively quiet and orderly. (I got it overturned.) But the memory of younger fears still remains, funnier now."
0	--	Walker Street	"Walker Street was Crazy Drive in release 1. But I found the joke of somewhere plain or boring too much to resist, especially after finding 'Walker Street' as a stray annotation to delete in my Trizbort map file. Oh, a streetwalker is, well, someone who trades favors for money. Yes, THAT sort of favor."
0	--	Discussion Block	"This was the Interest Compound in release 1, but that was too close to the title once I changed it from the Directors of Bored. The discussions, of course, block any real discussion. The books and songs are meant to be wrong, but you as Alec can't SAY that, and Art and Phil claim they 'make you think.' Better to have books that help or let you think, I say."
0	--	Standard Bog	"This was something entirely different until the end. Something different enough, it might go in a sequel. But being a bog, I realized that'd make it a handy dead end."
0	--	Pot Chamber	"Some room names made me smile with their subtlety. Others, with their utter lack. Since this combines two awkward conversation subjects, guess which it was?"
0	--	Freak Control	"This was one of those rooms that made me realize I had a game. And I think the false humility in it ties up an important thing: the Baiter claims he's a bit of a dork, but he's like moderate and stuff. Except when he needs to be extreme to win an argument. The for-your-own good of how he went through it adds to the pile."
0	--	Out Mist	"I needed a name for a final location, and originally it was the Haves Wood, which didn't quite make sense. It needed to be somewhere shadowy--unclear. Then I overheard someone saying 'Boy, you missed out,' and I wanted to thank them, but they would've thought it was weird. The wordplay is, of course, that you missed out a bit, but the mist is still out of bounds for people in the Compound."
0	--	Airy Station	"Since stationary means lack of motion and you are leaving, I lliked the contradiction. I wanted a way for people to say thanks for Alec before he left, if he did enough, as opposed to him just sneaking out as was the only way in release 1."

table of annotations (continued) [toa-views]
anno-num	exam-thing	anno-loc	anno-long (text)
0	--	Everything Hold	"The obvious pun here is that trying to hold everything physically often makes you hold everything in terms of time. So this seemed apt, but if I put anything in this room, I'd put in a lot, and that'd be way too much trouble to implement."
0	--	Mine Land	"I definitely don't want to trivialize the devastating effects of land mines. And from a technical viewpoint, Mine Land would probably have been an empty room. But really, a bunch of people crying 'Mine! Mine!' is destructive in its own way."
0	--	Robbery Highway	"Highway robbery being a clear rip-off, I liked the idea of a location made especially for that."
0	--	Space of Waste	"Like Mine Land, this is one of those areas that don't work well in a game, but all the same--so many spaces are space of waste."
0	--	Clown Class	"I had an idea of making Clown Class a dead end, or maybe even a separate game, but I couldn't pull it off."
0	--	Shoulder Square	"I do like the pun shoulder/should, er. They mix well with shoulders tensing thinking what you should do."
0	--	Perilous Siege	"The Siege Perilous is where Galahad was allowed to sit. It signified virtue. Of course, many of the antagonists in the Compound think they have virtue, but they don't. Since this room was so general, I didn't see a way to include it in the game proper."
0	--	Expectations Meet	"The irony of expectations meet is that if people gather together and discuss their expectations, they never quite meet them."
0	--	Camp Concentration	"[one of]I felt very, very horrible thinking of this, for obvious reasons, and similarly, I didn't want to put this in the game proper and fought about including it in the Director's Cut. So you'll have to ANNO CAMP to see more.[or]I wasn't looking for anything provocative, but reading an online article, the switcheroo hit me. Because there's some things you clearly can't trivialize or pass off as a joke, or not easily. But I imagined a place where people yelled at you you needed to focus to stop making stupid mistakes, and of course it could be far FAR worse, and perhaps they want you to concentrate on that and also on being a productive member of society at the same time, when at the same time they'd never have such low standards themselves.[paragraph break]The gallows humor here I also saw is that the [bad-guy] never sends you here, because you aren't that bad, and he wouldn't be nearly that bad, so stop complaining.[paragraph break]And while my writerly fee-fees are far from the most important thing, here, I was genuinely unnerved that I saw these links and my abstract-reasoning brain part went ahead with them, poking at the words for irony when there was something far more serious underneath. The contradiction here is that many people will tll you 1) it could be way worse and 2) dude, have some standards! And that's the sort of manipulation Alec, or too many people, don't know how to deal with, and there's not much teaching on the subject.[stopping]"

table of annotations (continued) [toa-bad]
anno-num	exam-thing	anno-loc	anno-long (text)
0	--	Hut Ten	"This was brought about by all the countless drills I was forced into in Boy Scouts, as well as the fear of possible war with the Russians and me getting drafted. I was also nervous for a few days about the first Iraq War, and what if it lasted [']til I went to college? Fortunately, the US got in and got out quickly, and there were totally no problems at all after that, amirite.[paragraph break]Also, I never got to implement as many silly 'death' rooms as I thought, but this was an obvious pun to conjure up images of Stalag 17 or something."
0	--	A Beer Pound	"This came up when I was looking for better names for the Sinister Bar (now the Soda Club) post-release. I wanted a place for alcohol-related offenses but had nowhere until this seemed a bit obvious.[paragraph break]I think there's a chance to be moralistic about alcohol no matter how much you drink. Maybe you are sure you need it after a hard day's work, or people never should've started. I've seen my share of people cutting down others who don't know their limits, including former employees upset with a junior employee they took out drinking and he found it hard to control. It's sad and unfortunate, and I've had my fair share of awkward explanations that, well, I'd be a fool to risk drinking."
0	--	In-Dignity Heap	"This was only put in to make the map 8x8 but I think it's a good one. People with seeming dignity giving pompous morality lectures do heap indignity on others. And some of us take it for our own good.[paragraph break]Also, it's hard to be dignified on a heap, and the 'in' prefix provides fodder for a lot of puns. I wasn't able to use this on an item, so there is a fake death location."
0	--	Shape Ship	"What better place to get ship shape than on a shape ship? Again, the creative deaths/failures didn't pile up enough, but I still enjoyed imagining all this. Also, if you've ever read any novels about rough life on a ship, well, this is just a gimme."
0	--	Criminals' Harbor	"This pun was too good to pass up. It could have been lumped with Shape Ship, but I liked them both too much."
0	--	Maintenance High	"Most people who complain about others being high maintenance usually are emotionally high maintenance themselves. So I imagined a place where people learned WHY they were high maintenance and had it beat into their skulls. If they learned quickly, see, it was right. If not, well, they're taking up teaching time. Where people doled out abuse and projected their own deficiencies on others.[paragraph break]One irony I've found about actively avoiding being high maintenance is that I've often forgotten to do simple things to keep things going. Most of the time that's paying a bill or putting off an eye doctor appointment. But more seriously, it's tough for me to evaluate high maintenance versus high standards."
0	--	Fight Fair	"Of course, none of the fights in Fight Fair are remotely fair, and fights at fairs in general are, well, rigged. It also seemed to be a good way to underscore pitting less popular kids against each other, or against a bully-henchman to grind them down."
0	--	Punishment Capitol	"I'm opposed to capital punishment. And I think the [bad-guy] is, too, though he does like to retaliate more vigorously than any (perceived) attack on him. I needed a place for the big crimes, and here it is. It's the place for the worst crimes, like attacking the [bad-guy]. Obviously, it had to be."

table of annotations (continued) [toa-rej]
anno-num	exam-thing	anno-loc	anno-long (text)
0	--	One Route	"It was either this or One Square or Way One, at the beginning. But those two got carded off to something better: Meal Square and, well, Way of Right should be in Slicker City." [begin speculative locations]
0	--	Muster Pass	"It was a close call between here and Judgment Pass, but only one could pass muster. Err, sorry about that. Judgment pass won out because it allowed for a NPC I could satirize a bit more."
0	--	Rage Road	"This flip made me giggle immediately, but it was one of those things where I could do better. The flipped meaning wasn't skewed enough. So when I stumbled on Chipper Wood, I decided to change it. That said, even though road rage is serious, it's fun to make fun of the silly ambitions behind it.[paragraph break]I also had ideas for a diner called [activation of road pizza]." [temproom rage road]
0	--	Chicken Free Range	"The Chicken Free Range is, well, free of everyone. It was replaced by the Speaking Plain and Chipper Wood. As much as I like the idea of rotating two of three names, the problem is that you have six possibilities now, which gets confusing. Plus, free-range chicken may be a bit obscure, though I like the connotation of chicken-free range as the self-contradictory booming edict 'THOU SHALT NOT FEAR.'"
0	--	Humor Gallows	"This was originally part of the main map, but the joke wasn't universal enough. I like the idea of killing jokes from something that should be funny, the reverse of gallows humor--which draws humor from tragedy or near tragedy. As well as the variety of ways jokes can be killed."
0	--	Tuff Butt Fair	"This was one of the first locations I found, and I took it, and I put it in the game. Tough butt/tough but is a good pun, and I have a personal test that if I can picture pundits calling a person 'tough but fair,' that person is a loudmouthed critical jerk. The only problem is, 'fair but tough' isn't really a fair flip. It was replaced by the Interest Compound, which became the Discussion Block, and Judgment Pass.[paragraph break]I originally thought of a lot of real people I could put in here, but I settled for putting them into the [bad-guy]'s name dropping at the end, for humor value and also to show him being socially 'conscious,' I mean, ambitious. However, for a truly atrocious inside joke, I was tempted to put in a bully named Nelson Graham who beat other kids up for playing games over three years old--or for even TRYING to make their own programming language. Especially one without even any graphics! I decided against even hinting at--oops."
0	--	Ill Falls	"This was simply a good pun that might have afforded a play on Ill, which often means beautiful and ugly at the same time. Or it could be a verb: to ill means to be out of it, or to insult someone, well or poorly."
0	--	Eternal Hope Springs	"This was the original place you'd sleep. Then I put the warmer bench, but then I discovered the Joint Strip as perfectly seedy. Since, like Chicken Free Range, this had three substansive words in its name, it didn't quite fit the room aesthetic. But I still liked the name, and it probably catalyzed other ideas before becoming obsolete."
0	--	Brains Beat	"I like the image of brainy people walking a beat, talking about stuff, making someone (figuratively, of course) want to beat their brains in. Them being themselves or the others. Intellectual Conversation in general drives me up the wall when it is too ostentatious."
0	--	Madness March	"Unsurprisingly, I thought of this one in March. But I didn't feel it was universal enough. March Madness is a big deal in the US among basketball fans. In fact, even non-basketball fans enter (nominally illegal) betting pools in this 68-game knockout tournament. I was planning to have a bunch of people getting into stupid arguments with someone winning, but I hadn't the heart to implement it."
0	--	Window Bay	"I liked the reversal on architecture for a more natural and magical setting."

table of annotations (continued) [toa-items]
anno-num	exam-thing	anno-loc	anno-long (text)
0	game shell	Smart Street	"This was originally a location, and its predecessor was the Gallery Peanut, which got shuffled to Meal Square, then to a potential sequel. But once I moved the Peanut, the Shell became obvious: a place where you could play games and win, but never really win anything valuable. Or you'd lose interest, or confidence."
0	round stick	Round Lounge	"It took a bit of time to find the magic item to cross over into the truly odd bits. Originally it was the Proof of Burden, but that was too magical, too early. And that might've forced the mechanic on you. I think A Round Stick is a bit subtler. Plus it let me put two round things together. In a round location!"
0	mouth mush	Tension Surface	"The mouth mush wasn't around until late in release 1. Originally it was the rogue arch talking, but walking into an actual mouth seemed a bit too creepy."
0	flower wall	Vision Tunnel	"It took me forever to figure what should be in the Vision Tunnel. I couldn't leave it empty."
0	Word Weasel	Variety Garden	"I like books with talking animals, but at the same time, it's interesting to subvery certain tropes. And the Word Weasel worked very well. It also plays on the whole 'you should've seen something from its name' versus 'with a name like that it better be honest.' The Word Weasel was also one of several entities neutered in release 3."
0	Terry Sally	Pressure Pier	"I was a bit wary of having two gatekeepers, but I wanted to contrast them so that Guy Sweet forced you to seem square and Terry (formerly the Howdy Boy before release 3 when I tried to give proper names) gave you the possibility of rebelling a bit, even if it was a bit forced."
0	Fritz the On	Down Ground	"Fritz is the character I have the most affection for. He may be the most well-meaning NPC in the whole game, but boy is he muddled. Also, the phrase 'on the fritz' bugged me in high school. I'm not sure why. But I'm able to get a good laugh from it now."
0	Stool Toad	Joint Strip	"I don't go in for in-depth NPC creation, and I think the Stool Toad fit into that. A general useless bureaucrat who thinks better of himself than he deserves to and doesn't realize his platitudes don't mean much all by themselves."
0	Ally Stout	Soda Club	"The social dynamics of bars and bartending eluded me, but I always figured I'd be the guy a bartender gave a fake smile to. They have a sort of celebrity and soft-power all of their own. They still confuse me, and they definitely still confuse Alec."
0	Erin Sack	Soda Club	"Most of the antagonists in the Problems Compound are male. Erin isn't a huge antagonist, but she does look down on Alec, much like the rest of them. Alec shouldn't be too good to listen to her views, and while they may be generally important, well, Alec needs to take care of his own stuff."
0	jerks	Nominal Fen	"The [j-co] aren't there just for a puzzle. That came together a week before release 1, with the result a few bugs slipped in. But I wanted to establish that there's a lot of insecurity under the 'impressive' bragging, which falls out when they are forced to admit they like certain things that may not be in the mainstream, and you may not be able to say, wow, look at me being retro for knowing all this."
0	Grace Goode	Classic Cult	"Faith and Grace were sort of inspired by the 'minimalist' episode of Absolutely Fabulous, where Max and Bettina make minimal comments on why they are happy. But then there's also the more serious side of how they've given up trying to overthink things and just want to be happy, but the [bad-guy] keeps finding complex 'sophisticated' reasons they're not. They're even betrayed by their own family (Herb Goode) in release 3."
0	Cute Percy	Chipper Wood	"Cute Percy, formerly the Assassination Character, may've been inspired by the Cruel Puppet from Beyond Zork. During testing, Brian Rushton pointed out his puzzle was something like the puzzle in Enchanter where you need to lose a move. I liked the idea of Alec being able to win a chase-game that seemed undoable by using diagonal moves, and I'd had the idea of such an area where diagonal moves only took half the time after playing yet another game where going southwest saved a turn over going west or south."
0	Insanity Terminal	Belt Below	"The Insanity Terminal was just a name, but once I had it, I wanted to make a ridiculous puzzle. David Welbourn pointed out that not assuming something at first led to more than one possible solution, so filling in that hole with a PERL script--and checking the other possible solutions--took a while."
0	Sid Lew	Truth Home	"I suppose we've all been on the receiving end of an argument that felt glib but couldn't possibly be right. How Alec gets circuitous revenge on Sid helped me recoup some of that."
0	Officer Petty	Judgment Pass	"This is maybe a slightly dishonest reverse, but then, you get the feeling that Officer Petty hasn't had much formal training. I'm a big Dukes of Hazzard fan, so it's fun to me to see policemen suckered by their own greed, as OP is when you find the right item to give him."
0	Sly Moore	Idiot Village	"More/Moore was an obvious homonym to play on, but I didn't know about a first name. I thought about Les, but that just ran into itself. I was able to google-spam enough sites to get first names that mean something, but then Sly Moore didn't seem like an antagonist to outwit. I needed someone for Alec to help, though, so Sly it was."
0	Thoughts Idol	Idiot Village	"I had the idea for the puzzle before the idol. Why would Alec run in that pattern? Well, he would be followed--and then it hit me. Alec couldn't get too near the idol for too long, but he had to keep it busy. Combine that with how I always liked to draw eight-pointed stars as a kid, and voila. The puzzle. Going from an idol giving you a long sidelong glance to you spinning it around until it explodes."
0	Turk Young	Speaking Plain	"Turk and Dutch's advice is worthless, but I remember being pressured that I didn't have the common sense of some other kids my age. I took it out a bit on Turk and Dutch and made them pompous--though it might not immediately be obvious why they're wrong."
0	Volatile Sal	Temper Keep	"Sal is probably the person I identify most with. He's probably most on the edge to being aligned with the [bad-guy] or Alec. The thing is: he complains a lot, but the solution is right under his nose. So Alec doing that for him gives Alec some confidence he's not the only one who's dragged his feet, and he can do better."
0	Buddy Best	Court of Contempt	"I don't know if I fully explained Buddy in the first release. Testers were upset he kicked you out--but I wanted that to be sort of the point. He didn't have time for you, and he acted like he was doing a favor giving you anything, and he sort of was, except you didn't need to feel grateful for that. Alec also learns to use Buddy's gift to get by someone else, so that's a good example of getting two enemies out of the way at once."
0	Mistake Grave	Walker Street	"I couldn't resist a chance for a cheap joke. The [bad-guy] is, sadly, one of those people who will condemn you for not being exciting enough, and while there's no way for Alec to outright lose, such a grave gives him a little fear.[paragraph break]Of course, there's no assurance anyone DID actually die."
0	Art Fine	Discussion Block	"Critical discussion of art is good. But hopefully Art is so over the top with his hyperbole, and the art is so obviously bad, that you can see why listening to him might turn people away. I have to admit listening to louder people than myself turned me away from reading in high school. Everything was terrible or awesome! You better not make the mistake of reading a stupid book! And so on. There was a lot of posturing, but I never quite picked up on it."
0	Harmonic Phil	Discussion Block	"I've always had trouble getting into music, and it's hard to describe what's so good about it. But people raving about it has never helped me. I admit I'm dreadfully conservative, often listening to the same song a few times in a row. But a long while back I was surprised to read research that overselling isn't the way to go, and it isn't just a matter of the sell-ees being stubborn or prissy. That holds for more than just music."
0	Language Machine	Standard Bog	"Some people expressed concern that the Language Machine was about choice versus parser games, but I think that's a little too solipsistic and art-on-art. The language machine continues to burble on writing to itself after Alec helps it, but the difference is that it looks for more than just complaining. I fixed some text for the next releasese to clear that up. But I'm disappointed that something intended to be optimistic and quirky turned out to be interpreted as an attack on a whole community."
0	Pusher Penn	Pot Chamber	"There may be some problem here with getting Alec to perform the risky task Pusher Penn asks. Only it isn't, as long as he avoids the Stool Toad. So there's a certain element of not worrying too much about obeying the rules for their own sake, and also for helping Fritz the On a bit, and how Pusher Penn sees the impoverished Fritz as beneath him. Also, I was sure to provide Alec with no matches so he couldn't consume the product or the reward. And I do like to put in references to smoking every game, especially after reading a po-faced research article condemning movies for excessive 'tobacco incidents,' which included nonsmoking signs that researcher's pals probably pushed for in the first place."
0	Brother Soul	Questions Field	"[intro-bro]Brother Soul had the easiest puzzle-train to implement once I figured something needed to be in the Spleen Vent."
0	Brother Blood	Questions Field	"[intro-bro]Brother Blood had the second-easiest puzzle-train to implement. I always viewed him as being gaslighted more than the other two, where people claimed he might do something violent due to--the sort of inane baiting they were putting on him in the first place."
0	Brother Big	Questions Field	"[intro-bro]Brother Big takes the most steps to get through, which is fortuitious. But I had a lot of false starts and the path felt artificial until near the end. However, I like that 'you are big and strong so you must be stupid' dilemma he has to face and stare down."
0	Baiter Master	Freak Control	"Once I realized the bad guy's name, I realized I had a serious game if only I knew what to do with him. But I also didn't want to identify him too much with any one person in my near past. I also wanted to have a non-swear version of the name, and I didn't want to waste Complex Messiah. Bino! Add asking for profanities at the start, which is intended to be a sort of power play where it doesn't matter what you respond, someone will have something mean to say, and you have another twist."
0	Worm Ring	Out Mist	"There wasn't even a location past Freak Control at the end of release 1. But people said it might be nice to have something based on the game's main mechanic and pun making, and I wondered if there were words I'd forgotten. A whole worm provided Alec's way home, but how to MAKE one? The good ending may actually have a tougher puzzle than the very good one--well, without the progressive clues."
0	Return Carriage	Airy Station	"Alec needed a way to go home once I decided on good/very good ends. The Snowflake Special was the first, but it didn't afford a puzzle, and I didn't want modern slang if I could avoid it. Of course, the answer came unexpectedly when I was looking for a way to parse my code for obvious mistakes. That happens a lot. I was worried too long that I didn't have enough ideas, but when I decided one a day was pretty good (say, about September 1, a month before IFCom's start,) they started falling. And they kept doing so once IFComp was over. The final barrier here was, how do you enter the carriage? Get rid of a lock? So I got HAMMER LOCK and then realized I could do more with a hammer."

to say intro-bro:
	say "[one of]The three brothers['] names dropped easily once I saw the Biblical phrase 'brothers and keepers.' Once I did, the puzzles really started clicking. I didn't know who would get what, but each one would obviously be missing something. [or][stopping]"

volume the game itself

book beginning

Beginning is a region.

chapter the player's possessions to start

section a thought of school

a thought of school is a thing. the player carries a thought of school. description of thought of school is "[long-school]."

instead of doing something with thought of school:
	if action is undrastic, continue the action;
	say "You can really only just think about it, e.g. e(X)amine or e(XP)lain.";

to say long-school:
	say "You think about how you don't follow any orthodoxy, but everyone seems more clever and creative than you are. All sorts of things. Like you should be doing way better than you should, and how you're too self-centered and too worried about everyone else at the same time. It doesn't make sense. But any one philosophy to explain it all doesn't really mesh"

check examining thought of school:
	if accel-ending:
		if brownie is in lalaland:
			say "Boy! School will be a lot more fun now that you can learn whom to please and not be grumpy.";
		else:
			say "Boy! There were some real bums at school, but you think you know how to deal with them, now.";
		the rule succeeds;

section exprs

an expr is a kind of thing.

a face of loss is an expr. The player carries a face of loss. description of face of loss is "There are no mirrors, so you can't see it, but it's hard to change."

a bad face is an expr. description is "You can't see it, but you can [i]feel[r] it has a bit more gravitas and confidence."

a lifted face is an expr. description is "You're feeling pretty good about yourself. Not too good, but you just feel your mouth muscles are a little perkier than normal."

an opener eye is an expr. description is "You can't see it, but it's helping you see things a bit more clearly now you ate the [bad-eaten].".

understand "face [text]" and "[text] face" as a mistake ("You can't do much to change your face. Well, it can't last. You may need to do something big.") when player does not have opener eye.

understand "eye [text]" and "[text] eye" as a mistake ("You're already a lot more aware than before you ate the [bad-eaten].") when player has opener eye.

rule for deciding whether all includes a face of loss: it does not.

rule for deciding whether all includes a bad face: it does not.

rule for deciding whether all includes a lifted face: it does not.

rule for deciding whether all includes opener eye: it does not.

rule for deciding whether all includes thought of school: it does not.

to decide whether the action is expressionable:
	if examining, decide yes;
	if explaining, decide yes;
	if annoing, decide yes;
	if dropping, decide yes;
	decide no;

instead of doing something when second noun is an expr:
	say "You can't do much with or to the [noun]. It's part of you."

instead of doing something with an expr:
	if action is expressionable:
		continue the action;
	say "You can't do much with or to the [noun]. It's part of you.";

to say bad-eaten:
	say "[random badfood in lalaland]"

[start rooms]

part Smart Street

Smart Street is a room in Beginning. "This isn't a busy street[one of], but there's a shell-like structure featuring all manner of odd games[or] though the Game Shell takes a good deal of space[stopping]. While you can leave in any direction, you'd probably get lost quickly.[paragraph break][if Broke Flat is examined]Broke Flat lies[else]The shell seems in much better condition than the flat[end if] a bit further away."

after looking in Smart Street when Guy Sweet is not in Smart Street:
	move Guy Sweet to Smart Street;
	say "A loud, hearty voice from the shell. 'Howdy! I'm Guy Sweet! You look like a fella with a [activation of mind games]! Why not come over to the Game Shell and have a TALK?'";
	say "[line break]";
	ital-say "you may wish to see the verbs for The Problems Compound by typing VERB at any time.";

the player is in Smart Street.

rule for clarifying the parser's choice of games: do nothing;

games are plural-named scenery in Smart Street. description of games is "[bug]";

instead of doing something with games:
	if current action is playing:
		say "You should try PLAYing one at a time." instead;
	say "There are a whole bunch: [the list of logic-games]. You can PLAY them one at a time, but not all at once."

check going nowhere in Smart Street:
	say "You don't have your bearings. Maybe you can go into the Broke Flat, but that's about it. You certainly can't see your room in any direction." instead;

section Guy Sweet

Guy Sweet is a man. litany of Guy Sweet is the table of guy sweet talk. "Guy Sweet stands in the Game Shell, [if guy-games is talked-thru and gesture token is not off-stage]looking disinterested[else if guy-games is talked-thru]gesturing at the games[else]looking at you as if expecting interaction[end if].". description of Guy Sweet is "He's, well, he sort of looks like you. A little handsomer, smiles a bit more, a bit more muscle, a bit taller. Wait, no. Your eyes are just above his. But he's got a bit of confidence you don't."

alec-intro is a truth state that varies.

check talking to guy sweet when alec-intro is false:
	now alec-intro is true;
	say "You introduce yourself as Alec Smart, and Guy coughs. 'You do know...' You sort of hope he doesn't ask why you aren't just Al or Alex or Alan, but then it's disappointing he doesn't let you explain you called yourself Alec when you were four.[paragraph break]'Whatever.'"

table of gs - guy sweet talk
prompt	response	enabled	permit
"So. What are these games for?"	guy-games	1	1
"How'd you get stuck here?"	guy-stuck	1	1
"Any advice on any of the games?"	guy-advice	1	1
"So. What's in [b-f]?"	guy-flat	1	1
"The Problems Compound?"	guy-problems	0	1
"The [bad-guy]?"	guy-mess	0	1
"[bad-guy-2]?"	guy-bad2	0	1
"[later-or-thanks]."	guy-bye	3	1

to say later-or-thanks:
	let temp be 0;
	repeat through qbc_litany:
		if enabled entry > 0:
			increment temp;
	if qbc_litany is table of stool toad talk:
		say "I'll, uh, try to stay out of [if your-tix > 0]more [end if]trouble";
		continue the action;
	if qbc_litany is table of Erin talk:
		if anything-said-yet is false:
			say "(shuffles off [if erin-warn is true]even more [end if]embarrassingly and awkwardly)";
			continue the action;
	if temp > 1:
		say "Um, later";
	else:
		say "Ok, thanks";

definition: a logic-game (called j) is defeated:
	if max-won of j is 0:
		decide no;
	if times-won of j is max-won of j:
		decide yes;
	decide no;

table of quip texts (continued)
quip	quiptext
guy-games	"'They're for people who don't like re	gular fun social games. Sort of like IQ tests. You look like you'd enjoy them more than most. No offense. Hey, I'm saying you have [g-c].'"
guy-stuck	"'Well, yeah, I used to be kind of a dork. And by kind of a dork I mean really a dork. Probably even worse than you. Hey, I'm showing some serious humility here. I mean, starting at the bottom, as a greeter, until I'm an interesting enough person to join the Problems Compound.'"
guy-advice	"'Hm, well, if I give you too much advice, you won't enjoy solving them. And if I don't give you enough, you'll be kind of mad at me. So I'm doing you a favor, saying just go ahead and PLAY.'"
guy-flat	"'Well, that way is the Problems Compound. If you can figure out some basic stuff, you'll make it to Pressure Pier. Then--oh, the people you'll meet!'"
guy-names	"'I know what you really want to ask. It's not at all about twisting things back around and making them the opposite of what they should mean. It's about SEEING things at every angle. You'll meet people who do. You'll be a bit jealous they can, and that they're that well-adjusted. But if you pay attention, you'll learn. I have. Though I've got a way to go. But I want to learn!'"
guy-problems	"'Well, it's a place where lots of people more social than you--or even me--pose real-life problems. Tough but fair. Lots of real interesting people. Especially the Baiter Master[if allow-swears is false]. Oops. You don't like swears? Okay. Call him the Complex Messiah[else]. AKA the Complex Messiah[end if]. But not [bg]. I haven't earned the right to. Or to enter Freak Control. It's guarded by a trap where a question mark hooks you, then an exclamation mark clobbers you.' He pauses, and you are about to speak...[wfk]'YEAH. He's really nice once you get to know him, I've heard, it's just, there's too many people might waste his time, or not deserve him or not appreciate him.' Guy stage-whispers. 'OR ALL THREE.'"
guy-mess	"'Oh, the [bad-guy]. He certainly knows what's what, and that's that! He certainly does things differently! But not all weird-like. A bit of time around him, and you too will know a bit--not as much as he did. He teaches by example! He can [activation of good egg]. Just his way of caring. Much nicer than [bad-guy-2]. Remember, it's up to YOU what you make of his lessons! Some people--they just don't get him. Which is ironic. They're usually the type that claim society doesn't get THEM[if allow-swears is true].' Guy whispers. '[activation of beat off] types[end if].'"
guy-bad2	"'[bad-guy-2]. Well, without the [bad-guy]'s snark, [bad-guy-2] would probably be in charge. The guy at [activation of first world problems]. Yeah. Extra strict. The [bad-guy], though, just likes to share a little snark. I remember that time he told me don't go thinking I'm too insignificant for his snark, or too above! What? Ah, you don't GET it. It was--well, the way he said it. Better than I did. So eye-opening, so motivational.'"
guy-bye	"'Whatever, dude.' [one of]It's--a bit harsh, you're not sure what you did to deserve that, but probably something[or]It's a bit less grating this time, but still[stopping]."

to say bad-guy:
	say "[if allow-swears is true]Baiter Master[else]Complex Messiah[end if]"

to say bad-guy-2:
	say "[if allow-swears is true][activation of buster ball]Buster Ball[else][activation of hunter savage]Hunter Savage[end if]";

to say bad-guy-2-c:
	say "[if allow-swears is true][activation of buster ball]BUSTER BALL[else][activation of hunter savage]HUNTER SAVAGE[end if]";

to say bg:
	say "[if allow-swears is true]BM[else]CM[end if]"

to say a-word:
	say "[if allow-swears is true]ass[else]***[end if]"

after quipping when qbc_litany is table of guy sweet talk:
	if current quip is guy-flat or current quip is guy-stuck:
		if guy-problems is not talked-thru:
			enable the guy-problems quip;
	else if current quip is guy-problems:
		enable the guy-mess quip;
	else if current quip is guy-mess:
		enable the guy-bad2 quip;
	else if current quip is guy-bye:
		check-babble;
		terminate the conversation;

to check-babble:
	d "Checking babble cue. Know-babble = [know-babble].";
	if know-babble is true:
		continue the action;
	if qbc_litany is table of gs:
		let tries be 0;
		repeat through table of gs:
			if response entry is talked-thru or response entry is guy-bye:
				increment tries;
			else:
				d "[response entry] not talked through.";
		if tries is not number of rows in table of gs:
			continue the action;
	if qbc_litany is table of gs: [e.g. just talked to guy]
		say "Well. That conversation with Guy was...thorough. But you wonder if you needed [i]all[r] the details. You imagine a babbling brook--then, wait...could you? Maybe you could ... BROOK BABBLING instead of TALKing, to just focus on the main stuff, because people aren't going to, like, [i]quiz[r] you. Yes. You think you see how, in the future.";
	else: [entering Broke Flat]
		say "You feel slight guilt you didn't ask Guy about everything, but not really, after that cheapo. Maybe--well, you don't need to feel forced to listen to everything others say. You can maybe BROOK BABBLING before TALKing so you're not swamped by unwanted details.";
		wfak;
	now know-babble is true;

section Game Shell

the Game Shell is scenery in Smart Street. "It's shaped like a carved-out turtle's shell[one of]. Scratched on the side you see a puzzle that didn't make it, marked OUT PUZZLE[or], with the out puzzle squiggled on it[stopping]. Behind the counter, Guy Sweet half-smiles, staring at the games on offer."

the out puzzle is part of the game shell. Understand "square" and "nine" and "nine dots" as out puzzle when player is in smart street. description is "[one of]It's the old puzzle where you have nine dots in a square and four lines and the solution is a diagonal arrow that goes outside the square. Everyone knows it, and in fact you understand the 'cheat' solutions of wrapping the paper around for one line, or treating the dots as having actual height, but somehow, you never felt you had the gravitas to explain how and why it's been done before, and you don't want to re-over-think why, now[or]Nine dots, four lines. Everyone sort of knows it[stopping]."

the printed name of out puzzle is "the 'out' puzzle".

instead of doing something with the out puzzle:
	if current action is not explaining and current action is not examining:
		say "No. You know the Out Puzzle. You forget if you got it when you saw it, but people made you feel awkward for actually knowing it. Best not to dwell--concentrate on Guy's, instead." instead;
	continue the action;

instead of entering shell:
	say "'Whoah. Back up there, champ. We need to, like, verify your [g-c]. Just PLAY a game here. Any game.'"

the games counter is part of the Game Shell. description is "[bug]"

instead of doing something with the games counter:
	say "It's there to keep you out. It's plain, but it has lots of games on it, though."

section leaving Smart Street

the gesture token is a thing. description is "It's inscribed with '[activation of acceptable]...' on one side and a bad knot on the other. [if player is in smart street]It's the closest to congratulations you'll probably get from Guy Sweet[else if player is not in variety garden]You wonder where it could be useful[else]The Word Weasel seems to crane in and look at the coin[end if]."

the bad knot is part of the gesture token. description is "It looks bad, but maybe it isn't."

instead of doing something with bad knot:
	if action is undrastic:
		continue the action;
	say "It's part of the coin and just there to make it less plain."

to say g-c: [this appears several places, so simplify the code]
	say "[activation of confidence games]"

check going inside when player is in Smart Street:
	if guy-games is not talked-thru and guy sweet is not babbled-out:
		say "'Hey! You anti-social or something? Have, y'know, meaningful conversation before exploring there!'" instead;
	if guy-flat is not talked-thru and guy sweet is not babbled-out:
		say "You don't know anything about Broke Flat. It might be really dangerous. Maybe you should ask someone about it. Even if the only someone around is Guy Sweet." instead;
	if your-game-wins is 0:
		say "'Dude! We need to, like, make sure you at least have [g-c] before you go in there. Try one of these games, or something!'" instead;
	repeat through table of guy taunts:
		if your-game-wins <= total-wins entry:
			say "A final salvo from Guy Sweet: [guy-sez entry][paragraph break]";
			wfak;
			check-babble;
			say "As you enter the flat, you hear a lock click--from the outside. There's no way out except down to a basement and a tunnel. At a dead end, you push a wall, which swivels and clicks again as you tumble into a lighted room. You push the wall again, but whatever passage was there isn't now.";
			continue the action;
	say "Guy Sweet remains quiet. He should not.";
	annotize game shell;

table of guy taunts
total-wins	guy-sez
1	"'Thanks for not wasting my time with these dumb brain teasers too much, but all the same, doing the bare minimum...'"
2	"'I guess you're prepared and stuff. Or not.'"
6	"'Nice job and all, but the puzzles are a bit more social in there. You know, talking to other people? Just a tip.'"
10	"'Smart enough to get that many puzzles, you're smart enough to know how much they don't mean in the real world, eh? Without, like, people skills."
15	"'You know, if you were more social, you'd be a total showoff. So you need to watch for that, if you get a clue in the Compound.'"
20	"'Whoah! You really do need some social well-roundedness to go with that knowing. No offense.'"
999	"'Boy! With all you learned about puzzles, you probably DIDN'T have time for common sensical stuff. Maybe you'll find it in there...or not.'"

section Broke Flat

Broke Flat is scenery in Smart Street. "[one of]It's--well, it's marked BROKE FLAT. And there's a lot that's broke(n). Windows, the foundation, etc. The pavement around it. None of which is worth looking at, but you're guessing any security system would also be broken, so you can enter pretty easily if you want[or]It's somewhere to go besides the endless expanse of urban waste to get lost in[stopping]."

to say n-w-flat:
	say "It's not worth your time to nitpick the things that make Broke Flat broke. It's not, well, hazardous"

the flat's windows are part of Broke Flat. description is "[bug]"

instead of doing something with the flat's windows:
	say "[n-w-flat]."

the flat's pavement are part of Broke Flat. description is "[bug]"

instead of doing something with the flat's pavement:
	say "[n-w-flat]."

the flat's foundation are part of Broke Flat. description is "[bug]"

instead of doing something with the flat's foundation:
	say "[n-w-flat]."

check entering Broke Flat:
	try going inside instead;

to say b-f:
	say "[if broke flat is not examined]the flat[else]Broke Flat[end if]"

section hide the logic games

After choosing notable locale objects:
	if player is in smart street:
		repeat with Q running through logic-games:
			set the locale priority of Q to 0;

rule for deciding whether all includes a logic-game: it does not.

after doing something with a logic-game:
	set the pronoun them to noun;
	set the pronoun it to noun;
	continue the action;

section jump macros

to move-puzzlies-and-jerks:
	now all clients are in lalaland;
	now player has quiz pop;
	move-puzzlies;

to send-bros:
	move brother big to lalaland;
	move brother soul to lalaland;
	move brother blood to lalaland;

to move-puzzlies:
	if in-beta is true:
		say "DEBUG NOTE: if you see someone or something astray, let me know.";
	now sal-sleepy is true;
	move Lee Bull to lalaland;
	move Sid Lew to lalaland;
	move harmonic phil to lalaland;
	move long string to lalaland;
	move poory pot to lalaland;
	move art fine to lalaland;
	move poetic wax to lalaland;
	move officer petty to lalaland;
	move sly moore to lalaland;
	move money seed to lalaland;
	move cold contract to lalaland;
	move trade of tricks to lalaland;
	move wacker weed to lalaland;
	move Fritz the On to lalaland;
	move Terry Sally to lalaland;
	move trail paper to lalaland;
	move boo tickety to lalaland;
	move fourth-blossom to lalaland;
	move reasoning circular to lalaland; [this blocks Court of Contempt]

section write-undo

to write-undo (x - text):
	repeat through table of vu:
		if brief entry matches the regular expression "[x]":
			if found entry is false:
				ital-say "You may have found a secret command that will jump you across rooms you haven't seen. However, you can UNDO or RESTART if you'd like.";
			else:
				say "[line break]";
			now found entry is true;
			if brief entry is a brief listed in table of verbmatches:
				prep-action brief entry;
			continue the action;
	say "[bug] -- [x] was called as a table element.";

section ducksitting [skips to tension surface]

ducksitting is an action applying to nothing.

understand the command "duck sitting" as something new.

understand "duck sitting" as ducksitting.

carry out ducksitting:
	if player is not in smart street:
		say "Boy! Knowing then what you know now, you'd have liked to duck sitting in [if player is in round lounge]this[else]some[end if] lounge and getting to action back in Smart Street. (NOTE: you need to RESTART to use this)." instead;
	say "You[activation of sitting duck] open the door to Broke Flat slowly, looking inside for people waiting in ambush. Nobody. You skulk around a bit more--hmm, a passage you'd've missed if you just ran through. You think you see your bathroom up ahead. Wait, no, it's another weird warp. "; [temproom general concepts]
	write-undo "duck";
	duck-sitting;
	the rule succeeds;

to duck-sitting:
	now jump-level is 1;
	move player to tension surface;
	now player has gesture token;
	open-babble;

to open-babble:
	if know-babble is false:
		say "Also, in addition to this shortcut, you remember another one. You can [b]BROOK BABBLING[r] to abridge a conversation, so you just get the main points.";
		now know-babble is true;

section knockharding [get to pressure pier]

understand "knock" and "knock [text]" and "[text] knock" as a mistake ("'That's the [activation of knockwurst] I ever heard!' proclaims Guy Sweet. 'Not that you need to be good at knocking to get through life. Just, y'know, didn't have much meat.") when player is in smart street.

knockharding is an action applying to nothing.

understand the command "knock hard" as something new.

understand "knock hard" as knockharding.

carry out knockharding:
	if player is in questions field:
		say "That would've gotten you into Broke Flat and beyond, but it won't do much to get into Freak Control." instead;
	if player is in joint strip:
		say "There's no secret knock or password. Either you can get in the Soda Club, or you can't." instead;
	if player is not in smart street:
		say "There's nothing to knock hard at. Or nothing it seems you should knock hard at. Not like Broke Flat back in Smart Street[if pressure pier is unvisited]--you'd need to RESTART to try that[end if]." instead;
	say "You stride up to Broke Flat with purpose. You knock, hard,[activation of hard knock] hoping to avoid a hard knock--and you do! You are escorted through a maze of hallways that eventually open up to a wide area with water behind: Pressure Pier. "; [temproom general concepts]
	write-undo "knock";
	knock-hard;
	the rule succeeds;

to knock-hard:
	now jump-level is 2;
	move player to pressure pier;
	now gesture token is in lalaland;
	open-babble;

section figure a cut [get to the Nominal Fen]

figureacuting is an action applying to nothing.

understand the command "figure a cut" as something new.
understand the command "figure cut" as something new.

understand "figure a cut" as figureacuting.
understand "figure cut" as figureacuting.

to say jump-reject:
	say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. Maybe if you somehow restart things and wind up back at Smart Street, you could";

to say jump-reject-2:
	say "[jump-reject][if Nominal Fen is visited]. But, eh, you already made it to the [jc][else]. You'll need to RESTART to jump ahead to the Nominal Fen this way";

carry out figureacuting:
	if player is not in smart street:
		say "[jump-reject-2]." instead;
	say "Guy Sweet yells[activation of cut a figure] 'Hey! Where are you going? I mean, you're probably like accelerated in school but if you think you're accelerated at life...' You ignore him. You don't need to be taught a same lesson twice. Well, not this one. You rattle the doorknob just so--and you recognize a few odd passages in Broke Flat--and bam! You fall through an invisible slide to the [jc]. "; [temproom general concepts]
	write-undo "figure";
	figure-cut;
	the rule succeeds;
	open-babble;

to disable-ticketies:
	now minimum bear is in lalaland;
	now off-the-path is true;
	now your-tix is 4;
	now caught-sleeping is true;

to figure-cut:
	now jump-level is 3;
	disable-ticketies;
	move player to Nominal Fen;
	now trail paper is in lalaland;
	now Terry Sally is in lalaland;
	now gesture token is in lalaland;
	open-babble;

chapter trackbeatening [lets you know the jerks solution]

trackbeatening is an action applying to nothing.

secrets-open is a truth state that varies.

understand the command "track beaten" as something new.

understand "track beaten" and "track the beaten" as trackbeatening.

to say periodly:
	if in-parser-error is true:
		say ".[no line break]";
		now in-parser-error is false;
	else:
		say ".";

carry out trackbeatening:
	if boris is in lalaland:
		say "You already figured the [j-co]['] secrets, but after that episode, you realize that other people's secrets may be there, if you know where to look. That leaves potential for abuse but also it's good to know everyone else isn't ten times as impervious as you to misfortune. Wait, no, not strictly good. But you feel less odd." instead;
	if secrets-open is true:
		say "You've already made a commitment to track the beaten[if finger index is not off-stage], and you can re-read everyone in full on the Finger Index back in Accountable Hold[else], though you haven't uncovered any specific evidence, yet[end if]." instead;
	say "[activation of beaten track][if finger index is examined]You take some time to track the possible names on the Finger Index. And you remember pieces of conversation from the [j-co]. One guy was too hesitant, or too eager, to dismiss this or that, or he knew too much about this subject, or played too dumb about that subject. Oh goodness. You've missed or dismissed those clues before in other situations. And you're a bit embarrassed the Labor Child figured things out so young. But--well, there were clues. You see that now[else]Nothing happens, or seems to. But you just feel you're more open to what people may be saying, or doing, and putting clues together so you're not in the dark about certain things[end if][periodly]"; [temproom general concepts]
	now secrets-open is true;
	the rule succeeds;

chapter fancypassing [skips you to Questions Field with just the jerks left]

fancypassing is an action applying to nothing.

understand the command "fancy passing" as something new.

understand "fancy passing" as fancypassing.

carry out fancypassing:
	if player is not in smart street:
		say "You daydream about how nice it would be to just be able to move ahead and be almost done. You daydream long enough that--why stop with doing so here? Do so back in Smart Street. Yes. That would be neat. if you could RESTART and jump." instead;
	say "You don't know how you know, but you know there's a hidden compartment in the Game Shell that will drop you by Freak Control[activation of passing fancy] and leave any guardians speechless and impressed enough that they'll listen to you instead of the [bad-guy].[paragraph break]Guy Sweet whines 'Cheater!' as you enter. You're surprised how well the conversation with the Keeper Brothers goes. You never really had that sort of confidence before."; [temproom general concepts]
	send-bros;
	write-undo "fancy";
	fancy-pass;
	the rule succeeds;

to fancy-pass:
	move-puzzlies;
	disable-ticketies;
	now jump-level is 4;
	move player to questions field;
	now the score is 16;
	now gesture token is in lalaland;
	open-babble;

section notice advance [skips you to the endgame before the BM, Nominal Fen solved]

jump-level is a number that varies.

noticeadvanceing is an action applying to nothing.

understand the command "notice advance" as something new.

understand "notice advance" as noticeadvanceing.

carry out noticeadvanceing:
	if player is not in smart street:
		say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. You may wish to restart the game." instead;
	say "Guy Sweet[activation of advance notice] yells 'Hey! What could you POSSIBLY... you can't just... someone a lot less lame must've showed you that, no offense...' "; [temproom general concepts]
	write-undo "notice";
	notice-advance;
	the rule succeeds;

to notice-advance:
	move-puzzlies;
	disable-ticketies;
	now jump-level is 4;
	move player to questions field;
	now all clients are in lalaland;
	now player has quiz pop;
	send-bros;
	now the score is 17;
	now last notified score is 17;
	now gesture token is in lalaland;
	open-babble;

section brookbabbling

brookbabbling is an action applying to nothing.

understand the command "brook babbling" as something new.

understand "brook babbling" as brookbabbling.
understand "bb" as bbing.
understand "b b" as bbing.

bbing is an action applying to nothing.

carry out bbing:
	unless accel-ending:
		if ever-babbled is false and know-babble is true:
			say "You use a little slangy shortcut in your own mind. You found it hard to, but hey, why not?";
		else if know-babble is false:
			say "Bbbbb, you think, you aren't going to worry about every single conversational detail, THIS TIME.";
			now know-babble is true;
		now ever-babbled is true;
	try brookbabbling instead;

know-babble is a truth state that varies.

ever-babbled is a truth state that varies.

definition: a person (called pe) is blabbable:
	if litany of pe is table of no conversation, decide no;
	if pe is babbled-out, decide no;
	if pe is in location of player, decide yes;
	decide no;

definition: a person (called pe) is chattable:
	if pe is Alec Smart, decide no;
	if pe is in location of player, decide yes;
	decide no;

a person can be babbled-out. a person is usually not babbled-out.

brooktrying is an action applying to one thing.

understand "brook [a person]" as brooktrying.
understand "bb [a person]" as brooktrying.
understand "b [a person]" as brooktrying.
understand "b b [a person]" as brooktrying.

carry out brooktrying:
	if noun is not a person:
		say "You can only zone out a person's conversation." instead;
	if noun is the player:
		say "Impossible to shut out your own thoughts." instead;
	consider the babble-shush rule;
	if the rule succeeded:
		continue the action;
	if player is in chipper wood and Cute Percy is in chipper wood:
		try talking to Cute Percy instead;
	if noun is babbled-out:
		recap-babble noun;
		the rule succeeds;
	if noun is blabbable:
		babble-out noun;
		the rule succeeds;

carry out brookbabbling:
	consider the babble-shush rule;
	if the rule succeeded:
		continue the action;
	if player is in chipper wood and Cute Percy is in chipper wood:
		try talking to Cute Percy instead;
	if number of blabbable people > 1:
		d "[list of blabbable people].";
	if number of blabbable people is 0:
		if number of babbled-out people in location of player > 1:
			say "There's more than one person you babbled with/to. Try to TALK to them individually for a recap." instead;
		if number of babbled-out people in location of player is 1:
			recap-babble a random babbled-out person in location of player;
			the rule succeeds;
		say "There's no one here to babble with. With whom to babble." instead;
	if number of blabbable people is 1:
		let dude be a random blabbable person;
		babble-out dude instead;
	if number of blabbable people > 1:
		if player is in discussion block:
			say "Art and Phil both seem equally tough to talk to. You can B/BB/BROOK ART or PHIL, though." instead;
		if player is in soda club:
			say "You decide to talk to Ally Stout for a bit[if erin is in soda club]. He seems safer than Erin, to start[end if].";
			babble-out Ally Stout instead;
		say "There are too many people to pick out to babble at. You can B/BB/BROOK any one individual.";
	the rule succeeds;

this is the babble-shush rule:
	if accel-ending:
		say "You're already saying whatever to whatever anyone's saying.";
		the rule succeeds;
	if player is in freak control:
		say "The awkward silence is too oppressive. Besides, you don't have the [bad-guy]'s attention yet.";
		the rule succeeds;
	if player is in speaking plain:
		say "You don't have much choice but to put up with Dutch and Turk.";
		the rule succeeds;
	if player is in temper keep:
		say "[if sal-sleepy is true]Sal is sleeping and has nothing to say[else]Sal's complaining is harmless but uninformative[end if].";
		the rule succeeds;
	if player is in scheme pyramid and labor child is in scheme pyramid:
		say "The Labor Child isn't one for small talk, especially around unconsequential people like you. No offense.";
		the rule succeeds;
	if player is in airy station:
		say "The crowd is certainly babbling, but nothing too in-depth or detailed.";
		the rule succeeds;
	if player is in truth home and Sid Lew is in truth home:
		say "You can't really zone Sid Lew out.";
		the rule succeeds;
	the rule fails.

to babble-out (pe - a person):
	repeat through table of npc talk summaries:
		if babbler entry is pe:
			if pe is part-talked:
				say "Unfortunately, you already started talking in-depth-ish with [the pe], so changing up is too tricky.";
				continue the action;
			choose row with babbler of pe in table of npc talk summaries;
			say "[babble-content entry][line break]";
			now pe is babbled-out;
			if there is a babble-reward entry:
				now player has babble-reward entry;
				if pe is word weasel:
					now gesture token is in lalaland;
			if pe is buddy best:
				move player to questions field;
			if ever-babbled is false:
				say "[line break]Well. Now that you, err, abridged the conversation, you feel as though you can abridge how you think of it. Instead of [b]BROOK BABBLING[r], well, [b]B[sr-space]B[r] (with or without a space) would work.";
				now ever-babbled is true;
			if pe is sly moore:
				say "Oh. You also find his name. Sly Moore.";
				now talked-to-sly is true;
			the rule succeeds;
	say "BUG! [pe] should have a babble shortcut in the table of npc talk summaries. I think.";

to decide whether (pe - a person) is part-talked:
	let Q be the litany of pe;
	if Q is table of no conversation:
		say "OOPS [pe] has a bug with part-talked code. This shouldn't happen but is fixable.";
		decide no;
	repeat through Q:
		if response entry is talked-thru and enabled entry < 2:
			decide yes;
	decide no;

table of npc talk summaries
babbler	babble-content	babble-recap	convo-recap	babble-reward
Word Weasel	"Something about how the weasel's willing to give you its signature, which is very valuable indeed helping you move on in the world. It [if player has gesture token]seems interested in a swap[else]got you to trade your token plus some work for the pick[end if]."	"[weasel-babble]"	--	a thing
Guy Sweet	"Guy Sweet blinks at you. 'Whoah! You're, like, more accelerated than most people at this whole social thing. Here, play a game, any game. It's sort of an aptitude test thing.'"	"Guy seemed impressed you took initiative and weren't intimidated[if gesture token is off-stage], but he's still waiting for you to play a game[else], and he even gave you that gesture token, too[end if]."	"Guy talked about the [bad-guy] and how you'd have to be very clever to meet him, and when you did, you'd better not waste his time."
Mouth Mush	"The mouth mush harangues you about needing certification to go through the arch to the north. This isn't a big area, so it can't be far."	"The mouth mush wanted some sort of document."
Fritz	"Many variants on 'Whoah dude whoah,' mumbling about the friend he lost[if fritz has minimum bear]--and you found[end if]."	"He was pretty incoherent, mumbling about a lost friend[if fritz has minimum bear] that you found[end if]."	--	--
Stool Toad	"The usual ordering to keep your nose clean, don't go off the beaten path, or litter, or annoy people, or have illicit substances."	"Ugh. You have had enough of officious adults telling you you seem like a good kid so that's EXTRA reason how you better keep clean."	"You sat through a disturbingly long lecture about what you'd better not do, and you felt guilty at both what you heard before and what you didn't."
Ally Stout	"He mentions all the places he's been and all the exciting people he's met, so much more exciting than here, no offense, you'll be exciting one day. Why, a bit of alcohol might help! [ally-offer]"	"Something about how exciting he was, and you could be, maybe. It doesn't feel so warm, in retrospect. [ally-offer]"	"Ally Stout certainly had a lot to say, but you get the feeling it was just minimal banter. [ally-offer]"	--
Erin Sack	"She--well, she seems to be making sense, but you feel obliged to agree with her without thinking in order to show her you're thoughtful. You notice she doesn't have a drink."	"She doesn't seem up for small talk, but she grabs an imaginary drink and swirls it."	"It was pretty head-spinning, but then, maybe it was just all bluster. She seems disinterested in you."
Terry Sally	"The usual greetings, as he exhorts you to be good--not too good, though. Maybe if you have some proof you're not totally boring and squeaky clean, you'll be bare-knuckle enough for the Compound proper. [if your-tix is 0]You'll--well, you'll know what, once you start picking up demerits[else]Probably the boo ticketies[end if]."	"Terry Sally wanted some sort of document[if your-tix is 4], maybe like that trail paper you've got[else if your-tix > 0], and your ticketies don't quite make one yet[end if]."
Buddy Best	"Buddy Best begins talking a mile a minute about Big Things, and it's impressive all right, and you're not sure how much you should interrupt to say so. You don't at all, and eventually he gets bored of you staring at him and hands you something called a Reasoning Circular and boots you back east."	"BUG. This should not happen."	--	Reasoning Circular
Pusher Penn	"He drones on about exciting business opportunities and pushes some wacker weed on you to help you, apparently, get a taste of cutting-edge business."	"[if wacker weed is in lalaland]'Business, eh?'[else]He rubs his hand and makes a 'come here' gesture.[end if][penn-ask]"	"[if wacker weed is in lalaland]Pusher Penn wanted you to run an errand, and you did. He seems pretty disinterested in you now[else if player has wacker weed]You still need to find whom to give the weed to[else]You get the feeling Pusher Penn is all business[end if]."	wacker weed
Art Fine	"Art goes to town on the superiority of unwritten art to written art. You guess it's persuasive, but you wonder if Phil would've been even more persuasive, if his views were switched."	"He was pretty convincing about spontaneous art versus art restricted by the written word."
Harmonic Phil	"Phil goes to town on the superiority of unwritten art to written art. You guess it's persuasive, but you wonder if Art would've been even more persuasive, if his views were switched."	"He was pretty convincing about intellectual art versus art that might appeal to less clever people."
Sly Moore	"[sly-s] haltingly asks if you found anything that could help him be less klutzy? He needs it a bit more than you. Um, a lot."	"'Uh, not got anything yet for my klutziness? No worries, I'd do even worse.'"	"He wanted something to help him be less klutzy."	--
Officer Petty	"Officer Petty boomingly proclaims a need for theoretical knowledge to augment his robust practical knowledge."	"'NOTHING FOUND YET? DIDN'T THINK SO. STILL, I CAN HOPE. I COULD USE SOME HIGHBROW FINESSE, I ADMIT IT.'"	"Officer Petty needed something to expand his skills beyond shouting and intimidation."	--
Grace Goode	"She mentions how having a flower for the googly bowl [if fourth-blossom is in lalaland]is so[else]would be[end if] nice."	"[if fourth-blossom is in lalaland]'Thank you for returning the flower to the bowl.'[else]'Have you found a flower for the googly bowl?'[end if]"	"[if fourth-blossom is in lalaland]There's no need for words now that the flower is back in the googly bowl[else]She was hoping for a flower for the googly bowl[end if]."
generic-jerk	"Each [j-g] seems to be hiding something for all his bluster."	"Each [j-g] put up a good face but there was something wrong about all the bragging."	--
Brother Big	"Brother Big mutters about how he's not very clever and he'd like to change that."	"Brother Big asked for something to make him cleverer."	--
Brother Soul	"Brother Soul frowns and pines for something to cheer him up."	"Brother Soul asked for something to cheer him up."	--
Brother Blood	"Brother Blood moans about how he thinks more violent thoughts than he should, and he wants to change that, and not just to look or seem better."	"Brother Blood seemed upset at how upset he was about things."	--
Baiter Master	"[bug] -- you should be forced to see all the conversation."	"[bug] -- you should be forced to see all the conversation."	--

to say weasel-babble:
	if player has gesture token:
		say "We could make a business arrangement, here.";
	else if burden-signed is true:
		say "I won't waste your time if you won't waste mine. Don't make me rip up that signed burden. Deal? Deal.'";
	else if dirt-dug is false:
		say "'Chop chop! Dig dig. Like you promised. Like you made me make you promise.'";
	else if player has proof of burden:
		if burden-signed is true:
			say "You probably got everything you could from the weasel.";
		else:
			say "The weasel needed something to sign. Maybe the proof of burden is it.";
	else:
		say "'Go out! Be inspired by my talk! Do things! Find things!'"

to say penn-ask:
	if player does not have weed:
		say "You haven't moved the product yet.";
	else:
		say "Give him the dreadful penny?";
		if the player yes-consents:
			try giving the penny to Pusher Penn;
		else:
			say "You wonder who else will take it."

to say ally-offer:
	if cooler is in lalaland and brew is in lalaland:
		say "'Oh, and I'm out of free drinks, kid.'";
	else if your-tix is 4:
		say "You decline the offer of a free drink. You're on the edge enough.";
	else if cooler is off-stage and brew is off-stage:
		say "'Want a drink, kid? Nothing too harsh.'";
		if the player yes-consents:
			let Z be a random drinkable;
			now the player has Z;
			say "Ally Stout hands you [the Z].";
	else if player has cooler or player has brew:
		say "'I'd offer you another drink, but drink what you got, kid.'[no line break]";
	else:
		say "'Want the other drink, kid?'";
		if the player yes-consents:
			let Z be a random drinkable not in lalaland;
			now the player has Z;
			say "Ally Stout hands you [the Z].";

to recap-babble (pe - a person):
	say "You've already had a chat. Re-summarize?";
	if the player yes-consents:
		choose row with babbler of pe in table of npc talk summaries;
		if there is no babble-recap entry:
			say "BUG [babbler entry] needs a babble recap!";
		else:
			say "You forget the details, but it went a little something like this:[paragraph break][babble-recap entry][line break]";
		if there is a babble-reward entry:
			say "[line break]You also remember you got [the babble-reward entry][if babble-reward entry is in lalaland], which you figured how to use, so yay[end if].";
		the rule succeeds;


section chessboard

the chess board is a logic-game in Smart Street. description is "The chessboard has eight queens all of one color lumped into an almost-3x3 square in one corner."

understand "chessboard" as chess board.

section matchsticks

the match sticks are a plural-named logic-game in Smart Street. description is "Match sticks are arranged as equations or makeshift animals, apparently just a few flips away from becoming something new."

understand "matches" and "matchsticks" as match sticks.

section hangman

hangman is a logic-game in Smart Street. description is "Well, it's not an actual structure, just a bunch of blanks for you to guess the right letters."

understand "hang man" as hangman.

section peg solitaire

Peg Solitaire is a logic-game in Smart Street. description is "It's an intersection of 3x7 rectangles with a hole in the middle. You know, where you jump a peg over another until--hopefully--they're all gone, except for one in the center. It makes you think of a lonely girl you should've asked out, for some reason."

understand "pegs" as peg solitaire

section gallon jugs

there is a logic-game called the gallon jugs in Smart Street.

description of gallon jugs is "Well, the gallon jugs are really a lot smaller. Or they'd take up the whole shell. But they're clearly marked as [if times-won of jugs is 0]3-, 4- and 5-[else if times-won of jugs is 1]5-, 7- and 10-[else]10-, 11- and 17-[end if]gallon jugs."

understand "jug" and "gallon jug" as gallon jugs.

section Nim

Nim is a logic-game in Smart Street. description is "It's really just a selection of pegs in a few rows of holes. Players alternate, and each turn you take any number of pegs from a remaining row. The object is to make the other guy take the last one."

section towers of hanoi

there is a plural-named proper-named logic-game called the Towers of Hanoi in Smart Street.

description of the Towers of Hanoi is "It's that classic old game of moving all the rings from the left of three towers to the right, where you can't put a bigger ring on a smaller one. Currently there are [times-won of Towers of Hanoi + 2] on the [l-r-hanoi] pole."

the rings are part of the towers of hanoi. description of rings is "They're stacked smallest on top, largest on bottom, on the [l-r-hanoi] peg."

the middle pole is part of the towers of hanoi. Understand "left/right pole" and "left" and "right" as middle pole when player is in smart street. description is "[bug]"

instead of doing something with the middle pole:
	say "There's nothing special about the poles. About all you can do is PLAY the towers."

understand "tower" as towers of hanoi.

to say l-r-hanoi:
	if the remainder after dividing times-won of towers of hanoi by 2 is 0:
		say "right";
	else:
		say "left";

instead of doing something with the rings:
	say "You can PLAY the towers if you want to tinker with the rings.";

section river boat

the river boat is a plural-named logic-game in Smart Street. description is "It's the old wolf, goat and cabbage puzzle, where you can take only two across the river at a time and the goat can't be left with either. The figures are kind of cute, but it's easy to see how they could get lost."

understand "riverboat" as river boat.

the necklace is a logic-game in Smart Street.

description of the necklace is a "It's a necklace with [nlinkx] links. Where you have to cut it [if times-won of necklace is 0]once[else if times-won of necklace is 1]twice[else]three times[end if] to get all the numbers up to [nlinkx], so you can pay for [nlinkx] days."

to say nlinkx:
	say "[if times-won of necklace is 0]seven[else if times-won of necklace is 1]seventeen[else]thirty-seven[end if]"

section rubik's cube

the Rubik's Cube is a logic-game in Smart Street.

understand "rubik/rubiks cube" and "rubik/rubiks" as rubik's cube

description of Rubik's Cube is "It's [if times-won of cube is 0]totally messed up[else if times-won of cube is 1]almost there[else if times-won of cube is 2]totally solved, and you don't know how to do any cool tricks with it, and you don't want to mess it up again[end if]."

section logic puzzles

the logic puzzles are a plural-named logic-game in Smart Street. description is "It's got some clues about [if times-won of logic puzzles is 0]who lives, or doesn't live, at which address[else if times-won of logic puzzles is 1]not just who lives at which address, but what color their houses are or aren't[else if times-won of logic puzzles is 2]addresses, house color, AND pets, oh my[else if times-won of logic puzzles is 3]addresses, house color, pets AND nationality[end if]."

section general logic game stuff

instead of doing something with a logic-game:
	if current action is playing or action is undrastic or current action is attacking:
		continue the action;
	if current action is taking:
		say "'Dude, no stealing!' says Guy. 'If you want to muck with a game, you can PLAY with it.' Besides, you've seen that puzzle before." instead;
	say "There's not much to do except PLAY [the noun] or EXAMINE it.";

to decide whether (l - a logic-game) is defeated:
	if max-won of l is 0:
		decide no;
	if max-won of l is times-won of l:
		decide yes;
	decide no;

section logic game win grid

max-game-wins is a number that varies.

your-game-wins is a number that varies.

table of logic game wins
the-game	num-wins	quote
gallon jugs	0	"You've seen this before. Pour three gallons out of the five, the remaining two in the three, pour out the five, fill it, and pour one gallon in the three.[paragraph break]'Less style than Bruce Willis in Die Hard 3. You did see that, right? Right? But you solved this all nonchalant-like, so maybe you'll have more fun with a ten-quart jug. And a seven! And a five! I guess it's fun for people who find this fun!'"
gallon jugs	1	"Ignoring any reason why anyone would want this, you continually pour water into the seven-'gallon' jug, then into the ten [']til it's full, pouring the 10 out. Eventually you get 5. Guy replaces the five- and seven-gallon jugs with eleven and seventeen."
gallon jugs	2	"[one of]Just, no. Your unsteady hand means it'll spill something so it's all just inaccurate and, really, who the heck uses seventeen-gallon jugs anyway? You explain to Guy about relatively prime numbers and so forth, and he motions for you to get on with it.[or]You don't need any more busy work to show you know the gallon jug puzzle.[stopping]"
Nim	0	"Guy sets the game up, putting pegs randomly in rows. You beat him several times, while recalling how students two years ahead mocked you for not understanding simple BINARY. Then a year later you almost got beaten up for failing to explain the mathematical induction behind it to people who didn't really care but didn't believe you.[paragraph break]'Wow. That's impressive. How'd you do that? No, don't answer, I was just being polite asking. Anyway, congratulations.'"
Nim	1	"You beat Guy Sweet a few times and even set things up so he can't win moving first. 'Ah! But can you get the last word in an argument?' he nods significantly."
Nim	2	"Before you can play again, Guy assures you he knows you're a world class Nim player and such. But really, what good will it do you in a future job, or at parties?"
Peg Solitaire	0	"You remember about symmetry, about not leaving pegs too isolated. Bottom clear, left side clear, right side clear. You remember it's tricky with eleven pegs, but you remember the final clump of five. There. That reverse, and done. Guy Sweet is impressed. 'Not bad! But I bet you can't do it again! And a bit different!'"
Peg Solitaire	1	"You proceed again. Bottom, right, left. The end goes quicker. 'Hey! That's not fair! You have a pattern! There's symmetry! That's cheating! I don't know how, but it is!'"
Peg Solitaire	2	"'Hey! No! Don't move the bottom peg up first! Challenge yourself!' It's confusing, but you figure what to push, where, much slower. Guy gives things a shot, bungles it and says, well, he has more important things to think of."
Peg Solitaire	3	"Guy brushes your hand away. 'I'm not interested any more. I'm sure you practiced hard to get so good, but it's kind of boring for me to watch, y'know? Maybe there's other formations that'll trip you up, but I'm too busy to think of them.'"
river boat	0	"You know this puzzle. You've aced it. Bring all three things over without the goat or cabbage getting eaten. Goat over, back, Wolf over, goat back, cabbage over, back, goat over. 'Everybody gets that one,' muses Guy, as he pulls out some additional tokens. 'Now, a boat that carries two of five things.'"
river boat	1	"Despite the extra two things involved, it's really just a matter of counting. Or numbering the pieces. Two and four over, none back, one and three over, two and four back, five over, two and four over."
river boat	2	"[one of]You yawn as you realize Guy's extension to seven things to cross the river is trivial. Two/four/six over, one/three/five, evens back, seven over, two/four/six over. Guy 'empathizes.'[or]You feel a vague accomplishment solving the old riverboat problem's extensions. All the same, you're sort of over it by now.[stopping]"
Rubik's Cube	0	"You figured how to get one surface all the same color, but it just got tougher from there. You had the big picture but forgot if you should twist left down up right or right down up left. 'Well, at least you're not one of those weird geniuses with useless skills,' Guy Sweet says, emphasizing GENIUSES a bit too much for your comfort.[paragraph break]There's a bit left...but you've impressed him, you think."
Rubik's Cube	1	"[one of]You sort of nod that you know how to do the rest. Guy says 'I guess I'll buy it. Anyway, I'm not interested in seeing the rest.'[or]Guy groans as you reach for the cube. Well, you were worried you'd mess it up, yourself.[stopping]"
towers of hanoi	0	"'Big deal, it's almost harder to mess up than get right!' Guy Sweet adds a ring to the left, then restacks the right on the left."
towers of hanoi	1	"You remember to put the first ring on the right. Guy Sweet still chuckles and says it's too easy."
towers of hanoi	2	"First ring in the center. It's a bit of a slog but you can still visualize it. You have to put the small ring back on the left."
towers of hanoi	3	"You remember the horrible recursion problem from programming class which doesn't seem so bad now. With five rings, you certainly have time to plan it. Hanoi (X-1, left to middle), flip X, Hanoi (x-1, middle to right.) Not that the grunt work's actually any fun."
towers of hanoi	4	"You proceed more out of obligation, maybe hoping Guy Sweet will give you a compliment. 'Boy! If you can do this sort of thing, you might be good at something useful! Well? Are you?' It's a rhetorical question."
towers of hanoi	5	"Good lord, no. You know it's going to take all of 63 moves. And, well, you've already gotten through--1, 3, 7, 15, 31, so, 59. There's some sort of twisted bizarre induction that would keep you going. But no."
match sticks	0	"You re-organize, from memory, a few matchsticks to reverse a fish and a martini glass and a triangle.[paragraph break]'What's the matter? These not fun for you? Okay, okay, got some harder ones.'"
match sticks	1	"You rearrange a few matchsticks to change false equations into real ones. These are puzzles you hadn't seen, but then, there are only so many possibilities. 'Dude! Lame! I saw you pointing at where the matchsticks should go, brute-forcing them. I thought you had, like, intuition and stuff.'"
match sticks	2	"'Sorry, dude. I'm all out of matchstick puzzles. And are matchstick puzzles really what life's all about? You know, if you were more social I bet you could find more matchstick puzzles. Though there's better things to do in social circles than matchstick puzzles. But hey, whatever.'"
hangman	0	"Guy gives you a few long words, which you recognize as easy. You try for the E-T-O-A-N three times in a row, but he calls you out for being boring. Good thing you don't remember the next five most popular letters in the alphabet."
hangman	1	"It's a bit tougher this time. Guy uses a few words with weird letters. You even trip up and guess a letter twice, and Guy insists that counts as something wrong, and you're never going to win that argument. But you pull everything out in the end. You move on to I and D and R and S to start, actually thinking after each move."
hangman	2	"It gets tenser and tenser as the words get down to six and seven letters. On WAXWING Guy asks you if you know what it means (you don't dare to ask back,) and then HAZING almost gets you. Guy keeps asking if you're actually good at, well, using these words? You finally slip on JINXED, where Guy claims you really should've done better after getting off to such a good start."
hangman	3	"Guy shrugs. 'Look, I finally beat you, and I don't want to have to play [']til I can beat you again. No offense but it got kind of tedious even when you changed from that E-T-O-A-N stuff. Maybe you can go figure the algorithm or something to make some tough words, or maybe you can, y'know, use the words better in conversation.'"
chess board	0	"You remember a cheap trick where you can eliminate the queens from the very center. From there it's pretty easy, since they can't be in the corners. You place one THERE--and the rest logically follow.[paragraph break]'Well, that's not fair. You didn't think. I'm sure you used a cheap trick. Still, I guess you deserve credit. Even if you don't know any other way.'"
chess board	1	"Under Guy's watchful eye, you can't solve the chessboard the same way again. But maybe if the queens were knight moves away--yes, start at the corners ('Dude! You're already wrong!') and put queens at knight's distance. Then switch one corner queen's row with another, then another pair...trial and error...bam![paragraph break]'Good job, I guess. Not sure if that REALLY counts, either. You were kind of guessing and flailing, there.'[paragraph break]You bite your tongue before asking just what DOES really count--but you can never force a straight answer, there."
chess board	2	"You just don't need any more goading--whether or not you find another position, Guy will invalidate how or why you got there."
necklace	0	"You remember the first time you solved it. After all, there were only seven--well, four places to cut the necklace. Three obviously didn't work. Your math teachers were suspicious you solved it a bit too quickly. Of course now everyone knows to cut the third link in, then 1+2+4 gets all numbers up to seven. Guy Sweet replaces the necklace with a much longer necklace. 'Yeah? Well, what if you got 2 cuts? How many numbers could you make?'"
necklace	1	"You get two cuts this time. 7+1=8, leaving a link of 9 chains. Then cut the 7 as before."
necklace	2	"The third puzzle is just more arithmetic. 17+1=18, so the next big link is 19, and so forth. You see the pattern. You tell Guy you could prove it by mathematical induction, but he cringes in fear. Wow! Micro-revenge! Usually YOU get tweaked for knowing stuff like that."
logic puzzles	0	"You don't even need the scratch paper Guy offers you. There are only so many possibilities and a lot of clues. 'Well, yeah, even I could do that,' he mutters. 'Try something more advanced?'"
logic puzzles	1	"It's a bit tougher, now. You hand-draw a grid on a piece of paper Guy gives you. There are more clues to wade through. It's sort of fun, nosing into people's houses (but not really) without having to ask any nosy que...[paragraph break]'Nice job. I knew a guy who can do it in his head--don't worry, you have more hope than him...' Guy takes the scratch paper and crumples it and throws it away. 'Aw, you couldn't have been ATTACHED to it, right?'"
logic puzzles	2	"You work away. It's a bit tedious, and you're not sure what you get, and you remember burning through a whole book so quickly your parents said you'd have to wait for a new one. It's knowledge you never lose, and as you mechanically fill in a few more, Guy crumples it and throws it."
logic puzzles	3	"That's the problem with logic matrix puzzles. You do too many, you prove to yourself they're not interesting, the clue combos can go so many ways. It might be interesting to see how to generate them, but that's too far out there. You see a clear choice between seeming lazy and potentially boring Guy, and after some mental gymnastics, you opt for lazy.[paragraph break]There's a brain game in here for a third option you can't quite solve. [if allow-swears is true]Damn[else]Rats[end if]."

section playing

playing is an action applying to one thing.

understand the command "play/try/solve" as something new.

understand "play [something]" and "solve [something]" and "try [something]" as playing.
understand "play" and "try" and "solve" as playing.

to say ok-rand:
	say "OK. If you want to see them all, X GAMES. Otherwise, PLAY will automatically pick a random game next time"

pick-warn is a truth state that varies.

rule for supplying a missing noun when the current action is playing (this is the play a game any game rule):
	if location of player is smart street:
		unless guy sweet is part-talked or guy sweet is babbled-out:
			say "[one of]'What? You gonna just play any old game without chatting a bit first?'[or]You'd like to poke around the merchandise, but Guy Sweet is glaring at you, waiting for you to TALK.[stopping]" instead;
		if pick-warn is false:
			now pick-warn is true;
			say "There are a lot of games. To be precise, [number of logic-games in words]. Just pick a random one?";
			unless the player yes-consents:
				say "[ok-rand]." instead;
			say "[ok-rand].";
		if number of sortof-won logic-games is 0:
			guy-all-done;
			reject the player's command;
		now noun is random-open-game;
		say "(picking [noun])[paragraph break]";
		the rule succeeds;
	if player is in chipper wood and chase paper is in chipper wood:
		now noun is chase paper;
		continue the action;
	now noun is Alec Smart;

to decide which thing is random-open-game:
	repeat with X running through logic-games:
		d "[X] [times-won of X]/[max-won of X] [if X is never-won]never[end if] [if x is sortof-won]sortof[end if].";
	if number of never-won logic-games > 0:
		decide on a random never-won logic-game;
	if number of sortof-won logic-games > 0:
		decide on a random sortof-won logic-game;
	guy-all-done;
	decide on nothing;

to guy-all-done:
	say "You scrunch your eyes. You've already played and won everything.[paragraph break]'Bored? Me too! How [']bout that?' snarks Guy.";

definition: a logic-game (called myg) is never-won:
	if times-won of myg is 0, decide yes;
	decide no;

definition: a logic-game (called myg) is sortof-won:
	if times-won of myg is max-won of myg, decide no;
	decide yes;

[	repeat through table of logic game wins:
		if the-game entry is not tried:
			say "([the the-game entry], why not)[line break]";
			now noun is the-game entry;
			the rule succeeds;
	repeat through table of logic game wins:
		if the-game entry is not defeated:
			say "([the the-game entry], why not)[line break]";
			now noun is the-game entry;
			the rule succeeds;]

carry out playing a logic-game:
	set the pronoun it to noun;
	set the pronoun them to noun;
	unless guy sweet is part-talked or guy sweet is babbled-out:
		say "'What? You gonna just play this game without chatting a bit first?'" instead;
	repeat through table of logic game wins:
		if noun is the-game entry and num-wins entry is times-won of noun:
			say "[quote entry][paragraph break]";
			now the-game entry is tried;
			if gesture token is off-stage:
				now player has gesture token;
				say "'Oh, hey, and here's a little something to recognize you've got, llike, [activation of power games].'[paragraph break]You turn it over after he hands it to you. Each side looks deliberately counterfeited.[paragraph break]'Buck up, bucko! Show some [g-c]! That's a gen-u-ine gesture token! They're pretty rare. At any rate, I bet YOU'VE never seen one.'";
			unless max-won of noun is times-won of noun:
				increment times-won of noun;
				increment your-game-wins;
				check-win-chat;
			the rule succeeds;
	say "This is a bug. You've played out [noun]. Let me know at [my-repo] or [email].";
	the rule succeeds.

to check-win-chat:
	repeat through table of win chat:
		if your-game-wins is win-check entry:
			if achieved entry is false:
				now achieved entry is true;
				say "Guy pauses to count on his fingers a bit. [guy-banter entry][paragraph break]";
				continue the action;

table of win chat
win-check	achieved	guy-banter
3	false	"'Oh, yeah, hey, if you were expecting a new gift, I heard these puzzles are their own reward for, uh, you people. What?! C'mon, now. You'll need thicker skin than that to get to the [bad-guy] through Broke Flat over there.'"
6	false	"'Wow. You have, like, aptitude or something. You're gonna go far in life. Well, unless you use your smarts or memory on silly games like these. Or use [']em to put off bigger challenges. Like in Broke Flat over there.'"
10	false	"'All these wins are most impressive! I'm sure your skills will come in handy in a technical field. Not enough to be a high-level manager, but yeah. Boy. You need the [bad-guy]'s snark even more. If a brain like yours fell into [bad-guy-2]'s clutches...'"
15	false	"'Hey, you've shown some heavy-duty smarts, I guess! Uh, yeah, I'm totally yawning because my brain is tired, not because I am.'"
99	false	"'Gee. That's the end. Impressive. If you had the social skills to match, why, it'd be YOU defending us against [bad-guy-2], not the [bad-guy].'"

does the player mean playing Cute Percy: it is likely.

carry out playing:
	if noun is nothing and player is in smart street:
		say "There are no games left to play." instead;
	if noun is rattle:
		say "Rattle, rattle.";
		if number of visible people > 0:
			let Q be a random visible person in location of player;
			say "[Q] looks up, distracted and annoyed.";
		the rule succeeds;
	if noun is story fish:
		try talking to story fish instead;
	if noun is torch:
		say "It is cranking out music nicely on its own. Ok, the music isn't so nice." instead;
	if noun is Cute Percy or noun is chase paper:
		try entering chase paper instead;
	if noun is Guy Sweet:
		say "Why not play one of his games instead?" instead;
	if noun is Alec Smart:
		say "You are trying to figure how NOT to play yourself." instead;
	if noun is a person:
		say "You don't have the guile to play other people for suckers. You're not sure you want to." instead;
	if noun is language machine:
		say "Writing is no game. And the machine doesn't seem equipped for games. Even semantic ones." instead;
	if noun is insanity terminal:
		say "It's more a technical console than a gaming console." instead;
	if noun is notes crib:
		say "You're not particularly musical or fatherly, so you can't play with the notes crib." instead;
	if noun is idol:
		say "Maybe you can. But you'll have to figure how." instead;
	say "You can only really play something that's explicitly a game.";
	if player is in smart street:
		say "[line break]";
		if number of sortof-won logic-games is 0:
			say "You look for any game to play, but--you've solved them all, several different ways." instead;
		say "Play a random game?";
		if the player yes-consents:
			try playing random-open-game;
		else:
			say "OK.";
	do nothing instead;

part A Round Lounge

There is a room called A Round Lounge. Round Lounge is in Beginning. A Round Lounge is inside of Smart Street. "Well, this is about as dumpy as you'd expect, for a place in Broke Flat.[paragraph break]There's just one piece of furniture here: [if person chair is not examined]a chair helpfully labelled PERSON CHAIR[else]the person chair[end if][if player is on chair] (which you're on)[end if] and [if plan hatch is not examined]a hatch above that appears to be written on[else]the plan hatch above[end if]."

after printing the locale description for Round Lounge when Round Lounge is unvisited:
	say "Well, this looks like a more practical brain teaser than in Smart Street. You're reminded of how in Boy Scouts, the older kids gave you brain teasers with a pool of water by a bleeding man or a man hanged from the ceiling. You looked up more at the library that weekend and then quit the troop after the next round of teasers, because you realized you failed to learn anything practical in Scouts."

check going inside in Round Lounge:
	say "It's more up that you need to go to get out." instead;

chapter person chair

the person chair is scenery in Round Lounge. the person chair is a supporter. "It's plain but sturdy[if player is on person chair] enough to hold your weight[end if], emblazoned with PERSON, probably to say it can only hold one. Not that there's another person around.".

after examining person chair for the first time:
	say "It's not an [activation of charity], but it still feels like someone gave it to you.";
	continue the action;

does the player mean entering the person chair: it is very likely.
does the player mean climbing the person chair: it is very likely.

to say move-the-chair:
	if player is on chair:
		say "Bad idea while you're on it";
	else:
		say "[one of]You consider where you could move it to, but then you look up and see it's under the hatch, which looks like the only way out[or]No, the chair should be under the hatch[stopping]"

check pushing chair:
	say "[move-the-chair]." instead;

check pulling chair:
	say "[move-the-chair]." instead;

check entering the person chair:
	if player is on the chair:
		say "You already are on the chair." instead;
	move the player to the person chair, without printing a room description;
	say "You stand on the chair." instead;

the plan hatch is scenery in Round Lounge. "It's directly above the chair. Written on the [one of][or]plan [stopping]hatch, you see: PLAN: FIND A WAY OUT OF THE ROUND LOUNGE. [hatch-far], but it's slightly ajar."

understand "hatch plan" as a mistake ("It won't just happen like that. You need to find a way to get up through the plan hatch.") when player is in round lounge.

the writing is part of the plan hatch. description is "PLAN: FIND A WAY OUT OF THE ROUND LOUNGE."

instead of doing something with writing:
	if action is undrastic:
		continue the action;
	say "You can't do much besides examining the writing, so let's do that.";
	try examining the writing instead;

hatch-known is a truth state that varies.

after examining hatch:
	name-hatch;
	continue the action;

to name-hatch:
	if hatch-known is false:
		say "I guess you could call it a plan hatch. Well, I'm going to, anyway.";
		now hatch-known is true;

after examining writing:
	name-hatch;
	continue the action;

to say hatch-far:
	say "The hatch is [if player is on chair]just barely[else]way[end if] too far away to grab with your hands";

check taking the hatch:
	say "[hatch-far]." instead;

check pulling the hatch:
	if player has screw or player has stick or player has tee:
		try attacking hatch instead;
	say "[hatch-far] with your hands." instead;

check pushing the hatch:
	if player has screw or player has stick or player has tee:
		try attacking hatch instead;
	say "[hatch-far] with your hands." instead;

check going outside in Round Lounge:
	say "The only real way out is the hatch above. I mean, even if you could find a way out through the walls, you'd have to put up with Guy Sweet again." instead;

for writing a paragraph about a thing (called rou) in A Round Lounge:
	say "[unless round screw is in Round Lounge]A round stick still lies here[else unless round stick is in Round Lounge]A round screw, almost as large as the stick you're carrying, still lies here[else]A round stick and a round screw, which is about the same size as the stick, lie here[end if].";
	now round stick is mentioned;
	now round screw is mentioned;

check going nowhere in A Round Lounge:
	if noun is up:
		say "You look up at the hatch. [hatch-far][if player is not on chair], especially here on the ground[end if]." instead;
	if noun is down:
		if player is on chair:
			try exiting instead;
		say "You're already down enough." instead;
	say "Even if you had your bearings, each (planar) direction would lead into a wall." instead;

check exiting when player is on person chair:
	say "You jump off.";
	move player to round lounge, without printing a room description;
	the rule succeeds;

to make-tee:
	say "You twist the round screw into the hole in the round stick. The result is a slightly asymmetrical T. Yes, you could call it an off tee. In fact, it's best to think of it that way from now on, and not as the screw and/or stick it was.";
	now stick is in lalaland;
	now screw is in lalaland;
	it-take off tee;

section round stick

a round stick is a thing in A Round Lounge. description is "Almost perfectly round, a narrow thin cylinder. It's got a hole in it, just off center."

The hole is part of the round stick. description is "It's engraved helically. Hm, now what could you put in it?"

instead of doing something with hole:
	if action is procedural:
		continue the action;
	say "Really, there's nothing to do except to put something in the hole."

section round screw

a round screw is a thing in A Round Lounge. description is "It's absurdly large for a screw, about the same width and length as the round stick."

section off tee

the off tee is a thing. description is "It's almost, but not quite a T, and it's made up of the stick and screw you saw."

understand "stick/screw/t" as tee when player has tee

check opening tee:
	try attacking tee instead;

chapter hatch

check attacking the hatch:
	if player is on the chair:
		if player has the screw or player has the stick:
			say "Wham! So close! You take a whack with the [screw-or-stick] but just miss. If only it were extended a bit." instead;
		if player has off tee:
			say "Wham! You swing at the hatch with your off tee. It catches just between the hatch and the ceiling. The hatch hinges down, and a fold-out ladder falls out from it. Which is handy, but unfortunately, it's also handsy, so you sort of have to drop the off-tee. You unscrew it, too, for the next person who might get stuck in here, before climbing up to somewhere completely different from Smart Street...";
			wfak;
			now off tee is in lalaland;
			move player to Tension Surface;
			annotize round stick;
			the rule succeeds;
		say "You swing your fist at it, but you miss by a couple feet. Maybe if you extended your reach, you could pull the hatch open." instead;
	if player has screw or player has stick:
		say "You take a good swing with your [screw-or-stick] but miss by a few feet. Hm. How to get closer?" instead;
	say "You flail ineffectually at the hatch several feet away[if player has screw or player has stick or player has tee] with your [lounge-implement]. If only you were a bit closer[end if]." instead;

check entering hatch:
	say "You'll need to open it first. I mean, it's slightly ajar, but you'll want to open it completely." instead;

check opening hatch:
	if player has screw or player has stick or player has tee:
		try attacking hatch instead;
	say "[if player is on chair]You still can't quite reach it with your hands[else]It's way too far away from the floor[end if]." instead;

to say lounge-implement:
	say "[if player has tee]tee[else if player has stick]stick[else]screw[end if]"

to say screw-and-or-stick: [unused]
	if player does not have stick:
		say "the screw";
	else if player does not have screw:
		say "the stick";
	else:
		say "the screw and the stick"

report taking when player is on person chair:
	say "It's too flat on the ground to take while you're on the chair, so you jump off for a second to pick it up.";
	try silently getting off the person chair;
	now player has the noun;
	the rule succeeds;

report taking round stick:
	say "[got-stick-screw].";
	the rule succeeds;

report taking round screw:
	say "[got-stick-screw].";
	the rule succeeds;

to say got-stick-screw:
	say "[one of]It feels light but sturdy[or]The stick and screw are easy to carry, but it'd still be nice to have a hand free, somehow[stopping]";


waited-yet is a truth state that varies.

ignore-wait is a truth state that varies.

to wfak:
	if ignore-wait is false:
		if waited-yet is false:
			ital-say "NOTE: when the prompt does not appear, it means to push any key to continue.";
			now waited-yet is true;
			wait for any key;
			say "[paragraph break]";
		else:
			wait for any key;

to say screw-or-stick:
	if player does not have screw:
		say "[stick]";
	else if player does not have stick:
		say "[screw]";
	else:
		say "[one of]screw[or]stick[at random]";

chapter sitting

sitting on is an action applying to one thing.

understand the command "sit" as something new.

Understand "sit on top of [something]" as sitting on.
Understand "sit on/in/inside [something]" as sitting on.

does the player mean sitting on the bench: it is very likely.

carry out sitting on:
	if noun is warmer bench:
		say "You figure you'll just sit, but that never works out. You feel relaxed, tired, drowsy...";
		try sleeping instead;
	if noun is a person:
		say "Inappropriate physical contact." instead;
	if noun is the person chair:
		say "You sit for a moment, and you feel further than ever away from the plan hatch." instead;
	if noun is scenery:
		say "You're feeling a bit too nervy to sit around." instead;
	if noun is fright stage:
		say "You're afraid (ha, ha) of what Uncle Dutch and Turk Young would say." instead;
	say "You can't really need to sit on anything [if down ground is visited]besides the bench[else]unless it's furniture[end if].";
	the rule succeeds.

part Tension Surface

Tension Surface is a room in beginning. it is inside of A Round Lounge. "While there's nothing here other than [if rogue arch is examined]the Rogue Arch[else]an arch[end if] [if mush is in Tension Surface]dancing sideways [end if]to the north, you're still worried the land is going to spill out over itself, or something. You can go east or west to relieve the, uh, tension. Any other way, it's crazy, but you feel like you might fall off."

after printing the locale description for Tension Surface when Tension Surface is unvisited:
	if Round Lounge is visited:
		say "Well. You start to feel good about figuring the way out of Round Lounge, then you realize that, logically, there was only one. You remember the times you heard you had no common sense, and you realize...you didn't really show THEM, whoever THEY are. 'Not enough common sense.'";
	unlock-verb "duck";
	continue the action;

t-surf is privately-named scenery in tension surface. Understand "surface" as t-surf. printed name of t-surf is "the surface". "It feels like it could burst at any minute. The longer it doesn't, the sillier you feel for worrying in the first place."

instead of doing something with t-surf:
	if action is undrastic:
		continue the action;
	say "You can't do much except examine it."

check going when player is in Tension Surface (this is the fraidy-tension rule) :
	if burden is in lalaland:
		if noun is east or noun is west:
			say "You imagine the arch laughing at you as you walk away, even though you know it's motionless now."

instead of entering rogue arch:
	try going north;

check going when player is in Tension Surface (this is the pass-arch rule) :
	if noun is inside:
		try going north instead;
	if noun is south or noun is outside or noun is down:
		say "[if mouth mush is in Tension Surface]The mouth mush makes fake chicken noises that would make even Tommy Wiseau cringe. Not that you can really run and hide, anyway.[else]Running away would just delay the inevitable--you really should try to enter the arch now.[end if]" instead;
	if noun is north:
		if player has burden and burden-signed is true:
			say "'Procedure, procedure!' mocks the mouth mush. 'You got your documentation signed, but you have to GIVE it over [i]before[r] walking in.'" instead;
		if mush is in Tension Surface:
			say "[one of]You think you've judged how the arch dances, so you can anticipate and walk in. Timing...there...WOOMP! The mush mouth opens so wide you can't jump over it. 'Oops! I need proof you NEED to get by.'[or]The mouth expands again. You're not falling in there, oh no.[stopping]" instead;
		say "You take a cautious step. That rogue arch might still bounce around...";
		wfak;
		say "Thankfully, nothing happens besides your surroundings changing from plains to water.";
		annotize flower wall;
		annotize mouth mush;
		annotize word weasel;

section mouth mush

the mouth mush is a neuter person in Tension Surface. "[if mush is examined]The mouth mush[else]Some mush[end if] burbles in front of the [r-a], conjuring up condescending facial expressions."

description of mouth mush is "It almost seems to whistle innocently as you examine it closely."

check talking to mouth mush when burden-signed is true:
	say "You don't have much to say, now you have the signed burden. Maybe just GIVE it to the mouth." instead;

to say r-a:
	say "[if rogue arch is examined]Rogue Arch[else]arch[end if]"

section Rogue Arch

the Rogue Arch is scenery in Tension Surface. "It is rectangular, maybe 6 feet wide by 9 tall. When you look, you can see a much different area beyond the arch than to the side of it. [if mush is in lalaland]It's not dancing back and forth any more.[else]It's dancing back and forth, as if daring you to try to enter. [one of]The [m-m] jabbers 'Looks interesting in there, eh? I'll need documentation to let you past! Documentation that the land beyond will help you!'[talk-back][or]The [m-m] smirks, again.[stopping]"

to say m-m:
	say "[if mouth mush is not examined]mush in front[else]mouth mush[end if]"

after doing something with the arch:
	set the pronoun it to the arch;

check talking to Rogue Arch:
	if mouth mush is in lalaland:
		say "The Arch is silent." instead;
	if conv-left of noun is 1:
		say "The arch has nothing to say, and you look down to the mush, but you've had your chat with it, too." instead;
	say "'Psst! Down here!' says the [m-m].";
	try talking to mouth mush instead;

to say talk-back:
	if mush-go is not talked-thru:
		say "[paragraph break][if mush-go is not talked-thru]Hmm. Maybe you can talk to it, back.[no line break][end if]"

litany of mouth mush is the table of arch talk.

table of quip texts (continued)
quip	quiptext
mush-go	"'Beyond is the Problems Compound. But you must prove you belong there. That you are smart enough to be worth helping, to process what you will see there.'"
mush-all	"'There's something west and east[unless Variety Garden is visited and Vision Tunnel is visited]. You should have a look[end if]. If you are resourceful, you will find what you need.'"
mush-north	"'I will need proof you really need the help of the Problems Compound. SIGNED proof.'"
mush-behind	"'More than you can imagine. Interesting people! Dynamic people! Who do not worry about which is more interesting. And if you know your place, you will not worry that they are more interesting than you.'"
mush-mb	"'He is certainly someone to know. A few moments with him and your life views will change instantly! Well, as long as you do what he says. If you manage to gain an audience with him, of course. Not that he's a tyrant, or anything. He's just right. Tough but fair. And you look like you could use both.'"
mush-bye	"'Remember, I need certification to let you by.'"

table of arch talk
prompt	response	enabled	permit
"Where can I go from here?"	mush-go	1	1
"What's there to do here?"	mush-all	0	1
"C'mon, let me north."	mush-north	0	0
"What's through the arch?"	mush-behind	0	1
"Tell me about the [bad-guy]!"	mush-mb	0	1
"Guess I'll [do-mush]."	mush-bye	3	1

to say do-mush:
	say "[if burden-signed is true]give you the proof[else if player has proof]go get the proof signed[else]go find stuff now[end if]"

after quipping when qbc_litany is table of arch talk (this is the restore asking about exiting from square rule):
	now mouth mush is examined;
	if current quip is mush-go:
		enable the mush-all quip;
		enable the mush-behind quip;
	if current quip is mush-behind:
		enable the mush-mb quip;
	if current quip is mush-bye:
		enable the mush-north quip;
		terminate the conversation;
	continue the action;

part Variety Garden

table of smackdowns
smak-quip	smak-txt
weasel-forme	"You imagine the Word Weasel saying that anything you do for it would be doing for you, because it probably knows what's good for you."
erin-bye	"No, it'd be even more embarrassing not to say anything. Come on, now, Alec."

Variety Garden is a room in Beginning. Variety Garden is west of Tension Surface. "Brush guards every way out except back east to the Tension Surface. Poor dirt in all shapes and textures lies here, but plants, not so much. If at all.[paragraph break]There's also an absence of leaves."

the gen-brush is privately-named scenery in variety garden. Understand "brush" as gen-brush. "You're not an expert on plants[plant-disc]."

to say plant-disc:
	if off brush is off-stage and off brush is off-stage and off brush is off-stage:
		say ", and you don't recognize any type of brush. Maybe if you walked in a direction closer to it, you could";
		the rule succeeds;
	say ", but you do recognize some of it";
	if off brush is in variety garden:
		say ". West-ish, off brush";
	if back brush is in variety garden:
		say ". South and southeast, back brush";
	if aside brush is in variety garden:
		say ". North and northeast, aside brush";

the off brush is scenery. "The brush is tangled so it seems to be pointed at you to back off."

the back brush is scenery. "The brush seems to wave forwards and back in a breeze you can't feel yourself."

the aside brush is scenery. "The brush seems to wave left and right in a breeze you can't feel yourself."

after doing something with back brush:
	now current-brush is back brush;
	continue the action;

after doing something with aside brush:
	now current-brush is aside brush;
	continue the action;

after doing something with off brush:
	now current-brush is off brush;
	continue the action;

current-brush is a thing that varies. current-brush is usually gen-brush.

does the player mean doing something with current-brush: it is very likely.

the absence of leaves is scenery in Variety Garden. "[bug]"

after doing something with leaves:
	set the pronoun them to leaves;

instead of doing something with the absence of leaves:
	say "It's an absence of leaves, so you can't do much with it."

the poor dirt is scenery in Variety Garden. "[bug]"

to say taste-poor:
	say "It would [activation of poor taste] enough to make you [if allow-swears is false]think[else]say[end if] a rude word"

instead of doing something with poor dirt:
	if the current action is eating:
		say "[taste-poor]." instead;
	if the current action is diging:
		continue the action;
	if weasel-grow is not talked-thru:
		choose row with response of weasel-grow in table of weasel talk;
		now enabled entry is 1;
	say "The poor dirt, though providing the main variety of the garden, isn't good for much other than digging[if dirt-dug is true], which you already did[else if pocket pick is off-stage], but you don't have a tool for that, yet[end if]."

check going in variety garden:
	if noun is up:
		continue the action;
	if noun is south or noun is southeast:
		now current-brush is back brush;
		move back brush to variety garden;
		say "[one of]You run into some brush. More precisely, you run near it but back off. 'Found the back brush, eh?' snickers the Word Weasel[or]You back up before you run into the back brush again[stopping]." instead;
	if noun is north or noun is northeast:
		now current-brush is off brush;
		move off brush to variety garden;
		say "[one of]You run into some brush. More precisely, you run near it but just don't feel up to it, as if you don't have the fight to look beyond it. 'Found the off brush, eh?' snickers the Word Weasel[or]You back up before you run into the off brush again[stopping]." instead;
	if noun is west or noun is southwest or noun is northwest: [w nw sw in]
		now current-brush is aside brush;
		move aside brush to variety garden;
		say "[one of]You run into some brush. More precisely, you get close to it but turn to the side to avoid its prickliness. You look for a way around--it's not that dense, so there should be one--but no luck. 'Found the aside brush, eh?' snickers the Word Weasel[or]You back up before you run into the aside brush again[stopping]." instead;
	if noun is down:
		say "There's no clever place to dig and find underground." instead;

carry out going west in Tension Surface:
	if variety garden is unvisited:
		say "A small animal bounds up to you. 'Hi! I'm the Word Weasel! Now that you know my name, you're on your guard, so I won't be able to sucker you in any way. This is my Variety Garden!'[paragraph break]'There's not much...'[paragraph break]'Well, you haven't noticed the absence of leaves! It's an absence of pretty much every leaf that was! And so much poor dirt! And all the brush!'";

chapter word weasel

the Word Weasel is a neuter person in Variety Garden. description is "The Word Weasel has a 'so untrustworthy it's trustworthy' look on its face[one of]. It looks pretty much like the weasels you imagined from those Brian Jacques books. The ones you got pinged for reading two years ago, and you still haven't read the last few[or][stopping].". "The Word Weasel smirks about here."

after doing something with weasel:
	set the pronoun him to weasel;
	set the pronoun her to weasel;
	continue the action;

check talking to weasel when burden-signed is true:
	say "It doesn't seem to want to talk any more, and come to think of it, neither do you, really. It's time to get a move on." instead;

after doing something with the weasel:
	set the pronoun it to the weasel;

the litany of Word Weasel is the table of weasel talk.

table of ww - weasel talk
prompt	response	enabled	permit
"Hi! What are you here for?"	weasel-hi	1	1
"What can you do for me?"	weasel-forme	1	0
"What can I do for you?"	weasel-foryou	1	1
"How can I get past the mush?"	weasel-arch	1	1
"How can I [b]deserve[r] to get past the mush?"	weasel-arch-2	0	1
"Could you, uh, sign this proof of burden for me?"	weasel-sign	0	1
"So, why are you the Word Weasel?"	weasel-why	1	1
"What do you hope to grow in the poor dirt, anyway?"	weasel-grow	0	1
"Tell me more!"	weasel-more	0	0
"What about the [bad-guy]?"	weasel-baiter	1	1
"Freak Control?"	weasel-freak	0	1
"Hey, sorry about the pocket pick that broke."	weasel-pick-oops	0	1
"Your stupid pocket pick you made me work for broke."	weasel-pick-hey	0	0
"[later-or-thanks]."	weasel-bye	3	1

after quipping when qbc_litany is table of weasel talk:
	if current quip is weasel-arch:
		enable the weasel-arch-2 quip;
	if current quip is weasel-more:
		enable the weasel-why quip;
	if current quip is weasel-why:
		enable the weasel-baiter quip;
	if current quip is weasel-baiter:
		say "'You have to admit, he's pretty impressive, eh? No essays, just yes or no.'";
		if the player yes-consents:
			say "'You're just buttering me up to get a favor, aren't you?'";
		else:
			say "'You're just being negative to pretend you won't butter me up to get a favor, aren't you? That's still buttering me up.'";
		say "[line break]";
		enable the weasel-freak quip;
	if current quip is weasel-sign and burden-signed is false:
		enable the weasel-sign quip;
	if current quip is weasel-bye:
		terminate the conversation;

table of quip texts (continued)
quip	quiptext
weasel-hi	"'Here to weed out people who don't belong. Ah, good, you didn't laugh at the weed/garden pun. There's hope for you yet! But I just have so much to say--you will listen to it all before asking anything of me, won't you?'"
weasel-foryou	"'Of course, you're really asking what I can do for you. Well, I like to trade, a bit. No need for chit-chat. Just GIVE me whatever. I have a tool you can use.'"
weasel-forme	--
weasel-arch	"'That's...a bit direct, isn't it? Just going from point A to point B, no worry about self improvement.'"
weasel-arch-2	"'That's...a bit circumspect, isn't it? Throwing in a few fancy words to seem like you care. Oh, all right. I'll sponsor you. Not with money. Just a reference or something.'"
weasel-sign	"'I could, but you'd have to GIVE it to me first.' It smirks."
weasel-grow	"'I dunno. A muffin meadow, maybe?'"
weasel-why	"'It's not because I twist words. Oh, no! Well, I do, but I twist them to EXPAND the English language. Plus it shows a deal of self-knowledge to let myself be called that. Yes? Yes. Good.' It laughs hard, and you laugh a bit, and it says that just proves how much less well-adjusted you are."
weasel-more	--
weasel-pick-hey	--
weasel-freak	"'Yup. It's way in the north. It's guarded well. It has to be. [bg]'s all for equality, but that doesn't mean everyone deserves to bask in [bg]'s cleverness equally.'"
weasel-baiter	"'Well, if everyone's praising him, that's because he really is great. It can't be hero worship, because he gave the BEST lecture against that. He's just so...well, even when he cuts you down, he's just so full of truth and interestingness. It's obvious, by the energy he puts in to cut people down, how thoughtful he is. No 'everyone is nice' dribble. He doesn't leave Freak Control to spread his wisdom very often.'"
weasel-pick-oops	"'Good thing I didn't charge you a deposit, eh?'"
weasel-bye	"'Gosh! You're lucky I didn't charge you for all this cleverness!'"

check going east when player is in variety garden:
	if dirt-dug is false:
		if player has pocket pick:
			say "'This isn't [activation of dirt nap], here. It won't DIG itself while you're gone.'" instead;
		else:
			say "'Well, let me know when you're ready to do business.'";

section pocket pick

the pocket pick is a thing. description is "You can DIG something with it."

after printing the name of the pocket pick while taking inventory:
	say " (DIG with it)";
	continue the action;

part Vision Tunnel

Vision Tunnel is east of Tension Surface. Vision Tunnel is in Beginning. "The flower wall blocking every which way but west is, well, a vision[if flower wall is examined], and now that you've seen the picture hole in it, you can't un-see it[end if][if earth of salt is in vision tunnel]. Some semi-crystallized looking earth is clumped here[end if]."

the flower wall is scenery in the Vision Tunnel. "All manner of flowers, real and fake, are sewed together. The only break is [if flower wall is examined]that picture hole[else][pic-hole][end if]."

after doing something with flower wall:
	set the pronoun them to flower wall;

to say pic-hole:
	say "[if picture hole is examined]the picture hole you looked through[else]a small hole, call it a picture hole, because it looks like there's some sort of picture in there[end if]"

check taking flower wall:
	say "The flowers seem delicately interconnected. If you take one, you fear the whole structure might collapse. Then you might feel more lonely than ever." instead;

understand "flowers" as flower wall.

check going nowhere in vision tunnel:
	say "You barge into the flower wall and feel less alone with all that nature around you. This isn't practical, but it feels much nicer than running into walls has a right to." instead;

the picture hole is scenery in vision tunnel. description is "[one of]You peek into the picture hole in the flower wall, and it looks like a bunch of swirls until you stare at it right. A whole story takes shape. [or][stopping]You recognize [one of]a stick figure[or]yourself, again[stopping] finding a ticket in a book, climbing a chair to reach a hatch, digging by a bunch of flowers, depositing a document in the ground--and then being blocked by three stick figures--blue, red and tall.[paragraph break][one of]You blink, and the picture degenerates back into swirls. But you can always look again, if you want[or]The picture scrambles again once you blink[stopping]."

understand "vision" as picture hole when player is in Vision Tunnel and flower wall is examined.

understand "vision" as flower wall when player is in Vision Tunnel and flower wall is not examined.

the earth of salt is scenery in Vision Tunnel. "It's opaque, probably earth of salt or something, and it seems half-buried. You think if you look closely you see something under it that's not dirt or salt. But you can't just move it away by conventional means."

check taking earth of salt:
	say "It's just too big of a slab to pick up. Maybe if it were broken into bits, you could see what was under it." instead;

check pushing earth of salt:
	say "You can't get a good grip on it--it's probably buried into the ground a bit too much." instead;

the proof of burden is a thing. "The plaque that is the Proof of Burden lies here."

after printing the name of the proof of burden while taking inventory:
	if proof of burden is examined:
		say " ([if burden-signed is false]un[end if]signed)";
	else:
		say " (which you should probably read[if burden-signed is true], even though you read it[end if])";

understand "plaque/document" as proof of burden when mrlp is Beginning.

burden-signed is a truth state that varies.

description of proof of burden is "The bearer of this plaque is certifiably unable to brush aside problems he feels he really should be smart enough to, and he quite bluntly has no clue how to rectify the situation. I mean, we all feel this way from time to time, but boy, the bearer got an extra dose. He certainly could use an audience with the [bad-guy], whether he deserves it or not.[paragraph break]Of course, he's not just going to be allowed to walk in. Goodness no! This will just get him one step closer. Plus the journey is the important thing, and so on.[paragraph break]There's a line below: SIGNED BY APPROPRIATE AUTHORITY (BEARER DOES NOT COUNT). It is [if burden-signed is true]filled[else]blank[end if]."

after taking proof of burden:
	choose row with response of weasel-baiter in table of weasel talk;
	now permit entry is 1;
	continue the action;

book Outer Bounds

Outer Bounds is a region.

part Pressure Pier

Pressure Pier is north of Tension Surface. It is in Outer Bounds. "[one of]So, this is Pressure Pier. Off south is water--no way back to the Tension Surface[or]Water south, passage north[stopping]. You smell food to the west, and the land sinks a bit to the east. [one of]A side stand grabs your attention enough you notice it holds a book with the words BASHER on the front[or]The Basher Bible still rests on a side stand[stopping]."

a side stand is scenery in Pressure Pier. "It's not actually blocking any direction to go in, but it's gaudy and shiny enough you won't be overlooking it. It's not really [activation of palatable]."

instead of taking side stand:
	say "You couldn't [activation of take a stand]. A take? Either way, you've got enough of a trial without lugging something like that around."

pier-visited is a truth state that varies.

 after printing the locale description for Pressure Pier when Pressure Pier is unvisited:
	now pier-visited is true; [not the best way to do things but I need to reference something in I6 to modify the play-end text, and it's just cleaner for my i6-illiterate self to define a boolean in I7]
	unlock-verb "knock";
	set the pronoun it to basher bible;

check going in Pressure Pier:
	if noun is outside or noun is south:
		say "Swimming seems inadvisable. The water goes on a ways." instead;
	if noun is inside:
		try going west instead;
	if room noun of Pressure Pier is nowhere:
		say "You consider going that way, but you'd feel embarrassed walking into a wall or whatever, with or without people watching." instead;
	if noun is north and pressure pier is unvisited:
		say "Up ahead is ... well, you're not sure what sort of terrain it is. Not quite a swamp. You squint a bit, and the ridges landscape seems to spell out F-E-N. So it's definitely a nominal fen. You blink, embarrassed you're not 100% sure what a three-letter word like fen means, and then you can't see the ridges any more.";
		say "[line break]";
		wfak;

water-scen is privately-named scenery in Pressure Pier. "You notice the [activation of fish out of water]. It stretches quite a ways."

understand "water" as water-scen when player is in Pressure Pier.

understand "swim" and "swim [text]" as a mistake("You're not a terrible swimmer, but you also remember hearing about undertows and that sort of thing. You'd hate to die like that.")

stall-scen is privately-named scenery in Pressure Pier. "It's a pretty large stall. But you won't be able to see what's in it [']til you go west."

instead of doing something with stall-scen:
	if action is procedural:
		continue the action;
	if current action is entering:
		try going west instead;
	say "You can probably just go west to enter Meal Square."

understand "stall" as stall-scen when player is in Pressure Pier.

instead of doing something with water-scen:
	if action is procedural:
		continue the action;
	say "The water goes on a ways."

the Basher Bible is scenery in Pressure Pier. "[one of]The Basher Bible labels seemingly contradictory things to want and to be: to be clever enough to cut down too-clever weirdos. To have enough interests you can almost empathize with obsessed nerds, but not quite. To know enough pop culture you can poke fun at people who care too much about it. To be nice enough adults are sure you'll go far, but not be some useless dweeb.[paragraph break]There's also something about how if you don't know how to balance those things and have to ask others, or if this triggers some oversensitivity, well, REALLY. And there's even a tip of the moment! You read it:[or]You read another passage from the Basher Bible: [stopping]"

check taking Basher Bible:
	say "That'd mean trouble if it's a [activation of bible belt], too." instead;

understand "belt bible" as a mistake ("The Baiter Master's personality cult is probably about how he does this sort of thing louder and more exciting than you, so, no.") when player is in Pressure Pier.

understand "spoons" and "spoons table" as spoon table.

bible-row is a number that varies. bible-row is usually 0.

bible-cycled is a truth state that varies. bible-cycled is usually false.

after examining basher bible:
	increment bible-row;
	if bible-row > number of rows in table of Bible references:
		now bible-row is 1;
		now bible-cycled is true;
	choose row bible-row in the table of Bible references;
	say "[italic type][reference-blurb entry][line break]";
	if bible-row is number of rows in table of Bible references:
		say "[r][line break]LAST HINT. You'd better have learned something, but remember, you can push around people who don't matter by saying they aren't persistent enough or they are a bit obsessed. Often within five minutes of each other. Because it's important to see both sides.";
	else if bible-row is 1 and bible-cycled is false:
		say "[line break][r]Of course, just internalizing this tip won't make you quite the guy the [bad-guy] is. Everyone can be right about some random thing. You need a variety of moves. To be a complete person!";
	else:
		say "[r]";
	unless accel-ending:
		if bible-cycled is false and bible-row is a looknum listed in table of Bible reflections:
			choose row with looknum of bible-row in table of Bible reflections;
			say "[line break][reflection entry][line break]";

after examining Basher Bible when accel-ending:
	if cookie-eaten is true:
		say "Well, DUH. It seems so obvious now you've eaten the cookie.";
	else if greater-eaten is true:
		say "Yyyuuuppp. It's easy to see why that works, now, and anyone who can't put in the effort to do that...the heck with [']em.";
	else:
		say "Geez. You don't want to have to put up with that any more. I mean, you'll probably have to do a [i]few[r] things like that, just to survive. Anyway, you'll be more forceful telling people to expletive off in the future, though. That should help.";
	continue the action;

instead of doing something with spoon table:
	if action is procedural:
		continue the action;
	if current action is taking:
		say "The spoons are dug in, and they're stuck together. You table the idea." instead;
	if current action is attacking:
		say "The table is too sturdy." instead;
	say "It's mostly there for holding up the Basher Bible."

instead of doing something with Basher Bible:
	if action is procedural:
		continue the action;
	if current action is taking:
		say "It's more or less impossible to take, both physically (its cover is woven or glued to the spoons) and emotionally." instead;
	if current action is attacking:
		say "[if accel-ending]No. Attacking it won't destroy its philosophy, or help you learn it better[else]It sort of makes you want to lash out, but somehow it makes you feel guilty for WANTING to attack it[end if]." instead;
	say "It's mostly there for looking at and absorbing its philosophy, whatever that may be."

section Terry Sally

Terry Sally is a person in Pressure Pier. "[one of]A smiling fellow walks up to you and shakes your hand. 'I'm Terry Sally! The official [activation of boy howdy]! Here to introduce new people to the Problems Compound! Smart or dumb, social or lame, well, someone needs to! But we don't let just anyone through to the Nominal Fen.' You shake hands, equally afraid you were too hard or soft. His enthusiasm quickly tails off, leaving you feeling it was your fault.[or]Terry Sally stands here, [if player has trail paper]and on seeing your trail paper, snaps his fingers and makes a 'gimme' gesture[else]looking disinterested now he's greeted you[end if].[stopping]"

description of Terry Sally is "Brightly dressed, smiling a bit too wide."

check talking to Terry Sally:
	if trail paper is in lalaland:
		say "'You don't need anyone to greet you any more. [if Nominal Fen is unvisited]Go on! See what's north[else]You've already visited what's beyond[end if][if meal square is not visited]. Oh, and check out to the west, too[end if].'" instead;

the litany of Terry Sally is table of Terry Sally talk.

table of ts - Terry Sally talk
prompt	response	enabled	permit
"So, um. Hi. I mean Howdy. Or heya."	terry-howdy	1	1
"Boy howdy! This sure is an interesting place!"	terry-boy	0	0
"For such an interesting guy, you sure have nothing better to do than stand here and block people going north."	terry-int	0	0
"Can you let me north? Please?"	terry-north	0	1
"So. What's fun to do here?"	terry-fun	1	1
"What's to the west?"	terry-west	1	1
"Tell me about the [bad-guy]."	terry-baiter	1	1
"[later-or-thanks]."	terry-bye	3	1

table of quip texts (continued)
quip	quiptext
terry-howdy	"'Um...yeah. I've heard that one. If you knew that, you shouldn't have said howdy, and if you didn't, that's kinda clueless. Anyway.'"
terry-boy	--
terry-int	--
terry-fun	"'Well, there's solving boring puzzles. But that's a bit too square. No offense, but that's probably how you wound up here. What if you--well, bend the rules a bit? Nothing too stupid, but annoy authority. Convince me--and yourself, of course--you're not just some boring square.'"
terry-ways	"'Well, there's public laziness. Annoying other bar patrons. Possession of alcohol. Littering and/or obfuscating your own transgressions record.'"
terry-north	"'Well, it gets a bit seedier there. Rougher. I'm sure you're nice and all, even if you're not actually nice TO anyone, but it might be better not to be totally nice. Tell you what. You find me a trail paper, I let you by. It's made up of--oh, what do you call em? For not being a total kiss-up? Anyway, don't do anything too dumb. But you'll want to annoy authorities a bit.'"
terry-west	"'Meal Square. Some odd foods there. Some of [']em scare me a bit. But you might like [']em.'"
terry-baiter	"'I'm sure he'd like to welcome you individually, but he's just too busy fending off [bad-guy-2]. And thinking up his own philosophies. And making sure nobody weirds out too much, from his big observation room in Freak Control. So he delegates the greeting to me, while making sure nobody acts out the wrong way. Don't get me wrong. He's a geek/dork/nerd and loves the rest of us. Just, those who give it a bad name...'"
terry-bye	"'Later. Be good. But not too good. That's just boring.'"

before talking to Terry Sally when player has trail paper:
	if player has trail paper and player is in pressure pier:
		say "Wait a minute! You've got the trail paper! Enough chit-chat!";
		terminate the conversation;
		try giving trail paper to Terry Sally instead;

after quipping when qbc_litany is table of Terry Sally talk:
	if current quip is terry-howdy:
		enable the terry-boy quip;
		enable the terry-int quip;
	if current quip is terry-ways:
		now litter-clue is true;
	if current quip is terry-north:
		enable the terry-fun quip;
	if current quip is terry-fun:
		enable the terry-ways quip;
	if current quip is terry-bye:
		terminate the conversation;

to superable (q - a quip):
	choose row with response of q in qbc_litany;
	now enabled entry is 2;

check going north in Pressure Pier:
	if Terry Sally is in lalaland:
		continue the action;
	if trail paper is in lalaland:
		say "Terry Sally gestures you through. 'Well, you did okay, I guess. Go have fun, or your idea of it[if meal square is not visited]. Oh, and maybe stop off west Meal Square, if you want[end if].'";
		continue the action;
	if player has trail paper:
		say "Terry Sally snaps his fingers and points at your trail paper.";
		try giving trail paper to Terry Sally;
		if trail paper is in lalaland:
			continue the action;
		the rule succeeds;
	choose row with response of terry-north in table of Terry Sally talk;
	now enabled entry is 2;
	if terry-howdy is not talked-thru:
		say "Terry Sally bars you with his arm. He's not bigger than you, but he is louder. 'Hey! Whoah! I took the time to greet you, and you're going to bull right on through? Nope!'" instead;
	say "'Nope. Not yet. Yay for showing initiative, but I need a bit more evidence you're not all goody-goody.'" instead;

section trail paper

the trail paper is a thing. description is "It looks pretty official. It's made up of the four boo ticketies, but now they're folded right, it may be just what Terry Sally wanted."

part Meal Square

check going west in pressure pier:
	if trail paper is in lalaland:
		do nothing;
	otherwise:
		if meal square is unvisited:
			now thought for food is in lalaland;
			say "Terry Sally coughs. 'That's Meal Square. Nice if you've got a [activation of food for thought]. Not just some [activation of hallway], but nothing crazy. So the [bad-guy] got rid of that [activation of impaler], the [activation of gobbling down].'";

Meal Square is west of Pressure Pier. Meal Square is in Outer Bounds. "This is a small alcove with Pressure Pier back east. You would call it an [activation of caveat], but ...[paragraph breka]There's not much decoration except a picture of a dozen bakers."

after printing the locale description for meal square when meal square is unvisited:
	if allow-swears is true:
		say "There's nothing to drink here, but then again, you'd be a bit worried if you saw a [activation of potty].";
	continue the action;

the spoon table is scenery in Meal Square. "Many kinds of spoon: greasy, tea, wooden and silver, and that thick one must be a fed spoon. They are welded together to form a table one person can eat at, well--with a few holes. It's large but also largely decorative."

Tray A is a supporter in Meal Square. description is "It's a [activation of trefoil], but it's circular-shaped--[word-things of tray a] different unusual foods rest on tray A[if condition mint is on tray a]. Well, the condition mint isn't food, but it's the one you'd feel leasy guilty sneaking[end if]."

Tray B is a supporter in Meal Square. description is "[if accel-ending]You still see [word-things of tray b] foods on Tray B, but you're pretty full[else]You're both scared and intrigued by Tray B, which reads, in large print, [activation of defeat]. You see [word-things of tray b] bizarre looking foods on it, labeled: [a list of things on tray b][end if]."

to say word-things of (q - a supporter):
	let q1 be number of things on q;
	say "[q1 in words]"

examining tray b is pielooking. examining tray a is pielooking.

after pielooking:
	if tray a is examined and tray b is examined and apple pie order is not in lalaland:
		say "Wow, that's a lot of food! You won't even need to [activation of apple pie order] as dessert.";
	continue the action;

outpigging is an action applying to two things.

understand "eat [things]" as outpigging when player is in meal square.

Definition: a thing is matched if it is listed in the multiple object list.

carry out outpigging:
	let L be the list of matched things;
	if number of entries in L > 1:
		say "[pig-out].";
		the rule succeeds;
	try eating a random matched thing instead;

rule for deciding whether all includes a thing when eating:
	if player is in meal square:
		if noun is on tray a or noun is on tray b, decide yes;
		decide no;
	decide yes;

to say pig-out:
	say "A booming voice yells, '[activation of pig out]!' Looks like you should concentrate on one food or tray at a time"

This is the pig rule:
	if the number of entries in the multiple object list is greater than 1:
		let q be entry 1 of the multiple object list;
		if q is tray a or q is tray b or q is on tray a or q is on tray b: [this could be better, but it does the job]
			say "[pig-out].";
			stop the action.

The pig rule is listed before the generate action rule in the turn sequence rules.

does the player mean doing something with tray a: it is likely.

the examine supporters rule is not listed in any rulebook.

check examining a supporter when accel-ending:
	say "You've already seen the food there and made your choice." instead;

check taking when player is in Meal Square and accel-ending:
	say "Ug. You're full. Move on." instead;

check eating when player is in Meal Square and accel-ending:
	say "Ug. You're full. Move on." instead;

check going nowhere in meal square:
	if noun is outside:
		try going east instead;
	say "No way out except east. There's no hidden [activation of arch deluxe] leading to truly glorious foods, either, but then again, it might be a trap leading to a [activation of quarter pounder] anyway." instead;

the picture of a dozen bakers is scenery in Meal Square. "It's a weird optical illusion--sometimes you count twelve, but if you look right, they warp a bit, and there's one extra. What's up with that?"

after doing something with bakers:
	set the pronoun them to bakers;

instead of doing something with bakers:
	if action is undrastic:
		continue the action;
	say "It's just there for scenery. There's nothing behind it or whatever. Though, looking at it some more, you kind of get it in the cosmic sense."

chapter fast food menu

[fast food? Get it? It gets you through the game fast! Ha ha!]

a badfood is a kind of thing. a badfood is usually edible.

check taking a badfood:
	try eating noun instead;

to decide which thing is yourfood:
	repeat with X running through badfoods:
		if X is in lalaland:
			decide on X;
	decide on Alec Smart;

to decide whether accel-ending:
	if greater-eaten is true or off-eaten is true or cookie-eaten is true or brownie-eaten is true, decide yes;
	decide no;

carry out looking when accel-ending (this is the alec sees the world differently rule) :
	say "[b][location of player][r][line break]";
	if player is in freak control:
		say "The [bad-guy] stands here, with his back to you. Trying to ignore you. Focusing on his machines. But you've got something important to say.[paragraph break]";
	if location of player is not cheat-surveyed:
		deal-with-loc;
	else if player is in Meal Square:
		say "Back out east now. Time to see the [bad-guy].";
	else if player is in pressure pier:
		say "With Terry Sally out of the way, you can go north. You could go back south, east, or west, but really, that [bad-eaten] focused you on what's important.";
	else if player is in nominal fen:
		say "The [j-co] aren't hanging around any more, and you don't want to be, either. Not sideways, or back, but north's where it is, with the [bad-guy].";
	else if player is in speaking plain:
		say "Well, Uncle Dutch and Turk Young had something to say, but you have something to say to the [bad-guy]. That means no going back south, or east, or west. Just north.";
	else if player is in questions field:
		say "The Brothers are dispatched. Your way north is free!";
	else:
		say "You're sort of forced north, here.";
	the rule succeeds;

to say b-food:
	say "[if off-eaten is true]off cheese[else if greater-eaten is true]greater cheese[else if cookie-eaten is true]cutter cookie[else]points brownie[end if]"

before going when accel-ending:
	if player is in meal square:
		if noun is east or noun is outside:
			say "[if brownie-eaten is true]You go in search of people to make happy[else]The heck with this dump[end if].";
			continue the action;
		else:
			say "You do feel like [if off-eaten is true]banging[else if greater-eaten is true]busting through[else if brownie-eaten is true]not flowering[else]bouncing off[end if] the walls now you've eaten the [b-food], but not literally. But when you get bored, there's back east." instead;
	if noun is north:
		say "[if off-eaten is true]Maybe up ahead will be less lame.[else if brownie-eaten is true][location of player] was nice and all but there's probably even more fun ahead![else]Time to leave [location of player] in the dust.[end if]";
		continue the action;
	if noun is south:
		if player is in pressure pier:
			if variety garden is unvisited:
				say "You don't know or care what's back there. Maybe people slower than you found out, but eh." instead;
			say "[if off-eaten is true]You can't deal with the Word Weasel and Rogue Arch again. Well, actually, you can, but it's a new quasi-fun experience to pretend you can't[else if cookie-eaten is true]You'd like to go back and win an argument with the Word Weasel, but that's small potatoes compared to showing the [bad-guy] a thing or two[else if brownie-eaten is true]You can maybe thank the Word Weasel for his help later[else]You're too good to need to kiss up to the Word Weasel again[end if]." instead;
		say "[if off-eaten is true]Go back south? Oh geez. Please, no[else if brownie-eaten is true]Nobody's left there. You'd like to meet some new people[else if greater-eaten is true]You don't GO backwards[else]Much as you'd like to revisit the site of that argument you won so quickly, you wish to move on to greater and bigger ones[end if]." instead;
	if the room noun of location of player is nowhere:
		say "Nothing that-a-way." instead;
	if the room noun of the location of player is visited:
		say "You look [noun]. Pfft. Why would you want to go back? You're more focused after having an invigorating meal." instead;
	else:
		say "[if off-eaten is true]You really don't want to get lost among whatever weird people are [noun]. You're not up to it. You just want to talk to anyone who can get you out of here.[else if brownie-eaten is true]You'd like to go [noun], but the [bad-guy] sounds like the person to meet for REAL.[else]Pfft. Nothing important enough to the [noun]! Maybe before you'd eaten, you'd have spent time wandering about, but not now. North to Freak Control![end if]" instead;

section greater cheese

greater cheese is a badfood on Tray B. description is "It looks just as icky as the off cheese. Maybe it's marbled differently or something. These things are beyond you."

greater-eaten is a truth state that varies.

check eating greater cheese:
	if off-eaten is true:
		say "Ugh! You've had enough cheese." instead;
	if cookie-eaten is true:
		say "Cookies and cheese? That's just weird." instead;
	consider the too cool for dessert rule;
	if the rule succeeded:
		continue the action;
	say "You pause a moment before eating the greater cheese. Perhaps you will not appreciate it fully, or you will appreciate it too much and become someone unrecognizable. ";
	consider the tray b eating rule;
	if the rule failed:
		the rule succeeds;
	say "You manage to appreciate the cheese and feel superior to those who don't. You have a new outlook on life! No longer will you feel [b-o]!";
	now greater cheese is in lalaland;
	bad-food-process true;
	now greater-eaten is true instead;

to say b-o:
	say "bowled over";
	now bowled over is in lalaland;

section off cheese

off cheese is a badfood on Tray B. description is "[if greater-eaten is true or cookie-eaten is true]It's really gross, and you'd have to be weird to consider eating it[else]It looks really gross but you're sure other people have better reasons why it is[end if]."

off-eaten is a truth state that varies.

check eating off cheese:
	if greater-eaten is true:
		say "You are above eating disgusting cheese. Unless it's tastefully disgusting, like what you just ate." instead;
	if cookie-eaten is true:
		say "Ugh! Now that you've eaten the cutter cookie, the off cheese looks even more gross than before. No way. You just want to leave." instead;
	consider the too cool for dessert rule;
	if the rule succeeded:
		continue the action;
	say "Hmm. It seems edible--well, eatable. You might not be the same person after eating it. ";
	consider the tray b eating rule;
	if the rule failed:
		the rule succeeds;
	say "Ugh. Bleah. It feels and tastes awful--but if you sat through this, you can sit through an awkward conversation. Not that you'll be [activation of bowled over] and cause a few. [activation of growing pains]... pain's growing...";
	now off cheese is in lalaland;
	bad-food-process true;
	now off-eaten is true instead;

section cutter cookie

a cutter cookie is a badfood on Tray B. description is "It looks like the worst sort of thing to give kids on Halloween. If it doesn't have any actual razor blades, it's pointy as a cookie should not be. It's also grey and oatmeal-y, which cookies should never be. I mean, I like oatmeal cookies, just not dingy grey ones. It seems like excellent food for if you want to be very nasty indeed."

cookie-eaten is a truth state that varies.

to say dj:
	say "[activation of just deserts]"

check eating cutter cookie:
	if brownie-eaten is true:
		say "Aw man! You're sure the cookie tastes good, but maybe leave it for the next person. You're already in a great mood. No need to get greedy." instead;
	consider the too cool for dessert rule;
	if the rule succeeded:
		continue the action;
	say "It's so sharp, it'd start you bleeding if you carried it around. Even as you pick the cookie up your thoughts turn resentful, yet you feel justified as never before. ";
	consider the tray b eating rule;
	if the rule failed:
		the rule succeeds;
	say "[line break]You have to eat it carefully, because of its spikes, but it gives you...a sharp tongue. [if allow-swears is true]And wait. Did you taste a [activation of raising hell]? [end if]Suddenly you wonder why you spent so much time feeling [b-o]. Even though there should've been, but wasn't, [activation of coffee break], you're ready to go off on pretty much anyone who's gotten in your way, or even not helped you enough. To [activation of quisling] at people you used to be like[if allow-swears is false]. You'll show those punks you don't need to swear to kick butt![else].[end if]";
	now cookie is in lalaland;
	bad-food-process true;
	now cookie-eaten is true instead;

section points brownie

a points brownie is a badfood on Tray B. description is "[if greater-eaten is true or cookie-eaten is true]The sort of chocolatey treat that fattens people with no willpower[else if off-eaten is true]A [activation of treat like dirt], the sort people used to try to bribe you with. With which they tried to bribe you. Ugh. You hate following grammar rules[else]It's not shaped like a square but rather a star. It has points[end if]."

brownie-eaten is a truth state that varies.

check eating points brownie:
	if cookie-eaten is true:
		say "If someone cooked it into such a weird shape, it probably tastes weird, too. PASS." instead;
	consider the too cool for dessert rule;
	if the rule succeeded:
		continue the action;
	say "You promise not to get on a sugar high like you did from wasting your first week's allowance. After eating it, you feel less inadequate, and willing to be even less inadequate if someone asks or hints! Oh boy!";
	consider the tray b eating rule;
	if the rule failed:
		the rule succeeds;
	say "[line break]You have to eat it carefully, because of its spikes, but it gives you...a sharp tongue. Suddenly you wonder why you spent so much time feeling [b-o]. You're ready to go off on pretty much anyone who's gotten in your way, or even not helped you enough[if allow-swears is false]. You'll show those punks you don't need to swear to kick butt![else].[end if]";
	now points brownie is in lalaland;
	bad-food-process false;
	now brownie-eaten is true instead;

section dessert rules

this is the tray b eating rule:
	say "Try eating it anyway?";
	if the player yes-consents:
		say "Your [activation of snap decision]! [activation of time consuming]!";
		the rule succeeds;
	else:
		say "It's not the [activation of spur of the moment]. Well, not yet.";
		the rule fails;

this is the too cool for dessert rule:
	if off-eaten is true:
		say "Ugh. [dj] for babies.";
		the rule succeeds;
	if greater-eaten is true:
		say "Pfft. [dj] not very refined.";
		the rule succeeds;


section general tray b eating stuff

to bad-food-process (as - a truth state):
	if as is true:
		if allow-swears is false:
			say "Then, after a bit of thinking, you realize how lame it was to be stuffy about swears. You have stuff to swear ABOUT now, see? You didn't used to have it, or any emotional depth, but now, heck yeah! (Okay, you still need some practice.) You realize Hunter Savage was just a pseudonym, and you're pretty sure the Complex Messiah had a cooler name, too.";
			now allow-swears is true;
	ital-say "This has caused an irreversible personality change in Alec. You may wish to UNDO and SAVE before trying to eat again to restore Normal Alec, even if that's not what he wants right now.";
	now player has an opener eye;
	if player has bad face:
		now bad face is in lalaland;
	if player has face of loss:
		now face of loss is in lalaland;


table of accel-text
accel-place	alt-num	accel-cookie	accel-off	accel-greater	accel-brownie
meal square	-1	"Pfft. None of the other foods look close to as good as the cookie you ate. Time to get going back east."	"Ugh. The sight of the remaining food turns your stomach. You just want to get going."	"You're sure you're meant for better things than pigging out and getting fat on food that probably doesn't taste that great, anyway."	"This is a neat place, and it'd be wonderful if there were people to eat with here, but there aren't, so maybe you just need to find people to be social to. Um, with."
pressure pier	0	"You take a moment to sneer at [if Terry Sally is in lalaland]the memory of the [end if]Terry Sally. 'Is this your JOB? Man, that's SAD. The stupid stuff you want people to do to show you they're cool? Little league stuff. I mean, thanks for the start and all, but SERIOUSLY.' He gapes, shocked, then flees before your wrath.[paragraph break]Man! You've never won an argument before. And you didn't expect to win that conclusively. Oh, wait, yes you did."	"You give an exasperated sigh. 'I'm not here because I want to be. I got suckered into it. Do you think I could...?'[paragraph break]'You know, some people don't even ASK. Or if they do, it's all unforceful. You're okay. You can go through.' [if Terry Sally is in lalaland]You blame Terry Sally for not being around to listen to your whining[else]Terry Sally bows slightly--you don't care if it's sarcastic or not--and you walk past. You turn around, but he's not there[end if]."	"[if Terry Sally is in lalaland]You're sad Terry Sally is gone. You'd be giving HIM advice, now.[else]'Oh, hey! Still here? I'm moving ahead in life!' you say to Terry Sally, who runs off in embarrassment.[end if]"	"[if Terry Sally is in lalaland]You were going to compliment him on what a good job he was doing vetting people, but dang it, he's gone[else]'Wow! You're doing a really good job of, like, guarding stuff. You totally deserve a break!'[paragraph break]'Gosh! You think so too?'[paragraph break]'Well, if the [bad-guy] does...'[paragraph break]'No, you're right. Hey, I thought you were just another of, well, them, but you're all right. More than all right. Go on through.' Terry Sally walks [where-howdy][end if]."
Nominal Fen	1	"'Hey, move it, I'm on a quest here!' They look shocked. You proceed to berate them for, is this all they ever do? Is it their purpose in life? Do they have anyone better to talk to? If so, what a waste. If not, sad.[paragraph break]Before this terrifying onslaught of hard-hitting language and lucid, back-to-basics logic, the [j-co] recognize how minor-league they are. They run off to chat or commiserate elsewhere.[paragraph break]Bam! Seven at one blow!"	"'Hey, what you all talking about?' you ask. 'Gossip, eh?' You try to join in, but--they seem a bit jealous of how good your grumbling is, and they excuse themselves."	"'Oh! Hey! You all talking about something interesting? I won't disturb you. Which way is the [bg]?' They look shocked you...USED HIS INITIALS. They point north. 'I KNOW,' you boom. They scatter."	"'Hey, guys! What's up?' you ask. They shuffle and mutter and walk away. Well, they probably had negative attitudes anyway. It feels more relaxed, now!"
lalaland	2	"Oh, boy. Looking back, you didn't need all that reasoning to get past them. You could've probably just acted a little exasperated, said you were SURE someone could help, and wham! Well, it's good to have all this space, but you need to be going north."	"You sniff at the memory of the [j-co] you helped. They weren't properly grateful, and they weren't even good at being [j-co]. Maybe you should've gone into business with the Labor Child. You'd figure how to backstab him later. Still, you learned a lot from that. Perhaps you can find ways to keep tabs on people, probe their weaknesses. Makes up for earlier memories of your own."	"You look back at the silliness and all you did to get around the [j-co] when really you could've just shown them what was what the way you are now. You're--BETTER than those logic puzzles."
speaking plain	0	"Oh geez. You can't take this. You really can't. All this obvious improvement stuff. You lash out, do they think people REALLY don't know this? Do they think hearing it again will help? Uncle Dutch and Turk Young revile you as a purveyor of negative energy. No, they won't go on with all this cynicism around. But you will be moving on soon enough. They go away for a break for a bit. Maybe more than a bit. You don't want to hang around to find out."	"'FRAUDS!!!' you yell at Uncle Dutch and Turk Young. 'ANYONE CAN SPOUT PLATITUDES!' You break it down sumpin['] sumpin['] real contrarian on them, twisting their generalities. A crowd gathers around. They applaud your snark! You yell at them that applause is all well and good, but there's DOING. They ooh and ahh further. After a brief speech about the dork you used to be, and if you can get better, anyone can, you wave away the performers, then the crowd that followed them."	"You give a pre-emptive 'Oh, I KNOW,' before Turk and Dutch can say any more. 'But you're doing a pretty good job. I mean, almost as good as I could if I weren't destined for better things. Just--take a break to hone your act. Not that it's THAT stale...' They look at each other, nod, and walk away."	"You sit and listen a lot, and more importantly, give positive feedback for all their helpful advice. 'Wow! You guys, it's like, you're saying it straight, but it's really profound!' And they are. If you just had faith and weren't a sourpuss, why, you could learn a lot. Their show finished, they quickly thank you and explain they forgot they had another place to be, and they need to get started early."
questions field	3	"Well, of COURSE the Brothers didn't leave a thank-you note. Ungrateful chumps. Next time you help someone, you'll demand a deposit of flattery up front, that's for sure."	"You expected no thanks, but you didn't expect to feel bad about getting no thanks. Hmph. Lesson learned!"	"'You had some wisdom to foist on the Brothers, but if they'd REALLY done their job, they'd have stayed. The heck with them! If they couldn't soak up knowledge from BEING around the [bg], they're hopeless."	"Well! You did something for the brothers, but just in case, you want to make sure the [bad-guy] isn't upset with you for stealing his employees away. You never thought of that before. Maybe if he's mad, you can make it up to him."
questions field	4	"'Kinda jealous of your brothers, eh? Not jealous enough to DO anything about it.' The brother[plur-s] nod[sing-s] at your sterling logic. 'You gonna waste your whole life here? I can't help everyone. I'm not a charity, you know.' More hard hitting truth! Ba-bam!'[wfk]'Go on, now! Go! What's that? I'm even bossier than the [bad-guy]? Excellent! If I can change, so can you! And the guy bossier than the [bad-guy] is ORDERING you to do something useful with your life!'[paragraph break]They follow your orders. You remember being bossed around by someone dumber than you--and now you turned the tables! Pasta fazoo!"	"'Still guarding Freak Control, eh? Well, I think you'll see you don't need to guard it from ME any more. Take the day off! C'mon, you want to. Hey, [bg] might be mad if you don't.' You're surprised he DOES run off."	"'Hey! Sorry to separate you from the rest of your family. But--well, mind if I go by? I mean, if you let someone in who just wants to help, maybe you'll, like, get rewarded.' The [if bros-left is 1]remaining brother shrugs and leaves[else]two reamining brothers look at each other, shrug, say 'He DID say...' and walk off[end if]. Man! You just had to ask nicely!"
questions field	5	"[qfifvis] brothers guard the way north. '[qfjs] standing around, eh? Nothing to do? Well, I've been out, y'know, DOING stuff. You might try it. Go along. Go. You wanna block me from seeing the [bad-guy]? I'll remember it once he's out of my way.' You're convincing enough, they rush along."	"You've done your share of standing around, but you're pretty sure you did a bit of thinking. 'Look,' you say, 'I just need to get through and get out of here. I'm not challenging anyone's authority. Just, I really don't want to be here.' [bro-consider]. You're free to continue."	"'So, yeah, you're here to guard the [bg] from chumps, right? Well, I'm not one. So you can make way.' And they do. Even though they're all bigger than you. Sweet!"	"'Hey, there! Any chance I can see the [bad-guy]? He seems like someone I should meet,' you say. The brother[plur-s] seem[sing-s] confused. Usually, anyone trying to get in has a complaint.[paragraph break]'Stay there a minute.' You do. When [he-they-bro] come[sing-s] back out, you're nodded through. You turn to wave and give a thumbs-up, but nobody's there. Gee, all you had to do was ask nicely!"
freak control	0	"You speak first. 'Don't pretend you can't see me, with all those reflective panels and stuff.'[paragraph break]He turns around, visibly surprised.[paragraph break]'Leadership, schmeadership,' you say. You're worried for a moment he might call you out on how dumb that sounds. You're open-minded like that. But when he hesitates, you know the good insults will work even better. 'Really. Leaving the cutter cookie right where I could take it, and plow through, and expose you for the lame chump you are. Pfft. I could do better than that.'[paragraph break]He stutters a half-response.[paragraph break]'Maybe that's why [bad-guy-2] hasn't been dealt with, yet. You say all the right things, but you're not forceful enough. Things'll change once I'm in power.'[wfk]He has no response. You point outside. He goes. Settling in is easy--as a new leader of Freak Control, you glad-hand the important people and assure them you're a bit cleverer than the [bad-guy] was. Naturally, you keep a list of [bad-guy-2]'s atrocities, and they're pretty easy to rail against, and people respect you for it, and from what you've seen, it's not like they could really get together and do anything, so you're making their lame lives more exciting.[wfk]You settle into a routine, as you read case studies of kids a lot like you used to be. Maybe you'd help one or two, if they had initiative...but until then, you'd like to chill and just let people appreciate the wit they always knew you had.[paragraph break]Really, who can defeat you? Anyone of power or consequence is on your side. Even [bad-guy-2] gives you tribute of a cutter cookie now and then. One day, you drop one in Meal Square... but nobody is brave enough to eat one. Well, for a while."	"You speak first. Well, you sigh REALLY loudly first. 'Just--this is messed up. I want to leave.'[paragraph break]'Of course you do,' says the [bad-guy]. 'I don't blame you. If you're not in power here, it's not fun. It's sort of your fault, but not totally. Hey, you actually showed some personality to get here. Just--show me you're worthy of leaving.' You complain--more excitingly than you've ever complained before. Without flattering or insulting the [bad-guy] too much: fair and balanced. You let him interrupt you, and you even interrupt him--but only to agree with his complaints.[wfk]'You're okay, I guess. You seem to know your place. Here, have a trip to the [activation of guttersnipe] in Slicker City. Seems like just the place for you. The [bad-guy] pushes a button and gestures to an opening. It's a slide. You complain a bit, but he holds up his hand. 'You'll have a lot more to complain about if you don't go.' You're impressed by this logic, and you only wish you could've stayed longer to absorb more of it, and maybe you could complain even more interestingly. You learn the culture in the Snipe Gutter for a bit, outlasting some veterans, then one day you just get sick of the clueless newbies who don't know what they're doing.[wfk]Back home, people notice a difference. You're still upset about things, but you impress people with it now. You notice other kids who just kind of seem vaguely upset, like you were before the Compound, not even bothering with constructive criticism. They're not worth it, but everywhere you go, you're able to fall in with complainers who complain about such a wide variety of things, especially people too dense to realize how much there is to complain about! You've matured, from..."	"'Hey! It's me!' you yell. [bg] turns. 'You know, I probably skipped a lot of dumb stuff to get here. You think you could be a LITTLE impressed?'[paragraph break][wfk]But he isn't. 'You know? You're not the first. Still, so many people just sort of putter around. You're going to be okay in life.' You two have a good laugh about things--you're even able to laugh at yourself, which of course gives you the right to laugh at people who haven't figured things out yet. Humor helps you deal, well, if it doesn't suck. You realize how silly you were before with all your fears, and you try to communicate that to a few creeps who don't want to be social. But they just don't listen. You'd rather hang around more with-it types, and from now on, you do."	"You speak a bit loudly. 'Hey, man! I heard you could teach me stuff, and I was jealous at first, but I'm... err... [activation of see if i care] how you do it?'[paragraph break]'Dude! Everyone says that. Do you mean it?' You nod vigorously. 'Great,' he continues. 'We could use more attitudes like yours. Tell me what you've been up to. Oh, yes, the points brownie. Made with my special [activation of butter up]. Say, there's more where that came from. But I can't just GIVE you it. You'll need some [activation of gravy train] to toughen up, then maybe you can appreciate my special [activation of salad days] more fully. It even has a rare [activation of pea brain]... but first, well, I'm getting a bit tired of Guy Sweet. I think you'd be an upgrade. Do well enough, and we'll maybe discuss another promotion over some of my sophisticated special cooking.'[wfk][line break]'What's that?'[wfk][line break]'Well, at first, you might need a little [activation of chowderhead], which you won't appreciate fully right away, but when you do, you'll deserve my [activation of curry favor]. Of course, you'll never quite deserve my [activation of stake a claim] or [activation of breadwinner], but...'[paragraph break]Your mouth waters. Something even better than that daze salad! You listen as the [bad-guy] describes your first task: tell Guy Sweet he's nice and all but he deserves a break. You're going to do it. And everyone's going to be happier when you do. Well, everyone who [i]wants[r] to be." [temproom freak control]

to say he-they-bro:
	if bros-left > 1:
		say "they";
	else:
		say "he";

to say where-howdy:
	say "[if soda club is visited], probably to the Soda Club[else if down ground is visited], maybe for a nap on the Warmer Bench[else]off east where you don't want to disturb his break[end if]";

say-old-you is a truth state that varies.

to check-fast-track:
	if say-old-you is false:
		if brownie is in lalaland:
			say "[line break]Wow! It's pretty cool being around people a little more socially acceptable than you. You're learning so fast!";
		else:
			say "[line break]Yup. You're not messing around. Chumps need to get out of your WAY. Maybe the Old You, before you ate the [bad-eaten], would've gotten bogged down in a silly puzzle or fetch quest or something, thinking some nonsense like it's the journey that mattered. But the new you--nope, Nope, NOPE.";
		now say-old-you is true;

to deal-with-loc:
	if location of player is cheat-surveyed:
		continue the action;
	unless location of player is an accel-place listed in table of accel-text:
		say "BUG. There should be text here.";
		now location of player is cheat-surveyed;
		the rule succeeds;
	if player is in Nominal Fen:
		if silly boris is in Nominal Fen:
			choose row with alt-num of 1 in table of accel-text;
		else:
			choose row with alt-num of 2 in table of accel-text;
	else if player is in questions field:
		let my-alt be 3 + bros-left;
		if my-alt > 4:
			decrement my-alt;
		choose row with alt-num of my-alt in table of accel-text;
	if off-eaten is true:
		if there is no accel-off entry:
			say "[bug]. There should be text for the off-cheese and [location of player].";
		else:
			say "[accel-off entry][line break]";
	if greater-eaten is true:
		if there is no accel-greater entry:
			say "[bug]. There should be text for the greater-cheese and [location of player].";
		else:
			say "[accel-greater entry][line break]";
	if cookie-eaten is true:
		if there is no accel-cookie entry:
			say "[bug]. There should be text for the cookie and [location of player].";
		else:
			say "[accel-cookie entry][line break]";
	if brownie-eaten is true:
		if there is no accel-brownie entry:
			say "[bug]. There should be text for the brownie and [location of player].";
		else:
			say "[accel-brownie entry][line break]";
	if player is in pressure pier: [cleanup]
		if Terry Sally is not in lalaland:
			check-fast-track;
		now Terry Sally is in lalaland;
		say "[line break]Better get started going north, then.";
	if player is in Nominal Fen:
		if silly boris is not in lalaland:
			check-fast-track;
		now all clients are in lalaland;
		say "[line break]Need to keep going, here.";
	if player is in speaking plain:
		check-fast-track;
		now turk is in lalaland;
		now dutch is in lalaland;
		say "[line break]Can't be much longer.";
	if player is in questions field:
		now brother soul is in lalaland;
		now brother blood is in lalaland;
		now brother big is in lalaland;
		say "[line break]All right, this should be about it.";
	if player is in freak control:
		if cookie-eaten is true:
			unlock-verb "cookie";
		else if greater-eaten is true:
			unlock-verb "greater";
		else if off-eaten is true:
			unlock-verb "off";
		else if brownie-eaten is true:
			unlock-verb "brownie";
		end the story saying "[final-fail-quip]";
		the rule succeeds;
	now location of player is cheat-surveyed;
	continue the action;

to say final-fail-quip:
	if greater-eaten is true:
		say "People Power? [activation of people power]![no line break]"; [temproom endgame]
	else if off-eaten is true:
		say "[activation of complain cant]? Complain Cant![no line break]"; [temproom endgame]
	else if cookie-eaten is true:
		say "[activation of something mean]? Something Mean![no line break]"; [temproom endgame]
	else if brownie-eaten is true:
		say "Much Flatter? [activation of much flatter]![no line break]"; [temproom endgame]

to say qfjs:
	say "[if questions field is unvisited]Just[else]Still[end if]"

to say qfifvis:
	say "[if questions field is unvisited]Three[else]Those[end if]"

to say bro-consider:
	if bros-left is 1:
		say "You both agree that you probably would've helped him, too, if you had the time, but life stinks. You exchange an awkward handshake good-bye";
	else:
		say "The brothers confer. '[bg] said to let him in...obviously harmless...grumbly...' You tap your foot a bit and sigh. They wave you through and nip off to the side"

to say sing-s:
	say "[if bros-left is 1]s[end if]";

to say plur-s:
	say "[unless bros-left is 1]s[end if]";

chapter Assignment Plum

an assignment plum is an edible thing on Tray A. description is "It looks too delicious to eat. You wouldn't want to, unless you'd been told."

check eating assignment plum:
	try taking assignment plum instead;

check taking assignment plum:
	say "You can't help but feel that's for someone more with-it and sophisticated than you[if bros-left > 0], even though you've made a lot of progress[end if]." instead;

chapter basted lamb

an basted lamb is an edible thing on Tray A. description is "It looks too delicious to eat. You wouldn't want to, unless you'd been told."

check eating basted lamb:
	try taking basted lamb instead;

check taking basted lamb:
	say "It might taste delicious, but oh, the yelling you could get if it was someone else's and they stopped by to try to eat it!" instead;

chapter Thyme Burger

a thyme burger is an edible thing on Tray A. description is "It doesn't appear to have any hot dogs or pickles or eggs in it. Or, um, meat. But lots of thyme is sticking out of it. And it looks like it's been stepped on, too."

check eating thyme burger:
	try taking thyme burger instead;

check taking the thyme burger:
	say "A catchy tune pops in your head as you reach for it, but then, nah. You've got no idea who might've stepped on it." instead;

chapter condition mint

for writing a paragraph about a supporter in Meal Square:
	say "Two trays sit here, labeled, semi-helpfully, Tray A and Tray B[one of]. You're not surprised [activation of astray] or [activation of ex-tray] is gone, but [activation of tea tray] would've been nice[or][stopping].";
	now all supporters in meal square are mentioned;

a condition mint is an edible thing on Tray A. description is "It's one inch square, with [activation of no-shame]! [activation of forgive]... on it. Maybe there's be more, but it [i]is[r] a small mint."

indefinite article of condition mint is "a".

check eating the condition mint:
	if silly boris is in lalaland:
		now condition mint is in lalaland;
		say "You think about the jerks. Maybe they'd have liked it. Then you gulp down the mint in their memory. You look at all the machinery--maybe one has a clue what to do." instead;
	say "No, it's the sort you gift to someone else[if player does not have mint], but you can take it, to give it to someone else[end if]." instead;

definition: a client (called cli) is befriended:
	choose row with jerky-guy of cli in table of fingerings;
	if suspect entry is 2:
		decide yes;
	decide no;

chapter charred pie

The charred pie is an edible thing on Tray A. description is "It doesn't look very appetizing."

check eating charred pie:
	say "Ugh, no. You've settled for second best before, but this looks bland and nott very nutritious." instead;

check taking charred pie:
	say "It'd probably fall apart if you carried it anywhere." instead;

chapter up gum

the up gum is an edible thing on Tray A. description is "You know it's UP GUM since that's what's carved into the top surface."

indefinite article of up gum is "some".

understand "get up" as gumtaking when player is in meal square.

gumtaking is an action applying to nothing.

carry out gumtaking:
	if accel-ending:
		say "Gum? Boring." instead;
	say "This is slightly ambiguous. It may mean taking the gum, or it may mean you want to exit. Do you wish to eat the gum?";
	if the player yes-consents:
		try eating gum instead;
	else:
		try going east instead;

check taking some up gum:
	if accel-ending:
		say "Gum? Boring." instead;
	say "You tend to just put gum in your pocket and forget about it. If you want to chew it, you should probably do so now. Have a chew?";
	if the player yes-consents:
		try eating some up gum instead;
	else:
		say "OK." instead;

check eating some up gum:
	if accel-ending:
		say "Gum? Boring." instead;
	say "Man! As you start chewing, you realize how to chew for better pleasure and taste preservation. You keep experimenting--wow, that works, that doesn't--man, you totally have ideas for a REALLY COOL SCIENCE PAPER! Until [if joint strip is unvisited]two shadowy characters[else if judgment pass is unvisited]the Stool Toad and some other bossy looking fellow[else]the Stool Toad and Officer Petty[end if] approach.";
	wfak;
	say "'Say! Look-a-here! Can't walk and chew gum at the same time!' Startled, you blink.";
	wfak;
	say "'But he can blink and chew gum, so that's something! Well, another one of these. Only one place for [']em.'";
	wfak;
	say "You should've expected that treat would...gum up your progress.";
	ship-off Maintenance High instead;

chapter iron waffle

an iron waffle is an edible thing on Tray A. description is "Just staring at it, you imagine ways to brush off people who get up in your grill with dumb questions. You try and forge them into a set of rules, but you feel, well, rusty."

indefinite article of iron waffle is "an".

check taking the iron waffle:
	say "Much too heavy. You don't see anything you could do with it." instead;

check eating the iron waffle:
	say "Your teeth are actually pretty good, and that'd be a great way to change that." instead;

chapter gagging lolly

a gagging lolly is an edible thing on Tray A. description is "Staring at the circular lolly's hypnotizing swirls of hideous colors, you also feel less sure of things, which makes you feel open-minded, which makes you feel more sure of things, which makes you feel closed-minded and eventually less sure of things.[paragraph break]Man! That was tough to digest. Just all that thinking was a choking enough sensation."

indefinite article of gagging lolly is "a".

check taking lolly:
	say "You haven't walked around with a lolly since you were five years old, and it'd be a bit embarrassing to do so now. Anyway, who would actually take it?" instead;

part Down Ground

Down Ground is east of Pressure Pier. It is in Outer Bounds. "[one of]Walking east of Pressure Pier, the land dips a bit. You pass by a bench that seems to radiate heat. A closer look reveals that, yes, it is a Warmer Bench.[or]The Warmer Bench waits here. It may be useful to lie on, or not[stopping]. Even choosing between eventually exiting to the east or west is oppressive."

after printing the locale description for down ground when down ground is unvisited:
	say "You're reminded of the day you didn't get a permission slip signed to go to the roller coaster park at science class's year end. You wondered if you really deserved it, since you didn't do as well as you felt you could've.[line break]";
	say "As you finish this thought, a large human-sized toad strolls in from the east. 'So! A new juvenile, eh? You's best not to SLIP. It ain't hard to avoid winding up mumbling and alone like Fritz the On, here. Whatever he smokes, can't be no [activation of joint statement]. Doobie? BE! DO!' His [activation of grammar police] leaves you unable to say anything until he disappears back east.[paragraph break]Fritz the On mutters something about that oppressive Stool Toad."

check going nowhere in Down Ground:
	if noun is down:
		say "You're down enough." instead;
	if noun is inside or noun is outside:
		say "There are two ways in or out: east or west." instead;
	if noun is up:
		say "Paths up to the east or west. So hard to decide which." instead;
	say "It's too high a slope north or south. Plus, you're not sure if such [activation of ground up] would be safe, though you do want to work from the, er, ground up." instead;

the warmer bench is a supporter in Down Ground. "The Warmer Bench waits here. It may be fun to lie on.". description is "Originally painted on the bench: PROPERTY OF [activation of beach bum]. Property Of is replaced by FORECLOSED FROM. You feel the heat coming from it. It makes you sleepy."

after examining warmer bench:
	now bum beach is in lalaland;
	continue the action;

check taking bench:
	say "It's too big. And where would you move it, anyway?[paragraph break]If you want to take it over, just SLEEP." instead;

After choosing notable locale objects:
	if player is in down ground:
		set the locale priority of warmer bench to 0;

check entering bench:
	say "If you do, you know you'll just fall asleep. Do so anyway?";
	if the player yes-consents:
		try sleeping instead;
	else:
		say "OK." instead;

section Fritz the On

Fritz the On is a surveyable person in Down Ground. "[one of]A fellow a bit older, but likely not wiser, than you sits cross-legged next to the Warmer Bench.[or][fritz-mumb].[stopping]"

to say fritz-mumb:
	say "[one of]Fritz the On still mumbles, sitting cross-legged[or]Fritz the On mumbles something incoherent about founding a consciousness-expanding school called [activation of high roller][stopping]"

description of fritz is "Fritz the On may be cosmically 'on,' but physically, he's out of it. Scruffy and unclean, he wobbles to and fro, mouthing words you can't make out[if fritz has bear]. He's clinging tightly to Minimum Bear[end if]."

understand "bum" as fritz

before taking bear when Fritz carries bear:
	say "Now that'd be just mean." instead;

after printing the name of boo tickety while taking inventory:
	say " ([your-tix] piece[if your-tix > 1]s[end if])";

the boo tickety is a thing. description is "WHATEVER YOU DID: BOOOOOO is displayed on [if your-tix is 1]it[else]each of them[end if].[paragraph break]You have [your-tix] [if your-tix is 1]piece of a boo tickety[else]pieces of boo ticketies[end if]. But [if your-tix is 1]it doesn't[else]they don't[end if] make a full document yet."

understand "boo ticket" and "ticket" as boo tickety.

drop-ticket is a truth state that varies.

the dreadful penny is a thing. description is "It has a relief of the [bad-guy] on the front and back, with '[activation of brain trust]' on the back. You hope it's worth more than you think it is."

after examining dreadful penny:
	now brain trust is in lalaland;
	continue the action;

your-tix is a number that varies.

to terry-sug:
	let ff be first-ticket of 0;
	if ff > 0:
		choose row ff in table of tickety suggestions;
		say "Terry Sally nods, semi-impressed, but wonders aloud if you considered [ticket-ref entry]. You shake your head.[line break]";
		continue the action;
	let ff be first-ticket of 2;
	if ff > 0:
		choose row ff in table of tickety suggestions;
		say "Terry Sally nods, semi-impressed, but wonders aloud if you considered [ticket-ref entry]. You say you did, but really, it didn't seem as fun or expedient as what you did.";
		continue the action;
	say "Terry Sally whistles. 'Wow! Somehow, you managed to do seven things when you only needed to do four. That's probably due to a BUG, but impressive, nonetheless.'"

table of tickety suggestions
ticket-ref	ticket-done
"dropping a ticket you had"	0
"giving Fritz his dumb bear he keeps losing"	0
"going off the path in the Joint Strip"	0
"taking alcohol out of the Soda Club"	0
"being too awkward to speak in the Soda Club"	0
"offering a sophisticated girl insultingly weak alcohol"	0
"sleeping too long on the Warmer Bench"	0

to decide which number is first-ticket of (nu - a number):
	let my-row be 0;
	repeat through table of tickety suggestions:
		increment my-row;
		if ticket-done entry is nu:
			decide on my-row;
	decide on 0;

to get-ticketed (ttext - text):
	if ttext is a ticket-ref listed in table of tickety suggestions:
		choose row with ticket-ref of ttext in table of tickety suggestions;
		if your-tix is 4:
			now ticket-done entry is 2;
		else:
			now ticket-done entry is 1;
	else:
		say "BUG -- the ticket-ref entry in the table of tickety suggestions needs fixing.";
	increment your-tix;
	if your-tix is 5:
		if player is in soda club:
			say "'Up to trouble, eh? I thought you might be.' The Stool Toad frog-marches you (ha! Ha!) out of the Soda Club to a rehabilitation area.";
			ship-off A Beer Pound;
		else:
			say "The Stool Toad [if player is not in joint strip]rushes over from the Joint Strip, yelling and getting on, but then [end if]turns all quiet. 'Son, you've gone too far. It's time to ship you out.' And he does. Even Fritz the On shakes his head sadly as you are marched past to the west.";
			ship-off Shape Ship;
		decrement your-tix;
	else if your-tix is 4:
		say "[line break]You have the fourth and final boo tickety you need! Using some origami skills you felt would never be practical, you fold them to form a coherent document: a trail paper!";
		now boo tickety is in lalaland;
		now player has trail paper;
		if player has a drinkable:
			say "[line break]Uh oh. You look at the drink in your hand. You're a hardened lawbreaker, now, and if the Stool Toad caught you with it, he'd have reason to send you off somewhere no good. You should probably DROP the [if player has brew]brew[else]cooler[end if].";
	else if your-tix is 1:
		say "[line break]You aren't sure what to do with this. It's not quite a ticket, because it's not shaped like one. It's cut diagonally, and it's triangular. You can see how putting four together would make a stamped seal, but it's nothing impressive right now.";
		now player has boo tickety;
	else if your-tix is 2:
		say "[line break]What luck! The second boo tickety you got fits in with the first. You now have a diagonal-half of, well, something.";
	else if your-tix is 3:
		say "[line break]You now have almost a full paper from the boo ticketies.";
	else:
		say "Uh-oh. You have entirely too many ticketies. This is a BUG. Write me at [email].";

litany of fritz is the table of fritz talk.

table of fto - fritz talk
prompt	response	enabled	permit
"Hi."	fritz-hi	1	1
"You okay?"	fritz-ok	1	1
"Who's your pal?"	fritz-pal	0	1
"What do you know about the [bad-guy]?"	fritz-bm	1	1
"[later-or-thanks]."	fritz-bye	3	1

table of quip texts (continued)
quip	quiptext
fritz-hi	"'I...I lost my...'"
fritz-ok	"'Yeah... just need... my pal.' Fritz looks around."
fritz-pal	"Fritz looks embarrassed, as if he doesn't want to say who his pal is. 'Others say he's not up to scratch, but he fits in ok with me.'"
fritz-bm	"'Well, he tolerates me more than he says [bad-guy-2] would. He also said it was ironic he got more out of drug humor than I did. He's even seen [i]Reefer Madness[r], and I haven't!'"
fritz-bye	"As you turn away, Fritz mumbles something about hoping you find genuine consciousness. You seem closer than most squares here."

after quipping when qbc_litany is litany of fritz:
	if current quip is fritz-ok:
		enable the fritz-pal quip;
	if current quip is fritz-bye:
		terminate the conversation;

part Joint Strip

Joint Strip is east of Down Ground. It is in Outer Bounds. "There's a familiar but disturbing scent in the air--those responsible for it are probably hiding nearby from the local law enforcement. The clearest exits are south to [if Soda Club is visited]the Soda Club[else]a fly bar[end if] or back west to Down Ground. Stickweed blocks off pretty much every other direction."

the stickweed is scenery in joint strip. "Man, it's wild, and high! Sorry about that. But it doesn't seem TOO dangerous, unless you sit in it for a long time and forget where you are."

understand "stick weed" and "weed stick" as stickweed.

check taking stickweed:
	say "It's more for cover than for personal use[if trail paper is off-stage]. If you want to annoy the Stool Toad, maybe you could ENTER it, or go any direction through it[end if]." instead;

check entering stickweed:
	try going east instead;

the fly bar is scenery in Joint Strip. "[if soda club is visited]It isn't labeled, but there's not a bouncer or anything[else]The Soda Club seems much less mysterious now you've been in it[end if]."

instead of entering bar:
	try going south.

instead of doing something with the bar:
	if action is undrastic:
		continue the action;
	say "You can't do much with the bar other than enter it."

check going south in joint strip:
	if jump-level > 2:
		say "[one of]'There's something about you, young man. Like you've been shifty before. I can't trust you. So you better use some common sense. Or I'll use it for you!' booms the Stool Toad.[paragraph break]On further reflection, you figure there probably wasn't much in there. Much you need any more, anyway. Also, his last little put-down didn't make any sense. But it still hurt.[or]You don't want to be told off by the Stool Toad again. Whether or not he makes sense the next time.[stopping]" instead;
	if Terry Sally is in lalaland:
		say "You had your 'fun,' or an attempt at it, anyway. You don't want to go [if soda club is visited]back there[else]anywhere too crazy[end if]." instead;
	if jump-level > 0 and soda club is unvisited:
		say "The Stool Toad eyes you suspiciously. 'Don't know what you're up to, but ... it's something too clever for your own good. You--you cheated to get here, somehow.'";
	else if soda club is unvisited:
		say "You look over your shoulder at the Stool Toad. 'I can't stop you, young man. But you keep your nose clean!' he shouts.";

check going nowhere in Joint Strip:
	if player has wacker weed:
		say "No, those people already have some, err, merchandise of their own. There's got to be someone jonesing for it who doesn't, yet." instead;
	if player has poory pot:
		say "Those people probably have better stuff than what you've got." instead;
	unless trail paper is off-stage:
		say "You don't want to attract the Stool Toad's attention, now that you've gotten enough ticketies." instead;
	if off-the-path is true:
		say "The repeat offense will get you shipped off." instead;
	if noun is inside:
		try going south instead;
	if noun is outside:
		say "You already are." instead;
	say "[one of]The Stool Toad booms 'Where you going, son? This isn't a [activation of strip search] without the right outfit!' You consider asking him why he isn't searching, but you don't have the guts. But you bet if you try wandering off again, he might get up from his stool.[or]'Sneak off? Off, sneak!' The Stool Toad nods pointedly at you. He's going to take action if you try that again.[or][toad-write-up][or]You already crossed the Stool Toad that way.[stopping]";
	the rule succeeds;

off-the-path is a truth state that varies.

to say toad-write-up:
	say "As you stumble through the stickweed for the third time, you uncover--[activation of case a joint]! The Stool Toad, so passive with all the suspicious smells around, leaps into action as sunlight reflects off it and in his eyes.[paragraph break]'You're lucky it's empty. But I can still write you up for aggravated jaywalking.' He mutters about laws preventing him from writing you up for more[if your-tix > 0], before seeing you're a repeat offender[end if].";
	now off-the-path is true;
	get-ticketed "going off the path in the Joint Strip";

bar-scen is privately-named scenery in Joint Strip. "It seems unobtrusive, with no obviously tacky paraphernalia or neon signs or whatever."

instead of doing something with bar-scen:
	if current action is entering:
		try going south instead;
	if action is undrastic:
		continue the action;
	say "You can't do much with the bar except enter it. But on the bright side, you can probably do more once you're in the bar." instead;

section minimum bear

Minimum Bear is a thing in Joint Strip. "[unless minimum bear is examined]A small toy bear[else]Minimum Bear[end if] lies here."

description of Minimum Bear is "[if minimum bear is not examined]Gee, isn't that cute? A tag reveals its name to be Minimum Bear. Well, it's not that cute. Only just cute enough to make you think aw, with as few w's as possible[else]It's just bear-ly cute enough. Ba boom boom[end if]. Only someone completely unworried about aesthetics, or terribly caught up in nostalgia and/or bizarre reasoning, could fully love poor Minimum Bear."

after taking Minimum Bear:
	if Minimum Bear is not examined:
		say "As you pick it up, you notice a tag says Minimum Bear. Cute, but not very.";
		now minimum bear is examined;
	else:
		say "You look around nervously as you pick Minimum Bear up. The Stool Toad scoffs slightly.";

the nametag is part of minimum bear. description is "The tag identifies Minimum Bear by name[ex-min]."

understand "tag" as nametag when player has minimum bear.

to say ex-min:
	now minimum bear is examined;

instead of doing something with the nametag:
	if action is undrastic:
		continue the action;
	say "You don't need to fiddle with the tag.";

understand "toy" and "toy bear" as Minimum Bear.

section the Stool Toad

The Stool Toad is an improper-named enforcing person in Joint Strip. "[one of]Ah. Here's where the Stool Toad went. He's sitting on a stool--shaped like a pigeon, of course.[paragraph break]'So! The new juvenile from Down Ground. Best you stay out of [if tix-adv > 0]further [end if]trouble.'[or]The Stool Toad, sitting on his pigeon stool, continues to eye you [tix-adv].[stopping]"

check talking to toad when trail paper is not off-stage:
	say "You don't want to let anything slip that could get you in further trouble, with all the boo-ticketies you accumulated." instead;

to decide what number is tix-adv:
	if fritz has minimum bear, decide on your-tix - 1;
	decide on your-tix;

to say tix-adv:
	say "[if tix-adv is 0]patronizingly[else if tix-adv is 1]somberly[else if tix-adv is 2]suspiciously[else]oppressively[end if]"

description of the Stool Toad is "Green, bloated and, oh yes, poisonous. He reminds you of a security guard at your high school whose every other sentence was 'YOUNG MAN!'"

the pigeon stool is scenery in Joint Strip. "It's shaped like a curled up pigeon, though its head might be a bit too big and flat. It's kind of snazzy, and you'd actually sort of like one. You read the words [activation of moral support] on it and feel immediately depressed[one of]. You aren't an orinthologist, though you got accused of being one, but if you had to guess, it'd be an [activation of pigeon English][or][stopping]."

does the player mean talking to stool toad when player is in joint strip: it is likely.

does the player mean doing something with the pigeon stool when player is in joint strip: it is likely.

instead of doing something with pigeon stool:
	if action is undrastic:
		continue the action;
	say "Since it's under the Stool Toad, there's not much you can do with it."

toad-got-you is a truth state that varies.

check going north in Soda Club:
	if player has a drinkable:
		if toad-got-you is false:
			say "'HALT! FREEZE! A MINOR WITH ALCOHOL!' booms the Stool Toad. He takes your drink and throws it off to the side. 'THAT'S AN INFRACTION!'[paragraph break]He looks around in his pockets but only finds a diagonal scrap of paper. 'Well, this'll do, for a boo tickety. Remember, you're warned.' You feel sort of rebellious--good rebellious--as he [if your-tix >= 4]counts your infractions on his fingers. Uh oh. Maybe you could've DROPped the booze before leaving[else]goes back to his pigeon stool[end if].";
			if player has haha brew:
				now haha brew is in lalaland;
			else:
				now cooler wine is in lalaland;
			get-ticketed "taking alcohol out of the Soda Club";
			activate-drink-check;
			now toad-got-you is true;
			do nothing instead;
		else:
			say "You can't go face the Stool Toad again. Not with the drink in your hand." instead;
	else:
		say "The Stool Toad looks you up and down as you exit. He nods. 'Better stay clean, or you'll get a boo tickety.'";

to activate-drink-check:
	if cooler wine is not in lalaland:
		choose row with response of ally-cooler in table of Ally Stout talk;
		now enabled entry is 1;
	if haha brew is not in lalaland:
		choose row with response of ally-haha in table of Ally Stout talk;
		now enabled entry is 1;

litany of stool toad is the table of stool toad talk.

table of st - stool toad talk
prompt	response	enabled	permit
"Um, yeah, hi, don't worry about me, I'm a good person and stuff."	toad-hi	1	1
"Why's this called the Joint Strip? I don't see anyone..."	toad-joint	1	1
"Just curious...what IS trouble around here? So I know what to avoid."	toad-troub	0	1
"I need a refresher what to avoid."	toad-refresh	0	1
"You pompous..."	toad-pomp	0	0
"What do you know about the [bad-guy]?"	toad-bm	1	1
"Sedition laws? That sounds horrible!"	toad-sedition	0	0
"[later-or-thanks]."	toad-bye	3	1

table of quip texts (continued)
quip	quiptext
toad-hi	"'They all say that. You're a bit less convincing than the rest. But you're also kind of more convincing at the same time, which also has me suspicious.'"
toad-joint	"'Of course not! But they would be if I weren't here! A [activation of job security] is tougher than it looks. There's just something ABOUT this place. Worse turpitude might fester without my imposing presence. Someone might even put up a [activation of advice] for the [activation of stop smoking].'"
toad-troub	"'[bad-toad].'"
toad-refresh	"'Y'mean you don't remember[one of][or], again[stopping]? [bad-toad].'"
toad-pomp	--
toad-bm	"'Well, he's a smart fella, but he still looks out for folks like me. Got me this position keeping order here. Said [bad-guy-2] wouldn't pay half as much. Plus the job satisfaction. Making people smarter than me feel dumb. Can't beat that. Asked my opinion on sedition laws the other day, too. Bad idea to start slanging [bad-guy] without proof even if you aren't kinda weird yourself. No offense.'"
toad-sedition	--
toad-bye	"'Don't do anything stupid. But don't go trying to be too clever, either.'"

litter-clue is a truth state that varies.

to say bad-toad:
	now litter-clue is true;
	say "Littering. Suppressing evidence of prior misconduct. Acting up in the bar. Minor in possession of alcohol. Aggravated loafing. Seeking out illicit activities. All manner of [activation of bullfrog]"

after quipping when qbc_litany is litany of stool toad:
	if current quip is toad-hi:
		enable the toad-troub quip;
	if current quip is toad-troub:
		superable toad-refresh;
		enable the toad-pomp quip;
	if current quip is toad-bye:
		terminate the conversation;

part Soda Club

Soda Club is south of Joint Strip. It is in Outer Bounds. "Maybe if it were past 1 AM, you'd see passages west, south, and east, making this place the [activation of teetotal]--or maybe even the [activation of tea party]--instead. But if it were past 1 AM, you'd probably be home and asleep and not here. Or, at least, persuaded to leave a while ago.[paragraph break]The only way out is north."

check going nowhere in Soda Club:
	if noun is outside:
		try going north instead;
	say "Maybe there's a cheap [activation of bargain] where they serve [activation of beer nuts] behind a hidden passage. But you're not going to find it, or be told about it, so you'll have to continue with your adventure here." instead;

section Erin Sack

Erin Sack is a female person. "[one of]Well, that must be Erin Sack over there.[or]Erin Sack waits here for intelligent, stimulating conversation.[stopping]"

Erin Sack wears the rehearsal dress.

description of dress is "It--well, it's one of those things you can't think of anything wrong to say about it. It's neither too tacky or dowdy. Yet it seems, to your unfashionable eye, a bit [i]comme il faut[r]."

instead of doing something with rehearsal dress:
	if action is undrastic:
		continue the action;
	say "In this game, you can pretty much only examine the dress."

after printing the locale description for Soda Club when Soda Club is unvisited:
	say "The bartender calls you over. 'Say, new fella! Just use common sense, and you won't get the [activation of boot licker] like the [activation of sucker punch].'";
	wfak;
	say "'But hey, one thing. Can you give me a break from Erin Sack over there? She's--she's interesting at first, but when she's wearing that rehearsal dress she tends to repeat what she's already said. She's no [activation of hip rose], but Rose is probably out of your league anyway. No offense. By the way, I'm Ally Stout.'";
	move Erin Sack to Soda Club;

description of Erin Sack is "She is waiting for conversation in her rehearsal dress."

litany of Erin is the table of Erin talk.

table of ll - Erin talk
prompt	response	enabled	permit
"Um, er, yeah, hi, I'm Alec."	erin-hi	1	1
"Sure!"	erin-sure	0	1
"I guess."	erin-guess	0	1
"No."	erin-no	0	0
"..."	erin-wait	0	1
"Yeah, I'm in tune."	erin-tune	0	1
"Sorry, I'm not in tune."	erin-notune	0	1
"So is your life really that exciting, or do you just talk a lot?"	erin-exci	0	1
"So, where can I get practice interrupting people?"	erin-prac	0	1
"So, what about the [bad-guy]?"	erin-baiter	0	1
"[later-or-thanks]."	erin-bye	3	1

check talking to erin:
	if erin-done is true:
		enable the erin-prac quip;

table of quip texts (continued)
quip	quiptext
erin-hi	"'Oh, um, hi. Do you want to hear my exciting opinions on stuff?'"
erin-sure	"'Perfect!'[paragraph break][erin-sez]"
erin-guess	"'Well, give it a try!'[paragraph break][erin-sez]"
erin-no	--
erin-wait	"You're not sure if you nodded encouragingly enough, but Erin mutters something about your reaction to her controversial opinions being problematic. She mumbles something about not expecting anything in turn for her advice, and nothing personal, but she doesn't need you bringing her down, but you don't seem like a total jerk, so she hopes you find whatever you want, even if it'd be too boring for her. She even explains how you look like you need to interrupt people more. That would make you more exciting! But not, like, right away.[paragraph break]'So, am I making sense?'"
erin-tune	"[bye-erin of 2]'Well, you say you are, but few people GET in tune. Think about that a moment.'"
erin-notune	"[bye-erin of 2]'Well, I thought you were better than that. And don't expect an [']At least you were honest.[']'"
erin-exci	"'Well, if it is, it is, and if it isn't, you have to respect my imagination, my getting a lot out of a little.'"
erin-prac	"She blathers some general advice, and you're not sure whether it's a good idea to put that into practice before she finishes. She yawns once she's done. 'If you want a refresher, ask me again,' she offers, unconvincingly."
erin-baiter	"'Well, he's equally snarky to males and females. Is that equality, or is that equality?'"
erin-bye	"[if anything-said-yet is false][erin-creep][else]'Bye.'[end if]" [ok]

erin-warn is a truth state that varies.

to say erin-creep:
	if erin-warn is false:
		say "'Aww. Awkwardness is real cute, until it's creepy. So it was kinda flattering this time but don't, like, try it again.'[no line break]";
		now erin-warn is true;
	else:
		say "'That's--just creepy,' she says. 'I didn't come to the bar for this. BARTENDER!' Ally Stout blows a whistle, and the Stool Toad charges in.[paragraph break]He explains that this is pretty bad, seeing as how you looked like a nice kid, or at least a quiet one, and goes on some irrelevant diatribe against prank callers who just hang up, and also how if this is how you act SOBER...";
		if player has a drinkable:
			say "Ally Stout takes your drink away from you, too.";
			if player has haha brew:
				now haha brew is in lalaland;
			if player has cooler wine:
				now cooler wine is in lalaland;
		now Erin is in lalaland;
		get-ticketed "being too awkward to speak in the Soda Club";

to say erin-sez:
	say "[bye-erin of 0]She starts off explaining how you are lucky to have met someone as exciting as her. She babbles on about the low quality and alcohol content of drinks in this place. You nod, but she notes you haven't even TRIED to interrupt, and how she used to never interrupt but she's learned there's a balance between not interrupting at all and interrupting too much, and you--you do want more balance in your life? You want to be more enthusiastic about life, don't you?[no line break]"

to say bye-erin of (x - a number):
	choose row with response of erin-bye in table of Erin talk;
	now enabled entry is x;

erin-done is a truth state that varies.

after quipping when qbc_litany is table of Erin talk:
	if current quip is erin-hi:
		enable the erin-sure quip;
		enable the erin-guess quip;
		enable the erin-no quip;
	if current quip is erin-sure or current quip is erin-guess:
		disable the erin-sure quip;
		disable the erin-guess quip;
		disable the erin-no quip;
		enable the the erin-wait quip;
	if current quip is erin-wait:
		enable the the erin-tune quip;
		enable the the erin-notune quip;
	if current quip is erin-tune or current quip is erin-notune:
		disable the erin-tune quip;
		disable the erin-notune quip;
		enable the erin-prac quip;
		enable the erin-baiter quip;
		enable the erin-exci quip;
		now erin-done is true;
	if current quip is erin-bye:
		if erin-prac is talked-thru:
			enable the erin-prac quip;
		terminate the conversation;

to chase-erin:
	say "Ally Stout sidles over. 'Sorry, champ. Looks like you did something to chase off a good patron. By the moral authority vested in me by the [bad-guy], it is my pleasure and duty to issue a boo-tickety.'";
	now Erin is in lalaland;
	get-ticketed "offering a sophisticated girl insultingly weak alcohol";

section Ally Stout

Ally Stout is a baiter-aligned person in Soda Club. "[one of]The guy you guess is the bartender[or]Ally Stout[stopping] bustles around, serving drinks to the customers."

rule for supplying a missing noun while talking to:
	if player is in airy station:
		now noun is mentality crowd;
	if location of player is soda club:
		if erin is in soda club:
			say "Man! You feel less awkward talking to Ally, even though he's probably out of your friendship league. Well, it's his job.[line break]";
		now noun is Ally Stout;
		continue the action;
	if number of blabbable people is 1:
		now noun is a random blabbable person;
		continue the action;
	if number of blabbable people is 0:
		if number of chattable people > 0:
			let rc be a random chattable person;
			say "([rc], why not)[paragraph break]";
			now noun is rc;
			continue the action;
		say "There's nobody here to talk to.";
	else:
		say "There's more than one person here to talk with or to.";
	reject the player's command;

check talking to Ally Stout when Erin is in lalaland and conv-left of Ally Stout > 1:
	say "Ally Stout flashes you a tense smile. 'Still around? Well, I can't make you leave, and I sort of needed a break from her chatter, I guess. Eh, I've dealt with worse.'";

understand "bartender" as Ally Stout.

description of Ally Stout is "He bustles about, talking to the patrons, pouring drinks, flipping glasses and wiping the bar off, with the sort of false cheer you were dumb enough to believe was genuine."

litany of Ally Stout is the table of Ally Stout talk.

table of ast - Ally Stout talk
prompt	response	enabled	permit
"The Punch Sucker? Should I know more?"	ally-punch	1	1
"What've you got, for drinks? Um, non-alcoholic?"	ally-drinks	1	1
"Got any booze?"	ally-alco	1	0
"What does On the Rocks mean, anyway? It SOUNDS way cool!"	ally-onrocks	1	1
"But I'm not 21! Not even close!"	ally-but	0	1
"I'll have the Haha Brew."	ally-haha	0	1
"I'll have the Cooler Wine."	ally-cooler	0	1
"What do you think of the [bad-guy]?"	ally-baiter	1	1
"[later-or-thanks]."	ally-bye	3	1

indefinite article of a drinkable is usually "some".

the cooler wine is a drinkable. description is "My goodness! It's almost fluorescent."

the haha brew is a drinkable. description is "Extra golden and bubbly."

understand "drink" as cooler wine when player has cooler wine.
understand "drink" as haha brew when player has haha brew.

after printing the name of cooler wine when taking inventory:
	if your-tix >= 4:
		say " (you may sneakily want to drop this to avoid the Stool Toad's wrath)";

after printing the name of haha brew when taking inventory:
	if your-tix >= 4:
		say " (you may sneakily want to drop this to avoid the Stool Toad's wrath)";

table of quip texts (continued)
quip	quiptext
ally-punch	"'Whatever we give him, it goes down badly. [activation of punch out], he starts a fight. [activation of punch line], the stupid jokes he tells! [activation of punch ticket], he whines he's entitled, or worse, he isn't. And that night he snuck some [activation of punch drunk]...'"
ally-drinks	"'Well, you wouldn't be ready for the [activation of gin rummy] or [activation of rum go]. If we served it after-hours, of course. If we served it after-hours. And water's...troubled, in such an exciting place. But we have Haha Brew and Cooler Wine. Both so watered down, the Stool Toad won't nab you long as you drink it here.'"
ally-alco	"'Haha. No.'"
ally-onrocks	"Ally pushes a button on an unseen machine. You hear ice cubes rattle. He holds up a glass, swirls it, and nods meaningfully before putting it away. Duh, now. Maybe you should've asked what Beechwood Aged or something meant, instead."
ally-but	"'Well, everyone here is a bit smarter and maturer than normal, and anyway, this isn't the high-proof stuff. Plus the Stool Toad, we've paid him off. As long as nobody makes it obvious and walks out with a drink. Then he's pretty awesome. So what the hey.'"
ally-haha	"[here-or-not]"
ally-cooler	"[here-or-not]"
ally-baiter	"'The [bg] lets me stay open for very reasonable shakedown fees. Much better than [bad-guy-2], I'm sure. He just, well, he just wants to know about all the patrons in here. Why, he drops in here himself and gets the good stuff. But he's very fair and balanced. He knows it's not how much you drink but how it affects you. Why, he's better at shaming unruly customers than I am! I'm just too good at the [activation of speakeasy] you need to get along, I guess.'"
ally-bye	"He goes back to mixing and serving drinks, to talking to some other customers about other customers[if allow-swears is true] and backhand-complimenting the rival [activation of striptease][end if][one of]. You wonder if you're an other OTHER customer, or if you're even that important[or][stopping]."

to say here-or-not:
	if player has cooler or player has haha brew:
		say "'HEY! Drink what you've got, first.'[no line break]";
		continue the action;
	else:
		if your-tix is 4:
			say "You pause for a second. You've got quite a record, already. You don't need a fifth tickety. No, you'd better play it cool.[no line break]";
			continue the action;
		if current quip is ally-haha:
			say "'Ah good. If you, like, laughed hard at the name, you'd get kicked out like the Punch Sucker. Maybe you'll even be refined enough for [activation of brew a plot] some day.'[no line break]";
			now player has haha brew;
			disable the ally-alco quip;
		else:
			say "'Let me crank up the [activation of genuine]...'[no line break]";
			disable the ally-alco quip;
			now player has cooler wine;

after quipping when qbc_litany is litany of Ally Stout:
	if current quip is ally-drinks:
		enable the ally-but quip;
		enable the ally-haha quip;
		enable the ally-cooler quip;
	if current quip is ally-alco:
		if player has cooler wine:
			enable the ally-haha quip;
	if current quip is ally-cooler:
		if player has haha brew:
			enable the ally-cooler quip;
	if current quip is ally-haha:
		if player has cooler wine:
			enable the ally-haha quip;
	if current quip is ally-bye:
		terminate the conversation;

book main chunk

Main Chunk is a region.

part Nominal Fen

Nominal Fen is north of Pressure Pier. It is in Main Chunk. printed name of Nominal Fen is "[jc]". "[if silly boris is in lalaland]It's a bit more relaxed here without the [j-co]['] conversation[else][one of]This--well, it isn't a swamp, or a bog, or--well, you're not sure, and it's not particularly amazing, so yeah, call it a fen. [or][stopping]Seven [j-co] stand in a circle (okay, a heptagon) here, talking to and about others[end if]. It looks like there's forested area to the west, a narrow valley to the east, and things open up to the north. Nothing's stopping you going back south to Pressure Pier, either[if bros-left is 0], though you probably have nothing to do there with the Brothers gone[end if]."

every turn when player is in Nominal Fen and Silly Boris is in Nominal Fen:
	jerk-blab;

understand "drain the circle" and "drain circle" as a mistake ("Maybe you can find a way to make them feel drained.") when player is in Nominal fen and boris is in Nominal fen and allow-swears is true.

after printing the locale description for Nominal Fen when Nominal Fen is unvisited:
	unless accel-ending:
		say "'[activation of dirty word]! [activation of clean break]!' the [j-co] gabble away. They're trying a bit too hard to show they're not lame.";
		if allow-swears is true:
			say "[line break]Man. You just feel oppressed just being [activation of jerk around].";
	continue the action;

check going nowhere in Nominal Fen:
	say "You can go in any compass direction, but not that way." instead;

check going south in Nominal Fen (this is the block pier in endgame rule):
	if bros-left is 0:
		say "No. You don't need to go back. The brothers are gone. You're close to what you need to do." instead;

to say jc:
	say "[if silly boris is in lalaland]Mellow Marsh[else]Nominal Fen[end if]"

understand "groan collective" as jerks when allow-swears is false.

understand "mellow marsh" and "mellow/marsh" as Nominal Fen when silly boris is in lalaland.

Dandy Jim is a client. clue-letter of Dandy Jim is "J". description is "He's well dressed, but not some yuppie or preppie or anything."

Silly Boris is a client. clue-letter of Silly Boris is "L". description is "He's not laughing at you, he's laughing at the thought you might be important enough to laugh at."

Wash White is a client. clue-letter of Wash White is "T". description is "He seems to spend a good deal of time protesting what he didn't say."

Warner Dyer is a client. clue-letter of Warner Dyer is "D". description is "His favorite phrase is a knowing 'Oh, I don't know about that.'"

Warm Luke is a client. clue-letter of Warm Luke is "M". description is "Smiling a bit too wide, saying sure a bit too often."

Paul Kast is a client. clue-letter of Paul Kast is "K". description is "Dressed darkly and frowning."

Cain Reyes is a client. clue-letter of Cain Reyes is "*". description is "The loudest of the bunch."

the bottle of Quiz Pop is a thing. "The [j-co] left a bottle of Quiz Pop here.". description is "It's typical ucky brown for pop, though it is fizzing furiously. The label proclaiming it Quiz Pop reveals no nutritional information, which may be for the better. It also provides a warning that it is therapeutic for people who don't always ask the questions they want to, but people who already ask loaded questions are at risk. It's from [activation of black mark] industries."

understand "soda" as Quiz Pop

does the player mean drinking Quiz Pop: it is very likely.

after examining Quiz Pop:
	now black mark is in lalaland;
	continue the action;

to say j-co:
	say "[if allow-swears is true]jerks[else]groaners[end if]";

to say j-cap:
	say "[if allow-swears is true]Jerks[else]Groaners[end if]";

to say jc-gc:
	say "[if allow-swears is true]Jerk Circle[else]Groan Collective[end if]";

instead of giving to jerks:
	say "It'd be too hard to decide who'd actually get any gift. So, no."

the seven jerks are plural-named scenery in Nominal Fen. "[if know-jerks is true][jerk-list].[else]You can't tell who they are, and they don't offer their names.[end if]"

understand "groaners" as jerks when allow-swears is false.

know-jerks is a truth state that varies.

understand "jerk" and "jerk circle" as jerks when player is in Nominal Fen and know-jerks is false.

understand "jerk" as a client when player is in Nominal Fen and know-jerks is true.

understand "circle/heptagon" as jerks.

before talking to a client (this is the ask jerks generally first rule):
	if know-jerks is false:
		say "You feel a bit over-familiar. Maybe if you talk to all the [j-co], you'll get a formal introduction." instead;

jerk-macho-row is a number that varies. jerk-macho-yet is a truth state that varies.

before talking to jerks (this is the ask jerks generally to get their names rule):
	if finger is not examined:
		if allow-swears is false:
			say "You don't know who would be least unpleasant to talk to first. Even if you did, it'd probably be too much. Maybe if you knew more about them some other way..." instead;
		say "[one of]You mouth something, but they form a [activation of ring finger], but using THAT finger, of course[or]Without anything specific to talk about, you don't want to bug them again[stopping]. So you just listen instead.[line break]";
		try listening instead;
	if know-jerks is true:
		say "You should really pick an individual jerk to talk to, now you know their names." instead;
	say "You give a vague 'Hi, guys,' and are assailed by the [j-co] saying, geez, we have names, you know, and all that sort of thing. They are: [jerk-list].";
	now know-jerks is true instead;

groanful-wait is a number that varies.

to jerk-blab:
	if allow-swears is false:
		if groanful-wait is 0, say "[line break]Boy! The groaners sure are [activation of full grown]! I can't repeat the details, with innuendo off.";
		increment groanful-wait;
		if groanful-wait is 10, now groanful-wait is 0;
		continue the action;
	increment jerk-macho-row;
	d "Jerk dialogue: [jerk-macho-row]";
	if jerk-macho-row > number of rows in table of jerk-macho-talk:
		say "'[activation of lovelies]!' proclaims [random client in Nominal Fen]. The others agree. They then resume their...evaluations.";
		now jerk-macho-row is 0;
		continue the action;
	choose row jerk-macho-row in table of jerk-macho-talk;
	say "[macho-boast entry][line break]";
	if jerk-macho-yet is false:
		say "[line break]You have a vague suspicion they don't know as much about girls as they say they do, but if you called them on it, they'd say you didn't, either, so hypocrisy.";
		now jerk-macho-yet is true;

for writing a paragraph about a client (called jrk) in Nominal Fen:
	if cookie-eaten is true:
		say "Pfft. None of the [j-co] look like they really know what's what. If they did, they'd be the ones in charge, not the [bad-guy].";
	else if off-eaten is true:
		say "Pfft. A clique of [j-co]. Almost as boring as the [bad-guy].";
	else if greater-eaten is true:
		say "Pfft. Look at those [j-co]. They don't have the initiative the [bad-guy] does.";
	else if brownie-eaten is true:
		say "Those guys seem rough. But surely one will like you. Time to test out your newfound positivity.";
	else if finger is not examined:
		say "The seven [j-co] are too intimidating now. Even two people conversing, that's tough to break in the middle of, much less seven.";
	else:
		say "[one of]The [j-co], again. Wait a minute. Seven [j-co], talking about being cool, seven 'clients' for the Labor Child. Could it be...? You ask if they know about the Labor Child. Once it's established you hate him, they're relieved.[or]The [j-co] continue to talk about what's cool and what's not. Now that you've established a common enemy, you may want a chat. Or not.[stopping]";
	now all clients are mentioned;

to say jerk-list:
	say "[list of clients in Nominal Fen]";

last-jerk is a person that varies.

jerk-who-short is a truth state that varies.

before talking to a client (this is the successfully talk to a client rule) :
	if noun is minted:
		say "You already know [noun]'s secret. You should talk to someone else." instead;
	now jerk-who-short is true;
	now last-jerk is noun;
	try talking to generic-jerk instead;

chapter skiping

skiping is an action applying to nothing.

understand the command "skip" as something new.

understand "skip" as skiping.

carry out skiping:
	now skip-after-accuse is whether or not skip-after-accuse is false;
	say "Skipping to next jerk after accusing them is now [on-off of skip-after-accuse].";
	the rule succeeds;

section force skip on - not for release

skiponing is an action applying to nothing.

understand the command "skip on" as something new.

understand "skip on" as skiponing.

carry out skiponing:
	say "Skipping to next jerk [if skip-after-accuse is true]was already[else]is now[end if] on.";
	now skip-after-accuse is true;
	the rule succeeds;

section force skip off - not for release

skipoffing is an action applying to nothing.

understand the command "skip off" as something new.

understand "skip off" as skipoffing.

carry out skipoffing:
	say "Skipping to next jerk [if skip-after-accuse is false]was already[else]is now[end if] off.";
	now skip-after-accuse is false;
	the rule succeeds;

chapter whoing

whoing is an action applying to nothing.

understand the command "who" as something new.

understand "who" as whoing when jerk-who-short is true and silly boris is not in lalaland.

carry out whoing:
	if qbc_litany is table of jt:
		say "The [j-co], in conversational order, are:";
		let cur-jerk be last-jerk;
		repeat with X running from 1 to number of clients:
			say " [if cur-jerk is minted][i][cur-jerk] (gave mint)[r][else][cur-jerk][end if][if X is number of clients].[else],[end if]";
			now cur-jerk is next-c of cur-jerk;
	else:
		say "The [j-co]['] names are [list of clients in Nominal Fen].";
	if debug-state is true:
		repeat with CLI running through clients in nominal fen:
			say "[CLI]=[clue-letter of CLI] ";
		say "[line break]";
	the rule succeeds;

chapter numjerking

understand the command "guess" as something new.

numjerking is an action applying to one number.

understand "guess [number]" as numjerking when jerk-who-short is true and silly boris is not in lalaland and player is in Nominal Fen.

carry out numjerking:
	let z be number understood;
	if z < 1000000:
		if z > 100000 and mint is in lalaland:
			say "You gave the mint to [random minted client], but you still need to guess him. That would be digit #[mint-away], which should be [mint-guess]." instead;
		say "You need to guess all seven [j-co]." instead;
	if z > 9999999:
		say "That's too many numbers. You only need seven." instead;
	let y be z;
	let dyet be { false, false, false, false, false, false, false };
	let q be 0;
	while y > 0:
		now q is remainder after dividing y by 10;
		if q < 1 or q > 7:
			say "All digits must be between 1 and 7 inclusive." instead;
		if entry q in dyet is true:
			say "You duplicated a number in your guess. All digits must be unique." instead;
		now entry q in dyet is true;
		now y is y / 10;
	if number understood is mint-guessed-wrong:
		say "You guessed the wrong answer for [random minted client] (#[mint-away] in the sequence). You tried [onesguess], but it should be [mint-guess]." instead;
	let xyz be magic-jerk-number;
	if number understood is xyz:
		say "As you check off with each jerk, they become more and more agitated until they realize someone knows their secrets! What more could they know?";
		zap-the-jerks;
	else:
		say "The [j-co] remain unmoved after your carousing.";
		d "Should've answered [xyz].";

onesguess is a number that varies.

to decide which number is mint-away:
	let temp-jerk be last-jerk;
	let count be 1;
	while temp-jerk is not minted:
		increment count;
		now temp-jerk is next-c of temp-jerk;
	decide on count;

to decide which number is mint-guess:
	let MJ be a random minted client;
	choose row with jerky-guy of MJ in table of fingerings;
	decide on quippos of my-quip entry;

to decide whether (myguess - a number) is mint-guessed-wrong:
	let ones be 0;
	if mint is not in lalaland:
		decide no;
	let mydiv be 1000000;
	let temp-jerk be last-jerk;
	repeat with count running from 1 to 7:
		if temp-jerk is minted:
			now ones is myguess / mydiv;
			choose row with jerky-guy of temp-jerk in table of fingerings;
			now ones is the remainder after dividing ones by 10;
			[say "[temp-jerk]: ones = [myguess] / [mydiv] = [ones], should be [quippos of my-quip entry].";]
			if ones is quippos of my-quip entry:
				decide no;
			else:
				now onesguess is ones;
				decide yes;
		now mydiv is mydiv / 10;
		now temp-jerk is next-c of temp-jerk;
	say "BUG. No jerk was marked as eating the mint, but I still tried to look for one.";
	decide no;

to decide which number is magic-jerk-number:
	let myret be 0;
	let temp-jerk be last-jerk;
	repeat with count running from 1 to 7:
		choose row with jerky-guy of temp-jerk in table of fingerings;
		now myret is myret * 10;
		let temp be quippos of my-quip entry;
		increase myret by temp;
		now temp-jerk is next-c of temp-jerk;
	decide on myret;

to decide which number is quippos of (mq - a quip):
	let count be 0;
	repeat through table of jt:
		if enabled entry is 1:
			increment count;
		if response entry is mq:
			decide on count;
	decide on 0;

chapter shorting

shorting is an action out of world.

understand the command "short" as something new.

understand "short" as shorting when jerk-who-short is true and silly boris is not in lalaland.

short-jerk is a truth state that varies.

carry out shorting:
	now short-jerk is whether or not short-jerk is false;
	say "Short jerk dialogue is now [on-off of short-jerk].";
	the rule succeeds;

chapter generic jerk

generic-jerk is a privately-named person. description is "[bug]";

after doing something with generic-jerk:
	set the pronoun them to jerks;
	continue the action;

after doing something with jerks:
	set the pronoun them to jerks;
	continue the action;

litany of generic-jerk is the table of generic-jerk talk.

table of jt - generic-jerk talk
prompt	response	enabled	permit
"So, um--how's things, I guess?"	jerk-hows	1	1
"[if short-jerk is false]So, I hear you like all the vegetables, even gross ones[else]VEGGIES[end if]."	jerk-veg	0	1
"[if short-jerk is false]So, that clean comedian so popular last year? Still like him, eh[else]CLEAN JOKES[end if]?"	jerk-comedian	0	1
"[if short-jerk is false]So, hear you secretly like that lousy pro sports team[else]YOUR TEAM STINKS[end if]."	jerk-pro	0	1
"[if short-jerk is false]So, you're a little better at chess than is practical for smart kids[else]CHESS[end if]."	jerk-chess	0	1
"[if short-jerk is false]So, you definitely don't wear colored underwear. Right[else]COLORED UNDIES[end if]?"	jerk-undies	0	1
"[if short-jerk is false]So, reread [i]Anne of Green Gables[r] lately[else]GIRL BOOK EWW[end if]?"	jerk-anne	0	1
"[if short-jerk is false]So, I hear you like light music. Not just by pretty women[else]LIGHT MUSIC[end if]."	jerk-light	0	1
"[if short-jerk is false]So, you big on violent games? Or not[else]LAMER OR GAMER[end if]?"	jerk-video	0	1
"[if short-jerk is false]So, Mr. Rogers. Does he conquer the basics, or what[else]MISTER ROGERS[end if]?"	jerk-rogers	0	1
"[if short-jerk is false]So, you wouldn't be ashamed of driving a clunker[else]LAME CAR[end if]?"	jerk-car	0	1
"[if short-jerk is false]So, do women's sports really have better fundamentals[else]SPORTSWOMEN[end if]?"	jerk-wsport	0	1
"[if short-jerk is false]So, what sort of glossy magazines do you read[else]MAGAZINES[end if]?"	jerk-zines	0	1
"[if short-jerk is false]So, any classic shows you miss? Or not so classic[else]EMBARRASSING CARTOONS[end if]?"	jerk-cartoon	0	1
"[if short-jerk is false]So, you like dogs even if they're not super tough[else]WIMPY SMALL DOGS[end if]?"	jerk-dogs	0	1
"(bug the next [j-g], [next-c-x of last-jerk])"	jerk-next	0	1 [p]
"So, what about the [bad-guy]?"	jerk-baiter	1	1
"[later-or-thanks]."	jerk-bye	3	1

to say j-g:
	say "[if allow-swears is true]jerk[else]groaner[end if]"

a client has a client called next-c.

table of fin - fingerings
jerky-guy	blackmail	my-quip	suspect
Buddy Best	"dislikes no vegetables at all"	jerk-veg	0
Buddy Best	"still likes that so-last-year comedian who doesn't swear"	jerk-comedian	0
Buddy Best	"cheers for a really bad pro sports team"	jerk-pro	0
Buddy Best	"studies chess on the sly"	jerk-chess	0
Buddy Best	"may or may not wear colored underwear"	jerk-undies	0
Buddy Best	"has not only read but re-read [i]Anne of Green Gables[r]"	jerk-anne	0
Buddy Best	"enjoys light music--worse, sung by MEN"	jerk-light	0
Buddy Best	"wouldn't mind a sensible, un-flashy car in the future"	jerk-car	0
Buddy Best	"watches women's sports without ogling or negging"	jerk-wsport	0
Buddy Best	"enjoys nonviolent video games and not just because they're cheap"	jerk-video	0
Buddy Best	"prefers fashion magazines to swimsuit editions"	jerk-zines	0
Buddy Best	"uses life lessons from Mr. Rogers"	jerk-rogers	0
Buddy Best	"has a DVD of an old cartoon he 'used to' like"	jerk-cartoon	0
Buddy Best	"feels safer around smaller dogs and thinks they look nicer too"	jerk-dogs	0

table of quip texts (continued)
quip	quiptext
jerk-hows	"[last-jerk] regards you stonily. 'I'm talking with my friends here! Unless you have something REALLY important to say...'"
jerk-veg	"[innue]."
jerk-comedian	"[innue]."
jerk-pro	"[innue]."
jerk-chess	"[innue]."
jerk-undies	"[innue]."
jerk-anne	"[innue]."
jerk-light	"[innue]."
jerk-car	"[innue]."
jerk-rogers	"[innue]."
jerk-video	"[innue]."
jerk-wsport	"[innue]."
jerk-zines	"[innue]."
jerk-cartoon	"[innue]."
jerk-dogs	"[innue]."
jerk-next	"You move on to [next-c-x of last-jerk]."
jerk-baiter	"Everyone chimes in. Oh, does the [bad-guy] know his cultural references! And oh, how they respect him for knowing more culture despite the intensity of working up north in Freak Control to keep [bad-guy-2] at bay! They are pretty sure [bad-guy-2] wouldn't allow seven people to assemble in one place so freely."
jerk-bye	"[last-jerk] turns away and goes back to talking to his buddies."

to decide which client is next-c-x of (cli - a client):
	let G be next-c of cli;
	while G is befriended or G is minted:
		let G be next-c of G;
		if G is cli:
			say "(oops, bug, should not have cycled back, report to [email]) ";
			decide on cli;
	decide on G;

to say innue:
	if current quip is mint-quip:
		say "No, [random minted client] told you that's his secret. Maybe try something else";
	else:
		say "You mutter an accusation that could destroy [last-jerk]'s social life"

check going when player is in Nominal Fen:
	if room noun of Nominal Fen is not nowhere and silly boris is in Nominal Fen:
		if jerks-scared > 0:
			say "You have a sense the [j-co] may be a bit vulnerable. Stay and take them?";
			if the player yes-consents:
				say "OK." instead;
			say "The [j-co] begin talking more confidently as you leave.";

to reset-fingerings:
	repeat through table of fingerings:
		if suspect entry is not 2 and suspect entry is not -1:
			now suspect entry is 0;

to decide what number is jerks-scared:
	let temp be 0;
	repeat through table of fingerings:
		increase temp by suspect entry;
	if condition mint is in lalaland:
		now temp is temp - 2;
	decide on temp;

before talking to generic-jerk when secrets-open is true:
	say "After listening to the [j-co] for a bit, it's extra apparent who's who on the Labor Child's list. You gather them around and tell them what's up.[line break]";
	zap-the-jerks;
	the rule succeeds;

jerk-num-hint is a truth state that varies.

after talking to generic-jerk:
	if jerk-num-hint is false:
		ital-say "now that you've seen the questions, there are easier ways than plowing through the dialogues. They are listed in VERBS, but now that you know which question is which, you can type a seven-digit number such as 1234567 to guess more quickly.";
	else:
		ital-say "remember, VERBS can show you shortcut alternatives to the dialogue.";
	now jerk-num-hint is true;
	now know-jerk-opts is true;

to decide which quip is mint-quip:
	if number of minted clients is 0:
		decide on best-bye;
	let Q be a random minted client;
	repeat through table of fin:
		if jerky-guy entry is Q:
			decide on my-quip entry;
	say "((BUG) mint-quip returned nothing, please let me know)";
	decide on best-bye;

after quipping when qbc_litany is table of generic-jerk talk:
	let cq be current quip;
	if cq is mint-quip:
		continue the action;
	if current quip is jerk-hows:
		continue the action;
	if current quip is jerk-next:
		if jerk-close-listen is true:
			if jerks-scared < 2:
				say "The [j-co] sound about the same. Maybe you need to scare a couple of them in a row before they get quieter.";
			else if jerks-scared is 2:
				say "The [j-co] seem a bit quieter now.";
			else if jerks-scared is 4:
				say "The [j-co] seem very quiet now.";
		now last-jerk is next-c-x of last-jerk;
		enable the jerk-next quip;
		continue the action;
	if current quip is jerk-bye:
		if finger index is not examined:
			enable the jerk-hows quip;
		terminate the conversation;
		the rule succeeds;
	enable the cq quip;
	if current quip is a my-quip listed in table of fingerings:
		choose row with my-quip of current quip in table of fingerings;
		if jerky-guy entry is not last-jerk:
			reset-the-table;
			continue the action;
		if suspect entry is 1:
			say "[last-jerk] mutters 'I know. Shut UP, already.'[paragraph break]";
			the rule succeeds;
		now suspect entry is 1;
		check-jerks-done;
	else:
		do nothing;

wrongalong is a number that varies. wrongalong is 8.

to say snickerin:
	say "[last-jerk] snickers noncommitally[one of], and you can't tell if you were right or wrong. You never were good at judging, but maybe if you get enough accusations right, you can LISTEN and everyone will be a little quieter[or][stopping]"

to reset-the-table:
	d "WRONG!";
	say "[snickerin].";
	if jerk-close-listen is true:
		if jerks-scared >= 2:
			say "[line break]The [j-co]['] conversation ratchets back up to full volume. You must've made the wrong accusation.";
	increment wrongalong;
	if wrongalong is 10:
		say "[line break]You remember[one of][or], again,[stopping] the finger index's advice. If you push someone twice, and you're right, it may make them lash out. So you must've been wrong, there. But it can be awkward repeating yourself!";
		now wrongalong is 0;
	reset-fingerings;

skip-after-accuse is a truth state that varies.

to check-jerks-done:
	d "RIGHT!";
	say "[snickerin].";
	repeat through table of fingerings:
		[if debug-state is true:
			say "DEBUG: [jerky-guy entry] ([my-quip entry][if my-quip entry is jerky]: JERKY[end if]): [suspect entry] [if jerky-guy entry is minted]MINT[end if].";]
		if suspect entry is 0 and my-quip entry is jerky and jerky-guy entry is not minted and jerky-guy entry is not buddy best:
			if skip-after-accuse is true:
				now last-jerk is next-c-x of last-jerk;
				say "[line break]You move on to [last-jerk].";
			continue the action;
	say "[line break]The other six [j-co], fully chastened by your observations, overhear what you have to say. They pile on [last-jerk], but you mention he's not the only one.[paragraph break]";
	zap-the-jerks;
	terminate the conversation;

to zap-the-jerks:
	say "A fight's about to break out, until you tell them where you got this information from.[paragraph break]'You better be right about this,' [a random not minted client] says. They rush off. You hear whining in the distance. It's the Labor Child. He protests he was just trying to shame them into doing more practical things. They aren't buying it!";
	say "[line break]The (ex-)[j-co]s arrive back, and [a random client] [if allow-swears is true]gives an [activation of grown up][else]wipes away a [activation of tear-jerk][end if] before handing you a bottle of Quiz Pop. 'Man, you seem to know what's what, and you helped us see it was okay to be us. Here's some totally sweet contraband[if allow-swears is true]. We're out of [activation of pop cherry] but this stuff is like good for people who figure stuff out[end if].'[paragraph break]Hmm. Interesting. Quiz Pop. As they walk away, you hear them deciding on a victory meal they can now afford at the [activation of you buy]: [activation of sausage fest]. With a [activation of joint committee] to top it off!";
	it-take quiz pop;
	increment the score;
	now all clients are in lalaland;
	unlock-verb "track";
	if bros-left is 0:
		unlock-verb "notice";
	annotize jerks;

check going north when player is in Disposed Well:
	if silly boris is in lalaland:
		say "[one of]Hmm. That's odd. You hear the [j-co] in there, marveling at the depth of the Labor Child's 'business interests.' You're glad you uncovered this, but maybe you should leave the Labor Child to the [j-co] and tackle the [bad-guy] instead.[or]No, you don't need or want to go back there. The Labor Child's in for it enough, and the [j-co] are investigating rigorously.[stopping]" instead;

chapter jerk talking

part Chipper Wood

Chipper Wood is west of Nominal Fen. It is in Main Chunk. "The path cuts east-west here, the wood being too thick elsewhere. [if chase paper is in Chipper wood][say-paper][else]You can go down where the chase paper was[end if]."

to say say-paper:
	say "[one of]But this path is clear, with an odd large paper grid. It's five by five, with fainter diagonal lines too[or]The chase paper is still there, taunting you with its apparent simplicity[stopping]";

understand "grid" and "paper grid" as chase paper.

the chase paper is scenery in Chipper Wood. "Goodness knows how it sticks to the ground, but it does. You can probably GET ON it."

Rule for supplying a missing noun while entering (this is the yup paper rule):
	if player is in chipper wood and chase paper is in chipper wood:
		now the noun is the chase paper;
	else if player is in smart street:
		now the noun is broke flat;
	else if player is on the chair:
		now the noun is hatch;
	else if player is in round lounge:
		now the noun is chair;
	else if player is in disposed well:
		say "(the Truth Home)[line break]";
		now noun is scen-home;
	continue the action;

check going in chipper wood when p-c is false:
	if noun is north or noun is south:
		say "The wood's too thick that way." instead;
	if noun is inside or noun is outside:
		say "You can go east or west." instead;

after going when player was in chipper wood and Cute Percy is in chipper wood:
	say "'Not clever enough to catch me? [activation of sweetheart deal]!' Percy's taunt echos.";
	continue the action;

you-y is a number that varies. you-x is a number that varies.
ac-y is a number that varies. ac-x is a number that varies.

diag-yet is a truth state that varies.

before entering the chase paper:
	if p-c is true:
		say "You're already on." instead;
	now you-x is 6;
	now you-y is 6;
	now ac-x is 3;
	now ac-y is 6;
	now p-c is true;
	now diag-yet is false;
	now corner-yet is false;
	say "'I'll even let you cut diagonally if you want.'";
	set the pronoun it to chase paper;
	do nothing instead;

you-x is a number that varies. you-y is a number that varies.

printed name of Chipper Wood is "[if p-c is true]Chase Paper [you-x] [you-y][else]Chipper Wood[end if]"

every turn when p-c is true:
	print-the-chase;

to decide which number is x-delt:
	if you-x > ac-x, decide on you-x - ac-x;
	decide on ac-x - you-x;

to decide which number is y-delt:
	if you-y > ac-y, decide on you-y - ac-y;
	decide on ac-y - you-y;

to print-the-chase:
	let xy be x-delt + y-delt;
	if xy is 3:
		if x-delt is 3 or y-delt is 3:
			say "'I'm just one step ahead of you...'";
	else if xy <= 4 and xy > 0:
		say "'So close! Gosh, you might have to back up a little...'";
	else if xy >= 12:
		say "'Really! What ARE you doing? You're half the paper away!'";
	print-the-grid;

to print-the-grid:
	if screen-read is true:
		say "You're at [you-x], [you-y] and Percy is at [ac-x], [ac-y], ";
		if you-y > ac-y:
			say "north";
		if you-y < ac-y:
			say "south";
		if you-x < ac-x:
			say "east";
		if you-x > ac-x:
			say "west";
		say " of you[one of], with 0, 0 being in the northwest[or][stopping].";
		how-to-leave;
		continue the action;
	say "[fixed letter spacing]";
	let r1 be 0;
	let r2 be 0;
	repeat with J running from 0 to 12:
		repeat with I running from 0 to 12:
			now r1 is remainder after dividing i by 3;
			now r2 is remainder after dividing j by 3;
			if ac-x is I and ac-y is J:
				say "A";
			else if you-x is I and you-y is J:
				say "U";
			else if r1 is 0 and r2 is 0:
				say "+";
			else if r2 is 0:
				say "-";
			else if r1 is 0:
				say "|";
			else:
				say " ";
		say "[line break]";
	say "[variable letter spacing]";
	how-to-leave;

to how-to-leave:
	if p-c is true:
		say "(Type EXIT to leave the paper[if diag-yet is false]. Remember, you can move diagonally, too[end if].)[paragraph break]";

last-p-dir is a direction that varies.

to diag-check:
	if diag-yet is false:
		now diag-yet is true;
		say "You--well, walking diagonally is about as fast as walking on the paths, but the Pythagorean theorem and all means you don't quite make it to the next grid point before Percy does. Hmm.";

check going when p-c is true (this is the move on paper rule):
	now last-p-dir is noun;
	if noun is west:
		if you-x >= 3:
			now you-x is you-x - 3;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x - 3 and you-y instead;
	if noun is east:
		if you-x <= 9:
			now you-x is you-x + 3;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x + 3 and you-y instead;
	if noun is north:
		if you-y >= 3:
			now you-y is you-y - 3;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x and you-y - 3 instead;
	if noun is south:
		if you-y <= 9:
			now you-y is you-y + 3;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x and you-y + 3 instead;
	if noun is northwest:
		if you-y >= 2 and you-x >= 2:
			diag-check;
			now you-y is you-y - 2;
			now you-x is you-x - 2;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x - 2 and you-y - 2 instead;
	if noun is northeast:
		if you-y >= 2 and you-x <= 10:
			now diag-yet is true;
			now you-y is you-y - 2;
			now you-x is you-x + 2;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x + 2 and you-y - 2 instead;
	if noun is southwest:
		if you-y <= 10 and you-x >= 2:
			now diag-yet is true;
			now you-y is you-y + 2;
			now you-x is you-x - 2;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x - 2 and you-y + 2 instead;
	if noun is southeast:
		if you-y <= 10 and you-x <= 10:
			now diag-yet is true;
			now you-y is you-y + 2;
			now you-x is you-x + 2;
			move-Percy;
			see-if-caught;
		else:
			edge-warn you-x + 2 and you-y + 2 instead;
	the rule succeeds;

to edge-warn (xs - a number) and (ys - a number):
	say "You'd go off the ";
	if ys > 12:
		say "south";
	if ys < 0:
		say "north";
	if xs > 12:
		say "east";
	if xs < 0:
		say "west";
	say " of the chase paper";
	if you-x is 0 or you-y is 0 or you-x is 12 or you-y is 12:
		say ", and you're already on the ";
		if you-y is 12:
			say "south";
		if you-y is 0:
			say "north";
		if you-x is 0:
			say "west";
		if you-x is 12:
			say "east";
		say " edge";
	say ".";

to move-Percy:
	[d "[you-x] [you-y] vs [ac-x] [ac-y] [last-p-dir].";]
	if you-x is 3 and ac-x is 0 and you-y is ac-y:
		if last-p-dir is south:
			now ac-y is ac-y + 3;
		else if last-p-dir is north:
			now ac-y is ac-y - 3;
		else if ac-y is 3 or ac-y is 9:
			now ac-y is 6;
		else:
			north-or-south-rand;
		continue the action;
	if you-x is 9 and ac-x is 12 and you-y is ac-y:
		if last-p-dir is south:
			now ac-y is ac-y + 3;
		else if last-p-dir is north:
			now ac-y is ac-y - 3;
		else if ac-y is 3 or ac-y is 9:
			now ac-y is 6;
		else:
			north-or-south-rand;
		continue the action;
	if you-x is ac-x and you-y is 9 and ac-y is 12:
		if last-p-dir is west:
			now ac-x is ac-x - 3;
		else if last-p-dir is east:
			now ac-x is ac-x + 3;
		else if ac-x is 3 or ac-x is 9:
			now ac-x is 6;
		else:
			east-or-west-rand;
		continue the action;
	if you-x is ac-x and you-y is 3 and ac-y is 0:
		if last-p-dir is west:
			now ac-x is ac-x - 3;
		else if last-p-dir is east:
			now ac-x is ac-x + 3;
		else if ac-x is 3 or ac-x is 9:
			now ac-x is 6;
		else:
			east-or-west-rand;
		continue the action;
	if you-x is ac-x and you-y is ac-y:
		say "'Oops! Just missed me!'";
		if ac-y < 12:
			now ac-y is ac-y + 3;
		else if ac-x < 12:
			now ac-x is ac-x + 3;
		else if ac-y > 0:
			now ac-y is ac-y - 3;
		else:
			now ac-x is ac-x - 3;
		continue the action;
	if you-y < ac-y:
		if ac-y < 12:
			now ac-y is ac-y + 3; [move south]
		else:
			east-or-west-rand;
	else if you-y > ac-y:
		if ac-y > 0:
			now ac-y is ac-y - 3; [move north]
		else:
			east-or-west-rand;
	else if you-x > ac-x:
		if ac-x > 0:
			now ac-x is ac-x - 3; [move west]
		else:
			north-or-south-rand;
	else if you-x < ac-x:
		if ac-x < 12:
			now ac-x is ac-x + 3; [move east]
		else:
			north-or-south-rand;
	else:
		say "BUG! Percy did not move.";
	do nothing;

to east-or-west-rand:
	if ac-x is 12:
		now ac-x is 9;
	else if ac-x is 0:
		now ac-x is 3;
	else if you-x - ac-x is 3:
		now ac-x is ac-x - 3;
	else if ac-x - you-x is 3:
		now ac-x is ac-x + 3;
	else if a random chance of 1 in 2 succeeds:
		now ac-x is ac-x - 3;
	else:
		now ac-x is ac-x + 3;

to north-or-south-rand:
	if ac-y is 12:
		now ac-y is 9;
	else if ac-y is 0:
		now ac-y is 3;
	else if you-y - ac-y is 3:
		now ac-y is ac-y - 3;
	else if ac-y - you-y is 3:
		now ac-y is ac-y + 3;
	else if a random chance of 1 in 2 succeeds:
		now ac-y is ac-y - 3;
	else:
		now ac-y is ac-y + 3;

corner-yet is a truth state that varies.

to see-if-caught:
	if ac-y is you-y and ac-x is you-x:
		now p-c is false;
		print-the-grid;
		say "'Hey! You actually caught me! That's not supposed to happen. I was supposed to just cower in a corner and beg you not to hurt me. Anyway. Do report this bug at [email] or [my-repo].'";
		bye-paper;
	else if Percy-in-corner and you-near-Percy:
		now p-c is false;
		print-the-grid;
		say "You've backed Percy into a corner![paragraph break]'Okay! Okay! Don't get violent or anything!' He accuses you of not being able to take a joke.";
		bye-paper;
	else:
		if Percy-in-corner and corner-yet is false:
			say "He does love to run for the corner. If you could just get one up-and-over from him, you bet you could freeze him.";
			now corner-yet is true;

to bye-paper:
	say "[line break]As he begins rolling up the chase paper, he asks if you're one of those odd brainy types who might know how to fill up a chessboard with 31 tiles. Well, you take the opposite corners off...[paragraph break]";
	wfak;
	say "You show him the solution, and he starts yelling about how nobody could have figured that out for themselves unless they really have nothing to do with their time. 'Hm, well, that's nice and all, but knowing that doesn't make you a better PERSON, as sure as my name's Percy Wright. Or solving the even weirder puzzle below. If you can.' Percy stalks off.[paragraph break]Hey, wait, you sort of enjoy weird puzzles. Not sure if you're up for it right now, but eh, something to do if you bog down up here.";
	open-below;

to open-below:
	now Cute Percy is in lalaland;
	now chase paper is in lalaland;
	now belt below is below chipper wood;
	now chipper wood is above belt below;
	inc-max;
	annotize Cute Percy;

to decide whether Percy-in-corner:
	if ac-x is 0 and ac-y is 12:
		decide yes;
	if ac-x is 12 and ac-y is 0:
		decide yes;
	if ac-x is 0 and ac-y is 0:
		decide yes;
	if ac-x is 12 and ac-y is 12:
		decide yes;
	decide no;

to decide whether you-near-Percy:
	unless ac-x - you-x is 3 or ac-x - you-x is -3:
		decide no;
	unless ac-y - you-y is 3 or ac-y - you-y is -3:
		decide no;
	decide yes;


p-c is a truth state that varies.

Cute Percy is a baiter-aligned person in Chipper Wood. initial appearance is "[if player was in chipper wood]Cute Percy sticks his tongue out, daring you to catch him.[else][as-char][end if]"

understand "percy wright" as cute percy when cute percy is in lalaland.

description of Cute Percy is "He's--he's actually shorter and fatter than you, and that makes you sort of jealous he's better at insults than you, too. Then you think maybe he had to be, and you wonder how people treated hi... 'Geez! Quit starin['], you freak!'"

check talking to Cute Percy:
	if p-c is true:
		say "You aren't going to win a taunting war. You wonder if getting under the paper chase is really worth it. He said it wasn't NECESSARY. But he also said there might be a big help." instead;
	else:
		say "You've got no chance of winning an insult war. But maybe if you catch him on the Chase Paper...he said he might help you. Or help you get close to help. Probably the second." instead;

check going inside when player is in chipper wood and p-c is false:
	if chase paper is in Chipper wood:
		try entering chase paper instead;

to say wfk:
	wfak;
	say "[line break]";

to say as-char:
	say "[one of]You hear a rustle from behind. Someone slaps you on the left side of your neck--you look there but see no-one. Then you look right. Ah, there. You STILL hate when people do that.[paragraph break]'Hey. It's me, Cute Percy. The [activation of character assassination], cuz the [bg], err, [bad-guy], says 'You're killing me!' at my little jokes and puzzles. AC for short. Or CP. What're you? AS? Pft, that's lame. Don't worry, I could make plenty of names for you.' He tries a few, guessing your middle name is Sheldon or Steve, and you rush at him, and he snickers.[wfk]'Temper, temper. Well, if you're not a lazy quitter, there's a cheat below.'[wfk]'Cheat?'[paragraph break]'Oop! Interested, eh? Guess you're not perfectly honest. Just ENTER the chase paper and give it a try. UNLESS YOU'RE CHICKEN.'[paragraph break]You wonder why you wouldn't fall through the chase paper if there was nothing under there, but the AC probably has an annoying response for that.[no line break][or]Cute Percy springs out of nowhere again, asking whether you are too chicken to get on the chase paper or maybe you want to be lazy and cheat but you're scared you'll fail.[no line break][stopping]"

does the player mean entering the chase paper: it is likely.

understand "cp/ac/char/ass/character/assassin" and "assassin/assassination character" as Cute Percy.

part The Belt Below

There is a room called The Belt Below. It is in Main Chunk. "You're in a cylindrical sort of room where instead of walls an energy waist [if insanity terminal is in lalaland]no longer [end if]blips around[if insanity terminal is in belt]. [one of]And look, there's a sort of odd faux-retro mainframe-ish computer[or]The Insanity Terminal waits for your answer[stopping][end if]."

check going nowhere in belt below:
	say "You can only go back up[if terminal is in belt], or maybe beating the terminal will lead elsewhere[else] or down[end if]." instead;

The Insanity Terminal is scenery in the Belt Below. description is "[bug]";

understand "puzzle" as terminal when player is in belt below.

after printing the locale description when player is in belt below and belt below is unvisited:
	say "'ATTENTION RECOVERING NERDLING!' booms the terminal. 'I THE INSANITY TERMINAL HAVE A CHALLENGE FOR YOU! IF YOU SOLVE IT, KNOWLEDGE UNIMAGINABLE WILL BE YOURS AND IT WILL BE ESPECIALLY VALUABLE IF YOU ARE UNIMAGINATIVE.'";
	say "[line break]You have a look, and -- well, it's about the oddest puzzle you've ever seen.";

after printing the locale description when player is in belt below and insanity terminal is in belt below:
	set the pronoun it to insanity terminal;

jerks-spoiled is a truth state that varies.

x-term-yet is a truth state that varies.

check examining the insanity terminal:
	if x-term-yet is false:
		if screen-read is true:
			say "This may be a bit of a text dump with screen readers active. You can say X 1 through X 8, or even just type the number, to read an individual question. Would you still like to read the whole thing?";
			if the player yes-consents:
				do nothing;
			else:
				say "OK. You can still see the whole terminal if you want, and this nag won't appear again.";
			now x-term-yet is true;
			the rule succeeds;
	now x-term-yet is true;
	if jerks-spoiled is true:
		say "The terminal spits out who's 'guilty' of what, again:[line break]";
		repeat through table of fingerings:
			say "[jerky-guy entry]: [blackmail entry][line break]";
		the rule succeeds;
	if know-jerks is true:
		say "You look at the Insanity Terminal. It's big on logic puzzles, like the one you're struggling with, with the [j-co]. Maybe you could program it. Give it a shot?";
		if the player yes-consents:
			repeat through table of fingerings:
				say "[jerky-guy entry]: [blackmail entry][line break]";
			now jerks-spoiled is true;
		else:
			say "OK.";
		do nothing instead;
	if terminal is examined:
		say "You re-read the clues." instead;
	repeat through table of quiz lines:
		say "[qline entry][line break]";
	if ffffffff is false:
		say "Go FFFFFFFF at any time to disable my editorializing!";
	say "There's a cursor, and you can probably just type out the right answer on, uh, the cursor before YOU[if ever-examined-number is false]. And you can examine an individual question, too, e.g. X 2[end if]. Convenient!";
	if x-term-yet is false:
		say "You can also X 1 or just type 1 to see an individual question again.";
	now x-term-yet is true;
	the rule succeeds;

to say ps:
	say "[if screen-read is true] [else])[end if]"

table of quiz lines
qline
"1. How many times is one answer the same letter as the previous? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"2. How many letters appear in more than one right answer? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"3. The first answer with A is a[ps]1 b[ps]2 c[ps]4 d[ps]5 e[ps]7 f[ps]8"
"4. How many questions have A's as correct answers? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"5. This answer is a mirror image (A/F, B/E, C/D) of which other answer? a[ps]6 b[ps]5 c[ps]4 d[ps]3 e[ps]2 f[ps]1"
"6. The right answer to this question is a[ps]a b[ps]b c[ps]c d[ps]d e[ps]e f[ps]f"
"7. At least one of each letter is a correct answer a[ps]false b[ps]false c[ps]true d[ps]false e[ps]false f[ps]false"
"8. How many questions have vowels as correct answers? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"

chapter linereading

ever-examined-number is a truth state that varies.

linereading is an action applying to one number.

understand "x [number]" and "examine [number]" as linereading when player is in belt below and terminal is in belt below.

carry out linereading:
	let ql be number of rows in table of quiz lines;
	if the number understood < 1 or number understood > ql:
		say "The Insanity Terminal only has [ql] questions, so pick a number from 1 to [ql]." instead;
	choose row number understood in table of quiz lines;
	say "[qline entry][line break]";
	now ever-examined-number is true;
	now x-term-yet is true;
	the rule succeeds;

ffffffff is a truth state that varies.

chapter ffffffffing

ffffffffing is an action out of world.

understand the command "ffffffff" as something new.

understand "ffffffff" as ffffffffing when player is in Belt Below and Terminal is in Belt Below.

carry out ffffffffing:
	now ffffffff is whether or not ffffffff is false;
	say "Insanity Terminal heckling turned [off-on of ffffffff]";
	the rule succeeds;

chapter abadfaceing

abadfaceing is an action applying to nothing.

understand the command "abadface" as something new.
understand the command "a bad face" as something new.

understand "a bad face" as abadfaceing when player is in Belt Below.
understand "abadface" as abadfaceing when player is in Belt Below.

carry out abadfaceing:
	if jerks-spoiled is true:
		say "[one of]The Insanity Terminal emits an ultrasound squeal that brings you to your knees. It's probably mad you made it solve the [j-co] for you and doesn't believe you solved its harder puzzle on your own. Or rather, its calculations lead it to suspect cheating[or]Nah. You don't want the Terminal to squeal at you again (note: on winning, you'll get a code where you can solve the terminal the right way and see what's below)[stopping]." instead;
	if Insanity Terminal is in Belt Below:
		open-bottom;
		say "You hear a great rumbling as you put on -- well, a bad face -- and the Insanity Terminal coughs and sputters (I guess it was an [activation of terminal illness], too! That would explain its--well, as close to a mood as a computer can get) before cracking in half to reveal a tunnel further below. You feel like you could face a bad...well, you're not sure. But something bad.";
		now player has a bad face;
		now face of loss is in lalaland;
		inc-max;
		say "[line break]";
		the rule succeeds;
	else:
		say "You already solved the puzzle. If any more of [if A Great Den is visited]A Great Den[else]the floor[end if] collapsed, you might not have a way back up." instead;
	the rule succeeds;

to open-bottom:
	now A Great Den is below Belt Below;
	now Belt Below is above A Great Den;
	now Insanity Terminal is in lalaland;
	annotize insanity terminal;

chapter energy waist

The Energy Waist is scenery in the belt below. "[if insanity terminal is in lalaland]Well, it no longer blinks around, but it's just as wide as before, so you can call it a [activation of waste breath] (but it won't do any good, ha ha)[else]It blips about efficiently, you assume. You can't be sure. People have accused you of being better at electronics than you are, so you don't know the hows and whys[end if]."

instead of doing something with energy waist:
	if action is procedural, continue the action;
	say "Doing anything unusual with or to the waist is probably a bad idea."

part A Great Den

There is a room called A Great Den. It is in Main Chunk. "Wow, it's really big and impressive here, but somehow, you feel someone is watching you and laughing at you, and you don't really belong. It's not possible to go any further down, or, in fact, any direction other than up."

after printing the locale description for A Great Den:
	say "A voice in your mind says [if player has legend of stuff or player has crocked half]'Hoping for a welcome back gift? Heh.'[else if thoughts idol is in lalaland and bros-left is 0]'Really, there's no point being here...'[else if A Great Den is unvisited]'Need help, eh?'[else]'Still can't decide if you want to cheat?'";
	continue the action;

to say cheat-not-have:
	say "[if player has legend of stuff]crocked half[else]Legend of Stuff[end if]"

check going up in A Great Den:
	say "You think you hear snickering as you go up. '[if legend of stuff is in crib]Too good for[else]Shouldn't REALLY need[end if] hints, eh?'";

check going nowhere in A Great Den:
	say "You can only go back up." instead;

the notes crib is a thing in A Great Den. it is fixed in place. "[one of]A crib barred by musical notes--it must be a notes crib--[or]The notes crib [stopping]stands here. [if Legend of Stuff is in crib]It contains two small papers: a small flipbook entitled Legend of Stuff, and a crocked half[else]It's empty, now[end if]."

understand "musical notes" as notes crib. Understand "note" and "note crib" as notes crib. Understand "odd" and "odd crib" as notes crib.

description of notes crib is "[if Legend of Stuff is in crib]It contains a flipbook called Legend of Stuff and a crocked half. Each looks written on, but you can't make out what's on it[else]Nothing now[end if].".

A procedural rule while examining the notes crib: ignore the examine containers rule.

check entering crib:
	try sleeping instead;

report taking a hintable:
	say "As you take the [noun], the notes crib schlurps up the [random not carried hintable]. Well, you've still got something helpful and useful. You hope.";
	now random not carried hintable is in lalaland;
	the rule succeeds;

before examining a hintable (this is the fuzz out but hint taking rule):
	if noun is in notes crib:
		say "[if noun is crocked half]It's got a pattern on it, but you'd need to take it to see it more closely.[else]It's weird--the details shift from things you remember: that looked like the word weasel, this looked like the Stool Toad--who knows what else it'd look like if you decided to TAKE it?[end if]" instead;

section Legend of Stuff

the Legend of Stuff is a hintable. it is in the notes crib. description of Legend of Stuff is "[bug]".

Include (-
	has transparent talkable
-) when defining Legend of Stuff.

understand "flipbook" and "flip book" and "flip/book" as Legend of Stuff.

stuff-talk is a truth state that varies.

check taking legend of stuff when Thoughts Idol is in lalaland:
	say "You hear a very low voice tell you to feel very very guilty for taking the Legend of Stuff for puzzles easier than getting rid of the Thoughts Idol. A voice...like you'd expect from the Thoughts Idol. Which you just destroyed. You imagine NOT taking the Legend of Stuff and hearing the Idol also asking if you're too good to ask for help, and--well, that does it.";

check examining the Legend of Stuff:
	now x-stuff-first is true;
	try talking to the Legend of Stuff instead;

check taking the notes crib:
	say "You can take notes and maybe crib notes, but you can't take the crib." instead;

x-stuff-first is a truth state that varies.

check talking to Legend of Stuff:
	if x-stuff-first is false:
		say "'OK, show me what you've got,' you whisper.[line break]";
	now x-stuff-first is false;
	if player does not have legend of stuff:
		say "You'll need to TAKE the Legend of Stuff to look through it." instead;
	if bros-left is 0:
		if silly boris is in Nominal Fen:
			say "As you flip through the Legend of Stuff, you notice two identical pages, of a stick-figure is asking the second stick-figure the same question twice. The second response, the askee is clutching their head, a bit nervier." instead;
		say "The Legend of Stuff has nothing new to offer." instead;
	say "The Legend of Stuff seems to be in roughly three parts: a red section, a blue section, and a section as big as the other two combined. Which section do you wish to look at? Or would you like to look at them all?";
	now stuff-talk is true;
	now qbc_litany is the table of Legend of Stuff talk;
	display the qbc options;
	the rule succeeds;

table of Legend of Stuff talk
prompt	response	enabled	permit
"Red."	stuff-blood	2	1
"Blue."	stuff-soul	2	1
"Big."	stuff-big	2	1
"All."	stuff-all	2	1
"None of them."	stuff-bye	3	1

table of quip texts (continued)
quip	quiptext
stuff-blood	"You stare at the red section."
stuff-soul	"You stare at the blue section."
stuff-big	"You stare at the big section."
stuff-all	"You stare at all the sections."
stuff-bye	"Enough studying. Time for action!"

already-clued is a truth state that varies.

last-clue is a number that varies;

after quipping when qbc_litany is table of Legend of Stuff talk:
	d "OK, hinting here.";
	now red-big-clued-this-turn is false;
	if current quip is stuff-blood or current quip is stuff-all:
		hint-red;
	if current quip is stuff-soul or current quip is stuff-all:
		hint-blue;
	if current quip is stuff-big or current quip is stuff-all:
		hint-big;
	now already-clued is true;
	if current quip is stuff-bye:
		say "You close the Legend of Stuff.";
		terminate the conversation;

hints-used is a number that varies. hints-used is usually 0.

to set-clue (x - a number): [set-clue numbers are arbitrary but unique]
	if last-clue is x:
		say "You cringe [if reused-hint is true]again[else]a bit[end if] because you realize you may not have understood the last picture you saw[one of]. You almost wait for someone authoritative to tell you to stop daydreaming and flaking, but there is none. Whew[or][stopping].";
		now reused-hint is true;
	else:
		increment hints-used;
	now last-clue is x;

to hint-blue:
	if relief light is in lalaland:
		say "The blue area morphs to Brother Soul smiling for a moment.";
	else if wacker weed is off-stage:
		say "You see yourself engaged in a business transaction with someone shady.";
		set-clue 1;
	else if player has wacker weed:
		say "You see yourself giving a small package to a down and out fellow.";
		set-clue 2;
	else if poory pot is off-stage:
		say "You see yourself receiving a coin from a shady person.";
		set-clue 3;
	else if player has poory pot:
		say "You see yourself stuffing something down a vent.";
		set-clue 4;
	else if relief light is off-stage:
		say "You see yourself opening a vent.";
		set-clue 5;
	else if player has relief light:
		say "You see yourself handing a shining light to someone.";
		set-clue 6;
	else:
		say "[bug]";
	say "[line break]";

red-big-clued-this-turn is a truth state that varies.

this is the red-big-together rule:
	if red-big-clued-this-turn is true: [this is so that you don't see the same clue twice where big and blood's clues merge]
		d "Already clued, skipping.";
		the rule succeeds;
	now red-big-clued-this-turn is true;
	if questions field is unvisited:
		say "You see a facsimile of yourself exploring a bit more, turning left by three guardians.";
		set-clue 7;
		the rule succeeds;
	if the Reasoning Circular is off-stage:
		say "You see yourself in conversation in a court of law.";
		set-clue 8;
		the rule succeeds;
	if officer petty is not in lalaland:
		say "You see yourself handing a paper to a police officer.";
		set-clue 9;
		the rule succeeds;
	if money seed is off-stage:
		say "You see yourself picking a seed from a hedge.";
		set-clue 10;
		the rule succeeds;
	if player has money seed:
		say "You see yourself giving a seed to a monkey.";
		set-clue 11;
		the rule succeeds;
	now red-big-clued-this-turn is false;
	the rule fails; [in other words we didn't find a clue that applies to red and big]

to hint-red:
	if mind of peace is in lalaland:
		say "The red area morphs to Brother Blood smiling for a moment.";
		continue the action;
	consider the red-big-together rule;
	if the rule succeeded:
		continue the action;
	if player has fourth-blossom:
		say "You see yourself giving a flower to two women in clerical robes.";
		set-clue 12;
	else if player has mind of peace:
		say "You see yourself giving something lumpy and spherical to a man in red.";
		set-clue 13;
	say "[line break]";

to hint-big:
	if trade of tricks is in lalaland:
		say "The big area morphs to Brother Big smiling for a moment.";
		continue the action;
	consider the red-big-together rule;
	if the rule succeeded:
		continue the action;
	if player does not have sound safe:
		say "You see yourself picking up a big square object--a safe, maybe[if accountable hold is unvisited]. The surroundings aren't familiar[end if].";
		set-clue 14;
	else if long string is off-stage:
		say "You see yourself wandering to a place you can't identify yet.";
		set-clue 15;
	else if player does not have string:
		say "You see yourself picking up a pile of string near a large grave.";
		set-clue 16;
	else if story fish is off-stage:
		say "You see yourself dropping a long string in the well.";
		set-clue 17;
	else if art fine is not in lalaland:
		say "You see yourself playing a fish around some artwork.";
		set-clue 18;
	else if harmonic phil is not in lalaland:
		say "You see yourself opening the safe around some artwork.";
		set-clue 19;
	else if poetic wax is not in lalaland:
		say "You see yourself glopping something gooey on some sort of computer.";
		set-clue 20;
	else if trap rattle is off-stage:
		say "You see yourself giving a hat to a hopeless magician.";
		set-clue 21;
	else if trade of tricks is off-stage:
		say "You see yourself giving a rattle to a harried man.";
		set-clue 22;
	else if the player has trade of tricks:
		say "You see yourself giving a book to someone much bigger than you.";
		set-clue 23;
	else:
		say "[bug]";
	say "[line break]";

section crocked half

the crocked half is a hintable. it is in the notes crib. "A crocked half of a paper is here, ready to blow away. You'd better take it quickly, if you want it."

description of the crocked half is "It's half-a-square and seems to be torn at the bottom, as if, well, there were another part.[paragraph break][upper]"

to say stars:
	say "   *     *[line break]";

to say upper:
	if screen-read is false:
		say "The design looks like so:[paragraph break][fixed letter spacing][stars]   |\   /|[line break]   | \ / |[line break]*--*--*--*--*[line break] \ | / \ | /[line break]  \|/   \|/[line break][stars][variable letter spacing][run paragraph on]";
	else:
		say "The paper is ridged in a clear pattern--there's a straight line across, and each quarter is a leg of an isosceles right triangle: in order, below, above, above and below.[no line break]"

part Disposed Well

Disposed Well is west of Chipper Wood. It is in Main Chunk. "A crumbling well marks the center of this clearing.[paragraph break]You may go west to [if classic cult is visited]the Classic Cult[else]some sort of church[end if] or back east to the Chipper Wood. To the north, [if boris is in lalaland]the Scheme Pyramid has been closed[else if scheme pyramid is visited]the Scheme Pyramid[else]a business[end if]. [if truth home is visited]You can go back inside to the Truth Home, too[else]There's also a small home you could go inside[end if]."

check going outside from disposed well:
	say "You already are outside." instead;

scen-home is privately-named scenery in disposed well. "[if truth home is visited]There's no evidence of Sid Lew's ramblings from outside[else]It looks safe enough to go into[end if]."

understand "home" and "house" as scen-home when player is in Disposed Well.

check entering scen-home:
	try going inside instead;

instead of doing something with scen-home:
	if action is undrastic:
		continue the action;
	d "[current action].";
	if current action is entering:
		try going inside instead;
	say "You can't do much except enter or examine the home."

scen-church is privately-named scenery in disposed well. "[if truth home is visited]Faith and Grace Goode would welcome you back[else]It looks safe enough to go into[end if]."

understand "church" as scen-church.

instead of doing something with scen-church:
	if action is undrastic:
		continue the action;
	if current action is entering:
		try going west instead;
	say "You can't do much except enter or examine the church."

check going nowhere in Disposed Well:
	if noun is down:
		say "If you entered the well, it could probably be renamed the [activation of well done], because you wouldn't be [i]climbing[r] down. Or back up." instead;
	say "The wood is too thick to the south." instead;

the nine yards hole is scenery in Disposed Well. "It looks too deep to reach into, and too narrow to climb, [if story fish is off-stage]but maybe with the right tools you could fish in the darkness below and find something[else]and you doubt there's anything else in there[end if]."

check entering the yards hole:
	try going down instead;

understand "disposed/well" as the yards hole.

the story fish is a thing. description of story fish is "[if player has story fish]It looks wooden and mechanical, but you can TALK to it when you need to[else]The story fish has been stuffed into the book bank here[end if]."

instead of switching on story fish:
	try playing story fish instead;

check taking story fish:
	if player has fish:
		continue the action;
	say "No, it's happy in the compound. You're happy you put it there to get rid of Art." instead;

check putting fish on bank:
	say "'Certainly not!' says Art Fine. 'Such a vulgar thing, among so many great books?'[paragraph break]Hm. You wonder what he'd think if he actually heard the fish." instead;

check inserting it into (this is the insert it right rule):
	if noun is fish and second noun is bank:
		try putting fish on bank instead;
	if noun is long string and second noun is yards hole:
		unless story fish is off-stage:
			say "[one of]You try your luck again. Nothing. B[or]B[stopping]est go [i]expedition[r] fishing instead." instead;
		it-take story fish;
		say "You pull the string down. It seems to take forever. But you wait. You feel a pull on the string. You tug--and--yes! Your catch stays with the string! You're not surprised it's a fish, but you are when it talks--and it explains it wanted to be caught, so it could tell others its story! You suffer through ten minutes of digressions and bad grammar before the fish takes a break. 'You don't seem to be appreciating me right now. Show me someone who appreciates a story fish like me, then TALK to me.'";
		increment the score instead;
	if second noun is yards hole:
		say "That'd be a good way to lose stuff." instead;

before talking to story fish:
	if player is in truth home and Sid Lew is in truth home:
		say "'NONSENSE! FACTS, FACTS, FACTS!' roars Sid Lew. The fish clams up after the tide of abuse leaves it all at sea." instead;
	if player is in standard bog:
		say "'Eh? I--I would tell my story, but the computer wouldn't appreciate it. Manufactured stuff. Mine is ORIGINAL.'" instead;
	if player is not in Discussion Block:
		say "The fish opens a sleepy eye. 'Eh? Anyone with a [activation of fish for a compliment]? Nope, nobody artsy enough.'" instead;
	if art fine is in Discussion Block:
		say "The fish eyes you sleepily but then sees the bookshelf, then Art Fine. 'Ah! Good sir! May I begin!' The fish's story is much funnier and shorter than you expected, because Art barely lasts five minutes before he runs away screaming. 'No more [activation of babel fish]! [safety-of]!' You pat the fish on the head and put it in the Book Bank with the Long String--there, you even hid the string, so it looks extra neat.[paragraph break]"; [temproom discussion block]
		now long string is in lalaland;
		now art fine is in lalaland;
		now story fish is in Discussion Block;
		say "[if harmonic phil is in Discussion Block]Harmonic Phil snickers. 'Well, Art was smart and all, but he was getting kind of boring anyway. And he didn't know a THING about music. Maybe now I can rename this place the [activation of chamber music]...'[else]Well, that's Phil AND Art gone.[end if]"; [temproom discussion block]
		increment the score;
		annotize art fine;
		the rule succeeds;
	say "[if harmonic phil is in Discussion Block and player is in Discussion Block]Harmonic Phil hums loudly over the sound of the fish talking. You'll need to ... fish for another way to get rid of Phil.[else]'Eh? Where'd everyone go? I'll wait [']til there's a crowd to tell my story.'[end if]";
	the rule succeeds;

part Classic Cult

Classic Cult is west of Disposed Well. It is in Main Chunk. "Light OMs can be heard all over. The lighting, the decor--it's too much like a classic cult, which means it's fooling nobody, which is why you're not surprised there are only two people here, and there are no exits except back out.[paragraph break]A googly bowl rests here, [if fourth-blossom is in lalaland]full of blossoms[else]three-quarters full of blossoms[end if]."

check going nowhere in Classic Cult:
	if noun is outside:
		try going east instead;
	say "If it were an effective or popular cult, oh, the secret doors it would have! But it isn't, so it doesn't." instead;

for writing a paragraph about a person (called fgg) in Classic Cult:
	say "[one of]'Welcome. We are Faith and Grace Goode.'[or]Faith and Grace Goode stand here, basking in the awkward silence.[stopping]";
	now faith goode is mentioned;
	now grace goode is mentioned;

the blossoms are scenery in classic cult. description is "[bug]"

instead of doing something with blossoms:
	say "They're only for looking, and you think they'd make you feel some blah, but they don't. Currently they're [if fourth-blossom is in lalaland]restored[else]only covering 75% of the bowl[end if]." instead;

the googly bowl is scenery in Classic Cult. "[if fourth-blossom is in lalaland]It looks balanced, beautiful, proper.[else]It looks lopsided--one more flower or whatever in the bowl might fix that.[end if]"

check inserting fourth-blossom into googly bowl:
	say "Faith and Grace take it from you.";
	try giving fourth-blossom to faith instead;

check putting on googly bowl:
	try giving noun to faith instead;

check inserting into googly bowl:
	try giving noun to faith instead;

check taking googly bowl:
	say "It surely means more to the Goodes than to you[if fourth-blossom is in lalaland], especially now it's fixed[end if]." instead;

to get-mind:
	say "Faith and Grace place the blossom and spin it, and when it slows, the flowers are changed so you can't remember which was which. 'This is the least we can do for you. Have this mind of peace.' It's beautiful, but not gaudy.";
	now player has mind of peace;
	now fourth-blossom is in lalaland;
	set the pronoun it to googly bowl;
	increment the score;

chapter Goode Sisters

Faith Goode is a surveyable female person in Classic Cult. description is "A mirror image of Grace."

Grace Goode is a surveyable female person in Classic Cult. description is "A mirror image of Faith."

instead of doing something when second noun is faith goode:
	now second noun is grace goode;
	continue the action;

instead of doing something with faith goode:
	if action is undrastic:
		continue the action;
	else:
		now noun is grace goode;
		continue the action;

does the player mean talking to grace goode: it is very likely.
does the player mean giving to grace goode: it is very likely.

check talking to Faith:
	try talking to Grace Goode instead;

check talking to Grace:
	if fourth-blossom is in lalaland:
		say "You exchange views on inner peace, finding yourself, achievement, and so forth. She's not particularly persuasive, so you sense whatever cult she had or will have won't be charismatic or forceful enough to give anyone any crazy ideas. But you still feel better for the chat, for all that." instead;

does the player mean talking to Grace when player is in Classic Cult: it is very likely.

litany of grace is the table of Grace Goode talk.

table of gg - Grace Goode talk
prompt	response	enabled	permit
"Hi. I'm -- well, I'm looking for something. Uh, not religion."	grace-hi	1	1
"What's wrong with the googly bowl?"	grace-googly	0	1
"But if I restore your cult, won't you just indoctrinate people?"	grace-restore	0	1
"Herb?"	grace-herb	0	1
"Why did the [bad-guy] break the Googly Bowl?"	grace-baiter	0	1
"[later-or-thanks]."	grace-bye	3	1

table of quip texts (continued)
quip	quiptext
grace-hi	"'That is no matter,' they reply in unison. 'You are welcome here. Whether or not you are the one to repair our Googly Bowl. The [bad-guy] ordered it broken, and our brother [activation of good herb] performed the act and said [activation of crisis] less.'"
grace-googly	"'It only contains three of the four vital elements it needs to create transcendent happiness, or at least provide relaxing aromas, so it is useless. The [bad-guy] deemed one of few pieces of [activation of cargo cult] not completely disposable. The metaphysics would take too long to explain, but... trust us.'"
grace-herb	"'Herb says brainwashing is worse than drugs. Each gets in the way of appreciating the [bad-guy], but we are apparently more insidious.'"
grace-restore	"'We hope not. We are a bit confused. The [bad-guy] said we didn't have anything close to the proper [activation of personality cult] to be a useful [activation of cult status], but all the same, we were using unfair tactics. Really, we just sit around and enjoy classic movies or cult movies without making too many snarky comments. But that's out of favor, thanks to the [bad-guy].'"
grace-baiter	"'Well, he thinks this whole boring-nice thing is not the way to go. We don't even try to [activation of defrock]. So he said if the googly-bowl worked, which it didn't, we didn't deserve it anyway. [activation of grace period]. Something too about how people should try to make their lives almost as exciting as his, but not as exciting--that'd be like sacrilege against intellect or something. It's all a bit confusing.'"
grace-bye	"'Fare well in your journeys.'"

after quipping when qbc_litany is litany of grace:
	if current quip is grace-hi:
		superable grace-googly;
		enable the grace-herb quip;
	if current quip is grace-googly:
		if grace-restore is not talked-thru:
			enable the grace-restore quip;
	if current quip is grace-hi:
		enable the grace-baiter quip;
	if current quip is grace-bye:
		terminate the conversation;

chapter Mind of Peace

the mind of peace is a thing. description is "Looking into it, you feel calmer. Better about past put-downs or failures, whether or not you have a plan to improve. Yet you also know, if it helped you so easily, it may be better for someone who needs it even more.[paragraph break]I suppose it could also be a [activation of brain trust]. Ba ba boom."

[?? test activation of Trust Brain]

understand "trust brain" and "trust/brain" as mind of peace.

part Truth Home

Truth Home is inside of Disposed Well. It is in Main Chunk. It is only-out. "Nothing feels wrong here, but it feels incredibly uncomfortable[if sid lew is in lalaland] even with Sid Lew gone[end if]. It's also a small home, almost a [activation of whole truth], with the only exit back out."

check going nowhere in truth home:
	say "The only way out is, well, out." instead;

for writing a paragraph about a person (called arg) in Truth Home:
	say "[one of]You walk in on a one-sided argument. The louder and bigger of the two getting the most of it. 'Oh, hey,' he says. 'I'm Sid Lew. They call me the Logical Psycho [']cause I'm quick to make one point and move on to something even better. I was worried my energy's wasted on Lee over here. Maybe you, well, Lee over here, he knows boring facts, but not exciting ones. Might even be jealous of my dynamic style. Say, tell this guy, whatshisname, do they call you? C'mon, you've got a chance to SPEAK.'[line break]'Lee Bull.'[paragraph break]'No, what they call you.'[paragraph break]'The Proof Fool.'[paragraph break]'Well, with a name like Bull, well, that maybe has meanings, too, am I right? Right!'[or]Sid Lew continues to explain something Lee Bull doesn't want to hear.[stopping]";
	now Lee Bull is mentioned;
	now Sid Lew is mentioned;

chapter Sid Lew

Sid Lew is a baiter-aligned person in Truth Home. description is "He is wearing a t-shirt with an old car on it."

understand "logical/psycho" and "logical psycho" as Sid Lew.

sid-row is a number that varies.

check talking to Sid Lew:
	say "'Oh yeah, sure, I bet you have interesting questions. But I've probably heard [']em all before. And I'm giving interesting answers to questions you didn't need to know yet. You might want to just listen.' [weird-hyp]" instead;

third-sid-yet is a truth state that varies.
twothird-sid-yet is a truth state that varies.

every turn when player is in truth home and Sid Lew is in truth home:
	increment sid-row;
	if third-sid-yet is false and sid-row is number of rows in table of incisive sid viewpoints:
		say "Sid takes a brief break. 'Boy! I could deserve good money as a [activation of psychotherapy]! You've only heard the half of my advice so far!'";
		now third-sid-yet is true;
		continue the action;
	if twothird-sid-yet is false and sid-row is number of rows in table of incisive sid viewpoints:
		say "Sid coughs then warms up for a song. '[activation of pathologic], oh logic path!' He's in the home stretch of ideas, now.";
		now twothird-sid-yet is true;
		continue the action;
	if sid-row > number of rows in table of incisive sid viewpoints:
		now sid-row is 0;
		say "'[activation of ideological], logical idea, logical idea. How can you POSSIBLY disagree with me?' booms Sid. He pauses before starting again.";
		now twothird-sid-yet is false;
		now third-sid-yet is false;
		continue the action;
	else:
		choose row sid-row in table of incisive sid viewpoints;
		say "[sid-sez entry][line break]";

chapter Lee Bull

Lee Bull is a surveyable person in Truth Home. description is "When he's not trying to wave off Sid Lew's arguments, he's grabbing his head with his hands."

understand "proof fool" and "proof/fool" as Lee Bull when player is in Truth Home.

understand "read proof" as a mistake ("He gives you a look like he's been scrutinized enough, really.") when Lee Bull is in truth home and player is in truth home.

check playing the rattle:
	if player is in truth home:
		say "Sid Lew looks worried for a second, but goes on. Hm. You interrupted one of his rants, but not at the right time. Maybe someone who understood them better, but just didn't have the guts to speak back, could use the rattle. Who could that be, now." instead;
	if number of people in location of player > 1:
		say "You don't know if it's worth deliberately annoying anyone here." instead;
	say "Rattle, rattle. It gives you a headache. Maybe if you were more Type A, it'd drive you totally up the wall." instead;

check talking to Lee Bull:
	say "Before Lee Bull can talk, Sid Lew cuts in. 'Quit distracting him! Y'got anything as interesting and profound to say as me? Well, you couldn't say it right, anyhow,' he roars. 'And if you DO have somewhere I'm wrong, well, it's selfish not to let Lee find it himself. He's, like, a truthseeker or something.' [weird-hyp]" instead;

to say weird-hyp:
	say "Sid Lew's voice is weirdly hypnotic and rhythmic, for all its bluster. How to cut into it? You could never win an argument."

a thing called The Trade of Tricks is a proper-named thing. description is "[one of]You got laughed at enough for reading, much less re-reading, in middle school, so you learned to cut that nonsense out--especially books you just liked. Because it was easier to get caught if you were absorbed in a book. But this--you can't help yourself. You earned this book. You feel like the lessons may not sink in for a few days, but all the same--man! You learned a lot! And you feel like sharing.[or]You pick up a few more tricks re-reading. But you realize others may need the book even more than you.[stopping]"

understand "book" as trade of tricks when player has trade of tricks.

part Scheme Pyramid

Scheme Pyramid is north of Disposed Well. It is in Main Chunk. "A gaudy, pointy-ceilinged room with exits north and south. Everything twinkles and shines. [one of]An odd hedge[or]The Fund Hedge[stopping] drips with all forms of currency, but you [if money seed is off-stage]are probably only allowed to take the cheapest[else]already got something[end if]."

after printing the locale description for scheme pyramid when scheme pyramid is unvisited:
	set the pronoun it to fund hedge;

check going nowhere in scheme pyramid:
	if noun is outside:
		try going south instead;
	if noun is inside:
		try going north instead;
	say "This room is north-south. Maybe once the brat turns ten, he'll have a bigger office, but right now, it's only got the two exits." instead;

The Labor Child is a baiter-aligned person in Scheme Pyramid. "[one of]Some overdressed little brat walks up to you and shakes your hand. 'Are you here to work for me? I hope you have [activation of labor of love]. Not as much as me. The Labor Child. If you think you have business savvy, get a seed from the Fund Hedge.'[or]The Labor Child paces about here[one of]plotting revenge against the [activation of baby boomer] who humiliated him in pre-school[or], formulating his next business idea[one of], muttering he's outgrown his [activation of army brat]. Time to move on[or][stopping][stopping].[stopping]"

understand "kid/brat" as Labor Child.

description of Labor Child is "He's dressed in abhorrently cutesy Deal Clothes, the sort that lets pretentious little brats be bossier than adults would let [i]other[r] adults get away with[one of].[paragraph break]As you look closer, he pipes up 'People stare at me thinking it's weird I'm such a success. I stare at them thinking it's sad they're all such failures.' Brat[or][stopping]."

check talking to labor child:
	if contract is off-stage:
		say "'I'm a busy kid. Almost as busy as the [bg]. In addition to delegating all my homework I am running a business! There's startup materials in the Fund Hedge. I'm not some silly [activation of child support].'" instead;
	if player has contract:
		if contract-signed is false:
			say "'The contract! Less talk! More do!' Oh, man, there's something you'd like to DO." instead;
		say "Before you can say anything, he takes the contract.";
		try giving contract to labor child instead;
	say "'Look, I'll write you a reference if you need one.'" instead;

The Labor Child wears the Deal Clothes. description of deal clothes is "They peg the wearer as above [activation of business casual]. Whether tie or bow-tie, single-breasted or double-breasted, two- or three- piece, nobody has the courage to yell this sort of thing isn't really all that cute, especially when the wearer is a greedy little brat. Whether the clothes make them bratty or you have to be bratty to wear them, it's a depressing situation."

the fund hedge is scenery in Scheme Pyramid. "The fund hedge has other seeds like the one you took, but you really only needed one."

the money seed is a thing. description is "It's shaped like a dollar sign."

check examining the fund hedge:
	if money seed is off-stage:
		say "You notice a particularly prominent seed shaped like a dollar sign. The Labor Child pipes up, with strategically 'adorable' mispronunciations: 'Like it? I can let you have it for free...if you just take this contract here. You can sign it, or you can get someone to sign it. Then I'll let you further inside. What do you say? Yes or no, yes or no.'";
		if the player yes-consents:
			now player has money seed;
			now player has cold contract;
			say "[line break]'Now, be sure you get that contract signed, now you have it.'";
		else:
			say "'Really, you're lucky I didn't make you search through [activation of slush fund]. You didn't learn to [activation of age four] young, did you?'";
		the rule succeeds;

the cold contract is a thing. description is "All the legal jargon is nothing to sneeze at. (Sorry.)[paragraph break]The main gist is that any person [if contract-signed is false](written extensively, instead of 'party') [end if]who signs it is probably screwed if they breathe wrong, and it's their fault if they missed something or didn't have access to someone who could read all the details.[paragraph break]It is currently [if contract-signed is false]unsigned[else]signed by the Business Monkey[end if]."

after printing the name of the cold contract while taking inventory:
	say " ([if contract-signed is false]un[end if]signed)";

contract-signed is a truth state that varies.

check going inside in scheme pyramid:
	try going north instead;

check going north in scheme pyramid:
	if cold contract is off-stage:
		say "'You'll need to transact business for me, first.' The Labor Child jerks his head to the fund hedge." instead;
	if player has cold contract:
		say "'[one of][or]Again, [stopping]I'll need that signed contract first.'";
		if contract-signed is true:
			say "[line break]Oh, hey, you have it! Give it to him?";
			if the player yes-consents:
				try giving the contract to the child;
				continue the action;
			else:
				say "'Bargaining [one of][or]still [stopping]won't work on me,' the Labor Child pouts." instead;
		the rule succeeds;
	if accountable hold is unvisited:
		say "'Take the safe if you want--they sent me the wrong model. Much too small and crackable. Taking advantage of a kid like that! Well, my lawyers showed them!'";

check talking to the labor child:
	if player has cold contract:
		if contract-signed is true:
			say "The little brat snaps his fingers and points to the contract. Hand it over?";
			if the player yes-consents:
				try giving the contract to the child;
				try going north instead;
			else:
				say "'One day I'll have a classmate who's a lawyer who would squash you for that.'" instead;

part Accountable Hold

Accountable Hold is a room in Main Chunk. It is north of Scheme Pyramid. "Surprisingly barren, this room functions as a brilliant metaphor (or whatever) for the shameful lack of accountability in the business world today.".

check going nowhere in accountable hold:
	if noun is outside:
		try going south instead;
	say "You can only go outside, to the south." instead;

chapter finger index

The finger index is a thing. "[if finger index is not examined]The paper lying where the safe was is some sort of index. You can see CONFIDENTIAL written on it.[else]The finger index on the floor provides all sorts of gossip.[end if]"

after examining the finger index (this is the know what jerks are about rule) :
	repeat through table of generic-jerk talk:
		if response entry is jerk-hows:
			now enabled entry is 0;
		else if response entry is jerky or response entry is jerk-next:
			now enabled entry is 1;
	continue the action;

understand "paper" as finger index.

description of finger index is "FINGER INDEX (CONFIDENTIAL):[paragraph break][finger-say].[paragraph break]P.S. upgrade anyone who tries to tattle to the [activation of bookworm].". [temproom scheme pyramid]

check examining finger index when finger index is not examined:
	say "It looks like a list of customers--wait, no, it's a list of embarrassing secrets. The little brat!";
	if secrets-open is true:
		say "[line break]And suddenly you realize who the people are on the sheet. You maybe couldn't overhear the conversation, but you heard snatches of names and so forth. You know what this document is for, and you can deduce who's who. So you do.";

after examining finger index:
	if finger index is not examined:
		say "You can THINK to remember this information, later.";
	continue the action;

to say dia-count of (myq - a quip):
	let count be 0;
	repeat through table of jt:
		increment count;
		if response entry is myq:
			say "[count]";
			continue the action;
	say "UNDEF";

know-jerk-opts is a truth state that varies.

to say finger-say:
	let temp be 0;
	repeat through the table of fingerings:
		if jerky-guy entry is not buddy best:
			increment temp;
			say "[2da][clue-letter of jerky-guy entry][if secrets-open is true] ([jerky-guy entry])[end if] [blackmail entry][if jerky-guy entry is minted] ([jerky-guy entry])[end if]";
			if know-jerk-opts is true:
				let jconv be 0;
				say " ([temp])";
			say "[line break]";
	say "[line break]Collect hush fees every Monday. Repeating accusations breaks the guilty parties. Insanity Terminal has backup data";
	now finger index is examined;

check taking the finger index:
	say "The Labor Child would probably get upset if you took that. And he'd probably get bigger people to be upset for him, too." instead;

chapter sound safe

The Sound Safe is a thing in Accountable Hold. "[if player is in Discussion Block]The safe lies here beneath the song torch[else]A safe lies here. It doesn't look particularly heavy or secure. You hear some sound from it[end if]."

after taking Sound Safe:
	say "It's not THAT heavy. The sound magnifies when you pick it up and the door opens briefly, but nothing falls out, not even an accounts pad.[paragraph break]But what's this? Something was stuck under the safe. It's a piece of paper marked FINGER INDEX: CONFIDENTIAL.";
	now finger index is in Accountable Hold;
	the rule succeeds;

description of Sound Safe is "[if sound safe is in Discussion Block]It sits there as a memorial to Art Fine[else if safe is in accountable hold]It looks the part, but on closer inspection, you don't see how it locks. You can probably OPEN it at will[else if player has safe]It's much lighter than expected, and you can probably OPEN it at the right time[end if]."

check opening sound safe:
	if harmonic phil is in lalaland:
		say "You don't need to, again." instead;
	if player is in speaking plain:
		say "[one of]Uncle Dutch and Turk Young look momentarily shaken up! But they soon talk over the Sound Safe, congratulating each other on not getting rattled by it, unlike less practical types[or]It won't work better this time. Dutch and Turk are too goal-oriented for the safe to bother them[stopping]." instead;
	if player is not in Discussion Block:
		say "You crack it open, but it makes such a terrible noise you have to close it again. You wouldn't want to open it again unless you were around someone you really wanted to spite[if player does not have safe], and thing is, it felt a lot lighter than you thought it would as you opened it[end if]." instead;
	say "The Sound Safe makes a brutal noise in the Discussion Block, made worse by the special acoustics. Harmonic Phil covers his ears. 'Not even [activation of world record] would sell dreck like this! I can't even be clever about how this is so bad it's good!' he yells, running off. '[safety-of]!'[paragraph break]You put the safe down by the song torch."; [temproom discussion block]
	now sound safe is in Discussion Block;
	now harmonic phil is in lalaland;
	say "[line break][if art fine is in Discussion Block]Art Fine chuckles and nods approval. 'That's what you get for dabbling in art that's not intellectually robust. Perhaps this place should be [activation of shelving the thought], instead.'[paragraph break]Wow. Even before a line like that, you figured Art Fine had to go, too.[else]Well, that's Phil AND Art gone.[end if]"; [temproom discussion block]
	increment the score;
	annotize harmonic phil;
	the rule succeeds;

to say safety-of:
	say "[one of]I need the safety of the [activation of block creativity][or]It's never this rough in the [activation of block arguments][stopping]" [temproom discussion block]

check taking sound safe:
	if player is in Discussion Block:
		say "No, you like it here. Good insurance against Harmonic Phil coming back." instead;

part Speaking Plain

Speaking Plain is north of Nominal Fen. It is in Main Chunk. "Roads go in all four directions here. North seems a bit wider. West leads [if keep is visited]back to Temper Keep[else]indoors[end if]. But the main 'attraction' is [if fright stage is examined]Fright Stage[else]a huge stage[end if] in the center."

understand "treat dutch" as a mistake ("While trying to [activation of dutch treat], You get the feeling he could say, no, I'll pay for everything, blackmailing you into declining his offer and, in fact, playing even more than you intended to. And of course he wouldn't go anywhere cheap.") when player is in speaking plain and dutch is in speaking plain.

check going nowhere in speaking plain:
	if noun is inside:
		try going west instead;
	if noun is outside:
		say "You already are." instead;

The Fright Stage is scenery in Speaking Plain. "It's decorated with all manner of horrible fate for people that, you assume, messed up in life. From homelessness to getting fired to visiting a porn store on Christmas Day to just plain envying other people with more stuff or social life, it's a mural of Scared Straight for kids without the guts to do anything jail-worthy."

understand "business/show" and "business show" as Fright Stage when player is in Speaking Plain.

Turk Young is a baiter-aligned person in Speaking Plain. description is "He seems a little trimmer, a little better dressed, and a little taller than you. And of course a lot more confident. Even when he's letting Uncle Dutch speak, his furious nods indicate control. He is clearly a fellow who is Going Places, and the Fright Stage is an apprenticeship."

Uncle Dutch is a baiter-aligned person in Speaking Plain. description is "The sort of adult you used to think was just really muscular, but now that you're as tall as a lot of them, you're willing to admit it's fat. His hair looks either artificial or combed-over, his teeth disturbingly white when he talks.[paragraph break]You'd say he looked avuncular if someone twisted your arm to say it (though come to think of it, you've gotten your arm twisted for saying words like avuncular, too,) but then again, he looks like he'd hire people to do that."

to say stage-talk:
	say "He'd be intimidating enough even if he weren't up there on the Fright Stage. Between [one of]Turk and Dutch[or]Dutch and Turk[at random], you can't get a word in, anyway"

check talking to Turk Young:
	say "[stage-talk]." instead;

check talking to Uncle Dutch:
	say "[stage-talk]." instead;

dutch-blab is a number that varies.

no-dutch is a truth state that varies.

every turn when Alec Smart is in Speaking Plain and Speaking Plain was visited and Dutch is in Speaking Plain:
	if no-dutch is true:
		now no-dutch is false;
		continue the action;
	increment dutch-blab;
	if dutch-blab > number of rows in table of dutch-blab:
		now dutch-blab is 1;
		say "'THUS ENDS THE BUSINESS SHOW.' Uncle Dutch and Turk Young shout in unison before applauding each other. They then look to you and sigh when you fail to applaud. 'Despite all our flourishes, he dares insinuate it was an [activation of show off],' notes Uncle Dutch. They [activation of stand the pace] for a bit.[paragraph break][one of]You look back on all their advice and realize none of it could even conceivably help you with what you need to do, here. At least they're not stopping you from going anywhere.[or]They're going to start up again soon. But it can't be that bad the next time through.[stopping]";
	else:
		choose row dutch-blab in table of dutch-blab;
		say "[banter entry][line break]";

for writing a paragraph about a person (called udyt) in Speaking Plain:
	say "[one of]As you approach the stage, the man and the teen on it boom: 'Approach the Fright Stage with care! Uncle Dutch and Turk Young bring it hard and keep it real with the [activation of show business]! With thanks to the [bad-guy] for not arresting us yet and who will one day let us call him [bg]!'[or]Uncle Dutch and Turk Young continue spouting practical philosophy lessons.[stopping]";
	now uncle dutch is mentioned;
	now turk young is mentioned;

part Temper Keep

Temper Keep is west of Speaking Plain. Temper Keep is in Main Chunk. "[if sal-sleepy is true]Temper Keep is nice and quiet and inoffensive-smelling now. Nothing much to do except go back east[else][one of]You find yourself hyperventilating as you enter, not due to any mind control, but because--well, it stinks[or]It still sort of stinks in here[stopping]. It would stink even worse if you couldn't go back east. [say-vent][end if]."

check going nowhere in Temper Keep:
	say "You're a bit annoyed to see there are no ways out except east. But then again, you'd also be annoyed if there was more to map. Annoying." instead;

to say say-vent:
	say "[one of]You look around for the cause, and you only see a vent shaped like a spleen[or]The spleen vent catches your eye[stopping]"

Volatile Sal is a person in Temper Keep. "[if sal-sleepy is true]Volatile Sal is snoozing in a corner by [sp-vent]. It [op-jump].[else][one of]'Oh, man! [bad-guy] maybe finally sent someone to fix...' An angry looking man takes a sniff. 'You smell awful too! What is it with all these visitors? Anyway, I'm Volatile Sal. Nice to meet you. Be nicer if you smelled better.'[or]Volatile Sal paces around here anxiously, holding his nose every few seconds.[stopping][end if]"

to say op-jump:
	if jump-level is 4:
		say "even smells nice, too";
	else:
		say "does smell nicer here after your operations"

check putting pot on sal:
	try giving poory pot to sal instead;

understand "angry man" as Sal when player is in Temper Keep.

description of Volatile Sal is "[if sal-sleepy is false]Sal paces around, grabbing at his hair or clothes and waving his hands as if to rid the stink. As you glance at him, he points at YOU.[else]He's curled up, happy and relaxed, dreaming better dreams than he probably deserves to.[end if]"

sal-sleepy is a truth state that varies.

The Spleen Vent is scenery in Temper Keep. "Carved into the vent is the phrase SPLEEN VENT. A [if sal-sleepy is true]weird but pleasant aroma[else]bad stench[end if] rises from it[if relief light is off-stage]. It looks like something's glowing behind it, but you'd have to open the vent to find out[end if]."

check entering vent:
	say "You're too big, but as you imagine being small enough to explore, you muse: boy, [activation of venturesome]!" instead;

check opening vent:
	if sal-sleepy is false:
		say "Not with Sal all anxious you aren't. He'd probably yell 'VANDALISM' or whatever. But you could fit something in there." instead;
	if relief light is off-stage:
		now player has relief light;
		say "You open it and swing your arm around. Ah, there's something--the light source. It's got RELIEF scratched into it. You take it." instead;
	say "You already did. There's nothing else in there." instead;

to say sp-vent:
	say "[if spleen vent is examined]the Spleen Vent[else]a vent[end if]";

check talking to volatile sal:
	say "[if sal-sleepy is true]You don't want to risk waking him. Who knows what new faults he might find?[else]'Um, yeah, um, back up. I really don't want to smell your breath. Just in case.' He curses the [bad-guy] for both not caring about the smell here and actively being the cause of it.[end if]" instead;

check inserting it into (this is the put it in vent rule):
	if second noun is spleen vent:
		if noun is poetic wax:
			say "It might calm Sal down, but you're not sure if it would be wasted on him. Or worse, he might write some of that manic poetry that's too much for you." instead;
		if noun is wacker weed:
			say "That might calm Sal down, but how would you explain things to Pusher Penn? Perhaps a different variety of...vegetation.";
			now pot-not-weed is true instead;
		if noun is poory pot:
			now poory pot is in lalaland;
			now sal-sleepy is true;
			say "As you stuff the thin roll into the vent, it tumbles down to what you can only assume is an incinerator or air flow or something in Temper Keep's foundation you'd be better off not touching in normal circumstances.[paragraph break]The 'aromatics' of the poory pot seep into the air in Temper Keep. 'Is it just me, or is it not stinky in here? Yes! Yes! It is probably some combination of both!' You stand well out of the way as Sal continues to babble, his pseudo-philosophy becoming ever more pseudo- before...clonk. An [activation of sound asleep]. You wait a minute to make sure. Yup, he's out.";
			increment the score;
			annotize pusher penn;
			set the pronoun it to spleen vent;
			the rule succeeds;
		if noun is long string:
			say "You fish in the vent with the string, but nothing comes up." instead;
		say "That doesn't seem to fit." instead;

section relief light

The relief light is a thing. description of relief light is "It glows comfortingly. You feel happier and smarter, even if you don't understand how it works. Just looking at it and holding it makes you feel better, but maybe there's someone who needs it even more than you."

part Questions Field

Questions Field is north of Speaking Plain. It is in Main Chunk. "North is what can only be the [bad-guy]'s lair: Freak Control. You can go back south to the Speaking Plain, [if reasoning circular is not off-stage]though Buddy Best probably won't welcome you back west[else]and also you can go west to [c-house][end if]."

to say c-house:
	say "[if contempt is visited]the Court of Contempt[else]what looks like a courthouse[end if]";

qp-hint is a truth state that varies.

to say bro-i-we:
	say "[if bros-left is 1]I[else]We[end if]";

section when to block going

check going south in questions field when got-pop is true:
	say "No. You've drunk the quiz pop, and it's time to face the [bad-guy]." instead;

check going west in Questions Field:
	if Reasoning Circular is not off-stage:
		say "[one of]As you're about to enter, you hear Buddy Best raving about plans to create a whole [activation of contempt of congress], before a voice from a hidden loudspeaker booms 'Get better? Better GET!'[paragraph break]Buddy Best has seen enough of you. Hmm, come to think of it, you've seen enough of Buddy Best. You're surprised he even gave you the Reasoning Circular, and you proably couldn't explain why you [if player has circular]haven't used it yet[else]gave it to Officer Petty[end if], anyway[or]You don't want to interrupt Buddy Best's grand plans. For your sake and his[stopping]. [if player has circular]Maybe figure what to do with the Reasoning Circular he gave you[else]His Reasoning Circular helped you enough[end if]." instead;

check going nowhere in questions field:
	if noun is inside:
		say "There are two ways to go inside: north and west." instead;
	if noun is outside:
		say "You already are." instead;
	if noun is east:
		say "The path grows tangled and too intimidating. You might get lost." instead;

check going north in Questions Field:
	if bros-left > 0:
		say "[random bro in Questions Field] wags a finger dolefully. [one of]'[bro-i-we] can't let you by to see the [bad-guy]. What was his joke?' He pauses. '[bro-i-we] had ONE JOB!'[or]'[bro-i-we] have one job.'[stopping][line break]'He wasn't being cruel. He's nice once you get to know him, we hear. But if he had to be nice to too many people, it'd get diluted.'" instead;
	if cookie-eaten is true:
		say "Bye-bye, Questions Field. A question mark pops out from the side and tries to hook you out of Freak Control, but that's a stupid trap. The exclamation mark that tries to bash you? A punch disables it.";
		continue the action;
	if off-eaten is true:
		say "A question mark pops out from the side and tries to hook you, but you throw your shoulders up in exasperation just so--one arm knocks the question away, and the other deflects an exclamation mark coming from above. Weird. It's more motivation than ever just to get OUT of here, already.";
		continue the action;
	if greater-eaten is true:
		say "A question mark pops out from the side and tries to hook you, but you reflexively throw an arm and knock it out without even looking. Same for an exclamation mark from above. Yup, YOU were listening when Guy Sweet was talking.";
		continue the action;
	if brownie-eaten is true:
		say "A question mark pops out from the side and tries to hook you, and then an exclamation mark clubs you on the head. But it's soft and foamy, and you laugh a bit. 'You know,' you say, 'I need to learn to toughen up.'[paragraph break]'Dude! Someone willing to take a little hazing! It's about time!' Oh man! You've made a good first impression!";
		continue the action;
	if got-pop is false:
		now qp-hint is true;
		say "[one of]A question mark pops out from one side of the entry and hooks you back. Then an exclamation mark clubs you on the head. Dazed, you roll back. Questions ring through your head: what makes you think you deserve to confront the [bad-guy]? Or that you have any chance of success? Perhaps a minor stimulant could perk you up.[or]The ambush looms, and you don't have the confidence to deal with it yet. You need a stimulant of some sort. You know it's there, and you can't avoid it, and that's what's frustrating.[stopping]" instead;
	else:
		say "Right-o. Now you've had that quiz pop, you're not going to let any question-mark hooks or exclamation-mark clubs get to you. You can handle both. You duck instinctively, and--YES! The question mark that should've hooked your neck springs out, and the exclamation mark meant for your head whacks the question mark."

chapter Keeper Brothers

a bro is a kind of person.

to decide what number is bros-left:
	let Q be 0;
	decide on the number of stillblocking people.

definition: a person (called p) is stillblocking:
	unless p is in Questions Field, decide no;
	if p is a bro, decide yes;
	decide no;

for writing a paragraph about a person (called bro) in Questions Field:
	if jump-level < 4:
		say "[one of]Three brothers block the way ahead to the north. They're imposing, each in his own way. 'Greetings, Traveler. We are the [activation of brother's keepers]: Brother Big, Brother Blood, and Brother Soul. We must guard Freak Control, headquarters of the [bad-guy]. It is the job we are best suited for, and we are lucky the [bad-guy] has given it to us. He said we are free to do something clearly better if we can find it. We have not, yet.'[or][list of stillblocking people] block[if bros-left is 1]s[end if] your way north. '[if bros-left is 1]I'm[else]We're[end if] sorry. It's [if bros-left is 1]my[else]our[end if] job. Until [if bros-left is 1]I[else]we[end if] find a purpose.'[stopping]";
	else:
		say "The Keeper Brothers are gone now that you've jumped.";
	now brother big is mentioned;
	now brother blood is mentioned;
	now brother soul is mentioned;

section Brother Big

Brother Big is a bro in Questions Field. description is "He is a foot taller than either of his brothers, but his eyes seem duller, and he frequently scratches his head."

to check-left:
	say "[line break]";
	if bros-left is 2:
		say "The two remaining brothers look jealously at their departed companion, then beseechingly at you. Maybe you can help them, too?";
	if bros-left is 1:
		say "[random bro in Questions Field] says, 'Well. Guess one of us had to be last. But...think you could help me, too?' You're pretty sure you can.";
	if bros-left is 0:
		say "Oh, man! The way north is free now! As the final brother leaves, he turns to say 'Beware...trap...question mark...exclamation mark...'";
		unlock-verb "fancy";
		if silly boris is in lalaland:
			unlock-verb "notice";
		annotize terry sally;
		annotize fritz the on;
		annotize stool toad;
	increment the score;

litany of Brother Big is the table of Brother Big talk.

table of b1 - Brother Big talk
prompt	response	enabled	permit
"Hi. Having fun--guarding--whatever?"	big-hi	1	1
"Your duty. What's he done for you?"	big-duty	0	1
"That's sad. I wouldn't take that. Well, in theory, at least."	big-theory	0	1
"[if big-go is talked-thru]So, anything that'd give you an excuse to move on[else]Any way I could give you a reason to take a vacation[end if]?"	big-go	0	1
"What do you really think of the [bad-guy]?"	big-baiter	0	1
"What about Brother Foster?"	big-foster	0	1
"[later-or-thanks]."	big-bye	3	1

table of quip texts (continued)
quip	quiptext
big-hi	"'Not really. But it is my duty. The [bad-guy] and [bfa] dictated it.'"
big-duty	"'Well, they explained it was what I was best at. I asked what else and they laughed. Until I had to laugh. I forget why. But apparently I'm not good at laughing at myself. Despite his example, laughing at me or himself. But he always has smart stuff to say.'"
big-theory	"'It's helping me, though. I'm just not smart enough to figure out why.'"
big-go	"'Well, if you could help me feel smart. I mean, you seem smart, but I dunno if you could help me feel smart. It's like I'd like a book, not boring like a dictionary or too fluffy. But one that just helps me, you know?'"
big-baiter	"'I figure I'll appreciate him more once or if I ever get smarter. He'd help me, but he's too busy.'"
big-foster	"'[bro-fo]. I'm sure he had a clever reason for my own good.'"
big-bye	"'Good-bye.'"

after quipping when qbc_litany is litany of Brother Big:
	if current quip is big-hi:
		enable the big-duty quip;
		enable the big-baiter quip;
	if current quip is big-duty:
		enable the big-theory quip;
	if current quip is big-theory:
		enable the big-go quip;
	if current quip is big-hi:
		enable the big-baiter quip;
	if current quip is big-bye:
		terminate the conversation;

section Brother Soul

Brother Soul is a bro in Questions Field. description is "His frowning and moping make him perfect for standing guard but not much else. He might not try to stop you if you passed by just him, but you'd feel guilty for doing so."

litany of Brother Soul is the table of Brother Soul talk.

table of b2 - Brother Soul talk
prompt	response	enabled	permit
"Hi there! Why are you moping here and not somewhere more soulful?"	soul-why	1	1
"Why not get out and live? See people?"	soul-live	0	1
"Maybe there's a quick fix?"	soul-fix	0	1
"How's him being self-absorbed better than the same from you?"	soul-how	0	1
"What if I found something to help your malaise or ennui or whatever?"	soul-what-if	0	1
"What about Brother Foster?"	soul-foster	0	1
"[later-or-thanks]."	soul-bye	3	1

table of quip texts (continued)
quip	quiptext
soul-why	"'Well, it all started when [bfa] took me to the [bad-guy] to show what REAL soul was, and how he enjoyed life more, too. He said he'd give me weekly lessons and all I had to do was guard Freak Control to the north.'"
soul-live	"'The [bad-guy] made it pretty clear that's what I should do, in an ideal world, and it'd help me, but it might not help the people I got out and saw. It'd be selfish. Well, he helped me get out of Idiot Village, and apparently the rest's up to me.'"
soul-fix	"'Oh, if there was, I would've found it. And if I haven't, well, that's my own fault. For being more self-absorbed than I should be. It's totally different from the [bad-guy] being self-absorbed.'"
soul-how	"'Well, when he's self-absorbed, it's really thinking about others, because they have fun hearing him talk about himself. Me, not so much. The only quick fixes are probably illegal and unhealthy. Woe is me!'"
soul-what-if	"'Oh, it would be nice. But it would be too much to ask. Something to relieve the darkness and burden. I could never find it myself, though.'"
soul-foster	"'[bro-fo]. It made me upset.'"
soul-bye	"'Best of luck. It's nothing personal, blocking you, you know. It's not like I'm blocking you on Facebook or something.'"

after quipping when qbc_litany is litany of Brother Soul:
	if current quip is soul-why:
		enable the soul-live quip;
	if current quip is soul-live:
		enable the soul-fix quip;
	if current quip is soul-fix:
		enable the soul-how quip;
	if current quip is soul-how:
		enable the soul-what-if quip;
	if current quip is soul-bye:
		if soul-what-if is talked-thru:
			enable the soul-what-if quip;
		terminate the conversation;

section Brother Blood

Brother Blood is a bro in Questions Field. description is "He jitters with rage for a few seconds, then takes a few breaths, whispers to calm himself down, then starts over again."

litany of Brother Blood is the table of Brother Blood talk.

table of b3 - Brother Blood talk
prompt	response	enabled	permit
"Whoah, hey, you seem tense."	blood-hi	1	1
"Well, it might not be all you."	blood-maybe	0	1
"The really smart people, they can be really manipulative. I been there."	blood-manip	0	1
"Anything that might help you calm down?"	blood-calm	0	1
"Well, hey, you got through all my questions without getting mad at me. That's a start."	blood-all	0	1
"What about Brother Foster?"	blood-foster	0	1
"[later-or-thanks]."	blood-bye	3	1

table of quip texts (continued)
quip	quiptext
blood-hi	"'Yeah. Well, it started the first time Brother Foster introduced us to the [bad-guy]. He cracked a few self-depreciating jokes then gave me a few to laugh at. But I got all mad. Took a swing. He said he bet he wasn't the first I lashed out at. He was right.'"
blood-maybe	"'Maybe not, but it's ENOUGH me, you know? And the [bad-guy] said maybe some inactivity might help me. Only lash out at people who deserve it. Like trespassers trying to bug him. If I hung around smart people, I might get angry at them. So I'm sort of more useful here.'"
blood-manip	"'Yeah. The [bad-guy] says [bad-guy-2] can be even more manipulative. Makes me all agitated about what happens if I ever lose this post.'"
blood-calm	"'Well, the [bad-guy] joked that even a stupid spiritual healing stone might not help me. If those things worked at all. Which they can't. I better not believe it since he took me away from Idiot Village.'"
blood-foster	"'[bro-fo]. It made me mad.'"
blood-all	"'Yeah. Not like they were really challenging or edgy, though. I mean, it feels nice to talk and stuff but the [bad-guy] said questions like yours weren't real nitty-gritty. No offense.'"
blood-bye	"'Later. You, um, yeah, seem okay.'"

foster-yet is a truth state that varies.

to say bfa:
	say "[activation of foster brother]";
	if foster-yet is false:
		now foster-yet is true;
		choose row with response of blood-foster in table of b3;
		now enabled entry is 1;
		choose row with response of soul-foster in table of b2;
		now enabled entry is 1;
		choose row with response of big-foster in table of b1;
		now enabled entry is 1;

to say bro-fo:
	say "He left us in Idiot Village after meeting the [bad-guy]. Cause we were getting jealous of him, and all he could do, and we--he--didn't need that";
		choose row with response of blood-foster in table of b3;
		now enabled entry is 0;
		choose row with response of soul-foster in table of b2;
		now enabled entry is 0;
		choose row with response of big-foster in table of b1;
		now enabled entry is 0;

after quipping when qbc_litany is litany of Brother Blood:
	if current quip is blood-hi:
		enable the blood-maybe quip;
	if current quip is blood-maybe:
		enable the blood-manip quip;
	if current quip is blood-manip:
		enable the blood-calm quip;
	if current quip is blood-calm:
		if blood-all is not talked-thru:
			enable the blood-all quip;
	if current quip is blood-bye:
		terminate the conversation;

part Court of Contempt

Court of Contempt is west of Questions Field. It is in Main Chunk. "Boy, it's stuffy in here! You can't actually hear anyone sniffling, but you can, well, feel it. You can escape back east."

check going nowhere in Court of Contempt:
	if noun is outside:
		try going east instead;
	say "'So, you the sort of person who runs into walls a lot? Not that there's anything wrong with that.' Yup. Looks like back east's the only way out." instead;

Buddy Best is a baiter-aligned person in Court of Contempt. "[one of]But wait! Someone here looks excited to see you! Not happy, but excited.[paragraph break]'Yah. Hi. I'm Buddy Best. You seem real nice. Nice enough not to waste too much of a [if allow-swears is true]dedicated lawyerly case head, [activation of nutcase], job nut, whichever,[else][activation of attorney general][end if] like me.'[paragraph break]Okay, never mind.[paragraph break]He goes back to sorting through his case basket.[or]Buddy Best waits and taps his foot and checks his case basket here.[stopping]".

description of Buddy Best is "Sour, as if he'd just eaten--[activation of lemon law]. Or maybe it's totally a delicate balance of happiness and seriousness and not a sign of contempt, so stop saying that."

the Reasoning Circular is a thing. description is "It's full of several pages why you're great if you think you are, unless you're lame, in which case you don't know what great means. There's a long tag stapled to it."

before doing something with a long tag:
	ignore the can't give what you haven't got rule;
	if action is undrastic:
		continue the action;
	if current action is giving:
		say "(giving the Reasoning Circular instead)[line break]";
		try giving Reasoning Circular to the second noun instead;
	say "You don't need to fiddle with the tag. It's part of the Circular. Plus, it's a ticket to somewhere that might help you get rid of someone." instead;

A thing called a long tag is part of the Reasoning Circular. description is "It's stapled to the Reasoning Circular and reads:[paragraph break]By Order of the [bad-guy]:[paragraph break]The holder of this ticket is entitled, irregardless (I know, I'm being ironic and vernacular) of station or current responsibility, to visit [activation of fair enough] (you know, that place newbies won't find), a whirlwind event of social skills where the bearer learns[paragraph break][2da]1. how to yell at others to stop complaining life's not fair AND still point how it's rigged against you[line break][2da]2. Of course, not trying to be too fair. People who overdo things are the worst![line break][2da]3. Lots more, but if we wrote everything, you wouldn't need to show up. Ha ha."

litany of buddy best is the table of Buddy Best talk.

table of bb - Buddy Best talk
prompt	response	enabled	permit
"Wow, so, um, you do lawyering stuff?"	best-law	1	1
"What sort of interesting people?"	best-int	0	1
"Can you see the good side of me?"	best-good	0	1
"That's kind of corrupt, isn't it?"	best-dirty	0	1
"What do you think of the [bad-guy]?"	best-baiter	1	1
"[later-or-thanks]."	best-bye	3	1

table of quip texts (continued)
quip	quiptext
best-law	"'Brilliant deduction. Yeah. I kind of see the good side of people. Well, interesting people. They don't even have to be as interesting as [bg]. But they better be close.'"
best-int	"'Oh, you know. People who break the rules. Break [']em creatively enough to be able to afford my fees. Nobody too square. No offense.'"
best-good	"'Look, I already said I'm sure you're nice, and all. Whether or not you pick your nose too much. There. Happy with that? No? Well, I did my best. Can't do much more for ya.'"
best-dirty	"'Y'know, that's shameful coming from you. Maybe someone said you were really weird, but it turned out you were only kind of weird? I'm doing the same thing. But for criminals. I mean, suspected criminals. Look, I can't have these accusations.'"
best-baiter	"'Obviously [bg] knows what's what. We had a good long discussion on dorkery, nerdery and geekery, and how it's busted out since the Internet blew up. We can say that. We're both hip to nerd culture, but we need to keep less consequential dorks, nerds and geeks from defining the lot of us. [activation of bosom buddy]. Aggressively. He's really fair, though. He doesn't insult anyone else without insulting himself first. Just--others, well, without self-awareness.'"
best-bye	"'Not very curious of you there. I'm an interesting fella, yet you...'"

after quipping when qbc_litany is table of Buddy Best talk:
	if current quip is best-law:
		enable the best-int quip;
	if current quip is best-int:
		enable the best-good quip;
		enable the best-dirty quip;
	if current quip is best-bye or current quip is best-good or current quip is best-dirty:
		terminate the conversation;
		say "Buddy waves his hands to change the subject. 'Well, I don't want to waste any more of your time,' he says, with fake humility not meant to be convincing. You freeze.";
		wfak;
		say "[line break]'Negotiator, eh? Standing your ground? I'm sure you're nice once I get to know you even if you're not as nice as [bg] once you get to know him, but if you go I'll give you some real efficient self improvement stuff. No [activation of prosecutor]. [activation of readjust]. I'm sure you're smart enough to understand. [']Cause you probably should've understood it a few years ago. Look, I don't want to waste any more of your time.' Buddy Best throws the newsletter at you as you leave.";
		wfak;
		say "[line break]You pick it up. [i]Reasoning Circular[r]. Well, it's something. Which is more than you expected. Generally, obnoxious fast-talkers wound up taking something from YOU after a short, loud, fast dialog.";
		it-take Reasoning Circular;
		move player to Questions Field, without printing a room description;
		say "[bold type]Questions Field[paragraph break][roman type]The [if bros-left is 3]Brothers look[else if bros-left is 2]remaining Brothers look[else]remaining Brother looks[end if] unsurprised you got thrown out. Well, at least you have this...Reasoning Circular now.";
		annotize buddy best;

section case basket

the case basket is scenery in Court of Contempt. "Just looking at such an impressive office doodad, you know Buddy Best must socially and mentally with-it."

part Walker Street

Walker Street is east of Speaking Plain. It is in Main Chunk. "A huge mistake grave blocks passage south, but to the north is [if standard bog is visited]the Standard Bog[else]some swamp or something[end if], east is some sort of museum, and you can go inside [gateway-desc]. Or you can go back west to the Speaking Plain."

check going inside in walker street:
	if poory pot is in lalaland:
		say "[one of]As you walk in, Pusher Penn looks up from his plans for [activation of wood pusher], his new resort, and asks if you enjoyed your 'payment.' But your truth truth that seems even more preposterous than if you'd actually sampled the stuff. 'THE THANKS I GET!' he booms. 'DON'T COME BACK.'[or]Pusher Penn really, really doesn't want to see you. But you don't want or need to see him.[stopping]" instead;

the mistake grave is scenery in Walker Street. "It's illuminated oddly, as if a red light were flashing behind it, and reads: IN MEMORY OF [activation of watkins glen], THE IDIOT WHO WENT ONLY FIVE MILES OVER THE SPEED LIMIT AND DIDN'T HEAR THE JOYRIDERS GOING THIRTY FORTY OR FIFTY OVER THUS RUINING THIS PRIME [activation of driving crazy] ZONE FOR MORE EXCITING PEOPLE. -[bg][one of].[paragraph break]Well, the message isn't [activation of drive into the ground][or][stopping]."

check going nowhere in Walker Street:
	if noun is south:
		say "I'm afraid the Mistake Grave is a [activation of bound and determined]." instead;
	if noun is outside:
		say "If there were a red light here, it would flash to say how vague you were. Just north, east, in and west." instead;

understand "pot/chamber" and "pot chamber" as drug gateway when player is in Walker Street

to say gateway-desc:
	say "[if gateway is examined]the Drug Gateway[else]a gateway[end if] to ";
	if pot chamber is unvisited:
		say "[if gateway is not examined]somewhere seedy[else]a place your parents would want you to stay out of it[end if]";
	else:
		say "the Pot Chamber"

a long string is a thing in Walker Street. "A long string lies piled up here.". description is "It's coiled, now, but it seems pretty easy to untangle if you want to PUT it IN somewhere deep."

report taking long string:
	say "You coil the string around itself so it doesn't get too unwieldy.";
	the rule succeeds;

check entering drug gateway:
	try going inside instead;

check closing drug gateway:
	say "There's no way to close it." instead;

check opening drug gateway:
	say "It already is." instead;

Drug Gateway is scenery in Walker Street. "[one of]You look at it--a weird amalgam of swirls that don't seem to say anything. But they are captivating. Then they come together--DRUG GATEWAY. [or]Now you've seen the pattern in the Drug Gateway, you can't un-see it. [stopping]As you haven't heard any cries or gunshots, yet, it can't be too bad to enter[if pot chamber is visited] again[end if].. you think."

does the player mean entering drug gateway: it is very likely.

part Standard Bog

Standard Bog is north of Walker Street. It is in Main Chunk. "This is a pretty standard bog. It's really slimy and probably has lots of quicksand traps you can't see until it's too late, and... [one of]well, the machine off to the side is not so standard. It seems to be mumbling, trying different ways to express itself. Yes, to use language. A language machine.[or]the Language Machine, still [if wax is in lalaland]burbling poems[else]grinding out dreary sentences[end if].[stopping][paragraph break]Magical glinting witch sand makes the way north too dangerous, and law sods to the east and west  all ways back except south."

The Witch Sand is scenery in Standard Bog. "It glints with an evil magic."

The Law Sods are plural-named scenery in Standard Bog. "You have a feeling that if you tried to walk on them, you'd miss a sinkhole that should've been obvious."

check taking Witch Sand:
	try going north instead;

check taking Law Sods:
	try going east instead;

instead of doing something with law sods:
	if action is procedural, continue the action;
	say "The Law Sods are mostly there just to prevent you from going east or west. Oh, and to provide a cheap joke."

instead of doing something with Witch Sand:
	if action is procedural, continue the action;
	say "The Witch Sand is mostly there just to prevent you from going east or west. Oh, and to provide a cheap joke."

check going nowhere in standard bog:
	if noun is inside or noun is down:
		say "There's no hidden [activation of bog down], and even if there were, going there wouldn't help you." instead;
	if noun is outside:
		try going south instead;
	if noun is north:
		say "You'd starve to death before you got anywhere, even if you weren't struck by a [activation of spell disaster]disaster spell." instead;
	if noun is west or noun is east:
		say "You'd probably take the silliest false step and sink into the Law Sods. But there's nowhere to go across the sods, anyway." instead;
	say "It's really only safe to go back south." instead;

The Language Machine is scenery in Standard Bog. "The language machine hums along [if wax is in lalaland]cheerfully[else]balefully[end if], its console spewing out [if wax is in lalaland]poetry, which isn't good, but it's not overblown[else]dolorous, leaden, formulated prose about, well, being stuck in a bog[end if] in its bottom half. In the top half is an LCD [fr-sm]."

to say fr-sm:
	say "[if wax is in lalaland]smile[else]frown[end if]"

the lcd frown is part of the language machine. description is "BUG"

understand "lcd smile" and "smile" as lcd frown when wax is in lalaland.

instead of doing something with the lcd frown:
	say "The [fr-sm] is just a output of the computer's feelings. [if wax is in lalaland]You already helped it[else]You could maybe help it somehow[end if]."

check opening the language machine:
	say "It's probably too complex to tinker with." instead;

check talking to language machine:
	say "It processes your words and converts them into an [if wax is in lalaland]amusing poem[else]angsty story[end if]. But it doesn't seem to notice you, being a machine[if wax is in lalaland]. Just as well. You've done what you can[else]. Maybe there's something that can modify how it sees its input." instead;

to say no-pos:
	say "The machine is humming along and poeticizing happily. It needs no more possessions"

check inserting into the language machine:
	if poetic wax is in lalaland:
		say "[no-pos]." instead;
	try putting noun on language machine instead;

check putting on the language machine:
	if poetic wax is in lalaland:
		say "[no-pos]." instead;
	if noun is poetic wax:
		now wax is in lalaland;
		now player has trick hat;
		say "The language machine emits a few weird meeps, then the wax seeps into it. The words on the terminal change from well-organized paragraphs to clumps of four in a line. You steel yourself and read a few...";
		wfak;
		say "...and they're not that great, but they're uplifting, and if they're still cynical, they have an amusing twist or two. No more FEEL MY ENNUI stuff. If only you could've done that back when you used to write, before you got too grim...well, maybe you still can.[paragraph break]The computer prints out a map for you, of the bog. It has all the pitfalls. You walk to the end to find a bona fide trick hat--like a wizard hat but with clever facial expressions instead of stars and whatnot.[paragraph break]You stick the map back in the computer, since it's really tearing through scratch paper to write poems, and it needs all the paper it can get. It's the least you can do. You won't need to go back, and that hat seems pretty cool. In fact, a bit too cool to wear without a good reason.";
		set the pronoun it to language machine;
		increment the score instead;
	if poetic wax is in lalaland:
		say "The machine is on a roll. You don't have anything else to give to it, anyway." instead;
	if noun is story fish:
		say "[one of]The story fish moans about how it moans occasionally, but it's not as bad as that computer. You probably want to do something more positive for or to the computer[or]You don't want to annoy the story fish into moaning again[stopping]." instead;
	if noun is contract:
		say "The machine whirs and coughs. Like any machine, it's used to being told what to do, but the contract may be too restrictive." instead;
	say "The machine whirs defensively as you get close. Hm, maybe something else would work better." instead;

the Trick Hat is a thing. description is "It's covered in snarky facial expressions and all manner of light bulbs and symbols of eureka moments. You think you even see a diagram of a fumblerooski or a fake field goal if you squint right."

check wearing the trick hat:
	say "It just doesn't feel...YOU. Maybe it'd look better on someone else." instead;

part Pot Chamber

Pot Chamber is inside of Walker Street. It is in Main Chunk. It is only-out. "This is a reclusive little chamber that smells far more of incense and air freshener than any place has a right to[one of], and after a moment's thought, you realize why[or][stopping]. Any sort of incriminating equipment is probably behind secret passages you'll never find, and you can only go out again."

check going nowhere in pot chamber:
	say "The only way to go is out." instead;

section Pusher Penn

Pusher Penn is a person in Pot Chamber. description is "He looks rather ordinary, really. No beepers, no weapons, no bulge indicating a concealed weapon. You'd guess he's one of those teens adults refer to as a Fine Young American (or whatever your nationality is) who'll make good in business some day.". "[one of]'Pusher Penn, [activation of go to pot],' says someone barely older than you. 'Customer? Nah...'[or]Pusher Penn paces here.[stopping]"

check talking to Penn when player has penny:
	try giving penny to Penn instead;

understand "pen" and "pusher pen" as Pusher Penn.

litany of Pusher Penn is the table of Pusher Penn talk.

table of pp - Pusher Penn talk
prompt	response	enabled	permit
"Um, hi, what's up?"	penn-nodrugs	1	1
"Whoah, I'm, like, all in for DRUGS, BABY!"	penn-drugs	0	0
"You sell drugs? Isn't that illegal?"	penn-yousell	0	1
"Wait, isn't it all sort of bad stuff?"	penn-cigarette	0	1
"Free stuff? Wow! Sure!"	penn-free	0	1
"Herb Goode?"	penn-herb	0	1
"Changed my mind. I'll help you out with your delivery."	penn-changed	0	1
"Whoah, MAN, the COPS!"	penn-cops	0	0
"What do you think of the [bad-guy]?"	penn-baiter	1	1
"[later-or-thanks]."	penn-bye	3	1

table of quip texts (continued)
quip	quiptext
penn-nodrugs	"'Come on. You know the deal. I sell smokables. The good stuff--I'm not [activation of bum a cigarette].'"
penn-yousell	"'Well, the [bad-guy] legalized them, but he gets the markup if they buy from him. And of course he makes fun of the serious druggies, because that's seeing both sides of things. Plus, I think he deals with [bad-guy-2]. No proof, though. Eh, I make a good profit, underselling. [activation of good herb]'s rants don't hurt either. Say, if you want a little sample, I just need a small favor.'"
penn-cigarette	"'Well, I'm not pro-everything. I'm not like ... [activation of kilo]. No [activation of crack up]. And I helped raise the cigarette tax 1357%, for the public health! Plain old cigarettes are more harmful than weed, because they're less harmful. So don't let me catch you TRYING to smoke in here. What? You never have? Then what's with the sour look? I'll let it slide this time.'"
penn-drugs	--
penn-free	"'Ha ha. Well, not quite free. Just a little favor. Make a little delivery. Behind five-oh's back.'"
penn-herb	"A lot less wishy washy than his sisters. Met [']em? [if classic cult is visited]Yeah[else]No[end if]? People probably start to NOT be like him. Also, I assure my customers I won't rat them to him. For just a small markup."
penn-cops	--
penn-changed	"Pusher Penn engages in some are-you-sure-no-are-you-really-sure and then waves you off. 'Enough of this nonsense. I have a business to run.'"
penn-baiter	"'Well, we had a confidential conversation, and he says he respects my business initiative, but I better not sell to anyone who matters. The [activation of pop pills] tried to make it [activation of time capsule] all the time, but--too long a story, there.'"
penn-bye	"[if player has weed]'Get my delivery done there, now.'[else if poory is not off-stage]'Enjoy the goods!'[else]'Well, if you need to do business, let me know.'[end if]" [ok]

check talking to Pusher Penn (this is the drugs trump Penn chats rule):
	if player has wacker weed:
		say "Pusher Penn won't be happy to see you haven't made the delivery." instead;
	if poory pot is not off-stage:
		say "Pusher Penn shoos you away. You've done enough business with him." instead;

to give-weed:
	say "'Here you go. Some wacker weed. There's a fella down by the Joint Strip on the monthly deep discount plan. Didn't pick up his allotment. Forget his name, too. Always mumbling. Maybe shouldn't a given him that [activation of weed out].' You take the baggie.[paragraph break]";
	it-take wacker weed;

after quipping when qbc_litany is litany of pusher penn:
	if current quip is penn-nodrugs:
		enable the penn-yousell quip;
		enable the penn-yousell quip;
		enable the penn-drugs quip;
		enable the penn-cops quip;
	if current quip is penn-yousell:
		enable the penn-free quip;
	if current quip is penn-free:
		say "It's tempting. Do you go in for it?";
		if the player yes-consents:
			give-weed;
			disable the penn-drugs quip;
		else:
			enable the penn-changed quip;
			say "'I can wait, kid.'[paragraph break]";
	if current quip is penn-changed:
		disable the penn-drugs quip;
		say "'Here you go. Some wacker weed. Nothing special, nothing I'd trust with an experienced runner. There's a fella down by the Joint Strip on the monthly discount plan. Didn't pick up his allotment.' You take the baggie.";
		now player has wacker weed;
	if current quip is penn-bye:
		terminate the conversation;

some wacker weed is a singular-named smokable. description is "You couldn't tell if it is good or bad, really. But it needs to be delivered. It's in a baggie and everything."

understand "baggie" as wacker weed.

check opening wacker weed:
	say "Don't dip into the supply." instead;

some poory pot is a smokable. description is "Geez. You can smell it. It's a sickly sweet smell."

part Discussion Block

Discussion Block is east of Walker Street. It is in Main Chunk. "On one wall, a book bank is embedded--like a bookshelf, only tougher to extract the books. On another, a song torch. You can only go back west[if phil is in lalaland and art fine is in lalaland and poetic wax is not in discussion block]. There's not much to do here, now, except maybe page through the bank and torch's selections[end if]."

check going nowhere in discussion block:
	if noun is outside:
		try going west;
	if art is in lalaland and phil is in lalaland:
		say "No sense searching for Art or Phil or the Creativity Block. You might even get lost and stumble on the Arguments Block, which would be horrible." instead;
	if art is in lalaland or phil is in lalaland:
		say "Searching for Creativity Block, where [if art is in lalaland]Art[else]Phil[end if] went, would be counterproductive." instead;
	say "A wall that way would block stumbling. You can only go back west." instead;

to say a-p:
	say "[one of]Art[or]Phil[in random order]"

the poetic wax is in Discussion Block. "Poetic Wax, a whole ball of it, lies here behind [if number of waxblocking people is 0]where Art and Phil used to be[else][list of waxblocking people][end if]."

the indefinite article of poetic wax is "some".

after taking the poetic wax:
	say "You're worried it might melt or vanish in your hands if you think too much or too little. Poetic things are that way.[paragraph break]Fortunately, it stays firm yet pliable in your hands.";

after examining the poetic wax:
	if art-wax is not talked-thru:
		enable the art-wax quip;
	if phil-wax is not talked-thru:
		enable the phil-wax quip;
	continue the action;

description of poetic wax is "It fluctuates through many shades of grey and colors of the rainbow at once. As you look at it, words seem to appear and vanish as it swirls. It becomes whatever you want it to be, but whatever it is, it isn't quite good enough and you think, just one more adjustment...it's the most fun you've had in forever."

check taking the poetic wax:
	if number of waxblocking people > 0:
		say "'Oh, no! Certainly not! The poetic wax is a valuable intersection of music and art, one [if number of waxblocking people is 1]I still[else]we[end if] must guard from less artful people! No offense.'" instead;

definition: a person (called p) is waxblocking:
	if p is art fine or p is harmonic phil:
		if p is in discussion block:
			decide yes;
	decide no;

check going to Discussion Block for the first time:
	if jump-level < 4:
		say "[art-phil] / [art-phil] [line break]";
		wfak;
		say "The arguers turn to you and ask if you're here to deliver the new [activation of counterculture]. introduce themselves as [hi-art-phil] and [hi-art-phil]. They ask if you prefer music or books. You shrug, and they mutter you can't even [activation of creative act]. So they go back to arguing.";
		say "[line break]'[activation of play dumb]! Dumb play!' / 'Could've used a [activation of elevator music].'";
		wfak;

to say hi-art-phil:
	say "[one of]Art Fine[or]Phil Gotsche, but call me Harmonic Phil[stopping]"

to say art-phil:
	say "'[one of][activation of artifact][or][activation of philistine][in random order]' "

chapter Art Fine

Art Fine is a baiter-aligned person in Discussion Block. description is "He's wearing a shirt with a quote from an author you never read."

litany of Art Fine is the table of Art Fine talk.

table of af - Art Fine talk
prompt	response	enabled	permit
"Some place you got here!"	art-hi	1	1
"Blather like yours is the sort of thing that scared me off reading, you know."	art-pomp	0	0
"May I check out anything from the Book Bank?"	art-book	0	1
"What is your aesthetic?"	art-aes	0	1
"So, what's with wax back there?"	art-wax	0	1
"What would be totally unsuitable for this fine sanctum? Just so I can, y'know, gaffle anyone who tries before they enter."	art-tol	0	1
"What do you think of the [bad-guy]?"	art-baiter	1	1
"[later-or-thanks]."	art-bye	3	1

table of quip texts (continued)
quip	quiptext
art-hi	"'It is. Phil[if phil is off-stage], wherever he is,[end if] and I have worked hard to make it a paragon of good taste!'"
art-pomp	--
art-aes	"'Well, closed-mindedness. I'll never like that in people. But in art? Ah, I can appreciate anything. Even stuff that's so bad it's good. Especially in the presence of other aficionados. Unless it's just drivel. Of course.'"
art-book	"'This is not a library! However, if you so choose, you may marvel at the titles, record them for your pleasure, and check them out at your nearest library.' Art mumbles something about you not being able to pay the interest back with exciting criticism of your own. You're pretty sure he meant you to hear it."
art-tol	"'Drivel so dreary, from a mind so banal. I shudder to think. It would make me run screaming.'"
art-wax	"[wax-blab]"
art-baiter	"'[bg] is a top notch fellow. Such [activation of lovecraft] it's almost scary! Our aesthetics do line up, and I even suspect he is slightly more partial to me than my friend. He seeks to encourage all art, unless it could be understood by dumb people. Now, art that dumb people SHOULD be able to understand but don't, that's a different story.'"
art-bye	"[enj-splend]"

to say wax-blab:
	say "'[one of]It's not for EVERYONE. It helps with the creative process. No drugs, whatever, For poetry is an intersection of music and words, is it not[or]AS WAS ALREADY EXPLAINED, it helps with the creative process. Now I believe in progressive tax structures and all but giving sops to the untalented is really too much[stopping].'"

after quipping when qbc_litany is litany of Art Fine:
	if current quip is art-hi:
		enable the art-pomp quip;
		enable the art-book quip;
		enable the art-aes quip;
	if current quip is art-aes:
		superable art-tol;
	if current quip is art-bye:
		terminate the conversation;

chapter Harmonic Phil

Harmonic Phil is a baiter-aligned person in Discussion Block. description is "He's wearing a shirt with a band you never heard of."

understand "gotsche" and "phil gotsche" as Harmonic Phil.

litany of Harmonic Phil is the table of Harmonic Phil talk.

table of hp - Harmonic Phil talk
prompt	response	enabled	permit
"Some place you got here!"	phil-hi	1	1
"That sounded hella pompous."	phil-pomp	0	0
"What is your aesthetic?"	phil-aes	0	1
"So, what's with wax back there?"	phil-wax	0	1
"Is there anything you can't tolerate?"	phil-tol	0	1
"What do you think of the [bad-guy]?"	phil-baiter	1	1
"[later-or-thanks]."	phil-bye	3	1

[todo: phony polly and tory hiss are love interests]

table of quip texts (continued)
quip	quiptext
phil-hi	"'Indeed! Even if you do not appreciate our aesthetic fully, it cannot but rub off on you a bit. Well, not enough to make music we'd appreciate.'"
phil-pomp	--
phil-aes	"'Indeed, how can one describe an aesthetic of good music? It just is. Except when it isn't. Good music--not rubbish noise--is music that convinces me to converse about it endlessly! I'm sure I've helped create more good music that way.'"
phil-wax	"[wax-blab]"
phil-tol	"'I enjoy any music that can be shown you have to be advanced to enjoy. It engenders discussion! Intelligent discussion! In fact, I only abhor pointless, constant noise.'"
phil-baiter	"'Why, [bg]'s music criticism is even more wonderful to listen to than the music itself! Even a great piece of music remains the same, but his alternate opinions... the complexity, the variety of though. My, my! [bg]has clued me that he could not perform such mental gymnastics with mere literature. Not that there's anything wrong with it.'"
phil-bye	"[enj-splend]"

to say enj-splend:
	say "'Enjoy the splendour of our sanctum of good, but not stuffy, taste.'[no line break]";

after quipping when qbc_litany is litany of Harmonic Phil:
	if current quip is phil-hi:
		enable the phil-pomp quip;
		enable the phil-aes quip;
	if current quip is phil-aes:
		superable phil-tol;
	if current quip is phil-bye:
		terminate the conversation;

chapter book bank

the book bank is scenery in Discussion Block. "Just filled with books! And interest!"

book-ord is a number that varies.

check examining book bank for the first time:
	say "It's just filled with books! And interest! But no silly books by, say, Jerome K. Jerome.";

check examining book bank:
	increment book-ord;
	if book-ord > number of rows in table of horrendous books:
		if art fine is in Discussion Block:
			say "Art Fine sighs. While he's obviously happy to reiterate his opinions on literature, he does need to let you know how kind he is to give his wisdom for free.[paragraph break]";
		else:
			say "You go back to the start of the book bank.[paragraph break]";
		now book-ord is 1;
	choose row book-ord in the table of horrendous books;
	if Art Fine is in lalaland:
		say "Let's see. [i][workname entry][r] by [authname entry]. Looks [one of]confusing[or]baffling[or]dreadfully important[or]best-seller-ish[in random order]." instead;
	say "'Ah, yes,' drones Art Fine. '[i][workname entry][r]. A most [one of]about-everything-and-nothing-y[or]simple yet complex[or]iconic[or]transformative[or]edifying[or]scintillating[or]complex yet simple[or]zeitgeisty[in random order] read, providing you are a good reader. [authname entry]. A [one of]stirring treatise[or]vigorous discussion[or]tour de force[or]stunning perspective[at random] on [booksubj entry]. And more. [pompous-phrase]! More sensible than some jingle!'";
	the rule succeeds;

check taking book bank:
	now Steal This Book is in lalaland;
	say "You consider trying to Steal This Book, but then you picture the Stool Toad[if Judgment Pass is visited] or Officer Petty[end if] ready to [activation of steal this book]. Even without Art or Phil here to see you." instead;

to say pompous-phrase:
	say "[one of]Indeed[or]True art[or]Simple, yet complex[or]Quite so[or]Immaculate[or]Ah[or]Fascinating[or]Food for thought[in random order]"

[it--it isn't just about itself. It's about other things, too!]

section all the books

chapter song torch

a song torch is scenery in Discussion Block. "Tacky and glitzy and afire (sorry) with music you're supposed to be smart and worldly enough to appreciate, but you can't."

song-ord is a number that varies.

check examining song torch:
	increment song-ord;
	if song-ord > number of rows in table of horrendous songs:
		if harmonic phil is in Discussion Block:
			say "Harmonic Phil sighs. While he's obviously happy to reiterate his opinions on music, he does need to let you know how kind he is to give his wisdom for free.[paragraph break]";
		else:
			say "Hmm, the songs seem to be repeating.[paragraph break]";
		now song-ord is 1;
	choose row song-ord in the table of horrendous songs;
	if Harmonic Phil is in lalaland:
		say "You listen, and the song's lyrics seem to indicate it's [i][workname entry][r] by, you guess, [singername entry]. Ridiculous." instead;
	say "'Ah, yes,' drones Harmonic Phil. '[i][workname entry][r]. A most [one of]titillating[or]sense-enhancing[or]transcending[or]pure-art[or]spine-tingling[in random order] experience, providing you are a good listener. [singername entry]. Such [one of]complex melodies[or]vigorous discussion[or]a tour de force[or]stunning perspective[at random] on [songsubj entry]. And more. [pompous-phrase]! It wouldn't be the same in print!'";
	the rule succeeds;

check taking song torch:
	say "Maybe that could reduce a [activation of coals to newcastle], but you're not sure that'd be a good idea even if you found one. Plus you don't need a light source anywhere in the Compound." instead;

part Judgment Pass

Judgment Pass is east of Nominal Fen. It is in Main Chunk. "[if officer petty is in Judgment Pass][one of]A huge counter with INTUITION in block letters is, well, blocking you. Well, not fully, but by the time you snuck around the edge, the official--and fit--looking officer behind it will get in your way.[or]The intuition counter still mostly blocks your way.[stopping][else]With Officer Petty out of the way, the Intuition Counter is now just an inconvenience. You can go east and west as you please.[end if]"

check going nowhere in judgment pass:
	if noun is inside or noun is outside or noun is north or noun is south:
		say "The only passage is east-west." instead;

Officer Petty is an enforcing person in Judgment Pass. "[one of]The officer stares down at the intuition counter for a moment. 'NOPE,' he yells. 'Sure as my name's Officer Petty, no good reason for you to go to Idiot Village.'[or]Officer Petty regards you with contempt.[stopping]"

understand "coat petty" as a mistake ("Officer Petty raps on the Intuition Counter, then looks at you for a moment. 'You look like one of those closet perverts. I can't arrest you for that, but I have freedom of speech, y'know.'") when player is in Judgment Pass and Petty is in Judgment Pass.

understand "fog petty" as a mistake ("Officer Petty is more likely to talk circles around you. Perhaps you could get on his good side, somehow.") when player is in Judgment Pass and Petty is in Judgment Pass.

description of Officer Petty is "Officer Petty stares back at you, cracks his knuckles, and rubs a palm. He's bigger, stronger and fitter than you."

the Intuition Counter is scenery in Judgment Pass. "It's labeled with all manner of dire motivational phrases I'm ashamed to spell out here[if officer petty is in lalaland]. It's no longer a [activation of countermand] with Officer Petty gone[end if]."

check going east in Judgment Pass:
	if Officer Petty is in Judgment Pass:
		say "'Whoah! On the one hand, anyone who wants to go to Idiot Village, deserves to go there, no matter how smart. But on the other hand, anyone who wants to put up with Idiot Village must have a dumb reason for going there. When I'm right, I'm right, eh?'" instead;

litany of officer petty is the table of officer petty talk.

table of op - officer petty talk
prompt	response	enabled	permit
"So, how's business?"	petty-biz	1	1
"Career objectives?"	petty-career	0	1
"What's in Idiot Village?"	petty-village	0	1
"You, uh, going on break soon?"	petty-break	0	1
"So, what can I do to help law enforcement?"	petty-help	0	1
"So, what about the [bad-guy]?"	petty-baiter	1	1
"[later-or-thanks]."	petty-bye	3	1

table of quip texts (continued)
quip	quiptext
petty-biz	"'Just keeping [']em sequestered in Idiot Village. Not really where I hoped my career would go, but it's a job.'"
petty-career	"'Well, I used to enjoy just shouting at people and pushing them around, but lots of my friends have got better at that psychological stuff. I been trying, but I can't work it out.'"
petty-village	"'Smart fella like you doesn't belong there. And no offense, but you're not the sort to whip [']em into line. So I can't let you past.'"
petty-break	"'No sir, no sir, no sir!' You wonder if you should call him sir, but you'd probably lose a sir-off. 'Unless there's an official opportunity for career skills enhancement!'"
petty-help	"'Cash donations are illegal. But gifts from the goodness of your heart...'"
petty-baiter	"'The [bad-guy] had a philosophical discussion with me once. Boy, oh, boy! It was about how just because someone is boring or passive doesn't mean they're not suspicious. What an exciting discussion! He said if I kept it up I could call him [bg] one day, even!'"
petty-bye	"'Stay law-abiding and stuff, kid.'"

after quipping when qbc_litany is litany of officer petty:
	if current quip is petty-biz:
		enable the petty-career quip;
		enable the petty-village quip;
	if current quip is petty-career or current quip is petty-village:
		if petty-career is talked-thru and petty-village is talked-thru:
			enable the petty-break quip;
			superenable the petty-help quip;
	if current quip is petty-bye:
		terminate the conversation;

part Idiot Village

Idiot Village is east of Judgment Pass. It is in Main Chunk. "Idiot Village is [how-empty-iv] empty right now. It expands in all directions, though it's simplest to go back west, especially with that creepy [one of]idol[or]Thoughts Idol[stopping] staring at you east-northeast-ish. You hear a chant."

check going west in idiot village for the first time:
	say "[line break]It doesn't seem much of a [activation of village people]. Although you were able to go west, you didn't see any YMCA or place to sign up in the Navy, or even any macho man.";

to say how-empty-iv:
	say "[if business monkey is in lalaland and sly moore is in lalaland]complete[else if business monkey is in idiot village and sly moore is in idiot village]most[else]large[end if]ly"

village-explored is a truth state that varies.

last-dir is a direction that varies.

rotation is a number that varies.

check going nowhere in idiot village (this is the final idol puzzle rule):
	if thoughts idol is in lalaland:
		say "You don't need a victory lap through the Service Community now, fun as it might be." instead;
	if player has legend of stuff:
		say "The idol glares at you. Once it makes eye contact, it lowers its eyes to the Legend of Stuff. You feel a bit silly." instead;
	if insanity terminal is in lalaland or player has bad face: [really just the first but for testing the 2nd works too]
		if noun is northeast or noun is east:
			say "You run past the Thoughts Idol. Its eyes follow you. You hear a buzzing hum, then a voice in your head: 'Trying to be a star[one of][or] again[stopping]?'";
			set the pronoun it to thoughts idol;
			if noun is northeast:
				now rotation is 3;
				now last-dir is northeast;
			else:
				now rotation is 5;
				now last-dir is east;
			now idol-progress is 0;
			now thoughts idol is in Service Community;
			move player to Service Community;
			prevent undo;
			the rule succeeds;
		else if noun is inside:
			say "You have two ways inside: east or northeast." instead;
		else if noun is outside:
			try going west instead;
		say "You try that, but it seems like the idol wants a challenge. You're not sure what type, but it's got a 'come at me bro' look on its face. Maybe east or northeast...";
		the rule succeeds;
	if noun is outside:
		try going west instead;
	say "Idiot Village expands in all directions, but of course, nobody was smart enough to provide a map. OR WERE THEY CLEVER ENOUGH NOT TO GIVE INVADERS AN EASY ROUTE IN?[paragraph break]Either way, you don't want to risk getting lost, and you don't feel you can defy the Thoughts Idol right now. You'd like to, but you don't see how, yet." instead;

The Business Monkey is a neuter person in Idiot Village. "A monkey mopes around here in a ridiculous suit two sizes too large for it."

the Business Monkey wears the Ability Suit. description of suit is "It's halfway between a business suit and a monkey suit (eg a tuxedo), without capturing the intended dignity or prestige of either. Nevertheless, the Monkey does preen in it a bit[if ability suit is not examined]. It's probably an Ability Suit, if you had to guess, and hey, it's free of [activation of grease monkey], too[end if]."

description of Business Monkey is "The monkey grins happily and vacantly, occasionally adjusting its [if suit is examined]Ability Suit[else]suit[end if] or pawing in the ground."

after doing something with business monkey:
	set the pronoun him to business monkey;
	set the pronoun her to business monkey;
	continue the action;

check talking to Business Monkey:
	say "The Business Monkey[if code monkey is in conceptville] chatters in unintelligible [activation of code monkey] (of course) for a bit, then[end if] "; [the if-then is so it doesn't get repeated]
	if fourth-blossom is off-stage:
		say "opens its pockets and smiles before clawing at the dirt and making a rising-up gesture with one paw." instead;
	if contract-signed is false:
		say "pulls a pen out of its pocket, scribbles into thin air, shrugs, and puts the pen back." instead;
	say "shakes your hand, gives you a thumbs up, and snickers." instead;

the fourth-blossom is a thing. Understand "fourth/blossom" and "fourth blossom" as fourth-blossom. description is "Seen from above, it'd take up one quadrant of the four it should. It looks like it should start falling apart at any time, since it's all sliced, but somehow, it holds together despite its weird angularity."

chapter Sly Moore

Sly Moore is a surveyable person in Idiot Village. "[if talked-to-sly is true]Sly Moore[else]A would-be magician[end if] loafs about here, trying and utterly failing to perform simple magic."

description of Sly Moore is "For someone trying to do magic tricks, he's dressed rather plainly. No cape, no wand or, well, anything."

understand "magician" as sly moore.

to say sly-s:
	say "[if talked-to-sly is true]Sly Moore[else]The would-be magician[end if]"

litany of Sly Moore is the table of Sly Moore talk.

to decide whether not-conversing:
	if qbc_litany is the Table of No Conversation, decide yes;
	decide no;

every turn when player is in idiot village and sly moore is in idiot village and not-conversing:
	say "[one of][sly-s] plays a sample three-shell game, but a bean appears under each one.[or][sly-s] asks you to pick a card but then realizes the value-sides all face him.[or][sly-s] tries to palm an egg in a handkerchief, but you hear a crunch. 'Well, good thing I hollowed it out first, eh?'[or][sly-s] slaps a bunch of paperclips on some folded paper and unfolds the paper. They go flying. 'They were supposed to connect...'[or][sly-s] performs a riffle shuffle where one side of the deck of cards falls much quicker.[or][sly-s] performs a riffle shuffle that works beautifully until the last few cards fall to the ground.[or][sly-s] mumbles 'Number from one to a thousand, ten guesses, five hundred, two fifty, one twenty-five--round up or down, now? Dang, I'm stuck.'[or][sly-s] pulls out a funny flower which doesn't squirt you when he pokes it. He looks at it up close, fiddles with it and--yup. Right in his face.[or][sly-s] reaches to shake your hand, but you see the joy buzzer pretty clearly. He slaps his knee in disappointment...BZZT.[or][sly-s] looks befuddled on pulling only one handkerchief out of his pocket.[or][sly-s] cuts a paper lady in half. 'Oops. Good thing she wasn't real.'[in random order]"

talked-to-sly is a truth state that varies.

check talking to sly moore:
	if talked-to-sly is false:
		say "He introduces himself as Sly Moore.";
		now talked-to-sly is true;

table of sm - Sly Moore talk
prompt	response	enabled	permit
"How's the magic going?"	sly-magic	1	1
"How's life here in Idiot Village?"	sly-idiot	1	1
"What'd the [bad-guy] do?"	sly-bm	0	1
"Check up on what?"	sly-check	0	1
"Candidate dummy? That's harsh."	sly-dummy	0	1
"Still...geez."	sly-geez	0	1
"So did he actually try any magic tricks?"	sly-didhe	0	1
"Anything I can do to help you learn?"	sly-help	0	1
"Um, later."	sly-bye	2	1

table of quip texts (continued)
quip	quiptext
sly-magic	"'Not so good. I keep following instructions, but everything goes wrong. Not even the [bad-guy] could help me.'"
sly-idiot	"'Well, I feel dumb if I learn anything, cuz I probably should've. But I feel dumb if I don't, too.'"
sly-bm	"'Well, the [bad-guy] told me I needed to banter more. He's real good at banter. He even borrowed my magic book and assured me it was easy enough for him, and he even has the whole Problems Compound to run. Too busy to explain or check up, but hey, teaching yourself works best.'"
sly-check	"'My progress. I mean, if it's what I'd like to do and all, I'd better be good at it. Or else he might be forced to label me a [activation of candidate dummy].'"
sly-dummy	"'Oh, no! Not an actual dummy. It was sort of a warning shot. Motivation to wise up. I mean he laughed real silvery and all after he said it. Or else. But I guess I took it wrong. Because I'm too worried about it.'"
sly-geez	"'Well, I figure he's a lot harder on himself. Guess you have to be, to be the main guy dealing with [bad-guy-2]. But he said--if I can just do three things right, someone else would get the label.'"
sly-didhe	"'That's kind of unfair to him, isn't it? I mean, he's busy running the place. And dealing with [bad-guy-2]. Magic tricks won't help against that guy.'"
sly-help	"'Well, I could maybe use part of a costume. Or study tips. Or something that does both. Help me score three different routines.'"
sly-bye	"'Later.'"

check putting trick hat on a person:
	try giving noun to the second noun instead;

after quipping when qbc_litany is litany of Sly Moore:
	if current quip is sly-magic:
		enable the sly-bm quip;
	if current quip is sly-bm:
		enable the sly-help quip;
		enable the sly-didhe quip;
		enable the sly-check quip;
	if current quip is sly-check:
		now candidate dummy is in lalaland;
		enable the sly-dummy quip;
	if current quip is sly-dummy:
		enable the sly-geez quip;
	if current quip is sly-bye:
		if sly-help is talked-thru:
			enable the sly-help quip;
		terminate the conversation;

chapter trap rattle

the trap rattle is a thing. description is "It's tough to hold on to. It constantly seems to be trying to bite you, but if you try to clip it to your clothes, it doesn't even try to catch. You sense there's some logic to how it works, but you can't quite figure it out."

chapter service memorial

The service memorial is scenery. "It's made up of rubble from the Thoughts Idol, with snarky messages like '[activation of serve you right]!'"

part Service Community

a direction has a number called orientation. the orientation of a direction is usually -1.

orientation of north is 0.
orientation of northeast is 1.
orientation of east is 2.
orientation of southeast is 3.
orientation of south is 4.
orientation of southwest is 5.
orientation of west is 6.
orientation of northwest is 7.

[ 5E  3NE
 70   01
 6  1 7  2
 5  2 6  3
  43   54]

the thoughts idol is scenery in Idiot Village. "[if player is in idiot village][iv-idol][else]If you look too long back at the Thoughts Idol now, it may distract you. You know it's [idol-dir]. Gotta keep running, somehow, somewhere[end if]."

check entering idol:
	if terminal is in lalaland and player does not have legend of stuff:
		say "That'd probably make for a really gruesome end, if you could, which you can't. But you're possessed by the temptation to tease it, to make it so you're almost willing to, just to annoy it." instead;
	say "No way. You can't even get near it." instead;

before talking to idol:
	say "It's not a [activation of idle gossip]. And even if you had something profoundly defiant to say, it would probably stare you down quickly." instead;

stared-idol is a truth state that varies.

to say iv-idol:
	if player has Legend of Stuff:
		say "The idol stares back at you and seems to shake its head slightly. You look down guiltily at the Legend of Stuff[no line break]";
		continue the action;
	say "You stare at the thoughts idol, [if player has bad face]and as it glares back, you resist the urge to look away. It--it actually blinks first. You wonder if you could run by it and see more of Idiot Village[else]but it stares back at you. You lose the war of facial expressions[end if]";
	if player has bad face:
		now stared-idol is true;

the Service Community is a room in Main Chunk. "Idiot Village's suburbs stretch every which way, including diagonal directions! The Thoughts Idol surveys you from the [idol-dir]. You just came from the [opposite of last-dir]."

to say idol-dir:
	let id be idol-progress;
	if rotation is 3:
		now id is 6 - id;
	if id is 0 or id is 3:
		say "west";
	else if id is 2 or id is 5:
		say "north";
	else if id is 1 or id is 6:
		say "south";
	else:
		say "east";
	say " and a bit ";
	if id is 0:
		say "north";
	else if id <= 2:
		say "east";
	else if id <= 4:
		say "south";
	else:
		say "west";

idol-progress is a number that varies.

idol-fails is a number that varies.

cur-dir is a direction that varies.

best-idol-progress is a number that varies.

check going in service community:
	if orientation of noun is -1:
		if noun is up or noun is down:
			say "There's nothing to climb or descend in the Service Community. 'Just' the eight basic compass directions." instead;
		if noun is inside:
			say "You don't have time to visit anyone. There are too many homes to choose from!" instead;
		if noun is outside:
			say "You don't want to just QUIT. Run any which way. Give it a shot." instead;
		say "That has no meaning here.";
		the rule succeeds;
		say "You need to go in a compass direction." instead;
	now cur-dir is noun;
	let q be orientation of noun - orientation of last-dir;
	if q < 0:
		now q is q + 8;
	if q is rotation:
		increment idol-progress;
		choose row idol-progress in the table of idol text;
		say "[good-text entry][line break]";
		now last-dir is noun;
		prevent undo;
		if idol-progress is 7:
			now bad face is in lalaland;
			now player has lifted face;
			now thoughts idol is in lalaland;
			now service memorial is in service community;
			move player to idiot village, without printing a room description;
			move crocked half to lalaland;
			inc-max;
			annotize thoughts idol;
			say "[line break][bold type]Back at Idiot Village[roman type][line break]";
		the rule succeeds;
	else:
		move thoughts idol to idiot village;
		d "idol-off = [idol-off], cur-dir = [orientation of cur-dir], last-dir = [orientation of last-dir], rotation = [rotation].";
		choose row idol-off in table of idol smackdowns;
		say "[smackdown entry][line break]";
		choose row idol-progress + 1 in the table of idol text;
		say "[line break][bad-text entry][line break]";
		if idol-progress < best-idol-progress:
			say "Rats. You did better and lasted longer before. Maybe you can repeat that and do a little better next time.";
		else:
			if idol-progress > best-idol-progress and best-idol-progress > 0:
				say "It stinks you got caught, but you had your best run yet. Maybe next time.";
			now best-idol-progress is idol-progress;
		increment idol-fails;
		now idol-progress is 0;
		now player is in idiot village;
		prevent undo;
		the rule succeeds;

to decide which number is idol-off:
	let temp be rotation - (orientation of cur-dir - orientation of last-dir);
	if rotation is 3:
		now temp is 0 - temp;
	while temp < 0:
		now temp is temp + 8;
	while temp > 8:
		now temp is temp - 8;
	decide on temp;

to say to-away:
	if debug-state is true:
		say "[idol-off]";
	say "[if idol-off < 5]away from[else]towards[end if]"

to say back-along:
	if debug-state is true:
		say "[idol-off]";
	say "[if idol-off < 5]along[else]back[end if]"

to say rt-idol:
	say "You make a right turn [if idol-off is 7]towards[else]away from[end if] the idol, but an audible whirr makes you look up. When you stop, it's already looking where you meant to go. It locks down a stare. You've gotten that before. You feel compelled to head back to Idiot Village under its gaze"

to say zz-idol:
	say "You zigzag [if idol-off is 6]along[else]back[end if], making the idol wheeze a good bit. You look back, and the idol's just finished turning its head, then. The stare. The embarrassment. Wondering what you were trying to DO, anyway, REALLY"

to say idol-straight-away:
	say "You try running and running away, but (not so) eventually you have to turn around to see how much you're being watched, and the idol seems to be staring extra hard at you when you look back as if to say you can't run and that only makes it worse"

table of idol smackdowns
smackdown
"You feel particularly helpless running back and forth. The idol shakes its head, as if to let you know that just won't do, and it's tired of telling lesser things, or people, or whatever, that." [3, backwards]
"You make a sharp zigzag, but somehow, the idol was ready for it. You dance back and forth, and the idol shakes its head at you. You stare at the ground and plod back to Idiot Village." [2]
"[rt-idol]." [3]
"[zz-idol]." [4]
"[idol-straight-away]." [5]
"[zz-idol]." [6]
"[rt-idol]." [7]

chapter community text

rule for deciding whether to allow undo:
	if undo is prevented:
		if player is in idiot village:
			say "[if thoughts idol is in lalaland]No, you did it right. No need to relive past victories[else]You kick yourself for doing something wrong, but ... well, the idol didn't kill you or anything. You can try again.";
			deny undo;
		if player is in service community:
			say "You're worried you might've messed up, but no, the Idol would've gotten you, then. Need to keep going on.";
			deny undo;

table of idol text
good-text	bad-text	undo-text
"The thoughts idol whizzes around to track you, quicker as you get close, slower as you get near, and quicker as you go away. Was it you, or did the humming seem just a bit more staticky than when you entered the Service Community? Well, you're safe so far[one of].[paragraph break]You look back to the entrance to Idiot Village, [idol-dir]. Makes sense, thinking back to how you got past Cute Percy losing a turn by moving diagonally[or][stopping]."	"You look back at the idol after your run. But you can't look at its face. A loud buzz emanates from the idol, and you sink to the ground, covering your ears. Once they stop ringing, you go back to the entrance to Idiot Village."	"You didn't really do much wrong. There's not much to undo."
"The thoughts idol whirls around some more. It must be [idol-dir] now. Was it just you, or did it go a little more slowly and sound a little creakier?"	"The idol catches you. A loud buzz, and you cover your ears. That could not have been the way to go."	"You didn't really do much wrong. There's not much to undo."
"The thoughts idol whizzes around, adjusting speed--but did you hear a little cough from [idol-dir]?"	"The idol buzzes. You feel frozen, then are frozen."	"You thought you almost had the idol there for a bit, but it's not exactly going to be open to letting you brute-force it into submission."
"The thoughts idol seems to twitch back and forth while following you. The noise is now from the [idol-dir]."	"You feel frozen and collapse. The idol's contempt can't hide a legitimate frown. You slipped up, but you got pretty far."	"Halfway there...maybe if you get momentum, you'll nail the pattern down for good."
"The thoughts idol barely catches its gaze up with you. More hacking, [idol-dir]."	"The idol gives that look--you know it--'Smart, but no common sense.' Still--you can give it another shot."	"Would'ves won't help here. You've actually gotten in better shape, walking around just thinking."
"The thoughts idol warps and seems to wobble a bit but you still see if staring back, [idol-dir]."	"You--well, confidence or whatever it was let you down."	"Geez. You were that close. But no chance to stew. You bet you could do it, next time. But you can't say 'Oh, I meant to...'"
"The thoughts idol spins, coughs, and with a final buzz, it flips into the air and lands on its head! Its eyes spark and go out, and it cracks down the middle. All of Idiot Village comes out to cheer your victory and pound the remnants of the idol into unrecognizeable rubble!"	"You must have been close. But no."	"The idol's look reminds you of when you got a really hard math problem right except for adding 1 and 6 to get 8. People laughed at you. It hurt."

book endgame bits

part Freak Control

Freak Control is north of Questions Field. It is in Main Chunk. "[if accel-ending]There's all sorts of stuff here but really all you want to do is show the [bad-guy] [what-what].[else][one of]Well, you made it. There's so much to look at[or]You're still dazed by all the machinery here[stopping]![paragraph break]While there's probably another secret exit than back south, it's surely only available to the [bad-guy]. All the same, you don't want to leave now. You can't.[end if]"

to say what-what:
	say "[if brownie-eaten is true]you're open to learning things you wouldn't have been, before[else]what's what[end if]";

check going nowhere in freak control:
	if noun is outside:
		try going south instead;
	say "You'd probably get lost, and caught, exploring." instead;

freak-ok is a truth state that varies.

check going south in Freak Control:
	say "[one of]You try to start running, but it fails, because you didn't have a running start. The [bad-guy] turns around. 'DUDE! That's pretty messed up, making it here and then running away. We'll sort out your confusion for your own good. There are people that can...help...with that.'[or]The [bad-guy] turns around, frowning intensely. '[activation of running gag]?' As if he's seen it before, he calls in help to sort out your ... confusion. They talk about you as if you aren't there for a bit, then...[stopping]";
	ship-off shape ship;
	if freak-ok is false:
		now freak-ok is true;
		ital-say "You can't leave, but you also can't lose. And you will gain a verb to reset the game to just before here, if you want to see both the good and very good endings.";
	the rule succeeds;

a list bucket is a thing in Freak Control. "[if accel-ending]A list bucket might help you see what machines do what, if you had the time, which you don't[else][one of]A list bucket lying nearby may help you make sense of the fancy machinery, though you worry you might kill yourself trying[or]The list bucket waits here, a handy reference to the gadgetry of Freak Control[stopping][end if]."

check taking the bucket:
	say "You would, but the [bad-guy] might turn around and ask if you really needed to steal a bucket, and no, the text isn't going to change if you pick it up, and so forth." instead;

description of list bucket is "[one of]It's nice and clean, free of [activation of scuzz bucket]. Of course it is.[paragraph break][or][stopping][2da]The Language Sign should, um, y'know, make things obvious.[line break][2da]The Shot Screen: track various areas in the Compound[line break][2da]The Twister Brain: to see what people REALLY mean when they oppose you just a little[line break][2da]The Witness Eye provides tracking of several suspicious individuals[line break][2da]The Incident Miner processes fuller meaning of events the perpetrators wish were harmless.[line break][2da]The Call Curtain is somewhere the [bad-guy] better not have to go behind more than once a day.[line break][2da]The Frenzy Feed magnifies social violations people don't know they're making, or want to hide from others, and lets you feel fully outraged.[line break][2da]The Duty Desk isn't just there to look important. Really, it isn't![paragraph break]All this gadgetry is well and good, but the [bad-guy] probably knows it better than you. You may need some other way to overcome him."

the frenzy feed is scenery in Freak Control. "It's whizzing out paper filled with oversized punctuation and question marks, SRSLY, WUT and OMG, and emoticons and so forth. You think you read something about [a random surveyable person] which is more harsh than it needs to be."

the call curtain is scenery in Freak Control. "It doesn't look particularly malevolent--it seems well washed--but you don't know what's going on behind it."

check opening call curtain:
	say "It's closer to the [bad-guy] than you. Maybe you'll just have to wonder what's behind it. Maybe that's another small part of the [bad-guy]'s mind games." instead;

check entering call curtain:
	say "The [bad-guy] wouldn't allow a repeat performance. Or any performance, really." instead;

the duty desk is scenery in Freak Control. "It's important-looking, all right."

the incident miner is scenery in Freak Control. "The incident miner churns and coughs. You see text like 'not as nice/interesting/worthwhile as he thinks' and 'passive aggressive but doesn't know it' and 'extraordinary lack of self awareness' spin by."

the against rails are plural-named scenery in Freak Control. "You're not sure whether they're meant to be touched or not. No matter what you do, though, you feel someone would yell 'Isn't it obvious Alec should/shouldn't touch the rails?'"

freaked-out is a truth state that varies.

the shot screen is scenery in Freak Control. "[if cookie-eaten is true]You're torn between wondering if it's not worth watching the jokers being surveyed, or you deserve a good laugh.[else]For a moment, you get a glimpse of [one of]the [j-co] going about their business[or]parts of Idiot Village you couldn't explore[or]a 'me-time' room in the Classic Cult[or]a secret room in the Soda Club[or]Officer Petty at the 'event,' writing notes furiously[or]the hideout the Stool Toad was too lazy to notice[or]Sid Lew back at his home[or]exiles living beyond the Standard Bog[in random order].[end if]"

current-worry is a number that varies. current-worry is 0.

freak-control-turns is a number that varies.

bucket-ping is a truth state that varies.

trip-ping is a truth state that varies.

every turn when player is in freak control and qbc_litany is not table of baiter master talk (this is the random stuff in FC rule):
	unless accel-ending:
		increment freak-control-turns;
		if current-worry is 5 and list bucket is not examined and bucket-ping is false:
			say "You think you hear the List Bucket rattle. Wait, no.";
			now bucket-ping is true;
			the rule succeeds;
		if current-worry is 10 and trip-ping is false:
			now trip-ping is true;
			say "'All this data from all these machines! I need a little [activation of break monotony] from this decisiveness and abrasiveness,' the [bad-guy] yells to, well, nobody in particular. 'It's not like I'm on a total [activation of power trip].'";
			the rule succeeds;
		increment current-worry;
		if current-worry > number of rows in table of bad guy worries:
			now current-worry is 1;
			now bucket-ping is false;
			now trip-ping is false;
		choose row current-worry in table of bad guy worries;
		say "[gad-act entry][line break]";

definition: a thing (called sc) is control-known:
	if sc is not in freak control, decide no;
	if sc is examined, decide yes;
	if list bucket is examined, decide yes;
	decide no;

definition: a room (called rm) is mainchunk:
	if rm is freak control, decide no;
	if rm is belt below, decide no;
	if rm is A Great Den, decide no;
	if map region of rm is main chunk, decide yes;
	decide no;

to say odd-machine of (x - a thing):
	if x is control-known:
		say "The [x]";
	else:
		say "Some machine";

to say odd-machine-l of (x - a thing):
	if x is control-known:
		say "The [x]";
	else:
		say "some machine";

the Twister Brain is scenery in Freak Control. "The way it's creased, it's just a contemptuous smirk. Or maybe you're just seeing things."

understand "ridge/ridges" as Twister Brain.

the Witness Eye is scenery in Freak Control. "It's weird, it's circular, but it has enough pointy protrusions, it could be a Witness Star too. You see lots of things going on. Most look innocent, but there's an occasional flash, the screen reddens, and WEIRD or WRONG flashes over for a half-second[if a random chance of 1 in 5 succeeds]. Hey, wait, that looked like [a random surveyable person] for a second, there[end if]."

after examining the Witness Eye for the first time:
	say "It seems a bit harsh. But then again, the [activation of beholder of the eye] sees what they want to, and--well, you realize you might be biased.";
	continue the action;

understand "witness star" and "star" as Witness Eye.

the Language Sign is scenery in Freak Control. "It says, in various languages: [activation of freak out]. [one of]You're momentarily impressed, then you feel slightly jealous that the [bad-guy] took the time to research them. You remember getting grilled for trying to learn new languages in elementary school, before you could take language classes. You mentally blame the [bad-guy] for that. Well, it was someone like him. [or]You also take a second or two to pick which language in which line says OUT, FREAK. Got [']em all. Even the ones with the unusual alphabets you only half know.[stopping]"

The Baiter Master is a proper-named person in Freak Control. "The [bad-guy] stands here with his back to you.". description is "You can only see the back of him, well, until you gaze in some reflective panels. He looks up but does not acknowledge you. He doesn't look that nasty, or distinguished, or strong, or whatever. Surprisingly ordinary. He shrugs and resumes his apparent thoughtfulness."

understand "complex" and "messiah" and "complex messiah" and "bm/cm" as Baiter Master.

litany of Baiter Master is the table of Baiter Master talk.

check talking to Baiter Master:
	if freaked-out is false:
		say "[one of]He waves you off without even looking. 'Whoever you are, I'm busy. Too busy for your lame problems. And they must be lame, if you asked so weakly.' Such an [activation of reactionary]! You'll need an entirely more aggressive way to get his attention.[or]You just aren't good enough at yelling to do things straight up. Maybe you can upset things somehow.[stopping]" instead;
	say "'But seriously, dude! You need to chill... there are things called manners...' but he does have your attention now. 'So. Someone finally got past those mopey brothers. You want a [activation of race baiting]? A [activation of dual vision]? I have...an [activation of difference of opinion]. You don't even have...[activation of serve one right].' He takes a slurp from a [activation of mug shot] (with a too-flattering self-portrait, of course) and perks up.";
	if player has legend of stuff:
		say "He points to the Legend of Stuff. 'Oh. It looks like you took the easy way out. In fact...";
		say "[line break][bm-stuff-brags]";
	say "[line break][bm-idol-brags]";
	say "[line break]'Well, even with the Thoughts Idol [if idol is in lalaland]gone[else]here[end if], I should be able to fix the mess you made.'"

to say bm-stuff-brags:
	repeat through table of bm stuff brags:
		if hints-used <= times-failed entry or times-failed entry is -1:
			say "'[what-to-say entry][if reused-hint is true] And you had to look something up twice, too, I bet. No focus.'[else]'";
			continue the action;

to say bm-idol-brags:
	repeat through table of bm idol brags:
		if idol-fails <= times-failed entry or times-failed entry is -1:
			say "[if idol is in lalaland][win-say entry][else][nowin-say entry][end if]";
			continue the action;

reused-hint is a truth state that varies.

table of distract time
control-turns	time-taunt
1	"'Just running in here quickly, eh? Not appreciating the scenery?'"
5	"'Wondered if you were going to do something.'"
10	"'Gosh! Was it awkward for you, waiting, too?'"
15	"'Well, yes, I saw you first thing. Finally had the guts...'"
--	"'You know, you're lucky I didn't have you arrested for loitering.'"

table of bm stuff brags
times-failed	what-to-say
0	"More precisely, you went to all that trouble and didn't even use it."
1	"Only used it once, maybe, but still--you had to cheat."
2	"Used it twice, there."
5	"Kind of taking the easy way, there."
10	"Did you even TRY to think on your own? I'm all for research and reading and re-reading, but..."
-1	"You should be embarrassed using the Legend that much! Honestly."

table of bm idol brags
times-failed	win-say	nowin-say
0	"'Destroyed the Thoughts Idol in one try, too. Lucky.'"	"'Didn't even try with the Thoughts Idol. That's a good way to get far in life.'"
1	"'You're lucky the Thoughts Idol didn't kill you first try you got. It should've. But, mercy and stuff.'"	"'Quit pretty quickly with the Thoughts Idol, though.'"
5	"'I suppose you can feel smart enough, beating the idol pretty quickly.'"	"'You sort of tried to figure the Idol, I guess.'"
10	"'Eh, well, sort of average performance taking the idol.'"	"'Guess I'll give you credit for persistence with the Idol, even in failure.'"
15	"'Boy. Took you long enough with the idol, there.'"	"'Boy, you seem like the sort that'd figure how to get by the Idol. Guess you got frustrated.'"
21	"'So. Trial and error worked, I guess. But--didn't you feel dumb once you realized what you did?'"	"'Too bad there wasn't an answer hidden somewhere for the Thoughts Idol..'"
-1	"'Congratulations, I guess. If you were persistent with, y'know, practical stuff...'"	"'Doubt you learned much from all your failures. Yeah, persistence, but you SHOULD have brute-forced it.'"

table of bm - Baiter Master talk
prompt	response	enabled	permit
"I've gained...[activation of beyond belief]."	bm-help	1	1
"What's in the shot mug?"	bm-mug	1	1
"A gift from [bad-guy-2]? WHAT?!"	bm-bad2	0	1
"Well, I took the time to go fetch stuff."	bm-fetch	0	1
"Oh, they had something to SAY, all right."	bm-tosay	0	1
"So does [bad-guy-2]."	bm-so-bad2	0	1
"Tribute? Is there any left over for the rest?"	bm-tribute	0	1
"Oh, yes. Yes they are. I kind of already helped them."	bm-fear	0	1
"Um, later."	bm-bye	2	1

table of quip texts (continued)
quip	quiptext
bm-help	"'Really? What sort of help?'[paragraph break]You describe what you did for them and how you did it.[paragraph break]'Oh, so a fetch quest, then. You should be above that, shouldn't you? I mean, a fetch quest helps one other person, but clever philosophy--it helps a lot. [bad-guy-2] is OUT there, you know.' And he laughs, but wait--it's [activation of laughingstock] you've heard before."
bm-fetch	"'Big deal. You probably never considered how lucky you were, how improbable those helpful items were just lying around. Intelligent design? Pah! What a joke! My social ideals fix society and all that sort of thing. Surely you heard what people said? They had something to say.'"
bm-tosay	"'You have to admit, I have leadership skills.'"
bm-mug	"'Oh, it's Crisis Energy[activation of energy crisis]. For taking urgent action when someone's -- out of line.' You look more closely. 'COMPLIMENTARY FROM [bad-guy-2-c].'"
bm-bad2	"'It's--it's, well, tribute is what it is.'"
bm-so-bad2	"'Oh, come on, you know the difference.'[wfk][line break]Your reply just slips out. 'Yeah, it's easy, there's not much of it.' Maybe you shouldn't have...but nothing happens..."
bm-tribute	"'There will be. Just--first things first. Stability. We almost got there, until you stepped in.'"
bm-fear	"You just mention, they're smart enough, but they can fool themselves. With being impressed by stupid propaganda, or misplaced confidence, or people who claim things are--well--back to front. They get used to it. They let things mean the opposite of what they mean. You've been there...[wfk][line break]'Whatever.'[paragraph break]'See? Just like that.'[paragraph break]There's a long silence. 'Well. I didn't want to do it, but you made me put on my [activation of face facts]. You'll never [activation of following my gut]! You don't listen to your [activation of half right]...makes you miss obvious things others see immediately. Always have, always will. [activation of see you later]...' The Baiter Master storms out, and he must have had a remote, because you're locked in![wfk][paragraph break]You search frantically. There must be some way to communicate...and you dig around until you find the [activation of wire fraud]! Meant to 'remind' citizens they aren't as nice as they think they are, it now encourages them to get mad. The Goods get their cult to help. The [j-co] even chip in, too. Then, for kicks, you call [bad-guy-2] pretending to be the [bad-guy] and you prank him. And, of course, you remember the number to RING BRASS, from the Quiz Pop.[paragraph break]Mark Black is on his way--but so are the [bad-guy]'s allies! You hear Brother Foster say, well, I knew they were flaky, but that's what you GET when you try to give them an important position in life, and [activation of relief] will set things straight.[wfk]Yes. That must be him, now.[paragraph break]'A danger not just to the Problems Compound but to [activation of city slicker]! [activation of pratfall]!' he booms, tripping over his feet slightly.[wfk]"
bm-bye	"'You're not going anywhere.' And he's right. But it's not out totally out of fear, now."

already-good is a truth state that varies.
already-great is a truth state that varies.

after quipping when qbc_litany is table of baiter master talk:
	if current quip is bm-help:
		enable the bm-fetch quip;
	if current quip is bm-fetch:
		enable the bm-tosay quip;
	if current quip is bm-tosay:
		enable the bm-so-bad2 quip;
	do nothing; [cut things in two]
	if current quip is bm-mug:
		enable the bm-bad2 quip;
	if current quip is bm-bad2:
		enable the bm-tribute quip;
	if current quip is bm-tribute or current quip is bm-so-bad2:
		if bm-tribute is talked-thru or bm-so-bad2 is talked-thru:
			say "'If I was really such a bad guy, wouldn't people have been smart enough to figure it out by now?'";
			enable the bm-fear quip;
		else:
			d "trib [if bm-tribute is talked-thru]1[else]0[end if]";
			d "hunter/buster [if bm-so-bad2 is talked-thru]1[else]0[end if]";
	choose-final-room;

to choose-final-room:
	let gg be indexed text;
	now gg is "good";
	choose row with brief of gg in table of vu;
	if found entry is true:
		now already-good is true;
	now gg is "great";
	choose row with brief of gg in table of vu;
	if found entry is true:
		now already-great is true;
	if current quip is bm-fear:
		terminate the conversation;
		move baiter master to lalaland;
		if thoughts idol is in lalaland:
			say "But Idiot Village has had time to assemble and rescue the hero that dispelled the Thoughts Idol! They overwhelm the [bad-guy]'s loyalists, trash the more sinister surveillance technology in Freak Control, and lead you somewhere new. You protest you're not a leader--you just, well, did a bunch of errands. But they insist they have something to show you.";
			it-take hammer;
			set the pronoun them to mentality crowd;
			move player to Airy Station;
		else:
			say "'Where? In the [activation of break jail]!'[paragraph break]Could people who yell that loud REALLY be that wrong? You keep a straight face, even as he booms '[activation of zeroin]!' Which helps you focus more than you thought you could on how to get out. You're way ahead of the guards when they give chase. There's a mist ahead--maybe they'll lose you! But you've done even better. 'The out mist!' they yell. 'People eventually leave there to get back to real life.' Leif Rhee booms his troops have enough out steak to last a while."; [temproom freak control]
			set the pronoun it to worm ring;
			move player to Out Mist;
		annotize baiter master;
		annotize grace goode;
		annotize turk young;
		annotize volatile sal;
		annotize mistake grave;
		annotize language machine;

chapter freakouting

freakouting is an action applying to nothing.

understand the command "freak out" as something new.
understand "freak out" as freakouting.

carry out freakouting:
	say "You let it all out. You haven't let it all out, since the good old days when James Scott and Scott James, ever fair and balanced, castigated you alternately for being too creepy-silent or being too overemotional. You blame the [bad-guy] for stuff that couldn't possibly be his fault, but it feels good--and it gets his attention.";
	begin-endgame;
	the rule succeeds;

chapter powertriping

powertriping is an action applying to nothing.

understand the command "trip power" as something new.
understand "trip power" as freakouting.

carry out powertriping:
	say "You wonder if it could be that easy. Of course there has to be a switch somewhere! It might be hard to find, and the [bad-guy] might catch you...no, he is too absorbed in his surveillance. He'd already have picked at you, if he cared.[paragraph break]Ah, there it is. Just shut it down...";
	wfak;
	say "[line break]Oops, it's dark! The [bad-guy] yells. 'It'll take FIVE MINUTES to boot up again![paragraph break]He turns around and glares at you. Or where he knows you are, because he saw you with mirrors and so forth.";
	begin-endgame;
	the rule succeeds;

to begin-endgame:
	now freaked-out is true;
	score-now;
	master-welcome-taunt;
	try talking to baiter master;

to master-welcome-taunt:
	repeat through table of distract time:
		if there is no control-turns entry or freak-control-turns <= control-turns entry:
			say "[time-taunt entry][line break]";
			the rule succeeds;

book endings

Endings is a region.

part Out Mist

Out Mist is a room in Endings. "It's very misty here, but you can still see a worm ring nearby. At the moment, it's cannibalizing itself too much to be whole.[paragraph break]It's silent here and tough to see, but you're pretty sure your pursuers aren't approaching any more."

understand "tickle mist" as a mistake ("You don't feel anything deep or wonderful.") when player is in Out Mist.

before talking to the ring:
	say "The ring reveals no hints as to what it should be." instead;

mist-turns is a number that varies.

every turn when player is in out mist (this is the ring clue rule):
	increment mist-turns;
	if the remainder after dividing mist-turns by 4 is 0:
		if worm is not examined:
			now mist-turns is 0;
			say "You may [one of][or]still [stopping]need to take a closer look at the worm.";
			the rule succeeds;
	if mist-turns is 4:
		say "You just want to generally, well, do something to the ring. Make it different from what it is. Hmm, but what? Maybe you don't need to be too specific.";
	else if mist-turns is 8:
		say "Something about the ring seems dishonest, wrong.";
	else if mist-turns is 12:
		now mist-turns is 0;
		say "If you had a cell phone, maybe someone would call you with an idea. Whether it was on vibrate, or it was more audible.";

check going nowhere in Out Mist:
	say "It's not an [activation of mystify]. You might not find your way back, since it's a [activation of mistracing] that swirls all over, and the worm ring seems important." instead;

check going inside in out mist:
	try entering worm ring instead;

check entering worm ring:
	say "Hm. Enter ring, enterring--it might be simple, but it's not that simple. Because there's not enough space for you to fit, as is. But it looks and feels pliable. You may need to modify it a bit--somehow." instead;

to good-end:
	say "You scoop out the innards of the worm. The moment they're outside the worm, it extends a bit more. Then it twitches and straightens.";
	wfak;
	say "It's a whole worm. What luck! You enter it, hoping things are still a bit flip flopped...";
	wfak;
	say "The Whole Worm is bigger than you thought. You hide deeper and deeper. A passage turns down, and then here's a door. Through it you see your bedroom.";
	go-back-home;

understand the command "answer" as something new.

to say ring-clue:
	say "!";

understand "brass ring" and "ring brass" as a mistake ("[if player is in out mist]You already had to ring the brass to get here. Gotta be something else with the ring.[ring-clue][else if player is in airy station][else if player is in freak control]You can't bring yourself to attack the [bad-guy] first.[else]You sense you don't quite need to, yet.[end if]") when quiz pop is in lalaland

understand "answer ring" and "ring answer" as a mistake ("The ring seems to be straining to be different. But it can't make a difference on its own.[ring-clue]") when player is in Out Mist.

understand "like ring" and "ring like" and "ringlike" as a mistake("You sort of like the ring the way it is, but you'd like it much better another way.[ring-clue]") when player is in Out Mist.

understand "ear ring" and "ring ear" and "earring" as a mistake("You aren't rebellious enough to pierce, well, anything.[ring-clue]") when player is in Out Mist.

understand "let ring" and "ring let" and "ringlet" as a mistake("Your hair curls at the thought of such passivity.[ring-clue]") when player is in Out Mist.

understand "master ring" and "leader ring" and "ring master" and "ring leader" as a mistake("You're RUNNING from the [r-m-l], and you've already spent time mastering the Problems Compound.[ring-clue]") when player is in Out Mist.

to say r-m-l:
	let x be word number 1 in the player's command;
	if word number 1 in the player's command is "ring":
		now x is word number 2 in the player's command;
	say "[x]";


understand "worm glow" and "glow worm" as a mistake ("If you needed to find it, it might help. But now, you need to get inside it. You probably need to fix the ring shape.[ring-clue]") when player is in Out Mist.

understand "round worm" and "worm round" as a mistake ("You consider worming around, but you're not very good at flattery, and there's nobody to flatter. Not that it's worth being good at flattery.[ring-clue]") when player is in Out Mist.

understand "wring [text]" and "[text] wring" as a mistake ("It's too big for that. That's not quite how to manipulate the ring.[ring-clue]") when player is in Out Mist.

understand the command "clear" as something new.

understand "hole [text]" and "[text] hole" as a mistake ("Concentrate on the ring, not the hole.") when player is in Out Mist.

understand "worm [text]" and "[text] worm" as a mistake ("The worm ring's problem isn't that it's a worm, but rather that it's a ring.") when player is in Out Mist.

understand "whole worm" and "worm whole" as a mistake ("It pretty much is a whole worm, and maybe there's a wormhole in there, but you'll have to fix the ring shape somehow to get in there.[ring-clue]") when player is in Out Mist.

understand "worm bait" and "bait worm" as a mistake ("It's an inanimate worm, and -- well -- you might rather try fishing with things to do to a ring.") when player is in Out Mist.

the worm ring is scenery in Out Mist. "[bug]"

check opening worm ring:
	say "It's not in the right state to open." instead;

check closing worm ring:
	say "It's already closed off to you. How to make space inside it?" instead;

check wearing ring:
	ignore the can't wear what's not held rule;
	say "Hm, a good try, but it would be wearing to wear it. It's just--not useful as is, and you need to modify it." instead;

Rule for deciding whether all includes worm ring when player is in out mist: it does.

part Airy Station

Airy Station is a room in Endings. "[one of]A cheering crowd surrounds you on all sides! They're going pretty crazy over their new-found freedom, and how you achieved it for them, and how they might not even need you to keep it, even though you're nice to have around[or]The mentality crowd continues to cheer and wave[stopping]."

the mentality crowd is scenery in airy station. "All kinds of people applaud you."

instead of talking to mentality crowd:
	say "They are stuck in full-on cheering mode.";

hammer-turns is a number that varies.

every turn when player is in airy station (this is the hammer clue rule):
	increment hammer-turns;
	if the remainder after dividing hammer-turns by 4 is 0:
		if hammer is not examined:
			now mist-turns is 0;
			say "You may [one of][or]still [stopping]need to figure how the hammer can help you get out of here--or past the caps. Maybe it'd help to EXAMINE the hammer.";
			the rule succeeds;
	if hammer-turns is 4:
		say "If you had another hammer, maybe you could click them together and go back.";
	else if hammer-turns is 8:
		say "You're chipping off things the hammer can't be.";
	else if hammer-turns is 12:
		say "You imagine the hammer putting the caps in a wrestling hold.";
	else if hammer-turns is 16:
		say "You wonder if the hammer can lead you some direction--up or down, maybe, or something vaguer.";
	else if hammer-turns is 20:
		say "You wonder if and how the hammer can lead you from this somewhat neutral arena.";
		now mist-turns is 0;

section hammer mistakes

the hammer is a thing in Airy Station. "A hammer lies nearby. It's the sort you use to knock in big spikes on a rail.". description is "[bug]".

check dropping the hammer:
	say "You already dropped the figurative hammer on the [bad-guy]. Now to do something constructive with the real hammer." instead;

after printing the name of the hammer when taking inventory:
	say " (much plainer than it should be)";

instead of doing something with hammer:
	say "The hammer seems to move in your hand a bit." instead;

the Return Carriage is a thing. "The Return Carriage awaits, but the problem is, you can't find an obvious way to, um, enter.". description is "It's spiffy and sleek. But the lock caps on the return carriage prevent you from entering. Maybe your hammer could help. Maybe not in its present state, but in some other state."

the lock caps are part of the return carriage. description is "They don't look too menacing, but then you look closer, and you feel like you're being shouted at. Hm. Plus they don't have the usual keyhole."

check entering Return Carriage:
	say "You approach the whitespace around the return carriage, then try a new line of entry, but you have to admit failure and retreat to backspace. Those lock caps--you can't find a way to control [']em." instead;

check opening Return Carriage:
	say "You need to get the locks off, somehow." instead;

check attacking lock caps:
	say "Your plain old hammer doesn't do much." instead;

instead of doing something with lock caps:
	if current action is attacking or action is undrastic:
		continue the action;
	say "They're pretty secure, for locks. You can't see how to start to open them." instead;

after printing the locale description for Airy Station when Airy Station is unvisited:
	say "The crowd's adulation shakes you a bit. You worry you'll be stuck in charge of the whole place, and you might get corrupted like the [bad-guy] or whatever. So you make a speech about how someone local should rule--and they eat it up! They praise your humility![wfk]";
	say "As they do, an odd vehicle rolls out. 'The Return Carriage!' shouts the mentality crowd. Amidst cheerful farewells there's a general undercurrent of 'TAKE THE HAMMER!' So you do.";
	now player has the hammer;
	move return carriage to Airy Station;

understand "hammer drop" as dropping when player is in airy station.

rule for supplying a missing noun when dropping:
	if player is in airy station:
		now noun is hammer;

check going in Airy Station:
	if noun is inside:
		say "You need to figure how to open the Return Carriage first." instead;
	else if noun is up or noun is down:
		say "No tricky directions here. Into the Return Carriage." instead;
	else:
		say "You consider saying '[activation of clear waivers]' and pushing through, but you know you need to LEAVE the big time in the Return Carriage. There'll be enough to do." instead;

book merged ending

end-stress-test is a truth state that varies.

to say bi of (ts - a truth state):
	if screen-read is true:
		if ts is true:
			say "* ";
	else:
		say "[if ts is true][i][else][b][end if]"

to go-back-home:
	choose row with final response activity of amusing a victorious player in table of final question options;
	now final question wording entry is "see some suggestions for [bi of amuseseen]AMUSING[r] things to do";
	if end-stress-test is true:
		say "Yay! This worked. I am blocking the ending so you can try again.";
		continue the action;
	score-now;
	say "The door leads to your closet and vanishes when you walk through. You're hungry after all that running around. Downstairs you find some old cereal you got sick of--certainly not killer cereal (ha ha) but now you realize it could be Procrastination Cereal, Moping Cereal, Complainer Cereal, or even something goofy like Monogamy Cereal. Maybe if it's really old you can pretend it's Pest Cereal, especially when you've put off asking someone about something. That little reverse will feel fresh for a while.";
	wfak;
	say "You laugh at your own joke, which brings your parents out, complaining your late night moping is worse than ever. You promise them it'll get better.";
	wfak;
	say "Back in your bedroom, you have a thought. The Baiter Master saying you miss obvious things. Another look at [i]The Phantom Tolllbooth[r]: the inside flap. 'Other books you may enjoy.' There will be other obvious things you should've discovered. But it's good you found something right away, back in the normal world. You're confident you'll find more--and that even when people like the Baiter Master or his allies are factually right, or loud, or confident, they aren't accelerated life experts. Or they're experts at the wrong sort of persuasion, and you've finally countered that a bit.";
	unlock-verb "anno";
	print-replay-message;
	see-if-show-terminal;
	if bros-left > 0:
		d "[b]Uh oh. A test to clear the brothers from questions field may not have worked. [list of people in questions field] remain. Please check.[r]";
	end the story finally saying "[activation of received wisdom]!"; [temproom endgame]
	the rule succeeds;

to see-if-show-terminal:
	if terminal is in lalaland, continue the action;
	if got-terminal-almost is true, continue the action;
	choose row with final response activity of altanswering in the table of final question options;
	blank out the final question wording entry;

to print-replay-message:
	let x be number of rows in table of verb-unlocks;
	choose row x - 1 in the table of verb-unlocks;
	let T1 be found entry;
	choose row x in the table of verb-unlocks;
	let T2 be found entry;
	if T1 is true and T2 is true:
		say "Thanks for playing through again! I'm glad you found the game interesting enough to do so.";
	continue the action;
	if out mist is visited:
		unlock-verb "good";
		if T1 is false:
			say "Thanks for replaying to find the good-but-not-great ending!";
		else if T2 is false:
			say "A better ending is [if T1 is true]still [end if]out there! [if Cute Percy is not in lalaland]There's something below Cute Percy[else if Insanity Terminal is not in lalaland]The Insanity Terminal hides a clue[else]The Thoughts Idol still remains to torture Idiot Village[end if].";
	else:
		unlock-verb "great";
		if T1 is true:
			say "Congratulations, and for replaying to find the slightly better ending! I, and the imaginary people of Idiot Village, thank you!";
		if T1 is false:
			say "There's [if T2 is true]still [end if]a slightly different ending if you don't rescue Idiot Village from the Thoughts Idol, if you're curious and/or completist.";

book Bad Ends

Bad Ends is a region.

part Beer Pound

there is a room called A Beer Pound. It is in Bad Ends. "Here prisoners are subjected to abuse from prison guards who CAN hold their liquor and NEED a drink at the end of the day. And they are not wimps with low alcohol tolerance, either."

part Criminals' Harbor

Criminals' Harbor is a room in Bad Ends. "Many poor teens in striped outfits or orange jumpsuits plod by here."

part Fight Fair

Fight Fair is a room in Bad Ends. "The [bad-guy] watches down from a video screen as much stronger people beat up on much weaker people. 'Use your minds! Be grateful they're not really hurting you!' Nobody dares call it barbaric. After all, it could be worse."

part Hut Ten

Hut Ten is a room in Bad Ends. "Here you spend time in pointless military marches next to people who might be your friends in kinder environs. Apparently you're being trained for some sort of strike on [bad-guy-2]'s base, whoever he is. As time goes on, more recruits come in. You do well enough to boss a few around. But people above you, especially the [activation of generalist] who knows everyone's trivial faults, remind you that's still not good ENOUGH."

part In-Dignity Heap

In-Dignity Heap is a room in Bad Ends. "Here we have someone at the top of the heap, telling people to have a little respect for themselves, you know?"

part Maintenance High

Maintenance High is a room in Bad Ends. "A teacher drones on endlessly about how it's not necessarily drugs that are bad, that people can mess themselves up even worse than drugs, and there's a whole huge lecture on how to be able to integrate making fun of drug users and feel sorry for them, to be maximally interesting."

part Punishment Capitol

Punishment Capitol is a room in Bad Ends. "You've really hit the jackpot! I guess. Everything is bigger and better here, and of course you're constantly reminded that you have more potential to build character here than in Hut Ten or Criminals['] Harbor. And whether you grumble or agree, someone officious is there to reenforce the message you probably won't build that character. But you have to try![paragraph break]Oh, also, there's word some of the officers have a black market going with [bad-guy-2], too, but people who do that--well, there's never any evidence."

part Shape Ship

Shape Ship is a room in Bad Ends. "Kids drudge away at tasks they're too smart for, being reminded that with that attitude they'll never be good for anything better than, well, this."

book dream sequence

Dream Sequence is a region.

nar-count is a number that varies. nar-count is 1.

toad-waits is a truth state that varies.

caught-sleeping is a truth state that varies.

last-room-dreamed is a room that varies.

to say to-js:
	say "[if joint strip is visited]to the Joint Strip[else]east[end if]";

every turn when mrlp is dream sequence:
	if player is in tense past:
		if slept-through is false and toad-waits is true and caught-sleeping is false:
			now toad-waits is false;
			now slept-through is true;
			say "As if that wasn't enough, you feel someone jostling you. Wait, no. It's not someone in the dream.";
			wfak;
			say "[line break]It's the Stool Toad! You're back on the bench at Down Ground![paragraph break]'A popular place for degenerates. A future [activation of sleeper cell], like you. That'll be a boo-tickety for you.'[if your-tix < 4][line break]As you hold the ticket and rub your eyes, the Stool Toad walks back [to-js]. 'It's a darn shame!' he moans. 'Only one of these per day! Plenty of other ways to make their [activation of double jeopardy] so I can reach my quota!' You get the sense he wouldn't sympathize if you told him WHAT you dreamed about.[end if]"; [temproom down ground]
			now caught-sleeping is true;
			move player to Down Ground, without printing a room description;
			get-ticketed "sleeping too long on the Warmer Bench";
			say "[line break]The Stool Toad leaves you in Down Ground, to think about what you did. Maybe even sleep on it. Ha ha.";
			leave-dream;
			the rule succeeds;
	if player is in Tense Future:
		now toad-waits is true;
	if last-room-dreamed is location of player:
		the rule succeeds;
	now last-room-dreamed is location of player;
	choose row nar-count in table of sleep stories;
	if player is in tense past:
		now b4-done entry is true;
	else if player is in tense present:
		now now-done entry is true;
	else if player is in tense future:
		now af-done entry is true;
	say "[if player is in tense past][b4-nar entry][else if player is in tense present][now-nar entry][else if player is in tense future][af-nar entry][else](BUG)[end if][line break]";

part tense past

check going nowhere when mrlp is dream sequence:
	say "You can never run. You always seem to WAIT or THINK as things happen. But maybe you can WAKE." instead;

Tense Past is a room in Dream Sequence. "People and memories and places from your past swirl, too vague to identify in detail. (Or if they can, I'm not going to intrude and tell you what they are. You know better than I do.)"

the regret of past mistakes is scenery in tense past. description is "[bug]".

instead of doing something with the regret of past mistakes:
	say "It's a part of you. It's hard enough to change in real life, day by day."

part tense present

Tense Present is a room in Dream Sequence. "Now is a whirl of classmates, acquaintances, officious adults and famous people you've tried not to care about."

the weight of indecision is scenery in tense present. description is "[bug]".

instead of doing something with weight of indecision:
	say "You decide against struggling with it. That'll only make it worse. You're pretty sure."

last-dream-loc is a room that varies. last-dream-loc is usually Tense Past.

part tense future

Tense Future is a room in Dream Sequence. "You feel horror at quite possibly turning into an adult who loathed you, or one you would disrespect."

the vision of future failures is scenery in tense future. description is "[bug]".

instead of doing something with the vision of future failures:
	say "You fail to see a way to lessen it, or, indeed, a way you might lessen it in the future."

book rejected rooms

Rejected Rooms is a region.

check going nowhere when mrlp is rejected rooms (this is the spell out the directions in director's cut rule):
	say "You can't go [noun], but you can go [list of viable directions]. Also, you can look in the upper right to see which way to exit." instead;

part One Route

One Route is a room in Rejected Rooms. "This is the first route in the director's cut, and oh, hey, guess what? There's only one route out of here: to the west."

check going nowhere in One Route:
	say "The rest of the director's cut area opens to the west." instead;

part Muster Pass

Muster Pass is a room in Rejected Rooms. "It looks and feels nice here, but there's nothing REALLY worth describing except that maple. Exits east and west seem equally suitable when this passage (which is okay and all) isn't good enough for you any more.". Muster Pass is west of One Route.

the maple is scenery in Muster Pass. "The maple has, carved in it, LE MAP (the sort of stretch that'd be a bit much for the game proper) over a rough map of the Problems Compound that's much like the Trizbort/PDF included in this game's package. You appear to be at the southeast of the southwest area. There are two other areas you didn't cross while beating the [bad-guy]: isolated rooms to the northwest and northeast."

part Chicken Free Range

Chicken Free Range is a room in Rejected Rooms. "Well, actually, it's pretty much free of anyone. But you are free to go in all four directions.".

part Tuff Butt Fair

Tuff Butt Fair is a room in Rejected Rooms. Tuff Butt Fair is east of Chicken Free Range. "Well, the fair is empty, but you can go east or west."

Francis Pope is a person in Tuff Butt Fair. description of Francis Pope is "Dressed all in black and he doesn't have a popemobile."

check talking to Francis Pope:
	say "You don't want to hear his views on religion. They generally involve telling poor people to shut up and be happy and fake-smiling at anyone who disagrees with that." instead;

check going nowhere in Tuff Butt Fair:
	say "The ways south and north are, err, too tough to fight through." instead;

part Ill Falls

Ill Falls is a room in Rejected Rooms. Ill Falls is east of Tuff Butt Fair. "A breathtaking view of waterfalls, and yet--it seems possibly manufactured, and you hold your breath suppressing anger that might be the case.[paragraph break]You can only go back west to the fair."

The Flames Fan is a proper-named person in Ill Falls. "The Flames Fan waits here, ready to chat about anything allowing pointless arguments. He snort-laughs every thirty seconds at some idea he thinks you don't deserve to know.". description is "Surprisingly, he is not wearing a Calgary hockey jersey."

check talking to Flames Fan:
	say "He blows you off. Perhaps he evaluates you as more likely to blow up if you're ignored instead of insulted. He probably needs another person here so he can start a flame war and watch. But--well, this is the director's cut, and that's not happening." instead;

part Eternal Hope Springs

Eternal Hope Springs is a room in Rejected Rooms. It is north of Chicken Free Range. "A pen fountain burbles happily here. Not a writing pen, but the fountain is caged in so you can really only see part of it and not appreciate its fully beauty, or maybe so people don't try to ruin it."

the pen fountain is scenery in Eternal Hope Springs. "You gaze at the fountain and wonder further why it's penned off. You hope there's a good reason. You don't even see any coins to be stolen from it."

check going nowhere in eternal hope springs:
	say "You can't go north, but any other way is okay." instead;

part Brains Beat

Brains Beat is a room in Rejected Rooms. It is east of Eternal Hope Springs. it is east of Eternal Hope Springs. "The consciousness stream flows by here. It cuts off passage everywhere except back west."

the consciousness stream is scenery in Brains Beat. "One look at the consciousness stream, and immediately, voices in your head cool down a bit. You feel more--wait for it--conscious of what you need to do.[paragraph break]Okay, you would've if this were in the game proper. It was, at the start. But it quickly felt even more contrived than what you just played through."

check going nowhere in Brains Beat:
	say "The stream blocks off passage anywhere except back west. You start to wade, but it's deeper and longer than you imagined. Like consciousness itself. Whoah!" instead;

part Rage Road

Rage Road is south of Chicken Free Range. Rage Road is in Rejected Rooms. "Fortunately, there is no sound of SUVs or hummers or sports cars about to run you over or get close to it or not stop at a crosswalk. Unfortunately, you flash back to all the times they did."

check going nowhere in rage road:
	say "Boy, if there were an intersection here, it'd be just too mad. So, it's just east-west." instead;

Rage Road is west of Muster Pass.

part Mine Land

Mine Land is a room in Rejected. Mine Land is west of Rage Road. "A very barren, unevenly pitted place. You can still hear echos of people who likely fought over it until it was wasted."

check going nowhere in mine land:
	say "It might not be safe to go [noun]. Rage Road to the east is less unsafe." instead;

part Humor Gallows

Humor Gallows is west of Chicken Free Range. Humor Gallows is in Rejected Rooms. "Laughter goes to die here. Or it bursts up then dies quickly. You can only go back east."

The Cards of the House are plural-named people in Humor Gallows. "The Cards of the House stand here, laughing at things you don't understand. They aren't going to let you in, so best ignore them.". description is "They seem straining to create a laugh or, indeed, claim why others aren't as funny as they are."

check taking cards of the house:
	say "They're not a deck of cards. They're people trying to be funny. You can barely take them as is." instead;

understand "card [text]" and "[text] card" and "[text] cards" as a mistake ("You can't do anything tricky with the Cards. You're able to deflect their 'humor,' and that's enough.") when player is in Humor Gallows.

check talking to Cards of the House:
	say "Nothing they say is funny. It's all inside jokes, or stuff about celebrities, or overgeneralization. You wish they could be dealt with (this is one of my very favorite bad puns. You're welcome.)[paragraph break]" instead;

part Madness March

Madness March is west of Eternal Hope Springs. Madness March is in Rejected Rooms. "You hear the distant sound of cheering and groaning about something people have no control over."

check going nowhere in madness march:
	say "The path bends north and east here." instead;

part Window Bay

Window Bay is north of Madness March. Window Bay is in Rejected Rooms. "It seems like your vision is sharper here than elsewhere. To keep you busy, a small structure labeled 'VIEW OF POINTS' is here."

check going nowhere in window bay:
	say "The water is too deep anywhere but back south." instead;

does the player mean switching on the view of points: it is very likely.

the view of points is scenery in Window Bay. "You shouldn't be seeing this."

understand "structure" as view of points.

check examining the view of points:
	if current-idea-room is 0:
		now current-idea-room is 1;
	say "The View of Points is [one of]like one of those parking meter looking things you see at the edge of a cliff to magnify the landscape beyond. It's [or][stopping]currently set to [current-idea-room], though you can SWITCH it.";
	if the-view-room is unvisited:
		view-point;
	else:
		say "You've seen [the-view-room] already, but have another look?";
		if the player yes-consents:
			view-point;
	the rule succeeds;

to decide which room is the-view-room:
	repeat with rm running through rooms in just ideas now:
		if point-view of rm is current-idea-room:
			decide on rm;
	repeat with rm running through rooms in bad ends:
		if point-view of rm is current-idea-room:
			decide on rm;
	decide on Window Bay;

alt-view is a truth state that varies.

to view-point:
	if the-view-room is Window Bay:
		say "Uh oh, BUG. [email].";
	else:
		now alt-view is true;
		move the player to the-view-room;
		now alt-view is false;
		move the player to Window Bay, without printing a room description;
		now the-view-room is map-pinged;
		say "The vision blurs, and you look up from the View of Points, sadder but hopefully wiser.";
		if last-bad-room is smart street, say "[line break]Note: for rooms you don't stay in, you can type XB to see the explanation.";
		now last-bad-room is the-view-room;

before switching on the view of points:
	if current-idea-room is switch-to-bad:
		say "The view becomes darker. You've moved on to less desirable areas now. Places the [bad-guy] would've had people ship you if you really messed up.";
	increment current-idea-room;
	if the-view-room is camp concentration and the-view-room is unvisited:
		say "Oh dear. This final one's really bad. I felt awful thinking of the name. Because there's some stuff it's hard to provide a humorous twist to. You might want to skip it. I left it off the Trizbort map for a reason. See it anyway?";
		if the player yes-consents:
			do nothing;
		else:
			increment current-idea-room;
	if current-idea-room > idea-rooms:
		say "[one of]CLICK! That's the last one. You're back to the start. No more prison-y areas.[or]The CLICK again--you reached the end once more.[stopping]";
		now current-idea-room is 1;
	view-point instead;

part Just Ideas Now

Just Ideas Now is a region.

idea-rooms is a number that varies.

current-idea-room is a number that varies. current-idea-room is 0.

a room has a number called point-view. point-view of a room is usually 0.

switch-to-bad is a number that varies.

part Camp Concentration

Camp Concentration is a room in Just Ideas Now. "This one's impossible to joke about straight-up. Just, the perpetrators are all, 'Well, it could be a LOT worse, so quit moping and focus on improving yourself.' Which isn't a lethal mind game, but it's a mean one."

part Expectations Meet

Expectations Meet is a room in Just Ideas Now. "People all discuss what they deserve to have and why they deserve it more than others. Well, most. There's some impressively nuanced false humility here, though you could never call anyone on it."

part Perilous Siege

Perilous Siege is a room in Just Ideas Now. "Some kind of combat is going on here! A big castle labeled [bad-guy-2-c][']S PLACE is surrounded by forces that can only be the [bad-guy][']s. Nobody's getting killed, but the insults are coming fast from each side."

part Robbery Highway

Robbery Highway is a room in Just Ideas Now. "There's a speed limit sign here (45 MPH IF YOU'RE LAME, 75 IF YOU'RE NOT,) but it's just put there so anyone dumb enough to follow it will get mugged."

part Space of Waste

Space of Waste is a room in Just Ideas Now. "Piles and piles of things society apparently needs, but you have no use for. Magazines, mattresses, furniture, take-out boxes. A voice whispers: 'But you do! People buy them, and if you invested in a company that sells them, that makes you money.'"

part Clown Class

Clown Class is a room in Just Ideas Now. "One teen forcefully berates a class into how they're not funny, and they never will be, unless they shape up and start blending intelligence with social knowledge properly. And the way to start is to encourage people who are actually funny, but don't be a COPYCAT. He scoffs a lot at them, and assures them he's not laughing at their JOKES."

part Everything Hold

Everything Hold is a room in Just Ideas Now. "You see about one of everything you've ever owned or wanted to here. Considering it all makes you pause with jealousy--for what you don't have--and regret, for what you got and wasn't worth it."

part Shoulder Square

Shoulder Square is a room in Just Ideas Now. "People mill about here in pairs, shoulder to shoulder. One of each pair always tells the other what he should have done."

part endgame

[this is for my code checker to flag endgame concepts]

[end rooms]

volume amusing and continuing

book amusing

rule for amusing a victorious player:
	now amuseseen is true;
	let missed-one be false;
	let item-count be 10;
	say "Have you tried:";
	repeat through table of amusingness:
		if there is an anyrule entry:
			follow the anyrule entry;
		if the rule succeeded:
			say "[2da][biglaff entry]";
			if item-count is 10:
				now item-count is 0;
				wfak;
		else:
			now missed-one is true;
	if missed-one is true:
		say "[line break]NOTE: both 'good' endings are mutually exclusive, so you missed a bit. But you can [b]NOTICE ADVANCE[r] to get back past the [j-co] and try the [if airy station is visited]okay[else]better[end if] one, if you haven't seen it yet."

table of amusingness
biglaff	anyrule
"Waiting? Especially in A Round Lounge/Soda Club?"	degen-true rule
"(First time only) thinking?"	--
"Swearing (and saying yes or no) when the game asks if you want swearing?"	--
"An empty command?"	--
"XYZZY? Four times?"	--
"XYZZY in Freak Control? Twice?"	--
"Attacking anyone? Or the torch?"	--
"DIGging twice in Variety Garden?"	--
"DROPping the dreadful penny, reasoning circluar, pot/weed or other things?"	--
"Going east when Officer Petty is still in Judgment Pass?"	--
"COAT PETTY or FOG PETTY?"	--
"Giving the condition mint to various non-[j-co], such as Volatile Sal or Buddy Best?"	--
"Cussing when you asked for no profanity?"	--
"Cussing in front of certain people, especially authority figures (twice for a 'bad' ending)?"	--
"Kissing the Language Machine?"	--
"Drinking someone?"	--
"Going west/north/south in the Variety Garden?"	--
"GIVEing Pusher Penn's 'merchandise' to the Stool Toad or Officer Petty?"	--
"GIVEing Minimum Bear to anyone except Fritz the On?"	--
"GIVEng Minimum Bear to Fritz with Terry Sally gone? Or with four ticketies?"	--
"PUTting the poetic wax on/giving it to anything except the language machine?"	--
"Saying YES or NO in the Drug Gateway?"	--
"Visiting the Scheme Pyramid after the [j-co] take their revenge?"	--
"LISTENing to all the songs from the song torch (there are [number of rows in table of horrendous songs])? Or just searching the source for them?"	--
"READing all the books from the book crack (there are [number of rows in table of horrendous books])? Or just searching the source for them?"	--
"TAKEng the book bank?"	--
"SLEEPing in the extra directors['] cut rooms in ANNO mode?"	--
"TAKEng the Legend of Stuff after defeating the Thoughts Idol?"	very-good-end rule
"ENTERing the Return Carriage?"	very-good-end rule
"(XP/EXPLAIN)ing the lock caps?"	very-good-end rule
"HAMMER BAN, HAMMER BLOW, DROP HAMMER, HAMMER JACK, MAN HAMMER, HAMMER NINNY, HAMMER SLEDGE, HAMMER TIME, HAMMER TOE or HAMMER YELLOW in Airy Station?"	very-good-end rule
"WORM ROUND in the Out Mist?"	good-end rule
"LET RING or MASTER RING in the Out Mist?"	good-end rule

this is the degen-true rule:
	the rule succeeds;

this is the degen-false rule:
	the rule fails;

this is the good-end rule:
	if Out Mist is visited, the rule succeeds;
	if already-good is true, the rule succeeds;
	the rule fails;

this is the very-good-end rule:
	if airy station is visited, the rule succeeds;
	if already-great is true, the rule succeeds;
	the rule fails;

book altanswering

altanswering is an activity.

[rule for altanswering:]

this is the alt-answer rule:
	now missseen is true;
	if terminal is in belt below:
		say "The correct answer was A BAD FACE. You deserve to know that.";
	say "Here are the 42 wrong combinations if you don't say 7 is C:";
	let cur-row be 0;
	repeat through table of plausible misses:
		increment cur-row;
		say "[plaus entry]";
		if cur-row < number of rows in table of plausible misses:
			say ",";
		if the remainder after dividing cur-row by 6 is 0:
			say "[line break]";
	the rule succeeds;

book continuing

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"see where minor [bi of swearseen]SWEARS[r] change"	true	"SWEARS"	swear-see rule	swearseeing
"see the [bi of sinseen]SINS[r] the [j-co] didn't commit"	true	"SINS"	sin-see rule	sinseeing
"see the [bi of altseen](ALT)ERNATIVE[r] endings and commands"	true	"ALT/ALTERNATIVE"	alternative-see rule	altseeing
"see how to get to each of the [bi of badendseen]BAD END[r] rooms"	true	"BAD/END/BADEND" or "BAD END"	bad-end-see rule	badendseeing
"see any reversible [bi of conceptseen](CONC)EPTS[r] you missed, or [bi of conceptseen]ALL[r]"	true	"CONCEPTS/CONC"	concept-see rule	conceptseeing
--	true	"ALL"	concept-all rule	conceptseeing
"see all the [bi of dreamseen]DREAM[r] sequence stories"	true	"DREAM/DREAMS"	dream-see rule	dreamseeing
"see the plausible [bi of missseen]MISSES[r] for the Terminal"	true	"MISSES"	alt-answer rule	altanswering

amuseseen is a truth state that varies.
swearseen is a truth state that varies.
sinseen is a truth state that varies.
altseen is a truth state that varies.
badendseen is a truth state that varies.
conceptseen is a truth state that varies.
dreamseen is a truth state that varies.
missseen is a truth state that varies.

to decide whether got-all-meta:
	if amuseseen is false, decide no;
	if swearseen is false, decide no;
	if sinseen is false, decide no;
	if altseen is false, decide no;
	if badendseen is false, decide no;
	if conceptseen is false, decide no;
	if dreamseen is false, decide no;
	if missseen is false, decide no;
	decide yes;

the print the modified final question rule is listed before the print the final prompt rule in before handling the final question.

the print the final question rule is not listed in any rulebook.

to say bold-asterisk:
	say "[if screen-read is true]Asterisked[else]Bolded[end if]";

This is the print the modified final question rule:
	if accel-ending:
		say "Alec didn't REALLY make a successful ending, so all you can do is RESTART, RESTORE a saved game, QUIT, or UNDO.[paragraph break]";
		continue the action;
	let named options count be 0;
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if there is a final question wording entry, increase named options count by 1;
	if the named options count is less than 1, abide by the immediately quit rule;
	say "[if got-all-meta]You can look through any of these again if you want[else]Here is game information you may find interesting or amusing. [bold-asterisk] are not seen yet[end if].";
	let pure-metas be 0;
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if there is a final question wording entry:
					if there is a final response activity entry:
						say "[2da][final question wording entry][line break]";
					else:
						increment pure-metas;
	say "You can also ";
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if there is a final question wording entry:
					unless there is a final response activity entry:
						decrement pure-metas;
						say "[if pure-metas is 0]or [end if][final question wording entry][if pure-metas is 0].[else], [end if]";
	say "[line break]";

chapter dream

dreamseeing is an activity.

to decide which number is read-stories:
	let temp be 0;
	repeat through table of sleep stories:
		if b4-done entry is true and af-done entry is true and now-done entry is true:
			increment temp;
	decide on temp;

this is the dream-see rule:
	now dreamseen is true;
	let alldreams be read-stories;
	let skip-done be false;
	let last-row be 0;
	let mytemp be 0;
	repeat through table of sleep stories:
		increment mytemp;
		unless b4-done entry is true and af-done entry is true and now-done entry is true:
			now last-row is mytemp;
	say "There are [number of rows in table of sleep stories] total stories, of which you completed [alldreams].";
	if alldreams > 0 and alldreams < number of rows in table of sleep stories:
		say "Do you want to skip over already-read stories?";
		if the player yes-consents:
			now skip-done is true;
	let this-row be 0;
	repeat through table of sleep stories:
		increment this-row;
		unless skip-done is true and b4-done entry is true and af-done entry is true and now-done entry is true:
			say "1. [b4-nar entry][line break]";
			say "2. [now-nar entry][line break]";
			say "3. [af-nar entry][line break]";
			if this-row is last-row and skip-done is true:
				say "That's the last one! Thanks for being interested.";
			else if this-row is number of rows in table of sleep stories and skip-done is false:
				say "That's the last one! Thanks for being interested.";
			else:
				say "Q to quit, or any other key to see another:";
				let Q be the chosen letter;
				if Q is 81 or Q is 113:
					the rule succeeds;
				say "[line break]";

chapter concept

conceptseeing is an activity.

see-all-concepts is a truth state that varies.

this is the concept-all rule:
	now see-all-concepts is true;
	consider the concept-see rule;
	now see-all-concepts is false;

this is the concept-see rule:
	now conceptseen is true;
	if number of concepts in conceptville is 0 and see-all-concepts is false:
		say "You found all the concepts. Very well done, indeed.";
		the rule succeeds;
	say "There are [if see-all-concepts is true][number of concepts] total concepts[else][number of concepts in conceptville] concepts you missed[end if]. I'll pause after every ten, and you can decide whether to continue.";
	let curcon be 0;
	repeat with X running through concepts:
		unless X is an exp-thing listed in table of explanations:
			say "[X] needs an explanation. BUG.";
		else:
			choose row with exp-thing of X in table of explanations;
			if X is not in lalaland or see-all-concepts is true:
				say "[b][X][r]: [exp-text entry] ([howto of X])[line break]";
		increment curcon;
		if the remainder after dividing curcon by 10 is 0:
			wfak;

chapter bad end

badendseeing is an activity.

this is the bad-end-see rule:
	now badendseen is true;
	repeat with X running through rooms in bad ends:
		if X is not a badroom listed in table of bad end listing:
			say "[2da][X] needs a bad-end listing.";
		else:
			choose row with badroom of X in the table of bad end listing;
			say "[2da][X]: [howto entry][line break]";

table of bad end listing
badroom	howto
A Beer Pound	"Get your fifth ticket in A Beer Pound, or attack Ally Stout."
Criminals' Harbor	"Give a smokable to an officer, attack a woman, or attack machines in Freak Control."
In-Dignity Heap	"Careless swearing around the [bad-guy], Officer Petty or the Stool Toad."
Fight Fair	"Attacking other people."
Hut Ten	"Vandalizing things like the Insanity Terminal, Game Shell, Thoughts Idol, or a logic game."
Maintenance High	"Choke on the gagging lolly."
Punishment Capitol	"Attacking the [bad-guy], Officer Petty, or the Stool Toad."
Shape Ship	"Get your fifth ticket outside A Beer Pound."

chapter special

altseeing is an activity.

this is the alternative-see rule:
	now altseen is true;
	unless Cute Percy is in lalaland:
		say "[2da]Cute Percy can be faked out.";
	if Cute Percy is in lalaland and insanity terminal is not in lalaland:
		say "[2da]There are two hint devices beneath the Insanity Terminal.";
	if service community is unvisited:
		say "[2da]You could've explored the Service Community east and northeast of Idiot Village.";
	if idol is not in lalaland:
		say "[2da]You didn't find a way to defeat the Thoughts Idol.";
	if out mist is visited:
		say "[2da]The other two ways to transform the ring were [other-ring-change] RING.";
	if airy station is visited:
		say "[2da]The other two things the hammer could've been were [other-hammer-change] HAMMER.";

to say other-hammer-change:
	if end-index is 1:
		say "HOME/AWAY";
	else if end-index is 2:
		say "LOCK/AWAY";
	else if end-index is 3:
		say "HOME/LOCK";

to say other-ring-change:
	if end-index is 1:
		say "HOLLOW/TONE";
	else if end-index is 2:
		say "CHANGE/TONE";
	else if end-index is 3:
		say "CHANGE/HOLLOW";

[lock home away
change hollow tone]

chapter sins

sinseeing is an activity.

this is the sin-see rule:
	now sinseen is true;
	say "None of the [j-co] was so square that he...[line break]";
	repeat through table of fingerings:
		if jerky-guy entry is Buddy Best:
			say " ... [blackmail entry][line break]";
	say "Not that there's anything wrong with any of the above. Or there would be, if the [j-co] were guilty. Um, interested. But you knew that. And, uh, I know that, too. Really!"

chapter swearing

swearseeing is an activity.

this is the swear-see rule:
	now swearseen is true;
	say "This list goes from the start of the game to the end.";
	say "[2da](general) If you actually swear, obscenely or mildly (BOTHER)--there's a small inner dialogue for swearing with swears off.";
	say "[2da]EXPLAIN Guy Sweet has a slight difference.";
	say "[2da]Guy Sweet warns of off-beat types, with profanity on, when you ask about the [bad-guy].";
	say "[2da]Solving the Logic Matrices in the Game Shell gives some minor profanity.";
	say "[2da]The [bad-guy] is the [stwid][bad-guy][stwid] instead.";
	say "[2da][bad-guy-2] is [stwid][bad-guy-2][stwid] instead."; [end smart street]
	say "[2da]The game warns you might think (off) or say (on) a swear if you try to eat the dirt."; [end garden part]
	say "[2da]You get an additional message on entering Meal Square.";
	say "[2da]Eating a food from Tray B forces swears on, if they were off, but you have a last moment before eating the Cutter Cookie.";
	say "[2da]Saying good-bye to Ally gives the name of a rival bar with swears on."; [end outskirts]
	say "[2da]The [jc-gc] is the [stwid][jc-gc][stwid] instead. Also, you feel a bit more foreboding, and everyone sheds a jerk-tear, and if you attack them, you get a 'special' message.";
	say "[2da]DRAIN THE CIRCLE is available with swears on.";
	say "[2da]You feel guilty just being AROUND jerks with swears on.";
	say "[2da]The guys in the Fen discuss girls (rather badly) if you talk to them before reading the Finger Index. There aren't any profanities here, but they're kind of, well, juvenile. They also give an obscene gesture if you try to talk to them before reading the Finger Index.";
	say "[2da]The guys in the Fen give an up groan or a jerk-tear if innuendo/profanity is off or on, respectively.";
	say "[2da]Buddy Best is either a general attorney or a case/job nut.";
	say "[2da]The Business Monkey's half-[abr] efforts are [stwid][abr][stwid] instead.";
	say "[2da]The jerks mention they're out of a much racier pop than Quiz Pop with swears on.";
	consider the very-good-end rule;
	if the rule succeeded:
		say "[2da]HAMMER BLOW or the reverse gives a different response.";
	say "That's not a ton. I planned to have a lot more, but I just got sidetracked with silly stuff like bug fixing and adding to the story, which hopefully gave you less occasion to use profanity. So I hope that balances out."

escape mode is a truth state that varies.

Include (-

[ ASK_FINAL_QUESTION_R;
	print "^";
	(+ escape mode +) = false;
	while ((+ escape mode +) == false) {
		CarryOutActivity(DEALING_WITH_FINAL_QUESTION_ACT);
		DivideParagraphPoint();
	}
];

-) instead of "Ask The Final Question Rule" in "OrderOfPlay.i6t".

Include (-

[ PRINT_OBITUARY_HEADLINE_R;
	print "^^    ";
	VM_Style(ALERT_VMSTY);
	print "***";
	if (deadflag == 1) L__M(##Miscellany, 3);
	if (deadflag == 2) L__M(##Miscellany, 4);
	if (deadflag == 3) L__M(##Miscellany, 75);
	if (deadflag ~= 0 or 1 or 2 or 3)  {
		print " ";
		if (deadflag ofclass Routine) (deadflag)();
		if (deadflag ofclass String) print (string) deadflag;
		print " ";
	}
	print "***";
	VM_Style(NORMAL_VMSTY);
	print "^^"; #Ifndef NO_SCORE; print "^"; #Endif;
	if ( (+ off-eaten +) || (+ cookie-eaten +) || (+ greater-eaten +) || (+ brownie-eaten +)) { print "(Note: this is one of the existential failure endings you get from eating a Tray B food. You may wish to skip back to Pressure Pier on restart with KNOCK HARD.)"; }
	rfalse;
];

-) instead of "Print Obituary Headline Rule" in "OrderOfPlay.i6t".

volume mapping

book in-game map

table of map coordinates (continued)
rm	x	y	l1	l2	indir	outdir	updir	downdir	view-rule
Smart Street	5	6	"SMART"	"STREE"	west
Round Lounge	4	6	"ROUND"	"LOUNG"	--	--	north
Tension Surface	4	5	"TENSI"	"SURFA"
Variety Garden	3	5	"VARIE"	"GARDN"
Vision Tunnel	5	5	"VISIO"	"TUNNL"
Soda Club	6	5	"SODA "	"CLUB "
Tense Future	7	0	"TENSE"	"FUTUR"
Tense Present	7	1	"TENSE"	"PRESE"
Tense Past	7	2	"TENSE"	"PAST "
Out Mist	3	0	" OUT "	"MIST "
Freak Control	4	0	"FREAK"	"CNTRL"
Airy Station	5	0	"AIRY "	"STATN"
Accountable Hold	2	1	"ACCOU"	"HOLD "
Court of Contempt	3	1	"COURT"	"CONTE"
Questions Field	4	1	"QUEST"	"FIELD"
Standard Bog	5	1	"STAND"	"-BOG-"
Pot Chamber	6	1	"-POT-"	"CHAMB"
Truth Home	1	2	"TRUTH"	"HOME "
Scheme Pyramid	2	2	"SCHEM"	"PYRAM"
Temper Keep	3	2	"TEMPR"	"KEEP "
Speaking Plain	4	2	"SPEAK"	"PLAIN"
Walker Street	5	2	"WALKR"	"STREE"
Discussion Block	6	2	"DISCU"	"BLOCK"
Classic Cult	1	3	"CLASS"	"CULT "
Disposed Well	2	3	"DISPO"	"WELL "
Chipper Wood	3	3	"CHIPR"	"WOOD "
Nominal Fen	4	3	"[if silly boris is in lalaland]MELLO[else]NOMIN[end if]"	"[if silly boris is in lalaland]MARSH[else] FEN [end if]"
Judgment Pass	5	3	"JGMNT"	"PASS "
Idiot Village	6	3	"IDIOT"	"VILLG"
Service Community	7	3	"SERVC"	"COMMU"
A Great Den	1	4	"BOTTM"	"ROCK "
Belt Below	2	4	"BELT "	"BELOW"
Meal Square	3	4	"MEAL "	"SQUAR"
Pressure Pier	4	4	"PRESS"	"PIER "
Down Ground	5	4	"DOWN "	"GROUN"
Joint Strip	6	4	"JOINT"	"STRIP" [end actual game locs]
Window Bay	0	4	"WINDO"	" BAY " [meta locs you can visit]
Madness March	0	5	"MADNS"	"MARCH"
Eternal Hope Springs	1	5	"ETERN"	"SPRNG"
Brains Beat	2	5	"BRAIN"	"BEAT "
Humor Gallows	0	6	"HUMOR"	"GALLO"
Chicken Free Range	1	6	"CHCKN"	"RANGE"
Tuff Butt Fair	2	6	"TUFF "	"FAIR "
Ill Falls	3	6	" ILL "	"FALLS"
Mine Land	0	7	"MINE "	"LAND "
Rage Road	1	7	"RAGE "	"ROAD "
Muster Pass	2	7	"MUSTR"	"PASS "
One Route	3	7	" ONE "	"ROUTE"
Shoulder Square	0	0	"EXPEC"	"MEET " [unused locs]
Everything Hold	1	0	"EVERY"	"HOLD "
Perilous Siege	2	0	"SHOUL"	"SQUAR"
Camp Concentration	3	0	"PERIL"	"SIEGE"
Space of Waste	1	1	"SPACE"	"WASTE"
Clown Class	0	2	"CLOWN"	"CLASS"
Robbery Highway	0	3	"ROBRY"	"HIWAY"
In-Dignity Heap	7	4	"INDIG"	"HEAP "	["death" rooms]
Beer Pound	7	5	"BEER "	"POUND"
Shape Ship	6	6	"SHAPE"	"SHIP "
Fight Fair	7	6	"FIGHT"	"FAIR "
Criminals' Harbor	4	7	"CRIMN"	"HARBR"
Punishment Capitol	5	7		"PUNSH"	"CAPIT"
Maintenance High	6	7	"MAINT"	"HIGH "
Hut Ten	7	7	" HUT "	" TEN "

book Inform IDE inits

index map with A Round Lounge mapped south of Tension Surface.

index map with Tension Surface mapped south of Pressure Pier.

index map with A Great Den mapped south of Disposed Well.

index map with The Belt Below mapped west of A Great Den.

index map with Service Community mapped east of Idiot Village.

index map with Eternal Hope Springs mapped south of The Belt Below.

[post game]

index map with Out Mist mapped east of Freak Control.

index map with Airy Station mapped east of Out Mist.

[sleep areas]

index map with Tense Past mapped east of Discussion Block.

index map with Tense Present mapped north of Tense Past.

index map with Tense Future mapped north of Tense Present.

[bad ends]

index map with In-Dignity Heap mapped east of Joint Strip.

index map with A Beer Pound mapped east of Soda Club.

index map with Shape Ship mapped east of Smart Street.

index map with Fight Fair mapped east of Shape Ship.

index map with Criminals' Harbor mapped south of A Round Lounge.

index map with Punishment Capitol mapped south of Smart Street.

index map with Maintenance High mapped east of Punishment Capitol.

index map with Hut Ten mapped east of Maintenance High.

[begin oranges = idea-areas]

index map with Camp Concentration mapped west of Freak Control.

index map with Perilous Siege mapped west of Camp Concentration.

index map with Everything Hold mapped west of Perilous Siege.

index map with Shoulder Square mapped west of Everything Hold.

index map with Expectations Meet mapped south of Shoulder Square.

index map with Space of Waste mapped south of Everything Hold.

index map with Clown Class mapped south of Expectations Meet.

index map with Robbery Highway mapped south of Clown Class.

[not really rooms but for neatness's sake]

index map with lalaland mapped east of Tense Present.

index map with bullpen mapped east of Tense Future.

index map with conceptville mapped east of Tense Past.

volume parser errors and undo

Rule for deciding whether all includes a helpy thing when taking: it does not.

terminal-errors is a number that varies.

table of terminal frustration
term-miss	term-text
5	"Okay. This is getting annoying."
20	"You will get it, somehow, some way. You hope."

table of plausible misses
plaus
"acacdbfc"
"acacdcbc"
"acacdcfc"
"acacdfbc"
"acacebfd"
"acacecbd"
"acacecfd"
"acacefbd"
"acadeaef"
"acadfabd"
"acadfade"
"acadfafe"
"adacdbdc"
"adacdbfc"
"adacdcbc"
"adacdcdc"
"adacdced"
"adacdcfc"
"adacdebe"
"adacdede"
"adacdefe"
"adacdfbc"
"adacdfdc"
"adacebde"
"adacecbd"
"adacecbe"
"adacecfd"
"adacecfe"
"adacedbe"
"adacedfe"
"adacefde"
"adadeaef"
"adadfafd"
"adadfafe"
"adecdbae"
"adecdcad"
"adecdfae"
"aeacbcbe"
"aeacdcde"
"bcecfaad"
"bdecdaae"
"ccecfaad"

got-terminal-almost is a truth state that varies.

in-parser-error is a truth state that varies.

rule for printing a parser error when the latest parser error is the didn't understand error:
	if player is in out mist:
		say "Hmm. You need to do something to the ring, but not that. Some action you haven't done yet. There may be more than one[unless remainder after dividing mist-turns by 4 is 3].[no line break][else].[end if]";
		consider the ring clue rule instead;
	if player is in airy station:
		say "Hmm. You need to change the hammer, somehow. There's probably more than one way to do it[unless remainder after dividing hammer-turns by 4 is 3].[no line break][else].[end if]";
		consider the hammer clue rule instead;
	if word number 1 in the player's command is "secrets":
		if number of words in the player's command is 2:
			if word number 2 in the player's command is "open":
				now in-parser-error is true;
				try trackbeatening;
				the rule succeeds;
	if the turn count is 1: [rather cringy hack for G on move 1]
		say "That isn't a recognized verb, or maybe you guessed a preposition wrong. In general, this game tries not to force longer commands. You can type VERB or VERBS to see all the commands and possible prepositions.";
		the rule succeeds;
	if the player's command matches the regular expression "^<0-9>":
		if player is in belt below and terminal is in belt below:
			say "The terminal wants eight letter answers, not a number.";
			the rule succeeds;
		say "Numbers are generally reserved for dialogue, but you're not in one right now.";
		the rule succeeds;
	if player is in belt below and terminal is in belt below:
		let jj be the player's command;
		replace the text " " in jj with "";
		if number of characters in jj is 8:
			if jj matches the regular expression "^<abcdef>*$":
				if ffffffff is false:
					say "The Insanity Terminal emits ";
					let Q be 0;
					if character number 1 in jj is not "a", increment Q;
					if character number 2 in jj is not "b", increment Q;
					if character number 3 in jj is not "a", increment Q;
					if character number 4 in jj is not "d", increment Q;
					if character number 5 in jj is not "f", increment Q;
					if character number 6 in jj is not "a", increment Q;
					if character number 8 in jj is not "e", increment Q;
					if character number 7 in jj is not "c":
						let plau be false;
						repeat through table of plausible misses:
							if jj matches the regular expression "[plaus entry]":
								now plau is true;
								say "The insanity terminal rings some old-fashioned bells, and they don't stop until you look at question 7, which is flashing red. All others have turned green, momentarily. Perhaps, despite the nastiness of the question, you wound up overthinking";
								now got-terminal-almost is true;
						if plau is false:
							say "one of those slow scales that always seem to be ascending. You look down, and it's highlighting question 7. You wonder if you are overthinking that one";
					else if Q > 6:
						say "the loudest gong you ever heard";
					else if Q > 4:
						say "a loud BZZZT";
					else if Q > 2:
						say "a piercing siren tone";
					else:
						say "a soft WOMP WOMP";
				else:
					say "a screech";
				say ". It looks like you'll need to try again.";
				increment terminal-errors;
				repeat through table of terminal frustration:
					if terminal-errors is term-miss entry:
						say "[term-text entry][line break]";
				the rule succeeds;
		say "That isn't a recognized verb, or it's too complex a sentence. If you want to answer the terminal's puzzle, type all eight letter answers in a row. No need for spaces.";
		the rule succeeds;
	if the player is on person chair or player is in round lounge: [give the player a mulligan with guess-the-verb]
		if player has tee:
			if the player's command matches the regular expression "\bhatch\b":
				if the player's command matches the regular expression "\b(tee|t)\b":
					say "(assuming you want to OPEN THE HATCH)[line break]";
					try opening hatch;
					the rule succeeds;
	let Q be number of words in the player's command;
	if Q is 4:
		say "That isn't a recognized verb, or maybe you guessed a preposition wrong. In general, this game tries not to force longer commands. You can type VERB or VERBS to see all the commands and possible prepositions.";
	else:
		say "That isn't a recognized verb";
		if Q > 4:
			say ", or at [if Q > 10]10+[else][Q][end if] words, it might be too complex an order";
		say ", but you can type VERB or VERBS to see them all.";
	reject the player's command;

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	if p-c is true:
		try waiting instead;
	if qbc_litany is table of no conversation:
		say "I'll need a [activation of turn of phrase] here.";
	else:
		say "[activation of break silence]?";
	the rule succeeds;

Rule for printing a parser error when the latest parser error is the can't see any such thing error:
	if mrlp is dream sequence:
		say "Everything swirls in and out so quickly, you can't really grasp it. Just visions, memories, constantly changing. You only seem able to WAIT or THINK or LOOK here." instead;
	if the player is in joint strip:
		if the player's command includes "frog":
			say "'Frog, toad, you people think we're all the same, don't you?' booms the Stool Toad.[paragraph break]With a frog in your throat, you forget what you wanted to do. Eh, well, frog, toad, it's just four letters to type anyway." instead;
		if the player's command includes "chair":
			say "You realize you don't need to do anything fancy with the chair. It's actually well placed under the hatch." instead;
	if the player's command includes "with":
		say "It looks like WITH may be superfluous here. Try and drop it?";
		now the last-command is the player's command;
		if the player yes-consents:
			replace the regular expression "with .*" in the last-command with "";
			now the parser error flag is true;
			say "Trying new command...";
		else:
			say "OK, I can't do much with the command as-is. Sorry.";
		the rule succeeds;
	say "You see nothing there like that. You may want to check for typos or excess words or prepositions."

Rule for printing a parser error when the latest parser error is the nothing to do error:
	if current action is dropping:
		say "You don't need to drop anything in the game, much less all your possessions.";
	else:
		say "Sorry, but right now ALL doesn't encompass anything you need to take. Though, don't worry, this game doesn't require you to mess with a ton of stuff in any one location." instead.

Rule for printing a parser error when the latest parser error is the noun did not make sense in that context error:
	say "The verb was ok, but I couldn't place the noun."

volume weird stuff

to force-status: (- DrawStatusLine(); -);

to debug-freeze: [this is so, in case I want to freeze the game, it doesn't seep into release mode. I should probably put this into my general tools module at some point, along with other things.]
	if debug-state is true:
		say "(any key)";
		wait for any key;
		say "[line break]";

rule for constructing the status line when started-yet is false (this is the status before you move rule) :
	center "Your bedroom, up too late" at row 1;

part meta-rooms

meta-rooms is a region.

chapter lalaland

lalaland is a privately-named room in meta-rooms. "You should never see this. If you do, it is a [bug]."

understand "lalaland" as lalaland when debug-state is true.

chapter bullpen

bullpen is a privately-named room in meta-rooms. "You should never see this. If you do, it is a [bug]." [the bullpen is for items that you dropped when you slept]

understand "bullpen" as bullpen when debug-state is true.

chapter conceptville [xxcv]

to say activation of (x - a thing):
	if gtxt of x is not empty:
		say "[if ital-conc is true][i][end if][gtxt of x][r]";
	else if debug-state is true:
		say "(NO GTXT)";
	now x is in lalaland;

to say f-t of (my-r - a room):
	say "go to the [my-r] for the first time"

to say nogo of (my-r - a room):
	say "go nowhere in [my-r]"

to say x-it of (q - a thing):
	say "examine [the q]";

to say t2 of (q - a thing):
	say "talk to [q]";

to say bga of (pe - a person):
	say "ask [pe] about the [bad-guy]"

conceptville is a privately-named room in meta-rooms. "You should never see this. If you do, it is a [bug]." [this is a cheesy hack, as concepts you haven't seen yet are here, and when you see them, they move to lalaland.]

understand "conceptville" as conceptville when debug-state is true.

section general concepts

abuse testing is a concept in conceptville. Understand "testing abuse" as abuse testing. howto is "credits". gtxt is "testing abuse".

Advance Notice is a concept in conceptville. Understand "notice advance" as Advance Notice. howto is "enter Freak Control". gtxt is "".

Beaten Track is a concept in conceptville. Understand "track beaten" as Beaten Track. howto is "solve the [j-co] puzzle for the first time". gtxt is "".

break silence is a concept in conceptville. Understand "silence break" as break silence. howto is "give no command when you are in a conversation". gtxt is "Silence break".

Captain Obvious is a concept in conceptville. Understand "obvious captain" as captain obvious. howto is "xyzzy". gtxt is "Obvious, Captain".

clouds of suspicion is a concept in conceptville. Understand "suspicion of clouds/cloud" and "cloud of suspicion" as clouds of suspicion. howto is "X U". gtxt is "suspicion of clouds".

Comedy of Errors is a concept in conceptville. Understand "errors of comedy" as comedy of errors. howto is "xyzzy". gtxt is "Errors of comedy".

compound problems is a concept in lalaland. Understand "problems compound" and "compound problem" as compound problems. howto is "very start". gtxt is "Problems Compound".

cut a deal is a concept in conceptville. Understand "deal a cut" as cut a deal. howto is "cut any inanimate thing before Freak Control". gtxt is "deal a cut".

Cut a Figure is a concept in conceptville. Understand "figure a cut" as cut a figure. howto is "get to Nominal Fen". gtxt is "Figure a Cut".

Face the music is a concept in conceptville. Understand "music the face" as face the music. howto is "sing outside the cult or Discussion Block". gtxt is "the music face".

Force of Habit is a concept in conceptville. Understand "habit of force" as force of habit. howto is "attack something inanimate you don't get arrested for". gtxt is "habit of force".

Hard Knock is a concept in conceptville. Understand "knock hard" as Hard Knock. howto is "get to Pressure Pier". gtxt is "".

herd mentality is a concept in conceptville. Understand "heard mentality" and "mentality heard" as herd mentality. howto is "listen in Airy Station". gtxt is "mentality heard".

No-Nonsense is a concept in conceptville. Understand "no nonsense" and "nonsense no" as no-nonsense. howto is "xyzzy". gtxt is "Nonsense? No".

Passing Fancy is a concept in conceptville. Understand "fancy passing" as Passing Fancy. howto is "help all three Keeper Brothers". gtxt is "".

poke fun is a concept in conceptville. Understand "fun poke" as poke fun. howto is "touch someone, or try". gtxt is "fun poke".

second thought is a concept in conceptville. Understand "thought second" as second thought. howto is "THINK early on". gtxt is "thought second".

Sitting Duck is a concept in conceptville. Understand "duck sitting" as Sitting Duck. howto is "get to Tension Surface". gtxt is "".

Spelling Disaster is a concept in conceptville. Understand "disaster spelling" as spelling disaster. howto is "xyzzy". gtxt is "Disaster spelling".

touch base is a concept in conceptville. Understand "base touch" as touch base. howto is "touch someone, or try". gtxt is "base touch".

turn of phrase is a concept in conceptville. Understand "phrase of turn" as turn of phrase. howto is "empty command". gtxt is "phrase of turn".

a u-turn is a concept in conceptville. Understand "u turn" and "turn u" as u-turn. howto is "turn an inanimate object". gtxt is "turn you"

wait your turn is a concept in conceptville. Understand "turn your wait" as wait your turn. howto is "wait". gtxt is "Turn your wait".

wave a flag is a concept in conceptville. Understand "flag a wave" as wave a flag. howto is "wave". gtxt is "flag a wave".

section smart street concepts

acceptable is a concept in conceptville. Understand "able except" and "except able" as acceptable. howto is "[x-it of gesture token]". gtxt is "Able... except".

Beat Off is a concept in conceptville. Understand "off beat" as beat off. howto is "talk to Guy". gtxt is "OFF-BEAT".

Buster Ball is a concept in conceptville. Understand "ball buster" as buster ball. howto is "talking".

confidence games is a concept in conceptville. Understand "games/game confidence" and "confidence game" as confidence games. howto is "talk to Guy". gtxt is "games confidence"

first world problems is a concept in conceptville. Understand "problems first world" and "world first problems" as first world problems. howto is "ask Guy about [bad-guy-2]". gtxt is "Problems First World".

Good Egg is a concept in conceptville. Understand "egg good" as good egg. howto is "talk to Guy". gtxt is "egg GOOD".

Hunter Savage is a concept in conceptville. Understand "savage hunter" as hunter savage. howto is "talking".

knockwurst is a concept in conceptville. Understand "knock worst" and "worst knock" as knockwurst. howto is "knock any way other than hard in Smart Street". gtxt is "worst knock".

mind games is a concept in conceptville. Understand "games mind" as mind games. howto is "very start". gtxt is "games mind".

power games is a concept in conceptville. Understand "games power" as power games. howto is "win your first logic game against Guy Sweet". gtxt is "games power".

chapter surface concepts

section a round lounge concepts

charity is a concept in conceptville. Understand "chair itty" and "itty chair" as charity. howto is "[x-it of person chair]". gtxt is "itty chair".

section tension surface concepts

nose picking is a concept in conceptville. Understand "picking nose" as nose picking. howto is "smell the mush in Tension Surface". gtxt is "picking nose".

section variety garden concepts

Animal Welfare is a concept in conceptville. Understand "welfare animal" as animal welfare. howto is "get the Weasel to sign the Burden". gtxt is "welfare animal".

brush up is a concept in conceptville. Understand "up brush" as brush up. howto is "go up in Variety Garden". gtxt is "up brush that'd remind you you don't REALLY know how to use them".

a thing called brush with greatness is a concept in conceptville. Understand "greatness with brush" as brush with greatness. howto is "examine any brush after becoming a brush sage". gtxt is "greatness with brush".

dirt nap is a concept in conceptville. Understand "nap dirt" as dirt nap. howto is "leave the garden without digging, or sleep when you have the pick". gtxt is "nap dirt".

man enough is a concept in conceptville. Understand "enough man" as man enough. howto is "dig twice with the pick in Variety Garden". gtxt is "Enough, man".

poor taste is a concept in conceptville. Understand "taste poor" as poor taste. howto is "try to eat the poor dirt.". gtxt is "taste poor".

sagebrush is a concept in conceptville. Understand "brush sage" and "sage brush" as sagebrush. howto is "examine all three types of brush in Variety Garden and try going up too". gtxt is "brush sage".

work of art is a concept in conceptville. Understand "art of work" as work of art. howto is "dig once with the pick in Variety Garden". gtxt is "art of work".

section vision tunnel concepts

scum of earth is a concept in conceptville. Understand "earth of scum" as scum of earth. howto is "dig the earth of salt". gtxt is "earth of scum".

chapter outer concepts

section pressure pier concepts

Bible Belt is a concept in conceptville. Understand "belt bible" as bible belt. howto is "try taking the Basher Bible". gtxt is "belt bible".

Boy Howdy is a concept in conceptville. Understand "howdy boy" as Boy Howdy. howto is "get to Pressure Pier". gtxt is "Howdy Boy".

fish out of water is a concept in conceptville. Understand "water out of fish" as fish out of water. howto is "examine the water in Pressure Pier". gtxt is "water: out of fish".

meal ticket is a concept in conceptville. Understand "ticket meal" as meal ticket. howto is "eat the boo tickety". gtxt is "ticket meal".

palatable is a concept in conceptville. Understand "table pal" and "pal table" as palatable. howto is "[x-it of side stand]". gtxt is "a table, pal".

take a stand is a concept in conceptville. Understand "stand a/the take" and "take the stand" as take a stand. howto is "try to take a/the side stand". gtxt is "stand the take".

section meal square concepts

apple pie order is a concept in conceptville. Understand "apple-pie order" and "order apple pie" as apple pie order. howto is "examine both Tray A and Tray B". gtxt is "order apple pie".

arch deluxe is a concept in conceptville. Understand "deluxe arch" as arch deluxe. howto is "[nogo of Meal Square]". gtxt is "deluxe arch".

astray is a concept in conceptville. understand "tray s" and "s tray" as astray. howto is "enter Meal Square". gtxt is "Tray S".

bowled over is a concept in conceptville. understand "over bold" and "bold over" as bowled over. howto is "eat any Tray B food". gtxt is "over-bold".

caveat is a concept in conceptville. Understand "cave eat" and "eat cave" as caveat. howto is "[f-t of meal square]". gtxt is "eat cave".

coffee break is a concept in conceptville. Understand "break coffee" as coffee break. howto is "eat the cutter cookie". gtxt is "Break Coffee".

defeat is a concept in conceptville. Understand "eat def" and "def eat" as defeat. howto is "[x-it of Tray B]". gtxt is "EAT DEF".

devil's food is a concept in conceptville. Understand "food devil's" as devil's food. howto is "eat the gagging lolly". gtxt is "food devils".

ex-tray is a concept in conceptville. understand "x/ex tray" and "tray x/ex" as ex-tray. howto is "enter Meal Square". gtxt is "Tray X".

face off is a concept in conceptville. understand "off face" as face off. howto is "take inventory after eating Tray B food". gtxt is "off face".

a thing called Food for Thought is a concept in conceptville. Understand "thought for food" as food for thought. howto is "visit Meal Square with Terry Sally around". gtxt is "thought for food".

Forgive is a concept in conceptville. Understand "give for" and "for give" as Forgive. howto is "[x-it of condition mint]". gtxt is "GIVE, FOR".

gobbling down is a concept in conceptville. Understand "goblin down" and "down goblin" as gobbling down. howto is "visit Meal Square with Terry Sally around". gtxt is "down goblin".

growing pains is a concept in conceptville. Understand "pain/pains growing" and "growing pain" as growing pains. howto is "eat the offcheese". gtxt is "Pain's growing".

hallway is a concept in conceptville. Understand "hall whey" and "whey hall" as hallway. howto is "visit Meal Square with Terry Sally around". gtxt is "whey hall".

hash table is a concept in conceptville. Understand "table hash" as hash table. howto is "attack the spoon table in Meal Square". gtxt is "table hash".

house special is a concept in conceptville. Understand "special house" as house special. howto is "smell Tray B". gtxt is "special house".

impaler is a concept in conceptville. Understand "imp paler" and "paler imp" as impaler. howto is "visit Meal Square with Terry Sally around". gtxt is "paler imp".

just deserts is a concept in conceptville. Understand "deserts just" as just deserts. howto is "try to eat the cookie or brownie after eating the cheese". gtxt is "Dessert's just".

Loaf Around is a concept in conceptville. Understand "round loaf" and "loaf round" as loaf around. howto is "wait in Meal Square". gtxt is "a round loaf".

No-Shame is a concept in conceptville. printed name is "no shame". Understand "no shame" as No-Shame. howto is "[x-it of condition mint]". gtxt is "SHAME? NO".

order n is a concept in conceptville. Understand "n order" as order n. howto is "attack the spoon table in Meal Square". gtxt is "n order".

pig out is a concept in conceptville. Understand "out pig" as pig out. howto is "TAKE ALL in Meal Square". gtxt is "OUT, PIG".

potty is a concept in conceptville. Understand "pottea" and "teapot" and "pot tea" and "tea pot" as potty. howto is "[f-t of meal square] with innuendo on". gtxt is "teapot". [ok]

quarter pounder is a concept in conceptville. Understand "pounder quarter" as quarter pounder. howto is "[nogo of Meal Square]". gtxt is "pounder quarter".

quisling is a concept in conceptville. Understand "sling a quiz" and "quiz a sling" as quisling. howto is "eat the cutter cookie". gtxt is "sling a quiz".

raising hell is a concept in conceptville. Understand "hell raisin" and "raisin hell" as raising hell. howto is "eat the cutter cookie". gtxt is "hell raisin".

snap decision is a concept in conceptville. Understand "decision snap" as snap decision. howto is "say yes to eating a Tray B food". gtxt is "decision: SNAP".

Spur of the Moment is a concept in conceptville. Understand "moment of the spur" as spur of the moment. howto is "say no to eating a Tray B food". gtxt is "moment of the spur".

strike a balance is a concept in conceptville. understand "balance a strike" as strike a balance. howto is "try to take Tray A or Tray B". gtxt is "balance a strike".

tea tray is a concept in conceptville. understand "tray t/tea" and "t tray" as tea tray. howto is "enter Meal Square". gtxt is "Tray T".

time consuming is a concept in conceptville. Understand "consuming time" as time consuming. howto is "say yes to eating a Tray B food". gtxt is "Consuming time".

treat like dirt is a concept in conceptville. Understand "dirt like treat" as treat like dirt. howto is "[x-it of points brownie]". gtxt is "dirt-like treat".

trefoil is a concept in conceptville. Understand "foil tray" and "tray foil" as trefoil. howto is "[x-it of Tray A]". gtxt is "foil tray".

section down ground concepts

to say w-fr:
	say "give the weed to Fritz"

[todo: two different things lead to brain trust]
Beach Bum is a concept in conceptville. Understand "bum beach" as Beach Bum. howto is "examine the bench in Down Ground". gtxt is "BUM BEACH".

brain trust is a concept in conceptville. Understand "trust brain" as brain trust. howto is "examine dreadful penny or mind of peace". gtxt is "[if the item described is dreadful penny]TRUST A BRAIN[else]trust brain[end if]".

Clip Joint is a concept in conceptville. Understand "joint clip" as clip joint. howto is "listen to Fritz after giving him the weed". gtxt is "joint clip".

Double Jeopardy is a concept in conceptville. Understand "jeopardy double" as Double Jeopardy. howto is "get ticket for sleeping". gtxt is "jeopardy double".

drag along is a concept in conceptville. Understand "along drag" as drag along. howto is "[w-fr]". gtxt is "a long drag".

Dream Ticket is a concept in conceptville. Understand "ticket dream" as dream ticket. howto is "sleep after you got a tickety". gtxt is "ticket dream".

Grammar Police is a concept in conceptville. Understand "police grammar" as grammar police. howto is "[f-t of Down Ground]". gtxt is "police grammar".

ground up is a concept in conceptville. Understand "up ground" as ground up. howto is "go north or south in Down Ground". gtxt is "up ground".

a thing called High and Dry is a concept in conceptville. Understand "dry and high" as high and dry. howto is "listen to Fritz after getting past Pressure Pier but before giving him the weed". gtxt is "dry and high".

a thing called high off the hog is a concept in conceptville. Understand "hog on/off the high" and "high on/off the hog" as high off the hog. howto is "[w-fr]". gtxt is "hog off the high".

high roller is a concept in conceptville. Understand "roller high" as high roller. howto is "look around Down Ground for a bit". gtxt is "Roller High".

joint statement is a concept in conceptville. Understand "statement joint" as joint statement. howto is " [f-t of down ground]". gtxt is "statement joint".

Puff Piece is a concept in conceptville. Understand "peace/piece puff" and "puff peace" as puff piece. howto is "[w-fr]". gtxt is "peace puff".

roll a joint is a concept in conceptville. Understand "role/roll joint" and "role/roll a joint" as roll a joint. howto is "[w-fr]". gtxt is "a joint role".

Sleeper Cell is a concept in conceptville. Understand "cell sleeper" as sleeper cell. howto is "sleep then wait in Down Ground". gtxt is "cell sleeper".

section joint strip concepts

advice is a concept in conceptville. Understand "vice ad" and "ad vice" as advice. howto is "ask the Stool Toad about the Joint Strip". gtxt is "vice ad".

bullfrog is a concept in conceptville. Understand "frog bull" and "bull frog" as bullfrog. howto is "ask the Stool Toad how to get in trouble". gtxt is "frog-bull".

case a joint is a concept in conceptville. Understand "joint a case" as case a joint. howto is "get ticket for exploring the stickweed". gtxt is "a joint case".

do dope is a concept in conceptville. Understand "dope do" as do dope. howto is "wait in Joint Strip". gtxt is "DOPE, DO".

job security is a concept in conceptville. Understand "security job" as job security. howto is "ask the Stool Toad about the Joint Strip". gtxt is "security job".

killer weed is a concept in conceptville. Understand "weed killer" as killer weed. howto is "smell in the Joint Strip". gtxt is "weed killer".

Moral Support is a concept in conceptville. Understand "support moral" as moral support. howto is "[x-it of pigeon stool]". gtxt is "SUPPORT MORAL".

Pigeon English is a concept in conceptville. Understand "english pigeon" as pigeon english. howto is "[x-it of pigeon stool]". gtxt is "English Pigeon".

stop smoking is a concept in conceptville. Understand "smoking stop" as stop smoking. howto is "ask the Stool Toad about the Joint Strip". gtxt is "Smoking Stop".

strip search is a concept in conceptville. Understand "search strip" as strip search. howto is "[nogo of Joint Strip]". gtxt is "search strip".

section soda club concepts

to say ask-ally:
	say "Ask Ally Stout about the Punch Sucker"

bargain is a concept in conceptville. Understand "bar gin" and "gin bar" and "bargin" as bargain. howto is "[nogo of soda club]". gtxt is "gin bar". [ok]

beer nuts is a concept in conceptville. Understand "nuts beer" as beer nuts. howto is "[nogo of soda club]". gtxt is "nuts beer".

boot licker is a concept in conceptville. Understand "licker/liquor boot" and "boot liquor" as boot licker. howto is "visit the Soda Club". gtxt is "liquor boot".

brew a plot is a concept in conceptville. Understand "plot a brew" as brew a plot. howto is "order the Haha Brew in the Soda Club". gtxt is "a plot brew".

genuine is a concept in conceptville. Understand "gen u wine" and "wine u gen" as genuine. howto is "order the Cooler Wine". gtxt is "Wine-U-Gen".

gin rummy is a concept in conceptville. understand "rummy gin" as gin rummy. howto is "ask Ally Stout about drinks". gtxt is "Rummy Gin".

Hip Rose is a concept in conceptville. Understand "rose hip/hips" as Hip Rose. howto is "visit the Soda Club". gtxt is "Hip Rose".

hit the bottle is a concept in conceptville. Understand "bottle the hit" as hit the bottle. howto is "attack Ally Stout". gtxt is "Bottle the hit".

punch drunk is a concept in conceptville. Understand "drunk punch" as punch drunk. howto is "[ask-ally]". gtxt is "drunk punch".

punch line is a concept in conceptville. Understand "line punch" as punch line. howto is "[ask-ally]". gtxt is "Line Punch".

punch out is a concept in conceptville. Understand "out punch" as punch out. howto is "[ask-ally]". gtxt is "Out Punch".

punch ticket is a concept in conceptville. Understand "ticket punch" as punch ticket. howto is "[ask-ally]". gtxt is "Ticket Punch".

rum go is a concept in conceptville. understand "go rum" as rum go. howto is "ask Ally Stout about drinks". gtxt is "Go Rum".

speakeasy is a concept in conceptville. Understand "easy speak" and "speak easy" as speakeasy. howto is "[bga of Ally Stout]". gtxt is "easy-speak".

striptease is a concept in conceptville. Understand "strip teas" and "teas strip" as striptease. howto is "talk to Ally Stout and say good-bye". gtxt is "Teas Strip".

Sucker Punch is a concept in conceptville. Understand "punch sucker" as sucker punch. howto is "visit the Soda Club". gtxt is "Punch Sucker".

tea party is a concept in conceptville. understand "party t/tea" and "t party" as tea party. howto is "visit the Soda Club". gtxt is "Party T".

teetotal is a concept in conceptville. understand "total t" and "t total" as teetotal. howto is "visit the Soda Club". gtxt is "Total T".

chapter main chunk concepts [left to right, then below]

section Nominal Fen concepts

[todo: eliminate dashes that aren't relevant]

to say solve-j:
	say "solve the [j-co]['] puzzle"

to say j-b4:
	say "talk to the [j-co] [if allow-swears is false]with swears on [end if]before reading the Finger Index"

to say j-blab:
	say "listen to random [j-co] babble[if allow-swears is false] with swears on[end if]"

adult content is a concept in conceptville. Understand "content adult" as adult content. howto is "[j-blab]". gtxt is "content adult".

air jordan is a concept in conceptville. Understand "jordan air" as air jordan. howto is "[j-blab]". gtxt is "Jordan Ayer".

anal is a concept in conceptville. Understand "alan" as anal. howto is "[j-blab]". gtxt is "alan".

anapest is a concept in conceptville. Understand "pest anna" and "anna pest" as anapest. howto is "[j-blab]". gtxt is "Pest Anna".

anne frank is a concept in conceptville. Understand "frank anne" as anne frank. howto is "[j-blab]". gtxt is "Frank Ahn".

ballets is a concept in conceptville. Understand "ball lets" and "lets ball" as ballets. howto is "[j-blab]". gtxt is "Let's ball".

Bandanna is a concept in conceptville. Understand "anna bandt/band" and "bandt/band anna" as bandanna. howto is "[j-blab]". gtxt is "Anna Bandt".

beaker is a concept in conceptville. Understand "kirby" as beaker. howto is "[j-blab]". gtxt is "Kirby".

Bechdel is a concept in conceptville. Understand "del beck" and "beck del" as bechdel. howto is "[j-blab]". gtxt is "Del Beck".

beer guts is a concept in conceptville. Understand "guts beer" as beer guts. howto is "[j-blab]". gtxt is "Guts Beer".

belial is a concept in conceptville. Understand "b lyle" and "lyle b" as belial. howto is "[j-blab]". gtxt is "Lyle B".

benedict arnold is a concept in conceptville. Understand "arnold benedict" as benedict arnold. howto is "[j-blab]". gtxt is "Arnold Benedict".

benevolent is a concept in conceptville. Understand "evelyn benn" and "benn evelyn" as benevolent. howto is "[j-blab]". gtxt is "Evelyn Benn".

benjamin is a concept in conceptville. Understand "ben jammin" and "jammin ben" as benjamin. howto is "[j-blab]". gtxt is "jammin['] Ben".

bernoulli is a concept in conceptville. Understand "newly burn" and "burn newly" as bernoulli. howto is "[j-blab]". gtxt is "newly burn".

Black Mark is a concept in conceptville. Understand "mark black" as black mark. howto is "[x-it of quiz pop]". gtxt is "Mark Black".

body slamming is a concept in conceptville. Understand "slamming body" as body slamming. howto is "[j-blab]". gtxt is "slamming body".

bognor regis is a concept in conceptville. Understand "regis bogner" and "bogner regis" as bognor regis. howto is "[j-blab]". gtxt is "Regis Bogner".

bonhomie is a concept in conceptville. Understand "bo nommy" and "nommy bo" as bonhomie. howto is "[j-blab]". gtxt is "nommy bo".

borat is a concept in conceptville. Understand "bo rat" and "rat bo" as borat. howto is "[j-blab]". gtxt is "rat bo".

boring is a concept in conceptville. Understand "bo ring" and "ring bo" as boring. howto is "[j-blab]". gtxt is "ring bo".

bouncing betty is a concept in conceptville. Understand "betty/beddy bouncing" and "beddy bouncing" as bouncing betty. howto is "[j-blab]". gtxt is "beddy bouncing".

box score is a concept in conceptville. Understand "score box" as box score. howto is "[j-blab]". gtxt is "Score Box".

broccoli is a concept in conceptville. Understand "lee brock" and "brock lee" as broccoli. howto is "[j-blab]". gtxt is "Lee Brock".

cacophony is a concept in conceptville. Understand "coco phony" and "phony coco" as cacophony. howto is "[j-blab]". gtxt is "Phony Coco".

call girl is a concept in conceptville. Understand "girl call" as call girl. howto is "[j-blab]". gtxt is "girl call".

cary grant is a concept in conceptville. Understand "grant carey" and "carey grant" as cary grant. howto is "[j-blab]". gtxt is "Grant Carey".

case sensitive is a concept in conceptville. Understand "sensitive case" as case sensitive. howto is "[j-blab]". gtxt is "sensitive case".

casually is a concept in conceptville. Understand "julie kaz" and "kaz julie" as casually. howto is "[j-blab]". gtxt is "Julie Kaz".

category is a concept in conceptville. Understand "gory kate" and "kate gory" as category. howto is "[j-blab]". gtxt is "Gory Kate".

caveman is a concept in conceptville. Understand "cave man" and "man cave" as caveman. howto is "[j-blab]". gtxt is "man cave".

cirrhosis is a concept in conceptville. Understand "roses sir" and "sir roses" as cirrhosis. howto is "[j-blab]". gtxt is "Roses, sir".

Clean Break is a concept in conceptville. Understand "break clean" as clean break. howto is "go to the [jc]". gtxt is "Break CLEAN".

club players is a concept in conceptville. Understand "players club" as club players. howto is "[j-blab]". gtxt is "Players['] Club".

co-ed is a concept in conceptville. Understand "ed coe" and "coe ed" as co-ed. howto is "[j-blab]". gtxt is "Ed Coe".

cojones is a concept in conceptville. Understand "jonesco" and "jones co" and "co jones" as cojones. howto is "[j-blab]". gtxt is "cojones".

commie is a concept in conceptville. Understand "mecom" and "me com" and "com me" as commie. howto is "[j-blab]". gtxt is "MeCom".

Cotton Candy is a concept in conceptville. Understand "candy cotton" as cotton candy. howto is "[j-blab]". gtxt is "Candy Cotton".

covfefe is a concept in conceptville. Understand "cove fefe" and "fefe cove" as covfefe. howto is "[j-blab]". gtxt is "Fefe Cove".

default is a concept in conceptville. Understand "dee fault" and "fault dee" as default. howto is "[j-blab]". gtxt is "fault dee".

defecate is a concept in conceptville. Understand "kate a def" and "def a kate" as defecate. howto is "[j-blab]". gtxt is "Kate? Uh, Def".

dilute is a concept in conceptville. Understand "di lewd" and "lewd di" as dilute. howto is "[j-blab]". gtxt is "lewd Di".

Dirty Word is a concept in conceptville. Understand "word dirty" as dirty word. howto is "go to the [jc]". gtxt is "Word! Dirty".

dust up is a concept in conceptville. Understand "up dust" as dust up. howto is "[j-blab]". gtxt is "Up Dust".

eBay is a concept in conceptville. Understand "basie" as eBay. howto is "[j-blab]". gtxt is "Basie".

electrocute is a concept in conceptville. Understand "cute electra" and "electra cute" as electrocute. howto is "[j-blab]". gtxt is "Cute Electra".

enhance is a concept in conceptville. Understand "hansen" as enhance. howto is "[j-blab]". gtxt is "Hansen".

evidence is a concept in conceptville. Understand "ev dense" and "dense ev" as evidence. howto is "[j-blab]". gtxt is "dense ev".

expat is a concept in conceptville. Understand "x pat" and "pat x" as expat. howto is "[j-blab]". gtxt is "Pat X".

flounder is a concept in conceptville. Understand "flo under" and "under flo" as flounder. howto is "[j-blab]". gtxt is "under Flo".

fluoridated is a concept in conceptville. Understand "dated flora" and "flora dated" as fluoridated. howto is "[j-blab]". gtxt is "dated Flora".

full grown is a concept in conceptville. Understand "grown full" as full grown. howto is "[f-t of nominal fen]". gtxt is "groan-ful".

gangbusters is a concept in conceptville. Understand "buster's/busters/buster gang" and "gang buster/busters/buster's" as gangbusters. howto is "[j-blab]". gtxt is "Buster's Gang".

Glenn Beck is a concept in conceptville. Understand "beck glenn" as glenn beck. howto is "[j-blab]". gtxt is "Beck Glenn".

gorgeous is a concept in conceptville. Understand "jess gore" and "gore jess" as gorgeous. howto is "[j-blab]". gtxt is "Jess Gore".

grown up is a concept in conceptville. Understand "up groan" and "groan up" as grown up. howto is "[solve-j] with swears off". gtxt is "up groan".

halfling is a concept in conceptville. Understand "hall fling" and "fling hall" as halfling. howto is "[j-blab]". gtxt is "Fling Hall".

Hara-Kiri is a concept in conceptville. Understand "keri harrah" and "harrah keri" as hara-kiri. howto is "[j-blab]". gtxt is "Keri Harrah".

henry clay is a concept in conceptville. Understand "clay henry" as henry clay. howto is "[j-blab]". gtxt is "Clay Henry".

hidey hole is a concept in conceptville. Understand "hole hidey" as hidey hole. howto is "[j-blab]". gtxt is "Whole Heidi".

high fidelity is a concept in conceptville. Understand "fidelity high" as high fidelity. howto is "[j-blab]". gtxt is "Fidelity High".

hillary is a concept in conceptville. Understand "hill larry" and "larry hill" as hillary. howto is "[j-blab]". gtxt is "Larry Hill".

hittite is a concept in conceptville. Understand "tight hit" and "hit tight" as hittite. howto is "[j-blab]". gtxt is "'tight' hit".

homer winslow is a concept in conceptville. Understand "winslow homer" as homer winslow. howto is "[j-blab]". gtxt is "slowin['] Homer".

Howard Stern is a concept in conceptville. Understand "stern howard" as Howard Stern. howto is "[j-blab]". gtxt is "stern Howard".

humphrey davy is a concept in conceptville. Understand "davey humphrey" and "humphrey davey" as humphrey davy. howto is "[j-blab]". gtxt is "Davey Humphrey".

Jack London is a concept in conceptville. Understand "london jack" as jack london. howto is "[j-blab]". gtxt is "London Jack".

james dean is a concept in conceptville. Understand "dean james" as james dean. howto is "[j-blab]". gtxt is "Dean James".

jeremiad is a concept in conceptville. Understand "add jeremy" and "jeremy add" as jeremiad. howto is "[j-blab]". gtxt is "add Jeremy".

Jerk Around is a concept in conceptville. Understand "around jerks" and "jerks around" as jerk around. howto is "enter the main area with profanity on". gtxt is "AROUND jerks".

Jerk Off is a concept in conceptville. Understand "off jerk" as jerk off. howto is "attack a jerk in swearing-on mode". gtxt is "off a jerk".

jerry built is a concept in conceptville. Understand "built jerry" as jerry built. howto is "[j-blab]". gtxt is "built Jerry".

jim beam is a concept in conceptville. Understand "beam jim" as jim beam. howto is "[j-blab]". gtxt is "Beam Gym".

jimmy buffett is a concept in conceptville. Understand "buffet jimmy" and "jimmy buffet" as jimmy buffett. howto is "[j-blab]". gtxt is "buffet jimmy".

johnny rotten is a concept in conceptville. Understand "rotten johnny" as johnny rotten. howto is "[j-blab]". gtxt is "rottin['] Johnny".

joint committee is a concept in conceptville. Understand "committee joint" as joint committee. howto is "[solve-j]". gtxt is "committee joint to top it off".

journeyman is a concept in conceptville. Understand "journey man" and "man journey" as journeyman. howto is "[j-blab]". gtxt is "man-journey".

junk mail is a concept in conceptville. Understand "mail junk" as junk mail. howto is "listen to the [j-co] before figuring the Index puzzle". gtxt is "male junk".

keepin is a concept in conceptville. Understand "pinkie" as keepin. howto is "[j-blab]". gtxt is "pinkie".

kevin spacey is a concept in conceptville. Understand "spacey kevin" as kevin spacey. howto is "[j-blab]". gtxt is "spacy Kevin".

Keyser Soze is a concept in conceptville. Understand "suzy kaiser" and "kaiser suzy" as Keyser Soze. howto is "[j-blab]". gtxt is "Suzy Kaiser".

kohlrabi is a concept in conceptville. Understand "robbie cole" and "cole robbie" as kohlrabi. howto is "[j-blab]". gtxt is "Robbie Cole".

a thing called Laverne and Shirley is a concept in conceptville. Understand "shirley and laverne" and "lee shore" and "vern love" and "shore lee" and "love vern" as Laverne and Shirley. howto is "[j-blab]". gtxt is "Lee Shore and Vern Love".

leicester square is a concept in conceptville. Understand "lester square" and "square lester" as leicester square. howto is "[j-blab]". gtxt is "square Lester".

less well is a concept in conceptville. Understand "wallace" as less well. howto is "[j-blab]". gtxt is "wallace".

lie detector is a concept in conceptville. Understand "ly detector" and "detector ly" as lie detector. howto is "[j-blab]". gtxt is "Detector Ly".

lily liver is a concept in conceptville. Understand "liver lily" as lily liver. howto is "[j-blab]". gtxt is "LIVER Lily".

Liverwurst is a concept in conceptville. Understand "wurst/worst liver" and "liver wurst/worst" and "worstliver/wurstliver" as liverwurst. howto is "smell any of the [j-co], or SMELL in the [jc]". gtxt is "liverwurst".

long johns is a concept in conceptville. Understand "john long" and "long john" as long johns. howto is "[j-blab]". gtxt is "John Long".

Lovelies is a concept in conceptville. Understand "lies love" and "love lies" as Lovelies. howto is "listen to all the [j-co] have to say, with swearing on". gtxt is "Lies: LOVE".

magnate is a concept in conceptville. Understand "nate magg" and "magg nate" as magnate. howto is "[j-blab]". gtxt is "Nate Magg".

manicured is a concept in conceptville. Understand "cured manny" and "manny cured" as manicured. howto is "[j-blab]". gtxt is "cured Manny".

Mary Sue is a concept in conceptville. Understand "sue merry" and "merry sue" as mary sue. howto is "[j-blab]". gtxt is "Sue Merry".

mascara is a concept in conceptville. Understand "cara maas" and "maas cara" as mascara. howto is "[j-blab]". gtxt is "Cara Maas".

melodious is a concept in conceptville. Understand "odious mel" and "mel odious" as melodious. howto is "[j-blab]". gtxt is "Odious Mel".

meretricious is a concept in conceptville. Understand "tricias merit" and "merit tricias" as meretricious. howto is "[j-blab]". gtxt is "Tricia's merit".

mike drop is a concept in conceptville. Understand "drop mike" as mike drop. howto is "[j-blab]". gtxt is "drop Mike".

Mollycoddling is a concept in conceptville. Understand "coddling/cuddling molly" and "molly coddling/cuddling" as mollycoddling. howto is "[j-blab]". gtxt is "coddling, err, cuddling Molly".

monte carlo is a concept in conceptville. Understand "carlo monte" as monte carlo. howto is "[j-blab]". gtxt is "Carlo Monty".

mortify is a concept in conceptville. Understand "mort iffy" and "iffy mort" as mortify. howto is "[j-blab]". gtxt is "iffy Mort".

musical chairs is a concept in conceptville. Understand "musical chers" and "chers musical" as musical chairs. howto is "[j-blab]". gtxt is "Cher's musical".

nancy spungen is a concept in conceptville. Understand "spungen nancy" as nancy spungen. howto is "[j-blab]". gtxt is "spongin['] Nancy".

nihilist is a concept in conceptville. Understand "list neil" and "neil list" as nihilist. howto is "[j-blab]". gtxt is "list Neil".

a thing called no-brew is a concept in conceptville. Understand "bruno" as no-brew. printed name is "no brew". howto is "[j-blab]". gtxt is "Bruno".

Nolan Ryan is a concept in conceptville. Understand "ryan nolan" as nolan ryan. howto is "[j-blab]". gtxt is "Ryan Nolan".

nookie is a concept in conceptville. Understand "nookie" as nookie. howto is "[j-blab]". gtxt is "nookie".

Nose Candy is a concept in conceptville. Understand "candy/candi nose/knows" and "nose/knows candy/candi" as nose candy. howto is "[j-blab]". gtxt is "Candi knows".

Notre Dame is a concept in conceptville. Understand "dame noter" and "noter dame" as notre dame. howto is "[j-blab]". gtxt is "Dame Noter".

numb bore is a concept in conceptville. Understand "barnum" as numb bore. howto is "[j-blab]". gtxt is "Barnum".

Olive is a concept in conceptville. Understand "olive green/black" and "green/black olive" as olive. howto is "[j-blab]". gtxt is "Olive Black or Olive Green".

olive drab is a concept in conceptville. Understand "drab olive" as olive drab. howto is "[j-blab]". gtxt is "drab Olive".

Patrick Henry is a concept in conceptville. Understand "henry patrick" as Patrick Henry. howto is "[j-blab]". gtxt is "Henry Patrick".

Paul Ryan is a concept in conceptville. Understand "ryan paul" as Paul Ryan. howto is "[j-blab]". gtxt is "Ryan Paul".

Pepper is a concept in conceptville. Understand "pepper bell/black/serrano/green" and "bell/black/green/serrano pepper" as pepper. howto is "[j-blab]". gtxt is "Pepper Black, Pepper Bell AND Pepper Green".

persephone is a concept in conceptville. Understand "phony percy" and "percy phony" as persephone. howto is "[j-blab]". gtxt is "Phony Percy".

Peter Pan is a concept in conceptville. Understand "pan peter" as peter pan. howto is "[j-blab]". gtxt is "pan Peter".

plaintiff is a concept in conceptville. Understand "tiff plain" and "plain tiff" as plaintiff. howto is "[j-blab]". gtxt is "Tiff? Plain".

planetary is a concept in conceptville. Understand "plain terry" and "terry plain" as planetary. howto is "[j-blab]". gtxt is "Terry Plain".

playboy is a concept in conceptville. Understand "boys/boy play" and "play boy/boys" as playboy. howto is "[j-blab]". gtxt is "boy play".

pocket pool is a concept in conceptville. Understand "pool pocket" as pocket pool. howto is "[j-blab]". gtxt is "Pool Pocket".

Pollyanna is a concept in conceptville. Understand "anna pauley" and "pauley anna" as pollyanna. howto is "[j-blab]". gtxt is "Anna Pauley".

Polygamy is a concept in conceptville. Understand "gamy polly" and "polly gamy" as polygamy. howto is "[j-blab]". gtxt is "Gamy Polly".

polyphony is a concept in conceptville. Understand "phony polly" and "polly phony" as polyphony. howto is "[j-blab]". gtxt is "Phony Polly".

pop cherry is a concept in conceptville. Understand "cherry pop" as pop cherry. howto is "[solve-j] with swears on". gtxt is "cherry pop".

Potter Stewart is a concept in conceptville. Understand "stewart potter" as Potter Stewart. howto is "[j-blab]". gtxt is "Stewart Potter".

pound meat is a concept in conceptville. Understand "meet pound" and "pound meet" as pound meat. howto is "[j-blab]". gtxt is "Meet Pound".

quaalude is a concept in conceptville. Understand "lewd quay" and "quay lewd" as quaalude. howto is "[j-blab]". gtxt is "Lewd Quay".

Ralph Lauren is a concept in conceptville. Understand "lauren ralph" as ralph lauren. howto is "[j-blab]". gtxt is "Lauren Ralph".

record keeper is a concept in conceptville. Understand "keeper record" as record keeper. howto is "[j-blab]". gtxt is "keeper record".

rectally is a concept in conceptville. Understand "ally wrecked" and "wrecked ally" as rectally. howto is "[j-blab]". gtxt is "Ally wrecked".

recur is a concept in conceptville. Understand "curry" as recur. howto is "[j-blab]". gtxt is "curry".

red rose is a concept in conceptville. Understand "rose redd/red/white/blue/black" and "redd/red/white/blue/black" as red rose. howto is "[j-blab]". gtxt is "Rose Redd, Rose White, Rose Black, and especially Rose Blue".

restore is a concept in conceptville. Understand "torres" as restore. howto is "[j-blab]". gtxt is "torres".

ring finger is a concept in conceptville. Understand "finger ring" as ring finger. howto is "[j-b4]". gtxt is "finger ring".

rosetta is a concept in conceptville. Understand "rose etta" and "etta rose" as rosetta. howto is "[j-blab]". gtxt is "Etta Rose".

run by is a concept in conceptville. Understand "byron" as run by. howto is "[j-blab]". gtxt is "Byron".

rusty nail is a concept in conceptville. Understand "nail rusty" as rusty nail. howto is "[j-blab]". gtxt is "nail Rusty".

sausage fest is a concept in conceptville. Understand "fest sausage" as sausage fest. howto is "[solve-j] with swears on". gtxt is "fest sausage".

says mo is a concept in conceptville. Understand "moses" as says mo. howto is "[j-blab]". gtxt is "moses".

Sharp Barb is a concept in conceptville. Understand "barb sharp" as sharp barb. howto is "[j-blab]". gtxt is "Barb Sharpe".

shock jock is a concept in conceptville. Understand "jock shock" as shock jock. howto is "[j-blab]". gtxt is "jock shock".

six-pack is a concept in conceptville. Understand "pack six" and "six pack" as six-pack. howto is "[j-blab] nominal fen". gtxt is "Pack Six".

social norms is a concept in conceptville. Understand "norms social" as social norms. howto is "[j-blab]". gtxt is "Norm's social".

spencer tracy is a concept in conceptville. Understand "tracy spencer" as spencer tracy. howto is "[j-blab]". gtxt is "Tracy Spencer".

spotted dick is a concept in conceptville. Understand "dick spotted" as spotted dick. howto is "[j-blab]". gtxt is "Dick spotted".

sweeney todd is a concept in conceptville. Understand "todd sweeney" as sweeney todd. howto is "[j-blab]". gtxt is "Todd Sweeney".

sympathetic is a concept in conceptville. Understand "sym pathetic" and "pathetic sym" as sympathetic. howto is "[j-blab]". gtxt is "Pathetic Sim".

tallywhacker is a concept in conceptville. Understand "tally wacker" and "wacker tally" as tallywhacker. howto is "[j-blab]". gtxt is "wacker tally".

Tear-Jerk is a concept in conceptville. Understand "jerk-tear" and "tear jerk" and "jerk tear" as Tear-Jerk. howto is "solve the [j-co]['] puzzle". gtxt is "jerk-tear".

terabyte is a concept in conceptville. Understand "bite tara" and "tara bite" as terabyte. howto is "[j-blab]". gtxt is "bite Tara".

teriyaki is a concept in conceptville. Understand "yacky terri" and "terri yacky" as teriyaki. howto is "[j-blab]". gtxt is "Yacky Terri".

terrapin is a concept in conceptville. Understand "pin tera" and "tera pin" as terrapin. howto is "[j-blab]". gtxt is "pin Tera".

tiebreaker is a concept in conceptville. Understand "Ty Breaker" and "Breaker Ty" as tiebreaker. howto is "[j-blab]". gtxt is "Breaker Ty".

turret is a concept in conceptville. Understand "ritter" as turret. howto is "[j-blab]". gtxt is "ritter".

water sports is a concept in conceptville. Understand "sports water" as water sports. howto is "[j-blab]". gtxt is "Sports Water".

wesley so is a concept in conceptville. Understand "so wesley" as wesley so. howto is "[j-blab]". gtxt is "so Wesley".

whistler's mother is a concept in conceptville. Understand "mother whistlers/whistler's/whistler" and "whistler/whitler's mother" as whistler's mother. howto is "[j-blab]". gtxt is "mother whistlers".

you buy is a concept in conceptville. Understand "you buy" and "bay you" as you buy. howto is "[solve-j]". gtxt is "bayou".

section chipper wood concepts

character assassination is a concept in conceptville. Understand "assassination character" as character assassination. howto is "visit Chipper Wood". gtxt is "assassination character".

Play it Cool is a concept in conceptville. Understand "cool it play" as play it cool. howto is "attack Cute Percy". gtxt is "Cool it! Play".

sweetheart deal is a concept in conceptville. Understand "deal sweetheart" as sweetheart deal. howto is "run from Chipper Wood before catching Cute Percy". gtxt is "Deal, sweetheart".

Woodstock is a concept in conceptville. Understand "wood stock" and "stock wood" as woodstock. howto is "sing in Chipper Wood". gtxt is "stock wood".

section the belt below concepts

Terminal Illness is a concept in conceptville. Understand "illness terminal" as terminal illness. howto is "defeat the Insanity Terminal". gtxt is "Illness Terminal".

waste breath is a concept in conceptville. Understand "breadth/breath waste/waist" and "waist/wast breadth/breath" as waste breath. howto is "[x-it of energy waist] after defeating the Insanity Terminal". gtxt is "breadth waist".

section disposed well concepts

Fish for a Compliment is a concept in conceptville. Understand "compliment for a fish" as fish for a compliment. howto is "talk to the story fish with nobody else around". gtxt is "compliment for a fish".

Well Done is a concept in conceptville. Understand "done well" as well done. howto is "try entering the Disposed Well". gtxt is "Done Well".

section classic cult concepts

cargo cult is a concept in conceptville. Understand "cult cargo" as cargo cult. howto is "talk to Grace". gtxt is "cult cargo".

crisis is a concept in conceptville. Understand "sis cry" and "cry sis" as crisis. howto is "say hi to Grace". gtxt is "Sis, Cry".

cult status is a concept in conceptville. Understand "status cult" as cult status. howto is "ask about restoring the googly bowl". gtxt is "status cult".

Defrock is a concept in conceptville. Understand "rock def" and "def rock" as defrock. howto is "talk to Grace". gtxt is "rock DEF".

good herb is a concept in conceptville. Understand "herb good/goode" and "herb good" as good herb. howto is "talk to Pusher Penn or the Goode sisters". gtxt is "Herb[if player is not in classic cult] Goode[end if]".

grace period is a concept in conceptville. Understand "period grace" as grace period. howto is "[bga of Grace Goode]". gtxt is "PERIOD, Grace".

personality cult is a concept in conceptville. Understand "cult personality" as personality cult. howto is "ask Grace about restoring her cult". gtxt is "cult personality".

section truth home concepts

assembly line is a concept in conceptville. Understand "line assembly" as assembly line. howto is "give Lee the rattle". gtxt is "line assembly".

ideological is a concept in conceptville. Understand "logical idea" and "idea logical" as ideological. howto is "listen to all of Sid Lew's advice". gtxt is "Logical idea".

loser is a concept in conceptville. Understand "lew seer" and "seer lew" as loser. howto is "listen to Sid Lew's advice (random)". gtxt is "Seer Lew".

mass production is a concept in conceptville. Understand "production mass" as mass production. howto is "give Lee the rattle". gtxt is "Production mass".

pathologic is a concept in conceptville. Understand "path oh/o logic" and "logic oh/o path" as pathologic. howto is "listen to two-thirds of Sid Lew's advice". gtxt is "Oh, logic path".

psychotherapy is a concept in conceptville. Understand "psycho therapy" and "therapy psycho" as psychotherapy. howto is "listen to one-third of Sid Lew's advice". gtxt is "therapy psycho".

right to privacy is a concept in conceptville. Understand "privacy to write" and "write to privacy" as right to privacy. howto is "give Lee the rattle". gtxt is "privacy to write".

showerproof is a concept in conceptville. Understand "shower proof" and "proof shower" as showerproof. howto is "listen to Sid Lew's advice (random)". gtxt is "proof shower".

sid vicious is a concept in conceptville. Understand "vicious sid" as sid vicious. howto is "listen to Sid Lew's advice (random)". gtxt is "Vicious Sid".

technology is a concept in conceptville. Understand "tech y knowledge" and "knowledge y tech" as technology. howto is "listen to Sid Lew's advice (random)". gtxt is "knowledge y tech".

thp is a privately-named concept in conceptville. printed name is "200 proof". Understand "proof 200" and "200 proof" as thp. howto is "give Lee the rattle". gtxt is "Proof 200".

turing machine is a concept in conceptville. Understand "touring machine" and "machine touring" as turing machine. howto is "listen to Sid Lew's advice (random)". gtxt is "machine touring".

whole truth is a concept in conceptville. Understand "truth whole" as whole truth. howto is "[f-t of Truth Home]". gtxt is "truth hole".

section scheme pyramid concepts

age four is a concept in conceptville. Understand "four age" and "forage" as age four. howto is "decline the Labor Child's offer for help". gtxt is "FORAGE". [ok]

Army Brat is a concept in conceptville. Understand "brat army" as army brat. howto is "enter the scheme pyramid". gtxt is "brat army".

Baby Boomer is a concept in conceptville. Understand "boomer baby" as baby boomer. howto is "enter the Scheme Pyramid". gtxt is "Boomer Baby".

bookworm is a concept in conceptville. Understand "book worm" and "worm book" as bookworm. howto is "[x-it of Finger Index]". gtxt is "Worm Book".

business casual is a concept in conceptville. Understand "casual business" as business casual. howto is "[x-it of deal clothes]". gtxt is "casual business".

child support is a concept in conceptville. Understand "support child" as child support. howto is "talk to the Labor Child before gettiing the contract". gtxt is "Support Child".

Labor of Love is a concept in conceptville. Understand "love of labor" as labor of love. howto is "enter the Scheme Pyramid". gtxt is "love of labor".

slush fund is a concept in conceptville. Understand "fund slush" as slush fund. howto is "decline the Labor Child's offer for help". gtxt is "fund slush".

section speaking plain concepts

to say pl-wa:
	say "put up with some of the Business Show"

to say pl-all:
	say "put up with all of the Business Show"

code golf is a concept in conceptville. Understand "golf code" as code golf. howto is "[pl-wa]". gtxt is "golf code".

cry uncle is a concept in conceptville. Understand "uncle cry" as cry uncle. howto is "[pl-wa]". gtxt is "Uncle, CRY".

Dutch Act is a concept in conceptville. Understand "act dutch" as dutch act. howto is "[pl-wa]". gtxt is "ACT, DUTCH".

Dutch Courage is a concept in conceptville. Understand "courage dutch" as dutch courage. howto is "[pl-wa]". gtxt is "COURAGE, Dutch".

Dutch Reckoning is a concept in conceptville. Understand "reckoning dutch" as dutch reckoning. howto is "[pl-wa]". gtxt is "reckoning, Dutch".

Dutch Treat is a concept in conceptville. Understand "treat dutch" as dutch treat. howto is "type TREAT DUTCH around Uncle Dutch". gtxt is "treat Uncle Dutch".

Fearlessness is a concept in conceptville. Understand "lessness fear" and "fear lessness" as fearlessness. howto is "[pl-wa]". gtxt is "lessness-fear".

hate speech is a concept in conceptville. Understand "speech hate" as hate speech. howto is "attack Turk or Dutch". gtxt is "SPEECH HATE".

platform shoes is a concept in conceptville. Understand "shoes platform" as platform shoes. howto is "climb the fright stage". gtxt is "shoos platform".

Rust Belt is a concept in conceptville. Understand "belt rust" as rust belt. howto is "[pl-wa]". gtxt is "belt rust".

Show Business is a concept in conceptville. Understand "business show" as show business. howto is "Go to the Speaking Plain without eating a Tray B food". gtxt is "BUSINESS SHOW".

show off is a concept in conceptville. Understand "off show" as show off. howto is "listen to all of the Business Show". gtxt is "OFF SHOW".

show our work is a concept in conceptville. Understand "work our show" as show our work. howto is "[pl-wa]". gtxt is "WORK OUR SHOW".

Stand the Pace is a concept in conceptville. Understand "pace the stand" as stand the pace. howto is "[pl-all]". gtxt is "pace the stand".

section temper keep concepts

sound asleep is a concept in conceptville. Understand "asleep sound" as sound asleep. howto is "put the pot in the vent". gtxt is "asleep sound".

venturesome is a concept in conceptville. Understand "you're/youre some vent" and "some vent" as venturesome. howto is "enter the spleen vent". gtxt is "you're some vent".

section questions field concepts

brass ring is a concept in conceptville. Understand "ring brass" as brass ring. howto is "drink the Quiz Pop". gtxt is "RING BRASS".

Brother's Keepers is a concept in conceptville. Understand "brother/brothers keeper/keepers" and "keeper/keepers brother/brothers" as Brother's Keepers. howto is "examine the brothers". gtxt is "Keepers Brothers".

contempt of congress is a concept in conceptville. Understand "congress of contempt" as contempt of congress. howto is "try to re-visit Buddy Best after getting the Circular". gtxt is "Congress of Contempt".

foster brother is a concept in conceptville. Understand "brother foster" as foster brother. howto is "talk to any of the brothers in Questions Field". gtxt is "Brother Foster".

section court of contempt concepts

attorney general is a concept in conceptville. Understand "general attorney" as attorney general. howto is "[f-t of Court of Contempt], innuendo off". gtxt is "general attorney".

bosom buddy is a concept in conceptville. Understand "buddy bosom" as bosom buddy. howto is "[bga of Buddy Best]". gtxt is "buddy bosom".

fair enough is a concept in conceptville. Understand "enough fair" as fair enough. howto is "[x-it of Reasoning Circular]". gtxt is "Enough Fair".

lemon law is a concept in conceptville. Understand "law lemon" as lemon law. howto is "[x-it of buddy best]". gtxt is "law, a lemon".

nutcase is a concept in conceptville. Understand "case/job nut" and "nut case/job" and "case head" and "head case" as nutcase. howto is "[f-t of Court of Contempt], innuendo on". gtxt is "case nut".

prosecutor is a concept in conceptville. Understand "cuter prose" and "prose cuter" as prosecutor. howto is "talk to Buddy Best". gtxt is "cuter prose".

readjust is a concept in conceptville. Understand "read just" and "just read" as readjust. howto is "talk to Buddy Best". gtxt is "Just read.".

section walker street concepts

a thing called Bound and Determined is a concept in conceptville. Understand "bound determined" and "determined bound" as Bound and Determined. howto is "go south in Walker Street". gtxt is "determined bound".

drive into the ground is a concept in conceptville. Understand "ground the into drive" as drive into the ground. howto is "[f-t of Walker Street]". gtxt is "ground into the drive".

Driving Crazy is a concept in conceptville. Understand "crazy driving" as driving crazy. howto is "[x-it of mistake grave]". gtxt is "CRAZY DRIVING".

Watkins Glen is a concept in conceptville. Understand "glen watkins" as watkins glen. howto is "[x-it of mistake grave]". gtxt is "GLEN WATKINS".

wood pusher is a concept in conceptville. Understand "pusher wood" as wood pusher. howto is "enter Pot Chamber after putting Sal to sleep". gtxt is "Pusher Wood".

section standard bog concepts

bog down is a concept in conceptville. Understand "down bog" as bog down. howto is "go down in Standard Bog". gtxt is "down bog".

spell disaster is a concept in conceptville. Understand "disaster spell" as spell disaster. howto is "go north in Standard Bog". gtxt is "disaster spell".

section pot chamber concepts

bum a cigarette is a concept in conceptville. Understand "cigarette a bum" as bum a cigarette. howto is "ask Pusher Penn what's up". gtxt is "a cigarette bum".

crack pipe is a concept in conceptville. Understand "pipe crack" as crack pipe. howto is "listen in the Pot Chamber". gtxt is "pipe crack".

crack up is a concept in conceptville. Understand "up/down/joke crack" and "crack joke/down" as crack up. howto is "ask Pusher Penn what's up". gtxt is "crack, up, down or even joke".

dopamine is a concept in conceptville. Understand "mean dope" and "dope mean" as dopamine. howto is "attack Pusher Penn". gtxt is "a mean dope".

go to pot is a concept in conceptville. Understand "pot to go" as go to pot. howto is "[f-t of Pot Chamber]". gtxt is "Pot to Go".

kilo is a concept in conceptville. Understand "loki" and "ki lo" and "lo ki" as kilo. howto is "ask Pusher Penn about bad stuff". gtxt is "Loki". [ok]

pop pills is a concept in conceptville. Understand "pills pop" as pop pills. howto is "[bga of Pusher Penn]". gtxt is "Pills Pop".

roach dropping is a concept in conceptville. Understand "dropping roach" as roach dropping. howto is "drop the weed or pot". gtxt is "dropping a roach".

time capsule is a concept in conceptville. Understand "capsule time" as time capsule. howto is "[bga of Pusher Penn]". gtxt is "capsule time".

vice admiral is a concept in conceptville. Understand "admiral vice" as vice admiral. howto is "attack Pusher Penn". gtxt is "admiral vice".

weed out is a concept in conceptville. Understand "out weed" as weed out. howto is "take Pusher Penn's wacker weed". gtxt is "out-weed".

section discussion block concepts

artifact is a concept in conceptville. Understand "fact art" and "art fact" as artifact. howto is "[f-t of Discussion Block]". gtxt is "A fact, Art".

babel fish is a concept in conceptville. Understand "fish babel/babble" and "babble fish" as babel fish. howto is "play the fish in Discussion Block". gtxt is "fish babble".

Block Arguments is a concept in conceptville. Understand "arguments block" as block arguments. howto is "get rid of both of Art and Phil". gtxt is "Arguments Block".

Block Creativity is a concept in conceptville. Understand "creativity block" as block creativity. howto is "get rid of one of Art and Phil". gtxt is "Creativity Block".

chamber music is a concept in conceptville. Understand "music chamber" as chamber music. howto is "get rid of Art first in Discussion Block". gtxt is "Music Chamber".

Coals to Newcastle is a concept in conceptville. Understand "new castle to coals" and "newcastle to coals" as Coals to Newcastle. howto is "take song torch". gtxt is "new castle to coals".

counterculture is a concept in conceptville. Understand "counter culture" and "culture counter" as counterculture. howto is "[f-t of discussion block]". gtxt is "Culture Counter".

creative act is a concept in conceptville. Understand "act creative" as creative act. howto is "[f-t of discussion block]". gtxt is "act creative".

Elevator Music is a concept in conceptville. Understand "music elevator" as elevator music. howto is "[f-t of Discussion Block]". gtxt is "music elevator".

lovecraft is a concept in conceptville. Understand "love craft" and "craft love" as lovecraft. howto is "[bga of Art Fine]". gtxt is "craft love".

philistine is a concept in conceptville. Understand "listen phil" and "phil listen" as philistine. howto is "[f-t of Discussion Block]". gtxt is "Listen, Phil".

Play Dumb is a concept in conceptville. Understand "dumb play" as play dumb. howto is "[f-t of Discussion Block]". gtxt is "Dumb play".

shelving the thought is a concept in conceptville. Understand "thought shelving" as shelving the thought. howto is "get rid of Phil first in Discussion Block". gtxt is "the Thought Shelving".

Steal This Book is a concept in conceptville. Understand "book this steal" as Steal This Book. howto is "take book bank". gtxt is "Book This Steal".

wax lyrical is a concept in conceptville. Understand "lyrical wax" as wax lyrical. howto is "sing while holding the poetic wax". gtxt is "lyrical wax".

world record is a concept in conceptville. Understand "record world" as world record. howto is "get rid of Phil". gtxt is "Record World".

section judgment pass concepts

career threatening is a concept in conceptville. Understand "threatening career" as career threatening. howto is "give Officer Petty the Reasoning Circular". gtxt is "Threatening career".

countermand is a concept in conceptville. Understand "counter manned" and "manned counter" as countermand. howto is "[x-it of intuition counter] once Officer Petty is gone". gtxt is "manned counter".

pass the torch is a concept in conceptville. Understand "torch the pass" as pass the torch. howto is "BURN anything in Judgment Pass". gtxt is "torch the pass".

scofflaw is a concept in conceptville. Understand "scoff law" and "lawscoff/law-scoff/scoff-law" and "law scoff" as scofflaw. howto is "give Officer Petty the Reasoning Circular". gtxt is "law-scoff".

section idiot village concepts

Candidate Dummy is a concept in conceptville. Understand "dummy candidate" as Candidate Dummy. howto is "talk to Sly". gtxt is "Candidate Dummy".

code monkey is a concept in conceptville. Understand "monkey code" as code monkey. howto is "talk to the Business Monkey". gtxt is "monkey code".

grease monkey is a concept in conceptville. Understand "monkey grease" as grease monkey. howto is "[x-it of Business Monkey]". gtxt is "monkey grease".

serve you right is a concept in conceptville. Understand "right you serve" as serve you right. howto is "[x-it of service memorial]". gtxt is "RIGHT, [b]YOU[r] SERVE".

village people is a concept in conceptville. Understand "people village" as village people. howto is "go west in idiot village". gtxt is "people village".

section service community concepts

idle gossip is a concept in conceptville. Understand "gossip idle" as idle gossip. howto is "[x-it of thoughts idol]". gtxt is "gossip idol".

section freak control concepts

to say fr-ran:
	say "wait and listen to the [bad-guy] in Freak Control"

to say fr-pb:
	say "visit Freak Control after eating the Points Brownie"

to say ok-end:
	say "defeat the [bad-guy] without rescuing Idiot Village"

artemis fowl is a concept in conceptville. Understand "foul miss artie" and "artie miss foul" as artemis fowl. howto is "[fr-ran]". gtxt is "Foul miss, Artie".

autocratic is a concept in conceptville. Understand "craddock auto" and "auto craddock" as autocratic. howto is "[fr-ran]". gtxt is "Craddock Auto".

beholder of the eye is a concept in conceptville. Understand "eye the of beholder" as beholder of the eye. howto is "[x-it of Witness Eye]". gtxt is "beholder of the eye".

benefactor is a concept in conceptville. Understand "factor benny" and "benny factor" as benefactor. howto is "[fr-ran]". gtxt is "factor BENNY".

Beyond Belief is a concept in conceptville. Understand "belief beyond" as Beyond Belief. howto is "get the [bad-guy]'s attention". gtxt is "belief beyond".

breadwinner is a concept in conceptville. Understand "winner bread" and "winner bread" as breadwinner. howto is "[fr-pb]". gtxt is "winner bread".

The Break Jail is a concept in conceptville. Understand "jail break" as Break Jail. howto is "[ok-end]". gtxt is "BREAK JAIL".

Break Monotony is a concept in conceptville. Understand "monotony break" as break monotony. howto is "wait for the [bad-guy] to go through his actions". gtxt is "monotony break".

a thing called breaking and entering is a concept in conceptville. Understand "entering and breaking" as breaking and entering. howto is "attack scenery in Freak Control". gtxt is "Entering and breaking".

busy work is a concept in conceptville. Understand "work busy" as busy work. howto is "[fr-ran]". gtxt is "Work ... busy ...".

butter up is a concept in conceptville. Understand "up butter" as butter up. howto is "[fr-pb]". gtxt is "up butter".

carry over is a concept in conceptville. Understand "over carry" as carry over. howto is "[fr-ran]". gtxt is "over Carrie".

chowderhead is a concept in conceptville. Understand "chowder head" and "head chowder" as chowderhead. howto is "[fr-pb]". gtxt is "head chowder".

City Slicker is a concept in conceptville. Understand "slicker city" as City Slicker. howto is "[bad-guy] dialog". gtxt is "Slicker City".

Cruise Control is a concept in conceptville. Understand "control cruise" as cruise control. howto is "[fr-ran]". gtxt is "Control Cruise".

curry favor is a concept in conceptville. Understand "favor curry" as curry favor. howto is "[fr-pb]". gtxt is "favor curry".

Daily Show is a concept in conceptville. Understand "show daily" as daily show. howto is "[fr-ran]". gtxt is "show daily".

degenerate is a concept in conceptville. Understand "d generate" and "generate d" as degenerate. howto is "[fr-ran]". gtxt is "generate D".

difference of opinion is a concept in conceptville. Understand "opinion of difference" as difference of opinion. howto is "get the [bad-guy]'s attention". gtxt is "opinion of difference".

disorder is a concept in conceptville. Understand "order dis" and "dis order" as disorder. howto is "[fr-ran]". gtxt is "Order Dis".

dual vision is a concept in conceptville. Understand "vision duel" and "duel vision" as dual vision. howto is "[fr-ran]". gtxt is "vision duel".

elitist is a concept in conceptville. Understand "leetest e/ee/eee/eeee" and "eeee/eee/ee/e leetest" as elitist. howto is "[fr-ran]". gtxt is "Leetest! Eeee".

energy crisis is a concept in conceptville. Understand "crisis energy" as energy crisis. howto is "get the [bad-guy]'s attention". gtxt is "Crisis Energy".

evil eye is a concept in conceptville. Understand "i evil" and "evil i" as evil eye. howto is "[fr-ran]". gtxt is "I?!? Evil".

Ezra Pound is a concept in conceptville. Understand "pound ezra" as ezra pound. howto is "[fr-ran]". gtxt is "pound Ezra".

face facts is a concept in conceptville. Understand "facts face" as face facts. howto is "talk to the [bad-guy]". gtxt is "facts face".

fanatic is a concept in conceptville. Understand "attic fan" and "fan attic" as fanatic. howto is "[fr-ran]". gtxt is "attic fan".

fatigue duty is a concept in conceptville. Understand "duty fatigue" as fatigue duty. howto is "[fr-ran]". gtxt is "Duty fatigue".

fawn over is a concept in conceptville. Understand "over fawn" as fawn over. howto is "[fr-ran]". gtxt is "OVER Fawn".

following my gut is a concept in conceptville. Understand "gut my following" as following my gut. howto is "get the [bad-guy]'s attention". gtxt is "gut my following".

Freak Out is a concept in conceptville. Understand "out freak" as freak out. howto is "read the Language sign". gtxt is "OUT, FREAK".

gravy train is a concept in conceptville. Understand "train gravy" as gravy train. howto is "[fr-pb]". gtxt is "train gravy".

grunt work is a concept in conceptville. Understand "work grunt" as grunt work. howto is "listen in Freak Control". gtxt is "work grunt".

guttersnipe is a concept in conceptville. Understand "snipe gutter" and "gutter snipe" as guttersnipe. howto is "eat the off cheese and 'win'". gtxt is "Snipe Gutter". [ok]

half right is a concept in conceptville. Understand "right half" as half right. howto is "[bad-guy] dialog". gtxt is "right half".

Howard Dean is a concept in conceptville. Understand "dean howard" as howard dean. howto is "[fr-ran]". gtxt is "Dean Howard".

Infomania is a concept in conceptville. Understand "info mania" and "mania info" as infomania. howto is "[fr-ran]". gtxt is "Mania Info".

informally is a concept in conceptville. Understand "ally inform" and "inform ally" as informally. howto is "[fr-ran]". gtxt is "Ally, Inform".

John Hancock is a concept in conceptville. Understand "hancock john" as john hancock. howto is "[fr-ran]". gtxt is "Hancock john".

John Oliver is a concept in conceptville. Understand "oliver jahn" and "jahn oliver" as john oliver. howto is "[fr-ran]". gtxt is "Stewart Jahn".

John Stewart is a concept in conceptville. Understand "stewart jahn" and "jahn stewart" as john stewart. howto is "[fr-ran]". gtxt is "Oliver Jahn".

Johns Hopkins is a concept in conceptville. Understand "hopkins johns" as johns hopkins. howto is "[fr-ran]". gtxt is "Hopkins johns".

King Henry is a concept in conceptville. Understand "henry king" as king henry. howto is "[fr-ran]". gtxt is "Henry King got one".

laughingstock is a concept in conceptville. Understand "laughing stock" and "stock laughing" as laughingstock. howto is "talk to the [bad-guy]". gtxt is "stock laughing".

Leading Question is a concept in conceptville. Understand "question leading" as leading question. howto is "[fr-ran]". gtxt is "question leading".

mistruth is a concept in conceptville. Understand "miss truth" and "truth miss" as mistruth. howto is "[fr-ran]". gtxt is "Ruth missed so much by not listening to the exciting stories I offered to share to her".

mug shot is a concept in conceptville. Understand "shot mug" as mug shot. howto is "get the [bad-guy]'s attention". gtxt is "shot mug".

narcissist is a concept in conceptville. Understand "assist narc" and "narc assist" as narcissist. howto is "[fr-ran]". gtxt is "assist-narc".

Off the Record is a concept in conceptville. Understand "record the off" as off the record. howto is "[fr-ran]". gtxt is "record the off".

order of operations is a concept in conceptville. Understand "operations of order" as order of operations. howto is "[fr-ran]". gtxt is "operations of order".

oscar wilde is a concept in conceptville. Understand "wilde/wild oscar" and "oscar wild" as oscar wilde. howto is "[fr-ran]". gtxt is "Wild Oscar".

pad accounts is a concept in conceptville. Understand "accounts pad" as pad accounts. howto is "[fr-ran]". gtxt is "accounts pad".

paddywagon is a concept in conceptville. Understand "waggin patty" and "patty waggin" as paddywagon. howto is "[fr-ran]". gtxt is "Waggin['] Patty".

pea brain is a concept in conceptville. Understand "brain pea" as pea brain. howto is "[fr-pb]". gtxt is "brain pea".

pharisee is a concept in conceptville. Understand "see farrah" and "farrah see" as pharisee. howto is "[fr-ran]". gtxt is "See, Farrah".

polygraph is a concept in conceptville. Understand "graph polly" and "polly graph" as polygraph. howto is "[fr-ran]". gtxt is "graph Polly".

Power Trip is a concept in conceptville. Understand "trip power" as power trip. howto is "wait for the [bad-guy] to go through his actions". gtxt is "POWER TRIP".

pratfall is a concept in conceptville. Understand "prat fall" and "fall prat" as pratfall. howto is "[bad-guy] dialog". gtxt is "Fall, prat".

Psychoanalyst is a concept in conceptville. Understand "list anna" and "anna list" and "analyst" as psychoanalyst. howto is "[fr-ran]". gtxt is "list Anna: psycho". [ok]

Putin is a concept in conceptville. Understand "input" and "put in" and "in put" as putin when freak control is visited. howto is "[fr-ran]". gtxt is "Input". [ok]

race baiting is a concept in conceptville. Understand "baiting race" as race baiting. howto is "[fr-ran]". gtxt is "baiting race".

reactionary is a concept in conceptville. Understand "airy reaction" and "reaction airy" as reactionary. howto is "talk to the [bad-guy] before guessing the right action". gtxt is "airy reaction".

red alert is a concept in conceptville. Understand "alert red/read" and "read alert" as red alert. howto is "[fr-ran]". gtxt is "Alert? Read".

relief is a concept in conceptville. Understand "leif rhee" and "rhee leif" as relief. howto is "[bad-guy] dialog". gtxt is "Leif Rhee".

running gag is a concept in conceptville. Understand "gag running" as running gag. howto is "go south twice in Freak Control". gtxt is "Running! Gag".

salad days is a concept in conceptville. Understand "daze salad" and "salad daze" as salad days. howto is "[fr-pb]". gtxt is "daze salad".

scuzz bucket is a concept in conceptville. Understand "scum bucket" and "bucket scuzz/scum" as scuzz bucket. howto is "[x-it of list bucket]". gtxt is "bucket scuzz or scum".

see if i care is a concept in conceptville. Understand "care i if see" as see if i care. howto is "[fr-pb]". gtxt is "care if I see".

see you later is a concept in conceptville. Understand "later you see" as see you later. howto is "[fr-ran]". gtxt is "Later, you see".

serve one right is a concept in conceptville. Understand "right one serve" as serve one right. howto is "get the [bad-guy]'s attention". gtxt is "one right serve".

sly dog is a concept in conceptville. Understand "dog sly" as sly dog. howto is "[fr-ran]". gtxt is "dog Sly".

stake a claim is a concept in conceptville. Understand "acclaim stake" and "stake acclaim" as stake a claim. howto is "[fr-pb]". gtxt is "acclaim stake".

Stand out is a concept in conceptville. Understand "doubt stan" and "stan doubt" as stand out. howto is "[fr-ran]". gtxt is "doubt Stan".

stupor is a concept in conceptville. Understand "poor stu" and "stu poor" as stupor. howto is "[fr-ran]". gtxt is "poor Stu".

taste buds is a concept in conceptville. Understand "bud's/buds taste" and "taste bud's" as taste buds. howto is "[fr-ran]". gtxt is "Bud's taste"

Trevor Noah is a concept in conceptville. Understand "noah trevor" as trevor noah. howto is "[fr-ran]". gtxt is "Noah Trevor".

Tucker Max is a concept in conceptville. Understand "max tucker" as Tucker Max. howto is "[fr-ran]". gtxt is "Max Tucker".

Wallace Shawn is a concept in conceptville. Understand "shawn wallace" as wallace shawn. howto is "[fr-ran]". gtxt is "Shawn Wallace said THAT".

Wire Fraud is a concept in conceptville. Understand "fraud wire" as Wire Fraud. howto is "[bad-guy] dialog". gtxt is "Fraud Wire".

zeroin is a privately-named concept in conceptville. printed name is "zero in". Understand "in zero" and "zero in" as zeroin. howto is "[ok-end]". gtxt is "IN, ZERO".

section out mist concepts

mistracing is a concept in conceptville. Understand "mist racing" and "racing mist" as mistracing. howto is "[nogo of Out Mist]". gtxt is "racing mist".

mystify is a concept in conceptville. Understand "mist iffy" and "iffy mist" as mystify. howto is "[nogo of Out Mist]". gtxt is "iffy mist".

section airy station concepts

case insensitive is a concept in conceptville. Understand "insensitive case" as case insensitive. howto is "attack the Return Carriage". gtxt is "insensitive case".

clear waivers is a concept in conceptville. Understand "waivers/wavers clear" and "clear wavers" as clear waivers. howto is "try going any direction in Airy Station". gtxt is "Wavers, clear".

chapter fake death concepts

section Criminals' Harbor concepts

to say ch-end:
	say "get sent to Criminals['] Harbor (e.g. vandalize scenery in Freak Control)"

gangplank is a concept in conceptville. Understand "gang plank" and "plank gang" as gangplank. howto is "[ch-end]". gtxt is "Plank Gang".

hate crime is a concept in conceptville. Understand "crime hate" as hate crime. howto is "[ch-end]". gtxt is "crime hate".

section fight fair concepts

to say ff-end:
	say "visit Fight Fair (attack random person)"

Boss Fight is a concept in conceptville. Understand "fight boss" as boss fight. howto is "[ff-end]". gtxt is "Fight Boss".

Sore Loser is a concept in conceptville. Understand "loser sore" as sore loser. howto is "[ff-end]". gtxt is "loser sore".

section Hut Ten concepts

corporal punishment is a concept in conceptville. Understand "punishment corporal" as corporal punishment. howto is "vandalize scenery/games before Freak Control". gtxt is "Punishment Corporal".

generalist is a concept in conceptville. Understand "general list" and "list general" as generalist. howto is "[f-t of hut ten]". gtxt is "List General".

section In-Dignity Heap concepts

steel will is a concept in conceptville. Understand "will steel" as steel will. howto is "swear around an authority figure". gtxt is "Will Steele".

section Maintenance High concepts

self sufficient is a concept in conceptville. Understand "sufficient self" as self sufficient. howto is "eat the lolly or gum". gtxt is "sufficient self".

section Punishment Capitol concepts

prisoners of war is a concept in conceptville. Understand "war of prisoners" as prisoners of war. howto is "attack an ally of the [bad-guy]". gtxt is "War of Prisoners".

section shape ship concepts

to say ss-end:
	say "visit Shape Ship (get fifth tickety outside of Soda Club)"

Censorship is a concept in conceptville. Understand "ship censor" and "censor ship" as censorship. howto is "[ss-end]". gtxt is "Ship Censer".

Courtship is a concept in conceptville. Understand "court ship" and "ship court" as courtship. howto is "[ss-end]". gtxt is "Ship Court".

Scholarship is a concept in conceptville. Understand "scholar ship" and "ship scholar" as scholarship. howto is "[ss-end]". gtxt is "Ship Scholar".

chapter director's cut concepts

section rage road concepts

road pizza is a concept in conceptville. Understand "pizza road" as road pizza. howto is "visit Rage Road in the Directors['] Cut". gtxt is "Pizza Road".

chapter lalaland concepts

chapter endgame concepts

Complain Cant is a concept in conceptville. Understand "cant complain" as Complain Cant. howto is "eat the off cheese and 'win'". gtxt is "Can't Complain".

Much Flatter is a concept in conceptville. Understand "flatter much" as Much Flatter. howto is "eat the points brownie and 'win'". gtxt is "Flatter Much".

People Power is a concept in conceptville. Understand "power people" as People Power. howto is "eat the greater cheese and 'win'". gtxt is "Power People".

Received Wisdom is a concept in conceptville. Understand "wisdom received" as received wisdom. howto is "get past Freak Control and get either good ending". gtxt is "Wisdom Received".

Something Mean is a concept in conceptville. Understand "mean something" as Something Mean. howto is "eat the cutter cookie and 'win'". gtxt is "Mean Something".

[end concepts]

volume rule replacements

the can't insert into what's not a container rule is not listed in any rulebook.

the can't put onto something being carried rule is not listed in any rulebook.

check putting it on:
	try tying noun to second noun instead;
	say "That doesn't seem to fit." instead;

the can't put onto what's not a supporter rule is not listed in any rulebook.

understand "put [thing]" as a mistake ("PUT is too vague for the parser. You need to PUT something ON or IN something else.")

book reading a command

period-warn is a truth state that varies.
dash-warn is a truth state that varies.
apostrophe-warn is a truth state that varies.

after reading a command:
	if parser error flag is false:
		if the player's command matches the regular expression "^\p" or the player's command matches the regular expression "^<\*;>":
			if currently transcripting:
				say "(Noted.)";
				reject the player's command;
		if player is in belt below and terminal is in belt below:
			if the player's command matches the regular expression "^answer ":
				replace the regular expression "^answer " in the player's command with "";
		if the player's command matches the regular expression "^talk to": [a hack for TALK TO vs TALK giving a non-awkward disambiguation]
			replace the regular expression "^talk to" in the player's command with "talk";
	if the player's command matches the text "-":
		replace the text "-" in the player's command with " ";
		if dash-warn is false:
			now dash-warn is true;
			say "(NOTE: Dashes aren't needed and will be changed to spaces.)[paragraph break]";
	if the player's command matches the text "'":
		replace the text "'" in the player's command with "";
		if apostrophe-warn is false:
			now apostrophe-warn is true;
			say "(NOTE: Apostrophes aren't needed and will be changed to no character.)[paragraph break]";
	if period-warn is false:
		if the player's command matches the regular expression " ":
			if the player's command matches the regular expression "\.":
				now period-warn is true;
				ital-say "extended commands may cause errors in rare cases such as E.N.W.GIVE X TO Y. This shouldn't happen often, but for future reference, it's a part of Inform parsing I never figured out. If you need to move around, GO TO is the preferred verb.";
	if word number 1 in the player's command is "secrets":
		replace the regular expression "secrets," in the player's command with "secrets";
	if player is in Nominal Fen and jerk-who-short is true and boris is in Nominal Fen and qbc_litany is table of no conversation:
		if the player's command matches the regular expression "^<0-9>+":
			change the text of the player's command to "guess [the player's command]";
			d "[the player's command]";
	if player is in belt below and insanity terminal is in belt below:
		if the player's command matches the regular expression "^<0-9>+":
			change the text of the player's command to "x [the player's command]";
	if anno-allow is true and qbc_litany is table of no conversation:
		if the player's command matches the regular expression "^<0-9>+":
			change the text of the player's command to "note [the player's command]";
	if player is in out mist:
		if the player's command includes "mist":
			if word number 1 in the player's command is "take":
				say "That's not easy, and it'd be, well, a mistake.";
				reject the player's command;
			unless the player's command includes "xp" or the player's command includes "explain":
				say "The mist doesn't seem as important as the ring." instead;
		if the player's command matches the regular expression "^ring<a-z>":
			replace the regular expression "^ring" in the player's command with "ring ";
		if the player's command matches the regular expression "<a-z>ring$":
			replace the regular expression "ring$" in the player's command with " ring";
		if the player's command includes "ring" and the player's command includes "the":
			note-thes;
			replace the regular expression "\bthe\b" in the player's command with "";
		if the player's command includes "ring":
			let temp be number of words in player's command;
			if temp > 2 and the player's command includes "worm", decrement temp;
			if temp is 1:
				say "But what to do with the ring?";
			else if temp > 2:
				say "No, too complex. Just a one-word action.";
			else:
				if word number 1 in the player's command is "ring":
					now word-req is 2;
				else:
					now word-req is 1;
				try-ring-poss;
			reject the player's command;
		if the player's command matches the regular expression "^worm<a-z>":
			replace the regular expression "^worm" in the player's command with "worm ";
		if the player's command matches the regular expression "<a-z>worm$":
			replace the regular expression "worm$" in the player's command with " worm";
		if the player's command includes "worm" and the player's command includes "the":
			note-thes;
			replace the regular expression "\bthe\b" in the player's command with "";
	if player is in airy station:
		if the player's command matches the regular expression "^hammer<a-z>":
			replace the regular expression "^hammer" in the player's command with "hammer ";
		if the player's command matches the regular expression "<a-z>hammer$":
			replace the regular expression "hammer$" in the player's command with " hammer";
		if the player's command includes "hammer" and the player's command includes "the":
			note-thes;
			replace the regular expression "\bthe\b" in the player's command with "";
		if the player's command includes "hammer":
			if word number 1 in the player's command is "hammer":
				now word-req is 2;
			else:
				now word-req is 1;
			try-hammer-poss;
			reject the player's command;
		if the player's command includes "lock" or the player's command includes "caps":
			say "The lock caps remain solid. Maybe you could augment the hammer, though.";
			consider the hammer clue rule;
			reject the player's command;
		if the player's command includes "key" or the player's command includes "keys":
			say "The lock caps are sort of keys, or a key. But they can't work on themselves. You probably want to focus on the hammer.";
			consider the hammer clue rule;
			reject the player's command;

to note-thes:
	say "(You don't need 'the' here. Just a two-word command.)[line break]";

word-req is a number that varies.

to try-ring-poss:
	repeat through table of ring tries:
		if word number word-req in the player's command is wordtry entry:
			if there is no tryresp entry:
				if word-req is 2:
					say "Close! Very.";
					consider the ring clue rule;
					continue the action;
				now end-index is right-act;
				good-end;
				consider the shutdown rules;
				continue the action;
			say "[tryresp entry][line break]";
			continue the action;
	say "Nothing happens to the ring. It sits there as lumpy and round and impenetrable as before, not quite spacy enough to enter, not quite straight enough to follow anywhere.";
	consider the ring clue rule;

to decide which number is right-act:
	if the player's command matches the regular expression "\bcaps\b":
		decide on -1;
	if the player's command matches the regular expression "\bchange\b":
		decide on 1;
	if the player's command matches the regular expression "\bhollow\b":
		decide on 2;
	if the player's command matches the regular expression "\btone\b":
		decide on 3;
	decide on 0;

table of ring tries [xxtrt]
wordtry	tryresp
"change"	--
"tone"	--
"hollow"	-- [the 3 right ones]
"clear"	"You can't move the ring or mist away, but you can make it feel less solid on the inside."
"ear"	"You aren't rebellious enough to pierce, well, anything."
"examine"	"[ring-x]."
"false"	"Well, not false...but a word like it."
"finger"	"You poke at the ring, and it seems like it could be scooped out, the right way."
"leader"	"[r-m-l]."
"let"	"Your hair curls at the thought of such passivity."
"like"	"You sort of like the ring the way it is, but you'd like it much better another way."
"master"	"[r-m-l]."
"right"	"That has the right ring, but maybe not quite the right note, or melody."
"ring"	"You hear in your head the sound from an old rotary phone. It's so different these days when someone calls you up."
"true"	"You know your Tolkein, but somehow, you think, showing up its falsehood might be the way to go."
"x"	"[ring-x]."

to say ring-x:
	say "It's circular and seems to be almost eating itself, Ouroborous-style, though it looks a bit slushy on the inside that you can see. You can't quite enter it, but maybe if it straightened out into a regular worm...or if you made it less fat, or thick, or dense, or maybe wide, with the hole being too small...so many possibilities, but maybe the right thing (or things) to do will be simple"

to say r-m-l:
	say "You're RUNNING from the [word number word-req in the player's command], and you've already spent time mastering the Problems Compound"

to try-hammer-poss:
	repeat through table of hammer tries:
		if word number word-req in the player's command is wordtry entry:
			if there is no tryresp entry:
				if word-req is 2:
					say "Close! Very.";
					consider the hammer clue rule;
					continue the action;
				best-end;
				consider the shutdown rules;
				continue the action;
			say "[tryresp entry][line break]";
			continue the action;
	say "You look at the hammer, hoping it will change, but nothing happens. Maybe another word.";
	consider the ring clue rule;

end-index is a number that varies.

to best-end:
	let q be right-adj;
	now end-index is q;
	if q is 1:
		say "The hammer glows a bit. You feel it pulling you towards the lock caps. Its claw end grabs one after another, strangling them until they pop off.";
	else if q is 2:
		say "The hammer glows a bit. You feel it pulling your arm up. The hammer crackles a bit, and you slam it down on the lock caps, which fall quickly.";
	else if q is 3:
		say "The hammer glows a bit. You feel it swinging side to side, and before it touches the lock caps, they crack open and fall to the ground.";
	else:
		say "Oops. Bug. This should never happen. But it won't stop you winning the game. I would like to know what command you used, though: [email].";
	say "[line break]The door to the Return Carriage creaks open. You wave to the crowd as you enter the Return Carriage. You think of all the people you helped, the smart-alecks you didn't let get you down. The clues won't be as obvious back home, but you see some people are full of hot air, and you can overcome them, and that's a relief.";
	go-back-home;

to decide which number is right-adj:
	if the player's command matches the regular expression "\bcaps\b":
		decide on -1;
	if the player's command matches the regular expression "\block\b":
		decide on 1;
	if the player's command matches the regular expression "\bhome\b":
		decide on 2;
	if the player's command matches the regular expression "\baway\b":
		decide on 3;
	decide on 0;


table of hammer tries [xxtht]
wordtry	tryresp
"away"	--
"home"	--
"lock"	--
"age"	"You've already grown up a bit, and you don't need to get drunk."
"ban"	"You do feel confident you could now be an Internet forum mod and curb some silliness. But--if you banned the hammer, you'd never get back home."
"blow"	"[if allow-swears is true]The hammer is small enough to put in your mouth, but, no. This isn't that kind of game[else][one of]You blow on the hammer and wipe it off. It looks nice and shiny[or]You already cleaned the hammer a bit[stopping]."
"down"	"You've already put the hammer down in the [bad-guy], and you don't need or want to make everyone else feel down."
"emcee"	"[stanley-burrell]."
"examine"	"[x-hammer]."
"fall"	"It's not seasons, but maybe distance, or maybe getting rid of the caps."
"hammer"	"Too brute force. It needs to be a different sort of hammer."
"head"	"You don't need to beat yourself up, or have a vicious shark do the honors, to change the hammer into what you need to. It's probably the best hammer for the purpose, too."
"jack"	"There's probably someone named Jack in the crowd, but even if he deserved it, it'd take too long to go and ask."
"mc"	"[stanley-burrell]."
"man"	"[stanley-burrell]."
"ninny"	"This is a nonviolent mistake, and besides, everyone here has been slandered as an idiot, not a ninny."
"sledge"	"If there were a sledge, you wouldn't want to destroy it. Plus the carriage is cooler and faster than a sledge. Trust me, I know what I'm doing. And you will, soon, too."
"stein"	"The hammer produces no music and fails to turn into a mug, which wouldn't be helpful anyway."
"strength"	"You've already gained strength. And hitting such a thick lock harder wouldn't do much."
"time"	"[stanley-burrell]."
"toe"	"The mentality crowd might enjoy that sort of comic relief, but you wouldn't."
"under"	"You don't know enough about vehicles, but even if you did, the hammer wouldn't have enough force to open the Return Carriage from below."
"x"	"[x-hammer]."
"yellow"	"You don't need to be around birds, and it'd be hypocritical to cut people down for their fears."

to say x-hammer:
	say "It's a nondescript hammer--well, okay, it's blunt, not claw. Almost like a rubber mallet. You feel a power, though, as you carry it--as if you were able to change it correctly, if you knew a good way to describe it"

to say stanley-burrell:
	say "A voice says 'STOP!' Your pants momentarily feel baggy. Maybe it doesn't quite need to be that sort of hammer"

volume swear deciding

To decide what number is swear-decide:
	(- OKSwear(); -)

Include (-

[ OKSwear i j u u2 times bigSwear smallSwear returnYes returnNo copout;
	if ((+ debug-state +) == 1) rtrue;
	for (::) {
		#Ifdef TARGET_ZCODE;
		if (location == nothing || parent(player) == nothing) read buffer parse;
		else read buffer parse DrawStatusLine;
		j = parse->1;
		#Ifnot; ! TARGET_GLULX;
		KeyboardPrimitive(buffer, parse);
		j = parse-->0;
		#Endif; ! TARGET_
		if (j)
		{ ! at least one word entered
			returnYes = 0;
			returnNo = 0;
			bigSwear = 0;
			smallSwear = 0;
			for (u = 1: u <= j: u=u+1)
			{
			#ifdef TARGET_ZCODE;
			u2 = 2 * u - 1;
			#Ifnot; ! TARGET_GLULX;
			u2 = 3 * u - 2;
			#ENDif; ! TARGET_
			i = parse-->u2;
			if (i == 'fuck//' or 'shit//' or 'damn//') { bigSwear = true; }
			if (i == 'bother//' or 'curses//' or 'drat//' or 'darn//') { smallSwear = true; }
			if (i == 'yes//' or 'y//') { returnYes = true; }
			if (i == 'no//' or 'n//') { returnNo = true; }
			}
			if (returnYes)
			{
				if (bigSwear) { print "~Dude! CHILL! We GET IT!~ a voice says.^"; return 3; }
				if (smallSwear) { print "You hear snickering at your half-body-parted swear attempts. ~Let's give 'im the rough stuff!~^"; return 3; }
				return 1;
			}
			if (returnNo)
			{
				if (bigSwear) { print "~Don't play mind games with us!~ a voice booms. ~Just for that, you're in for it.~^"; return 3; }
				if (smallSwear) { print "~You sure can't! What a lame try,~ a voice booms.^"; }
				return 4;
			}
			if (bigSwear || smallSwear)
			{
			  if (bigSwear) { print "~A simple yes or no would've done, but we get the point,~ you hear."; }
			  else { print "~Oh, you'll have to deal with worse than that!~ you hear.^"; }
			  return 3;
			}
		}
		times++;
		if (times == 4) { return 2; }
		print "I won't judge. And it won't affect the game. Yes or No (Y or N for short also works). ";
		if ((+ started-yet +) == 1) { print "^"; }
		print ">";
	}
];

-)

volume testing I can't quite NFR

book ticking-debug

[* this is a stub if we want to see where something fails, instead of d 1, d 2 etc. we just tick-up ]

my-tick is a number that varies.

to tick-up:
	if debug-state is true:
		increment my-tick;
		say "DEBUG-TEXT: [my-tick].";

every turn:
	now my-tick is 0;

volume programmer tests - not for release

to rulesOn: [used to turn rules on at the very start of play]
	(- RulesOnSub(); -)

to rulesAll: [used to turn rules ALL on at the very start of play]
	(- RulesAllSub(); -)

chapter sring

sring is an action out of world.

understand the command "sr" as something new.

understand "sr" as sring.

carry out sring:
	now screen-read is whether or not screen-read is false;
	say "Screen reading is [if screen-read is true]on[else]off[end if].";
	the rule succeeds;

chapter dsing

dsing is an action out of world.

understand the command "ds" as something new.

understand "ds" as dsing.

carry out dsing:
	now debug-state is whether or not debug-state is false;
	say "Debug state is [if debug-state is true]on[else]off[end if].";
	the rule succeeds;

book anno-check

to anno-check:
	repeat with Q running through rooms:
		if map region of Q is meta-rooms:
			next;
		if Q is not an anno-loc listed in table of annotations:
			say "[Q] [map region of Q] needs annotations.";
		else:
			choose row with anno-loc of Q in table of annotations;
			if there is no anno-long entry:
				say "[Q] [map region of Q] needs long anno entry.";

book odd verbs

chapter curcing

curcing is an action applying to nothing.

understand the command "curc" as something new.

understand "curc" as curcing.

carry out curcing:
	say "[qbc_litany].";
	repeat through qbc_litany:
		if enabled entry > 0:
			say "[prompt entry] available.";
		else:
			say "[prompt entry] not available.";
	the rule succeeds;

chapter ruving

ruving is an action out of world.

understand the command "ruv" as something new.

understand "ruv" as ruving.

carry out ruving:
	say "Unvisited:";
	let got-one be false;
	repeat with QQ running through rooms in mrlp:
		if QQ is unvisited:
			say "[if got-one is true],[end if] [QQ]";
			now got-one is true;
	say "[if got-one is false] no rooms[end if].";
	the rule succeeds;

chapter puving

puving is an action out of world.

understand the command "puv" as something new.

understand "puv" as puving.

carry out puving:
	say "People in region:";
	let got-one be false;
	repeat with QQ running through people in mrlp:
		say "[if got-one is true],[end if] [QQ] ([location of QQ])";
		now got-one is true;
	say "[if got-one is false]nobody[end if].";
	the rule succeeds;

chapter stobing

stobing is an action out of world.

understand the command "stob" as something new.

understand "stob" as stobing.

carry out stobing:
	now stop-on-bug is whether or not stop-on-bug is false;
	the rule succeeds;

book programmer testing

chapter who's unnecessarily untalkative?

to decide whether (Q - a person) is talkative:
	if Q is Alec Smart, decide no;
	if Q is Business Monkey, decide no;
	if Q is Volatile Sal, decide no;
	if Q is Cute Percy, decide no;
	if Q is Lee Bull, decide no;
	if Q is Francis Pope, decide no;
	if Q is Flames Fan, decide no;
	if Q is Turk Young, decide no;
	if Q is Labor Child, decide no;
	if Q is cards of the house, decide no;
	if Q is Uncle Dutch, decide no;
	if Q is Faith Goode, decide no;
	if Q is Sid Lew, decide no;
	if Q is a client, decide no;
	decide yes;

when play begins (this is the test for talkers rule):
	let count be 0;
	let c2 be 0;
	repeat with Q running through people:
		if litany of Q is table of no conversation:
			if Q is talkative:
				if location of Q is not nothing and map region of location of Q is rejected rooms:
					say "PERSON X [Q] no litany in non-critical area[line break]";
				else:
					increment count;
					say "PERSON [count] [Q] has no litany.";

chapter test macros

section 1 smart street

test 1 with "talk to guy/1/1/1/1/1/1/1/1/play nim/in"

test 1b with "bb/play nim/in"

section 2 lounge quests

test 2 with "get all/put screw in stick/climb chair/hit hatch"

section 3 surface quests

test 3 with "w/give token/dig dirt/e/e/dig earth/read burden/w/w/talk to weasel/1/2/2/2/2/2/2/2/2/give burden/e/give burden/n"

test 3b with "w/give token/dig dirt/e/e/dig earth/read burden/w/w/bb/give burden/e/give burden/n"

section 4 pier quests

test 4-convo-trap with "test street/test lounge/test arch/bb/e/e/get bear/w/talk to fritz/e/s/i/1/1/1/1/1/1/give bear to fritz/e/s/talk to erin/n"

test 4 with "e/sleep/z/z/z/e/get bear/s/talk to ally/1/1/2/2/2/3/3/n/talk to ally/2/2/talk to erin/1/1/1/1/1/1/1/1/give wine to erin/n/w/give bear to fritz/w/give paper to boy/n"

test 4b with "e/sleep/z/z/z/e/get bear/s/bb/y/bb/give drink to erin/n/w/give bear to fritz/w/give paper to boy/drop ticket/n"

test 4-dream with "gonear bench/sleep/wake/sleep/z/wake/sleep/z/wake/sleep/z/wake"

test 4-to-bar with "test street/test lounge/test arch/talk to howdy/1/3/3/3/3/e/get bear/give bear to fritz/e/s"

test 4f-alltick with "gonear pier/e/sleep/z/z/z/tick/drop ticket/tick/e/e/e/e/e/tick/s/talk to erin/2/talk to erin/2/bb/y/abstract erin to soda club/bb/give drink to erin/bb/y/n"

test 4f-allbad with "attack shell/attack guy/gonear pier/e/e/s/attack erin/tix 3/bb/y/talk to erin/2/talk to erin/2/n/n/shit/shit/purloin weed/give weed to toad/w/w/sleep/z/z/z/w/eat lolly/purloin weed/e"

section 5 main quests

test 5 with "test 5-blood/test 5-soul/test 5-big"

test 5-big with "n/e/get string/w/s/w/w/put string in hole/n/n/get sound safe/s/s/e/e/n/e/e/open safe/talk to story fish/get poetic wax/w/n/put wax in machine/wear trick hat/s/w/s/e/e/give hat to sly/w/w/w/w/in/give trap rattle to lee/out/e/e/n/n/give trade to brother big/s/s/bro 3"

test 5-blood with "n/n/w/talk to buddy/1/1/1/s/s/w/w/n/x hedge/y/s/e/e/e/give tag/e/give seed to monkey/give contract to monkey/w/w/w/w/w/give blossom to faith/e/e/e/n/n/give mind to brother blood/s/s/bro 1"

test 5-soul with "n/e/in/talk to penn/1/2/2/y/2/out/w/s/s/e/give weed to fritz/w/n/n/e/in/give penny to penn/out/w/w/put pot in vent/x vent/open vent/e/n/give light to brother soul/s/s/bro 2"

test 5b with "test 5b-blood/test 5b-soul/test 5-big"

test 5b-blood with "n/n/w/bb/s/s/w/w/n/x hedge/y/s/e/e/e/give tag/e/give seed to monkey/give contract to monkey/w/w/w/w/w/give blossom to faith/e/e/e/n/n/give mind to brother blood/s/s/bro 1"

test 5b-soul with "n/e/in/bb/out/w/s/s/e/give weed to fritz/w/n/n/e/in/give penny to penn/out/w/w/put pot in vent/x vent/open vent/e/n/give light to brother soul/s/s/bro 2"

test 5-jk with "j/j/j/j/brobye/purloin finger/x finger/talk to jerks/talk to boris"

section 6 final stuff

test 6-final with "n/freak out/1/1/1/1/1/1/1/1/1"

test 6-lastroom with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/n/explain me"

section best ending stuff

test bestprep with "gonear Nominal Fen/w/ctc/d/a bad face/d/get crocked half/u/u/e/e/e/ne/s/nw/e/sw/n/se/w/w/w/n/n"

test bestprep2 with "gonear Nominal Fen/w/ctc/d/a bad face/d/get crocked half/u/u/e/e/e/e/nw/s/ne/w/se/n/sw/w/w/n/n"

section bugs

test bugs-arts-x-before-after with "gonear compound/x crack/x torch/purloin fish/play it/purloin safe/open it/x crack/x torch"
			[say "[jerky-guy entry], [c2].";]

section cheats

test cheat-pop with "purloin quiz pop/gonear questions field/drink quiz pop"

section features

test feat-anno with "anno/y/jump/w/w/w/e/n/e/e/w/w/w/e/n/e/w/w/n/e/w/w/n/x view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view"

test feat-allwin with "gonear out mist/est/change ring/tone ring/hollow ring/gonear airy/away hammer/home hammer/lock hammer"

test feat-deaths with "attack game shell/gonear strip/shit/shit/gonear meal square/eat lolly/gonear labor child/attack child/tix 4/purloin brew/gonear soda club/n/gonear stool toad/attack toad/gonear stool toad/purloin weed/give weed to toad"

section jerk tests

test j-1 with "purloin mint/gonear accountable hold/get safe/x index/gonear Nominal Fen/talk to jerks/talk to boris/10"

test jerk-wrong with "1111111/1234576/1023456/1823456"

test jerk-q with "gonear jerks/talk to jerks/g/gonear safe/get safe/x index/s/s/e/e/talk to jerks/purloin mint/give mint to wash white/test jq"

test jq with "test j-1/jfix/talk to dandy jim/10/1234567"

test jmint with "test j-1/jfix/talk to dandy jim/10/give mint to boris/talk to dandy jim/2"

section errors

test j-err-mintgive with "give mint to jim/talk to jim/jrm"

section quick stuff

test j-q-jim with "talk to jim/10/1234567/jr q-jim"

test j-q-boris with "talk to boris/10/2345671/jr q-boris"

test j-q-wash with "talk to wash/10/3456712/jr q-wash"

test j-q-warner with "talk to warner/10/4567123/jr q-warner"

test j-q-warm with "talk to warm/10/5671234/jr q-warm"

test j-q-paul with "talk to paul/10/6712345/jr q-paul"

test j-q-cain with "talk to cain/10/7123456/jr q-cain"

section jerk quick with mint

test j-qm-boris with "skip on/give mint to boris/talk to jim/10/1234567/jrm j-qm-boris"

test j-qm-wash with "skip on/give mint to wash/talk to jim/10/1234567/jrm j-qm-wash"

test j-qm-warner with "skip on/give mint to warner/talk to jim/10/1234567/jrm j-qm-warner"

test j-qm-warm with "skip on/give mint to warm/talk to jim/10/1234567/jrm j-qm-warm"

test j-qm-paul with "skip on/give mint to paul/talk to jim/10/1234567/jrm j-qm-paul"

test j-qm-cain with "skip on/give mint to cain/talk to jim/10/1234567/jrm j-qm-cain"

section jerk mint

test j-m-boris with "skip on/give mint to boris/talk to jim/1/3/4/5/6/7/jrm j-m-boris"

test j-m-wash with "skip on/give mint to wash/talk to jim/1/2/4/5/6/7/jrm j-m-wash"

test j-m-warner with "skip on/give mint to warner/talk to jim/1/2/3/5/6/7/jrm j-m-warner"

test j-m-warm with "skip on/give mint to warm/talk to jim/1/2/3/4/6/7/jrm j-m-warm"

test j-m-paul with "skip on/give mint to paul/talk to jim/1/2/3/4/5/7/jrm j-m-paul"

test j-m-cain with "skip on/give mint to cain/talk to jim/1/2/3/4/5/6/jrm j-m-cain"

section jerk plain

test j-jim with "skip on/talk to jim/1/2/3/4/5/6/7/jrm j-jim"

test j-boris with "skip on/talk to boris/2/3/4/5/6/7/1/jrm j-boris"

test j-wash with "skip on/talk to wash/3/4/5/6/7/1/2/jrm j-wash"

test j-warner with "skip on/talk to warner/4/5/6/7/1/2/3/jrm j-warner"

test j-warm with "skip on/talk to warm/5/6/7/1/2/3/4/jrm j-warm"

test j-paul with "skip on/talk to paul/6/7/1/2/3/4/5/jrm j-paul"

test j-cain with "skip on/talk to cain/7/1/2/3/4/5/6/jrm j-cain"

section jerk long mint

test j-l-m-boris with "skip off/give mint to boris/talk to jim/1/8/3/8/4/8/5/8/6/8/7/8/jrm j-l-m-boris"

test j-l-m-wash with "skip off/give mint to wash/talk to jim/1/8/2/8/4/8/5/8/6/8/7/8/jrm j-l-m-wash"

test j-l-m-warner with "skip off/give mint to warner/talk to jim/1/8/2/8/3/8/5/8/6/8/7/8/jrm j-l-m-warner"

test j-l-m-warm with "skip off/give mint to warm/talk to jim/1/8/2/8/3/8/4/8/6/8/7/8/jrm j-l-m-warm"

test j-l-m-paul with "skip off/give mint to paul/talk to jim/1/8/2/8/3/8/4/8/5/8/7/8/jrm j-l-m-paul"

test j-l-m-cain with "skip off/give mint to cain/talk to jim/1/8/2/8/3/8/4/8/5/8/6/8/jrm j-l-m-cain"

section jerk long

test j-l-jim with "skip off/talk to jim/1/8/2/8/3/8/4/8/5/8/6/8/7/jrm j-l-jim"

test j-l-boris with "skip off/talk to boris/2/8/3/8/4/8/5/8/6/8/7/8/1/jrm j-l-boris"

test j-l-wash with "skip off/talk to wash/3/8/4/8/5/8/6/8/7/8/1/8/2/jrm j-l-wash"

test j-l-warner with "skip off/talk to warner/4/8/5/8/6/8/7/8/1/8/2/8/3/jrm j-l-warner"

test j-l-warm with "skip off/talk to warm/5/8/6/8/7/8/1/8/2/8/3/8/4/jrm j-l-warm"

test j-l-paul with "skip off/talk to paul/6/8/7/8/1/8/2/8/3/8/4/8/5/jrm j-l-paul"

test j-l-cain with "skip off/talk to cain/7/8/1/8/2/8/3/8/4/8/5/8/6/jrm j-l-cain"

section jall

test j-q-all with "jfix/test j-q-jim/test j-q-boris/test j-q-wash/test j-q-warner/test j-q-warm/test j-q-paul/test j-q-cain"

test j-qm-all with "jfix/test j-qm-boris/test j-qm-wash/test j-qm-warner/test j-qm-warm/test j-qm-paul/test j-qm-cain"

test j-m-all with "jfix/test j-m-boris/test j-m-wash/test j-m-warner/test j-m-warm/test j-m-paul/test j-m-cain"

test j-all with "jfix/test j-jim/test j-boris/test j-wash/test j-warner/test j-warm/test j-paul/test j-cain"

test j-l-m-all with "jfix/test j-l-m-jim/test j-l-m-boris/test j-l-m-wash/test j-l-m-warner/test j-l-m-warm/test j-l-m-paul/test j-l-m-cain"

test j-l-all with "jfix/test j-l-jim/test j-l-boris/test j-l-wash/test j-l-warner/test j-l-warm/test j-l-paul/test j-l-cain"

test j-exhaust with "test j-1/test j-q-all/test j-qm-all/test j-m-all/test j-all/test j-l-m-all/test j-l-all"

section losses

test lose-cc with "knock hard/get cookie/e/n/score/n/n/n"

test lose-oc with "knock hard/get off cheese/e/n/score/n/n/n"

test lose-gc with "knock hard/w/get greater cheese/e/n/score/n/n/n"

test lose-br with "knock hard/w/get brownie/e/n/score/n/n/n"

section warp

test warp-jerks with "test 1/test 2/test 3/test 4"

section wins

test win with "test 1/test 2/test 3/test 4/test 5/test cheat-pop/test 6-final/change ring"

test winb with "test 1b/test 2/test 3b/test 4b/test 5b/test cheat-pop/test 6-final/change ring"

test winbest with "test 1/test 2/test 3/test 4/test 5/purloin quiz pop/n/n/test bestprep/drink quiz pop/test 6-final/away hammer"

test winbest2 with "test 1/test 2/test 3/test 4/test 5/purloin quiz pop/n/n/test bestprep2/drink quiz pop/test 6-final/away hammer"

test wjds with "duck sitting/y/test 3/test 4/test 5/test cheat-pop/test 6-final/change ring"

test wjfc with "figure a cut/test 5/test cheat-pop/test 6-final/change ring"

test wjkh with "knock hard/y/test 4/test 5/test cheat-pop/test 6-final/change ring"

test wjna with "notice advance/test cheat-pop/test 6-final/change ring"

section xps

test term with "gonear belt/xp terminal/a bad face/xp terminal"

chapter broing

[* this tests if a brother is gone]

broing is an action applying to one number.

understand the command "bro" as something new.

understand "bro [number]" as broing.

carry out broing:
	if number understood is 1:
		if brother blood is in lalaland:
			say "SUCCESS!";
		else:
			say "FAILURE!";
	if number understood is 2:
		if brother soul is in lalaland:
			say "SUCCESS!";
		else:
			say "FAILURE!";
	if number understood is 3:
		if brother big is in lalaland:
			say "SUCCESS!";
		else:
			say "FAILURE!";
	the rule succeeds;

chapter anchecking

anchecking is an action out of world.

understand the command "ancheck" as something new.

understand "ancheck" as anchecking.

carry out anchecking:
	repeat with Q running through rooms:
		unless Q is a anno-loc listed in table of annotations:
			say "Room: [Q] needs annotation.";
	the rule succeeds;

volume beta testing - not for release

the force tester wherever rule is listed last in the when play begins rulebook.

beta-zap-room is a room that varies. beta-zap-room is lalaland.

after printing the locale description when mrlp is endings and location of player is unvisited:
	if player is in airy station:
		say "[line break]";
	say "NOTE TO BETA TESTERS: the EST command lets you toggle whether or not a winning command ends the game, so you don't have to keep UNDOing if you want to try to guess all three wins, here, or just beat the game up. Whatever you can try is a big help.";

after printing the locale description when player is in beta-zap-room and beta-zap-room is unvisited (this is the stop the game before I'm embarrassed by implementation rule) :
	if debug-state is false:
		say "You've gotten as far as is useful to me know. Thank you so much! Please send the transcript to [email].";
		end the story;
	else:
		say "NOTE: flagging that play would end here in a beta version."

when play begins (this is the force tester wherever rule):
	now in-beta is true;
	if currently transcripting:
		say "It looks like you restarted, and the transcript should still be running.";
	else if debug-state is false:
		say "Note: I like to make sure beta testers have a transcript working. It's a big help to me. So, after you press a key, you'll be asked to save a file.";
		wfak;
		try switching the story transcript on;
		say "Transcripts can be sent to blurglecruncheon@gmail.com. Any punctuation before the comment is okay, e.g. *TYPO or ;typo or :typo.";
	continue the action;

chapter jcing

[ * this tells the cheat code for beating the jerks]

jcing is an action out of world.

understand the command "jc" as something new.

understand "jc" as jcing when jerk-who-short is true and silly boris is not in lalaland.

carry out jcing:
	say "Starting with [last-jerk], the [j-co]['] magic number is [magic-jerk-number].";
	the rule succeeds;

chapter tixing

[ * this sets the number of tickets you have ]

tixing is an action applying to a number.

understand the command "tix" as something new.
understand the command "tick" as something new.

understand "tix [number]" as tixing.
understand "tick [number]" as tixing.

understand "tix" as tixreseting.
understand "tick" as tixreseting.

tixreseting is an action out of world.

last-tix is a number that varies.

carry out tixreseting:
	try tixing last-tix;

carry out tixing:
	if Terry Sally is in lalaland:
		say "You may need to restart and KNOCK HARD to retry getting tickets, with Terry Sally gone.";
	if number understood > 4 or number understood < 0:
		say "The number of tickets you have can only be 0-4." instead;
	now your-tix is the number understood;
	now last-tix is your-tix;
	if your-tix is 0:
		now tickety is off-stage;
		now trail paper is off-stage;
	else if your-tix is 4:
		now tickety is in lalaland;
		now player has trail paper;
	else:
		now player has boo tickety;
		now trail paper is off-stage;
	say "You now have [your-tix] tickets.";
	the rule succeeds;

chapter swearing

[ * toggle swearing]

swearing is an action out of world.

understand the command "swear" as something new.

understand "swear" as swearing.

carry out swearing:
	now allow-swears is whether or not allow-swears is false;
	say "Swearing is [on-off of allow-swears].";
	the rule succeeds;

chapter gqing

[* gq = go quick, tells you what a number should skip to, so we don't have to go through a conversation etc.]

gqing is an action applying to one number.

understand the command "gq" as something new.

understand "gq [number]" as gqing.

understand "gq" as a mistake ("[gq-err]")

to say gq-err:
	say "gq (number) forces a variable that would be tedious to increase to what it needs to be. The game detects what to changed based on where you are or what you have.[paragraph break]# of game wins in smart street.[line break]# of idol failures[line break][line break]# of times used the Legend of Stuff for new hints[line break]# of Insanity Terminal failures[line break]-1 twiddles whether you re-saw a hint in the Legend of Stuff.[paragraph break]Some too big answers may give a 'bug' response, which isn't really a bug.[paragraph break]Adding 100 to the number = that many idol failures, adding 200 = that many terminal failures, adding 300 = smart street game-wins, adding 400 = turns before talking to BM, adding 500 = legend of stuff reads.[paragraph break]Sorry for the magic numbers, but coding alternatives were worse."

to say gqhelp:
	say "If this wasn't what you wanted, type GQ for general help.[line break]";

carry out gqing:
	if the number understood is -1:
		if player does not have legend of stuff:
			say "You need the Legend of Stuff to twiddle whether you looked in it." instead;
			now reused-hint is whether or not reused-hint is false;
			say "You have now [if reused-hint is false]not [end if]reused a hint in the Legend of Stuff." instead;
	let Z be the number understood / 100;
	let Y be the remainder after dividing the number understood by 100;
	if Z > 5 or Z < 0:
		say "You can only use numbers from -1 to 599 for this test hack.";
		say "[gq-err] instead.";
	if player has Legend of Stuff and Z is 5: [this trumps everything]
		now hints-used is Y;
		say "Legend of stuff peeks is now [hints-used]. Bad-guy taunts for using Legend of Stuff: ";
		repeat through table of bm stuff brags:
			if there is a times-failed entry:
				say "([times-failed entry - 1], [times-failed entry], [times-failed entry + 1])[line break]";
		say "[gqhelp]" instead;
	if Z is 5 and player does not have legend of stuff:
		say "You may wish to PURLOIN LEGEND to test this." instead;
	if player is in service community or player is in idiot village or Z is 1:
		now idol-fails is Y;
		say "Idol-fails is now [idol-fails]. Bad-guy taunt for idol failure critical values are:";
		repeat through table of bm idol brags:
			if there is a times-failed entry:
				say "([times-failed entry - 1], [times-failed entry], [times-failed entry + 1])[line break]";
		say "[gqhelp]" instead;
	if player is in belt below or Z is 2:
		now terminal-errors is Y;
		say "Terminal-errors is now [terminal-errors]. Bad-guy taunt for terminal failure critical values are:";
		repeat through table of terminal frustration:
			if there is a term-miss entry:
				say "([term-miss entry - 1], [term-miss entry], [term-miss entry + 1])[line break]";
		say "[gqhelp]" instead;
	if player is in smart street or Z is 3:
		let totwin be 0;
		repeat with lg running through logic-games:
			now totwin is totwin + max-won of lg;
		now your-game-wins is Y;
		say "Your-game-wins is now [your-game-wins]. The maximum possible is [totwin]. Win chat critical values are: ";
		repeat through table of win chat:
			if there is a win-check entry:
				say "([win-check entry - 1], [win-check entry], [win-check entry + 1])[line break]";
		say "[line break]";
		say "Guy taunt-as-you-leave values are:";
		repeat through table of guy taunts:
			if there is a total-wins entry:
				say "([total-wins entry - 1], [total-wins entry], [total-wins entry + 1])[line break]";
		say "[gqhelp]" instead;
	if player is in freak control or Z is 4:
		now freak-control-turns is Y;
		say "Freak control turns is [freak-control-turns]. Bad-guy taunts for time taken: ";
		repeat through table of distract time:
			if there is a control-turns entry:
				say "([control-turns entry - 1], [control-turns entry], [control-turns entry + 1])[line break]";
		say "[gqhelp]" instead;
	the rule succeeds;

chapter gating

[* this is "give all to" which gives everything to a certain NPC ]

gating is an action applying to one thing.

understand the command "gat" as something new.

understand "gat [something]" as gating.

gat-ruin is a truth state that varies.

the macguffin is a thing. description is "bug".

table of explanations (continued)
exp-thing	exp-text	exp-anno
macguffin	"BUG--testing item."	--

to gat-ruin-check:
	if gat-ruin is false:
		say "NOTE: 	.";
		now gat-ruin is true;

carry out gating:
	if tension surface is unvisited:
		now player has token;
		do nothing;
	else if pressure pier is unvisited:
		gat-ruin-check;
		now player has pick;
		now player has burden;
	else if Terry Sally is not in lalaland and mrlp is not main chunk:
		gat-ruin-check;
		now player has minimum bear;
		now player has trail paper;
		now player has boo tickety;
		now player has condition mint;
	else:
		gat-ruin-check;
		now trail paper is in lalaland;
		now boo tickety is in lalaland;
		now player has poory pot;
		now player has dreadful penny;
		now player has wacker weed;
		now player has minimum bear;
		now player has long string;
		now player has reasoning circular;
		now player has poetic wax;
		now player has trick hat;
		now player has trap rattle;
		now player has cold contract;
		now player has trade of tricks;
		now player has relief light;
		now player has condition mint;
		now player has money seed;
		now player has fourth-blossom;
		now player has mind of peace;
		now player has legend of stuff;
		now player has crocked half;
		now player has story fish;
		now player has sound safe;
	if player is in soda club:
		if player does not have haha brew:
			now player has cooler wine;
	else:
		now cooler wine is in lalaland;
		now haha brew is in lalaland;
	now player has macguffin;
	let int be indexed text;
	let last-item be an object;
	if noun is brother big:
		now last-item is trade of tricks;
	else if noun is brother blood:
		now last-item is mind of peace;
	else if noun is brother soul:
		now last-item is relief light;
	else if noun is business monkey:
		now last-item is money seed;
	else if noun is fritz:
		now last-item is minimum bear;
	else if noun is grace or noun is faith:
		now last-item is fourth-blossom;
	else if noun is labor child:
		now last-item is cold contract;
	else if noun is language machine:
		now last-item is poetic wax;
	else if noun is lee bull:
		now last-item is trap rattle;
	else if noun is officer petty:
		now last-item is reasoning circular;
	else if noun is sly moore:
		now last-item is trick hat;
	else if noun is terry sally:
		now last-item is trail paper;
	say "Last item is [last-item].[line break]";
	repeat with gatitm running through carried things:
		if gatitm is last-item:
			next;
		now int is "COMMAND: GIVE [gatitm] TO [noun]: ";
		say "[int in upper case][no line break]";
		try giving gatitm to the noun;
	if last-item is not nothing:
		say "GIVE IMPORTANT ITEM: [no line break]";
		try giving last-item to noun;
	say "Now we try taking [the noun]: [no line break]";
	if noun is in lalaland:
		say "Oops, moving [the noun] back to where you are.";
		move noun to location of player;
	try taking the noun; [heck why not?]
	now haha brew is in lalaland;
	now cooler wine is in lalaland;
	the rule succeeds.

chapter testjumping

[* testjump lets the tester make specific jumps. nu-testjump is the action, but list-testjumping = if we type 0, for a list]

understand the command "testjump" as something new.
understand the command "tj" as something new.
understand the command "jt" as something new.

understand "testjump [number]" as nu-testjumping.
understand "tj [number]" as nu-testjumping.
understand "jt [number]" as nu-testjumping.

nu-testjumping is an action applying to one number.

list-testjumping is an action out of world.

understand "testjump 0" and "testjump" and "tj 0" and "jt 0" and "tj" and "jt" as list-testjumping.

carry out list-testjumping:
	try nu-testjumping 0;

carry out nu-testjumping:
	let all-jumps be number of rows in table of tj-moves;
	if player is not in Smart Street:
		say "You should be in Smart Street before you jump. Otherwise things get too messy. You may wish to restart and try again.";
		the rule succeeds;
	if number understood is 0:
		say "[tj-list]" instead;
	if number understood < 1 or number understood > all-jumps:
		say "You need to choose a number between 1 and [all-jumps], or 0 to see a list." instead;
	choose row number understood in table of tj-moves;
	consider the tj-rule entry;
	if corruption entry is true:
		say "Note that any bugs you may find after making this jump may be a testing artifact and not a problem with the game. That's probably because this is a command to test something specific. I'll verify if the bug would happen in an actual game, if it pops up.";
	the rule succeeds;

block-other is a truth state that varies;
block-pier is a truth state that varies;

check going south in Nominal Fen when block-pier is true:
	say "You don't need to go back here for focused testing." instead;

check going when block-pier is true:
	if noun is west or noun is east:
		say "This is testing, so I won't allow you to move to the side." instead;

to say tj-list:
	let count be 0;
	repeat through table of tj-moves:
		increment count;
		say "[count]. [tj-descr entry][line break]";

table of tj-moves
tj-descr	tj-rule	corruption
"Round Lounge"	go-lounge rule	false
"Tension Surface"	go-surface rule	false
"Pressure Pier"	go-pier rule	false
"Nominal Fen"	go-jerks rule	false
"Brothers gone, visit [j-cap]"	go-field-bro rule	false
"Brothers and [j-cap] gone"	notice-advance rule	false
"[j-cap] gone, go near Brothers"	jerks-not-bros rule	true
"Jump to Freak Control"	freak-control rule	false
"Jump to Good End"	to-good-end rule	false
"Jump to Great End"	to-very-good-end rule	false
"Face Cute Percy"	face-ac rule	false
"Face the Insanity Terminal"	face-term rule	true
"Face the Idol"	face-idol rule	true
"Auto-solve the Idol"	defeat-idol rule	true
"Auto-solve the Idol/Brothers/[j-cap]"	defeat-everyone rule	true

this is the go-lounge rule:
	move player to round lounge;
	now player has gesture token;
	the rule succeeds;

this is the go-surface rule:
	duck-sitting;
	the rule succeeds;

this is the go-pier rule:
	knock-hard;
	the rule succeeds;

this is the go-jerks rule:
	figure-cut;
	the rule succeeds;

this is the go-field-bro rule:
	move-puzzlies-and-jerks;
	move player to Nominal Fen;
	send-bros;
	if in-beta is true:
		now block-pier is true;
	the rule succeeds;

this is the notice-advance rule:
	notice-advance;
	if in-beta is true:
		now block-pier is true;
		now block-other is true;
	the rule succeeds;

this is the jerks-not-bros rule:
	now all clients are in lalaland;
	now player has quiz pop;
	the rule succeeds;

this is the freak-control rule:
	now player is in freak control;
	the rule succeeds;

this is the to-good-end rule:
	now player is in out mist;
	send-bros;
	the rule succeeds;

this is the to-very-good-end rule:
	now player is in airy station;
	send-bros;
	the rule succeeds;

this is the face-ac rule:
	move player to chipper wood;
	the rule succeeds;

this is the face-term rule:
	move-puzzlies-and-jerks;
	move player to A Great Den;
	the rule succeeds;

this is the face-idol rule:
	move-puzzlies-and-jerks;
	move player to idiot village;
	now Cute Percy is in lalaland;
	open-bottom;
	now player has crocked half;
	now player has bad face;
	now face of loss is in lalaland;
	the rule succeeds;

this is the defeat-idol rule:
	move-puzzlies-and-jerks;
	move player to questions field;
	now Cute Percy is in lalaland;
	open-bottom;
	now player has crocked half;
	now player has bad face;
	now face of loss is in lalaland;
	now thoughts idol is in lalaland;
	now service memorial is in service community;
	the rule succeeds;

this is the defeat-everyone rule:
	send-bros;
	follow the defeat-idol rule;
	the rule succeeds;

chapter montying

[* this turns testing stuff on and off. The table has information on all the tests.]

montying is an action applying to one topic.

widdershins is a direction. turnwise is a direction. the opposite of widdershins is turnwise. the opposite of turnwise is widdershins.

understand the command "monty" as something new.

understand "monty" as a mistake ("[monty-sum]")

to say monty-sum:
	say "MONTY usage for running a test-command every move:[paragraph break]";
	repeat through table of monties:
		say "[2da][test-title entry] can be turned on/off with [topic-as-text entry][line break]";
	say "[line break]MONTY FULL/ALL and MONTY NONE tracks all these every-move tries, or none of them.[no line break]";

understand "monty [text]" as montying.

monty-full is a truth state that varies.

carry out montying:
	let found-toggle be false;
	if the topic understood matches "all" or the topic understood matches "full":
		repeat through table of monties:
			now on-off entry is true;
		the rule succeeds;
	if the topic understood matches "none":
		repeat through table of monties:
			now on-off entry is false;
		the rule succeeds;
	repeat through table of monties:
		if the topic understood matches montopic entry:
			now on-off entry is whether or not on-off entry is false;
			say "[test-title entry] is now [if on-off entry is true]on[else]off[end if].";
			now found-toggle is true;
	if found-toggle is false:
		say "That wasn't a recognized flag for MONTY.[paragraph break][monty-sum][line break]";
	the rule succeeds;

table of monties
montopic (topic)	on-off	test-title (text)	test-action	topic-as-text (text)
"exits"	false	"LISTING EXITS"	try-exits rule	"exits"
"legend/hint"	false	"LEGEND HINTING"	try-hinting rule	"legend/hint"
"red"	false	"LEGEND HINTING RED"	try-red rule	"red"
"blue"	false	"LEGEND HINTING BLUE"	try-blue rule	"blue"
"big"	false	"LEGEND HINTING BIG"	try-big rule	"big"
"i/inventory"	false	"INVENTORY"	try-inventory rule	"i/inventory"
"s/smell"	false	"SMELLING"	try-smelling rule	"s/smell"
"l/listen"	false	"LISTENING"	try-listening rule	"l/listen"
"sc/score"	false	"SCORING"	try-scoring rule	"sc/score"
"dir/noway"	false	"GOING NOWHERE"	try-wid rule	"dir/noway"
"dirs"	false	"GOING BASIC DIRS"	try-dirs rule	"dirs"
"donote/note"	false	"DONOTEING"	try-noting rule	"donote/note"
"mood"	false	"MOOD TRACKING"	try-mood rule	"mood"
"think"	false	"THINK TRACKING"	try-think rule	"think"
"sleep"	false	"SLEEP TRACKING"	try-sleep rule	"sleep"
"status"	false	"STATUS LINE (SL)"	try-statline rule	"sl"

this is the try-statline rule:
	say "Left-hand status line: [lhs][line break]";
	say "Right-hand status line: [lhs][line break]";

this is the try-exits rule:
	try exitsing;

this is the try-hinting rule:
	hint-red;
	hint-blue;
	hint-big;

this is the try-red rule:
	hint-red;

this is the try-blue rule:
	hint-blue;

this is the try-big rule:
	hint-big;

this is the try-inventory rule:
	try taking inventory;

this is the try-smelling rule:
	try smelling;

this is the try-listening rule:
	try listening;

this is the try-scoring rule:
	try requesting the score;

this is the try-wid rule:
	try going widdershins;

tracked-room is a room that varies.

this is the try-dirs rule:
	now tracked-room is location of player;
	say "[tracked-room] = base room.";
	shift-player inside;
	shift-player outside;
	shift-player east;
	shift-player west;
	shift-player south;
	shift-player north;

to shift-player (Q - a direction):
	say "Going [Q] from [location of the player]:";
	try going q;
	move player to tracked-room, without printing a room description;

this is the try-noting rule:
	try donoteing;

this is the try-mood rule:
	say "Your mood (upper right status) is [your-mood].";

this is the try-think rule:
	try thinking;

this is the try-sleep rule:
	if player is not in down ground: [cheating a bit. Sleeping throws it off]
		try sleeping;

every turn (this is the full monty test rule) :
	now red-big-clued-this-turn is false;
	now already-clued is false;
	let test-output-yet be false;
	repeat through table of monties:
		if on-off entry is true:
			now test-output-yet is true;
			say "========[test-title entry]:[line break]";
			follow the test-action entry;
	if test-output-yet is true:
		say "========END TESTS[line break]";

chapter nobooing

[* this resets the boo ticketies]

nobooing is an action out of world.

understand the command "noboo" as something new.

understand "noboo" as nobooing.

carry out nobooing:
	move player to pressure pier;
	now trail paper is off-stage;
	now Erin is in Soda Club;
	now erin-warn is false;
	now toad-got-you is false;
	now drop-ticket is false;
	now erin-done is false;
	now minimum bear is in joint strip;
	now haha brew is off-stage;
	now cooler wine is off-stage;
	now your-tix is 0;
	the rule succeeds;

chapter cribing

[* this should be folded into MONTY later]

cribing is an action out of world.

understand the command "crib" as something new.

understand "crib" as cribing.

carry out cribing:
	now monty-full is whether or not monty-full is false;
	say "MONTY now [if monty-full is true]shows[else]hides[end if] crib hints.";
	the rule succeeds;

chapter donoteing

[* this shows hints once, for testers who are stuck]

donoteing is an action out of world.

understand the command "donote" as something new.

understand "donote" as donoteing.

carry out donoteing:
	say "Soul: ";
	hint-blue;
	say "Blood: ";
	hint-red;
	say "Big: ";
	hint-big;
	the rule succeeds;

chapter brobyeing

[* all 3 brothers to lalaland]

brobyeing is an action out of world.

understand the command "brobye" as something new.

understand "brobye" as brobyeing.

carry out brobyeing:
	if bros-left is 0:
		say "You already got rid of all the brothers." instead;
	now brother blood is in lalaland;
	now brother soul is in lalaland;
	now brother big is in lalaland;
	say "The Keeper Brothers are now out of play. This may cause some oddness with in-game stuff, including solving puzzles that lead up to dispersing the Brothers.";
	if silly boris is in Nominal Fen:
		say "Do you wish to get rid of the [j-co], too?";
		if the player yes-consents:
			now all clients are in lalaland;
			now player has quiz pop;
			say "You now have the quiz pop.";
		else:
			say "If you want to, you can use JGO to get rid of the [j-co], or just JERK to see who's 'guilty' of what.";
	the rule succeeds;

chapter bro1ing

[* random bro to lalaland]

bro1ing is an action out of world.

understand the command "bro1" as something new.

understand "bro1" as brobyeing.

carry out bro1ing:
	if number of stillblocking people is 0:
		say "Everyone's gone.";
		the rule succeeds;
	let Z be a random stillblocking person;
	now Z is in lalaland;
	say "Moved [Z] to lalaland.";
	now a random bro is in lalaland;
	say "[list of stillblocking people] still in Questions Field.";
	say "This is a test command only.";
	the rule succeeds;

chapter acbyeing

[* this lets testers bypass Cute Percy]

acbyeing is an action out of world.

understand the command "acbye" as something new.
understand the command "ctc" as something new.
understand the command "ctp" as something new.

understand "ctc" as acbyeing.
understand "ctp" as acbyeing.
understand "acbye" as acbyeing.

carry out acbyeing:
	if Cute Percy is in lalaland:
		say "Cute Percy is already gone!";
	else:
		say "I've sent Cute Percy to the great beyond. This is not reversible except with UNDO or RESTART.";
		if p-c is true:
			say "Also, stopping your current game.";
			now p-c is false;
		open-below instead;
	the rule succeeds;

chapter jerking

[* this tells testers what to do with the jerks]

jerking is an action out of world.

understand the command "jerk" as something new.
understand the command "groan" as something new.

understand "jerk" as jerking.
understand "groan" as jerking.

carry out jerking:
	if silly boris is in lalaland:
		say "The [j-co] are already gone instead. You'll need to RESTART if you want them back." instead;
	if Nominal Fen is unvisited:
		say "You haven't made it to the [j-co] yet. ";
	if finger index is not examined or know-jerks is false:
		say "You need to have examined the Finger Index or learned the [j-co]['] names to see the clues. You haven't, but would you like to cheat?";
		if the player yes-consents:
			now finger index is examined;
			now know-jerks is true;
		else:
			say "OK, this command will still be here." instead;
	repeat through table of fingerings:
		if jerky-guy entry is not buddy best:
			say "[jerky-guy entry] [blackmail entry].";
	the rule succeeds.

chapter jgoing

[* this gets rid of the jerks]

jgoing is an action out of world.

understand the command "jgo" as something new.

understand "jgo" as jgoing.

carry out jgoing:
	if boris is in lalaland:
		say "Jerks are already gone." instead;
	now all clients are in lalaland;
	now player has quiz pop;
	say "Bye bye [j-co]! Oh, you have the quiz pop, too.";
	the rule succeeds;

chapter soffing

[* ship the tester off to each room in order]

soffing is an action out of world.

understand the command "soff" as something new.

understand "soff" as soffing.

carry out soffing:
	repeat with Q running through rooms in bad ends:
		ship-off Q;
	the rule succeeds;

chapter xpalling

[* this explains all visible]

xpalling is an action out of world.

understand the command "xpall" as something new.

understand "xpall" as xpalling.

carry out xpalling:
	repeat with Q running through visible things:
		if Q is not Alec Smart:
			say "[Q]: ";
			try explaining Q;
	the rule succeeds;

chapter esting

[* this lets the player try a bunch of wins without undo ]

esting is an action out of world.

understand the command "est" as something new.

understand "est" as esting.

carry out esting:
	now end-stress-test is whether or not end-stress-test is false;
	say "End stress testing is now [on-off of end-stress-test].";
	the rule succeeds;

chapter amaping

[* toggles automapping every turn]

amaping is an action out of world.

understand the command "amap" as something new.

understand "amap" as amaping.

amap-on is a truth state that varies.

carry out amaping:
	now amap-on is whether or not amap-on is false;
	say "Automapping is now [on-off of amap-on]";
	the rule succeeds;

after printing the locale description when location of player is unvisited:
	if amap-on is true:
		try maping;
	continue the action;

chapter vicing

[* forces victory ]

vicing is an action out of world.

understand the command "vic" as something new.

understand "vic" as vicing.

carry out vicing:
	move the player to out mist, without printing a room description;
	end the story finally saying "LISTS CHECK (GOOD ENDING)";
	consider the shutdown rules;
	the rule succeeds;

chapter vicxing

[* forces very good ending]

vicxing is an action out of world.

understand the command "vicx" as something new.

understand "vicx" as vicxing.

carry out vicxing:
	move the player to airy station, without printing a room description;
	end the story finally saying "LISTS CHECK (VERY GOOD ENDING)";
	consider the shutdown rules;
	the rule succeeds;

chapter bcing

[* see who has a babble summary]

bcing is an action out of world.

understand the command "bc" as something new.

understand "bc" as bcing.

to see-babble (pe - a person):
	repeat through table of npc talk summaries:
		if pe is babbler entry:
			say "[i][pe] has a babble summary[r].";
			continue the action;
	say "[b][pe] needs a babble summary[r].";

carry out bcing:
	repeat with X running through people:
		if litany of X is table of no conversation:
			say "[X] has no conversation table.";
	repeat with X running through people:
		unless litany of X is table of no conversation:
			[if X is a babbler listed in table of npc talk summaries:
				say "[i][X] has a babble summary[r].";
			else:
				say "[b][X] has no babble summary[r].";]
			see-babble X;
	the rule succeeds;

chapter jfixing

[ * this fixes the jerks with dandy jim 1-2-3-4-5-6-7]

jfixing is an action out of world.

understand the command "jfix" as something new.

understand "jfix" as jfixing.

carry out jfixing:
	if finger index is not examined:
		say "NOTE: you didn't examine the finger index, so I did that. This is a bit out of order for the game, but it shouldn't make a difference.";
	now finger index is examined;
	re-fix;
	say "Talk to Dandy Jim, then exit the conversation with 10. Now 1-2-3-4-5-6-7 should work.";

to re-fix:
	repeat through table of fingerings:
		now jerky-guy entry is buddy best;
		now suspect entry is 0;
	choose row with my-quip of jerk-veg in table of fingerings;
	now jerky-guy entry is dandy jim;
	now next-c of cain reyes is dandy jim;
	choose row with my-quip of jerk-comedian in table of fingerings;
	now jerky-guy entry is silly boris;
	now next-c of dandy jim is silly boris;
	choose row with my-quip of jerk-pro in table of fingerings;
	now jerky-guy entry is wash white;
	now next-c of silly boris is wash white;
	choose row with my-quip of jerk-chess in table of fingerings;
	now jerky-guy entry is warner dyer;
	now next-c of wash white is warner dyer;
	choose row with my-quip of jerk-undies in table of fingerings;
	now jerky-guy entry is warm luke;
	now next-c of warner dyer is warm luke;
	choose row with my-quip of jerk-anne in table of fingerings;
	now jerky-guy entry is paul kast;
	now next-c of warm luke is paul kast;
	choose row with my-quip of jerk-light in table of fingerings;
	now jerky-guy entry is cain reyes;
	now next-c of paul kast is cain reyes;
	repeat through table of jt:
		if response entry is jerk-hows or response entry is jerk-baiter or response entry is jerk-next or response entry is jerk-bye:
			do nothing;
		else if response entry is jerk-veg or response entry is jerk-comedian or response entry is jerk-pro or response entry is jerk-chess or response entry is jerk-undies or response entry is jerk-anne or response entry is jerk-light:
			now enabled entry is 1;
			now response entry is jerky;
		else:
			now response entry is not jerky;
			now enabled entry is 0;
	the rule succeeds;

chapter plowing

[ * this plows through a convo and leaves nothing to say. Obviously this can cause a game breaking bug so I'm not revealing it to testers.]

plowing is an action applying to one thing.

understand the command "plow" as something new.

understand "plow [person]" as plowing.

carry out plowing:
	if litany of noun is table of no conversation:
		say "They're not talkable right now!";
	else:
		repeat through litany of noun:
			if enabled entry < 2:
				now enabled entry is 0;
		say "REJECT MESSAGE:[line break]";
		try talking to noun;
	the rule succeeds.

chapter jrming

[* jrm sends you back to the jerks. jrtm checks to see if the test succeeded. You also get the mint back. ]

total-tests is a number that varies.

tests-failed is a number that varies.

jrtming is an action applying to one topic.

jrming is an action out of world.

understand the command "jrm" as something new.

understand "jrm [text]" as jrtming.

understand "jrm" as jrming.

to check-boris:
	if qbc_litany is not table of no conversation:
		end the story saying "TEST WENT AWRY";
		continue the action;
	increment total-tests;
	if boris is in Nominal Fen:
		increment tests-failed;
	re-fix;

to say test-prog:
	if tests-failed is 0:
		say "ALL [total-tests] TESTS SUCCEEDED SO FAR";
	else:
		say "[tests-failed] of [total-tests] failed";

carry out jrtming:
	check-boris;
	say "Test [topic understood] [if boris is not in Nominal Fen]passed[else]failed[end if], [test-prog].";
	try jrming instead;

carry out jrming:
	now all clients are in Nominal Fen;
	now all clients are not minted;
	now player has condition mint;
	the rule succeeds;

chapter jring

[* removes you to the Nominal Fen without changing the jerks eg mint is still used ]

jrting is an action applying to one topic.

jring is an action out of world.

understand the command "jr" as something new.

understand "jr [text]" as jrting.

understand "jr" as jring.

carry out jrting:
	check-boris;
	say "Test [topic understood] [if boris is not in Nominal Fen]passed[else]failed[end if], [test-prog].";
	try jring instead;

carry out jring:
	now all clients are in Nominal Fen;
	the rule succeeds;

chapter fining

[* spoils the finger index's contents]

fining is an action out of world.

understand the command "fin" as something new.

understand "fin" as fining.

carry out fining:
	repeat through table of fingerings:
		if jerky-guy entry is not buddy best:
			say "[jerky-guy entry]: [blackmail entry].";
	the rule succeeds;

chapter xinding

[* this flags the finger index as examined]

xinding is an action out of world.

understand the command "xind" as something new.

understand "xind" as xinding.

carry out xinding:
	now finger index is examined;
	the rule succeeds;

chapter cswearing

[ * this lets someone re-try the Choose Swearing routine. ]

cswearing is an action out of world.

understand the command "cswear" as something new.

understand "cswear" as cswearing.

carry out cswearing:
	let restore-debug be debug-state;
	now debug-state is false;
	say "This is a test for the swearing option at the game's start.";
	say "> ";
	choose-swearing;
	now debug-state is restore-debug;
	the rule succeeds;

chapter vuing

[ * this either unlocks all the verbs (vu 1) or locks them (vu 0) ]

vuing is an action out of world applying to one number.
vu0ing is an action out of world.

understand the command "vu" as something new.

understand "vu [number]" as vuing.

understand "vu" as vu0ing.

carry out vu0ing:
	choose row 1 in table of verb-unlocks;
	if found entry is true:
		try vuing 0;
	else:
		try vuing 1;

carry out vuing:
	if number understood > 1 or number understood < 0:
		say "0 clears verb unlocks, 1 puts them all in." instead;
	let vuc be whether or not number understood is 1;
	let vuc2 be vuc;
	repeat through table of verb-unlocks:
		now found entry is vuc;
		now jumpable entry is vuc2;
		if brief entry is "notice":
			now vuc2 is false;
	say "All verb-unlock found entries are now [vuc].";
	the rule succeeds;

chapter zping

[*zp = power wait. This goes through everything in a table. ]

zping is an action applying to nothing.

understand the command "zp" as something new.

understand "zp" as zping.

books-not-song is a truth state that varies.

carry out zping: [this is hard coded but I hope that things work okay]
	let waits be 0;
	if player is in fen, now waits is number of rows in table of jerk-macho-talk + 1;
	if mrlp is Dream Sequence, now waits is number of rows in table of sleep stories * 3;
	if player is in pressure pier:
		now waits is number of rows in table of bible references + 1;
	if player is in Freak Control, now waits is number of rows in table of bad guy worries + 1;
	if player is in Speaking Plain, now waits is number of rows in table of dutch-blab + 1;
	if player is in Truth Home, now waits is number of rows in table of incisive sid viewpoints + 1;
	if player is in Discussion block:
		if books-not-song is true:
			now waits is number of rows in table of horrendous books + 1;
		else:
			now waits is number of rows in table of horrendous songs + 1;
	if waits is 0, say "Waiting does nothing special here." instead;
	repeat with X running from 1 to waits:
		say "[bracket]Try [X][close bracket]:[line break]";
		if player is in pressure pier:
			try examining basher bible;
		else if player is in discussion block:
			if books-not-song is true:
				try examining the book bank;
			else:
				try examining the song torch;
		else:
			try waiting;
	the rule succeeds;

section zpting

[* this toggles what to poke at in Discussion Block]

zpting is an action applying to nothing.

understand the command "zpt" as something new.

understand "zpt" as zpting.

carry out zpting:
	now books-not-song is whether or not books-not-song is false;
	say "Now searching for all the [if books-not-song is true]books[else]songs[end if] in Discussion Block.";
	the rule succeeds;

chapter jing

[* this jumps the tester ahead one stage]

jing is an action out of world.

understand the command "j" as something new.

understand "j" as jing.

carry out jing:
	if player is in smart street:
		now player has gesture token;
		now player is in round lounge instead;
	if player is in round lounge:
		now player is in Tension Surface instead;
	if mrlp is Beginning:
		now gesture token is in lalaland;
		now proof of burden is in lalaland;
		now player is in Pressure Pier instead;
	if mrlp is outer bounds:
		now trail paper is in lalaland;
		now player is in Nominal Fen instead;
	say "Now that you're in the main area, this command won't let you warp further in your beta testing quest. However, BROBYE will disperse the Brothers, JGO will spoil the [j-co]['] puzzle, and JERK(S)/GROAN(S) will clue it." instead;
	the rule succeeds;
