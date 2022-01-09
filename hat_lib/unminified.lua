local notifs = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AbstractPoo/Main/main/Notifications.lua')))()


local vec3, cfn, ins, rem = Vector3.new, CFrame.new, table.insert, table.remove
local serv_rs = game:GetService('RunService')
local serv_players = game:GetService('Players')

local l_plr = serv_players.LocalPlayer
local l_chr = l_plr.Character
local l_humrp = l_chr and l_chr:FindFirstChild('HumanoidRootPart')

local stepped = serv_rs.RenderStepped
local wait,delay,spawn = task.wait, task.delay, task.spawn


local module = {} do 
    module.RespawnConnection = l_plr.CharacterAdded:Connect(function(c) 
        l_chr = c
        l_humrp = c:WaitForChild('HumanoidRootPart', 3)
    end)
    module.BlockifyHats = true
    module.NetIntensity = 80
    module.DisableFlicker = false
    
    
    local fake_hats = {}
    local hats = {}
    local running = true
    
    local hat_obj_mt = {} do 
        hat_obj_mt.__index = function(a,b) 
            -- If the user tries to get position then
            -- return the fake hat's position
            -- so it isn't all wonky
            if (b == 'CFrame') then
                return rawget(a, 'root')[b]
            end
            -- Otherwise return desired value
            return rawget(a,b)
        end
        hat_obj_mt.__newindex = function(a,b,c) 
            if (b == 'CFrame') then
                rawget(a, 'root')['CFrame'] = c
                return
            end
            
            -- If its the real velocity or position then change the real parts property
            if (b == 'realvel') then
                --printconsole("Set velocity",0,0,255)
                rawget(a, 'real')['Velocity'] = c
                return
            end
            if (b == 'realcf') then 
                --printconsole("Set position",0,0,255)
                rawget(a, 'real')['CFrame'] = c
                return
            end
            -- Otherwise do a normal set
            rawset(a,b,c)
        end
    end
    
    function module.GetHat_Internal() 
        local accessory = l_chr:FindFirstChildOfClass('Accessory')
        local oldaccessory = accessory
        accessory = accessory and accessory.Handle
        if (not accessory) then return nil end
        
        local fake_hat = Instance.new('Part')
        fake_hat.Transparency = 1
        fake_hat.Anchored = true
        fake_hat.CanTouch = false
        fake_hat.CanCollide = false
        fake_hat.Size = vec3(1,1,1)
        fake_hat.Parent = workspace
        
        ins(fake_hats, fake_hat)
        
        
        if (module.BlockifyHats) then
            local mesh = accessory:FindFirstChildOfClass('SpecialMesh') or accessory:FindFirstChildOfClass('Mesh')
            if mesh then mesh:Destroy() end
        end
        
        if (module.DisableFlicker) then
            fake_hat.Transparency = 0
            accessory.Transparency = 1
            
            fake_hat.Size = accessory.Size
            fake_hat.BottomSurface = "Smooth"
            fake_hat.TopSurface = "Smooth"
        end
        
        local weld = accessory:FindFirstChildOfClass('Weld')
        if (weld) then weld:Destroy() end
        
        accessory.Parent = fake_hat
        oldaccessory:Destroy()
        
        return accessory, fake_hat
    end
    
    function module:NewHat()
        local obj = setmetatable({}, hat_obj_mt)
        
        local realhat, fakehat = module.GetHat_Internal()
        
        if (not realhat) then 
            warn('Couldn\'t make hat, no more hats on char')
            return nil
        end
        
        rawset(obj, 'real', realhat)
        rawset(obj, 'root', fakehat)
        
        ins(hats, obj)
        
        return obj
    end
    
    function module:ClearHats() 
        for i,v in ipairs(hats) do 
            rawget(v, 'root'):Destroy()
            rawget(v, 'real'):Destroy()
            v = nil
        end
        hats = nil
        for i,v in ipairs(fake_hats) do 
            v:Destroy() 
        end
        fake_hats = nil
    end
    
    function module:Exit() 
        module:ClearHats()
        
        module.RespawnConnection:Disconnect()
        
        running = false
        
        notifs:message({
            Title = 'Jeff\'s Hat Lib unloaded';
            Description = 'Goodbye!';
            Length = 2;
            Icon = 6023426926
        })
    end

    
    
    
    
    spawn(function() 
        while true do
            if (not running) then return end
            
            for idx,hat in ipairs(hats) do
                hat.realcf = hat.CFrame
            end
            stepped:Wait(stepped)
            
            if (not running) then return end
            
            local p1 = l_humrp.Position
            local p2 = module.NetIntensity
            
            for idx,hat in ipairs(hats) do 
                hat.realvel = cfn(hat.CFrame.Position, p1).LookVector * p2
            end
            stepped:Wait(stepped)
        end
    end)

end

notifs:message({
    Title = 'Jeff\'s Hat Lib loaded';
    Description = 'Made by topit';
    Length = 3;
    Accept = {
        Text = 'Ok';
    };
    Icon = 6023426926
})


delay(3.25, function() 
    local ms = game:GetService('Stats').FrameRateManager.RenderAverage:GetValue()
    if (ms > 8) then
        
        notifs:notify({
            Title = 'Warning';
            Description = 'Your FPS seems to be low (<144).\nStability issues with the net may occur';
            Length = 6;
            Accept = {
                Text = 'Ok, set cap to 144';
                Callback = function() 
                    local f = (setfpscap or set_fps_cap)
                    if (f) then
                        f(144)

                        notifs:notify({
                            Title = 'Changed cap successfully';
                            Description = 'Doesn\'t work? Check console for more info';
                            Length = 3;
                        })
                        if (identifyexecutor():match("Synapse")) then
                            print("It looks like you're using Synapse!")
                            print("Make sure to have Unlock FPS enabled in options,\nthen restart roblox and try again")
                        else
                            print("Make sure your exploit's FPS unlocker option is enabled!")
                        end
                    else
                        notifs:notif({
                            Title = 'Something went wrong';
                            Description = 'Missing function setfpscap / set_fps_cap\nCheck console for more info';
                            Length = 3;
                        })
                        print("It looks like your exploit is missing a valid FPS unlocker function")
                        print("You can download a safe, free FPS unlocker from https://github.com/axstin/rbxfpsunlocker/releases")
                        print("Alternatively, you can just run the script normally")
                    end
                    
                end
            },
            Dismiss = {
                Text = 'Ok'
            }
        })
    end
end)

return module
