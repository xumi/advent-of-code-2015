/*
http://adventofcode.com/day/10

--- Day 10: Elves Look, Elves Say ---

Today, the Elves are playing a game called look-and-say. They take turns making sequences by reading aloud the previous sequence and using that reading as the next sequence. For example, 211 is read as "one two, two ones", which becomes 1221 (1 2, 2 1s).

Look-and-say sequences are generated iteratively, using the previous value as input for the next step. For each step, take the previous value, and replace each run of digits (like 111) with the number of digits (3) followed by the digit itself (1).

For example:

1 becomes 11 (1 copy of digit 1).
11 becomes 21 (2 copies of digit 1).
21 becomes 1211 (one 2 followed by one 1).
1211 becomes 111221 (one 1, one 2, and two 1s).
111221 becomes 312211 (three 1s, two 2s, and one 1).

Starting with the digits in your puzzle input, apply this process 40 times. What is the length of the result?

*/

// ------------------------------------------------
// My puzzle input
// ------------------------------------------------
var INPUT = '1113222113';

// How many times we have to loop
var AMOUNT = 40;

// ------------------------------------------------
// The Algorithm
// ------------------------------------------------
function search(input){
	var string = input;
	// We apply the process AMOUNT times
	for(var i=0;i<AMOUNT;i++){
		string = lookAndSay(string);
	}
	// Return the length of the string
	return string.length;
}

function lookAndSay(string){
	// We start with a blank string
	var result = '';
	// The last char we looked at
	var lastChar  = false;
	// The amount of times we saw the current char
	var countChar = 1;

	function dumpCharCount(){
		// We append the count and the char to the result string
		result += [countChar,lastChar].join('');
		// We reset the counter
		countChar = 1;
	}

	// We loop through the string
	for(var i=0;i<string.length;i++){
		// We get the current char
		var c = string.charAt(i);
		// If already looked at a previous char
		if(lastChar){
			// If this is the same char again we increment the counter
			if(c==lastChar){
				countChar++;
			// Otherwise we know the amount of repeated lastChar. Let's write it in our result string
			}else{
				// Save the count in the result string
				dumpCharCount();
			}
		}
		// We save the the current char for the next loop
		lastChar = c;
	}
	// We still have to save the count of the last known lastChar
	dumpCharCount();
	// We return the full string
	return result;
}

// ------------------------------------------------
// The Solution
// ------------------------------------------------
console.log(search(INPUT));