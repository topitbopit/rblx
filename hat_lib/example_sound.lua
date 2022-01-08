-- Sound visualizer example
-- Not gonna bother commenting this one, check the orbit one for setup and math explanations
-- The visualizer itself kinda sucks but it shows what can be done

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local serv_ts = game:GetService("TweenService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

if (not l_humrp) then warn("Wait for the game to load!") return end 

local vec3,cfn,cfa = Vector3.new, CFrame.new, CFrame.Angles
local cos,sin,sqrt,rad,random = math.cos,math.sin,math.sqrt, math.rad, math.random
local ins, rem = table.insert, table.remove

local makeinfo, _e1, _e2 = TweenInfo.new, Enum.EasingDirection.Out, Enum.EasingStyle.Exponential

local function twn(object)
    local tween = serv_ts:Create(
        object, 
        makeinfo(
            .15, 
            _e2,
            _e1
            ),
        {Value = 0})
    
    tween:Play()
    return tween
end



local die_connection
local render_connection


local sb1
local sb2
local a
die_connection = l_char.Humanoid.Died:Connect(function() 
    library:Exit()
    
    hats = nil
    sb2 = nil
    
    die_connection:Disconnect()
    render_connection:Disconnect()
    
    a:Destroy()
    
end)


library.DisableFlicker = true
library.NetIntensity = 80

local hats = {} do 
    while true do
        local hat = library:NewHat()
        if hat then
            ins(hats, {
                hat;
            })
        else
            break
        end
    end
end

a = Instance.new("Sound")
a.SoundId = "rbxassetid://6577568420"
a.PlaybackSpeed = 1
a.Looped = true
a.Volume = 1
a.Parent = workspace
a:Play()

sb1 = {}
sb2 = {}
for i = 1, 10 do 
    local b = Instance.new("NumberValue", a)
    sb1[i] = b
    sb2[i] = 0
end

local time = 0
render_connection = rs_stepped:Connect(function(DeltaTime) 
    time += DeltaTime + (sb1[1].Value*0.001)
    local humrp_pos = l_humrp.Position
    
    for index,hat in ipairs(hats) do
        local loudness = 4 + sb1[index].Value
        
        local c = time + ((index * .1)*7)
        local a, b = sin(c)*loudness, cos(c)*loudness
        local pos1 = (humrp_pos + vec3(a-b,1,a+b))
        hat[1].CFrame = cfn(pos1, humrp_pos)
    end
    
    
    for i = 1, 10 do
        sb2[i+1] = sb2[i]
        sb1[i].Value = sb2[i]
        twn(sb1[i])
        
    end
    sb2[1] = a.PlaybackLoudness * .03
end)
