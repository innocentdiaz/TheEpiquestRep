=====EPIQUEST=====

This is a web based game I made in a week some months ago, and now I want to fix. It's very short, and just needs some help to make it maintanable, and some new design.


COMPLICATIONS:
*Was made a long time ago and needs to be updated
*Needs new look / layout
*EXTREMELY hard coded
	>Random outcomes could be made an array, instead of if,else statements.
	>need to replace document.getElement with jQuery methods
	
*Needs to be rid of prompt() and be replaced with <input> element
	>This comes with the complication of how we input throughout the WHOLE game, so going through lines of prompt and making it be accessed by input will be time consuming. Good news is I already have 25% of inputs replaced. See the bottom for more info.

*Responsive design
*Fix bugs

#How input works#
In the past, you would be asked for input as a prompt variable, would then return the value to be checked. If X = true, else if, else, etc would execute, repeat this through the whole game.
Now I decided to replace prompt with an input element. When you click "ENTER" inside the input, it will do the "current()" function. Current is set everytime you call a function in the game.
Example:
<pseudo code example>
var current;
var displayToPlayer = function(message){
	$("h1").html(message);
};

displayToPlayer("What is you name?");

current = function(){
	name = input.value;
	
	displayToPlayer(Shall we begin, " + name + "?");

	current = function(){
		if (input.value == "yes"){
			//start game
		}
	}
}

<end of example>
