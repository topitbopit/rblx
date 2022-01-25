local display_size = 90

-- Velocity viewer
-- Made by topit
-- Should work in most games except for ones w/ custom characters



local floor = math.floor

if not game:IsLoaded() then game.Loaded:Wait() end

local rs = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer


local txt
do
    local a = Instance.new("ScreenGui")
    a.IgnoreGuiInset = true
    a.DisplayOrder = 1500
    syn.protect_gui(a)
    a.Parent = game.CoreGui
    
    txt = Instance.new("TextLabel")
    txt.TextStrokeColor3 = Color3.new(0,0,0)
    txt.TextStrokeTransparency = 0
    txt.Text = ""
    txt.BackgroundTransparency = 0.9
    txt.BorderSizePixel = 1
    txt.BorderColor3 = Color3.new(0.1,0.1,0.1)
    txt.BackgroundColor3 = Color3.new(0,0,0)
    txt.Position = UDim2.new(1, -(display_size+10), 1, -(display_size+10))
    txt.Size = UDim2.fromOffset(display_size, display_size)
    txt.TextXAlignment = "Left"
    txt.Font = "SourceSans"
    txt.RichText = true
    txt.TextScaled = true
    txt.Parent = a 
end
do
    local _0 = 0
    local _1 = Color3.fromHSV
    local _2 = rs.RenderStepped:Connect(function(dt) 
        _0 = (_0 > 1 and 0 or _0 + dt*.1)
        txt.TextColor3 = _1(_0,1,1)
        
    end)
end



local humrp,hum

local function bind() 
    rs:BindToRenderStep("updateVelocity",2000,function() 
        local vel = humrp.Velocity
        if (floor(vel.Magnitude) == 0) then
            txt.Text = "<u>Velocity</u>\nX: 0.00\nY: 0.00\nZ: 0.00"
            return    
        end
        txt.Text = ("<u>Velocity</u>\nX: %.2f\nY: %.2f\nZ: %.2f"):format(vel.X,vel.Y,vel.Z)
    end)
end

local function hook(c) 
    humrp = c:WaitForChild("HumanoidRootPart",0.5)
    hum = c:WaitForChild("Humanoid",0.5)
    
    hum.Died:Connect(function() 
        rs:UnbindFromRenderStep("updateVelocity")
        txt.Text = "Waiting for respawn..."
        plr.CharacterAdded:Wait()
        bind()
    end)
    
    if (humrp) then
        bind()
    end
end


plr.CharacterAdded:Connect(hook)
hook(plr.Character)

