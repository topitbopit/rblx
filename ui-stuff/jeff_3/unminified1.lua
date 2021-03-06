-- Jeff 3.0
-- Requires getcustomasset / getsynasset




local serv_rs  = game:GetService("RunService")
local serv_ts  = game:GetService("TweenService")
local serv_uis = game:GetService("UserInputService")
local serv_gui = game:GetService("GuiService")

local dim2, dim2off, dim2sca = UDim2.new, UDim2.fromOffset, UDim2.fromScale
local vec3,vec2 = Vector3.new, Vector2.new

local c3,c3r,c3h = Color3.new, Color3.fromRGB, Color3.fromHSV
local ins,rem,clr = table.insert, table.remove, table.clear


local rand, floor,ceil, clamp = math.random, math.floor, math.ceil, math.clamp
local char,byte = string.char, string.byte

local wait,delay,spawn = task.wait, task.delay, task.spawn

local inst = Instance.new


local getname
local shadow
local twn
local ctwn
local buttoneff
local round

do
    function round(num, place) 
        return floor(((num+(place*.5)) / place)) * place
    end
    function getname()
        local a = ''
        for i = 1, 10 do 
            a = a .. char(rand(60,150))
        end
        return a
    end
    function shadow(parent)
        local a = inst("ImageLabel")
        
        a.BackgroundTransparency  = 1
        a.ImageTransparency       = 0.5
        a.SliceScale              = 1.3
        
        a.Image                   = "rbxassetid://7603818383"
        
        a.AnchorPoint             = vec2(0.5,0.5)
        a.ImageColor3             = c3(0,0,0)
        a.Position                = dim2sca(0.5, 0.5)
        a.Size                    = dim2(1, 20, 1, 20)
        a.SliceCenter             = Rect.new(15, 15, 175, 175)
        
        a.ScaleType               = 'Slice'
        a.ZIndex                  = parent.ZIndex - 1 
        a.Parent                  = parent
    
        return a
    end
    
    local info1 = TweenInfo.new(0.1,10,1)
    local info2 = TweenInfo.new(0.15,10,1)
    
    function twn(twn_target, twn_settings, twn_long) 

        local tween = serv_ts:Create(
            twn_target,
            twn_long and info2 or info1,
            twn_settings
        )
        tween:Play()
        return tween
    end
    
    function ctwn(twn_target, twn_settings, twn_dur) 

        local tween = serv_ts:Create(
            twn_target,
            TweenInfo.new(twn_dur,10,1),
            twn_settings
        )
        tween:Play()
        return tween
    end
end

local fake_asset = getsynasset or getcustomasset or get_custom_asset or fake_asset or fakeasset
if (fake_asset) then
    local req = http_request or request or (syn and syn.request) or (fluxus and fluxus.request) or httprequest
    
    if (not isfolder("jeff3")) then
        makefolder("jeff3")
    end
    local files = {
        'close.png',
        'min.png',
        'unmin.png',
        'lines.png',
        'input.png',
        'color1.png',
        'color2.png',
        'color3.png',
        'arrow.png',
        'resize.png'
    }
    
    for i = 1, #files do 
        local file = files[i]
        if (not isfile("jeff3/"..file)) then
            print(("Downloading ")..file.. (" (%s/%s)"):format(i, #files))
            writefile("jeff3/"..file,
                req{
                    Url = 'https://raw.githubusercontent.com/topitbopit/rblx/main/ui-stuff/jeff_3/assets/'..file;
                    Method = 'GET';
                }.Body
            )
        end
    end
    print("Finished downloading all files")
else
    warn("Your exploit is missing a customasset function!")
    warn("Consider upgrading to a non-shitter exploit such as jjsploit")
    return
end

local function getcore() 
    return game:GetService("CoreGui")
end

local screen = inst("ScreenGui")

if (type(syn) == "table" and type(syn.protect_gui) == "function") then
    syn.protect_gui(screen)
end
screen.ZIndexBehavior = "Global"
screen.Parent = (gethui or gethiddengui or get_hidden_gui or get_hidden_ui or gethiddenui or getcore)();
getcore = nil

local ui = {} do
    ui.Font = "SourceSans"
    
    local Ui_Flags = {}
    Ui_Flags['Exiting'] = false
    Ui_Flags['Exited'] = false
    
    local inset = serv_gui:GetGuiInset()
    local res = serv_gui:GetScreenResolution()
    
    screen:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() 
        res = serv_gui:GetScreenResolution()
    end)
    
    local tda = {} -- temp drag something
    local tsa = {} -- temp slider 
    local ltc = {} -- long term connections
    local hotkeys = {}
    
    local objects = {} do
        objects[1] = {} -- windows
        objects[2] = {} -- menus
        objects[3] = {} -- toggles 
        
    end
    local colors = {} do
        colors['w1'] = c3r(35,35,35); -- Menu outline
        colors['w2'] = c3r(20,20,20); -- Topbar background
        colors['w3'] = c3r(10,10,10); -- Normal background
        
        colors['s1'] = c3r(33,33,33); -- the j
        colors['s2'] = c3r(00,00,00); -- Section background

        colors['b1'] = c3r(14,14,14);
        colors['b2'] = c3r(24,23,34);
        colors['b3'] = c3r(39,39,97);
        colors['b4'] = c3r(49,48,117);
        
        colors['sl1'] = c3r(12,12,12);
        colors['sl2'] = c3r(39,39,97);
        colors['sl3'] = c3r(22,21,32);
        
        colors['t1'] = c3(1,1,1);
        colors['t2'] = c3(0.0,0.0,0.0);
        colors['t3'] = c3(0.8,0.8,0.8);
        
        colors['dd1'] = c3r(11,11,11);
        colors['dd2'] = c3r(21,20,31);
        colors['dd3'] = c3r(36,36,94);
        colors['dd4'] = c3r(46,45,114);
    end
    local icons = {} do 
        icons[1] = fake_asset("jeff3/lines.png");
        icons[2] = fake_asset("jeff3/close.png");
        icons[3] = fake_asset("jeff3/min.png");
        icons[4] = fake_asset("jeff3/unmin.png");
        icons[5] = fake_asset("jeff3/input.png");
        icons[6] = fake_asset("jeff3/arrow.png");
        --icons[7] = fake_asset("jeff3/resize.png");
    end
    
    local msg = '%s failed; %s must be of type %s'
    local tooltip = {} do 
        local tt1 = inst("TextLabel")
        tt1.Size = dim2off(125, 30)
        tt1.BorderColor3 = colors['w1']
        tt1.BorderSizePixel = 1
        tt1.BackgroundColor3 = colors['w3']
        tt1.BackgroundTransparency = 0
        tt1.TextXAlignment = "Left"
        tt1.TextYAlignment = "Top"
        tt1.Font = ui.Font
        tt1.TextStrokeTransparency = 0
        tt1.TextColor3 = colors['t1']
        tt1.TextSize = 17
        tt1.TextWrapped = true
        tt1.RichText = true
        tt1.Visible = false
        tt1.Text = ''
        tt1.ZIndex = 100
        tt1.Parent = screen
        
        local tt2 = inst("UIPadding")
        tt2.PaddingLeft = dim2off(3,0).X
        tt2.Parent = tt1
        
        tooltip.text = ''
        tooltip.root = tt1
        tooltip.visible = false
        tooltip.changetext = function(text) 
            tt1.Size = dim2off(175, 0)
            tt1.Text = text
            for i = 1, 15 do 
                if (tt1.TextFits) then break end
                tt1.Size += dim2off(0, 10)
            end
            
            tooltip.text = text
        end
    end
    
    
    
    local MOUSELOC = vec2(0,0)
    
    ltc[1] = serv_uis.InputBegan:Connect(function(io,gpe)
        
        if (io.UserInputType.Value == 8 and not gpe) then
            local len = #hotkeys
            if (len == 0) then return end
            
            local kcv = io.KeyCode.Value
            
            for i = 1, len do 
                local hk = hotkeys[i]
                if (hk[1] == kcv) then
                    kh[2]()
                end
            end
        end
    end)
    ltc[2] = serv_uis.InputChanged:Connect(function(io,gpe) 
        if (io.UserInputType.Value == 4) then
            local pos = io.Position
            MOUSELOC = vec2(pos.X, pos.Y)
            
            if (not tooltip.visible) then
                return
            end
            
            
            tooltip.root.Position = dim2off(pos.X+16, pos.Y+16)
            return
        end
    end)
    
    
    function ui:ConnectFlag(Ui_FlagName, Ui_Func) 
        assert(type(Ui_FlagName) == 'string', msg:format('ConnectFlag', 'Ui_FlagName', 'string'))
        assert(type(Ui_Func) == 'function', msg:format('ConnectFlag', 'Ui_Func', 'function'))
        
        if (Ui_Flags[Ui_FlagName] == false) then
            Ui_Flags[Ui_FlagName] = Ui_Func
        end
        
        return ui
    end
    function ui:NewWindow(W_WindowTitle, W_WindowWidth, W_WindowHeight, W_MenuWidth) 
        -- Var cleaning
        assert(type(W_WindowWidth)   == 'number' , msg:format('NewWindow','W_WindowWidth', 'number'))
        assert(type(W_WindowHeight)  == 'number' , msg:format('NewWindow','W_WindowHeight','number'))
        assert(type(W_WindowTitle)   == 'string' , msg:format('NewWindow','W_WindowTitle', 'string'))
        if (W_MenuWidth) then
            assert(type(W_MenuWidth) == 'number' , msg:format('NewWindow','W_MenuWidth',   'number'))
        end
        
        -- Declare window locals
        local W_WINSIZEHALF = vec2(W_WindowWidth,W_WindowHeight)*.5
        local W_WINPOS
        local W_WIDTHBUFFER = W_WindowWidth+80
        local W_HEIGHTBUFFER = W_WindowHeight+60
        
        local W_WindowId = #objects[1]+1
        local W_Minimized = false
        local W_MenuCount = 0
        W_MenuWidth = W_MenuWidth or 100
        local W_Children = {}
        
        -- Declare instances
        local w_RootFrame
         local w_ResizeHandle
         local w_Background
          local w_BackgroundLines
          local w_TabContainer
           local w_TabContainerOutline
           local w_TabMenu
            local w_TabMenuLayout
            local w_TabMenuPadding
          local w_MenuContainer
           local w_MenuContainerOutline
          
         local w_Topbar
          local w_TopbarLabel
          local w_TopbarClose
          local w_TopbarMin
         local w_FadeFrame
         
        do
            
            w_RootFrame = inst("Frame")
            w_RootFrame.BackgroundColor3 = colors['w3']
            w_RootFrame.BorderColor3 = colors['w1']
            w_RootFrame.BorderMode = 'Outline'
            w_RootFrame.Parent = screen
            
             w_ResizeHandle = inst("ImageLabel")
             w_ResizeHandle.Position = dim2sca(1,1)
             w_ResizeHandle.Size = dim2off(10,10)
             w_ResizeHandle.AnchorPoint = vec2(1,1)
             --w_ResizeHandle.Image = icons[7]
             w_ResizeHandle.BackgroundTransparency = 1
             w_ResizeHandle.ZIndex = 25
             w_ResizeHandle.Visible = false
             w_ResizeHandle.Parent = w_RootFrame
            
             w_Background = inst("Frame")
             w_Background.BackgroundTransparency = 1
             w_Background.BorderSizePixel = 0
             w_Background.ClipsDescendants = true
             w_Background.Size = dim2(1, 0, 1, -26)
             w_Background.Position = dim2off(0, 26)
             w_Background.ZIndex = 1
             w_Background.Parent = w_RootFrame
             
              w_BackgroundLines = inst("ImageLabel")
              w_BackgroundLines.Position = dim2(0, 0, 1, 20)
              w_BackgroundLines.AnchorPoint = vec2(0, 1)
              w_BackgroundLines.Image = icons[1]
              w_BackgroundLines.ImageColor3 = c3(1,1,1)
              w_BackgroundLines.BorderSizePixel = 0
              w_BackgroundLines.BackgroundTransparency = 1
              w_BackgroundLines.ImageTransparency = 0
              w_BackgroundLines.Size = dim2(1,0,0,300)
              w_BackgroundLines.ZIndex = 2
              w_BackgroundLines.Parent = w_Background
              
              w_TabContainer = inst("Frame")
              w_TabContainer.BackgroundColor3 = colors['s2']
              w_TabContainer.BorderSizePixel = 0
              w_TabContainer.BackgroundTransparency = 0.7
              w_TabContainer.Position = dim2off(2,2)
              w_TabContainer.Size = dim2(0, W_MenuWidth, 1, -4) --dim2(0, W_MenuWidth, 0, W_WindowHeight-30)--dim2off(W_MenuWidth, W_WindowHeight-30) 
              w_TabContainer.ZIndex = 5
              w_TabContainer.Parent = w_Background
              
               w_TabContainerOutline = inst("UIStroke")
               w_TabContainerOutline.LineJoinMode = "Miter"
               w_TabContainerOutline.Color = colors['w1']
               w_TabContainerOutline.Thickness = 1
               w_TabContainerOutline.Parent = w_TabContainer
               
               w_TabMenu = inst("ScrollingFrame")
               w_TabMenu.Size = dim2sca(1, 1)
               w_TabMenu.BackgroundTransparency = 1
               w_TabMenu.ScrollBarImageTransparency = 1
               w_TabMenu.ScrollBarThickness = 0
               w_TabMenu.TopImage = ""
               w_TabMenu.BottomImage = ""
               w_TabMenu.BorderSizePixel = 0
               w_TabMenu.CanvasSize = dim2off(0,2)
               w_TabMenu.ZIndex = 6
               w_TabMenu.Parent = w_TabContainer
               
                w_TabMenuLayout = inst("UIListLayout")
                w_TabMenuLayout.FillDirection = "Vertical"
                w_TabMenuLayout.VerticalAlignment = "Top"
                w_TabMenuLayout.HorizontalAlignment = "Center"
                w_TabMenuLayout.Padding = dim2off(0, 1).Y
                w_TabMenuLayout.SortOrder = "LayoutOrder"
                w_TabMenuLayout.Parent = w_TabMenu
                
                w_TabMenuPadding = inst("UIPadding")
                w_TabMenuPadding.PaddingTop = dim2off(0, 1).Y
                w_TabMenuPadding.Parent = w_TabMenu
                
                
              w_MenuContainer = inst("Frame")
              w_MenuContainer.BackgroundColor3 = colors['s2']
              w_MenuContainer.BorderSizePixel = 0
              w_MenuContainer.BackgroundTransparency = 1
              w_MenuContainer.Position = dim2off(W_MenuWidth+5,2)
              w_MenuContainer.Size = dim2(1, -(W_MenuWidth+7), 1, -4)  --dim2off(W_WindowWidth - (W_MenuWidth+7), W_WindowHeight - 30)
              w_MenuContainer.ZIndex = 5
              w_MenuContainer.Parent = w_Background
              
               w_MenuContainerOutline = inst("UIStroke")
               w_MenuContainerOutline.LineJoinMode = "Miter"
               w_MenuContainerOutline.Color = colors['w1']
               w_MenuContainerOutline.Thickness = 1
               w_MenuContainer.ZIndex = 6
               w_MenuContainerOutline.Parent = w_MenuContainer
            
             w_Topbar = inst("Frame")
             w_Topbar.Active = true
             w_Topbar.Size = dim2(1, 0, 0, 25)
             w_Topbar.BackgroundColor3 = colors['w2']
             w_Topbar.BorderColor3 = colors['w1']
             w_Topbar.BorderMode = 'Outline'
             w_Topbar.ZIndex = 50
             w_Topbar.Parent = w_RootFrame
             
              w_TopbarLabel = inst("TextLabel")
              w_TopbarLabel.BackgroundTransparency = 1
              w_TopbarLabel.Position = dim2off(3, -1)
              w_TopbarLabel.Size = dim2sca(1,1)
              w_TopbarLabel.TextXAlignment = 'Left'
              w_TopbarLabel.TextYAlignment = 'Top'
              w_TopbarLabel.Font = ui.Font
              w_TopbarLabel.TextStrokeTransparency = 0
              w_TopbarLabel.TextColor3 = colors['t1']
              w_TopbarLabel.TextSize = 23
              w_TopbarLabel.RichText = true
              w_TopbarLabel.ZIndex = 50
              w_TopbarLabel.Parent = w_Topbar
              
              w_TopbarClose = inst("ImageButton")
              w_TopbarClose.Active = true
              w_TopbarClose.AutoButtonColor = false
              w_TopbarClose.Position = dim2(1, -1, 0, 1)
              w_TopbarClose.AnchorPoint = vec2(1, 0)
              w_TopbarClose.Image = icons[2]
              w_TopbarClose.ImageColor3 = colors['t1']
              w_TopbarClose.BackgroundColor3 = colors['b1']
              w_TopbarClose.BorderColor3 = colors['w1']
              w_TopbarClose.BorderMode = "Inset"
              w_TopbarClose.Size = dim2off(23, 23)
              w_TopbarClose.ZIndex = 50
              w_TopbarClose.Parent = w_Topbar
              
              w_TopbarMin = inst("ImageButton")
              w_TopbarMin.Active = true
              w_TopbarMin.AutoButtonColor = false
              w_TopbarMin.Position = dim2(1, -25, 0, 1)
              w_TopbarMin.AnchorPoint = vec2(1, 0)
              w_TopbarMin.Image = icons[3]
              w_TopbarMin.ImageColor3 = colors['t1']
              w_TopbarMin.BackgroundColor3 = colors['b1']
              w_TopbarMin.BorderColor3 = colors['w1']
              w_TopbarMin.BorderMode = "Inset"
              w_TopbarMin.Size = dim2off(23, 23)
              w_TopbarMin.ZIndex = 50
              w_TopbarMin.Parent = w_Topbar
             
             w_FadeFrame = inst("Frame")
             w_FadeFrame.Active = false
             w_FadeFrame.Size = dim2sca(1,1)
             w_FadeFrame.BorderColor3 = c3(0,0,0)
             w_FadeFrame.BackgroundColor3 = c3(0,0,0)
             w_FadeFrame.BorderMode = 'Outline'
             w_FadeFrame.ZIndex = 135135
             w_FadeFrame.BackgroundTransparency = 1
             w_FadeFrame.Parent = w_RootFrame
        end
        
        -- Important stuff
        -- Just for cleanliness and because it uses inputted vals
        do
            w_TopbarLabel.Text = W_WindowTitle
            
            w_RootFrame.Size = dim2off(W_WindowWidth,W_WindowHeight)
            w_RootFrame.Position = dim2off((res.X - 50) - W_WindowWidth, (res.Y - 50) - W_WindowHeight)
            
            W_WINPOS = w_RootFrame.AbsolutePosition
        end
        
        -- Effects
        local w_Shadow = shadow(w_RootFrame)
        do 
            local particles = {}
            local particles_x = {}
            local particles_y = {}
            local particles_depth = {}
            
            local pc = floor((W_WindowWidth * W_WindowHeight) / 1300)
            
            for i = 1, pc do 
                local depth = rand(1,rand(25,50))*.1
                local x,y = rand(-25, W_WindowWidth+25), rand(5, W_WindowHeight+25)
                local p = inst("Frame")
                p.BackgroundTransparency = (1 / depth) + 0.25
                p.BackgroundColor3 = c3h(.65,0.9 - (rand(0,30)*.01),1)
                p.BorderSizePixel = 0
                p.Position = dim2off(x,y)
                p.Size = dim2off(depth,depth)
                
                p.ZIndex = 2
                p.Parent = w_Background
                
                particle_times = rand(1, 20)*.1
                
                particles[i] = p
                particles_depth[i] = depth
                particles_x[i] = x
                particles_y[i] = y
            end
            
            local m 
            local mx, my
            
            
            
            ltc[W_WindowId+2] = serv_rs.RenderStepped:Connect(function(dt) 
                if (W_Minimized) then return end
                
                m = (W_WINPOS+W_WINSIZEHALF) - (MOUSELOC + inset)
                mx, my = m.X*.03, m.Y*.03
                
                
                for i = 1, pc do 
                    local y = particles_y[i]
                    local x = particles_x[i]
                    local depth = particles_depth[i]
                    
                    x += dt * depth * 13
                    x = x > W_WIDTHBUFFER and -80 or x
                    
                    y -= dt * depth * 5
                    y = y < -60 and W_HEIGHTBUFFER or y
                    
                    particles[i].Position = dim2off(
                        x - (mx*depth), 
                        y - (my*depth)
                    )
                    
                    particles_y[i] = y
                    particles_x[i] = x
                end
            end)

        end
        
        local W_Object = {} do 
            function W_Object:Close() 
                local scale = Instance.new("UIScale", w_RootFrame)
                
                local w_ShadowFrame = inst("Frame")
                w_ShadowFrame.Size = w_RootFrame.Size
                w_ShadowFrame.Position = w_RootFrame.Position
                w_ShadowFrame.BackgroundTransparency = 1
                
                w_RootFrame.Position = dim2off(0,0)
                w_RootFrame.Size = dim2sca(1,1)
                w_Shadow.Parent = w_ShadowFrame
                w_RootFrame.Parent = w_ShadowFrame
                w_ShadowFrame.Parent = screen
                w_RootFrame.ClipsDescendants = true
                
                
                twn(w_Shadow, {ImageTransparency = 1}, true)
                
                if (rand(0,1) == 1) then
                    twn(w_ShadowFrame, {Size = dim2off(0,W_WindowHeight)}, true).Completed:Wait()
                else
                    twn(w_ShadowFrame, {Size = dim2off(W_WindowWidth,0)}, true).Completed:Wait()
                end
                
                
                w_ShadowFrame:Destroy()
            end
            function W_Object:AddMenu(M_MenuTitle) 
                -- clean vars
                assert(type(M_MenuTitle) == 'string', msg:format('AddMenu','M_MenuTitle','string'))
                M_MenuTitle = M_MenuTitle
                
                W_MenuCount += 1
                w_TabMenu.CanvasSize += dim2off(0, 23)
                
                -- locals
                local M_Sections = {}
                local M_IsLeft = true
                local M_Halfway = w_MenuContainer.AbsoluteSize*0.5
                local M_IsSelected = false
                
                -- instance locals 
                local m_TabButton
                 local m_TabButtonPadding
                local m_MenuFrame
                 local m_MenuLeft
                  local m_MenuLeftLayout
                  local m_MenuLeftPadding
                 local m_MenuRight
                  local m_MenuRightLayout
                  local m_MenuRightPadding
                
                -- instances 
                do 
                    m_TabButton = inst("TextButton")
                    m_TabButton.Active = true
                    m_TabButton.AutoButtonColor = false
                    m_TabButton.BackgroundTransparency = 0
                    m_TabButton.BorderColor3 = colors['w1']
                    m_TabButton.BorderMode = "Inset"
                    m_TabButton.TextXAlignment = 'Center'
                    m_TabButton.TextYAlignment = 'Top'
                    m_TabButton.Font = ui.Font
                    m_TabButton.TextStrokeTransparency = 0
                    m_TabButton.TextColor3 = c3(1,1,1)
                    m_TabButton.TextSize = 20
                    m_TabButton.RichText = true
                    m_TabButton.Size = dim2off(W_MenuWidth-2, 22)
                    m_TabButton.ZIndex = 6
                    m_TabButton.LayoutOrder = W_MenuCount
                    m_TabButton.Parent = w_TabMenu
                    
                     m_TabButtonPadding = inst("UIPadding")
                     m_TabButtonPadding.PaddingBottom = dim2off(0, 21).Y
                     m_TabButtonPadding.Parent = m_TabButton
                     
                    m_MenuFrame = inst("ScrollingFrame")
                    m_MenuFrame.Size = dim2sca(1, 1)
                    m_MenuFrame.BackgroundTransparency = 1
                    m_MenuFrame.ScrollBarImageTransparency = 1
                    m_MenuFrame.ScrollBarThickness = 0
                    m_MenuFrame.TopImage = ""
                    m_MenuFrame.BottomImage = ""
                    m_MenuFrame.BorderSizePixel = 0
                    m_MenuFrame.CanvasSize = dim2off(0,2)
                    m_MenuFrame.AutomaticCanvasSize = "Y"
                    m_MenuFrame.ZIndex = 6
                    m_MenuFrame.Parent = w_MenuContainer
                    
                     m_MenuLeft = inst("Frame")
                     m_MenuLeft.Size = dim2(0.5, -1, 1, 1)
                     m_MenuLeft.BackgroundTransparency = 1
                     m_MenuLeft.BorderSizePixel = 0
                     m_MenuLeft.AutomaticSize = "Y"
                     m_MenuLeft.ZIndex = 6
                     m_MenuLeft.Parent = m_MenuFrame
                     
                      m_MenuLeftLayout = inst("UIListLayout")
                      m_MenuLeftLayout.FillDirection = "Vertical"
                      m_MenuLeftLayout.VerticalAlignment = "Top"
                      m_MenuLeftLayout.HorizontalAlignment = "Center"
                      m_MenuLeftLayout.Padding = dim2off(0, 3).Y
                      m_MenuLeftLayout.SortOrder = "LayoutOrder"
                      m_MenuLeftLayout.Parent = m_MenuLeft
                      
                      m_MenuLeftPadding = inst("UIPadding")
                      m_MenuLeftPadding.PaddingTop = dim2off(0, 2).Y
                      m_MenuLeftPadding.PaddingLeft = dim2off(0, 1).Y
                      m_MenuLeftPadding.Parent = m_MenuLeft
                            
                     m_MenuRight = inst("Frame")
                     m_MenuRight.Size = dim2(0.5, -1, 1, 1)
                     m_MenuRight.Position = dim2(0.5, 0, 0, 0)
                     m_MenuRight.BackgroundTransparency = 1
                     m_MenuRight.BorderSizePixel = 0
                     m_MenuRight.ZIndex = 6
                     m_MenuRight.AutomaticSize = "Y"
                     m_MenuRight.Parent = m_MenuFrame
                     
                      m_MenuRightLayout = inst("UIListLayout")
                      m_MenuRightLayout.FillDirection = "Vertical"
                      m_MenuRightLayout.VerticalAlignment = "Top"
                      m_MenuRightLayout.HorizontalAlignment = "Center"
                      m_MenuRightLayout.Padding = dim2off(0, 3).Y
                      m_MenuRightLayout.SortOrder = "LayoutOrder"
                      m_MenuRightLayout.Parent = m_MenuRight
                      
                      m_MenuRightPadding = inst("UIPadding")
                      m_MenuRightPadding.PaddingTop = dim2off(0, 2).Y
                      m_MenuRightPadding.PaddingLeft = dim2off(0, 1).Y
                      m_MenuRightPadding.Parent = m_MenuRight
                    
                end
                -- final props
                M_IsSelected = W_MenuCount == 1
                
                
                m_TabButton.Text = M_MenuTitle
                m_MenuFrame.Visible = M_IsSelected
                m_TabButton.BackgroundColor3 = M_IsSelected and colors['b3'] or colors['b1']
                
                local M_Object = {} do 
                    M_Object.Title = M_MenuTitle
                    
                    function M_Object:IsSelected() 
                        return M_IsSelected
                    end
                    
                    function M_Object:Select() 
                        local menus = objects[2]
                        for i = 1, #menus do
                            local m = menus[i]
                            if (m and m ~= M_Object) then
                                m:Deselect()
                            end
                        end
                        
                        M_IsSelected = true
                        
                        m_MenuFrame.Visible = true
                        
                        twn(m_TabButton, {
                            BackgroundColor3 = colors['b4']
                        })
                    end
                    
                    function M_Object:Deselect() 
                        M_IsSelected = false
                        m_MenuFrame.Visible = false
                        
                        twn(m_TabButton, {
                            BackgroundColor3 = colors['b1']
                        })
                    end
                    
                    function M_Object:GetParent() 
                        return W_Object
                    end
                    
                    function M_Object:AddSection(S_Title1, S_Title2)
                        -- Clean variables
                        assert(type(S_Title1) == "string", msg:format('AddSection','S_Title1','string'))
                        if (S_Title2) then
                            assert(type(S_Title2) == "string", msg:format('AddSection','S_Title2','string'))
                        end
                        
                        
                        -- Locals
                        local S_Side = M_IsLeft and 1 or 2
                        local S_IsMinimized = false
                        local S_CurrentPage = true
                        
                        local S_HalfwayX = M_Halfway.X - 3
                        
                        M_IsLeft = not M_IsLeft
                        
                        -- instance locals
                        local s_Background
                         local s_BackgroundOffset
                         local s_TopbarTrim
                         local s_BackgroundOutline
                         local s_TopbarMinimize
                         local s_Page1Topbar
                          local s_Page1TopbarText
                          
                         local s_Page1Menu
                          local s_Page1MenuPadding
                          local s_Page1MenuLayout
                          
                         local s_Page2Topbar
                          local s_Page2TopbarText
                          
                         local s_Page2Menu
                          local s_Page2MenuPadding
                          local s_Page2MenuLayout
                         
                        -- instances
                        do
                            
                            s_Background = inst("Frame")
                            s_Background.BackgroundColor3 = colors['s2']
                            s_Background.BorderSizePixel = 0
                            s_Background.BackgroundTransparency = 0.7
                            s_Background.Size = dim2off(S_HalfwayX, 0)--dim2(1, -2, 0, 0)
                            s_Background.AutomaticSize = "Y"
                            s_Background.ZIndex = 8
                             
                             s_BackgroundOutline = inst("UIStroke")
                             s_BackgroundOutline.LineJoinMode = "Miter"
                             s_BackgroundOutline.Color = colors['w1']
                             s_BackgroundOutline.Thickness = 1
                             s_BackgroundOutline.Parent = s_Background
                             
                             s_TopbarTrim = inst("Frame")
                             s_TopbarTrim.Size = dim2(1, 0, 0, 1)
                             s_TopbarTrim.Position = dim2off(0, 16)
                             s_TopbarTrim.BackgroundColor3 = colors['w1']
                             s_TopbarTrim.BorderSizePixel = 0
                             s_TopbarTrim.ZIndex = 9
                             s_TopbarTrim.Parent = s_Background
                             
                             s_Page1Topbar = inst("TextButton")
                             s_Page1Topbar.Text = ''
                             s_Page1Topbar.Active = true
                             s_Page1Topbar.AutoButtonColor = false
                             s_Page1Topbar.Size = dim2(0.5, 0, 0, 16)
                             s_Page1Topbar.Position = dim2off(0,0)
                             s_Page1Topbar.BackgroundColor3 = colors['b1']
                             s_Page1Topbar.BorderSizePixel = 0
                             s_Page1Topbar.ZIndex = 9
                             s_Page1Topbar.Parent = s_Background
                             
                              s_Page1TopbarText = inst("TextLabel")
                              s_Page1TopbarText.BackgroundTransparency = 1
                              s_Page1TopbarText.Position = dim2off(0, -1)
                              s_Page1TopbarText.Size = dim2sca(1,1)
                              s_Page1TopbarText.TextXAlignment = "Center"
                              s_Page1TopbarText.TextYAlignment = "Top"
                              s_Page1TopbarText.Font = ui.Font
                              s_Page1TopbarText.TextStrokeTransparency = 0
                              s_Page1TopbarText.TextColor3 = colors['t1']
                              s_Page1TopbarText.TextSize = 16
                              s_Page1TopbarText.RichText = true
                              s_Page1TopbarText.ZIndex = 9
                              s_Page1TopbarText.Parent = s_Page1Topbar
                             
                             s_Page1Menu = inst("Frame")
                             s_Page1Menu.Size = dim2sca(1,0)
                             s_Page1Menu.Position = dim2off(0, 16)
                             s_Page1Menu.BackgroundTransparency = 1
                             s_Page1Menu.BorderSizePixel = 0
                             s_Page1Menu.Visible = false
                             s_Page1Menu.AutomaticSize = "Y"
                             s_Page1Menu.ZIndex = 8
                             s_Page1Menu.Parent = s_Background
                             
                              s_Page1MenuLayout = inst("UIListLayout")
                              s_Page1MenuLayout.FillDirection = "Vertical"
                              s_Page1MenuLayout.VerticalAlignment = "Top"
                              s_Page1MenuLayout.HorizontalAlignment = "Center"
                              s_Page1MenuLayout.Padding = dim2off(0, 3).Y
                              s_Page1MenuLayout.SortOrder = "LayoutOrder"
                              
                              s_Page1MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
                                   s_Page1Menu.Size = dim2(1, 0, 0, s_Page1MenuLayout.AbsoluteContentSize.Y+5)
                              end)
                              
                              s_Page1MenuLayout.Parent = s_Page1Menu
                              
                              s_Page1MenuPadding = inst("UIPadding")
                              s_Page1MenuPadding.PaddingTop = dim2off(0, 3).Y
                              s_Page1MenuPadding.Parent = s_Page1Menu
                              
                             s_Page2Topbar = inst("TextButton")
                             s_Page2Topbar.Text = ''
                             s_Page2Topbar.Active = true
                             s_Page2Topbar.AutoButtonColor = false
                             s_Page2Topbar.Size = dim2(0.5, 0, 0, 16)
                             s_Page2Topbar.Position = dim2(0.5, 0, 0, 0)
                             s_Page2Topbar.BackgroundColor3 = colors['b1']
                             s_Page2Topbar.BorderSizePixel = 0
                             s_Page2Topbar.ZIndex = 8
                             s_Page2Topbar.Parent = s_Background
                             
                              s_Page2TopbarText = inst("TextLabel")
                              s_Page2TopbarText.BackgroundTransparency = 1
                              s_Page2TopbarText.Position = dim2off(0, -1)
                              s_Page2TopbarText.Size = dim2sca(1,1)
                              s_Page2TopbarText.TextXAlignment = "Center"
                              s_Page2TopbarText.TextYAlignment = "Top"
                              s_Page2TopbarText.Font = ui.Font
                              s_Page2TopbarText.TextStrokeTransparency = 0
                              s_Page2TopbarText.TextColor3 = c3(1,1,1)
                              s_Page2TopbarText.TextSize = 16
                              s_Page2TopbarText.RichText = true
                              s_Page2TopbarText.ZIndex = 8
                              s_Page2TopbarText.Parent = s_Page2Topbar
                              
                             s_Page2Menu = inst("Frame")
                             s_Page2Menu.Size = dim2sca(1,0)
                             s_Page2Menu.Position = dim2off(0, 16)
                             s_Page2Menu.BackgroundTransparency = 1
                             s_Page2Menu.BorderSizePixel = 0
                             s_Page2Menu.Visible = false
                             s_Page2Menu.AutomaticSize = "Y"
                             s_Page2Menu.ZIndex = 8
                             s_Page2Menu.Parent = s_Background
                             
                              s_Page2MenuLayout = inst("UIListLayout")
                              s_Page2MenuLayout.FillDirection = "Vertical"
                              s_Page2MenuLayout.VerticalAlignment = "Top"
                              s_Page2MenuLayout.HorizontalAlignment = "Center"
                              s_Page2MenuLayout.Padding = dim2off(0, 3).Y
                              s_Page2MenuLayout.SortOrder = "LayoutOrder"
                              
                              s_Page2MenuLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() 
                                   s_Page2Menu.Size = dim2(1, 0, 0, s_Page2MenuLayout.AbsoluteContentSize.Y+5)
                              end)
                              
                              s_Page2MenuLayout.Parent = s_Page2Menu
                              
                              s_Page2MenuPadding = inst("UIPadding")
                              s_Page2MenuPadding.PaddingTop = dim2off(0, 3).Y
                              s_Page2MenuPadding.Parent = s_Page2Menu
                              
                        end
                        -- final props
                        do 
                            s_Background.Parent = S_Side == 1 and m_MenuLeft or m_MenuRight
                            s_Page1TopbarText.Text = S_Title1
                            
                            if (S_Title2) then
                                s_Page1TopbarText.Text = S_Title1
                                s_Page2TopbarText.Text = S_Title2
                                
                                if (S_CurrentPage) then
                                    s_Page1Topbar.BackgroundColor3 = colors['b3']
                                    
                                    delay(0.01, function()
                                        s_Page1Menu.Visible = true
                                        s_Page1Menu.AutomaticSize = "Y"
                                        s_Page1Menu.Size = dim2(1,0,0,s_Page1MenuLayout.AbsoluteContentSize.Y+5)
                                        
                                        s_Page2Menu.Visible = false
                                        s_Page2Menu.AutomaticSize = "None"
                                        s_Page2Menu.Size = dim2sca(1,0)
                                    end)
                                    
                                else
                                    delay(0.01, function()
                                        s_Page2Menu.Visible = true
                                        s_Page2Menu.AutomaticSize = "Y"
                                        s_Page2Menu.Size = dim2(1,0,0,s_Page2MenuLayout.AbsoluteContentSize.Y+5)
                                        
                                        s_Page1Menu.Visible = false
                                        s_Page1Menu.AutomaticSize = "None"
                                        s_Page1Menu.Size = dim2sca(1,0)
                                    end)
                                end
                                
                            else
                                s_Page1Topbar.Size = dim2(1, 0, 0, 16)
                                s_Page1Menu.Visible = true
                                
                                s_Page2Topbar:Destroy()
                                s_Page2Topbar = nil
                                s_Page2Menu:Destroy()
                                s_Page2Menu = nil
                                
                                S_CurrentPage = nil
                            end
                            
                        end
                        
                        -- object
                        local S_Object = {} do 
                            function S_Object:GetParent() 
                                return M_Object
                            end
                            function S_Object:GetSelectedPage()
                                return S_CurrentPage == false and 'r' or 'l'
                            end
                            function S_Object:IsMinimized() 
                                return S_IsMinimized
                            end
                            
                            function S_Object:AddLabel(L_Text, L_Page) 
                                -- filter input
                                assert(type(L_Text) == "string", msg:format('AddLabel','L_Text','string'))
                                if (L_Page) then
                                    assert(type(L_Page) == "number", msg:format('AddLabel','L_Page','number'))
                                else
                                    L_Page = 1
                                end
                                
                                local l_TextLabel
                                local l_LabelPadding
                                
                                l_TextLabel = inst("TextLabel")
                                l_TextLabel.BackgroundTransparency = 1
                                l_TextLabel.Size = dim2(1, -2, 0, 20)
                                l_TextLabel.TextXAlignment = "Left"
                                l_TextLabel.TextYAlignment = "Top"
                                l_TextLabel.Font = ui.Font
                                l_TextLabel.TextStrokeTransparency = 0
                                l_TextLabel.TextColor3 = colors['t1']
                                l_TextLabel.TextSize = 17
                                l_TextLabel.TextWrapped = true
                                l_TextLabel.RichText = true
                                l_TextLabel.Text = L_Text
                                l_TextLabel.ZIndex = 10
                                if (L_Page == 1) then
                                    l_TextLabel.Parent = s_Page1Menu
                                else
                                    l_TextLabel.Parent = s_Page2Menu
                                end                                
                                l_LabelPadding = inst("UIPadding")
                                l_LabelPadding.PaddingLeft = dim2off(2, 0).X
                                l_LabelPadding.Parent = l_TextLabel
                                
                                for i = 1, 100 do
                                    if (l_TextLabel.TextFits) then break end
                                    l_TextLabel.Size += dim2off(0, 20)
                                end 
                                
                                local L_Object = {} do 
                                    function L_Object:GetParent() 
                                        return S_Object
                                    end
                                end
                                
                                return L_Object
                            end
                            function S_Object:AddButton(B_Text, B_Page) 
                                -- filter input
                                assert(type(B_Text) == "string", msg:format('AddButton', 'B_Text', 'string'))
                                if (B_Page) then
                                    assert(type(B_Page) == "number", msg:format('AddButton', 'B_Page', 'number'))
                                else
                                    B_Page = 1
                                end
                                
                                -- locals 
                                local B_Tooltip
                                local B_Flags = {}
                                B_Flags["Clicked"] = false
                                
                                -- local insts
                                local b_Button
                                 local b_ButtonPadding
                                 local b_ButtonOutline
                                 
                                -- insts
                                do
                                    b_Button = inst("TextButton")
                                    b_Button.Active = true
                                    b_Button.AutoButtonColor = false
                                    b_Button.BorderSizePixel = 0
                                    b_Button.BackgroundColor3 = colors['b1']
                                    b_Button.BackgroundTransparency = 0
                                    b_Button.Size = dim2(1, -4, 0, 18)
                                    b_Button.TextXAlignment = "Left"
                                    b_Button.TextYAlignment = "Top"
                                    b_Button.Font = ui.Font
                                    b_Button.TextStrokeTransparency = 0
                                    b_Button.TextColor3 = colors['t1']
                                    b_Button.TextSize = 17
                                    b_Button.TextWrapped = true
                                    b_Button.RichText = true
                                    b_Button.Text = B_Text
                                    b_Button.ZIndex = 10
                                    if (B_Page == 1) then
                                        b_Button.Parent = s_Page1Menu
                                    else
                                        b_Button.Parent = s_Page2Menu
                                    end
                                    
                                    b_ButtonOutline = inst("UIStroke")
                                    b_ButtonOutline.LineJoinMode = "Miter"
                                    b_ButtonOutline.Color = colors['w1']
                                    b_ButtonOutline.Thickness = 1
                                    b_ButtonOutline.ApplyStrokeMode = "Border"
                                    b_ButtonOutline.Parent = b_Button
                                    
                                    b_ButtonPadding = inst("UIPadding")
                                    b_ButtonPadding.PaddingLeft = dim2off(2, 0).X
                                    b_ButtonPadding.Parent = b_Button
                                end
                                
                                -- object
                                local B_Object = {} do 
                                    function B_Object:GetParent() 
                                        return S_Object
                                    end 
                                    function B_Object:ConnectFlag(B_FlagName, B_Func) 
                                        assert(type(B_FlagName) == 'string', msg:format('ConnectFlag', 'B_FlagName', 'string'))
                                        assert(type(B_Func) == 'function', msg:format('ConnectFlag', 'B_Func', 'function'))
                                        
                                        if (B_Flags[B_FlagName] == false) then
                                            B_Flags[B_FlagName] = B_Func
                                        end
                                        
                                        return B_Object
                                    end
                                    function B_Object:Fire()
                                        if (B_Flags["Clicked"]) then 
                                            B_Flags["Clicked"]()
                                        end
                                        return B_Object
                                    end
                                    
                                    function B_Object:SetTooltip(B_Text) 
                                        if (B_Text) then
                                            B_Tooltip = tostring(B_Text)
                                        else
                                            B_Tooltip = nil
                                        end
                                        return B_Object
                                    end
                                end
                                
                                -- Callbacks
                                do 
                                    b_Button.MouseEnter:Connect(function() 
                                        twn(b_Button, {BackgroundColor3 = colors['b2']})
                                        
                                        if (B_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(B_Tooltip)
                                        end
                                    end)
                                    
                                    b_Button.MouseLeave:Connect(function() 
                                        twn(b_Button, {BackgroundColor3 = colors['b1']})
                                        
                                        if (tooltip.text == B_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    b_Button.MouseButton1Click:Connect(function() 
                                        b_Button.BackgroundColor3 = colors['b4']
                                        twn(b_Button, {BackgroundColor3 = colors['b2']}, true)
                                        B_Object:Fire()
                                    end)
                                end
                                
                                return B_Object
                            end
                            function S_Object:AddToggle(T_Text, T_Page) 
                                -- filter input
                                assert(type(T_Text) == "string", msg:format('AddToggle', 'T_Text', 'string'))
                                if (T_Page) then
                                    assert(type(T_Page) == "number", msg:format('AddToggle', 'T_Page', 'number'))
                                else
                                    T_Page = 1
                                end
                                
                                -- locals
                                local T_Tooltip
                                local T_IsToggled = false
                                local T_Flags = {}
                                T_Flags["Enabled"] = false
                                T_Flags["Toggled"] = false
                                T_Flags["Disabled"] = false
                                
                                -- instances 
                                local t_Toggle
                                 local t_ToggleOutline
                                 local t_ToggleIcon1
                                  local t_ToggleIcon2
                                 local t_TogglePadding
                                
                                do 
                                    t_Toggle = inst("TextButton")
                                    t_Toggle.Active = true
                                    t_Toggle.AutoButtonColor = false
                                    t_Toggle.BorderSizePixel = 0
                                    t_Toggle.BackgroundColor3 = colors['b1']
                                    t_Toggle.BackgroundTransparency = 0
                                    t_Toggle.Size = dim2(1, -4, 0, 18)
                                    t_Toggle.TextXAlignment = "Left"
                                    t_Toggle.TextYAlignment = "Top"
                                    t_Toggle.Font = ui.Font
                                    t_Toggle.TextStrokeTransparency = 0
                                    t_Toggle.TextColor3 = colors['t1']
                                    t_Toggle.TextSize = 17
                                    t_Toggle.TextWrapped = false
                                    t_Toggle.RichText = true
                                    t_Toggle.Text = T_Text
                                    t_Toggle.ZIndex = 10
                                    
                                     t_ToggleOutline = inst("UIStroke")
                                     t_ToggleOutline.LineJoinMode = "Miter"
                                     t_ToggleOutline.Color = colors['w1']
                                     t_ToggleOutline.Thickness = 1
                                     t_ToggleOutline.ApplyStrokeMode = "Border"
                                     t_ToggleOutline.Parent = t_Toggle
                                    
                                     t_ToggleIcon1 = inst("Frame")
                                     t_ToggleIcon1.BorderColor3 = colors['w1']
                                     t_ToggleIcon1.BackgroundColor3 = colors['w2']
                                     t_ToggleIcon1.Size = dim2off(16,16)
                                     t_ToggleIcon1.Position = dim2(1, -17, 0, 1)
                                     t_ToggleIcon1.BorderMode = "Inset"
                                     t_ToggleIcon1.ZIndex = 11
                                     t_ToggleIcon1.Parent = t_Toggle
                                     
                                      t_ToggleIcon2 = inst("Frame")
                                      t_ToggleIcon2.BackgroundColor3 = colors['b3']
                                      t_ToggleIcon2.BackgroundTransparency = 1
                                      t_ToggleIcon2.BorderSizePixel = 0
                                      t_ToggleIcon2.Size = dim2off(12,12)
                                      t_ToggleIcon2.Position = dim2(0, 1, 0, 1)
                                      t_ToggleIcon2.ZIndex = 11
                                      t_ToggleIcon2.Parent = t_ToggleIcon1
                                     
                                     t_TogglePadding = inst("UIPadding")
                                     t_TogglePadding.PaddingLeft = dim2off(2, 0).X
                                     t_TogglePadding.Parent = t_Toggle
                                end
                                
                                if (T_Page == 1) then
                                    t_Toggle.Parent = s_Page1Menu
                                else
                                    t_Toggle.Parent = s_Page2Menu
                                end
                                
                                -- Object
                                local T_Object = {} do 
                                    function T_Object:GetParent() 
                                        return S_Object
                                    end
                                    function T_Object:IsEnabled() 
                                        return T_IsToggled
                                    end
                                    function T_Object:GetState() 
                                        return T_IsToggled
                                    end
                                    function T_Object:Toggle() 
                                        T_IsToggled = not T_IsToggled
                                        
                                        if (T_IsToggled) then
                                            
                                            twn(t_ToggleIcon2, {BackgroundTransparency = 0})
                                            
                                            if (T_Flags["Enabled"]) then
                                                T_Flags["Enabled"]()
                                            end
                                        else
                                            
                                            twn(t_ToggleIcon2, {BackgroundTransparency = 1})
                                            
                                            if (T_Flags["Disabled"]) then
                                                T_Flags["Disabled"]()
                                            end
                                        end
                                        
                                        if (T_Flags["Toggled"]) then
                                            T_Flags["Toggled"](T_IsToggled)
                                        end
                                        
                                        return T_Object
                                    end
                                    function T_Object:ConnectFlag(T_FlagName, T_Func) 
                                        assert(type(T_FlagName) == 'string', msg:format('ConnectFlag', 'T_FlagName', 'string'))
                                        assert(type(T_Func) == 'function', msg:format('ConnectFlag', 'T_Func', 'function'))
                                        
                                        if (T_Flags[T_FlagName] == false) then
                                            T_Flags[T_FlagName] = T_Func
                                        end
                                        
                                        return T_Object
                                    end
                                    function T_Object:SetTooltip(T_Text) 
                                        if (T_Text) then
                                            T_Tooltip = tostring(T_Text)
                                        else
                                            T_Tooltip = nil
                                        end
                                        return T_Object
                                    end
                                end
                                
                                -- Callbacks
                                do 
                                    t_Toggle.MouseEnter:Connect(function() 
                                        twn(t_Toggle, {BackgroundColor3 = colors['b2']})
                                        
                                        if (T_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(T_Tooltip)
                                        end
                                    end)
                                    
                                    t_Toggle.MouseLeave:Connect(function() 
                                        twn(t_Toggle, {BackgroundColor3 = colors['b1']})
                                        
                                        if (tooltip.text == T_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    t_Toggle.MouseButton1Click:Connect(function() 
                                        T_Object:Toggle()
                                    end)
                                end
                                
                                ins(objects[3], T_Object)
                                
                                -- Return
                                return T_Object
                            end
                            function S_Object:AddInput(T_Text, T_Page) 
                                -- filter input
                                assert(type(T_Text) == "string", msg:format('AddInput', 'T_Text', 'string'))
                                if (T_Page) then
                                    assert(type(T_Page) == "number", msg:format('AddInput', 'T_Page', 'number'))
                                else
                                    T_Page = 1
                                end
                                
                                -- locals
                                local T_Tooltip
                                local T_Focused = false
                                local T_Flags = {}
                                T_Flags["Unfocused"] = false
                                T_Flags["Focused"] = false
                                T_Flags["TextChanged"] = false
                                
                                -- instances 
                                local t_InputBox
                                 local t_InputBoxOutline
                                 local t_InputPadding
                                 local t_InputIcon
                                
                                do 
                                    t_InputBox = inst("TextBox")
                                    t_InputBox.Active = true
                                    t_InputBox.BorderSizePixel = 0
                                    t_InputBox.BackgroundColor3 = colors['b1']
                                    t_InputBox.BackgroundTransparency = 0
                                    t_InputBox.Size = dim2(1, -4, 0, 18)
                                    t_InputBox.TextXAlignment = "Left"
                                    t_InputBox.TextYAlignment = "Top"
                                    t_InputBox.Font = ui.Font
                                    t_InputBox.TextStrokeTransparency = 0
                                    t_InputBox.TextColor3 = colors['t1']
                                    t_InputBox.TextSize = 17
                                    t_InputBox.Text = T_Text
                                    t_InputBox.TextWrapped = false
                                    t_InputBox.RichText = false
                                    t_InputBox.ZIndex = 10
                                    
                                     t_InputBoxOutline = inst("UIStroke")
                                     t_InputBoxOutline.LineJoinMode = "Miter"
                                     t_InputBoxOutline.Color = colors['w1']
                                     t_InputBoxOutline.Thickness = 1
                                     t_InputBoxOutline.ApplyStrokeMode = "Border"
                                     t_InputBoxOutline.Parent = t_InputBox
                                    
                                     t_InputPadding = inst("UIPadding")
                                     t_InputPadding.PaddingLeft = dim2off(2, 0).X
                                     t_InputPadding.Parent = t_InputBox
                                     
                                     t_InputIcon = inst("ImageLabel")
                                     t_InputIcon.BackgroundTransparency = 1
                                     t_InputIcon.ImageColor3 = colors['t3']
                                     t_InputIcon.Image = icons[5]
                                     t_InputIcon.ZIndex = 11
                                     t_InputIcon.Visible = true
                                     t_InputIcon.Size = dim2off(12, 12)
                                     t_InputIcon.AnchorPoint = vec2(1, 0)
                                     t_InputIcon.Position = dim2(1, -3, 0, 3)
                                     t_InputIcon.Parent = t_InputBox
                                     
                                end
                                
                                if (T_Page == 1) then
                                    t_InputBox.Parent = s_Page1Menu
                                else
                                    t_InputBox.Parent = s_Page2Menu
                                end
                                
                                -- Object
                                local T_Object = {} do 
                                    function T_Object:GetParent() 
                                        return S_Object
                                    end
                                    function T_Object:IsFocused() 
                                        return T_Focused 
                                    end
                                    function T_Object:GetState() 
                                        return T_Focused 
                                    end
                                    function T_Object:GetText() 
                                        return t_InputBox.Text
                                    end
                                    function T_Object:ConnectFlag(T_FlagName, T_Func) 
                                        assert(type(T_FlagName) == 'string', msg:format('ConnectFlag', 'T_FlagName', 'string'))
                                        assert(type(T_Func) == 'function', msg:format('ConnectFlag', 'T_Func', 'function'))
                                        
                                        if (T_Flags[T_FlagName] == false) then
                                            T_Flags[T_FlagName] = T_Func
                                        end
                                        
                                        return T_Object
                                    end
                                    function T_Object:SetTooltip(T_Text) 
                                        if (T_Text) then
                                            T_Tooltip = tostring(T_Text)
                                        else
                                            T_Tooltip = nil
                                        end
                                        return T_Object
                                    end
                                end
                                
                                -- Callbacks
                                do 
                                    t_InputBox.MouseEnter:Connect(function() 
                                        twn(t_InputBox, {BackgroundColor3 = T_Focused and colors['b4'] or colors['b2']})
                                        
                                        if (T_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(T_Tooltip)
                                        end
                                    end)
                                    
                                    t_InputBox.MouseLeave:Connect(function() 
                                        twn(t_InputBox, {BackgroundColor3 = T_Focused and colors['b3'] or colors['b1']})
                                        
                                        if (tooltip.text == T_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    t_InputBox.Focused:Connect(function() 
                                        T_Focused = true
                                        
                                        if (T_Flags['Focused']) then
                                            T_Flags['Focused']()
                                        end
                                        
                                        twn(t_InputBox, {BackgroundColor3 = colors['b4']})
                                        
                                        t_InputBox.TextColor3 = colors['t3']
                                    end)
                                    
                                    t_InputBox.FocusLost:Connect(function(IsEnter, IoObject) 
                                        T_Focused = false
                                        
                                        if (T_Flags['Unfocused']) then
                                            T_Flags['Unfocused'](t_InputBox.Text, IsEnter, IoObject)
                                        end
                                        
                                        twn(t_InputBox, {BackgroundColor3 = colors['b1']})
                                        
                                        t_InputBox.TextColor3 = colors['t1']
                                        t_InputBox.Text = T_Text
                                    end)
                                    
                                    t_InputBox:GetPropertyChangedSignal("Text"):Connect(function() 
                                        
                                        if (T_Flags['TextChanged']) then
                                            T_Flags['TextChanged'](t_InputBox.Text)
                                        end
                                        
                                    end)
                                end
                                
                                
                                -- Return
                                return T_Object
                            end
                            function S_Object:AddSlider(S_Text, S_Page, S_Settings) 
                                -- filter input
                                assert(type(S_Text) == "string", msg:format('AddSlider', 'S_Text', 'string'))
                                if (S_Page) then
                                    assert(type(S_Page) == "number", msg:format('AddSlider', 'S_Page', 'number'))
                                else
                                    S_Page = 1
                                end
                                if (S_Settings) then
                                    assert(type(S_Settings) == "table", msg:format('AddSlider', 'S_Settings', 'table'))
                                else
                                    S_Settings = {}
                                end
                                
                                S_Settings['min']     = S_Settings['min']     or 0
                                S_Settings['max']     = S_Settings['max']     or 100
                                S_Settings['step']    = S_Settings['step']    or 1
                                S_Settings['current'] = S_Settings['current'] or 20
                                
                                assert(type(S_Settings['min']) == "number", msg:format('AddSlider', 'S_Settings.min', 'number'))
                                assert(type(S_Settings['max']) == "number", msg:format('AddSlider', 'S_Settings.max', 'number'))
                                assert(type(S_Settings['step']) == "number", msg:format('AddSlider', 'S_Settings.step', 'number'))
                                assert(type(S_Settings['current']) == "number", msg:format('AddSlider', 'S_Settings.current', 'number'))
                                
                                if (S_Settings['current'] > S_Settings['max']) then
                                    warn("S_Settings.current was above S_Settings.max, set to S_Settings.max")
                                    S_Settings['current'] = S_Settings['max']
                                end
                                if (S_Settings['current'] < S_Settings['min']) then
                                    warn("S_Settings.current was below S_Settings.min, set to S_Settings.min")
                                    S_Settings['current'] = S_Settings['min']
                                end
                                
                                if (tostring(S_Settings['step']):match("e%-")) then
                                    error(("%s failed; %s was too %s"):format('AddSlider', 'S_Settings.step', 'small'))
                                end
                                if (tostring(S_Settings['step']):match("e%+")) then 
                                    error(("%s failed; %s was too %s"):format('AddSlider', 'S_Settings.step', 'large'))
                                end
                                
                                -- locals
                                local S_Tooltip
                                local S_DragConnection
                                local S_Flags = {}
                                S_Flags["ValueChangeStarted"] = false
                                S_Flags["ValueChangeEnded"] = false
                                S_Flags["ValueChanged"] = false
                                
                                
                                local s_TextLabel
                                 local s_TextPadding
                                local s_SliderBox
                                 local s_SliderBoxOutline
                                 local s_SliderAmnt
                                 local s_SliderFill
                                
                                do
                                    s_TextLabel = inst("TextLabel")
                                    s_TextLabel.BackgroundTransparency = 1
                                    s_TextLabel.Size = dim2(1, -2, 0, 20)
                                    s_TextLabel.TextXAlignment = "Left"
                                    s_TextLabel.TextYAlignment = "Top"
                                    s_TextLabel.Font = ui.Font
                                    s_TextLabel.TextStrokeTransparency = 0
                                    s_TextLabel.TextColor3 = colors['t1']
                                    s_TextLabel.TextSize = 17
                                    s_TextLabel.TextWrapped = true
                                    s_TextLabel.RichText = true
                                    s_TextLabel.Text = S_Text
                                    s_TextLabel.ZIndex = 10
                                    if (S_Page == 1) then
                                        s_TextLabel.Parent = s_Page1Menu
                                    else
                                        s_TextLabel.Parent = s_Page2Menu
                                    end                                
                                     s_TextPadding = inst("UIPadding")
                                     s_TextPadding.PaddingLeft = dim2off(2, 0).X
                                     s_TextPadding.Parent = s_TextLabel
                                    
                                    s_SliderBox = inst("Frame")
                                    s_SliderBox.Active = false
                                    s_SliderBox.Selectable = false
                                    s_SliderBox.BorderSizePixel = 0
                                    s_SliderBox.BackgroundColor3 = colors['sl1']
                                    s_SliderBox.BackgroundTransparency = 0
                                    s_SliderBox.ClipsDescendants = true
                                    s_SliderBox.Size = dim2(1, -4, 0, 18)
                                    s_SliderBox.ZIndex = 10
                                    
                                     s_SliderBoxOutline = inst("UIStroke")
                                     s_SliderBoxOutline.LineJoinMode = "Miter"
                                     s_SliderBoxOutline.Color = colors['w1']
                                     s_SliderBoxOutline.Thickness = 1
                                     s_SliderBoxOutline.ApplyStrokeMode = "Border"
                                     s_SliderBoxOutline.Parent = s_SliderBox
                                    
                                    s_SliderFill = inst("Frame")
                                    s_SliderFill.BorderSizePixel = 0
                                    s_SliderFill.AnchorPoint = vec2(1,0)
                                    s_SliderFill.BackgroundColor3 = colors['sl2']
                                    s_SliderFill.BackgroundTransparency = 0
                                    s_SliderFill.Parent = s_SliderBox
                                    s_SliderFill.Size = dim2sca(3,1)
                                    s_SliderFill.Position = dim2sca(0,0)
                                    s_SliderFill.ZIndex = 10
                                    s_SliderFill.Parent = s_SliderBox
                                    
                                    s_SliderAmnt = inst("TextLabel")
                                    s_SliderAmnt.BackgroundTransparency = 1
                                    s_SliderAmnt.Size = dim2sca(1,1)
                                    s_SliderAmnt.Position = dim2off(0, -1)
                                    s_SliderAmnt.TextXAlignment = "Center"
                                    s_SliderAmnt.TextYAlignment = "Center"
                                    s_SliderAmnt.Font = ui.Font
                                    s_SliderAmnt.TextStrokeTransparency = 0
                                    s_SliderAmnt.TextColor3 = colors['t1']
                                    s_SliderAmnt.TextSize = 17
                                    s_SliderAmnt.TextWrapped = false
                                    s_SliderAmnt.RichText = false
                                    s_SliderAmnt.ZIndex = 10
                                    s_SliderAmnt.Parent = s_SliderBox
                                    
                                    if (S_Page == 1) then
                                        s_SliderBox.Parent = s_Page1Menu
                                    else
                                        s_SliderBox.Parent = s_Page2Menu
                                    end   
                                end
                                
                                -- handle slider math
                                local ValueCurrent = S_Settings['current']
                                local ValuePrevious = ValueCurrent

                                local ValueMin = S_Settings['min']
                                local ValueMax = S_Settings['max']
                                local ValueStep = S_Settings['step']

                                local SliderSize = s_SliderBox.AbsoluteSize.X
                                
                                local ValueRatio = SliderSize / (ValueMax - ValueMin)
                                local ValueRatioInverse = 1 / ValueRatio
                                
                                local StepFormat = #(tostring(ValueStep):match("%.(%d+)") or '')
                                StepFormat = ("%."..StepFormat.."f")
                                
                                
                                
                                
                                -- Set position: floor((ValueCurrent - ValueMin) * ratio)
                                
                                s_SliderAmnt.Text = ValueCurrent
                                s_SliderFill.Position = dim2off(floor((ValueCurrent - ValueMin) * ValueRatio), 0)
                                
                                -- Objects
                                local Sl_Object = {} do 
                                    function Sl_Object:GetParent() 
                                        return S_Object
                                    end
                                    function Sl_Object:SetValue(S_NewValue) 
                                        assert(type(S_NewValue) == "number", msg:format('SetValue', 'S_NewValue', 'number'))
                                        
                                        ValueCurrent = round(clamp(S_NewValue, ValueMin, ValueMax), ValueStep)
                                        
                                        if (ValuePrevious ~= ValueCurrent) then
                                            ValuePrevious = ValueCurrent
                                            
                                            s_SliderFill.Position = dim2off(floor((ValueCurrent - ValueMin) * ValueRatio), 0)
                                            s_SliderAmnt.Text = StepFormat:format(ValueCurrent)
                                            
                                            if (S_Flags["ValueChanged"]) then
                                                S_Flags["ValueChanged"](ValueCurrent)
                                            end
                                        end
                                        return Sl_Object
                                    end
                                    function Sl_Object:GetValue() 
                                        return ValueCurrent
                                    end
                                    function Sl_Object:ConnectFlag(S_FlagName, S_Func) 
                                        assert(type(S_FlagName) == 'string', msg:format('ConnectFlag', 'S_FlagName', 'string'))
                                        assert(type(S_Func) == 'function', msg:format('ConnectFlag', 'S_Func', 'function'))
                                        
                                        if (S_Flags[S_FlagName] == false) then
                                            S_Flags[S_FlagName] = S_Func
                                        end
                                        
                                        return Sl_Object
                                    end
                                    function Sl_Object:SetTooltip(S_Text) 
                                        if (S_Text) then
                                            S_Tooltip = tostring(S_Text)
                                        else
                                            S_Tooltip = nil
                                        end
                                        return Sl_Object
                                    end
                                end
                                
                                -- Callbacks
                                do 
                                    s_SliderBox.MouseEnter:Connect(function() 
                                        twn(s_SliderBox, {BackgroundColor3 = colors['sl3']})
                                        
                                        if (S_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(S_Tooltip)
                                        end
                                        
                                    end)
                                    
                                    s_SliderBox.MouseLeave:Connect(function() 
                                        twn(s_SliderBox, {BackgroundColor3 = colors['sl1']})
                                        
                                        if (tooltip.text == S_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    s_SliderBox.InputBegan:Connect(function(io,gpe)
                                        if (io.UserInputType.Value == 0) then
                                            local pos_begin = io.Position.X
                                            local pos_normalized = clamp(pos_begin - s_SliderBox.AbsolutePosition.X, 0, SliderSize)
                                            ValueCurrent = round((pos_normalized * (ValueRatioInverse))+ValueMin, ValueStep)
                                            
                                            if (ValuePrevious ~= ValueCurrent) then
                                                ValuePrevious = ValueCurrent
                                                
                                                s_SliderFill.Position = dim2off(floor((ValueCurrent - ValueMin) * ValueRatio), 0)
                                                
                                                s_SliderAmnt.Text = StepFormat:format(ValueCurrent)
                                                
                                                if (S_Flags["ValueChanged"]) then
                                                    S_Flags["ValueChanged"](ValueCurrent)
                                                end
                                            end
                                            
                                            if (S_Flags["ValueChangeStarted"]) then
                                                S_Flags["ValueChangeStarted"](ValueCurrent)
                                            end
                                            
                                            
                                            
                                            
                                            S_DragConnection = serv_uis.InputChanged:Connect(function(io) 
                                                if (io.UserInputType.Value == 4) then
                                                    local pos_begin = io.Position.X
                                                    local pos_normalized = clamp(pos_begin - s_SliderBox.AbsolutePosition.X, 0, SliderSize) -- how far the mouse is along the x
                                                    ValueCurrent = round((pos_normalized * (ValueRatioInverse))+ValueMin, ValueStep) -- rounded to step
                                                    
                                                    if (ValuePrevious ~= ValueCurrent) then
                                                        ValuePrevious = ValueCurrent
                                                        
                                                        s_SliderFill.Position = dim2off(floor((ValueCurrent - ValueMin) * ValueRatio), 0)
                                                        
                                                        s_SliderAmnt.Text = StepFormat:format(ValueCurrent)
                                                        
                                                        if (S_Flags["ValueChanged"]) then
                                                            S_Flags["ValueChanged"](ValueCurrent)
                                                        end
                                                    end
                                                end
                                            end)
                                        end
                                    end)
                                    s_SliderBox.InputEnded:Connect(function(io,gpe) 
                                        if (io.UserInputType.Value == 0) then
                                            S_DragConnection:Disconnect()
                                            
                                            if (S_Flags["ValueChangeEnded"]) then
                                                S_Flags["ValueChangeEnded"](ValueCurrent)
                                            end
                                        end
                                    end)
                                end
                                
                                
                                return Sl_Object
                            end
                            
                            function S_Object:AddDropdown(D_Text, D_Page, D_Settings)
                                -- filter input
                                assert(type(D_Text) == "string", msg:format('AddMultiDropdown', 'D_Text', 'string'))
                                if (D_Page) then
                                    assert(type(D_Page) == "number", msg:format('AddMultiDropdown', 'D_Page', 'number'))
                                else
                                    D_Page = 1
                                end
                                if (D_Settings) then
                                    assert(type(D_Settings) == "table", msg:format('AddMultiDropdown', 'D_Settings', 'table'))
                                    
                                    local aux = {}
                                    for i = 1, #D_Settings do 
                                        local a = D_Settings[i]
                                        if (a) then
                                            
                                            local s = aux[a]
                                            aux[a] = (s and s + 1) or 1
                                            
                                            s = aux[a]
                                            if (s > 1) then
                                                D_Settings[i] = a .. " " ..s
                                            end
                                        end
                                    end
                                    
                                else
                                    D_Settings = {}
                                    D_Settings[1] = "Item 1"
                                    D_Settings[2] = "Item 2"
                                end
                                
                                -- locals
                                local D_Tooltip
                                local D_IsOpen = false
                                local D_Flags = {}
                                D_Flags['SelectionChanged'] = false
                                
                                
                                local D_Items = {}
                                
                                -- instances
                                local d_DropRoot
                                 local d_DropToggle
                                  local d_DropTogglePadding
                                  local d_DropToggleOutline
                                  local d_DropToggleIcon
                                 local d_DropMenu
                                  local d_DropMenuLayout
                                  local d_DropMenuPadding
                                
                                do
                                    d_DropRoot = inst("Frame")
                                    d_DropRoot.Size = dim2(1, -4, 0, 18)
                                    d_DropRoot.AutomaticSize = "Y"
                                    d_DropRoot.BackgroundTransparency = 1
                                    d_DropRoot.ZIndex = 12
                                    
                                     d_DropToggle = inst("TextButton")
                                     d_DropToggle.Active = true
                                     d_DropToggle.AutoButtonColor = false
                                     d_DropToggle.BorderColor3 = colors['w1']
                                     d_DropToggle.BorderMode = "Inset"
                                     d_DropToggle.BorderSizePixel = 0
                                     d_DropToggle.BackgroundColor3 = colors['b1']
                                     d_DropToggle.BackgroundTransparency = 0
                                     d_DropToggle.Size = dim2(1, 0, 0, 18)
                                     d_DropToggle.TextXAlignment = "Left"
                                     d_DropToggle.TextYAlignment = "Top"
                                     d_DropToggle.Font = ui.Font
                                     d_DropToggle.TextStrokeTransparency = 0
                                     d_DropToggle.TextColor3 = colors['t1']
                                     d_DropToggle.TextSize = 17
                                     d_DropToggle.Text = D_Text
                                     d_DropToggle.TextWrapped = false
                                     d_DropToggle.RichText = false
                                     d_DropToggle.ZIndex = 12
                                     d_DropToggle.Parent = d_DropRoot
                                     
                                      d_DropTogglePadding = inst("UIPadding")
                                      d_DropTogglePadding.PaddingLeft = dim2off(2, 0).X
                                      d_DropTogglePadding.Parent = d_DropToggle
                                      
                                      d_DropToggleOutline = inst("UIStroke")
                                      d_DropToggleOutline.LineJoinMode = "Miter"
                                      d_DropToggleOutline.Color = colors['w1']
                                      d_DropToggleOutline.Thickness = 1
                                      d_DropToggleOutline.ApplyStrokeMode = "Border"
                                      d_DropToggleOutline.Parent = d_DropToggle
                                      
                                      d_DropToggleIcon = inst("ImageLabel")
                                      d_DropToggleIcon.BackgroundTransparency = 1
                                      d_DropToggleIcon.BorderSizePixel = 0
                                      d_DropToggleIcon.Position = dim2(1, -22, 0, -1)
                                      d_DropToggleIcon.Size = dim2off(19, 19)
                                      d_DropToggleIcon.Image = icons[6]
                                      d_DropToggleIcon.ZIndex = 12
                                      d_DropToggleIcon.ResampleMode = "Pixelated"
                                      d_DropToggleIcon.Parent = d_DropToggle
                                      
                                     d_DropMenu = inst("ScrollingFrame")
                                     d_DropMenu.Size = dim2(1, 0, 0, 20)
                                     d_DropMenu.ClipsDescendants = false
                                     d_DropMenu.Position = dim2off(0, 20)
                                     d_DropMenu.BackgroundTransparency = 1
                                     d_DropMenu.BackgroundColor3 = c3(0,0,1)
                                     d_DropMenu.ScrollBarImageTransparency = 1
                                     d_DropMenu.ScrollBarThickness = 0
                                     d_DropMenu.TopImage = ""
                                     d_DropMenu.BottomImage = ""
                                     d_DropMenu.BorderSizePixel = 0
                                     d_DropMenu.AutomaticSize = "None"
                                     d_DropMenu.ZIndex = 8
                                     d_DropMenu.Visible = false
                                     d_DropMenu.Parent = d_DropToggle
                                     
                                      d_DropMenuLayout = inst("UIListLayout")
                                      d_DropMenuLayout.FillDirection = "Vertical"
                                      d_DropMenuLayout.VerticalAlignment = "Top"
                                      d_DropMenuLayout.HorizontalAlignment = "Center"
                                      d_DropMenuLayout.Padding = dim2off(0, 3).Y
                                      d_DropMenuLayout.SortOrder = "LayoutOrder"
                                      d_DropMenuLayout.Parent = d_DropMenu
                                      
                                      d_DropMenuPadding = inst("UIPadding")
                                      d_DropMenuPadding.PaddingTop = dim2off(0, 1).Y
                                      d_DropMenuPadding.PaddingRight = dim2off(2,0).X
                                      d_DropMenuPadding.Parent = d_DropMenu
                                end
                                
                                if (D_Page == 1) then
                                    d_DropRoot.Parent = s_Page1Menu
                                else
                                    d_DropRoot.Parent = s_Page2Menu
                                end
                                
                                -- items
                                local function create(Di_Name) 
                                    do
                                        local aux = {}
                                        
                                        for i = 1, #D_Items do 
                                            local a = D_Items[i]
                                            if (a) then
                                                local name1 = a.Name
                                                local name2, amnt = name1:match("(.+) (%d+)")
                                                
                                                
                                                if (amnt) then
                                                    aux[tostring(amnt)] = true
                                                    
                                                    
                                                    if (Di_Name == name1 or Di_Name == name2) then
                                                        if (not aux[tostring(amnt+1)]) then
                                                            Di_Name = name2 .. " ".. (amnt + 1)
                                                        end
                                                    end
                                                else
                                                    if (Di_Name == name1) then
                                                        amnt = 1
                                                        aux[tostring(amnt)] = true
                                                        Di_Name = name1 .. " ".. (amnt)
                                                    end
                                                end
                                            end
                                        end
                                        aux = nil
                                    end
                                    
                                    local Di_Button
                                     local Di_ButtonOutline
                                     local Di_Padding
                                    
                                    local Di_IsSelected = false
                                    
                                    Di_Button = inst("TextButton")
                                    Di_Button.Active = true
                                    Di_Button.AutoButtonColor = false
                                    Di_Button.BorderSizePixel = 0
                                    Di_Button.BackgroundColor3 = colors['dd1']
                                    Di_Button.BackgroundTransparency = 0
                                    Di_Button.Size = dim2(1, 2, 0, 18)
                                    Di_Button.TextXAlignment = "Left"
                                    Di_Button.TextYAlignment = "Top"
                                    Di_Button.Font = ui.Font
                                    Di_Button.TextStrokeTransparency = 0
                                    Di_Button.TextColor3 = colors['t1']
                                    Di_Button.TextSize = 17
                                    Di_Button.TextWrapped = false
                                    Di_Button.RichText = true
                                    Di_Button.Text = Di_Name
                                    Di_Button.ZIndex = 12
                                    Di_Button.Parent = d_DropMenu
                                    
                                     Di_ButtonOutline = inst("UIStroke")
                                     Di_ButtonOutline.LineJoinMode = "Miter"
                                     Di_ButtonOutline.Color = colors['w1']
                                     Di_ButtonOutline.Thickness = 1
                                     Di_ButtonOutline.ApplyStrokeMode = "Border"
                                     Di_ButtonOutline.Parent = Di_Button
                                    
                                     Di_Padding = inst("UIPadding")
                                     Di_Padding.PaddingLeft = dim2off(2, 0).X
                                     Di_Padding.Parent = Di_Button
                                     
                                    
                                    local Di_Object = {} do 
                                        function Di_Object:Select() 
                                            
                                            for i = 1, #D_Items do 
                                                local d = D_Items[i]
                                                if (d) then
                                                    d:Deselect()
                                                end
                                            end
                                            
                                            
                                            Di_IsSelected = true
                                            
                                            twn(Di_Button, {
                                                BackgroundColor3 = colors['dd4']
                                            })
                                        
                                            if (D_Flags['SelectionChanged']) then
                                                D_Flags['SelectionChanged'](Di_Name)
                                            end
                                            
                                        end
                                        
                                        function Di_Object:Deselect() 
                                            
                                            Di_IsSelected = false
                                            
                                            twn(Di_Button, {
                                                BackgroundColor3 = colors['dd1']
                                            })
                                            
                                        end
                                        
                                        function Di_Object:IsSelected() 
                                            return Di_IsSelected
                                        end
                                        
                                        function Di_Object:Destroy() 
                                            Di_Button:Destroy()
                                            Di_IsSelected = nil
                                            Di_Object = nil
                                        end
                                        
                                        Di_Object.Name = Di_Name
                                    end
                                    
                                    Di_Button.MouseEnter:Connect(function() 
                                        twn(Di_Button, {BackgroundColor3 = Di_IsSelected and colors['dd4'] or colors['dd2']})
                                    end)
                                    
                                    Di_Button.MouseLeave:Connect(function() 
                                        twn(Di_Button, {BackgroundColor3 = Di_IsSelected and colors['dd3'] or colors['dd1']})
                                    end)
                                    
                                    Di_Button.MouseButton1Click:Connect(function()
                                        Di_Object:Select()
                                    end)
                                    
                                    
                                    ins(D_Items, Di_Object)
                                    
                                    
                                    if (#D_Items == 1) then
                                        Di_Object:Select()
                                    end
                                    
                                end
                                
                                for _,item in ipairs(D_Settings) do 
                                    create(item)
                                end
                                
                                
                                local D_Object = {} do 
                                    function D_Object:GetParent() 
                                        return S_Object
                                    end
                                    
                                    function D_Object:AddItem(D_ItemName) 
                                        create(tostring(D_ItemName))
                                    end
                                    function D_Object:RemoveItem(D_ItemName) -- refactored
                                        if (type(D_ItemName) == 'number') then 
                                            local item = D_Items[D_ItemName]
                                            if (item) then 
                                                item:Destroy() 
                                                rem(D_Items, D_ItemName)
                                            end
                                        else
                                            D_ItemName = tostring(D_ItemName)
                                            
                                            for i = 1, #D_Items do 
                                                local item = D_Items[i]
                                                if (item and item.Name == D_ItemName) then
                                                    item:Destroy()
                                                    rem(D_Items, i)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    function D_Object:SetItems(D_NewItems) 
                                        assert(type(D_NewItems) == "table", msg:format('SetItems', 'D_NewItems', 'table'))
                                        
                                        for i = 1, #D_Items do 
                                            local item = D_Items[i]
                                            if (item) then
                                                item:Destroy()
                                            end
                                        end
                                        clr(D_Items)
                                        
                                        for i = 1, #D_NewItems do
                                            local new = D_NewItems[i]
                                            if (new) then
                                                create(tostring(new))
                                            end
                                        end
                                    end
                                    
                                    function D_Object:SetSelection(D_NewItem) -- refactored
                                        if (type(D_NewItem) == 'number') then
                                            
                                            local item = D_Items[D_NewItem]
                                            if (item) then
                                                item:Select()
                                            end
                                        else
                                            D_NewItem = tostring(D_NewItem)
                                            
                                            for i = 1, #D_Items do 
                                                local item = D_Items[i]
                                                if (item) then
                                                    if (item.Name == D_NewItem) then
                                                        item:Select()
                                                        break
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    function D_Object:GetSelection() 
                                        if (#D_Items == 0) then return nil end
                                        for i = 1, #D_Items do 
                                            local item = D_Items[i]
                                            if (item:IsSelected()) then
                                                return item.Name
                                            end
                                        end
                                    end
                                    
                                    function D_Object:SetTooltip(D_Text) 
                                        if (D_Text) then
                                            D_Tooltip = tostring(D_Text)
                                        else
                                            D_Tooltip = nil
                                        end
                                        return D_Object
                                    end
                                    
                                    function D_Object:ConnectFlag(D_FlagName, D_Func) 
                                        assert(type(D_FlagName) == 'string', msg:format('ConnectFlag', 'D_FlagName', 'string'))
                                        assert(type(D_Func) == 'function', msg:format('ConnectFlag', 'D_Func', 'function'))
                                        
                                        if (D_Flags[D_FlagName] == false) then
                                            D_Flags[D_FlagName] = D_Func
                                        end
                                        
                                        return D_Object
                                    end
                                end
                                
                                -- Callbacks
                                do 
                                    
                                    d_DropToggle.MouseEnter:Connect(function() 
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b4'] or colors['b2']})
                                        
                                        if (D_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(D_Tooltip)
                                        end
                                    end)
                                    
                                    d_DropToggle.MouseLeave:Connect(function() 
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b3'] or colors['b1']})
                                        
                                        if (tooltip.text == D_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    d_DropToggle.MouseButton1Click:Connect(function() 
                                        D_IsOpen = not D_IsOpen
                                        
                                        d_DropMenu.Visible = D_IsOpen
                                        
                                        d_DropToggleIcon.Rotation = D_IsOpen and -90 or 0
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b4'] or colors['b2']})
                                    end)
                                end
                                
                                return D_Object
                                
                            end
                            
                            function S_Object:AddMultiDropdown(D_Text, D_Page, D_Settings)
                                -- filter input
                                assert(type(D_Text) == "string", msg:format('AddMultiDropdown', 'D_Text', 'string'))
                                if (D_Page) then
                                    assert(type(D_Page) == "number", msg:format('AddMultiDropdown', 'D_Page', 'number'))
                                else
                                    D_Page = 1
                                end
                                if (D_Settings) then
                                    assert(type(D_Settings) == "table", msg:format('AddMultiDropdown', 'D_Settings', 'table'))
                                    
                                    local aux = {}
                                    for i = 1, #D_Settings do 
                                        local a = D_Settings[i]
                                        if (a) then
                                            
                                            local s = aux[a]
                                            aux[a] = (s and s + 1) or 1
                                            
                                            s = aux[a]
                                            if (s > 1) then
                                                D_Settings[i] = a .. " " ..s
                                            end
                                        end
                                    end
                                    
                                else
                                    D_Settings = {}
                                    D_Settings[1] = "Item 1"
                                    D_Settings[2] = "Item 2"
                                end
                                
                                -- locals
                                local D_Tooltip
                                local D_IsOpen = false
                                local D_Flags = {}
                                D_Flags['SelectionChanged'] = false
                                
                                
                                local D_Items = {}
                                
                                -- instances
                                local d_DropRoot
                                 local d_DropToggle
                                  local d_DropTogglePadding
                                  local d_DropToggleOutline
                                  local d_DropToggleIcon
                                 local d_DropMenu
                                  local d_DropMenuLayout
                                  local d_DropMenuPadding
                                
                                do
                                    d_DropRoot = inst("Frame")
                                    d_DropRoot.Size = dim2(1, -4, 0, 18)
                                    d_DropRoot.AutomaticSize = "Y"
                                    d_DropRoot.BackgroundTransparency = 1
                                    d_DropRoot.ZIndex = 12
                                    
                                     d_DropToggle = inst("TextButton")
                                     d_DropToggle.Active = true
                                     d_DropToggle.AutoButtonColor = false
                                     d_DropToggle.BorderColor3 = colors['w1']
                                     d_DropToggle.BorderMode = "Inset"
                                     d_DropToggle.BorderSizePixel = 0
                                     d_DropToggle.BackgroundColor3 = colors['b1']
                                     d_DropToggle.BackgroundTransparency = 0
                                     d_DropToggle.Size = dim2(1, 0, 0, 18)
                                     d_DropToggle.TextXAlignment = "Left"
                                     d_DropToggle.TextYAlignment = "Top"
                                     d_DropToggle.Font = ui.Font
                                     d_DropToggle.TextStrokeTransparency = 0
                                     d_DropToggle.TextColor3 = colors['t1']
                                     d_DropToggle.TextSize = 17
                                     d_DropToggle.Text = D_Text
                                     d_DropToggle.TextWrapped = false
                                     d_DropToggle.RichText = false
                                     d_DropToggle.ZIndex = 12
                                     d_DropToggle.Parent = d_DropRoot
                                     
                                      d_DropTogglePadding = inst("UIPadding")
                                      d_DropTogglePadding.PaddingLeft = dim2off(2, 0).X
                                      d_DropTogglePadding.Parent = d_DropToggle
                                      
                                      d_DropToggleOutline = inst("UIStroke")
                                      d_DropToggleOutline.LineJoinMode = "Miter"
                                      d_DropToggleOutline.Color = colors['w1']
                                      d_DropToggleOutline.Thickness = 1
                                      d_DropToggleOutline.ApplyStrokeMode = "Border"
                                      d_DropToggleOutline.Parent = d_DropToggle
                                      
                                      d_DropToggleIcon = inst("ImageLabel")
                                      d_DropToggleIcon.BackgroundTransparency = 1
                                      d_DropToggleIcon.BorderSizePixel = 0
                                      d_DropToggleIcon.Position = dim2(1, -22, 0, -1)
                                      d_DropToggleIcon.Size = dim2off(19, 19)
                                      d_DropToggleIcon.Image = icons[6]
                                      d_DropToggleIcon.ZIndex = 12
                                      d_DropToggleIcon.ResampleMode = "Pixelated"
                                      d_DropToggleIcon.Parent = d_DropToggle
                                      
                                     d_DropMenu = inst("ScrollingFrame")
                                     d_DropMenu.Size = dim2(1, 0, 0, 20)
                                     d_DropMenu.ClipsDescendants = false
                                     d_DropMenu.Position = dim2off(0, 20)
                                     d_DropMenu.BackgroundTransparency = 1
                                     d_DropMenu.BackgroundColor3 = c3(0,0,1)
                                     d_DropMenu.ScrollBarImageTransparency = 1
                                     d_DropMenu.ScrollBarThickness = 0
                                     d_DropMenu.TopImage = ""
                                     d_DropMenu.BottomImage = ""
                                     d_DropMenu.BorderSizePixel = 0
                                     d_DropMenu.AutomaticSize = "None"
                                     d_DropMenu.ZIndex = 8
                                     d_DropMenu.Visible = false
                                     d_DropMenu.Parent = d_DropToggle
                                     
                                      d_DropMenuLayout = inst("UIListLayout")
                                      d_DropMenuLayout.FillDirection = "Vertical"
                                      d_DropMenuLayout.VerticalAlignment = "Top"
                                      d_DropMenuLayout.HorizontalAlignment = "Center"
                                      d_DropMenuLayout.Padding = dim2off(0, 3).Y
                                      d_DropMenuLayout.SortOrder = "LayoutOrder"
                                      d_DropMenuLayout.Parent = d_DropMenu
                                      
                                      d_DropMenuPadding = inst("UIPadding")
                                      d_DropMenuPadding.PaddingTop = dim2off(0, 1).Y
                                      d_DropMenuPadding.PaddingRight = dim2off(2,0).X
                                      d_DropMenuPadding.Parent = d_DropMenu
                                end
                                
                                if (D_Page == 1) then
                                    d_DropRoot.Parent = s_Page1Menu
                                else
                                    d_DropRoot.Parent = s_Page2Menu
                                end
                                
                                -- items
                                local function create(Di_Name) 
                                    do
                                        local aux = {}
                                        
                                        for i = 1, #D_Items do 
                                            local a = D_Items[i]
                                            if (a) then
                                                local name1 = a.Name
                                                local name2, amnt = name1:match("(.+) (%d+)")
                                                
                                                
                                                if (amnt) then
                                                    aux[tostring(amnt)] = true
                                                    
                                                    
                                                    if (Di_Name == name1 or Di_Name == name2) then
                                                        if (not aux[tostring(amnt+1)]) then
                                                            Di_Name = name2 .. " ".. (amnt + 1)
                                                        end
                                                    end
                                                else
                                                    if (Di_Name == name1) then
                                                        amnt = 1
                                                        aux[tostring(amnt)] = true
                                                        Di_Name = name1 .. " ".. (amnt)
                                                    end
                                                end
                                            end
                                        end
                                        aux = nil
                                    end
                                    
                                    local Di_Button
                                     local Di_ButtonOutline
                                     local Di_Padding
                                    
                                    local Di_IsSelected = false
                                    
                                    Di_Button = inst("TextButton")
                                    Di_Button.Active = true
                                    Di_Button.AutoButtonColor = false
                                    Di_Button.BorderSizePixel = 0
                                    Di_Button.BackgroundColor3 = colors['dd1']
                                    Di_Button.BackgroundTransparency = 0
                                    Di_Button.Size = dim2(1, 2, 0, 18)
                                    Di_Button.TextXAlignment = "Left"
                                    Di_Button.TextYAlignment = "Top"
                                    Di_Button.Font = ui.Font
                                    Di_Button.TextStrokeTransparency = 0
                                    Di_Button.TextColor3 = colors['t1']
                                    Di_Button.TextSize = 17
                                    Di_Button.TextWrapped = false
                                    Di_Button.RichText = true
                                    Di_Button.Text = Di_Name
                                    Di_Button.ZIndex = 12
                                    Di_Button.Parent = d_DropMenu
                                    
                                     Di_ButtonOutline = inst("UIStroke")
                                     Di_ButtonOutline.LineJoinMode = "Miter"
                                     Di_ButtonOutline.Color = colors['w1']
                                     Di_ButtonOutline.Thickness = 1
                                     Di_ButtonOutline.ApplyStrokeMode = "Border"
                                     Di_ButtonOutline.Parent = Di_Button
                                    
                                     Di_Padding = inst("UIPadding")
                                     Di_Padding.PaddingLeft = dim2off(2, 0).X
                                     Di_Padding.Parent = Di_Button
                                     
                                    
                                    local Di_Object = {} do 
                                        function Di_Object:Select() 
                                            
                                            
                                            Di_IsSelected = true
                                            
                                            twn(Di_Button, {
                                                BackgroundColor3 = colors['dd4']
                                            })
                                            
                                            
                                            if (D_Flags['SelectionChanged']) then
                                                D_Flags['SelectionChanged'](Di_Name)
                                            end
                                        end
                                        
                                        function Di_Object:Deselect() 
                                            
                                            Di_IsSelected = false
                                            
                                            twn(Di_Button, {
                                                BackgroundColor3 = colors['dd1']
                                            })
                                            
                                        end
                                        
                                        function Di_Object:IsSelected() 
                                            return Di_IsSelected
                                        end
                                        
                                        function Di_Object:Destroy() 
                                            Di_Button:Destroy()
                                            Di_IsSelected = nil
                                            Di_Object = nil
                                        end
                                        
                                        Di_Object.Name = Di_Name
                                    end
                                    
                                    Di_Button.MouseEnter:Connect(function() 
                                        twn(Di_Button, {BackgroundColor3 = Di_IsSelected and colors['dd4'] or colors['dd2']})
                                    end)
                                    
                                    Di_Button.MouseLeave:Connect(function() 
                                        twn(Di_Button, {BackgroundColor3 = Di_IsSelected and colors['dd3'] or colors['dd1']})
                                    end)
                                    
                                    Di_Button.MouseButton1Click:Connect(function()
                                        Di_IsSelected = not Di_IsSelected
                                        if (Di_IsSelected) then
                                            Di_Object:Select()
                                        else
                                            Di_Object:Deselect()
                                        end
                                    end)
                                    
                                    ins(D_Items, Di_Object)
                                    
                                    if (#D_Items == 1) then
                                        Di_Object:Select()
                                    end
                                    
                                end
                                
                                for _,item in ipairs(D_Settings) do 
                                    create(item)
                                end
                                
                                
                                local D_Object = {} do 
                                    function D_Object:GetParent() 
                                        return S_Object
                                    end
                                    function D_Object:AddItem(D_ItemName) 
                                        create(tostring(D_ItemName))
                                    end
                                    
                                    function D_Object:RemoveItem(D_ItemName) -- refactored
                                        if (type(D_ItemName) == 'number') then 
                                            local item = D_Items[D_ItemName]
                                            if (item) then 
                                                item:Destroy() 
                                                rem(D_Items, D_ItemName)
                                            end
                                            
                                        else
                                            D_ItemName = tostring(D_ItemName)
                                            
                                            for i = 1, #D_Items do 
                                                local item = D_Items[i]
                                                if (item and item.Name == D_ItemName) then
                                                    item:Destroy()
                                                    rem(D_Items, i)
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    function D_Object:SetItems(D_NewItems) 
                                        assert(type(D_NewItems) == "table", msg:format('SetItems', 'D_NewItems', 'table'))
                                        
                                        for i = 1, #D_Items do 
                                            local item = D_Items[i]
                                            if (item) then
                                                item:Destroy()
                                            end
                                        end
                                        clr(D_Items)
                                        
                                        for i = 1, #D_NewItems do
                                            local new = D_NewItems[i]
                                            if (new) then
                                                create(tostring(new))
                                            end
                                        end
                                    end
                                    
                                    function D_Object:AddSelection(D_ItemName) -- refactored
                                        if (type(D_ItemName) == 'number') then
                                            local item = D_Items[D_ItemName]
                                            if (item) then 
                                                item:Select()
                                            end
                                        else
                                            D_ItemName = tostring(D_ItemName)
                                            
                                            for i = 1, #D_Items do 
                                                local item = D_Items[i]
                                                if (item and item.Name == D_ItemName) then
                                                    item:Select()
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    function D_Object:RemoveSelection(D_ItemName) -- refactored
                                        if (type(D_ItemName) == 'number') then
                                            local item = D_Items[D_ItemName]
                                            if (item) then 
                                                item:Deselect()
                                            end
                                        else
                                            D_ItemName = tostring(D_ItemName)
                                            
                                            for i = 1, #D_Items do 
                                                local item = D_Items[i]
                                                if (item and item.Name == D_ItemName) then
                                                    item:Deselect()
                                                    break
                                                end
                                            end
                                        end
                                    end
                                    
                                    function D_Object:SetSelections(D_NewItems) 
                                        assert(type(D_NewItems) == "table", msg:format('SetItems', 'D_NewItems', 'table'))
                                        
                                        local lookupified = {}
                                        for i = 1, #D_NewItems do 
                                            lookupified[D_NewItems[i]] = true
                                        end
                                        D_NewItems = nil
                                        
                                        for i = 1, #D_Items do 
                                            local item = D_Items[i]
                                            if (item) then
                                                if (lookupified[item.Name]) then
                                                    item:Select()
                                                else
                                                    item:Deselect()
                                                end
                                            end
                                        end
                                        
                                    end
                                    function D_Object:GetSelections() 
                                        local a = {}
                                        
                                        if (#D_Items == 0) then return a end
                                        for i = 1, #D_Items do 
                                            local item = D_Items[i]
                                            if (item:IsSelected()) then
                                                ins(a, item.Name)
                                            end
                                        end
                                        return a
                                    end
                                    
                                    function D_Object:SetTooltip(D_Text) 
                                        if (D_Text) then
                                            D_Tooltip = tostring(D_Text)
                                        else
                                            D_Tooltip = nil
                                        end
                                        return D_Tooltip
                                    end
                                    
                                    function D_Object:ConnectFlag(D_FlagName, D_Func) 
                                        assert(type(D_FlagName) == 'string', msg:format('ConnectFlag', 'D_FlagName', 'string'))
                                        assert(type(D_Func) == 'function', msg:format('ConnectFlag', 'D_Func', 'function'))
                                        
                                        if (D_Flags[D_FlagName] == false) then
                                            D_Flags[D_FlagName] = D_Func
                                        end
                                        
                                        return D_Object
                                    end
                                    
                                end
                                
                                -- Callbacks
                                do 
                                    
                                    d_DropToggle.MouseEnter:Connect(function() 
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b4'] or colors['b2']})
                                        
                                        if (D_Tooltip) then
                                            tooltip.visible = true
                                            tooltip.root.Visible = true
                                            tooltip.changetext(D_Tooltip)
                                        end
                                    end)
                                    
                                    d_DropToggle.MouseLeave:Connect(function() 
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b3'] or colors['b1']})
                                        
                                        if (tooltip.text == D_Tooltip) then
                                            tooltip.visible = false
                                            tooltip.root.Visible = false
                                        end
                                    end)
                                    
                                    d_DropToggle.MouseButton1Click:Connect(function() 
                                        D_IsOpen = not D_IsOpen
                                        
                                        d_DropMenu.Visible = D_IsOpen
                                        d_DropToggleIcon.Rotation = D_IsOpen and -90 or 0
                                        twn(d_DropToggle, {BackgroundColor3 = D_IsOpen and colors['b4'] or colors['b2']})
                                    end)
                                end
                                
                                return D_Object
                                
                            end
                        end
                        -- callbacks
                        do 
                            s_Page1Topbar.MouseEnter:Connect(function() 
                                
                                twn(s_Page1Topbar, {
                                    BackgroundColor3 = S_CurrentPage and colors['b4'] or colors['b2']
                                })
                            end)
                            
                            s_Page1Topbar.MouseLeave:Connect(function() 
                                twn(s_Page1Topbar, {
                                    BackgroundColor3 = S_CurrentPage and colors['b3'] or colors['b1']
                                })
                            end)
                            
                            
                            if (s_Page2Topbar) then 
                                s_Page1Topbar.MouseButton1Click:Connect(function() 
                                    S_CurrentPage = true
                                    
                                    s_Page1Menu.Visible = true
                                    s_Page1Menu.AutomaticSize = "Y"
                                    s_Page1Menu.Size = dim2(1,0,0,s_Page1MenuLayout.AbsoluteContentSize.Y+5)
                                    
                                    s_Page2Menu.Visible = false
                                    s_Page2Menu.AutomaticSize = "None"
                                    s_Page2Menu.Size = dim2sca(1,0)
                                    
                                    twn(s_Page1Topbar, {
                                        BackgroundColor3 = colors['b4']
                                    })
                                    twn(s_Page2Topbar, {
                                        BackgroundColor3 = colors['b1']
                                    })
                                end)
                            
                                s_Page2Topbar.MouseEnter:Connect(function() 
                                    
                                    twn(s_Page2Topbar, {
                                        BackgroundColor3 = (S_CurrentPage == false and colors['b4']) or colors['b2']
                                    })
                                end)
                                
                                s_Page2Topbar.MouseLeave:Connect(function() 
                                    twn(s_Page2Topbar, {
                                        BackgroundColor3 = (S_CurrentPage == false and colors['b3']) or colors['b1']
                                    })
                                end)
                                
                                s_Page2Topbar.MouseButton1Click:Connect(function() 
                                    S_CurrentPage = false
                                    
                                    s_Page2Menu.Visible = true
                                    s_Page2Menu.AutomaticSize = "Y"
                                    s_Page2Menu.Size = dim2(1,0,0,s_Page2MenuLayout.AbsoluteContentSize.Y+5)
                                    
                                    s_Page1Menu.Visible = false
                                    s_Page1Menu.AutomaticSize = "None"
                                    s_Page1Menu.Size = dim2sca(1,0)
                                    
                                    twn(s_Page2Topbar, {
                                        BackgroundColor3 = colors['b4']
                                    })
                                    twn(s_Page1Topbar, {
                                        BackgroundColor3 = colors['b1']
                                    })
                                end)
                            
                            end
                        end
                        
                        return S_Object
                    end
                end
                
                
                -- callbacks
                do 
                    m_TabButton.MouseEnter:Connect(function() 
                        
                        twn(m_TabButton, {
                            BackgroundColor3 = M_IsSelected and colors['b4'] or colors['b2']
                        })
                    end)
                    
                    m_TabButton.MouseLeave:Connect(function() 
                        twn(m_TabButton, {
                            BackgroundColor3 = M_IsSelected and colors['b3'] or colors['b1']
                        })
                    end)
                    
                    m_TabButton.MouseButton1Click:Connect(function() 
                        M_Object:Select()
                    end)
                end
                
                ins(objects[2], M_Object)
                ins(W_Children, M_Object)
                
                return M_Object
            end
            function W_Object:AddMenuDivider() 
                W_MenuCount += 1
                w_TabMenu.CanvasSize += dim2off(0, 3)
                
                local m_TabDivider = inst("Frame")
                m_TabDivider.BackgroundTransparency = 0
                m_TabDivider.BorderColor3 = colors['w1']
                m_TabDivider.BorderMode = "Inset"
                m_TabDivider.BackgroundColor3 = colors['b3']
                m_TabDivider.Size = dim2off(98, 3)
                m_TabDivider.ZIndex = 15
                m_TabDivider.LayoutOrder = W_MenuCount
                m_TabDivider.Parent = w_TabMenu
                
                local D_Object = {} do 
                    function D_Object:GetParent() 
                        return W_Object
                    end
                end
                return D_Object
            end
            
            function W_Object:GetMenu(title) 
                for i = 1, #W_Children do 
                    if (W_Children[i].Title == title) then
                        return W_Children[i]
                    end
                end
            end
            
        end
        ins(objects[1], W_Object)
        
        -- Callbacks
        do
            w_Topbar.InputBegan:Connect(function(io) 
            if (io.UserInputType.Value == 0) then

                local root_pos = w_RootFrame.AbsolutePosition
                local start_pos = io.Position
                start_pos = vec2(start_pos.X, start_pos.Y)
                
                tda[#tda+1] = serv_uis.InputChanged:Connect(function(io) 
                    if (io.UserInputType.Value == 4) then
                        local curr_pos = io.Position
                        curr_pos = vec2(curr_pos.X, curr_pos.Y)
                        
                        local destination = root_pos + (curr_pos - start_pos)
                        W_WINPOS = vec2(destination.X, destination.Y)
                        
                        w_RootFrame.Position = dim2off(destination.X, destination.Y)
                        --twn(w_RootFrame, {Position = dim2off(destination.X,destination.Y)})
                    end
                end)
            end
        end)
            w_Topbar.InputEnded:Connect(function(io) 
            if (io.UserInputType.Value == 0) then
                local tda_CONN = tda[#tda]
                if (tda_CONN) then
                    tda_CONN:Disconnect()
                    tda[#tda],tda_CONN = nil
                end
            end
            
            w_ResizeHandle.InputBegan:Connect(function(io)
                if (io.UserInputType.Value == 0) then
                    local root_size = w_RootFrame.AbsoluteSize
                    local start_pos = io.Position
                    start_pos = vec2(start_pos.X, start_pos.Y)
                    
                    tda[#tda+1] = serv_uis.InputChanged:Connect(function(io) 
                        if (io.UserInputType.Value == 4) then
                            local curr_pos = io.Position
                            curr_pos = vec2(curr_pos.X, curr_pos.Y)
                            
                            local final_size = root_size + (curr_pos - start_pos)
                            
                            W_WIDTHBUFFER = clamp(final_size.X, 200, 800)
                            W_HEIGHTBUFFER = clamp(final_size.Y, 200, 700)
                            
                            W_WINSIZEHALF = vec2(W_WIDTHBUFFER, W_HEIGHTBUFFER)*.5
                            
                            w_RootFrame.Size = dim2off(W_WIDTHBUFFER, W_HEIGHTBUFFER)
                            
                            W_WIDTHBUFFER += 80
                            W_HEIGHTBUFFER += 60
                            --twn(w_RootFrame, {Position = dim2off(destination.X,destination.Y)})
                        end
                    end)
                end
            end)
            w_ResizeHandle.InputEnded:Connect(function(io) 
                if (io.UserInputType.Value == 0) then
                    local tda_CONN = tda[#tda]
                    if (tda_CONN) then
                        tda_CONN:Disconnect()
                        tda[#tda],tda_CONN = nil
                    end
                end
            end)
        end)
        
        
        
            w_TopbarMin.MouseEnter:Connect(function() 
                
                twn(w_TopbarMin, {
                    BackgroundColor3 = W_Minimized and colors['b4'] or colors['b2']
                })
            end)
            
            w_TopbarMin.MouseLeave:Connect(function() 
                twn(w_TopbarMin, {
                    BackgroundColor3 = W_Minimized and colors['b3'] or colors['b1']
                })
            end)
            
            w_TopbarClose.MouseEnter:Connect(function() 
                
                twn(w_TopbarClose, {
                    BackgroundColor3 = colors['b2']
                })
            end)
            
            w_TopbarClose.MouseLeave:Connect(function() 
                twn(w_TopbarClose, {
                    BackgroundColor3 = colors['b1']
                })
            end)
            
        
            w_TopbarMin.MouseButton1Click:Connect(function() 
                W_Minimized = not W_Minimized
                twn(w_TopbarMin, {
                    BackgroundColor3 = W_Minimized and colors['b4'] or colors['b2']
                })
                
                twn(w_RootFrame, {
                    Size = W_Minimized and dim2off(W_WindowWidth, 25) or dim2off(W_WindowWidth, W_WindowHeight)
                }, true)
                
                w_TopbarMin.Image = W_Minimized and icons[4] or icons[3]
            end)
            
            w_TopbarClose.MouseButton1Click:Connect(function() 
                if (#objects[1] == 1) then
                    ui:Destroy()
                else

                    rem(objects[1], W_WindowId)
                    ltc[W_WindowId+2]:Disconnect()
                    W_Object:Close()
                end
            end)
        
        end
        
        return W_Object 
    end
    
    function ui:Ready() 
        screen.Name = getname()
        for _,a in ipairs(screen:GetDescendants()) do 
            a.Name = getname()
        end
    end
    function ui:Destroy() 
        if (Ui_Flags['Exiting']) then Ui_Flags['Exiting'](objects[3]) end
        
        for i = 1, #tda do 
            if (tda[i]) then
                tda[i]:Disconnect() 
            end
        end
        
        local windows = objects[1]
        for i = 1, #windows do 
            if (windows[i]) then
                windows[i]:Close()
            end
        end
        
        wait(1)
        
        
        screen:Destroy()
        
        for i = 1, #ltc do 
            if (ltc[i]) then
                ltc[i]:Disconnect()
            end
        end
        
        objects,colors = nil,nil
        
        
        if (Ui_Flags['Exited']) then Ui_Flags['Exited'](objects[3]) end
        ui = nil
    end
    
    local notification_offset = -50
    local notifs = {}
    
    function ui:SendNotification(N_Title, N_Description, N_Duration) 
        assert(type(N_Title)        == 'string' , msg:format('SendNotification','N_Title',       'string'))
        assert(type(N_Description)  == 'string' , msg:format('SendNotification','N_Description', 'string'))
        if (N_Duration) then
            assert(type(N_Duration)     == 'number' , msg:format('SendNotification','N_Duration',    'number'))
        else
            N_Duration = 1
        end
        
        
        N_Duration = clamp(N_Duration, 0.1, 30)
        
        local n_RootFrame
         local n_Background
          local n_MessageLabel
          local n_Progress
         local n_Topbar
          local n_TopbarLabel
          
        do
            
            n_RootFrame = inst("Frame")
            n_RootFrame.BackgroundColor3 = colors['w3']
            n_RootFrame.BorderColor3 = colors['w1']
            n_RootFrame.BorderMode = 'Outline'
            n_RootFrame.Visible = false
            n_RootFrame.AnchorPoint = vec2(1,1)
            n_RootFrame.Parent = screen
            
             n_Background = inst("Frame")
             n_Background.BackgroundTransparency = 1
             n_Background.BorderSizePixel = 0
             n_Background.ClipsDescendants = true
             n_Background.Size = dim2(1, 0, 1, -26)
             n_Background.Position = dim2off(0, 26)
             n_Background.ZIndex = 1
             n_Background.Parent = n_RootFrame
             
              n_MessageLabel = inst("TextLabel")
              n_MessageLabel.BackgroundTransparency = 1
              n_MessageLabel.Position = dim2off(3, 0)
              n_MessageLabel.Size = dim2(1, -5, 1, -2)
              n_MessageLabel.TextXAlignment = 'Left'
              n_MessageLabel.TextYAlignment = 'Top'
              n_MessageLabel.Font = ui.Font
              n_MessageLabel.TextStrokeTransparency = 0
              n_MessageLabel.TextColor3 = colors['t1']
              n_MessageLabel.TextSize = 20
              n_MessageLabel.RichText = true
              n_MessageLabel.TextWrapped = true
              n_MessageLabel.ZIndex = 50
              n_MessageLabel.Parent = n_Background
              
              n_Progress = inst("Frame")
              n_Progress.Size = dim2(1, 0, 0, 2)
              n_Progress.Position = dim2sca(0, 1)
              n_Progress.AnchorPoint = vec2(0, 1)
              n_Progress.BorderSizePixel = 0
              n_Progress.ZIndex = 3
              n_Progress.BackgroundColor3 = colors['b4']
              n_Progress.Parent = n_Background
             
             n_Topbar = inst("Frame")
             n_Topbar.Active = true
             n_Topbar.Size = dim2(1, 0, 0, 25)
             n_Topbar.BackgroundColor3 = colors['w2']
             n_Topbar.BorderColor3 = colors['w1']
             n_Topbar.BorderMode = 'Outline'
             n_Topbar.ZIndex = 15
             n_Topbar.Parent = n_RootFrame
             
              n_TopbarLabel = inst("TextLabel")
              n_TopbarLabel.BackgroundTransparency = 1
              n_TopbarLabel.Position = dim2off(3, 2)
              n_TopbarLabel.Size = dim2sca(1,1)
              n_TopbarLabel.TextXAlignment = 'Left'
              n_TopbarLabel.TextYAlignment = 'Top'
              n_TopbarLabel.Font = ui.Font
              n_TopbarLabel.TextStrokeTransparency = 0
              n_TopbarLabel.TextColor3 = colors['t1']
              n_TopbarLabel.RichText = true
              n_TopbarLabel.ZIndex = 50
              n_TopbarLabel.Parent = n_Topbar
              
        end
        
        -- this is extremely scuffed but it works
        -- gonna need a rewrite later
        -- still better than jeff 2 i think
        do 
            shadow(n_RootFrame)
            
            n_RootFrame.Size = dim2off(150, 75)
            n_TopbarLabel.TextSize = 23
            n_MessageLabel.TextSize = 23
            
            
            n_TopbarLabel.Text = N_Title
            n_MessageLabel.Text = N_Description
            
            for i = 1, 25 do 
                if (n_MessageLabel.TextFits) then break end
                n_RootFrame.Size += dim2off(15, 5)
            end
            
            for i = 1, 25 do 
                if (n_TopbarLabel.TextFits) then break end
                n_RootFrame.Size += dim2off(15, 0)
            end
            
            n_TopbarLabel.TextSize = 21
            n_MessageLabel.TextSize = 19
            
            local size = n_RootFrame.AbsoluteSize.Y+50
            local pos1 = dim2(1, -50, 1, notification_offset)
            n_RootFrame.Position = dim2(1, n_RootFrame.AbsoluteSize.X+50, 1, notification_offset)
            notification_offset -= size
            
            n_RootFrame.Visible = true
            ins(notifs, n_RootFrame)
            
            twn(n_RootFrame, {Position = pos1}, true)
            ctwn(n_Progress, {Size = dim2(0, 0, 0, 2)}, N_Duration)
            delay(N_Duration, function()
                local selfpos = n_RootFrame.AbsolutePosition.Y
                for i = 1, #notifs do 
                    if notifs[i] == n_RootFrame then
                        rem(notifs, i)
                    end
                end
                twn(n_RootFrame, {Position = dim2(1, -50, 1, size)},true)
                for i = 1, #notifs do 
                    local notif = notifs[i]
                    if (notif and notif.AbsolutePosition.Y < selfpos) then
                        twn(notif, {Position = notif.Position + dim2off(0, size)},true)
                    end
                end
                wait(0.2)
                n_RootFrame:Destroy()
                notification_offset += size
            end)
        end
    end
    
    delay(15, function() 
        pcall(function()
            if (ui and #objects[1] == 0) then
                warn(("[%s]: Jeff UI warning:\nLibrary never exited properly! If no windows are created call ui:Destroy() when finished"):format(os.date('%X')))
                ui:Destroy()
            end
        end)
    end)
    
    delay(35, function() 
        pcall(function() 
            if (ui and #objects[1] == 0) then
                warn(("[%s]: Jeff UI warning:\nLibrary never exited properly! If no windows are created call ui:Destroy() when finished"):format(os.date('%X')))
                ui:Destroy()
            end
        end)
    end)
end

return ui
