if not game:IsLoaded() then game.Loaded:Wait() end

local players = game:GetService("Players")
local ts = game:GetService("TweenService")
local plr = players.LocalPlayer

local vector3 = Vector3.new

local function find(instance, name) 
    local a,b = pcall(function() return instance[name] end)
    
    return (a and b) or nil
end

local function twn(object, dest, time)
    local tween = ts:Create(object, TweenInfo.new(time, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), dest)
    tween:Play()
    return tween
end

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

local offset = math.random(0,5)*0.01
local offset2 = offset + (math.random(0,2)*0.01)
ui:SetColors({
    window         = Color3.new(0.03+offset,0.03+offset,0.03+offset2);
    topbar         = Color3.new(0.04+offset,0.04+offset,0.04+offset2);
    text           = Color3.new(1.00,1.00,1.00);
    button         = Color3.new(0.12,0.12,0.13);
    scroll         = Color3.new(0.22,0.22,0.23);
    detail         = Color3.new(0.22,0.20,1.00);
    enabledbright  = Color3.new(0.41,0.40,0.80);
    enabled        = Color3.new(0.31,0.30,0.90);
    textshade1     = Color3.new(0.00,0.70,1.00);
    textshade2     = Color3.new(1.00,0.20,1.00);
})
ui.TooltipX = 25


local w = ui:NewWindow("la sociedad hbe", 360, 300) local m
  m = w:NewMenu("Self HBE",false)
    m:NewSection("Classic HBE (RootPart, Self)",true) m:NewTrim(true,true)
     local humrp_toggle = m:NewToggle("Enabled")
      humrp_toggle:SetTooltip("Toggles an expander for your rootpart")
     local humrp_size = m:NewSlider("Hitbox size",30,275,60)
      humrp_size:SetTooltip("Changes the expander size for your rootpart")
     local humrp_visible = m:NewToggle("Visible")
      humrp_visible:SetTooltip("Changes the visibility for your rootpart")
      
    m:NewSection("Custom HBE (Self)",true) m:NewTrim(true,true)
     local custom_toggle = m:NewToggle("Enabled")
      custom_toggle:SetTooltip("Toggles an expander for a specified part")
     local custom_size = m:NewSlider("Hitbox size",30,275,60)
      custom_size:SetTooltip("Changes the expander size for the specified part, retains original size when disabled")
     local custom_visible = m:NewToggle("Visible")
      custom_visible:SetTooltip("Changes the visibility for the specified part, retains original transparency when disabled")
     local custom_name = m:NewTextbox("Enter custom part name")
      custom_name:SetTooltip("Type in the part name (ex. \"left arm\") to expand that part. Type the name in quotes to disable fuzzy search (\"Head\" vs Head)")
    --m:NewSection("Settings (Self)",true) m:NewTrim(true,true)
    -- local massless = m:NewToggle("Massless hitboxes")
    --  massless:SetTooltip("Makes the hitbox less glitchy. Helps for games with custom jumping mechanics")
    m:NewSection("Made by topit")
    
    
  m = w:NewMenu("Other HBE",false)
    m:NewSection("Classic HBE (RootPart, Others)",true) m:NewTrim(true,true)
     local others_toggle = m:NewToggle("Enabled")
      others_toggle:SetTooltip("Toggles an expander for other players' rootpart")
     local others_size = m:NewSlider("Hitbox size",30,275,60)
      others_size:SetTooltip("Changes the expander size for other players' rootpart")
     local others_visible = m:NewToggle("Visible")
      others_visible:SetTooltip("Changes the visibility for other players' rootpart")
    m:NewSection("Made by topit")

ui:Ready()

local connections_self = {}
local connections_others = {}


-- SELF HBE

do
    -- define hitbox parts
    local plr_humrp
    local plr_custom
    local plr_customname
    local plr_custom_oldtrans
    local plr_custom_oldsize
    
    -- get respawn event and handle the stuff
    connections_self["chrhandle"] = plr.CharacterAdded:Connect(function(c) 
        plr_humrp = c:WaitForChild("HumanoidRootPart")
        
        if humrp_toggle:IsEnabled() then 
            humrp_toggle:Disable()
            humrp_toggle:Enable() 
        end
        
        if humrp_visible:IsEnabled() then 
            humrp_visible:Disable()
            humrp_visible:Enable() 
        end
        
        if plr_customname == nil then return end
        
        wait()
        
        plr_custom = nil
        do
            -- check for exact search
            local _1, _2, _3 = plr_customname:sub(1,1), plr_customname:sub(#plr_customname,#plr_customname+1), false
            -- if first and last character are both ' or " then enable exact
            if _1 == '"' and _2 == '"' then
                _3 = true
            elseif _1 == "'" and _2 == "'" then
                _3 = true
            end
            
            if _3 then
                -- if exact search then search for an exact match
                plr_customname = plr_customname:gsub('[\"\']', "")
                
                for _,part in ipairs(plr.Character:GetChildren()) do
                    if part.Name:lower() == plr_customname:lower() then
                        if find(part, "Transparency") and find(part, "Size") then
                            plr_custom = part
                            break
                        end
                    end
                end
                
                plr_customname = "'"..plr_customname.."'"
            else
                -- otherwise fuzzy search
                for _,part in ipairs(plr.Character:GetChildren()) do
                    if part.Name:lower():match(plr_customname) then
                        if find(part, "Transparency") and find(part, "Size") then
                            plr_custom = part
                            break
                        end
                    end
                end
            end
            
            -- check for part
            if plr_custom == nil then
                custom_name:SetText("Failed, couldn't find child")
            else
                if custom_toggle:IsEnabled() then 
                    custom_toggle:Disable()
                    custom_toggle:Enable() 
                end
                
                if custom_visible:IsEnabled() then 
                    custom_visible:Disable()
                    custom_visible:Enable() 
                end
                
                custom_name:SetText("Got "..plr_custom.Name)
            end
            -- les goo manual variable management
            _1,_2,_3 = nil
        end
    end)
    
    -- handle grabbing humrp
    do 
        local c = plr.Character
        if c then
            plr_humrp = c:WaitForChild("HumanoidRootPart")
        end
    end
    
    -- custom hitbox
    do
        custom_toggle.OnToggle:Connect(function(t) 
            
            if t then
                if plr_custom == nil then
                    ui:NewNotification("Oops","Select a part first (Enter custom part name)",4)
                    custom_toggle:Disable()
                    return
                end
                plr_custom_oldsize = plr_custom.Size
                twn(plr_custom, {Size = vector3(
                    custom_size:GetValue()*0.1, 
                    plr_custom_oldsize.Y, 
                    custom_size:GetValue()*0.1
                )}, 0.25)
            else
                twn(plr_custom, {Size = plr_custom_oldsize}, 0.25)
            end
        end)
        
        custom_size.OnValueChanged:Connect(function(v) 
            if custom_toggle:IsEnabled() then
                twn(plr_custom, {Size = vector3(v*0.1, plr_custom_oldsize.Y, v*0.1)}, 0.25)
            end
        end)
        
        custom_visible.OnToggle:Connect(function(t) 
            if t then 
                if plr_custom == nil then
                    ui:NewNotification("Oops","Select a part first (Enter custom part name)",4)
                    custom_visible:Disable()
                    return
                end
                
                plr_custom_oldtrans = plr_custom.Transparency
                twn(plr_custom, {Transparency = 0.3}, 0.25)
            else 
                if plr_custom then
                    twn(plr_custom, {Transparency = plr_custom_oldtrans}, 0.25)
                end
            end
        end)
        
        custom_name.OnFocusLost:Connect(function(text) 
            local old = plr_custom
            plr_custom = nil
            
            plr_customname = text:lower()
            
            -- check for exact search
            local _1, _2, _3 = plr_customname:sub(1,1), plr_customname:sub(#plr_customname,#plr_customname+1), false
            -- if first and last character are both ' or " then enable exact
            if _1 == '"' and _2 == '"' then
                _3 = true
            elseif _1 == "'" and _2 == "'" then
                _3 = true
            end
            
            if _3 then
                -- if exact search then search for an exact match
                plr_customname = plr_customname:gsub('[\"\']', "")
                
                for _,part in ipairs(plr.Character:GetChildren()) do
                    if part.Name:lower() == plr_customname:lower() then
                        if find(part, "Transparency") and find(part, "Size") then
                            plr_custom = part
                            break
                        end
                    end
                end
                
                plr_customname = "'"..plr_customname.."'"
            else
                -- otherwise fuzzy search
                for _,part in ipairs(plr.Character:GetChildren()) do
                    if part.Name:lower():match(plr_customname) then
                        if find(part, "Transparency") and find(part, "Size") then
                            plr_custom = part
                            break
                        end
                    end
                end
            end
            
            -- check for part
            if plr_custom == nil then
                custom_name:SetText("Failed, couldn't find child")
                plr_custom = old
            else
                if custom_toggle:IsEnabled() then 
                    custom_toggle:Disable()
                    custom_toggle:Enable() 
                end
                
                if custom_visible:IsEnabled() then 
                    custom_visible:Disable()
                    custom_visible:Enable() 
                end
                
                custom_name:SetText("Got "..plr_custom.Name)
            end
            -- les goo manual variable management
            old,_1,_2,_3 = nil
        end)
    end
    
    -- classic hitbox
    do
        humrp_toggle.OnToggle:Connect(function(t) 
            if t then 
                twn(plr_humrp, {Size = vector3(humrp_size:GetValue()*0.1, 2, humrp_size:GetValue()*0.1)}, 0.25)
            else
                twn(plr_humrp, {Size = vector3(2, 2, 1)}, 0.25)
            end
            
        end)
        
        humrp_size.OnValueChanged:Connect(function(v) 
            if humrp_toggle:IsEnabled() then
                twn(plr_humrp, {Size = vector3(v*0.1, 2, v*0.1)}, 0.25)
            end
        end)
        
        humrp_visible.OnToggle:Connect(function(t) 
            if t then 
                twn(plr_humrp, {Transparency = 0.3}, 0.25)
            else 
                twn(plr_humrp, {Transparency = 1.0}, 0.25)
            end
        end)
    end
    
    -- massless 
    do 
        --[[
        turns out setting Massless to true on the humrp just locks up your character
        so rip this idea
        
        
        massless.OnToggle:Connect(function(t) 
            if t then
                plr_humrp.Massless = true
                if plr_custom then
                    plr_custom.Massless = true
                end
                
                ui:NewNotification("Massless","Hitboxes are now massless",3)
            else
                plr_humrp.Massless = false
                if plr_custom then
                    plr_custom.Massless = false
                end
                ui:NewNotification("Massless","Disabled massless",3)
            end
        end)
        ]]
    end
end

-- OTHER HBE

do 
    others_toggle.OnEnable:Connect(function() 
        for _,p in ipairs(players:GetPlayers()) do
            if p == plr then continue end
            
            connections_others[p.Name] = p.CharacterAdded:Connect(function(c) 
                local humrp = c:WaitForChild("HumanoidRootPart",5)
                if others_toggle:IsEnabled() then
                    local v = others_size:GetValue()
                    twn(humrp, {Size = vector3(v*0.1, 2+(v*0.05), v*0.1)}, 0.25)
                end
                if others_visible:IsEnabled() then
                    twn(humrp, {Transparency = 0.3}, 0.25)
                end
            end)
            
            local humrp = find(p.Character, "HumanoidRootPart")
            if humrp then
                local v = others_size:GetValue()
                twn(humrp, {Size = vector3(v*0.1, 2+(v*0.05), v*0.1)}, 0.25)
                if others_visible:IsEnabled() then
                    twn(humrp, {Transparency = 0.3}, 0.25)
                end
            end
        end
        
        connections_others["newplr"] = players.PlayerAdded:Connect(function(p) 
            connections_others[p.Name] = p.CharacterAdded:Connect(function(c) 
                local humrp = c:WaitForChild("HumanoidRootPart",5)
                if others_toggle:IsEnabled() then
                    local v = others_size:GetValue()
                    twn(humrp, {Size = vector3(v*0.1, 2+(v*0.05), v*0.1)}, 0.25)
                end
                if others_visible:IsEnabled() then
                    twn(humrp, {Transparency = 0.3}, 0.25)
                end
            end)
        end)
        
        connections_others["oldplr"] = players.PlayerRemoving:Connect(function(p) 
            if connections_others[p.Name] then 
                connections_others[p.Name]:Disconnect() 
            end
        end)
    end)
        
    others_toggle.OnDisable:Connect(function() 
        connections_others["newplr"]:Disconnect()
        connections_others["oldplr"]:Disconnect()
        
        for pname,con in pairs(connections_others) do con:Disconnect() end
        
        for _,p in ipairs(players:GetPlayers()) do
            if p == plr then continue end
            
            local humrp = find(p.Character, "HumanoidRootPart")
            if humrp then
                twn(humrp, {Size = vector3(2, 2, 1)}, 0.25)
            end
        end
    end)
    
    others_visible.OnToggle:Connect(function(t) 
        if t then 
            for _,p in ipairs(players:GetPlayers()) do
                if p == plr then continue end
                
                local humrp = find(p.Character, "HumanoidRootPart")
                if humrp then
                    twn(humrp, {Transparency = 0.3}, 0.25)
                end
            end
        else
            for _,p in ipairs(players:GetPlayers()) do
                if p == plr then continue end
                
                local humrp = find(p.Character, "HumanoidRootPart")
                if humrp then
                    twn(humrp, {Transparency = 1}, 0.25)
                end
            end
        end
    end)
    
    others_size.OnFocusLost:Connect(function() 
        local v = others_size:GetValue()
        for _,p in ipairs(players:GetPlayers()) do
            if p == plr then continue end
            
            local humrp = find(p.Character, "HumanoidRootPart")
            print(humrp)
            if humrp then
                twn(humrp, {Size = vector3(v*0.1, 2+(v*0.05), v*0.1)}, 0.25)
            end
        end
    end)
end

ui.Exiting:Connect(function() 
    for i,v in ipairs(ui:GetAllToggles()) do
        if v:IsEnabled() then v:Disable() end 
    end
    
    for name,con in pairs(connections_self) do con:Disconnect() end
    for plr,con in pairs(connections_others) do con:Disconnect() end
end)


