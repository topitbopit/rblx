local plr = game.Players.LocalPlayer
local pscs = plr.PlayerScripts
local pgui = plr.PlayerGui

local getconstants = getconstants or debug.getconstants
local getconstant = getconstant or debug.getconstant

local out = printconsole or function(a) print(a) end


do
    out("Checking for anti-lagswitch script",0,255,255)
    local got = false
    
    for _,script in ipairs(pscs:GetChildren()) do 
        if (script.Name == "LocalScript") then
            local closure = getscriptclosure(script)
            
            local s, b = pcall(getconstant, closure, 26)
            
            if (s and b == 'BADMON') then
                got = true
                script:Destroy()
                break
            end
        end
    end
    
    if (got) then
        out('Bypassed anti-lagswitch',0,255,0)
    else
        out('Couldn\'t find it',255,0,0)
    end
end

do
    out("Checking for anti-noclip script",0,255,255)
    local got = 0
    
    local sc = pgui:FindFirstChild("Noclip patch")
    
    if (sc) then
        local closure = getscriptclosure(sc)
        
        local c1 = getconstant(closure, 10)
        local c2 = getconstant(closure, 15)
        
        if (c1 == 'return clip'and c2 == 'stacks') then
            got = 2
            sc:Destroy()
        else
            got = 1
        end
    end

    if (got == 2) then
        out('Bypassed anti-noclip',0,255,0)
    elseif (got == 1) then
        out('Anti-noclip seems to have changed / been updated',255,255,0)
    else
        out('Couldn\'t find it',255,0,0)
    end
end

do 
    out("Checking for anti-speedhack script",0,255,255)
    local got = false
    local sc = pgui:FindFirstChild("SkyboxRenderMode")
    
    if (sc) then
        sc.Disabled = true
    end
    out('Bypassed anti-speedhack',0,255,0)
end
