//%attributes = {"invisible":true}
#DECLARE() : Boolean

If (False:C215)
	C_BOOLEAN:C305(_confirm; $0)
End if 

CONFIRM:C162("Are you sure?")

return Bool:C1537(OK)