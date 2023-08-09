//%attributes = {"invisible":true}
#DECLARE($signal : 4D:C1709.Signal; $progress : cs:C1710.progress)

If (False:C215)
	C_OBJECT:C1216(progressManager; $1)
	C_OBJECT:C1216(progressManager; $2)
End if 

var $key; $name : Text
var $height; $left; $top; $type; $width : Integer

instances:=instances || []

Case of 
		
		//______________________________________________________
	: ($signal.action="new")
		
		If ($progress.delay>0)
			
			HIDE PROCESS:C324(Current process:C322)
			
		End if 
		
		If (Is macOS:C1572)  //& False
			
			$name:="MACOS"
			FORM GET PROPERTIES:C674($name; $width; $height)
			$left:=(Screen width:C187/2)-($width/2)
			$top:=Menu bar height:C440+Tool bar height:C1016+60
			$type:=Palette window:K34:3
			
			$progress[""].macOS:=True:C214
			
		Else 
			
			$name:="WINDOWS"
			FORM GET PROPERTIES:C674($name; $width; $height)
			$left:=(Screen width:C187/2)-($width/2)
			$top:=(Screen height:C188-$height)/2
			$type:=Plain fixed size window:K34:6
			
			$progress[""].macOS:=False:C215
			
		End if 
		
		$progress.window:=Open window:C153($left; $top; $left+$width; $top+$height; $type)
		DIALOG:C40($name; $progress; *)
		
		instances.push($progress)
		$progress.id:=instances.length
		
		//______________________________________________________
	: ($progress.window=Null:C1517)
		
		// Ooops
		
		//______________________________________________________
	: ($signal.action="close")
		
		CALL FORM:C1391($progress.window; Formula:C1597(CANCEL:C270))
		
		//______________________________________________________
	: ($signal.action="update")
		
		If ($progress.delay=0)\
			 | ($progress.timeSpent>$progress.delay)
			
			SHOW PROCESS:C325(Current process:C322)
			
		End if 
		
		For each ($key; [\
			"title"; \
			"message"; \
			"type"; \
			"icon"; \
			"cancellable"; \
			"autoMessage"; \
			"stopFormula"; \
			"stopButtonTitle"; \
			"cancellationMessage"; \
			"calculationMessage"\
			])
			
			CALL FORM:C1391($progress.window; Formula:C1597(Form:C1466[$key]:=$progress[""][$key]))
			
		End for each 
		
		// Refresh
		CALL FORM:C1391($progress.window; Formula:C1597(SET TIMER:C645(-1)))
		
		//______________________________________________________
End case 

If ($signal#Null:C1517)
	
	Use ($signal)
		
		// Return current instance
		$signal.instance:=OB Copy:C1225(instances[$progress.id-1]; ck shared:K85:29; $signal)
		
	End use 
	
	$signal.trigger()
	
	If ($signal.action="close")
		
		// Freeing memories
		instances[$progress.id-1]:=Null:C1517
		
	End if 
End if 