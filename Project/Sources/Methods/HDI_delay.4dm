//%attributes = {}
var $i; $length : Integer
var $o : Object
var $progress : cs:C1710.progress

// Set a 240 ticks delay before the progress will be show
$o:={\
title: "Copy files"; \
type: "indexed"; \
icon: "file"\
}

// Sets a delay before progress is displayed.
If (Not:C34(Shift down:C543))
	
	// 3 secondes before progress is displayed.
	$o.delay:=60*3
	
Else 
	
	// Increasing the delay to 8 seconds means that progress will not displayed.
	$o.delay:=60*8
	
End if 

$progress:=cs:C1710.progress.new($o)

$length:=80

For ($i; 1; $length; 1)
	
	// Giving the impression that we're doing something ;-)
	DELAY PROCESS:C323(Current process:C322; 5)
	
	If (Milliseconds:C459%3=0)\
		 | ($i=$length)
		
		$progress.value:=$i*100/$length
		
	End if 
End for 

$progress.Close()

BEEP:C151