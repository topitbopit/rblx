-- Velocity viewer
-- Made by topit
-- Should work in more games


-- Settings

local display_size = 90
local rgb_display = false


-- Actual code

local floor = math.floor

if not game:IsLoaded() then game.Loaded:Wait() end
local rs = game:GetService("RunService")
local plr = game:GetService("Players").LocalPlayer


local txt
do
	-- Make a screengui with protection
    local a = Instance.new("ScreenGui")
    a.IgnoreGuiInset = true
    a.DisplayOrder = 1500
    pcall(function()
        syn.protect_gui(a)
    end)
    a.Parent = gethui and gethui() or game.CoreGui
    
	-- Make a textlabel 
    txt = Instance.new("TextLabel")
    txt.TextStrokeColor3 = Color3.new(0,0,0)
    txt.TextStrokeTransparency = 0
    txt.Text = ""
    txt.BackgroundTransparency = 0.9
    txt.BorderSizePixel = 1
    txt.BorderColor3 = Color3.new(0.1,0.1,0.1)
    txt.BackgroundColor3 = Color3.new(0,0,0)
    txt.Position = UDim2.new(1, -(display_size+10), 1, -((display_size-40)+10))
    txt.Size = UDim2.fromOffset(display_size, display_size-40)
    txt.TextXAlignment = "Left"
    txt.Font = "SourceSans"
    txt.RichText = true
    txt.TextScaled = true
    txt.Parent = a 
end

-- Handles RGB display
if (rgb_display) then
    local _0 = 0 -- Color value
    local _1 = Color3.fromHSV -- Color function
    local _2 = rs.RenderStepped:Connect(function(dt) 
        -- If color value > 1 then make it 0
		-- Otherwise add the deltatime * 0.1 to the value
		_0 = (_0 > 1 and 0 or _0 + dt*.1)

		-- Set the textcolor to this hsv value
        txt.TextColor3 = _1(_0,1,1)
    end)
end


local humrp

-- Unbinds the velocity viewer
local function unbind() 
	rs:UnbindFromRenderStep("updateVelocity")
end

-- Binds the velocity viewer to the render step
-- i.e. every frame update velocity text
local function bind()
    rs:BindToRenderStep("updateVelocity",2000,function() 
        local vel = humrp.Velocity

		-- Low amounts of magnitude may display janky so just show 0 manually
        if (floor(vel.Magnitude) == 0) then
            txt.Text = "Velocity:\n0"
            return    
        end

		-- Shows the velocity with 3 decimal precision
		-- 0.135813958135 would go to 0.135
        txt.Text = ("Velocity:\n%.3f"):format(vel.Magnitude)
    end)
end

-- Handles a character being spawned
-- Waits for the needed part then binds the velocity viewer
-- If it cant get the root part then it warns in console
local function hook(c) 
	humrp = c:WaitForChild("HumanoidRootPart",1)
	if (humrp) then
		bind()
	else
		txt.Text = "Check console!"
		warn("Something went wrong!")
		warn("Couldn't get humanoidootpart!")
		warn("Whatever game you're testing on likely")
		warn("uses a custom character system and")
		warn("requires special support")
	end
end

-- Handles the character being removed
-- Unbinds the velocity updater
plr.CharacterRemoving:Connect(function() 
	unbind()
	txt.Text = "Waiting for respawn"
end)
plr.CharacterAdded:Connect(hook)



-- Hook the current player character
-- so waiting for a respawn isnt needed 
hook(plr.Character)
