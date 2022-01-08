# Jeff's Hat lib
made by topit
does the funny thing with hats

## How do I use it

### Module settings
```lua
<boolean> module.BlockifyHats = true
``` 
*Turns hats into blocks. Set `DisableFlicker` to false since `DisableFlicker` assumes you have blockify enabled*

```lua
<number> module.NetIntensity = 80
``` 
*The higher the less likely for blocks to break, but the more the flicker effect appears*
```lua
<boolean> module.DisableFlicker = false
``` 
*Because of the way the net works, there is a noticeable flicker effect, even more so on lower FPS. Setting `DisableFlicker` to true disables the flicker effect clientside by hiding the actual hat handles and showing the fake "root" parts.*

### Module functions
```lua
<HatObject> module:NewHat()
```
*Creates and returns a hat object*
```lua
<void> module:ClearHats()
```
*Removes all hats. Useful for when your character respawns.*
```lua
<void> module:Exit()
```
*Removes all hats, remove variables, stops main net loop, etc.*

### Hat object
Hatobjects have one property, their CFrame
```lua
<CFrame> HatObject.CFrame
```
*Sets the hat CFrame to a desired value when newindexed*

### Huh
Basically: 
- create a hat with NewHat()
- set hat.CFrame to a cframe
- call Exit() when done with the hats

## Give me an example
```lua
-- Load in the hat library
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()
-- Exit the library and clear all the resources after 15 seconds
delay(15, function() 
    library:Exit()
end)

-- Disable these if you're R15
library.DisableFlicker = true
library.BlockifyHats = true

-- Make a hat
local hat = library:NewHat()
-- Move it to 15, 15, 15
hat.CFrame = CFrame.new(15, 15, 15)
```

## How does it work
dm topit#4057 cause i dont want to explain it rn loolol