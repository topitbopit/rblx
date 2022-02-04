-- Telekinesis example

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
library.CustomNet = vec3(0, 0, 35)


local bvs = {}
local bgs = {}

do
    connections[1] = l_char.Humanoid.Died:Connect(function() 
        library:Exit()
        
        for i,v in ipairs(bvs) do v:Destroy() end
        for i,v in ipairs(bgs) do v:Destroy() end
        
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
    v.CFrame = dest * cfn(0,7,0)
end
wait(0.1)


for idx,hat in ipairs(hats) do 
    local root = rawget(hat, 'root')
    root.Anchored = false
    root.CanCollide = true
    
    local a = Instance.new("BodyPosition")
    a.D = 800
    a.P = 13000
    a.MaxForce = vec3(15000,15000,15000)
    ins(bvs, a)
    
    local b = Instance.new("BodyGyro")
    b.MaxTorque = vec3(15000,15000,15000)
    b.D = 700 
    b.P = 13000
    
    ins(bgs, b)
end


local offsets, cframes, bgcframes = {}, {}, {}
local toggled = false
connections[2] = serv_uis.InputBegan:Connect(function(io,gpe) 
    if (gpe) then return end
    if (io.KeyCode == Enum.KeyCode.R) then
        toggled = not toggled
        if (toggled) then 
        
            for i = 1, #hats do 
                local root = rawget(hats[i],'root')
                
                bvs[i].Parent = root
                bgs[i].Parent = root
            end
            offsets = {}
            for i = 1, 10 do 
                offsets[i] = {
                    (rand(-200,50)*.1),
                    (rand(-10,40)*.1),
                    (rand(-200,50)*.1)
                }
            end
            
            cframes = {}
            for i = 1, 10 do 
                cframes[i] = cfn(offsets[i][1],offsets[i][2],offsets[i][3] + (-i-2))
            end
            
            bgcframes = {}
            for i = 1, 10 do 
                bgcframes[i] = cfn(vec3(0,0,0), vec3(offsets[i][1],offsets[i][2],offsets[i][3]))
            end
            
            
            connections[4] = rs_stepped:Connect(function(dt) 
                local base = l_humrp.CFrame
                
                for i = 1, #bvs do 
                    bvs[i].Position = (base * cframes[i]).Position
                    bgs[i].CFrame = bgcframes[i]
                    
                end
            end)
        else
            offsets = nil
            cframes = nil
            bgcframes = nil
            connections[4]:Disconnect()
            
            for i = 1, #hats do 
                bvs[i].Parent = nil
                bgs[i].Parent = nil
            end
        end
    end
end)


