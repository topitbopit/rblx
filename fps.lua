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

if isfile("epicfps.txt") then
    if readfile("epicfps.txt"):match("%d+|%d+") then
        print'verified'
    else
        writefile("epicfps.txt","144|60")
    end
else
    writefile("epicfps.txt","144|60")
end

local _ = readfile("epicfps.txt"):split"|"
local max = _[1]
local min = _[2]

local w = ui:NewWindow("epic fps unlocker", 250, 200)
local m = w:NewMenu("stuff")

local unlocker = m:NewToggle("Unlock FPS")
local unfocused = m:NewToggle("Limit when unfocused")
local maxbox = m:NewTextbox("FPS max: "..max)
local minbox = m:NewTextbox("FPS min: "..min)

unlocker:SetTooltip("Unlocks your fps. When enabled, max amount ("..max..") is used and when disabled min amount ("..min..") is used")
unfocused:SetTooltip("When the window gets minimized, rendering is disabled and fps gets capped to prevent cpu and gpu usage")

maxbox:SetTooltip("FPS used when the unlocker is enabled")
minbox:SetTooltip("FPS used when the unlocker is disabled")

unlocker.OnToggle:Connect(function(t) 
    if t then
        setfpscap(max)
    else
        setfpscap(min)
    end
end)

maxbox.OnFocusLost:Connect(function(text) 
    local n = tonumber(text)
    if n == nil then
        maxbox:SetText("Not a number!")
    else
        max = math.floor(n)
        if max < 20 then
            local msg = ui:NewMessagebox("Are you sure?","Are you sure you want to set the max this low?",{{Text = "Yes", Callback = function(self) 
                maxbox:SetText("FPS max: "..max)
                writefile("epicfps.txt",max.."|"..min)
                
                setfpscap(unlocker:IsEnabled() and max or min)
                self:Close()
            end},{Text = "No", Callback = function(self)
                max = readfile("epicfps.txt"):split("|")[1]
                maxbox:SetText("FPS max: "..max)
                
                
                setfpscap(unlocker:IsEnabled() and max or min)
                self:Close()
            end}},40,-30)
        else
            maxbox:SetText("FPS max: "..max)
            writefile("epicfps.txt",max.."|"..min)
            
            
            setfpscap(unlocker:IsEnabled() and max or min)
        end
    end
end)

minbox.OnFocusLost:Connect(function(text) 
    local n = tonumber(text)
    if n == nil then
        minbox:SetText("Not a number!")
    else
        min = math.floor(n)
        if min < 20 then
            local msg = ui:NewMessagebox("Are you sure?","Are you sure you want to set the min this low?",{{Text = "Yes", Callback = function(self) 
                minbox:SetText("FPS min: "..min)
                writefile("epicfps.txt",max.."|"..min)
                
                
                setfpscap(unlocker:IsEnabled() and max or min)
                self:Close()
            end},{Text = "No", Callback = function(self)
                min = readfile("epicfps.txt"):split("|")[2]
                minbox:SetText("FPS min: "..min)
                
                setfpscap(unlocker:IsEnabled() and max or min)
                self:Close()
            end}},40,-30)
        else
            minbox:SetText("FPS min: "..min)
            writefile("epicfps.txt",max.."|"..min)
            
            setfpscap(unlocker:IsEnabled() and max or min)
        end
    end
end)

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local event_onfocus,event_focus

unfocused.OnEnable:Connect(function() 
    event_focus = uis.WindowFocused:Connect(function() 
        rs:Set3dRenderingEnabled(true)
        
        setfpscap(unlocker:IsEnabled() and max or min)
    end)
    event_onfocus = uis.WindowFocusReleased:Connect(function() 
        rs:Set3dRenderingEnabled(false)
        setfpscap(15)
    end)
end)

unfocused.OnDisable:Connect(function() 
    event_focus:Disconnect()
    event_onfocus:Disconnect()
end)

ui.Exiting:Connect(function() 
    _G.UnlockerLoaded = false
    _G.UnlockerUI = nil
    
    setfpscap(60)
end)


ui:Ready()
unlocker:Enable()

_G.UnlockerLoaded = true
_G.UnlockerUI = ui
ui:NewNotification("FPS unlocker loaded","Made by topit",4)
