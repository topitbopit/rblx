
if not game:IsLoaded() then game.Loaded:Wait() end




local players = game:GetService("Players")
local runservice = game:GetService("RunService")
local userinput = game:GetService("UserInputService")

local cframe = CFrame.new
local vector = Vector3.new
local vector2 = Vector2.new
local color3n = Color3.new
local color3 = Color3.fromRGB

local twait = task.wait
local tdelay = task.delay
local tspawn = task.spawn

local cwrap = coroutine.wrap
local ccreate = coroutine.create
local cresume = coroutine.resume 

local tinsert = table.insert
local tremove = table.remove

local mrandom = math.random

local function disablecons(e) 
    for _,con in pairs(getconnections(e)) do
        con:Disable()
    end
end

local function enablecons(e) 
    for _,con in pairs(getconnections(e)) do
        con:Enable()
    end
end


local function FindFastChild(instance, name) 
    local a,b = pcall(function() return instance[name] end)
    
    return (a and b) or nil
end

disablecons(game.DescendantAdded)

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
ui:SetColors("cold")

local connections = {}
local plr = players.LocalPlayer


local window = ui:NewWindow("Jeff GUI", 400, 300)

local MenuPlayer = window:NewMenu("Player")
local MenuCamera = window:NewMenu("Camera")
local MenuRender = window:NewMenu("Render")
local MenuTeleport = window:NewMenu("Teleport")


MenuPlayer:NewSection("Noclip")
local NoclipToggle = MenuPlayer:NewToggle("Noclip")
local NoclipMethod = MenuPlayer:NewDropdown("Noclip method",{"CanCollide","Humanoid","Raycast"})

NoclipToggle:SetTooltip("Standard noclip")
NoclipMethod:SetTooltip("Method Noclip uses.\nCanCollide: The best\nHumanoid: Pretty good\nRaycast: Workaround for games that can detect noclip")

MenuPlayer:NewSection("Speed")
local SpeedToggle = MenuPlayer:NewToggle("Speed")
local SpeedAmount = MenuPlayer:NewSlider("Speed amount",0,200,20)

SpeedToggle:SetTooltip("Standard speed - doesn't use walkspeed")

MenuPlayer:NewSection("Flight")
local FlightToggle = MenuPlayer:NewToggle("Flight")
local FlightMethod = MenuPlayer:NewDropdown("Flight method", {"CFrame","Weld"})
local FlightAmount = MenuPlayer:NewSlider("Flight speed", 0, 100, 20)

FlightToggle:SetTooltip("Pretty good flight. All methods are nearly undetectable, unlike most scripts")
FlightMethod:SetTooltip("The method Flight uses.\nCFrame: Works like expected. Only detectable through sanity checks\nWeld: Works a little weird; other players cant see you fly like a lagswitch")
FlightAmount:SetTooltip("Flight speed")

MenuPlayer:NewSection("Misc")
local Parkour = MenuPlayer:NewToggle("Parkour")
local InfJump = MenuPlayer:NewToggle("Infinite Jump")
local Flashback = MenuPlayer:NewToggle("Flashback")
local AnticheatBypass = MenuPlayer:NewToggle("Antidetect")

Parkour:SetTooltip("Jumps when you reach the end of a part")
InfJump:SetTooltip("Lets you jump infinite times")
Flashback:SetTooltip("Teleports you back after you die. Should work better than most other scripts")
AnticheatBypass:SetTooltip("Disconnects connections for things like cframe changing ")


MenuPlayer:NewLabel()
MenuPlayer:NewTrim()
MenuPlayer:NewLabel("Made by topit; v1.0.0")

MenuCamera:NewSection("Freecam")
local Freecam = MenuCamera:NewToggle("Freecam")
local FreecamSpeed = MenuCamera:NewSlider("Freecam speed", 10, 30, 20)
local FreecamMoveto = MenuCamera:NewTextbox("Enter player to move freecam to...")
local FreecamGoto = MenuCamera:NewButton("Teleport to freecam")
MenuCamera:NewSection("Camera")
local MaxZoom = MenuCamera:NewSlider("Max camera zoom", 1, 500, 500)
local MinZoom = MenuCamera:NewSlider("Min camera zoom", 0, 500, 0)
local ThirdPerson = MenuCamera:NewToggle("Enable third person")

local Fullbright = MenuRender:NewToggle("Fullbright")
local ForceFuture = MenuRender:NewToggle("Force Future lighting")
ForceFuture:Assert("sethiddenproperty")
local ViewPlayerBox = MenuCamera:NewTextbox("Enter player to view...")

MenuRender:NewSection("Player ESP")
local PESP_Names = MenuRender:NewToggle("Names")
local PESP_Boxes = MenuRender:NewToggle("Boxes")
local PESP_Lazy = MenuRender:NewToggle("Lazy update")
PESP_Lazy:Enable()

PESP_Names:Assert("Drawing")
PESP_Boxes:Assert("Drawing")
PESP_Lazy:Assert("Drawing")


MenuRender:NewLabel("Lazy update drastically improves fps but may add    some update delay")

-- { Functions / variables } --

local flightpart

local function GetPlayerFromName(name) 
    name = name:lower()
    --check 1: exact matches (display)
    for i,v in pairs(players:GetPlayers()) do
        if v.DisplayName:lower():sub(1,#name) == name then
            return v, 1
        end
    end
    
    --check 2: exact matches (name)
    for i,v in pairs(players:GetPlayers()) do
        if v.Name:lower():sub(1,#name) == name then
            return v, 2
        end
    end
    
    --check 3: contains (display)
    for i,v in pairs(players:GetPlayers()) do
        if v.DisplayName:lower():match(name) then
            return v,3
        end
    end
    
    --check 4: contains (name)
    for i,v in pairs(players:GetPlayers()) do
        if v.Name:lower():match(name) then
            return v,4
        end
    end
    
    return nil
end


-- { Assign callbacks } --

--Player
do
    NoclipToggle.OnEnable:Connect(function() 
        local mode,idx = NoclipMethod:GetSelection()
        
        if mode == "Humanoid" then
            
            connections["NoclipHumanoid"] = runservice.Stepped:Connect(function()
                plr.Character.Humanoid:ChangeState(11)
            end)
        elseif mode == "CanCollide" then
            
            connections["NoclipCollide"] = runservice.Stepped:Connect(function() 
                for i,v in pairs(plr.Character:GetChildren()) do
                    pcall(function() 
                        v.CanCollide = false
                    end) 
                end
            end)
        elseif mode == "Raycast" then
            local rc = RaycastParams.new({
                FilterType = Enum.RaycastFilterType.Blacklist
            })
            
            while NoclipToggle:GetState() do
                local c = plr.Character
                rc.FilterDescendantsInstances = {c}
                
                pcall(function() 
                    local lv = c.Humanoid.MoveDirection--c.HumanoidRootPart.CFrame.LookVector
                    
                    local r1
                    local r2
                    
                    r1 = workspace:Raycast(c.HumanoidRootPart.Position, lv*4, rc)
                    
                    if r1 then
                        r2 = workspace:Raycast(r1.Position + lv*10, -(lv*100), rc)
                        c.HumanoidRootPart.CFrame = cframe(r2.Position, r2.Position + lv)
                    end
                end)
                
                twait(0.1)    
            end
        end
    end)
    
    NoclipToggle.OnDisable:Connect(function() 
        
        if connections["NoclipHumanoid"] then
            connections["NoclipHumanoid"]:Disconnect()
        end
        if connections["NoclipCollide"] then
            connections["NoclipCollide"]:Disconnect()
        end
    end)
    
    
    NoclipMethod.OnSelection:Connect(function(name,idx) 
        if NoclipToggle:GetState() then 
            NoclipToggle:Disable()
            NoclipToggle:Enable()
        end
    end)
    
    
    SpeedToggle.OnEnable:Connect(function() 
        local c = plr.Character
        runservice:BindToRenderStep("GUISpeed",500,function(dt) 
            pcall(function() 
                local a = c.HumanoidRootPart
                
                a.CFrame = a.CFrame + (c.Humanoid.MoveDirection * (SpeedAmount:GetValue() * dt ))
                
            end)
        end)
    end)
    
    SpeedToggle.OnDisable:Connect(function() 
        runservice:UnbindFromRenderStep("GUISpeed")
    end)
    
    flightpart = Instance.new("Part")
    flightpart.Name = "煃碷科綞洃筂瘫皪疿"
    flightpart.CanCollide = false
    flightpart.Anchored = true
    flightpart.Transparency = 1
    
    flightpart.Parent = workspace
    
    FlightToggle.OnEnable:Connect(function()
        if Freecam:GetState() then
            ui:NewNotification("Oopsies","Got out of freecam first",4)
            FlightToggle:Disable()
            return 
        end
        
        local _,idx = FlightMethod:GetSelection()
        
        if idx == 1 then
            local humrp = FindFastChild(plr.Character, "HumanoidRootPart")
            
            connections["GUIFlight"] = plr.CharacterAdded:Connect(function(c) 
                humrp = c:WaitForChild("HumanoidRootPart")
            end)
            
            local cam = workspace.CurrentCamera
            
            --cam.CameraSubject = flightpart
            flightpart.CFrame = plr.Character.HumanoidRootPart.CFrame
            runservice:BindToRenderStep("GUIFlight", 800, function(dt) 
                pcall(function() 
                    local clv = cam.CFrame.LookVector
                    
                    plr.Character.Humanoid:ChangeState(16)
                    
                    local lv = 
                    (userinput:IsKeyDown(Enum.KeyCode.S) and vector(0, 0, 1) or vector(0, 0, 0))  +
                    (userinput:IsKeyDown(Enum.KeyCode.W) and vector(0, 0, -1) or vector(0, 0, 0)) +
                    (userinput:IsKeyDown(Enum.KeyCode.A) and vector(-1, 0, 0) or vector(0, 0, 0)) +
                    (userinput:IsKeyDown(Enum.KeyCode.D) and vector(1, 0, 0) or vector(0, 0, 0))
                    
                    
                    flightpart.CFrame = cframe(flightpart.Position, flightpart.Position + clv) * cframe((lv*FlightAmount:GetValue()*2) * dt)
                    
                    
                    
                    for i,v in pairs(plr.Character:GetChildren()) do
                        pcall(function() 
                            v.Velocity = vector(0,0,0)
                        end) 
                    end
                    
                    
                    humrp.CFrame = flightpart.CFrame
                end)
            end)
            
        elseif idx == 2 then
        
            local a = Instance.new("Weld")
            a.Name = "amongus"
            a.Part0 = flightpart
            a.Parent = flightpart
            
            
            connections["GUIFlight"] = plr.CharacterAdded:Connect(function(c) 
                local a = FindFastChild(flightpart, "amongus")
                if a then a:Destroy() end
                
                twait(0.04)
                
                local a = Instance.new("Weld")
                a.Name = "amongus"
                a.Part0 = flightpart
                a.Parent = flightpart
                a.Part1 = (FindFastChild(c, "HumanoidRootPart") or c:WaitForChild("HumanoidRootPart", 2))
            end)
            
            local cam = workspace.CurrentCamera
            
            --cam.CameraSubject = flightpart
            flightpart.CFrame = plr.Character.HumanoidRootPart.CFrame
            runservice:BindToRenderStep("GUIFlight", 800, function(dt) 
                pcall(function() 
                    local clv = cam.CFrame.LookVector
                    
                    plr.Character.Humanoid:ChangeState(16)
                    a.Part1 = plr.Character.HumanoidRootPart
                    
                    local lv = 
                    (userinput:IsKeyDown(Enum.KeyCode.S) and vector(0, 0, 1) or vector(0, 0, 0))  +
                    (userinput:IsKeyDown(Enum.KeyCode.W) and vector(0, 0, -1) or vector(0, 0, 0)) +
                    (userinput:IsKeyDown(Enum.KeyCode.A) and vector(-1, 0, 0) or vector(0, 0, 0)) +
                    (userinput:IsKeyDown(Enum.KeyCode.D) and vector(1, 0, 0) or vector(0, 0, 0))
                    
                    
                    flightpart.CFrame = cframe(flightpart.Position, flightpart.Position + clv) * cframe((lv*FlightAmount:GetValue()*2) * dt)
                end)
            end)
        end
    end)
    
    FlightToggle.OnDisable:Connect(function() 
        if Freecam:GetState() then return end
        runservice:UnbindFromRenderStep("GUIFlight")
        connections["GUIFlight"]:Disconnect()
        
        if FindFastChild(plr.Character, "Humanoid") then
            plr.Character.Humanoid:ChangeState(2)
            --workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
        end
        
        local a = FindFastChild(flightpart, "amongus")
        if a then a:Destroy() end
    end)
    
    FlightMethod.OnSelection:Connect(function(name,idx) 
        if FlightToggle:GetState() then 
            FlightToggle:Disable()
            FlightToggle:Enable()
        end
    end)
    
    
    Parkour.OnEnable:Connect(function() 
        local a = FindFastChild(plr.Character, 'Humanoid')
        if not a then 
            ui:NewNotification("Oopsies","Couldn't enable - make sure your character's loaded", 4)
            Parkour:Disable()
            return 
        end
        
        connections["Parkour1"] = plr.CharacterAdded:Connect(function(c) 
            twait(0.05)
            local a = FindFastChild(c, 'Humanoid')
            if not a then
                a = c:WaitForChild('Humanoid', 5)
                if not a then
                    ui:NewNotification("Oopsies","Couldn't enable - make sure your character's loaded", 4)
                    Parkour:Disable()
                    return
                end
            end
            
    
            connections["Parkour2"] = a:GetPropertyChangedSignal("FloorMaterial"):Connect(function() 
                if a.FloorMaterial == Enum.Material.Air then
                    if a.Jump then return end
                    a:ChangeState(3)
                end
            end)
        end)
        connections["Parkour2"] = a:GetPropertyChangedSignal("FloorMaterial"):Connect(function() 
            if a.FloorMaterial == Enum.Material.Air then
                if a.Jump then return end
                a:ChangeState(3)
            end
        end)
    end)
    
    Parkour.OnDisable:Connect(function() 
        connections["Parkour1"]:Disconnect()
        connections["Parkour2"]:Disconnect()
    end)
    
    InfJump.OnEnable:Connect(function() 
        connections["InfJump"] = userinput.InputBegan:Connect(function(io, gpe) 
            if io.KeyCode == Enum.KeyCode.Space then
                if plr.Character then plr.Character.Humanoid:ChangeState(3) end
            end
        end)
    end)
    
    InfJump.OnDisable:Connect(function() 
        connections["InfJump"]:Disconnect()
    end)
    
    Flashback.OnEnable:Connect(function() 
        connections["Flashback1"] = plr.CharacterAdded:Connect(function(c) 
            
            local hum = c:WaitForChild("Humanoid", 2)
            
            if not hum then return end
            
            connections["Flashback2"] = hum.Died:Connect(function() 
                local old = plr.Character.HumanoidRootPart.CFrame -- get the old position 
                local new = plr.CharacterAdded:Wait() -- wait for new character
                
                
                new:WaitForChild("HumanoidRootPart").CFrame = old
                
                twait()
                
                local humrp = new.HumanoidRootPart
                for i = 1, 5 do
                    if (humrp.Position - old.Position).Magnitude > 5 then -- if you're far away from old then
                        humrp.CFrame = old -- teleport back 
                    end
                    twait(0.1)
                end
            end)
        end)
        
        
        if plr.Character then
            local hum = FindFastChild(plr.Character, 'Humanoid')
            if not hum then return end
            connections["Flashback2"] = hum.Died:Connect(function() 
                local old = plr.Character.HumanoidRootPart.CFrame
                local new = plr.CharacterAdded:Wait() 
                
                
                new:WaitForChild("HumanoidRootPart").CFrame = old
                twait()
                local humrp = new.HumanoidRootPart
                for i = 1, 5 do
                    if (humrp.Position - old.Position).Magnitude > 5 then
                        humrp.CFrame = old 
                    end
                    twait()
                end
            end)
        end
    end)
    
    Flashback.OnDisable:Connect(function() 
        connections["Flashback1"]:Disconnect()
        connections["Flashback2"]:Disconnect()
    end)
    
    
    
    AnticheatBypass.OnEnable:Connect(function() 
        connections["BypassAnticheat"] = plr.CharacterAdded:Connect(function(c) 
            
            local h = c:WaitForChild("HumanoidRootPart", 5)
            disablecons(h:GetPropertyChangedSignal("CFrame"))
            disablecons(h.Changed)
            disablecons(h.ChildAdded)
        end)
        --ui:NewNotification("Anticheat bypass","Anticheat bypass activated")
    end)
    
    AnticheatBypass.OnDisable:Connect(function() 
        connections["BypassAnticheat"]:Disconnect()
    end)
end

--Camera
do 
    local old_freecampos = cframe(0, 0, 0)
    if plr.Character then
        old_freecampos = plr.Character.HumanoidRootPart.CFrame
    end
    Freecam.OnEnable:Connect(function()
        if FlightToggle:GetState() then
            ui:NewNotification("Oopsies","Got out of flight first",4)
            Freecam:Disable()
            return 
        end

        local c = plr.Character
        if FindFastChild(c, "HumanoidRootPart") then
            c.HumanoidRootPart.Anchored = true
            
        end

        connections["Freecam"] = plr.CharacterAdded:Connect(function(c) 
            local hum = FindFastChild(c, "HumanoidRootPart") or c:WaitForChild("HumanoidRootPart", 2)
            
            hum.Anchored = true
        end)
        
        local cam = workspace.CurrentCamera

        cam.CameraSubject = flightpart
        flightpart.CFrame = old_freecampos
        runservice:BindToRenderStep("GUIFreecam", 500, function(dt) 
            pcall(function() 
                local clv = cam.CFrame.LookVector
                
                
                local lv = 
                (userinput:IsKeyDown(Enum.KeyCode.S) and vector(0, 0, 1) or vector(0, 0, 0))  +
                (userinput:IsKeyDown(Enum.KeyCode.W) and vector(0, 0, -1) or vector(0, 0, 0)) +
                (userinput:IsKeyDown(Enum.KeyCode.A) and vector(-1, 0, 0) or vector(0, 0, 0)) +
                (userinput:IsKeyDown(Enum.KeyCode.D) and vector(1, 0, 0) or vector(0, 0, 0))
                
                flightpart.CFrame = cframe(flightpart.Position, flightpart.Position + clv) * cframe((lv*FreecamSpeed:GetValue()*4) * dt)
            end)
        end)
        

    end)
    
    Freecam.OnDisable:Connect(function() 
        if FlightToggle:GetState() then return end
        
        old_freecampos = flightpart.CFrame
        
        runservice:UnbindFromRenderStep("GUIFreecam")
        connections["Freecam"]:Disconnect()
        
        if FindFastChild(plr.Character, "Humanoid") then
            workspace.CurrentCamera.CameraSubject = plr.Character.Humanoid
        end
        
        if FindFastChild(plr.Character, "HumanoidRootPart") then
            plr.Character.HumanoidRootPart.Anchored = false 
        end
    end)    
    
    
    FreecamMoveto.OnFocusLost:Connect(function(text)
        local p,mode = GetPlayerFromName(text)
        if p then
            if FindFastChild(p.Character, "HumanoidRootPart") then
                FreecamMoveto:SetText("Moved to "..(#p.Name > 15 and p.Name:sub(1,9).."..."..p.Name:sub(#p.Name-3,#p.Name) or p.Name)..(mode%2~=0 and(" (used Display name)")or""))
                flightpart.CFrame = p.Character.HumanoidRootPart.CFrame
            else
                FreecamMoveto:SetText("Couldn't move to "..(#p.Name > 15 and p.Name:sub(1,9).."..."..p.Name:sub(#p.Name-3,#p.Name) or p.Name))
            end
        
        else
            FreecamMoveto:SetText("Couldn't find any matching player")
        end
        
    end)
    
    FreecamGoto.OnClick:Connect(function() 
        plr.Character.HumanoidRootPart.CFrame = flightpart.CFrame
    end)
    
    MaxZoom.OnValueChanged:Connect(function(val) 
        plr.CameraMaxZoomDistance = val
    end)
    
    MinZoom.OnValueChanged:Connect(function(val) 
        plr.CameraMinZoomDistance = val
    end)
    
    
    ThirdPerson.OnEnable:Connect(function() 
        plr.CameraMode = Enum.CameraMode.Classic
    end)
    
    ThirdPerson.OnDisable:Connect(function() 
        plr.CameraMode = Enum.CameraMode.LockFirstPerson
    end)
    
    ViewPlayerBox.OnFocusLost:Connect(function(text) 
        local p,mode = GetPlayerFromName(text)
        if p then
            if FindFastChild(p.Character, "HumanoidRootPart") then
                ViewPlayerBox:SetText("Viewing "..(#p.Name > 15 and p.Name:sub(1,9).."..."..p.Name:sub(#p.Name-3,#p.Name) or p.Name)..(mode%2~=0 and(" (used Display name)")or""))
                
                rs:BindToRenderStep("GUIPLAYERVIEW", 605, function() 
                    
                end)
                
            else
                ViewPlayerBox:SetText("Couldn't view "..(#p.Name > 15 and p.Name:sub(1,9).."..."..p.Name:sub(#p.Name-3,#p.Name) or p.Name))
            end
        
        else
            FreecamMoveto:SetText("Couldn't find any matching player")
        end
    end)
end




ui.Exiting:Connect(function() 
    for i,v in pairs(connections) do
        v:Disconnect()
    end
    
    
    local toggles = ui:GetAllToggles()
    
    for i,v in pairs(toggles) do
        if v:GetState() == true then 
            v:Disable() 
        end
    end
    flightpart:Destroy()
end)


-- { Ready } --

local msg = ui:NewMessagebox("Warning","This is not the final version!",nil,50,-30)

msg.OnClose:Wait()
ui:Ready()

-- { Activate extra stuff } --

--anticheat bypass
if FindFastChild(plr.Character, "HumanoidRootPart") then
    local h = plr.Character.HumanoidRootPart

    disablecons(h:GetPropertyChangedSignal("CFrame"))
    disablecons(h.Changed)
    disablecons(h.ChildAdded)
end
AnticheatBypass:Enable()
