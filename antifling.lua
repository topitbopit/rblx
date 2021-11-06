local players = game:GetService("Players")
local rs = game:GetService("RunService")
local plr = players.LocalPlayer

local function FindFastChild(instance, name) 
    local a,b = pcall(function() return instance[name] end)
    
    return (a and b) or nil
end

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
ui:SetColors("nightshift")


local window = ui:NewWindow("Antifling", 275, 250)
local menu = window:NewMenu("Antifling",true)
local antifling = menu:NewToggle("Antifling")
local distance = menu:NewSlider("Sensitivity", 1, 15, 8)
local mode = menu:NewDropdown("Antifling type",{"Anchor","Noclip"})
menu:NewLabel()
menu:NewLabel()
menu:NewTrim()
menu:NewLabel("Made by topit")


local vector3 = Vector3.new

local connections = {}
do
    
    local triggerdist
    
    antifling.OnEnable:Connect(function() 
        local localhumrp = FindFastChild(plr.Character, "HumanoidRootPart")
        
        connections["resp"] = plr.CharacterAdded:Connect(function(c) 
            localhumrp = c:WaitForChild("HumanoidRootPart", 3)
        end)
        
        triggerdist = distance:GetValue()
        
        if mode:GetSelection() == "Anchor" then
            
            connections["among"] = rs.RenderStepped:Connect(function() 
                localhumrp.Anchored = false
                
                local players = players:GetPlayers()
                
                
                for i,v in ipairs(players) do
                    if v == plr then continue end
                    local nohumrp = FindFastChild(v.Character, "HumanoidRootPart")
                    if nohumrp then
                        local tdist = (nohumrp.Position - localhumrp.Position).Magnitude
                        if tdist < triggerdist then
                            localhumrp.Anchored = true
                        end 
                    end
                end
            end)
            
            
        else
            connections["among"] = rs.Stepped:Connect(function() 
                
                local players = players:GetPlayers()
                
                
                for i,v in ipairs(players) do
                    if v == plr then continue end
                    local nohumrp = FindFastChild(v.Character, "HumanoidRootPart")
                    if nohumrp then
                        local tdist = (nohumrp.Position - localhumrp.Position).Magnitude
                        if tdist < triggerdist then
                            for i,v in pairs(plr.Character:GetChildren()) do
                                if FindFastChild(v, "CanCollide") then
                                    v.CanCollide = false
                                    v.Velocity = vector3(0, 0, 0)
                                end
                            end
                        end 
                    end
                end
            end)
            
        end
    end)
    
    distance.OnValueChanged:Connect(function(val) 
        triggerdist = val
    end)
    
    antifling.OnDisable:Connect(function()
        connections["resp"]:Disconnect()
        connections["among"]:Disconnect()
        
        
        
        if FindFastChild(plr.Character, "HumanoidRootPart") then
            plr.Character.HumanoidRootPart.Anchored = false 
        end
    end)



    mode.OnSelection:Connect(function() 
        if antifling:GetState() == true then
            antifling:Disable()
            antifling:Enable()
        end
    end)
    
end

ui.Exiting:Connect(function() 
    for i,v in pairs(ui:GetAllToggles()) do
        if v:GetState() == true then v:Disable() end 
    end
    
    
    for i,v in ipairs(connections) do v:Disconnect() end
end)

ui:Ready()
