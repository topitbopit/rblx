local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

--Windows hold menus (only 1 menu can be used per window for version 2.0.0-alpha)
local window = ui:NewWindow("Example window", 400, 300)

--Menus hold labels, buttons, sliders, and everything else
local menu = window:NewMenu("Example menu")

--Labels can act like section headers, a separate object for inlined text will be added soon
menu:NewLabel("Example section")

--Buttons let you fire a function on click
local button = menu:NewButton("Example button")

button.OnClick:Connect(function() 
    button:SetText("Click!")
end)


--Textboxes are for simple user input, a separate hotkey object will be added soon
local textbox = menu:NewTextbox("Example textbox")

textbox.OnFocusLost:Connect(function(text, enter) 
    if enter then
        textbox:SetText("Enter was pressed") 
    else
        textbox:SetText("Did you accidentally cancel typing?")
        wait(1)
        textbox:SetText(text)
    end
end)

--Sliders are useful but can only be in range from 0 to 999. For more specific numbers textboxes are better
--If you want to get a number from 0 to 1 you can make it 0 to 10 and divide the result, though.
--They're a little buggy right now but will be improved eventually!
local slider = menu:NewSlider("Example slider", 0, 20, 0)

local slider_msg

slider.OnFocusGained:Connect(function() 
    slider_msg = ui:NewMessagebox("Slider", "Value: "..slider:GetValue()) 
end)

slider.OnFocusLost:Connect(function() 
    slider_msg:Close()
end)

slider.OnValueChanged:Connect(function(value) 
    slider_msg:SetDesc("Value: "..value)
end)


--Toggles can be on or off
local toggle = menu:NewToggle("Example toggle")

toggle.OnEnable:Connect(function() 
    slider:SetValue(10)
end)

toggle.OnDisable:Connect(function() 
    slider:SetValue(5)
end)

--Dropdowns can have infinite amounts of options but somewhere between 1 and 4 is recommended.
local dropdown = menu:NewDropdown("Example dropdown", {"Option 1", "Option 2"})

dropdown.OnSelection:Connect(function(name, index) 
    print("Selected button "..index..", which is "..name)
end)

--Messageboxes can have titles, descriptions, and any amount of buttons
ui:NewMessagebox("Message box", "Example text", {{Text = "Ok", Callback = function(self) 
    self:SetDesc("Goodbye!") 
    wait(1) 
    self:Close() 
end}})

--For no buttons, pass the button table as {} like this vv
--ui:NewMessagebox("Message box", "Example text", {})


--When you're finished making objects, call ui:Ready() to finish everything off
ui:Ready()
--Do NOT make objects after you've readied!
--You can assign callbacks to their events afterwards, though
