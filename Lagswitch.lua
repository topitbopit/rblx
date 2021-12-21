loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/jtags.lua'))()
local JFR = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/lib.lua'))()

local scriptversion = "1.1.0"

JFR.SetFont(Enum.Font["Nunito"])
JFR.SetBold(false)
JFR.SetRoundAmount(7)
JFR.SetRoundifyEnabled(true)

local num = math.random(7, 10) / 10
JFR.SetTheme({r = num, g = num, b = num + (math.random(1,4) / 10)})


---



local plr = game:GetService"Players".LocalPlayer
local rs = game:GetService"RunService"
local uis = game:GetService"UserInputService"
local ctx = game:GetService"ContextActionService"
local con = {}

if pcall(function() return plr.Character.Parent end) and pcall(function() return plr.Character.Head end) then
else
    JFR.SendMessage({Text = "<font size='30'>Waiting for character...</font>", Size = UDim2.new(0, 300, 0, 50), Position = UDim2.new(0.5, -150, 0.5, -25), Delay = 3})
    repeat wait(0.35) 
        until plr.Character 
end

local noclip = false
local hotkey = nil
local lagswitch_viewing = false
local lagswitch_enabled = false
local show_character = false

local function clone()

    JFR.Async(function()
        pcall(function() game.Workspace["BAKA"]:Destroy() end)
        
        local chr = plr.Character
        LAGSWITCH = Instance.new("Model")
        LAGSWITCH.Parent = game.Workspace
        LAGSWITCH.Name = "BAKA"

    
        local part0 = chr["Torso"]
        local part1 = Instance.new("Part")
        local part2 = chr["HumanoidRootPart"]
        part1.Parent = LAGSWITCH
        part1.CFrame = part0.CFrame
        part1.CanCollide = false
        part1.Size = Vector3.new(2, 2, 1)
        part1.Transparency = 1
        part1.Name = "HumanoidRootPart"
        
        local motor1 = Instance.new("Motor6D")
        motor1.Parent = part1
        motor1.C0 = part2["RootJoint"].C0
        motor1.C1 = part2["RootJoint"].C1
        motor1.MaxVelocity = 0.1
        
        motor1.Part0 = part1
        motor1.Part1 = part0

        part0 = nil
        part1 = nil
        part2 = nil
        
        if not show_character then return end
    
    
        --Handle baseparts
        for _,obj in pairs(chr:GetChildren()) do
            if obj:IsA("BasePart") then
                local a = obj:Clone()
                pcall(function()
                    a.Anchored = true
                    a.CanCollide = false
                    if a.Transparency < 1 then a.Transparency = 0.5 end
                end)
                
                a.Parent = LAGSWITCH
                
            end
        end
        
        --Handle basepart motor6ds
        for i,v in pairs(LAGSWITCH:GetDescendants()) do
            if v:IsA("Motor6D") then
                local old = v.Part1
                v.Part1 = LAGSWITCH[old.Name]
            end
        end
        
        --Handle humanoid
        
        chr["Humanoid"]:Clone().Parent = LAGSWITCH
        
        --Handle clothes
        for _,obj in pairs(chr:GetChildren()) do
            if obj:IsA("Shirt") or obj:IsA("Pants") then
                obj:Clone().Parent = LAGSWITCH 
            end
        end
        
        --Handle accessories
        for _,obj in pairs(chr:GetChildren()) do
            if obj:IsA("Accessory") then
                local a = obj:Clone()
                
                for i,v in pairs(a:GetDescendants()) do
                    if v:IsA("Weld") then
                        local old = v.Part1
                        v.Part1 = LAGSWITCH[old.Name]
                    end
                end
                a.Parent = LAGSWITCH
            end
        end
        
        
        con["temp"] = rs.Stepped:Connect(function() 
            for i,v in pairs(LAGSWITCH:GetChildren()) do
                pcall(function() v.CanCollide = false end) 
            end
        end)
        
        wait(2)
        
        con["temp"]:Disconnect()
        
    end)
    
end


local function lagswitch_enable()
    lagswitch_enabled = true
    
    LAGPOINTER = Instance.new("Part")
    LAGPOINTER.CanCollide = false
    LAGPOINTER.Anchored = true
    LAGPOINTER.Parent = game.Workspace
    LAGPOINTER.Size = Vector3.new(1, 1, 1)
    LAGPOINTER.Position = plr.Character.HumanoidRootPart.Position
    LAGPOINTER.Transparency = 1 
    
    local b = Instance.new("BillboardGui")
    b.Parent = LAGPOINTER
    b.Size = UDim2.new(6, 0, 2, 0)
    b.AlwaysOnTop = true
    
    local c = Instance.new("TextLabel")
    c.Font = Enum.Font.Nunito
    c.TextScaled = true
    c.Text = "You are here"
    c.Size = UDim2.new(1, 0, 1, 0)
    c.BackgroundTransparency = 1
    c.TextColor3 = Color3.fromRGB(255, 255, 255)
    c.TextStrokeTransparency = 0
    c.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    c.Parent = b 
    
    clone() 
end

local function lagswitch_disable()
    lagswitch_enabled = false
    
    pcall(function() LAGSWITCH:Destroy() end)
    pcall(function() LAGPOINTER:Destroy() end)
    
    if lagswitch_viewing then
        lagswitch_viewing = false
        rs:UnbindFromRenderStep("LAGSWITCHCAM")
        game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
        
        JFR.CloseObject(JFR.GetInstance("view"))
        JFR.SetInstanceValue("view", false)
    end
end

local function lagswitch_toggle()
    JFR.SetInstanceValue("toggle", not JFR.GetInstanceValue("toggle"))
    if JFR.GetInstanceValue("toggle") then
        JFR.OpenObject(JFR.GetInstance("toggle"))
        lagswitch_enable()
    else
        JFR.CloseObject(JFR.GetInstance("toggle"))
        lagswitch_disable()
    end
end



--

local function NewlineOnLabel(inst)
    JFR.NewBoard("", inst.Parent, {Position = UDim2.new(0, 30 + inst.TextBounds.X, 0, inst.Position.Y.Offset+12.5), Size = UDim2.new(0, 360 - inst.TextBounds.X,0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function NewLine(inst, y)
    JFR.NewBoard("", inst, {Position = UDim2.new(0, 10, 0, y), Size = UDim2.new(0, 380, 0, 2), BackgroundColor3 = JFR.Theme.shade7, ZIndex = 200})
end

local function StartGradient(parent, y, x)
    x = x or 400
    y = y or 2
    
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6947150722"
    f.Position = UDim2.new(0, 0, 0, y)
    f.Parent = parent
    f.Size = UDim2.new(0, x, 0, 50)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 125
end
local function EndGradient(parent, y, x)
    x = x or 400
    y = y or -50
    
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6947474904"
    f.Position = UDim2.new(0, 0, 1, y)
    f.Parent = parent
    f.Size = UDim2.new(0, x, 0, 50)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 125
end




--init y values
local y = 15;

--Screen gui
local screen = JFR.GetScreen()
screen.Name = "shitstain-"..scriptversion

--Background
local bg = JFR.NewBoard("no", screen, {Position = UDim2.new(0.7, 0, 1.3, 0), Size = UDim2.new(0, 300, 0, 250), Nodrag = true}, true)
local parentb = JFR.GetParentBoard()



--Extra gui stuff
JFR.NewText("Title", bg, {Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 200, 0, 25), Text = "Lagswitch / Blink <font size='15'>v"..scriptversion.."</font>", TextSize = 35, TextYAlignment = Enum.TextYAlignment.Center})
JFR.NewBoard("Shadow", bg, {ZIndex = 0, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 300, 0, 265), BackgroundTransparency = 0.3, BackgroundColor3 = JFR.Theme.shadow})
JFR.NewBoard("Roundedbottom1", bg, {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(0, 300, 0, 25), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewBoard("Outline2", bg, {Position = UDim2.new(0, 0, 0, 50), Size = UDim2.new(0, 300, 0, 2), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})


--Menus
local page = JFR.NewMenu("Page", bg, {AnchorPoint = Vector2.new(0, 0), Size = UDim2.new(0, 300, 0, 200), Position = UDim2.new(0, 0, 0, 50), CanvasSize = UDim2.new(0, 100, 0, 350), Invisible = false})

JFR.NewText("Title", page, {Position = UDim2.new(0, 15, 1, -80), Size = UDim2.new(0, 400, 0, 20), Text = "Made by topit", TextSize = 25})



JFR.NewButton("CloseButton", bg, {Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "X", TextSize = 14}, {on = function()
    JFR.TweenPosition(parentb, UDim2.new(parentb.Position.X.Scale, parentb.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    JFR.TweenCustom(parentb, {Size = UDim2.new(0, parentb.Size.X.Offset, 0, 0)}, 0.75, Enum.EasingDirection.In)
    wait(0.25)
    JFR.FadeOut(parentb, 1)
    wait(0.5)
    screen:Destroy() 


    rs:UnbindFromRenderStep("LAGSWITCHCAM")
    ctx:UnbindAction("LAGSWITCHTOGGLE")
    pcall(function() game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid end)
    pcall(function() LAGSWITCH:Destroy() end)
    pcall(function() LAGPOINTER:Destroy() end)
    
    for i,v in pairs(con) do
        v:Disconnect() 
    end
    con = {}
    
    
    pcall(function() tdc3:Disconnect() end)
    
end})


StartGradient(JFR.GetInstance("Page"), nil, 500)
EndGradient(JFR.GetInstance("Page"), nil, 500)


y=5;
JFR.NewText("a", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Toggle", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("a"))
y=y+30;

JFR.NewButton("toggle", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Lagswitch", TextSize = 20}, {
    on = lagswitch_enable, off = lagswitch_disable})

y=y+30;
JFR.NewButton("hotkey", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Hotkey: none", TextSize = 20}, {
    on = function()
    JFR.GetInstance("hotkey").Text = "Press any key."
    JFR.Async(function() 
        while JFR.GetInstance("hotkey").Text:sub(1,5) == "Press" do
            if JFR.GetInstance("hotkey").Text:sub(1,5) == "Press" then
                JFR.GetInstance("hotkey").Text = "Press any key.."
            end
            wait(0.3) 
            if JFR.GetInstance("hotkey").Text:sub(1,5) == "Press" then 
                JFR.GetInstance("hotkey").Text = "Press any key..."
            end
            wait(0.3)
            if JFR.GetInstance("hotkey").Text:sub(1,5) == "Press" then 
                JFR.GetInstance("hotkey").Text = "Press any key."
            end    
            wait(0.3)
        end
    end)
    con["hotkey"] = uis.InputBegan:Connect(function(io, gpe) 
        local key = io.KeyCode
        
        if key.Name ~= "Unknown" then 
            JFR.GetInstance("hotkey").Text = "Hotkey: "..key.Name
            hotkey = key
            ctx:BindAction("LAGSWITCHTOGGLE", function(_, is, io) 
                if is == Enum.UserInputState.Begin then
                    lagswitch_toggle()
                end
                
            end, false, hotkey)
            con["hotkey"]:Disconnect()
        
        elseif key.Name == "Unknown" then
            JFR.GetInstance("hotkey").Text = "Hotkey: none"
            hotkey = nil
            con["hotkey"]:Disconnect()

        end
    end)
end})
y=y+30;

JFR.NewText("b", page, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Misc", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("b"))
y=y+30;
JFR.NewButton("noclip", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Toggle noclip", TextSize = 20}, {
    on = function()
        con["noclip"] = rs.Stepped:Connect(function()
            for _,inst in pairs(plr.Character:GetChildren()) do
                pcall(function() inst.CanCollide = false end)
            end
        end)

    end, off = function() 
        con["noclip"]:Disconnect()
end})

y=y+30;
JFR.NewButton("view", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "View lagswitch position", TextSize = 20}, {
    on = function()
        if lagswitch_enabled then
            lagswitch_viewing = true
            
            rs:BindToRenderStep("LAGSWITCHCAM", 2000, function() 
                pcall(function() 
                    game.Workspace.CurrentCamera.CameraSubject = LAGPOINTER 
                    game.Workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
                end)
                
            end)
        end
        
    end, off = function() 
        lagswitch_viewing = false
        rs:UnbindFromRenderStep("LAGSWITCHCAM")
        game.Workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid 
end})
y=y+30;
JFR.NewButton("show_character", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Show actual character (buggy)", TextSize = 20}, {
    on = function()
        show_character = true

    end, off = function() 
        show_character = false
end})


y=y+60;

JFR.NewButton("discord", page, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 255, 0, 25), Text = "Copy discord invite", TextSize = 20}, {
    on = function()
        setclipboard("https://discord.gg/a3JEr9Z6jY")
        
end})

local dragarea = Instance.new("Frame")
dragarea.Size = UDim2.new(0, 300, 0, 50)
dragarea.Position = UDim2.new(0, 0, 0, 0)
dragarea.Parent = parentb
dragarea.BackgroundTransparency = 1 
dragarea.BorderSizePixel = 0 

local temp = {}
dragarea.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        temp[1] = true
        temp[2] = parentb.Position
        
        tdc3 = game:GetService("UserInputService").InputChanged:Connect(function(input2)
            if input2.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = input2.Position - input.Position

                JFR.TweenPosition(parentb, UDim2.new(temp[2].X.Scale, temp[2].X.Offset + delta.X, temp[2].Y.Scale, temp[2].Y.Offset + delta.Y), 0.75)
            end
        end)
    end
end)

dragarea.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        temp[1] = false
        tdc3:Disconnect()
        
    end
end) 
JFR.Ready()
JFR.SendMessage({Horizontal = true, Text = "<font size='30'>Lagswitch ready.</font>", Size = UDim2.new(0, 300, 0, 50), Position = UDim2.new(0.05, 0, 0.9, 0), Delay = 3})

wait(1)

if plr.Character.Humanoid.RigType == Enum.HumanoidRigType.R15 then
    JFR.SendMessage({Text = "<font size='25'>This script is not designed for R15.<br/>You can try it, but it will not work.</font>", Size = UDim2.new(0, 400, 0, 60), Position = UDim2.new(0.5, -200, 0.5, -30), Delay = 3}) 
end