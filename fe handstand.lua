local serv_rs = game:GetService("RunService")

local l_chr = game.Players.LocalPlayer.Character
local l_humrp = l_chr.HumanoidRootPart
local l_hum = l_chr.Humanoid

local vec3, cfn, cfa = Vector3.new, CFrame.new, CFrame.Angles
local rad, sin, cos = math.rad, math.sin, math.cos

local l_cam = workspace.CurrentCamera

local a
local b

delay(30, function() 
    serv_rs:UnbindFromRenderStep("j")
    
    a:Destroy() 
    b:Destroy()
end)


a = Instance.new("BodyPosition")
a.Position = l_humrp.Position - vec3(0, 1, 0)
a.P = 135000
a.Parent = l_humrp

b = Instance.new("BodyGyro")
b.MaxTorque = vec3(9999,9999,9999)
b.P = 125000
b.D = 135
b.Parent = l_humrp


serv_rs:BindToRenderStep("j",2000, function(dt) 
    l_hum:ChangeState(6)
    a.Position += l_hum.MoveDirection * dt * 16
    
    local lv = l_cam.CFrame.LookVector*50
    
    b.CFrame = cfn(vec3(0,0,0), vec3(lv.X, 0, lv.Z)) * cfa(0, 0, rad(180))
end)