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
>`ui:Ready()` is important as it finalizes making the gui. Make sure to leave it at the far bottom of your script and **never** make more objects after calling `Ready()`. You can assign callbacks to events after you call it though.

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

```lua
<window> ui:NewWindow(<string> title, <number> size_x, <number> size_y)
```
*Creates a new window object.*
>Scroll to the window section to view more documentation on windows.

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
Windows are the main part of the library as of now, and are far from finished.

Creation:
```lua
<window> ui:NewWindow(<string> title, <number> size_x, <number> size_y)
```
*Creates a new window object named `title` with dimensions of (`size_x`, `size_y`)*
```lua
local window = ui:NewWindow("Example window", 400, 300)
```
*Creates a window called **Example window** thats 400 pixels wide and 300 tall*
<br/>
Functions:
```lua
<menu> window:NewMenu(<string> title, <bool> showtitle)
```

*Creates a new menu object*
>Scroll to the menu section to view more documentation on menus.

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
## Menus

---
## Message boxes
Message boxes have several functions and params. They're useful for displaying short amounts of text, but will automatically expand to fit buttons, the description, and title. 
>Don't use messageboxes for notifications, since notifications will be added within the next few updates.


Creation:
```lua
<msgbox> ui:NewMessageBox(<string> msg_text, <string> msg_desc, <table>{<table>{Text: <string>, Callback: <function>}} msg_buttons)
```
```lua
local msg = ui:NewMessageBox("Message box", "Hello world!", {
	{
		Text = "Yes",
		Callback = function(self) --The callback function gets passed with the created msgbox object
			self:Close()
		end
	}, {
		Text = "No",
		Callback = function(self) --You can do more than just close the box when the button gets pressed
			self:SetTitle("Ok")
			wait(2)
			self:Close()
		end
	},
})
```
*Creates a new message box titled **Message box** with the description **Hello world!** and two buttons*
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
<void> msg:SetDesc(<string> text)
```
*Sets the title to  `text`*
<br/>
Events:
`none`

---
These docs are for version 2.0.0-alpha.
