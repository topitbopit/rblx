local eventlistener = loadstring(game:HttpGet('https://raw.githubusercontent.com/topitbopit/misc-dependancies/main/RBXEvent.lua'))()

if _G.JUI2 then
    
    pcall(_G.JUI2) 
end

local plrs = game:GetService("Players")
local ts = game:GetService("TweenService")
local uis = game:GetService("UserInputService")
local ctx = game:GetService("ContextActionService")
local deb = game:GetService("Debris")
local rs = game:GetService("RunService")
local plr = plrs.LocalPlayer

local mouse = plr:GetMouse()

local screen = Instance.new("ScreenGui")

pcall(function() 
    syn.protect_gui(screen)
end)
pcall(function() 
    screen.Parent = gethiddengui()
end)
pcall(function() 
    screen.Parent = gethui()
end)

if screen.Parent == nil then
    screen.Parent = game.CoreGui
end


local ui = {}


local drag
local rdrag
local hdrag
local vdrag
local ctwn 
local twn
local getrand
local shadow
local round
local ceffect

function drag(detect, target) 
    target = target or detect
    local id = target:GetDebugId() .. getrand(5)
    
    ui.cons[id] = nil
    
    
    detect.InputBegan:Connect(function(old_input)
        if old_input.UserInputType == Enum.UserInputType.MouseButton1 then
            local starting_pos = target.Position
            
            local previnput = old_input.Position
        
            
            ui.cons[id] = uis.InputChanged:Connect(function(new_input)
                
                if new_input.UserInputType == Enum.UserInputType.MouseMovement then
                    
                    
                    local delta = new_input.Position - old_input.Position
                    
                    
                    twn(target, {Position = UDim2.new(
                        starting_pos.X.Scale, 
                        starting_pos.X.Offset + delta.X, 
                        starting_pos.Y.Scale, 
                        starting_pos.Y.Offset + delta.Y
                    )})
                    
                    
                    
                    previnput = new_input.Position
                end
            end)
        end
    end)
    
    detect.InputEnded:Connect(function(cur_input)
        if cur_input.UserInputType == Enum.UserInputType.MouseButton1 then
            pcall(function() ui.cons[id]:Disconnect() end)
        end
    end)
end


function rdrag(detect, target) 
    target = target or detect
    local id = target:GetDebugId() .. getrand(5)
    
    ui.cons[id] = nil
    
    detect.InputBegan:Connect(function(old_input)
        if old_input.UserInputType == Enum.UserInputType.MouseButton1 then
            local starting_pos = target.Position
            
            local previnput = old_input.Position
            
            
            ui.cons[id] = uis.InputChanged:Connect(function(new_input)
                
                if new_input.UserInputType == Enum.UserInputType.MouseMovement then
                    
                    
                    local delta = new_input.Position - old_input.Position
                    
                    
                    target.Rotation = target.Rotation - ((previnput.Magnitude - new_input.Position.Magnitude) * 0.1)
                    
                    twn(target, {Position = UDim2.new(
                        starting_pos.X.Scale, 
                        starting_pos.X.Offset + delta.X, 
                        starting_pos.Y.Scale, 
                        starting_pos.Y.Offset + delta.Y
                    ), Rotation = 0})
                    
                    
                    
                    previnput = new_input.Position
                end
            end)
        end
    end)
    
    detect.InputEnded:Connect(function(cur_input)
        if cur_input.UserInputType == Enum.UserInputType.MouseButton1 then
            pcall(function() ui.cons[id]:Disconnect() end)
        end
    end)
end

function ctwn(object, dest, delay, direction, style)
    delay = delay or 0.35
    direction = direction or "Out"
    style = style or "Circular"
    
    local tween = ts:Create(object, TweenInfo.new(delay, Enum.EasingStyle[style], Enum.EasingDirection[direction]), dest)
    tween:Play()
    return tween
end

function twn(object, dest)
    
    local tween = ts:Create(object, TweenInfo.new(0.25, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), dest)
    tween:Play()
    return tween
end

function getrand(count) 
    local str = ""
    for i = 1, count or 10 do
        str = str..utf8.char(math.random(20000,27000))
    end
    
    return str
end



function shadow(inst) 
    local among = Instance.new("ImageLabel")
    among.BackgroundTransparency = 1
    among.Image = "rbxassetid://7603818383"
    among.ImageColor3 = Color3.new(0, 0, 0)
    among.ImageTransparency = 0.15
    among.Position = UDim2.new(0.5, 0, 0.5, 0)
    among.AnchorPoint = Vector2.new(0.5, 0.5)
    among.Size = UDim2.new(1, 20, 1, 20)
    among.SliceCenter = Rect.new(15, 15, 175, 175)
    among.SliceScale = 1.3
    among.ScaleType = Enum.ScaleType.Slice
    among.ZIndex = inst.ZIndex - 1 
    among.Parent = inst

    return among
end


function round(inst)
    local among = Instance.new("UICorner")
    among.CornerRadius = UDim.new(0, 5)
    among.Parent = inst
    
    return among
end

function ceffect(parent) 
    local a = Instance.new("ImageLabel")
    a.Image = "rbxassetid://7620264743"
    a.AnchorPoint = Vector2.new(0.5, 0.5)
    a.Size = UDim2.new(0, 0, 0, 0)
    a.ZIndex = parent.ZIndex + 1 
    a.Position = UDim2.new(0.5, mouse.X - (parent.AbsolutePosition.X + (parent.Size.X.Offset / 2)), 0.5, mouse.Y - (parent.AbsolutePosition.Y + (parent.Size.Y.Offset / 2)))
    a.ImageTransparency = 0.5
    a.BackgroundTransparency = 1
    a.Parent = parent
    
    ctwn(a, {Size = UDim2.new(0, parent.AbsoluteSize.X+25, 0, parent.AbsoluteSize.X+25), ImageTransparency = 1}, 0.3)
    
    deb:AddItem(a, 0.3)
end

screen.Name = "C​hi​n​a​ #​1​! |"..getrand(15)

ui = {} do
    ui.__index = ui
    ui.minimized = false
    ui.cons = {}
    
    ui.colors = {
        window = Color3.fromRGB(20, 20, 20),
        topbar = Color3.fromRGB(22, 22, 22),
        text = Color3.fromRGB(230, 230, 255),
        button = Color3.fromRGB(43, 43, 43),
        scroll = Color3.fromRGB(130, 130, 130),
        detail = Color3.fromRGB(53, 53, 123),
        enabledbright = Color3.fromRGB(106, 106, 255),
        enabled = Color3.fromRGB(53, 53, 123),
        textshade1 = Color3.fromRGB(100, 100, 255),
        textshade2 = Color3.fromRGB(255, 100, 100)
    }
    
    ui.OnMinimize = eventlistener.new()
    ui.OnReady = eventlistener.new()
    
    function ui:SetColors(colors) 

        if colors == "red" then
            ui.colors = {
                window = Color3.fromRGB(12, 12, 12),
                topbar = Color3.fromRGB(14, 14, 14),
                text = Color3.fromRGB(225, 225, 225),
                button = Color3.fromRGB(170, 22, 22),
                scroll = Color3.fromRGB(130, 130, 130),
                detail = Color3.fromRGB(255, 53, 53),
                enabledbright = Color3.fromRGB(255, 153, 153),
                enabled = Color3.fromRGB(255, 35, 35),
                textshade1 = Color3.fromRGB(255, 70, 70),
                textshade2 = Color3.fromRGB(255, 70, 255)
            }
            
        elseif colors == "green" then
            ui.colors = {
                window = Color3.fromRGB(16, 16, 16),
                topbar = Color3.fromRGB(18, 18, 18),
                text = Color3.fromRGB(225, 225, 225),
                button = Color3.fromRGB(22, 170, 22),
                scroll = Color3.fromRGB(130, 130, 130),
                detail = Color3.fromRGB(53, 255, 53),
                enabledbright = Color3.fromRGB(133, 255, 153),
                enabled = Color3.fromRGB(35, 255, 35),
                textshade1 = Color3.fromRGB(70, 255, 70),
                textshade2 = Color3.fromRGB(0, 255, 255)
            }
        elseif colors == "blue" then
            ui.colors = {
                window = Color3.fromRGB(22, 22, 22),
                topbar = Color3.fromRGB(24, 24, 24),
                text = Color3.fromRGB(230, 230, 225),
                button = Color3.fromRGB(22, 22, 170),
                scroll = Color3.fromRGB(130, 130, 130),
                detail = Color3.fromRGB(53, 53, 255),
                enabledbright = Color3.fromRGB(133, 153, 255),
                enabled = Color3.fromRGB(35, 35, 255),
                textshade1 = Color3.fromRGB(70, 70, 255),
                textshade2 = Color3.fromRGB(255, 0, 255)
            }
            
        else
        
            
            colors.window = colors.window or ui.colors.window
            colors.topbar = colors.topbar or ui.colors.topbar
            colors.text = colors.text or ui.colors.text
            colors.button = colors.button or ui.colors.button
            colors.scroll = colors.scroll or ui.colors.scroll
            colors.detail = colors.detail or ui.colors.detail
            colors.enabledbright = colors.enabledbright or ui.colors.enabledbright
            colors.enabled = colors.enabled or ui.colors.enabled
            ui.colors = colors
        
        
        end
    end
    
    function ui:NewWindow(title, sizex, sizey) 
        title = title or getrand(10)
        sizex = sizex or 400
        sizey = sizey or 200
        
        
        local wind_menus = {}
        
        
        
        local window_window = Instance.new("Frame")
        window_window.BackgroundColor3 = ui.colors.window
        window_window.BorderSizePixel = 0
        window_window.Size = UDim2.new(0, sizex, 0, sizey)
        window_window.Position = UDim2.new(0, 20, 0, 20)
        window_window.ZIndex = 20
        
        
        local window_clip1 = window_window:Clone()
        
        shadow(window_window)
        window_clip1.Parent = screen
        window_clip1.BackgroundTransparency = 1
        window_clip1.ClipsDescendants = true
        window_clip1.Position = UDim2.new(1, -520, 1, -520)
        window_clip1.Size = UDim2.new(0, sizex+100, 0, 0)
        window_window.Parent = window_clip1
        
        
        
        local window_menureg = Instance.new("Frame")
        window_menureg.Size = UDim2.new(1, 0, 1, -30)
        window_menureg.Position = UDim2.new(0, 0, 0, 30)
        window_menureg.BackgroundTransparency = 1
        window_menureg.ZIndex = 21
        window_menureg.Parent = window_window
        
        
        local window_topbar = Instance.new("Frame")
        window_topbar.BackgroundColor3 = ui.colors.topbar
        window_topbar.BorderSizePixel = 0
        window_topbar.Size = UDim2.new(1, 0, 0, 30)
        window_topbar.Position = UDim2.new(0, 0, 0, 0)
        window_topbar.ZIndex = 30
        window_topbar.Active = true
        window_topbar.Parent = window_window
        
        local window_fade1 = Instance.new("ImageLabel")
        window_fade1.Size = UDim2.new(1, 0, 0, 30)
        window_fade1.Position = UDim2.new(0, 0, 1, -30)
        window_fade1.ZIndex = 29
        window_fade1.Active = false
        window_fade1.BackgroundTransparency = 1
        window_fade1.Image = "rbxassetid://7668647110"
        window_fade1.ImageColor3 = ui.colors.window
        window_fade1.Parent = window_menureg
        
        local window_fade2 = Instance.new("ImageLabel")
        window_fade2.Size = UDim2.new(1, 0, 0, 30)
        window_fade2.Position = UDim2.new(0, 0, 0, 0)
        window_fade2.ZIndex = 29
        window_fade2.Active = false
        window_fade2.Rotation = 180
        window_fade2.BackgroundTransparency = 1
        window_fade2.Image = "rbxassetid://7668647110"
        window_fade2.ImageColor3 = ui.colors.window
        window_fade2.Parent = window_menureg
        
        
        local window_title = Instance.new("TextLabel")
        window_title.Text = title
        window_title.BackgroundTransparency = 1
        window_title.TextTransparency = 1
        window_title.TextColor3 = ui.colors.text
        window_title.Font = Enum.Font.Nunito
        window_title.TextSize = 25
        window_title.Size = UDim2.new(1, -60, 1, 0)
        window_title.Position = UDim2.new(0, 5, 0, 0)
        window_title.TextXAlignment = Enum.TextXAlignment.Left
        window_title.ZIndex = 31
        window_title.Parent = window_topbar
        
        local window_clip2 = Instance.new("Frame")
        window_clip2.Visible = true
        window_clip2.ClipsDescendants = true
        window_clip2.Position = UDim2.new(0, 0, 0, 0)
        window_clip2.Size = UDim2.new(1, 0, 0, 0)
        window_clip2.BackgroundTransparency = 1
        window_clip2.ZIndex = 0
        window_clip2.Parent = window_topbar
        
        local window_bclose = Instance.new("TextButton")
        window_bclose.Text = "X"
        window_bclose.ClipsDescendants = true
        window_bclose.AutoButtonColor = false
        window_bclose.BackgroundColor3 = ui.colors.button
        window_bclose.BackgroundTransparency = 1
        window_bclose.BorderSizePixel = 0
        window_bclose.TextColor3 = ui.colors.text
        window_bclose.Font = Enum.Font.Nunito
        window_bclose.TextSize = 19
        window_bclose.Size = UDim2.new(0, 30-4, 0, 30-4)
        window_bclose.Position = UDim2.new(1, -30+2, 0, 2)
        window_bclose.ZIndex = 31
        window_bclose.Parent = window_clip2
        round(window_bclose)
        
        window_bclose.MouseEnter:Connect(function() 
            twn(window_bclose, {BackgroundTransparency = 0})
        end)
        
        window_bclose.MouseLeave:Connect(function() 
            twn(window_bclose, {BackgroundTransparency = 1})
        end)
        
        local window_bmin = Instance.new("TextButton")
        window_bmin.Text = "-"
        window_bmin.AutoButtonColor = false
        window_bmin.ClipsDescendants = true
        window_bmin.BackgroundColor3 = ui.colors.button
        window_bmin.BackgroundTransparency = 1
        window_bmin.BorderSizePixel = 0
        window_bmin.TextColor3 = ui.colors.text
        window_bmin.Font = Enum.Font.Nunito
        window_bmin.TextSize = 19
        window_bmin.Size = UDim2.new(0, 30-4, 0, 30-4)
        window_bmin.Position = UDim2.new(1, -60+2, 0, 2)
        window_bmin.ZIndex = 31
        window_bmin.Parent = window_clip2
        round(window_bmin)
        
        window_bmin.MouseEnter:Connect(function() 
            twn(window_bmin, {BackgroundTransparency = 0})
        end)
        
        window_bmin.MouseLeave:Connect(function() 
            twn(window_bmin, {BackgroundTransparency = 1})
        end)
    
        
        local window_bmenu = Instance.new("TextButton")
        window_bmenu.Text = "="
        window_bmenu.AutoButtonColor = false
        window_bmenu.ClipsDescendants = true
        window_bmenu.BackgroundTransparency = 1
        window_bmenu.BackgroundColor3 = ui.colors.button
        window_bmenu.BorderSizePixel = 0
        window_bmenu.TextColor3 = ui.colors.text
        window_bmenu.Font = Enum.Font.Nunito
        window_bmenu.TextSize = 19
        window_bmenu.Size = UDim2.new(0, 30-4, 0, 30-4)
        window_bmenu.Position = UDim2.new(0, 2, 0, 2)
        window_bmenu.ZIndex = 31
        window_bmenu.Parent = window_clip2
        round(window_bmenu)
        
        local menu_popup = Instance.new("Frame")

        
        
        window_bmenu.MouseEnter:Connect(function() 
            twn(window_bmenu, {BackgroundTransparency = 0})
        end)
        
        window_bmenu.MouseLeave:Connect(function() 
            twn(window_bmenu, {BackgroundTransparency = 1})
        end)
        
        window_bmenu.MouseButton1Click:Connect(function() 
            ceffect(window_bmenu)
        end)
        
        
        
        
        
        
        
        
        window_bmin.MouseButton1Click:Connect(function()
            ceffect(window_bmin)
            ui.minimized = not ui.minimized
            
            if ui.minimized then
                twn(window_window, {Size = UDim2.new(0, sizex, 0, 30)})
                twn(window_fade1, {Size = UDim2.new(1, 0, 0, 0)})
                twn(window_fade2, {Size = UDim2.new(1, 0, 0, 0)})
                window_bmin.Text = "+"
            else
                twn(window_window, {Size = UDim2.new(0, sizex, 0, sizey)})
                twn(window_fade1, {Size = UDim2.new(1, 0, 0, 30)})
                twn(window_fade2, {Size = UDim2.new(1, 0, 0, 30)})
                window_bmin.Text = "-"
            end
            ui.OnMinimize:Fire(ui.minimized)
        end)
        
        window_bclose.MouseButton1Click:Connect(function() 
            ceffect(window_bmin)
            task.spawn(function() 
                
                
                local a = Instance.new("UIScale")
                a.Scale = 1 
                a.Parent = window_window
                
                ctwn(window_window, {Position = window_window.Position + UDim2.new(0, 0, 0, 50)}, 1.75, "Out", "Exponential")
                ctwn(a, {Scale = 0.25}, 1, "Out", "Linear")
                for i,v in pairs(screen:GetDescendants()) do
                    pcall(function() 
                        twn(v, {BackgroundTransparency = 1})
                        twn(v, {ScrollBarImageTransparency = 1})
                    end)
                    pcall(function() 
                        twn(v, {TextTransparency = 1})
                    end)
                    pcall(function() 
                        twn(v, {ImageTransparency = 1})
                    end)
                    
                    deb:AddItem(v, 0.25)
                end
            end)
            
            wait(0.8)
            
            screen:Destroy()
        end)
        
        window_bmenu.MouseButton1Click:Connect(function() 
            
        end)
        
        ui.OnReady:Connect(function() 
            window_window.Size = UDim2.new(0, sizex, 0, 0)
            window_window.Position = UDim2.new(0, 20, 0, 20)
            
            
            local a = Instance.new("UIScale")
            a.Scale = 0.25
            a.Parent = window_window

            twn(a, {Scale = 1})
            
            ctwn(window_clip1, {Size = UDim2.new(0, sizex+100, 0, sizey+100)}, 0.75, "InOut", "Exponential")
            ctwn(window_window, {Size = UDim2.new(0, sizex, 0, sizey)}, 0.75, "InOut", "Exponential")
            wait(0.25)
            
            ctwn(window_clip2, {Size = UDim2.new(1, 0, 1, 0)}, 2, "Out", "Exponential")
            ctwn(window_title, {TextTransparency = 0, Size = UDim2.new(1, -100, 1, 0), Position = UDim2.new(0, 35, 0, 0)}, 0.75, "Out")
            wait(0.75)
            
            window_bmenu.Parent = window_topbar
            window_bclose.Parent = window_topbar
            window_bmin.Parent = window_topbar
            window_window.Parent = screen
            
            window_window.Position = UDim2.new(1, -500, 1, -500)
            window_clip2:Destroy()
            window_clip1:Destroy()
            drag(window_topbar, window_window)
        end)
        
        
        local w = {} do
            
            function w:NewMenu(text, desc, showtitle)
                showtitle = showtitle or true
                local menu_objects = {}
                
                
                local menu_menu = Instance.new("ScrollingFrame")
                menu_menu.BackgroundTransparency = 1
                menu_menu.BorderSizePixel = 0
                menu_menu.Size = UDim2.new(1, 0, 1, 0)
                menu_menu.Position = UDim2.new(0, 0, 0, 0)
                menu_menu.ZIndex = 22
                menu_menu.CanvasSize = UDim2.new(0, 0, 3, 0)
                menu_menu.TopImage = menu_menu.MidImage
                menu_menu.BottomImage = menu_menu.MidImage
                menu_menu.ScrollBarThickness = 0
                menu_menu.Parent = window_menureg
                
                local div = menu_menu.CanvasSize.Y.Scale + (menu_menu.CanvasSize.Y.Offset / menu_menu.Parent.AbsoluteSize.Y)
                
                local scroll = nil
                
                
                if div > 1 then
                
                    local menu_scroll = Instance.new("TextButton")
                    menu_scroll.BackgroundColor3 = ui.colors.scroll
                    menu_scroll.BackgroundTransparency = 0.7
                    menu_scroll.BorderSizePixel = 0
                    menu_scroll.Size = UDim2.new(0, 5, 1/div, -4)
                    menu_scroll.Position = UDim2.new(1, -7, 0, 2)
                    menu_scroll.ZIndex = 24
                    menu_scroll.Text = "|"
                    menu_scroll.TextScaled = true
                    menu_scroll.TextColor3 = ui.colors.scroll
                    menu_scroll.Font = Enum.Font.Code
                    menu_scroll.AutoButtonColor = false
                    menu_scroll.Parent = window_menureg
                    
                    round(menu_scroll)
                    
                    
                    menu_scroll.MouseEnter:Connect(function() 
                        twn(menu_scroll, {BackgroundTransparency = 0.5})
                    end)
                    
                    menu_scroll.MouseLeave:Connect(function() 
                        twn(menu_scroll, {BackgroundTransparency = 0.7})
                    end)
                    
                    
                    
                    local function handleScrollPos() 
                        local y = menu_menu.CanvasPosition.Y
                        
                        menu_scroll.Position = UDim2.new(1, -7, 0, (y/div)+2)
                    end
                    
                    local scrollConnection;
                    scrollConnection = menu_menu:GetPropertyChangedSignal("CanvasPosition"):Connect(handleScrollPos)
                    
                    menu_scroll.InputBegan:Connect(function(old_input)
                        if old_input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local starting_pos = menu_scroll.Position
                            
                            scrollConnection:Disconnect()
                            
                            ui.cons["ScrollDrag"] = uis.InputChanged:Connect(function(new_input)
                                
                                if new_input.UserInputType == Enum.UserInputType.MouseMovement then
                                    local delta = new_input.Position - old_input.Position
                                    
                                    twn(menu_scroll, {Position = UDim2.new(
                                        starting_pos.X.Scale, 
                                        starting_pos.X.Offset, 
                                        starting_pos.Y.Scale, 
                                        math.clamp(starting_pos.Y.Offset + delta.Y, 2, menu_menu.AbsoluteSize.Y - menu_scroll.AbsoluteSize.Y - 2)
                                    )})
                                
                                    twn(menu_menu, {CanvasPosition = Vector2.new(
                                        0,
                                        (starting_pos.Y.Offset + delta.Y)*div
                                    )})
                                end
                            end)
                        end
                    end)
                    
                    menu_scroll.InputEnded:Connect(function(cur_input)
                        if cur_input.UserInputType == Enum.UserInputType.MouseButton1 then
                            pcall(function() 
                                ui.cons["ScrollDrag"]:Disconnect() 
                            end)
                            scrollConnection = menu_menu:GetPropertyChangedSignal("CanvasPosition"):Connect(handleScrollPos)
                        end
                    end)
                    
                    ui.OnMinimize:Connect(function(toggle)
                        if toggle then 
                            twn(menu_scroll, {Size = UDim2.new(0, 5, 0, 0)})
                        else
                            twn(menu_scroll, {Size = UDim2.new(0, 5, 1/div, -4)})
                        end
                    end)
                
                end
                
                if showtitle then
                    local menu_label = Instance.new("TextLabel")
                    menu_label.Text = text
                    menu_label.BackgroundTransparency = 1
                    menu_label.TextTransparency = 0
                    menu_label.TextColor3 = ui.colors.text
                    menu_label.Font = Enum.Font.Nunito
                    menu_label.TextSize = 21
                    menu_label.Size = UDim2.new(1, -10, 0, 25)
                    menu_label.Position = UDim2.new(0, 10, 0, 0)
                    menu_label.TextXAlignment = Enum.TextXAlignment.Left
                    menu_label.ZIndex = 23
                    menu_label.Parent = menu_menu
                    
                    local among = Instance.new("UIGradient")
                    among.Color = ColorSequence.new{
                        ColorSequenceKeypoint.new(0, ui.colors.textshade1),
                        ColorSequenceKeypoint.new(1, ui.colors.textshade2)
                    }
                    among.Parent = menu_label 
                    
                    table.insert(menu_objects, menu_label)
                    
                    local trim = Instance.new("Frame")
                    trim.BackgroundTransparency = 0
                    trim.BackgroundColor3 = ui.colors.detail
                    trim.BorderSizePixel = 0
                    trim.Size = UDim2.new(1, -20, 0, 1)
                    trim.Position = UDim2.new(0, 10, 0, 25)
                    trim.ZIndex = 23
                    trim.Parent = menu_menu
                    
                end
                
                table.insert(wind_menus, {
                    ["menu_name"] = text,
                    ["menu_desc"] = desc,
                    ["menu"] = menu_menu,
                    ["scroll"] = menu_scroll
                })
                
                local m = {} do
                    
                    function m:GetChildren()
                        return menu_objects
                    end
                    
                    function m:GetChildCount()
                        return #menu_objects
                    end
                    
                    function m:NewLabel(text) 
                        local label_label = Instance.new("TextLabel")
                        label_label.Text = text
                        label_label.BackgroundTransparency = 1
                        label_label.TextTransparency = 0
                        label_label.TextColor3 = ui.colors.text
                        label_label.Font = Enum.Font.Nunito
                        label_label.TextSize = 21
                        label_label.Size = UDim2.new(1, -10, 0, 24)
                        label_label.Position = UDim2.new(0, 10, 0, (m:GetChildCount()*28)+3)
                        label_label.TextXAlignment = Enum.TextXAlignment.Left
                        label_label.ZIndex = 23
                        label_label.Parent = menu_menu
                        
                        table.insert(menu_objects, 2)
                        
                        local l = {} do
                            
                            function l:GetText() 
                                return label_label.Text
                            end 
                            
                            function l:SetText(txt) 
                                label_label.Text = txt
                            end
                        end
                        
                        return l
                    end
                    
                    function m:NewToggle(text, state)
                        state = state or false
                        text = text or getrand(7)
                        
                        
                        local toggle_state = state
                        
                        local OnEnable = eventlistener.new()
                        local OnToggle = eventlistener.new()
                        local OnDisable = eventlistener.new()
                        
                        local toggle_button = Instance.new("TextButton")
                        toggle_button.Text = text
                        toggle_button.AutoButtonColor = false
                        toggle_button.ClipsDescendants = true
                        toggle_button.BackgroundTransparency = 0.7
                        toggle_button.BackgroundColor3 = ui.colors.button
                        toggle_button.TextColor3 = ui.colors.text
                        toggle_button.Font = Enum.Font.Nunito
                        toggle_button.TextXAlignment = Enum.TextXAlignment.Left
                        toggle_button.TextSize = 19
                        toggle_button.Size = UDim2.new(0, menu_menu.AbsoluteSize.X-30, 0, 24)
                        toggle_button.Position = UDim2.new(0, 15, 0, ((m:GetChildCount())*28)+3)
                        toggle_button.ZIndex = 23
                        toggle_button.Parent = menu_menu
                        round(toggle_button)
                        
                        local toggle_pad = Instance.new("UIPadding")
                        toggle_pad.PaddingLeft = UDim.new(0, 10)
                        toggle_pad.Parent = toggle_button
                        
                        
                        local toggle_tbox = Instance.new("ImageLabel")
                        toggle_tbox.Active = false
                        toggle_tbox.BackgroundTransparency = 1
                        toggle_tbox.Image = "rbxassetid://7197977900"
                        toggle_tbox.ImageColor3 = ui.colors.text
                        toggle_tbox.Position = UDim2.new(1, -30, 0, -5)
                        toggle_tbox.Size = UDim2.new(0, 34, 0, 34)
                        toggle_tbox.Rotation = 0
                        toggle_tbox.ZIndex = 23
                        toggle_tbox.Parent = toggle_button
                        
                        local toggle_tcheck = Instance.new("ImageLabel")
                        toggle_tcheck.Active = false
                        toggle_tcheck.BackgroundTransparency = 1
                        toggle_tcheck.ImageTransparency = 1
                        toggle_tcheck.Image = "rbxassetid://7202619688"
                        toggle_tcheck.ImageColor3 = ui.colors.enabledbright
                        toggle_tcheck.Position = UDim2.new(1, -30, 0, -5)
                        toggle_tcheck.Size = UDim2.new(0, 34, 0, 34)
                        toggle_tcheck.Rotation = 0
                        toggle_tcheck.ZIndex = 24
                        toggle_tcheck.Parent = toggle_button
                        
                        
                        toggle_button.MouseEnter:Connect(function() 
                            twn(toggle_button, {BackgroundTransparency = 0})
                        end)
                        
                        toggle_button.MouseLeave:Connect(function() 
                            twn(toggle_button, {BackgroundTransparency = 0.7})
                        end)
                        
                        
                        local function toggle() 
                            
                            
                            toggle_state = not toggle_state
                            
                            
                            if (toggle_state) then
                                twn(toggle_button, {BackgroundColor3 = ui.colors.enabled})
                                twn(toggle_tcheck, {ImageTransparency = 0})
                                
                                OnToggle:Fire(true)
                                OnEnable:Fire()
                                
                            else
                                twn(toggle_button, {BackgroundColor3 = ui.colors.button})  
                                twn(toggle_tcheck, {ImageTransparency = 1})

                                OnToggle:Fire(false)
                                OnEnable:Fire()
                            end
                        end
                        
                        toggle_button.MouseButton1Click:Connect(function() 
                            ceffect(toggle_button)
                            toggle()
                        end)
                        
                        
                        table.insert(menu_objects, 1)
                        
                        local t = {} do
                            
                            function t:GetState() 
                                return toggle_state
                            end 
                            
                            function t:SetState(bool, callafter) 
                                callafter = callafter or true
                                
                                
                                xpcall(function() 
                                    toggle_state = bool    
                                end, function() 
                                    error("Did not pass SetState with boolean; sent with "..tostring(bool))
                                end)
                                
                                if callafter == true then
                                    toggle()
                                end
                            end
                            
                            function t:Toggle() 
                                toggle()
                            end
                            
                            function t:SetHotkey() 
                                
                            end
                            
                            function t:GetHotkey() 
                                
                            end
                            
                            t.OnDisable = OnDisable
                            t.OnEnable = OnEnable
                            t.OnToggle = OnToggle
                        end
                        
                        return t
                    end
                    
                    function m:NewButton(text)
                        text = text or getrand(7)
                        
                        local OnClick = eventlistener.new()
                        
                        local button_button = Instance.new("TextButton")
                        button_button.Text = text
                        button_button.AutoButtonColor = false
                        button_button.ClipsDescendants = true
                        button_button.BackgroundTransparency = 0.7
                        button_button.BackgroundColor3 = ui.colors.button
                        button_button.TextColor3 = ui.colors.text
                        button_button.Font = Enum.Font.Nunito
                        button_button.TextXAlignment = Enum.TextXAlignment.Left
                        button_button.TextSize = 19
                        button_button.Size = UDim2.new(0, menu_menu.AbsoluteSize.X-30, 0, 24)
                        button_button.Position = UDim2.new(0, 15, 0, ((m:GetChildCount())*28)+3)
                        button_button.ZIndex = 23
                        button_button.Parent = menu_menu
                        round(button_button)
                        
                        local button_pad = Instance.new("UIPadding")
                        button_pad.PaddingLeft = UDim.new(0, 10)
                        button_pad.Parent = button_button
                        
                        
                        local button_image = Instance.new("ImageLabel")
                        button_image.Active = false
                        button_image.Visible = false
                        button_image.BackgroundTransparency = 1
                        button_image.Image = "rbxassetid://7197977900"
                        button_image.ImageColor3 = ui.colors.text
                        button_image.Position = UDim2.new(1, -30, 0, -5)
                        button_image.Size = UDim2.new(0, 34, 0, 34)
                        button_image.Rotation = 0
                        button_image.ZIndex = 23
                        button_image.Parent = button_button

                        
                        
                        button_button.MouseEnter:Connect(function() 
                            twn(button_button, {BackgroundTransparency = 0})
                        end)
                        
                        button_button.MouseLeave:Connect(function() 
                            twn(button_button, {BackgroundTransparency = 0.7})
                        end)
                        
                        
                        
                        button_button.MouseButton1Click:Connect(function() 
                            ceffect(button_button)
                            OnClick:Fire()
                        end)
                        
                        
                        
                        
                        table.insert(menu_objects, 1)
                        
                        local t = {} do
                            
                            function t:Fire() 
                                OnClick:Fire()
                            end
                            
                            function t:SetCallback(cb) 
                                if type(cb) ~= "function" then
                                    error("SetCallback failed; provided value was not a function")
                                end
                                callback = cb
                            end
                            
                            function t:SetHotkey() 
                                
                            end
                            
                            function t:GetHotkey() 
                                
                            end
                            
                            function t:SetText(tx) 
                                if tx == nil then error("SetText failed; provided value was nil") end
                                button_button.Text = tostring(tx)
                            end
                            
                            function t:GetText() 
                                return button_button.Text
                            end
                            
                            t.OnClick = OnClick
                        end
                        
                        return t
                    end
                    
                    
                    function m:NewTextbox(text)
                        text = text or getrand(7)
                        
                        local OnFocusLost = eventlistener.new()
                        local OnFocusGained = eventlistener.new()
                        
                        local text_textbox = Instance.new("TextBox")
                        text_textbox.Active = true
                        text_textbox.Text = text
                        text_textbox.TextColor3 = ui.colors.text
                        text_textbox.PlaceholderText = "..."
                        text_textbox.BackgroundTransparency = 0.7
                        text_textbox.BackgroundColor3 = ui.colors.button
                        text_textbox.Size = UDim2.new(0, menu_menu.AbsoluteSize.X-30, 0, 24)
                        text_textbox.Position = UDim2.new(0, 15, 0, ((m:GetChildCount())*28)+3)
                        text_textbox.ZIndex = 23
                        text_textbox.Parent = menu_menu
                        text_textbox.Font = Enum.Font.Nunito
                        text_textbox.TextXAlignment = Enum.TextXAlignment.Left
                        text_textbox.TextSize = 19
                        round(text_textbox)
                        
                        local text_icon = Instance.new("ImageLabel")
                        text_icon.Active = false
                        text_icon.BackgroundTransparency = 1
                        text_icon.Image = "rbxassetid://7467053157"
                        text_icon.ImageColor3 = ui.colors.text
                        text_icon.Position = UDim2.new(1, -30, 0, -5)
                        text_icon.Size = UDim2.new(0, 34, 0, 34)
                        text_icon.Rotation = 0
                        text_icon.ZIndex = 23
                        text_icon.Parent = text_textbox
                        
                        
                        local button_pad = Instance.new("UIPadding")
                        button_pad.PaddingLeft = UDim.new(0, 10)
                        button_pad.Parent = text_textbox
                        
                        
                        text_textbox.MouseEnter:Connect(function() 
                            twn(text_textbox, {BackgroundTransparency = 0})
                        end)
                        
                        text_textbox.MouseLeave:Connect(function() 
                            twn(text_textbox, {BackgroundTransparency = 0.7})
                        end)
                        
                        text_textbox.FocusLost:Connect(function(enter, io) 
                            twn(text_textbox, {BackgroundColor3 = ui.colors.button})  
                            twn(text_icon,    {BackgroundColor3 = ui.colors.text})
                            
                            OnFocusLost:Fire(text_textbox.Text, enter, io)
                        end)
                        
                        text_textbox.Focused:Connect(function() 
                            twn(text_textbox, {BackgroundColor3 = ui.colors.enabled})
                            twn(text_icon,    {BackgroundColor3 = ui.colors.enabledbright})
                            
                            OnFocusGained:Fire(text_textbox.Text)
                        end)


                        
                        table.insert(menu_objects, 5)
                        
                        local t = {} do

                            
                            function t:SetText(txt)
                                if txt == nil then error("SetText failed; can't set text to nil") end
                                text_textbox.Text = tostring(txt)
                            end
                            
                            function t:GetText() 
                                return text_textbox.Text
                            end
                            
                            function t:GetTextFormattedAsInt() 
                                local among = text_textbox.Text:gsub("[^%d]", "")
                                return tonumber(among)
                            end
                            
                            t.OnFocusLost = OnFocusLost
                            t.OnFocusGained = OnFocusGained
                        end
                        
                        return t
                    end
                    
                    function m:NewSlider(text, min, max, start) 
                        text = text or getrand(7)
                        min = min or 0
                        max = max or 100
                        start = start or min
                        
                        
                        if max > 999 then max = 999
                        elseif max < 1 then max = 1
                        end
                        if min >= max then min = max-1
                        elseif min < 0 then min = 0
                        end

                        start = math.clamp(start, min, max)
                        
                        
                        local OnValueChanged = eventlistener.new()
                        local OnFocusLost = eventlistener.new()
                        local OnFocusGained = eventlistener.new()
                        
                        
                        local slider_bg = Instance.new("Frame")
                        slider_bg.BackgroundTransparency = 0.7
                        slider_bg.BackgroundColor3 = ui.colors.button
                        slider_bg.Size = UDim2.new(0, menu_menu.AbsoluteSize.X-30, 0, 24)
                        slider_bg.Position = UDim2.new(0, 15, 0, ((m:GetChildCount())*28)+3)
                        slider_bg.ZIndex = 23
                        slider_bg.Parent = menu_menu
                        round(slider_bg)
                        
                        local slider_text = Instance.new("TextButton")
                        slider_text.Active = false
                        slider_text.Selectable = false
                        slider_text.Text = text
                        slider_text.AutoButtonColor = false
                        slider_text.BackgroundTransparency = 0.4
                        slider_text.BackgroundColor3 = ui.colors.button
                        slider_text.TextColor3 = ui.colors.text
                        slider_text.Font = Enum.Font.Nunito
                        slider_text.TextXAlignment = Enum.TextXAlignment.Center
                        slider_text.TextSize = 19
                        slider_text.Size = UDim2.new(1, 0, 1, 0)
                        slider_text.Position = UDim2.new(0, 0, 0, 0)
                        slider_text.ZIndex = 25
                        slider_text.Visible = true
                        slider_text.Parent = slider_bg
                        
                        round(slider_text)
                        
                        local slider_amount = Instance.new("TextBox")
                        slider_amount.Active = true
                        slider_amount.Text = ""
                        slider_amount.PlaceholderText = "..."
                        slider_amount.BackgroundTransparency = 1
                        slider_amount.BackgroundColor3 = ui.colors.button
                        slider_amount.TextColor3 = ui.colors.text
                        slider_amount.Font = Enum.Font.Nunito
                        slider_amount.TextXAlignment = Enum.TextXAlignment.Center
                        slider_amount.TextSize = 19
                        slider_amount.Size = UDim2.new(0, 35, 1, 0)
                        slider_amount.Position = UDim2.new(0, 5, 0, 0)
                        slider_amount.ZIndex = 25
                        slider_amount.Parent = slider_bg
                        
                        local slider_back = Instance.new("Frame")
                        slider_back.AnchorPoint = Vector2.new(1, 0)
                        slider_back.BorderSizePixel = 0
                        slider_back.BackgroundTransparency = 0
                        slider_back.ClipsDescendants = true
                        slider_back.BackgroundColor3 = ui.colors.scroll
                        slider_back.Size = UDim2.new(0, slider_bg.AbsoluteSize.X - 55, 0, 6)
                        slider_back.Position = UDim2.new(1, -10, 0.5, -3)
                        slider_back.ZIndex = 23
                        slider_back.Parent = slider_bg
                        
                        local slider_slider = Instance.new("Frame")
                        slider_slider.AnchorPoint = Vector2.new(1, 0)
                        slider_slider.BorderSizePixel = 0
                        slider_slider.BackgroundTransparency = 0
                        slider_slider.ClipsDescendants = true
                        slider_slider.BackgroundColor3 = ui.colors.enabled
                        slider_slider.Size = UDim2.new(1, 0, 1, 0)
                        slider_slider.Position = UDim2.new(0, 0, 0, 0)
                        slider_slider.ZIndex = 23
                        slider_slider.Parent = slider_back
                        
                        
                        slider_text.MouseEnter:Connect(function() 
                            twn(slider_text, {BackgroundTransparency = 1, TextTransparency = 1, ZIndex = 0})
                        end)
                        
                        slider_text.MouseLeave:Connect(function() 
                            twn(slider_text, {BackgroundTransparency = 0.4, TextTransparency = 0, ZIndex = 25})
                        end)
                        
                        local slider_id = "Slider"..getrand(10)
                        local ratio = (slider_back.AbsoluteSize.X / (max-min))

                        
                        local value = math.floor((start-min) * ratio)
                        local oldv = value
                        
                        slider_amount.Text = tostring(start)
                        slider_slider.Position = UDim2.new(0, value, 0, 0)
                        
                        slider_back.InputBegan:Connect(function(input1)
                            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                                OnFocusGained:Fire()
                                
                                local x = math.floor(math.clamp(((input1.Position.X - slider_back.AbsolutePosition.X)), 0, slider_slider.AbsoluteSize.X))
                                twn(slider_slider, {Position = UDim2.new(0, x, 0, 0)})
                                
                                value = min+math.floor(x / ratio)
                                slider_amount.Text = tostring(value)
                                
                                
                                
                                if value ~= oldv then
                                    OnValueChanged:Fire(value)
                                end
                                oldv = value
                                
                                ui.cons[slider_id] = uis.InputChanged:Connect(function(input2)
                                    if input2.UserInputType == Enum.UserInputType.MouseMovement then
                                        local delta = (input2.Position - input1.Position)
                                        local x = math.floor(math.clamp(x + delta.X, 0, slider_back.AbsoluteSize.X))
                                        twn(slider_slider, {Position = UDim2.new(0, x, 0, 0)})
                                                
                                        value = min+math.floor(x / ratio)
                                        slider_amount.Text = tostring(value)
                                        
                                        
                                        if value ~= oldv then
                                            OnValueChanged:Fire(value)
                                        end
                                        
                                        oldv = value
                                    end
                                end)
                            end
                        end)
                        
                        slider_back.InputEnded:Connect(function(input1)
                            if input1.UserInputType == Enum.UserInputType.MouseButton1 then
                                ui.cons[slider_id]:Disconnect()
                                OnFocusLost:Fire()
                            end
                        end) 
                        
                        
                        table.insert(menu_objects, 3)
                        
                        
                        local s = {} do
                            
                            function s:SetCallback(cb) 
                                if type(cb) ~= "function" then
                                    error("SetCallback failed; provided value was not a function")
                                end
                                callback = cb
                            end
                            
                            function s:GetValue() 
                                return value
                            end
                            
                            function s:SetValue(v) 
                                if type(v) ~= "number" then
                                    error("SetValue failed; provided value was not a number")
                                end
                                
                                v = math.clamp(v, min, max)
                                value = v
                                slider_amount.Text = tostring(value)
                                twn(slider_slider, {Position = UDim2.new(0, min+math.floor(value * ratio), 0, 0)})
                            end
                            
                            
                            function s:SetMax(m)
                                if type(m) ~= "number" then
                                    error("SetMax failed; provided max was not a number")
                                end
                                
                                max = m
                                if max > 999 then max = 999
                                elseif max < 1 then max = 1
                                end
                                
                                ratio = (slider_back.AbsoluteSize.X / (max-min))
                                
                                value = math.clamp(value, min, max)
                                slider_amount.Text = tostring(value)
                                twn(slider_slider, {Position = UDim2.new(0, min+math.floor(value * ratio), 0, 0)})
                                
                                
                            end
                            
                            function s:GetMax() 
                                return max
                                
                            end
                            
                            function s:SetMin(m) 
                                if type(m) ~= "number" then
                                    error("SetMax failed; provided max was not a number")
                                end
                                
                                min = m
                                if min >= max then min = max-1
                                elseif min < 0 then min = 0
                                end
                                
                                ratio = (slider_back.AbsoluteSize.X / (max-min))
                                
                                value = math.clamp(value, min, max)
                                slider_amount.Text = tostring(value)
                                twn(slider_slider, {Position = UDim2.new(0, math.floor(value * ratio), 0, 0)})
                            end
                            
                            function s:GetMin() 
                                return min
                            end
                            
                            s.OnValueChanged = OnValueChanged
                            s.OnFocusLost    = OnFocusLost
                            s.OnFocusGained  = OnFocusGained
                            
                            
                        end
                        
                        slider_amount.FocusLost:Connect(function() 
                            local tx = slider_amount.Text:gsub("[^%d]", "")
                            local success,ntx = pcall(function() 
                                return tonumber(tx)
                            end)
                            
                            
                            if success then
                            
                                s:SetValue(ntx)
                                slider_amount.Text = s:GetValue()
                            end
                        end)
                        
                        
                        return s
                        
                        
                    end
                    
                    function m:NewGrid() 
                        
                        
                        local g = {} do
                            
                            function g:NewToggle() 
                                
                                
                            end
                        end
                        return g
                        
                    end
                end
                
                return m 
            end
        end
        
        return w
        
    end
    
    function ui:Ready() 
        
        ui.OnReady:Fire()
    end
    
    
    
    function ui:NewMessagebox(msg_text, msg_desc, msg_buttons)
        msg_text = msg_text or getrand(5)
        msg_desc = msg_desc or getrand(10)
        msg_buttons = msg_buttons or {
            {
                Text = "Ok",
                Callback = function(self)
                    self:Close()
                end
            }
            
        }
        
        
        
        local sizex, sizey = 150 + (#msg_buttons*10), 100 + ((utf8.len(msg_desc)))
        
        local msg_window = Instance.new("Frame")
        msg_window.BackgroundColor3 = ui.colors.window
        msg_window.BorderSizePixel = 0
        msg_window.Size = UDim2.new(0, sizex, 0, sizey)
        msg_window.Position = UDim2.new(0, 20, 0, 20)
        msg_window.ZIndex = 100
        
        local msg_clip1 = msg_window:Clone()
        shadow(msg_window)
        msg_clip1.Parent = screen
        msg_clip1.BackgroundTransparency = 1
        msg_clip1.ClipsDescendants = true
        msg_clip1.Position = UDim2.new(1, -520, 1, -520)
        msg_clip1.Size = UDim2.new(0, sizex+100, 0, 0)
        msg_window.Parent = msg_clip1
        
        local msg_topbar = Instance.new("Frame")
        msg_topbar.BackgroundColor3 = ui.colors.topbar
        msg_topbar.BorderSizePixel = 0
        msg_topbar.Size = UDim2.new(1, 0, 0, 30)
        msg_topbar.Position = UDim2.new(0, 0, 0, 0)
        msg_topbar.ZIndex = 101
        msg_topbar.Active = true
        msg_topbar.Parent = msg_window
        
        local msg_title = Instance.new("TextLabel")
        msg_title.Text = msg_text
        msg_title.BackgroundTransparency = 1
        msg_title.TextTransparency = 1
        msg_title.TextColor3 = ui.colors.text
        msg_title.Font = Enum.Font.Nunito
        msg_title.TextSize = 25
        msg_title.Size = UDim2.new(1, -60, 1, 0)
        msg_title.Position = UDim2.new(0, 5, 0, 0)
        msg_title.TextXAlignment = Enum.TextXAlignment.Left
        msg_title.ZIndex = 102
        msg_title.Parent = msg_topbar
        
        local msg_desc2 = Instance.new("TextLabel")
        msg_desc2.Text = msg_desc
        msg_desc2.BackgroundTransparency = 1
        msg_desc2.TextTransparency = 1
        msg_desc2.TextColor3 = ui.colors.text
        msg_desc2.Font = Enum.Font.Nunito
        msg_desc2.TextSize = 20
        msg_desc2.Size = UDim2.new(1, -10, 1, -65)
        msg_desc2.Position = UDim2.new(0, 5, 0, 30)
        msg_desc2.TextXAlignment = Enum.TextXAlignment.Left
        msg_desc2.TextYAlignment = Enum.TextYAlignment.Top
        msg_desc2.ZIndex = 101
        msg_desc2.TextWrapped = true
        msg_desc2.Parent = msg_window
        
        local msg_clip2 = Instance.new("Frame")
        msg_clip2.Visible = true
        msg_clip2.ClipsDescendants = true
        msg_clip2.Position = UDim2.new(0, 0, 0, 0)
        msg_clip2.Size = UDim2.new(1, 0, 0, 0)
        msg_clip2.BackgroundTransparency = 1
        msg_clip2.ZIndex = 102
        msg_clip2.Parent = msg_topbar
        
        local msg_bclose = Instance.new("TextButton")
        msg_bclose.Text = "X"
        msg_bclose.ClipsDescendants = true
        msg_bclose.AutoButtonColor = false
        msg_bclose.BackgroundColor3 = ui.colors.button
        msg_bclose.BackgroundTransparency = 1
        msg_bclose.BorderSizePixel = 0
        msg_bclose.TextColor3 = ui.colors.text
        msg_bclose.Font = Enum.Font.Nunito
        msg_bclose.TextSize = 19
        msg_bclose.Size = UDim2.new(0, 30-4, 0, 30-4)
        msg_bclose.Position = UDim2.new(1, -30+2, 0, 2)
        msg_bclose.ZIndex = 102
        msg_bclose.Parent = msg_clip2
        
        round(msg_bclose)
        
        
        
        local function closeMsg() 
            task.spawn(function() 
                
                
                local a = Instance.new("UIScale")
                a.Scale = 1 
                a.Parent = msg_window
                
                ctwn(msg_window, {Position = msg_window.Position + UDim2.new(0, 0, 0, 50)}, 1.75, "Out", "Exponential")
                ctwn(a, {Scale = 0.25}, 1, "Out", "Linear")
                
                
                twn(msg_window, {BackgroundTransparency = 1})
                for i,v in pairs(msg_window:GetDescendants()) do
                    pcall(function() 
                        twn(v, {BackgroundTransparency = 1})
                        twn(v, {ScrollBarImageTransparency = 1})
                    end)
                    pcall(function() 
                        twn(v, {TextTransparency = 1})
                    end)
                    pcall(function() 
                        twn(v, {ImageTransparency = 1})
                    end)
                end
            end)
            
            wait(2)
            
            msg_window:Destroy()
        end
        
        local msg = {} do
            
            function msg:Close() 
                closeMsg()
            end
            
            function msg:GetTitle() 
                return msg_text
            end
            
            function msg:GetDesc() 
                return msg_desc 
            end
            
            function msg:SetTitle(text)
                msg_text = text
                msg_title.Text = msg_text
            end
            
            function msg:SetDesc(desc)
                msg_desc = desc
                msg_desc2.Text = msg_desc
            end
        
        end
        
        
        
        msg_bclose.MouseEnter:Connect(function() 
            twn(msg_bclose, {BackgroundTransparency = 0})
        end)
        msg_bclose.MouseLeave:Connect(function() 
            twn(msg_bclose, {BackgroundTransparency = 1})
        end)
        
        
        
        
        msg_bclose.MouseButton1Click:Connect(function() 
            ceffect(msg_bclose)
            closeMsg()
        end)
        
        for i,v in pairs(msg_buttons) do
            local cb = v["Callback"] or (function() end)
            
            
            local msg_bv = Instance.new("TextButton")
            msg_bv.Text = v["Text"] or getrand(3)
            msg_bv.ClipsDescendants = true
            msg_bv.AutoButtonColor = false
            msg_bv.BackgroundColor3 = ui.colors.button
            msg_bv.BackgroundTransparency = 1
            msg_bv.BorderSizePixel = 0
            msg_bv.TextColor3 = ui.colors.text
            msg_bv.Font = Enum.Font.Nunito
            msg_bv.TextSize = 19
            msg_bv.Size = UDim2.new(0, (msg_window.AbsoluteSize.X/#msg_buttons-4)-5, 0, 30-4)
            msg_bv.Position = UDim2.new(0, ((msg_window.AbsoluteSize.X/#msg_buttons)*(i-1))+5, 1, -32)
            msg_bv.TextTransparency = 1
            msg_bv.ZIndex = 102
            msg_bv.Parent = msg_window
            
            round(msg_bv)
            
            
            msg_bv.MouseEnter:Connect(function() 
                twn(msg_bv, {BackgroundTransparency = 0})
            end)
            msg_bv.MouseLeave:Connect(function() 
                twn(msg_bv, {BackgroundTransparency = 1})
            end)
            
            
            msg_bv.MouseButton1Click:Connect(function() 
                ceffect(msg_bv)
                
                cb(msg, v["Text"], v)
            end)
            
            task.delay(0.25, function() 
                ctwn(msg_bv, {TextTransparency = 0}, 1)
            end)
        end
        
        
        task.spawn(function()
            msg_window.Size = UDim2.new(0, sizex, 0, 0)
            msg_window.Position = UDim2.new(0, 20, 0, 20)
            
            
            ctwn(msg_clip1, {Size = UDim2.new(0, sizex+100, 0, sizey+100)}, 0.75, "InOut", "Exponential")
            ctwn(msg_window, {Size = UDim2.new(0, sizex, 0, sizey)}, 0.75, "InOut", "Exponential")
            wait(0.25)
            
            ctwn(msg_clip2, {Size = UDim2.new(1, 0, 1, 0)}, 2, "Out", "Exponential")
            ctwn(msg_title, {TextTransparency = 0, Size = UDim2.new(1, -50, 1, 0), Position = UDim2.new(0, 5, 0, 0)}, 0.75, "Out")
            ctwn(msg_desc2, {TextTransparency = 0}, 0.75, "InOut")
            wait(0.75)
            
            msg_bclose.Parent = msg_topbar
            msg_window.Parent = screen
            
            msg_window.Position = UDim2.new(1, -500, 1, -500)
            msg_clip2:Destroy()
            msg_clip1:Destroy()
            rdrag(msg_topbar, msg_window)
        
        end)
        
        
        return msg
        
    end
end

return ui
