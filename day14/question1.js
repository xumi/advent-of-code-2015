/*
http://adventofcode.com/day/14

--- Day 14: Reindeer Olympics ---

This year is the Reindeer Olympics! Reindeer can fly at high speeds, but must rest occasionally to recover their energy. Santa would like to know which of his reindeer is fastest, and so he has them race.

Reindeer can only either be flying (always at their top speed) or resting (not moving at all), and always spend whole seconds in either state.

For example, suppose you have the following Reindeer:

Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.
Dancer can fly 16 km/s for 11 seconds, but then must rest for 162 seconds.
After one second, Comet has gone 14 km, while Dancer has gone 16 km. After ten seconds, Comet has gone 140 km, while Dancer has gone 160 km. On the eleventh second, Comet begins resting (staying at 140 km), and Dancer continues on for a total distance of 176 km. On the 12th second, both reindeer are resting. They continue to rest until the 138th second, when Comet flies for another ten seconds. On the 174th second, Dancer flies for another 11 seconds.

In this example, after the 1000th second, both reindeer are resting, and Comet is in the lead at 1120 km (poor Dancer has only gotten 1056 km by that point). So, in this situation, Comet would win (if the race ended at 1000 seconds).

Given the descriptions of each reindeer (in your puzzle input), after exactly 2503 seconds, what distance has the winning reindeer traveled?

*/

// ------------------------------------------------
// My puzzle input
// ------------------------------------------------
var INPUT = 'Vixen can fly 8 km/s for 8 seconds, but then must rest for 53 seconds.;Blitzen can fly 13 km/s for 4 seconds, but then must rest for 49 seconds.;Rudolph can fly 20 km/s for 7 seconds, but then must rest for 132 seconds.;Cupid can fly 12 km/s for 4 seconds, but then must rest for 43 seconds.;Donner can fly 9 km/s for 5 seconds, but then must rest for 38 seconds.;Dasher can fly 10 km/s for 4 seconds, but then must rest for 37 seconds.;Comet can fly 3 km/s for 37 seconds, but then must rest for 76 seconds.;Prancer can fly 9 km/s for 12 seconds, but then must rest for 97 seconds.;Dancer can fly 37 km/s for 1 seconds, but then must rest for 36 seconds.';
// The total travel time
var DURATION = 2503;

// ------------------------------------------------
// The Algorithm
// ------------------------------------------------
function search(instructions){
	// We parse the instructions to get the data
	var reindeers = parseInstructions(instructions);
	// We prepare the team
	hitch(reindeers);
	// We count the seconds
	for(var i=0;i<DURATION;i++){
		// For each reindeer
		Object.keys(reindeers).forEach(function(name){
			// We check the state of the reindeers
			checkState(reindeers[name]);
		});
	}
	// We return the maximum distance
	return getMaxDistance(reindeers);
}

function getMaxDistance(reindeers){
	var max = 0;
	Object.keys(reindeers).forEach(function(name){
		max = Math.max(reindeers[name].distance, max);
	});
	return max;
}

function checkState(reindeer){
	// We decrement the amount of time the reindeer will spend in his current state
	reindeer.countdown--;
	// If he is flying we mark his progress
	if(reindeer.flying){
		reindeer.distance += reindeer.maxFlyingSpeed;
	}
	// If he is tired or ready to fly again
	if(reindeer.countdown===0){
		// We invest his state
		toggleBehavior(reindeer);
	}
	return reindeer;
}

function hitch(reindeers){
	Object.keys(reindeers).forEach(function(name){
		var reindeer = reindeers[name];
		// All reindeers are ready to fly at start
		reindeer.flying     = true;
		// We initialize their distance counter
		reindeer.distance   = 0;
		// We initialize the coutdown to the flying time of the reindeer
		reindeer.countdown	= reindeer.maxFlyingTime;
		
	});
	return reindeers;
}

function toggleBehavior(reindeer){
	// If the reindeer is flying and needs to rest
	if(reindeer.flying){
		// We give him the time he needs to rest
		reindeer.countdown = reindeer.maxRestingTime;
	// If the reindeer is ready to fly again
	}else{
		// We tell him to fly for that duration
		reindeer.countdown = reindeer.maxFlyingTime;
	}
	// We invest his current state
	reindeer.flying = !reindeer.flying;
	return reindeer;
}

function parseInstructions(instructions){
	// We grab the useful parts
	var regexp = /(\S+)[^\d]+(\d+)[^\d]+(\d+)[^\d]+(\d+)/
	// The team
	var reindeers = [];
	// For each instructions
	instructions.forEach(function(instruction){
		var data = instruction.match(regexp);
		reindeers[data[1]] = {
			'maxFlyingSpeed': 	parseInt(data[2],10),
			'maxFlyingTime': 	parseInt(data[3],10),
			'maxRestingTime':  	parseInt(data[4],10),
		};
	});
	return reindeers;
}

// ------------------------------------------------
// The Solution
// ------------------------------------------------
var instructions = INPUT.split(';');
var result = search(instructions);
console.log(result+' kilometers');