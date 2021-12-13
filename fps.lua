if not game:IsLoaded() then game.Loaded:Wait() end

if _G.UnlockerLoaded == true then
    _G.UnlockerUI:NewNotification("FPS unlocker","Already loaded!",4)
    return 
end

local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()
ui:SetColors({
    window        = Color3.new(0.04,0.04,0.04);
    topbar        = Color3.new(0.05,0.05,0.05);
    text          = Color3.new(0.90,0.90,0.90);
    button        = Color3.new(0.12,0.12,0.13);
    scroll        = Color3.new(0.22,0.22,0.23);
    detail        = Color3.new(0.22,0.22,1.00);
    enabledbright = Color3.new(0.40,0.40,0.90);
    enabled       = Color3.new(0.40,0.40,1.00);
    textshade1    = Color3.new(0.40,0.40,1.00);
    textshade2    = Color3.new(0.60,0.10,1.00);
})
ui.TooltipX = 25

if not isfile("epicfps.txt") then
    writefile("epicfps.txt","60")
end
local fps = readfile("epicfps.txt")

local w = ui:NewWindow("epic fps unlocker", 250, 180)
local m = w:NewMenu("stuff")

local unlocker = m:NewToggle("Unlock FPS")
local unfocused = m:NewToggle("Limit when unfocused")
local amountbox = m:NewTextbox("FPS: "..fps)

unlocker.OnToggle:Connect(function(t) 
    if t then
        setfpscap(fps)
    else
        setfpscap(60)
    end
end)

amountbox.OnFocusLost:Connect(function(text) 
    local n = tonumber(text)
    
    if n == nil then
        amountbox:SetText("Not a number!")
    else
        fps = math.floor(n)
        if fps < 20 then
            local msg = ui:NewMessagebox("Are you sure?","Are you sure you want to set the cap this low?",{{Text = "Yes", Callback = function(self) 
                amountbox:SetText("FPS: "..fps)
                writefile("epicfps.txt",fps)
                
                if unlocker:IsEnabled() then
                    setfpscap(fps)
                end
                
                self:Close()
            end},{Text = "No", Callback = function(self)
                fps = readfile("epicfps.txt")
                amountbox:SetText("FPS: "..fps)
                setfpscap(fps)
                
                self:Close()
            end}},40,-30)
        else
            amountbox:SetText("FPS: "..fps)
            writefile("epicfps.txt",fps)
            
            if unlocker:IsEnabled() then
                setfpscap(fps)
            end
        end
    end
end)

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local event_onfocus,event_focus

unfocused.OnEnable:Connect(function() 
    event_focus = uis.WindowFocused:Connect(function() 
        rs:Set3dRenderingEnabled(true)
        setfpscap(unlocker:IsEnabled() and fps or 60)
    end)
    event_onfocus = uis.WindowFocusReleased:Connect(function() 
        rs:Set3dRenderingEnabled(false)
        setfpscap(20)
    end)
end)

unfocused.OnDisable:Connect(function() 
    event_focus:Disconnect()
    event_onfocus:Disconnect()
end)

ui.Exiting:Connect(function() 
    _G.UnlockerLoaded = false
    _G.UnlockerUI = nil
end)


ui:Ready()
unlocker:Enable()

_G.UnlockerLoaded = true
_G.UnlockerUI = ui
ui:NewNotification("FPS unlocker loaded","Made by topit",4)