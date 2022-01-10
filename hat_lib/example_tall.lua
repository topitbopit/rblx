-- Tall legs example
-- Extremely simple compared to the other demos

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

if (not l_humrp) then warn("Wait for the game to load!") return end 

if (l_char.Humanoid.RigType == Enum.HumanoidRigType.R15) then
    warn("Unsupported: make sure you're in R6")
    library:Exit()
    return
end

local vec3,cfn,cfa = Vector3.new, CFrame.new, CFrame.Angles
local cos,sin,sqrt,rad,random = math.cos,math.sin,math.sqrt, math.rad, math.random
local ins, rem = table.insert, table.remove

local die_connection
local render_connection

die_connection = l_char.Humanoid.Died:Connect(function() 
    library:Exit()
    
    die_connection:Disconnect()
    render_connection:Disconnect()
    
end)


library.DisableFlicker = true
library.NetIntensity = 70



local l_left = l_char["Left Leg"]
local l_right = l_char["Right Leg"]
 
local hats_l = {}
local hats_r = {}
do
    while true do
        local hat = library:NewHat()
        if hat then
            ins(hats_l,hat)
        else
            break
        end
        
        local hat = library:NewHat()
        if hat then
            ins(hats_r,hat)
        else
            hats_l[#hats_l] = nil
            break
        end
    end
end

l_char.Humanoid.HipHeight = #hats_l

render_connection = rs_stepped:Connect(function() 
    
    local cf_l = l_left.CFrame
    local cf_r = l_right.CFrame
    
    for idx,hat in ipairs(hats_l) do
        hat.CFrame = cf_l * cfn(0, -(idx + 0.4), 0)
    end
    
    for idx,hat in ipairs(hats_r) do
        hat.CFrame = cf_r * cfn(0, -(idx + 0.4), 0)
    end
    
end)
