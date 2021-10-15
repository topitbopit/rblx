# Jeff 2 UI Library
*Jeff 2 is a clean, simple UI library made by topit.*  

## Getting started
Just put this at the top of your script to load the library. It doesn't have to be called `ui`, but it will be here for consistency.
```lua
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
```
Note that unlike most UI libraries, Jeff 2 is *event based.*
Instead of making a toggle like this...
```lua
ui:NewToggle("Hello world", function(state) print(state) end)
```
you would make it like this...
```lua
local toggle = ui:NewToggle("Hello world")
toggle.OnToggle:Connect(function(state) 
    print(state)
end)
```
This lets you organize your code better, disconnect functions easily, yield until a button gets pressed, and more.

Another thing is native keybind support. A lot of UIs do let you use keybinds, but usually it's a separate button / box you click and enter.
When you right click a button, toggle, or tabbutton a prompt allows you to bind that button to any key. That way you don't have to worry about implementing keybinds; it's all done for you.

## UI
### Functions:

```lua
<void> ui:Ready()
```
*Readies library  `ui`, firing the `ui.OnReady` event.*
>`ui:Ready()` is important as it finalizes making the gui. Make sure to leave it at the far bottom of your script and **never** make more objects after calling `Ready()`. Assigning callbacks, displaying notifications and displaying messageboxes all work though.

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

```lua
<msgbox> ui:NewMessagebox(<string> msg_text, <string> msg_desc, <table> msg_buttons)
```
*Creates a new messagebox object.*

```lua
<notification> ui:NewNotification(<string> notif_text, <string> notif_desc, <number> notif_timer)
```
*Creates a new notification object.*

```lua
<notification> ui:NewBindDialog(<string> bd_name, <function> bd_func, <string> bd_id, <stirng> bd_word, <guiobject> bd_display)
```
*Creates a new binddialog object.*
>BindDialogs are an object used for keybind initialization that should only be used internally. Instead, use button:SetBind() or toggle:SetBind()


#### Variables:  

```lua
<string> ui.Version = "2.1.0-alpha" 
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
```lua
<table> ui.binds
```
*Table for ui binds. Used internally, do not change*

```lua
<RBXScriptConnection> ui.BindHandler
```
*Connection used for handling binds. Used internally, do not change*

```lua
<number> ui.NotifCount
```
*Value to keep track of currently displayed notifications. Used internally, do not change.*
```lua
<Enum.Font> ui.Font = Enum.Font.SourceSans
```
*Globally used font. Edit this before calling any functions.*
```lua
<number> ui.FontSize = 20
```
*Base UI font size. Edit this before calling any functions.*
```lua
<number> ui.WindowCount
```
*How many windows there are. Used internally, do not change.*
```lua
<table> ui.Windows
```
*A table for ui windows. Used internally, do not change.*
#### Events:

```lua
<RBXEvent> ui.OnReady
```
*Event that gets fired when ui:Ready() gets called. Used internally, do not change.*

```lua
<RBXEvent> ui.OnNotifDelete
```
*Event that gets fired when a notification gets deleted. Used internally, do not change.*

---
## Windows
Windows are the main part of the library as of now.

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
These docs are for version 2.1.0-alpha. (UNFINISHED)
