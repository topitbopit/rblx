-- Telekenisis example

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local serv_uis = game:GetService("UserInputService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = (l_char and l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",.5))


local vec3,cfn,cfa = Vector3.new, CFrame.new, CFrame.Angles
local cos,sin,rand = math.cos,math.sin, math.random
local ins, rem = table.insert, table.remove
local wait,spawn = task.wait, task.spawn

local connections = {}

library.DisableFlicker = false
pcall(function() 
    if (l_char.Humanoid.RigType == Enum.HumanoidRigType.R6) then
        library.DisableFlicker = true
    end
end)
library.NetIntensity = 60
library.CustomNet = vec3(0, 0, 30)


local bvs = {}

do
    connections[1] = l_char.Humanoid.Died:Connect(function() 
        library:Exit()
        
        for i,v in ipairs(bvs) do 
            v:Destroy()
        end
        
        for i,v in ipairs(connections) do v:Disconnect() end
    end)
end



local hats = {}
do
    while true do
        local hat = library:NewHat()
        if hat then
            ins(hats,hat)
        else
            break
        end
    end
end




local dest = l_humrp.CFrame
for idx,v in ipairs(hats) do
    v.CFrame = dest * cfn(0,5,0)
end
wait(0.1)


for idx,hat in ipairs(hats) do 
    local root = rawget(hat, 'root')
    root.Anchored = false
    root.CanCollide = true
    
    local a = Instance.new("BodyPosition")
    a.D = 600
    a.P = 9000
    a.MaxForce = vec3(9000,9000,9000)
    ins(bvs, a)
end


local offsets, cframes = {}, {}

connections[2] = serv_uis.InputBegan:Connect(function(io,gpe) 
    if (gpe) then return end
    if (io.KeyCode == Enum.KeyCode.R) then
        
        for idx,hat in ipairs(hats) do 
            bvs[idx].Parent = rawget(hat,'root')
        end
        offsets = {}
        for i = 1, 10 do 
            offsets[i] = {
                (rand(-180,180)*.1),
                (rand(-60,90)*.1),
                (rand(-190,20)*.1)
            }
        end
        
        cframes = {}
        for i = 1, 10 do 
            cframes[i] = cfn(offsets[i][1],offsets[i][2],offsets[i][3] + (-i-2))
        end
        
        
        connections[4] = rs_stepped:Connect(function(dt) 
            local base = l_humrp.CFrame
            
            for i,v in ipairs(bvs) do 
                v.Position = (base * cframes[i]).Position
            end
        end)
    end
end)

connections[3] = serv_uis.InputEnded:Connect(function(io,gpe) 
    if (gpe) then return end
    if (io.KeyCode == Enum.KeyCode.R) then
        offsets = nil
        cframes = nil
        
        connections[4]:Disconnect()
        
        for idx,hat in ipairs(hats) do 
            bvs[idx].Parent = nil
        end
    end
end)


