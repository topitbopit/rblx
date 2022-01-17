local dim2, dim2off, dim2sca = UDim2.new, UDim2.fromOffset, UDim2.fromScale
local vec3,vec2 = Vector3.new, Vector2.new
local c3,c3r,c3h = Color3.new, Color3.fromRGB, Color3.fromHSV
local ins,rem,clr = table.insert, table.remove, table.clear
local rand, floor,ceil, clamp = math.random, math.floor, math.ceil, math.clamp
local char,byte = string.char, string.byte
local wait,delay,spawn = task.wait, task.delay, task.spawn
local inst = Instance.new

local serv_uis = game:GetService("UserInputService")
local serv_plrs = game:GetService("Players")
local l_plr = serv_plrs.LocalPlayer

local function getname()
    local a = ''
    for i = 1, 10 do 
        a..= char(rand(60,150))
    end
    return a
end


local res = game:GetService("GuiService"):GetScreenResolution()

local screen = inst("ScreenGui")
screen.Name = getname()
pcall(function() 
    syn.protect_gui(screen)
end)
pcall(function() 
    protect_gui(screen) -- forwards compatibility for any exploits skidding synapse :troll:
end)
screen.Parent = game:GetService("CoreGui")

local RootFrame = inst("Frame")
RootFrame.Size = dim2off(200, 247)
RootFrame.BackgroundTransparency = 1
RootFrame.Position = dim2off(res.X - 250, res.Y - 297)
RootFrame.Parent = screen

local Background = inst("Frame")
Background.Size = dim2(1, 0, 1, 0)
Background.BackgroundColor3 = c3(0.12,0.12,0.12)
Background.BorderColor3 = c3(0.05,0.05,0.05)
Background.BorderSizePixel = 1
Background.ZIndex = 5
Background.Parent = RootFrame

local TopBar = inst("Frame")
TopBar.Size = dim2(1, 0, 0, 30)
TopBar.BackgroundColor3 = c3(0.15,0.15,0.15)
TopBar.BorderColor3 = c3(0.05,0.05,0.05)
TopBar.BorderSizePixel = 1
TopBar.ZIndex = 5
TopBar.Active = true
TopBar.Parent = RootFrame

local TopBarText = inst("TextLabel")
TopBarText.Size = dim2sca(1, 1)
TopBarText.BackgroundTransparency = 1
TopBarText.Text = "  Coords grabber"
TopBarText.TextSize = 20
TopBarText.TextColor3 = c3(1,1,1)
TopBarText.TextXAlignment = "Left"
TopBarText.TextStrokeTransparency = 0
TopBarText.Font = "SourceSans"
TopBarText.ZIndex = 5
TopBarText.Parent = TopBar

local Menu = inst("Frame")
Menu.Size = dim2(1,-12,1,-42)
Menu.Position = dim2off(6,36)
Menu.BackgroundColor3 = c3(0.12,0.12,0.12)
Menu.BorderColor3 = c3(0.05,0.05,0.05)
Menu.BorderSizePixel = 1
Menu.ZIndex = 5
Menu.Parent = Background

local Close = inst("TextButton")
Close.Size = dim2off(20,20)
Close.Position = dim2(1,-26,0,5)
Close.BackgroundColor3 = c3(0.12,0.12,0.12)
Close.BorderColor3 = c3(0.05,0.05,0.05)
Close.BorderSizePixel = 1
Close.Text = "X"
Close.TextColor3 = c3(1,1,1)
Close.Font = "Nunito"
Close.TextScaled = true
Close.ZIndex = 5
Close.Parent = TopBar

local Copy = inst("TextButton")
Copy.Size = dim2(1,-8,0,25)
Copy.Position = dim2(0,4,0,5)
Copy.BackgroundColor3 = c3(0.11,0.11,0.11)
Copy.BorderColor3 = c3(0.05,0.05,0.05)
Copy.BorderSizePixel = 1
Copy.Text = "Copy coords"
Copy.TextColor3 = c3(1,1,1)
Copy.TextStrokeTransparency = 0
Copy.Font = "SourceSans"
Copy.TextSize = 19
Copy.ZIndex = 5
Copy.Parent = Menu

local GenTP = inst("TextButton")
GenTP.Size = dim2(1,-8,0,25)
GenTP.Position = dim2(0,4,0,35)
GenTP.BackgroundColor3 = c3(0.11,0.11,0.11)
GenTP.BorderColor3 = c3(0.05,0.05,0.05)
GenTP.BorderSizePixel = 1
GenTP.Text = "Gen TP script"
GenTP.TextColor3 = c3(1,1,1)
GenTP.TextStrokeTransparency = 0
GenTP.Font = "SourceSans"
GenTP.TextSize = 19
GenTP.ZIndex = 5
GenTP.Parent = Menu

local GenTPTween = inst("TextButton")
GenTPTween.Size = dim2(1,-8,0,25)
GenTPTween.Position = dim2(0,4,0,65)
GenTPTween.BackgroundColor3 = c3(0.11,0.11,0.11)
GenTPTween.BorderColor3 = c3(0.05,0.05,0.05)
GenTPTween.BorderSizePixel = 1
GenTPTween.Text = "Gen tween TP script"
GenTPTween.TextColor3 = c3(1,1,1)
GenTPTween.TextStrokeTransparency = 0
GenTPTween.Font = "SourceSans"
GenTPTween.TextSize = 19
GenTPTween.ZIndex = 5
GenTPTween.Parent = Menu



local FullCopy = inst("TextButton")
FullCopy.Size = dim2(1,-8,0,25)
FullCopy.Position = dim2(0,4,0,115)
FullCopy.BackgroundColor3 = c3(0.11,0.11,0.11)
FullCopy.BorderColor3 = c3(0.05,0.05,0.05)
FullCopy.BorderSizePixel = 1
FullCopy.Text = "Copy full coords"
FullCopy.TextColor3 = c3(1,1,1)
FullCopy.TextStrokeTransparency = 0
FullCopy.Font = "SourceSans"
FullCopy.TextSize = 19
FullCopy.ZIndex = 5
FullCopy.Parent = Menu

local FullGenTP = inst("TextButton")
FullGenTP.Size = dim2(1,-8,0,25)
FullGenTP.Position = dim2(0,4,0,145)
FullGenTP.BackgroundColor3 = c3(0.11,0.11,0.11)
FullGenTP.BorderColor3 = c3(0.05,0.05,0.05)
FullGenTP.BorderSizePixel = 1
FullGenTP.Text = "Gen full TP script"
FullGenTP.TextColor3 = c3(1,1,1)
FullGenTP.TextStrokeTransparency = 0
FullGenTP.Font = "SourceSans"
FullGenTP.TextSize = 19
FullGenTP.ZIndex = 5
FullGenTP.Parent = Menu

local FullGenTPTween = inst("TextButton")
FullGenTPTween.Size = dim2(1,-8,0,25)
FullGenTPTween.Position = dim2(0,4,0,175)
FullGenTPTween.BackgroundColor3 = c3(0.11,0.11,0.11)
FullGenTPTween.BorderColor3 = c3(0.05,0.05,0.05)
FullGenTPTween.BorderSizePixel = 1
FullGenTPTween.Text = "Gen full tween TP script"
FullGenTPTween.TextColor3 = c3(1,1,1)
FullGenTPTween.TextStrokeTransparency = 0
FullGenTPTween.Font = "SourceSans"
FullGenTPTween.TextSize = 19
FullGenTPTween.ZIndex = 5
FullGenTPTween.Parent = Menu

Close.MouseButton1Click:Connect(function() 
    screen:Destroy()
end)

do
    local tempcon
    TopBar.InputBegan:Connect(function(io) 
        if (io.UserInputType.Value == 0) then
            local root_pos = RootFrame.AbsolutePosition
            local start_pos = io.Position
            start_pos = vec2(start_pos.X, start_pos.Y)
            
            tempcon = serv_uis.InputChanged:Connect(function(io) 
                if (io.UserInputType.Value == 4) then
                    local curr_pos = io.Position
                    curr_pos = vec2(curr_pos.X, curr_pos.Y)
                    
                    local destination = root_pos + (curr_pos - start_pos)
                    RootFrame.Position = dim2off(destination.X, destination.Y)
                end
            end)
        end
    end)
    TopBar.InputEnded:Connect(function(io) 
        if (io.UserInputType.Value == 0) then
            tempcon:Disconnect()
        end
    end)
end

Copy.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.Position
    setclipboard("CFrame.new("..
        ("%.1f"):format(pos.X) .. ', ' ..
        ("%.1f"):format(pos.Y) .. ', ' ..
        ("%.1f"):format(pos.Z) .. ")"
    )
end)

GenTP.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.Position
    setclipboard("local plr = game.Players.LocalPlayer\nplr.Character.HumanoidRootPart.CFrame = CFrame.new("..
        ("%.1f"):format(pos.X) .. ', ' ..
        ("%.1f"):format(pos.Y) .. ', ' ..
        ("%.1f"):format(pos.Z) .. ")"
    )
end)

GenTPTween.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.Position
    setclipboard(
        "local tween = game:GetService('TweenService')\n"..
        "local plr = game.Players.LocalPlayer\n"..
        "local humrp = plr.Character.HumanoidRootPart\n\n"..
        "tween:Create(humrp, TweenInfo.new(1), {CFrame = CFrame.new("..
        
        
        ("%.1f"):format(pos.X) .. ', ' ..
        ("%.1f"):format(pos.Y) .. ', ' ..
        ("%.1f"):format(pos.Z) .. ")" .. 
        "}):Play()"
    )
end)




FullCopy.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.CFrame
    setclipboard("CFrame.new("..tostring(pos)..")")
end)

FullGenTP.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.CFrame
    setclipboard("local plr = game.Players.LocalPlayer\nplr.Character.HumanoidRootPart.CFrame = CFrame.new("..
        tostring(pos).. ")"
    )
end)

FullGenTPTween.MouseButton1Click:Connect(function() 
    local pos = l_plr.Character.HumanoidRootPart.CFrame
    setclipboard(
        "local tween = game:GetService('TweenService')\n"..
        "local plr = game.Players.LocalPlayer\n"..
        "local humrp = plr.Character.HumanoidRootPart\n\n"..
        "tween:Create(humrp, TweenInfo.new(1), {CFrame = CFrame.new("..
        
        tostring(pos)..
        ")}):Play()"
    )
end)


