--Simple example showing how a speed gui would work
--Check out the jeff_2_example-demo to see what more features look like

--Written while at school, may have syntax errors or similar.


local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

-- Window for the gui
local window = ui:NewWindow("Example Speed GUI", 400, 300)

-- Main menu
local menu = window:NewMenu("Modules")

local toggle = menu:NewToggle("Toggle")
local mode = menu:NewDropdown("Speed method", {"CFrame", "Walkspeed"})
local amount = menu:NewSlider("Speed amount", 1, 200, 16)


menu.OnEnable:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed")
    local _,idx = mode:GetSelection()
    
    if idx == 1 then --cframe
            
    elseif idx == 2 then --walkspeed
         
                
    end
end)

menu.OnDisable:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed")
end)

--Call ui:Ready() to finish everything off
ui:Ready()

ui.Exiting:Connect(function() 
    rs:UnbindFromRenderStep("Jeff2_ExampleSpeed") 
end)
