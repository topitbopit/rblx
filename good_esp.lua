local players = game:GetService("Players")
local replicated = game:GetService("ReplicatedStorage")
local rs = game:GetService("RunService")
local plr = players.LocalPlayer

local cframe = CFrame.new
local vector = Vector3.new
local vector2 = Vector2.new
local color3 = Color3.new


local wait = task.wait
local delay = task.delay
local spawn = task.spawn

local insert = table.insert
local remove = table.remove



local function FindFastChild(instance, name) 
    local a,b = pcall(function() return instance[name] end)
    
    return (a and b) or nil
end

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()


ui:SetColors("streamline")


local window = ui:NewWindow("Simple ESP", 225, 200)


local misc = window:NewMenu("ESP")

local esp_name = misc:NewToggle("Name ESP")
local esp_box = misc:NewToggle("Box ESP")
local lazyupdate = misc:NewToggle("Lazy update")



local name_objects = {}
local box_objects = {}
local esp_connections = {}



esp_name.OnEnable:Connect(function() 

    spawn(function()
        local norm = color3(0.9, 0.9, 0.9)
        
        for i,v in ipairs(players:GetPlayers()) do
            local a = Drawing.new("Text")
            a.Visible = true
            a.Color = norm
            a.Text = v.Name
            a.Outline = true
            a.OutlineColor = color3(0.1, 0.1, 0.11)
            a.Font = Drawing.Fonts.Plex
            name_objects[v.Name] = a
        end
        
        esp_connections["NP1"] = players.PlayerAdded:Connect(function(v) 
            wait(0.05)
            local a = Drawing.new("Text")
            a.Visible = true
            a.Color = norm
            a.Text = v.Name
            a.Outline = true
            a.OutlineColor = color3(0.1, 0.1, 0.11)
            a.Font = Drawing.Fonts.Plex
            
            name_objects[v.Name] = a
        end)
        
        local cam = workspace.CurrentCamera
        
        if not lazyupdate:IsEnabled() then
            while esp_name:IsEnabled() do
                for i,v in pairs(name_objects) do
                    local s, m = pcall(function()
                        local p = players[i]
                        local c = p.Character
                        local v2, visible = cam:WorldToViewportPoint(c.HumanoidRootPart.Position + vector(0, 4, 0))
                        
                        v.Visible = visible
                        v.Color = (p.TeamColor and p.TeamColor.Color) or norm
                        v.Position = vector2(v2.X - (v.TextBounds.X*0.5), v2.Y)
                    end)
                    
                    if not s then
                        if not FindFastChild(players, i) then
                            --v.Visible = false
                            v.Position = vector2(150, 500) --in case removing fails, move it here so i can tell it failed
                            v:Remove()
                            name_objects[i] = nil
                        else
                            v.Visible = false
                        end
                    end
                end
                rs.RenderStepped:Wait()
            end
        else
            while esp_name:IsEnabled() do
                for i,v in pairs(name_objects) do
                    local s, m = pcall(function()
                        local p = players[i]
                        local c = p.Character
                        local v2, visible = cam:WorldToViewportPoint(c.HumanoidRootPart.Position + vector(0, 4, 0))
                        
                        v.Visible = visible
                        v.Color = (p.TeamColor and p.TeamColor.Color) or norm
                        v.Position = vector2(v2.X - (v.TextBounds.X*0.5), v2.Y)
                    end)
                    
                    if not s then
                        if not FindFastChild(players, i) then
                            --v.Visible = false
                            v.Position = vector2(150, 500) --in case removing fails, move it here so i can tell it failed
                            v:Remove()
                            name_objects[i] = nil
                        else
                            v.Visible = false
                        end
                    end
                end
                wait(0.03)
            end
        end
    end)
end)

esp_name.OnDisable:Connect(function() 
    if esp_connections["NP1"] then esp_connections["NP1"]:Disconnect() end
    
    for i,v in pairs(name_objects) do
        v:Remove()
    end
    name_objects = {}
end)

esp_box.OnEnable:Connect(function() 

    spawn(function()
        local norm = color3(0.9, 0.9, 0.9)
        
        for i,v in ipairs(players:GetPlayers()) do
            local a = Drawing.new("Quad")
            a.Visible = true
            a.Color = norm
            a.Thickness = 3
            
            box_objects[v.Name] = a
        end
        
        esp_connections["NP2"] = players.PlayerAdded:Connect(function(v) 
            wait(0.05)
            local a = Drawing.new("Quad")
            a.Visible = true
            a.Color = norm
            a.Thickness = 3
            
            box_objects[v.Name] = a
        end)
        
        local cam = workspace.CurrentCamera
        
        if not lazyupdate:IsEnabled() then
            while esp_box:IsEnabled() do
                for i,v in pairs(box_objects) do
                    local s, m = pcall(function()
                        local p = players[i]
                        local pos0 = p.Character.HumanoidRootPart.CFrame
                        local pos1,pos2,pos3,pos4
                        
                        pos1, visible = cam:WorldToViewportPoint((pos0 * cframe(-2,3,0)).Position)
                        
                        if visible == true then
                            pos2 = cam:WorldToViewportPoint((pos0 * cframe(2,3,0)).Position)
                            pos3 = cam:WorldToViewportPoint((pos0 * cframe(2,-3,0)).Position)
                            pos4 = cam:WorldToViewportPoint((pos0 * cframe(-2,-3,0)).Position)
                            
                            v.PointA = vector2(pos1.X,pos1.Y)
                            v.PointB = vector2(pos2.X,pos2.Y)
                            v.PointC = vector2(pos3.X,pos3.Y)
                            v.PointD = vector2(pos4.X,pos4.Y)
                        end
                        
                        v.Visible = visible
                        v.Color = (p.TeamColor and p.TeamColor.Color) or norm
                        
                        
                    end)
                    
                    
                    if not s then
                        if not FindFastChild(players, i) then
                            v:Remove()
                            box_objects[i] = nil
                        else
                            v.Visible = false
                        end
                    end
                end
                rs.RenderStepped:Wait()
            end
        else
            while esp_box:IsEnabled() do
                for i,v in pairs(box_objects) do
                    local s, m = pcall(function()
                        local p = players[i]
                        local pos0 = p.Character.HumanoidRootPart.CFrame
                        local pos1,pos2,pos3,pos4
                        
                        pos1, visible = cam:WorldToViewportPoint((pos0 * cframe(-2,3,0)).Position)
                        
                        if visible == true then
                            pos2 = cam:WorldToViewportPoint((pos0 * cframe(2,3,0)).Position)
                            pos3 = cam:WorldToViewportPoint((pos0 * cframe(2,-3,0)).Position)
                            pos4 = cam:WorldToViewportPoint((pos0 * cframe(-2,-3,0)).Position)
                            
                            v.PointA = vector2(pos1.X,pos1.Y)
                            v.PointB = vector2(pos2.X,pos2.Y)
                            v.PointC = vector2(pos3.X,pos3.Y)
                            v.PointD = vector2(pos4.X,pos4.Y)
                        end
                        
                        v.Visible = visible
                        v.Color = (p.TeamColor and p.TeamColor.Color) or norm
                        
                        
                    end)
                    
                    
                    if not s then
                        if not FindFastChild(players, i) then
                            v:Remove()
                            box_objects[i] = nil
                        else
                            v.Visible = false
                        end
                    end
                end
                wait(0.05)
            end
        end
    end)
end)

esp_box.OnDisable:Connect(function() 
    if esp_connections["NP2"] then esp_connections["NP2"]:Disconnect() end
    
    for i,v in pairs(box_objects) do
        v:Remove()
    end
    box_objects = {}
end)




ui.Exiting:Connect(function() 
    for i,v in ipairs(ui:GetAllToggles()) do
        if v:GetState() == true then v:Disable() end 
    end
    
    for i,v in pairs(esp_connections) do
        v:Disconnect() 
    end
end)

ui:Ready()
