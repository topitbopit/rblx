-- Use with executors that arent synapse

local eventlistener;do local RBXEvent={}RBXEvent.__index=RBXEvent;local EventListener={}do EventListener.__index=EventListener;function EventListener.new(callback,disconnectFunction)local listenerObject={}setmetatable(listenerObject,EventListener)listenerObject.callback=callback;listenerObject.disconnectFunction=disconnectFunction;return listenerObject end;function EventListener:Disconnect()self.disconnectFunction(self.id)end;function EventListener:FireListener(...)coroutine.resume(coroutine.create(function(...)self.callback(...)end),...)end end;function RBXEvent.new()local RBXEventObject={}setmetatable(RBXEventObject,RBXEvent)RBXEventObject.active=true;RBXEventObject.observers={}return RBXEventObject end;function RBXEvent:Fire(...)for _,observer in pairs(self.observers)do observer:FireListener(...)end end;function RBXEvent:DisconnectListener(id)table.remove(self.observers,id)end;function RBXEvent:Connect(callback)if(callback==nil)then error("The event callback function provided was nil")return end;local listener=EventListener.new(callback,function(id)self:DisconnectListener(id)end)listener.id=#self.observers+1;table.insert(self.observers,listener)return listener end;function RBXEvent:Wait()local thread=coroutine.running()local connection;connection=self:Connect(function(...)connection:Disconnect()coroutine.resume(thread,...)end)return coroutine.yield()end;function RBXEvent:Destroy()for _,observer in pairs(self.observers)do observer:Disconnect()end;self.observers={}self.active=false end;eventlistener=RBXEvent end;local plrs=game:GetService("Players")local ts=game:GetService("TweenService")local uis=game:GetService("UserInputService")local rs=game:GetService("RunService")local ctx=game:GetService("ContextActionService")local log=game:GetService("LogService")local gui=game:GetService("GuiService")local plr=plrs.LocalPlayer;local color_new=Color3.new;local color_rgb=Color3.fromRGB;local color_hsv=Color3.fromHSV;local delay=task.delay;local wait=task.wait;local spawn=task.spawn;local cframe=CFrame.new;local vector2=Vector2.new;local vector3=Vector3.new;local udim2_scale=UDim2.fromScale;local udim2_offset=UDim2.fromOffset;local udim2_new=UDim2.new;local tweeninfo_new=TweenInfo.new;local clamp=math.clamp;local insert,remove=table.insert,table.remove;local mouse=plr:GetMouse()local screen=Instance.new("ScreenGui")screen.OnTopOfCoreBlur=true;screen.DisplayOrder=9183;screen.IgnoreGuiInset=true;screen.ZIndexBehavior=0;local screen_inset=gui:GetGuiInset().Y;local ui;local connections={}pcall(function()syn.protect_gui(screen)end)local function getrand(count)local str=""for i=1,count or 10 do str..=string.char(math.random(65,122))end;return str end;screen.Name=getrand(20)screen.Parent=(gethiddengui or gethui or get_hui or get_hidden_gui or function()return game.CoreGui end)()ui={}do ui.__index=ui;ui.Toggled=eventlistener.new()ui.Ready=eventlistener.new()local UIOBJ_FadeFrame;local UIOBJ_WindowFrame;local UIOBJ_ResizeMouse;local UI_WindowCount=0;local UI_Open=false;local UI_Res=screen.AbsoluteSize;local UI_HidingIcon=false;local twn;local ctwn;local function UI_DragModifier(detect,target)target=target or detect;local id=getrand(9)connections[id]=nil;detect.InputBegan:Connect(function(old_input)if(old_input.UserInputType==Enum.UserInputType.MouseButton1)then local starting_pos=target.Position;connections[id]=uis.InputChanged:Connect(function(new_input)if(new_input.UserInputType==Enum.UserInputType.MouseMovement)then local delta=new_input.Position-old_input.Position;local pos=starting_pos+udim2_offset(delta.X,delta.Y)pos=udim2_offset(clamp(pos.X.Offset,1,(UI_Res.X-target.AbsoluteSize.X)-1),clamp(pos.Y.Offset,1,(UI_Res.Y-target.AbsoluteSize.Y)-1))ctwn(target,{Position=pos},0.05,"Out","Quad")end end)end end)detect.InputEnded:Connect(function(cur_input)if(cur_input.UserInputType==Enum.UserInputType.MouseButton1 and connections[id])then connections[id]:Disconnect()end end)end;local function UI_ResizeModifier(detect,target,mode,min,max)local id=getrand(9)mode=mode or 3;min=min or vector2(225,175)max=max or vector2(700,500)local min_x=min.X;local min_y=min.Y;local max_x=max.X;local max_y=max.Y;connections[id]=nil;if(mode==1)then detect.InputBegan:Connect(function(old_input)if(old_input.UserInputType==Enum.UserInputType.MouseButton1)then local starting_size=target.Size;connections[id]=uis.InputChanged:Connect(function(new_input)if(new_input.UserInputType==Enum.UserInputType.MouseMovement)then local delta=(new_input.Position-old_input.Position)local new=starting_size+udim2_offset(delta.X,0)new=udim2_offset(clamp(new.X.Offset,min_x,max_x),clamp(new.Y.Offset,min_y,max_y))target.Size=new end end)end end)elseif(mode==2)then detect.InputBegan:Connect(function(old_input)if(old_input.UserInputType==Enum.UserInputType.MouseButton1)then local starting_size=target.Size;connections[id]=uis.InputChanged:Connect(function(new_input)if(new_input.UserInputType==Enum.UserInputType.MouseMovement)then local delta=(new_input.Position-old_input.Position)local new=starting_size+udim2_offset(0,delta.Y)new=udim2_offset(clamp(new.X.Offset,min_x,max_x),clamp(new.Y.Offset,min_y,max_y))target.Size=new end end)end end)elseif(mode==3)then detect.InputBegan:Connect(function(old_input)if(old_input.UserInputType==Enum.UserInputType.MouseButton1)then local starting_size=target.Size;connections[id]=uis.InputChanged:Connect(function(new_input)if(new_input.UserInputType==Enum.UserInputType.MouseMovement)then local delta=(new_input.Position-old_input.Position)local new=starting_size+udim2_offset(delta.X,delta.Y)new=udim2_offset(clamp(new.X.Offset,min_x,max_x),clamp(new.Y.Offset,min_y,max_y))target.Size=new end end)end end)elseif(mode==4)then detect.InputBegan:Connect(function(old_input)if(old_input.UserInputType==Enum.UserInputType.MouseButton1)then local starting_size=target.Size;local starting_pos=target.Position;connections[id]=uis.InputChanged:Connect(function(new_input)if(new_input.UserInputType==Enum.UserInputType.MouseMovement)then local delta=(new_input.Position-old_input.Position)local new=starting_size-udim2_offset(delta.X,0)local x=new.X.Offset;local y=new.Y.Offset;local move=true;if(x<175)then x=175;move=false elseif(x>700)then x=700;move=false end;if(y<175)then y=175;move=false elseif(y>500)then y=500;move=false end;new=udim2_offset(x,y)target.Size=new;target.Position=(move and starting_pos+udim2_offset(delta.X,0))or target.Position end end)end end)end;detect.InputEnded:Connect(function(cur_input)if(cur_input.UserInputType==Enum.UserInputType.MouseButton1 and connections[id])then connections[id]:Disconnect()end end)end;function ctwn(TweenTarget,TweenTo,TweenLength,TweenDirection,TweenStyle)local tween=ts:Create(TweenTarget,tweeninfo_new(TweenLength,Enum.EasingStyle[TweenStyle],Enum.EasingDirection[TweenDirection or"Out"]),TweenTo)tween:Play()return tween end;function twn(TweenTarget,TweenTo,TweenLength)local tween=ts:Create(TweenTarget,tweeninfo_new(TweenLength,8,1),TweenTo)tween:Play()return tween end;local function UI_RoundModifier(inst,le)le=le or 5;local among=Instance.new("UICorner")among.CornerRadius=UDim.new(0,le)among.Parent=inst;return among end;local function shadow(inst)local among=Instance.new("ImageLabel")among.BackgroundTransparency=1;among.Image="rbxassetid://7603818383"among.ImageColor3=Color3.new(0,0,0)among.ImageTransparency=0.15;among.Position=UDim2.new(0.5,0,0.5,0)among.AnchorPoint=Vector2.new(0.5,0.5)among.Size=UDim2.new(1,20,1,20)among.SliceCenter=Rect.new(15,15,175,175)among.SliceScale=1.3;among.ScaleType=Enum.ScaleType.Slice;among.ZIndex=inst.ZIndex-1;among.Parent=inst;return among end;local UI_Objects={windows={},menus={},tabs={},toggles={},buttons={},dropdowns={},sliders={},labels={},blur}local UI_Colors={button_enabled=color_new(0.52,0.52,0.52);button_outline=color_new(0.51,0.51,0.51);generic_white=color_new(1.00,1.00,1.00);generic_gray3=color_new(0.93,0.93,0.93);generic_gray2=color_new(0.60,0.60,0.60);generic_gray=color_new(0.27,0.27,0.27);generic_dark=color_new(0.02,0.02,0.02);generic_text=color_new(0.92,0.92,0.92);slider_header=color_new(0.70,0.70,0.70);dd_highlight=color_new(0.49,0.49,0.49);dd_background=color_new(0.35,0.35,0.35);dd_outline=color_new(0.11,0.11,0.11);window_lighter=color_new(0.16,0.16,0.16);window_outline=color_new(0.28,0.28,0.28);window_darkoutline=color_new(0.11,0.11,0.11);window_topbar=color_new(0.00,0.00,0.00);window_background=color_new(0.12,0.12,0.12);generic_enabled=color_hsv(0.38,0.88,0.88);generic_disabled=color_hsv(0.98,0.88,0.88)}local UI_Icons={pin="rbxassetid://8276501287";close="rbxassetid://8278323973";load="rbxassetid://8276501739";pinned="rbxassetid://8276500899";min="rbxassetid://8278213868";shutdown="rbxassetid://8277904453";window="rbxassetid://8278118177";resize="rbxassetid://8284456609";toggle="rbxassetid://8305179661"}local function UI_ButtonEffect(button,image)button.MouseEnter:Connect(function()twn(button,{BackgroundTransparency=0.4},0.2)end)button.MouseLeave:Connect(function()twn(button,{BackgroundTransparency=1},0.2)image.ImageTransparency=0 end)button.MouseButton1Down:Connect(function()button.BackgroundTransparency=1;image.ImageTransparency=0.2 end)button.MouseButton1Up:Connect(function()button.BackgroundTransparency=0.4;image.ImageTransparency=0 end)end;connections["Res"]=screen:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()UI_Res=screen.AbsoluteSize end)connections["Mouse"]=mouse.Move:Connect(function()UIOBJ_ResizeMouse.Position=udim2_offset(mouse.X,mouse.Y+screen_inset)end)function ui:Ready()ctx:BindActionAtPriority(ui.id,function(_,is)if(is~=Enum.UserInputState.Begin)then return end;UI_Open=not UI_Open;ui.Toggled:Fire(UI_Open)if(UI_Open)then UIOBJ_FadeFrame.Visible=true;twn(UIOBJ_FadeFrame,{BackgroundTransparency=0.6},.25)ctwn(UIOBJ_WindowFrame,{Position=udim2_scale(0,0)},.3,"Out","Cubic")UI_Objects.blur.Enabled=true;twn(UI_Objects.blur,{Size=20},0.5)else ctwn(UIOBJ_WindowFrame,{Position=udim2_scale(0,-1)},.3,"Out","Cubic")twn(UIOBJ_FadeFrame,{BackgroundTransparency=1},.25).Completed:Connect(function()if(UIOBJ_FadeFrame.BackgroundTransparency==1)then UIOBJ_FadeFrame.Visible=false end end)twn(UI_Objects.blur,{Size=0},0.5).Completed:Connect(function()if(UI_Objects.blur.Size==0)then UI_Objects.blur.Enabled=false end end)end end,false,9999999,Enum.KeyCode.RightShift)end;function ui:Destroy()ctx:UnbindAction(ui.id)screen:Destroy()for _,con in pairs(connections)do con:Disconnect()end;UI_Objects.blur:Destroy()UI_Objects,UI_Icons,UI_RGBInstances,UI_Colors,UI_DragModifier,ctwn,twn,getrand,UI_RoundModifier,ceffect,UI_ResizeModifier=nil end;function ui:NewWindow(WindowTitle,WindowX,WindowY,WindowResizable)UI_WindowCount+=1;WindowTitle=(type(WindowTitle)=="string"and WindowTitle or"n/a")WindowX=(type(WindowX)=="number"and clamp(WindowX,225,700)or 300)WindowY=(type(WindowY)=="number"and clamp(WindowY,175,500)or 200)WindowResizable=not(type(WindowResizable)=="boolean"and(WindowResizable==false and true or false)or false)local W_IsPinned=false;local W_Closed=eventlistener.new()local W_Index=UI_WindowCount*10;local W_AutoScrollEnabled=false;local W_SizeMin=vector2(375,225)local W_SizeMax=vector2(900,900)local w_RootFrame;local w_Topbar;local w_TopbarIcon;local w_TopbarTitle;local w_TopbarPin;local w_TopbarPinImage;local w_TopbarClose;local w_TopbarCloseImage;local w_Background;local w_ConsoleWindow;local w_ConsoleWindowLayout;local w_ClearConsoleButton;local w_AutoScrollText;local w_AutoScrollButton;local w_AutoScrollButtonHighlight;local w_InputBox;local w_InputBoxPadding;local w_ResizeRight;local w_ResizeDown;local w_ResizeCorner;do w_RootFrame=Instance.new("Frame")w_RootFrame.BackgroundTransparency=0.4;w_RootFrame.BorderSizePixel=1;w_RootFrame.BorderColor3=UI_Colors.window_outline;w_RootFrame.BackgroundColor3=UI_Colors.window_background;w_RootFrame.Size=udim2_offset(WindowX,WindowY)local x=50;local y=150;local mod=math.floor(UI_Res.X/350)for idx,window in ipairs(UI_Objects.windows)do x+=window.Width+50;if((UI_Res.X-x)<275)then y+=325;x=50 end end;w_RootFrame.Position=udim2_offset(x,y)w_RootFrame.ZIndex=W_Index;w_RootFrame.Parent=UIOBJ_WindowFrame end;do w_Topbar=Instance.new("Frame")w_Topbar.BorderSizePixel=0;w_Topbar.BackgroundColor3=UI_Colors.window_topbar;w_Topbar.Size=udim2_new(1,0,0,32)w_Topbar.ZIndex=(W_Index+1)w_Topbar.Parent=w_RootFrame;w_TopbarIcon=Instance.new("ImageLabel")w_TopbarIcon.Image=UI_Icons.window;w_TopbarIcon.ZIndex=(W_Index+1)w_TopbarIcon.Position=udim2_offset(8,8)w_TopbarIcon.Size=udim2_offset(16,16)w_TopbarIcon.BackgroundTransparency=1;w_TopbarIcon.Parent=w_Topbar;w_TopbarTitle=Instance.new("TextLabel")w_TopbarTitle.TextXAlignment=Enum.TextXAlignment.Left;w_TopbarTitle.TextYAlignment=Enum.TextYAlignment.Center;w_TopbarTitle.Position=udim2_offset(32,0)w_TopbarTitle.Size=udim2_new(0.7,-32,1,0)w_TopbarTitle.BackgroundTransparency=1;w_TopbarTitle.ZIndex=(W_Index+1)w_TopbarTitle.TextSize=19;w_TopbarTitle.Text=WindowTitle;w_TopbarTitle.Font=Enum.Font.SourceSansSemibold;w_TopbarTitle.TextColor3=UI_Colors.generic_text;w_TopbarTitle.Parent=w_Topbar;w_TopbarPin=Instance.new("TextButton")w_TopbarPin.ZIndex=(W_Index+1)w_TopbarPin.AnchorPoint=vector2(1,0)w_TopbarPin.Position=udim2_new(1,-2,0,2)w_TopbarPin.Size=udim2_offset(28,28)w_TopbarPin.BackgroundTransparency=1;w_TopbarPin.BackgroundColor3=UI_Colors.generic_gray;w_TopbarPin.Text=""w_TopbarPin.Parent=w_Topbar;w_TopbarPinImage=Instance.new("ImageLabel")w_TopbarPinImage.Image=UI_Icons.pin;w_TopbarPinImage.ZIndex=(W_Index+2)w_TopbarPinImage.Size=udim2_scale(0.65,0.65)w_TopbarPinImage.Position=udim2_scale(.5,.5)w_TopbarPinImage.AnchorPoint=vector2(.5,.5)w_TopbarPinImage.BackgroundTransparency=1;w_TopbarPinImage.ImageColor3=UI_Colors.generic_gray3;w_TopbarPinImage.ImageTransparency=0;w_TopbarPinImage.Parent=w_TopbarPin end;do w_Background=Instance.new("Frame")w_Background.BackgroundColor3=UI_Colors.window_background;w_Background.Size=udim2_new(1,0,1,-32)w_Background.Position=udim2_offset(0,32)w_Background.BorderSizePixel=0;w_Background.ZIndex=(W_Index+1)w_Background.Parent=w_RootFrame;w_ConsoleWindow=Instance.new("ScrollingFrame")w_ConsoleWindow.Size=udim2_new(1,-8,1,-44)w_ConsoleWindow.Position=udim2_offset(4,4)w_ConsoleWindow.ZIndex=W_Index+5;w_ConsoleWindow.BorderSizePixel=1;w_ConsoleWindow.CanvasSize=udim2_offset(0,0)w_ConsoleWindow.AutomaticCanvasSize=Enum.AutomaticSize.XY;w_ConsoleWindow.ScrollBarThickness=5;w_ConsoleWindow.ScrollBarImageColor3=UI_Colors.generic_gray;w_ConsoleWindow.BorderColor3=UI_Colors.window_outline;w_ConsoleWindow.BackgroundColor3=UI_Colors.window_darkoutline;w_ConsoleWindow.BackgroundTransparency=0;w_ConsoleWindow.Visible=true;w_ConsoleWindow.Parent=w_Background;w_ConsoleWindowLayout=Instance.new("UIListLayout")w_ConsoleWindowLayout.FillDirection=Enum.FillDirection.Vertical;w_ConsoleWindowLayout.Parent=w_ConsoleWindow end;do w_InputBox=Instance.new("TextBox")w_InputBox.AnchorPoint=vector2(0,1)w_InputBox.Size=udim2_new(0.4,0,0,30)w_InputBox.Position=udim2_new(0,4,1,-4)w_InputBox.ZIndex=W_Index+5;w_InputBox.BorderSizePixel=1;w_InputBox.BorderColor3=UI_Colors.window_outline;w_InputBox.BackgroundColor3=UI_Colors.window_darkoutline;w_InputBox.BackgroundTransparency=0;w_InputBox.Visible=true;w_InputBox.TextTruncate=Enum.TextTruncate.AtEnd;w_InputBox.TextXAlignment=Enum.TextXAlignment.Left;w_InputBox.TextYAlignment=Enum.TextYAlignment.Center;w_InputBox.TextSize=19;w_InputBox.Text=""w_InputBox.Font=Enum.Font.SourceSans;w_InputBox.TextColor3=UI_Colors.generic_text;w_InputBox.Parent=w_Background;w_InputBoxPadding=Instance.new("UIPadding")w_InputBoxPadding.PaddingLeft=UDim.new(0,4)w_InputBoxPadding.Parent=w_InputBox;w_ClearConsoleButton=Instance.new("TextButton")w_ClearConsoleButton.AnchorPoint=vector2(0,1)w_ClearConsoleButton.AutoButtonColor=true;w_ClearConsoleButton.Size=udim2_offset(50,30)w_ClearConsoleButton.Position=udim2_new(0.4,10,1,-4)w_ClearConsoleButton.BorderSizePixel=1;w_ClearConsoleButton.BorderColor3=UI_Colors.window_outline;w_ClearConsoleButton.BackgroundColor3=UI_Colors.window_darkoutline;w_ClearConsoleButton.TextXAlignment=Enum.TextXAlignment.Center;w_ClearConsoleButton.TextYAlignment=Enum.TextYAlignment.Center;w_ClearConsoleButton.TextSize=19;w_ClearConsoleButton.Text="Clear"w_ClearConsoleButton.Font=Enum.Font.SourceSans;w_ClearConsoleButton.TextColor3=UI_Colors.generic_text;w_ClearConsoleButton.ZIndex=W_Index+5;w_ClearConsoleButton.Parent=w_Background;w_AutoScrollButton=Instance.new("TextButton")w_AutoScrollButton.AnchorPoint=vector2(1,1)w_AutoScrollButton.AutoButtonColor=false;w_AutoScrollButton.Size=udim2_offset(30,30)w_AutoScrollButton.Position=udim2_new(1,-4,1,-4)w_AutoScrollButton.BorderSizePixel=1;w_AutoScrollButton.BorderColor3=UI_Colors.window_outline;w_AutoScrollButton.BackgroundColor3=UI_Colors.window_darkoutline;w_AutoScrollButton.Text=""w_AutoScrollButton.ZIndex=W_Index+5;w_AutoScrollButton.Parent=w_Background;w_AutoScrollText=Instance.new("TextLabel")w_AutoScrollText.AnchorPoint=vector2(1,1)w_AutoScrollText.Size=udim2_offset(100,30)w_AutoScrollText.Position=udim2_new(1,-38,1,-4)w_AutoScrollText.BackgroundTransparency=1;w_AutoScrollText.TextXAlignment=Enum.TextXAlignment.Center;w_AutoScrollText.TextYAlignment=Enum.TextYAlignment.Center;w_AutoScrollText.TextSize=19;w_AutoScrollText.Text="Auto-scroll"w_AutoScrollText.Font=Enum.Font.SourceSans;w_AutoScrollText.TextColor3=UI_Colors.generic_text;w_AutoScrollText.ZIndex=W_Index+5;w_AutoScrollText.Parent=w_Background;w_AutoScrollButtonHighlight=Instance.new("Frame")w_AutoScrollButtonHighlight.Size=udim2_new(0.8,0,0.8,0)w_AutoScrollButtonHighlight.Position=udim2_scale(.1,.1)w_AutoScrollButtonHighlight.BackgroundColor3=UI_Colors.generic_disabled;w_AutoScrollButtonHighlight.BorderSizePixel=0;w_AutoScrollButtonHighlight.BackgroundTransparency=0.2;w_AutoScrollButtonHighlight.ZIndex=W_Index+6;w_AutoScrollButtonHighlight.Parent=w_AutoScrollButton end;do w_ResizeRight=Instance.new("Frame")w_ResizeRight.Size=udim2_new(0,8,1,0)w_ResizeRight.BackgroundTransparency=1;w_ResizeRight.Position=udim2_new(1,0,0,0)w_ResizeRight.ZIndex=999;w_ResizeRight.BorderSizePixel=0;w_ResizeRight.Parent=w_RootFrame;w_ResizeDown=Instance.new("Frame")w_ResizeDown.Size=udim2_new(1,0,0,8)w_ResizeDown.BackgroundTransparency=1;w_ResizeDown.Position=udim2_new(0,0,1,0)w_ResizeDown.ZIndex=999;w_ResizeDown.BorderSizePixel=0;w_ResizeDown.Parent=w_RootFrame;w_ResizeCorner=Instance.new("Frame")w_ResizeCorner.Size=udim2_new(0,8,0,8)w_ResizeCorner.BackgroundTransparency=1;w_ResizeCorner.Position=udim2_new(1,0,1,0)w_ResizeCorner.ZIndex=999;w_ResizeCorner.BorderSizePixel=0;w_ResizeCorner.Parent=w_RootFrame end;do shadow(w_RootFrame)UI_DragModifier(w_Topbar,w_RootFrame)UI_RoundModifier(w_TopbarPin)UI_ButtonEffect(w_TopbarPin,w_TopbarPinImage)delay(0.4,function()if(WindowResizable==true)then if(w_RootFrame.Size.X.Offset<W_SizeMin.X)then w_RootFrame.Size=udim2_offset(W_SizeMin.X,w_RootFrame.Size.Y.Offset)end;if(w_RootFrame.Size.Y.Offset<W_SizeMin.Y)then w_RootFrame.Size=udim2_offset(w_RootFrame.Size.X.Offset,W_SizeMin.Y)end;UI_ResizeModifier(w_ResizeRight,w_RootFrame,1,W_SizeMin,W_SizeMax)UI_ResizeModifier(w_ResizeDown,w_RootFrame,2,W_SizeMin,W_SizeMax)UI_ResizeModifier(w_ResizeCorner,w_RootFrame,3,W_SizeMin,W_SizeMax)else W_SizeMax=nil;W_SizeMin=nil end end)end;do w_TopbarPin.MouseButton1Click:Connect(function()W_IsPinned=not W_IsPinned;if(W_IsPinned)then w_RootFrame.Parent=screen;w_TopbarPinImage.Image=UI_Icons.pinned else w_RootFrame.Parent=UIOBJ_WindowFrame;w_TopbarPinImage.Image=UI_Icons.pin end end)w_AutoScrollButton.MouseButton1Click:Connect(function()W_AutoScrollEnabled=not W_AutoScrollEnabled;if(W_AutoScrollEnabled)then twn(w_AutoScrollButtonHighlight,{BackgroundColor3=UI_Colors.generic_enabled},.25)else twn(w_AutoScrollButtonHighlight,{BackgroundColor3=UI_Colors.generic_disabled},.25)end end)w_ClearConsoleButton.MouseButton1Click:Connect(function()w_ConsoleWindowLayout.Parent=nil;for i,v in ipairs(w_ConsoleWindow:GetChildren())do v:Destroy()end;w_ConsoleWindowLayout.Parent=w_ConsoleWindow end)if(WindowResizable==true)then local resizetype=0;w_ResizeDown.MouseEnter:Connect(function()resizetype=1;uis.MouseIconEnabled=false;UIOBJ_ResizeMouse.ImageTransparency=0;twn(UIOBJ_ResizeMouse,{Rotation=90},.25)end)w_ResizeDown.MouseLeave:Connect(function()wait(0.2)if(resizetype==1)then uis.MouseIconEnabled=true;UIOBJ_ResizeMouse.ImageTransparency=1 end end)w_ResizeRight.MouseEnter:Connect(function()resizetype=2;uis.MouseIconEnabled=false;UIOBJ_ResizeMouse.ImageTransparency=0;twn(UIOBJ_ResizeMouse,{Rotation=0},.25)end)w_ResizeRight.MouseLeave:Connect(function()wait(0.2)if(resizetype==2)then uis.MouseIconEnabled=true;UIOBJ_ResizeMouse.ImageTransparency=1 end end)w_ResizeCorner.MouseEnter:Connect(function()resizetype=3;uis.MouseIconEnabled=false;UIOBJ_ResizeMouse.ImageTransparency=0;twn(UIOBJ_ResizeMouse,{Rotation=45},.25)end)w_ResizeCorner.MouseLeave:Connect(function()wait(0.2)if(resizetype==3)then uis.MouseIconEnabled=true;UIOBJ_ResizeMouse.ImageTransparency=1 end end)else w_ResizeCorner:Destroy()w_ResizeRight:Destroy()w_ResizeDown:Destroy()end end;local w_ConsoleItem=Instance.new("TextLabel")w_ConsoleItem.TextXAlignment=Enum.TextXAlignment.Left;w_ConsoleItem.TextYAlignment=Enum.TextYAlignment.Center;w_ConsoleItem.TextSize=19;w_ConsoleItem.BackgroundTransparency=1;w_ConsoleItem.Text=""w_ConsoleItem.Font=Enum.Font.SourceSans;w_ConsoleItem.Size=udim2_new(1,0,0,25)w_ConsoleItem.TextColor3=UI_Colors.generic_text;w_ConsoleItem.ZIndex=W_Index+5;local w_ConsoleItemPadding=Instance.new("UIPadding")w_ConsoleItemPadding.PaddingLeft=UDim.new(0,4)w_ConsoleItemPadding.Parent=w_ConsoleItem;local w_Object={}do function w_Object:MsgOut(msg,color_r,color_g,color_b)local label=w_ConsoleItem:Clone()label.Text=msg;label.TextColor3=color_rgb(color_r or 255,color_g or 255,color_b or 255)label.Parent=w_ConsoleWindow;if(W_AutoScrollEnabled)then w_ConsoleWindow.CanvasPosition=vector2(0,9e9)end end;w_Object.Width=w_RootFrame.Size.X.Offset;w_Object.Height=w_RootFrame.Size.Y.Offset end;w_InputBox.FocusLost:Connect(function(bool)if(not bool)then return end;local text=w_InputBox.Text;w_Object:MsgOut("> "..text,128,128,128)local func,msg=loadstring(text)if(not func)then w_Object:MsgOut(msg,255,255,0)else local success,msg=pcall(func)if(not success)then w_Object:MsgOut(msg,255,0,0)end end;w_InputBox.Text=''end)insert(UI_Objects.windows,w_Object)return w_Object end;UIOBJ_FadeFrame=Instance.new("Frame")UIOBJ_FadeFrame.BackgroundTransparency=1;UIOBJ_FadeFrame.ZIndex=0;UIOBJ_FadeFrame.BackgroundColor3=UI_Colors.generic_dark;UIOBJ_FadeFrame.Size=udim2_scale(1,1)UIOBJ_FadeFrame.Visible=false;UIOBJ_FadeFrame.Parent=screen;UIOBJ_ResizeMouse=Instance.new("ImageLabel")UIOBJ_ResizeMouse.BackgroundTransparency=1;UIOBJ_ResizeMouse.ZIndex=999;UIOBJ_ResizeMouse.AnchorPoint=vector2(0.5,0.5)UIOBJ_ResizeMouse.BackgroundColor3=UI_Colors.generic_white;UIOBJ_ResizeMouse.Size=udim2_offset(28,28)UIOBJ_ResizeMouse.Image=UI_Icons.resize;UIOBJ_ResizeMouse.Visible=true;UIOBJ_ResizeMouse.ImageTransparency=1;UIOBJ_ResizeMouse.Parent=screen;UIOBJ_WindowFrame=Instance.new("Frame")UIOBJ_WindowFrame.Size=udim2_scale(1,1)UIOBJ_WindowFrame.BackgroundTransparency=1;UIOBJ_WindowFrame.ZIndex=0;UIOBJ_WindowFrame.Parent=UIOBJ_FadeFrame;UI_Objects.blur=Instance.new("BlurEffect")UI_Objects.blur.Size=0;UI_Objects.blur.Enabled=false;UI_Objects.blur.Parent=game.Lighting;ui.id=getrand(8)end;local window1=ui:NewWindow("Internal Console - Exploit",475,350)local window2=ui:NewWindow("Internal Console - Roblox",475,350)getgenv().error=newcclosure(function()window1:MsgOut(debug.traceback(2),255,0,0)end)getgenv().warn=newcclosure(function(...)window1:MsgOut(table.concat({...},"   "),255,255,0)end)getgenv().print=newcclosure(function(...)window1:MsgOut(table.concat({...},"   "),255,255,255)end)getgenv().printconsole=newcclosure(function(msg,r,g,b)if(type(msg))=="string"then window1:MsgOut(msg,r or 255,g or 255,b or 255)else error("expected string as argument #1")end end)game:GetService("LogService").MessageOut:Connect(function(msg,type)if(type==0 or type==1)then window2:MsgOut(msg,255,255,255)elseif(type==2)then window2:MsgOut(msg,255,255,0)elseif(type==3)then window2:MsgOut(msg,255,0,0)end end)window1:MsgOut("Logs exploit functions like print, warn, etc.")window1:MsgOut("Script errors won't appear in this console!")window2:MsgOut("Logs roblox related messages with LogService")window2:MsgOut("This includes script errors, warnings, and messages from the game")window2:MsgOut("and most executors")window1:MsgOut("Made by topit",120,60,255)window2:MsgOut("Made by topit",120,60,255)ui:Ready()
