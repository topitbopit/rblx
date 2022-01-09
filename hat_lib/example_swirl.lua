-- Swirl example

local library = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/hat_lib/main.lua'))()

local serv_rs = game:GetService("RunService")
local rs_stepped = serv_rs.RenderStepped

local l_plr = game:GetService("Players").LocalPlayer
local l_char = l_plr.Character
local l_humrp = l_char and (l_char:FindFirstChild("HumanoidRootPart") or l_char:WaitForChild("HumanoidRootPart",3)) or nil

if (not l_humrp) then warn("Wait for the game to load!") return end 

local vec3,cfn,cfa = Vector3.new, CFrame.new, CFrame.Angles
local cos,sin,rad = math.cos,math.sin,math.rad
local ins, rem = table.insert, table.remove

local die_connection
local render_connection

die_connection = l_char.Humanoid.Died:Connect(function() 
    library:Exit()
    
    hats = nil
    sb2 = nil
    
    die_connection:Disconnect()
    render_connection:Disconnect()
end)


library.DisableFlicker = true
library.NetIntensity = 80

local hats = {}
do
    while true do
        local hat = library:NewHat()
        if hat then
            ins(hats,hat)
        else
            break
        end
    end
end


local degrees = rad(36)

local time = 0
render_connection = rs_stepped:Connect(function(dt) 
    time += dt
    
    local humrp_pos = l_humrp.Position
    
    for idx,hat in ipairs(hats) do 
        local c = time + (((idx * degrees)+18)) -- Thanks https://math.stackexchange.com/questions/1092502/
        local a, b = sin(c)*4, cos(c)*4
        local pos1 = (humrp_pos + vec3(a-b,idx>5 and a or b,a+b))
        hat.CFrame = cfn(pos1, humrp_pos) * cfa(a,b,0)
    end
end)
