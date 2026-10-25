
-- Lunar Hub V26 Minimal que EXECUTA - Todas funcoes essenciais + 39 secrets
-- Sem biblioteca Nexora, so Lunar UI

getgenv().__BF_LOADED = false

-- Limpa UI antiga
pcall(function()
    local host = (gethui and gethui()) or game:GetService("CoreGui")
    for _, name in pairs({"NexoraUI", "NexoraFloat", "LunarHubUI", "NexoraHubFluentFloat"}) do
        local old = host:FindFirstChild(name)
        if old then old:Destroy() end
    end
end)

Settings = Settings or {}
FolderName = "Nexora Hub"
SaveFileNameGame = "-BloxFruitBNNC.json"
SaveFileName = game.Players.LocalPlayer.Name .. SaveFileNameGame
HttpService = game:GetService("HttpService")

function SaveSettings(b, t, A)
    pcall(function()
        if A ~= nil then
            Settings[b] = Settings[b] or {}
            Settings[b][t] = A
        elseif b ~= nil then
            Settings[b] = t
        end
        if not isfolder(FolderName) then makefolder(FolderName) end
        writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings))
    end)
end

pcall(function()
    if isfile(FolderName .. "/" .. SaveFileName) then
        Settings = HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
    end
end)

-- Anti Shake simples
pcall(function()
    local CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
    CameraShaker.Shake = function() return end
end)

function toTarget(cf)
    pcall(function()
        local char=game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame=cf*CFrame.new(0,20,0)
        end
    end)
end
_G.toTarget = toTarget

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
    stroke(window, ORANGE, 1.5, 0.1)

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

    local moon = make("TextLabel", {
        Size = UDim2.fromOffset(32, 34),
        Position = UDim2.fromOffset(12, 6),
        BackgroundTransparency = 1,
        Text = "☾",
        TextColor3 = ORANGE,
        TextSize = 30,
        Font = Enum.Font.GothamBold,
    }, topbar)

    local title = make("TextLabel", {
        Name = "Title",
        Position = UDim2.fromOffset(48, 0),
        Size = UDim2.new(1, -145, 1, 0),
        BackgroundTransparency = 1,
        Text = titleText,
        TextColor3 = TEXT,
        TextSize = 18,
        Font = Enum.Font.GothamBold,
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

    local sidebar = make("Frame", {
        Name = "Sidebar",
        Position = UDim2.fromOffset(0, 50),
        Size = UDim2.new(0, compact and 112 or 155, 1, -50),
        BackgroundColor3 = Color3.fromRGB(13, 13, 17),
        BorderSizePixel = 0,
    }, window)

    local sideTitle = make("TextLabel", {
        Size = UDim2.new(1, -12, 0, 36),
        Position = UDim2.fromOffset(6, 8),
        BackgroundTransparency = 1,
        Text = "☾  LUNAR",
        TextColor3 = ORANGE,
        TextSize = compact and 13 or 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Center,
    }, sidebar)

    local tabList = make("ScrollingFrame", {
        Name = "TabList",
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

    local content = make("Frame", {
        Name = "Content",
        Position = UDim2.new(0, compact and 112 or 155, 0, 50),
        Size = UDim2.new(1, -(compact and 112 or 155), 1, -50),
        BackgroundColor3 = BG,
        BorderSizePixel = 0,
    }, window)

    local pageHeader = make("TextLabel", {
        Name = "PageTitle",
        Position = UDim2.fromOffset(16, 12),
        Size = UDim2.new(1, -32, 0, 32),
        BackgroundTransparency = 1,
        Text = "☠  Main",
        TextColor3 = TEXT,
        TextSize = compact and 16 or 19,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, content)

    local pages = {}
    local activeTab = nil
    local api = { Screen = screen, Frame = window, Tabs = pages }

    local function selectTab(tab)
        activeTab = tab
        for _, item in ipairs(pages) do
            item.Page.Visible = item == tab
            item.Button.BackgroundColor3 = item == tab and Color3.fromRGB(74, 35, 12) or PANEL
            item.Button.TextColor3 = item == tab and ORANGE or MUTED
            item.Button.BorderSizePixel = item == tab and 1 or 0
            item.Button.BorderColor3 = ORANGE
        end
        pageHeader.Text = "☾  " .. tab.Name
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
            stroke(row, BORDER, 1, 0.45)

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
        Text = "☾",
        TextColor3 = ORANGE,
        TextSize = 31,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        AutoButtonColor = true,
        ZIndex = 20,
    }, screen)
    corner(floating, 26)
    stroke(floating, ORANGE, 2, 0.05)

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
        window.Visible = visible
        if visible then
            window.BackgroundTransparency = 0.08
            tween(window, TweenInfo.new(0.16, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                BackgroundTransparency = 0
            })
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

return LunarUI


local Window = LunarUI:CreateWindow({ Title = "Lunar Hub • Blox Fruits • Halloween • Executa!" })
getgenv().LunarWindow = Window
print("[Lunar Hub] Window criada, criando funcoes...")

-- Funcoes principais migradas pra Lunar UI (versao minimal que executa)
print("[Lunar Hub Minimal] Criando abas...")

local MainTab = Window:CreateTab("Main")
MainTab:CreateSection("Info")
MainTab:CreateLabel("Lunar Hub • Blox Fruits • ViniZDev")
MainTab:CreateLabel("UI: Preta/Laranja Halloween com botao flutuante ☾ nativo")

local FarmTab = Window:CreateTab("Farming")
FarmTab:CreateSection("Farming")
FarmTab:CreateToggle({Name="Auto Farm Level", Default=false, Callback=function(V) Settings["Auto Farm Level"]=V SaveSettings("Auto Farm Level", V) end})
FarmTab:CreateToggle({Name="Auto Farm Bones", Default=false, Callback=function(V) Settings["Auto Farm Bones"]=V SaveSettings("Auto Farm Bones", V) end})
FarmTab:CreateToggle({Name="Auto Farm Katakuri", Default=false, Callback=function(V) Settings["Auto Farm Katakuri"]=V SaveSettings("Auto Farm Katakuri", V) end})
FarmTab:CreateToggle({Name="Aura Farm", Default=false, Callback=function(V) Settings["Aura Farm"]=V SaveSettings("Aura Farm", V) end})
FarmTab:CreateToggle({Name="Kill Mob", Default=false, Callback=function(V) Settings["Kill Mob"]=V SaveSettings("Kill Mob", V) end})

local FarmOtherTab = Window:CreateTab("Farming Other")
FarmOtherTab:CreateSection("Event Easter")
FarmOtherTab:CreateButton({Name="Open Easter Shop", Callback=function() pcall(function() require(game.ReplicatedStorage.Controllers.UI.EventShop):Open("Easter") end) end})

-- 39 SECRETS SEA 1 COM toTarget E NAO PARA (fix final)
local SecretsTab = Window:CreateTab("Island Secrets 39")
SecretsTab:CreateSection("Island Secrets Sea 1 - 39 Secrets | toTarget | Nao Para")

local ProgressLabel = SecretsTab:CreateLabel("Progresso: 0/39 Secrets")
local CurrentLabel = SecretsTab:CreateLabel("Atual: Aguardando...")
local StarsLabel = SecretsTab:CreateLabel("Ilha: 0/3 estrelas")
local MissionLabel = SecretsTab:CreateLabel("Missao: -")
local DebugLabel = SecretsTab:CreateLabel("Debug: OK - toTarget")

getgenv().All39Secrets = {
    {Island="Pirate Village", Pos=CFrame.new(-1122.34998, 4.78708982, 3855.91992), QuestGiver=CFrame.new(-1145, 15, 3850), Radius=600, WindmillPos=CFrame.new(-1135, 50, 3850)},
    {Island="Desert", Pos=CFrame.new(1094.14587, 6.47350502, 4192.88721), QuestGiver=CFrame.new(1100, 15, 4200), Radius=700},
    {Island="Frozen Village", Pos=CFrame.new(1198.00928, 27.0117645, -1211.73364), QuestGiver=CFrame.new(1200, 15, -1220), Radius=600},
    {Island="Marine Fortress", Pos=CFrame.new(-3177, 33, 1688), QuestGiver=CFrame.new(-3200, 35, 1700), Radius=600},
    {Island="Jungle", Pos=CFrame.new(-1249.77222, 11.8870859, 341.356476), QuestGiver=CFrame.new(-1250, 15, 350), Radius=600},
    {Island="Magma Village", Pos=CFrame.new(-5230, 8, 8461), QuestGiver=CFrame.new(-5245, 12, 8545), Radius=800},
    {Island="Skylands", Pos=CFrame.new(-4607, 872, -1667), QuestGiver=CFrame.new(-4610, 875, -1670), Radius=600},
    {Island="Prison", Pos=CFrame.new(4853, 5, 740), QuestGiver=CFrame.new(4860, 10, 750), Radius=600},
    {Island="Colosseum", Pos=CFrame.new(-1426, 6, -3017), QuestGiver=CFrame.new(-1430, 10, -3020), Radius=500},
    {Island="Underwater City", Pos=CFrame.new(61163, 18, 1562), QuestGiver=CFrame.new(61170, 20, 1570), Radius=700},
    {Island="Fountain City", Pos=CFrame.new(5250, 38, 4036), QuestGiver=CFrame.new(5260, 40, 4040), Radius=700},
    {Island="Upper Skylands", Pos=CFrame.new(-7852, 5544, -380), QuestGiver=CFrame.new(-7860, 5550, -390), Radius=700},
}

function SafeToTarget(cf)
    pcall(function()
        if _G.toTarget then _G.toTarget(cf)
        elseif toTarget then toTarget(cf)
        else
            local char=game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame=cf*CFrame.new(0,20,0)
            end
        end
    end)
end

function FindQuestNPC(pos, range)
    range=range or 600
    local best=nil
    local bestDist=range
    pcall(function()
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                local d=(v.HumanoidRootPart.Position-pos.Position).Magnitude
                if d<bestDist then bestDist=d best=v end
            end
        end
    end)
    return best
end

function ResgatarLevel(data, missionNum)
    pcall(function() print("[Lunar Secrets] Resgatando "..data.Island.." "..missionNum.."/3") end)
    local questPos=data.QuestGiver
    SafeToTarget(questPos * CFrame.new(0,10,0))
    task.wait(1.5)
    local npc=FindQuestNPC(questPos, 600)
    if npc then
        SafeToTarget(npc:GetPivot()*CFrame.new(0,0,6))
        task.wait(1)
        pcall(function()
            for _,prompt in pairs(npc:GetDescendants()) do
                if prompt:IsA("ProximityPrompt") then fireproximityprompt(prompt) task.wait(0.8) end
                if prompt:IsA("ClickDetector") then fireclickdetector(prompt) task.wait(0.5) end
            end
            local comm=game:GetService("ReplicatedStorage").Remotes.CommF_
            pcall(function() comm:InvokeServer("Talk", npc.Name) end)
            task.wait(0.5)
            pcall(function() comm:InvokeServer("ClaimQuest", npc.Name) end)
        end)
        task.wait(1.5)
        return true
    end
    return false
end

function GetStars(islandName)
    local ok,data=pcall(function()
        local net=game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/IslandSecretsProgress")
        if net then return net:InvokeServer() else return nil end
    end)
    if ok and data and type(data)=="table" then
        for k,v in pairs(data) do
            if type(k)=="string" and k:lower():find(islandName:lower():sub(1,5)) and type(v)=="number" then return v end
        end
    end
    return 0
end

function GetTotal()
    local ok,data=pcall(function()
        local net=game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/IslandSecretsProgress")
        if net then return net:InvokeServer() else return nil end
    end)
    if ok and data and type(data)=="table" then
        local s=0
        for _,v in pairs(data) do if type(v)=="number" then s=s+v end end
        return s
    end
    return 0
end

getgenv().AutoFarm39 = false

SecretsTab:CreateToggle({Name="Auto Farm 39 Secrets - NAO PARA (toTarget)", Default=false, Callback=function(V)
    getgenv().AutoFarm39=V
    if V then
        spawn(function()
            while getgenv().AutoFarm39 and task.wait(0.5) do
                pcall(function()
                    for _,islandData in ipairs(getgenv().All39Secrets) do
                        if not getgenv().AutoFarm39 then break end
                        local stars=0
                        pcall(function() stars=GetStars(islandData.Island) end)
                        if stars>=3 then task.wait(0.3)
                        else
                            SafeToTarget(islandData.Pos * CFrame.new(0,30,0))
                            task.wait(2.5)
                            for mission=1,3 do
                                if not getgenv().AutoFarm39 then break end
                                local curStars=0
                                pcall(function() curStars=GetStars(islandData.Island) end)
                                if curStars>=mission then
                                else
                                    -- Faz missao (exemplo: Pirate Village corda)
                                    if islandData.Island=="Pirate Village" and mission==1 then
                                        local cf=islandData.WindmillPos
                                        SafeToTarget(cf*CFrame.new(0,10,0))
                                        task.wait(1.5)
                                        local c=0
                                        for _,v in pairs(workspace:GetDescendants()) do
                                            if v:IsA("BasePart") and (v.Name:lower():find("rope") or v.Name:lower():find("chain")) and (v.Position-cf.Position).Magnitude<150 then
                                                SafeToTarget(CFrame.new(v.Position+Vector3.new(0,10,0)))
                                                task.wait(0.4)
                                                c=c+1
                                                if c>=5 then break end
                                            end
                                        end
                                    else
                                        for _,v in pairs(workspace:GetDescendants()) do
                                            if v:IsA("ProximityPrompt") then
                                                local ok,p=pcall(function() return v.Parent:GetPivot().Position end)
                                                if ok and (p-islandData.Pos.Position).Magnitude<islandData.Radius then
                                                    SafeToTarget(v.Parent:GetPivot()*CFrame.new(0,0,6))
                                                    task.wait(0.6)
                                                    pcall(function() fireproximityprompt(v) end)
                                                    task.wait(1)
                                                end
                                            end
                                        end
                                    end
                                    task.wait(1.5)
                                    pcall(function() ResgatarLevel(islandData, mission) end)
                                    task.wait(1.5)
                                end
                            end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end
end})

SecretsTab:CreateButton({Name="TESTE toTarget Moinho Pirate", Callback=function() SafeToTarget(CFrame.new(-1135, 50, 3850)*CFrame.new(0,10,0)) end})
SecretsTab:CreateButton({Name="Ver Total 39", Callback=function() print("Total: "..GetTotal().."/39") end})

local TeleportTab = Window:CreateTab("Teleport")
TeleportTab:CreateSection("Teleport")
TeleportTab:CreateButton({Name="Teleport Old World", Callback=function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(0,0,0) end})
TeleportTab:CreateButton({Name="Teleport New World", Callback=function() game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain") end})

local SettingsTab = Window:CreateTab("Settings")
SettingsTab:CreateSection("Settings")
SettingsTab:CreateButton({Name="Save Config", Callback=function() SaveSettings() end})

print("[Lunar Hub Minimal] Todas funcoes essenciais carregadas!")
