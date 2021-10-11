## Loading the library

Just put this at the top of your script to load the library. It doesn't have to be called `ui`, but it will be in these docs.
```lua
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
```

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
<string> msg:GetDesc() --returns the current description
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
<string> msg:GetDesc() --returns the current description
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
