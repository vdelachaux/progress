//%attributes = {"invisible":true}
#DECLARE($this; $container; $indx : Integer) : Text

/*
The formula receive:

- $this        Current item
- $container   All values
- $indx        Current index

& returns the text to be displayed as the message

*/

If (False:C215)
	C_VARIANT:C1683(_doSomething; $1)
	C_VARIANT:C1683(_doSomething; $2)
	C_LONGINT:C283(_doSomething; $3)
	C_TEXT:C284(_doSomething; $0)
End if 

// Giving the impression that we're doing something ;-)
DELAY PROCESS:C323(Current process:C322; 5)

Case of 
		
		//______________________________________________________
	: (Value type:C1509($container)=Is collection:K8:32)
		
		If (Value type:C1509($this)=Is text:K8:3)
			
			return $this
			
		Else 
			
			// Use index
			return "Processing item #"+String:C10($indx)
			
		End if 
		
		//______________________________________________________
	: (Value type:C1509($container)=Is object:K8:27)
		
		return "Processing key: "+String:C10($this)
		
		//______________________________________________________
	Else 
		
		return "Processing: "+String:C10($indx)
		
		//______________________________________________________
End case 