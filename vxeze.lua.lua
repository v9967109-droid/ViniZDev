
--[[
    Vxeze Hub UI Library - New Library
    Recreated from Vxeze Hub interface (file7073221245296215401.txt)
    Original had: VxezeUI.Library.Theme.Accent, FloatingButton Ring 46x46, Window:ToggleVisibility, Tabs with AddSubTab Lucide icons
    This is a clean implementation - no Nexora library, only Vxeze style
]]

local VxezeUI = {}
VxezeUI.__index = VxezeUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Vxeze theme (dark with blue/purple accent like original Vxeze)
local ACCENT = Color3.fromRGB(120, 80, 255) -- Vxeze purple/blue accent
local ACCENT_DARK = Color3.fromRGB(80, 50, 180)
local BG = Color3.fromRGB(15, 15, 20)
local BG_DARK = Color3.fromRGB(10, 10, 15)
local PANEL = Color3.fromRGB(22, 22, 30)
local PANEL_2 = Color3.fromRGB(30, 30, 40)
local TEXT = Color3.fromRGB(240, 240, 250)
local MUTED = Color3.fromRGB(150, 150, 165)
local BORDER = Color3.fromRGB(45, 45, 60)

VxezeUI.Library = {}
VxezeUI.Library.Theme = { Accent = ACCENT }
VxezeUI.Library.ThemeChanged = { Connect = function() return { Disconnect = function() end } end }
VxezeUI.Tabs = {}
VxezeUI.Pages = {}
VxezeUI.Panes = {}
VxezeUI.Toggles = {}
VxezeUI.SectionRoutes = {}
VxezeUI.ConfirmButtons = {}
VxezeUI.ElementCount = 0

local function make(className, props, parent)
    local obj = Instance.new(className)
    for k, v in pairs(props or {}) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function corner(parent, radius)
    return make("UICorner", { CornerRadius = UDim.new(0, radius or 8) }, parent)
end

local function stroke(parent, color, thickness, transparency)
    return make("UIStroke", { Color = color or BORDER, Thickness = thickness or 1, Transparency = transparency or 0 }, parent)
end

local function tween(obj, info, props)
    local ok, result = pcall(function()
        local t = TweenService:Create(obj, info, props)
        t:Play()
        return t
    end)
    return ok and result or nil
end

local function addDrag(target, dragHandle)
    local dragging, dragStart, startPos = false, nil, nil
    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
        end
    end)
    dragHandle.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function VxezeUI:CreateWindow(options)
    options = options or {}
    local titleText = options.Title or "Vxeze Hub"
    local guiParent
    
    local ok, hui = pcall(function()
        if typeof(gethui) == "function" then return gethui() end
        return nil
    end)
    
    if ok and hui then
        guiParent = hui
    else
        local playerGui = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
        guiParent = playerGui
    end
    
    -- Remove old UIs
    pcall(function()
        local old = guiParent:FindFirstChild("VxezeHubUI")
        if old then old:Destroy() end
        local old2 = guiParent:FindFirstChild("Vxeze Hub Button")
        if old2 then old2:Destroy() end
        local old3 = guiParent:FindFirstChild("NexoraUI")
        if old3 then old3:Destroy() end
        local old4 = guiParent:FindFirstChild("LunarHubUI")
        if old4 then old4:Destroy() end
    end)
    
    local screen = make("ScreenGui", {
        Name = "VxezeHubUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
    }, guiParent)
    
    VxezeUI.Library._Root = screen
    
    local window = make("Frame", {
        Name = "MainWindow",
        Size = UDim2.fromOffset(650, 460),
        Position = UDim2.new(0.5, -325, 0.5, -230),
        BackgroundColor3 = BG,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, screen)
    corner(window, 12)
    stroke(window, BORDER, 1, 0.2)
    
    -- Topbar with Vxeze style
    local topbar = make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 45),
        BackgroundColor3 = BG_DARK,
        BorderSizePixel = 0,
    }, window)
    corner(topbar, 12)
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 12),
        Position = UDim2.new(0, 0, 1, -6),
        BackgroundColor3 = BG_DARK,
        BorderSizePixel = 0,
    }, topbar)
    
    local title = make("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -100, 1, 0),
        Position = UDim2.new(0, 15, 0, 0),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = TEXT,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, topbar)
    
    local closeBtn = make("TextButton", {
        Name = "Close",
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -35, 0, 7),
        BackgroundColor3 = PANEL,
        Text = "X",
        TextColor3 = MUTED,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, topbar)
    corner(closeBtn, 6)
    
    local minimizeBtn = make("TextButton", {
        Name = "Minimize",
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -70, 0, 7),
        BackgroundColor3 = PANEL,
        Text = "-",
        TextColor3 = MUTED,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
    }, topbar)
    corner(minimizeBtn, 6)
    
    -- Sidebar (Vxeze style with icons)
    local sidebar = make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 160, 1, -45),
        Position = UDim2.new(0, 0, 0, 45),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0,
    }, window)
    make("Frame", {
        Size = UDim2.new(0, 12, 1, 0),
        Position = UDim2.new(1, -6, 0, 0),
        BackgroundColor3 = PANEL,
        BorderSizePixel = 0,
    }, sidebar)
    
    local sidebarTitle = make("TextLabel", {
        Name = "SidebarTitle",
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = "VXEZE HUB",
        TextColor3 = ACCENT,
        TextSize = 13,
        Font = Enum.Font.GothamBlack,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, sidebar)
    
    local tabList = make("ScrollingFrame", {
        Name = "TabList",
        Position = UDim2.fromOffset(5, 40),
        Size = UDim2.new(1, -10, 1, -50),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = ACCENT,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    make("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, tabList)
    
    -- Content area
    local content = make("Frame", {
        Name = "Content",
        Position = UDim2.new(0, 160, 0, 45),
        Size = UDim2.new(1, -160, 1, -45),
        BackgroundColor3 = BG,
        BorderSizePixel = 0,
    }, window)
    
    local contentScroll = make("ScrollingFrame", {
        Name = "ContentScroll",
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = ACCENT,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, content)
    make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, contentScroll)
    
    -- Floating Button (Vxeze style Ring 46x46)
    local floatingScreen = make("ScreenGui", {
        Name = "Vxeze Hub Button",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        DisplayOrder = 1000,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    }, guiParent)
    
    local floatingFrame = make("Frame", {
        Name = "Ring",
        Size = UDim2.fromOffset(46, 46),
        Position = UDim2.fromOffset(40, 160),
        BackgroundColor3 = ACCENT,
        BorderSizePixel = 0,
    }, floatingScreen)
    corner(floatingFrame, 23)
    stroke(floatingFrame, ACCENT_DARK, 2, 0)
    
    local floatingIcon = make("TextButton", {
        Name = "Icon",
        Size = UDim2.new(1, -4, 1, -4),
        Position = UDim2.new(0, 2, 0, 2),
        BackgroundColor3 = BG_DARK,
        Text = "V",
        TextColor3 = TEXT,
        TextSize = 20,
        Font = Enum.Font.GothamBlack,
        BorderSizePixel = 0,
    }, floatingFrame)
    corner(floatingIcon, 21)
    
    VxezeUI.FloatingButton = { Gui = floatingScreen, Frame = floatingFrame, Icon = floatingIcon }
    VxezeUI.ButtonImage = floatingIcon
    
    local tabs = {}
    local currentTab = nil
    
    local function createTab(name, icon)
        local tabButton = make("TextButton", {
            Name = name,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = PANEL_2,
            Text = "  " .. (icon and (icon .. " ") or "") .. name,
            TextColor3 = MUTED,
            TextSize = 13,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
        }, tabList)
        corner(tabButton, 6)
        
        local tabContent = make("Frame", {
            Name = name .. "_Content",
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = false,
            AutomaticSize = Enum.AutomaticSize.Y,
        }, contentScroll)
        make("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, tabContent)
        
        local tabObj = {}
        VxezeUI.Tabs[name] = tabObj
        
        function tabObj:CreateSection(sectionName)
            local section = make("Frame", {
                Name = sectionName,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = PANEL,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
            }, tabContent)
            corner(section, 8)
            stroke(section, BORDER, 1, 0.3)
            
            local sectionTitle = make("TextLabel", {
                Size = UDim2.new(1, -10, 0, 25),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = TEXT,
                TextSize = 13,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, section)
            
            local sectionLayout = make("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }, section)
            
            local sectionPadding = make("UIPadding", {
                PaddingTop = UDim.new(0, 28),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
            }, section)
            
            local secObj = {}
            
            function secObj.CreateToggle(cfg, callback)
                cfg = cfg or {}
                local toggleName = cfg.Title or cfg.Text or "Toggle"
                local toggleFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 30),
                    BackgroundColor3 = PANEL_2,
                    BorderSizePixel = 0,
                }, section)
                corner(toggleFrame, 6)
                
                local toggleLabel = make("TextLabel", {
                    Size = UDim2.new(1, -50, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    Text = toggleName,
                    TextColor3 = TEXT,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, toggleFrame)
                
                local toggleBtn = make("Frame", {
                    Size = UDim2.fromOffset(36, 20),
                    Position = UDim2.new(1, -42, 0.5, -10),
                    BackgroundColor3 = Color3.fromRGB(50, 50, 60),
                    BorderSizePixel = 0,
                }, toggleFrame)
                corner(toggleBtn, 10)
                
                local toggleCircle = make("Frame", {
                    Size = UDim2.fromOffset(16, 16),
                    Position = UDim2.fromOffset(2, 2),
                    BackgroundColor3 = TEXT,
                    BorderSizePixel = 0,
                }, toggleBtn)
                corner(toggleCircle, 8)
                
                local enabled = cfg.Default == true
                local function updateToggle()
                    if enabled then
                        tween(toggleBtn, TweenInfo.new(0.2), { BackgroundColor3 = ACCENT })
                        tween(toggleCircle, TweenInfo.new(0.2), { Position = UDim2.fromOffset(18, 2) })
                    else
                        tween(toggleBtn, TweenInfo.new(0.2), { BackgroundColor3 = Color3.fromRGB(50, 50, 60) })
                        tween(toggleCircle, TweenInfo.new(0.2), { Position = UDim2.fromOffset(2, 2) })
                    end
                end
                updateToggle()
                
                local toggleButton = make("TextButton", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                }, toggleFrame)
                
                toggleButton.MouseButton1Click:Connect(function()
                    enabled = not enabled
                    updateToggle()
                    if callback then pcall(callback, enabled) end
                end)
                
                return { SetText = function() end }
            end
            
            function secObj.CreateButton(cfg, callback)
                cfg = cfg or {}
                local btn = make("TextButton", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = PANEL_2,
                    Text = cfg.Title or "Button",
                    TextColor3 = TEXT,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    BorderSizePixel = 0,
                }, section)
                corner(btn, 6)
                stroke(btn, BORDER, 1, 0.2)
                
                btn.MouseButton1Click:Connect(function()
                    if callback then pcall(callback) end
                end)
                
                return { SetText = function() end }
            end
            
            function secObj.CreateLabel(cfg)
                local text = type(cfg) == "table" and (cfg.Title or "") or tostring(cfg or "")
                local label = make("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = MUTED,
                    TextSize = 12,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, section)
                return { SetText = function(t) label.Text = t end }
            end
            
            secObj.CreateTextLabel = secObj.CreateLabel
            
            function secObj.CreateDropdown(cfg, cb)
                return secObj.CreateButton({ Title = cfg.Title or "Dropdown" }, function() if cb then pcall(cb, cfg.List and cfg.List[1] or "Option1") end end)
            end
            
            function secObj.CreateSlider(cfg, cb) 
                secObj.CreateLabel(cfg.Title or "Slider")
                return {} 
            end
            
            function secObj.CreateBox(cfg, cb) 
                return secObj.CreateButton({ Title = cfg.Title or "Box" }, function() if cb then pcall(cb, "") end end)
            end
            
            function secObj.CreateNoti(text) print(text) end
            function secObj.CreatePriorityDropdown(cfg, cb) return secObj.CreateDropdown(cfg, cb) end
            function secObj.CreateMultiToggle(cfg, cb) return secObj.CreateButton({ Title = cfg.Title or "Multi" }, function() if cb then pcall(cb, {}) end end) end
            function secObj.CreateSliderDropdown(cfg, cb) return secObj.CreateDropdown(cfg, cb) end
            
            return secObj
        end
        
        function tabObj:AddSubTab(cfg)
            return createTab(cfg.Name, cfg.Icon)
        end
        
        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                currentTab.Content.Visible = false
                currentTab.Button.BackgroundColor3 = PANEL_2
                currentTab.Button.TextColor3 = MUTED
            end
            tabContent.Visible = true
            tabButton.BackgroundColor3 = ACCENT
            tabButton.TextColor3 = TEXT
            currentTab = { Content = tabContent, Button = tabButton }
        end)
        
        if #tabs == 0 then
            tabContent.Visible = true
            tabButton.BackgroundColor3 = ACCENT
            tabButton.TextColor3 = TEXT
            currentTab = { Content = tabContent, Button = tabButton }
        end
        
        table.insert(tabs, { Name = name, Button = tabButton, Content = tabContent })
        
        local api = {}
        function api:CreateSection(name) return tabObj:CreateSection(name) end
        function api:CreateToggle(cfg, cb) return tabObj:CreateSection("Section"):CreateToggle(cfg, cb) end
        function api:CreateButton(cfg, cb) return tabObj:CreateSection("Section"):CreateButton(cfg, cb) end
        function api:CreateLabel(cfg) return tabObj:CreateSection("Section"):CreateLabel(cfg) end
        
        return api
    end
    
    local api = {}
    
    function api:CreateTab(name)
        return createTab(name, nil)
    end
    
    function api:SetTitle(newTitle)
        title.Text = tostring(newTitle)
    end
    
    function api:SetVisible(visible)
        window.Visible = visible == true
    end
    
    function api:Destroy()
        if screen then screen:Destroy() end
        if floatingScreen then floatingScreen:Destroy() end
    end
    
    function api:ToggleVisibility()
        window.Visible = not window.Visible
    end
    
    -- Floating button logic (Vxeze style)
    local floatingDragging = false
    local floatingStart, floatingPos
    
    floatingIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatingDragging = false
            floatingStart = input.Position
            floatingPos = floatingFrame.Position
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if floatingStart and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - floatingStart
            if math.abs(delta.X) + math.abs(delta.Y) > 6 then floatingDragging = true end
            if floatingDragging then
                floatingFrame.Position = UDim2.new(floatingPos.X.Scale, floatingPos.X.Offset + delta.X, floatingPos.Y.Scale, floatingPos.Y.Offset + delta.Y)
            end
        end
    end)
    
    floatingIcon.MouseButton1Click:Connect(function()
        if floatingDragging then return end
        window.Visible = not window.Visible
    end)
    
    closeBtn.MouseButton1Click:Connect(function() window.Visible = false end)
    minimizeBtn.MouseButton1Click:Connect(function() window.Visible = false end)
    
    addDrag(window, topbar)
    
    VxezeUI.Window = api
    VxezeUI.Library._Root = screen
    
    return api
end

function VxezeUI.Library:Confirm(cfg)
    print("[VxezeUI] Confirm: " .. (cfg.Title or ""))
    if cfg.Callback then pcall(cfg.Callback, true) end
end

return VxezeUI
