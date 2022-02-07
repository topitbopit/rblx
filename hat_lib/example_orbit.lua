-- Orbiting rocks example


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
-- You could do with just calling the normal functions, but redundantly indexing math and getting .new every time
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

-- By default itll be false
library.DisableFlicker = false
-- But if the character is in R6 then set it to true
-- The checks in a pcall in case theres no humanoid for some reason
pcall(function() 
    if (l_char.Humanoid.RigType == Enum.HumanoidRigType.R6) then
        library.DisableFlicker = true
    end
end)
library.CustomNet = vec3(0, 0, 40) -- Using a custom net vector makes it look better
-- If you care more about ownership over shakiness, then just use NetIntensity


-- Make the hats
local hats = {} do 
    while true do
        local hat = library:NewHat()
        if hat then
            ins(hats, {
                hat; -- The hat itself
                random(0,2000)*0.01; -- Current time w/ random offset
                random(50,210)*0.01; -- Speed
                random(-300,300)*0.01; -- Vertical offset
                random(300,800)*0.01; -- Distance
            })
        else
            break
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
        -- The hat[5] controls the distance
        local a, b = sin(index+time)*hat[5], cos(index+time)*hat[5]
        
        -- To prevent the blocks rotating with the player constantly,
        -- the cframe gets calculated separately from the cfa line to preserve rotation
        -- Replace the line below with "local pos1 = (l_humrp.CFrame * cfn(a-b,(sin(index+time)^2) + hat[4],a+b))"
        -- to see what i mean about the rotation w/ the player
        local pos1 = (l_humrp.Position + vec3(a-b,(sin(index+time)^2) + hat[4],a+b))
        
        -- Set the hats cframe to the calculated position multiplied by a "random" angle to give a rotation effect
        hat[1].CFrame = cfn(pos1) * cfa(a,b,0)
    end
end)
