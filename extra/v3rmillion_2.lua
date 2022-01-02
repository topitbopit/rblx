-- Hat spin demo
-- This assumes you use the free international fedoras but any hats could work

-- Get important services for stuff
local rs = game:GetService("RunService")
local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer

-- Get character and make a table for hats
local c = plr.Character
local hats = {}
    
-- Get the hats
for i,v in ipairs(c:GetChildren()) do
    if v:IsA("Accessory") then
        v.Handle.AccessoryWeld:Destroy() 
        table.insert(hats, v.Handle)
    end
end

-- Remove meshes if R6
if (c.Humanoid.RigType == Enum.HumanoidRigType.R6) then
    for i,v in ipairs(hats) do 
        local mesh = v:FindFirstChildOfClass("SpecialMesh") or v:FindFirstChildOfClass("Mesh")
        mesh:Destroy()
    end
end

-- Disable the anim when you die
c.Humanoid.Died:Connect(function() 
    rs:UnbindFromRenderStep("hatanim")
end)

-- "Net bypass" stuff
settings().Physics.AllowSleep = false
settings().Physics.DisableCSGv2 = true
settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled

-- Localize math functions
local cos,sin,sqrt = math.cos, math.sin, math.sqrt

-- Main loop
rs:BindToRenderStep("hatanim", 2000, function()
    local t = tick()
    local m = (cos(t))*1.5
    for i,v in ipairs(hats) do
        
        -- This is all overly complicated math just to make a simple spin animation
        -- You just need to set the cframe to where you want them to go
        v.CFrame = c.HumanoidRootPart.CFrame * 
        
        CFrame.new(
            m*(cos((t-i)*5)*3), 
            sin(t+i), 
            (sqrt(m*m))*(sin((t-i)*5)*3)
        ) * 
        
        CFrame.Angles(0, sin(t-i)*5, 0)
        
        -- and set the velocity to move some direction
        -- I prefer moving the hats closer towards yourself, which the line below accomplishes
        v.Velocity = CFrame.new(v.Position, c.HumanoidRootPart.Position).LookVector * 15
    end
end)
