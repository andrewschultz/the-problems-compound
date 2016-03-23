"The Problems Compound" by Andrew Schultz

the story headline is "A Direction of Sense: changing what's-thats to that's-whats"

volume initialization

Release along with an interpreter.

Release along with cover art.

use the serial comma.

use American dialect.

the release number is 2.

book includes

include Basic Screen Effects by Emily Short.

include Conditional Undo by Jesse McGrew.

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
	if one-true is false:
		say "DEBUG TEST: All rooms have regions.";
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
	now all clients are in Jerk Circle;
	sort table of fingerings in random order;
	while number of not specified clients > 0:
		let Q be a random not specified client;
		increment temp;
		choose row temp in table of fingerings;
		now jerky-guy entry is Q;
		now Q is specified;
		d "[jerky-guy entry] = [blackmail entry].";
	sort table of fingerings in random order;
	choose row 7 in table of fingerings;
	let f-cur-row be 0;
	let temp-cli be Buddy Best;
	let first-cli be Buddy Best;
	repeat through table of fingerings:
		unless jerky-guy entry is Buddy Best:
			unless temp-cli is Buddy Best:
				now next-c of temp-cli is jerky-guy entry;
				d "[temp-cli] to [jerky-guy entry].";
			else:
				now first-cli is jerky-guy entry;
			now temp-cli is jerky-guy entry;
	d "[temp-cli] to [first-cli].";
	now next-c of temp-cli is first-cli;

when play begins (this is the sort ALL the tables rule) :
	sort table of gadget action in random order;
	sort the table of dutch-blab in random order;
	sort the table of sleep stories in random order;
	sort the table of horrendous books in random order;
	sort the table of horrendous songs in random order;
	continue the action;

when play begins (this is the initialize missing table element rule) :
	repeat through table of amusingness:
		if there is no anyrule entry:
			now anyrule entry is degen-true rule;

when play begins (this is the initialize bad room viewing rule):
	let room-index be 0;
	repeat with RM running through rooms in Just Ideas Now:
		increment room-index;
		now point-view of RM is room-index;
	now switch-to-bad is room-index;
	repeat with RM running through rooms in Bad Ends:
		increment room-index;
		now point-view of RM is room-index;
	now idea-rooms is room-index;

when play begins (this is the actual start rule):
	force-status;
	say "The Problems Compound may contain minor profanity/innuendo that is not critical to the story. Type Y or YES if this is okay. Typing N or NO will provide alternate text.";
	let qq be swear-decide;
	if qq is 2:
		say "You hear someone moan 'Great, another indecisive type! We'll go easy with the tough language. I guess.'[paragraph break]";
		now allow-swears is false;
	else if qq is 1:
		say "You hear someone sniff. 'Oh, good, someone at least willing to TRY the heavy-hitting stuff.'[paragraph break]";
		now allow-swears is true;
	else:
		say "You hear a far-off voice: 'Great. No freakin['] profanity. Sorry, FLIPPIN[']. In case they're extra sensitive.'";
		now allow-swears is false;
	wfak;
	say "Also, The Problems Compound has minimal support for screen readers. In particular, it makes one puzzle less nightmarish. Are you using a screen reader?";
	if the player no-consents:
		now screen-read is true;
	else:
		now screen-read is false;
	if screen-read is false:
		say "Also, how thick are your glasses, if you have them? How much acne--? Wait, no, that's irrelevant. When you're stuck, you're stuck. Let's...let's get on with things.";
		wfak;
	say "It's not [i]The Phantom Tollbooth[r]'s fault your umpteenth re-reading fell flat earlier this evening. Perhaps now you're really too old for it to give you a boost, especially since you're in advanced high school classes. Classes where you learn about the Law of Diminishing Returns.[paragraph break]Or how protagonists gain character through conflict--conflict much tougher than class discussions you barely have energy for. It's all so frustrating--you hate small talk, but you still talk small, and there's no way around. You pick the book up--you shouldn't have chucked it on the floor. Back to the bookcase...";
	wfak;
	say "[line break]Odd. Why's a bookmark wedged there? You always read the book in one go!";
	wfak;
	say "[line break]That's not a bookmark. It's a ticket to some place called the Problems Compound, just off Smart Street. And it has your name on it! FOR ALEC SMART. Too bad it's missing directions.";
	wfak;
	say "[line break]> TAKE TICKET. PUT BOOK ON SHELF. GO GET A DRINK OF WATER";
	wfak;
	say "[paragraph break]The end of the hallway keeps getting farther away. You start to run, which makes it worse. You close your eyes until, exhausted, you catch your breath. The hallway's gone.";
	set the pronoun him to Guy Sweet;
	now right hand status line is "[your-mood]";
	now started-yet is true;

to say your-mood:
	if cookie-eaten is true:
		say "WAY TOO COOL";
	else if off-eaten is true:
		say "NO FUNNY STUFF";
	else if greater-eaten is true:
		say "PUZZLES? PFF";
	else if player is in Smart Street:
		say "Just Starting";
	else if player is in lounge:
		say "First Puzzle";
	else if mrlp is beginning:
		say "[if player is in surface]T[else]Near t[end if]he Arch";
	else if mrlp is outer bounds:
		if trail paper is in lalaland:
			do nothing;
		else:
			if your-tix is 0:
				say "Find trouble?";
			else:
				say "[your-tix]/4 ticketies";
			the rule succeeds;
		say "[if player is in pressure pier]By Howdy Boy[else]Find Trouble[end if]";
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
	else if player is in jerk circle and silly boris is in jerk circle:
		say "7[']s a crowd";
	else if player is in Wood and p-c is true:
		say "Chasing";
	else if player is in Belt Below:
		say "[unless terminal is in Belt Below]Cheats below[else if terminal is examined]Puzzling[else]";
	else if player is in Bottom Rock:
		say "Spoilerville";
	else:
		say "[the score]/[maximum score][if questions field is visited][bro-sco][end if]";

to say bro-sco:
	say ", [3 - bros-left] Bro[if bros-left is not 2]s[end if]";

section read what's been done

when play begins (this is the read options file rule):
	say "Trying to read.";
	if file of verb-unlocks exists:
		read file of verb-unlocks into table of verb-unlocks;

the file of verb-unlocks is called "pcverbs".

table of vu - verb-unlocks [tvu]
brief (indexed text)	found	expound	jumpable	descr (indexed text)
"anno"	false	true	false	"ANNO to show annotations, or JUMP to jump to a bunch of rejected rooms, as a sort of director's cut."
"duck"	false	true	true	"DUCK SITTING to jump to Tension Surface."
"knock"	false	true	true	"KNOCK HARD to get to Pressure Pier."
"figure"	false	true	true	"FIGURE A CUT to skip past the Howdy Boy to the [jc]."
"notice"	false	true	true	"NOTICE ADVANCE to skip to Questions Field, with the brothers and jerks gone."
"good"	false	false	false	"You found a good ending!"
"great"	false	false	false	"You found the great ending!"

to unlock-verb (t - text):
	let j be indexed text;
	repeat through table of verb-unlocks:
		now j is "[brief entry]";
		if j matches the regular expression "[t]":
			if found entry is true:
				continue the action;
			if expound entry is true:
				say "[i][bracket]NOTE: you have just unlocked a new verb![close bracket][r][paragraph break]";
				say "On restarting, you may now [descr entry][line break]";
			now found entry is true;
			write file of verb-unlocks from table of verb-unlocks;
			continue the action;
	say "BUG! I tried to add a verb for [t] but failed. Let me know at [email] as this should not have happened.";

to decide whether (t - text) is skip-verified:
	repeat through table of verb-unlocks:
		if brief entry matches the regular expression "[t]":
			if found entry is false:
				say "You don't seem to have unlocked that verb yet. Are you sure you wish to go ahead?";
				unless the player consents:
					say "OK. You can try this again, if you want. There's no penalty.";
					decide no;
				say "Okay. You can undo if you change your mind.";
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

a person can be surveyable, baiter-aligned, or unaffected. a person is usually unaffected.

Procedural rule: ignore the print final score rule.

a thing can be abstract. a thing is usually not abstract.

a client is a kind of person. a client is usually male. a client can be specified. a client is usually not specified. a client has text called clue-letter.

an enforcer is a kind of person.

to decide whether the action is undrastic:
	if examining, decide yes;
	if explaining, decide yes;
	decide no;

chapter misc defs for later

a concept is a kind of thing. description of a concept is usually "[bug]"

a concept has text called howto. howto of a concept is "(need text)".

a concept can be explained. a concept is usually not explained.

a drinkable is a kind of thing.
does the player mean drinking a drinkable: it is very likely.

a smokable is a kind of thing.

a hintable is a kind of thing.

a logic-game is a kind of thing. a logic-game has a number called times-won. times-won of a logic-game is usually 0. a logic-game has a number called max-won.

a logic-game can be tried. a logic-game is usually not tried.

volume stubs

section nicety stubs

to say sr-space:
	if screen-read is true:
		say " ";

section rerouting verb tries

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
	say "That command seemed like it was longer than it needed to be. You may wish to cut a word or two down. Push 1 to retry [word number 1 in the player's command in upper case][if nw > 1] or up to [nw] to retry the first [nw] words, or any other key to try something else.";
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

section debug stubs

[these 3 must be in release section since release code uses them trivially at points. Beta = for beta testers, Debug-state is my own debugging, stop-on-bug is for me in case something bad happens.]

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
	if player is in pressure pier:
		if myd is south:
			decide no;
	if player is in scheme pyramid and contract-signed is false:
		if myd is north:
			decide no;
	if the room myd of the location of the player is nowhere:
		decide no;
	decide yes;

exits-mentioned is a truth state that varies.

every turn:
	if print-exits is true:
		now exits-mentioned is false;

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

understand the command "pe" as something new.

understand "pe" as peing.

carry out peing:
	now print-exits is whether or not print-exits is false;
	say "The Problems Compound now [if print-exits is true]displays[else]does not display[end if] exits when you look or move to another room.";
	the rule succeeds;

section procedurality

to decide whether the action is procedural: [aip]
	if examining, yes;
	if attacking, yes;
	if saying yes, yes;
	if saying no, yes;
	if dropping, yes;
	if looking, yes;
	if listening, yes;
	no;

section shorthand

to decide what region is imr of (x - a thing):
	if x is off-stage:
		decide on nothing;
	decide on map region of location of x;

to decide what region is mrlp:
	decide on map region of location of player.

section formatting

to say r:
	say "[roman type]";

to say b:
	say "[bold type]";

to say i:
	say "[italic type]";

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
	if player is in pot chamber:
		say "Nancy Reagan would be [if current action is saying no]proud[else]ashamed[end if].";
		continue the action;
	if not-conversing:
		say "You always feel pushed around being asked a yes-or-no question. Like you can't say what you really want to say, not that you were sure anyway (you don't need to say yes or no here, but you can RECAP to see a list of options).";
	else:
		say "[one of]You freeze up. Was that a rhetorical question just now? Where did it come from? [or][stopping]Your nos and yesses never quiiite meant what they hoped to mean. Sometimes it's a relief not to be forced to say an essay, but other times--man, others seem to be better with those short words than you are.";
	if yes-yet is false:
		now yes-yet is true;
		say "[bracket]NOTE: you don't need to answer rhetorical questions, and I tried to avoid them, but characters may ask you a few.[close bracket][line break]";

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

the maximum score is 19.

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
		say "You have [number of unvisited rooms in mrlp] to visit here, and ";
		if window bay is unvisited:
			say "you haven't found the place that lets you see a few others.";
		else:
			say "you've seen [number of visited rooms in just ideas now] rooms in the view of points.";
		the rule succeeds;
	if mrlp is Beginning:
		say "You don't need to worry about score yet. You're still poking around." instead;
	if mrlp is outer:
		if your-tix > 0:
			say "You have [your-tix] of the 4 boo-ticketies you need." instead;
		say "You don't feel you've made it anywhere, yet." instead;
	say "You have scored [score] of [maximum score] points";
	if number of map-pinged rooms > 1:
		say ", and you've also been to [number of map-pinged rooms] or [number of rooms in bad ends] rooms";
	say ".";
	say "[line break]";
	if Questions Field is unvisited:
		say "You haven't gotten near the [bad-guy]'s hideout yet. So maybe you need to explore a bit more." instead;
	if player is in out mist:
		say "You need to modify the worm ring somehow." instead;
	if player is in airy station:
		say "You need to modify the hammer somehow." instead;
	if qp-hint is true and quiz pop is not in lalaland:
		say "You need some way to get past the question/exclamation mark guard combination. It's like--I don't know. A big ol['] pop quiz or something." instead;
	if player has crocked half and thoughts idol is not in lalaland:
		say "You haven't found what the crocked half's clue is, either." instead;
	say "You have currently helped [if bros-left is 3]none[else if bros-left is 0]all[else][3 - bros-left in words][end if] of the Keeper Brothers." instead;
	say "You've found [number of endfound rooms] bad end[if number of endfound rooms is not 1]s[end if] out of [number of rooms in Bad Ends]: [list of endfound rooms]." instead;

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
	now player has all things in bullpen;

chapter waiting

check waiting (this is the caught napping rule):
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if player is in down ground and slept-through is false:
		say "[one of]You attempt to loiter in this seedy area in order to get in trouble or something, but no dice.[or]Still, nobody comes to break up your loitering.[or]You reflect if you want to get zapped for loitering, maybe you need to do better than just hang around.[or]Hm, you wonder what is even lazier than standing around.[stopping]" instead;
	say "Turn your wait." instead;

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

check dropping face of loss:
	say "You're frowning enough, probably, why make it worse?" instead;

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
		say "'Aw, c'mon,' you hear the Word Weasel say, in your head[if player is in garden]. You think it was in your head[end if]." instead;
	if noun is dreadful penny:
		say "The penny doesn't drop on any puzzle you want to solve." instead;
	if noun is minimum bear:
		say "No. It's just cute enough not to abandon[if your-tix < 4 and litter-clue is true], and dropping it wouldn't feel like LITTERING[end if]. It's somebody's. But whose?" instead;
	if noun is trail paper:
		say "No way. You should return that to the Howdy Boy!" instead;
	if noun is cooler or noun is haha:
		if your-tix >= 4:
			say "Now you're living on the edge with four ticketies, you're confident you can get away with dropping a drink to avoid getting busted by the Stool Toad.";
			now noun is in lalaland instead;
		if lily is in lalaland:
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
	say "You don't need to leave anything lying around. In fact, you shouldn't[if your-tix < 4 and litter-clue is true], unless you want to annoy authority figures who may not actually care about the environment anyway." instead;

chapter buying

the block buying rule is not listed in any rulebook.

understand "buy [text]" as a mistake ("If you want a[n-dr] drink, you'll need to talk to the Punch Sucker.") when player is in Soda Club.

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


chapter jumping

jump-from-room is a room that varies. jump-from-room is Smart Street.

jump-to-room is a room that varies. jump-to-room is One Route.

instead of jumping:
	if player is in round lounge:
		if player is on person chair:
			say "You're actually worried you might hit your head on the ceiling. You consider jumping to grab the crack in the hatch and swing it open Indiana Jones style, but...no. You'd need to push it open a bit more first[one of].[paragraph break]NOTE: if you want to jump off, just EXIT or DOWN works[or][stopping]." instead;
		say "You jump for the hatch, but you don't get close." instead;
	if player is in tension surface:
		say "[if mush is in lalaland]You can just enter the arch[else]No, it's too far to jump over the mouth[end if]." instead;
	if anno-allow is true:
		if accel-ending:
			say "That [random badfood in lalaland] you ate was enough of a mental jump. You don't have time for silly details--well, not until you restart the game." instead;
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
				say "You can make the following jumps [if player is not in smart street] on restart[end if]:[line break]";
				now any-jumps is true;
			say "[2da][descr entry][line break]";
	if any-jumps is false:
		say "You're not ready to form hasty conclusions."

chapter thinking

think-score is a truth state that varies.

instead of thinking:
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if finger index is examined and silly boris is in jerk circle:
		say "Hmm. You remember the finger index and the seven jerks.";
		say "[finger-say]" instead;
	if think-score is false:
		say "NOTE: THINK will redirect to SCORE in the future.";
		now think-score is true;
	say "[one of]You take a thought-second. Then you take another, but you reflect it wasn't as good. OR WAS IT? So you just[or]You[stopping] think about what you've accomplished..." instead;
	try requesting the score instead;

pot-not-weed is a truth state that varies.

chapter waving

understand the command "wave" as something new.

understand "waving" as waving.

carry out waving:
	say "Your awkward wave never managed the gravitas others['] awkward waves have. Yours accepts awkwardness, but theirs foists it on others.";
	the rule succeeds;

chapter swearing

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

carry out do-swearing:
	unless accel-ending:
		if hypoc-swear is 0:
			say "A voice in your head reminds you of your gross, gross hypocrisy in swearing when you opted for no profanity, but dang it, you're confused and frustrated.";
		else if hypoc-swear is 1:
			say "The 'hypocrisy' of swearing feels a bit less, now. Yes, you're allowed to change your mind. And...well...you know how people can manipulate with the threat of a swear, or saying, don't make me swear.";
		else:
			say "It's almost getting a bit boring breaking the rules again.";
		if hypoc-swear < 2:
			increment hypoc-swear;
	if player is in Soda Club:
		say "You reckon that's how people are supposed to cuss in a bar, er, club, but you can't give that word the right oomph." instead;
	if player is in cult:
		say "That'd be extra rude in a place like this." instead;
	if player is in chipper wood and assassination is in chipper wood:
		say "The assassin smirks[if p-c is true]. 'That won't do any good!'[else].[end if]" instead;
	if player is in belt and terminal is in belt:
		say "Sorry, man. I didn't mean for it to be THIS hard." instead;
	if player is in joint strip:
		if toad-swear is false:
			now toad-swear is true;
			say "'It's a damn shame. Kids thinking they're tougher than they are. I had a lot more to swear ABOUT when I was a kid.'" instead;
		say "'Repeat offender? Cutting up for the fun of it? Off you go!'";
		ship-off in-dignity heap instead;
	if player is in freak control:
		say "That gets the [bad-guy]'s attention. 'DUDE!' he says. 'REALLY, dude! Some respect for authority? I mean, don't respect stupid authority but I *** need to *** concentrate, here. My job's not *** easy and anyone who just swears frivolously to grab attention--well, they don't GET IT, y'know? Besides, you sounded lame when you said that.' As you're pulled away by guards you hadn't seen before, the 'OUT, FREAK' sign catches your eye. Perhaps there was another way to annoy him, without letting him be so self-righteous.";
		ship-off in-dignity heap instead;
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
		say "You feel especially apathetic here. Yes, it's a good place to drift off.";
		if last-dream-loc is visited:
			say "[line break]You slip back into the old dream.";
		go-to-dream;
		the rule succeeds;
	if mrlp is rejected rooms:
		say "Oh no, this extra material isn't THAT boring, is it?" instead;
	if mrlp is Main Chunk:
		say "There are too many energetic people around here." instead;
	if Down Ground is unvisited:
		say "You're nowhere near tired. You're curious what could be ahead." instead;
	if player is in Bottom Rock:
		say "The crib's too small for sleeping." instead;
	say "This doesn't look like the place to retreat for a nap." instead;

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

check pulling:
	if noun is a person:
		say "Physical force will work out poorly." instead;
	if noun is ring:
		say "Ring pull, pull ring... no, you need to do something else to the ring." instead;
	say "[im-im]pull." instead;

check pushing:
	if noun is a person:
		say "Physical force will work out poorly." instead;
	if noun is ring:
		say "Ring push, push ring... no, you need to do something else to the ring." instead;
	say "[im-im]push." instead;

chapter taking

the can't take what's fixed in place rule is not listed in any rulebook.

the can't take scenery rule is not listed in any rulebook.

before taking a person:
	if noun is weasel:
		say "He is too small and mobile." instead;
	say "You're not strong enough for the sort of WWF moves required to move a person." instead;

check taking:
	if noun is tray a or noun is tray b:
		say "Man. It's heavy. That might cause a balance strike[activation of strike a balance]." instead;
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
		say "[if petty is in judgment pass]Oh, Officer Petty would get you for that one![else][one of]You climb on the Intuition Counter for a moment and feel rebellious, but the feeling passes.[or]Nah, that's already old.[stopping]" instead;
	if noun is the nine yards hole:
		say "No footholds or handholds. You'd be stuck.";
	if noun is fright stage:
		say "[if dutch is in plain]There's not room enough for you. Well, there is, but you'd get shouted down quickly[else]You're too busy to shout platitudes right now. You could do better than Uncle Dutch and Turk Young, but really, you're thinking bigger than that[end if]." instead;
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
	say "That doesn't seem to work." instead;

chapter smelling

the block smelling rule is not listed in any rulebook.

check smelling (this is the smelling a thing rule):
	if noun is the player:
		say "That never works. People who smell bad are used to their own smells, but if you're caught sniffing yourself, whew." instead;
	if noun is poor dirt:
		say "The dirt doesn't smell of anything much." instead;
	if noun is poetic wax:
		say "You're sure you've smelled it before, and it's good and bad and a bit beyond you." instead;
	if noun is flower wall:
		say "Smells nice. Cancels out the [if scum is in tunnel]now-gone scum[else]scum, almost[end if]." instead;
	if noun is scum:
		say "It smells bad enough from where you are standing, even though you don't have a very picking nose[activation of nose picking]." instead;
	if noun is fritz:
		say "You'd rather not risk it." instead;
	if noun is bear:
		say "It smells kind of dirty." instead;
	if noun is poory pot:
		say "It smells like some cheap air freshener you bought once." instead;
	if noun is wacker weed:
		say "It doesn't smell dangerous to brain cells, but it is." instead;
	if noun is fish:
		say "The story fish is thankfully not organic enough to stink, or boy, WOULD it." instead;
	if noun is a person:
		say "You've had people give YOU the smell test, but somehow, even when you passed, you still failed." instead;

check smelling (this is the smelling a place rule): [see above for people]
	if player is in jerk circle and silly boris is in jerk circle:
		say "The [j-co] sniff back at you. You detect a greasy aroma, of meals that give indigestion." instead;
	if player is in down ground:
		say "It smells okay here, but maybe that's because you're not too close to Fritz the On." instead;
	if player is in temper keep:
		say "[if sal-sleepy is false]You can understand why Volatile Sal is upset about smells, but you don't understand why he thinks it's other people.[else]Much nicer now with the poory pot in the vent.[end if]" instead;
	if player is in joint strip:
		say "It smells a bit odd[if off-the-path is true]. But you can't go off the path again with the Stool Toad watching you[else]. You're tempted to check what's off the path, to the north or east[end if]." instead;
	if player is in pressure pier:
		say "A faint smell of various foods to the west." instead;
	if player is in meal square:
		say "So many foods mix here, it's hard to pick anything individually. Overall, smells pretty nice, though." instead;
	say "Nothing really smells too bad. You worry for a second it's because nothing smells worse than you." instead;

chapter looking

chapter listening

the block listening rule is not listed in any rulebook.

check listening (this is the listening to a thing rule):
	if noun is fritz:
		say "Fritz mumbles to himself[if fritz has bear] a bit more happily now he has minimum bear[else] nervously[end if]." instead;
	if noun is assassination:
		say "Now that you appear to be listening, the assassin is quiet." instead;
	if noun is petty:
		say "He gives off the occasional HMPH." instead;
	if noun is labor child:
		say "He yacks into an unseen headpiece." instead;
	if noun is a person:
		say "Maybe you should TALK TO them instead." instead;

jerk-close-listen is a truth state that varies.

check listening (this is the listening in a place rule):
	if qbc_litany is table of generic-jerk talk:
		now jerk-close-listen is true;
		say "You listen in a bit closer, so if your accusations disquieted the jerks enough, you'll know." instead;
	if player is in chipper wood:
		if assassination is in chipper wood:
			try listening to assassination instead;
	if player is in cult:
		say "That stereotypical 'OM' noise which fools nobody any more. The Goodes pretty clearly haven't taken any marketing clues from any big televangelist, and they seem happy just helping people feel at ease." instead;
	if player is in idiot village:
		say "You hear a faint duh-duh-duh. But wait a minute. Maybe it's there to ward off people who think they're a little too smart, and Idiot Village is not so stupid." instead;
	if player is in jerk circle:
		say "[if boris is in lalaland]Mercifully silent[else]The jerks gabble away about what is cool and what is not, and how they do not participate in any of the second[end if]." instead;
	if player is in surface and mush is in surface:
		say "The arch makes a slight tapping noise as it dances from side to side." instead;
	if player is in Soda Club:
		say "Under some [one of]popular[or]alternative[or]classical[in random order] tune you really should know, you think you hear some really hearty arguments about really dumb stuff." instead;
	if player is in pyramid:
		try listening to labor child instead;
	if player is in judgment and petty is in judgment:
		try listening to petty instead;
	if player is in speaking plain and dutch is in speaking plain:
		say "Hard NOT to listen to Uncle Dutch." instead;
	if player is in truth home and psycho is in truth home:
		say "[one of]'See there, Proof Fool? This guy sits and listens. Right?' Before you can agree, the Logical Psycho continues. Strictly speaking, everything he says is true, but he tends to weight this or that more than he should...[or]The Logical Psycho continues to spew truths, with his own unique weighting of what is important.[stopping]" instead;
	if player is in Discussion Block:
		if phil is in Discussion Block:
			say "[one of]M[or]More m[stopping]usic from the song torch!";
			try examining song torch instead;
	if player is in freak control:
		say "The apparatus emits an occasional work grunt, you suspect, to impress visitors." instead;
	if player is in out mist:
		say "You can't hear anyone. That's good." instead;
	if player is in airy station:
		say "The cheering's nice, but--it's a bit old. You wonder if you've done THAT much." instead;
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

check eating:
	if noun is lolly:
		say "You gag on it. What did you expect?";
		ship-off Maintenance High instead;
	if noun is condition mint:
		now mint is in lalaland;
		say "You feel healed." instead;
	if noun is iron waffle:
		say "No, it's iron." instead;
	if noun is a person:
		say "This isn't that sort of game." instead;
	say "Even if you were terribly hungry...no." instead;

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

check touching:
	if noun is hammer:
		say "It doesn't feel unusual, but maybe you can change it." instead;
	if noun is worm:
		say "It feels pliable, like you could manipulate it--no, that's too complex a word." instead;
	if noun is earth of scum:
		say "Ew. No." instead;
	if noun is bench:
		say "Mm. Nice. Warm. But not burning-hot." instead;
	if noun is Alec:
		say "You took a year longer than most to find out what that meant. You're still embarrassed by that." instead;
	if noun is assassination character:
		say "You'll need to [if p-c is true]catch him[else]ENTER the chase paper[end if]." instead;
	if noun is a person:
		say "That wouldn't be a fun poke[activation of poke fun]. It might even be a base touch[activation of touch base]." instead;
	say "You can just TAKE something if you want to." instead;

chapter taking inventory

check taking inventory (this is the adjust sleep rule) :
	if mrlp is dream sequence:
		say "You are carrying: (well, mentally anyway)[line break]  [if player is in tense past]Regret of past mistakes[else if player is in tense future]the weight of indecision[else]understanding of future failures but none of their solutions[end if][paragraph break]" instead;

the print standard inventory rule is not listed in any rulebook.

check taking inventory (this is the new standard inventory rule):
	if accel-ending:
		say "You have a new outlook on life, and you're ready to show it. No more silly off face[activation of face off], either." instead;
	if number of things carried by player is 1:
		say "You're empty-handed.[line break]";
	else:
		say "You are carrying:";
		repeat with X running through things carried by player:
			if X is bad face or X is face of loss:
				do nothing;
			else:
				say "  [X][line break]";
	say "[line break]";
	if player carries bad face:
		say "You're wearing a bad face.";
		now bad face is mentioned;
	else if player carries face of loss:
		say "You're wearing a face of loss.";
		now face of loss is mentioned;


chapter kissing

the block kissing rule is not listed in any rulebook.

check kissing:
	if noun is lily:
		say "The Stool Toad would probably be on you like a cheap suit." instead;
	if noun is punch sucker:
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
		say "As a businessperson, he doesn't have time for romance." instead;
	if noun is a client:
		say "[if finger index is examined]That's not his secret. Or, well, it's not the one the Labor Child is blackmailing him with. Not that either secret is wrong, just, people can be mean[else]This is not the way to make friends[end if]." instead;
	if noun is a person:
		say "You don't need to open yourself to gay-bashing. Despite equal rights blah blah, that stuff still HAPPENS in high school, because." instead;
	if noun is minimum bear:
		say "You're too old for that. You think." instead;
	if noun is language machine:
		say "No. You remember a story about another kid who loved his calculator too much, and what happened to him. The guy who told it liked to brag about his 60 inch TV." instead;
	say "Icky." instead;

chapter talking

check talking to alec:
	if cookie is in lalaland:
		say "You take time to discuss to yourself how people are dumber than they used to be before you had that Cutter Cookie." instead;
	if greater cheese is in lalaland:
		say "You mutter to yourself about how lame your self-talk used to be." instead;
	if off cheese is in lalaland:
		say "You grumble to yourself. You feel real hard to hang with." instead;
	say "You've already taken heat for talking to yourself. With people around or no, it's a bad habit. Socially, at least." instead;

understand "ask [person]" as talking to.
understand "ask [person] about " as talking to.

understand "ask [text]" as a mistake ("You can say ASK NPC, or if there is just one person, ASK will work.")

understand "talk [text]" as a mistake ("There's nobody named that, or you threw in an odd preposition. You can say TALK TO NPC, or if there is just one person, TALK will work.")

check asking it about:
	say "TALK TO [noun] is the main syntax for talking, so I'll switch to that.";
	try talking to noun instead;

chapter turning

before turning a person:
	say "You are worried enough about changing yourself. No time to try to change other people." instead;

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
		say "[i][bracket]NOTE: showing/displaying/presenting and giving are functionally equivalent in this game.[close bracket][r][paragraph break]";
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

chapter singing

the block singing rule is not listed in any rulebook.

check singing:
	if player is in Discussion Block:
		say "[if phil is in Discussion Block]You don't want to hear Phil's critique of your singing[else]You still can't compete with the song torch[end if]." instead;
	if player is in cult:
		say "You sense singing may be overdoing it for the cult here." instead;
	say "You never were the artsy type. And the songs you want to sing are always out of fashion." instead;

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
		say "Glug, glug. It tastes nasty. But suddenly your mind is whizzing with memories of people who out-talked you, and your realize how they did it and why." instead;
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
	let mrlg be map region of noun;
	if noun is off-stage or mrlg is nothing or mrlg is meta-rooms:
		say "[if noun is a person]They aren't[else]that isn't[end if] around right now." instead;
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
			say "You can't just go jetting off with a drink in your hand!" instead;
	if noun is service community:
		if idol is in lalaland:
			say "No need to go back." instead;
		say "You'll need to navigate that by yourself." instead;
	if player is in service community:
		say "So many ways to go! The Service Community expands everywhere. You need to just pick a direction." instead;
	if bros-left is 0 and mrlg is outer bounds:
		say "You don't need to go that far back. You're close to Freak Control, you know it." instead;
	if noun is Soda Club and player is not in joint strip:
		say "You'll have to walk by that nosy Stool Toad directly[if trail paper is in lalaland], not that you need to go back[end if]." instead;
	if noun is not a room:
		say "You need to specify a room or a thing." instead;
	if noun is court of contempt and reasoning circular is not off-stage:
		say "You can't go back. You could, but Buddy Best would scream you back outside." instead;
	if noun is unvisited:
		say "You haven't visited there yet." instead;
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
	continue the action;

chapter attacking

the block attacking rule is not listed in any rulebook.

understand the command "kick" as something new.

understand "kick [thing]" as attacking.

check attacking:
	if noun is player:
		say "You don't want to embarrass yourself like that." instead;
	if noun is tee:
		say "Instead of breaking the tee, maybe you can use it to break something else." instead;
	if noun is mouth mush:
		say "How? By stepping on it and falling into it? Smooth." instead;
	if noun is arch:
		say "[if mush is in surface]Maybe you could do a flying karate-leap to touch the arch, but you'd fall into the mouth mush, so no[else]You should really just ENTER it now[end if]." instead;
	if noun is gen-brush or noun is off brush or noun is back brush or noun is aside brush:
		say "Beating that brush would be beating around the brush." instead;
	if noun is fund hedge:
		say "'Vandalism is subject to fines and incarceration,' the Labor Child warns you as you take a swing. You [if money seed is off-stage]can probably just take what you need[else]already got the money seed[end if]." instead;
	if noun is a logic-game or noun is game shell:
		say "'Dude! I don't care about the logic games, but they're, like, someone's PROPERTY! And lashing out like that doesn't make you any less, um...' As you wait, you're grabbed from behind. It's some giant toad in a police uniform. Weird. 'There's a place for disrespectful troublemakers like you.'";
		ship-off Hut Ten instead;
	if noun is insanity terminal:
		say "It gives a ton of warning beeps. You run, but the Stool Toad and Officer Petty block the way up. 'Vandalism, eh? An expensive piece of property!'";
		ship-off Hut Ten instead;
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
		say "'Dude. REALLY? There's a bunch of them left,' says the [bad-guy] as you pound away. 'No damage d9ne? No. But it's the intent that matters. I don't know how you got in here but you'll be going somewhere far away.'";
		ship-off Criminals' Harbor instead;
	if noun is Baiter:
		say "Of course, with all those screens, he saw you well before you got close. He whirls and smacks you. Stunned, you offer no resistance as guards appear and take you away to where those who commit the worst crimes... 'Dude! If you wanted to talk, just TALK. I mean, you can't be too boring, but don't be all...' You don't hear the rest.";
		ship-off Punishment Capitol instead;
	if noun is an enforcer:
		say "'ATTACKING A LAW ENFORCEMENT OFFICER?' Ouch. You should've known better. And [noun] lets you know that in utterly needless detail, explaining just because you had no chance of beating him up doesn't mean it's not a very serious crime indeed.[paragraph break]It's almost a relief when he has finished shipping you off.";
		ship-off Punishment Capitol instead;
	if noun is a bro:
		say "'Silently, [noun] grabs you. [if bros-left is 1]Even without his brothers, it's a quick affair[else]His brothers hold you[end if]. He's apologetic--but he'd have liked to work with you, and violence is violence, and his job is his job. He realizes he is not so important, but anyone trying to break past him must have SOMETHING bad on their mind.";
		ship-off Punishment Capitol instead;
	if noun is list bucket:
		say "You didn't come so far only to -- wait for it -- kick the bucket. Surely there's a better way to get the [bad-guy]'s attention." instead;
	if noun is a person:
		if noun is female:
			say "Attacking people unprovoked is uncool, but attacking females is doubly uncool. You may not feel big and strong, but with that recent growth spurt, you're bigger than you used to be. The Stool Toad's quick on the scene, and while his knight-in-shining-armor act goes way overboard, to the point [noun] says that's enough--well, that doesn't change what you did.";
			ship-off Criminals' Harbor instead;
		say "You begin to lash out, but [the noun] says 'Hey! What's your problem?' [if joint strip is
		 visited]the Stool Toad[else]A big scary important looking man[end if] blusters over. 'WHOSE FAULT? QUIT HORSING AROUND!' You have no defense. 'THERE'S ONLY ONE PLACE TO REFORM VIOLENT TYPES LIKE YOU.' You--you should've KNOWN better than to lash out, but...";
		ship-off Fight Fair instead;
	if noun is language machine:
		say "[if wax is in lalaland]After you were so nice to it? That's rough, man[else]No, it needs compassion, here[end if]." instead;
	if noun is jerks:
		say "You've been suckered into lashing out before, but these guys--well, you've faced more annoying, truth be told." instead;
	if mrlp is endings:
		say "You don't need violence right now[if player is in station]. Well, maybe the right sort against the caps[end if]." instead;
	say "Lashing out against inanimate objects won't help, here. In fact, you may be lucky this one's unimportant enough you didn't get arrested." instead;

return-room is a room that varies.

to ship-off (X - a room):
	let ZZ be location of player;
	say "[b][X][r][paragraph break]";
	now X is map-pinged;
	if X is a room-loc listed in table of ending-places:
		choose row with room-loc of X in table of ending-places;
		say "[room-fun entry][paragraph break]";
	else:
		say "BUG! [X] isn't listed but should be.";
	say "Wait, no, that's not quite how it happened. It was tempting to lash out and step over the line, let's undo that so you can try again...";
	wfak;
	move player to ZZ, without printing a room description;

table of ending-places
room-loc	room-fun
Fight Fair	"You are placed against someone slightly stronger, quicker, and savvier than you. He beats you up rather easily, assuring you that just because you're smart doesn't mean you needed to lack any physical prowess. Your opponent then goes to face someone stronger than him."
Maintenance High	"You're given the lecture about how attempts to rehabilitate you cost society even if they work out pretty quickly."
Criminals' Harbor	"You're given the lecture about how you'll be performing drudgework until your attempts at obvious crime are sucked out of you."
Punishment Capitol	"You're given the lecture about how just because you did something really wrong doesn't mean you're a big thinker. Then you're told to sit and think deeply about that for a good long while."
Hut Ten	"The basic training isn't too bad. You seem to do everything right, except for the stuff you do wrong, and a commanding officer gets on your case for that. There's so much to do, and you only make mistakes 5% of the time, maybe, but boy do the people who get it right come down hard on you when you miss. You do the same to others, but it's DIFFERENT when you do. No, really."
A Beer Pound	"The admissions officer gives you a worksheet to fill out about how and why you can't hold your liquor."
In-Dignity Heap	"You're given a lecture and assured that they will have to get more abusive but still won't be as effective and eventually you'll build up a tolerance to abuse, and that's better than a tolerance to alcohol."
Shape Ship	"Here, you spend months toiling pointlessly with others who acquired too many boo ticketies. You actually strike up a few good friendships, and you all vow to take more fun silly risks when you get back home.[paragraph break]As the days pass, the whens change to ifs."

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

chapter item based [these see us giving specific items to specific characters. They come first.]

check giving smokable to: [poory pot or wacker weed]
	if second noun is stool toad:
		say "The Stool Toad jumps a whole foot in the air. 'How DARE you--on my turf--by me! OFFICER PETTY!' [if judgment pass is visited]Officer Petty[else]A man with a less fancy uniform[end if] rushes in and handcuffs you away and takes you to the...";
		ship-off Criminals' Harbor instead;
	if second noun is Officer Petty:
		say "Officer Petty begins a quick cuff em and stuff em routine while remarking how that stuff impairs your judgement, and you seemed kind of weird anyway. He summons the Stool Toad for backup, not that he's needed, but just to make your perp walk a little more humiliating.";
		ship-off Criminals' Harbor instead;
	if second noun is volatile sal:
		say "[if noun is poory pot]Sal might be offended by that. As if he is the one causing the smell. Maybe if you can make it so the poory pot can take over the whole room...[else]Sal would probably tell you he's no druggie.[end if]" instead;
	if second noun is logical psycho:
		say "That might mellow him out, but it also might start him lecturing on the idiocy of anti-pot laws. Which you don't want, regardless of his stance." instead;
	if second noun is faith or second noun is grace:
		say "That's probably not the sort of incense or decoration they want to use[if fourth-blossom is in lalaland]. You restored the blossom, anyway[else]. The bowl seems more for flowers[end if]." instead;
	if second noun is Pusher Penn:
		say "[if noun is weed]'Nope. No reneging.'[else]'Nonsense. That's your pay.'[end if]" instead;
	if second noun is Fritz the On:
		if noun is poory pot:
			say "'Whoah! That stuff is too crazy for me,' mutters Fritz.'" instead;
		say "You look every which way to the Stool Toad, then put your finger to your lips as you hand Fritz the packet. He conceals the stash and hands you a coin back--a dreadful penny. Proper payment for the cheap stuff. 'Dude! Once I find my lighter I totally won't hog off the high[activation of hoth] from you.'";
		increment the score;
		now wacker weed is in lalaland;
		now player has dreadful penny instead;

check giving drinkable to:
	if second noun is punch sucker:
		say "He might be insulted if you give it back." instead;
	if second noun is lily:
		unless lily-hi is talked-thru or lily is babbled-out:
			say "Lily ignores your offer. Perhaps if you talked to her first, she might be more receptive." instead;
		say "Lily looks outraged. 'This?! Are you trying to make me boring like you?! HONESTLY! After all the advice I gave you!' She takes your drink and pours it in your face before running off.";
		wfak;
		now noun is in lalaland;
		activate-drink-check;
		chase-lily instead;
	say "This is a BUG. You shouldn't be able to carry liquor out of the Soda Club." instead;

section giving items in intro

check giving face of loss to:
	say "You get the sense pity won't get you very far, here." instead;

check giving bad face to:
	say "[if stared-idol is true]You already gave it to the idol, which seemed to deserve it. Maybe the [bad-guy] deserved it more, but you probably can't[else]You'll pull the bad face out when you need to[end if]." instead;

check giving gesture token to:
	if second noun is weasel:
		now token is in lalaland;
		now player has the pocket pick;
		say "He tucks away the token with a sniff. 'Well, it's not much--but, very well, I'll let you in my work study program. I won't even charge interest. Have this pocket pick. It'll help you DIG to find stuff. You can try it here, with the poor dirt!'" instead;
	if second noun is mush:
		say "'Pfft. Petty bribery. I need forms. Signed forms.'" instead;
	if second noun is guy sweet:
		say "'No way! These games are free. And if I charged, it'd be more than THAT.'" instead;

check giving burden to:
	if second noun is mush:
		if burden-signed is true:
			say "With a horrible SCHLURP, the mouth mush vacuums the signed burden away from you. You hear digestive noises, then a burp, and an 'Ah!'[paragraph break]'That'll do. Okay, you stupid arch, stay put. And YOU--wait a few seconds before walking through. I'm just as alive as you are.' You're too stunned to step right away, and after the mush burbles into plain ground, you take a few seconds to make sure the Rogue Arch is motionless.";
			now burden is in lalaland;
			now mouth mush is in lalaland;
			the rule succeeds;
		say "'It's not properly signed! And it's not officially a proof [']til it is!'" instead;
	if second noun is weasel:
		if burden-signed is true:
			say "'That's my signature. Don't wear it out.'" instead;
		unless weasel-baiter is talked-thru or weasel is babbled-out:
			say "'Oh no! You obviously need a little help being more social, but you haven't listened to me enough yet. That'll help. Totally.'" instead;
		say "The weasel makes a big show about how it would normally charge for this sort of thing, but then, signing for you means it'll feel less guilty rejecting an actual charity since it already did something for someone. It makes you sign a disclaimer in turn, absolving it if you do anything dumb. 'Ain't I a welfare animal[activation of animal welfare]?'[paragraph break]Well, the proof is signed now.";
		now burden-signed is true instead;

section giving items from surface

check giving pick to:
	if second noun is mouth mush:
		say "'Thanks, but I floss regularly.'" instead;
	if second noun is weasel:
		say "'No! It's yours now! I'm not strong enough for manual labor, anyway. But you are.' He grins brightly." instead;

section giving items from outskirts

check giving the condition mint to:
	if second noun is volatile sal:
		say "'Hm, if you had one like three feet cubed, it'd make the room smell nicer. But you don't.' He pushes you away before you can ask if he means three on each side or three total." instead;
	if second noun is buddy best:
		say "'Look, I know from dinner mints. I steal [']em all the time when I go out to eat. I deserve to. And that's a pretty lame dinner mint.'" instead;
	if second noun is art or second noun is phil:
		say "He sniffs. 'I'm sure it's perfectly tasty for SOME people.'" instead;
	if second noun is language machine:
		try inserting mint into machine instead;
	if second noun is a bro:
		say "'Mmm. That might help me feel a bit better. But not for long enough. I...well, save it for someone who'd appreciate its taste.'";
	if second noun is not a client:
		say "Your offer is declined. Perhaps you need to find someone who has just finished a meal." instead;
	if finger index is not examined:
		say "The [j-co] seem nasty enough, you don't want to share even a mint with any of them. Maybe if you found some way to empathize with them." instead;
	choose row with jerky-guy of noun in table of fingerings;
	if suspect entry is 1:
		say "[noun] is a bit too nervous around you, as you already figured his secret." instead;
	say "[noun] accepts your offer gratefully, and you discuss the list with him. 'Oh dear,' he says, 'I must be [clue-letter].'[paragraph break]You assure him his secret is safe with you.";
	now suspect entry is 2;
	the rule succeeds;

check giving minimum bear to (this is the fun stuff if you give the bear to someone else rule) :
	if second noun is Stool Toad:
		say "'DO I LOOK LIKE A SOFTIE?'" instead;
	if second noun is Fritz the On:
		say "'Dude! Minimum Bear!' he says, snatching it from you. 'I--I gotta give you something to thank you.' And he does. 'Here's a boo tickety I got for, like, not minding right. I've got so many, I won't miss it.'[paragraph break]";
		now Fritz has minimum bear;
		if howdy boy is in lalaland:
			say "Fritz starts mumbling about the generosity of someone coming back to do nice things for the sake of being nice and strts complaining enough about how people who don't do this sort of thing that you wish you hadn't." instead;
		if your-tix >= 4:
			say "Before you can decline Fritz's offer because you have too many already, he begins mumbling something about a revolution of the oppressed. It's enough to alert the Stool Toad.";
		if your-tix is 3:
			say "'Whoah, dude! You have almost as many ticketies as me!' Fritz blurts, before you can shush him.";
		get-ticketed "giving Fritz his dumb bear he keeps losing";
		the rule succeeds;
	if second noun is howdy boy:
		say "A momentary expression of rage crosses his face. 'Is this some sort of joke? You'd have to be whacked out to like that.'" instead;
	if second noun is lily:
		say "'Aww. That's so sweet. Or it would've been if I was still eight.'" instead;
	if second noun is a bro: [note that this *is* possible if you perform other lawbreaking tasks]
		say "He gazes at it wistfully. 'No, I'm too old. I better be.'" instead;

check giving tickety to:
	if second noun is Fritz:
		say "'No way, dude. I already have too many[unless fritz has minimum bear]. But I can give you one if you like[else]. Keep the one I gave you[end if].'" instead;
	if second noun is howdy boy:
		say "'Not bad. But you still need [4 - your-tix in words] more.'" instead;
	if second noun is Lily:
		say "She is not impressed by your attempts to be a Bad Boy." instead;
	if second noun is Punch Sucker:
		say "[one of]A sardonic laugh. 'Tough customer, eh? We better not give you the REAL stuff, then!'[or]He ignores you the second time.[stopping]" instead;
	if second noun is stool toad:
		say "You consider it, but it'd be embarrassing to get another tickety. Or not even be important enough for one." instead;

check giving the trail paper to:
	if second noun is Fritz:
		say "'That's not the kind of trips I go in for, dude.'" instead;
	if second noun is howdy boy:
		now trail paper is in lalaland;
		choose row with response of howdy-west in table of howdy boy talks;
		now enabled entry is 0;
		howdy-sug;
		say "'Eh, you've done enough. Here, I'll shred the evidence. So you don't get caught later. Say, after all that goofing around, you might be hungry. Look around in Meal Square. There's some food that'll fix you quick.'";
		unlock-verb "figure";
		now howdy boy is in lalaland;
		the rule succeeds;
	if second noun is Lily:
		say "She shrugs and mentions she's been better places." instead;
	if second noun is Punch Sucker:
		say "She is unimpressed with your attempt at being a Bad Boy." instead;
	if second noun is Stool Toad:
		say "He might put two and two together and arrest you." instead;

check giving dreadful penny to:
	if second noun is labor child:
		say "That's small stuff for him. He'd probably rather be doing business." instead;
	if second noun is an enforcer:
		say "'Such blatant bribery! And small thinking, too.'" instead;
	if second noun is faith or second noun is grace:
		say "'We need no monetary donations. Big or small. The googly bowl [if fourth-blossom is in lalaland]must be[else]is[end if] healed, and that is most important.'" instead;
	if second noun is pusher penn:
		now player has poory pot;
		now penny is in lalaland;
		say "'Most excellent! It's not the profit so much as the trust. Now, you look like you haven't tried the good herb before. No offense. So let's start you with the...' he sniffs, 'aromatic stuff. It's poor-y pot, but it'll do. Seller assumes no liability if user is too wussy to keep smoke in lungs for effective amount of time, yada, yada.' You try to say you weren't intending to smoke it, anyway.";
		increment the score;
		the rule succeeds;

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
	say "It's far too tacky for anyone to use. You probably just want to TALK to it to get it going." instead;

check giving mind of peace to:
	if second noun is Brother Blood:
		now mind of peace is in lalaland;
		now brother blood is in lalaland;
		say "Brother Blood takes the mind and gazes at it from all different angles He smiles. 'Yeah...yeah. Some people are just jerks. Nothing you can do to brush [']em off but brush [']em off. I mean, I knew that, but I KNOW it now.'[paragraph break]'Thank you!' he says, squeezing your arm a bit too hard. 'Oops, sorry, let's try that again.' The other arm works better. 'I'm--I'm not just good for snarling and yelling at people and pushing them around, like the [bad-guy] said. I'm more than that. So I guess I need to go find myself or something.'";
		check-left;
		the rule succeeds;

check giving trade of tricks to:
	if second noun is Brother Big:
		now brother big is in lalaland;
		now trade of tricks is in lalaland;
		say "'Wow! All these things I never learned before! Was it really--did people really--yes, they did.' You read through with him, [if trade of tricks is examined]re-[end if]appreciating all the things you'd fallen for and won't again.[paragraph break]'I won't be suckered again.'";
		check-left;
		the rule succeeds;

check giving money seed to:
	if second noun is sly moore:
		say "'I'm not the farmer here. The monkey, though...'" instead;
	if second noun is language machine:
		say "The Standard Bog is no place to grow anything." instead;
	if second noun is Fritz the On:
		say "'Whoah, I don't farm materialistic stuff.'" instead;
	if second noun is faith or second noun is grace:
		say "'Our bowl cannot grow flowers. It can only accept them.'" instead;
	if second noun is business monkey:
		say "The business monkey grabs it eagerly, stuffing it into the soil.";
		wfak;
		say "[line break]As both actions were rather half-[if allow-swears is true]assed[else]brained[end if] to say the least, you are completely unsurprised to see, not a full blossom, but a fourth of one spring up--one quadrant from above, instead of, well, a blossom one-fourth the length or size it should be. He plucks it and offers it to you--very generous, you think, as you accept it. As you do, three others pop up, and he pockets them.";
		increment the score;
		now player has the fourth-blossom;
		now money seed is in lalaland;
		the rule succeeds;

check giving cold contract to:
	if second noun is labor child:
		continue the action;
	if contract-signed is true:
		say "It's already signed. No point." instead;
	if second noun is sly moore:
		say "[if talked-to-sly is true]Sly[else]He[end if] looks confused, but the Business Monkey looks over curiously." instead;
	if second noun is not business monkey:
		say "You can't bring yourself to sucker a person into signing this. Regardless of how nice they may (not) be." instead;

check giving the cold contract to the business monkey:
	if contract-signed is true:
		say "You already did." instead;
	if money seed is not in lalaland:
		say "The monkey looks at it, smiles and shrugs. It seems to trust you, but not enough to sign a contract, yet." instead;
	say "You feel only momentary guilt at having the business monkey sign such a contract. After all, it binds the [i]person[r] to the terms. And is a monkey a person? Corporations, maybe, but monkeys, certainly not, despite any genetic similarities! The monkey eagerly pulls a pen from an inside pocket, then signs and returns the contract.";
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
		say "A tear starts to form in Officer Petty's eye. 'Really? I...well, this definitely isn't bribery! I've always been good at yelling at people who get simple stuff wrong, but I always felt there was more. I could have more complex reasons to put people down. Wow! Now I can be clever and still play the Maybe I Didn't Go to a Fancy School card. Thank...' He looks at the Reasoning Circular again. 'Wait, wait. Maybe you wouldn't have gotten anything out of this invitation anyway. So it's not so generous.' Officer Petty beams at his newfound profundity before shuffling off.";
		increment the score;
		the rule succeeds;
	if second noun is Fritz:
		say "'Whoah! Cosmic!'" instead;

check giving trick hat to:
	if second noun is fool:
		say "Thing is, he KNOWS all the tricks. He just can't use them." instead;
	if second noun is logical psycho or noun is stool toad:
		say "He's awful enough with what he's got." instead;
	if second noun is faith goode or noun is grace goode:
		say "Then they might become a charismatic cult, and that wouldn't be good." instead;
	if second noun is Sly Moore:
		say "[if talked-to-sly is false]You introduce yourself, and he introduces himself as Sly Moore. You give him[else]You give Sly Moore[end if] the trick hat. He adjusts it ten times until it feels right, which is pretty silly, since it's completely circular. But once he wears it, his eyes open. 'Oh...that's how you...and that's how you...'[paragraph break]All the magic tricks he failed at, before, work now.";
		wfak;
		say "[line break]He hands the hat back to you. 'Let's see if I can do things without the hat. Yep, not hard to remember...there we go.' Sly shakes your hand. 'Thanks so much! Oh, hey, here's a gift for you. From a far-off exotic place. A trap-rattle.'[paragraph break]You accept it without thought. Sly excuses himself to brush up on magic tricks.";
		wfak;
		now player has the trap rattle;
		now trick hat is in lalaland;
		increment the score;
		now sly is in lalaland;
		say "[line break]And once you take a step, thought is hard. Rattle, rattle. Well, it looks like Sly Moore was able to play a trick on you without the trick hat. He'll be okay." instead;

check giving wax to:
	ignore the can't give what you haven't got rule;
	if second noun is proof fool or second noun is logical psycho:
		say "[one of]The Logical Psycho begins an extremely boring, but loud, discourse on a poet you never heard of and never want to hear of again. The sort of poet who would not want his work read or discussed quietly[or]No, the poetic wax doesn't belong here[stopping]." instead;
	if second noun is grace goode or second noun is faith goode:
		say "[one of]Faith and Grace begin humming a tune too wonderful to remember to remember. You feel refreshed after hearing it, but you can't remember why[or]You feel greedy, for some reason, giving [second noun] the Poetic Wax. But you don't know why[stopping]." instead;
	if second noun is Stool Toad:
		say "He booms 'I can't arrest you for slovenliness, young man. But you're well on your way to trouble.'" instead;
	if second noun is Pusher Penn:
		say "[one of]'Yo, yo, hit me with the beatbox!' he cries. 'I gots tales of...' but he tails off before you can get your fists up to your mouth. 'Okay, man. Be wack.'[or]Nah, you funked out the first time.[stopping]" instead;
	if second noun is Buddy Best:
		say "'I'm not some neat freak. But geez, that stuff's just gross.'" instead;
	if second noun is Punch Sucker:
		say "'The Stool Toad would LOVE to find a health violation. Put that away.'" instead;
	if second noun is assassination character:
		say "You can't get near enough to him." instead;
	if second noun is Labor Child:
		say "He squirms. The [i]thought[r] of getting something like that over his practical, getting-ahead clothes!" instead;
	if second noun is Officer Petty:
		say "'You'll have to work a little harder to bribe me. Well, if I [i]could[r] be bribed." instead;
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
	else if second noun is lily:
		say "That would gross her out. Deservedly, but still. Guys would come to her 'rescue' and probably gaffle you or something." instead;

section giving items from east

check giving the trap rattle to: [you can't get the trap rattle until you've gotten past Sly Moore, which means being nice to the machine and also getting the wax and vanishing the discussion block]
	if second noun is fritz:
		say "'Not groovy music, man.'" instead;
	if second noun is grace goode:
		say "'That is too noisy for here.'" instead;
	if second noun is labor child:
		say "'That's for BABIES.'" instead;
	if second noun is logical psycho:
		say "He recoils in fear for a second, then booms 'WHY WOULD I WANT THAT.' It's not really a question." instead;
	if second noun is proof fool:
		say "The Logical Psycho continues his abuse. At first the Proof Fool seems to take it, but then--rattle, rattle. It distracts the Psycho enough, the Proof Fool finds his voice. Animated, he shows up every hole in the Psycho's seductive but wrong arguments. He begins hitting the Psycho on the head with the trap rattle until the Psycho runs out.";
		wfak;
		say "[line break]Very impressive! You learned so much from the Fool. He gestures to your trick hat, then his head. You hand it over. The hat, silly.";
		wfak;
		say "[line break]The fool begins to write. And write. He hands you the first page--and wow! All the clever life hacks you learn just from the introduction! It's too much, though. You fall asleep as your mind processes it all.";
		wfak;
		say "[line break]When you wake up, the fool has written a small, but fully bound book. He stuffs it in the Trick Hat, shakes it up, and out emerges a xerox copy! He hands it to you and shakes your hand. THE TRADE OF TRICKS, it's called. Then he retreats to his private quarters.";
		now proof fool is in lalaland;
		now psycho is in lalaland;
		now player has trade of tricks;
		increment the score instead;
	if second noun is dutch or second noun is turk:
		say "They're making enough hoopla as-is." instead;
	if second noun is pusher penn:
		say "'You wanna alert the COPS?'" instead;
	if second noun is volatile sal:
		say "'Oh, great. Noise AND smell!'" instead;
	if second noun is a bro:
		say "[second noun] stares blankly." instead;

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
	say "They don't seem to appreciate that." instead;

section giving items from below

check giving legend of stuff to:
	say "The Legend of Stuff feels stuck to you." instead;

check giving crocked half to:
	say "[if thoughts idol is in lalaland]It's completely useless now[else]Probably even more useless for them than you[end if]." instead;

chapter person based

[these kick in before giving X to Y, but it's a smaller section so I put them here.]

check giving to Brother Big:
	if noun is poetic wax:
		say "'I am too clumsy to write poetry.'" instead;
	if noun is Trick Hat:
		say "It doesn't even close to fit him. Too bad! Anyway, he could maybe use some real education and not just a magic boost." instead;
	if noun is Mind of Peace:
		say "'I need education, not peace. However, that may be perfect for Brother Blood.'" instead;
	if noun is Relief Light:
		say "'I need specific relief from my own lack of knowledge. However, that may be perfect for Brother Soul.'" instead;

check giving to Brother Soul:
	if noun is poetic wax:
		say "'If I were cheerier, that might help me write decent poetry. But alas, I am not, yet.'" instead;
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is mind of peace:
		say "'That would be perfect for Brother Blood. But any peace I have would be temporary. I would still need relief.'" instead;

check giving to Brother Blood:
	if noun is poetic wax:
		say "'I am scared of what I might write.'" instead;
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is relief light:
		say "'That would be perfect for Brother Soul. But it might only give me temporary relief from my violent worries.'" instead;

chapter big one and default

[this is a catch-all]
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
	if second noun is sucker:
		say "'Thanks, but no thanks. I do okay enough with tips.'" instead;
	if second noun is Assassination Character:
		say "'Ha!' he says. 'If I took that, you'd catch me. Nice try!'" instead;
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

check giving (this is the default fall-through giving rule) :
	if second noun is not a person:
		say "You should probably GIVE stuff to people. For inanimate objects, try PUT X ON/IN Y." instead;
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
		say "The hatch above." instead;
	if player is in idiot village and player has bad face:
		say "You can exit to the west, and you might've, earlier, but--you may want to poke around Idiot Village in even some crazy diagonal directions." instead;
	if player is in service community:
		say "You can go pretty much any which way, but you sense that there's only one right way out." instead;
	if mrlp is endings:
		say "It looks like you have a small puzzle on how to get out of here." instead;
	repeat with G running through directions:
		if G is viable:
			now got-one is true;
			say "Going [G], there is [if room G of location of player is visited][the room G of location of player][else]somewhere you haven't been[end if].";
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
	say "A hollow voice booms '[one of]Disaster spelling[activation of spelling disaster][or]Obvious, Captain[activation of captain obvious][or]Nonsense? No[activation of nonsense no][or]Errors of comedy[activation of comedy of errors][cycling]!'";
	the rule succeeds;

chapter diging

diging is an action applying to one thing.

understand the command "dig" as something new.

understand "dig [something]" as diging.
understand "dig" as diging.

does the player mean diging the poor dirt: it is likely.
does the player mean diging the earth of scum: it is likely.
does the player mean diging the mouth mush: it is likely.
does the player mean diging the t-surf when mouth mush is in lalaland: it is likely.

dirt-dug is a truth state that varies.

rule for supplying a missing noun when diging:
	if player does not have pocket pick:
		say "Nothing to dig with. You try to dig things generally, but it doesn't work[if player is in down ground]. Not even with Fritz around[end if]." instead;
	if player is in garden:
		now the noun is poor dirt;
	else if player is in tunnel:
		if earth of scum is in tunnel:
			now noun is scum;
		else:
			now noun is flower wall;
	else if player is in surface:
		if mush is in surface:
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
			say "'Enough, man[activation of enough man]!' says the Weasel, leaving you feeling not man enough." instead;
		say "'Ah, the art of work[activation of work of art]!' the Weasel says as you begin. He throws on a few more aphorisms about exercise and experience and advice that, well, motivate you not to take breaks. 'You've paid off your debt now.'";
		now dirt-dug is true;
		the rule succeeds;
	if noun is mouth mush:
		say "[one of]Before you can strike, the mouth mush coughs so forcefully, it blows you back. While its breath is surprisingly fresh, it's pretty clear you can't use the pick as a weapon.[or]The mouth mush can defend itself well enough.[stopping]" instead;
	if noun is arch:
		say "It's too big for the pick to make a dent." instead;
	if noun is flower wall:
		say "It's too pretty to damage. Plus it might collapse." instead;
	if noun is earth of scum:
		now player has the proof of burden;
		choose row with response of weasel-sign in table of weasel talk;
		now enabled entry is 1;
		now earth of scum is in lalaland;
		set the pronoun it to proof of burden;
		now pocket pick is in lalaland;
		choose row with response of weasel-pick-oops in table of weasel talk;
		now permit entry is 1;
		choose row with response of weasel-pick-hey in table of weasel talk;
		now permit entry is 1;
		say "With your pocket pick, the work is steady and clean, if arduous. Beneath the earth of scum, you hit something which snaps your pocket pick in two. It's a thin plaque. But not just any plaque: a PROOF OF BURDEN. You wipe it off and pick it up, then you bury the pocket pick, which is not only broken but also rusted." instead;
	say "That's not soft enough." instead;
	the rule succeeds.

chapter explaining

explaining is an action applying to one visible thing.

understand the command "explain" as something new.
understand the command "xp" as something new.

understand the command "explain [any thing]" as something new.
understand the command "xp [any thing]" as something new.

understand "explain [any explainable thing]" as explaining.
understand "xp [any explainable thing]" as explaining.

expl-hint is a truth state that varies.

told-xpoff is a truth state that varies;

carry out explaining:
	if debug-state is true:
		now all rooms are visited;
	if accel-ending:
		say "Hmph. You don't want explanations. You put first things first, now, and you just need to get through." instead;
	let found-yet be false;
	if noun is not explainable and noun is not a room:
		say "That doesn't need any special explanation. I think/hope." instead;
	if noun is an exp-thing listed in the table of explanations:
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
	choose row with exp-thing of noun in table of explanations;
	if there is an exp-anno entry:
		if anno-allow is false:
			if expl-hint is false:
				now expl-hint is true;
				say "[line break][i][bracket]NOTE: [if ever-anno is true]typing ANNO and explaining again will let you see more details notes on this item and others[else]once you finish the game, you'll get a command that will annotate this more fully, beyond the basics[end if].[close bracket][r][line break]";
			the rule succeeds;
		say "[exp-anno entry]";
	the rule succeeds.

does the player mean explaining the player when debug-state is true: it is likely;

does the player mean explaining the location of the player when debug-state is false: it is likely;

carry out explaining the player:
	if debug-state is true:
		if out mist is unvisited or airy station is unvisited:
			now all rooms are visited;
		let count be 0;
		repeat with Q running through explainable things:
			if Q is not an exp-thing listed in table of explanations:
				increment count;
				say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) needs an explanation.";
		if count is 0:
			say "Yay! No unexplained things.";
		now count is 0;
		repeat with Q running through rooms not in meta-rooms:
			if Q is not a room-to-exp listed in table of room explanations:
				increment count;
				say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) needs an explanation.";
			else:
				unless there is an exp-text corresponding to a room-to-exp of Q in table of room explanations:
					increment count;
					say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) is in the table but needs an explanation.";
		if count is 0:
			say "Yay! No unexplained rooms.";
		unless the player's command includes "me":
			the rule succeeds;

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
	if x is in conceptville and debug-state is true, decide yes; [can it ever be in play? In debug, we need to know]
	if x is in lalaland, decide yes;
	if x is part of towers of hanoi or x is part of broke flat or x is part of games counter or x is games counter or x is games, decide no;
	if x is t-surf, decide no;
	if x is in pressure pier:
		if x is water-scen or x is stall-scen, decide no;
	if x is in disposed well:
		if x is scen-home or x is scen-church, decide no;
	if x is gen-brush or x is hole, decide no;
	if x is nametag or x is bar-scen or x is writing, decide no;
	if player carries x, decide yes;
	if x is Baiter Master, decide yes;
	if x is not off-stage:
		let mrlx be map region of location of x;
		if mrlx is Dream Sequence, decide no;
	if location of x is visited, decide yes;
	decide no;

understand "explain [text]" as a mistake ("You've come across nothing like that, yet. Or perhaps it is way in the past by now.")

after explaining out puzzle: [just below, the dots explanation asks a question, if you want it spoiled]
	if the player consents:
		say "[one of][or]Oh no! Forgot already? [stopping]From the lower right, go up-left two, right 3, down-left 3, up 3. It's part of 'outside the box' thinking. But you can also roll a paper into a cylinder so one line goes through, or you can assume the dots have height and draw three gently sloping lines back and forth.";
	else:
		say "Okay."

table of explanations [toe]
exp-thing	exp-text	exp-anno
face of loss	"Loss of face means humiliation or loss of respect. A face of loss isn't a real term, but it probably means you're just sad."
out puzzle	"These aren't a pun, but it's something mathy people see a lot of, and motivational speakers tend to abuse it. If you'd like the solution to the four lines to draw to connect all the points, and even other smart-aleck answers, say yes." [note a non-person must come first or Inform thinks it's a thing]
the chess board	"Despite being a really good chess player, this always fooled me. I started with a queen in the corner as a kid and got run around, but then as an adult I recognized the virtue of going for an easy solution and seeing why it didn't work. Restricting the center 16 squares helped a lot--by sheer number, that's 21/23 each queen touches, not 25/27. Also, I didn't understand symmetry arguments e.g. it's useful to see if we can have a queen 2 from any corner, or one 3 from a corner. It's important not to think of this as 'laziness' if we can start building general principles or eliminate enough cases."
the match sticks	"I've always enjoyed match stick problems and how some just don't seem likely. While the general trick if not too many are moved is to shift the original picture onto the new one, somehow, there are creative ones with many shifts."
Nim	"Nim was always the toughest to prove, and my 8th-grade self wiped out in Beyond Zork and I had to watch the trees for hints. Once I learned about Strong Induction, the proof made sense. Though I was still impressed anyone would come up with it."
Towers of Hanoi	"ToH is a basic computer science problem, and I remember someone I respected raving how hard it was, and being disappointed how easy the recursive solution was: N to peg X = n-1 to peg Y, bottom to peg X, n-1 to peg Z. That said, it's just awful in practice."
river boat	"I remember being fooled by the river boat as a kid and then realizing the moves were forced. I was glad to find some variations and even make a decent one in my experimental game Turn Around for the Apollo 18 tribute. It's not big on story, but I like the puzzles and tricks."
necklace	"The seven-link necklace really only has three possibilities: center, next to center, and next to edge, the edge being clearly silly. That said, I felt clever being able to work out the two-link problem on my own way back when, so I put it here."
Rubik's Cube	"The Rubik's Cube is always something I was supposed to be good at. My sister three years older than me bought a solving book I figured I'd be old enough to look at in three years. I never did. Not til I was an adult did I see the methods, and I was surprised how piecemeal and orderly it was. I also remember being very very jealous of Will Smith solving it in an episode of Fresh Prince of Bel Air."
logic puzzles	"I remember marking up books of logic puzzles but thinking they could never ever be practical. I remember having a grease pen over clear plastic so the books could be reused, but I also remember the patterns geting a bit tedious. It wasn't until someone showed me a sample LSAT years later that I thought, really, these are the same thing. Or it's the same process of elimination. Suddenly lawyers seemed less intimidating."
Alec Smart	"A smart alec is someone who always has a clever quip."
Guy Sweet	"Guy Sweet is more of a candy-[a-word] than a sweet guy, but 'sweet guy' is such a terrible compliment as-is. To yourself or others." [smart street]
Game Shell	"A shell game is where an operator and possibly an assistant rig a game so that mugs think it's an easy win, but they can't. The most popular one is when they hide a bean under a hollowed shell and shift them around."	"The game shell is a shell game of its own. No matter how much you solve, you won't impress Guy Sweet, and you won't--well--figure the real puzzles you want to, beyond logic etc."
Broke Flat	"Flat Broke means out of money."	"This was originally a location until I discovered A Round Lounge."
A Round Lounge	"To lounge around is to do nothing--the opposite of what you want."
Plan Hatch	"To hatch a plan is to figure a way to do something."
gesture token	"A token gesture is something done as a bare minimum of acknowledgement."
round screw	"To screw around is to do silly unproductive stuff." [a round lounge]
round stick	"To stick around is to move nowhere."
off tee	"To tee off is to yell or punch out at someone."
person chair	"A chairperson is someone in charge of things."
Mouth Mush	"A mush-mouth is someone who talks unclearly or uses weak words." [tension surface]
Rogue Arch	"An arch-rogue is a big bad guy, obviously inappropriate for early in the story."
Word Weasel	"A weasel word is something that seems to mean more than it should." [variety garden]
pocket pick	"A pickpocket is a thief."
proof of burden	"The burden of proof means: you need to come up with evidence to prove your point."
Absence of Leaves	"Leaves of absence means taking time off."
off brush	"To brush off is to ignore. It's more ignoring someone's ideas than ignoring them fully."
back brush	"To brush back is to repel someone or keep them out."
aside brush	"To brush aside is to ignore someone as you move past them."
Flower Wall	"A wallflower is someone who doesn't participate socially." [vision tunnel]
Poor Dirt	"Dirt poor means especially not rich."
picture hole	"Seeing the whole picture means you see everything."
earth of scum	"Scum of the earth is the worst possible person."
Howdy Boy	"Boy Howdy is a colloquial expression of surprise." [pressure pier]
Saver Screen	"A screen saver is often an amusing little graphic, animated or otherwise, on a computer that's been idle."
boo tickety	"Tickety-boo means okay, all right, etc."
trail paper	"A paper trail is evidence in white-collar crimes. People often have to piece it together."
Howdy Boy	"Boy Howdy is a colloquial expression of surprise."
Tray A	"Just a tray, contrasted with Tray B." [meal square]
Tray B	"Eating anything on it may betray who you really are."
cutter cookie	"Cookie-cutter means predictable and formulaic."
greater cheese	"A cheese grater chops up cheese. Also, you do become a bit of a grater if you eat it."
Off Cheese	"To cheese someone off is to annoy them."
gagging lolly	"Lollygagging is waiting around."
condition mint	"Mint condition is brand new."
iron waffle	"A waffle iron is what you put batter in to make a waffle. But a waffle is also what you use when you don't know what to say. An iron waffle, then, would be something to say when you don't know what to say--but it is hard to take down."
picture of a dozen bakers	"A baker's dozen is thirteen, thus counting for the illusion."
warmer bench	"A bench warmer is someone who doesn't get into the action, especially in a sports game." [down ground]
Fritz the On	"On the fritz means on the blink."
sleeper cell	"A group of people who blen into a community until they can commit an act of terrorism."
hoth	"High on the hog means living wealthily. To hog the high would be if Fritz didn't share his, um, stuff."
dreadful penny	"A penny dreadful is a trashy novel."
Stool Toad	"A toadstool is a mushroom." [joint strip]
Pigeon Stool	"A stool pigeon is someone who tattles."
Minimum Bear	"Bare minimum is the very least you need to do to get by."
haha brew	"Brouhaha is a commotion or noise." [soda club]
cooler wine	"A wine cooler is very low in alcohol content."
Liver lily	"Lily-liver means coward."
Rehearsal Dress	"A dress rehearsal is the final staging of the play before the audience sees it."
Punch Sucker	"A sucker punch is hitting someone when they aren't looking."
fly bar	"A barfly is someone who goes around to bars and gets drunk."
Dandy Jim	"Jim Dandy is something excellent." [jerk circle]
Silly Boris	"Bore us silly."
Wash White	"To whitewash is to wipe clean."
Warner Dyer	"A dire warner has a message for you to keep away."
Warm Luke	"Lukewarm is not really warm."
Paul Kast	"To cast a pall is to give an air of unhappiness."
Cain Reyes	"To raise Cain is to be loud."
Quiz Pop	"A pop quiz is when a teacher gives an unannounced quiz on materials."
jerks	"Pick one by name to see details."
Assassination Character	"Character assassination is the act of tearing someone down." [chipper wood]
chase paper	"A paper chase is excessive paperwork. In this case, work not strictly needed to reach the Assassination Character."
Insanity Terminal	"Terminal insanity is having no chance to regain sanity." [the belt below]
a bad face	"It will help you face a bad...something."
note crib	"To crib notes is to copy from someone who was at a lecture." [bottom rock]
legend of stuff	"The Stuff of Legend means a book about great tales of yore, as opposed to the scribble-hint-book you get."
crocked half	"Half-crocked means drunk."
Logical Psycho	"Psychological, e.g. in the mind." [truth home]
Proof Fool	"Being fool-proof means you aren't suckered by anything."
Trade of Tricks	"Tricks of the Trade are things that outsiders to a specialty probably don't know that are a bit out of the range of common sense."
fund hedge	"A hedge fund is for super rich people to get even richer." [scheme pyramid]
money seed	"Seed money helps an investment."
Labor Child	"Child labor is about putting children to tough manual labor."
Deal Clothes	"To close the deal means to agree to terms."
Cold contract	"To contract a cold is to get sick. Also, the contract is pretty cold-blooded."
Sound Safe	"Safe, sound means being out of trouble. Also, the safe isn't very sound, as it's easy to open." [accountable hold]
Finger Index	"The index finger is the one next to your thumb. Also, to finger someone means to point them out."
yards hole	"The whole nine yards means everything." [disposed well]
Story Fish	"A fish story is a long winding story."
Googly bowl	"To bowl a googly is to throw someone for a loop." [classic cult]
Faith Goode	"Good faith."
Grace Goode	"Good grace."
blossoms	"Now that the blossoms are in place, well, it'd be mean to say a blossom is 'some blah.' Oops."
mind of peace	"Peace of mind means being able to think."
Officer Petty	"A petty officer is actually reasonably far up in the hierarchy, the equivalent of a sergeant." [judgment pass]
Intuition Counter	"Counterintuition means the reverse of what you'd expect."
Business Monkey	"Monkey business is general silliness." [idiot village]
Ability Suit	"Suitability means appropriateness. And the suit is not appropriate for the monkey."
Sly Moore	"More sly = slyer = cleverer."
fourth-blossom	"To blossom fourth is to grow."
Thoughts Idol	"Idle thoughts, e.g., a wandering mind, are what it purports to oppose."
Trap Rattle	"A rattle trap is a cheap car."
Candidate Dummy	"A dummy candidate is one who is there to give the illusion of dissent or choice, or one who siphons off votes from the chosen opponent. The person may, in fact, be quite clever."
Uncle Dutch	"A Dutch Uncle gives useful advice." [speaking plain] [??test XP BUSINESS SHOW]
Turk Young	"A Young Turk is a brave rebel."
Fright Stage	"Stage fright is being scared to get out in front of a crowd."
Volatile Sal	"Sal volatile is given to wake up unconscious people with its smell." [temper keep]
Spleen Vent	"To vent one's spleen is to let our your anger."
relief light	"Light relief would be a silly joke."
Drug Gateway	"A gateway drug leads you to bigger drugs, but here, the gateway may be blocking you from them." [walker street]
Mistake Grave	"A grave mistake is a very bad mistake indeed."
long string	"To string along someone is to keep them trying or asking for more."
Harmonic Phil	"Many orchestras bill themselves as philharmonic. I suppose they could be anti-harmonic, but an Auntie character felt a bit stereotyped, and Auntie feels a bit too charged." [discussion block]
Art Fine	"Why, fine art, of course. Highfalutin['] stuff, not easy to understand."
Poetic Wax	"To wax poetic is to, well, rhapsodize with poems or song or whatever. It's slightly less gross than wax."
Song Torch	"A Torch Song is about looking back on a love you can't quite let go of. The Song Torch is more cynical than that, being a bit rougher on its subjects, and, well, actually torching them."
the Book Bank	"A bankbook records numbers and is very un-literary."
Pusher Penn	"A pen pusher is someone working at a boring job." [pot chamber]
wacker weed	"A weed whacker is the slang for a gardening tool to cut weeds."
Poory Pot	"Potpourri, which smells good. Of course, I've read about pipe and cigar snobs who babble on about aromas and such, and apparently there are marijuana snobs too in this progressive time! Perhaps there always were."
Language Machine	"Machine Language is very low-level, unreadable (without training) code of bits. No English or anything." [standard bog]
Trick Hat	"A hat trick, in hockey or soccer, is scoring three times."
Brother Big	"Big Brother is the character from Orwell's 1984." [questions field]
Brother Blood	"A blood brother is someone related by blood or who has sworn an oath of loyalty to someone else."
Brother Soul	"A soul brother is one who has very similar opinions to you."
Buddy Best	"A best buddy is your favorite friend." [court of contempt]
the Reasoning Circular	"Circular Reasoning is, for instance, I'm smart because I'm clever because I'm smart."
a long tag	"To tag along is to follow behind."
Baiter Master	"[if allow-swears is true]Masturbater is someone who--pleasures himself[else]Messiah Complex means someone believes they're the chosen one[end if]." [freak control] [?? break this up]
list bucket	"A bucket list has things to do before you die."
Language Sign	"Sign language is how people communicate with the deaf."
call curtain	"A curtain call is when someone comes back out after lots of applause."
shot screen	"A screenshot is a still frame from a video."
incident miner	"A minor incident is not a big deal, but the incident miner makes a big deal of small things."
Twister Brain	"The opposite of a brain twister, where someone derives a conclusion from a fact, the brain has a set conclusion and twists and weights facts to line up with them."
Witness Eye	"Someone at the scene of the crime."
against rails	"If someone rails against something, they're upset with it."
running start	"A running start means you've gotten started quickly."
worm ring	"A ringworm is a form of parasite." [final final areas]
Return Carriage	"Carriage Return is going back to the start of a new line in a document with text. And you are sort of going back to the start, too."
hammer	"The hammer can be three things[ham-desc]."
lock caps	"I THINK YOU KNOW WHAT CAPS LOCK IS, BUT HERE'S A DEMONSTRATION OF WHAT HAPPENS IF YOU LEAVE IT ON."

table of explanations (continued) [this is stuff referred to in the director's cut area]
exp-thing	exp-text	exp-anno
pen fountain	"A fountain pen is (these days) a typical pen. You don't have to dip it in ink to keep writing. It's less exotic than a pen fountain, of course."
consciousness stream	"Stream of consciousness is a form of writing that relies heavily on inner monologue."
Francis Pope	"Pope Francis is the current pope as of this game's writing."
Flames Fan	"To fan the flames is to keep things going. The Flames Fan just watches them."
Cards of the House	"The house of cards is something that falls down easily."
View of Points	"Points of view are opinions."

table of explanations (continued) [this is stuff referred to tangentially]
exp-thing	exp-text	exp-anno
turn of phrase	"A turn of phrase is clever wording. A phrase of turn is, well, what's at the command prompt, or, any wording."
wait your turn	"This means not to do anything til someone else goes first. But in this case the game wants you to turn your wait into something else."
Buster Ball	"A ball buster is someone who really presses you hard, verbally or physically. Because the groin is the worst place to have pressure." [the 2 bad guys]
Hunter Savage	"A savage hunter is, well, someone with no mercy. Yup, I like the 'dirty' tangential bad guy better, too."
Nonsense No	"No-nonsense means, well, not taking any silliness." [xyzzy snark]
Captain Obvious	"Captain Obvious is someone who always states what's readily apparent. Captain has a sarcastic meaning, here."
Comedy of Errors	"A comedy of errors is so much going wrong it's funny. Errors of comedy would be so much wrong there's nothing to laugh at."
Spelling Disaster	"Disaster spelling is, well, consonants clumped together. Spelling disaster is leading to bad news."
touch base	"To touch base is to get back to someone or return their call, especially if it's been a while. Versus a base touch, base being mean, so it's a bit more creepy."
poke fun	"To poke fun is to make a joke, but poke can mean a lot of things--putter around, meddle, or maybe poke a friend to get their attention."
Games Mind	"Mind games are messing with people's mind with lies or half-truths. A games mind might be more inclined to abstract puzzles." [start of game]
Games Confidence	"Confidence games are where someone gains someone else's trust to rip them off. It can be as simple as a shell game or as complex as an investment scheme. Of course, Alec has confidence with logic games but not much else."
Animal Welfare	"Animal welfare is concern for animals who often can't help themselves. Welfare has a slightly perjorative definition in the US these days, e.g. people on welfare are lazy, or someone giving it is very generous indeed, more than they need to be."
nose picking	"Nose picking is -- not the best habit. A picking nose would be a discerning sense of smell."
work of art	"A work of art is something nice and beautiful. The art of work is--well, the term can be abused to make work seem more exciting than it is."
enough man	"Man enough means being able to stand up for yourself. Okay, it's a bit sexist, but people who say it mean to be annoying. 'Enough, man' just means stop it."
strike a balance	"To strike a balance is to find a satisfactory compromise. A strike can alo mean--well, your balance went on strike, or you'd fall over."
Thought for food	"Food for thought is something to think about."
Tray S	"Stray. In other words, it strayed from Meal Square."
Tray T	"A tea tray. To go with food."
Tray X	"It is an ex-tray."
face off	"An off face probably doesn't look right, but a face off is when you challenge someone, like the game forces you to in the accelerated Tray B endings."
Bowled Over	"Bowled over means unable to deal with things. Over-bold means too confident."
Growing Pains	"Growing pains are temporary setbacks that help you get going. Pain's growing is just a complaint."
Bum Beach	"A beach bum is someone who wanders on the beach. Maybe he lives there in a shack too."
Double Jeopardy	"Double jeopardy is being tried for the same crime twice. Making your jeopardy double is just putting you at twice the risk."
Trust Brain	"A brain trust is a group of people that help make a decision. A trust-brain, though not an English phrase, might mean a mind that can't make its own decisions."
Moral Support	"Moral support is helping someone even if you don't have concrete advice. SUPPORT MORAL is, well, a slogan that pushes people around."
bullfrog	"A bullfrog is not quite a toad. And bull means nonsense. The Stool Toad is probably in no danger of being mistaken for Frog or Toad from Arnold Lobel's nice books."
Total T	"Teetotal means alcohol-free."
Party T	"A tea party is usually non-alcoholic, and people mind their manners. Well, unless it's the political sort, but I won't touch that any further. I probably said too much, already."
Rummy Gin	"Gin Rummy is a card game, generally not the sort associated with wild binge drinking."
Go Rum	"A rum go is an unforeseen unusual experience, as opposed to 'GO' anything which indicates general motivation."
Brother's Keepers	"'Am I my brother's keeper?' is what Cain said after killing Abel. The implication is, why should I care about anyone else? The brothers are blackmailed into caring too much--or not being able to help each other just walk off."
Black Mark	"A black mark is something indicating bad behavior."
Steal This Book	"Steal This Book was a countercultural guide by Abbie Hoffman. Book this steal refers to 'booking' suspects for a transgression, e.g. a parking fine or ticket."
Business Show	"Show business is the act of entertainment, and the business show's is (purportedly) more practical." [?? test this!]
Crisis Energy	"An energy crisis is when a community doesn't have enough electrical power, or oil, or whatever."
shot mug	"The shot mug may look shot, or beaten-up, but mug shots--photographs of apprehended suspects--are generally very unflattering. Hence the flattering portrait of the [bad-guy] on the mug."
Slicker City	"A city slicker is what rural people may call someone more urban. It's also the name of a planned sequel to PC."
Break Jail	"A jailbreak means getting out of jail. Though to break someone is to destroy their spirit."
Admiral Vice	"A vice-(anything) is a next-in-line/assistant to an honorary position, but vice is also a personal failing, big or small."
Complain Cant	"Cant means a tendency towards something, so someone with a complain cant would only say 'can't complain' very ironically." [eternal concepts]
Received Wisdom	"Received wisdom is generally accepted knowledge which is often not true, such as we only use 10% of our brain. Gustave Flaubert wrote a fun book called The Dictionary of Received Wisdom that makes fun of many examples. For instance, a hamlet is always charming."
Power People	"People power was a rallying cry in demonstrations against the authoritarianism of, well, power people."
Something Mean	"Mean something = talk or act with purpose. Something mean = well, nastiness."
Sitting Duck	"A sitting duck is someone just waiting to be taking advantage of. But if you duck sitting, you aren't waiting."
Hard Knock	"A hard knock is physical wear and tear, or being hit hard, versus just knocking at a door."
Cut a Figure	"To cut a figure is to make a strong impression."
Advance Notice	"Advance notice is letting someone know ahead of time."

table of room explanations [tore]
room-to-exp	exp-text
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
Jerk Circle	"A collective groan is when everyone groans at once. A circle jerk is people getting together and stroking each other's egos. Or, well, something else."
Chipper Wood	"A wood chipper puts in logs and spits out small wood chips." [west-ish]
Disposed Well	"To be well disposed is to be agreeable."
Truth Home	"A home truth is an unpleasant fact about oneself."
Bottom Rock	"Rock bottom is the very bottom, usually emotionally more than physically. But in this case, you may be on a bit of a high after solving the terminal's puzzle."
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
	let x be number of rows in table of verb-unlocks;
	choose row x in table of verb-unlocks;
	say "[if found entry is true]: AWAY HAMMER = hammer away = keep trying, HOME HAMMER = hammer home = to make a point forcefully, LOCK HAMMER = hammer lock = a wrestling hold[else] I can't spoil yet[end if]";

chapter xpoffing

xpoffing is an action out of world.

understand the command "xpoff" as something new.

understand "xpoff" as xpoffing when ever-anno is true.

no-basic-anno is a truth state that varies.

carry out xpoffing:
	unless anno-check is true or "anno" is skip-verified:
		say "You may've stumbled on a command you shouldn't be aware of yet. This is meant to be used in conjunction with the ANNO command. So I'm going to reject it until you specifically ANNO." instead;
	now told-xpoff is true;
	now no-basic-anno is whether or not no-basic-anno is true;
	say "Basic explanations now [if no-basic-anno is true]don't [end if]appear with ANNO annotations.";
	the rule succeeds;

chapter noteing

noteflating is an action out of world.

noteing is an action applying to a number.

notetexting is an action applying to one topic.

understand the command "note" as something new.

understand "note [number]" as noteing when anno-allow is true.

understand "note [text]" as notetexting when anno-allow is true.

understand "note" as noteflating when anno-allow is true.

carry out noteflating:
	say "Here is a list of the notes so far:";
	repeat with X running from 1 to cur-anno:
		show-anno X;
	the rule succeeds;

to show-anno (X - a number):
	unless there is an anno-num of X in table of annotations:
		say "Oops, there should be a footnote for that, but there is not. [bug]";
		continue the action;
	choose row with anno-num of X in table of annotations;
	say "[X]. [if anno-loc entry is not lalaland][anno-loc entry][else][exam-thing entry][end if] ([anno-short entry])[line break]";

carry out noteing:
	if the number understood < 1 or the number understood > cur-anno:
		say "You need a number between 1 and [cur-anno]." instead;
	show-anno number understood;

understand "note [text]" as notetexting when anno-allow is true;

carry out notetexting:
	repeat through table of annotations:
		if the topic understood includes anno-short entry:
			say "[anno-num entry]. [if anno-loc entry is not lalaland][anno-loc entry][else][exam-thing entry][end if] ([anno-short entry])[line break]";
			the rule succeeds;
	say "There's no note containing that text. You may wish to try a number (1-[cur-anno]) instead." instead;

chapter verbing

verbing is an action out of world.

understand the command "verb" as something new.
understand the command "verbs" as something new.
understand the command "command" as something new.
understand the command "commands" as something new.

understand "verb" as verbing.
understand "verbs" as verbing.
understand "command" as verbing.
understand "commandss" as verbing.

to say 2da:
	say "[if screen-read is false]--[end if]";

to say equal-line:
	say "[if screen-read is false]==========[end if]";

carry out verbing:
	if mrlp is Dream Sequence:
		say "There aren't too many verbs in the Dream Sequence.";
		say "THINK or WAIT/Z moves the dream, and you can also LOOK. Your 'inventory' is strictly mental.";
		say "You can also WAKE[if caught-sleeping is true], which is the only way to get out now the Stool Toad caught you[end if].";
		the rule succeeds;
	if player is in freak control:
		say "There may be a special command or two you need to get the [bad-guy]'s attention." instead;
	if player is in out mist:
		say "There may be a special command or three you need to manipulate the worm-ring more, well, enterable." instead;
	if player is in airy station:
		say "There may be a special command or three you need to manipulate the hammer into something more powerful." instead;
	say "[one of]The Problems Compound has tried to avoid guess-the-verb situations and keep the parser simple.[line break][or][stopping]Verbs needed in The Problems Compound include:[paragraph break]";
	if player is in smart street:
		say "[2da]PLAY/TRY any of the games in the shell.";
	say "[2da]directions (N, S, E, W, IN, OUT, ENTER something, and occasionally U and D)[line break]";
	say "[2da]OPEN X (no second noun needed)[line break]";
	say "[2da]PUT X ON/IN Y or ATTACH X TO Y. These are usually functionally equivalent.[line break]";
	say "[2da]GT or GO TO lets you go to a room you've been to.[line break]";
	say "[2da]GIVE X TO Y[line break]";
	say "[2da]TALK/T talks to the only other person in the room. TALK TO X is needed if there is more than one.[line break]";
	if know-babble is true:
		say "[2da]BROOK BABBLING lets you talk to someone and skip over a conversation's details[if ever-babbled is true]. It can be shortened to B[sr-space]B, with or without a space[end if].[line break]";
	say "[2da]specific items may mention a verb to use in CAPS, e.g 'You can SHOOT the gun AT something,' but otherwise, prepositions aren't necessary.";
	say "[2da]conversations use numbered options, and you often need to end them before using standard verbs. RECAP shows your options.";
	say "[2da]other standard parser verbs apply, and some may provide alternate solutions, but you should be able to win without them.";
	say "[equal-line]Meta-commands listed below[equal-line][line break]";
	say "[2da]you can also type ABOUT or CREDITS or HISTORY or TECH to see meta-information, and XP/EXPLAIN (any object) gives a brief description. XP with no argument explains the room name.";
	say "[2da]EXITS shows the exits. While these should be displayed in the room text, you can see where they lead if you've been there.";
	say "[2da]HELP/HINT/HINTS/WALKTHROUGH will redirect you to the PDF and HTML hints that come with the game. THINK/SCORE gives very broad, general hinting. WAIT lets you wait.";
	if cur-anno > 0:
		say "[2da]NOTE (number or text) displays a previous note you uncovered." instead;
	if verbs-unlocked:
		say "You've also unlocked some verbs:[line break]";
		repeat through table of vu:
			if found entry is true, say "[2da][descr entry][line break]";
	if in-beta is true:
		list-debug-cmds;
	the rule succeeds;

to decide whether verbs-unlocked: [I could probably check "duck sitting" but best to be thorough]
	repeat through table of vu:
		if found entry is true, decide yes;
	decide no;

to list-debug-cmds:
	say "[line break]DEBUG COMMANDS: ================[line break][2da]J jumps you to the next bit from the Street, Lounge, Surface or Pier.[line break][2da]MONTY toggles every-move actions like listening and smelling. It may be more for programming testing[line break][2da]ACBYE/CTC/CTP gets rid of the Assassination Character and chase paper.[line break][2da]JERK tells you what to do with the jerks.[line break][2da]JGO gets rid of them[line break][2da]BROBYE kicks the Keeper Brothers out.";

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
	say "If you're stuck, the game should come with a brute-force HTML walkthrough, an Invisiclues-style HTML document, and a PDF document with a map followed by move-by-move walkthrough[if bottom rock is visited]. Also, you can go back to Bottom Rock. If that's flaky, please do report a bug at [email][end if][paragraph break]SCORE gives very broad general hinting.[no line break]";

chapter creditsing

creditsing is an action out of world.

understand the command "credits" as something new.

understand "credits" as creditsing.

carry out creditsing:
	say "I was able to bounce technical and non-technical ideas off several other people. Wade Clarke, Marco Innocenti, Hugo Labrande, Juhana Leinonen, Brian Rushton and Matt Weiner offered testing and general encouragement and insight on what was a VERY short deadline given the game's size. An anonymous tester provided other direction.[paragraph break]Robert DeFord, Harry Giles and Steven Watson had ideas for the white paper and direction, as did the Interactive Fiction Faction, a private Google group. They include Hanon Ondricek, Robert Patten, Miguel Garza, Matt Goh, Jim Warrenfeltz and Joseph Geipel.[paragraph break]Jason Lautzenheiser's work on Genstein's Trizbort app (www.trizbort.com) was invaluable for big-picture planning and for adding in ideas I wasn't ready to code. If you are writing a parser game, I recommend it. (Disclaimer: I am a contributor, too.)[paragraph break]Many websites and resources helped me discover silly phrases.";
	say "====IN-COMP THANKS:";
	say "I'd also like to thank non-competitors who alerted me to flaws/bugs in the comp version: Olly Kirk, Paul Lee, Michael Martin, David Welbourn and Al Golden. Competitors offered both praise and criticism which helped add features and polish to the post-comp release.";
	say "====POST-COMP THANKS:";
	say "Thanks to Joey Jones (also in the IFF) for finding lots of fixables present in the comp and post-comp release.[line break]Thanks to Alex Butterfield and Hugo Labrande for our games of code tennis, which is basically, try and do something every other day, or the other guy scores a point. Hugo worked with me more on a 'related project,' but a lot of things I pinged him with were relevant here. I recommend code tennis for anyone who needs motivation.";
	the rule succeeds;

chapter abouting

abouting is an action out of world.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	say "The Problems Compound is meant to be less puzzly than my previous efforts. If you need to see verbs, type VERBS. Though there's no hint command, a walkthrough should be included with the game.";
	say "[line break]TPC is a bit, well, AGT-ish. It's not intended to be a technical marvel, but I hope it takes a funny tack on being overwhelmed. It was inspired by Hulk Handsome's very fun 2012 IFComp entry, In a Manner of Speaking and leans heavily on my 'researching' a website that you can find in TECH.";
	say "[line break]But more importantly, CREDITS lists my testers first, because they've helped make the game less rocky and found bugs that saved me time when I had (yet again) procrastinated.[paragraph break]Also, if you want, HISTORY will contain details about the game's history, and TECH will describe some technical stuff you may find helpful in your own games.";
	say "[line break]One other thing. If you find bugs, send them at [email] or visit the repository for the game at [my-repo]. If you can take a transcript of how it happens, use the TRANSCRIPT command and attach the file. Oh, also, I'm on twitter as @ned_yompus.";
	the rule succeeds;

chapter historying

historying is an action out of world.

understand the command "history" as something new.

understand "history" as historying.

carry out historying:
	say "I originally thought up this game in November of 2013. It had a completely different name, which I like a lot, but it didn't fit. PC went through several other names which sounded good but not good enough. The basic idea behind most room names etc. was unchanged.[paragraph break]I wanted to riff on some facet of language without being as abstract and obscure as Ugly Oafs, or as puzzly as the Stale Tales Slate or Threediopolis. The ideas poured in slowly, often by accident. Sometimes I'd overhear stuff, or I'd read an article or book, and there it was. Other times, I'd see a word I was sure had to work some way.[paragraph break]There were enough ideas that didn't fit my story line that [if you-already-won]will go into Slicker City, the sequel[else]I have a sequel and a name for it too. That name will be reveled in a successful ending[end if].";
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
		say "You don't have anything left to say except hello, good-bye." instead;
	now anything-said-yet is false;

anything-said-yet is a truth state that varies.

after quipping:
	now current quip is talked-thru;
	now anything-said-yet is true;

the basic RQ out of range rule is not listed in any rulebook.

An RQ out of range rule for a number (called max) (this is the redone basic RQ out of range rule): say "[if max is 1]You've only got one choice left, the number 1. Type RECAP to see it, though it's probably just saying good-bye.[else][bracket]Whoah! You'd love to think of something awesome and random and creative, but all you can think of are the choices from 1-[max].  Type RECAP to relist the options.[close bracket][line break][end if]".

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

before doing something when qbc_litany is not table of no conversation:
	if current action is qbc responding with:
		continue the action;
	if qbc_litany is table of legend of stuff talk:
		if current action is examining legend of stuff:
			say "You already are!" instead;
		say "You put the Legend of Stuff away[if noun is legend of stuff or second noun is legend of stuff], perhaps only temporarily[end if].";
		terminate the conversation;
		continue the action;
	d "[the current action], [qbc_litany].";
	if current action is thinking or current action is listening:
		if qbc_litany is table of generic-jerk talk:
			continue the action;
	unless convo-left:
		say "[bracket]NOTE: it looks like you hit an unexpected conversational dead end. I'll kick you out so you can continue the game. Please let me know how this happened at [email] so I can fix it.[close bracket][paragraph break]";
		terminate the conversation;
		continue the action;
	if current action is listening:
		say "Well, you just did, and now it's your turn to respond." instead;
	if current action is smelling:
		say "Others can throw you off with a well-timed sniff, but not vice versa." instead;
	if current action is going:
		if the room noun of location of player is nowhere:
			say "You can't escape the conversation running nowhere! Well, you can't really escape it running anywhere, either. You're not good at slick exits." instead;
		if qbc_litany is table of Punch Sucker talk:
			say "The Punch Sucker, with other customers to serve, is actually glad to be spared hi-bye small talk.";
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
		say "You're already in a conversation." instead;
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
	say "You get distracted, but you've never had the power to break a conversation off. [note-recap]" instead;

to say note-recap:
	say "(NOTE: to see dialog options, type RECAP. Currently you can choose [convo-nums])[line break]";

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

carry out annoing:
	unless anno-check is true or "anno" is skip-verified:
		say "This is the command for annotations, which are usually only for after you win the game. While it has no spoilers, and it can be toggled, it may be a distraction. Are you sure you want to activate annotations?";
		now anno-check is true;
		unless the player consents:
			say "OK. This warning won't appear again." instead;
	now anno-allow is whether or not anno-allow is false;
	now ever-anno is true;
	say "Now annotations are [if anno-allow is true]on[else]off[end if].";
	[showme whether or not anno-allow is true;] [commented this code for later reference. It's handy.]
	the rule succeeds;

cur-anno is a number that varies. cur-anno is usually 0.

section the triggers

after printing the locale description (this is the show annos rule):
	if anno-allow is true:
		let myloc be location of player;
		repeat through table of annotations:
			if myloc is anno-loc entry:
				if anno-num entry is 0:
					increment cur-anno;
					say "([cur-anno]) [anno-long entry][line break]";
					now anno-num entry is cur-anno;
				continue the action;
		if mrlp is rejected rooms:
			ital-say "There should be an annotation for this room, but there isn't.";
	continue the action;

after examining:
	if anno-allow is true:
		if noun is an exam-thing listed in table of annotations:
			choose row with exam-thing of noun in table of annotations;
			if anno-num entry is 0:
				say "([cur-anno]) [anno-long entry]";
				increment cur-anno;
				now anno-num entry is cur-anno;
	continue the action;

section the table

table of annotations [toa]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	Smart Street	"smart"	"This came surprisingly late, but the reverse made total sense. The main point is that Alec may not be street smart, but people often assume he'll wind up somewhere around clever people." [very start]
0	--	A Round Lounge	"lounge"	"This came to me pretty late. I'm never quite sure how to start games. It always seems the best idea comes at the end, and yet on the other hand it's not fully comforting that I know how my story will end. I wanted you to start pretty normally, but move to progressively odder places."
0	--	Tension Surface	"compound"	"I thought of making this the title of the game. But it was probably better to have it clue you to the room names. Anyway, It'd be hard to believe such a big world was part of a compound." [start intro]
0	--	Variety Garden	"garden"	"The title was totally silly until release 2, when I added varieties of brush. Basically, the garden has a lot of variety, but not really quality. Originally there was a Stream of Consciousness and Train of Thought, but these were placeholders. The Word Weasel didn't come until later, but I always liked that phrase. I went through a bunch of vegetables before I found an animal would do just as well."
0	--	Vision Tunnel	"tunnel"	"I'm pleased with the flip here from 'tunnel vision' as the vision tunnel opens you up to the different ways to see things."
0	--	Pressure Pier	"pier"	"This shuffled around a bit until I found someone who was adequate for pressuring you, as opposed to just talking you down. That was the Howdy Boy. And, in fact, he was just 'there' in Sense Common for a while. Early I took a 'best/worst remaining pun' approach to the map, but as I started writing code and sending the game to testers, I realized how it could make more sense." [start outskirts]
0	--	Meal Square	"square"	"This was the Tactics Stall for a while, until I had enough food items for a separate area, and then I didn't have enough time to implement tactical items. I needed a place to put them. 'Sink kitchen' didn't quite work, but eventually I found this. The baker's dozen was my first scenery implemented, and I'm quite pleased at the bad pun. Also, the Gagging Lolly was the first silly-death thing I implemented."
0	--	Down Ground	"jump"	"Some locations didn't make the cut, but they helped me figure out better ones.  However, Down Ground was one of the first and most reliable. It was behind Rejection Retreat, which--well--didn't fit the bill.[paragraph break]You can now JUMP to or from random areas that didn't quite make it. Actually, you could've once you turned on annotation mode. But now you know you can."
0	--	Joint Strip	"strip"	"Sometimes the names just fall into your lap. It's pretty horrible and silly either way, isn't it? I don't smoke pot myself, but I can't resist minor drug humor, and between Reefer Madness and Cheech and Chong, there is a lot of fertile ground out there."
0	--	Soda Club	"club"	"I forget what medieval text I read that made me figure out the Sinister Bar, but that's what it was in release 1. Then one day at the grocery store, I saw club soda, thought--could it be that easy? Having an ironic title for a speakeasy? It was!"
0	--	Tense Past	"past"	"These three rooms fell pretty quickly once I heard 'past tense.' Dreams have often been a source of helplessness for me, with one 'favorite' flavor being me as my younger self knowing what I know now, knowing I'd get cut down for using that knowledge. That snafu has grown amusing over the years, but it wasn't as a teen." [sleepytime rooms]
0	--	Tense Present	"present"	"Of course we've all had dreams about stuff we can't do now, or issues that keep coming up. I'd like to think that my bad dreams, once I confronted them, let me exaggerate things for humor in everday conversation. Still, it's been a developing process."
0	--	Tense Future	"future"	"We all worry about the future and what it will be, and we get it wrong, but that doesn't make it any less scary. I included this once I saw that dreams and fears could be traced into three segments: how you messed up, how you are messing up, and how you won't be able to stop messing up."
0	--	Jerk Circle	"circle"	"The idea of Jerk Circle made me laugh until I realized it might be a bit too icky to see too much. Thus it became part of the swearing-only part of the game once I realized the Groan Collective was an adequate replacement. Of course, when you know the 'other' name is Jerk Circle, there are still connotations. But the image of one person starting to groan encouraging others is very apt. Once I saw how the NPCs could interact, I felt even more amused." [main area]
0	--	Chipper Wood	"wood"	"I got the idea for this when reminded of a certain Coen Brothers movie. The contrast of violence and happiness in the title made me realize it was a better choice than Rage Road." [west-a-ways first]
0	--	Disposed Well	"well"	"This was originally the preserved well, and the Belt Below was below it. There was going to be a Barrel of the Bottom that opened, but it seemed too far-fetched. So I just went with a well where you couldn't quite reach something."
0	--	Classic Cult	"cult"	"Of course, a cult never calls itself a cult these days. It just--emphasizes things society doesn't. Which is seductive, since we all should do it on our own. But whether the thinking is New or Old, it remains. It can be dogma, even if people say it all exciting.[paragraph break]Plus I cringe when someone replies 'That's classic!' to a joke that's a bit too well-worn or even mean-spirited. Oh, a cult classic is a movie with a small but fervent following."
0	--	Truth Home	"home"	"Of course, the truth home has lots of truth--it's just all misused. And I liked the idea of a name that sounds a bit superior but isn't."
0	--	Scheme Pyramid	"pyramid"	"I find pyramid schemes endlessly funny in theory, though their cost is real and sad. They're worse than lotteries."
0	--	Accountable Hold	"hold"	"I'm critical of Big Business and people who think they've done a lot more than they have because they have a good network they don't give much back to. In particular, if someone talks about accountability, it's a sad but safe bet that in a minute they will start blaming less powerful people for things out of their control. There's a certain confidence you need for business, but too often it turns into bluster."
0	--	The Belt Below	"belt"	"I wanted a seedy underbelly. And I got one. I didn't know what it was for, and certainly, it didn't all come together in the initial release. But the room name spurred me to make a puzzle that FELT unfair."
0	--	Bottom Rock	"bottom"	"I forget when the idea of giving you a powerful item if you got abstract puzzles came to me. But I wanted it to be powerful and cleverly named. I wasn't sure where I could put a crib, because I couldn't implement a bedroom, but then I realized it could be just dropped anywhere, to show the Problems Compound is not for babies--or maybe to insinuate that hints are for babies. I mean, for the [bad-guy] to insinuate, not me. I use them a lot, too."
0	--	Judgment Pass	"pass"	"This seemed as good a generic place-you-need-a-puzzle-to-get-by as any. Especially since I wanted solutions to focus around outsmarting instead of violence or pushing someone out of the way." [east-ish]
0	--	Idiot Village	"village"	"Of course, the people here aren't total idiots, even if they are very silly. But I liked the idea of turning 'village idiot' on its head, as well as having a caste of 'outs' who maybe weren't stupid but let themselves be treated that way."
0	--	Service Community	"community"	"I liked the idea of an underclass that needs to rebel, and Idiot Village was good enough for getting the game out there. But then while playing Kingdom of Loathing, which has inspired a lot of my 'jokes,' the Community Service path's name kept pinging me."
0	--	Speaking Plain	"plain"	"The people here do go in for plain speaking, but that doesn't mean it's good speaking. In general, Alec is assaulted by a bunch of people who want to convince him they're wasting their time speaking to him than the other way around. They act like advertisements, to me." [north-ish]
0	--	Temper Keep	"keep"	"This is one of those ideas that came relatively late, but once it did, I had a few adjectives and verbs that tipped me off to a quick puzzle that should be in there."
0	--	Questions Field	"field"	"This was originally the Way of Right, which was sort of close to Freak Control, but then close to release I was searching for other names and this popped up. I liked it better--the three Brothers are asking questions, first of you and then of why they're there and how they could leave--and it seemed less generic. So it stayed."
0	--	Court of Contempt	"court"	"As someone unimpressed and/or intimidated by all the yelling that went on in law-firm shows when I was younger, any sort of court always seemed fearful to me. What would I be doing there? I was shocked when I got my first traffic ticket and went in to protest that it was relatively quiet and orderly. But the image and fears still remain, funnier now."
0	--	Walker Street	"drive"	"Walker Street was Crazy Drive in release 1. But I found the joke of somewhere plain or boring too much to resist, especially after finding 'Walker Street' as a stray annotation to delete in my Trizbort map file. Oh, a streetwalker is, well, someone who trades favors for money. Yes, THAT sort of favor."
0	--	Discussion Block	"block"	"This was the Interest Compound in release 1, but that was too close to the title. The discussions, of course, block any real discussion. The books and songs are purposely bad, but you can't SAY that."
0	--	Standard Bog	"bog"	"This was something entirely different until the end. Something different enough, it might go in a sequel."
0	--	Pot Chamber	"chamber"	"Some room names made me smile with their subtlety. Others, with their utter lack. Since this combines two awkward conversation subjects, guess which it was?"
0	--	Freak Control	"control"	"This was one of those rooms that made me realize I had a game. And I think the false humility in it ties up an important thing: the Baiter claims he's a bit of a dork, but he's like moderate and stuff. Except when he needs to be extreme to win an argument. The for-your-own good of how he went through it adds to the pile."
0	--	Out Mist	"mist"	"I needed a name for a final location, and originally it was the Haves Wood, which didn't quite make sense. It needed to be somewhere shadowy--unclear. Then I overheard someone saying 'Boy, you missed out,' and I wanted to thank them, but they would've thought it was weird. The wordplay is, of course, that you missed out a bit, but the mist is still out of bounds for people in the Compound."
0	--	Airy Station	"station"	"Since stationary means motion and you are leaving, this seems good. I wanted a way for people to say thanks for Alec before he left, as opposed to him just sneaking out."

table of annotations (continued) [toa-views]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	Everything Hold	"hold"	"The obvious pun here is that trying to hold everything physically often makes you hold everything in terms of time. So this seemed apt, but if I put anything in this room, I'd put in a lot, and that'd be way too much trouble to implement."
0	--	Mine Land	"mine"	"I definitely don't want to trivialize the devastating effects of land mines. And from a technical viewpoint, Mine Land would probably have been an empty room. But really, a bunch of people crying 'Mine! Mine!' is destructive in its own way."
0	--	Robbery Highway	"highway"	"Highway robbery being a clear rip-off, I liked the idea of a location made especially for that."
0	--	Space of Waste	"space"	"Like Mine Land, this is one of those areas that don't work well in a game, but all the same--so many spaces are space of waste."
0	--	Clown Class	"class"	"I had an idea of making Clown Class a dead end, or maybe even a separate game, but I couldn't pull it off."
0	--	Shoulder Square	"shoulder"	"I do like the pun shoulder/should, er. They mix well with shoulders tensing thinking what you should do."
0	--	Perilous Siege	"siege"	"The Siege Perilous is where Galahad was allowed to sit. It signified virtue. Of course, many of the antagonists in the Compound think they have virtue, but they don't. Since this room was so general, I didn't see a way to include it in the game proper."
0	--	Expectations Meet	"meet"	"The irony of expectations meet is that if people gather together and discuss their expectations, they never quite meet them."

table of annotations (continued) [toa-rej]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	One Route	"route"	"It was either this or One Square or Way One, at the beginning. But those two dovetailed nicely into a small puzzle."
0	--	Muster Pass	"muster"	"It was a close call between here and Judgment Pass, but only one could pass muster. Err, sorry about that." [begin speculative locations]
0	--	Rage Road	"rage"	"This flip made me giggle immediately, but it was one of those things where I could do better. The flipped meaning wasn't skewed enough. So when I stumbled on Chipper Wood, I decided to change it. That said, even though road rage is serious, coworkers and I riff on it when we're carrying lots of stuff and want pedestrians out of our way.[paragraph break]I also had ideas for a diner called Pizza Road."
0	--	Chicken Free Range	"range"	"The Chicken Free Range is, well, free of everyone. It was replaced by the Speaking Plain and Chipper Wood. As much as I like the idea of rotating two of three names, the problem is that you have six possibilities now, which gets confusing. Plus, free-range chicken may be a bit obscure, though I like the connotation of chicken-free range as 'THOU SHALT NOT FEAR.'"
0	--	Humor Gallows	"gallows"	"This was originally part of the main map, but the joke wasn't universal enough. I like the idea of killing jokes from something that should be funny, the reverse of gallows humor--which draws humor from tragedy or near tragedy. As well as the variety of ways jokes can be killed."
0	--	Tuff Butt Fair	"fair"	"This was one of the first locations I found, and I took it, and I put it in the game. Tough butt/tough but is a good pun, and I have a personal test that if I can picture pundits calling a person 'tough but fair,' that person is a loudmouthed critical jerk. The only problem is, 'fair but tough' isn't really a fair flip. It was replaced by the Interest Compound, which became the Discussion Block, and Judgment Pass.[paragraph break]I originally thought of a lot of contemporary sounding people I could put in here, but they got rejected. Even Francis Pope (who'd be a rather nasty opposite of the Pontiff, whom I respect.) I wanted to keep it abstract and not Talk About Important People. However, for a truly atrocious inside joke, I was tempted to put in a bully named Nelson Graham who beat other kids up for playing games over three years old--or for even TRYING to make their own programming language. I decided agai--oops."
0	--	Ill Falls	"falls"	"This was simply a good pun that might have afforded a play on Ill, which often means beautiful and ugly at the same time."
0	--	Eternal Hope Springs	"springs"	"This was the original place you'd sleep. Then I put the warmer bench, but then I discovered the Joint Strip as perfectly seedy. Since, like Chicken Free Range, this had three substansive words in its name, it didn't quite fit the room aesthetic. But I still liked the name, and it probably catalyzed other ideas before becoming obsolete."
0	--	Brains Beat	"beat"	"I like the image of brainy people walking a beat, talking bout stuff, making someone (figuratively, of course) want to beat their brains in. Them being themselves or the others. Intellectual Conversation in general drives me up the wall."
0	--	Madness March	"madness"	"Unsurprisingly, I thought of this one in March. But I didn't feel it was universal enough. March Madness is a big deal in the US among basketball fans. In fact, even non-basketball fans enter (nominally illegal) betting pools in this 68-game knockout tournament. I was planning to have a bunch of people getting into stupid arguments with someone winning, but I hadn't the heart to implement it."
0	--	Window Bay	"coast"	"I liked the reversal on architecture for a more natural and magical setting."

table of annotations (continued) [toa-badend]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	Hut Ten	"hut"	"This was brought about by all the countless drills I was forced into in Boy Scouts, as well as the fear of possible war with the Russians and me getting drafted. I was also nervous for a few days about the first Iraq War, and what if it lasted [']til I went to college? Fortunately, the US got in and got out quickly, and there were totally no problems at all after that, amirite."
0	--	A Beer Pound	"pound"	"I think there's a chance to be moralistic about alcohol no matter how much you drink. Maybe you are sure you need it after a hard day's work, or people never should've started. I've seen my share of people cutting down others who don't know their limits, including former employees upset with a junior employee they took out drinking and he found it hard to control. It's sad and unfortunate, and I've had my fair share of awkward explanations that, well, I'd be a fool to risk drinking."
0	--	Shape Ship	"ship"	"If you've ever read any novels about rough life on a ship, well, this is just a gimme."
0	--	Criminals' Harbor	"harbor"	"This could have been lumped with Shape Ship, but I liked them both too much."
0	--	Maintenance High	"high"	"One irony I've found about avoiding being high maintenance is that I've often forgotten to do simple things to keep things going. Most of the time that's paying a bill or putting off an eye doctor appointment. But more seriously, it's tough for me to evaluate high maintenance vs. high standards."
0	--	Fight Fair	"fight"	"Of course, there's not a single fair fight here."
0	--	Punishment Capitol	"capitol"	"I'm opposed to capital punishment. And I think the [bad-guy] is, too. Well, until it happens to him. I needed a place for the big crimes, and here it is."
0	--	Camp Concentration	"camp"	"Ever think of something and feel guilty about it after? Yup."
0	--	In-Dignity Heap	"heap"	"This was only put in to make the map 8x8 but I think it's a good one. People with seeming dignity giving pompous morality lectures do heap indignity on others. And some of us take it for our own good."

table of annotations (continued) [toa-items]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	round stick	lalaland	"stick"	"It took a bit of time to find the magic item to cross over. Originally it was the Proof of Burden, but that was too magical, too early. And that might've forced the mechanic on you. I think A Round Stick is a bit subtler."
0	game shell	lalaland	"Shell"	"This was originally a location, and its predecessor was the Gallery Peanut, which got shuffled to Meal Square, then to a potential sequel. But once I moved the Peanut, the Shell became obvious: a place where you could play games and win, but never really win anything valuable. Or you'd lose interest, or confidence."

volume the game itself

book beginning

Beginning is a region.

chapter the player's possessions to start

a face of loss is a thing. The player carries a face of loss. description of face of loss is "There are no mirrors, so you can't see it, but it's hard to change."

a bad face is a thing. description is "You can't see it, but you can [i]feel[r] it has a bit more gravitas and confidence."

part Smart Street

Smart Street is a room in Beginning. "This isn't a busy street[one of], but there's a shell-like structure featuring all manner of odd games[or] though the Game Shell takes a good deal of space[stopping]. While you can leave in any direction, you'd probably get lost quickly.[paragraph break][if Broke Flat is examined]Broke Flat lies[else]The shell seems in much better condition than the flat[end if] a bit further away."

after looking in Smart Street when Guy Sweet is not in Smart Street:
	move Guy Sweet to Smart Street;
	say "A loud, hearty voice from the shell. 'Howdy! I'm Guy Sweet! You look like a fella with a games mind! Why not come over to the Game Shell and have a TALK?'"

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
	if qbc_litany is table of lily talk:
		if anything-said-yet is false:
			say "(shuffles off [if lily-warn is true]even more [end if]embarrassingly and awkwardly)";
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
guy-games	"'They're for people who don't like regular fun social games. Sort of like IQ tests. You look like you'd enjoy them more than most. No offense. Hey, I'm saying you have [g-c].'"
guy-stuck	"'Well, yeah, I used to be kind of a dork. And by kind of a dork I mean really a dork. Probably even worse than you. Hey, I'm showing some serious humility here. I mean, starting at the bottom, as a greeter, until I'm an interesting enough person to join the Problems Compound.'"
guy-advice	"'Hm, well, if I give you too much advice, you won't enjoy solving them. And if I don't give you enough, you'll be kind of mad at me. So I'm doing you a favor, saying just go ahead and PLAY.'"
guy-flat	"'Well, that way is the Problems Compound. If you can figure out some basic stuff, you'll make it to Pressure Pier. Then--oh, the people you'll meet!'"
guy-names	"'I know what you really want to ask. It's not at all about twisting things back around and making them the opposite of what they should mean. It's about SEEING things at every angle. You'll meet people who do. You'll be a bit jealous they can, and that they're that well-adjusted. But if you pay attention, you'll learn. I have. Though I've got a way to go. But I want to learn!'"
guy-problems	"'Well, it's a place where lots of people more social than you--or even me--pose real-life problems. Tough but fair. Lots of real interesting people. Especially the Baiter Master[if allow-swears is false]. Oops. You don't like swears? Okay. Call him the Complex Messiah[else]. AKA the Complex Messiah[end if]. But not [bg]. Even I haven't earned that right yet. Or even to enter Freak Control. It's guarded by a trap where a question mark hooks you, then an exclamation mark clobbers you.' He pauses, and you are about to speak...[wfk]'YEAH. He's really nice once you get to know him, I've heard, it's just, there's too many people might waste his time, or not deserve him or not appreciate him.' Guy stage-whispers. 'OR ALL THREE.'"
guy-mess	"'Oh, the [bad-guy]. He certainly knows what's what, and that's that! A bit of time around him, and you too will know a bit--not as much as he did. But he teaches by example! And if he ribs you a little, that's just his way of caring. Remember, it's up to YOU what you make of his lessons! Some people--they just don't get him. Which is ironic. They're usually the type that claim society doesn't get THEM.'"
guy-bad2	"'[bad-guy-2]. Well, without the [bad-guy]'s snark, [bad-guy-2] would probably be in charge. Then things would get worse. You see, [bad-guy-2] is after our time and money. The [bad-guy] just likes to share a little snark.'"
guy-bye	"'Whatever, dude.' [one of]It's--a bit harsh, you're not sure what you did to deserve that, but probably something[or]It's a bit less grating this time, but still[stopping]."

to say bad-guy:
	say "[if allow-swears is true]Baiter Master[else]Complex Messiah[end if]"

to say bad-guy-2:
	say "[if allow-swears is true]Buster Ball[else]Hunter Savage[end if]";
	now buster ball is in lalaland;
	now hunter savage is in lalaland;

to say bad-guy-2-c:
	say "[if allow-swears is true]BUSTER BALL[else]HUNTER SAVAGE[end if]";
	now buster ball is in lalaland;
	now hunter savage is in lalaland;

to say bg:
	say "[if allow-swears is true]BM[else]CM[end if]"

to say a-word:
	say "[if allow-swears is true]ass[else]***[end if]"

after quipping when qbc_litany is table of guy sweet talk:
	if current quip is guy-flat or current quip is guy-stuck:
		if guy-problems is not talked-thru:
			enable the guy-problems quip;
	if current quip is guy-mess:
		enable the guy-bad2 quip;
	else if current quip is guy-bye:
		check-babble;
		terminate the conversation;

to check-babble:
	if know-babble is true:
		continue the action;
	if qbc_litany is table of gs:
		let tries be 0;
		repeat through table of gs:
			if response entry is talked-thru:
				increment tries;
		if tries is not number of rows in table of gs:
			continue the action;
	if qbc_litany is table of gs:
		say "Well. That conversation with Guy was...thorough. But you wonder if you needed [i]all[r] the details. You imagine a babbling brook--then, wait...could you? Maybe you could ... BROOK BABBLING instead of TALKing, to just focus on the main stuff, because people aren't going to, like, QUIZ you. Yes. You think you see how, in the future.";
	else:
		say "You feel slight guilt you didn't ask Guy about everything, but not really, after that cheapo. Maybe--well, you don't need to feel forced to listen to everything others say. To BROOK BABBLING before TALKing and not worry about too many details.";
		wfak;
	now know-babble is true;

section Game Shell

the Game Shell is scenery in Smart Street. "It's shaped like a carved-out turtle's shell[one of]. Scratched on the side you see a puzzle that didn't make it, marked OUT PUZZLE[or], with the out puzzle squiggled on it[stopping]. Behind the counter, Guy Sweet half-smiles, staring at the games on offer."

the out puzzle is part of the game shell. understand "square" and "nine" and "nine dots" as out puzzle when player is in smart street. description is "[one of]It's the old puzzle where you have nine dots in a square and four lines and the solution is a diagonal arrow that goes outside the square. Everyone knows it, and in fact you understand the 'cheat' solutions of wrapping the paper around for one line, or treating the dots as having actual height, but somehow, you never felt you had the gravitas to explain how and why it's been done before, and you don't want to re-over-think why, now[or]Nine dots, four lines. Everyone sort of knows it[stopping]."

the printed name of out puzzle is "the 'out' puzzle".

instead of doing something with the out puzzle:
	if current action is not explaining and current action is not examining:
		say "No. You know the Out Puzzle. You forget if you got it when you saw it, but people made you feel awkward for actually knowing it. Best not to dwell--concentrate on Guy's, instead." instead;

instead of entering shell:
	say "'Whoah. Back up there, champ. We need to, like, verify your [g-c]. Just PLAY a game here. Any game.'"

the games counter is part of the Game Shell. description is "[bug]"

instead of doing something with the games counter:
	say "It's there to keep you out. It's plain, but it has lots of games on it, though."

section leaving Smart Street

the gesture token is a thing. description is "It's got a thumbs-up and a finger-gun on one side and a fake grin and a sneer on the other. [if player is in smart street]It's the closest to congratulations you'll probably get from Guy Sweet[else if player is not in variety garden]You wonder where it could be useful[else]The Word Weasel seems to crane in and look at the coin[end if]."

to say g-c:
	now games confidence is in lalaland;
	say "games confidence";

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

table of guy taunts
total-wins	guy-sez
1	"'Thanks for not wasting my time with these dumb brain teasers too much, but all the same, doing the bare minimum...'"
2	"'I guess you're prepared and stuff. Or not.'"
6	"'Nice job and all, but the puzzles are a bit more social in there. You know, talking to other people? Just a tip.'"
10	"'Smart enough to get that many puzzles, you're smart enough to know how much they don't mean in the real world, eh? Without, like, people skills."
10	"'You know, if you were more social, you'd be a total showoff. So you need to watch for that, if you get a clue in the Compound.'"
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
	move-puzzlies;

to send-bros:
	move brother big to lalaland;
	move brother soul to lalaland;
	move brother blood to lalaland;

to move-puzzlies:
	if in-beta is true:
		say "NOTE: if you see someone or something astray, let me know.";
	move proof fool to lalaland;
	move logical psycho to lalaland;
	move harmonic phil to lalaland;
	move art fine to lalaland;
	move poetic wax to lalaland;
	move officer petty to lalaland;
	move sly moore to lalaland;
	move money seed to lalaland;
	move cold contract to lalaland;
	move trade of tricks to lalaland;
	move howdy boy to lalaland;
	move wacker weed to lalaland;
	move howdy boy to lalaland;
	move trail paper to lalaland;
	move boo tickety to lalaland;
	move fourth-blossom to lalaland;
	move reasoning circular to lalaland; [this blocks Court of Contempt]

section write-undo

to write-undo (x - text):
	repeat through table of vu:
		if brief entry matches the regular expression "[x]":
			if found entry is false:
				ital-say "You may have found a secret command that will skip you across rooms you haven't seen. However, you can UNDO if you'd like.";
			else:
				say "[line break]";
			now found entry is true;
			continue the action;
	say "[bug] -- [x] was called as a table element.";

section ducksitting [skips to tension surface]

ducksitting is an action out of world.

understand the command "duck sitting" as something new.

understand "duck sitting" as ducksitting.

carry out ducksitting:
	if player is not in smart street:
		say "Boy! Knowing then what you know now, you'd have liked to duck sitting in some house and getting to action. But you can't, unless you restart." instead;
	say "You open the door to Broke Flat slowly, looking inside for people waiting in ambush. Nobody. You skulk around a bit more--hmm, a passage you'd've missed if you just ran through. You think you see your bathroom up ahead. Wait, no, it's another weird warp. ";
	write-undo "duck";
	duck-sitting;
	the rule succeeds;

to duck-sitting:
	now jump-level is 1;
	move player to tension surface;
	now gesture token is in lalaland;

section knockharding [get to pressure pier]

knockharding is an action out of world.

understand the command "knock hard" as something new.

understand "knock hard" as knockharding.

carry out knockharding:
	if player is not in smart street:
		say "There's nothing to knock hard at. Or nothing it seems you should knock hard at." instead;
	say "You stride up to Broke Flat with purpose, You knock, hard, hoping to avoid a hard knock--and you do! You are escorted through a maze of hallways that eventually open up to a wide area with water behind: Pressure Pier. ";
	write-undo "knock";
	knock-hard;
	the rule succeeds;

to knock-hard:
	now jump-level is 2;
	move player to pressure pier;
	now gesture token is in lalaland;

section figure a cut [get to the jerk circle]

figureacuting is an action out of world.

understand the command "figure a cut" as something new.
understand the command "figure cut" as something new.

understand "figure a cut" as figureacuting.
understand "figure cut" as figureacuting.

carry out figureacuting:
	if player is not in smart street:
		say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. You may wish to restart the game." instead;
	say "Guy Sweet yells 'Hey! Where are you going? I mean, you're probably like accelerated in school but if you think you're accelerated at life...' You ignore him. You don't need to be taught a same lesson twice. Well, not this one. You rattle the doorknob just so--and you recognize a few odd passages in Broke Flat--and bam! You fall through an invisible slide to the [jc]. ";
	write-undo "figure";
	figure-cut;
	the rule succeeds;

to figure-cut:
	now jump-level is 3;
	move player to jerk circle;
	now trail paper is in lalaland;
	now howdy boy is in lalaland;
	now gesture token is in lalaland;

section notice advance [skips you to the endgame before the BM, jerk circle solved]

jump-level is a number that varies.

noticeadvanceing is an action out of world.

understand the command "notice advance" as something new.

understand "notice advance" as noticeadvanceing.

carry out noticeadvanceing:
	if player is not in smart street:
		say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. You may wish to restart the game." instead;
	say "Guy Sweet yells 'Hey! What could you POSSIBLY... you can't just... someone a lot less lame must've showed you that, no offense...' ";
	write-undo "notice";
	notice-advance;
	the rule succeeds;

to notice-advance:
	move-puzzlies;
	now jump-level is 4;
	move player to questions field;
	now all clients are in lalaland;
	send-bros;
	now the score is 17;
	now last notified score is 17;
	now player has quiz pop;
	now gesture token is in lalaland;

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
			say "Bbbbb, you think, you aren't going to worry about every single conversational detail.";
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

a person can be babbled-out. a person is usually not babbled-out.

carry out brookbabbling:
	if accel-ending:
		say "You're already saying whatever to whatever anyone's saying." instead;
	if player is in freak control:
		say "The awkward silence is too oppressive. Besides, you don't have the [bad-guy]'s attention yet." instead;
	if player is in speaking plain:
		say "You don't have much choice but to put up with Dutch and Turk." instead;
	if player is in temper keep:
		say "[if sal-sleepy is true]Sal is sleeping and has nothing to say[else]Sal's complaining is harmless but uninformative[end if]." instead;
	if player is in chipper wood and assassination character is in chipper wood:
		try talking to assassination character instead;
	if player is in pyramid and labor child is in pyramid:
		say "The Labor Child isn't one for small talk, especially around unconsequential people like you. No offense." instead;
	if player is in airy station:
		say "The crowd is certainly babbling, but nothing too in-depth or detailed." instead;
	if player is in truth home and logical psycho is in truth home:
		say "You can't really zone the Logical Psycho out." instead;
	d "[list of blabbable people].";
	if number of blabbable people is 0:
		if number of babbled-out people in location of player > 1:
			say "There's more than one person you babbled with/to. Try to TALK to them individually for a recap." instead;
		if number of babbled-out people in location of player is 1:
			recap-babble a random babbled-out person in location of player instead;			
		say "There's no one here to babble with. With whom to babble." instead;
	if player is in questions field:
		say "[if bros-left is 1]The remaining Keeper Brother doesn't seem[else]None of the Keeper Brothers seem[end if] up to small talk." instead;
	if number of blabbable people is 1:
		let dude be a random blabbable person;
		d "Babbling [dude].";
		babble-out dude instead;
	if number of blabbable people is 2:
		if player is in discussion block:
			say "Art and Phil both seem equally tough to talk to." instead;
		if player is in soda club:
			say "You talk to the Punch Sucker for a bit.";
			babble-out punch sucker instead;
		say "There are too many people to pick out to babble at.";
	the rule succeeds;

to babble-out (pe - a person):
	repeat through table of babble summaries:
		if babbler entry is pe:
			if pe is part-talked:
				say "You already started talking in-depth-ish with [the pe], so it's hard to change up.";
				continue the action;
			choose row with babbler of pe in table of babble summaries;
			say "[babble-content entry]";
			now pe is babbled-out;
			if there is a babble-reward entry:
				now player has babble-reward entry;
			if pe is buddy best:
				move player to questions field;
			if ever-babbled is false:
				say "Well. Now that you, err, abridged the conversation, you feel as though you can abridge how you think of it. Instead of Brook Babbling, well, B[sr-space]B (with or without a space) would work.";
				now ever-babbled is true;
			the rule succeeds;
	say "BUG! [pe] should have a babble shortcut in the table of babble summaries. I think.";

to decide whether (pe - a person) is part-talked:
	let Q be the litany of pe;
	if Q is table of no conversation:
		say "OOPS [pe] has a bug with part-talked code. This shouldn't happen but is fixable.";
		decide no;
	repeat through Q:
		if response entry is talked-thru and enabled entry < 2:
			decide yes;
	decide no;

table of babble summaries
babbler	babble-content	babble-recap	babble-reward
Guy Sweet	"Guy Sweet blinks at you. 'Whoah! You're, like, more accelerated than most people at this whole social thing. I probably don't want to know what you've gotten wrong, dude. No offense. But here, I guess I have to give you this gesture token. Everyone gets one.'"	"Guy seemed impressed you took initiative."	gesture token
Word Weasel	"Something about how he's willing to give you his signature, which is very valuable indeed helping you move on in the world. He hand[one of]s[or]ed[stopping] you a pocket pick, which apparently you can pay off by DIGging."	"[weasel-babble]"	pocket pick
Fritz	"Many variants on 'Whoah dude whoah,' mumbling about the friend he lost[if fritz has minimum bear]--and you found[end if]."	"He was pretty incoherent, mumbling about a lost friend[if fritz has minimum bear] that you found[end if]."	--
Stool Toad	"The usual ordering to keep your nose clean, don't go off the beaten path, or litter, or annoy people, or have illicit substances."	"Ugh. You have had enough of officious adults telling you you seem like a good kid so that's EXTRA reason how you better keep clean."
Punch Sucker	"He mentions all the places he's been and all the exciting people he's met, so much more exciting than here, no offense, you'll be exciting one day. Why, a bit of alcohol might help! [sucker-offer]"	"Something about how exciting he was, and you could be, maybe. It doesn't feel so warm, in retrospect. [sucker-offer]"	--
Liver Lily	"She--well, she seems to be making sense, but you feel obliged to agree with her without thinking in order to show her you're thoughtful. You notice she doesn't have a drink."	"She doesn't seem up for small talk, but she grabs an imaginary drink and swirls it."
Buddy Best	"Buddy Best begins talking a mile a minute about Big Things, and it's impressive all right, and you're not sure how much you should interrupt to say so. You don't at all, and eventually he gets bored of you staring at him and hands you something called a Reasoning Circular and boots you back east."	"BUG. This should not happen."	Reasoning Circular
Pusher Penn	"He drones on about exciting business opportunities and pushes some wacker weed on you to help you, apparently, get a taste of cutting-edge business."	"[if wacker weed is in lalaland]'Business, eh?'[else]He rubs his hand and makes a 'come here' gesture.[end if][penn-ask]"	wacker weed
Sly Moore	"Sly haltingly asks if you found anything that could help him be less klutzy? He needs it a bit more than you. Um, a lot."	"Uh, not found anything yet? No worries, I'd do even worse."	--
Officer Petty	"Officer Petty boomingly proclaims a need for theoretical knowledge to augment his robust practical knowledge."	"'NOT FOUND ANYTHING YET? DIDN'T THINK SO. STILL, I CAN HOPE. I COULD USE SOME HIGHBROW FINESSE, I ADMIT IT.'"	--
Grace Goode	"She mentions how having a flower for the googly bowl [if fourth-blossom is in lalaland]is so[else]would be[end if] nice."	"[if fourth-blossom is in lalaland]'Thank you for returning the flower to the bowl.'[else]'Have you found a flower for the googly bowl?'[end if]"

to say weasel-babble:
	if burden-signed is true:
		say "I won't waste your time if you won't waste mine. Don't make me rip up that signed burden. Deal? Deal.'";
	else if dirt-dug is false:
		say "'Chop chop! Dig dig. Like you promised. Like you made me make you promise.'";
	else if player has proof of burden:
		say "'Cut the small talk. You just want me to sign that proof, don't you?'";
		if the player consents:
			say "'Geez, twist my arm! Ain't I a welfare animal[activation of animal welfare]?'";
			now burden-signed is true;
		else:
			say "'If you change your mind, I'll be here, just a little wasted time in the future. I'll be here even if you don't.'";
	else:
		say "'Go out! Be inspired by my talk! Do things! Find things!'"

to say penn-ask:
	if player does not have weed:
		say "You haven't moved the product yet.";
	else:
		say "Give him the dreadful penny?";
		if the player consents:
			try giving the penny to Pusher Penn;
		else:
			say "You wonder who else will take it."

to say sucker-offer:
	if cooler is in lalaland and brew is in lalaland:
		say "'Oh, and I'm out of free drinks, kid.'";
	else if your-tix is 4:
		say "You decline the offer of a free drink. You're on the edge enough.";
	else if cooler is off-stage and brew is off-stage:
		say "'Want a drink, kid? Nothing too harsh.'";
		if the player consents:
			let Z be a random drinkable;
			now the player has Z;
			say "The Punch Sucker hands you [the Z].";
	else if player has cooler or player has brew:
		say "'I'd offer you another drink, but drink what you got, kid.'";
	else:
		say "'Want the other drink, kid?'";
		if the player consents:
			let Z be a random drinkable not in lalaland;
			now the player has Z;
			say "The Punch Sucker hands you [the Z].";

to recap-babble (pe - a person):
	say "You've already had a chat. Re-summarize?";
	if the player consents:
		choose row with babbler of pe in table of babble summaries;
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

the middle pole is part of the towers of hanoi. understand "left/right pole" and "left" and "right" as middle pole when player is in smart street. description is "[bug]"

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
towers of hanoi	5	"Good lord, no. You know it's only 63 moves. And, well, you've already gotten through--1, 3, 7, 15, 31, so, 59. There's some sort of twisted bizarre induction that would keep you going. But no."
match sticks	0	"You re-organize, from memory, a few matchsticks to reverse a fish and a martini glass and a triangle.[paragraph break]'What's the matter? These not fun for you? Okay, okay, got some harder ones.'"
match sticks	1	"You rearrange a few matchsticks to change false equations into real ones. These are puzzles you hadn't seen, but then, there are only so many possibilities. 'Dude! Lame! I saw you pointing at where the matchsticks should go, brute-forcing them. I thought you had, like, intuition and stuff.'"
match sticks	2	"'Sorry, dude. I'm all out of matchstick puzzles. And are matchstick puzzles really what life's all about? You know, if you were more social I bet you could find more matchstick puzzles. Though there's better things to do in social circles than matchstick puzzles. But hey, whatever.'"
chess board	0	"You remember a cheap trick where you can eliminate the queens from the very center. From there it's pretty easy, since they can't be in the corners. You place one THERE--and the rest logically follow.[paragraph break]'Well, that's not fair. You didn't think. I'm sure you used a cheap trick. Still, I guess you deserve credit. Even if you don't know any other way.'"
chess board	1	"Under Guy's watchful eye, you can't solve the chessboard the same way again. But maybe if the queens were knight moves away--yes, start at the corners ('Dude! You're already wrong!') and put queens at knight's distance. Then switch one corner queen's row with another, then another pair...trial and error...bam![paragraph break]'Good job, I guess. Not sure if that REALLY counts, either. You were kind of guessing and flailing, there.'[paragraph break]You bite your tongue before asking just what DOES really count--but you can never force a straight answer, there."
chess board	2	"You just don't need any more goading--whether or not you find another position, Guy will invalidate how or why you got there."
necklace	0	"You remember the first time you solved it. After all, there were only seven--well, four places to cut the necklace. Three obviously didn't work. Your math teachers were suspicious you solved it a bit too quickly. Of course now everyone knows to cut the third link in, then 1+2+4 gets all numbers up to seven. Guy Sweet replaces the necklace with a much longer necklace. 'Yeah? Well, what if you got 2 cuts? How many numbers could you make?'"
necklace	1	"You get two cuts this time. 7+1=8, leaving a link of 9 chains. Then cut the 7 as before."
necklace	2	"The third puzzle is just more arithmetic. 17+1=18, so the next big link is 19, and so forth. You see the pattern. You tell Guy you could prove it by mathematical induction, but he cringes in fear. Wow! Micro-revenge! Usually YOU get tweaked for knowing stuff like that."
logic puzzles	0	"You don't even need the scratch paper Guy offers you. There are only so many possibilities and a lot of clues. 'Well, yeah, even I could do that,' he mutters. 'Try something more advanced?'"
logic puzzles	1	"It's a bit tougher, now. You hand-draw a grid on a piece of paper Guy gives you. There are more clues to wade through. It's sort of fun, nosing into people's houses (but not really) without having to ask any nosy que...[paragraph break]'Nice job. I knew a guy who can do it in his head--don't worry, you have more hope than him...' Guy takes the scratch paper and crumples it and throws it away. 'Aw, you couldn't have been ATTACHED to it, right?'"
logic puzzles	2	"You work away. It's a bit tedious, and you're not sure what you get, and you remember burning through a whole book so quickly your parents said you'd have to wait for a new one. It's knowledge you never lose, and as you mechanically fill in a few more, Guy crumples it and throws it."
logic puzzles	3	"It's--grr. You see a clear choice between seeming lazy and potentially boring Guy, and after some mental gymnastics, you opt for lazy.[paragraph break]There's a brain game in here for a third option you can't quite solve. [if allow-swears is true]Damn[else]Rats[end if]."

section playing

playing is an action applying to one thing.

understand the command "play/try/solve" as something new.

understand "play [something]" and "solve [something]" and "try [something]" as playing.
understand "play" and "try" and "solve" as playing.

for supplying a missing noun when examining:
	now the noun is Alec Smart;

to say ok-rand:
	say "OK. If you want to see them all, X GAMES. Otherwise, PLAY will automatically pick a random game next time"

pick-warn is a truth state that varies.

rule for supplying a missing noun when the current action is playing (this is the play a game any game rule):
	if location of player is smart street:
		unless guy sweet is part-talked or guy sweet is babbled-out:
			say "[one of]'What? You gonna just play any old game without chatting a bit first?'[or]You'd like to poke around the merchandise, but Guy Sweet is glaring at you, waiting for you to TALK.[stopping]" instead;
		if pick-warn is false:
			now pick-warn is true;
			say "There are a lot of games. To be precise, [number of logic-games in words]. Pick one at random?";
			unless the player consents:
				say "[ok-rand]." instead;
			say "[ok-rand].";
		play-random-game;
		the rule succeeds;
	now noun is Alec Smart;

to play-random-game:
	repeat through table of logic game wins:
		if the-game entry is not tried:
			say "([the the-game entry], why not)[line break]";
			now noun is the-game entry;
			the rule succeeds;
	repeat through table of logic game wins:
		if the-game entry is not defeated:
			say "([the the-game entry], why not)[line break]";
			now noun is the-game entry;
			the rule succeeds;
	say "You scrunch your eyes. You've already played and won everything.[paragraph break]'Bored? Me too! How [']bout that?' snarks Guy.";

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
				say "'Oh, hey, and here's a little something to recognize you're good for something, or at something, or something.'[paragraph break]You turn it over after he hands it to you. Each side looks deliberately counterfeited.[paragraph break]'Buck up, bucko! Show some [g-c]! That's a gen-u-ine gesture token! They're pretty rare. At any rate, I bet YOU'VE never seen one.'";
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
15	false	"'Hey, you've shown some heavy-duty, I guess! Uh, yeah, I'm totally yawning because my brain is tired, not because I am.'"
99	false	"'Gee. That's the end. Impressive. If you had the social skills to match, why, it'd be YOU defending us against [bad-guy-2], not the [bad-guy].'"

does the player mean playing assassination character: it is likely.

carry out playing:
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
	if noun is assassination character or noun is chase paper:
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
	say "You can only really play something that's explicitly a game.";
	if player is in smart street:
		say "Play a random game?";
		if the player consents:
			play-random-game;
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
	say "[unless round screw is in Lounge]A round stick still lies here[else unless round stick is in Lounge]A round screw, almost as large as the stick you're carrying, still lies here[else]A round stick and a round screw, which is about the same size as the stick, lie here[end if].";
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
	now player has off tee;

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
			move player to Tension Surface instead;
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

waited-yet is a truth state that varies.

ignore-wait is a truth state that varies.

to wfak:
	if ignore-wait is false:
		if waited-yet is false:
			say "[i][bracket]NOTE: when the prompt does not appear, it means to push any key to continue[close bracket][r]";
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

Tension Surface is a room in beginning. it is inside of A Round Lounge. "While there's nothing here other than [if rogue arch is examined]the Rogue Arch[else]an arch[end if] [if mush is in surface]dancing sideways [end if]to the north, you're still worried the land is going to spill out over itself, or something. You can go east or west to relieve the, uh, tension. Any other way, it's crazy, but you feel like you might fall off."

after printing the locale description for Tension Surface when Tension Surface is unvisited:
	if Round Lounge is visited:
		say "Well. You start to feel good about figuring the way out of Round Lounge, then you realize that, logically, there was only one. You remember the times you heard you had no common sense, and you realize...you didn't really show THEM, whoever THEY are. 'Not enough common sense.'";
	continue the action;

t-surf is privately-named scenery in tension surface. understand "surface" as t-surf. printed name of t-surf is "the surface". "It feels like it could burst at any minute. The longer it doesn't, the sillier you feel for worrying in the first place."

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
		say "[if mouth mush is in surface]The mouth mush makes fake chicken noises that would make even Tommy Wiseau cringe. Not that you can really run and hide, anyway.[else]Running away would just delay the inevitable--you really should try to enter the arch now.[end if]" instead;
	if noun is north:
		if player has burden and burden-signed is true:
			say "'Procedure, procedure!' mocks the mouth mush. 'You got your documentation signed, but you have to GIVE it over [i]before[r] walking in.'" instead;
		if mush is in surface:
			say "[one of]You think you've judged how the arch dances, so you can anticipate and walk in. Timing...there...WOOMP! The mush mouth opens so wide you can't jump over it. 'Oops! I need proof you NEED to get by.'[or]The mouth expands again. You're not falling in there, oh no.[stopping]" instead;
		say "You take a cautious step. That rogue arch might still bounce around...";
		wfak;
		say "Thankfully, nothing happens besides your surroundings changing from plains to water."

section mouth mush

the mouth mush is a person in Tension Surface. "[if mush is examined]The mouth mush[else]Some mush[end if] burbles in front of the [r-a], conjuring up condescending facial expressions."

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

litany of mouth mush is the table of arch talk

table of quip texts (continued)
quip	quiptext
mush-go	"'Beyond is the Problems Compound. But you must prove you belong there. That you are smart enough to be worth helping, to process what you will see there.'"
mush-all	"'There's something west and east[unless garden is visited and tunnel is visited]. You should have a look[end if]. If you are resourceful, you will find what you need.'"
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

part Vision Tunnel

Vision Tunnel is east of Tension Surface. Vision Tunnel is in Beginning. "The flower wall blocking every which way but west is, well, a vision[if flower wall is examined], and now that you've seen the picture hole in it, you can't un-see it[end if][if earth of scum is in vision tunnel]. Some icky looking earth is clumped here[end if]."

the flower wall is scenery in the Vision Tunnel. "All manner of flowers, real and fake, are sewed together. The only break is [if flower wall is examined]that picture hole[else][pic-hole][end if]."

after doing something with flower wall:
	set the pronoun them to flower wall;

to say pic-hole:
	say "[if picture hole is examined]the picture hole you looked through[else]a small hole, call it a picture hole, because it looks like there's some sort of picture in there[end if]"

check taking flower wall:
	say "The flowers seem delicately interconnected. If you take one, you fear the whole structure might collapse. Then you might feel more lonely than ever." instead;

understand "flowers" as flower wall.

check going nowhere in vision tunnel:
	say "You barge into the flower wall and feel less alone with all that nature around you. This isn't practical, but it feels nice." instead;

the picture hole is scenery in vision tunnel. description is "[one of]You peek into the picture hole in the flower wall, and it looks like a bunch of swirls until you stare at it right. A whole story takes shape. [or][stopping]You recognize [one of]a stick figure[or]yourself, again[stopping] finding a ticket in a book, climbing a chair to reach a hatch, digging by a bunch of flowers, depositing a document in the ground--and then being blocked by three stick figures--blue, red and tall.[paragraph break][one of]You blink, and the picture degenerates back into swirls. But you can always look again, if you want[or]The picture scrambles again once you blink[stopping]."

understand "vision" as picture hole when player is in tunnel and flower wall is examined.

understand "vision" as flower wall when player is in tunnel and flower wall is not examined.

the earth of scum is scenery in Vision Tunnel. "It doesn't smell until you get close to it. It seems to be wriggling, and you're not sure what died in it, or when. You don't want to know."

check taking earth of scum:
	say "Ew. No. If it were just one handful, maybe, but it looks like there's a lot more." instead;

the proof of burden is a thing. "The plaque that is the Proof of Burden lies here."

after printing the name of the proof of burden while taking inventory:
	if proof of burden is examined:
		say " ([if burden-signed is false]un[end if]signed)";
	else:
		say " (which you should probably read)";

understand "plaque/document" as proof of burden when mrlp is Beginning.

burden-signed is a truth state that varies.

description of proof of burden is "The bearer of this plaque is certifiably unable to brush aside problems he feels he really should be smart enough to, and he quite bluntly has no clue how to rectify the situation. I mean, we all feel this way from time to time, but boy, the bearer got an extra dose. He certainly could use an audience with the [bad-guy], whether he deserves it or not.[paragraph break]Of course, he's not just going to be allowed to walk in. Goodness no! This will just get him one step closer. Plus the journey is the important thing, and so on.[paragraph break]There's a line below: SIGNED BY APPROPRIATE AUTHORITY (BEARER DOES NOT COUNT). It is [if burden-signed is true]filled[else]blank[end if]."

after taking proof of burden:
	choose row with response of weasel-baiter in table of weasel talk;
	now permit entry is 1;
	continue the action;


part Variety Garden

table of smackdowns
smak-quip	smak-txt
weasel-forme	"You imagine the Word Weasel saying that anything you do for it would be doing for you, because it probably knows what's good for you."
lily-bye	"No, it'd be even more embarrassing not to say anything. Come on, now, Alec."

Variety Garden is a room in Beginning. Variety Garden is west of Tension Surface. "Brush guards every way out except back east to the Tension Surface. There are few plants here, but poor dirt in all shapes and textures lies here.[paragraph break]There's also an absence of leaves."

the gen-brush is privately-named scenery in variety garden. understand "brush" as gen-brush. "You're not an expert on plants[plant-disc]."

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

after doing something with aside brush:
	now current-brush is aside brush;

after doing something with off brush:
	now current-brush is off brush;

current-brush is a thing that varies. current-brush is usually gen-brush.

does the player mean doing something with current-brush: it is very likely.

the absence of leaves is scenery in Variety Garden. "[bug]"

after doing something with leaves:
	set the pronoun them to leaves;

instead of doing something with the absence of leaves:
	say "It's an absence of leaves, so you can't do much with it."

the poor dirt is scenery in Variety Garden. "[bug]"

instead of doing something with poor dirt:
	if the current action is eating:
		say "It would taste poor." instead;
	if the current action is diging:
		continue the action;
	if weasel-grow is not talked-thru:
		choose row with response of weasel-grow in table of weasel talk;
		now enabled entry is 1;
	say "The poor dirt, though providing the main variety of the garden, isn't good for much other than digging[if dirt-dug is true], which you already did[else if pocket pick is off-stage], but you don't have a tool for that, yet[end if]."

check going in variety garden:
	if noun is up or noun is down:
		say "No. Only back east." instead;
	if noun is south or noun is southeast:
		now current-brush is back brush;
		move back brush to variety garden;
		say "You run into some brush. More precisely, you run near it but back off. 'Found the back brush, eh?' snickers the Word Weasel." instead;
	if noun is north or noun is northeast:
		now current-brush is off brush;
		move off brush to variety garden;
		say "You run into some brush. More precisely, you run near it but just don't feel up to it, as if you don't have the fight to look beyond it. 'Found the off brush, eh?' snickers the Word Weasel." instead;
	if noun is not east: [w nw sw]
		now current-brush is aside brush;
		move aside brush to variety garden;
		say "You run into some brush. More precisely, you get close to it but turn to the side to avoid its prickliness. You look for a way around--it's not that dense, so there should be one--but no luck. 'Found the aside brush, eh?' snickers the Word Weasel." instead;

carry out going west in Tension Surface:
	if variety garden is unvisited:
		say "A small animal bounds up to you. 'Hi! I'm the Word Weasel, and this is the variety garden!'[paragraph break]'There's not much...'[paragraph break]'Well, you haven't noticed the absence of leaves! It's an absence of pretty much every leaf that was! And so much poor dirt! And all the brush!'";

chapter word weasel

the Word Weasel is a neuter person in Variety Garden. description is "The Word Weasel[one of] looks pretty much like the weasels you imagined from those Brian Jacques novels you're too old for now, so you can't read the last few you wanted to. It[or][']s[stopping] facial expression seems to be going for 'so untrustworthy it's trustworthy.'". "The Word Weasel smirks about here."

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
weasel-forme
weasel-arch	"'That's...a bit direct, isn't it? Just going from point A to point B, no worry about self improvement.'"
weasel-arch-2	"'That's...a bit circumspect, isn't it? Throwing in a few fancy words to seem like you care. Oh, all right. I'll sponsor you. Not with money. Just a reference or something.'"
weasel-sign	"'You haven't shown enough interest in things yet. Just in your own social progress. Ironic, but just like the others who come through here who aren't very social. It's just, you're just not good at it.'"
weasel-grow	"'I dunno. A muffin meadow, maybe?'"
weasel-why	"'It's not because I twist words. Oh, no! Well, I do, but I twist them to EXPAND the English language. Plus it shows a deal of self-knowledge to let myself be called that. Yes? Yes. Good.' It laughs hard, and you laugh a bit, and it says that just proves how much less well-adjusted you are."
weasel-more
weasel-pick-hey
weasel-freak	"'Yup. It's way in the north. It's guarded well. It has to be. [bg]'s all for equality, but that doesn't mean everyone deserves to bask in [bg]'s cleverness equally.'"
weasel-baiter	"'Well, if everyone's praising him, that's because he really is great. I mean, there's no personality cult. He gave a great lecture against that. He's just so...well, even when he cuts you down, he's just so full of truth and interestingness. It's obvious, by the energy he puts in to cut people down, how thoughtful he is. No 'everyone is nice' dribble. He doesn't leave Freak Control to spread his wisdom very often.'"
weasel-pick-oops	"'Good thing I didn't charge you a deposit, eh?'"
weasel-bye	"'Gosh! You're lucky I didn't charge you for all this cleverness!'"

check going east when player is in variety garden:
	if dirt-dug is false:
		if player has pocket pick:
			say "'You just going to run away without paying off the pocket pick in full? C'mon, just DIG a bit here.'" instead;
		else:
			say "'Well, let me know when you're ready to do business.'";

section pocket pick

the pocket pick is a thing. description is "You can DIG something with it."

book Outer Bounds

Outer Bounds is a region.

part Pressure Pier

Pressure Pier is north of Tension Surface. It is in Outer Bounds. "[one of]So, this is Pressure Pier. Off south is water--no way back to the Tension Surface[or]Water south, passage north[stopping]. You smell food to the west, and the land sinks a bit to the east. Ahead north, things open up further behind [one of]something labeled[or]the[stopping] Saver Screen."

pier-visited is a truth state that varies.

 after printing the locale description for Pressure Pier when Pressure Pier is unvisited:
	now pier-visited is true; [not the best way to do things but I need to reference something in I6 to modify the play-end text, and it's just cleaner for my i6-illiterate self to define a boolean in I7]
	unlock-verb "knock"

check going in Pressure Pier:
	if noun is outside or noun is south:
		say "Swimming seems inadvisable. The water goes on a ways." instead;
	if room noun of Pressure Pier is nowhere:
		say "You consider going that way, but you'd feel embarrassed walking into a wall or whatever, with or without people watching." instead;

water-scen is privately-named scenery in Pressure Pier. "You notice the water: out of fish[activation of fish out of water]. It stretches quite a ways."

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

the Saver Screen is scenery in Pressure Pier. "It labels seemingly contradictory things to want and to be: to be clever enough to cut down too-clever weirdos. To have enough interests you can almost empathize with obsessed nerds, but not quite. To know enough pop culture you can poke fun at people who care too much about it. To be nice enough adults are sure you'll go far, but not be some useless dweeb.[paragraph break]There's also something about how if you don't know how to balance those things and have to ask others, or if this triggers some oversensitivity, well, REALLY. And there's even a tip of the moment![paragraph break][tip-of-moment]"

saver-row is a number that varies. saver-row is usually 0.

saver-cycled is a truth state that varies. saver-cycled is usually false.

to say tip-of-moment:
	increment saver-row;
	if saver-row > number of rows in table of saver references:
		now saver-row is 1;
		now saver-cycled is true;
	choose row saver-row in the table of saver references;
	say "[italic type][reference-blurb entry][line break]";
	if saver-row is number of rows in table of saver references:
		say "[r]LAST HINT. You'd better have learned something, but remember, you can push around people who don't matter by saying they aren't persistent enough or they are a bit obsessed. Often within five minutes of each other. Because it's important to see both sides.";
	else if saver-row is 1:
		say "Of course, just internalizing this tip won't make you quite the guy the [bad-guy] is. Everyone can be right about some random thing. You need a variety of moves. To be a complete person![r]";
	else:
		say "[r]";
	unless accel-ending:
		if saver-cycled is false and saver-row is a looknum listed in table of saver reflections:
			choose row with looknum of saver-row in table of saver reflections;
			say "[reflection entry]";

table of saver reflections
looknum	reflection
1	"Well, you do need to be more dynamic in conversations. But that doesn't seem right. You wonder if you're just being lazy or unsocial or antisocial."
3	"Man. It's frustrating. People have pulled these moves on you. And you're pretty sure they're wrong. You've got no way to go around them. You wonder if maybe you need a LITTLE edge."
6	"Ugh. Surely that can't be the way to be? But people who mastered this, get ahead."
10	"It seems knowing these makes up for not knowing actual stuff. Maybe you are just jealous others put in the effort to look and be clever with more than just boring facts."

table of saver references
reference-blurb
"Misunderstand someone blatantly to see if they react excitingly enough. If so, you may have a new associate!"
"Use 'fair enough' frequently to cool off someone who actually may have a point."
"Complain about something you can't say these days, but don't let your audience cut in too much."
"Pretend to misunderstand everyone even if they're clear. If they don't stick up for themselves, well, they need to learn."
"Use 'y'know' a lot, especially when berating unnecessary adverbs."
"Point out that someone thinks they're a special snowflake, but...give it your own special touch."
"Blast people for copying you, or for being too weird."
"Smack [']em down with 'It's called...' two or three times a day."
"Make your I CAN'T and YOU CAN'T equally forcible."
"Make people feel like they blew it and they never had it in the first place."
"Say people need to put first thing first, then laugh at every other thing they say."
"If you can make people feel their weirdness is forcing you to lie to them, good for you!"
"Pick out an unsocial skeptic and be skeptical they actually care."
"Tell people you're not a mind reader, then say you know what they're thinking."
"A single 'I'm not mad at you' can go a long way."
"'Don't get me wrong' puts the burden on THEM. If you don't think you deserve to use it, you don't. Don't take this the wrong way!"
"Be exciting when you refuse to apologize, and cut people down for boring apologies which don't make others feel better."
"Be okay once they get to know you around people it's not worth bothering to get to know."
"Some people aren't special, but they have special weird quirks. Don't let them off the hook!"
"Let people know when they need to take a hint and when stuff is in all their head."
"Assure people you get to the point, but be sure to laugh before responding. 'Is it something I said' is a good follow up question."
"Throw someone a bone with 'Even so-and-so knows...' You'd be surprised how many 'nice quiet types' lash out at charity."
"When asked for help, say 'oh, it's easy.' If someone asks why, tell them to stop badgering you."
"Be sure one weirdo a day is a nice guy. Let him know. It's not your fault if he responds...weirdly."
"Tell someone they're clear when they're unclear, and vice versa."
"Understand how flattery and the golden rule interact, unless someone is fishing for approval."
"Pick out someone creepy with a valid criticism and go ad hominem."

after examining saver screen when accel-ending:
	if cookie-eaten is true:
		say "Well, DUH. It seems so obvious now you've eaten the cookie.";
	else if greater-eaten is true:
		say "Yyyuuuppp. It's easy to see why that works, now, and anyone who can't put in the effort to do that...the heck with [']em.";
	else:
		say "Geez. You don't want to have to put up with that any more. You'll be more forceful telling people to expletive off in the future, though. That should help.";
	continue the action;

instead of doing something with Saver Screen:
	if action is procedural:
		continue the action;
	say "It's mostly there for looking at and absorbing its philosophy, whatever that may be."

check taking the Saver Screen:
	say "That'd be too much of a burden." instead;

section Howdy Boy

The Howdy Boy is a person in Pressure Pier. "[one of]A smiling fellow walks up to you and shakes your hand. 'I'm the Howdy Boy! Here to introduce new people to the Problems Compound! Smart or dumb, social or lame, well, someone needs to!' You shake hands, equally afraid you were too hard or soft. His enthusiasm quickly tails off, leaving you feeling it was your fault.[or]The Howdy Boy stands here, [if player has trail paper]and on seeing your trail paper, snaps his fingers and makes a 'gimme' gesture[else]looking disinterested now he's greeted you[end if].[stopping]"

description of Howdy Boy is "Brightly dressed, smiling a bit too wide."

check talking to howdy boy:
	if trail paper is in lalaland:
		say "'You don't need anyone to greet you any more. [if jerk circle is unvisited]Go on! See what's north[else]You've already visited what's beyond[end if][if meal square is not visited]. Oh, and check out to the west, too[end if].'" instead;

the litany of Howdy Boy is table of howdy boy talks.

table of hb - howdy boy talks
prompt	response	enabled	permit
"So, um. Hi. I mean Howdy. Or heya."	howdy-howdy	1	1
"Boy howdy! This sure is an interesting place!"	howdy-boy	0	0
"For such an interesting guy, you sure have nothing better to do than stand here and block people going north."	howdy-int	0	0
"Can you let me north? Please?"	howdy-north	0	1
"So. What's fun to do here?"	howdy-fun	1	1
"What's to the west?"	howdy-west	1	1
"Tell me about the [bad-guy]."	howdy-baiter	1	1
"[later-or-thanks]."	howdy-bye	3	1

table of quip texts (continued)
quip	quiptext
howdy-howdy	"'Um...yeah. I've heard that one. If you knew that, you shouldn't have said howdy, and if you didn't, that's kinda clueless. Anyway.'"
howdy-boy
howdy-int
howdy-fun	"'Well, there's solving boring puzzles. But that's a bit too square. No offense, but that's probably how you wound up here. What if you--well, bend the rules a bit? Nothing too stupid, but annoy authority. Convince me--and yourself, of course--you're not just some boring square.'"
howdy-ways	"'Well, there's public laziness. Annoying other bar patrons. Possession of alcohol. Littering and/or obfuscating your own transgressions record.'"
howdy-north	"'Well, it gets a bit seedier there. Rougher. I'm sure you're nice and all, even if you're not actually nice TO anyone, but it might be better not to be totally nice. Tell you what. You find me a trail paper, I let you by. It's made up of--oh, what do you call em? For not being a total kiss-up? Anyway, don't do anything too dumb. But you'll want to annoy authorities a bit.'"
howdy-west	"'Meal Square. But you can't get up to much trouble there.'"
howdy-baiter	"'I'm sure he'd like to welcome you individually, but he's just too busy fending off [bad-guy-2]. And thinking up his own philosophies. And making sure nobody weirds out too much, from his big observation room in Freak Control. So he delegates the greeting to me, while making sure nobody acts out the wrong way. Don't get me wrong. He's a geek/dork/nerd and loves the rest of us. Just, those who give it a bad name...'"
howdy-bye	"'Later. Be good. But not too good. That's just boring.'"

before quipping when player has trail paper:
	if player has trail paper and player is in pressure pier:
		say "Wait a minute! You've got the trail paper! Enough chit-chat!";
		terminate the conversation;
		try giving trail paper to howdy boy instead;

after quipping when qbc_litany is table of howdy boy talks:
	if current quip is howdy-howdy:
		enable the howdy-boy quip;
		enable the howdy-int quip;
	if current quip is howdy-ways:
		now litter-clue is true;
	if current quip is howdy-north:
		enable the howdy-fun quip;
	if current quip is howdy-fun:
		enable the howdy-ways quip;
	if current quip is howdy-bye:
		terminate the conversation;

to superable (q - a quip):
	choose row with response of q in qbc_litany;
	now enabled entry is 2;

check going north in Pressure Pier:
	if howdy boy is in lalaland:
		continue the action;
	if trail paper is in lalaland:
		say "The Howdy Boy gestures you through. 'Well, you started good. Here's luck to finding more lessons, further on[if meal square is not visited]. Oh, and maybe stop off west Meal Square, if you want[end if].'";
		continue the action;
	if player has trail paper:
		say "The Howdy Boy snaps his fingers and points at your trail paper.";
		try giving trail paper to howdy boy;
		if trail paper is in lalaland:
			continue the action;
		the rule succeeds;
	choose row with response of howdy-north in table of howdy boy talks;
	now enabled entry is 2;
	if howdy-howdy is not talked-thru:
		say "The Howdy Boy bars you with his arm. He's not bigger than you, but he is louder. 'Hey! Whoah! I took the time to greet you, and you're going to bull right on through? Nope!'" instead;
	say "'Nope. Not yet. Yay for showing initiative, but I need a bit more evidence you're not all goody-goody.'" instead;

section trail paper

the trail paper is a thing. description is "It looks pretty official. It's made up of the four boo ticketies, but now they're folded right, it may be just what the Howdy Boy wanted."

part Meal Square

check going west in pressure pier:
	if trail paper is in lalaland:
		do nothing;
	otherwise:
		if meal square is unvisited:
			now thought for food is in lalaland;
			say "The Howdy Boy coughs. 'That's Meal Square. Nice if you've got a thought for food[activation of thought for food]. But better places to break the rules.' Nevertheless, he lets you go.";

Meal Square is west of Pressure Pier. Meal Square is in Outer Bounds. "This is a small alcove with Pressure Pier back east. There's not much decoration except a picture of a dozen bakers."

Tray A is a supporter in Meal Square. description is "It's just a tray, really. Nothing special. A few foods rest on tray A: [list of things on tray a]."

Tray B is a supporter in Meal Square. description is "[if accel-ending]You still see [list of things on tray a] on Tray B, but you're pretty full[else]You're both scared and intrigued by Tray B, which reads, in small print NOT FOR THE UNSOPHISTICATED. Three unappetizing looking foods lie on it, labeled: [a list of things on tray b][end if]."

check examining a supporter when accel-ending:
	say "You've already seen the food there and made your choice." instead;

check taking when player is in Meal Square and accel-ending:
	say "Ug. You're full. Move on." instead;

check eating when player is in Meal Square and accel-ending:
	say "Ug. You're full. Move on." instead;

check going nowhere in meal square:
	say "No way out except east." instead;

the picture of a dozen bakers is scenery in Meal Square. "It's a weird optical illusion--sometimes you count twelve, but if you look right, they warp a bit, and there's one extra. What's up with that?"

after doing something with bakers:
	set the pronoun them to bakers;

instead of doing something with bakers:
	if action is undrastic:
		continue the action;
	say "It's just there for scenery. There's nothing behind it or whatever."

chapter fast food menu

[fast food? Get it? It gets you through the game fast! Ha ha!]

a badfood is a kind of thing. a badfood is usually edible.

to decide which thing is yourfood:
	repeat with X running through badfoods:
		if X is in lalaland:
			decide on X;
	decide on Alec Smart;

to decide whether accel-ending:
	if greater-eaten is true or off-eaten is true or cookie-eaten is true, decide yes;
	decide no;

to say co-ch:
	say "[if off-eaten is true]off cheese[else if greater-eaten is true]greater cheese[else]cutter cookie[end if]"

before going when accel-ending:
	if player is in meal square:
		if noun is east or noun is outside:
			say "The heck with this dump.";
			continue the action;
		else:
			say "You do feel like [if off-eaten is true]banging[else if greater-eaten is true]busting through[else]bouncing off[end if] the walls now you've eaten the [co-ch], but not literally. But when you get bored, there's back east." instead;
	if noun is north:
		say "[if off-eaten is true]Maybe up ahead will be less lame[else]Time to leave [location of player] in the dust[end if].";
		continue the action;
	if noun is south:
		if player is in pressure pier:
			say "[if off-eaten is true]You can't deal with the Word Weasel and Rogue Arch again. Well, actually, you can, but it's a new quasi-fun experience to pretend you can't[else if cookie-eaten is true]You'd like to go back and win an argument with the Word Weasel, who seems like small potatoes compared to showing the [bad-guy] a thing or two[else]You're too good to need to kiss up to the Word Weasel again[end if]." instead;
		say "[if off-eaten is true]Go back south? Oh geez. Please, no[else]Much as you'd like to revisit the site of that argument you won so quickly, you wish to move on to greater and bigger ones[end if]." instead;
	if the room noun of location of player is nowhere:
		say "Nothing that-a-way." instead;
	if the room noun of the location of player is visited:
		say "You look [noun]. Pfft. Why would you want to go back? You're more focused after having an invigorating meal." instead;
	else:
		say "[if off-eaten is true]You really don't want to get lost among whatever weird people are [noun]. You're not up to it. You just want to talk to anyone who can get you out of here.[else]Pfft. Nothing important enough that way! Maybe before you'd eaten, you'd have spent time wandering about, but not now. North to Freak Control![end if]" instead;

section greater cheese

greater cheese is a badfood on Tray B. description is "It looks just as icky as the off cheese. Maybe it's marbled differently or something. These things are beyond you."

greater-eaten is a truth state that varies.

check taking greater cheese:
	try eating noun instead;

check eating greater cheese:
	if off-eaten is true:
		say "Ugh! You've had enough cheese." instead;
	if cookie-eaten is true:
		say "Cookies and cheese? That's just weird." instead;
	say "You pause a moment before eating the greater cheese. Perhaps you will not appreciate it fully, or you will appreciate it too much and become someone unrecognizable. Try eating it anyway?";
	unless the player yes-consents:
		say "[line break]OK." instead;
	say "You manage to appreciate the cheese and feel superior to those who don't. You have a new outlook on life! No longer will you feel [b-o]!";
	now greater cheese is in lalaland;
	force-swear;
	now greater-eaten is true instead;

to say b-o:
	say "bowled over";
	now bowled over is in lalaland;

section off cheese

off cheese is a badfood on Tray B. description is "[if greater-eaten is true or cookie-eaten is true]It's really gross, and you'd have to be weird to consider eating it[else]It looks really gross but you're sure other people have better reasons why it is[end if]."

off-eaten is a truth state that varies.

check taking off cheese:
	try eating off cheese instead;

check eating off cheese:
	if greater-eaten is true:
		say "You are above eating disgusting cheese. Unless it's tastefully disgusting, like what you just ate." instead;
	if cookie-eaten is true:
		say "Ugh! Now that you've eaten the cutter cookie, the off cheese looks even more gross than before. No way. You just want to leave." instead;
	say "Hmm. It seems edible--well, eatable. You might not be the same person after eating it. Try eating it anyway?";
	unless the player yes-consents:
		say "[line break]OK." instead;
	say "Ugh. Bleah. It feels and tastes awful--but if you sat through this, you can sit through an awkward conversation. Not that you'll be over-bold[activation of bowled over] and cause a few. [activation of growing pains]Pain's growing... pain's growing...";
	now off cheese is in lalaland;
	force-swear;
	now off-eaten is true instead;

section cutter cookie

a cutter cookie is a badfood on Tray B. description is "It looks like the worst sort of thing to give kids on Halloween. If it doesn't have any actual razor blades, it's pointy as a cookie should not be. It's also grey and oatmeal-y, which cookies should never be. I mean, I like oatmeal cookies, just not dingy grey ones. It seems like excellent food for if you want to be very nasty indeed."

cookie-eaten is a truth state that varies.

check taking cutter cookie:
	try eating cutter cookie instead;

check eating cutter cookie:
	if off-eaten is true:
		say "Ugh. You're not in the mood for something sweet like cookies. You're good and jaded." instead;
	if greater-eaten is true:
		say "Pfft. Anyone can appreciate cookies. Cookies aren't sophisticated." instead;
	say "It's so sharp, it'd start you bleeding if you carried it around. Even as you pick the cookie up your thoughts turn resentful, yet you feel justified as never before. Try eating it anyway?";
	unless the player yes-consents:
		say "[line break]OK." instead;
	say "[line break]You have to eat it carefully, because of its spikes, but it gives you...a sharp tongue. Suddenly you wonder why you spent so much time feeling [b-o]. You're ready to go off on pretty much anyone who's gotten in your way, or even not helped you enough[if allow-swears is false]. You'll show those punks you don't need to swear to kick butt![else].[end if]";
	now cookie is in lalaland;
	force-swear;
	now cookie-eaten is true instead;

to force-swear:
	if allow-swears is false:
		say "Also, you realize how lame it was to be stuffy about swears. You have stuff to swear ABOUT now, see?";
		now allow-swears is true;

table of accel-text
accel-place	alt-num	accel-cookie	accel-off	accel-greater
pressure pier	0	"You take a moment to sneer at the [if howdy boy is in lalaland]memory of the [end if]Howdy Boy. 'Is this your JOB? Man, that's SAD. The stupid stuff you want people to do to show you they're cool? Little league stuff. I mean, thanks for the start and all, but SERIOUSLY.' He gapes, shocked, then flees before your wrath.[paragraph break]Man! You've never won an argument before. And you didn't expect to win that conclusively. Oh, wait, yes you did."	"You give an exasperated sigh. 'I'm not here because I want to be. I got suckered into it. Do you think I could...?'[paragraph break]'You know, some people don't even ASK. Or if they do, it's all unforceful. You're okay. You can go through.' [if howdy boy is in lalaland]You blame the Howdy Boy for not being around to listen to your whining[else]The Howdy Boy bows slightly--you don't care if it's sarcastic or not--and you walk past. You turn around, but he's not there[end if]."	"[if howdy boy is in lalaland]You're sad the Howdy Boy is gone. You'd be giving HIM advice, now.[else]'Oh, hey! Still here? I'm moving ahead in life!' you say to the Howdy Boy, who runs off in embarrassment.[end if]"
jerk circle	1	"'Hey, move it, I'm on a quest here!' They look shocked. You proceed to berate them for, is this all they ever do? Is it their purpose in life? Do they have anyone better to talk to? If so, what a waste. If not, sad.[paragraph break]Before this terrifying onslaught of hard-hitting language and lucid, back-to-basics logic, the [j-co] recognize how minor-league they are. They run off to chat or commiserate elsewhere.[paragraph break]Bam! Seven at one blow!"	"'Hey, what you all talking about?' you ask. 'Gossip, eh?' You try to join in, but--they seem a bit jealous of how good your grumbling is, and they excuse themselves."	"'Oh! Hey! You all talking about something interesting? I won't disturb you. Which way is the [bg]?' They look shocked you...USED HIS INITIALS. They point north. 'I KNOW,' you boom. They scatter."
lalaland	2	"Oh, boy. Looking back, you didn't need all that reasoning to get past them. You could've probably just acted a little exasperated, said you were SURE someone could help, and wham! Well, it's good to have all this space, but you need to be going north."	"You sniff at the memory of the [j-co] you helped. They weren't properly grateful, and they weren't even good at being jerks. Maybe you should've gone into business with the Labor Child. You'd figure how to backstab him later. Still, you learned a lot from that. Perhaps you can find ways to keep tabs on people, probe their weaknesses. Makes up for earlier memories of your own."	"You look back at the silliness and all you did to get around the jerks when really you could've just shown them what was what the way you are now. You're--BETTER than those logic puzzles."
speaking plain	0	"Oh geez. You can't take this. You really can't. All this obvious improvement stuff. You lash out, do they think people REALLY don't know this? Do they think hearing it again will help? Uncle Dutch and Turk Young revile you as a purveyor of negative energy. No, they won't go on with all this cynicism around. But you will be moving on soon enough. They go away for a break for a bit."	"'FRAUDS!!!' you yell at Uncle Dutch and Turk Young. 'ANYONE CAN SPOUT PLATITUDES!' You break it down sumpin['] sumpin['] real contrarian on them, twisting their generalities. A crowd gathers around. They applaud your snark! You yell at them that applause is all well and good, but there's DOING. They ooh and ahh further. After a brief speech about the dork you used to be, and if you can get better, anyone can, you wave them away."	"You give a pre-emptive 'Oh, I KNOW,' before Turk and Dutch can say any more. 'But you're doing a pretty good job. I mean, almost as good as I could if I weren't destined for better things.'"
questions field	3	"Well, of COURSE the Brothers didn't leave a thank-you note. Ungrateful chumps. Next time you help someone, you'll demand a deposit of flattery up front, that's for sure."	"You expected no thanks, but you didn't expect to feel bad about getting no thanks. Hmph. Lesson learned!"	"'You had some wisdom to foist on the Brothers, but if they'd REALLY done their job, they'd have stayed. The heck with them! If they couldn't soak up knowledge from BEING around the [bg], they're hopeless."
questions field	4	"'Kinda jealous of your brother[bro-s], eh? Not jealous enough to DO anything about it.' The brother[bro-nos]s nod at your sterling logic. 'You gonna waste your whole life here? I can't help everyone. I'm not a charity, you know.' More hard hitting truth! Ba-bam!'[wfk]'Go on, now! Go! What's that? I'm even bossier than the [bad-guy]? Excellent! If I can change, so can you! And the guy bossier than the [bad-guy] is ORDERING you to do something useful with your life!'[paragraph break]They follow your orders. You remember being bossed around by someone dumber than you--and now you turned the tables! Pasta fazoo!"	"'Still guarding Freak Control, eh? Well, I think you'll see you don't need to guard it from ME any more. Take the day off! C'mon, you want to. Hey, [bg] might be mad if you don't.' You're surprised he DOES run off."
questions field	5	"'[qfjs] standing around, eh? Nothing to do? Well, I've been out, y'know, DOING stuff. You might try it. Go along. Go. You wanna block me from seeing the [bad-guy]? I'll remember it once he's out of my way.' You're convincing enough, they rush along."	"You've done your share of standing around, but you're pretty sure you did a bit of thinking. 'Look,' you say, 'I just need to get through and get out of here. I'm not challenging anyone's authority. Just, I really don't want to be here.' [bro-consider]. You're free to continue."	"'Oh, hey, everyone! You're here to guard the [bg] from chumps, right? Well, I'm not one. So you can make way.'"
freak control	0	"You speak first. 'Don't pretend you can't see me, with all those reflective panels and stuff.'[paragraph break]He turns around, visible surprised.[paragraph break]'Leadership, schmeadership,' you say. You're worried for a moment he might call you out on how dumb that sounds. You're open-minded like that. But when he hesitates, you know the good insults will work even better. 'Really. Leaving the cutter cookie right where I could take it, and plow through, and expose you for the lame chump you are. Pfft. I could do better than that.'[paragraph break]He stutters a half-response.[paragraph break]'Maybe that's why [bad-guy-2] hasn't been dealt with, yet. You say all the right things, but you're not forceful enough. Things'll change once I'm in power.'[wfk]He has no response. You point outside. He goes. Settling in is easy--as a new leader of Freak Control, you glad-hand the important people and assure them you're a bit cleverer than the [bad-guy] was.  Naturally, you keep a list of [bad-guy-2]'s atrocities, and they're pretty easy to rail against, and people respect you for it, and from what you've seen, it's not like they could really get together and do anything, so you're making their lame lives more exciting.[wfk]You settle into a routine, as you read case studies of kids a lot like you used to be. Maybe you'd help one or two, if they had initiative...but until then, you'd like to chill and just let people appreciate the wit they always knew you had.[paragraph break]Really, who can defeat you? Anyone of power or consequence is on your side. Even [bad-guy-2] gives you tribute of a cutter cookie now and then. One day, you drop one in Meal Square... but nobody is brave enough to eat one. Well, for a while."	"You speak first. Well, you sigh REALLY loudly first. 'Just--this is messed up. I want to leave.'[paragraph break]'Of course you do,' says the [bad-guy]. 'I don't blame you. If you're not in power here, it's not fun. It's sort of your fault, but not totally. Hey, you actually showed some personality to get here. Just--show me you're worthy of leaving.' You complain--more excitingly than you've ever complained before. Without flattering or insulting the [bad-guy] too much: fair and balanced. You let him interrupt you, and you even interrupt him--but only to agree with his complaints.[wfk]'You're okay, I guess. You seem to know your place. Here, let me show you the Snipe Gutter. It seems like just the place for you. The [bad-guy] pushes a button and gestures to an opening. It's a slide. You complain a bit, but he holds up his hand. 'You'll have a lot more to complain about if you don't go.' You're impressed by this logic, and you only wish you could've stayed longer to absorb more of it, and maybe you could complain even more interestingly.[wfk]Back home, people notice a difference. You're still upset about things, but you impress people with it now. You notice other kids who just kind of seem vaguely upset, like you were before the Compound, not even bothering with constructive criticism. They're not worth it, but everywhere you go, you're able to fall in with complainers who complain about such a wide variety of things, especially people too dense to realize how much there is to complain about! You've matured, from..."	"'Hey! It's me!' you yell. [bg] turns. 'You know, I probably skipped a lot of dumb stuff to get here. You think you could be a LITTLE impressed?'[wfk]But he isn't. 'You know? You're not the first. Still, so many people just sort of putter around. You're going to be okay in life.' You two have a good laugh about things--you're even able to laugh at yourself, which of course gives you the right to laugh at people who haven't figured things out yet. Humor helps you deal, well, if it doesn't suck. You realize how silly you were before with all your fears, and you try to communicate that to a few creeps who don't want to be social. But they just don't listen. You'd rather hang around more with-it types, and from now on, you do."

after printing the locale description when accel-ending:
	if location of player is cheat-surveyed:
		continue the action;
	unless location of player is an accel-place listed in table of accel-text:
		say "BUG. There should be text here.";
		now location of player is cheat-surveyed;
		the rule succeeds;
	if player is in jerk circle:
		if silly boris is in jerk circle:
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
			say "[accel-greater entry]";
	if cookie-eaten is true:
		if there is no accel-cookie entry:
			say "[bug]. There should be text for the cookie and [location of player].";
		else:
			say "[accel-cookie entry]";
	if player is in pressure pier: [cleanup]
		now howdy boy is in lalaland;
	if player is in jerk circle:
		now all clients are in lalaland;
	if player is in speaking plain:
		now turk is in lalaland;
		now dutch is in lalaland;
	if player is in questions field:
		now brother soul is in lalaland;
		now brother blood is in lalaland;
		now brother big is in lalaland;
	if player is in freak control:
		end the story saying "[final-fail-quip]";
	now location of player is cheat-surveyed;
	continue the action;

to say final-fail-quip:
	if greater-eaten is true:
		say "People Power? Power People![no line break]";
	else if off-eaten is true:
		say "Can't Complain? Complain Cant![no line break]";
	else if cookie-eaten is true:
		say "Mean Something? Something Mean![no line break]";

to say qfjs:
	say "[if questions field is unvisited]Just[else]Still[end if]"

to say bro-consider:
	if bros-left is 1:
		say "You both agree that you probably would've helped him, too, if you had the time, but life stinks. You exchange an awkward handshake good-bye";
	else:
		say "The brothers confer. '[bg] said to let him in...obviously harmless...grumbly...' You tap your foot a bit and sigh. They wave you through and nip off to the side"

to say bro-s:
	say "[if bros-left is 1]s[end if]";

to say bro-nos:
	say "[unless bros-left is 1]s[end if]";

chapter condition mint

for writing a paragraph about a supporter in Meal Square:
	say "Two trays sit here, labeled, semi-helpfully, Tray A and Tray B[one of]. You're not surprised Tray S or X is gone, but Tray T would've been nice[or][stopping].";
	now Tray S is in lalaland;
	now Tray X is in lalaland;
	now Tray T is in lalaland;
	now all supporters in meal square are mentioned;

a condition mint is an edible thing on Tray A. description is "It's one inch square, with SHARE WITH A FRIEND on it."

check eating the condition mint:
	say "No, it's for someone else." instead;

definition: a client (called cli) is befriended:
	choose row with jerky-guy of cli in table of fingerings;
	if suspect entry is 2:
		decide yes;
	decide no;

chapter up gum

some up gum is an edible thing on Tray A. description is "You know it's UP GUM since that's what's carved into the top surface."

check taking some up gum:
	try eating some up gum instead;

check eating some up gum:
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

check taking the iron waffle:
	say "It'd be too heavy." instead;

check eating the iron waffle:
	say "Your teeth are actually pretty good, and that'd be a great way to change that." instead;

chapter gagging lolly

a gagging lolly is an edible thing on Tray A. description is "Staring at the circular lolly's hypnotizing swirls of hideous colors, you also feel less sure of things, which makes you feel open-minded, which makes you feel more sure of things, which makes you feel closed-minded and eventually less sure of things.[paragraph break]Man! That was tough to digest. Just all that thinking was a choking enough sensation."

check taking lolly:
	say "You haven't walked around with a lolly since you were five years old, and it'd be a bit embarrassing to do so now. Anyway, who would actually take it?" instead;

part Down Ground

Down Ground is east of Pressure Pier. It is in Outer Bounds. "[one of]Walking east of Pressure Pier, the land dips a bit. You pass by a bench that seems to radiate heat. A closer look reveals that, yes, it is a Warmer Bench.[or]The Warmer Bench waits here. It may be useful to lie on, or not[stopping]. Even choosing between eventually exiting to the east or west is oppressive."

after printing the locale description for down ground when down ground is unvisited:
	say "You're reminded of the day you didn't get a permission slip signed to go to the roller coaster park at science class's year end. You wondered if you really deserved it, since you didn't do as well as you felt you could've.";

check going nowhere in Down Ground:
	if noun is down:
		say "You're down enough." instead;
	if noun is up:
		say "Paths up to the east or west. So hard to decide which." instead;
	say "It's too high a slope north or south." instead;

the warmer bench is a supporter in Down Ground. "The Warmer Bench waits here. It may be fun to lie on.". description is "Originally painted on the bench: PROPERTY OF BUM BEACH. Property Of is replaced by FORECLOSED FROM. You feel the heat coming from it. It makes you sleepy."

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

after printing the locale description for down ground when down ground is unvisited:
	say "A large human-sized toad strolls in from the east. 'So! A new juvenile, eh? Gonna be on the straight and narrow? Or wind up like Fritz the On, here? Eh? EH?' Before you can answer, he turns back.[paragraph break]Fritz the On mutters something about that oppressive Stool Toad."

Fritz the On is a surveyable person in Down Ground. "[one of]A fellow a bit older, but likely not wiser, than you sits cross-legged next to the Warmer Bench.[or]Fritz the On still mumbles, sitting cross-legged.[stopping]"

description of fritz is "Fritz the On may be cosmically 'on,' but physically, he's out of it. Scruffy and unclean, he wobbles to and fro, mouthing words you can't make out[if fritz has bear]. He's clinging tightly to Minimum Bear[end if]."

understand "bum" as fritz

before taking bear when Fritz carries bear:
	say "Now that'd be just mean." instead;

after printing the name of boo tickety while taking inventory:
	say " ([your-tix] piece[if your-tix > 1]s[end if])";

the boo tickety is a thing. description is "WHATEVER YOU DID: BOOOOOO is displayed on [if your-tix is 1]it[else]each of them[end if].[paragraph break]You have [your-tix] [if your-tix is 1]piece of a boo tickety[else]pieces of boo ticketies[end if]. But [if your-tix is 1]it doesn't[else]they don't[end if] make a full document yet."

understand "boo ticket" and "ticket" as boo tickety.

drop-ticket is a truth state that varies.

the dreadful penny is a thing. description is "It has a relief of the [bad-guy] on the front and back, with 'TRUST A BRAIN' on the back. You hope it's worth more than you think it is."

after examining dreadful penny:
	now brain trust is in lalaland;
	continue the action;

your-tix is a number that varies.

to howdy-sug:
	let ff be first-ticket of 1;
	if ff > 0:
		choose row ff in table of tickety suggestions;
		say "The Howdy Boy nods, semi-impressed, but wonders aloud if you considered [ticket-ref entry]. You shake your head.";
		continue the action;
	let ff be first-ticket of 2;
	choose row ff in table of tickety suggestions;
	say "The Howdy Boy nods, semi-impressed, but wonders aloud if you considered [ticket-ref entry]. You say you did, but really, it didn't seem as fun or expedient as what you did.";

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
			say "The Stool Toad [if player is not in joint strip] rushes over from the Joint Strip, yelling and getting on, but then [end if]turns all quiet. 'Son, you've gone too far. It's time to ship you out.' And he does. Even Fritz the On shakes his head sadly as you are marched past to the west.";
			ship-off Shape Ship;
		decrement your-tix;
	else if your-tix is 4:
		say "You have the fourth and final boo tickety you need! Using some origami skills you felt would never be practical, you fold them to form a coherent document: a trail paper!";
		now boo tickety is in lalaland;
		now player has trail paper;
		if player has a drinkable:
			say "[line break]Uh oh. You look at the drink in your hand. You're a hardened lawbreaker, now, and if the Stool Toad caught you with it, he'd have reason to send you off somewhere no good. You should probably DROP the [if player has brew]brew[else]cooler[end if].";
	else if your-tix is 1:
		say "You aren't sure what to do with this. It's not quite a ticket, because it's not shaped like one. It's cut diagonally, and it's triangular. You notice it's got a quarter of some sort of stamped seal on the other side.";
		now player has boo tickety;
	else if your-tix is 2:
		say "What luck! The second boo tickety you got fits in with the first. You now have a diagonal-half of, well, something.";
	else if your-tix is 3:
		say "You now have almost a full paper from the boo ticketies.";
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
fritz-bye	"As you turn away, Fritz mumbles something about hoping you find genuine consciousness."

after quipping when qbc_litany is litany of fritz:
	if current quip is fritz-ok:
		enable the fritz-pal quip;
	if current quip is fritz-bye:
		terminate the conversation;

part Joint Strip

Joint Strip is east of Down Ground. It is in Outer Bounds. "There's a familiar but disturbing scent in the air--those responsible for it are probably hiding nearby from the local law enforcement. The clearest exits are south to [if Soda Club is visited]the Soda Club[else]a fly bar[end if] or back west to Down Ground."

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
	if jump-level > 0 and soda club is unvisited:
		say "The Stool Toad eyes you suspiciously. 'Don't know what you're up to, but ... it's something too clever for your own good. You--you cheated to get here, somehow.'" instead;
	if howdy boy is in lalaland:
		say "You had your 'fun,' or an attempt at it, anyway. You don't want to go [if soda club is visited]back there[else]anywhere too crazy[end if].";
	if soda club is unvisited:
		say "You look over your shoulder at the Stool Toad. 'I can't stop you, young man. But you keep your nose clean!' he shouts.";

check going nowhere in Joint Strip:
	unless trail paper is off-stage:
		say "You don't want to attract the Stool Toad's attention, now that you've gotten enough ticketies." instead;
	if off-the-path is true:
		say "The repeat offense will get you shipped off." instead;
	say "[one of]The Stool Toad booms 'Where you going, son? There's degenerates hiding that way! That's a warning!' You consider asking him why he doesn't go hunt them down, but you don't have the guts.[or]The Stool Toad blathers something about a final warning, because he sees you trying to sneak off.[or][toad-write-up][stopping]";
	the rule succeeds;

off-the-path is a truth state that varies.

to say toad-write-up:
	say "The Stool Toad, so passive with all the suspicious smells around, leaps into action as you seek them out for yourself. He writes you up for jaywalking, all the while muttering that stupid laws prevent him from writing you up for more.";
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

description of Minimum Bear is "[if minimum bear is not examined]Aww, isn't that cute? A tag reveals its name to be Minimum Bear. Well, it's not that cute. Only just cute enough to make you go aww. Or want to[else]It's just bear-ly cute enough. Ba boom boom[end if]. Only someone completely unworried about aesthetics, or terribly caught up in nostalgia and/or bizarre aesthetics, could fully love poor Minimum Bear."

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

the Stool Toad is an enforcer in Joint Strip. "[one of]Ah. Here's where the Stool Toad went. He's sitting on a stool--shaped like a pigeon, of course.[paragraph break]'So! The new juvenile from Down Ground. Best you stay out of [if tix-adv > 0]further [end if]trouble.'[or]The Stool Toad, sitting on his pigeon stool, continues to eye you [tix-adv].[stopping]"

check talking to toad when trail paper is not off-stage:
	say "You don't want to let anything slip that could get you in further trouble, with all the boo-ticketies you accumulated." instead;

to decide what number is tix-adv:
	if fritz has minimum bear, decide on your-tix - 1;
	decide on your-tix;

to say tix-adv:
	say "[if tix-adv is 0]patronizingly[else if tix-adv is 1]somberly[else if tix-adv is 2]suspiciously[else]oppressively[end if]"

description of the Stool Toad is "Green, bloated and, oh yes, poisonous. He reminds you of a security guard at your high school whose every other sentence was 'YOUNG MAN!'"

the pigeon stool is scenery in Joint Strip. "It's shaped like a curled up pigeon, though its head might be a bit too big and flat. It's kind of snazzy, and you'd actually sort of like one. You read the words SUPPORT MORAL on it and feel immediately depressed."

does the player mean doing something with the stool toad when player is in joint strip: it is unlikely. [more likely to use stool as a noun and all that]

instead of doing something with pigeon stool:
	if action is undrastic:
		continue the action;
	say "Since it's under the Stool Toad, there's not much you can do with it."

toad-got-you is a truth state that varies.

check going north in Soda Club:
	if player has a drinkable:
		if toad-got-you is false:
			say "'HALT! FREEZE! A MINOR WITH ALCOHOL!' booms the Stool Toad. He takes your drink and throws it off to the side. 'THAT'S AN INFRACTION!'[paragraph break]He looks around in his pockets but only finds a diagonal scrap of paper. 'Well, this'll do, for a boo tickety. Remember, you're warned.' You feel sort of rebellious--good rebellious--as he [if your-tix >= 4]counts your infractions on his fingers. Uh oh. Maybe you could've DROPped the booze before leaving[else]goes back to his pigeon stool[end if].";
			get-ticketed "taking alcohol out of the Soda Club";
			if player has haha brew:
				now haha brew is in lalaland;
			else:
				now cooler wine is in lalaland;
			activate-drink-check;
			now toad-got-you is true;
			do nothing instead;
		else:
			say "You can't go face the Stool Toad again. Not with the drink in your hand." instead;
	else:
		say "The Stool Toad looks you up and down as you exit. He nods. 'Better stay clean, or you'll get a boo tickety.'";

to activate-drink-check:
	if cooler wine is not in lalaland:
		choose row with response of sucker-cooler in table of Punch Sucker talk;
		now enabled entry is 1;
	if haha brew is not in lalaland:
		choose row with response of sucker-haha in table of Punch Sucker talk;
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
toad-joint	"'Of course not! But they would be if I weren't here! In fact, there's just something ABOUT this place. Worse turpitude might fester without my imposing presence.'"
toad-troub	"'[bad-toad].'"
toad-refresh	"'Y'mean you don't remember[one of][or], again[stopping]? [bad-toad].'"
toad-pomp	--
toad-bm	"'Well, he's a smart fella, but he still looks out for folks like me. Got me this position keeping order here. Said [bad-guy-2] wouldn't pay half as much. Plus the job satisfaction. Making people smarter than me feel dumb. Can't beat that. Asked my opinion on sedition laws the other day, too. Bad idea to start slanging [bad-guy] without proof even if you aren't kinda weird yourself. No offense.'"
toad-sedition	--
toad-bye	"'Don't do anything stupid. But don't go trying to be too clever, either.'"

litter-clue is a truth state that varies.

to say bad-toad:
	now litter-clue is true;
	say "Littering. Suppressing evidence of prior misconduct. Acting up in the bar. Minor in possession of alcohol. Aggravated loafing. Seeking out illicit activities. All manner of frog-bull[activation of bullfrog]"

after quipping when qbc_litany is litany of stool toad:
	if current quip is toad-hi:
		enable the toad-troub quip;
	if current quip is toad-troub:
		superable toad-refresh;
		enable the toad-pomp quip;
	if current quip is toad-bye:
		terminate the conversation;

part Soda Club

Soda Club is south of Joint Strip. It is in Outer Bounds. "Maybe if it were past 1 AM, you'd see passages west, south, and east, making this place the Total T--or maybe even the Party T--instead. But if it were past 1 AM, you'd probably be home and asleep and not here. Or, at least, persuaded to leave a while ago.[paragraph break]The only way out is north."

check going nowhere in Soda Club:
	say "There aren't, like, hidden bathrooms, and you wouldn't need to go even if there were. And if there's a secret passage, there's probably a secret code you don't know, too. So, back north it'll be, once you want to leave." instead;

section Liver Lily

Liver Lily is a female person in Soda Club. "[one of]A girl is here. She's--well, pretty attractive. And well-dressed.[or]Liver Lily waits here for intelligent, stimulating conversation.[stopping]"

Liver Lily wears the rehearsal dress.

description of dress is "It--well, it's one of those things you can't think of anything wrong to say about it. It's neither too tacky or dowdy. Yet it seems, to your unfashionable eye, a bit [i]comme il faut[r]."

instead of doing something with rehearsal dress:
	if action is undrastic:
		continue the action;
	say "In this game, you can pretty much only examine the dress."

after printing the locale description for Soda Club when Soda Club is unvisited:
	now Total T is in lalaland;
	now Party T is in Lalaland;
	say "The bartender calls you over. 'Psst! Pal! Can you give me a break from Liver Lily over there? She's--she's usually pretty interesting, but when she's wearing that rehearsal dress she tends to repeat what she's already said. By the way, you can call me the Punch Sucker. Cuz it's my favorite drink.'"

description of Liver Lily is "She is waiting for conversation in her rehearsal dress."

litany of Lily is the table of Lily talk.

table of ll - Lily talk
prompt	response	enabled	permit
"Um, er, yeah, hi, I'm Alec."	lily-hi	1	1
"Sure!"	lily-sure	0	1
"I guess."	lily-guess	0	1
"No."	lily-no	0	0
"..."	lily-wait	0	1
"Yeah, I'm in tune."	lily-tune	0	1
"Sorry, I'm not in tune."	lily-notune	0	1
"So is your life really that exciting, or do you just talk a lot?"	lily-exci	0	1
"So, where can I get practice interrupting people?"	lily-prac	0	1
"So, what about the [bad-guy]?"	lily-baiter	0	1
"[later-or-thanks]."	lily-bye	3	1

check talking to lily:
	if lily-done is true:
		enable the lily-prac quip;

table of quip texts (continued)
quip	quiptext
lily-hi	"'Oh, um, hi. Do you want to hear my exciting opinions on stuff?'"
lily-sure	"'Perfect!'[paragraph break][lily-sez]"
lily-guess	"'Well, give it a try!'[paragraph break][lily-sez]"
lily-no
lily-wait	"You're not sure if you nodded encouragingly enough, but Lily mutters something about your reaction to her controversial opinions being problematic. She mumbles something about not expecting anything in turn for her advice, and nothing personal, but she doesn't need you bringing her down, but you don't seem like a total jerk, so she hopes you find whatever you want, even if it'd be too boring for her. She even explains how you look like you need to interrupt people more. That would make you more exciting! But not, like, right away.[paragraph break]'So, am I making sense?'"
lily-tune	"[bye-lily of 2]'Well, you say you are, but few people GET in tune. Think about that a moment.'"
lily-notune	"[bye-lily of 2]'Well, I thought you were better than that. And don't expect an [']At least you were honest.[']'"
lily-exci	"'Well, if it is, it is, and if it isn't, you have to respect my imagination, my getting a lot out of a little.'"
lily-prac	"She blathers some general advice, and you're not sure whether it's a good idea to put that into practice before she finishes. She yawns once she's done. 'If you want a refresher, ask me again,' she offers, unconvincingly."
lily-baiter	"'Well, he's equally snarky to males and females. Is that equality, or is that equality?'"
lily-bye	"[if anything-said-yet is false][lily-creep][else]'Bye.'[end if]"

lily-warn is a truth state that varies.

to say lily-creep:
	if lily-warn is false:
		say "'If you don't actually say anything next time, I'll be a little creeped out. I might call someone in on you.'[no line break]";
		now lily-warn is true;
	else:
		say "'That's--just creepy,' she says. 'I didn't come to the bar for this.' The Punch Sucker blows a whistle, and the Stool Toad charges in.[paragraph break]He explains that this is pretty bad, seeing as how you looked like a nice kid, or at least a quiet one, and goes on some irrelevant diatribe against prank callers who just hang up, and also how if this is how you act SOBER...";
		if player has a drinkable:
			say "The Punch Sucker takes your drink away from you, too.";
			if player has haha brew:
				now haha brew is in lalaland;
			if player has cooler wine:
				now cooler wine is in lalaland;
		now lily is in lalaland;
		get-ticketed "being too awkward to speak in the Soda Club";

to say lily-sez:
	say "[bye-lily of 0]She starts off explaining how you are lucky to have met someone as exciting as her. She babbles on about the low quality and alcohol content of drinks in this place. You nod, but she notes you haven't even TRIED to interrupt, and how she used to never interrupt but she's learned there's a balance between not interrupting at all and interrupting too much, and you--you do want more balance in your life? You want to be more enthusiastic about life, don't you?'[no line break]"

to say bye-lily of (x - a number):
	choose row with response of lily-bye in table of lily talk;
	now enabled entry is x;

lily-done is a truth state that varies.

after quipping when qbc_litany is table of lily talk:
	if current quip is lily-hi:
		enable the lily-sure quip;
		enable the lily-guess quip;
		enable the lily-no quip;
	if current quip is lily-sure or current quip is lily-guess:
		disable the lily-sure quip;
		disable the lily-guess quip;
		disable the lily-no quip;
		enable the the lily-wait quip;
	if current quip is lily-wait:
		enable the the lily-tune quip;
		enable the the lily-notune quip;
	if current quip is lily-tune or current quip is lily-notune:
		disable the lily-tune quip;
		disable the lily-notune quip;
		enable the lily-prac quip;
		enable the lily-baiter quip;
		enable the lily-exci quip;
		now lily-done is true;
	if current quip is lily-bye:
		if lily-prac is talked-thru:
			enable the lily-prac quip;
		terminate the conversation;

to chase-lily:
	say "The Punch Sucker sidles over. 'Sorry, champ. Looks like you did something to chase off a good patron. By the moral authority vested in me by the [bad-guy], it is my pleasure and duty to issue a boo-tickety.'";
	now lily is in lalaland;
	get-ticketed "offering a sophisticated girl insultingly weak alcohol";

section Punch Sucker

A Punch Sucker is a baiter-aligned person in Soda Club. "The [one of]guy you guess is the bartender[or]Punch Sucker[stopping] bustles around, serving drinks to the customers."

check talking to punch sucker when lily is in lalaland and conv-left of punch sucker > 1:
	say "The Punch Sucker flashes you a fake smile. 'Still around? Well, I can't make you leave, and I sort of needed a break from her chatter, I guess. Eh, I've dealt with worse.'";

understand "bartender" as punch sucker.

description of Punch Sucker is "He bustles about, talking to the patrons, pouring drinks, flipping glasses and wiping the bar off, with the sort of false cheer you were dumb enough to believe was genuine."

litany of Punch Sucker is the table of Punch Sucker talk.

table of ps - Punch Sucker talk
prompt	response	enabled	permit
"What've you got, for drinks? Um, non-alcoholic?"	sucker-drinks	1	1
"Got any booze?"	sucker-alco	1	0
"What does On the Rocks mean, anyway? It SOUNDS way cool!"	sucker-onrocks	1	1
"But I'm not 21! Not even close!"	sucker-but	0	1
"I'll have the Haha Brew."	sucker-haha	0	1
"I'll have the Cooler Wine."	sucker-cooler	0	1
"What do you think of the [bad-guy]?"	sucker-baiter	1	1
"[later-or-thanks]."	sucker-bye	3	1

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
sucker-drinks	"'Well, you wouldn't be ready for the Rummy Gin or Go Rum. If we served it after-hours, of course. If we served it after-hours. But we have Haha Brew and Cooler Wine. Both so watered down, the Stool Toad won't nab you long as you drink it here.'"
sucker-alco	"'Haha. No.'"
sucker-onrocks	"He pushes a button on an unseen machine. You hear ice cubes rattle. He holds up a glass, swirls it, and nods meaningfully before putting it away."
sucker-but	"'Well, everyone here is a bit smarter and maturer than normal, and anyway, this isn't the high-proof stuff. Plus the Stool Toad, we've paid him off. As long as nobody makes it obvious and walks out with a drink. Then he's pretty awesome. So what the hey.'"
sucker-haha	"[here-or-not]"
sucker-cooler	"[here-or-not]"
sucker-baiter	"'The [bg] lets me stay open for very reasonable shakedown fees. Much better than [bad-guy-2], I'm sure. He just, well, he just wants to know about all the patrons in here. Why, he drops in here himself and gets the good stuff. But he's very fair and balanced. He knows it's not how much you drink but how it affects you. Why, he's better at shaming unruly customers than I am!'"
sucker-bye	"He goes back to mixing and serving drinks."

to say here-or-not:
	if player has cooler or player has haha brew:
		say "'HEY! Drink what you've got, first.'[no line break]";
		continue the action;
	else:
		if your-tix is 4:
			say "You pause for a second. You've got quite a record, already. You don't need a fifth tickety. No, you'd better play it cool.[no line break]";
			continue the action;
		say "'Coming right up!'[no line break]";
		if current quip is sucker-haha:
			now player has haha brew;
		else:
			now player has cooler wine;

after quipping when qbc_litany is litany of Punch Sucker:
	if current quip is sucker-drinks:
		move go rum to lalaland;
		move rummy gin to lalaland;
		enable the sucker-but quip;
		enable the sucker-haha quip;
		enable the sucker-cooler quip;
	if current quip is sucker-alco:
		if player has cooler wine:
			enable the sucker-haha quip;
	if current quip is sucker-cooler:
		if player has haha brew:
			enable the sucker-cooler quip;
	if current quip is sucker-haha:
		if player has cooler wine:
			enable the sucker-haha quip;
	if current quip is sucker-bye:
		terminate the conversation;

book main chunk

Main Chunk is a region.

part Jerk Circle

Jerk Circle is north of Pressure Pier. It is in Main Chunk. printed name of Jerk Circle is "[jc]". "[if silly boris is in lalaland]The only evidence the [j-co] were here is that the ground seems slightly trampled[else]Seven [j-co] stand in a circle (okay, a heptagon) here, talking to and about others[end if]. It looks like there's forested area to the west, a narrow valley to the east, and things open up to the north. Nothing's stopping you going back south in this crossroads, either."

check going south in jerk circle (this is the block pier in endgame rule):
	if bros-left is 0:
		say "No. You don't need to go back. You're close to what you need to do." instead;

to say jc:
	say "[if allow-swears is true]Jerk Circle[else]Groan Collective[end if]"

Dandy Jim is a client. clue-letter of Dandy Jim is "J". description is "He's well dressed, but not some yuppie or preppie or anything."

Silly Boris is a client. clue-letter of Silly Boris is "L". description is "He's not laughing at you, he's laughing at the thought you might be important enough to laugh at."

Wash White is a client. clue-letter of Wash White is "T". description is "He seems to spend a good deal of time protesting what he didn't say."

Warner Dyer is a client. clue-letter of Warner Dyer is "D". description is "His favorite phrase is a knowing 'Oh, I don't know about that.'"

Warm Luke is a client. clue-letter of Warm Luke is "M". description is "Smiling a bit too wide, saying sure a bit too often."

Paul Kast is a client. clue-letter of Paul Kast is "K". description is "Dressed darkyl and frowning."

Cain Reyes is a client. clue-letter of Cain Reyes is "*". description is "The loudest of the bunch."

the bottle of Quiz Pop is a thing. "The [j-co] left a bottle of Quiz Pop here.". description is "It's typical ucky brown for pop, though it is fizzing furiously. The label proclaiming it Quiz Pop reveals no nutritional information, which may be for the better. It also provides a warning that it is therapeutic for people who don't always ask the questions they want to, but people who already ask loaded questions are at risk. It's from Mark Black industries."

understand "soda" as Quiz Pop

does the player mean drinking Quiz Pop: it is very likely.

after examining Quiz Pop:
	now black mark is in lalaland;
	continue the action;

to say j-co:
	say "[if allow-swears is true]jerks[else]groaners[end if]"

the seven jerks are scenery in jerk circle. "[if know-jerks is true][jerk-list].[else]You can't tell who they are, and they don't offer their names.[end if]"

know-jerks is a truth state that varies.

understand "jerk" as jerks when player is in jerk circle and know-jerks is false.

understand "jerk" as a client when player is in jerk circle and know-jerks is true.

understand "circle/heptagon" as jerks.

before talking to a client:
	if know-jerks is false:
		say "You feel a bit over-familiar. Maybe if you talk to all the jerks, you'll get a formal introduction." instead;

before talking to jerks:
	if finger is not examined:
		say "You don't have any reason to want to deal with that many jerks. At least not now." instead;
	if know-jerks is true:
		say "You should really pick an individual jerk to talk to, now you know their names." instead;
	say "You give a vague 'Hi, guys,' and are assailed by the [j-co] saying, geez, we have names, you know, and all that sort of thing. They are: [jerk-list].";
	now know-jerks is true instead;

for writing a paragraph about a client (called jrk) in Jerk Circle:
	if cookie-eaten is true:
		say "Pfft. None of the [j-co] look like they really know what's what. If they did, they'd be the ones in charge, not the [bad-guy].";
	else if off-eaten is true:
		say "Pfft. A clique of [j-co]. Almost as boring as the [bad-guy].";
	else if greater-eaten is true:
		say "Pfft. Look at those [j-co]. They don't have the initiative the [bad-guy] does.";
	else if finger is not examined:
		say "The seven [j-co] are too intimidating now. Even two people conversing, that's tough to break in the middle of, much less seven.";
	else:
		say "[one of]The jerks, again. Wait a minute. Seven jerks, talking about being cool, seven 'clients' for the Labor Child. Could it be...? You ask if they know about the Labor Child. Once it's established you hate him, they're relieved.[or]The [j-co] continue to talk about what's cool and what's not.[stopping]";
	now all clients are mentioned;

to say jerk-list:
	say "[list of clients in jerk circle]";

last-jerk is a person that varies.

before talking to a client:
	say "Notes in hand, you realize you can THINK about what you saw on the finger index at any time. You also may want to LISTEN to see if everyone is getting demoralized after you move on to the next jerk. You can, of course, UNDO that, too, and I won't judge.";
	now last-jerk is noun;
	try talking to generic-jerk instead;

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
"So, I hear you like all the vegetables, even gross ones."	jerk-veg	0	1
"So, that clean comedian so popular last year? Still like him, eh?"	jerk-comedian	0	1
"So, I hear you like light music. Not just by pretty women."	jerk-light	0	1
"So, you're a little better at chess than is practical for smart kids."	jerk-chess	0	1
"So, hear you secretly like that lousy pro sports team."	jerk-pro	0	1
"So, you definitely don't wear colored underwear. Right?"	jerk-undies	0	1
"So, reread [i]Anne of Green Gables[r] lately?"	jerk-anne	0	1
"So, you big on violent games? Or not?"	jerk-video	0	1
"So, Mr. Rogers. Does he conquer the basics, or what?"	jerk-rogers	0	1
"So, you wouldn't be ashamed of driving a clunker?"	jerk-car	0	1
"So, do women's sports really have better fundamentals?"	jerk-wsport	0	1
"So, what sort of glossy magazines do you read?"	jerk-zines	0	1
"(bug the next [j-g])"	jerk-next	0	1
"So, what about the [bad-guy]?"	jerk-baiter	1	1
"[later-or-thanks]."	jerk-bye	3	1

to say j-g:
	say "[if allow-swears is true]jerk[else]groaner[end if]"

a client has a client called next-c.

table of fingerings
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

table of quip texts (continued)
quip	quiptext
jerk-hows	"[last-jerk] regards you stonily. 'I'm talking with my friends here! Unless you have something REALLY important to say...'"
jerk-veg	"[innue]."
jerk-comedian	"[innue]."
jerk-light	"[innue]."
jerk-chess	"[innue]."
jerk-pro	"[innue]."
jerk-undies	"[innue]."
jerk-anne	"[innue]."
jerk-car	"[innue]."
jerk-rogers	"[innue]."
jerk-video	"[innue]."
jerk-wsport	"[innue]."
jerk-zines	"[innue]."
jerk-next	"You move on to [next-c-x of last-jerk]."
jerk-baiter	"Everyone chimes in. Oh, does the [bad-guy] know his cultural references! And oh, how they respect him for knowing more culture despite the intensity of working up north in Freak Control to keep [bad-guy-2] at bay! They are pretty sure [bad-guy-2] wouldn't allow seven people to assemble in one place so freely."
jerk-bye	"[last-jerk] turns away and goes back to talking to his buddies."

to decide which client is next-c-x of (cli - a client):
	let G be next-c of cli;
	while G is befriended:
		let G be next-c of G;
		if G is cli:
			say "(oops, bug, should not have cycled back, report to [email]) ";
			decide on cli;
	decide on G;

to say innue:
	say "You mutter an accusation that could destroy [last-jerk]'s social life"

check going when player is in jerk circle:
	if room noun of jerk circle is not nowhere and silly boris is in jerk circle:
		if jerks-scared > 0:
			say "You have a sense the [j-co] may be a bit vulnerable. Stay and take them?";
			if the player consents:
				say "OK." instead;
			say "The jerks begin talking more confidently as you leave.";

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

after quipping when qbc_litany is table of generic-jerk talk:
	let cq be current quip;
	if current quip is jerk-hows:
		continue the action;
	if current quip is jerk-next:
		if jerk-close-listen is true:
			if jerks-scared < 2:
				say "The [j-co] sound about the same. Maybe you need to scare a couple of them in a row before they get quieter.";
			else if jerks-scared is 2:
				say "The [j-co] seem a bit quieter now.";
			else if jerks-scared is 4:
				say "[line break]The [j-co] seem quiet now.";
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

to reset-the-table:
	d "WRONG!";
	say "[last-jerk] snickers noncommitally.[line break]";
	if jerk-close-listen is true:
		if jerks-scared >= 2:
			say "[line break]The [j-co]['] conversation ratchets back up to full volume. You must've made the wrong accusation.";
	increment wrongalong;
	if wrongalong is 10:
		say "[line break]You remember[one of][or], again,[stopping] the finger index's advice. If you push someone twice, and you're right, it may make them lash out.";
		now wrongalong is 0;
	reset-fingerings;

to check-jerks-done:
	d "RIGHT!";
	say "[last-jerk] snickers noncommitally.";
	repeat through table of fingerings:
		if suspect entry is 0:
			continue the action;
	say "[line break]The other six jerks, fully chastened by your observations, overhear what you have to say. They pile on [last-jerk], but you mention he's not the only one. A fight's about to break out, until you tell them where you got this information from.[paragraph break]'You better be right about this,' [a random client] says. They rush off. You hear whining in the distance. It's the Labor Child. He protests he was just trying to shame them into doing more practical things!";
	say "[line break]The (ex-)jerks arrive back, and [a random client] hands you a bottle of Quiz Pop. 'Man, you seem to know what's what, and you helped us see it was okay to be us. Here's some totally sweet contraband.'";
	now player has quiz pop;
	increment the score;
	now all clients are in lalaland;
	unlock-verb "notice";
	terminate the conversation;

check going north when player is in well:
	if silly boris is in lalaland:
		say "[one of]Before you enter, you hear the Labor Child squealing how this all can't be legal and he knows people. Various jerks express interest at this confidential document or that and relief they never stooped that low. It looks like they are uncovering other of the Labor Child's 'business interests,' and they don't need you. Nothing violent is happening, and you enjoy some schadenfreude at the Labor Child's expense before deciding to move on.[or]No, you don't need or want to help the jerks. The Labor Child's in for it enough.[stopping]" instead;

chapter jerk talking

part Chipper Wood

Chipper Wood is west of Jerk Circle. It is in Main Chunk. "The path cuts east-west here, the wood being too thick elsewhere. [if chase paper is in wood][say-paper][else]You can go down where the chase paper was[end if]."

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
		now noun is scen-home;
	continue the action;

check going in chipper wood when p-c is false:
	if noun is north or noun is south:
		say "The wood's too thick that way." instead;

after going when player was in chipper wood and assassination character is in chipper wood:
	say "'Oops, maybe some other time,' the Character's taunt echos.";
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
		say "The assassin is at [ac-x], [ac-y] on the grid from 0, 0 southeast to 12, 12. You are at [you-x], [you-y].";
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
		say "You--well, walking diagonally is about as fast as walking on the paths, but the Pythagorean theorem and all means you don't quite make it to the next grid point before the Character does. Hmm.";

check going when p-c is true (this is the move on paper rule):
	now last-p-dir is noun;
	if noun is west:
		if you-x >= 3:
			now you-x is you-x - 3;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is east:
		if you-x <= 9:
			now you-x is you-x + 3;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is north:
		if you-y >= 3:
			now you-y is you-y - 3;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is south:
		if you-y <= 9:
			now you-y is you-y + 3;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is northwest:
		if you-y >= 2 and you-x >= 2:
			diag-check;
			now you-y is you-y - 2;
			now you-x is you-x - 2;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is northeast:
		if you-y >= 2 and you-x <= 10:
			now diag-yet is true;
			now you-y is you-y - 2;
			now you-x is you-x + 2;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is southwest:
		if you-y <= 10 and you-x >= 2:
			now diag-yet is true;
			now you-y is you-y + 2;
			now you-x is you-x - 2;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	if noun is southeast:
		if you-y <= 10 and you-x <= 10:
			now diag-yet is true;
			now you-y is you-y + 2;
			now you-x is you-x + 2;
			move-assassin;
			see-if-caught;
		else:
			say "You'd go off the edge of the chase paper." instead;
	the rule succeeds;

to move-assassin:
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
		d "1.";
		if ac-y < 12:
			now ac-y is ac-y + 3; [move south]
		else:
			east-or-west-rand;
	else if you-y > ac-y:
		d "2.";
		if ac-y > 0:
			now ac-y is ac-y - 3; [move north]
		else:
			east-or-west-rand;
	else if you-x > ac-x:
		d "3.";
		if ac-x > 0:
			now ac-x is ac-x - 3; [move west]
		else:
			north-or-south-rand;
	else if you-x < ac-x:
		d "4.";
		if ac-x < 12:
			now ac-x is ac-x + 3; [move east]
		else:
			north-or-south-rand;
	else:
		say "BUG! Assassin did not move.";
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
	else if assassin-in-corner and you-near-assassin:
		now p-c is false;
		print-the-grid;
		say "You've backed the assassin into a corner![paragraph break]'Okay! Okay! Don't get violent or anything!' He accuses you of not being able to take a joke.";
		bye-paper;
	else:
		if assassin-in-corner and corner-yet is false:
			say "He does love to run for the corner. If you could just get one up-and-over from him, you bet you could freeze him.";
			now corner-yet is true;

to bye-paper:
	say "[line break]As he begins rolling up the chase paper, he asks if you're one of those odd brainy types who might know how to fill up a chessboard with 31 tiles. Well, you take the opposite corners off...[paragraph break]";
	wfak;
	say "You show him the solution, and he starts yelling about how nobody could have figured that out for themselves unless they really have nothing to do with their time. As he runs off, he raves about how the hint below won't really help you with anything you couldn't figure out yourself, and besides there's another worse puzzle below only weird people would enjoy, and...[paragraph break]Hey, wait, you sort of enjoy weird puzzles. Not sure if you're up for it right now, but eh, something to do if you bog down up here.";
	open-below;
		
to open-below:
	now assassination character is in lalaland;
	now chase paper is in lalaland;
	now belt below is below chipper wood;
	now chipper wood is above belt below;

to decide whether assassin-in-corner:
	if ac-x is 0 and ac-y is 12:
		decide yes;
	if ac-x is 12 and ac-y is 0:
		decide yes;
	if ac-x is 0 and ac-y is 0:
		decide yes;
	if ac-x is 12 and ac-y is 12:
		decide yes;
	decide no;

to decide whether you-near-assassin:
	unless ac-x - you-x is 3 or ac-x - you-x is -3:
		decide no;
	unless ac-y - you-y is 3 or ac-y - you-y is -3:
		decide no;
	decide yes;


p-c is a truth state that varies.

the Assassination Character is a baiter-aligned person in Chipper Wood. initial appearance is "[if player was in chipper wood]The Assassination Character sticks his tongue out, daring you to catch him.[else][as-char][end if]"

description of Assassination Character is "He's--he's actually shorter and fatter than you, and that makes you sort of jealous he's better at insults than you, too. Then you think maybe he had to be, and you wonder how people treated hi... 'Geez! Quit starin['], you freak!'"

check talking to assassination character:
	if p-c is true:
		say "You aren't going to win a taunting war. You wonder if getting under the paper chase is really worth it. He said it wasn't NECESSARY. But he also said there might be a big help." instead;
	else:
		say "You've got no chance of winning an insult war. But maybe if you catch him on the Chase Paper...he said he might help you. Or help you get close to help. Probably the second." instead;

check going inside when player is in chipper wood and p-c is false:
	if chase paper is in wood:
		try entering chase paper instead;

to say wfk:
	wfak;
	say "[line break]";

to say as-char:
	say "[one of]You hear a rustle from behind. Someone slaps you on the left side of your neck--you look there but see no-one. Then you look right. Ah, there. You STILL hate when people do that.[paragraph break]'Hey. It's me, the Assassination Character. You can call me AC for short (aren't I swell? The [bg], err, [bad-guy], won't let me. I mean, you)--what're you? AS? No, not as catchy. Don't worry, I could make plenty of names for you.' He tries a few, guessing your middle name is Sheldon or Steve, and you rush at him, and he snickers.[wfk]'Temper, temper. Well, if you're not a lazy quitter, there's a cheat below.'[wfk]'Cheat?'[paragraph break]'Oop! Interested, eh? Guess you're not perfectly honest. Just ENTER the chase paper and give it a try. UNLESS YOU'RE CHICKEN.'[paragraph break]You wonder why you wouldn't fall through the chase paper if there was nothing under there, but the AC probably has an annoying response for that.[no line break][or]The Assassination Character springs out of nowhere again, asking whether you are too chicken to get on the chase paper or maybe you want to be lazy and cheat but you're scared you'll fail.[no line break][stopping]"

does the player mean entering the chase paper: it is likely.

understand "ac" and "char" and "ass" and "assassin" and "assassin character" as the Assassination Character.

part Disposed Well

Disposed Well is west of Chipper Wood. It is in Main Chunk. "A crumbling well is here. You may go west to some sort of church or back east to the Chipper Wood. To the north, [if boris is in lalaland]the Scheme Pyramid has been boarded up[else if pyramid is visited]the Scheme Pyramid[else]a business[end if]. There's also a small home you could go inside."

scen-home is privately-named scenery in disposed well. "[if truth home is visited]There's no evidence of the Logical Psycho's ramblings from outside[else]It looks safe enough to go into[end if]."

understand "home" as scen-home.

instead of doing something with scen-home:
	if action is undrastic:
		continue the action;
	if current action is entering:
		try going inside instead;
	say "You can't do much except enter or examine the home."

scen-church is privately-named scenery in disposed well. "[if truth home is visited]Faith and Grace Goode would welcome you back[else]It looks safe enough to go into[end if]."

understand "church" as scen-church.

instead of doing something with scen-church:
	if action is undrastic:
		continue the action;
	if current action is entering:
		try going inside instead;
	say "You can't do much except enter or examine the church."

check going nowhere in well:
	if noun is down:
		say "You have no way back up." instead;
	say "The wood is too thick to the south." instead;

the nine yards hole is scenery in Disposed Well. "It looks rather deep, too narrow to climb, [if story fish is off-stage]but maybe you could find something in it[else]and you doubt there's anything else in there[end if]."

understand "disposed/well" as the yards hole.

the story fish is a thing. description of story fish is "[if player has story fish]It looks wooden and mechanical[else]The story fish has been stuffed into the book bank here[end if]."

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
		now player has story fish;
		say "You pull the string down. It seems to take forever. But you wait. You feel a pull on the string. You tug--and--yes! Your catch stays with the string! You're not surprised it's a fish, but you are when it talks--and it explains it wanted to be caught, so it could tell others its story! You suffer through ten minutes of digressions and bad grammar before the fish takes a break. 'You don't seem to be appreciating me right now. Show me someone who does, then TALK to me.'";
		increment the score instead;
	if second noun is yards hole:
		say "That'd be a good way to lose stuff." instead;

before talking to story fish:
	if player is in truth home and psycho is in truth home:
		say "'NONSENSE!  FACTS, FACTS, FACTS!' roars the Psycho. The fish clams up after the tide of abuse leaves it all at sea." instead;
	if player is in standard bog:
		say "'Eh? I--I would tell my story, but the computer wouldn't appreciate it. Manufactured stuff. Mine is ORIGINAL.'" instead;
	if player is not in Discussion Block:
		say "The fish opens a sleepy eye. 'Eh? Anyone here? Nope, nobody artsy.'" instead;
	if art fine is in Discussion Block:
		say "The fish eyes you sleepily but then sees the bookshelf, then Art Fine. 'Ah! Good sir! May I begin!' The fish's story is much funnier this time, and a bit shorter, too, because Art barely lasts five minutes before he runs away screaming. You pat the fish on the head and put it in the bookshelf.[paragraph break]";
		now art fine is in lalaland;
		now story fish is in Discussion Block;
		say "[if harmonic phil is in Discussion Block]Harmonic Phil snickers. 'Well, Art was smart and all, but he was getting kind of boring anyway. And he didn't know a THING about music.'[else]Well, that's Phil AND Art gone.[end if]";
		increment the score instead;
	say "[if harmonic phil is in Discussion Block and player is in Discussion Block]Harmonic Phil hums loudly over the sound of the fish talking. You'll need to ... fish for another way to get rid of Phil.[else]'Eh? Where'd everyone go? I'll wait [']til there's a crowd to tell my story.'[end if]";
	the rule succeeds;

part Truth Home

Truth Home is inside of Disposed Well. It is in Main Chunk. It is only-out. "Nothing feels wrong here, but it feels incredibly uncomfortable. It's also a small home, with the only exit back out."

for writing a paragraph about a person (called arg) in Truth Home:
	say "[one of]A large guy berates a much smaller guy here. 'Proof fool! Proof fool! You need some emotion in your life! You just don't want to admit you're jealous of the jumps I can make! Me, the Logical Psycho!'[or]The Logical Psycho continues to berate the Proof Fool.[stopping]";
	now Proof Fool is mentioned;
	now Logical Psycho is mentioned;

section Logical Psycho

the Logical Psycho is a baiter-aligned person in Truth Home. description is "He is wearing a t-shirt with an old car on it."

understand "large" and "large guy" as Psycho when player is in Truth Home.

check talking to Logical Psycho:
	say "'Oh yeah, sure, I bet you have interesting questions. But I've probably heard [']em all before. And I'm giving interesting answers to questions you didn't need to know yet. You might want to just listen.' [weird-hyp]" instead;

section Proof Fool

the Proof Fool is a surveyable person in Truth Home.

understand "small" and "small guy" as Proof Fool when player is in Truth Home.

check playing the rattle:
	if player is in truth home:
		say "The Logical Psycho looks worried for a second, but goes on. Hm. You interrupted one of his rants, but not at the right time. Maybe someone who understood them better, but just didn't have the guts to speak back, could use the rattle. Who could that be, now." instead;
	if number of people in location of player > 1:
		say "You don't know if it's worth deliberately annoying anyone here." instead;
	say "Rattle, rattle." instead;

description is "When he's not trying to wave off the Logical Psycho's arguments, he's grabbing his head with his hands."

check talking to proof fool:
	say "Before the Fool can talk, the Psycho cuts in. 'Quit distracting him! Y'got anything as interesting and profound to say as me? Well, you couldn't say it right, anyhow,' he roars. [weird-hyp]" instead;

to say weird-hyp:
	say "The Psycho's voice is weirdly hypnotic and rhythmic, for all its bluster. How to cut into it? You could never win an argument."

The Trade of Tricks is a proper-named thing. description is "[one of]You got laughed at enough for reading, much less re-reading, in middle school, so you learned to cut that nonsense out--especially books you just liked. Because it was easier to get caught if you were absorbed in a book. But this--you can't help yourself. You earned this book. You feel like the lessons may not sink in for a few days, but all the same--man! You learned a lot! And you feel like sharing.[or]You pick up a few more tricks re-reading. But you realize others may need the book even more than you.[stopping]"

part Bottom Rock

Bottom Rock is a room. It is in Main Chunk. "You've reached a rock chamber. It's not possible to go any further down, or, in fact, any direction other than up."

check going nowhere in bottom rock:
	say "You can only go back up." instead;

the note crib is a thing in Bottom Rock. it is fixed in place. "[one of]A crib barred by musical notes--it must be a notes crib--[or]The notes crib [stopping]stands here. [if Legend of Stuff is in crib]It contains two small papers: a small flipbook entitled Legend of Stuff, and a crocked half[else]It's empty, now[end if]."

understand "musical notes" as note crib. understand "notes" and "notes crib" as note crib. understand "odd" and "odd crib" as note crib.

description of note crib is "[if Legend of Stuff is in crib]It contains a flipbook called Legend of Stuff and a crocked half. Each looks written on, but you can't make out what's on it[else]Nothing now[end if].".

check entering crib:
	try sleeping instead;

report taking a hintable:
	say "As you take the [noun], the note crib schlurps up the [random not carried hintable]. Well, you're still up one hint, net. You hope.";
	now random not carried hintable is in lalaland;
	continue the action;

before examining a hintable (this is the fuzz out but hint taking rule):
	if noun is in note crib:
		say "[if noun is crocked half]It's got a pattern on it, but you'd need to take it to see it more closely.[else]It's weird--the details shift from things you remember: that looked like the word weasel, this looked like the Stool Toad--who knows what else it'd look like if you decided to TAKE it?[end if]" instead;

section Legend of Stuff

the Legend of Stuff is a hintable. it is in the Note Crib.

Include (-
	has transparent talkable
-) when defining Legend of Stuff.

understand "flipbook" and "flip book" and "flip/book" as Legend of Stuff.

stuff-talk is a truth state that varies.

check taking legend of stuff when Thoughts Idol is in lalaland:
	say "You hear a very low voice tell you to feel very very guilty for taking the Legend of Stuff for puzzles easier than getting rid of the Thoughts Idol. A voice...like you'd expect from the Thoughts Idol. Which you just destroyed. You imagine NOT taking the Legend of Stuff and hearing the Idol also asking if you're too good to ask for help, and--well, that does it.";

check examining the Legend of Stuff:
	if bros-left is 0:
		if silly boris is in jerk circle:
			say "As you flip through the Legend of Stuff, you notice two identical pages, of a stick-figure is asking the second stick-figure the same question twice. The second response is nervier.'" instead;
		say "The Legend of Stuff has nothing new to offer." instead;
	say "The Legend of Stuff seems to be in roughly three parts: a red section, a blue section, and a section as big as the other two combined. Which section do you wish to look at? Or would you like to look at them all?";
	try talking to the Legend of Stuff instead;

check taking the note crib:
	say "You can take notes and maybe crib notes, but you can't take the crib." instead;

check talking to Legend of Stuff:
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
stuff-bye	"Nah, you don't want any hints just now."

already-clued is a truth state that varies.

last-clue is a number that varies;

after quipping when qbc_litany is table of Legend of Stuff talk:
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
		say "Give the mind of peace to Brother Blood.";
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
		say "You see yourself picking up a big square object--a safe, maybe[if hold is unvisited]. The surroundings aren't familiar[end if].";
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

the crocked half is a hintable. it is in the Note Crib. "A crocked half of a paper is here, ready to blow away. You'd better take it quickly, if you want it."

description of the crocked half is "It's half-a-square and seems to be torn at the bottom, as if, well, there were another part."

to say stars:
	say "   *     *[line break]";

to say upper:
	if screen-read is false:
		say "[fixed letter spacing][stars]   |\   /|[line break]
   | \ / |[line break]
*--*--*--*--*[line break]
 \ | / \ | /[line break]
  \|/   \|/[line break][stars][variable letter spacing]";
	else:
		say "The paper is ridged in a clear pattern--there's a straight line across, and each quarter is a leg of an isosceles right triangle: in order, below, above, above and below."

part The Belt Below

There is a room called The Belt Below. It is in Main Chunk. "You're in a cylindrical sort of room where the walls are shaped like a belt--yes, a bit even comes out like a buckle[if insanity terminal is in belt]. [one of]And look, there's a sort of odd faux-retro mainframe-ish computer[or]The Insanity Terminal waits for your answer[stopping][end if]."

check going nowhere in belt below:
	say "You can only go back up[if terminal is in belt], or maybe beating the terminal will lead elsewhere[else] or down[end if]." instead;

The Insanity Terminal is scenery in the Belt Below. description is "[bug]";

understand "puzzle" as terminal

after printing the locale description when player is in belt below and belt below is unvisited:
	say "'ATTENTION RECOVERING NERDLING!' booms the terminal. 'I THE INSANITY TERMINAL HAVE A CHALLENGE FOR YOU! IF YOU SOLVE IT, KNOWLEDGE UNIMAGINABLE WILL BE YOURS AND IT WILL BE ESPECIALLY VALUABLE IF YOU ARE UNIMAGINATIVE.'";
	say "[line break]You have a look, and -- well, it's about the oddest puzzle you've ever seen.";

jerks-spoiled is a truth state that varies.

check examining the insanity terminal:
	if jerks-spoiled is true:
		say "The terminal spits out who's 'guilty' of what, again:[line break]";
		repeat through table of fingerings:
			say "[jerky-guy entry]: [blackmail entry][line break]";
		the rule succeeds;
	if know-jerks is true:
		say "You look at the Insanity Terminal. It's big on logic puzzles, like the one you're struggling with, with the [j-co]. Maybe you could program it. Give it a shot?";
		if the player consents:
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
	say "There's a cursor, and you can probably just type out the right answer on, uh, the cursor before YOU. Convenient!" instead;

to say ps:
	say "[if screen-read is true] [else])[end if]"

table of quiz lines
qline
"1. How many times is one answer the same as the previous? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"2. How many letters appear in more than one right answer? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"3. The first answer with A is a[ps]1 b[ps]2 c[ps]4 d[ps]5 e[ps]7 f[ps]8"
"4. How many questions have A's as correct answers? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"
"5. This answer is a mirror image (A/F, B/E, C/D) of which other answer? a[ps]6 b[ps]5 c[ps]4 d[ps]3 e[ps]2 f[ps]1"
"6. The right answer to this question is a[ps]a b[ps]b c[ps]c d[ps]d e[ps]e f[ps]f"
"7. At least one of each letter is a correct answer a[ps]false b[ps]false c[ps]true d[ps]false e[ps]false f[ps]false"
"8. How many questions have vowels as correct answers? a[ps]0 b[ps]1 c[ps]2 d[ps]3 e[ps]4 f[ps]5"

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
		say "[one of]The Insanity Terminal emits an ultrasound squeal that brings you to your knees. It's probably mad you made it solve the jerks for you and doesn't believe you solved its harder puzzle on your own. Or rather, its calculations lead it to suspect cheating[or]Nah. You don't want the Terminal to squeal at you again (note: on winning, you'll get a code where you can solve the terminal the right way and see what's below)[stopping]." instead;
	if Insanity Terminal is in Belt Below:
		open-bottom;
		say "You hear a great rumbling as you put on -- well, a bad face -- and the Insanity Terminal cracks in half to reveal a tunnel further below. You feel like you could face a bad...well, you're not sure. But something bad.";
		now player has a bad face;
		now face of loss is in lalaland;
		the rule succeeds;
	else:
		say "You already solved the puzzle. If any more of [if bottom rock is visited]Bottom Rock[else]the floor[end if] collapsed, you might not have a way back up." instead;
	the rule succeeds;

to open-bottom:
	now Bottom Rock is below Belt Below;
	now Belt Below is above Bottom Rock;
	now Insanity Terminal is in lalaland;

part Classic Cult

Classic Cult is west of Disposed Well. It is in Main Chunk. "Light OMs can be heard all over. The lighting, the decor--it's too much like a classic cult, which means it's fooling nobody, which is why you're not surprised there are only two people here, and there are no exits except back out.[paragraph break]A googly bowl rests here, [if fourth-blossom is in lalaland]full of blossoms[else]three-quarters full of blossoms[end if]."

check going nowhere in Classic Cult:
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
	say "Sacrilege." instead;

to get-mind:
	say "Faith and Grace place the blossom and spin it, and when it slows, the flowers are changed so you can't remember which was which. 'This is the least we can do for you. Have this mind of peace.' It's beautiful, but not gaudy.";
	now player has mind of peace;
	now fourth-blossom is in lalaland;
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

does the player mean talking to Grace when player is in Cult: it is very likely.

litany of grace is the table of Grace Goode talk.

table of gg - Grace Goode talk
prompt	response	enabled	permit
"Hi. I'm -- well, I'm looking for something. Uh, not religion."	grace-hi	1	1
"What's wrong with the googly bowl?"	grace-googly	0	1
"But if I restore your cult, won't you just indoctrinate people?"	grace-restore	0	1
"Why doesn't the [bad-guy] approve?"	grace-baiter	0	1
"[later-or-thanks]."	grace-bye	3	1

table of quip texts (continued)
quip	quiptext
grace-hi	"'That is no matter,' they reply in unison. 'You are welcome here. Whether or not you are the one to repair our Googly Bowl.'"
grace-googly	"'It only contains three of the four vital elements it needs to create transcendent happiness, or at least provide relaxing aromas, so it is useless. The metaphysics would take too long to explain, but trust us.'"
grace-restore	"'Nonsense. We are not very charismatic. Nowhere near as charismatic as the [bad-guy]. Really, we just sit around and enjoy classic movies or cult movies without making too many snarky comments. But that's out of favor, thanks to the [bad-guy].'"
grace-baiter	"'Well, he thinks it's a pretty weenie way to be smart, or enjoy things. Something about how people should try to make their lives almost as exciting as his, but not as exciting--that'd be like sacrilege against intellect or something. How being nice is nice and all, but...'"
grace-bye	"'Fare well in your journeys.'"

after quipping when qbc_litany is litany of grace:
	if current quip is grace-hi:
		superable grace-googly;
	if current quip is grace-googly:
		enable the grace-restore quip;
	if current quip is grace-hi:
		enable the grace-baiter quip;
	if current quip is grace-bye:
		terminate the conversation;

chapter Mind of Peace

the mind of peace is a thing. description is "Looking into it, you feel calmer. Better about past put-downs or failures, whether or not you have a plan to improve. Yet you also know, if it helped you so easily, it may be better for someone who needs it even more.[paragraph break]I suppose it could also be a Trust Brain. Ba ba boom."

after examining mind of peace:
	now trust brain is in lalaland;
	continue the action;

understand "trust brain" and "trust/brain" as mind of peace.

part Scheme Pyramid

Scheme Pyramid is north of Disposed Well. It is in Main Chunk. "A gaudy, pointy-ceilinged room with exits north and south. Everything twinkles and shines. [one of]An odd hedge[or]The Fund Hedge[stopping] drips with all forms of currency, but you [if money seed is off-stage]are probably only allowed to take the cheapest[else]already got something[end if]."

check going nowhere in scheme pyramid:
	say "This room is north-south. Maybe once the brat turns ten, he'll have a bigger office, but right now, it's only got the two exits." instead;

The Labor Child is a baiter-aligned person in Scheme Pyramid. "[one of]Some overdressed little brat walks up to you and shakes your hand. 'Are you here to work for me? You look like you have initiative. Not as much as me. The Labor Child. If you think you have business savvy, get a seed from the Fund Hedge.'[or]The Labor Child paces about here, formulating his next business idea.[stopping]"

understand "kid/brat" as Labor Child.

description of Labor Child is "He's dressed in abhorrently cutesy Deal Clothes, the sort that lets pretentious little brats be bossier than adults would let [i]other[r] adults get away with[one of].[paragraph break]As you look closer, he pipes up 'People stare at me thinking it's weird I'm such a success. I stare at them thinking it's sad they're all such failures.' Brat[or][stopping]."

check talking to labor child:
	if contract is off-stage:
		say "'I'm a busy kid. Almost as busy as [bg]. In addition to delegating all my homework I am running a business! There's startup materials in the Hedge Fund.'" instead;
	if player has contract:
		if contract-signed is false:
			say "'The contract! Less talk! More do!' Oh, man, there's something you'd like to DO." instead;
		say "Before you can say anything, he takes the contract.";
		try giving contract to labor child instead;
	say "'Look, I'll write you a reference if you need one.'" instead;

The Labor Child wears the Deal Clothes. description of deal clothes is "The less said about them, the better. Whether tie or bow-tie, single-breasted or double-breasted, two- or three- piece, nobody has the courage to yell it's not really all that cute, especially when the wearer is a greedy little brat. Whether the clothes make them bratty or you have to be bratty to wear them, it's a depressing situation."

the fund hedge is scenery in Scheme Pyramid. "The fund hedge has other seeds like the one you took, but you really only needed one."

the money seed is a thing. description is "It's shaped like a dollar sign."

check examining the fund hedge:
	if money seed is off-stage:
		say "You notice a particularly prominent seed shaped like a dollar sign. The Labor Child pipes up, with strategically 'adorable' mispronunciations: 'Like it? I can let you have it for free...if you just take this contract here. You can sign it, or you can get someone to sign it. Then you can go to the back rooms. What do you say? Yes or no, yes or no.'";
		if the player yes-consents:
			now player has money seed;
			now player has cold contract;
			say "[line break]'Now, be sure you get that contract signed, now you have it.'";
		else:
			say "'No free lunches. Didn't you learn that when you were my age?'";
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
		say "'Take the safe if you want--they sent me the wrong model. Taking advantage of a kid!'";

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

chapter finger index

The finger index is a thing. "[if finger index is not examined]The paper lying where the safe was is some sort of index. You can see CONFIDENTIAL written on it.[else]The finger index on the floor provides all sorts of gossip.[end if]"

after examining the finger index (this is the know what jerks are about rule) :
	repeat through table of generic-jerk talk:
		if response entry is jerk-hows:
			now enabled entry is 0;
		else if response entry is not jerk-bye:
			now enabled entry is 1;
	continue the action;

understand "paper" as finger index.

description of finger index is "FINGER INDEX (CONFIDENTIAL):[paragraph break][finger-say].".

check examining finger index when finger index is not examined:
	say "It looks like a list of customers--wait, no, it's a list of embarrassing secrets. The little brat!";

to say finger-say:
	let temp be 0;
	repeat through the table of fingerings:
		increment temp;
		say "[temp]. [clue-letter of jerky-guy entry] [blackmail entry][line break]";
	say "[line break]Collect hush fees every Monday. Repeating accusations breaks the guilty parties. Insanity Terminal has backup data";
	now finger index is examined;

check taking the finger index:
	say "The Labor Child would probably get upset if you took that. And he'd probably get bigger people to be upset for him, too." instead;

chapter sound safe

The Sound Safe is a thing in Accountable Hold. "[if player is in Discussion Block]The safe lies here beneath the song torch[else]A safe lies here. It doesn't look particularly heavy or secure. You hear some sound from it[end if]."

after taking Sound Safe:
	say "It's not THAT heavy. The sound magnifies when you pick it up and the door opens briefly, but you close it. You try, but there's no way to lock it.[paragraph break]But what's this? Something's stuck under the safe. It's a piece of paper marked CONFIDENTIAL.";
	now finger index is in Accountable Hold;
	the rule succeeds;

description of Sound Safe is "[if sound safe is in Discussion Block]It's, well, not very sound. While it's closed, you can OPEN it at will. You're not even sure how to lock it[else]It sits, closed, and you probably want to keep it that way[end if]."

check opening sound safe:
	if harmonic phil is in lalaland:
		say "You don't need to, again." instead;
	if player is not in Discussion Block:
		say "You crack it open, but it makes such a terrible noise you have to close it again. You wouldn't want to open it again unless you were around someone you really wanted to spite." instead;
	say "The Sound Safe makes a brutal noise in the Discussion Block, made worse by the special acoustics. Harmonic Phil covers his ears. 'I can't even blather about how this is so bad it's good!' he yells, running off.[paragraph break]You put the safe down by the song torch.";
	now sound safe is in Discussion Block;
	now harmonic phil is in lalaland;
	say "[line break][if art fine is in Discussion Block]Art Fine chuckles and nods approval. 'That's what you get for dabbling in art that's not intellectually robust.' Wow. Even before a line like that, you figured Art Fine had to go, too.[else]Well, that's Phil AND Art gone.[end if]";
	increment the score instead;

check taking sound safe:
	if player is in Discussion Block:
		say "No, you like it here. Good insurance against Harmonic Phil coming back." instead;

part Judgment Pass

Judgment Pass is east of Jerk Circle. It is in Main Chunk. "[if officer petty is in Judgment Pass][one of]A huge counter with INTUITION in block letters is, well, blocking you. Well, not fully, but by the time you snuck around the edge, the official--and fit--looking officer behind it will get in your way.[or]The intuition counter still mostly blocks your way.[stopping][else]With Officer Petty out of the way, the Intuition Counter is now just an inconvenience.[end if]"

Officer Petty is an enforcer in Judgment Pass. "[one of]The officer stares down at the intuition counter for a moment. 'NOPE,' he yells. 'Sure as my name's Officer Petty, no good reason for you to go to Idiot Village.'[or]Officer Petty regards you with contempt.[stopping]"

description of Officer Petty is "Officer Petty stares back at you, cracks his knuckles, and rubs a palm. He's bigger, stronger and fitter than you."

the Intuition Counter is scenery in Judgment Pass. "It's labeled with all manner of dire motivational phrases I'm ashamed to spell out here."

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
petty-break	"'Not any time soon, kid. But dispensation from above, and bam. I'm gone.'"
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

Idiot Village is east of Judgment Pass. It is in Main Chunk. "Idiot Village is surprisingly empty right now. It expands in all directions, though you'd feel safest going back west, especially with that creepy [one of]idol[or]Thoughts Idol[stopping] staring at you east-northeast-ish. You hear a chant."

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
			say "You run past the Thoughts Idol. Its eyes follow you.";
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
		else:
			say "You try that, but it seems like the idol wants a challenge. You're not sure what type, but it's got a 'come at me bro' look on its face. Maybe east or northeast...";
		the rule succeeds;
	say "Idiot Village expands in all directions, but of course, nobody was smart enough to provide a map. OR WERE THEY CLEVER ENOUGH NOT TO GIVE INVADERS AN EASY ROUTE IN?[paragraph break]Either way, you don't want to risk getting lost.";
	do nothing instead;

The Business Monkey is a neuter person in Idiot Village. "A monkey mopes around here in a ridiculous suit two sizes too large for it."

the Business Monkey wears the Ability Suit. description of suit is "It's halfway between a business suit and a monkey suit (eg a tuxedo), without capturing the intended dignity or prestige of either. Nevertheless, the Monkey does preen in it a bit[if ability suit is not examined]. It's probably an Ability Suit, if you had to guess[end if]."

description of Business Monkey is "The monkey grins happily and vacantly, occasionally adjusting its [if suit is examined]Ability Suit[else]suit[end if] or pawing in the ground."

after doing something with business monkey:
	set the pronoun him to business monkey;
	set the pronoun her to business monkey;
	continue the action;

check talking to Business Monkey:
	if fourth-blossom is off-stage:
		say "The Business Monkey opens its pockets and smiles before clawing at the dirt and making a rising-up gesture with one paw." instead;
	if contract-signed is false:
		say "The Business Monkey pulls a pen out of its pocket, scribbles into thin air, shrugs, and puts the pen back." instead;
	say "The Business Monkey shakes your hand, gives you a thumbs up, and snickers." instead;

the fourth-blossom is a thing. understand "fourth/blossom" and "fourth blossom" as fourth-blossom. description is "Seen from above, it'd take up one quadrant of the four it should. It looks like it should start falling apart at any time, since it's all sliced, but somehow, it holds together despite its weird angularity."

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
	say "[one of][sly-s] plays a sample three-shell game, but a bean appears under each one.[or][sly-s] asks you to pick a card but then realizes they're all facing him.[or][sly-s] tries to palm an egg in a handkerchief, but you hear a crunch. 'Well, good thing I hollowed it out first, eh?'[or][sly-s] slaps a bunch of paperclips on some folded paper and unfolds the paper. They go flying. 'They were supposed to connect...'[or][sly-s] performs a riffle shuffle where one side of the deck of cards falls much quicker.[or][sly-s] performs a riffle shuffle that works beautifully until the last few cards fall to the ground.[or][sly-s] mumbles 'Number from one to a thousand, ten guesses, five hundred, two fifty, one twenty-five--round up or down, now? Dang, I'm stuck.'[or][sly-s] pulls out a funny flower which doesn't squirt you when he pokes it. He looks at it up close, fiddles with it and--yup. Right in his face.[or][sly-s] reaches to shake your hand, but you see the joy buzzer pretty clearly. He slaps his knee in disappointment...BZZT.[or][sly-s] looks befuddled on pulling only one handkerchief out of his pocket.[or][sly-s] cuts a paper lady in half. 'Oops. Good thing she wasn't real.'[in random order]"

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
sly-idiot	"Well, I feel dumb if I learn anything, cuz I probably should've. But I feel dumb if I don't, too."
sly-bm	"'Well, the [bad-guy] told me I needed to banter more. He's real good at banter. He even borrowed my magic book and assured me it was easy enough for him, and he even has the whole Problems Compound to run. Too busy to explain, but hey, teaching yourself works best.'"
sly-check	"'My progress. I mean, if it's what I'd like to do and all, I'd better be good at it. Or else he might be forced to label me a Candidate Dummy.'"
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

the thoughts idol is scenery in Idiot Village. "[if player is in idiot village][iv-idol][else]If you look back at the Thoughts Idol now, it may distract you. You know it's [vague-dir]. Gotta keep running, somehow, somewhere[end if]"

to say vague-dir:
	let J be orientation of last-dir * 2;
	now J is J + rotation;
	now J is the remainder after dividing J by 16;
	let J1 be (J + 1) / 4;
	say "mostly [if j1 is 0]east[else if j1 is 1]south[else if j1 is 2]west[else if j1 is 3]north and a bit ";
	if J is 5 or J is 11:
		say "west";
	else if J is 13 or J is 3:
		say "east";
	else if j > 8: [9 or 15]
		say "north";
	else: [1 or 7]
		say "south";

stared-idol is a truth state that varies.

to say iv-idol:
	if player has Legend of Stuff:
		say "The idol stares back at you and seems to shake its head slightly. You look down guiltily at the Legend of Stuff.";
		continue the action;
	say "You stare at the thoughts idol, [if player has bad face]and as it glares back, you resist the urge to look away. It--it actually blinks first.[else]but it stares back at you. You lose the war of facial expressions[end if]";
	if player has bad face:
		now stared-idol is true;

the Service Community is a room in Main Chunk. "Idiot Village's suburbs stretch every which way! The Thoughts Idol surveys you from a distance. You just came from the [opposite of last-dir]."

idol-progress is a number that varies.

idol-fails is a number that varies.

cur-dir is a direction that varies.

check going in service community:
	if orientation of noun is -1:
		say "You need to go in a compass direction.";
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
			now thoughts idol is in lalaland;
			move player to idiot village, without printing a room description;
			move crocked half to lalaland;
			increment the score;
		the rule succeeds;
	else:
		move thoughts idol to idiot village;
		d "idol-off = [idol-off], cur-dir = [orientation of cur-dir], last-dir = [orientation of last-dir], rotation = [rotation].";
		choose row idol-off in table of idol smackdowns;
		say "[smackdown entry][line break]";
		choose row idol-progress + 1 in the table of idol text;
		say "[bad-text entry][line break]";
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
	say "[if idol-off < 5]away from[else]towards[end if]"

to say rt-idol:
	say "You zigzag [to-away] the idol, but an audible whirr makes you look up. When you stop, it's already looking where you meant to go. It locks down a stare. You've gotten that before. You feel compelled to head back to Idiot Village under its gaze"

to say zz-idol:
	say "The short turn [to-away] the idol makes it wheeze a good bit, but it's enough to make you look back. It's just finished turning its head, then. The stare. The embarrassment. Wondering what you were trying to DO, anyway, REALLY"

to say idol-straight-away:
	say "You try running and running away, but (not so) eventually you have to turn around to see how much you're being watched, and the idol seems to be staring extra hard at you when you look back as if to say you can't run and that only makes it worse"

table of idol smackdowns
smackdown
"You feel particularly helpless running back and forth. The idol shakes its head, as if to let you know that just won't do, and it's tired of telling lesser things, or people, or whatever, that." [3, backwards]
"[zz-idol]." [2]
"[rt-idol]." [3]
"[idol-straight-away]." [4]
"[idol-straight-away]." [5]
"[rt-idol]." [6]
"[zz-idol]." [7]

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
"The thoughts idol whizzes around to track you, quicker as you get close, then slower as you get near."	"You look back at the idol after your run. But you can't look at its face. A loud buzz emanates from the idol, and you sink to the ground, covering your ears. Once they stop ringing, you go back to the entrance to Idiot Village."	"You didn't really do much wrong. There's not much to undo."
"The thoughts idol whirls around some more. Was it just you, or did it go a little more slowly?"	"The idol catches you. A loud buzz, and you cover your ears. That could not have been the way to go."	"You didn't really do much wrong. There's not much to undo."
"The thoughts idol whizzes around, adjusting speed--but did you hear a little cough?"	"The idol buzzes. You feel frozen, then are frozen."	"You thought you almost had the idol there for a bit, but it's not exactly going to be open to letting you brute-force it into submission."
"The thoughts idol seems to twitch back and forth while following you."	"You feel frozen and collapse. The idol's contempt can't hide a legitimate frown. You slipped up, but you got pretty far."	"Halfway there...maybe if you get momentum, you'll nail the pattern down for good."
"The thoughts idol barely catches its gaze up with you."	"The idol gives that look--you know it--'Smart, but no common sense.' Still--you can give it another shot."	"Would'ves won't help here. You've actually gotten in better shape, walking around just thinking."
"The thoughts idol warps and seems to wobble a bit but still looks at you."	"You--well, confidence or whatever it was let you down."	"Geez. You were that close. But no chance to stew. You bet you could do it, next time. But you can't say 'Oh, I meant to...'"
"The thoughts idol spins, coughs, and with a final buzz, it flips into the air and lands on its head! its eyes spark and go out, and it cracks down the middle. All of Idiot Village comes out to cheer your victory!"	"You must have been close. But no."	"The idol's look reminds you of when you got a really hard math problem right except for adding 1 and 6 to get 8. People laughed at you. It hurt."

part Speaking Plain

Speaking Plain is north of Jerk Circle. It is in Main Chunk. "Roads go in all four directions here. North seems a bit wider. West leads [if keep is visited]back to Temper Keep[else]indoors[end if]. But the main 'attraction' is [if fright stage is examined]Fright Stage[else]a huge stage[end if] in the center."

The Fright Stage is scenery in Speaking Plain. "It's decorated with all manner of horrible fate for people that, you assume, messed up in life. From homelessness to getting fired visiting a porn store on Christmas Day to just plain envying other people with more stuff or social life, it's a mural of Scared Straight for kids without the guts to do anything jail-worthy."

understand "business/show" and "business show" as Fright Stage.

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
		say "'THUS ENDS THE BUSINESS SHOW.' Uncle Dutch and Turk Young shout in unison before applauding each other. They then look to you and sigh when you fail to applaud. 'Does not provide minimal encouragement to others or appreciate clever generalities. He'll be a failure for sure,' notes Uncle Dutch. 'I've had teachers like that. But they still had to give me A's!' beams Turk Young.[paragraph break][one of]You look back on all their advice and realize none of it could even conceivably help you with what you need to do, here. At least they're not stopping you from going anywhere.[or]They're going to start up again in a bit. But it can't be that bad the next time through.[stopping]";
	else:
		choose row dutch-blab in table of dutch-blab;
		say "[banter entry][line break]";

table of dutch-blab
banter
"Uncle Dutch mentions kids who have more potential than Turk who are destined to be screwups. Turk Young condemns adults who had more going for them than Uncle Dutch but predictably failed."
"Uncle Dutch mentions he's not trying to scare people, but if they are scared, that's his problem. All the same, he mentions one truly scary person he had to deal with the other week."
"Uncle Dutch takes a moment to commend Turk Young's youthful enthusiasm, with which Turk Young takes a moment to commend Uncle Dutch's wisdom."
"Uncle Dutch mentions things you'd better learn unless you're stupid. Turk Young mentions things you'd better already know if you're smart."
"Uncle Dutch and Turk discuss the right amount to be scared to be at your most productive, but if you achieve that, you'd better not feel you have nothing to be scared of."
"Uncle Dutch complains about lazy kids these days, and Turk Young complains about adults who are have given up on life. They both wind up agreeing initiative in general is a good thing."
"Uncle Dutch reminds Turk to focus on school, but to remember it's more than school. Turk agrees. 'One day I'll have a job where I can tell people to focus on their job and make it more than a job!'"
"Uncle Dutch and Turk discuss the etiquette of whether you should call the [bad-guy] [bg] or not. Well, YOU never should, and Turk isn't ready yet, but what a big day it will be in the near future when he is allowed!"

for writing a paragraph about a person (called udyt) in Speaking Plain:
	say "[one of]As you approach the stage, the man and the teen on it boom: 'Approach the Fright Stage with care! Uncle Dutch and Turk Young bring it hard and keep it real with the BUSINESS SHOW! With thanks to the [bad-guy] for not arresting us yet and who will one day let us call him [bg]!'[or]Uncle Dutch and Turk Young continue their practical philosophy lessons on the Fright Stage.[stopping]";
	now uncle dutch is mentioned;
	now turk young is mentioned;

part Walker Street

Walker Street is east of Speaking Plain. It is in Main Chunk. "A huge mistake grave blocks passage south, but to the north is [if standard bog is visited]the Standard Bog[else]some swamp or something[end if], east is some sort of museum, and you can go inside [gateway-desc]. Or you can go back west to the Speaking Plain."

the mistake grave is scenery in Walker Street. "It's illuminated oddly, as if a red light were flashing behind it, and reads: IN MEMORY OF THE NAMELESS IDIOT WHO WENT ONLY FIVE MILES OVER THE SPEED LIMIT AND DIDN'T HEAR THE JOYRIDERS GOING THIRTY FORTY OR FIFTY OVER THUS RUINING THIS PRIME JOYRIDING ZONE FOR MORE EXCITING PEOPLE. -[bg][line break]"

check going nowhere in Walker Street:
	if noun is south:
		say "I'm afraid the Mistake Grave is a determined bound." instead;
	say "If there were a red light here, it would flash . Just north, east, in and west." instead;

understand "pot/chamber" and "pot chamber" as drug gateway when player is in Walker Street

to say gateway-desc:
	say "[if gateway is examined]the Drug Gateway[else]a gateway[end if] to ";
	if pot chamber is unvisited:
		say "[if gateway is not examined]somewhere seedy[else]a place your parents would want you to stay out of it[end if]";
	else:
		say "the Pot Chamber"

a long string is a thing in Walker Street. "A long string lies piled up here.". description is "It's coiled, now, but it seems pretty easy to untangle if you want to PUT it IN somewhere deep."

check entering drug gateway:
	try going inside instead;

check closing drug gateway:
	say "There's no way to close it." instead;

check opening drug gateway:
	say "It already is." instead;

Drug Gateway is scenery in Walker Street. "[one of]You look at it--a weird amalgam of swirls that don't seem to say anything. But they are captivating. Then they come together--DRUG GATEWAY. [or]Now you've seen the pattern in the Drug Gateway, you can't un-see it. [stopping]As you haven't heard any cries or gunshots, yet, it can't be too bad to enter[if pot chamber is visited] again[end if].. you think."

does the player mean entering drug gateway: it is very likely.

part Pot Chamber

Pot Chamber is inside of Walker Street. It is in Main Chunk. It is only-out. "This is a reclusive little chamber that sells far more of incense and air freshener than any place has a right to[one of], and after a moment's thought, you realize why[or][stopping]. Any sort of incriminating equipment is probably behind secret passages you'll never find, and you can only go out again."

check going nowhere in pot chamber:
	say "The only way to go is out." instead;

section Pusher Penn

Pusher Penn is a person in Pot Chamber. description is "He looks rather ordinary, really. No beepers, no weapons, no bulge indicating a concealed weapon. You'd guess he's one of those teens adults refer to as a Fine Young American."

litany of Pusher Penn is the table of Pusher Penn talk.

table of pp - Pusher Penn talk
prompt	response	enabled	permit
"Um, hi, what's up?"	penn-nodrugs	1	1
"Whoah, I'm, like, all in for DRUGS, BABY!"	penn-drugs	0	0
"You sell drugs? Isn't that illegal?"	penn-yousell	0	1
"Free stuff? Wow! Sure!"	penn-free	0	1
"Changed my mind. I'll help you out with your delivery."	penn-changed	0	1
"Whoah, MAN, the COPS!"	penn-cops	0	0
"What do you think of the [bad-guy]?"	penn-baiter	1	1
"[later-or-thanks]."	penn-bye	3	1

table of quip texts (continued)
quip	quiptext
penn-nodrugs	"'Come on. You know the deal. I sell drugs. In person, or with a delivery boy.'"
penn-yousell	"'Well, the [bad-guy] legalized them, but he gets the markup if they buy from him. And of course he makes fun of the serious druggies, because that's seeing both sides of things. Plus, I think he deals with [bad-guy-2]. No proof, though. Eh, I make a good profit underselling. Say, if you want a little sample, I just need a small favor.'"
penn-drugs	--
penn-free	"'Ha ha. Well, not quite free. Just a little favor. Make a little delivery. Behind five-oh's back.'"
penn-cops	--
penn-changed	"Pusher Penn engages in some are-you-sure-no-are-you-really-sure and then waves you off. 'Enough of this nonsense. I have a business to run."
penn-baiter	"'Well, we had a confidential conversation, and he says he respects my business initiative, but I better not sell to anyone who matters.'"
penn-bye	"[if player has weed]'Get my delivery done there, now.'[else if poory is not off-stage]'Enjoy the goods!'[else]'Well, if you need to do business, let me know.'[end if]"

check talking to Pusher Penn (this is the drugs trump Penn chats rule):
	if player has wacker weed:
		say "Pusher Penn won't be happy to see you haven't made the delivery." instead;
	if poory pot is not off-stage:
		say "Pusher Penn shoos you away. You've done enough business with him." instead;

to give-weed:
	say "'Here you go. Some wacker weed. Nothing special, nothing I'd trust with an experienced runner. There's a fella down by the Joint Strip on the monthly discount plan. Didn't pick up his allotment.' You take the baggie.[line break]";
	now player has wacker weed;

after quipping when qbc_litany is litany of pusher penn:
	if current quip is penn-nodrugs:
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

the wacker weed is a smokable. description is "You couldn't tell if it is good or bad, really. But it needs to be delivered. It's in a baggie and everything."

understand "baggie" as wacker weed.

check opening wacker weed:
	say "Don't dip into the supply." instead;

some poory pot is a smokable. description is "Geez. You can smell it. It's a sickly sweet smell."

part Standard Bog

Standard Bog is north of Walker Street. It is in Main Chunk. "This is a pretty standard bog. It's got slimy ground, some quicksand traps, and... [one of]well, the machine off to the side is not so standard. It seems to be mumbling, trying different ways to express itself. Yes, to use language. A language machine.[or]the Language Machine, still [if wax is in lalaland]burbling poems[else]grinding out dreary sentences[end if].[stopping]"

check going nowhere in standard bog:
	say "It's really only safe to go back south." instead;

The Language Machine is scenery in Standard Bog. "The language machine hums along [if wax is in lalaland]cheerfully[else]balefully[end if], its console spewing out [if wax is in lalaland]poetry, which isn't good, but it's not overblown[else]dolorous, leaden, formulated prose about, well, being stuck in a bog[end if] in its bottom half. In the top half is an LCD [if wax is in lalaland]smile[else]frown[end if]."

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
		increment the score instead;
	if poetic wax is in lalaland:
		say "The machine is on a roll. You don't have anything else to give to it, anyway." instead;
	if noun is story fish:
		say "[one of]The story fish moans about how it moans occasionally, but it's not as bad as that computer. You probably want to do something more positive for or to the computer[or]You don't want to annoy the story fish into moaning again[stopping]." instead;
	say "The machine whirs defensively as you get close. Hm, maybe something else would work better." instead;

the Trick Hat is a thing. description is "It's covered in snarky facial expressions and all manner of light bulbs and symbols of eureka moments. You think you even see a diagram of a fumblerooski or a fake field goal if you squint right."

check wearing the trick hat:
	say "It just doesn't feel...YOU. Maybe it'd look better on someone else." instead;

part Court of Contempt

Court of Contempt is west of Questions Field. It is in Main Chunk. "Boy, it's stuffy in here! You can't actually hear anyone sniffling, but you can, well, feel it. You can escape back east."

check going nowhere in Court of Contempt:
	say "'So, you the sort of person who runs into walls a lot? Not that there's anything wrong with that.' Yup. Looks like back east's the only way out." instead;

Buddy Best is a baiter-aligned person in Court of Contempt. "[one of]Oh, look! A potential friend![paragraph break]'Yah. Hi. I'm Buddy Best. You seem real nice. Nice enough not to waste too much of my time.'[paragraph break]Okay, never mind.[or]Buddy Best waits and taps his foot here.[stopping]". description is "Buddy Best has a half-smile on his face, which is totally a delicate balance of happiness and seriousness and not a sign of contempt, so stop saying that."

the Reasoning Circular is a thing. description is "It's full of several pages why you're great if you think you are, unless you're lame, in which case you don't know what great means. There's a long tag stapled to it."

before doing something with a long tag:
	ignore the can't give what you haven't got rule;
	if action is undrastic:
		continue the action;
	if current action is giving:
		say "(giving the Reasoning Circular instead)[line break]";
		try giving Reasoning Circular to the second noun instead;
	say "You don't need to fiddle with the tag. It's part of the Circular. Plus, it's a ticket to somewhere that might help you get rid of someone." instead;

the long tag is part of the Reasoning Circular. description is "It's stapled to the Reasoning Circular and reads:[paragraph break]By Order of the [bad-guy]:[paragraph break]The holder of this ticket is entitled, irregardless (I know, I'm being ironic and vernacular) of station or current responsibility, to visit Enough Fair, a whirlwind event of social skills where the bearer learns[paragraph break][2da]1. how to yell at others to stop complaining life's not fair AND still point how it's rigged against you[line break][2da]3. Of course, not trying to be too fair. People who overdo things are the worst![line break][2da]3. Lots more, but if we wrote everything, you wouldn't need to show up. Ha ha."

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
best-law	"'Brilliant. Yeah. I kind of see the good side of people. Well, interesting people. They don't even have to be as interesting as [bg]. But they better be close.'"
best-int	"'Oh, you know. People who break the rules. Break [']em creatively enough to be able to afford my fees. Nobody too square. No offense.'"
best-good	"'Look, I already said I'm sure you're nice, and all. Whether or not you pick your nose too much. There. Happy with that? No? Well, I did my best. Can't do much more for ya.'"
best-dirty	"'Y'know, that's shameful coming from you. Maybe someone said you were really weird, but it turned out you were only kind of weird? I'm doing the same thing. But for criminals. I mean, suspected criminals. Look, I can't have these accusations.'"
best-baiter	"'Obviously [bg] knows what's what. We had a good long discussion on dorkery, nerdery and geekery, and how it's busted out since the Internet blew up. We can say that. We're both hip to nerd culture, but we need to keep less consequential dorks, nerds and geeks from defining the lot of us. Aggressively. He's really fair, though. He doesn't insult anyone else without insulting himself first. Just--others, well, without self-awareness.'"
best-bye	"'Not very curious of you there. I'm an interesting fella, yet you...'"

check going west in Questions Field:
	if Reasoning Circular is not off-stage:
		say "Buddy Best has seen enough of you. Hmm, come to think of it, you've seen enough of Buddy Best. You're surprised he even gave you the Reasoning Circular." instead;

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
		say "[line break]'Negotiator, eh? Standing your ground?' Buddy Best shoves something in your hands as he pushes you out. 'It's, well, stuff I could tell you personally, but I don't want to waste your time. I'm sure you're nice once I get to know you even if you're not as nice as [bg] once you get to know him, but this is real efficient self improvement stuff. I'm sure you're smart enough to understand. [']Cause you probably should've understood it a few years ago.'";
		wfak;
		say "[line break]Well, it's something. Which is more than you expected. Generally, obnoxious fast-talkers wound up taking something from YOU after a short, loud, fast dialog. You're not sorry you had no chance to say good-bye.";
		now player has the Reasoning Circular;
		try going east;

part Discussion Block

Discussion Block is east of Walker Street. It is in Main Chunk. "On one wall, a book bank is embedded--like a bookshelf, only tougher to extract the books. On another, a song torch."

the poetic wax is in Discussion Block. "Poetic Wax--a whole ball of it--lies here behind [if number of waxblocking people is 0]where Art and Phil used to be[else][list of waxblocking people][end if]."

after taking the poetic wax:
	say "You're worried it might melt or vanish in your hands if you think too much or too little. Poetic things are that way.[paragraph break]Fortunately, it stays firm yet pliable in your hands.";

after examining the poetic wax:
	if art-wax is not talked-thru:
		enable the art-wax quip;
	if phil-wax is not talked-thru:
		enable the phil-wax quip;
	continue the action;

description of poetic wax is "It fluctuates through many shades of grey and colors of the rainbow at once. As you look at it, words seem to appear and vanish as it swirls. it becomes whatever you want it to be, but whatever it is, it isn't quite good enough and you think, just one more adjustment...it's the most fun you've had in forever."

check taking the poetic wax:
	if number of waxblocking people > 0:
		say "'Oh, no! Certainly not! The poetic wax is a valuable intersection of music and art, one [if number of waxblocking people is 1]I still[else]we[end if] must guard from less artful people! No offense.'" instead;

definition: a person (called p) is waxblocking:
	if p is art fine or p is harmonic phil:
		if p is in discussion block:
			decide yes;
	decide no;

[MUSIC FACE]

check going to Discussion Block for the first time:
	say "Two guys greet you as you walk in. 'I'm Art Fine. This is Harmonic Phil. Welcome to the Discussion Block! All discussion is welcome here, but some is more welcome than others.' They squabble briefly over whether music or books is superior, ask you whom you agree with and what you especially like, and shrug when you have nothing to say";
	wfak;

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
art-pomp
art-aes	"'Well, closed-mindedness. I'll never like that in people. But in art? Ah, I can appreciate anything. Even stuff that's so bad it's good. Especially in the presence of other aficionados. Unless it's just drivel. Of course.'"
art-book	"'This is not a library! However, if you so choose, you may marvel at the titles, record them for your pleasure, and check them out at your nearest library.' Art mumbles something about you not being able to pay the interest back with exciting criticism of your own. You're pretty sure he meant you to hear it."
art-tol	"'Drivel so dreary, from a mind so banal. I shudder to think. It would make me run screaming.'"
art-wax	"[wax-blab]"
art-baiter	"'[bg] is a top notch fellow. A true patron of the arts. Our aesthetics do line up, and I even suspect he is slightly more partial to me than my friend. He seeks to encourage all art, unless it could be understood by dumb people. Now, art that dumb people SHOULD be able to understand but don't, that's a different story.'"
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

table of quip texts (continued)
quip	quiptext
phil-hi	"'Indeed! Even if you do not appreciate our aesthetic fully, it cannot but rub off on you a bit.'"
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
		enable the phil-tol quip;
	if current quip is phil-bye:
		terminate the conversation;

chapter book bank

the book bank is scenery in Discussion Block. "Just filled with books! And interest!"

book-ord is a number that varies.

check examining book bank for the first time:
	say "It's just filled with books! And interest!";

check examining book bank:
	increment book-ord;
	if book-ord > number of rows in table of horrendous books:
		if art fine is in Discussion Block:
			say "Art Fine sighs. While he's obviously happy to reiterate his opinions on literature, he does need to let you know how kind he is to give his wisdom for free.[paragraph break]";
		else:
			say "You go back to the start of the book crack.[paragraph break]";
		now book-ord is 1;
	choose row book-ord in the table of horrendous books;
	if Art Fine is in lalaland:
		say "Oh, dear. [i][workname entry][r] by [authname entry]. Looks depressing." instead;
	say "'Ah, yes,' drones Art Fine. '[i][workname entry][r]. A most [one of]iconic[or]transformative[or]edifying[or]scintillating[or]zeitgeisty[in random order] read, providing you are a good reader. [authname entry]. A [one of]stirring treatise[or]vigorous discussion[or]tour de force[or]stunning perspective[at random] on [booksubj entry]. And more. [pompous-phrase]! More sensible than some jingle!'";
	the rule succeeds;

check taking book bank:
	now Steal This Book is in lalaland;
	say "You consider trying to Steal This Book, but then you picture the Stool Toad[if Judgment Pass is visited] or Officer Petty[end if] ready to Book This Steal. Even without Art or Phil here to see you." instead;

to say pompous-phrase:
	say "[one of]Indeed[or]True art[or]Simple, yet complex[or]Quite so[or]Immaculate[or]Ah[or]Fascinating[or]Food for thought[in random order]"

[it--it isn't just about itself. It's about other things, too!]

section all the books

table of hb - horrendous books
workname	authname	booksubj
"War's Star"	"Lucas George"	"how some kid ignored his weenie father's humble advice and took over the galaxy"
"Mannering Guy"	"Scott Walter"	"a man eschewing a life of travel and adventure for simple pleasures like putting neighbors in their place"
"Life, MY"	"Clinton William"	"a poor uncharismatic schlub appalled with the complexity and speed of today's fast-paced world, especially politics"
"The Convictions of Our Courage"	"Blair Anthony"	"the emotional and moral fulfillment a fellow who told on his friends to milquetoast seeming politicians who grovel shamefully before greater power"
"Jest in Finite"	"Wallace Foster David"	"a snappy fifty-page tour de force that's about nothing and everything--err, make that everything and nothing"
"Willows in the Wind"	"Graham Kenneth"	"a toad who learns to leave behind his less clever animal friends and passe forest life for more advanced, luxurious society"
"A Mockingbird to Kill"	"Lee Harper"	"losers who try to imitate people less weird than them. Or don't EVEN try"
"Wake, Finnegans"	"Joyce James"	"(he pauses) matters likely too complex for you."
"The Master of the Lesson"	"James Henry"	"an older literary critic who finds and mentors hopeless young fiction authors who'd be better suited to HIS career"
"The Life (sic) of Meaning"	"Adam Douglas"	"a serious but persuasive argument against letting uncreative people enjoy nonsense words and definitions"
"Lover Chatterly's Lady"	"L. H. David"	"a reformed rake who marries a social equal for scandalous reasons indeed"
"Messiah Dune"	"Herbert Frank"	"a race of people who gave up on interstellar war to relax at the beach and concoct a religion forbidding spices"
"Three of the Book"	"Alexander Lloyd"	"nosey overprivileged little kids convinced it's foretold they'll be the best thing ever"
"Arrow Times"	"Amos Martin"	"looking back to history and judging why everyone's a screw-up"
"The Floss on the Mill"	"Elliot George"	"a family with nothing better to do than stay together, and how they think they're happy [']til they stagnate into loathing at the end"
"Writing On"	"King Stephen"	"how society represses real writers from writing real books"
"The Islands of an Outcast"	"Joseph Conrad"	"a gentle fellow, shunned by modern society, who forges an idyllic utopia"
"The Divorce: GREAT"	"Lewis S. Clive"	"how blatant infidelity is really about seeing all the world has to offer and making the most of things--well, if you're worth cheating with. It surpasses even [i]The Boy and His Horse[r] and [i]The Love of Allegory[r]"
"Odyssey Space"	"Clark Arthur"	"a modern retelling of Ulysses dealing harshly with technocrats"
"The Cancer of Tropic"	"Miller Arthur"	"one ascetic's skin disease and the surprising poetry that lies therein"
"And Dominion Shall Have No Death"	"Thomas Dylan"	"a New World Order of smart poetic people that properly keeps the rabble scared of death and all that"
"Prejudice and Pride"	"Austin Jayne"	"someone learning, with humor and pathos, how and why his instincts about lesser people who think they're equal to him is right"
"The Stone in the Sword"	"White Theodore"	"a kid learning to be king by doing all the things fantasy novels don't describe--like pushing people around, politics, and so forth"
"The World Beyond the Wood"	"Morris William"	"a muddled fellow moving on from silly fantasy novels to real-life gritty ones you can have louder arguments over"
"The Stuff, Right?"	"Wolfie Thomas"	"some schlep's comical attempts to alchemize a 'good' drug and his failure to keep his feet on the ground"
"Rings of the Lord"	"T. R. R. John"	"one person's quest to help some insanely rich person gain a full collection of rich jewels and why it was character building"
"Thrones of a Game"	"Martin George"	"Three hundred pages of medieval Musical Chairs, with a secret deeper meaning careful readers can't miss"
"The Half Second"	"Doyle Roddy"	"a literary type, Keen Roy, suddenly realizing how truly silly reading, writing and thinking about sports can be"
"The Judgement of Vision"	"Byron Gordon George"	"how a great poet is denied Heaven for exposing truths to people a bit too common to appreciate them"
"On Death After Life"	"Ross Kubler"	"how and why to truth-bomb the terminally ill with stuff they better learn before they peg out"
"The Aging of Virtues"	"Carter James"	"why just plain being nice is a cop-out these days, especially as we get older"
"The Magi of the Gift"	"Henry O"	"clever folk whose seemingly ideal gifts show the recipients up as greedy bums"
"Pay, Soldiers"	"Faulkner William"	"a soldier who returns from war uninjured and how people with medical exemptions proved he didn't try hard enough"
"Command the Angels"	"Jacques Brian"	"how and why evil pirates deserve to be richer and more interesting than boring sailors"
"Farm Animal"	"Blair Irick"	"how particularly common people never understand why they obviously need to be pushed aside, in fable form, no less"
"The Sleepy Hollow of Legend"	"Irving Washington"	"how people learned and proved that silly old 'national treasures' don't hold any mysteries"
"Girls With Difficulties"	"Amos Kingsley"	"sensitivity, surprising from a man, and tender insight into female psyche, with not the least bit of flippancy"
[can't quite get to work:
brooks walter: Freddy and (something) (dang it none of the 26 do anything cool. I mean the books are cool but they all have FREDDY in them which ruins things)
Allan Woody: Ending Hollywood (was a movie)
Dickey James
Pascal Blaise
Armstrong Sperry
Ford Richard The Land of the Lay?
Wallace Stegner (never read)
Richter Conrad: The Forest in the Light?
Hugo Victor: Eternity with Conversations? (not really by Hugo)
]

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
	say "'Ah, yes,' drones Harmonic Phil. '[i][workname entry][r]. A most [one of]titillating[or]sense-enhancing[or]transcending[or]pure-art[or]spine-tingling[in random order] experience, providing you are a good listener. [singername entry]. Such [one of]complex melodies[or]vigorous discussion[or]tour de force[or]stunning perspective[at random] on [songsubj entry]. And more. [pompous-phrase]! It wouldn't be the same in print!'";
	the rule succeeds;

check taking song torch:
	say "Maybe that could reduce a new castle to coals, but you're not sure that'd be a good idea even if you found one." instead;

section all the songs

table of hs - horrendous songs
workname	singername	songsubj
"Stop Believing, Don't"	"Perry Steven"	"people who already tried enough and should stop embarrassing themselves"
"Train Downtown"	"Stewart Rodd"	"a man rightfully too busy advancing his career prospects to spend time with his woman"
"Life is WHAT"	"Harrison George"	"a man too clever for all the constant love-is-life babble"
"Out Movin[']"	"Joel Billey"	"someone who finds value in a more stressful life"
"The Light of Dying"	"The Machine Against Rage"	"admitting that there are smarter people than you who know what's best and if you care about society, maybe it's time to go, but don't, like, make a messy suicide. Even better than The Name in Killing"
"Work Fire"	"Perry Keady"	"having everyday up and at em for the things you deserve to do (if you're smart) or better do to survive (if you're dumb)"
"Bound Homeward"	"Simon Paul"	"someone who wants to get out more but his stupid artsy worries get in the way"
"My Mind in Carolina"	"Taylor James"	"getting away from one's backward past and entering sophistication"
"Gold of Heart"	"Young Neil"	"someone who understands finding someone with money is important, but only to support a blocked artist like himself."
"Knife the Mack"	"Darin Bobby"	"harsh punishment for some dude with no game trying to impress women out of his league"
"Girl Island"	"John Elton"	"the first really cool song about men finding paradise among REAL women"
"My Mind on Georgia"	"Charles Ray"	"cutting reflections on why certain places hate progress"
"Lies Little"	"Mac Fleetwood"	"how it's fun to cheat on someone dumb enough to tell the truth too much"

[the music face?]

part Questions Field

Questions Field is north of Speaking Plain. It is in Main Chunk. "North is what can only be the [bad-guy]'s lair: Freak Control. You can go back south to the Speaking Plain, [if reasoning circular is not off-stage]though Buddy Best probably won't welcome you back west[else]and also you can go west to [c-house][end if]."

check going south in questions field when got-pop is true:
	say "No. You've drunk the quiz pop, and it's time to face the [bad-guy]." instead;

to say c-house:
	say "[if contempt is visited]the Court of Contempt[else]a courthouse[end if]";

check going east in Questions Field:
	say "The path grows tangled and too intimidating. You might get lost." instead;

qp-hint is a truth state that varies.

to say bro-i-we:
	say "[if bros-left is 1]I[else]We[end if]";

check going north in Questions Field:
	if bros-left > 0:
		say "[random bro in Questions Field] wags a finger dolefully. [one of]'[bro-i-we] can't let you by to see the [bad-guy]. What was his joke?' He pauses. '[bro-i-we] had ONE JOB!'[or]'[bro-i-we] have one job.'[stopping][paragraph break]'He wasn't being cruel. He's nice once you get to know him, we hear. But if he had to be nice to too many people, it'd get diluted.'" instead;
	if cookie-eaten is true:
		say "Bye-bye, Questions Field. A question mark pops out from the side and tries to hook you out of Freak Control, but that's a stupid trap. The exclamation mark that tries to bash you? A punch disables it.";
		continue the action;
	if off-eaten is true:
		say "A question mark pops out from the side and tries to hook you, but you throw your shoulders up in exasperation just so--one arm knocks the question away, and the other deflects an exclamation mark coming from above. Weird. It's more motivation than ever just to get OUT of here, already.";
		continue the action;
	if greater-eaten is true:
		say "A question mark pops out from the side and tries to hook you, but you reflexively throw an arm and knock it out without even looking. Same for an exclamation mark from above. Yup, YOU were listening when Guy Sweet was talking.";
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
		say "[one of]Three brothers block the way ahead to the north. They're imposing, each in his own way. 'Greetings, Traveler. We are the Keeper Brothers: Brother Big, Brother Blood, and Brother Soul. We must guard Freak Control, headquarters of the [bad-guy]. It is the job we are best suited for, and we are lucky the [bad-guy] has given it to us. He said we are free to do something clearly better if we can find it. We have not, yet.'[or][list of stillblocking people] block[if bros-left is 1]s[end if] your way north. '[if bros-left is 1]I'm[else]We're[end if] sorry. It's [if bros-left is 1]my[else]our[end if] job. Until we find a purpose.'[stopping]";
	else:
		say "You've also disposed of the brothers with the NOTICE ADVANCE command.";
	now brother's keepers is mentioned;
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
	increment the score;

litany of Brother Big is the table of Brother Big talk.

table of b1 - Brother Big talk
prompt	response	enabled	permit
"Hi. Having fun--guarding--whatever?"	big-hi	1	1
"Your duty. What's he done for you?"	big-duty	0	1
"That's sad. I wouldn't take that. Well, in theory, at least."	big-theory	0	1
"[if big-go is talked-thru]So, anything that'd give you an excuse to move on[else]Any way I could give you a reason to take a vacation[end if]?"	big-go	0	1
"What do you really think of the [bad-guy]?"	big-baiter	0	1
"[later-or-thanks]."	big-bye	3	1

table of quip texts (continued)
quip	quiptext
big-hi	"'Not really. But it is my duty. The [bad-guy] dictates it.'"
big-duty	"'Well, he kind of explained to me I was kind of stupid. Which I am. But he sort of made me laugh when he said it. And nobody ever did that. And he needs to prod me less to laugh now, specially now I've been rescued from Idiot Village a while. He always has smart stuff to say.'"
big-theory	"'It's helping me, though. I'm just not smart enough to figure out why.'"
big-go	"'Well, if you could help me feel smart. I mean, you seem smart, but I dunno if you could help me feel smart. It's like I'd like a book, not boring like a dictionary or too fluffy. But one that just helps me, you know?'"
big-baiter	"'I figure I'll appreciate him more once or if I ever get smarter. He'd help me, but he's too busy.'"
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
"[later-or-thanks]."	soul-bye	3	1

table of quip texts (continued)
quip	quiptext
soul-why	"'Well, it all started when the [bad-guy] proved to me he had more soul than me, and he enjoyed life more, too. He said he'd give me weekly lessons and all I had to do was guard Freak Control to the north.'"
soul-live	"'The [bad-guy] made it pretty clear that's what I should do, in an ideal world, and it'd help me, but it might not help the people I got out and saw. It'd be selfish. Well, he helped me get out of Idiot Village, and apparently the rest's up to me.'"
soul-fix	"'Oh, if there was, I would've found it. And if I haven't, well, that's my own fault. For being more self-absorbed than I should be. It's totally different from the [bad-guy] being self-absorbed.'"
soul-how	"'Well, when he's self-absorbed, it's really thinking about others, because they have fun hearing him talk about himself. Me, not so much. The only quick fixes are probably illegal and unhealthy. Woe is me!'"
soul-what-if	"'Oh, it would be nice. But it would be too much to ask. Something to relieve the darkness and burden. I could never find it myself, though.'"
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
"[later-or-thanks]."	blood-bye	3	1

table of quip texts (continued)
quip	quiptext
blood-hi	"'Yeah. Well, it started the first time I met the [bad-guy]. He cracked a few self-depreciating jokes then gave me a few to laugh at. But I got all mad. Took a swing. He said he bet he wasn't the first I lashed out at. He was right.'"
blood-maybe	"'Maybe not, but it's ENOUGH me, you know? And the [bad-guy] said maybe some inactivity might help me. Only lash out at people who deserve it. Like trespassers trying to bug him. If I hung around smart people, I might get angry at them. So I'm sort of more useful here.'"
blood-manip	"'Yeah. The [bad-guy] says [bad-guy-2] can be even more manipulative. Makes me all agitated about what happens if I ever lose this post.'"
blood-calm	"'Well, the [bad-guy] joked that even a stupid spiritual healing stone might not help me. If those things worked at all. Which they can't. I better not believe it since he took me away from Idiot Village.'"
blood-all	"'Yeah. Not like they were really challenging or edgy, though. I mean, it feels nice to talk and stuff but the [bad-guy] said questions like yours weren't real nitty-gritty. No offense.'"
blood-bye	"'Later. You, um, yeah, seem okay.'"

after quipping when qbc_litany is litany of Brother Blood:
	if current quip is blood-hi:
		enable the blood-maybe quip;
	if current quip is blood-maybe:
		enable the blood-manip quip;
	if current quip is blood-manip:
		superable blood-calm;
	if current quip is blood-calm:
		enable the blood-all quip;
	if current quip is blood-bye:
		terminate the conversation;

part Temper Keep

Temper Keep is west of Speaking Plain. Temper Keep is in Main Chunk. "[if sal-sleepy is true]Temper Keep is nice and quiet now. Nothing much to do except go back east[else]You find yourself hyperventilating as you enter, not due to any mind control, but because--well, it stinks. It would stink even worse if you couldn't go back east. [say-vent][end if]."

check going nowhere in Temper Keep:
	say "You're a bit annoyed to see there are no ways out except east. But then again, you'd also be annoyed if there was more to map. Annoying." instead;

to say say-vent:
	say "[one of]You look around for the cause, and you only see a vent shaped like a spleen[or]The spleen vent catches your eye[stopping]"

Volatile Sal is a person in Temper Keep. "[one of]'Oh, man! [bad-guy] maybe finally sent someone to fix...' An angry looking man takes a sniff. 'You smell awful too! What is it with all these visitors? Anyway, I'm Volatile Sal. Nice to meet you. Be nicer if you smelled better.'[or][if sal-sleepy is false]Volatile Sal paces around here anxiously, holding his nose every few seconds[else]Volatile Sal is snoozing in a corner by [sp-vent][end if]. It [if sal-sleepy is true]does smell nicer here after your operations[else]does smell a bit odd here[end if].[stopping]"

check putting pot on sal:
	try giving poory pot to sal instead;

understand "angry man" as Sal when player is in Temper Keep.

description of Volatile Sal is "[if sal-sleepy is false]Sal paces around, grabbing at his hair or clothes and waving his hands as if to rid the stink. As you glance at him, he points at YOU.[else]He's curled up, happy and relaxed, dreaming better dreams than he probably deserves to.[end if]"

sal-sleepy is a truth state that varies.

The Spleen Vent is scenery in Temper Keep. "Carved into the vent is the phrase SPLEEN VENT. A [if sal-sleepy is true]weird but pleasant aroma[else]bad stench[end if] rises from it[if relief light is off-stage]. It looks like something's glowing behind it, but you'd have to open the vent to find out[end if]."

check opening vent:
	if sal-sleepy is false:
		say "Not with Sal all anxious you aren't." instead;
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
			say "As you stuff the thin roll into the vent, it tumbles down to what you can only assume is an incinerator or air flow or something in Temper Keep's foundation you'd be better off not touching in normal circumstances.[paragraph break]The 'aromatics' of the poory pot seep into the air in Temper Keep. 'Is it just me, or is it not stinky in here? Yes! Yes! It is probably some combination of both!' You stand well out of the way as Sal continues to babble, his pseudo-philosophy becoming ever more pseudo- before...clonk. He's out.";
			increment the score;
			the rule succeeds;
		if noun is long string:
			say "You fish in the vent with the string, but nothing comes up." instead;
		say "That doesn't seem to fit." instead;

section relief light

The relief light is a thing. description of relief light is "It glows comfortingly. You feel happier and smarter, even if you don't understand how it works. Just looking at it and holding it makes you feel better, but maybe there's someone who needs it even more than you."

part Freak Control

Freak Control is north of Questions Field. It is in Main Chunk. "[if accel-ending]There's all sorts of stuff here but really all you want to do is show the [bad-guy] what's what.[else]Well, you made it. There's so much to look at![paragraph break]While there's probably another secret exit than back south, it's surely only available to the [bad-guy]. All the same, you don't want to leave now. You can't.[end if]"

check going south in Freak Control:
	say "If you start running, you'll never get a running start[activation of running start]. Plus you're too chicken to face the possibility of being called a chicken." instead;

a list bucket is a thing in Freak Control. "[one of]A list bucket lying nearby may help you make sense of the fancy machinery, though you worry you might kill yourself trying[or]The list bucket waits here, a handy reference to the gadgetry of Freak Control[stopping]."

check taking the bucket:
	say "You would, but the [bad-guy] might turn around and ask if you really needed to steal a bucket, and no, the text isn't going to change if you pick it up, and so forth." instead;

description of list bucket is "[2da]The Language Sign should, um, y'know, make things obvious.[line break][2da]The Shot Screen: track various areas in the Compound[line break][2da]The Twister Brain: to see what people REALLY mean when they oppose you just a little[line break][2da]The Witness Eye provides tracking of several suspicious individuals[line break][2da]The Incident Miner processes fuller meaning of events the perpetrators wish were harmless.[line break][2da]The Call Curtain is somewhere the [bad-guy] better not have to go behind more than once a day.[line break][2da]The Frenzy Feed magnifies social violations people don't know they're making, or want to hide from others, and lets you feel fully outraged.[paragraph break]All this gadgetry is well and good, but the [bad-guy] probably knows it better than you. You may need some other way to overcome him."

the call curtain is scenery in Freak Control. "It doesn't look particularly malevolent--it seems well washed--but you don't know what's going on behind it."

check opening call curtain:
	say "It's closer to the [bad-guy] than you. Maybe you'll just have to wonder what's behind it. Maybe that's another small part of the [bad-guy]'s mind games." instead;

check entering call curtain:
	say "The [bad-guy] wouldn't allow a repeat performance. Or any performance, really." instead;

the incident miner is scenery in Freak Control. "The incident miner churns and coughs. You see text like 'not as nice/interesting/worthwhile as he thinks' and 'passive aggressive but doesn't know it' and 'extraordinary lack of self awareness' spin by."

the against rails are plural-named scenery in Freak Control. "You're not sure whether they're meant to be touched or not. No matter what you do, though, you feel someone would yell 'Isn't it obvious Alec should/shouldn't touch the rails?'"

freaked-out is a truth state that varies.

the shot screen is scenery in Freak Control. "[if cookie-eaten is true]You're torn between wondering if it's not worth watching the jokers being surveyed, or you deserve a good laugh.[else]For a moment, you get a glimpse of [one of]the jerks going about their business[or]parts of Idiot Village you couldn't explore[or]a 'me-time' room in the Classic Cult[or]a secret room in the Soda Club[or]Officer Petty at the 'event,' writing notes furiously[or]the hideout the Stool Toad was too lazy to notice[or]The Logical Psycho back at his home[or]exiles living beyond the Standard Bog[in random order].[end if]"

control-gadget-row is a number that varies. control-gadget-row is 0.

every turn when player is in freak control and qbc_litany is not table of baiter master talk (this is the random stuff in FC rule): [?? if player doesn't know names, don't write them]
	unless accel-ending:
		increment control-gadget-row;
		if control-gadget-row > number of rows in table of gadget action:
			now control-gadget-row is 0;
			say "'All this data from all these machines! Of course I have to be decisive and a little abrasive,' the [bad-guy] yells to, well, nobody in particular. 'It's not like I'm on a total power trip.'";
			the rule succeeds;
		choose row control-gadget-row in table of gadget action;
		say "[gad-act entry][line break]";

definition: a thing (called sc) is control-known:
	if sc is not in freak control, decide no;
	if sc is examined, decide yes;
	if list bucket is examined, decide yes;
	decide no;

definition: a room (called rm) is mainchunk:
	if rm is freak control, decide no;
	if rm is belt below, decide no;
	if rm is bottom rock, decide no;
	if map region of rm is main chunk, decide yes;
	decide no;

table of gadget action
gad-act
"You think you hear the List Bucket rattle. Wait, no."
"The Language Sign flashes but you don't think it changed its message. Just reinforced it."
"The Twister Brain spits out a page of data the [bad-guy] speed reads. He mutters 'Pfft. I already sort of knew that. Mostly. Still, need to keep an eye on [the random surveyable person].'"
"The Witness Eye swivels around with a VVSSHHKK before changing the focus to [random mainchunk room]."
"The [bad-guy] gestures at the Incident Miner. 'Some people never learn. Or they just learn wrong.'"
"The [bad-guy] laughs sardonically at the Frenzy Feed. 'Hah, gonna love complaining about that with [random baiter-aligned person].'"
"The Shot Screen blinks a bit before changing its focus."

the Twister Brain is scenery in Freak Control. "The way it's creased, it's just a contemptuous smirk. Or maybe you're just seeing things."

understand "ridge/ridges" as Twister Brain.

the Witness Eye is scenery in Freak Control. "It's weird, it's circular, but it has enough pointy protrustions, it could be a Witness Star too. You see lots of things going on. Most look innocent, but there's an occasional flash, the screen reddens, and WEIRD or WRONG flashes over for a half-second[if a random chance of 1 in 5 succeeds]. Hey, wait, that looked like [a random surveyable person] for a second, there[end if]."

understand "witness star" and "star" as Witness Eye.

the Language Sign is scenery in Freak Control. "It says, in various languages: OUT, FREAK. [one of]You're momentarily impressed, then you feel slightly jealous that the [bad-guy] took the time to research them. You remember getting grilled for trying to learn new languages in elementary school, before you could take language classes. You mentally blame the [bad-guy] for that. Well, it was someone like him. [or]You also take a second or two to pick which language in which line says OUT, FREAK. Got [']em all. Even the ones with the unusual alphabets you only half know.[stopping]"

The Baiter Master is a proper-named person in Freak Control. "The [bad-guy] stands here with his back to you.". description is "You can only see the back of him, well, until you gaze in some reflective panels. He looks up but does not acknowledge you. He doesn't look that nasty, or distinguished, or strong, or whatever. Surprisingly ordinary. He shrugs and resumes his apparent thoughtfulness."

understand "complex" and "messiah" and "complex messiah" and "bm/cm" as Baiter Master.

litany of Baiter Master is the table of Baiter Master talk.

check talking to Baiter Master:
	if freaked-out is false:
		say "[one of]He waves you off without even looking. 'Whoever you are, I'm busy. Too busy for your lame problems. And they must be lame, if you asked so weakly.' You'll need an entirely more aggressive way to get his attention.[or]You just aren't good enough at yelling to do things straight up. Maybe you can upset things somehow.[stopping]" instead;
	say "'Dude! You need to chill... there are things called manners...' but he does have your attention now. 'So. Someone finally got past those mopey brothers. You want a vision duel? Because we can have a vision duel. I have...an [i]opinion[r] of difference. You don't even have...one right serve.' He takes a slurp from a shot mug[activation of shot mug] (with a too-flattering self-portrait, of course) and perks up.";
	if player has legend of stuff:
		say "He points to the Legend of Stuff. 'Oh. It looks like you took the easy way out. In fact...";
		say "[bm-stuff-brags][line break]";
	say "[if thoughts idol is in lalaland]Destroyed the Thoughts Idol, too[else if service community is in lalaland]You'd think failing with the Thoughts Idol would be a hint, but maybe not[else if insanity terminal is in lalaland]Knew better than to challenge the Thoughts Idol, at least[else]Well, I have...resources...in place to fix your mess[end if].";
	if insanity terminal is in lalaland:
		say "[bm-idol-brags]";

to say bm-stuff-brags:
	repeat through table of bm stuff brags:
		if hints-used <= times-failed entry or times-failed entry is -1:
			say "'[what-to-say entry][if reused-hint is true] And you had to look something up twice, too, I bet. No focus.'[else]'";
			continue the action;

to say bm-idol-brags:
	repeat through table of bm idol brags:
		if idol-fails <= times-failed entry or times-failed entry is -1:
			say "[if idol is in lalaland][win-say entry][else][nowin-say entry]";
			continue the action;

reused-hint is a truth state that varies.

freak-control-turns is a number that varies.

every turn when player is in freak control:
	increment freak-control-turns;

table of distract time
control-turns	time-taunt
1	"'Just running in here quickly, eh? Making a big mess?'"
5	"'Wondered if you were going to do something.'"
10	"'Gosh! Was it awkward for you, waiting, too?'"
15	"'Well, yes, I saw you first thing.'"

table of bm stuff brags
times-failed	what-to-say
0	"More precisely, you went to all that trouble and didn't even use it."
1	"Only used it once, maybe, but still--you had to cheat."
2	"Used it twice, there."
5	"The really easy way."
10	"Did you even TRY to think on your own? I'm all for research, but..."
-1	"You should be embarrassed using it that much! Honestly."

table of bm idol brags
times-failed	win-say	nowin-say
0	"'Destroyed the Thoughts Idol in one try, too. Lucky.'"	"'Didn't even try. That's a good way to get far in life.'"
1	"'You're lucky the Thoughts Idol didn't kill you first try you got. It should've. But, mercy and stuff.'"	"'Quit pretty quickly, though.'"
5	"'I suppose you can feel smart enough, beating the idol pretty quickly.'"	"'You sort of tried to figure it, I guess.'"
10	"'Eh, well, sort of average performance taking the idol.'"	"'Guess I'll give you credit for persistence even in failure.'"
15	"'Boy. Took you long enough.'"	"'Boy, you seem like the sort that'd figure how to get by the Idol. Guess you got frustrated.'"
21	"'Well. Trial and error worked, I guess. But--didn't you feel dumb once you realized what you did?'"	"'Too bad there wasn't an answer in back of the book.'"
-1	"'Congratulations, I guess. If you were persistent with, y'know, practical stuff...'"	"'Doubt you learned much from all your failures.'"

table of bm - Baiter Master talk
prompt	response	enabled	permit
"I've gained...belief beyond."	bm-help	1	1
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
bm-help	"'Really? What sort of help?'[paragraph break]You describe what you did for them and how you did it.[paragraph break]'Oh, so a fetch quest, then. You should be above that, shouldn't you? I mean, a fetch quest helps one other person, but clever philosophy--it helps a lot. [bad-guy-2], you know.'"
bm-fetch	"'Big deal. You probably never considered how lucky you were, how improbable those helpful items were just lying around. Intelligent design? Pah! What a joke! My social ideals fix society and all that sort of thing. Surely you heard what people said? They had something to say.'"
bm-tosay	"'You have to admit, I have leadership skills.'"
bm-mug	"'Oh, it's Crisis Energy[activation of crisis energy]. For taking urgent action when someone's -- out of line.' You look more closely. 'COMPLIMENTARY FROM [bad-guy-2-c].'"
bm-bad2	"'It's--it's, well, tribute is what it is.'"
bm-so-bad2	"'Oh, come on, you know the difference.'[wfk][line break]It just slips out. 'Yeah, it's easy, there's not much of it.'"
bm-tribute	"'There will be. Just--society needs to be stable, first. And it almost was. Until you stepped in.'"
bm-fear	"You just mention, they're smart enough, but they can fool themselves. With being impressed by stupid propaganda, or misplaced confidence, or people who claim things are--well--back to front. They get used to it. They let things mean the opposite of what they mean. You've been there...[wfk][line break]'Whatever.'[paragraph break]'See? Just like that.'[paragraph break]There's a long silence. 'Great. You think you can do better? Do so. I'll be waiting in Questions Field. You'll miss something obvious. Always have, always will.' The Baiter Master storms out.[paragraph break]You're not sure who can help, but maybe...the Goods? Yes. The Jerks? Surprisingly, yes, too. You even call Mark Black on the Quiz Pop's customer service number. Then [bad-guy-2] pretending to be the [bad-guy] and you prank him. It's--there's so much to do, questions you never asked. Mark Black is on his way--but you are unprepared for the military coup--someone named Admiral Vice. 'A danger to Slicker City[activation of slicker city]! We will break him,' he says, gesturing to you.[wfk]"
bm-bye	"'You're not going anywhere.' And he's right. But it's not out totally out of fear, now."

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
	if current quip is bm-fear:
		terminate the conversation;
		if thoughts idol is in lalaland:
			say "But Idiot Village has had time to assemble and rescue the hero that dispelled the Thoughts Idol! They overwhelm the Admiral, trash the more sinister surveillance technology in Freak Control, and lead you somewhere new. You protest you're not a leader--you just, well, did a bunch of errands. But they insist they have something to show you.";
			now player has hammer;
			move player to Airy Station;
		else:
			say "'Where? In the BREAK JAIL[activation of break jail]!'[paragraph break]You keep a straight face and, later that night, your wits. Could people who yell that loud REALLY be that wrong? You don't sneak out quietly, enough, though, and guards give chase. There's a mist ahead--maybe they'll lose you! But you've done even better. 'The out mist!' they yell. 'People eventually leave there to get back to real life.'";
			move player to Out Mist;

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
	repeat through table of distract time:
		if there is no control-turns entry or freak-control-turns < control-turns entry:
			say "[time-taunt entry][line break]";
	try talking to baiter master;

book endings

Endings is a region.

part Airy Station

Airy Station is a room in Endings. "[one of]A cheering crowd[or]The mentality crowd[stopping] surrounds you on all sides! They're going pretty crazy over their new-found freedom, and how you got it for them."

understand "man hammer" as a mistake ("So, this game isn't badly cartoonish enough for you?") when player is in Airy Station.

understand "ban hammer" as a mistake ("You do feel confident you could now be an Internet forum mod. But--if you banned the hammer, you'd never get back home.") when player is in Airy Station.

understand "hammer jack" as a mistake ("There's probably someone named Jack in the crowd, but even if he deserved it, it'd take too long to go and ask.") when player is in Airy Station.

understand "hammer ninny" as a mistake("This is a nonviolent mistake, and besides, everyone here has been slandered as an idiot, not a ninny.") when player is in Airy Station.

understand "hammer sledge" as a mistake("If there were a sledge, you wouldn't want to destroy it. Trust me, I know what I'm doing. And you will, soon, too.") when player is in Airy Station.

understand "worm round" as a mistake("You consider worming around, but you're not very good at flattery, and there's nobody to flatter. Not that it's worth being good at flattery.") when player is in Airy Station.

understand "hammer [text]" and "[text] hammer" as a mistake ("You look at the hammer, hoping it will change, but nothing happens. Maybe another word.") when player is in Airy Station.

understand "hammer away" and "hammer home" and "hammer lock" as a mistake ("Wrong way round.") when player is in Airy Station.

the hammer is a thing in Airy Station. description of hammer is "It's a nondescript hammer. You feel a power, though, as you carry it--as if you were able to change it, if you knew how to describe it."

after printing the name of the hammer when taking inventory:
	say " (much plainer than it should be)";

before doing something with hammer:
	let q be right-adj;
	if q is -1:
		say "That should have worked. But it didn't. You must be close, though." instead;
	if q is 0:
		continue the action;
	if q is 1:
		say "The hammer glows a bit. You feel it pulling you towards the lock caps. Its claw end grabs one after another, strangling them until they pop off.";
		best-end;
	if q is 2:
		say "The hammer glows a bit. You feel it pulling your arm up. The hammer crackles a bit, and you slam it down on the lock caps, which fall quickly.";
		best-end;
	if q is 3:
		say "The hammer glows a bit. You feel it swinging side to side, and before it touches the lock caps, they crack open and fall to the ground.";
		best-end;

to best-end:
	say "The door to the Return Carriage creaks open. You wave to the crowd as you enter the Return Carriage. You think of all the people you helped, the smart-alecks you didn't let get you down. The clues won't be as obvious back home, but you see some people are full of hot air, and you can overcome them, and that's a relief.";
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

the Return Carriage is a thing. description is  "The Return Carriage awaits, but the problem is, you can't find an obvious way to, um, enter."

the lock caps are part of the return carriage. description is "They don't look too menacing, but then you look closer, and you feel like you're being shouted at. Hm."

airy-wait is a number that varies.

every turn when player is in Airy Station:
	increment airy-wait;
	if airy-wait is 5:
		say "You jiggle the hammer in your hand, nervously. There has to be a way to use it, or change it. Maybe more than one.";
		now airy-wait is 0;

check entering Return Carriage:
	say "You approach the whitespace around the return carriage, then try a new line of entry, but you have to admit failure and retreat to backspace. Those caps locks--you can't find a way to control [']em." instead;

check attacking lock caps:
	say "Your plain old hammer doesn't do much." instead;

instead of doing something with lock caps:
	if current action is attacking or action is undrastic:
		continue the action;
	say "They're pretty secure, for locks. You can't see how to start to open them." instead;

after printing the locale description for Airy Station when Airy Station is unvisited:
	say "The crowd's adulation shakes you a bit. You worry you'll be stuck in charge of the whole place, and you might get corrupted like the [bad-guy] or whatever. So you make a speech about how someone local should rule--and they eat it up! They praise your humility!";
	say "An odd vehicle rolls out. 'The Return Carriage!' shots the mentality crowd. 'It's for you! To go back to your world! And do great things there!'";
	move return carriage to Airy Station;

check going in Airy Station:
	if noun is inside:
		say "You need to figure how to open the Return Carriage first." instead;
	else:
		say "You won't get through the Mentality Crowd. They want you to get into the Return Carriage." instead;

part Out Mist

Out Mist is a room in Endings. "It's very misty here, but you can still see a worm ring nearby. At the moment, it's cannibalizing itself too much to be whole.[paragraph break]It's silent here and tough to see, but you're pretty sure your pursuers aren't approaching any more."

check going nowhere in Out Mist:
	say "No. This is the first thing you stumbled on, and getting more or less lost both seem equally bad." instead;

check going inside in out mist:
	try entering worm ring instead;

check entering worm ring:
	say "Hm. Enter ring, enterring--it might be simple, but it's not that simple. Because there's not enough space for you to fit, as is. But it looks and feels pliable. You may need to modify it a bit--somehow." instead;

to good-end:
	say "The Whole Worm is bigger than you thought. You hide deeper and deeper. A passage turns down, and then here's a door. Through it you see your bedroom.";
	go-back-home;

understand "like ring" and "ring like" and "ringlike" as a mistake("You sort of like the ring the way it is, but you'd like it much better another way.") when player is in Out Mist.

understand "ear ring" and "ring ear" and "earring" as a mistake("You aren't rebellious enough to pierce, well, anything.") when player is in Out Mist.

understand "let ring" and "ring let" and "ringlet" as a mistake("Your hair curls at the thought of such passivity.") when player is in Out Mist.

understand "master ring" and "leader ring" and "ring master" and "ring leader" as a mistake("You're RUNNING from the [r-m-l], and you've already spent time mastering the Problems Compound.") when player is in Out Mist.

to say r-m-l:
	let x be word number 1 in the player's command;
	if word number 1 in the player's command is "ring":
		now x is word number 2 in the player's command;
	say "[x]";

understand "ring change" and "ring tone" and "ring hollow" as a mistake ("Ooh! Almost.")

understand "ring [text]" and "[text] ring" as a mistake ("Nothing happens to the ring. It sits there as lumpy as before.") when player is in Out Mist.

understand "worm [text]" and "[text] worm" as a mistake ("The worm ring's problem isn't that it's a worm, but rather that it's a ring.") when player is in Out Mist.

understand "worm bait" and "bait worm" as a mistake ("It's an inanimate worm, and -- well -- you might rather try fishing with things to do to a ring.") when player is in Out Mist.

the worm ring is scenery in Out Mist. "It's circular and seems to be almost eating itself, Ouroborous-style, though it looks a bit slushy on the inside that you can see. You can't quite enter it, but maybe if it straightened out into a regular worm...or if you made it less fat, or thick, or dense...so many possibilities, but maybe the right thing (or things) to do will be simple."

check wearing ring:
	ignore the can't wear what's not held rule;
	say "Hm, a good try, but it would be wearing to wear it. It's just--not useful as is, and you need to modify it." instead;

Rule for deciding whether all includes worm ring when player is in out mist: it does.

chapter verbs for wood

worming is an action applying to one thing.

understand the command "change" as something new.
understand the command "tone" as something new.
understand the command "hollow" as something new.

understand "hollow [thing]" and "tone [thing]" and "change [thing]" as worming when player is in Out Mist.

does the player mean worming the worm ring: it is very likely.

carry out worming:
	if noun is not worm ring:
		say "That's the right idea, but the wrong thing to do it to." instead;
	say "You scoop out the innards of the worm. The moment they're outside the worm, it extends a bit more. Then it twitches and straightens.";
	wfak;
	say "It's a whole worm. What luck! You enter it, hoping things are still a bit flip flopped...";
	good-end;

part merged ending

end-stress-test is a truth state that varies.

to go-back-home:
	if end-stress-test is true:
		say "Yay! This worked. I am blocking the ending so you can try again.";
		continue the action;
	score-now;
	say "The door leads to your closet and vanishes when you walk through. You're hungry after all that running around. Downstairs you find some old cereal you got sick of--certainly not killer cereal (ha ha) but now you realize it could be Procrastination Cereal, Moping Cereal, or even something goofy like Monogamy Cereal--that little reverse will feel fresh for a while.";
	wfak;
	say "You laugh at your own joke, which brings your parents out, complaining your late night moping is worse than ever. You promise them it'll get better.";
	wfak;
	say "Back in your bedroom, you have a thought. The Baiter Master saying you miss obvious things. Another look at [i]The Phantom Tolllbooth[r]: the inside flap. 'Other books you may enjoy.' There will be other obvious things you should've discovered. But it's good you found something right away, back in the normal world. You're confident you'll find more--and that people like the Baiter Master or his allies aren't the accelerated life experts you built them up to be.";
	unlock-verb "anno";
	print-replay-message;
	see-if-show-terminal;
	end the story finally saying "Wisdom Received!";
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
			say "A better ending is [if T1 is true]still [end if]out there! [if assassination character is not in lalaland]There's something below the Assassination Character[else if Insanity Terminal is not in lalaland]The Insanity Terminal hides a clue[else]The Thoughts Idol still remains to torture Idiot Village[end if].";
	else:
		unlock-verb "great";
		if T1 is true:
			say "Congratulations, and for replaying to find the slightly better ending! I, and the imaginary people of Idiot Village, thank you!";
		if T1 is false:
			say "There's [if T2 is true]still [end if]a slightly different ending if you don't rescue Idiot Village from the Thoughts Idol, if you're curious and/or completist.";

book Bad Ends

Bad Ends is a region.

part Punishment Capitol

Punishment Capitol is a room in Bad Ends. "You've really hit the jackpot! I guess. Everything is bigger and better here, and of course you're constantly reminded that you have more potential to build character here than in Hut Ten or Criminals['] Harbor. And whether you grumble or agree, someone officious is there to reenforce the message you probably won't build that character. But you have to try![paragraph break]Oh, also, there's word some of the officers have a black market going with [bad-guy-2], too, but people who do that--well, there's never any evidence."

part Hut Ten

Hut Ten is a room in Bad Ends. "Here you spend time in pointless military marches next to people who might be your friends in kinder environs. Apparently you're being trained for some sort of strike on [bad-guy-2]'s base, whoever he is. As time goes on, more recruits come in. You do well enough, you're allowed to boss a few around. But it's not good ENOUGH."

part Beer Pound

there is a room called A Beer Pound. It is in Bad Ends. "Here prisoners are subjected to abuse from prison guards who CAN hold their liquor and NEED a drink at the end of the day. Though of course they do not go in for the hard stuff."

part In-Dignity Heap

In-Dignity Heap is a room in Bad Ends. "Here we have someone at the top of the heap, telling people to have a little respect for themselves, you know?"

part Shape Ship

Shape Ship is a room in Bad Ends. "Kids drudge away at tasks they're too smart for, being reminded that with that attitude they'll never be good for anything better than, well, this."

part Criminals' Harbor

Criminals' Harbor is a room in Bad Ends. "Many poor teens in striped outfits or orange jumpsuits plod by here."

part Maintenance High

Maintenance High is a room in Bad Ends. "A teacher drones on endlessly about how it's not necessarily drugs that are bad, that people can mess themselves up even worse than drugs, and there's a whole huge lecture on how to be able to integrate making fun of drug users and feel sorry for them, to be maximally interesting."

part Fight Fair

Fight Fair is a room in Bad Ends. "The [bad-guy] watches down from a video screen as much stronger people beat up on much weaker people. 'Use your minds! Be grateful they're not really hurting you!' Nobody dares call it barbaric. After all, it could be worse."

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
			say "[line break]It's the Stool Toad! You're back on the bench at Down Ground![paragraph break]'A popular place for degenerates. Future cell sleepers, I bet[activation of sleeper cell]. That'll be a boo-tickety for you.'[if your-tix < 4][line break]As you hold the ticket and rub your eyes, the Stool Toad walks back [to-js]. 'It's a darn shame!' he moans. 'Only one sleeping ticket per lazy degenerate, per day! Plenty of other ways to make their jeopardy double[activation of double jeopardy] so I can reach my quota!' You get the sense he wouldn't sympathize if you told him WHAT you dreamed about.[end if]";
			now caught-sleeping is true;
			move player to Down Ground, without printing a room description;
			get-ticketed "sleeping too long on the Warmer Bench";
			say "The Stool Toad leaves you in Down Ground, to think about what you did. Maybe even sleep on it. Ha ha.";
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

table of sleep stories [painful narratives]
b4-nar	now-nar	af-nar	b4-done	now-done	af-done
"'Dude, why do you read so much? It's sort of showing off.'"	"You are, for the moment, in English class. People are running circles around you discussing an assigned book. You overhear that YOU should be participating more, with all you used to read."	"You are outside an expensive charity dinner--not allowed in, of course. A grown-up version of the classmate who made fun of you in the past for reading blathers on about how reading books helps children become success stories."	true	true	true
"A teacher chides the class to be 'nice like Alec.' They aren't, at recess."	"Some fake contrarian says that just being nice isn't nearly enough, and it's so formulated."	"You face an onslaught of people who were apparently trying to be nice to you, but NO..."
"The rest of the class glares at your younger self for asking one too many 'why' questions."	"Classmates moan endlessly about research papers, and you figure there's probably some law against choosing a subject you'd like."	"A classmate all grown up espouses original dynamic thinking and how schools just don't do enough."
"A young version of a now ex-friend berates young you for a small inefficiency in code his father noted."	"The ex-friend, older now, wonders why you stink at big-picture programming for computer class despite writing that immaculate Quick Sort routine."	"The ex-friend is lecturing at a big conference now, about how coding is about flexibility and trading ideas, but there's still a great job market for low-level stuff most people totally fear."
"You feel slightly sick hearing what a smart young boy you are. Study hard, and the social stuff will work itself out later."	"You hear whispers that Alec may be smart, but he can't be bothered to, you know, work well with other people. People who do the organizational stuff."	"You're stuck listening to a self-help guru tape blathering how what REALLY matters is how well you work with other people, and if brainy types never bothered to get this, the worse for them."
"Your six-year-old self listens to a 'sophisticated' joke by eleven-year-olds you don't understand."	"Your peers tell a dirty joke they're shocked you don't understand, but they're sure you're learning important stuff."	"A college professor lambastes your lack of curiosity and/or research network when you draw a blank on his/her clever cultural reference."
"Memories of elementary-school classmates bugging you about what you're writing, only to grow shortly bored with it."	"Memories of fringe-group kids not willing to share their writing with such a math and science square."	"A vision of THAT guy hawking his 'creative' autobiography, which is total rubbish."
"Remembering the first time you kicked a kickball in the air. The bully waiting under it, saying don't bother to run. Dropping it and hitting you good, your teammates furious you didn't try."	"Smart semi-friends laughing at the bully flunking a grade. Drug problems."	"Advanced-class peers discuss why you're not on the career track you should be. The bully joins in, saying if HE had your chances...they agree."
"You fail to deal with James Scott and Scott James both laughing at you for reading in third grade."	"You remember Bradley George and George Bradley arguing if you are just lazy or clueless. It's unclear whether they'd rather acknowledge if you're in earshot, or not."	"In the future, you see co-workers Simon Terry and Terry Simon argue over whether you should be fired because you concentrate too much on details or too much on big things."
"You remember being guilt tripped for falling asleep in church and reading the whole Bible personally."	"Other kids tell you religion is for wimps, why take it seriously, throwing logic-busters like 'Can God make an immovable object?' at you."	"You overhear a former classmate saying he wouldn't have made it in the world without The Lord, and stuff."
"You find yourself unable to win an argument or even convince a teacher a classmate hit you when the teacher's back was turned."	"Your head is left swirling by rampant lawyering of your classmates and how they seem to participate a lot better in class."	"You take a practice LSAT, ace it, and are told 'You could've been a good lawyer if you'd had a work ethic!'"
"You're told tolerance is important, to give more than you get, or else you're selfish."	"Some teens assure you that they're trying to tolerate you, and that's harder than you trying to tolerate them, so, give and take."	"You picture a future employer saying, well, he can pretty much tolerate anything (with community awards to prove it) except, well, you."
"Hearing 'Don't think you're special, son. The sooner you learn that, the better,' back in third grade."	"Hearing you didn't really distinguish yourself with any special skills for the job market."	"Being around people who wondered why you didn't try for anything special, because you could've if you wanted to."
"'Why would anyone want to write something like THAT?!'"	"'Wow! You're trying to, like, appeal to normal people with this writing, but, um, no.'"	"'Say, why don't you write any more?'"
"You're picked apart for knowing weird facts that aren't on any quiz."	"In school, you feel bad you never have anything interesting to add to right answers."	"You feel lost in a game of Trivial Pursuit you feel you should be much better at."

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

check going nowhere when mrlp is rejected rooms:
	say "You can't go [noun], but you can go [list of viable directions]. Also, you can look in the upper right to see which way to exit." instead;

part One Route

One Route is a room in Rejected Rooms. "Oh, hey, guess what? There's only one route out of here: to the west."

part Muster Pass

Muster Pass is a room in Rejected Rooms. "There's a lot of nice scenery here, but maybe not enough for a truly exciting fantasy world. Exits east and west seem equally suitable."

Muster Pass is west of One Route.

part Chicken Free Range

Chicken Free Range is a room in Rejected Rooms. "Well, actually, it's pretty much free of anyone. But you are free to go in all four directions.".

part Tuff Butt Fair

Tuff Butt Fair is a room in Rejected Rooms. Tuff Butt Fair is east of Chicken Free Range. "Well, the fair is empty, but you can go east or west."

Francis Pope is a person in Tuff Butt Fair. description of Francis Pope is "Dressed all in black and he doesn't have a popemobile."

check talking to Francis Pope:
	say "You don't want to hear his views on religion. They generally involve telling poor people to shut up and be happy and fake-smiling at anyone who disagrees with that." instead;

part Ill Falls

Ill Falls is a room in Rejected Rooms. Ill Falls is east of Tuff Butt Fair. "A breathtaking view of waterfalls, and yet--it seems possibly manufactured, and you hold your breath suppressing anger that might be the case.[paragraph break]You can only go back west to the fair."

The Flames Fan is a proper-named person in Ill Falls. "The Flames Fan waits here, ready to chat about anything allowing pointless arguments. He snort-laughs every thirty seconds at some idea he thinks you don't deserve to know.". description is "Surprisingly, he is not wearing a Calgary hockey jersey."

check talking to Flames Fan:
	say "He blows you off. He probably needs another person here so he can start a flame war and watch." instead;

part Eternal Hope Springs

Eternal Hope Springs is a room in Rejected Rooms. It is north of Chicken Free Range. "A pen fountain burbles happily here. Not a writing pen, but the fountain is caged in so you can really only see part of it and not appreciate its fully beauty, or maybe so people don't try to ruin it."

the pen fountain is scenery in Eternal Hope Springs. "You gaze at the fountain and wonder further why it's penned off. You hope there's a good reason."

part Brains Beat

Brains Beat is a room in Rejected Rooms. It is east of Eternal Hope Springs. it is east of Eternal Hope Springs. "The consciousness stream flows by here. It cuts off passage everywhere except back west."

the consciousness stream is scenery in Brains Beat. "One look at the consciousness stream, and immediately, voices in your head cool down a bit. You feel more--wait for it--conscious of what you need to do.[paragraph break]Okay, you would've if this were in the game proper. It was, at the start. But it quickly felt even more contrived than what you just played through."

part Rage Road

Rage Road is south of Chicken Free Range. Rage Road is in Rejected Rooms. "Fortunately, there is no sound of SUVs or hummers or sports cars about to run you over or get close to it or not stop at a crosswalk. Unfortunately, you flash back to all the times they did."

Rage Road is west of Muster Pass.

part Mine Land

Mine Land is a room in Rejected. Mine Land is west of Rage Road. "A very barren, unevenly pitted place. You can still hear echos of people who likely fought over it until it was wasted."

part Humor Gallows

Humor Gallows is west of Chicken Free Range. Humor Gallows is in Rejected Rooms. "Laughter goes to die here. Or it bursts up then dies quickly."

The Cards of the House are plural-named people in Humor Gallows. description is "They seem straining to create a laugh or, indeed, claim why others aren't as funny as they are."

check talking to Cards of the House:
	say "Nothing they say is funny. It's all inside jokes, or stuff about celebrities, or overgeneralization. You wish they could be dealt with (this is one of my very favorite bad puns. You're welcome.)[paragraph break]" instead;

part Madness March

Madness March is west of Eternal Hope Springs. Madness March is in Rejected Rooms. "You hear the distant sound of cheering and groaning about something people have no control over."

part Window Bay

Window Bay is north of Madness March. Window Bay is in Rejected Rooms. "It seems like your vision is sharper here than elsewhere. To keep you busy, a small structure labeled 'VIEW OF POINTS' is here."

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
		if the player consents:
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

check looking when alt-view is true and mrlp is bad ends:
	follow the room description heading rule;
	repeat through the table of alt-views:
		if location of player is therm entry:
			say "[thealt entry]";
			the rule succeeds;
	say "Oh, the atrocity!";
	the rule succeeds;

table of alt-views
therm	thealt
punishment capitol	"The place for the worst crimes, like attacking the [bad-guy]. Obviously, it had to be."
hut ten	"I never got to implement as many deaths as I thought, but this was an obvious pun along the lines of Stalag 17 or something."
beer pound	"This came up when I was looking for better names for the Sinister Bar (now the Soda Club) post-release. I wanted a place for alcohol-related offenses but had nowhere until this seemed a bit obvious."
shape ship	"What better place to get ship shape than on a shape ship? Again, the creative deaths/failures didn't pile up enough, but I still enjoyed imagining all this."
criminals' harbor	"This pun was too good to pass up. Maybe I should've saved it for the sequel. Maybe I will anyway. It's delightfully seedy."
maintenance high	"Most people who complain about others being high maintenance usually are emotionally high maintenance themselves. So I imagined a place where people learned WHY they were high maintenance and had it beat into their skulls. If they learned quickly, see, it was right. If not, well, they're taking up teaching time. Where people doled out abuse and projected their own deficiencies on others."
fight fair	"Of course, none of the fights in Fight Fair are remotely fair, and fights at fairs in general are, well, rigged. It also seemed to be a good way to underscore pitting less popular kids against each other, or against a bully-henchman to grind them down."
camp concentration	"I felt very, very horrible thinking of this, for obvious reasons, and similarly, I didn't want to put this in the game proper and fought about including it in the Director's Cut. I wasn't looking for anything provocative, but reading an online article, the switcheroo hit me. Because there's some things you clearly can't trivialize or pass off as a joke, or not easily. But I imagined a place where people yelled at you you needed to focus to stop making stupid mistakes, and of course it could be far FAR worse, and perhaps they want you to concentrate on that and also on being a productive member of society at the same time, when at the same time they'd never have such low standards themselves.[paragraph break]The gallows humor here I also saw is that the [bad-guy] never sends you here, because you aren't that bad, and of course he can use that to manipulate you, or say if this is mind control, there was other that was worse.[paragraph break]And while my writerly fee-fees are far from the most important thing, here, I was genuinely unnerved that I saw these links and my abstract-reasoning brain part went ahead with them, poking at the words for irony when there was something far more serious underneath."

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
	say "[line break]The vision blurs, and you look up from the View of Points, sadder but hopefully wiser."

before switching on the view of points:
	if current-idea-room is switch-to-bad:
		say "The view becomes darker. You've moved on to less desirable areas now. Places the [bad-guy] would've had people ship you if you really messed up.";
	increment current-idea-room;
	if the-view-room is camp concentration and the-view-room is unvisited:
		say "Oh dear. This final one's really bad. I felt awful thinking of the name. Because there's some stuff it's hard to provide a humorous twist to. You might want to skip it. I left it off the Trizbort map for a reason. See it anyway?";
		if the player consents:
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

chapter Camp Concentration

Camp Concentration is a room in Just Ideas Now. "This one's impossible to joke about straight-up. Just, the perpetrators are all, 'Well, of course it's not THAT bad, so quit moping.' Which isn't a lethal mind game, but it's a mean one."

chapter Expectations Meet

Expectations Meet is a room in Just Ideas Now. "People all discuss what they deserve to have and why they deserve it more than others. Well, most. There's some impressively nuanced false humility here, though you could never call anyone on it."

chapter Perilous Siege

Perilous Siege is a room in Just Ideas Now. "Some kind of combat is going on here! A big castle labeled [bad-guy-2-c]'S PLACE is surrounded by forces that can only be the [bad-guy][']s. Nobody's getting killed, but the insults are coming fast from each side."

chapter Robbery Highway

Robbery Highway is a room in Just Ideas Now. "There's a speed limit sign here, but it's just put there so anyone dumb enough to follow it will get mugged."

chapter Space of Waste

Space of Waste is a room in Just Ideas Now. "Piles and piles of things society apparently needs, but you have no use for. Magazines, mattresses, furniture, take-out boxes. A voice whispers: 'But you do! People buy them, and if you invested in a company that sells them, that makes you money.'"

chapter Clown Class

Clown Class is a room in Just Ideas Now. "One teen forcefully berates a class into how they're not funny, and they never will be, unless they shape up and start blending intelligence with social knowledge properly. And the way to start is to encourage people who are actually funny, but don't be a COPYCAT. He scoffs a lot at them, and assures them he's not laughing at their JOKES."

chapter Everything Hold

Everything Hold is a room in Just Ideas Now. "You see about one of everything you've ever owned or wanted to here. Considering it all makes you pause with jealousy--for what you don't have--and regret, for what you got and wasn't worth it."

chapter Shoulder Square

Shoulder Square is a room in Just Ideas Now. "People mill about here in pairs, shoulder to shoulder. One of each pair always tells the other what he should have done."

volume amusing and continuing

book amusing

rule for amusing a victorious player:
	let missed-one be false;
	say "Have you tried:";
	repeat through table of amusingness:
		if there is an anyrule entry:
			follow the anyrule entry;
		if the rule succeeded:
			say "[2da][biglaff entry][line break]";
		else:
			now missed-one is true;
	if missed-one is true:
		say "NOTE: both 'good' endings are mutually exclusive, so you missed a bit. But you can NOTICE ADVANCE to get back past the jerks and try the other, if you haven't seen it yet."

table of amusingness
biglaff	anyrule
"waiting?"	degen-true rule
"(first time only) thinking?"	--
"swearing (and saying yes or no) when the game asks if you want swearing?"	--
"an empty command?"	--
"XYZZY? Four times?"	--
"attacking anyone? Or the torch?"	--
"DIGging twice in Variety Garden?"	--
"DROPping the dreadful penny, reasoning circluar or other things?"	--
"giving the condition mint to various people, like Volatile Sal or Buddy Best?"
"cussing when you asked for no profanity?"	--
"cussing in front of certain people, especially authority figures (twice for a 'bad' ending)?"	--
"kissing the Language Machine?"	--
"drinking someone?"	--
"going west/north/south in the Variety Garden?"	--
"giving Pusher Penn's 'merchandise' to the Stool Toad or Officer Petty?"	--
"giving Minimum Bear to anyone except Fritz the On?"	--
"giving Minimum Bear to Fritz with the Howdy Boy gone? Or with four ticketies?"	--
"putting the poetic wax on/giving it to anything except the language machine?"	--
"saying YES or NO in the Drug Gateway?"	--
"visiting the Scheme Pyramid after the jerks take their revenge?"	--
"listening to all the songs from the song torch (there are [number of rows in table of horrendous songs])? Or just reading the source for them?"	--
"reading all the books from the book crack (there are [number of rows in table of horrendous books])? Or just reading the source for them?"	--
"taking the book bank?"	--
"SLEEPing in the extra directors' cut rooms in ANNO mode?"	--
"taking the Legend of Stuff after defeating the Thoughts Idol?"	very-good-end rule
"ENTERing the Return Carriage?"	very-good-end rule
"(XP/EXPLAIN)ing the lock caps?"	very-good-end rule
"MAN HAMMER, BAN HAMMER, HAMMER JACK, HAMMER NINNY, HAMMER SLEDGE in Airy Station?"	very-good-end rule
"WORM ROUND in the Out Mist?"	good-end rule
"LET RING or MASTER RING in the Out Mist?"	good-end rule

this is the degen-true rule:
	the rule succeeds;

this is the degen-false rule:
	the rule fails;

this is the good-end rule:
	if Out Mist is visited, the rule succeeds;
	the rule fails;

this is the very-good-end rule:
	if airy station is visited, the rule succeeds;
	the rule fails;

book altanswering

altanswering is an activity.

[rule for altanswering:]
		
this is the alt-answer rule:
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
"see where minor SWEARS change"	true	"SWEARS"	swear-see rule	swearseeing
"see the SINS the jerks didn't commit"	true	"SINS"	sin-see rule	sinseeing
"see the SPECIAL ways to see a bit more of the Compound"	true	"SPECIAL"	special-see rule	specialseeing
"see how to get to each of the BAD END rooms"	true	"BAD/END" or "BAD END"	bad-end-see rule	badendseeing
"see any reversible CONCEPTS you missed"	true	"CONCEPTS"	concept-see rule	conceptseeing
"see all the DREAM sequence stories"	true	"DREAM/DREAMS"	dream-see rule	dreamseeing
"see the plausible MISSES for the Terminal"	true	"MISSES"	alt-answer rule	altanswering

chapter dream

dreamseeing is an activity.

to decide which number is read-stories:
	let temp be 0;
	repeat through table of sleep stories:
		if b4-done entry is true and af-done entry is true and now-done entry is true:
			increment temp;
	decide on temp;

this is the dream-see rule:
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
		if the player consents:
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

chapter concept

conceptseeing is an activity.

this is the concept-see rule:
	say "There are [number of concepts] total concepts. I'll pause.";
	let curcon be 0;
	repeat with X running through concepts:
		unless X is an exp-thing listed in table of explanations:
			say "[X] needs an explanation. BUG.";
		else:
			choose row with exp-thing of X in table of explanations;
			say "[X]: [exp-text entry] ([howto of X])[line break]";
		increment curcon;
		if the remainder after dividing curcon by 10 is 0:
			wfak;

chapter bad end

badendseeing is an activity.

this is the bad-end-see rule:
	repeat with X running through rooms in bad ends:
		if X is not a badroom listed in table of bad end listing:
			say "[2da][X] needs a bad-end listing.";
		else:
			choose row with badroom of X in the table of bad end listing;
			say "[2da][X]: [howto entry][line break]";

table of bad end listing
badroom	howto
A Beer Pound	"Get your fifth ticket in A Beer Pound"
Criminals' Harbor	"Give a smokable to an officer, attack a woman, or attack machines in Freak Control"
In-Dignity Heap	"Careless swearing around the [bad-guy], Officer Petty or the Stool Toad"
Fight Fair	"Attacking other people"
Hut Ten	"Vandalizing things like the Insanity Terminal, Game Shell, Thoughts Idol,  or a logic game"
Maintenance High	"Choke on the gagging lolly"
Punishment Capitol	"Attacking the [bad-guy], Officer Petty, or the Stool Toad"
Shape Ship	"Get your fifth ticket outside A Beer Pound"

chapter special

specialseeing is an activity.

this is the special-see rule:
	unless assassination character is in lalaland:
		say "[2da]The assassination character can be faked out.";
	if assassination character is in lalaland and insanity terminal is not in lalaland:
		say "[2da]There are two hint devices beneath the Insanity Terminal.";
	if service community is unvisited:
		say "[2da]You could've explored the Service Community east and northeast of Idiot Village.";
	if idol is not in lalaland:
		say "[2da]You didn't find a way to defeat the Thoughts Idol.";

chapter sins

sinseeing is an activity.

this is the sin-see rule:
	say "None of the jerks was so square that he...[line break]";
	repeat through table of fingerings:
		if jerky-guy entry is Buddy Best:
			say " ... [blackmail entry][line break]";
	say "Not that there's anything wrong with any of the above. Or there would be, if the jerks were guilty. Um, interested. But you knew that. And, uh, I know that, too. Really!"

chapter swearing

swearseeing is an activity.

this is the swear-see rule:
	say "[2da]The Baiter Master is the Complex Messiah.";
	say "[2da]Buster Ball is Hunter Savage.";
	say "[2da]The Jerk Circle is the Groan Collective.";
	say "[2da]The Business Monkey's efforts are half-brained or [if allow-swears is true]ass[else]posterior[end if]ed.";
	say "[2da]If you actually swear, obscenely or mildly (BOTHER)--there's a small inner dialogue for swearing with swears off[line break]";
	say "[2da]A different reaction to repeatedly playing the logic puzzles[line break]";
	say "[2da]EXPLAIN Guy Sweet has a slight difference[line break]";
	say "[2da]Eating a food from Tray B turns swears on, if they were off[line break]";
	say "Welp, that's not much. I planned to have a lot more, but I just got sidetracked with silly stuff like bug fixing and adding to the story, which hopefully gave you less occasion to use profanity. Sorry about that."

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
	if ( (+ off-eaten +) || (+ cookie-eaten +) || (+ greater-eaten +)) { print "(Note: this is not the best ending, but you can skip back to Pressure Pier on restart with KNOCK HARD.)^"; }
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
Jerk Circle	4	3	"JERK "	"CIRCL"
Judgment Pass	5	3	"JGMNT"	"PASS "
Idiot Village	6	3	"IDIOT"	"VILLG"
Service Community	7	3	"SERVC"	"COMMU"
Bottom Rock	1	4	"BOTTM"	"ROCK "
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
Mine Land	0	1	"MINE "	"LAND "
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

index map with Bottom Rock mapped south of Disposed Well.

index map with The Belt Below mapped west of Bottom Rock.

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
5	"Okay. this is getting annoying."
50	"You will get it, somehow, some way. You hope."

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

rule for printing a parser error when the latest parser error is the didn't understand error:
	if player is in out mist:
		say "Hmm. You need to do something to the ring, but not that. Some action you haven't done yet. There may be more than one." instead;
	if player is in airy station:
		say "Hmm.  You need to change the hammer, somehow. There's probably more than one way to do it." instead;
	if the turn count is 1: [hack (??) for G on move 1]
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
	say "[activation of turn of phrase]I'll need a phrase of turn here." instead;

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
		if the player consents:
			replace the regular expression "with .*" in the last-command with "";
			say "After: [the last-command].";
			now the parser error flag is true;
			say "Trying new command...";
		else:
			say "OK.";
		the rule succeeds;
	say "You see nothing there like that. You may want to check for typos or excess words or prepositions."

Rule for printing a parser error when the latest parser error is the nothing to do error:
	if current action is dropping:
		say "You don't need to drop anything in the game, much less all your possessions.";
	else:
		say "Sorry, but right now ALL doesn't encompass anything. But don't worry, everything you need should be visible." instead.

Rule for printing a parser error when the latest parser error is the noun did not make sense in that context error:
	if current action is explaining:
		say "I couldn't find anything named that to explain.";
	else:
		say "The verb was ok, but you referred to something that hasn't come up yet in the game--and may not."

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

chapter bullpen

bullpen is a room in meta-rooms. "You should never see this. If you do, it is a [bug]." [the bullpen is for items that you dropped when you slept]

chapter conceptville

to say activation of (x - a thing):
	now x is in lalaland;

conceptville is a room in meta-rooms. "You should never see this. If you do, it is a [bug]." [this is a cheesy hack, as concepts you haven't seen yet are here, and when you see them, they move to lalaland.]

section misc concept(s)

a turn of phrase is a concept in conceptville. understand "phrase of turn" as turn of phrase. howto is "empty command"

wait your turn is a concept. understand "turn your wait" as wait your turn. howto is "waiting"

section intro concepts

a games mind is a concept in conceptville. understand "mind games" as games mind. howto is "very start".

Games confidence is a concept in conceptville. understand "confidence game/games" and "game confidence" as games confidence. howto is "talk to Guy"

Buster Ball is a concept in conceptville. understand "ball buster" as buster ball. howto is "talking"

Hunter Savage is a concept in conceptville. understand "savage hunter" as hunter savage. howto is "talking"

section surface concepts

Animal Welfare is a concept in conceptville. understand "welfare animal" as animal welfare. howto is "get the Weasel to sign the Burden"

nose picking is a concept in conceptville. understand "picking nose" as nose picking. howto is "smell the mush in Tension Surface"

work of art is a concept in conceptville. understand "art of work" as work of art. howto is "dig once with the pick in Variety Garden"

enough man is a concept in conceptville. understand "man enough" as enough man. howto is "dig twice with the pick in Variety Garden"

section soda club concepts

the Total T is a concept in conceptville. howto is "visit the Soda Club"

the Party T is a concept in conceptville. howto is "visit the Soda Club"

the Go Rum is a concept in conceptville. howto is "ask the Punch Sucker about drinks"

Rummy Gin is a concept in conceptville. howto is "ask the Punch Sucker about drinks"

section food concepts

a thing called Thought for Food is a concept in conceptville. understand "food for thought" as thought for food. howto is "visit Meal Square with Howdy Boy around"

Tray S is a concept in conceptville. howto is "enter Meal Square".

Tray T is a concept in conceptville. howto is "enter Meal Square".

Tray X is a concept in conceptville. howto is "enter Meal Square".

bowled over is a concept in conceptville. howto is "eat Tray B food"

growing pains is a concept in conceptville. understand "pain/pains growing" as growing pains.. howto is "eat off-cheese"

strike a balance is a concept in conceptville. howto is "try to take Tray A or Tray B"

face off is a concept in conceptville. howto is "take inventory after eating Tray B food"

section outer concepts

fish out of water is a concept in conceptville. understand "water out of fish" as fish out of water. howto is "examine the water in Pressure Pier"

Bum Beach is a concept in conceptville. howto is "examine the bench in Down Ground"

Sleeper Cell is a concept in conceptville. howto is "sleep then wait in Down Ground". understand "cell sleeper" as sleeper cell.

hoth is a privately-named concept in conceptville. howto is "give the weed to Fritz". understand "hog on/off the high" and "high on/off the hog" as hoth. printed name is "high off the hog"

bullfrog is a concept in conceptville. howto is "ask the Stool Toad how to get in trouble"

Trust Brain is a concept in conceptville. howto is "examine dreadful penny or mind of peace"

Moral Support is a concept in conceptville. understand "support moral" as moral support. howto is "examine pigeon stool"

section main chunk concepts

Double Jeopardy is a concept in conceptville. understand "jeopardy double" as Double Jeopardy. howto is "get ticket for sleeping"

Black Mark is a concept in conceptville. understand "mark black" as black mark. howto is "examine quiz pop"

Steal This Book is a concept in conceptville. howto is "take book bank"

Brother's Keepers is a concept in conceptville. understand "brother/brothers keeper/keepers" and "keeper/keepers brother/brothers" as Brother's Keepers. howto is "examine the brothers"

Candidate Dummy is a concept in conceptville. understand "dummy candidate" as Candidate Dummy. howto is "talk to Sly"

section endgame concepts

Crisis Energy is a concept in conceptville. understand "energy crisis" as Crisis Energy. howto is "get the [bad-guy]'s attention"

The shot mug is a concept in conceptville. understand "mug shot" as shot mug. howto is "get the [bad-guy]'s attention"

Slicker City is a concept in conceptville. understand "city slicker" as Slicker City. howto is "[bad-guy] dialog"

Admiral Vice is a concept in conceptville. understand "vice admiral" as admiral vice. howto is "[bad-guy] dialog"

The Break Jail is a concept in conceptville. understand "jail break" as Break Jail. howto is "lesser-end dialog"

Running Start is a concept in conceptville. howto is "try going south in Freak Control". understand "start running" as running start.

section xyzzy concepts

Captain Obvious is a concept in conceptville. understand "obvious captain" as captain obvious. howto is "xyzzy". 

a thing called Nonsense No is a concept in conceptville. understand "no nonsense" as nonsense. howto is "xyzzy".

Comedy of Errors is a concept in conceptville. understand "errors of comedy" as comedy of errors. howto is "xyzzy". 

Spelling Disaster is a concept in conceptville. understand "disaster spelling" as spelling disaster. howto is "xyzzy". 

section touch concepts

poke fun is a concept in conceptville. understand "fun poke" as poke fun. howto is "touch someone, or try"

touch base is a concept in conceptville. understand "base touch" as touch base. howto is "touch someone, or try"

section game-warp concepts

Sitting Duck is a concept in conceptville. understand "duck sitting" as Sitting Duck.

Hard Knock is a concept in conceptville. understand "hard knock" as Hard Knock.

Cut a Figure is a concept in conceptville. understand "cut a figure" as cut a figure.

Advance Notice is a concept in conceptville. understand "advance notice" as Advance Notice.

chapter lalaland

section pure eternal concepts

lalaland is a room in meta-rooms. "You should never see this. If you do, it is a [bug]."

Show Business is a concept in lalaland. understand "business show" as show business.

Wisdom Received is a concept in lalaland. understand "received wisdom" as wisdom received.

Something Mean is a concept in lalaland. understand "mean something" as Something Mean.

Complain Cant is a concept in lalaland. understand "cant complain" as Complain Cant.

People Power is a concept in lalaland. understand "power people" as People Power.

volume rule replacements

the can't insert into what's not a container rule is not listed in any rulebook.

the can't put onto something being carried rule is not listed in any rulebook.

check putting it on:
	try tying noun to second noun instead;
	say "That doesn't seem to fit." instead;

the can't put onto what's not a supporter rule is not listed in any rulebook.

understand "put [thing]" as a mistake ("PUT is too vague for the parser. You need to PUT something ON or IN something else.")

check inserting it into:
	if second noun is Alec Smart:
		try eating noun instead;
	try tying noun to second noun instead;

period-warn is a truth state that varies.

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
	if period-warn is false:
		if the player's command matches the regular expression " ":
			if the player's command matches the regular expression "\.":
				now period-warn is true;
				ital-say "extended commands may cause errors in rare cases such as E.N.W.GIVE X TO Y. This shouldn't happen often, but for future reference, it's a part of Inform parsing I never figured out. If you need to move around, GO TO is the preferred verb.";
	if player is in out mist:
		if the player's command includes "mist":
			unless the player's command includes "xp" or the player's command includes "explain":
				say "The mist doesn't seem as important as the ring." instead;
	if player is in airy station:
		if the player's command includes "home hammer" or the player's command includes "away hammer" or the player's command includes "lock hammer":
			try examining hammer;
			consider the shutdown rules;
			the rule succeeds;

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
				if (bigSwear) { print "'Dude! CHILL!' a voice says."; }
				if (smallSwear) { print "'You hear snickering at your half-body-parted swear attempts."; }
				rtrue;
			}
			if (returnNo)
			{
				if (bigSwear) { print "'Don't play mind games with us!' a voice booms. 'Just for that, you're in for it.'"; rtrue; }
				if (smallSwear) { print "'You sure can't! What a lame try.' a voice booms."; }
				rfalse;
			}
			if (bigSwear || smallSwear)
			{
			  print "'Waffling, but we get the point.'";
			  rtrue;
			}
		}
		times++;
		if (times == 4) { return 2; }
		print "I won't judge. And it won't affect the game. Yes or No (Y or N for short also works). ";
		print "> ";
	}
];

-)

volume testing bits

book ticking-debug

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
	if Q is Assassination character, decide no;
	if Q is Proof Fool, decide no;
	if Q is Francis Pope, decide no;
	if Q is Flames Fan, decide no;
	if Q is Turk Young, decide no;
	if Q is Labor Child, decide no;
	if Q is cards of the house, decide no;
	if Q is Uncle Dutch, decide no;
	if Q is Faith Goode, decide no;
	if Q is Logical Psycho, decide no;
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

test allanno with "anno/y/jump/w/w/w/e/n/e/e/w/w/w/e/n/e/w/w/n/e/w/w/n/x view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view/switch view"

test dream with "gonear bench/sleep/wake/sleep/z/wake/sleep/z/wake/sleep/z/wake"

test street with "talk to guy/1/1/1/1/1/1/play nim/in"

test street-bab with "bb/play nim/in"

test lounge with "get all/put screw in stick/climb chair/hit hatch"

test arch with "w/give token/dig dirt/e/e/dig earth/read burden/w/w/talk to weasel/1/2/2/2/2/2/2/2/2/give burden/e/give burden/n"

test arch-bab with "w/give token/dig dirt/e/e/dig earth/read burden/w/w/bb/give burden/e/give burden/n"

test pier with "e/sleep/z/z/z/e/get bear/s/talk to punch/1/2/2/2/3/n/talk to punch/2/2/talk to lily/1/1/1/1/1/1/1/1/give wine to lily/n/w/give bear to fritz/w/give paper to boy/n"

test pier-bab with "e/sleep/z/z/z/e/get bear/s/bb/y/bb/give drink to lily/n/w/give bear to fritz/w/give paper to boy/drop ticket/n"

test cutter with "j/j/j/test pier/s/w/eat cookie/y/e/n/n/n/n"

test startit with "test street/test lounge/test arch/test pier"

test to-bar with "test street/test lounge/test arch/talk to howdy/1/3/3/3/3/e/get bear/give bear to fritz/e/s"

test to-bar-bab with "test street/test lounge/test arch/bb/e/get bear/give bear to fritz/e/s"

test blood with "n/n/w/talk to buddy/1/1/1/s/s/w/w/n/x hedge/y/s/e/e/e/give tag/e/give seed to monkey/give contract to monkey/w/w/w/w/w/give blossom to faith/e/e/e/n/n/give mind to brother blood/s/s/bro 1"

test blood-bab with "n/n/w/bb/s/s/w/w/n/x hedge/y/s/e/e/e/give tag/e/give seed to monkey/give contract to monkey/w/w/w/w/w/give blossom to faith/e/e/e/n/n/give mind to brother blood/s/s/bro 1"

test soul with "n/e/in/talk to penn/1/2/2/y/2/2/out/w/s/s/e/give weed to fritz/w/n/n/e/in/give penny to penn/out/w/w/put pot in vent/x vent/open vent/e/n/give light to brother soul/s/s/bro 2"

test soul-bab with "n/e/in/bb/out/w/s/s/e/give weed to fritz/w/n/n/e/in/give penny to penn/out/w/w/put pot in vent/x vent/open vent/e/n/give light to brother soul/s/s/bro 2"

test big-old with "n/e/w/s/w/w/put string in hole/n/n/get sound safe/x finger/s/s/e/e/n/e/e/open safe/talk to story fish/get poetic wax/w/n/put wax in machine/wear trick hat/s/talk to charmer snake/w/s/w/w/in/give trap rattle to fool/out/e/e/n/n/give trade to brother big/s/s/bro 3"

test big with "n/e/get string/w/s/w/w/put string in hole/n/n/get sound safe/s/s/e/e/n/e/e/open safe/talk to story fish/get poetic wax/w/n/put wax in machine/wear trick hat/s/w/s/e/e/give hat to sly/w/w/w/w/in/give trap rattle to fool/out/e/e/n/n/give trade to brother big/s/s/bro 3"

test jk with "j/j/j/j/brobye/purloin finger/x finger/talk to jerks/talk to boris"

test final with "n/freak out/1/1/1/1/1/1/1/1/1"

test lastroom with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/n/explain me"

test winit with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/test final"

test winbab with "test street-bab/test lounge/test arch-bab/test pier-bab/test blood-bab/test soul-bab/test big/purloin quiz pop/n/n/drink quiz pop/test final"

test bestprep with "s/s/w/ctc/d/a bad face/d/get crocked half/u/u/e/e/e/ne/s/nw/e/sw/n/se/w/w/w/n/n"

test bestprep2 with "s/s/w/ctc/d/a bad face/d/get crocked half/u/u/e/e/e/e/nw/s/ne/w/se/n/sw/w/w/n/n"

test winbest with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/test bestprep/test final/away hammer"

test winfast with "gonear freak control/1/1/1/1/1/1/1/1"

test pops with "get pop/n/n/drink pop/n"

test arts-before-after with "gonear compound/x crack/x torch/purloin fish/play it/purloin safe/open it/x crack/x torch"

test all-tick with "gonear pier/e/sleep/z/z/z/tick/drop ticket/tick/e/e/e/e/e/tick/s/talk to lily/2/talk to lily/2/bb/y/abstract lily to soda club/bb/give drink to lily/bb/y/n"

test all-bad with "attack shell/attack guy/gonear pier/e/e/s/attack lily/tix 3/bb/y/talk to lily/2/talk to lily/2/n/n/shit/shit/purloin weed/give weed to toad/w/w/sleep/z/z/z/w/eat lolly/purloin weed/e"

section shipoffs

test shipoff with "attack game shell/gonear strip/shit/shit/gonear meal square/eat lolly/gonear labor child/attack child/tix 4/purloin brew/gonear soda club/n/gonear stool toad/attack toad/gonear stool toad/purloin weed/give weed to toad"

section bad endings

test cookie with "gonear meal square/get cookie/e/n/score/n/n/n"

test off-c with "j/j/j/j/s/w/get off cheese/e/n/score/n/n/n"

test greater-c with "j/j/j/j/s/w/get greater cheese/e/n/score/n/n/n"

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
	say "NOTE TO BETA TESTERS: the EST command lets you toggle whether or not a winning command ends the game, so you don't have to keep UNDOing. Whatever you can try is a big help.";

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
	if howdy boy is in lalaland:
		say "You may need to restart and KNOCK HARD to retry getting tickets, with the Howdy Boy gone.";
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
	say "Swearing is [on-off of allow-swears]";
	the rule succeeds;

chapter gqing

gqing is an action applying to one number.

understand the command "gq" as something new.

understand "gq [number]" as gqing.

understand "gq" as a mistake ("[gq-err]")

to say gq-err:
	say "gq (number) forces a variable that would be tedious to increase to what it needs to be. The game detects what to changed based on where you are or what you have.[paragraph break]# of game wins in smart street.[line break]# of idol failures[line break][line break]# of times used the Legend of Stuff for new hints[line break]# of Insanity Terminal failures[line break]-1 twiddles whether you re-saw a hint in the Legend of Stuff.[paragraph break]Some too big answers may give a 'bug' response, which isn't really a bug.[paragraph break]Adding 100 to the number = that many idol failures, adding 200 = that many terminal failures, adding 300 = smart street game-wins, adding 400 = turns before talking to BM, adding 500 = legend of stuff reads.[paragraph break]Sorry for the magic numbers, but coding alternatives were worse."

carry out gqing:
	say "If this wasn't what you wanted, type GQ for general help.";
	if the number understood is -1:
		if player does not have legend of stuff:
			say "You need the Legend of Stuff to twiddle whether you looked in it." instead;
			now reused-hint is whether or not reused-hint is false;
			say "You have now [if reused-hint is false]not [end if]reused a hint in the Legend of Stuff." instead;
	let Z be the number understood / 100;
	let Y be the remainder after dividing Z by 100;
	if Z > 5 or Z < 0:
		say "You can only use numbers from -1 to 599 for this test hack.";
		say "[gq-err] instead.";
	if player is in service community or player is in idiot village or Z is 1:
		say "Bad-guy taunt for idol failure critical values are:";
		repeat through table of bm idol brags:
			say "[times-failed entry - 1], [times-failed entry], [times-failed entry + 1] ";
		now idol-fails is Y;
		say "[line break]" instead;
	if player is in belt below or Z is 2:
		say "Bad-guy taunt for terminal failure critical values are:";
		repeat through table of terminal frustration:
			say "[term-miss entry - 1], [term-miss entry], [term-miss entry + 1] ";
		now terminal-errors is Y;
		say "[line break]" instead;
	if player is in smart street or Z is 3:
		say "Win chat critical values are: ";
		repeat through table of win chat:
			say "[win-check entry - 1], [win-check entry], [win-check entry + 1] ";
		say "[line break]";
		say "Guy taunt-as-you-leave values are:";
		repeat through table of win chat:
			say "[total-wins entry - 1], [total-wins entry], [total-wins entry + 1] ";
		now your-game-wins is Y;
		say "[line break]" instead;
	if player is in freak control or Z is 4:
		say "Bad-guy taunts for time taken: ";
		repeat through table of distract time:
			say "[control-turns entry - 1], [control-turns entry], [control-turns entry + 1] ";
		now freak-control-turns is Y;
		say "[line break]" instead;
	if player has Legend of Stuff or Z is 5:
		say "Bad-guy taunts for using Legend of Stuff: ";
		repeat through table of bm stuff brags:
			say "[times-failed entry - 1], [times-failed entry], [times-failed entry + 1] ";
		say "[line break]";
		now hints-used is Y instead;
	the rule succeeds;

chapter gating

gating is an action applying to one thing.

understand the command "gat" as something new.

understand "gat [something]" as gating.

gat-ruin is a truth state that varies.

to gat-ruin-check:
	if gat-ruin is false:
		say "NOTE: This ruins the game.";
		now gat-ruin is true;

carry out gating:
	if tension surface is unvisited:
		do nothing;
	else if pressure pier is unvisited:
		gat-ruin-check;
		now player has pick;
		now player has burden;
	else if howdy boy is not in lalaland:
		gat-ruin-check;
		now player has fritz;
		if player is in soda club:
			if player does not have haha brew:
				now player has cooler wine;
	else:
		gat-ruin-check;
		now player has poory pot;
		now player has dreadful penny;
		now player has wacker weed;
		now player has minimum bear;
		now player has long string;
		now player has reasoning circular;
		now player has poetic wax;
		now player has trick hat;
		now player has trap rattle;
		now player has trade of tricks;
		now player has relief light;
		now player has condition mint;
		now player has money seed;
		now player has fourth-blossom;
		now player has mind of peace;
		now player has legend of stuff;
		now player has crocked half;
	repeat with Q running through carried things:
		try giving Q to the noun;
	try taking the noun; [heck why not?]
	the rule succeeds.

chapter skiping

chapter nu-skiping

understand the command "skip" as something new.

understand "skip [number]" as nu-skiping.

nu-skiping is an action applying to one number.

skipped-yet is a truth state that varies.

lock-in-place is a truth state that varies.

carry out nu-skiping:
	if player is not in Smart Street:
		say "You already skipped. Doing so again is too messy to keep track of. You may wish to restart and try again.";
		the rule succeeds;
	if number understood is 0:
		say "[skip-list]" instead;
	if number understood is 100:
		move player to chipper wood;
		now lock-in-place is true;
	if number understood is 101:
		move-puzzlies-and-jerks;
		move player to bottom rock;
		now skipped-yet is true;
		the rule succeeds;
	if number understood is 102:
		move-puzzlies-and-jerks;
		move player to idiot village;
		now assassination character is in lalaland;
		open-bottom;
		now player has crocked half;
		now skipped-yet is true;
		the rule succeeds;
	if number understood is 103:
		move-puzzlies-and-jerks;
		move player to questions field;
		now assassination character is in lalaland;
		open-bottom;
		now player has crocked half;
		now thoughts idol is in lalaland;
		now skipped-yet is true;
		the rule succeeds;
	if number understood > 10:
		say "You need a number between 1 and 10 or, if you are testing very specific things, 100-103.[line break][skip-list]" instead;
	now skipped-yet is true;
	if number understood is 1:
		move player to round lounge;
		now player has gesture token;
	else if number understood is 2:
		duck-sitting;
	else if number understood is 3:
		knock-hard;
	else if number understood is 4:
		figure-cut;
	else if number understood is 5:
		move-puzzlies-and-jerks;
		move player to jerk circle;
		send-bros;
		if in-beta is true:
			now block-pier is true;
	else if number understood is 6: [notice advance]
		notice-advance;
		if in-beta is true:
			now block-pier is true;
			now block-other is true;
	else if number understood is 7:
		now all clients are in lalaland;
		now player has quiz pop;
	else if number understood is 8:
		move player to freak control;
	else if number understood is 9:
		move player to Out Mist;
	else if number understood is 10:
		move player to airy station;
	the rule succeeds;

block-other is a truth state that varies;
block-pier is a truth state that varies;

check going south in jerk circle when block-pier is true:
	say "You don't need to go back here for focused testing." instead;

check going when block-pier is true:
	if noun is west or noun is east:
		say "This is testing, so I won't allow you to move to the side." instead;

to say skip-list:
	say "1: Round Lounge 2: Tension Surface 3: Pressure Pier 4: Go to Jerk Circle 5: Brothers gone, Jerks not 6: Notice Advance (3 jerks solved) 7: Jerks Solved 8: Final Chat 9: Airy Station[line break]100. Chipper Wood/Assassination Character 101. Brothers gone, in Bottom Rock 102. Brothers gone, have crocked half in Idiot Village 103. Brothers gone, idol gone[line break]"

chapter montying

[* this turns testing stuff on and off. It will be more detailed later.]

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
"legend/hint"	false	"LEGEND HINTING"	try-hinting rule	"legend/hint"
"i/inventory"	false	"INVENTORY"	try-inventory rule	"i/inventory"
"s/smell"	false	"SMELLING"	try-smelling rule	"s/smell"
"l/listen"	false	"LISTENING"	try-listening rule	"l/listen"
"sc/score"	false	"SCORING"	try-scoring rule	"sc/score"
"dir/noway"	false	"GOING NOWHERE"	try-wid rule	"dir/noway"
"donote/note"	false	"DONOTEING"	try-noting rule	"donote/note"
"mood"	false	"MOOD tracking"	try-mood rule	"mood"

this is the try-mood rule:
	say "Your mood is [your-mood].";

this is the try-noting rule:
	try donoteing;

this is the try-wid rule:
	try going widdershins;

this is the try-hinting rule:
	hint-red;
	hint-blue;
	hint-big;

this is the try-inventory rule:
	try taking inventory;

this is the try-smelling rule:
	try smelling;

this is the try-listening rule:
	try listening;

this is the try-scoring rule:
	try requesting the score;

every turn (this is the full monty test rule) :
	repeat through table of monties:
		if on-off entry is true:
			say "========[test-title entry]:[line break]";
			follow the test-action entry;

chapter nobooing

[* this resets the boo ticketies]

nobooing is an action out of world.

understand the command "noboo" as something new.

understand "noboo" as nobooing.

carry out nobooing:
	move player to pressure pier;
	now trail paper is off-stage;
	now lily is in Soda Club;
	now lily-warn is false;
	now toad-got-you is false;
	now drop-ticket is false;
	now lily-done is false;
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
	if silly boris is in jerk circle:
		say "Do you wish to get rid of the jerks, too?";
		if the player consents:
			now all clients are in lalaland;
			now player has quiz pop;
			say "You now have the quiz pop.";
		else:
			say "If you want to, you can use JGO to get rid of the jerks, or just JERK to see who's 'guilty' of what.";
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

[* this lets testers bypass the Assassination Character]

acbyeing is an action out of world.

understand the command "acbye" as something new.
understand the command "ctc" as something new.
understand the command "ctp" as something new.

understand "ctc" as acbyeing.
understand "ctp" as acbyeing.
understand "acbye" as acbyeing.

carry out acbyeing:
	if assassination character is in lalaland:
		say "The assassination character is already gone!";
	else:
		say "I've sent the assassination character to the great beyond. This is not reversible except with UNDO or RESTART.";
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
	if jerk circle is unvisited:
		say "You haven't made it to the jerks yet." instead;
	if finger index is not examined or know-jerks is false:
		say "You need to have examined the Finger Index or learned the jerks['] names to see the clues. You haven't, but would you like to cheat?";
	if the player consents:
		now finger index is examined;
		now know-jerks is true;
	else:
		say "OK, this command will still be here." instead;
	repeat through table of fingerings:
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
	say "Bye bye jerks! Oh, you have the quiz pop, too.";
	the rule succeeds;

chapter soffing

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
		now player is in jerk circle instead;
	say "Now that you're in the main area, this command won't let you warp further in your beta testing quest. However, BROBYE will disperse the Brothers, JGO will spoil the jerks['] puzzle, and JERK(S)/GROAN(S) will clue it." instead;
	the rule succeeds;
