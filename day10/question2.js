/*
http://adventofcode.com/day/10

--- Part Two ---

Neat, right? You might also enjoy hearing John Conway talking about this sequence (that's Conway of Conway's Game of Life fame).

Now, starting again with the digits in your puzzle input, apply this process 50 times. What is the length of the new result?

*/

// ------------------------------------------------
// My puzzle input
// ------------------------------------------------
var INPUT = '1113222113';

// How many times we have to loop
var AMOUNT = 50;

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