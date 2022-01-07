--[[
I will make full on docs later, but heres some simple docs for now

<boolean>   module.BlockifyHats = true    -- Turns hats into blocks. Set DisableFlicker to false if you set this to false for consistent appearance
<number>    module.NetIntensity = 80      -- The higher the less likely for blocks to break, but the more the flicker effect appears
<boolean>   module.DisableFlicker = false -- Disables the flicker effect, but only clientside.

<HatObject> module:NewHat() -- Creates and returns a hat object
<void>      module:ClearHats() -- Removes all hats
<void>      module:Exit() -- Removes all hats, remove variables, stops main net loop, etc.

-- HatObject --
<CFrame>    HatObject.CFrame -- Sets the hat CFrame to a desired value when newindexed


Basically: create a hat with NewHat(), set hat.CFrame to some value, call Exit() when done

]]--


-- Get hat library
local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

-- Get services
local serv_rs = game:GetService("RunService")
local rs_stepped = serv_rs.RenderStepped
-- Get local stuff
local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

-- Safety measure, doubt its needed but just in case
if (not l_humrp) then warn("Wait for the game to load!") return end 

-- Get needed functions
local vec3,cfn,cfa = Vector3.new, CFrame.new, CFrame.Angles
local cos,sin,sqrt,rad,random = math.cos,math.sin,math.sqrt, math.rad, math.random
local ins = table.insert
-- You could do with just calling the normal functions, but reduntantly indexing math and getting .new every time
-- is annoying


-- Set up connections
local die_connection
local render_connection

-- Destroy everything when dead
-- library:Exit() handles most of the cleanups for you
die_connection = l_char.Humanoid.Died:Connect(function() 
    library:Exit()
    
    hats = nil
    
    die_connection:Disconnect()
    render_connection:Disconnect()
end)

-- Disable the flicker
-- Note that because of the way the net works, extreme flicker is generated (even more so with higher fps)
-- There is an option to disable the flicker, but it's clientside only
-- The only downside is that if a block gets destroyed for whatever reason, you still see it since the fakepart doesn't get destroyed
library.DisableFlicker = true
library.NetIntensity = 80 -- 80 works fine, 50-60 seems to be the lowest you can go without breaking ownership

-- Make the hats
local hats = {} do 
    for i = 1, 10 do 
        local hat = library:NewHat()
        if hat then
            ins(hats, {
                hat; -- The hat itself
                random(0,200)*0.1; -- Current time w/ random offset
                random(5,20)*0.1; -- Speed
                random(-30,30)*0.1; -- Vertical offset
            })
        end
    end
end 

-- Slight explanation before the actual math is shown:
-- Each hat will have its own "time", "speed", and vertical offset
-- Vertical offset:
--   Offset from the normal Y, done to give a more interesting look
-- Time:
--   Essentially how far the animation is in progress.
--   Since the position is effectively a math equation, think as it as like the X going into an algebraic function
--   It's actually just a number used as the basis for calculations
-- Speed:
--   The speed is how fast the time progresses.
--   If you understand how deltatime works, then you'll understand what the code below does


-- Now onto the math
render_connection = rs_stepped:Connect(function(DeltaTime) 
    
    -- Go through every single hat, and set its position
    for index,hat in ipairs(hats) do
        -- << TIME & DELTATIME >> --
        -- First change its time value by the deltatime multiplied by speed
        -- Don't know what deltatime is? Heres a good article https://drewcampbell92.medium.com/understanding-delta-time-b53bf4781a03
        hat[2] += DeltaTime * hat[3]
        
        -- Then get hat[2] and assign it to time
        local time = hat[2]
        -- The code could lose this line and just get hat[2] every time, but
        -- it doesn't really matter
        
        -- << CFRAME MATH >> --
        -- Using sin and cos lets a circle path be formed
        -- `index` isn't really needed (because of the random time value set at hat creation) but it helps give extra variety
        -- Changing 4 changes the size of the circle, try it out
        local a, b = sin(index+time)*4, cos(index+time)*4
        
        -- To prevent the blocks rotating with the player constantly,
        -- the cframe gets calculated separately from the cfa line to preserve rotation
        -- Replace the line below with "local pos1 = (l_humrp.CFrame * cfn(a-b,(sin(index+time)^2) + hat[4],a+b))"
        -- to see what i mean about the rotation w/ the player
        local pos1 = (l_humrp.Position + vec3(a-b,(sin(index+time)^2) + hat[4],a+b))
        
        -- Set the hats cframe to the calculated position multiplied by a "random" angle to give a rotation effect
        hat[1].CFrame = cfn(pos1) * cfa(a,b,0)
    end
end)

