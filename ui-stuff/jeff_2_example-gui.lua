--Simple example showing how a speed gui would work
--Check out the jeff_2_example-demo to see what more features look like


-- { UI } --

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

-- Window for the gui
local window = ui:NewWindow("Simple Speed", 400, 300)

-- Main menu
local menu = window:NewMenu("Stuff")

local toggle = menu:NewToggle("Speed toggle")
local amount = menu:NewSlider("Speed amount", 1, 200, 16)
local mode = menu:NewDropdown("Speed method", {"CFrame", "Walkspeed"})
local hook = menu:NewButton("Metatable hook")
--Call ui:Ready() to finish everything off
ui:Ready()


-- { Vars } --

local players = game:GetService("Players")
local rs = game:GetService("RunService")
local plr = players.LocalPlayer



toggle.OnEnable:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed")
    local type,idx = mode:GetSelection()
    local chr = plr.Character
    
    if type == "CFrame" then --cframe
        rs:BindToRenderStep("Jeff2_ExampleSpeed", 2000, function(dt) 
            
            pcall(function() 
                local h = chr.HumanoidRootPart
                h.CFrame = h.CFrame + ((chr.Humanoid.MoveDirection*5*amount:GetValue())*dt) -- move direction * 5 * value * deltatime
            end)    
        end)
    elseif type == "Walkspeed" then --walkspeed
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

hook.OnClick:Connect(function() 
    local old
    old = hookmetamethod(game, "__index", function(...) 
        local h, w = ...
        if w == "Walkspeed" and h.ClassName == "Humanoid" and h.Parent == plr.Character then
            return 16
        end
        return old(...)
    end)
    hook:Hide("Hook enabled")
end)

ui.Exiting:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed") 
end)
