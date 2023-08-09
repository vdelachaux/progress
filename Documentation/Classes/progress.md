#progress

The `progress` class is designed to manage a progress dialog that adapts to the platform where it is executed.

### Sample code

```4d
var $progress : cs.progress
$progress:=cs.progress.new()$progress.title:="Copy files"$progress.icon:="check"$progress.message:="We're doing something..."// Do something$progress.Close()
```

## Summary

### Properties:

|Properties|Type|Description|Initial value|
|---------|:----:|------|:------:|
|**title**|`Text`|The title| empty|
|**message**|`Text`|The displayed message| empty |
|**[type](#type)**|`Text` \| `Integer`|The thermometer type| "barber"|
|**[icon](#icon)**|`Text` \| `Picture`|The icon to display| empty |
|**delay**|`Integer`|The delay, in seconds, during which progress will not be displayed| 0 |
|**[cancellable](#cancellable)**|`Boolean`|Whether or not to display a Stop button| **False**|
|**isStopped**|`Boolean`|Did the user stop the process or not?| **False**|
|**value**|`Text` \| `Integer`|The current value of the progress bar| 0 |
|**[stopFormula](#stopFormula)**|`4D.Function`|The formula to call up if the user clicks on the Stop button| **Null**|
|**autoMessage**|`Boolean`|Enable or disable automatic status messages| **False**|
|**calculationMessage**|`Text`|Message displayed as long as thermometer value is 0| empty|
|**cancellationMessage**|`Text`|Message displayed when user stops process| empty|
|**properties**|`Object`|All-in-one properties| - |

### Functions:

|Function|Action|
|--------|------|  
|**Reset**()|Resets all properties to default values| 
|**BringToFront**()|Puts progress dialog in the foreground| 
|**Close**()|Closes the progress window| 
|**Quit**()|Closes the progress window & kills the worker| 
|||
|**[forEach](#forEach)**( target; formula; keepOpen )|Calls the formula for each attribute/member of the target and automatically manage the display| 

## Details

### 🔸 Constructor

----
The constructor of the `cs.progress.new()` class can be called without parameters to create a progress dialog box with default properties, i.e. an undefined, non-cancellable progress bar with no title, icon or message.

The class constructor also accepts an optional parameter, which can be the text to be used as a title or an object describing the properties to be initialized in a single operation.

#### Text
```4d
var $progress : cs.progress
$progress:=cs.progress.new("My title")
```

#### Object
```4dvar $o : Object
$o:={\
  title: "Copy files"; \  icon: "check"; \  message: "We're doing some preliminary work..."\}
var $progress : cs.progress$progress:=cs.progress.new($o)
```

### 🔹 <a name="type">type</a>

----
The `type` property accepts a `Text` or `Integer` value.

* `Text` values are a user-friendly way of defining the type. Supported values are: 

    > * "barber" or "undefined" to display a "barber-shop".
    > * "indexed" or "ruler" to display a bar from 0 to 100.

* `Integer` values allow between 0 & 100 to set the ruler progression

    > you can also pass -1 to set a "barber-shop" or -2 to set a "stepper"
    

📌 If the display is a bar from 0 to 100, the `autoMessage` property is set to **True** if the `message` property is empty, to **False** otherwise.

### 🔹 <a name="icon">icon</a>

----
The `icon` property accepts a `Text` or `Picture` value.

* The values of type `Text` are the names of the embedded icons. The following values are supported:

| |        | |        
|----|:----:|----|:----:|
|"add"|<img src="../../Resources/add.svg"/>|"folder"|<img src="../../Resources/folder.svg"/>|
|"archive"|<img src="../../Resources/archive.svg"/>|"infos"|<img src="../../Resources/infos.svg"/>|
|"calculator"|<img src="../../Resources/calculator.svg"/>|"more"|<img src="../../Resources/more.svg"/>|
|"check"|<img src="../../Resources/check.svg"/>|"receive"|<img src="../../Resources/receive.svg"/>|
|"clock"|<img src="../../Resources/clock.svg"/>|"save"|<img src="../../Resources/save.svg"/>|
|"compare"|<img src="../../Resources/compare.svg"/>|"send"|<img src="../../Resources/send.svg"/>|
|"delete"|<img src="../../Resources/delete.svg"/>|"stat"|<img src="../../Resources/stat.svg"/>|
|"download"|<img src="../../Resources/download.svg"/>|"update"|<img src="../../Resources/update.svg"/>|
|"exchange"|<img src="../../Resources/exchange.svg"/>|"upload"|<img src="../../Resources/upload.svg"/>|
|"file"|<img src="../../Resources/file.svg"/>|"wait"|<img src="../../Resources/wait.svg"/>|
|"filter"|<img src="../../Resources/filter.svg"/>|


* Values of type `Picture` will be used as they are.

> 📌 Pass a **Null** value to remove the icon.

### 🔹 <a name="cancellable">cancellable</a>

----
If this property is set to **False**, the `stopFormula` property is automatically reset to **Null**

### 🔹 <a name="stopFormula">stopFormula </a>

----
The `stopFormula` property must be a **4D**.Function which returns **True** if, for example, the user confirms the action, **False** otherwise. The result will be set as value of the property `isStopped`.

#### Sample:

```4d
#DECLARE() : BooleanCONFIRM("Are you sure?")return Bool(OK)
```

> 📌 If the property `cancellable` is **True** & the property `stopFormula` is **Null**, the property `isStopped` is immediatly set to **True**.

#### Code sample:

```4d
$progress:=cs.progress.new()$progress.properties:={\    message: ""; \    stopFormula: Formula(_confirm); \    icon: "file"; \    type: "indexed"; \    calculationMessage: "Calculation in progress..."; \    cancellationMessage: "We're cancelling..."\   }

For ($i; 1; 100; 1)		// Do something		If ($progress.isStopped)				break			End if End for If ($progress.isStopped)		// Do the cancellation work…
		// Close after 2 sec.	$progress.Close(120)	return 	End if 
```

### 🔸 <a name="forEach">forEach</a> 

----

**forEach**( `Object`; `4D.Function` {; `Boolean`} ) : **cs**.progress    
**forEach**( `Collection`; `4D.Function` {; `Boolean`} ) : **cs**.progress 

|Parameter|Type||Description|
|----|----|:----:|----|
|target|`Object` or `Collection`|→|Target to iterate on|
|formula|`4D.Function`|→|Function to be called on all target attributes/members|
|keep|`Boolean`|→|If False (default), automatically closes the dialog box at the end of the loop|
|keep|`Boolean`|→|If False (default), automatically closes the dialog box at the end of the loop|

The **forEach**() function calls the formula for each attribute/member of the `target` and updates the dialog.

> 📌 If the `keep` parameter is **True**, the resetted progress window will remain on screen and can be reused for other operations.

The called formula receive 3 parameters and must return the message to be displayed

|Parameter|Type||Description|
|----|----|:----:|----|
|this|`Variant`|→|The current item (property or member) of the target|
|target|`Object` or `Collection`|→|Function to be called on all target attributes/members|
|counter|`Integer`|→|The counter of the loop|
|message|`Text`|⟵|The message to be displayed|

#### Code sample:

```4d
var $progress : cs.progress
$progress:=cs.progress.new("We're working…")
$progress.forEach($myCollection; Formula(doSomething))
```

with ***doSomething*** method:

```4d
#DECLARE($this; $container; $indx : Integer) : Text

…

return "Processing: "+String($indx)
```
