
--[[
    Hub Vxeze [grátis] Verdadeiro v2 UI Library
    Recriado exatamente como na imagem enviada
    - Fundo escuro transparente, arredondado
    - Sidebar: Principal, Farm, Mundo, Loja, Visual, Webhook
    - Tabs: Farming, Pilha, Boss, Outro
    - Toggles: Auto Factory, Auto Pirate Raid, Secret Quest 24/39
    - Cores: preto transparente, ciano #00C8A0, branco
    - Sem sons, sem loading
]]

local VxezeGratis = {}
VxezeGratis.__index = VxezeGratis

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Cores exatamente como na imagem Vxeze Gratis
local CYAN = Color3.fromRGB(0, 200, 160) -- Ciano do toggle ativo e progress bar
local CYAN_DARK = Color3.fromRGB(0, 150, 120)
local BG = Color3.fromRGB(18, 18, 22) -- Fundo escuro
local BG_TRANSP = 0.15
local PANEL = Color3.fromRGB(28, 28, 35)
local PANEL_2 = Color3.fromRGB(35, 35, 45)
local SIDEBAR_BG = Color3.fromRGB(22, 22, 28)
local TEXT = Color3.fromRGB(240, 240, 240)
local TEXT_DIM = Color3.fromRGB(180, 180, 185)
local TEXT_MUTED = Color3.fromRGB(120, 120, 125)
local BORDER = Color3.fromRGB(50, 50, 60)
local TOGGLE_OFF = Color3.fromRGB(70, 70, 80)

local function make(className, props, parent)
    local o = Instance.new(className)
    for k, v in pairs(props or {}) do
        o[k] = v
    end
    o.Parent = parent
    return o
end

local function corner(parent, radius)
    return make("UICorner", { CornerRadius = UDim.new(0, radius or 12) }, parent)
end

local function stroke(parent, color, thickness, transparency)
    return make("UIStroke", {
        Color = color or BORDER,
        Thickness = thickness or 1,
        Transparency = transparency or 0.5,
    }, parent)
end

local function tween(obj, info, props)
    pcall(function()
        TweenService:Create(obj, info, props):Play()
    end)
end

local function addDrag(target, handle)
    local dragging, startPos, startInput = false, nil, nil
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startInput = input.Position
            startPos = target.Position
        end
    end)
    handle.InputEnded:Connect(function()
        dragging = false
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - startInput
            target.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

function VxezeGratis:CreateWindow(options)
    options = options or {}
    local titleText = options.Title or "Hub Vxeze [grátis]"
    local subtitleText = options.Subtitle or "Verdadeiro v2"
    
    local guiParent
    local ok, hui = pcall(function()
        if typeof(gethui) == "function" then return gethui() end
        return nil
    end)
    if ok and hui then
        guiParent = hui
    else
        guiParent = LocalPlayer:FindFirstChild("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    end
    
    pcall(function()
        for _, name in pairs({"VxezeGratisUI", "LunarHubUI", "NexoraUI", "NexoraLoading", "VxezeHubUI"}) do
            local old = guiParent:FindFirstChild(name)
            if old then old:Destroy() end
        end
    end)
    
    local screen = make("ScreenGui", {
        Name = "VxezeGratisUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
    }, guiParent)
    
    -- Main window - exatamente como na imagem: escuro transparente, bem arredondado
    local window = make("Frame", {
        Name = "MainWindow",
        Size = UDim2.fromOffset(700, 480),
        Position = UDim2.new(0.5, -350, 0.5, -240),
        BackgroundColor3 = BG,
        BackgroundTransparency = BG_TRANSP,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, screen)
    corner(window, 16)
    stroke(window, BORDER, 1, 0.6)
    
    -- Blur effect (simulado com transparência)
    local blurCover = make("Frame", {
        Name = "BlurCover",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = BG,
        BackgroundTransparency = 0.25,
        BorderSizePixel = 0,
    }, window)
    corner(blurCover, 16)
    
    -- Topbar com titulo Hub Vxeze [grátis] Verdadeiro v2
    local topbar = make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 55),
        BackgroundColor3 = Color3.fromRGB(25, 25, 30),
        BackgroundTransparency = 0.15,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, window)
    corner(topbar, 16)
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BackgroundColor3 = BORDER,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
    }, topbar)
    
    -- Icon top left (88 blue)
    local topIcon = make("Frame", {
        Size = UDim2.fromOffset(36, 36),
        Position = UDim2.new(0, 12, 0, 9),
        BackgroundColor3 = Color3.fromRGB(45, 45, 60),
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
    }, topbar)
    corner(topIcon, 10)
    make("TextLabel", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        Text = "88",
        TextColor3 = Color3.fromRGB(100, 150, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
    }, topIcon)
    
    local titleLabel = make("TextLabel", {
        Name = "Title",
        Size = UDim2.new(1, -200, 0, 20),
        Position = UDim2.new(0, 55, 0, 8),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = TEXT,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
    }, topbar)
    
    local subtitleLabel = make("TextLabel", {
        Size = UDim2.new(1, -200, 0, 15),
        Position = UDim2.new(0, 55, 0, 26),
        BackgroundTransparency = 1,
        Text = subtitleText,
        TextColor3 = TEXT_DIM,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 3,
    }, topbar)
    
    -- Search and buttons top right (como na imagem)
    local searchBtn = make("TextButton", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -90, 0, 12),
        BackgroundColor3 = PANEL_2,
        BackgroundTransparency = 0.3,
        Text = "🔍",
        TextSize = 14,
        BorderSizePixel = 0,
        ZIndex = 3,
    }, topbar)
    corner(searchBtn, 8)
    
    local minBtn = make("TextButton", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -55, 0, 12),
        BackgroundColor3 = PANEL_2,
        BackgroundTransparency = 0.3,
        Text = "—",
        TextColor3 = TEXT_DIM,
        TextSize = 14,
        BorderSizePixel = 0,
        ZIndex = 3,
    }, topbar)
    corner(minBtn, 8)
    
    local closeBtn = make("TextButton", {
        Size = UDim2.fromOffset(30, 30),
        Position = UDim2.new(1, -20, 0, 12),
        BackgroundColor3 = PANEL_2,
        BackgroundTransparency = 0.3,
        Text = "X",
        TextColor3 = TEXT_DIM,
        TextSize = 12,
        BorderSizePixel = 0,
        ZIndex = 3,
    }, topbar)
    corner(closeBtn, 8)
    
    -- Sidebar esquerda: Principal, Farm, Mundo, Loja, Visual, Webhook
    local sidebar = make("Frame", {
        Name = "Sidebar",
        Size = UDim2.new(0, 150, 1, -60),
        Position = UDim2.new(0, 5, 0, 58),
        BackgroundColor3 = SIDEBAR_BG,
        BackgroundTransparency = 0.2,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, window)
    corner(sidebar, 12)
    
    local sidebarList = make("ScrollingFrame", {
        Name = "SidebarList",
        Size = UDim2.new(1, -10, 1, -10),
        Position = UDim2.new(0, 5, 0, 5),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    make("UIListLayout", {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, sidebarList)
    
    -- Content area direita
    local contentArea = make("Frame", {
        Name = "ContentArea",
        Size = UDim2.new(1, -165, 1, -65),
        Position = UDim2.new(0, 160, 0, 60),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 2,
    }, window)
    
    -- Top tabs: Farming, Pilha, Boss, Outro (como na imagem)
    local topTabs = make("Frame", {
        Name = "TopTabs",
        Size = UDim2.new(1, 0, 0, 32),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }, contentArea)
    make("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, topTabs)
    
    -- Main content scroll
    local contentScroll = make("ScrollingFrame", {
        Name = "ContentScroll",
        Size = UDim2.new(1, 0, 1, -40),
        Position = UDim2.new(0, 0, 0, 38),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = CYAN,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, contentArea)
    make("UIListLayout", {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, contentScroll)
    
    -- Floating button (3 dots like image right side)
    local floating = make("TextButton", {
        Name = "FloatingButton",
        Size = UDim2.fromOffset(36, 60),
        Position = UDim2.new(1, -50, 0.5, -30),
        BackgroundColor3 = BG,
        BackgroundTransparency = 0.3,
        Text = "⋮",
        TextColor3 = TEXT,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        ZIndex = 10,
    }, screen)
    corner(floating, 18)
    stroke(floating, BORDER, 1, 0.5)
    
    local tabs = {}
    local sidebarTabs = {}
    local currentSidebar = nil
    local currentTopTab = nil
    
    local function createSidebarTab(name, icon, isMain)
        local btn = make("TextButton", {
            Name = name,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundColor3 = isMain and PANEL_2 or Color3.fromRGB(0,0,0),
            BackgroundTransparency = isMain and 0.2 or 1,
            Text = (icon and (icon .. "  ") or "") .. name,
            TextColor3 = isMain and TEXT or TEXT_MUTED,
            TextSize = 12,
            Font = Enum.Font.Gotham,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
        }, sidebarList)
        corner(btn, 8)
        if isMain then
            stroke(btn, CYAN, 1, 0.6)
        end
        
        local tabContent = make("Frame", {
            Name = name .. "_SidebarContent",
            Size = UDim2.new(1, 0, 0, 0),
            BackgroundTransparency = 1,
            Visible = isMain and true or false,
            AutomaticSize = Enum.AutomaticSize.Y,
        }, contentScroll)
        make("UIListLayout", {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, tabContent)
        
        btn.MouseButton1Click:Connect(function()
            for _, t in pairs(sidebarTabs) do
                t.Content.Visible = false
                t.Button.BackgroundTransparency = 1
                t.Button.TextColor3 = TEXT_MUTED
                if t.Button:FindFirstChild("UIStroke") then
                    t.Button:FindFirstChild("UIStroke"):Destroy()
                end
            end
            tabContent.Visible = true
            btn.BackgroundTransparency = 0.2
            btn.BackgroundColor3 = PANEL_2
            btn.TextColor3 = TEXT
            stroke(btn, CYAN, 1, 0.6)
            currentSidebar = { Button = btn, Content = tabContent }
        end)
        
        table.insert(sidebarTabs, { Name = name, Button = btn, Content = tabContent })
        
        if isMain then
            currentSidebar = { Button = btn, Content = tabContent }
        end
        
        return { Button = btn, Content = tabContent, Name = name }
    end
    
    local function createTopTab(name, icon, selected)
        local btn = make("TextButton", {
            Name = name,
            Size = UDim2.fromOffset(80, 28),
            BackgroundColor3 = selected and PANEL_2 or Color3.fromRGB(0,0,0),
            BackgroundTransparency = selected and 0.2 or 1,
            Text = (icon and (icon .. " ") or "") .. name,
            TextColor3 = selected and TEXT or TEXT_MUTED,
            TextSize = 11,
            Font = Enum.Font.Gotham,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
        }, topTabs)
        corner(btn, 8)
        if selected then
            stroke(btn, CYAN, 1, 0.5)
        end
        
        btn.MouseButton1Click:Connect(function()
            for _, child in pairs(topTabs:GetChildren()) do
                if child:IsA("TextButton") then
                    child.BackgroundTransparency = 1
                    child.TextColor3 = TEXT_MUTED
                    local s = child:FindFirstChild("UIStroke")
                    if s then s:Destroy() end
                end
            end
            btn.BackgroundTransparency = 0.2
            btn.BackgroundColor3 = PANEL_2
            btn.TextColor3 = TEXT
            stroke(btn, CYAN, 1, 0.5)
        end)
        
        return btn
    end
    
    -- Criar sidebar tabs como na imagem
    createSidebarTab("Principal", "◉", false)
    local farmTab = createSidebarTab("Farm", "◎", true)
    createSidebarTab("Mundo", "🌐", false)
    createSidebarTab("Loja", "🛒", false)
    createSidebarTab("Visual", "🖥", false)
    createSidebarTab("Webhook", "🔗", false)
    
    -- Criar top tabs como na imagem
    createTopTab("Farming", "⚔", false)
    createTopTab("Pilha", "⭐", true)
    createTopTab("Boss", "💀", false)
    createTopTab("Outro", "✦", false)
    
    local api = {}
    local contentFrames = { farmTab.Content }
    
    function api:CreateTab(name)
        -- Para compatibilidade com Nexora: cria aba na sidebar
        local sidebarTab = createSidebarTab(name, "•", false)
        table.insert(contentFrames, sidebarTab.Content)
        
        local tabApi = {}
        
        function tabApi:CreateSection(sectionName)
            -- Encontra o content frame atual ou usa o ultimo
            local targetContent = sidebarTab.Content
            
            local section = make("Frame", {
                Name = sectionName,
                Size = UDim2.new(1, 0, 0, 0),
                BackgroundColor3 = PANEL,
                BackgroundTransparency = 0.2,
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.Y,
            }, targetContent)
            corner(section, 12)
            stroke(section, BORDER, 1, 0.6)
            
            local sectionTitle = make("TextLabel", {
                Size = UDim2.new(1, -10, 0, 22),
                Position = UDim2.new(0, 10, 0, 0),
                BackgroundTransparency = 1,
                Text = sectionName,
                TextColor3 = TEXT,
                TextSize = 11,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, section)
            
            make("UIListLayout", {
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
            }, section)
            
            make("UIPadding", {
                PaddingTop = UDim.new(0, 26),
                PaddingBottom = UDim.new(0, 8),
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
            }, section)
            
            local secObj = {}
            
            function secObj.CreateToggle(cfg, callback)
                cfg = cfg or {}
                local toggleName = cfg.Title or cfg.Text or "Toggle"
                
                local toggleFrame = make("Frame", {
                    Size = UDim2.new(1, 0, 0, 32),
                    BackgroundColor3 = PANEL_2,
                    BackgroundTransparency = 0.3,
                    BorderSizePixel = 0,
                }, section)
                corner(toggleFrame, 8)
                
                local toggleLabel = make("TextLabel", {
                    Size = UDim2.new(1, -55, 1, 0),
                    Position = UDim2.new(0, 8, 0, 0),
                    BackgroundTransparency = 1,
                    Text = toggleName,
                    TextColor3 = TEXT,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    TextXAlignment = Enum.TextXAlignment.Left,
                }, toggleFrame)
                
                local toggleBtn = make("Frame", {
                    Size = UDim2.fromOffset(38, 20),
                    Position = UDim2.new(1, -45, 0.5, -10),
                    BackgroundColor3 = TOGGLE_OFF,
                    BackgroundTransparency = 0.2,
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
                        tween(toggleBtn, TweenInfo.new(0.2), { BackgroundColor3 = CYAN })
                        tween(toggleCircle, TweenInfo.new(0.2), { Position = UDim2.fromOffset(20, 2) })
                    else
                        tween(toggleBtn, TweenInfo.new(0.2), { BackgroundColor3 = TOGGLE_OFF })
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
                    BackgroundTransparency = 0.3,
                    Text = cfg.Title or "Button",
                    TextColor3 = TEXT,
                    TextSize = 11,
                    Font = Enum.Font.Gotham,
                    BorderSizePixel = 0,
                }, section)
                corner(btn, 8)
                
                btn.MouseButton1Click:Connect(function()
                    if callback then pcall(callback) end
                end)
                
                return { SetText = function() end }
            end
            
            function secObj.CreateLabel(cfg)
                local text = type(cfg) == "table" and (cfg.Title or "") or tostring(cfg or "")
                -- Detecta Secret Quest para fazer progress bar igual imagem
                if text:lower():find("secret") and text:lower():find("quest") then
                    local container = make("Frame", {
                        Size = UDim2.new(1, 0, 0, 50),
                        BackgroundTransparency = 1,
                    }, section)
                    
                    local label = make("TextLabel", {
                        Size = UDim2.new(1, 0, 0, 18),
                        BackgroundTransparency = 1,
                        Text = "🔵 Secret Quest",
                        TextColor3 = CYAN,
                        TextSize = 11,
                        Font = Enum.Font.GothamBold,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }, container)
                    
                    local sub = make("TextLabel", {
                        Size = UDim2.new(1, 0, 0, 14),
                        Position = UDim2.new(0, 0, 0, 18),
                        BackgroundTransparency = 1,
                        Text = "Mar 1 secret quests done",
                        TextColor3 = TEXT_DIM,
                        TextSize = 10,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                    }, container)
                    
                    local barBg = make("Frame", {
                        Size = UDim2.new(1, 0, 0, 4),
                        Position = UDim2.new(0, 0, 0, 36),
                        BackgroundColor3 = TOGGLE_OFF,
                        BorderSizePixel = 0,
                    }, container)
                    corner(barBg, 2)
                    
                    local barFill = make("Frame", {
                        Size = UDim2.new(0.6, 0, 1, 0),
                        BackgroundColor3 = CYAN,
                        BorderSizePixel = 0,
                    }, barBg)
                    corner(barFill, 2)
                    
                    local countLabel = make("TextLabel", {
                        Size = UDim2.new(0, 50, 0, 14),
                        Position = UDim2.new(1, -50, 0, 18),
                        BackgroundTransparency = 1,
                        Text = "24 / 39",
                        TextColor3 = TEXT_MUTED,
                        TextSize = 10,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Right,
                    }, container)
                    
                    return { SetText = function() end }
                end
                
                local label = make("TextLabel", {
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = text,
                    TextColor3 = TEXT_DIM,
                    TextSize = 11,
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
        
        function tabApi:CreateSection(name)
            return tabApi:CreateSection(name)
        end
        
        return tabApi
    end
    
    function api:SetTitle(newTitle)
        titleLabel.Text = tostring(newTitle)
    end
    
    function api:SetVisible(visible)
        window.Visible = visible == true
    end
    
    function api:Destroy()
        if screen then screen:Destroy() end
    end
    
    function api:ToggleVisibility()
        window.Visible = not window.Visible
    end
    
    floating.MouseButton1Click:Connect(function()
        window.Visible = not window.Visible
    end)
    
    closeBtn.MouseButton1Click:Connect(function() window.Visible = false end)
    minBtn.MouseButton1Click:Connect(function() window.Visible = false end)
    
    addDrag(window, topbar)
    addDrag(floating, floating)
    
    -- Resize
    local resizeGrip = make("TextButton", {
        Size = UDim2.fromOffset(20, 20),
        Position = UDim2.new(1, -20, 1, -20),
        BackgroundColor3 = PANEL_2,
        BackgroundTransparency = 0.5,
        Text = "◢",
        TextColor3 = TEXT_MUTED,
        TextSize = 12,
        BorderSizePixel = 0,
    }, window)
    corner(resizeGrip, 4)
    
    local resizing, resizeStart, startSize = false, nil, nil
    resizeGrip.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            resizing = true
            resizeStart = input.Position
            startSize = window.Size
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - resizeStart
            local newW = math.clamp(startSize.X.Offset + delta.X, 300, 1000)
            local newH = math.clamp(startSize.Y.Offset + delta.Y, 300, 800)
            window.Size = UDim2.fromOffset(newW, newH)
        end
    end)
    
    UserInputService.InputEnded:Connect(function()
        resizing = false
    end)
    
    return api
end

return VxezeGratis
