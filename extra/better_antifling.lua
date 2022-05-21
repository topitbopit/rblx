-- hi 🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑🤑

-- get services
local runServ = game:GetService('RunService') -- used for some antifling methods 
local sGuiServ = game:GetService('StarterGui') -- starter gui
local playerServ = game:GetService('Players') -- players

-- get client stuff
local clientPlr = game:GetService('Players').LocalPlayer 
local clientChar = clientPlr.Character
local clientHumanoid
local clientRoot

-- assign char vars
if (clientChar) then
    clientHumanoid = clientChar:FindFirstChild('Humanoid')
    clientRoot = clientChar:FindFirstChild('HumanoidRootPart')
end 

-- localize some functions for speed 🤑🤑
local vec3 = Vector3
local cfr = CFrame
-- localize config
local config = _G.AntiFlingConfig
-- setup connection table 
local cons = {}

-- handle disable stuff
do 
    -- check if the script was ran previously 
    if (typeof(_G.disable) == 'function') then
        -- if it was then delete it
        _G.disable()
    end
    -- set disable function
    _G.disable = function()
        -- disable every connection 
        for i,v in pairs(cons) do
            v:Disconnect() 
        end
        -- set cons to nil for the funnies
        cons = nil
        -- display notification 
        sGuiServ:SetCore('SendNotification', {
        	Title = 'antifling';
        	Text = 'deactivated';
        	Duration = 2;
        })
        -- clear function
        _G.disable = nil 
    end
end

-- client char handler
cons.charHandler = clientPlr.CharacterAdded:Connect(function(newChar) 
    -- update shit
    clientChar = newChar
    
    -- do a funny error message thing
    local set = false
    task.delay(4, function() 
        if (set == false) then
            sGuiServ:SetCore('SendNotification', {
            	Title = 'antifling';
            	Text = 'something went wrong and shit itself (your game probably isnt supported)';
            	Duration = 4;
            })
        end
    end)
    clientRoot = clientChar:WaitForChild('HumanoidRootPart', 99)
    clientHumanoid = clientChar:WaitForChild('Humanoid', 99)
    set = true
end)




--// actual antifling method shit
if (config.disable_rotation) then
    cons.disableRot = runServ.Stepped:Connect(function()
        if (clientRoot) then
            -- set rotvelocity to (0,0,0)
            clientRoot.RotVelocity = vec3.zero -- handy tip: you can use Vector3.zero instead of Vector3.new(0,0,0)
        end
    end)
end

if (config.anti_ragdoll) then
    -- i could use humanoid.StateChanged but this is easier (https://en.wikipedia.org/wiki/Trollface)
    cons.antiRagdoll = runServ.Heartbeat:Connect(function()
        if (clientHumanoid) then
            local state = clientHumanoid:GetState().Name
            if (state == 'FallingDown' or state == 'Ragdoll') then
                clientHumanoid:ChangeState(10) 
            end
        end
    end)
end

if (config.limit_velocity) then
    local sens = config.limit_velocity_sensitivity
    local slow = config.limit_velocity_slow
    
    
    cons.limitVelocity = runServ.Stepped:Connect(function()
        if (clientRoot) then
            local vel = clientRoot.Velocity
            if (vel.Magnitude > sens) then
                -- effectively clamp velocity
                clientRoot.Velocity = vel.Unit * slow
            end
        end
    end)
end

if (config.anchor) then
    local dist = config.anchor_dist
    
    if (config.smart_anchor) then
        cons.anchor = runServ.Stepped:Connect(function() 
            local clientPosition = clientRoot.Position
            
            clientRoot.Anchored = false
            for _, plr in ipairs(playerServ:GetPlayers()) do 
                if (plr ~= clientPlr and plr.Character) then
                    local plrRp = plr.Character:FindFirstChild('HumanoidRootPart')
                    if (plrRp and plrRp.RotVelocity.Magnitude > 100 and (plrRp.Position - clientPosition).Magnitude < dist) then
                        clientRoot.Anchored = true
                        break
                    end
                end
            end    
        end)
    else
        cons.anchor = runServ.Stepped:Connect(function() 
            local clientPosition = clientRoot.Position
            
            clientRoot.Anchored = false 
            for _, plr in ipairs(playerServ:GetPlayers()) do 
                if (plr ~= clientPlr and plr.Character) then
                    local plrRp = plr.Character:FindFirstChild('HumanoidRootPart')
                    if (plrRp and (plrRp.Position - clientPosition).Magnitude < dist) then
                        clientRoot.Anchored = true
                        break
                    end
                end
            end    
        end)
    end
end


if (config.teleport) then
    local dist = config.teleport_dist
    
    if (config.smart_teleport) then
        cons.teleport = runServ.Stepped:Connect(function() 
            local clientPosition = clientRoot.Position
            
            for _, plr in ipairs(playerServ:GetPlayers()) do 
                if (plr ~= clientPlr and plr.Character) then
                    local plrRp = plr.Character:FindFirstChild('HumanoidRootPart')
                    if (plrRp and plrRp.RotVelocity.Magnitude > 5 and (plrRp.Position - clientPosition).Magnitude < dist) then
                        clientRoot.CFrame += vec3.new(math.random(-100, 100), 5, math.random(-100, 100))
                        break
                    end
                end
            end    
        end)
    else
        cons.teleport = runServ.Stepped:Connect(function() 
            local clientPosition = clientRoot.Position
            
            for _, plr in ipairs(playerServ:GetPlayers()) do 
                if (plr ~= clientPlr and plr.Character) then
                    local plrRp = plr.Character:FindFirstChild('HumanoidRootPart')
                    if (plrRp and (plrRp.Position - clientPosition).Magnitude < dist) then
                        clientRoot.CFrame += vec3.new(math.random(-100, 100), 5, math.random(-100, 100))
                        break
                    end
                end
            end    
        end)
    end
end

-- final notif 
sGuiServ:SetCore('SendNotification', {
	Title = 'antifling';
	Text = 'ready to go\n\nif you change any setting re-exec the script to refresh it';
	Duration = 4;
})
