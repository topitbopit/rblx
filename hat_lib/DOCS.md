# Jeff's Hat lib
made by topit  
does the funny thing with hats

## How do I use it

### Module settings
```lua
<boolean> module.BlockifyHats = true
``` 
*Turns hats into blocks. Requires R6. If you have blockify enabled, set `DisableFlicker`to false*

```lua
<number> module.NetIntensity = 80
``` 
*The higher the intensity the more the hats flicker / shake. However, the hats remain stable when others touch them*
```lua
<boolean> module.DisableFlicker = false
``` 
*Because of the way the net works, there is a noticeable flicker effect, even more so on lower FPS. Setting `DisableFlicker` to true disables the flicker effect clientside by hiding the actual hat handles and showing the fake "root" parts.*
```lua
<boolean> module.ShowRoots = false
```
*Primarily used for debugging. Shows the hat roots as a small blue transclucent cube*




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
```lua
<number> module:GetHatCount()
```
*Returns the current amount of hats. Useful for debugging*
```lua
<table> module:GetHatTable() 
```
*Returns the hat table, which is an array of HatObjects*

### Hat object
Hatobjects have a few properties, but CFrame is the most used one
```lua
<CFrame> HatObject.CFrame
```
*Sets the hat CFrame to a desired value when newindexed*
```lua
<string> HatObject.HatId
```
*The ID portion of the MeshId. For example, "rbxassetid://4489232754" would result in "4489232754"*
```lua
<Vector3> HatObject.HatSize
```
*The size of the handle as a Vector3. For an international fedora, this would be (1,1,1)*

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
dm topit#4057 cause i dont want to explain it here loolol

## Q/A

**What happens if i try to make a hat when there aren't any left on my character?**  
The NewHat call will return nil  
Probably gonna add a :HatExists() function or something later  
**What happens if i reset?**  
If DisableFlicker is enabled, then a fake hat will be there  
If DisableFlicker is disabled, then the hat will despawn normally  
Calling ClearHats when you respawn / die probably improves performance so do that  
**What happens if i unload the library while its running?**  
The existing hats just drop  
**What happens if i never unload the library?**  
It will still try to calculate stuff for the hats and probably slow your game down  
**Will this lag my pc?**  
Idk :skull:  
**How does the net work?**  
It does some ooga booga stuff and updates some hat stuff every other frame  
Idk why it works but it does  
**Why do I need an fps unlocker?**
Because the net updates the position every 2 frames, the net will appear choppy / laggy for other players. However, setting the cap to 144 (or higher) will let the hats update quicker, making it look smoother
