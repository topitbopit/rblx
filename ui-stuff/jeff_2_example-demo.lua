-- Simple example demoing some features of the gui
-- Check out the jeff_2_example-gui to see what a simple speed gui would look like

-- Load in the library
local ui = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_2.lua'))()

-- Create the main window which will hold everything
local window = ui:NewWindow("Jeff 2 demo", 400, 300)

-- Menus are important for actually letting you do stuff
-- They can be switched using the button at the top left of the window
local menu = window:NewMenu("Menu")
local menu2 = window:NewMenu("Menu2")

-- Here's a section header. They're useful for separating
-- different types of modules and organization.
menu:NewSection("Example section")

-- Create a button
local button = menu:NewButton("Click me!")
-- Buttons can only be clicked, but they can have hotkeys bound to them

button:SetTooltip("Heres a button! Try clicking it")

button.OnClick:Connect(function() 
    ui:NewNotification("Nice!","You clicked the button!",3)
    button:Hide("Already clicked, too bad")
end)

-- Sliders are useful for choosing a number from a wide or small range
local slider = menu:NewSlider("Yo pick a number",0,10,5)

slider.OnValueChanged:Connect(function(v) 
    
    local a = ""
    for i = 0, v do
        a = a .. "ඞ" 
    end
    ui:NewNotification("ඞ count",a,1.5)    
end)


-- Dropdown
local dd = menu:NewDropdown("Dropdown",{"Yes","No","Maybe","Idk"})

dd.OnSelection:Connect(function()
    local val = math.random(0,3)
    if val == 3 then
        ui:NewNotification("Ey good choice", "Yeah i picked that too", 2)
    elseif val == 2 then
        ui:NewNotification("Ok choice", "I wouldn't pick it, but its ok", 2)
    elseif val == 1 then
        ui:NewNotification("That sucks", "Wtf why would you pick that", 2)
    elseif val == 0 then
        ui:NewNotification("No","Awful choice pls uninstall",2)
    end
end)

-- Textbox
local textbox = menu:NewTextbox("Type some stuff in")

textbox.OnFocusLost:Connect(function(text)
    ui:NewNotification(text, "", 2)
    textbox:SetText("Among us")
end)

-- Toggle
local toggle = menu:NewToggle("Toggle epic mode")

toggle.OnEnable:Connect(function() 
    ui:NewNotification("Epic mode enabled", ":D", 2)
end)

toggle.OnDisable:Connect(function() 
    ui:NewNotification("Epic mode disabled", ":(", 2)
end)


local name1 = {
    "among",
    "epic",
    "sussy",
    "jeff",
    "bob",
    "joey",
    "xX",
    "II_",
    "cold",
    "aeq",
    "233",
    "Raider"
}
local name2 = {
    "gamer",
    "460",
    "YT",
    "_TTV",
    "NoHoes",
    "Marku",
    "Matthias",
    "_micdown",
    "SRT"
}

local name = menu:NewButton("Make a username")
name.OnClick:Connect(function() 
    local new = name1[math.random(1, #name1)] .. name2[math.random(1, #name2)] .. tostring(math.random(10001,96836))
    ui:NewNotification("Your new name is",new,2)
end)
menu:NewLabel("Epic")
menu:NewLabel()
menu:NewTrim()

menu:NewLabel("Made by "..name1[math.random(1, #name1)] .. name2[math.random(1, #name2)] .. tostring(math.random(10001,96836)))


--Messageboxes can have titles, descriptions, and any amount of buttons
ui:NewMessagebox("Message box", "Here's a message box!", {
    {
        Text = "Ok", 
        Callback = function(self) 
            self:FadeText("Ok","Cya") 
            wait(1) 
            self:Close() 
        end
    }
}, 40)

--For no buttons, just pass the button table as an empty table, like this
--ui:NewMessagebox("Message box", "Example text", {})

--For a simpler method of showing information, use a notification
ui:NewNotification("New Notification", "Hello world!", 5)



--When you're finished making objects, call ui:Ready() to finish everything off
ui:Ready()
--Do NOT make window objects after you've readied!
--Doing anything else with the ui (callbacks, notifications, etc.) will work though

ui.Exiting:Connect(function() 
    for _,t in pairs(ui:GetAllToggles()) do
        t:Disable()    
    end
end)
