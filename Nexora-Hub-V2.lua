-- LunarLibrary.lua | Biblioteca NOVA e independente para Lunar Hub
-- Não altera nem depende da biblioteca embutida em gg.lua.
-- API compatível: CreateMain, CreatePage, CreateSection, CreateToggle,
-- CreateButton, CreateDropdown, CreateSlider, CreateLabel e CreateNoti.

local Lunar = { Options = {}, OptionOrder = {} }
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local parent = (gethui and gethui()) or game:GetService("CoreGui")
local player = Players.LocalPlayer
local COLORS = {
    bg = Color3.fromRGB(12, 12, 15), panel = Color3.fromRGB(24, 24, 28),
    panel2 = Color3.fromRGB(32, 32, 37), line = Color3.fromRGB(0, 190, 200),
    accent = Color3.fromRGB(0, 210, 218), text = Color3.fromRGB(245, 245, 248),
    muted = Color3.fromRGB(155, 158, 166), on = Color3.fromRGB(0, 190, 200)
}
local function create(class, props, p)
    local o = Instance.new(class)
    for k,v in pairs(props or {}) do o[k] = v end
    o.Parent = p
    return o
end
local function round(o, radius)
    create("UICorner", {CornerRadius=UDim.new(0, radius or 8)}, o)
end
local function outline(o, color, transparency)
    return create("UIStroke", {Color=color or COLORS.line, Thickness=1, Transparency=transparency or .55}, o)
end
local function tween(o, time, props, style)
    local t = TweenService:Create(o, TweenInfo.new(time or .18, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props)
    t:Play(); return t
end
local function text(parentObj, value, size, color, bold)
    return create("TextLabel", {BackgroundTransparency=1, Text=tostring(value or ""), TextSize=size or 12,
        TextColor3=color or COLORS.text, Font=bold and Enum.Font.GothamBold or Enum.Font.Gotham,
        TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Center,
        TextTruncate=Enum.TextTruncate.AtEnd, Size=UDim2.new(1,0,1,0)}, parentObj)
end
local function register(title, kind, value, callback, page, section)
    local opt = {Title=title, type=kind, value=value, Callback=callback, Page=page, Section=section}
    function opt:SetValue(v)
        self.value = v
        if self._setValue then self._setValue(v) end
        if self.Callback then task.spawn(function() pcall(self.Callback, v) end) end
    end
    Lunar.Options[title] = opt; table.insert(Lunar.OptionOrder, opt)
    return opt
end

function Lunar.CreateMain(config)
    config = config or {}
    local old = parent:FindFirstChild("LunarLibraryUI")
    if old then old:Destroy() end
    local gui = create("ScreenGui", {Name="LunarLibraryUI", ResetOnSpawn=false, IgnoreGuiInset=true, ZIndexBehavior=Enum.ZIndexBehavior.Sibling}, parent)
    local shell = create("Frame", {Name="Window", AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.5), Size=UDim2.new(.88,0,.78,0), BackgroundColor3=COLORS.bg, BackgroundTransparency=.06, BorderSizePixel=0}, gui)
    shell.Size = UDim2.new(0, math.clamp((workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.X or 800)*.88, 340, 850), 0, math.clamp((workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize.Y or 600)*.78, 300, 620))
    round(shell, 18); outline(shell, Color3.fromRGB(110,115,125), .55)
    create("UIGradient", {Rotation=135, Color=ColorSequence.new(COLORS.bg, Color3.fromRGB(27,27,32))}, shell)
    local header = create("Frame", {Name="Header", Size=UDim2.new(1,0,0,76), BackgroundColor3=Color3.fromRGB(19,19,23), BackgroundTransparency=.1, BorderSizePixel=0}, shell)
    round(header, 18)
    create("Frame", {Position=UDim2.new(0,0,1,-1), Size=UDim2.new(1,0,0,1), BackgroundColor3=COLORS.line, BackgroundTransparency=.35, BorderSizePixel=0}, header)
    local title = create("TextLabel", {Position=UDim2.new(0,20,0,10), Size=UDim2.new(1,-115,0,28), BackgroundTransparency=1, Text=config.Title or "Lunar Hub | Blox Fruits", TextColor3=COLORS.text, Font=Enum.Font.GothamBold, TextSize=18, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd}, header)
    local desc = create("TextLabel", {Position=UDim2.new(0,20,0,39), Size=UDim2.new(1,-115,0,20), BackgroundTransparency=1, Text=config.Desc or "Biblioteca independente", TextColor3=COLORS.muted, Font=Enum.Font.Gotham, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd}, header)
    local close = create("TextButton", {AnchorPoint=Vector2.new(1,.5), Position=UDim2.new(1,-14,.5,0), Size=UDim2.fromOffset(34,34), BackgroundColor3=COLORS.panel2, Text="×", TextColor3=COLORS.muted, Font=Enum.Font.Gotham, TextSize=24, AutoButtonColor=false, BorderSizePixel=0}, header)
    round(close, 10); close.MouseButton1Click:Connect(function() tween(shell,.18,{BackgroundTransparency=1}); task.delay(.2,function() if gui then gui:Destroy() end end) end)
    local nav = create("ScrollingFrame", {Name="Navigation", Position=UDim2.new(0,12,0,88), Size=UDim2.new(0,145,1,-100), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, ScrollBarImageColor3=COLORS.line, CanvasSize=UDim2.new()}, shell)
    local navLayout = create("UIListLayout", {Padding=UDim.new(0,5), SortOrder=Enum.SortOrder.LayoutOrder}, nav)
    navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() nav.CanvasSize=UDim2.new(0,0,0,navLayout.AbsoluteContentSize.Y+8) end)
    local content = create("Frame", {Name="Content", Position=UDim2.new(0,168,0,88), Size=UDim2.new(1,-180,1,-100), BackgroundTransparency=1, BorderSizePixel=0}, shell)
    local pages, activePage, pageCount = {}, nil, 0
    local Main = {Gui=gui, Window=shell}
    local function showPage(p)
        activePage=p
        for _,item in ipairs(pages) do item.frame.Visible = item==p end
        for _,item in ipairs(pages) do
            tween(item.button,.16,{BackgroundTransparency=item==p and .12 or 1, TextColor3=item==p and COLORS.accent or COLORS.muted})
        end
    end
    function Main.CreatePage(cfg)
        cfg=cfg or {}; pageCount=pageCount+1
        local name=cfg.Page_Name or cfg.Page_Title or ("Page "..pageCount)
        local pageFrame=create("ScrollingFrame", {Name=name, Size=UDim2.fromScale(1,1), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3, ScrollBarImageColor3=COLORS.line, CanvasSize=UDim2.new()}, content)
        pageFrame.Visible=false
        local pad=create("UIPadding", {PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,10),PaddingLeft=UDim.new(0,4),PaddingRight=UDim.new(0,5)}, pageFrame)
        local layout=create("UIListLayout", {Padding=UDim.new(0,9),SortOrder=Enum.SortOrder.LayoutOrder}, pageFrame)
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() pageFrame.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+16) end)
        local b=create("TextButton", {Size=UDim2.new(1,0,0,38), BackgroundColor3=COLORS.panel2, BackgroundTransparency=1, BorderSizePixel=0, Text="   "..(cfg.Page_Title or name), TextColor3=COLORS.muted, Font=Enum.Font.GothamMedium, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, AutoButtonColor=false, LayoutOrder=pageCount}, nav)
        round(b,8)
        local p={name=name,frame=pageFrame,button=b}; table.insert(pages,p)
        b.MouseButton1Click:Connect(function() showPage(p) end)
        local Page={Frame=pageFrame}
        function Page.CreateSection(sectionName)
            local card=create("Frame", {Name=tostring(sectionName), Size=UDim2.new(1,0,0,40), AutomaticSize=Enum.AutomaticSize.Y, BackgroundColor3=COLORS.panel, BackgroundTransparency=.06, BorderSizePixel=0}, pageFrame)
            round(card,11); outline(card,COLORS.line,.72)
            create("UIPadding", {PaddingTop=UDim.new(0,10),PaddingBottom=UDim.new(0,10),PaddingLeft=UDim.new(0,11),PaddingRight=UDim.new(0,11)},card)
            local list=create("UIListLayout", {Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder},card)
            local head=create("TextLabel", {Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text=tostring(sectionName),TextColor3=COLORS.text,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},card)
            local accent=create("Frame", {Position=UDim2.new(0,-11,.5,-7),Size=UDim2.new(0,3,0,14),BackgroundColor3=COLORS.accent,BorderSizePixel=0},head); round(accent,3)
            local Section={}
            local function row(h)
                return create("Frame", {Size=UDim2.new(1,0,0,h),BackgroundTransparency=1},card)
            end
            function Section.CreateToggle(c, callback)
                c=c or {}; local name=c.Title or "Toggle"; local value=c.Default==true
                local r=row(34); local label=text(create("Frame",{Size=UDim2.new(1,-65,1,0),BackgroundTransparency=1},r),name,12,COLORS.text,false)
                local track=create("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,0,.5,0),Size=UDim2.fromOffset(43,24),BackgroundColor3=value and COLORS.on or COLORS.panel2,Text="",AutoButtonColor=false,BorderSizePixel=0},r); round(track,12); outline(track,COLORS.line,.55)
                local knob=create("Frame",{Position=value and UDim2.new(1,-21,.5,-8) or UDim2.new(0,4,.5,-8),Size=UDim2.fromOffset(16,16),BackgroundColor3=Color3.fromRGB(245,245,245),BorderSizePixel=0},track); round(knob,9)
                local opt=register(name,"toggle",value,callback,name,sectionName)
                local function set(v, fire) value=not not v; opt.value=value; tween(track,.15,{BackgroundColor3=value and COLORS.on or COLORS.panel2}); tween(knob,.15,{Position=value and UDim2.new(1,-21,.5,-8) or UDim2.new(0,4,.5,-8)}); if fire and callback then task.spawn(function() pcall(callback,value) end) end end
                opt._setValue=function(v) set(v,false) end; track.MouseButton1Click:Connect(function() set(not value,true) end)
                return opt
            end
            function Section.CreateButton(c, callback)
                c=c or {}; local name=c.Title or "Button"; local b=create("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=COLORS.panel2,Text=name,TextColor3=COLORS.accent,Font=Enum.Font.GothamBold,TextSize=12,AutoButtonColor=false,BorderSizePixel=0},card); round(b,8); outline(b,COLORS.line,.72); b.MouseButton1Click:Connect(function() tween(b,.1,{BackgroundColor3=COLORS.panel}); if callback then task.spawn(function() pcall(callback) end) end end); register(name,"button",false,callback,name,sectionName); return b
            end
            function Section.CreateLabel(c)
                local name=type(c)=="table" and (c.Title or c.Text or "") or tostring(c or "")
                local r=row(25); local lbl=text(r,name,11,COLORS.muted,false); local handle={Object=lbl}
                function handle.SetText(v) lbl.Text=tostring(v or "") end; function handle.GetText() return lbl.Text end
                return handle
            end
            function Section.CreateSlider(c, callback)
                c=c or {}; local name=c.Title or "Slider"; local min=c.Min or c.MinValue or 0; local max=c.Max or c.MaxValue or 100; local value=math.clamp(tonumber(c.Default or c.Value) or min,min,max)
                local r=row(52); text(create("Frame",{Size=UDim2.new(1,-65,0,20),BackgroundTransparency=1},r),name,11,COLORS.text,false)
                local number=create("TextLabel",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.fromOffset(60,20),BackgroundTransparency=1,Text=tostring(value),TextColor3=COLORS.accent,Font=Enum.Font.GothamBold,TextSize=11,TextXAlignment=Enum.TextXAlignment.Right},r)
                local bar=create("Frame",{Position=UDim2.new(0,0,0,31),Size=UDim2.new(1,0,0,5),BackgroundColor3=COLORS.panel2,BorderSizePixel=0},r); round(bar,4)
                local ratio=(value-min)/math.max(1,max-min); local fill=create("Frame",{Size=UDim2.new(ratio,0,1,0),BackgroundColor3=COLORS.accent,BorderSizePixel=0},bar); round(fill,4)
                local hit=create("TextButton",{Position=UDim2.new(0,0,0,-9),Size=UDim2.new(1,0,0,23),BackgroundTransparency=1,Text="",AutoButtonColor=false},bar)
                local opt=register(name,"slider",value,callback,name,sectionName)
                local function set(x,fire) local q=math.clamp((x-bar.AbsolutePosition.X)/math.max(1,bar.AbsoluteSize.X),0,1); value=math.floor(min+(max-min)*q); ratio=(value-min)/math.max(1,max-min); fill.Size=UDim2.new(ratio,0,1,0); number.Text=tostring(value); opt.value=value; if fire and callback then pcall(callback,value) end end
                hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then set(i.Position.X,true) end end)
                hit.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch then set(i.Position.X,true) end end)
                opt._setValue=function(v) value=math.clamp(tonumber(v) or min,min,max); ratio=(value-min)/math.max(1,max-min); fill.Size=UDim2.new(ratio,0,1,0); number.Text=tostring(value); opt.value=value end
                return opt
            end
            function Section.CreateDropdown(c, callback)
                c=c or {}; local name=c.Title or "Dropdown"; local values=c.List or c.Values or c.Options or {}; local multi=c.Selected==true; local selected=c.Default or (multi and {} or "Select...")
                local b=create("TextButton",{Size=UDim2.new(1,0,0,34),BackgroundColor3=COLORS.panel2,Text="  "..name.."  ▾",TextColor3=COLORS.text,Font=Enum.Font.Gotham,TextSize=11,TextXAlignment=Enum.TextXAlignment.Left,AutoButtonColor=false,BorderSizePixel=0},card); round(b,8); outline(b,COLORS.line,.78)
                local opt=register(name,"dropdown",selected,callback,name,sectionName)
                local function refresh() b.Text="  "..name.."  ·  "..tostring(type(selected)=="table" and "Selected" or selected).."  ▾"; opt.value=selected end; refresh()
                b.MouseButton1Click:Connect(function()
                    local overlay=gui:FindFirstChild("LunarDropdown") if overlay then overlay:Destroy() end
                    local menu=create("ScrollingFrame",{Name="LunarDropdown",Position=UDim2.fromOffset(b.AbsolutePosition.X,b.AbsolutePosition.Y+b.AbsoluteSize.Y+3),Size=UDim2.fromOffset(math.max(170,b.AbsoluteSize.X),math.min(180,math.max(35,#values*30+8))),BackgroundColor3=COLORS.panel,BorderSizePixel=0,ScrollBarThickness=3,ScrollBarImageColor3=COLORS.line,CanvasSize=UDim2.new(0,0,0,0),ZIndex=50},gui); round(menu,8); outline(menu,COLORS.line,.3)
                    local lay=create("UIListLayout",{Padding=UDim.new(0,3)},menu); lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() menu.CanvasSize=UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+8) end)
                    for idx,v in ipairs(values) do local item=create("TextButton",{Size=UDim2.new(1,-8,0,27),BackgroundColor3=COLORS.panel2,Text=tostring(v),TextColor3=COLORS.text,Font=Enum.Font.Gotham,TextSize=11,AutoButtonColor=false,LayoutOrder=idx,BorderSizePixel=0,ZIndex=51},menu); round(item,6); item.MouseButton1Click:Connect(function() if multi then if type(selected)~="table" then selected={} end; selected[v]=not selected[v] else selected=v; menu:Destroy() end; refresh(); if callback then task.spawn(function() pcall(callback,selected) end) end end) end
                end)
                opt._setValue=function(v) selected=v; refresh() end
                opt.GetNewList=function(_,newList) values=newList or {}; refresh() end; opt.SetList=opt.GetNewList
                return opt
            end
            return Section
        end
        return Page
    end
    function Main.CreateNoti(c, duration)
        c=c or {}; local toast=create("Frame",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,20,0,90),Size=UDim2.fromOffset(245,66),BackgroundColor3=COLORS.panel,BackgroundTransparency=.04,BorderSizePixel=0},gui); round(toast,10); outline(toast,COLORS.line,.35)
        create("TextLabel",{Position=UDim2.new(0,12,0,7),Size=UDim2.new(1,-24,0,21),BackgroundTransparency=1,Text=c.Title or "Lunar Hub",TextColor3=COLORS.accent,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},toast)
        create("TextLabel",{Position=UDim2.new(0,12,0,29),Size=UDim2.new(1,-24,0,28),BackgroundTransparency=1,Text=c.Desc or c.Description or "",TextColor3=COLORS.text,Font=Enum.Font.Gotham,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},toast)
        tween(toast,.2,{Position=UDim2.new(1,-12,0,90)}); task.delay(duration or c.ShowTime or 4,function() if toast and toast.Parent then tween(toast,.2,{Position=UDim2.new(1,260,0,90)}); task.delay(.25,function() if toast then toast:Destroy() end end) end end); return toast
    end
    gui.Destroying:Connect(function() end)
    -- Botão flutuante para abrir/fechar a janela, separado do cabeçalho.
    local floating=create("TextButton",{Name="LunarFloat",AnchorPoint=Vector2.new(0,0),Position=UDim2.new(0,16,0.42,0),Size=UDim2.fromOffset(46,46),BackgroundColor3=COLORS.panel,Text="L",TextColor3=COLORS.accent,Font=Enum.Font.GothamBlack,TextSize=22,AutoButtonColor=false,BorderSizePixel=0,ZIndex=20},gui); round(floating,23); outline(floating,COLORS.line,.15)
    local dragging, dragStart, startPos
    floating.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true; dragStart=i.Position; startPos=floating.Position end end)
    UIS.InputChanged:Connect(function(i) if dragging and (i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseMovement) then local d=i.Position-dragStart; floating.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.Touch or i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    floating.MouseButton1Click:Connect(function() shell.Visible=not shell.Visible end)
    function Main.Destroy() if gui then gui:Destroy() end end
    function Main.SetTitle(v) title.Text=tostring(v) end
    function Main.SetDesc(v) desc.Text=tostring(v) end
    if #pages==0 then end
    task.defer(function() tween(shell,.25,{BackgroundTransparency=.06}) end)
    return Main
end

function Lunar.CreateNoti(config, duration)
    local mainGui=parent:FindFirstChild("LunarLibraryUI")
    if not mainGui then return end
    local holder=mainGui:FindFirstChild("Window")
    if not holder then return end
    local c=config or {}; local toast=create("Frame",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,20,0,90),Size=UDim2.fromOffset(245,66),BackgroundColor3=COLORS.panel,BorderSizePixel=0},mainGui); round(toast,10); outline(toast,COLORS.line,.35)
    create("TextLabel",{Position=UDim2.new(0,12,0,7),Size=UDim2.new(1,-24,0,21),BackgroundTransparency=1,Text=c.Title or "Lunar Hub",TextColor3=COLORS.accent,Font=Enum.Font.GothamBold,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},toast)
    create("TextLabel",{Position=UDim2.new(0,12,0,29),Size=UDim2.new(1,-24,0,28),BackgroundTransparency=1,Text=c.Desc or "",TextColor3=COLORS.text,Font=Enum.Font.Gotham,TextSize=11,TextWrapped=true,TextXAlignment=Enum.TextXAlignment.Left},toast)
    tween(toast,.2,{Position=UDim2.new(1,-12,0,90)}); task.delay(duration or c.ShowTime or 4,function() if toast and toast.Parent then toast:Destroy() end end); return toast
end
function Lunar.RestoreSavedToggles() end
return Lunar
