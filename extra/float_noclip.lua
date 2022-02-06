local KEYBIND = Enum.KeyCode.G


local serv_uis     = game:GetService("UserInputService")
local serv_rs      = game:GetService("RunService")
local serv_players = game:GetService("Players")

local l_plr = serv_players.LocalPlayer
local l_cam = workspace.CurrentCamera

local vec3, vec2, c3n = Vector3.new, Vector2.new, Color3.new

local toggled = false

local noclip_conn
local float_conn

local text = Drawing.new("Text")
text.Color = c3n(0, 1, 1)
text.Font = 1
text.Outline = true
text.OutlineColor = c3n(0, 0, 0)
text.Position = vec2(20, l_cam.ViewportSize.Y - 35)
text.Size = 25
text.Text = "Noclip: Keybind is G"
text.Visible = true


l_cam:GetPropertyChangedSignal("ViewportSize"):Connect(function() 
    text.Position = vec2(20, l_cam.ViewportSize.Y - 35)
end)

KEYBIND = KEYBIND.Value
serv_uis.InputBegan:Connect(function(io) 
    if (io.KeyCode.Value == KEYBIND) then
        toggle = not toggle 

        if toggle then
            text.Text = "Noclip: on"
            text.Color = c3n(0, 1, 0)
            
            noclip_conn = serv_rs.Stepped:Connect(function() 
                local c = l_plr.Character:GetChildren()
                for i = 1, #c do
                    local v = c[i]
                    if (v:IsA("BasePart")) then
                        v.CanCollide = false
                    end
                end
            end)
            
            float_conn = serv_rs.Heartbeat:Connect(function() 
                local h = l_plr.Character.HumanoidRootPart
                local v = h.Velocity
                
                h.Velocity = vec3(v.X,1.3,v.Z)
            end)
        else
            text.Text = "Noclip: off"
            text.Color = c3n(1, 0, 0)
            
            noclip_conn:Disconnect()
            float_conn:Disconnect()
        end
    end
end)
