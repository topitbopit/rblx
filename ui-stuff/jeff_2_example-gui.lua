--Simple example showing how a speed gui would work
--Check out the jeff_2_example-demo to see what more features look like


-- { UI } --

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

-- Window for the gui
local window = ui:NewWindow("Example Speed GUI", 400, 300)

-- Main menu
local menu = window:NewMenu("Modules")

local toggle = menu:NewToggle("Speed")
local mode = menu:NewDropdown("Speed method", {"CFrame", "Walkspeed"})
local amount = menu:NewSlider("Speed amount", 1, 200, 16)

--Call ui:Ready() to finish everything off
ui:Ready()


-- { Vars } --

local players = game:GetService("Players")
local rs = game:GetService("RunService")
local plr = players.LocalPlayer



toggle.OnEnable:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed")
    local _,idx = mode:GetSelection()
    local chr = plr.Character
    
    if idx == 1 then --cframe
        rs:BindToRenderStep("Jeff2_ExampleSpeed", 2000, function() 
            pcall(function() 
                chr.HumanoidRootPart.CFrame = chr.HumanoidRootPart.CFrame + (((chr.Humanoid.MoveDirection*5)*amount:GetValue())*dt) -- move direction * 5 * value * deltatime
            end)    
        end)
    elseif idx == 2 then --walkspeed
        rs:BindToRenderStep("Jeff2_ExampleSpeed", 2000, function() 
            pcall(function() 
                chr.Humanoid.WalkSpeed = amount:GetValue()
            end)            
        end)       
    end
end)

toggle.OnDisable:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed")
end)


ui.Exiting:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed") 
end)
