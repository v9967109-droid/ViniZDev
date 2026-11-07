-- ez crack skid night hub 😂
-- Deobfuscated by DevAurora Code
-- Detected obfuscation: Luraph v15
-- Local names are inferred from use (the original names are not in the bytecode)

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
local Lighting = game:GetService("Lighting")
game:GetService("SoundService")
game:GetService("VirtualUser")
local VirtualInputManager = game:GetService("VirtualInputManager")
local HttpService = game:GetService("HttpService")
local CollectionService = game:GetService("CollectionService")
local TeleportService = game:GetService("TeleportService")
local localPlayer = Players.LocalPlayer
local placeId = game.PlaceId

if not (tbl[placeId] or tbl2[placeId] or tbl3[placeId]) then
	localPlayer:Kick("You have been permanently banned.")
	return
end

local genv = type(getgenv) == "function" and getgenv() or _G
local pullLeverConfig = type(genv.PullLeverConfig) == "table" and genv.PullLeverConfig or {}
pullLeverConfig.Status = type(pullLeverConfig.Status) == "table" and pullLeverConfig.Status or {}
pullLeverConfig.Race = type(pullLeverConfig.Race) == "table" and pullLeverConfig.Race or {}
genv.PullLeverConfig = pullLeverConfig
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
local pullLeverConfig2 = type(genv2.PullLeverConfig) == "table" and genv2.PullLeverConfig or {}
pullLeverConfig2.Status = type(pullLeverConfig2.Status) == "table" and pullLeverConfig2.Status or {}
local tbl4 = {}
local colorIslandGui = nil

local tbl5 = {
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

local tbl6 = {
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

local tbl7 = {
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

local function fn(arg, arg2, arg3)
	return { Value = arg, Target = arg, Velocity = 0, Stiffness = arg2, Damping = arg3 }
end

local function fn2(arg, arg2)
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
	frame.BackgroundColor3 = tbl6.White
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

local function fn3(arg, arg2, arg3)
	return arg:Lerp(arg2, arg3)
end

local function fn4(arg)
	local n = math.max(math.floor(arg), 0)
	local n2 = math.floor(n / 3600)
	local n3 = math.floor(n % 3600 / 60)
	local n4 = n % 60
	if n2 > 0 then
		return string.format("%d:%02d:%02d", n2, n3, n4)
	end
	return string.format("%02d:%02d", n3, n4)
end

local function fn5(arg, arg2, arg3)
	return string.format("%d %s", arg, arg == 1 and arg2 or arg3)
end

local function fn6()
	local ok, result = pcall(function()
		return DateTime.now():FormatLocalTime("HH:mm:ss", "en-us")
	end)

	if ok and typeof(result) == "string" then
		return result
	end
	return "--:--:--"
end

tbl4.Build = function()
	local tbl8 = {
		AccentColor = Color3.fromRGB(58, 140, 255),
		AnimationSpeed = 1,
		ReduceMotion = false,
		Transparency = 0,
	}

	for k, statu in pairs(pullLeverConfig2.Status) do
		tbl8[k] = statu
	end

	local flag = tbl8.ReduceMotion == true
	local n = 1

	if typeof(tbl8.AnimationSpeed) == "number" then
		n = math.clamp(tbl8.AnimationSpeed, 0.25, 3)
	end

	local backgroundTransparency = 0

	if typeof(tbl8.Transparency) == "number" then
		backgroundTransparency = math.clamp(tbl8.Transparency, 0, 0.5)
	end

	local accentColor = typeof(tbl8.AccentColor) == "Color3" and tbl8.AccentColor or Color3.fromRGB(58, 140, 255)
	local playerGui = localPlayer2:WaitForChild("PlayerGui")
	local colorIslandGui2 = playerGui:FindFirstChild("ColorIslandGui")

	if colorIslandGui2 then
		colorIslandGui2:Destroy()
	end

	local tbl9 = {}

	local tbl10 = {
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
		ReaderWidth = tbl5.ReaderMaxWidth,
		ReaderHeight = tbl5.ReaderMaxHeight,
		ReaderRowHeight = tbl5.ReaderRowHeight,
		ReaderNarrow = false,
		ReaderOriginX = 0,
		ReaderOriginY = 0,
		ReaderOriginWidth = 80,
		ReaderTargetX = 0,
		ReaderTargetY = 0,
	}

	local tbl11 = {
		Width = fn(tbl5.DormantWidth, 200, 26),
		Height = fn(tbl5.BarHeight, 200, 26),
		Radius = fn(tbl5.BarHeight / 2, 220, 30),
		TitleAlpha = fn(0, 260, 30),
		CardAlpha = fn(0, 240, 30),
		Press = fn(1, 420, 26),
		Bloom = fn(0, 160, 26),
		Progress = fn(0, 180, 28),
		Reader = fn(0, 240, 24),
	}

	local tbl12 = {}
	local tbl13 = {}
	local tbl14 = {}
	local flag2 = false

	local function fn7(arg)
		table.insert(tbl14, arg)
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
	frame.Position = UDim2.new(0.5, 0, 0, tbl5.TopOffset)
	frame.Size = UDim2.fromOffset(tbl5.CompactWidth, tbl5.BarHeight)
	frame.BackgroundTransparency = 1
	frame.BorderSizePixel = 0
	frame.ZIndex = 1
	frame.Parent = screenGui
	tbl9.Scale = Instance.new("UIScale")
	tbl9.Scale.Name = "ResponsiveScale"
	tbl9.Scale.Scale = tbl5.MaximumScale
	tbl9.Scale.Parent = frame
	tbl9.Bloom = {}
	tbl9.BloomCorners = {}

	for i = 1, 5 do
		local v = createFrame(frame, "Bloom" .. i, 1)
		v.AnchorPoint = Vector2.new(0.5, 0.5)
		v.Position = UDim2.new(0.5, 0, 0, tbl5.BarHeight / 2)
		v.BackgroundTransparency = 1
		tbl9.BloomCorners[i] = createUICorner(v, UDim.new(0, 30))
		tbl9.Bloom[i] = v
	end

	tbl9.Shell = createFrame(frame, "Shell", 2)
	tbl9.Shell.AnchorPoint = Vector2.new(0.5, 0)
	tbl9.Shell.Position = UDim2.fromScale(0.5, 0)
	tbl9.Shell.BackgroundColor3 = tbl6.Shell
	tbl9.Shell.BackgroundTransparency = backgroundTransparency
	tbl9.Shell.ClipsDescendants = true
	tbl9.ShellCorner = createUICorner(tbl9.Shell, UDim.new(1, 0))
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Name = "Depth"
	local colorSequence = ColorSequence.new
	local tbl15 = {}
	local v = ColorSequenceKeypoint.new(0, tbl6.ShellTop)
	local v2 = ColorSequenceKeypoint.new(0.5, tbl6.ShellBottom)
	local new = ColorSequenceKeypoint.new
	local shell = tbl6.Shell
	tbl15[1] = v
	tbl15[2] = v2

	do
		local values = table.pack(new(1, shell))
		table.move(values, 1, values.n, 3, tbl15)
	end

	uiGradient.Color = colorSequence(tbl15)
	uiGradient.Rotation = 90
	uiGradient.Parent = tbl9.Shell
	tbl9.Stroke = Instance.new("UIStroke")
	tbl9.Stroke.Name = "Edge"
	tbl9.Stroke.Color = tbl6.White
	tbl9.Stroke.Transparency = 0.88
	tbl9.Stroke.Thickness = 1
	tbl9.Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	tbl9.Stroke.Parent = tbl9.Shell
	tbl9.Wash = createFrame(tbl9.Shell, "Wash", 3)
	tbl9.Wash.Size = UDim2.fromScale(1, 1)
	tbl9.Wash.BackgroundTransparency = 1
	tbl9.WashCorner = createUICorner(tbl9.Wash, UDim.new(0, 28))
	tbl9.Hairline = createFrame(tbl9.Shell, "Hairline", 4)
	tbl9.Hairline.AnchorPoint = Vector2.new(0.5, 0)
	tbl9.Hairline.Position = UDim2.new(0.5, 0, 0, 2)
	tbl9.Hairline.Size = UDim2.new(0.62, 0, 0, 1)
	tbl9.Hairline.BackgroundTransparency = 0.55
	local uiGradient2 = Instance.new("UIGradient")
	uiGradient2.Name = "Fade"
	local numberSequence = NumberSequence.new
	local tbl16 = {}
	local v3 = NumberSequenceKeypoint.new(0, 1)
	local v4 = NumberSequenceKeypoint.new(0.5, 0)
	local new2 = NumberSequenceKeypoint.new
	tbl16[1] = v3
	tbl16[2] = v4

	do
		local values = table.pack(new2(1, 1))
		table.move(values, 1, values.n, 3, tbl16)
	end

	uiGradient2.Transparency = numberSequence(tbl16)
	uiGradient2.Parent = tbl9.Hairline
	tbl9.Content = Instance.new("Frame")
	tbl9.Content.Name = "Content"
	tbl9.Content.Size = UDim2.fromScale(1, 1)
	tbl9.Content.BackgroundTransparency = 1
	tbl9.Content.BorderSizePixel = 0
	tbl9.Content.ZIndex = 5
	tbl9.Content.Parent = tbl9.Shell
	tbl9.Header = Instance.new("Frame")
	tbl9.Header.Name = "Header"
	tbl9.Header.Size = UDim2.new(1, 0, 0, tbl5.BarHeight)
	tbl9.Header.BackgroundTransparency = 1
	tbl9.Header.BorderSizePixel = 0
	tbl9.Header.ZIndex = 5
	tbl9.Header.Parent = tbl9.Content
	tbl9.Slot = Instance.new("Frame")
	tbl9.Slot.Name = "IconSlot"
	tbl9.Slot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.Slot.Position = UDim2.fromOffset(32, tbl5.BarHeight / 2)
	tbl9.Slot.Size = UDim2.fromOffset(30, 30)
	tbl9.Slot.BackgroundTransparency = 1
	tbl9.Slot.BorderSizePixel = 0
	tbl9.Slot.ZIndex = 6
	tbl9.Slot.Parent = tbl9.Header
	tbl9.Halo = createFrame(tbl9.Slot, "Halo", 6)
	tbl9.Halo.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.Halo.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.Halo.Size = UDim2.fromOffset(30, 30)
	tbl9.Halo.BackgroundTransparency = 0.78
	createUICorner(tbl9.Halo, UDim.new(1, 0))
	tbl9.GlyphDot = createFrame(tbl9.Slot, "GlyphDot", 7)
	tbl9.GlyphDot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.GlyphDot.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.GlyphDot.Size = UDim2.fromOffset(12, 12)
	createUICorner(tbl9.GlyphDot, UDim.new(1, 0))
	tbl9.GlyphSpin = Instance.new("Frame")
	tbl9.GlyphSpin.Name = "GlyphSpin"
	tbl9.GlyphSpin.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.GlyphSpin.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.GlyphSpin.Size = UDim2.fromOffset(20, 20)
	tbl9.GlyphSpin.BackgroundTransparency = 1
	tbl9.GlyphSpin.BorderSizePixel = 0
	tbl9.GlyphSpin.ZIndex = 7
	tbl9.GlyphSpin.Parent = tbl9.Slot
	tbl9.SpinRing = createFrame(tbl9.GlyphSpin, "Ring", 7)
	tbl9.SpinRing.Size = UDim2.fromScale(1, 1)
	tbl9.SpinRing.BackgroundTransparency = 1
	createUICorner(tbl9.SpinRing, UDim.new(1, 0))
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = "RingStroke"
	uiStroke.Thickness = 2
	uiStroke.Transparency = 0.72
	uiStroke.Parent = tbl9.SpinRing
	tbl9.SpinStroke = uiStroke
	tbl9.SpinHead = createFrame(tbl9.GlyphSpin, "Head", 8)
	tbl9.SpinHead.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.SpinHead.Position = UDim2.fromScale(0.5, 0)
	tbl9.SpinHead.Size = UDim2.fromOffset(6, 6)
	createUICorner(tbl9.SpinHead, UDim.new(1, 0))
	tbl9.GlyphCheck = Instance.new("Frame")
	tbl9.GlyphCheck.Name = "GlyphCheck"
	tbl9.GlyphCheck.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.GlyphCheck.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.GlyphCheck.Size = UDim2.fromOffset(20, 20)
	tbl9.GlyphCheck.BackgroundTransparency = 1
	tbl9.GlyphCheck.BorderSizePixel = 0
	tbl9.GlyphCheck.ZIndex = 7
	tbl9.GlyphCheck.Parent = tbl9.Slot
	tbl9.CheckShort = createFrame(tbl9.GlyphCheck, "Short", 8)
	tbl9.CheckShort.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.CheckShort.Position = UDim2.fromOffset(6, 12)
	tbl9.CheckShort.Size = UDim2.fromOffset(8, 2.5)
	tbl9.CheckShort.Rotation = 45
	createUICorner(tbl9.CheckShort, UDim.new(1, 0))
	tbl9.CheckLong = createFrame(tbl9.GlyphCheck, "Long", 8)
	tbl9.CheckLong.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.CheckLong.Position = UDim2.fromOffset(12, 9)
	tbl9.CheckLong.Size = UDim2.fromOffset(15, 2.5)
	tbl9.CheckLong.Rotation = -45
	createUICorner(tbl9.CheckLong, UDim.new(1, 0))
	tbl9.GlyphCross = Instance.new("Frame")
	tbl9.GlyphCross.Name = "GlyphCross"
	tbl9.GlyphCross.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.GlyphCross.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.GlyphCross.Size = UDim2.fromOffset(20, 20)
	tbl9.GlyphCross.BackgroundTransparency = 1
	tbl9.GlyphCross.BorderSizePixel = 0
	tbl9.GlyphCross.ZIndex = 7
	tbl9.GlyphCross.Parent = tbl9.Slot

	for i = 1, 2 do
		local v5 = createFrame(tbl9.GlyphCross, "Stroke" .. i, 8)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.fromScale(0.5, 0.5)
		v5.Size = UDim2.fromOffset(15, 2.5)
		v5.Rotation = i == 1 and 45 or -45
		createUICorner(v5, UDim.new(1, 0))
	end

	tbl9.GlyphBang = Instance.new("Frame")
	tbl9.GlyphBang.Name = "GlyphBang"
	tbl9.GlyphBang.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.GlyphBang.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.GlyphBang.Size = UDim2.fromOffset(20, 20)
	tbl9.GlyphBang.BackgroundTransparency = 1
	tbl9.GlyphBang.BorderSizePixel = 0
	tbl9.GlyphBang.ZIndex = 7
	tbl9.GlyphBang.Parent = tbl9.Slot
	tbl9.BangStem = createFrame(tbl9.GlyphBang, "Stem", 8)
	tbl9.BangStem.AnchorPoint = Vector2.new(0.5, 0)
	tbl9.BangStem.Position = UDim2.fromOffset(10, 3)
	tbl9.BangStem.Size = UDim2.fromOffset(2.5, 9)
	createUICorner(tbl9.BangStem, UDim.new(1, 0))
	tbl9.BangDot = createFrame(tbl9.GlyphBang, "Tip", 8)
	tbl9.BangDot.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.BangDot.Position = UDim2.fromOffset(10, 16)
	tbl9.BangDot.Size = UDim2.fromOffset(2.5, 2.5)
	createUICorner(tbl9.BangDot, UDim.new(1, 0))

	tbl9.Glyphs = {
		Dot = tbl9.GlyphDot,
		Breath = tbl9.GlyphDot,
		Spinner = tbl9.GlyphSpin,
		Check = tbl9.GlyphCheck,
		Cross = tbl9.GlyphCross,
		Bang = tbl9.GlyphBang,
	}

	tbl9.TitleClip = Instance.new("CanvasGroup")
	tbl9.TitleClip.Name = "TitleClip"
	tbl9.TitleClip.Position = UDim2.fromOffset(58, 10)
	tbl9.TitleClip.Size = UDim2.new(1, -150, 0, 22)
	tbl9.TitleClip.BackgroundTransparency = 1
	tbl9.TitleClip.GroupTransparency = 1
	tbl9.TitleClip.BorderSizePixel = 0
	tbl9.TitleClip.ClipsDescendants = true
	tbl9.TitleClip.ZIndex = 6
	tbl9.TitleClip.Parent = tbl9.Header
	tbl9.TitleA = createTextLabel(tbl9.TitleClip, "TitleA", Enum.Font.GothamBold, 17, tbl6.Title, Enum.TextXAlignment.Left, 6)
	tbl9.TitleA.Size = UDim2.fromScale(1, 1)
	tbl9.TitleB = createTextLabel(tbl9.TitleClip, "TitleB", Enum.Font.GothamBold, 17, tbl6.Title, Enum.TextXAlignment.Left, 6)
	tbl9.TitleB.Size = UDim2.fromScale(1, 1)
	tbl9.TitleB.TextTransparency = 1
	tbl9.ActiveTitle = tbl9.TitleA
	tbl9.Detail = createTextLabel(tbl9.Header, "Detail", Enum.Font.GothamMedium, 13, tbl6.Muted, Enum.TextXAlignment.Left, 6)
	tbl9.Detail.Position = UDim2.fromOffset(58, 31)
	tbl9.Detail.Size = UDim2.new(1, -150, 0, 15)
	tbl9.Trail = Instance.new("Frame")
	tbl9.Trail.Name = "Trail"
	tbl9.Trail.AnchorPoint = Vector2.new(1, 0.5)
	tbl9.Trail.Position = UDim2.new(1, -22, 0, tbl5.BarHeight / 2)
	tbl9.Trail.Size = UDim2.fromOffset(58, 30)
	tbl9.Trail.BackgroundTransparency = 1
	tbl9.Trail.BorderSizePixel = 0
	tbl9.Trail.ZIndex = 6
	tbl9.Trail.Parent = tbl9.Header
	tbl9.Bars = {}

	for i = 1, 4 do
		local v5 = createFrame(tbl9.Trail, "Bar" .. i, 7)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.new(1, -6 - (4 - i) * 9, 0.5, 0)
		v5.Size = UDim2.fromOffset(3.5, 10)
		createUICorner(v5, UDim.new(1, 0))
		tbl9.Bars[i] = v5
	end

	tbl9.Pulse = createFrame(tbl9.Trail, "Pulse", 7)
	tbl9.Pulse.AnchorPoint = Vector2.new(1, 0.5)
	tbl9.Pulse.Position = UDim2.new(1, 0, 0.5, 0)
	tbl9.Pulse.Size = UDim2.fromOffset(8, 8)
	tbl9.Pulse.BackgroundTransparency = 1
	createUICorner(tbl9.Pulse, UDim.new(1, 0))
	tbl9.Pips = {}

	for i = 1, 3 do
		local v5 = createFrame(tbl9.Header, "Pip" .. i, 7)
		v5.AnchorPoint = Vector2.new(0.5, 0.5)
		v5.Position = UDim2.new(1, -22 - (3 - i) * 7, 0, 12)
		v5.Size = UDim2.fromOffset(3.5, 3.5)
		v5.BackgroundTransparency = 1
		createUICorner(v5, UDim.new(1, 0))
		tbl9.Pips[i] = v5
	end

	tbl9.Track = createFrame(tbl9.Header, "Track", 6)
	tbl9.Track.Position = UDim2.fromOffset(58, 48)
	tbl9.Track.Size = UDim2.new(1, -80, 0, 2)
	tbl9.Track.BackgroundColor3 = Color3.fromRGB(52, 52, 58)
	tbl9.Track.BackgroundTransparency = 1
	tbl9.Track.ClipsDescendants = true
	createUICorner(tbl9.Track, UDim.new(1, 0))
	tbl9.Fill = createFrame(tbl9.Track, "Fill", 7)
	tbl9.Fill.Position = UDim2.fromScale(0, 0)
	tbl9.Fill.Size = UDim2.fromScale(0, 1)
	tbl9.Fill.BackgroundTransparency = 1
	createUICorner(tbl9.Fill, UDim.new(1, 0))
	tbl9.Comet = createFrame(tbl9.Track, "Comet", 7)
	tbl9.Comet.Position = UDim2.fromScale(-0.35, 0)
	tbl9.Comet.Size = UDim2.fromScale(0.35, 1)
	tbl9.Comet.BackgroundTransparency = 1
	createUICorner(tbl9.Comet, UDim.new(1, 0))
	local uiGradient3 = Instance.new("UIGradient")
	uiGradient3.Name = "Fade"
	local numberSequence2 = NumberSequence.new
	local tbl17 = {}
	local v5 = NumberSequenceKeypoint.new(0, 1)
	local v6 = NumberSequenceKeypoint.new(0.5, 0)
	local new3 = NumberSequenceKeypoint.new
	tbl17[1] = v5
	tbl17[2] = v6

	do
		local values = table.pack(new3(1, 1))
		table.move(values, 1, values.n, 3, tbl17)
	end

	uiGradient3.Transparency = numberSequence2(tbl17)
	uiGradient3.Parent = tbl9.Comet
	tbl9.Card = Instance.new("CanvasGroup")
	tbl9.Card.Name = "Card"
	tbl9.Card.Position = UDim2.fromOffset(26, tbl5.BarHeight + 8)
	tbl9.Card.Size = UDim2.new(1, -52, 0, tbl5.CardHeight - tbl5.BarHeight - 24)
	tbl9.Card.BackgroundTransparency = 1
	tbl9.Card.GroupTransparency = 1
	tbl9.Card.BorderSizePixel = 0
	tbl9.Card.Visible = false
	tbl9.Card.ZIndex = 6
	tbl9.Card.Parent = tbl9.Content
	local rule = createFrame(tbl9.Card, "Rule", 6)
	rule.Size = UDim2.new(1, 0, 0, 1)
	rule.BackgroundTransparency = 0.9
	tbl9.Rows = {}

	for i = 1, 3 do
		local frame2 = Instance.new("Frame")
		frame2.Name = "Row" .. i
		frame2.Position = UDim2.fromOffset(0, 12 + (i - 1) * 32)
		frame2.Size = UDim2.new(1, 0, 0, 28)
		frame2.BackgroundTransparency = 1
		frame2.BorderSizePixel = 0
		frame2.Visible = false
		frame2.ZIndex = 6
		frame2.Parent = tbl9.Card
		local marker = createFrame(frame2, "Marker", 7)
		marker.AnchorPoint = Vector2.new(0.5, 0.5)
		marker.Position = UDim2.fromOffset(4, 14)
		marker.Size = UDim2.fromOffset(6, 6)
		createUICorner(marker, UDim.new(1, 0))
		local message = createTextLabel(frame2, "Message", Enum.Font.GothamMedium, 14, tbl6.Body, Enum.TextXAlignment.Left, 7)
		message.Position = UDim2.fromOffset(20, 0)
		message.Size = UDim2.new(1, -96, 1, 0)
		local stamp = createTextLabel(frame2, "Stamp", Enum.Font.Gotham, 12, tbl6.Muted, Enum.TextXAlignment.Right, 7)
		stamp.Position = UDim2.new(1, -72, 0, 0)
		stamp.Size = UDim2.fromOffset(72, 28)
		tbl9.Rows[i] = { Frame = frame2, Marker = marker, Message = message, Stamp = stamp }
	end

	tbl9.Empty = createTextLabel(tbl9.Card, "Empty", Enum.Font.GothamMedium, 14, tbl6.Muted, Enum.TextXAlignment.Center, 7)
	tbl9.Empty.Position = UDim2.fromOffset(0, 30)
	tbl9.Empty.Size = UDim2.new(1, 0, 0, 28)
	tbl9.Empty.Text = "No activity yet"
	tbl9.Stats = createTextLabel(tbl9.Card, "Stats", Enum.Font.Gotham, 12, tbl6.Muted, Enum.TextXAlignment.Left, 7)
	tbl9.Stats.Position = UDim2.fromOffset(2, 112)
	tbl9.Stats.Size = UDim2.new(1, -4, 0, 16)

	local function createTextButton(name, anchorPoint, position, text)
		local textButton = Instance.new("TextButton")
		textButton.Name = name
		textButton.AutoLocalize = false
		textButton.AnchorPoint = anchorPoint
		textButton.Position = position
		textButton.Size = UDim2.fromOffset(150, 30)
		textButton.BackgroundColor3 = tbl6.White
		textButton.BackgroundTransparency = 0.9
		textButton.AutoButtonColor = false
		textButton.Font = Enum.Font.GothamMedium
		textButton.Text = text
		textButton.TextSize = 13
		textButton.TextColor3 = tbl6.Body
		textButton.BorderSizePixel = 0
		textButton.ZIndex = 8
		textButton.Parent = tbl9.Card
		createUICorner(textButton, UDim.new(1, 0))
		return textButton
	end

	tbl9.Pin = createTextButton("Pin", Vector2.new(0, 1), UDim2.new(0, 0, 1, 0), "Keep open")
	tbl9.Open = createTextButton("Open", Vector2.new(0.5, 1), UDim2.new(0.5, 0, 1, 0), "Read full log")
	tbl9.Clear = createTextButton("Clear", Vector2.new(1, 1), UDim2.new(1, 0, 1, 0), "Clear")
	tbl9.ReaderRoot = Instance.new("Frame")
	tbl9.ReaderRoot.Name = "ReaderRoot"
	tbl9.ReaderRoot.Size = UDim2.fromScale(1, 1)
	tbl9.ReaderRoot.BackgroundTransparency = 1
	tbl9.ReaderRoot.BorderSizePixel = 0
	tbl9.ReaderRoot.Visible = false
	tbl9.ReaderRoot.ZIndex = 50
	tbl9.ReaderRoot.Parent = screenGui
	tbl9.ReaderDim = Instance.new("TextButton")
	tbl9.ReaderDim.Name = "Dim"
	tbl9.ReaderDim.AutoLocalize = false
	tbl9.ReaderDim.Size = UDim2.fromScale(1, 1)
	tbl9.ReaderDim.BackgroundColor3 = tbl6.Black
	tbl9.ReaderDim.BackgroundTransparency = 1
	tbl9.ReaderDim.AutoButtonColor = false
	tbl9.ReaderDim.Text = ""
	tbl9.ReaderDim.BorderSizePixel = 0
	tbl9.ReaderDim.ZIndex = 50
	tbl9.ReaderDim.Parent = tbl9.ReaderRoot
	tbl9.Reader = Instance.new("CanvasGroup")
	tbl9.Reader.Name = "Reader"
	tbl9.Reader.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.Reader.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.Reader.Size = UDim2.fromOffset(tbl10.ReaderWidth, tbl10.ReaderHeight)
	tbl9.Reader.BackgroundColor3 = Color3.fromRGB(11, 11, 13)
	tbl9.Reader.GroupTransparency = 1
	tbl9.Reader.BorderSizePixel = 0
	tbl9.Reader.ZIndex = 51
	tbl9.Reader.Parent = tbl9.ReaderRoot
	createUICorner(tbl9.Reader, UDim.new(0, 26))
	tbl9.ReaderScale = Instance.new("UIScale")
	tbl9.ReaderScale.Name = "ReaderScale"
	tbl9.ReaderScale.Scale = 1
	tbl9.ReaderScale.Parent = tbl9.Reader
	local uiStroke2 = Instance.new("UIStroke")
	uiStroke2.Color = tbl6.White
	uiStroke2.Transparency = 0.9
	uiStroke2.Thickness = 1
	uiStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke2.Parent = tbl9.Reader
	tbl9.ReaderTitle = createTextLabel(tbl9.Reader, "Title", Enum.Font.GothamBold, 20, tbl6.Title, Enum.TextXAlignment.Left, 52)
	tbl9.ReaderTitle.Position = UDim2.fromOffset(28, 22)
	tbl9.ReaderTitle.Size = UDim2.new(1, -140, 0, 26)
	tbl9.ReaderTitle.Text = "Log"
	tbl9.ReaderCount = createTextLabel(tbl9.Reader, "Count", Enum.Font.GothamMedium, 13, tbl6.Muted, Enum.TextXAlignment.Left, 52)
	tbl9.ReaderCount.Position = UDim2.fromOffset(28, 48)
	tbl9.ReaderCount.Size = UDim2.new(1, -140, 0, 18)
	tbl9.ReaderClose = Instance.new("TextButton")
	tbl9.ReaderClose.Name = "Close"
	tbl9.ReaderClose.AutoLocalize = false
	tbl9.ReaderClose.AnchorPoint = Vector2.new(1, 0)
	tbl9.ReaderClose.Position = UDim2.new(1, -24, 0, 24)
	tbl9.ReaderClose.Size = UDim2.fromOffset(88, 32)
	tbl9.ReaderClose.BackgroundColor3 = tbl6.White
	tbl9.ReaderClose.BackgroundTransparency = 0.9
	tbl9.ReaderClose.AutoButtonColor = false
	tbl9.ReaderClose.Font = Enum.Font.GothamMedium
	tbl9.ReaderClose.Text = "Close"
	tbl9.ReaderClose.TextSize = 13
	tbl9.ReaderClose.TextColor3 = tbl6.Body
	tbl9.ReaderClose.BorderSizePixel = 0
	tbl9.ReaderClose.ZIndex = 53
	tbl9.ReaderClose.Parent = tbl9.Reader
	createUICorner(tbl9.ReaderClose, UDim.new(1, 0))
	tbl9.ReaderRule = createFrame(tbl9.Reader, "Rule", 52)
	tbl9.ReaderRule.Position = UDim2.fromOffset(28, 76)
	tbl9.ReaderRule.Size = UDim2.new(1, -56, 0, 1)
	tbl9.ReaderRule.BackgroundTransparency = 0.9
	tbl9.ReaderList = Instance.new("ScrollingFrame")
	tbl9.ReaderList.Name = "List"
	tbl9.ReaderList.Position = UDim2.fromOffset(24, 88)
	tbl9.ReaderList.Size = UDim2.new(1, -48, 1, -128)
	tbl9.ReaderList.BackgroundTransparency = 1
	tbl9.ReaderList.BorderSizePixel = 0
	tbl9.ReaderList.ScrollBarThickness = 3
	tbl9.ReaderList.ScrollBarImageColor3 = tbl6.White
	tbl9.ReaderList.ScrollBarImageTransparency = 0.7
	tbl9.ReaderList.CanvasSize = UDim2.new()
	tbl9.ReaderList.ZIndex = 52
	tbl9.ReaderList.Parent = tbl9.Reader
	local uiListLayout = Instance.new("UIListLayout")
	uiListLayout.FillDirection = Enum.FillDirection.Vertical
	uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	uiListLayout.Padding = UDim.new(0, 2)
	uiListLayout.Parent = tbl9.ReaderList
	tbl9.ReaderFoot = createTextLabel(tbl9.Reader, "Foot", Enum.Font.Gotham, 12, tbl6.Muted, Enum.TextXAlignment.Left, 52)
	tbl9.ReaderFoot.AnchorPoint = Vector2.new(0, 1)
	tbl9.ReaderFoot.Position = UDim2.new(0, 28, 1, -16)
	tbl9.ReaderFoot.Size = UDim2.new(1, -56, 0, 16)
	tbl9.ReaderEmpty = createTextLabel(tbl9.Reader, "Empty", Enum.Font.GothamMedium, 15, tbl6.Muted, Enum.TextXAlignment.Center, 52)
	tbl9.ReaderEmpty.AnchorPoint = Vector2.new(0.5, 0.5)
	tbl9.ReaderEmpty.Position = UDim2.fromScale(0.5, 0.5)
	tbl9.ReaderEmpty.Size = UDim2.new(1, 0, 0, 24)
	tbl9.ReaderEmpty.Text = "No activity yet"
	tbl9.ReaderRows = {}
	tbl9.Tap = Instance.new("TextButton")
	tbl9.Tap.Name = "Tap"
	tbl9.Tap.AutoLocalize = false
	tbl9.Tap.Size = UDim2.new(1, 0, 0, tbl5.BarHeight)
	tbl9.Tap.BackgroundTransparency = 1
	tbl9.Tap.Text = ""
	tbl9.Tap.AutoButtonColor = false
	tbl9.Tap.ZIndex = 9
	tbl9.Tap.Parent = tbl9.Shell
	local tbl18 = {}

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
		tbl18[v7] = bindableEvent
	end

	screenGui.Parent = playerGui

	local function fn8(arg)
		if typeof(arg) == "string" and tbl7[arg] then
			return arg
		end
		return "Working"
	end

	local function fn9(arg)
		if arg == "Sleep" then
			return tbl5.SleepWidth, tbl5.BarHeight, tbl5.BarHeight / 2, 0, 0
		end

		if arg == "Dormant" then
			return tbl5.DormantWidth, tbl5.BarHeight, tbl5.BarHeight / 2, 0, 0
		end

		if arg == "Compact" then
			return tbl5.CompactWidth, tbl5.BarHeight, tbl5.BarHeight / 2, 1, 0
		end
		return tbl5.ExpandedWidth, tbl5.CardHeight, 28, 1, 1
	end

	local function fn10(arg)
		local damping = arg and 24 or 34
		tbl11.Width.Damping = damping
		tbl11.Height.Damping = damping
	end

	local function fn11(tier, arg)
		if tbl10.Destroyed then
			return
		end
		local v7, v8, v9, v10, v11 = fn9(tier)
		tbl10.Tier = tier
		fn10(v7 > tbl11.Width.Value or v8 > tbl11.Height.Value)
		tbl11.Width.Target = v7
		tbl11.Height.Target = v8
		tbl11.Radius.Target = v9
		tbl11.TitleAlpha.Target = v10
		tbl11.CardAlpha.Target = v11

		if v11 > 0 then
			tbl9.Card.Visible = true
		end

		if arg or flag then
			for _, v12 in pairs(tbl11) do
				v12.Value = v12.Target
				v12.Velocity = 0
			end
		end
	end

	local function fn12(arg)
		tbl10.HoldToken = tbl10.HoldToken + 1
		local holdToken = tbl10.HoldToken

		local function fn13()
			return not tbl10.Destroyed and holdToken == tbl10.HoldToken and tbl10.Tier ~= "Expanded" and not tbl10.Pinned
		end

		task.delay(arg / n, function()
			if not fn13() then
				return
			end
			fn11("Dormant")

			task.delay(tbl5.SleepDelay / n, function()
				if fn13() then
					fn11("Sleep")
				end
			end)
		end)
	end

	local function fn13()
		tbl10.CardToken = tbl10.CardToken + 1
		local cardToken = tbl10.CardToken

		task.delay(tbl5.CardHold / n, function()
			if tbl10.Destroyed or cardToken ~= tbl10.CardToken or tbl10.Tier ~= "Expanded" or tbl10.Pinned then
				return
			end
			fn11("Dormant")
		end)
	end

	local function fn14()
		tbl10.CardToken = tbl10.CardToken + 1
	end

	local function fn15(accent)
		tbl10.Accent = accent
		tbl9.Halo.BackgroundColor3 = accent
		tbl9.GlyphDot.BackgroundColor3 = accent
		tbl9.SpinStroke.Color = accent
		tbl9.SpinHead.BackgroundColor3 = fn3(accent, tbl6.White, 0.5)
		tbl9.CheckShort.BackgroundColor3 = accent
		tbl9.CheckLong.BackgroundColor3 = accent
		tbl9.BangStem.BackgroundColor3 = accent
		tbl9.BangDot.BackgroundColor3 = accent
		tbl9.Wash.BackgroundColor3 = accent
		tbl9.Pulse.BackgroundColor3 = accent
		tbl9.Fill.BackgroundColor3 = fn3(accent, tbl6.White, 0.2)
		tbl9.Comet.BackgroundColor3 = fn3(accent, tbl6.White, 0.35)
		tbl9.Pin.TextColor3 = fn3(accent, tbl6.White, 0.5)

		for _, child in ipairs(tbl9.GlyphCross:GetChildren()) do
			if child:IsA("Frame") then
				child.BackgroundColor3 = accent
			end
		end

		for _, bar in ipairs(tbl9.Bars) do
			bar.BackgroundColor3 = accent
		end

		for _, v7 in ipairs(tbl9.Bloom) do
			v7.BackgroundColor3 = accent
		end
	end

	local function fn16(glyph)
		tbl10.Glyph = glyph

		for _, glyph2 in pairs(tbl9.Glyphs) do
			glyph2.Visible = false
		end
		;(tbl9.Glyphs[glyph] or tbl9.GlyphDot).Visible = true
	end

	local function fn17(text)
		local activeTitle = tbl9.ActiveTitle
		local titleB = activeTitle == tbl9.TitleA and tbl9.TitleB or tbl9.TitleA
		titleB.Text = text
		tbl9.ActiveTitle = titleB

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

	local function fn18()
		local n2 = math.min(#tbl13, 3)

		for i, pip in ipairs(tbl9.Pips) do
			pip.BackgroundColor3 = tbl10.Accent
			pip.BackgroundTransparency = i <= n2 and 0.25 or 1
		end
	end

	local function fn19()
		local n2 = #tbl12

		for i, row in ipairs(tbl9.Rows) do
			local v7 = tbl12[n2 - i + 1]

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

		tbl9.Empty.Visible = n2 == 0
		local sessionEnd = tbl10.SessionEnd or os.clock()
		local retries = tbl10.Retries
		tbl9.Stats.Text = string.format("Elapsed %s   |   %s   |   %s   |   %s", fn4(sessionEnd - tbl10.SessionStart), fn5(tbl10.Events, "event", "events"), fn5(tbl10.Issues, "issue", "issues"), fn5(retries, "retry", "retries"))
	end

	local function fn20(arg)
		local readerNarrow = tbl10.ReaderNarrow
		local readerRowHeight = tbl10.ReaderRowHeight
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

	local function fn21()
		local readerNarrow = tbl10.ReaderNarrow
		tbl9.ReaderTitle.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 15 or 22)
		tbl9.ReaderTitle.Size = UDim2.new(1, readerNarrow and -110 or -140, 0, 26)
		tbl9.ReaderTitle.TextSize = readerNarrow and 17 or 20
		tbl9.ReaderCount.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 38 or 48)
		tbl9.ReaderCount.Size = UDim2.new(1, readerNarrow and -110 or -140, 0, 18)
		tbl9.ReaderClose.Position = UDim2.new(1, readerNarrow and -16 or -24, 0, readerNarrow and 16 or 24)
		tbl9.ReaderClose.Size = UDim2.fromOffset(readerNarrow and 70 or 88, readerNarrow and 28 or 32)
		tbl9.ReaderRule.Position = UDim2.fromOffset(readerNarrow and 18 or 28, readerNarrow and 62 or 76)
		tbl9.ReaderRule.Size = UDim2.new(1, readerNarrow and -36 or -56, 0, 1)
		tbl9.ReaderList.Position = UDim2.fromOffset(readerNarrow and 14 or 24, readerNarrow and 72 or 88)
		tbl9.ReaderList.Size = UDim2.new(1, readerNarrow and -28 or -48, 1, readerNarrow and -104 or -128)
		tbl9.ReaderFoot.Position = UDim2.new(0, readerNarrow and 18 or 28, 1, readerNarrow and -12 or -16)
		tbl9.ReaderFoot.Size = UDim2.new(1, readerNarrow and -36 or -56, 0, 16)
		tbl9.ReaderFoot.TextSize = readerNarrow and 11 or 12

		for _, readerRow in ipairs(tbl9.ReaderRows) do
			fn20(readerRow)
		end
	end

	local function fn22(layoutOrder)
		local v7 = tbl9.ReaderRows[layoutOrder]
		if v7 then
			return v7
		end
		local frame2 = Instance.new("Frame")
		frame2.Name = "Entry" .. layoutOrder
		frame2.BackgroundColor3 = tbl6.White
		frame2.BackgroundTransparency = 0.97
		frame2.BorderSizePixel = 0
		frame2.LayoutOrder = layoutOrder
		frame2.ZIndex = 52
		frame2.Parent = tbl9.ReaderList
		createUICorner(frame2, UDim.new(0, 8))
		local marker = createFrame(frame2, "Marker", 53)
		marker.AnchorPoint = Vector2.new(0.5, 0.5)
		marker.Position = UDim2.fromOffset(16, tbl5.ReaderRowHeight / 2)
		marker.Size = UDim2.fromOffset(7, 7)
		createUICorner(marker, UDim.new(1, 0))
		local stamp = createTextLabel(frame2, "Stamp", Enum.Font.Gotham, 13, tbl6.Muted, Enum.TextXAlignment.Left, 53)
		stamp.Position = UDim2.fromOffset(32, 0)
		stamp.Size = UDim2.fromOffset(74, tbl5.ReaderRowHeight)
		local kind = createTextLabel(frame2, "Kind", Enum.Font.GothamMedium, 13, tbl6.Muted, Enum.TextXAlignment.Left, 53)
		kind.Position = UDim2.fromOffset(110, 0)
		kind.Size = UDim2.fromOffset(74, tbl5.ReaderRowHeight)
		local message = createTextLabel(frame2, "Message", Enum.Font.GothamMedium, 14, tbl6.Body, Enum.TextXAlignment.Left, 53)
		message.Position = UDim2.fromOffset(190, 0)
		message.Size = UDim2.new(1, -206, 0, tbl5.ReaderRowHeight)
		local tbl19 = { Frame = frame2, Marker = marker, Stamp = stamp, Kind = kind, Message = message }
		tbl9.ReaderRows[layoutOrder] = tbl19
		fn20(tbl19)
		return tbl19
	end

	local function fn23()
		local n2 = #tbl12

		for i = 1, n2 do
			local v7 = tbl12[n2 - i + 1]
			local v8 = fn22(i)
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

		for i = n2 + 1, #tbl9.ReaderRows do
			tbl9.ReaderRows[i].Frame.Visible = false
		end

		tbl9.ReaderList.CanvasSize = UDim2.fromOffset(0, n2 * (tbl10.ReaderRowHeight + 2))
		tbl9.ReaderEmpty.Visible = n2 == 0
		tbl9.ReaderCount.Text = fn5(n2, "entry", "entries")
		local sessionEnd = tbl10.SessionEnd or os.clock()
		local retries = tbl10.Retries
		tbl9.ReaderFoot.Text = string.format("Elapsed %s   |   %s   |   %s   |   %s", fn4(sessionEnd - tbl10.SessionStart), fn5(tbl10.Events, "event", "events"), fn5(tbl10.Issues, "issue", "issues"), fn5(retries, "retry", "retries"))
	end

	local function fn24(readerOpen)
		if tbl10.Destroyed or tbl10.ReaderOpen == readerOpen then
			return
		end
		tbl10.ReaderOpen = readerOpen

		if readerOpen then
			local absolutePosition = tbl9.Open.AbsolutePosition
			local absoluteSize = tbl9.Open.AbsoluteSize
			tbl10.ReaderOriginX = absolutePosition.X + absoluteSize.X / 2
			tbl10.ReaderOriginY = absolutePosition.Y + absoluteSize.Y / 2
			tbl10.ReaderOriginWidth = math.max(absoluteSize.X, 8)
			fn23()
			tbl9.ReaderRoot.Visible = true
			tbl9.ReaderList.CanvasPosition = Vector2.new(0, 0)
			tbl11.Reader.Target = 1
			tbl10.Pinned = false
			tbl9.Pin.Text = "Keep open"
			fn14()
			fn11("Sleep")
		else
			tbl11.Reader.Target = 0
			fn12(0.25)
		end
	end

	local function fn25(arg)
		if flag then
			return
		end
		tbl9.Wash.BackgroundTransparency = (arg == "Error" or arg == "Success") and 0.82 or 0.92
		TweenService:Create(tbl9.Wash, TweenInfo.new(0.5 / n, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 1 }):Play()
		tbl11.Bloom.Value = 1
		tbl11.Bloom.Velocity = 0
		tbl11.Bloom.Target = 0
	end

	local function fn26(arg)
		local working = tbl7[arg.Kind] or tbl7.Working
		fn15(working.Color)
		fn16(working.Glyph)
		tbl10.Live = working.Live
		tbl10.Title = arg.Message
		tbl10.Detail = arg.Detail or ""
		fn17(arg.Message)
		tbl9.Detail.Text = tbl10.Detail
		fn25(arg.Kind)
		fn18()

		if tbl10.Tier == "Expanded" then
			fn19()
			fn13()
		else
			fn11("Compact")
			local holdDuration = tbl5.HoldDuration

			if arg.Kind == "Success" then
				holdDuration = tbl5.SuccessHold
			elseif arg.Kind == "Error" then
				holdDuration = tbl5.ErrorHold
			end

			fn12(holdDuration)
		end
	end

	local function fn27()
		if flag2 or tbl10.Destroyed then
			return
		end
		flag2 = true

		task.spawn(function()
			while not tbl10.Destroyed and #tbl13 > 0 do
				local n2 = -1
				local n3 = 1

				for i, v7 in ipairs(tbl13) do
					if v7.Priority > n2 then
						n2 = v7.Priority
						n3 = i
					end
				end

				local v7 = table.remove(tbl13, n3)
				tbl10.CurrentPriority = v7.Priority
				fn26(v7)
				local n4 = 0.45 / n
				local n5 = os.clock() + n4

				while true do
					if os.clock() < n5 and not tbl10.Destroyed then
						local flag3 = false

						for _, v8 in ipairs(tbl13) do
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

			tbl10.CurrentPriority = -1
			flag2 = false
			fn18()
		end)
	end

	local function fn28(arg, arg2, arg3)
		table.insert(tbl13, { Message = arg, Kind = arg2, Detail = arg3, Priority = (tbl7[arg2] or tbl7.Working).Priority })

		while tbl5.QueueLimit < #tbl13 do
			local huge = math.huge
			local n2 = 1

			for i, v7 in ipairs(tbl13) do
				if v7.Priority < huge then
					huge = v7.Priority
					n2 = i
				end
			end

			table.remove(tbl13, n2)
		end

		fn18()
		fn27()
	end

	local function fn29(arg, arg2, arg3)
		if tbl10.Destroyed or typeof(arg) ~= "string" or arg == "" then
			return
		end
		local v7 = fn8(arg2)
		local color = tbl7[v7].Color
		local v8 = tbl12[#tbl12]

		if v8 and v8.Message == arg and v8.Kind == v7 then
			v8.Count = v8.Count + 1
			v8.Stamp = fn6()
		else
			table.insert(tbl12, { Message = arg, Kind = v7, Colour = color, Stamp = fn6(), Count = 1 })
		end

		tbl10.Events = tbl10.Events + 1

		if v7 == "Error" or v7 == "Warning" then
			tbl10.Issues = tbl10.Issues + 1
		end

		while #tbl12 > tbl5.LogLimit do
			table.remove(tbl12, 1)
		end

		if tbl10.Tier == "Expanded" then
			fn19()
		end

		if tbl10.ReaderOpen then
			fn23()
		end

		fn28(arg, v7, arg3)
	end

	local function fn30(deltaTime)
		if tbl10.Destroyed then
			return
		end
		tbl10.Clock = tbl10.Clock + deltaTime * n

		for _, v7 in pairs(tbl11) do
			fn2(v7, deltaTime)
		end

		local value = tbl11.Width.Value
		local value2 = tbl11.Height.Value
		local n2 = math.max(tbl11.Radius.Value, 1)
		local max = math.max
		tbl9.Shell.Size = UDim2.fromOffset(math.max(value, 1), max(value2, 1))
		tbl9.ShellCorner.CornerRadius = UDim.new(0, n2)
		tbl9.WashCorner.CornerRadius = UDim.new(0, n2)
		tbl9.Scale.Scale = (tbl10.ResponsiveScale or tbl5.MaximumScale) * tbl11.Press.Value
		tbl9.TitleClip.Size = UDim2.fromOffset(math.max(value - 150, 0), 22)
		tbl9.Detail.Size = UDim2.fromOffset(math.max(value - 150, 0), 15)
		tbl9.Track.Size = UDim2.fromOffset(math.max(value - 80, 0), 2)
		local n3 = math.clamp(tbl11.TitleAlpha.Value, 0, 1)
		tbl9.TitleClip.Visible = n3 > 0.02
		tbl9.TitleClip.GroupTransparency = 1 - n3
		tbl9.Detail.TextTransparency = 1 - n3
		tbl9.Detail.Visible = tbl10.Detail ~= "" and n3 > 0.02
		tbl9.Track.BackgroundTransparency = 1 - n3 * 0.65
		local n4 = math.clamp(tbl11.CardAlpha.Value, 0, 1)
		tbl9.Card.GroupTransparency = 1 - n4
		tbl9.Card.Visible = n4 > 0.02
		local n5 = math.clamp(tbl11.Reader.Value, 0, 1)
		tbl9.ReaderRoot.Visible = n5 > 0.01
		tbl9.Reader.GroupTransparency = 1 - n5
		tbl9.ReaderDim.BackgroundTransparency = 1 - n5 * 0.55
		tbl9.Reader.Size = UDim2.fromOffset(tbl10.ReaderWidth, tbl10.ReaderHeight)
		local n6 = n5 * n5 * (3 - 2 * n5)
		local n7 = math.clamp(tbl10.ReaderOriginWidth / math.max(tbl10.ReaderWidth, 1), 0.05, 0.6)
		tbl9.ReaderScale.Scale = n7 + (1 - n7) * n6
		tbl9.Reader.Position = UDim2.fromOffset(tbl10.ReaderOriginX + (tbl10.ReaderTargetX - tbl10.ReaderOriginX) * n6, tbl10.ReaderOriginY + (tbl10.ReaderTargetY - tbl10.ReaderOriginY) * n6)
		local n8 = 0.5 + 0.5 * math.sin(tbl10.Clock * 1.6)
		local n9 = math.clamp(tbl11.Bloom.Value, 0, 1)

		for i, v7 in ipairs(tbl9.Bloom) do
			local n10 = i * 5
			v7.Position = UDim2.new(0.5, 0, 0, value2 / 2)
			v7.Size = UDim2.fromOffset(value + n10, value2 + n10)
			v7.BackgroundTransparency = math.clamp(0.965 - i * 0.004 - n9 * 0.05 - n8 * 0.006, 0, 1)
			tbl9.BloomCorners[i].CornerRadius = UDim.new(0, n2 + n10 / 2)
		end

		if tbl10.Glyph == "Spinner" then
			tbl9.GlyphSpin.Rotation = tbl10.Clock * 220 % 360
		elseif tbl10.Glyph == "Breath" or tbl10.Glyph == "Dot" then
			local n10 = 11 + n8 * 3
			tbl9.GlyphDot.Size = UDim2.fromOffset(n10, n10)
		end

		tbl9.Halo.BackgroundTransparency = 0.82 - n8 * 0.08
		local flag3 = tbl10.Live == "Equalizer" or tbl10.Live == "Stream"

		for i, bar in ipairs(tbl9.Bars) do
			local flag4 = flag3 and n3 > 0.02
			bar.BackgroundTransparency = flag4 and 0 or 1

			if flag4 then
				if tbl10.Live == "Stream" then
					bar.Size = UDim2.fromOffset(3.5, 6 + 10 * math.abs(math.sin((tbl10.Clock * 2.2 + i * 0.25) % 1 * 3.1415926535897931)))
				else
					bar.Size = UDim2.fromOffset(3.5, 7 + 9 * (0.5 + 0.5 * math.sin(tbl10.Clock * 5.5 + i * 1.1)))
				end
			end
		end

		local n10 = tbl5.BarHeight / 2
		tbl9.Slot.Position = UDim2.fromOffset(32 + (value / 2 - 32) * math.clamp((tbl5.DormantWidth - value) / (tbl5.DormantWidth - tbl5.SleepWidth), 0, 1), n10)

		if n3 < 0.98 and value > 108 then
			local n11 = 7 + n8 * 3
			tbl9.Pulse.Size = UDim2.fromOffset(n11, n11)
			tbl9.Pulse.BackgroundTransparency = math.clamp(n3 + 0.12 + n8 * 0.28, 0, 1)
		else
			tbl9.Pulse.BackgroundTransparency = 1
		end

		if tbl10.Progress then
			tbl9.Fill.Size = UDim2.fromScale(math.clamp(tbl11.Progress.Value, 0, 1), 1)
			tbl9.Fill.BackgroundTransparency = 1 - n3 * 0.9
			tbl9.Comet.BackgroundTransparency = 1
		else
			tbl9.Fill.BackgroundTransparency = 1

			if n3 > 0.02 and not flag then
				tbl9.Comet.Position = UDim2.fromScale(tbl10.Clock * 0.55 % 1.35 - 0.35, 0)
				tbl9.Comet.BackgroundTransparency = 0.1
			else
				tbl9.Comet.BackgroundTransparency = 1
			end
		end
	end

	local function fn31()
		local currentCamera = Workspace2.CurrentCamera
		if not currentCamera then
			tbl10.ResponsiveScale = tbl5.MaximumScale
			return
		end
		local compactWidth = tbl5.CompactWidth
		local minimumScale = tbl5.MinimumScale
		local maximumScale = tbl5.MaximumScale
		tbl10.ResponsiveScale = math.clamp(math.max(currentCamera.ViewportSize.X - 28, 1) / compactWidth, minimumScale, maximumScale)
		local readerMinWidth = tbl5.ReaderMinWidth
		local readerMaxWidth = tbl5.ReaderMaxWidth
		tbl10.ReaderWidth = math.clamp(math.floor(currentCamera.ViewportSize.X * tbl5.ReaderWidthRatio), readerMinWidth, readerMaxWidth)
		local readerMinHeight = tbl5.ReaderMinHeight
		local readerMaxHeight = tbl5.ReaderMaxHeight
		tbl10.ReaderHeight = math.clamp(math.floor(currentCamera.ViewportSize.Y * tbl5.ReaderHeightRatio), readerMinHeight, readerMaxHeight)
		tbl10.ReaderTargetX = currentCamera.ViewportSize.X / 2
		tbl10.ReaderTargetY = currentCamera.ViewportSize.Y / 2
		local readerNarrow = tbl10.ReaderWidth < tbl5.ReaderNarrowUnder

		if readerNarrow ~= tbl10.ReaderNarrow then
			tbl10.ReaderNarrow = readerNarrow
			tbl10.ReaderRowHeight = readerNarrow and tbl5.ReaderRowHeightNarrow or tbl5.ReaderRowHeight
			fn21()

			if tbl10.ReaderOpen then
				fn23()
			end
		end
	end

	local function fn32()
		if flag then
			return
		end
		tbl11.Press.Value = 0.955
		tbl11.Press.Velocity = 0
		tbl11.Press.Target = 1
	end

	fn7(tbl9.Tap.Activated:Connect(function()
		fn32()

		if tbl10.Tier == "Expanded" then
			tbl10.Pinned = false
			tbl9.Pin.Text = "Keep open"
			fn14()
			fn11("Dormant")
			return
		end

		fn19()
		fn11("Expanded")
		fn13()
	end))

	fn7(tbl9.Pin.Activated:Connect(function()
		fn32()
		tbl10.Pinned = not tbl10.Pinned
		tbl9.Pin.Text = tbl10.Pinned and "Pinned" or "Keep open"

		if tbl10.Pinned then
			fn14()
		else
			fn13()
		end
	end))

	fn7(tbl9.Open.Activated:Connect(function()
		fn32()
		fn24(true)
	end))

	fn7(tbl9.ReaderClose.Activated:Connect(function()
		fn24(false)
	end))

	fn7(tbl9.ReaderDim.Activated:Connect(function()
		fn24(false)
	end))

	fn7(tbl9.Clear.Activated:Connect(function()
		fn32()
		fn13()
		tbl12 = {}
		tbl10.Events = 0
		tbl10.Issues = 0
		fn19()

		if tbl10.ReaderOpen then
			fn23()
		end
	end))

	fn7(tbl18.AddLog.Event:Connect(function(arg, arg2)
		fn29(tostring(arg), arg2)
	end))

	fn7(tbl18.UpdateStatus.Event:Connect(function(arg, arg2)
		fn29(tostring(arg), arg2)
	end))

	fn7(tbl18.UpdateCurrentStep.Event:Connect(function(detail)
		if typeof(detail) == "string" and detail ~= "" then
			tbl10.Detail = detail
			tbl9.Detail.Text = detail
		end
	end))

	fn7(tbl18.UpdateRetry.Event:Connect(function(arg, arg2)
		local n2 = tonumber(arg) or 0
		tbl10.Retries = math.max(tbl10.Retries, n2)
		local str = string.format("Retry %d", n2)

		if tonumber(arg2) then
			str = string.format("Retry %d in %ds", n2, tonumber(arg2))
		end

		fn29(str, "Warning")
	end))

	fn7(tbl18.UpdateRecovery.Event:Connect(function(arg, arg2)
		local str = tostring(arg)

		if typeof(arg2) == "string" and arg2 ~= "" then
			str ..= " -> " .. arg2
		end

		fn29(str, "Warning")
	end))

	fn7(tbl18.CompleteSession.Event:Connect(function()
		if tbl10.Complete then
			return
		end
		tbl10.Complete = true
		tbl10.SessionEnd = os.clock()
		fn29("Session complete", "Success")
	end))

	fn7(tbl18.ResetSession.Event:Connect(function()
		tbl12 = {}
		tbl13 = {}
		tbl10.Events = 0
		tbl10.Issues = 0
		tbl10.Retries = 0
		tbl10.Complete = false
		tbl10.SessionStart = os.clock()
		tbl10.SessionEnd = nil
		tbl10.Pinned = false
		tbl9.Pin.Text = "Keep open"
		fn24(false)
		fn19()
		fn11("Dormant")
		fn29("New session", "Info")
	end))

	fn7(tbl18.UpdateProgress.Event:Connect(function(arg)
		if typeof(arg) ~= "number" then
			tbl10.Progress = nil
			return
		end
		local value = math.clamp(arg, 0, 1)

		if not tbl10.Progress then
			tbl11.Progress.Value = value
			tbl11.Progress.Velocity = 0
		end

		tbl10.Progress = value
		tbl11.Progress.Target = value
	end))

	fn7(tbl18.UpdateTheme.Event:Connect(function(arg)
		if typeof(arg) == "Color3" then
			accentColor = arg
			fn15(arg)
		end
	end))

	local function fn33()
		if tbl10.Destroyed then
			return
		end
		tbl10.Destroyed = true
		tbl10.HoldToken = tbl10.HoldToken + 1

		for _, v7 in ipairs(tbl14) do
			pcall(function()
				v7:Disconnect()
			end)
		end

		tbl14 = {}
	end

	fn7(tbl18.DestroyUI.Event:Connect(function()
		fn33()
		screenGui:Destroy()
	end))

	fn7(screenGui.Destroying:Connect(fn33))
	fn7(RunService2.RenderStepped:Connect(fn30))
	fn7(Workspace2:GetPropertyChangedSignal("CurrentCamera"):Connect(fn31))
	fn31()
	fn21()
	fn15(accentColor)
	fn16("Dot")
	fn19()
	fn18()
	fn11("Dormant", true)
	tbl9.TitleA.Text = "Idle"
	tbl9.TitleA.TextTransparency = 1
	local currentCamera = Workspace2.CurrentCamera

	if currentCamera then
		fn7(currentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(fn31))
	end
end

tbl4.Start = function()
	if colorIslandGui and colorIslandGui.Parent then
		return true, nil
	end
	local ok, result = pcall(tbl4.Build)
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

tbl4.Fire = function(arg, ...)
	if not colorIslandGui or not colorIslandGui.Parent then
		return false
	end
	local v = colorIslandGui:FindFirstChild(arg)
	if not v or not v:IsA("BindableEvent") then
		return false
	end
	return pcall(v.Fire, v, ...)
end

tbl4.Log = function(arg, arg2)
	return tbl4.Fire("AddLog", tostring(arg), arg2)
end

tbl4.Step = function(arg)
	return tbl4.Fire("UpdateCurrentStep", tostring(arg))
end

tbl4.Progress = function(arg)
	return tbl4.Fire("UpdateProgress", arg)
end

tbl4.Retry = function(arg, arg2)
	return tbl4.Fire("UpdateRetry", arg, arg2)
end

tbl4.Recovery = function(arg, arg2)
	return tbl4.Fire("UpdateRecovery", tostring(arg), arg2)
end

tbl4.Theme = function(arg)
	return tbl4.Fire("UpdateTheme", arg)
end

tbl4.Reset = function()
	return tbl4.Fire("ResetSession")
end

tbl4.Complete = function()
	return tbl4.Fire("CompleteSession")
end

tbl4.Destroy = function()
	return tbl4.Fire("DestroyUI")
end

local v = tbl4
local n = 50
local n2 = 0.0001
local n3 = 0.5
local v2 = nil
local tbl8 = {}
local index = {}
local index2 = {}
index.__index = index
index2.__index = index2

tbl8.IsFiniteNumber = function(arg)
	return typeof(arg) == "number" and arg == arg and arg > -math.huge and arg < math.huge
end

tbl8.IsFiniteVector3 = function(arg)
	return typeof(arg) == "Vector3" and tbl8.IsFiniteNumber(arg.X) and tbl8.IsFiniteNumber(arg.Y) and tbl8.IsFiniteNumber(arg.Z)
end

tbl8.IsFiniteCFrame = function(arg)
	if typeof(arg) ~= "CFrame" then
		return false
	end
	return tbl8.IsFiniteVector3(arg.Position) and tbl8.IsFiniteVector3(arg.RightVector) and tbl8.IsFiniteVector3(arg.UpVector) and tbl8.IsFiniteVector3(arg.LookVector)
end

tbl8.FindModelRoot = function(arg, arg2)
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

tbl8.GetLocalCharacter = function()
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
	local v3 = tbl8.FindModelRoot(character, humanoid)
	if not v3 then
		return nil, nil, nil, "Local HumanoidRootPart is unavailable"
	end
	return character, humanoid, v3, nil
end

tbl8.CreateTargetState = function(arg)
	local kind = typeof(arg)

	if kind == "CFrame" then
		if not tbl8.IsFiniteCFrame(arg) then
			return nil, "Target CFrame is invalid"
		end
		return { Kind = "CFrame", Value = arg, IsCharacterTarget = false }
	end

	if kind == "Vector3" then
		if not tbl8.IsFiniteVector3(arg) then
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
		local v3 = character and tbl8.FindModelRoot(character, humanoid)
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
			if not tbl8.FindModelRoot(arg, humanoid) then
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

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return nil, "Target model has no valid pivot"
		end
		return { Kind = "Model", Instance = arg, IsCharacterTarget = false }
	end

	return nil, "Unsupported target instance"
end

tbl8.RefreshPlayerTarget = function(arg)
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

		if not tbl8.FindModelRoot(character, humanoid) then
			return false, "Target player root part is not ready yet"
		end
		arg.Character = character
		arg.Humanoid = humanoid
	end

	return true, nil
end

tbl8.ResolveTargetFrame = function(arg)
	local kind = arg.Kind
	if kind == "CFrame" then
		return arg.Value, true, nil, nil
	end

	if kind == "Vector3" then
		return CFrame.new(arg.Value), false, nil, nil
	end

	if kind == "Player" then
		local v3, v4 = tbl8.RefreshPlayerTarget(arg)
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
		local v5 = tbl8.FindModelRoot(character, humanoid)
		if not v5 then
			return nil, false, "Lost", "Target player root part is unavailable"
		end
		local cFrame = v5.CFrame
		if not tbl8.IsFiniteCFrame(cFrame) then
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
		local v3 = tbl8.FindModelRoot(character, humanoid)
		if not v3 then
			return nil, false, "Lost", "Target mob root part is unavailable"
		end
		local cFrame = v3.CFrame
		if not tbl8.IsFiniteCFrame(cFrame) then
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
		if not tbl8.IsFiniteCFrame(worldCFrame) then
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
		if not tbl8.IsFiniteCFrame(cFrame) then
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

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return nil, false, "Lost", "Target model pivot is invalid"
		end
		return result, true, nil, nil
	end

	return nil, false, "Lost", "Target state is unsupported"
end

tbl8.ResolveOffset = function(arg, arg2)
	if arg == nil then
		if arg2 then
			return CFrame.new(0, 15, 0), nil
		end
		return CFrame.identity, nil
	end

	if typeof(arg) == "Vector3" then
		if not tbl8.IsFiniteVector3(arg) then
			return nil, "Offset Vector3 is invalid"
		end
		return CFrame.new(arg), nil
	end

	if tbl8.IsFiniteCFrame(arg) then
		return arg, nil
	end
	return nil, "Offset must be a finite CFrame or Vector3"
end

tbl8.GetHorizontalDirection = function(arg, arg2)
	if tbl8.IsFiniteVector3(arg) then
		local vector = Vector3.new(arg.X, 0, arg.Z)
		local magnitude = vector.Magnitude
		if tbl8.IsFiniteNumber(magnitude) and magnitude > n2 then
			return vector / magnitude
		end
	end

	if tbl8.IsFiniteVector3(arg2) then
		local vector = Vector3.new(arg2.X, 0, arg2.Z)
		local magnitude = vector.Magnitude
		if tbl8.IsFiniteNumber(magnitude) and magnitude > n2 then
			return vector / magnitude
		end
	end

	return Vector3.new(0, 0, -1)
end

tbl8.BuildDestination = function(arg, arg2, arg3)
	if not tbl8.IsFiniteCFrame(arg2) then
		return nil, "Target CFrame is invalid"
	end
	local targetDirection = arg.TargetDirection

	if arg3 then
		targetDirection = tbl8.GetHorizontalDirection(arg2.LookVector, arg.TargetDirection)
		arg.TargetDirection = targetDirection
	end

	local offsetCFrame = arg.OffsetCFrame
	local n4 = CFrame.lookAlong(arg2.Position, targetDirection, Vector3.new(0, 1, 0)) * offsetCFrame
	local cframe = CFrame.lookAlong(n4.Position, tbl8.GetHorizontalDirection(n4.LookVector, targetDirection), Vector3.new(0, 1, 0))
	if not tbl8.IsFiniteCFrame(cframe) then
		return nil, "Calculated destination is invalid"
	end
	return cframe, nil
end

tbl8.GetCurrentUprightCFrame = function(arg)
	local ok, result = pcall(function()
		return arg.Character:GetPivot()
	end)

	if not ok or not tbl8.IsFiniteCFrame(result) then
		return nil, "Local character pivot is invalid"
	end
	local v3 = tbl8.GetHorizontalDirection(result.LookVector, arg.CharacterDirection)
	arg.CharacterDirection = v3
	return CFrame.lookAlong(result.Position, v3, Vector3.new(0, 1, 0)), nil
end

tbl8.ValidateLocalJob = function(arg)
	if localPlayer.Character ~= arg.Character then
		return false, "Local character has respawned"
	end

	if not arg.Character.Parent then
		return false, "Local character has been removed"
	end

	if not arg.Humanoid.Parent or not arg.Humanoid:IsDescendantOf(arg.Character) or arg.Humanoid.Health <= 0 then
		return false, "Local humanoid is unavailable or dead"
	end
	local v3 = tbl8.FindModelRoot(arg.Character, arg.Humanoid)
	if not v3 then
		return false, "Local root part is unavailable"
	end
	arg.RootPart = v3
	return true, nil
end

tbl8.StopVelocity = function(arg)
	if not arg or not arg.Parent then
		return false
	end

	return (pcall(function()
		arg.AssemblyLinearVelocity = Vector3.zero
		arg.AssemblyAngularVelocity = Vector3.zero
	end))
end

tbl8.ClearArray = function(arg)
	if type(arg) ~= "table" then
		return
	end

	for i = #arg, 1, -1 do
		arg[i] = nil
	end
end

tbl8.RebuildNoclipCache = function(arg)
	local ok, result = pcall(function()
		return arg.Character:GetDescendants()
	end)

	if not ok then
		return
	end
	local noclipParts = arg.NoclipParts
	tbl8.ClearArray(noclipParts)

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

tbl8.ApplyNoclip = function(arg, arg2)
	if tbl8.IsFiniteNumber(arg2) and arg2 > 0 then
		arg.NoclipClock = arg.NoclipClock + arg2
	end

	if arg.NoclipDirty or arg.NoclipClock >= n3 then
		arg.NoclipDirty = false
		arg.NoclipClock = 0
		tbl8.RebuildNoclipCache(arg)
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

tbl8.EnforceUprightState = function(arg)
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

tbl8.ApplyCharacterCFrame = function(arg, arg2)
	if not tbl8.IsFiniteCFrame(arg2) then
		return false, "Refused to apply an invalid character CFrame"
	end

	local ok, result = pcall(function()
		arg.Character:PivotTo(arg2)
	end)

	if not ok then
		return false, "Failed to move the local character: " .. tostring(result)
	end
	tbl8.StopVelocity(arg.RootPart)
	return true, nil
end

tbl8.PrepareCharacter = function(arg)
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
	tbl8.ApplyNoclip(arg, 0)
	tbl8.EnforceUprightState(arg)
	tbl8.StopVelocity(arg.RootPart)
end

tbl8.TryReacquireLocalCharacter = function(arg)
	local character = localPlayer.Character
	if not character or not character.Parent then
		return false
	end
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or not humanoid:IsDescendantOf(character) or humanoid.Health <= 0 then
		return false
	end
	local v3 = tbl8.FindModelRoot(character, humanoid)
	if not v3 then
		return false
	end

	if character == arg.Character then
		arg.Humanoid = humanoid
		arg.RootPart = v3
		arg.NoclipDirty = true
		tbl8.ApplyNoclip(arg, 0)
		tbl8.EnforceUprightState(arg)
		return true
	end

	tbl8.ReleaseCharacterBindings(arg)
	arg.Character = character
	arg.Humanoid = humanoid
	arg.RootPart = v3
	arg.CollisionStates = {}
	arg.NoclipClock = 0
	arg.NoclipDirty = true
	arg.OriginalAutoRotate = nil
	arg.AutoRotateChanged = false
	tbl8.PrepareCharacter(arg)

	local ok, result = pcall(function()
		return character:GetPivot()
	end)

	if ok and tbl8.IsFiniteCFrame(result) then
		arg.CharacterDirection = tbl8.GetHorizontalDirection(result.LookVector, arg.CharacterDirection)
	end

	return true
end

tbl8.ReleaseCharacterBindings = function(arg)
	if arg.DescendantConnection then
		pcall(function()
			arg.DescendantConnection:Disconnect()
		end)

		arg.DescendantConnection = nil
	end

	tbl8.ClearArray(arg.NoclipParts)
end

tbl8.Cleanup = function(arg, state, arg2)
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

	if genv.PullLeverConfigActiveTween == arg then
		genv.PullLeverConfigActiveTween = nil
	end

	tbl8.ReleaseCharacterBindings(arg)

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

	tbl8.StopVelocity(arg.RootPart)
	return true
end

tbl8.EnterHolding = function(arg, holdKind, reason, holdCFrame)
	if arg.Cleaned then
		return false, "Tween has already been cleaned"
	end

	if not tbl8.IsFiniteCFrame(holdCFrame) then
		return false, "Hold CFrame is invalid"
	end
	arg.State = "Holding"
	arg.HoldKind = holdKind or "Lost"
	arg.Reason = reason or "Target became unavailable"
	arg.HoldCFrame = holdCFrame
	return tbl8.ApplyCharacterCFrame(arg, holdCFrame)
end

tbl8.TryResumeFromHolding = function(arg)
	local targetState = arg.TargetState
	if targetState.Kind ~= "Player" then
		return false
	end

	if not tbl8.RefreshPlayerTarget(targetState) then
		return false
	end
	local character = targetState.Character
	local humanoid = targetState.Humanoid
	if not humanoid.Parent or not humanoid:IsDescendantOf(character) or humanoid.Health <= 0 then
		return false
	end

	if not tbl8.FindModelRoot(character, humanoid) then
		return false
	end
	arg.State = "Moving"
	arg.HoldKind = nil
	arg.HoldCFrame = nil
	arg.Reason = nil
	return true
end

tbl8.Fail = function(arg, arg2)
	tbl8.Cleanup(arg, "Failed", arg2 or "Tween failed")
	return false
end

tbl8.StopJob = function(arg, arg2)
	if not arg or arg.Cleaned then
		arg = arg and arg.Reason or "Tween is not running"
		return false, arg
	end
	tbl8.Cleanup(arg, "Stopped", arg2 or "Stopped")
	return true, arg.Reason
end

tbl8.StopActiveJob = function(arg)
	local v3 = v2
	local flag = v2

	if v3 then
		flag = not v3.Cleaned
	end

	if flag then
		tbl8.StopJob(v3, arg or "Replaced by a new Tween")
	end

	local pullLeverConfigActiveTween = genv.PullLeverConfigActiveTween

	if pullLeverConfigActiveTween ~= v3 and type(pullLeverConfigActiveTween) == "table" then
		local stop = pullLeverConfigActiveTween.Stop

		if type(stop) == "function" then
			pcall(stop, pullLeverConfigActiveTween)
		end
	end
end

tbl8.Step = function(arg, arg2)
	local v3, v4 = tbl8.ValidateLocalJob(arg)

	if not v3 and not tbl8.TryReacquireLocalCharacter(arg) then
		arg.State = "Respawning"
		arg.Reason = v4
		arg.HoldKind = nil
		arg.HoldCFrame = nil
		return
	end

	if not tbl8.IsFiniteNumber(arg2) or arg2 < 0 then
		tbl8.Fail(arg, "Heartbeat delta time is invalid")
		return
	end
	local v5, v6 = tbl8.GetCurrentUprightCFrame(arg)
	if not v5 then
		tbl8.Fail(arg, v6)
		return
	end
	tbl8.ApplyNoclip(arg, arg2)
	tbl8.EnforceUprightState(arg)

	if arg.State == "Holding" and not tbl8.TryResumeFromHolding(arg) then
		local v7, v8 = tbl8.ApplyCharacterCFrame(arg, arg.HoldCFrame)

		if not v7 then
			tbl8.Fail(arg, v8)
		end

		return
	end

	local v7, v8, v9, v10 = tbl8.ResolveTargetFrame(arg.TargetState)

	if v9 or not v7 then
		local v11, v12 = tbl8.EnterHolding(arg, v9 or "Lost", v10 or "Target CFrame is unavailable", v5)

		if not v11 then
			tbl8.Fail(arg, v12)
		end

		return
	end

	local v11, v12 = tbl8.BuildDestination(arg, v7, v8)
	if not v11 then
		tbl8.Fail(arg, v12)
		return
	end
	local magnitude = (v11.Position - v5.Position).Magnitude
	if not tbl8.IsFiniteNumber(magnitude) then
		tbl8.Fail(arg, "Calculated Tween distance is invalid")
		return
	end
	local cframe

	if magnitude <= n then
		arg.State = arg.TargetState.IsCharacterTarget and "Tracking" or "Arrived"
		cframe = v11
	else
		local n4 = math.clamp(math.min(arg.Speed * arg2, magnitude) / magnitude, 0, 1)
		local v13 = v5:Lerp(v11, n4)
		cframe = CFrame.lookAlong(v13.Position, tbl8.GetHorizontalDirection(v13.LookVector, arg.CharacterDirection), Vector3.new(0, 1, 0))
		arg.State = "Moving"
	end

	if not tbl8.IsFiniteCFrame(cframe) then
		tbl8.Fail(arg, "Calculated character CFrame is invalid")
		return
	end
	local v13, v14 = tbl8.ApplyCharacterCFrame(arg, cframe)
	if not v13 then
		tbl8.Fail(arg, v14)
		return
	end
	arg.CharacterDirection = tbl8.GetHorizontalDirection(cframe.LookVector, arg.CharacterDirection)
	arg.LastDestination = v11
	arg.Reason = nil
end

tbl8.Follow = function(arg)
	while true do
		if v2 == arg and not arg.Cleaned then
			local result = RunService.Heartbeat:Wait()
			if not (v2 ~= arg or arg.Cleaned) then
				tbl8.Step(arg, result)
				continue
			end
		end

		break
	end
end

tbl8.FollowProtected = function(arg)
	local ok, result = pcall(tbl8.Follow, arg)

	if not ok and not arg.Cleaned then
		tbl8.Fail(arg, "Tween worker error: " .. tostring(result))
	end
end

tbl8.CreateJob = function(arg, arg2, arg3, arg4)
	local v3, v4, v5, v6 = tbl8.GetLocalCharacter()
	if not v3 then
		return nil, v6
	end

	if arg2 == nil then
		arg2 = 180
	end

	if not tbl8.IsFiniteNumber(arg2) or arg2 <= 0 then
		return nil, "Speed must be a finite number greater than zero"
	end
	local n4 = math.min(arg2, 180)
	local v7, v8 = tbl8.CreateTargetState(arg)
	if not v7 then
		return nil, v8
	end
	local v9, v10 = tbl8.ResolveOffset(arg3, v7.IsCharacterTarget)
	if not v9 then
		return nil, v10
	end

	local ok, result = pcall(function()
		return v3:GetPivot()
	end)

	if not ok or not tbl8.IsFiniteCFrame(result) then
		return nil, "Local character pivot is invalid"
	end
	local v11 = tbl8.GetHorizontalDirection(result.LookVector, Vector3.new(0, 0, -1))
	local cframe = CFrame.lookAlong(result.Position, v11, Vector3.new(0, 1, 0))
	local v12, v13, v14, str = tbl8.ResolveTargetFrame(v7)
	if not v12 and not v14 then
		str = str or "Target CFrame is unavailable"
		return nil, str
	end

	local pullLeverConfigActiveTween = setmetatable({
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
		v15, v16 = tbl8.BuildDestination(pullLeverConfigActiveTween, v12, v13)
		if not v15 then
			return nil, v16
		end
		magnitude = (v15.Position - cframe.Position).Magnitude
		if not tbl8.IsFiniteNumber(magnitude) then
			return nil, "Initial Tween distance is invalid"
		end
	end

	tbl8.StopActiveJob("Replaced by a new Tween")
	v2 = pullLeverConfigActiveTween
	genv.PullLeverConfigActiveTween = pullLeverConfigActiveTween
	tbl8.PrepareCharacter(pullLeverConfigActiveTween)
	local v16, v17

	if v14 or not v15 then
		v16, v17 = tbl8.EnterHolding(pullLeverConfigActiveTween, v14 or "Lost", str or "Target CFrame is unavailable", cframe)
	elseif magnitude <= n then
		pullLeverConfigActiveTween.State = v7.IsCharacterTarget and "Tracking" or "Arrived"
		v16, v17 = tbl8.ApplyCharacterCFrame(pullLeverConfigActiveTween, v15)
		pullLeverConfigActiveTween.CharacterDirection = tbl8.GetHorizontalDirection(v15.LookVector, v11)
	else
		pullLeverConfigActiveTween.State = "Moving"
		v16, v17 = tbl8.ApplyCharacterCFrame(pullLeverConfigActiveTween, cframe)
	end

	if not v16 then
		tbl8.Fail(pullLeverConfigActiveTween, v17)
		return nil, v17
	end
	pullLeverConfigActiveTween.LastDestination = v15
	task.spawn(tbl8.FollowProtected, pullLeverConfigActiveTween)
	return pullLeverConfigActiveTween, nil
end

index.Stop = function(arg)
	if type(arg) ~= "table" or getmetatable(arg) ~= index then
		return false, "Stop must be called with a Tween controller"
	end
	local ok, result, result2 = pcall(tbl8.StopJob, arg, "Stopped")
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

tbl8.CreateNullController = function(arg)
	return setmetatable({ State = "Failed", Reason = arg or "Tween never started", Running = false, Cleaned = true }, index2)
end

Tween = function(arg, arg2, arg3, arg4)
	local v3 = v2
	local ok, result, result2 = pcall(tbl8.CreateJob, arg, arg2, arg3, arg4)

	if not ok then
		if v2 and v2 ~= v3 then
			pcall(tbl8.Fail, v2, "Unexpected Tween creation error")
		end

		local str = "Tween error: " .. tostring(result)
		return tbl8.CreateNullController(str), str
	end

	if not result then
		result2 = result2 or "Tween could not start"
		return tbl8.CreateNullController(result2), result2
	end
	return result, nil
end

tbl8.StopActiveJob("Tween controller reloaded")
local tbl9

tbl9 = {
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
			tbl9.Disconnect(v3)
		end

		tbl8.ClearArray(arg)
	end,
	StopRuntime = function(arg)
		if type(arg) ~= "table" then
			return false
		end
		arg.Active = false
		tbl9.Disconnect(arg.Connection)
		arg.Connection = nil
		tbl9.DisconnectAll(arg.WatcherConnections)
		return true
	end,
	ClaimSharedRuntime = function(arg, arg2)
		local v3 = genv[arg]
		local flag = type(v3) == "table" and v3 ~= arg2
		local flag2 = false

		if flag then
			flag2 = tbl9.StopRuntime(v3)
		end

		genv[arg] = arg2
		return flag2
	end,
}

local tbl10

tbl10 = {
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
		local v3, v4 = tbl10.GetRemote()
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
		local v3, v4 = tbl10.GetRemote()
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

local tbl11 = {
	TravelToSecondSea = function()
		if tbl2[game.PlaceId] then
			return true, "The player is already in the Second Sea"
		end
		local TravelDressrosa, v3 = tbl10.Invoke("TravelDressrosa")
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

			local TravelZou, v4 = tbl10.Invoke("TravelZou")

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
local tbl12

tbl12 = {
	APIServerRetryDelay = 2,
	APITeleportResultTimeout = 15,
	APITeleportPollDelay = 0.1,
	APIServerMaxPlayers = 11,
	GroupJoinRetryDelay = 1.5,
	GroupJoinResultTimeout = 15,
	GroupJoinPollDelay = 0.1,
	APIModuleUrl = "https://raw.githubusercontent.com/WhiteX1208/Scripts/refs/heads/main/IaChay.luau",
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
	GetServerBrowser = function()
		local serverBrowser = ReplicatedStorage:FindFirstChild("__ServerBrowser")
		if not serverBrowser or not serverBrowser:IsA("RemoteFunction") then
			return nil, "__ServerBrowser RemoteFunction is unavailable"
		end
		return serverBrowser, nil
	end,
	RequestPublicServers = function(arg, arg2, arg3)
		if not tbl12.IsHttpGetAvailable() then
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
				local v4, v5 = tbl12.GetServerFullPrompt()

				if v4 then
					flooded = Enum.TeleportResult.Flooded
					v3 = v5
					break
				else
					task.wait(tbl12.APITeleportPollDelay)
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
		local v3, v4 = tbl12.GetServerBrowser()
		if not v3 then
			return false, v4
		end
		local tbl13 = {}
		local str = ""
		local str2 = nil

		for i = 1, 10 do
			local v5, v6
			v5, str, v6 = tbl12.RequestPublicServers(str, "Desc", true)
			if not v5 then
				return false, v6
			end

			for _, v7 in ipairs(v5) do
				if type(v7) == "table" and type(v7.id) == "string" and type(v7.playing) == "number" and type(v7.maxPlayers) == "number" and v7.id ~= game.JobId and v7.playing >= 8 and v7.playing < v7.maxPlayers and not tbl13[v7.id] then
					tbl13[v7.id] = true
					local v8, v9 = tbl12.TryBrowserTeleport(v3, v7.id)
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
		local v3, v4 = tbl12.GetServerBrowser()
		if not v3 then
			return false, v4
		end
		local v5, v6 = tbl12.TryBrowserTeleport(v3, jobId)
		return false, "Failed to rejoin server " .. jobId .. ": " .. tostring(v6)
	end,
	GetAPIModule = function()
		if type(tbl12.APIModule) == "table" and type(tbl12.APIModule.HopApi) == "function" then
			return tbl12.APIModule, nil
		end

		if not tbl12.IsHttpGetAvailable() then
			return nil, "game:HttpGet is unavailable"
		end

		if type(loadstring) ~= "function" then
			return nil, "loadstring is unavailable"
		end

		local ok, apiModule = pcall(function()
			local response = game:HttpGet(tbl12.APIModuleUrl)
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
		tbl12.APIModule = apiModule
		return apiModule, nil
	end,
	APIServer = function(arg, arg2)
		if type(arg) ~= "string" or arg == "" then
			return false, "NameBoss must be a non-empty string"
		end

		if arg2 == nil then
			arg2 = tbl12.APIServerMaxPlayers
		end

		if not tbl8.IsFiniteNumber(arg2) or arg2 < 1 then
			return false, "MaxPlayers must be a finite number greater than zero"
		end
		local n6 = math.floor(arg2)
		local v3, v4 = tbl12.GetAPIModule()
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

		local ok, result, result2 = pcall(v3.HopApi, tbl12.APIServerNameMap[arg] or arg, n6)
		if not ok then
			connection:Disconnect()
			return false, "HopApi failed: " .. tostring(result)
		end

		if result == true then
			local now = os.clock()

			while true do
				local flag = game.JobId == jobId and v5 == nil

				if flag then
					local apiTeleportResultTimeout = tbl12.APITeleportResultTimeout
					flag = os.clock() - now < apiTeleportResultTimeout
				end

				if flag then
					task.wait(tbl12.APITeleportPollDelay)
					continue
				end
				break
			end

			connection:Disconnect()
			if game.JobId ~= jobId then
				return true, result2 or "HopApi completed the teleport"
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
		while true do
			if type(arg2) == "function" then
				local ok, result = pcall(arg2)
				if ok and result ~= true then
					break
				end
			end

			local v3, v4 = tbl12.APIServer(arg, arg3)
			if v3 then
				return true, v4
			end
			task.wait(tbl12.APIServerRetryDelay)
		end

		return false, nil
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
		local v3, v4 = tbl12.GetServerBrowser()
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

		local function fn7()
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
					fn7()
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
					local groupJoinResultTimeout = tbl12.GroupJoinResultTimeout
					flag = os.clock() - now < groupJoinResultTimeout
				end

				if flag then
					local v6
					v6, v5 = tbl12.GetServerFullPrompt()

					if v6 then
						exitTo = 2
						break
					elseif type(arg2) ~= "function" then
						task.wait(tbl12.GroupJoinPollDelay)
						continue
					else
						local ok2, result2 = pcall(arg2, arg)
						if not (not ok2 or result2 ~= true) then
							task.wait(tbl12.GroupJoinPollDelay)
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
					fn7()
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

				fn7()
				if flag then
					return false, "Group server " .. arg .. " is full helper 1 is finding another Full Moon"
				end
				return false, "Group server " .. arg .. " is full" .. (result2 and ": " .. tostring(result2) or "")
			end

			if flooded == Enum.TeleportResult.GameNotFound or flooded == Enum.TeleportResult.GameEnded or flooded == Enum.TeleportResult.Unauthorized then
				fn7()
				local v6 = str or flooded
				return false, "Cannot join group server " .. arg .. ": " .. v6(v6)
			end

			if game.JobId == jobId then
				task.wait(tbl12.GroupJoinRetryDelay)
			end
		end

		fn7()
		return true, "Joined group server " .. arg
	end,
}

local str = "Pirates"
local tbl13

tbl13 = {
	JoinSettleDelay = 5,
	IsOnTeam = function(arg)
		local team = localPlayer.Team
		return team ~= nil and team.Name == arg
	end,
	HopAfterTimeout = function(arg)
		local v3, v4 = tbl12.HopNormalServer()
		if not v3 then
			return false, arg .. " (server hop failed: " .. tostring(v4) .. ")"
		end
		return false, arg .. " (" .. tostring(v4) .. ")"
	end,
	Join = function(arg, arg2)
		if arg == nil then
			arg = "Marines"
		end

		if tbl13.IsOnTeam(arg) then
			return true, nil
		end

		if arg2 == nil then
			arg2 = 10
		end

		if not tbl8.IsFiniteNumber(arg2) or arg2 <= 0 then
			return false, "Timeout must be a finite number greater than zero"
		end
		local v3, v4 = tbl10.GetRemote()
		if not v3 then
			return false, v4
		end
		local n6 = os.clock() + arg2
		local v5 = nil

		while true do
			local SetTeam, v6 = tbl10.Invoke("SetTeam", arg)
			v5 = v6 or v5
			if tbl13.IsOnTeam(arg) then
				task.wait(tbl13.JoinSettleDelay)
				return true, nil
			end
			task.wait(0.5)
			if not (n6 <= os.clock()) then
				continue
			end
			break
		end

		if tbl13.IsOnTeam(arg) then
			task.wait(tbl13.JoinSettleDelay)
			return true, nil
		end

		if v5 then
			return tbl13.HopAfterTimeout("Failed to join the " .. arg .. " team: " .. v5)
		end
		return tbl13.HopAfterTimeout("Timed out while joining the " .. arg .. " team")
	end,
}

local n6 = 3
local tbl14

tbl14 = {
	IsEnabled = function(arg)
		return arg ~= nil and (arg:FindFirstChild("HasBuso") ~= nil or arg:FindFirstChild("Buso") ~= nil)
	end,
	Enable = function()
		local character = localPlayer.Character
		if not character then
			return false, "Local character is unavailable"
		end

		if tbl14.IsEnabled(character) then
			return true, nil
		end
		local Buso, v3 = tbl10.Invoke("Buso")
		if v3 then
			return false, v3
		end
		local now = os.clock()

		while os.clock() - now < n6 do
			if tbl14.IsEnabled(localPlayer.Character) then
				return true, nil
			end
			task.wait(0.1)
		end

		return false, "The Buso remote completed, but the character received no Buso marker"
	end,
}

local tbl15

tbl15 = {
	SetAim = function(pullLeverConfigAimPosition)
		genv.PullLeverConfigAimPosition = pullLeverConfigAimPosition
	end,
	HookAim = function()
		if genv.PullLeverConfigAimHooked then
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
				local pullLeverConfigAimPosition = genv.PullLeverConfigAimPosition

				if pullLeverConfigAimPosition and getnamecallmethod() == "FireServer" and typeof(v5[1]) == "Instance" and v5[1].Name == "RemoteEvent" and type(v5[2]) ~= "boolean" then
					if typeof(v5[2]) == "CFrame" then
						v5[2] = CFrame.new(pullLeverConfigAimPosition)
					else
						v5[2] = pullLeverConfigAimPosition
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
		genv.PullLeverConfigAimHooked = true
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
			local v4, v5 = tbl15.PressKey(v3)
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
local tbl16 = { "Util", "Common", "Remotes", "Assets", "FX" }
local v3 = nil
local v4 = nil
local v5 = nil
local n9 = 0
local tbl17 = { Active = false, Connection = nil, WatcherConnections = {} }
local tbl18

tbl18 = {
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
		local v6, v7, v8, v9 = tbl8.GetLocalCharacter()
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
		local tbl19 = {}

		for _, child in ipairs(enemies:GetChildren()) do
			if not arg2 or child.Name == arg2 then
				local humanoid = child:FindFirstChildWhichIsA("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") and (humanoidRootPart.Position - position).Magnitude <= n7 then
					tbl19[#tbl19 + 1] = { Mob = child, HitPart = tbl18.ResolveHitPart(child, humanoidRootPart), Health = humanoid.Health }
				end
			end
		end

		table.sort(tbl19, function(arg3, arg4)
			return arg3.Health < arg4.Health
		end)

		local tbl20 = {}
		local hitPart = nil

		for _, v6 in ipairs(tbl19) do
			hitPart = hitPart or v6.HitPart
			tbl20[#tbl20 + 1] = { v6.Mob, v6.HitPart }
		end

		if not hitPart then
			if arg2 then
				return nil, tbl20, "No living target named " .. tostring(arg2) .. " is within attack range"
			end
			return nil, tbl20, "No living target is within attack range"
		end

		return hitPart, tbl20, nil
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

			v6:FireServer(tbl18.ScrambleName("RE/RegisterHit"), bit32.bxor(v4 + 909090, v5 * 2), arg, arg2)
		end)

		if not ok then
			return false, "Failed to fire scrambled hit remote: " .. tostring(result)
		end
		return true, nil
	end,
	FireAttackRemotes = function(arg, arg2)
		local v6 = tbl18.GetNet()
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
		return tbl18.FireScrambledHit(arg, arg2)
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
		tbl9.DisconnectAll(tbl17.WatcherConnections)
		local watcherConnections = tbl17.WatcherConnections

		for _, v6 in ipairs(tbl16) do
			local v7 = ReplicatedStorage:FindFirstChild(v6)

			if v7 then
				for _, child in ipairs(v7:GetChildren()) do
					tbl18.TrackRemote(child)
				end

				local ok, result = pcall(function()
					return v7.ChildAdded:Connect(tbl18.TrackRemote)
				end)

				if ok then
					watcherConnections[#watcherConnections + 1] = result
				end
			end
		end

		return true, nil
	end,
	RefreshSeed = function()
		local v6 = tbl18.GetNet()
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
		if tbl18.IsOnCooldown() then
			return false, "Attack is on cooldown"
		end
		local v6, v7, v8 = tbl18.GetLocalAttacker()
		if not v7 then
			return false, v8
		end
		local v9, v10, v11 = tbl18.CollectMobTargets(v7, arg)
		if not v9 then
			return false, v11
		end
		n9 = os.clock()
		return tbl18.FireAttackRemotes(v9, v10)
	end,
	AttackPlayer = function(arg)
		if tbl18.IsOnCooldown() then
			return false, "Attack is on cooldown"
		end

		if typeof(arg) ~= "Instance" or not arg:IsA("Player") or arg == localPlayer then
			return false, "Target player is invalid"
		end
		local v6, v7, v8 = tbl18.GetLocalAttacker()
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
		local v9 = tbl18.ResolveHitPart(character, humanoidRootPart)
		n9 = os.clock()
		return tbl18.FireAttackRemotes(v9, { { character, v9 } })
	end,
	Start = function(arg)
		if arg ~= nil and type(arg) ~= "string" then
			return false, "MobName must be a string or nil"
		end
		tbl18.Stop()

		local ok, connection = pcall(function()
			return RunService.Heartbeat:Connect(function()
				if not tbl17.Active then
					return
				end
				tbl18.Attack(arg)
			end)
		end)

		if not ok then
			return false, "Failed to start the attack loop: " .. tostring(connection)
		end
		tbl17.Active = true
		tbl17.Connection = connection
		return true, nil
	end,
	Stop = function()
		tbl17.Active = false
		tbl9.Disconnect(tbl17.Connection)
		tbl17.Connection = nil
		return true, nil
	end,
	IsRunning = function()
		return tbl17.Active and tbl17.Connection ~= nil
	end,
}

tbl9.ClaimSharedRuntime("PullLeverConfigAttackRuntime", tbl17)
local flag = type(isnetworkowner) == "function" and isnetworkowner or nil
local tbl19

tbl19 = {
	ResolveAnchor = function(arg, arg2)
		local v6, v7 = tbl8.CreateTargetState(arg)
		if not v6 then
			return nil, v7
		end
		local n10, v8, v9, v10 = tbl8.ResolveTargetFrame(v6)
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

		if not tbl8.IsFiniteNumber(arg3) or arg3 <= 0 then
			return 0, "Range must be a finite number greater than zero"
		end

		if not flag then
			return 0, "isnetworkowner is unavailable"
		end
		local v6, v7, v8, v9 = tbl8.GetLocalCharacter()
		if not v6 or not v8 then
			return 0, v9
		end

		local ok, result = pcall(function()
			return v6:GetPivot()
		end)

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return 0, "Local character pivot is invalid"
		end
		local v10, v11 = tbl19.ResolveAnchor(arg, result)
		if not v10 then
			return 0, v11
		end
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return 0, "Enemies folder is unavailable"
		end
		local v12 = tbl19.ResolveTargetModel(arg)
		local position = v8.Position
		local n10 = 0
		local str2 = nil

		for _, child in ipairs(enemies:GetChildren()) do
			if child ~= v12 and (not arg2 or child.Name == arg2) then
				local humanoid = child:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") and (humanoidRootPart.Position - position).Magnitude <= arg3 then
					local v13, v14 = tbl19.HasNetworkOwnership(humanoidRootPart)

					if v13 then
						local v15, v16 = tbl19.PullMob(humanoidRootPart, v10)

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
local tbl20

tbl20 = {
	GetAliveRoot = function()
		local v6, v7, v8, v9 = tbl8.GetLocalCharacter()
		if not v6 or not v8 then
			return nil, nil, v9
		end
		return v6, v8, nil
	end,
	WaitForAliveRoot = function()
		local v6, v7

		while true do
			v6, v7 = tbl20.GetAliveRoot()

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
		if tbl20.GetAliveRoot() then
			return false
		end
		tbl20.WaitForAliveRoot()
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
		if tbl20.IsMeleeTool(tool) then
			return tool, nil
		end
		local backpack = localPlayer:FindFirstChild("Backpack")

		if backpack then
			for _, child in ipairs(backpack:GetChildren()) do
				if tbl20.IsMeleeTool(child) then
					return tbl20.TryEquipTool(character, humanoid, child, "Melee", tbl20.IsMeleeTool)
				end
			end
		end

		return nil, "No Melee tool was found in the Backpack or Character"
	end,
	EquipItem = function(arg)
		if type(arg) ~= "string" or arg == "" then
			return nil, "Item name must be a non-empty string"
		end
		local v6 = tbl20.WaitForAliveRoot()
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

		return tbl20.TryEquipTool(v6, humanoid, backpack, arg, function(arg2)
			return typeof(arg2) == "Instance" and arg2:IsA("Tool") and arg2.Name == arg
		end)
	end,
}

local n10 = 100
local n11 = 1500
local n12 = 10000
local n13 = 5
local flag3 = false

local tbl21 = {
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

local tbl22 = {
	["Flower 1"] = true,
	["Flower 2"] = true,
	["Flower 3"] = true,
	["Fist of Darkness"] = true,
	["Core Brain"] = true,
	Microchip = true,
	["Hellfire Torch"] = true,
}

local tbl23

tbl23 = {
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

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return nil, "Local character pivot is invalid"
		end
		return tbl19.ResolveAnchor(arg, result)
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

		if tbl22[arg.Name] == true then
			return true
		end
		return arg2 and arg.Name ~= "Tool" and not tbl23.IsWeaponTool(arg) and arg.ToolTip == "" and arg:FindFirstChildOfClass("RemoteFunction") == nil
	end,
	HasProtectedTool = function()
		local tbl24 = { Instance = localPlayer.Character, Name = "Character", ProtectUnknown = false }

		for _, v6 in ipairs({ { Instance = localPlayer:FindFirstChild("Backpack"), Name = "Backpack", ProtectUnknown = true }, tbl24 }) do
			local instance = v6.Instance

			if instance then
				for _, child in ipairs(instance:GetChildren()) do
					if tbl23.IsProtectedTool(child, v6.ProtectUnknown) then
						return true, child.Name, v6.Name
					end
				end
			end
		end

		return false, nil, nil
	end,
	CanReset = function()
		local v6, v7, v8 = tbl23.HasProtectedTool()
		if v6 then
			return false, "Reset is disabled while carrying protected tool " .. tostring(v7) .. " (" .. tostring(v8) .. ")"
		end
		return true, nil
	end,
	RequestBestEntrance = function(arg, arg2)
		local v6 = tbl23.GetSeaIndex()
		v6 = v6 and tbl21[v6]
		if not v6 then
			return false, nil, "No entrance table exists for the current sea"
		end
		local tbl24 = {}

		for _, v7 in ipairs(v6) do
			tbl24[#tbl24 + 1] = v7
		end

		table.sort(tbl24, function(arg3, arg4)
			return tbl23.HorizontalDistance(arg3, arg2) < tbl23.HorizontalDistance(arg4, arg2)
		end)

		local v7 = tbl23.HorizontalDistance(arg.Position, arg2)

		for _, v8 in ipairs(tbl24) do
			if v7 <= tbl23.HorizontalDistance(v8, arg2) then
				break
			end

			if not arg.Parent then
				return false, nil, "Character was lost before requestEntrance"
			end
			local position = arg.Position
			if tbl23.HorizontalDistance(position, v8) <= n10 then
				return true, v8, nil
			end
			local requestEntrance, v9 = tbl10.Invoke("requestEntrance", v8)
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

			if ok and tbl8.IsFiniteCFrame(result) then
				local v8 = tbl23.HorizontalDistance(result.Position, arg)

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
		local tbl24 = {}
		if not v6 then
			return tbl24
		end

		for _, child in ipairs(v6:GetChildren()) do
			local ok, result = pcall(function()
				return child:GetPivot()
			end)

			if ok and tbl8.IsFiniteCFrame(result) then
				tbl24[#tbl24 + 1] = { Name = child.Name, Position = result.Position }
			end
		end

		return tbl24
	end,
	FindSpawnPath = function(arg, arg2, arg3)
		local v6 = tbl23.GetSpawnNodes()
		local tbl24 = {}
		local tbl25 = {}
		local tbl26 = {}
		arg3 = arg3 or {}

		for _, v7 in ipairs(v6) do
			if not arg3[v7.Name] and (v7.Position - arg).Magnitude <= n12 then
				tbl25[v7.Name] = true
				tbl26[#tbl26 + 1] = v7
			end
		end

		local n14 = 1

		while n14 <= #tbl26 do
			local v7 = tbl26[n14]
			n14 += 1

			if v7.Name == arg2 then
				local tbl27 = {}
				local name = v7.Name

				while name do
					table.insert(tbl27, 1, name)
					name = tbl24[name]
				end

				return tbl27
			end

			for _, v8 in ipairs(v6) do
				if not tbl25[v8.Name] and not arg3[v8.Name] and (v7.Position - v8.Position).Magnitude <= n12 then
					tbl25[v8.Name] = true
					tbl24[v8.Name] = v7.Name
					tbl26[#tbl26 + 1] = v8
				end
			end
		end

		return nil
	end,
	ClaimSpawn = function(arg, arg2, arg3, arg4)
		local n14 = os.clock() + n13

		while true do
			if not arg3.Parent or not arg4.Parent or arg4.Health <= 0 then
				return false, "Character died before the spawn point was accepted", true
			end
			local SetLastSpawnPoint, v6 = tbl10.Invoke("SetLastSpawnPoint", arg2)
			if v6 then
				return false, v6
			end

			if arg.Value == arg2 then
				return true, nil
			end
			task.wait()
			if not (n14 <= os.clock()) then
				continue
			end
			break
		end

		return false, arg2 .. " was not accepted as the spawn point"
	end,
	WaitForAliveCharacter = function(arg)
		local v6, v7, v8

		while true do
			v6, v7, v8 = tbl8.GetLocalCharacter()
			if not (v6 and v7 and v8 and v6 ~= arg) then
				task.wait(0.1)
				continue
			end
			break
		end

		return v6, v8, v7
	end,
	RunResetTeleport = function(arg)
		local v6, v7 = tbl23.ResolveTargetCFrame(arg)
		if not v6 then
			return false, v7
		end
		local v8, v9, v10 = tbl23.WaitForAliveCharacter(nil)
		tbl8.StopActiveJob("Preparing reset teleport")
		local v11, v12 = tbl23.CanReset()

		if not v11 then
			local v13, v14, v15 = tbl23.RequestBestEntrance(v9, v6.Position)

			if v15 then
				warn(tostring(v15))
			end

			warn(tostring(v12))
			return true, v12 .. (v14 and " used requestEntrance" or "") .. " continue with Tween"
		end

		local v13, v14, v15 = tbl23.GetNearestSpawn(v6.Position)
		if not v13 or not v14 then
			warn(tostring(v15))
			return true, tostring(v15) .. " continue with Tween"
		end
		local data = localPlayer:WaitForChild("Data", 10)
		data = data and data:WaitForChild("LastSpawnPoint", 10)
		if not data then
			return false, "Data.LastSpawnPoint did not load in time"
		end
		local tbl24 = {}
		local n14 = 0

		while n11 < tbl23.HorizontalDistance(v9.Position, v14.Position) do
			local v16 = tbl23.FindSpawnPath(v9.Position, v13.Name, tbl24)
			if not v16 then
				return true, v13.Name .. " has no reachable spawn chain continue with Tween"
			end
			local v17 = v16[1]
			local v18, v19, v20 = tbl23.ClaimSpawn(data, v17, v8, v10)

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
				tbl24[v17] = true
			end

			if v18 or v20 then
				n14 += 1
				v8, v9, v10 = tbl23.WaitForAliveCharacter(v8)
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
		local ok, result, result2 = pcall(tbl23.RunResetTeleport, arg)
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
		local v6, v7 = tbl23.ResolveTargetCFrame(arg)
		if not v6 then
			return tbl8.CreateNullController(v7), v7
		end
		local v8, v9 = tbl8.ResolveOffset(arg3)
		if not v8 then
			return tbl8.CreateNullController(v9), v9
		end
		tbl8.StopActiveJob("Preparing travel")
		local v10, v11 = tbl23.ResetTeleport(v6 * v8)
		if not v10 then
			return tbl8.CreateNullController(v11), v11
		end
		tbl20.WaitForAliveRoot()
		return Tween(arg, arg2, arg3)
	end,
	MoveToPosition = function(arg, arg2)
		if typeof(arg) ~= "Vector3" then
			return false, "Move position must be a Vector3"
		end

		if arg2 == nil then
			arg2 = 10
		end

		if not tbl8.IsFiniteNumber(arg2) or arg2 <= 0 then
			return false, "Tolerance must be a finite number greater than zero"
		end
		local v6, v7 = tbl23.Travel(arg)
		if v7 then
			return false, v7
		end

		while true do
			local v8
			v8, v8 = tbl20.WaitForAliveRoot()

			if (v8.Position - arg).Magnitude <= arg2 then
				tbl23.StopJob(v6)
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

		local v6, v7 = tbl23.Travel(arg)
		if v7 then
			return false, v7
		end

		while true do
			if not arg.Parent then
				tbl23.StopJob(v6)
				return false, "Target part was removed while moving"
			else
				local v8, v9, v10 = tbl20.GetAliveRoot()
				if not v8 or not v9 then
					tbl23.StopJob(v6)
					return false, v10
				end

				if (v9.Position - arg.Position).Magnitude <= arg2 then
					tbl23.StopJob(v6)
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

local tbl24 = {
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

local tbl25

tbl25 = {
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

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return nil
		end
		return result.Position
	end,
	FindMap = function(arg)
		local map = Workspace:FindFirstChild("Map")
		return map and map:FindFirstChild(arg)
	end,
	GetMapPosition = function(arg)
		local v6 = tbl25.FindMap(arg)
		if not v6 then
			return nil
		end

		local ok, result = pcall(function()
			return v6:GetPivot()
		end)

		if ok and tbl8.IsFiniteCFrame(result) then
			return result.Position
		end
		local basePart = v6:FindFirstChildWhichIsA("BasePart", true)
		return basePart and basePart.Position or nil
	end,
	ScanMap = function(arg)
		local tbl26 = {}
		local v6 = tbl25.FindMap(arg)
		if not v6 then
			return tbl26
		end

		for _, v7 in ipairs(CollectionService:GetTagged("_ChestTagged")) do
			if v7:IsDescendantOf(v6) and tbl25.IsCollectable(v7) then
				tbl26[#tbl26 + 1] = v7
			end
		end

		return tbl26
	end,
	FindNearest = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(arg) do
			if v8.Parent and not arg3[v8] then
				local v9 = tbl25.GetPosition(v8)

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
		if not tbl25.IsCollectable(arg) then
			return false, "Chest is no longer collectable"
		end
		local v6, v7 = tbl23.MoveToPosition(arg2, 10)
		if not v6 then
			return false, v7
		end
		local n16 = os.clock() + n14
		local n17 = 0
		local v8 = nil

		while true do
			local v9 = task.wait()
			local v10, v11 = tbl20.WaitForAliveRoot()
			tbl20.PreventSit(v10)
			n17 = math.min(n17 + v9, 0.4)
			local n18 = n17 / n15 * 3.1415926535897931 * 2
			v10:PivotTo(CFrame.new(arg2) * CFrame.Angles(n18, 0, 0))
			tbl8.StopVelocity(v11)
			local v12, v13 = tbl25.Touch(arg, v11)

			if not v12 then
				v8 = v13
			end

			if not (not tbl25.IsCollectable(arg) or os.clock() >= n16) then
				continue
			end
			break
		end

		local v9, v10 = tbl20.GetAliveRoot()

		if v9 and v10 then
			v9:PivotTo(CFrame.new(v10.Position))
		end

		if tbl25.IsCollectable(arg) then
			return false, v8 or "Chest did not open"
		end
		return true, nil
	end,
	FarmMap = function(arg, arg2, arg3, arg4)
		if not arg4 and #tbl25.ScanMap(arg) == 0 then
			return arg3
		end

		if arg4 then
			local v6 = tbl25.GetMapPosition(arg)

			if v6 then
				if not tbl23.MoveToPosition(v6, 100) then
					return arg3
				end
				task.wait(1)
			end
		end

		local tbl26 = {}

		while not arg2(arg3) do
			local v6, v7 = tbl20.WaitForAliveRoot()
			local v8, v9 = tbl25.FindNearest(tbl25.ScanMap(arg), v7, tbl26)

			if v8 then
				tbl26[v8] = true

				if tbl25.Collect(v8, v9) then
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
			tbl20.WaitForAliveRoot()
			local v6 = n16

			for _, v7 in ipairs(tbl24) do
				if not arg(v6) then
					v6 = tbl25.FarmMap(v7, arg, v6, false)
					continue
				end
				break
			end

			if v6 == n16 then
				for _, v7 in ipairs(tbl24) do
					if not arg(v6) then
						v6 = tbl25.FarmMap(v7, arg, v6, true)
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

				local v7, v8 = tbl12.HopNormalServer()
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
local tbl26

tbl26 = {
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
			if tbl26.IsAliveBoss(child, arg) then
				return true
			end
		end

		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return false
		end

		for _, child in ipairs(enemies:GetChildren()) do
			if tbl26.IsAliveBoss(child, arg) then
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
			if tbl26.IsAliveBoss(child, arg) then
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
		local bigMirror = tbl26.GetCakeLoaf()
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
		local tbl27 = {}
		if not worldOrigin then
			return tbl27
		end

		for _, child in ipairs(worldOrigin:GetChildren()) do
			if child.Name == tbl26.CakeIslandLocation and child:IsA("BasePart") then
				table.insert(tbl27, child.Position)
			end
		end

		return tbl27
	end,
	WaitForCakeMirror = function()
		local cakeMirrorStreamTimeout = tbl26.CakeMirrorStreamTimeout
		local n22 = os.clock() + cakeMirrorStreamTimeout

		while true do
			local v6 = tbl26.GetCakeMirror()

			if v6 then
				return v6
			else
				task.wait(tbl26.CakeMirrorStreamPoll)
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
		v6, v6 = tbl20.GetAliveRoot()
		if not v6 then
			return nil
		end
		local v7 = tbl26.GetCakeIslandPositions()
		local position = v6.Position

		table.sort(v7, function(arg, arg2)
			return (arg - position).Magnitude < (arg2 - position).Magnitude
		end)

		for _, v8 in ipairs(v7) do
			if tbl23.ResetTeleport(v8) then
				tbl20.WaitForAliveRoot()
				local v9 = tbl26.WaitForCakeMirror()
				if v9 then
					return v9
				end
			end
		end

		return nil
	end,
	FireCakeMirror = function(arg)
		local v6
		v6, v6 = tbl20.GetAliveRoot()
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

		local cakeMirrorTimeout = tbl26.CakeMirrorTimeout
		local n22 = os.clock() + cakeMirrorTimeout

		repeat
			local v7, v8 = tbl20.GetAliveRoot()

			if not v7 or not v8 then
				tbl20.WaitForAliveRoot()
				task.wait(tbl26.CakeMirrorSettleDelay)
				return false
			end

			if tbl26.CakeMirrorTeleportDistance <= (v8.Position - position).Magnitude then
				task.wait(tbl26.CakeMirrorSettleDelay)
				return true
			end
			task.wait(0.25)
		until os.clock() >= n22

		return false
	end,
	UseCakeMirror = function(arg)
		if not tbl26.CakeMirrorBosses[arg] or not flag2 then
			return false
		end
		local v6 = tbl26.GetCakeMirror() or tbl26.ReachCakeMirror()
		if not v6 then
			return false
		end
		local v7, v8 = tbl20.GetAliveRoot()
		if not v7 or not v8 then
			return false
		end

		if tbl26.CakeMirrorIslandRange < (v8.Position - v6.Position).Magnitude then
			if not tbl23.ResetTeleport(v6.Position) then
				return false
			end
			local v9
			v9, v8 = tbl20.WaitForAliveRoot()
			if not v6.Parent then
				return false
			end
		end

		if tbl26.CakeMirrorIslandRange < (v8.Position - v6.Position).Magnitude then
			return false
		end

		if tbl26.FireCakeMirror(v6) then
			return true
		end
		local v9, v10 = tbl20.GetAliveRoot()
		if not v9 or not v10 or not v6.Parent then
			return false
		end

		if tbl26.CakeMirrorApproachDistance < (v10.Position - v6.Position).Magnitude then
			if not tbl23.MoveToPart(v6, tbl26.CakeMirrorApproachDistance) then
				return false
			end
			tbl20.WaitForAliveRoot()
			if not v6.Parent then
				return false
			end
		end

		return tbl26.FireCakeMirror(v6)
	end,
	TravelToSpawn = function(arg, arg2, arg3)
		local v6, v7 = tbl23.Travel(arg2)
		if v7 then
			return false, "Failed to travel to " .. arg .. ": " .. tostring(v7)
		end
		local n22 = os.clock() + n17
		local n23 = 0

		while true do
			if tbl26.Find(arg) then
				tbl23.StopJob(v6)
				return true, nil
			else
				local v8, v9 = tbl20.GetAliveRoot()

				if not v8 or not v9 then
					tbl23.StopJob(v6)
					tbl20.WaitForAliveRoot()
					return true, nil
				end

				local v10, v11 = tbl26.CheckAbort(arg3, n23)
				if v10 then
					tbl23.StopJob(v6)
					return false, nil, v10
				end

				if (v9.Position - arg2).Magnitude <= n16 then
					tbl23.StopJob(v6)
					return true, nil
				end

				if os.clock() >= n22 then
					tbl23.StopJob(v6)
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
		local v6, v7 = tbl20.EquipMelee()
		if not v6 then
			return false, "Failed to equip Melee for " .. arg .. ": " .. tostring(v7)
		end
		local v8, v9 = tbl14.Enable()
		if not v8 then
			return false, "Failed to enable Buso for " .. arg .. ": " .. tostring(v9)
		end
		local v10, v11 = tbl18.Attack(arg)
		if not v10 and not tbl18.IsTransientError(v11) and arg2.Health > 0 then
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
			v6, v7 = tbl23.Travel(arg2, 300, cframe)
		end

		if v7 then
			return false, "Failed to follow " .. arg .. ": " .. tostring(v7)
		end
		local now = os.clock()
		local n22 = 0
		local position = nil

		while arg2.Parent and arg3.Parent and arg4.Parent and arg4.Health > 0 do
			local v8, v9 = tbl20.GetAliveRoot()

			if not v8 or not v9 then
				tbl23.StopJob(v6)
				tbl20.WaitForAliveRoot()
				return true, nil
			end

			local v10, v11 = tbl26.CheckAbort(arg5, n22)
			if v10 then
				tbl23.StopJob(v6)
				return false, nil, v10
			end
			local magnitude = (arg3.Position - v9.Position).Magnitude

			if not position or (v9.Position - position).Magnitude >= n21 then
				position = v9.Position
				now = os.clock()
			elseif arg6 and magnitude > n7 and os.clock() - now >= n20 then
				tbl23.StopJob(v6)
				return true, nil
			end

			if magnitude <= n7 then
				local v12, v13 = tbl26.Strike(arg, arg4)

				if not v12 then
					tbl23.StopJob(v6)
					if tbl20.WaitForRespawnIfDead() then
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

		tbl23.StopJob(v6)
		return true, nil
	end,
	Kill = function(arg, arg2, arg3, arg4, arg5)
		if not tbl26.Exists(arg) then
			return false, arg .. " has not spawned"
		end
		local n22 = os.clock() + n18
		local v6 = nil

		while tbl26.Exists(arg) do
			if n22 <= os.clock() then
				return false, "Timed out while fighting " .. arg
			end
			local v7, v8 = tbl20.WaitForAliveRoot()
			local v9, v10, v11 = tbl26.Find(arg)
			local flag4 = tbl26.CakeMirrorBosses[arg] and v6 ~= v7 and (not v10 or (v10.Position - v8.Position).Magnitude > n7)

			if flag4 then
				local v12 = tbl26.UseCakeMirror(arg)
				local v13 = tbl20.WaitForAliveRoot()
				v9, v10, v11 = tbl26.Find(arg)

				if v12 then
					v6 = v13
				end
			end

			if flag4 then
				task.wait(0.25)
				continue
			end

			if not v9 then
				local v12, v13, v14 = tbl26.TravelToSpawn(arg, arg2, arg3)
				if v14 then
					return false, nil, v14
				end

				if not v12 then
					return false, v13
				end
				task.wait(0.25)
				continue
			end

			local v12, v13, v14 = tbl26.Fight(arg, v9, v10, v11, arg3, arg4, arg5)
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

local tbl27 = nil
local tbl28

tbl28 = {
	ReplicationTimeout = 20,
	ReplicationPollDelay = 0.5,
	ReplicationReady = false,
	GetModules = function()
		if tbl27 then
			return tbl27, nil
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
		tbl27 = { Id = result, Replication = result2 }
		return tbl27, nil
	end,
	GetId = function(arg, arg2)
		local v6, v7 = tbl28.GetModules()
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
		if tbl28.ReplicationReady then
			return true
		end
		local v6 = tbl28.GetModules()
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
			if type(itemId) ~= "number" then
				continue
			end

			local ok, result = pcall(function()
				return isOwned.readClient(itemId)
			end)

			if ok and result ~= nil then
				tbl28.ReplicationReady = true
				return true
			end
		end

		return false
	end,
	Read = function(arg, arg2, arg3)
		local v6, v7 = tbl28.GetId(arg2, arg3)
		if not v6 then
			return nil, v7
		end
		local v8 = tbl28.GetModules()
		v8 = v8 and v8.Replication[arg]
		if not v8 then
			return nil, "ItemReplication." .. arg .. " is unavailable"
		end
		local replicationTimeout = tbl28.ReplicationTimeout
		local n22 = os.clock() + replicationTimeout

		while true do
			local ok, result = pcall(function()
				return v8.readClient(v6)
			end)

			if not ok then
				return nil, arg .. ".readClient failed for " .. tostring(arg2)
			else
				if result ~= nil then
					tbl28.ReplicationReady = true
					return result, nil
				end

				if tbl28.HasAnyReplicatedItem() then
					return nil, nil
				end

				if os.clock() >= n22 then
					break
				end
				task.wait(tbl28.ReplicationPollDelay)
			end
		end

		return nil, "The inventory has not replicated yet, so " .. arg .. " for " .. tostring(arg2) .. " could not be read"
	end,
	WaitForReplication = function()
		local replicationTimeout = tbl28.ReplicationTimeout
		local n22 = os.clock() + replicationTimeout

		while not tbl28.HasAnyReplicatedItem() do
			if n22 <= os.clock() then
				return false, "The inventory has not replicated yet"
			end
			task.wait(tbl28.ReplicationPollDelay)
		end

		return true, nil
	end,
	ListOwned = function(arg, arg2)
		local v6, v7 = tbl28.GetModules()
		if not v6 then
			return nil, v7
		end
		local v8, v9 = tbl28.WaitForReplication()
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
		local tbl29 = {}

		for _, v10 in pairs(ids) do
			local id = type(v10) == "table" and v10.Id or nil

			if type(id) == "table" and id.Type == arg and type(id.StorageKey) == "string" and (arg2 == nil or string.find(id.StorageKey, arg2) ~= nil) then
				local ok, result = pcall(function()
					return v6.Replication.IsOwned.readClient(id.ItemId)
				end)

				if ok and result == true then
					tbl29[#tbl29 + 1] = id.StorageKey
				end
			end
		end

		return tbl29, nil
	end,
	GetQuantity = function(arg, arg2)
		local Quantity, v6 = tbl28.Read("Quantity", arg, arg2)
		if v6 then
			return nil, v6
		end
		return tonumber(Quantity) or 0, nil
	end,
	IsOwned = function(arg, arg2)
		local IsOwned, v6 = tbl28.Read("IsOwned", arg, arg2)
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
local tbl29 = {}

local tbl30 = {
	{ ItemName = "Mirror Fractal", ItemType = "Material", BossName = "Dough King" },
	{ ItemName = "Valkyrie Helm", ItemType = "Accessory", BossName = "rip_indra True Form" },
}

local tbl31

tbl31 = {
	CheckItem = function(arg, arg2)
		if tbl20.HasItem(arg) then
			return true, nil
		end
		local v6, v7 = tbl28.IsOwned(arg, arg2)
		if v6 then
			return true, nil
		end

		if arg2 == "Accessory" then
			local v8, v9 = tbl28.ScanUniqueItem(arg)
			if v8 then
				return true, nil
			end

			if v6 == false or v8 == false then
				return false, nil
			end
			return nil, "Could not check " .. arg .. ": " .. tostring(v7 or v9)
		end

		if v6 == false then
			return false, nil
		end
		return nil, "Could not check " .. arg .. ": " .. tostring(v7)
	end,
	HasItem = function(arg, arg2)
		if tbl29[arg] then
			return tbl31.CheckItem(arg, arg2)
		end
		local flag4 = false
		local v6 = nil

		for i = 1, 10 do
			local v7, v8 = tbl31.CheckItem(arg, arg2)
			if v7 then
				tbl29[arg] = nil
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
			tbl29[arg] = true
			return false, nil
		end
		return nil, v6 or "Could not verify " .. tostring(arg)
	end,
	ResolveSpawn = function(arg)
		local v6, v7 = tbl26.Find(arg)
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
			local v7, v8 = tbl31.HasItem(arg, arg2)

			if v7 == nil then
				return false, v8
			else
				if v7 then
					return true, nil
				end

				if not tbl26.Exists(arg3) then
					local v9, v10 = tbl12.RetryAPIServer(arg3)
					if not v9 then
						return false, arg3 .. " is not in this server: " .. tostring(v10)
					end
					return false, "Hopping to a server that has " .. arg3
				end

				tbl20.WaitForAliveRoot()
				local v9, v10 = tbl31.ResolveSpawn(arg3)
				if not v9 then
					return false, v10
				end
				local v11
				v11, v6 = tbl26.Kill(arg3, v9)
				if not v11 and not tbl20.WaitForRespawnIfDead() then
					break
				end
				task.wait(5)
			end
		end

		return false, v6
	end,
	EnsureAll = function()
		for _, v6 in ipairs(tbl30) do
			local v7, v8 = tbl31.HasItem(v6.ItemName, v6.ItemType)
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
				local v9, v10 = tbl31.Obtain(v6.ItemName, v6.ItemType, v6.BossName)
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

local tbl32 = {
	["Ship Deckhand"] = true,
	["Ship Engineer"] = true,
	["Ship Steward"] = true,
	["Ship Officer"] = true,
}

local tbl33

tbl33 = {
	HasAnyFlower = function()
		return tbl20.HasItem("Flower 1") or tbl20.HasItem("Flower 2") or tbl20.HasItem("Flower 3")
	end,
	IsRaceEvolved = function()
		local data = localPlayer:FindFirstChild("Data")
		data = data and data:FindFirstChild("Race")
		return data ~= nil and data:FindFirstChild("Evolved") ~= nil
	end,
	IsFlowerReady = function(arg)
		return tbl33.FindReadyFlower(arg) ~= nil
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

		while not tbl20.HasItem(arg3) and os.clock() < n28 do
			local v7, v8, v9 = tbl20.GetAliveRoot()
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

		if tbl20.HasItem(arg3) then
			return true, nil, false
		end
		return false, flag4 and arg2 .. " disappeared before " .. arg3 .. " reached the Backpack" or arg2 .. " did not grant " .. arg3 .. " within 10 seconds", true
	end,
	CollectFlower = function(arg, arg2)
		local n28 = os.clock() + n25
		local v7 = nil

		while not tbl20.HasItem(arg2) do
			if n28 <= os.clock() then
				if v7 then
					return false, arg .. " did not grant " .. arg2 .. " in time: " .. tostring(v7)
				end
				return false, arg .. " did not respawn in time to grant " .. arg2
			end

			local v8 = tbl33.FindReadyFlower(arg)
			if not v8 then
				task.wait(0.25)
				continue
			end
			local v9, v10 = tbl23.MoveToPart(v8)

			if not v9 then
				task.wait(0.25)
				v7 = v10
				continue
			end

			local v11, v12, v13 = tbl33.TouchFlower(v8, arg, arg2)

			if not v11 then
				if v13 then
					tbl8.StopActiveJob("The red or blue flower pickup timed out")
					local v14
					v14, v14 = tbl12.HopNormalServer()
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
		local requestEntrance, v7 = tbl10.Invoke("requestEntrance", arg)
		if v7 then
			return false, v7
		end
		local n28 = os.clock() + n27

		while true do
			local v8, v9, v10 = tbl20.GetAliveRoot()
			if not v8 or not v9 then
				return false, v10
			end

			if tbl33.IsInsideGhostShip(v9) == arg2 then
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
		local v7, v8, v9 = tbl20.GetAliveRoot()
		if not v7 or not v8 then
			return false, v9
		end

		if tbl33.IsInsideGhostShip(v8) then
			return true, nil
		end
		return tbl33.UseGhostShipGate(Vector3.new(923.213, 125.39765, 32852.832), true)
	end,
	ExitGhostShip = function()
		local v7, v8, v9 = tbl20.GetAliveRoot()
		if not v7 or not v8 then
			return false, v9
		end

		if not tbl33.IsInsideGhostShip(v8) then
			return true, nil
		end
		return tbl33.UseGhostShipGate(Vector3.new(-6491.8643, 116.52766, -108.822334), false)
	end,
	AttackGhostShipMob = function(arg, arg2, arg3)
		local v7, v8 = tbl20.EquipMelee()
		if not v7 then
			return false, "Failed to equip Melee for " .. arg3 .. ": " .. tostring(v8)
		end
		local v9, v10 = tbl14.Enable()
		if not v9 then
			return false, "Failed to enable Buso for " .. arg3 .. ": " .. tostring(v10)
		end
		local v11, v12 = tbl19.Gather(arg, nil, 350)

		if v11 == 0 and v12 and v12 ~= v6 then
			v6 = v12
			warn("Failed to gather Ghost Ship mobs: " .. tostring(v12))
		end

		local v13, v14 = tbl18.Attack()
		if not v13 and not tbl18.IsTransientError(v14) and arg2.Health > 0 then
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
				tbl23.StopJob(v7)
				return false, v10
			end

			if v9 then
				tbl23.StopJob(v7)
				return true, nil
			end
			local v11, v12 = tbl20.GetAliveRoot()

			if not v11 or not v12 then
				tbl23.StopJob(v7)
				tbl20.WaitForAliveRoot()
				return true, nil
			end

			if not tbl33.IsInsideGhostShip(v12) then
				tbl23.StopJob(v7)
				return true, nil
			end

			if (arg2.Position - v12.Position).Magnitude <= n7 then
				local v13, v14 = tbl33.AttackGhostShipMob(arg, arg3, arg5)

				if not v13 then
					tbl23.StopJob(v7)
					if tbl20.WaitForRespawnIfDead() then
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

		tbl23.StopJob(v7)
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
				local v10, v11 = tbl20.GetAliveRoot()
				if not v10 or not v11 then
					tbl20.WaitForAliveRoot()
					return true, nil
				end

				if not tbl33.IsInsideGhostShip(v11) then
					local v12, v13 = tbl33.EnterGhostShip()

					if not v12 then
						if tbl20.WaitForRespawnIfDead() then
							return true, nil
						end
						return false, v13
					end

					task.wait(0.25)
					continue
				end

				local v12, v13, v14 = tbl33.FindNearestMob(v11, tbl32)
				if not v12 then
					task.wait(0.25)
					continue
				end
				local v15
				v15, v7 = tbl33.FarmGhostShipMob(v12, v13, v14, arg, arg2)
				if not v15 then
					break
				end
			end
		end

		return false, v7
	end,
	HasYellowFlower = function()
		return tbl20.HasItem("Flower 3"), nil
	end,
	CollectYellowFlower = function()
		local v7, v8 = tbl33.FarmGhostShip(tbl33.HasYellowFlower, "Flower 3")
		if not v7 then
			return false, v8
		end

		if not tbl20.HasItem("Flower 3") then
			return true, nil
		end
		local v9, v10 = tbl33.ExitGhostShip()

		if not v9 then
			if tbl20.WaitForRespawnIfDead() then
				return true, nil
			end
			return false, v10
		end

		return true, nil
	end,
	CollectNextFlower = function()
		if not tbl33.HasAnyFlower() and not tbl33.IsFlowerReady("Flower1") then
			local v7
			v7, v7 = tbl12.HopNormalServer()
			return false, v7 or "Hopping to a low server for the blue flower"
		end

		if not tbl20.HasItem("Flower 1") and tbl33.IsFlowerReady("Flower1") then
			return tbl33.CollectFlower("Flower1", "Flower 1")
		end

		if not tbl20.HasItem("Flower 2") and tbl33.IsFlowerReady("Flower2") then
			return tbl33.CollectFlower("Flower2", "Flower 2")
		end

		if not tbl20.HasItem("Flower 3") then
			return tbl33.CollectYellowFlower()
		end
		return true, nil
	end,
	RunQuest = function()
		if not tbl2[placeId] then
			return false, "The Race V2 quest only works in the Second Sea"
		end
		tbl20.WaitForAliveRoot()
		local data = localPlayer:WaitForChild("Data", 10)
		local race = data and data:WaitForChild("Race", 10)
		data = data and data:WaitForChild("Beli", 10)
		if not race or not data then
			return false, "Player race or Beli data did not load in time"
		end

		if tbl33.IsRaceEvolved() then
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
			if tbl33.IsRaceEvolved() then
				return true, "Race upgraded to V2", true
			else
				local v7
				Alchemist, v7 = tbl10.Invoke("Alchemist", "1")
				if v7 then
					return false, v7
				end

				if Alchemist == 0 then
					local Alchemist2, v8 = tbl10.Invoke("Alchemist", "2")
					if v8 then
						return false, v8
					end
				elseif Alchemist == 1 then
					local v8, v9 = tbl33.CollectNextFlower()
					if not v8 then
						return false, v9
					end
				else
					if Alchemist ~= 2 then
						break
					end
					local Alchemist2, v8 = tbl10.Invoke("Alchemist", "3")
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

local tbl34 = {
	BossName = "Cake Prince",
	Reserve = 9250,
	ThirdSeaAction = "ThirdSea",
	ServerHopAction = "ServerHop",
	QuietServerAction = "QuietServer",
}

local tbl35 = {
	Human = "Full Power",
	Mink = "Godspeed",
	Fishman = "Warrior of the Sea",
	Skypiea = "Perfect Being",
	Cyborg = "War Machine",
	Ghoul = "Hell Hound",
}

local tbl36

tbl36 = {
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
		local Wenlocktoad, v7 = tbl10.Invoke("Wenlocktoad")
		if v7 then
			return nil, v7
		end
		return Wenlocktoad ~= nil, nil
	end,
	GetTitles = function()
		local getTitles

		while true do
			local v7
			getTitles, v7 = tbl10.Invoke("getTitles")

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
		local v7 = tbl35[arg]
		if not v7 then
			return nil, "No Race V3 title is configured for " .. tostring(arg)
		end
		local v8, v9 = tbl36.GetTitles()
		if not v8 then
			return nil, v9
		end
		return tbl36.HasTitleNamed(v8, v7), nil
	end,
	RerollOnce = function()
		local BlackbeardReward, v7 = tbl10.Invoke("BlackbeardReward", "Reroll", "1")
		if v7 then
			return false, "Failed to check race reroll: " .. tostring(v7)
		end
		local BlackbeardReward2, v8 = tbl10.Invoke("BlackbeardReward", "Reroll", "2")
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
			local v7, v8 = tbl36.RerollOnce()
			if not v7 then
				return false, v8
			end
		end

		return true, nil
	end,
}

local v7 = nil
local tbl37

tbl37 = {
	EnsureAmount = function(arg, arg2, arg3)
		if type(arg) ~= "table" or not arg.Fragments then
			return false, "Fragments data is unavailable"
		end
		local flag4 = false

		while arg.Fragments.Value < arg2 do
			if not tbl3[placeId] then
				return false, "Cake Prince fragment farming needs the Third Sea", tbl34.ThirdSeaAction
			end

			if not flag4 then
				flag4 = true
			end

			if type(arg3) == "function" then
				arg3(string.format("Farming Cake Prince for Fragments: %d/%d", arg.Fragments.Value, arg2), "Working")
			end

			if not tbl26.Exists(tbl34.BossName) then
				local v8, v9 = tbl12.RetryAPIServer(tbl34.BossName)
				if not v8 then
					return false, tbl34.BossName .. " is not in this server: " .. tostring(v9)
				end
				return false, "Hopping through APIServer to find " .. tbl34.BossName, tbl34.ServerHopAction
			end

			tbl20.WaitForAliveRoot()
			local v8, v9 = tbl31.ResolveSpawn(tbl34.BossName)
			if not v8 then
				return false, v9
			end
			local v10, v11 = tbl26.Kill(tbl34.BossName, v8, nil, nil, CFrame.new(0, -50, 0))
			if not v10 and not tbl20.WaitForRespawnIfDead() then
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
			local v8, v9, v10 = tbl37.EnsureAmount(arg2, 3000, arg3)
			if not v8 then
				return false, v9, v10
			end

			if type(arg3) == "function" then
				arg3("Rerolling " .. tostring(arg2.Race.Value) .. " to " .. arg, "Working")
			end

			local v11, v12 = tbl36.RerollOnce()
			if not v11 then
				return false, v12
			end
		end

		return true, nil, nil
	end,
}

tbl36.MeetsV3Requirements = function(arg, arg2)
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
local tbl38

tbl38 = {
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
		return tbl38.ReadFistAccounts()[tostring(localPlayer.UserId)] == true
	end,
	MarkFistInserted = function()
		flag4 = true
		if not flag6 then
			return
		end
		local v8 = tbl38.ReadFistAccounts()
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

		if not ok or not tbl8.IsFiniteCFrame(result) then
			return nil, "Order has no valid pivot"
		end
		return result.Position, nil
	end,
	FarmFistOfDarkness = function()
		if tbl20.HasItem("Fist of Darkness") then
			return true, nil
		end

		local v8, v9, v10 = tbl25.Farm(function(arg)
			return tbl20.HasItem("Fist of Darkness") or arg >= n34
		end)

		if not v8 then
			return false, v9
		end

		if tbl20.HasItem("Fist of Darkness") then
			return true, nil
		end
		local v11, v12 = tbl12.HopNormalServer()
		if not v11 then
			return false, string.format("%d chests were opened without a Fist of Darkness %s", v10, tostring(v12))
		end
		return false, string.format("Hopping to a low server after %d chests without a Fist of Darkness", v10)
	end,
	InsertFistOfDarkness = function()
		local v8, v9 = tbl38.FarmFistOfDarkness()
		if not v8 then
			return false, v9
		end
		local v10, v11 = tbl20.EquipItem("Fist of Darkness")
		if not v10 then
			return false, v11
		end
		local v12, v13 = tbl38.UseMachine()
		if not v12 then
			return false, v13
		end
		task.wait(1)
		if tbl20.HasItem("Fist of Darkness") then
			return false, "The Cyborg machine did not accept the Fist of Darkness"
		end
		tbl38.MarkFistInserted()
		return true, nil
	end,
	LoadStoredFruit = function()
		local Moveset, v8 = tbl28.ListOwned("Moveset", "%-")
		if not Moveset then
			return false, v8
		end
		local v9 = Moveset[1]
		if not v9 then
			return false, "There is no stored Blox Fruit to show Arowe"
		end
		local LoadFruit, v10 = tbl10.Invoke("LoadFruit", v9)
		if v10 then
			return false, v10
		end
		return true, v9
	end,
	RunRaceStep = function(arg)
		local n35 = n31 + tbl34.Reserve
		local CyborgTrainer, v8 = tbl10.Invoke("CyborgTrainer", "Check")
		if v8 then
			return false, v8
		end

		if CyborgTrainer == true then
			if arg.Fragments.Value < n35 then
				return false, nil, n35
			end
			local CyborgTrainer2, v9 = tbl10.Invoke("CyborgTrainer", "Buy")
			return v9 == nil, v9
		end

		if tbl20.HasItem("Core Brain") then
			return tbl38.UseMachine()
		end

		if tbl26.Exists("Order") then
			local v9, v10 = tbl38.GetOrderPosition()
			if not v9 then
				return false, v10
			end
			return tbl26.Kill("Order", v9)
		end

		if tbl20.HasItem("Microchip") then
			return tbl38.UseMachine()
		end

		if not tbl38.HasInsertedFist() then
			return tbl38.InsertFistOfDarkness()
		end

		if n32 <= arg.Fragments.Value - n35 then
			local BlackbeardReward, v9 = tbl10.Invoke("BlackbeardReward", "Microchip", "2")
			return v9 == nil, v9
		end
		return false, nil, n35 + n33
	end,
	EnsureRace = function(arg, arg2)
		if type(arg) ~= "table" or not arg.Race or not arg.Fragments then
			return false, "Race or Fragments data is unavailable"
		end

		while arg.Race.Value ~= "Cyborg" do
			local v8, v9, v10 = tbl38.RunRaceStep(arg)

			if v10 then
				local v11, v12, v13 = tbl37.EnsureAmount(arg, v10, arg2)
				if not v11 then
					return false, v12, v13
				end
			elseif not v8 then
				return false, v9
			end

			task.wait(0.5)
		end

		tbl20.WaitForAliveRoot()
		return true, nil
	end,
}

local n35 = 7.5
local n36 = 15
local tbl39 = { "Z", "X", "C" }
local n37 = 0.15
local n38 = 0.3
local n39 = 0.5
local n40 = 2000
local n41 = 120
local n42 = 1
local n43 = 5
local n44 = 0
local v8 = nil
local tbl40

tbl40 = {
	Enable = function()
		local character = localPlayer.Character
		local now = os.clock()
		local flag7 = character ~= v8
		if not flag7 and now - n44 < n42 then
			return true, nil
		end
		local EnablePvp, v9 = tbl10.Invoke("EnablePvp")
		if v9 then
			return false, v9
		end
		v8 = character
		n44 = os.clock()

		if flag7 then
			task.wait(1.5)
		end

		return true, nil
	end,
	GetPlayerRace = function(arg)
		arg = arg and arg:FindFirstChild("Data")
		arg = arg and arg:FindFirstChild("Race")
		if not arg or type(arg.Value) ~= "string" or arg.Value == "" then
			return nil
		end
		return arg.Value
	end,
	GetTargetHumanoid = function(arg, arg2)
		if not arg.Parent or arg == localPlayer then
			return nil
		end

		if arg2 and tbl40.GetPlayerRace(arg) ~= arg2 then
			return nil
		end
		local character = arg.Character
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not character or character.Health <= 0 then
			return nil
		end
		return character
	end,
	FindNextTarget = function(arg, arg2)
		for _, player in ipairs(Players:GetPlayers()) do
			if not arg[player] and tbl40.GetTargetHumanoid(player, arg2) then
				return player
			end
		end

		return nil
	end,
	StrikeTarget = function(arg, arg2)
		local v9, v10 = tbl20.EquipMelee()
		if not v9 then
			return false, "Failed to equip Melee for PvP: " .. tostring(v10)
		end
		local v11, v12 = tbl14.Enable()
		if not v11 then
			return false, "Failed to enable Buso for PvP: " .. tostring(v12)
		end
		local v13, v14 = tbl18.AttackPlayer(arg)
		if not v13 and not tbl18.IsTransientError(v14) then
			return false, v14
		end

		if arg2 then
			return true, nil
		end
		local v15, v16 = tbl15.CastKeys(tbl39, 0.1)
		if not v15 then
			return false, v16
		end
		return true, nil
	end,
	Retreat = function(arg)
		local v9, v10 = tbl20.WaitForAliveRoot()
		local vector2 = Vector3.new(v10.Position.X, v10.Position.Y + n40, v10.Position.Z)

		pcall(function()
			v9:PivotTo(CFrame.new(vector2))
			tbl8.StopVelocity(v10)
		end)

		local v11 = arg and tbl40.GetTargetHumanoid(arg)
		local v12 = nil
		local v13 = nil

		if v11 then
			v12, v13 = tbl23.Travel(arg, 300, CFrame.new(0, 2000, 0))
		end

		if not v12 or v13 then
			v12, v13 = tbl23.Travel(vector2)
		end

		if v13 then
			return false, v13
		end
		local n45 = os.clock() + n41

		while tbl20.GetHealthRatio() < n39 do
			if not (n45 <= os.clock()) then
				if tbl20.GetAliveRoot() then
					task.wait(1)
					continue
				end
			end

			break
		end

		tbl23.StopJob(v12)
		return true, nil
	end,
	AttackTarget = function(arg, arg2)
		local v9 = tbl40.GetTargetHumanoid(arg, arg2)
		if not v9 then
			return false, nil
		end
		tbl15.SetAim(nil)
		local v10, v11 = tbl23.Travel(arg, 300)
		if v11 then
			return false, v11
		end
		local health = v9.Health
		local n45 = os.clock() + n36
		local flag7 = false
		local flag8 = false
		local n46 = nil
		local n47 = nil
		local v12

		while true do
			local flag9

			if v9.Health <= 0 then
				flag7 = true
				flag9 = false
				tbl23.StopJob(v10)
				tbl15.SetAim(nil)
				return flag7, nil, flag9
			else
				if v9.Health < health then
					flag7 = true
				end

				if v9.MaxHealth > 0 and v9.Health / v9.MaxHealth <= n37 then
					flag8 = true
				end

				local v13, v14 = tbl20.GetAliveRoot()

				if not v13 or not v14 then
					flag9 = true
					tbl23.StopJob(v10)
					tbl15.SetAim(nil)
					return flag7, nil, flag9
				end

				flag9 = false

				if tbl20.GetHealthRatio() < n38 then
					tbl23.StopJob(v10)
					tbl15.SetAim(nil)
					return flag7, nil, flag9
				end

				local humanoidRootPart = arg.Character and arg.Character:FindFirstChild("HumanoidRootPart")

				if not humanoidRootPart or not v9.Parent then
					tbl23.StopJob(v10)
					tbl15.SetAim(nil)
					return flag7, nil, flag9
				end

				if flag8 then
					tbl15.SetAim(nil)
				else
					tbl15.SetAim(humanoidRootPart.Position)
				end

				if (humanoidRootPart.Position - v14.Position).Magnitude <= n7 then
					if not n46 then
						n46 = os.clock() + n35
						n47 = os.clock() + n43
					end

					local v15
					v15, v12 = tbl40.StrikeTarget(arg, flag8)
					if not v15 then
						break
					end
				end

				if n46 then
					if not flag7 and os.clock() >= n47 then
						tbl23.StopJob(v10)
						tbl15.SetAim(nil)
						return flag7, nil, flag9
					end

					if os.clock() >= n46 then
						tbl23.StopJob(v10)
						tbl15.SetAim(nil)
						return flag7, nil, flag9
					end
				elseif n45 <= os.clock() then
					tbl23.StopJob(v10)
					tbl15.SetAim(nil)
					return flag7, nil, flag9
				end

				task.wait()
			end
		end

		tbl23.StopJob(v10)
		tbl15.SetAim(nil)
		return flag7, v12, false
	end,
	CountRacePlayers = function(arg)
		local n45 = 0
		local n46 = 0
		local n47 = 0

		for _, player in ipairs(Players:GetPlayers()) do
			if player ~= localPlayer then
				n45 += 1
				local v9 = tbl40.GetPlayerRace(player)

				if v9 then
					n46 += 1

					if v9 == arg then
						n47 += 1
					end
				end
			end
		end

		return n47, n46, n45
	end,
	ShouldHopForRace = function(arg)
		local v9, v10, v11 = tbl40.CountRacePlayers(arg)
		if v11 == 0 then
			return true
		end
		return v10 > 0 and v9 == 0
	end,
	HopForMissingRace = function(arg)
		local v9, v10 = tbl12.HopNormalServer()
		if not v9 then
			return false, "No " .. arg .. " player is in this server: " .. tostring(v10)
		end
		return false, "Hopping to a low server to find a " .. arg .. " player"
	end,
	AttackPlayers = function(arg, arg2, arg3, arg4)
		local Pirates, v9 = tbl13.Join("Pirates")
		if not Pirates then
			return false, tostring(arg3) .. " PvP requires the " .. str .. " team: " .. tostring(v9)
		end
		tbl15.HookAim()
		local tbl41 = {}
		local v10 = nil

		while true do
			local v11, v12 = arg()

			if v12 then
				return false, v12
			else
				if v11 then
					return true, nil
				end
				tbl20.WaitForAliveRoot()
				local v13, v14 = tbl40.Enable()
				if not v13 then
					return false, tostring(arg3) .. " PvP could not be enabled: " .. tostring(v14)
				end

				if tbl20.GetHealthRatio() < n38 then
					tbl40.Retreat(v10)
				end

				local v15

				if v10 and not tbl41[v10] and tbl40.GetTargetHumanoid(v10, arg2) then
					v15 = v10
				else
					v15 = tbl40.FindNextTarget(tbl41, arg2)
				end

				if not v15 and next(tbl41) ~= nil then
					table.clear(tbl41)

					if v10 then
						tbl41[v10] = true
					end

					v15 = tbl40.FindNextTarget(tbl41, arg2)

					if not v15 then
						table.clear(tbl41)
						task.wait(5)
						v15 = tbl40.FindNextTarget(tbl41, arg2)
					end
				end

				if not v15 then
					if arg4 and tbl40.ShouldHopForRace(arg2) then
						break
					end
					task.wait(5)
					continue
				end

				local v16, v17, v18 = tbl40.AttackTarget(v15, arg2)

				if v17 then
					warn(tostring(arg3) .. " PvP: " .. tostring(v17))
				end

				if v18 or not v16 then
					tbl41[v15] = true
					v10 = v15
				else
					v10 = v15
				end
			end
		end

		return tbl40.HopForMissingRace(arg2)
	end,
}

local n45 = 100
local n46 = 5
local str2 = "Cursed Captain"
local n47 = 5
local n48 = 0
local n49 = 0
local tbl41

tbl41 = {
	GetEctoplasm = function()
		return tbl28.GetQuantity("Ectoplasm", "Material")
	end,
	RefreshEctoplasm = function(arg)
		local now = os.clock()

		if arg or now - n49 >= n46 then
			local v9, v10 = tbl41.GetEctoplasm()
			if v9 == nil then
				return nil, v10
			end
			n48 = v9
			n49 = now
		end

		return n48, nil
	end,
	HasEnoughEctoplasm = function()
		local v9, v10 = tbl41.RefreshEctoplasm(false)
		if v9 == nil then
			return false, v10
		end
		return v9 >= n45, nil
	end,
	FarmEctoplasm = function()
		return tbl33.FarmGhostShip(tbl41.HasEnoughEctoplasm, "Ectoplasm")
	end,
	HasLeftGhostShip = function()
		local v9, v10 = tbl20.GetAliveRoot()
		if not v9 or not v10 then
			return nil
		end

		if tbl33.IsInsideGhostShip(v10) then
			return nil
		end
		return true
	end,
	FarmTorch = function()
		while not tbl20.HasItem("Hellfire Torch") do
			if not tbl26.Exists("Cursed Captain") then
				local v9, v10 = tbl12.RetryAPIServer("Cursed Captain")
				if not v9 then
					return false, str2 .. " is not in this server: " .. tostring(v10)
				end
				return false, "Hopping to a server that has " .. str2
			end

			tbl20.WaitForAliveRoot()
			local v9, v10 = tbl33.EnterGhostShip()

			if not v9 then
				if not tbl20.WaitForRespawnIfDead() then
					return false, v10
				end
			else
				local v11, v12, v13 = tbl26.Kill("Cursed Captain", Vector3.new(923.213, 125.39765, 32852.832), tbl41.HasLeftGhostShip, true)
				if not v11 and not v13 then
					return false, v12
				end
			end

			task.wait(5)
		end

		return true, nil
	end,
	RunRaceStep = function(arg)
		local Ectoplasm, v9 = tbl10.Invoke("Ectoplasm", "Change", 4)
		if v9 then
			return false, v9
		end
		task.wait(1)
		if arg.Race.Value == "Ghoul" then
			return true, nil
		end
		local v10, v11 = tbl41.RefreshEctoplasm(true)
		if v10 == nil then
			return false, v11
		end

		if v10 < n45 then
			return tbl41.FarmEctoplasm()
		end

		if not tbl20.HasItem("Hellfire Torch") then
			return tbl41.FarmTorch()
		end
		local Ectoplasm2, v12 = tbl10.Invoke("Ectoplasm", "Buy", 4)
		if v12 then
			return false, v12
		end
		task.wait(1)
		return true, nil, true
	end,
	EnsureRace = function(arg)
		if type(arg) ~= "table" or not arg.Race then
			return false, "Race data is unavailable"
		end
		local n50 = 0

		while arg.Race.Value ~= "Ghoul" do
			local v9, v10, v11 = tbl41.RunRaceStep(arg)
			if not v9 then
				return false, v10
			end

			if v11 then
				n50 += 1
				if not (n47 <= n50) then
					continue
				end
				return false, "The Ectoplasm shop did not change the race to Ghoul"
			end
		end

		tbl20.WaitForAliveRoot()
		return true, nil
	end,
}

local tbl42 = {
	BoatDealerPosition = Vector3.new(-12.414993, 8.977997, 2959.396),
	BoatDealerTolerance = 15,
	BoatName = "MarineBrigade",
	BoatSpawnDelay = 2,
	BoatSitTimeout = 15,
	BoatSitPollDelay = 0.25,
	BeastZonePosition = Vector3.new(-64.29892, 33.836834, 6347.8853),
	BeastPollDelay = 0.5,
	BeastHopTimeout = 600,
	BeastRange = 2000,
	BeastHoverHeight = 200,
	BeastOrbitRadius = 100,
	BeastOrbitSpeed = 6,
	BeastMoveTolerance = 50,
	OrbitTolerance = 20,
	EventEscapeHeight = 2000,
	RetreatHealthRatio = 0.3,
	ReturnHealthRatio = 0.5,
	TeacherPosition = Vector3.new(-2599.6218, 238.19833, -10315.998),
	KarateName = "Sharkman Karate",
	SkillKeys = { "Z", "X", "C" },
	SkillKeyDelay = 0.1,
	BuyDelay = 1,
	MobAttackHeight = 15,
	ArrivalTolerance = 3,
	MoveTimeout = 120,
	FleeMobNames = { PirateBrigade = true, PirateGrandBrigade = true },
	FleeSearchFolders = { "Enemies", "SeaBeasts", "Boats", "NPCs" },
	LastFleeName = nil,
	FarmMobNames = { Shark = true, Piranha = true },
}

local tbl43

tbl43 = {
	MoveDirect = function(arg, arg2, arg3)
		if typeof(arg) ~= "Vector3" then
			return false, "Fishman move position must be a Vector3"
		end

		if arg2 == nil then
			arg2 = tbl42.ArrivalTolerance
		end

		local v9, v10 = Tween(arg, nil, nil, arg3)
		if v10 then
			return false, v10
		end
		local moveTimeout = tbl42.MoveTimeout
		local n50 = os.clock() + moveTimeout

		while v9:IsRunning() do
			local v11
			v11, v11 = tbl20.WaitForAliveRoot()
			if (v11.Position - arg).Magnitude <= arg2 then
				tbl23.StopJob(v9)
				return true, nil
			end

			if n50 <= os.clock() then
				tbl23.StopJob(v9)
				return false, "Timed out while moving across the sea"
			end
			task.wait(0.25)
		end

		return false, v9:GetReason() or "Fishman movement stopped before reaching the target"
	end,
	IsSeaBeastAlive = function(arg)
		if not arg or not arg.Parent then
			return false
		end
		local health = arg:FindFirstChild("Health")
		return health ~= nil and health.Value > 0
	end,
	FindSeaBeast = function()
		local seaBeasts = Workspace:FindFirstChild("SeaBeasts")
		local v9, v10 = tbl20.GetAliveRoot()
		if not seaBeasts or not v9 or not v10 then
			return nil, nil
		end

		for _, child in ipairs(seaBeasts:GetChildren()) do
			local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
			if humanoidRootPart and humanoidRootPart:IsA("BasePart") and tbl43.IsSeaBeastAlive(child) and (humanoidRootPart.Position - v10.Position).Magnitude <= tbl42.BeastRange then
				return child, humanoidRootPart
			end
		end

		return nil, nil
	end,
	FindOwnedBoat = function()
		local boats = Workspace:FindFirstChild("Boats")
		if not boats then
			return nil
		end

		for _, child in ipairs(boats:GetChildren()) do
			local owner = child:FindFirstChild("Owner")
			local vehicleSeat = child:FindFirstChild("VehicleSeat")

			if owner then
				local name = localPlayer.Name
				owner = tostring(owner.Value) == name
			end

			if owner and vehicleSeat then
				return child
			end
		end

		return nil
	end,
	BuyBoat = function()
		local v9, v10 = tbl23.MoveToPosition(tbl42.BoatDealerPosition, tbl42.BoatDealerTolerance)
		if not v9 then
			return false, v10
		end
		local BuyBoat, v11 = tbl10.Invoke("BuyBoat", tbl42.BoatName)
		if v11 then
			return false, v11
		end
		task.wait(tbl42.BoatSpawnDelay)
		if not tbl43.FindOwnedBoat() then
			return false, "Could not buy the " .. tbl42.BoatName .. " boat"
		end
		return true, nil
	end,
	SitOnBoat = function(arg)
		local vehicleSeat = arg and arg:FindFirstChild("VehicleSeat")
		if not vehicleSeat or not vehicleSeat:IsA("VehicleSeat") then
			return false, "The boat has no VehicleSeat"
		end
		tbl8.StopActiveJob("Sitting down on the boat")
		local boatSitTimeout = tbl42.BoatSitTimeout
		local n50 = os.clock() + boatSitTimeout

		repeat
			if not arg.Parent or not vehicleSeat.Parent then
				return false, "The boat disappeared"
			end
			local v9, v10 = tbl20.WaitForAliveRoot()
			local humanoid = v9:FindFirstChildOfClass("Humanoid")
			if not humanoid then
				return false, "Local humanoid is unavailable while sitting down"
			end

			if vehicleSeat.Occupant == humanoid then
				return true, nil
			end

			pcall(function()
				v9:PivotTo(vehicleSeat.CFrame * CFrame.new(0, 1, 0))
				tbl8.StopVelocity(v10)
				vehicleSeat:Sit(humanoid)
			end)

			task.wait(tbl42.BoatSitPollDelay)
		until os.clock() >= n50

		return false, "Could not sit on the boat"
	end,
	LeaveBoat = function()
		tbl20.PreventSit(localPlayer.Character)
	end,
	FindSeaMob = function(arg)
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return nil, nil
		end

		for _, child in ipairs(enemies:GetChildren()) do
			if arg[child.Name] then
				local humanoid = child:FindFirstChildOfClass("Humanoid")
				local humanoidRootPart = child:FindFirstChild("HumanoidRootPart")
				if humanoid and humanoid.Health > 0 and humanoidRootPart and humanoidRootPart:IsA("BasePart") then
					return child, humanoidRootPart
				end
			end
		end

		return nil, nil
	end,
	GetWaterHeight = function(arg)
		local map = Workspace:FindFirstChild("Map")
		map = map and map:FindFirstChild("WaterBase-Plane")
		if map and map:IsA("BasePart") then
			return map.Position.Y
		end
		return arg
	end,
	GetSkyPosition = function(arg)
		local eventEscapeHeight = tbl42.EventEscapeHeight
		local z = arg.Z
		return Vector3.new(arg.X, tbl43.GetWaterHeight(arg.Y) + eventEscapeHeight, z)
	end,
	EscapeToSky = function(arg)
		local v9, v10 = tbl20.WaitForAliveRoot()

		pcall(function()
			v9:PivotTo(CFrame.new(arg))
			tbl8.StopVelocity(v10)
		end)

		return tbl43.MoveDirect(arg, tbl42.BeastMoveTolerance)
	end,
	NormalizeName = function(arg)
		local v9 = string.gsub(tostring(arg), "[%s_%-]", "")
		return string.lower(v9)
	end,
	IsFleeEvent = function(arg)
		local v9 = tbl43.NormalizeName(arg.Name)

		for k in pairs(tbl42.FleeMobNames) do
			if v9 == tbl43.NormalizeName(k) then
				return true
			end
		end

		return false
	end,
	FindFleeEvent = function()
		for _, fleeSearchFolder in ipairs(tbl42.FleeSearchFolders) do
			local v9 = Workspace:FindFirstChild(fleeSearchFolder)

			if v9 then
				for _, child in ipairs(v9:GetChildren()) do
					if tbl43.IsFleeEvent(child) then
						return child
					end
				end
			end
		end

		for _, child in ipairs(Workspace:GetChildren()) do
			if tbl43.IsFleeEvent(child) then
				return child
			end
		end

		return nil
	end,
	ShouldRetreat = function(arg)
		local v9 = tbl43.FindFleeEvent()

		if v9 then
			if tbl42.LastFleeName ~= v9.Name then
				tbl42.LastFleeName = v9.Name
				warn("Fishman is escaping from " .. v9.Name)
			end

			return true
		end

		tbl42.LastFleeName = nil
		local v10 = tbl20.GetHealthRatio()
		if arg then
			return v10 < tbl42.ReturnHealthRatio
		end
		return v10 < tbl42.RetreatHealthRatio
	end,
	AttackSeaMob = function(arg, arg2)
		tbl43.LeaveBoat()
		local v9, v10 = Tween(arg, 300, CFrame.new(0, tbl42.MobAttackHeight, 0))
		if v10 then
			return false, v10
		end

		while arg.Parent and v9:IsRunning() do
			local humanoid = arg:FindFirstChildOfClass("Humanoid")
			local v11
			v11, v11 = tbl20.WaitForAliveRoot()
			if not humanoid or humanoid.Health <= 0 or not arg2.Parent then
				tbl23.StopJob(v9)
				return true, nil
			end

			if (arg2.Position - v11.Position).Magnitude <= n7 then
				local v12, v13 = tbl20.EquipMelee()
				if not v12 then
					tbl23.StopJob(v9)
					return false, v13
				end
				local v14, v15 = tbl14.Enable()
				if not v14 then
					tbl23.StopJob(v9)
					return false, v15
				end
				local v16, v17 = tbl18.Attack(arg.Name)
				if not v16 and not tbl18.IsTransientError(v17) then
					tbl23.StopJob(v9)
					return false, v17
				end
				return true, nil
			end

			task.wait(0.25)
		end

		tbl23.StopJob(v9)
		return true, nil
	end,
	RideToBeastZone = function()
		local v9 = tbl43.FindOwnedBoat()
		if not v9 then
			return tbl43.BuyBoat()
		end
		local v10, v11 = tbl43.SitOnBoat(v9)
		if not v10 then
			return false, v11
		end
		return tbl43.MoveDirect(tbl42.BeastZonePosition, tbl42.BeastMoveTolerance, true)
	end,
	LureSeaBeast = function()
		local beastHopTimeout = tbl42.BeastHopTimeout
		local n50 = os.clock() + beastHopTimeout
		local flag7 = false
		local v9

		while true do
			if tbl43.FindSeaBeast() then
				tbl8.StopActiveJob("A Sea Beast has appeared")
				return true, nil
			else
				if n50 <= os.clock() then
					local v10, v11 = tbl12.HopNormalServer()
					if not v10 then
						return false, "No Sea Beast appeared: " .. tostring(v11)
					end
					return false, "Hopping to a low server to find a Sea Beast"
				end

				tbl20.WaitForAliveRoot()
				flag7 = tbl43.ShouldRetreat(flag7)
				local v10, v11 = tbl43.FindSeaMob(tbl42.FarmMobNames)

				if flag7 then
					tbl43.LeaveBoat()
					local v12, v13 = tbl43.EscapeToSky(tbl43.GetSkyPosition(tbl42.BeastZonePosition))
					if not v12 then
						return false, v13
					end
				elseif v10 then
					local v12, v13 = tbl43.AttackSeaMob(v10, v11)
					if not v12 then
						return false, v13
					end
				else
					local v12
					v12, v9 = tbl43.RideToBeastZone()
					if not v12 then
						break
					end
				end

				task.wait(tbl42.BeastPollDelay)
			end
		end

		return false, v9
	end,
	BuySharkmanKarate = function()
		if tbl20.HasItem(tbl42.KarateName) then
			return true, nil
		end
		local v9, v10 = tbl23.MoveToPosition(tbl42.TeacherPosition, 10)
		if not v9 then
			return false, v10
		end
		local BuySharkmanKarate, v11 = tbl10.Invoke("BuySharkmanKarate", true)
		if v11 then
			return false, v11
		end
		local BuySharkmanKarate2, v12 = tbl10.Invoke("BuySharkmanKarate")
		if v12 then
			return false, v12
		end
		task.wait(tbl42.BuyDelay)
		if not tbl20.HasItem(tbl42.KarateName) then
			return false, "Sharkman Karate requires Fishman Karate mastery 400, a Water Key, and 5000 Fragments"
		end
		return true, nil
	end,
	GetSeaBeastOrbitPosition = function(arg)
		local beastOrbitSpeed = tbl42.BeastOrbitSpeed
		local n50 = os.clock() * beastOrbitSpeed
		local vector2 = Vector3.new
		local beastOrbitRadius = tbl42.BeastOrbitRadius
		local n51 = arg.Position.X + math.cos(n50) * beastOrbitRadius
		local beastHoverHeight = tbl42.BeastHoverHeight
		local n52 = tbl43.GetWaterHeight(arg.Position.Y) + beastHoverHeight
		local beastOrbitRadius2 = tbl42.BeastOrbitRadius
		return vector2(n51, n52, arg.Position.Z + math.sin(n50) * beastOrbitRadius2)
	end,
	CastSkills = function(arg)
		local v9, v10 = tbl20.WaitForAliveRoot()

		pcall(function()
			v9:PivotTo(CFrame.lookAt(v10.Position, arg.Position))
			tbl8.StopVelocity(v10)
		end)

		local v11, v12 = tbl20.EquipItem(tbl42.KarateName)
		if not v11 then
			return false, v12
		end
		local v13, v14 = tbl14.Enable()
		if not v13 then
			return false, v14
		end
		tbl15.SetAim(arg.Position)
		return tbl15.CastKeys(tbl42.SkillKeys, tbl42.SkillKeyDelay)
	end,
	FightSeaBeast = function(arg)
		local flag7 = false

		while tbl43.IsSeaBeastAlive(arg) do
			tbl20.WaitForAliveRoot()
			local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
			if not humanoidRootPart or not humanoidRootPart:IsA("BasePart") then
				return false, "The Sea Beast has no HumanoidRootPart"
			end
			flag7 = tbl43.ShouldRetreat(flag7)

			if flag7 then
				tbl15.SetAim(nil)
				local v9, v10 = tbl43.EscapeToSky(tbl43.GetSkyPosition(humanoidRootPart.Position))
				if not v9 then
					return false, v10
				end
			else
				local orbitTolerance = tbl42.OrbitTolerance
				local v9, v10 = tbl43.MoveDirect(tbl43.GetSeaBeastOrbitPosition(humanoidRootPart), orbitTolerance)
				if not v9 then
					return false, v10
				end
				local v11, v12 = tbl43.CastSkills(humanoidRootPart)
				if not v11 then
					return false, v12
				end
			end

			task.wait()
		end

		return true, nil
	end,
	KillSeaBeast = function()
		local v9, v10 = tbl43.BuySharkmanKarate()
		if not v9 then
			return false, v10
		end
		local v11, v12 = tbl43.LureSeaBeast()
		if not v11 then
			return false, v12
		end
		tbl43.LeaveBoat()
		tbl15.HookAim()
		local v13 = tbl43.FindSeaBeast()
		if not v13 then
			return false, "The Sea Beast disappeared before the fight started"
		end
		local v14, v15 = tbl43.FightSeaBeast(v13)
		tbl15.SetAim(nil)
		return v14, v15
	end,
}

local n50 = 5
local n51 = 2
local tbl44 = {}
local tbl45 = {}

local tbl46 = {
	{ Name = "Diamond", Position = Vector3.new(-1576.71, 198.59, 13.72) },
	{ Name = "Jeremy", Position = Vector3.new(2006.92, 448.95, 853.98) },
	{ Name = "Orbitus", Position = Vector3.new(-2172.73, 103.32, -4015.02) },
}

local tbl47

tbl47 = {
	ValidateConfiguredRaces = function()
		if type(pullLeverConfig.Race) ~= "table" then
			return nil, "Config.Race must be an array of race names"
		end

		if #pullLeverConfig.Race == 0 then
			return nil, "Config.Race is empty"
		end

		for i, v9 in ipairs(pullLeverConfig.Race) do
			if type(v9) ~= "string" or v9 == "" then
				return nil, "Config.Race[" .. tostring(i) .. "] must be a non-empty string"
			end

			if not tbl35[v9] then
				return nil, "Config.Race[" .. tostring(i) .. "] is not a known race: " .. v9
			end

			if not tbl45[v9] then
				return nil, "Race V3 quest is not implemented for " .. v9
			end
		end

		return pullLeverConfig.Race, nil
	end,
	GetNextRace = function()
		local v9, v10 = tbl47.ValidateConfiguredRaces()
		if not v9 then
			return nil, false, v10
		end
		local v11, v12 = tbl36.GetTitles()
		if not v11 then
			return nil, false, "Failed to check the V3 titles: " .. tostring(v12)
		end

		for _, v13 in ipairs(v9) do
			local v14 = tbl35[v13]
			if not v14 then
				return nil, false, "No Race V3 title is configured for " .. tostring(v13)
			end

			if not tbl36.HasTitleNamed(v11, v14) then
				return v13, false, nil
			end
		end

		return nil, true, nil
	end,
	RunWenlocktoadQuest = function(arg, arg2, arg3)
		local Wenlocktoad

		while true do
			local v9, v10 = tbl36.IsV3()

			if v9 == nil then
				return false, v10
			else
				if v9 then
					return true, arg .. " upgraded to V3"
				end
				local v11
				Wenlocktoad, v11 = tbl10.Invoke("Wenlocktoad", "1")
				if v11 then
					return false, v11
				end

				if Wenlocktoad == 0 then
					local Wenlocktoad2, v12 = tbl10.Invoke("Wenlocktoad", "2")
					if v12 then
						return false, v12
					end

					if arg3 then
						arg3()
					end
				elseif Wenlocktoad == 1 then
					local v12, v13 = arg2()
					if not v12 then
						return false, v13
					end
				else
					if Wenlocktoad ~= 2 then
						break
					end
					local Wenlocktoad2, v12 = tbl10.Invoke("Wenlocktoad", "3")
					if v12 then
						return false, v12
					end
					task.wait(1)
				end

				task.wait(0.25)
			end
		end

		return false, "Unexpected Wenlocktoad state for " .. arg .. ": " .. tostring(Wenlocktoad)
	end,
	FarmMinkChests = function()
		local v9 = nil
		local n52 = 0

		local v10, v11 = tbl25.Farm(function()
			local Wenlocktoad, v10 = tbl10.Invoke("Wenlocktoad", "1")

			if v10 then
				n52 += 1
				if n52 >= n50 then
					v9 = v10
					return true
				end
				warn(tostring(v10))
				return false
			end

			n52 = 0
			return Wenlocktoad ~= 1
		end, false)

		if v9 then
			return false, v9
		end

		if not v10 then
			return false, v11
		end
		return true, nil
	end,
	DoMink = function()
		if not tbl2[placeId] then
			return false, "The Mink V3 quest only works in the Second Sea"
		end
		tbl20.WaitForAliveRoot()
		local v9, v10 = tbl36.GetUpgradeData()
		if not v9 then
			return false, v10
		end
		local Mink, v11 = tbl36.HasV3Title("Mink")
		if Mink == nil then
			return false, "Failed to check the Mink V3 title: " .. tostring(v11)
		end

		if Mink then
			return true, "Mink V3 is already completed because the " .. tbl35.Mink .. " title was found"
		end
		local v12, v13 = tbl36.IsV3()
		if v12 == nil then
			return false, v13
		end

		if v12 and v9.Race.Value == "Mink" then
			return true, "Mink is already V3"
		end
		local Mink2, v14 = tbl36.EnsureRerollRace("Mink", v9)
		if not Mink2 then
			return false, v14
		end
		local v15, v16 = tbl33.RunQuest()
		if not v15 then
			return false, v16
		end
		local Mink3, v17 = tbl36.MeetsV3Requirements("Mink", v9)
		if not Mink3 then
			return false, v17
		end
		return tbl47.RunWenlocktoadQuest("Mink", tbl47.FarmMinkChests)
	end,
}

tbl45.Mink = tbl47.DoMink

tbl47.ResetKilledBosses = function()
	table.clear(tbl44)
end

tbl47.FindMissingHumanBosses = function()
	local v9 = nil

	for _, v10 in ipairs(tbl46) do
		if not tbl44[v10.Name] and not tbl26.Exists(v10.Name) then
			local tbl48 = v9 or {}
			tbl48[#tbl48 + 1] = v10.Name
			v9 = tbl48
		end
	end

	return v9
end

tbl47.KillHumanBoss = function(arg)
	local v9, v10, v11 = tbl26.Kill(arg.Name, arg.Position, tbl47.FindMissingHumanBosses)
	if v9 then
		return true, nil, nil
	end

	if v11 then
		return false, nil, v11
	end

	if not tbl26.Exists(arg.Name) then
		return false, nil, { arg.Name }
	end
	return false, "Failed to kill " .. arg.Name .. ": " .. tostring(v10), nil
end

tbl47.HopForMissingHumanBosses = function(arg)
	local str3 = table.concat(arg, ", ")
	local v9, v10 = tbl12.HopNormalServer()
	if not v9 then
		return false, "Missing Human V3 boss(es): " .. str3 .. " " .. tostring(v10)
	end
	return false, "Hopping to a low server because Human V3 boss(es) are missing: " .. str3
end

tbl47.ConfirmHumanBossCredit = function()
	local n52 = os.clock() + n51

	while true do
		local Wenlocktoad, v9 = tbl10.Invoke("Wenlocktoad", "1")

		if v9 then
			return false, v9
		else
			if Wenlocktoad ~= 1 then
				return true, nil
			end
			task.wait(0.25)
			if not (n52 <= os.clock()) then
				continue
			end
			break
		end
	end

	tbl18.Stop()
	local v9, v10 = tbl12.HopNormalServer()
	if not v9 then
		return false, "A Human V3 boss kill was not credited: " .. tostring(v10)
	end
	return false, "A Human V3 boss kill was not credited hopping to a low server"
end

tbl47.HuntHumanBosses = function()
	local v9 = tbl47.FindMissingHumanBosses()
	if v9 then
		return tbl47.HopForMissingHumanBosses(v9)
	end

	for _, v10 in ipairs(tbl46) do
		if not tbl44[v10.Name] then
			local v11, v12, v13 = tbl47.KillHumanBoss(v10)
			if v11 then
				tbl44[v10.Name] = true
				continue
			end

			if v13 then
				return tbl47.HopForMissingHumanBosses(v13)
			end
			return false, v12
		end
	end

	return tbl47.ConfirmHumanBossCredit()
end

tbl47.DoHuman = function()
	if not tbl2[placeId] then
		return false, "The Human V3 quest only works in the Second Sea"
	end
	tbl20.WaitForAliveRoot()
	local v9, v10 = tbl36.GetUpgradeData()
	if not v9 then
		return false, v10
	end
	local Human, v11 = tbl36.HasV3Title("Human")
	if Human == nil then
		return false, "Failed to check the Human V3 title: " .. tostring(v11)
	end

	if Human then
		return true, "Human V3 is already completed because the " .. tbl35.Human .. " title was found"
	end
	local v12, v13 = tbl36.IsV3()
	if v12 == nil then
		return false, v13
	end

	if v12 and v9.Race.Value == "Human" then
		return true, "Human is already V3"
	end
	local Human2, v14 = tbl36.EnsureRerollRace("Human", v9)
	if not Human2 then
		return false, v14
	end
	local v15, v16 = tbl33.RunQuest()
	if not v15 then
		return false, "Failed to upgrade Human to V2: " .. tostring(v16)
	end
	local Human3, v17 = tbl36.MeetsV3Requirements("Human", v9)
	if not Human3 then
		return false, v17
	end
	return tbl47.RunWenlocktoadQuest("Human", tbl47.HuntHumanBosses, tbl47.ResetKilledBosses)
end

tbl45.Human = tbl47.DoHuman

tbl47.LoadCyborgFruit = function()
	local v9, v10 = tbl38.LoadStoredFruit()
	if not v9 then
		return false, v10
	end
	task.wait(1)
	return true, nil
end

tbl47.DoCyborg = function()
	if not tbl2[placeId] then
		return false, "The Cyborg V3 quest only works in the Second Sea"
	end
	tbl20.WaitForAliveRoot()
	local v9, v10 = tbl36.GetUpgradeData()
	if not v9 then
		return false, v10
	end
	local Cyborg, v11 = tbl36.HasV3Title("Cyborg")
	if Cyborg == nil then
		return false, "Failed to check the Cyborg V3 title: " .. tostring(v11)
	end

	if Cyborg then
		return true, "Cyborg V3 is already completed because the " .. tbl35.Cyborg .. " title was found"
	end
	local v12, v13 = tbl38.EnsureRace(v9)
	if not v12 then
		return false, v13
	end
	local v14, v15 = tbl33.RunQuest()
	if not v14 then
		return false, "Failed to upgrade Cyborg to V2: " .. tostring(v15)
	end
	local Cyborg2, v16 = tbl36.MeetsV3Requirements("Cyborg", v9)
	if not Cyborg2 then
		return false, v16
	end
	return tbl47.RunWenlocktoadQuest("Cyborg", tbl47.LoadCyborgFruit)
end

tbl45.Cyborg = tbl47.DoCyborg

tbl47.CreateStateWatcher = function()
	local n52 = 0

	return function()
		local Wenlocktoad, v9 = tbl10.Invoke("Wenlocktoad", "1")

		if v9 then
			n52 += 1
			if n50 <= n52 then
				return false, v9
			end
			warn(tostring(v9))
			return false, nil
		end

		n52 = 0
		return Wenlocktoad ~= 1, nil
	end
end

tbl47.HuntGhoulPlayers = function()
	return tbl40.AttackPlayers(tbl47.CreateStateWatcher(), nil, "Ghoul")
end

tbl47.HuntSkypieaPlayers = function()
	return tbl40.AttackPlayers(tbl47.CreateStateWatcher(), "Skypiea", "Skypiea", true)
end

tbl47.RunV2QuestThenHop = function()
	local v9, v10, v11 = tbl33.RunQuest()
	if not v9 or not v11 then
		return v9, v10
	end
	local v12, v13 = tbl12.HopNormalServer()
	if v12 then
		return false, "Race upgraded to V2, " .. tostring(v13)
	end
	warn("Could not hop after the V2 upgrade: " .. tostring(v13))
	return true, v10
end

tbl47.DoGhoul = function()
	if not tbl2[placeId] then
		return false, "The Ghoul V3 quest only works in the Second Sea"
	end
	tbl20.WaitForAliveRoot()
	local v9, v10 = tbl36.GetUpgradeData()
	if not v9 then
		return false, v10
	end
	local Ghoul, v11 = tbl36.HasV3Title("Ghoul")
	if Ghoul == nil then
		return false, "Failed to check the Ghoul V3 title: " .. tostring(v11)
	end

	if Ghoul then
		return true, "Ghoul V3 is already completed because the " .. tbl35.Ghoul .. " title was found"
	end
	local Ghoul2, v12 = tbl36.MeetsV3Requirements("Ghoul", v9)
	if not Ghoul2 then
		return false, v12
	end
	local v13, v14 = tbl41.EnsureRace(v9)
	if not v13 then
		return false, v14
	end
	local v15, v16 = tbl36.IsV3()
	if v15 == nil then
		return false, v16
	end

	if v15 then
		return true, "Ghoul is already V3"
	end
	local v17, v18 = tbl47.RunV2QuestThenHop()
	if not v17 then
		return false, "Failed to upgrade Ghoul to V2: " .. tostring(v18)
	end
	return tbl47.RunWenlocktoadQuest("Ghoul", tbl47.HuntGhoulPlayers)
end

tbl45.Ghoul = tbl47.DoGhoul

tbl47.DoFishman = function()
	if not tbl2[placeId] then
		return false, "The Fishman V3 quest only works in the Second Sea"
	end
	tbl20.WaitForAliveRoot()
	local v9, v10 = tbl36.GetUpgradeData()
	if not v9 then
		return false, v10
	end
	local Fishman, v11 = tbl36.HasV3Title("Fishman")
	if Fishman == nil then
		return false, "Failed to check the Fishman V3 title: " .. tostring(v11)
	end

	if Fishman then
		return true, "Fishman V3 is already completed because the " .. tbl35.Fishman .. " title was found"
	end
	local v12, v13 = tbl36.IsV3()
	if v12 == nil then
		return false, v13
	end

	if v12 and v9.Race.Value == "Fishman" then
		return true, "Fishman is already V3"
	end
	local Fishman2, v14 = tbl36.EnsureRerollRace("Fishman", v9)
	if not Fishman2 then
		return false, v14
	end
	local v15, v16 = tbl33.RunQuest()
	if not v15 then
		return false, "Failed to upgrade Fishman to V2: " .. tostring(v16)
	end
	local Fishman3, v17 = tbl36.MeetsV3Requirements("Fishman", v9)
	if not Fishman3 then
		return false, v17
	end
	return tbl47.RunWenlocktoadQuest("Fishman", tbl43.KillSeaBeast)
end

tbl45.Fishman = tbl47.DoFishman

tbl47.DoSkypiea = function()
	if not tbl2[placeId] then
		return false, "The Skypiea V3 quest only works in the Second Sea"
	end
	tbl20.WaitForAliveRoot()
	local v9, v10 = tbl36.GetUpgradeData()
	if not v9 then
		return false, v10
	end
	local Skypiea, v11 = tbl36.HasV3Title("Skypiea")
	if Skypiea == nil then
		return false, "Failed to check the Skypiea V3 title: " .. tostring(v11)
	end

	if Skypiea then
		return true, "Skypiea V3 is already completed because the " .. tbl35.Skypiea .. " title was found"
	end
	local v12, v13 = tbl36.IsV3()
	if v12 == nil then
		return false, v13
	end

	if v12 and v9.Race.Value == "Skypiea" then
		return true, "Skypiea is already V3"
	end
	local Skypiea2, v14 = tbl36.EnsureRerollRace("Skypiea", v9)
	if not Skypiea2 then
		return false, v14
	end
	local v15, v16 = tbl33.RunQuest()
	if not v15 then
		return false, "Failed to upgrade Skypiea to V2: " .. tostring(v16)
	end
	local Skypiea3, v17 = tbl36.MeetsV3Requirements("Skypiea", v9)
	if not Skypiea3 then
		return false, v17
	end
	return tbl47.RunWenlocktoadQuest("Skypiea", tbl47.HuntSkypieaPlayers)
end

tbl45.Skypiea = tbl47.DoSkypiea
local v9 = v

local function fn7(arg)
	if v9 and v9.Step then
		pcall(v9.Step, arg)
	end
end

local function fn8(arg, arg2)
	if v9 and v9.Log then
		pcall(v9.Log, arg, arg2)
	end
end

local function fn9()
	local v10 = localPlayer
	local commF = ReplicatedStorage.Remotes.CommF_
	local request_ = syn and syn.request or flux and flux.request or request or http_request
	local str3 = "Blox Fruit"

	local ok, result = pcall(function()
		return getgenv().Config.Settings.ToolFarm
	end)

	if ok and type(result) == "string" and result ~= "" then
		str3 = result
	end

	local tween = nil

	local function fn10()
		local tbl48 = {}
		local bxor = bit32.bxor
		local band = bit32.band
		local lshift = bit32.lshift
		local rshift = bit32.rshift
		local lrotate = bit32.lrotate
		local str4 = "NIGHTHUB|"
		local n52 = 8
		local n53 = 4
		local n54 = 4294967296
		local tbl49 = { 1634760805, 857760878, 2036477234, 1797285236 }

		local function fn11(arg)
			local tbl50 = {}

			for i = 1, #arg, 2 do
				tbl50[#tbl50 + 1] = tonumber(arg:sub(i, i + 1), 16)
			end

			return tbl50
		end

		local function fn12(arg)
			local tbl50 = {}

			for i = 1, #arg do
				tbl50[i] = string.char(arg[i])
			end

			return table.concat(tbl50)
		end

		local function fn13(arg, arg2)
			return arg[arg2] + arg[arg2 + 1] * 256 + arg[arg2 + 2] * 65536 + arg[arg2 + 3] * 16777216
		end

		local function fn14(arg, arg2, arg3, arg4, arg5)
			arg[arg2] = (arg[arg2] + arg[arg3]) % n54
			arg[arg5] = lrotate(bxor(arg[arg5], arg[arg2]), 16)
			arg[arg4] = (arg[arg4] + arg[arg5]) % n54
			arg[arg3] = lrotate(bxor(arg[arg3], arg[arg4]), 12)
			arg[arg2] = (arg[arg2] + arg[arg3]) % n54
			arg[arg5] = lrotate(bxor(arg[arg5], arg[arg2]), 8)
			arg[arg4] = (arg[arg4] + arg[arg5]) % n54
			arg[arg3] = lrotate(bxor(arg[arg3], arg[arg4]), 7)
		end

		local function fn15(arg)
			for i = 1, 10 do
				fn14(arg, 1, 5, 9, 13)
				fn14(arg, 2, 6, 10, 14)
				fn14(arg, 3, 7, 11, 15)
				fn14(arg, 4, 8, 12, 16)
				fn14(arg, 1, 6, 11, 16)
				fn14(arg, 2, 7, 12, 13)
				fn14(arg, 3, 8, 9, 14)
				fn14(arg, 4, 5, 10, 15)
			end
		end

		local function fn16(arg, arg2, arg3)
			local tbl50 = { tbl49[1], tbl49[2], tbl49[3], tbl49[4] }

			for i = 0, 7 do
				tbl50[5 + i] = fn13(arg, 1 + 4 * i)
			end

			tbl50[13] = arg2 % n54

			for i = 0, 2 do
				tbl50[14 + i] = fn13(arg3, 1 + 4 * i)
			end

			return tbl50
		end

		local function fn17(arg, arg2, arg3)
			local v11 = fn16(arg, arg2, arg3)
			local tbl50 = {}

			for i = 1, 16 do
				tbl50[i] = v11[i]
			end

			fn15(tbl50)
			local tbl51 = {}

			for i = 1, 16 do
				local n55 = (tbl50[i] + v11[i]) % n54
				local n56 = (i - 1) * 4
				tbl51[n56 + 1] = band(n55, 255)
				tbl51[n56 + 2] = band(rshift(n55, 8), 255)
				tbl51[n56 + 3] = band(rshift(n55, 16), 255)
				tbl51[n56 + 4] = band(rshift(n55, 24), 255)
			end

			return tbl51
		end

		local function fn18(arg, arg2, arg3, arg4)
			local tbl50 = {}
			local n55 = 0

			while n55 < arg4 do
				local v11 = fn17(arg, arg3, arg2)

				for i = 1, 64 do
					if not (n55 >= arg4) then
						n55 += 1
						tbl50[n55] = v11[i]
						continue
					end

					break
				end

				arg3 += 1
			end

			return tbl50
		end

		local function fn19(arg, arg2, arg3)
			local v11 = fn16(arg, 4294967295, arg2)
			fn15(v11)
			local n55 = #arg3

			for i = 0, n55 + (16 - n55 % 16) % 16 - 1, 16 do
				for i2 = 0, 3 do
					local n56 = i + 4 * i2
					v11[i2 + 1] = bxor(v11[i2 + 1], (arg3[n56 + 1] or 0) + (arg3[n56 + 2] or 0) * 256 + (arg3[n56 + 3] or 0) * 65536 + (arg3[n56 + 4] or 0) * 16777216)
				end

				fn15(v11)
			end

			v11[1] = bxor(v11[1], n55)
			fn15(v11)
			local v12 = v11[1]
			local tbl50 = {}
			local v13 = band(v12, 255)
			local v14 = band(rshift(v12, 8), 255)
			local v15 = band(rshift(v12, 16), 255)
			local v16 = rshift(v12, 24)
			tbl50[1] = v13
			tbl50[2] = v14
			tbl50[3] = v15

			do
				local values = table.pack(band(v16, 255))
				table.move(values, 1, values.n, 4, tbl50)
			end

			return tbl50
		end

		local tbl50 = {}

		local function fn20(arg)
			local str5 = table.concat(arg, ",")
			if tbl50[str5] then
				return tbl50[str5]
			end
			local v11 = fn18(arg, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, 11259375, 128)
			local tbl51 = {}

			for i = 1, 64 do
				tbl51[i] = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"):sub(i, i)
			end

			for i = 64, 2, -1 do
				local n55 = i - 1
				local n56 = (v11[2 * n55 + 1] * 256 + v11[2 * n55 + 2]) % i + 1
				local v12 = tbl51[i]
				tbl51[i] = tbl51[n56]
				tbl51[n56] = v12
			end

			local str6 = table.concat(tbl51)
			tbl50[str5] = str6
			return str6
		end

		local function fn21(arg, arg2)
			local tbl51 = {}

			for i = 1, 64 do
				tbl51[arg2:sub(i, i)] = i - 1
			end

			local tbl52 = {}

			for i = 1, #arg do
				local v11 = tbl51[arg:sub(i, i)]
				if v11 == nil then
					return nil
				end
				tbl52[#tbl52 + 1] = v11
			end

			local tbl53 = {}

			for i = 1, #tbl52, 4 do
				local v11 = tbl52[i]
				local v12 = tbl52[i + 1]
				local v13 = tbl52[i + 2]
				local v14 = tbl52[i + 3]
				if v12 == nil then
					return nil
				end
				tbl53[#tbl53 + 1] = band(lshift(v11, 2) + rshift(v12, 4), 255)

				if v13 ~= nil then
					tbl53[#tbl53 + 1] = band(lshift(band(v12, 15), 4) + rshift(v13, 2), 255)
				end

				if v14 ~= nil then
					tbl53[#tbl53 + 1] = band(lshift(band(v13, 3), 6) + v14, 255)
				end
			end

			return tbl53
		end

		local v11 = fn11("8992d555ed7846a562b058523100fbd0e59b5f6f28e98003230ffb4d9db60411")

		tbl48.decode = function(arg, arg2)
			local v12 = arg2 or v11
			if type(arg) ~= "string" or arg:sub(1, #str4) ~= str4 then
				return nil, "bad prefix"
			end
			local v13 = fn21(arg:sub(#str4 + 1), fn20(v12))
			if not v13 or #v13 < n52 + n53 then
				return nil, "malformed"
			end
			local tbl51 = {}

			for i = 1, 8 do
				tbl51[i] = v13[i]
			end

			for i = n52 + 1, 12 do
				tbl51[i] = 0
			end

			local tbl52 = {}

			for i = n52 + n53 + 1, #v13 do
				tbl52[i - n52 - n53] = v13[i]
			end

			local v14 = fn19(v12, tbl51, tbl52)
			local n55 = 0

			for i = 1, 4 do
				n55 += v14[i] == v13[n52 + i] and 0 or 1
			end

			if n55 ~= 0 then
				return nil, "bad tag"
			end
			local v15 = fn18(v12, tbl51, 1, #tbl52)
			local tbl53 = {}

			for i = 1, #tbl52 do
				tbl53[i] = bxor(tbl52[i], v15[i])
			end

			return fn12(tbl53)
		end

		tbl48.decodeJobId = function(arg, arg2)
			local v12, v13 = tbl48.decode(arg, arg2)
			if not v12 then
				return nil, v13
			end

			if not v12:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
				return nil, "not a JobId"
			end
			return v12
		end

		return tbl48
	end

	local v11 = fn10()
	local tbl48 = {}

	local function fn11()
		pcall(function()
			writefile("pull_lever_api.json", HttpService:JSONEncode(tbl48))
		end)
	end

	local function fn12()
		local ok2, result2 = pcall(function()
			return HttpService:JSONDecode(readfile("pull_lever_api.json"))
		end)

		if ok2 and type(result2) == "table" then
			return result2
		end
		fn11()
		return {}
	end

	tbl48 = fn12()
	local ItemId = nil
	local ItemReplicationService = nil
	local KEYS = nil

	local function fn13()
		if ItemReplicationService then
			return true
		end

		pcall(function()
			ItemId = require(ReplicatedStorage.Economy.ItemId)
			ItemReplicationService = require(ReplicatedStorage.ItemReplicationService)
			KEYS = require(ReplicatedStorage.ItemReplicationService.KEYS)
		end)

		return ItemReplicationService ~= nil
	end

	local function fn14(arg)
		if not fn13() then
			return false
		end

		if not ItemReplicationService.IsInitialized then
			return false
		end
		local flag7 = false

		pcall(function()
			local items = ItemReplicationService:GetItems(KEYS.QUANTITY)

			for _, item in pairs(items) do
				local ok2, result2 = pcall(function()
					return ItemId.getDataFromId(item.ItemId):unwrap()
				end)

				if ok2 and result2 and result2.StorageKey == arg and item.Value >= 1 then
					flag7 = { Name = result2.StorageKey, Count = item.Value or 0, Type = result2.Type }
					break
				end
			end
		end)

		return flag7
	end

	local function fn15(...)
		return commF:InvokeServer(...)
	end

	local function fn16(arg, arg2)
		local function fn17(arg3)
			if typeof(arg3) == "CFrame" then
				return arg3
			end

			if typeof(arg3) == "Vector3" then
				return CFrame.new(arg3)
			end

			if typeof(arg3) == "Instance" and arg3:IsA("Model") then
				return arg3:GetPivot()
			end

			if typeof(arg3) == "Instance" and arg3:IsA("Part") then
				return arg3.CFrame
			end
		end

		arg2 = arg2 or v10.Character.PrimaryPart
		return (fn17(arg).Position - fn17(arg2).Position).Magnitude
	end

	local function fn17()
		return workspace.Map:FindFirstChild("MysticIsland")
	end

	local fn18 = nil

	fn18 = function(arg)
		local function fn19(arg2)
			local vector2 = Vector3.zero
			local huge = math.huge
			local str4 = ""

			for k, v12 in pairs({
				Mansion = Vector3.new(-12550, 337, -7476),
				["Castle On The Sea"] = Vector3.new(-5073, 314, -3152),
				["Hydra Island"] = Vector3.new(5681, 1013, -313),
				["Temple Of Time"] = Vector3.new(28294, 14896, 103),
				["Great Tree"] = Vector3.new(3028, 2280, -7324),
			}) do
				if vector2 ~= v12 and fn16(v12, arg2) <= huge then
					huge = fn16(v12, arg2)
					vector2 = v12
					str4 = k
				end
			end

			if str4 ~= "Great Tree" and not fn14("Valkyrie Helm") then
				return
			end
			return vector2, str4
		end

		local function fn20()
			if tween then
				tween:Cancel()
			end
		end

		pcall(function()
			if not v10.Character.Head:FindFirstChild("BodyVelocity") then
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Name = "BodyVelocity"
				bodyVelocity.Velocity = Vector3.zero
				bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				bodyVelocity.P = 1500
				bodyVelocity.Parent = v10.Character.Head
			end
		end)

		local v12 = next
		local descendants, v13 = v10.Character:GetDescendants()

		for _, v14 in v12, descendants, v13 do
			if v14:IsA("Part") or v14:IsA("BasePart") then
				v14.CanCollide = false
			end
		end

		v10.Character.Humanoid.Sit = false
		local v14 = fn16(arg)

		if workspace:GetAttribute("MAP") == "Sea3" and fn16(Vector3.new(28609, 14896, 106), arg) > 3000 and fn16(Vector3.new(28609, 14896, 106)) <= 3000 then
			if fn16(CFrame.new(28610, 14897, 105)) <= 10 then
				fn15("RaceV4Progress", "Check")
				fn15("RaceV4Progress", "TeleportBack")
				wait(0.5)
			else
				fn18(CFrame.new(28610, 14897, 105))
			end

			return
		end

		if v14 <= 100 then
			fn20()
			v10.Character:SetPrimaryPartCFrame(arg)
		else
			local v15, v16 = fn19(arg)

			if v15 and (v15 - arg.Position).Magnitude + 250 <= v14 and v14 >= 3000 then
				fn20()

				if v16 ~= "Great Tree" then
					fn15("requestEntrance", v15)
				else
					fn15("requestEntrance", Vector3.new(28294, 14896, 103))
				end

				wait()
				return
			end

			v10.Character.PrimaryPart.CFrame = CFrame.new(v10.Character.PrimaryPart.CFrame.X, arg.Y, v10.Character.PrimaryPart.CFrame.Z)
			tween = game:GetService("TweenService"):Create(v10.Character.PrimaryPart, TweenInfo.new(v14 / 325, Enum.EasingStyle.Linear), { CFrame = arg })
			tween:Play()
		end
	end

	local function fn19(arg)
		return arg and arg.Parent and not arg:FindFirstChild("VehicleSeat") and arg:FindFirstChild("Humanoid") and arg.Humanoid.Health > 0 and arg:FindFirstChild("HumanoidRootPart")
	end

	local function fn20(arg)
		for _, v12 in pairs({ workspace.Enemies, ReplicatedStorage }) do
			local v13 = next
			local children, v14 = v12:GetChildren()

			for _, v15 in v13, children, v14 do
				if v15:IsA("Model") and (typeof(arg) == "string" and (v15.Name == arg or string.find(arg, v15.Name)) or typeof(arg) == "table" and table.find(arg, v15.Name)) and fn19(v15) then
					return v15
				end
			end
		end
	end

	local function fn21(arg)
		local v12 = next
		local children, v13 = v10.Backpack:GetChildren()
		local v14 = nil

		for _, v15 in v12, children, v13 do
			local isTool = v15:IsA("Tool")

			if isTool then
				isTool = v15.ToolTip == (arg or "Melee")
			end

			if isTool then
				v14 = v15
				break
			else
				v14 = nil
			end
		end

		if v14 and v14.Parent == v10.Backpack and v10.Character:FindFirstChild("Humanoid") then
			v10.Character.Humanoid:EquipTool(v14)
		end
	end

	local function fn22()
		if not v10.Character:FindFirstChild("HasBuso") then
			fn15("Buso")
		end
	end

	local function fn23(arg)
		if not table.find(tbl48, game.JobId) then
			table.insert(tbl48, game.JobId)
			fn11()
		end

		local ok2, result2 = pcall(function()
			return request_({ Url = arg, Method = "GET" })
		end)

		local tbl49 = {}

		if ok2 then
			local data = HttpService:JSONDecode(result2.Body)

			if data and data.data then
				if data.count > 0 then
					for _, v12 in pairs(data.data) do
						local v13 = v11.decodeJobId(v12.JobId)

						if v13 and v12.Players < 12 and game.JobId ~= v13 and not table.find(tbl48, v13) and v12.PlaceId == game.PlaceId then
							table.insert(tbl49, { JobId = v13, Age = v12.Age })
						end
					end

					table.sort(tbl49, function(arg2, arg3)
						return arg2.Age < arg3.Age
					end)

					for _, v12 in next, tbl49, nil do
						ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", v12.JobId)
						wait(0.5)
					end
				end
			end
		end

		wait(1)
	end

	local function fn24()
		if workspace.Map:FindFirstChild("MysticIsland") then
			for _, child in pairs(workspace.Map.MysticIsland:GetChildren()) do
				if child:IsA("MeshPart") and child.MeshId == "rbxassetid://10153114969" then
					return child
				end
			end
		end
	end

	local function fn25()
		if workspace.Map:FindFirstChild("MysticIsland") then
			for _, descendant in pairs(workspace.Map.MysticIsland:GetDescendants()) do
				if descendant:IsA("MeshPart") and descendant.MeshId == "rbxassetid://6105779869" then
					return descendant
				end
			end
		end
	end

	local function fn26()
		local humanoidRootPart = v10.Character and v10.Character:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart and not humanoidRootPart:FindFirstChild("Agility") then
			local particleEmitter = Instance.new("ParticleEmitter")
			particleEmitter.Acceleration = Vector3.zero
			particleEmitter.Archivable = true
			particleEmitter.Drag = 20
			particleEmitter.EmissionDirection = Enum.NormalId.Top
			particleEmitter.Enabled = true
			particleEmitter.Lifetime = NumberRange.new(0, 0)
			particleEmitter.LightInfluence = 0
			particleEmitter.LockedToPart = true
			particleEmitter.Name = "Agility"
			particleEmitter.Rate = 500
			local new = NumberSequenceKeypoint.new
			particleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new(1, 4) })
			particleEmitter.RotSpeed = NumberRange.new(9999, 99999)
			particleEmitter.Rotation = NumberRange.new(0, 0)
			particleEmitter.Speed = NumberRange.new(30, 30)
			particleEmitter.SpreadAngle = Vector2.new(0, 0)
			particleEmitter.Texture = "rbxassetid://243098098"
			particleEmitter.VelocityInheritance = 0
			particleEmitter.ZOffset = 2
			particleEmitter.Transparency = NumberSequence.new(0)
			particleEmitter.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0))
			particleEmitter.Parent = humanoidRootPart
		end
	end

	local function fn27()
		if not workspace.Map:FindFirstChild("Temple of Time") then
			pcall(function()
				ReplicatedStorage.MapStash["Temple of Time"].Parent = workspace.Map
			end)
		end

		if workspace:GetAttribute("MAP") ~= "Sea3" then
			pcall(function()
				commF:InvokeServer("TravelZou")
			end)
		end
	end

	return function()
		fn27()

		while task.wait() do
			local flag7 = false

			pcall(function()
				if commF:InvokeServer("CheckTempleDoor") then
					fn7("Pull Lever completed")
					flag7 = true
					return
				end

				if fn14("Mirror Fractal") and fn14("Valkyrie Helm") then
					local response = commF:InvokeServer("RaceV4Progress", "Check")

					if response == 1 then
						fn7("RaceV4Progress: Begin")
						fn15("RaceV4Progress", "Begin")
					elseif response == 2 then
						fn7("RaceV4Progress: Teleport")

						if fn16(CFrame.new(3033, 2281, -7324).Position) <= 10 then
							fn15("RaceV4Progress", "Teleport")
						else
							fn18(CFrame.new(3033, 2281, -7324))
						end
					elseif response == 3 then
						fn7("RaceV4Progress: Continue")
						fn15("RaceV4Progress", "Continue")
					else
						fn7("Pull Lever")

						if fn17() then
							local cFrame = fn25() and fn25().CFrame

							if not cFrame then
								cFrame = workspace.Map:FindFirstChild("MysticIsland"):GetPivot() * CFrame.new(0, 500, 0)
							end

							local v12 = fn24()

							if v12 then
								if v12.Transparency == 0 and not v12.CanCollide then
									while true do
										wait()
										fn18(v12.CFrame)
										if not (not v12 or v12.Transparency == 1 or not v12.CanCollide) then
											continue
										end
										break
									end
								elseif fn16(cFrame) <= 15 then
									if Lighting.ClockTime >= 18 or Lighting.ClockTime < 5 then
										fn7("Activate ability under the moon")

										while true do
											task.wait()
											local position = workspace.CurrentCamera.CFrame.Position
											workspace.CurrentCamera.CFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + position)

											if commF:InvokeServer("Wenlocktoad", "1") == -2 then
												ReplicatedStorage.Remotes.CommE:FireServer("ActivateAbility")
											else
												fn26()
											end

											if not (v12.Transparency == 0 and v12.CanCollide == false or not fn17()) then
												continue
											end
											break
										end
									else
										fn18(cFrame)
									end
								else
									fn18(cFrame)
								end
							else
								fn18(cFrame)
							end
						else
							fn7("Hop - find Mirage Island")
							fn23("http://163.223.9.144/boss/Mirage")
						end
					end
				elseif not fn14("Valkyrie Helm") then
					local v12 = fn20({ "rip_indra", "rip_indra True Form" })

					if v12 then
						fn7("Farm rip_indra for Valkyrie Helm")
						getgenv().PullLeverConfig.FarmTarget = v12

						while true do
							task.wait()
							fn22()
							fn21(str3)
							fn18(CFrame.new(v12.HumanoidRootPart.Position + Vector3.new(0, 20, 0), v12.HumanoidRootPart.Position))
							if not (not v12 or not fn19(v12) or fn14("Valkyrie Helm")) then
								continue
							end
							break
						end

						getgenv().PullLeverConfig.FarmTarget = nil
					else
						fn7("Hop - find Rip Indra")
						fn23("http://163.223.9.144/boss/RipIndra")
					end
				else
					local doughKing = fn20("Dough King")

					if doughKing then
						fn7("Farm Dough King for Mirror Fractal")
						getgenv().PullLeverConfig.FarmTarget = doughKing

						while true do
							task.wait()

							if fn16(doughKing.HumanoidRootPart.Position) <= 1500 then
								fn22()
								fn21(str3)
								fn18(CFrame.new(doughKing.HumanoidRootPart.Position + Vector3.new(0, 20, 0), doughKing.HumanoidRootPart.Position))
							elseif workspace.Map:FindFirstChild("CakeLoaf") and workspace.Map.CakeLoaf:FindFirstChild("BigMirror") and workspace.Map.CakeLoaf.BigMirror:FindFirstChild("Main") then
								if tween then
									tween:Cancel()
								end

								firetouchinterest(v10.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 0)
								task.wait(0.1)
								firetouchinterest(v10.Character.HumanoidRootPart, workspace.Map.CakeLoaf.BigMirror.Main, 1)
							else
								fn18(CFrame.new(-2124, 69, -12401))
							end

							if not (not doughKing or not fn19(doughKing) or fn14("Mirror Fractal")) then
								continue
							end
							break
						end

						getgenv().PullLeverConfig.FarmTarget = nil
					else
						fn7("Hop - find Dough King")
						fn23("http://163.223.9.144/boss/DoughKing")
					end
				end
			end)

			if flag7 then
				if v9 and v9.Complete then
					pcall(v9.Complete)
				end

				break
			else
			end
		end
	end
end

local v10 = fn9()

local function fn10()
	local data = localPlayer:FindFirstChild("Data")
	data = data and data:FindFirstChild("Race")
	return data and data.Value or nil
end

local function fn11()
	local tbl48 = { Enabled = false }
	local v11 = localPlayer
	local v12 = ReplicatedStorage
	local sendHitsToServer = nil

	pcall(function()
		local v13 = next
		local children, v14 = v11:WaitForChild("PlayerScripts"):GetChildren()

		for _, v15 in v13, children, v14 do
			if v15:IsA("LocalScript") then
				local ok, result = pcall(getsenv, v15)

				if ok and typeof(result) == "table" and result._G and result._G.SendHitsToServer then
					sendHitsToServer = result._G.SendHitsToServer
				end
			end
		end
	end)

	local flag7 = false

	pcall(function()
		flag7 = require(v12.Modules:WaitForChild("Flags")).COMBAT_REMOTE_THREAD or false
	end)

	local function fn12(arg)
		return arg and arg.Parent and not arg:FindFirstChild("VehicleSeat") and arg:FindFirstChild("Humanoid") and arg.Humanoid.Health > 0 and arg:FindFirstChild("HumanoidRootPart")
	end

	local function fn13()
		local pullLeverConfig3 = getgenv().PullLeverConfig
		pullLeverConfig3 = pullLeverConfig3 and pullLeverConfig3.FarmTarget
		if pullLeverConfig3 and typeof(pullLeverConfig3) == "Instance" and pullLeverConfig3.Parent and fn12(pullLeverConfig3) then
			return pullLeverConfig3
		end
		return nil
	end

	local function fn14(arg)
		local tool = arg:FindFirstChildOfClass("Tool")
		if tool then
			return tool
		end
		local humanoid = arg:FindFirstChildOfClass("Humanoid")
		local backpack = v11:FindFirstChildOfClass("Backpack")
		if not (humanoid and backpack) then
			return nil
		end
		local tool2 = nil
		local v13 = next
		local children, v14 = backpack:GetChildren()

		for _, v15 in v13, children, v14 do
			if v15:IsA("Tool") and v15.ToolTip == "Melee" then
				tool2 = v15
				break
			end
		end

		tool2 = tool2 or backpack:FindFirstChildOfClass("Tool")

		if tool2 then
			pcall(function()
				humanoid:EquipTool(tool2)
			end)
		end

		return arg:FindFirstChildOfClass("Tool")
	end

	local function fn15()
		local v13 = fn13()
		if not v13 then
			return
		end
		local character = v11.Character
		if not character then
			return
		end
		local head = v13:FindFirstChild("Head") or v13:FindFirstChild("HumanoidRootPart")
		if not head then
			return
		end
		local v14 = fn14(character)
		if not v14 then
			return
		end

		if v14.ToolTip == "Blox Fruit" then
			local leftClickRemote = v14:FindFirstChild("LeftClickRemote")

			if leftClickRemote and leftClickRemote:IsA("RemoteEvent") then
				leftClickRemote:FireServer(Vector3.new(0, -500, 0), math.random(1, 3), true)
				task.wait(0.01)
				leftClickRemote:FireServer(false)
			end
		else
			v12.Modules.Net:WaitForChild("RE/RegisterAttack"):FireServer(0)
			local tbl49 = { { v13, head } }

			if flag7 and sendHitsToServer then
				sendHitsToServer(head, tbl49)
			else
				v12.Modules.Net:WaitForChild("RE/RegisterHit"):FireServer(head, tbl49)
			end
		end
	end

	task.spawn(function()
		while task.wait() do
			if tbl48.Enabled then
				pcall(fn15)
			end
		end
	end)

	tbl48.Start = function()
		tbl48.Enabled = true
	end

	tbl48.Stop = function()
		tbl48.Enabled = false
	end

	return tbl48
end

local v11 = fn11()

task.spawn(function()
	local function fn12()
		local str3 = "Pirates"

		pcall(function()
			local config = getgenv().Config

			if config and config.Settings and type(config.Settings.Team) == "string" then
				str3 = config.Settings.Team
			end
		end)

		if localPlayer.Team ~= nil and not localPlayer.Neutral then
			return
		end
		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		local commF = remotes and remotes:FindFirstChild("CommF_")
		if not commF then
			return
		end
		fn8("No team detected - joining " .. str3, "Travel")
		local n52 = tick() + 30

		while (localPlayer.Team == nil or localPlayer.Neutral) and tick() < n52 do
			pcall(function()
				commF:InvokeServer("SetTeam2", str3)
			end)

			local now = tick()

			while true do
				task.wait(0.2)
				if not (localPlayer.Team ~= nil and not localPlayer.Neutral or tick() - now > 3) then
					continue
				end
				break
			end
		end

		if localPlayer.Team ~= nil and not localPlayer.Neutral then
			fn8("Joined team " .. tostring(localPlayer.Team), "Success")

			pcall(function()
				local n53 = tick() + 15

				while true do
					task.wait(0.1)
					if not (localPlayer.Character and localPlayer.Character:IsDescendantOf(workspace.Characters) or tick() > n53) then
						continue
					end
					break
				end
			end)
		else
			fn8("Team join timed out", "Warning")
		end
	end

	pcall(function()
		if v and v.Start then
			v.Start()
		end
	end)

	pcall(function()
		if v and v.Reset then
			v.Reset()
		end
	end)

	pcall(function()
		if v and v.Theme then
			v.Theme(Color3.fromRGB(186, 104, 255))
		end
	end)

	fn8("Night Hub - Pull Lever started", "Info")
	fn12()
	local flag7 = true

	pcall(function()
		if getgenv().Config.Settings.FastAttack == false then
			flag7 = false
		end
	end)

	if flag7 then
		v11.Start()
		fn8("Fast Attack enabled", "Combat")
	end

	local v12 = fn10()

	if v12 then
		pullLeverConfig.Race = { v12 }
		fn8("Detected race: " .. tostring(v12), "Info")
	end

	local flag8 = tbl36.IsV3()

	if flag8 == nil then
		flag8 = false
	end

	if not flag8 and v12 and tbl45[v12] then
		fn7("No V3 yet - running 6v3 for " .. v12)
		fn8("Starting Race V3 quest for " .. v12, "Trial")
		local v13 = tbl45[v12]

		while tbl36.IsV3() ~= true do
			local ok, result, result2 = pcall(v13)

			if not ok then
				fn8("V3 quest error: " .. tostring(result), "Error")
				task.wait(3)
				continue
			else
				if result2 ~= nil then
					fn8(tostring(result2), result and "Success" or "Warning")
				end

				if not result then
					task.wait(2)
					continue
				end
			end

			break
		end

		fn8("Race V3 obtained", "Success")
	elseif not v12 then
		fn8("Could not read race data - skipping 6v3", "Warning")
	elseif not tbl45[v12] then
		fn8("No 6v3 quest for race " .. tostring(v12) .. " - skipping", "Warning")
	else
		fn8("Already V3 - going to pull lever", "Info")
	end

	fn7("Pulling lever at Temple of Time")
	fn8("Pull Lever routine engaged", "Working")
	v10()
end)
