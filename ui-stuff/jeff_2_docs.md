# Loading the library

Just put this at the top of your script to load the library. It doesn't have to be called `ui`, but it will be in these docs.
```lua
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
```
<br/>
Functions:

```lua
<void> ui:Ready()
```
*Readies library  `ui`, firing the `ui.OnReady` event.*
*`ui:Ready()` is important as it finalizes making the gui. Make sure to leave it at the far bottom of your script and **never** make more objects after calling `Ready()`. You can assign callbacks to events after you call it though.*

```lua
<void> ui:SetColors(<variant> theme)
```
*Sets the ui color scheme to `theme`. Call before creation of any objects.*
*Available pre-made color schemes:*
|name|description|
|-|-|
|red|Near black colors with a red accent
|green|Dark gray colors with bright green accent
|blue|Similar to default, but higher contrast
|purple|Purple and blue combined
|bright|The closest theme to a light mode
|mono|All gray colors, like bright but better
|neon|Experimental bad looking theme


<br/>
Variables:  

```lua
<string> ui.Version = "2.0.0-alpha" 
```
*The current ui version*
```lua
<bool> ui.minimized
```
*If the ui is minimized or not. Used internally, do not change.*
```lua
<table> ui.cons
```
*Table for ui connections. Used internally, do not change.*
```lua
<table> ui.colors
```
*Table for ui colors. Used internally, do not change*


---
## Windows
Windows are basically the main part of the library as of now, and are far from finished.

Creation:
```lua
local msg = ui:NewMessageBox(msg_text, msg_desc, msg_buttons)
```
```lua
local msg = ui:NewMessageBox("Message box", "Hello world!", {
	{
		Text = "Ok",
		Callback = function(self) --The callback function gets passed with the created messagebox object
			self:Close()
		end
	}
})
```
<br/>
Functions:

```lua
<void> msg:Close()
```

*Closes the messagebox*

```lua
<string> msg:GetTitle()
```
*Returns the title*
```lua
<string> msg:GetDesc()
```
*Returns the description*
```lua
<void> msg:SetTitle(<string> text)
```
*Sets the title to  `text`*
```lua
<void> msg:SetDesc(<string> desc)
```
*Sets the title to  `text`*
<br/>
Events:
`none`

---
## Message boxes
Message boxes have several functions and params. They're useful for displaying short amounts of text, but will automatically expand to fit buttons, the description, and title.

Creation:
```lua
local msg = ui:NewMessageBox(msg_text, msg_desc, msg_buttons)
```
```lua
local msg = ui:NewMessageBox("Message box", "Hello world!", {
	{
		Text = "Ok",
		Callback = function(self) --The callback function gets passed with the created messagebox object
			self:Close()
		end
	}
})
```
<br/>
Functions:

```lua
<void> msg:Close()
```

*Closes the messagebox*

```lua
<string> msg:GetTitle()
```
*Returns the title*
```lua
<string> msg:GetDesc()
```
*Returns the description*
```lua
<void> msg:SetTitle(<string> text)
```
*Sets the title to  `text`*
```lua
<void> msg:SetDesc(<string> desc)
```
*Sets the title to  `text`*
<br/>
Events:
`none`

---
