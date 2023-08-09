property properties : Object
property id; start; delay : Integer
property ready; isClosed; isStopped; success : Boolean
property manager : 4D:C1709.Function

Class constructor($data)
	
	This:C1470.ready:=False:C215
	
	This:C1470[""]:={\
		stopTitle: "Stop"; \
		worker: "Progress UI"; \
		manager: Formula:C1597(progressManager); \
		calculationMessage: "Calculation…"; \
		cancellationMessage: "Cancellation…"\
		}
	
	// Set default properties
	This:C1470.Reset()
	
	This:C1470.id:=0
	
	This:C1470.start:=Tickcount:C458
	This:C1470.delay:=0
	
	This:C1470.isClosed:=False:C215
	This:C1470.isStopped:=False:C215
	
	This:C1470.success:=False:C215
	
	If (Value type:C1509($data)=Is object:K8:27)
		
		This:C1470.properties:=$data
		
	Else 
		
		This:C1470[""].title:=String:C10($data)
		
	End if 
	
	This:C1470._init()
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set title($title : Text)
	
	This:C1470[""].title:=$title
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get title() : Text
	
	return This:C1470[""]#Null:C1517 ? String:C10(This:C1470[""].title) : ""
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set message($message : Text)
	
	This:C1470[""].message:=$message
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get message() : Text
	
	return This:C1470[""]#Null:C1517 ? String:C10(This:C1470[""].message) : ""
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set icon($icon)
	
	This:C1470._setIcon($icon)
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get icon() : Picture
	
	If (This:C1470[""]#Null:C1517)
		
		return This:C1470[""].icon
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set cancellable($on : Boolean)
	
	If (Not:C34($on))
		
		This:C1470[""].stopFormula:=Null:C1517
		
	End if 
	
	This:C1470[""].cancellable:=$on
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get cancellable() : Boolean
	
	return This:C1470[""]#Null:C1517 ? Bool:C1537(This:C1470[""].cancellable) : False:C215
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set type($type : Variant)
	
	This:C1470._setProgress($type)
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get type() : Text
	
	If (This:C1470[""]#Null:C1517)
		
		return This:C1470[""].type=-2 ? "stepper" : This:C1470[""].type=-1 ? "barber" : "indexed"
		
	Else 
		
		return "barber"
		
	End if 
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set value($value : Integer)
	
	This:C1470._setProgress($value)
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get value() : Integer
	
	return (This:C1470[""]#Null:C1517) && (This:C1470[""].type>0) ? This:C1470[""].type : 0
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set stopFormula($formula : 4D:C1709.Function)
	
	If ($formula#Null:C1517)
		
		This:C1470[""].cancellable:=True:C214
		
	End if 
	
	This:C1470[""].stopFormula:=$formula
	
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get stopFormula() : 4D:C1709.Function
	
	return This:C1470[""]#Null:C1517 ? This:C1470[""].stopFormula : Null:C1517
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set stopTitle($title : Text)
	
	This:C1470[""].stopTitle:=$title
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get stopTitle() : Text
	
	return This:C1470[""]#Null:C1517 ? String:C10(This:C1470[""].stopTitle) : ""
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set properties($data : Object)
	
	var $key : Text
	var $properties : Object
	
	$properties:=This:C1470[""]
	
	For each ($key; $data)
		
		Case of 
				
				//______________________________________________________
			: ($key="delay")
				
				This:C1470[$key]:=$data[$key]
				
				//______________________________________________________
			: ($key="type")
				
				This:C1470._setProgress($data[$key])
				
				//______________________________________________________
			: ($key="cancellable")
				
				If ($data[$key]=False:C215)
					
					$properties.stopFormula:=Null:C1517
					
				End if 
				
				$properties[$key]:=$data[$key]
				
				//______________________________________________________
			: ($key="stopFormula")
				
				If ($data[$key]#Null:C1517)
					
					$properties.cancellable:=True:C214
					
				End if 
				
				$properties[$key]:=$data[$key]
				
				//______________________________________________________
			: ($key="icon")
				
				This:C1470._setIcon($data[$key])
				
				//______________________________________________________
			Else 
				
				$properties[$key]:=$data[$key]
				
				//______________________________________________________
		End case 
	End for each 
	
	If ($properties.type>=0)
		
		$properties.autoMessage:=$properties.message=""
		
	End if 
	
	This:C1470._update()
	
	// ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==> ==>
Function get properties() : Object
	
	return This:C1470[""]
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set calculationMessage($message : Text)
	
	This:C1470[""].calculationMessage:=$message
	
	// <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <== <==
Function set cancellationMessage($message : Text)
	
	This:C1470[""].cancellationMessage:=$message
	
	//Mark:-
	// === === === === === === === === === === === === === === === === === === ===
Function Reset() : cs:C1710.progress
	
	var $properties : Object
	var $icon : Picture
	
	$properties:=This:C1470[""]
	$properties.type:=-1
	$properties.title:=""
	$properties.message:=""
	$properties.autoMessage:=False:C215
	$properties.cancellable:=False:C215
	$properties.icon:=$icon
	$properties.stopFormula:=Null:C1517
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === ===
Function BringToFront() : cs:C1710.progress
	
	var $bottom; $left; $process; $right; $top : Integer
	
	$process:=Process number:C372(This:C1470[""].worker)
	
	SHOW PROCESS:C325($process)
	BRING TO FRONT:C326($process)
	
	GET WINDOW RECT:C443($left; $top; $right; $bottom; This:C1470.window)
	SET WINDOW RECT:C444($left; $top; $right; $bottom; This:C1470.window)
	
	return This:C1470
	
	// === === === === === === === === === === === === === === === === === === ===
Function Close($delay : Integer)
	
	var $signal : 4D:C1709.Signal
	
	If (This:C1470.ready)
		
		If ($delay>0)
			
			DELAY PROCESS:C323(Current process:C322; $delay)
			
		End if 
		
		$signal:=This:C1470._signal("close")
		This:C1470._callWorker($signal; True:C214)
		This:C1470.isClosed:=This:C1470.success
		
	End if 
	
	// === === === === === === === === === === === === === === === === === === ===
Function Quit()
	
	This:C1470.Close()
	
	If (This:C1470.success)
		
		KILL WORKER:C1390(This:C1470[""].worker)
		
	End if 
	
	//Mark:-
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _callWorker($signal : 4D:C1709.Signal; $wait : Boolean)
	
	This:C1470.timeSpent:=Tickcount:C458-This:C1470.start
	
	CALL WORKER:C1389(This:C1470[""].worker; This:C1470[""].manager; $signal; This:C1470)
	
	If (Count parameters:C259>=2 ? $wait : True:C214)
		
		$signal.wait(10)
		
		This:C1470.success:=$signal.signaled
		
		This:C1470.isStopped:=Bool:C1537($signal.instance.isStopped)
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _signal($action : Text) : 4D:C1709.Signal
	
	var $signal : 4D:C1709.Signal
	$signal:=New signal:C1641
	
	Use ($signal)
		
		$signal.action:=$action
		
	End use 
	
	return $signal
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _init()
	
	var $signal : 4D:C1709.Signal
	
	$signal:=This:C1470._signal("new")
	This:C1470._callWorker($signal; True:C214)
	
	If (This:C1470.success)
		
		This:C1470.id:=$signal.instance.id
		This:C1470.window:=$signal.instance.window
		This:C1470.ready:=True:C214
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _setProgress($type : Variant)
	
	var $properties : Object
	$properties:=This:C1470[""]
	
	If ($type=Null:C1517)
		
		$properties.type:=-1
		return 
		
	End if 
	
	If (Value type:C1509($type)=Is text:K8:3)
		
		Case of 
				
				//______________________________________________________
			: ($type="indexed")\
				 | ($type="ruler")
				
				$properties.type:=0
				
				//______________________________________________________
			: ($type="barber")\
				 | ($type="undefined")
				
				$properties.type:=-1
				
				//______________________________________________________
			: ($type="stepper")\
				 | ($type="asynchronous")
				
				$properties.type:=-2
				
				//______________________________________________________
			Else 
				
				$properties.type:=Num:C11($type)
				
				//______________________________________________________
		End case 
		
		return 
		
	End if 
	
	$properties.type:=Num:C11($type)
	
	If ($properties.type>=0)
		
		$properties.autoMessage:=$properties.message=""
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _setIcon($icon)
	
	var $properties : Object
	var $file : 4D:C1709.File
	
	$properties:=This:C1470[""]
	
	If ($icon=Null:C1517)
		
		$properties.icon:=Null:C1517
		return 
		
	End if 
	
	If (Value type:C1509($icon)=Is text:K8:3)
		
		$file:=File:C1566("/RESOURCES/"+$icon+".svg")
		
		If ($file.exists)
			
			READ PICTURE FILE:C678($file.platformPath; $icon)
			$properties.icon:=$icon
			
		Else 
			
			$properties.icon:=Null:C1517
			
		End if 
		
		return 
		
	End if 
	
	If (Value type:C1509($icon)=Is picture:K8:10)
		
		$properties.icon:=$icon
		return 
		
	End if 
	
	//*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***
Function _update()
	
	If (This:C1470.ready)
		
		This:C1470._callWorker(This:C1470._signal("update"))
		
	End if 
	
	//Mark:-
	// === === === === === === === === === === === === === === === === === === ===
Function forEach($target; $formula : 4D:C1709.Function; $keepOpen : Boolean) : cs:C1710.progress
	
	var $t : Text
	var $i; $length : Integer
	var $v
	
	Case of 
			
			//______________________________________________________
		: (Value type:C1509($target)=Is collection:K8:32)
			
			This:C1470.type:=0
			$length:=$target.length
			
			//______________________________________________________
		: (Value type:C1509($target)=Is object:K8:27)
			
			This:C1470.type:=0
			$length:=OB Entries:C1720($target).length
			
			//______________________________________________________
		Else 
			
			This:C1470.type:=-1
			
			//______________________________________________________
	End case 
	
	This:C1470.stopped:=False:C215
	
	For each ($v; $target)
		
		This:C1470._update()
		
		If (This:C1470.isStopped)
			
			// The user clicks on Stop
			This:C1470.cancellable:=False:C215
			break
			
		Else 
			
			$i+=1
			$t:=String:C10($formula.call(Null:C1517; $v; $target; $i))
			
			If ($length#0)
				
				This:C1470.value:=$i*100/$length
				
			End if 
			
			If (Length:C16($t)>0)
				
				This:C1470.message:=$t
				
			End if 
		End if 
	End for each 
	
	If (Count parameters:C259>=2 ? $keepOpen : False:C215)
		
		This:C1470.Reset()
		
	Else 
		
		This:C1470.Close()
		
	End if 