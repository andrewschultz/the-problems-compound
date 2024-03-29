Version 2/180419 of Alec Smart Endgame Lists by Andrew Schultz begins here.

volume the actual endgame lists

Table of Final Question Options (continued)
final question wording	only if victorious	topic	final response rule	final response activity
"see [bi of list-seen]LIST[r] of flips ([b]L 1-[number of rows in table of context rewrites][r] or [b]LN[r] or [b]LP[r] for next/previous)"	true	"L/LIST"	list-flips rule	--
--	true	"LN"	next-list rule	--
--	true	"LP"	prev-list rule	--
--	true	"L [number]"	list-num rule	--

current-end-list is a number that varies.

list-seen is a truth state that varies.

to decide which number is concept-num of (co - a context):
	let total be 0;
	repeat with Q running through concepts:
		if context of Q is co, increment total;
	decide on total.

this is the list-flips rule:
	let count be 0;
	repeat through table of context rewrites:
		increment count;
		if concept-num of ctxt entry > 0:
			say "[count]: [ctxt-exp entry] ([concept-num of ctxt entry])[line break]";
		else if debug-state is true:
			say "DEBUG WARNING: [ctxt-exp entry] has no concepts.";
	if current-end-list > 0:
		choose row current-end-list in table of context rewrites;
		say "The current list is [current-end-list] ([ctxt-exp entry]).";
	else:
		say "You haven't seen a list yet.";

this is the next-list rule:
	increment current-end-list;
	if current-end-list > number of rows in table of context rewrites:
		now current-end-list is 1;
		say "Cycling back to first table element...";
	write-end-stuff-up;

this is the prev-list rule:
	decrement current-end-list;
	if current-end-list is 0:
		now current-end-list is number of rows in table of context rewrites;
		say "Cycling up to last table element(#[number of rows in table of context rewrites])...";
	write-end-stuff-up;

this is the list-num rule:
	if number understood > number of rows in table of context rewrites or number understood < 1:
		say "I need a number between 1 and [number of rows in table of context rewrites].";
	else:
		now current-end-list is number understood;
		write-end-stuff-up;

to write-end-stuff-up:
	now list-seen is true;
	choose row current-end-list in table of context rewrites;
	let cur-concept be ctxt entry;
	let cn be concept-num of cur-concept;
	if cn is 0:
		say "No concept is found by [ctxt-exp entry].";
		continue the action;
	say "[b]FULL LIST OF [ctxt-exp entry in upper case] CONCEPTS:[r][paragraph break]";
	let count be 0;
	repeat through table of explanations:
		if exp-thing entry is a concept and context of exp-thing entry is cur-concept:
			say "[b][exp-thing entry][r] ([i][gtxt of exp-thing entry]/[howto of exp-thing entry][r]): [exp-text entry][line break]";
			increment count;
			if the remainder after dividing count by 10 is 0 and count is not cn:
				say "([count]/[cn], push any key for next concepts or Q to quit)";
				if debug-state is false:
					let Q be the chosen letter;
					if Q is 81 or Q is 113, continue the action;

The standard respond to final question rule is not listed in for handling the final question.

The modified respond to final question rule is listed last in for handling the final question.

This is the modified respond to final question rule:
	repeat through the Table of Final Question Options:
		if the only if victorious entry is false or the story has ended finally:
			if there is a final response rule entry
				or the final response activity entry [activity] is not empty:
				if the player's command matches the topic entry:
					if there is a final response rule entry, abide by final response rule entry;
					otherwise carry out the final response activity entry activity;
					rule succeeds;
	say "I didn't recognize that. [run paragraph on]"

Alec Smart Endgame Lists ends here.

---- DOCUMENTATION ----

