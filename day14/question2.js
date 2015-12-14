/*
http://adventofcode.com/day/14

--- Day 14: Reindeer Olympics ---

--- Part Two ---

Seeing how reindeer move in bursts, Santa decides he's not pleased with the old scoring system.

Instead, at the end of each second, he awards one point to the reindeer currently in the lead. (If there are multiple reindeer tied for the lead, they each get one point.) He keeps the traditional 2503 second time limit, of course, as doing otherwise would be entirely ridiculous.

Given the example reindeer from above, after the first second, Dancer is in the lead and gets one point. He stays in the lead until several seconds into Comet's second burst: after the 140th second, Comet pulls into the lead and gets his first point. Of course, since Dancer had been in the lead for the 139 seconds before that, he has accumulated 139 points by the 140th second.

After the 1000th second, Dancer has accumulated 689 points, while poor Comet, our old champion, only has 312. So, with the new scoring system, Dancer would win (if the race ended at 1000 seconds).

Again given the descriptions of each reindeer (in your puzzle input), after exactly 2503 seconds, how many points does the winning reindeer have?

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
		// We give a point to the first reindeers
		awardFirst(reindeers);
	}
	// We return the maximum points
	return getMaxPoints(reindeers);
}


function awardFirst(reindeers){
	// We find the maximum distance
	var max = getMaxDistance(reindeers);
	Object.keys(reindeers).forEach(function(name){
		// We award a point to this reindeer if he reached the maximum distance
		if(reindeers[name].distance === max){
			reindeers[name].points++;
		}
	});	
}

function getMaxDistance(reindeers){
	var max = 0;
	Object.keys(reindeers).forEach(function(name){
		max = Math.max(reindeers[name].distance, max);
	});
	return max;
}

function getMaxPoints(reindeers){
	var max = 0;
	Object.keys(reindeers).forEach(function(name){
		max = Math.max(reindeers[name].points, max);
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
		// We initialize the amount of points
		reindeer.points		= 0;		
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
console.log(result+' points');