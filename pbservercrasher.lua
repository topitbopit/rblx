if not game:IsLoaded() then game.Loaded:Wait() end



local plrs    = game:GetService("Players")
local ts      = game:GetService("TweenService")
local rs      = game:GetService("RunService")
local ctx     = game:GetService("ContextActionService")
local uis     = game:GetService("UserInputService")

local plr = plrs.LocalPlayer
local con = {}


local function twn(object, dest, delay, direction, style)
    delay = delay or 0.2
    direction = direction or "Out"
    style = style or "Exponential"
    
    local tween = ts:Create(object, TweenInfo.new(delay, Enum.EasingStyle[style], Enum.EasingDirection[direction]), dest)
    tween:Play()
    return tween
end

local function tl(parent, max, min) 
    local a = Instance.new("UITextSizeConstraint")
    a.MaxTextSize = max or 19
    a.MinTextSize = min or 5
    a.Parent = parent
end

local function p(parent, h)
    local a = Instance.new("UIPadding")
    a.Parent = parent
    a.PaddingTop = UDim.new(0, h)
end


local s = Instance.new("ScreenGui")
s.Name = "pblagger"
s.Parent = game.CoreGui

if game.PlaceId ~= 1758401491 then
    local a = Instance.new("Frame")
    a.Size = UDim2.new(0, 200, 0, 100)
    a.Position = UDim2.new(0, 100, 1, 200)
    a.BorderSizePixel = 0
    a.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    a.Parent = s
    
    local b = Instance.new("Frame")
    b.Size = UDim2.new(1, 0, 0, 25)
    b.Position = UDim2.new(0, 0, 0, 0)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
    b.Active = true
    b.Parent = a
    
    local c = Instance.new("TextButton")
    c.Text = "x"
    c.TextSize = 24
    c.TextColor3 = Color3.new(1, 1, 1)
    c.Size = UDim2.new(0, 25, 0, 25)
    c.Position = UDim2.new(1, -25, 0, 0)
    c.TextXAlignment = Enum.TextXAlignment.Center
    c.BackgroundTransparency = 0
    c.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
    c.BorderSizePixel = 0
    c.Font = Enum.Font.SourceSansLight
    c.Parent = b
    
    
    local title = Instance.new("TextLabel")
    title.Text = "wrong game"
    title.TextScaled = true
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, 0, 0.9, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansLight
    title.Parent = b
    
    
    
    c.MouseButton1Click:Connect(function() 
        s:Destroy()
    end)
    
    
    twn(a, {Position = UDim2.new(0, 100, 1, -200)})
    
    
    b.InputBegan:Connect(function(input1)
        local position = a.Position
        if input1.UserInputType == Enum.UserInputType.MouseButton1 then
            con["Dragging"] = uis.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = (input2.Position - input1.Position)
                    
                    twn(a, {Position = UDim2.new(
                        position.X.Scale, 
                        position.X.Offset + delta.X, 
                        position.Y.Scale, 
                        position.Y.Offset + delta.Y
                        )}, 0.25, "Out", "Circular")
                end
            end)
        end
    end)
    
    b.InputEnded:Connect(function(input1)
        if input1.UserInputType == Enum.UserInputType.MouseButton1 then
            con["Dragging"]:Disconnect()
        end
    end) 
    
    return 
end

local a = Instance.new("Frame")
a.Size = UDim2.new(0, 225, 0, 275)
a.Position = UDim2.new(0, 0, 1, -285)
a.BorderSizePixel = 0
a.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
a.Parent = s

local b = Instance.new("Frame")
b.Size = UDim2.new(1, 0, 0, 25)
b.Position = UDim2.new(0, 0, 0, 0)
b.BorderSizePixel = 0
b.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
b.Active = true
b.Parent = a

local c = Instance.new("TextButton")
c.Text = "x"
c.TextSize = 24
c.TextColor3 = Color3.new(1, 1, 1)
c.Size = UDim2.new(0, 25, 0, 25)
c.Position = UDim2.new(1, -25, 0, 0)
c.TextXAlignment = Enum.TextXAlignment.Center
c.BackgroundTransparency = 0
c.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
c.BorderSizePixel = 0
c.Font = Enum.Font.SourceSansLight
c.Parent = b

local d = Instance.new("ScrollingFrame")
d.Size = UDim2.new(1, 0, 1, -25)
d.Position = UDim2.new(0, 0, 0, 25)
d.BackgroundTransparency = 1
d.ScrollBarThickness = 0
d.ScrollBarImageTransparency = 0.8
d.BorderSizePixel = 0
d.ScrollBarImageColor3 = Color3.fromRGB(248, 248, 250)
d.CanvasSize = UDim2.new(0, 0, 1.1, 0)
d.Parent = a


local title = Instance.new("TextLabel")
title.Text = "public bathroom lagger"
title.TextScaled = true
title.TextColor3 = Color3.new(1, 1, 1)
title.Size = UDim2.new(1, 0, 0.9, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.SourceSansLight
title.Parent = b


local progress_t = Instance.new("TextLabel")
progress_t.Text = "ready"
progress_t.TextScaled = true
progress_t.TextColor3 = Color3.new(1, 1, 1)
progress_t.Size = UDim2.new(1, -20, 0, 20)
progress_t.Position = UDim2.new(0, 10, 0, 10)
progress_t.TextXAlignment = Enum.TextXAlignment.Center
progress_t.BackgroundTransparency = 1
progress_t.Font = Enum.Font.SourceSansLight
progress_t.Parent = d

local progress_1 = Instance.new("Frame")
progress_1.Size = UDim2.new(1, -20, 0, 5)
progress_1.Position = UDim2.new(0, 10, 0, 35)
progress_1.BackgroundTransparency = 0
progress_1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
progress_1.BorderSizePixel = 0
progress_1.ClipsDescendants = true
progress_1.Parent = d

local progress_2 = Instance.new("Frame")
progress_2.Size = UDim2.new(1, 0, 1, 0)
progress_2.Position = UDim2.new(0, 0, 0, 0)
progress_2.BackgroundTransparency = 0
progress_2.BorderSizePixel = 0
progress_2.BackgroundColor3 = Color3.new(0.1, 1, 0.1)
progress_2.ClipsDescendants = true
progress_2.Parent = progress_1


local trim1 = Instance.new("Frame")
trim1.Size = UDim2.new(1, -20, 0, 1)
trim1.Position = UDim2.new(0, 10, 0, 50)
trim1.BackgroundTransparency = 0
trim1.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
trim1.BorderSizePixel = 0
trim1.ClipsDescendants = true
trim1.Parent = d

local crash = Instance.new("TextButton")
crash.Text = "lag server"
crash.TextScaled = true
crash.TextColor3 = Color3.new(1, 1, 1)
crash.Size = UDim2.new(1, -20, 0, 20)
crash.Position = UDim2.new(0, 10, 0, 60)
crash.TextXAlignment = Enum.TextXAlignment.Center
crash.BackgroundTransparency = 0
crash.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
crash.BorderSizePixel = 0
crash.Font = Enum.Font.SourceSansLight
crash.AutoButtonColor = false
crash.Parent = d

local trim2 = Instance.new("Frame")
trim2.Size = UDim2.new(1, -20, 0, 1)
trim2.Position = UDim2.new(0, 10, 0, 90)
trim2.BackgroundTransparency = 0
trim2.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
trim2.BorderSizePixel = 0
trim2.ClipsDescendants = true
trim2.Parent = d

local loud = Instance.new("TextButton")
loud.Text = "loud mode"
loud.TextScaled = true
loud.TextColor3 = Color3.new(1, 1, 1)
loud.Size = UDim2.new(1, -45, 0, 20)
loud.Position = UDim2.new(0, 10, 0, 100)
loud.TextXAlignment = Enum.TextXAlignment.Center
loud.BackgroundTransparency = 0
loud.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
loud.BorderSizePixel = 0
loud.Font = Enum.Font.SourceSansLight
loud.AutoButtonColor = false
loud.Parent = d

local loud_que = Instance.new("TextButton")
loud_que.Text = "?"
loud_que.TextScaled = true
loud_que.TextColor3 = Color3.new(1, 1, 1)
loud_que.Size = UDim2.new(0, 20, 0, 20)
loud_que.Position = UDim2.new(1, -30, 0, 100)
loud_que.TextXAlignment = Enum.TextXAlignment.Center
loud_que.BackgroundTransparency = 0
loud_que.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
loud_que.BorderSizePixel = 0
loud_que.Font = Enum.Font.SourceSansLight
loud_que.AutoButtonColor = true
loud_que.Parent = d

local fps = Instance.new("TextButton")
fps.Text = "prevent client lag"
fps.TextScaled = true
fps.TextColor3 = Color3.new(1, 1, 1)
fps.Size = UDim2.new(1, -45, 0, 20)
fps.Position = UDim2.new(0, 10, 0, 125)
fps.TextXAlignment = Enum.TextXAlignment.Center
fps.BackgroundTransparency = 0
fps.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
fps.BorderSizePixel = 0
fps.Font = Enum.Font.SourceSansLight
fps.AutoButtonColor = false
fps.Parent = d

local fps_que = Instance.new("TextButton")
fps_que.Text = "?"
fps_que.TextScaled = true
fps_que.TextColor3 = Color3.new(1, 1, 1)
fps_que.Size = UDim2.new(0, 20, 0, 20)
fps_que.Position = UDim2.new(1, -30, 0, 125)
fps_que.TextXAlignment = Enum.TextXAlignment.Center
fps_que.BackgroundTransparency = 0
fps_que.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
fps_que.BorderSizePixel = 0
fps_que.Font = Enum.Font.SourceSansLight
fps_que.AutoButtonColor = true
fps_que.Parent = d

local payload = Instance.new("TextBox")
payload.Text = "lag amount: 200"
payload.TextScaled = true
payload.TextColor3 = Color3.new(1, 1, 1)
payload.Size = UDim2.new(1, -20, 0, 20)
payload.Position = UDim2.new(0, 10, 0, 150)
payload.TextXAlignment = Enum.TextXAlignment.Center
payload.BackgroundTransparency = 0
payload.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
payload.BorderSizePixel = 0
payload.Font = Enum.Font.SourceSansLight
payload.ClearTextOnFocus = true
payload.Parent = d

local trim3 = Instance.new("Frame")
trim3.Size = UDim2.new(1, -20, 0, 1)
trim3.Position = UDim2.new(0, 10, 0, 180)
trim3.BackgroundTransparency = 0
trim3.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
trim3.BorderSizePixel = 0
trim3.ClipsDescendants = true
trim3.Parent = d

local cred = Instance.new("TextLabel")
cred.Text = "made by topit; v1.0.0"
cred.TextScaled = true
cred.TextColor3 = Color3.new(1, 1, 1)
cred.Size = UDim2.new(1, -20, 0, 20)
cred.Position = UDim2.new(0, 10, 0, 185)
cred.TextXAlignment = Enum.TextXAlignment.Left
cred.TextYAlignment = Enum.TextYAlignment.Top
cred.BackgroundTransparency = 1
cred.Font = Enum.Font.SourceSansLight
cred.Parent = d

local discord = Instance.new("TextButton")
discord.Text = "click to copy discord inv"
discord.TextScaled = true
discord.TextColor3 = Color3.new(1, 1, 1)
discord.Size = UDim2.new(1, -20, 0, 20)
discord.Position = UDim2.new(0, 10, 0, 210)
discord.TextXAlignment = Enum.TextXAlignment.Center
discord.BackgroundTransparency = 0
discord.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
discord.BorderSizePixel = 0
discord.Font = Enum.Font.SourceSansLight
discord.AutoButtonColor = true
discord.Parent = d


tl(title)
tl(fps)
tl(fps_que)
tl(payload)
tl(loud)
tl(loud_que)
tl(cred)
tl(discord)


b.InputBegan:Connect(function(input1)
    local position = a.Position
    if input1.UserInputType == Enum.UserInputType.MouseButton1 then
        con["Dragging"] = uis.InputChanged:Connect(function(input2)
            if input2.UserInputType == Enum.UserInputType.MouseMovement then
                local delta = (input2.Position - input1.Position)
                
                twn(a, {Position = UDim2.new(
                    position.X.Scale, 
                    position.X.Offset + delta.X, 
                    position.Y.Scale, 
                    position.Y.Offset + delta.Y
                    )}, 0.25, "Out", "Circular")
            end
        end)
    end
end)

b.InputEnded:Connect(function(input1)
    if input1.UserInputType == Enum.UserInputType.MouseButton1 then
        con["Dragging"]:Disconnect()
    end
end) 

-----------

local function progress(text, timing)
    progress_t.Text = text
    progress_2.Size = UDim2.new(0, 0, 1, 0)
    twn(progress_2, {Size = UDim2.new(1, 0, 1, 0)}, timing, "Out", "Linear")
end

local function msgbox(text1, text2) 
    local a = Instance.new("Frame")
    a.Size = UDim2.new(0, 200, 0, 100)
    a.Position = UDim2.new(0, 100, 1, 200)
    a.BorderSizePixel = 0
    a.BackgroundColor3 = Color3.fromRGB(22, 22, 24)
    a.Parent = s
    
    local b = Instance.new("Frame")
    b.Size = UDim2.new(1, 0, 0, 25)
    b.Position = UDim2.new(0, 0, 0, 0)
    b.BorderSizePixel = 0
    b.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
    b.Active = true
    b.Parent = a
    
    local c = Instance.new("TextButton")
    c.Text = "x"
    c.TextSize = 24
    c.TextColor3 = Color3.new(1, 1, 1)
    c.Size = UDim2.new(0, 25, 0, 25)
    c.Position = UDim2.new(1, -25, 0, 0)
    c.TextXAlignment = Enum.TextXAlignment.Center
    c.BackgroundTransparency = 0
    c.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
    c.BorderSizePixel = 0
    c.Font = Enum.Font.SourceSansLight
    c.Parent = b
    
    
    local title = Instance.new("TextLabel")
    title.Text = text1
    title.TextScaled = true
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Size = UDim2.new(1, 0, 0.9, 0)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.SourceSansLight
    title.Parent = b
    
    
    local text = Instance.new("TextLabel")
    text.Text = text2
    text.TextScaled = true
    text.TextColor3 = Color3.new(1, 1, 1)
    text.Size = UDim2.new(1, -20, 0, 60)
    text.Position = UDim2.new(0, 10, 0, 30)
    text.TextXAlignment = Enum.TextXAlignment.Center
    text.BackgroundTransparency = 1
    text.Font = Enum.Font.SourceSansLight
    text.Parent = a
    
    tl(text)
    tl(title)
    
    c.MouseButton1Click:Connect(function() 
        a:Destroy()
    end)
    
    
    
    
    b.InputBegan:Connect(function(input1)
        local position = a.Position
        if input1.UserInputType == Enum.UserInputType.MouseButton1 then
            con["Dragging"] = uis.InputChanged:Connect(function(input2)
                if input2.UserInputType == Enum.UserInputType.MouseMovement then
                    local delta = (input2.Position - input1.Position)
                    
                    twn(a, {Position = UDim2.new(
                        position.X.Scale, 
                        position.X.Offset + delta.X, 
                        position.Y.Scale, 
                        position.Y.Offset + delta.Y
                        )}, 0.25, "Out", "Circular")
                end
            end)
        end
    end)
    
    b.InputEnded:Connect(function(input1)
        if input1.UserInputType == Enum.UserInputType.MouseButton1 then
            con["Dragging"]:Disconnect()
        end
    end) 
    
    
    twn(a, {Position = UDim2.new(0, 100, 1, -200)})
    
end

-------------

local loud_mode = false
local amount = 200
local keep_fps = false

local lagging = false


crash.MouseButton1Click:Connect(function() 
    if lagging then 
        msgbox("Can't do that", "Already lagging server")
        return 
    end
    
    if not amount then 
        msgbox("Uh oh", "Couldn't grab lag amount. Re-enter in the textbox")
        return 
    end
    
    if not fireclickdetector then
        msgbox("Uh oh", "Your exploit doesn't support this script")
        return 
    end
    
    if not plr.Character then
        msgbox("Uh oh", "You aren't spawned in")
        return 
    end
    
    local err = false
    lagging = true
    twn(crash, {BackgroundColor3 = Color3.fromRGB(229, 229, 227), TextColor3 = Color3.new(0, 0, 0)}) 
    
    local cds = {}
    progress("fetching items", 0.2)
    wait()
    do
        if not loud_mode then
            local a = pcall(function()
                table.insert(cds, workspace["Trash can"]["Trash"]["Can"]["ClickDetector"])
            end)

            if not a then
                msgbox("Uh oh","Couldn't get trash can properly. Switching servers may fix") 
                progress("something went wrong", 0)
                lagging = false
                twn(crash, {BackgroundColor3 = Color3.fromRGB(26, 26, 28), TextColor3 = Color3.new(1, 1, 1)}) 
                err = nil
                cds = nil
                return 
            end
        else 
            for i,v in pairs(workspace:GetDescendants()) do
                if v:IsA("ClickDetector") then
                    table.insert(cds, v)
                end
            end
        end
    end
    
    local del = 0.5 + (amount / 300)
    if loud_mode then
        del = del + 0.5
    end
    progress("getting items", del)
    
    for i = 1, amount do
        for i,v in pairs(cds) do
            fireclickdetector(v) 
        end
    end
    wait(del)
    
    progress("waiting until finish", 1.4)
    for i = 1, 35 do
        local amnt1 = #plr.Backpack:GetChildren()
        wait(0.4)
        local amnt2 = #plr.Backpack:GetChildren()
        if amnt2 == amnt1 then break end
    end
    
    wait()
    progress("glitching items", 4 + (#plr.Backpack:GetChildren() / 300))
    
    cds = {}
	for _,v in pairs(plr.Backpack:GetChildren()) do
	    if v:IsA("Tool") then
	        table.insert(cds, v)
	    end
	end
	for i,v in pairs(cds) do
	    v.Parent = plr.Character
	    if i % 10 == 0 then 
	        task.wait(0.0001) 
	    end
	end
	for i,v in pairs(cds) do
	    v.Parent = workspace
	    if i % 10 == 0 then 
	        task.wait(0.0001) 
	    end
	end
    
    progress("lagging server", 0.6)
    plr.Character.Humanoid.Health = 0
    wait(0.5)
    if keep_fps then
        wait(1.3)
        progress("preventing client lag", 0.5)
        for _,v in pairs(cds) do
            v:Destroy()
        end
        wait(0.3)
    end
    
    progress("waiting for respawn", 0)
    plr.CharacterAdded:Wait()
    progress_t.Text = "ready"
    cds = nil
    twn(crash, {BackgroundColor3 = Color3.fromRGB(26, 26, 28), TextColor3 = Color3.new(1, 1, 1)}) 
    lagging = false
end)

loud.MouseButton1Click:Connect(function() 
    if lagging then return end
    loud_mode = not loud_mode
    if loud_mode then
        progress("loud mode enabled", 0.1)
        twn(loud, {BackgroundColor3 = Color3.fromRGB(229, 229, 227), TextColor3 = Color3.new(0, 0, 0)}) 
    else
        progress("loud mode disabled", 0.1)
        twn(loud, {BackgroundColor3 = Color3.fromRGB(26, 26, 28), TextColor3 = Color3.new(1, 1, 1)}) 
    end
end)

fps.MouseButton1Click:Connect(function() 
    if lagging then return end
    keep_fps = not keep_fps
    if keep_fps then
        progress("nolag enabled", 0.1)
        twn(fps, {BackgroundColor3 = Color3.fromRGB(229, 229, 227), TextColor3 = Color3.new(0, 0, 0)}) 
    else
        progress("nolag disabled", 0.1)
        twn(fps, {BackgroundColor3 = Color3.fromRGB(26, 26, 28), TextColor3 = Color3.new(1, 1, 1)}) 
    end
end)

fps_que.MouseButton1Click:Connect(function() 
    msgbox("Info", "Saves fps (deletes tools after a delay). May prevent others from render lag!!")
end)

loud_que.MouseButton1Click:Connect(function() 
    msgbox("Info", "Spams noises when enabled, creating even more lag")
end)

discord.MouseButton1Click:Connect(function() 
    setclipboard("https://discord.gg/a3JEr9Z6jY")
    msgbox("Thank you!","Copied invite")
end)

payload.FocusLost:Connect(function() 
    local txt = payload.Text:gsub("%s","")
    local num = pcall(function() txt = txt + 0 end)
    if num == false then
        payload.Text = "not a number" 
        amount = nan
    else
        amount = tonumber(txt)
        if amount > 1234 then
            amount = 1234
        elseif amount < 150 then
            amount = 150 
        end
        payload.Text = "lag amount: "..amount
        progress("lag amount set to "..amount, 0.1)
    end
end)



c.MouseButton1Click:Connect(function() 
    s:Destroy()
    for i,v in pairs(con) do
        v:Disconnect()
    end
end)