-- ez crack skid night hub 😂
local str, str2, n, n2, n3, autoResume, bypassTeleport, str3, str4, str5
local ReplicatedStorage, TweenService, UserInputService, RunService, CollectionService, HttpService, Workspace, localPlayer, commF, reRegisterAttack
local reRegisterHit, fn, nightHubDBDK, flag, str6, flag2, request_, stats, n4, fn2
local fn3, chests, tbl, tbl2, tbl3, tbl4, gothamBold, gothamMedium, gotham, fn4
local fn5, fn6, fn7, tbl5, fn8, ScreenGui

do
	local str7 = tostring(getgenv().Boss or "Darkbeard")
	str = tostring(getgenv().Weapon or "Melee")
	str2 = tostring(getgenv().Team or "Pirates")
	n = tonumber(getgenv().ChestLimit) or 30
	n2 = tonumber(getgenv().TweenSpeed) or 180
	n3 = tonumber(getgenv().TweenInstance) or 50
	autoResume = getgenv().AutoResume
	bypassTeleport = getgenv().BypassTeleport
	local flag3 = getgenv().ResetStats == true

	if autoResume == nil then
		autoResume = true
	end

	if bypassTeleport == nil then
		bypassTeleport = true
	end

	if str7:lower():find("dough") then
		str3 = "Dough King"
	else
		str3 = "Darkbeard"
	end

	str4 = str3 == "Darkbeard" and "Sea2" or "Sea3"
	str5 = str3 == "Darkbeard" and "Sea 2" or "Sea 3"
	local Players = game:GetService("Players")
	ReplicatedStorage = game:GetService("ReplicatedStorage")
	TweenService = game:GetService("TweenService")
	UserInputService = game:GetService("UserInputService")
	RunService = game:GetService("RunService")
	CollectionService = game:GetService("CollectionService")
	HttpService = game:GetService("HttpService")
	Workspace = game:GetService("Workspace")
	localPlayer = Players.LocalPlayer
	local playerGui = localPlayer:WaitForChild("PlayerGui")
	commF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
	local net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
	reRegisterAttack = net:WaitForChild("RE/RegisterAttack")
	reRegisterHit = net:WaitForChild("RE/RegisterHit")

	if str2 ~= "Pirates" and str2 ~= "Marines" then
		str2 = "Pirates"
	end

	local function fn9(arg)
		local team = localPlayer.Team
		return team ~= nil and team.Name == arg
	end

	local function fn10()
		if type(getconnections) ~= "function" then
			return
		end
		local mainMinimal = playerGui:FindFirstChild("Main (minimal)")
		mainMinimal = mainMinimal and mainMinimal:FindFirstChild("ChooseTeam")
		mainMinimal = mainMinimal and mainMinimal:FindFirstChild("Container")
		mainMinimal = mainMinimal and mainMinimal:FindFirstChild(str2)
		mainMinimal = mainMinimal and mainMinimal:FindFirstChild("Frame")
		mainMinimal = mainMinimal and mainMinimal:FindFirstChild("TextButton")
		if not mainMinimal then
			return
		end

		for _, v in pairs(getconnections(mainMinimal.Activated)) do
			v.Function()
		end
	end

	fn = function(arg)
		if fn9(str2) then
			return true
		end
		local n5 = os.clock() + (arg or 10)

		while true do
			pcall(commF.InvokeServer, commF, "SetTeam", str2)

			if fn9(str2) then
				task.wait(5)
				return true
			else
				pcall(fn10)
				if fn9(str2) then
					task.wait(5)
					return true
				end
				task.wait(0.5)
				if not (n5 <= os.clock()) then
					continue
				end
				break
			end
		end

		return fn9(str2)
	end

	if localPlayer.Team == nil then
		fn()
	end

	if getgenv().NightHubDBDK then
		pcall(function()
			getgenv().NightHubDBDK.Stop()
		end)
	end

	nightHubDBDK = {}
	flag = false
	getgenv().NightHubDBDK = nightHubDBDK
	str6 = "http://163.223.9.144/boss/"
	local flag4 = type(writefile) == "function"
	flag2 = type(readfile) == "function" and type(isfile) == "function"
	request_ = type(http) == "table" and http.request or http_request or request
	stats = { Elapsed = 0, Boss = 0, Chests = 0 }
	local now = os.clock()
	n4 = 0

	local function fn11()
		if flag3 then
			if flag4 then
				pcall(writefile, "NightHub_DBDK_Stats.json", "{}")
			end

			return
		end

		if not flag2 then
			return
		end
		local flag5 = false

		pcall(function()
			flag5 = isfile("NightHub_DBDK_Stats.json")
		end)

		if not flag5 then
			return
		end
		local ok, result = pcall(readfile, "NightHub_DBDK_Stats.json")
		if not ok or type(result) ~= "string" then
			return
		end

		local ok2, result2 = pcall(function()
			return HttpService:JSONDecode(result)
		end)

		if not ok2 or type(result2) ~= "table" then
			return
		end

		if result2.UserId ~= localPlayer.UserId then
			return
		end
		stats.Elapsed = tonumber(result2.Elapsed) or 0
		stats.Boss = tonumber(result2.Boss) or 0
		stats.Chests = tonumber(result2.Chests) or 0
	end

	fn2 = function()
		return stats.Elapsed + os.clock() - now
	end

	fn3 = function()
		if not flag4 then
			return
		end

		pcall(function()
			writefile("NightHub_DBDK_Stats.json", HttpService:JSONEncode({ UserId = localPlayer.UserId, Elapsed = fn2(), Boss = stats.Boss, Chests = stats.Chests }))
		end)
	end

	fn11()
	chests = stats.Chests

	tbl = {
		Title = "Night Hub",
		Accent = Color3.fromRGB(122, 108, 255),
		Background = Color3.fromRGB(0, 0, 0),
		Transparency = 0.08,
		Width = 440,
		Height = 300,
		HeaderHeight = 62,
		ToggleKey = Enum.KeyCode.RightControl,
	}

	tbl2 = {
		Idle = { Label = "Idle", Color = Color3.fromRGB(142, 142, 147) },
		Running = { Label = "Running", Color = Color3.fromRGB(48, 209, 88) },
		Paused = { Label = "Paused", Color = Color3.fromRGB(255, 179, 64) },
		Error = { Label = "Error", Color = Color3.fromRGB(255, 69, 58) },
	}

	tbl3 = {
		{ Key = "time", Label = "TIME ELAPSED", Value = "00:00:00" },
		{ Key = "boss", Label = "BOSS KILLED", Value = "0" },
		{ Key = "status", Label = "STATUS", Value = "Idle", Dot = true },
		{ Key = "chests", Label = "CHESTS", Value = "0 / " .. n },
	}

	tbl4 = {
		Enter = TweenInfo.new(0.55, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		Exit = TweenInfo.new(0.26, Enum.EasingStyle.Quart, Enum.EasingDirection.In),
		Snap = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
		Micro = TweenInfo.new(0.13, Enum.EasingStyle.Sine, Enum.EasingDirection.Out),
		Spring = TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
		Pop = TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		Resize = TweenInfo.new(0.42, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
		Glow = TweenInfo.new(1.4, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut),
	}

	gothamBold = Enum.Font.GothamBold
	gothamMedium = Enum.Font.GothamMedium
	gotham = Enum.Font.Gotham

	fn4 = function(arg, arg2, arg3)
		local tween = TweenService:Create(arg, arg2, arg3)
		tween:Play()
		return tween
	end

	fn5 = function(arg, arg2, arg3)
		local instance = Instance.new(arg)
		local v = pairs
		arg2 = arg2 or {}
		local v2 = nil

		for k, v3 in v(arg2) do
			if k == "Parent" then
				v2 = v3
			else
				instance[k] = v3
			end
		end

		local v3 = ipairs
		arg3 = arg3 or {}

		for _, v4 in v3(arg3) do
			v4.Parent = instance
		end

		instance.Parent = v2
		return instance
	end

	fn6 = function(arg)
		return fn5("UICorner", { CornerRadius = UDim.new(0, arg) })
	end

	fn7 = function(arg, arg2, arg3)
		return fn5("UIStroke", {
			Color = arg,
			Transparency = arg2,
			Thickness = arg3 or 1,
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		})
	end

	local hui = playerGui

	pcall(function()
		if type(gethui) == "function" then
			hui = gethui()
		end
	end)

	for _, v in ipairs({ "NightHubHUD", "ModernHUD" }) do
		local v2 = hui:FindFirstChild(v)

		if v2 then
			v2:Destroy()
		end

		local v3 = playerGui:FindFirstChild(v)

		if v3 then
			v3:Destroy()
		end
	end

	tbl5 = {}

	fn8 = function(arg, arg2)
		local connection = arg:Connect(arg2)
		table.insert(tbl5, connection)
		return connection
	end

	ScreenGui = fn5("ScreenGui", {
		Name = "NightHubHUD",
		Parent = hui,
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		DisplayOrder = 999,
	})
end

local Frame

Frame = fn5("Frame", {
	Name = "Root",
	Parent = ScreenGui,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.fromOffset(tbl.Width, tbl.Height),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
})

local UIScale
UIScale = fn5("UIScale", { Parent = Frame, Scale = 1 })
local ImageLabel, ImageLabel2, ImageLabel3
local rect = Rect.new(49, 49, 450, 450)

ImageLabel = fn5("ImageLabel", {
	Name = "AmbientShadow",
	Parent = Frame,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 18),
	Size = UDim2.new(1, 140, 1, 140),
	BackgroundTransparency = 1,
	Image = "rbxassetid://6014261993",
	ImageColor3 = Color3.fromRGB(0, 0, 0),
	ImageTransparency = 0.74,
	ScaleType = Enum.ScaleType.Slice,
	SliceCenter = rect,
	ZIndex = 0,
})

ImageLabel2 = fn5("ImageLabel", {
	Name = "AccentGlow",
	Parent = Frame,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.fromScale(0.5, 0.5),
	Size = UDim2.new(1, 100, 1, 100),
	BackgroundTransparency = 1,
	Image = "rbxassetid://6014261993",
	ImageColor3 = tbl.Accent,
	ImageTransparency = 0.9,
	ScaleType = Enum.ScaleType.Slice,
	SliceCenter = rect,
	ZIndex = 0,
})

ImageLabel3 = fn5("ImageLabel", {
	Name = "KeyShadow",
	Parent = Frame,
	AnchorPoint = Vector2.new(0.5, 0.5),
	Position = UDim2.new(0.5, 0, 0.5, 8),
	Size = UDim2.new(1, 64, 1, 64),
	BackgroundTransparency = 1,
	Image = "rbxassetid://6014261993",
	ImageColor3 = Color3.fromRGB(0, 0, 0),
	ImageTransparency = 0.36,
	ScaleType = Enum.ScaleType.Slice,
	SliceCenter = rect,
	ZIndex = 0,
})

local Close, Minimize, tbl6, setStage, setState, fn9, fn10, fn11

do
	local tbl7 = {
		Name = "Main",
		Parent = Frame,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = tbl.Background,
		BackgroundTransparency = tbl.Transparency,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
	}

	local tbl8 = {}
	local v = fn6(20)
	local color = Color3.fromRGB(255, 255, 255)
	tbl8[1] = v

	do
		local values = table.pack(fn7(color, 0.88, 1))
		table.move(values, 1, values.n, 2, tbl8)
	end

	local Frame2 = fn5("Frame", tbl7, tbl8)

	local tbl9 = {
		Name = "Gloss",
		Parent = Frame2,
		Size = UDim2.new(1, 0, 0, 140),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		ZIndex = 1,
	}

	local tbl10 = {}
	local v2 = fn6(20)
	local tbl11 = { Rotation = 90 }
	local numberSequence = NumberSequence.new
	local tbl12 = {}
	local v3 = NumberSequenceKeypoint.new(0, 0.94)
	local v4 = NumberSequenceKeypoint.new(0.55, 0.985)
	local new = NumberSequenceKeypoint.new
	tbl12[1] = v3
	tbl12[2] = v4

	do
		local values = table.pack(new(1, 1))
		table.move(values, 1, values.n, 3, tbl12)
	end

	tbl11.Transparency = numberSequence(tbl12)
	local UIGradient = fn5("UIGradient", tbl11)
	tbl10[1] = v2
	tbl10[2] = UIGradient
	fn5("Frame", tbl9, tbl10)

	local Frame3 = fn5("Frame", {
		Name = "Header",
		Parent = Frame2,
		Size = UDim2.new(1, 0, 0, tbl.HeaderHeight),
		BackgroundTransparency = 1,
		ZIndex = 3,
	})

	local tbl13 = {
		Name = "Logo",
		Parent = Frame3,
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 16, 0.5, 0),
		Size = UDim2.fromOffset(34, 34),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BorderSizePixel = 0,
		ZIndex = 3,
	}

	local tbl14 = {}
	local v5 = fn6(11)
	local UIGradient2 = fn5("UIGradient", { Rotation = 130, Color = ColorSequence.new(tbl.Accent, Color3.fromRGB(64, 52, 168)) })

	local TextLabel = fn5("TextLabel", {
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		Text = "N",
		Font = gothamBold,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		ZIndex = 4,
	})

	tbl14[1] = v5
	tbl14[2] = UIGradient2
	tbl14[3] = TextLabel
	fn5("Frame", tbl13, tbl14)

	fn5("TextLabel", {
		Name = "Title",
		Parent = Frame3,
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 60, 0.5, 1),
		Size = UDim2.new(1, -160, 0, 17),
		BackgroundTransparency = 1,
		Text = tbl.Title,
		Font = gothamBold,
		TextSize = 15,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
	})

	fn5("TextLabel", {
		Name = "Subtitle",
		Parent = Frame3,
		AnchorPoint = Vector2.new(0, 0),
		Position = UDim2.new(0, 60, 0.5, 2),
		Size = UDim2.new(1, -160, 0, 14),
		BackgroundTransparency = 1,
		Text = str3 .. " · " .. str5,
		Font = gotham,
		TextSize = 11,
		TextColor3 = Color3.fromRGB(138, 138, 145),
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 3,
	})

	local function fn12(arg, arg2, arg3, arg4)
		local v6 = fn5

		local tbl15 = {
			Name = arg,
			Parent = Frame3,
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, arg3, 0.5, 0),
			Size = UDim2.fromOffset(28, 28),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.92,
			Text = "",
			AutoButtonColor = false,
			BorderSizePixel = 0,
			ZIndex = 3,
		}

		local tbl16 = {}
		local v7 = fn6(14)
		local v8 = fn7
		local color2 = Color3.fromRGB(255, 255, 255)
		tbl16[1] = v7

		do
			local values = table.pack(v8(color2, 0.9, 1))
			table.move(values, 1, values.n, 2, tbl16)
		end

		local TextButton = v6("TextButton", tbl15, tbl16)
		local UIScale2 = fn5("UIScale", { Parent = TextButton, Scale = 1 })

		local TextLabel2 = fn5("TextLabel", {
			Parent = TextButton,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = arg2,
			Font = gothamBold,
			TextSize = 13,
			TextColor3 = Color3.fromRGB(190, 190, 198),
			ZIndex = 4,
		})

		fn8(TextButton.MouseEnter, function()
			fn4(TextButton, tbl4.Micro, { BackgroundTransparency = 0.78 })
			fn4(TextLabel2, tbl4.Micro, { TextColor3 = arg4 })
			fn4(UIScale2, tbl4.Snap, { Scale = 1.08 })
		end)

		fn8(TextButton.MouseLeave, function()
			fn4(TextButton, tbl4.Micro, { BackgroundTransparency = 0.92 })
			fn4(TextLabel2, tbl4.Micro, { TextColor3 = Color3.fromRGB(190, 190, 198) })
			fn4(UIScale2, tbl4.Spring, { Scale = 1 })
		end)

		fn8(TextButton.MouseButton1Down, function()
			fn4(UIScale2, tbl4.Micro, { Scale = 0.9 })
		end)

		fn8(TextButton.MouseButton1Up, function()
			fn4(UIScale2, tbl4.Spring, { Scale = 1.08 })
		end)

		return TextButton, TextLabel2
	end

	Close = fn12("Close", "✕", -16, Color3.fromRGB(255, 90, 82))
	local v6
	Minimize, v6 = fn12("Minimize", "–", -52, Color3.fromRGB(255, 255, 255))

	local Frame4 = fn5("Frame", {
		Name = "Divider",
		Parent = Frame2,
		Position = UDim2.new(0, 14, 0, tbl.HeaderHeight),
		Size = UDim2.new(1, -28, 0, 1),
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.9,
		BorderSizePixel = 0,
		ZIndex = 3,
	})

	local n5 = 14
	local n6 = 12
	local n7 = (tbl.Width - n5 * 2 - n6) / 2
	local n8 = 80
	local n9 = tbl.HeaderHeight + 10

	local Frame5 = fn5("Frame", {
		Name = "Body",
		Parent = Frame2,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 2,
	})

	tbl6 = {}

	local function fn13(arg, arg2)
		local Frame6 = fn5("Frame", {
			Name = "Card_" .. arg2.Key,
			Parent = Frame5,
			Position = UDim2.fromOffset(n5 + (arg - 1) % 2 * (n7 + n6), n9 + math.floor((arg - 1) / 2) * (n8 + n6)),
			Size = UDim2.fromOffset(n7, 80),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.945,
			BorderSizePixel = 0,
			ZIndex = 2,
		}, { fn6(14) })

		local v7 = fn7(Color3.fromRGB(255, 255, 255), 0.92, 1)
		v7.Parent = Frame6
		local UIScale2 = fn5("UIScale", { Parent = Frame6, Scale = 1 })

		local Frame7 = fn5("Frame", {
			Name = "Bar",
			Parent = Frame6,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 0.5, 0),
			Size = UDim2.fromOffset(3, 22),
			BackgroundColor3 = tbl.Accent,
			BackgroundTransparency = 0.55,
			BorderSizePixel = 0,
			ZIndex = 3,
		}, { fn6(2) })

		fn5("TextLabel", {
			Name = "Label",
			Parent = Frame6,
			Position = UDim2.fromOffset(16, 15),
			Size = UDim2.new(1, -28, 0, 13),
			BackgroundTransparency = 1,
			Text = arg2.Label,
			Font = gothamMedium,
			TextSize = 10,
			TextColor3 = Color3.fromRGB(128, 128, 136),
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 3,
		})

		local Frame8 = nil
		local Frame9 = nil
		local n10 = 16

		if arg2.Dot then
			Frame9 = fn5("Frame", {
				Name = "Pulse",
				Parent = Frame6,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromOffset(21, 52),
				Size = UDim2.fromOffset(9, 9),
				BackgroundColor3 = tbl2.Idle.Color,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 3,
			}, { fn6(999) })

			Frame8 = fn5("Frame", {
				Name = "Dot",
				Parent = Frame6,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromOffset(21, 52),
				Size = UDim2.fromOffset(9, 9),
				BackgroundColor3 = tbl2.Idle.Color,
				BorderSizePixel = 0,
				ZIndex = 4,
			}, { fn6(999) })

			n10 = 32
		end

		local Frame10 = fn5("Frame", {
			Name = "ValueHolder",
			Parent = Frame6,
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, n10, 0, 52),
			Size = UDim2.new(1, -n10 - 14, 0, 26),
			BackgroundTransparency = 1,
			ZIndex = 3,
		})

		local UIScale3 = fn5("UIScale", { Parent = Frame10, Scale = 1 })

		local TextLabel2 = fn5("TextLabel", {
			Name = "Value",
			Parent = Frame10,
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = arg2.Value,
			Font = gothamBold,
			TextSize = 20,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Center,
			ZIndex = 3,
		})

		fn8(Frame6.MouseEnter, function()
			fn4(Frame6, tbl4.Snap, { BackgroundTransparency = 0.9 })
			fn4(v7, tbl4.Snap, { Transparency = 0.78 })
			fn4(UIScale2, tbl4.Snap, { Scale = 1.018 })
			fn4(Frame7, tbl4.Snap, { BackgroundTransparency = 0.05, Size = UDim2.fromOffset(3, 38) })
		end)

		fn8(Frame6.MouseLeave, function()
			fn4(Frame6, tbl4.Snap, { BackgroundTransparency = 0.945 })
			fn4(v7, tbl4.Snap, { Transparency = 0.92 })
			fn4(UIScale2, tbl4.Spring, { Scale = 1 })
			fn4(Frame7, tbl4.Snap, { BackgroundTransparency = 0.55, Size = UDim2.fromOffset(3, 22) })
		end)

		local tbl15 = {
			Frame = Frame6,
			Value = TextLabel2,
			Scale = UIScale3,
			Dot = Frame8,
			Pulse = Frame9,
			Bar = Frame7,
			Set = function(arg3, arg4, arg5)
				local text = tostring(arg4)
				if TextLabel2.Text == text then
					return
				end
				TextLabel2.Text = text

				if arg5 ~= false then
					UIScale3.Scale = 1.16
					fn4(UIScale3, tbl4.Pop, { Scale = 1 })
				end
			end,
		}

		tbl6[arg2.Key] = tbl15
		return tbl15
	end

	for i, v7 in ipairs(tbl3) do
		fn13(i, v7)
	end

	local TextLabel2 = fn5("TextLabel", {
		Name = "Stage",
		Parent = Frame5,
		Position = UDim2.new(0, 14, 0, n9 + n8 * 2 + n6 + 10),
		Size = UDim2.new(1, -n5 * 2, 0, 16),
		BackgroundTransparency = 1,
		Text = "Starting…",
		Font = gotham,
		TextSize = 11,
		TextColor3 = Color3.fromRGB(128, 128, 136),
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		ZIndex = 3,
	})

	local tbl15 = {}

	local function fn14(arg)
		local tbl16 = {}

		if arg:IsA("GuiObject") then
			tbl16.BackgroundTransparency = arg.BackgroundTransparency
		end

		if arg:IsA("TextLabel") or arg:IsA("TextButton") or arg:IsA("TextBox") then
			tbl16.TextTransparency = arg.TextTransparency
		end

		if arg:IsA("ImageLabel") or arg:IsA("ImageButton") then
			tbl16.ImageTransparency = arg.ImageTransparency
		end

		if arg:IsA("UIStroke") then
			tbl16.Transparency = arg.Transparency
		end

		if next(tbl16) then
			table.insert(tbl15, { Object = arg, Props = tbl16 })
		end
	end

	fn14(Frame)

	for _, descendant in ipairs(Frame:GetDescendants()) do
		fn14(descendant)
	end

	local function fn15(arg)
		for _, v7 in ipairs(tbl15) do
			for k, prop in pairs(v7.Props) do
				v7.Object[k] = 1 - (1 - prop) * arg
			end
		end
	end

	local function fn16(arg, arg2)
		for _, v7 in ipairs(tbl15) do
			local tbl16 = {}

			for k, prop in pairs(v7.Props) do
				tbl16[k] = 1 - (1 - prop) * arg
			end

			fn4(v7.Object, arg2, tbl16)
		end
	end

	local udim2 = UDim2.fromScale(0.5, 0.5)
	local udim22 = UDim2.new(0.5, 0, 0.5, 34)
	Frame.Position = udim22
	local flag3 = false
	local position = nil
	local v7 = nil
	local connection = nil

	local function fn17()
		if connection then
			connection:Disconnect()
			connection = nil
		end

		Frame.Position = udim2
		udim22 = udim2
	end

	fn8(Frame3.InputBegan, function(arg)
		if arg.UserInputType ~= Enum.UserInputType.MouseButton1 and arg.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		flag3 = true
		position = arg.Position
		v7 = udim2
		fn4(UIScale, tbl4.Micro, { Scale = 0.985 })
		fn4(ImageLabel, tbl4.Snap, { ImageTransparency = 0.62, Size = UDim2.new(1, 180, 1, 180) })
		fn4(ImageLabel3, tbl4.Snap, { ImageTransparency = 0.24, Size = UDim2.new(1, 84, 1, 84) })
		fn4(ImageLabel2, tbl4.Snap, { ImageTransparency = 0.78, Size = UDim2.new(1, 130, 1, 130) })

		if not connection then
			connection = RunService.RenderStepped:Connect(function(deltaTime)
				udim22 = udim22:Lerp(udim2, 1 - math.exp(-deltaTime * 18))
				Frame.Position = udim22
			end)
		end

		local connection2 = nil

		connection2 = arg.Changed:Connect(function()
			if arg.UserInputState ~= Enum.UserInputState.End then
				return
			end
			flag3 = false
			fn4(UIScale, tbl4.Spring, { Scale = 1 })
			fn4(ImageLabel, tbl4.Snap, { ImageTransparency = 0.74, Size = UDim2.new(1, 140, 1, 140) })
			fn4(ImageLabel3, tbl4.Snap, { ImageTransparency = 0.36, Size = UDim2.new(1, 64, 1, 64) })
			fn4(ImageLabel2, tbl4.Snap, { ImageTransparency = 0.9, Size = UDim2.new(1, 100, 1, 100) })

			task.delay(0.35, function()
				if not flag3 then
					fn17()
				end
			end)

			connection2:Disconnect()
		end)
	end)

	fn8(UserInputService.InputChanged, function(arg)
		if not flag3 then
			return
		end

		if arg.UserInputType ~= Enum.UserInputType.MouseMovement and arg.UserInputType ~= Enum.UserInputType.Touch then
			return
		end
		local n10 = arg.Position - position
		udim2 = UDim2.new(v7.X.Scale, v7.X.Offset + n10.X, v7.Y.Scale, v7.Y.Offset + n10.Y)
	end)

	local str7 = "Idle"
	local flag4 = true
	local flag5 = false

	local function fn18(arg)
		local n10 = math.max(0, math.floor(arg))
		return string.format("%02d:%02d:%02d", n10 // 3600, n10 % 3600 // 60, n10 % 60)
	end

	local function fn19(arg)
		local idle = tbl2[arg] or tbl2.Idle
		str7 = tbl2[arg] and arg or "Idle"
		local status = tbl6.status
		status:Set(idle.Label)
		fn4(status.Value, tbl4.Snap, { TextColor3 = idle.Color })
		fn4(status.Dot, tbl4.Snap, { BackgroundColor3 = idle.Color })
		fn4(status.Bar, tbl4.Snap, { BackgroundColor3 = idle.Color })
		status.Pulse.BackgroundColor3 = idle.Color
	end

	task.spawn(function()
		while not flag do
			if str7 == "Running" and flag4 and not flag5 then
				local pulse = tbl6.status.Pulse
				pulse.Size = UDim2.fromOffset(9, 9)
				pulse.BackgroundTransparency = 0.4
				fn4(pulse, TweenInfo.new(1.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromOffset(30, 30), BackgroundTransparency = 1 })
				fn4(ImageLabel2, tbl4.Glow, { ImageTransparency = 0.82 })
				task.wait(1.4)

				if not flag3 then
					fn4(ImageLabel2, tbl4.Glow, { ImageTransparency = 0.9 })
				end
			end

			task.wait(1.4)
		end
	end)

	task.spawn(function()
		while not flag do
			tbl6.time:Set(fn18(fn2()), false)
			task.wait(0.5)
		end
	end)

	local function fn20()
		if flag4 or flag then
			return
		end
		flag4 = true
		ScreenGui.Enabled = true
		fn15(0)
		UIScale.Scale = 0.93
		fn16(1, tbl4.Enter)
		fn4(UIScale, tbl4.Enter, { Scale = 1 })
	end

	local function fn21()
		if not flag4 or flag then
			return
		end
		flag4 = false
		fn16(0, tbl4.Exit)
		fn4(UIScale, tbl4.Exit, { Scale = 0.93 })

		task.delay(0.28, function()
			if not flag4 and not flag then
				ScreenGui.Enabled = false
			end
		end)
	end

	local function fn22(arg)
		if flag5 == arg then
			return
		end
		flag5 = arg

		if flag5 then
			fn4(Frame, tbl4.Resize, { Size = UDim2.fromOffset(tbl.Width, tbl.HeaderHeight) })

			for _, descendant in ipairs(Frame5:GetDescendants()) do
				if descendant:IsA("GuiObject") then
					fn4(descendant, tbl4.Exit, { BackgroundTransparency = 1 })
				end

				if descendant:IsA("TextLabel") then
					fn4(descendant, tbl4.Exit, { TextTransparency = 1 })
				end

				if descendant:IsA("UIStroke") then
					fn4(descendant, tbl4.Exit, { Transparency = 1 })
				end
			end

			fn4(Frame4, tbl4.Exit, { BackgroundTransparency = 1 })
		else
			fn4(Frame, tbl4.Resize, { Size = UDim2.fromOffset(tbl.Width, tbl.Height) })

			for _, v8 in ipairs(tbl15) do
				if v8.Object == Frame4 or v8.Object:IsDescendantOf(Frame5) then
					fn4(v8.Object, tbl4.Enter, v8.Props)
				end
			end
		end

		v6.Text = flag5 and "+" or "–"
	end

	fn8(Close.MouseButton1Click, fn21)

	fn8(Minimize.MouseButton1Click, function()
		fn22(not flag5)
	end)

	fn8(UserInputService.InputBegan, function(arg, arg2)
		if arg2 then
			return
		end

		if arg.KeyCode == tbl.ToggleKey then
			if flag4 then
				fn21()
			else
				fn20()
			end
		end
	end)

	fn15(0)
	UIScale.Scale = 0.93
	fn19("Idle")
	tbl6.boss:Set(stats.Boss, false)
	tbl6.chests:Set(chests .. " / " .. n, false)

	task.defer(function()
		fn4(UIScale, tbl4.Enter, { Scale = 1 })
		fn4(Frame, tbl4.Enter, { Position = udim2 })
		fn16(1, tbl4.Enter)

		for i, v8 in ipairs(tbl3) do
			local frame = tbl6[v8.Key].Frame
			local position2 = frame.Position
			frame.Position = position2 + UDim2.fromOffset(0, 18)

			task.delay(0.05 + (i - 1) * 0.06, function()
				if flag then
					return
				end
				fn4(frame, tbl4.Enter, { Position = position2 })
			end)
		end
	end)

	local str8 = ""

	setStage = function(arg)
		local text = tostring(arg)
		if text == str8 then
			return
		end
		str8 = text
		TextLabel2.Text = text
	end

	setState = function(arg)
		if str7 == arg then
			return
		end
		fn19(arg)
	end

	fn9 = function(arg)
		tbl6.chests:Set(arg .. " / " .. n)
	end

	fn10 = function()
		stats.Boss = stats.Boss + 1
		tbl6.boss:Set(stats.Boss)
	end

	fn11 = function()
		for _, v8 in ipairs(tbl5) do
			pcall(function()
				v8:Disconnect()
			end)
		end

		table.clear(tbl5)
		fn17()

		pcall(function()
			ScreenGui:Destroy()
		end)
	end
end

local fn12

fn12 = function()
	local character = localPlayer.Character
	if character and character.Parent and character:FindFirstChild("HumanoidRootPart") then
		return character
	end
	return nil
end

local fn13, fn14, fn15, fn16, fn17, fn18, fn19, fn20, fn21, flag3
local v, fn22

do
	local function fn23()
		return localPlayer:FindFirstChildOfClass("Backpack")
	end

	fn13 = function(...)
		local ok, result = pcall(commF.InvokeServer, commF, ...)
		if ok then
			return result
		end
		return nil
	end

	local function fn24(arg)
		local kind = typeof(arg)
		if kind == "CFrame" then
			return arg
		end

		if kind == "Vector3" then
			return CFrame.new(arg)
		end

		if kind == "Instance" then
			if arg:IsA("BasePart") then
				return arg.CFrame
			end

			if arg:IsA("Model") then
				return arg:GetPivot()
			end
		end

		return nil
	end

	local tween = nil

	local function fn25(arg)
		local v2 = fn12()
		if not v2 then
			return
		end
		local head = v2:FindFirstChild("Head")
		if not head then
			return
		end

		if arg then
			if not head:FindFirstChild("NightVelocity") then
				local bodyVelocity = Instance.new("BodyVelocity")
				bodyVelocity.Name = "NightVelocity"
				bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
				bodyVelocity.Velocity = Vector3.zero
				bodyVelocity.P = 1500
				bodyVelocity.Parent = head
			end

			for _, descendant in ipairs(v2:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.CanCollide then
					descendant.CanCollide = false
				end
			end
		else
			local nightVelocity = head:FindFirstChild("NightVelocity")

			if nightVelocity then
				nightVelocity:Destroy()
			end
		end
	end

	local function fn26()
		if tween then
			tween:Cancel()
			tween = nil
		end
	end

	fn14 = function()
		fn26()
		fn25(false)
	end

	local n5 = 3500
	local n6 = 5
	local n7 = 0
	local fn27 = nil

	fn15 = function(arg, arg2)
		local v2 = fn24(arg)
		if not v2 then
			return
		end
		local v3 = fn12()
		if not v3 then
			return
		end
		local humanoidRootPart = v3:FindFirstChild("HumanoidRootPart")
		local humanoid = v3:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart or not humanoid or humanoid.Health <= 0.36 then
			fn26()
			return
		end

		if humanoid.Sit then
			humanoid.Sit = false
		end

		fn25(arg2 and true or false)
		local magnitude = (v2.Position - humanoidRootPart.Position).Magnitude

		if magnitude <= n3 then
			fn26()
			n7 = 0
			humanoidRootPart.CFrame = v2
			return
		end

		if magnitude >= n5 and fn27 and fn27(v2) then
			return
		end
		fn26()
		tween = TweenService:Create(humanoidRootPart, TweenInfo.new(magnitude / n2, Enum.EasingStyle.Linear), { CFrame = v2 })
		tween:Play()
	end

	fn16 = function(arg)
		if not arg or not arg.Parent then
			return false
		end

		if arg:FindFirstChild("VehicleSeat") then
			return false
		end
		local humanoid = arg:FindFirstChild("Humanoid")
		return humanoid ~= nil and humanoid.Health > 0 and arg:FindFirstChild("HumanoidRootPart") ~= nil
	end

	fn17 = function(arg, arg2)
		if type(arg) == "string" then
			return arg2.Name == arg or arg2.Name:find(arg, 1, true) ~= nil
		end
		return table.find(arg, arg2.Name) ~= nil
	end

	fn18 = function(arg, arg2)
		local v2 = fn12()
		if not v2 then
			return nil
		end
		local humanoidRootPart = v2.HumanoidRootPart
		local v3 = nil
		local huge = math.huge

		local function fn28(arg3)
			for _, v4 in ipairs(arg3) do
				if v4:IsA("Model") and fn17(arg, v4) and fn16(v4) then
					local magnitude = (v4.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude

					if magnitude < huge then
						huge = magnitude
						v3 = v4
					end
				end
			end
		end

		local enemies = Workspace:FindFirstChild("Enemies")

		if enemies then
			fn28(enemies:GetChildren())
		end

		if arg2 then
			fn28(ReplicatedStorage:GetChildren())
		end

		return v3
	end

	local tbl7 = { "Melee", "Sword", "Blox Fruit" }

	local function fn28(arg)
		local v2 = fn12()
		local v3 = fn23()

		local function fn29(arg2)
			for _, v4 in ipairs(arg2) do
				if v4:IsA("Tool") and v4.ToolTip == arg then
					return v4.Name
				end
			end

			return nil
		end

		if v3 then
			local v4 = fn29(v3:GetChildren())
			if v4 then
				return v4
			end
		end

		if v2 then
			return (fn29(v2:GetChildren()))
		end
		return nil
	end

	local function fn29()
		local v2 = fn28(str)
		if v2 then
			return v2
		end

		for _, v3 in ipairs(tbl7) do
			local v4 = fn28(v3)
			if v4 then
				return v4
			end
		end

		return nil
	end

	local function fn30()
		local v2 = fn12()
		local humanoid = v2 and v2:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end
		local v3 = fn29()
		if not v3 then
			return
		end
		local tool = v2:FindFirstChildOfClass("Tool")
		if tool and tool.Name == v3 then
			return
		end
		local v4 = fn23()
		v4 = v4 and v4:FindFirstChild(v3)

		if v4 then
			humanoid:EquipTool(v4)
		end
	end

	fn19 = function(arg)
		local v2 = fn12()
		local humanoid = v2 and v2:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return
		end

		if v2:FindFirstChild(arg) then
			return
		end
		local v3 = fn23()
		v3 = v3 and v3:FindFirstChild(arg)

		if v3 then
			humanoid:EquipTool(v3)
		end
	end

	local n8 = 0

	local function fn31()
		local v2 = fn12()
		if not v2 or v2:FindFirstChild("HasBuso") then
			return
		end

		if os.clock() - n8 < 3 then
			return
		end
		n8 = os.clock()
		fn13("Buso")
	end

	fn20 = function(arg)
		local v2 = fn12()
		local v3 = fn23()

		local function fn32(arg2)
			for _, v4 in ipairs(arg2) do
				if v4.Name == arg or v4.Name:find(arg, 1, true) then
					return v4
				end
			end

			return nil
		end

		if v3 then
			local v4 = fn32(v3:GetChildren())
			if v4 then
				return v4
			end
		end

		if v2 then
			return (fn32(v2:GetChildren()))
		end
		return nil
	end

	local tbl8 = { "Fist of Darkness", "God's Chalice", "Sweet Chalice" }

	local function fn32()
		if not bypassTeleport then
			return false
		end

		if n7 >= n6 then
			return false
		end

		for _, v2 in ipairs(tbl8) do
			if fn20(v2) then
				return false
			end
		end

		return true
	end

	local function fn33(arg)
		local humanoidRootPart = fn12()
		humanoidRootPart = humanoidRootPart and humanoidRootPart:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return nil
		end
		local worldOrigin = Workspace:FindFirstChild("_WorldOrigin")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild("PlayerSpawns")
		worldOrigin = worldOrigin and worldOrigin:FindFirstChild(str2)
		if not worldOrigin then
			return nil
		end
		local huge = math.huge
		local cFrame = nil
		local name = nil

		for _, child in ipairs(worldOrigin:GetChildren()) do
			local part = child:FindFirstChild("Part")

			if part and part:IsA("BasePart") then
				local magnitude = (part.Position - arg.Position).Magnitude
				local magnitude2 = (part.Position - humanoidRootPart.Position).Magnitude

				if magnitude < huge and magnitude2 >= 2000 and magnitude2 <= 10000 then
					cFrame = part.CFrame
					name = child.Name
					huge = magnitude
				end
			end
		end

		if not cFrame or huge >= (arg.Position - humanoidRootPart.Position).Magnitude then
			return nil
		end
		return cFrame, name
	end

	fn27 = function(arg)
		if not fn32() then
			return false
		end
		local v2, v3 = fn33(arg)
		if not v2 or not v3 then
			return false
		end
		local v4 = fn12()
		if not v4 then
			return false
		end
		local humanoidRootPart = v4:FindFirstChild("HumanoidRootPart")
		local humanoid = v4:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
			return false
		end
		fn26()
		fn25(false)
		n7 += 1
		setStage("Bypass teleport via " .. v3)
		humanoidRootPart.Anchored = true
		local n9 = os.clock() + 8

		while true do
			fn13("SetLastSpawnPoint", v3)

			pcall(function()
				v4:PivotTo(v2)
				local head = v4:FindFirstChild("Head")

				if head then
					head:Destroy()
				end

				humanoidRootPart.Anchored = false
			end)

			task.wait(1)
			if not (humanoid.Health <= 0 or not v4.Parent or os.clock() >= n9) then
				continue
			end
			break
		end

		pcall(function()
			humanoidRootPart.Anchored = false
		end)

		local n10 = os.clock() + 15

		while true do
			task.wait(0.25)
			local v5 = fn12()
			local humanoid2 = v5 and v5:FindFirstChildOfClass("Humanoid")
			if v5 ~= v4 and humanoid2 and humanoid2.Health > 0 then
				return true
			end

			if not (n10 <= os.clock()) then
				continue
			end
			break
		end

		return true
	end

	local ItemId = nil
	local ItemReplicationService = nil
	local KEYS = nil

	pcall(function()
		ItemId = require(ReplicatedStorage.Economy.ItemId)
		ItemReplicationService = require(ReplicatedStorage.ItemReplicationService)
		KEYS = require(ReplicatedStorage.ItemReplicationService.KEYS)
	end)

	fn21 = function(arg)
		if not ItemReplicationService or not ItemReplicationService.IsInitialized then
			return 0
		end

		local ok, result = pcall(function()
			for _, v2 in pairs(ItemReplicationService:GetItems(KEYS.QUANTITY)) do
				local v3 = ItemId.getDataFromId(v2.ItemId):unwrap()
				if v3 and v3.StorageKey == arg then
					return v2.Value or 0
				end
			end

			return 0
		end)

		if ok then
			return result
		end
		return 0
	end

	flag3 = false
	local n9 = 0

	local function fn34()
		local v2 = fn12()
		if not v2 then
			return
		end
		local tool = v2:FindFirstChildOfClass("Tool")
		if not tool then
			return
		end
		local humanoidRootPart = v2.HumanoidRootPart
		local enemies = Workspace:FindFirstChild("Enemies")
		if not enemies then
			return
		end
		local tbl9 = {}

		for _, child in ipairs(enemies:GetChildren()) do
			if child:IsA("Model") and not child:FindFirstChild("VehicleSeat") then
				local humanoid = child:FindFirstChild("Humanoid")
				local humanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

				if humanoid and humanoidRootPart2 and humanoid.Health > 0 and (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= 100 then
					tbl9[#tbl9 + 1] = child
				end
			end
		end

		if #tbl9 == 0 then
			return
		end

		if tool.ToolTip == "Blox Fruit" then
			local leftClickRemote = tool:FindFirstChild("LeftClickRemote")

			if leftClickRemote and leftClickRemote:IsA("RemoteEvent") then
				leftClickRemote:FireServer(Vector3.new(0, -500, 0), math.random(1, 4), true)
				task.wait(0.01)
				leftClickRemote:FireServer(false)
			end

			return
		end

		if tool.ToolTip == "Melee" or tool.ToolTip == "Sword" then
			local tbl10 = {}

			for _, v3 in ipairs(tbl9) do
				tbl10[#tbl10 + 1] = { v3, v3.HumanoidRootPart }
			end

			reRegisterAttack:FireServer(0)
			reRegisterHit:FireServer(tbl10[1][2], tbl10)
		end
	end

	task.spawn(function()
		while not flag do
			if flag3 then
				if os.clock() - n9 > 1 then
					flag3 = false
					task.wait(0.2)
				else
					pcall(fn34)
					task.wait()
				end
			else
				task.wait(0.2)
			end
		end
	end)

	v = nil

	fn22 = function(arg)
		if not fn16(arg) then
			return false
		end
		local v2 = fn12()
		if not v2 then
			return false
		end
		local humanoid = v2:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			return false
		end

		if humanoid.Sit then
			humanoid.Sit = false
			return true
		end
		local tool = v2:FindFirstChildOfClass("Tool")
		local n10 = arg:GetAttribute("IsBoss") and 50 or 30

		if tool and tool.ToolTip == "Blox Fruit" then
			n10 = 15
		end

		fn15(arg.HumanoidRootPart.CFrame * CFrame.new(-3, n10, 0), true)
		fn30()
		fn31()
		flag3 = true
		n9 = os.clock()
		return true
	end
end

do
	local function fn23()
		local v2 = fn12()
		if not v2 then
			return nil
		end
		local humanoidRootPart = v2.HumanoidRootPart
		local huge = math.huge
		local v3 = nil

		for _, v4 in ipairs(CollectionService:GetTagged("_ChestTagged")) do
			if v4.Parent and v4:FindFirstChild("TouchInterest") and not v4:GetAttribute("IsDisabled") then
				local position = humanoidRootPart.Position
				local magnitude = (v4:GetPivot().Position - position).Magnitude

				if magnitude < huge then
					huge = magnitude
					v3 = v4
				end
			end
		end

		return v3
	end

	local n5 = 0

	local function fn24()
		local v2 = fn23()
		if not v2 then
			setStage("Waiting for chests to respawn")
			return
		end
		setStage(string.format("Farming chests  %d / %d", chests, n))
		local pivot = v2:GetPivot()
		fn15(pivot, true)
		local v3 = fn12()
		if not v3 then
			return
		end
		local humanoidRootPart = v3.HumanoidRootPart
		if (pivot.Position - humanoidRootPart.Position).Magnitude > 10 then
			return
		end

		pcall(function()
			firetouchinterest(v2, humanoidRootPart, 0)
			firetouchinterest(v2, humanoidRootPart, 1)
			firesignal(v2.Touched, humanoidRootPart)
		end)

		if os.clock() - n5 >= 1 and not v2:GetAttribute("IsDisabled") then
			n5 = os.clock()
			v2:SetAttribute("IsDisabled", true)
			chests += 1
			stats.Chests = chests
			fn9(chests)
		end
	end

	local bxor = bit32.bxor
	local band = bit32.band
	local lshift = bit32.lshift
	local rshift = bit32.rshift
	local lrotate = bit32.lrotate
	local str7 = "NIGHTHUB|"
	local n6 = 8
	local n7 = 4
	local n8 = 4294967296
	local tbl7 = { 1634760805, 857760878, 2036477234, 1797285236 }

	local function fn25(arg)
		local tbl8 = {}

		for i = 1, #arg, 2 do
			tbl8[#tbl8 + 1] = tonumber(arg:sub(i, i + 1), 16)
		end

		return tbl8
	end

	local function fn26(arg, arg2)
		return arg[arg2] + arg[arg2 + 1] * 256 + arg[arg2 + 2] * 65536 + arg[arg2 + 3] * 16777216
	end

	local function fn27(arg, arg2, arg3, arg4, arg5)
		arg[arg2] = (arg[arg2] + arg[arg3]) % n8
		arg[arg5] = lrotate(bxor(arg[arg5], arg[arg2]), 16)
		arg[arg4] = (arg[arg4] + arg[arg5]) % n8
		arg[arg3] = lrotate(bxor(arg[arg3], arg[arg4]), 12)
		arg[arg2] = (arg[arg2] + arg[arg3]) % n8
		arg[arg5] = lrotate(bxor(arg[arg5], arg[arg2]), 8)
		arg[arg4] = (arg[arg4] + arg[arg5]) % n8
		arg[arg3] = lrotate(bxor(arg[arg3], arg[arg4]), 7)
	end

	local function fn28(arg)
		for i = 1, 10 do
			fn27(arg, 1, 5, 9, 13)
			fn27(arg, 2, 6, 10, 14)
			fn27(arg, 3, 7, 11, 15)
			fn27(arg, 4, 8, 12, 16)
			fn27(arg, 1, 6, 11, 16)
			fn27(arg, 2, 7, 12, 13)
			fn27(arg, 3, 8, 9, 14)
			fn27(arg, 4, 5, 10, 15)
		end
	end

	local function fn29(arg, arg2, arg3)
		local tbl8 = { tbl7[1], tbl7[2], tbl7[3], tbl7[4] }

		for i = 0, 7 do
			tbl8[5 + i] = fn26(arg, 1 + 4 * i)
		end

		tbl8[13] = arg2 % n8

		for i = 0, 2 do
			tbl8[14 + i] = fn26(arg3, 1 + 4 * i)
		end

		return tbl8
	end

	local function fn30(arg, arg2, arg3)
		local v2 = fn29(arg, arg2, arg3)
		local tbl8 = {}

		for i = 1, 16 do
			tbl8[i] = v2[i]
		end

		fn28(tbl8)
		local tbl9 = {}

		for i = 1, 16 do
			local n9 = (tbl8[i] + v2[i]) % n8
			local n10 = (i - 1) * 4
			tbl9[n10 + 1] = band(n9, 255)
			tbl9[n10 + 2] = band(rshift(n9, 8), 255)
			tbl9[n10 + 3] = band(rshift(n9, 16), 255)
			tbl9[n10 + 4] = band(rshift(n9, 24), 255)
		end

		return tbl9
	end

	local function fn31(arg, arg2, arg3, arg4)
		local tbl8 = {}
		local n9 = 0

		while n9 < arg4 do
			local v2 = fn30(arg, arg3, arg2)

			for i = 1, 64 do
				if not (arg4 <= n9) then
					n9 += 1
					tbl8[n9] = v2[i]
					continue
				end

				break
			end

			arg3 += 1
		end

		return tbl8
	end

	local function fn32(arg, arg2, arg3)
		local v2 = fn29(arg, 4294967295, arg2)
		fn28(v2)
		local n9 = #arg3

		for i = 0, n9 + (16 - n9 % 16) % 16 - 1, 16 do
			for i2 = 0, 3 do
				local n10 = i + 4 * i2
				v2[i2 + 1] = bxor(v2[i2 + 1], (arg3[n10 + 1] or 0) + (arg3[n10 + 2] or 0) * 256 + (arg3[n10 + 3] or 0) * 65536 + (arg3[n10 + 4] or 0) * 16777216)
			end

			fn28(v2)
		end

		v2[1] = bxor(v2[1], n9)
		fn28(v2)
		local v3 = v2[1]
		local tbl8 = {}
		local v4 = band(v3, 255)
		local v5 = band(rshift(v3, 8), 255)
		local v6 = band(rshift(v3, 16), 255)
		local v7 = rshift(v3, 24)
		tbl8[1] = v4
		tbl8[2] = v5
		tbl8[3] = v6

		do
			local values = table.pack(band(v7, 255))
			table.move(values, 1, values.n, 4, tbl8)
		end

		return tbl8
	end

	local tbl8 = {}

	local function fn33(arg)
		local str8 = table.concat(arg, ",")
		if tbl8[str8] then
			return tbl8[str8]
		end
		local v2 = fn31(arg, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, 11259375, 128)
		local tbl9 = {}

		for i = 1, 64 do
			tbl9[i] = ("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_"):sub(i, i)
		end

		for i = 64, 2, -1 do
			local n9 = i - 1
			local n10 = (v2[2 * n9 + 1] * 256 + v2[2 * n9 + 2]) % i + 1
			local v3 = tbl9[i]
			tbl9[i] = tbl9[n10]
			tbl9[n10] = v3
		end

		local str9 = table.concat(tbl9)
		tbl8[str8] = str9
		return str9
	end

	local function fn34(arg, arg2)
		local tbl9 = {}

		for i = 1, 64 do
			tbl9[arg2:sub(i, i)] = i - 1
		end

		local tbl10 = {}

		for i = 1, #arg do
			local v2 = tbl9[arg:sub(i, i)]
			if v2 == nil then
				return nil
			end
			tbl10[#tbl10 + 1] = v2
		end

		local tbl11 = {}

		for i = 1, #tbl10, 4 do
			local v2 = tbl10[i]
			local v3 = tbl10[i + 1]
			local v4 = tbl10[i + 2]
			local v5 = tbl10[i + 3]
			if v3 == nil then
				return nil
			end
			tbl11[#tbl11 + 1] = band(lshift(v2, 2) + rshift(v3, 4), 255)

			if v4 ~= nil then
				tbl11[#tbl11 + 1] = band(lshift(band(v3, 15), 4) + rshift(v4, 2), 255)
			end

			if v5 ~= nil then
				tbl11[#tbl11 + 1] = band(lshift(band(v4, 3), 6) + v5, 255)
			end
		end

		return tbl11
	end

	local v2 = fn25("8992d555ed7846a562b058523100fbd0e59b5f6f28e98003230ffb4d9db60411")

	local function fn35(arg)
		if type(arg) ~= "string" or arg:sub(1, #str7) ~= str7 then
			return nil
		end
		local v3 = fn34(arg:sub(#str7 + 1), fn33(v2))
		if not v3 or #v3 < n6 + n7 then
			return nil
		end
		local tbl9 = {}

		for i = 1, 8 do
			tbl9[i] = v3[i]
		end

		for i = n6 + 1, 12 do
			tbl9[i] = 0
		end

		local tbl10 = {}

		for i = n6 + n7 + 1, #v3 do
			tbl10[i - n6 - n7] = v3[i]
		end

		local v4 = fn32(v2, tbl9, tbl10)

		for i = 1, 4 do
			if v4[i] ~= v3[n6 + i] then
				return nil
			end
		end

		local v5 = fn31(v2, tbl9, 1, #tbl10)
		local tbl11 = {}

		for i = 1, #tbl10 do
			tbl11[i] = string.char(bxor(tbl10[i], v5[i]))
		end

		return table.concat(tbl11)
	end

	local function fn36(arg)
		local ok, result = pcall(fn35, arg)
		if not ok or type(result) ~= "string" then
			return nil
		end

		if not result:match("^%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x$") then
			return nil
		end
		return result
	end

	local function fn37()
		return ReplicatedStorage:FindFirstChild("__ServerBrowser")
	end

	local function fn38(arg)
		if not request_ then
			return false
		end
		local v3 = arg

		pcall(function()
			v3 = HttpService:UrlEncode(arg)
		end)

		local ok, result = pcall(request_, { Url = str6 .. v3, Method = "GET" })
		if not ok or type(result) ~= "table" or type(result.Body) ~= "string" then
			return false
		end

		local ok2, result2 = pcall(function()
			return HttpService:JSONDecode(result.Body)
		end)

		if not ok2 or type(result2) ~= "table" or type(result2.data) ~= "table" then
			return false
		end
		local tbl9 = {}

		for _, v4 in pairs(result2.data) do
			if type(v4) == "table" and type(v4.JobId) == "string" and v4.PlaceId == game.PlaceId then
				local v5 = fn36(v4.JobId)

				if v5 and v5 ~= game.JobId then
					tbl9[#tbl9 + 1] = { Id = v5, Age = tonumber(v4.Age) or 0 }
				end
			end
		end

		if #tbl9 == 0 then
			return false
		end

		table.sort(tbl9, function(arg2, arg3)
			return arg2.Age < arg3.Age
		end)

		local v4 = fn37()
		if not v4 then
			return false
		end

		for _, v5 in ipairs(tbl9) do
			pcall(function()
				v4:InvokeServer("teleport", v5.Id)
			end)

			task.wait(0.4)
		end

		return true
	end

	local function fn39()
		local v3 = fn37()
		if not v3 then
			return false
		end
		local flag4 = false

		for i = 1, 20 do
			local ok, result = pcall(function()
				return v3:InvokeServer(i)
			end)

			if ok and type(result) == "table" then
				for k, v4 in pairs(result) do
					local flag5 = k ~= game.JobId and type(v4) == "table"

					if flag5 then
						flag5 = (tonumber(v4.Count) or 99) <= 12
					end

					if flag5 then
						pcall(function()
							v3:InvokeServer("teleport", k)
						end)

						task.wait(0.5)
						flag4 = true
					end
				end
			end
		end

		return flag4
	end

	local function fn40()
		if not autoResume or not flag2 then
			return
		end
		local v3 = queue_on_teleport or queueonteleport
		if type(v3) ~= "function" then
			return
		end
		local str8 = string.format("getgenv().Boss = %q getgenv().Weapon = %q getgenv().Team = %q getgenv().ChestLimit = %d getgenv().TweenSpeed = %d getgenv().TweenInstance = %d getgenv().AutoResume = true task.wait(6) local ok, src = pcall(function() if isfile(%q) then return readfile(%q) end end) if ok and type(src) == \"string\" and src ~= \"\" then local fn = loadstring(src) if fn then fn() end end", str3, str, str2, n, n2, n3, "KaitunDarkbeard_DoughKing.lua", "KaitunDarkbeard_DoughKing.lua")
		pcall(v3, str8)
	end

	local flag4 = false

	local function fn41()
		if flag4 then
			return
		end
		flag4 = true
		setState("Paused")
		setStage("Hopping to a 4H server")
		chests = 0
		stats.Chests = 0
		fn9(0)
		fn3()
		fn40()

		if not fn38("4H") then
			setStage("4H list empty, trying the " .. str3 .. " list")

			if not fn38(str3) then
				setStage("API list empty, using the server browser")
				fn39()
			end
		end

		flag4 = false
	end

	local function fn42()
		if chests >= n then
			fn41()
			return
		end
		fn24()
	end

	local function fn43()
		return Workspace:GetAttribute("MAP") or "UNKNOWN"
	end

	local n9 = 0

	local function fn44()
		local v3 = fn43()
		if v3 == str4 then
			return true
		end
		setState("Paused")
		setStage("Traveling to " .. str5)
		if os.clock() - n9 < 6 then
			return false
		end
		n9 = os.clock()

		if str4 == "Sea2" then
			if v3 == "Sea3" then
				fn13("TravelMain")
			else
				fn13("TravelDressrosa")
			end
		elseif v3 == "Sea1" then
			fn13("TravelDressrosa")
		else
			fn13("TravelZou")
		end

		return false
	end

	local function fn45(arg)
		local fortBuilderReplicatedSpawnPositi = ReplicatedStorage:FindFirstChild("FortBuilderReplicatedSpawnPositionsFolder")
		if not fortBuilderReplicatedSpawnPositi then
			return
		end
		local v3 = fn12()
		if not v3 then
			return
		end
		local humanoidRootPart = v3.HumanoidRootPart
		local huge = math.huge
		local v4 = nil

		for _, child in ipairs(fortBuilderReplicatedSpawnPositi:GetChildren()) do
			if child:IsA("BasePart") and fn17(arg, child) then
				local magnitude = (child.Position - humanoidRootPart.Position).Magnitude

				if magnitude > 30 and magnitude < huge then
					huge = magnitude
					v4 = child
				end
			end
		end

		if v4 then
			fn15(v4.CFrame * CFrame.new(0, 20, 0), true)
		end
	end

	local function fn46(arg, arg2)
		setStage(arg2)
		local v3 = fn18(arg, false)
		if v3 then
			fn22(v3)
			return
		end
		fn45(arg)
	end

	local cframe = CFrame.new(3779, 16, -3500)
	local cframe2 = CFrame.new(-2124, 69, -12401)
	local tbl9 = { "Head Baker", "Baking Staff", "Cake Guard", "Cookie Crafter" }
	local tbl10 = { "Cocoa Warrior", "Chocolate Bar Battler" }

	local function fn47()
		local Darkbeard = fn18("Darkbeard", true)

		if Darkbeard then
			v = Darkbeard
			setState("Running")
			setStage("Killing Darkbeard")
			fn22(Darkbeard)
			return
		end

		if fn20("Fist of Darkness") then
			setState("Running")
			setStage("Summoning Darkbeard")
			fn19("Fist of Darkness")
			fn15(cframe, true)
			return
		end

		setState("Running")
		fn42()
	end

	local n10 = 0

	local function fn48()
		local doughKing = fn18("Dough King", true)

		if doughKing then
			v = doughKing
			setState("Running")
			local v3 = fn12()
			if not v3 then
				return
			end
			local humanoidRootPart = v3.HumanoidRootPart

			if (doughKing.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude >= 1500 then
				local map = Workspace:FindFirstChild("Map")
				map = map and map:FindFirstChild("CakeLoaf")
				map = map and map:FindFirstChild("BigMirror")
				local main = map and map:FindFirstChild("Main")

				if main then
					setStage("Entering the Cake Loaf mirror")
					fn14()

					pcall(function()
						firetouchinterest(humanoidRootPart, main, 0)
						task.wait(0.1)
						firetouchinterest(humanoidRootPart, main, 1)
					end)
				else
					setStage("Moving to the Cake Loaf portal")
					fn15(cframe2, true)
				end

				return
			end

			setStage("Killing Dough King")
			fn22(doughKing)
			return
		end

		setState("Running")

		if os.clock() - n10 >= 0.5 then
			n10 = os.clock()
			local CakePrinceSpawner = fn13("CakePrinceSpawner", true)

			if type(CakePrinceSpawner) == "string" and CakePrinceSpawner:find("open portal") then
				fn13("CakePrinceSpawner")
			end
		end

		if fn20("Sweet Chalice") then
			fn46(tbl9, "Farming cake mobs for Dough King")
			return
		end

		if fn20("God's Chalice") then
			local conjuredCocoa = fn21("Conjured Cocoa")

			if conjuredCocoa >= 10 then
				setStage("Trading for a Sweet Chalice")
				fn13("SweetChaliceNpc")
				return
			end

			fn46(tbl10, string.format("Farming Conjured Cocoa  %d / 10", conjuredCocoa))
			return
		end

		fn42()
	end

	local function fn49()
		if os.clock() - n4 < 5 then
			return
		end
		n4 = os.clock()
		fn3()
	end

	fn40()

	task.spawn(function()
		while not flag do
			local ok, result = pcall(function()
				if localPlayer.Team == nil then
					setState("Paused")
					setStage("Joining team " .. str2)

					if not fn(10) then
						fn41()
					end

					return
				end

				if not fn12() then
					setState("Paused")
					setStage("Waiting for the character to load")
					return
				end

				if v and not fn16(v) then
					v = nil
					fn10()
					fn3()
				end

				if not fn44() then
					return
				end

				if str3 == "Darkbeard" then
					fn47()
				else
					fn48()
				end
			end)

			if not ok then
				setState("Error")
				setStage(tostring(result))
				warn("[Night Hub] " .. tostring(result))
			end

			fn49()
			task.wait(0.1)
		end
	end)
end

nightHubDBDK.Stop = function()
	if flag then
		return
	end
	flag = true
	fn3()
	flag3 = false
	fn14()
	fn11()

	if getgenv().NightHubDBDK == nightHubDBDK then
		getgenv().NightHubDBDK = nil
	end
end

nightHubDBDK.SetState = setState
nightHubDBDK.SetStage = setStage
nightHubDBDK.Stats = stats
print("[Night Hub] Kaitun " .. str3 .. " loaded — target " .. str5)
