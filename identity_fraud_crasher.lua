-- Identity fraud "crash" script
-- Game link: https://www.roblox.com/games/338521019/Identity-Fraud-Revamp
-- Press Numpad one to increase the pen size
-- Press Numpad two to decrease the pen size
-- Press numpad three to toggle the pen



local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local t = game:GetService("ReplicatedStorage").Mark

local l_chr = game.Players.LocalPlayer.Character
local l_humrp = l_chr.HumanoidRootPart

local cfn, vec3 = CFrame.new, Vector3.new




local size = 1
local is_placing = false

local place

local printconsole = printconsole or print

local function placesmall() 
    t:FireServer(l_humrp.CFrame)
end
local function placebig() 
    local base = l_humrp.CFrame
    
    for x = -size,size do 
        
        for z = -size,size do 
            t:FireServer(base + vec3(x,0,z))
        end
    end
end

place = placesmall

_G.con = uis.InputBegan:Connect(function(io,gpe) 
    if (io.KeyCode == Enum.KeyCode.KeypadOne) then
        size += 1
        
        size = (size > 10 and 10 or size)
        place = (size == 0) and placesmall or placebig
        
        printconsole("size: "..size, 25, 0, 255)
        return
    end
    if (io.KeyCode == Enum.KeyCode.KeypadTwo) then
        size -= 1
        
        size = (size < 0 and 0 or size)
        place = (size == 0) and placesmall or placebig
        
        printconsole("size: "..size, 25, 0, 255)
        return
    end
    if (io.KeyCode == Enum.KeyCode.KeypadThree) then
        is_placing = not is_placing
        
        if (is_placing) then
            printconsole("placing: yes", 25, 255, 25)
            rs:BindToRenderStep("j",2000,function() 
                place()
            end)
        else
            printconsole("placing: no", 255, 25, 25)
            rs:UnbindFromRenderStep("j")
        end
    end
end)
