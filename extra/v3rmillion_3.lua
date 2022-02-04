local players = game:GetService("Players")
local plr = players.LocalPlayer

local cmds = {} do
    cmds['bring'] = function(caller, ...) 
        plr.Character.HumanoidRootPart.CFrame = caller.Character.HumanoidRootPart.CFrame
    end
    cmds['test2'] = function(caller, ...) 
        if (caller == plr) then
            plr.Character.HumanoidRootPart.CFrame += Vector3.new(0, 5, 0)
        end
    end
    cmds['test'] = function(caller, ...) 
        print(("%s just used test!"):format(caller.Name))
        print("Amount of args: "..tostring(#({...})))
        print("Args: "..table.concat({...}," "))
    end
    -- etc etc etc
end

local function split(msg)
    local a = {}
    
    for m in msg:gmatch("%s([^%s]+)") do 
        a[#a+1] = m
    end
    return a
end

local prefix = ';'
local function hook(p) 
    -- Hook the chat connection to each player
    p.Chatted:Connect(function(msg) 
        -- Check if their message starts with the prefix 
        if (msg:sub(1,1) == prefix) then
            -- Get the arguments
            local args = split(msg)
            -- Get the command
            local cmd = msg:match(prefix..'([^%s]+)%s?')
            if (cmds[cmd]) then
                cmds[cmd](p, unpack(args)) -- Fire the command function
            end
        end
    end)
end

for _,p in ipairs(players:GetPlayers()) do hook(p) end
players.PlayerAdded:Connect(hook)
