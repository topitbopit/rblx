-- Among us example

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local serv_uis = game:GetService("UserInputService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

if (not l_humrp) then warn("Wait for the game to load!") return end 

local ins,rem = table.insert, table.remove
local vec3, cfn, cfa = Vector3.new, CFrame.new, CFrame.Angles
local sin,cos,rad = math.sin, math.cos, math.rad
local wait = task.wait


local die_connection
local render_connection
local input_connection

if testing then
    die_connection = l_plr.Chatted:Connect(function(msg) 
        if msg:match("resp") then
            library:Exit()
            
            die_connection:Disconnect()
            render_connection:Disconnect()
            input_connection:Disconnect()    
        end
        --l_char.Humanoid:Destroy()
    end)
else
    die_connection = l_char.Humanoid.Died:Connect(function() 
        library:Exit()
        
        die_connection:Disconnect()
        render_connection:Disconnect()
        input_connection:Disconnect()    
        --l_char.Humanoid:Destroy()
    end)
end
do 
    library.CustomNet = vec3(0, 0, 30)
    library.DisableFlicker = true
    library.ShowRoots = false
    library.BlockifyHats = true
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

local vent_sound
local walk_sound


local new_hum
local root
do 
    new_hum = Instance.new("Humanoid")
    new_hum.Name = "Humanoid"
    new_hum.RigType = Enum.HumanoidRigType.R6
    new_hum.WalkSpeed = 25
    new_hum.DisplayDistanceType = "None"
    new_hum.HealthDisplayType = "DisplayWhenDamaged"
    new_hum.CameraOffset = vec3(0, -2, 0)
    new_hum.Parent = new_chr
    
    local a = Instance.new("Part")
    a.Name = "Head"
    a.Size = vec3(2, 1, 1)
    a.Transparency = 1
    a.Color = Color3.new(1,0,0)
    a.Anchored = false
    a.CanCollide = true
    a.Parent = new_chr
    
    local b = Instance.new("Part")
    b.Name = "Torso"
    b.Size = vec3(2, 2, 1)
    b.Transparency = 1
    b.Color = Color3.new(0,1,0)
    b.Anchored = false
    b.CanCollide = true
    b.Parent = new_chr
    
    root = Instance.new("Part")
    root.Name = "HumanoidRootPart"
    root.Size = vec3(2, 2, 1)
    root.Anchored = false
    root.CanCollide = false
    root.CFrame = l_humrp.CFrame + vec3(0, 3, 0)
    root.Transparency = 1
    root.Color = Color3.new(0,0,1)
    root.Parent = new_chr
    
    new_chr.PrimaryPart = root
    
    local c = Instance.new("Part")
    c.Name = "Left Leg"
    c.Size = vec3(1,2,1)
    c.Transparency = 1
    c.Anchored = false
    c.CanCollide = false
    c.Parent = new_chr
    
    local d = Instance.new("Part")
    d.Name = "Right Leg"
    d.Size = vec3(1,2,1)
    d.Transparency = 1
    d.Anchored = false
    d.CanCollide = false
    d.Parent = new_chr
    
    local e = Instance.new("Motor6D")
    e.C0 = cfn(0,1,0)
    e.C1 = cfn(0,-.5,0)
    e.Part0 = b
    e.Part1 = a
    e.Name = "Neck"
    e.Parent = b
    
    local f = Instance.new("Motor6D")
    f.C0 = cfn(0,0,0)
    f.C1 = cfn(0,0,0)
    f.Part0 = root
    f.Part1 = b
    f.Name = "RootJoint"
    f.Parent = root
    
    local g = Instance.new("Motor6D")
    g.C0 = cfn(1,-1,0)
    g.C1 = cfn(0.5,1,0)
    g.Part0 = b
    g.Part1 = d
    g.Name = "Right Hip"
    g.Parent = b
    
    local h = Instance.new("Motor6D")
    h.C0 = cfn(-1,-1,0)
    h.C1 = cfn(-0.5,1,0)
    h.Part0 = b
    h.Part1 = c
    h.Name = "Left Hip"
    h.Parent = b
    
    local w = Instance.new("Part")
    w.Name = "Right Arm"
    w.Size = vec3(1,2,1)
    w.Transparency = 1
    w.Anchored = false
    w.CanCollide = false
    w.Parent = new_chr
    
    local x = Instance.new("Part")
    x.Name = "Left Arm"
    x.Size = vec3(1,2,1)
    x.Transparency = 1
    x.Anchored = false
    x.CanCollide = false
    x.Parent = new_chr
    
    local y = Instance.new("Motor6D")
    y.C0 = cfn(1,0.5,0)
    y.C1 = cfn(-0.5,0.5,0)
    y.Part0 = b
    y.Part1 = w
    y.Name = "Right Shoulder"
    y.Parent = w
    
    local z = Instance.new("Motor6D")
    z.C0 = cfn(-1,0.5,0)
    z.C1 = cfn(0.5,0.5,0)
    z.Part0 = b
    z.Part1 = x
    z.Name = "Left Shoulder"
    z.Parent = x
    
    new_hum.Died:Connect(function() 
        l_plr.Character = old_chr
        workspace.CurrentCamera.CameraSubject = old_chr.Humanoid
        
        wait(0.3)
        new_chr:Destroy()
    end)
    
    vent_sound = Instance.new("Sound")
    vent_sound.Name = "Vent"
    vent_sound.SoundId = "rbxassetid://5771441412"
    vent_sound.Volume = 5
    vent_sound.TimePosition = .3
    vent_sound.Parent = root
    
    walk_sound = Instance.new("Sound")
    walk_sound.Name = "Walk"
    walk_sound.SoundId = "rbxassetid://6019631856"
    walk_sound.Volume = 0
    walk_sound.Looped = true
    walk_sound.Parent = root
    
    walk_sound:Play()
end

new_chr.Parent = workspace
wait(0.1)
l_plr.Character = new_chr


workspace.CurrentCamera.CameraSubject = new_hum

local offset = cfn(0, -2.45, 0)
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


local is_amongus = true
local is_venting = false
local debounce = false

input_connection = serv_uis.InputBegan:Connect(function(io, gpe) 
    if gpe then return end
    if (io.KeyCode == Enum.KeyCode.KeypadZero) then
        is_amongus = not is_amongus
        if (is_amongus) then
            l_plr.Character = new_chr
            workspace.CurrentCamera.CameraSubject = new_hum
        else
            l_plr.Character = old_chr
            workspace.CurrentCamera.CameraSubject = old_chr.Humanoid
        end
        
    elseif (io.KeyCode == Enum.KeyCode.KeypadOne) then
        root.CFrame = l_humrp.CFrame
        offset = cfn(0, -2.45, 0)
        new_hum.WalkSpeed = 25
    
    elseif (io.KeyCode == Enum.KeyCode.KeypadTwo) then
        if (debounce) then return end
        
        is_venting = not is_venting
        debounce = true
        vent_sound:Play()
        if (is_venting) then
            walk_sound.SoundId = "rbxassetid://6169152593"
            
            
            new_hum.WalkSpeed = 0
            root.Velocity = vec3(0,40,0)
            wait(0.35)
            for i = 1, 6, 0.5 do 
                offset = cfn(0, -(i*1.2), 0)
                wait(0.01)
            end
            new_hum.WalkSpeed = 50
            
            offset = cfn(0, -15, 0)
        else
            walk_sound.SoundId = "rbxassetid://6019631856"
            
            new_hum.WalkSpeed = 0
            root.Velocity = vec3(0,40,0)
            
            offset = cfn(0, -4.45, 0)
            wait(.01)
            offset = cfn(0, -3.45, 0)
            wait(.01)
            offset = cfn(0, -2.45, 0)
            
            wait(0.3)
            new_hum.WalkSpeed = 25
        end
        debounce = false
    end
end)



local time = 0
local a = 0
render_connection = rs_stepped:Connect(function(dt)
    
    if (new_hum.MoveDirection.Magnitude > 0) then
        time += dt*15
        a = (sin(time) * (new_hum.WalkSpeed*2))
        
        walk_sound.Volume = 2
    else
        time = 0
        a *= (100*dt)
        walk_sound.Volume = 0
    end
    
    local base_cf = root.CFrame * offset
    
    hats[1].CFrame = base_cf * cframes[1] * cfn(0, 0, -rad(a)) * cfa( rad(a), 0, -.04)
    hats[2].CFrame = base_cf * cframes[2] * cfn(0, 0,  rad(a)) * cfa(-rad(a), 0, 0.04)

    for i = 3, 10 do
        hats[i].CFrame = base_cf * cframes[i]
    end
end)
