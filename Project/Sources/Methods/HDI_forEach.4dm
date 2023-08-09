//%attributes = {}
var $i : Integer
var $o : Object
var $c : Collection
var $progress : cs:C1710.progress

// MARK:-forEach with an object
$o:={}

For ($i; 1; 50; 1)
	
	$o["property "+String:C10($i)]:=$i
	
End for 

// Create a default progress with a title
$progress:=cs:C1710.progress.new("PROCESSING AN OBJECT")

// Make cancellable
$progress.cancellable:=True:C214

// Process:
// The formula will be executed for each property of the object
// If the third optional parameter is True, the resetted progress window will remain on screen.
$progress.forEach($o; Formula:C1597(_doSomething); True:C214)

If ($progress.isStopped)
	
	// Close after 2 sec.
	$progress.Close(120)
	return 
	
End if 

// Transition
$progress.title:="Waiting for next step…"
DELAY PROCESS:C323(Current process:C322; 80)

// MARK:-forEach with a collection
$c:=[]
$c[60]:=True:C214

// Change Title
$progress.title:="PROCESSING A COLLECTION"

// Process:
// The formula will be executed for each member of the collection
// If the third parameter is omitted, the progress window will be closed automatically.
$progress.forEach($c; Formula:C1597(_doSomething))