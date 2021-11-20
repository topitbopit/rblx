


<!---
among us
--->
# Jeff 2 UI Library
*Jeff 2 is a clean, simple UI library made by topit.*  
**DOCS ARE CURRENTLY INCOMPLETE!**
**They are updated frequently, so check back often!**
![](https://cdn.discordapp.com/attachments/886387861388132402/900523062242447440/jeff2_banner.png)  
*Join the [discord server](https://discord.gg/Gn9vWr8DJC)!*  
Contents:

```
Getting started
 - Quirks and cool features
 - Loading the library
 - Windows
 - Menus & Doing stuff
 - Finishing off
UI
 - Window
   - Menu
     - Label
     - Section
     - Textbox
     - Button
     - Toggle
     - Dropdown
     - Slider
     - Trim
 - Messagebox
 - Notification
```


## Getting started
### Quirks and cool features
Jeff 2 is unique and unlike most ui libraries. The biggest difference is that it is *event based*.

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
This doesn't seem like that big of a difference, right? The callback is just a line down!

However, this is more powerful than it seems. It lets you organize your code better, disconnect and change functions easily, and allow better optimization. It's also closer to normal GUI creation workflow.

Heres a list of more cool native features that you probably won't find anywhere else: 
- Jeff 2 has a built-in optimized hotkey system. Toggles (on-off) and Buttons (click to fire) let you bind hotkeys by right clicking them, so you don't have to implement expensive hotkey systems.
- Toggles and buttons can be **hidden** from user interaction. This prevents them from being fired, which is useful in case a module needs to wait for something to load or if an exploit doesn't support a function.
- Sliders are intuitive. Not only can you type in a specific number to jump to it, you can slow drag with right click to slowly change the value.
- Any object can have a description that appears when you mouse over it - called a tooltip - letting you quickly set descriptions without obstructing anything

Of course, this library isn't perfect and there are some issues.
- Only a limited amount of menus can be made
- Library code is pretty large and not very polished
- Buttons, toggles, etc. take up a lot of space

Most of these issues will be worked on and fixed eventually.
 
### Loading the library
Just put this at the top of your script to load the library. It doesn't have to be called `ui`, but it will be here for consistency.
```lua
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
```



### Windows
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
*This will call an anonymous function that prints `Minimized: true` when minimized and `Minimized: false` when not minimized.*

### Menus & Doing stuff

So now we have the first menu. How can you make it actually do stuff?
There's several objects you can create with menus.
The most simplest is a Label - used for displaying text.

```lua
menu:NewLabel("Text")
```
This would create a new text label displaying "Text".

Similar to a label, there's an object called a Section. It is essentially the same thing - even in code they're considered the same. The only difference is the size and position.

![](https://cdn.discordapp.com/attachments/892261816141496351/900504087357964348/unknown.png)


**What about something you can click?**

Here's a button. They have a single event called `OnClick` that gets fired, you guess it, on a click. 
```lua
local button = menu:NewButton("Do something!")

button.OnClick:Connect(function() 
	print("I did something!")
end)
```


*Buttons are nice and all, but what about something that can be turned both on and off?*

Toggles are like buttons, but can be turned both on and off.
```lua
local toggle = menu:NewToggle("Do something, but in a better way!")

-- Toggles can have two ways of being made
-- With two separate events
toggle.OnEnable:Connect(function() 
	print("Enabled")
end)
toggle.OnDisable:Connect(function() 
	print("Disabled")
end)

-- Or one event
toggle.OnToggle:Connect(function(toggle) 
	if toggle then
		print("Enabled")
	else
		print("Disabled")
	end
end)
```

Buttons and toggles both have a lot of neat functions, like hiding, setting binds, and setting tooltips.

Heres an example of what could be done in a shooter game like Arsenal, provided you have the right events and variables ready.
```lua
if map_isnt_loaded then
	wallbang:Hide("Map isn't loaded!")
	wallbang:SetTooltip("Wait for the game to finish loading the map first.")
	map_loaded:Wait()
	wallbang:Unhide()
	wallbang:SetTooltip("When enabled, wallbang lets you shoot through walls.")
end
```


*Now I've made a toggle. How can I change what it does?*

There are a bunch of useful objects for controlling settings. Sliders let you select a number from a specified range, dropdowns let you select an option from a specified group, and textboxes let you input text.




Dropdowns are useful for selecting a certain mode for something to use. An example could be flight - vehicle fly, cframe fly, and normal fly are all valid options.
```lua
local dd = menu:NewDropdown("Pick an option!",{"Option 1","Option 2","Option 3","Option 4"})

dd.OnSelection:Connect(function(value, idx) 
	if value == "Option 1" then
		print("Option 1 is the best")
	else
		print("This option sucks")
	end

	if toggle:GetState() == true then 
		toggle:Disable() 
		toggle:Enable()
	end
end)

```


### Finishing off

The most important part of your GUI is actually displaying it.
To do so with Jeff 2, just put this at the end of your script:
```lua
ui:Ready()
```
Because of the way jeff 2 internally works, objects can be created before ui:Ready() gets called very easily but will have many problems after the call.
**Do not create any objects after calling `:Ready()`**.

However, interactions with the ui or objects you've made are completely fine.
Sending a notification, messagebox, etc. or assigning a callback to an event won't mess anything up.

What about handling the ui close?
Maybe theres some important thing you want to delete or resources you want to clear out.

Using the `ui.Exiting` event, you can do this easily.
```lua
ui.Exiting:Connect(function() 
	for i,v in pairs(ClearLater) do
		v:Destroy()
	end
	ClearLater = nil
	

	for _, t in pairs(ui:GetAllToggles()) do 
		if t:GetState() == true then
			t:Disable()
		end
	end
	--cleanup successful
end)
```

> When exiting, every single object on screen gets closed automatically. However, no objects get disabled. To quickly disable toggles on close, use the `ui:GetAllToggles()` function and call `:Disable()` on each enabled toggle.

> Keep in mind that after the final window closes, all ui resources clear out automatically. If no window is created, the resources won't be cleared. To manually clear resources after you finish, use `ui:Exit()`


<br/>

## UI
#### Creation:
```lua
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
```
*Loads the Jeff 2 library into `ui`*
#### Functions:

```lua
<void> ui:Ready()
```
*Readies library  `ui`, firing the `ui.OnReady` event.*
>`ui:Ready()` is important as it finalizes making the gui. Make sure to leave it at the far bottom of your script and **never** make more objects after calling `Ready()`. Assigning callbacks, displaying notifications and doing other things with the ui all work though.

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
|purple|Combination of Red and Blue
|bright|The closest theme to a light mode
|mono|All gray colors, better version of older bright
|mint|Like blue and bright
|legacy|Similar color scheme to the original jeff ui
|cold|Similar to blue and legacy
|nightshift|All black with some blueish/purple
|jacko|Black and orange
|spring|Slightly lighter version of mint with a different hue

![](https://cdn.discordapp.com/attachments/649469977828786178/900529096067534878/unknown.png)
<br/>
```lua
<table<Toggle>> ui:GetAllToggles()
```
*Returns every toggle in `ui`. Use for disabling modules when exiting.*

**All of the object types below have / will have their own dedicated sections on how to use them.**
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
<notification> ui:NewBindDialog(<string> bd_name, <function> bd_func, <string> bd_id, <string> bd_word, <guiobject> bd_display)
```
*Creates a new binddialog object.*
>BindDialogs are an object used for keybind initialization that should only be used internally. Instead, use button:SetBind() or toggle:SetBind()

#### Events:

```lua
<RBXEvent> ui.OnReady
```
*Event that gets fired when ui:Ready() gets called. Used internally, do not change.*

```lua
<RBXEvent> ui.OnNotifDelete
```
*Event that gets fired when a notification gets deleted. Used internally, do not change.*
```lua
<RBXEvent> ui.Exiting
```
*Event that gets fired when the last window closes.*
```lua
<RBXScriptConnection> ui.BindHandler
```
*Connection used for handling binds. Used internally, do not change*
#### Variables:  

```lua
<string> ui.Version = "2.1.6.0-alpha" 
```
*The current ui version*


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
```lua
<table> ui.Toggles
```
*A table for ui toggles. Used internally, do not change.*
```lua
<number> ui.TooltipX = 15
```
*Value used for resizing tooltips' width.*
```lua
<number> ui.TooltipY = 8
```
*Value used for resizing tooltips' height.*
```lua
<number  ui.ScrollAmount = 200
```
*Value used for scroll speed*
<br/>

## Windows
Windows are pretty self explanatory. Note that although you can create more than one window, it is buggy and will not work well.

#### Creation:
```lua
<window> ui:NewWindow(<string> title, <number> size_x, <number> size_y)
```
*Creates a new window object named `title` with dimensions of (`size_x`, `size_y`)*
```lua
local window = ui:NewWindow("Example window", 400, 300)
```
*Creates a window called **Example window** thats 400 pixels wide and 300 tall*
#### Functions:
```lua
<menu> window:NewMenu(<string> menu_title, <bool> menu_showtitle = true)
```
*Creates a new menuobject named `menu_title`. If `menu_showtitle` is true, the menu header is displayed.*
>Scroll to the menu section to view more documentation on menus.

```lua
<bool> window:GetMinimized()
```
*Returns true if the window is minimized - false if not*
```lua
<table> window:GetMenus()
```
*Returns every menu. May be reworked later*
<br/>
#### Events:
```lua
<RBXEvent> window.OnMinimize
```
*Event that gets fired the current minimize state on change*

#### Variables:

`none`

<br/>

## Menus

Menus are important for actually creating your script. There technically can be any amount of menus, but you should use 1 - 6. They hold the objects that will be used for the gui.
#### Creation:
```lua
<menu> window:NewMenu(<string> menu_title, <bool> menu_showtitle = true)
```
*Creates a new menuobject named `menu_title`. If `menu_showtitle` is true, the menu header is displayed.*
```lua
local menu = window:NewMenu("Epic modules")
```
*Creates a menu displaying the header `Epic Modules`*
#### Functions:
```lua
<table> menu:GetChildren()
```
*Returns a table of all the menus children. Used internally, do not change*
```lua
<number> menu:GetChildrenCount()
```
*Returns how many children the menu has. Used internally, do not change*
**All below functions have specific documentation sections on how to use them. Scroll down until you find what you need!**
```lua
<section> menu:NewSection(<string> section_text)
```
*Creates a new section object saying `section_text`.*
```lua
<label> menu:NewLabel(<string> label_text)
```
*Creates a new label object saying `label_text`.*
>Although labels and sections are technically different, their functions are the exact same.
```lua
<toggle> menu:NewToggle(<string> toggle_text)
```
*Creates a new toggle object displaying `toggle_text`.*
```lua
<button> menu:NewButton(<string> button_text)
```
*Creates a new button object displaying `button_text`.*
```lua
<textbox> menu:NewTextbox(<string> tb_text, <bool> clearonfocus = true)
```
*Creates a new textbox object displaying `tb_text`. When `clearonfocus` is set to true, text will be cleared on focus.*
```lua
<slider> menu:NewSlider(<string> slider_text, <number> slider_min = 0, <number> slider_max = 0, <number> slider_start = slider_min)
```
*Creates a new slider object displaying `slider_text` when unfocused, with a range from `slider_min` to `slider_max`, defaulting to `slider_start`.*
>Sliders are quite advanced and have lots of features. Right clicking will slow-drag, and entering a number into the value box will instantly set the slider to that value!
```lua
<dropdown> menu:NewDropdown(<string> dropdown_text, <table<string>> dropdown_options)
```
*Creates a new dropdown object displaying `dropdown_text`, with `dropdown_options` as options.*
```lua
<grid> menu:NewGrid()
```
*Unused as of now. Will be used as an embedded menu that can be used to fit more objects into a grid*
```lua
<void> menu:NewTrim()
```
*Creates a new trim object, which is the detail line below menu headers.*

#### Events:
```lua
<RBXEvent> menu.OnChildAdded
```
*Event that fires when a new child is added to a menu. Used internally, do not change.*

#### Variables:
`none`
<br/>

## Labels

Labels are useful for adding descriptions, and adding newline breaks (:NewLabel()). Descriptions for specific objects that can be viewed when you mouse over will be added soon.
#### Creation:
```lua
<label> menu:NewLabel(<string> text = "")
```
*Creates a new label reading `text` and returns it*
```lua
local Description = speedhax:NewLabel("Among us")
```
*Creates a new label reading **Among us**, and returns it to Description*
#### Functions:
```lua
<void> label:SetText(<string> newtext)
```
*Sets `label`s text to `newtext`*
```lua
<string> label:GetText()
```
*Returns `label`s text*
#### Events:
`none`
#### Variables:
`none`

<br/>

## Section

Sections are like labels, but with different positioning and sizing. They're the same as menu titles, but without the color gradient.

#### Creation:
```lua
<section> menu:NewSection(<string> text = "")
```
*Creates a new section reading `text` and returns it*
```lua
local Title = epicstuff:NewSection("TPHax")
```
*Creates a new section reading **TPHax**, and returns it to Title*
#### Functions:
```lua
<void> section:SetText(<string> newtext)
```
*Sets `section`s text to `newtext`*
```lua
<string> section:GetText()
```
*Returns `section`s text*
#### Events:
`none`
#### Variables:
`none`

<br/>

## Textbox

Textboxes are useful for user input. They're limited for now but will have more features and possibly a combined version with dropdowns.

#### Creation:
```lua
<textbox> menu:NewTextbox(<string> textbox_display, <boolean> textbox_clear)
```
*Creates a new textbox object displaying `textbox_display`. If `textbox_clear` is true, then the box will clear on focus*

```lua
local plrbox = teleports:NewTextbox("Enter player to teleport to")
```
*Creates a new textbox (`plrbox`) displaying `Enter player to teleport to`*

#### Functions:
```lua
<void> textbox:SetText(<string> text)
```
*Sets `textbox`s text to `text`*
```lua
<void> textbox:ForceFocus()
```
*Forces the client to focus on `textbox`*
```lua
<void> textbox:ForceRelease()
```
*Forces the client to unfocus `textbox`*
```lua
<void> textbox:SetClearOnFocus(<boolean> newstate)
```
*Sets `textbox`s ClearTextOnFocus property to `newstate`

```lua
<bool> textbox:IsFocused()
```
*Returns whether or not `textbox` is focused*
```lua
<string> textbox:GetText()
```
*Returns `textbox`s text*
```lua
<number?> textbox:GetTextFormattedAsInt()
```
*Returns `textbox`s text formatted as a number.*
> If the text cannot be formatted as a number properly, it returns `nil`. It may not return floats properly, so this tip will be updated when floats are confirmed to work.

```lua
<void> textbox:SetTooltip(<string> newtooltip)
```
*Sets this objects tooltip to `newtooltip`
```lua
<string> textbox:GetTooltip()
```
*Returns this object's tooltip*
```lua
<boolean> textbox:IsMouseOver()
```
*Returns if the mouse is currently hovering over this object.*

#### Events:
```lua
<RBXEvent> textbox.OnFocusGained
```
*Event that fires when the textbox gains focus.*
```lua
<RBXEvent> textbox.OnFocusLost
```
*Event that fires when the textbox loses focus.*

#### Variables:
`none`
<br/>

## Button

Buttons are very simple but do have some neat features. Just like toggles, buttons natively support binds when right clicked.
Another cool feature buttons and toggles have is that they can be disabled from user interaction, or **hidden**. This prevents the user from actually clicking this button, which is useful in case a module needs to wait for something to load or if an exploit doesn't support a function.

#### Creation:
```lua
<button> menu:NewButton(<string> text)
```
*Creates a new `button` displaying `text`*
```lua
local invite = menu_amongus:NewButton("Join the discord server")
```
*Creates a button saying `Join the discord server` and assigns it to `invite`*

#### Functions:
```lua
<void> button:Fire()
```
*Triggers the OnClick function*
```lua
<void> button:SetCallback(<function> func)
```
*Sets the callback to `func`. Deprecated, will be removed within the next few updates*
```lua
<void> button:SetBind(<string?> bind_name)
```
*Sets `button`s bind to `bind_name`. If `bind_name` is not passed, the bind is removed.
>`bind_name` must be the name of the keycode you are binding. Instead of Enum.KeyCode.RightControl, pass "RightControl" or Enum.KeyCode.RightControl.Name
```lua
<string> button:GetBind()
```
*Returns the name of the bind `button` is bound to*

```lua
<void> button:SetText(<string> text)
```
*Sets `button`s text to `text`*
```lua
<string> button:GetText()
```
*Returns `button`s text*
```lua
<void> button:Hide(<string> message)
```
*Hides `button`, disabling user interaction. When hidden, `message` will be displayed.*
```lua
<void> button:Unhide()
```
*Unhides `button`, reenabling user interaction.*
```lua
<void> button:Assert(<string> global)
```
*Hides `button` with the message `Your exploit doesn't support global` if `global` is not found in the global env.*
>`:Assert()` was based on the vanilla function `assert`. If you pass a global, such as`getsynasset`, into `:Assert()` and that global is not found in `getgenv`, it will hide the object.

![](https://cdn.discordapp.com/attachments/892261816141496351/903425728803123230/unknown.png
)
<sup>Example message of a module that had :Assert("Drawing") called on it being used on an exploit without Drawing</sup>
```lua
<void> button:SetTooltip(<string> newtooltip)
```
*Sets this objects tooltip to `newtooltip`
```lua
<string> button:GetTooltip()
```
*Returns this object's tooltip*
```lua
<boolean> button:IsMouseOver()
```
*Returns if the mouse is currently hovering over this object.*



#### Events:

```lua
<RBXEvent> button.OnClick
```
*Event that fires when clicked*

#### Variables:
```lua
<boolean> button.Hidden
```
*True when the button is hidden from interaction, false when it's not hidden*

## Toggle

Toggles are like advanced buttons. They can be hidden, have tooltips, and have binds, but can also be enabled, disabled, and toggled. 

#### Creation:
```lua
<toggle> menu:NewToggle(<string> text)
```
*Creates a new `toggle` displaying `text`*
```lua
local spectate = PlayerViewer:NewToggle("view selected player")
```
*Creates a toggle saying `view selected player` and assigns it to `spectate`*

#### Functions:
```lua
<bool> toggle:GetState()
```
*Returns true if `toggle` is enabled, false otherwise*
```lua
<void> toggle:SetState(<bool> newstate, <bool> call_func_after)
```
*Sets the state to `newstate`. If `call_func_after` is true, then the callback will be fired.
```lua
<void> toggle:Toggle()
```
*Toggles the toggle `toggle`, toggling the `OnToggle` `toggle` event*
```lua
<void> toggle:Enable()
```
*Enables `toggle`, firing the `OnEnable` and `OnToggle` events*

```lua
<void> toggle:Disable()
```
*Disables `toggle`, firing the `OnDisable` and `OnToggle` events*


```lua
<void> toggle:SetBind(<string?> bind_name)
```
*Sets `toggle`s bind to `bind_name`. If `bind_name` is not passed, the bind is removed.*
>`bind_name` must be the name of the keycode you are binding. Instead of Enum.KeyCode.RightControl, pass "RightControl" or Enum.KeyCode.RightControl.Name


![](https://cdn.discordapp.com/attachments/892261816141496351/903426532146577468/unknown.png
)
<sup>*Image showcasing a toggle bound to E*</sup>
```lua
<string> toggle:GetBind()
```
*Returns the name of the bind `toggle` is bound to*

```lua
<void> toggle:SetText(<string> text)
```
*Sets `toggle`s text to `text`*
```lua
<string> toggle:GetText()'
```
*Returns `toggle`s text*

```lua
<void> toggle:Hide(<string> message)
```
*Hides `toggle`, disabling user interaction. When hidden, `message` will be displayed.*
```lua
<void> toggle:Unhide()
```
*Unhides `toggle`, reenabling user interaction.*
```lua
<void> toggle:Assert(<string> global)
```
*Hides `toggle` with the message `Your exploit doesn't support global` if `global` is not found in the global env.*
>Think of `:Assert()` like `if not getgenv()["global"] then toggle:Hide("Your exploit does not support global!") end`; it checks if the function / library exists and if it doesn't, it disables the toggle
```lua
<void> toggle:SetTooltip(<string> newtooltip)
```
*Sets this objects tooltip to `newtooltip`*
```lua
<string> toggle:GetTooltip()
```
*Returns this object's tooltip*
```lua
<boolean> toggle:IsMouseOver()
```
*Returns if the mouse is currently hovering over this object.*




#### Events:

```lua
<RBXEvent> toggle.OnEnable
```
*Event that fires when enabled*

```lua
<RBXEvent> toggle.OnDisable
```
*Event that fires when disabled*
```lua
<RBXEvent> toggle.OnToggle
```
*Event that fires when toggled; true when enabled and false when disabled*


#### Variables:
```lua
<boolean> toggle.Hidden
```
*True when the toggle is hidden from interaction, false when it's not hidden*

## Dropdown
Dropdowns are useful for more specific customization, such as what method a flight script would use to fly.
![](https://cdn.discordapp.com/attachments/892261816141496351/903425543104512090/unknown.png)
#### Creation:
```lua
<dropdown> menu:NewDropdown(<string> text, <table<string>> options)
```
*Creates a new dropdown displaying `text` with options `options`*
```lua
local speedmethod = m_speedhacks:NewDropdown("Speed hack method", {"CFrame","Walkspeed","Velocity"})
```
*Creates a new dropdown `speedmethod` saying `Speed hack method` with the options `CFrame`, `Walkspeed`, and `Velocity`.*

#### Functions:
```lua
<void> dropdown:SetText(<string> text)
```
*Sets `dropdown`s text to `text`*

```lua
<string> dropdown:GetText()
```
*Gets `dropdown`s text*
```lua
<string>, <number> dropdown:GetSelectedOption()
```
*Returns the current option's text and index.*

```lua
<string>, <number> dropdown:GetSelection()
```
*Alias for `GetSelectedOption()`*
```lua
<void> dropdown:SetSelectedOption(<variant>)
```
*Selects an option on the dropdown. Using the index is faster and preferable, but using the name works as well.*

```lua
<void> dropdown:Select()
```
*Alias for `SetSelectedOption()`*

```lua
<table> dropdown:GetOptions()
```
*Returns the dropdown options*
```lua
<void> dropdown:SetOptions(<table> options)
```
*Deletes all of the dropdowns current options, and adds `options`. For best performance, don't use often, or use AddOption and RemoveOption.*
```lua
<void> dropdown:AddOption(<string> name)
```
*Adds a new option to `dropdown`*
```lua
<void> dropdown:RemoveOption(<variant> name_idx)
```
*Removes an option from dropdown. Can use index (faster) or string (easier)*
![](https://cdn.discordapp.com/attachments/891090588445851698/911727527691681852/gif.gif)
<sup>*demo of RemoveOption and AddOption*
```lua
<bool> dropdown:IsOpen()
```
*Returns if the dropdown is open or not*


```lua
<void> dropdown:SetTooltip(<string> newtooltip)
```
*Sets this objects tooltip to `newtooltip`*
```lua
<string> dropdown:GetTooltip()
```
*Returns this object's tooltip*
```lua
<boolean> dropdown:IsMouseOver()
```
*Returns if the mouse is currently hovering over this object.*
#### Events:

```lua
<RBXEvent> dropdown.OnOpen
```
*Event that fires when the dropdown opens.*
```lua
<RBXEvent> dropdown.OnClose
```
*Event that fires when the dropdown closes.*
```lua
<RBXEvent> dropdown.OnSelection
```
*Event that fires when a selection is made. Gets passed with the name and index.*
```lua
<RBXEvent> dropdown.OnToggle
```
*Event that fires `true` when the dropdown opens and `false` when closed.*
```lua
<RBXEvent> dropdown.OnOptionRemoved
```
*Event that gets fired when an option gets removed. The option's name, list index, and method used to find that option (string | index) are passed.*
```
```lua
<RBXEvent> dropdown.OnOptionAdded
```
*Event that gets fired when an option gets added. The name and index are passed.*

#### Variables:
`none`

## Slider

Sliders are useful for easily changing a value of something, and have plenty of features like slow dragging and the number box. The only limitation is a slider can only have whole, positive integers from 0 to 999. They may gain support for floats and >999 later.
For more specific numbers, use a textbox and `tonumber` the text, since`:GetTextFormattedAsInt` doesn't support floats yet.

#### Creation:
```lua
<slider> menu:NewSlider(<string> slider_text, <number> slider_min = 0, <number> slider_max = 100, <number> slider_start = slider_min)
```
*Creates a new slider object displaying `slider_text` when unfocused, with a range from `slider_min` to `slider_max`, defaulting to `slider_start`.*

```lua
local how_many_years_will = it_take_for:NewSlider("jeff hoops 3 to release:",5,500,500)
```
*Creates a new slider `how_many_years_will` parented to `it_take_for` saying `jeff hoops 3 to release:` ranging from `5` to `500`*
#### Functions:
```lua
<void> slider:SetValue(<number> newvalue)
```
*Sets `slider`s value to `newvalue`*
```lua
<number> slider:GetValue()
```
*Returns `slider`s value*
```lua
<void> slider:SetMax(<number> newmax)
```
*Sets `slider`s maximum value to `newmax`*
```lua
<number> slider:GetMax()
```
*Returns `slider`s minimum value*
```lua
<void> slider:SetMin(<number> newmin)
```
*Sets `slider`s minimum value to `newmin`*
```lua
<number> slider:GetMin()
```
*Returns `slider`s minimum value*

```lua
<void> slider:SetTooltip(<string> newtooltip)
```
*Sets this objects tooltip to `newtooltip`
```lua
<string> slider:GetTooltip()
```
*Returns this object's tooltip*
```lua
<boolean> slider:IsMouseOver()
```
*Returns if the mouse is currently hovering over this object.*

![](https://cdn.discordapp.com/attachments/892261816141496351/903423745769738240/unknown.png)

#### Events:

```lua
<RBXEvent> slider.OnValueChanged
```
*Event that fires when the value changes. The event gets passed with the slider value and 1 if MouseButton1 was used, 2 if MouseButton2 was used, or 3 if SetValue / number box was used.*
```lua
<RBXEvent> slider.OnFocusLost
```
*Event that fires when the slider loses focus. The event gets passed with `1` if MouseButton1 was used, and `2` if MouseButton2 was used.
```lua
<RBXEvent> slider.OnFocusGained
```
*Event that fires when the slider gains focus. The event gets passed with `1` if MouseButton1 was used, and `2` if MouseButton2 was used.

#### Variables:

## Grid

Grid objects are like menus inside of menus, and are unfinished. Instead of buttons, dropdowns, sliders, etc. being 100% the width of menus, they can be 1/3, 2/3, or 3/3 the width.

I.e., grids help you organize buttons like guis using jeff 1.

#### Creation:
`none`
#### Functions:
`none`
#### Events:
`none`
#### Variables:
`none`

## Trim
Trim objects are useful for organization. Kinda like sections, trims are the detail line underneath menu titles.

![](https://media.discordapp.net/attachments/892261816141496351/903426205376708668/unknown.png
)
<sup>*A trim is used here to separate the main modules from the credits.*</sub>
#### Creation:
```lua
<void> menu:NewTrim()
```
*Creates a new trim object for `menu`.*
```lua
modules:NewTrim()
```
*Creates a new trim object on the `modules` menu.*
#### Functions:
`none`
#### Events:
`none`
#### Variables:
`none`

<br/>
<br/>
<br/>

---
## Message boxes
Message boxes have several functions and params. They're useful for displaying short amounts of text, but will automatically expand to (mostly) fit buttons, the description, and title. 

![](https://media.discordapp.net/attachments/892261816141496351/903427018169937991/unknown.png
)

#### Creation:
```lua
<msgbox> ui:NewMessageBox(<string> msg_text, <string> msg_desc, <table>{<table>{Text: <string>, Callback: <function>}} msg_buttons, <number?> msg_extraX, <number?> msg_extraY)
```
*Creates a new `msgbox` object titled `msg_text`, with the description `msg_desc`, with `msg_buttons` buttons and optionally expanded by (`msg_extraX`, `msg_extraY`)*
```lua
local msg = ui:NewMessageBox("Message box", "Hello world!", {
	{
		Text = "Yes",
		Callback = function(self) --The callback function gets passed with the created msgbox object
			self:Close("Yes")
		end
	}, {
		Text = "No",
		Callback = function(self) --You can do more than just close the box when the button gets pressed
			self:SetTitle("Ok")
			wait(2)
			self:Close("No")
		end
	},
}, 40)
```
*Creates a new message box titled **Message box** with the description **Hello world!** and two buttons, as well as a 40 px extension*
#### Functions:

```lua
<void> msg:Close(<variant> msg_identifier)
```
*Closes the messagebox. If `msg_identifier` is provided, then the `OnClose` event will be passed with it.*
>Use `msg_identifier` for keeping track of different options. For example, if you have a "Yes" button and want to see if the user clicks it, use a custom callback with `self:Close("Yes")` (it doesn't have to be yes - just anything unique works fine) then check what gets passed with the event
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
*Sets the description to  `text`*

```lua
<void> msg:FadeText(<string> newtitle, <string> newdesc)
```
*Fades from the previous title and description to `newtitle` and `newdesc`*
#### Events:

```lua
<RBXEvent> msg.OnClose
```
*Event that fires when the messagebox closes. The first argument is the identifier that gets passed. When the close button is clicked, `OnClose` gets passed with 'Close'.* 

#### Variables:
`none`

<br/>

## Notifications
Notifications are useful for displaying text quickly without obstructing anything.
![](https://media.discordapp.net/attachments/892261816141496351/903426902797213726/unknown.png
)

#### Creation:
```lua
<notification> ui:NewNotification(<string> notif_text, <string> notif_desc, <number> notif_timer)
```
*Creates a new notification titled `notif_text` with thedescription `notif_desc` that lasts `notif_timer` seconds*
```lua
local msg = ui:NewNotification("Notification", "Hello world!", 5)
```
*Creates a new notification titled **Notification** with the description **Hello world!** that lasts 5 seconds*
#### Functions:

```lua
<void> notif:Close()
```

*Closes the notification. Recommended to use only for longer notifications*

```lua
<string> notif:GetDesc()
```
*Returns the notification description*
```lua
<void> notif:SetDesc()
```
*Sets the notification description*

#### Events:
`none`
#### Variables:
`none`

---
These docs are for version 2.1.6.0-alpha. Functions should remain the same for future versions unless noted otherwise. If something does not work, check **Deprecated** and use the new solution.

**DOCS ARE CURRENTLY INCOMPLETE**
If you want to make a suggestion contact topit#4057

<br/>

## Deprecated
If a function or object is going to be deprecated then using it will print a warning in your console.
```lua
<bool> ui.minimized
```
*If the ui is minimized or not. Used internally, do not change.*
**Superseded by window.Minimized, removed on v2.1.0.0-a**

```lua
NewToggle(name, enabled)
                ^^^^^^^
```
*Removed enabled param on NewToggle*
**Superseded by toggle:Enable(), removed on 2.1.3.2a**

```lua
<void> button:SetCallback(<function> func)
```
*Sets the callback of `button` to `func`*
**Removed on 2.1.5.0a, will not be replaced**


<br/>

## Pro gamers
if you're an epic user who uses jeff 2 then let me know and i will add your name here
