-- Made by topit
-- Update: switched to runservice deltatime method
if not game:IsLoaded() then game.Loaded:Wait() end

local rs = game:GetService("RunService")
local wait = task.wait
local floor = math.floor

local a = Instance.new("ScreenGui") do 
    a.IgnoreGuiInset = true
    a.DisplayOrder = 1500
    a.Name = 'av7n5317v9n19375'
    pcall(function() 
        syn.protect_gui(a)
    end)

    local _ = gethui or gethiddengui or get_hidden_gui
    _ = _ and _() or nil
    a.Parent = _ or game.CoreGui
end
local b = Instance.new("TextLabel")
b.TextStrokeColor3 = Color3.new(0,0,0)
b.TextStrokeTransparency = 0
b.Text = ''
b.Position = UDim2.new(1, -60, 1, -30)
b.Size = UDim2.fromOffset(50, 20)
b.BackgroundTransparency = 1
b.TextXAlignment = 'Right'
b.TextYAlignment = 'Bottom'
b.Font = "SourceSans"
b.TextScaled = true
b.Parent = a 

local delta = 0
do
    local rgbtime = 0
    local hsvfunc = Color3.fromHSV
    local rgbcon = rs.RenderStepped:Connect(function(dt) 
        delta = dt
        rgbtime = (rgbtime > 1 and rgbtime-1 or rgbtime)
        rgbtime += dt * 0.1

        b.TextColor3 = hsvfunc(rgbtime,1,1)
    end)
end



local fps = game:GetService("Stats").PerformanceStats.CPU
spawn(function()
    while true do
        b.Text = floor(1 / delta)
        wait(0.2)
    end
end)
