//%attributes = {"invisible":true}
var $t : Text
var $bottom; $left; $right; $top; $unused : Integer
var $e; $o : Object
var $c : Collection

$e:=FORM Event:C1606

SET TIMER:C645(0)

$o:=Form:C1466[""]

If (Form:C1466.isStopped)
	
	OBJECT SET VALUE:C1742("progress"; 1)
	$t:=$o.cancellationMessage
	ST SET ATTRIBUTES:C1093($t; ST Start text:K78:15; ST End text:K78:16; Attribute text color:K65:7; "red")
	$o.message:=$t
	$o.autoMessage:=False:C215
	
	return 
	
End if 

If ($o.cancellable)\
 && ($e.code=On Clicked:K2:4)\
 && ($e.objectName="stop")
	
	If (Form:C1466.stopFormula#Null:C1517)
		
		Form:C1466.isStopped:=Form:C1466.stopFormula.call(Null:C1517; Form:C1466)
		
	Else 
		
		Form:C1466.isStopped:=True:C214
		
	End if 
End if 

If (Form:C1466.isStopped)
	
	// Hide stop button
	OBJECT SET VISIBLE:C603(*; "stop"; False:C215)
	OBJECT GET COORDINATES:C663(*; "markerNoStop"; $left; $top; $right; $bottom)
	OBJECT GET COORDINATES:C663(*; "progress"; $left; $top; $unused; $bottom)
	OBJECT SET COORDINATES:C1248(*; "progress"; $left; $top; $right; $bottom)
	
	// Enables & starts the Barber shop
	OBJECT SET FORMAT:C236(*; "progress"; ";;;;128")
	OBJECT SET VALUE:C1742("progress"; 1)
	
	return 
	
End if 

// "min;max;unit;step;flags;format;display"
$c:=Split string:C1554(OBJECT Get format:C894(*; "progress"); ";")

If ($o.type<0)
	
	// Enables & starts the Barber shop
	If ($c[4]#"128")
		
		OBJECT SET VALUE:C1742("progress"; 1)
		$o.autoMessage:=False:C215
		
	End if 
	
	If ($o.type=-2) & ($o.macOS)  // Stepper
		
		OBJECT SET FORMAT:C236(*; "progress"; ";;;;128;;1")
		
	Else 
		
		OBJECT SET FORMAT:C236(*; "progress"; ";;;;128")
		
	End if 
	
Else 
	
	// Disables the Barber shop
	If ($c[4]="128")
		
		OBJECT SET FORMAT:C236(*; "progress"; "0;100;1;1;0")
		$o.autoMessage:=$o.message=""
		
	End if 
	
	// Set the value
	OBJECT SET VALUE:C1742("progress"; Num:C11($o.type))
	
	If ($o.autoMessage)
		
		If ($o.type=0)
			
			$o.message:=$o.calculationMessage
			
		Else 
			
			$o.message:=String:C10($o.type; "##0%")
			
		End if 
	End if 
End if 

If ($o.icon=Null:C1517)
	
	If (OBJECT Get visible:C1075(*; "icon"))
		
		OBJECT SET VISIBLE:C603(*; "icon"; False:C215)
		OBJECT GET COORDINATES:C663(*; "markerNoIcon"; $left; $top; $right; $bottom)
		OBJECT GET COORDINATES:C663(*; "title"; $unused; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; "title"; $left; $top; $right; $bottom)
		
		If ($o.macOS)
			
			OBJECT GET COORDINATES:C663(*; "progress"; $unused; $top; $right; $bottom)
			OBJECT SET COORDINATES:C1248(*; "progress"; $left; $top; $right; $bottom)
			OBJECT GET COORDINATES:C663(*; "message"; $unused; $top; $right; $bottom)
			OBJECT SET COORDINATES:C1248(*; "message"; $left; $top; $right; $bottom)
			
		End if 
	End if 
	
Else 
	
	If (Not:C34(OBJECT Get visible:C1075(*; "icon")))
		
		OBJECT SET VISIBLE:C603(*; "icon"; True:C214)
		OBJECT GET COORDINATES:C663(*; "markerIcon"; $left; $top; $right; $bottom)
		OBJECT GET COORDINATES:C663(*; "title"; $unused; $top; $right; $bottom)
		OBJECT SET COORDINATES:C1248(*; "title"; $left; $top; $right; $bottom)
		
		If ($o.macOS)
			
			OBJECT GET COORDINATES:C663(*; "progress"; $unused; $top; $right; $bottom)
			OBJECT SET COORDINATES:C1248(*; "progress"; $left; $top; $right; $bottom)
			OBJECT GET COORDINATES:C663(*; "message"; $unused; $top; $right; $bottom)
			OBJECT SET COORDINATES:C1248(*; "message"; $left; $top; $right; $bottom)
			
		End if 
		
		OBJECT SET VALUE:C1742("Icon"; $o.icon)
		
	End if 
End if 

If ($o.cancellable)
	
	If (Not:C34(OBJECT Get visible:C1075(*; "stop")))
		
		OBJECT SET VISIBLE:C603(*; "stop"; True:C214)
		OBJECT GET COORDINATES:C663(*; "markerStop"; $left; $top; $right; $bottom)
		
		If ($o.macOS)
			
			OBJECT GET COORDINATES:C663(*; "progress"; $left; $top; $unused; $bottom)
			OBJECT SET COORDINATES:C1248(*; "progress"; $left; $top; $right; $bottom)
			
		Else 
			
			OBJECT GET COORDINATES:C663(*; "message"; $left; $top; $unused; $bottom)
			OBJECT SET COORDINATES:C1248(*; "message"; $left; $top; $right; $bottom)
			
		End if 
	End if 
	
Else 
	
	If (OBJECT Get visible:C1075(*; "stop"))
		
		OBJECT SET VISIBLE:C603(*; "stop"; False:C215)
		OBJECT GET COORDINATES:C663(*; "markerNoStop"; $left; $top; $right; $bottom)
		
		If ($o.macOS)
			
			OBJECT GET COORDINATES:C663(*; "progress"; $left; $top; $unused; $bottom)
			OBJECT SET COORDINATES:C1248(*; "progress"; $left; $top; $right; $bottom)
			
		Else 
			
			OBJECT GET COORDINATES:C663(*; "message"; $left; $top; $unused; $bottom)
			OBJECT SET COORDINATES:C1248(*; "message"; $left; $top; $right; $bottom)
			
		End if 
	End if 
End if 