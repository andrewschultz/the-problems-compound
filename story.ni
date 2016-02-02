"The Problems Compound" by Andrew Schultz

the story headline is "A Direction of Sense: changing what's-thats to that's-whats"

volume initialization

Release along with an interpreter.

Release along with cover art.

use the serial comma.

use American dialect.

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
		if ((+ you-are-conversing +) && (i == RECAP__WD))
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

[when play begins (this is the debugging stuff first thing rule):
	rulesAll;]

the set debug first rule is listed first in the when play begins rules.

when play begins (this is the set debug first rule):
	now ignore-wait is true;
	let one-true be false;
	repeat with RM running through rooms:
		if map region of RM is nothing and RM is not lalaland and RM is not bullpen:
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
	sort the table of dutch-blab in random order;
	sort the table of painful narratives in random order;
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
		say "Also, do you wear gla--? Wait, no, that's irrelevant. Let's...let's get on with things.";
		wfak;
	say "It's not [i]The Phantom Tollbooth[r]'s fault your umpteenth re-reading fell flat earlier this evening. Perhaps now you're really too old for it to give you a boost, especially since you're in advanced high school classes. Classes where you learn about the Law of Diminishing Returns.[paragraph break]Or how protagonists gain character through conflict--conflict much tougher than class discussions you barely have energy for. You pick the book up--you shouldn't have chucked it on the floor. Back to the bookcase...";
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

section read what's been done

when play begins (this is the read options file rule):
	if file of verb-unlocks exists:
		read file of verb-unlocks into table of verb-unlocks;

the file of verb-unlocks is called "pcunlock".

table of vu - verb-unlocks [tvu]
brief	found	expound	descr
"anno"	false	true	"ANNO to show annotations, or JUMP to jump to a bunch of rejected rooms, as a sort of director's cut."
"knock"	false	true	"KNOCK HARD to get to Pressure Pier."
"figure"	false	true	"FIGURE A CUT to skip past the Howdy Boy to the [jc]."
"notice"	false	true	"NOTICE ADVANCE to skip to after you disposed of the jerks."
"good"	false	false	--
"great"	false	false	--

to unlock-verb (t - text):
	unless t is a brief listed in table of verb-unlocks:
		say "BUG! I tried to add a verb for [t] but failed. Let me know at [email] as this should not have happened.";
		continue the action;
	choose row with brief of t in table of verb-unlocks;
	if found entry is true:
		continue the action;
	if expound entry is true:
		say "[i][bracket]NOTE: you have just unlocked a new verb![close bracket][r]";
		say "On restarting, you may now [descr entry][line break]";
	now found entry is true;
	write file of verb-unlocks from table of verb-unlocks;

to decide whether (t - text) is skip-verified:
	if t is a brief listed in table of verb-unlocks:
		choose row with brief of t in table of verb-unlocks;
		if found entry is false:
			say "You don't seem to have unlocked that verb yet. Are you sure you wish to go ahead?";
			unless the player consents:
				say "OK. You can try this again, if you want. There's no penalty.";
				decide no;
			say "Okay. You can undo if you change your mind.";
			decide yes;
		decide yes;
	else:
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

a person can be smalltalked. a person is usually not smalltalked.

a person can be surveyable, baiter-aligned, or unaffected. a person is usually unaffected.

Procedural rule: ignore the print final score rule.

[the print final score rule does nothing.]

[use scoring.] [needed for 6l]

a thing can be abstract. a thing is usually not abstract.

a client is a kind of person. a client is usually male. a client can be specified. a client is usually not specified. a client has text called clue-letter.

to decide whether the action is undrastic:
	if examining, decide yes;
	if explaining, decide yes;
	decide no;

chapter misc defs for later

a drinkable is a kind of thing.

a smokable is a kind of thing.

a logic-game is a kind of thing. a logic-game has a number called times-won. times-won of a logic-game is usually 0. a logic-game has a number called max-won.

a logic-game can be tried. a logic-game is usually not tried.

volume stubs

section nicety stubs

to ital-say (x - text):
	say "[italic type][bracket]NOTE: [x][close bracket][roman type][line break]";

to score-now:
	increment the score;
	consider the notify score changes rule;

section rerouting verb tries

the last-command is indexed text that varies.

parser error flag is a truth state that varies.

Rule for printing a parser error when the latest parser error is the only understood as far as error:
	let nw be number of words in the player's command;
	if nw > 6:
		now nw is 6;
	say "That command seemed like it was longer than it needed to be. You may wish to cut a word or two down. Push 1 to retry [word number 1 in the player's command in upper case][if nw > 1] or up to [nw] to retry the first [nw] words, or any other key to try something else.";
	let Q be the chosen letter;
	d "[Q] vs 49 vs [48 + nw], [nw].";
	if Q >= 49 and Q <= 48 + nw:
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

[these 2 must be in release section since release code uses them trivially at points]

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

to say my-repo:
	say "http://github.com/andrewschultz/the-problems-compound"

section printing exits

print-exits is a truth state that varies.

definition: a direction (called myd) is viable:
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

check examining alec when cookie-eaten is true:
	say "Well, you know looks don't matter now. You're pretty sure you can take either tack. 'Even a guy looking like ME can have confidence' or, well, just having confidence.[paragraph break]Still, probably above average. Yup." instead;

description of Alec Smart is "[one of]You, Alec Smart, are just sort of average looking. You hope. You guess. But you know people who think they're average are below average, whether or not they know that bit of research.[paragraph break]In any case, looking at yourself tends to make you over-think, and you have enough thinking to do[or]You hope you're un-ugly enough to be a likable everyteen. Others take worse heat for their looks. Not that that makes you feel better[stopping]."

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
	if qbc_litany is the table of no conversation:
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

special-score is a number that varies. max-special-score is a number that varies. max-special-score is 4.

check requesting the score:
	if greater-eaten is true:
		say "You're more worried about scoring points with the right people than in some silly game." instead;
	if cookie-eaten is true:
		say "It's probably pretty good, but you're too cool for numbery nonsense." instead;
	if off-eaten is true:
		say "Oh man. You don't need yet another number assigned to your performance." instead;
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
	say "You have scored [score] of [maximum score] points.";
	if special-score > 0:
		say "[line break]";
		say "You have also found [special-score] of [max-special-score] points.";
	say "[line break]";
	if Questions Field is unvisited:
		say "You haven't gotten near the [bad-guy]'s hideout yet. So maybe you need to explore a bit more." instead;
	if qp-hint is true:
		say "You need some way to get past the question/exclamation mark guard combination. It's like--I don't know. A big ol['] pop quiz or something." instead;
	say "You have currently helped [if bros-left is 3]none[else if bros-left is 0]all[else][3 - bros-left in words][end if] of the Keeper Brothers." instead;
	say "You've found [number of endfound rooms] bad end[if number of endfound rooms is not 1]s[end if] out of [number of rooms in Bad Ends]: [list of endfound rooms]." instead;

to special-bonus:
	increment special-score;
	say "[i][bracket][if special-score is 1]You just found the first hidden secret in the Problems Compound[else]You found another secret[end if]. You are at [special-score] of [max-special-score] now.[close bracket][r][line break]";

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
	if player has trick hat:
		now player wears trick hat;

chapter waiting

check waiting (this is the caught napping rule):
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if player is in down ground and slept-through is false:
		say "[one of]You attempt to loiter in this seedy area in order to get in trouble or something, but no dice.[or]Still, nobody comes to break up your loitering.[or]You reflect if you want to get zapped for loitering, maybe you need to do better than just hang around.[or]Hm, you wonder what is even lazier than standing around.[stopping]" instead;
	say "You take a thought-second. Then you take another, but you reflect it wasn't as good. OR WAS IT?" instead;
	
every turn when player is in tense past and tense present is not visited:
	say "Torpor. You can't do much besides LOOK or WAIT or THINK.";

to move-dream-ahead:
	say "You let the dream sequence take its course. As usual, time spins out of control for you.";
	if player is in tense present:
		now player is in tense future;
	else if player is in tense future:
		now player is in tense past;
		increase nar-count by 1;
		if nar-count > number of rows in table of painful narratives:
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

check dropping:
	if noun is cooler or noun is haha:
		if your-tix >= 4:
			say "Now you're living on the edge with four ticketies, you're confident you can get away with dropping a drink to avoid getting busted by the Stool Toad.";
			now noun is in lalaland instead;
		if lily is in lalaland:
			say "You don't want to drink it, and nobody else seems to want it. So you throw it away, instead.";
			now noun is in lalaland instead;
	say "You don't need to leave anything lying around. In fact, you shouldn't." instead;

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
		say "Everyone seems richer than you." instead;
	say "You might need to GIVE someone an item to get something, but BUYing is not necessary." instead;

chapter thinking

think-score is a truth state that varies.

instead of thinking:
	if mrlp is dream sequence:
		move-dream-ahead instead;
	if finger index is examined and silly boris is in jerk circle:
		say "[finger-say]" instead;
	if think-score is false:
		say "NOTE: THINK will redirect to SCORE in the future.";
		now think-score is true;
	try requesting the score instead;

pot-not-weed is a truth state that varies.

chapter swearing

big-swear is a truth state that varies.

instead of swearing mildly:
	now big-swear is false;
	try do-swearing;

instead of swearing obscenely:
	now big-swear is true;
	try do-swearing;

do-swearing is an action applying to nothing.

carry out do-swearing:
	if player is in Soda Club:
		say "You reckon that's how people are supposed to cuss in a bar, er, club, but you can't give that word the right oomph." instead;
	if player is in cult:
		say "That'd be extra rude in a place like this." instead;
	if player is in wood and assassination is in wood:
		say "The assassin smirks[if p-c is true]. 'That won't do any good!'[else].[end if]" instead;
	if player is in belt and terminal is in belt:
		say "Sorry, man. I didn't mean for it to be THIS hard." instead;
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
	say "[im-im]pull." instead;

check pushing:
	if noun is a person:
		say "Physical force will work out poorly." instead;
	say "[im-im]push." instead;

chapter taking

the can't take what's fixed in place rule is not listed in any rulebook.

the can't take scenery rule is not listed in any rulebook.

before taking a person:
	if noun is weasel:
		say "He is too small and mobile." instead;
	say "You're not strong enough for the sort of WWF moves required to move a person." instead;

check taking:
	if noun is scenery or noun is fixed in place:
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
	say "You don't need to climb a lot here." instead;

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
		say "It smells bad enough from where you are standing. You don't want a snootful for no good reason." instead;
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

check smelling (this is the smelling a place rule):
	if player is in jerk circle and silly boris is in jerk circle:
		say "It smells like the [j-co] cooked a fancy meal recently. Or had one." instead;
	if player is in down ground:
		say "It smells okay here, but maybe that's because you're not too close to Fritz the On." instead;
	if player is in temper keep:
		say "[if sal-sleepy is false]You can understand why Volatile Sal is upset about smells, but you don't understand why he thinks it's other people.[else]Much nicer now with the poory pot in the vent.[end if]" instead;
	if player is in joint strip:
		say "It smells a bit odd[if off-the-path is true]. But you can't go off the path with the Stool Toad watching you[else]. You're tempted to check what's off the west/south path[end if]." instead;
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
		say "He gives off the occasiona HMPH." instead;
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
	if player is in Interest Compound:
		if phil is in Interest Compound:
			say "[one of]M[or]More m[stopping]usic from the song torch!";
			try examining song torch instead;
	say "Nothing crazy or unusual." instead;

chapter searching

the can't search unless container or supporter rule is not listed in any rulebook.

search-x-warn is a truth state that varies.

check searching:
	if search-x-warn is false:
		now search-x-warn is true;
		say "Most of the time, searching will be equivalent to examining in the game. So you can just type X (WHATEVER).";
	try examining the noun instead;

chapter eating

Procedural rule while eating something: ignore the carrying requirements rule.

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
		say "You don't have the authority or stength." instead;
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
	say "There are no locks in this game. Well, nothing you need to get through." instead;

chapter touching

understand "tag [thing]" as touching.

check touching:
	if noun is earth of scum:
		say "Ew. No." instead;
	if noun is bench:
		say "Mm. Nice. Warm. But not burning-hot." instead;
	if noun is Alec:
		say "You took a year longer than most to find out what that meant. You're still embarrassed by that." instead;
	if noun is assassination character:
		say "You'll need to [if p-c is true]catch him[else]ENTER the chase paper[end if]." instead;
	if noun is a person:
		say "That wouldn't be a fun poke." instead;
	say "You can just TAKE something if you want to." instead;

chapter taking inventory

check taking inventory (this is the adjust sleep rule) :
	if mrlp is dream sequence:
		say "You are carrying: (well, mentally anyway)[line break]  [if player is in tense past]Regret of past mistakes[else if player is in tense future]the weight of indecision[else]understanding of future failures but none of their solutions[end if][paragraph break]" instead;

chapter kissing

the block kissing rule is not listed in any rulebook.

check kissing:
	if noun is lily:
		say "The Stool Toad would probably be on you like a cheap suit." instead;
	if noun is punch sucker:
		say "If he does like men, you reflect, he could do a lot better than you." instead;
	if noun is faith or noun is grace:
		say "You don't know what sort of vows of chastity they took. Plus the other sister might beat you up for your indiscretion. Or just report you to the Stool Toad." instead;
	if noun is a bro:
		say "He needs something to hold, yes, but more like an object." instead;
	if noun is a person:
		say "You don't need to open yourself to gay-bashing. Despite equal rights blah blah, that stuff still HAPPENS in high school, because." instead;
	if noun is monkey or noun is child:
		say "As a businessperson, he doesn't have time for romance." instead;
	if noun is minimum bear:
		say "You're too old for that. You think." instead;
	say "Icky." instead;

chapter talking

check talking to alec:
	if cookie is in lalaland:
		say "You take time to discuss to yourself how people are dumber than they used to be before you had that Cutter Cookie." instead;
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
	if player is in interest:
		say "[if phil is in interest]You don't want to hear Phil's critique of your singing[else]You still can't compete with the song torch[end if]." instead;
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
	if cookie-eaten is true:
		say "Nonsense. Forward!" instead;
	if off-eaten is true:
		say "Ugh. Why would you want to go THERE again? It was no fun the first time." instead;
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
			say "No going backwards." instead;
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
		say "You don't need to look in directions. Nothing will ambush you if you just go that way." instead;

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
	if noun is torch:
		if phil is in Interest Compound or art is in Interest Compound:
			say "'VANDAL!' shouts [if phil is not in Interest Compound]Art[else if art is not in Interest Compound]Phil[else]the pair of impresarios[end if]. 'You don't realize how priceless it is!' Law enforcement arrives. There's only one place for unartistic lummoxes like you.";
			ship-off Hut Ten instead;
	if noun is mouth mush:
		say "How? By stepping on it and falling into it? Smooth." instead;
	if noun is arch:
		say "[if mush is in surface]Maybe you could do a flying karate-leap to touch the arch, but you'd fall into the mouth mush, so no[else]You should really just ENTER it now[end if]." instead;
	if noun is insanity terminal:
		say "It gives a ton of warning beeps. You run, but the Stool Toad and Officer Petty block the way up. 'Vandalism, eh? An expensive piece of property!'";
		ship-off Punishment Capitol instead;
	if noun is Baiter:
		say "Of course, with all those screens, he saw you well before you got close. He whirls and smacks you. Stunned, you offer no resistance as you're sent away to where those who commit high treason go...";
		ship-off Punishment Capitol instead;
	if noun is Stool Toad or noun is Officer Petty:
		say "'ATTACKING A LAW ENFORCEMENT OFFICER?' Ouch. You should've known better. And [noun] lets you know that in utterly needless detail, explaining just because you had no chance of beating him up doesn't mean it's not a very serious crime indeed.[paragraph break]It's almost a relief when he has finished shipping you off.";
		ship-off Punishment Capitol instead;
	if noun is a bro:
		say "'Silently, [noun] grabs you. [if bros-left is 1]Even without his brothers, it's a quick affair[else]His brothers hold you[end if]. He's apologetic--but he'd have liked to work with you, and violence is violence, and his job is his job.";
		ship-off Hut Ten instead;
	if noun is list bucket:
		say "You didn't come so far only to -- wait for it -- kick the bucket. Surely there's a better way to get the [bad-guy]'s attention." instead;
	if noun is a person:
		if noun is female:
			say "Attacking people is uncool, but attacking females is doubly uncool. You may not feel big and strong, but with that recent growth spurt, you're bigger than you used to be. While the Stool Toad's knight-in-shining-armor act goes way overboard, to the point [noun] says that's enough--well, it's the least you deserve. And you can't complain about where you're shipped off.";
			ship-off Hut Ten instead;
		say "You begin to lash out, but [the noun] says 'Hey! What's your problem?' [if joint strip is
		 visited]the Stool Toad[else]A big scary important looking man[end if] blusters over. 'WHOSE FAULT? QUIT HORSING AROUND!' You have no defense. 'THERE'S ONLY ONE PLACE TO REFORM VIOLENT TYPES LIKE YOU.' You--you should've KNOWN better than to lash out, but...";
		ship-off Fight Fair instead;
	if noun is language machine:
		say "[if wax is in lalaland]After you were so nice to it? That's rough, man[else]No, it needs compassion, here[end if]." instead;
	if noun is jerks:
		say "You've been suckered into lashing out before, but these guys--well, you've faced more annoying, truth be told." instead;
	say "Lashing out against inanimate objects won't help, here. In fact, you may be lucky this one's unimportant enough you didn't get arrested." instead;

return-room is a room that varies.

to ship-off (X - a room):
	move player to X;
	if X is a room-loc listed in table of ending-places:
		choose row with room-loc of X in table of ending-places;
		say "[room-fun entry]";
	say "Wait, no, that's not quite how it happened. It was tempting to lash out and step over the line, but you should probably UNDO that...";
	end the story;

table of ending-places
room-loc	room-fun
Fight Fair	"You are placed against someone slightly stronger, quicker, and savvier than you. He beats you up rather easily, assuring you that just because you're smart doesn't mean you needed to lack any physical prowess."

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

before giving to (this is the warn against giving to nonperson rule):
	if second noun is not a person:
		if give-obj-warn is false:
			say "(NOTE: instead of GIVEing to an inanimate object, you may wish to PUT X ON/IN Y instead.)[line break]";
			now give-obj-warn is true;

before giving to the rogue arch:
	if mouth mush is in lalaland:
		say "You've paid your way through. You can just enter the arch." instead;
	say "The rogue arch hasn't paid any attention to you, so you give [the noun] to the mouth mush instead.";
	try giving noun to mouth mush instead;

the block giving rule is not listed in any rulebook.

[the warn against giving to nonperson rule is listed first in the before giving to rulebook.]

book check/before giving

[there were too many CHECK GIVING rules and there were too many possibilities for fun stuff. So I thought I would put everything in order here.]

[#16 on github]

chapter item based

check giving smokable to:
	if second noun is stool toad:
		say "The Stool Toad jumps a whole foot in the air. 'How DARE you--on my turf--by me! OFFICER PETTY!' [if judgment pass is visited]Officer Petty[else]A man with a less fancy uniform[end if] rushes in and handcuffs you away and takes you to the...";
		ship-off Maintenance High instead;
	if second noun is Officer Petty:
		say "Officer Petty begins a quick cuff em and stuff em routine while remarking how that stuff impairs your judgement, and you seemed kind of weird anyway.";
		ship-off Maintenance High instead;
	if second noun is logical psycho:
		say "That might mellow him out, but it also might start him lecturing on the idiocy of anti-pot laws. Which you don't want, regardless of his stance." instead;

check giving a drinkable to:
	if second noun is lily:
		if lily-hi is not talked-thru:
			say "Lily ignores your offer. Perhaps if you talked to her first, she might be more receptive." instead;
		say "Lily looks outraged. 'This?! Are you trying to make me boring like you?! HONESTLY! After all the advice I gave you!' She takes your drink and pours it in your face before running off.";
		wfak;
		now noun is in lalaland;
		activate-drink-check;
		chase-lily instead;
	if second noun is punch sucker:
		say "'No refunds. Good thing it was free, eh?'" instead;
	say "This is a BUG. You shouldn't be able to carry liquor out of the Soda Club." instead;

check giving wacker weed to:
	if second noun is Fritz the On:
		say "You look every which way to the Stool Toad, then put your finger to your lips as you hand Fritz the packet. He conceals the stash and hands you a coin back--a dreadful penny. Proper payment for the cheap stuff.";
		increment the score;
		now wacker weed is in lalaland;
		now player has dreadful penny instead;

check giving minimum bear to (this is the fun stuff if you give the bear to someone else rule) :
	if second noun is Stool Toad:
		say "'DO I LOOK LIKE A SOFTIE?'" instead;
	if second noun is Fritz the On:
		say "'Dude! Minimum Bear!' he says, snatching it from you. 'I--I gotta give you something to thank you.' And he does. 'Here's a boo tickety I got for, like, not minding right. I've got so many, I won't miss it.'[paragraph break]";
		now Fritz has minimum bear;
		if your-tix >= 4:
			say "You decline Fritz's generous offer, since you're already in enough trouble with the Stool Toad. He winks at you in solidarity." instead;
		get-ticketed instead;
	if second noun is howdy boy:
		say "A momentary expression of rage crosses his face. 'Is this some sort of joke? You'd have to be wacked out to still like that.'" instead;
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
		now howdy boy is in lalaland;
		say "'Well done. You've acted up enough. Here, I'll shred the evidence. So you don't get caught later. Say, after all that goofing around, you might be hungry. Look around in Meal Square. But be careful.'";
		unlock-verb "figure";
		the rule succeeds;
	if second noun is Lily:
		say "She shrugs and mentions she's been better places." instead;
	if second noun is Punch Sucker:
		say "She is unimpressed with your attempt at being a Bad Boy." instead;
	if second noun is Stool Toad:
		say "He might put two and two together and arrest you." instead;

check giving pick to:
	if second noun is mouth mush:
		say "'Thanks, but I floss reguarly.'" instead;
	if second noun is weasel:
		say "'No! It's yours now! I'm not strong enough for manual labor, anyway. But you are.' He grins brightly." instead;

check giving gesture token to:
	if second noun is weasel:
		now token is in lalaland;
		now player has the pocket pick;
		say "He tucks away the token with a sniff. 'Well, it's not much--but, very well, I'll let you in my work study program. I won't even charge interest. Have this pocket pick. It'll help you DIG to find stuff. You can try it here, with the poor dirt!'" instead;
	if second noun is mush:
		say "'Pfft. Petty bribery. I need forms. Signed forms.'" instead;

check giving burden to:
	if second noun is mush:
		if burden-signed is true:
			say "With a horrible SCHLURP, the mouth mush vacuums the signed burden away from you. You hear digestive noises, then a burp, and an 'Ah!'[paragraph break]'That'll do. Okay, you stupid arch, stay put. And YOU--wait a few seconds before walking through. I'm just as alive as you are.' You're too stunned to step right away, and after the mush bubbles into plain ground, you take a few seconds to make sure the Rogue Arch is motionless.";
			now burden is in lalaland;
			now mouth mush is in lalaland;
			the rule succeeds;
		say "'It's not properly signed! And it's not officially a proof [']til it is!'" instead;
	if second noun is weasel:
		if burden-signed is true:
			say "'That's my signature. Don't wear it out.'" instead;
		if weasel-baiter is not talked-thru:
			say "'Oh no! You obviously need a little help being more social, but you haven't listened to me enough yet. That'll help. Totally.'" instead;
		say "The weasel makes a big show about how he would normally charge for this sort of thing, but then, signing for you means he'll feel less guilty rejecting an actual charity since he already did something for someone. He makes you sign a disclaimer in term absolving him if you do anything dumb.[paragraph break]Well, the proof is signed now.";
		now burden-signed is true instead;

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

chapter person based

chapter big one and default

[#16-2]

check giving (this is the big giving organized by room rule) : [this is a catch-all]
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

check giving (this is the default fall-through giving rule) :
	if noun is not a person:
		say "You should probably GIVE stuff to people. For inanimate objects, try PUT X ON/IN Y." instead;
	say "As you reach for that, [the second noun] blinks and looks at you. No, you don't see how they'd want THAT." instead;

[end giving rules block]

book common irregular verbs

chapter exitsing

exitsing is an action out of world.

understand the command "ex/exits" as something new.

understand "ex" and "exits" as exitsing.

carry out exitsing:
	let got-one be false;
	if player is in round lounge:
		say "The hatch above." instead;
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
	say "A hollow voice booms '[one of]Disaster spelling[or]Obvious, Captain[or]Nonsense? No[or]Errors of comedy[cycling]!'";
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
		say "Nothing to dig with." instead;
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
	if player does not have pocket pick:
		say "You have nothing to dig with." instead;
	if noun is t-surf:
		say "Doing that to a tension surface may release too much pressure. You're pretty good in science, so you worry about these things." instead;
	if noun is poor dirt:
		if dirt-dug is true:
			say "You don't feel a need or desire to dig any more here." instead;
		say "You start plowing the land. It's exhausting at first, but you suppose it's good practice. The Weasel compliments you on getting a bit of exercise and work experience and how it's win-win that way and you've paid off your debt now.";
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
	let found-yet be false;
	if noun is not explainable:
		say "That doesn't need any special explanation. I think/hope.";
	if noun is an exp-thing listed in the table of explanations:
		if anno-allow is true and told-xpoff is false:
			now told-xpoff is true;
		if anno-allow is false or no-basic-anno is false:
			say "[exp-text entry][line break]";
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

understand "explain [text]" as a mistake ("You've come across nothing like that, yet. Or perhaps it is way in the past by now.")

after explaining dots:
	if the player consents:
		say "[one of][or]Oh no! Forgot already? [stopping]From the lower right, go up-left two, right 3, down-left 3, up 3. It's part of 'outside the box' thinking. But you can also roll a paper into a cylinder so one line goes through, or you can assume the dots have height and draw three gently sloping lines back and forth.";
	else:
		say "Okay."

table of explanations [toe]
exp-thing	exp-text	exp-anno
dots	"These aren't a pun, but it's something mathy people see a lot of, and motivational speakers tend to abuse it. If you'd like the solution to the four lines to draw to connect all the points, and even other smart-aleck answers, say yes."
Poetic Wax	"To wax poetic is to, well, rhapsodize with poems or song or whatever. It's slightly less gross than wax."
Ability Suit	"Suitability means appropriateness. And the suit is not appropriate for the monkey."
blossoms	"Now that the blossoms are in place, well, it'd be mean to say they're 'some blah.'"
Buddy Best	"A best buddy is your favorite friend."
Insanity Terminal	"Terminal insanity is having no chance to regain sanity."
iron waffle	"A waffle iron is what you put batter in to make a waffle. But a waffle is also what you use when you don't know what to say. An iron waffle, then, would be something to say when you don't know what to say--but it is hard to take down."
note crib	"To crib notes is to copy from someone who was at a lecture."
Eye Witness	"Someone at the scene of the crime."
Gallery Peanut	"The peanut gallery is where people sit around and make wisecracks."
Off Cheese	"To cheese someone off is to annoy them."
gagging lolly	"Lollygagging is waiting around."
condition mint	"Mint condition is brand new."
cutter cookie	"Cookie-cutter means predictable and formulaic."
Alec Smart	"A smart alec is someone who always has a clever quip."
Dandy Jim	"Jim Dandy is something excellent."
Silly Boris	"Bore us silly."
Wash White	"To whitewash is to wipe clean."
Warner Dyer	"A dire warner has a message for you to keep away."
Warm Luke	"Lukewarm is not really warm."
Paul Kast	"To cast a pall is to give an air of unhappiness."
Cain Reyes	"To raise Cain is to be loud."
Pusher Penn	"A pen pusher is someone working at a boring job."
Cards of the House	"The house of cards is something that falls down easily."
View of Points	"Points of view are opinions."
picture of a dozen bakers	"A baker's dozen is thirteen, thus counting for the illusion."
Sly Moore	"More sly = slyer = cleverer."
fourth-blossom	"To blossom fourth is to grow."
Business Monkey	"Monkey business is general silliness."
Harmonic Phil	"Many orchestras bill themselves as philharmonic. I suppose they could be anti-harmonic, but an Auntie character felt a bit stereotyped, and Auntie feels a bit too charged."
Art Fine	"Why, fine art, of course. Highfalutin['] stuff, not easy to understand."
Song Torch	"A Torch Song is about looking back on a love you can't quite let go of. The Song Torch is more cynical than that, being a bit rougher on its subjects, and, well, actually torching them."
Finger Index	"The index finger is the one next to your thumb. Also, to finger someone means to point them out."
Jerk Circle	"You'll have to look on Urban Dictionary for that."
Drug Gateway	"A gateway drug leads you to bigger drugs, but here, the gateway may be blocking you from them."
Guy Sweet	"Guy Sweet is more of a candy-[a-word] than a sweet guy, but 'sweet guy' is such a terrible compliment as-is. To yourself or others."
Game Shell	"A shell game is where an operator and possibly an assistant rig a game so that mugs think it's an easy win, but they can't. The most popular one is when they hide a bean under a hollowed shell and shift them around."	"The game shell is a shell game of its own. No matter how much you solve, you won't impress Guy Sweet, and you won't--well--figure the real puzzles you want to, beyond logic etc."
Broke Flat	"Flat Broke means out of money."	"This was originally a location until I discovered A Round Lounge."
A Round Lounge	"To lounge around is to do nothing--the opposite of what you want."
Plan Hatch	"To hatch a plan is to figure a way to do something."
Word Weasel	"A weasel word is something that seems to mean more than it should."
Flower Wall	"A wallflower is someone who doesn't participate socially."
Variety Garden	"Garden-variety means ordinary, nothing special."
Vision Tunnel	"Tunnel vision is the inability to see anything other than what is in front of you."
Mouth Mush	"A mush-mouth is someone who talks unclearly or uses weak words."
Rogue Arch	"An arch-rogue is a big bad guy, obviously inappropriate for early in the story."
Twister Brain	"The opposite of a brain twister, where someone derives a conclusion from a fact, the brain has a set conclusion and twists and weights facts to line up with them."
Uncle Dutch	"A Dutch Uncle gives useful advice."
Turk Young	"A Young Turk is a brave rebel."
Story Fish	"A fish story is a long winding story."
Punch Sucker	"A sucker punch is hitting someone when they aren't looking."
jerks	"Pick one by name to see details."
Logical Psycho	"Psychological, e.g. in the mind."
Googly bowl	"To bowl a googly is to throw someone for a loop."
Faith Goode	"Good faith."
Grace Goode	"Good grace."
fund hedge	"A hedge fund is for super rich people to get even richer."
money seed	"Seed money helps an investment."
Labor Child	"Child labor is about putting children to tough manual labor."
Deal Clothes	"To close the deal means to agree to terms."
Trap Rattle	"A rattle trap is a cheap car."
relief light	"Light relief would be a silly joke."
Baiter Master	"[if allow-swears is true]Masturbater is someone who--pleasures himself[else]Messiah Complex means someone believes they're the chosen one[end if]."
Proof Fool	"Being fool-proof means you aren't suckered by anything."
yards hole	"The whole nine yards means everything."
Assassination Character	"Character assassination is the act of tearing someone down."
Brother Big	"Big Brother is the character from Orwell's 1984."
Brother Blood	"A blood brother is someone related by blood or who has sworn an oath of loyalty to someone else."
proof of burden	"The burden of proof means: you need to come up with evidence to prove your point."
Rehearsal Dress	"A dress rehearsal is the final staging of the play before the audience sees it."
hopper grass	"A grasshopper is a small insect. Also, 'grasshopper' is an overused term when describing what a wise man calls a disciple."
Brother Soul	"A soul brother is one who has very similar opinions to you."
the Book Bank	"A bankbook records numbers and is very un-literary."
Spleen Vent	"To vent one's spleen is to let our your anger."
Language Sign	"Sign language is how people communicate with the deaf."
Thoughts Idol	"Idle thoughts are what it purports to oppose."
Absence of Leaves	"Leaves of absence means taking time off."
Liver lily	"Lily-liver means coward."
Minimum Bear	"Bare minimum is the very least you need to do to get by."
dreadful penny	"A penny dreadful is a trashy novel."
haha brew	"Brouhaha is a commotion or noise."
long string	"To string along someone is to keep them trying or asking for more."
chase paper	"A paper chase is excessive paperwork. In this case, work not strictly needed to reach the Assassination Character."
cooler wine	"A wine cooler is very low in alcohol content."
pocket pick	"A pickpocket is a thief."
earth of scum	"Scum of the earth is the worst possible person."
Stool Toad	"A toadstool is a mushroom."
Pigeon Stool	"A stool pigeon is someone who tattles."
Language Machine	"Machine Language is very low-level, unreadable (without training) code of bits. No English or anything."
round screw	"To screw around is to do silly unproductive stuff."
round stick	"To stick around is to move nowhere."
gesture token	"A token gesture is something done as a bare minimum of acknowledgement."
off tee	"To tee off is to yell or punch out at someone."
fly bar	"A barfly is someone who goes around to bars and gets drunk."
boo tickety	"Tickety-boo means okay, all right, etc."
person chair	"A chairperson is someone in charge of things."
off brush	"To brush off is to ignore. It's more ignoring someone's ideas than ignoring them fully."
back brush	"To brush back is to repel someone or keep them out."
aside brush	"To brush aside is to ignore someone as you move past them."
against rails	"If someone rails against something, they're upset with it."
trail paper	"A paper trail is evidence in white-collar crimes. People often have to piece it together."
tension surface	"Surface tension is a scientific phenomenon where water can, say, go a bit above the top of a cup without falling out."
Howdy Boy	"Boy Howdy is a colloquial expression of surprise."
Intuition Counter	"Counterintuition means the reverse of what you'd expect."
Fright Stage	"Stage fright is being scared to get out in front of a crowd."
Trick Hat	"A hat trick, in hockey or soccer, is scoring three times."
Saver Screen	"A screen saver is often an amusing little graphic, animated or otherwise, on a computer that's been idle."
Fritz the On	"On the fritz means on the blink."
Poor Dirt	"Dirt poor means especially not rich."
picture hole	"Seeing the whole picture means you see everything."
warmer bench	"A bench warmer is someone who doesn't get into the action, especially in a sports game."
Quiz Pop	"A pop quiz is when a teacher gives an unannounced quiz on materials."
Poory Pot	"Potpourri, which smells good. Of course, I've read about pipe and cigar snobs who babble on about aromas and such."
the Reasoning Circular	"Circular Reasoning is, for instance, I'm smart because I'm clever because I'm smart."
a long tag	"To tag along is to follow behind."
Volatile Sal	"Sal volatile is given to wake up unconscious people with its smell."
Cold contract	"To contract a cold is to get sick."
Trade of Tricks	"Tricks of the Trade are things that outsiders to a specialty probably don't know that are a bit out of the range of common sense."
wacker weed	"A weed whacker is the slang for a gardening tool to cut weeds."
shot screens	"A screenshot is a still frame from a video."
list bucket	"A bucket list has things to do before you die."
call curtain	"A curtain call is when someone comes back out after lots of applause."
hammer	"The hammer can be three things[ham-desc]."
incident miner	"A minor incident is not a big deal, but the incident miner makes a big deal of small things."
worm ring	"A ringworm is a form of parasite."
greater cheese	"A cheese grater chops up cheese. Also, you do become a bit of a grater if you eat it."
Officer Petty	"A petty officer is actually reasonably far up in the hierarchy, the equivalent of a sergeant."
Sound Safe	"Safe, sound means being out of trouble. Also, the safe isn't very sound, as it's easy to open."
mind of peace	"Peace of mind means being able to think."
pen fountain	"A fountain pen is (these days) a typical pen. You don't have to dip it in ink to keep writing. It's less exotic than a pen fountain, of course."
consciousness stream	"Stream of consciousness is a form of writing that relies heavily on inner monologue."
Francis Pope	"Pope Francis is the current pope as of this game's writing."
Flames Fan	"To fan the flames is to keep things going. The Flames Fan just watches them."

to say ham-desc:
	choose row with brief of "great" in table of verb-unlocks;
	if found entry is true:
		say ": AWAY HAMMMER = hammer away = keep trying, HOME HAMMER = hammer home = to make a point forcefully, LOCK HAMMER = hammer lock = a wrestling hold";
	else:
		say " I can't spoil yet";

does the player mean explaining the player:
	it is likely;

carry out explaining the player:
	if debug-state is true:
		let count be 0;
		repeat with Q running through explainable things:
			if Q is not an exp-thing listed in table of explanations:
				increment count;
				say "[count]: [Q][if Q is privately-named](privately-named)[end if] ([location of Q]) needs an explanation.";
		if count is 0:
			say "Yay! No unexplained things.";
		unless the player's command includes "me":
			the rule succeeds;

definition: a thing (called x) is explainable:
	if x is a logic-game, decide no;
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

chapter xpoffing

xpoffing is an action out of world.

understand the command "xpoff" as something new.

understand "xpoff" as xpoffing when ever-anno is true.

no-basic-anno is a truth state that varies.

carry out xpoffing:
	now told-xpoff is true;
	now no-basic-anno is whether or not no-basic-anno is true;
	say "Basic explanations now [if no-basic-anno is true]don't [end if]appear with annotations.";
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

understand "verb" as verbing.
understand "verbs" as verbing.

to say 2da:
	say "[if screen-read is false]--";

carry out verbing:
	if mrlp is Dream Sequence:
		say "There aren't too many verbs in the Dream Sequence.";
		say "THINK or WAIT/Z moves the dream, and you can also LOOK. Your 'inventory' is strictly mental.";
		say "You can also WAKE[if caught-sleeping is true], which is the only way to get out now the Stool Toad caught you[end if].";
		the rule succeeds;
	say "[one of]The Problems Compound has tried to avoid guess-the-verb situations and keep the parser simple.[line break][or][stopping]Verbs needed in The Problems Compound include:[paragraph break]";
	if player is in smart street:
		say "[2da]PLAY/TRY any of the games in the shell.";
	say "[2da]directions (N, S, E, W, IN, OUT, ENTER something, and occasionally U and D)[line break]";
	say "[2da]OPEN X (no second noun needed)[line break]";
	say "[2da]PUT X ON/IN Y or ATTACH X TO Y. These are usually functionally equivalent.[line break]";
	say "[2da]GT or GO TO lets you go to a room you've been to.[line break]";
	say "[2da]GIVE X TO Y[line break]";
	say "[2da]TALK/T talks to the only other person in the room. TALK TO X is needed if there is more than one.[line break]";
	say "[2da]You shouldn't need any more prepositions than these.";
	say "[2da]specific items may mention a verb to use in CAPS, e.g 'You can SHOOT the gun AT something.'";
	say "[2da]conversations use numbered options, and you often need to end them before using standard verbs. RECAP shows your options.";
	say "[2da]other standard parser verbs apply, and some may provide alternate solutions, but you should be able to win without them.";
	say "[2da]Meta-commands listed below.";
	say "[2da]you can also type ABOUT or CREDITS or HISTORY to see meta-information, and XP/EXPLAIN (any object) gives a brief description.";
	if anno-allow is true or ever-anno is true:
		say "[2da]ANNO toggles director's cut information on rooms and gives more information to XP. Also, XPOFF turns off basic information, if ANNO is turned on.";
	say "[2da]EXITS shows the exits. While these should be displayed in the room text, you can see where they lead if you've been there.";
	say "[2da]HELP/HINT/HINTS/WALKTHROUGH will redirect you to the PDF and HTML hints that come with the game. THINK/SCORE gives very broad, general hinting. WAIT lets you wait.";
	if in-beta is true:
		list-debug-cmds;
	the rule succeeds;

to list-debug-cmds:
	say "DEBUG COMMANDS:[paragraph break][2da]J jumps you to the next bit from the Street, Lounge, or Way.[line break][2da]MONTY listens and smells and, if CRIB is toggled, looks at the note crib.[line break][2da]DONOTE lists the current note crib contents.[line break][2da]JERK tells you what to do with the jerks.[line break][2da]JGO gets rid of them[line break][2da]BROBYE kicks the Keeper Brothers out.[line break][2da]CTC clears the chase paper.";

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
	say "I was able to bounce technical and non-technical ideas off several other people. Wade Clarke, Marco Innocenti, Hugo Labrande, Juhana Leinonen, Brian Rushton and Matt Weiner offered testing and general encouragement and insight on what was a VERY short deadline given the game's size. An anonymous tester provided other direction.[paragraph break]Robert DeFord, Harry Giles and Steven Watson had ideas for the white paper and direction, as did the Interactive Fiction Faction, a private Google group. They include Hanon Ondricek, Robert Patten, Miguel Garza, Matt Goh and Joseph Geipel.[paragraph break]Jason Lautzenheiser's work on Genstein's Trizbort app (www.trizbort.com) was invaluable for big-picture planning and for adding in ideas I wasn't ready to code. If you are writing a parser game, I recommend it. (Disclaimer: I am a contributor, too.)[paragraph break]Many websites and resources helped me discover silly phrases. The Director's Cut has details on specific names, but www.thefreedictionary.com was a big help with its idioms search/subdomain idioms.thefreedictionary.com. Various compound word lists gave me ideas, too.";
	say "====IN-COMP THANKS:";
	say "I'd also like to thank people who alerted me to bugs in the comp version: Olly Kirk, Paul Lee, Michael Martin and Al Golden.";
	say "====POST-COMP THANKS:";
	say "Thanks to Alex Butterfield and Hugo Labrande for our games of code tennis, which is basically, try and do something every other day, or the other guy scores a point. Hugo worked with me more on a 'related project,' but a lot of things I pinged him with were relevant here.";
	the rule succeeds;

chapter abouting

abouting is an action out of world.

understand the command "about" as something new.

understand "about" as abouting.

carry out abouting:
	say "The Problems Compound is meant to be less puzzly than my previous efforts. If you need to see verbs, type VERBS. Though there's no hint command, a walkthrough should be included with the game.";
	say "[line break]TPC also, well, may suffer from AGT disease. It's intended to be a bit juvenile, but hopefully funny for all that. It was inspired by Hulk Handsome's very fun 2012 IFComp entry, In a Manner of Speaking and leans heavily on my 'researching' a website that you can find in CREDITS.";
	say "[line break]But more importantly, CREDITS lists my testers first, because they've helped make the game less rocky and found bugs that saved me time when I had (yet again) procrastinated.[paragraph break]Also, if you want, HISTORY will contain details about the game's history.";
	say "[line break]One other thing. If you find bugs, send them at [email] or visit the repository for the game at [my-repo]. If you can take a transcript of how it happens, use the TRANSCRIPT command and attach the file. Oh, also, I'm on twitter as @ned_yompus.";
	the rule succeeds;

chapter historying

historying is an action out of world.

understand the command "history" as something new.

understand "history" as historying.

carry out historying:
	say "I originally thought up this game in November of 2013. It had a completely different name, which I like a lot, but it didn't fit. PC went through several other names which sounded good but not good enough. The basic idea behind most room names etc. was unchanged.[paragraph break]I wanted to riff on some facet of language without being as abstract and obscure as Ugly Oafs, or as puzzly as the Stale Tales Slate or Threediopolis. The ideas poured in slowly, often by accident. Sometimes I'd overhear stuff, or I'd read an article or book, and there it was. Other times, I'd see a word I was sure had to work some way.[paragraph break]There were enough ideas that didn't fit my story line that I have a sequel and a name for it too. That name will be reveled in a successful ending.";
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
	say "You aren't famous or popular enough for your signature to mean anything, and besides, you have no pen, anyway." instead;

volume new rule (re-)definitions

the can't exit when not inside anything rule is not listed in any rulebook.

check exiting:
	if p-c is true:
		now p-c is false;
		say "You exit the chase paper." instead;
	if location of player is only-out:
		continue the action;
	if number of viable directions is 0:
		say "There's no way to exit.";
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
	now you-are-conversing is true;
	now anything-said-yet is false;
	now noun is smalltalked;

anything-said-yet is a truth state that varies.

after quipping:
	now current quip is talked-thru;
	now anything-said-yet is true;

the basic RQ out of range rule is not listed in any rulebook.

An RQ out of range rule for a number (called max) (this is the redone basic RQ out of range rule): say "[if max is 1]You've only got one choice left, the number 1. Type RECAP to see it, though it's probably just saying good-bye.[else][bracket]Whoah! You'd love to think of something awesome and random and creative, but all you can think of are the choices from 1-[max].  Type RECAP to relist the options.[close bracket][line break][end if]".

the block asking rule is not listed in any rulebook.

the block answering rule is not listed in any rulebook.

you-are-conversing is a truth state that varies.

to decide whether no-convo-left:
	let got-one be false;
	if qbc_litany is the Table of No Conversation:
		say "(note--there's a small programming bug I'd like to know about, if possible, at [email], though it shouldn't impact the game.)[paragraph break]";
		decide yes;
	repeat through qbc_litany:
		if enabled entry is not 0:
			decide yes;
	decide no;

before doing something when you-are-conversing is true:
	if player is in bottom rock: [skip out as you aren't really 'talking' to the crib]
		now you-are-conversing is false;
		continue the action;
	if current action is qbc responding with:
		continue the action;
	if current action is thinking or current action is listening:
		if qbc_litany is table of generic-jerk talk:
			continue the action;
	if no-convo-left:
		say "[bracket]NOTE: it looks like you hit an unexpected conversational dead end. Please let me know how this happened at [email] so I can fix it.[close bracket][paragraph break]";
		now you-are-conversing is false;
		continue the action;
	if current action is listening:
		say "Well, you just did, and now it's your turn to respond." instead;
	if current action is smelling:
		say "Others can throw you off with a well-timed sniff, but not vice versa." instead;
	if current action is going:
		if the room noun of location of player is nowhere:
			say "You can't escape the conversation that way!" instead;
		if qbc_litany is table of Punch Sucker talk:
			say "The Punch Sucker, with other customers to serve, is actually glad to be spared hi-bye small talk.";
			terminate the conversation;
			continue the action;			
		if qbc_litany is table of fritz talk:
			say "Fritz barely notices you wandering off to end the conversation.";
			terminate the conversation;
			continue the action;		
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

to quit small talk:
	now you-are-conversing is false;
	terminate the conversation;

volume annotations

chapter annoing

anno-allow is a truth state that varies.

ever-anno is a truth state that varies.

anno-check is a truth state that varies.

annoing is an action out of world.

understand the command "anno" as something new.

understand "anno" as annoing.

carry out annoing:
	choose row with brief of "anno" in table of verb-unlocks;
	unless anno-check is true or "anno" is skip-verified:
		now anno-check is true;
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
					say "([cur-anno]) [anno-long entry]";
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

section the table

table of annotations [toa]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	Tense Past	"past"	"These three rooms fell pretty quickly once I heard 'past tense.' Dreams have often been a source of helplessness for me, with one 'favorite' flavor being me as my younger self knowing what I know now, knowing I'd get cut down for using that knowledge. That snafu has grown amusing over the years, but it wasn't as a teen."
0	--	Tense Present	"present"	"Of course we've all had dreams about stuff we can't do now, or issues that keep coming up. I'd like to think that my bad dreams, once I confronted them, let me exaggerate things for humor in everday conversation. Still, it's been a developing process."
0	--	Tense Future	"future"	"We all worry about the future and what it will be, and we get it wrong, but that doesn't make it any less scary. I included this once I saw that dreams and fears could be traced into three segments: how you messed up, how you are messing up, and how you won't be able to stop messing up."
0	--	Smart Street	"smart"	"This came surprisingly late, but the reverse made total sense. The main point is that Alec may not be street smart, but people often assume he'll wind up somewhere around clever people."
0	--	A Round Lounge	"lounge"	"This came to me pretty late. I'm never quite sure how to start games. It always seems the best idea comes at the end, and yet on the other hand it's not fully comforting that I know how my story will end."
0	--	Down Ground	"jump"	"Some locations didn't make the cut, but they helped me figure out better ones.  However, Down Ground was one of the first and most reliable. It was behind Rejection Retreat, which has a double meaning I may reserve for another game.[paragraph break]You can now JUMP to or from random areas that didn't quite make it. Actually, you could've once you turned on annotation mode. But now you know you can."
0	--	A Round Lounge	"intro"	"The basic idea is that you start somewhere that's pretty normal, but people reverse their names." [start intro]
0	--	Tension Surface	"compound"	"I thought of making this the title of the game. But it was probably better to have it clue you to the room names. Anyway, It'd be hard to believe such a big world was part of a compound."
0	--	Variety Garden	"garden"	"The garden has a lot of variety, but it's plain, hence Variety Garden. Originally there was a Stream of Consciousness and Train of Thought, but these were immense placeholders. The Word Weasel didn't come until later, but I always liked that phrase. I went through a bunch of vegetables before I found an animal would do just as well."
0	--	Vision Tunnel	"tunnel"	"I'm pleased with the flip here since tunnel vision means narrowing things, but the vision tunnel opens you up to the different ways to see things."
0	--	Meal Square	"square"	"This was the Tactics Stall for a while, until I had enough food items for a separate area, and then I didn't have enough time to implement tactical items. I needed a place to put them. 'Sink kitchen' didn't quite work, but eventually I found this. The baker's dozen was my first scenery implemented, and I'm quite pleased at the bad pun. Also, the Gagging Lolly was the first silly-death thing I implemented."
0	--	Pressure Pier	"pier"	"This shuffled around a bit until I found someone who was adequate for pressuring you, as opposed to just talking you down. That was the Howdy Boy. And, in fact, he was just 'there' in Sense Common for a while. Early I took a 'best/worst remaining pun' approach to the map, but as I started writing code and sending the game to testers, I realized how it could make more sense."
0	--	Questions Field	"field"	"This was originally the Way of Right, which was sort of close to Freak Control, but then close to release I was searching for other names and this popped up. I liked it better--the three Brothers are asking questions--and it seemed less generic. So it stayed."
0	--	Court of Contempt	"court"	"As someone unimpressed by all the yelling that went on in law-firm shows when I was younger, any sort of court always seemed fearful to me. What would I be doing there? I was shocked when I got my first traffic ticket and went in to protest that it was relatively quiet and orderly. But the image and fears still remain, funnier now."
0	--	Interest Compound	"compound"	"This riffs a bit on the title, but the Directors of Bored--Art and Phil--well, this was called Directors of Bored for a while. Actually, before that, it was called Nation of Conster, before I decided to just work at real words for what's in the game."
0	--	Disposed Well	"well"	"This was originally the preserved well, and the Belt Below was below it. There was going to be a Barrel of the Bottom that opened, but it seemed too far-fetched. So I just went with a well where you couldn't quite reach something."
0	--	Scheme Pyramid	"pyramid"	"I find pyramid schemes endlessly funny in theory, though their cost is real and sad. They're worse than lotteries."
0	--	Standard Bog	"bog"	"This was something entirely different until the end. Something different enough, it might go in a sequel."
0	--	Soda Club	"bar"	"I forget what medieval text I read that made me figure this out."
0	--	Joint Strip	"strip"	"Sometimes the names just fall into your lap. It's pretty horrible and silly either way, isn't it? I don't smoke pot myself, but I can't resist minor drug humor, and between Reefer Madness and Cheech and Chong, there is a lot of fertile ground out there."
0	--	Classic Cult	"cult"	"Of course, a cult never calls itself a cult these days. It just--emphasizes things society doesn't. Which is seductive, since we all should do it on our own. But whether the thinking is New or Old, it remains. It can be dogma, even if people say it all exciting.[paragraph break]Plus I cringe when someone replies 'That's classic!' to a joke that's a bit too well-worn or even mean-spirited."
0	--	Speaking Plain	"plain"	"The people here do go in for plain speaking, but also, they just go in for speaking."
0	--	Crazy Drive	"drive"	"Crazy Drive is, well, not very crazy. But the places around it are."
0	--	Accountable Hold	"hold"	"I'm critical of Big Business and people who think they've done a lot more than they have because they have a good network they don't give much back to. In particular, if someone talks about accountability, it's a sad but safe bet that in a minute they will start blaming less powerful people for things out of their control. There's a certain confidence you need for business, but too often it turns into bluster."
0	--	Judgment Pass	"pass"	"This seemed as good a generic place-you-need-a-puzzle-to-get-by as any. Especially since I wanted solutions to focus around outsmarting instead of violence or pushing someone out of the way."
0	--	Jerk Circle	"circle"	"The idea of Jerk Circle made me laugh until I realized it might be a bit too icky to see too much. Thus it became part of the swearing-only part of the game once I realized the Groan Collective was an adequate replacement. Of course, when you know the 'other' name is Jerk Circle, there are still connotations. But the image of one person starting to groan encouraging others is very apt. Once I saw how the NPCs could interact, I felt even more amused."
0	--	Truth Home	"home"	"Of course, the truth home has lots of truth--it's just all misused."
0	--	The Belt Below	"belt"	"I wanted a seedy underbelly. And I got one."
0	--	Bottom Rock	"bottom"	"I forget when the idea of giving you a powerful item if you got abstract puzzles came to me. But I wanted it to be powerful and cleverly named. I wasn't sure where I could put a crib, because I couldn't implement a bedroom, but then I realized it could be discarded somewhere, because the Problems Compound is not for babies."
0	--	Idiot Village	"village"	"Of course, the people here aren't total idiots, even if they are very silly."
0	--	Chipper Wood	"wood"	"I got the idea for this when reminded of a certain Coen Brothers movie. The contrast of violence and happiness in the title made me realize it was a better choice than Rage Road."
0	--	Temper Keep	"keep"	"This is one of those ideas that came relatively late, but once it did, I had a few adjectives and verbs that tipped me off to a quick puzzle that should be in there."
0	--	Pot Chamber	"chamber"	"Some room names made me smile with their subtlety. Others, with their utter lack. Since this combines two awkward conversation subjects, guess which it was?"
0	--	Freak Control	"control"	"This was one of those rooms that made me realize I had a game. And I think the false humility in it ties up an important thing: the Baiter claims he's a bit of a dork, but he's like moderate and stuff. Except when he needs to be extreme to win an argument. The for-your-own good of how he went through it adds to the pile."

table of annotations (continued) [toa-views]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	Deal Square	"deal"	"This was one of the more obvious flips, but I already had the Scheme Pyramid and so forth. It tries to encapsulate how I'm a terrible negotiator fast and up close. Or was. I've learned that not feeling forced to say anything is big--and certainly, realizing I don't need something ASAP helps me prepare in advance for negotiations."
0	--	Everything Hold	"hold"	"The obvious pun here is that trying to hold everything physically often makes you hold everything in terms of time. So this seemed apt, but if I put anything in this room, I'd put in a lot, and that'd be way too much trouble to implement."
0	--	Mine Land	"mine"	"I definitely don't want to trivialize the devastating effects of land mines. And from a technical viewpoint, Mine Land would probably have been an empty room. But really, a bunch of people crying 'Mine! Mine!' is destructive in its own way."
0	--	Truck Dump	"dump"	"I've always found it depressing we need so many trucks, for garbage or transport or whatever. But I couldn't do anything with it in-story."
0	--	Space of Waste	"space"	"Like Mine Land, this is one of those areas that don't work well in a game, but all the same--so many spaces are space of waste."
0	--	Clown Class	"class"	"I had an idea of making Clown Class a dead end, or maybe even a separate game, but I couldn't pull it off."
0	--	Shoulder Square	"shoulder"	"I do like the pun shoulder/should, er. They mix well with shoulders tensing thinking what you should do."
0	--	Perilous Siege	"siege"	"The Siege Perilous is where Galahad was allowed to sit. It signified virtue. Of course, many of the antagonists in the Compound think they have virtue, but they don't. Since this room was so general, I didn't see a way to include it in the game proper."

table of annotations (continued) [toa-rej]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	--	One Route	"route"	"It was either this or One Square or Way One, at the beginning. But those two dovetailed nicely into a small puzzle."
0	--	Muster Pass	"muster"	"It was a close call between here and Judgment Pass, but only one could pass muster. Err, sorry about that." [begin speculative locations]
0	--	Rage Road	"rage"	"This flip made me giggle immediately, but it was one of those things where I could do better. The flipped meaning wasn't skewed enough. So when I stumbled on Chipper Wood, I decided to change it. That said, even though road rage is serious, coworkers and I riff on it when we're carrying lots of stuff and want pedestrians out of our way.[paragraph break]I also had ideas for a diner called Pizza Road."
0	--	Chicken Free Range	"range"	"The Chicken Free Range is, well, free of everyone. It was replaced by the Speaking Plain and Chipper Wood. As much as I like the idea of rotating two of three names, the problem is that you have six possibilities now, which gets confusing. Plus, free-range chicken may be a bit obscure, though I like the connotation of chicken-free range as 'THOU SHALT NOT FEAR.'"
0	--	Humor Gallows	"gallows"	"This was originally part of the main map, but the joke wasn't universal enough. I like the idea of killing jokes from something that should be funny, the reverse of gallows humor--which draws humor from tragedy or near tragedy. As well as the variety of ways jokes can be killed."
0	--	Tuff Butt Fair	"fair"	"This was one of the first locations I found, and I took it, and I put it in the game. Tough butt/tough but is a good pun, and I have a personal test that if I can picture pundits calling a person 'tough but fair,' that person is a loudmouthed critical jerk. The only problem is, 'fair but tough' isn't really a fair flip. It was replaced by the Interest Compound and Judgment Pass.[paragraph break]I originally thought of a lot of contemporary sounding people I could put in here, but they got rejected. Even Francis Pope (who'd be a rather nasty opposite of the Pontiff, whom I respect.) I wanted to keep it abstract and not Talk About Important People. However, for a truly atrocious inside joke, I was tempted to put in a bully named Nelson Graham who beat other kids up for playing games over three years old--or for even TRYING to make their own programming language. I decided agai--oops."
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

table of annotations (continued) [toa-items]
anno-num	exam-thing	anno-loc	anno-short (text)	anno-long (text)
0	round stick	lalaland	"stick"	"It took a bit of time to find the magic item to cross over. Originally it was the Proof of Burden, but that was too magical, too early. And that might've forced the mechanic on you. I think A Round Stick is a bit subtler."
0	game shell	lalaland	"Shell"	"This was originally a location, and its predecessor was the Gallery Peanut, which deserved a more prominent fate than I gave it. But once I moved it, it became obvious: a place where you could play games and win, but never really win anything valuable. Or you'd lose interest, or confidence."

volume the game itself

book beginning

Beginning is a region.

part Smart Street

Smart Street is a room in Beginning. "This isn't a busy street[one of], but there's a shell-like structure featuring all manner of odd games[or] though the Game Shell takes a good deal of space[stopping]. While you can leave in any direction, you'd probably get lost quickly.[paragraph break][if Broke Flat is examined]Broke Flat lies[else]The shell seems in much better condition than the flat[end if] a bit further away."

after looking in Smart Street when Guy Sweet is not in Smart Street:
	move Guy Sweet to Smart Street;
	say "A loud, hearty voice from the shell. 'Howdy! I'm Guy Sweet! You look like a fella who enjoys these sort of useless games that drive regular folk crazy! Why not come over to the Game Shell and have a TALK?'"

the player is in Smart Street.

rule for clarifying the parser's choice of games: do nothing;

games are plural-named scenery in Smart Street. description of games is "[bug]";

instead of doing something with games:
	if current action is playing:
		say "You should try PLAYing one at a time." instead;
	say "There are a whole bunch: [the list of logic-games]. And you can't really do more than PLAY any one of them."

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
guy-games	"'They're for people who don't like regular fun social games. Sort of like IQ tests. You look like you'd enjoy them more than most. No offense.'"
guy-stuck	"'Well, yeah, I used to be kind of a dork. And by kind of a dork I mean really a dork. Probably even worse than you. Hey, I'm showing some serious humility here. I mean, starting at the bottom, as a greeter, until I'm an interesting enough person to join the Problems Compound.'"
guy-advice	"'Hm, well, if I give you too much advice, you won't enjoy solving them. And if I don't give you enough, you'll be kind of mad at me. So I'm doing you a favor, saying just go ahead and PLAY.'"
guy-flat	"'Well, that way is the Problems Compound. If you can figure out some basic stuff, you'll make it to Pressure Pier. Then--oh, the people you'll meet!'"
guy-names	"'I know what you really want to ask. It's not at all about twisting things back around and making them the opposite of what they should mean. It's about SEEING things at every angle. You'll meet people who do. You'll be a bit jealous they can, and that they're that well-adjusted. But if you pay attention, you'll learn. I have. Though I've got a way to go. But I want to learn!'"
guy-problems	"'Well, it's a place where lots of people more social than you--or even me--pose real-life problems. Tough but fair. Lots of real interesting people. Especially the Baiter Master[if allow-swears is false]. Oops. You don't like swears? Okay. Call him the Complex Messiah[else]. AKA the Complex Messiah[end if]. But not [bg]. Even I haven't earned that right yet. His workplace, Freak Control, is guarded by a trap where a question mark hooks you, then an exclamation mark clobbers you.' He pauses, and as you're about to speak, throws in a 'YEAH.'"
guy-mess	"'Oh, the [bad-guy]. He certainly knows what's what, and that's that! A bit of time around him, and you too will know a bit--not as much as he did. But he teaches by example! And if he ribs you a little, that's just his way of caring. Remember, it's up to YOU what you make of his lessons! Some people--they just don't get him. Which is ironic. They're usually the type that claim society doesn't get THEM.'"
guy-bad2	"'[bad-guy-2]. Well, without the [bad-guy]'s snark, [bad-guy-2] would probably be in charge. Then things would get worse. You see, [bad-guy-2] is after our time and money. The [bad-guy] just likes to share a little snark.'"
guy-bye	"'Whatever, dude.'"

to say bad-guy:
	say "[if allow-swears is true]Baiter Master[else]Complex Messiah[end if]"

to say bad-guy-2:
	say "[if allow-swears is true]Buster Ball[else]Hunter Savage[end if]"

to say bad-guy-2-c:
	say "[if allow-swears is true]BUSTER BALL[else]HUNTER SAVAGE[end if]"

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
		quit small talk;

section Game Shell

the Game Shell is scenery in Smart Street. "It's shaped like a carved-out turtle's shell[one of]. Scratched on the side you see nine dots in a square with FOUR LINES THROUGH ALL POINTS scratched out below, then EVERYONE KNOWS THAT.[or][stopping]. Behind the counter, Guy Sweet half-smiles, staring at the games on offer."

the dots are part of the game shell. understand "square" and "nine" and "nine dots" as dots when player is in smart street.

instead of doing something with the dots:
	if current action is not explaining:
		say "No. You know that puzzle. You forget if you got it when you saw it, but people made you feel awkward for actually knowing it. Best not to dwell." instead;

instead of entering shell:
	say "'Whoah. Back up there, champ. We need to, like, verify your aptitude. Just PLAY a game here. Any game.'"

the games counter is part of the Game Shell. description is "[bug]"

instead of doing something with the games counter:
	say "It's there to keep you out. It's plain, but it has lots of games on it, though."

section leaving Smart Street

the gesture token is a thing. description is "It's got a thumbs-up and a finger-gun on one side and a fake grin and a sneer on the other. [if player is in smart street]It's the closest to congratulations you'll probably get from Guy Sweet[else if player is not in variety garden]You wonder where it could be useful[else]The Word Weasel seems to crane in and look at the coin[end if]."

check dropping gesture token:
	say "It seems worthless, but you never know. Anyway, it's harmless at worst in your pocket." instead;

check going inside when player is in Smart Street:
	if guy-games is not talked-thru:
		say "'Hey! You anti-social or something? Have, y'know, meaningful conversation before exploring there!'" instead;
	if guy-flat is not talked-thru:
		say "You don't know anything about Broke Flat. It might be really dangerous. Maybe you should ask someone about it. Even if the only someone around is Guy Sweet." instead;
	if your-game-wins is 0:
		say "'Dude! We need to, like, make sure you have aptitude before you go in there. Try one of these games, or something!'" instead;
	repeat through table of guy taunts:
		if your-game-wins <= total-wins entry:
			say "A final salvo from Guy Sweet: [guy-sez entry][paragraph break]";
			wfak;
			say "As you enter the flat, you hear a lock click--from the outside. There's no way out except down to a basement and a tunnel. At a dead end, you push a wall, which swivels and clicks again as you tumble into a lighted room. You push the wall again, but whatever passage was there isn't now.";
			continue the action;
	say "Guy Sweet remains quiet. He should not.";

table of guy taunts
total-wins	guy-sez
1	"'Thanks for not wasting my time with these dumb brain teasers too much, but all the same, doing the bare minimum...'"
2	"'I guess you're prepared and stuff. Or not.'"
6	"'Nice job and all, but the puzzles are a bit more social in there. You know, talking to other people? Just a tip.'"
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
		say "NOTE: this should be right, but if you see someone or something astray, ignore them.";
	move proof fool to lalaland;
	move logical psycho to lalaland;
	move harmonic phil to lalaland;
	move art fine to lalaland;
	move officer petty to lalaland;
	move sly moore to lalaland;
	move howdy boy to lalaland;
	move uncle dutch to lalaland; [they don't need to go but let's keep the focus]
	move turk young to lalaland;
	move reasoning circular to lalaland;

section notice advance

jumped-at-start is a truth state that varies.

noticeadvanceing is an action out of world.

understand the command "notice advance" as something new.

understand "notice advance" as noticeadvanceing.

carry out noticeadvanceing:
	if player is not in smart street:
		say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. You may wish to restart the game." instead;
	unless "notice" is skip-verified:
		now jumped-at-start is true;
		say "Guy Sweet yells 'Hey! Where are you going?'";
		notice-advance;
	the rule succeeds;

to notice-advance:
	move player to jerk circle;
	now all clients are in lalaland;
	send-bros;
	now player has quiz pop;
	now gesture token is in lalaland;
	
section figure a cut

figureacuting is an action out of world.

understand the command "figure a cut" as something new.
understand the command "figure cut" as something new.

understand "figure a cut" as figureacuting.
understand "figure cut" as figureacuting.

carry out figureacuting:
	if player is not in smart street:
		say "Oh, man! Looking back, you totally see a shortcut you should've at least checked at, back in Smart Street. But it's too late to skip ahead like that now. You may wish to restart the game." instead;
	unless "figure" is skip-verified:
		now jumped-at-start is true;
		say "Guy Sweet yells 'Hey! Where are you going?'";
		figure-cut;
	the rule succeeds;

to figure-cut:
	move player to jerk circle;
	now trail paper is in lalaland;
	now howdy boy is in lalaland;
	now gesture token is in lalaland;

section knockharding

knockharding is an action out of world.

understand the command "knock hard" as something new.

understand "knock hard" as knockharding.

carry out knockharding:
	if player is not in smart street:
		say "There's nothing to knock hard at. Or nothing it seems you should knock hard at.";
	unless "knock" is skip-verified:
		say "You stride up to Broke Flat with purpose, You knock, hard, hoping to avoid a hard knock--and you do! You are escorted to Pressure Pier, skipping a Round Lounge and the Tension Surface. (Note: if you wish to see those areas, you can UNDO.)[paragraph break]";
		now jumped-at-start is true;
		knock-hard instead;
	say "There's nothing to knock hard at." instead;

to knock-hard:
	move player to pressure pier;
	now gesture is in lalaland;

section chessboard

the chess board is a logic-game in Smart Street. description is "The chessboard has eight queens all of one color lumped into an almost-3x3 square in one corner."

understand "chessboard" as chess board.

section matchsticks

the match sticks are a plural-named logic-game in Smart Street. description is "Match sticks are arranged as equations or makeshift animals, apparently just a few flips away from becoming something new."

understand "matches" and "matchsticks" as match sticks.

section peg solitaire

Peg Solitaire is a logic-game in Smart Street. description is "It's an intersection of 3x7 rectangles with a hole in the middle. You know, where you jump a peg over another until--hopefully--they're all gone, except for one in the center."

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

the middle pole is part of the towers of hanoi. understand "left/right pole" and "left pole" as middle pole. description is "[bug]"

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

the river boat is a plural-named logic-game in Smart Street. description is "It's the old wolf, goat and cabbage puzzle. The figures are kind of cute, but it's easy to see how they could get lost."

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
	if current action is playing or action is undrastic:
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
Peg Solitaire	0	"You remember about symmetry, about not leaving pegs too isolated. Guy Sweet is impressed. 'Not bad! But I bet you can't do it again!'"
Peg Solitaire	1	"'Hey! That's not fair! You have a pattern! There's symmetry! That's cheating! I don't know how, but it is!'"
Peg Solitaire	2	"'Hey! No! Don't move the bottom peg up first! Challenge yourself!' It's confusing, but you figure what to push, where, much slower. Guy gives things a shot, bungles it and says, well, he has more important things to think of."
Peg Solitaire	3	"Guy brushes your hand away. 'I'm not interested any more. I'm sure you practiced hard to get so good, but it's kind of boring for me to watch, y'know? Maybe there's other formations that'll trip you up, but I'm too busy to think of them.'"
river boat	0	"You know this. You've aced this. Goat over, Wolf over, goat back, cabbage over, goat over. 'Everybody gets that one,' muses Guy, as he pulls out some additional tokens. 'Now, a boat with two entries.'"
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
necklace	0	"You remember the first time you solved it. After all, there were only seven--well, four places to cut the necklace. Three obviously didn't work. Your math teachers were suspicious you solved it a bit too quickly. Of course now everyone knows to cut the third link in, then 1+2+4 gets all numbers up to seven. Guy Sweet replaces the necklace with something longer. 'Yeah? Well, what if you got 2 cuts? How many numbers could you make?'"
necklace	1	"You get two cuts this time. 7+1=8, leaving a link of 9 chains. Then cut the 7 as before."
necklace	2	"The third puzzle is just more arithmetic. 17+1=18, so the next big link is 19, and so forth. You see the pattern. You tell Guy you could prove it by mathematical induction, but he cringes in fear. Wow! Micro-revenge! Usually YOU get tweaked for knowing stuff like that."
logic puzzles	0	"You don't even need the scratch paper Guy offers you. There are only so many possibilities and a lot of clues. 'Well, yeah, even I could do that,' he mutters. 'Try something more advanced?'"
logic puzzles	1	"It's a bit tougher, now. You hand-draw a grid on a piece of paper Guy gives you. There are more clues to wade through. It's sort of fun, nosing into people's houses (but not really) without having to ask any nosy que...[paragraph break]'Nice job. I knew a guy who can do it in his head--don't worry, you have more hope than him...' Guy takes the scratch paper and crumples it and throws it away. 'Aw, you couldn't have been ATTACHED to it, right?'"
logic puzzles	2	"You work away. It's a bit tedious, and you're not sure what you get, and you remember burning through a whole book so quickly your parents said you'd have to wait for a new one. It's knowledge you never lose, and as you mechanically fill in a few more, Guy crumples it and throws it."
logic puzzles	3	"It's--grr. You see a clear choice between seeming lazy and potentially boring Guy, and after some mental gymnastics, you opt for lazy.[paragraph break]There's a brain game in here for a third option you can't quite solve. [if allow-swears is true]Damn[else]Rats[end if]."

[gallery peanut]

section playing

playing is an action applying to one thing.

understand the command "play/try" as something new.

understand "play [something]" and "try [something]" as playing.
understand "play" and "try" as playing.

for supplying a missing noun when examining:
	now the noun is Alec Smart;

to say ok-rand:
	say "OK. If you want to see them all, X GAMES. Otherwise, PLAY will automatically pick a random game next time"

pick-warn is a truth state that varies.

rule for supplying a missing noun when the current action is playing (this is the play a game any game rule):
	if location of player is smart street:
		if guy sweet is not smalltalked:
			say "'What? You gonna just play any old game without chatting a bit first?'" instead;
		if pick-warn is false:
			now pick-warn is true;
			say "There are a lot of games. To be precise, [number of logic-games in words]. Pick one at random?";
			unless the player consents:
				say "[ok-rand]." instead;
			say "[ok-rand].";			
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
		the rule succeeds;
	now noun is Alec Smart;

carry out playing a logic-game:
	set the pronoun it to noun;
	set the pronoun them to noun;
	if guy sweet is not smalltalked:
		say "'What? You gonna just play this game without chatting a bit first?'" instead;
	repeat through table of logic game wins:
		if noun is the-game entry and num-wins entry is times-won of noun:
			say "[quote entry][paragraph break]";
			now the-game entry is tried;
			if gesture token is off-stage:
				now player has gesture token;
				say "'Oh, hey, and here's a little something to recognize you're good for something, or at something, or something.'[paragraph break]You turn it over after he hands it to you. Each side looks deliberately counterfeited.[paragraph break]'Buck up, bucko! That's a gen-u-ine gesture token! They're pretty rare. At any rate, I bet YOU'VE never seen one.'";
			unless max-won of noun is times-won of noun:
				increment times-won of noun;
				increment your-game-wins;
				check-win-chat;
			the rule succeeds;
	say "This is a bug. You've played out [noun].";
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
	if noun is Guy Sweet:
		say "Why not play one of his games instead?" instead;
	if noun is Alec Smart:
		say "You are trying to figure how NOT to play yourself." instead;
	if noun is chase paper:
		try entering chase paper instead;
	if noun is a person:
		say "You don't have the guile to play other people for suckers. You're not sure you want to." instead;
	if noun is language machine:
		say "Writing is no game." instead;
	if noun is insanity terminal:
		say "It's more a technical console than a gaming console." instead;
	say "You can only really play something that's explicitly a game." instead;

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

check dropping when player is in Round Lounge:
	if noun is off tee:
		say "But you made it with your own hands! It must be useful for something. You hope." instead;
	if noun is stick or noun is screw:
		say "You can't think of any reason to drop that. It seems no better or worse than the [if noun is screw]stick[else]screw[end if] to help you get out of here." instead;

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

Tension Surface is a room in beginning. it is inside of A Round Lounge. "While there's nothing here other than [if rogue arch is examined]the Rogue Arch[else]an arch[end if] [if mush is in surface]dancing sideways [end if]to the north, you're still worried the land is going to spill out over itself, or something. You can go east or west to relieve the, uh, tension. There's no way south or back down."

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
		say "Thankfully, nothing happens besides your surroundings changng from plains to water."

section mouth mush

the mouth mush is a person in Tension Surface. "[if mush is examined]The mouth mush[else]Some mush[end if] bubbles in front of the [r-a], conjuring up condescending facial expressions."

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
		quit small talk;
	continue the action;

part Vision Tunnel

Vision Tunnel is east of Tension Surface. Vision Tunnel is in Beginning. "The flower wall blocking every which way but west is, well, a vision[if flower wall is examined], and now that you've seen the picture hole in it, you can't un-see it[end if][if earth of scum is in vision tunnel]. Some icky looking earth is clumped here[end if]."

the flower wall is scenery in the Vision Tunnel. "All manner of flowers, real and fake, are sewed together. The only break is [if flower wall is examined]that picture hole[else][pic-hole][end if]."

to say pic-hole:
	say "[if picture hole is examined]the picture hole you looked through[else]a small hole, call it a picture hole, because it looks like there's some sort of picture in there[end if]"
	
check taking flower wall:
	say "The flowers seem delicately interconnected. If you take one, you fear the whole structure might collapse. And you fear loneliness, too." instead;

understand "flowers" as flower wall.

check going nowhere in vision tunnel:
	say "You barge into the flower wall and feel less alone with all that nature around you. This isn't practical, but it feels nice." instead;

the picture hole is scenery in vision tunnel. description is "[one of]You peek into the picture hole in the flower wall and see far more than you'd ever suspected. A whole story takes shape. [or][stopping]You recognize [one of]a stick figure[or]yourself, again[stopping] finding a ticket in a book, climbing a chair to reach a hatch, digging by a bunch of flowers, depositing a document in the ground--and then being blocked by three stick figures--blue, red and tall."

understand "vision" as picture hole when player is in tunnel and flower wall is examined.

understand "vision" as picture hole when player is in tunnel and flower wall is not examined.

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

check dropping the proof of burden:
	say "No. There's a part of you that always sort of believed what the proof said, even if it's said kind of snide. Most of the time, you just hear disbelief you're smart and you can't deal, but there may be help here." instead;

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

the off brush is scenery.

the back brush is scenery.

the aside brush is scenery.

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
	if noun is not east:
		now current-brush is aside brush;
		move aside brush to variety garden;
		say "You run into some brush. More precisely, you get close to it but turn to the side to avoid its prickliness. You look for a way around--it's not that dense, so there should be one--but no luck. 'Found the aside brush, eh?' snickers the Word Weasel." instead;

carry out going west in Tension Surface:
	if variety garden is unvisited:
		say "A small animal bounds up to you. 'Hi! I'm the Word Weasel, and this is the variety garden!'[paragraph break]'There's not much...'[paragraph break]'Well, you haven't noticed the absence of leaves! It's an absence of pretty much every leaf that was! And so much poor dirt!'";

chapter word weasel

the Word Weasel is a person in Variety Garden. description is "The Word Weasel[one of] looks pretty much like the weasels you imagined from those Brian Jacques novels you're too old for now, so you can't read the last few you wanted to. His[or][']s[stopping] facial expression seems to be going for 'so untrustworthy he's trustworthy.'". "The Word Weasel smirks about here."

check talking to weasel when burden-signed is true:
	say "He doesn't seem to want to talk any more, and come to think of it, neither do you, really. It's time to get a move on." instead;

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
		quit small talk;

table of quip texts (continued)
quip	quiptext
weasel-hi	"'Here to weed out people who don't belong. Ah, good, you didn't laugh at the weed/garden pun. There's hope for you yet! But I just have so much to say--you will listen to it all before asking anything of me, won't you?'"
weasel-foryou	"'Of course, you're really asking what I can do for you. Well, I like to trade, a bit. No need for chit-chat. Just GIVE me whatever. I have a tool you can use.'"
weasel-forme
weasel-arch	"'That's...a bit direct, isn't it? Just going from point A to point B, no worry about self improvement.'"
weasel-arch-2	"'That's...a bit circumspect, isn't it? Throwing in a few fancy words to seem like you care. Oh, all right. I'll sponsor you. Not with money. Just a reference or something.'"
weasel-sign	"'You haven't shown enough interest in things yet. Just in your own social progress. Ironic, but just like the others who come through here who aren't very social. It's just, you're just not good at it.'"
weasel-grow	"'I dunno. A muffin meadow, maybe?'"
weasel-why	"'It's not because I twist words. Oh, no! Well, I do, but I twist them to EXPAND the English language. Plus it shows a deal of self-knowledge to let myself be called that. Yes? Yes. Good.' He laughs hard, and you laugh a bit, and he says that just proves how much more well-adjusted he is than you."
weasel-more
weasel-pick-hey
weasel-freak	"'Yup. It's way in the north. It's guarded well. It has to be. He's all for equality, but that doesn't mean everyone deserves to bask in his cleverness equally.'"
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
	now pier-visited is true; [not the best way to do things but I need to reference something in I6 to modify the play-end text, and it's just cleaner to define a boolean in I7]
	unlock-verb "knock"
 
check going in Pressure Pier:
	if noun is west and trail paper is not in lalaland:
		say "'You're not authorized yet!' yells the Howdy Boy." instead;
	if noun is outside or noun is south:
		say "You can't see any way back." instead;
	if room noun of Pressure Pier is nowhere:
		say "You consider going that way, but you'd feel embarrassed walking into a wall or whatever, with or without people watching." instead;

water-scen is privately-named scenery in Pressure Pier. "It doesn't look dangerous or polluted or anything. You can probably just go east to see more of it."

understand "water" as water-scen when player is in Pressure Pier.

stall-scen is privately-named scenery in Pressure Pier. "It's a pretty large stall. But you won't be able to see what's in it [']til you go west."

instead of doing something with stall-scen:
	if action is procedural:
		continue the action;
	if current action is entering:
		try going west instead;
	say "You can probably just go east to see more of the water."

understand "stall" as stall-scen when player is in Pressure Pier.

instead of doing something with water-scen:
	if action is procedural:
		continue the action;
	say "You can probably just go east to see more of the water."

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
3	"Man. It's frustrating. People have pulled these moves on you. And you're pretty sure they're wrong. You've got no way to go around them."

table of saver references
reference-blurb
"Use 'fair enough' frequently to cool off someone who actually may have a point."
"Pretend to misunderstand everyone even if they're clear. If they don't stick up for themselves, well, they need to learn."
"Use 'y'know' a lot, especially when berating unnecessary adverbs."
"Smack [']em down with 'It's called...' two or three times a day."
"Make your I CAN'T and YOU CAN'T equally forcible."
"Make people feel like they blew it and they never had it in the first place."
"Say people need to put first thing first, then laugh at every other thing they say."
"If you can make people feel their weirdness is forcing you to lie to them, good for you!"
"Pick out an unsocial skeptic and be skeptical they actually care."
"Tell people you're not a mind reader, then say you know what they're thinking."
"A single 'I'm not mad at you' can go a long way."
"'Don't get me wrong' puts the burden on THEM. If you don't think you deserve to use it, you don't."
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

description of Howdy Boy is "Brightly dressed, with a just a bit too big smile."

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
howdy-north	"'Well, it gets a bit seedier there. Rougher. I'm sure you're nice and all, but it might be better not to be totally nice. Tell you what. You find me a trail paper, I let you by. It's made up of--oh, what do you call em? For not being a total kiss-up? Anyway, don't do anything too dumb. But you'll want to annoy authorities a bit.'"
howdy-west	"'Meal Square. But you can't get up to much trouble there.'"
howdy-baiter	"'I'm sure he'd like to welcome you individually, but he's just too busy fending off [bad-guy-2]. And thinking up his own philosophies. And making sure nobody weirds out too much, from his big observation room in Freak Control. So he delegates the greeting to me, while making sure nobody acts out the wrong way. Don't get me wrong. He's a geek/dork/nerd and loves the rest of us. Just, those who give it a bad name...'"
howdy-bye	"'Later. Be good. But not too good. That's just boring.'"

before quipping when player has trail paper:
	if player has trail paper and player is in pressure pier:
		say "Wait a minute! You've got the trail paper! Enough chit-chat!";
		now you-are-conversing is false;
		terminate the conversation;
		try giving trail paper to howdy boy instead;

after quipping when qbc_litany is table of howdy boy talks:
	if current quip is howdy-howdy:
		enable the howdy-boy quip;
		enable the howdy-int quip;
	if current quip is howdy-north:
		enable the howdy-fun quip;
	if current quip is howdy-fun:
		enable the howdy-ways quip;
	if current quip is howdy-bye:
		quit small talk;

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

the trail paper is a thing. description is "It looks pretty official. It's made up of the four boo ticketys, but now they're folded right, it may be just what the Howdy Boy wanted."

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

the boo tickety is a thing. description is "WHATEVER YOU DID: BOOOOOO is displayed on [if your-tix is 1]it[else]each of them[end if].[paragraph break]You have [your-tix] [if your-tix is 1]piece of a boo tickety
[else]pieces of boo ticketys[end if]. But [if your-tix is 1]it doesn't[else]they don't[end if] make a full document yet."

understand "boo ticket" and "ticket" as boo tickety.

drop-ticket is a truth state that varies.

check dropping boo tickety:
	if drop-ticket is false:
		now drop-ticket is true;
		say "As you drop it, you feel a tap on your shoulder. The Stool Toad, again![paragraph break]'Son, I'm going to have to write you up.' And he does. He gives you what you've dropped, plus a new boo tickety.";
		get-ticketed;
		do nothing instead;
	else:
		say "Either the Stool Toad will have given up on you, or he'll really get to bust you for a repeat offense. Neither seems to help you." instead;

the dreadful penny is a thing. description is "It has a relief of the [bad-guy] on the front and back, with 'TRUST A BRAIN' on the back. You hope it's worth more than you think it is."

your-tix is a number that varies.

to get-ticketed:
	increment your-tix;
	say "[line break]";
	if your-tix is 5:
		if player is in soda club:
			say "'Up to trouble, eh? I thought you might be.' The Stool Toad frog-marches you (ha! Ha!) out of the Soda Club to a rehabilitation area.";
			ship-off A Beer Pound;
		else:
			say "The Stool Toad looks all quiet. 'Son, you've gone too far. It's time to ship you out.' And he does. Even Fritz the On shakes his head sadly as you are marched past to the west.";
			ship-off Shape Ship;
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
		say "You now have almost a full paper from the boo ticketys.";
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
		quit small talk;

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
	if jumped-at-start is true:
		say "[one of]'There's something about you, young man. Like you've been shifty before. I can't trust you. So you better use some common sense. Or I'll use it for you!' booms the Stool Toad.[paragraph break]On further reflection, you figure there probably wasn't much in there. Much you need any more, anyway. Also, his last little put-down didn't make any sense. But it still hurt.[or]You don't want to be told off by the Stool Toad again. Whether or not he makes sense the next time.[stopping]" instead;
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
	get-ticketed;

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
		say "A tag says Minimum Bear. Cute, but not very.";
		now minimum bear is examined;
	else:
		say "You look around nervously as you pick Minimum Bear up. The Stool Toad scoffs slightly.";

check dropping Minimum Bear:
	say "No. It's somebody's. But whose?" instead;
		
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

the Stool Toad is a person in Joint Strip. "[one of]Ah. Here's where the Stool Toad went. He's sitting on a stool--shaped like a pigeon, of course.[paragraph break]'So! The new juvenile from Down Ground. Best you stay out of [if tix-adv > 0]further [end if]trouble.'[or]The Stool Toad, sitting on his pigeon stool, continues to eye you [tix-adv].[stopping]"

check talking to toad when trail paper is not off-stage:
	say "You don't want to let anything slip that could get you in further trouble, with all the boo-ticketies you accumulated." instead;

to decide what number is tix-adv:
	if fritz has minimum bear, decide on your-tix - 1;
	decide on your-tix;

to say tix-adv:
	say "[if tix-adv is 0]patronizingly[else if tix-adv is 1]somberly[else if tix-adv is 2]suspiciously[else]oppressively[end if]"

description of the Stool Toad is "Green, bloated and, oh yes, poisonous. Green and bloated, he reminds you of a security guard at your high school whose every other sentence was 'YOUNG MAN!'"

the pigeon stool is scenery in Joint Strip. "It's shaped like a curled up pigeon, though its head might be a bit too big and flat. It's kind of snazzy, and you'd actually sort of like one. You read the words SUPPORT MORAL on it and feel immediately depressed."

does the player mean doing something with the pigeon stool: it is likely. [more likely to use stool as a noun and all that]

instead of doing something with pigeon stool:
	if action is undrastic:
		continue the action;
	say "Since it's under the Stool Toad, there's not much you can do with it."

toad-got-you is a truth state that varies.

check going north in Soda Club:
	if player has a drinkable:
		if toad-got-you is false:
			say "'HALT! FREEZE! A MINOR WITH ALCOHOL!' booms the Stool Toad. He takes your drink and throws it off to the side. 'THAT'S AN INFRACTION!'[paragraph break]He looks around in his pockets but only finds a diagonal scrap of paper. 'Well, this'll do, for a boo tickety. Remember, you're warned.' You feel sort of rebellious--good rebellious--as he [if your-tix >= 4]counts your infractions on his fingers. Uh oh. Maybe you could've DROPped the booze before leaving[else]goes back to his pigeon stool[end if].";
			get-ticketed;
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
toad-bye	"'Don't do anything stupid.'"

to say bad-toad:
	say "Littering. Suppressing evidence of prior misconduct. Acting up in the bar. Minor in possession of alcohol. Aggravated loafing. Seeking out illicit activities. All manner of frog-bull"

after quipping when qbc_litany is litany of stool toad:
	if current quip is toad-hi:
		enable the toad-troub quip;
	if current quip is toad-troub:
		superable toad-refresh;
		enable the toad-pomp quip;
	if current quip is toad-bye:
		quit small talk;

part Soda Club

Soda Club is south of Joint Strip. It is in Outer Bounds. "Maybe if it were past 1 AM, you'd see passages west, south, and east, making this place the Total T instead. But if it were past 1 AM, you'd probably be home and asleep and not here. Or, at least, persuaded to leave a while ago.[paragraph break]The only way out is north."

check going nowhere in Soda Club:
	say "There aren't, like, hidden bathrooms, and you wouldn't need to go even if there were. And if there's a secret passage, there's probably a secret code you don't know, too. So, back north it'll be, once you want to leave." instead;

[Chips Cash is a person in Soda Club.

Kinetic Psycho is a person in Soda Club.

A Feel Cop is a person in Soda Club.]

section Liver Lily

Liver Lily is a female person in Soda Club. "[one of]A girl is here. She's--well, pretty attractive. And well-dressed.[or]Liver Lily waits here for intelligent, stimulating conversation.[stopping]"

Liver Lily wears the rehearsal dress.

description of dress is "It--well, it's one of those things you can't think of anything wrong to say about it. It's neither too tacky or dowdy. Yet it seems, to your unfashionable eye, a bit [i]comme il faut[r]."

instead of doing something with rehearsal dress:
	if action is undrastic:
		continue the action;
	say "In this game, you can pretty much only examine the dress."

after printing the locale description for Soda Club when Soda Club is unvisited:
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
		get-ticketed;

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
		quit small talk;

to chase-lily:
	say "The Punch Sucker sidles over. 'Sorry, champ. Looks like you did something to chase off a good patron. By the moral authority vested in me by the [bad-guy], it is my pleasure and duty to issue a boo-tickety.'";
	now lily is in lalaland;
	get-ticketed;

section Punch Sucker

A Punch Sucker is a person in Soda Club. "The [one of]guy you guess is the bartender[or]Punch Sucker[stopping] bustles around, serving drinks to the customers."

understand "bartender" as punch sucker.

description of Punch Sucker is "He bustles about, talking to the patrons, pouring drinks, flipping glasses and wiping the bar off, with the sort of false cheer you were dumb enough to believe was genuine."

check giving to sucker:
	if noun is cooler or noun is brew:
		say "He might be insulted if you give it back." instead;
	if noun is bear:
		say "He doesn't need it." instead;
	say "'Thanks, but no thanks. I do okay enough with tips.'" instead;

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
sucker-but	"'Well, everyone here is a bit smarter and maturer than normal, and anyway, this isn't the high-proof stuff. Plus the Stool Toad, we've paid him off. As long as nobody makes it obvious and walks out with a drink. So what the hey.'"
sucker-haha	"[here-or-not]"
sucker-cooler	"[here-or-not]"
sucker-baiter	"'He lets me stay open for very reasonable shakedown fees. He just, well, he just wants to know about all the patrons in here. Why, he drops in here himself and gets the good stuff. But he's very fair and balanced. He knows it's not how much you drink but how it affects you. Why, he's better at shaming unruly customers than I am!'"
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
		quit small talk;

book main chunk

Main Chunk is a region.

part Jerk Circle

Jerk Circle is north of Pressure Pier. It is in Main Chunk. printed name of Jerk Circle is "[jc]". "[if silly boris is in lalaland]The only evidence the [j-co] were here is that the ground seems slightly trampled[else]Seven [j-co] stand in a circle (okay, a heptagon) here, talking to and about others[end if]. It looks like there's forested area to the west, a narrow valley to the east, and things open up to the north. Nothing's stopping you going back south in this crossroads, either."

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

before giving quiz pop to:
	say "No. It looks really valuable. You might need one last thought burst before you're done." instead;

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
	else if finger is not examined:
		say "The seven [j-co] are too intimidating now. Even two people conversing, that's tough to break in the middle of.";
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
"So, Mr. Rogers. Does he conquer the basics?"	jerk-rogers	0	1
"So, you wouldn't be ashamed of driving a clunker?"	jerk-car	0	1
"So, do women's sports really have better fundamentals?"	jerk-wsport	0	1
"So, what sort of glossy magazines do you read?"	jerk-maga	0	1
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
Buddy Best	"prefers fashion magazines to swimsuit editions"	jerk-maga	0
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
jerk-maga	"[innue]."
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
		quit small talk;
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
	now all clients are in lalaland;
	unlock-verb "notice";
	quit small talk;

check going north when player is in well:
	if silly boris is in lalaland:
		say "[one of]Before you enter, you hear the Labor Child squealing how this all can't be legal and he knows people. Various jerks express interest at this confidential document or that and relief they never stooped that low. It looks like they are uncovering other of the Labor Child's 'business interests,' and they don't need you. Nothing violent is happening, and you enjoy some schadenfreude at the Labor Child's expense before deciding to move on.[or]No, you don't need or want to help the jerks. The Labor Child's in for it enough.[stopping]" instead;

chapter jerk talking

part Chipper Wood

Chipper Wood is west of Jerk Circle. It is in Main Chunk. "The path cuts east-west here, the wood being too thick elsewhere. [if chase paper is in wood][say-paper][else]You can go down where the chase paper was[end if]."

to say say-paper:
	say "[one of]But this path is clear, with an odd large paper grid. It's five by five, with fainter diagonal lines too[or]The chase paper is still there, taunting you with its apparent simplicity[stopping]";
	
understand "grid" as chase paper.

the chase paper is scenery in Chipper Wood. "Goodness knows how it sticks to the ground, but it does. You can probably GET ON it."

Rule for supplying a missing noun while entering (this is the yup paper rule):
	if player is in wood and chase paper is in wood:
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

[	
	if you-x is 3 and you-y is 3: [northwest corner trap]
		if ac-x is 0 and ac-y is 3:
			if last-p-dir is not north:
				now ac-y is ac-y + 3;
			else:
				now ac-y is ac-y - 3;
			continue the action;
		if ac-y is 0 and ac-x is 3:
			if last-p-dir is not west:
				now ac-x is ac-x + 3;
			else:
				now ac-x is ac-x - 3;
			continue the action;
	if you-x is 3 and you-y is 9: [southwest corner]
		if ac-x is 0 and ac-y is 9:
			if last-p-dir is not south:
				now ac-y is ac-y - 3;
			else:
				now ac-y is ac-y + 3;
			continue the action;
		if ac-x is 3 and ac-y is 12:
			if last-p-dir is not west:
				now ac-x is ac-x + 3;
			else:
				now ac-x is ac-x - 3;	
			continue the action;
	if you-x is 9 and you-y is 9: [southeast corner]
		if ac-x is 9 and ac-y is 12:
			if last-p-dir is not east:
				now ac-x is ac-x - 3;
			else:
				now ac-x is ac-x + 3;
			continue the action;
		if ac-x is 12 and ac-y is 9:
			if last-p-dir is not south:
				now ac-y is ac-y - 3;
			else:
				now ac-y is ac-y + 3;
			continue the action;
	if you-x is 9 and you-y is 3: [northeast corner trap]
		if ac-x is 9 and ac-y is 0:
			if last-p-dir is not east:
				now ac-x is ac-x - 3;
			else:
				now ac-x is ac-x + 3;
			continue the action;
		if ac-x is 12 and ac-y is 3:
			if last-p-dir is not north:
				now ac-y is ac-y + 3;
			else:
				now ac-y is ac-y - 3;
			continue the action;
]

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
		say "'Hey! You actually caught me! That's not supposed to happen. I was supposed to just cower in a corner and beg you not to hurt me. Anyway.'";
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
		say "You show him the solution, and he starts yelling about how nobody could have figured that out for themselves unless they really have nothing to do with their time.[paragraph break]Well, you have something to do with your time, now. Like seeing what's below.";
		special-bonus;
		now assassination is in lalaland;
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

[check going when player is in chipper wood and assassination character is in chipper wood:
	if noun is west:
		say "'Come on, you can't catch me? I'm as slow as you are...and not as smart. If you're clever, you'll find a way.'" instead;
	if noun is east:
		say "'Maybe you can catch me next time.'" instead;]

the Assassination Character is a person in Chipper Wood. initial appearance is "[if player was in chipper wood]The Assassination Character sticks his tongue out, daring you to catch him.[else][as-char][end if]"

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
	say "[one of]You hear a rustle from behind. Someone slaps you on the left side of your neck--you look there but see no-one. Then you look right. Ah, there. You STILL hate when people do that.[paragraph break]'Hey. It's me, the Assassination Character. You can call me AC for short--hey, I have plenty of names for you.' He tries a few, and you rush at him, and he snickers. 'Temper, temper. Well, I'll still let you cheat if you can get by me. Oh, and what's below.'[wfk]'Cheat?'[paragraph break]'Yup! If you can catch me, you'll be real close to something I'll let you under the chase paper. Just ENTER it. UNLESS YOU'RE CHICKEN.'[paragraph break]You wonder why you wouldn't fall through the chase paper if there was nothing under there, but the AC probably has an annoying response for that.[no line break][or]The Assassination Character springs out of nowhere again, asking whether you are too chicken to get on the chase paper or you are just too lazy not to cheat.[no line break][stopping]"

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

before giving the fish to:
	say "It's far too tacky for anyone to use. You probably just want to TALK to it to get it going." instead;

check taking story fish:
	if player has fish:
		continue the action;
	say "No, it's happy in the compound. You're happy you put it there to get rid of Art." instead;

check putting fish on bank:
	say "'Certainly not!' says Art Fine. 'Such a vulgar thing, among so many great books?'[paragraph break]Hm. You wonder what he'd think if he actually heard the fish." instead;

check inserting it into (this is the insert it right rule):
	if noun is fish and second noun is bank:
		say "'Certainly not!' says Art Fine. 'Such a vulgar thing, among so many great books?'[paragraph break]Hm. You wonder what he'd think if he actually heard the fish." instead;
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
	if player is not in Interest Compound:
		say "The fish opens a sleepy eye. 'Eh? Anyone here? Nope, nobody artsy.'" instead;
	if art fine is in Interest Compound:
		say "The fish eyes you sleepily but then sees the bookshelf, then Art Fine. 'Ah! Good sir! May I begin!' The fish's story is much funnier this time, and a bit shorter, too, because Art barely lasts five minutes before he runs away screaming. You pat the fish on the head and put it in the bookshelf.[paragraph break]";
		now art fine is in lalaland;
		now story fish is in Interest Compound;
		say "[if harmonic phil is in Interest Compound]Harmonic Phil snickers. 'Well, Art was smart and all, but he was getting kind of boring anyway. And he didn't know a THING about music.'[else]Well, that's Phil AND Art gone.[end if]";
		increment the score instead;
	say "[if harmonic phil is in Interest Compound and player is in Interest Compound]Harmonic Phil hums loudly over the sound of the fish talking. You'll need to ... fish for another way to get rid of Phil.[else]'Eh? Where'd everyone go? I'll wait [']til there's a crowd to tell my story.'[end if]";
	the rule succeeds;

a long string is a thing. description is "It's coiled, now, but it seems pretty easy to untangle if you want to PUT it IN somewhere deep."

part Truth Home

Truth Home is inside of Disposed Well. It is in Main Chunk. It is only-out. "Nothing feels wrong here, but it feels incredibly uncomfortable. It's also a small home, with the only exit back out."

for writing a paragraph about a person (called arg) in Truth Home:
	say "[one of]A large guy berates a much smaller guy here. 'Proof fool! Proof fool! You need some emotion in your life! You just don't want to admit you're jealous of the jumps I can make! Me, the Logical Psycho!'[or]The Logical Psycho continues to berate the Proof Fool.[stopping]";
	now Proof Fool is mentioned;
	now Logical Psycho is mentioned;

section Logical Psycho

the Logical Psycho is a person in Truth Home. description is "He is wearing a t-shirt with an old car on it."

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

check giving the trap rattle to the Logical Psycho:
	say "He recoils in fear for a second, then booms 'WHY WOULD I WANT THAT.' It's not really a question." instead;

check giving the trap rattle to Proof Fool:
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

part Bottom Rock

Bottom Rock is a room. It is in Main Chunk. "You've reached a rock chamber. It's not possible to go any further down, or, in fact, any direction other than up."

check going nowhere in bottom rock:
	say "You can only go back up." instead;

the note crib is a thing in Bottom Rock. it is fixed in place. "[if crib-talk is true]The note crib[else]An odd crib[end if] rests here."

understand "notes" and "notes crib" as note crib.

understand "odd" and "odd crib" as note crib.

description of note crib is "[bug]".

Include (-
	has transparent talkable
-) when defining note crib.

check entering crib:
	try sleeping instead;

crib-talk is a truth state that varies.

check examining the note crib:
	if bros-left is 0:
		if silly boris is in jerk circle:
			say "A final note mentions 'Be brutal. Ask a jerk twice to catch him off-guard, if the finger index doesn't help you.'" instead;
		say "A huge seven-pointed stain covers the crib. It looks like some liquid has been spilled." instead;
	say "[one of]The crib's bars appear to be notes, and doesn't have any bedding, but it is divided into a red section, a blue section, and a section as big as the other two combined. Looking below the header FOR BABIES, you see writing in the three sections. Which[or]Which section[stopping] do you wish to look at?";
	try talking to the crib instead;

check taking the note crib:
	say "You can take notes, but you can't take the crib." instead;

check talking to crib:
	now crib-talk is true;
	now qbc_litany is the table of note crib talk;
	display the qbc options;
	the rule succeeds;

table of note crib talk
prompt	response	enabled	permit
"Red."	crib-blood	2	1
"Blue."	crib-soul	2	1
"Big."	crib-big	2	1
"All."	crib-all	2	1
"None of them."	crib-bye	3	1

table of quip texts (continued)
quip	quiptext
crib-blood	"You stare at the red section."
crib-soul	"You stare at the blue section."
crib-big	"You stare at the big section."
crib-all	"You stare at all the sections."
crib-bye	"Nah, you don't want any hints just now."

already-clued is a truth state that varies.

ever-clue-crib is a truth state that varies.

after quipping when qbc_litany is table of note crib talk:
	now already-clued is false;
	if current quip is crib-blood or current quip is crib-all:
		hint-red;
	if current quip is crib-soul or current quip is crib-all:
		hint-blue;
	if current quip is crib-big or current quip is crib-all:
		hint-big;
	now already-clued is true;
	if current quip is crib-bye:
		quit small talk;
	else:
		say "Hm, the crib doesn't seem to have decayed spontaneously. Guess that means you can revisit it all you want.";
		now ever-clue-crib is true:

to hint-blue:
	if wacker weed is off-stage:
		say "Talk to Pusher Penn in the Pot Chamber.";
	else if player has wacker weed:
		say "Give Fritz the On the wacker weed.";
	else if poory pot is off-stage:
		say "Go back and give Pusher Penn the dreadful penny.";
	else if player has poory pot:
		say "Put the poory pot in the Spleen Vent in Temper Keep to pacify Volatile Sal.";
	else if relief light is off-stage:
		say "Open the Spleen Vent for the relief light.";
	else if player has relief light:
		say "Give the relief light to Brother Soul.";
	else:
		say "The blue area is blank now. You think to Brother Soul for a minute. You hope he is at ease.";
	say "[line break]";

to hint-red:
	if the Reasoning Circular is off-stage:
		now already-clued is true;
		say "Talk to Buddy Best until he gives you something.";
	else if officer petty is not in lalaland:
		now already-clued is true;
		say "Give the Reasoning Circular to Officer Petty.";
	else if money seed is off-stage:
		now already-clued is true;
		say "Get the Money Seed from the Scheme Pyramid.";
	else if contract-signed is false:
		now already-clued is true;
		say "Get the Business Monkey to sign the contract.";
	else if money seed is not in lalaland:
		say "Give the Money Seed to the Business Monkey.";
	else if player has fourth-blossom:
		say "Give the fourth-blossom to Faith or Grace Goode.";
	else if player has the mind of peace:
		say "Give the mind of peace to Brother Blood.";
	else:
		say "The red area is blank now. You think to Brother Blood for a moment. You hope he is at ease.";
	say "[line break]";

to hint-big: [already-clued indicates that you already saw a clue]
	if already-clued is false:
		if the Reasoning Circular is off-stage:
			say "Talk to Buddy Best until he gives you something.";
			continue the action;
		else if officer petty is not in lalaland:
			say "Give the Reasoning Circular to Officer Petty.";
			continue the action;
		else if contract-signed is false:
			say "Get the Business Monkey to sign the contract.";
			continue the action;
		else if money seed is off-stage:
			say "Get the Money Seed from the Scheme Pyramid.";
			continue the action;
	if player does not have sound safe:
		say "Get the Sound Safe from the Accountable Hold.";
	else if long string is off-stage:
		say "Visit Crazy Drive east of Speaking Plain.";
	else if player does not have string:
		say "Get the string from Crazy Drive.";
	else if story fish is off-stage:
		say "PUT STRING IN WELL for an important item.";
	else if art fine is not in lalaland:
		say "PLAY the story fish by Art Fine.";
	else if harmonic phil is not in lalaland:
		say "OPEN the sound safe by Harmonic Phil.";
	else if poetic wax is not in lalaland:
		say "PUT the poetic wax on the Language Machine.";
	else if trap rattle is off-stage:
		say "WEAR the trick hat then talk to the Charmer Snake.";
	else if trade of tricks is off-stage:
		say "GIVE the trap rattle to the Proof Fool.";
	else if the player has trade of tricks:
		say "GIVE the Trade of Tricks to Brother Big.";
	else:
		say "The big area is blank now. You think to Brother Big for a moment. You hope he is at ease.";
	say "[line break]";

part The Belt Below

There is a room called The Belt Below. It is in Main Chunk. "You're in a cylindrical sort of room where the walls are shaped like a belt--yes, a bit even comes out like a buckle[if insanity terminal is in belt]. [one of]And look, there's a sort of odd faux-retro mainframe-ish computer[or]The Insanity Terminal waits for your answer[stopping][end if]."

check going nowhere in belt below:
	say "You can only go back up[if terminal is in belt], ormaybe beating the terminal will lead elsewhere[else] or down[end if]." instead;

The Insanity Terminal is scenery in the Belt Below. description is "[bug]";

understand "puzzle" as terminal

after printing the locale description when player is in belt below and belt below is unvisited:
	say "'ATTENTION RECOVERING NERDLING!' booms the terminal. 'I THE INSANITY TERMINAL HAVE A CHALLENGE FOR YOU! IF YOU SOLVE IT, YOU WILL KNOW HOW TO PASS THE BROTHERS. IF YOU PASS THE BROTHERS, I WILL HELP YOU WITH THE [if allow-swears is true]JERKS[else]GROANERS[end if] ANYWAY.'";
	say "[line break]You have a look, and -- well, it's about the oddest puzzle you've ever seen.";

talked-to-pop is a truth state that varies.

check examining the insanity terminal:
	if bros-left is 0:
		repeat through table of fingerings:
			say "[jerky-guy entry]: [blackmail entry][line break]";
		do nothing instead;
	if terminal is examined:
		say "You re-read the clues." instead;
	repeat through table of quiz lines:
		say "[qline entry][line break]";
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

chapter abadfaceing

abadfaceing is an action applying to nothing.

understand the command "abadface" as something new.
understand the command "a bad face" as something new.

understand "a bad face" as abadfaceing when player is in Belt Below.
understand "abadface" as abadfaceing when player is in Belt Below.

carry out abadfaceing:
	if Insanity Terminal is in Belt Below:
		if bros-left is 0:
			say "You wonder if you should. You see some data on [if finger index is examined]who of seven guys likes what, which seems familiar[else]seven guys[end if], which looks valuable.";
		open-bottom;
		say "You hear a great rumbling as you put on -- well, a bad face -- and the Insanity Terminal cracks in half to reveal a tunnel further below.";
		special-bonus;
		the rule succeeds;
	else:
		say "You already solved the puzzle. If any more of Bottom Rock collapsed, you might not have a way back up." instead;
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

before giving to googly bowl:
	try giving noun to Faith Goode instead;

check inserting fourth-blossom into googly bowl:
	say "Faith and Grace take it from you.";
	try giving fourth-blossom to faith instead;

check giving penny to:
	if noun is labor child:
		say "That's small stuff for him. He'd probably rather be doing business." instead;
	if noun is toad or noun is petty:
		say "'Such blatant bribery! And small thinking, too.'" instead;
	if second noun is faith or second noun is grace:
		say "'We need no monetary donations. Big or small. The googly bowl [if fourth-blossom is in lalaland]must be[else]is[end if] healed, and that is most important.'" instead;

check giving poory pot to:
	if second noun is faith or second noun is grace:
		say "That's probably not the sort of incense or decoration they want to use[if fourth-blossom is in lalaland]. You restored the blossom, anyway[else]. The bowl seems more for flowers[end if]." instead;

check giving money seed to:
	if second noun is sly moore:
		say "'I'm not the farmer here. The monkey, though...'" instead;
	if second noun is faith or second noun is grace:
		say "'Our bowl cannot grow flowers. It can only accept them.'" instead;

check putting on googly bowl:
	try giving noun to faith instead;

check inserting into googly bowl:
	try giving noun to faith instead;

check giving fourth-blossom to:
	if second noun is faith or second noun is grace:
		say "'We must perform the ritual.' They cover the googly bowl with their hands. You hear a whirring and squelching, then soft humming.";
		wfak;
		say "[line break]'It is done! The bowl is whole! And here is thanks for you, who found the last component.' They hand you a fragile, translucent miniature brain. 'A mind of peace.'[paragraph break]";
		get-mind;
		the rule succeeds;
	if second noun is art fine or second noun is harmonic phil:
		say "He takes a dainty sniff. 'It's nice, but no imagination went into it.'" instead;
	if noun is a bro:
		say "He looks momentarily comforted but says, 'No. I need something that will last. And change me.'" instead;
	say "They don't seem to appreciate that." instead;

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
		quit small talk;

chapter Mind of Peace

the mind of peace is a thing. description is "Looking into it, you feel calmer. Better about past put-downs or failures, whether or not you have a plan to improve. Yet you also know, if it helped you so easily, it may be better for someone who needs it even more.[paragraph break]I suppose it could also be a Trust Brain. Ba ba boom."

understand "trust brain" and "trust/brain" as mind of peace.

part Scheme Pyramid

Scheme Pyramid is north of Disposed Well. It is in Main Chunk. "A gaudy, pointy-ceilinged room with exits north and south. Everything twinkles and shines. [one of]An odd hedge[or]The Fund Hedge[stopping] drips with all forms of currency, but you [if money seed is off-stage]are probably only allowed to take the cheapest[else]already got something[end if]."

check going nowhere in scheme pyramid:
	say "This room is north-south. Maybe once the brat turns ten, he'll have a bigger office, but right now, it's only got the two exits." instead;

The Labor Child is a person in Scheme Pyramid. "[one of]Some overdressed little brat walks up to you and shakes your hand. 'Are you here to work for me? You look like you have initiative. Not as much as me. The Labor Child. If you think you have business savvy, get a seed from the Fund Hedge.'[or]The Labor Child paces about here, formulating his next business idea.[stopping]"

understand "kid/brat" as Labor Child.

description of Labor Child is "He's dressed in abhorrently cute Deal Clothes, the sort that lets pretentious little brats be bossier than adults would let [i]other[r] adults get away with[one of].[paragraph break]As you look closer, he pipes up 'People stare at me thinking it's weird I'm such a success. I stare at them thinking it's sad they're all such failures.' Brat[or][stopping]."

check talking to labor child:
	if contract is off-stage:
		say "'I'm a busy kid. In addition to delegating all my homework I am running a business! There's startup materials in the Hedge Fund.'" instead;
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

before giving cold contract to a person:
	if second noun is labor child:
		continue the action;
	if contract-signed is true:
		say "It's already signed. No point." instead;
	if second noun is sly moore:
		say "[if talked-to-sly is true]Sly[else]He[end if] looks confused, but the Business Monkey looks over curiously." instead;
	if second noun is not business monkey:
		say "You can't bring yourself to sucker a person into signing this. Regardless of how nice they may (not) be." instead;

after printing the name of the cold contract while taking inventory:
	say " ([if contract-signed is false]un[end if]signed)";

contract-signed is a truth state that varies.

check dropping the cold contract:
	say "It's yours. You're bound to it [']til you sign it or find someone who can. The Labor Child has records in triplicate." instead;

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

understand "paper" as finger index.

description of finger index is "[finger-say].".

check examining finger index when finger index is not examined:
	say "It looks like a list of customers--wait, no, it's a list of embarrassing secrets. The little brat!";

to say finger-say:
	say "FINGER INDEX (CONFIDENTIAL):[paragraph break]";
	let temp be 0;
	repeat through the table of fingerings:
		increment temp;
		say "[temp]. [clue-letter of jerky-guy entry] [blackmail entry][line break]";
	say "[line break]Collect hush fees every Monday. Repeating accusations breaks the guilty parties. Insanity Terminal has backup data";
	now finger index is examined;

check taking the finger index:
	say "The Labor Child would probably get upset if you took that. And he'd probably get bigger people to be upset for him, too." instead;

chapter sound safe

The Sound Safe is a thing in Accountable Hold. "[if player is in Interest Compound]The safe lies here beneath the song torch[else]A safe lies here. It doesn't look particularly heavy or secure. You hear some sound from it[end if]."

after taking Sound Safe:
	say "It's not THAT heavy. The sound magnifies when you pick it up and the door opens briefly, but you close it. You try, but there's no way to lock it.[paragraph break]But what's this? Something's stuck under the safe. It's a piece of paper marked CONFIDENTIAL.";
	now finger index is in Accountable Hold;
	the rule succeeds;

description of Sound Safe is "[if sound safe is in interest compound]It's, well, not very sound. While it's closed, you can OPEN it at will. You're not even sure how to lock it[else]It sits, closed, and you probably want to keep it that way[end if]."

check opening sound safe:
	if harmonic phil is in lalaland:
		say "You don't need to, again." instead;
	if player is not in Interest Compound:
		say "You crack it open, but it makes such a terrible noise you have to close it again. You wouldn't want to open it again unless you were around someone you really wanted to spite." instead;
	say "The Sound Safe makes a brutal noise in the Interest Compound, made worse by the special acoustics. Harmonic Phil covers his ears. 'I can't even blather about how this is so bad it's good!' he yells, running off.[paragraph break]You put the safe down by the song torch.";
	now sound safe is in Interest Compound;
	now harmonic phil is in lalaland;
	say "[line break][if art fine is in Interest Compound]Art Fine chuckles and nods approval. 'That's what you get for dabbling in art that's not intellectually robust.' Wow. Even before a line like that, you figured Art Fine had to go, too.[else]Well, that's Phil AND Art gone.[end if]";
	increment the score instead;

check taking sound safe:
	if player is in Interest Compound:
		say "No, you like it here. Good insurance against Harmonic Phil coming back." instead;

part Judgment Pass

Judgment Pass is east of Jerk Circle. It is in Main Chunk. "[if officer petty is in Judgment Pass][one of]A huge counter with INTUITION in block letters is, well, blocking you. Well, not fully, but by the time you snuck around the edge, the official--and fit--looking officer behind it will get in your way.[or]The intuition counter still mostly blocks your way.[stopping][else]With Officer Petty out of the way, the Intuition Counter is now just an inconvenience.[end if]"

Officer Petty is a person in Judgment Pass. "[one of]The officer stares down at the intuition counter for a moment. 'NOPE,' he yells. 'Sure as my name's Officer Petty, no good reason for you to go to Idiot Village.'[or]Officer Petty regards you with contempt.[stopping]"

description of Officer Petty is "Officer Petty stares back at you, cracks his knuckles, and rubs a palm. He's bigger, stronger and fitter than you."

the Intuition Counter is scenery in Judgment Pass. "It's labeled with all manner of dire motivational phrases."

check giving to Officer Petty:
	if noun is smokable:
		say "'Hoo, boy! Really? REALLY? That'll get you to worse than Idiot Village. STOOL TOAD!' Not that Officer Petty needed backup, but it's the principle of the thing. You are escorted away.";
		move player to maintenance high instead;
	if noun is the Reasoning Circular:
		now Officer Petty is in lalaland;
		now the Reasoning Circular is in lalaland;
		say "A tear starts to form in Officer Petty's eye. 'Really? I...well, this definitely isn't bribery! I've always been good at yelling at people who get simple stuff wrong, but I always felt there was more. I could have more complex reasons to put people down. Thank you.' He looks at the Reasoning Circular again. 'Wait, wait. Maybe you wouldn't have gotten anything out of this invitation anyway. So it's not so generous.' Officer Petty beams at his newfound profundity before shuffling off.";
		increment the score;
		continue the action;
	say "'NO BRIBERY! Besides, that's not worth anything. But, uh, it's perfectly legal to give me something that might help my career.'" instead;
	
check going east in Judgment Pass:
	if Officer Petty is in Judgment Pass:
		say "'Whoah! I can't just let you go to Idiot Village. You're not qualified to show them what's what. And I have nothing better to do than stop you. For now.'" instead;

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
petty-baiter	"'He had a philosophical discussion with me once. Boy, oh, boy! It was about how just because someone is boring or passive doesn't mean they're not suspicious. What an exciting discussion!'"
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
		quit small talk;

part Idiot Village

Idiot Village is east of Judgment Pass. It is in Main Chunk. "Idiot Village is surprisingly empty right now. It expands in all directions, though you'd feel safest going back west, especially with that creepy [one of]idol[or]Thoughts Idol[stopping] staring at you east-northeast-ish. You hear a chant."

village-explored is a truth state that varies.

last-dir is a direction that varies.

rotation is a number that varies.

check going nowhere in idiot village (this is the final idol puzzle rule):
	if player has crocked half:
		if noun is northeast or noun is east:
			say "You run past the Thoughts Idol. Its eyes follow you.";
			if noun is northeast:
				now rotation is 3;
				now last-dir is northeast;
			else:
				now rotation is 5;
				now last-dir is east;
			now idol-tries is 0;
			now thoughts idol is in Service Community;
			move player to Service Community;
			prevent undo;
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

check giving the money seed to the business monkey:
	say "The business monkey grabs it eagerly, stuffing it into the soil.";
	wfak;
	say "[line break]As both actions were rather half-[if allow-swears is true]assed[else]brained[end if] to say the least, you are completely unsurprised to see, not a full blossom, but a fourth of one spring up--one quadrant from above, instead of, well, a blossom one-fourth the length or size it should be. He plucks it and offers it to you--very generous, you think, as you accept it. As you do, three others pop up, and he pockets them.";
	increment the score;
	now player has the fourth-blossom;
	now money seed is in lalaland;
	the rule succeeds;

check giving the cold contract to the business monkey:
	if contract-signed is true:
		say "You already did." instead;
	if money seed is not in lalaland:
		say "The monkey looks at it, smiles and shrugs. It seems to trust you, but not enough to sign a contract, yet." instead;
	say "You feel only momentary guilt at having the business monkey sign such a contract. After all, it binds the [i]person[r] to the terms. And is a monkey a person? Corporations, maybe, but monkeys, certainly not, despite any genetic simiarities! The monkey eagerly pulls a pen from an inside pocket, then signs and returns the contract.";
	increment the score;
	now contract-signed is true;
	the rule succeeds;
	
check giving the cold contract to the labor child:
	if contract-signed is false:
		say "'Trying to exploit a defenseless kid! Shame on you! I need that signature, and I need it NOW!'" instead;
	now cold contract is in lalaland;
	say "'Excellent! You now have a customer in your pipeline. You will receive 5% of whatever he buys from us in the future. Oh, and you may go IN to the back room.'" instead;

chapter Sly Moore

Sly Moore is a surveyable person in Idiot Village. "[if talked-to-sly is true]Sly Moore[else]A would-be magician[end if] loafs about here, trying and utterly failing to perform simple magic."

description of Sly Moore is "For someone trying to do magic tricks, he's dressed rather plainly. No cape, no wand or, well, anything."

understand "magician" as sly moore

to say sly-s:
	say "[if talked-to-sly is true]Sly Moore[else]The would-be magician[end if]"

litany of Sly Moore is the table of Sly Moore talk.

every turn when player is in idiot village and sly moore is in idiot village and you-are-conversing is false:
	say "[one of][sly-s] tries to play a three-shell game, but a bean appears under each one.[or][sly-s] tries and fails to shuffle a deck of cards. Several fall out, and he picks them up and pockets them.[or][sly-s] tries to palm an egg in a handkerchief, but you hear a crunch. 'Well, good thing I hollowed it out first, eh?'[or][sly-s] slaps a bunch of paperclips on some folded paper and unfolds the paper. They go flying. 'They were supposed to connect...'[or][sly-s] mumbles 'Number from one to a thousand, ten guesses, five hundred, two fifty--now round up or down? Dang, I'm stuck.'[or][sly-s] pulls out a funny flower which doesn't squirt you when he pokes it. He looks at it up close, fiddles with it and--yup. Right in his face.[or][sly-s] reaches to shake your hand, but you see the joy buzzer pretty clearly. He slaps his knee in disappointment...BZZT.[or][sly-s] looks befuddled on pulling only one handkerchief out of his pocket.[or][sly-s] cuts a paper lady in half. 'Oops. Good thing she wasn't real.'[in random order]"

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
sly-bm	"'Well, he told me I needed to banter more. He's real good at banter. He even borrowed my magic book and assured me it was easy enough for him, and he has the whole Problems Compound to run. In fact, he said he'd be checking up on me.'"
sly-check	"'My progress. I mean, if it's what I'd like to do and all, I'd better be good at it. Or else he might be forced to label me a Candidate Dummy.'"
sly-dummy	"'Oh, no! Not an actual dummy. It was sort of a warning shot. Motivation to wise up. I mean he laughed real silvery and all after he said it. Or else. But I guess I took it wrong. Because I'm too worried about it.'"
sly-geez	"'Well, I figure he's a lot harder on himself. Guess you have to be, to be the main guy dealing with [bad-guy-2]. But he said--if I can just do three things right, someone else would get the label.'"
sly-didhe	"'That's kind of unfair to him, isn't it? I mean, he's busy running the place. And dealing with [bad-guy-2]. Magic tricks won't help against Spike.'"
sly-help	"'Well, I could maybe use part of a costume. Or study tips. Or something that does both. Help me score three different routines.'"
sly-bye	"'Later.'"

check giving trick hat to a person:
	if noun is fool:
		say "Thing is, he KNOWS all the tricks. He just can't use them." instead;
	if noun is logical psycho or noun is stool toad:
		say "He's awful enough with what he's got." instead;
	if noun is faith goode or noun is grace goode:
		say "Then they might become a charismatic cult, and that wouldn't be good." instead;

check putting trick hat on a person:
	try giving noun to the second noun instead;

check giving trick hat to sly moore:
	say "You give Sly Moore the trick hat. He adjusts it ten times until it feels right, which is pretty silly, since it's completely circular. But once he wears it, his eyes open. 'Oh...that's how you...and that's how you...'[paragraph break]All the magic tricks he failed at, before, work now.";
	wfak;
	say "[line break]He hands the hat back to you. 'Let's see if I can do things without the hat. Yep, not hard to remember...there we go.' Sly shakes your hand. 'Thanks so much! Oh, hey, here's a gift for you. From a far-off exotic place. A trap-rattle.'[paragraph break]You accept it without thought. Sly excuses himself to brush up on magic tricks.";
	wfak;
	now player has the trap rattle;
	now sly is in lalaland;
	say "[line break]And once you take a step, thought is hard. Rattle, rattle. Well, it looks like Sly Moore was able to play a trick on you without the trick hat. He'll be okay." instead;

after quipping when qbc_litany is litany of Sly Moore:
	if current quip is sly-magic:
		enable the sly-bm quip;
	if current quip is sly-bm:
		enable the sly-help quip;
		enable the sly-didhe quip;
		enable the sly-check quip;
	if current quip is sly-check:
		enable the sly-dummy quip;
	if current quip is sly-dummy:
		enable the sly-geez quip;
	if current quip is sly-bye:
		if sly-help is talked-thru:
			enable the sly-help quip;
		quit small talk;

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

the thoughts idol is scenery in Idiot Village. "[if player is in idiot village][iv-idol][else]If you look back at the Thoughts Idol now, it may distract you. Gotta keep running, somehow, somewhere[end if]"

to say iv-idol:
	say "You stare at the thoughts idol, [if player has crocked half]and as it glares back, you resist the urge to look away. It--it actually blinks first.[else]but it stares back at you. You lose the war of facial expressions[end if]"

the Service Community is a room in Main Chunk. "You just came from the [opposite of last-dir]."

idol-tries is a number that varies.

check going in service community:
	if orientation of noun is -1:
		say "You need to go in a compass direction.";
	let q be orientation of noun - orientation of last-dir;
	if q < 0:
		now q is q + 8;
	if q is rotation:
		choose row idol-tries + 1 in the table of idol text;
		d "[idol-tries]";
		say "[good-text entry]";
		increment idol-tries;
		now last-dir is noun;
		prevent undo;
		if idol-tries is 7:
			now thoughts idol is in lalaland;
			move player to idiot village, without printing a room description;
			special-bonus;
		the rule succeeds;
	else:
		move thoughts idol to idiot village;
		if q is 4:
			say "You feel particularly helpless running back and forth. The idol shakes its head, as if to let you know that just won't do, and it's tired of telling lesser things or people or whatever that.";
		else:
			say "[bad-text entry]";
		prevent undo;

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
"The thoughts idol whizzes around a bit more. You're really making it spin. You wonder if it's had a workout like this in a while."	"You glance at the idol, feel frozen and collapse. The idol almost seems to be mocking you, but fearing you at the same time. Maybe if you think, you can run again."	"There's not too much ground to retrack. No need for would'ves."
"The thoughts idol seems to twitch back and forth while following you."	"You feel frozen and collapse. The idol's contempt can't hide a legitimate frown. You slipped up, but you got pretty far."	"Halfway there...maybe if you get momentum, you'll nail the pattern down for good."
"The thoughts idol barely catches its gaze up with you."	"The idol gives that look--you know it--'Smart, but no common sense.' Still--you can give it another shot."	"Would'ves won't help here. You've actually gotten in better shape, walking around just thinking."
"The thoughts idol warps and seems to wobble a bit but still looks at you."	"You--well, confidence or whatever it was let you down."	"Geez. You were that close. But no chance to stew. You bet you could do it, next time. But you can't say 'Oh, I meant to...'"
"The thoughts idol spins, coughs, and with a final buzz, its eyes spark and go out."	"You must have been close. But no."	"The idol's look reminds you of when you got a really hard math problem right except for adding 1 and 6 to get 8. People laughed at you. It hurt."

part Speaking Plain

Speaking Plain is north of Jerk Circle. It is in Main Chunk. "Roads go in all four directions here. North seems a bit wider. There's a keep to the west. But the main 'attraction' is [if fright stage is examined]Fright Stage[else]a huge stage[end if] in the center."

The Fright Stage is scenery in Speaking Plain. "It's decorated with all manner of horrible fate for people that, you assume, messed up in life. From homelessness to getting fired visiting a porn store on Christmas Day to just plain envying other people with more stuff or social life, it's a mural of Scared Straight for kids without the guts to do anything jail-worthy."

understand "business/show" and "business show" as Fright Stage.

Turk Young is a person in Speaking Plain. description is "He seems a little trimmer, a little better dressed, and a little taller than you. And of course a lot more confident. Even when he's letting Uncle Dutch speak, his furious nods indicate control. He is clearly a fellow who is Going Places, and the Fright Stage is an apprenticeship."

Uncle Dutch is a person in Speaking Plain. description is "The sort of adult you used to think was just really muscular, but now that you're as tall as a lot of them, you're willing to admit it's fat. His hair looks either artificial or combed-over, his teeth disturbingly white when he talks.[paragraph break]You'd say he looked avuncular if someone twisted your arm to say it (though come to think of it, you've gotten your arm twisted for saying words like avuncular, too,) but then again, he looks like he'd hire people to do that."

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
		say "'THUS ENDS THE BUSINESS SHOW.' Uncle Dutch and Turk Young shout in unison before applauding each other. They then look to you and sigh when you fail to applaud. 'Does not provide minimal encouragement to others. He'll be a failure for sure,' notes Uncle Dutch. 'I've had teachers like that. But they still had to give me A's!' beams Turk Young.[paragraph break][one of]You look back on all their advice and realize none of it could even conceivably help you with what you need to do, here. At least they're not stopping you from going anywhere.[or]They're going to start up again in a bit. But it can't be that bad the next time through.[stopping]";
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

for writing a paragraph about a person (called udyt) in Speaking Plain:
	say "[one of]As you approach the stage, the man and the teen on it boom: 'Approach the Fright Stage with care! Uncle Dutch and Turk Young bring it hard and keep it real with the BUSINESS SHOW!'[or]Uncle Dutch and Turk Young continue their practical philosophy lessons on the Fright Stage.[stopping]";
	now uncle dutch is mentioned;
	now turk young is mentioned;


part Crazy Drive

Crazy Drive is east of Speaking Plain. It is in Main Chunk. "While Crazy Drive itself isn't especially crazy, it leads to three very different buildings indeed. To the north is [if standard bog is visited]the Standard Bog[else]some swamp or something[end if], east is some sort of museum, and you can go inside [gateway-desc]. Or you can go back west to the Speaking Plain."

check going nowhere in crazy drive:
	say "There's no crazy secret passage in Crazy Drive. Just north, east, in and west." instead;

understand "pot/chamber" and "pot chamber" as drug gateway when player is in crazy drive

to say gateway-desc:
	say "[if gateway is examined]the Drug Gateway[else]a gateway[end if] to ";
	if pot chamber is unvisited:
		say "[if gateway is not examined]somewhere seedy[else]a place your parents would want you to stay out of it[end if]";
	else:
		say "the Pot Chamber"

a long string is in crazy drive. "A long string lies piled up here."

check entering drug gateway:
	try going inside instead;

check closing drug gateway:
	say "There's no way to close it." instead;

check opening drug gateway:
	say "It already is." instead;

Drug Gateway is scenery in Crazy Drive. "[one of]You look at it--a weird amalgam of swirls that don't seem to say anything. But they are captivating. Then they come together--DRUG GATEWAY. [or]Now you've seen the pattern in the Drug Gateway, you can't un-see it. [stopping]As you haven't heard any cries or gunshots, yet, it can't be too bad to enter[if pot chamber is visited] again[end if].. you think."

does the player mean entering drug gateway: it is very likely.

part Pot Chamber

Pot Chamber is inside of Crazy Drive. It is in Main Chunk. It is only-out. "This is a reclusive little chamber that sells far more of incense and air freshener than any place has a right to[one of], and after a moment's thought, you realize why[or][stopping]. Any sort of incriminating equipment is probably behind secret passages you'll never find, and you can only go out again."

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

check giving to pusher penn:
	if noun is poory pot:
		say "You've already done enough business with Pusher Penn." instead;
	if noun is wacker weed:
		say "'Nope. No reneging.'" instead;
	if noun is poory pot:
		say "'Nonsense. You earned it.'" instead;
	if noun is dreadful penny:
		now player has poory pot;
		now penny is in lalaland;
		say "'Most excellent! It's not the profit so much as the trust. Now, you look like you haven't tried the good herb before. No offense. So let's start you with the...' he sniffs, 'aromatic stuff. It's poor-y pot, but it'll do. Seller assumes no liability if user is too wussy to keep smoke in lungs for effective amount of time, yada, yada.' You try to say you weren't intending to smoke it, anyway." instead;
	say "Pusher Penn sniffs. 'That's not even close to what I want.'" instead;

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
		quit small talk;

the wacker weed is a smokable. description is "You couldn't tell if it is good or bad, really. But it needs to be delivered. It's in a baggie and everything."

understand "baggie" as wacker weed.

check opening wacker weed:
	say "Don't dip into the supply." instead;

some poory pot is a smokable. description is "Geez. You can smell it. It's a sickly sweet smell."

part Standard Bog

Standard Bog is north of Crazy Drive. It is in Main Chunk. "This is a pretty standard bog. It's got slimy ground, some quicksand traps, and... [one of]well, the machine off to the side is not so standard. It seems to be mumbling, trying different ways to express itself. Yes, to use language. A language machine.[or]the Language Machine, still [if wax is in lalaland]burbling poems[else]grinding out dreary sentences[end if].[stopping]"

the hopper grass is a thing in Standard Bog.

check giving hopper grass to pusher penn:
	say "'Brilliant! This might be some really good stuff.'";
	special-bonus;
	now hopper grass is in lalaland instead;

check going nowhere in standard bog:
	say "It's really only safe to go back south." instead;

The Language Machine is scenery in Standard Bog. "The language machine hums along [if wax is in lalaland]cheerfully[else]balefully[end if], its console spewing out [if wax is in lalaland]poetry, which isn't good, but it's not overblown[else]dolorous, leaden, formulated prose about, well, being stuck in a bog[end if] in its bottom half. In the top half is an LCD [if wax is in lalaland]smile[else]frown[end if]."

before giving to machine:
	say "(putting [unless noun is plural-named]it[else]those[end if] on the machine instead)";
	try putting noun on machine instead;

check talking to language machine:
	say "It processes your words and converts them into an [if wax is in lalaland]amusing poem[else]angsty story[end if]. But it doesn't seem to notice you, being a machine[if wax is in lalaland]. Just as well. You've done what you can[else]. Maybe there's something that can modify how it sees its input." instead;

to say no-pos:
	say "The machine is humming along and poeticizing happily. It needs no more possessions"

check giving to the language machine:
	if poetic wax is in lalaland:
		say "[no-pos]." instead;
	say "The language machine has no arms, so you decide to PUT it ON.";
	try putting noun on language machine instead;

check inserting into the language machine:
	if poetic wax is in lalaland:
		say "[no-pos]." instead;
	try putting noun on language machine instead;
	
check putting on the language machine:
	if poetic wax is in lalaland:
		say "[no-pos]." instead;
	if noun is poetic wax:
		now wax is in lalaland;
		now player is wearing trick hat;
		say "The language machine emits a few weird meeps, then the wax seeps into it. The words on the terminal change from well-organized paragraphs to clumps of four in a line. You steel yourself and read a few...";
		wfak;
		say "...and they're not that great, but they're uplifting, and if they're still cynical, they have an amusing twist or two. No more FEEL MY ENNUI stuff. If only you could've done that back when you used to write, before you got too grim...well, maybe you still can.[paragraph break]The computer prints out a map for you, of the bog. It has all the pitfalls. You walk to the end to find a bona fide trick hat--like a wizard hat but with clever facial expressions instead of stars and whatnot.[paragraph break]You stick the map back in the computer, since it's really tearing through scratch paper to write poems, and it needs all the paper it can get. It's the least you can do. You won't need to go back, and that hat seems pretty cool. Cool enough to wear immediately.";
		increment the score instead;
	if poetic wax is in lalaland:
		say "The machine is on a roll. You don't have anything else to give to it, anyway." instead;
	if noun is story fish:
		say "[one of]The story fish moans about how it moans occasionally, but it's not as bad as that computer. You probably want to do something more positive for or to the computer[or]You don't want to annoy the story fish into moaning again[stopping]." instead;
	say "The machine whirs defensively as you get close. Hm, maybe something else would work better." instead;

the Trick Hat is a thing. description is "You pull the hat off for a moment. It's covered in snarky facial expressions and all manner of light bulbs and symbols of eureka moments. You think you even see a diagram of a fumblerooski or a fake field goal if you squint right."

check taking off the trick hat:
	say "Surely not. It [if sly moore is in lalaland]may have another use[else]must be useful for something[end if]." instead;

part Court of Contempt

Court of Contempt is west of Questions Field. It is in Main Chunk. "Boy, it's stuffy in here! You can't actually hear anyone sniffling, but you can, well, feel it. You can escape back east."

check going nowhere in Court of Contempt:
	say "'So, you the sort of person who runs into walls a lot? Not that there's anything wrong with that.' Yup. Looks like back east's the only way out." instead;

Buddy Best is a person in Court of Contempt. "[one of]Oh, look! A potential friend![paragraph break]'Yah. Hi. I'm Buddy Best. You seem real nice. Nice enough not to waste too much of my time.'[paragraph break]Okay, never mind.[or]Buddy Best waits and taps his foot here.[stopping]". description is "Buddy Best has a half-smile on his face, which is totally a delicate balance of happiness and seriousness and not a sign of contempt, so stop saying that."

the Reasoning Circular is a thing. description is "It's full of several pages why you're great if you think you are, unless you're lame, in which case you don't know what great means. There's a long tag stapled to it."

before giving Reasoning Circular to:
	if noun is dutch or noun is turk or noun is child:
		say "Oh, he's long since mastered THAT." instead;
	if noun is Stool Toad:
		say "'BASIC TRAINING! I completed that long ago. Some of my colleagues haven't, yet.'" instead;
	if noun is a bro:
		say "He's not searching for that. He's searching for something real." instead;

instead of doing something with the long tag:
	if action is undrastic:
		continue the action;
	if current action is giving:
		try giving Reasoning Circular to the second noun;
	say "You don't want to pull it out. Maybe someone else could use it. Someone you want to get rid of.";

the long tag is part of the Reasoning Circular. description is "It's stapeld to the Reasoning Circular and reads:[paragraph break]By Order of the [bad-guy]:[paragraph break]The holder of this ticket is entitled, irregardless (I know, I'm being ironic and vernacular) of station or current responsibility, to visit Enough Fair, a whirlwind event of social skills where the bearer learns[paragraph break][2da]1. how to yell at others to stop complaining life's not fair AND still point how it's rigged against you[line break][2da]3. Of course, not trying to be too fair. People who overdo things are the worst![line break][2da]3. Lots more, but if we wrote everything, you wouldn't need to show up. Ha ha."

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
best-law	"'Brilliant. Yeah. I kind of see the good side of people. Well, interesting people.'"
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
		quit small talk;
		say "Buddy waves his hands to change the subject. 'Well, I don't want to waste any more of your time,' he says, with fake humility not meant to be convincing. You freeze.";
		wfak;
		say "[line break]'Negotiator, eh? Standing your ground?' Buddy Best shoves something in your hands as he pushes you out. 'It's, well, stuff I could tell you personally, but I don't want to waste your time. Self improvement stuff. I'm sure you're smart enough to understand. Smart enough to have understood a few years ago, really.'";
		wfak;
		say "[line break]Well, it's something. Which is more than you expected. Generally, obnoxious fast-talkers wound up taking something from YOU after a short, loud, fast dialog. You're not sorry you had no chance to say good-bye.";
		now player has the Reasoning Circular;
		try going east;

part Interest Compound

Interest Compound is east of Crazy Drive. It is in Main Chunk. "On one wall, a book bank is embedded--like a bookshelf, only tougher to extract the books. On another, a song torch."

the poetic wax is in Interest Compound. "Poetic Wax--a whole ball of it--lies here behind [if number of waxblocking people is 0]where Art and Phil used to be[else][list of waxblocking people][end if]."

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
	unless p is in Interest Compound, decide no;
	if p is art fine or p is harmonic phil, decide yes;
	decide no;

[MUSIC FACE]

check going to Interest Compound for the first time:
	say "Two guys greet you as you walk in. 'I'm Art Fine. This is Harmonic Phil. We're the Directors of Bored. We're--well, we're bored of things the right way. Of written and aural art.'"

chapter Art Fine

Art Fine is a person in Interest Compound. description is "He's wearing a shirt with a quote from an author you never read."

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
art-baiter	"'A top notch fellow. A true patron of the arts. Our aesthetics do line up. He seeks to encourage all art, unless it could be understood by dumb people. Now, art that dumb people SHOULD be able to understand but don't, that's a different story.'"
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
		quit small talk;

chapter Harmonic Phil

Harmonic Phil is a person in Interest Compound. description is "He's wearing a shirt with a band you never heard of."

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
phil-baiter	"'Why, his music criticism is even more wonderful to listen to than the music itself! Even a great piece of music remains the same, but his alternate opinions... the complexity, the variety of though. My, my!'"
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
		quit small talk;

chapter book bank

the book bank is scenery in Interest Compound. "Just filled with books!"

book-ord is a number that varies.

check examining book bank:
	increment book-ord;
	if book-ord > number of rows in table of horrendous books:
		if art fine is in compound:
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
Clark Arthur: Odyssey Space
Ford Richard The Land of the Lay?
Wallace Stegner (never read)
Richter Conrad: The Forest in the Light?
Hugo Victor: Eternity with Conversations? (not really by Hugo)
]

chapter song torch

a song torch is scenery in Interest Compound. "Tacky and glitzy and afire (sorry) with music you're supposed to be smart and worldly enough to appreciate, but you can't."

song-ord is a number that varies.

check examining song torch:
	increment song-ord;
	if song-ord > number of rows in table of horrendous songs:
		if harmonic phil is in compound:
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
		say "[random bro in Questions Field] wags a finger dolefully. [one of]'[bro-i-we] can't let you by to see the [bad-guy]. What was his joke?' He pauses. '[bro-i-we] had ONE JOB!'[or]'[bro-i-we] have one job.'[stopping]" instead;
	if cookie-eaten is true:
		say "Bye-bye, Questions Field. A question mark pops out from the side and tries to hook you out of Freak Control, but that's a stupid trap. The exclamation mark that tries to bash you? A punch disables it.";
		continue the action;
	if off-eaten is true:
		say "A question mark pops out from the side and tries to hook you, buy you throw your shoulders up in exasperation just so--one arm knocks the question away, and the other deflects an exclamation mark coming from above. Weird. It's more motivation than ever just to get OUT of here, already.";
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
	say "[one of]Three brothers block the way ahead to the north. They're imposing, each in his own way. 'Greetings, Traveler. We are the Keeper Brothers: Brother Big, Brother Blood, and Brother Soul. We must guard Freak Control, headquarters of the [bad-guy]. It is the job we are best suited for, and we are lucky the [bad-guy] has given it to us. He said we are free to do something clearly better if we can find it. We have not, yet.'[or][list of stillblocking people] block[if bros-left is 1]s[end if] your way north. '[if bros-left is 1]I'm[else]We're[end if] sorry. It's [if bros-left is 1]my[else]our[end if] job. Until we find a purpose.'[stopping]";
	now brother big is mentioned;
	now brother blood is mentioned;
	now brother soul is mentioned;

section Brother Big

Brother Big is a bro in Questions Field. description is "He is a foot taller than either of his brothers, but his eyes seem duller, and he frequently scratches his head."

check giving to Brother Big:
	if noun is Trick Hat:
		say "It doesn't even close to fit him. Too bad! Anyway, he could maybe use some real education and not just a magic boost." instead;
	if noun is Mind of Peace:
		say "'I need education, not peace. However, that may be perfect for Brother Blood.'" instead;
	if noun is Relief Light:
		say "'I need specific relief from my own lack of knowledge. However, that may be perfect for Brother Soul.'" instead;
	if noun is not Trade of Tricks:
		say "'That is not educational enough for me.'" instead;
	now brother big is in lalaland;
	now trade of tricks is in lalaland;
	say "'Wow! All these things I never learned before! Was it really--did people really--yes, they did.' You read through with him, [if trade of tricks is examined]re-[end if]appreciating all the things you'd fallen for and won't again.[paragraph break]'I won't be suckered again.'";
	check-left instead;

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
		quit small talk;

section Brother Soul

Brother Soul is a bro in Questions Field. description is "His frowning and moping make him perfect for standing guard but not much else. He might not try to stop you if you passed by just him, but you'd feel guilty for doing so."

check giving to Brother Soul:
	if noun is poetic wax:
		say "'If I were cheerier, that might help me write decent poetry. But alas, I am not, yet.'" instead;
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is mind of peace:
		say "'That would be perfect for Brother Blood. But any peace I have would be temporary. I would still need relief.'" instead;
	if noun is not relief light:
		say "'No, I need something to dispel this sad darkness in my soul.'" instead;
	now relief light is in lalaland;
	now brother soul is in lalaland;
	say "'Thank you! My soul is less heavy and dark now. I believe I have a higher purpose than just blocking people.'";
	check-left instead;

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
		quit small talk;

section Brother Blood

Brother Blood is a bro in Questions Field. description is "He jitters with rage for a few seconds, then takes a fw breaths, whispers to calm himself down, then starts over again."

check giving to Brother Blood:
	if noun is Trade of Tricks:
		say "'That would be perfect for Brother Big. But it is not best for me.'" instead;
	if noun is relief light:
		say "'That would be perfect for Brother Soul. But it might only give me temporary relief from my violent worries.'" instead;
	if noun is not mind of peace:
		say "'No, I need something to calm me down.'" instead;
	now mind of peace is in lalaland;
	now brother blood is in lalaland;
	say "Brother Blood takes the mind and gazes at it from all different angles He smiles. 'Yeah...yeah. Some people are just jerks. Nothing you can do to brush [']em off but brush [']em off. I mean, I knew that, but I KNOW it now.'[paragraph break]'Thank you!' he says, squeezing your arm a bit too hard. 'Oops, sorry, let's try that again.' The other arm works better. 'I'm--I'm not just good for snarling and yelling at people and pushing them around, like the [bad-guy] said. I'm more than that. So I guess I need to go find myself or something.'";
	check-left instead;

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
		quit small talk;

part Temper Keep

Temper Keep is west of Speaking Plain. Temper Keep is in Main Chunk. "[if sal-sleepy is true]Temper Keep is nice and quiet now. Nothing much to do except go back east[else]You find yourself hyperventilating as you enter, not due to any mind control, but because--well, it stinks. It would stink even worse if you couldn't go back east. [say-vent][end if]."

check going nowhere in Temper Keep:
	say "You're a bit annoyed to see there are no ways out except east. But then again, you'd also be annoyed if there was more to map. Annoying." instead;

to say say-vent:
	say "[one of]You look around for the cause, and you only see a vent shaped like a spleen[or]The spleen vent catches your eye[stopping]"

Volatile Sal is a person in Temper Keep. "[one of]'Ah! A new person!' An angry looking man takes a sniff. 'You smell awful too! What is it with all these visitors? Anyway, I'm Volatile Sal. Nice to meet you. Be nicer if you smelled better.'[or][if sal-sleepy is false]Volatile Sal paces around here anxiously, holding his nose every few seconds[else]Volatile Sal is snoozing in a corner by [sp-vent][end if]. It [if sal-sleepy is true]does smell nicer here after your operations[else]does smell a bit odd here[end if].[stopping]"

check putting pot on sal:
	say "Sal might be offended by that. As if he is the one causing the smell. Maybe if you can make it so the poory pot can take over the whole room..." instead;

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
	say "[if sal-sleepy is true]You don't want to risk waking him. Who knows what new faults he might find?[else]'Um, yeah, um, back up. I really don't want to smell your breath. Just in case.'[end if]" instead;

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

a list bucket is a thing in Freak Control. "[one of]A list bucket lying nearby may help you make sense of the fancy machinery, though you worry might kill yourself trying[or]The list bucket waits here, a handy reference to the gadgetry of Freak Control[stopping]."

check taking the bucket:
	say "You would, but the [bad-guy] might turn around and ask if you really needed to steal a bucket, and no, the text isn't going to change if you pick it up, and so forth." instead;

description of list bucket is "[2da]The Language Sign should, um, y'know, make things obvious.[line break][2da]Shot screens: track various areas in the Compound[line break][2da]The Twister Brain: to see what people REALLY mean when they oppose you just a little[line break][2da]the Witness Eye provides tracking of several suspicious individuals[line break][2da]The Incident Miner processes fuller meaning of events the perpetrators wish were harmless.[line break][2da]the Call Curtain is somewhere the [bad-guy] better not have to go behind more than once a day.[line break][2da]the Frenzy Feed magnifies social violations people don't know they're making, or want to hide from others, and lets you feel fully outraged.[paragraph break]All this gadgetry is well and good, but the [bad-guy] probably knows it better than you. You may need some other way to overcome him."

the call curtain is scenery in Freak Control. "It doesn't look particularly malevolent--it seems well washed--but you don't know what's going on behind it."

check entering call curtain:
	say "The [bad-guy] wouldn't allow a repeat performance. Or any performance, really."

the incident miner is scenery in Freak Control. "The incident miner churns and coughs. You see text like 'not as nice/interesting/worthwhile as he thinks' and 'passive aggressive but doesn't know it' and 'extraordinary lack of self awareness' spin by."

the against rails are plural-named scenery in Freak Control. "You're not sure whether they're meant to be touched or not. No matter what you do, though, you feel someone would yell 'Isn't it obvious Alec should/shouldn't touch the rails?'"

freaked-out is a truth state that varies.

the shot screens are scenery in Freak Control. "[if cookie-eaten is true]You're torn between wondering if it's not worth watching the jokers being surveyed, or you deserve a good laugh.[else]For a moment, you get a glimpse of [one of]the jerks going about their business[or]the parts of Idiot Village you couldn't explore[or]a secret room in the Soda Club[or]Officer Petty at the 'event,' writing notes furiously[or]the hideout the Stool Toad was too lazy to notice[or]The Logical Psycho back at his home[or]exiles living beyond the Standard Bog[in random order].[end if]"

every turn when player is in freak control and qbc_litany is not table of baiter master talk (this is the random stuff in FC rule): [?? if player doesn't know names, don't write them]
	unless accel-ending:
		say "[one of]The Twister Brain spits out a page of data the [bad-guy] speed reads. He mutters 'Pfft. I already sort of knew that. Mostly.'[or]The Witness Eye swivels around with a VVSSHHKK before changing the focus to [a random surveyable person].[or]The Shot Screen blinks a bit before changing its focus.[in random order]"

the Twister Brain is scenery in Freak Control. "Its ridges seem twisted into a smirk."

understand "ridge/ridges" as Twister Brain.

the Witness Eye is scenery in Freak Control. "It's weird, it's circular, but it has enough pointy protrustions, it could be a Witness Star too. You see lots of things going on Most look innocent, but there's an occasional flash, the screen reddens, and WEIRD or WRONG flashes over for a half-second."

understand "witness star" and "star" as Witness Eye.

the Language Sign is scenery in Freak Control. "It says, in various languages: OUT, FREAK. [one of]You're momentarily impressed, then you feel slightly jealous that the [bad-guy] took the time to research them. You remember getting grilled for trying to learn new languages in elementary school, before you could take language classes. You mentally blame the [bad-guy] for that. Well, it was someone like him. [or]You also take a second or two to pick which language is which line. Got [']em all. Even the ones with the unusual alphabets you meant to figure.[stopping]"

The Baiter Master is a proper-named person in Freak Control. "The [bad-guy] stands here with his back to you.". description is "You can only see the back of him, well, until you gaze in some reflective panels. He looks up but does not acknowledge you. He doesn't look that nasty, or distinguished, or strong, or whatever. Surprisingly ordinary. He shrugs and resumes his apparent thoughtfulness."

understand "complex" and "messiah" and "complex/messiah" as Baiter Master.

litany of Baiter Master is the table of Baiter Master talk.

check talking to Baiter Master:
	if freaked-out is false:
		say "[one of]He waves you off without even looking. 'Whoever you are, I'm busy. Too busy for your lame problems. And they must be lame, if you asked so weakly.' You'll need an entirely more aggressive way to get his attention.[or]You just aren't good enough at yelling to do things straight up. Maybe you can upset things somehow.[stopping]" instead;
	say "'Dude! You need to chill... there are things called manners...' but he does have your attention now. 'So. Someone finally got past those mopey brothers. You want a vision duel? Because we can have a vision duel. I have...an [i]opinion[r] of difference. You don't even have...one right serve.' He takes a slurp from a shot mug (with a too-flattering self-portrait, of course) and perks up."

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
bm-mug	"'Oh, it's Crisis Energy. For taking urgent action when someone's -- out of line.' You look more closely. 'COMPLIMENTARY FROM [bad-guy-2-c].'"
bm-bad2	"'It's--it's, well, tribute is what it is.'"
bm-so-bad2	"'Oh, come on, you know the difference.'[wfk][line break]It just slips out. 'Yeah, it's easy, there's not much of it.'"
bm-tribute	"'There will be. Just--society needs to be stable, first. And it almost was. Until you stepped in.'"
bm-fear	"You just mention, they're smart enough, but they can fool themselves. With being impressed by stupid propaganda, or misplaced confidence, or people who claim things are--well--back to front. They get used to it. They let things mean the opposite of what they mean. You've been there...[wfk][line break]'Whatever.'[paragraph break]'See? Just like that.'[paragraph break]There's a long silence. 'Great. You think you can do better? Do so. I'll be waiting in Questions Field. You'll miss something obvious. Always have, always will.' The Baiter Master storms out.[paragraph break]You're not sure who can help, but maybe...the Goods? Yes. The Jerks? Surprisingly, yes, too. You even call Mark Black on the Quiz Pop's customer service number. Then [bad-guy-2] pretending to be the [bad-guy] and you prank him. It's--there's so much to do, questions you never asked. Mark Black is on his way--but you are unprepared for the military coup--someone named Admiral Vice. 'A danger to Slicker City! We will break him,' he says, gesturing to you.[wfk]"
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
			d "spike [if bm-so-bad2 is talked-thru]1[else]0[end if]";
	if current quip is bm-fear:
		if thoughts idol is in lalaland:
			say "[line break]But Idiot Village has had time to assemble and rescue the hero that dispelled the Thoughts Idol! They overwhelm the Admiral, trash the more sinister surveillance technology in Freak Control, and lead you somewhere new. You protest you're not a leader--you just, well, did a bunch of errands. But they insist they have something to show you.";
			now player has hammer;
			move player to Airy Station;
		else:
			say "[line break]'Where? In the BREAK JAIL!'[paragraph break]You keep a straight face and, later that night, your wits. Could people who yell that loud REALLY be that wrong? You don't sneak out quietly, enough, though, and guards give chase. There's a mist ahead--maybe they'll lose you! But you've done even better. 'The out mist!' they yell. 'People eventually leave there to get back to real life.'";
			move player to Out Mist;
		terminate the conversation;

chapter freakouting

freakouting is an action applying to nothing.

understand the command "freak out" as something new.
understand "freak out" as freakouting.

carry out freakouting:
	say "You let it all out. You haven't let it all out, since the good old days when James Scott and Scott James, ever fair and balanced, castigated you alternately for being too creepy-silent or being too overemotional. You blame the [bad-guy] for stuff that couldn't possibly be his fault, but it feels good--and it gets his attention.";
	now freaked-out is true;
	score-now;
	try talking to baiter master instead;

chapter powertriping

powertriping is an action applying to nothing.

understand the command "trip power" as something new.
understand "trip power" as freakouting.

carry out powertriping:
	say "You wonder if it could be that easy. Of course there has to be a switch somewhere! It might be hard to find, and the [bad-guy] might catch you...no, he is too absorbed in his surveillance. He'd already have picked at you, if he cared.[paragraph break]Ah, there it is. Just shut it down...";
	wfak;
	say "[line break]Oops, it's dark! The [bad-guy] yells. 'It'll take FIVE MINUTES to boot up again![paragraph break]Well, you have nothing to do but talk right now.";
	now freaked-out is true;
	try talking to baiter master instead;

book endings

Endings is a region.

part Airy Station

Airy Station is a room in Endings. "[one of]A cheering crowd[or]The mentality crowd[stopping] surrounds you on all sides! They're going pretty crazy over their new-found freedom, and how you got it for them."

understand "man hammer" as a mistake ("So, this game isn't badly cartoonish enough for you?") when player is in Airy Station.

understand "ban hammer" as a mistake ("You feel confident you could be an internet forum mod. But--if you banned the hammer, you'd never get back home.") when player is in Airy Station.

understand "hammer jack" as a mistake ("There's probably someone named Jack in the crowd, but even if he deserved it, it'd take too long to go and ask.") when player is in Airy Station.

understand "hammer ninny" as a mistake("This is a nonviolent mistake, and besides, everyone here has been slandered as an idiot, not a ninny.") when player is in Airy Station.

understand "hammer sledge" as a mistake("If there were a sledge, you wouldn't want to destroy it. Trust me, I know what I'm doing. And you will, soon, too.") when player is in Airy Station.

understand "worm round" as a mistake("You consider worming around, but you're not very good at flattery, and there's nobody to flatter. Not that it's worth being good at flattery.") when player is in Airy Station.

understand "hammer [text]" and "[text] hammer" as a mistake ("You look at the hammer, hoping it will change, but nothing happens. Maybe another word.") when player is in Airy Station.

the hammer is a thing in Airy Station. description of hammer is "It's a nondescript hammer. You feel a power, though, as you carry it--as if you were able to change it, if you knew how to describe it."

after printing the name of the hammer when taking inventory:
	say " (much plainer than it should be)";

instead of doing something with hammer:
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

the lock caps are part of the return carriage.

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

Out Mist is a room in Endings. "A worm ring sits in the middle of the wood here. It's cannibalizing itself too much to be whole.[paragraph break]It's silent here and tough to see, but you're pretty sure your pursuers aren't approaching any more."

check going nowhere in Out Mist:
	say "No. This is the first thing you stumbled on, and getting more or less lost both seem equally bad." instead;

check going inside in out mist:
	try entering worm ring instead;

check entering worm ring:
	say "There's not enough space for you to fit." instead;

to good-end:
	say "The Whole Worm is bigger than you thought. You hide deeper and deeper. A passage turns down, and then here's a door. Through it you see your bedroom.";
	go-back-home;

understand "let ring" as a mistake("Your hair curls at the thought of such passivity.") when player is in Out Mist.

understand "master ring" as a mistake("You're RUNNING from the ring master, and you've already spent time mastering the Problems Compound.") when player is in Out Mist.

understand "ring [text]" and "[text] ring" as a mistake ("Nothing happens to the ring. It sits there as lumpy as before.") when player is in Out Mist.

understand "worm [text]" and "[text] worm" as a mistake ("The worm ring's problem isn't that it's a worm, but rather that it's a ring.") when player is in Out Mist.

the worm ring is scenery in Out Mist.

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
	say "The door leads to your closet and vanishes when you walk through. You're hungry after all that running around. Downstairs you find some old cereal you got sick of--but now you realize it could be Procrastination Cereal, Moping Cereal, or anything else--a small joke you'll be able to use for a while. Especially since it's hardly killer cereal--not even close.";
	wfak;
	say "You laugh at your own joke, which brings your parents out, complaining your late night moping is worse than ever. You promise them it'll get better.";
	wfak;
	say "Back in your bedroom, you have a thought. The Baiter Master saying you miss obvious things. Another look at [i]The Phantom Tolllbooth[r]: the inside flap. 'Other books you may enjoy.' There will be other obvious things you should've discovered. But it's good you found something right away, back in the normal world. You're confident you'll find more--and that people like the Baiter Master aren't the accelerated life experts you built them up to be.";
	unlock-verb "anno";
	print-replay-message;
	end the story finally saying "Wisdom Received!";

to print-replay-message:
	choose row with brief of "good" in the table of verb-unlocks;
	let T1 be found entry;
	choose row with brief of "great" in the table of verb-unlocks;
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

part Meal Square

check going west in pressure pier:
	if trail paper is in lalaland:
		do nothing;
	otherwise:
		say "The Howdy Boy coughs. '[one of]That's Meal Square. No one to get in a food fight with or anything[or]There's other better places to break the rules than Meal Square[stopping].'" instead;

Meal Square is west of Pressure Pier. Meal Square is in Main Chunk. "This is a small alcove with Pressure Pier back east. [one of]One wall features a huge peanut, with a gallery of foods[or]The gallery peanut covers one wall[stopping]. There's also a picture of a dozen bakers."

check going nowhere in meal square:
	say "No way out except east." instead;

the picture of a dozen bakers is scenery in Meal Square. "It's a weird optical illusion--sometimes you count twelve, but if you look right, they warp a bit, and there's on extra. What's up with that?"

after doing something with bakers:
	set the pronoun them to bakers;

instead of doing something with bakers:
	if action is undrastic:
		continue the action;
	say "It's just there for scenery. There's nothing behind it or whatever."

chapter cracker safe

[The cracker safe is a fixed in place container in Meal Square. "This is a safe with walls shaped like crackers. Its 'dial' is circular (crackers come in all sizes and shapes, dontcha know) and appears to be unlabeled."

check opening cracker safe:
	say "The safe offers no way to open it." instead;]

chapter fast food menu

[fast food? Get it? It gets you through the game fast! Ha ha!]

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
			say "[if off-eaten is true]You can't deal with the Word Weasel and Rogue Arch again. Well, actually, you can, but it's a new quasi-fun experience to pretend you can't[else if cookie-eaten is true]You'd like to go back and win an argument with the Word Weasel, but he seems like small potatoes compared to showing the [bad-guy] a thing or two[else]You're too good to need to kiss up to the Word Weasel again[end if]." instead;
		say "[if off-eaten is true]Go back south? Oh geez. Please, no[else]Much as you'd like to revisit the site of that argument you won so quickly, you wish to move on to greater and bigger ones[end if]." instead;
	if the room noun of location of player is nowhere:
		say "Nothing that-a-way." instead;
	if the room noun of the location of player is visited:
		say "You look [noun]. Pfft. Why would you want to go back? You're more focused after having an invigorating meal.";
	else:
		say "[if off-eaten is true]You really don't want to get lost among whatever weird people are [noun]. You're not up to it. You just want to talk to anyone who can get you out of here.[else]Pfft. Nothing important enough that way! Maybe before you'd eaten, you'd have spent time wandering about, but not now. North to Freak Control![end if]" instead;

section greater cheese

the greater cheese is an edible thing in Meal Square.

greater-eaten is a truth state that varies.

check taking greater cheese:
	try eating noun instead;

check eating greater cheese:
	if off-eaten is true:
		say "Ugh! You've had enough cheese." instead;
	if cookie-eaten is true:
		say "Ugh! You've had enough cheese." instead;
	say "You pause a moment before eating the greater cheese. Perhaps you will not appreciate it fully, or you will appreciate it too much and become someone unrecognizable. Try eating it anyway?";
	unless the player yes-consents:
		say "[line break]OK." instead;
	say "You manage to appreciate the cheese and feel superior to those who don't. You have a new outlook on life!";
	now greater cheese is in lalaland;
	now greater-eaten is true instead;

section off cheese

the off cheese is an edible thing in Meal Square.

off-eaten is a truth state that varies.

check taking off cheese:
	try eating off cheese instead;

check eating off cheese:
	if greater-eaten is true:
		say "You are above eating disgusting cheese. Unless it's tastefully disgusting, like what you just ate." instead;
	if cookie-eaten is true:
		say "Ugh! Now that you've eaten the cutter cookie, the off cheese looks even more gross than before. No way. You just want to leave." instead;
	say "Hmm. It seems edible, but it might be, well, character-building. You might not be the same person after eating it. Try eating it anyway?";
	unless the player yes-consents:
		say "[line break]OK." instead;
	say "Ugh. Bleah. It feels and tastes awful--but if you sat through this, you can sit through an awkward conversation. Not that you'll do anything like cause a few.";
	now off cheese is in lalaland;
	now off-eaten is true instead;
	
chapter cutter cookie

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
	say "[line break]You have to eat it carefully, because of its spikes, but it gives you...a sharp tongue. Suddenly you're ready to go off on pretty much anyone who's gotten in your way, or even not helped you enough[if allow-swears is false]. You'll show those punks you don't need to swear to kick butt![else].[end if]";
	now cookie is in lalaland;
	now cookie-eaten is true instead;

table of accel-text
accel-place	alt-num	accel-cookie	accel-off	accel-greater
pressure pier	0	"You take a moment to sneer at the Howdy Boy. 'Is this your JOB? Man, that's SAD. The stupid stuff you want people to do to show you they're cool? Little league stuff. I mean, thanks for the start and all, but SERIOUSLY.' He gapes, shocked, then flees before your wrath.[paragraph break]Man! You've never won an argument before. And you didn't expect to win that conclusively. Oh, wait, yes you did."	"You give an exasperated sigh. 'I'm not here because I want to be. I got suckered into it. Do you think I could...?'[paragraph break]'You know, some people don't even ASK. Or if they do, it's all unforceful. You're okay. You can go through.' The Howdy Boy bows slightly--you don't care if it's sarcastic or not--and you walk past. You turn around, but he's not there."	--
jerk circle	1	"'Hey, move it, I'm on a quest here!' They look shocked. You proceed to berate them for, is this all they ever do? Is it their purpose in life? Do they have anyone better to talk to? If so, what a waste. If not, sad.[paragraph break]Before this terrifying onslaught of hard-hitting language and lucid, back-to-basics logic, the [j-co] recognize how minor-league they are. They run off to chat or commiserate elsewhere.[paragraph break]Bam! Seven at one blow!"	"'Hey, what you all talking about?' you ask. 'Gossip, eh?' You try to join in, but--they seem a bit jealous of how good your grumbling is, and they excuse themselves."
lalaland	2	"Oh, boy. Looking back, you didn't need all that reasoning to get past them. You could've probably just acted a little exasperated, said you were SURE someone could help, and wham! Well, it's good to have all this space, but you need to be going north."	"You sniff at the memory of the [j-co] you helped. They weren't properly grateful, and they weren't even good at being jerks. Maybe you should've gone into business with the Labor Child. You'd figure how to backstab him later. Still, you learned a lot from that. Perhaps you can find ways to keep tabs on people, probe their weaknesses. Makes up for earlier memories of your own."
speaking plain	0	"Oh geez. You can't take this. You really can't. All this obvious improvement stuff. You lash out, do they think people REALLY don't know this? Do they think hearing it again will help? Uncle Dutch and Turk Young revile you as a purveyor of negative energy. No, they won't go on with all this cynicism around. But you will be moving on soon enough. They go away for a break for a bit."	"'FRAUDS!!!' you yell at Uncle Dutch and Turk Young. 'ANYONE CAN SPOUT PLATITUDES!' You break it down sumpin['] sumpin['] real contrarian on them, twisting their generalities. A crowd gathers around. They applaud your snark! You yell at them that applause is all well and good, but there's DOING. They ooh and ahh further. After a brief speech about the dork you used to be, and if you can get better, anyone can, you wave them away."
questions field	3	"Well, of COURSE the Brothers didn't leave a thank-you note. Ungrateful chumps. Next time you help someone, you'll demand a deposit of flattery up front, that's for sure."	"You expected no thanks, but you didn't expect to feel bad about getting no thanks. Hmph. Lesson learned!"
questions field	4	"'Kinda jealous of your brother[bro-s], eh? Not jealous enough to DO anything about it.' The brother[bro-nos]s nod at your sterling logic. 'You gonna waste your whole life here? I can't help everyone. I'm not a charity, you know.' More hard hitting truth! Ba-bam!'[wfk]'Go on, now! Go! What's that? I'm even bossier than the [bad-guy]? Excellent! If I can change, so can you! And the guy bossier than the [bad-guy] is ORDERING you to do something useful with your life!'[paragraph break]They follow your orders. You remember being bossed around by someone dumber than you--and now you turned the tables! Pasta fazoo!"
questions field	5	"'[qfjs] standing around, eh? Nothing to do? Well, I've been out, y'know, DOING stuff. You might try it. Go along. Go. You wanna block me from seeing the [bad-guy]? I'll remember it once he's out of my way.' You're convincing enough, they rush along."	"You've done your share of standing around, but you're pretty sure you did a bit of thinking. 'Look,' you say, 'I just need to get through and get out of here. I'm not challenging anyone's authority. Just, I really don't want to be here.' [bro-consider]. You're free to continue."
freak control	0	"You speak first. 'Don't pretend you can't see me, with all those reflective panels and stuff.'[paragraph break]He turns around, visible surprised.[paragraph break]'Leadership, schmeadership,' you say. You're worried for a moment he might call you out on how dumb that sounds. You're open-minded like that. But when he hesitates, you know the good insults will work even better. 'Really. Leaving the cutter cookie right where I could take it, and plow through, and expose you for the lame chump you are. Pfft. I could do better than that.'[paragraph break]He stutters a half-response.[paragraph break]'Maybe that's why [bad-guy-2] hasn't been dealt with, yet. You say all the right things, but you're not forceful enough. Things'll change once I'm in power.'[wfk]He has no response. You point outside. He goes. Settling in is easy--as a new leader of Freak Control, you glad-hand the important people and assure them you're a bit cleverer than the [bad-guy] was.  Naturally, you keep a list of [bad-guy-2]'s atrocities, and they're pretty easy to rail against, and people respect you for it, and from what you've seen, it's not like they could really get together and do anything, so you're making their lame lives more exciting.[wfk]You settle into a routine, as you read case studies of kids a lot like you used to be. Maybe you'd help one or two, if they had initiative...but until then, you'd like to chill and just let people appreciate the wit they always knew you had.[paragraph break]Really, who can defeat you? Anyone of power or consequence is on your side. Even [bad-guy-2] gives you tribute of a cutter cookie now and then. One day, you drop one in Meal Square... but nobody is brave enough to eat one. Well, for a while."	"You speak first. Well, you sigh REALLY loudly first. 'Just--this is messed up. I want to leave.'[paragraph break]'Of course you do,' says the [bad-guy]. 'I don't blame you. If you're not in power here, it's not fun. It's sort of your fault, but not totally. Hey, you actually showed some personality to get here. Just--show me you're worthy of leaving.' You complain--more excitingly than you've ever complained before. Without flattering or insulting the [bad-guy] too much: fair and balanced. You let him interrupt you, and you even interrupt him--but only to agree with his complaints.[wfk]'You're okay, I guess. You seem to know your place. Here, let me show you the Snipe Gutter. It seems like just the place for you. The [bad-guy] pushes a button and gestures to an opening. It's a slide. You complain a bit, but he holds up his hand. 'You'll have a lot more to complain about if you don't go.' You're impressed by this logic, and you only wish you could've stayed longer to absorb more of it, and maybe you could complain even more interestingly.[wfk]Back home, people notice a difference. You're still upset about things, but you impress people with it now. You notice other kids who just kind of seem vaguely upset, like you were before the Compound, not even bothering with constructive criticism. They're not worth it, but everywhere you go, you're able to fall in with complainers who complain about such a wide variety of things, especially people too dense to realize how much there is to complain about! You've matured, from..."	"'Hey! It's me!' you yell. The [bad-guy] turns. 'You know, I probably skipped a lot of dumb stuff to get here. You think you could be a LITTLE impressed?'[wfk]But he isn't. 'You know? You're not the first. Still, so many people just sort of putter around. You're going to be okay in life.' You two have a good laugh about things--you're even able to laugh at yourself, which of course gives you the right to laugh at people who haven't figured things out yet. Humor helps you deal, well, if it doesn't suck. You realize how silly you were before with all your fears, and you try to communicate that to a few creeps who don't want to be social. But they just don't listen. You'd rather hang around more with-it typpes, and from now on, you do."

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
			say "[bug]. There should be text for the off-cheese and this location.";
		else:
			say "[accel-off entry]";
	if greater-eaten is true:
		if there is no accel-greater entry:
			say "[bug]. There should be text for the greater-cheese and this location.";
		else:
			say "[accel-off entry]";
	if cookie-eaten is true:
		if there is no accel-off entry:
			say "[bug]. There should be text for the cookie and this location.";
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
		say "People Power? Power People!";
	else if off-eaten is true:
		say "Can't Complain? Complain Cant!";
	else if cookie-eaten is true:
		say "Mean Something? Something Mean!";

to say qfjs:
	say "[if questions field is unvisited]Just[else]Still[end if]"

to say bro-consider:
	if bros-left is 1:
		say "You both agree that you probably would've helped him, too, if you had the time, but life stinks. You exchange an awkward handshake good-bye";
	else:
		say "The brothers confer. '[bad-abb] said to let him in...obviously harmless...grumbly...' You tap your foot a bit and sigh. They wave you through and nip off to the side"

to say bad-abb:
	say "[if allow-swears is true]BM[else]CM[end if]"

to say bro-s:
	say "[if bros-left is 1]s[end if]";

to say bro-nos:
	say "[unless bros-left is 1]s[end if]";

cookie-eaten is a truth state that varies.

a cutter cookie is an edible thing in Meal Square. description is "It looks like the worst sort of thing to give kids on Halloween. If it doesn't have any actual razor blades, it's pointy as a cookie should not be. It's also grey and oatmeal-y, which cookies should never be. I mean, I like oatmeal cookies, just not dingy grey ones. It seems like excellent food for if you want to be very nasty indeed."

chapter gallery peanut

the gallery peanut is scenery in Meal Square. "It's hollowed out to contain a variety of foods: [a list of edible things in meal square]."

check eating gallery peanut:
	say "It's too big to be edible and probably too sturdy, too.";

chapter condition mint

for writing a paragraph about an edible thing:
	say "The gallery peanut contains several different food samples: [a list of edible things in meal square].";
	now all edible things in meal square are mentioned;

a condition mint is an edible thing in Meal Square. description is "It's one inch square, with SHARE WITH A FRIEND on it."

check eating the condition mint:
	say "No, it's for someone else." instead;

check giving the condition mint to:
	if noun is not a client:
		say "Your offer is declined. Perhaps you need to find someone who has just finished a meal." instead;
	if finger index is not examined:
		say "The [j-co] seem nasty enough, you don't want to share even a mint with any of them. Maybe if you found some way to empathize with them." instead;
	choose row with jerky-guy of noun in table of fingerings;
	if suspect entry is 1:
		say "[noun] is a bit too nervous around you, as you already figured his secret." instead;
	say "[noun] accepts your offer gratefully, and you discuss the list with him. 'Oh dear,' he says, 'I must be [clue-letter].'[paragraph break]You assure him his secret is safe with you.";
	now suspect entry is 2;
	the rule succeeds;

definition: a client (called cli) is befriended:
	choose row with jerky-guy of cli in table of fingerings;
	if suspect entry is 2:
		decide yes;
	decide no;

chapter iron waffle

an iron waffle is an edible thing in Meal Square. description is "Just staring at it, you imagine ways to brush off people who get up in your grill with dumb questions. You try and forge them into a set of rules, but you feel, well, rusty."

check taking the iron waffle:
	say "It'd be too heavy." instead;

check eating the iron waffle:
	say "Your teeth are actually pretty good, and that'd be a great way to change that." instead;

chapter gagging lolly

a gagging lolly is an edible thing in Meal Square. description is "Staring at the circular lolly's blend of hideous colors, you also feel less sure of things, which makes you feel open-minded, which makes you feel more sure of things, which makes you feel closed-minded and eventually less sure of things.[paragraph break]Man! That was tough to digest. Just all that thinking was a choking enough sensation."

check taking lolly:
	say "You haven't walked around with a lolly since you were five years old, and it'd be a bit embarrassing to do so now." instead;

before giving gagging lolly to:
	if noun is labor child:
		say "He's so totally outgrown that." instead;
	if noun is a bro:
		say "That'd be a vicious cheat, if it worked. Shame on you." instead;
	say "Alas, [second noun], recognizing the gagging lolly would shut [if second noun is male]him[else]her[end if] up or worse, rejects your gift." instead;

book Bad Ends

Bad Ends is a region.

part Punishment Capitol

Punishment Capitol is in Bad Ends. "You've really hit the jackpot! I guess. Everything is bigger and better here, and of course you're constantly reminded that you have more potential to build character here than in Hut Ten or Criminals['] Harbor. And whether you grumble or agree, someone officious is there to reenforce the message you probably won't build that character. But you have to try![paragraph break]Oh, also, there's word some of the officers have a black market going with [bad-guy-2], too, but people who do that--well, there's never any evidence."

part Hut Ten

Hut Ten is a room in Bad Ends. "Here you spend time in pointless military marches next to people who might be your friends in kinder environs. Apparently you're being trained for some sort of strike on [bad-guy-2]'s base, whoever he is. As time goes on, more recruits come in. You do well enough, you're allowed to boss a few around. But it's not good ENOUGH."

part Beer Pound

there is a room called A Beer Pound. It is in Bad Ends. "Here prisoners are subjected to abuse from prison guards who CAN hold their liquor and NEED a drink at the end of the day. Though of course they do not go in for the hard stuff."

part Shape Ship

Shape Ship is a room in Bad Ends. "Here, you spend months toiling pointlessly with others who acquired too many boo ticketies. You actually strike up a few good friendships, and you all vow to take more fun silly risks when you get back home.[paragraph break]As the days pass, the whens change to ifs."

part Criminals' Harbor

Criminals' Harbor is a room in Bad Ends. "Many poor teens in striped outfits or orange jumpsuits plod by here."

part Maintenance High

Maintenance High is a room in Bad Ends. "A teacher drones on endlessly about how it's not necessarily drugs that are bad, that people can mess themselves up even worse than drugs, and there's a whole huge lecture on how to be able to integrate making fun of drug users and feel sorry for them, to be maximally interesting."

part Fight Fair

Fight Fair is a room in Bad Ends. "The [bad-guy] watches down from a video screen as much stronger people beat up on much weaker people. 'Use your minds! Be grateful they're not really hurting you!' Nobody dares call it barbaric. After all, it could be worse."

Camp Concentration is a room in Bad Ends. "This one's impossible to joke about straight-up."

book dream sequence

Dream Sequence is a region.

nar-count is a number that varies. nar-count is 1.

toad-waits is a truth state that varies.

caught-sleeping is a truth state that varies.

last-room-dreamed is a room that varies.

every turn when mrlp is dream sequence:
	if player is in tense past:
		if slept-through is false and toad-waits is true and caught-sleeping is false:
			now toad-waits is false;
			now slept-through is true;
			say "As if that wasn't enough, you feel someone jostling you. Wait, no. It's not someone in the dream.";
			wfak;
			say "[line break]It's the Stool Toad! You're back on the bench at Down Ground![paragraph break]'A popular place for degenerates. That'll be a boo-tickety for you.'[if your-tix < 4][line break]As you hold the ticket and rub your eyes, the Stool Toad walks back to the Joint Strip. 'It's a darn shame!' he moans. 'Only one sleeping ticket per lazy degenerate, per day! Need some other infractions to reach my quota!' You get the sense he wouldn't sympathize if you told him WHAT you dreamed about.[end if]";
			now caught-sleeping is true;
			get-ticketed;
			if your-tix < 5:
				move player to Down Ground, without printing a room description;
			the rule succeeds;
	if player is in Tense Future:
		now toad-waits is true;
	if last-room-dreamed is location of player:
		the rule succeeds;
	now last-room-dreamed is location of player;
	choose row nar-count in table of painful narratives;
	say "[if player is in tense past][b4-nar entry][else if player is in tense present][now-nar entry][else if player is in tense future][af-nar entry][else](BUG)[end if][line break]";

table of painful narratives
b4-nar	now-nar	af-nar	ac-nar
"'Dude, why do you read so much? It's sort of showing off.'"	"You are, for the moment, in English class. People are running circles around you discussing an assigned book. You overhear that YOU should be participating more, with all you used to read."	"You are outside a charity dinner--not allowed in, of course. A grown-up version of the classmate who made fun of you in the past for reading blathers on about how reading books helps children become success stories."	true
"A teacher chides the class to be 'nice like Alec.' They aren't, at recess."	"Some fake contrarian says that just being nice isn't nearly enough, and it's so formulated."	"You face an onslaught of people who were apparently trying to be nice to you, but NO..." 	
"The rest of the class glares at you after you ask one too many 'why' questions."	"Classmates moan endlessly about research papers, and you figure there's probably some law against choosing a subject you'd like."	"A classmate all grown up espouses original dynamic thinking and how schools just don't do enough."
"A young version of a now ex-friend berates young you for a small inefficiency in code his father noted."	"The ex-friend, older now, wonders why you stink at big-picture programming for computer class despite writing that immaculate Quick Sort routine."	"The ex-friend is lecturing at a big conference now, about how coding is about flexibility and trading ideas, but there's still a great job market for low-level stuff most people totally fear."
"You feel slightly sick hearing what a smart young boy you are. Study hard, and the social stuff will work itself out later."	"You hear whispers that Alec may be smart, but he can't be bothered to, you know, work well with other people. People who do the organizational stuff."	"You're stuck listening to a self-help guru tape blathering how what REALLY matters is how well you work with other people, and if brainy types never bothered to get this, the worse for them."
"Your six-year-old self listens to a 'sophisticated' joke by eleven-year-olds you don't understand."	"Your peers tell a dirty joke they're shocked you don't understand, but they're sure you're learning important stuff."	"A college professor lambastes your lack of curiosity and/or research network when you draw a blank on his/her clever cultural reference."
"Memories of elementary-school classmates bugging you about what you're writing, only to grow shortly bored with it."	"Memories of fringe-group kids not willing to share their writing with such a math and science square."	"A vision of THAT guy hawking his 'creative' autobiography, which is total rubbish."
"Remembering the first time you kicked a kickball in the air. The bully waiting under it, saying don't bother to run. Dropping it and hitting you good, your teammates furious you didn't try."	"Smart semi-friends laughing at the bully flunking a grade. Drug problems."	"Advanced-class peers discuss why you're not on the career track you should be. The bully joins in, saying if HE had your chances...they agree."
"You fail to deal with James Scott and Scott James both laughing at you for reading in third grade."	"You remember Bradley George and George Bradley arguing if you are just lazy or clueless. It's unclear whether they'd rather acknowledge if you're in earshot, or not."	"In the future, you see co-workers Simon Terry and Terry Simon argue over whether you should be fired because you concentrate too much on details or too much on big things."

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

Madness March is west of Eternal Hope Springs. Madness March is in Rejected Rooms. "You hear the distant sound."

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
camp concentration	"I felt very, very horrible thinking of this, for obvious reasons, and similarly, I didn't want to put this in the game proper and fought about including it in the Director's Cut. I wasn't looking for anything provocative, but reading an online article, the switcheroo hit me. Because there's some things you clearly can't trivialize or pass off as a joke, or not easily. But I imagined a place where people yelled at you you needed to focus to stop making stupid mistakes, and of course it could be far FAR worse, and perhaps they want you to concentrate on that and also on being a productive member of society at the same time.[paragraph break]The gallows humor here I also saw is that the [bad-guy] never sends you here, because you aren't that bad, and of course he can use that to manipulate you, or say if this is mind control, there was other that was worse.[paragraph break]And while my writerly fee-fees are far from the most important thing, here, I was genuinely unnerved that I saw these links and my abstract-reasoning brain part went ahead with them, poking at the words for irony when there was something far more serious underneath."

alt-view is a truth state that varies.

to view-point:
	if the-view-room is Window Bay:
		say "Uh oh, BUG. [email].";
	else:
		now alt-view is true;
		move the player to the-view-room;
		now alt-view is false;
		move the player to Window Bay, without printing a room description;
	say "[line break]The vision blurs, and you look up from the View of Points, sadder but hopefully wiser."

to say email:
	say "blurglecruncheon@gmail.com";

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

chapter deal square

Deal Square is a room in Just Ideas Now. "People rush past, performing social tricks and calculus that you can only imagine, reading facial expressions and knowing when to interrupt. Man. You're sure you'd get skinned."

chapter perilous siege

Perilous Siege is a room in Just Ideas Now. "Some kind of combat is going on here! A big castle labeled [bad-guy-2-c]'S PLACE is surrounded by forces that can only be the [bad-guy][']s. Nobody's getting killed, but the insults are coming fast from each side."

chapter Truck Dump

Truck Dump is a room in Just Ideas Now. "So many trucks. Why do we need them? They beep at each other, everyone needing, if not wanting, to get where they're going. Piles of trash cut the plain into de facto narrow streets."

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
"an empty command?"	--
"XYZZY? Four times?"	--
"attacking anyone? Or the torch?"	--
"cussing in front of certain people?"	--
"going west/north/south in the Variety Garden?"	--
"giving Pusher Penn's 'merchandise' to the Stool Toad or Officer Petty?"	--
"giving Minimum Bear to anyone except Fritz the On?"	--
"putting the poetic wax on anything except the language machine?"	--
"saying YES or NO in the Drug Gateway?"	--
"visiting the Scheme Pyramid after the jerks take their revenge?"	--
"listening to all the songs from the song torch (there are [number of rows in table of horrendous songs])? Or just reading the source for them?"	--
"reading all the books from the book crack (there are [number of rows in table of horrendous books])? Or just reading the source for them?"	--
"SLEEPing in the extra directors' cut rooms in ANNO mode?"	--
"ENTERing the Return Carriage?"	very-good-end rule
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

book continuing

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"see where minor SWEARS change"	true	"SWEARS"	swear-see rule	swearseeing
"see the SINS the jerks didn't commit"	true	"SINS"	sin-see rule	sinseeing
"see the SPECIAL ways to see a bit more of the Compound"	true	"SPECIAL"	special-see rule	specialseeing

chapter special

specialseeing is an activity.

this is the special-see rule:
	unless hopper grass is in lalaland:
		say "[2da]Pusher Penn had more merchandise, not that he needed a bigger profit.";
	unless assassination character is in lalaland:
		say "[2da]The assassination character can be faked out.";
	if assassination character is in lalaland and insanity terminal is not in lalaland:
		say "[2da]There's a hint device you don't need beneath the Insanity Terminal.";
	if village-explored is false:
		say "[2da]You could've asked for help to find your way through Idiot Village.";

chapter sins

sinseeing is an activity.

this is the sin-see rule:
	say "None of the jerks was so square that he...[line break]";
	repeat through table of fingerings:
		if jerky-guy entry is Buddy Best:
			say " ... [blackmail entry][line break]";
	say "Not that there's anything wrong with that. Or there would be, if they did. But you knew that. And, uh, I know that, too. Really!"

chapter swearing

swearseeing is an activity.

this is the swear-see rule:
	say "[2da]The Baiter Master is the Complex Messiah.";
	say "[2da]Buster Ball is Hunter Savage.";
	say "[2da]The Jerk Circle is the Groan Collective.";
	say "[2da]The Business Monkey's efforts are half-brained or assed.";
	say "[2da]If you actually swear, obscenely or mildly (BOTHER)[line break]";
	say "[2da]A different reaction to repeatedly playing the logic puzzles[line break]";
	say "[2da]EXPLAIN Guy Sweet has a slight difference[line break]";
	say "Well, that's not much. I planned to have a lot more, but I just got sidetracked with silly stuff like bug fixing and adding to the story, which hopefully gave you less occasion to use profanity. Sorry about that."

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
	if ( (+ pier-visited +) ) { print "(Note: you can skip to Pressure Pier on retry with KNOCK HARD in Smart Street.)^"; }
	if ( (+ off-eaten +) || (+ cookie-eaten +) || (+ greater-eaten +)) { print "(Also note: this is not the best ending.)^"; }
	rfalse;
];

-) instead of "Print Obituary Headline Rule" in "OrderOfPlay.i6t".

volume mapping

book in-game map

table of map coordinates (continued)
rm	x	y	l1	l2	indir	outdir	updir	downdir
Smart Street	5	6	"SMART"	"STREE"	west
Round Lounge	4	6	"ROUND"	"LOUNG"	--	--	north
Tension Surface	4	5	"TENSI"	"SURFA"
Variety Garden	3	5	"VARIE"	"GARDN"
Vision Tunnel	5	5	"VISIO"	"TUNNL"
Soda Club	6	5	"SODA "	"CLUB "
Tense Future	0	1	"TENSE"	"FUTUR"
Tense Present	0	2	"TENSE"	"PRESE"
Tense Past	0	3	"TENSE"	"PAST "
Freak Control	4	0	"FREAK"	"CNTRL"
Accountable Hold	2	1	"ACCOU"	"HOLD "
Court of Contempt	3	1	"COURT"	"CONTE"
Questions Field	4	1	"QUEST"	"FIELD"
Standard Bog	5	1	"STAND"	"-BOG-"
Pot Chamber	6	1	"-POT-"	"CHAMB"
Truth Home	1	2	"TRUTH"	"HOME "
Scheme Pyramid	2	2	"SCHEM"	"PYRAM"
Temper Keep	3	2	"TEMPR"	"KEEP "
Speaking Plain	4	2	"SPEAK"	"PLAIN"
Crazy Drive	5	2	"CRAZY"	"DRIVE"
Interest Compound	6	2	"INTRS"	"COMPO"
Classic Cult	1	3	"CLASS"	"CULT "
Disposed Well	2	3	"DISPO"	"WELL "
Chipper Wood	3	3	"CHIPR"	"WOOD "
Jerk Circle	4	3	"JERK "	"CIRCL"
Judgment Pass	5	3	"JGMNT"	"PASS "
Idiot Village	6	3	"IDIOT"	"VILLG"
Bottom Rock	1	4	"BOTTM"	"ROCK "
Belt Below	2	4	"BELT "	"BELOW"
Meal Square	3	4	"MEAL "	"SQUAR"
Pressure Pier	4	4	"PRESS"	"PIER "
Down Ground	5	4	"DOWN "	"GROUN"
Joint Strip	6	4	"JOINT"	"STRIP"

book Inform IDE inits

index map with A Round Lounge mapped south of Tension Surface.

index map with Tension Surface mapped south of Pressure Pier.

index map with Tense Present mapped north of Tense Past.

index map with Tense Future mapped east of Tense Present.

index map with Bottom Rock mapped south of Disposed Well.

index map with The Belt Below mapped west of Bottom Rock.

index map with Eternal Hope Springs mapped south of The Belt Below.

index map with Tense Past mapped west of Classic Cult.

index map with Punishment Capitol mapped east of A Round Lounge.

index map with Hut Ten mapped east of Punishment Capitol.

index map with Maintenance High mapped south of Punishment Capitol.

index map with Criminals' Harbor mapped south of Hut Ten.

index map with Fight Fair mapped south of A Round Lounge.

volume parser errors

Rule for deciding whether all includes a helpy thing when taking: it does not.

rule for printing a parser error when the latest parser error is the didn't understand error:
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
			if jj matches the regular expression "^<abcdef>$":
				say "The Insanity Terminal emits an annoying buzz. It looks like you'll need to try again.";
				the rule succeeds;
		say "That isn't a recognized verb, or it's too complex a sentence. If you want to answer the terminal's puzzle, type AAAAAAAA -- or the answers all in a row. No need for spaces.";
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
		say ". You can type VERB or VERBS to see them all.";
	reject the player's command;

Rule for printing a parser error when the latest parser error is the i beg your pardon error:
	say "I'll need a phrase of turn here." instead;

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
	
volume real stuff

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

understand "man/boy/dude/guy/fellow" as a person when the item described is male and the item described is not Alec Smart.
understand "woman/girl/lady" as a person when the item described is female.

understand "director" as a person when the item described is in Interest Compound and the item described is not Alec Smart.

allow-swears is a truth state that varies.

screen-read is a truth state that varies.

started-yet is a truth state that varies.

to force-status: (- DrawStatusLine(); -);

to debug-freeze: [this is so, in case I want to freeze the game, it doesn't seep into release mode. I should probably put this into my general tools module at some point, along with other things.]
	if debug-state is true:
		say "(any key)";
		wait for any key;
		say "[line break]";

rule for constructing the status line when started-yet is false (this is the status before you move rule) :
	center "Your bedroom, up too late" at row 1;

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
		say "[one of]You jump farther than you could've imagined[or]You've got the hang of jumping, now[stopping].";
		if mrlp is Rejected:
			now jump-to-room is location of player;
			move player to jump-from-room;
		else:
			now jump-from-room is location of player;
			move player to jump-to-room;
		the rule succeeds;
	say "You're not ready to form hasty conclusions."

chapter lalaland

meta-rooms is a region.

bullpen is a room in meta-rooms. "You should never see this. If you do, it is a [bug]."

lalaland is a room in meta-rooms. "You should never see this. If you do, it is a [bug]."

volume extended stuff

the crocked half is a thing. description is "[fixed letter spacing][stars][upper][stars][variable letter spacing]"

to say stars:
	say "   *     *[line break]";

to say upper:
	say "   |\   /|[line break]
   | \ / |[line break]
*--*--*--*--*[line break]
 \ | / \ | /[line break]
  \|/   \|/[line break]";

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
	if player is in airy station:
		if the player's command includes "home hammer":
			try examining hammer instead;
		if the player's command includes "away hammer":
			try examining hammer instead;
		if the player's command includes "lock hammer":
			try examining hammer instead;

volume swear deciding

To decide what number is swear-decide:
	(- OKSwear(); -)

Include (-

Global copout;

[ OKSwear i j;
	if ((+ debug-state +) == 1) rtrue;
	copout = 0;
	for (::) {
		#Ifdef TARGET_ZCODE;
		if (location == nothing || parent(player) == nothing) read buffer parse;
		else read buffer parse DrawStatusLine;
		j = parse->1;
		#Ifnot; ! TARGET_GLULX;
		KeyboardPrimitive(buffer, parse);
		j = parse-->0;
		#Endif; ! TARGET_
		copout++;
		if (copout == 4) { return 2; }
		if (j) { ! at least one word entered
			i = parse-->1;
			if (i == YES1__WD or YES2__WD or YES3__WD) rtrue;
			if (i == NO1__WD or NO2__WD or NO3__WD) rfalse;
			print "I won't judge. Yes or no. > ";
		} else { print "No wrong answer. You won't miss anything either way. Yes or no. > "; }
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
		if Q is lalaland or Q is bullpen:
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

test dream with "gonear bench/sleep/wake/sleep/z/wake/sleep/z/wake/sleep/z/wake"

test street with "talk to guy/1/1/1/1/1/1/play nim/in"

test lounge with "get all/put screw in stick/climb chair/hit hatch"

test arch with "w/give token/dig dirt/e/e/dig earth/read burden/w/w/talk to weasel/1/2/2/2/2/2/2/2/2/give burden/e/give burden/n"

test pier with "e/sleep/z/z/z/e/get bear/s/talk to punch/1/2/2/2/3/n/talk to punch/2/2/talk to lily/1/1/1/1/1/1/1/1/give wine to lily/n/w/give bear to fritz/w/give paper to boy/n"

test cutter with "j/j/j/test pier/s/w/eat cookie/y/e/n/n/n/n"

test startit with "test street/test lounge/test arch/test pier"

test to-bar with "test street/test lounge/test arch/talk to howdy/1/3/3/3/3/e/get bear/give bear to fritz/e/s"

test blood with "n/n/w/talk to buddy/1/1/1/s/s/w/w/n/x hedge/y/s/e/e/e/give tag/e/give seed to monkey/give contract to monkey/w/w/w/w/w/give blossom to faith/e/e/e/n/n/give mind to brother blood/s/s/bro 1"

test soul with "n/e/in/talk to penn/1/2/2/y/2/2/out/w/s/s/e/give weed to fritz/w/n/n/e/in/give penny to penn/out/w/w/put pot in vent/x vent/open vent/e/n/give light to brother soul/s/s/bro 2"

test big-old with "n/e/w/s/w/w/put string in hole/n/n/get sound safe/x finger/s/s/e/e/n/e/e/open safe/talk to story fish/get poetic wax/w/n/put wax in machine/wear trick hat/s/talk to charmer snake/w/s/w/w/in/give trap rattle to fool/out/e/e/n/n/give trade to brother big/s/s/bro 3"

test big with "n/e/get string/w/s/w/w/put string in hole/n/n/get sound safe/s/s/e/e/n/e/e/open safe/talk to story fish/get poetic wax/w/n/put wax in machine/wear trick hat/s/w/s/e/e/give hat to sly/w/w/w/w/in/give trap rattle to fool/out/e/e/n/n/give trade to brother big/s/s/bro 3"

test jk with "j/j/j/j/brobye/purloin finger/x finger/talk to jerks/talk to boris"

test final with "n/talk to baiter/1/1/1/1/1/1/1/1/1"

test lastroom with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/n/explain me"

test winit with "test startit/test blood/test soul/test big/purloin quiz pop/n/n/drink quiz pop/test final"

test winfast with "gonear freak control/1/1/1/1/1/1/1/1"

test pops with "get pop/n/n/drink pop/n"

test arts-before-after with "gonear compound/x crack/x torch/purloin fish/play it/purloin safe/open it/x crack/x torch"

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
	say "NOTE TO BETA TESTERS: the EST command lets you toggle whether or not win-tries end the game, so you don't have to keep UNDOing. Whatever you can try is a big help.";

after printing the locale description when player is in beta-zap-room and beta-zap-room is unvisited (this is the stop the game before I'm embarrassed by implementation rule) :
	if debug-state is false:
		say "You've gotten as far as is useful to me know. Thank you so much! Please send the transcript to [email].";
		end the story;
	else:
		say "NOTE: flagging that play would end here in a beta version."

when play begins (this is the force tester wherever rule):
	now in-beta is true;
	if debug-state is false:
		say "Note: I like to make sure beta testers have a transcript working. It's a big help to me. So, after you press a key, you'll be asked to save a file.";
		wfak;
		try switching the story transcript on;
		say "Transcripts can be sent to blurglecruncheon@gmail.com. Any punctuation before the comment is okay, e.g. *TYPO or ;typo or :typo.";
	continue the action;

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
	repeat with Q running through carried things:
		try giving Q to the noun;
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
		move player to jerk circle;
		now player has crocked half;
	if number understood is 102:
		move-puzzlies-and-jerks;
		move player to jerk circle;
		now assassination character is in lalaland;
		open-bottom;
		now player has crocked half;
	if number understood > 9:
		say "You need a number between 1 and 9 or, if you are testing very specific things, 100-100.[line break][skip-list]" instead;
	now skipped-yet is true;
	if number understood is 1:
		move player to round lounge;
		now player has gesture token;
	else if number understood is 2:
		move player to tension surface;
		now player has gesture token;
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
		move player to freak control;
	else if number understood is 8:
		move player to Out Mist;
	else if number understood is 9:
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
	say "1: Round Lounge 2: Tension Surface 3: Pressure Pier 4: Jerk Circle 5: All 3 given to Brothers 6: Jerks solved 7: Final chat 8: Out Mist 9: Airy Station[line break]100. Chipper Wood/Assassination Character[line break]"

chapter ctcing

[* ctc = clear the chase]

ctcing is an action out of world.

understand the command "ctc" as something new.

understand "ctc" as ctcing.

carry out ctcing:
	if assassination is in lalaland:
		say "He's already gone." instead;
	if p-c is true:
		now p-c is false;
	say "Ok, bye-bye AC.";
	now belt below is below chipper wood;
	now chipper wood is above belt below;
	now assassination is in lalaland;
	now chase paper is in lalaland;
	the rule succeeds;

chapter montying

[* this turns testing stuff on and off. It will be more detailed later.]

montying is an action applying to one topic.

widdershins is a direction. the opposite of widdershins is turnwise. description of turnwise is "[bug]".

understand the command "monty" as something new.

understand "monty [text]" as montying.

monty-full is a truth state that varies.

carry out montying:
	let found-toggle be false;
	if the topic understood matches "all":
		repeat through table of monties:
			now on-off entry is true;
		the rule succeeds;
	say "[b]Going Widdershins (ungoable direction) :[r]";
	repeat through table of monties:
		if the topic understood matches montopic entry:
			now on-off entry is whether or not on-off entry is true;
			say "[test-title entry] is now [if on-off entry is true]on[else]off[end if].";
			now found-toggle is true;
	if found-toggle is false:
		say "MONTY didn't find anything to toggle.";
	the rule succeeds;
	try requesting the score;	
	if monty-full is false:
		say "Currently blocking crib hints with MONTY. Type CRIB to turn them on." instead;
	if jerk circle is visited:
		say "Currently allowing crib hints with MONTY. Type CRIB to turn them off.";
		try donoteing instead;
	else:
		say "You haven't made it to the jerk circle, so I won't look in the crib, yet." instead;
	the rule succeeds;

table of monties
montopic (topic)	on-off	test-title	test-action
"s/smell"	false	"SMELLING"	try-smelling rule
"l/listen"	false	"LISTENING"	try-listening rule
"sc/score"	false	"SCORING"	try-scoring rule
"dir/noway"	false	"DEAD ENDING"	try-wid rule
"donote/note"	false	"DONOTEING"	try-noting rule

this is the try-noting rule:
	try donoteing;

this is the try-wid rule:
	try going widdershins;

this is the try-smelling rule:
	try smelling;

this is the try-listening rule:
	try listening;

this is the try-scoring rule:
	try requesting the score;

every turn:
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
	now brother blood is in lalaland;
	now brother soul is in lalaland;
	now brother big is in lalaland;
	say "The Keeper Brothers are now out of play.";
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

chapter jerking

[* this tells testers what to do with the jerks]

jerking is an action out of world.

understand the command "jerk" as something new.

understand "jerk" as jerking.

carry out jerking:
	if jerk circle is unvisited:
		say "You haven't made it to the jerks yet." instead;
	if finger index is not examined:
		if accountable hold is visited:
			say "You missed important data on the [j-co]." instead;
		say "You haven't found any data on the [j-co] yet." instead;
	if know-jerks is false:
		say "You need to talk to the [j-co] to find their names." instead;
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
	say "Now that you're in the main area, this command won't let you warp further in your beta testing quest. However, BROBYE will disperse the Brothers and JERK will spoil the jerks['] puzzle." instead;
	the rule succeeds;
