--[[indep from ui variables]]--
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PlayerService = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ContextAction= game:GetService("ContextActionService")


local SCRIPTVER = "1.2.0"



loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/jtags.lua'))()
local JFR = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/Jeff-2.3-Framework/main/lib.lua'))()

local plr = game:GetService"Players".LocalPlayer
local peening = false
local runs = game:GetService("RunService")
local bypass_connections = {}

local balls = false
local plr_rotate = false
local swing_amount = 1.5
local penoir_size = 1.5

local penoir_parts1
local penoir_parts2
local penoir_parts3
local penoir_parts4


local libtards = {}

local function message(message)
    JFR.Async(function()
        local a = Instance.new("Part")
        a.CanCollide = false
        a.Anchored = true
        a.Parent = game.Workspace
        a.Size = Vector3.new(1, 1, 1)
        a.Position = plr.Character.Head.Position
        a.Transparency = 1 
        
        local b = Instance.new("BillboardGui")
        b.Parent = a
        b.Size = UDim2.new(5, 0, 1, 0)
        b.AlwaysOnTop = true
        
        local c = Instance.new("TextLabel")
        c.Font = Enum.Font.Nunito
        c.TextScaled = true
        c.Text = message
        c.Size = UDim2.new(1, 0, 1, 0)
        c.BackgroundTransparency = 1
        c.TextColor3 = Color3.fromRGB(255, 255, 255)
        c.TextStrokeTransparency = 0
        c.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        c.Parent = b 
        c.RichText = true
    
     
        JFR.TweenCustom(a, {Position = a.Position + Vector3.new(0, math.random(100, 180)/100, 0)}, 1.5) 
        wait(1.5)
        a:Destroy()
    end)
end

function GetCharacter()
    if pcall(function() return plr.Character.Head end) then
        return plr.Character 
    end
    return nil
end

function GetMesh(instance)
    if pcall(function() return instance["SpecialMesh"].VertexColor end) then
        return instance["SpecialMesh"]
    end
    return nil 
end


function netbypass_disable()
    for i,v in pairs(bypass_connections) do
        v:Disconnect()
    end
end

local function GetClosestPlayer()
    local e = plr.Character.HumanoidRootPart.Position
    local curtarg = nil
    local curlim = 5000
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= plr.Name and pcall(function() return plr.Character.Head end) then
            local f = 999
            pcall(function() f = (v.Character.HumanoidRootPart.Position - e).Magnitude end)
            if f < curlim then
                curlim = f 
                curtarg = v
            end
        end     
    end
    return curtarg 
end

local function rotate_disable()
    
    pcall(function() plr.Character.Humanoid.AutoRotate = true end)
    pcall(function() RunService:UnbindFromRenderStep("PlayerRotatePenoir") end)
    
    pcall(function()
        JFR.SetInstanceValue("Player_Rotate", false)
        JFR.CloseObject(JFR.GetInstance("Player_Rotate"))
    end)
    
end



local bindto = function(name, value,func) 
    name = name or "nil"
    value = value or Enum.RenderPriority.Character.Value + 2
    RunService:BindToRenderStep(name,value,func)
end
local unbindfrom = function(name)
    name = name or "nil"
    RunService:UnbindFromRenderStep(name) 
end

local bindaction = function(name, func, key)
    ContextAction:BindAction(name, function(a, b) if b == Enum.UserInputState.Begin then func() end end, false, key) 
end

local unbindaction = function(name)
    ContextAction:UnbindAction(name)

end


local newhotkey = function(name, parent, args, bound, unbound)
    local f = JFR.NewTextBox(name.."Hotkey", parent, args, function() 
        
        local tb = JFR.GetInstance(name.."Hotkey")
        local t = tb.Text
        if t:len() == 1 then
            t = t:upper() 
        end
        
        if pcall(function() return Enum.KeyCode[t] end) then
            h = Enum.KeyCode[t]
            if ("Hotkey: "..h.Name):len() >= 13 then
                local temp = h.Name:gsub("%l","", 4)
                    
                if hotkeytables[h.Name] then
                    tb.Text = "Hotkey: "..hotkeytables[h.Name]
                else
                    tb.Text = "Hotkey: <font size='"..tostring(20 - temp:len()).."'>"..temp.."</font>"
                
                end
            else
                tb.Text = "Hotkey: "..h.Name
            end
            
            bindaction(name.."Hotkey",function()
                JFR.SetInstanceValue(name, not JFR.GetInstanceValue(name))
                if JFR.GetInstanceValue(name) then
                    JFR.OpenObject(JFR.GetInstance(name))
                    bound()
                else
                    JFR.CloseObject(JFR.GetInstance(name))
                    unbound()
                end
                
            
            end, h)
        else
            tb.Text = "No hotkey"
            unbindaction(name.."Hotkey")
        end
    end)
    
end

local function NewSelector(size, place, parent)
    size = size or 7 
    place = place or 0
    parent = parent or nil
    local f = Instance.new("ImageLabel")
    f.Image = "rbxassetid://6956257983"
    f.Size = UDim2.new(0, size, 0, size)
    f.Position = UDim2.new(0, place, 0, 0)
    f.BackgroundTransparency = 1
    f.ZIndex = 280    
    f.Parent = parent
    return f
end

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
    f.Position = UDim2.new(0, 2, 0, y)
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
    f.Position = UDim2.new(0, 2, 1, y)
    f.Parent = parent
    f.Size = UDim2.new(0, x, 0, 50)
    f.BackgroundTransparency = 1
    f.BorderSizePixel = 0
    f.ZIndex = 125
end

JFR.SetFont(Enum.Font["Nunito"])
JFR.SetBold(false)
JFR.SetRoundAmount(7)
JFR.SetRoundifyEnabled(true)

local num = math.random(7, 10) / 10
JFR.SetTheme({r = num, g = num, b = num + (math.random(1,4) / 10)})



--init y values
local y = 15;
local page = "Page_Home"

--Screen gui
local screen = JFR.GetScreen()
screen.Name = "penisjuice-"..SCRIPTVER

--Background
local bg = JFR.NewBoard("no", screen, {Position = UDim2.new(0.7, 0, 1.3, 0), Size = UDim2.new(0, 500, 0, 250), Nodrag = true}, true)
local parentb = JFR.GetParentBoard()



--Extra gui stuff
JFR.NewText("Title", bg, {Position = UDim2.new(0, 15, 0, 15), Size = UDim2.new(0, 400, 0, 25), Text = "Penoirware GUI <font size='15'>v"..SCRIPTVER.."</font>", TextSize = 35, TextYAlignment = Enum.TextYAlignment.Center})
JFR.NewBoard("Shadow", bg, {ZIndex = 0, Position = UDim2.new(0, 3, 0, 3), Size = UDim2.new(0, 500, 0, 265), BackgroundTransparency = 0.3, BackgroundColor3 = JFR.Theme.shadow})
JFR.NewBoard("Roundedbottom1", bg, {Position = UDim2.new(0, 0, 1, -10), Size = UDim2.new(0, 125, 0, 25), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewBoard("Roundedbottom2", bg, {Position = UDim2.new(0, 100, 1, -10), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade3, Unroundify = true})
JFR.NewBoard("Roundedbottom3", bg, {Position = UDim2.new(0, 115, 1, -10), Size = UDim2.new(0, 385, 0, 25), BackgroundColor3 = JFR.Theme.shade3})
JFR.NewBoard("Outline1", bg, {Position = UDim2.new(0, 100, 0, 50), Size = UDim2.new(0, 2, 0, 200), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})
JFR.NewBoard("Outline2", bg, {Position = UDim2.new(0, 0, 0, 50), Size = UDim2.new(0, 500, 0, 2), BackgroundColor3 = JFR.Theme.shade6, ZIndex = 200})

--Menus
local Page_Home = JFR.NewMenu("Page_Home", bg, {Position = UDim2.new(0, 100, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 100)})
local Page_Modes = JFR.NewMenu("Page_Modes", bg, {Position = UDim2.new(0, 100, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 600), Invisible = true})
local Page_Respawn = JFR.NewMenu("Page_Respawn", bg, {Position = UDim2.new(0, 100, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 100), Invisible = true})
local Page_Info = JFR.NewMenu("Page_Info", bg, {Position = UDim2.new(0, 100, 0, 250), CanvasSize = UDim2.new(0, 100, 0, 1255), Invisible = true})


--Tabs
local menu_tabs = JFR.NewMenu("Menu_Tabs", bg, {Position = UDim2.new(0, 0, 0, 250), Size = UDim2.new(0, 100, 0, 200), CanvasSize = UDim2.new(0, 80, 0, 100), BackgroundColor3 = JFR.Theme.shade4})
JFR.NewButton("Tab_Home", menu_tabs, {Position = UDim2.new(0, 12, 0, y), Size = UDim2.new(0, 75, 0, 25), Text = "Home"}, {on = function() 
    JFR.OpenObject(JFR.GetInstance("Tab_Home"));
    JFR.CloseObject(JFR.GetInstance("Tab_Modes"));
    JFR.CloseObject(JFR.GetInstance("Tab_Respawn"));
    JFR.CloseObject(JFR.GetInstance("Tab_Info"));

    JFR.GetInstance("Page_Home").Visible = true
    JFR.GetInstance("Page_Modes").Visible = false
    JFR.GetInstance("Page_Respawn").Visible = false
    JFR.GetInstance("Page_Info").Visible = false
    
    page = "Page_Home"
end})
JFR.OpenObject(JFR.GetInstance("Tab_Home"))
y=y+40;
JFR.NewButton("Tab_Modes", menu_tabs, {Position = UDim2.new(0, 12, 0, y), Size = UDim2.new(0, 75, 0, 25), Text = "Modes"}, {on = function()
    JFR.CloseObject(JFR.GetInstance("Tab_Home"));
    JFR.OpenObject(JFR.GetInstance("Tab_Modes"));
    JFR.CloseObject(JFR.GetInstance("Tab_Respawn"));
    JFR.CloseObject(JFR.GetInstance("Tab_Info"));

    JFR.GetInstance("Page_Home").Visible = false
    JFR.GetInstance("Page_Modes").Visible = true
    JFR.GetInstance("Page_Respawn").Visible = false
    JFR.GetInstance("Page_Info").Visible = false
    
    page = "Page_Modes"
end})
y=y+40;
JFR.NewButton("Tab_Respawn", menu_tabs, {Position = UDim2.new(0, 12, 0, y), Size = UDim2.new(0, 75, 0, 25), Text = "Respawn"}, {on = function() 
    JFR.CloseObject(JFR.GetInstance("Tab_Home"));
    JFR.CloseObject(JFR.GetInstance("Tab_Modes"));
    JFR.OpenObject(JFR.GetInstance("Tab_Respawn"));
    JFR.CloseObject(JFR.GetInstance("Tab_Info"));

    JFR.GetInstance("Page_Home").Visible = false
    JFR.GetInstance("Page_Modes").Visible = false
    JFR.GetInstance("Page_Respawn").Visible = true
    JFR.GetInstance("Page_Info").Visible = false
    
    page = "Page_Respawn"
end})
y=y+40;
JFR.NewButton("Tab_Info", menu_tabs, {Position = UDim2.new(0, 12, 0, y), Size = UDim2.new(0, 75, 0, 25), Text = "Info"}, {on = function() 
    JFR.CloseObject(JFR.GetInstance("Tab_Home"));
    JFR.CloseObject(JFR.GetInstance("Tab_Modes"));
    JFR.CloseObject(JFR.GetInstance("Tab_Respawn"));
    JFR.OpenObject(JFR.GetInstance("Tab_Info"));

    JFR.GetInstance("Page_Home").Visible = false
    JFR.GetInstance("Page_Modes").Visible = false
    JFR.GetInstance("Page_Respawn").Visible = false
    JFR.GetInstance("Page_Info").Visible = true
    
    page = "Page_Info"
end})

JFR.NewButton("MinimizeButton", bg, {Position = UDim2.new(1, -60, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "-", TextSize = 14}, {
    on = function()
        JFR.GetInstance("MinimizeButton").Text = "+"
        
        JFR.TweenSize(parentb, UDim2.new(0, parentb.Size.X.Offset, 0, 50), 0.75, Enum.EasingDirection.Out)
        JFR.TweenSize(JFR.GetInstance("Shadow"), UDim2.new(0, parentb.Size.X.Offset, 0, 50), 0.75, Enum.EasingDirection.Out)
        
        local function YoMom(a)
            JFR.Async(function() 
                JFR.TweenSize(a, UDim2.new(a.Size.X.Scale, a.Size.X.Offset, a.Size.Y.Scale, 0), 0.75, Enum.EasingDirection.Out)
                wait(0.75)
                if a.Size.Y.Offset == 0 then 
                    a.Visible = false
                end
            end)
        end
        YoMom(JFR.GetInstance("Page_Home"))
        YoMom(JFR.GetInstance("Page_Info"))
        YoMom(JFR.GetInstance("Page_Modes"))
        YoMom(JFR.GetInstance("Page_Respawn"))
        YoMom(JFR.GetInstance("Menu_Tabs"))
        
        YoMom(JFR.GetInstance("Outline1"))
        YoMom(JFR.GetInstance("Outline2"))
        
        YoMom(JFR.GetInstance("Roundedbottom3"))
        YoMom(JFR.GetInstance("Roundedbottom2"))
        YoMom(JFR.GetInstance("Roundedbottom1"))

    end,
    off = function() 
        JFR.GetInstance("MinimizeButton").Text = "-"
        local function YorMom(a, y)
            JFR.Async(function()
                a.Visible = true
                JFR.TweenSize(a, UDim2.new(a.Size.X.Scale, a.Size.X.Offset, a.Size.Y.Scale, y), 0.75, Enum.EasingDirection.Out)
            end)
        end
        
        JFR.TweenSize(parentb, UDim2.new(0, parentb.Size.X.Offset, 0, 250), 0.75, Enum.EasingDirection.Out)
        JFR.TweenSize(JFR.GetInstance("Shadow"), UDim2.new(0, parentb.Size.X.Offset, 0, 265), 0.75, Enum.EasingDirection.Out)
    
        YorMom(JFR.GetInstance("Page_Home"), 200)
        YorMom(JFR.GetInstance("Page_Info"), 200)
        YorMom(JFR.GetInstance("Page_Modes"), 200)
        YorMom(JFR.GetInstance("Page_Respawn"), 200)
        YorMom(JFR.GetInstance("Menu_Tabs"), 200)
        
        
        JFR.GetInstance("Page_Home"    ).Visible = false
        JFR.GetInstance("Page_Info"    ).Visible = false
        JFR.GetInstance("Page_Modes"    ).Visible = false
        JFR.GetInstance("Page_Respawn"    ).Visible = false
        JFR.GetInstance(page).Visible = true
        
    
        YorMom(JFR.GetInstance("Outline1"), 200)
        YorMom(JFR.GetInstance("Outline2"), 2)
    
        YorMom(JFR.GetInstance("Roundedbottom1"), 25)
        YorMom(JFR.GetInstance("Roundedbottom2"), 25)
        YorMom(JFR.GetInstance("Roundedbottom3"), 25)


    end
})

JFR.NewButton("CloseButton", bg, {Position = UDim2.new(1, -30, 0, 5), Size = UDim2.new(0, 25, 0, 25), BackgroundColor3 = JFR.Theme.shade7, Text = "X", TextSize = 14}, {on = function()
    JFR.TweenPosition(parentb, UDim2.new(parentb.Position.X.Scale, parentb.Position.X.Offset, 1.1, 0), 0.75, Enum.EasingDirection.In)
    JFR.TweenCustom(parentb, {Size = UDim2.new(0, parentb.Size.X.Offset, 0, 0)}, 0.75, Enum.EasingDirection.In)
    wait(0.25)
    JFR.FadeOut(parentb, 1)
    wait(0.5)
    screen:Destroy() 
    

    netbypass_disable()

    
    for i,v in pairs(libtards) do
        libtards[i] = nil
        pcall(function() v:Destroy() end)
    end
    
    pcall(function() mouse_part:Destroy() end)
    rotate_disable()

    pcall(function() plhk_connection:Disconnect() end)
    pcall(function() ContextAction:UnbindAction("PLHKRESP") end)
    pcall(function() penoir_parts1:Destroy() end)
    pcall(function() penoir_parts2:Destroy() end)
    pcall(function() penoir_parts3:Destroy() end)
    pcall(function() penoir_parts4:Destroy() end)
end})


StartGradient(JFR.GetInstance("Page_Home"))
EndGradient(JFR.GetInstance("Page_Home"))

StartGradient(JFR.GetInstance("Page_Info"))
EndGradient(JFR.GetInstance("Page_Info"))

StartGradient(JFR.GetInstance("Page_Modes"))
EndGradient(JFR.GetInstance("Page_Modes"))

StartGradient(JFR.GetInstance("Page_Respawn"))
EndGradient(JFR.GetInstance("Page_Respawn"))

y=5;
JFR.NewText("Page_Home_Title", Page_Home, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Home", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("Page_Home_Title"))

y=y+30;
JFR.NewText("1_Text", Page_Home, {Position = UDim2.new(0, 10, 0, 30), Size = UDim2.new(0, 400, 0, 75), Text = " Penoirware made by topit<br/>Check out what the new features are in the <b>info</b> tab<br/><br/>Join the discord: <br/><br/><br/><br/>Version "..SCRIPTVER, TextSize = 20})
NewLine(Page_Home, 165)

JFR.NewButton("HomeDiscord", Page_Home, {Position = UDim2.new(0.075, 0, 0, 120), Size = UDim2.new(0, 340, 0, 25), Text = "Copy invite to clipboard"}, {on = function() setclipboard("https://discord.gg/Gn9vWr8DJC") JFR.Async(function() JFR.GetInstance("HomeDiscord").Text = "Copied" wait(1) JFR.GetInstance("HomeDiscord").Text = "Copy invite to clipboard" end) end})

y=5;
JFR.NewText("Page_Modes_Title2", Page_Modes, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Penoir modes", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("Page_Modes_Title2"))
y=y+30;

JFR.NewButton("Penoir_Normal", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Normal penoir"}, {on = function() 

        
        
    local libral = GetCharacter()
    
    if libral then
        --Capture valid hats for making penoir
        for _,child in pairs(libral:GetChildren()) do
            if child:IsA("Accessory") then
                if child.Name:match("Fedora") or child.Name == "MeshPartAccessory" then
                    table.insert(libtards, child) 
                end
            end
        end
    
        --Clear out meshes on the hats
        for _,hat in pairs(libtards) do
            pcall(function() GetMesh(hat.Handle):Destroy() end)
        end
        
        
        penoir_parts1 = Instance.new("Folder")
        penoir_parts1.Name = "PenoirParts1"
        penoir_parts1.Parent = workspace
        
        --Clear out attachments from each hat, letting them fall
        for _,hat in pairs(libtards) do
            for _,child in pairs(hat["Handle"]:GetChildren()) do
                if child:IsA("Weld") then
                    child:Destroy()
                end
            end
            hat.Parent = penoir_parts1
        end
        
        --Make hat not gravity
        for ind,hat in pairs(libtards) do
            if not pcall(function() return hat["Handle"]["Sussy baka"].Name end) then
                local nograv = Instance.new("BodyVelocity")
                nograv.Velocity = Vector3.new(0, 0, 0)
                nograv.Parent = hat["Handle"]
                nograv.Name = "Sussy baka"
            end
        end
        
        
        
        --Start the penoir
        bypass_connections["Penoir_Normal"] = runs.Heartbeat:Connect(function()
            for pos, hat in pairs(libtards) do
                if pos > 2 then
                    pcall(function()
                        hat["Handle"].CFrame = libral["HumanoidRootPart"].CFrame * CFrame.new(0, -0.8, ((-pos / 2) * penoir_size)  + 1.21)
                    end)
                else
                    pcall(function()
                        hat["Handle"].CFrame = libral["HumanoidRootPart"].CFrame * CFrame.new((pos - 1.5) * 1.35, -0.8, -0.8)
                    end)
                end
                
                hat["Handle"].Velocity = Vector3.new(0, 0, 0)
            end
            
        end)
        
        
    end

end, off = function() 
    for i,v in pairs(libtards) do
        libtards[i] = nil
        v:Destroy()
    end
    
    penoir_parts1:Destroy()
    netbypass_disable()
end})
y=y+30;

JFR.NewButton("Penoir_Swing", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Swinging penoir"}, {on = function() 

    local libral = GetCharacter()
    
    if libral then
        --Capture valid hats for making penoir
        for _,child in pairs(libral:GetChildren()) do
            if child:IsA("Accessory") then
                if child.Name:match("Fedora") or child.Name == "MeshPartAccessory" then
                    table.insert(libtards, child) 
                end
            end
        end
    
        --Clear out meshes on the hats
        for _,hat in pairs(libtards) do
            pcall(function() GetMesh(hat.Handle):Destroy() end)
        end
        
        
        penoir_parts2 = Instance.new("Folder")
        penoir_parts2.Name = "PenoirParts2"
        penoir_parts2.Parent = workspace

        
        --Clear out attachments from each hat, letting them fall
        for _,hat in pairs(libtards) do
            for _,child in pairs(hat["Handle"]:GetChildren()) do
                if child:IsA("Weld") then
                    child:Destroy()
                end
            end
            hat.Parent = penoir_parts2
        end
        
        --Make hat not gravity
        for ind,hat in pairs(libtards) do
            if not pcall(function() return hat["Handle"]["Sussy baka"].Name end) then
                local nograv = Instance.new("BodyPosition")
                --nograv.Velocity = Vector3.new(0, 0, 0)
                nograv.Parent = hat["Handle"]
                nograv.Name = "Sussy baka"
                nograv.D = (4 + (swing_amount * 40)) - ind / 5
                nograv.P = 1500
                
                local e = Instance.new("BodyGyro")
                e.Parent = hat["Handle"]
                e.Name = "Imposter"
                e.D = 10
                e.P = 1500
                e.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                
            end
        end
        
        
        
        --Start the penoir
        if balls then
            bypass_connections["Penoir_Swing"] = runs.Heartbeat:Connect(function()
                for pos, hat in pairs(libtards) do
                    if pos > 2 then 
                        
                        pcall(function() 
                            hat["Handle"]["Sussy baka"].Position = (libral["HumanoidRootPart"].CFrame * CFrame.new(0, -0.8, (-(pos -2) / 2) * (penoir_size))).Position
                            hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                            
                            hat["Handle"]["Imposter"].CFrame = CFrame.new(libral["HumanoidRootPart"].Position, libral["HumanoidRootPart"].Position + libral["HumanoidRootPart"].CFrame.LookVector)
                        end)
                    else
                        pcall(function() 
                            
                            hat["Handle"]["Sussy baka"].Position = (libral["HumanoidRootPart"].CFrame * CFrame.new((pos - 1.5) * 1.35, -0.8, -0.8)).Position
                            hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                            
                            hat["Handle"]["Imposter"].CFrame = CFrame.new(libral["HumanoidRootPart"].Position, libral["HumanoidRootPart"].Position + libral["HumanoidRootPart"].CFrame.LookVector)
                        end)
                    end
                    hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                end
                
            end)
        else
            bypass_connections["Penoir_Swing"] = runs.Heartbeat:Connect(function()
                for pos, hat in pairs(libtards) do
                    pcall(function() 
                        
                        hat["Handle"]["Sussy baka"].Position = (libral["HumanoidRootPart"].CFrame * CFrame.new(0, -0.8, (-pos / 2) * (penoir_size))).Position
                        hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                        
                        hat["Handle"]["Imposter"].CFrame = CFrame.new(libral["HumanoidRootPart"].Position, libral["HumanoidRootPart"].Position + libral["HumanoidRootPart"].CFrame.LookVector)
                    end)
                    hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                end
                
            end)
        end
        
        
    end

end, off = function() 
    for i,v in pairs(libtards) do
        libtards[i] = nil
        v:Destroy()
    end
    
    penoir_parts2:Destroy()
    netbypass_disable()
end})
y=y+30;

JFR.NewButton("Penoir_Mouse", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Mouse-facing penoir"}, {on = function() 

        
    local libral = GetCharacter()
    
    if libral then
        libral = GetCharacter()
        
        
        local mouse = plr:GetMouse()
        
        
        mouse_part = Instance.new("Part")
        mouse_part.CFrame = CFrame.new(libral.HumanoidRootPart.Position, mouse.Hit.Position)
        mouse_part.Transparency = 1
        mouse_part.Anchored = true
        mouse_part.CanCollide = false
        mouse_part.Name = "imposterbaka"
        mouse_part.Size = Vector3.new(1, 1, 1)
        mouse_part.Parent = workspace
        
        --Capture valid hats for making penoir
        for _,child in pairs(libral:GetChildren()) do
            if child:IsA("Accessory") then
                if child.Name:match("Fedora") or child.Name == "MeshPartAccessory" then
                    table.insert(libtards, child) 
                end
            end
        end
    
        --Clear out meshes on the hats
        for _,hat in pairs(libtards) do
            pcall(function() GetMesh(hat.Handle):Destroy() end)
        end
        
        penoir_parts3 = Instance.new("Folder")
        penoir_parts3.Name = "PenoirParts3"
        penoir_parts3.Parent = workspace
        
        mouse.TargetFilter = penoir_parts3
        
        --Clear out attachments from each hat, letting them fall
        for _,hat in pairs(libtards) do
            for _,child in pairs(hat["Handle"]:GetChildren()) do
                if child:IsA("Weld") then
                    child:Destroy()
                end
            end
            hat.Parent = penoir_parts3
        end
        
        --Make hat not gravity
        for ind,hat in pairs(libtards) do
            if not pcall(function() return hat["Handle"]["Sussy baka"].Name end) then
                local nograv = Instance.new("BodyPosition")
                --nograv.Velocity = Vector3.new(0, 0, 0)
                nograv.Parent = hat["Handle"]
                nograv.Name = "Sussy baka"
                nograv.D = (4 + (swing_amount * 40)) - ind / 5
                nograv.P = 1500
                
                local e = Instance.new("BodyGyro")
                e.Parent = hat["Handle"]
                e.Name = "Imposter"
                e.D = 10
                e.P = 1500
                e.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            end
        end
        
        
                        
        --Start the penoir
        if balls then
            bypass_connections["Penoir_Mouse"] = runs.Heartbeat:Connect(function()
                mouse_part.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position-Vector3.new(0,0.8,0), mouse.Hit.Position)
                for pos, hat in pairs(libtards) do
                    if pos > 2 then 
                        pcall(function() 
                            hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame + (mouse_part.CFrame.LookVector * (((pos - 2) / 2) * penoir_size))).Position
                            hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                            
                            hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                        end)
                    else
                        do
                            pcall(function() 
                            
                                hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame * CFrame.new((pos - 1.5) * 1.35, 0, -0.5)).Position --(libral["HumanoidRootPart"].CFrame * CFrame.new((pos - 1.5) * 1.35, -0.8, -0.8)).Position
                                hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                                
                                hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                            end)
                        end
                    end
                    hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                end
                
            end)
        else
            bypass_connections["Penoir_Mouse"] = runs.Heartbeat:Connect(function()
                mouse_part.CFrame = CFrame.new(libral.HumanoidRootPart.Position-Vector3.new(0,0.8,0), mouse.Hit.Position)
                for pos, hat in pairs(libtards) do
                    pcall(function() 
                        
                        hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame + (mouse_part.CFrame.LookVector * ((pos / 2) * penoir_size))).Position
                        hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                        
                        hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                    end)
                    hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                end
                
            end)
        end
        
        if plr_rotate then
            RunService:BindToRenderStep("PlayerRotatePenoir", 800, function() 
                pcall(function() 
                    plr.Character.Humanoid.AutoRotate = false
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.CFrame.Position, plr.Character.HumanoidRootPart.CFrame.Position + Vector3.new(mouse_part.CFrame.LookVector.X, 0 ,mouse_part.CFrame.LookVector.Z))
                    
                end)
                
            end) 
        end
        
    end
    
end, off = function() 
    for i,v in pairs(libtards) do
        libtards[i] = nil
        v:Destroy()
    end
    pcall(function() mouse_part:Destroy() end)
    pcall(function() penoir_parts3:Destroy() end)
    rotate_disable()
    netbypass_disable()
end})

y=y+30;

JFR.NewButton("Penoir_FacePlr", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Face nearest player penoir"}, {on = function() 

    if #game.Players:GetPlayers() == 1 then
        message("Not enough players")
        JFR.SetInstanceValue("Penoir_FacePlr", false)
        JFR.CloseObject(JFR.GetInstance("Penoir_FacePlr"))
        return 
    end
    
    local libral = GetCharacter()
    
    if libral then
        
        mouse_part = Instance.new("Part")
        mouse_part.CFrame = CFrame.new(libral.HumanoidRootPart.Position, Vector3.new(0, 0, 0))
        mouse_part.Transparency = 1
        mouse_part.Anchored = true
        mouse_part.CanCollide = false
        mouse_part.Parent = game.Workspace
        mouse_part.Name = "imposterbaka"
        mouse_part.Size = Vector3.new(1, 1, 1)
        
        --Capture valid hats for making penoir
        for _,child in pairs(libral:GetChildren()) do
            if child:IsA("Accessory") then
                if child.Name:match("Fedora") or child.Name == "MeshPartAccessory" then
                    table.insert(libtards, child) 
                end
            end
        end
        
        
        --Clear out meshes on the hats
        for _,hat in pairs(libtards) do
            pcall(function() GetMesh(hat.Handle):Destroy() end)
        end
        
        
        penoir_parts4 = Instance.new("Folder")
        penoir_parts4.Name = "PenoirParts4"
        penoir_parts4.Parent = workspace
        
        --Clear out attachments from each hat, letting them fall
        for _,hat in pairs(libtards) do
            for _,child in pairs(hat["Handle"]:GetChildren()) do
                if child:IsA("Weld") then
                    child:Destroy()
                end
            end
            hat.Parent = penoir_parts4
        end
        
        --Make hat not gravity
        for ind,hat in pairs(libtards) do
            if not pcall(function() return hat["Handle"]["Sussy baka"].Name end) then
                local nograv = Instance.new("BodyPosition")
                --nograv.Velocity = Vector3.new(0, 0, 0)
                nograv.Parent = hat["Handle"]
                nograv.Name = "Sussy baka"
                nograv.D = (4 + (swing_amount * 40)) - ind / 5
                nograv.P = 1500
                
                local e = Instance.new("BodyGyro")
                e.Parent = hat["Handle"]
                e.Name = "Imposter"
                e.D = 10
                e.P = 1500
                e.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                
            end
        end
        
        
        
        
        --Start the penoir
        if balls then
            bypass_connections["Penoir_FacePlr"] = runs.Heartbeat:Connect(function()
                local targ_pos = GetClosestPlayer().Character.HumanoidRootPart.Position
                mouse_part.CFrame = CFrame.new(libral.HumanoidRootPart.Position-Vector3.new(0,0.8,0), targ_pos - Vector3.new(0,0.8,0))
                for pos, hat in pairs(libtards) do
                    if pos > 2 then 
                        pcall(function() 
                            hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame + (mouse_part.CFrame.LookVector * (((pos - 2) / 2) * penoir_size))).Position
                            hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                            
                            hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                        end)
                    else
                        do
                            pcall(function() 
                            
                                hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame * CFrame.new((pos - 1.5) * 1.35, 0, -0.5)).Position --(libral["HumanoidRootPart"].CFrame * CFrame.new((pos - 1.5) * 1.35, -0.8, -0.8)).Position
                                hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                                
                                hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                            end)
                        end
                    end
                    hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                end
                
            end)
        else
            bypass_connections["Penoir_FacePlr"] = runs.Heartbeat:Connect(function()
                local targ_pos = GetClosestPlayer().Character.HumanoidRootPart.Position
                mouse_part.CFrame = CFrame.new(libral.HumanoidRootPart.Position-Vector3.new(0,0.8,0), targ_pos - Vector3.new(0,0.8,0))
                
                for pos, hat in pairs(libtards) do
                    pcall(function() 
                        
                        hat["Handle"]["Sussy baka"].Position = (mouse_part.CFrame + (mouse_part.CFrame.LookVector * ((pos / 2) * penoir_size))).Position
                        hat["Handle"]["Sussy baka"].D = (4 + (swing_amount * 2)) - pos / 5
                        
                        hat["Handle"]["Imposter"].CFrame = CFrame.new(mouse_part.Position, mouse_part.Position + mouse_part.CFrame.LookVector)
                    
                        hat["Handle"].Velocity = Vector3.new(0, 0, 0)
                    end)
                    
                end
                
            end)
        end
        
        if plr_rotate then
            RunService:BindToRenderStep("PlayerRotatePenoir", 800, function() 
                pcall(function() 
                    plr.Character.Humanoid.AutoRotate = false
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.CFrame.Position, plr.Character.HumanoidRootPart.CFrame.Position + Vector3.new(mouse_part.CFrame.LookVector.X, 0 ,mouse_part.CFrame.LookVector.Z))
                    
                end)
                
            end) 
        end
        
    end
end, off = function() 
    for i,v in pairs(libtards) do
        libtards[i] = nil
        v:Destroy()
    end
    pcall(function() mouse_part:Destroy() end)
    pcall(function() penoir_parts4:Destroy() end)

    rotate_disable()
    netbypass_disable()
end})

y=y+30;
JFR.NewText("Penoir_SizeText", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 220, 0, 25), Text = "Pen. length: "..penoir_size})

JFR.NewBoard("Penoir_SizeAmount", Page_Modes, {ClipsDescendants = true, Position = UDim2.new(0.375, 0, 0, y+9), Size = UDim2.new(0, 220, 0, 7), ZIndex = 200})

local sel = Instance.new("Frame")
sel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sel.Size = UDim2.new(0, 7, 0, 7)
sel.Position = UDim2.new(0, 106.5, 0, 0)
sel.Parent = JFR.GetInstance("Penoir_SizeAmount")
sel.BorderSizePixel = 0
sel.ZIndex = 500
JFR.Roundify(sel)
local ps_vals = {}

JFR.MakeSlider(sel, JFR.GetInstance("Penoir_SizeAmount"), ps_vals, function() 
    penoir_size = 1 + ps_vals[3] / 213
    JFR.GetInstance("Penoir_SizeText").Text = "Pen. length: "..tostring(penoir_size):sub(1,3)
end, true)



y=y+30;
JFR.NewText("Swing_AmountText", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 220, 0, 25), Text = "Pen. swing: "..tostring(swing_amount)})

JFR.NewBoard("Swing_Amount", Page_Modes, {ClipsDescendants = true, Position = UDim2.new(0.375, 0, 0, y+9), Size = UDim2.new(0, 220, 0, 7), ZIndex = 200})

local sel = Instance.new("Frame")
sel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
sel.Size = UDim2.new(0, 7, 0, 7)
sel.Position = UDim2.new(0, 106.5, 0, 0)
sel.Parent = JFR.GetInstance("Swing_Amount")
sel.BorderSizePixel = 0
sel.ZIndex = 500
JFR.Roundify(sel)
local sw_vals = {}

JFR.MakeSlider(sel, JFR.GetInstance("Swing_Amount"), sw_vals, function() 
    swing_amount = 1 + sw_vals[3] / 213
    JFR.GetInstance("Swing_AmountText").Text="Pen. swing: "..tostring(swing_amount):sub(1,3)
end, true)


y=y+30;

JFR.NewButton("Penoir_Balls", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Balls on non-normal modes"}, {on = function() 
    balls = true
    message("Pee is stored in the balls")
end, off = function() 
    balls = false
    message("Pee isn&apos;t stored in the balls")
end})

JFR.OpenObject(JFR.GetInstance("Penoir_Balls"))
JFR.SetInstanceValue("Penoir_Balls", true)
balls = true


y=y+30;

JFR.NewButton("Player_Rotate", Page_Modes, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Face toward mouse / nearest player"}, {on = function() 
    plr_rotate = true
    message("Player rotate enabled")
end, off = function() 
    plr_rotate = false
    message("Player rotate disabled")
    rotate_disable()
end})

y=5;
JFR.NewText("Page_Respawn_Title", Page_Respawn, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Respawn", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("Page_Respawn_Title"))

y=y+30;
JFR.NewButton("Respawn_Normal", Page_Respawn, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Normal respawn"}, {on = function() 
    message("Respawning...")
    local libral = GetCharacter()
    
    if libral then
        local was_rotating = plr_rotate
        rotate_disable()
        
        local cf = libral["HumanoidRootPart"].CFrame
        
        libral["Humanoid"].Health = 0
        wait(0.1)
        sussy_respawn_connec = plr.CharacterAdded:Connect(function() 
            wait(0.2)
            GetCharacter().HumanoidRootPart.CFrame = cf
            sussy_respawn_connec:Disconnect()
            
            if was_rotating then
                rotate_disable()
                
                
                JFR.OpenObject(JFR.GetInstance("Player_Rotate"))
                JFR.SetInstanceValue("Player_Rotate", true)
                plr_rotate = true
                
            end
        end)
        
        
    end
end})
y=y+30;
JFR.NewButton("Respawn_Inf", Page_Respawn, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Infinite yield&apos;s respawn"}, {on = function() 
    message("Respawning (IY)...")
    
    local libral = GetCharacter()
    
    if libral then
        local was_rotating = plr_rotate

        
        local cf = libral["HumanoidRootPart"].CFrame
        
    	libral["Humanoid"]:ChangeState(15)
    	libral:ClearAllChildren()
    	
    	local newChar = Instance.new("Model")
    	newChar.Parent = workspace
    	
    	plr.Character = newChar
    	wait()
    	plr.Character = libral
    	newChar:Destroy()
    	
        wait(0.1)
        sussy_respawn_connec = plr.CharacterAdded:Connect(function() 
            wait(0.2)
            GetCharacter().HumanoidRootPart.CFrame = cf
            sussy_respawn_connec:Disconnect()
            
            if was_rotating then
                rotate_disable()
                
                
                JFR.OpenObject(JFR.GetInstance("Player_Rotate"))
                JFR.SetInstanceValue("Player_Rotate", true)
                plr_rotate = true
                
            end
        end)
        
        
    end
    
end})
if game.PlaceId == 155615604 then
    y=y+30;
    JFR.NewText("Page_Respawn_PLTitle", Page_Respawn, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Prison life", TextSize = 20})
    NewlineOnLabel(JFR.GetInstance("Page_Respawn_PLTitle"))
        
    local gayevent = game.Workspace.Remote["loadchar"]
    local plre_hotkey = nil
    local plre_hotkey_connec = nil
    
    local function PL_Respawn()
        message("Respawning (Instant)...")
        local libral = GetCharacter()
        if libral then
            local prev_mode = 0
            
            netbypass_disable()

            local cf = libral["HumanoidRootPart"].CFrame
            gayevent:InvokeServer(plr)
            wait(0.1)
            GetCharacter()["HumanoidRootPart"].CFrame = cf
            rotate_disable()
            for i,v in pairs(libtards) do
                libtards[i] = nil
                v:Destroy()
            end
            pcall(function() mouse_part:Destroy() end)
            pcall(function() penoir_parts:Destroy() end)
            

            
            JFR.SetInstanceValue("Penoir_Normal", false)
            JFR.CloseObject(JFR.GetInstance("Penoir_Normal"))
            
            JFR.SetInstanceValue("Penoir_Swing", false)
            JFR.CloseObject(JFR.GetInstance("Penoir_Swing"))
            
            JFR.SetInstanceValue("Penoir_Mouse", false)
            JFR.CloseObject(JFR.GetInstance("Penoir_Mouse"))
            
            JFR.SetInstanceValue("Penoir_FacePlr", false)
            JFR.CloseObject(JFR.GetInstance("Penoir_FacePlr"))
        end 
        
    end
    
    
    y=y+30;
    JFR.NewButton("Respawn_PL", Page_Respawn, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "Prison life insta respawn"}, {on = function() 
        PL_Respawn()
        
    end})
    
    y=y+30;
    JFR.NewButton("Respawn_PLHK", Page_Respawn, {Position = UDim2.new(0.075, 0, 0, y), Size = UDim2.new(0, 340, 0, 25), Text = "PL Respawn hotkey: none"}, {on = function() 
        JFR.GetInstance("Respawn_PLHK").Text = "Enter a hotkey."
        JFR.Async(function() 
            while JFR.GetInstance("Respawn_PLHK").Text:sub(1,5) == "Enter" do
                if JFR.GetInstance("Respawn_PLHK").Text:sub(1,5) == "Enter" then
                    JFR.GetInstance("Respawn_PLHK").Text = "Enter a hotkey.."
                end
                wait(0.3) 
                if JFR.GetInstance("Respawn_PLHK").Text:sub(1,5) == "Enter" then 
                    JFR.GetInstance("Respawn_PLHK").Text = "Enter a hotkey..."
                end
                wait(0.3)
                if JFR.GetInstance("Respawn_PLHK").Text:sub(1,5) == "Enter" then 
                    JFR.GetInstance("Respawn_PLHK").Text = "Enter a hotkey."
                end    
                wait(0.3)
            end
        end)
        plhk_connection = UserInputService.InputBegan:Connect(function(io, gpe) 
            local key = io.KeyCode
            
            if key.Name ~= "Unknown" then 
                JFR.GetInstance("Respawn_PLHK").Text = "PL Respawn hotkey: "..key.Name
                plre_hotkey = key
                plhk_connection:Disconnect()
                ContextAction:BindAction("PLHKRESP", function(_, uis, io) 
                    if uis == Enum.UserInputState.Begin then
                        PL_Respawn() 
                    end
                end, false, plre_hotkey)
            
            elseif key.Name == "Unknown" then
                JFR.GetInstance("Respawn_PLHK").Text = "PL Respawn hotkey: none"
                plre_hotkey = nil
                plhk_connection:Disconnect()
                
                ContextAction:UnbindAction("PLHKRESP")
            end
        end)
    end})


end

y=5;

JFR.NewText("InfoText1", Page_Info, {Position = UDim2.new(0.05, -10, 0, y), Size = UDim2.new(0, 400, 0, 25), Text = "Information", TextSize = 20})
NewlineOnLabel(JFR.GetInstance("InfoText1"))

JFR.NewText("InfoText2", Page_Info, {Position = UDim2.new(0, 10, 0, 30), Size = UDim2.new(0, 400, 0, 2345), Text = " "..
    "<font size='24'><i>Required hats</i></font>"..
    "<br/>For this script to work, you must have <b>9</b> different<br/>international fedoras. They&apos;re free, so no worries.<br/>If you don&apos;t know how to get them, scroll down to Q/A."..
    
    "<br/><br/>"..
    "<font size='24'><i>Version 1.2.0</i></font>"..
    "<br/> -Switched to netless; more exploits are compatible now"..
    "<br/> -Changed how swing works"..
    "<br/> -Made it less detectable in certain games"..
    "<br/> -Defaulted balls to on"..
    "<br/> -Updated discord link"..
    
    "<br/><br/>"..
    "<font size='24'><i>Version 1.1.0</i></font>"..
    "<br/> -Possibly improved net bypass"..
    "<br/> -Made IY respawn mode better"..
    "<br/> -Added balls option and look at mouse / other player<br/>option"..
    "<br/> -Changed how penoir swing was calculated"..
    "<br/> -Made non-normal penoir modes look better"..
    "<br/> -Made mouse mode not glitch out when you looked<br/>at the penoir"..
    

    "<br/><br/>"..
    "<font size='24'><i>Version 1.0.0</i></font>"..
    "<br/> -Added normal penoir, mouse facing penoir,<br/>swinging penoir, and player facing penoir."..
    "<br/> -Added IY respawn and Normal respawn modes"..
    "<br/> -Added Penoir Swing setting and Penoir Length setting"..
    "<br/> -Added special support for the game Prison Life"..
    
    "<br/><br/>"..
    "<font size='24'><i>Help / Q&A</i></font>"..
    "<br/><b>It doesn&apos;t work in <i>x</i> game!</b><br/>You can send me the game link, but odds are I won&apos;t update<br/>this script ever again"..
    "<br/><b>Can I enable multiple penoir modes?</b><br/>No, this will break the script."..
    "<br/><br/><b>What does the Penoir Swing setting do?</b><br/>The higher the number, the less it swings.<br/>The name should be &quot;Swing Dampening&quot;, but I don&apos;t care."..
    "<br/><br/><b>Why doesn&apos;t the netless work?</b><br/> - If someone touches the blocks, you lose<br/>network ownership and they break. There&apos;s<br/>no way to get around this."..
    "<br/><br/><b>How do I equip multiple fedoras?</b><br/>Go to Avatar -> Clothing -> Hat, and scroll to the bottom.<br/>Click &quot;advanced&quot;, and paste in all of your hat IDs.<br/>Note that all fedoras should be supported, but some<br/>may not work because of their model name."..
    "<br/><br/><b>Can I close the GUI with some modules on?</b><br/>Although it should be fine, I wouldn&apos;t recommend it."..
    "<br/><br/><b>Does this support <i>x</i> exploit?</b><br/>Penoirware is tested on synapse, but should work fine on<br/>any exploit that can run PSU.<br/>Because of the switch to netless, more exploits<br/>are supported.",
    
TextSize = 18})

local dragarea = Instance.new("Frame")
dragarea.Size = UDim2.new(0, 500, 0, 50)
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





bypass_connections["ONHUMDEATH"] = plr.CharacterRemoving:Connect(function() 
    netbypass_disable()
end)


settings().Physics.AllowSleep = false
settings().Physics.DisableCSGv2 = true
settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Disabled


JFR.Ready()
JFR.SendMessage({Horizontal = true, Text = "<font size='30'>Loaded <b>Penoirware</b>.<br/>Required hats are listed in <b>Info</b></font>", Size = UDim2.new(0, 500, 0, 75), Position = UDim2.new(0.05, 0, 0.9, 0), Delay = 3})