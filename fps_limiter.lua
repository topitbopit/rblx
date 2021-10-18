setfpscap(144)
if not game:IsLoaded() then game.Loaded:Wait() end

local uis = game:GetService("UserInputService")
local size = workspace.CurrentCamera.ViewportSize

local a = Drawing.new("Text")
a.Visible = true
a.Size = 16
a.Color = Color3.fromRGB(0, 255, 255)
a.Text = "Maximized"
a.Font = Drawing.Fonts.Plex
a.Outline = true
a.OutlineColor = Color3.new(.1,.1,.1)
a.Position = Vector2.new((size.X - a.TextBounds.X) - 10, (size.Y - a.TextBounds.Y) - 25)

local b = Drawing.new("Text")
b.Visible = true
b.Size = 16
b.Color = Color3.fromRGB(0, 255, 0)
b.Text = "Cap: 144"
b.Font = Drawing.Fonts.Plex
b.Outline = true
b.OutlineColor = Color3.new(.1,.1,.1)
b.Position = Vector2.new((size.X - b.TextBounds.X) - 10, (size.Y - b.TextBounds.Y) - 10)

uis.WindowFocused:Connect(function() 
    setfpscap(144)
    a.Text = "Maximized"
    b.Text = "Cap: 144"
end)

uis.WindowFocusReleased:Connect(function() 
    setfpscap(15)
    a.Text = "Minimized"
    b.Text = "Cap: 15"
end)
