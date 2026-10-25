--[[
    Lunar Hub UI Library
    Halloween Edition - Black / Orange
    Standalone Roblox UI framework (no external UI libraries).

    Features:
      - Persistent floating button to show/hide the main window
      - Draggable floating button and draggable window
      - Resizable window (bottom-right handle)
      - Sidebar tabs
      - Toggle, Button, Label and Section controls
      - Responsive starting size for smaller screens

    Usage:
      local LunarUI = loadstring(readfile("LunarHubUI.lua"))()
      local Window = LunarUI:CreateWindow({ Title = "Lunar Hub" })
      local Main = Window:CreateTab("Main")
      Main:CreateSection("General")
      Main:CreateToggle({ Name = "Example toggle", Default = false,
          Callback = function(value) print(value) end })
      Main:CreateButton({ Name = "Example button",
          Callback = function() print("Clicked") end })

    Note:
      This file creates the interface only. Connect your own legitimate feature
      callbacks to the controls. It does not include game automation or exploits.
]]

local LunarUI = {}
LunarUI.__index = LunarUI

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local GuiService = game:GetService("GuiService")

local LocalPlayer = Players.LocalPlayer
local ORANGE = Color3.fromRGB(255, 125, 24)
local ORANGE_DARK = Color3.fromRGB(190, 66, 8)
local BG = Color3.fromRGB(10, 10, 13)
local PANEL = Color3.fromRGB(17, 17, 22)
local PANEL_2 = Color3.fromRGB(24, 24, 30)
local TEXT = Color3.fromRGB(245, 240, 235)
local MUTED = Color3.fromRGB(164, 158, 153)
local BORDER = Color3.fromRGB(68, 43, 29)

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
    return make("UIStroke", {
        Color = color or BORDER,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    }, parent)
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
    local dragging, dragStart, startPos, activeInput = false, nil, nil, nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            activeInput = input
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    activeInput = nil
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch
            or input == activeInput) then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale, startPos.X.Offset + delta.X,
                startPos.Y.Scale, startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function LunarUI:CreateWindow(options)
    options = options or {}
    local titleText = options.Title or "Lunar Hub"
    local guiParent

    local ok, hui = pcall(function()
        if typeof(gethui) == "function" then
            return gethui()
        end
        return nil
    end)

    if ok and hui then
        guiParent = hui
    else
        local playerGui = LocalPlayer:WaitForChild("PlayerGui")
        guiParent = playerGui
    end

    local old = guiParent:FindFirstChild("LunarHubUI")
    if old then old:Destroy() end

    local screen = make("ScreenGui", {
        Name = "LunarHubUI",
        ResetOnSpawn = false,
        IgnoreGuiInset = true,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 999,
    }, guiParent)

    local camera = workspace.CurrentCamera
    local viewport = camera and camera.ViewportSize or Vector2.new(900, 600)
    local compact = viewport.X < 700
    local initialWidth = compact and math.max(320, math.min(440, viewport.X - 24)) or 680
    local initialHeight = compact and math.max(330, math.min(480, viewport.Y - 80)) or 450

    local window = make("Frame", {
        Name = "MainWindow",
        Size = UDim2.fromOffset(initialWidth, initialHeight),
        Position = UDim2.new(0.5, -initialWidth / 2, 0.5, -initialHeight / 2),
        BackgroundColor3 = BG,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    }, screen)
    corner(window, 12)
    local windowStroke = stroke(window, ORANGE, 1.5, 0.1)
    local windowStrokePulse = TweenService:Create(windowStroke, TweenInfo.new(1.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.05, Thickness = 3})
    windowStrokePulse:Play()
    -- Borda laranja fixa e limpa: sem pulsação contínua.
    windowStroke.Transparency = 0.08
    windowStroke.Thickness = 1.5

    local topbar = make("Frame", {
        Name = "Topbar",
        Size = UDim2.new(1, 0, 0, 48),
        BackgroundColor3 = Color3.fromRGB(20, 15, 13),
        BorderSizePixel = 0,
    }, window)
    make("Frame", {
        Size = UDim2.new(1, 0, 0, 2),
        Position = UDim2.new(0, 0, 1, -2),
        BackgroundColor3 = ORANGE,
        BorderSizePixel = 0,
    }, topbar)

    local topbarGradient = make("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, ORANGE_DARK),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 190, 70)),
            ColorSequenceKeypoint.new(1, ORANGE),
        }),
        Rotation = 0,
    }, topbar:FindFirstChildWhichIsA("Frame"))
    -- Gradiente laranja fluido e discreto, sem pulsar a janela inteira.
    topbarGradient.Rotation = 0
    tween(topbarGradient, TweenInfo.new(3.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        Rotation = 180
    })

    local moon = make("TextLabel", {
        Size = UDim2.fromOffset(32, 34),
        Position = UDim2.fromOffset(12, 6),
        BackgroundTransparency = 1,
        Text = "🎃",
        TextColor3 = ORANGE,
        TextSize = 30,
        Font = Enum.Font.GothamBold,
    }, topbar)

    local title = make("TextLabel", {
        Name = "Title",
        Position = UDim2.fromOffset(48, 2),
        Size = UDim2.new(1, -145, 0, 27),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = TEXT,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, topbar)

    local developerLabel = make("TextLabel", {
        Name = "DeveloperCredit",
        Position = UDim2.fromOffset(49, 27),
        Size = UDim2.new(1, -150, 0, 15),
        BackgroundTransparency = 1,
        Text = "Dev: ViniZ_DV",
        TextColor3 = Color3.fromRGB(255, 157, 79),
        TextSize = 10,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, topbar)

    local hideButton = make("TextButton", {
        Name = "HideButton",
        Size = UDim2.fromOffset(32, 30),
        Position = UDim2.new(1, -76, 0, 9),
        BackgroundColor3 = PANEL_2,
        Text = "—",
        TextColor3 = ORANGE,
        TextSize = 20,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = true,
    }, topbar)
    corner(hideButton, 8)
    hideButton.MouseEnter:Connect(function() tween(hideButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(63, 32, 16), Rotation = -8}) end)
    hideButton.MouseLeave:Connect(function() tween(hideButton, TweenInfo.new(0.18), {BackgroundColor3 = PANEL_2, Rotation = 0}) end)

    local closeButton = make("TextButton", {
        Name = "CloseButton",
        Size = UDim2.fromOffset(32, 30),
        Position = UDim2.new(1, -38, 0, 9),
        BackgroundColor3 = PANEL_2,
        Text = "×",
        TextColor3 = ORANGE,
        TextSize = 23,
        Font = Enum.Font.Gotham,
        AutoButtonColor = true,
    }, topbar)
    corner(closeButton, 8)
    closeButton.MouseEnter:Connect(function() tween(closeButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(95, 32, 20), Rotation = 8}) end)
    closeButton.MouseLeave:Connect(function() tween(closeButton, TweenInfo.new(0.18), {BackgroundColor3 = PANEL_2, Rotation = 0}) end)

    local sidebar = make("Frame", {
        Name = "Sidebar",
        Visible = true,
        Position = UDim2.fromOffset(0, 50),
        Size = UDim2.new(0, 42, 1, -50),
        BackgroundColor3 = Color3.fromRGB(13, 13, 17),
        BorderSizePixel = 0,
    }, window)

    local sideTitle = make("TextLabel", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.fromOffset(6, 8),
        BackgroundTransparency = 1,
        Text = "🎃",
        TextColor3 = ORANGE,
        TextSize = 22,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, sidebar)

    local sidebarFooter = make("TextLabel", {
        Name = "HalloweenFooter",
        AnchorPoint = Vector2.new(0.5, 1),
        Position = UDim2.new(0.5, 0, 1, -5),
        Size = UDim2.new(1, -12, 0, 24),
        BackgroundTransparency = 1,
        Text = "☠",
        TextColor3 = ORANGE_DARK,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        TextWrapped = true,
    }, sidebar)

    local tabList = make("ScrollingFrame", {
        Name = "TabList",
        Visible = false,
        Position = UDim2.fromOffset(7, 49),
        Size = UDim2.new(1, -14, 1, -58),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 3,
        ScrollBarImageColor3 = ORANGE,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
    }, sidebar)
    make("UIListLayout", {
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    }, tabList)

    -- Trilho lateral decorativo sem abas: detalhes animados para preencher a barra.
    local railTop = make("Frame", {
        Name = "RailTopAccent",
        Position = UDim2.new(0.5, -2, 0, 55),
        Size = UDim2.new(0, 4, 0, 34),
        BackgroundColor3 = ORANGE,
        BorderSizePixel = 0,
    }, sidebar)
    corner(railTop, 4)
    tween(railTop, TweenInfo.new(1.3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        BackgroundColor3 = Color3.fromRGB(255, 190, 95), Size = UDim2.new(0, 4, 0, 52)
    })
    for i = 1, 4 do
        local railDot = make("Frame", {
            Name = "RailDot" .. i,
            Position = UDim2.new(0.5, -2, 0, 112 + (i - 1) * 17),
            Size = UDim2.fromOffset(4, 4),
            BackgroundColor3 = ORANGE_DARK,
            BackgroundTransparency = 0.15 + (i * 0.12),
            BorderSizePixel = 0,
        }, sidebar)
        corner(railDot, 4)
        tween(railDot, TweenInfo.new(0.8 + i * 0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            BackgroundTransparency = 0.05
        })
    end

    local content = make("Frame", {
        Name = "Content",
        Position = UDim2.new(0, 42, 0, 50),
        Size = UDim2.new(1, -42, 1, -50),
        BackgroundColor3 = BG,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }, window)

    -- User-provided Halloween background asset. Keep it subtle so text/buttons remain readable.
    local halloweenBackground = make("ImageLabel", {
        Name = "HalloweenBackground",
        Size = UDim2.fromScale(1, 1),
        Position = UDim2.fromScale(0, 0),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=Asset&id=123816569263005&w=420&h=420",
        ImageTransparency = 0.08,
        ScaleType = Enum.ScaleType.Crop,
        BorderSizePixel = 0,
        ZIndex = 1,
    }, content)
    halloweenBackground.ZIndex = 0
    -- Soft dark overlay improves text readability while preserving the artwork.
    local backgroundShade = make("Frame", {
        Name = "BackgroundShade", Size = UDim2.fromScale(1, 1),
        BackgroundColor3 = Color3.fromRGB(8, 7, 10), BackgroundTransparency = 0.78,
        BorderSizePixel = 0, ZIndex = 0,
    }, content)
    -- Deixa o artwork visível como no mockup, mantendo contraste leve para o texto.
    backgroundShade.BackgroundTransparency = 0.78

    -- Halloween atmosphere: decorative pumpkin/moon art made from native UI,
    -- so no external image host is required.
    local halloweenStrip = make("Frame", {
        Name = "HalloweenAccent",
        Position = UDim2.new(1, -72, 0, 10),
        Size = UDim2.fromOffset(58, 30),
        BackgroundColor3 = Color3.fromRGB(37, 20, 12),
        BackgroundTransparency = 0.12,
        BorderSizePixel = 0,
        ZIndex = 1,
    }, content)
    corner(halloweenStrip, 9)
    local stripStroke = stroke(halloweenStrip, ORANGE_DARK, 1, 0.25)
    if stripStroke then
        TweenService:Create(stripStroke, TweenInfo.new(1.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {Transparency = 0.02, Thickness = 2}):Play()
    end
    make("TextLabel", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "🎃 🦇",
        TextColor3 = ORANGE,
        TextSize = 17,
        Font = Enum.Font.GothamBold,
        ZIndex = 2,
    }, halloweenStrip)

    local pageHeader = make("TextLabel", {
        Name = "PageTitle",
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -32, 0, 32),
        BackgroundTransparency = 1,
        Text = "Lunar Hub | Blox Fruits",
        TextColor3 = TEXT,
        TextSize = compact and 16 or 19,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, content)

    -- Animação suave de entrada para o título da página e faixa temática.
    pageHeader.TextTransparency = 1
    tween(pageHeader, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0})
    tween(halloweenStrip, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -72, 0, 10), BackgroundTransparency = 0.12
    })

    local pages = {}
    local activeTab = nil
    local api = { Screen = screen, Frame = window, Tabs = pages }

    local function selectTab(tab)
        activeTab = tab
        for _, item in ipairs(pages) do
            item.Page.Visible = item == tab
            tween(item.Button, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundColor3 = item == tab and Color3.fromRGB(74, 35, 12) or PANEL,
                TextColor3 = item == tab and ORANGE or MUTED,
            })
            item.Button.BorderSizePixel = item == tab and 1 or 0
            item.Button.BorderColor3 = ORANGE
            if item == tab then
                item.Button.Size = UDim2.new(1, -5, 0, compact and 32 or 36)
                tween(item.Button, TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, compact and 32 or 36)})
                tab.Page.CanvasPosition = Vector2.new(0, 0)
            end
        end
        pageHeader.Text = "🎃  " .. tab.Name
    end

    function api:CreateTab(tabName)
        local tabButton = make("TextButton", {
            Name = tabName .. "Tab",
            Size = UDim2.new(1, 0, 0, compact and 32 or 36),
            BackgroundColor3 = PANEL,
            Text = (tabName == "Main" and "⌂  " or "✦  ") .. tabName,
            TextColor3 = MUTED,
            TextSize = compact and 11 or 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextTruncate = Enum.TextTruncate.AtEnd,
            BorderSizePixel = 0,
            AutoButtonColor = true,
        }, tabList)
        corner(tabButton, 7)
        tabButton.MouseEnter:Connect(function()
            if activeTab ~= nil and activeTab.Button ~= tabButton then
                tween(tabButton, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = Color3.fromRGB(39, 25, 18), TextColor3 = TEXT
                })
            end
        end)
        tabButton.MouseLeave:Connect(function()
            if activeTab == nil or activeTab.Button ~= tabButton then
                tween(tabButton, TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    BackgroundColor3 = PANEL, TextColor3 = MUTED
                })
            end
        end)
        make("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 4),
        }, tabButton)

        local page = make("ScrollingFrame", {
            Name = tabName .. "Page",
            Position = UDim2.fromOffset(12, 52),
            Size = UDim2.new(1, -24, 1, -64),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = ORANGE,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
        }, content)
        make("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        }, page)

        local tab = { Name = tabName, Button = tabButton, Page = page }
        table.insert(pages, tab)
        tabButton.MouseButton1Click:Connect(function() selectTab(tab) end)

        local tabApi = { Page = page, Name = tabName }

        function tabApi:CreateSection(sectionName)
            local label = make("TextLabel", {
                Size = UDim2.new(1, -2, 0, 26),
                BackgroundTransparency = 1,
                Text = string.upper(sectionName),
                TextColor3 = ORANGE,
                TextSize = 12,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left,
            }, page)
            return label
        end

        function tabApi:CreateLabel(textValue)
            local label = make("TextLabel", {
                Size = UDim2.new(1, -2, 0, 30),
                BackgroundColor3 = PANEL,
                Text = "  " .. tostring(textValue),
                TextColor3 = MUTED,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true,
            }, page)
            corner(label, 7)
            return label
        end

        function tabApi:CreateButton(config)
            config = config or {}
            local button = make("TextButton", {
                Size = UDim2.new(1, -2, 0, 39),
                BackgroundColor3 = PANEL_2,
                Text = "  " .. (config.Name or "Button") .. "     ›",
                TextColor3 = TEXT,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutoButtonColor = true,
            }, page)
            corner(button, 8)
            stroke(button, BORDER, 1, 0.35)
            button.MouseButton1Click:Connect(function()
                if type(config.Callback) == "function" then
                    task.spawn(function()
                        local success, err = pcall(config.Callback)
                        if not success then warn("[Lunar Hub] Button callback:", err) end
                    end)
                end
            end)
            return button
        end

        function tabApi:CreateToggle(config)
            config = config or {}
            local value = config.Default == true
            local row = make("Frame", {
                Size = UDim2.new(1, -2, 0, 48),
                BackgroundColor3 = PANEL,
                BorderSizePixel = 0,
            }, page)
            corner(row, 8)
            local rowStroke = stroke(row, BORDER, 1, 0.45)
            row.MouseEnter:Connect(function()
                tween(row, TweenInfo.new(0.16), {BackgroundColor3 = Color3.fromRGB(27, 22, 21)})
                if rowStroke then tween(rowStroke, TweenInfo.new(0.16), {Color = ORANGE, Transparency = 0.12}) end
            end)
            row.MouseLeave:Connect(function()
                tween(row, TweenInfo.new(0.2), {BackgroundColor3 = PANEL})
                if rowStroke then tween(rowStroke, TweenInfo.new(0.2), {Color = BORDER, Transparency = 0.45}) end
            end)

            local name = make("TextLabel", {
                Position = UDim2.fromOffset(12, 0),
                Size = UDim2.new(1, -76, 1, 0),
                BackgroundTransparency = 1,
                Text = config.Name or "Toggle",
                TextColor3 = TEXT,
                TextSize = 13,
                Font = Enum.Font.GothamMedium,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
            }, row)

            local switch = make("TextButton", {
                Size = UDim2.fromOffset(42, 23),
                Position = UDim2.new(1, -54, 0.5, -11),
                BackgroundColor3 = value and ORANGE_DARK or Color3.fromRGB(56, 56, 62),
                Text = "",
                BorderSizePixel = 0,
                AutoButtonColor = false,
            }, row)
            corner(switch, 12)

            local knob = make("Frame", {
                Size = UDim2.fromOffset(17, 17),
                Position = value and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 3, 0.5, -8),
                BackgroundColor3 = TEXT,
                BorderSizePixel = 0,
            }, switch)
            corner(knob, 10)

            local function setValue(newValue, fireCallback)
                value = newValue == true
                tween(switch, TweenInfo.new(0.14), {
                    BackgroundColor3 = value and ORANGE_DARK or Color3.fromRGB(56, 56, 62)
                })
                tween(knob, TweenInfo.new(0.14), {
                    Position = value and UDim2.new(1, -20, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
                })
                if fireCallback and type(config.Callback) == "function" then
                    task.spawn(function()
                        local success, err = pcall(config.Callback, value)
                        if not success then warn("[Lunar Hub] Toggle callback:", err) end
                    end)
                end
            end
            switch.MouseButton1Click:Connect(function() setValue(not value, true) end)

            return {
                Set = function(_, newValue) setValue(newValue, true) end,
                Get = function() return value end,
                Row = row,
            }
        end

        if #pages == 1 then selectTab(tab) end
        return tabApi
    end

    -- Persistent floating control: hides/shows the main window, never hides itself.
    local floating = make("TextButton", {
        Name = "LunarFloatingButton",
        Size = UDim2.fromOffset(52, 52),
        Position = UDim2.new(0, 24, 0.5, -26),
        BackgroundColor3 = Color3.fromRGB(20, 14, 12),
        Text = "",
        TextColor3 = ORANGE,
        TextSize = 31,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        AutoButtonColor = true,
        ZIndex = 20,
    }, screen)
    corner(floating, 26)
    local floatingStroke = stroke(floating, ORANGE, 2, 0.05)
    floating.MouseEnter:Connect(function()
        tween(floating, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(57, 57), BackgroundColor3 = Color3.fromRGB(47, 25, 13)})
        if floatingStroke then tween(floatingStroke, TweenInfo.new(0.18), {Thickness = 3, Transparency = 0}) end
    end)
    floating.MouseLeave:Connect(function()
        tween(floating, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromOffset(52, 52), BackgroundColor3 = Color3.fromRGB(20, 14, 12)})
        if floatingStroke then tween(floatingStroke, TweenInfo.new(0.2), {Thickness = 2, Transparency = 0.05}) end
    end)
    -- O botão só anima em interações, sem movimento automático contínuo.
    local floatingIcon = make("ImageLabel", {
        Name = "LunarFloatingIcon",
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(0.72, 0.72),
        BackgroundTransparency = 1,
        Image = "rbxthumb://type=Asset&id=123816569263005&w=150&h=150",
        ScaleType = Enum.ScaleType.Fit,
        ZIndex = 21,
    }, floating)
    -- If the selected asset is not a usable thumbnail, retain the pumpkin fallback.
    local floatingFallback = make("TextLabel", {
        Name = "IconFallback",
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        Text = "🎃",
        TextSize = 30,
        Font = Enum.Font.GothamBold,
        TextColor3 = ORANGE,
        ZIndex = 20,
    }, floating)
    floatingIcon:GetPropertyChangedSignal("Image"):Connect(function() end)
    floatingIcon:GetPropertyChangedSignal("IsLoaded"):Connect(function()
        if floatingIcon.IsLoaded then floatingFallback.Visible = false end
    end)
    task.delay(2, function()
        if floatingIcon.Parent and not floatingIcon.IsLoaded then floatingFallback.Visible = true end
    end)

    local floatingDragging = false
    local floatingStart, floatingPos
    floating.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            floatingDragging = false
            floatingStart = input.Position
            floatingPos = floating.Position
            local ended
            ended = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    if ended then ended:Disconnect() end
                end
            end)
        end
    end)

    local floatingInputStart
    floating.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            floatingInputStart = input.Position
            floatingDragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if floatingInputStart and floatingPos and floatingStart
            and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - floatingStart
            if math.abs(delta.X) + math.abs(delta.Y) > 6 then floatingDragging = true end
            if floatingDragging then
                floating.Position = UDim2.new(
                    floatingPos.X.Scale, floatingPos.X.Offset + delta.X,
                    floatingPos.Y.Scale, floatingPos.Y.Offset + delta.Y
                )
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            floatingInputStart = nil
        end
    end)

    local function setVisible(visible)
        if visible then
            window.Visible = true
            window.BackgroundTransparency = 0.12
            local originalSize = window.Size
            window.Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - 18, originalSize.Y.Scale, originalSize.Y.Offset - 18)
            tween(window, TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Size = originalSize, BackgroundTransparency = 0
            })
            tween(floating, TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                Rotation = 12
            })
            task.delay(0.18, function() if floating.Parent then tween(floating, TweenInfo.new(0.18), {Rotation = 0}) end end)
        else
            local originalSize = window.Size
            tween(window, TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                BackgroundTransparency = 0.15,
                Size = UDim2.new(originalSize.X.Scale, math.max(260, originalSize.X.Offset - 12), originalSize.Y.Scale, math.max(240, originalSize.Y.Offset - 12)),
            })
            task.delay(0.14, function()
                if window.Parent then
                    window.Visible = false
                    window.Size = originalSize
                end
            end)
        end
    end

    floating.MouseButton1Click:Connect(function()
        if floatingDragging then return end
        setVisible(not window.Visible)
    end)
    hideButton.MouseButton1Click:Connect(function() setVisible(false) end)
    closeButton.MouseButton1Click:Connect(function() setVisible(false) end)

    -- Resize grip at the bottom-right corner.
    local resizeGrip = make("TextButton", {
        Name = "ResizeGrip",
        Size = UDim2.fromOffset(24, 24),
        Position = UDim2.new(1, -24, 1, -24),
        BackgroundColor3 = Color3.fromRGB(47, 26, 17),
        Text = "◢",
        TextColor3 = ORANGE,
        TextSize = 15,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        ZIndex = 5,
        AutoButtonColor = false,
    }, window)
    corner(resizeGrip, 5)

    local resizing, resizeStart, startSize = false, nil, nil
    resizeGrip.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            resizeStart = input.Position
            startSize = window.Size
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local minW, minH = 300, 280
            local maxW, maxH = 1000, 800
            local newW = math.clamp(startSize.X.Offset + delta.X, minW, maxW)
            local newH = math.clamp(startSize.Y.Offset + delta.Y, minH, maxH)
            window.Size = UDim2.fromOffset(newW, newH)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            resizing = false
        end
    end)

    addDrag(window, topbar)

    function api:SetTitle(newTitle)
        title.Text = tostring(newTitle)
    end
    function api:SetVisible(visible)
        setVisible(visible == true)
    end
    function api:Destroy()
        if screen then screen:Destroy() end
    end

    return api
end


-- Lunar Hub blank starter: trilho lateral decorativo sem abas.
local Window = LunarUI:CreateWindow({ Title = "Lunar Hub | Blox Fruits" })
Window:SetTitle("Lunar Hub | Blox Fruits")

return Window
