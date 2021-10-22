if not game:IsLoaded() then game.Loaded:Wait() end


local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
ui:SetColors("nightshift")
local window = ui:NewWindow("Invis", 200, 150)
local menu = window:NewMenu("Invisibility")
local invisible = menu:NewToggle("Toggle")


local lighting = game:GetService("Lighting")
local runservice = game:GetService("RunService")
local players = game:GetService("Players")
local plr = players.LocalPlayer
local void = workspace.FallenPartsDestroyHeight

local rs_connection = nil
local die_connection = nil

local chr
local InvisChar


invisible.OnEnable:Connect(function() 
    
    
    chr = plr.Character
    chr.Archivable = true
    
    InvisChar = chr:Clone()
    InvisChar.Name = ""
    InvisChar.Parent = lighting
    
    rs_connection = runservice.Stepped:Connect(function() 
        pcall(function() 
            local e = tonumber(void)
            local pos = chr.HumanoidRootPart.Position
            if pos.Y <= void then
				plr.Character = chr
				
				chr.Parent = workspace
				chr["Humanoid"]:Destroy()

				InvisChar:Destroy()
				
				
				rs_connection:Disconnect()
            end
            
        end)
    end)
    
    die_connection = InvisChar["Humanoid"].Died:Connect(function() 
		plr.Character = chr
		wait()
		
		chr.Parent = workspace
		chr["Humanoid"]:Destroy()
		InvisChar:Destroy()
		
		
		rs_connection:Disconnect()
        
        die_connection:Disconnect()
            
    end)
    
	for i,v in pairs(InvisChar:GetDescendants())do
		if v:IsA("BasePart") then
			if v.Name == "HumanoidRootPart" then
				v.Transparency = 1
			else
				v.Transparency = .5
			end
		end
	end
    
    local camera = workspace.CurrentCamera
    local camera_cf = camera.CFrame
    local old_cf = chr.HumanoidRootPart.CFrame
    chr:MoveTo(Vector3.new(0, 3141593, 0))
    
    camera.CameraType = Enum.CameraType.Scriptable
    wait(0.2)
    camera.CameraType = Enum.CameraType.Custom
    
    chr.Parent = lighting
    InvisChar.Parent = workspace
    InvisChar.HumanoidRootPart.CFrame = old_cf
    
    plr.Character = InvisChar
    camera.CameraSubject = InvisChar.Humanoid
    
    InvisChar.Animate.Disabled = true
    wait()
    InvisChar.Animate.Disabled = false
end)

invisible.OnDisable:Connect(function()
    local oldpos = InvisChar.HumanoidRootPart.CFrame
    
    plr.Character = chr
	wait()
	
	chr.Parent = workspace
	chr["Humanoid"]:Destroy()
	
	InvisChar:Destroy()
	
	rs_connection:Disconnect()
    die_connection:Disconnect()
    
    plr.CharacterAdded:Wait()
    wait(0.1)
    plr.Character.HumanoidRootPart.CFrame = oldpos
end)

menu:NewLabel("Skidded off Infinite Yield by topit")
ui:Ready()