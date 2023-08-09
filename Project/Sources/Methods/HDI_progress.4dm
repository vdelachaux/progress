//%attributes = {}
var $i : Integer
var $o : Object
var $progress : cs:C1710.progress

// Display a progress by giving a title, a predefined icon "check" and a message
$o:={\
title: "Copy files"; \
icon: "check"; \
message: "We're doing some preliminary work..."\
}

$progress:=cs:C1710.progress.new($o)

// Giving the impression that we're doing something ;-)
DELAY PROCESS:C323(Current process:C322; 120)

// Now that we're ready, let's update :
// - Change to an indexed progress bar with a predefined "file" icon
// - If we define a stop formula, the Stop button will be displayed automatically.
// - If the message is empty, the percentage of completion is automatically displayed.
$progress.properties:={\
message: ""; \
stopFormula: Formula:C1597(_confirm); \
icon: "file"; \
type: "indexed"; \
calculationMessage: "Calculation in progress..."; \
cancellationMessage: "We're cancelling..."\
}

$progress.BringToFront()

// Giving the impression that we're doing something ;-)
DELAY PROCESS:C323(Current process:C322; 15)

For ($i; 1; 100; 1)
	
	// Giving the impression that we're doing something ;-)
	DELAY PROCESS:C323(Current process:C322; 5)
	
	If (Milliseconds:C459%3=0)\
		 | ($i=100)
		
		$progress.value:=$i
		
	End if 
	
	If ($progress.isStopped)
		
		break
		
	End if 
End for 

If ($progress.isStopped)
	
	// Do the cancellation work…
	// Close after 2 sec.
	$progress.Close(120)
	return 
	
End if 

// Restore default values
$progress.Reset()

// Change the icon & give new messages
$progress.properties:={\
title: "Finitions"; \
message: "Just a little more patience…"; \
icon: "wait"\
}

// Giving the impression that we're doing something ;-)
DELAY PROCESS:C323(Current process:C322; 240)

// If you no longer need the progress bar,
// You can use Quit() to close the dialog and kill the worker.
$progress.Quit()