-- Among us example

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

if (not l_humrp) then warn("Wait for the game to load!") return end 

local ins,rem = table.insert, table.remove
local vec3, cfn, cfa = Vector3.new, CFrame.new, CFrame.Angles
local sin,cos,rad = math.sin, math.cos, math.rad


local die_connection
local render_connection

die_connection = l_char.Humanoid.Died:Connect(function() 
    library:Exit()
    
    die_connection:Disconnect()
    render_connection:Disconnect()
    
    
    l_char.Humanoid:Destroy()
end)

do 
    local testing = true
    
    library.CustomNet = vec3(0, 0, 40)
    library.DisableFlicker = not testing
    library.ShowRoots = testing
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

local old_chr = l_plr.Character
local new_chr = Instance.new("Model")

local new_hum
local root
do 
    new_hum = Instance.new("Humanoid")
    new_hum.Name = "Humanoid"
    new_hum.RigType = Enum.HumanoidRigType.R6
    new_hum.WalkSpeed = 25
    new_hum.Parent = new_chr
    
    local a = Instance.new("Part")
    a.Name = "Head"
    a.Size = vec3(2, 1, 1)
    a.Transparency = 1
    a.Parent = new_chr
    
    local b = Instance.new("Part")
    b.Name = "Torso"
    b.Size = vec3(2, 2, 1)
    b.Transparency = 1
    b.Parent = new_chr
    
    local c = Instance.new("Part")
    c.Name = "HumanoidRootPart"
    c.Size = vec3(2, 2, 1)
    c.CFrame = l_humrp.CFrame
    c.Transparency = 1
    c.Parent = new_chr
    
    root = c
    
    local d = Instance.new("Motor6D")
    d.C0 = cfn(0,1,0)
    d.C1 = cfn(0,-.5,0)
    d.Part0 = b
    d.Part1 = a
    d.Name = "Neck"
    d.Parent = b
    
    local e = Instance.new("Motor6D")
    e.C0 = cfn(0,0,0)
    e.C1 = cfn(0,0,0)
    e.Part0 = c
    e.Part1 = b
    e.Name = "RootJoint"
    e.Parent = c
    
    new_hum.Died:Connect(function() 
        l_plr.Character = old_chr
        workspace.CurrentCamera.CameraSubject = old_chr.Humanoid
        
        wait(0.3)
        new_chr:Destroy()
    end)
end

new_chr.Parent = workspace
wait(0.1)
l_plr.Character = new_chr


workspace.CurrentCamera.CameraSubject = new_hum

local offset = cfn(0, -0.45, 0)
local cframes = {}

cframes[1]  = cfn(-.5,0,0)
cframes[2]  = cfn(0.5,0,0)
cframes[3]  = cfn(-.5,1,0)
cframes[4]  = cfn(0.5,1,0)
cframes[5]  = cfn(-.5,2,0)
cframes[6]  = cfn(0.5,2,0)
cframes[7]  = cfn(-.5,1.5,-0.8)
cframes[8]  = cfn(0.5,1.5,-0.8)
cframes[9]  = cfn(0,1.5,0.8)
cframes[10] = cfn(0,0.5,0.8)

local time = 0

render_connection = rs_stepped:Connect(function(dt)
    local a = 0
    if (new_hum.MoveDirection.Magnitude > 0) then
        time += dt*7
        a = (sin(time) * (new_hum.WalkSpeed*2))
    end
    
    local base_cf = root.CFrame * offset
    
    hats[1].CFrame = base_cf * cframes[1] * cfn(0, 0, -rad(a)) * cfa( rad(a), 0, -.04)
    hats[2].CFrame = base_cf * cframes[2] * cfn(0, 0,  rad(a)) * cfa(-rad(a), 0, 0.04)

    for i = 3, 10 do
        hats[i].CFrame = base_cf * cframes[i]
    end
end)
