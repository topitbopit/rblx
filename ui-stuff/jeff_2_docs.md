# Jeff 2 UI Library
*Jeff 2 is a clean, simple UI library made by topit.*  

## Getting started
### Running the library
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



In order to create the first window, begin with the `ui:NewWindow()` function.
```lua
local window = ui:NewWindow("EpicHax", 400, 300)
```
This would create a new window titled EpicHax with a size of 400 x 300, and assign it to `window`.

Now that the window is made, much more can be done.

The most important thing is creating a new menu. This lets you create buttons, sliders, and more
```lua
local menu = window:NewMenu("SpeedHax")
```
This will create a new menu called SpeedHax.

Although you can do more with windows such as being able to tell when they're minimized, that's pretty much it.
```lua
window.OnMinimize:Connect(function(min) print("Minimized:", min) end)
```
This will call an anonymous function that prints *Minimized: true* when minimized and *Minimized: false* when not minimized.

### Menus & Doing stuff

So now we have the first menu. How can you make it actually do stuff?
There's several objects you can create with menus.
The most simplest is a Label - used for displaying text.

```lua
menu:NewLabel("Text")
```
This would create a new text label displaying "Text".

Similar to a label, theres an object called a Section. It is essentially the same thing - even in code they're considered the same. The only difference is that sections aren't padded on the left.

In other words, use them for creating or splitting off sections.


What about something more complicated?

When clicked, a button fires an event. That's it.

```lua
local button = menu:NewButton("Do something!")

button.OnClick:Connect(function() 
	print("I did something!")
end)
```
Since everything in Jeff 2 is event based, creating objects like buttons and toggles are super easy.


**More explanations on how to create other objects will be added soon.**

### Finishing off

The most important part of your GUI is actually displaying it.
To do so with Jeff 2, just put this at the end of your script:
```lua
ui:Ready()
```
Because of the way jeff 2 internally works, objects can be created before ui:Ready() gets called very easily but will have problems after the call.
**Do not create any objects after calling :Ready()**.

However, interactions with the ui or objects you've made are completely fine.
Sending a notification, messagebox, etc. or assigning a callback to an event won't mess anything up.

What about handling the ui close?
Maybe theres some important thing you want to delete or resources you want to clear out.

Using the `ui.Exiting` event, you can do this just fine.
```lua
ui.Exiting:Connect(function() 
	for i,v in pairs(VeryImportantTableClearOutLaterThough) do
		v:Destroy()
	end
	VeryImportantTableClearOutLaterThough = nil
	--cleanup successful
end)
```

## UI
#### Functions:

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
These docs are for version 2.1.3-alpha. Versions below should work fine, and functions should remain the same for future versions unless noted otherwise.

**DOCS ARE CURRENTLY INCOMPLETE**
Check out the example file to get an idea on how the library works
If you want to make a suggestion contact topit#4057
