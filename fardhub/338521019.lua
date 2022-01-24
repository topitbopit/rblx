
-- library
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_3/main.lua'))()

-- services
local serv_players = game:GetService("Players")
local serv_rs = game:GetService("RunService")

-- events 
local ev_rs_stepped = serv_rs.Stepped
local ev_rs_rstepped = serv_rs.RenderStepped

-- micro ops
local ins = table.insert
local rem = table.remove

local cfn = CFrame.new
local vec3 = Vector3.new
local vec2 = Vector2.new

local rand = math.random
local floor = math.floor
local clamp = math.clamp

local wait, spawn, delay = task.wait, task.spawn, task.delay
local c3n, dn = Color3.new, Drawing.new



-- functions
local function DisableNonexecConnections(signal) 
    for _, con in ipairs(getconnections(signal)) do 
        local func = con.Function
        if (func and islclosure(func)) then
            local is_executor_closure = getfenv(func).game.HttpGet
            if (not is_executor_closure) then con:Disable() end
        end
    end
end
local find
do 
    local __index = getrawmetatable(game).__index
    find = function(inst, child) 
        local a,b = pcall(__index, inst, child)
        return a and b
    end
end

local base64decode do 
    local b = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'

    base64decode = function(data)
        data = data:gsub('[^'..b..'=]', '')
        return (data:gsub('.', function(x)
            if (x == '=') then return '' end
            local r,f='',(b:find(x)-1)
            for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
            return r;
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
            if (#x ~= 8) then return '' end
            local c=0
            for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
                return string.char(c)
        end))
    end
end

local create_esp



-- actual variables
local cons = {}
local p_players = {}
local rgbs = {}

local l_plr = serv_players.LocalPlayer
local l_chr = l_plr.Character
local l_humrp = l_chr and find(l_chr, "HumanoidRootPart")
local l_hum = l_chr and find(l_chr, "Humanoid")

local l_cam = workspace.CurrentCamera


do
    create_esp = function(text, textcolor) 
        local t = {}
        do
            local q = dn("Quad") do 
                q.Visible = true
                q.Thickness = 2
                q.ZIndex = 1
                q.Filled = false
                
                ins(rgbs, {
                    q;
                    "Color";
                })
                
                t[1] = q 
            end
            local q = dn("Quad") do 
                q.Visible = false
                q.Thickness = 4
                q.Filled = false
                q.Color = c3n(0.01,0.01,0.01)
                
                t[2] = q 
            end
            local tl = dn("Text") do 
                tl.Visible = false
                tl.Size = 19
                tl.Center = true
                tl.Outline = true
                tl.OutlineColor = c3n(0.01,0.01,0.01)
                tl.Text = text
                tl.Font = Drawing.Fonts.Plex
                tl.Color = textcolor
                
                t[3] = tl
            end
            
        end
        
        return t
    end
end

local remrgbobj
do
    local _0 = 0
    local _1
    local _2 = Color3.fromHSV
    cons[#cons+1] = ev_rs_rstepped:Connect(function(dt) 
        local len = #rgbs
        if (len == 0) then return end
        
        _0 = (_0 > 1 and 0 or _0 + dt*.1)
        _1 = _2(_0,0.7,1)
        for i = 1, len do
            local i = rgbs[i]
            
            local ob = i[1]
            if (ob) then 
                ob[i[2]] = _1
            end
        end
    end)
    
    remrgbobj = function(obj)
        for i = 1, #rgbs do 
            if (rgbs[i][1] == obj) then
                rem(rgbs, i)
                break
            end
        end
    end
end

-- shitter connections
for _,plr in ipairs(serv_players:GetPlayers()) do 
    if plr == l_plr then continue end
    
    local ptable = {}
    ptable[1] = plr
    ptable[4] = {}
    
    if (plr.Character and find(plr.Character, "HumanoidRootPart")) then
        ptable[2] = plr.Character
        ptable[3] = plr.Character.HumanoidRootPart
    end
    
    cons[#cons+1] = plr.CharacterAdded:Connect(function(c) 
        local pidx
        
        for i = 1, #p_players do 
            if p_players[i][1] == plr then
                pidx = i
                break
            end
        end
        
        ptable[2] = c
        ptable[3] = c and c:WaitForChild("HumanoidRootPart", 3)
        p_players[pidx] = ptable
    end)
    
    p_players[#p_players+1] = ptable
end
cons[#cons+1] = serv_players.PlayerAdded:Connect(function(plr) 
    local ptable = {}
    ptable[1] = plr
    ptable[4] = {}
    
    if (plr.Character and find(plr.Character, "HumanoidRootPart")) then
        ptable[2] = plr.Character
        ptable[3] = plr.Character.HumanoidRootPart
    end
    
    cons[#cons+1] = plr.CharacterAdded:Connect(function(c) 
        local pidx
        
        for i = 1, #p_players do 
            if p_players[i][1] == plr then
                pidx = i
                break
            end
        end
        
        ptable[2] = c
        ptable[3] = c and c:WaitForChild("HumanoidRootPart", 3)
        p_players[pidx] = ptable
    end)
    
    p_players[#p_players+1] = ptable
end)
cons[#cons+1] = serv_players.PlayerRemoving:Connect(function(p) 
    for i = 1, #p_players do
        if (p_players[i][1] == p) then
            local drawing_insts = p_players[i][4]
            
            remrgbobj(drawing_insts[1])
            delay(0.3, function() 
                for i,v in ipairs(drawing_insts) do 
                    v:Remove()
                end
            end)
            p_players[i] = nil
            rem(p_players, i)
            
            break
        end
    end
end)
cons[#cons+1] = l_plr.CharacterAdded:Connect(function(c) 
    l_chr = c
    l_humrp = c:WaitForChild("HumanoidRootPart",0.2)
    l_hum = c:WaitForChild("Humanoid",0.2)
end)
cons[#cons+1] = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() 
    l_cam = workspace.CurrentCamera
end)


-- misc module "globals"

--local mark_RemoveCooldown = false




ui:ConnectFlag("Exiting", function(toggles) 
    for _,tog in ipairs(toggles) do 
        if (tog:IsEnabled()) then 
            tog:Toggle() 
        end
    end
    
    for _,con in ipairs(cons) do 
        con:Disconnect() 
    end
    
    find, base64decode, DisableNonexecConnections = nil
    --printconsole("Disconnected everything",0,255,255)
end)

local title = [[<font color='rgb(45,3,236)'>f</font><font color='rgb(79,6,218)'>a</font><font color='rgb(114,9,200)'>r</font><font color='rgb(149,13,182)'>d</font><font color='rgb(185,16,164)'>h</font><font color='rgb(219,19,146)'>u</font><font color='rgb(255,23,128)'>b</font>]]

local win = ui:NewWindow(title.. " | Identity Fraud", 550, 400)

local m_stuff = win:AddMenu('stuff') do 
    local s1 = m_stuff:AddSection('monster/plr esp') do 
        local esp_cons = {}
        
        local esp_objs1 = {}
        
        local paranoia_esp
        
        local settings_distance = false
        local settings_delaytime = 0.03
        
        local monster_color = c3n(0.9,0.2,0.2)
        local warning_color = c3n(0.9,0.6,0.2)
        local player_color = c3n(0.2,0.2,0.9)
        
        
        local cf_offs_1 = cfn( 2, 2, 0)
        local cf_offs_2 = cfn(-2, 2, 0)
        local cf_offs_3 = cfn(-2,-2, 0)
        local cf_offs_4 = cfn( 2,-2, 0)
        local cf_offs_5 = cfn( 0, 3, 0)
        
        
        local mesp = s1:AddToggle('monster esp'):SetTooltip("toggles esp for all monsters (Kate, Stan, etc.)")
        :ConnectFlag("Enabled", function() 
            local path_npc = workspace.NPCs
            local path_paranoia = workspace.CurrentCamera
            
            for i,npc in ipairs(path_npc:GetChildren()) do 
                local t = create_esp(npc.Name, monster_color)
                t[4] = npc
                t[5] = find(npc, "HumanoidRootPart")
                
                ins(esp_objs1, t)
            end
            
            if (find(path_paranoia,"Paranoia")) then
                local npc = find(path_paranoia,"Paranoia")
                
                local t = create_esp('Hallucination', warning_color)
                t[4] = npc
                t[5] = find(npc, "HumanoidRootPart")
                
                paranoia_esp = t
                ins(esp_objs1, t)
            end
            
            esp_cons[2] = path_paranoia.ChildAdded:Connect(function(c) 
                if (c.Name == "Paranoia") then
                    local npc = find(path_paranoia,"Paranoia")
                    
                    local t = create_esp('Hallucination', warning_color)
                    t[4] = npc
                    t[5] = find(npc, "HumanoidRootPart")
                    
                    paranoia_esp = t
                    ins(esp_objs1, t)
                end
            end)
            esp_cons[3] = path_paranoia.ChildRemoved:Connect(function(c) 
                if (c.Name == "Paranoia") then
                    
                    
                    for i,v in ipairs(esp_objs1) do 
                        if (v == paranoia_esp) then
                            rem(esp_objs1, i)
                            printconsole("Removed paranoia from esp objects",0,255,255)
                            break
                        end
                    end
                    
                    remrgbobj(paranoia_esp[1])
                    remrgbobj(paranoia_esp[3])
                    printconsole("Removed paranoia from rgb objects",0,255,255)
                    
                    
                    delay(0.01, function() 
                        paranoia_esp[1]:Remove()
                        paranoia_esp[2]:Remove()
                        paranoia_esp[3]:Remove()
                        
                        paranoia_esp = nil
                        printconsole("Cleared paranoia esp",0,255,0)
                    end)
                end
            end)
            
            esp_cons[1] = true
            spawn(function() 
                while esp_cons[1] do 
                    
                    local self_pos = l_humrp.Position
                    for i = 1, #esp_objs1 do 
                        local obj = esp_objs1[i]
                        
                        local humrp = obj[5]
                        local inside, outside, text = obj[1], obj[2], obj[3]
                        local pos3d0 = humrp.CFrame
                        
                        local pos3d5 = (pos3d0 * cf_offs_5).Position
                        local pos2d5, vis5 = l_cam:WorldToViewportPoint(pos3d5)
                        if not vis5 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue
                        end
                        
                        local pos3d1 = (pos3d0 * cf_offs_1).Position
                        local pos2d1, vis1 = l_cam:WorldToViewportPoint(pos3d1)
                        if not vis1 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d2 = (pos3d0 * cf_offs_3).Position
                        local pos2d2, vis2 = l_cam:WorldToViewportPoint(pos3d2)
                        if not vis2 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d3 = (pos3d0 * cf_offs_2).Position
                        local pos2d3, vis3 = l_cam:WorldToViewportPoint(pos3d3)
                        if not vis3 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d4 = (pos3d0 * cf_offs_4).Position
                        local pos2d4, vis4 = l_cam:WorldToViewportPoint(pos3d4)
                        if not vis4 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        pos2d1 = vec2(pos2d1.X, pos2d1.Y)
                        pos2d2 = vec2(pos2d2.X, pos2d2.Y)
                        pos2d3 = vec2(pos2d3.X, pos2d3.Y)
                        pos2d4 = vec2(pos2d4.X, pos2d4.Y)
                        
                        text.Position = vec2(pos2d5.X,pos2d5.Y-12)
                        
                        inside.PointA, outside.PointA = pos2d1, pos2d1
                        inside.PointB, outside.PointB = pos2d3, pos2d3
                        inside.PointC, outside.PointC = pos2d2, pos2d2
                        inside.PointD, outside.PointD = pos2d4, pos2d4
                        
                        outside.Visible = true
                        inside.Visible = true
                        text.Visible = true
                        
                        if (settings_distance) then
                            local mag = floor((pos3d0.Position - self_pos).Magnitude)
                            text.Text = chr.Name.."\n"..mag.."s"
                            text.Position -= vec2(0,25)
                        end
                    end
                    
                    if settings_delaytime == 0 then
                        ev_rs_rstepped:Wait()
                    else
                        wait(settings_delaytime)
                    end
                end
            end)
            
        end)
        :ConnectFlag("Disabled", function()
            
            spawn(function()
                wait()
                for i,v in ipairs(esp_objs1) do 
                    remrgbobj(v[1])
                    remrgbobj(v[3])
                    
                    v[1]:Remove()
                    v[2]:Remove()
                    v[3]:Remove()
                    
                end
                table.clear(esp_objs1)
            end)
            
            if (esp_cons[1]) then esp_cons[1] = nil end
            if (esp_cons[2]) then esp_cons[2]:Disconnect() end
            if (esp_cons[3]) then esp_cons[3]:Disconnect() end
        end)
        
        local pesp = s1:AddToggle('player esp'):SetTooltip('toggles esp for all players')
        :ConnectFlag("Enabled", function() 
            for idx,plr_obj in ipairs(p_players) do 
                local esp = create_esp(plr_obj[1].Name, player_color)
                plr_obj[4] = esp
            end
            
            esp_cons[5] = serv_players.PlayerAdded:Connect(function(p) 
                wait(0.03)
                local obj
                
                local l = #p_players
                
                for i = l-3, l do
                    local v = p_players[i]
                    if (v[1] == p) then
                        obj = v
                        break
                    end
                end
                
                if (not obj) then
                    printconsole("Failed to create esp for "..p.Name.."; couldn't get player object",255,255,0)
                    return
                end
                
                local esp = create_esp(p.Name, player_color)
                obj[4] = esp
            end)
            
            esp_cons[4] = true
            spawn(function() 
                while esp_cons[4] do 
                    local self_pos = l_humrp.Position
                    for i = 1, #p_players do 
                        local plr = p_players[i]
                        local humrp = plr[3]
                        
                        if (not humrp) then continue end
                        
                        local esp_objs = plr[4]
                        local inside, outside = esp_objs[1], esp_objs[2]
                        local text = esp_objs[3]
                        local pos3d0 = humrp.CFrame
                        
                        
                        local pos3d5 = (pos3d0 * cf_offs_5).Position
                        local pos2d5, vis5 = l_cam:WorldToViewportPoint(pos3d5)
                        if not vis5 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue
                        end
                        
                        local pos3d1 = (pos3d0 * cf_offs_1).Position
                        local pos2d1, vis1 = l_cam:WorldToViewportPoint(pos3d1)
                        if not vis1 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d2 = (pos3d0 * cf_offs_3).Position
                        local pos2d2, vis2 = l_cam:WorldToViewportPoint(pos3d2)
                        if not vis2 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d3 = (pos3d0 * cf_offs_2).Position
                        local pos2d3, vis3 = l_cam:WorldToViewportPoint(pos3d3)
                        if not vis3 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        local pos3d4 = (pos3d0 * cf_offs_4).Position
                        local pos2d4, vis4 = l_cam:WorldToViewportPoint(pos3d4)
                        if not vis4 then 
                            text.Visible = false
                            outside.Visible = false
                            inside.Visible = false
                            continue 
                        end
                        
                        pos2d1 = vec2(pos2d1.X, pos2d1.Y)
                        pos2d2 = vec2(pos2d2.X, pos2d2.Y)
                        pos2d3 = vec2(pos2d3.X, pos2d3.Y)
                        pos2d4 = vec2(pos2d4.X, pos2d4.Y)
                        
                        text.Position = vec2(pos2d5.X,pos2d5.Y-12)
                        
                        inside.PointA, outside.PointA = pos2d1, pos2d1
                        inside.PointB, outside.PointB = pos2d3, pos2d3
                        inside.PointC, outside.PointC = pos2d2, pos2d2
                        inside.PointD, outside.PointD = pos2d4, pos2d4
                        
                        outside.Visible = true
                        inside.Visible = true
                        text.Visible = true

                        if (settings_distance) then
                            local mag = floor((pos3d0.Position - self_pos).Magnitude)
                            text.Text = chr.Name.."\n"..mag.."s"
                            text.Position -= vec2(0,25)
                        end
                    end
                    
                    
                    if settings_delaytime == 0 then
                        ev_rs_rstepped:Wait()
                    else
                        wait(settings_delaytime)
                    end
                    
                end
            end)
        end)
        :ConnectFlag("Disabled", function() 
            spawn(function()
                wait()
                for i,v in ipairs(p_players) do 
                    local objs = v[4]
                    
                    remrgbobj(objs[1])
                    remrgbobj(objs[3])
                    
                    
                    objs[1]:Remove()
                    objs[2]:Remove()
                    objs[3]:Remove()
                    
                    table.clear(v[4])
                end
            end)
            
            if (esp_cons[4]) then esp_cons[4] = nil end
            if (esp_cons[5]) then esp_cons[5]:Disconnect() end
        end)
        
        
        s1:AddLabel('settings')
        s1:AddToggle('distance'):SetTooltip("shows distance in studs"):ConnectFlag("Toggled",function(t) 
            settings_distance = t
            
            if (t == false) then
                if (pesp:IsEnabled()) then
                    pesp:Toggle()
                    wait(0.02)
                    pesp:Toggle()
                end
                if (mesp:IsEnabled()) then
                    mesp:Toggle()
                    wait(0.02)
                    mesp:Toggle()
                end
            end
        end)
        s1:AddSlider('refresh delay',1,{min=0,max=0.08,current=0.03,step=0.001}):SetTooltip("how many seconds to wait before refreshing esp again"):ConnectFlag("ValueChanged", function(t) 
            settings_delaytime = t
        end)
        
        do 
            
            
            s1:AddMultiDropdown('esp targets',2,{'mirror','radio','maze 1 door', 'maze 2 door', 'maze 3 door'})
            
        end
    end
    
    local s2 = m_stuff:AddSection('client') do 
        local conid
        
        s2:AddLabel('camera')
        s2:AddToggle('unlock camera',1):SetTooltip("lets you go in third person")
        :ConnectFlag("Toggled",function(t) 
            if (t) then
                l_plr.CameraMode = "Classic"
                l_plr.CameraMinZoomDistance = 0.5
                l_plr.CameraMaxZoomDistance = 5000
                
                conid = #cons+1
                cons[conid] = l_plr.CharacterAdded:Connect(function() 
                    wait(0.1)
                    l_plr.CameraMode = "Classic"
                    l_plr.CameraMinZoomDistance = 0.5
                    l_plr.CameraMaxZoomDistance = 5000
                end)
            else
                l_plr.CameraMode = "LockFirstPerson"
                l_plr.CameraMinZoomDistance = 0.5
                l_plr.CameraMaxZoomDistance = 0.5
                
                cons[conid]:Disconnect()
            end
        end)
        
        s2:AddToggle('shiftlock'):SetTooltip("enables shiftlock")
        :ConnectFlag("Toggled",function(t) 
            l_plr.DevEnableMouseLock = t
        end)
        
        s2:AddLabel('invisible stuff')
        s2:AddToggle('invisible walls'):SetTooltip("makes walls for the 1st and 2nd mazes invisible")
        :ConnectFlag("Toggled",function(t) 
            local walls = workspace.Map.Walls
            local walls2 = workspace["Hedge Maze"].Walls
            
            if (t) then 
                for i,v in ipairs(walls:GetChildren()) do 
                    v.Transparency = 1
                end
                
                for i,v in ipairs(walls2:GetChildren()) do 
                    v.Transparency = 0.8
                end
                return 
            end
            
            for i,v in ipairs(walls:GetChildren()) do 
                v.Transparency = 0
            end
            
            for i,v in ipairs(walls2:GetChildren()) do 
                v.Transparency = 0
            end
        end)
        
        s2:AddToggle('invisible roof'):SetTooltip("makes the 1st maze's roof invisible")
        :ConnectFlag("Toggled",function(t) 
            local map = workspace.Map
            if (t) then
                for i,v in ipairs(map:GetChildren()) do 
                    if (v.Name == "Ceiling") then
                        v.Transparency = 1
                    end
                end
            else
                for i,v in ipairs(map:GetChildren()) do 
                    if (v.Name == "Ceiling") then
                        v.Transparency = 0
                    end
                end
            end
        end)
        

        s2:AddLabel('lighting')
        s2:AddToggle('fullbright'):SetTooltip("removes shadows")
        :ConnectFlag("Toggled",function(t) 
            game.Lighting.Ambient = t and c3n(0.5,0.5,0.5) or c3n(0,0,0)
        end)
        
        s2:AddToggle('fancy lighting'):SetTooltip('sets the games lighting to Future (this is a useless thing but it looks cool)')
        :ConnectFlag("Toggled",function(t) 
            sethiddenproperty(game.Lighting, "Technology", t and Enum.Technology.Future or Enum.Technology.Compatibility)
        end)
    end
    
    local s3 = m_stuff:AddSection('character','pathfind') do 
        local nc_con
        local speed_amnt = 3
        local speed_con
        
        
        s3:AddToggle("speed"):SetTooltip("classic speedhack (uses tpwalk, not walkspeed)"):ConnectFlag("Toggled",function(t) 
            if (t) then
                DisableNonexecConnections(l_humrp.Changed)
                DisableNonexecConnections(l_humrp:GetPropertyChangedSignal("CFrame"))
                speed_con = ev_rs_rstepped:Connect(function(dt) 
                    l_humrp.CFrame += l_hum.MoveDirection * 5 * dt * speed_amnt
                end)
            else
                speed_con:Disconnect()    
            end
        end)
        s3:AddToggle("noclip"):SetTooltip("classic noclip"):ConnectFlag("Toggled",function(t) 
            if t then
                local __newindex = getrawmetatable(game).__newindex
                
                nc_con = ev_rs_stepped:Connect(function() 
                    local c = l_chr:GetChildren()
                    for i = 1, #c do 
                        pcall(__newindex, c[i], "CanCollide", false)
                    end
                end)
            else
                nc_con:Disconnect()
            end
        end)
        
        s3:AddLabel('settings',1)
        s3:AddSlider('speed amount',1,{min=1,max=20,current=3,step=.5}):SetTooltip("changes speed amount"):ConnectFlag("ValueChanged",function(v) 
            speed_amnt = v
        end)
        
        s3:AddButton('pathfind to target',2):SetTooltip("automatically walks you to the selected target, uses the roblox pathfinding service")
        s3:AddDropdown('pathfind target',2,{'maze 1 door','maze 2 door','maze 3 door','mirror','disco room','netgear hall'})
    end
    
    local s4 = m_stuff:AddSection('marker') do 
        local mark_rem = game:GetService("ReplicatedStorage").Mark
        local settings_bcd = 1
        
        local lag_slider
        local lag_instant 
        
        local navi = l_plr.Backpack.Navigator
        
        s4:AddToggle("remove cooldown"):SetTooltip("removes the cooldown for placing markers"):ConnectFlag("Toggled",function(t) 
            if (t) then
                getsenv(navi)['buffer'] = function() return nil end
            else
                getsenv(navi)['buffer'] = function() return wait(30) end
            end
        end)
        
        local bcs 
        bcs = s4:AddToggle("breadcrumbs"):SetTooltip("leaves a trail of markers behind you"):ConnectFlag("Toggled",function(t)
            if (t) then
                spawn(function() 
                    while bcs:IsEnabled() do
                        local cf = l_humrp.CFrame
                        
                        local vec = vec3(cf.X, 0.5, cf.Z)
                        cf = cfn(vec, vec+cf.LookVector)
                        mark_rem:FireServer(cf)
                        wait(settings_bcd)
                    end
                end)
            end
        end)
        s4:AddButton('lag server'):SetTooltip("lagspikes the server, may take a bit"):ConnectFlag("Clicked",function() 
            local amt = lag_slider:GetValue()*2
            local rootcf = l_humrp.CFrame
            
            local floaty = Instance.new("BodyVelocity")
            floaty.Parent = l_humrp
            
            local campart = Instance.new("Part")
            campart.Anchored = true
            campart.Transparency = 1
            campart.CanTouch = false
            campart.CFrame = rootcf*cfn(0,1.5,0)
            
            l_cam.CameraSubject = campart
            
            
            local fast = lag_instant:IsEnabled()
            
            if fast then
                
                for x = -amt, amt do 
                    for z = -amt, amt do 
                        local targ = rootcf * cfn(x, 0, z)
                        mark_rem:FireServer(targ)
                    end
                end
                wait()
                
            else
                for x = -amt, amt do 
                    for z = -amt, amt do 
                        local targ = rootcf * cfn(x, 0, z)
                        
                        l_humrp.CFrame = targ
                        mark_rem:FireServer(targ)
                        wait()
                    end
                    wait(0.01)
                end
                wait(0.3)
            end
            
            
            l_humrp.CFrame = rootcf
            l_cam.CameraSubject = l_hum
            
            campart:Destroy()
            floaty:Destroy()
        end)
        
        s4:AddSlider("breadcrumbs delay",1,{min=0,max=4,step=0.1,current=1}):SetTooltip("delay between breadcrumb placements"):ConnectFlag("ValueChanged",function(t) 
            settings_bcd = t
        end)
        lag_slider = s4:AddSlider("lag server amount",1,{min=1,max=10,current=1}):SetTooltip("intensity of server laggage")
        lag_instant = s4:AddToggle('instant lag'):SetTooltip("instantly makes markers instead of gradually making them. wastes less time, but less markers may show up")
        
        
        local covering = false
        s4:AddButton('cover entire first maze'):SetTooltip('covers the entire first maze with markers, takes an insanely long amount of time'):ConnectFlag("Clicked", function() 
            if (covering) then
                ui:SendNotification("oops","already covering maze",2)
                return
            end
            covering = true
            
            local start = l_humrp.CFrame
            
            local floaty = Instance.new("BodyVelocity")
            floaty.Velocity = vec3(0, 0, 0)
            floaty.Parent = l_humrp
            
            local noclip
            local __newindex = getrawmetatable(game).__newindex
            noclip = ev_rs_stepped:Connect(function() 
                local c = l_chr:GetChildren()
                for i = 1, #c do 
                    pcall(__newindex, c[i], "CanCollide", false)
                end
            end)
            
            l_hum.CameraOffset = vec3(0, 5, 0)
            
            local _1 = 360
            local _2 = 540
            local _3 = -370
            local _4 = -540 
            
            local off = cfn(0, -5, 0)
            
            local idx = 0
            
            for x = _3, _2, 5 do 
                idx += 1
                for z = _4, _1, 5 do 
                    local targ = cfn(x, 1, z)
                    
                    l_humrp.CFrame = targ * off
                    mark_rem:FireServer(targ)
                    wait(0.02)
                end
                wait(0.01*idx)
            end
            wait(0.3)
            
            floaty:Destroy()
            noclip:Disconnect()
            l_hum.CameraOffset = vec3(0, 0, 0)
            
            l_humrp.CFrame = start
            
            covering = false
        end)
        
        
        s4:AddLabel('')
        s4:AddLabel('')
    end
end
local m_puzzles = win:AddMenu('puzzles') do 
    local chat = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
    
    -- disco
    do
        local disco_puzzle = workspace["Secret Doors"].Pad.SurfaceGui.TextLabel    
        local disco_answer = base64decode(disco_puzzle.Text):match("The code is %d+")
        local disco_target = disco_answer:match("The code is (%d+)")
        
        
        local s1 = m_puzzles:AddSection('disco room') do 
            s1:AddLabel("answer: "..disco_target)
            s1:AddButton('copy to clipboard'):SetTooltip('copies the answer to clipboard'):ConnectFlag("Clicked",function() 
                setclipboard(tostring(disco_target))
                ui:SendNotification("disco puzzle","copied answer to clipboard",3)
            end)
        end
    end
    -- hex 
    do 
        local surf = workspace.Finale.Panel.SurfaceGui
        local hex_code = surf.Frame.Code.Text
        local hex_replace = surf.Frame.Hexadecimals.Text
        
        local hex_key = ''
        for i in hex_replace:gmatch("([%a%d]+) ") do 
            hex_key = hex_key .. string.char(tonumber('0x'..i))
        end
        
        local hex_r1, hex_r2 = hex_key:match("Replace all ([%d%a])'s with a ([%d%a])")
        
        local hex_answer = hex_code:gsub(hex_r1,hex_r2)
        
        local s1 = m_puzzles:AddSection('final room') do 
            s1:AddLabel("original code: "..hex_code)
            s1:AddLabel("key: "..hex_key)
            
            s1:AddLabel("answer: "..hex_answer)
            s1:AddButton('copy to clipboard'):SetTooltip('copies the answer to clipboard'):ConnectFlag("Clicked",function() 
                setclipboard(tostring(hex_answer))
                ui:SendNotification("hex puzzle","copied answer to clipboard",3)
            end)
        end
    end
end


ui:Ready()

delay(1, function() 
    if (l_chr) then
        local frig = find(l_chr, "Frigid")
        if (frig) then
            frig:Destroy()
        end
    end
end)

cons[#cons+1] = l_plr.CharacterAdded:Connect(function(c) 
    local frig = c:WaitForChild("Frigid",6)
    if (frig) then frig:Destroy() end
    
    delay(2, function() 
        if (l_humrp.CFrame.Y > 22 and l_cam.CameraSubject == l_hum) then
            ui:SendNotification("Fixed character","detected your character stuck on the roof, teleported to a random spawn",2)
            local c1 = workspace.Spawns:GetChildren()
            local c2 = c1[math.random(1, #c1)]
            
            l_humrp.CFrame = c2.CFrame * cfn(0, 1, 0)
            
        end
    end)
end)
