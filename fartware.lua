--[[fartware]]--
--[[made by topit]]--

local sc = Instance.new("ScreenGui")
sc.Parent = game.CoreGui
sc.Name = "Fartware"

local count = 0 

local function Async(e)
    coroutine.resume(coroutine.create(e))
end

local function NewLabel(text)
    local txt = Instance.new("TextLabel")
    txt.Font = Enum.Font.Nunito
    txt.Text = text.." got farded ("..tostring(count)..")"
    txt.Size = UDim2.new(0, 150, 0, 50)
    txt.Parent = sc
    txt.Position = UDim2.new(math.random(1,90)/100, 0, math.random(1,85)/100, 0)
    txt.TextSize = 30
    txt.TextColor3 = Color3.fromRGB(math.random(100,255), math.random(100,255), math.random(100,255))
    txt.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    txt.TextStrokeTransparency = 0
    txt.BackgroundTransparency = 1
    
    return txt
end


local function Fard(chr)
    count = count + 1
    local text = NewLabel(chr.Name)
    
    local gay = Instance.new("Sound")
    
    gay.Parent = game.Workspace
    pcall(function() gay.Parent = chr.HumanoidRootPart end)
    gay.SoundId = "rbxassetid://6731548686"
    gay.RollOffMode = Enum.RollOffMode.Linear
    gay.Volume = 2
    gay.RollOffMaxDistance = 5000
    gay.RollOffMinDistance = 50
    gay.TimePosition = 0.4
    
    wait(0.1)
    gay:Play()
    
    wait(1.5)
    
    gay:Destroy()
    text:Destroy()
end

local function HookCharacter(chr)
    chr["Humanoid"].Died:Connect(function()
        Async(function() Fard(chr) end)
    end)
end

local function HookPlayer(plr)
    plr.CharacterAdded:Connect(function(chr) 
        wait(0.2)
        HookCharacter(chr)
    end)
end

game.Players.PlayerAdded:connect(function(plr) 
    HookPlayer(plr)    
    
end)
for i,v in pairs(game.Players:GetChildren()) do
    HookPlayer(v)
    if pcall(function() return v.Character.Head end) then
        HookCharacter(v.Character) 
    end
end

