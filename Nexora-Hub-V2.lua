-- ez crack skid night hub 😂
if not game:IsLoaded() then
	game.Loaded:Wait()
end

local tbl = { [2753915549] = true, [85211729168715] = true }
local tbl2 = { [4442272183] = true, [79091703265657] = true }
local tbl3 = { [7449423635] = true, [100117331123089] = true }
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
game:GetService("Lighting")
game:GetService("SoundService")
game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")
local localPlayer = Players.LocalPlayer
local placeId = game.PlaceId

if not (tbl[placeId] or tbl2[placeId] or tbl3[placeId]) then
	warn("[NightRace] This script only runs inside Blox Fruits")
	return
end

local genv = type(getgenv) == "function" and getgenv() or _G
local tbl4 = { ghoul = "Ghoul", cyborg = "Cyborg" }

local function fn(arg)
	if type(arg) ~= "string" then
		return nil
	end
	local v = string.match(arg, "^%s*(.-)%s*$")
	if v == "" then
		return nil
	end
	return tbl4[string.lower(v)]
end

local targetRace = fn(genv.Race)

if not targetRace then
	warn("[NightRace] getgenv().Race must be \"Ghoul\" or \"Cyborg\" (got: " .. tostring(genv.Race) .. ")")
	return
end

local kaitun6V4 = type(genv.Kaitun6V4) == "table" and genv.Kaitun6V4 or {}
kaitun6V4.Webhook = type(kaitun6V4.Webhook) == "table" and kaitun6V4.Webhook or {}
kaitun6V4.Webhook.Enabled = false
kaitun6V4.Account = type(kaitun6V4.Account) == "table" and kaitun6V4.Account or {}
kaitun6V4.Help = type(kaitun6V4.Help) == "table" and kaitun6V4.Help or {}
kaitun6V4.Status = type(kaitun6V4.Status) == "table" and kaitun6V4.Status or {}
genv.Kaitun6V4 = kaitun6V4
local Players2 = game:GetService("Players")
local RunService2 = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace2 = game:GetService("Workspace")
local localPlayer2 = Players2.LocalPlayer

if not localPlayer2 then
	Players2:GetPropertyChangedSignal("LocalPlayer"):Wait()
	localPlayer2 = Players2.LocalPlayer
end

local genv2 = type(getgenv) == "function" and getgenv() or _G
local kaitun6V42 = type(genv2.Kaitun6V4) == "table" and genv2.Kaitun6V4 or {}
kaitun6V42.Status = type(kaitun6V42.Status) == "table" and kaitun6V42.Status or {}
local tbl5 = {}
local colorIslandGui = nil

local tbl6 = {
	SleepWidth = 56,
	SleepDelay = 16,
	DormantWidth = 132,
	CompactWidth = 544,
	ExpandedWidth = 544,
	BarHeight = 56,
	CardHeight = 272,
	TopOffset = 16,
	MinimumScale = 0.34,
	MaximumScale = 0.52,
	HoldDuration = 1.8,
	SuccessHold = 2.6,
	ErrorHold = 3,
	CardHold = 9,
	LogLimit = 60,
	QueueLimit = 12,
	ReaderMinWidth = 280,
	ReaderMaxWidth = 860,
	ReaderMinHeight = 240,
	ReaderMaxHeight = 560,
	ReaderWidthRatio = 0.92,
	ReaderHeightRatio = 0.8,
	ReaderNarrowUnder = 520,
	ReaderRowHeight = 30,
	ReaderRowHeightNarrow = 34,
}

local tbl7 = {
	Shell = Color3.fromRGB(0, 0, 0),
	ShellTop = Color3.fromRGB(26, 26, 30),
	ShellBottom = Color3.fromRGB(4, 4, 6),
	Title = Color3.fromRGB(244, 244, 248),
	Body = Color3.fromRGB(206, 206, 214),
	Muted = Color3.fromRGB(132, 132, 142),
	Hairline = Color3.fromRGB(255, 255, 255),
	White = Color3.fromRGB(255, 255, 255),
	Black = Color3.fromRGB(0, 0, 0),
}

local tbl8 = {
	Info = { Color = Color3.fromRGB(94, 200, 255), Glyph = "Dot", Live = "Pulse", Priority = 2 },
	Debug = { Color = Color3.fromRGB(142, 142, 152), Glyph = "Dot", Live = "Pulse", Priority = 1 },
	Working = { Color = Color3.fromRGB(48, 209, 122), Glyph = "Spinner", Live = "Equalizer", Priority = 1 },
	Travel = { Color = Color3.fromRGB(58, 140, 255), Glyph = "Spinner", Live = "Stream", Priority = 1 },
	Trial = { Color = Color3.fromRGB(186, 104, 255), Glyph = "Spinner", Live = "Equalizer", Priority = 1 },
	Combat = { Color = Color3.fromRGB(255, 148, 48), Glyph = "Spinner", Live = "Equalizer", Priority = 1 },
	Waiting = { Color = Color3.fromRGB(255, 206, 42), Glyph = "Breath", Live = "Pulse", Priority = 2 },
	Warning = { Color = Color3.fromRGB(255, 206, 42), Glyph = "Bang", Live = "Pulse", Priority = 3 },
	Success = { Color = Color3.fromRGB(48, 209, 122), Glyph = "Check", Live = "Pulse", Priority = 4 },
	Error = { Color = Color3.fromRGB(255, 82, 74), Glyph = "Cross", Live = "Pulse", Priority = 5 },
}

local function fn2(arg, arg2, arg3)
	return { Value = arg, Target = arg, Velocity = 0, Stiffness = arg2, Damping = arg3 }
end

local function fn3(arg, arg2)
	local n = math.min(arg2, 0.1)

	while n > 0 do
		local n2 = math.min(0.0041666666666666666, n)
		arg.Velocity = arg.Velocity + ((arg.Target - arg.Value) * arg.Stiffness + -arg.Velocity * arg.Damping) * n2
		arg.Value = arg.Value + arg.Velocity * n2
		n -= n2
	end
end

local function createUICorner(parent, cornerRadius)
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = cornerRadius
	uiCorner.Parent = parent
	return uiCorner
end

local function createFrame(parent, name, zIndex)
	local frame = Instance.new("Frame")
	frame.Name = name
	frame.BackgroundColor3 = tbl7.White
	frame.BorderSizePixel = 0
	frame.ZIndex = zIndex or 2
	frame.Parent = parent
	return frame
end

local function createTextLabel(parent, name, font, textSize, textColor3, textXAlignment, zIndex)
	local textLabel = Instance.new("TextLabel")
	textLabel.Name = name
	textLabel.AutoLocalize = false
	textLabel.BackgroundTransparency = 1
	textLabel.Font = font
	textLabel.Text = ""
	textLabel.TextSize = textSize
	textLabel.TextColor3 = textColor3
	textLabel.TextXAlignment = textXAlignment
	textLabel.TextYAlignment = Enum.TextYAlignment.Center
	textLabel.TextTruncate = Enum.TextTruncate.AtEnd
	textLabel.ZIndex = zIndex or 4
	textLabel.Parent = parent
	return textLabel
end

local function fn4(arg, arg2, arg3)
	return arg:Lerp(arg2, arg3)
end

local function fn5(arg)
	local n = math.max(math.floor(arg), 0)
	local n2 = math.floor(n / 3600)
	local n3 = math.floor(n % 3600 / 60)
	local n4 = n % 60
	if n2 > 0 then
		return string.format("%d:%02d:%02d", n2, n3, n4)
	end
	return string.format("%02d:%02d", n3, n4)
end

local function fn6(arg, arg2, arg3)
	return string.format("%d %s", arg, arg == 1 and arg2 or arg3)
end

local function fn7()
	local ok, result = pcall(function()
		return DateTime.now():FormatLocalTime("HH:mm:ss", "en-us")
	end)

	if ok and typeof(result) == "string" then
		return result
	end
	return "--:--:--"
end

tbl5.Build = function()
	local tbl9 = {
		AccentColor = Color3.fromRGB(58, 140, 255),
		AnimationSpeed = 1,
		ReduceMotion = false,
		Transparency = 0,
	}

	for k, statu in pairs(kaitun6V42.Status) do
		tbl9[k] = statu
	end

	local flag = tbl9.ReduceMotion == true
	local n = 1

	if typeof(tbl9.AnimationSpeed) == "number" then
		n = math.clamp(tbl9.AnimationSpeed, 0.25, 3)
	end

	local backgroundTransparency = 0

	if typeof(tbl9.Transparency) == "number" then
		backgroundTransparency = math.clamp(tbl9.Transparency, 0, 0.5)
	end

	local accentColor = typeof(tbl9.AccentColor) == "Color3" and tbl9.AccentColor or Color3.fromRGB(58, 140, 255)
	local playerGui = localPlayer2:WaitForChild("PlayerGui")
	local colorIslandGui2 = playerGui:FindFirstChild("ColorIslandGui")

	if colorIslandGui2 then
		colorIslandGui2:Destroy()
	end

	local tbl10 = {}

	local tbl11 = {
		Tier = "Dormant",
		Accent = accentColor,
		Glyph = "Dot",
		Live = "Pulse",
		Destroyed = false,
		HoldToken = 0,
		CardToken = 0,
		Pinned = false,
		Clock = 0,
		SessionStart = os.clock(),
		SessionEnd = nil,
		Complete = false,
		Title = "Idle",
		Detail = "",
		Retries = 0,
		Events = 0,
		Issues = 0,
		Progress = nil,
		CurrentPriority = -1,
		ReaderOpen = false,
		ReaderWidth = tbl6.ReaderMaxWidth,
		ReaderHeight = tbl6.ReaderMaxHeight,
		ReaderRowHeight = tbl6.ReaderRowHeight,
		ReaderNarrow = false,
		ReaderOriginX = 0,
		ReaderOriginY = 0,
		ReaderOriginWidth = 80,
		ReaderTargetX = 0,
		ReaderTargetY = 0,
	}

	local tbl12 = {
		Width = fn2(tbl6.DormantWidth, 200, 26),
		Height = fn2(tbl6.BarHeight, 200, 26),
		Radius = fn2(tbl6.BarHeight / 2, 220, 30),
		TitleAlpha = fn2(0, 260, 30),
		CardAlpha = fn2(0, 240, 30),
		Press = fn2(1, 420, 26),
		Bloom = fn2(0, 160, 26),
		Progress = fn2(0, 180, 28),
		Reader = fn2(0, 240, 24),
	}

	local tbl13 = {}
	local tbl14 = {}
	local tbl15 = {}
	local flag2 = false

	local function fn8(arg)
		table.insert(tbl15, arg)
		return arg
	end

	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "ColorIslandGui"
	screenGui.DisplayOrder = 999
	screenGui.IgnoreGuiInset = true
	screenGui.AutoLocalize = false
	screenGui.ResetOnSpawn = false
	screenGui.ScreenInsets = Enum.ScreenInsets.None
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	local frame = Instance.new("Frame")
	frame.Name = "Anchor"
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.new(0.5, 0, 0, tbl6.TopOffset)
	frame.Size = UDim2.fromOffset(tbl6.CompactWidth, tbl6.BarHeight)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ZIndex = 1
	frame.Parent = screenGui
	tbl10.Scale = Instance.new("UIScale")
	tbl10.Scale.Name = "ResponsiveScale"
	tbl10.Scale.Scale = tbl6.MaximumScale
	tbl10.Scale.Parent = frame
	tbl10.Bloom = {}
	tbl10.BloomCorners = {}

	for i = 1, 5 do
		local v = createFrame(frame, "Bloom" .. i, 1)
		v.AnchorPoint = Vector2.new(0.5, 0.5)
		v.Position = UDim2.new(0.5, 0, 0, tbl6.BarHeight / 2)
		v.BackgroundTransparency = 1
		tbl10.BloomCorners[i] = createUICorner(v, UDim.new(0, 30))
		tbl10.Bloom[i] = v
	end

	tbl10.Shell = createFrame(frame, "Shell", 2)
	tbl10.Shell.AnchorPoint = Vector2.new(0.5, 0)
	tbl10.Shell.Position = UDim2.fromScale(0.5, 0)
	tbl10.Shell.BackgroundColor3 = tbl7.Shell
	tbl10.Shell.BackgroundTransparency = backgroundTransparency
	tbl10.Shell.ClipsDescendants = true
	tbl10.ShellCorner = createUICorner(tbl10.Shell, UDim.new(1, 0))
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Name = "Depth"
	local colorSequence = ColorSequence.new
	local tbl16 = {}
	local v = ColorSequenceKeypoint.new(0, tbl7.ShellTop)
	local v2 = ColorSequenceKeypoint.new(0.5, tbl7.ShellBottom)
	local new = ColorSequenceKeypoint.new
	local shell = tbl7.Shell
	tbl16[1] = v
	tbl16[2] = v2

	do
		local values = table.pack(new(1, shell))
		table.move(values, 1, values.n, 3, tbl16)
	end

	uiGradient.Color = colorSequence(tbl16)
	uiGradient.Rotation = 90
	uiGradient.Parent = tbl10.Shell
	tbl10.Stroke = Instance.new("UIStroke")
	tbl10.Stroke.Name = "Edge"
	tbl10.Stroke.Color = tbl7.White
	tbl10.Stroke.Transparency = 0.88
	tbl10.Stroke.Thickness = 1
	tbl10.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	tbl10.Stroke.Parent = tbl10.Shell
	tbl10.Wash = createFrame(tbl10.Shell, "Wash", 3)
	tbl10.Wash.Size = UDim2.fromScale(1, 1)
	tbl10.Wash.BackgroundTransparency = 1
	tbl10.WashCorner = createUICorner(tbl10.Wash, UDim.new(0, 28))
	tbl10.Hairline = createFrame(tbl10.Shell, "Hairline", 4)
	tbl10.Hairline.AnchorPoint = Vector2.new(0.5, 0)
	tbl10.Hairline.Position = UDim2.new(0.5, 0, 0, 2)
	tbl10.Hairline.Size = UDim2.new(0.62, 0, 0, 1)
	tbl10.Hairline.BackgroundTransparency = 0.55
	local uiGradient2 = Instance.new("UIGradient")
	uiGradient2.Name = "Fade"
	local numberSequence = NumberSequence.new
	local tbl17 = {}
	local v3 = NumberSequenceKeypoint.new(0, 1)
	local v4 = NumberSequenceKeypoint.new(0.5, 0)
	local new2 = NumberSequenceKeypoint.new
	tbl17[1] = v3
	tbl17[2] = v4

	do
		local values = table.pack(new2(1, 1))
		table.move(values, 1, values.n, 3, tbl17)
	end

	uiGradient2.Transparency = numberSequence(tbl17)
	uiGradient2.Parent = tbl10.Hairline
	tbl10.Content = Instance.new("Frame")
	tbl10.Content.Name = "Content"
	tbl10.Content.Size = UDim2.fromScale(1, 1)
	tbl10.Content.BackgroundTransparency = 1
	tbl10.Content.BorderSizePixel = 0
	tbl10.Content.ZIndex = 5
	tbl10.Content.Parent = tbl10.Shell
	tbl10.Header = Instance.new("Frame")
	tbl10.Header.Name = "Header"
	tbl10.Header.Size = UDim2.new(1, 0, 0, tbl6.BarHeight)
	tbl10.Header.BackgroundTransparency = 1
	tbl10.Header.BorderSizePixel = 0
	tbl10.Header.ZIndex = 5
	tbl10.Header.Parent = tbl10.Content
	tbl10.Slot = Instance.new("Frame")
	tbl10.Slot.Name = "IconSlot"
	tbl10.Slot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.Slot.Position = UDim2.fromOffset(32, tbl6.BarHeight / 2)
	tbl10.Slot.Size = UDim2.fromOffset(30, 30)
	tbl10.Slot.BackgroundTransparency = 1
	tbl10.Slot.BorderSizePixel = 0
	tbl10.Slot.ZIndex = 6
	tbl10.Slot.Parent = tbl10.Header
	tbl10.Halo = createFrame(tbl10.Slot, "Halo", 6)
	tbl10.Halo.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.Halo.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.Halo.Size = UDim2.fromOffset(30, 30)
	tbl10.Halo.BackgroundTransparency = 0.78
	createUICorner(tbl10.Halo, UDim.new(1, 0))
	tbl10.GlyphDot = createFrame(tbl10.Slot, "GlyphDot", 7)
	tbl10.GlyphDot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.GlyphDot.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.GlyphDot.Size = UDim2.fromOffset(12, 12)
	createUICorner(tbl10.GlyphDot, UDim.new(1, 0))
	tbl10.GlyphSpin = Instance.new("Frame")
	tbl10.GlyphSpin.Name = "GlyphSpin"
	tbl10.GlyphSpin.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.GlyphSpin.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.GlyphSpin.Size = UDim2.fromOffset(20, 20)
	tbl10.GlyphSpin.BackgroundTransparency = 1
	tbl10.GlyphSpin.BorderSizePixel = 0
	tbl10.GlyphSpin.ZIndex = 7
	tbl10.GlyphSpin.Parent = tbl10.Slot
	tbl10.SpinRing = createFrame(tbl10.GlyphSpin, "Ring", 7)
	tbl10.SpinRing.Size = UDim2.fromScale(1, 1)
	tbl10.SpinRing.BackgroundTransparency = 1
	createUICorner(tbl10.SpinRing, UDim.new(1, 0))
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = "RingStroke"
	uiStroke.Thickness = 2
	uiStroke.Transparency = 0.72
	uiStroke.Parent = tbl10.SpinRing
	tbl10.SpinStroke = uiStroke
	tbl10.SpinHead = createFrame(tbl10.GlyphSpin, "Head", 8)
	tbl10.SpinHead.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.SpinHead.Position = UDim2.fromScale(0.5, 0)
	tbl10.SpinHead.Size = UDim2.fromOffset(6, 6)
	createUICorner(tbl10.SpinHead, UDim.new(1, 0))
	tbl10.GlyphCheck = Instance.new("Frame")
	tbl10.GlyphCheck.Name = "GlyphCheck"
	tbl10.GlyphCheck.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.GlyphCheck.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.GlyphCheck.Size = UDim2.fromOffset(20, 20)
	tbl10.GlyphCheck.BackgroundTransparency = 1
	tbl10.GlyphCheck.BorderSizePixel = 0
	tbl10.GlyphCheck.ZIndex = 7
	tbl10.GlyphCheck.Parent = tbl10.Slot
	tbl10.CheckShort = createFrame(tbl10.GlyphCheck, "Short", 8)
	tbl10.CheckShort.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.CheckShort.Position = UDim2.fromOffset(6, 12)
	tbl10.CheckShort.Size = UDim2.fromOffset(8, 2.5)
	tbl10.CheckShort.Rotation = 45
	createUICorner(tbl10.CheckShort, UDim.new(1, 0))
	tbl10.CheckLong = createFrame(tbl10.GlyphCheck, "Long", 8)
	tbl10.CheckLong.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.CheckLong.Position = UDim2.fromOffset(12, 9)
	tbl10.CheckLong.Size = UDim2.fromOffset(15, 2.5)
	tbl10.CheckLong.Rotation = -45
	createUICorner(tbl10.CheckLong, UDim.new(1, 0))
	tbl10.GlyphCross = Instance.new("Frame")
	tbl10.GlyphCross.Name = "GlyphCross"
	tbl10.GlyphCross.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.GlyphCross.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.GlyphCross.Size = UDim2.fromOffset(20, 20)
	tbl10.GlyphCross.BackgroundTransparency = 1
	tbl10.GlyphCross.BorderSizePixel = 0
	tbl10.GlyphCross.ZIndex = 7
	tbl10.GlyphCross.Parent = tbl10.Slot

	for i = 1, 2 do
		local v5 = createFrame(tbl10.GlyphCross, "Stroke" .. i, 8)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.fromScale(0.5, 0.5)
		v5.Size = UDim2.fromOffset(15, 2.5)
		v5.Rotation = i == 1 and 45 or -45
		createUICorner(v5, UDim.new(1, 0))
	end

	tbl10.GlyphBang = Instance.new("Frame")
	tbl10.GlyphBang.Name = "GlyphBang"
	tbl10.GlyphBang.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.GlyphBang.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.GlyphBang.Size = UDim2.fromOffset(20, 20)
	tbl10.GlyphBang.BackgroundTransparency = 1
	tbl10.GlyphBang.BorderSizePixel = 0
	tbl10.GlyphBang.ZIndex = 7
	tbl10.GlyphBang.Parent = tbl10.Slot
	tbl10.BangStem = createFrame(tbl10.GlyphBang, "Stem", 8)
	tbl10.BangStem.AnchorPoint = Vector2.new(0.5, 0)
	tbl10.BangStem.Position = UDim2.fromOffset(10, 3)
	tbl10.BangStem.Size = UDim2.fromOffset(2.5, 9)
	createUICorner(tbl10.BangStem, UDim.new(1, 0))
	tbl10.BangDot = createFrame(tbl10.GlyphBang, "Tip", 8)
	tbl10.BangDot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.BangDot.Position = UDim2.fromOffset(10, 16)
	tbl10.BangDot.Size = UDim2.fromOffset(2.5, 2.5)
	createUICorner(tbl10.BangDot, UDim.new(1, 0))

	tbl10.Glyphs = {
		Dot = tbl10.GlyphDot,
		Breath = tbl10.GlyphDot,
		Spinner = tbl10.GlyphSpin,
		Check = tbl10.GlyphCheck,
		Cross = tbl10.GlyphCross,
		Bang = tbl10.GlyphBang,
	}

	tbl10.TitleClip = Instance.new("CanvasGroup")
	tbl10.TitleClip.Name = "TitleClip"
	tbl10.TitleClip.Position = UDim2.fromOffset(58, 10)
	tbl10.TitleClip.Size = UDim2.new(1, -150, 0, 22)
	tbl10.TitleClip.BackgroundTransparency = 1
	tbl10.TitleClip.GroupTransparency = 1
	tbl10.TitleClip.BorderSizePixel = 0
	tbl10.TitleClip.ClipsDescendants = true
	tbl10.TitleClip.ZIndex = 6
	tbl10.TitleClip.Parent = tbl10.Header
	tbl10.TitleA = createTextLabel(tbl10.TitleClip, "TitleA", Enum.Font.GothamBold, 17, tbl7.Title, Enum.TextXAlignment.Left, 6)
	tbl10.TitleA.Size = UDim2.fromScale(1, 1)
	tbl10.TitleB = createTextLabel(tbl10.TitleClip, "TitleB", Enum.Font.GothamBold, 17, tbl7.Title, Enum.TextXAlignment.Left, 6)
	tbl10.TitleB.Size = UDim2.fromScale(1, 1)
	tbl10.TitleB.TextTransparency = 1
	tbl10.ActiveTitle = tbl10.TitleA
	tbl10.Detail = createTextLabel(tbl10.Header, "Detail", Enum.Font.GothamMedium, 13, tbl7.Muted, Enum.TextXAlignment.Left, 6)
	tbl10.Detail.Position = UDim2.fromOffset(58, 31)
	tbl10.Detail.Size = UDim2.new(1, -150, 0, 15)
	tbl10.Trail = Instance.new("Frame")
	tbl10.Trail.Name = "Trail"
	tbl10.Trail.AnchorPoint = Vector2.new(1, 0.5)
	tbl10.Trail.Position = UDim2.new(1, -22, 0, tbl6.BarHeight / 2)
	tbl10.Trail.Size = UDim2.fromOffset(58, 30)
	tbl10.Trail.BackgroundTransparency = 1
	tbl10.Trail.BorderSizePixel = 0
	tbl10.Trail.ZIndex = 6
	tbl10.Trail.Parent = tbl10.Header
	tbl10.Bars = {}

	for i = 1, 4 do
		local v5 = createFrame(tbl10.Trail, "Bar" .. i, 7)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.new(1, -6 - (4 - i) * 9, 0.5, 0)
		v5.Size = UDim2.fromOffset(3.5, 10)
		createUICorner(v5, UDim.new(1, 0))
		tbl10.Bars[i] = v5
	end

	tbl10.Pulse = createFrame(tbl10.Trail, "Pulse", 7)
	tbl10.Pulse.AnchorPoint = Vector2.new(1, 0.5)
	tbl10.Pulse.Position = UDim2.new(1, 0, 0.5, 0)
	tbl10.Pulse.Size = UDim2.fromOffset(8, 8)
	tbl10.Pulse.BackgroundTransparency = 1
	createUICorner(tbl10.Pulse, UDim.new(1, 0))
	tbl10.Pips = {}

	for i = 1, 3 do
		local v5 = createFrame(tbl10.Header, "Pip" .. i, 7)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.new(1, -22 - (3 - i) * 7, 0, 12)
		v5.Size = UDim2.fromOffset(3.5, 3.5)
		v5.BackgroundTransparency = 1
		createUICorner(v5, UDim.new(1, 0))
		tbl10.Pips[i] = v5
	end

	tbl10.Track = createFrame(tbl10.Header, "Track", 6)
	tbl10.Track.Position = UDim2.fromOffset(58, 48)
	tbl10.Track.Size = UDim2.new(1, -80, 0, 2)
	tbl10.Track.BackgroundColor3 = Color3.fromRGB(52, 52, 58)
	tbl10.Track.BackgroundTransparency = 1
	tbl10.Track.ClipsDescendants = true
	createUICorner(tbl10.Track, UDim.new(1, 0))
	tbl10.Fill = createFrame(tbl10.Track, "Fill", 7)
	tbl10.Fill.Position = UDim2.fromScale(0, 0)
	tbl10.Fill.Size = UDim2.fromScale(0, 1)
	tbl10.Fill.BackgroundTransparency = 1
	createUICorner(tbl10.Fill, UDim.new(1, 0))
	tbl10.Comet = createFrame(tbl10.Track, "Comet", 7)
	tbl10.Comet.Position = UDim2.fromScale(-0.35, 0)
	tbl10.Comet.Size = UDim2.fromScale(0.35, 1)
	tbl10.Comet.BackgroundTransparency = 1
	createUICorner(tbl10.Comet, UDim.new(1, 0))
	local uiGradient3 = Instance.new("UIGradient")
	uiGradient3.Name = "Fade"
	local numberSequence2 = NumberSequence.new
	local tbl18 = {}
	local v5 = NumberSequenceKeypoint.new(0, 1)
	local v6 = NumberSequenceKeypoint.new(0.5, 0)
	local new3 = NumberSequenceKeypoint.new
	tbl18[1] = v5
	tbl18[2] = v6

	do
		local values = table.pack(new3(1, 1))
		table.move(values, 1, values.n, 3, tbl18)
	end

	uiGradient3.Transparency = numberSequence2(tbl18)
	uiGradient3.Parent = tbl10.Comet
	tbl10.Card = Instance.new("CanvasGroup")
	tbl10.Card.Name = "Card"
	tbl10.Card.Position = UDim2.fromOffset(26, tbl6.BarHeight + 8)
	tbl10.Card.Size = UDim2.new(1, -52, 0, tbl6.CardHeight - tbl6.BarHeight - 24)
	tbl10.Card.BackgroundTransparency = 1
	tbl10.Card.GroupTransparency = 1
	tbl10.Card.BorderSizePixel = 0
	tbl10.Card.Visible = false
	tbl10.Card.ZIndex = 6
	tbl10.Card.Parent = tbl10.Content
	local rule = createFrame(tbl10.Card, "Rule", 6)
	rule.Size = UDim2.new(1, 0, 0, 1)
	rule.BackgroundTransparency = 0.9
	tbl10.Rows = {}

	for i = 1, 3 do
		local frame2 = Instance.new("Frame")
		frame2.Name = "Row" .. i
		frame2.Position = UDim2.fromOffset(0, 12 + (i - 1) * 32)
		frame2.Size = UDim2.new(1, 0, 0, 28)
		frame2.BackgroundTransparency = 1
		frame2.BorderSizePixel = 0
		frame2.Visible = false
		frame2.ZIndex = 6
		frame2.Parent = tbl10.Card
		local marker = createFrame(frame2, "Marker", 7)
		marker.AnchorPoint = Vector2.new(0.5, 0.5)
		marker.Position = UDim2.fromOffset(4, 14)
		marker.Size = UDim2.fromOffset(6, 6)
		createUICorner(marker, UDim.new(1, 0))
		local message = createTextLabel(frame2, "Message", Enum.Font.GothamMedium, 14, tbl7.Body, Enum.TextXAlignment.Left, 7)
		message.Position = UDim2.fromOffset(20, 0)
		message.Size = UDim2.new(1, -96, 1, 0)
		local stamp = createTextLabel(frame2, "Stamp", Enum.Font.Gotham, 12, tbl7.Muted, Enum.TextXAlignment.Right, 7)
		stamp.Position = UDim2.new(1, -72, 0, 0)
		stamp.Size = UDim2.fromOffset(72, 28)
		tbl10.Rows[i] = { Frame = frame2, Marker = marker, Message = message, Stamp = stamp }
	end

	tbl10.Empty = createTextLabel(tbl10.Card, "Empty", Enum.Font.GothamMedium, 14, tbl7.Muted, Enum.TextXAlignment.Center, 7)
	tbl10.Empty.Position = UDim2.fromOffset(0, 30)
	tbl10.Empty.Size = UDim2.new(1, 0, 0, 28)
	tbl10.Empty.Text = "No activity yet"
	tbl10.Stats = createTextLabel(tbl10.Card, "Stats", Enum.Font.Gotham, 12, tbl7.Muted, Enum.TextXAlignment.Left, 7)
	tbl10.Stats.Position = UDim2.fromOffset(2, 112)
	tbl10.Stats.Size = UDim2.new(1, -4, 0, 16)

	local function createTextButton(name, anchorPoint, position, text)
		local textButton = Instance.new("TextButton")
		textButton.Name = name
		textButton.AutoLocalize = false
		textButton.AnchorPoint = anchorPoint
		textButton.Position = position
		textButton.Size = UDim2.fromOffset(150, 30)
		textButton.BackgroundColor3 = tbl7.White
		textButton.BackgroundTransparency = 0.9
		textButton.AutoButtonColor = false
		textButton.Font = Enum.Font.GothamMedium
		textButton.Text = text
		textButton.TextSize = 13
		textButton.TextColor3 = tbl7.Body
		textButton.BorderSizePixel = 0
		textButton.ZIndex = 8
		textButton.Parent = tbl10.Card
		createUICorner(textButton, UDim.new(1, 0))
		return textButton
	end

	tbl10.Pin = createTextButton("Pin", Vector2.new(0, 1), UDim2.new(0, 0, 1, 0), "Keep open")
	tbl10.Open = createTextButton("Open", Vector2.new(0.5, 1), UDim2.new(0.5, 0, 1, 0), "Read full log")
	tbl10.Clear = createTextButton("Clear", Vector2.new(1, 1), UDim2.new(1, 0, 1, 0), "Clear")
	tbl10.ReaderRoot = Instance.new("Frame")
	tbl10.ReaderRoot.Name = "ReaderRoot"
	tbl10.ReaderRoot.Size = UDim2.fromScale(1, 1)
	tbl10.ReaderRoot.BackgroundTransparency = 1
	tbl10.ReaderRoot.BorderSizePixel = 0
	tbl10.ReaderRoot.Visible = false
	tbl10.ReaderRoot.ZIndex = 50
	tbl10.ReaderRoot.Parent = screenGui
	tbl10.ReaderDim = Instance.new("TextButton")
	tbl10.ReaderDim.Name = "Dim"
	tbl10.ReaderDim.AutoLocalize = false
	tbl10.ReaderDim.Size = UDim2.fromScale(1, 1)
	tbl10.ReaderDim.BackgroundColor3 = tbl7.Black
	tbl10.ReaderDim.BackgroundTransparency = 1
	tbl10.ReaderDim.AutoButtonColor = false
	tbl10.ReaderDim.Text = ""
	tbl10.ReaderDim.BorderSizePixel = 0
	tbl10.ReaderDim.ZIndex = 50
	tbl10.ReaderDim.Parent = tbl10.ReaderRoot
	tbl10.Reader = Instance.new("CanvasGroup")
	tbl10.Reader.Name = "Reader"
	tbl10.Reader.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.Reader.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.Reader.Size = UDim2.fromOffset(tbl11.ReaderWidth, tbl11.ReaderHeight)
	tbl10.Reader.BackgroundColor3 = Color3.fromRGB(11, 11, 13)
	tbl10.Reader.GroupTransparency = 1
	tbl10.Reader.BorderSizePixel = 0
	tbl10.Reader.ZIndex = 51
	tbl10.Reader.Parent = tbl10.ReaderRoot
	createUICorner(tbl10.Reader, UDim.new(0, 26))
	tbl10.ReaderScale = Instance.new("UIScale")
	tbl10.ReaderScale.Name = "ReaderScale"
	tbl10.ReaderScale.Scale = 1
	tbl10.ReaderScale.Parent = tbl10.Reader
	local uiStroke2 = Instance.new("UIStroke")
	uiStroke2.Color = tbl7.White
	uiStroke2.Transparency = 0.9
	uiStroke2.Thickness = 1
	uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke2.Parent = tbl10.Reader
	tbl10.ReaderTitle = createTextLabel(tbl10.Reader, "Title", Enum.Font.GothamBold, 20, tbl7.Title, Enum.TextXAlignment.Left, 52)
	tbl10.ReaderTitle.Position = UDim2.fromOffset(28, 22)
	tbl10.ReaderTitle.Size = UDim2.new(1, -140, 0, 26)
	tbl10.ReaderTitle.Text = "Log"
	tbl10.ReaderCount = createTextLabel(tbl10.Reader, "Count", Enum.Font.GothamMedium, 13, tbl7.Muted, Enum.TextXAlignment.Left, 52)
	tbl10.ReaderCount.Position = UDim2.fromOffset(28, 48)
	tbl10.ReaderCount.Size = UDim2.new(1, -140, 0, 18)
	tbl10.ReaderClose = Instance.new("TextButton")
	tbl10.ReaderClose.Name = "Close"
	tbl10.ReaderClose.AutoLocalize = false
	tbl10.ReaderClose.AnchorPoint = Vector2.new(1, 0)
	tbl10.ReaderClose.Position = UDim2.new(1, -24, 0, 24)
	tbl10.ReaderClose.Size = UDim2.fromOffset(88, 32)
	tbl10.ReaderClose.BackgroundColor3 = tbl7.White
	tbl10.ReaderClose.BackgroundTransparency = 0.9
	tbl10.ReaderClose.AutoButtonColor = false
	tbl10.ReaderClose.Font = Enum.Font.GothamMedium
	tbl10.ReaderClose.Text = "Close"
	tbl10.ReaderClose.TextSize = 13
	tbl10.ReaderClose.TextColor3 = tbl7.Body
	tbl10.ReaderClose.BorderSizePixel = 0
	tbl10.ReaderClose.ZIndex = 53
	tbl10.ReaderClose.Parent = tbl10.Reader
	createUICorner(tbl10.ReaderClose, UDim.new(1, 0))
	tbl10.ReaderRule = createFrame(tbl10.Reader, "Rule", 52)
	tbl10.ReaderRule.Position = UDim2.fromOffset(28, 76)
	tbl10.ReaderRule.Size = UDim2.new(1, -56, 0, 1)
	tbl10.ReaderRule.BackgroundTransparency = 0.9
	tbl10.ReaderList = Instance.new("ScrollingFrame")
	tbl10.ReaderList.Name = "List"
	tbl10.ReaderList.Position = UDim2.fromOffset(24, 88)
	tbl10.ReaderList.Size = UDim2.new(1, -48, 1, -128)
	tbl10.ReaderList.BackgroundTransparency = 1
	tbl10.ReaderList.BorderSizePixel = 0
	tbl10.ReaderList.ScrollBarThickness = 3
	tbl10.ReaderList.ScrollBarImageColor3 = tbl7.White
	tbl10.ReaderList.ScrollBarImageTransparency = 0.7
	tbl10.ReaderList.CanvasSize = UDim2.new()
	tbl10.ReaderList.ZIndex = 52
	tbl10.ReaderList.Parent = tbl10.Reader
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Vertical
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Padding = UDim.new(0, 2)
	uiListLayout.Parent = tbl10.ReaderList
	tbl10.ReaderFoot = createTextLabel(tbl10.Reader, "Foot", Enum.Font.Gotham, 12, tbl7.Muted, Enum.TextXAlignment.Left, 52)
	tbl10.ReaderFoot.AnchorPoint = Vector2.new(0, 1)
	tbl10.ReaderFoot.Position = UDim2.new(0, 28, 1, -16)
	tbl10.ReaderFoot.Size = UDim2.new(1, -56, 0, 16)
	tbl10.ReaderEmpty = createTextLabel(tbl10.Reader, "Empty", Enum.Font.GothamMedium, 15, tbl7.Muted, Enum.TextXAlignment.Center, 52)
	tbl10.ReaderEmpty.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl10.ReaderEmpty.Position = UDim2.fromScale(0.5, 0.5)
	tbl10.ReaderEmpty.Size = UDim2.new(1, 0, 0, 24)
	tbl10.ReaderEmpty.Text = "No activity yet"
	tbl10.ReaderRows = {}
	tbl10.Tap = Instance.new("TextButton")
	tbl10.Tap.Name = "Tap"
	tbl10.Tap.AutoLocalize = false
	tbl10.Tap.Size = UDim2.new(1, 0, 0, tbl6.BarHeight)
	tbl10.Tap.BackgroundTransparency = 1
	tbl10.Tap.Text = ""
	tbl10.Tap.AutoButtonColor = false
	tbl10.Tap.ZIndex = 9
	tbl10.Tap.Parent = tbl10.Shell
	local tbl19 = {}

	for _, v7 in ipairs({
		"UpdateStatus",
		"AddLog",
		"UpdateCurrentStep",
		"UpdateRetry",
		"UpdateRecovery",
		"CompleteSession",
		"ResetSession",
		"UpdateTheme",
		"UpdateProgress",
		"DestroyUI",
	}) do
		local bindableEvent = Instance.new("BindableEvent")
		bindableEvent.Name = v7
		bindableEvent.Parent = screenGui
		tbl19[v7] = bindableEvent
	end

	screenGui.Parent = playerGui

	local function fn9(arg)
		if typeof(arg) == "string" and tbl8[arg] then
			return arg
		end
		return "Working"
	end

	local function fn10(arg)
		if arg == "Sleep" then
			return tbl6.SleepWidth, tbl6.BarHeight, tbl6.BarHeight / 2, 0, 0
		end

		if arg == "Dormant" then
			return tbl6.DormantWidth, tbl6.BarHeight, tbl6.BarHeight / 2, 0, 0
		end

		if arg == "Compact" then
			return tbl6.CompactWidth, tbl6.BarHeight, tbl6.BarHeight / 2, 1, 0
		end
		return tbl6.ExpandedWidth, tbl6.CardHeight, 28, 1, 1
	end

	local function fn11(arg)
		local damping = arg and 24 or 34
		tbl12.Width.Damping = damping
		tbl12.Height.Damping = damping
	end

	local function fn12(tier, arg)
		if tbl11.Destroyed then
			return
		end
		local v7, v8, v9, v10, v11 = fn10(tier)
		tbl11.Tier = tier
		fn11(v7 > tbl12.Width.Value or v8 > tbl12.Height.Value)
		tbl12.Width.Target = v7
		tbl12.Height.Target = v8
		tbl12.Radius.Target = v9
		tbl12.TitleAlpha.Target = v10
		tbl12.CardAlpha.Target = v11

		if v11 > 0 then
			tbl10.Card.Visible = true
		end

		if arg or flag then
			for _, v12 in pairs(tbl12) do
				v12.Value = v12.Target
				v12.Velocity = 0
			end
		end
	end

	local function fn13(arg)
		tbl11.HoldToken = tbl11.HoldToken + 1
		local holdToken = tbl11.HoldToken

		local function fn14()
			return not tbl11.Destroyed and holdToken == tbl11.HoldToken and tbl11.Tier ~= "Expanded" and not tbl11.Pinned
		end

		task.delay(arg / n, function()
			if not fn14() then
				return
			end
			fn12("Dormant")

			task.delay(tbl6.SleepDelay / n, function()
				if fn14() then
					fn12("Sleep")
				end
			end)
		end)
	end

	local function fn14()
		tbl11.CardToken = tbl11.CardToken + 1
		local cardToken = tbl11.CardToken

		task.delay(tbl6.CardHold / n, function()
			if tbl11.Destroyed or cardToken ~= tbl11.CardToken or tbl11.Tier ~= "Expanded" or tbl11.Pinned then
				return
			end
			fn12("Dormant")
		end)
	end

	local function fn15()
		tbl11.CardToken = tbl11.CardToken + 1
	end

	local function fn16(accent)
		tbl11.Accent = accent
		tbl10.Halo.BackgroundColor3 = accent
		tbl10.GlyphDot.BackgroundColor3 = accent
		tbl10.SpinStroke.Color = accent
		tbl10.SpinHead.BackgroundColor3 = fn4(accent, tbl7.White, 0.5)
		tbl10.CheckShort.BackgroundColor3 = accent
		tbl10.CheckLong.BackgroundColor3 = accent
		tbl10.BangStem.BackgroundColor3 = accent
		tbl10.BangDot.BackgroundColor3 = accent
		tbl10.Wash.BackgroundColor3 = accent
		tbl10.Pulse.BackgroundColor3 = accent
		tbl10.Fill.BackgroundColor3 = fn4(accent, tbl7.White, 0.2)
		tbl10.Comet.BackgroundColor3 = fn4(accent, tbl7.White, 0.35)
		tbl10.Pin.TextColor3 = fn4(accent, tbl7.White, 0.5)

		for _, child in ipairs(tbl10.GlyphCross:GetChildren()) do
			if child:IsA("Frame") then
				child.BackgroundColor3 = accent
			end
		end

		for _, bar in ipairs(tbl10.Bars) do
			bar.BackgroundColor3 = accent
		end

		for _, v7 in ipairs(tbl10.Bloom) do
			v7.BackgroundColor3 = accent
		end
	end

	local function fn17(glyph)
		tbl11.Glyph = glyph

		for _, glyph2 in pairs(tbl10.Glyphs) do
			glyph2.Visible = false
		end
		;(tbl10.Glyphs[glyph] or tbl10.GlyphDot).Visible = true
	end

	local function fn18(text)
		local activeTitle = tbl10.ActiveTitle
		local titleB = activeTitle == tbl10.TitleA and tbl10.TitleB or tbl10.TitleA
		titleB.Text = text
		tbl10.ActiveTitle = titleB

		if flag then
			titleB.Position = UDim2.fromOffset(0, 0)
			titleB.TextTransparency = 0
			activeTitle.TextTransparency = 1
			return
		end

		titleB.Position = UDim2.fromOffset(0, 14)
		titleB.TextTransparency = 1
		TweenService:Create(titleB, TweenInfo.new(0.26 / n, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Position = UDim2.fromOffset(0, 0), TextTransparency = 0 }):Play()
		local v7
		TweenService:Create(activeTitle, v7, { Position = UDim2.fromOffset(0, -14), TextTransparency = 1 }):Play()
	end

	local function fn19()
		local n2 = math.min(#tbl14, 3)

		for i, pip in ipairs(tbl10.Pips) do
			pip.BackgroundColor3 = tbl11.Accent
			pip.BackgroundTransparency = i <= n2 and 0.25 or 1
		end
	end

	local function fn20()
		local n2 = #tbl13

		for i, row in ipairs(tbl10.Rows) do
			local v7 = tbl13[n2 - i + 1]

			if v7 then
				local message = v7.Message

				if v7.Count > 1 then
					message ..= "  (" .. tostring(v7.Count) .. ")"
				end

				row.Marker.BackgroundColor3 = v7.Colour
				row.Message.Text = message
				row.Stamp.Text = v7.Stamp
				row.Frame.Visible = true
			else
				row.Frame.Visible = false
			end
		end

		tbl10.Empty.Visible = n2 == 0
		local sessionEnd = tbl11.SessionEnd or os.clock()
		local retries = tbl11.Retries
		tbl10.Stats.Text = string.format("Elapsed %s   |   %s   |   %s   |   %s", fn5(sessionEnd - tbl11.SessionStart), fn6(tbl11.Events, "event", "events"), fn6(tbl11.Issues, "issue", "issues"), fn6(retries, "retry", "retries"))
	end

	local function fn21(arg)
		local readerNarrow = tbl11.ReaderNarrow
		local readerRowHeight = tbl11.ReaderRowHeight
		arg.Frame.Size = UDim2.new(1, -8, 0, readerRowHeight)
		arg.Marker.Position = UDim2.fromOffset(readerNarrow and 14 or 16, readerRowHeight / 2)
		arg.Stamp.Position = UDim2.fromOffset(readerNarrow and 26 or 32, 0)
		arg.Stamp.Size = UDim2.fromOffset(readerNarrow and 62 or 74, readerRowHeight)
		arg.Stamp.TextSize = readerNarrow and 12 or 13
		arg.Kind.Visible = not readerNarrow
		arg.Kind.Position = UDim2.fromOffset(110, 0)
		arg.Kind.Size = UDim2.fromOffset(74, readerRowHeight)
		arg.Message.Position = UDim2.fromOffset(readerNarrow and 94 or 190, 0)
		arg.Message.Size = UDim2.new(1, readerNarrow and -104 or -206, 0, readerRowHeight)
		arg.Message.TextSize = readerNarrow and 13 or 14
	end

	local function fn22()
		local readerNarrow = tbl11.ReaderNarrow
		tbl10.ReaderTitle.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 15 or 22)
		tbl10.ReaderTitle.Size = UDim2.new(1, readerNarrow and -110 or -140, 0, 26)
		tbl10.ReaderTitle.TextSize = readerNarrow and 17 or 20
		tbl10.ReaderCount.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 38 or 48)
		tbl10.ReaderCount.Size = UDim2.new(1, readerNarrow and -110 or -140, 0, 18)
		tbl10.ReaderClose.Position = UDim2.new(1, readerNarrow and -16 or -24, 0, readerNarrow and 16 or 24)
		tbl10.ReaderClose.Size = UDim2.fromOffset(readerNarrow and 70 or 88, readerNarrow and 28 or 32)
		tbl10.ReaderRule.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 62 or 76)
		tbl10.ReaderRule.Size = UDim2.new(1, readerNarrow and -36 or -56, 0, 1)
		tbl10.ReaderList.Position = UDim2.fromOffset(readerNarrow and 14 or 24, readerNarrow and 72 or 88)
		tbl10.ReaderList.Size = UDim2.new(1, readerNarrow and -28 or -48, 1, readerNarrow and -104 or -128)
		tbl10.ReaderFoot.Position = UDim2.new(0, readerNarrow and 18 or 28, 1, readerNarrow and -12 or -16)
		tbl10.ReaderFoot.Size = UDim2.new(1, readerNarrow and -36 or -56, 0, 16)
		tbl10.ReaderFoot.TextSize = readerNarrow and 11 or 12

		for _, readerRow in ipairs(tbl10.ReaderRows) do
			fn21(readerRow)
		end
	end

	local function fn23(layoutOrder)
		local v7 = tbl10.ReaderRows[layoutOrder]
		if v7 then
			return v7
		end
		local frame2 = Instance.new("Frame")
		frame2.Name = "Entry" .. layoutOrder
		frame2.BackgroundColor3 = tbl7.White
		frame2.BackgroundTransparency = 0.97
		frame2.BorderSizePixel = 0
		frame2.LayoutOrder = layoutOrder
		frame2.ZIndex = 52
		frame2.Parent = tbl10.ReaderList
		createUICorner(frame2, UDim.new(0, 8))
		local marker = createFrame(frame2, "Marker", 53)
		marker.AnchorPoint = Vector2.new(0.5, 0.5)
		marker.Position = UDim2.fromOffset(16, tbl6.ReaderRowHeight / 2)
		marker.Size = UDim2.fromOffset(7, 7)
		createUICorner(marker, UDim.new(1, 0))
		local stamp = createTextLabel(frame2, "Stamp", Enum.Font.Gotham, 13, tbl7.Muted, Enum.TextXAlignment.Left, 53)
		stamp.Position = UDim2.fromOffset(32, 0)
		stamp.Size = UDim2.fromOffset(74, tbl6.ReaderRowHeight)
		local kind = createTextLabel(frame2, "Kind", Enum.Font.GothamMedium, 13, tbl7.Muted, Enum.TextXAlignment.Left, 53)
		kind.Position = UDim2.fromOffset(110, 0)
		kind.Size = UDim2.fromOffset(74, tbl6.ReaderRowHeight)
		local message = createTextLabel(frame2, "Message", Enum.Font.GothamMedium, 14, tbl7.Body, Enum.TextXAlignment.Left, 53)
		message.Position = UDim2.fromOffset(190, 0)
		message.Size = UDim2.new(1, -206, 0, tbl6.ReaderRowHeight)
		local tbl20 = { Frame = frame2, Marker = marker, Stamp = stamp, Kind = kind, Message = message }
		tbl10.ReaderRows[layoutOrder] = tbl20
		fn21(tbl20)
		return tbl20
	end

	local function fn24()
		local n2 = #tbl13

		for i = 1, n2 do
			local v7 = tbl13[n2 - i + 1]
			local v8 = fn23(i)
			local message = v7.Message

			if v7.Count > 1 then
				message ..= "  (" .. tostring(v7.Count) .. ")"
			end

			v8.Marker.BackgroundColor3 = v7.Colour
			v8.Stamp.Text = v7.Stamp
			v8.Kind.Text = v7.Kind
			v8.Kind.TextColor3 = v7.Colour
			v8.Message.Text = message
			v8.Frame.Visible = true
		end

		for i = n2 + 1, #tbl10.ReaderRows do
			tbl10.ReaderRows[i].Frame.Visible = false
		end

		tbl10.ReaderList.CanvasSize = UDim2.fromOffset(0, n2 * (tbl11.ReaderRowHeight + 2))
		tbl10.ReaderEmpty.Visible = n2 == 0
		tbl10.ReaderCount.Text = fn6(n2, "entry", "entries")
		local sessionEnd = tbl11.SessionEnd or os.clock()
		local retries = tbl11.Retries
		tbl10.ReaderFoot.Text = string.format("Elapsed %s   |   %s   |   %s   |   %s", fn5(sessionEnd - tbl11.SessionStart), fn6(tbl11.Events, "event", "events"), fn6(tbl11.Issues, "issue", "issues"), fn6(retries, "retry", "retries"))
	end

	local function fn25(readerOpen)
		if tbl11.Destroyed or tbl11.ReaderOpen == readerOpen then
			return
		end
		tbl11.ReaderOpen = readerOpen

		if readerOpen then
			local absolutePosition = tbl10.Open.AbsolutePosition
			local absoluteSize = tbl10.Open.AbsoluteSize
			tbl11.ReaderOriginX = absolutePosition.X + absoluteSize.X / 2
			tbl11.ReaderOriginY = absolutePosition.Y + absoluteSize.Y / 2
			tbl11.ReaderOriginWidth = math.max(absoluteSize.X, 8)
			fn24()
			tbl10.ReaderRoot.Visible = true
			tbl10.ReaderList.CanvasPosition = Vector2.new(0, 0)
			tbl12.Reader.Target = 1
			tbl11.Pinned = false
			tbl10.Pin.Text = "Keep open"
			fn15()
			fn12("Sleep")
		else
			tbl12.Reader.Target = 0
			fn13(0.25)
		end
	end

	local function fn26(arg)
		if flag then
			return
		end
		tbl10.Wash.BackgroundTransparency = (arg == "Error" or arg == "Success") and 0.82 or 0.92
		TweenService:Create(tbl10.Wash, TweenInfo.new(0.5 / n, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
		tbl12.Bloom.Value = 1
		tbl12.Bloom.Velocity = 0
		tbl12.Bloom.Target = 0
	end

	local function fn27(arg)
		local working = tbl8[arg.Kind] or tbl8.Working
		fn16(working.Color)
		fn17(working.Glyph)
		tbl11.Live = working.Live
		tbl11.Title = arg.Message
		tbl11.Detail = arg.Detail or ""
		fn18(arg.Message)
		tbl10.Detail.Text = tbl11.Detail
		fn26(arg.Kind)
		fn19()

		if tbl11.Tier == "Expanded" then
			fn20()
			fn14()
		else
			fn12("Compact")
			local holdDuration = tbl6.HoldDuration

			if arg.Kind == "Success" then
				holdDuration = tbl6.SuccessHold
			elseif arg.Kind == "Error" then
				holdDuration = tbl6.ErrorHold
			end

			fn13(holdDuration)
		end
	end

	local function fn28()
		if flag2 or tbl11.Destroyed then
			return
		end
		flag2 = true

		task.spawn(function()
			while not tbl11.Destroyed and #tbl14 > 0 do
				local n2 = -1
				local n3 = 1

				for i, v7 in ipairs(tbl14) do
					if n2 < v7.Priority then
						n2 = v7.Priority
						n3 = i
					end
				end

				local v7 = table.remove(tbl14, n3)
				tbl11.CurrentPriority = v7.Priority
				fn27(v7)
				local n4 = 0.45 / n
				local n5 = os.clock() + n4

				while true do
					if os.clock() < n5 and not tbl11.Destroyed then
						local flag3 = false

						for _, v8 in ipairs(tbl14) do
							if v8.Priority > v7.Priority then
								flag3 = true
								break
							else
								flag3 = false
							end
						end

						if not flag3 then
							task.wait(0.05)
							continue
						end
					end

					break
				end
			end

			tbl11.CurrentPriority = -1
			flag2 = false
			fn19()
		end)
	end

	local function fn29(arg, arg2, arg3)
		table.insert(tbl14, { Message = arg, Kind = arg2, Detail = arg3, Priority = (tbl8[arg2] or tbl8.Working).Priority })

		while #tbl14 > tbl6.QueueLimit do
			local huge = math.huge
			local n2 = 1

			for i, v7 in ipairs(tbl14) do
				if v7.Priority < huge then
					huge = v7.Priority
					n2 = i
				end
			end

			table.remove(tbl14, n2)
		end

		fn19()
		fn28()
	end

	local function fn30(arg, arg2, arg3)
		if tbl11.Destroyed or typeof(arg) ~= "string" or arg == "" then
			return
		end
		local v7 = fn9(arg2)
		local color = tbl8[v7].Color
		local v8 = tbl13[#tbl13]

		if v8 and v8.Message == arg and v8.Kind == v7 then
			v8.Count = v8.Count + 1
			v8.Stamp = fn7()
		else
			table.insert(tbl13, { Message = arg, Kind = v7, Colour = color, Stamp = fn7(), Count = 1 })
		end

		tbl11.Events = tbl11.Events + 1

		if v7 == "Error" or v7 == "Warning" then
			tbl11.Issues = tbl11.Issues + 1
		end

		while tbl6.LogLimit < #tbl13 do
			table.remove(tbl13, 1)
		end

		if tbl11.Tier == "Expanded" then
			fn20()
		end

		if tbl11.ReaderOpen then
			fn24()
		end

		fn29(arg, v7, arg3)
	end

	local function fn31(deltaTime)
		if tbl11.Destroyed then
			return
		end
		tbl11.Clock = tbl11.Clock + deltaTime * n

		for _, v7 in pairs(tbl12) do
			fn3(v7, deltaTime)
		end

		local value = tbl12.Width.Value
		local value2 = tbl12.Height.Value
		local n2 = math.max(tbl12.Radius.Value, 1)
		local max = math.max
		tbl10.Shell.Size = UDim2.fromOffset(math.max(value, 1), max(value2, 1))
		tbl10.ShellCorner.CornerRadius = UDim.new(0, n2)
		tbl10.WashCorner.CornerRadius = UDim.new(0, n2)
		tbl10.Scale.Scale = (tbl11.ResponsiveScale or tbl6.MaximumScale) * tbl12.Press.Value
		tbl10.TitleClip.Size = UDim2.fromOffset(math.max(value - 150, 0), 22)
		tbl10.Detail.Size = UDim2.fromOffset(math.max(value - 150, 0), 15)
		tbl10.Track.Size = UDim2.fromOffset(math.max(value - 80, 0), 2)
		local n3 = math.clamp(tbl12.TitleAlpha.Value, 0, 1)
		tbl10.TitleClip.Visible = n3 > 0.02
		tbl10.TitleClip.GroupTransparency = 1 - n3
		tbl10.Detail.TextTransparency = 1 - n3
		tbl10.Detail.Visible = tbl11.Detail ~= "" and n3 > 0.02
		tbl10.Track.BackgroundTransparency = 1 - n3 * 0.65
		local n4 = math.clamp(tbl12.CardAlpha.Value, 0, 1)
		tbl10.Card.GroupTransparency = 1 - n4
		tbl10.Card.Visible = n4 > 0.02
		local n5 = math.clamp(tbl12.Reader.Value, 0, 1)
		tbl10.ReaderRoot.Visible = n5 > 0.01
		tbl10.Reader.GroupTransparency = 1 - n5
		tbl10.ReaderDim.BackgroundTransparency = 1 - n5 * 0.55
		tbl10.Reader.Size = UDim2.fromOffset(tbl11.ReaderWidth, tbl11.ReaderHeight)
		local n6 = n5 * n5 * (3 - 2 * n5)
		local n7 = math.clamp(tbl11.ReaderOriginWidth / math.max(tbl11.ReaderWidth, 1), 0.05, 0.6)
		tbl10.ReaderScale.Scale = n7 + (1 - n7) * n6
		tbl10.Reader.Position = UDim2.fromOffset(tbl11.ReaderOriginX + (tbl11.ReaderTargetX - tbl11.ReaderOriginX) * n6, tbl11.ReaderOriginY + (tbl11.ReaderTargetY - tbl11.ReaderOriginY) * n6)
		local n8 = 0.5 + 0.5 * math.sin(tbl11.Clock * 1.6)
		local n9 = math.clamp(tbl12.Bloom.Value, 0, 1)

		for i, v7 in ipairs(tbl10.Bloom) do
			local n10 = i * 5
			v7.Position = UDim2.new(0.5, 0, 0, value2 / 2)
			v7.Size = UDim2.fromOffset(value + n10, value2 + n10)
			v7.BackgroundTransparency = math.clamp(0.965 - i * 0.004 - n9 * 0.05 - n8 * 0.006, 0, 1)
			tbl10.BloomCorners[i].CornerRadius = UDim.new(0, n2 + n10 / 2)
		end

		if tbl11.Glyph == "Spinner" then
			tbl10.GlyphSpin.Rotation = tbl11.Clock * 220 % 360
		elseif tbl11.Glyph == "Breath" or tbl11.Glyph == "Dot" then
			local n10 = 11 + n8 * 3
			tbl10.GlyphDot.Size = UDim2.fromOffset(n10, n10)
		end

		tbl10.Halo.BackgroundTransparency = 0.82 - n8 * 0.08
		local flag3 = tbl11.Live == "Equalizer" or tbl11.Live == "Stream"

		for i, bar in ipairs(tbl10.Bars) do
			local flag4 = flag3 and n3 > 0.02
			bar.BackgroundTransparency = flag4 and 0 or 1

			if flag4 then
				if tbl11.Live == "Stream" then
					bar.Size = UDim2.fromOffset(3.5, 6 + 10 * math.abs(math.sin((tbl11.Clock * 2.2 + i * 0.25) % 1 * 3.1415926535897931)))
				else
					bar.Size = UDim2.fromOffset(3.5, 7 + 9 * (0.5 + 0.5 * math.sin(tbl11.Clock * 5.5 + i * 1.1)))
				end
			end
		end

		local n10 = tbl6.BarHeight / 2
		tbl10.Slot.Position = UDim2.fromOffset(32 + (value / 2 - 32) * math.clamp((tbl6.DormantWidth - value) / (tbl6.DormantWidth - tbl6.SleepWidth), 0, 1), n10)

		if n3 < 0.98 and value > 108 then
			local n11 = 7 + n8 * 3
			tbl10.Pulse.Size = UDim2.fromOffset(n11, n11)
			tbl10.Pulse.BackgroundTransparency = math.clamp(n3 + 0.12 + n8 * 0.28, 0, 1)
		else
			tbl10.Pulse.BackgroundTransparency = 1
		end

		if tbl11.Progress then
			tbl10.Fill.Size = UDim2.fromScale(math.clamp(tbl12.Progress.Value, 0, 1), 1)
			tbl10.Fill.BackgroundTransparency = 1 - n3 * 0.9
			tbl10.Comet.BackgroundTransparency = 1
		else
			tbl10.Fill.BackgroundTransparency = 1

			if n3 > 0.02 and not flag then
				tbl10.Comet.Position = UDim2.fromScale(tbl11.Clock * 0.55 % 1.35 - 0.35, 0)
				tbl10.Comet.BackgroundTransparency = 0.1
			else
				tbl10.Comet.BackgroundTransparency = 1
			end
		end
	end

	local function fn32()
		local currentCamera = Workspace2.CurrentCamera
		if not currentCamera then
			tbl11.ResponsiveScale = tbl6.MaximumScale
			return
		end
		local compactWidth = tbl6.CompactWidth
		local minimumScale = tbl6.MinimumScale
		local maximumScale = tbl6.MaximumScale
		tbl11.ResponsiveScale = math.clamp(math.max(currentCamera.ViewportSize.X - 28, 1) / compactWidth, minimumScale, maximumScale)
		local readerMinWidth = tbl6.ReaderMinWidth
		local readerMaxWidth = tbl6.ReaderMaxWidth
		tbl11.ReaderWidth = math.clamp(math.floor(currentCamera.ViewportSize.X * tbl6.ReaderWidthRatio), readerMinWidth, readerMaxWidth)
		local readerMinHeight = tbl6.ReaderMinHeight
		local readerMaxHeight = tbl6.ReaderMaxHeight
		tbl11.ReaderHeight = math.clamp(math.floor(currentCamera.ViewportSize.Y * tbl6.ReaderHeightRatio), readerMinHeight, readerMaxHeight)
		tbl11.ReaderTargetX = currentCamera.ViewportSize.X / 2
		tbl11.ReaderTargetY = currentCamera.ViewportSize.Y / 2
		local readerNarrow = tbl11.ReaderWidth < tbl6.ReaderNarrowUnder

		if readerNarrow ~= tbl11.ReaderNarrow then
			tbl11.ReaderNarrow = readerNarrow
			tbl11.ReaderRowHeight = readerNarrow and tbl6.ReaderRowHeightNarrow or tbl6.ReaderRowHeight
			fn22()

			if tbl11.ReaderOpen then
				fn24()
			end
		end
	end

	local function fn33()
		if flag then
			return
		end
		tbl12.Press.Value = 0.955
		tbl12.Press.Velocity = 0
		tbl12.Press.Target = 1
	end

	fn8(tbl10.Tap.Activated:Connect(function()
		fn33()

		if tbl11.Tier == "Expanded" then
			tbl11.Pinned = false
			tbl10.Pin.Text = "Keep open"
			fn15()
			fn12("Dormant")
			return
		end

		fn20()
		fn12("Expanded")
		fn14()
	end))

	fn8(tbl10.Pin.Activated:Connect(function()
		fn33()
		tbl11.Pinned = not tbl11.Pinned
		tbl10.Pin.Text = tbl11.Pinned and "Pinned" or "Keep open"

		if tbl11.Pinned then
			fn15()
		else
			fn14()
		end
	end))

	fn8(tbl10.Open.Activated:Connect(function()
		fn33()
		fn25(true)
	end))

	fn8(tbl10.ReaderClose.Activated:Connect(function()
		fn25(false)
	end))

	fn8(tbl10.ReaderDim.Activated:Connect(function()
		fn25(false)
	end))

	fn8(tbl10.Clear.Activated:Connect(function()
		fn33()
		fn14()
		tbl13 = {}
		tbl11.Events = 0
		tbl11.Issues = 0
		fn20()

		if tbl11.ReaderOpen then
			fn24()
		end
	end))

	fn8(tbl19.AddLog.Event:Connect(function(arg, arg2)
		fn30(tostring(arg), arg2)
	end))

	fn8(tbl19.UpdateStatus.Event:Connect(function(arg, arg2)
		fn30(tostring(arg), arg2)
	end))

	fn8(tbl19.UpdateCurrentStep.Event:Connect(function(detail)
		if typeof(detail) == "string" and detail ~= "" then
			tbl11.Detail = detail
			tbl10.Detail.Text = detail
		end
	end))

	fn8(tbl19.UpdateRetry.Event:Connect(function(arg, arg2)
		local n2 = tonumber(arg) or 0
		tbl11.Retries = math.max(tbl11.Retries, n2)
		local str = string.format("Retry %d", n2)

		if tonumber(arg2) then
			str = string.format("Retry %d in %ds", n2, tonumber(arg2))
		end

		fn30(str, "Warning")
	end))

	fn8(tbl19.UpdateRecovery.Event:Connect(function(arg, arg2)
		local str = tostring(arg)

		if typeof(arg2) == "string" and arg2 ~= "" then
			str ..= " -> " .. arg2
		end

		fn30(str, "Warning")
	end))

	fn8(tbl19.CompleteSession.Event:Connect(function()
		if tbl11.Complete then
			return
		end
		tbl11.Complete = true
		tbl11.SessionEnd = os.clock()
		fn30("Session complete", "Success")
	end))

	fn8(tbl19.ResetSession.Event:Connect(function()
		tbl13 = {}
		tbl14 = {}
		tbl11.Events = 0
		tbl11.Issues = 0
		tbl11.Retries = 0
		tbl11.Complete = false
		tbl11.SessionStart = os.clock()
		tbl11.SessionEnd = nil
		tbl11.Pinned = false
		tbl10.Pin.Text = "Keep open"
		fn25(false)
		fn20()
		fn12("Dormant")
		fn30("New session", "Info")
	end))

	fn8(tbl19.UpdateProgress.Event:Connect(function(arg)
		if typeof(arg) ~= "number" then
			tbl11.Progress = nil
			return
		end
		local value = math.clamp(arg, 0, 1)

		if not tbl11.Progress then
			tbl12.Progress.Value = value
			tbl12.Progress.Velocity = 0
		end

		tbl11.Progress = value
		tbl12.Progress.Target = value
	end))

	fn8(tbl19.UpdateTheme.Event:Connect(function(arg)
		if typeof(arg) == "Color3" then
			accentColor = arg
			fn16(arg)
		end
	end))

	local function fn34()
		if tbl11.Destroyed then
			return
		end
		tbl11.Destroyed = true
		tbl11.HoldToken = tbl11.HoldToken + 1

		for _, v7 in ipairs(tbl15) do
			pcall(function()
				v7:Disconnect()
			end)
		end

		tbl15 = {}
	end

	fn8(tbl19.DestroyUI.Event:Connect(function()
		fn34()
		screenGui:Destroy()
	end))

	fn8(screenGui.Destroying:Connect(fn34))
	fn8(RunService2.RenderStepped:Connect(fn31))
	fn8(Workspace2:GetPropertyChangedSignal("CurrentCamera"):Connect(fn32))
	fn32()
	fn22()
	fn16(accentColor)
	fn17("Dot")
	fn20()
	fn19()
	fn12("Dormant", true)
	tbl10.TitleA.Text = "Idle"
	tbl10.TitleA.TextTransparency = 1
	local currentCamera = Workspace2.CurrentCamera

	if currentCamera then
		fn8(currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn32))
	end
end

tbl5.Start = function()
	if colorIslandGui and colorIslandGui.Parent then
		return true, nil
	end
	local ok, result = pcall(tbl5.Build)
	if not ok then
		return false, "ColorIsland failed to load: " .. tostring(result)
	end
	local playerGui = localPlayer2:FindFirstChild("PlayerGui")
	colorIslandGui = playerGui and playerGui:FindFirstChild("ColorIslandGui")
	if not colorIslandGui then
		return false, "ColorIsland was not created"
	end
	return true, nil
end

tbl5.Fire = function(arg, ...)
	if not colorIslandGui or not colorIslandGui.Parent then
		return false
	end
	local v = colorIslandGui:FindFirstChild(arg)
	if not v or not v:IsA("BindableEvent") then
		return false
	end
	return pcall(v.Fire, v, ...)
end

tbl5.Log = function(arg, arg2)
	return tbl5.Fire("AddLog", tostring(arg), arg2)
end

tbl5.Step = function(arg)
	return tbl5.Fire("UpdateCurrentStep", tostring(arg))
end

tbl5.Progress = function(arg)
	return tbl5.Fire("UpdateProgress", arg)
end

tbl5.Retry = function(arg, arg2)
	return tbl5.Fire("UpdateRetry", arg, arg2)
end

tbl5.Recovery = function(arg, arg2)
	return tbl5.Fire("UpdateRecovery", tostring(arg), arg2)
end

tbl5.Theme = function(arg)
	return tbl5.Fire("UpdateTheme", arg)
end

tbl5.Reset = function()
	return tbl5.Fire("ResetSession")
end

tbl5.Complete = function()
	return tbl5.Fire("CompleteSession")
end

tbl5.Destroy = function()
	return tbl5.Fire("DestroyUI")
end

local v = tbl5
local n = 50
local n2 = 0.0001
local n3 = 0.5
local v2 = nil
local tbl9 = {}
local index = {}
local index2 = {}
index.__index = index
index2.__index = index2

tbl9.IsFiniteNumber = function(arg)
	return typeof(arg) == "number" and arg == arg and arg > -math.huge and arg < math.huge
end

tbl9.IsFiniteVector3 = function(arg)
	return typeof(arg) == "Vector3" and tbl9.IsFiniteNumber(arg.X) and tbl9.IsFiniteNumber(arg.Y) and tbl9.IsFiniteNumber(arg.Z)
end

tbl9.IsFiniteCFrame = function(arg)
	if typeof(arg) ~= "CFrame" then
		return false
	end
	return tbl9.IsFiniteVector3(arg.Position) and tbl9.IsFiniteVector3(arg.RightVector) and tbl9.IsFiniteVector3(arg.UpVector) and tbl9.IsFiniteVector3(arg.LookVector)
end

tbl9.FindModelRoot = function(arg, arg2)
	if not arg or not arg:IsA("Model") then
		return nil
	end
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	if humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoidRootPart:IsDescendantOf(arg) then
		return humanoidRootPart
	end

	if arg2 then
		local ok, result = pcall(function()
			return arg2.RootPart
		end)

		if ok and result and result:IsA("BasePart") and result:IsDescendantOf(arg) then
			return result
		end
	end

	local primaryPart = arg.PrimaryPart
	if primaryPart and primaryPart:IsA("BasePart") and primaryPart:IsDescendantOf(arg) then
		return primaryPart
	end
	return arg:FindFirstChildWhichIsA("BasePart", true)
end

tbl9.GetLocalCharacter = function()
	local character = localPlayer and localPlayer.Character
	if not character or not character.Parent then
		return nil, nil, nil, "Local character is unavailable"
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or not humanoid:IsDescendantOf(character) then
		return nil, nil, nil, "Local humanoid is unavailable"
	end

	if humanoid.Health <= 0 then
		return nil, nil, nil, "Local humanoid is dead"
	end
	local v3 = tbl9.FindModelRoot(character, humanoid)
	if not v3 then
		return nil, nil, nil, "Local HumanoidRootPart is unavailable"
	end
	return character, humanoid, v3, nil
end

tbl9.CreateTargetState = function(arg)
	local kind = typeof(arg)

	if kind == "CFrame" then
		if not tbl9.IsFiniteCFrame(arg) then
			return nil, "Target CFrame is invalid"
		end
		return { Kind = "CFrame", Value = arg, IsCharacterTarget = false }
	end

	if kind == "Vector3" then
		if not tbl9.IsFiniteVector3(arg) then
			return nil, "Target Vector3 is invalid"
		end
		return { Kind = "Vector3", Value = arg, IsCharacterTarget = false }
	end

	if kind ~= "Instance" then
		return nil, "Target must be a CFrame, Vector3, BasePart, Attachment, Model, or Player"
	end

	if arg:IsA("Player") then
		if not arg.Parent then
			return nil, "Target player has left the game"
		end
		local character = arg.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local v3 = character and tbl9.FindModelRoot(character, humanoid)
		if not character or not character.Parent then
			return nil, "Target player character is unavailable"
		end

		if not humanoid or not humanoid:IsDescendantOf(character) then
			return nil, "Target player humanoid is unavailable"
		end

		if not v3 then
			return nil, "Target player has no usable root part"
		end
		return { Kind = "Player", Instance = arg, Character = character, Humanoid = humanoid, IsCharacterTarget = true }
	end

	if arg:IsA("Attachment") then
		if not arg.Parent then
			return nil, "Target attachment has been removed"
		end
		return { Kind = "Attachment", Instance = arg, IsCharacterTarget = false }
	end

	if arg:IsA("BasePart") then
		if not arg.Parent then
			return nil, "Target part has been removed"
		end
		return { Kind = "BasePart", Instance = arg, IsCharacterTarget = false }
	end

	if arg:IsA("Model") then
		if not arg.Parent then
			return nil, "Target model has been removed"
		end
		local humanoid = arg:FindFirstChildOfClass("Humanoid")

		if humanoid then
			if not tbl9.FindModelRoot(arg, humanoid) then
				return nil, "Target mob has no usable root part"
			end

			return {
				Kind = "CharacterModel",
				Instance = arg,
				Character = arg,
				Humanoid = humanoid,
				IsCharacterTarget = true,
			}
		end

		local ok, result = pcall(function()
			return arg:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return nil, "Target model has no valid pivot"
		end
		return { Kind = "Model", Instance = arg, IsCharacterTarget = false }
	end

	return nil, "Unsupported target instance"
end

tbl9.RefreshPlayerTarget = function(arg)
	local instance = arg.Instance
	if not instance.Parent then
		return false, "Target player has left the game"
	end
	local character = instance.Character
	if not character or not character.Parent then
		return false, "Target player character is unavailable"
	end

	if character ~= arg.Character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return false, "Target player humanoid is not ready yet"
		end

		if not tbl9.FindModelRoot(character, humanoid) then
			return false, "Target player root part is not ready yet"
		end
		arg.Character = character
		arg.Humanoid = humanoid
	end

	return true, nil
end

tbl9.ResolveTargetFrame = function(arg)
	local kind = arg.Kind
	if kind == "CFrame" then
		return arg.Value, true, nil, nil
	end

	if kind == "Vector3" then
		return CFrame.new(arg.Value), false, nil, nil
	end

	if kind == "Player" then
		local v3, v4 = tbl9.RefreshPlayerTarget(arg)
		if not v3 then
			return nil, false, "Lost", v4
		end
		local character = arg.Character
		local humanoid = arg.Humanoid
		if not humanoid.Parent or not humanoid:IsDescendantOf(character) then
			return nil, false, "Lost", "Target player humanoid has been removed"
		end

		if humanoid.Health <= 0 then
			return nil, false, "Dead", "Target player is dead"
		end
		local v5 = tbl9.FindModelRoot(character, humanoid)
		if not v5 then
			return nil, false, "Lost", "Target player root part is unavailable"
		end
		local cFrame = v5.CFrame
		if not tbl9.IsFiniteCFrame(cFrame) then
			return nil, false, "Lost", "Target player CFrame is invalid"
		end
		return cFrame, true, nil, nil
	end

	if kind == "CharacterModel" then
		local character = arg.Character
		local humanoid = arg.Humanoid
		if not character.Parent then
			return nil, false, "Lost", "Target mob has been removed"
		end

		if not humanoid.Parent or not humanoid:IsDescendantOf(character) then
			return nil, false, "Lost", "Target mob humanoid has been removed"
		end

		if humanoid.Health <= 0 then
			return nil, false, "Dead", "Target mob is dead"
		end
		local v3 = tbl9.FindModelRoot(character, humanoid)
		if not v3 then
			return nil, false, "Lost", "Target mob root part is unavailable"
		end
		local cFrame = v3.CFrame
		if not tbl9.IsFiniteCFrame(cFrame) then
			return nil, false, "Lost", "Target mob CFrame is invalid"
		end
		return cFrame, true, nil, nil
	end

	if kind == "Attachment" then
		local instance = arg.Instance
		if not instance.Parent then
			return nil, false, "Lost", "Target attachment has been removed"
		end
		local worldCFrame = instance.WorldCFrame
		if not tbl9.IsFiniteCFrame(worldCFrame) then
			return nil, false, "Lost", "Target attachment CFrame is invalid"
		end
		return worldCFrame, true, nil, nil
	end

	if kind == "BasePart" then
		local instance = arg.Instance
		if not instance.Parent then
			return nil, false, "Lost", "Target part has been removed"
		end
		local cFrame = instance.CFrame
		if not tbl9.IsFiniteCFrame(cFrame) then
			return nil, false, "Lost", "Target part CFrame is invalid"
		end
		return cFrame, true, nil, nil
	end

	if kind == "Model" then
		local instance = arg.Instance
		if not instance.Parent then
			return nil, false, "Lost", "Target model has been removed"
		end

		local ok, result = pcall(function()
			return instance:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return nil, false, "Lost", "Target model pivot is invalid"
		end
		return result, true, nil, nil
	end

	return nil, false, "Lost", "Target state is unsupported"
end

tbl9.ResolveOffset = function(arg, arg2)
	if arg == nil then
		if arg2 then
			return CFrame.new(0, 15, 0), nil
		end
		return CFrame.identity, nil
	end

	if typeof(arg) == "Vector3" then
		if not tbl9.IsFiniteVector3(arg) then
			return nil, "Offset Vector3 is invalid"
		end
		return CFrame.new(arg), nil
	end

	if tbl9.IsFiniteCFrame(arg) then
		return arg, nil
	end
	return nil, "Offset must be a finite CFrame or Vector3"
end

tbl9.GetHorizontalDirection = function(arg, arg2)
	if tbl9.IsFiniteVector3(arg) then
		local vector = Vector3.new(arg.X, 0, arg.Z)
		local magnitude = vector.Magnitude
		if tbl9.IsFiniteNumber(magnitude) and magnitude > n2 then
			return vector / magnitude
		end
	end

	if tbl9.IsFiniteVector3(arg2) then
		local vector = Vector3.new(arg2.X, 0, arg2.Z)
		local magnitude = vector.Magnitude
		if tbl9.IsFiniteNumber(magnitude) and magnitude > n2 then
			return vector / magnitude
		end
	end

	return Vector3.new(0, 0, -1)
end

tbl9.BuildDestination = function(arg, arg2, arg3)
	if not tbl9.IsFiniteCFrame(arg2) then
		return nil, "Target CFrame is invalid"
	end
	local targetDirection = arg.TargetDirection

	if arg3 then
		targetDirection = tbl9.GetHorizontalDirection(arg2.LookVector, arg.TargetDirection)
		arg.TargetDirection = targetDirection
	end

	local offsetCFrame = arg.OffsetCFrame
	local n4 = CFrame.lookAlong(arg2.Position, targetDirection, Vector3.new(0, 1, 0)) * offsetCFrame
	local cframe = CFrame.lookAlong(n4.Position, tbl9.GetHorizontalDirection(n4.LookVector, targetDirection), Vector3.new(0, 1, 0))
	if not tbl9.IsFiniteCFrame(cframe) then
		return nil, "Calculated destination is invalid"
	end
	return cframe, nil
end

tbl9.GetCurrentUprightCFrame = function(arg)
	local ok, result = pcall(function()
		return arg.Character:GetPivot()
	end)

	if not ok or not tbl9.IsFiniteCFrame(result) then
		return nil, "Local character pivot is invalid"
	end
	local v3 = tbl9.GetHorizontalDirection(result.LookVector, arg.CharacterDirection)
	arg.CharacterDirection = v3
	return CFrame.lookAlong(result.Position, v3, Vector3.new(0, 1, 0)), nil
end

tbl9.ValidateLocalJob = function(arg)
	if localPlayer.Character ~= arg.Character then
		return false, "Local character has respawned"
	end

	if not arg.Character.Parent then
		return false, "Local character has been removed"
	end

	if not arg.Humanoid.Parent or not arg.Humanoid:IsDescendantOf(arg.Character) or arg.Humanoid.Health <= 0 then
		return false, "Local humanoid is unavailable or dead"
	end
	local v3 = tbl9.FindModelRoot(arg.Character, arg.Humanoid)
	if not v3 then
		return false, "Local root part is unavailable"
	end
	arg.RootPart = v3
	return true, nil
end

tbl9.StopVelocity = function(arg)
	if not arg or not arg.Parent then
		return false
	end

	return (pcall(function()
		arg.AssemblyLinearVelocity = Vector3.zero
		arg.AssemblyAngularVelocity = Vector3.zero
	end))
end

tbl9.ClearArray = function(arg)
	if type(arg) ~= "table" then
		return
	end

	for i = #arg, 1, -1 do
		arg[i] = nil
	end
end

tbl9.RebuildNoclipCache = function(arg)
	local ok, result = pcall(function()
		return arg.Character:GetDescendants()
	end)

	if not ok then
		return
	end
	local noclipParts = arg.NoclipParts
	tbl9.ClearArray(noclipParts)

	for _, v3 in ipairs(result) do
		if v3:IsA("BasePart") then
			if arg.CollisionStates[v3] == nil then
				local ok2, result2 = pcall(function()
					return v3.CanCollide
				end)

				if ok2 then
					arg.CollisionStates[v3] = result2
				end
			end

			noclipParts[#noclipParts + 1] = v3
		end
	end
end

tbl9.ApplyNoclip = function(arg, arg2)
	if tbl9.IsFiniteNumber(arg2) and arg2 > 0 then
		arg.NoclipClock = arg.NoclipClock + arg2
	end

	if arg.NoclipDirty or arg.NoclipClock >= n3 then
		arg.NoclipDirty = false
		arg.NoclipClock = 0
		tbl9.RebuildNoclipCache(arg)
	end

	local noclipParts = arg.NoclipParts

	for i = #noclipParts, 1, -1 do
		local v3 = noclipParts[i]

		if not v3.Parent then
			table.remove(noclipParts, i)
		elseif v3.CanCollide then
			v3.CanCollide = false
		end
	end
end

tbl9.EnforceUprightState = function(arg)
	local humanoid = arg.Humanoid

	if arg.KeepSeated then
		local ok, result = pcall(function()
			return humanoid.Sit
		end)

		if ok and result then
			return
		end
	end

	pcall(function()
		if humanoid.Sit then
			humanoid.Sit = false
		end

		if humanoid.PlatformStand then
			humanoid.PlatformStand = false
		end
	end)

	pcall(function()
		local state = humanoid:GetState()

		if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.Seated or state == Enum.HumanoidStateType.PlatformStanding then
			humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)
end

tbl9.ApplyCharacterCFrame = function(arg, arg2)
	if not tbl9.IsFiniteCFrame(arg2) then
		return false, "Refused to apply an invalid character CFrame"
	end

	local ok, result = pcall(function()
		arg.Character:PivotTo(arg2)
	end)

	if not ok then
		return false, "Failed to move the local character: " .. tostring(result)
	end
	tbl9.StopVelocity(arg.RootPart)
	return true, nil
end

tbl9.PrepareCharacter = function(arg)
	local ok, originalAutoRotate = pcall(function()
		return arg.Humanoid.AutoRotate
	end)

	if ok then
		arg.OriginalAutoRotate = originalAutoRotate

		arg.AutoRotateChanged = pcall(function()
			arg.Humanoid.AutoRotate = false
		end)
	end

	local ok2, descendantConnection = pcall(function()
		return arg.Character.DescendantAdded:Connect(function()
			arg.NoclipDirty = true
		end)
	end)

	if ok2 then
		arg.DescendantConnection = descendantConnection
	end

	arg.NoclipDirty = true
	tbl9.ApplyNoclip(arg, 0)
	tbl9.EnforceUprightState(arg)
	tbl9.StopVelocity(arg.RootPart)
end

tbl9.TryReacquireLocalCharacter = function(arg)
	local character = localPlayer.Character
	if not character or not character.Parent then
		return false
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or not humanoid:IsDescendantOf(character) or humanoid.Health <= 0 then
		return false
	end
	local v3 = tbl9.FindModelRoot(character, humanoid)
	if not v3 then
		return false
	end

	if character == arg.Character then
		arg.Humanoid = humanoid
		arg.RootPart = v3
		arg.NoclipDirty = true
		tbl9.ApplyNoclip(arg, 0)
		tbl9.EnforceUprightState(arg)
		return true
	end

	tbl9.ReleaseCharacterBindings(arg)
	arg.Character = character
	arg.Humanoid = humanoid
	arg.RootPart = v3
	arg.CollisionStates = {}
	arg.NoclipClock = 0
	arg.NoclipDirty = true
	arg.OriginalAutoRotate = nil
	arg.AutoRotateChanged = false
	tbl9.PrepareCharacter(arg)

	local ok, result = pcall(function()
		return character:GetPivot()
	end)

	if ok and tbl9.IsFiniteCFrame(result) then
		arg.CharacterDirection = tbl9.GetHorizontalDirection(result.LookVector, arg.CharacterDirection)
	end

	return true
end

tbl9.ReleaseCharacterBindings = function(arg)
	if arg.DescendantConnection then
		pcall(function()
			arg.DescendantConnection:Disconnect()
		end)

		arg.DescendantConnection = nil
	end

	tbl9.ClearArray(arg.NoclipParts)
end

tbl9.Cleanup = function(arg, state, arg2)
	if not arg or arg.Cleaned then
		return false
	end
	arg.Cleaned = true
	arg.Running = false
	arg.State = state or "Stopped"
	arg.Reason = arg2 or arg.Reason or arg.State

	if v2 == arg then
		v2 = nil
	end

	if genv.Kaitun6V4ActiveTween == arg then
		genv.Kaitun6V4ActiveTween = nil
	end

	tbl9.ReleaseCharacterBindings(arg)

	for k, collisionState in pairs(arg.CollisionStates) do
		if k and k.Parent then
			pcall(function()
				k.CanCollide = collisionState
			end)
		end
	end

	arg.CollisionStates = {}

	if arg.AutoRotateChanged and arg.Humanoid and arg.Humanoid.Parent then
		pcall(function()
			arg.Humanoid.AutoRotate = arg.OriginalAutoRotate
		end)
	end

	tbl9.StopVelocity(arg.RootPart)
	return true
end

tbl9.EnterHolding = function(arg, holdKind, reason, holdCFrame)
	if arg.Cleaned then
		return false, "Tween has already been cleaned"
	end

	if not tbl9.IsFiniteCFrame(holdCFrame) then
		return false, "Hold CFrame is invalid"
	end
	arg.State = "Holding"
	arg.HoldKind = holdKind or "Lost"
	arg.Reason = reason or "Target became unavailable"
	arg.HoldCFrame = holdCFrame
	return tbl9.ApplyCharacterCFrame(arg, holdCFrame)
end

tbl9.TryResumeFromHolding = function(arg)
	local targetState = arg.TargetState
	if targetState.Kind ~= "Player" then
		return false
	end

	if not tbl9.RefreshPlayerTarget(targetState) then
		return false
	end
	local character = targetState.Character
	local humanoid = targetState.Humanoid
	if not humanoid.Parent or not humanoid:IsDescendantOf(character) or humanoid.Health <= 0 then
		return false
	end

	if not tbl9.FindModelRoot(character, humanoid) then
		return false
	end
	arg.State = "Moving"
	arg.HoldKind = nil
	arg.HoldCFrame = nil
	arg.Reason = nil
	return true
end

tbl9.Fail = function(arg, arg2)
	tbl9.Cleanup(arg, "Failed", arg2 or "Tween failed")
	return false
end

tbl9.StopJob = function(arg, arg2)
	if not arg or arg.Cleaned then
		arg = arg and arg.Reason or "Tween is not running"
		return false, arg
	end
	tbl9.Cleanup(arg, "Stopped", arg2 or "Stopped")
	return true, arg.Reason
end

tbl9.StopActiveJob = function(arg)
	local v3 = v2
	local flag = v2

	if v3 then
		flag = not v3.Cleaned
	end

	if flag then
		tbl9.StopJob(v3, arg or "Replaced by a new Tween")
	end

	local kaitun6V4ActiveTween = genv.Kaitun6V4ActiveTween

	if kaitun6V4ActiveTween ~= v3 and type(kaitun6V4ActiveTween) == "table" then
		local stop = kaitun6V4ActiveTween.Stop

		if type(stop) == "function" then
			pcall(stop, kaitun6V4ActiveTween)
		end
	end
end

tbl9.Step = function(arg, arg2)
	local v3, v4 = tbl9.ValidateLocalJob(arg)

	if not v3 and not tbl9.TryReacquireLocalCharacter(arg) then
		arg.State = "Respawning"
		arg.Reason = v4
		arg.HoldKind = nil
		arg.HoldCFrame = nil
		return
	end

	if not tbl9.IsFiniteNumber(arg2) or arg2 < 0 then
		tbl9.Fail(arg, "Heartbeat delta time is invalid")
		return
	end
	local v5, v6 = tbl9.GetCurrentUprightCFrame(arg)
	if not v5 then
		tbl9.Fail(arg, v6)
		return
	end
	tbl9.ApplyNoclip(arg, arg2)
	tbl9.EnforceUprightState(arg)

	if arg.State == "Holding" and not tbl9.TryResumeFromHolding(arg) then
		local v7, v8 = tbl9.ApplyCharacterCFrame(arg, arg.HoldCFrame)

		if not v7 then
			tbl9.Fail(arg, v8)
		end

		return
	end

	local v7, v8, v9, v10 = tbl9.ResolveTargetFrame(arg.TargetState)

	if v9 or not v7 then
		local v11, v12 = tbl9.EnterHolding(arg, v9 or "Lost", v10 or "Target CFrame is unavailable", v5)

		if not v11 then
			tbl9.Fail(arg, v12)
		end

		return
	end

	local v11, v12 = tbl9.BuildDestination(arg, v7, v8)
	if not v11 then
		tbl9.Fail(arg, v12)
		return
	end
	local magnitude = (v11.Position - v5.Position).Magnitude
	if not tbl9.IsFiniteNumber(magnitude) then
		tbl9.Fail(arg, "Calculated Tween distance is invalid")
		return
	end
	local cframe

	if magnitude <= n then
		arg.State = arg.TargetState.IsCharacterTarget and "Tracking" or "Arrived"
		cframe = v11
	else
		local n4 = math.clamp(math.min(arg.Speed * arg2, magnitude) / magnitude, 0, 1)
		local v13 = v5:Lerp(v11, n4)
		cframe = CFrame.lookAlong(v13.Position, tbl9.GetHorizontalDirection(v13.LookVector, arg.CharacterDirection), Vector3.new(0, 1, 0))
		arg.State = "Moving"
	end

	if not tbl9.IsFiniteCFrame(cframe) then
		tbl9.Fail(arg, "Calculated character CFrame is invalid")
		return
	end
	local v13, v14 = tbl9.ApplyCharacterCFrame(arg, cframe)
	if not v13 then
		tbl9.Fail(arg, v14)
		return
	end
	arg.CharacterDirection = tbl9.GetHorizontalDirection(cframe.LookVector, arg.CharacterDirection)
	arg.LastDestination = v11
	arg.Reason = nil
end

tbl9.Follow = function(arg)
	while true do
		if v2 == arg and not arg.Cleaned then
			local result = RunService.Heartbeat:Wait()
			if not (v2 ~= arg or arg.Cleaned) then
				tbl9.Step(arg, result)
				continue
			end
		end

		break
	end
end

tbl9.FollowProtected = function(arg)
	local ok, result = pcall(tbl9.Follow, arg)

	if not ok and not arg.Cleaned then
		tbl9.Fail(arg, "Tween worker error: " .. tostring(result))
	end
end

tbl9.CreateJob = function(arg, arg2, arg3, arg4)
	local v3, v4, v5, v6 = tbl9.GetLocalCharacter()
	if not v3 then
		return nil, v6
	end

	if arg2 == nil then
		arg2 = 180
	end

	if not tbl9.IsFiniteNumber(arg2) or arg2 <= 0 then
		return nil, "Speed must be a finite number greater than zero"
	end
	local n4 = math.min(arg2, 180)
	local v7, v8 = tbl9.CreateTargetState(arg)
	if not v7 then
		return nil, v8
	end
	local v9, v10 = tbl9.ResolveOffset(arg3, v7.IsCharacterTarget)
	if not v9 then
		return nil, v10
	end

	local ok, result = pcall(function()
		return v3:GetPivot()
	end)

	if not ok or not tbl9.IsFiniteCFrame(result) then
		return nil, "Local character pivot is invalid"
	end
	local v11 = tbl9.GetHorizontalDirection(result.LookVector, Vector3.new(0, 0, -1))
	local cframe = CFrame.lookAlong(result.Position, v11, Vector3.new(0, 1, 0))
	local v12, v13, v14, str = tbl9.ResolveTargetFrame(v7)
	if not v12 and not v14 then
		str = str or "Target CFrame is unavailable"
		return nil, str
	end

	local kaitun6V4ActiveTween = setmetatable({
		Character = v3,
		Humanoid = v4,
		RootPart = v5,
		TargetState = v7,
		OffsetCFrame = v9,
		Speed = n4,
		KeepSeated = arg4 == true,
		State = "Starting",
		Reason = nil,
		Running = true,
		Cleaned = false,
		HoldKind = nil,
		HoldCFrame = nil,
		LastDestination = nil,
		CharacterDirection = v11,
		TargetDirection = v11,
		CollisionStates = {},
		NoclipParts = {},
		NoclipClock = 0,
		NoclipDirty = true,
		DescendantConnection = nil,
		OriginalAutoRotate = nil,
		AutoRotateChanged = false,
	}, index)

	local v15 = nil
	local magnitude = nil

	if v12 then
		local v16
		v15, v16 = tbl9.BuildDestination(kaitun6V4ActiveTween, v12, v13)
		if not v15 then
			return nil, v16
		end
		magnitude = (v15.Position - cframe.Position).Magnitude
		if not tbl9.IsFiniteNumber(magnitude) then
			return nil, "Initial Tween distance is invalid"
		end
	end

	tbl9.StopActiveJob("Replaced by a new Tween")
	v2 = kaitun6V4ActiveTween
	genv.Kaitun6V4ActiveTween = kaitun6V4ActiveTween
	tbl9.PrepareCharacter(kaitun6V4ActiveTween)
	local v16, v17

	if v14 or not v15 then
		v16, v17 = tbl9.EnterHolding(kaitun6V4ActiveTween, v14 or "Lost", str or "Target CFrame is unavailable", cframe)
	elseif magnitude <= n then
		kaitun6V4ActiveTween.State = v7.IsCharacterTarget and "Tracking" or "Arrived"
		v16, v17 = tbl9.ApplyCharacterCFrame(kaitun6V4ActiveTween, v15)
		kaitun6V4ActiveTween.CharacterDirection = tbl9.GetHorizontalDirection(v15.LookVector, v11)
	else
		kaitun6V4ActiveTween.State = "Moving"
		v16, v17 = tbl9.ApplyCharacterCFrame(kaitun6V4ActiveTween, cframe)
	end

	if not v16 then
		tbl9.Fail(kaitun6V4ActiveTween, v17)
		return nil, v17
	end
	kaitun6V4ActiveTween.LastDestination = v15
	task.spawn(tbl9.FollowProtected, kaitun6V4ActiveTween)
	return kaitun6V4ActiveTween, nil
end

index.Stop = function(arg)
	if type(arg) ~= "table" or getmetatable(arg) ~= index then
		return false, "Stop must be called with a Tween controller"
	end
	local ok, result, result2 = pcall(tbl9.StopJob, arg, "Stopped")
	if not ok then
		return false, "Tween Stop error: " .. tostring(result)
	end
	return result, result2
end

index.IsRunning = function(arg)
	return type(arg) == "table" and getmetatable(arg) == index and arg.Running and not arg.Cleaned and v2 == arg
end

index.GetReason = function(arg)
	if type(arg) ~= "table" or getmetatable(arg) ~= index then
		return "Invalid Tween controller"
	end
	return arg.Reason
end

index.GetState = function(arg)
	if type(arg) ~= "table" or getmetatable(arg) ~= index then
		return "Invalid"
	end
	return arg.State
end

index2.Stop = function(arg)
	return false, type(arg) == "table" and arg.Reason or "Tween never started"
end

index2.IsRunning = function()
	return false
end

index2.GetState = function()
	return "Failed"
end

index2.GetReason = function(arg)
	return type(arg) == "table" and arg.Reason or "Tween never started"
end

tbl9.CreateNullController = function(arg)
	return setmetatable({ State = "Failed", Reason = arg or "Tween never started", Running = false, Cleaned = true }, index2)
end

Tween = function(arg, arg2, arg3, arg4)
	local v3 = v2
	local ok, result, result2 = pcall(tbl9.CreateJob, arg, arg2, arg3, arg4)

	if not ok then
		if v2 and v2 ~= v3 then
			pcall(tbl9.Fail, v2, "Unexpected Tween creation error")
		end

		local str = "Tween error: " .. tostring(result)
		return tbl9.CreateNullController(str), str
	end

	if not result then
		result2 = result2 or "Tween could not start"
		return tbl9.CreateNullController(result2), result2
	end
	return result, nil
end

tbl9.StopActiveJob("Tween controller reloaded")
local tbl10

tbl10 = {
	Disconnect = function(arg)
		if not arg then
			return false
		end

		return pcall(function()
			arg:Disconnect()
		end)
	end,
	DisconnectAll = function(arg)
		if type(arg) ~= "table" then
			return
		end

		for _, v3 in ipairs(arg) do
			tbl10.Disconnect(v3)
		end

		tbl9.ClearArray(arg)
	end,
	StopRuntime = function(arg)
		if type(arg) ~= "table" then
			return false
		end
		arg.Active = false
		tbl10.Disconnect(arg.Connection)
		arg.Connection = nil
		tbl10.DisconnectAll(arg.WatcherConnections)
		return true
	end,
	ClaimSharedRuntime = function(arg, arg2)
		local v3 = genv[arg]
		local flag = type(v3) == "table" and v3 ~= arg2
		local flag2 = false

		if flag then
			flag2 = tbl10.StopRuntime(v3)
		end

		genv[arg] = arg2
		return flag2
	end,
}

local tbl11

tbl11 = {
	GetRemote = function()
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		if not remotes then
			return nil, "Remotes folder is unavailable"
		end
		local commF = remotes:FindFirstChild("CommF_")
		if not commF or not commF:IsA("RemoteFunction") then
			return nil, "CommF_ RemoteFunction is unavailable"
		end
		return commF, nil
	end,
	Invoke = function(...)
		local v3, v4 = tbl11.GetRemote()
		if not v3 then
			return nil, v4
		end
		local v5 = table.pack(...)

		local ok, result = pcall(function()
			return v3:InvokeServer(table.unpack(v5, 1, v5.n))
		end)

		if not ok then
			return nil, "CommF_ invocation failed: " .. tostring(result)
		end
		return result, nil
	end,
	InvokeMany = function(...)
		local v3, v4 = tbl11.GetRemote()
		if not v3 then
			return nil, v4
		end
		local v5 = table.pack(...)

		local ok, result = pcall(function()
			return table.pack(v3:InvokeServer(table.unpack(v5, 1, v5.n)))
		end)

		if not ok then
			return nil, "CommF_ invocation failed: " .. tostring(result)
		end
		return result, nil
	end,
}

local n4 = 120

local tbl12 = {
	TravelToSecondSea = function()
		if tbl2[game.PlaceId] then
			return true, "The player is already in the Second Sea"
		end
		local TravelDressrosa, v3 = tbl11.Invoke("TravelDressrosa")
		if v3 then
			return false, "Traveling to the Second Sea failed: " .. tostring(v3)
		end
		return false, "Requested travel to the Second Sea"
	end,
	TravelToThirdSea = function()
		local n5 = os.clock() + n4
		local v3 = nil

		while not tbl3[game.PlaceId] do
			if os.clock() >= n5 then
				if v3 then
					return false, "Travel to the Third Sea timed out: " .. tostring(v3)
				end
				return false, "Travel to the Third Sea timed out"
			end

			local TravelZou, v4 = tbl11.Invoke("TravelZou")

			if v4 then
				warn(tostring(v4))
				v3 = v4
			elseif type(TravelZou) == "string" and TravelZou ~= "" then
				warn(tostring(TravelZou))
				v3 = TravelZou
			end

			task.wait(5)
		end

		return true, "The player is in the Third Sea"
	end,
}

local n5 = 5
local tbl13

tbl13 = {
	APIServerRetryDelay = 2,
	APITeleportResultTimeout = 15,
	APITeleportPollDelay = 0.1,
	APIServerMaxPlayers = 11,
	GroupJoinRetryDelay = 1.5,
	GroupJoinResultTimeout = 15,
	GroupJoinPollDelay = 0.1,
	APIModuleUrl = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/IDK.luau",
	APIServerListUrl = "http://163.223.9.144/boss/",
	APIModule = nil,
	APIServerNameMap = {
		FullMoon = "Fullmoon",
		["Cake Prince"] = "CakePrince",
		["Dough King"] = "DoughKing",
		["rip_indra True Form"] = "RipIndra",
		MysticIsland = "Mirage",
		["Cursed Captain"] = "CursedCaptain",
	},
	IsHttpGetAvailable = function()
		local ok, result = pcall(function()
			return game.HttpGet
		end)

		return ok and type(result) == "function"
	end,
	HttpGetText = function(arg)
		if tbl13.IsHttpGetAvailable() then
			local ok, result = pcall(function()
				return game:HttpGet(arg)
			end)

			if ok and type(result) == "string" and result ~= "" then
				return result, nil
			end
		end

		local v3

		if type(request) == "function" then
			v3 = request
		else
			v3 = nil

			if type(http_request) == "function" then
				v3 = http_request
			end
		end

		if not v3 then
			return nil, "No HTTP request function is available"
		end
		local ok, result = pcall(v3, { Url = arg, Method = "GET" })
		if not ok then
			return nil, "Failed to request " .. tostring(arg) .. ": " .. tostring(result)
		end

		if type(result) ~= "table" or type(result.Body) ~= "string" then
			return nil, "The response from " .. tostring(arg) .. " had no body"
		end
		return result.Body, nil
	end,
	CountAPIServers = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" then
			return nil, "NameBoss must be a non-empty string"
		end
		local v3, v4 = tbl13.HttpGetText(tbl13.APIServerListUrl .. arg)
		if not v3 then
			return nil, v4
		end

		local ok, result = pcall(function()
			return HttpService:JSONDecode(v3)
		end)

		if not ok or type(result) ~= "table" then
			return nil, "Failed to decode the server list for " .. arg
		end

		if type(result.data) ~= "table" then
			return tonumber(result.count) or 0, nil
		end

		if arg2 == nil then
			return tonumber(result.count) or #result.data, nil
		end
		local n6 = 0

		for _, v5 in ipairs(result.data) do
			if type(v5) == "table" and v5.PlaceId == arg2 then
				n6 += 1
			end
		end

		return n6, nil
	end,
	GetServerBrowser = function()
		local serverBrowser = ReplicatedStorage:FindFirstChild("__ServerBrowser")
		if not serverBrowser or not serverBrowser:IsA("RemoteFunction") then
			return nil, "__ServerBrowser RemoteFunction is unavailable"
		end
		return serverBrowser, nil
	end,
	RequestPublicServers = function(arg, arg2, arg3)
		if not tbl13.IsHttpGetAvailable() then
			return nil, nil, "game:HttpGet is unavailable"
		end

		if arg2 ~= "Desc" then
			arg2 = "Asc"
		end

		local str = "https://games.roblox.com/v1/games/" .. tostring(placeId) .. "/servers/Public?sortOrder=" .. arg2 .. "&limit=100"

		if arg3 == true then
			str ..= "&excludeFullGames=true"
		end

		if type(arg) == "string" and arg ~= "" then
			str ..= "&cursor=" .. HttpService:UrlEncode(arg)
		end

		local result

		while true do
			local ok

			ok, result = pcall(function()
				return HttpService:JSONDecode(game:HttpGet(str))
			end)

			if not ok then
				return nil, nil, "Failed to request public servers: " .. tostring(result)
			else
				if type(result) == "table" and type(result.data) == "table" then
					break
				end
				task.wait(5)
			end
		end

		return result.data, result.nextPageCursor, nil
	end,
	TryBrowserTeleport = function(arg, arg2)
		local flooded = nil
		local v3 = nil

		local connection = TeleportService.TeleportInitFailed:Connect(function(arg3, arg4, arg5, arg6, arg7)
			if arg3 ~= localPlayer or arg6 ~= placeId then
				return
			end
			local isTeleportOptions = arg7 and arg7:IsA("TeleportOptions")
			local serverInstanceId = nil

			if isTeleportOptions then
				serverInstanceId = arg7.ServerInstanceId
			end

			if type(serverInstanceId) == "string" and serverInstanceId ~= "" and serverInstanceId ~= arg2 then
				return
			end
			flooded = arg4
			v3 = arg5
		end)

		local ok, result = pcall(function()
			arg:InvokeServer("teleport", arg2)
		end)

		if not ok then
			connection:Disconnect()
			return false, tostring(result)
		end
		local n6 = os.clock() + n5

		while true do
			if flooded == nil and os.clock() < n6 then
				local v4, v5 = tbl13.GetServerFullPrompt()

				if v4 then
					flooded = Enum.TeleportResult.Flooded
					v3 = v5
					break
				else
					task.wait(tbl13.APITeleportPollDelay)
					continue
				end
			end

			break
		end

		connection:Disconnect()
		if flooded ~= nil then
			local v4 = v3 or flooded
			return false, v4(v4)
		end
		return false, "Teleport request to server " .. arg2 .. " was not confirmed"
	end,
	HopNormalServer = function()
		local v3, v4 = tbl13.GetServerBrowser()
		if not v3 then
			return false, v4
		end
		local tbl14 = {}
		local str = ""
		local str2 = nil

		for i = 1, 10 do
			local v5, v6
			v5, str, v6 = tbl13.RequestPublicServers(str, "Desc", true)
			if not v5 then
				return false, v6
			end

			for _, v7 in ipairs(v5) do
				if type(v7) == "table" and type(v7.id) == "string" and type(v7.playing) == "number" and type(v7.maxPlayers) == "number" and v7.id ~= game.JobId and v7.playing >= 8 and v7.playing < v7.maxPlayers and not tbl14[v7.id] then
					tbl14[v7.id] = true
					local v8, v9 = tbl13.TryBrowserTeleport(v3, v7.id)
					str2 = tostring(v9)
				end
			end

			if type(str) ~= "string" or str == "" or str == "null" then
				break
			end
		end

		if str2 then
			return false, "Failed to teleport to a normal server: " .. str2
		end
		return false, "No public server with at least " .. tostring(8) .. " player(s) and an open slot was found"
	end,
	RejoinServer = function()
		local jobId = game.JobId
		if type(jobId) ~= "string" or jobId == "" then
			return false, "The current JobId is unavailable"
		end
		local v3, v4 = tbl13.GetServerBrowser()
		if not v3 then
			return false, v4
		end
		local v5, v6 = tbl13.TryBrowserTeleport(v3, jobId)
		return false, "Failed to rejoin server " .. jobId .. ": " .. tostring(v6)
	end,
	GetAPIModule = function()
		if type(tbl13.APIModule) == "table" and type(tbl13.APIModule.HopApi) == "function" then
			return tbl13.APIModule, nil
		end

		if not tbl13.IsHttpGetAvailable() then
			return nil, "game:HttpGet is unavailable"
		end

		if type(loadstring) ~= "function" then
			return nil, "loadstring is unavailable"
		end

		local ok, apiModule = pcall(function()
			local response = game:HttpGet(tbl13.APIModuleUrl)
			local chunk, v3 = loadstring(response)

			if type(chunk) ~= "function" then
				error("Failed to compile HopApi module: " .. tostring(v3))
			end

			return chunk()
		end)

		if not ok then
			return nil, "Failed to load HopApi module: " .. tostring(apiModule)
		end

		if type(apiModule) ~= "table" or type(apiModule.HopApi) ~= "function" then
			return nil, "HopApi module did not return a HopApi function"
		end
		tbl13.APIModule = apiModule
		return apiModule, nil
	end,
	APIServer = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" then
			return false, "NameBoss must be a non-empty string"
		end

		if arg2 == nil then
			arg2 = tbl13.APIServerMaxPlayers
		end

		if not tbl9.IsFiniteNumber(arg2) or arg2 < 1 then
			return false, "MaxPlayers must be a finite number greater than zero"
		end
		local n6 = math.floor(arg2)
		local v3, v4 = tbl13.GetAPIModule()
		if not v3 then
			return false, v4
		end
		local jobId = game.JobId
		local v5 = nil
		local v6 = nil

		local connection = TeleportService.TeleportInitFailed:Connect(function(arg3, arg4, arg5, arg6)
			if arg3 == localPlayer and arg6 == placeId then
				v5 = arg4
				v6 = arg5
			end
		end)

		local ok, result, result2 = pcall(v3.HopApi, tbl13.APIServerNameMap[arg] or arg, n6)
		if not ok then
			connection:Disconnect()
			return false, "HopApi failed: " .. tostring(result)
		end

		if result == true then
			local now = os.clock()

			while true do
				local flag = game.JobId == jobId and v5 == nil

				if flag then
					local apiTeleportResultTimeout = tbl13.APITeleportResultTimeout
					flag = os.clock() - now < apiTeleportResultTimeout
				end

				if flag then
					task.wait(tbl13.APITeleportPollDelay)
					continue
				end
				break
			end

			connection:Disconnect()
			if game.JobId ~= jobId then
				result2 = result2 or "HopApi completed the teleport"
				return true, result2
			end

			if v5 == Enum.TeleportResult.Flooded then
				local v7 = v6 or v5
				return false, "HopApi server is full getting another server: " .. v7(v7)
			end

			if v5 ~= nil then
				local v7 = v6 or v5
				return false, "HopApi teleport failed getting another server: " .. v7(v7)
			end
			return false, "HopApi teleport was not confirmed getting another server"
		end

		connection:Disconnect()
		return false, result2 or "HopApi found no matching server"
	end,
	RetryAPIServer = function(arg, arg2, arg3)
		local v3

		while true do
			if type(arg2) == "function" then
				local ok, result = pcall(arg2)
				if ok and result ~= true then
					return false, nil
				end
			end

			local v4
			v4, v3 = tbl13.APIServer(arg, arg3)
			if v4 then
				break
			end
			task.wait(tbl13.APIServerRetryDelay)
		end

		return true, v3
	end,
	GetServerFullPrompt = function()
		local ok, result, result2 = pcall(function()
			local robloxPromptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
			robloxPromptGui = robloxPromptGui and robloxPromptGui:FindFirstChild("promptOverlay")
			if not robloxPromptGui then
				return false, nil
			end

			for _, descendant in ipairs(robloxPromptGui:GetDescendants()) do
				if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
					local str = tostring(descendant.Text or "")
					if string.find(str, "772", 1, true) then
						return true, str
					end
				end
			end

			return false, nil
		end)

		if not ok then
			return false, nil
		end
		return result == true, result2
	end,
	JoinServer = function(arg, arg2, arg3)
		if type(arg) ~= "string" or arg == "" then
			return false, "JobId must be a non-empty string"
		end

		if arg == game.JobId then
			return true, "Already in server " .. arg
		end
		local v3, v4 = tbl13.GetServerBrowser()
		if not v3 then
			return false, v4
		end
		local jobId = game.JobId
		local flooded = nil
		local str = nil

		local connection = TeleportService.TeleportInitFailed:Connect(function(arg4, arg5, arg6, arg7, arg8)
			if arg4 ~= localPlayer then
				return
			end
			local isTeleportOptions = arg8 and arg8:IsA("TeleportOptions")
			local serverInstanceId = nil

			if isTeleportOptions then
				serverInstanceId = arg8.ServerInstanceId
			end

			if type(serverInstanceId) == "string" and serverInstanceId ~= "" and serverInstanceId ~= arg then
				return
			end
			flooded = arg5
			str = arg6
		end)

		local function fn8()
			if connection.Connected then
				connection:Disconnect()
			end
		end

		local n6 = 0
		local v5

		while game.JobId == jobId do
			if type(arg2) == "function" then
				local ok, result = pcall(arg2, arg)
				if not ok or result ~= true then
					fn8()
					return false, "The host cancelled or changed server " .. arg
				end
			end

			n6 += 1
			flooded = nil
			str = nil

			local ok, result = pcall(function()
				v3:InvokeServer("teleport", arg)
			end)

			if not ok then
				str = tostring(result)
			end

			if n6 == 1 or n6 % 10 == 0 then
				warn("Joining group server " .. arg .. " (attempt " .. tostring(n6) .. ")")
			end

			local now = os.clock()
			local exitTo = nil

			while true do
				local flag = ok and game.JobId == jobId and flooded == nil

				if flag then
					local groupJoinResultTimeout = tbl13.GroupJoinResultTimeout
					flag = os.clock() - now < groupJoinResultTimeout
				end

				if flag then
					local v6
					v6, v5 = tbl13.GetServerFullPrompt()

					if v6 then
						exitTo = 2
						break
					elseif type(arg2) ~= "function" then
						task.wait(tbl13.GroupJoinPollDelay)
						continue
					else
						local ok2, result2 = pcall(arg2, arg)
						if not (not ok2 or result2 ~= true) then
							task.wait(tbl13.GroupJoinPollDelay)
							continue
						end
					end
				else
					exitTo = 1
					break
				end

				break
			end

			if exitTo ~= 1 then
				if exitTo ~= 2 then
					fn8()
					return false, "The host cancelled or changed server " .. arg
				end
				flooded = Enum.TeleportResult.Flooded
				str = v5
			end

			if flooded == Enum.TeleportResult.Flooded then
				local flag = false
				local result2 = nil

				if type(arg3) == "function" then
					local ok2, result3
					ok2, result3, result2 = pcall(arg3, arg, str)

					if ok2 then
						flag = result3 == true
					else
						result2 = result3
					end
				end

				fn8()
				if flag then
					return false, "Group server " .. arg .. " is full helper 1 is finding another Full Moon"
				end
				return false, "Group server " .. arg .. " is full" .. (result2 and ": " .. tostring(result2) or "")
			end

			if flooded == Enum.TeleportResult.GameNotFound or flooded == Enum.TeleportResult.GameEnded or flooded == Enum.TeleportResult.Unauthorized then
				fn8()
				local v6 = str or flooded
				return false, "Cannot join group server " .. arg .. ": " .. v6(v6)
			end

			if game.JobId == jobId then
				task.wait(tbl13.GroupJoinRetryDelay)
			end
		end

		fn8()
		return true, "Joined group server " .. arg
	end,
}

local str = "Marines"
local tbl14

tbl14 = {
	JoinSettleDelay = 5,
	IsOnTeam = function(arg)
		local team = localPlayer.Team
		return team ~= nil and team.Name == arg
	end,
	HopAfterTimeout = function(arg)
		local v3, v4 = tbl13.HopNormalServer()
		if not v3 then
			return false, arg .. " (server hop failed: " .. tostring(v4) .. ")"
		end
		return false, arg .. " (" .. tostring(v4) .. ")"
	end,
	Join = function(arg, arg2)
		if arg == nil then
			arg = "Marines"
		end

		if tbl14.IsOnTeam(arg) then
			return true, nil
		end

		if arg2 == nil then
			arg2 = 10
		end

		if not tbl9.IsFiniteNumber(arg2) or arg2 <= 0 then
			return false, "Timeout must be a finite number greater than zero"
		end
		local v3, v4 = tbl11.GetRemote()
		if not v3 then
			return false, v4
		end
		local n6 = os.clock() + arg2
		local v5 = nil

		while true do
			local SetTeam, v6 = tbl11.Invoke("SetTeam", arg)
			v5 = v6 or v5
			if tbl14.IsOnTeam(arg) then
				task.wait(tbl14.JoinSettleDelay)
				return true, nil
			end
			task.wait(0.5)
			if not (n6 <= os.clock()) then
				continue
			end
			break
		end

		if tbl14.IsOnTeam(arg) then
			task.wait(tbl14.JoinSettleDelay)
			return true, nil
		end

		if v5 then
			return tbl14.HopAfterTimeout("Failed to join the " .. arg .. " team: " .. v5)
		end
		return tbl14.HopAfterTimeout("Timed out while joining the " .. arg .. " team")
	end,
}

local n6 = 3
local tbl15

tbl15 = {
	IsEnabled = function(arg)
		return arg ~= nil and (arg:FindFirstChild("HasBuso") ~= nil or arg:FindFirstChild("Buso") ~= nil)
	end,
	Enable = function()
		local character = localPlayer.Character
		if not character then
			return false, "Local character is unavailable"
		end

		if tbl15.IsEnabled(character) then
			return true, nil
		end
		local Buso, v3 = tbl11.Invoke("Buso")
		if v3 then
			return false, v3
		end
		local now = os.clock()

		while os.clock() - now < n6 do
			if tbl15.IsEnabled(localPlayer.Character) then
				return true, nil
			end
			task.wait(0.1)
		end

		return false, "The Buso remote completed, but the character received no Buso marker"
	end,
}

local tbl16

tbl16 = {
	SetAim = function(kaitun6V4AimPosition)
		genv.Kaitun6V4AimPosition = kaitun6V4AimPosition
	end,
	HookAim = function()
		if genv.Kaitun6V4AimHooked then
			return true, nil
		end

		if type(getrawmetatable) ~= "function" or type(setreadonly) ~= "function" or type(newcclosure) ~= "function" or type(getnamecallmethod) ~= "function" then
			return false, "Skill aim hooks are unavailable"
		end
		local v3 = nil

		local ok, result = pcall(function()
			v3 = getrawmetatable(game)
			local namecall = v3.__namecall
			setreadonly(v3, false)

			v3.__namecall = newcclosure(function(...)
				local v4 = table.pack(...)
				local v5 = table.pack(...)
				local kaitun6V4AimPosition = genv.Kaitun6V4AimPosition

				if kaitun6V4AimPosition and getnamecallmethod() == "FireServer" and typeof(v5[1]) == "Instance" and v5[1].Name == "RemoteEvent" and type(v5[2]) ~= "boolean" then
					if typeof(v5[2]) == "CFrame" then
						v5[2] = CFrame.new(kaitun6V4AimPosition)
					else
						v5[2] = kaitun6V4AimPosition
					end

					return namecall(table.unpack(v5, 1, v5.n))
				end

				return namecall(table.unpack(v4, 1, v4.n))
			end)
		end)

		if v3 then
			pcall(setreadonly, v3, true)
		end

		if not ok then
			return false, "Failed to hook the skill aim: " .. tostring(result)
		end
		genv.Kaitun6V4AimHooked = true
		return true, nil
	end,
	PressKey = function(arg)
		local ok, result = pcall(function()
			VirtualInputManager:SendKeyEvent(true, arg, false, game)
			task.wait()
			VirtualInputManager:SendKeyEvent(false, arg, false, game)
		end)

		if not ok then
			return false, "Failed to press " .. tostring(arg) .. ": " .. tostring(result)
		end
		return true, nil
	end,
	CastKeys = function(arg, arg2)
		for _, v3 in ipairs(arg) do
			local v4, v5 = tbl16.PressKey(v3)
			if not v4 then
				return false, v5
			end
			task.wait(arg2)
		end

		return true, nil
	end,
}

local n7 = 60
local n8 = 0.3
local tbl17 = { "Util", "Common", "Remotes", "Assets", "FX" }
local v3 = nil
local v4 = nil
local v5 = nil
local n9 = 0
local tbl18 = { Active = false, Connection = nil, WatcherConnections = {} }
local tbl19

tbl19 = {
	GetNet = function()
		local modules = ReplicatedStorage:FindFirstChild("Modules")
		return modules and modules:FindFirstChild("Net")
	end,
	TrackRemote = function(arg)
		if not arg:IsA("RemoteEvent") then
			return
		end
		local attribute = arg:GetAttribute("Id")
		if attribute == nil then
			return
		end
		v3 = arg
		v4 = attribute
	end,
	ScrambleName = function(arg)
		local n10 = math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1

		return (string.gsub(arg, ".", function(arg2)
			return string.char(bit32.bxor(string.byte(arg2), n10))
		end))
	end,
	GetLocalAttacker = function()
		local v6, v7, v8, v9 = tbl9.GetLocalCharacter()
		if not v6 then
			return nil, nil, v9
		end

		if not v6:FindFirstChildWhichIsA("Tool") then
			return nil, nil, "Local character has no equipped Tool"
		end
		return v6, v8, nil
	end,
	ResolveHitPart = function(arg, arg2)
		local head = arg:FindFirstChild("Head")
		if head and head:IsA("BasePart") then
			return head
		end
		return arg2
	end,
	CollectMobTargets = function(arg, arg2)
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return nil, nil, "Enemies folder is unavailable"
		end
		local position = arg.Position
		local tbl20 = {}

		for _, child in ipairs(enemies:GetChildren()) do
			if not arg2 or child.Name == arg2 then
				local humanoid = child:FindFirstChildWhichIsA("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") and (humanoidRootPart.Position - position).Magnitude <= n7 then
					tbl20[#tbl20 + 1] = { Mob = child, HitPart = tbl19.ResolveHitPart(child, humanoidRootPart), Health = humanoid.Health }
				end
			end
		end

		table.sort(tbl20, function(arg3, arg4)
			return arg3.Health < arg4.Health
		end)

		local tbl21 = {}
		local hitPart = nil

		for _, v6 in ipairs(tbl20) do
			hitPart = hitPart or v6.HitPart
			tbl21[#tbl21 + 1] = { v6.Mob, v6.HitPart }
		end

		if not hitPart then
			if arg2 then
				return nil, tbl21, "No living target named " .. tostring(arg2) .. " is within attack range"
			end
			return nil, tbl21, "No living target is within attack range"
		end

		return hitPart, tbl21, nil
	end,
	FireScrambledHit = function(arg, arg2)
		if not v3 or not v4 or not v5 then
			return true, nil
		end

		if not v3.Parent then
			return true, nil
		end

		local ok, result = pcall(function()
			local v6 = v3

			if type(cloneref) == "function" then
				v6 = cloneref(v3)
			end

			v6:FireServer(tbl19.ScrambleName("RE/RegisterHit"), bit32.bxor(v4 + 909090, v5 * 2), arg, arg2)
		end)

		if not ok then
			return false, "Failed to fire scrambled hit remote: " .. tostring(result)
		end
		return true, nil
	end,
	FireAttackRemotes = function(arg, arg2)
		local v6 = tbl19.GetNet()
		if not v6 then
			return false, "Net module is unavailable"
		end
		local reRegisterAttack = v6:FindFirstChild("RE/RegisterAttack")
		local reRegisterHit = v6:FindFirstChild("RE/RegisterHit")
		if not reRegisterAttack then
			return false, "RegisterAttack remote is unavailable"
		end

		if not reRegisterHit then
			return false, "RegisterHit remote is unavailable"
		end

		local ok, result = pcall(function()
			reRegisterAttack:FireServer(0.3)
			reRegisterHit:FireServer(arg, arg2)
		end)

		if not ok then
			return false, "Failed to fire attack remotes: " .. tostring(result)
		end
		return tbl19.FireScrambledHit(arg, arg2)
	end,
	IsOnCooldown = function()
		return n8 > 0 and os.clock() - n9 < n8
	end,
	IsTransientError = function(arg)
		if arg == "Attack is on cooldown" then
			return true
		end
		return type(arg) == "string" and string.find(arg, "No living target", 1, true) ~= nil
	end,
	WatchRemotes = function()
		tbl10.DisconnectAll(tbl18.WatcherConnections)
		local watcherConnections = tbl18.WatcherConnections

		for _, v6 in ipairs(tbl17) do
			local v7 = ReplicatedStorage:FindFirstChild(v6)

			if v7 then
				for _, child in ipairs(v7:GetChildren()) do
					tbl19.TrackRemote(child)
				end

				local ok, result = pcall(function()
					return v7.ChildAdded:Connect(tbl19.TrackRemote)
				end)

				if ok then
					watcherConnections[#watcherConnections + 1] = result
				end
			end
		end

		return true, nil
	end,
	RefreshSeed = function()
		local v6 = tbl19.GetNet()
		local seed = v6 and v6:FindFirstChild("seed")
		if not seed then
			return false, "Seed remote is unavailable"
		end

		local ok, result = pcall(function()
			return seed:InvokeServer()
		end)

		if not ok then
			return false, "Failed to invoke the seed remote: " .. tostring(result)
		end
		v5 = result
		return true, nil
	end,
	Attack = function(arg)
		if tbl19.IsOnCooldown() then
			return false, "Attack is on cooldown"
		end
		local v6, v7, v8 = tbl19.GetLocalAttacker()
		if not v7 then
			return false, v8
		end
		local v9, v10, v11 = tbl19.CollectMobTargets(v7, arg)
		if not v9 then
			return false, v11
		end
		n9 = os.clock()
		return tbl19.FireAttackRemotes(v9, v10)
	end,
	AttackPlayer = function(arg)
		if tbl19.IsOnCooldown() then
			return false, "Attack is on cooldown"
		end

		if typeof(arg) ~= "Instance" or not arg:IsA("Player") or arg == localPlayer then
			return false, "Target player is invalid"
		end
		local v6, v7, v8 = tbl19.GetLocalAttacker()
		if not v7 then
			return false, v8
		end
		local character = arg.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		if not character or not humanoid or humanoid.Health <= 0 or not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
			return false, "Target player character is unavailable or dead"
		end

		if n7 < (humanoidRootPart.Position - v7.Position).Magnitude then
			return false, "Target player is outside attack range"
		end
		local v9 = tbl19.ResolveHitPart(character, humanoidRootPart)
		n9 = os.clock()
		return tbl19.FireAttackRemotes(v9, { { character, v9 } })
	end,
	Start = function(arg)
		if arg ~= nil and type(arg) ~= "string" then
			return false, "MobName must be a string or nil"
		end
		tbl19.Stop()

		local ok, connection = pcall(function()
			return RunService.Heartbeat:Connect(function()
				if not tbl18.Active then
					return
				end
				tbl19.Attack(arg)
			end)
		end)

		if not ok then
			return false, "Failed to start the attack loop: " .. tostring(connection)
		end
		tbl18.Active = true
		tbl18.Connection = connection
		return true, nil
	end,
	Stop = function()
		tbl18.Active = false
		tbl10.Disconnect(tbl18.Connection)
		tbl18.Connection = nil
		return true, nil
	end,
	IsRunning = function()
		return tbl18.Active and tbl18.Connection ~= nil
	end,
}

tbl10.ClaimSharedRuntime("Kaitun6V4AttackRuntime", tbl18)
local flag = type(isnetworkowner) == "function" and isnetworkowner or nil
local tbl20

tbl20 = {
	ResolveAnchor = function(arg, arg2)
		local v6, v7 = tbl9.CreateTargetState(arg)
		if not v6 then
			return nil, v7
		end
		local n10, v8, v9, v10 = tbl9.ResolveTargetFrame(v6)
		if v9 or not n10 then
			return nil, v10 or "Target CFrame is unavailable"
		end

		if not v8 then
			local rotation = arg2.Rotation
			n10 = CFrame.new(n10.Position) * rotation
		end

		return n10, nil
	end,
	HasNetworkOwnership = function(arg)
		if not flag then
			return false, "The isnetworkowner function is unavailable"
		end

		if not arg or not arg:IsA("BasePart") or not arg.Parent then
			return false, "Mob HumanoidRootPart is unavailable"
		end
		local ok, result = pcall(flag, arg)
		if not ok then
			return false, "The isnetworkowner check failed: " .. tostring(result)
		end
		return result == true, nil
	end,
	ResolveTargetModel = function(arg)
		if typeof(arg) == "Instance" and arg:IsA("Model") then
			return arg
		end
		return nil
	end,
	PullMob = function(arg, cFrame)
		return pcall(function()
			arg.CanCollide = false
			arg.CFrame = cFrame
			arg.AssemblyLinearVelocity = Vector3.zero
			arg.AssemblyAngularVelocity = Vector3.zero
		end)
	end,
	Gather = function(arg, arg2, arg3)
		if arg2 ~= nil and type(arg2) ~= "string" then
			return 0, "MobName must be a string or nil"
		end

		if arg3 == nil then
			arg3 = 350
		end

		if not tbl9.IsFiniteNumber(arg3) or arg3 <= 0 then
			return 0, "Range must be a finite number greater than zero"
		end

		if not flag then
			return 0, "isnetworkowner is unavailable"
		end
		local v6, v7, v8, v9 = tbl9.GetLocalCharacter()
		if not v6 or not v8 then
			return 0, v9
		end

		local ok, result = pcall(function()
			return v6:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return 0, "Local character pivot is invalid"
		end
		local v10, v11 = tbl20.ResolveAnchor(arg, result)
		if not v10 then
			return 0, v11
		end
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return 0, "Enemies folder is unavailable"
		end
		local v12 = tbl20.ResolveTargetModel(arg)
		local position = v8.Position
		local n10 = 0
		local str2 = nil

		for _, child in ipairs(enemies:GetChildren()) do
			if child ~= v12 and (not arg2 or child.Name == arg2) then
				local humanoid = child:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") and (humanoidRootPart.Position - position).Magnitude <= arg3 then
					local v13, v14 = tbl20.HasNetworkOwnership(humanoidRootPart)

					if v13 then
						local v15, v16 = tbl20.PullMob(humanoidRootPart, v10)

						if v15 then
							n10 += 1
						else
							str2 = "Failed to gather " .. child.Name .. ": " .. tostring(v16)
						end
					else
						str2 = v14 or str2
					end
				end
			end
		end

		return n10, str2
	end,
}

local flag2 = type(firetouchinterest) == "function" and firetouchinterest or nil
local tbl21

tbl21 = {
	GetAliveRoot = function()
		local v6, v7, v8, v9 = tbl9.GetLocalCharacter()
		if not v6 or not v8 then
			return nil, nil, v9
		end
		return v6, v8, nil
	end,
	WaitForAliveRoot = function()
		local v6, v7

		while true do
			v6, v7 = tbl21.GetAliveRoot()

			if v6 then
				break
			else
				task.wait(0.1)
			end
		end

		return v6, v7
	end,
	GetHealthRatio = function()
		local character = localPlayer.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not character or character.MaxHealth <= 0 then
			return 1
		end
		return character.Health / character.MaxHealth
	end,
	WaitForRespawnIfDead = function()
		if tbl21.GetAliveRoot() then
			return false
		end
		tbl21.WaitForAliveRoot()
		return true
	end,
	PreventSit = function(arg)
		arg = arg and arg:FindFirstChildOfClass("Humanoid")

		if arg and arg.Sit then
			arg.Sit = false
			arg:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end,
	HasItem = function(arg)
		if type(arg) ~= "string" or arg == "" then
			return false
		end
		local backpack = localPlayer:FindFirstChild("Backpack")
		if backpack and backpack:FindFirstChild(arg) then
			return true
		end
		local character = localPlayer.Character
		return character ~= nil and character:FindFirstChild(arg) ~= nil
	end,
	IsMeleeTool = function(arg)
		if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
			return false
		end
		return arg:GetAttribute("WeaponType") == "Melee" or arg.ToolTip == "Melee"
	end,
	TryEquipTool = function(arg, arg2, arg3, arg4, arg5)
		for i = 1, 10 do
			if not arg.Parent or arg2.Health <= 0 then
				return nil, "Local character became unavailable while equipping " .. arg4
			end

			if not arg3.Parent then
				return nil, "The selected " .. arg4 .. " tool became unavailable"
			end

			local ok, result = pcall(function()
				arg2:EquipTool(arg3)
			end)

			if not ok then
				return nil, "Failed to equip " .. arg4 .. ": " .. tostring(result)
			end
			RunService.Heartbeat:Wait()
			local tool = arg:FindFirstChildOfClass("Tool")
			if arg5(tool) then
				return tool, nil
			end
		end

		return nil, "Humanoid:EquipTool did not move " .. arg4 .. " into Character"
	end,
	EquipMelee = function()
		local character = localPlayer.Character
		local humanoid = character and character:FindFirstChildOfClass("Humanoid")
		if not character or not humanoid or humanoid.Health <= 0 then
			return nil, "Local humanoid is unavailable or dead"
		end
		local tool = character:FindFirstChildOfClass("Tool")
		if tbl21.IsMeleeTool(tool) then
			return tool, nil
		end
		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if tbl21.IsMeleeTool(child) then
					return tbl21.TryEquipTool(character, humanoid, child, "Melee", tbl21.IsMeleeTool)
				end
			end
		end

		return nil, "No Melee tool was found in the Backpack or Character"
	end,
	EquipItem = function(arg)
		if type(arg) ~= "string" or arg == "" then
			return nil, "Item name must be a non-empty string"
		end
		local v6 = tbl21.WaitForAliveRoot()
		local humanoid = v6:FindFirstChildOfClass("Humanoid")
		if not humanoid or humanoid.Health <= 0 then
			return nil, "Local humanoid is unavailable or dead"
		end
		local v7 = v6:FindFirstChild(arg)
		if v7 and v7:IsA("Tool") then
			return v7, nil
		end
		local backpack = localPlayer:FindFirstChild("Backpack")
		backpack = backpack and backpack:FindFirstChild(arg)
		if not backpack or not backpack:IsA("Tool") then
			return nil, arg .. " was not found in Backpack or Character"
		end

		return tbl21.TryEquipTool(v6, humanoid, backpack, arg, function(arg2)
			return typeof(arg2) == "Instance" and arg2:IsA("Tool") and arg2.Name == arg
		end)
	end,
}

local n10 = 100
local n11 = 1500
local n12 = 10000
local n13 = 5
local flag3 = false

local tbl22 = {
	{
		Vector3.new(61163.85, 5.337033, 1819.784),
		Vector3.new(3863.9893, 5.457043, -1929.5609),
		Vector3.new(-4625.7827, 930.5339, -1702.791),
		Vector3.new(-7923.1855, 5565.5625, -378.75677),
	},
	{
		Vector3.new(-315.51932, 331.89066, 614.8649),
		Vector3.new(2288.1086, 15.181684, 842.8977),
		Vector3.new(861.2258, 130.80856, 32849.61),
		Vector3.new(-6493.257, 116.21698, -111.39042),
	},
	{
		Vector3.new(-12548.324, 341.781, -7487.3125),
		Vector3.new(-5037.7803, 314.54593, -3145.043),
		Vector3.new(5650.301, 1082.4382, -349.40088),
	},
}

local tbl23 = {
	["Flower 1"] = true,
	["Flower 2"] = true,
	["Flower 3"] = true,
	["Fist of Darkness"] = true,
	["Core Brain"] = true,
	Microchip = true,
	["Hellfire Torch"] = true,
}

local tbl24

tbl24 = {
	GetSeaIndex = function()
		if tbl[placeId] then
			return 1
		end

		if tbl2[placeId] then
			return 2
		end

		if tbl3[placeId] then
			return 3
		end
		return nil
	end,
	HorizontalDistance = function(arg, arg2)
		local x = arg2.X
		return (Vector3.new(arg.X, 0, arg.Z) - Vector3.new(x, 0, arg2.Z)).Magnitude
	end,
	ResolveTargetCFrame = function(arg)
		local character = localPlayer.Character
		if not character or not character.Parent then
			return nil, "Local character is unavailable"
		end

		local ok, result = pcall(function()
			return character:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return nil, "Local character pivot is invalid"
		end
		return tbl20.ResolveAnchor(arg, result)
	end,
	IsWeaponTool = function(arg)
		if typeof(arg) ~= "Instance" or not arg:IsA("Tool") then
			return false
		end
		local attribute = arg:GetAttribute("WeaponType")
		local toolTip = arg.ToolTip
		return attribute == "Melee" or attribute == "Sword" or attribute == "Gun" or toolTip == "Melee" or toolTip == "Sword" or toolTip == "Gun"
	end,
	IsProtectedTool = function(arg, arg2)
		if not arg:IsA("Tool") then
			return false
		end

		if string.find(string.lower(arg.Name), "fruit", 1, true) then
			return true
		end

		if tbl23[arg.Name] == true then
			return true
		end
		return arg2 and arg.Name ~= "Tool" and not tbl24.IsWeaponTool(arg) and arg.ToolTip == "" and arg:FindFirstChildOfClass("RemoteFunction") == nil
	end,
	HasProtectedTool = function()
		local tbl25 = { Instance = localPlayer.Character, Name = "Character", ProtectUnknown = false }

		for _, v6 in ipairs({ { Instance = localPlayer:FindFirstChild("Backpack"), Name = "Backpack", ProtectUnknown = true }, tbl25 }) do
			local instance = v6.Instance

			if instance then
				for _, child in ipairs(instance:GetChildren()) do
					if tbl24.IsProtectedTool(child, v6.ProtectUnknown) then
						return true, child.Name, v6.Name
					end
				end
			end
		end

		return false, nil, nil
	end,
	CanReset = function()
		local v6, v7, v8 = tbl24.HasProtectedTool()
		if v6 then
			return false, "Reset is disabled while carrying protected tool " .. tostring(v7) .. " (" .. tostring(v8) .. ")"
		end
		return true, nil
	end,
	RequestBestEntrance = function(arg, arg2)
		local v6 = tbl24.GetSeaIndex()
		v6 = v6 and tbl22[v6]
		if not v6 then
			return false, nil, "No entrance table exists for the current sea"
		end
		local tbl25 = {}

		for _, v7 in ipairs(v6) do
			tbl25[#tbl25 + 1] = v7
		end

		table.sort(tbl25, function(arg3, arg4)
			return tbl24.HorizontalDistance(arg3, arg2) < tbl24.HorizontalDistance(arg4, arg2)
		end)

		local v7 = tbl24.HorizontalDistance(arg.Position, arg2)

		for _, v8 in ipairs(tbl25) do
			if tbl24.HorizontalDistance(v8, arg2) >= v7 then
				break
			end

			if not arg.Parent then
				return false, nil, "Character was lost before requestEntrance"
			end
			local position = arg.Position
			if tbl24.HorizontalDistance(position, v8) <= n10 then
				return true, v8, nil
			end
			local requestEntrance, v9 = tbl11.Invoke("requestEntrance", v8)
			if v9 then
				return false, nil, v9
			end
			task.wait(0.25)
			if arg.Parent and (arg.Position - position).Magnitude > n10 then
				return true, v8, nil
			end
		end

		return true, nil, nil
	end,
	GetNearestSpawn = function(arg)
		local worldOrigin = Workspace:FindFirstChild("_WorldOrigin")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild("PlayerSpawns")
		local team = localPlayer.Team
		if not team then
			return nil, nil, "The player has not joined a team"
		end
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild(team.Name)
		if not worldOrigin then
			return nil, nil, "No spawn folder exists for the " .. team.Name .. " team"
		end
		local n14 = 3000
		local v6 = nil
		local v7 = nil

		for _, child in ipairs(worldOrigin:GetChildren()) do
			local ok, result = pcall(function()
				return child:GetPivot()
			end)

			if ok and tbl9.IsFiniteCFrame(result) then
				local v8 = tbl24.HorizontalDistance(result.Position, arg)

				if v8 <= n14 then
					v6 = child
					n14 = v8
					v7 = result
				end
			end
		end

		if not v6 then
			return nil, nil, "No suitable spawn exists near the target"
		end
		return v6, v7, nil
	end,
	GetSpawnNodes = function()
		local worldOrigin = Workspace:FindFirstChild("_WorldOrigin")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild("PlayerSpawns")
		local team = localPlayer.Team
		local v6 = team and worldOrigin and worldOrigin:FindFirstChild(team.Name)
		local tbl25 = {}
		if not v6 then
			return tbl25
		end

		for _, child in ipairs(v6:GetChildren()) do
			local ok, result = pcall(function()
				return child:GetPivot()
			end)

			if ok and tbl9.IsFiniteCFrame(result) then
				tbl25[#tbl25 + 1] = { Name = child.Name, Position = result.Position }
			end
		end

		return tbl25
	end,
	FindSpawnPath = function(arg, arg2, arg3)
		local v6 = tbl24.GetSpawnNodes()
		local tbl25 = {}
		local tbl26 = {}
		local tbl27 = {}
		arg3 = arg3 or {}

		for _, v7 in ipairs(v6) do
			if not arg3[v7.Name] and (v7.Position - arg).Magnitude <= n12 then
				tbl26[v7.Name] = true
				tbl27[#tbl27 + 1] = v7
			end
		end

		local n14 = 1

		while n14 <= #tbl27 do
			local v7 = tbl27[n14]
			n14 += 1

			if v7.Name == arg2 then
				local tbl28 = {}
				local name = v7.Name

				while name do
					table.insert(tbl28, 1, name)
					name = tbl25[name]
				end

				return tbl28
			end

			for _, v8 in ipairs(v6) do
				if not tbl26[v8.Name] and not arg3[v8.Name] and (v7.Position - v8.Position).Magnitude <= n12 then
					tbl26[v8.Name] = true
					tbl25[v8.Name] = v7.Name
					tbl27[#tbl27 + 1] = v8
				end
			end
		end

		return nil
	end,
	ClaimSpawn = function(arg, arg2, arg3, arg4)
		local n14 = os.clock() + n13

		repeat
			if not arg3.Parent or not arg4.Parent or arg4.Health <= 0 then
				return false, "Character died before the spawn point was accepted", true
			end
			local SetLastSpawnPoint, v6 = tbl11.Invoke("SetLastSpawnPoint", arg2)
			if v6 then
				return false, v6
			end

			if arg.Value == arg2 then
				return true, nil
			end
			task.wait()
		until os.clock() >= n14

		return false, arg2 .. " was not accepted as the spawn point"
	end,
	WaitForAliveCharacter = function(arg)
		local v6, v7, v8

		while true do
			v6, v7, v8 = tbl9.GetLocalCharacter()
			if not (v6 and v7 and v8 and v6 ~= arg) then
				task.wait(0.1)
				continue
			end
			break
		end

		return v6, v8, v7
	end,
	RunResetTeleport = function(arg)
		local v6, v7 = tbl24.ResolveTargetCFrame(arg)
		if not v6 then
			return false, v7
		end
		local v8, v9, v10 = tbl24.WaitForAliveCharacter(nil)
		tbl9.StopActiveJob("Preparing reset teleport")
		local v11, v12 = tbl24.CanReset()

		if not v11 then
			local v13, v14, v15 = tbl24.RequestBestEntrance(v9, v6.Position)

			if v15 then
				warn(tostring(v15))
			end

			warn(tostring(v12))
			return true, v12 .. (v14 and " used requestEntrance" or "") .. " continue with Tween"
		end

		local v13, v14, v15 = tbl24.GetNearestSpawn(v6.Position)
		if not v13 or not v14 then
			warn(tostring(v15))
			return true, tostring(v15) .. " continue with Tween"
		end
		local data = localPlayer:WaitForChild("Data", 10)
		data = data and data:WaitForChild("LastSpawnPoint", 10)
		if not data then
			return false, "Data.LastSpawnPoint did not load in time"
		end
		local tbl25 = {}
		local n14 = 0

		while n11 < tbl24.HorizontalDistance(v9.Position, v14.Position) do
			local v16 = tbl24.FindSpawnPath(v9.Position, v13.Name, tbl25)
			if not v16 then
				return true, v13.Name .. " has no reachable spawn chain continue with Tween"
			end
			local v17 = v16[1]
			local v18, v19, v20 = tbl24.ClaimSpawn(data, v17, v8, v10)

			if v20 then
				warn(tostring(v19))
			elseif v18 then
				local ok, result = pcall(function()
					v10.Health = 0
				end)

				if not ok then
					return false, "Failed to reset the character: " .. tostring(result)
				end
			else
				tbl25[v17] = true
			end

			if v18 or v20 then
				n14 += 1
				v8, v9, v10 = tbl24.WaitForAliveCharacter(v8)
			end
		end

		if n14 == 0 then
			return true, "Already within reach of " .. v13.Name
		end
		return true, string.format("Respawned at %s after %d hop%s", v13.Name, n14, n14 == 1 and "" or "s")
	end,
	ResetTeleport = function(arg)
		if flag3 then
			return false, "ResetTeleport is already running"
		end
		flag3 = true
		local ok, result, result2 = pcall(tbl24.RunResetTeleport, arg)
		flag3 = false
		if not ok then
			return false, "ResetTeleport error: " .. tostring(result)
		end
		return result, result2
	end,
	StopJob = function(arg)
		if arg and arg:IsRunning() then
			arg:Stop()
		end
	end,
	Travel = function(arg, arg2, arg3)
		local v6, v7 = tbl24.ResolveTargetCFrame(arg)
		if not v6 then
			return tbl9.CreateNullController(v7), v7
		end
		local v8, v9 = tbl9.ResolveOffset(arg3)
		if not v8 then
			return tbl9.CreateNullController(v9), v9
		end
		tbl9.StopActiveJob("Preparing travel")
		local v10, v11 = tbl24.ResetTeleport(v6 * v8)
		if not v10 then
			return tbl9.CreateNullController(v11), v11
		end
		tbl21.WaitForAliveRoot()
		return Tween(arg, arg2, arg3)
	end,
	MoveToPosition = function(arg, arg2)
		if typeof(arg) ~= "Vector3" then
			return false, "Move position must be a Vector3"
		end

		if arg2 == nil then
			arg2 = 10
		end

		if not tbl9.IsFiniteNumber(arg2) or arg2 <= 0 then
			return false, "Tolerance must be a finite number greater than zero"
		end
		local v6, v7 = tbl24.Travel(arg)
		if v7 then
			return false, v7
		end

		while true do
			local v8
			v8, v8 = tbl21.WaitForAliveRoot()

			if (v8.Position - arg).Magnitude <= arg2 then
				tbl24.StopJob(v6)
				return true, nil
			else
				if not v6:IsRunning() then
					break
				end
				task.wait(0.25)
			end
		end

		return false, v6:GetReason() or "Tween stopped before reaching the position"
	end,
	MoveToPart = function(arg, arg2)
		if typeof(arg) ~= "Instance" or not arg:IsA("BasePart") or not arg.Parent then
			return false, "Target part is unavailable"
		end

		if arg2 == nil then
			arg2 = 10
		end

		local v6, v7 = tbl24.Travel(arg)
		if v7 then
			return false, v7
		end

		while true do
			if not arg.Parent then
				tbl24.StopJob(v6)
				return false, "Target part was removed while moving"
			else
				local v8, v9, v10 = tbl21.GetAliveRoot()
				if not v8 or not v9 then
					tbl24.StopJob(v6)
					return false, v10
				end

				if (v9.Position - arg.Position).Magnitude <= arg2 then
					tbl24.StopJob(v6)
					return true, nil
				end

				if not v6:IsRunning() then
					break
				end
				task.wait(0.25)
			end
		end

		return false, v6:GetReason() or "Tween stopped before reaching the target part"
	end,
}

local n14 = 0.6
local n15 = 0.4

local tbl25 = {
	"Dressrosa",
	"GhostShipInterior",
	"CircleIsland",
	"GraveIsland",
	"GreenBit",
	"ForgottenIsland",
	"SnowMountain",
	"IceCastle",
	"DarkbeardArena",
	"Mini1",
	"Mini2",
}

local tbl26

tbl26 = {
	IsCollectable = function(arg)
		return arg ~= nil and arg.Parent ~= nil and not arg:GetAttribute("IsDisabled") and arg:FindFirstChild("TouchInterest", true) ~= nil
	end,
	GetPosition = function(arg)
		if not arg or not arg.Parent then
			return nil
		end

		if arg:IsA("BasePart") then
			return arg.Position
		end

		local ok, result = pcall(function()
			return arg:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return nil
		end
		return result.Position
	end,
	FindMap = function(arg)
		local map = Workspace:FindFirstChild("Map")
		return map and map:FindFirstChild(arg)
	end,
	GetMapPosition = function(arg)
		local v6 = tbl26.FindMap(arg)
		if not v6 then
			return nil
		end

		local ok, result = pcall(function()
			return v6:GetPivot()
		end)

		if ok and tbl9.IsFiniteCFrame(result) then
			return result.Position
		end
		local basePart = v6:FindFirstChildWhichIsA("BasePart", true)
		return basePart and basePart.Position or nil
	end,
	ScanMap = function(arg)
		local tbl27 = {}
		local v6 = tbl26.FindMap(arg)
		if not v6 then
			return tbl27
		end

		for _, v7 in ipairs(CollectionService:GetTagged("_ChestTagged")) do
			if v7:IsDescendantOf(v6) and tbl26.IsCollectable(v7) then
				tbl27[#tbl27 + 1] = v7
			end
		end

		return tbl27
	end,
	FindNearest = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(arg) do
			if v8.Parent and not arg3[v8] then
				local v9 = tbl26.GetPosition(v8)

				if v9 then
					local magnitude = (v9 - arg2.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v6 = v8
						v7 = v9
					end
				end
			end
		end

		return v6, v7
	end,
	Touch = function(arg, arg2)
		if not flag2 then
			return false, "The firetouchinterest function is unavailable"
		end
		local flag4 = false

		local ok, result = pcall(function()
			for _, descendant in ipairs(arg:GetDescendants()) do
				if descendant:IsA("TouchTransmitter") then
					local parent = descendant.Parent

					if parent and parent:IsA("BasePart") then
						flag2(arg2, parent, 0)
						flag2(arg2, parent, 1)
						flag4 = true
					end
				end
			end
		end)

		if not ok then
			return false, "Failed to touch chest: " .. tostring(result)
		end

		if not flag4 then
			return false, "Chest has no usable TouchInterest"
		end
		return true, nil
	end,
	Collect = function(arg, arg2)
		if not tbl26.IsCollectable(arg) then
			return false, "Chest is no longer collectable"
		end
		local v6, v7 = tbl24.MoveToPosition(arg2, 10)
		if not v6 then
			return false, v7
		end
		local n16 = os.clock() + n14
		local n17 = 0
		local v8 = nil

		while true do
			local v9 = task.wait()
			local v10, v11 = tbl21.WaitForAliveRoot()
			tbl21.PreventSit(v10)
			n17 = math.min(n17 + v9, 0.4)
			local n18 = n17 / n15 * 3.1415926535897931 * 2
			v10:PivotTo(CFrame.new(arg2) * CFrame.Angles(n18, 0, 0))
			tbl9.StopVelocity(v11)
			local v12, v13 = tbl26.Touch(arg, v11)

			if not v12 then
				v8 = v13
			end

			if not (not tbl26.IsCollectable(arg) or os.clock() >= n16) then
				continue
			end
			break
		end

		local v9, v10 = tbl21.GetAliveRoot()

		if v9 and v10 then
			v9:PivotTo(CFrame.new(v10.Position))
		end

		if tbl26.IsCollectable(arg) then
			return false, v8 or "Chest did not open"
		end
		return true, nil
	end,
	FarmMap = function(arg, arg2, arg3, arg4)
		if not arg4 and #tbl26.ScanMap(arg) == 0 then
			return arg3
		end

		if arg4 then
			local v6 = tbl26.GetMapPosition(arg)

			if v6 then
				if not tbl24.MoveToPosition(v6, 100) then
					return arg3
				end
				task.wait(1)
			end
		end

		local tbl27 = {}

		while not arg2(arg3) do
			local v6, v7 = tbl21.WaitForAliveRoot()
			local v8, v9 = tbl26.FindNearest(tbl26.ScanMap(arg), v7, tbl27)

			if v8 then
				tbl27[v8] = true

				if tbl26.Collect(v8, v9) then
					arg3 += 1
				end

				task.wait(0.15)
				continue
			end

			break
		end

		return arg3
	end,
	Farm = function(arg, arg2)
		if type(arg) ~= "function" then
			return false, "Chest stop condition must be a function", 0
		end

		if arg2 == nil then
			arg2 = true
		end

		local n16 = 0

		while not arg(n16) do
			tbl21.WaitForAliveRoot()
			local v6 = n16

			for _, v7 in ipairs(tbl25) do
				if not arg(v6) then
					v6 = tbl26.FarmMap(v7, arg, v6, false)
					continue
				end
				break
			end

			if v6 == n16 then
				for _, v7 in ipairs(tbl25) do
					if not arg(v6) then
						v6 = tbl26.FarmMap(v7, arg, v6, true)
						continue
					end
					break
				end
			end

			if v6 == n16 and not arg(v6) then
				if not arg2 then
					task.wait(5)
					n16 = v6
					continue
				end

				local v7, v8 = tbl13.HopNormalServer()
				if not v7 then
					return false, "No chest was collected: " .. tostring(v8), v6
				end
				return false, "Hopping to a low server for more chests", v6
			end

			n16 = v6
		end

		return true, nil, n16
	end,
}

local n16 = 10
local n17 = 120
local n18 = 300
local n19 = 3
local n20 = 5
local n21 = 1
local tbl27

tbl27 = {
	CakeMirrorBosses = { ["Cake Prince"] = true, ["Dough King"] = true },
	CakeMirrorIslandRange = 2000,
	CakeMirrorApproachDistance = 250,
	CakeMirrorTeleportDistance = 50,
	CakeMirrorTimeout = 2,
	CakeMirrorSettleDelay = 1,
	CakeMirrorStreamTimeout = 20,
	CakeMirrorStreamPoll = 0.5,
	CakeIslandLocation = "Sea of Treats",
	IsAliveBoss = function(arg, arg2)
		if typeof(arg) ~= "Instance" or not arg:IsA("Model") or arg.Name ~= arg2 then
			return false
		end
		local humanoid = arg:FindFirstChildOfClass("Humanoid")
		return humanoid ~= nil and humanoid.Health > 0
	end,
	Exists = function(arg)
		for _, child in ipairs(ReplicatedStorage:GetChildren()) do
			if tbl27.IsAliveBoss(child, arg) then
				return true
			end
		end

		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return false
		end

		for _, child in ipairs(enemies:GetChildren()) do
			if tbl27.IsAliveBoss(child, arg) then
				return true
			end
		end

		return false
	end,
	Find = function(arg)
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return nil, nil, nil
		end

		for _, child in ipairs(enemies:GetChildren()) do
			if tbl27.IsAliveBoss(child, arg) then
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
				local humanoid = child:FindFirstChildOfClass("Humanoid")
				if humanoidRootPart and humanoidRootPart:IsA("BasePart") and humanoid then
					return child, humanoidRootPart, humanoid
				end
			end
		end

		return nil, nil, nil
	end,
	CheckAbort = function(arg, arg2)
		if not arg or os.clock() < arg2 then
			return nil, arg2
		end
		return arg(), os.clock() + n19
	end,
	GetCakeLoaf = function()
		local map = Workspace:FindFirstChild("Map")
		return map and map:FindFirstChild("CakeLoaf")
	end,
	GetCakeMirror = function()
		local bigMirror = tbl27.GetCakeLoaf()
		bigMirror = bigMirror and bigMirror:FindFirstChild("BigMirror")
		bigMirror = bigMirror and bigMirror:FindFirstChild("Main")
		if not bigMirror or not bigMirror:IsA("BasePart") or not bigMirror:FindFirstChild("TouchInterest") then
			return nil
		end
		return bigMirror
	end,
	GetCakeIslandPositions = function()
		local worldOrigin = Workspace:FindFirstChild("_WorldOrigin")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild("Locations")
		local tbl28 = {}
		if not worldOrigin then
			return tbl28
		end

		for _, child in ipairs(worldOrigin:GetChildren()) do
			if child.Name == tbl27.CakeIslandLocation and child:IsA("BasePart") then
				table.insert(tbl28, child.Position)
			end
		end

		return tbl28
	end,
	WaitForCakeMirror = function()
		local cakeMirrorStreamTimeout = tbl27.CakeMirrorStreamTimeout
		local n22 = os.clock() + cakeMirrorStreamTimeout

		while true do
			local v6 = tbl27.GetCakeMirror()

			if v6 then
				return v6
			else
				task.wait(tbl27.CakeMirrorStreamPoll)
				if not (n22 <= os.clock()) then
					continue
				end
				break
			end
		end

		return nil
	end,
	ReachCakeMirror = function()
		local v6
		v6, v6 = tbl21.GetAliveRoot()
		if not v6 then
			return nil
		end
		local v7 = tbl27.GetCakeIslandPositions()
		local position = v6.Position

		table.sort(v7, function(arg, arg2)
			return (arg - position).Magnitude < (arg2 - position).Magnitude
		end)

		for _, v8 in ipairs(v7) do
			if tbl24.ResetTeleport(v8) then
				tbl21.WaitForAliveRoot()
				local v9 = tbl27.WaitForCakeMirror()
				if v9 then
					return v9
				end
			end
		end

		return nil
	end,
	FireCakeMirror = function(arg)
		local v6
		v6, v6 = tbl21.GetAliveRoot()
		if not v6 or not arg.Parent then
			return false
		end
		local position = v6.Position

		if not pcall(function()
			flag2(v6, arg, 0)
			task.wait()
			flag2(v6, arg, 1)
		end) then
			return false
		end

		local cakeMirrorTimeout = tbl27.CakeMirrorTimeout
		local n22 = os.clock() + cakeMirrorTimeout

		while true do
			local v7, v8 = tbl21.GetAliveRoot()

			if not v7 or not v8 then
				tbl21.WaitForAliveRoot()
				task.wait(tbl27.CakeMirrorSettleDelay)
				return false
			end

			if tbl27.CakeMirrorTeleportDistance <= (v8.Position - position).Magnitude then
				task.wait(tbl27.CakeMirrorSettleDelay)
				return true
			end
			task.wait(0.25)
			if not (n22 <= os.clock()) then
				continue
			end
			break
		end

		return false
	end,
	UseCakeMirror = function(arg)
		if not tbl27.CakeMirrorBosses[arg] or not flag2 then
			return false
		end
		local v6 = tbl27.GetCakeMirror() or tbl27.ReachCakeMirror()
		if not v6 then
			return false
		end
		local v7, v8 = tbl21.GetAliveRoot()
		if not v7 or not v8 then
			return false
		end

		if tbl27.CakeMirrorIslandRange < (v8.Position - v6.Position).Magnitude then
			if not tbl24.ResetTeleport(v6.Position) then
				return false
			end
			local v9
			v9, v8 = tbl21.WaitForAliveRoot()
			if not v6.Parent then
				return false
			end
		end

		if tbl27.CakeMirrorIslandRange < (v8.Position - v6.Position).Magnitude then
			return false
		end

		if tbl27.FireCakeMirror(v6) then
			return true
		end
		local v9, v10 = tbl21.GetAliveRoot()
		if not v9 or not v10 or not v6.Parent then
			return false
		end

		if (v10.Position - v6.Position).Magnitude > tbl27.CakeMirrorApproachDistance then
			if not tbl24.MoveToPart(v6, tbl27.CakeMirrorApproachDistance) then
				return false
			end
			tbl21.WaitForAliveRoot()
			if not v6.Parent then
				return false
			end
		end

		return tbl27.FireCakeMirror(v6)
	end,
	TravelToSpawn = function(arg, arg2, arg3)
		local v6, v7 = tbl24.Travel(arg2)
		if v7 then
			return false, "Failed to travel to " .. arg .. ": " .. tostring(v7)
		end
		local n22 = os.clock() + n17
		local n23 = 0

		while true do
			if tbl27.Find(arg) then
				tbl24.StopJob(v6)
				return true, nil
			else
				local v8, v9 = tbl21.GetAliveRoot()

				if not v8 or not v9 then
					tbl24.StopJob(v6)
					tbl21.WaitForAliveRoot()
					return true, nil
				end

				local v10, v11 = tbl27.CheckAbort(arg3, n23)
				if v10 then
					tbl24.StopJob(v6)
					return false, nil, v10
				end

				if (v9.Position - arg2).Magnitude <= n16 then
					tbl24.StopJob(v6)
					return true, nil
				end

				if n22 <= os.clock() then
					tbl24.StopJob(v6)
					return false, "Timed out while traveling to " .. arg
				end

				if not v6:IsRunning() then
					break
				end
				task.wait(0.25)
				n23 = v11
			end
		end

		return false, v6:GetReason() or "Tween stopped while traveling to " .. arg
	end,
	Strike = function(arg, arg2)
		local v6, v7 = tbl21.EquipMelee()
		if not v6 then
			return false, "Failed to equip Melee for " .. arg .. ": " .. tostring(v7)
		end
		local v8, v9 = tbl15.Enable()
		if not v8 then
			return false, "Failed to enable Buso for " .. arg .. ": " .. tostring(v9)
		end
		local v10, v11 = tbl19.Attack(arg)
		if not v10 and not tbl19.IsTransientError(v11) and arg2.Health > 0 then
			return false, "Failed to attack " .. arg .. ": " .. tostring(v11)
		end
		return true, nil
	end,
	Fight = function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
		local cframe = arg7 or CFrame.new(0, 15, 0)
		local v6, v7

		if arg6 then
			v6, v7 = Tween(arg2, 300, cframe)
		else
			v6, v7 = tbl24.Travel(arg2, 300, cframe)
		end

		if v7 then
			return false, "Failed to follow " .. arg .. ": " .. tostring(v7)
		end
		local now = os.clock()
		local n22 = 0
		local position = nil

		while arg2.Parent and arg3.Parent and arg4.Parent and arg4.Health > 0 do
			local v8, v9 = tbl21.GetAliveRoot()

			if not v8 or not v9 then
				tbl24.StopJob(v6)
				tbl21.WaitForAliveRoot()
				return true, nil
			end

			local v10, v11 = tbl27.CheckAbort(arg5, n22)
			if v10 then
				tbl24.StopJob(v6)
				return false, nil, v10
			end
			local magnitude = (arg3.Position - v9.Position).Magnitude

			if not position or (v9.Position - position).Magnitude >= n21 then
				position = v9.Position
				now = os.clock()
			elseif arg6 and magnitude > n7 and os.clock() - now >= n20 then
				tbl24.StopJob(v6)
				return true, nil
			end

			if magnitude <= n7 then
				local v12, v13 = tbl27.Strike(arg, arg4)

				if not v12 then
					tbl24.StopJob(v6)
					if tbl21.WaitForRespawnIfDead() then
						return true, nil
					end
					return false, v13
				end
			end

			if not v6:IsRunning() and arg4.Health > 0 then
				if arg6 then
					return true, nil
				end
				return false, v6:GetReason() or "Tween stopped while fighting " .. arg
			end

			task.wait()
			n22 = v11
		end

		tbl24.StopJob(v6)
		return true, nil
	end,
	Kill = function(arg, arg2, arg3, arg4, arg5)
		if not tbl27.Exists(arg) then
			return false, arg .. " has not spawned"
		end
		local n22 = os.clock() + n18
		local v6 = nil

		while tbl27.Exists(arg) do
			if os.clock() >= n22 then
				return false, "Timed out while fighting " .. arg
			end
			local v7, v8 = tbl21.WaitForAliveRoot()
			local v9, v10, v11 = tbl27.Find(arg)
			local flag4 = tbl27.CakeMirrorBosses[arg] and v6 ~= v7 and (not v10 or (v10.Position - v8.Position).Magnitude > n7)

			if flag4 then
				local v12 = tbl27.UseCakeMirror(arg)
				local v13 = tbl21.WaitForAliveRoot()
				v9, v10, v11 = tbl27.Find(arg)

				if v12 then
					v6 = v13
				end
			end

			if flag4 then
				task.wait(0.25)
				continue
			end

			if not v9 then
				local v12, v13, v14 = tbl27.TravelToSpawn(arg, arg2, arg3)
				if v14 then
					return false, nil, v14
				end

				if not v12 then
					return false, v13
				end
				task.wait(0.25)
				continue
			end

			local v12, v13, v14 = tbl27.Fight(arg, v9, v10, v11, arg3, arg4, arg5)
			if v14 then
				return false, nil, v14
			end

			if not v12 then
				return false, v13
			end
		end

		return true, nil
	end,
}

local tbl28 = nil
local tbl29

tbl29 = {
	ReplicationTimeout = 20,
	ReplicationPollDelay = 0.5,
	ReplicationReady = false,
	GetModules = function()
		if tbl28 then
			return tbl28, nil
		end
		local itemId = ReplicatedStorage:FindFirstChild("ItemId", true)
		local itemReplication = ReplicatedStorage:FindFirstChild("ItemReplication", true)
		if not itemId or not itemReplication then
			return nil, "The ItemId or ItemReplication module is unavailable"
		end
		local ok, result = pcall(require, itemId)
		if not ok then
			return nil, "Failed to require ItemId: " .. tostring(result)
		end
		local ok2, result2 = pcall(require, itemReplication)
		if not ok2 then
			return nil, "Failed to require ItemReplication: " .. tostring(result2)
		end
		tbl28 = { Id = result, Replication = result2 }
		return tbl28, nil
	end,
	GetId = function(arg, arg2)
		local v6, v7 = tbl29.GetModules()
		if not v6 then
			return nil, v7
		end

		local ok, result = pcall(function()
			return v6.Id.getId(arg, arg2)
		end)

		if not ok or type(result) ~= "table" then
			return nil, "getId failed for " .. tostring(arg)
		end

		local ok2, result2 = pcall(function()
			return result:unwrapOr(nil)
		end)

		if not ok2 or type(result2) ~= "number" then
			return nil, "No item id for " .. tostring(arg) .. " of type " .. tostring(arg2)
		end
		return result2, nil
	end,
	HasAnyReplicatedItem = function()
		if tbl29.ReplicationReady then
			return true
		end
		local v6 = tbl29.GetModules()
		local isOwned = v6 and v6.Replication.IsOwned
		if not isOwned then
			return false
		end
		local ids = v6.Id._IDS

		if type(ids) == "table" and type(ids._ok) == "table" then
			ids = ids._ok
		end

		if type(ids) ~= "table" then
			return false
		end

		for _, v7 in pairs(ids) do
			local id = type(v7) == "table" and v7.Id or nil
			local itemId = type(id) == "table" and id.ItemId or nil

			if type(itemId) == "number" then
				local ok, result = pcall(function()
					return isOwned.readClient(itemId)
				end)

				if ok and result ~= nil then
					tbl29.ReplicationReady = true
					return true
				end
			end
		end

		return false
	end,
	Read = function(arg, arg2, arg3)
		local v6, v7 = tbl29.GetId(arg2, arg3)
		if not v6 then
			return nil, v7
		end
		local v8 = tbl29.GetModules()
		v8 = v8 and v8.Replication[arg]
		if not v8 then
			return nil, "ItemReplication." .. arg .. " is unavailable"
		end
		local replicationTimeout = tbl29.ReplicationTimeout
		local n22 = os.clock() + replicationTimeout

		while true do
			local ok, result = pcall(function()
				return v8.readClient(v6)
			end)

			if not ok then
				return nil, arg .. ".readClient failed for " .. tostring(arg2)
			else
				if result ~= nil then
					tbl29.ReplicationReady = true
					return result, nil
				end

				if tbl29.HasAnyReplicatedItem() then
					return nil, nil
				end

				if n22 <= os.clock() then
					break
				end
				task.wait(tbl29.ReplicationPollDelay)
			end
		end

		return nil, "The inventory has not replicated yet, so " .. arg .. " for " .. tostring(arg2) .. " could not be read"
	end,
	WaitForReplication = function()
		local replicationTimeout = tbl29.ReplicationTimeout
		local n22 = os.clock() + replicationTimeout

		while not tbl29.HasAnyReplicatedItem() do
			if n22 <= os.clock() then
				return false, "The inventory has not replicated yet"
			end
			task.wait(tbl29.ReplicationPollDelay)
		end

		return true, nil
	end,
	ListOwned = function(arg, arg2)
		local v6, v7 = tbl29.GetModules()
		if not v6 then
			return nil, v7
		end
		local v8, v9 = tbl29.WaitForReplication()
		if not v8 then
			return nil, v9
		end
		local ids = v6.Id._IDS

		if type(ids) == "table" and type(ids._ok) == "table" then
			ids = ids._ok
		end

		if type(ids) ~= "table" then
			return nil, "The ItemId table is unavailable"
		end
		local tbl30 = {}

		for _, v10 in pairs(ids) do
			local id = type(v10) == "table" and v10.Id or nil

			if type(id) == "table" and id.Type == arg and type(id.StorageKey) == "string" and (arg2 == nil or string.find(id.StorageKey, arg2) ~= nil) then
				local ok, result = pcall(function()
					return v6.Replication.IsOwned.readClient(id.ItemId)
				end)

				if ok and result == true then
					tbl30[#tbl30 + 1] = id.StorageKey
				end
			end
		end

		return tbl30, nil
	end,
	GetQuantity = function(arg, arg2)
		local Quantity, v6 = tbl29.Read("Quantity", arg, arg2)
		if v6 then
			return nil, v6
		end
		return tonumber(Quantity) or 0, nil
	end,
	IsOwned = function(arg, arg2)
		local IsOwned, v6 = tbl29.Read("IsOwned", arg, arg2)
		if v6 then
			return nil, v6
		end
		return IsOwned == true, nil
	end,
	ScanUniqueItem = function(arg)
		if type(arg) ~= "string" or arg == "" then
			return nil, "Item name must be a non-empty string"
		end

		if type(filtergc) == "function" then
			local ok, result = pcall(function()
				return filtergc("table", { Keys = { "Equipped", "Modifiers", "Grade" }, KeyValuePairs = { Name = arg } }, true) ~= nil
			end)

			if not ok then
				return nil, "Failed to filter for " .. arg .. ": " .. tostring(result)
			end
			return result == true, nil
		end

		if type(getgc) ~= "function" then
			return nil, "The executor has no filtergc or getgc function"
		end

		local ok, result = pcall(function()
			for _, v6 in ipairs(getgc(true)) do
				if type(v6) == "table" then
					local flag4 = false

					pcall(function()
						flag4 = rawget(v6, "Name") == arg and rawget(v6, "Equipped") ~= nil
					end)

					if flag4 then
						return true
					end
				end
			end

			return false
		end)

		if not ok then
			return nil, "Failed to scan for " .. arg .. ": " .. tostring(result)
		end
		return result == true, nil
	end,
}

local n22 = 10
local tbl30 = {}

local tbl31 = {
	{ ItemName = "Mirror Fractal", ItemType = "Material", BossName = "Dough King" },
	{ ItemName = "Valkyrie Helm", ItemType = "Accessory", BossName = "rip_indra True Form" },
}

local tbl32

tbl32 = {
	CheckItem = function(arg, arg2)
		if tbl21.HasItem(arg) then
			return true, nil
		end
		local v6, v7 = tbl29.IsOwned(arg, arg2)
		if v6 then
			return true, nil
		end

		if arg2 == "Accessory" then
			local v8, v9 = tbl29.ScanUniqueItem(arg)
			if v8 then
				return true, nil
			end

			if v6 == false or v8 == false then
				return false, nil
			end
			local v10 = tostring
			v7 = v7 or v9
			return nil, "Could not check " .. arg .. ": " .. v10(v7)
		end

		if v6 == false then
			return false, nil
		end
		return nil, "Could not check " .. arg .. ": " .. tostring(v7)
	end,
	HasItem = function(arg, arg2)
		if tbl30[arg] then
			return tbl32.CheckItem(arg, arg2)
		end
		local flag4 = false
		local v6 = nil

		for i = 1, 10 do
			local v7, v8 = tbl32.CheckItem(arg, arg2)
			if v7 then
				tbl30[arg] = nil
				return true, nil
			end

			if v7 == false then
				flag4 = true
			else
				v6 = v8 or v6
			end

			if i < n22 then
				task.wait(1)
			end
		end

		if flag4 then
			tbl30[arg] = true
			return false, nil
		end
		return nil, v6 or "Could not verify " .. tostring(arg)
	end,
	ResolveSpawn = function(arg)
		local v6, v7 = tbl27.Find(arg)
		if v7 then
			return v7.Position, nil
		end
		local humanoidRootPart = ReplicatedStorage:FindFirstChild(arg)
		humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
		if humanoidRootPart and humanoidRootPart:IsA("BasePart") then
			return humanoidRootPart.Position, nil
		end
		return nil, "Could not resolve a spawn position for " .. arg
	end,
	Obtain = function(arg, arg2, arg3)
		local v6

		while true do
			local v7, v8 = tbl32.HasItem(arg, arg2)

			if v7 == nil then
				return false, v8
			else
				if v7 then
					return true, nil
				end

				if not tbl27.Exists(arg3) then
					local v9, v10 = tbl13.RetryAPIServer(arg3)
					if not v9 then
						return false, arg3 .. " is not in this server: " .. tostring(v10)
					end
					return false, "Hopping to a server that has " .. arg3
				end

				tbl21.WaitForAliveRoot()
				local v9, v10 = tbl32.ResolveSpawn(arg3)
				if not v9 then
					return false, v10
				end
				local v11
				v11, v6 = tbl27.Kill(arg3, v9)
				if not v11 and not tbl21.WaitForRespawnIfDead() then
					break
				end
				task.wait(5)
			end
		end

		return false, v6
	end,
	EnsureAll = function()
		for _, v6 in ipairs(tbl31) do
			local v7, v8 = tbl32.HasItem(v6.ItemName, v6.ItemType)
			if v7 == nil then
				return false, v8
			end

			if not v7 then
				if not tbl3[placeId] then
					return false, v6.ItemName .. " can only be farmed in the Third Sea", true
				end
				local str2 = v6.ItemName .. " is missing, killing " .. v6.BossName
				warn(str2)
				v.Log(str2, "Trial")
				local v9, v10 = tbl32.Obtain(v6.ItemName, v6.ItemType, v6.BossName)
				if not v9 then
					return false, v10
				end
			end
		end

		return true, nil
	end,
}

local n23 = 500000
local n24 = 10
local n25 = 300
local n26 = 1000
local n27 = 30
local vector = Vector3.new(923.213, 125.39765, 32852.832)
local v6 = nil

local tbl33 = {
	["Ship Deckhand"] = true,
	["Ship Engineer"] = true,
	["Ship Steward"] = true,
	["Ship Officer"] = true,
}

local tbl34

tbl34 = {
	HasAnyFlower = function()
		return tbl21.HasItem("Flower 1") or tbl21.HasItem("Flower 2") or tbl21.HasItem("Flower 3")
	end,
	IsRaceEvolved = function()
		local data = localPlayer:FindFirstChild("Data")
		data = data and data:FindFirstChild("Race")
		return data ~= nil and data:FindFirstChild("Evolved") ~= nil
	end,
	IsFlowerReady = function(arg)
		return tbl34.FindReadyFlower(arg) ~= nil
	end,
	FindReadyFlower = function(arg)
		local v7 = Workspace:FindFirstChild(arg)
		if v7 and v7:IsA("BasePart") and v7.Transparency ~= 1 then
			return v7
		end
		return nil
	end,
	TouchFlower = function(arg, arg2, arg3)
		local n28 = os.clock() + n24
		local flag4 = false

		while not tbl21.HasItem(arg3) and os.clock() < n28 do
			local v7, v8, v9 = tbl21.GetAliveRoot()
			if not v7 or not v8 then
				return false, v9, false
			end

			if arg.Parent and arg.Transparency ~= 1 then
				pcall(function()
					if flag2 then
						flag2(v8, arg, 0)
						flag2(v8, arg, 1)
					else
						v7:PivotTo(arg.CFrame)
					end
				end)
			else
				flag4 = true
			end

			task.wait(0.25)
		end

		if tbl21.HasItem(arg3) then
			return true, nil, false
		end
		return false, flag4 and arg2 .. " disappeared before " .. arg3 .. " reached the Backpack" or arg2 .. " did not grant " .. arg3 .. " within 10 seconds", true
	end,
	CollectFlower = function(arg, arg2)
		local n28 = os.clock() + n25
		local v7 = nil

		while not tbl21.HasItem(arg2) do
			if n28 <= os.clock() then
				if v7 then
					return false, arg .. " did not grant " .. arg2 .. " in time: " .. tostring(v7)
				end
				return false, arg .. " did not respawn in time to grant " .. arg2
			end

			local v8 = tbl34.FindReadyFlower(arg)
			if not v8 then
				task.wait(0.25)
				continue
			end
			local v9, v10 = tbl24.MoveToPart(v8)

			if not v9 then
				task.wait(0.25)
				v7 = v10
				continue
			end

			local v11, v12, v13 = tbl34.TouchFlower(v8, arg, arg2)

			if not v11 then
				if v13 then
					tbl9.StopActiveJob("The red or blue flower pickup timed out")
					local v14
					v14, v14 = tbl13.HopNormalServer()
					return false, v14 or v12
				end

				task.wait(0.25)
				v7 = v12
			end
		end

		return true, nil
	end,
	FindNearestMob = function(arg, arg2)
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return nil, nil, nil
		end
		local huge = math.huge
		local v7 = nil
		local v8 = nil
		local v9 = nil

		for _, child in ipairs(enemies:GetChildren()) do
			if not arg2 or arg2[child.Name] then
				local humanoid = child:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") then
					local magnitude = (humanoidRootPart.Position - arg.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v7 = child
						v8 = humanoidRootPart
						v9 = humanoid
					end
				end
			end
		end

		return v7, v8, v9
	end,
	IsInsideGhostShip = function(arg)
		return arg ~= nil and arg.Parent ~= nil and (arg.Position - vector).Magnitude <= n26
	end,
	UseGhostShipGate = function(arg, arg2)
		local requestEntrance, v7 = tbl11.Invoke("requestEntrance", arg)
		if v7 then
			return false, v7
		end
		local n28 = os.clock() + n27

		while true do
			local v8, v9, v10 = tbl21.GetAliveRoot()
			if not v8 or not v9 then
				return false, v10
			end

			if tbl34.IsInsideGhostShip(v9) == arg2 then
				return true, nil
			end

			if n28 <= os.clock() then
				break
			end
			task.wait(0.25)
		end

		if arg2 then
			return false, "Timed out while entering the Ghost Ship"
		end
		return false, "Timed out while leaving the Ghost Ship"
	end,
	EnterGhostShip = function()
		local v7, v8, v9 = tbl21.GetAliveRoot()
		if not v7 or not v8 then
			return false, v9
		end

		if tbl34.IsInsideGhostShip(v8) then
			return true, nil
		end
		return tbl34.UseGhostShipGate(Vector3.new(923.213, 125.39765, 32852.832), true)
	end,
	ExitGhostShip = function()
		local v7, v8, v9 = tbl21.GetAliveRoot()
		if not v7 or not v8 then
			return false, v9
		end

		if not tbl34.IsInsideGhostShip(v8) then
			return true, nil
		end
		return tbl34.UseGhostShipGate(Vector3.new(-6491.8643, 116.52766, -108.822334), false)
	end,
	AttackGhostShipMob = function(arg, arg2, arg3)
		local v7, v8 = tbl21.EquipMelee()
		if not v7 then
			return false, "Failed to equip Melee for " .. arg3 .. ": " .. tostring(v8)
		end
		local v9, v10 = tbl15.Enable()
		if not v9 then
			return false, "Failed to enable Buso for " .. arg3 .. ": " .. tostring(v10)
		end
		local v11, v12 = tbl20.Gather(arg, nil, 350)

		if v11 == 0 and v12 and v12 ~= v6 then
			v6 = v12
			warn("Failed to gather Ghost Ship mobs: " .. tostring(v12))
		end

		local v13, v14 = tbl19.Attack()
		if not v13 and not tbl19.IsTransientError(v14) and arg2.Health > 0 then
			return false, "Failed to farm " .. arg3 .. ": " .. tostring(v14)
		end
		return true, nil
	end,
	FarmGhostShipMob = function(arg, arg2, arg3, arg4, arg5)
		local v7, v8 = Tween(arg, 300, CFrame.new(0, 15, 0))
		if v8 then
			return false, "Failed to move to a Ghost Ship mob: " .. tostring(v8)
		end

		while arg.Parent and arg2.Parent and arg3.Parent and arg3.Health > 0 do
			local v9, v10 = arg4()
			if v10 then
				tbl24.StopJob(v7)
				return false, v10
			end

			if v9 then
				tbl24.StopJob(v7)
				return true, nil
			end
			local v11, v12 = tbl21.GetAliveRoot()

			if not v11 or not v12 then
				tbl24.StopJob(v7)
				tbl21.WaitForAliveRoot()
				return true, nil
			end

			if not tbl34.IsInsideGhostShip(v12) then
				tbl24.StopJob(v7)
				return true, nil
			end

			if (arg2.Position - v12.Position).Magnitude <= n7 then
				local v13, v14 = tbl34.AttackGhostShipMob(arg, arg3, arg5)

				if not v13 then
					tbl24.StopJob(v7)
					if tbl21.WaitForRespawnIfDead() then
						return true, nil
					end
					return false, v14
				end
			end

			if not v7:IsRunning() and arg3.Health > 0 then
				return false, v7:GetReason() or "Tween stopped while farming " .. arg5
			end
			task.wait()
		end

		tbl24.StopJob(v7)
		return true, nil
	end,
	FarmGhostShip = function(arg, arg2)
		local v7

		while true do
			local v8, v9 = arg()

			if v9 then
				return false, v9
			else
				if v8 then
					return true, nil
				end
				local v10, v11 = tbl21.GetAliveRoot()
				if not v10 or not v11 then
					tbl21.WaitForAliveRoot()
					return true, nil
				end

				if not tbl34.IsInsideGhostShip(v11) then
					local v12, v13 = tbl34.EnterGhostShip()

					if not v12 then
						if tbl21.WaitForRespawnIfDead() then
							return true, nil
						end
						return false, v13
					end

					task.wait(0.25)
					continue
				end

				local v12, v13, v14 = tbl34.FindNearestMob(v11, tbl33)
				if not v12 then
					task.wait(0.25)
					continue
				end
				local v15
				v15, v7 = tbl34.FarmGhostShipMob(v12, v13, v14, arg, arg2)
				if not v15 then
					break
				end
			end
		end

		return false, v7
	end,
	HasYellowFlower = function()
		return tbl21.HasItem("Flower 3"), nil
	end,
	CollectYellowFlower = function()
		local v7, v8 = tbl34.FarmGhostShip(tbl34.HasYellowFlower, "Flower 3")
		if not v7 then
			return false, v8
		end

		if not tbl21.HasItem("Flower 3") then
			return true, nil
		end
		local v9, v10 = tbl34.ExitGhostShip()

		if not v9 then
			if tbl21.WaitForRespawnIfDead() then
				return true, nil
			end
			return false, v10
		end

		return true, nil
	end,
	CollectNextFlower = function()
		if not tbl34.HasAnyFlower() and not tbl34.IsFlowerReady("Flower1") then
			local v7
			v7, v7 = tbl13.HopNormalServer()
			return false, v7 or "Hopping to a low server for the blue flower"
		end

		if not tbl21.HasItem("Flower 1") and tbl34.IsFlowerReady("Flower1") then
			return tbl34.CollectFlower("Flower1", "Flower 1")
		end

		if not tbl21.HasItem("Flower 2") and tbl34.IsFlowerReady("Flower2") then
			return tbl34.CollectFlower("Flower2", "Flower 2")
		end

		if not tbl21.HasItem("Flower 3") then
			return tbl34.CollectYellowFlower()
		end
		return true, nil
	end,
	RunQuest = function()
		if not tbl2[placeId] then
			return false, "The Race V2 quest only works in the Second Sea"
		end
		tbl21.WaitForAliveRoot()
		local data = localPlayer:WaitForChild("Data", 10)
		local race = data and data:WaitForChild("Race", 10)
		data = data and data:WaitForChild("Beli", 10)
		if not race or not data then
			return false, "Player race or Beli data did not load in time"
		end

		if tbl34.IsRaceEvolved() then
			return true, "Race is already V2", false
		end

		if race.Value == "Draco" then
			return false, "Draco V2 cannot be upgraded through the Alchemist quest"
		end

		if data.Value < n23 then
			return false, string.format("%d Beli is required, currently %d", 500000, data.Value)
		end
		local Alchemist

		while true do
			if tbl34.IsRaceEvolved() then
				return true, "Race upgraded to V2", true
			else
				local v7
				Alchemist, v7 = tbl11.Invoke("Alchemist", "1")
				if v7 then
					return false, v7
				end

				if Alchemist == 0 then
					local Alchemist2, v8 = tbl11.Invoke("Alchemist", "2")
					if v8 then
						return false, v8
					end
				elseif Alchemist == 1 then
					local v8, v9 = tbl34.CollectNextFlower()
					if not v8 then
						return false, v9
					end
				else
					if Alchemist ~= 2 then
						break
					end
					local Alchemist2, v8 = tbl11.Invoke("Alchemist", "3")
					if v8 then
						return false, v8
					end
					task.wait(1)
				end

				task.wait(0.25)
			end
		end

		return false, "Unexpected Alchemist state: " .. tostring(Alchemist)
	end,
}

local n28 = 2000000
local n29 = 1000
local n30 = 3000

local tbl35 = {
	BossName = "Cake Prince",
	Reserve = 9250,
	ThirdSeaAction = "ThirdSea",
	ServerHopAction = "ServerHop",
	QuietServerAction = "QuietServer",
}

local tbl36 = {
	Human = "Full Power",
	Mink = "Godspeed",
	Fishman = "Warrior of the Sea",
	Skypiea = "Perfect Being",
	Cyborg = "War Machine",
	Ghoul = "Hell Hound",
}

local tbl37

tbl37 = {
	GetUpgradeData = function()
		local data = localPlayer:WaitForChild("Data", 10)
		local level = data and data:WaitForChild("Level", 10)
		local beli = data and data:WaitForChild("Beli", 10)
		local fragments = data and data:WaitForChild("Fragments", 10)
		data = data and data:WaitForChild("Race", 10)
		if not level or not beli or not fragments or not data then
			return nil, "Player Level, Beli, Fragments, or Race data did not load in time"
		end
		return { Level = level, Beli = beli, Fragments = fragments, Race = data }, nil
	end,
	IsV3 = function()
		local Wenlocktoad, v7 = tbl11.Invoke("Wenlocktoad")
		if v7 then
			return nil, v7
		end
		return Wenlocktoad ~= nil, nil
	end,
	GetTitles = function()
		local getTitles

		while true do
			local v7
			getTitles, v7 = tbl11.Invoke("getTitles")

			if v7 then
				return nil, v7
			else
				if type(getTitles) == "table" then
					return getTitles, nil
				end

				if getTitles ~= nil then
					break
				end
				task.wait(1)
			end
		end

		return nil, "The getTitles reply was unexpected: " .. tostring(getTitles)
	end,
	HasTitleNamed = function(arg, arg2)
		for _, v7 in next, arg, nil do
			if type(v7) == "table" and v7.Name == arg2 then
				return true
			end
		end

		return false
	end,
	HasV3Title = function(arg)
		local v7 = tbl36[arg]
		if not v7 then
			return nil, "No Race V3 title is configured for " .. tostring(arg)
		end
		local v8, v9 = tbl37.GetTitles()
		if not v8 then
			return nil, v9
		end
		return tbl37.HasTitleNamed(v8, v7), nil
	end,
	RerollOnce = function()
		local BlackbeardReward, v7 = tbl11.Invoke("BlackbeardReward", "Reroll", "1")
		if v7 then
			return false, "Failed to check race reroll: " .. tostring(v7)
		end
		local BlackbeardReward2, v8 = tbl11.Invoke("BlackbeardReward", "Reroll", "2")
		if v8 then
			return false, "Failed to reroll race: " .. tostring(v8)
		end
		task.wait(2.5)
		return true, nil
	end,
	EnsureRerollRace = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" then
			return false, "Race name must be a non-empty string"
		end

		if type(arg2) ~= "table" or not arg2.Race or not arg2.Fragments then
			return false, "Race or Fragments data is unavailable"
		end

		while arg2.Race.Value ~= arg do
			if arg2.Fragments.Value < n30 then
				local value = arg2.Fragments.Value
				return false, string.format("%s is required, but the current race is %s and rerolling needs %d Fragments (currently %d)", arg, tostring(arg2.Race.Value), 3000, value)
			end
			local v7, v8 = tbl37.RerollOnce()
			if not v7 then
				return false, v8
			end
		end

		return true, nil
	end,
}

local v7 = nil
local tbl38

tbl38 = {
	EnsureAmount = function(arg, arg2, arg3)
		if type(arg) ~= "table" or not arg.Fragments then
			return false, "Fragments data is unavailable"
		end
		local flag4 = false

		while arg.Fragments.Value < arg2 do
			if not tbl3[placeId] then
				return false, "Cake Prince fragment farming needs the Third Sea", tbl35.ThirdSeaAction
			end

			if not flag4 then
				flag4 = true
			end

			if type(arg3) == "function" then
				arg3(string.format("Farming Cake Prince for Fragments: %d/%d", arg.Fragments.Value, arg2), "Working")
			end

			if not tbl27.Exists(tbl35.BossName) then
				local v8, v9 = tbl13.RetryAPIServer(tbl35.BossName)
				if not v8 then
					return false, tbl35.BossName .. " is not in this server: " .. tostring(v9)
				end
				return false, "Hopping through APIServer to find " .. tbl35.BossName, tbl35.ServerHopAction
			end

			tbl21.WaitForAliveRoot()
			local v8, v9 = tbl32.ResolveSpawn(tbl35.BossName)
			if not v8 then
				return false, v9
			end
			local v10, v11 = tbl27.Kill(tbl35.BossName, v8, nil, nil, CFrame.new(0, -50, 0))
			if not v10 and not tbl21.WaitForRespawnIfDead() then
				return false, v11
			end
			task.wait(5)
		end


		return true, nil, nil
	end,
	EnsureRace = function(arg, arg2, arg3)
		if type(arg) ~= "string" or arg == "" then
			return false, "Race name must be a non-empty string"
		end

		if type(arg2) ~= "table" or not arg2.Race or not arg2.Fragments then
			return false, "Race or Fragments data is unavailable"
		end

		while arg2.Race.Value ~= arg do
			local v8, v9, v10 = tbl38.EnsureAmount(arg2, 3000, arg3)
			if not v8 then
				return false, v9, v10
			end

			if type(arg3) == "function" then
				arg3("Rerolling " .. tostring(arg2.Race.Value) .. " to " .. arg, "Working")
			end

			local v11, v12 = tbl37.RerollOnce()
			if not v11 then
				return false, v12
			end
		end

		return true, nil, nil
	end,
}

tbl37.MeetsV3Requirements = function(arg, arg2)
	if type(arg2) ~= "table" or not arg2.Level or not arg2.Beli then
		return false, "Level or Beli data is unavailable"
	end

	if arg2.Level.Value < n29 then
		local value = arg2.Level.Value
		return false, string.format("Level %d is required for %s V3, currently %d", 1000, tostring(arg), value)
	end

	if arg2.Beli.Value < n28 then
		return false, string.format("%d Beli is required for %s V3, currently %d", 2000000, tostring(arg), arg2.Beli.Value)
	end
	return true, nil
end

local n31 = 2500
local n32 = 1000
local n33 = 10000
local n34 = 30
local flag4 = false
local flag5 = type(fireclickdetector) == "function" and fireclickdetector or nil
local flag6 = type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
local tbl39

tbl39 = {
	ReadFistAccounts = function()
		if not flag6 then
			return {}
		end
		local ok, result = pcall(isfile, "FistOfDarkness.txt")
		if not ok or not result then
			return {}
		end
		local ok2, result2 = pcall(readfile, "FistOfDarkness.txt")
		if not ok2 or type(result2) ~= "string" or result2 == "" then
			return {}
		end

		local ok3, result3 = pcall(function()
			return HttpService:JSONDecode(result2)
		end)

		if not ok3 or type(result3) ~= "table" then
			return {}
		end
		return result3
	end,
	HasInsertedFist = function()
		if flag4 then
			return true
		end

		if not flag6 then
			return false
		end
		return tbl39.ReadFistAccounts()[tostring(localPlayer.UserId)] == true
	end,
	MarkFistInserted = function()
		flag4 = true
		if not flag6 then
			return
		end
		local v8 = tbl39.ReadFistAccounts()
		v8[tostring(localPlayer.UserId)] = true

		pcall(function()
			writefile("FistOfDarkness.txt", HttpService:JSONEncode(v8))
		end)
	end,
	UseMachine = function()
		local map = Workspace:FindFirstChild("Map")
		map = map and map:FindFirstChild("CircleIsland")
		map = map and map:FindFirstChild("RaidSummon")
		map = map and map:FindFirstChild("Button")
		map = map and map:FindFirstChild("Main")
		map = map and map:FindFirstChildOfClass("ClickDetector")
		if not map then
			return false, "Cyborg machine ClickDetector was not found"
		end

		if not flag5 then
			return false, "The fireclickdetector function is unavailable"
		end
		local ok, result = pcall(flag5, map)
		if not ok then
			return false, "Failed to use the Cyborg machine: " .. tostring(result)
		end
		return true, nil
	end,
	GetOrderPosition = function()
		local enemies = Workspace:FindFirstChild("Enemies")
		local order = ReplicatedStorage:FindFirstChild("Order") or enemies and enemies:FindFirstChild("Order")
		if not order then
			return nil, "Order was not found"
		end

		local ok, result = pcall(function()
			return order:GetPivot()
		end)

		if not ok or not tbl9.IsFiniteCFrame(result) then
			return nil, "Order has no valid pivot"
		end
		return result.Position, nil
	end,
	FarmFistOfDarkness = function()
		if tbl21.HasItem("Fist of Darkness") then
			return true, nil
		end

		local v8, v9, v10 = tbl26.Farm(function(arg)
			return tbl21.HasItem("Fist of Darkness") or arg >= n34
		end)

		if not v8 then
			return false, v9
		end

		if tbl21.HasItem("Fist of Darkness") then
			return true, nil
		end
		local v11, v12 = tbl13.CountAPIServers("4H", placeId)

		if v11 and v11 > 0 then
			local v13
			v13, v12 = tbl13.APIServer("4H")
			if v13 then
				return false, string.format("Hopping to a four hour server after %d chests without a Fist of Darkness", v10)
			end
		end

		local v13, v14 = tbl13.HopNormalServer()
		if not v13 then
			return false, string.format("%d chests were opened without a Fist of Darkness %s", v10, tostring(v14 or v12))
		end
		return false, string.format("Hopping to a low server after %d chests without a Fist of Darkness", v10)
	end,
	InsertFistOfDarkness = function()
		local v8, v9 = tbl39.FarmFistOfDarkness()
		if not v8 then
			return false, v9
		end
		local v10, v11 = tbl21.EquipItem("Fist of Darkness")
		if not v10 then
			return false, v11
		end
		local v12, v13 = tbl39.UseMachine()
		if not v12 then
			return false, v13
		end
		task.wait(1)
		if tbl21.HasItem("Fist of Darkness") then
			return false, "The Cyborg machine did not accept the Fist of Darkness"
		end
		tbl39.MarkFistInserted()
		return true, nil
	end,
	LoadStoredFruit = function()
		local Moveset, v8 = tbl29.ListOwned("Moveset", "%-")
		if not Moveset then
			return false, v8
		end
		local v9 = Moveset[1]
		if not v9 then
			return false, "There is no stored Blox Fruit to show Arowe"
		end
		local LoadFruit, v10 = tbl11.Invoke("LoadFruit", v9)
		if v10 then
			return false, v10
		end
		return true, v9
	end,
	RunRaceStep = function(arg)
		local n35 = n31 + tbl35.Reserve
		local CyborgTrainer, v8 = tbl11.Invoke("CyborgTrainer", "Check")
		if v8 then
			return false, v8
		end

		if CyborgTrainer == true then
			if arg.Fragments.Value < n35 then
				return false, nil, n35
			end
			local CyborgTrainer2, v9 = tbl11.Invoke("CyborgTrainer", "Buy")
			return v9 == nil, v9
		end

		if tbl21.HasItem("Core Brain") then
			return tbl39.UseMachine()
		end

		if tbl27.Exists("Order") then
			local v9, v10 = tbl39.GetOrderPosition()
			if not v9 then
				return false, v10
			end
			return tbl27.Kill("Order", v9)
		end

		if tbl21.HasItem("Microchip") then
			return tbl39.UseMachine()
		end

		if not tbl39.HasInsertedFist() then
			return tbl39.InsertFistOfDarkness()
		end

		if n32 <= arg.Fragments.Value - n35 then
			local BlackbeardReward, v9 = tbl11.Invoke("BlackbeardReward", "Microchip", "2")
			return v9 == nil, v9
		end
		return false, nil, n35 + n33
	end,
	EnsureRace = function(arg, arg2)
		if type(arg) ~= "table" or not arg.Race or not arg.Fragments then
			return false, "Race or Fragments data is unavailable"
		end

		while arg.Race.Value ~= "Cyborg" do
			local v8, v9, v10 = tbl39.RunRaceStep(arg)

			if v10 then
				local v11, v12, v13 = tbl38.EnsureAmount(arg, v10, arg2)
				if not v11 then
					return false, v12, v13
				end
			elseif not v8 then
				return false, v9
			end

			task.wait(0.5)
		end

		tbl21.WaitForAliveRoot()
		return true, nil
	end,
}

local n35 = 100
local n36 = 5
local str2 = "Cursed Captain"
local n37 = 5
local n38 = 0
local n39 = 0
local tbl40

tbl40 = {
	GetEctoplasm = function()
		return tbl29.GetQuantity("Ectoplasm", "Material")
	end,
	RefreshEctoplasm = function(arg)
		local now = os.clock()

		if arg or now - n39 >= n36 then
			local v8, v9 = tbl40.GetEctoplasm()
			if v8 == nil then
				return nil, v9
			end
			n38 = v8
			n39 = now
		end

		return n38, nil
	end,
	HasEnoughEctoplasm = function()
		local v8, v9 = tbl40.RefreshEctoplasm(false)
		if v8 == nil then
			return false, v9
		end
		return v8 >= n35, nil
	end,
	FarmEctoplasm = function()
		return tbl34.FarmGhostShip(tbl40.HasEnoughEctoplasm, "Ectoplasm")
	end,
	HasLeftGhostShip = function()
		local v8, v9 = tbl21.GetAliveRoot()
		if not v8 or not v9 then
			return nil
		end

		if tbl34.IsInsideGhostShip(v9) then
			return nil
		end
		return true
	end,
	FarmTorch = function()
		while not tbl21.HasItem("Hellfire Torch") do
			if not tbl27.Exists("Cursed Captain") then
				local v8, v9 = tbl13.RetryAPIServer("Cursed Captain")
				if not v8 then
					return false, str2 .. " is not in this server: " .. tostring(v9)
				end
				return false, "Hopping to a server that has " .. str2
			end

			tbl21.WaitForAliveRoot()
			local v8, v9 = tbl34.EnterGhostShip()

			if not v8 then
				if not tbl21.WaitForRespawnIfDead() then
					return false, v9
				end
			else
				local v10, v11, v12 = tbl27.Kill("Cursed Captain", Vector3.new(923.213, 125.39765, 32852.832), tbl40.HasLeftGhostShip, true)
				if not v10 and not v12 then
					return false, v11
				end
			end

			task.wait(5)
		end

		return true, nil
	end,
	RunRaceStep = function(arg)
		local Ectoplasm, v8 = tbl11.Invoke("Ectoplasm", "Change", 4)
		if v8 then
			return false, v8
		end
		task.wait(1)
		if arg.Race.Value == "Ghoul" then
			return true, nil
		end
		local v9, v10 = tbl40.RefreshEctoplasm(true)
		if v9 == nil then
			return false, v10
		end

		if v9 < n35 then
			return tbl40.FarmEctoplasm()
		end

		if not tbl21.HasItem("Hellfire Torch") then
			return tbl40.FarmTorch()
		end
		local Ectoplasm2, v11 = tbl11.Invoke("Ectoplasm", "Buy", 4)
		if v11 then
			return false, v11
		end
		task.wait(1)
		return true, nil, true
	end,
	EnsureRace = function(arg)
		if type(arg) ~= "table" or not arg.Race then
			return false, "Race data is unavailable"
		end
		local n40 = 0

		while arg.Race.Value ~= "Ghoul" do
			local v8, v9, v10 = tbl40.RunRaceStep(arg)
			if not v8 then
				return false, v9
			end

			if v10 then
				n40 += 1
				if not (n37 <= n40) then
					continue
				end
				return false, "The Ectoplasm shop did not change the race to Ghoul"
			end
		end

		tbl21.WaitForAliveRoot()
		return true, nil
	end,
}

local n40 = 3
local n41 = 0
local n42 = 0
local v8 = nil
local tbl41

tbl41 = {
	Report = function(arg, arg2)
		warn(tostring(arg))
		v.Log(arg, arg2 or "Working")
	end,
	Summarize = function(arg)
		local match = tostring(arg):match("^[^\n]*")
		if not match or match == "" then
			return "Unknown failure"
		end
		return match
	end,
	Recover = function(arg)
		tbl9.StopActiveJob("Recovering after a failure")
		tbl19.Stop()
		tbl21.WaitForAliveRoot()
		local v9 = tbl41.Summarize(arg)

		if v9 ~= v8 then
			v8 = v9
			n41 = 1
			return false, nil
		end

		n41 += 1
		if n41 < n40 then
			return false, nil
		end
		n41 = 0
		v8 = nil
		return tbl13.RejoinServer()
	end,
	EnsureCyborg = function()
		local v9, v10 = tbl37.GetUpgradeData()
		if not v9 then
			return false, v10
		end

		if v9.Race.Value == "Cyborg" then
			return true, "Cyborg race obtained"
		end

		if not tbl2[placeId] and not tbl3[placeId] then
			tbl41.Report("Traveling to the Second Sea", "Travel")
			tbl12.TravelToSecondSea()
			return false, "Traveling to the Second Sea"
		end

		local v11, v12, v13 = tbl39.EnsureRace(v9, tbl41.Report)
		if v11 then
			return true, "Cyborg race obtained"
		end

		if v13 == tbl35.ThirdSeaAction then
			tbl41.Report(tostring(v12) .. ", traveling to the Third Sea", "Travel")
			tbl12.TravelToThirdSea()
			return false, "Traveling to the Third Sea"
		end

		if v13 == tbl35.ServerHopAction or v13 == tbl35.QuietServerAction then
			return false, tostring(v12)
		end

		if tbl3[placeId] then
			tbl41.Report("Returning to the Second Sea for the Cyborg quest", "Travel")
			tbl12.TravelToSecondSea()
			return false, "Returning to the Second Sea"
		end

		return false, v12
	end,
	EnsureGhoul = function()
		local v9, v10 = tbl37.GetUpgradeData()
		if not v9 then
			return false, v10
		end

		if v9.Race.Value == "Ghoul" then
			return true, "Ghoul race obtained"
		end

		if not tbl2[placeId] then
			tbl41.Report("Traveling to the Second Sea", "Travel")
			tbl12.TravelToSecondSea()
			return false, "Traveling to the Second Sea"
		end

		local v11, v12 = tbl40.EnsureRace(v9)
		if v11 then
			return true, "Ghoul race obtained"
		end
		return false, v12
	end,
	RunProtected = function()
		tbl41.Report("Loading remotes")
		tbl19.WatchRemotes()
		local v9, v10 = tbl19.RefreshSeed()

		if not v9 then
			tbl41.Report("Seed unavailable, continuing anyway: " .. tostring(v10), "Warning")
		end

		if not localPlayer.Team then
			tbl41.Report("Joining the " .. str .. " team")
			local Marines, v11 = tbl14.Join("Marines")
			if not Marines then
				return false, v11
			end
		end

		tbl41.Report("Loading Hop API")
		local v11, v12 = tbl13.GetAPIModule()

		if not v11 then
			tbl41.Report("Hop API unavailable: " .. tostring(v12), "Warning")
		end

		tbl41.Report("Target race: " .. targetRace, "Trial")
		if targetRace == "Cyborg" then
			return tbl41.EnsureCyborg()
		end
		return tbl41.EnsureGhoul()
	end,
	Run = function()
		local result

		while true do
			local ok, result2
			ok, result2, result = xpcall(tbl41.RunProtected, debug.traceback)

			if not (ok and result2) then
				ok = ok and tostring(result) or "Unexpected error:\n" .. tostring(result2)
				warn("Retrying after: " .. ok)
				n42 += 1
				local v9, v10 = tbl41.Recover(ok)
				v.Recovery(tbl41.Summarize(ok), "Retrying in " .. tostring(5) .. "s")
				v.Retry(n42, 5)

				if v9 then
					tbl41.Report("Repeated failure " .. tostring(v10), "Warning")
				elseif v10 then
					tbl41.Report("Server rejoin failed: " .. tostring(v10), "Warning")
				end

				task.wait(5)
				continue
			end

			break
		end

		return true, result
	end,
}

local v9, v10 = v.Start()

if not v9 then
	warn(tostring(v10))
end

tbl41.Report("Finished: " .. tostring(select(2, tbl41.Run())), "Success")
v.Complete()
