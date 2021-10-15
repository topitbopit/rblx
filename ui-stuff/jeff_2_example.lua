local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

--Windows hold menus
--Technically you can use multiple windows, but its janky and you need to ui:Ready() twice
local window = ui:NewWindow("Example window", 400, 300)

--Menus hold labels, buttons, sliders, and everything else
--as of 2.1.0-a, as many menus as you want can be used
local menu = window:NewMenu("Menu")
local menu2 = window:NewMenu("Menu2")
--Sections are for headers
menu:NewSection("Example section")

--Buttons let you fire a function on click
local button = menu:NewButton("Example button")

button.OnClick:Connect(function() 
    button:SetText("Click!")
end)


--Textboxes are for simple user input
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
local slider = menu:NewSlider("Example slider", 0, 20, 0)

menu:NewLabel("Sliders can be both hard dragged (MB1) and")
menu:NewLabel("soft dragged (MB2).") --Label text wrapping isn't implemented yet but will be soon.
menu:NewLabel("You can also type in the value!")
menu:NewLabel("")
slider.OnFocusLost:Connect(function() 
    ui:NewNotification("Slider", "Goodbye!")
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
menu:NewLabel("")
menu:NewLabel("")
menu:NewLabel("")

menu:NewSection("Credits")

local discord = menu:NewButton("Copy discord link")
discord.OnClick:Connect(function() 
    ui:NewNotification("Thanks!", "", 3) 
    setclipboard("https://discord.gg/Gn9vWr8DJC") 
end)


menu:NewLabel("Made by topit")


dropdown.OnSelection:Connect(function(name, index) 
    ui:NewNotification("Dropdown", "Selected button "..index..", which says \""..name.."\".", 2)
end)

--Messageboxes can have titles, descriptions, and any amount of buttons
ui:NewMessagebox("Message box", "Example text", {{Text = "Ok", Callback = function(self) 
    self:SetDesc("Cya") 
    wait(1) 
    self:Close() 
end}})

--For no buttons, pass the button table as {}, like this
--ui:NewMessagebox("Message box", "Example text", {})

--For a simpler method of showing information, use a notification
ui:NewNotification("New Notification", "Hello world!", 5)



--When you're finished making objects, call ui:Ready() to finish everything off
ui:Ready()
--Do NOT make window objects after you've readied!
--Assigning callbacks to events still works on window objects.
--Notifications and messageboxes do work properly.
