--[[
	ZYROX HUB - ESCOLHA DA INTERFACE
	Ao executar, abre uma tela temporaria para escolher:
		Fluent  = dawid (original)
		Modded  = Fluent-modded (StyearX) — temas / Personalizar
		Classic = interface antiga (banana)

	Se ja existir getgenv().ZyroxUI, a tela e pulada.
	Fallback de load: escolha -> alternativas -> Classic.
]]

-- Tela de escolha (so se ainda nao definiu ZyroxUI)
if not getgenv().ZyroxUI then
	local chosen = nil
	local UIS = game:GetService("UserInputService")
	local TS = game:GetService("TweenService")
	local host = (gethui and gethui()) or game:GetService("CoreGui")

	pcall(function()
		local old = host:FindFirstChild("ZyroxUIPicker")
		if old then
			old:Destroy()
		end
	end)

	local gui = Instance.new("ScreenGui")
	gui.Name = "ZyroxUIPicker"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 9999
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
		end
	end)
	gui.Parent = host

	local dim = Instance.new("Frame")
	dim.Size = UDim2.fromScale(1, 1)
	dim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	dim.BackgroundTransparency = 0.35
	dim.BorderSizePixel = 0
	dim.Parent = gui

	local card = Instance.new("Frame")
	card.AnchorPoint = Vector2.new(0.5, 0.5)
	card.Position = UDim2.fromScale(0.5, 0.5)
	card.Size = UDim2.fromOffset(360, 360)
	card.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
	card.BorderSizePixel = 0
	card.Parent = gui
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 16)
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 255, 255)
	stroke.Thickness = 1.5
	stroke.Transparency = 0.15
	stroke.Parent = card

	-- header bar
	local header = Instance.new("Frame")
	header.Size = UDim2.new(1, 0, 0, 52)
	header.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	header.BorderSizePixel = 0
	header.Parent = card
	Instance.new("UICorner", header).CornerRadius = UDim.new(0, 16)
	local headerFix = Instance.new("Frame")
	headerFix.Size = UDim2.new(1, 0, 0, 18)
	headerFix.Position = UDim2.new(0, 0, 1, -18)
	headerFix.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
	headerFix.BorderSizePixel = 0
	headerFix.Parent = header

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Size = UDim2.new(1, -24, 0, 24)
	title.Position = UDim2.fromOffset(16, 14)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 17
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "Zyrox Hub Interfaces"
	title.Parent = header

	local sub = Instance.new("TextLabel")
	sub.BackgroundTransparency = 1
	sub.Size = UDim2.new(1, -24, 0, 16)
	sub.Position = UDim2.fromOffset(16, 56)
	sub.Font = Enum.Font.Gotham
	sub.TextSize = 12
	sub.TextColor3 = Color3.fromRGB(150, 150, 160)
	sub.TextXAlignment = Enum.TextXAlignment.Left
	sub.Text = "selecione como quer abrir o hub"
	sub.Parent = card

	local list = Instance.new("Frame")
	list.BackgroundTransparency = 1
	list.Position = UDim2.fromOffset(16, 80)
	list.Size = UDim2.new(1, -32, 1, -100)
	list.Parent = card
	local layout = Instance.new("UIListLayout")
	layout.Padding = UDim.new(0, 8)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Parent = list

	local options = {
		{
			id = "Fluent",
			label = "Fluent",
			desc = "Original (dawid) — estavel",
			color = Color3.fromRGB(0, 140, 255),
		},
		{
			id = "Modded",
			label = "Fluent Modded",
			desc = "Temas, Personalizar, acrylic",
			color = Color3.fromRGB(160, 80, 255),
		},
		{
			id = "Classic",
			label = "Classic",
			desc = "Interface antiga (banana)",
			color = Color3.fromRGB(90, 200, 120),
		},
		{
			id = "Kaitun",
			label = "Kaitun",
			desc = "Full auto: level + seas + itens",
			color = Color3.fromRGB(255, 170, 40),
		},
	}

	local function makeBtn(opt, order)
		local btn = Instance.new("TextButton")
		btn.LayoutOrder = order
		btn.Size = UDim2.new(1, 0, 0, 52)
		btn.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
		btn.BorderSizePixel = 0
		btn.AutoButtonColor = false
		btn.Text = ""
		btn.Parent = list
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)
		local btnStroke = Instance.new("UIStroke")
		btnStroke.Color = Color3.fromRGB(255, 255, 255)
		btnStroke.Thickness = 1
		btnStroke.Transparency = 0.88
		btnStroke.Parent = btn

		local bar = Instance.new("Frame")
		bar.Size = UDim2.new(0, 3, 1, -14)
		bar.Position = UDim2.fromOffset(8, 7)
		bar.BackgroundColor3 = opt.color
		bar.BorderSizePixel = 0
		bar.Parent = btn
		Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

		local name = Instance.new("TextLabel")
		name.BackgroundTransparency = 1
		name.Position = UDim2.fromOffset(20, 7)
		name.Size = UDim2.new(1, -30, 0, 20)
		name.Font = Enum.Font.GothamBold
		name.TextSize = 14
		name.TextColor3 = Color3.fromRGB(255, 255, 255)
		name.TextXAlignment = Enum.TextXAlignment.Left
		name.Text = opt.label
		name.Parent = btn

		local desc = Instance.new("TextLabel")
		desc.BackgroundTransparency = 1
		desc.Position = UDim2.fromOffset(20, 28)
		desc.Size = UDim2.new(1, -30, 0, 16)
		desc.Font = Enum.Font.Gotham
		desc.TextSize = 11
		desc.TextColor3 = Color3.fromRGB(140, 140, 150)
		desc.TextXAlignment = Enum.TextXAlignment.Left
		desc.Text = opt.desc
		desc.Parent = btn

		btn.MouseEnter:Connect(function()
			TS:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(32, 32, 38) }):Play()
			TS:Create(btnStroke, TweenInfo.new(0.12), { Transparency = 0.55 }):Play()
		end)
		btn.MouseLeave:Connect(function()
			TS:Create(btn, TweenInfo.new(0.12), { BackgroundColor3 = Color3.fromRGB(22, 22, 26) }):Play()
			TS:Create(btnStroke, TweenInfo.new(0.12), { Transparency = 0.88 }):Play()
		end)
		btn.MouseButton1Click:Connect(function()
			chosen = opt.id
		end)
	end

	for i, opt in ipairs(options) do
		makeBtn(opt, i)
	end

	local hint = Instance.new("TextLabel")
	hint.BackgroundTransparency = 1
	hint.AnchorPoint = Vector2.new(0.5, 1)
	hint.Position = UDim2.new(0.5, 0, 1, -10)
	hint.Size = UDim2.new(1, -24, 0, 16)
	hint.Font = Enum.Font.Gotham
	hint.TextSize = 11
	hint.TextColor3 = Color3.fromRGB(110, 115, 130)
	hint.Text = "vale so para esta execucao"
	hint.Parent = card

	-- espera escolha (max 30s -> Fluent). se a GUI sumir, segue.
	local deadline = tick() + 30
	while not chosen and tick() < deadline do
		if not gui.Parent then
			break
		end
		task.wait(0.05)
	end
	if not chosen then
		chosen = "Fluent"
	end
	if chosen == "Kaitun" then
		getgenv().ZyroxKaitun = true
		-- Kaitun usa Fluent por baixo (estavel); UI ainda abre
		getgenv().ZyroxUI = "Fluent"
	else
		getgenv().ZyroxUI = chosen
	end
	pcall(function()
		gui:Destroy()
	end)
	print("[Zyrox] picker done -> " .. tostring(getgenv().ZyroxUI or chosen))
end

getgenv().ZyroxUI = getgenv().ZyroxUI or "Fluent"
print("[Zyrox] boot UI=" .. tostring(getgenv().ZyroxUI) .. " kaitun=" .. tostring(getgenv().ZyroxKaitun))

local function geniter(f, s, c)
	if type(f) ~= "function" then
		local mt = getmetatable(f)

		if type(mt) == "table" and mt.__iter then
			f, s, c = mt.__iter(f)
		elseif type(f) == "table" then
			f, s, c = next, f, nil
		end
	end

	return function()
		local r = table.pack(f(s, c))

		if r[1] == nil then
			return false
		end

		c = r[1]

		return true, table.unpack(r, 1, r.n)
	end
end

ply = game.Players
plr = ply.LocalPlayer

-- Root seguro (nao trava o script; atualiza quando o character spawna)
Root = nil
pcall(function()
	Root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
end)
plr.CharacterAdded:Connect(function(char)
	task.spawn(function()
		local hrp = char:WaitForChild("HumanoidRootPart", 15)
		if hrp then
			Root = hrp
		end
	end)
end)
-- se character ja existe mas Root ainda nil, tenta de novo em background
task.spawn(function()
	for _ = 1, 100 do
		if Root and Root.Parent then
			break
		end
		pcall(function()
			local ch = plr.Character
			if ch then
				local hrp = ch:FindFirstChild("HumanoidRootPart")
				if hrp then
					Root = hrp
				end
			end
		end)
		task.wait(0.2)
	end
end)

replicated = game:GetService("ReplicatedStorage")

Lv = 1
pcall(function()
	local data = plr:FindFirstChild("Data") or plr:WaitForChild("Data", 10)
	if data then
		local level = data:FindFirstChild("Level") or data:WaitForChild("Level", 10)
		if level then
			Lv = level.Value
			level:GetPropertyChangedSignal("Value"):Connect(function()
				Lv = level.Value
			end)
		end
	end
end)

-- Prioridade de movimento (ideia do TSUO): so uma tarefa mexe o personagem por vez; a mais importante vence.
-- Quanto menor o numero, maior a prioridade. Quem nao esta na lista conta como "farm" (22).
ZyroxPriority = { safemode = 0, protect = 1, fruit = 3, ripindra = 4, elite = 5, factory = 6, boss = 7, bartilo = 8, raid = 10, farm = 22 }
ZyroxMov = { owner = nil, untilT = 0, name = "" }
ZyroxClaim = function(name)
	local co = coroutine.running()
	local mine = ZyroxPriority[name] or 22
	if ZyroxMov.owner and ZyroxMov.owner ~= co and tick() < ZyroxMov.untilT then
		if (ZyroxPriority[ZyroxMov.name] or 22) <= mine then
			return false
		end
	end
	ZyroxMov.owner, ZyroxMov.untilT, ZyroxMov.name = co, tick() + 3, name
	return true
end
TeleportService = game:GetService("TeleportService")
TW = game:GetService("TweenService")
Lighting = game:GetService("Lighting")
Enemies = workspace.Enemies
vim1 = game:GetService("VirtualInputManager")
vim2 = game:GetService("VirtualUser")
TeamSelf = plr.Team
RunSer = game:GetService("RunService")
Stats = game:GetService("Stats")
do
	local e = plr.Character and plr.Character:FindFirstChild("Energy")
	Energy = (e and e.Value) or 0
end
BringConnections = {}
BossList = {}
MaterialList = {}
NPCList = {}
shouldTween = false
getgenv().OnFarm = false
getgenv().AutoMaterial = false
NextIs = false
senth = false
senth2 = false
SoulGuitar = false
KenTest = true
debug = false
Brazier1 = false
Brazier2 = false
Brazier3 = false
Sec = 0.1
ClickState = 0
Num_self = 25

do
	-- load leve: nao bloqueia 45s se Loading ficar Visible
	pcall(function()
		if not game:IsLoaded() then
			game.Loaded:Wait()
		end
	end)
	task.spawn(function()
		pcall(function()
			local main = plr.PlayerGui:FindFirstChild("Main") or plr.PlayerGui:WaitForChild("Main", 15)
			if not main then
				return
			end
			local loading = main:FindFirstChild("Loading")
			local t0 = tick()
			while loading and loading.Parent and loading.Visible and tick() - t0 < 20 do
				task.wait(0.2)
				loading = main:FindFirstChild("Loading")
			end
		end)
		pcall(function()
			if (not Root or not Root.Parent) and plr.Character then
				Root = plr.Character:FindFirstChild("HumanoidRootPart")
			end
		end)
	end)
end

World1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
World2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
World3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

do
	Marines = function()
		replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
	end
end

Pirates = function()
	replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end

if World1 then
	BossList = {
		"The Gorilla King",
		"Bobby",
		"The Saw",
		"Yeti",
		"Mob Leader",
		"Vice Admiral",
		"Saber Expert",
		"Warden",
		"Chief Warden",
		"Swan",
		"Magma Admiral",
		"Fishman Lord",
		"Wysper",
		"Thunder God",
		"Cyborg",
		"Ice Admiral",
		"Greybeard"
	}
elseif World2 then
	BossList = {
		"Diamond",
		"Jeremy",
		"Orbitus",
		"Don Swan",
		"Smoke Admiral",
		"Awakened Ice Admiral",
		"Tide Keeper",
		"Darkbeard",
		"Cursed Captain",
		"Order"
	}
elseif World3 then
	BossList = {
		"Stone",
		"Hydra Leader",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate",
		"Cake Queen",
		"Dough King",
		"Longma",
		"Soul Reaper",
		"rip_indra True Form",
		"Tyrant of the Skies"
	}
end

if World1 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Angel Wings",
		"Magma Ore",
		"Fish Tail"
	}
elseif World2 then
	MaterialList = {
		"Leather + Scrap Metal",
		"Radioactive Material",
		"Ectoplasm",
		"Mystic Droplet",
		"Magma Ore",
		"Vampire Fang"
	}
elseif World3 then
	MaterialList = {
		"Scrap Metal",
		"Demonic Wisp",
		"Conjured Cocoa",
		"Dragon Scale",
		"Gunpowder",
		"Fish Tail",
		"Mini Tusk"
	}
end

local t1 = {
	"Snow Lurker",
	"Arctic Warrior",
	"Hidden Key",
	"Awakened Ice Admiral"
}
local t2 = {
	"Part",
	"SpawnLocation",
	"Terrain",
	"WedgePart",
	"MeshPart"
}
local t3 = {
	"Swan Pirate",
	"Jeremy"
}
local t4 = {
	"Fajita",
	"Jeremy",
	"Diamond"
}
local t5 = { "Cookie Crafter" }
local t6 = { "Reborn Skeleton" }
local t7 = {
	["Pirate Millionaire"] = CFrame.new(-712.8272705078125, 98.577049255371094, 5711.9541015625),
	["Pistol Billionaire"] = CFrame.new(-723.43316650390625, 147.42906188964844, 5931.9931640625),
	["Dragon Crew Warrior"] = CFrame.new(7021.50439453125, 55.762702941894531, -730.12908935546875),
	["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
	["Female Islander"] = CFrame.new(4692.7939453125, 797.9766845703125, 858.8480224609375),
	["Venomous Assailant"] = CFrame.new(4902, 670, 39),
	["Marine Commodore"] = CFrame.new(2401, 123, -7589),
	["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
	["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
	["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
	["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
	["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
	["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
	["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
	["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
	["Living Zombie"] = CFrame.new(-10227, 421, 6161),
	["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
	["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
	["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
	["Peanut President"] = CFrame.new(-2215, 159, -10474),
	["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
	["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
	["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
	["Cake Guard"] = CFrame.new(-2024, 38, -12026),
	["Baking Staff"] = CFrame.new(-1932, 38, -12848),
	["Head Baker"] = CFrame.new(-1932, 38, -12848),
	["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
	["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
	["Sweet Thief"] = CFrame.new(116, 36, -12478),
	["Candy Rebel"] = CFrame.new(47, 61, -12889),
	Ghost = CFrame.new(5251, 5, 1111)
}
local t8 = {
	RFJobsRemoteFunction = replicated.Modules.Net["RF/JobsRemoteFunction"],
	RFCraft = replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/Craft")
}

EquipWeapon = function(p1)
	if not p1 then
		return
	end

	if plr.Backpack:FindFirstChild(p1) then
		plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(p1))
	end
end
weaponSc = function(p2)
	for _, child in pairs(plr.Backpack:GetChildren()) do
		if child:IsA("Tool") then
			if child.ToolTip == p2 then
				EquipWeapon(child.Name)
			end
		end
	end
end

local t9 = {}

t9.__index = t9
t9.Alive = function(p3)
	if not p3 then
		return
	end

	-- mob que o anti-trava pulou (nao tomou dano por 12s) fica de fora por 20s
	local skipped = p3:GetAttribute("ZyroxSkip")
	if skipped and tick() - skipped < 20 then
		return false
	end

	local Humanoid = p3:FindFirstChild("Humanoid")

	return Humanoid and Humanoid.Health > 0
end

do
	t9.Pos = function(p4, p5)
		local pos = typeof(p4) == "Vector3" and p4 or p4.Position
		return (plr.Character.HumanoidRootPart.Position - pos).Magnitude <= p5
	end
end

do
	t9.Dist = function(p6, p7)
		return (Root.Position - p6:FindFirstChild("HumanoidRootPart").Position).Magnitude <= p7
	end
end

do
	t9.DistH = function(p8, p9)
		return (Root.Position - p8:FindFirstChild("HumanoidRootPart").Position).Magnitude > p9
	end
end

t9.Kill = function(p10, p11)
	if p10 and p11 then
		if not p10:GetAttribute("Locked") then
			p10:SetAttribute("Locked", p10.HumanoidRootPart.CFrame)
		end

		PosMon = p10:GetAttribute("Locked").Position
		BringEnemy()
		EquipWeapon(_G.SelectWeapon)

		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

		if (Tool and Tool:FindFirstChild("ToolTip") and Tool.ToolTip or "") == "Blox Fruit" then
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
		else
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, math.rad(180), 0))
		end

		if RandomCFrame then
			wait(0.5)
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.5)
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
			wait(0.5)
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			wait(0.5)
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.5)
			_tp(p10.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
		end
	end
end
t9.Kill2 = function(p12, p13)
	if p12 and p13 then
		if not p12:GetAttribute("Locked") then
			p12:SetAttribute("Locked", p12.HumanoidRootPart.CFrame)
		end

		PosMon = p12:GetAttribute("Locked").Position
		BringEnemy()
		EquipWeapon(_G.SelectWeapon)

		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
		local ToolTip = Tool and Tool:FindFirstChild("ToolTip")

		if (ToolTip and Tool.ToolTip or "") == "Blox Fruit" then
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
		else
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 10, 8) * CFrame.Angles(0, math.rad(180), 0))
		end

		if RandomCFrame then
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
			wait(0.1)
			_tp(p12.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
		end
	end
end

do
	t9.KillSea = function(p14, p15)
		if p14 then
			if p15 then
				if not p14:GetAttribute("Locked") then
					p14:SetAttribute("Locked", p14.HumanoidRootPart.CFrame)
				end

				PosMon = p14:GetAttribute("Locked").Position
				BringEnemy()
				EquipWeapon(_G.SelectWeapon)

				local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")

				if (Tool and Tool:FindFirstChild("ToolTip") and Tool.ToolTip or "") == "Blox Fruit" then
					_tp(p14.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0) * CFrame.Angles(0, math.rad(90), 0))
				else
					notween(p14.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8))
					wait(0.85)
					notween(p14.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0))
					wait(1)
				end
			end
		end
	end
end

do
	t9.Sword = function(p16, p17)
		if p16 and p17 then
			if not p16:GetAttribute("Locked") then
				p16:SetAttribute("Locked", p16.HumanoidRootPart.CFrame)
			end

			PosMon = p16:GetAttribute("Locked").Position
			BringEnemy()
			weaponSc("Sword")
			_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

			if RandomCFrame then
				wait(0.1)
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.1)
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0))
				wait(0.1)
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
				wait(0.1)
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25))
				wait(0.1)
				_tp(p16.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0))
			end
		end
	end
end

do
	t9.Mas = function(p18, p19)
		if p18 and p19 then
			if not p18:GetAttribute("Locked") then
				p18:SetAttribute("Locked", p18.HumanoidRootPart.CFrame)
			end

			PosMon = p18:GetAttribute("Locked").Position
			BringEnemy()

			if p18.Humanoid.Health <= HealthM then
				_tp(p18.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

				local SelectedMasterySkills = _G.SelectedMasterySkills

				if type(SelectedMasterySkills) ~= "table" then
					SelectedMasterySkills = {
						"Z",
						"X",
						"C",
						"V",
						"F"
					}
				end

				for k, SelectedMasterySkill in pairs(SelectedMasterySkills) do
					if type(k) == "number" then
						Useskills("Blox Fruit", SelectedMasterySkill)
					elseif type(k) == "string" and SelectedMasterySkill == true then
						Useskills("Blox Fruit", k)
					end
				end
			else
				weaponSc("Melee")
				_tp(p18.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
			end
		end
	end
end

t9.Masgun = function(p20, p21)
	if p20 and p21 then
		if not p20:GetAttribute("Locked") then
			p20:SetAttribute("Locked", p20.HumanoidRootPart.CFrame)
		end

		PosMon = p20:GetAttribute("Locked").Position
		BringEnemy()

		if p20.Humanoid.Health <= HealthM then
			_tp(p20.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8))

			local SelectedMasterySkills = _G.SelectedMasterySkills

			if type(SelectedMasterySkills) ~= "table" then
				SelectedMasterySkills = {
					"Z",
					"X",
					"C",
					"V",
					"F"
				}
			end

			for k, SelectedMasterySkill in pairs(SelectedMasterySkills) do
				if type(k) == "number" then
					Useskills("Gun", SelectedMasterySkill)
				elseif type(k) == "string" and SelectedMasterySkill == true then
					Useskills("Gun", k)
				end
			end
		else
			weaponSc("Melee")
			_tp(p20.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
		end
	end
end

do
	statsSetings = function(p22, p23)
		if p22 ~= "Melee" then
			if p22 ~= "Defense" then
				if p22 ~= "Sword" then
					if p22 ~= "Gun" then
						if p22 == "Devil" and plr.Data.Points.Value ~= 0 then
							replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", p23)
						end
					elseif plr.Data.Points.Value ~= 0 then
						replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", p23)
					end
				elseif plr.Data.Points.Value ~= 0 then
					replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", p23)
				end
			elseif plr.Data.Points.Value ~= 0 then
				replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", p23)
			end
		elseif plr.Data.Points.Value ~= 0 then
			replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", p23)
		end
	end
end

BringEnemy = function(p24)
	if not _B then
		return
	end

	if not p24 then
		local HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local huge = math.huge

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			local Humanoid = child:FindFirstChildOfClass("Humanoid")
			local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

			if Humanoid and HumanoidRootPart2 and Humanoid.Health > 0 then
				local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude

				if Magnitude < huge then
					huge = Magnitude
					p24 = child
				end
			end
		end

		if not p24 then
			return
		end
	end

	local u34 = false

	local function v35(p25)
		local Humanoid = p25:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = p25:FindFirstChild("HumanoidRootPart")

		return Humanoid and HumanoidRootPart and Humanoid.Health > 0, HumanoidRootPart, Humanoid
	end
	local function v38(p26)
		if isnetworkowner then
			return isnetworkowner(p26)
		end

		return p26.ReceiveAge == 0 and not p26.Anchored and p26.Velocity.Magnitude > 0
	end

	pcall(function()
		if sethiddenproperty then
			sethiddenproperty(plr, "SimulationRadius", math.huge)
		end

		local Position = p24.HumanoidRootPart.Position
		local bringCount = 0

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child ~= p24 then
				local v42, v43, v44 = v35(child)

				if v42 and child.Name == p24.Name then
					local Magnitude = (v43.Position - Position).Magnitude

					if Magnitude <= 3000 and bringCount < 4 then
						bringCount = bringCount + 1


						if not v43:FindFirstChild("BodyVelocity") then
							local BodyVelocity = Instance.new("BodyVelocity")

							BodyVelocity.Name = "BodyVelocity"
							BodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
							BodyVelocity.Velocity = Vector3.zero
							BodyVelocity.Parent = v43
						end

						if Magnitude <= 10 then
							u34 = true
						end

						if not u34 and v38(v43) then
							v43.CFrame = CFrame.new(Position)
						end

						v43.CanCollide = false
						v44.WalkSpeed = 0
						v44.JumpPower = 0
					end
				end
			end
		end

		if p24 and p24:FindFirstChild("HumanoidRootPart") then
			p24.HumanoidRootPart.CanCollide = false
			p24.Humanoid.WalkSpeed = 0
			p24.Humanoid.JumpPower = 0
		end
	end)
end


do
	local function v47(p27, p28)
		local LocalPlayer = game.Players.LocalPlayer
		local Name
		local v50, v51, v52 = pairs(LocalPlayer.Character:GetChildren())
		local v53 = geniter(v50, v51, v52)

		while true do
			local v54 = table.pack(v53())

			if v54[1] then
				local v55 = v54[3]

				if v55:IsA("Tool") and v55.ToolTip == p27 then
					Name = v55.Name

					break
				end
			else
				break
			end
		end

		if not Name then
			local v56, v57, v58 = pairs(LocalPlayer.Backpack:GetChildren())

			for _, v1 in v56, v57, v58 do
				if v1:IsA("Tool") and v1.ToolTip == p27 then
					Name = v1.Name

					break
				end
			end
		end

		if Name then
			if LocalPlayer.PlayerGui:FindFirstChild("Main") then
				if LocalPlayer.PlayerGui.Main:FindFirstChild("Skills") then
					local v61 = LocalPlayer.PlayerGui.Main.Skills:FindFirstChild(Name)

					if v61 then
						local v62 = v61:FindFirstChild(p28)

						if not v62 then
							return false
						end

						local Title = v62:FindFirstChild("Title")

						if Title and Title:IsA("TextLabel") and Title.TextColor3.R < 0.5 then
							return false
						end

						local Cooldown = v62:FindFirstChild("Cooldown")

						if Cooldown and (Cooldown.Size.X.Scale > 0 or Cooldown.AbsoluteSize.X > 0) then
							return false
						end

						return true
					end
				end
			end
		end

		return true
	end

	Useskills = function(p29, p30)
		if p29 == "Melee" then
			weaponSc("Melee")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Sword" then
			weaponSc("Sword")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Blox Fruit" then
			weaponSc("Blox Fruit")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		elseif p29 == "Gun" then
			weaponSc("Gun")

			if not v47(p29, p30) then
				return
			end

			if p30 == "Z" then
				vim1:SendKeyEvent(true, "Z", false, game)
				vim1:SendKeyEvent(false, "Z", false, game)
			elseif p30 == "X" then
				vim1:SendKeyEvent(true, "X", false, game)
				vim1:SendKeyEvent(false, "X", false, game)
			elseif p30 == "C" then
				vim1:SendKeyEvent(true, "C", false, game)
				vim1:SendKeyEvent(false, "C", false, game)
			elseif p30 == "V" then
				vim1:SendKeyEvent(true, "V", false, game)
				vim1:SendKeyEvent(false, "V", false, game)
			elseif p30 == "F" then
				vim1:SendKeyEvent(true, "F", false, game)
				vim1:SendKeyEvent(false, "F", false, game)
			elseif p30 == "Y" then
				vim1:SendKeyEvent(true, "Y", false, game)
				vim1:SendKeyEvent(false, "Y", false, game)
			end
		end

		if p29 == "nil" and p30 == "Y" then
			vim1:SendKeyEvent(true, "Y", false, game)
			vim1:SendKeyEvent(false, "Y", false, game)
		end
	end
end

do
	local v65 = getrawmetatable(game)
	local __namecall = v65.__namecall

	setreadonly(v65, false)
	v65.__namecall = newcclosure(function(...)
		local v67 = getnamecallmethod()
		local t10 = { ... }

		if tostring(v67) ~= "FireServer" or tostring(t10[1]) ~= "RemoteEvent" or tostring(t10[2]) == "true" or tostring(t10[2]) == "false" then
			return __namecall(...)
		end

		if not _G.FarmMastery_G or SoulGuitar then
			if not (_G.FarmMastery_Dev or _G.FarmBlazeEM or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials or not ((not _G.AimMethod or ABmethod ~= "Aim Player") and (not _G.AimMethod or ABmethod ~= "Nearest Aim"))) then
				return __namecall(...)
			end
		end

		t10[2] = MousePos

		return __namecall(unpack(t10))
	end)
end

do
	GetConnectionEnemies = function(p31)
		for _, child in pairs(replicated:GetChildren()) do
			if not child:IsA("Model") or (typeof(p31) ~= "table" or not table.find(p31, child.Name)) and child.Name ~= p31 then
				continue
			end

			if child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
				return child
			end
		end

		local children, v72 = game.Workspace.Enemies:GetChildren()

		for _, v1 in next, children, v72 do
			if v1:IsA("Model") and (typeof(p31) == "table" and table.find(p31, v1.Name) or v1.Name == p31) and v1:FindFirstChild("Humanoid") and v1.Humanoid.Health > 0 then
				return v1
			end
		end
	end
end

LowCpu = function()
	local Terrain = game.Workspace.Terrain

	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 0
	game.Lighting.GlobalShadows = false
	game.Lighting.FogEnd = 9e9
	game.Lighting.Brightness = 0
	settings().Rendering.QualityLevel = "Level01"

	for _, descendant in pairs(game:GetDescendants()) do
		if descendant:IsA("Part") or descendant:IsA("Union") or descendant:IsA("CornerWedgePart") or descendant:IsA("TrussPart") then
			descendant.Material = "Plastic"
			descendant.Reflectance = 0
		else
			if not descendant:IsA("Decal") then
				if not descendant:IsA("Texture") then
					if not descendant:IsA("ParticleEmitter") then
						if not descendant:IsA("Trail") then
							if descendant:IsA("Explosion") then
								descendant.BlastPressure = 1
								descendant.BlastRadius = 1
							elseif descendant:IsA("Fire") or descendant:IsA("SpotLight") or descendant:IsA("Smoke") or descendant:IsA("Sparkles") then
								descendant.Enabled = false
							elseif descendant:IsA("MeshPart") then
								descendant.Material = "Plastic"
								descendant.Reflectance = 0
								descendant.TextureID = 10385902758728956
							end

							continue
						end
					end

					descendant.Lifetime = NumberRange.new(0)

					continue
				end
			end

			descendant.Transparency = 1
		end
	end

	for _, child in pairs(game.Lighting:GetChildren()) do
		if child:IsA("BlurEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("BloomEffect") or child:IsA("DepthOfFieldEffect") then
			child.Enabled = false
		end
	end
end

do
	CheckF = function()
		if not (GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune")) then
			if not GetBP("T-Rex-T-Rex") then
				return
			end
		end

		return true
	end
end

-- Barco do jogador (logica do 3nn: checa Owner e vida do barco, sem quebrar com barcos sem Owner)
CheckBoat = function()
	for _, child in pairs(workspace.Boats:GetChildren()) do
		if child:IsA("Model") then
			local owner = child:FindFirstChild("Owner")
			local hum = child:FindFirstChild("Humanoid")
			if owner and tostring(owner.Value) == tostring(plr.Name) and (not hum or hum.Value > 0) then
				ZyroxBoatWasAlive = true
				return child
			end
		end
	end

	return false
end
CheckEnemiesBoat = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child.Name == "FishBoat" then
			local health = child:FindFirstChild("Health")
			if health and health.Value > 0 then
				return true
			end
		end
	end

	return false
end
CheckPirateGrandBrigade = function()
	for _, child in pairs(workspace.Enemies:GetChildren()) do
		if child.Name == "PirateGrandBrigade" or child.Name == "PirateBrigade" then
			local health = child:FindFirstChild("Health")
			if health and health.Value > 0 then
				return true
			end
		end
	end

	return false
end

do
	CheckShark = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Shark" and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

do
	CheckTerrorShark = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Terrorshark" and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

do
	CheckPiranha = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Piranha" and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

do
	CheckFishCrew = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if (child.Name == "Fish Crew Member" or child.Name == "Haunted Crew Member") and t9.Alive(child) then
				return true
			end
		end

		return false
	end
end

CheckHauntedCrew = function()
	local v94, v95, v96 = pairs(workspace.Enemies:GetChildren())
	local v97 = geniter(v94, v95, v96)
	local v98

	while true do
		local v99 = table.pack(v97())

		if v99[1] then
			v98 = v99[3]

			if v98.Name == "Haunted Crew Member" then
				break
			end
		else
			return false
		end
	end

	while not t9.Alive(v98) do
		while true do
			local v100 = table.pack(v97())

			if v100[1] then
				v98 = v100[3]

				if v98.Name == "Haunted Crew Member" then
					break
				end
			else
				return false
			end
		end
	end

	return true
end
CheckSeaBeast = function()
	if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
		return true
	end

	return false
end
CheckLeviathan = function()
	if workspace.SeaBeasts:FindFirstChild("Leviathan") then
		return true
	end

	return false
end

do
	UpdStFruit = function()
		local children, v102 = plr.Backpack:GetChildren()

		for _, v1 in next, children, v102 do
			StoreFruit = v1:FindFirstChild("EatRemote", true)

			if StoreFruit then
				replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(v1.Name))
			end
		end
	end
end

collectFruits = function(p32)
	if p32 then
		local Character = plr.Character

		for _, child in pairs(workspace:GetChildren()) do
			if string.find(child.Name, "Fruit") then
				child.Handle.CFrame = Character.HumanoidRootPart.CFrame
			end
		end
	end
end

do
	Getmoon = function()
		if World1 then
			return Lighting.FantasySky.MoonTextureId
		end

		if World2 then
			return Lighting.FantasySky.MoonTextureId
		end

		if World3 then
			return Lighting.Sky.MoonTextureId
		end
	end
end

DropFruits = function()
	local children, v109 = plr.Backpack:GetChildren()

	for _, v1 in next, children, v109 do
		if string.find(v1.Name, "Fruit") then
			EquipWeapon(v1.Name)
			wait(0.1)

			if plr.PlayerGui.Main.Dialogue.Visible == true then
				plr.PlayerGui.Main.Dialogue.Visible = false
			end

			EquipWeapon(v1.Name)
			plr.Character:FindFirstChild(v1.Name).EatRemote:InvokeServer("Drop")
		end
	end

	for _, child in pairs(plr.Character:GetChildren()) do
		if string.find(child.Name, "Fruit") then
			EquipWeapon(child.Name)
			wait(0.1)

			if plr.PlayerGui.Main.Dialogue.Visible == true then
				plr.PlayerGui.Main.Dialogue.Visible = false
			end

			EquipWeapon(child.Name)
			plr.Character:FindFirstChild(child.Name).EatRemote:InvokeServer("Drop")
		end
	end
end
GetBP = function(p33)
	return plr.Backpack:FindFirstChild(p33) or plr.Character:FindFirstChild(p33)
end
GetIn = function(p34)
	for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v1) ~= "table" then
			continue
		end

		if v1.Name == p34 then
			return true
		end

		if plr.Character:FindFirstChild(p34) then
			return true
		end

		if plr.Backpack:FindFirstChild(p34) then
			return true
		end
	end

	return false
end
GetM = function(p35)
	for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v1) == "table" and v1.Type == "Material" and v1.Name == p35 then
			return v1.Count
		end
	end

	return 0
end

do
	GetWP = function(p36)
		local response = replicated.Remotes.CommF_:InvokeServer("getInventory")

		if type(response) ~= "table" then
			return false
		end

		for _, v1 in pairs(response) do
			if type(v1) ~= "table" or v1.Type ~= "Sword" then
				continue
			end

			if v1.Name == p36 then
				return true
			end

			if plr.Character then
				if plr.Character:FindFirstChild(p36) then
					return true
				end
			end

			if not plr.Backpack then
				continue
			end

			if plr.Backpack:FindFirstChild(p36) then
				return true
			end
		end

		return false
	end
end

getInfinity_Ability = function(p37, p38)
	if not Root then
		return
	end

	if p37 == "Soru" and p38 then
		local next_ = next
		local v122, v123 = getgc()

		for _, v1 in next_, v122, v123 do
			if plr.Character.Soru and typeof(v1) == "function" and getfenv(v1).script == plr.Character.Soru then
				local next_2 = next
				local v127, v128 = getupvalues(v1)

				for _, v2 in next_2, v127, v128 do
					if typeof(v2) == "table" then
						repeat
							wait(Sec)
							v2.LastUse = 0
						until plr.Character.Humanoid.Health <= 0
					end
				end
			end
		end
	elseif p37 == "Energy" and p38 then
		plr.Character.Energy.Changed:connect(function()
			if p38 then
				plr.Character.Energy.Value = Energy
			end
		end)
	elseif p37 == "Observation" and p38 then
		plr.VisionRadius.Value = math.huge
	end
end

do
	Hop = function()
		pcall(function()
			for i = math.random(1, math.random(40, 75)), 100 do
				for k, v1 in next, replicated.__ServerBrowser:InvokeServer(i), nil do
					if tonumber(v1.Count) < 12 then
						TeleportService:TeleportToPlaceInstance(game.PlaceId, k)
					end
				end
			end
		end)
	end
end

local Part = Instance.new("Part", workspace)

Part.Size = Vector3.new(1, 1, 1)
Part.Name = "Rip_Indra"
Part.Anchored = true
Part.CanCollide = false
Part.CanTouch = false
Part.Transparency = 1

do
	local PartName = workspace:FindFirstChild(Part.Name)

	if PartName and PartName ~= Part then
		PartName:Destroy()
	end
end

task.spawn(function()
	while task.wait() do
		if not Part or Part.Parent ~= workspace then
			getgenv().OnFarm = false
		elseif shouldTween then
			getgenv().OnFarm = true
		else
			getgenv().OnFarm = false
		end
	end
end)
task.spawn(function()
	local LocalPlayer = game.Players.LocalPlayer

	while true do
		task.wait()

		if not LocalPlayer.Character then
			continue
		end

		if LocalPlayer.Character.PrimaryPart then
			break
		end
	end

	Part.CFrame = LocalPlayer.Character.PrimaryPart.CFrame

	while task.wait() do
		pcall(function()
			if getgenv().OnFarm then
				if not _G.WasOnFarm then
					_G.WasOnFarm = true
				end

				if Part and Part.Parent == workspace then
					local PrimaryPart = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart

					if PrimaryPart and (PrimaryPart.Position - Part.Position).Magnitude <= 200 then
						PrimaryPart.CFrame = CFrame.new(Part.Position)
					else
						Part.CFrame = PrimaryPart.CFrame
					end
				end

				local Character = LocalPlayer.Character

				if Character then
					for _, child in pairs(Character:GetChildren()) do
						if child:IsA("BasePart") then
							child.CanCollide = false
						end
					end
				end
			elseif _G.WasOnFarm then
				_G.WasOnFarm = false

				local Character = LocalPlayer.Character

				if Character then
					for _, child in pairs(Character:GetChildren()) do
						if child:IsA("BasePart") then
							child.CanCollide = true
						end
					end
				end
			end
		end)
	end
end)

local ReplicatedStorage = game:GetService("ReplicatedStorage")

game:GetService("TweenService")
game:GetService("RunService")

do
	local LocalPlayer = game:GetService("Players").LocalPlayer

	sea1 = game.PlaceId == 2753915549 or game.PlaceId == 85211729168715
	sea2 = game.PlaceId == 4442272183 or game.PlaceId == 79091703265657
	sea3 = game.PlaceId == 7449423635 or game.PlaceId == 100117331123089

	local t11 = {
		["Tween Speed"] = 270,
		["Bypass Teleport"] = false,
		["Up Y"] = false,
		["Up Y When Low Health"] = false,
		["Same Y"] = false
	}
	local cFrame = CFrame.new(10641.0918, -1953.92981, 9825.07031, -0.652825892, -9.2805891e-08, -0.757508039, -2.73638356e-08, 1, -9.89323823e-08, 0.757508039, -4.38572947e-08, -0.652825892)
	local cFrame2 = CFrame.new(-16271.126, 25.5847301, 1371.98755, 0.999396622, -5.78875188e-08, -0.0347310975, 5.52972779e-08, 1, -8.7544322e-08, 0.034731105, 8.28877091e-08, 0.999396741)

	Convert_CFrame = function(p39)
		if not p39 then
			return
		end

		if typeof(p39) == "Vector3" then
			return CFrame.new(p39)
		end

		if typeof(p39) == "CFrame" then
			return p39
		end

		if typeof(p39) == "Model" then
			return p39:GetPivot()
		end

		if p39.CFrame then
			return p39.CFrame
		end

		return nil
	end
	GetDistance = function(p40, p41, p42)
		if p40 == nil then
			return 9e9
		end

		local Character = LocalPlayer.Character

		if not Character then
			return 9e9
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if not Humanoid or Humanoid.Health <= 0 then
			return 9e9
		end

		if p41 == nil then
			p41 = Character:FindFirstChild("HumanoidRootPart")

			if not p41 then
				return 9e9
			end
		end

		local v151 = Convert_CFrame(p40)
		local v152 = Convert_CFrame(p41)

		if p42 then
			return (Vector3.new(v151.X, 0, v151.Z) - Vector3.new(v152.X, 0, v152.Z)).Magnitude
		end

		return (v151.Position - v152.Position).Magnitude
	end
	InArea = function(p43)
		local _WorldOrigin = workspace:FindFirstChild("_WorldOrigin")

		if not _WorldOrigin then
			return {
				Name = ""
			}
		end

		local v154 = Convert_CFrame(p43)
		local children, v156 = _WorldOrigin.Locations:GetChildren()

		for _, v1 in next, children, v156 do
			if v1:FindFirstChild("Mesh") and (v154.Position - v1.Position).Magnitude <= v1.Mesh.Scale.X then
				return v1
			end
		end

		return {
			Name = ""
		}
	end
	GetSpawnPoint = function(p44)
		local Pirates_ = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("PlayerSpawns") and workspace._WorldOrigin.PlayerSpawns:FindFirstChild("Pirates")

		if not Pirates_ then
			return
		end

		local children, v161 = Pirates_:GetChildren()

		for _, v1 in next, children, v161 do
			if v1:FindFirstChild("Part") and (v1.Part.Position - p44.Position).Magnitude <= 2500 then
				return v1
			end
		end
	end
	CheckLegendaryItems = function()
		local function v164(p45)
			local children, v166 = LocalPlayer.Backpack:GetChildren()

			for _, v1 in next, children, v166 do
				if v1:IsA("Tool") and (v1.Name == p45 or string.find(v1.Name, p45)) then
					return v1
				end
			end

			local children2, v170 = LocalPlayer.Character:GetChildren()

			for _, v1 in next, children2, v170 do
				if v1:IsA("Tool") and (v1.Name == p45 or string.find(v1.Name, p45)) then
					return v1
				end
			end
		end

		if not v164("God's Chalice") then
			if not v164("Fist of Darkness") then
				if not v164("Sweet Chalice") then
					if not v164("Hallow Essence") then
						if not v164("Flower1") then
							return false
						end
					end
				end
			end
		end

		return true
	end
	WaitForHumanoid = function()
		local Character = LocalPlayer.Character

		if not Character then
			return nil
		end

		local Humanoid = Character:FindFirstChild("Humanoid")

		if Humanoid then
			return Humanoid
		end

		local v175 = tick() + 5

		while tick() < v175 do
			local Humanoid2 = Character:FindFirstChild("Humanoid")

			if Humanoid2 then
				return Humanoid2
			end

			task.wait(0.1)
		end

		return nil
	end
	checkinventory = function(p46)
		if p46 then
			for _, v1 in pairs(ReplicatedStorage.Remotes.CommF_:InvokeServer("getInventory")) do
				if v1.Name == p46 then
					return true
				end
			end
		end

		return false
	end
	getdis = function(p47, p48)
		local CFrame_ = p48 or LocalPlayer.Character.HumanoidRootPart.CFrame

		return (CFrame.new(p47.X, CFrame_.Y, p47.Z).Position - CFrame.new(CFrame_.X, CFrame_.Y, CFrame_.Z).Position).Magnitude
	end
	CanBypassTeleport = function(p49)
		local Name = InArea(p49).Name

		if Name == "" then
			return false
		end

		if not (not t11["Bypass Teleport"] or Name:find("Dimension") or Name:find("Submerged") or Name == "Sealed Cavern") then
			if not (Name:lower():find("under") or CheckLegendaryItems()) then
				if LocalPlayer.Data and LocalPlayer.Data.LastSpawnPoint and LocalPlayer.Data.LastSpawnPoint.Value == "SubmergedIsland" then
					return false
				end

				if GetDistance(p49.Position) <= 3500 then
					return false
				end

				return true
			end
		end

		return false
	end
	GetBypassCFrame = function(p50)
		local huge = math.huge
		local v182
		local children = workspace._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
		local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		for _, v1 in next, children, nil do
			if v1:FindFirstChild("Part") and (p50.Position - HumanoidRootPart.Position).Magnitude >= 3000 and GetSpawnPoint(v1.Part) ~= GetSpawnPoint(HumanoidRootPart) then
				if (v1.Part.Position - HumanoidRootPart.Position).Magnitude <= 10000 and (v1.Part.Position - p50.Position).Magnitude <= huge then
					huge = (v1.Part.Position - p50.Position).Magnitude
					v182 = v1
				end
			end
		end

		return v182
	end
	BypassTP = function(p51)
		local Character = LocalPlayer.Character

		if not Character then
			return
		end

		local v188 = WaitForHumanoid()

		if not v188 or v188.Health <= 0 then
			return
		end

		if CanBypassTeleport(p51) and GetBypassCFrame(p51) then
			local v189 = GetBypassCFrame(p51)

			if v189 and v189:FindFirstChild("Part") then
				Character.LastSpawnPoint.Disabled = true
				ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", v189.Name)
				ReplicatedStorage.Remotes.CommF_:InvokeServer("SetSpawnPoint")
				Character:PivotTo(v189.Part.CFrame)
				v188:ChangeState(15)

				while true do
					task.wait()

					if not LocalPlayer.Character then
						continue
					end

					if WaitForHumanoid() and WaitForHumanoid().Health > 0 then
						break
					end
				end
			end
		end
	end
	totopofgreattree = function()
		if getdis(CFrame.new(28310.0234, 14895.1123, 109.456741)) > 1500 then
			ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(28310.0234, 14895.1123, 109.456741))
			wait(0.3)
		end

		local cFrame3 = CFrame.new(28607.5352, 14896.5449, 106.011726)

		_tp(cFrame3)

		repeat
			wait()
		until getdis(cFrame3) <= 5

		wait(0.5)

		for i = 1, 4 do
			ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "TeleportBack")
		end
	end
	requestentrance = function(p52)
		local Position = p52

		if typeof(p52) == "CFrame" then
			Position = p52.Position
		elseif typeof(p52) == "Instance" then
			Position = p52:IsA("BasePart") and p52.Position or p52:GetPivot().Position
		elseif typeof(p52) == "Vector3" then
			Position = p52
		end

		if typeof(Position) ~= "Vector3" then
			return
		end

		local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

		if not root then
			return
		end

		-- portal so em viagens longas; cooldown curto pra nao spammar
		local direct = (Position - root.Position).Magnitude

		if direct < 2500 or tick() - (_G.ZyroxPortalLast or 0) < 4 then
			return
		end

		-- posicoes dos pontos de entrada/saida lidas do mapa (como no arquivo novo)
		local mapPart = function(...)
			local node = workspace:FindFirstChild("Map")

			for _, name in ipairs({ ... }) do
				node = node and (node:FindFirstChild(name) or node:FindFirstChild(name, true))
			end

			if not node then
				return nil
			end

			if node:IsA("BasePart") then
				return node.Position
			end

			local ok, pivot = pcall(function()
				return node:GetPivot().Position
			end)

			return ok and pivot or nil
		end

		local t12 = {}
		local add = function(name, pos)
			if typeof(pos) == "Vector3" then
				t12[name] = pos
			end
		end

		if sea1 then
			add("FishmanSea1", mapPart("TeleportSpawn", "EntrancePoint"))
			add("Sky2", mapPart("SkyArea2", "PathwayHouse", "EntrancePoint"))
			add("Sky1", mapPart("SkyArea1", "PathwayTemple", "ExitPoint"))
			add("Sky3", Vector3.new(-7894, 5547, -380))
			add("Sky3Exit", Vector3.new(-4607, 874, -1667))
			add("UnderWater", Vector3.new(61163, 11, 1819))
			add("Underwater City", Vector3.new(61165.19140625, 0.18704631924629211, 1897.379150390625))
			add("Pirate Village", Vector3.new(-1242.4625244140625, 4.7870597839355469, 3901.282958984375))
			add("UnderwaterExit", Vector3.new(4050, -1, -1814))
		elseif sea2 then
			add("CaFe", Vector3.new(-288, 305, 613))
			add("SwanRoom", Vector3.new(2284, 15, 897))
			add("GhostShip", mapPart("GhostShipInterior", "TeleportSpawn"))
			add("Cursed Ship", Vector3.new(923, 126, 32852))
			add("Zombie Island", Vector3.new(-6509, 83, -133))
			add("Swan Mansion", Vector3.new(-390, 332, 673))
		else
			add("Castle", Vector3.new(-5058, 314, -3155))
			add("Mansion", Vector3.new(-12463, 374, -7523))
			add("Hydra Island", Vector3.new(5657.88623046875, 1013.0790405273438, -335.4996337890625))

			-- o Valkyrie Helm so e exigido para Temple of Time / Great Tree (antes ele bloqueava TODOS os portais do Sea 3)
			if checkinventory("Valkyrie Helm") then
				add("Temple of Time", Vector3.new(28286, 14897, 103))
				add("Greate Tree", Vector3.new(3024.1709, 2280.69434, -7325.12793))
			end
		end

		-- portais que ja falharam ficam 15 min fora da escolha
		local bad = _G.ZyroxPortalBad or {}
		_G.ZyroxPortalBad = bad

		local bestName, best
		local bestDist = math.huge

		for name, pos in pairs(t12) do
			local dist = (pos - Position).Magnitude

			if dist < bestDist and tick() - (bad[name] or -1e9) > 900 then
				bestName, best, bestDist = name, pos, dist
			end
		end

		-- so usa se o portal deixa o alvo mais perto (pelo menos ~10%)
		if not best or not (bestDist < direct * 0.9) then
			return
		end

		_G.ZyroxPortalLast = tick()

		pcall(function()
			if _G.TweenCache then
				_G.TweenCache:Cancel()
			end
		end)

		-- Great Tree: com a Race V4 no progresso 2+ o caminho e pelo topo da arvore
		if bestName == "Greate Tree" then
			local okc, progress = pcall(function()
				return ReplicatedStorage.Remotes.CommF_:InvokeServer("RaceV4Progress", "Check")
			end)

			if okc and type(progress) == "number" and progress >= 2 then
				totopofgreattree()
				wait(1)

				return
			end
		end

		ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", best)
		wait(1)

		-- se depois do portal o alvo nao ficou mais perto, descarta esse portal
		local root2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

		if root2 and (Position - root2.Position).Magnitude >= direct then
			bad[bestName] = tick()
		end
	end
	_tp = function(p53)
		if ZyroxMov.owner then
			if ZyroxMov.owner == coroutine.running() then
				ZyroxMov.untilT = tick() + 3
			elseif tick() < ZyroxMov.untilT and (ZyroxPriority[ZyroxMov.name] or 22) < 22 then
				return
			end
		end
		local cFrame3

		if typeof(p53) == "Vector3" then
			cFrame3 = CFrame.new(p53)
		elseif typeof(p53) == "CFrame" then
			cFrame3 = p53
		else
			cFrame3 = p53 and p53.CFrame
		end

		if not cFrame3 then
			return
		end

		if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") then
			return
		end

		local HumanoidRootPart = plr.Character.HumanoidRootPart

		getgenv().OnFarm = false
		pcall(function()
			if CanBypassTeleport(cFrame3) then
				BypassTP(cFrame3)
				task.wait(0.5)
			end
		end)
		pcall(function()
			requestentrance(p53)
		end)

		-- Ilha submersa (Sea 3): VOA ate o NPC do submarino na superficie, depois pede o travel.
		-- Nao usa old_tp (TP instantaneo) — isso era o bug que o dj reportou.
		if sea3 and getdis(cFrame3.Position, cFrame.Position) < 2500 then
			local HumanoidRootPart2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart2 and math.abs(cFrame.Position.Y - HumanoidRootPart2.Position.Y) > 800 then
				local subDeadline = tick() + 90
				local lastSubTry = 0

				-- voa ate o ponto do NPC (cFrame2 = superficie perto do Submarine Worker)
				while tick() < subDeadline and getdis(cFrame3.Position) >= 2000 do
					HumanoidRootPart2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
					if not HumanoidRootPart2 then
						task.wait(0.2)
					else
						local nearSurface = getdis(cFrame2) < 15
						if not nearSurface then
							-- tween voando ate o NPC (sem CFrame instantaneo)
							if ZyroxSubmarine.flyTo then
								ZyroxSubmarine.flyTo(cFrame2, 320)
							else
								-- fallback: tween da peca-guia
								local dist = (cFrame2.Position - HumanoidRootPart2.Position).Magnitude
								Part.CFrame = HumanoidRootPart2.CFrame
								local tw = game:GetService("TweenService"):Create(
									Part,
									TweenInfo.new(math.max(dist / 320, 0.2), Enum.EasingStyle.Linear),
									{ CFrame = cFrame2 }
								)
								shouldTween = true
								getgenv().OnFarm = true
								tw:Play()
								local t0 = tick()
								while tick() - t0 < dist / 320 + 2 and getdis(cFrame2) > 15 do
									task.wait(0.05)
								end
								pcall(function()
									tw:Cancel()
								end)
							end
						end

						if getdis(cFrame2) < 15 and tick() - lastSubTry > 5 then
							lastSubTry = tick()
							-- tenta sistema novo; se falhar, WorkerSpeak (como Banana/Vxeze)
							local used = false
							if ZyroxSubmarine.travelNear then
								used = ZyroxSubmarine.travelNear(cFrame3.Position)
							end
							if not used then
								local Net = ReplicatedStorage.Modules.Net
								pcall(function()
									Net["RF/SubmarineWorkerSpeak"]:InvokeServer("AskKilledTikiBoss")
								end)
								task.wait(0.4)
								pcall(function()
									Net["RF/SubmarineWorkerSpeak"]:InvokeServer("TravelToSubmergedIsland")
								end)
								pcall(function()
									ReplicatedStorage.Remotes.CommF_:InvokeServer("SetLastSpawnPoint", "SubmergedIsland")
								end)
							end
							task.wait(1.2)
						end
					end
					task.wait(0.1)
				end

				task.wait(0.5)
				pcall(function()
					HumanoidRootPart2 = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
					if HumanoidRootPart2 and HumanoidRootPart2:FindFirstChild("BodyClip") then
						HumanoidRootPart2.BodyClip:Destroy()
					end
				end)
			end
		end

		local Magnitude = (cFrame3.Position - HumanoidRootPart.Position).Magnitude
		local tweenInfo = TweenInfo.new(Magnitude / (Magnitude <= 15 and (getgenv().TweenSpeedNear or 270) or getgenv().TweenSpeedFar or 270), Enum.EasingStyle.Linear)
		local tween = game:GetService("TweenService"):Create(Part, tweenInfo, {
			CFrame = CFrame.new(cFrame3.Position)
		})

		if plr.Character.Humanoid.Sit == true then
			Part.CFrame = CFrame.new(Part.Position.X, cFrame3.Y, Part.Position.Z)
		end

		tween:Play()
		task.spawn(function()
			while tween.PlaybackState == Enum.PlaybackState.Playing do
				if shouldTween then
					task.wait(0.1)
				else
					tween:Cancel()

					break
				end
			end

			getgenv().OnFarm = true
		end)

		return tween
	end
end

-- Submarino (logica do arquivo novo): RF/SubmarineTransportation -> GetAvailableLocations / InitiateTeleport
ZyroxSubmarine = { cache = nil, readAt = 0 }

ZyroxSubmarine.remote = function()
	for _, descendant in ipairs(replicated:GetDescendants()) do
		if descendant.Name == "RF/SubmarineTransportation" then
			return descendant
		end
	end
end

ZyroxSubmarine.npc = function()
	local npcs = workspace:FindFirstChild("NPCs")
	return npcs and npcs:FindFirstChild("Submarine Worker2")
end

ZyroxSubmarine.destinations = function()
	if ZyroxSubmarine.cache and tick() - ZyroxSubmarine.readAt < 120 then
		return ZyroxSubmarine.cache
	end
	local remote = ZyroxSubmarine.remote()
	if remote then
		local ok, result = pcall(function()
			return remote:InvokeServer("GetAvailableLocations")
		end)
		if ok and type(result) == "table" then
			ZyroxSubmarine.cache = result
			ZyroxSubmarine.readAt = tick()
		end
	end
	return ZyroxSubmarine.cache
end

-- destino cujo ponto final fica mais perto de `position`
ZyroxSubmarine.nearest = function(position)
	local list = ZyroxSubmarine.destinations()
	if not list then
		return nil
	end
	local best, bestDist = nil, math.huge
	for _, dest in pairs(list) do
		if type(dest) == "table" and dest.Name and dest.EndLocation then
			local point = typeof(dest.EndLocation) == "CFrame" and dest.EndLocation.Position or dest.EndLocation
			local dist = (point - position).Magnitude
			if dist < bestDist then
				best, bestDist = dest, dist
			end
		end
	end
	return best, bestDist
end

-- viaja para o destino mais perto de `position`; devolve true se o servidor aceitou
-- NAO da TP instantaneo no NPC: voa (tween da peca-guia) ate chegar perto
ZyroxSubmarine.flyTo = function(goalCF, speed)
	speed = speed or 300
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not root or not Part then
		return false
	end
	if typeof(goalCF) == "Vector3" then
		goalCF = CFrame.new(goalCF)
	end
	local dist = (goalCF.Position - root.Position).Magnitude
	if dist <= 12 then
		return true
	end
	pcall(function()
		if _G.TweenCache then
			_G.TweenCache:Cancel()
		end
	end)
	Part.CFrame = root.CFrame
	local info = TweenInfo.new(math.max(dist / speed, 0.15), Enum.EasingStyle.Linear)
	local tw = game:GetService("TweenService"):Create(Part, info, { CFrame = goalCF })
	_G.TweenCache = tw
	shouldTween = true
	getgenv().OnFarm = true
	tw:Play()
	local deadline = tick() + math.max(dist / speed, 0.2) + 2
	while tick() < deadline do
		root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if not root then
			break
		end
		if (root.Position - goalCF.Position).Magnitude <= 12 then
			pcall(function()
				tw:Cancel()
			end)
			return true
		end
		task.wait(0.05)
	end
	pcall(function()
		tw:Cancel()
	end)
	root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	return root and (root.Position - goalCF.Position).Magnitude <= 25
end

ZyroxSubmarine.travelNear = function(position)
	local remote = ZyroxSubmarine.remote()
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not remote or not root then
		return false
	end
	local dest, dist = ZyroxSubmarine.nearest(position)
	if not dest or (root.Position - position).Magnitude <= dist then
		return false
	end
	local npc = ZyroxSubmarine.npc()
	local npcRoot = npc and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart)
	if npcRoot and (root.Position - npcRoot.Position).Magnitude > 12 then
		-- voa ate o NPC (sem CFrame instantaneo)
		ZyroxSubmarine.flyTo(npcRoot.CFrame * CFrame.new(0, 3, 4), 320)
		task.wait(0.4)
	end
	root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
	if not root then
		return false
	end
	local ok, result = pcall(function()
		return remote:InvokeServer("InitiateTeleport", dest.Name)
	end)
	return ok and type(result) == "table"
end

do
	old_tp = function(p54)
		if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			plr.Character.HumanoidRootPart.CFrame = p54
		end
	end
end

do
	TeleportToTarget = function(p55)
		local v207 = _tp(p55)

		if v207 then
			v207.Completed:Wait()
		end

		task.wait(0.1)
	end
end

notween = function(p56)
	plr.Character.HumanoidRootPart.CFrame = p56

	-- a peca-guia do _tp puxa o personagem de volta a cada frame; sem mover ela junto (e cancelar o tween em andamento)
	-- o personagem ficava "voltando" para a posicao antiga (ex.: armas que nao sao fruta no t9.KillSea)
	pcall(function()
		Part.CFrame = p56
		game:GetService("TweenService"):Create(Part, TweenInfo.new(0), { CFrame = p56 }):Play()
	end)
end

do
	BTP = function(p57)
		local LocalPlayer = game.Players.LocalPlayer
		local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
		local Humanoid = LocalPlayer.Character.Humanoid
		local Main = LocalPlayer.PlayerGui.Main
		local Position = HumanoidRootPart.Position

		repeat
			Humanoid.Health = 0
			HumanoidRootPart.CFrame = p57
			Main.Quest.Visible = false

			if (HumanoidRootPart.Position - Position).Magnitude > 1 then
				Position = HumanoidRootPart.Position
				HumanoidRootPart.CFrame = p57
			end

			task.wait(0.5)
		until (p57.Position - HumanoidRootPart.Position).Magnitude <= 2000
	end
end

do
	spawn(function()
		while task.wait() do
			pcall(function()
				if _G.HalloweenFarm or _G.FarmEliteH or _G.AutoRaid3nn or _G.AutoFindLeviathan3nn or _G.MultiFindLeviathan3nn or _G.AutoStartLeviathan3nn or _G.AutoDestroyIDK3nn or _G.AutoFireHeart3nn or _G.AutoSecretQuest or _G.AutoRaidX or _G.FightShopActive or _G.Auto_StartRaid or _G.SailBoat_Hydra or _G.WardenBoss or _G.AutoFactory or _G.HighestMirage or _G.HCM or _G.PGB or _G.Leviathan1 or _G.UPGDrago or _G.Complete_Trials or _G.TpDrago_Prehis or _G.BuyDrago or _G.AutoFireFlowers or _G.DT_Uzoth or _G.AutoBerry or _G.Prefully or _G.Prehis_Find or _G.Prehis_Skills or _G.Prehis_DB or _G.Prehis_DE or _G.FarmBlazeEM or _G.Dojoo or _G.CollectPresent or _G.AutoLawKak or _G.TpLab or _G.AutoPhoenixF or _G.AutoFarmChest or _G.AutoHytHallow or _G.LongsWord or _G.BlackSpikey or _G.AutoHolyTorch or _G.TrainDrago or _G.AutoSaber or _G.FarmMastery_Dev or _G.CitizenQuest or _G.AutoEctoplasm or _G.KeysRen or _G.Auto_Rainbow_Haki or _G.obsFarm or _G.AutoBigmom or _G.Doughv2 or _G.AuraBoss or _G.Raiding or _G.Auto_Cavender or _G.TpPly or _G.Bartilo_Quest or _G.Level or _G.FarmEliteHunt or _G.AutoZou or _G.AutoFarm_Bone or getgenv().AutoMaterial or _G.CraftVM or _G.FrozenTP or _G.TPDoor or _G.AcientOne or _G.AutoFarmNear or _G.AutoRaidCastle or _G.DarkBladev3 or _G.AutoFarmRaid or _G.Auto_Cake_Prince or _G.Addealer or _G.TPNpc or _G.TwinHook or _G.FindMirage or _G.FarmChestM or _G.Shark or _G.TerrorShark or _G.Piranha or _G.MobCrew or _G.SeaBeast1 or _G.FishBoat or _G.AutoPole or _G.AutoPoleV2 or _G.Auto_SuperHuman or _G.AutoDeathStep or _G.Auto_SharkMan_Karate or _G.Auto_Electric_Claw or _G.AutoDragonTalon or _G.Auto_Def_DarkCoat or _G.Auto_God_Human or _G.Auto_Tushita or _G.AutoMatSoul or _G.AutoKenVTWO or _G.AutoSerpentBow or _G.AutoFMon or _G.Auto_Soul_Guitar or _G.TPGEAR or _G.AutoSaw or _G.AutoTridentW2 or _G.AutoEvoRace or _G.AutoGetQuestBounty or _G.MarinesCoat or _G.TravelDres or _G.Defeating or _G.DummyMan or _G.Auto_Yama or _G.Auto_SwanGG or _G.SwanCoat or _G.AutoEcBoss or _G.Auto_Mink or _G.Auto_Human or _G.Auto_Skypiea or _G.Auto_Fish or _G.CDK_TS or _G.CDK_YM or _G.CDK or _G.AutoFarmGodChalice or _G.AutoFistDarkness or _G.AutoMiror or _G.Teleport or _G.AutoKilo or _G.AutoGetUsoap or _G.Praying or _G.TryLucky or _G.AutoColShad or _G.AutoUnHaki or _G.Auto_DonAcces or _G.AutoRipIngay or _G.DragoV3 or _G.DragoV1 or _G.SailBoats or NextIs or _G.FarmGodChalice or _G.IceBossRen or senth or senth2 or _G.Lvthan or _G.beasthunter or _G.DangerLV or _G.Relic123 or _G.tweenKitsune or _G.Collect_Ember or _G.AutofindKitIs or _G.snaguine or _G.TwFruits or _G.tweenKitShrine or _G.Tp_LgS or _G.Tp_MasterA or _G.tweenShrine or _G.FarmMastery_G or _G.FarmMastery_S or _G.FarmBoss or _G.AutoFarmAllBoss or _G.AutoFishSlap or _G.FarmTyrant or _G.FarmPhaBinh or _G.AutoSpawnCP or _G.AutoBerryH or _G.AutoChestBP or _G.FarmEliteHop or _G.AutoHop_Dough or _G.AutoDoughKing or _G.AutoAttackDoughKing or _G.StartEvent or _G.AutoMysticIsland or _G.AutoPlayerHunter or _G.SafeMode or _G.AutoKillMob or _G.AutoStartPrehistoric or _G.AutoUnHaki or _G.AutoAttackRipIndra or _G.AutoFarmIsland or _G.AutoFarmDungeon or _G.AutoFarmCandy or _G.AutoTP_Gift or _G.AutoTPGift or _G.AutoTPAndCollect or _G.MasterAutoLevel or _G.MasterAutoCandy or _G.TPFloor1 or _G.TPFloor2 or _G.TPFloor3 or _G.TPFloor4 then
					shouldTween = true

					if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						local BodyVelocity = Instance.new("BodyVelocity")

						BodyVelocity.Name = "BodyClip"
						BodyVelocity.Parent = plr.Character.HumanoidRootPart
						BodyVelocity.MaxForce = Vector3.new(100000, 100000, 100000)
						BodyVelocity.Velocity = Vector3.new(0, 0, 0)
					end

					if not plr.Character:FindFirstChild("highlight") then
						local Highlight = Instance.new("Highlight")

						Highlight.Name = "highlight"
						Highlight.Enabled = true
						Highlight.FillColor = Color3.fromRGB(128, 128, 128)
						Highlight.OutlineColor = Color3.fromRGB(128, 128, 128)
						Highlight.FillTransparency = 0.5
						Highlight.OutlineTransparency = 0.2
						Highlight.Parent = plr.Character
					end

					for _, descendant in pairs(plr.Character:GetDescendants()) do
						if descendant:IsA("BasePart") then
							descendant.CanCollide = false
						end
					end
				else
					shouldTween = false

					if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
						plr.Character.HumanoidRootPart:FindFirstChild("BodyClip"):Destroy()
					end

					if plr.Character:FindFirstChild("highlight") then
						plr.Character:FindFirstChild("highlight"):Destroy()
					end
				end
			end)
		end
	end)
end

do
	QuestB = function()
		if World1 then
			if _G.FindBoss == "The Gorilla King" then
				bMon = "The Gorilla King"
				Qname = "JungleQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
				PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, 0.707079291, 0, 1, 0, -0.707079291, 0, -0.707134247)
			elseif _G.FindBoss == "Bobby" then
				bMon = "Bobby"
				Qname = "BuggyQuest1"
				Qdata = 3
				PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
				PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344)
			elseif _G.FindBoss == "The Saw" then
				bMon = "The Saw"
				PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906)
			elseif _G.FindBoss == "Yeti" then
				bMon = "Yeti"
				Qname = "SnowQuest"
				Qdata = 3
				PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
				PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
			elseif _G.FindBoss == "Mob Leader" then
				bMon = "Mob Leader"
				PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813)
			elseif _G.FindBoss == "Vice Admiral" then
				bMon = "Vice Admiral"
				Qname = "MarineQuest2"
				Qdata = 2
				PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625)
				PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375)
			elseif _G.FindBoss == "Saber Expert" then
				bMon = "Saber Expert"
				PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564)
			elseif _G.FindBoss == "Warden" then
				bMon = "Warden"
				Qname = "ImpelQuest"
				Qdata = 1
				PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, -4.49946401e-06, 0.975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, 0.220546961)
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
			elseif _G.FindBoss == "Chief Warden" then
				bMon = "Chief Warden"
				Qname = "ImpelQuest"
				Qdata = 2
				PosB = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939)
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
			elseif _G.FindBoss == "Swan" then
				bMon = "Swan"
				Qname = "ImpelQuest"
				Qdata = 3
				PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812)
				PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, 0.681965172, 0, 1, 0, -0.681965172, 0, -0.731384635)
			elseif _G.FindBoss == "Magma Admiral" then
				bMon = "Magma Admiral"
				Qname = "MagmaQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875)
				PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875)
			elseif _G.FindBoss == "Fishman Lord" then
				bMon = "Fishman Lord"
				Qname = "FishmanQuest"
				Qdata = 3
				PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734)
				PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984)
			elseif _G.FindBoss == "Wysper" then
				bMon = "Wysper"
				Qname = "SkyExp1Quest"
				Qdata = 3
				PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094)
				PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531)
			elseif _G.FindBoss == "Thunder God" then
				bMon = "Thunder God"
				Qname = "SkyExp2Quest"
				Qdata = 3
				PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125)
				PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188)
			elseif _G.FindBoss == "Cyborg" then
				bMon = "Cyborg"
				Qname = "FountainQuest"
				Qdata = 3
				PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875)
				PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813)
			elseif _G.FindBoss == "Ice Admiral" then
				bMon = "Ice Admiral"
				Qdata = nil
				PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
				PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, 0.81913656, 0, -0.573599219)
			elseif _G.FindBoss == "Greybeard" then
				bMon = "Greybeard"
				Qdata = nil
				PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
				PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188)
			end
		end

		if World2 then
			if _G.FindBoss == "Diamond" then
				bMon = "Diamond"
				Qname = "Area1Quest"
				Qdata = 3
				PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375)
				PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407)
			elseif _G.FindBoss == "Jeremy" then
				bMon = "Jeremy"
				Qname = "Area2Quest"
				Qdata = 3
				PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063)
				PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109)
			elseif _G.FindBoss == "Orbitus" then
				bMon = "Orbitus"
				Qname = "MarineQuest3"
				Qdata = 3
				PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031)
				PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625)
			elseif _G.FindBoss == "Don Swan" then
				bMon = "Don Swan"
				PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875)
			elseif _G.FindBoss == "Smoke Admiral" then
				bMon = "Smoke Admiral"
				Qname = "IceSideQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813)
				PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875)
			elseif _G.FindBoss == "Awakened Ice Admiral" then
				bMon = "Awakened Ice Admiral"
				Qname = "FrostQuest"
				Qdata = 3
				PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813)
				PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125)
			elseif _G.FindBoss == "Tide Keeper" then
				bMon = "Tide Keeper"
				Qname = "ForgottenQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625)
				PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188)
			elseif _G.FindBoss == "Darkbeard" then
				bMon = "Darkbeard"
				Qdata = nil
				PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
				PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
			elseif _G.FindBoss == "Cursed Captaim" then
				bMon = "Cursed Captain"
				Qdata = nil
				PosQBoss = CFrame.new(916.928589, 181.092773, 33422)
				PosB = CFrame.new(916.928589, 181.092773, 33422)
			elseif _G.FindBoss == "Order" then
				bMon = "Order"
				Qdata = nil
				PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
				PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875)
			end
		end

		if World3 then
			if _G.FindBoss == "Stone" then
				bMon = "Stone"
				Qname = "PiratePortQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625)
				PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438)
			elseif _G.FindBoss == "Hydra Leader" then
				bMon = "Hydra Leader"
				Qname = "VenomCrewQuest"
				Qdata = 3
				PosQBoss = CFrame.new(5211.021484375, 1004.35778859375, 758.18475341796875)
				PosB = CFrame.new(5821.89794921875, 1019.0950927734375, -73.719230651855469)
			elseif _G.FindBoss == "Kilo Admiral" then
				bMon = "Kilo Admiral"
				Qname = "MarineTreeIsland"
				Qdata = 3
				PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938)
				PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125)
			elseif _G.FindBoss == "Captain Elephant" then
				bMon = "Captain Elephant"
				Qname = "DeepForestIsland"
				Qdata = 3
				PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875)
				PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125)
			elseif _G.FindBoss == "Beautiful Pirate" then
				bMon = "Beautiful Pirate"
				Qname = "DeepForestIsland2"
				Qdata = 3
				PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375)
				PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285)
			elseif _G.FindBoss == "Cake Queen" then
				bMon = "Cake Queen"
				Qname = "IceCreamIslandQuest"
				Qdata = 3
				PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, 0.642767608, 0, 1, 0, -0.642767608, 0, -0.766061664)
				PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, -0.417492568, 0.0167988986, -0.90852499)
			elseif _G.FindBoss == "Longma" then
				bMon = "Longma"
				Qdata = nil
				PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
				PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125)
			elseif _G.FindBoss == "Soul Reaper" then
				bMon = "Soul Reaper"
				Qdata = nil
				PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
				PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813)
			end
		end
	end
end

QuestBeta = function()
	QuestB()

	return {
		[0] = _G.FindBoss,
		bMon,
		Qdata,
		Qname,
		PosB,
		PosQBoss
	}
end

do
	local Quests = require(game:GetService("ReplicatedStorage"):WaitForChild("Quests"))
	local GuideModule = require(game:GetService("ReplicatedStorage"):WaitForChild("GuideModule"))
	local t13 = {
		"MarineQuest",
		"BartiloQuest",
		"CitizenQuest",
		"Trainees"
	}

	CheckSea = function(p58)
		if (game.PlaceId == 2753915549 or game.PlaceId == 85211729168715) and p58 == 1 then
			return true
		end

		if (game.PlaceId == 4442272183 or game.PlaceId == 79091703265657) and p58 == 2 then
			return true
		end

		if (game.PlaceId == 7449423635 or game.PlaceId == 100117331123089) and p58 == 3 then
			return true
		end

		return false
	end
	GetQuestPointFromNPC = function(p59)
		for _, child in pairs(workspace.NPCs:GetChildren()) do
			if child.Name ~= p59 then
				continue
			end

			if child:FindFirstChild("HumanoidRootPart") then
				return child.HumanoidRootPart.CFrame
			end
		end

		for _, child in pairs(replicated.NPCs:GetChildren()) do
			if child.Name == p59 and child:FindFirstChild("HumanoidRootPart") then
				return child.HumanoidRootPart.CFrame
			end
		end

		return nil
	end
	GetQuests = function()
		local Value = plr.Data.Level.Value
		local n1 = 0
		local t14 = {}

		if Value >= 700 and CheckSea(1) then
			t14.Mob = "Galley Captain"
			t14.NameQuest = "FountainQuest"
			t14.ID = 2
			t14.LevelReq = 700
		elseif Value >= 1500 and CheckSea(2) then
			t14.Mob = "Water Fighter"
			t14.NameQuest = "ForgottenQuest"
			t14.ID = 2
			t14.LevelReq = 1450
		else
			for k, Quest in pairs(Quests) do
				local v229, v230, v231 = pairs(Quest)
				local v232 = geniter(v229, v230, v231)
				local v233 = table.pack(v232())

				if v233[1] then
					local v234 = v233[2]
					local v235 = v233[3]

					while true do
						local LevelReq = v235.LevelReq

						for k2 in pairs(v235.Task) do
							if LevelReq <= Value and n1 <= LevelReq and v235.Task[k2] > 1 and not table.find(t13, k) then
								n1 = LevelReq
								t14.Mob = k2
								t14.NameQuest = k
								t14.ID = v234
								t14.LevelReq = LevelReq
							end
						end

						local v238 = table.pack(v232())

						if not v238[1] then
							break
						end

						v234 = v238[2]
						v235 = v238[3]
					end
				end
			end
		end

		return t14
	end
	GetQuestPoint = function()
		if GuideModule then
			if GuideModule.Data then
				if GuideModule.Data.LastClosestNPC then
					return GetQuestPointFromNPC(GuideModule.Data.LastClosestNPC)
				end
			end
		end

		return nil
	end
end

do
	MaterialMon = function()
		local LocalPlayer = game.Players.LocalPlayer

		if LocalPlayer.Character then
			local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				shouldRequestEntrance = function(p60, p61)
					if p61 <= (HumanoidRootPart.Position - p60).Magnitude then
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", p60)
					end
				end

				if not World1 then
					if not World2 then
						if World3 then
							if SelectMaterial == "Scrap Metal" then
								MMon = {
									"Jungle Pirate",
									"Forest Pirate"
								}
								MPos = CFrame.new(-11975.78515625, 331.77340698242188, -10620.0302734375)
								SP = "Default"
							elseif SelectMaterial == "Fish Tail" then
								MMon = {
									"Fishman Raider",
									"Fishman Captain"
								}
								MPos = CFrame.new(-10993, 332, -8940)
								SP = "Default"
							elseif SelectMaterial == "Conjured Cocoa" then
								MMon = {
									"Chocolate Bar Battler",
									"Cocoa Warrior"
								}
								MPos = CFrame.new(620.63446044921875, 78.936447143554688, -12581.369140625)
								SP = "Default"
							elseif SelectMaterial == "Dragon Scale" then
								MMon = {
									"Dragon Crew Archer",
									"Dragon Crew Warrior"
								}
								MPos = CFrame.new(6594, 383, 139)
								SP = "Default"
							elseif SelectMaterial == "Gunpowder" then
								MMon = { "Pistol Billionaire" }
								MPos = CFrame.new(-84.855690002441406, 85.620613098144531, 6132.0087890625)
								SP = "Default"
							elseif SelectMaterial == "Mini Tusk" then
								MMon = { "Mythological Pirate" }
								MPos = CFrame.new(-13545, 470, -6917)
								SP = "Default"
							elseif SelectMaterial == "Demonic Wisp" then
								MMon = { "Demonic Soul" }
								MPos = CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125)
								SP = "Default"
							end
						end
					elseif SelectMaterial == "Leather + Scrap Metal" then
						MMon = { "Marine Captain" }
						MPos = CFrame.new(-2010.5059814453125, 73.00115966796875, -3326.620849609375)
						SP = "Default"
					elseif SelectMaterial == "Magma Ore" then
						MMon = {
							"Magma Ninja",
							"Lava Pirate"
						}
						MPos = CFrame.new(-5428, 78, -5959)
						SP = "Default"
					elseif SelectMaterial == "Ectoplasm" then
						MMon = {
							"Ship Deckhand",
							"Ship Engineer",
							"Ship Steward",
							"Ship Officer"
						}
						MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625)
						SP = "Default"
						shouldRequestEntrance(Vector3.new(61163.8515625, 5.3423423767089844, 1819.7841796875), 18000)
					elseif SelectMaterial == "Mystic Droplet" then
						MMon = { "Water Fighter" }
						MPos = CFrame.new(-3385, 239, -10542)
						SP = "Default"
					elseif SelectMaterial == "Radioactive Material" then
						MMon = { "Factory Staff" }
						MPos = CFrame.new(295, 73, -56)
						SP = "Default"
					elseif SelectMaterial == "Vampire Fang" then
						MMon = { "Vampire" }
						MPos = CFrame.new(-6033, 7, -1317)
						SP = "Default"
					end
				elseif SelectMaterial == "Angel Wings" then
					MMon = {
						"Shanda",
						"Royal Squad",
						"Royal Soldier",
						"Wysper",
						"Thunder God"
					}
					MPos = CFrame.new(-4698, 845, -1912)
					SP = "Default"
					shouldRequestEntrance(Vector3.new(-4607.82275, 872.54248, -1667.55688), 10000)
				elseif SelectMaterial == "Leather + Scrap Metal" then
					MMon = {
						"Brute",
						"Pirate"
					}
					MPos = CFrame.new(-1145, 15, 4350)
					SP = "Default"
				elseif SelectMaterial == "Magma Ore" then
					MMon = {
						"Military Soldier",
						"Military Spy",
						"Magma Admiral"
					}
					MPos = CFrame.new(-5815, 84, 8820)
					SP = "Default"
				elseif SelectMaterial == "Fish Tail" then
					MMon = {
						"Fishman Warrior",
						"Fishman Commando",
						"Fishman Lord"
					}
					MPos = CFrame.new(61123, 19, 1569)
					SP = "Default"
					shouldRequestEntrance(Vector3.new(61163.8515625, 5.3423423767089844, 1819.7841796875), 17000)
				end

				return
			end
		end
	end
end

do
	QuestNeta = function()
		local v241 = GetQuests()

		return {
			v241.Mob,
			v241.ID,
			v241.NameQuest,
			v241.LevelReq,
			v241.Mob,
			(GetQuestPoint())
		}
	end
end

-- ===================== UI: Fluent / Fluent-modded / Classic =====================
-- Escolha: getgenv().ZyroxUI = "Fluent" | "Modded" | "Classic"  (veja o topo do arquivo)
-- Fallback: Modded -> Fluent -> Classic se o load falhar.
local ZYROX_UI_CHOICE = tostring(getgenv().ZyroxUI or "Fluent"):lower()
local ZYROX_FLUENT_ACTIVE = false
local ZYROX_UI_NAME = "Classic"

local function ZyroxLoadOldUI()
	return loadstring(game:HttpGet("https://raw.githubusercontent.com/HavocXRealDev/zyrox/refs/heads/main/UI%20banana%20zyrox"))()
end

-- source: "fluent" (dawid) ou "modded" (StyearX Fluent-modded)
local function ZyroxBuildFluentAdapter(source)
	source = tostring(source or "fluent"):lower()
	local urls = {}
	if source == "modded" or source == "fluentmod" or source == "fluent-modded" then
		-- Fluent-modded (StyearX) — temas extras, icones, minimizer mobile
		urls = {
			"https://github.com/StyearX/Fluent-Modded/releases/download/Fluent/FluentPro",
			"https://github.com/StyearX/Fluent-modded/releases/download/Fluent/FluentPro",
			"https://github.com/StyearX/Fluent-Modded/releases/latest/download/FluentPro",
		}
	else
		urls = {
			"https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua",
		}
	end

	local Fluent, lastErr
	for _, url in ipairs(urls) do
		local ok, result = pcall(function()
			return loadstring(game:HttpGet(url))()
		end)
		if ok and type(result) == "table" and result.CreateWindow then
			Fluent = result
			break
		end
		lastErr = result
	end
	assert(Fluent, "Fluent (" .. source .. ") did not load: " .. tostring(lastErr))

	local UserInputService = game:GetService("UserInputService")
	local adapter = {}
	local window
	local uid = 0
	local firstToggleUI = true

	local nextId = function(prefix, text)
		uid = uid + 1
		return prefix .. "_" .. uid .. "_" .. (tostring(text or ""):gsub("%W", "_"))
	end

	local dummy = function()
		return setmetatable({}, {
			__index = function()
				return function() end
			end,
		})
	end

	local safe = function(label, fn)
		local ok, result = pcall(fn)
		if ok then
			return result
		end
		warn("[ZyroxUI] could not create '" .. tostring(label) .. "': " .. tostring(result))
		return dummy()
	end

	-- callbacks: dawid Fluent usa OnChanged; Fluent-modded usa Callback no config (e as vezes OnChanged)
	local bind = function(label, element, callback)
		if not callback or not element then
			return
		end
		local wrapped = function(value)
			local ok, err = pcall(callback, value)
			if not ok then
				warn("[ZyroxUI] callback '" .. tostring(label) .. "': " .. tostring(err))
			end
		end
		local ok = pcall(function()
			element:OnChanged(wrapped)
		end)
		if not ok then
			pcall(function()
				if element.OnChanged then
					element.OnChanged(element, wrapped)
				end
			end)
		end
	end

	local isModded = (source == "modded" or source == "fluentmod" or source == "fluent-modded")

	local wrap = function(element)
		return setmetatable({}, {
			__index = function(_, key)
				local value = element[key]
				if type(value) == "function" then
					return function(_, ...)
						return value(element, ...)
					end
				end
				return value
			end,
		})
	end

	local newGroup = function(tab, name)
		-- Fluent-modded: AddSection(title, icon); dawid: AddSection(title)
		local section
		local okSec, secRes = pcall(function()
			if isModded then
				return tab:AddSection(tostring(name), "lucide/folder")
			end
			return tab:AddSection(tostring(name))
		end)
		if okSec and secRes then
			section = secRes
		else
			-- fallback: elementos direto na tab
			section = tab
			pcall(function()
				tab:AddParagraph({ Title = tostring(name), Content = "" })
			end)
		end

		local host = section
		local function addOn(method, ...)
			local args = { ... }
			-- tenta na section; se falhar, na tab
			local ok, res = pcall(function()
				return host[method](host, table.unpack(args))
			end)
			if ok and res ~= nil then
				return res
			end
			ok, res = pcall(function()
				return tab[method](tab, table.unpack(args))
			end)
			if ok then
				return res
			end
			error(tostring(res))
		end

		local group = {}

		function group:AddToggle(id, cfg)
			cfg = cfg or {}
			local title = cfg.Text or tostring(id)
			return safe(title, function()
				local opts = {
					Title = title,
					Description = cfg.Tooltip or cfg.Desc,
					Default = cfg.Default and true or false,
					Callback = cfg.Callback, -- Fluent-modded
				}
				local element = addOn("AddToggle", nextId("T", id), opts)
				bind(title, element, cfg.Callback)
				return wrap(element)
			end)
		end

		function group:AddButton(cfg)
			cfg = cfg or {}
			local title = cfg.Text or "Button"
			local fn = cfg.Func or cfg.Callback
			return safe(title, function()
				addOn("AddButton", {
					Title = title,
					Description = cfg.Tooltip or cfg.Desc,
					Callback = function()
						if fn then
							local ok, err = pcall(fn)
							if not ok then
								warn("[ZyroxUI] button '" .. title .. "': " .. tostring(err))
							end
						end
					end,
				})
				return dummy()
			end)
		end

		function group:AddLabel(text)
			return safe("label", function()
				local split = function(value)
					value = tostring(value or "")
					local first, rest = value:match("^([^\n]*)\n(.*)$")
					if first then
						return first, rest
					end
					return value, ""
				end
				local title, content = split(text)
				local paragraph = addOn("AddParagraph", { Title = title, Content = content })
				local label = {}
				label.SetText = function(a, b)
					local newTitle, newContent = split((b ~= nil) and b or a)
					pcall(function()
						paragraph:SetTitle(newTitle)
					end)
					pcall(function()
						paragraph:SetDesc(newContent)
					end)
					pcall(function()
						if paragraph.SetValue then
							paragraph:SetValue(newTitle)
						end
					end)
				end
				return label
			end)
		end

		function group:AddDropdown(id, cfg)
			cfg = cfg or {}
			local title = cfg.Text or tostring(id)
			local values = cfg.Values or cfg.List or {}
			local multi = cfg.Multi and true or false
			return safe(title, function()
				local default
				if multi then
					default = nil
				elseif isModded then
					-- modded prefere string
					if type(cfg.Default) == "string" then
						default = cfg.Default
					elseif type(cfg.Default) == "number" and values[cfg.Default] then
						default = values[cfg.Default]
					end
				else
					if type(cfg.Default) == "number" then
						default = cfg.Default
					elseif type(cfg.Default) == "string" then
						default = table.find(values, cfg.Default)
					end
				end
				local opts = {
					Title = title,
					Description = cfg.Tooltip or cfg.Desc,
					Values = values,
					Multi = multi,
					Default = default,
					Callback = cfg.Callback,
				}
				local element = addOn("AddDropdown", nextId("D", id), opts)
				if multi and type(cfg.Default) == "table" then
					local selected = {}
					for key, val in pairs(cfg.Default) do
						if type(key) == "number" then
							selected[val] = true
						elseif val then
							selected[key] = true
						end
					end
					pcall(function()
						element:SetValue(selected)
					end)
				end
				bind(title, element, cfg.Callback)
				return wrap(element)
			end)
		end

		function group:AddSlider(a, b)
			local id, cfg
			if type(a) == "table" then
				cfg = a
				id = cfg.Text
			else
				id = a
				cfg = b or {}
			end
			local title = cfg.Text or tostring(id or "Slider")
			return safe(title, function()
				local min = cfg.Min or 0
				local opts = {
					Title = title,
					Description = cfg.Tooltip or cfg.Desc,
					Default = cfg.Default or min,
					Min = min,
					Max = cfg.Max or 100,
					Rounding = cfg.Rounding or 0,
					Callback = cfg.Callback,
				}
				local element = addOn("AddSlider", nextId("S", id), opts)
				bind(title, element, cfg.Callback)
				return wrap(element)
			end)
		end

		function group:AddInput(id, cfg)
			cfg = cfg or {}
			local title = cfg.Text or tostring(id)
			return safe(title, function()
				local opts = {
					Title = title,
					Default = cfg.Default or "",
					Placeholder = cfg.Placeholder or "",
					Numeric = cfg.Numeric or false,
					Finished = cfg.Finished or false,
					Callback = cfg.Callback,
				}
				local element = addOn("AddInput", nextId("I", id), opts)
				bind(title, element, cfg.Callback)
				return wrap(element)
			end)
		end

		return group
	end

	function adapter:CreateWindow(cfg)
		cfg = cfg or {}
		local mobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
		local themeName = "Dark"
		-- Fluent-modded traz temas extras (AMOLED, etc.)
		if source == "modded" or source == "fluentmod" or source == "fluent-modded" then
			themeName = cfg.Theme or "AMOLED"
		elseif cfg.Theme then
			themeName = cfg.Theme
		end

		window = Fluent:CreateWindow({
			Title = cfg.Title or "Zyrox Hub",
			SubTitle = cfg.Subtitle or cfg.SubTitle or "",
			TabWidth = mobile and 120 or 160,
			Size = mobile and UDim2.fromOffset(500, 320) or UDim2.fromOffset(580, 460),
			Acrylic = source == "modded" or source == "fluentmod" or source == "fluent-modded",
			Theme = themeName,
			MinimizeKey = Enum.KeyCode.RightControl,
			Search = (source == "modded" or source == "fluentmod" or source == "fluent-modded") and true or false,
		})

		-- botao flutuante (celular): abre/fecha a janela
		pcall(function()
			local holder = (gethui and gethui()) or game:GetService("CoreGui")
			local gui = Instance.new("ScreenGui")
			gui.Name = "ZyroxFluentBtn"
			gui.ResetOnSpawn = false
			gui.DisplayOrder = 998
			pcall(function()
				if syn and syn.protect_gui then
					syn.protect_gui(gui)
				end
			end)
			gui.Parent = holder
			local button = Instance.new("ImageButton")
			button.Size = UDim2.fromOffset(44, 44)
			button.Position = UDim2.new(0, 12, 0.5, -22)
			button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
			button.Image = cfg.Image or ""
			button.ScaleType = Enum.ScaleType.Crop
			button.Active = true
			button.Draggable = true
			button.Parent = gui
			Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)
			button.MouseButton1Click:Connect(function()
				pcall(function() window:Minimize() end)
			end)
		end)

		local win = {}
		function win:AddTab(name)
			local tab
			local okTab, tabRes = pcall(function()
				if isModded then
					return window:AddTab({ Title = tostring(name), Icon = "lucide/layout-grid" })
				end
				return window:AddTab({ Title = tostring(name), Icon = "" })
			end)
			if okTab and tabRes then
				tab = tabRes
			else
				tab = window:AddTab({ Title = tostring(name) })
			end
			local t = {}
			function t:AddLeftGroupbox(n)
				return newGroup(tab, n)
			end
			function t:AddRightGroupbox(n)
				return newGroup(tab, n)
			end
			return t
		end
		function win:SelectTab(i)
			pcall(function() window:SelectTab(i) end)
		end
		return win
	end

	function adapter:Notify(cfg)
		cfg = cfg or {}
		pcall(function()
			Fluent:Notify({
				Title = tostring(cfg.Title or "Zyrox"),
				Content = tostring(cfg.Description or cfg.Content or ""),
				SubContent = cfg.SubContent,
				Duration = cfg.Duration or cfg.Time or 5,
			})
		end)
	end

	-- a UI antiga abria visivel; a primeira chamada nao esconde a janela
	adapter.ToggleUI = function()
		if firstToggleUI then
			firstToggleUI = false
			return
		end
		pcall(function() window:Minimize() end)
	end

	-- minimiza a janela (so se estiver aberta) para nao cobrir menus do jogo abertos pelos botoes
	adapter.HideUI = function()
		pcall(function()
			if window and not window.Minimized then
				window:Minimize()
			end
		end)
	end

	-- exposto para a aba Personalizar (Fluent-modded)
	adapter._Fluent = Fluent
	adapter._Window = function()
		return window
	end
	adapter.SetTheme = function(name)
		pcall(function()
			if Fluent.SetTheme then
				Fluent:SetTheme(name)
			end
		end)
	end
	getgenv().ZyroxFluent = Fluent

	return adapter
end

local lib
do
	local choice = ZYROX_UI_CHOICE
	local order = {}
	if choice == "classic" or choice == "old" or choice == "banana" then
		order = { "classic" }
	elseif choice == "modded" or choice == "fluentmod" or choice == "fluent-modded" or choice == "fluentmodded" then
		order = { "modded", "fluent", "classic" }
	else
		-- Fluent (padrao) ou qualquer outro valor
		order = { "fluent", "modded", "classic" }
	end

	for _, kind in ipairs(order) do
		if lib then
			break
		end
		if kind == "classic" then
			local ok, result = pcall(ZyroxLoadOldUI)
			if ok and result then
				lib = result
				ZYROX_UI_NAME = "Classic"
			else
				warn("[ZyroxUI] Classic failed: " .. tostring(result))
			end
		else
			local ok, result = pcall(ZyroxBuildFluentAdapter, kind)
			if ok and result then
				lib = result
				ZYROX_FLUENT_ACTIVE = true
				ZYROX_UI_NAME = (kind == "modded") and "Fluent-modded" or "Fluent"
			else
				warn("[ZyroxUI] " .. kind .. " failed: " .. tostring(result))
			end
		end
	end
end
if not lib then
	error("[ZyroxUI] nenhuma interface carregou")
end
print("[Zyrox] UI: " .. ZYROX_UI_NAME)
print("[Zyrox] CreateWindow next...")
local v243 = lib:CreateWindow({
	Title = "Zyrox Hub",
	Subtitle = "Blox Fruit Script",
	Image = "rbxassetid://108697676964602"
})
if not ZYROX_FLUENT_ACTIVE then
for _, v in ipairs(game:GetService("CoreGui"):GetDescendants()) do
	if v:IsA("ImageLabel") and v.Name == "Ruafimg" and v.Image == "rbxassetid://108697676964602" then
		v.ScaleType = Enum.ScaleType.Crop
	end
end
task.spawn(function()
	while task.wait(0.05) do
		for _, gui in ipairs(game:GetService("CoreGui"):GetChildren()) do
			if gui.Name == "Nousigi Hub Btn" then
				for _, v in ipairs(gui:GetDescendants()) do
					if v:IsA("ImageLabel") and v.Image == "rbxassetid://108697676964602" and v.Parent and v.Parent:IsA("TextButton") then
						if v.Size ~= UDim2.new(1, 0, 1, 0) then
							v.Size = UDim2.new(1, 0, 1, 0)
						end
						if v.AnchorPoint ~= Vector2.new(0.5, 0.5) then
							v.AnchorPoint = Vector2.new(0.5, 0.5)
						end
						if v.Position ~= UDim2.new(0.5, 0, 0.5, 0) then
							v.Position = UDim2.new(0.5, 0, 0.5, 0)
						end
						v.ScaleType = Enum.ScaleType.Crop
					elseif v:IsA("UICorner") and v.Parent and v.Parent.Name == "dut dit" then
						v.CornerRadius = UDim.new(0, 0)
					end
				end
			end
		end
	end
end)
end

local t15 = {
	Info = v243:AddTab("Info And Status"),
	Main = v243:AddTab("Farming"),
	Settings = v243:AddTab("Setting"),
	Fish = v243:AddTab("Fishing"),
	Quests = v243:AddTab("Quest And Item"),
	SeaEvent = v243:AddTab("Sea Event"),
	Race = v243:AddTab("Mirage And Race"),
	Prehistoric = v243:AddTab("Volcano Event"),
	Esp = v243:AddTab("Stats And Esp"),
	Raids = v243:AddTab("Fruit And Raid"),
	Combat = v243:AddTab("Local Player"),
	Travel = v243:AddTab("Teleport"),
	Shop = v243:AddTab("Shopping"),
	Misc = v243:AddTab("Miscellaneous"),
	SecretQuest = v243:AddTab("Secret Quest"),
	Halloween = v243:AddTab("Halloween")
}

-- Aba Personalizar: so na Fluent-modded (temas / cores)
if ZYROX_UI_NAME == "Fluent-modded" then
	t15.Personalizar = v243:AddTab("Personalizar")
	do
		local GRP = t15.Personalizar:AddLeftGroupbox("Tema")
		GRP:AddLabel("Temas do Fluent-modded\nMuda as cores da interface em tempo real.")

		local themes = {
			"AMOLED",
			"Ash Gray",
			"Blood Red",
			"Cyanic",
			"Amber Glow",
			"Deep Violet",
			"Neon Cyber",
			"Neon Purple",
			"Royal Blue",
			"Deep Ocean",
			"RGB",
			"Orange",
			"Charcoal",
			"Pearl White",
			"Midnight Blue",
			"Galaxy Purple",
			"Cosmic Violet",
			"Cotton Candy",
		}

		local savedTheme = (getgenv().ZyroxTheme or _G.ZyroxTheme or "AMOLED")
		local defaultIdx = table.find(themes, savedTheme) or 1

		GRP:AddDropdown("Zyrox_Theme", {
			Text = "Tema",
			Values = themes,
			Default = defaultIdx,
			Callback = function(value)
				getgenv().ZyroxTheme = value
				_G.ZyroxTheme = value
				pcall(function()
					if lib.SetTheme then
						lib.SetTheme(value)
					elseif getgenv().ZyroxFluent and getgenv().ZyroxFluent.SetTheme then
						getgenv().ZyroxFluent:SetTheme(value)
					end
				end)
				pcall(function()
					lib:Notify({
						Title = "Personalizar",
						Description = "Tema: " .. tostring(value),
						Duration = 3,
					})
				end)
			end,
		})

		-- aplica tema salvo no load
		task.defer(function()
			pcall(function()
				if lib.SetTheme then
					lib.SetTheme(savedTheme)
				elseif getgenv().ZyroxFluent and getgenv().ZyroxFluent.SetTheme then
					getgenv().ZyroxFluent:SetTheme(savedTheme)
				end
			end)
		end)

		local GRP2 = t15.Personalizar:AddLeftGroupbox("Atalhos")
		GRP2:AddLabel("Dica: RightControl minimiza a janela.\nNo mobile use o botao flutuante.")
		GRP2:AddButton({
			Text = "Aplicar tema salvo",
			Func = function()
				local t = getgenv().ZyroxTheme or "AMOLED"
				pcall(function()
					if lib.SetTheme then
						lib.SetTheme(t)
					elseif getgenv().ZyroxFluent then
						getgenv().ZyroxFluent:SetTheme(t)
					end
				end)
			end,
		})
		GRP2:AddButton({
			Text = "Reset tema (AMOLED)",
			Func = function()
				getgenv().ZyroxTheme = "AMOLED"
				_G.ZyroxTheme = "AMOLED"
				pcall(function()
					if lib.SetTheme then
						lib.SetTheme("AMOLED")
					elseif getgenv().ZyroxFluent then
						getgenv().ZyroxFluent:SetTheme("AMOLED")
					end
				end)
			end,
		})
	end
end

lib.ToggleUI()

do
	local v245 = -- ===================== UNLOAD / TIRAR SCRIPT =====================
getgenv().ZyroxUnloaded = false
getgenv().ZyroxUnload = function()
	getgenv().ZyroxUnloaded = true
	getgenv().ZyroxKaitun = false
	getgenv().ZyroxKaitunRunning = false
	pcall(function()
		if getgenv().ZyroxKaitunStop then
			getgenv().ZyroxKaitunStop()
		end
	end)

	-- desliga farms principais
	pcall(function()
		_G.Level = false
		_G.AutoFarmNear = false
		_G.HalloweenFarm = false
		_G.AutoSlapBattle = false
	end)

	local names = {
		"ZyroxFluentBtn",
		"Nousigi Hub Btn",
		"ZyroxHalloweenCursor",
		"ZyroxKaitunUI",
		"ZyroxUIPicker",
		"Fluent",
		"FluentPro",
		"Library",
		"Linoria",
	}

	local function wipe(host)
		if not host then
			return
		end
		pcall(function()
			for _, name in ipairs(names) do
				local g = host:FindFirstChild(name)
				if g then
					g:Destroy()
				end
			end
			for _, child in ipairs(host:GetChildren()) do
				local n = string.lower(child.Name)
				if string.find(n, "zyrox") or string.find(n, "fluent") or string.find(n, "nousigi") or string.find(n, "linoria") then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end)
	end

	local hosts = {
		game:GetService("CoreGui"),
		game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui"),
	}
	pcall(function()
		if gethui then
			table.insert(hosts, gethui())
		end
	end)
	for _, h in ipairs(hosts) do
		wipe(h)
	end

	-- tenta fechar janela Fluent
	pcall(function()
		if getgenv().ZyroxFluent and getgenv().ZyroxFluent.Unload then
			getgenv().ZyroxFluent:Unload()
		end
	end)
	pcall(function()
		if lib and lib.Unload then
			lib:Unload()
		end
	end)

	print("[Zyrox] script removido da tela — execute de novo pra voltar")
end

do
	local GRP_Unload = t15.Info:AddLeftGroupbox("Hub")
	GRP_Unload:AddButton({
		Text = "Tirar script (Unload)",
		Func = function()
			pcall(function()
				lib:Notify({
					Title = "Zyrox",
					Description = "Removendo UI...",
					Duration = 2,
				})
			end)
			task.defer(function()
				task.wait(0.15)
				getgenv().ZyroxUnload()
			end)
		end,
	})
	GRP_Unload:AddLabel("Some a UI e o botao abrir/fechar.\nSo volta se executar o script de novo.")
end

t15.Info:AddLeftGroupbox("Time Zone"):AddLabel("")

	UpdateOS = function()
		local v246 = os.date("*t")
		local v247 = v246.hour % 24
		local v248 = string.format("%02i:%02i:%02i %s", (v247 - 1) % 12 + 1, v246.min, v246.sec, v247 < 12 and "AM" or "PM")
		local v249 = string.format("%02d/%02d/%04d", v246.day, v246.month, v246.year)
		local LocalizationService = game:GetService("LocalizationService")
		local LocalPlayer = game:GetService("Players").LocalPlayer
		local countryRegionCode

		if getgenv().countryRegionCode then
			countryRegionCode = getgenv().countryRegionCode
		else
			local ok

			ok, countryRegionCode = pcall(function()
				return LocalizationService:GetCountryRegionForPlayerAsync(LocalPlayer)
			end)

			if ok then
				getgenv().countryRegionCode = countryRegionCode
			else
				getgenv().countryRegionCode = "Unknown"
			end
		end

		v245:SetText(v249 .. " - " .. v248 .. " [ " .. countryRegionCode .. " ]")
	end
end

spawn(function()
	while true do
		UpdateOS()
		wait(1)
	end
end)

do
	local v254 = t15.Info:AddLeftGroupbox("Game Time"):AddLabel("")

	UpdateGameTime = function()
		local v255 = math.floor(workspace.DistributedGameTime + 0.5)

		v254:SetText(math.floor(v255 / 3600) % 24 .. " Hour (h) " .. math.floor(v255 / 60) % 60 .. " Minute (m) " .. math.floor(v255 / 1) % 60 .. " Second (s)")
	end
end

spawn(function()
	while true do
		UpdateGameTime()
		wait(1)
	end
end)

do
	local v256 = t15.Info:AddLeftGroupbox("Mirage Island"):AddLabel("Status: ")
	local s1 = ""

	spawn(function()
		pcall(function()
			while true do
				wait(1)

				local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") ~= nil and "✅" or "❌"

				if status == s1 then
					continue
				end

				v256:SetText("Status: " .. status)
				s1 = status
			end
		end)
	end)
end

do
	local v259 = t15.Info:AddLeftGroupbox("Kitsune Island"):AddLabel("Status: ")
	local s2 = ""

	spawn(function()
		while task.wait(1) do
			local status = game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") and "✅" or "❌"

			if status ~= s2 then
				v259:SetText("Status: " .. status)
				s2 = status
			end
		end
	end)
end

do
	local v262 = t15.Info:AddLeftGroupbox("Prehistoric Island"):AddLabel("Status: ")
	local s3 = ""

	task.spawn(function()
		while task.wait(1) do
			local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") and "✅" or "❌"

			if status ~= s3 then
				v262:SetText("Status: " .. status)
				s3 = status
			end
		end
	end)
end

do
	local v265 = t15.Info:AddLeftGroupbox("Frozen Dimension"):AddLabel("Status: ")
	local s4 = ""

	spawn(function()
		while wait(1) do
			local status = game.Workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") and "✅" or "❌"

			if status ~= s4 then
				v265:SetText("Status: " .. status)
				s4 = status
			end
		end
	end)
end

do
	local v268 = t15.Info:AddLeftGroupbox("Cake Prince Status"):AddLabel("")

	spawn(function()
		while wait(1) do
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			local s5 = "Cake Prince: ✅"

			if string.len(response) >= 86 then
				s5 = "Killed: " .. string.sub(response, 39, 41)
			end

			v268:SetText(s5)
		end
	end)
end

do
	local v271 = t15.Info:AddLeftGroupbox("Rip Indra"):AddLabel("Status: ")
	local s6 = ""

	spawn(function()
		while wait(1) do
			local status = (game:GetService("ReplicatedStorage"):FindFirstChild("rip_indra True Form") or game:GetService("Workspace").Enemies:FindFirstChild("rip_indra")) and "✅" or "❌"

			if status ~= s6 then
				v271:SetText("Status: " .. status)
				s6 = status
			end
		end
	end)
end

do
	local v274 = t15.Info:AddLeftGroupbox("Dough King"):AddLabel("Status: ")
	local s7 = ""

	spawn(function()
		while wait(1) do
			local status = (game:GetService("ReplicatedStorage"):FindFirstChild("Dough King") or game:GetService("Workspace").Enemies:FindFirstChild("Dough King")) and "✅" or "❌"

			if status ~= s7 then
				v274:SetText("Status: " .. status)
				s7 = status
			end
		end
	end)
end

do
	local v277 = t15.Info:AddLeftGroupbox("Full Moon"):AddLabel("")

	task.spawn(function()
		while task.wait(1) do
			local MoonTextureId = game:GetService("Lighting").Sky.MoonTextureId
			local s8 = "Moon: 0/5"

			if MoonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
				s8 = "Moon: 5/5 (Full Moon) ✅"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
				s8 = "Moon: 4/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
				s8 = "Moon: 3/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
				s8 = "Moon: 2/5"
			elseif MoonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
				s8 = "Moon: 1/5"
			end

			v277:SetText(s8)
		end
	end)
end

do
	local v280 = t15.Info:AddLeftGroupbox("Legendary Sword"):AddLabel("Status: ")

	spawn(function()
		while wait(1) do
			local s9 = "Not Found"

			if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
				s9 = "Shisui ✅"
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
				s9 = "Wando ✅"
			elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
				s9 = "Saddi ✅"
			end

			v280:SetText(s9)
		end
	end)
end

local v282 = t15.Info:AddLeftGroupbox("Bone"):AddLabel("")

GRP_Main_Select_Weapon = t15.Main:AddLeftGroupbox("Select Weapon")

do
	WeaponDropdown = GRP_Main_Select_Weapon:AddDropdown("Select_Weapon", {
		Text = "Select Weapon",
		Values = {
			"Melee",
			"Sword",
			"Blox Fruit",
			"Gun"
		},
		Default = "Melee",
		Callback = function(p62)
			_G.ChooseWP = p62
		end
	})
end

do
	spawn(function()
		local v283 = task.wait(0.5)

		while v283 do
			pcall(function()
				if _G.ChooseWP == "Melee" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Melee" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Sword" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Sword" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Gun" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Gun" then
							_G.SelectWeapon = child.Name
						end
					end
				elseif _G.ChooseWP == "Blox Fruit" then
					for _, child in pairs(plr.Backpack:GetChildren()) do
						if child.ToolTip == "Blox Fruit" then
							_G.SelectWeapon = child.Name
						end
					end
				end
			end)
			v283 = task.wait(0.5)
		end
	end)
end

GRP_Main_Farming = t15.Main:AddLeftGroupbox("Farming")

do
	FarmLevel = GRP_Main_Farming:AddToggle("Auto_Farm_Level", {
		Text = "Auto Farm Level",
		Default = false,
		Callback = function(p63)
			_G.Level = p63

			if not p63 then
				alreadyTeleported = false
				teleporting = false
			end
		end
	})
end

do
	local u292 = false
	local u293 = false

	_G.CheckQuestVisible = function(p64)
		local LocalPlayer = p64 or game.Players.LocalPlayer
		local Quest = LocalPlayer.PlayerGui:FindFirstChild("Main") and LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
		local TrackedQuestFrame = LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

		if Quest and Quest.Visible then
			local s10 = ""

			pcall(function()
				s10 = Quest.Container.QuestTitle.Title.Text
			end)

			return true, s10
		end

		if not TrackedQuestFrame or not TrackedQuestFrame.Enabled then
			return false, ""
		end

		local s11 = ""

		pcall(function()
			s11 = TrackedQuestFrame.Frame.header.textLabel.Text
		end)

		if s11 == "" then
			pcall(function()
				s11 = TrackedQuestFrame.Frame.header.textLabel.textLabel.Text
			end)
		end

		return true, s11
	end

	local function v299()
		if not plr.Character then
			return false
		end

		local HumanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return false
		end

		if HumanoidRootPart.Position.Y < -1000 then
			return true
		end

		local vector3 = Vector3.new(10533.28, 0, 9940.48)

		return (Vector3.new(HumanoidRootPart.Position.X, 0, HumanoidRootPart.Position.Z) - vector3).Magnitude < 4500
	end
	local function v302(...)
		local Main = game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main")

		if not Main then
			return nil
		end

		local v304 = Main

		for _, v1 in ipairs({ ... }) do
			if v304 then
				v304 = v304:FindFirstChild(v1)

				continue
			end

			return nil
		end

		return v304
	end
	local function v307(...)
		if select("#", ...) == 1 and select(1, ...) == "Quest" then
			local TrackedQuestFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

			if TrackedQuestFrame then
				local Frame = TrackedQuestFrame:FindFirstChild("Frame")

				if Frame then
					return TrackedQuestFrame.Enabled and Frame.Visible
				end
			end
		end

		local v310 = v302(...)

		return v310 ~= nil and v310.Visible == true
	end
	local function v311()
		local TrackedQuestFrame = game.Players.LocalPlayer.PlayerGui:FindFirstChild("TrackedQuestFrame")

		if TrackedQuestFrame then
			local Frame = TrackedQuestFrame:FindFirstChild("Frame")

			if Frame and Frame.Visible then
				local header = Frame:FindFirstChild("header")
				local textLabel = header and header:FindFirstChild("textLabel")

				if textLabel and textLabel:IsA("TextLabel") then
					return tostring(textLabel.Text)
				end
			end
		end

		local Quest = v302("Quest", "Container", "QuestTitle", "Title")

		if Quest then
			return tostring(Quest.Text)
		end

		return ""
	end
	local function v317(p65)
		if not p65 then
			return false
		end

		if not v307("Quest") then
			return false
		end

		local v318 = v311()

		if v318 == "" then
			return false
		end

		return string.find(string.lower(v318), string.lower(p65), 1, true) ~= nil
	end
	local function v319(p66, p67, p68)
		if v317(p68) then
			return true
		end

		local CommF_ = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes") and game:GetService("ReplicatedStorage").Remotes:FindFirstChild("CommF_")

		if not CommF_ then
			return false
		end

		local ok = pcall(function()
			return CommF_:InvokeServer("StartQuest", p66, p67)
		end)

		if not ok then
			return false
		end

		local v323 = os.clock() + 3

		while not v317(p68) do
			task.wait(0.25)

			if v323 <= os.clock() then
				return v317(p68)
			end
		end

		return true
	end

	task.spawn(function()
		while task.wait(Sec) do
			if _G.Level and ZyroxClaim("farm") then
				pcall(function()
					local Character = plr.Character or plr.CharacterAdded:Wait()
					local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

					if not HumanoidRootPart then
						return
					end

					local Value = plr.Data.Level.Value
					local v327 = v299()

					v307("Quest")
					v311()

					if not World3 or not (Value >= 2600) or v327 or u293 or u292 then
						if v327 or Value < 2600 or not World3 then
							u292 = true
							u293 = false

							local v328 = QuestNeta()

							if not v328 or not v328[1] then
								task.wait(1)

								return
							end

							local Quest = v307("Quest")

							if Quest then
								Quest = v317(v328[5] or v328[1])
							end

							if v307("Quest") and not Quest then
								replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
								task.wait(0.2)

								return
							end

							if not Quest then
								local v330 = v328[6]

								if v330 then
									_tp(v330)
									task.wait(2)

									if (HumanoidRootPart.Position - v330.Position).Magnitude <= 10 then
										v319(v328[3], v328[2], v328[5] or v328[1])
									end
								else
									v319(v328[3], v328[2], v328[5] or v328[1])
								end

								return
							end

							local v331 = v328[1]
							local v332 = false
							local v333, v334, v335 = pairs(workspace.Enemies:GetChildren())
							local v336 = geniter(v333, v334, v335)
							local exitTo
							local v338

							while true do
								local v339 = table.pack(v336())

								if v339[1] then
									v338 = v339[3]

									if string.find(v338.Name, v331) and t9.Alive(v338) then
										exitTo = 1

										break
									end
								else
									break
								end
							end

							if exitTo == 1 then
								v332 = true

								local watchHp, watchSince, watchFixed = nil, tick(), false

								while true do
									task.wait(Sec)
									-- o t9.Kill ja posiciona o personagem: aqui so se aproxima se estiver longe
									local myRoot = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
									if not myRoot or (myRoot.Position - v338.HumanoidRootPart.Position).Magnitude > 60 then
										_tp(v338.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
									end
									t9.Kill(v338, _G.Level)

									-- anti-trava: se a vida do mob nao muda, reequipa a arma (5s) e depois pula esse mob (12s)
									local mobHum = v338:FindFirstChildOfClass("Humanoid")
									if mobHum then
										if watchHp ~= mobHum.Health then
											watchHp, watchSince, watchFixed = mobHum.Health, tick(), false
										elseif tick() - watchSince > 12 then
											v338:SetAttribute("ZyroxSkip", tick())
											break
										elseif tick() - watchSince > 5 and not watchFixed then
											watchFixed = true
											pcall(function()
												if _G.ChooseWP then
													weaponSc(_G.ChooseWP)
												end
												EquipWeapon(_G.SelectWeapon)
											end)
										end
									end

									if v307("Quest") then
										if not _G.Level or not v338.Parent or v338.Humanoid.Health <= 0 then
											break
										end
									else
										break
									end
								end
							end

							if not v332 then
								local v340, v341, v342 = pairs(replicated:GetChildren())
								local v343 = geniter(v340, v341, v342)

								while true do
									local v344 = table.pack(v343())

									if v344[1] then
										local v345 = v344[3]

										if string.find(v345.Name, v331) and t9.Alive(v345) then
											v332 = true
											_tp(v345.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

											break
										end
									else
										break
									end
								end
							end

							if not v332 then
								local v346, v347, v348 = pairs(workspace._WorldOrigin.EnemySpawns:GetChildren())

								for _, v1 in v346, v347, v348 do
									if string.find(v1.Name, v331) then
										_tp(v1.CFrame * CFrame.new(0, 20, 0))

										break
									end
								end
							end
						elseif World3 and Value >= 2600 and not v327 then
							-- saiu da Ilha Submersa (morreu / renasceu): libera para viajar de novo em vez de ficar parado
							u292 = false
						end
					else
						u293 = true

						local cFrame = CFrame.new(-16269.7041, 25.2288494, 1373.65955)
						local n2 = 0

						while true do
							task.wait(Sec)
							_tp(cFrame)
							n2 += 1

							if not _G.Level then
								break
							elseif (HumanoidRootPart.Position - cFrame.Position).Magnitude <= 8 or n2 > 20 then
								break
							end
						end

						if not _G.Level then
							u293 = false

							return
						end

						task.wait(1)

						if not ZyroxSubmarine.travelNear(Vector3.new(10641.0918, -1953.92981, 9825.07031)) then
							pcall(function()
								local net = game:GetService("ReplicatedStorage").Modules.Net
								net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("AskKilledTikiBoss")
								net:FindFirstChild("RF/SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland")
							end)
						end

						local now = tick()

						while true do
							task.wait(0.5)

							local v354 = v299()
							local v355 = (HumanoidRootPart.Position - cFrame.Position).Magnitude > 50

							if v354 then
								break
							elseif v355 or not _G.Level or tick() - now > 15 then
								break
							end
						end

						task.wait(2)
						u292 = true
						u293 = false
					end
				end)
			else
				u293 = false
				u292 = false
			end
		end
	end)
end

do
	ClosetMons = GRP_Main_Farming:AddToggle("Auto_Farm_Nearest", {
		Text = "Auto Farm Nearest",
		Default = false,
		Callback = function(p69)
			_G.AutoFarmNear = p69
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.AutoFarmNear then
				for _, child in pairs(workspace.Enemies:GetChildren()) do
					if (child:FindFirstChild("Humanoid") or child:FindFirstChild("HumanoidRootPart")) and child.Humanoid.Health > 0 then
						while true do
							wait()
							t9.Kill(child, _G.AutoFarmNear)

							if not _G.AutoFarmNear then
								break
							elseif not child.Parent or child.Humanoid.Health <= 0 then
								break
							end
						end
					end
				end
			end
		end)
	end
end)

do
	FactoryRaids = GRP_Main_Farming:AddToggle("Auto_Factory_Raid", {
		Text = "Auto Factory Raid",
		Default = false,
		Callback = function(p70)
			_G.AutoFactory = p70
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoFactory then
					local Core = GetConnectionEnemies("Core")

					if Core and not ZyroxClaim("factory") then
						return
					end

					if Core then
						while true do
							wait()
							EquipWeapon(_G.SelectWeapon)
							_tp(CFrame.new(448.46756, 199.356781, -441.389252))

							if Core.Humanoid.Health <= 0 then
								break
							elseif _G.AutoFactory == false then
								break
							end
						end
					else
						_tp(CFrame.new(448.46756, 199.356781, -441.389252))
					end
				end
			end)
		end
	end)
end

do
	CastleRaids = GRP_Main_Farming:AddToggle("Auto_Pirate_Raid", {
		Text = "Auto Pirate Raid",
		Default = false,
		Callback = function(p71)
			_G.AutoRaidCastle = p71
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AutoRaidCastle then
			pcall(function()
				local cFrame = CFrame.new(-5496.17432, 313.768921, -2841.53027, 0.924894512, 7.37058015e-09, 0.380223751, 3.5881019e-08, 1, -1.06665446e-07, -0.380223751, 1.12297109e-07, 0.924894512)

				if (CFrame.new(-5539.3115234375, 313.800537109375, -2972.372314453125).Position - Root.Position).Magnitude <= 500 then
					local target
					local best = math.huge

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
							local dist = (child.HumanoidRootPart.Position - Root.Position).Magnitude

							if dist < best then
								best = dist
								target = child
							end
						end
					end

					if target then
						while true do
							wait()
							t9.Kill(target, _G.AutoRaidCastle)

							if not _G.AutoRaidCastle or not target.Parent or target.Humanoid.Health <= 0 then
								break
							end
						end
					end
				else
					local t16 = {
						"Galley Pirate",
						"Galley Captain",
						"Raider",
						"Mercenary",
						"Vampire",
						"Zombie",
						"Snow Trooper",
						"Winter Warrior",
						"Lab Subordinate",
						"Horned Warrior",
						"Magma Ninja",
						"Lava Pirate",
						"Ship Deckhand",
						"Ship Engineer",
						"Ship Steward",
						"Ship Officer",
						"Arctic Warrior",
						"Snow Lurker",
						"Sea Soldier",
						"Water Fighter"
					}

					for i = 1, #t16 do
						if replicated:FindFirstChild(t16[i]) then
							for _, child in pairs(replicated:GetChildren()) do
								if table.find(t16, child.Name) then
									_tp(cFrame)
								end
							end
						end
					end
				end
			end)
		end
	end
end)

do
	Ecto = GRP_Main_Farming:AddToggle("Auto_Farm_Ectoplasm", {
		Text = "Auto Farm Ectoplasm",
		Default = false,
		Callback = function(p72)
			_G.AutoEctoplasm = p72
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoEctoplasm then
				local v366 = GetConnectionEnemies({
					"Ship Deckhand",
					"Ship Engineer",
					"Ship Steward",
					"Ship Officer",
					"Arctic Warrior"
				})

				if t9.Alive(v366) then
					while true do
						wait()
						t9.Kill(v366, _G.AutoEctoplasm)

						if not _G.AutoEctoplasm then
							break
						elseif not v366.Parent or v366.Humanoid.Health <= 0 then
							break
						end
					end
				else
					replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				end
			end
		end)
	end
end)
GRP_Main_Chest = t15.Main:AddLeftGroupbox("Chest")

do
	ChestTW = GRP_Main_Chest:AddToggle("Auto_Farm_Chest", {
		Text = "Auto Farm Chest",
		Default = false,
		Callback = function(p73)
			_G.AutoFarmChest = p73
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AutoFarmChest then
			local exitTo

			repeat
				pcall(function()
					local CollectionService = game:GetService("CollectionService")
					local LocalPlayer = game:GetService("Players").LocalPlayer
					local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

					if not Character then
						return
					end

					local Position = Character:GetPivot().Position
					local tagged = CollectionService:GetTagged("_ChestTagged")
					local huge = math.huge
					local v374

					for i = 1, #tagged do
						local v376 = tagged[i]
						local Magnitude = (v376:GetPivot().Position - Position).Magnitude

						if (not SelectedIsland or v376:IsDescendantOf(SelectedIsland)) and not v376:GetAttribute("IsDisabled") and Magnitude < huge then
							huge = Magnitude
							v374 = v376
						end
					end

					if v374 then
						_tp(v374:GetPivot())
					end
				end)
				exitTo = nil

				while wait(Sec) do
					if _G.AutoFarmChest then
						exitTo = 1

						break
					end
				end
			until exitTo ~= 1

			return
		end
	end
end)
ChestBP = GRP_Main_Chest:AddToggle("Auto_Chest_Bypass", {
	Text = "Auto Chest Bypass",
	Default = false,
	Callback = function(p74)
		_G.AutoChestBP = p74

		if p74 then
			local LocalPlayer = game:GetService("Players").LocalPlayer
			local u379 = false
			local t17 = {}
			local u381 = true

			local function v382()
				if not LocalPlayer.Character then
					LocalPlayer.CharacterAdded:Wait()
				end

				LocalPlayer.Character:WaitForChild("HumanoidRootPart")

				return LocalPlayer.Character
			end
			local function v383()
				if u381 then
					u381 = false

					for _, descendant in pairs(game:GetDescendants()) do
						if descendant.Name:find("Chest") and descendant.ClassName == "Part" then
							table.insert(t17, descendant)
						end
					end
				end

				local t18 = {}

				for _, v1 in pairs(t17) do
					if v1:FindFirstChild("TouchInterest") then
						table.insert(t18, v1)
					end
				end

				local LowerTorso = v382().LowerTorso

				table.sort(t18, function(p75, p76)
					return (LowerTorso.Position - p75.Position).Magnitude < (LowerTorso.Position - p76.Position).Magnitude
				end)

				return t18
			end
			local function v390()
				if u379 then
					return
				end

				u379 = true
				task.spawn(function()
					while _G.AutoChestBP and LocalPlayer.Character and LocalPlayer.Character.Parent do
						local v391 = v383()

						if #v391 > 0 then
							v382().HumanoidRootPart.CFrame = v391[1].CFrame
						end

						task.wait(0.1)
					end

					u379 = false
				end)
			end

			LocalPlayer.CharacterAdded:Connect(function()
				v382()
				task.wait(0.5)

				if _G.AutoChestBP then
					v390()
				end
			end)
			v390()
		end
	end
})
StopI = GRP_Main_Chest:AddToggle("Stop_Items", {
	Text = "Stop Items",
	Default = true,
	Callback = function(p77)
		_G.StopWhenChalice = p77
	end
})
spawn(function()
	while wait(0.2) do
		if _G.StopWhenChalice and (_G.AutoFarmChest or _G.AutoChestBP) then
			pcall(function()
				if GetBP("God's Chalice") or GetBP("Sweet Chalice") then
					_G.AutoFarmChest = false
					_G.AutoChestBP = false
				elseif GetBP("Fist of Darkness") then
					_G.AutoFarmChest = false
					_G.AutoChestBP = false

					return
				end
			end)
		end
	end
end)
GRP_Main_Collect_Berry = t15.Main:AddLeftGroupbox("Collect Berry")
Berry = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry", {
	Text = "Auto Farm Berry",
	Default = false,
	Callback = function(p78)
		_G.AutoBerry = p78
	end
})

BerryH = GRP_Main_Collect_Berry:AddToggle("Auto_Farm_Berry_+_Hop", {
	Text = "Auto Farm Berry + Hop",
	Default = false,
	Callback = function(p79)
		_G.AutoBerryH = p79
	end
})

-- Auto Berry (logica do Vxeze: um alvo por ciclo, tudo em pcall, hop quando nao ha berry)
do
	local CollectionService = game:GetService("CollectionService")
	local lastNotify = 0

	local DetectBerryCFrame = function(attrs)
		for _, v in next, attrs, nil do
			if v then
				return v
			end
		end
	end

	local DetectBerry = function()
		for _, bush in ipairs(CollectionService:GetTagged("BerryBush")) do
			local data = DetectBerryCFrame(bush:GetAttributes())
			if data then
				return bush, data
			end
		end
	end

	local DetectModelBerry = function(bush)
		for _, child in pairs(bush:GetChildren()) do
			if child then
				return child
			end
		end
	end

	task.spawn(function()
		while task.wait(0.1) do
			if _G.AutoBerry or _G.AutoBerryH then
				pcall(function()
					local bush = DetectBerry()
					if bush then
						local model = DetectModelBerry(bush)
						if not model then
							_tp(bush.Parent.WorldPivot)
						else
							_tp(model.WorldPivot)
							local prompt = model:FindFirstChild("ProximityPrompt")
							if prompt then
								fireproximityprompt(prompt)
							end
						end
					else
						if tick() - lastNotify > 10 then
							lastNotify = tick()
							pcall(function()
								lib:Notify({ Title = "Berry", Description = "Waiting Berry spawn", Duration = 4 })
							end)
						end
						if _G.AutoBerryH then
							Hop()
						end
						wait(5)
					end
				end)
			end
		end
	end)
end

GRP_Main_Farm_Mob = t15.Main:AddLeftGroupbox("Farm Mob")

if World1 then
	GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
		Text = "Select Mob",
		Values = {
			"Bandit",
			"Monkey",
			"Gorilla",
			"Pirate",
			"Brute",
			"Desert Bandit",
			"Desert Officer",
			"Snow Bandit",
			"Snowman",
			"Chief Petty Officer",
			"Sky Bandit",
			"Dark Master",
			"Toga Warrior",
			"Gladiator",
			"Military Soldier",
			"Military Spy",
			"Fishman Warrior",
			"Fishman Commando",
			"God's Guard",
			"Shanda",
			"Royal Squad",
			"Royal Soldier",
			"Galley Pirate",
			"Galley Captain"
		},
		Default = 1,
		Callback = function(p80)
			getgenv().SelectMob = p80
		end
	})
end

do
	if World2 then
		GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
			Text = "Select Mob",
			Values = {
				"Raider",
				"Mercenary",
				"Swan Pirate",
				"Factory Staff",
				"Marine Lieutenant",
				"Marine Captain",
				"Zombie",
				"Vampire",
				"Snow Trooper",
				"Winter Warrior",
				"Lab Subordinate",
				"Horned Warrior",
				"Magma Ninja",
				"Lava Pirate",
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer",
				"Arctic Warrior",
				"Snow Lurker",
				"Sea Soldier",
				"Water Fighter"
			},
			Default = 1,
			Callback = function(p81)
				getgenv().SelectMob = p81
			end
		})
	end
end

if World3 then
	GRP_Main_Farm_Mob:AddDropdown("Select_Mob", {
		Text = "Select Mob",
		Values = {
			"Pirate Millionaire",
			"Dragon Crew Warrior",
			"Dragon Crew Archer",
			"Female Islander",
			"Giant Islander",
			"Marine Commodore",
			"Marine Rear Admiral",
			"Fishman Raider",
			"Fishman Captain",
			"Forest Pirate",
			"Mythological Pirate",
			"Jungle Pirate",
			"Musketeer Pirate",
			"Reborn Skeleton",
			"Living Zombie",
			"Demonic Soul",
			"Posessed Mummy",
			"Peanut Scout",
			"Peanut President",
			"Ice Cream Chef",
			"Ice Cream Commander",
			"Cookie Crafter",
			"Cake Guard",
			"Baking Staff",
			"Head Baker",
			"Cocoa Warrior",
			"Chocolate Bar Battler",
			"Sweet Thief",
			"Candy Rebel",
			"Candy Pirate",
			"Snow Demon",
			"Isle Outlaw",
			"Island Boy",
			"Sun-kissed Warrior",
			"Isle Champion"
		},
		Default = 1,
		Callback = function(p82)
			getgenv().SelectMob = p82
		end
	})
end

GRP_Main_Farm_Mob:AddToggle("Auto_Kill_Mob", {
	Text = "Auto Kill Mob",
	Default = false,
	Callback = function(p83)
		_G.AutoKillMob = p83
	end
})
spawn(function()
	while wait() do
		if _G.AutoKillMob then
			pcall(function()
				if game:GetService("Workspace").Enemies:FindFirstChild(getgenv().SelectMob) then
					for _, child in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if child.Name == getgenv().SelectMob and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
							while true do
								game:GetService("RunService").Heartbeat:Wait()
								t9.Kill(child, _G.AutoKillMob)

								if not _G.AutoKillMob then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end
				end
			end)
		end
	end
end)
GRP_Main_Farm_All_Island = t15.Main:AddLeftGroupbox("Farm All Island")

do
	local t19 = {
		Pirates = {
			CFrame = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929),
			Mobs = { "Bandit" }
		},
		Marine = {
			CFrame = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929),
			Mobs = { "Trainee" }
		},
		Jungle = {
			CFrame = CFrame.new(-1600, 36, 150),
			Mobs = {
				"Monkey",
				"Gorilla"
			}
		},
		["Pirate Village"] = {
			CFrame = CFrame.new(-1100, 4, 3850),
			Mobs = {
				"Pirate",
				"Brute"
			}
		},
		Desert = {
			CFrame = CFrame.new(1090, 7, 4370),
			Mobs = {
				"Desert Bandit",
				"Desert Officer"
			}
		},
		["Frozen Village"] = {
			CFrame = CFrame.new(1200, 28, -1500),
			Mobs = {
				"Snow Bandit",
				"Snowman"
			}
		},
		["Marine Fortress"] = {
			CFrame = CFrame.new(-4500, 20, 4250),
			Mobs = { "Chief Petty Officer" }
		},
		["Skylands Lower"] = {
			CFrame = CFrame.new(-5000, 700, -2500),
			Mobs = {
				"Sky Bandit",
				"Dark Master"
			}
		},
		Prison = {
			CFrame = CFrame.new(4875, 6, 735),
			Mobs = {
				"Prisoner",
				"Dangerous Prisoner"
			}
		},
		Colosseum = {
			CFrame = CFrame.new(-1500, 60, -290),
			Mobs = {
				"Toga Warrior",
				"Gladiator"
			}
		},
		["Magma Village"] = {
			CFrame = CFrame.new(-5200, 8, 8400),
			Mobs = {
				"Military Soldier",
				"Military Spy"
			}
		},
		["Underwater City"] = {
			CFrame = CFrame.new(61160, 5, 1819),
			Mobs = {
				"Fishman Warrior",
				"Fishman Commando"
			}
		},
		["Skylands Upper"] = {
			CFrame = CFrame.new(-7880, 5545, -380),
			Mobs = {
				"Shanda",
				"Royal Squad",
				"Royal Soldier"
			}
		}
	}
	local t20 = {
		["Kingdom of Rose"] = {
			CFrame = CFrame.new(-321, 73, 297),
			Mobs = {
				"Raider",
				"Mercenary",
				"Swan Pirate",
				"Factory Staff"
			}
		},
		["Green Zone"] = {
			CFrame = CFrame.new(-2447, 73, -3211),
			Mobs = {
				"Marine Lieutenant",
				"Marine Captain"
			}
		},
		["Graveyard Island"] = {
			CFrame = CFrame.new(-9515, 142, 5536),
			Mobs = {
				"Zombie",
				"Vampire"
			}
		},
		["Snow Mountain"] = {
			CFrame = CFrame.new(561, 401, -5306),
			Mobs = {
				"Snow Trooper",
				"Winter Warrior"
			}
		},
		["Hot and Cold (Cold)"] = {
			CFrame = CFrame.new(-6026, 15, -5062),
			Mobs = {
				"Lab Subordinate",
				"Horned Warrior"
			}
		},
		["Hot and Cold (Hot)"] = {
			CFrame = CFrame.new(-5478, 15, -5240),
			Mobs = {
				"Magma Ninja",
				"Lava Pirate"
			}
		},
		["Cursed Ship"] = {
			CFrame = CFrame.new(902, 126, 33071),
			Mobs = {
				"Ship Deckhand",
				"Ship Engineer",
				"Ship Steward",
				"Ship Officer"
			}
		},
		["Ice Castle"] = {
			CFrame = CFrame.new(6137, 294, -6747),
			Mobs = {
				"Arctic Warrior",
				"Snow Lurker"
			}
		},
		["Forgotten Island"] = {
			CFrame = CFrame.new(-3043, 238, -10191),
			Mobs = {
				"Sea Soldier",
				"Water Fighter"
			}
		}
	}
	local t21 = {
		["Port Town"] = {
			CFrame = CFrame.new(-290, 44, 5450),
			Mobs = {
				"Pirate Millionaire",
				"Pistol Billionaire"
			}
		},
		["Hydra Island"] = {
			CFrame = CFrame.new(5228, 604, 345),
			Mobs = {
				"Dragon Crew Warrior",
				"Dragon Crew Archer",
				"Female Islander",
				"Giant Islander",
				"Training Dummy"
			}
		},
		["Great Tree"] = {
			CFrame = CFrame.new(2682, 1682, -7190),
			Mobs = {
				"Marine Commodore",
				"Marine Rear Admiral"
			}
		},
		["Floating Turtle"] = {
			CFrame = CFrame.new(-12000, 331, -8500),
			Mobs = {
				"Forest Pirate",
				"Mythological Pirate",
				"Jungle Pirate",
				"Musketeer Pirate",
				"Fishman Raider",
				"Fishman Captain"
			}
		},
		["Haunted Castle"] = {
			CFrame = CFrame.new(-9515, 142, 5536),
			Mobs = {
				"Reborn Skeleton",
				"Living Zombie",
				"Demonic Soul",
				"Posessed Mummy"
			}
		},
		["Sea of Treats"] = {
			CFrame = CFrame.new(-1145, 13, -14450),
			Mobs = {
				"Peanut Scout",
				"Peanut President",
				"Ice Cream Commander",
				"Cookie Crafter",
				"Cake Guard",
				"Baking Staff",
				"Head Baker",
				"Cocoa Warrior",
				"Chocolate Bar Battler",
				"Sweet Thief",
				"Candy Rebel"
			}
		},
		["Tiki Outpost"] = {
			CFrame = CFrame.new(-16200, 90, -17300),
			Mobs = {
				"Isle Outlaw",
				"Island Boy",
				"Sun-kissed Warrior",
				"Isle Champion"
			}
		},
		["Submerged Island"] = {
			CFrame = CFrame.new(-3200, -10, -10000),
			Mobs = {
				"Reef Bandit",
				"Coral Pirate",
				"Sea Chanter",
				"Ocean Prophet",
				"High Disciple",
				"Grand Devotee"
			}
		}
	}

	if World1 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Pirates",
				"Marine",
				"Jungle",
				"Pirate Village",
				"Desert",
				"Frozen Village",
				"Marine Fortress",
				"Skylands Lower",
				"Prison",
				"Colosseum",
				"Magma Village",
				"Underwater City",
				"Skylands Upper"
			},
			Default = 1,
			Callback = function(p84)
				_G.SelectIsland = p84
			end
		})
	end

	if World2 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Kingdom of Rose",
				"Green Zone",
				"Graveyard Island",
				"Snow Mountain",
				"Hot and Cold (Cold)",
				"Hot and Cold (Hot)",
				"Cursed Ship",
				"Ice Castle",
				"Forgotten Island"
			},
			Default = 1,
			Callback = function(p85)
				_G.SelectIsland = p85
			end
		})
	end

	if World3 then
		GRP_Main_Farm_All_Island:AddDropdown("Select_Island", {
			Text = "Select Island",
			Values = {
				"Port Town",
				"Hydra Island",
				"Great Tree",
				"Floating Turtle",
				"Haunted Castle",
				"Sea of Treats",
				"Tiki Outpost",
				"Submerged Island"
			},
			Default = 1,
			Callback = function(p86)
				_G.SelectIsland = p86
			end
		})
	end

	local v415

	if World1 then
		v415 = t19
	elseif World2 then
		v415 = t20
	elseif World3 then
		v415 = t21
	end

	GRP_Main_Farm_All_Island:AddToggle("Auto_Farm_All_Island", {
		Text = "Auto Farm All Island",
		Default = false,
		Callback = function(p87)
			_G.AutoFarmIsland = p87
		end
	})
	task.spawn(function()
		while task.wait(0.2) do
			if _G.AutoFarmIsland and _G.SelectIsland and v415 then
				local v416 = v415[_G.SelectIsland]

				if v416 then
					local CFrame_ = v416.CFrame
					local t22 = {}

					for _, mob in ipairs(v416.Mobs) do
						t22[mob] = true
					end

					local v421 = false

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if t22[child.Name] and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
							v421 = true

							while true do
								task.wait()
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0))
								t9.Kill(child, true)

								if not _G.AutoFarmIsland then
									break
								elseif not child.Parent or child.Humanoid.Health <= 0 then
									break
								end
							end
						end
					end

					if not v421 then
						_tp(CFrame_)
					end
				end
			end
		end
	end)
end

GRP_Main_Farm_Elite_Hunter = t15.Main:AddLeftGroupbox("Farm Elite Hunter")

do
	local v424 = GRP_Main_Farm_Elite_Hunter:AddLabel("Elite Progress : 0")

	spawn(function()
		while wait(Sec) do
			pcall(function()
				v424:SetText("Elite Progress : " .. replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress"))
			end)
		end
	end)
end

do
	local v425 = GRP_Main_Farm_Elite_Hunter:AddLabel("Status: Not Found")

	spawn(function()
		local s12 = ""

		while wait(1) do
			local v427 = (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) and "✅" or "❌"
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter", "Progress")

			if v427 ~= s12 then
				v425:SetText("Status: " .. v427 .. " | Killed: " .. response)
				s12 = v427
			end
		end
	end)
end

EliteQ = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite", {
	Text = "Auto Farm Elite",
	Default = false,
	Callback = function(p88)
		_G.FarmEliteHunt = p88
	end
})
-- Auto Elite (logica do Vxeze): detecta qual Elite realmente apareceu e alinha a quest com ele
ZyroxEliteNames = { "Deandre", "Diablo", "Urban" }
ZyroxEliteAlive = function(mob)
	return mob ~= nil and mob.Parent ~= nil and mob:FindFirstChild("HumanoidRootPart") ~= nil
		and mob:FindFirstChildOfClass("Humanoid") ~= nil and mob.Humanoid.Health > 0
end
ZyroxDetectElite = function()
	-- prefere o Elite ja nascido em Enemies; o modelo de ReplicatedStorage so serve para se aproximar e faze-lo nascer
	for _, container in ipairs({ workspace.Enemies, replicated }) do
		for _, mob in ipairs(container:GetChildren()) do
			if mob:IsA("Model") and table.find(ZyroxEliteNames, mob.Name) and ZyroxEliteAlive(mob) then
				return mob
			end
		end
	end
end
ZyroxEliteQuestMatches = function(name)
	local quest = plr.PlayerGui.Main.Quest
	return quest.Visible and string.find(quest.Container.QuestTitle.Title.Text, name) ~= nil
end
ZyroxEliteFight = function(boss, isOn)
	local quest = plr.PlayerGui.Main.Quest
	_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

	if not boss:IsDescendantOf(workspace) then
		-- so o modelo de ReplicatedStorage: espera o boss nascer (ate 8s) em vez de ficar parado no ar atacando nada
		local waited = 0
		while isOn() and waited < 8 and ZyroxEliteAlive(boss) and not boss:IsDescendantOf(workspace)
			and not workspace.Enemies:FindFirstChild(boss.Name) do
			wait(0.5)
			waited = waited + 0.5
		end
		return
	end

	while isOn() do
		wait()
		t9.Kill(boss, true)
		if not ZyroxEliteAlive(boss) or not quest.Visible then
			break
		end
	end
end
-- um passo: se algum Elite apareceu, alinha a quest (abandona e pega de novo) ou luta. Devolve true se achou algum.
ZyroxEliteStep = function(isOn)
	local boss = ZyroxDetectElite()
	if not boss then
		return false
	end
	if not ZyroxClaim("elite") then
		return true
	end
	if not ZyroxEliteQuestMatches(boss.Name) then
		replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
		replicated.Remotes.CommF_:InvokeServer("EliteHunter")
		task.wait(1)
	else
		ZyroxEliteFight(boss, isOn)
	end
	return true
end

spawn(function()
	while wait(1) do
		pcall(function()
			if _G.FarmEliteHunt then
				if ZyroxEliteStep(function() return _G.FarmEliteHunt end) then
					return
				end
				-- nenhum Elite apareceu: pede a quest (em cooldown, espera)
				local response = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
				if response == nil or string.find(tostring(response), "Cooldown") then
					wait(10)
				end
			end
		end)
	end
end)
EliteH = GRP_Main_Farm_Elite_Hunter:AddToggle("Auto_Farm_Elite_+_Hop", {
	Text = "Auto Farm Elite + Hop",
	Default = false,
	Callback = function(p89)
		_G.FarmEliteH = p89
	end
})

do
	local function v451()
		local HttpService = game:GetService("HttpService")
		local TeleportService_ = game:GetService("TeleportService")
		local s13 = ""
		local v455 = false

		repeat
			local ok, result = pcall(function()
				return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100&cursor=" .. s13)
			end)

			if ok and result then
				local data = HttpService:JSONDecode(result)

				if data.data then
					for _, v1 in pairs(data.data) do
						if v1.playing < v1.maxPlayers and v1.id ~= game.JobId then
							v455 = true
							TeleportService_:TeleportToPlaceInstance(game.PlaceId, v1.id)

							break
						end
					end

					s13 = data.nextPageCursor or ""
				end
			end
		until not s13 or v455
	end

	spawn(function()
		while task.wait(1) do
			pcall(function()
				if _G.FarmEliteH then
					if ZyroxEliteStep(function() return _G.FarmEliteH end) then
						return
					end

					if plr.PlayerGui.Main.Quest.Visible then
						-- tem quest, mas nenhum Elite apareceu: espera um pouco antes de trocar de servidor
						for _ = 1, 6 do
							if ZyroxDetectElite() then
								return
							end
							task.wait(1)
						end
						replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
						task.wait(1)
						v451()
					else
						local response = replicated.Remotes.CommF_:InvokeServer("EliteHunter")
						if response == nil or string.find(tostring(response), "Cooldown") then
							v451()
							return
						end
						task.wait(1)
					end
				end
			end)
		end
	end)
end

GRP_Main_Farm_Rip_Indra = t15.Main:AddLeftGroupbox("Farm Rip Indra")
GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Attack_Rip_Indra", {
	Text = "Auto Attack Rip Indra",
	Default = false,
	Callback = function(p90)
		_G.AutoRipIngay = p90
	end
})

do
	spawn(function()
		if wait(Sec) then
			repeat
				pcall(function()
					if _G.AutoRipIngay then
						local ripIndra = GetConnectionEnemies("rip_indra")

						if not GetWP("Dark Dagger") or not GetIn("Valkyrie") and ripIndra then
							while true do
								wait()
								t9.Kill(ripIndra, _G.AutoRipIngay)

								if not _G.AutoRipIngay or not ripIndra.Parent then
									break
								elseif ripIndra.Humanoid.Health <= 0 then
									break
								end
							end

							return
						end

						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-5097.93164, 316.447021, -3142.66602, -0.405007899, -4.31682743e-08, 0.914313197, -1.90943332e-08, 1, 3.8755779e-08, -0.914313197, -1.76180437e-09, -0.405007899))
						wait(0.1)
						_tp(CFrame.new(-5344.822265625, 423.98541259766, -2725.0930175781))
					end
				end)
			until not wait(Sec)
		end
	end)
end

GRP_Main_Farm_Rip_Indra:AddToggle("Auto_Unlocked_Haki", {
	Text = "Auto Unlocked Haki",
	Default = false,
	Callback = function(p91)
		_G.AutoUnHaki = p91
	end
})
AuraSkin = function(p92)
	local t23 = { {
		StorageName = p92,
		Type = "AuraSkin",
		Context = "Equip"
	} }

	replicated:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/FruitCustomizerRF"):InvokeServer(unpack(t23))
end

do
	VaildColor = function(p93)
		if p93 and p93.BrickColor then
			return tostring(p93.BrickColor) == "Lime green"
		end
	end
end

HakiCalculate = function(p94)
	local t24 = {
		["Really red"] = "Pure Red",
		Oyster = "Snow White",
		["Hot pink"] = "Winter Sky"
	}

	if p94 then
		if p94.BrickColor then
			return t24[tostring(p94.BrickColor)]
		end
	end
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoUnHaki then
				pcall(function()
					local Summoner = workspace.Map["Boat Castle"]:FindFirstChild("Summoner")

					if Summoner and Summoner:FindFirstChild("Circle") then
						local pairs_ = pairs
						local Circle = Summoner:FindFirstChild("Circle")

						for _, child in pairs_(Circle:GetChildren()) do
							if child.Name == "Part" then
								local Part2 = child:FindFirstChild("Part")

								if VaildColor(Part2) == false then
									AuraSkin(HakiCalculate(child))

									while true do
										wait()
										_tp(child.CFrame)

										if VaildColor(Part2) == true then
											break
										elseif not _G.AutoUnHaki then
											break
										end
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
end

GRP_Main_Farming_Cake = t15.Main:AddLeftGroupbox("Farming Cake")

do
	local v492 = GRP_Main_Farming_Cake:AddLabel("")

	spawn(function()
		if wait(0.2) then
			repeat
				pcall(function()
					local v493 = string.match(replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner"), "%d+")

					if v493 then
						v492:SetText("Killed : " .. (500 - tonumber(v493) or 0))
					end
				end)
			until not wait(0.2)
		end
	end)
end

do
	Cake = GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Cake_Prince", {
		Text = "Auto Farm Cake Prince",
		Default = false,
		Callback = function(p95)
			_G.Auto_Cake_Prince = p95
		end
	})
end

spawn(function()
	while task.wait() do
		if _G.Auto_Cake_Prince then
			if not _G.AutoRaidCastle then
				pcall(function()
					local LocalPlayer = game.Players.LocalPlayer
					local HumanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
					local CakeLoaf = workspace.Map:FindFirstChild("CakeLoaf")
					local BigMirror = CakeLoaf and CakeLoaf:FindFirstChild("BigMirror")

					if not HumanoidRootPart then
						return
					end

					local v498, v499

					if not _G.AcceptQuestC or _G.CheckQuestVisible(LocalPlayer) then
						if CakeLoaf then
							if BigMirror and (BigMirror.Other.Transparency == 0 or workspace.Enemies:FindFirstChild("Cake Prince")) then
								v499 = GetConnectionEnemies("Cake Prince")

								if v499 then
									while true do
										task.wait()
										t9.Kill2(v499, _G.Auto_Cake_Prince)

										if not _G.Auto_Cake_Prince then
											break
										elseif not v499.Parent or v499.Humanoid.Health <= 0 then
											break
										end
									end
								else
									_tp(CFrame.new(-2151.82, 149.32, -12404.91))
								end
							else
								v498 = GetConnectionEnemies({
									"Cookie Crafter",
									"Cake Guard",
									"Baking Staff",
									"Head Baker"
								})

								if v498 then
									while true do
										task.wait()
										t9.Kill(v498, _G.Auto_Cake_Prince)

										if not _G.Auto_Cake_Prince then
											break
										elseif not v498.Parent or v498.Humanoid.Health <= 0 or BigMirror and BigMirror.Other.Transparency == 0 then
											break
										end
									end
								else
									_tp(CFrame.new(-2077, 252, -12373))
								end
							end

							return
						end
					else
						local cFrame = CFrame.new(-1927.92, 37.8, -12842.54)

						_tp(cFrame)

						while (cFrame.Position - HumanoidRootPart.Position).Magnitude > 50 do
							task.wait(0.2)
						end

						local v501 = math.random(1, 4)
						local t25 = {
							{
								"StartQuest",
								"CakeQuest2",
								2
							},
							{
								"StartQuest",
								"CakeQuest2",
								1
							},
							{
								"StartQuest",
								"CakeQuest1",
								1
							},
							{
								"StartQuest",
								"CakeQuest1",
								2
							}
						}

						pcall(function()
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(t25[v501]))
						end)

						if CakeLoaf then
							if BigMirror and (BigMirror.Other.Transparency == 0 or workspace.Enemies:FindFirstChild("Cake Prince")) then
								v499 = GetConnectionEnemies("Cake Prince")

								if not v499 then
									_tp(CFrame.new(-2151.82, 149.32, -12404.91))

									return
								end

								while true do
									task.wait()
									t9.Kill2(v499, _G.Auto_Cake_Prince)

									if not _G.Auto_Cake_Prince then
										break
									elseif not v499.Parent or v499.Humanoid.Health <= 0 then
										break
									end
								end
							else
								v498 = GetConnectionEnemies({
									"Cookie Crafter",
									"Cake Guard",
									"Baking Staff",
									"Head Baker"
								})

								if v498 then
									while true do
										task.wait()
										t9.Kill(v498, _G.Auto_Cake_Prince)

										if not _G.Auto_Cake_Prince then
											break
										elseif not v498.Parent or v498.Humanoid.Health <= 0 or BigMirror and BigMirror.Other.Transparency == 0 then
											break
										end
									end
								else
									_tp(CFrame.new(-2077, 252, -12373))
								end
							end

							return
						end
					end

					_tp(CFrame.new(-2077, 252, -12373))
					task.wait(2)
				end)
			end
		end
	end
end)
CakeQ = GRP_Main_Farming_Cake:AddToggle("Accept_Quests", {
	Text = "Accept Quests",
	Default = false,
	Callback = function(p96)
		_G.AcceptQuestBoss = p96
	end
})

do
	CakeSM = GRP_Main_Farming_Cake:AddToggle("Auto_Summon_Cake_Prince", {
		Text = "Auto Summon Cake Prince",
		Default = false,
		Callback = function(p97)
			_G.AutoSpawnCP = p97
		end
	})
end

do
	spawn(function()
		while task.wait(2) do
			if _G.AutoSpawnCP then
				local exitTo

				repeat
					pcall(function()
						local CommF_ = game.ReplicatedStorage.Remotes.CommF_
						local BigMirror = workspace.Map.CakeLoaf:FindFirstChild("BigMirror")

						if not BigMirror then
							return
						end

						if workspace.Enemies:FindFirstChild("Cake Prince") then
							return
						end

						if BigMirror.Other.Transparency == 0 then
							return
						end

						CommF_:InvokeServer("CakePrinceSpawner", true)
					end)
					exitTo = nil

					while task.wait(2) do
						if _G.AutoSpawnCP then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Main_Farming_Cake:AddToggle("Auto_Dough_King_[Fully]", {
	Text = "Auto Dough King [Fully]",
	Default = false,
	Callback = function(p98)
		_G.AutoDoughKing = p98
	end
})
spawn(function()
	while wait() do
		if _G.AutoDoughKing then
			pcall(function()
				if workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
					if not workspace.Map.CakeLoaf:FindFirstChild("RedDoor") then
						if GetConnectionEnemies("Dough King") then
							local v506 = GetConnectionEnemies("Dough King")

							if v506 then
								while true do
									task.wait()
									t9.Kill(v506, _G.AutoDoughKing)

									if not _G.AutoDoughKing then
										break
									elseif not v506.Parent or v506.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
							end
						end
					elseif GetBP("Red Key") then
						while true do
							task.wait()
							_tp(CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782))

							if not getgenv().AutoDoughKing then
								break
							elseif (plr.Character.HumanoidRootPart.CFrame - CFrame.new(-2681.97998, 64.3921585, -12853.7363, 0.149007782, -1.87902192e-08, 0.98883605, 3.60619588e-08, 1, 1.35681812e-08, -0.98883605, 3.36376011e-08, 0.149007782)).Magnitude <= 5 then
								break
							end
						end

						EquipWeapon("Red Key")
					end
				elseif GetBP("Red Key") then
					replicated.Remotes.CommF_:InvokeServer("CakeScientist", "Check")
					replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Check")
				end

				if GetBP("Sweet Chalice") then
					replicated.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true)
					_G.AutoAttackDoughKing = true
				else
					_G.AutoAttackDoughKing = false
				end

				if GetBP("God's Chalice") and GetM("Conjured Cocoa") >= 10 then
					replicated.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
				end

				local ok = not plr.Backpack:FindFirstChild("God's Chalice")

				if not ok then
					ok = plr.Character:FindFirstChild("God's Chalice")
				end

				if ok then
					_G.FarmEliteHunt = true
				else
					_G.FarmEliteHunt = false
				end

				if GetM("Conjured Cocoa") <= 10 then
					local v508 = GetConnectionEnemies({
						"Cocoa Warrior",
						"Chocolate Bar Battler"
					})

					if v508 then
						while true do
							task.wait()
							t9.Kill(v508, _G.AutoDoughKing)

							if _G.AutoDoughKing == false then
								break
							elseif not v508.Parent or v508.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(402.71890258789062, 81.060501098632812, -12259.54296875))
					end
				end
			end)
		end
	end
end)
GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King", {
	Text = "Auto Farm Dough King",
	Default = false,
	Callback = function(p99)
		_G.AutoAttackDoughKing = p99
	end
})

do
	spawn(function()
		while wait() do
			if _G.AutoAttackDoughKing then
				local exitTo

				repeat
					pcall(function()
						local v510 = GetConnectionEnemies("Dough King")

						if v510 then
							while true do
								task.wait()
								t9.Kill(v510, _G.AutoAttackDoughKing)

								if not _G.AutoAttackDoughKing then
									break
								elseif not v510.Parent or v510.Humanoid.Health <= 0 then
									break
								end
							end
						else
							_tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))
						end
					end)
					exitTo = nil

					while wait() do
						if _G.AutoAttackDoughKing then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

do
	GRP_Main_Farming_Cake:AddToggle("Auto_Farm_Dough_King_+_Hop", {
		Text = "Auto Farm Dough King + Hop",
		Default = false,
		Callback = function(p100)
			_G.AutoHop_Dough = p100
		end
	})
end

do
	local function v511()
		pcall(function()
			local HttpService = game:GetService("HttpService")
			local t26 = {}
			local response = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")

			for _, v1 in pairs(HttpService:JSONDecode(response).data) do
				if v1.playing < v1.maxPlayers then
					table.insert(t26, v1.id)
				end
			end

			if #t26 > 0 then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, t26[math.random(1, #t26)], game.Players.LocalPlayer)
			end
		end)
	end

	spawn(function()
		while task.wait() do
			if _G.AutoHop_Dough then
				pcall(function()
					local v517 = GetConnectionEnemies("Dough King")

					if v517 then
						while true do
							task.wait()
							t9.Kill(v517, _G.AutoHop_Dough)

							if not _G.AutoHop_Dough then
								break
							elseif not v517.Parent or v517.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-1943.6765, 251.5095, -12337.8809))
						task.wait(2)

						if not GetConnectionEnemies("Dough King") and _G.AutoHop_Dough then
							v511()
						end
					end
				end)
			end
		end
	end)
end

GRP_Main_Farming_Bone = t15.Main:AddLeftGroupbox("Farming Bone")

do
	local v518 = GRP_Main_Farming_Bone:AddLabel("")

	spawn(function()
		while wait(1) do
			local response = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Bones", "Check") or 0

			v518:SetText("You Have: " .. tostring(response) .. " Bones")
			v282:SetText("You Have: " .. tostring(response) .. " Bones")
		end
	end)
end

GRP_Main_Farming_Bone:AddToggle("Auto_Farm_Bone", {
	Text = "Auto Farm Bone",
	Default = false,
	Callback = function(p101)
		_G.AutoFarm_Bone = p101
	end
})
spawn(function()
	local LocalPlayer = game.Players.LocalPlayer
	local t27 = {
		"Reborn Skeleton",
		"Living Zombie",
		"Demonic Soul",
		"Possessed Mummy"
	}

	while wait(0.5) do
		if _G.AutoFarm_Bone then
			pcall(function()
				local Character = LocalPlayer.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

				if not HumanoidRootPart then
					return
				end

				if LocalPlayer.PlayerGui:FindFirstChild("Main") then
					LocalPlayer.PlayerGui.Main:FindFirstChild("Quest")
				end

				local v524 = GetConnectionEnemies(t27)

				if _G.AcceptQuestB and not _G.CheckQuestVisible(LocalPlayer) then
					local cFrame = CFrame.new(-9516.99316, 172.01718, 6078.46533)

					_tp(cFrame)

					while true do
						wait(2)

						if not _G.AutoFarm_Bone then
							break
						elseif (cFrame.Position - HumanoidRootPart.Position).Magnitude <= 50 then
							break
						end
					end

					if not _G.AutoFarm_Bone then
						return
					end

					local t28 = {
						{
							"StartQuest",
							"HauntedQuest2",
							2
						},
						{
							"StartQuest",
							"HauntedQuest2",
							1
						},
						{
							"StartQuest",
							"HauntedQuest1",
							1
						},
						{
							"StartQuest",
							"HauntedQuest1",
							2
						}
					}

					game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack(t28[math.random(1, #t28)]))
				end

				if v524 then
					while true do
						wait()
						t9.Kill(v524, true)

						if not _G.AutoFarm_Bone then
							break
						elseif not v524.Parent or v524.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
				end
			end)
		end
	end
end)

do
	BoneQ = GRP_Main_Farming_Bone:AddToggle("Accept_Quests", {
		Text = "Accept Quests",
		Default = false,
		Callback = function(p102)
			_G.AcceptQuestBoss = p102
		end
	})
end

GRP_Main_Farming_Bone:AddToggle("Auto_Soul_Reaper", {
	Text = "Auto Soul Reaper",
	Default = false,
	Callback = function(p103)
		_G.AutoHytHallow = p103
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoHytHallow then
			pcall(function()
				local v527 = GetConnectionEnemies("Soul Reaper")

				if v527 then
					while true do
						task.wait()
						t9.Kill(v527, _G.AutoHytHallow)

						if v527.Humanoid.Health <= 0 then
							break
						elseif _G.AutoHytHallow == false then
							break
						end
					end
				elseif GetBP("Hallow Essence") then
					while true do
						wait(0.1)
						_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))

						if _G.AutoHytHallow == false then
							break
						elseif plr.Character.HumanoidRootPart.CFrame == CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125) then
							break
						end
					end

					EquipWeapon("Hallow Essence")
				else
					while true do
						task.wait(0.1)
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						if _G.AutoHytHallow == false then
							break
						elseif GetBP("Hallow Essence") then
							break
						end
					end
				end
			end)
		end
	end
end)
RanBone = GRP_Main_Farming_Bone:AddToggle("Auto_Random_Bones", {
	Text = "Auto Random Bones",
	Default = false,
	Callback = function(p104)
		_G.Auto_Random_Bone = p104
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Random_Bone then
				repeat
					task.wait()
					replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
				until not _G.Auto_Random_Bone
			end
		end)
	end
end)
Lucky = GRP_Main_Farming_Bone:AddToggle("Auto_Try_Luck_Gravestone", {
	Text = "Auto Try Luck Gravestone",
	Default = false,
	Callback = function(p105)
		_G.TryLucky = p105
	end
})
spawn(function()
	local exitTo

	while true do
		if not wait(Sec) then
			exitTo = 1

			break
		end

		if not _G.TryLucky then
			continue
		end

		local cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

		if plr.Character.HumanoidRootPart.CFrame == cFrame then
			if plr.Character.HumanoidRootPart.CFrame ~= cFrame then
				continue
			end

			exitTo = 2

			break
		end

		break
	end

	if exitTo ~= 1 then
		local exitTo2, cFrame

		if exitTo == 2 then
			repeat
				replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
				exitTo2 = nil

				while wait(Sec) do
					if _G.TryLucky then
						cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

						if plr.Character.HumanoidRootPart.CFrame == cFrame then
							if plr.Character.HumanoidRootPart.CFrame == cFrame then
								exitTo2 = 1

								break
							end
						else
							_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
						end
					end
				end
			until exitTo2 ~= 1
		else
			local exitTo3

			repeat
				_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
				exitTo3 = nil

				while wait(Sec) do
					if _G.TryLucky then
						cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

						if plr.Character.HumanoidRootPart.CFrame == cFrame then
							if plr.Character.HumanoidRootPart.CFrame == cFrame then
								exitTo3 = 2

								break
							end
						else
							exitTo3 = 1

							break
						end
					end
				end
			until exitTo3 ~= 1

			if exitTo3 == 2 then
				repeat
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 1)
					exitTo2 = nil

					while wait(Sec) do
						if _G.TryLucky then
							cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

							if plr.Character.HumanoidRootPart.CFrame == cFrame then
								if plr.Character.HumanoidRootPart.CFrame == cFrame then
									exitTo2 = 1

									break
								end
							else
								_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
							end
						end
					end
				until exitTo2 ~= 1
			end
		end
	end
end)

do
	Pray = GRP_Main_Farming_Bone:AddToggle("Auto_Pray_Gravestone", {
		Text = "Auto Pray Gravestone",
		Default = false,
		Callback = function(p106)
			_G.Praying = p106
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.Praying then
			local cFrame = CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813)

			if plr.Character.HumanoidRootPart.CFrame == cFrame then
				if plr.Character.HumanoidRootPart.CFrame == cFrame then
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
				end
			else
				_tp(CFrame.new(-8761.3154296875, 164.85829162598, 6161.1567382813))
			end
		end
	end
end)
GRP_Main_Tyrant_of_the_Skies = t15.Main:AddLeftGroupbox("Tyrant of the Skies")

do
	local v534 = GRP_Main_Tyrant_of_the_Skies:AddLabel("Tyrant of the Skies: ")

	spawn(function()
		pcall(function()
			while wait(1) do
				if workspace.Enemies:FindFirstChild("Tyrant of the Skies") then
					v534:SetText("Tyrant of the Skies: ✅")
				else
					v534:SetText("Tyrant of the Skies: ❌")
				end
			end
		end)
	end)
end

do
	local v535 = GRP_Main_Tyrant_of_the_Skies:AddLabel("Eyes: 0/4")

	Check_Eye = function()
		local IslandModel = workspace.Map.TikiOutpost.IslandModel
		local n4 = 0

		for _, v1 in ipairs({
			IslandModel.Eye1,
			IslandModel.Eye2,
			IslandModel.IslandChunks.E.Eye3,
			IslandModel.IslandChunks.E.Eye4
		}) do
			if v1 and v1.Transparency ~= 1 then
				n4 += 1
			end
		end

		return n4, n4 == 4
	end
	task.spawn(function()
		local v540 = false

		if task.wait(1) then
			repeat
				local v541, v542 = Check_Eye()

				v535:SetText("Eyes: " .. v541 .. "/4")

				if not v542 or v540 then
					if not v542 then
						v540 = false
					end
				else
					v540 = true
				end
			until not task.wait(1)
		end
	end)
end

do
	FarmTyrant = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Farm_Boss_TOTS", {
		Text = "Auto Farm Boss TOTS",
		Default = false,
		Callback = function(p107)
			_G.FarmTyrant = p107
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.FarmTyrant then
				pcall(function()
					if not plr.Character then
						return
					end

					local HumanoidRootPart = plr.Character:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart then
						return
					end

					local vector3 = Vector3.new(-16268.287, 152.616, 1390.773)

					if (HumanoidRootPart.Position - vector3).Magnitude > 5 then
						_tp(CFrame.new(vector3))

						while true do
							wait()

							if not _G.FarmTyrant then
								break
							end

							if not plr.Character then
								continue
							elseif not plr.Character:FindFirstChild("HumanoidRootPart") or not ((plr.Character.HumanoidRootPart.Position - vector3).Magnitude <= 5) then
								continue
							end

							break
						end
					end

					local TyrantOfTheSkies = workspace.Enemies:FindFirstChild("Tyrant of the Skies")

					if TyrantOfTheSkies and TyrantOfTheSkies:FindFirstChild("Humanoid") and TyrantOfTheSkies.Humanoid.Health > 0 then
						while _G.FarmTyrant do
							if t9 and t9.Kill then
								t9.Kill(TyrantOfTheSkies, _G.FarmTyrant)
							end

							wait()

							if not _G.FarmTyrant or not TyrantOfTheSkies.Parent or TyrantOfTheSkies.Humanoid.Health <= 0 then
								break
							end
						end

						return
					end

					for _, v1 in ipairs({
						"Serpent Hunter",
						"Skull Slayer",
						"Isle Champion",
						"Sun-kissed Warrior"
					}) do
						if not _G.FarmTyrant then
							break
						end

						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if not _G.FarmTyrant then
								break
							end

							if child and child.Name == v1 and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 then
								if (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude > 5000 then
									_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

									local now = tick()

									repeat
										wait()
										HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
									until not _G.FarmTyrant or not HumanoidRootPart or (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude <= 6 or tick() - now > 8
								end

								while _G.FarmTyrant do
									if t9 and t9.Kill then
										t9.Kill(child, _G.FarmTyrant)
									end

									wait()

									if not _G.FarmTyrant or not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end)
			end
		end
	end)
end

do
	FarmPhaBinh = GRP_Main_Tyrant_of_the_Skies:AddToggle("Auto_Summon_Boss", {
		Text = "Auto Summon Boss",
		Default = false,
		Callback = function(p108)
			_G.FarmPhaBinh = p108
		end
	})
end

do
	local function v551(p109)
		local VirtualInputManager = game:GetService("VirtualInputManager")

		VirtualInputManager:SendKeyEvent(true, p109, true, game)
		wait(0.05)
		VirtualInputManager:SendKeyEvent(false, p109, true, game)
	end
	local function v553(p110)
		if not plr.Character or not plr.Character:FindFirstChild("Humanoid") or not (plr.Character.Humanoid.Health > 0) then
			return
		end

		for _, child in pairs(plr.Backpack:GetChildren()) do
			if child:IsA("Tool") and child.ToolTip == p110 then
				child.Parent = plr.Character
				wait(0.12)

				for _, v1 in ipairs({
					"Z",
					"X",
					"C",
					"V",
					"F"
				}) do
					if not _G.FarmPhaBinh then
						break
					end

					pcall(function()
						v551(v1)
					end)
					wait(0.12)
				end

				child.Parent = plr.Backpack

				return
			end
		end
	end

	local t29 = {
		CFrame.new(-16332.5263671875, 158.07200622558594, 1440.324951171875),
		CFrame.new(-16288.609375, 158.16700744628906, 1470.3680419921875),
		CFrame.new(-16245.412109375, 158.43699645996094, 1463.365966796875),
		CFrame.new(-16212.46875, 158.16700744628906, 1466.343994140625),
		CFrame.new(-16211.9462890625, 158.07200622558594, 1322.39794921875),
		CFrame.new(-16260.921875, 154.92100524902344, 1323.615966796875),
		CFrame.new(-16297.0595703125, 159.322998046875, 1317.2239990234375),
		CFrame.new(-16335.0966796875, 159.33399963378906, 1324.885986328125)
	}

	spawn(function()
		while wait(Sec) do
			if _G.FarmPhaBinh then
				local exitTo

				repeat
					pcall(function()
						if plr then
							if plr.Character then
								if plr.Character:FindFirstChild("HumanoidRootPart") then
									if plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
										for _, v1 in ipairs(t29) do
											if not _G.FarmPhaBinh then
												break
											end

											_tp(v1)

											local v562 = false
											local now = tick()

											while tick() - now < 12 and _G.FarmPhaBinh do
												local HumanoidRootPart = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

												if not HumanoidRootPart then
													break
												end

												if (HumanoidRootPart.Position - v1.Position).Magnitude <= 3 then
													v562 = true

													break
												end

												wait(0.1)
											end

											if _G.FarmPhaBinh and v562 then
												v553("Melee")
												v553("Sword")
												v553("Gun")
											end
										end

										return
									end
								end
							end
						end
					end)
					exitTo = nil

					while wait(Sec) do
						if _G.FarmPhaBinh then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Main_Farm_Material = t15.Main:AddLeftGroupbox("Farm Material")

do
	Test = GRP_Main_Farm_Material:AddDropdown("Choose_Material", {
		Text = "Choose Material",
		Values = MaterialList,
		Default = 1,
		Callback = function(p111)
			getgenv().SelectMaterial = p111
		end
	})
end

do
	Toggle = GRP_Main_Farm_Material:AddToggle("Auto_Farm_Materials", {
		Text = "Auto Farm Materials",
		Default = false,
		Callback = function(p112)
			getgenv().AutoMaterial = p112
		end
	})
end

spawn(function()
	local function v565(p113, p114)
		if p113:FindFirstChild("Humanoid") then
			if p113:FindFirstChild("HumanoidRootPart") then
				if p113.Humanoid.Health > 0 and p113.Name == p114 then
					while true do
						wait()
						t9.Kill(p113, getgenv().AutoMaterial)

						if not getgenv().AutoMaterial then
							break
						elseif not p113.Parent or p113.Humanoid.Health <= 0 then
							break
						end
					end
				end
			end
		end
	end
	local function v566()
		for _, child in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
			for _, v1 in ipairs(MMon) do
				if string.find(child.Name, v1) and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - child.Position).Magnitude >= 10 then
					_tp(child.CFrame * Pos)
				end
			end
		end
	end

	while wait() do
		if getgenv().AutoMaterial then
			pcall(function()
				if getgenv().SelectMaterial then
					MaterialMon(getgenv().SelectMaterial)
					_tp(MPos)
				end

				for _, v1 in ipairs(MMon) do
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						v565(child, v1)
					end
				end

				v566()
			end)
		end
	end
end)
GRP_Main_Farm_Boss = t15.Main:AddLeftGroupbox("Farm Boss")
BossDropdown = GRP_Main_Farm_Boss:AddDropdown("Select_Boss", {
	Text = "Select Boss",
	Values = BossList,
	Default = 1,
	Callback = function(p115)
		_G.FindBoss = p115
	end
})

do
	FarmBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_Boss", {
		Text = "Auto Farm Boss",
		Default = false,
		Callback = function(p116)
			_G.FarmBoss = p116
			spawn(function()
				while wait(Sec) do
					if _G.FarmBoss then
						pcall(function()
							local q = QuestBeta() -- [0]=boss, [1]=mob, [2]=nivel da quest, [3]=nome da quest, [4]=ponto do boss, [5]=NPC da quest
							local questFrame = plr.PlayerGui.Main.Quest
							local hasQuest = _G.AcceptQuestBoss and q[2] ~= nil and q[3] ~= nil

							-- quest opcional: tem limite de tempo (antes o script ficava preso na missao)
							if hasQuest and tick() > (ZyroxBossQuestSkip or 0) then
								if questFrame.Visible and not string.find(questFrame.Container.QuestTitle.Title.Text, q[0]) then
									replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
									return
								end

								if not questFrame.Visible then
									ZyroxBossQuestSince = ZyroxBossQuestSince or tick()

									if tick() - ZyroxBossQuestSince > 20 then
										ZyroxBossQuestSkip = tick() + 120
										ZyroxBossQuestSince = nil
									else
										if not ZyroxClaim("boss") then
											return
										end

										_tp(q[5])

										if (plr.Character.HumanoidRootPart.Position - q[5].Position).Magnitude <= 5 then
											replicated.Remotes.CommF_:InvokeServer("StartQuest", q[3], q[2])
										end

										return
									end
								else
									ZyroxBossQuestSince = nil
								end
							end

							-- acha o boss (Enemies primeiro; o modelo de ReplicatedStorage so serve para se aproximar)
							local boss

							for _, container in ipairs({ workspace.Enemies, replicated }) do
								local candidate = container:FindFirstChild(q[1])

								if candidate and candidate:FindFirstChild("HumanoidRootPart") and candidate:FindFirstChildOfClass("Humanoid")
									and candidate.Humanoid.Health > 0 and t9.Alive(candidate) then
									boss = candidate
									break
								end
							end

							if not ZyroxClaim("boss") then
								return
							end

							if not boss then
								if q[4] then
									_tp(q[4]) -- espera perto do ponto do boss
								end

								return
							end

							if not boss:IsDescendantOf(workspace) then
								_tp(boss.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

								local waited = 0

								while _G.FarmBoss and waited < 8 and not workspace.Enemies:FindFirstChild(q[1]) do
									wait(0.5)
									waited = waited + 0.5
								end

								return
							end

							-- luta (anti-trava: sem dano por 12s pula o boss)
							local lastHp, since = nil, tick()

							while _G.FarmBoss do
								wait()
								t9.Kill(boss, _G.FarmBoss)

								if not boss.Parent or boss.Humanoid.Health <= 0 then
									break
								end

								if lastHp ~= boss.Humanoid.Health then
									lastHp, since = boss.Humanoid.Health, tick()
								elseif tick() - since > 12 then
									boss:SetAttribute("ZyroxSkip", tick())
									break
								end
							end
						end)
					end
				end
			end)
		end
	})
end

do
	BossQ = GRP_Main_Farm_Boss:AddToggle("Accept_Quests", {
		Text = "Accept Quests",
		Default = true,
		Callback = function(p117)
			_G.AcceptQuestBoss = p117
		end
	})
end

FarmAllBoss = GRP_Main_Farm_Boss:AddToggle("Auto_Farm_All_Boss", {
	Text = "Auto Farm All Boss",
	Default = false,
	Callback = function(p118)
		_G.AutoFarmAllBoss = p118
	end
})
task.spawn(function()
	while task.wait(0.3) do
		if _G.AutoFarmAllBoss then
			pcall(function()
				local LocalPlayer = game.Players.LocalPlayer

				if LocalPlayer.Character then
					if LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
						local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
						local v583
						local huge = math.huge

						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child.Humanoid.Health > 0 and table.find(BossList, child.Name) then
								local Magnitude = (HumanoidRootPart.Position - child.HumanoidRootPart.Position).Magnitude

								if Magnitude < huge then
									v583 = child
									huge = Magnitude
								end
							end
						end

						if v583 then
							if v583:FindFirstChild("HumanoidRootPart") then
								local HumanoidRootPart2 = v583.HumanoidRootPart
								local Humanoid = v583.Humanoid

								while true do
									task.wait(0.1)

									if _G.AutoFarmAllBoss then
										local v590 = HumanoidRootPart2.CFrame * CFrame.new(0, 5, 0)

										if (HumanoidRootPart.Position - v590.Position).Magnitude > 100 then
											LocalPlayer.Character:PivotTo(v590)
										else
											_tp(v590)
										end

										if t9 and typeof(t9.Kill) == "function" then
											t9.Kill(v583, true)
										end

										if not v583.Parent or Humanoid.Health <= 0 or not _G.AutoFarmAllBoss then
											break
										end
									else
										break
									end
								end
							end
						end

						return
					end
				end
			end)
		end
	end
end)
_G.MasteryHealthPct = 70
_G.SelectedMasterySkills = {
	Z = true,
	X = true,
	C = true,
	V = true,
	F = true
}

do
	local v591 = t15.Main:AddLeftGroupbox("Farming Mastery")
	local s14 = "Cake"

	v591:AddDropdown("Choose_Island", {
		Text = "Choose Island",
		Values = {
			"Cake",
			"Bone"
		},
		Default = 1,
		Callback = function(p119)
			s14 = p119
		end
	})
	v591:AddSlider({
		Text = "NPC Health % Switch to Weapon",
		Min = 10,
		Max = 95,
		Default = 70,
		Rounding = 1,
		Callback = function(p120)
			_G.MasteryHealthPct = p120
		end
	})
	v591:AddDropdown("Select_Skills", {
		Text = "Select Skills to Use",
		Values = {
			"Z",
			"X",
			"C",
			"V",
			"F",
			"Y"
		},
		Multi = true,
		Default = {
			Z = true,
			X = true,
			C = true,
			V = true,
			F = true
		},
		Callback = function(p121, p122)
			if type(p121) == "table" then
				_G.SelectedMasterySkills = p121
			elseif type(p121) == "string" then
				if type(_G.SelectedMasterySkills) ~= "table" then
					_G.SelectedMasterySkills = {}
				end

				_G.SelectedMasterySkills[p121] = p122 and true or nil
			end
		end
	})
	v591:AddToggle("Auto_Mastery_Fruits", {
		Text = "Auto Mastery Fruits",
		Default = false,
		Callback = function(p123)
			_G.FarmMastery_Dev = p123
		end
	})
	spawn(function()
		RunSer.RenderStepped:Connect(function()
			pcall(function()
				if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then
					for _, child in pairs(plr.PlayerGui.Notifications:GetChildren()) do
						if child.Name == "NotificationTemplate" and string.find(child.Text, "Skill locked!") then
							child:Destroy()
						end
					end
				end
			end)
		end)
	end)
	spawn(function()
		while wait(Sec) do
			if _G.FarmMastery_Dev then
				pcall(function()
					if s14 == "Cake" then
						local v595 = GetConnectionEnemies(t5)

						if v595 then
							while true do
								wait()
								HealthM = v595.Humanoid.MaxHealth * (_G.MasteryHealthPct / 100)
								MousePos = v595.HumanoidRootPart.Position
								t9.Mas(v595, _G.FarmMastery_Dev)

								if _G.FarmMastery_Dev == false then
									break
								elseif v595.Humanoid.Health <= 0 or not v595.Parent then
									break
								end
							end
						else
							_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
						end
					elseif s14 == "Bone" then
						local v596 = GetConnectionEnemies(t6)

						if v596 then
							while true do
								wait()
								HealthM = v596.Humanoid.MaxHealth * (_G.MasteryHealthPct / 100)
								MousePos = v596.HumanoidRootPart.Position
								t9.Mas(v596, _G.FarmMastery_Dev)

								if _G.FarmMastery_Dev == false then
									break
								elseif v596.Humanoid.Health <= 0 or not v596.Parent then
									break
								end
							end
						else
							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
						end
					end
				end)
			end
		end
	end)
	v591:AddToggle("Auto_Mastery_Gun", {
		Text = "Auto Mastery Gun",
		Default = false,
		Callback = function(p124)
			_G.FarmMastery_G = p124
		end
	})
	spawn(function()
		while wait(Sec) do
			if _G.FarmMastery_G then
				pcall(function()
					if s14 == "Cake" then
						local v597 = GetConnectionEnemies(t5)

						if v597 then
							HealthM = v597.Humanoid.MaxHealth * _G.MasteryHealthPct / 100

							repeat
								wait()
								MousePos = v597.HumanoidRootPart.Position
								t9.Masgun(v597, _G.FarmMastery_G)

								local REShootGunEvent = replicated:FindFirstChild("Modules"):FindFirstChild("Net"):FindFirstChild("RE/ShootGunEvent")

								if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end

								local Character, Character2

								if not plr.Character:FindFirstChildOfClass("Tool") then
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v597.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end
								elseif plr.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
									SoulGuitar = true
									plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)

									if _G.FarmMastery_G then
										vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								else
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v597.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end

									if _G.FarmMastery_G == false or v597.Humanoid.Health <= 0 or not v597.Parent then
										break
									end
								end
							until _G.FarmMastery_G == false or v597.Humanoid.Health <= 0 or not v597.Parent

							SoulGuitar = false
						else
							_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
						end
					elseif s14 == "Bone" then
						local v601 = GetConnectionEnemies(t6)

						if v601 then
							HealthM = v601.Humanoid.MaxHealth * _G.MasteryHealthPct / 100

							repeat
								wait()
								MousePos = v601.HumanoidRootPart.Position
								t9.Masgun(v601, _G.FarmMastery_G)

								local REShootGunEvent = replicated:FindFirstChild("Modules"):FindFirstChild("Net"):FindFirstChild("RE/ShootGunEvent")

								if plr.Character:FindFirstChildOfClass("Tool").ToolTip ~= "Gun" then
									return
								end

								local Character, Character2

								if not plr.Character:FindFirstChildOfClass("Tool") then
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v601.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end
								elseif plr.Character:FindFirstChildOfClass("Tool").Name == "Skull Guitar" then
									SoulGuitar = true
									plr.Character:FindFirstChildOfClass("Tool").RemoteEvent:FireServer("TAP", MousePos)

									if _G.FarmMastery_G then
										vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
										wait(0.05)
										vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
										wait(0.05)
									end
								else
									Character = plr.Character

									if Character:FindFirstChildOfClass("Tool") then
										Character2 = plr.Character

										if Character2:FindFirstChildOfClass("Tool").Name ~= "Skull Guitar" then
											SoulGuitar = false
											REShootGunEvent:FireServer(MousePos, { v601.HumanoidRootPart })

											if _G.FarmMastery_G then
												vim1:SendMouseButtonEvent(0, 0, 0, true, game, 1)
												wait(0.05)
												vim1:SendMouseButtonEvent(0, 0, 0, false, game, 1)
												wait(0.05)
											end
										end
									end

									if _G.FarmMastery_G == false or v601.Humanoid.Health <= 0 or not v601.Parent then
										break
									end
								end
							until _G.FarmMastery_G == false or v601.Humanoid.Health <= 0 or not v601.Parent

							SoulGuitar = false
						else
							_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
						end
					end
				end)
			end
		end
	end)
	v591:AddToggle("Auto_Mastery_All_Sword", {
		Text = "Auto Mastery All Sword",
		Default = false,
		Callback = function(p125)
			_G.FarmMastery_S = p125
		end
	})
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.FarmMastery_S then
					if s14 == "Cake" then
						local next_ = next
						local response, v607 = replicated.Remotes.CommF_:InvokeServer("getInventory")
						local exitTo2
						local v609

						for _, v1 in next_, response, v607 do
							if type(v1) == "table" and v1.Type == "Sword" then
								v609 = v1
								exitTo2 = 1

								break
							end
						end

						if exitTo2 == 1 then
							SwordName = v609.Name

							if tonumber(v609.Mastery) >= 1 or tonumber(v609.Mastery) <= 599 then
								local v612 = GetConnectionEnemies(t5)

								if not GetBP(SwordName) then
									replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
								elseif v612 then
									while true do
										wait()
										t9.Sword(v612, _G.FarmMastery_S)

										if _G.FarmMastery_S == false then
											break
										elseif not v612.Parent or v612.Humanoid.Health <= 0 then
											break
										end
									end
								else
									_tp(CFrame.new(-1943.676513671875, 251.50956726074219, -12337.880859375))
								end
							elseif tonumber(v609.Mastery) >= 600 then
								if GetBP(SwordName) then
									return nil
								end

								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
							end
						end
					elseif s14 == "Bone" then
						local next_ = next
						local response, v615 = replicated.Remotes.CommF_:InvokeServer("getInventory")
						local exitTo
						local v617

						for _, v1 in next_, response, v615 do
							if type(v1) == "table" then
								if v1.Type == "Sword" then
									v617 = v1
									exitTo = 1

									break
								end
							end
						end

						if exitTo == 1 then
							SwordName = v617.Name

							if tonumber(v617.Mastery) >= 1 or tonumber(v617.Mastery) <= 599 then
								local v620 = GetConnectionEnemies(t6)

								if not GetBP(SwordName) then
									replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
								elseif v620 then
									while true do
										wait()
										t9.Sword(v620, _G.FarmMastery_S)

										if _G.FarmMastery_S == false then
											break
										elseif not v620.Parent or v620.Humanoid.Health <= 0 then
											break
										end
									end
								else
									_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
								end
							elseif tonumber(v617.Mastery) >= 600 then
								if GetBP(SwordName) then
									return nil
								end

								replicated.Remotes.CommF_:InvokeServer("LoadItem", SwordName)
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_Settings_Settings_Configure = t15.Settings:AddLeftGroupbox("Settings / Configure")
Initialize = GRP_Settings_Settings_Configure:AddToggle("Fast_Attack", {
	Text = "Fast Attack",
	Default = true,
	Callback = function(p133)
		_G.Seriality = p133
	end
})

do
	Bringmob = GRP_Settings_Settings_Configure:AddToggle("Bring_Mobs", {
		Text = "Bring Mobs",
		Default = true,
		Callback = function(p134)
			_B = p134
		end
	})
end

-- velocidade do tween (usada pelo _tp: TweenSpeedNear / TweenSpeedFar). Padrao do Zyrox: 270
do
	GRP_Settings_Settings_Configure:AddDropdown("Tween_Speed", {
		Text = "Tween Speed",
		Values = { "170", "220", "250", "270", "300" },
		Default = 4,
		Callback = function(value)
			local speed = tonumber(value)
			if speed then
				getgenv().TweenSpeedNear = speed
				getgenv().TweenSpeedFar = speed
			end
		end
	})
end

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Hop_Server_with_time", {
		Text = "Auto Hop Server with time",
		Default = false,
		Callback = function(p135)
			_G.AutoHopServer = p135

			if not p135 then
				_G.HopTimer = nil
			end
		end
	})
end

Spawn(function()
	while Wait(1) do
		if _G.AutoHopServer then
			pcall(function()
				if not _G.HopTimer then
					_G.HopTimer = tick()
				end

				if _G.HopDelay <= tick() - _G.HopTimer then
					_G.HopTimer = tick()

					if syn and syn.queue_on_teleport then
						syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/bloxfruitsnokey/Redz/refs/heads/main/Chest'))()")
					end

					game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
				end
			end)
		end
	end
end)
GRP_Settings_Settings_Configure:AddSlider({
	Text = "Hop Delay (Minutes)",
	Min = 5,
	Max = 120,
	Default = 30,
	Rounding = 0,
	Callback = function(p136)
		_G.HopDelay = p136 * 60
	end
})

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Set_Spawn_Point", {
		Text = "Auto Set Spawn Point",
		Default = false,
		Callback = function(p137)
			getgenv().Set = p137

			if p137 then
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
				end)
			end
		end
	})
end

BusuAura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Buso", {
	Text = "Auto Turn on Buso",
	Default = true,
	Callback = function(p138)
		Boud = p138
	end
})

do
	spawn(function()
		if wait(Sec) then
			repeat
				pcall(function()
					if Boud then
						local t36 = {
							"HasBuso",
							"Buso"
						}

						if not plr.Character:FindFirstChild(t36[1]) then
							replicated.Remotes.CommF_:InvokeServer(t36[2])
						end
					end
				end)
			until not wait(Sec)
		end
	end)
end

GRP_Settings_Settings_Configure:AddToggle("Auto_Haki_Observation", {
	Text = "Auto Haki Observation",
	Default = false,
	Callback = function(p139)
		getgenv().Observation = p139
	end
})

do
	spawn(function()
		while wait() do
			if getgenv().Observation then
				local exitTo

				repeat
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
					end)
					exitTo = nil

					while wait() do
						if getgenv().Observation then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

RaceV3Aura = GRP_Settings_Settings_Configure:AddToggle("AutoTurnonRaceV3", {
	Text = "Auto Turn on Race V3",
	Default = false,
	Callback = function(p140)
		_G.RaceClickAutov3 = p140
	end
})

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.RaceClickAutov3 then
					repeat
						replicated.Remotes.CommE:FireServer("ActivateAbility")
						wait(30)
					until not _G.RaceClickAutov3
				end
			end)
		end
	end)
end

do
	RaceV4Aura = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Race_V4", {
		Text = "Auto Turn on Race V4",
		Default = false,
		Callback = function(p141)
			_G.RaceClickAutov4 = p141
		end
	})
end

do
	spawn(function()
		if wait(0.2) then
			repeat
				pcall(function()
					if _G.RaceClickAutov4 then
						if plr.Character:FindFirstChild("RaceEnergy") then
							if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
								Useskills("nil", "Y")
							end
						end
					end
				end)
			until not wait(0.2)
		end
	end)
end

do
	RandomAround = GRP_Settings_Settings_Configure:AddToggle("Auto_Turn_on_Spin__xyz", {
		Text = "Auto Turn on Spin  xyz",
		Default = false,
		Callback = function(p142)
			RandomCFrame = p142
		end
	})
end

do
	SafeModes = GRP_Settings_Settings_Configure:AddToggle("Safe_Mode", {
		Text = "Safe Mode",
		Default = false,
		Callback = function(p143)
			_G.Safemode = p143
		end
	})
end

do
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.Safemode then
					if plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100 < Num_self then
						shouldTween = true
						_tp(Root.CFrame * CFrame.new(0, 500, 0))
					else
						shouldTween = false
					end
				end
			end)
		end
	end)
end

DisableHitVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Hit_VFX", {
	Text = "Remove Hit VFX",
	Default = false,
	Callback = function(p144)
		_G.DestroyHit = p144
	end
})

do
	local t37 = {
		"SlashHit",
		"CurvedRing",
		"SwordSlash",
		"SlashTail"
	}

	task.spawn(function()
		while task.wait(Sec) do
			if _G.DestroyHit then
				pcall(function()
					for _, child in pairs(workspace._WorldOrigin:GetChildren()) do
						if table.find(t37, child.Name) then
							child:Destroy()
						end
					end
				end)
			end
		end
	end)
end

RmvVFX = GRP_Settings_Settings_Configure:AddToggle("Remove_Death_&_Respawned_VFX", {
	Text = "Remove Death & Respawned VFX",
	Default = false,
	Callback = function(p145)
		RDeath = p145
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if RDeath then
					if replicated.Effect.Container:FindFirstChild("Death") then
						replicated.Effect.Container.Death:Destroy()
					end

					if replicated.Effect.Container:FindFirstChild("Respawn") then
						replicated.Effect.Container.Respawn:Destroy()
					end
				end
			end)
		end
	end)
end

do
	DisblesNotify = GRP_Settings_Settings_Configure:AddToggle("Disable_Notify", {
		Text = "Disable Notify",
		Default = false,
		Callback = function(p146)
			RemoveDamage = p146
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if RemoveDamage then
					replicated.Assets.GUI.DamageCounter.Enabled = false
					plr.PlayerGui.Notifications.Enabled = false
				else
					replicated.Assets.GUI.DamageCounter.Enabled = true
					plr.PlayerGui.Notifications.Enabled = true
				end
			end)
		end
	end)
end

do
	GRP_Settings_Settings_Configure:AddToggle("Anti_AFK", {
		Text = "Anti AFK",
		Default = true,
		Callback = function(p147)
			if p147 then
				local VirtualUser = game:GetService("VirtualUser")

				repeat
					wait()
				until game:IsLoaded()

				game:GetService("Players").LocalPlayer.Idled:Connect(function()
					VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
					wait(1)
					VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
				end)
			end
		end
	})
end

do
	GRP_Settings_Settings_Configure:AddToggle("Auto_Anti_-_Admin_Join_Server", {
		Text = "Auto Anti - Admin Join Server",
		Default = true,
		Callback = function(p148)
			getgenv().HopServerAdmin = p148
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if getgenv().HopServerAdmin then
				for _, player in pairs(game.Players:GetPlayers()) do
					if table.find({
						"red_game43",
						"rip_indra",
						"Axiore",
						"Polkster",
						"wenlocktoad",
						"Daigrock",
						"toilamvidamme",
						"oofficialnoobie",
						"Uzoth",
						"Azarth",
						"arlthmetic",
						"Death_King",
						"Lunoven",
						"TheGreateAced",
						"rip_fud",
						"drip_mama",
						"layandikit12",
						"Hingoi"
					}, player.Name) then
						Hop()
					end
				end
			end
		end)
	end
end)
GRP_Settings_Settings_Configure:AddToggle("No_Clip", {
	Text = "No Clip",
	Default = false,
	Callback = function(p149)
		getgenv().NoClip = p149
	end
})
spawn(function()
	pcall(function()
		game:GetService("RunService").Stepped:Connect(function()
			if getgenv().NoClip then
				for _, descendant in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if descendant:IsA("BasePart") or descendant:IsA("Part") then
						descendant.CanCollide = false
					end
				end
			end
		end)
	end)
end)
GRP_Esp_Stats_Upgrade = t15.Esp:AddLeftGroupbox("Stats Upgrade")

do
	StatusSelect = GRP_Esp_Stats_Upgrade:AddSlider({
		Text = "Stats Value",
		Min = 0,
		Max = 1000,
		Default = 10,
		Rounding = 0,
		Callback = function(p150)
			pSats = p150
		end
	})
end

do
	StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Melee", {
		Text = "Auto Melee",
		Default = false,
		Callback = function(p151)
			_G.Auto_Melee = p151
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Melee then
				statsSetings("Melee", pSats)
			end
		end)
	end
end)

do
	StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Swords", {
		Text = "Auto Swords",
		Default = false,
		Callback = function(p152)
			_G.Auto_Sword = p152
		end
	})
end

spawn(function()
	if wait(Sec) then
		repeat
			pcall(function()
				if _G.Auto_Sword then
					statsSetings("Sword", pSats)
				end
			end)
		until not wait(Sec)
	end
end)
StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Gun", {
	Text = "Auto Gun",
	Default = false,
	Callback = function(p153)
		_G.Auto_Gun = p153
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Gun then
					statsSetings("Gun", pSats)
				end
			end)
		end
	end)
end

StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Blox_Fruit", {
	Text = "Auto Blox Fruit",
	Default = false,
	Callback = function(p154)
		_G.Auto_DevilFruit = p154
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_DevilFruit then
					statsSetings("Devil", pSats)
				end
			end)
		end
	end)
end

StatsUpg = GRP_Esp_Stats_Upgrade:AddToggle("Auto_Defense", {
	Text = "Auto Defense",
	Default = false,
	Callback = function(p155)
		_G.Auto_Defense = p155
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Defense then
					statsSetings("Defense", pSats)
				end
			end)
		end
	end)
end

GRP_Fish_Fishing = t15.Fish:AddLeftGroupbox("Fishing")

do
	GRP_Fish_Fishing:AddDropdown("Select_Fishing_Rod", {
		Text = "Select Fishing Rod",
		Values = {
			"Fishing Rod",
			"Gold Rod",
			"Shark Rod",
			"Shell Rod",
			"Treasure Rod"
		},
		Default = "Fishing Rod",
		Callback = function(p156)
			_G.SelectedRod = p156
		end
	})
end

BaitDropdown = GRP_Fish_Fishing:AddDropdown("Select_Bait", {
	Text = "Select Bait",
	Values = {
		"Basic Bait",
		"Kelp Bait",
		"Good Bait",
		"Abyssal Bait",
		"Frozen Bait",
		"Epic Bait",
		"Carnivore Bait"
	},
	Default = "Basic Bait",
	Callback = function(p157)
		_G.SelectedBait = p157

		if _G.AutoBuyBait then
			pcall(function()
				t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
			end)
		end
	end
})

do
	BuyBaitToggle = GRP_Fish_Fishing:AddToggle("Auto_Buy_Bait", {
		Text = "Auto Buy Bait",
		Default = false,
		Callback = function(p158)
			_G.AutoBuyBait = p158

			if p158 then
				pcall(function()
					t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
				end)
			end
		end
	})
end

do
	task.spawn(function()
		while task.wait(2) do
			if _G.AutoBuyBait and _G.SelectedBait then
				pcall(function()
					t8.RFCraft:InvokeServer("Craft", _G.SelectedBait, {})
				end)
			end
		end
	end)
end

FishingToggle = GRP_Fish_Fishing:AddToggle("Auto_Fishing", {
	Text = "Auto Fishing",
	Default = false,
	Callback = function(p159)
		_G.AutoFishing = p159
	end
})

local Players = game:GetService("Players")

do
	local LocalPlayer = Players.LocalPlayer
	local Workspace = game:GetService("Workspace")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local FishReplicated = ReplicatedStorage2:WaitForChild("FishReplicated")
	local FishingRequest = FishReplicated:WaitForChild("FishingRequest")
	local Config = require(FishReplicated.FishingClient.Config)
	local GetWaterHeightAtLocation = require(ReplicatedStorage2.Util.GetWaterHeightAtLocation)
	local MaxLaunchDistance = Config.Rod.MaxLaunchDistance

	task.spawn(function()
		while task.wait(0.5) do
			if _G.AutoFishing then
				pcall(function()
					local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart then
						return
					end

					local Tool = Character:FindFirstChildOfClass("Tool")

					if _G.SelectedRod and (not Tool or Tool.Name ~= _G.SelectedRod) then
						local _GSelectedRod = LocalPlayer.Backpack:FindFirstChild(_G.SelectedRod)

						if _GSelectedRod then
							Character.Humanoid:EquipTool(_GSelectedRod)
							Tool = _GSelectedRod
						end
					end

					if Tool then
						local v735 = GetWaterHeightAtLocation(HumanoidRootPart.Position)
						local _, v737 = Workspace:FindPartOnRayWithIgnoreList(Ray.new(Character.Head.Position, HumanoidRootPart.CFrame.LookVector * MaxLaunchDistance), {
							Character,
							Workspace.Characters,
							Workspace.Enemies
						})
						local vector3 = v737 and Vector3.new(v737.X, math.max(v737.Y, v735), v737.Z)
						local attribute = Tool:GetAttribute("State")
						local attribute2 = Tool:GetAttribute("ServerState")

						if vector3 and (attribute == "ReeledIn" or attribute2 == "ReeledIn") then
							FishingRequest:InvokeServer("StartCasting")
							task.wait()
							FishingRequest:InvokeServer("CastLineAtLocation", vector3, 100, true)
						elseif attribute2 == "Biting" then
							FishingRequest:InvokeServer("Catching", true)
							task.wait(0.1)
							FishingRequest:InvokeServer("Catch", 1)
						end
					end
				end)
			end
		end
	end)
end

FishingQ = GRP_Fish_Fishing:AddToggle("Auto_Quest_Fishing", {
	Text = "Auto Quest Fishing",
	Default = false,
	Callback = function(p160)
		_G.AutoFishingQuest = p160
	end
})

do
	local LocalPlayer = game:GetService("Players").LocalPlayer
	local RFJobsRemoteFunction = game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobsRemoteFunction")

	local function v743()
		local Quest = LocalPlayer.PlayerGui:FindFirstChild("Quest") or LocalPlayer.PlayerGui:FindFirstChild("QuestGui")

		if Quest and Quest:FindFirstChild("Container") then
			if Quest.Container:FindFirstChild("QuestTitle") then
				return true
			end
		end

		return false
	end

	task.spawn(function()
		while task.wait(1) do
			if _G.AutoFishingQuest then
				pcall(function()
					if not v743() then
						RFJobsRemoteFunction:InvokeServer("FishingNPC", "Angler", "AskQuest")
					end
				end)
			end
		end
	end)
end

do
	QuestToggle = GRP_Fish_Fishing:AddToggle("Auto_Complete_Quest", {
		Text = "Auto Complete Quest",
		Default = false,
		Callback = function(p161)
			_G.AutoQuestComplete = p161

			if p161 then
				pcall(function()
					t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
				end)
			end
		end
	})
end

task.spawn(function()
	while task.wait(5) do
		if _G.AutoQuestComplete then
			pcall(function()
				t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "FinishQuest")
			end)
		end
	end
end)
SellFishToggle = GRP_Fish_Fishing:AddToggle("Auto_Sell_Fish", {
	Text = "Auto Sell Fish",
	Default = false,
	Callback = function(p162)
		_G.AutoSellFish = p162

		if p162 then
			pcall(function()
				t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
			end)
		end
	end
})

do
	task.spawn(function()
		while task.wait(5) do
			if _G.AutoSellFish then
				pcall(function()
					t8.RFJobsRemoteFunction:InvokeServer("FishingNPC", "SellFish")
				end)
			end
		end
	end)
end

do
	SpamSkillZ = GRP_Fish_Fishing:AddToggle("Auto_Spam_Skill_Z", {
		Text = "Auto Spam Skill Z",
		Default = false,
		Callback = function(p163)
			_G.AutoSkillZ = p163
		end
	})
end


-- ===================== 3NN FISHING: CHANGE SIZE REEL =====================
do
	GRP_Fish_Fishing:AddToggle("Change_Size_Reel", {
		Text = "Change Size Reel",
		Default = false,
		Callback = function(enabled)
			_G.ChangeSizeReel = enabled
			if enabled then
				task.spawn(function()
					local player = game:GetService("Players").LocalPlayer
					while _G.ChangeSizeReel do
						task.wait()
						pcall(function()
							local gui = player:FindFirstChild("PlayerGui")
							local reeling = gui and gui:FindFirstChild("Fishing_Reeling")
							local minigame = reeling and reeling:FindFirstChild("Minigame")
							local container = minigame and minigame:FindFirstChild("Container")
							local reelZone = container and container:FindFirstChild("ReelZone")
							if reelZone then
								reelZone.Size = UDim2.new(0.98, 0, 0.13, 0)
							end
						end)
					end
				end)
			end
		end
	})
end

-- ===================== AUTO SLAP BATTLE (logica Banana/Nexora, janela ampliada) =====================
do
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local player = Players.LocalPlayer
	local eventConnection
	local heartbeatConnection
	local toggleGeneration = 0
	local lastJump = 0

	local function stopAutoSlap()
		if eventConnection then
			pcall(function()
				eventConnection:Disconnect()
			end)
			eventConnection = nil
		end
		if heartbeatConnection then
			pcall(function()
				heartbeatConnection:Disconnect()
			end)
			heartbeatConnection = nil
		end
	end

	local function triangle(value, low, high)
		-- espelha o valor entre low..high como a barra do slap
		local span = high - low
		if span <= 0 then
			return low
		end
		local t = (value - low) % (span * 2)
		if t > span then
			return high - (t - span)
		end
		return low + t
	end

	GRP_Fish_Fishing:AddToggle("Auto_Slap_Battle", {
		Text = "Auto Slap Battle",
		Tooltip = "Banana/Nexora timing — janela ampliada",
		Default = false,
		Callback = function(enabled)
			_G.AutoSlapBattle = enabled
			toggleGeneration = toggleGeneration + 1
			local generation = toggleGeneration
			stopAutoSlap()
			if not enabled then
				return
			end

			task.spawn(function()
				-- espera o RemoteEvent do minigame (so existe durante a slap battle)
				local remoteEvent
				local waitUntil = tick() + 120
				while _G.AutoSlapBattle and generation == toggleGeneration and tick() < waitUntil do
					remoteEvent = player:FindFirstChild("RemoteEvent")
					if remoteEvent then
						break
					end
					task.wait(0.25)
				end
				if not remoteEvent or not _G.AutoSlapBattle or generation ~= toggleGeneration then
					return
				end

				-- assinatura Banana: action, startTime, cycle, targetPlayer, _, _, _, fixedTarget
				eventConnection = remoteEvent.OnClientEvent:Connect(function(action, startTime, cycle, targetPlayer, _a, _b, _c, fixedTarget)
					if not _G.AutoSlapBattle or generation ~= toggleGeneration then
						return
					end

					-- fixedTarget pode vir no 7o arg em alguns builds
					if fixedTarget == nil then
						fixedTarget = _c
					end

					if action == "startBar" and targetPlayer == player then
						local safeCycle = tonumber(cycle)
						local t0 = tonumber(startTime)
						if not safeCycle or safeCycle <= 0 or not t0 then
							return
						end

						if heartbeatConnection then
							pcall(function()
								heartbeatConnection:Disconnect()
							end)
							heartbeatConnection = nil
						end

						-- mesma formula Banana/Nexora
						local speed = 0.96 / (safeCycle * 0.5)
						local targetSpeed = 0.2 / (safeCycle * 1.5)
						local hitWindow = 0.055 -- ampliado (antes 0.03) — menos miss
						local jumpedThisPass = false
						local lastBar = 0

						heartbeatConnection = RunService.Heartbeat:Connect(function()
							if not _G.AutoSlapBattle or generation ~= toggleGeneration then
								stopAutoSlap()
								return
							end
							if not remoteEvent.Parent then
								stopAutoSlap()
								return
							end

							local now = workspace:GetServerTimeNow()
							local bar = 0.02 + (now - t0) % safeCycle * speed
							if bar >= 0.98 then
								bar = 0.98 - (bar - 0.98)
							end

							local target
							if fixedTarget then
								target = 0.5
							else
								target = 0.4 + (now - t0) % (safeCycle * 3) * targetSpeed
								if target >= 0.6 then
									target = 0.6 - (target - 0.6)
								end
							end

							local dist = math.abs(bar - target)

							-- reset flag quando a barra se afasta (nova passagem)
							if dist > hitWindow * 2.2 then
								jumpedThisPass = false
							end

							-- atira quando entra na janela; permite 2 jumps curtos se ainda perto
							if dist <= hitWindow and not jumpedThisPass then
								local tnow = tick()
								if tnow - lastJump > 0.05 then
									lastJump = tnow
									jumpedThisPass = true
									pcall(function()
										remoteEvent:FireServer("Jump", workspace:GetServerTimeNow())
									end)
									-- segundo shot um frame depois (rede / delay)
									task.delay(0.03, function()
										if _G.AutoSlapBattle and remoteEvent and remoteEvent.Parent then
											pcall(function()
												remoteEvent:FireServer("Jump", workspace:GetServerTimeNow())
											end)
										end
									end)
								end
							end

							lastBar = bar
						end)
					elseif action == "killBar" then
						if heartbeatConnection then
							pcall(function()
								heartbeatConnection:Disconnect()
							end)
							heartbeatConnection = nil
						end
					end
				end)
			end)
		end
	})
end

do
	local RFJobToolAbilities = game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RF/JobToolAbilities")

	task.spawn(function()
		while task.wait(0.5) do
			if _G.AutoSkillZ then
				local exitTo

				repeat
					pcall(function()
						RFJobToolAbilities:InvokeServer("Z", true)
					end)
					exitTo = nil

					while task.wait(0.5) do
						if _G.AutoSkillZ then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_Quests_Auto_Quest_Sea_2 = t15.Quests:AddLeftGroupbox("Auto Quest Sea 2")

do
	TravelDress = GRP_Quests_Auto_Quest_Sea_2:AddToggle("Auto_Quest_Sea_2", {
		Text = "Auto Quest Sea 2",
		Default = false,
		Callback = function(p164)
			_G.TravelDres = p164
		end
	})
end

spawn(function()
	if wait(Sec) then
		repeat
			pcall(function()
				if _G.TravelDres and plr.Data.Level.Value >= 700 then
					if workspace.Map.Ice.Door.CanCollide == true and workspace.Map.Ice.Door.Transparency == 0 then
						replicated.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
						EquipWeapon("Key")

						while true do
							wait()
							_tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))

							if not _G.TravelDres then
								break
							elseif Root.Position == CFrame.new(1347.7124, 37.3751602, -1325.6488).Position then
								break
							end
						end
					elseif workspace.Map.Ice.Door.CanCollide ~= false or workspace.Map.Ice.Door.Transparency ~= 1 then
						replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
					elseif Enemies:FindFirstChild("Ice Admiral") then
						for _, child in pairs(Enemies:GetChildren()) do
							if child.Name == "Ice Admiral" and t9.Alive(child) then
								while true do
									task.wait()
									t9.Kill(child, _G.TravelDres)

									if _G.TravelDres == false then
										break
									elseif child.Humanoid.Health <= 0 then
										break
									end
								end

								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
							end
						end
					else
						_tp(CFrame.new(1347.7124, 37.3751602, -1325.6488))
					end
				end
			end)
		until not wait(Sec)
	end
end)
Zou = GRP_Quests_Auto_Quest_Sea_2:AddToggle("Auto_Quest_Sea_3", {
	Text = "Auto Quest Sea 3",
	Default = false,
	Callback = function(p165)
		_G.AutoZou = p165
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoZou and plr.Data.Level.Value >= 1500 then
				if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 3 then
					if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") ~= 0 then
						if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
							local Jeremy = GetConnectionEnemies("Jeremy")

							if Jeremy then
								while true do
									wait()
									t9.Kill(Jeremy, _G.AutoZou)

									if not Jeremy.Parent then
										break
									elseif Jeremy.Humanoid.Health <= 0 or _G.AutoZou == false then
										break
									end
								end
							else
								_tp(CFrame.new(2099.88159, 448.931, 648.997375))
							end
						elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
							while true do
								wait()
								_tp(CFrame.new(-1836, 11, 1714))

								if not _G.AutoZou then
									break
								elseif Root.Position == CFrame.new(-1836, 11, 1714).Position then
									break
								end
							end

							if Root.CFrame == CFrame.new(-1836, 11, 1714) then
								notween(CFrame.new(-1836, 11, 1714))
							end

							notween(CFrame.new(-1850.49329, 13.1789551, 1750.89685))
							wait(0.1)
							notween(CFrame.new(-1858.87305, 19.3777466, 1712.01807))
							wait(0.1)
							notween(CFrame.new(-1803.94324, 16.5789185, 1750.89685))
							wait(0.1)
							notween(CFrame.new(-1858.55835, 16.8604317, 1724.79541))
							wait(0.1)
							notween(CFrame.new(-1869.54224, 15.987854, 1681.00659))
							wait(0.1)
							notween(CFrame.new(-1800.0979, 16.4978027, 1684.52368))
							wait(0.1)
							notween(CFrame.new(-1819.26343, 14.795166, 1717.90625))
							wait(0.1)
							notween(CFrame.new(-1813.51843, 14.8604736, 1724.79541))
						end
					elseif string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
						local v750 = GetConnectionEnemies("Swan Pirate")

						if v750 then
							pcall(function()
								while true do
									wait()
									t9.Kill(v750, _G.AutoZou)

									if not v750.Parent then
										break
									elseif v750.Humanoid.Health <= 0 or _G.AutoZou == false or plr.PlayerGui.Main.Quest.Visible == false then
										break
									end
								end
							end)
						else
							_tp(CFrame.new(1057.92761, 137.614319, 1242.08069))
						end
					else
						_tp(CFrame.new(-456.28952, 73.0200958, 299.895966))
					end
				elseif replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
					if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
						TabelDevilFruitStore = {}
						TabelDevilFruitOpen = {}

						for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventoryFruits")) do
							for k, v2 in pairs(v1) do
								if k == "Name" then
									table.insert(TabelDevilFruitStore, v2)
								end
							end
						end

						local next_ = next
						local response, v757 = game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")

						for _, v1 in next_, response, v757 do
							if v1.Price >= 1000000 then
								table.insert(TabelDevilFruitOpen, v1.Name)
							end
						end

						for _, v1 in pairs(TabelDevilFruitOpen) do
							for _, v2 in pairs(TabelDevilFruitStore) do
								if v1 == v2 then
									if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
										if plr.Backpack:FindFirstChild(v2) then
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
											replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
										else
											replicated.Remotes.CommF_:InvokeServer("F_", "LoadFruit", v2)
										end
									end
								end
							end
						end

						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "1")
						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "2")
						replicated.Remotes.CommF_:InvokeServer("F_", "TalkTrevor", "3")
					end
				else
					replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")

					if replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
						local ripIndra = GetConnectionEnemies("rip_indra")

						if ripIndra then
							while true do
								wait()
								t9.Kill(ripIndra, _G.AutoZou)

								if not _G.AutoZou then
									break
								elseif not ripIndra.Parent or ripIndra.Humanoid.Health <= 0 then
									break
								end
							end

							Check = 2

							repeat
								wait()
								replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")
							until Check == 1
						else
							replicated.Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Check")
							wait(0.1)
							replicated.Remotes.CommF_:InvokeServer("F_", "ZQuestProgress", "Begin")
						end
					elseif replicated.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1 then
						replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")
					else
						local v765 = GetConnectionEnemies("Don Swan")

						if v765 then
							while true do
								wait()
								t9.Kill(v765, _G.AutoZou)

								if not _G.AutoZou then
									break
								elseif not v765.Parent or v765.Humanoid.Health <= 0 then
									break
								end
							end
						else
							while true do
								wait()
								_tp(CFrame.new(2288.802, 15.1870775, 863.034607))

								if not _G.AutoZou then
									break
								elseif Root.Position == CFrame.new(2288.802, 15.1870775, 863.034607).Position then
									break
								end
							end

							if Root.CFrame == CFrame.new(2288.802, 15.1870775, 863.034607) then
								notween(CFrame.new(2288.802, 15.1870775, 863.034607))
							end
						end
					end
				end
			end
		end)
	end
end)
GRP_Quests_Tushita_Yama = t15.Quests:AddLeftGroupbox("Tushita + Yama")

do
	Q = GRP_Quests_Tushita_Yama:AddToggle("Auto_Tushita_Sword", {
		Text = "Auto Tushita Sword",
		Default = false,
		Callback = function(p166)
			_G.Auto_Tushita = p166
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Tushita then
				if not workspace.Map.Turtle:FindFirstChild("TushitaGate") then
					local Longma = GetConnectionEnemies("Longma")

					if Longma then
						while true do
							task.wait()
							t9.Kill(Longma, _G.Auto_Tushita)

							if Longma.Humanoid.Health <= 0 then
								break
							elseif not _G.Auto_Tushita or not Longma.Parent then
								break
							end
						end
					elseif replicated:FindFirstChild("Longma") then
						_tp(replicated:FindFirstChild("Longma").HumanoidRootPart.CFrame * CFrame.new(0, 40, 0))
					end
				elseif GetBP("Holy Torch") then
					EquipWeapon("Holy Torch")
					task.wait(1)

					while true do
						task.wait()
						_tp(CFrame.new(-10752, 417, -9366))

						if not _G.Auto_Tushita then
							break
						elseif (CFrame.new(-10752, 417, -9366).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							break
						end
					end

					wait(0.7)

					while true do
						task.wait()
						_tp(CFrame.new(-11672, 334, -9474))

						if not _G.Auto_Tushita then
							break
						elseif (CFrame.new(-11672, 334, -9474).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							break
						end
					end

					wait(0.7)

					while true do
						task.wait()
						_tp(CFrame.new(-12132, 521, -10655))

						if not _G.Auto_Tushita then
							break
						elseif (CFrame.new(-12132, 521, -10655).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							break
						end
					end

					wait(0.7)

					while true do
						task.wait()
						_tp(CFrame.new(-13336, 486, -6985))

						if not _G.Auto_Tushita then
							break
						elseif (CFrame.new(-13336, 486, -6985).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							break
						end
					end

					wait(0.7)

					while true do
						task.wait()
						_tp(CFrame.new(-13489, 332, -7925))

						if not _G.Auto_Tushita then
							break
						elseif (CFrame.new(-13489, 332, -7925).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							break
						end
					end
				else
					_tp(CFrame.new(5148.03613, 162.352493, 910.548218))
					wait(0.7)
				end
			end
		end)
	end
end)
Q = GRP_Quests_Tushita_Yama:AddToggle("Auto_Yama_Sword", {
	Text = "Auto Yama Sword",
	Default = false,
	Callback = function(p167)
		_G.Auto_Yama = p167
		if not p167 and ZyroxYamaOwnsElite then
			ZyroxYamaOwnsElite = false
			_G.FarmEliteHunt = false
		end
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Yama then
				-- 30 Elites mortos liberam a Katana (o codigo antigo parava quando o progresso era exatamente 30)
				local progress = tonumber(replicated.Remotes.CommF_:InvokeServer("EliteHunter", "Progress")) or 0

				if progress < 30 then
					ZyroxYamaOwnsElite = true
					_G.FarmEliteHunt = true
				else
					if ZyroxYamaOwnsElite then
						ZyroxYamaOwnsElite = false
						_G.FarmEliteHunt = false
					end

					local katana = workspace.Map.Waterfall.SealedKatana.Handle

					if (katana.Position - plr.Character.HumanoidRootPart.Position).Magnitude >= 20 then
						_tp(katana.CFrame)
					else
						-- perto da katana: mata os Ghosts que aparecem e clica nela
						local Ghost = GetConnectionEnemies("Ghost")

						if Ghost then
							while true do
								wait()
								t9.Kill(Ghost, _G.Auto_Yama)

								if Ghost.Humanoid.Health <= 0 or not Ghost.Parent or not _G.Auto_Yama then
									break
								end
							end
						end

						fireclickdetector(katana.ClickDetector)
					end
				end
			end
		end)
	end
end)
GRP_Quests_Skull_Guitars_Misc = t15.Quests:AddLeftGroupbox("Skull Guitars / Misc")

do
	local v768 = GRP_Quests_Skull_Guitars_Misc:AddLabel("")

	spawn(function()
		while wait(0.2) do
			pcall(function()
				if Quest1 == true then
					v768:SetText("Quest Number : Quest1")
				elseif Quest2 == true then
					v768:SetText("Quest Number : Quest2")
				elseif Quest3 == true then
					v768:SetText("Quest Number : Quest3")
				elseif Quest4 == true then
					v768:SetText("Quest Number : Quest4")
				elseif GetWP("Skull Guitar") then
					v768:SetText("Quest Number : Collect!!")
				else
					v768:SetText("Quest Number : No Quest!!")
				end
			end)
		end
	end)
end

do
	GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Skull_Guitar", {
		Text = "Auto Skull Guitar",
		Default = false,
		Callback = function(p168)
			_G.Auto_Soul_Guitar = p168
		end
	})
end

do
	task.spawn(function()
		while wait() do
			if _G.Auto_Soul_Guitar then
				pcall(function()
					local v769 = GetConnectionEnemies("Living Zombie")

					if v769 then
						v769.HumanoidRootPart.CFrame = CFrame.new(-10138.3974609375, 138.6524658203125, 5902.89208984375)
						v769.Head.CanCollide = false
						v769.Humanoid.Sit = false
						v769.HumanoidRootPart.CanCollide = false
						v769.Humanoid.JumpPower = 0
						v769.Humanoid.WalkSpeed = 0

						if v769.Humanoid:FindFirstChild("Animator") then
							v769.Humanoid:FindFirstChild("Animator"):Destroy()
						end
					end
				end)
			end
		end
	end)
end

do
	getT = function(p169)
		local Rotation

		if p169 == 1 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment1.Line.Rotation
		elseif p169 == 3 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment3.Line.Rotation
		elseif p169 == 4 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment4.Line.Rotation
		elseif p169 == 7 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment7.Line.Rotation
		elseif p169 == 10 then
			Rotation = workspace.Map["Haunted Castle"].Tablet.Segment10.Line.Rotation
		end

		if Rotation then
			return Rotation.Z
		end
	end
end

getRT = function(p170)
	local Rotation

	for _, child in pairs(workspace.Map["Haunted Castle"].Trophies.Quest:GetChildren()) do
		if p170 == 1 and child.Name == "Trophy1" and child:FindFirstChild("Handle") then
			Rotation = child.Handle.Rotation
		elseif p170 == 2 and child.Name == "Trophy2" and child:FindFirstChild("Handle") then
			Rotation = child.Handle.Rotation
		elseif p170 == 3 and child.Name == "Trophy3" and child:FindFirstChild("Handle") then
			Rotation = child.Handle.Rotation
		elseif p170 == 4 and child.Name == "Trophy4" and child:FindFirstChild("Handle") then
			Rotation = child.Handle.Rotation
		elseif p170 == 5 and child.Name == "Trophy5" and child:FindFirstChild("Handle") then
			Rotation = child.Handle.Rotation
		end

		if Rotation then
			return Rotation.Z
		end
	end
end
GetFirePlacard = function(p171, p172)
	if tostring(workspace.Map["Haunted Castle"]["Placard" .. p171][p172].Indicator.BrickColor) ~= "Pearl" then
		fireclickdetector(workspace.Map["Haunted Castle"]["Placard" .. p171][p172].ClickDetector)
	end
end

do
	spawn(function()
		repeat
			task.wait()
		until _G.Auto_Soul_Guitar

		while wait(Sec) do
			pcall(function()
				if _G.Auto_Soul_Guitar and World3 then
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
					replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)

					if replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check") == nil then
						_tp(CFrame.new(-8655.0166015625, 141.31669616699219, 6160.0224609375))
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2)
						replicated.Remotes.CommF_:InvokeServer("gravestoneEvent", 2, true)
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Swamp == false then
						Quest1 = true
						Quest2 = false
						Quest3 = false
						Quest4 = false

						local v774 = GetConnectionEnemies("Living Zombie")

						if v774 then
							while true do
								task.wait()
								t9.Kill(v774, _G.Auto_Soul_Guitar)

								if not _G.Auto_Soul_Guitar then
									break
								elseif v774.Humanoid.Health <= 0 or not v774.Parent or workspace.Map["Haunted Castle"].SwampWater.Color ~= Color3.fromRGB(117, 0, 0) then
									break
								end
							end
						else
							_tp(CFrame.new(-10170.7275390625, 138.6524658203125, 5934.26513671875))
						end
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Gravestones == false then
						Quest1 = false
						Quest2 = true
						Quest3 = false
						Quest4 = false
						GetFirePlacard("7", "Left")
						GetFirePlacard("6", "Left")
						GetFirePlacard("5", "Left")
						GetFirePlacard("4", "Right")
						GetFirePlacard("3", "Left")
						GetFirePlacard("2", "Right")
						GetFirePlacard("1", "Right")
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Ghost == false then
						replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost")
						replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Ghost", true)
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Trophies == false then
						Quest1 = false
						Quest2 = false
						Quest3 = true
						Quest4 = false
						_tp(CFrame.new(-9532.8232421875, 6.4716677665710449, 6078.068359375))

						local v775, v776

						repeat
							wait()
							v776 = getRT(1)
							v775 = getT(1)

							if v776 and v775 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment1:FindFirstChild("ClickDetector"))
							end
						until v776 == v775

						local v777, v778

						repeat
							wait()
							v778 = getRT(2)
							v777 = getT(3)

							if v778 and v777 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment3:FindFirstChild("ClickDetector"))
							end
						until v778 == v777

						local v779, v780

						repeat
							wait()
							v780 = getRT(3)
							v779 = getT(4)

							if v780 and v779 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment4:FindFirstChild("ClickDetector"))
							end
						until v780 == v779

						local v781, v782

						repeat
							wait()
							v782 = getRT(4)
							v781 = getT(7)

							if v782 and v781 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment7:FindFirstChild("ClickDetector"))
							end
						until v782 == v781

						local v783, v784

						repeat
							wait()
							v784 = getRT(5)
							v783 = getT(10)

							if v784 and v783 then
								fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment10:FindFirstChild("ClickDetector"))
							end
						until v784 == v783

						while true do
							wait()
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment2:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment5:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment6:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment8:FindFirstChild("ClickDetector"))
							fireclickdetector(workspace.Map["Haunted Castle"].Tablet.Segment9:FindFirstChild("ClickDetector"))

							if workspace.Map["Haunted Castle"].Tablet.Segment2.Line.Rotation.Z == 0 then
								break
							elseif workspace.Map["Haunted Castle"].Tablet.Segment5.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment6.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment8.Line.Rotation.Z == 0 or workspace.Map["Haunted Castle"].Tablet.Segment9.Line.Rotation.Z == 0 then
								break
							end
						end
					elseif replicated.Remotes.CommF_:InvokeServer("GuitarPuzzleProgress", "Check").Pipes == false then
						Quest1 = false
						Quest2 = false
						Quest3 = false
						Quest4 = true
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part3.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part4.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part6.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part8.ClickDetector)
						_tp(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.CFrame)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
						fireclickdetector(workspace.Map["Haunted Castle"]["Lab Puzzle"].ColorFloor.Model.Part10.ClickDetector)
					end
				end
			end)
		end
	end)
end

do
	GRP_Quests_Skull_Guitars_Misc:AddToggle("Auto_Farm_Material_Skull_Guitar", {
		Text = "Auto Farm Material Skull Guitar",
		Default = false,
		Callback = function(p173)
			_G.AutoMatSoul = p173
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AutoMatSoul and GetWP("Skull Guitar") == false then
					if GetM("Bones") >= 500 and GetM("Ectoplasm") >= 250 and GetM("Dark Fragment") >= 1 then
						replicated.Remotes.CommF_:InvokeServer("soulGuitarBuy", true)
					elseif GetM("Ectoplasm") <= 250 then
						if _G.AutoMatSoul and World2 then
							local v785 = GetConnectionEnemies({
								"Ship Deckhand",
								"Ship Engineer",
								"Ship Steward",
								"Ship Officer",
								"Arctic Warrior"
							})

							if v785 then
								while true do
									task.wait()
									t9.Kill(v785, _G.AutoMatSoul)

									if not _G.AutoMatSoul then
										break
									elseif not v785.Parent or v785.Humanoid.Health <= 0 then
										break
									end
								end
							else
								replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					elseif GetM("Dark Fragment") < 1 then
						if _G.AutoMatSoul and World2 then
							local Darkbeard = GetConnectionEnemies("Darkbeard")

							if Darkbeard then
								while true do
									task.wait()
									t9.Kill(Darkbeard, _G.AutoMatSoul)

									if _G.AutoMatSoul then
										break
									elseif Darkbeard.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end

						if not GetConnectionEnemies("Darkbeard") then
							Hop()
						end
					elseif GetM("Bones") <= 500 then
						if _G.AutoMatSoul and World3 then
							local v787 = GetConnectionEnemies({
								"Reborn Skeleton",
								"Living Zombie",
								"Demonic Soul",
								"Posessed Mummy"
							})

							if v787 then
								while true do
									task.wait()
									t9.Kill(v787, _G.AutoMatSoul)

									if not _G.AutoMatSoul then
										break
									elseif v787.Humanoid.Health <= 0 or not v787.Parent or v787.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(-9504.8564453125, 172.14292907714844, 6057.259765625))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelZou")
						end
					end
				end
			end)
		end
	end)
end

GRP_Quests_Cursed_Dual_Katana = t15.Quests:AddLeftGroupbox("Cursed Dual Katana")

do
	local v788 = GRP_Quests_Cursed_Dual_Katana:AddLabel("Quest Numbers :")

	spawn(function()
		while wait(0.2) do
			if QuestYama_1 == true then
				v788:SetText("Quest Numbers : yama quest 1")
			elseif QuestYama_2 == true then
				v788:SetText("Quest Numbers : yama quest 2")
			elseif QuestYama_3 == true then
				v788:SetText("Quest Numbers : yama quest 3")
			elseif QuestTushita_1 == true then
				v788:SetText("Quest Numbers : tushita quest 1")
			elseif QuestTushita_2 == true then
				v788:SetText("Quest Numbers : tushita quest 2")
			elseif GetWP("Cursed Dual Katana") then
				v788:SetText("Quest Numbers : CDK done!!")
			end
		end
	end)
end

Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Get_CDK_[_Last_Quest_]", {
	Text = "Auto Get CDK [ Last Quest ]",
	Default = false,
	Callback = function(p174)
		_G.CDK = p174
	end
})

-- Auto CDK completo (Yama/Tushita trials + pedestal) — usa os loops CDK_TS / CDK_YM ja existentes
Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_CDK", {
	Text = "Auto CDK",
	Default = false,
	Callback = function(v)
		_G.Auto_CDK = v
		if not v then
			_G.CDK_TS = false
			_G.CDK_YM = false
			_G.CDK = false
		end
	end
})
spawn(function()
	local function hasItem(name)
		if GetWP and GetWP(name) then
			return true
		end
		local bp, ch = plr.Backpack, plr.Character
		return (bp and bp:FindFirstChild(name)) or (ch and ch:FindFirstChild(name))
	end

	local function progress()
		local ok, p = pcall(function()
			return replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress")
		end)
		if ok and type(p) == "table" then
			return tonumber(p.Good) or 0, tonumber(p.Evil) or 0, p.Finished
		end
		return 0, 0, nil
	end

	local function openDoor()
		pcall(function()
			local s = replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
			if tostring(s) ~= "opened" then
				replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
			end
		end)
	end

	while task.wait(0.5) do
		pcall(function()
			if not _G.Auto_CDK then
				return
			end
			if not hasItem("Yama") or not hasItem("Tushita") then
				pcall(function()
					lib:Notify({ Title = "CDK", Description = "Precisa de Yama e Tushita", Duration = 4 })
				end)
				task.wait(4)
				return
			end

			openDoor()
			local good, evil, finished = progress()

			-- trials Good (Tushita)
			if good ~= 4 and good ~= -2 then
				pcall(function()
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
				end)
				_G.CDK_TS = true
				_G.CDK_YM = false
				_G.CDK = false
				return
			end

			-- trials Evil (Yama)
			if evil ~= 4 and evil ~= -2 then
				pcall(function()
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
				end)
				_G.CDK_YM = true
				_G.CDK_TS = false
				_G.CDK = false
				return
			end

			-- ambos em 4: pedestal / boss final
			_G.CDK_TS = false
			_G.CDK_YM = false
			_G.CDK = true

			-- pedestais
			local cursed = workspace:FindFirstChild("Map") and workspace.Map:FindFirstChild("Turtle") and workspace.Map.Turtle:FindFirstChild("Cursed")
			if cursed then
				local which = nil
				if good == 4 and evil == 3 then
					which = "Pedestal2"
				elseif good == 3 and evil == 4 then
					which = "Pedestal1"
				elseif good == 4 and evil == 4 then
					which = "Pedestal3"
				end
				if which and cursed:FindFirstChild(which) then
					local ped = cursed[which]
					if (plr.Character.HumanoidRootPart.Position - ped.Position).Magnitude > 12 then
						_tp(ped.CFrame)
					else
						pcall(function()
							if ped:FindFirstChild("ProximityPrompt") then
								fireproximityprompt(ped.ProximityPrompt)
							end
						end)
					end
				end
			end
		end)
	end
end)

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.CDK then
				replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Good")
				replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress", "Evil")
				replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Boss")

				local v789 = GetConnectionEnemies("Cursed Skeleton Boss")

				if v789 then
					repeat
						wait()

						if plr.Character:FindFirstChild("Yama") then
							EquipWeapon("Yama")
						else
							if plr.Backpack:FindFirstChild("Yama") then
								EquipWeapon("Yama")
								_tp(v789.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

								if not _G.CDK or not v789.Parent or v789.Humanoid.Health <= 0 then
									break
								end
							end

							if plr.Character:FindFirstChild("Tushita") then
								EquipWeapon("Tushita")
							elseif plr.Backpack:FindFirstChild("Tushita") then
								EquipWeapon("Tushita")
								_tp(v789.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))

								if not _G.CDK or not v789.Parent or v789.Humanoid.Health <= 0 then
									break
								end
							end
						end

						_tp(v789.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
					until not _G.CDK or not v789.Parent or v789.Humanoid.Health <= 0
				else
					_tp(CFrame.new(-12318.193359375, 601.95184326171875, -6538.662109375))
					wait(0.5)
					_tp(workspace.Map.Turtle.Cursed.BossDoor.CFrame)
				end
			end
		end)
	end
end)
Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Yama_CDK", {
	Text = "Auto Yama CDK",
	Default = false,
	Callback = function(p175)
		_G.CDK_YM = p175
	end
})

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.CDK_YM then
					if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
					elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
						replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Evil")
					elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == false then
						if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -3 then
							QuestYama_1 = true
							QuestYama_2 = false
							QuestYama_3 = false

							repeat
								task.wait()

								if workspace.Enemies:FindFirstChild("Forest Pirate") then
									if GetConnectionEnemies("Forest Pirate") then
										_tp(workspace.Enemies:FindFirstChild("Forest Pirate").HumanoidRootPart.CFrame)
									end
								else
									_tp(CFrame.new(-13223.521484375, 428.19381713867188, -7766.06787109375))
								end
							until not (tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 1 and _G.CDK_YM)
						elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -4 then
							QuestYama_1 = false
							QuestYama_2 = true
							QuestYama_3 = false

							for _, child in pairs(game:GetService("Players").LocalPlayer.QuestHaze:GetChildren()) do
								for k, v1 in pairs(t7) do
									if string.find(k, child.Name) and child.Value > 0 then
										if (v1.Position - Root.Position).Magnitude <= 1000 then
											if workspace.Enemies:FindFirstChild(k) then
												for _, child2 in pairs(workspace.Enemies:GetChildren()) do
													if child2:FindFirstChild("HumanoidRootPart") and child2:FindFirstChild("Humanoid") and child2:FindFirstChild("Humanoid").Health > 0 and child2:FindFirstChild("HazeESP") then
														while true do
															wait()
															t9.Kill(child2, _G.CDK_YM)

															if not _G.CDK_YM then
																break
															elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 2 or not child2:FindFirstChild("HazeESP") or child2.Humanoid.Health <= 0 then
																break
															end
														end
													end
												end

												continue
											end
										end

										_tp(v1)
									end
								end
							end
						elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == -5 then
							QuestYama_1 = false
							QuestYama_2 = false
							QuestYama_3 = true

							if workspace.Map:FindFirstChild("HellDimension") and (Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000 then
								for k in pairs(workspace.Map.HellDimension.Exit:GetChildren()) do
									if tonumber(k) == 2 then
										while true do
											task.wait()
											Root.CFrame = workspace.Map.HellDimension.Exit.CFrame

											if not _G.CDK_YM then
												break
											elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
												break
											end
										end
									end
								end

								EquipWeapon(_G.SelectWeapon)

								if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
									while true do
										task.wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch1.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch1.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T1Yama = true

										if _G.CDK_YM and not _G.T1Yama then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
												continue
											end
										end

										break
									end

									repeat
										task.wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch2.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch2.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T2Yama = true

										if _G.T2Yama or _G.CDK_YM == false then
											break
										end
									until tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3

									while true do
										wait()

										repeat
											task.wait()
											_tp(workspace.Map.HellDimension.Torch3.Particles.CFrame)

											for _, descendant in pairs(workspace.Map.HellDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (workspace.Map.HellDimension.Torch3.Particles.Position - Root.Position).Magnitude < 5

										wait(2)
										_G.T3Yama = true

										if not (_G.T3Yama or _G.CDK_YM == false) then
											if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
												continue
											end
										end

										break
									end
								end

								for _, child in pairs(workspace.Enemies:GetChildren()) do
									if (child:FindFirstChild("HumanoidRootPart").Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 300 and child:FindFirstChild("HumanoidRootPart") then
										if child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
											while true do
												task.wait()
												t9.Kill(child, _G.CDK_YM)

												if not _G.CDK_YM or child.Humanoid.Health <= 0 or not child.Parent then
													break
												elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) == 3 then
													break
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end)
		end
	end)
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.CDK_YM then
				if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= -5 then
					return
				end

				if workspace.Map:FindFirstChild("HellDimension") and not ((Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude > 1000) then
					return
				end

				local v805 = GetConnectionEnemies("Soul Reaper")

				if v805 then
					while true do
						task.wait()
						_tp(v805.HumanoidRootPart.CFrame)

						if v805.Humanoid.Health <= 0 or not _G.CDK_YM or not v805.Parent then
							break
						end

						if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Evil) ~= 3 then
							if not workspace.Map:FindFirstChild("HellDimension") or not ((Root.Position - workspace.Map.HellDimension.Spawn.Position).Magnitude <= 1000) then
								continue
							end
						end

						break
					end

					return
				end

				if plr.Backpack:FindFirstChild("Hallow Essence") then
					repeat
						_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
						task.wait()
					until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - Root.Position).Magnitude <= 8

					EquipWeapon("Hallow Essence")
				else
					if plr.Character:FindFirstChild("Hallow Essence") then
						repeat
							_tp(CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125))
							task.wait()
						until (CFrame.new(-8932.322265625, 146.83154296875, 6062.55078125).Position - Root.Position).Magnitude <= 8

						EquipWeapon("Hallow Essence")

						return
					end

					local ok4 = not replicated:FindFirstChild("Soul Reaper")

					if not ok4 then
						ok4 = not (replicated:FindFirstChild("Soul Reaper").Humanoid.Health > 0)
					end

					if not ok4 then
						_tp(replicated:FindFirstChild("Soul Reaper").HumanoidRootPart.CFrame)

						return
					end

					if not (replicated.Remotes.CommF_:InvokeServer("Bones", "Check") < 50) then
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						return
					end

					if workspace.Enemies:FindFirstChild("Soul Reaper") then
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						return
					end

					if replicated:FindFirstChild("Soul Reaper") then
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						return
					end

					if workspace.Map:FindFirstChild("HellDimension") then
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)

						return
					end

					local ok = workspace.Enemies:FindFirstChild("Reborn Skeleton")

					if not ok then
						ok = workspace.Enemies:FindFirstChild("Living Zombie")
					end

					local ok2 = ok

					if not ok2 then
						ok2 = workspace.Enemies:FindFirstChild("Domenic Soul")
					end

					local ok3 = ok2

					if not ok3 then
						ok3 = workspace.Enemies:FindFirstChild("Posessed Mummy")
					end

					if ok3 then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if (child.Name == "Reborn Skeleton" or child.Name == "Living Zombie" or child.Name == "Demonic Soul" or child.Name == "Posessed Mummy") and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
								while true do
									task.wait()
									t9.Kill(child, _G.CDK_YM)

									if not _G.CDK_YM then
										break
									elseif child.Humanoid.Health <= 0 or not child.Parent then
										break
									end
								end
							end
						end
					else
						_tp(CFrame.new(-9515.2255859375, 164.0062255859375, 5785.38330078125))
					end
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Cursed_Dual_Katana:AddToggle("Auto_Tushita_CDK", {
		Text = "Auto Tushita CDK",
		Default = false,
		Callback = function(p176)
			_G.CDK_TS = p176
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.CDK_TS then
				if tostring(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")) ~= "opened" then
					wait(0.7)
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor")
					wait(0.3)
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "OpenDoor", true)
				elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == nil then
					replicated.Remotes.CommF_:InvokeServer("CDKQuest", "StartTrial", "Good")
				elseif replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Finished == false then
					if tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -3 then
						QuestTushita_1 = true
						QuestTushita_2 = false
						QuestTushita_3 = false

						while true do
							wait()
							_tp(CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875))

							if (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS then
								break
							elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
								break
							end
						end

						if (CFrame.new(-4602.5107421875, 16.446542739868164, -2880.998046875).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)

						while true do
							wait()
							_tp(CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125))

							if (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS then
								break
							elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
								break
							end
						end

						if (CFrame.new(4001.185302734375, 10.089399337768555, -2654.86328125).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)

						while true do
							wait()
							_tp(CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625))

							if (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 3 or not _G.CDK_TS then
								break
							elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 1 then
								break
							end
						end

						if (CFrame.new(-9530.763671875, 7.245208740234375, -8375.5087890625).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							wait(0.7)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"), "Check")
							wait(0.5)
							replicated.Remotes.CommF_:InvokeServer("CDKQuest", "BoatQuest", workspace.NPCs:FindFirstChild("Luxury Boat Dealer"))
						end

						wait(1)
					elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -4 then
						QuestTushita_1 = false
						QuestTushita_2 = true
						QuestTushita_3 = false

						while true do
							wait()
							_G.AutoRaidCastle = true

							if not _G.CDK_TS then
								break
							elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 2 then
								break
							end
						end

						_G.AutoRaidCastle = false
					elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == -5 then
						QuestTushita_1 = false
						QuestTushita_2 = false
						QuestTushita_3 = true

						if workspace.Enemies:FindFirstChild("Cake Queen") then
							for _, child in pairs(workspace.Enemies:GetChildren()) do
								if child.Name == "Cake Queen" then
									if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and child.Humanoid.Health > 0 then
										while true do
											wait()
											t9.Kill(child, _G.CDK_TS)

											if not _G.CDK_TS or not child.Parent or child.Humanoid.Health <= 0 then
												break
											elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3 then
												break
											end
										end
									end
								end
							end
						else
							local ok = not replicated:FindFirstChild("Cake Queen")

							if not ok then
								ok = not (replicated:FindFirstChild("Cake Queen").Humanoid.Health > 0)
							end

							if ok then
								if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - workspace.Map.HeavenlyDimension.Spawn.Position).Magnitude <= 1000 then
									for k in pairs(workspace.Map.HeavenlyDimension.Exit:GetChildren()) do
										Ex = k
									end

									if Ex == 2 then
										while true do
											wait()
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Map.HeavenlyDimension.Exit.CFrame

											if not _G.CDK_TS then
												break
											elseif tonumber(replicated.Remotes.CommF_:InvokeServer("CDKQuest", "Progress").Good) == 3 then
												break
											end
										end
									end

									repeat
										wait()

										repeat
											wait()
											_tp(CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22529.6171875, 5275.77392578125, 3873.5712890625).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT1 = true
									until not _G.CDK_TS or _G.DoneT1

									repeat
										wait()

										repeat
											wait()
											_tp(CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22637.291015625, 5281.365234375, 3749.28857421875).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT2 = true
									until _G.DoneT2 or _G.CDK_TS == false

									repeat
										wait()

										repeat
											task.wait()
											_tp(CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375))

											for _, descendant in pairs(workspace.Map.HeavenlyDimension:GetDescendants()) do
												if descendant:IsA("ProximityPrompt") then
													fireproximityprompt(descendant)
												end
											end
										until (CFrame.new(-22791.14453125, 5277.16552734375, 3764.570068359375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 5

										wait(2)
										_G.DoneT3 = true
									until _G.DoneT3 or _G.CDK_TS == false

									for _, child in pairs(workspace.Enemies:GetChildren()) do
										if (child:FindFirstChild("HumanoidRootPart").Position - CFrame.new(-22695.7012, 5270.93652, 3814.42847, 0.11794927, 3.32185834e-08, 0.99301964, -8.73070718e-08, 1, -2.30819008e-08, -0.99301964, -8.3975138e-08, 0.11794927).Position).Magnitude <= 300 and child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Humanoid") and child:FindFirstChild("Humanoid").Health > 0 then
											while true do
												wait()
												t9.Kill(child, _G.CDK_TS)

												if not _G.CDK_TS then
													break
												elseif child.Humanoid.Health <= 0 or not child.Parent then
													break
												end
											end
										end
									end
								end
							else
								_tp(replicated:FindFirstChild("Cake Queen").HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							end
						end
					end
				end
			end
		end)
	end
end)
GRP_Quests_True_Triple_Katana_Sword = t15.Quests:AddLeftGroupbox("True Triple Katana Sword")

do
	GRP_Quests_True_Triple_Katana_Sword:AddButton({
		Text = "Buy Legendary Sword",
		Func = function()
			for i = 1, 3 do
				replicated.Remotes.CommF_:InvokeServer("LegendarySwordDealer", tostring(i))
				task.wait(0.3)
			end
		end
	})
end

do
	GRP_Quests_True_Triple_Katana_Sword:AddButton({
		Text = "Buy True Triple Katana Sword",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("MysteriousMan", "2")
		end
	})
end

-- Auto TTK (Banana/Vxeze): mastery 300 em Oroshi / Saishi / Shizu, depois compra TTK
Q = GRP_Quests_True_Triple_Katana_Sword:AddToggle("Auto_TTK", {
	Text = "Auto TTK",
	Default = false,
	Callback = function(v)
		_G.Auto_TTK = v
	end
})
spawn(function()
	local swords = { "Oroshi", "Saishi", "Shizu" }
	local farmMobs = {
		"Pirate Raider",
		"Vampire",
		"Reborn Skeleton",
		"Living Zombie",
		"Demonic Soul",
		"Posessed Mummy",
		"Marine Commodore",
		"Forest Pirate",
	}

	local function invMastery(name)
		local ok, inv = pcall(function()
			return replicated.Remotes.CommF_:InvokeServer("getInventory")
		end)
		if not ok or type(inv) ~= "table" then
			return 0, false
		end
		for _, it in pairs(inv) do
			if it and it.Name == name then
				return tonumber(it.Mastery) or 0, true
			end
		end
		return 0, false
	end

	local function hasTTK()
		return GetWP and GetWP("True Triple Katana")
			or (plr.Backpack:FindFirstChild("True Triple Katana") or plr.Character and plr.Character:FindFirstChild("True Triple Katana"))
	end

	local function loadSword(name)
		pcall(function()
			replicated.Remotes.CommF_:InvokeServer("LoadItem", name)
		end)
		task.wait(0.35)
		pcall(function()
			EquipWeapon(name)
		end)
	end

	while task.wait(0.35) do
		pcall(function()
			if not _G.Auto_TTK then
				return
			end
			if hasTTK() then
				_G.Auto_TTK = false
				pcall(function()
					lib:Notify({ Title = "TTK", Description = "True Triple Katana pronta", Duration = 5 })
				end)
				return
			end

			local need = nil
			for _, s in ipairs(swords) do
				local m, owned = invMastery(s)
				if not owned then
					-- tenta puxar do inventario / dealer path
					loadSword(s)
					m, owned = invMastery(s)
				end
				if owned and m < 300 then
					need = s
					break
				end
			end

			if not need then
				-- as tres com 300+: compra
				pcall(function()
					replicated.Remotes.CommF_:InvokeServer("MysteriousMan", "2")
				end)
				task.wait(1)
				pcall(function()
					replicated.Remotes.CommF_:InvokeServer("LoadItem", "True Triple Katana")
				end)
				return
			end

			loadSword(need)
			local mob = nil
			for _, name in ipairs(farmMobs) do
				mob = GetConnectionEnemies(name)
				if mob then
					break
				end
			end
			if mob and mob:FindFirstChild("HumanoidRootPart") then
				t9.Kill(mob, _G.Auto_TTK)
			else
				-- ponto generico sea2/3 farm
				if sea2 then
					_tp(CFrame.new(-950, 13, 3000))
				elseif sea3 then
					_tp(CFrame.new(-9500, 15, 5500))
				end
			end
		end)
	end
end)


Q = GRP_Quests_True_Triple_Katana_Sword:AddToggle("Tween_to_Legendary_Sword_Dealer", {
	Text = "Tween to Legendary Sword Dealer",
	Default = false,
	Callback = function(p177)
		_G.Tp_LgS = p177
	end
})
spawn(function()
	while wait(Sec) do
		if _G.Tp_LgS then
			pcall(function()
				for _, child in pairs(replicated.NPCs:GetChildren()) do
					if child.Name == "Legendary Sword Dealer " then
						_tp(child.HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)
GRP_Quests_Pole_God_Enal_s = t15.Quests:AddLeftGroupbox("Pole / God Enal's")
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Pole_V1", {
	Text = "Auto Pole V1",
	Default = false,
	Callback = function(p178)
		_G.AutoPole = p178
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoPole then
			pcall(function()
				local v827 = GetConnectionEnemies("Thunder God")

				if v827 then
					while true do
						task.wait()
						t9.Kill(v827, _G.AutoPole)

						if not _G.AutoPole then
							break
						elseif not v827.Parent or v827.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188))
				end
			end)
		end
	end
end)
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Pole_V2_[Beta]", {
	Text = "Auto Pole V2 [Beta]",
	Default = false,
	Callback = function(p179)
		_G.AutoPoleV2 = p179
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoPoleV2 then
				if not GetBP("Pole (1st Form)") then
					replicated.Remotes.CommF_:InvokeServer("LoadItem", "Pole (1st Form)")
				end

				if not GetBP("Pole (2nd Form)") then
					replicated.Remotes.CommF_:InvokeServer("LoadItem", "Pole (2nd Form)")
				end

				if GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value <= 179 then
					_G.Level = true
				elseif GetBP("Pole (1st Form)") and GetBP("Pole (1st Form)").Level.Value >= 180 then
					_G.Level = false
				end

				if not GetBP("Rumble Fruit") then
					return
				end

				local ok2 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("Z")

				if not ok2 then
					ok2 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("X")
				end

				local ok3 = ok2

				if not ok3 then
					ok3 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("C")
				end

				local ok4 = ok3

				if not ok4 then
					ok4 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("V")
				end

				local ok5 = ok4

				if not ok5 then
					ok5 = not GetBP("Rumble Fruit").AwakenedMoves:FindFirstChild("F")
				end

				if ok5 then
					local ok = replicated.Remotes.CommF_:InvokeServer("Awakener", "Check") == nil

					if not ok then
						ok = replicated.Remotes.CommF_:InvokeServer("Awakener", "Check") == 0
					end

					if ok then
						_G.SelectChip = "Rumble"

						local response = replicated.Remotes.CommF_:InvokeServer("RaidsNpc", "Select", _G.SelectChip)

						if response then
							response:Stop()
						end

						_G.Raiding = true
						_G.Auto_Awakener = true
					end
				else
					_G.SelectChip = nil
					_G.Raiding = false
					_G.Auto_Awakener = false

					if plr.Data.Fragments.Value >= 5000 then
						replicated.Remotes.CommF_:InvokeServer("Thunder God", "Talk")
						wait(Sec)
						replicated.Remotes.CommF_:InvokeServer("Thunder God", "Sure")
					end
				end
			end
		end)
	end
end)

do
	GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Saw_Sword", {
		Text = "Auto Saw Sword",
		Default = false,
		Callback = function(p180)
			_G.AutoSaw = p180
		end
	})
end

spawn(function()
	while wait(0.2) do
		pcall(function()
			if _G.AutoSaw then
				local v834 = GetConnectionEnemies("The Saw")

				if v834 then
					while true do
						task.wait()
						t9.Kill(v834, _G.AutoSaw)

						if _G.AutoSaw == false then
							break
						elseif v834.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906))
				end
			end
		end)
	end
end)
Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Saber_Sword", {
	Text = "Auto Saber Sword",
	Default = false,
	Callback = function(p181)
		_G.AutoSaber = p181
	end
})

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.AutoSaber and plr.Data.Level.Value >= 200 then
					if not plr.Backpack:FindFirstChild("Saber") then
						if not plr.Character:FindFirstChild("Saber") then
							if workspace.Map.Jungle.Final.Part.Transparency ~= 0 then
								local ok = workspace.Enemies:FindFirstChild("Saber Expert")

								if not ok then
									ok = replicated:FindFirstChild("Saber Expert")
								end

								if ok then
									for _, child in pairs(workspace.Enemies:GetChildren()) do
										if child.Name == "Saber Expert" and t9.Alive(child) then
											while true do
												task.wait()
												t9.Kill(child, _G.AutoSaber)

												if child.Humanoid.Health <= 0 then
													break
												elseif _G.AutoSaber == false then
													break
												end
											end

											if child.Humanoid.Health <= 0 then
												replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
											end
										end
									end
								else
									_tp(CFrame.new(-1401.85046, 29.9773273, 8.81916237, 0.85820812, 8.76083845e-08, 0.513301849, -8.55007443e-08, 1, -2.77243419e-08, -0.513301849, -2.00944328e-08, 0.85820812))
								end
							elseif workspace.Map.Jungle.QuestPlates.Door.Transparency ~= 0 then
								if workspace.Map.Desert.Burn.Part.Transparency ~= 0 then
									if replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "GetCup")
										wait(0.5)
										EquipWeapon("Cup")
										wait(0.5)
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "FillCup", plr.Character.Cup)
										wait(Sec)
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "SickMan")
									elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == nil then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
									elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 0 then
										local ok2 = workspace.Enemies:FindFirstChild("Mob Leader")

										if not ok2 then
											ok2 = replicated:FindFirstChild("Mob Leader")
										end

										if ok2 then
											_tp(CFrame.new(-2967.59521, -4.91089821, 5328.70703, 0.342208564, -0.0227849055, 0.939347804, 0.0251603816, 0.999569714, 0.0150796166, -0.939287126, 0.0184739735, 0.342634559))

											for _, child in pairs(workspace.Enemies:GetChildren()) do
												if child.Name == "Mob Leader" and t9.Alive(child) then
													while true do
														task.wait()
														t9.Kill(child, _G.AutoSaber)

														if child.Humanoid.Health <= 0 then
															break
														elseif _G.AutoSaber == false then
															break
														end
													end
												end
											end
										end
									elseif replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon") == 1 then
										replicated.Remotes.CommF_:InvokeServer("ProQuestProgress", "RichSon")
										EquipWeapon("Relic")
										_tp(CFrame.new(-1404.91504, 29.9773273, 3.80598116, 0.876514494, 5.66906877e-09, 0.481375456, 2.53851997e-08, 1, -5.79995607e-08, -0.481375456, 6.30572643e-08, 0.876514494))
									end
								elseif plr.Backpack:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0)
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1)
									_tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))
								elseif plr.Character:FindFirstChild("Torch") then
									EquipWeapon("Torch")
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 0)
									firetouchinterest(plr.Character.Torch.Handle, workspace.Map.Desert.Burn.Fire, 1)
									_tp(CFrame.new(1114.61475, 5.04679728, 4350.22803, -0.648466587, -1.28799094e-09, 0.761243105, -5.70652914e-10, 1, 1.20584542e-09, -0.761243105, 3.47544882e-10, -0.648466587))

									return
								else
									_tp(CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408))
								end
							elseif (CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 100 then
								_tp(plr.Character.HumanoidRootPart.CFrame)
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate1.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate2.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate3.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate4.Button.CFrame
								wait(0.5)
								plr.Character.HumanoidRootPart.CFrame = workspace.Map.Jungle.QuestPlates.Plate5.Button.CFrame
								wait(0.5)
							else
								_tp(CFrame.new(-1612.55884, 36.9774132, 148.719543, 0.37091279, 3.0717151e-09, -0.928667724, 3.97099491e-08, 1, 1.91679348e-08, 0.928667724, -4.39869794e-08, 0.37091279))
							end
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Cybrog", {
	Text = "Auto Cybrog",
	Default = false,
	Callback = function(p182)
		_G.AutoColShad = p182
	end
})

do
	spawn(function()
		while wait(0.2) do
			if _G.AutoColShad then
				pcall(function()
					local Cyborg = GetConnectionEnemies("Cyborg")

					if Cyborg then
						while true do
							task.wait()
							t9.Kill(Cyborg, _G.AutoColShad)

							if _G.AutoColShad == false then
								break
							elseif not Cyborg.Parent or Cyborg.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813))
					end
				end)
			end
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Usoap's_Hat", {
	Text = "Auto Usoap's Hat",
	Default = false,
	Callback = function(p183)
		_G.AutoGetUsoap = p183
	end
})

do
	spawn(function()
		while task.wait(Sec) do
			pcall(function()
				if _G.AutoGetUsoap then
					for _, child in pairs(workspace.Characters:GetChildren()) do
						if child.Name ~= plr.Name and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") and child.Parent and (Root.Position - child.HumanoidRootPart.Position).Magnitude <= 230 then
							while true do
								task.wait()
								EquipWeapon(_G.SelectWeapon)
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(1, 1, 2))

								if _G.AutoGetUsoap == false then
									break
								elseif child.Humanoid.Health <= 0 or not child.Parent or not child:FindFirstChild("HumanoidRootPart") or not child:FindFirstChild("Humanoid") then
									break
								end
							end
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Bisento_V2", {
	Text = "Auto Bisento V2",
	Default = false,
	Callback = function(p184)
		_G.Greybeard = p184
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.Greybeard then
				pcall(function()
					if GetWP("Bisento") then
						if GetWP("Bisento") then
							replicated.Remotes.CommF_:InvokeServer("LoadItem", "Bisento")

							local Greybeard = GetConnectionEnemies("Greybeard")

							if Greybeard then
								while true do
									wait()
									t9.Kill(Greybeard, _G.Greybeard)

									if _G.Greybeard == false then
										break
									elseif not Greybeard.Parent or Greybeard.Humanoid.Health <= 0 then
										break
									end
								end
							else
								_tp(CFrame.new(-5023.38330078125, 28.652032852172852, 4332.3818359375))
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Warden_Sword", {
		Text = "Auto Warden Sword",
		Default = false,
		Callback = function(p185)
			_G.WardenBoss = p185
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.WardenBoss then
				pcall(function()
					local v845 = GetConnectionEnemies("Chief Warden")

					if v845 then
						while true do
							wait()
							t9.Kill(v845, _G.WardenBoss)

							if _G.WardenBoss == false then
								break
							elseif not v845.Parent or v845.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, -0.00062915677, 0.939684749, 0.00191645394, 0.999998152, -2.80422337e-05, -0.939682961, 0.00181045406, 0.342041939))
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Marine_Coat", {
		Text = "Auto Marine Coat",
		Default = false,
		Callback = function(p186)
			_G.MarinesCoat = p186
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.MarinesCoat then
				pcall(function()
					local v846 = GetConnectionEnemies("Vice Admiral")

					if v846 then
						while true do
							wait()
							t9.Kill(v846, _G.MarinesCoat)

							if _G.MarinesCoat == false then
								break
							elseif not v846.Parent or v846.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375))
					end
				end)
			end
		end
	end)
end

Q = GRP_Quests_Pole_God_Enal_s:AddToggle("Auto_Swan_Coat", {
	Text = "Auto Swan Coat",
	Default = false,
	Callback = function(p187)
		_G.SwanCoat = p187
	end
})
spawn(function()
	while wait(0.1) do
		if _G.SwanCoat then
			pcall(function()
				local Swan = GetConnectionEnemies("Swan")

				if Swan then
					while true do
						wait()
						t9.Kill(Swan, _G.SwanCoat)

						if _G.SwanCoat == false then
							break
						elseif not Swan.Parent or Swan.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, 0.951042235, 0, 1, 0, -0.951042235, 0, -0.309060812))
				end
			end)
		end
	end
end)
GRP_Quests_Rengoku_Sword = t15.Quests:AddLeftGroupbox("Rengoku Sword")

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Rengoku_Sword", {
		Text = "Auto Rengoku Sword",
		Default = false,
		Callback = function(p188)
			_G.IceBossRen = p188
		end
	})
end

do
	spawn(function()
		pcall(function()
			while wait(0.1) do
				if _G.IceBossRen then
					local v848 = GetConnectionEnemies("Awakened Ice Admiral")

					if v848 then
						while true do
							task.wait()
							t9.Kill(v848, _G.IceBossRen)

							if _G.IceBossRen == false then
								break
							elseif not v848.Parent or v848.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
					end
				end
			end
		end)
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Key_Rengoku", {
		Text = "Auto Key Rengoku",
		Default = false,
		Callback = function(p189)
			_G.KeysRen = p189
		end
	})
end

spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.KeysRen then
				if plr.Backpack:FindFirstChild(t1[3]) then
					EquipWeapon(t1[3])
					wait(0.1)
					_tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))
				else
					if plr.Character:FindFirstChild(t1[3]) then
						EquipWeapon(t1[3])
						wait(0.1)
						_tp(CFrame.new(6571.1201171875, 299.23028564453, -6967.841796875))

						return
					end

					local v849 = GetConnectionEnemies(t1)

					if v849 then
						while true do
							task.wait()
							t9.Kill(v849, _G.KeysRen)

							if plr.Backpack:FindFirstChild(t1[3]) then
								break
							elseif _G.KeysRen == false or not v849.Parent or v849.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5439.716796875, 84.420944213867, -6715.1635742188))
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Dragon_Trident", {
	Text = "Auto Dragon Trident",
	Default = false,
	Callback = function(p190)
		_G.AutoTridentW2 = p190
	end
})
spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.AutoTridentW2 then
				local v850 = GetConnectionEnemies("Tide Keeper")

				if v850 then
					while true do
						task.wait()
						t9.Kill(v850, _G.AutoTridentW2)

						if _G.AutoTridentW2 == false then
							break
						elseif not v850.Parent or v850.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188))
				end
			end
		end)
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Long_Sword", {
	Text = "Auto Long Sword",
	Default = false,
	Callback = function(p191)
		_G.LongsWord = p191
	end
})

do
	spawn(function()
		while wait(0.1) do
			pcall(function()
				if _G.LongsWord then
					local Diamond = GetConnectionEnemies("Diamond")

					if Diamond then
						while true do
							task.wait()
							t9.Kill(Diamond, _G.LongsWord)

							if _G.LongsWord == false then
								break
							elseif not Diamond.Parent or Diamond.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
					end
				end
			end)
		end
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Black_Spikey", {
		Text = "Auto Black Spikey",
		Default = false,
		Callback = function(p192)
			_G.BlackSpikey = p192
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.BlackSpikey then
				pcall(function()
					local Jeremy = GetConnectionEnemies("Jeremy")

					if Jeremy then
						while true do
							wait()
							t9.Kill(Jeremy, _G.BlackSpikey)

							if _G.BlackSpikey == false then
								break
							elseif not Jeremy.Parent or Jeremy.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Dark_Blade_V3", {
		Text = "Auto Dark Blade V3",
		Default = false,
		Callback = function(p193)
			_G.DarkBladev3 = p193
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DarkBladev3 and World2 then
					if not GetBP("Dark Blade") then
						replicated.Remotes.CommF_:InvokeServer("LoadItem", "Dark Blade")
					end

					if not (GetBP("Fist of Darkness") > 1) then
						_G.AutoFarmChest = true
					elseif not workspace.Enemies:FindFirstChild("Darkbeard") then
						_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
					elseif GetConnectionEnemies("Darkbeard") then
						if GetBP("Fist of Darkness") >= 1 then
							while true do
								wait()
								_tp(CFrame.new(-5719.36376953125, 48.505905151367188, -782.9759521484375))

								if not _G.DarkBladev3 then
									break
								elseif Root.Position == CFrame.new(-5719.36376953125, 48.505905151367188, -782.9759521484375).Position then
									break
								end
							end

							fireclickdetector(workspace.Map.GraveIsland.Mountain.Rocks.Button.ClickDetector)
						end
					end
				end
			end)
		end
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Midnight_Blade", {
		Text = "Auto Midnight Blade",
		Default = false,
		Callback = function(p194)
			_G.AutoEcBoss = p194
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.AutoEcBoss then
				if GetM("Ectoplasm") >= 99 then
					replicated.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 3)
				elseif GetM("Ectoplasm") <= 99 then
					local v853 = GetConnectionEnemies("Cursed Captain")

					if v853 then
						while true do
							wait()
							t9.Kill(v853, _G.AutoEcBoss)

							if not _G.AutoEcBoss then
								break
							elseif not v853.Parent or v853.Humanoid.Health <= 0 then
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
						wait(0.5)
						_tp(CFrame.new(916.928589, 181.092773, 33422))
					end
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Darkbeard", {
		Text = "Auto Darkbeard",
		Default = false,
		Callback = function(p195)
			_G.Auto_Def_DarkCoat = p195
		end
	})
end

spawn(function()
	while wait(0.1) do
		if _G.Auto_Def_DarkCoat then
			pcall(function()
				local ok = not GetBP("Fist of Darkness")

				if not ok then
					ok = workspace.Enemies:FindFirstChild("Darkbeard")
				end

				if not ok then
					_tp(CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531))
				elseif GetConnectionEnemies("Darkbeard") then
					local Darkbeard = GetConnectionEnemies("Darkbeard")

					if Darkbeard then
						while true do
							wait()
							t9.Kill(Darkbeard, _G.Auto_Def_DarkCoat)

							if _G.Auto_Def_DarkCoat == false then
								break
							elseif not Darkbeard.Parent or Darkbeard.Humanoid.Helath <= 0 then
								break
							end
						end
					end
				elseif not (GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard")) then
					while true do
						wait(0.1)
						_G.AutoFarmChest = true

						if not _G.Auto_Def_DarkCoat then
							break
						elseif GetBP("Fist of Darkness") or GetConnectionEnemies("Darkbeard") then
							break
						end
					end

					_G.AutoFarmChest = false
				end
			end)
		end
	end
end)
Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Unlocked_DonSwan", {
	Text = "Auto Unlocked DonSwan",
	Default = false,
	Callback = function(p196)
		_G.Auto_DonAcces = p196
	end
})

do
	spawn(function()
		while wait(0.1) do
			if _G.Auto_DonAcces then
				pcall(function()
					if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil and plr.Data.Level.Value >= 1500 then
						FruitPrice = {}
						FruitStore = {}

						local next_ = next
						local response, v858 = replicated:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits")

						for _, v1 in next_, response, v858 do
							if v1.Price >= 1000000 then
								table.insert(FruitPrice, v1.Name)
							end
						end

						for _, v1 in pairs(replicated.Remotes.CommF_:InvokeServer("getInventoryFruits")) do
							for k, v2 in pairs(v1) do
								if k == "Name" then
									table.insert(FruitStore, v2)
								end
							end

							replicated.Remotes.CommF_:InvokeServer("Cousin", "Buy")

							for _, v2 in pairs(FruitPrice) do
								for _, v3 in pairs(FruitStore) do
									if v2 == v3 then
										if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
											_G.StoreF = false

											if plr.Backpack:FindFirstChild(FruitStore) then
												replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "1")
												replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "2")
												replicated.Remotes.CommF_:InvokeServer("TalkTrevor", "3")
											else
												replicated.Remotes.CommF_:InvokeServer("LoadFruit", tostring(v2))
											end
										end
									end
								end
							end

							if replicated.Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess ~= nil then
								_G.StoreF = true
								_G.Auto_DonAcces = false
							end
						end
					end
				end)
			end
		end
	end)
end

do
	Q = GRP_Quests_Rengoku_Sword:AddToggle("Auto_Swan_Glasses", {
		Text = "Auto Swan Glasses",
		Default = false,
		Callback = function(p197)
			_G.Auto_SwanGG = p197
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			if _G.Auto_SwanGG then
				pcall(function()
					local v869 = GetConnectionEnemies("Don Swan")

					if v869 then
						while true do
							wait()
							t9.Kill(v869, _G.Auto_SwanGG)

							if _G.Auto_SwanGG == false then
								break
							elseif not v869.Parent or v869.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875))
					end
				end)
			end
		end
	end)
end

GRP_Quests_Cavender_Twin_Hooks_Bigmom = t15.Quests:AddLeftGroupbox("Cavender + Twin Hooks + Bigmom")
Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Bigmom", {
	Text = "Auto Bigmom",
	Default = false,
	Callback = function(p198)
		_G.AutoBigmom = p198
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoBigmom then
			pcall(function()
				local v870 = GetConnectionEnemies("Cake Queen")

				if v870 then
					while true do
						task.wait()
						t9.Kill(v870, _G.AutoBigmom)

						if not _G.AutoBigmom then
							break
						elseif not v870.Parent or v870.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(-709.31329345703125, 381.6005859375, -11011.396484375))
				end
			end)
		end
	end
end)
Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Canvendish_Sword", {
	Text = "Auto Canvendish Sword",
	Default = false,
	Callback = function(p199)
		_G.Auto_Cavender = p199
		ender = v
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Cavender then
					local v871 = GetConnectionEnemies("Beautiful Pirate")

					if v871 then
						while true do
							wait()
							t9.Kill(v871, _G.Auto_Cavender)

							if not _G.Auto_Cavender then
								break
							elseif v871.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(5283.609375, 22.56223487854, -110.78285217285))
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Twin_Hooks", {
	Text = "Auto Twin Hooks",
	Default = false,
	Callback = function(p200)
		_G.TwinHook = p200
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TwinHook then
					local v872 = GetConnectionEnemies("Captain Elephant")

					if v872 then
						while true do
							wait()
							t9.Kill(v872, _G.TwinHook)

							if not _G.TwinHook then
								break
							elseif v872.Humanoid.Health <= 0 then
								break
							end
						end
					else
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))
						wait(0.2)
						_tp(CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125))
					end
				end
			end)
		end
	end)
end

do
	Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Serpent_Bow", {
		Text = "Auto Serpent Bow",
		Default = false,
		Callback = function(p201)
			_G.AutoSerpentBow = p201
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AutoSerpentBow then
			local v873 = GetConnectionEnemies("Hydra Leader")

			if v873 then
				while true do
					wait()
					t9.Kill(v873, _G.AutoSerpentBow)

					if not _G.AutoSerpentBow then
						break
					elseif not v873.Parent or v873.Humanoid.Health <= 0 then
						break
					end
				end
			else
				_tp(CFrame.new(5821.89794921875, 1019.0950927734375, -73.719230651855469))
			end
		end
	end
end)
Q = GRP_Quests_Cavender_Twin_Hooks_Bigmom:AddToggle("Auto_Lei_Accessory", {
	Text = "Auto Lei Accessory",
	Default = false,
	Callback = function(p202)
		_G.AutoKilo = p202
	end
})
spawn(function()
	while wait(0.2) do
		if _G.AutoKilo then
			pcall(function()
				local v874 = GetConnectionEnemies("Kilo Admiral")

				if v874 then
					while true do
						task.wait()
						t9.Kill(v874, _G.AutoKilo)

						if not _G.AutoKilo then
							break
						elseif not v874.Parent or v874.Humanoid.Health <= 0 then
							break
						end
					end
				else
					_tp(CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125))
				end
			end)
		end
	end
end)
GRP_Quests_Buso_Aura_Colours = t15.Quests:AddLeftGroupbox("Buso/Aura Colours")
Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Teleport_Barista_Cousin", {
	Text = "Auto Teleport Barista Cousin",
	Default = false,
	Callback = function(p203)
		_G.Tp_MasterA = p203
	end
})
spawn(function()
	while wait() do
		if _G.Tp_MasterA then
			pcall(function()
				for _, child in pairs(replicated.NPCs:GetChildren()) do
					if child.Name == "Barista Cousin" then
						_tp(child.HumanoidRootPart.CFrame)
					end
				end
			end)
		end
	end
end)

do
	GRP_Quests_Buso_Aura_Colours:AddButton({
		Text = "Buy Buso Colors",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("ColorsDealer", "2")
		end
	})
end

Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Auto_Rainbow_Colors", {
	Text = "Auto Rainbow Colors",
	Default = false,
	Callback = function(p204)
		_G.Auto_Rainbow_Haki = p204
	end
})
-- Auto Rainbow Haki (logica Banana/Vxeze): HornedMan + boss da quest
spawn(function()
	local rainbowBosses = {
		"Stone",
		"Island Empress",
		"Kilo Admiral",
		"Captain Elephant",
		"Beautiful Pirate",
	}

	local function rainbowQuestBoss()
		local ok, title = pcall(function()
			return plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text
		end)
		if not ok or type(title) ~= "string" then
			return nil
		end
		for _, name in ipairs(rainbowBosses) do
			if string.find(title, name, 1, true) then
				return name
			end
		end
		return nil
	end

	local function hornedDone()
		local ok, res = pcall(function()
			return replicated.Remotes.CommF_:InvokeServer("HornedMan")
		end)
		return ok and res == 1
	end

	local function findHorned()
		local n = workspace:FindFirstChild("NPCs")
		if n and n:FindFirstChild("Horned Man") then
			return n["Horned Man"]
		end
		n = replicated:FindFirstChild("NPCs")
		if n and n:FindFirstChild("Horned Man") then
			return n["Horned Man"]
		end
		return nil
	end

	while task.wait(0.25) do
		pcall(function()
			if not _G.Auto_Rainbow_Haki then
				return
			end
			if not sea3 then
				return
			end
			if hornedDone() then
				_G.Auto_Rainbow_Haki = false
				pcall(function()
					lib:Notify({ Title = "Rainbow Haki", Description = "Done", Duration = 5 })
				end)
				return
			end

			local questOn = false
			pcall(function()
				questOn = plr.PlayerGui.Main.Quest.Visible == true
			end)
			local bossName = questOn and rainbowQuestBoss() or nil

			if bossName then
				local mob = GetConnectionEnemies(bossName)
				if mob and mob:FindFirstChild("HumanoidRootPart") then
					t9.Kill(mob, _G.Auto_Rainbow_Haki)
				else
					-- espera spawn; alguns bosses ficam no ReplicatedStorage
					local rs = replicated:FindFirstChild(bossName) or (replicated:FindFirstChild("Enemies") and replicated.Enemies:FindFirstChild(bossName))
					if rs and rs:FindFirstChild("HumanoidRootPart") then
						_tp(rs.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
					end
				end
			else
				-- pega / renova quest no Horned Man
				local npc = findHorned()
				local root = npc and (npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart)
				if root then
					if (plr.Character.HumanoidRootPart.Position - root.Position).Magnitude > 10 then
						_tp(root.CFrame * CFrame.new(0, 3, 4))
					else
						task.wait(0.6)
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
						end)
						task.wait(0.8)
					end
				else
					-- posicao padrao do Horned Man (Hydra / Floating Turtle area)
					_tp(CFrame.new(-11892.0703125, 930.57672119141, -8760.1591796875))
					task.wait(0.5)
					pcall(function()
						replicated.Remotes.CommF_:InvokeServer("HornedMan", "Bet")
					end)
				end
			end
		end)
	end
end)

do
	Q = GRP_Quests_Buso_Aura_Colours:AddToggle("Accept_Rainbow_Quest_Faster", {
		Text = "Accept Rainbow Quest Faster",
		Default = false,
		Callback = function(p205)
			_G.GetQFast = p205
		end
	})
end

GRP_Quests_Instinct_Observation = t15.Quests:AddLeftGroupbox("Instinct / Observation")

do
	Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Farm_Observation", {
		Text = "Auto Farm Observation",
		Default = false,
		Callback = function(p206)
			_G.obsFarm = p206
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.obsFarm then
					replicated.Remotes.CommE:FireServer("Ken", true)

					if plr:GetAttribute("KenDodgesLeft") == 0 then
						KenTest = false
					elseif plr:GetAttribute("KenDodgesLeft") > 0 then
						replicated.Remotes.CommE:FireServer("Ken", true)
						KenTest = true
					end
				end
			end)
		end
	end)
end

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if _G.obsFarm then
					if not World1 then
						if not World2 then
							if World3 then
								if not workspace.Enemies:FindFirstChild("Venomous Assailant") then
									_tp(CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789))
								elseif KenTest then
									while true do
										wait()
										_tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0))

										if _G.obsFarm == false then
											break
										elseif KenTest == false then
											break
										end
									end
								else
									while true do
										wait()
										_tp(workspace.Enemies:FindFirstChild("Venomous Assailant").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0))

										if _G.obsFarm == false then
											break
										elseif KenTest then
											break
										end
									end
								end
							end
						elseif not workspace.Enemies:FindFirstChild("Lava Pirate") then
							_tp(CFrame.new(-5478.39209, 15.9775667, -5246.9126))
						elseif KenTest then
							while true do
								wait()
								plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

								if _G.obsFarm == false then
									break
								elseif KenTest == false then
									break
								end
							end
						else
							while true do
								wait()
								plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Lava Pirate").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

								if _G.obsFarm == false then
									break
								elseif KenTest then
									break
								end
							end
						end
					elseif not workspace.Enemies:FindFirstChild("Galley Captain") then
						_tp(CFrame.new(5533.29785, 88.1079102, 4852.3916))
					elseif KenTest then
						while true do
							wait()
							plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(3, 0, 0)

							if _G.obsFarm == false then
								break
							elseif KenTest == false then
								break
							end
						end
					else
						while true do
							wait()
							plr.Character.HumanoidRootPart.CFrame = workspace.Enemies:FindFirstChild("Galley Captain").HumanoidRootPart.CFrame * CFrame.new(0, 50, 0)

							if _G.obsFarm == false then
								break
							elseif KenTest then
								break
							end
						end
					end
				end
			end)
		end
	end)
end

Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Observation_V2", {
	Text = "Auto Observation V2",
	Default = false,
	Callback = function(p207)
		_G.AutoKenVTWO = p207
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoKenVTWO then
			pcall(function()
				local cFrame = CFrame.new(-12444.78515625, 332.40396118164, -7673.1806640625)
				local cFrame2 = CFrame.new(-10920.125, 624.20275878906, -10266.995117188)
				local cFrame3 = CFrame.new(-13277.568359375, 370.34185791016, -7821.1572265625)
				local cFrame4 = CFrame.new(-13493.12890625, 318.89553833008, -8373.7919921875)

				if plr.PlayerGui.Main.Quest.Visible == true and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Defeat 50 Forest Pirates") then
					local v890 = GetConnectionEnemies("Forest Pirate")

					if v890 then
						while true do
							wait()
							t9.Kill(v890, _G.AutoKenVTWO)

							if not _G.AutoKenVTWO then
								break
							elseif v890.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(cFrame3)
					end
				elseif plr.PlayerGui.Main.Quest.Visible == true then
					local v891 = GetConnectionEnemies("Captain Elephant")

					if v891 then
						while true do
							wait()
							t9.Kill(v891, _G.AutoKenVTWO)

							if not _G.AutoKenVTWO then
								break
							elseif v891.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(cFrame4)
					end
				elseif plr.PlayerGui.Main.Quest.Visible == false then
					replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
					wait(0.1)
					replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
				end

				if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
					_tp(CFrame.new(-12513.51953125, 340.11373901367188, -9873.048828125))
				end

				local ok5 = not plr.Backpack:FindFirstChild("Fruit Bowl")

				if not ok5 then
					ok5 = not plr.Character:FindFirstChild("Fruit Bowl")
				end

				if ok5 then
					if not GetBP("Fruit Bowl") then
						if not GetBP("Apple") then
							replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12471.169921875, 374.94024658203, -7551.677734375))

							for _, descendant in pairs(workspace:GetDescendants()) do
								if descendant.Name == "Apple" then
									descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
									wait()
									firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
									wait()
								end
							end
						elseif GetBP("Banana") then
							if not GetBP("Pineapple") then
								_tp(CFrame.new(-712.8272705078125, 98.577049255371094, 5711.9541015625))

								for _, descendant in pairs(workspace:GetDescendants()) do
									if descendant.Name == "Pineapple" then
										descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
										wait()
										firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
										wait()
									end
								end
							end
						else
							_tp(CFrame.new(2286.0078125, 73.133918762207031, -7159.80908203125))

							for _, descendant in pairs(workspace:GetDescendants()) do
								if descendant.Name == "Banana" then
									descendant.Handle.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 10)
									wait()
									firetouchinterest(plr.Character.HumanoidRootPart, descendant.Handle, 0)
									wait()
								end
							end
						end
					end

					local ok = not plr.Backpack:FindFirstChild("Banana")

					if not ok then
						ok = not plr.Backpack:FindFirstChild("Apple")
					end

					local ok3 = ok

					if not ok3 then
						ok3 = not plr.Backpack:FindFirstChild("Pineapple")
					end

					local ok2

					if not ok3 then
						repeat
							wait()
							_tp(cFrame)
							ok2 = _G.AutoKenVTWO

							if not ok2 then
								ok2 = plr.Character.HumanoidRootPart.CFrame == cFrame

								if ok2 then
									break
								end
							end
						until ok2
						-- (could not be recovered)
					end

					if plr:FindFirstChild("Banana") then
						if plr:FindFirstChild("Apple") then
							if plr:FindFirstChild("Pineapple") then
								repeat
									wait()
									_tp(cFrame)
									ok2 = _G.AutoKenVTWO or plr.Character.HumanoidRootPart.CFrame == cFrame
								until ok2

								replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
							end
						end
					end

					local ok4 = plr.Backpack:FindFirstChild("Fruit Bowl")

					if not ok4 then
						ok4 = plr.Character:FindFirstChild("Fruit Bowl")
					end

					if ok4 then
						if plr.Character.HumanoidRootPart.CFrame == cFrame2 then
							if plr.Character.HumanoidRootPart.CFrame == cFrame2 then
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Start")
								wait(0.1)
								replicated.Remotes.CommF_:InvokeServer("KenTalk2", "Buy")
							end
						else
							_tp(cFrame2)
						end
					end
				end
			end)
		end
	end
end)

do
	Bartilo = GRP_Quests_Instinct_Observation:AddToggle("Auto_Done_Bartilo_Quest", {
		Text = "Auto Done Bartilo Quest",
		Default = false,
		Callback = function(p208)
			_G.Bartilo_Quest = p208
		end
	})
end

spawn(function()
	while wait(0.1) do
		pcall(function()
			if _G.Bartilo_Quest and Lv >= 850 and ZyroxClaim("bartilo") then
				local Quest = plr.PlayerGui.Main.Quest

				if replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
					_G.Level = false

					if Quest.Visible ~= true then
						while true do
							wait()
							_tp(CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312))

							if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 20 then
								break
							elseif _G.Bartilo_Quest == false then
								break
							end
						end

						if (CFrame.new(-461.533203, 72.3478546, 300.311096, 0.050853312, -0, -0.998706102, 0, 1, -0, 0.998706102, 0, 0.050853312).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
							replicated.Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1)
						end
					elseif GetConnectionEnemies("Swan Pirate") then
						local v904 = GetConnectionEnemies(t3)

						if v904 then
							repeat
								task.wait()

								if string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirate") then
									t9.Kill(v904, _G.Bartilo_Quest)
								else
									replicated.Remotes.CommF_:InvokeServer("AbandonQuest")
								end
							until _G.Bartilo_Quest == false or not v904.Parent or v904.Humanoid.Health <= 0 or Quest.Visible == false or not v904:FindFirstChild("HumanoidRootPart")
						end
					else
						_tp(CFrame.nee(970.369446, 142.653198, 1217.3667, 0.162079468, -4.85452638e-08, -0.986777723, 1.03357589e-08, 1, -4.74980872e-08, 0.986777723, -2.50063148e-09, 0.162079468))
					end
				elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
					_G.Level = false

					local Jeremy = GetConnectionEnemies("Jeremy")

					if Jeremy then
						while true do
							task.wait()
							t9.Kill(Jeremy, _G.Bartilo_Quest)

							if _G.Bartilo_Quest ~= false and Jeremy.Parent then
								if Jeremy.Humanoid.Health <= 0 or not (Quest.Visible ~= false and Jeremy:FindFirstChild("HumanoidRootPart")) then
									break
								end
							else
								break
							end
						end
					else
						_tp(CFrame.new(2158.97412, 449.056244, 705.411682, -0.754199564, -4.17389057e-09, -0.656645238, -4.47752875e-08, 1, 4.50709301e-08, 0.656645238, 6.3393955e-08, -0.754199564))
					end
				elseif replicated.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
					while true do
						wait()
						_tp(CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456))

						if (CFrame.new(-1830.83972, 10.5578213, 1680.60229, 0.979988456, -2.02152783e-08, -0.199054286, 2.20792113e-08, 1, 7.1442483e-09, 0.199054286, -1.13962431e-08, 0.979988456).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 1 then
							break
						elseif _G.Bartilo_Quest == false then
							break
						end
					end

					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate1.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate2.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate3.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate4.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate5.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate6.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate7.CFrame
					wait(0.5)
					plr.Character.HumanoidRootPart.CFrame = workspace.Map.Dressrosa.BartiloPlates.Plate8.CFrame
					wait(2.5)
				end
			end
		end)
	end
end)
CitizenQ = GRP_Quests_Instinct_Observation:AddToggle("Auto_Done_Citizen_Quest", {
	Text = "Auto Done Citizen Quest",
	Default = false,
	Callback = function(p209)
		_G.CitizenQuest = p209
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.CitizenQuest then
				local ok3 = not (Lv >= 1800)

				if not ok3 then
					ok3 = replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBandits ~= false
				end

				if ok3 then
					local ok2 = not (Lv >= 1800)

					if not ok2 then
						ok2 = replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress").KilledBoss ~= false
					end

					if not ok2 then
						local v908 = GetConnectionEnemies("Captain Elephant")

						if not plr.PlayerGui.Main.Quest.Visible or not string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Captain Elephant") or plr.PlayerGui.Main.Quest.Visible ~= true then
							_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

							if (CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 4 then
								wait(1.5)
								replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen")
							end
						elseif v908 then
							while true do
								task.wait()
								t9.Kill(v908, _G.CitizenQuest)

								if _G.CitizenQuest == false then
									break
								elseif v908.Humanoid.Health <= 0 or not v908.Parent or plr.PlayerGui.Main.Quest.Visible == false then
									break
								end
							end
						else
							_tp(CFrame.new(-13374.889648438, 421.27752685547, -8225.208984375))
						end
					elseif Lv >= 1800 then
						if replicated.Remotes.CommF_:InvokeServer("CitizenQuestProgress", "Citizen") == 2 then
							_tp(CFrame.new(-12512.138671875, 340.39279174805, -9872.8203125))
						end
					end
				elseif string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Forest Pirate") and string.find(plr.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and plr.PlayerGui.Main.Quest.Visible == true then
					local v909 = GetConnectionEnemies("Forest Pirate")

					if v909 then
						while true do
							task.wait()
							t9.Kill(v909, _G.CitizenQuest)

							if _G.CitizenQuest == false then
								break
							elseif not v909.Parent or v909.Humanoid.Health <= 0 or plr.PlayerGui.Main.Quest.Visible == false then
								break
							end
						end
					else
						_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
					end
				else
					_tp(CFrame.new(-12443.8671875, 332.40396118164, -7675.4892578125))

					if (Vector3.new(-12443.8671875, 332.40396118164, -7675.4892578125) - plr.Character.HumanoidRootPart.Position).Magnitude <= 30 then
						wait(1.5)
						replicated.Remotes.CommF_:InvokeServer("StartQuest", "CitizenQuest", 1)
					end
				end
			end
		end)
	end
end)
Q = GRP_Quests_Instinct_Observation:AddToggle("Auto_Training_Dummy", {
	Text = "Auto Training Dummy",
	Default = false,
	Callback = function(p210)
		_G.DummyMan = p210
	end
})
spawn(function()
	while wait(Sec) do
		if _G.DummyMan then
			pcall(function()
				if plr.PlayerGui.Main.Quest.Visible == false then
					replicated:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(unpack({ "ArenaTrainer" }))
				else
					local v910 = GetConnectionEnemies("Training Dummy")

					if v910 then
						while true do
							wait()
							t9.Kill(v910, _G.DummyMan)

							if not _G.DummyMan then
								break
							elseif not v910.Parent or v910.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(3688.005126953125, 12.746943473815918, 170.20953369140625))
					end
				end
			end)
		end
	end
end)
GRP_Quests_Fighting_Melee_Styles = t15.Quests:AddLeftGroupbox("Fighting Melee Styles")

do
	SuperHuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Superhuman", {
		Text = "Auto Superhuman",
		Default = false,
		Callback = function(p211)
			_G.Auto_SuperHuman = p211
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_SuperHuman then
				local Value = plr.Data.Beli.Value
				local Value2 = plr.Data.Fragments.Value

				if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Superhuman") then
					if GetBP("Black Leg") then
						if GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 300 then
							_G.Level = false
						end
					elseif Value >= 150000 then
						replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
					end

					if GetBP("Electro") then
						if GetBP("Electro") and GetBP("Electro").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Electro") then
							if GetBP("Electro").Level.Value >= 300 then
								_G.Level = false
							end
						end
					elseif Value >= 500000 then
						replicated.Remotes.CommF_:InvokeServer("BuyElectro")
					end

					if GetBP("Fishman Karate") then
						if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 300 then
							_G.Level = false
						end
					elseif Value >= 750000 then
						replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
					end

					if GetBP("Dragon Claw") then
						if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 299 then
							_G.Level = true
						elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 300 then
							_G.Level = false
						end
					elseif Value2 >= 1500 then
						replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
					end

					replicated.Remotes.CommF_:InvokeServer("BuySuperhuman")
				end
			end
		end)
	end
end)
DeathStep = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DeathStep", {
	Text = "Auto DeathStep",
	Default = false,
	Callback = function(p212)
		_G.AutoDeathStep = p212
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoDeathStep then
				pcall(function()
					if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Death Step") then
						if not GetBP("Black Leg") then
							replicated.Remotes.CommF_:InvokeServer("BuyBlackLeg")
						end

						if GetBP("Black Leg") and GetBP("Black Leg").Level.Value >= 400 then
							replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
							_G.Level = false
						elseif GetBP("Black Leg") and GetBP("Black Leg").Level.Value < 399 then
							_G.Level = true
						end

						if (GetBP("Black Leg") or GetBP("Black Leg").Level.Value >= 400) and workspace.Map.IceCastle.Hall.LibraryDoor.PhoeyuDoor.Transparency == 0 then
							if GetBP("Library Key") then
								while true do
									wait()
									_tp(CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375))

									if not _G.AutoDeathStep then
										break
									elseif Root.Position == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375).Position then
										break
									end
								end

								if Root.CFrame == CFrame.new(6371.2001953125, 296.63433837890625, -6841.18115234375) then
									replicated.Remotes.CommF_:InvokeServer("BuyDeathStep")
								end
							elseif not GetBP("Library Key") then
								local v913 = GetConnectionEnemies("Awakened Ice Admiral")

								if v913 then
									while true do
										wait()
										t9.Kill(v913, _G.AutoDeathStep)

										if not v913.Parent then
											break
										elseif v913.Humanoid.Health <= 0 or _G.AutoDeathStep == false or GetBP("Library Key") or GetBP("Death Step") then
											break
										end
									end
								else
									_tp(CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813))
								end
							end
						end
					end
				end)
			end
		end
	end)
end

do
	SharkManV2 = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Sharkman_Karate", {
		Text = "Auto Sharkman Karate",
		Default = false,
		Callback = function(p213)
			_G.Auto_SharkMan_Karate = p213
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.Auto_SharkMan_Karate then
				pcall(function()
					if plr:FindFirstChild("WeaponAssetCache") and not GetBP("Sharkman Karate") then
						if not GetBP("Fishman Karate") then
							replicated.Remotes.CommF_:InvokeServer("BuyFishmanKarate")
						end

						if GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value >= 400 then
							replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
							_G.Level = false
						elseif GetBP("Fishman Karate") and GetBP("Fishman Karate").Level.Value < 399 then
							_G.Level = true
						end

						if GetBP("Fishman Karate") or GetBP("Fishman Karate").Level.Value >= 400 then
							if not GetBP("Water Key") then
								if not GetBP("Water Key") then
									local v914 = GetConnectionEnemies("Tide Keeper")

									if v914 then
										while true do
											wait()
											t9.Kill(v914, _G.Auto_SharkMan_Karate)

											if not v914.Parent then
												break
											elseif v914.Humanoid.Health <= 0 or _G.Auto_SharkMan_Karate == false or GetBP("Water Key") or GetBP("Sharkman Karate") then
												break
											end
										end
									else
										_tp(CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625))
									end
								end
							elseif string.find(replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate"), "keys") and GetBP("Water Key") then
								while true do
									wait()
									_tp(CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365))

									if not _G.Auto_SharkMan_Karate then
										break
									elseif Root.Position == CFrame.new(-2604.6958, 239.432526, -10315.1982, 0.0425701365, 0, -0.999093413, 0, 1, 0, 0.999093413, 0, 0.0425701365).Position then
										break
									end
								end

								replicated.Remotes.CommF_:InvokeServer("BuySharkmanKarate")
							end
						end
					end
				end)
			end
		end
	end)
end

do
	ElectricClaw = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_ElectricClaw", {
		Text = "Auto ElectricClaw",
		Default = false,
		Callback = function(p214)
			_G.Auto_Electric_Claw = p214
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.Auto_Electric_Claw then
			pcall(function()
				if plr:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Electro") then
						replicated.Remotes.CommF_:InvokeServer("BuyElectro")
					end

					if GetBP("Electro") and GetBP("Electro").Level.Value >= 400 then
						if replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw", "Start") == nil then
							notween(CFrame.new(-12548, 337, -7481))
						end

						replicated.Remotes.CommF_:InvokeServer("BuyElectricClaw")
					elseif GetBP("Electro") and GetBP("Electro").Level.Value < 400 then
						while true do
							_G.AutoFarm_Bone = true
							wait()

							if not _G.Auto_Electric_Claw then
								break
							elseif GetBP("Electric Claw") then
								break
							end
						end

						_G.AutoFarm_Bone = false
					end
				end
			end)
		end
	end
end)

do
	DragonTalon = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_DragonTalon", {
		Text = "Auto DragonTalon",
		Default = false,
		Callback = function(p215)
			_G.AutoDragonTalon = p215
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.AutoDragonTalon then
			pcall(function()
				if plr:FindFirstChild("WeaponAssetCache") then
					if not GetBP("Dragon Claw") then
						replicated.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2")
					end

					if GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value >= 400 then
						replicated.Remotes.CommF_:InvokeServer("Bones", "Buy", 1, 1)
						replicated.Remotes.CommF_:InvokeServer("BuyDragonTalon")
					elseif GetBP("Dragon Claw") and GetBP("Dragon Claw").Level.Value < 400 then
						while true do
							_G.AutoFarm_Bone = true
							wait()

							if not _G.AutoDragonTalon then
								break
							elseif GetBP("Dragon Talon") then
								break
							end
						end

						_G.AutoFarm_Bone = false
					end
				end
			end)
		end
	end
end)
Godhuman = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_Godhuman", {
	Text = "Auto Godhuman",
	Default = false,
	Callback = function(p216)
		_G.Auto_God_Human = p216
	end
})

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Auto_God_Human then
					if replicated.Remotes.CommF_:InvokeServer("BuyGodhuman", true) ~= "Bring me 20 Fish Tails, 20 Magma Ore, 10 Dragon Scales and 10 Mystic Droplets." then
						if replicated.Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 3 then
							return nil
						end

						replicated.Remotes.CommF_:InvokeServer("BuyGodhuman")
					elseif GetM("Dragon Scale") ~= false and not (GetM("Dragon Scale") < 10) then
						if GetM("Fish Tail") ~= false and not (GetM("Fish Tail") < 20) then
							if GetM("Mystic Droplet") ~= false and not (GetM("Mystic Droplet") < 10) then
								if GetM("Magma Ore") == false or GetM("Magma Ore") < 20 then
									if World2 then
										Lv = 1175
										_G.Level = true
									else
										replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
									end
								end
							elseif World2 then
								Lv = 1425
								_G.Level = true
							else
								replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
							end
						elseif World3 then
							Lv = 1775
							_G.Level = true
						else
							replicated.Remotes.CommF_:InvokeServer("TravelZou")
						end
					elseif World3 then
						Lv = 1575
						_G.Level = true
					else
						replicated.Remotes.CommF_:InvokeServer("TravelZou")
					end
				end
			end)
		end
	end)
end

do
	SanguineArt = GRP_Quests_Fighting_Melee_Styles:AddToggle("Auto_SanguineArt", {
		Text = "Auto SanguineArt",
		Default = false,
		Callback = function(p217)
			_G.Snaguine = p217
		end
	})
end

spawn(function()
	while wait(Sec) do
		if _G.Snaguine then
			pcall(function()
				if not GetBP("Sanguine Art") then
					replicated.Remotes.CommF_:InvokeServer("Sanguine Art")
				end

				if GetBP("Sanguine Art") then
					replicated.Remotes.CommF_:InvokeServer("BuySanguineArt")
				else
					if GetM("Leviathan Heart") >= 1 then
						print("Completed!!")
					elseif World3 then
						_G.DangerSc = "Lv Infinite"
						_G.SailBoats = true
					else
						_G.SailBoats = false
					end

					if GetM("Vampire Fang") <= 19 then
						if World2 then
							local Vampire = GetConnectionEnemies("Vampire")

							if Vampire then
								while true do
									task.wait()
									t9.Kill(Vampire, _G.Snaguine)

									if not _G.Snaguine then
										break
									elseif Vampire.Humanoid.Health <= 0 or not Vampire.Parent then
										break
									end
								end
							else
								_tp(CFrame.new(-6041.29248046875, 6.4027109146118164, -1304.63330078125))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end

					if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") <= 19 then
						if World3 then
							local v916 = GetConnectionEnemies("Demonic Soul")

							if v916 then
								while true do
									task.wait()
									t9.Kill(v916, _G.Snaguine)

									if not _G.Snaguine then
										break
									elseif v916.Humanoid.Health <= 0 or not v916.Parent then
										break
									end
								end
							else
								_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
							end
						else
							replicated.Remotes.CommF_:InvokeServer("TravelZou")
						end
					end

					if GetM("Vampire Fang") >= 20 and GetM("Demonic Wisp") >= 20 and GetM("Dark Fragment") <= 1 then
						if not World2 then
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						elseif GetConnectionEnemies("Darkbeard") then
							while true do
								task.wait()
								t9.Kill(black, _G.Snaguine)

								if _G.Snaguine then
									break
								elseif black.Humanoid.Health <= 0 or not black.Parent then
									break
								end
							end
						else
							_tp(CFrame.new(3798.4575195313, 13.826690673828, -3399.806640625))
						end
					end
				end
			end)
		end
	end
end)
-- posicao da Mirage Island (arquivo novo): Locations["Mirage Island"] ou Map.MysticIsland / "Mystic Island"
ZyroxMirageTarget = function()
	local function cframeOf(obj)
		if not obj then
			return nil
		end
		if obj:IsA("BasePart") then
			return obj.CFrame
		end
		local ok, pivot = pcall(function()
			return obj:GetPivot()
		end)
		return ok and pivot or nil
	end

	local map = workspace:FindFirstChild("Map")
	local island = map and (map:FindFirstChild("MysticIsland") or map:FindFirstChild("Mystic Island"))
	if island then
		local center = island:FindFirstChild("Center", true)
		local cf = cframeOf(center) or cframeOf(island)
		if cf then
			return cf
		end
	end

	local origin = workspace:FindFirstChild("_WorldOrigin") or workspace:FindFirstChild("WorldOrigin")
	local locations = origin and origin:FindFirstChild("Locations")
	return cframeOf(locations and locations:FindFirstChild("Mirage Island"))
end

GRP_Race_Mystic_Island_Full_Moon = t15.Race:AddLeftGroupbox("Mystic Island / Full Moon")

do
	local v917 = GRP_Race_Mystic_Island_Full_Moon:AddLabel("")
	local v918 = GRP_Race_Mystic_Island_Full_Moon:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("MysticIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") then
					v918:SetText("Mirage Island : False")

					continue
				end
			end

			v918:SetText("Mirage Island : True")
		end
	end)
	spawn(function()
		while wait(0.2) do
			pcall(function()
				local v919 = Getmoon()

				if v919 == "http://www.roblox.com/asset/?id=9709135895" then
					v917:SetText("Moon : 0 / 8")
				elseif v919 == "http://www.roblox.com/asset/?id=9709139597" then
					v917:SetText("Moon : 1 / 8")
				elseif v919 == "http://www.roblox.com/asset/?id=9709143733" then
					v917:SetText("Moon : 2 / 8")
				elseif v919 == "http://www.roblox.com/asset/?id=9709149052" then
					v917:SetText("Moon : 3 / 8 [ Next Night ]")
				elseif v919 == "http://www.roblox.com/asset/?id=9709149431" then
					v917:SetText("Moon : 4 / 8 [ Full Moon ]")
				elseif v919 == "http://www.roblox.com/asset/?id=9709149680" then
					v917:SetText("Moon : 5 / 8 [ Last Night ]")
				elseif v919 == "http://www.roblox.com/asset/?id=9709150086" then
					v917:SetText("Moon : 6 / 8")
				elseif v919 == "http://www.roblox.com/asset/?id=9709150401" then
					v917:SetText("Moon : 7 / 8")
				end
			end)
		end
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Find_Mirage_Island", {
		Text = "Auto Find Mirage Island",
		Default = false,
		Callback = function(p218)
			_G.FindMirage = p218
		end
	})
end

spawn(function()
	while wait() do
		if _G.FindMirage then
			pcall(function()
				local mirageCFrame = ZyroxMirageTarget()

				if mirageCFrame then
					_tp(mirageCFrame * CFrame.new(0, 300, 0))
				else
					local v920 = CheckBoat()

					if v920 then
						if plr.Character.Humanoid.Sit == false then
							_tp(v920.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							while true do
								wait()

								local cFrame = CFrame.new(-118834.515625, 31, 999920.0494155884)

								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-118834.515625, 150, 999920.0494155884))
								else
									_tp(CFrame.new(-118834.515625, 31, 999920.0494155884))
								end

								if _G.FindMirage and not ((cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10) then
									if not (workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island") or plr.Character.Humanoid.Sit == false) then
										continue
									end
								end

								break
							end

							plr.Character.Humanoid.Sit = false
						end
					else
						local cFrame = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						ZyroxGoBuyBoat(cFrame)

						if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					end
				end
			end)
		end
	end
end)
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Esp_Mirage_Island", {
	Text = "Esp Mirage Island",
	Default = false,
	Callback = function(p219)
		MirageIslandESP = p219

		if MirageIslandESP then
			task.spawn(function()
				while MirageIslandESP do
					UpdateIslandMirageESP()
					task.wait(1)
				end
			end)
		else
			UpdateIslandMirageESP()
		end
	end
})
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Mirage_Island", {
	Text = "Auto Tween To Mirage Island",
	Default = false,
	Callback = function(p220)
		_G.AutoMysticIsland = p220
	end
})

do
	spawn(function()
		while task.wait(0.1) do
			pcall(function()
				if _G.AutoMysticIsland then
					for _, child in pairs(game:GetService("Workspace")._WorldOrigin.Locations:GetChildren()) do
						if child.Name == "Mirage Island" then
							topos(child.CFrame * CFrame.new(0, 333, 0))
						end
					end
				end
			end)
		end
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_To_Highest_Point", {
		Text = "Auto Tween To Highest Point",
		Default = false,
		Callback = function(p221)
			_G.HighestMirage = p221
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.HighestMirage then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Mirage Island", true) then
						_tp(ZyroxMirageTarget() * CFrame.new(0, 400, 0))
					end
				end)
			end
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Gear", {
	Text = "Auto Collect Gear",
	Default = false,
	Callback = function(p222)
		_G.TPGEAR = p222
	end
})

do
	spawn(function()
		pcall(function()
			while wait(0.1) do
				if _G.TPGEAR then
					local pairs_ = pairs
					local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

					for _, child in pairs_(MysticIsland:GetChildren()) do
						if child.Name == "Part" and child.ClassName == "MeshPart" then
							_tp(child.CFrame)
						end
					end
				end
			end
		end)
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Change_Transparency_can_see", {
		Text = "Change Transparency can see",
		Default = false,
		Callback = function(p223)
			_G.can = p223
		end
	})
end

do
	spawn(function()
		pcall(function()
			while wait(Sec) do
				if _G.can then
					local pairs_ = pairs
					local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

					for _, child in pairs_(MysticIsland:GetChildren()) do
						if child.Name == "Part" then
							if child.ClassName == "MeshPart" then
								child.Transparency = 0
							else
								child.Transparency = 1
							end
						end
					end
				end
			end
		end)
	end)
end

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Tween_Advanced_Fruit_Dealer", {
		Text = "Auto Tween Advanced Fruit Dealer",
		Default = false,
		Callback = function(p224)
			_G.Addealer = p224
		end
	})
end

do
	spawn(function()
		while wait() do
			if _G.Addealer then
				pcall(function()
					for _, child in pairs(replicated.NPCs:GetChildren()) do
						if child.Name == "Advanced Fruit Dealer" then
							_tp(child.HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Collect_Mirage_Chest", {
	Text = "Auto Collect Mirage Chest",
	Default = false,
	Callback = function(p225)
		_G.FarmChestM = p225
	end
})

do
	spawn(function()
		while wait(0.2) do
			if _G.FarmChestM then
				pcall(function()
					local ok = workspace.Map:FindFirstChild("MysticIsland").Chests:FindFirstChild("DiamondChest")

					if not ok then
						ok = workspace.Map:FindFirstChild("MysticIsland").Chests:FindFirstChild("FragChest")
					end

					if ok then
						local CollectionService = game:GetService("CollectionService")
						local LocalPlayer = game:GetService("Players").LocalPlayer
						local Character = LocalPlayer.Character

						Character = Character or LocalPlayer.CharacterAdded:Wait()

						if not Character then
							return
						end

						local Position = Character:GetPivot().Position
						local tagged = CollectionService:GetTagged("_ChestTagged")
						local huge = math.huge
						local v942

						for i = 1, #tagged do
							local v944 = tagged[i]
							local Magnitude = (v944:GetPivot().Position - Position).Magnitude

							if (not SelectedIsland or v944:IsDescendantOf(SelectedIsland)) and not v944:GetAttribute("IsDisabled") and Magnitude < huge then
								huge = Magnitude
								v942 = v944
							end
						end

						if v942 then
							_tp(v942:GetPivot())
						end
					end
				end)
			end
		end
	end)
end

GRP_Race_Mystic_Island_Full_Moon:AddButton({
	Text = "Talk With Stone",
	Func = function()
		local CommF_ = replicated:WaitForChild("Remotes"):WaitForChild("CommF_")

		CommF_:InvokeServer("RaceV4Progress", "Begin")
		CommF_:InvokeServer("RaceV4Progress", "Check")
		CommF_:InvokeServer("RaceV4Progress", "Teleport")
	end
})
GRP_Race_Mystic_Island_Full_Moon:AddToggle("Auto_Look_At_Moon", {
	Text = "Auto Look At Moon",
	Default = false,
	Callback = function(p226)
		_G.Auto_Mink = p226
	end
})

do
	MoveCamtoMoon = function()
		workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, Lighting:GetMoonDirection() + workspace.CurrentCamera.CFrame.Position)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, Lighting:GetMoonDirection() + plr.Character.HumanoidRootPart.CFrame.Position)
	end
end

task.spawn(function()
	while task.wait() do
		if LookM then
			MoveCamtoMoon()
			wait(0.1)
			replicated.Remotes.CommE:FireServer("ActivateAbility")
		end
	end
end)

do
	GRP_Race_Mystic_Island_Full_Moon:AddToggle("Look_Moon_+_Auto_V3", {
		Text = "Look Moon + Auto V3",
		Default = false,
		Callback = function(p227)
			LookMV3 = p227
		end
	})
end

do
	MoveCamtoMoon = function()
		local moonDirection = Lighting:GetMoonDirection()

		workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, workspace.CurrentCamera.CFrame.Position + moonDirection)
		plr.Character.HumanoidRootPart.CFrame = CFrame.new(plr.Character.HumanoidRootPart.Position, plr.Character.HumanoidRootPart.Position + moonDirection)
	end
end

do
	task.spawn(function()
		while task.wait(0.1) do
			if LookMV3 then
				MoveCamtoMoon()
				replicated.Remotes.CommE:FireServer("ActivateAbility")
				UIS:SendKeyEvent(true, "T", true, game)
				wait(0.5)
				UIS:SendKeyEvent(false, "T", true, game)
			end
		end
	end)
end

GRP_Race_Upgrade_Races_V2_And_V3 = t15.Race:AddLeftGroupbox("Upgrade Races V2 And V3")

do
	RaceMink = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Mink", {
		Text = "Auto Upgrade Mink",
		Default = false,
		Callback = function(p228)
			_G.Auto_Mink = p228
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Mink then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= 2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							local ok2 = plr.Backpack:FindFirstChild("Flower 1")

							if not ok2 then
								ok2 = plr.Character:FindFirstChild("Flower 1")
							end

							if ok2 then
								local ok = plr.Backpack:FindFirstChild("Flower 2")

								if not ok then
									ok = plr.Character:FindFirstChild("Flower 2")
								end

								if not ok then
									_tp(workspace.Flower2.CFrame)
								elseif not plr.Backpack:FindFirstChild("Flower 3") then
									if not plr.Character:FindFirstChild("Flower 3") then
										local v950 = GetConnectionEnemies("Swan Pirate")

										if v950 then
											while true do
												wait()
												t9.Kill(v950, _G.Auto_Mink)

												if GetBP("Flower 3") then
													break
												elseif not v950.Parent or v950.Humanoid.Health <= 0 or _G.Auto_Mink == false then
													break
												end
											end
										else
											_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
										end
									end
								end
							else
								_tp(workspace.Flower1.CFrame)
							end
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						_G.AutoFarmChest = true
					else
						_G.AutoFarmChest = false
					end
				end
			end)
		end
	end)
end

RaceHuman = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Human", {
	Text = "Auto Upgrade Human",
	Default = false,
	Callback = function(p229)
		_G.Auto_Human = p229
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Auto_Human then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
						if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
							local ok2 = plr.Backpack:FindFirstChild("Flower 1")

							if not ok2 then
								ok2 = plr.Character:FindFirstChild("Flower 1")
							end

							if ok2 then
								local ok = plr.Backpack:FindFirstChild("Flower 2")

								if not ok then
									ok = plr.Character:FindFirstChild("Flower 2")
								end

								if not ok then
									_tp(workspace.Flower2.CFrame)
								elseif not plr.Backpack:FindFirstChild("Flower 3") then
									if not plr.Character:FindFirstChild("Flower 3") then
										local v953 = GetConnectionEnemies("Swan Pirate")

										if v953 then
											while true do
												wait()
												t9.Kill(v953, _G.Auto_Human)

												if plr.Backpack:FindFirstChild("Flower 3") then
													break
												elseif not v953.Parent or v953.Humanoid.Health <= 0 or _G.Auto_Human == false then
													break
												end
											end
										else
											_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
										end
									end
								end
							else
								_tp(workspace.Flower1.CFrame)
							end
						elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
							replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
						local v954 = GetConnectionEnemies(t4[1])

						if v954 then
							while true do
								wait()
								t9.Kill(v954, _G.Auto_Human)

								if v954.Humanoid.Health <= 0 then
									break
								elseif not v954.Parent or not _G.Auto_Human then
									break
								end
							end
						else
							_tp(CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625))
						end

						local v955 = GetConnectionEnemies(t4[2])

						if v955 then
							while true do
								wait()
								t9.Kill(v955, _G.Auto_Human)

								if v955.Humanoid.Health <= 0 then
									break
								elseif not v955.Parent or not _G.Auto_Human then
									break
								end
							end
						else
							_tp(CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109))
						end

						local v956 = GetConnectionEnemies(t4[3])

						if v956 then
							while true do
								wait()
								t9.Kill(v956, _G.Auto_Human)

								if v956.Humanoid.Health <= 0 then
									break
								elseif not v956.Parent or not _G.Auto_Human then
									break
								end
							end
						else
							_tp(CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407))
						end
					end
				end
			end)
		end
	end)
end

RaceSky = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_Angel", {
	Text = "Auto Upgrade Angel",
	Default = false,
	Callback = function(p230)
		_G.Auto_Skypiea = p230
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Skypiea then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						local ok2 = plr.Backpack:FindFirstChild("Flower 1")

						if not ok2 then
							ok2 = plr.Character:FindFirstChild("Flower 1")
						end

						if ok2 then
							local ok = plr.Backpack:FindFirstChild("Flower 2")

							if not ok then
								ok = plr.Character:FindFirstChild("Flower 2")
							end

							if not ok then
								_tp(workspace.Flower2.CFrame)
							elseif not plr.Backpack:FindFirstChild("Flower 3") then
								if not plr.Character:FindFirstChild("Flower 3") then
									local v959 = GetConnectionEnemies("Swan Pirate")

									if v959 then
										while true do
											wait()
											t9.Kill(v959, _G.Auto_Skypiea)

											if plr.Backpack:FindFirstChild("Flower 3") then
												break
											elseif not v959.Parent or v959.Humanoid.Health <= 0 or _G.Auto_Skypiea == false then
												break
											end
										end
									else
										_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end
						else
							_tp(workspace.Flower1.CFrame)
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					for _, child in pairs(game.Players:GetChildren()) do
						if child.Name ~= plr.Name and tostring(child.Data.Race.Value) == "Skypiea" then
							while true do
								task.wait()
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 8, 0) * CFrame.Angles(math.rad(-45), 0, 0))

								if child.Humanoid.Health <= 0 then
									break
								elseif _G.Auto_Skypiea == false then
									break
								end
							end
						end
					end
				end
			end
		end)
	end
end)
RaceFish = GRP_Race_Upgrade_Races_V2_And_V3:AddToggle("Auto_Upgrade_FishMan", {
	Text = "Auto Upgrade FishMan",
	Default = false,
	Callback = function(p231)
		_G.Auto_Fish = p231
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Fish then
				if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") ~= -2 then
					if replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 0 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "2")
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 1 then
						local ok2 = plr.Backpack:FindFirstChild("Flower 1")

						if not ok2 then
							ok2 = plr.Character:FindFirstChild("Flower 1")
						end

						if ok2 then
							local ok = plr.Backpack:FindFirstChild("Flower 2")

							if not ok then
								ok = plr.Character:FindFirstChild("Flower 2")
							end

							if not ok then
								_tp(workspace.Flower2.CFrame)
							elseif not plr.Backpack:FindFirstChild("Flower 3") then
								if not plr.Character:FindFirstChild("Flower 3") then
									local v964 = GetConnectionEnemies("Swan Pirate")

									if v964 then
										while true do
											wait()
											t9.Kill(v964, _G.Auto_Fish)

											if plr.Backpack:FindFirstChild("Flower 3") then
												break
											elseif not v964.Parent or v964.Humanoid.Health <= 0 or _G.Auto_Fish == false then
												break
											end
										end
									else
										_tp(CFrame.new(980.0985107421875, 121.331298828125, 1287.2093505859375))
									end
								end
							end
						else
							_tp(workspace.Flower1.CFrame)
						end
					elseif replicated.Remotes.CommF_:InvokeServer("Alchemist", "1") == 2 then
						replicated.Remotes.CommF_:InvokeServer("Alchemist", "3")
					end
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 0 then
					replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "2")
				elseif replicated.Remotes.CommF_:InvokeServer("Wenlocktoad", "1") == 1 then
					warn("Sea Beast Soon")
				end
			end
		end)
	end
end)
GRP_Race_Trials_Quest_V4 = t15.Race:AddLeftGroupbox("Trials Quest V4")

do
	local v965 = GRP_Race_Trials_Quest_V4:AddLabel("")

	spawn(function()
		pcall(function()
			while wait(0.2) do
				v965:SetText("Tiers - V4 : " .. " " .. plr.Data.Race.C.Value)
			end
		end)
	end)
end

PullLv = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Pull_Lever", {
	Text = "Auto Pull Lever",
	Default = false,
	Callback = function(p232)
		_G.Lver = p232
	end
})
spawn(function()
	while wait(Sec) do
		if _G.Lver then
			pcall(function()
				for _, descendant in pairs(workspace.Map["Temple of Time"]:GetDescendants()) do
					if descendant.Name == "ProximityPrompt" then
						fireproximityprompt(descendant, math.huge)
					end
				end
			end)
		end
	end
end)
Train = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Train_V4", {
	Text = "Auto Train V4",
	Default = false,
	Callback = function(p233)
		_G.AcientOne = p233
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.AcientOne then
					local t38 = {
						"Reborn Skeleton",
						"Living Zombie",
						"Demonic Soul",
						"Posessed Mummy"
					}

					for i = 1, #t38 do
						if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
							vim1:SendKeyEvent(true, "Y", true, game)
							replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy")
							vim1:SendKeyEvent(false, "Y", true, game)
							_tp(CFrame.new(-8987.041015625, 215.862060546875, 5886.71044921875))
						elseif plr.Character:FindFirstChild("RaceTransformed").Value == false then
							local v970 = GetConnectionEnemies(t38)

							if v970 then
								while true do
									wait()
									t9.Kill(v970, _G.AcientOne)

									if _G.AcientOne == false then
										break
									elseif v970.Humanoid.Health <= 0 or not v970.Parent then
										break
									end
								end
							else
								_tp(CFrame.new(-9495.6806640625, 453.58624267578125, 5977.3486328125))
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_Race_Trials_Quest_V4:AddButton({
	Text = "Teleport to Temple of Time",
	Func = function()
		if plr.Character then
			if plr.Character:FindFirstChild("HumanoidRootPart") then
				local cFrame = CFrame.new(-7754.033203125, 2998.953857421875, -404.75357055664062)

				_tp(cFrame)
			end
		end
	end
})

do
	GRP_Race_Trials_Quest_V4:AddButton({
		Text = "Teleport to Ancient One",
		Func = function()
			if plr.Character then
				if plr.Character:FindFirstChild("HumanoidRootPart") then
					local cFrame = CFrame.new(-5071.541015625, 314.5412902832, -3151.1098632812)

					_tp(cFrame)
				end
			end
		end
	})
end

do
	GRP_Race_Trials_Quest_V4:AddButton({
		Text = "Teleport to Ancient Clock",
		Func = function()
			if plr.Character then
				if plr.Character:FindFirstChild("HumanoidRootPart") then
					local cFrame = CFrame.new(-12471.169921875, 374.94024658203, -7551.677734375)

					_tp(cFrame)
				end
			end
		end
	})
end

do
	Doors = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Teleport_to_Race_Doors", {
		Text = "Auto Teleport to Race Doors",
		Default = false,
		Callback = function(p234)
			_G.TPDoor = p234
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TPDoor then
					if tostring(plr.Data.Race.Value) == "Mink" then
						_tp(CFrame.new(29020.66015625, 14889.4267578125, -379.26828002929688))
					elseif tostring(plr.Data.Race.Value) == "Fishman" then
						_tp(CFrame.new(28224.056640625, 14889.4267578125, -210.58720397949219))
					elseif tostring(plr.Data.Race.Value) == "Cyborg" then
						_tp(CFrame.new(28492.4140625, 14894.4267578125, -422.11001586914062))
					elseif tostring(plr.Data.Race.Value) == "Skypiea" then
						_tp(CFrame.new(28967.408203125, 14918.0751953125, 234.31198120117188))
					elseif tostring(plr.Data.Race.Value) == "Ghoul" then
						_tp(CFrame.new(28672.720703125, 14889.1279296875, 454.59616088867188))
					elseif tostring(plr.Data.Race.Value) == "Human" then
						_tp(CFrame.new(29237.294921875, 14889.4267578125, -206.94955444335938))
					end
				end
			end)
		end
	end)
end

Trials = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Complete_Trial_Race", {
	Text = "Auto Complete Trial Race",
	Default = false,
	Callback = function(p235)
		_G.Complete_Trials = p235
	end
})

do
	GetSeaBeastTrial = function()
		if not workspace.Map:FindFirstChild("FishmanTrial") then
			return nil
		end

		if workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water") then
			FishmanTrial = workspace._WorldOrigin.Locations:FindFirstChild("Trial of Water")
		end

		if FishmanTrial then
			local next_ = next
			local children, v976 = workspace.SeaBeasts:GetChildren()

			for _, v1 in next_, children, v976 do
				if v1:FindFirstChild("HumanoidRootPart") and (v1.HumanoidRootPart.Position - FishmanTrial.Position).Magnitude <= 1500 and v1.Health.Value > 0 then
					return v1
				end
			end
		end
	end
end

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Mink" then
						notween(workspace.Map.MinkTrial.Ceiling.CFrame * CFrame.new(0, -20, 0))
					end
				end
			end)
		end
	end)
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Complete_Trials and tostring(plr.Data.Race.Value) == "Fishman" and GetSeaBeastTrial() then
				while true do
					task.wait()
					spawn(function()
						_tp(CFrame.new(GetSeaBeastTrial().HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 300, GetSeaBeastTrial().HumanoidRootPart.Position.Z))
					end)
					MousePos = GetSeaBeastTrial().HumanoidRootPart.Position
					Useskills("Melee", "Z")
					Useskills("Melee", "X")
					Useskills("Melee", "C")
					wait(0.1)
					Useskills("Sword", "Z")
					Useskills("Sword", "X")
					wait(0.1)
					Useskills("Blox Fruit", "Z")
					Useskills("Blox Fruit", "X")
					Useskills("Blox Fruit", "C")
					wait(0.1)
					Useskills("Gun", "Z")
					Useskills("Gun", "X")

					if _G.Complete_Trials == false then
						break
					elseif not GetSeaBeastTrial() then
						break
					end
				end
			end
		end)
	end
end)

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Complete_Trials then
					if tostring(plr.Data.Race.Value) == "Cyborg" then
						_tp(workspace.Map.CyborgTrial.Floor.CFrame * CFrame.new(0, 500, 0))
					end
				end
			end)
		end
	end)
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Complete_Trials then
				if tostring(plr.Data.Race.Value) == "Skypiea" then
					notween(workspace.Map.SkyTrial.Model.FinishPart.CFrame)
				end
			end
		end)
	end
end)

do
	spawn(function()
		while wait(0.1) do
			pcall(function()
				if _G.Complete_Trials and (tostring(plr.Data.Race.Value) == "Human" or tostring(plr.Data.Race.Value) == "Ghoul") then
					local v979 = GetConnectionEnemies({
						"Ancient Vampire",
						"Ancient Zombie"
					})

					if v979 then
						while true do
							wait()
							t9.Kill(v979, _G.Complete_Trials)

							if _G.Complete_Trials == false then
								break
							elseif not v979.Parent or v979.Humanoid.Health <= 0 then
								break
							end
						end
					end
				end
			end)
		end
	end)
end

do
	AutoKill = GRP_Race_Trials_Quest_V4:AddToggle("Auto_Kill_Player_After_Trial", {
		Text = "Auto Kill Player After Trial",
		Default = false,
		Callback = function(p236)
			_G.Defeating = p236
		end
	})
end

spawn(function()
	while task.wait(Sec) do
		pcall(function()
			if _G.Defeating then
				for _, child in pairs(workspace.Characters:GetChildren()) do
					if child.Name ~= plr.Name and child.Humanoid.Health > 0 and child:FindFirstChild("HumanoidRootPart") and child.Parent and (Root.Position - child.HumanoidRootPart.Position).Magnitude <= 250 then
						while true do
							task.wait()
							EquipWeapon(_G.SelectWeapon)
							_tp(child.HumanoidRootPart.CFrame * CFrame.new(0, 0, 15))
							sethiddenproperty(plr, "SimulationRadius", math.huge)

							if _G.Defeating == false then
								break
							elseif child.Humanoid.Health <= 0 or not child.Parent or not child:FindFirstChild("HumanoidRootPart") or not child:FindFirstChild("Humanoid") then
								break
							end
						end
					end
				end
			end
		end)
	end
end)
GRP_Prehistoric_Dojo_Quest = t15.Prehistoric:AddLeftGroupbox("Dojo Quest")
GRP_Prehistoric_Dojo_Quest:AddButton({
	Text = "Dojo Quest",
	Func = function()
		replicated.Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, -334.96499633789062))
		_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
	end
})

do
	DojoQ = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dojo_Trainer", {
		Text = "Auto Dojo Trainer",
		Default = false,
		Callback = function()
		end
	})
end

do
	printBeltName = function(p237)
		if type(p237) == "table" and p237.Quest.BeltName then
			return p237.Quest.BeltName
		end
	end
end

do
	spawn(function()
		while wait(Sec) do
			if _G.Dojoo then
				pcall(function()
					local response = replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
						NPC = "Dojo Trainer",
						Command = "RequestQuest"
					} }))
					local v983 = printBeltName(response)

					if not (debug ~= false or response or v983) then
						_tp(CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875))
						debug = true
					elseif debug == true and (CFrame.new(5865.0234375, 1208.3154296875, 871.15185546875).Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
						if v983 == "White" then
							local v984 = GetConnectionEnemies("Skull Slayer")

							if v984 then
								while true do
									task.wait()
									t9.Kill(v984, _G.Dojoo)

									if not response then
										break
									elseif not _G.Dojoo or not t9.Alive(v984) then
										break
									end
								end
							else
								_tp(CFrame.new(-16759.58984375, 71.283767700195312, 1595.3399658203125))
							end
						elseif v983 == "Yellow" then
							while true do
								task.wait()
								_G.SeaBeast1 = true
								_G.TerrorShark = true
								_G.Shark = true
								_G.Piranha = true
								_G.MobCrew = true
								_G.FishBoat = true
								_G.SailBoats = true

								if not _G.Dojoo then
									break
								elseif not response then
									break
								end
							end

							_G.SeaBeast1 = false
							_G.TerrorShark = false
							_G.Shark = false
							_G.Piranha = false
							_G.MobCrew = false
							_G.FishBoat = false
							_G.SailBoats = false
						elseif v983 == "Green" then
							while true do
								task.wait()
								_G.SailBoats = true

								if not _G.Dojoo then
									break
								elseif not response then
									break
								end
							end

							_G.SailBoats = false
						elseif v983 == "Purple" then
							while true do
								task.wait()
								_G.FarmEliteHunt = true

								if not _G.Dojoo then
									break
								elseif not response then
									break
								end
							end

							_G.FarmEliteHunt = false
						elseif v983 == "Red" then
							while true do
								task.wait()
								_G.SailBoats = true
								_G.FishBoat = true

								if not _G.Dojoo then
									break
								elseif not response then
									break
								end
							end

							_G.SailBoats = false
							_G.FishBoat = false
						elseif v983 == "Black" then
							repeat
								task.wait()

								local ActivationPrompt

								if workspace.Map:FindFirstChild("PrehistoricIsland") then
									_G.Prehis_Find = true
									ActivationPrompt = workspace.Map.PrehistoricIsland.Core.ActivationPrompt

									if ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
										_G.Prehis_Skills = false
										_G.Prehis_Find = true
									else
										_G.Prehis_Skills = true
										_G.Prehis_Find = false
									end
								elseif workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
									_G.Prehis_Find = true
									ActivationPrompt = workspace.Map.PrehistoricIsland.Core.ActivationPrompt

									if ActivationPrompt:FindFirstChild("ProximityPrompt", true) then
										_G.Prehis_Skills = false
										_G.Prehis_Find = true
									else
										_G.Prehis_Skills = true
										_G.Prehis_Find = false
									end

									if not _G.Dojoo or not response then
										break
									end
								else
									_G.Prehis_Find = true
									_G.Prehis_Skills = false
								end
							until not _G.Dojoo or not response

							_G.Prehis_Find = false
							_G.Prehis_Skills = false
						elseif v983 == "Orange" or v983 == "Blue" then
							return nil
						end
					end

					if not response then
						debug = false
						replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
							NPC = "Dojo Trainer",
							Command = "ClaimQuest"
						} }))
					end
				end)
			end
		end
	end)
end

do
	BlazeEM = GRP_Prehistoric_Dojo_Quest:AddToggle("Auto_Dragon_Hunter", {
		Text = "Auto Dragon Hunter",
		Default = false,
		Callback = function(p238)
			_G.FarmBlazeEM = p238
		end
	})
end

do
	checkQuesta = function()
		local t39 = { {
			Context = "Check"
		} }
		local response

		pcall(function()
			game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack({ {
				Context = "RequestQuest"
			} }))
		end)

		local _ = pcall(function()
			response = game:GetService("ReplicatedStorage"):WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RF/DragonHunter"):InvokeServer(unpack(t39))
		end)
		local v990 = false
		local v991
		local v992
		local n5

		if response and response.Text then
			v990 = true

			local Text = response.Text

			if string.find(tostring(Text), "Defeat") then
				n5 = 1

				local v995 = string.sub(tostring(Text), 8, 9)

				v991 = tonumber(v995)

				for _, v1 in pairs({
					"Hydra Enforcer",
					"Venomous Assailant"
				}) do
					if string.find(Text, v1) then
						v992 = v1

						break
					end
				end
			elseif string.find(tostring(Text), "Destroy") then
				v991 = 10
				n5 = 2
				v992 = nil
			end
		end

		return v990, v992, v991, n5
	end
end

do
	BackTODoJo = function()
		for _, child in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren()) do
			if child.Name ~= "NotificationTemplate" then
				continue
			end

			if string.find(child.Text, "Head back to the Dojo to complete more tasks") then
				return true
			end
		end

		return false
	end
end

DragonMobClear = function(p239, p240, p241)
	if workspace.Enemies:FindFirstChild(p240) then
		local v1000, v1001, v1002 = pairs(workspace.Enemies:GetChildren())
		local v1003 = geniter(v1000, v1001, v1002)
		local v1004 = table.pack(v1003())

		if v1004[1] then
			local v1005 = v1004[3]
			local exitTo

			while true do
				if v1005.Name ~= p240 then
					local v1007 = table.pack(v1003())

					if not v1007[1] then
						break
					end

					v1005 = v1007[3]

					continue
				end

				exitTo = 1

				break
			end

			if exitTo == 1 then
				while true do
					if t9.Alive(v1005) and p239 then
						t9.Kill(v1005, p239)

						local exitTo3

						while true do
							local v1009 = table.pack(v1003())

							if v1009[1] then
								v1005 = v1009[3]

								if v1005.Name == p240 then
									exitTo3 = 1

									break
								end
							else
								break
							end
						end

						if exitTo3 ~= 1 then
							break
						end
					else
						local exitTo2

						while true do
							local v1011 = table.pack(v1003())

							if v1011[1] then
								v1005 = v1011[3]

								if v1005.Name == p240 then
									exitTo2 = 1

									break
								end
							else
								break
							end
						end

						if exitTo2 ~= 1 then
							break
						end
					end
				end
			end
		end
	else
		_tp(p241)
	end
end

do
	spawn(function()
		while wait() do
			if _G.FarmBlazeEM then
				pcall(function()
					local v1012, v1013, _, v1015 = checkQuesta()

					if v1012 ~= true or BackTODoJo() then
						_tp(CFrame.new(5813, 1208, 884))
						DragonMobClear(false, nil, nil)
					elseif v1015 ~= 1 then
						if v1015 == 2 then
							if workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true) then
								repeat
									wait()
									spawn(function()
										_tp(workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).CFrame * CFrame.new(4, 0, 0))
									end)

									if (workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position - Root.Position).Magnitude <= 200 then
										MousePos = workspace.Map.Waterfall.IslandModel:FindFirstChild("Meshes/bambootree", true).Position
										Useskills("Melee", "Z")
										Useskills("Melee", "X")
										Useskills("Melee", "C")
										wait(0.5)
										Useskills("Sword", "Z")
										Useskills("Sword", "X")
										wait(0.5)
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
										wait(0.5)
										Useskills("Gun", "Z")
										Useskills("Gun", "X")
									end
								until not _G.FarmBlazeEM or BackTODoJo()
							end
						end
					elseif v1013 == "Hydra Enforcer" or v1013 == "Venomous Assailant" then
						while true do
							wait()
							DragonMobClear(true, v1013, CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))

							if not _G.FarmBlazeEM then
								break
							elseif BackTODoJo() then
								break
							end
						end
					end
				end)
			end
		end
	end)
end

spawn(function()
	while wait(0.1) do
		if _G.FarmBlazeEM then
			pcall(function()
				if workspace.EmberTemplate:FindFirstChild("Part") then
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.EmberTemplate.Part.CFrame
				end
			end)
		end
	end
end)
GRP_Prehistoric_Drago_Trial = t15.Prehistoric:AddLeftGroupbox("Drago Trial")
GetQuestDracoLevel = function()
	return replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
		NPC = "Dragon Wizard",
		Command = "Upgrade"
	} }))
end

do
	Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_To_Upgrade_Droco_Trial", {
		Text = "Tween To Upgrade Droco Trial",
		Default = false,
		Callback = function(p242)
			_G.UPGDrago = p242
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.UPGDrago then
				if GetQuestDracoLevel() == false then
					return nil
				end

				if GetQuestDracoLevel() == true then
					if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - Root.Position).Magnitude >= 300 then
						_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
					else
						_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
						replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
							NPC = "Dragon Wizard",
							Command = "Upgrade"
						} }))
					end
				end
			end
		end)
	end
end)
Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V1)", {
	Text = "Auto Drago (V1)",
	Default = false,
	Callback = function(p243)
		_G.DragoV1 = p243
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.DragoV1 and GetM("Dragon Egg") <= 0 then
				while true do
					wait()
					_G.Prehis_Find = true
					_G.Prehis_Skills = true
					_G.Prehis_DE = true

					if not _G.DragoV1 then
						break
					elseif GetM("Dragon Egg") >= 1 then
						break
					end
				end

				_G.Prehis_Find = false
				_G.Prehis_Skills = false
				_G.Prehis_DE = false
			end
		end)
	end
end)
fireflower = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V2)", {
	Text = "Auto Drago (V2)",
	Default = false,
	Callback = function(p244)
		_G.AutoFireFlowers = p244
	end
})
spawn(function()
	while wait(Sec) do
		if _G.AutoFireFlowers then
			local FireFlowers = workspace:FindFirstChild("FireFlowers")
			local v1017 = GetConnectionEnemies("Forest Pirate")

			if v1017 then
				while true do
					wait()
					t9.Kill(v1017, _G.AutoFireFlowers)

					if not _G.AutoFireFlowers then
						break
					elseif not v1017.Parent or v1017.Humanoid.Health <= 0 or FireFlowers then
						break
					end
				end
			else
				_tp(CFrame.new(-13206.452148438, 425.89199829102, -7964.5537109375))
			end

			if FireFlowers then
				for _, child in pairs(FireFlowers:GetChildren()) do
					if child:IsA("Model") and child.PrimaryPart then
						local Position = child.PrimaryPart.Position

						if (Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
							vim1:SendKeyEvent(true, "E", true, game)
							wait(1.5)
							vim1:SendKeyEvent(false, "E", true, game)
						else
							_tp(CFrame.new(Position))
						end
					end
				end
			end
		end
	end
end)
Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Drago_(V3)", {
	Text = "Auto Drago (V3)",
	Default = false,
	Callback = function(p245)
		_G.DragoV3 = p245
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.DragoV3 then
					repeat
						wait()
						_G.DangerSc = "Lv Infinite"
						_G.SailBoats = true
						_G.TerrorShark = true
					until not _G.DragoV3

					_G.DangerSc = "Lv 1"
					_G.SailBoats = false
					_G.TerrorShark = false
				end
			end)
		end
	end)
end

Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Relic_Drago_Trial_[Beta]", {
	Text = "Auto Relic Drago Trial [Beta]",
	Default = false,
	Callback = function(p246)
		_G.Relic123 = p246
	end
})
spawn(function()
	while wait(Sec) do
		if _G.Relic123 then
			pcall(function()
				if workspace.Map:FindFirstChild("DracoTrial") then
					replicated.Remotes.DracoTrial:InvokeServer()
					wait(0.5)

					while true do
						wait()
						_tp(CFrame.new(-39934.9765625, 10685.359375, 22999.34375))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-39934.9765625, 10685.359375, 22999.34375).Position then
							break
						end
					end

					while true do
						wait()
						_tp(CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-40511.25390625, 9376.4013671875, 23458.37890625).Position then
							break
						end
					end

					wait(2.5)

					while true do
						wait()
						_tp(CFrame.new(-39914.65625, 10685.384765625, 23000.177734375))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-39914.65625, 10685.384765625, 23000.177734375).Position then
							break
						end
					end

					while true do
						wait()
						_tp(CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-40045.83203125, 9376.3984375, 22791.287109375).Position then
							break
						end
					end

					wait(2.5)

					while true do
						wait()
						_tp(CFrame.new(-39908.5, 10685.4052734375, 22990.04296875))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-39908.5, 10685.4052734375, 22990.04296875).Position then
							break
						end
					end

					while true do
						wait()
						_tp(CFrame.new(-39609.5, 9376.400390625, 23472.94335975))

						if not _G.Relic123 then
							break
						elseif Root.Position == CFrame.new(-39609.5, 9376.400390625, 23472.94335975).Position then
							break
						end
					end
				else
					local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

					if TrialTeleport and TrialTeleport:IsA("Part") then
						_tp(CFrame.new(TrialTeleport.Position))
					end
				end
			end)
		end
	end
end)
Toggle = GRP_Prehistoric_Drago_Trial:AddToggle("Auto_Train_Drago_v4", {
	Text = "Auto Train Drago v4",
	Default = false,
	Callback = function(p247)
		_G.TrainDrago = p247
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.TrainDrago then
					local t40 = {
						"Venomous Assailant",
						"Hydra Enforcer"
					}

					for i = 1, #t40 do
						if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then
							vim1:SendKeyEvent(true, "Y", true, game)
							replicated.Remotes.CommF_:InvokeServer("UpgradeRace", "Buy", 2)
							vim1:SendKeyEvent(false, "Y", true, game)
							_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
						elseif plr.Character:FindFirstChild("RaceTransformed").Value == false then
							local v1024 = GetConnectionEnemies(t40)

							if v1024 then
								while true do
									wait()
									t9.Kill(v1024, _G.TrainDrago)

									if _G.TrainDrago == false then
										break
									elseif v1024.Humanoid.Health <= 0 or not v1024.Parent then
										break
									end
								end
							else
								_tp(CFrame.new(4620.61572265625, 1002.2954711914062, 399.08688354492188))
							end
						end
					end
				end
			end)
		end
	end)
end

do
	dragoTpVolcano = GRP_Prehistoric_Drago_Trial:AddToggle("Tween_to_Drago_Trials", {
		Text = "Tween to Drago Trials",
		Default = false,
		Callback = function(p248)
			_G.TpDrago_Prehis = p248
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.TpDrago_Prehis then
				local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

				if TrialTeleport and TrialTeleport:IsA("Part") then
					_tp(CFrame.new(TrialTeleport.Position))
				end
			end
		end
	end)
end

bdrago = GRP_Prehistoric_Drago_Trial:AddToggle("Swap_Drago_Race", {
	Text = "Swap Drago Race",
	Default = false,
	Callback = function(p249)
		_G.BuyDrago = p249
	end
})
spawn(function()
	while wait(Sec) do
		if _G.BuyDrago then
			pcall(function()
				if (CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375).Position - Root.Position).Magnitude >= 300 then
					_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
				else
					_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))
					replicated.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
						NPC = "Dragon Wizard",
						Command = "DragonRace"
					} }))
				end
			end)
		end
	end
end)

do
	UpTalon = GRP_Prehistoric_Drago_Trial:AddToggle("Upgrade_Dragon_Talon_With_Uzoth", {
		Text = "Upgrade Dragon Talon With Uzoth",
		Default = false,
		Callback = function(p250)
			_G.DT_Uzoth = p250
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.DT_Uzoth then
				local cFrame = CFrame.new(5661.89014, 1211.31909, 864.836731, 0.811413169, -1.36805838e-08, -0.584473014, 4.75227395e-08, 1, 4.25682458e-08, 0.584473014, -6.23161966e-08, 0.811413169)

				_tp(cFrame)

				if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 25 then
					replicated.Modules.Net["RF/InteractDragonQuest"]:InvokeServer({
						NPC = "Uzoth",
						Command = "Upgrade"
					})
				end
			end
		end
	end)
end

-- Craft pelo remote novo (RF/Craft), igual ao Vxeze: InvokeServer("Craft", item, 1, {})
ZyroxCraft = function(itemId, label)
	task.spawn(function()
		local ok, result = pcall(function()
			local net = replicated.Modules.Net:FindFirstChild("RF/Craft")
			if not net then
				error("RF/Craft remote not found")
			end
			return net:InvokeServer("Craft", itemId, 1, {})
		end)
		local msg
		if not ok then
			msg = "error: " .. tostring(result)
		elseif type(result) == "table" then
			msg = tostring(result.Message or result.Text or "sent")
		elseif result == nil then
			msg = "sent"
		else
			msg = tostring(result)
		end
		pcall(function()
			lib:Notify({ Title = "Craft", Description = label .. ": " .. msg, Duration = 4 })
		end)
	end)
end

GRP_Prehistoric_Volcanic_Crafting = t15.Prehistoric:AddLeftGroupbox("Volcanic Crafting")
GRP_Prehistoric_Volcanic_Crafting:AddButton({
	Text = "Craft Dragonheart",
	Func = function()
		ZyroxCraft("Dragonheart", "Dragonheart")
	end
})

do
	GRP_Prehistoric_Volcanic_Crafting:AddButton({
		Text = "Craft Dragonstorm",
		Func = function()
			ZyroxCraft("Dragonstorm", "Dragonstorm")
		end
	})
end

GRP_Prehistoric_Volcanic_Crafting:AddButton({
	Text = "Craft Dino Hood",
	Func = function()
		ZyroxCraft("DinoHood", "Dino Hood")
	end
})
GRP_Prehistoric_Volcanic_Crafting:AddButton({
	Text = "Craft T-Rex Skull",
	Func = function()
		ZyroxCraft("TRexSkull", "T-Rex Skull")
	end
})
GRP_Prehistoric_Prehistoric_Island = t15.Prehistoric:AddLeftGroupbox("Prehistoric Island")

do
	local v1027 = GRP_Prehistoric_Prehistoric_Island:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("PrehistoricIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island") then
					v1027:SetText("Prehistoric Island : False")

					continue
				end
			end

			v1027:SetText("Prehistoric Island : True")
		end
	end)
end

do
	GRP_Prehistoric_Prehistoric_Island:AddButton({
		Text = "Craft Volcanic Magnet",
		Func = function()
			ZyroxCraft("Volcanic Magnet", "Volcanic Magnet")
		end
	})
end

GRP_Prehistoric_Prehistoric_Island:AddToggle("Craft_Volcanic_Magnet", {
	Text = "Craft Volcanic Magnet",
	Default = false,
	Callback = function(p251)
		getgenv().AutoCraftVolcanic = p251
	end
})
task.spawn(function()
	while task.wait(2) do
		if getgenv().AutoCraftVolcanic then
			pcall(function()
				local rfCraft = game:GetService("ReplicatedStorage").Modules.Net["RF/Craft"]
				rfCraft:InvokeServer("Craft", "Volcanic Magnet", 1, {})
			end)
		end
	end
end)

do
	GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Find_Prehistoric_Island", {
		Text = "Auto Find Prehistoric Island",
		Default = false,
		Callback = function(p252)
			_G.Prehis_Find = p252
		end
	})
end

do
	local u1029

	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Prehis_Find then
					local Character = plr.Character

					if not Character then
						return
					end

					local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character:FindFirstChild("Humanoid")

					if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
						return
					end

					local PrehistoricIsland = workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true)

					if PrehistoricIsland then
						local HeadTeleport = PrehistoricIsland:FindFirstChild("HeadTeleport", true) or PrehistoricIsland:FindFirstChild("Teleport_Head", true) or PrehistoricIsland:FindFirstChild("Head", true)

						if HeadTeleport then
							local CFrame_ = HeadTeleport.CFrame
							local v1036 = CFrame_.Position - CFrame_.LookVector * 40 + Vector3.new(0, 20, 0)

							if (v1036 - HumanoidRootPart.Position).Magnitude > 30 then
								_tp(CFrame.new(v1036))
							end
						else
							local Position = PrehistoricIsland.CFrame.Position

							_tp(CFrame.new(Position - (Position - HumanoidRootPart.Position).Unit * 250 + Vector3.new(0, 60, 0)))
						end
					else
						local v1038 = CheckBoat()

						if not v1038 then
							local cFrame = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

							ZyroxGoBuyBoat(cFrame)

							if (cFrame.Position - HumanoidRootPart.Position).Magnitude <= 10 then
								replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat or "Guardian")
							end

							return
						end

						if Humanoid.Sit == false then
							_tp(v1038.VehicleSeat.CFrame * CFrame.new(0, 1, 0))

							return
						end

						local cFrame = CFrame.new(-10000000, 31, 37016.25)

						u1029 = cFrame

						if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
							_tp(CFrame.new(-10000000, 150, 37016.25))
						else
							_tp(cFrame)
						end
					end
				end
			end)
		end
	end)
end

GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Start_Prehistoric_Event", {
	Text = "Auto Start Prehistoric Event",
	Default = false,
	Callback = function(p253)
		_G.AutoStartPrehistoric = p253
	end
})

do
	spawn(function()
		while wait() do
			if _G.AutoStartPrehistoric then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Prehistoric Island", true) then
						if workspace.Map:FindFirstChild("PrehistoricIsland", true) then
							local ActivationPrompt = workspace.Map.PrehistoricIsland.Core:FindFirstChild("ActivationPrompt", true)

							if ActivationPrompt and ActivationPrompt:FindFirstChild("ProximityPrompt") then
								if plr:DistanceFromCharacter(ActivationPrompt.CFrame.Position) <= 150 then
									fireproximityprompt(ActivationPrompt.ProximityPrompt, math.huge)
									vim1:SendKeyEvent(true, "E", true, game)
									wait(1.5)
									vim1:SendKeyEvent(false, "E", true, game)
								end

								_tp(ActivationPrompt.CFrame)
							end
						end
					end
				end)
			end
		end
	end)
end

do
	GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Patch_Prehistoric_Event", {
		Text = "Auto Patch Prehistoric Event",
		Default = false,
		Callback = function(p254)
			_G.Prehis_Skills = p254
		end
	})
end

do
	spawn(function()
		while wait(0.3) do
			if _G.Prehis_Skills then
				pcall(function()
					local PrehistoricIsland = workspace.Map:FindFirstChild("PrehistoricIsland")

					if not PrehistoricIsland then
						return
					end

					for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
						if descendant:IsA("BasePart") or descendant:IsA("MeshPart") then
							if descendant.Name:lower():find("lava") then
								descendant:Destroy()
							end
						end
					end

					local Core = PrehistoricIsland:FindFirstChild("Core")

					if Core then
						local InteriorLava = Core:FindFirstChild("InteriorLava")

						if InteriorLava then
							InteriorLava:Destroy()
						end
					end

					local TrialTeleport = PrehistoricIsland:FindFirstChild("TrialTeleport")

					for _, descendant in pairs(PrehistoricIsland:GetDescendants()) do
						if descendant.Name == "TouchInterest" then
							if not TrialTeleport or not descendant:IsDescendantOf(TrialTeleport) then
								descendant.Parent:Destroy()
							end
						end
					end
				end)
			end
		end
	end)
end

spawn(function()
	while wait(Sec) do
		if _G.Prehis_Skills then
			pcall(function()
				local v1050 = GetConnectionEnemies("Lava Golem")

				if v1050 and v1050:FindFirstChild("Humanoid") then
					while true do
						wait(0.1)
						t9.Kill(v1050, true)
						v1050.Humanoid:ChangeState(15)

						if not _G.Prehis_Skills then
							break
						elseif not v1050.Parent or v1050.Humanoid.Health <= 0 then
							break
						end
					end
				end
			end)
		end
	end
end)
-- Ataque as lavas (rochas do vulcao): logica do Vxeze
-- DetectRockVolcano (VFXLayer.Specs.Enabled) + posicao de ataque por altura da rocha + skills fora de cooldown
do
	local LavaRockOffsets = {
		[273] = CFrame.new(40, 0, 0),
		[286] = CFrame.new(40, 0, 0),
		[246] = CFrame.new(0, -40, 0),
		[486] = CFrame.new(40, 0, 0),
		[364] = CFrame.new(40, 0, 0),
		[682] = CFrame.new(0, 0, -40),
		[490] = CFrame.new(0, 40, 0),
		[691] = CFrame.new(40, 0, 0),
		[502] = CFrame.new(-40, 0, 0),
		[256] = CFrame.new(-40, 0, 0),
		[290] = CFrame.new(0, 40, 0),
		[427] = CFrame.new(0, 40, 0),
		[692] = CFrame.new(0, 0, 40),
		[316] = CFrame.new(0, 40, 0),
		[481] = CFrame.new(0, 40, 0),
		[594] = CFrame.new(0, 40, 0),
		[649] = CFrame.new(40, 0, 0),
		[285] = CFrame.new(0, -40, 0),
		[250] = CFrame.new(0, 40, 0),
		[454] = CFrame.new(-40, 0, 0),
	}
	local LavaSkillKeys = {
		Melee = { "Z", "X", "C" },
		Sword = { "Z", "X" },
		Gun = { "Z", "X" },
		["Blox Fruit"] = { "Z", "X", "C", "V", "F" },
	}
	local LavaWeaponOrder = { "Melee", "Sword", "Gun", "Blox Fruit" }

	local LavaSkillBoard = function(tool)
		local gui = plr:FindFirstChild("PlayerGui")
		gui = gui and gui:FindFirstChild("Main")
		gui = gui and gui:FindFirstChild("Skills")
		return tool and gui and gui:FindFirstChild(tool.Name)
	end

	local LavaSkillReady = function(frame)
		if not frame or not frame:IsA("Frame") or frame.Name == "Template" or not frame.Visible then
			return false
		end
		local title, cooldown = frame:FindFirstChild("Title"), frame:FindFirstChild("Cooldown")
		if not title or not cooldown then
			return false
		end
		if string.find(title.Text, "Transformation") or title.Text == "" or title.Text == "???" then
			return false
		end
		if title.TextColor3 ~= Color3.new(1, 1, 1) then
			return false
		end
		return cooldown.Size.X.Scale <= 0.005
	end

	local LavaFindTool = function(tooltip)
		for _, container in ipairs({ plr.Character, plr.Backpack }) do
			if container then
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and tool.ToolTip == tooltip then
						return tool
					end
				end
			end
		end
	end

	local LavaReadySkill = function(tool, tooltip)
		local board = LavaSkillBoard(tool)
		if not board then
			return nil
		end
		for _, key in ipairs(LavaSkillKeys[tooltip] or { "Z", "X", "C", "V", "F" }) do
			if LavaSkillReady(board:FindFirstChild(key)) then
				return key
			end
		end
	end

	-- botao mobile ou teclado (como o PressSkillKey do Vxeze)
	local LavaPressKey = function(key, hold)
		local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
		local board = tool and LavaSkillBoard(tool)
		local slot = board and board:FindFirstChild(key)
		local button = slot and slot:FindFirstChild("Mobile")
		local downs = button and getconnections and getconnections(button.MouseButton1Down)
		if downs and #downs > 0 then
			for _, conn in ipairs(downs) do
				pcall(function() conn:Fire() end)
			end
			task.wait(hold)
			for _, conn in ipairs(getconnections(button.MouseButton1Up)) do
				pcall(function() conn:Fire() end)
			end
			return
		end
		pcall(function() vim1:SendKeyEvent(true, key, false, game) end)
		task.wait(hold)
		pcall(function() vim1:SendKeyEvent(false, key, false, game) end)
	end

	-- AutoUseSkillFixLava: arma escolhida -> primeira skill pronta. Padrao: Melee + Blox Fruit (como o Zyrox usava).
	-- Para mudar: _G.LavaWeapons = { Melee = true, Sword = true, Gun = true, ["Blox Fruit"] = true }
	local LavaUseSkills = function()
		local selected = _G.LavaWeapons or { Melee = true, ["Blox Fruit"] = true }
		local char = plr.Character
		if not char then
			return
		end
		local tools = {}
		for _, tooltip in ipairs(LavaWeaponOrder) do
			if selected[tooltip] then
				local tool = LavaFindTool(tooltip)
				if tool then
					if not LavaSkillBoard(tool) then
						EquipWeapon(tool.Name)
						return
					end
					tools[#tools + 1] = { tool = tool, tooltip = tooltip }
				end
			end
		end
		for _, item in ipairs(tools) do
			local key = LavaReadySkill(item.tool, item.tooltip)
			if key then
				if not char:FindFirstChild(item.tool.Name) then
					EquipWeapon(item.tool.Name)
					task.wait(0.05)
				end
				if plr.Character and plr.Character:FindFirstChild(item.tool.Name) then
					LavaPressKey(key, _G.LavaSkillHold or 0.05)
				end
				return
			end
		end
	end

	-- DetectRockVolcano: rocha "Rock" ativa mais proxima
	local LavaDetectRock = function()
		local island = workspace.Map:FindFirstChild("PrehistoricIsland")
		local core = island and island:FindFirstChild("Core")
		local rocks = core and core:FindFirstChild("VolcanoRocks")
		if not rocks then
			return nil
		end
		local best, bestDist = nil, math.huge
		for _, rock in ipairs(rocks:GetChildren()) do
			if rock.Name == "Rock" then
				local vfx = rock:FindFirstChild("VFXLayer")
				local specs = vfx and vfx:FindFirstChild("Specs")
				if specs and specs.Enabled then
					local dist = plr:DistanceFromCharacter(rock.WorldPivot.Position)
					if dist < bestDist then
						bestDist, best = dist, rock
					end
				end
			end
		end
		return best
	end

	local LavaGolemAlive = function()
		for _, mob in ipairs(workspace.Enemies:GetChildren()) do
			if mob.Name == "Lava Golem" then
				local hum, root = mob:FindFirstChild("Humanoid"), mob:FindFirstChild("HumanoidRootPart")
				if hum and root and hum.Health > 0 and plr:DistanceFromCharacter(root.Position) <= 1500 then
					return true
				end
			end
		end
		return false
	end

	-- se o HUD dos timers nao existir, nao bloqueia o ataque
	local LavaTimerVisible = function()
		local main = plr.PlayerGui:FindFirstChild("Main")
		local hud = main and main:FindFirstChild("TopHUDList")
		if not hud then
			return true
		end
		local prehistoric, raid = hud:FindFirstChild("PrehistoricRaidTimer"), hud:FindFirstChild("RaidTimer")
		if not prehistoric and not raid then
			return true
		end
		return (prehistoric and prehistoric.Visible) or (raid and raid.Visible) or false
	end

	spawn(function()
		while wait(Sec) do
			if _G.Prehis_Skills then
				pcall(function()
					local rock = LavaDetectRock()
					if not rock then
						return
					end

					local lastTp = 0
					while _G.Prehis_Skills do
						task.wait()
						local pivot = rock.WorldPivot
						local standAt = pivot * (LavaRockOffsets[math.floor(pivot.Position.Y)] or CFrame.new(0, 40, 0))

						if plr:DistanceFromCharacter(standAt.Position) > 8 and tick() - lastTp > 0.5 then
							lastTp = tick()
							_tp(standAt)
						end

						MousePos = pivot.Position
						getgenv().AimPos = pivot

						if plr:DistanceFromCharacter(pivot.Position) < 100 then
							LavaUseSkills()
						end

						local vfx = rock:FindFirstChild("VFXLayer")
						local specs = vfx and vfx:FindFirstChild("Specs")
						if not rock.Parent or not specs or not specs.Enabled or LavaGolemAlive()
							or not workspace.Map:FindFirstChild("PrehistoricIsland") or not LavaTimerVisible() then
							break
						end
					end
					wait(1)
				end)
			end
		end
	end)
end

do
	Kaura = GRP_Prehistoric_Prehistoric_Island:AddToggle("Kill_Aura", {
		Text = "Kill Aura",
		Default = false,
		Callback = function(p255)
			_G.KillAuraFull = p255
		end
	})
end

spawn(function()
	while task.wait(2) do
		if _G.KillAuraFull then
			pcall(function()
				local LocalPlayer = game.Players.LocalPlayer
				local Character = LocalPlayer.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

				if not HumanoidRootPart then
					return
				end

				sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)

				for _, child in pairs(workspace.Enemies:GetChildren()) do
					if child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") and (child.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 500 and child.Humanoid.Health > 0 then
						child.Humanoid.Health = 0
						child.HumanoidRootPart.CanCollide = false
						child:BreakJoints()
					end
				end
			end)
		end
	end
end)

do
	Vocan = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dino_Bones", {
		Text = "Auto Collect Dino Bones",
		Default = false,
		Callback = function(p256)
			_G.Prehis_DB = p256
		end
	})
end

spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Prehis_DB then
				if workspace:FindFirstChild("DinoBone") then
					for _, child in pairs(workspace:GetChildren()) do
						if child.Name == "DinoBone" then
							_tp(child.CFrame)
						end
					end
				end
			end
		end)
	end
end)
Vocan = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Collect_Dragon_Eggs", {
	Text = "Auto Collect Dragon Eggs",
	Default = false,
	Callback = function(p257)
		_G.Prehis_DE = p257
	end
})

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				if _G.Prehis_DE then
					if workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg") then
						_tp(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs:FindFirstChild("DragonEgg").Molten.CFrame)
						fireproximityprompt(workspace.Map.PrehistoricIsland.Core.SpawnedDragonEggs.DragonEgg.Molten.ProximityPrompt, 30)
					end
				end
			end)
		end
	end)
end

Toggle = GRP_Prehistoric_Prehistoric_Island:AddToggle("Auto_Reset_When_Complete_Volcano", {
	Text = "Auto Reset When Complete Volcano",
	Default = false,
	Callback = function(p258)
		_G.ResetPH = p258
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.ResetPH then
				local TrialTeleport = workspace.Map.PrehistoricIsland:FindFirstChild("TrialTeleport")

				if TrialTeleport and TrialTeleport:FindFirstChild("TouchInterest") then
					plr.Character.Humanoid.Health = 0
				elseif workspace:FindFirstChild("DinoBone") then
					for _, child in pairs(workspace:GetChildren()) do
						if child.Name == "DinoBone" then
							_tp(child.CFrame)
						end
					end
				end
			end
		end)
	end
end)
GRP_SeaEvent_Sea_Event_Setting_Sail = t15.SeaEvent:AddLeftGroupbox("Sea Event / Setting Sail")
getgenv().SetSpeedBoat = 300

do
	spawn(function()
		game:GetService("RunService").RenderStepped:Connect(function()
			if getgenv().SpeedBoat then
				local LocalPlayer = game:GetService("Players").LocalPlayer

				if LocalPlayer.Character then
					if LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid.Sit then
						for _, child in pairs(game:GetService("Workspace").Boats:GetChildren()) do
							local VehicleSeat = child:FindFirstChildWhichIsA("VehicleSeat")

							if VehicleSeat then
								VehicleSeat.MaxSpeed = getgenv().SetSpeedBoat
							end
						end
					end
				end
			end
		end)
	end)
end

GRP_SeaEvent_Sea_Event_Setting_Sail:AddButton({
	Text = "Remove Lighting Effect",
	Func = function()
		pcall(function()
			game.Lighting.BaseAtmosphere:Destroy()
		end)
	end
})

do
	GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Ship_Speed_Modifier", {
		Text = "Ship Speed Modifier",
		Default = false,
		Callback = function(p259)
			getgenv().SpeedBoat = p259
		end
	})
end

GRP_SeaEvent_Sea_Event_Setting_Sail:AddSlider({
	Text = "Ship Speed",
	Min = 0,
	Max = 1000,
	Default = 300,
	Rounding = 0,
	Callback = function(p260)
		getgenv().SetSpeedBoat = p260
	end
})

do
	GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("Auto_Press_W", {
		Text = "Auto Press W",
		Default = false,
		Callback = function(p261)
			getgenv().AutoPressW = p261
		end
	})
end

spawn(function()
	while wait() do
		pcall(function()
			if getgenv().AutoPressW then
				if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
					game:GetService("VirtualInputManager"):SendKeyEvent(true, "W", true, game)
					task.wait(0.1)
					game:GetService("VirtualInputManager"):SendKeyEvent(false, "W", true, game)
				end
			end
		end)
	end
end)
GRP_SeaEvent_Sea_Event_Setting_Sail:AddToggle("No_Clip_Ship", {
	Text = "No Clip Ship",
	Default = false,
	Callback = function(p262)
		getgenv().NoClipShip = p262
	end
})
spawn(function()
	while wait() do
		pcall(function()
			for _, child in pairs(game:GetService("Workspace").Boats:GetChildren()) do
				for _, descendant in pairs(child:GetDescendants()) do
					if descendant:IsA("BasePart") then
						if getgenv().NoClipShip or getgenv().FindPrehistoric then
							descendant.CanCollide = false
						else
							descendant.CanCollide = true
						end
					end
				end
			end
		end)
	end
end)
GRP_SeaEvent_Crafting_Items = t15.SeaEvent:AddLeftGroupbox("Crafting Items")

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft SharkTooth",
		Func = function()
			ZyroxCraft("ToothNecklace", "Shark Tooth Necklace")
		end
	})
end

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft TerrorJaw",
		Func = function()
			ZyroxCraft("TerrorJaw", "Terror Jaw")
		end
	})
end

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft SharkAnchor",
		Func = function()
			ZyroxCraft("SharkAnchor", "Shark Anchor")
		end
	})
end

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft LeviathanCrown",
		Func = function()
			ZyroxCraft("LeviathanCrown", "Leviathan Crown")
		end
	})
end

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft LeviathanShield",
		Func = function()
			ZyroxCraft("LeviathanShield", "Leviathan Shield")
		end
	})
end

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft LeviathanBoat",
		Func = function()
			ZyroxCraft("LeviathanBoat", "Leviathan Boat")
		end
	})
end

GRP_SeaEvent_Crafting_Items:AddButton({
	Text = "Craft LegendaryScroll",
	Func = function()
		ZyroxCraft("LegendaryScroll", "Legendary Scroll")
	end
})

do
	GRP_SeaEvent_Crafting_Items:AddButton({
		Text = "Craft MythicalScroll",
		Func = function()
			ZyroxCraft("MythicalScroll", "Mythical Scroll")
		end
	})
end

GRP_SeaEvent_Choose_Sea_Event = t15.SeaEvent:AddLeftGroupbox("Choose Sea Event")
_G.SelectedBoat = _G.SelectedBoat or "Guardian"
_G.DangerSc = _G.DangerSc or "Lv 1"

-- Quando o barco morre: reseta o personagem (renasce perto do vendedor) em vez de voar ate ele
ZyroxBoatWasAlive = false
ZyroxBoatResetAt = 0
-- Logica do "Reset Character Buy Boat" do 3nn / Vxeze: sem barco e longe do vendedor (> 1000 studs) no Sea 3,
-- se o seu ponto de spawn for Tiki, reseta para renascer perto do vendedor; caso contrario voa ate ele.
ZyroxGoBuyBoat = function(cFrame)
	local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")

	if root and _G.ResetWhenBoatDies ~= false and World3 and (cFrame.Position - root.Position).Magnitude > 1000 then
		local location = plr:GetAttribute("CurrentLocation")

		if not location or location ~= "Tiki Outpost" then
			local data = plr:FindFirstChild("Data")
			local spawnPoint = data and data:FindFirstChild("LastSpawnPoint")

			if spawnPoint and (spawnPoint.Value == "Tiki" or spawnPoint.Value == "Tiki2") and tick() - ZyroxBoatResetAt > 15 then
				ZyroxBoatResetAt = tick()
				local oldChar = plr.Character
				local hum = oldChar and oldChar:FindFirstChildOfClass("Humanoid")

				if hum then
					hum.Health = 0

					-- espera renascer (com limite de tempo)
					local startedAt = tick()
					repeat
						task.wait(0.5)
					until (plr.Character and plr.Character ~= oldChar and plr.Character:FindFirstChild("HumanoidRootPart"))
						or tick() - startedAt > 25

					task.wait(3)
					return
				end
			end
		end
	end

	TeleportToTarget(cFrame)
end

GRP_SeaEvent_Choose_Sea_Event:AddToggle("Reset_When_Boat_Dies", {
	Text = "Reset When Boat Dies",
	Tooltip = "Sem barco e longe do vendedor: se o seu spawn for Tiki, reseta em vez de voar ate ele",
	Default = true,
	Callback = function(value)
		_G.ResetWhenBoatDies = value
	end
})
Q = GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Boats", {
	Text = "Select Boats",
	Values = {
		"Guardian",
		"PirateGrandBrigade",
		"MarineGrandBrigade",
		"PirateBrigade",
		"MarineBrigade",
		"PirateSloop",
		"MarineSloop",
		"Beast Hunter"
	},
	Default = 1,
	Callback = function(p263)
		_G.SelectedBoat = p263
	end
})

do
	GRP_SeaEvent_Choose_Sea_Event:AddButton({
		Text = "Buy Boats",
		Func = function()
			replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
		end
	})
end

do
	Q = GRP_SeaEvent_Choose_Sea_Event:AddDropdown("Select_Sea_Level", {
		Text = "Select Sea Level",
		Values = {
			"Lv 1",
			"Lv 2",
			"Lv 3",
			"Lv 4",
			"Lv 5",
			"Lv 6",
			"Lv Infinite"
		},
		Default = 1,
		Callback = function(p264)
			_G.DangerSc = p264
		end
	})
end

do
	Q = GRP_SeaEvent_Choose_Sea_Event:AddToggle("Auto_Sail_Boat", {
		Text = "Auto Sail Boat",
		Default = false,
		Callback = function(p265)
			_G.SailBoats = p265
		end
	})
end

spawn(function()
	while wait() do
		if _G.SailBoats then
			pcall(function()
				local v1077 = CheckBoat()

				if not v1077 and (not CheckShark() or not _G.Shark) and (not CheckTerrorShark() or not _G.TerrorShark) and (not CheckFishCrew() or not _G.MobCrew) and (not CheckPiranha() or not _G.Piranha) and (not CheckEnemiesBoat() or not _G.FishBoat) and (not CheckSeaBeast() or not _G.SeaBeast1) and (not _G.PGB or not CheckPirateGrandBrigade()) and (not _G.HCM or not CheckHauntedCrew()) and (not _G.Leviathan1 or not CheckLeviathan()) then
					local cFrame = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

					ZyroxGoBuyBoat(cFrame)

					if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
						replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)

						return
					end
				elseif v1077 and (not CheckShark() or not _G.Shark) and (not CheckTerrorShark() or not _G.TerrorShark) and (not CheckFishCrew() or not _G.MobCrew) and (not CheckPiranha() or not _G.Piranha) then
					if (not CheckEnemiesBoat() or not _G.FishBoat) and (not CheckSeaBeast() or not _G.SeaBeast1) and (not _G.PGB or not CheckPirateGrandBrigade()) and (not _G.HCM or not CheckHauntedCrew()) and (not _G.Leviathan1 or not CheckLeviathan()) then
						if plr.Character.Humanoid.Sit == false then
							_tp(v1077.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							if _G.DangerSc == "Lv 1" then
								CFrameSelectedZone = CFrame.new(-21767.4765625, 30, 5815.41259765625)
							elseif _G.DangerSc == "Lv 2" then
								CFrameSelectedZone = CFrame.new(-26017.931640625, 30, 5657.8837890625)
							elseif _G.DangerSc == "Lv 3" then
								CFrameSelectedZone = CFrame.new(-29545.703125, 30, 6377.98974609375)
							elseif _G.DangerSc == "Lv 4" then
								CFrameSelectedZone = CFrame.new(-33609.7578125, 30, 7422.890625)
							elseif _G.DangerSc == "Lv 5" then
								CFrameSelectedZone = CFrame.new(-38480.42578125, 30, 10350.943359375)
							elseif _G.DangerSc == "Lv 6" then
								CFrameSelectedZone = CFrame.new(-32975.9921875, 30, 25963.7109375)
							elseif _G.DangerSc == "Lv Infinite" then
								CFrameSelectedZone = CFrame.new(-118834.515625, 31, 999920.0494155884)
							end

							wait()

							if (_G.FishBoat or not CheckEnemiesBoat()) and (_G.PGB or not CheckPirateGrandBrigade()) and (_G.TerrorShark or not CheckTerrorShark()) then
								_tp(CFrameSelectedZone)
							else
								_tp(CFrameSelectedZone * CFrame.new(0, 150, 0))
							end

							if _G.SailBoats == false or CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha or CheckSeaBeast() and _G.SeaBeast1 or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() then
								plr.Character.Humanoid.Sit = false
							else
								while plr.Character:WaitForChild("Humanoid").Sit ~= false do
									wait()

									if (_G.FishBoat or not CheckEnemiesBoat()) and (_G.PGB or not CheckPirateGrandBrigade()) and (_G.TerrorShark or not CheckTerrorShark()) then
										_tp(CFrameSelectedZone)
									else
										_tp(CFrameSelectedZone * CFrame.new(0, 150, 0))
									end

									if _G.SailBoats == false or CheckShark() and _G.Shark or CheckTerrorShark() and _G.TerrorShark or CheckFishCrew() and _G.MobCrew or CheckPiranha() and _G.Piranha or CheckSeaBeast() and _G.SeaBeast1 or CheckEnemiesBoat() and _G.FishBoat or _G.Leviathan1 and CheckLeviathan() or _G.HCM and CheckHauntedCrew() or _G.PGB and CheckPirateGrandBrigade() then
										break
									end
								end

								plr.Character.Humanoid.Sit = false
							end
						end
					end
				end
			end)
		end
	end
end)

do
	spawn(function()
		while wait(Sec) do
			pcall(function()
				for _, child in pairs(workspace.Boats:GetChildren()) do
					for _, descendant in pairs(child:GetDescendants()) do
						if descendant:IsA("BasePart") then
							if _G.SailBoats or _G.Prehis_Find or _G.FindMirage or _G.SailBoat_Hydra or _G.AutofindKitIs then
								descendant.CanCollide = false
							else
								descendant.CanCollide = true
							end
						end
					end
				end
			end)
		end
	end)
end

GRP_SeaEvent_Entity_Sea_Event = t15.SeaEvent:AddLeftGroupbox("Entity Sea Event")
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Shark", {
	Text = "Auto Shark",
	Default = false,
	Callback = function(p266)
		_G.Shark = p266
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Piranha", {
	Text = "Auto Piranha",
	Default = false,
	Callback = function(p267)
		_G.Piranha = p267
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Terror_Shark", {
	Text = "Auto Terror Shark",
	Default = false,
	Callback = function(p268)
		_G.TerrorShark = p268
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Fish_Crew_Member", {
	Text = "Auto Fish Crew Member",
	Default = false,
	Callback = function(p269)
		_G.MobCrew = p269
	end
})

do
	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Haunted_Crew_Member", {
		Text = "Auto Haunted Crew Member",
		Default = false,
		Callback = function(p270)
			_G.HCM = p270
		end
	})
end

GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_PirateGrandBrigade", {
	Text = "Auto Attack PirateGrandBrigade",
	Default = false,
	Callback = function(p271)
		_G.PGB = p271
	end
})
GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Fish_Boat", {
	Text = "Auto Attack Fish Boat",
	Default = false,
	Callback = function(p272)
		_G.FishBoat = p272
	end
})

do
	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Attack_Sea_Beast", {
		Text = "Auto Attack Sea Beast",
		Default = false,
		Callback = function(p273)
			_G.SeaBeast1 = p273
		end
	})
end

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Shark then
					local t41 = { "Shark" }

					if CheckShark() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if table.find(t41, child.Name) and t9.Alive(child) then
								while true do
									task.wait()
									t9.Kill(child, _G.Shark)

									if _G.Shark == false then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.TerrorShark then
					local t42 = { "Terrorshark" }

					if CheckTerrorShark() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if table.find(t42, child.Name) and t9.Alive(child) then
								while true do
									task.wait()
									t9.KillSea(child, _G.TerrorShark)

									if _G.TerrorShark == false then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.Piranha then
					local t43 = { "Piranha" }

					if CheckPiranha() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if table.find(t43, child.Name) and t9.Alive(child) then
								while true do
									task.wait()
									t9.Kill(child, _G.Piranha)

									if _G.Piranha == false then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.MobCrew then
					local t44 = { "Fish Crew Member" }

					if CheckFishCrew() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if table.find(t44, child.Name) and t9.Alive(child) then
								while true do
									task.wait()
									t9.Kill(child, _G.MobCrew)

									if _G.MobCrew == false then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.HCM then
					local t45 = { "Haunted Crew Member" }

					if CheckHauntedCrew() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if table.find(t45, child.Name) and t9.Alive(child) then
								while true do
									task.wait()
									t9.Kill(child, _G.HCM)

									if _G.HCM == false then
										break
									elseif not child.Parent or child.Humanoid.Health <= 0 then
										break
									end
								end
							end
						end
					end
				end

				if _G.SeaBeast1 then
					if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
						for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
							if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Health") and child.Health.Value > 0 then
								repeat
									task.wait()
									spawn(function()
										_tp(CFrame.new(child.HumanoidRootPart.Position.X, game:GetService("Workspace").Map["WaterBase-Plane"].Position.Y + 200, child.HumanoidRootPart.Position.Z))
									end)

									if plr:DistanceFromCharacter(child.HumanoidRootPart.CFrame.Position) <= 500 then
										AitSeaSkill_Custom = child.HumanoidRootPart.CFrame
										MousePos = AitSeaSkill_Custom.Position

										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(0.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(0.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(0.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.SeaBeast1 == false or not child:FindFirstChild("HumanoidRootPart") or not child.Parent or child.Health.Value <= 0
							end
						end
					end
				end


				if _G.FishBoat then
					if CheckEnemiesBoat() then
						for _, child in pairs(workspace.Enemies:GetChildren()) do
							if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
								repeat
									task.wait()
									spawn(function()
										if child.Name == "FishBoat" then
											_tp(child.Engine.CFrame * CFrame.new(0, -50, -25))
										end
									end)

									if plr:DistanceFromCharacter(child.Engine.CFrame.Position) <= 150 then
										AitSeaSkill_Custom = child.Engine.CFrame
										MousePos = AitSeaSkill_Custom.Position

										if CheckF() then
											weaponSc("Blox Fruit")
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
										else
											Useskills("Melee", "Z")
											Useskills("Melee", "X")
											Useskills("Melee", "C")
											wait(0.1)
											Useskills("Sword", "Z")
											Useskills("Sword", "X")
											wait(0.1)
											Useskills("Blox Fruit", "Z")
											Useskills("Blox Fruit", "X")
											Useskills("Blox Fruit", "C")
											wait(0.1)
											Useskills("Gun", "Z")
											Useskills("Gun", "X")
										end
									end
								until _G.FishBoat == false or not child:FindFirstChild("VehicleSeat") or child.Health.Value <= 0
							end
						end
					end
				end

				if _G.PGB and CheckPirateGrandBrigade() then
					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
							repeat
								task.wait()
								spawn(function()
									if child.Name == "PirateBrigade" then
										_tp(child.Engine.CFrame * CFrame.new(0, -30, -10))
									elseif child.Name == "PirateGrandBrigade" then
										_tp(child.Engine.CFrame * CFrame.new(0, -50, -50))
									end
								end)

								if plr:DistanceFromCharacter(child.Engine.CFrame.Position) <= 150 then
									AitSeaSkill_Custom = child.Engine.CFrame
									MousePos = AitSeaSkill_Custom.Position

									if CheckF() then
										weaponSc("Blox Fruit")
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
									else
										Useskills("Melee", "Z")
										Useskills("Melee", "X")
										Useskills("Melee", "C")
										wait(0.1)
										Useskills("Sword", "Z")
										Useskills("Sword", "X")
										wait(0.1)
										Useskills("Blox Fruit", "Z")
										Useskills("Blox Fruit", "X")
										Useskills("Blox Fruit", "C")
										wait(0.1)
										Useskills("Gun", "Z")
										Useskills("Gun", "X")
									end
								end
							until _G.PGB == false or not child:FindFirstChild("VehicleSeat") or child.Health.Value <= 0
						end
					end
				end
			end)
		end
	end)
end

-- ===== Dragonstorm kill aura para Sea Events (3nn) =====
do
	local L = replicated
	local t = plr

	-- Metodo antigo (3nn): mexia em upvalues do CombatController. O jogo mudou e ele parou de atirar; fica so como reserva.
	local legacyDragonStorm = function(E)
		local m = L:WaitForChild("Modules")
		local util, character = require(m.CombatUtil), t.Character
		local dragon = character and character:FindFirstChild("Dragonstorm")
		if not dragon or util:IsGunReloading(dragon) then
			return
		end
		local attackFn = getupvalues(require(L.Controllers.CombatController).Attack)[9]
		local I, _, o, V, N, y, P =
			debug.getupvalue(attackFn, 15),
			debug.getupvalue(attackFn, 13),
			debug.getupvalue(attackFn, 16),
			debug.getupvalue(attackFn, 17),
			debug.getupvalue(attackFn, 14),
			debug.getupvalue(attackFn, 12),
			debug.getupvalue(attackFn, 18)
		local Q = y * _
		local d = ((N * _ + y * I) % o * o + Q) % V
		N = math.floor(d / o)
		y = d - N * o
		P = P + 1
		debug.setupvalue(attackFn, 15, I)
		debug.setupvalue(attackFn, 13, _)
		debug.setupvalue(attackFn, 16, o)
		debug.setupvalue(attackFn, 17, V)
		debug.setupvalue(attackFn, 14, N)
		debug.setupvalue(attackFn, 12, y)
		debug.setupvalue(attackFn, 18, P)
		L.Remotes.Validator2:FireServer(math.floor(d / V * 16777215), P)
		m.Net:FindFirstChild("RE/ShootGunEvent"):FireServer(E.Position, { E })
	end

	-- Tiro automatico (metodo atual do Vxeze): acha a funcao de disparo do jogo (getgc), mira com ela e respeita
	-- recarga / superaquecimento da arma.
	local modules = L:WaitForChild("Modules")
	local UserInputService = game:GetService("UserInputService")
	local FastGun = {
		fn = nil,
		assist = nil,
		looked = 0,
		heat = {},
		last = {},
		data = {},
		ShootsPerTarget = { ["Dual Flintlock"] = 2 },
		input = {
			UserInputType = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) and Enum.UserInputType.Touch
				or Enum.UserInputType.MouseButton1,
			Position = Vector3.zero,
		},
	}

	local ResolveShootGun = function()
		if FastGun.fn then
			return FastGun.fn
		end
		if tick() - FastGun.looked < 3 then
			return nil
		end
		FastGun.looked = tick()
		if not getgc or not debug.getconstants then
			return nil
		end
		for _, fn in ipairs(getgc(false)) do
			if type(fn) == "function" and (not islclosure or islclosure(fn)) then
				local info = debug.getinfo(fn)
				if info and info.numparams == 2 then
					local ok, constants = pcall(debug.getconstants, fn)
					if ok and table.find(constants, "LocalShotsLeft") and table.find(constants, "LocalTotalShots") then
						FastGun.fn = fn
						break
					end
				end
			end
		end
		if FastGun.fn and getupvalues then
			for _, up in ipairs(getupvalues(FastGun.fn)) do
				if type(up) == "table" and type(rawget(up, "getTargetInfo")) == "function" then
					FastGun.assist = up
					break
				end
			end
		end
		return FastGun.fn
	end

	local GunData = function(name)
		local cached = FastGun.data[name]
		if cached then
			return cached
		end
		local ok, result = pcall(function()
			return require(modules.CombatUtil):GetWeaponData(name)
		end)
		cached = ok and type(result) == "table" and result or {}
		FastGun.data[name] = cached
		return cached
	end

	local AimPartOf = function(target)
		if typeof(target) == "Vector3" then
			return { CFrame = CFrame.new(target), Position = target }
		end
		if typeof(target) == "CFrame" then
			return { CFrame = target, Position = target.Position }
		end
		if typeof(target) ~= "Instance" then
			return nil
		end
		if target:IsA("BasePart") then
			return target
		end
		local part = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Hitbox") or target.PrimaryPart
		if part then
			return part
		end
		local ok, pivot = pcall(function()
			return target:GetPivot()
		end)
		return ok and { CFrame = pivot, Position = pivot.Position } or nil
	end

	local GunReady = function(tool, data)
		local now, cooldown = tick(), tonumber(data.Cooldown) or 0.2
		if data.ShootStyle == "Gatling" then
			local limit = (tonumber(data.OverheatLimit) or 3) - 0.1
			local state = FastGun.heat[tool.Name]
			if not state then
				state = { heat = 0, cooling = false, prev = now }
				FastGun.heat[tool.Name] = state
			end
			local dt = now - state.prev
			state.prev = now
			if state.cooling or dt > 0.4 then
				state.heat = math.max(state.heat - dt, 0)
				if state.heat <= 0 then
					state.cooling = false
				end
			else
				state.heat = state.heat + dt
				if state.heat >= limit then
					state.cooling = true
				end
			end
			if state.cooling then
				return false
			end
		else
			if not tool.Enabled or (tonumber(tool:GetAttribute("LocalShotsLeft")) or 1) < 1 then
				return false
			end
			if require(modules.CombatUtil):IsGunReloading(tool) then
				return false
			end
		end
		return now - (FastGun.last[tool.Name] or 0) >= cooldown
	end

	local GunCooling = function(name)
		local state = FastGun.heat[name]
		if not state or not state.cooling then
			return false
		end
		local dt = tick() - state.prev
		if state.heat - dt <= 0 then
			state.heat, state.cooling, state.prev = 0, false, tick()
			return false
		end
		return true
	end

	local ShootGunAt = function(target)
		local char = plr.Character
		local tool = char and char:FindFirstChildOfClass("Tool")
		if not tool or tool.ToolTip ~= "Gun" then
			return false
		end
		local shootFn, aimPart = ResolveShootGun(), AimPartOf(target)
		if not shootFn or not aimPart then
			return false
		end
		local data = GunData(tool.Name)
		if not GunReady(tool, data) then
			return false
		end
		local now, cooldown = tick(), tonumber(data.Cooldown) or 0.2
		local shots = FastGun.ShootsPerTarget[tool.Name] or 1
		if data.ShootStyle == "Gatling" then
			shots = math.clamp(math.floor((now - (FastGun.last[tool.Name] or 0)) / cooldown), 1, 3)
		end
		FastGun.last[tool.Name] = now
		local assist = FastGun.assist
		local original = assist and assist.getTargetInfo
		if assist then
			assist.getTargetInfo = function()
				return { Part = aimPart }
			end
		end
		local fired = 0
		for _ = 1, shots do
			if pcall(shootFn, tool, FastGun.input) then
				fired = fired + 1
			end
		end
		if assist then
			assist.getTargetInfo = original
		end
		return fired > 0
	end

	local SpamGunNamed = function(name, target)
		local char = plr.Character
		if not char or not target then
			return false
		end
		if GunCooling(name) then
			return false
		end
		if not char:FindFirstChild(name) then
			if plr.Backpack:FindFirstChild(name) then
				EquipWeapon(name)
			end
			return false
		end
		return ShootGunAt(target)
	end

	getgenv().SpamGunDragonStorm = function(part)
		if SpamGunNamed("Dragonstorm", part) then
			return true
		end
		-- sem a funcao de disparo do jogo (executor sem getgc / jogo mudou): metodo antigo + clique da propria arma
		if not FastGun.fn then
			if FastGun.looked > 0 and not FastGun.warned then
				FastGun.warned = true
				pcall(function()
					lib:Notify({ Title = "Dragonstorm", Description = "funcao de tiro do jogo nao encontrada (getgc/debug.getconstants); usando clique da arma", Duration = 6 })
				end)
			end
			pcall(legacyDragonStorm, part)
			local char = plr.Character
			local tool = char and char:FindFirstChild("Dragonstorm")
			if tool and tick() - (FastGun.lastActivate or 0) > 0.15 then
				FastGun.lastActivate = tick()
				pcall(function()
					tool:Activate()
				end)
			end
		end
		return false
	end

	-- 3nn: "Only Farm Boat and Fish and TerrorShark" (SeaBeast fica de fora)
	local seaNames = {
		Terrorshark = true,
		Shark = true,
		Piranha = true,
		FishBoat = true,
		PirateGrandBrigade = true,
		PirateBrigade = true,
		["Fish Crew Member"] = true,
		["Haunted Crew Member"] = true,
	}

	local gunTool = function()
		local found
		for _, container in ipairs({ plr.Character, plr.Backpack }) do
			if container then
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and tool.ToolTip == "Gun" then
						if tool.Name == "Dragonstorm" then
							return tool
						end
						found = found or tool
					end
				end
			end
		end
		return found
	end

	local shoot = function(target)
		local part = target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Engine")
		if not part then
			return
		end
		pcall(getgenv().SpamGunDragonStorm, part)
		if plr:DistanceFromCharacter(part.Position) < 400 and Useskills then
			pcall(Useskills, "Gun", "Z")
			pcall(Useskills, "Gun", "X")
		end
	end

	local lastLoad = 0
	local currentTarget, currentTargetAt = nil, 0
	-- embrulha t9.Kill / t9.KillSea: nos Sea Events usa a Gun (Dragonstorm) como arma e atira com o aura do 3nn
	for _, name in ipairs({ "Kill", "KillSea" }) do
		local original = t9[name]
		if original then
			t9[name] = function(target, flag, ...)
				if flag and _G.UseDragonstormSea and target and seaNames[target.Name] then
					currentTarget, currentTargetAt = target, tick()
					local gun = gunTool()
					if _G.AutoLoadDragonstorm and (not gun or gun.Name ~= "Dragonstorm") and tick() - lastLoad > 5 then
						lastLoad = tick()
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("LoadItem", "Dragonstorm")
						end)
					end
					local saved = _G.SelectWeapon
					if gun then
						_G.SelectWeapon = gun.Name
					end
					shoot(target) -- atira antes tambem: alguns Kill esperam ~1s e perderiam tiros
					local ok, err = pcall(original, target, flag, ...)
					_G.SelectWeapon = saved
					shoot(target)
					if not ok then
						error(err, 0)
					end
					return
				end
				return original(target, flag, ...)
			end
		end
	end

	-- Tiro continuo (como o Vxeze/3nn, que chamam a cada frame): o t9.Kill / t9.KillSea so rodam a cada ~2s (esperas
	-- internas), o que deixava a Dragonstorm quase sem atirar. Enquanto houver alvo de Sea Event, atira a cada frame.
	local lastSkill = 0
	task.spawn(function()
		while task.wait() do
			if _G.UseDragonstormSea and currentTarget and tick() - currentTargetAt < 4 then
				local target = currentTarget
				local part = target.Parent and (target:FindFirstChild("HumanoidRootPart") or target:FindFirstChild("Engine"))

				if part then
					pcall(function()
						MousePos = part.Position
						getgenv().AimPos = part.CFrame
						getgenv().SpamGunDragonStorm(part)

						if tick() - lastSkill > 0.4 and plr:DistanceFromCharacter(part.Position) < 400 and Useskills then
							lastSkill = tick()
							Useskills("Gun", "Z")
							Useskills("Gun", "X")
						end
					end)
				end
			end
		end
	end)

	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Use_Dragonstorm_For_Sea_Event", {
		Text = "Use Dragonstorm For Sea Event",
		Tooltip = "Only Farm Boat and Fish and TerrorShark",
		Default = false,
		Callback = function(value)
			_G.UseDragonstormSea = value
		end
	})

	GRP_SeaEvent_Entity_Sea_Event:AddToggle("Auto_Load_Dragonstorm_Sea", {
		Text = "Auto Load Dragonstorm (Inventory)",
		Tooltip = "Pega a Dragonstorm do inventario quando nao estiver na mao",
		Default = false,
		Callback = function(value)
			_G.AutoLoadDragonstorm = value
		end
	})
end

GRP_SeaEvent_Kitsune_Island_Event = t15.SeaEvent:AddLeftGroupbox("Kitsune Island / Event")

do
	local v1106 = GRP_SeaEvent_Kitsune_Island_Event:AddLabel("")

	spawn(function()
		while wait(0.2) do
			if not workspace.Map:FindFirstChild("KitsuneIsland") then
				if not workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") then
					v1106:SetText("Kitsune Island : False")

					continue
				end
			end

			v1106:SetText("Kitsune Island : True")
		end
	end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Find_Kitsune_Island", {
	Text = "Auto Find Kitsune Island",
	Default = false,
	Callback = function(p274)
		_G.AutofindKitIs = p274
	end
})
spawn(function()
	while wait() do
		if _G.AutofindKitIs then
			pcall(function()
				if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
					_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
				else
					local v1107 = CheckBoat()

					if v1107 then
						if plr.Character.Humanoid.Sit == false then
							_tp(v1107.VehicleSeat.CFrame * CFrame.new(0, 1, 0))
						else
							local cFrame = CFrame.new(-10000000, 31, 37016.25)

							while true do
								wait()

								if CheckEnemiesBoat() or CheckTerrorShark() or CheckPirateGrandBrigade() then
									_tp(CFrame.new(-10000000, 150, 37016.25))
								else
									_tp(CFrame.new(-10000000, 31, 37016.25))
								end

								if _G.AutofindKitIs then
									if not ((cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10) then
										if not (workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") or plr.Character.Humanoid.Sit == false) then
											continue
										end
									end
								end

								break
							end

							plr.Character.Humanoid.Sit = false
						end
					else
						local cFrame = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375)

						ZyroxGoBuyBoat(cFrame)

						if (cFrame.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 10 then
							replicated.Remotes.CommF_:InvokeServer("BuyBoat", _G.SelectedBoat)
						end
					end
				end
			end)
		end
	end
end)
GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Teleport_to_Shrine_Actived", {
	Text = "Auto Teleport to Shrine Actived",
	Default = false,
	Callback = function(p275)
		_G.tweenShrine = p275
	end
})
spawn(function()
	while wait(0.1) do
		if _G.tweenShrine then
			pcall(function()
				local KitsuneIsland = workspace.Map:FindFirstChild("KitsuneIsland") or game.Workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island")
				local ShrineActive = KitsuneIsland:FindFirstChild("ShrineActive")

				if ShrineActive then
					local next_ = next
					local descendants, v1114 = ShrineActive:GetDescendants()

					for _, v1 in next_, descendants, v1114 do
						if v1:IsA("BasePart") then
							if v1.Name:find("NeonShrinePart") then
								replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue"):FireServer()

								while true do
									wait()
									_tp(v1.CFrame * CFrame.new(0, 2, 0))

									if _G.tweenShrine == false then
										break
									elseif not KitsuneIsland then
										break
									end
								end
							end
						end
					end
				else
					_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
				end
			end)
		end
	end
end)

do
	GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Collect_Azure_Ember", {
		Text = "Auto Collect Azure Ember",
		Default = false,
		Callback = function(p276)
			_G.Collect_Ember = p276
		end
	})
end

do
	spawn(function()
		while wait(0.1) do
			if _G.Collect_Ember then
				local exitTo

				repeat
					pcall(function()
						if workspace:WaitForChild("AttachedAzureEmber") then
							notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)
						else
							if workspace:WaitForChild("EmberTemplate") then
								notween(workspace:WaitForChild("EmberTemplate"):FindFirstChild("Part").CFrame)

								return
							end

							_tp(workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island").CFrame * CFrame.new(0, 500, 0))
							replicated.Modules.Net["RF/KitsuneStatuePray"]:InvokeServer()
						end
					end)
					exitTo = nil

					while wait(0.1) do
						if _G.Collect_Ember then
							exitTo = 1

							break
						end
					end
				until exitTo ~= 1

				return
			end
		end
	end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddToggle("Auto_Trade_Azure_Ember", {
	Text = "Auto Trade Azure Ember",
	Default = false,
	Callback = function(p277)
		_G.Trade_Ember = p277
	end
})

do
	spawn(function()
		while wait(0.1) do
			if _G.Trade_Ember then
				pcall(function()
					if workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island", true) then
						replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray"):InvokeServer()
					end
				end)
			end
		end
	end)
end

GRP_SeaEvent_Kitsune_Island_Event:AddButton({
	Text = "Trade Items Azure",
	Func = function()
		if replicated.Modules and replicated.Modules.Net then
			local RFKitsuneStatuePray = replicated.Modules.Net:FindFirstChild("RF/KitsuneStatuePray")

			if RFKitsuneStatuePray then
				RFKitsuneStatuePray:InvokeServer()
			end
		end
	end
})
GRP_SeaEvent_Kitsune_Island_Event:AddButton({
	Text = "Talk with kitsune statue",
	Func = function()
		if replicated.Modules and replicated.Modules.Net then
			local RETouchKitsuneStatue = replicated.Modules.Net:FindFirstChild("RE/TouchKitsuneStatue")

			if RETouchKitsuneStatue then
				RETouchKitsuneStatue:FireServer()
			end
		end
	end
})
-- === 3nn Leviathan compatibility layer ===
local Levi3nnBusy = false

local function NoclipBoat(boat)
    for _, part in ipairs(boat:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end

local function ZyroxLeviBoat()
    local boat = CheckBoat and CheckBoat()
    if boat and boat:FindFirstChild("VehicleSeat") then return boat end
    return nil
end

local function ZyroxBoatTurnAngle(boat, target)
    if not boat or not boat.PrimaryPart then return 0 end
    local pos = boat.PrimaryPart.Position
    local forward = (boat.PrimaryPart.CFrame.LookVector * Vector3.new(1,0,1)).Unit
    local dir = ((target - pos) * Vector3.new(1,0,1)).Unit
    local dot = math.clamp(forward:Dot(dir), -1, 1)
    local cross = forward:Cross(dir)
    local deg = math.deg(math.acos(dot))
    return cross.Y < 0 and -deg or deg
end

local function ZyroxBoatFace(boat, target)
    if not boat or not boat.PrimaryPart then return end
    local p = boat.PrimaryPart.Position
    boat:SetPrimaryPartCFrame(CFrame.lookAt(p, Vector3.new(target.X, p.Y, target.Z)))
end

local TikiRoute3nn = {
    Vector3.new(7415.83251953125, 24.0008487701416, -6664.6826171875),
    Vector3.new(-4703.16015625, 24.000019073486328, -7.822202682495117),
    Vector3.new(-8762.3310546875, 23.99974822998047, -452.2586669921875),
    Vector3.new(-15018.0634765625, 23.999053955078125, 199.0315399169922),
    Vector3.new(-16065.728515625, 23.9991512298584, 421.8982238769531),
}
local HydraRoute3nn = {
    Vector3.new(7415.83251953125, 24.0008487701416, -6664.6826171875),
    Vector3.new(1162.8353271484375, 24.00018882751465, -1825.8121337890625),
    Vector3.new(2517.887451171875, 24.000118255615234, 5109.43115234375),
    Vector3.new(5172.72607421875, 23.999813079833984, 3893.62451171875),
    Vector3.new(5203.80908203125, 24.001039505004883, 2013.0904541015625),
}

local function DriveBoat3nn(route, key)
    for _, target in ipairs(route) do
        while _G[key] and task.wait(0.05) do
            local boat = ZyroxLeviBoat()
            if not boat then return end
            local root = boat.PrimaryPart or boat:FindFirstChild("VehicleSeat")
            if not root then return end
            if (root.Position - target).Magnitude < 10 then
                root.ThrottleFloat = 0
                root.Throttle = 0
                break
            end
            pcall(function()
                boat.VehicleSeat.MaxSpeed = _G.LevSpeed3nn or 300
                if NoclipBoat then NoclipBoat(boat) end
            end)
            local angle = ZyroxBoatTurnAngle(boat, target)
            if math.abs(angle) > 5 then
                ZyroxBoatFace(boat, target)
                root.ThrottleFloat = 0
                root.Throttle = 0
            else
                root.ThrottleFloat = 1
                root.Throttle = 1
            end
        end
    end
    return true
end

local function FindLeviathan3nn()
    local sb = workspace:FindFirstChild("SeaBeasts")
    if not sb then return nil end
    local function valid(x)
        local hp=x:FindFirstChild("Health")
        return x:IsA("Model") and x:FindFirstChild("HumanoidRootPart") and hp and hp.Value>0
    end
    for _, x in ipairs(sb:GetChildren()) do
        if x.Name == "Leviathan Segment" and x:GetAttribute("SegmentId") and valid(x) then return x end
    end
    for _, x in ipairs(sb:GetChildren()) do
        if x.Name == "Leviathan" and not x:GetAttribute("Armored") and valid(x) then return x end
    end
    return nil
end

local function AutoStartLeviathan3nn()
    if not workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then return end
    local npc
    for _, container in ipairs({workspace:FindFirstChild("NPCs"), game.ReplicatedStorage:FindFirstChild("NPCs")}) do
        if container then
            for _, x in ipairs(container:GetChildren()) do
                if x.Name == "Frozen Watcher" and x:FindFirstChild("HumanoidRootPart") then npc=x end
            end
        end
    end
    if npc then
        if plr:DistanceFromCharacter(npc.HumanoidRootPart.Position) < 8 then
            replicated.Remotes.CommF_:InvokeServer("OpenLeviathanGate")
        else
            TeleportToTarget(npc.HumanoidRootPart.CFrame)
        end
    end
end

local LeviDamageBaseline3nn = setmetatable({}, { __mode = "k" })
local function AutoAttackLeviathan3nn()
    local sb = workspace:FindFirstChild("SeaBeasts")
    if not sb then return end
    local target
    local threshold = tonumber(_G.LeviDamage3nn) or 30000
    if _G.AttackMultiLeviathan3nn then
        for _, id in ipairs({2, 3, 4}) do
            for _, part in ipairs(sb:GetChildren()) do
                local hp = part:FindFirstChild("Health")
                if part.Name == "Leviathan Segment" and part:GetAttribute("SegmentId") == id
                    and part:FindFirstChild("HumanoidRootPart") and hp and hp.Value > 0 then
                    if LeviDamageBaseline3nn[part] == nil then LeviDamageBaseline3nn[part] = hp.Value end
                    local dealt = math.max(0, LeviDamageBaseline3nn[part] - hp.Value)
                    if dealt < threshold then target = part; break end
                end
            end
            if target then break end
        end
    end
    if not target then
        for _, part in ipairs(sb:GetChildren()) do
            local hp = part:FindFirstChild("Health")
            if (part.Name == "Leviathan" or part.Name == "Leviathan Tail" or part.Name == "Leviathan Segment")
                and part:FindFirstChild("HumanoidRootPart") and hp and hp.Value > 0
                and (part.Name ~= "Leviathan" or not part:GetAttribute("Armored")) then
                target = part
                break
            end
        end
    end
    if not target or not _G.Leviathan1 then return end
    local hrp = target:FindFirstChild("HumanoidRootPart")
    local hp = target:FindFirstChild("Health")
    if not hrp or not hp or hp.Value <= 0 then return end
    local y = target.Name == "Leviathan" and 140 or 142
    pcall(function() TeleportToTarget(CFrame.new(hrp.Position.X, y, hrp.Position.Z)) end)
    local hitbox = target:FindFirstChild("Hitbox11")
    MousePos = hitbox and hitbox.Position or hrp.Position
    pcall(function()
        if _G.UseFruitLevi3nn and getgenv().ClickM1 then
            weaponSc("Blox Fruit")
            getgenv().ClickM1()
        elseif _G.UseSkullLevi3nn then
            weaponSc("Gun")
            Useskills("Gun", "Z"); Useskills("Gun", "X")
        elseif CheckF and CheckF() then
            weaponSc("Blox Fruit")
            Useskills("Blox Fruit", "Z"); Useskills("Blox Fruit", "X"); Useskills("Blox Fruit", "C")
        else
            Useskills("Melee", "Z"); Useskills("Melee", "X"); Useskills("Melee", "C")
            task.wait(0.1)
            Useskills("Sword", "Z"); Useskills("Sword", "X")
            task.wait(0.1)
            Useskills("Blox Fruit", "Z"); Useskills("Blox Fruit", "X"); Useskills("Blox Fruit", "C")
            task.wait(0.1)
            Useskills("Gun", "Z"); Useskills("Gun", "X")
        end
    end)
end

local function AutoFireHeart3nn()
    local heart=workspace.Map:FindFirstChild("FrozenHeart")
    if not heart or not heart:FindFirstChild("Inside") or heart.Inside:GetAttribute("Harpooned") then return end
    local boat=ZyroxLeviBoat()
    if not boat or not boat:FindFirstChild("Harpoon") or not boat:FindFirstChild("VehicleSeat") then return end
    local cube=heart:FindFirstChild("Cube")
    if not cube then return end
    local target=CFrame.new(cube.Position.X, boat.VehicleSeat.Position.Y, cube.Position.Z) * CFrame.new(0,0,300)
    if (boat.VehicleSeat.Position-target.Position).Magnitude>5 then
        if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.SeatPart then
            NoclipBoat(boat)
            local seat=boat.VehicleSeat
            local tw=game:GetService("TweenService"):Create(seat,TweenInfo.new((seat.Position-target.Position).Magnitude/150,Enum.EasingStyle.Quad),{CFrame=target})
            tw:Play()
            tw.Completed:Wait()
            task.wait(1)
            ZyroxBoatFace(boat, heart.Inside.Position)
        else
            TeleportToTarget(boat.VehicleSeat.CFrame)
        end
    elseif plr.Character.Humanoid.SeatPart and plr.Character.Humanoid.SeatPart.Parent and plr.Character.Humanoid.SeatPart.Parent.Name=="Harpoon" then
        ZyroxBoatFace(boat, heart.Inside.Position)
        replicated.Remotes.CommF_:InvokeServer("FireHarpoon",0.7853981633974483,4.4342573293783646E-4,boat.Harpoon,workspace:GetServerTimeNow())
    else
        TeleportToTarget(boat.Harpoon.Seat.CFrame)
    end
end

GRP_SeaEvent_Frozen_Dimension_Event = t15.SeaEvent:AddLeftGroupbox("Frozen Dimension Event")
local LeviInfoCache3nn = { t = 0, v = nil }
local function LeviInfo3nn(force)
    if force or tick() - LeviInfoCache3nn.t > 2 then
        LeviInfoCache3nn.v = replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
        LeviInfoCache3nn.t = tick()
    end
    return LeviInfoCache3nn.v
end

local LeviFrozenLabel = GRP_SeaEvent_Frozen_Dimension_Event:AddLabel("")
local LeviSpyLabel = GRP_SeaEvent_Frozen_Dimension_Event:AddLabel("")

task.spawn(function()
    while task.wait(0.2) do
        pcall(function()
            LeviFrozenLabel:SetText("Frozen Dimension : " .. tostring(workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") ~= nil))
            local v=tonumber(LeviInfo3nn())
            if v then LeviSpyLabel:SetText(v==5 and "Spy Leviathan : Already Done!!" or (v<0 and "Spy Leviathan : Not bought" or "Spy Leviathan : "..v)) end
        end)
    end
end)

GRP_SeaEvent_Frozen_Dimension_Event:AddButton({Text="Buy Spy",Func=function()
    replicated.Remotes.CommF_:InvokeServer("InfoLeviathan","2")
end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Buy_Spy_3NN",{Text="Auto Buy Spy",Default=false,Callback=function(v) _G.AutoBuySpy3nn=v end})
task.spawn(function()
    while task.wait(5) do
        if _G.AutoBuySpy3nn then
            pcall(function()
                local status = LeviInfo3nn(true)
                if status ~= -1 and tonumber(status) ~= 5 then
                    replicated.Remotes.CommF_:InvokeServer("InfoLeviathan", "2")
                end
            end)
        end
    end
end)

GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Buy_Beast_Hunter_3NN",{Text="Auto Buy Boat Beast Hunter",Default=false,Callback=function(v) _G.AutoBuyBeastHunter3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Teleport_Frozen_Dimension",{Text="Auto Teleport Frozen Dimension",Default=false,Callback=function(v) _G.FrozenTP=v end})
local function FindFrozenWatcher3nn()
    for _, container in ipairs({workspace:FindFirstChild("NPCs"), replicated:FindFirstChild("NPCs")}) do
        if container then
            local npc = container:FindFirstChild("Frozen Watcher")
            if npc and npc:FindFirstChild("HumanoidRootPart") then return npc end
        end
    end
end
task.spawn(function()
    while task.wait(0.1) do
        if _G.FrozenTP then
            pcall(function()
                if workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
                    local npc = FindFrozenWatcher3nn()
                    if npc then TeleportToTarget(npc.HumanoidRootPart.CFrame) end
                end
            end)
        end
    end
end)

local LeviBoatOwners3nn = {}
for _, player in ipairs(game:GetService("Players"):GetPlayers()) do table.insert(LeviBoatOwners3nn, player.Name) end
_G.SelectedOwnerBoatFindLeviathan3nn = _G.SelectedOwnerBoatFindLeviathan3nn or plr.Name
LeviBoatOwnerDropdown3nn = GRP_SeaEvent_Frozen_Dimension_Event:AddDropdown("Select_Owner_Boat_Find_Leviathan_3NN", {
    Text = "Select Owner Boat Find Leviathan", Values = LeviBoatOwners3nn,
    Default = _G.SelectedOwnerBoatFindLeviathan3nn,
    Callback = function(v) _G.SelectedOwnerBoatFindLeviathan3nn = v end
})
GRP_SeaEvent_Frozen_Dimension_Event:AddButton({Text="Refresh Boat Owners", Func=function()
    LeviBoatOwners3nn = {}
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do table.insert(LeviBoatOwners3nn, player.Name) end
    pcall(function() LeviBoatOwnerDropdown3nn:SetValues(LeviBoatOwners3nn) end)
end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Multi_Find_Leviathan_3NN",{Text="Multi Find Leviathan",Default=false,Callback=function(v) _G.MultiFindLeviathan3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Find_Leviathan_3NN",{Text="Auto Find Leviathan",Default=false,Callback=function(v) _G.AutoFindLeviathan3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Start_Leviathan_3NN",{Text="Auto Start Leviathan",Default=false,Callback=function(v) _G.AutoStartLeviathan3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Destroy_IDK_3NN",{Text="Auto Destroy IDK",Default=false,Callback=function(v) _G.AutoDestroyIDK3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Attack_Leviathan",{Text="Auto Attack Leviathan",Default=false,Callback=function(v) _G.Leviathan1=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Attack_Multi_Segments_Leviathan_3NN",{Text="Attack Multi Segments Leviathan",Default=false,Callback=function(v) _G.AttackMultiLeviathan3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddSlider("Value_Damage_Multi_Segments_Leviathan_3NN",{Text="Value Damage Multi Segments",Min=0,Max=1000000,Default=30000,Rounding=0,Callback=function(v) _G.LeviDamage3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Auto_Fire_Shoot_Heart_Leviathan_3NN",{Text="Auto Fire Shoot Heart Leviathan",Default=false,Callback=function(v) _G.AutoFireHeart3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Use_Click_M1_Fruit_Leviathan_3NN",{Text="Use Click M1 Fruit Leviathan",Default=false,Callback=function(v) _G.UseFruitLevi3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Use_Click_M1_Skull_Guitar_Leviathan_3NN",{Text="Use Click M1 Skull Guitar Leviathan",Default=false,Callback=function(v) _G.UseSkullLevi3nn=v end})
GRP_SeaEvent_Frozen_Dimension_Event:AddSlider("Speed_Boat_Auto_Drive_3NN",{Text="Speed Boat Auto Drive",Min=0,Max=500,Default=300,Rounding=0,Callback=function(v) _G.LevSpeed3nn=v end})
DriveTikiToggle3nn = GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Drive_Boat_To_Tiki_3NN",{Text="Drive Boat To Tiki",Default=false,Callback=function(v) _G.DriveTiki3nn=v end})
DriveHydraToggle3nn = GRP_SeaEvent_Frozen_Dimension_Event:AddToggle("Drive_Boat_To_Hydra_3NN",{Text="Drive Boat To Hydra",Default=false,Callback=function(v) _G.DriveHydra3nn=v end})

local function ZyroxStatusCheckLeviathan3nn()
    local result = LeviInfo3nn()
    if result == -1 then return "I DONT KNOW" end
    if tonumber(result) == 5 then return "You can find leviathan now" end
    return "Buy Find leviathan"
end

-- 3nn-style background workers

task.spawn(function() while task.wait(0.2) do
    if _G.AutoFindLeviathan3nn then pcall(function()
        if not workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
            local boat=ZyroxLeviBoat()
            if boat then ZyroxBoatWasAlive = true end
            if not boat then
                if _G.AutoBuyBeastHunter3nn then
                    local buy=CFrame.new(-16204.0810546875,9.0863618850708,479.2259521484375)
                    if (buy.Position-plr.Character.HumanoidRootPart.Position).Magnitude>10 then ZyroxGoBuyBoat(buy)
                    else replicated.Remotes.CommF_:InvokeServer("BuyBoat","Beast Hunter"); task.wait(3) end
                end
            elseif plr.Character.Humanoid.Sit then
                if _G.AutoDestroyIDK3nn and Levi3nnBusy then return end
                local seat=boat.VehicleSeat
                local pos=seat.Position
                local dir=Vector3.new(-118834.515625-pos.X,0,99999920-pos.Z).Unit
                local step=350*0.2 -- ~350 studs/s (como o tween do 3nn), laco de 0.2s
                local newPos=Vector3.new(pos.X+dir.X*step,160,pos.Z+dir.Z*step)
                seat.CFrame=CFrame.lookAt(newPos,newPos+dir)
                NoclipBoat(boat)
            else TeleportToTarget(boat.VehicleSeat.CFrame) end
        end
    end) end
end end)

task.spawn(function()
    while task.wait(0.15) do
        if _G.MultiFindLeviathan3nn then
            pcall(function()
                local selected = _G.SelectedOwnerBoatFindLeviathan3nn
                for _, boat in ipairs(workspace.Boats:GetChildren()) do
                    local owner = boat:FindFirstChild("Owner")
                    local health = boat:FindFirstChild("Humanoid")
                    if boat:IsA("Model") and owner and tostring(owner.Value) == tostring(selected) and (not health or health.Value > 0) then
                        for _, item in ipairs(boat:GetChildren()) do
                            if item.Name == "Cannon" and item:FindFirstChild("Seat") and not item.Seat:FindFirstChild("SeatWeld") then
                                if not (plr.Character and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character.Humanoid.Sit) then
                                    TeleportToTarget(item.Seat.CFrame)
                                end
                                return
                            end
                        end
                    end
                end
            end)
        end
    end
end)
task.spawn(function() while task.wait(2.5) do if _G.AutoStartLeviathan3nn then pcall(AutoStartLeviathan3nn) end end end)
local LeviIDKNames3nn = { FishBoat = true, PirateBrigade = true, PirateGrandBrigade = true, Terrorshark = true, TerrorShark = true, Shark = true, Piranha = true }
task.spawn(function()
    while task.wait(0.12) do
        if _G.AutoDestroyIDK3nn then
            pcall(function()
                if ZyroxStatusCheckLeviathan3nn() ~= "I DONT KNOW" then
                    Levi3nnBusy = false
                    return
                end
                local function pick(container, onlyNames)
                    for _, candidate in ipairs(container:GetChildren()) do
                        if not onlyNames or LeviIDKNames3nn[candidate.Name] then
                            local hum = candidate:FindFirstChildOfClass("Humanoid")
                            local hp = candidate:FindFirstChild("Health")
                            local part = candidate:FindFirstChild("HumanoidRootPart") or candidate:FindFirstChild("Engine")
                            if part and ((hum and hum.Health > 0) or (hp and hp.Value > 0)) then
                                return candidate, part
                            end
                        end
                    end
                end
                local target, root = pick(workspace.SeaBeasts, false)
                if not target then target, root = pick(workspace.Enemies, true) end
                Levi3nnBusy = target ~= nil
                if target and root then
                    MousePos = root.Position
                    if plr:DistanceFromCharacter(root.Position) < 500 then
                        if getgenv().ClickM1 then pcall(getgenv().ClickM1) end
                        if Useskills then
                            Useskills("Melee","Z"); Useskills("Melee","X"); Useskills("Melee","C")
                            Useskills("Sword","Z"); Useskills("Sword","X")
                            Useskills("Blox Fruit","Z"); Useskills("Blox Fruit","X"); Useskills("Blox Fruit","C")
                            Useskills("Gun","Z"); Useskills("Gun","X")
                        end
                    else
                        pcall(function() TeleportToTarget(CFrame.new(root.Position.X, root.Position.Y + 50, root.Position.Z)) end)
                    end
                end
            end)
        else
            Levi3nnBusy = false
        end
    end
end)

-- baixa o barco para o nivel do mar quando a Frozen Dimension aparece (como o 3nn)
task.spawn(function()
    local lowered = false
    while task.wait(1) do
        pcall(function()
            local exists = workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") ~= nil
            if exists and not lowered and _G.AutoFindLeviathan3nn then
                local boat = ZyroxLeviBoat()
                if boat and boat.VehicleSeat.Position.Y > 60 then
                    local p = boat.VehicleSeat.Position
                    boat.VehicleSeat.CFrame = CFrame.new(p.X, 24, p.Z)
                end
                lowered = true
            elseif not exists then
                lowered = false
            end
        end)
    end
end)
task.spawn(function() while task.wait(0.1) do if _G.Leviathan1 then pcall(AutoAttackLeviathan3nn) end end end)
task.spawn(function() while task.wait(0.1) do if _G.AutoFireHeart3nn then pcall(AutoFireHeart3nn) end end end)
task.spawn(function() while task.wait(0.05) do
    if _G.DriveTiki3nn then
        local ok, done = pcall(DriveBoat3nn, TikiRoute3nn, "DriveTiki3nn")
        if ok and done then
            _G.DriveTiki3nn = false
            pcall(function() DriveTikiToggle3nn:SetValue(false) end)
        end
    end
    if _G.DriveHydra3nn then
        local ok, done = pcall(DriveBoat3nn, HydraRoute3nn, "DriveHydra3nn")
        if ok and done then
            _G.DriveHydra3nn = false
            pcall(function() DriveHydraToggle3nn:SetValue(false) end)
        end
    end
end end)

GRP_Esp_Esp = t15.Esp:AddLeftGroupbox("Esp")
isnil = function(p281)
	return p281 == nil
end

local function v1125(p282)
	return math.floor(tonumber(p282) + 0.5)
end

Number = math.random(1, 1000000)

local LocalPlayer = game:GetService("Players").LocalPlayer
local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
local Team = LocalPlayer.Team

EspPly = function()
	local children, v1130 = game.Players:GetChildren()

	for _, v1 in next, children, v1130 do
		pcall(function()
			if not isnil(v1.Character) then
				if PlayerEsp then
					local ok = isnil(v1.Character.Head)

					if not ok then
						ok = v1.Character.Head:FindFirstChild("NameEsp" .. Number)
					end

					if ok then
						if v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
							v1.Character.Head["NameEsp" .. Number].TextLabel.Text = v1.Name .. " | " .. v1125((LocalPlayer.Character.Head.Position - v1.Character.Head.Position).Magnitude / 3) .. " M\nHealth : " .. v1125(v1.Character.Humanoid.Health * 100 / v1.Character.Humanoid.MaxHealth) .. "%"
						end
					else
						local BillboardGui = Instance.new("BillboardGui", v1.Character.Head)

						BillboardGui.Name = "NameEsp" .. Number
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = v1.Character.Head
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = Enum.Font.Code
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Text = v1.Name .. " \n" .. v1125((LocalPlayer.Character.Head.Position - v1.Character.Head.Position).Magnitude / 3) .. " M"
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5

						if v1.Team == Team then
							TextLabel.TextColor3 = Color3.new(0, 0, 254)
						else
							TextLabel.TextColor3 = Color3.new(255, 0, 0)
						end
					end
				elseif v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
					v1.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
				end
			end
		end)
	end
end
LocationEsp = function()
	local children, v1137 = workspace._WorldOrigin.Locations:GetChildren()

	for _, v1 in next, children, v1137 do
		pcall(function()
			if not IslandESP then
				if v1:FindFirstChild("NameEsp") then
					v1:FindFirstChild("NameEsp"):Destroy()
				end
			elseif v1.Name ~= "Sea" then
				if v1:FindFirstChild("NameEsp") then
					v1.NameEsp.TextLabel.Text = v1.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - v1.Position).Magnitude / 3) .. " M"
				else
					local BillboardGui = Instance.new("BillboardGui", v1)

					BillboardGui.Name = "NameEsp"
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = v1
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = Enum.Font.Code
					TextLabel.FontSize = "Size14"
					TextLabel.TextWrapped = true
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.TextYAlignment = "Top"
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.TextColor3 = Color3.fromRGB(98, 252, 252)
					TextLabel.Text = v1.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - v1.Position).Magnitude / 3) .. " M"
				end
			end
		end)
	end
end
DevEsp = function()
	local children, v1143 = workspace:GetChildren()

	for _, v1 in next, children, v1143 do
		pcall(function()
			if not DevilFruitESP then
				if v1:FindFirstChild("Handle") then
					if v1.Handle:FindFirstChild("NameEsp" .. Number) then
						v1.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
					end
				end
			elseif string.find(v1.Name, "Fruit") then
				if v1.Handle:FindFirstChild("NameEsp" .. Number) then
					v1.Handle["NameEsp" .. Number].TextLabel.Text = "[" .. v1.Name .. "]" .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - v1.Handle.Position).Magnitude / 3) .. " M"
				else
					local BillboardGui = Instance.new("BillboardGui", v1.Handle)

					BillboardGui.Name = "NameEsp" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = v1.Handle
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = Enum.Font.Code
					TextLabel.FontSize = "Size14"
					TextLabel.TextWrapped = true
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.TextYAlignment = "Top"
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					TextLabel.Text = v1.Name .. " \n" .. v1125((LocalPlayer.Character.Head.Position - v1.Handle.Position).Magnitude / 3) .. " M"
				end
			end
		end)
	end
end
flowerEsp = function()
	for _, child in pairs(workspace:GetChildren()) do
		pcall(function()
			if child.Name == "Flower2" or child.Name == "Flower1" then
				if not FlowerESP then
					if child:FindFirstChild("NameEsp" .. Number) then
						child:FindFirstChild("NameEsp" .. Number):Destroy()
					end
				elseif child:FindFirstChild("NameEsp" .. Number) then
					child["NameEsp" .. Number].TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
				else
					local BillboardGui = Instance.new("BillboardGui", child)

					BillboardGui.Name = "NameEsp" .. Number
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = Enum.Font.Code
					TextLabel.FontSize = "Size14"
					TextLabel.TextWrapped = true
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.TextYAlignment = "Top"
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.TextColor3 = Color3.fromRGB(88, 214, 252)

					if child.Name == "Flower1" then
						TextLabel.Text = "Blue Flower" .. " \n" .. v1125((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
					elseif child.Name == "Flower2" then
						TextLabel.Text = "Red Flower" .. " \n" .. v1125((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end)
	end
end
EventIslandEsp = function()
	for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
		pcall(function()
			if not EspEventIsland then
				if child:FindFirstChild("NameEsp") then
					child:FindFirstChild("NameEsp"):Destroy()
				end
			elseif child.Name == "Mirage Island" or child.Name == "Prehistoric Island" or child.Name == "Kitsune Island" then
				if child:FindFirstChild("NameEsp") then
					child.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
				else
					local BillboardGui = Instance.new("BillboardGui", child)

					BillboardGui.Name = "NameEsp"
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = child
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "Code"
					TextLabel.FontSize = "Size14"
					TextLabel.TextWrapped = true
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.TextYAlignment = "Top"
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
					TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.Position).Magnitude / 3) .. " M"
				end
			end
		end)
	end
end
gearEsp = function()
	local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

	for _, descendant in pairs(MysticIsland:GetDescendants()) do
		pcall(function()
			if not ESPGear then
				if descendant:FindFirstChild("NameEsp") then
					descendant:FindFirstChild("NameEsp"):Destroy()
				end
			elseif descendant.Name == "Part" and descendant.Material == Enum.Material.Neon then
				if descendant:FindFirstChild("NameEsp") then
					descendant.NameEsp.TextLabel.Text = "Gear" .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - descendant.Position).Magnitude / 3) .. " M"
				else
					local BillboardGui = Instance.new("BillboardGui", descendant)

					BillboardGui.Name = "NameEsp"
					BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
					BillboardGui.Size = UDim2.new(1, 200, 1, 30)
					BillboardGui.Adornee = descendant
					BillboardGui.AlwaysOnTop = true

					local TextLabel = Instance.new("TextLabel", BillboardGui)

					TextLabel.Font = "Code"
					TextLabel.FontSize = "Size14"
					TextLabel.TextWrapped = true
					TextLabel.Size = UDim2.new(1, 0, 1, 0)
					TextLabel.TextYAlignment = "Top"
					TextLabel.BackgroundTransparency = 1
					TextLabel.TextStrokeTransparency = 0.5
					TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
					TextLabel.Text = "Gear" .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - descendant.Position).Magnitude / 3) .. " M"
				end
			end
		end)
	end
end
AdvanFruitEsp = function()
	if advanEsp then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Advanced Fruit Dealer" then
				if not workspace:FindFirstChild("Adv") then
					Adv = Instance.new("Part")
					Adv.Name = "Adv"
					Adv.Transparency = 1
					Adv.Size = Vector3.new(1, 1, 1)
					Adv.Anchored = true
					Adv.CanCollide = false
					Adv.Parent = workspace
					Adv.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Adv") then
					if Adv:FindFirstChild("NameEsp") then
						Adv.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Adv)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Adv
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Adv") then
		workspace:FindFirstChild("Adv"):Destroy()
	end
end
HakiClorEsp = function()
	if ColorEsp then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Barista Cousin" then
				if not workspace:FindFirstChild("Gay") then
					Gay = Instance.new("Part")
					Gay.Name = "Gay"
					Gay.Transparency = 1
					Gay.Size = Vector3.new(1, 1, 1)
					Gay.Anchored = true
					Gay.CanCollide = false
					Gay.Parent = workspace
					Gay.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Gay") then
					if Gay:FindFirstChild("NameEsp") then
						Gay.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Gay)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Gay
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Gay") then
		workspace:FindFirstChild("Gay"):Destroy()
	end
end
LegenSword = function()
	if LegenS then
		for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
			if child.Name == "Legendary Sword Dealer" then
				if not workspace:FindFirstChild("Lgd") then
					Lgd = Instance.new("Part")
					Lgd.Name = "Lgd"
					Lgd.Transparency = 1
					Lgd.Size = Vector3.new(1, 1, 1)
					Lgd.Anchored = true
					Lgd.CanCollide = false
					Lgd.Parent = workspace
					Lgd.CFrame = child.HumanoidRootPart.CFrame
				elseif workspace:FindFirstChild("Lgd") then
					if Lgd:FindFirstChild("NameEsp") then
						Lgd.NameEsp.TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					else
						local BillboardGui = Instance.new("BillboardGui", Lgd)

						BillboardGui.Name = "NameEsp"
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.Size = UDim2.new(1, 200, 1, 30)
						BillboardGui.Adornee = Lgd
						BillboardGui.AlwaysOnTop = true

						local TextLabel = Instance.new("TextLabel", BillboardGui)

						TextLabel.Font = "Code"
						TextLabel.FontSize = "Size14"
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = "Top"
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Text = child.Name .. "   \n" .. v1125((LocalPlayer.Character.Head.Position - child.HumanoidRootPart.Position).Magnitude / 3) .. " M"
					end
				end
			end
		end
	elseif workspace:FindFirstChild("Lgd") then
		workspace:FindFirstChild("Lgd"):Destroy()
	end
end

do
	ChestEsp = function()
		if ChestESP then
			local tagged = game:GetService("CollectionService"):GetTagged("_ChestTagged")

			for _, v1 in ipairs(tagged) do
				pcall(function()
					local Magnitude = (v1:GetPivot().Position - LocalPlayer.Character.Head.Position).Magnitude

					v1:GetFullName():gsub("[^%w_]", "_")

					local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

					if not ChestEspAttachment then
						local Attachment = Instance.new("Attachment")

						Attachment.Name = "ChestEspAttachment"
						Attachment.Parent = v1
						Attachment.Position = Vector3.new(0, 3, 0)

						local BillboardGui = Instance.new("BillboardGui")

						BillboardGui.Name = "NameEsp"
						BillboardGui.Size = UDim2.new(0, 200, 0, 30)
						BillboardGui.Adornee = Attachment
						BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
						BillboardGui.AlwaysOnTop = true
						BillboardGui.Parent = Attachment

						local TextLabel = Instance.new("TextLabel")

						TextLabel.Font = Enum.Font.Code
						TextLabel.TextSize = 14
						TextLabel.TextWrapped = true
						TextLabel.Size = UDim2.new(1, 0, 1, 0)
						TextLabel.TextYAlignment = Enum.TextYAlignment.Top
						TextLabel.BackgroundTransparency = 1
						TextLabel.TextStrokeTransparency = 0.5
						TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						TextLabel.Parent = BillboardGui
					end

					local NameEsp = ChestEspAttachment and ChestEspAttachment:FindFirstChild("NameEsp")

					if NameEsp then
						local v1182 = math.floor(Magnitude / 3)

						NameEsp.TextLabel.Text = string.format("[%s] %d M", v1.Name:gsub("Label", ""), v1182)
					end
				end)
			end
		else
			for _, v1 in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
				local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

				if ChestEspAttachment then
					ChestEspAttachment:Destroy()
				end
			end
		end
	end
end

berriesEsp = function()
	if BerryEsp then
		local tagged = game:GetService("CollectionService"):GetTagged("BerryBush")

		for _, v1 in ipairs(tagged) do
			pcall(function()
				local Position = v1.Parent:GetPivot().Position

				for _, v2 in pairs(v1:GetAttributes()) do
					if v2 then
						local name = "BerryEspPart_" .. v2 .. "_" .. tostring(Position)
						local Part2 = workspace:FindFirstChild(name)

						if not Part2 then
							Part2 = Instance.new("Part")
							Part2.Name = name
							Part2.Transparency = 1
							Part2.Size = Vector3.new(1, 1, 1)
							Part2.Anchored = true
							Part2.CanCollide = false
							Part2.Parent = workspace
							Part2.CFrame = CFrame.new(Position)
						end

						if not Part2:FindFirstChild("NameEsp") then
							local BillboardGui = Instance.new("BillboardGui", Part2)

							BillboardGui.Name = "NameEsp"
							BillboardGui.ExtentsOffset = Vector3.new(0, 1, 0)
							BillboardGui.Size = UDim2.new(0, 200, 0, 30)
							BillboardGui.Adornee = Part2
							BillboardGui.AlwaysOnTop = true

							local TextLabel = Instance.new("TextLabel", BillboardGui)

							TextLabel.Font = Enum.Font.Code
							TextLabel.TextSize = 14
							TextLabel.TextWrapped = true
							TextLabel.Size = UDim2.new(1, 0, 1, 0)
							TextLabel.TextYAlignment = Enum.TextYAlignment.Top
							TextLabel.BackgroundTransparency = 1
							TextLabel.TextStrokeTransparency = 0.5
							TextLabel.TextColor3 = Color3.fromRGB(80, 245, 245)
						end

						local NameEsp = Part2:FindFirstChild("NameEsp")
						local v1197 = (LocalPlayer.Character.Head.Position - Position).Magnitude / 3

						if NameEsp then
							NameEsp.TextLabel.Text = "[" .. v2 .. "]" .. " " .. math.round(v1197) .. " M"
						end
					end
				end
			end)
		end
	else
		for _, child in ipairs(workspace:GetChildren()) do
			if child:IsA("Part") then
				if child.Name:match("BerryEspPart_.*") then
					child:Destroy()
				end
			end
		end
	end
end
GRP_Esp_Esp:AddToggle("Esp_Berry", {
	Text = "Esp Berry",
	Default = false,
	Callback = function(p283)
		BerryEsp = p283

		if p283 then
			task.spawn(function()
				while BerryEsp do
					berriesEsp()
					task.wait()
				end
			end)
		else
			for _, child in ipairs(workspace:GetChildren()) do
				if child:IsA("Part") then
					if child.Name:match("BerryEspPart_.*") then
						child:Destroy()
					end
				end
			end
		end
	end
})

do
	GRP_Esp_Esp:AddToggle("Esp_Player", {
		Text = "Esp Player",
		Default = false,
		Callback = function(p284)
			PlayerEsp = p284

			if p284 then
				task.spawn(function()
					while PlayerEsp do
						EspPly()
						task.wait()
					end
				end)
			else
				local next_ = next
				local children, v1204 = game.Players:GetChildren()

				for _, v1 in next_, children, v1204 do
					pcall(function()
						if not (isnil(v1.Character) or isnil(v1.Character.Head)) then
							if v1.Character.Head:FindFirstChild("NameEsp" .. Number) then
								v1.Character.Head:FindFirstChild("NameEsp" .. Number):Destroy()
							end
						end
					end)
				end
			end
		end
	})
end

GRP_Esp_Esp:AddToggle("Esp_Chest", {
	Text = "Esp Chest",
	Default = false,
	Callback = function(p285)
		ChestESP = p285

		if p285 then
			task.spawn(function()
				while ChestESP do
					ChestEsp()
					task.wait()
				end
			end)
		else
			for _, v1 in ipairs(game:GetService("CollectionService"):GetTagged("_ChestTagged")) do
				local ChestEspAttachment = v1:FindFirstChild("ChestEspAttachment")

				if ChestEspAttachment then
					ChestEspAttachment:Destroy()
				end
			end
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Fruit", {
	Text = "Esp Fruit",
	Default = false,
	Callback = function(p286)
		DevilFruitESP = p286

		if p286 then
			task.spawn(function()
				while DevilFruitESP do
					DevEsp()
					task.wait()
				end
			end)
		else
			local next_ = next
			local children, v1212 = workspace:GetChildren()

			for _, v1 in next_, children, v1212 do
				pcall(function()
					if v1:FindFirstChild("Handle") then
						if v1.Handle:FindFirstChild("NameEsp" .. Number) then
							v1.Handle:FindFirstChild("NameEsp" .. Number):Destroy()
						end
					end
				end)
			end
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Island", {
	Text = "Esp Island",
	Default = false,
	Callback = function(p287)
		IslandESP = p287

		if p287 then
			task.spawn(function()
				while IslandESP do
					LocationEsp()
					task.wait()
				end
			end)
		else
			local next_ = next
			local children, v1217 = workspace._WorldOrigin.Locations:GetChildren()

			for _, v1 in next_, children, v1217 do
				pcall(function()
					if v1:FindFirstChild("NameEsp") then
						v1:FindFirstChild("NameEsp"):Destroy()
					end
				end)
			end
		end
	end
})

do
	GRP_Esp_Esp:AddToggle("Esp_Flower", {
		Text = "Esp Flower",
		Default = false,
		Callback = function(p288)
			FlowerESP = p288

			if p288 then
				task.spawn(function()
					while FlowerESP do
						flowerEsp()
						task.wait()
					end
				end)
			else
				for _, child in pairs(workspace:GetChildren()) do
					pcall(function()
						if (child.Name == "Flower2" or child.Name == "Flower1") and child:FindFirstChild("NameEsp" .. Number) then
							child:FindFirstChild("NameEsp" .. Number):Destroy()
						end
					end)
				end
			end
		end
	})
end

GRP_Esp_Esp:AddToggle("Esp_Legendary_Sword", {
	Text = "Esp Legendary Sword",
	Default = false,
	Callback = function(p289)
		LegenS = p289

		if p289 then
			task.spawn(function()
				while LegenS do
					LegenSword()
					task.wait()
				end
			end)
		elseif workspace:FindFirstChild("Lgd") then
			workspace:FindFirstChild("Lgd"):Destroy()
		end
	end
})
GRP_Esp_Esp:AddToggle("Esp_Haki_Color", {
	Text = "Esp Haki Color",
	Default = false,
	Callback = function(p290)
		ColorEsp = p290

		if p290 then
			task.spawn(function()
				while ColorEsp do
					HakiClorEsp()
					task.wait()
				end
			end)
		elseif workspace:FindFirstChild("Gay") then
			workspace:FindFirstChild("Gay"):Destroy()
		end
	end
})

do
	GRP_Esp_Esp:AddToggle("Esp_Gear", {
		Text = "Esp Gear",
		Default = false,
		Callback = function(p291)
			ESPGear = p291

			if p291 then
				task.spawn(function()
					while ESPGear do
						gearEsp()
						task.wait()
					end
				end)
			else
				local pairs_ = pairs
				local MysticIsland = workspace.Map:FindFirstChild("MysticIsland")

				for _, descendant in pairs_(MysticIsland:GetDescendants()) do
					pcall(function()
						if descendant:FindFirstChild("NameEsp") then
							descendant:FindFirstChild("NameEsp"):Destroy()
						end
					end)
				end
			end
		end
	})
end

do
	GRP_Esp_Esp:AddToggle("Esp_SeaEvent_Island", {
		Text = "Esp SeaEvent Island",
		Default = false,
		Callback = function(p292)
			EspEventIsland = p292

			if p292 then
				task.spawn(function()
					while EspEventIsland do
						EventIslandEsp()
						task.wait()
					end
				end)
			else
				for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
					pcall(function()
						if child:FindFirstChild("NameEsp") then
							child:FindFirstChild("NameEsp"):Destroy()
						end
					end)
				end
			end
		end
	})
end

GRP_Esp_Esp:AddToggle("Esp_Advanced_Dealer", {
	Text = "Esp Advanced Dealer",
	Default = false,
	Callback = function(p293)
		advanEsp = p293

		if p293 then
			task.spawn(function()
				while advanEsp do
					AdvanFruitEsp()
					task.wait()
				end
			end)
		elseif workspace:FindFirstChild("Adv") then
			workspace:FindFirstChild("Adv"):Destroy()
		end
	end
})
GRP_Raids_Fruits_Options = t15.Raids:AddLeftGroupbox("Fruits Options")

do
	local function v1228(p294)
		local v1229 = tostring(p294)
		local v1230

		repeat
			v1229, v1230 = v1229:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
		until v1230 == 0

		return v1229
	end
	local function v1231()
		local s18 = "Advance Fruit Stock\n"
		local ok, result = pcall(function()
			return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", true)
		end)

		if ok and result then
			local v1235 = false

			for _, v1 in pairs(result) do
				if v1.OnSale then
					v1235 = true
					s18 ..= v1.Name .. " - $" .. v1228(v1.Price) .. "\n"
				end
			end

			if not v1235 then
				s18 ..= "- No fruit.\n"
			end
		else
			s18 ..= "- Error while retrieving data.\n"
		end

		local v1238 = s18 .. "\nNormal Fruit Stock\n"
		local ok2, result2 = pcall(function()
			return game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
		end)

		if ok2 and result2 then
			local v1241 = false

			for _, v1 in pairs(result2) do
				if v1.OnSale then
					v1241 = true
					v1238 ..= v1.Name .. " - $" .. v1228(v1.Price) .. "\n"
				end
			end

			if not v1241 then
				v1238 ..= "- No fruit.\n"
			end
		else
			v1238 ..= "- Error while retrieving data.\n"
		end

		return v1238
	end

	local v1244 = GRP_Raids_Fruits_Options:AddLabel("Loading...")

	task.spawn(function()
		if task.wait(60) then
			repeat
				pcall(function()
					v1244:SetText(v1231())
				end)
			until not task.wait(60)
		end
	end)
	pcall(function()
		v1244:SetText(v1231())
	end)
end

-- Auto Random Fruit (logica do Vxeze: GachaClient / ZiolesGacha, respeita o tempo de espera do servidor)
do
	local okGC, GachaClient = pcall(function()
		return require(game:GetService("ReplicatedStorage").Controllers.GachaClient)
	end)
	local okGW, GachaWindow = pcall(function()
		return require(game:GetService("ReplicatedStorage").Controllers.UI.GachaWindow)
	end)
	local GachaTimers = {}

	local gachaNotify = function(title, msg)
		pcall(function()
			lib:Notify({ Title = tostring(title), Description = tostring(msg), Duration = 4 })
		end)
	end

	local GetGachaMissing = function(arg)
		if arg.PaidRandomItemsRestricted and arg.PaidRandomItemsRestricted.Value then
			return arg.PaidRandomItemsRestricted
		end

		for _, key in ipairs({ "Level", "Price", "Cooldown" }) do
			if arg[key] and arg[key].RequirementMet == false then
				return arg[key]
			end
		end
	end

	local RollGacha = function(arg, arg2)
		local serverTimeNow = workspace:GetServerTimeNow()
		if serverTimeNow < (GachaTimers[arg] or 0) then
			return
		end
		GachaTimers[arg] = serverTimeNow + 60

		local ok, result = pcall(GachaClient.CheckGachaAsync, arg, "Blox Fruit Gacha")
		if not ok or type(result) ~= "table" then
			gachaNotify("Gacha", "Gacha is not available right now")
			return
		end

		local missing = GetGachaMissing(result)
		if missing then
			if missing.TimeEnds then
				GachaTimers[arg] = missing.TimeEnds + 1
			end
			gachaNotify(arg2, missing.ErrorMessage)
			return
		end

		if pcall(GachaClient.PurchaseGachaAsync, arg) then
			GachaTimers[arg] = serverTimeNow + 5
			gachaNotify("Gacha", "Rolled successfully")
		end
	end

	RandomFF = GRP_Raids_Fruits_Options:AddToggle("Auto_Random_Fruit", {
		Text = "Auto Random Fruit",
		Default = false,
		Callback = function(p295)
			_G.Random_Auto = p295
			GachaTimers.ZiolesGacha = nil
		end
	})

	task.spawn(function()
		while task.wait(0.5) do
			if _G.Random_Auto and okGC then
				pcall(function()
					if okGW and GachaWindow.IsOpen() then
						GachaWindow.Close()
					end
					RollGacha("ZiolesGacha", "Random Devil Fruit")
				end)
			end
		end
	end)
end
DropF = GRP_Raids_Fruits_Options:AddToggle("Auto_Drop_Fruit", {
	Text = "Auto Drop Fruit",
	Default = false,
	Callback = function(p296)
		_G.DropFruit = p296
	end
})
spawn(function()
	while wait(Sec) do
		if _G.DropFruit then
			pcall(function()
				DropFruits()
			end)
		end
	end
end)
StoredF = GRP_Raids_Fruits_Options:AddToggle("Auto_Store_Fruit", {
	Text = "Auto Store Fruit",
	Default = false,
	Callback = function(p297)
		_G.StoreF = p297
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.StoreF then
				pcall(function()
					UpdStFruit()
				end)
			end
		end
	end)
end

do
	TwF = GRP_Raids_Fruits_Options:AddToggle("Auto_Tween_to_Fruit", {
		Text = "Auto Tween to Fruit",
		Default = false,
		Callback = function(p298)
			_G.TwFruits = p298
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.TwFruits then
				pcall(function()
					for _, child in pairs(workspace:GetChildren()) do
						if string.find(child.Name, "Fruit") then
							_tp(child.Handle.CFrame)
						end
					end
				end)
			end
		end
	end)
end

do
	BringF = GRP_Raids_Fruits_Options:AddToggle("Auto_Collect_Fruit", {
		Text = "Auto Collect Fruit",
		Default = false,
		Callback = function(p299)
			_G.InstanceF = p299
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.InstanceF then
				pcall(function()
					collectFruits(_G.InstanceF)
				end)
			end
		end
	end)
end

GRP_Raids_Fruits_Options:AddDropdown("Select_Fruit_Shop", {
	Text = "Select Fruit Shop",
	Values = {
		"Rocket-Rocket",
		"Spin-Spin",
		"Blade-Blade",
		"Spring-Spring",
		"Bomb-Bomb",
		"Smoke-Smoke",
		"Spike-Spike",
		"Flame-Flame",
		"Ice-Ice",
		"Sand-Sand",
		"Dark-Dark",
		"Eagle-Eagle",
		"Diamond-Diamond",
		"Light-Light",
		"Rubber-Rubber",
		"Ghost-Ghost",
		"Magma-Magma",
		"Quake-Quake",
		"Buddha-Buddha",
		"Love-Love",
		"Creation-Creation",
		"Spider-Spider",
		"Sound-Sound",
		"Phoenix-Phoenix",
		"Portal-Portal",
		"Lightning-Lightning",
		"Pain-Pain",
		"Blizzard-Blizzard",
		"Gravity-Gravity",
		"T-Rex-T-Rex",
		"Mammoth-Mammoth",
		"Dough-Dough",
		"Shadow-Shadow",
		"Venom-Venom",
		"Gas-Gas",
		"Control-Control",
		"Spirit-Spirit",
		"Leopard-Leopard",
		"Yeti-Yeti",
		"Kitsune-Kitsune",
		"Dragon-Dragon"
	},
	Default = 1,
	Callback = function(p300)
		getgenv().SelectFruit = p300
	end
})
GRP_Raids_Fruits_Options:AddToggle("Auto_Buy_Fruit_Shop", {
	Text = "Auto Buy Fruit Shop",
	Default = false,
	Callback = function(p301)
		getgenv().AutoBuyFruitSniper = p301
	end
})

do
	spawn(function()
		pcall(function()
			while wait() do
				if getgenv().AutoBuyFruitSniper then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits")
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PurchaseRawFruit", getgenv().SelectFruit)
				end
			end
		end)
	end)
end

GRP_Raids_Dungeon_Event_Raiding = t15.Raids:AddLeftGroupbox("Dungeon Event / Raiding")
-- ===================== AUTO RAID (3nn) =====================
-- Funcoes do Raid do 3nn: Select Raid, Get Fruit In Inventory Low Beli, Auto Raid, Hop Server Raid, Auto Awake Fruit,
-- Kill Aura Only Raid (Time Delay Kill), BringMobRaid, DetectMobRaid, GetLastRaidIsland, CheckInRaid.
do
	local t = plr
	local wOrigin = workspace._WorldOrigin
	local CommF = replicated.Remotes.CommF_

	-- configuracoes do 3nn (Settings["..."]) guardadas em uma tabela local
	local Settings = { ["Time Delay Kill"] = 5 }
	local SaveSettings = function(key, value)
		Settings[key] = value
		if key == "Auto Raid" then
			_G.AutoRaid3nn = value and true or false -- libera o _tp e o noclip do Zyrox
		end
	end

	local raidLog = function(msg)
		pcall(function()
			lib:Notify({ Title = "Auto Raid", Description = tostring(msg), Duration = 4 })
		end)
	end

	-- ===== helpers do 3nn =====
	local IsMobAlive = function(mob)
		if mob and mob.Parent and mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChildWhichIsA("Humanoid") and mob.Humanoid.Health > 0 then
			return true
		end
	end

	local isnetworkowner2 = function(part)
		for _, other in ipairs(game.Workspace.Characters:GetChildren()) do
			if other.Name ~= t.Name and other:FindFirstChild("HumanoidRootPart") and (other.HumanoidRootPart.Position - part.Position).Magnitude <= 300 then
				return false
			end
		end
		return true
	end

	local sizepart = function(mob)
		if not mob or not mob.Parent or not mob:FindFirstChild("HumanoidRootPart") then
			return
		end
		if t:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 50 then
			for _, part in ipairs(mob:GetDescendants()) do
				if (part:IsA("Part") or part:IsA("MeshPart")) and part.CanCollide then
					part.CanCollide = false
				end
			end
		end
	end

	local DeleteIgnoredMob = function()
		for _, mob in pairs(workspace.Enemies:GetChildren()) do
			if mob:IsA("Model") and mob:FindFirstChild("Ignored") then
				mob.Ignored:Destroy()
			end
		end
	end

	getgenv().KillRaidEnemy = function()
		for _, mob in ipairs(workspace.Enemies:GetChildren()) do
			if IsMobAlive(mob) then
				mob.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
			end
		end
	end

	getgenv().KillRaidEnemyLowhealth = function()
		for _, mob in ipairs(workspace.Enemies:GetChildren()) do
			if IsMobAlive(mob) and mob.Humanoid.Health / mob.Humanoid.MaxHealth < 0.2 then
				mob.Humanoid.Health = 0
			end
		end
	end

	local DetectMobRaid = function()
		for _, mob in ipairs(workspace.Enemies:GetChildren()) do
			if IsMobAlive(mob) and t:DistanceFromCharacter(mob.HumanoidRootPart.Position) <= 400 then
				return mob
			end
		end
	end

	-- BringMobRaid (3nn): puxa mobs de mesmo nome para perto do alvo; marca "Ignored" quem nao perde vida
	local daBring = false
	local currentMob, anchorCF
	local BringMobRaid = function(mob)
		if not _B then -- toggle "Bring Mobs" do Zyrox
			return
		end
		if mob and currentMob ~= mob then
			currentMob = mob
			anchorCF = mob.HumanoidRootPart.CFrame
			DeleteIgnoredMob()
		end
		if daBring then
			delay(0.1, function()
				daBring = false
			end)
			return
		end

		local list = {}
		if not mob:FindFirstChild("Ignored") then
			table.insert(list, mob)
		end
		for _, other in pairs(workspace.Enemies:GetChildren()) do
			if other ~= mob and other.Name == mob.Name and not other:FindFirstChild("Ignored") and IsMobAlive(other) and isnetworkowner2(other.HumanoidRootPart) then
				if (other.HumanoidRootPart.Position - anchorCF.Position).Magnitude <= 200 and #list < 1 then
					table.insert(list, other)
				end
			end
		end

		if anchorCF and (t.Character.HumanoidRootPart.Position - mob.HumanoidRootPart.Position).Magnitude <= 50 and isnetworkowner2(t.Character.HumanoidRootPart) then
			for _, target in pairs(list) do
				sizepart(target)
				target.HumanoidRootPart.CFrame = anchorCF * CFrame.new(0, math.random(0, 2), math.random(0, 2))
				task.spawn(function()
					local hp = target.Humanoid.Health
					task.wait(3.5)
					if target.Humanoid.Health == hp and not target:FindFirstChild("Ignored") then
						target.HumanoidRootPart.CFrame = target.WorldPivot
						Instance.new("IntValue", target).Name = "Ignored"
						task.wait(0.3)
					end
				end)
				daBring = true
			end
		end
	end

	local GetLastRaidIsland = function()
		local best, bestNum = nil, 0
		for _, island in ipairs(wOrigin.Locations:GetChildren()) do
			if string.find(island.Name, "Island ") and t:DistanceFromCharacter(island.Position) < 3000 then
				local num = tonumber((island.Name:gsub("Island ", "")))
				if num and bestNum < num then
					bestNum, best = num, island
				end
			end
		end
		return best
	end

	local CheckInRaid = function()
		for _, island in ipairs(wOrigin.Locations:GetChildren()) do
			if string.find(island.Name, "Island ") and t:DistanceFromCharacter(island.Position) < 3000 then
				return true
			end
		end
		return false
	end

	local UsedualFlock = function()
		EquipWeapon(_G.SelectWeapon)
	end

	-- ===== frutas (Get Fruit In Inventory Low Beli / Hop Sever Raid) =====
	local HasFruitTool = function()
		for _, container in ipairs({ t.Backpack, t.Character }) do
			if container then
				for _, tool in ipairs(container:GetChildren()) do
					if tool:IsA("Tool") and tool:FindFirstChild("ToolTip") and tool.ToolTip == "Blox Fruit" then
						return true
					end
				end
			end
		end
		return false
	end

	local GetPathFruit = function()
		for _, obj in ipairs(workspace:GetChildren()) do
			if (obj:IsA("Tool") or obj:IsA("Model")) and string.find(obj.Name, "Fruit") and obj:FindFirstChild("Handle") then
				return obj
			end
		end
	end

	-- TakeFruitInventory(true) (Vxeze): primeira fruta do INVENTARIO que nao esta na tabela de frutas caras (>= 1M)
	local okIRS, ItemReplicationService = pcall(function()
		return require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService"))
	end)
	local okIC, ItemConfig = pcall(function()
		return require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
	end)
	local GetInventoryItems
	GetInventoryItems = function()local n={};local L=require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")).KEYS;for U,U in  ItemReplicationService :GetItems(L.QUANTITY)do if U.Value and U.Value>0 then local w,y=pcall(function()return  ItemConfig .match(U.ItemId):unwrap();end);if w and y and y.Display then local w,S=y.Display.Category,y.Index and y.Index.StorageKey;local K,R=if w=="Blox Fruit"then S or y.Display.Name or"ItemId_"..U.ItemId else y.Display.Name or S or"ItemId_"..U.ItemId, ItemReplicationService :ReadItem(L.MASTERY,U.ItemId,U.NetworkedUID)or 0;table.insert(n,{Name=K,Type=w,Count=U.Value,Mastery=R,ItemId=U.ItemId,UID=U.NetworkedUID});end;end;end;return n;end

	local ExpensiveFruits = {}
	local fruitsLoaded = false
	local LoadFruitTables = function()
		local ok, data = pcall(function()
			return CommF:InvokeServer("GetFruits", false)
		end)
		if ok and type(data) == "table" then
			for _, fruit in pairs(data) do
				if fruit.Price >= 1000000 then
					ExpensiveFruits[fruit.Name] = fruit.Price
				end
			end
			ExpensiveFruits["Dragon (East)-Dragon (East)"] = 15000000
			ExpensiveFruits["Dragon (West)-Dragon (West)"] = 15000000
			fruitsLoaded = true
		end
		-- skins de fruta tambem contam como caras (como no Vxeze)
		pcall(function()
			local skins = require(game:GetService("ReplicatedStorage").Modules.SkinUtil.FruitSkins)
			for _, group in next, skins.Grouped, nil do
				if group.StorageName then
					ExpensiveFruits[group.StorageName] = true
				end
			end
		end)
	end
	task.spawn(LoadFruitTables)

	local TakeFruitInventory = function()
		if not fruitsLoaded then
			LoadFruitTables()
		end
		local ok, items = pcall(GetInventoryItems)
		if ok and type(items) == "table" then
			for _, item in pairs(items) do
				if item.Type == "Blox Fruit" and not ExpensiveFruits[item.Name] then
					return item.Name
				end
			end
		end
	end

	-- ===== UI =====
	local raidNames = {}
	pcall(function()
		for _, group in next, require(game.ReplicatedStorage.Raids) do
			if type(group) == "table" then
				for _, name in next, group do
					if type(name) == "string" then
						table.insert(raidNames, name)
					end
				end
			end
		end
	end)
	if #raidNames == 0 then
		raidNames = { "Flame", "Ice", "Quake", "Light", "Dark", "String", "Rumble", "Magma", "Human: Buddha", "Sand", "Bird: Phoenix", "Dough" }
	end

	GRP_Raids_Dungeon_Event_Raiding:AddDropdown("Select_Raid_3NN", {
		Text = "Select Raid",
		Values = raidNames,
		Callback = function(value)
			Settings["Select Raid"] = value
			_G.SelectChip = value -- o resto do Zyrox (ex.: Rumble) tambem le _G.SelectChip
		end
	})

	GRP_Raids_Dungeon_Event_Raiding:AddToggle("Get_Fruit_In_Inventory_Low_Beli_3NN", {
		Text = "Get Fruit In Inventory Low Beli",
		Default = false,
		Callback = function(value)
			SaveSettings("Get Fruit In Inventory Low Beli", value)
		end
	})

	local buychip = true
	local waitgoraid = false
	local tickTeleCastle = nil

	local RaidButton = function()
		local map = workspace:FindFirstChild("Map")
		if World2 then
			local circle = map and map:FindFirstChild("CircleIsland")
			local summon = circle and circle:FindFirstChild("RaidSummon2")
			return summon and summon.Button:FindFirstChild("Main")
		elseif World3 then
			local castle = map and map:FindFirstChild("Boat Castle")
			local summon = castle and castle:FindFirstChild("RaidSummon2")
			return summon and summon.Button:FindFirstChild("Main")
		end
	end

	-- fase "dentro do raid": mata o mob e vai para a proxima ilha (usada pelo Auto Raid e pelo _G.Raiding do Rumble)
	local RaidFight = function()
		waitgoraid = true
		buychip = true
		local mob = DetectMobRaid()
		if mob then
			repeat
				task.wait()
				if not getgenv().KillMobRaid and Settings["Kill Aura Only Raid And Volcano"] then
					getgenv().KillMobRaid = true
					local delaySeconds = Settings["Time Delay Kill"] or 5
					mob.Humanoid:ChangeState(Enum.HumanoidStateType.Dead)
					delay(delaySeconds, function()
						getgenv().KillMobRaid = false
					end)
				end
				UsedualFlock()
				pcall(AttackNoCoolDown)
				sizepart(mob)
				BringMobRaid(mob)
				if _G.ChooseWP == "Blox Fruit" then
					_tp(mob.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					_tp(mob.HumanoidRootPart.CFrame * CFrame.new(10, 20, 0))
				end
			until not IsMobAlive(mob)
		else
			local island = GetLastRaidIsland()
			if island then
				if island.Name == "Island 2" and Settings["Select Raid"] == "Phoenix" then
					_tp(island.CFrame * CFrame.new(300, 60, 0))
				else
					_tp(island.CFrame * CFrame.new(0, 60, 0))
				end
			end
		end
	end

	GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Raid_3NN", {
		Text = "Auto Raid",
		Default = false,
		Callback = function(value)
			if value then
				spawn(function()
					while Settings["Auto Raid"] and task.wait() do
						local ok, err = pcall(function()
							if not ZyroxClaim("raid") then
								return
							end
							local button = RaidButton()
							local timerVisible = t.PlayerGui.Main.TopHUDList.RaidTimer.Visible

							if not timerVisible and not CheckInRaid() then
								if tickTeleCastle and tick() - tickTeleCastle < 5 then
									return
								end
								if not button then
									if World2 then
										_tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
									else
										_tp(CFrame.new(-5500, 314, -2855))
									end
									return
								end
							end

							if GetBP("Special Microchip") then
								if waitgoraid then
									wait(5)
									waitgoraid = false
								end
								buychip = false
								fireclickdetector(button.ClickDetector)
								tickTeleCastle = tick()
								if getgenv().Tween then
									getgenv().Tween:Pause()
									getgenv().Tween:Cancel()
								end
								return
							end

							if timerVisible and CheckInRaid() then
								RaidFight()
								return
							end

							if buychip and t.Data.Level.Value >= 1100 and not timerVisible and not GetBP("Special Microchip") and not CheckInRaid() then
								if Settings["Hop Sever Raid"] then
									local fruit = GetPathFruit()
									if fruit then
										if not ((fruit.Handle.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 5) then
											_tp(fruit.Handle.CFrame)
										end
										return
									elseif not HasFruitTool() then
										Hop()
										wait(5)
										return
									end
								end
								if not HasFruitTool() and TakeFruitInventory() and Settings["Get Fruit In Inventory Low Beli"] then
									CommF:InvokeServer("LoadFruit", TakeFruitInventory())
								end
								CommF:InvokeServer("RaidsNpc", "Check")
								CommF:InvokeServer("RaidsNpc", "Select", Settings["Select Raid"] or "Flame")
								wait(1)
							end
						end)
						if not ok then
							warn("[AutoRaid] " .. tostring(err))
						end
					end
				end)
			end
			SaveSettings("Auto Raid", value)
		end
	})

	-- _G.Raiding (ligado pelo Rumble/Awakener) continua matando mobs e avancando de ilha
	task.spawn(function()
		while task.wait(0.1) do
			if _G.Raiding and not Settings["Auto Raid"] then
				pcall(function()
					if t.PlayerGui.Main.TopHUDList.RaidTimer.Visible and CheckInRaid() then
						RaidFight()
					end
				end)
			end
		end
	end)

	GRP_Raids_Dungeon_Event_Raiding:AddToggle("Hop_Sever_Raid_3NN", {
		Text = "Hop Sever Raid",
		Default = false,
		Callback = function(value)
			if value and not Settings["Auto Raid"] then
				raidLog("Turn On Auto Raid Plz")
			end
			SaveSettings("Hop Sever Raid", value)
		end
	})

	GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Awake_Fruit_3NN", {
		Text = "Auto Awake Fruit",
		Default = false,
		Callback = function(value)
			SaveSettings("Auto Awake Fruit", value)
		end
	})

	task.spawn(function()
		while task.wait(1) do
			if Settings["Auto Awake Fruit"] then
				pcall(function()
					CommF:InvokeServer("Awakener", "Check")
					CommF:InvokeServer("Awakener", "Awaken")
				end)
			end
		end
	end)

	GRP_Raids_Dungeon_Event_Raiding:AddToggle("Raid_Kill_Aura", {
		Text = "Kill Aura Only Raid",
		Default = false,
		Callback = function(value)
			SaveSettings("Kill Aura Only Raid And Volcano", value)
		end
	})

	GRP_Raids_Dungeon_Event_Raiding:AddSlider({
		Text = "Time Delay Kill",
		Min = 0,
		Max = 5,
		Default = 5,
		Rounding = 1,
		Callback = function(value)
			SaveSettings("Time Delay Kill", value)
		end
	})
end
-- ===================== FIM AUTO RAID (3nn) =====================

-- ===================== SECRET QUEST (aba nova, port do Vxeze) =====================
do
	local sqOk, sqErr = pcall(function()

-- ---------- compat layer (Vxeze -> Zyrox) ----------
local localPlayer = plr
local ReplicatedStorage = replicated
local CommF = replicated.Remotes.CommF_
local VirtualInputManager = vim1

local SQStore = {}
local Settings = setmetatable({}, {
	__index = function(_, k)
		local v = SQStore[k]
		if v ~= nil then
			return v
		end
		if k == "Select Weapon" then
			return _G.ChooseWP or "Melee"
		elseif k == "Select Bait" then
			return _G.SelectedBait or "Basic Bait"
		elseif k == "Bring Mob" then
			return _B and true or false
		elseif k == "Auto Fishing" then
			return SQStore["Auto Secret Quest"]
		end
		return nil
	end,
})
local SaveSettings = function(k, v)
	SQStore[k] = v
	if k == "Auto Secret Quest" then
		_G.AutoSecretQuest = v and true or false -- libera o _tp e o noclip do Zyrox (shouldTween)
	end
end

local sqNotified = {}
local VxezeLog = function(a, b)
	if _G.SQDebug then
		print("[SecretQuest] " .. tostring(a) .. ": " .. tostring(b))
	end
end
local VxezeNotify = function(title, msg, kind, opts)
	opts = opts or {}
	VxezeLog(title, msg)
	local key = opts.Key or (tostring(title) .. "|" .. tostring(msg))
	if tick() - (sqNotified[key] or 0) < 3 then
		return
	end
	sqNotified[key] = tick()
	local text = tostring(msg)
	if opts.SubContent then
		text = text .. " (" .. tostring(opts.SubContent) .. ")"
	end
	pcall(function()
		lib:Notify({ Title = "Secret Quest", Description = text, Duration = opts.Duration or 5 })
	end)
end

local GetCurrentSea = function()
	if World1 then
		return 1
	elseif World2 then
		return 2
	elseif World3 then
		return 3
	end
	return 0
end
local Place_Id = {
	sea1 = function() return GetCurrentSea() == 1 end,
	sea2 = function() return GetCurrentSea() == 2 end,
	sea3 = function() return GetCurrentSea() == 3 end,
}
local SeaOnly = function(label, title, seas)
	local cur = GetCurrentSea()
	for _, s in ipairs(seas) do
		if s == cur then
			return true
		end
	end
	local names = {}
	for _, s in ipairs(seas) do
		table.insert(names, "Sea " .. s)
	end
	label.SetText(title .. " : Not in Sea " .. tostring(cur) .. ", go to " .. table.concat(names, " or "))
	return false
end
local EnforceGate = function(c, n, ok, msg)
	if ok then
		return true
	end
	SaveSettings(n, false)
	if c and c.SetStage then
		c:SetStage(false)
	end
	VxezeNotify(n, msg, "warning", { Key = "gate" .. n })
	return false
end

-- movimento (usa o _tp do Zyrox)
local ToTarget = function(a)
	return _tp(a)
end
local TweenManager = {
	CancelTweenOnly = function() end,
	CancelCurrent = function() end,
}
local NoclipChanged = setmetatable({}, { __mode = "k" })
local StopTweenNow = function()
	pcall(function()
		local r = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if r then
			r.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
			r.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
		end
	end)
end
local ReleaseTweenPhysics = function()
	pcall(function()
		local r = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
		if r then
			r.Anchored = false
			local f = r:FindFirstChild("FloatForce")
			if f then
				f:Destroy()
			end
		end
	end)
end
local travelFunctions = {
	GetSpawnPosition = function(arg)
		local spawns = workspace._WorldOrigin:FindFirstChild("PlayerSpawns")
		local team = spawns and plr.Team and spawns:FindFirstChild(plr.Team.Name)
		team = team and team:FindFirstChild(arg)
		return team and team:GetPivot().Position
	end,
}
local StackFarmOther = true

-- combate / inventario (copiados do Vxeze quando possivel)
local WeaponCache = {}
local SizedParts = setmetatable({}, { __mode = "k" })
local EquipTool, NameWeapon, SizePart, GetInventoryItems, FormatMagnetTime
local CalculateFishingCastTarget, DetectRod, RunFishingCycle

	EquipTool = function(n)if n and( localPlayer :FindFirstChild("Backpack"))and( localPlayer .Backpack:FindFirstChild(n))and not  localPlayer .Character.Humanoid.Sit then  localPlayer .Character.Humanoid:EquipTool( localPlayer .Backpack:FindFirstChild(n));end;end
	NameWeapon = function(n,L)local U=WeaponCache[n or""];if U and os.clock()-U.time<1 and U.tool.ToolTip==n and(U.tool.Parent== localPlayer .Backpack or U.tool.Parent== localPlayer .Character)then return L and U.tool or U.tool.Name;end;local function w(y)for S,S in ipairs(y:GetChildren())do if S:IsA("Tool")and S.ToolTip==n then return S;end;end;end;U=w( localPlayer .Backpack)or  localPlayer .Character and(w( localPlayer .Character));if U then WeaponCache[n or""]={tool=U,time=os.clock()};return L and U or U.Name;end;end
	SizePart = function(n)AttackingMob=n;if not n or not n.Parent or not n:FindFirstChild("HumanoidRootPart")then return;end;if os.clock()-(SizedParts[n]or 0)<2 then return;end;if  localPlayer :DistanceFromCharacter(n.HumanoidRootPart.Position)<=50 then SizedParts[n]=os.clock();for c,c in ipairs(n:GetDescendants())do if c:IsA("BasePart")and c.CanCollide then c.CanCollide=false;end;end;end;end

local okIRS, ItemReplicationService = pcall(function()
	return require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService"))
end)
local okIC, ItemConfig = pcall(function()
	return require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
end)
	GetInventoryItems = function()local n={};local L=require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")).KEYS;for U,U in  ItemReplicationService :GetItems(L.QUANTITY)do if U.Value and U.Value>0 then local w,y=pcall(function()return  ItemConfig .match(U.ItemId):unwrap();end);if w and y and y.Display then local w,S=y.Display.Category,y.Index and y.Index.StorageKey;local K,R=if w=="Blox Fruit"then S or y.Display.Name or"ItemId_"..U.ItemId else y.Display.Name or S or"ItemId_"..U.ItemId, ItemReplicationService :ReadItem(L.MASTERY,U.ItemId,U.NetworkedUID)or 0;table.insert(n,{Name=K,Type=w,Count=U.Value,Mastery=R,ItemId=U.ItemId,UID=U.NetworkedUID});end;end;end;return n;end

local TakeFruitInventory = function(arg)
	for _, v in ipairs(GetInventoryItems() or {}) do
		if v.Type == "Blox Fruit" then
			return v.Name
		end
	end
end
local BringMob = function(n)
	if _B and n and n.Parent then
		pcall(BringEnemy, n)
	end
end
local UsedualFlock = function()
	EquipTool(NameWeapon(Settings["Select Weapon"] or "Melee"))
end
getgenv().ClickM1 = function()
	pcall(AttackNoCoolDown)
end

	FormatMagnetTime = function(arg)
		local n = math.floor(arg)
		return string.format("%02d:%02d", n // 60, n % 60)
	end

local StatusFishingLabel = { SetText = function() end }
do
		local fishingRequest = game.ReplicatedStorage.FishReplicated.FishingRequest
		local FishingRemote = require(game.ReplicatedStorage.Modules.Net):RemoteEvent("FishingRemote", true)
		local GetWaterHeightAtLocation = require(game.ReplicatedStorage.Util.GetWaterHeightAtLocation)
		local CollectionService = game:GetService("CollectionService")
		local waterBodyTag = require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).WATER_BODY_TAG
		local rod = require(game.ReplicatedStorage.FishReplicated.FishingClient.Config).Rod
		require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components)

		CalculateFishingCastTarget = function(arg, arg2, arg3)
			local v6 = GetWaterHeightAtLocation(arg.Position)
			local v7, v8 = workspace:FindPartOnRayWithIgnoreList(Ray.new(arg.Parent.Head.Position, arg.CFrame.LookVector * (arg2:GetAttribute("MaxLaunchDistance") or rod.MaxLaunchDistance) * (0.5 + arg3 / 201)), { arg.Parent, workspace.Characters, workspace.Enemies })
			local tbl9 = { arg.Parent, workspace.Characters, workspace.Enemies }
			local v9, v10 = workspace:FindPartOnRayWithIgnoreList(Ray.new(v8 + Vector3.new(0, 3, 0), Vector3.new(0, -500, 0)), tbl9)
			if not v10 then
				return
			end
			local z = v8.Z
			local vector = Vector3.new(v8.X, math.max(v10.Y, v6), z)
			return vector, v9 and CollectionService:HasTag(v9, waterBodyTag) or vector.Y <= v6
		end

		DetectRod = function()
			if not localPlayer then
				return nil
			end
			local fishingRodData = (localPlayer.Character or localPlayer.CharacterAdded:Wait()):FindFirstChild("FishingRodData", true)
			if fishingRodData then
				return fishingRodData.Parent
			end

			for _, child in ipairs(localPlayer.Backpack:GetChildren()) do
				if child:FindFirstChild("FishingRodData") then
					return child
				end
			end

			return nil
		end

		require(game:GetService("ReplicatedStorage").FishReplicated.FishingClient.Components.CatchingMinigame)

		RunFishingCycle = function()
			local character = localPlayer.Character
			character = character and character:FindFirstChild("HumanoidRootPart")
			local v6 = DetectRod()
			if not character or not v6 then
				return
			end

			if v6.Parent == localPlayer.Backpack then
				EquipTool(v6.Name)
				task.wait(0.5)
				return
			end

			local attribute = v6:GetAttribute("ServerState")

			if attribute then
				StatusFishingLabel.SetText("Status Fishing : " .. attribute)
			end

			if v6:GetAttribute("SkillChargeAlpha") >= 1 then
				game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/JobToolAbilities"):InvokeServer(unpack({ "Z", true }))
			end

			if not attribute or attribute == "ReeledIn" then
				getgenv().delaytimeBiting = nil
				fishingRequest:InvokeServer("StartCasting")
				task.wait(0.7)
				local v7, v8 = CalculateFishingCastTarget(character, v6, 98)
				if not v7 then
					return
				end

				if not fishingRequest:InvokeServer("CastLineAtLocation", v7, 98, v8) then
					EquipTool(NameWeapon("Melee"))
					return
				end

				if not getgenv().LoadFishingRemote then
					FishingRemote.OnClientEvent:Connect(function(arg, arg2)
						if Settings["Auto Fishing"] then
							if arg ~= localPlayer then
								return
							end

							if arg2 == "SpawnFishOnBob" then
								task.wait(0.2)
								fishingRequest:InvokeServer("Catching", true, { fastBite = true })
								task.wait(2)
								game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 1, 1)
								game.ReplicatedStorage.FishReplicated.FishingRequest:InvokeServer("Catch", 1, 0, 1)
							end
						end
					end)

					getgenv().LoadFishingRemote = true
				end
			elseif attribute == "Biting" then
				if not getgenv().delaytimeBiting then
					getgenv().delaytimeBiting = tick()
				end

				if tick() - (getgenv().delaytimeBiting or 0) >= 5 then
					EquipTool(NameWeapon("Melee"))
					task.wait(1)
				end
			else
				getgenv().delaytimeBiting = nil
			end
		end
end

-- UI adapter: API do Vxeze (CreateSection/CreateLabel/CreateToggle) em cima da lib do Zyrox
local FarmotherMain = {
	CreateSection = function(name)
		local gb = t15.SecretQuest:AddLeftGroupbox(name)
		local sec = {}
		sec.CreateLabel = function(cfg)
			local lbl = gb:AddLabel(cfg.Title or "")
			return {
				SetText = function(t)
					pcall(function()
						lbl:SetText(tostring(t))
					end)
				end,
			}
		end
		sec.CreateToggle = function(cfg, cb)
			local id = "SQ_" .. tostring(cfg.Title):gsub("%W", "_")
			local tg = gb:AddToggle(id, {
				Text = cfg.Title,
				Tooltip = cfg.Desc,
				Default = cfg.Default or false,
				Callback = function(v)
					cb(v)
				end,
			})
			return {
				SetStage = function(_, v)
					pcall(function()
						tg:SetValue(v)
					end)
				end,
			}
		end
		return sec
	end,
}
-- ---------- fim da camada de compatibilidade ----------

	HiddenEventSection = FarmotherMain.CreateSection("Secret Quest")
	StatusHiddenProgress = HiddenEventSection.CreateLabel({ Title = "Secret Quest : 0/39 Quests" })
	StatusHiddenQuest = HiddenEventSection.CreateLabel({ Title = "Title Quest : ..." })
	StatusHiddenStep = HiddenEventSection.CreateLabel({ Title = "Doing Quest : None" })
	StatusHiddenBoss = HiddenEventSection.CreateLabel({ Title = "Title Awakened Boss : None" })

	HiddenEvent = {
		progress = {},
		checked = 0,
		current = nil,
		step = "Idle",
		handlers = {},
		skipped = {},
		lastNotify = {},
	}

	GetHiddenProgress = function(arg)
		local flag

		if arg then
			flag = arg
		else
			local checked = HiddenEvent.checked
			flag = os.clock() - checked > 15
		end

		if flag then
			HiddenEvent.checked = os.clock()

			local ok, result = pcall(function()
				return ReplicatedStorage.Modules.Net["RF/RequestBonusMomentReplication"]:InvokeServer({ Type = "GetMomentProgress" })
			end)

			if ok and type(result) == "table" and type(result.Data) == "table" then
				ReportHiddenDone(HiddenEvent.progress, result.Data)
				HiddenEvent.progress = result.Data
			end
		end

		return HiddenEvent.progress
	end

	ReportHiddenDone = function(arg, arg2)
		local done = 0

		for k, v6 in pairs(arg2) do
			if type(v6) == "table" and v6.Completed then
				done += 1
				local flag = type(arg) == "table" and arg[k]

				if type(flag) == "table" and not flag.Completed then
					HiddenNotify((tostring(k):match("([^/]+)$") or tostring(k)) .. " completed", "done" .. tostring(k), "reward", { SubContent = done .. "/39 secret quests", Duration = 8 })
				end
			end
		end

		HiddenEvent.done = done
	end

	HiddenNotify = function(arg, key, arg2, arg3)
		key = key or arg
		if os.clock() - (HiddenEvent.lastNotify[key] or 0) < 20 then
			return
		end
		HiddenEvent.lastNotify[key] = os.clock()
		local tbl9 = arg3 or {}
		tbl9.Key = key
		VxezeNotify("Hidden Event", arg, arg2 or "info", tbl9)
	end

	SetHiddenStep = function(step)
		if step ~= HiddenEvent.step then
			local stepShape = tostring(step):gsub("%d+", "#")

			if stepShape ~= HiddenEvent.stepShape then
				HiddenEvent.stepShape = stepShape
				VxezeLog("Hidden", step)
			end
		end

		HiddenEvent.step = step
	end

	HiddenModules = setmetatable({}, { __index = function(arg, arg2)
		local handlers = {
			Controller = function()
				return require(ReplicatedStorage.Controllers.BonusMomentsController)
			end,
			Guide = function()
				return require(ReplicatedStorage.BonusMomentsGuide)
			end,
			Map = function()
				return require(ReplicatedStorage.Definitions.Map)
			end,
			NpcList = function()
				return require(ReplicatedStorage.NPCManager.NPCList)
			end,
			Dialogues = function()
				return require(ReplicatedStorage.DialoguesList)
			end,
			RegisterAttack = function()
				return ReplicatedStorage.Modules.Net:WaitForChild("RE/RegisterAttack")
			end,
			RegisterHit = function()
				return require(ReplicatedStorage.Modules.Net):RemoteEvent("RegisterHit", true)
			end,
		}

		local v6 = handlers[arg2] and handlers[arg2]()
		rawset(arg, arg2, v6)
		return v6
	end })

	GetHiddenIsland = function(arg)
		HiddenEvent.islands = HiddenEvent.islands or {}

		if HiddenEvent.islands[arg] == nil then
			local v6 = HiddenModules.Map.findCurrentMap()
			local v7 = pairs
			local islands = v6 and v6.Islands or {}

			for _, island in v7(islands) do
				if island.Index.Key == arg then
					HiddenEvent.islands[arg] = island
				end
			end
		end

		return HiddenEvent.islands[arg]
	end

	GetHiddenMoment = function(arg)
		return HiddenModules.Controller:GetLoadedMoments()[arg]
	end

	HiddenRelease = function()
		local anchored = HiddenEvent.anchored

		if anchored and anchored.Parent then
			anchored.Anchored = false
		end

		HiddenEvent.anchored = nil
	end

	HiddenMove = function(arg)
		HiddenRelease()

		if Settings["Auto Secret Quest"] then
			ToTarget(arg)
		end
	end

	HiddenGoTo = function(arg, arg2)
		if localPlayer:DistanceFromCharacter(arg) <= (arg2 or 8) then
			return true
		end
		HiddenMove(CFrame.new(arg))
		return false
	end

	HiddenGoToIsland = function(arg)
		local v6 = GetHiddenIsland(arg)
		if not v6 then
			return
		end
		SetHiddenStep("Travel to " .. arg)
		local position = v6.TeleportPoints[1].Position
		local v7 = nil

		for _, child in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
			if child.Name == v6.Reference.Location then
				local magnitude = (child.Position - v6.World.Position).Magnitude

				if not v7 or magnitude < v7 then
					position = child.Position
					v7 = magnitude
				end
			end
		end

		return HiddenGoTo(position + Vector3.new(0, 30, 0), 150)
	end

	HiddenHold = function(arg)
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end

		if (humanoidRootPart.Position - arg.Position).Magnitude > 3 then
			HiddenMove(arg)
			return
		end

		if HiddenEvent.anchored ~= humanoidRootPart then
			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
			humanoidRootPart.Anchored = true
			HiddenEvent.anchored = humanoidRootPart
		end

		HiddenEvent.holdTime = tick()
		TweenHoldUntil = tick() + 1
	end

	SweepHiddenTrigger = function(arg, arg2, arg3)
		HiddenRelease()
		local character = localPlayer.Character
		local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
		character = character and character:FindFirstChildOfClass("Humanoid")
		if not humanoidRootPart or not character then
			return
		end
		HiddenEvent.walking = true
		local floatForce = humanoidRootPart:FindFirstChild("FloatForce")
		local maxForce = floatForce and floatForce.MaxForce

		if floatForce then
			floatForce.MaxForce = Vector3.zero
		end

		for k in pairs(NoclipChanged) do
			if k.Parent then
				k.CanCollide = true
			end
		end

		table.clear(NoclipChanged)
		humanoidRootPart.CFrame = CFrame.new(arg2)
		humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		task.wait(0.4)
		character:MoveTo(arg3)
		local now = tick()

		while true do
			task.wait(0.1)
			tbl3.LastCall = tick()
			TweenHoldUntil = tick() + 1
			if not ((humanoidRootPart.Position - arg3).Magnitude < 6 or tick() - now > 6 or not humanoidRootPart.Parent) then
				continue
			end
			break
		end

		if floatForce and floatForce.Parent then
			floatForce.MaxForce = maxForce
		end

		HiddenEvent.walking = false
	end

	HiddenDialoguePriority = {
		"not this time",
		"help hasan",
		"return the hat",
		"you're welcome",
		"hand over",
		"claim",
		"reward",
		"i'll get it",
		"accept",
		"let's go",
		"start",
		"yes",
		"sure",
		"okay",
		"go on",
		"continue",
		"so go get it back",
	}

	HiddenDialogueAvoid = {
		"walk away",
		"leave",
		"nevermind",
		"never mind",
		"not now",
		"maybe later",
		"no thanks",
		"no, ",
		"cancel",
		"skip",
		"bye",
		"goodbye",
		"forget it",
		"i'll pass",
		"decline",
		"quit",
		"exit",
		"stop",
	}

	PickHiddenDialogue = function(arg)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		if not DialogueController.Active then
			return false
		end
		local ok, result = pcall(DialogueController.getActiveDialogue)
		ok = ok and result and result._pageStack and result._pageStack[#result._pageStack]
		if not ok then
			return false
		end
		local options2 = ok._options or {}
		if #options2 == 0 then
			pcall(DialogueController.advance)
			return false
		end
		local v6 = ipairs
		arg = arg or {}

		for _, v7 in v6(arg) do
			for _, v8 in ipairs(options2) do
				if string.find(string.lower(type(v8._text) == "table" and table.concat(v8._text, " ") or tostring(v8._text)), string.lower(v7), 1, true) then
					pcall(DialogueController.select, v8)
					return true
				end
			end
		end

		return false
	end

	AutoHiddenDialogue = function()
		if tick() < (HiddenEvent.talking or 0) then
			HiddenEvent.strayDialogue = nil
			return
		end

		if PickHiddenDialogue(HiddenDialoguePriority) then
			HiddenEvent.strayDialogue = nil
			return
		end
		local DialogueController = require(ReplicatedStorage.DialogueController)
		local ok, result = pcall(DialogueController.getActiveDialogue)
		local pageStack = DialogueController.Active and ok and result and result._pageStack and result._pageStack[#result._pageStack]

		if pageStack then
			pageStack = #(pageStack._options or {}) > 0
		end

		if pageStack then
			pageStack = tick() > (HiddenEvent.dialogueBusy or 0)
		end

		if pageStack then
			HiddenEvent.strayDialogue = HiddenEvent.strayDialogue or tick()
			local strayDialogue = HiddenEvent.strayDialogue

			if tick() - strayDialogue > 1.5 then
				HiddenEvent.strayDialogue = nil
				pcall(DialogueController.close)
			end
		else
			HiddenEvent.strayDialogue = nil
		end
	end

	HiddenDialogueLoop = function()
		while Settings["Auto Secret Quest"] do
			pcall(AutoHiddenDialogue)
			task.wait(0.4)
		end
	end

	HiddenMaterialMobs = {
		["Yeti Fur"] = { mobs = { "Snow Bandit", "Snowman" }, center = Vector3.new(1350, 60, -1300) },
		Leather = { mobs = { "Brute", "Pirate" }, center = Vector3.new(-1436, 28, 4357) },
		["Scrap Metal"] = { mobs = { "Brute", "Pirate" }, center = Vector3.new(-1436, 28, 4357) },
		["Magma Ore"] = { mobs = { "Military Soldier", "Military Spy" }, center = Vector3.new(-5300, 20, 8500) },
		["Angel Wings"] = { mobs = { "Royal Soldier", "Royal Squad" }, center = Vector3.new(-7030, 5545, 1120) },
		["Fish Tail"] = { mobs = { "Fishman Warrior", "Fishman Commando" }, center = Vector3.new(61000, 23, 1300) },
	}

	CountHiddenMaterial = function(arg)
		local v6, v7, v8 = ipairs(GetInventoryItems() or {})
		local n = 0

		for _, v9 in v6, v7, v8 do
			if tostring(v9.Name) == arg then
				n = tonumber(v9.Count) or tonumber(v9.Amount) or 1
			end
		end

		return n
	end

	FarmHiddenMaterial = function(arg, arg2)
		local v6 = HiddenMaterialMobs[arg]
		if not v6 then
			return
		end
		arg2 = arg2 or 1
		local now = tick()
		local now2 = tick()
		local str2

		while true do
			local v7 = FindHiddenEnemy(v6.mobs, v6.center, 1500)

			if not v7 then
				HiddenGoTo(v6.center, 120)
				str2 = "Look for " .. v6.mobs[1] .. " to farm " .. arg
				task.wait(0.2)
			else
				str2 = "Farm " .. arg .. " from " .. v7.Name
				HiddenEvent.stallGrace = tick() + 20
				SizePart(v7)
				BringMob(v7)
				UsedualFlock()
				HiddenMove(GetHiddenFarmCFrame(v7))
				getgenv().ClickM1(v7, true)
				task.wait()
			end

			local flag

			if tick() - now2 > 4 then
				local now3 = tick()

				if not (arg2 <= CountHiddenMaterial(arg)) then
					now2 = now3
					flag = tick() - now > 45 or not Settings["Auto Secret Quest"]

					if flag then
						break
					else
						continue
					end
				end
			else
				flag = tick() - now > 45 or not Settings["Auto Secret Quest"]

				if flag then
					break
				else
					continue
				end
			end

			break
		end

		return str2
	end

	FindHiddenWaterSpot = function()
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not humanoidRootPart then
			return
		end
		local GetWaterHeightAtLocation = require(ReplicatedStorage.Util.GetWaterHeightAtLocation)
		local raycastParams = RaycastParams.new()
		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = { localPlayer.Character, workspace.Characters, workspace.Enemies }

		local function fn(arg)
			local ok, result = pcall(GetWaterHeightAtLocation, arg)
			return ok and tonumber(result)
		end

		local function fn2(arg, arg2)
			local hit = workspace:Raycast(Vector3.new(arg.X, arg2 + 200, arg.Z), Vector3.new(0, -500, 0), raycastParams)
			return hit and hit.Position or nil
		end

		for i_ = 15, 400, 15 do
			for i_2 = 0, 11 do
				local v6 = math.rad(i_2 * 30)
				local sin = math.sin
				local vector = Vector3.new(math.cos(v6), 0, sin(v6))
				local n = humanoidRootPart.Position + vector * i_
				local v7 = fn(n)

				if v7 then
					local v8 = fn2(n, v7)

					if v8 and v8.Y >= v7 - 1 then
						local n3 = n + vector * 14
						local v9 = fn(n3)
						local v10 = v9 and fn2(n3, v9)
						if v9 and (not v10 or v10.Y < v9 - 2) then
							return Vector3.new(v8.X, v8.Y + 3, v8.Z), Vector3.new(n3.X, v9, n3.Z)
						end
					end
				end
			end
		end
	end

	TalkFishermanDialogue = function(arg, arg2, arg3)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		HiddenEvent.dialogueBusy = tick() + (arg3 or 20) + 4
		pcall(DialogueController.close)
		task.wait(0.4)
		local fisherman = HiddenModules.NpcList.List.Fisherman
		if not fisherman then
			return false
		end
		local ok, result = pcall(fisherman.DialogueCallback)
		if not ok or not result then
			return false
		end
		task.spawn(pcall, DialogueController.start, result)
		local now = tick()
		local n = 1

		while true do
			task.wait(0.4)
			local ok2, result2 = pcall(DialogueController.getActiveDialogue)
			local pageStack = ok2 and result2 and result2._pageStack and result2._pageStack[#result2._pageStack]

			if pageStack then
				local options2 = pageStack._options or {}

				if #options2 == 0 then
					pcall(DialogueController.advance)
				else
					local v6 = nil

					for _, v7 in ipairs(options2) do
						local v8 = string.lower(type(v7._text) == "table" and table.concat(v7._text, " ") or tostring(v7._text))
						local v9 = ipairs
						local tbl9 = arg or {}

						for _, v10 in v9(tbl9) do
							if not v6 and string.find(v8, string.lower(v10), 1, true) then
								v6 = v7
							end
						end
					end

					pcall(DialogueController.select, v6 or options2[1])
					n += 1
				end
			end

			local flag = arg2 and arg2() or n > 6

			if not flag then
				flag = tick() - now > (arg3 or 15)
			end

			if not flag then
				continue
			end
			break
		end

		task.wait(0.5)
		pcall(DialogueController.close)
		return arg2 and arg2() or true
	end

	GoToFisherman = function()
		local fisherman = workspace.NPCs:FindFirstChild("Fisherman")
		fisherman = fisherman and fisherman:GetPivot().Position or Vector3.new(1065, 6, -1083)
		if localPlayer:DistanceFromCharacter(fisherman) <= 12 then
			return true
		end

		if Settings["Auto Secret Quest"] then
			return HiddenSettle(fisherman + Vector3.new(0, 1.5, 4), 10)
		end
		ToTarget(CFrame.new(fisherman + Vector3.new(0, 1.5, 4)))
		return false
	end

	CountFishingBait = function(arg)
		local v6 = ipairs
		local tbl9 = GetInventoryItems() or {}

		for _, v7 in v6(tbl9) do
			if tostring(v7.Name) == arg then
				return tonumber(v7.Count) or tonumber(v7.Amount) or 1
			end
		end

		return 0
	end

	BuyHiddenFishingGear = function(arg)
		local selectBait = arg or Settings["Select Bait"] or "Basic Bait"
		if DetectRod() and CountFishingBait(selectBait) > 0 then
			return true
		end

		if not GoToFisherman() then
			return false
		end

		if tick() - (HiddenEvent.rodAsked or 0) < 20 then
			return DetectRod() ~= nil
		end
		HiddenEvent.rodAsked = tick()

		if not DetectRod() then
			TalkFishermanDialogue({ "Thanks" }, function()
				return DetectRod() ~= nil
			end, 15)
		end

		if DetectRod() and CountFishingBait(selectBait) <= 0 then
			local v6 = CountFishingBait(selectBait)

			TalkFishermanDialogue({ "Bait", selectBait, "Craft", "Buy", "Confirm", "Yes" }, function()
				return CountFishingBait(selectBait) > v6
			end, 20)
		end

		return DetectRod() ~= nil
	end

	RunHiddenFishing = function()
		if not DetectRod() then
			if not BuyHiddenFishingGear() then
				HiddenNotify("Getting a Fishing Rod from the Fisherman for Chef's Kiss", "chefrod", "start")
				return "Get a Fishing Rod from the Fisherman"
			end
			DetectRod()
		end

		local selectBait = Settings["Select Bait"] or "Basic Bait"
		local fishingData = localPlayer.Data:FindFirstChild("FishingData")
		fishingData = fishingData and fishingData:GetAttribute("SelectedBait")

		if not fishingData or fishingData == "None" then
			if CountFishingBait(selectBait) > 0 then
				CommF:InvokeServer("LoadItem", selectBait, { "Usables" })
				task.wait(0.5)
			elseif not BuyHiddenFishingGear(selectBait) then
				return "Buy fishing bait from the Fisherman"
			end
		end

		local fishSpot = HiddenEvent.fishSpot

		if fishSpot then
			fishSpot = tick() - (HiddenEvent.fishSpotAt or 0) > 120
		end

		if fishSpot then
			HiddenEvent.fishSpot = nil
		end

		if not HiddenEvent.fishSpot then
			local v6 = HiddenEvent
			local v7 = HiddenEvent
			local v8, v9 = FindHiddenWaterSpot()
			v6.fishSpot = v8
			v7.fishWater = v9
			HiddenEvent.fishSpotAt = tick()
		end

		local fishSpot2 = HiddenEvent.fishSpot
		if not fishSpot2 then
			return "Looking for a shore to fish from"
		end

		if localPlayer:DistanceFromCharacter(fishSpot2) > 10 then
			HiddenMove(CFrame.new(fishSpot2, HiddenEvent.fishWater or fishSpot2 + Vector3.new(0, 0, 5)))
			return "Go to the shore to fish"
		end
		HiddenHold(CFrame.new(fishSpot2, HiddenEvent.fishWater or fishSpot2 + Vector3.new(0, 0, 5)))
		pcall(RunFishingCycle)
		task.wait(0.4)
		return "Fishing at the shore for Chef's Kiss"
	end

	GetHiddenFishCount = function()
		local tbl9 = {}

		for _, child in ipairs(ReplicatedStorage.FishReplicated.FishData:GetChildren()) do
			tbl9[child.Name] = true
		end

		local v6, v7, v8 = ipairs(GetInventoryItems() or {})
		local n = 0

		for _, v9 in v6, v7, v8 do
			if tbl9[tostring(v9.Name)] then
				n += tonumber(v9.Count) or 1
			end
		end

		return n
	end

	PrepareHiddenChef = function(arg)
		if arg["Sea1/Pirate Village/Chef's Kiss"] == true then
			return
		end

		if CountHiddenMaterial("Yeti Fur") < 1 then
			HiddenEvent.current = "Chef's Kiss"
			HiddenEvent.prepUntil = tick() + 60
			SetHiddenStep(FarmHiddenMaterial("Yeti Fur", 1) or "Farm Yeti Fur for Chef's Kiss")
			return true
		end

		if GetHiddenFishCount() < 1 then
			HiddenEvent.current = "Chef's Kiss"
			HiddenEvent.prepUntil = tick() + 60
			SetHiddenStep(RunHiddenFishing() or "Fishing for Chef's Kiss")
			return true
		end

		HiddenEvent.prepUntil = nil
	end

	GatherChefIngredients = function()
		local text = HiddenEvent.chefMissing and HiddenEvent.chefMissing.text or ""
		local v6 = string.lower(text)

		for k in pairs(HiddenMaterialMobs) do
			if string.find(text, k, 1, true) and CountHiddenMaterial(k) < 1 then
				local v7 = FarmHiddenMaterial(k)
				if v7 then
					return v7
				end
			end
		end

		local flag = string.find(v6, "fish", 1, true) ~= nil

		if not flag then
			for _, child in ipairs(ReplicatedStorage.FishReplicated.FishData:GetChildren()) do
				if string.find(text, child.Name, 1, true) then
					flag = true
					break
				end
			end
		end

		if flag then
			local v7 = RunHiddenFishing()
			if v7 then
				return v7
			end
		end

		if string.find(v6, "material", 1, true) or string.find(v6, "ingredient", 1, true) then
			for k in pairs(HiddenMaterialMobs) do
				if CountHiddenMaterial(k) > 0 then
					return
				end
			end

			local v7 = FarmHiddenMaterial("Yeti Fur", 1)
			if v7 then
				return v7
			end
		end
	end

	ResetHiddenMomentFlag = function(arg, arg2, arg3)
		for _, v6 in pairs(getgc()) do
			if type(v6) == "function" and islclosure(v6) and debug.info(v6, "n") == arg2 and string.find(tostring(debug.info(v6, "s")), arg, 1, true) then
				local ok, result = pcall(debug.getupvalues, v6)

				if ok and type(result[arg3]) == "boolean" then
					pcall(debug.setupvalue, v6, arg3, false)
				end
			end
		end
	end

	TalkHiddenQuestNpc = function(arg, arg2)
		pcall(function()
			local v6 = HiddenModules.NpcList.List[arg].DialogueCallback()

			if type(v6) == "table" and type(v6.Get) == "function" then
				v6:Get()
			end
		end)

		task.wait(0.6)
		local v6 = GetHiddenDialogueKey(arg)

		if v6 then
			pcall(HiddenModules.Guide.interactQuestGiver, v6)
		end

		return RunHiddenDialogue(arg2, 10)
	end

	RunHiddenDialogue = function(arg, arg2)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		local now = tick()
		HiddenEvent.dialogueBusy = tick() + (arg2 or 12) + 2
		local flag = false

		while true do
			task.wait(0.3)
			HiddenEvent.stallGrace = tick() + 20

			if PickHiddenDialogue(arg) then
				flag = true
			end

			local flag2 = flag and not DialogueController.Active

			if not flag2 then
				flag2 = tick() - now > (arg2 or 12)
			end

			if not flag2 then
				continue
			end
			break
		end

		if flag and DialogueController.Active then
			task.wait(1)
			pcall(DialogueController.close)
		end

		return flag
	end

	HiddenSettle = function(arg, arg2)
		if not HiddenGoTo(arg, arg2) then
			HiddenEvent.arrived = nil
			return false
		end
		HiddenHold(CFrame.new(arg))
		HiddenEvent.arrived = HiddenEvent.arrived or tick()

		if not game:GetService("CollectionService"):HasTag(localPlayer, "Teleporting") then
			HiddenEvent.teleportTag = nil
		else
			HiddenEvent.teleportTag = HiddenEvent.teleportTag or tick()
		end

		local arrived = HiddenEvent.arrived
		local flag = tick() - arrived > 1.5

		if flag then
			flag = not HiddenEvent.teleportTag

			if not flag then
				local teleportTag = HiddenEvent.teleportTag
				flag = tick() - teleportTag > 6
			end
		end

		return flag
	end

	ListenHiddenMoment = function(arg, arg2)
		return ReplicatedStorage.Remotes.BonusMomentsRemoteEvent.OnClientEvent:Connect(function(arg3, arg4, ...)
			if arg3 == arg then
				arg2(arg4, ...)
			end
		end)
	end

	HitHiddenPart = function(arg)
		if localPlayer:DistanceFromCharacter(arg.Position) > 12 then
			HiddenMove(arg.CFrame * CFrame.new(0, 0, 6))
			return
		end
		HiddenHold(localPlayer.Character.HumanoidRootPart.CFrame)
		EquipHiddenWeapon("Melee")

		if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
			HiddenEvent.lastHit = os.clock()
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(arg)
		end
	end

	IsHiddenEnemyMine = function(arg)
		local attribute = arg:GetAttribute("LocalEnemy")
		if attribute and attribute ~= localPlayer.Name then
			return false
		end
		local num = tonumber(arg:GetAttribute("BossEngagedWith"))
		if num and num ~= localPlayer.UserId and not arg:GetAttribute("BossIndicatorAwakened") then
			return false
		end
		return true
	end

	IsHiddenTarget = function(arg)
		local humanoid = arg and arg.Parent and arg:FindFirstChildWhichIsA("Humanoid")
		return humanoid ~= nil and humanoid.Health > 0 and arg:FindFirstChild("HumanoidRootPart") ~= nil and IsHiddenEnemyMine(arg)
	end

	FindHiddenEnemyNear = function(arg, arg2)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsHiddenTarget(child) and (child:GetPivot().Position - arg).Magnitude <= arg2 then
				local v7 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

				if v7 < huge then
					huge = v7
					v6 = child
				end
			end
		end

		return v6
	end

	FindHiddenEnemy = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if table.find(arg, child.Name) and IsHiddenTarget(child) and (child:GetPivot().Position - arg2).Magnitude <= arg3 then
				local v7 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

				if v7 < huge then
					huge = v7
					v6 = child
				end
			end
		end

		return v6
	end

	HiddenDodge = { untilTime = 0, target = nil, animations = {}, connection = nil, watching = false }
	IsHiddenDodging = function()return HiddenDodge.target~=nil and tick()<HiddenDodge.untilTime;end
	TriggerHiddenDodge = function(c)if HiddenDodge.target then HiddenDodge.untilTime=math.max(HiddenDodge.untilTime,tick()+math.clamp(c,0.3,8));end;end

	IsHiddenBoss = function(arg)
		if arg:GetAttribute("BossIndicatorAwakened") then
			return true
		end
		local v6 = ipairs
		local tbl9 = HiddenQuests or {}

		for _, v7 in v6(tbl9) do
			if v7.BossNames and table.find(v7.BossNames, arg.Name) then
				return true
			end
		end

		return false
	end

	OnHiddenEnemyAnimation = function(c)if c.Looped then return;end;local n,L=c.Animation and c.Animation.AnimationId or"",tick();local U=HiddenDodge.animations[n];if not U or L-U.since>20 then U={count=0,since=L};HiddenDodge.animations[n]=U;end;U.count=U.count+1;if U.count>4 then return;end;task.wait(0.05);if c.IsPlaying and c.Length>=0.9 then TriggerHiddenDodge(c.Length/math.max(c.Speed,0.1)+0.3);end;end
	OnHiddenEnemySkill = function(n)if not HiddenDodge.target then return;end;if not n:IsA("BodyGyro")and not n:IsA("BodyPosition")and not string.find(n.Name,"KiBlast",1,true)then return;end;local L=n.Parent;while L and L.Parent~=workspace.Enemies do L=L.Parent;end;local U=L and(L:FindFirstChild("HumanoidRootPart"));if not U or L~=HiddenDodge.target and  localPlayer :DistanceFromCharacter(U.Position)>70 then return;end;L=tick();TriggerHiddenDodge(1);while n.Parent and HiddenDodge.target and tick()-L<8 do TriggerHiddenDodge(0.5);task.wait(0.2);end;end

	WatchHiddenEnemy = function(target)
		if HiddenDodge.target == target then
			return
		end
		StopHiddenDodge()
		HiddenDodge.target = target
		local humanoid = target:FindFirstChildOfClass("Humanoid")

		if humanoid then
			humanoid = humanoid:FindFirstChildOfClass("Animator") or humanoid
		end

		if humanoid then
			HiddenDodge.connection = humanoid.AnimationPlayed:Connect(OnHiddenEnemyAnimation)
		end

		if not HiddenDodge.watching then
			HiddenDodge.watching = true
			workspace.Enemies.DescendantAdded:Connect(OnHiddenEnemySkill)
		end
	end

	StopHiddenDodge = function()
		if HiddenDodge.connection then
			HiddenDodge.connection:Disconnect()
			HiddenDodge.connection = nil
		end

		table.clear(HiddenDodge.animations)
		HiddenDodge.target = nil
		HiddenDodge.untilTime = 0
	end

	GetHiddenFarmCFrame = function(c)local n,L=c.HumanoidRootPart,Settings["Select Weapon"]=="Blox Fruit";local U=HiddenEvent.farmHeight or L and(getgenv().YPosFruit or 20)or 20;return n.CFrame*CFrame.new(L and-7 or 7,if IsHiddenDodging()then U+(IsHiddenBoss(c)and 40 or 25)else U,0);end

	KillHiddenEnemy = function(fighting)
		local now = tick()
		local v6 = IsHiddenBoss(fighting)
		local n = v6 and 180 or 45
		HiddenEvent.fighting = fighting
		WatchHiddenEnemy(fighting)

		while true do
			task.wait()

			if not fighting:FindFirstChild("HumanoidRootPart") then
				break
			else
				SizePart(fighting)

				if not v6 then
					BringMob(fighting)
				end

				UsedualFlock()
				local humanoidRootPart = fighting:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart then
					local cFrame = humanoidRootPart.CFrame
					getgenv().AimPos = cFrame
				end

				HiddenMove(GetHiddenFarmCFrame(fighting))
				getgenv().ClickM1(fighting, true)
				if not (not IsHiddenTarget(fighting) or not Settings["Auto Secret Quest"] or tick() - now > n) then
					continue
				end
				break
			end
		end

		HiddenEvent.fighting = nil
		StopHiddenDodge()
	end

	GetHiddenDialogueKey = function(arg)
		local v6 = HiddenModules.NpcList.List[arg]
		local tbl9 = {}
		local fn = nil

		fn = function(arg2, arg3)
			if type(arg2) ~= "function" or tbl9[arg2] or arg3 > 3 then
				return nil
			end
			tbl9[arg2] = true
			local ok, result = pcall(debug.getconstants, arg2)
			local v7 = ipairs
			local tbl10 = ok and result or {}

			for _, v8 in v7(tbl10) do
				if type(v8) == "string" and rawget(HiddenModules.Dialogues, v8) ~= nil then
					return v8
				end
			end

			local ok2, result2 = pcall(debug.getupvalues, arg2)
			local v8 = pairs
			result2 = ok2 and result2 or {}

			for _, v9 in v8(result2) do
				local flag = fn(v9, arg3 + 1) or type(v9) == "table" and fn(rawget(v9, "original"), arg3 + 1)
				if flag then
					return flag
				end
			end
		end

		return fn(v6 and v6.DialogueCallback, 0)
	end

	FindHiddenNpc = function(arg, arg2)
		for _, v6 in ipairs({ workspace.NPCs, ReplicatedStorage.NPCs }) do
			for _, child in ipairs(v6:GetChildren()) do
				if child:IsA("Model") and (child:GetPivot().Position - arg).Magnitude <= arg2 then
					return child
				end
			end
		end
	end

	ClaimHiddenReward = function()
		local v6 = HiddenModules.Guide.getRewardTracker()
		local target = v6 and v6.Options and v6.Options.Target
		HiddenEvent.rewardSeen = HiddenEvent.rewardSeen or {}

		if typeof(target) == "Vector3" then
			HiddenEvent.rewardSeen[tostring(target)] = { position = target, time = tick() }
		end

		local rewardLock = HiddenEvent.rewardLock
		local v7 = rewardLock and HiddenEvent.rewardSeen[tostring(rewardLock)]
		local flag = not v7
		local flag2

		if flag then
			flag2 = flag
		else
			local time_ = v7.time
			flag2 = tick() - time_ > 8
		end

		if not flag2 then
			flag2 = tick() < (HiddenEvent.skipped["Reward:" .. tostring(rewardLock)] or 0)
		end

		if flag2 then
			local v8 = nil
			rewardLock = nil

			for k, v9 in pairs(HiddenEvent.rewardSeen) do
				local v10 = localPlayer:DistanceFromCharacter(v9.position)
				local time_ = v9.time
				local flag3 = tick() - time_ <= 8

				if flag3 then
					flag3 = tick() >= (HiddenEvent.skipped["Reward:" .. k] or 0)
				end

				if flag3 and (not v8 or v10 < v8) then
					rewardLock = v9.position
					v8 = v10
				end
			end

			HiddenEvent.rewardLock = rewardLock
		end

		if typeof(rewardLock) ~= "Vector3" then
			return false
		end
		local reward = tostring(rewardLock)
		local v8 = FindHiddenNpc(rewardLock, 15)
		HiddenEvent.current = "Claim Reward"
		SetHiddenStep("Talk to " .. (v8 and v8.Name or "the quest giver") .. " for reward")
		if not v8 then
			HiddenGoTo(rewardLock + Vector3.new(0, 5, 0), 20)
			return true
		end

		if HiddenSettle(rewardLock + Vector3.new(0, 1.5, 4), 10) then
			HiddenEvent.dialogueBusy = tick() + 12

			pcall(function()
				local v9 = HiddenModules.NpcList.List[v8.Name].DialogueCallback()

				if type(v9) == "table" and type(v9.Get) == "function" then
					v9:Get()
				end
			end)

			task.wait(1)
			local v9 = HiddenModules.Guide.getRewardTracker()
			local v10 = GetHiddenDialogueKey(v8.Name)

			if v10 and v9 and v9.Options and v9.Options.Target == rewardLock then
				HiddenModules.Guide.interactQuestGiver(v10)
			end

			HiddenEvent.checked = 0
			HiddenEvent.rewardSeen[tostring(rewardLock)] = nil
			HiddenEvent.rewardLock = nil
			local flag3 = false

			for i_ = 1, 8 do
				task.wait(0.5)
				local v11 = HiddenModules.Guide.getRewardTracker()
				flag3 = flag3 or v11 and v11.Options and v11.Options.Target == rewardLock
			end

			if flag3 then
				HiddenEvent.skipped["Reward:" .. reward] = tick() + 300
				HiddenNotify("Could not claim the reward from " .. v8.Name .. ", retry later", nil, "warning")
			else
				HiddenNotify("Claimed reward from " .. v8.Name, nil, "reward")
			end
		end

		return true
	end

	EquipHiddenWeapon = function(arg)
		local character = localPlayer.Character
		local v6 = NameWeapon(arg, true)
		local flag = not v6

		if flag then
			flag = os.clock() - (HiddenEvent.loadedWeapon or 0) > 5
		end

		if flag then
			HiddenEvent.loadedWeapon = os.clock()

			for _, v7 in ipairs(GetInventoryItems()) do
				if v7.Type == arg then
					CommF:InvokeServer("LoadItem", v7.Name)
					task.wait(0.5)
					v6 = NameWeapon(arg, true)
					break
				end
			end
		end

		local flag2 = not v6 and arg == "Gun"

		if flag2 then
			flag2 = os.clock() - (HiddenEvent.boughtGun or 0) > 30
		end

		if flag2 then
			HiddenEvent.boughtGun = os.clock()
			VxezeNotify("Hidden Event", "No gun in backpack or inventory, buying a Slingshot for the quest", "info", { Key = "hiddenbuygun" })

			pcall(function()
				CommF:InvokeServer("BuyItem", "Slingshot")
			end)

			task.wait(1)

			for _, v7 in ipairs(GetInventoryItems()) do
				if v7.Type == "Gun" then
					CommF:InvokeServer("LoadItem", v7.Name)
					task.wait(0.5)
					break
				end
			end

			v6 = NameWeapon(arg, true)
		end

		if v6 and v6.Parent ~= character then
			character.Humanoid:EquipTool(v6)
		end

		return v6
	end

	GetHiddenState = function(arg, arg2)
		HiddenEvent.states = HiddenEvent.states or {}
		local tbl9 = HiddenEvent.states[arg]

		if not tbl9 then
			tbl9 = {}
			HiddenEvent.states[arg] = tbl9

			ListenHiddenMoment(arg, function(arg3, ...)
				local v6 = tbl9
				local v7 = table.pack(...)
				local v8 = arg2
				v7.n = 3 + v7.n - 1
				table.move(v7, 1, v7.n, 3, v7)
				v7[1] = v6
				v7[2] = arg3
				v8(table.unpack(v7, 1, v7.n))
			end)
		end

		return tbl9
	end

	FindTaggedPartNear = function(arg, arg2)
		for _, v6 in ipairs(game:GetService("CollectionService"):GetTagged("M1HitRegistry")) do
			if (v6.Position - arg).Magnitude <= arg2 then
				return v6
			end
		end
	end

	GetPrisonLocation = function(arg)
		local bonusMomentLocations = workspace.Map.Prison:FindFirstChild("BonusMoment_Locations", true)
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild(arg, true)
		return bonusMomentLocations and bonusMomentLocations:GetPivot().Position
	end

	FindHiddenEnemyMatch = function(arg, arg2, arg3)
		local huge = math.huge
		local v6 = nil

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if IsHiddenTarget(child) and (child:GetPivot().Position - arg2).Magnitude <= arg3 then
				for _, v7 in ipairs(arg) do
					if string.find(child.Name, v7, 1, true) then
						local v8 = localPlayer:DistanceFromCharacter(child:GetPivot().Position)

						if v8 < huge then
							huge = v8
							v6 = child
						end

						break
					end
				end
			end
		end

		return v6
	end

	FindHiddenPromptNear = function(arg, arg2, arg3)
		local v6, v7, v8 = ipairs(arg)
		local v9 = nil
		local v10 = nil

		for _, v11 in v6, v7, v8 do
			for _, descendant in ipairs(v11:GetDescendants()) do
				if descendant:IsA("ProximityPrompt") and descendant.Enabled then
					local parent = descendant.Parent
					local worldPosition = parent:IsA("Attachment") and parent.WorldPosition or parent:IsA("BasePart") and parent.Position or parent:IsA("Model") and parent:GetPivot().Position
					local magnitude = worldPosition and (worldPosition - arg2).Magnitude

					if magnitude and magnitude <= arg3 and (not v9 or magnitude < v9) then
						v9 = magnitude
						v10 = descendant
					end
				end
			end
		end

		return v10
	end

	HoldHiddenPrompt = function(arg)
		if not pcall(function()
			arg:InputHoldBegin()
			task.wait(arg.HoldDuration + 0.35)
			arg:InputHoldEnd()
		end) and fireproximityprompt then
			pcall(fireproximityprompt, arg, arg.HoldDuration + 0.35)
		end
	end

	FindTaggedPartIn = function(arg)
		if not arg then
			return nil
		end
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(game:GetService("CollectionService"):GetTagged("M1HitRegistry")) do
			if v8:IsDescendantOf(arg) then
				local v9 = localPlayer:DistanceFromCharacter(v8.Position)

				if not v6 or v9 < v6 then
					v6 = v9
					v7 = v8
				end
			end
		end

		return v7
	end

	GetNpcPosition = function(arg)
		local v6 = workspace.NPCs:FindFirstChild(arg) or ReplicatedStorage.NPCs:FindFirstChild(arg)
		if v6 then
			return v6:GetPivot().Position
		end
		local v7 = require(ReplicatedStorage.NPCManager).getNPCsByName(arg)[1]
		local instance = v7 and v7._modelState and v7._modelState._instance
		return instance and instance:GetPivot().Position
	end

	HoistHiddenFlag = function(arg, arg2)
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		local tbl9 = {}
		local flag = false

		local v6 = ListenHiddenMoment("Fortress Flagpole", function(arg3, arg4, arg5, arg6)
			if arg3 == "Shell" and typeof(arg4) == "Vector3" then
				table.insert(tbl9, { position = arg4, time = tick() + (arg5 or 1.4), radius = arg6 or 9 })
			elseif arg3 == "Completed" then
				flag = true
			end
		end)

		arg:FireServer("Hoist")
		local now = tick()
		local v7 = arg2

		while Settings["Auto Secret Quest"] and not flag and tick() - now < 100 and humanoidRootPart.Parent do
			task.wait(0.05)
			local flag2 = false

			for _, v8 in ipairs(tbl9) do
				local vector = Vector3.new(v7.X - v8.position.X, 0, v7.Z - v8.position.Z)

				if not flag2 then
					local n = v8.time + 0.5
					flag2 = tick() < n and vector.Magnitude < v8.radius + 4
				end
			end

			if flag2 then
				local v8 = nil

				for i_ = 0, 330, 30 do
					for _, v9 in ipairs({ 2, 7, 12, 15 }) do
						local n = arg2 + Vector3.new(math.cos(math.rad(i_)) * v9, 0, math.sin(math.rad(i_)) * v9)
						local v10, v11, v12 = ipairs(tbl9)
						local huge = math.huge

						for _, v13 in v10, v11, v12 do
							local n3 = v13.time + 0.5

							if tick() < n3 then
								local radius = v13.radius
								huge = math.min(huge, Vector3.new(n.X - v13.position.X, 0, n.Z - v13.position.Z).Magnitude - radius)
							end
						end

						if not v8 or huge > v8 then
							v8 = huge
							v7 = n
						end
					end
				end
			end

			if (humanoidRootPart.Position - v7).Magnitude > 1.5 then
				humanoidRootPart.CFrame = CFrame.new(v7)
			end

			humanoidRootPart.AssemblyLinearVelocity = Vector3.zero

			for i_ = #tbl9, 1, -1 do
				if tbl9[i_].time + 1.5 < tick() then
					table.remove(tbl9, i_)
				end
			end
		end

		v6:Disconnect()
		HiddenEvent.checked = 0
	end

	TalkHiddenNpc = function(arg, arg2)
		local DialogueController = require(ReplicatedStorage.DialogueController)
		HiddenEvent.talking = tick() + 25

		local function fn()
			local v6 = DialogueController.getActiveDialogue()
			return v6 and v6._pageStack[#v6._pageStack]
		end

		pcall(DialogueController.close)
		task.wait(0.3)
		task.spawn(pcall, DialogueController.start, HiddenModules.NpcList.List[arg].DialogueCallback())
		local now = tick()
		local n = 0

		while true do
			if tick() - now < 20 and n < #arg2 then
				task.wait(0.4)
				local v6 = fn()

				if v6 then
					local options2 = v6._options or {}

					if #options2 == 0 then
						pcall(DialogueController.advance)
						continue
					else
						local v7 = nil

						for _, v8 in ipairs(options2) do
							if table.concat(v8._text or {}, " ") == arg2[n + 1] then
								v7 = v8
							end
						end

						if v7 then
							n += 1
							DialogueController.select(v7)
							task.wait(1)
							continue
						end
					end
				else
					continue
				end
			end

			break
		end

		task.wait(1)
		pcall(DialogueController.close)
		return n == #arg2
	end

	RunHiddenTempleIntel = function(arg)
		local v6 = GetHiddenState("Temple Intel", function(arg2, arg3, arg4, arg5)
			if arg3 == "Reveal" then
				arg2.revealed = tick()
				arg2.solved = arg5 == true
			elseif arg3 == "Storm" then
				arg2.storm = arg4 == true
			elseif arg3 == "Clear" or arg3 == "Dropped" then
				arg2.storm = false
				arg2.solved = false
				arg2.carrying = false
			end
		end)

		if not rawget(arg, "HiddenGuard") then
			local fireServer = arg.FireServer
			arg.HiddenGuard = true

			arg.FireServer = function(arg2, arg3, ...)
				if arg3 == "Struck" then
					return
				end
				local v7 = table.pack(...)
				local v8 = fireServer
				v7.n = 3 + v7.n - 1
				table.move(v7, 1, v7.n, 3, v7)
				v7[1] = arg2
				v7[2] = arg3
				return v8(table.unpack(v7, 1, v7.n))
			end
		end

		if v6.carrying or v6.storm then
			local v7 = GetNpcPosition("Sky Quest Giver 2")

			if v7 and HiddenSettle(v7 + Vector3.new(0, 1.5, 4), 10) then
				TalkHiddenNpc("Sky Quest Giver 2", { "The old temple", "Hand over the Intel" })
				HiddenEvent.checked = 0
				v6.carrying = false
			end

			return "Bring the Intel back to Sky Quest Giver 2"
		end

		local flag = not v6.revealed

		if not flag then
			local revealed = v6.revealed
			flag = tick() - revealed > 6
		end

		if flag then
			if HiddenSettle(Vector3.new(-7389.5, 5599, 339) + Vector3.new(0, 6, 0), 10) then
				local arrived = HiddenEvent.arrived

				if tick() - arrived > 9 then
					HiddenEvent.arrived = nil
					local v7 = GetNpcPosition("Sky Quest Giver 2")
					local now = tick()

					while Settings["Auto Secret Quest"] and tick() - now < 60 do
						task.wait(0.3)
						if v7 and HiddenSettle(v7 + Vector3.new(0, 1.5, 4), 10) then
							TalkHiddenNpc("Sky Quest Giver 2", { "The old temple", "I'll get it" })
							return "Accept The old temple quest"
						end
					end

					return "Accept The old temple quest"
				end
			end

			return "Enter the old temple"
		end

		if not HiddenSettle(Vector3.new(-7389.5, 5599, 339) + Vector3.new(0, 6, 0), 10) then
			HiddenEvent.stallGrace = tick() + 5
			return "Go back into the old temple"
		end

		if not v6.solved then
			arg:FireServer("Solved")
			task.wait(2)
			return "Turn the coils"
		end

		if arg:InvokeServer("TakeIntel") == true then
			v6.carrying = true
			HiddenNotify("Took the Intel, running back", nil, "found")
		end

		return "Take the Intel"
	end

	RunHiddenLookout = function(arg)
		local response = arg:InvokeServer("StartAttempt")
		if type(response) ~= "table" or type(response.Token) ~= "string" or type(response.Manifest) ~= "table" then
			return "Captain is not ready for lookout duty", true
		end
		local response2

		while Settings["Auto Secret Quest"] do
			local str2 = "/4: watching " .. #response.Manifest .. " ships"
			SetHiddenStep("Lookout round " .. tostring(response.Round) .. str2)
			local now = tick()

			while true do
				response2 = arg:InvokeServer("ObservationFinished", response.Token)
				local v6 = nil

				if type(response2) ~= "table" then
					response2 = v6
					break
				else
					if response2.Ready == false then
						task.wait(math.clamp(tonumber(response2.RetryAfter) or 1, 0.2, 5))
						response2 = nil
						if not (tick() - now > 120) then
							continue
						end
					end

					break
				end
			end

			if not response2 then
				arg:InvokeServer("AbortAttempt", response.Token)
				return "Lookout observation failed, retrying", true
			end
			local n = 0

			for _, v6 in ipairs(response.Manifest) do
				if v6.Boat == response2.TargetBoat and v6.FlagColor == response2.TargetFlagColor then
					n += 1
				end
			end

			local response3 = arg:InvokeServer("SubmitAnswer", response.Token, n)
			if type(response3) ~= "table" then
				return "Lookout answer was rejected", true
			end

			if response3.Correct ~= true then
				if type(response3.FinaleToken) == "string" then
					arg:InvokeServer("FinishFinale", response3.FinaleToken)
				end

				HiddenNotify("Lookout miscounted (" .. n .. " " .. tostring(response2.TargetFlagColor) .. " " .. tostring(response2.TargetBoat) .. "), retrying", nil, "warning")
				return "Lookout miscount, retrying"
			end

			if type(response3.NextRound) == "table" and type(response3.NextRound.Token) == "string" then
				response = response3.NextRound
				task.wait(1.25)
				continue
			end

			if type(response3.FinaleToken) == "string" then
				arg:InvokeServer("FinishFinale", response3.FinaleToken)
			end

			HiddenModules.Guide.interactQuestGiver("TravelDressrosa")
			HiddenEvent.checked = 0
			HiddenNotify("Lookout duty complete", nil, "success")
			return "Lookout duty complete"
		end

		return "Lookout stopped"
	end

	BuildHiddenSnowman = function(arg)
		if not HiddenSettle(Vector3.new(1300, 60, -1450), 40) then
			return "Go to the Frozen Village square"
		end
		local tbl9 = {}
		local flag = false

		local Snowman = ListenHiddenMoment("Snowman", function(arg2, arg3)
			if arg2 == "Setup" and type(arg3) == "table" then
				for k, v6 in pairs(arg3) do
					tbl9[k] = v6
				end
			elseif arg2 == "Alive" then
				flag = true
			end
		end)

		arg:FireServer("Init")
		task.wait(3)
		if not next(tbl9) then
			Snowman:Disconnect()
			return "Waiting for snow piles on Frozen Village", true
		end
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		local snowmanBallRemote = ReplicatedStorage.Remotes.SnowmanBallRemote
		local snowmanStackRemote = ReplicatedStorage.Remotes.SnowmanStackRemote
		local tbl10 = {}
		local tbl11 = {}
		HiddenEvent.snowSequence = (HiddenEvent.snowSequence or 0) + 1000

		local function fn()
			local v6 = HiddenEvent
			v6.snowSequence = v6.snowSequence + 1
			local tbl12 = {}

			for _, v7 in ipairs(tbl10) do
				table.insert(tbl12, { i = v7.i, c = v7.c, d = v7.d })
			end

			snowmanBallRemote:FireServer(HiddenEvent.snowSequence, tbl12)
		end

		local function fn2(arg2)
			local now = tick()
			HiddenEvent.arrived = nil

			while Settings["Auto Secret Quest"] and tick() - now < 60 do
				task.wait(0.1)
				fn()
				if HiddenSettle(arg2, 8) then
					return true
				end
			end
		end

		local n = 0
		local cframe = nil

		for k, v6 in pairs(tbl9) do
			if not (not Settings["Auto Secret Quest"] or not fn2(v6.Position + Vector3.new(0, 3, 0))) then
				SetHiddenStep("Roll snowball " .. n + 1 .. "/3")
				arg:FireServer("GrabSnowball", k)
				n += 1
				local tbl12 = { i = n, c = humanoidRootPart.CFrame, d = 5 }
				table.insert(tbl10, tbl12)
				local n3 = humanoidRootPart.CFrame.LookVector * Vector3.new(1, 0, 1)
				local vector = n3.Magnitude < 0.1 and Vector3.new(0, 0, -1) or n3.Unit

				for i_ = 3.5, 315, 3.5 do
					task.wait(0.066666666666666666)
					tbl12.d = math.clamp(i_ / 300, 0, 1) * 10 + 5
					tbl12.c = CFrame.new(humanoidRootPart.Position + vector * (tbl12.d / 2 + 2.5))
					fn()
				end

				if not cframe then
					cframe = CFrame.new(tbl12.c.Position - Vector3.new(0, tbl12.d / 2, 0))
				else
					SetHiddenStep("Stack snowball " .. n .. "/3")
					fn2(cframe.Position + Vector3.new(0, 3, 12))
					tbl12.c = CFrame.new(cframe.Position + Vector3.new(0, 7.5, 0))
					fn()
					task.wait(0.2)
					table.insert(tbl11, 15)

					if #tbl11 == 1 then
						table.insert(tbl11, 15)
					end

					tbl10 = {}
					fn()
					snowmanStackRemote:FireServer(tbl11, cframe)
				end

				task.wait(1)
				continue
			end

			break
		end

		local now = tick()

		while true do
			task.wait(0.5)
			if not (flag or tick() - now > 8) then
				continue
			end
			break
		end

		Snowman:Disconnect()

		if flag then
			task.wait(2)
			arg:FireServer("Finished")
			HiddenEvent.checked = 0
			HiddenNotify("Snowman is alive again", nil, "found")
			return "Snowman built"
		end

		tbl10 = {}
		fn()
		return "Snowman failed, retrying", true
	end

	FaceHiddenTarget = function(arg)
		local humanoidRootPart = localPlayer.Character.HumanoidRootPart
		humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, Vector3.new(arg.X, humanoidRootPart.Position.Y, arg.Z))
		workspace.CurrentCamera.CFrame = CFrame.lookAt(humanoidRootPart.Position + Vector3.new(0, 2, 0), arg)
	end

	GetHiddenFruitM1 = function()
		local v6 = NameWeapon("Blox Fruit")
		local character = localPlayer.Character

		if v6 then
			v6 = character and character:FindFirstChild(v6) or localPlayer.Backpack:FindFirstChild(v6)
		end

		return v6
	end

	NotifyHiddenFruitM1 = function(arg)
		if os.clock() - (HiddenEvent.fruitNotified or -300) < 300 then
			return
		end
		HiddenEvent.fruitNotified = os.clock()
		local value = localPlayer.Data.DevilFruit.Value
		VxezeNotify("Hidden Event", (value == "" and "You have no Blox Fruit" or value .. " has no M1 attack") .. ", please eat a Blox Fruit that has M1 (left click) for " .. arg, "warning", { Duration = 10 })
	end

	FindHiddenFruitTool = function()
		for _, v6 in ipairs({ localPlayer.Backpack, localPlayer.Character }) do
			for _, child in ipairs(v6:GetChildren()) do
				if child:IsA("Tool") and child:FindFirstChild("EatRemote") then
					return child
				end
			end
		end
	end

	EnsureHiddenFruit = function(arg)
		if GetHiddenFruitM1() then
			return true
		end

		if localPlayer.Data.DevilFruit.Value ~= "" then
			return false, "your eaten fruit has no M1 attack"
		end
		local v6 = FindHiddenFruitTool()

		if not v6 then
			local v7 = TakeFruitInventory()
			if not v7 then
				return false, "no Blox Fruit in backpack or inventory, skipping this quest"
			end
			VxezeNotify("Hidden Event", "Loading " .. v7 .. " from inventory to eat for " .. tostring(arg), "info", { Key = "hiddenloadfruit" })
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", v7)
			local now = tick()

			while true do
				task.wait(0.3)
				v6 = FindHiddenFruitTool()
				if not (v6 or tick() - now > 4) then
					continue
				end
				break
			end

			if not v6 then
				return false, "could not load a Blox Fruit from inventory, skipping this quest"
			end
		end

		pcall(function()
			localPlayer.Character.Humanoid:EquipTool(v6)
		end)

		task.wait(0.4)
		local eatRemote = v6:FindFirstChild("EatRemote")

		if eatRemote then
			pcall(function()
				eatRemote:InvokeServer("Eat")
			end)
		end

		local now = tick()

		while true do
			task.wait(0.3)
			if not (localPlayer.Data.DevilFruit.Value ~= "" or tick() - now > 4) then
				continue
			end
			break
		end

		if localPlayer.Data.DevilFruit.Value == "" then
			return false, "could not eat the Blox Fruit, skipping this quest"
		end
		VxezeNotify("Hidden Event", "Ate " .. tostring(localPlayer.Data.DevilFruit.Value) .. " for " .. tostring(arg), "success", { Key = "hiddenatefruit" })
		task.wait(1.5)
		if not GetHiddenFruitM1() then
			return false, "the eaten fruit has no M1 attack"
		end
		return true
	end

	UseHiddenSkillAt = function(arg)
		if not EquipHiddenWeapon("Blox Fruit") then
			return false
		end
		local skills = localPlayer.PlayerGui.Main:FindFirstChild("Skills")
		skills = skills and skills:FindFirstChild(localPlayer.Data.DevilFruit.Value)
		local v6 = nil

		for _, v7 in ipairs({ "Z", "X", "C", "V", "F" }) do
			local v8 = skills and skills:FindFirstChild(v7)
			local title = v8 and v8:FindFirstChild("Title")
			local cooldown = v8 and v8:FindFirstChild("Cooldown")
			if v8 and (not title or not title:IsA("TextLabel") or title.TextColor3.R > 0.9) and (not cooldown or cooldown.Size.X.Scale <= 0) then
				v6 = v7
				break
			end
		end

		if not skills then
			HiddenEvent.skillIndex = (HiddenEvent.skillIndex or 0) % 4 + 1
			v6 = ({ "Z", "X", "C", "V" })[HiddenEvent.skillIndex]
		end

		if not v6 then
			task.wait(0.5)
			return true
		end
		FaceHiddenTarget(arg.Position)

		pcall(function()
			VirtualInputManager:SendKeyEvent(true, v6, false, game)
		end)

		task.wait(0.1)

		pcall(function()
			VirtualInputManager:SendKeyEvent(false, v6, false, game)
		end)

		task.wait(1.5)
		return true
	end

	ShootHiddenGunAt = function(arg)
		local Gun = EquipHiddenWeapon("Gun")
		local flag = not Gun
		local flag2

		if flag then
			flag2 = os.clock() - (HiddenEvent.boughtGun or 0) > 30
		else
			flag2 = flag
		end

		if flag2 then
			HiddenEvent.boughtGun = os.clock()
			CommF:InvokeServer("BuyItem", "Slingshot")
			return false
		end

		if flag then
			return false
		end
		FaceHiddenTarget(arg.Position)
		task.wait(0.1)
		local v6 = workspace.CurrentCamera:WorldToViewportPoint(arg.Position)
		local v7 = getupvalues(require(ReplicatedStorage.Controllers.CombatController).Attack)[9]

		if type(v7) == "function" and debug.info(v7, "n") == "shootGun" and Gun.Parent == localPlayer.Character then
			local guiInset = game:GetService("GuiService"):GetGuiInset()

			pcall(v7, Gun, {
				UserInputType = Enum.UserInputType.Touch,
				Position = Vector3.new(v6.X - guiInset.X, v6.Y - guiInset.Y, 0),
			})
		else
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, true, game, 0)
			end)

			task.wait(0.05)

			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, false, game, 0)
			end)
		end

		task.wait(1.2)
		return true
	end

	GetHiddenRaidHint = function()
		local flag = not HiddenEvent.hint

		if not flag then
			local time_ = HiddenEvent.hint.time
			flag = tick() - time_ > 20
		end

		if flag then
			local ok, result = pcall(function()
				return ReplicatedStorage.Modules.Net["RF/RequestNextRaidHint"]:InvokeServer()
			end)

			HiddenEvent.hint = { time = tick(), data = ok and type(result) == "table" and result or {} }

			if HiddenEvent.hint.data.Island and tonumber(HiddenEvent.hint.data.Seconds) then
				HiddenEvent.expectedBoss = {
					key = os.date("!%Y%m%d%H", os.time() + tonumber(HiddenEvent.hint.data.Seconds) + 5),
					hint = HiddenEvent.hint.data,
				}
			end
		end

		local expectedBoss = HiddenEvent.expectedBoss
		if not HiddenEvent.hint.data.Island and expectedBoss and expectedBoss.key == os.date("!%Y%m%d%H") and os.date("!*t").min < 8 then
			return { Island = expectedBoss.hint.Island, Boss = expectedBoss.hint.Boss, State = "Triggered", Seconds = 0 }
		end
		return HiddenEvent.hint.data
	end

	FindHiddenBoss = function(arg, arg2)
		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			local position = child:GetPivot().Position

			if IsHiddenTarget(child) and ((position - arg2).Magnitude < 1500 or localPlayer:DistanceFromCharacter(position) < 1500) then
				for _, v6 in ipairs(arg) do
					if string.find(child.Name, v6, 1, true) then
						return child
					end
				end
			end
		end
	end

	GetChargedClouds = function()
		return GetHiddenState("Electric Fighting Teacher", function(arg, arg2, arg3, arg4)
			if arg2 == "Charge" and typeof(arg3) == "Instance" then
				arg[arg3] = arg[arg3] or {}

				if typeof(arg4) == "Instance" and not table.find(arg[arg3], arg4) then
					table.insert(arg[arg3], arg4)
				end
			elseif arg2 == "Split" and typeof(arg3) == "Instance" and type(arg4) == "table" then
				arg[arg3] = arg[arg3] or {}

				for _, v6 in ipairs(arg4) do
					table.insert(arg[arg3], v6)
				end
			elseif arg2 == "Break" and typeof(arg3) == "Instance" then
				arg[arg3] = nil
			end
		end)
	end

	HitChargedCloud = function()
		for k, v6 in pairs(GetChargedClouds()) do
			local M1HitRegistry = nil

			for _, v7 in ipairs(v6) do
				if v7.Parent and v7:HasTag("M1HitRegistry") then
					M1HitRegistry = v7
					break
				else
					M1HitRegistry = nil
				end
			end

			M1HitRegistry = M1HitRegistry or k.Parent and k:HasTag("M1HitRegistry") and k
			if M1HitRegistry then
				HitHiddenPart(M1HitRegistry)
				return true
			end
			GetChargedClouds()[k] = nil
		end
	end

	PlayHiddenBellTune = function(arg, arg2)
		for i_, note in ipairs(arg.notes) do
			local str2 = tostring(note)
			local n = arg.start + (i_ - 1) * arg.beat
			local v6 = workspace
			local n3 = n + arg.good

			if v6:GetServerTimeNow() <= n3 then
				if str2 == "Fruit" and not GetHiddenFruitM1() then
					pcall(EnsureHiddenFruit, "Echoes Through the Clouds")
				end

				local v7 = EquipHiddenWeapon(str2 == "Fruit" and "Blox Fruit" or str2)

				while true do
					task.wait()

					if v7 and v7.Parent ~= localPlayer.Character then
						pcall(localPlayer.Character.Humanoid.EquipTool, localPlayer.Character.Humanoid, v7)
					end

					if not (workspace:GetServerTimeNow() >= n - 0.08 or not Settings["Auto Secret Quest"]) then
						continue
					end
					break
				end

				FaceHiddenTarget(arg2.Position)

				if str2 == "Gun" and v7 then
					local v8 = workspace.CurrentCamera:WorldToViewportPoint(arg2.Position)
					local v9 = getupvalues(require(ReplicatedStorage.Controllers.CombatController).Attack)[9]

					if type(v9) == "function" and v7.Parent == localPlayer.Character then
						local guiInset = game:GetService("GuiService"):GetGuiInset()

						pcall(v9, v7, {
							UserInputType = Enum.UserInputType.Touch,
							Position = Vector3.new(v8.X - guiInset.X, v8.Y - guiInset.Y, 0),
						})
					else
						pcall(function()
							VirtualInputManager:SendMouseButtonEvent(v8.X, v8.Y, 0, true, game, 0)
						end)

						pcall(function()
							VirtualInputManager:SendMouseButtonEvent(v8.X, v8.Y, 0, false, game, 0)
						end)
					end
				elseif str2 == "Fruit" and v7 then
					pcall(function()
						VirtualInputManager:SendKeyEvent(true, "Z", false, game)
					end)

					pcall(function()
						VirtualInputManager:SendKeyEvent(false, "Z", false, game)
					end)
				elseif str2 == "Fruit" then
					NotifyHiddenFruitM1("Echoes Through the Clouds")
				end

				if str2 ~= "Gun" then
					HiddenModules.RegisterAttack:FireServer(0.3)
					HiddenModules.RegisterHit:FireServer(arg2)
				end
			end
		end

		HiddenEvent.bellQuiet = tick() + 6
		task.wait(1)
	end

	FindHiddenRaidShip = function(arg)
		local v6 = nil
		local v7

		local function fn(arg2)
			for _, child in ipairs(arg2:GetChildren()) do
				if child:IsA("Model") and child ~= workspace.Map then
					local v8 = string.lower(child.Name)

					if string.find(v8, "ship", 1, true) or string.find(v8, "brigade", 1, true) or string.find(v8, "galleon", 1, true) or string.find(v8, "boat", 1, true) then
						local ok, result = pcall(function()
							return child:GetPivot().Position
						end)

						if ok then
							local magnitude = (result - arg).Magnitude

							if magnitude < 2500 and (not v7 or magnitude < v7) then
								v6 = child
								v7 = magnitude
							end
						end
					end
				end
			end
		end

		fn(workspace)
		fn(workspace.Map)
		fn(workspace.Enemies)
		return v6
	end

	ListHiddenRaidShips = function(arg)
		local tbl9 = {}

		local function fn(arg2)
			for _, child in ipairs(arg2:GetChildren()) do
				if child:IsA("Model") and child ~= workspace.Map then
					local v6 = string.lower(child.Name)

					if string.find(v6, "brigade", 1, true) or string.find(v6, "ship", 1, true) or string.find(v6, "galleon", 1, true) then
						local ok, result = pcall(function()
							return child:GetPivot().Position
						end)

						if ok and (result - arg).Magnitude < 3000 then
							table.insert(tbl9, { model = child, pos = result, dist = (result - arg).Magnitude })
						end
					end
				end
			end
		end

		fn(workspace.Enemies)
		fn(workspace)
		fn(workspace.Map)

		table.sort(tbl9, function(arg2, arg3)
			return arg2.dist < arg3.dist
		end)

		return tbl9
	end

	ListenHiddenRaidChat = function()
		if HiddenEvent.raidChat then
			return
		end
		local tbl9 = {}

		for _, descendant in ipairs(ReplicatedStorage:GetDescendants()) do
			if (descendant:IsA("RemoteEvent") or descendant:IsA("UnreliableRemoteEvent")) and string.find(descendant.Name, "Chat", 1, true) then
				table.insert(tbl9, descendant)
			end
		end

		if #tbl9 == 0 then
			return
		end
		HiddenEvent.raidChat = true

		local function fn(...)
			local str2 = ""

			local function fn2(arg)
				if type(arg) == "string" then
					str2 ..= " " .. arg
				elseif type(arg) == "table" then
					for _, v6 in pairs(arg) do
						if type(v6) == "string" then
							str2 ..= " " .. v6
						end
					end
				end
			end

			for _, v6 in ipairs({ ... }) do
				fn2(v6)
			end

			str2 = string.lower(str2)

			if string.find(str2, "pirate sails", 1, true) or string.find(str2, "fleet will be", 1, true) or string.find(str2, "lookouts have spotted", 1, true) then
				HiddenEvent.raidWarn = tick()
				HiddenNotify("Pirate fleet spotted, manning the fortress cannons", "raidwarn" .. math.floor(tick() / 60), "found")
			end
		end

		for _, v6 in ipairs(tbl9) do
			v6.OnClientEvent:Connect(fn)
		end
	end

	GetCannonAimState = function(arg)
		if HiddenEvent.cannonState and HiddenEvent.cannonState.seat == arg then
			return HiddenEvent.cannonState
		end

		if tick() - (HiddenEvent.cannonScanAt or 0) < 3 then
			return nil
		end
		HiddenEvent.cannonScanAt = tick()

		for _, v6 in pairs(getgc(true)) do
			if type(v6) == "table" and rawget(v6, "targetYaw") ~= nil and rawget(v6, "seat") == arg then
				HiddenEvent.cannonState = v6
				return v6
			end
		end
	end

	SetCannonAim = function(arg, arg2)
		local center = arg.center
		local position = arg.seat.Position
		local vector = Vector3.new(arg2.X - center.X, 0, arg2.Z - center.Z)
		if vector.Magnitude < 40 then
			return
		end
		local vector2 = Vector3.new(arg2.X - position.X, 0, arg2.Z - position.Z)
		local restForward = vector2.Magnitude <= 0.01 and arg.restForward or vector2.Unit
		local n = math.clamp(arg2.Y - position.Y, -300, 60)
		local n3 = position + restForward * math.clamp(vector2.Magnitude, 8, 700) + Vector3.new(0, n, 0)
		local restForward2 = arg.restForward
		local targetYaw = (math.atan2(vector.Unit.X, vector.Unit.Z) - math.atan2(restForward2.X, restForward2.Z) + 3.1415926535897931) % 6.2831853071795862 - 3.1415926535897931
		local n4 = math.max(Vector3.new(n3.X - position.X, 0, n3.Z - position.Z).Magnitude, 8) / 180
		local targetPitch = math.clamp(math.atan2((n3.Y - position.Y + 2.25 + 0.5 * workspace.Gravity * n4 * n4) / n4, 180), 0, 1.1344640137963142)
		arg.targetYaw = targetYaw
		arg.targetPitch = targetPitch
		arg.yaw = targetYaw
		arg.pitch = targetPitch
		arg.yawVel = 0
		local model = arg.model
		local parent

		if model then
			parent = model
		else
			parent = arg.seat and arg.seat.Parent
		end

		local remotes = ReplicatedStorage:FindFirstChild("Remotes")
		remotes = remotes and remotes:FindFirstChild("MarineBusterAim")
		local flag = parent and remotes

		if flag then
			flag = tick() - (HiddenEvent.cannonRelay or 0) > 0.05
		end

		if flag then
			HiddenEvent.cannonRelay = tick()

			pcall(function()
				remotes:FireServer(parent, targetYaw, targetPitch)
			end)
		end
	end

	AimHiddenCannon = function(cannonTarget)
		local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
		local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")
		local seatPart = humanoid and humanoid.SeatPart

		if not seatPart or seatPart.Parent.Name ~= "MarineBusterCannon" then
			local v6 = ipairs
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
			local v7 = nil
			seatPart = nil

			for _, bonusMomentLocation in v6(bonusMomentLocations) do
				local seat = bonusMomentLocation.Name == "MarineBusterCannon" and bonusMomentLocation:FindFirstChild("Seat")
				local flag

				if seat then
					flag = not seat.Occupant or seat.Occupant.Parent == localPlayer.Character
				else
					flag = seat
				end

				if flag then
					local magnitude = (seat.Position - cannonTarget).Magnitude

					if not v7 or magnitude < v7 then
						v7 = magnitude
						seatPart = seat
					end
				end
			end

			if not seatPart then
				return false
			end

			if localPlayer:DistanceFromCharacter(seatPart.Position) > 10 then
				HiddenMove(seatPart.CFrame * CFrame.new(0, 4, 0))
				return true
			end
			HiddenRelease()
			TweenManager.CancelTweenOnly()
			localPlayer.Character.HumanoidRootPart.CFrame = seatPart.CFrame * CFrame.new(0, 2, 0)
			task.wait(0.2)
			seatPart:Sit(humanoid)
			task.wait(0.6)
			HiddenEvent.cannonState = nil
		end

		local v6 = GetCannonAimState(seatPart)
		if not v6 then
			return false
		end
		HiddenEvent.cannonTarget = cannonTarget

		if not HiddenEvent.cannonLoop then
			HiddenEvent.cannonLoop = game:GetService("RunService").RenderStepped:Connect(function(...) end)
		end

		pcall(SetCannonAim, v6, cannonTarget)
		task.wait(0.2)
		return true
	end

	FireHiddenCannon = function(arg)
		local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
		local v6 = ipairs
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
		local v7 = nil
		local v8 = nil

		for _, bonusMomentLocation in v6(bonusMomentLocations) do
			local seat = bonusMomentLocation.Name == "MarineBusterCannon" and bonusMomentLocation:FindFirstChild("Seat")

			if seat and (not seat.Occupant or seat.Occupant.Parent == localPlayer.Character) then
				local magnitude = (seat.Position - arg).Magnitude

				if not v7 or magnitude < v7 then
					v7 = magnitude
					v8 = seat
				end
			end
		end

		if not v8 then
			return false
		end
		local humanoid = localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid.SeatPart ~= v8 then
			if localPlayer:DistanceFromCharacter(v8.Position) > 8 then
				HiddenMove(v8.CFrame * CFrame.new(0, 3, 0))
				return true
			end
			HiddenRelease()
			TweenManager.CancelTweenOnly()
			localPlayer.Character.HumanoidRootPart.CFrame = v8.CFrame * CFrame.new(0, 2, 0)
			task.wait(0.2)
			v8:Sit(humanoid)
			task.wait(0.5)
		end

		local currentCamera = workspace.CurrentCamera
		currentCamera.CFrame = CFrame.lookAt(v8.Position + Vector3.new(0, 12, 0) + (v8.Position - arg).Unit * 10, arg)
		task.wait(0.1)
		local v9, v10 = currentCamera:WorldToViewportPoint(arg)

		if v10 then
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v9.X, v9.Y, 0, true, game, 0)
			end)

			task.wait(0.05)

			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(v9.X, v9.Y, 0, false, game, 0)
			end)
		end

		task.wait(0.6)
		return true
	end

	ShootHiddenCannon = function(arg)
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")
		humanoid = humanoid and humanoid.SeatPart
		if not humanoid or humanoid.Parent.Name ~= "MarineBusterCannon" then
			return false
		end

		if tick() - (HiddenEvent.cannonShot or 0) < 1.2 then
			return true
		end
		local currentCamera = workspace.CurrentCamera
		local v6, v7 = currentCamera:WorldToViewportPoint(arg)

		if not v7 then
			currentCamera.CFrame = CFrame.lookAt(humanoid.Position + Vector3.new(0, 10, 0) + (humanoid.Position - arg).Unit * 8, arg)
			task.wait(0.12)
			v6, v7 = currentCamera:WorldToViewportPoint(arg)
		end

		if not v7 then
			return false
		end
		HiddenEvent.cannonShot = tick()

		pcall(function()
			VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, true, game, 0)
		end)

		task.wait(0.06)

		pcall(function()
			VirtualInputManager:SendMouseButtonEvent(v6.X, v6.Y, 0, false, game, 0)
		end)

		return true
	end

	LeaveHiddenCannon = function()
		local humanoid = localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

		if humanoid and humanoid.SeatPart and humanoid.SeatPart.Parent.Name == "MarineBusterCannon" then
			humanoid.Sit = false
			humanoid.Jump = true
		end
	end

	AttackHiddenSpot = function(arg)
		if localPlayer:DistanceFromCharacter(arg.Position) > 10 then
			HiddenMove(arg.CFrame * CFrame.new(0, 4, 4))
			return
		end
		HiddenHold(arg.CFrame * CFrame.new(0, 4, 4))
		EquipHiddenWeapon("Melee")

		if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
			HiddenEvent.lastHit = os.clock()
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(arg)
		end
	end

	RunMagmaOreCave = function()
		local magmaCave = workspace.Map:FindFirstChild("MagmaCave")
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not magmaCave or not humanoidRootPart then
			return
		end
		local bonusMomentLocations = magmaCave:FindFirstChild("BonusMoment_Locations")
		bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChildWhichIsA("BasePart")
		if not bonusMomentLocations or (humanoidRootPart.Position - bonusMomentLocations.Position).Magnitude > 1500 then
			return
		end

		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child.Name == "Magma Drill" and IsHiddenTarget(child) then
				KillHiddenEnemy(child)
				HiddenEvent.checked = 0
				return "Destroy the Magma Drill"
			end
		end
	end

	FindAwakenedBoss = function(arg, arg2)
		for _, child in ipairs(workspace.Enemies:GetChildren()) do
			if child:GetAttribute("BossIndicatorAwakened") and IsHiddenTarget(child) then
				local flag = true

				if arg2 then
					flag = false

					for _, v6 in ipairs(arg2) do
						if string.find(child.Name, v6, 1, true) then
							flag = true
						end
					end
				end

				if flag and (not arg or (child:GetPivot().Position - arg).Magnitude < 3000) then
					return child
				end
			end
		end
	end

	HitHiddenTriggers = function(arg, arg2)
		local v6 = nil
		local v7 = nil

		for _, v8 in ipairs(arg) do
			local descendants = v8 and v8:GetDescendants() or {}
			table.insert(descendants, v8)

			for _, descendant in ipairs(descendants) do
				if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") and (arg2 or descendant.Transparency < 1) then
					local v9 = localPlayer:DistanceFromCharacter(descendant.Position)

					if not v6 or v9 < v6 then
						v6 = v9
						v7 = descendant
					end
				end
			end
		end

		if v7 then
			HitHiddenPart(v7)
			return true
		end
	end

	GetHiddenBossHour = function()
		local v6 = os.date("!%Y%m%d%H")

		if not HiddenEvent.bossHour or HiddenEvent.bossHour.key ~= v6 then
			HiddenEvent.bossHour = { key = v6, checked = {}, active = nil }
			local expectedBoss = HiddenEvent.expectedBoss

			if expectedBoss and expectedBoss.key == v6 then
				for _, v7 in ipairs(HiddenQuests) do
					if v7.BossNames and not IsHiddenBossHinted(expectedBoss.hint, v7.HintIsland, v7.BossNames) then
						HiddenEvent.bossHour.checked[v7.Name] = true
					end
				end
			end
		end

		return HiddenEvent.bossHour
	end

	IsHiddenBossHinted = function(arg, arg2, arg3)
		if not arg.Island then
			return false
		end

		if table.find(arg3, arg.Boss) then
			return true
		end

		for _, v6 in ipairs(HiddenQuests) do
			if v6.BossNames and table.find(v6.BossNames, arg.Boss) then
				return false
			end
		end

		return arg.Island == arg2
	end

	IsHiddenHourUseful = function(arg)
		local v6 = GetHiddenRaidHint()
		if not v6 or not v6.Island or not v6.Boss then
			return true
		end

		for _, v7 in ipairs(HiddenQuests) do
			if arg["Sea1/" .. v7.Island .. "/" .. v7.Name] ~= true then
				if v7.BossNames then
					if IsHiddenBossHinted(v6, v7.HintIsland or v7.Island, v7.BossNames) then
						return true
					end
					continue
				end

				if v6.Island == (v7.HintIsland or v7.Island) then
					return true
				end
			end
		end

		return false
	end

	ListHiddenServers = function()
		local tbl9 = {}

		local ok, result = pcall(function()
			return ReplicatedStorage.__ServerBrowser:InvokeServer(1)
		end)

		if ok and type(result) == "table" then
			for k in pairs(result) do
				if type(k) == "string" then
					tbl9[k] = true
				end
			end
		end

		return tbl9
	end

	QueueHiddenReload = function()
		local queueOnTeleport = rawget(getgenv(), "queue_on_teleport") or syn and syn.queue_on_teleport or fluxus and fluxus.queue_on_teleport
		if not queueOnTeleport then
			return false
		end

		pcall(function()
			queueOnTeleport([[task.spawn(function()
	repeat
		task.wait(1)
	until game:IsLoaded()
	local players = game:GetService("Players")
	repeat
		task.wait(0.5)
	until players.LocalPlayer
	local player = players.LocalPlayer
	repeat
		task.wait(0.5)
	until player:FindFirstChild("PlayerGui")
	local waited = 0
	while not player.Character and waited < 240 do
		task.wait(2)
		waited = waited + 2
		if waited > 14 and player.PlayerGui:FindFirstChild("TeamSelection") then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
			end)
		end
	end
	local character = player.Character or player.CharacterAdded:Wait()
	character:WaitForChild("HumanoidRootPart", 60)
	task.wait(5)
	pcall(function()
		loadstring(readfile("ZyroxHub.lua"))()
	end)
end)]])
		end)

		return true
	end

	HopHiddenServer = function()
		HiddenEvent.hopped = HiddenEvent.hopped or {}
		QueueHiddenReload()
		local v6 = ListHiddenServers()

		for i_ = 1, 2 do
			for k in pairs(v6) do
				if k ~= game.JobId and not HiddenEvent.hopped[k] then
					HiddenEvent.hopped[k] = true
					HiddenNotify("Dead boss hour, switching server", "hop" .. k, "travel")

					local function fn()
						ReplicatedStorage.__ServerBrowser:InvokeServer("teleport", k)
					end

					pcall(fn)
					return true
				end
			end

			HiddenEvent.hopped = {}
		end

		return false
	end

	RunChefsKiss = function(arg)
		local chefMissing = HiddenEvent.chefMissing
		local flag

		if chefMissing then
			local time_ = HiddenEvent.chefMissing.time
			flag = tick() - time_ < 300
		else
			flag = chefMissing
		end

		if flag then
			local v6 = GatherChefIngredients(arg)
			if v6 then
				return v6
			end
			HiddenEvent.chefMissing = nil
			HiddenEvent.cooked = 0
		end

		local cauldronMoment = workspace.Map.Pirate:FindFirstChild("Cauldron_Moment")

		if cauldronMoment then
			cauldronMoment = cauldronMoment:FindFirstChild("Cauldron") or cauldronMoment:FindFirstChildWhichIsA("BasePart", true)
		end

		local flag2 = not cauldronMoment

		if not flag2 then
			flag2 = tick() - (HiddenEvent.cooked or 0) <= 15
		end

		if flag2 then
			return
		end

		if not HiddenSettle(cauldronMoment:GetPivot().Position + Vector3.new(0, 3, 6), 10) then
			return "Go to the tavern cauldron"
		end
		HiddenEvent.cooked = tick()
		local response = arg:InvokeServer("OpenCauldron")
		if type(response) ~= "table" then
			return "Waiting for the cauldron to open"
		end
		local tbl9 = {}
		local v6 = ipairs
		local slots = response.Slots or {}

		for _, slot in v6(slots) do
			if not response.Placed[slot] then
				local v7 = pairs
				local owned = response.Owned and response.Owned[slot] or {}
				local flag3 = nil

				for k, v8 in v7(owned) do
					if not (v8 > 0) then
						flag3 = nil
					else
						local response2 = arg:InvokeServer("Insert", k)

						if type(response2) == "table" then
							flag3 = true
							response = response2
							break
						else
							flag3 = nil
						end
					end
				end

				if not flag3 then
					table.insert(tbl9, tostring(response.Examples and response.Examples[slot] and response.Examples[slot][1] or slot))
				end
			end
		end

		if #tbl9 > 0 then
			arg:FireServer("CloseCauldron")
			HiddenNotify("Chef's Kiss needs: " .. table.concat(tbl9, ", "), "chefmissing", "warning")
			HiddenEvent.chefMissing = { time = tick(), text = "Chef's Kiss needs " .. table.concat(tbl9, ", "), needs = response.Slots }
			return HiddenEvent.chefMissing.text, true
		end

		local response2 = arg:InvokeServer("Cook")
		arg:FireServer("CloseCauldron")
		HiddenEvent.awakened = HiddenEvent.awakened or {}

		if response2 == "Cooked" then
			HiddenEvent.awakened["Chef's Kiss"] = tick()
			HiddenNotify("Chef's Kiss: recipe cooked, the Chef is awakening", "chefcooked", "success")
		end

		return "Cook the Chef's recipe"
	end

	CreateBossQuest = function(arg, active, arg2, arg3, arg4, arg5)
		return {
			Island = arg,
			Name = active,
			HintIsland = arg2,
			BossNames = arg3,
			RetryDelay = 300,
			Precheck = function(arg6)
				local v6 = GetHiddenBossHour()
				local flag = IsHiddenBossHinted(arg6, arg2, arg3) or v6.active == active
				local flag2

				if flag then
					flag2 = flag
				else
					flag2 = tick() - ((HiddenEvent.announced or {})[active] or 0) < 400
				end

				if flag2 then
					return true
				end

				if v6.active then
					return false, "awakened boss is on " .. tostring(v6.active) .. " this hour"
				end
				return false, "waiting for the XX:50 boss hint"
			end,
			Run = function(arg6)
				local v6 = GetHiddenIsland(arg)
				local position = v6 and v6.World.Position or localPlayer.Character:GetPivot().Position
				FindHiddenBoss(arg3, position)
				HiddenEvent.awakened = HiddenEvent.awakened or {}
				local v7 = FindAwakenedBoss(position, arg3)

				if v7 then
					GetHiddenBossHour().active = active
					HiddenEvent.bossFight = { quest = active, time = tick() }
					KillHiddenEnemy(v7)
					HiddenEvent.checked = 0
					return "Defeat the awakened " .. v7.Name
				end

				local v8 = GetHiddenBossHour()
				local v9 = GetHiddenRaidHint()
				local v10 = IsHiddenBossHinted(v9, arg2, arg3)

				if arg6.Active and not v10 and os.date("!*t").min >= 12 then
					v8.checked[active] = true
					v8.active = nil
					return arg3[1] .. " window passed this hour, wait for XX:50 hint", true
				end

				if arg6.Active then
					v8.active = active

					if arg4 then
						local v11, v12 = arg4(arg6)
						if v11 then
							return v11, v12
						end
					end

					return "Waiting for " .. arg3[1] .. " to awaken"
				end

				if v8.active == active then
					v8.active = nil
				end

				if v10 then
					local num = tonumber(v9.Seconds)
					local flag = arg5

					if arg5 then
						flag = v9.State == "Triggered"

						if not flag then
							flag = (num or math.huge) <= 0
						end
					end

					if flag then
						local v11, v12 = arg5(arg6)
						if v11 then
							return v11, v12
						end
					end

					return arg3[1] .. " stirs on " .. arg .. (num and " in ~" .. FormatMagnetTime(num) or " soon"), (num or 0) > 180
				end

				v8.checked[active] = true
				return "No awakened " .. arg3[1] .. " this hour", true
			end,
		}
	end

	do
		local tbl9 = {}

		local Jungle = CreateBossQuest("Jungle", "Banana Tree", "Jungle", { "Gorilla King" }, function()
			local v6 = GetHiddenState("Banana Tree", function(arg, arg2, arg3)
				if arg2 == "Availability" then
					arg.tree = typeof(arg3) == "Instance" and arg3 or nil
				elseif arg2 == "Reset" or arg2 == "Finale" then
					arg.tree = nil
				end
			end)

			if HitHiddenTriggers({ v6.tree and v6.tree.Parent and v6.tree or workspace.Map.Jungle:FindFirstChild("BananaTrees") }) then
				return "Shake the banana tree"
			end
		end)

		local v6 = CreateBossQuest("Frozen Village", "Frozen Defense", "Frozen Village", { "Yeti" }, function()
			local bonusMomentLocations = workspace.Map.Ice:FindFirstChild("BonusMoment_Locations")
			local v6 = ipairs
			local descendants = bonusMomentLocations and bonusMomentLocations:GetDescendants() or {}
			local v7 = nil
			local v8 = nil

			for _, descendant in v6(descendants) do
				local attribute = descendant:GetAttribute("FrozenDefenseRockPresent")
				local isBasePart = descendant:IsA("BasePart") and descendant or descendant:IsA("Model") and (descendant.PrimaryPart or descendant:FindFirstChildWhichIsA("BasePart", true))

				if attribute ~= nil and attribute ~= false and isBasePart then
					local v9 = localPlayer:DistanceFromCharacter(isBasePart.Position)

					if not v7 or v9 < v7 then
						v7 = v9
						v8 = isBasePart
					end
				end
			end

			if v8 then
				AttackHiddenSpot(v8)
				return "Break the cursed ice rocks"
			end

			if HitHiddenTriggers({ bonusMomentLocations }) then
				return "Break the cursed ice rocks"
			end
			local bossFight = HiddenEvent.bossFight
			local flag = bossFight and bossFight.quest == "Frozen Defense"

			if flag then
				local time_ = bossFight.time
				flag = tick() - time_ < 240
			end

			if flag then
				local position = GetHiddenIsland("Frozen Village")
				position = position and position.World.Position

				for _, child in ipairs(workspace.NPCs:GetChildren()) do
					if string.find(string.lower(child.Name), "villager", 1, true) and position and (child:GetPivot().Position - position).Magnitude < 900 then
						if not HiddenSettle(child:GetPivot().Position + Vector3.new(0, 2, 4), 8) then
							return "Go to " .. child.Name
						end
						TalkHiddenQuestNpc(child.Name, { "Yeti", "thank", "reward", "done" })
						HiddenEvent.bossFight = nil
						return "Report the Yeti to " .. child.Name
					end
				end
			end
		end)

		local v7 = CreateBossQuest("Magma Village", "One Last Eruption", "Magma Village", { "Magma Admiral", "Magma General" }, function(arg)
			local v7 = GetHiddenState("One Last Eruption", function(arg2, arg3, spots)
				if arg3 == "Setup" and type(spots) == "table" then
					arg2.spots = spots
					arg2.destroyed = {}
				elseif arg3 == "Destroyed" and arg2.destroyed then
					arg2.destroyed[spots] = true
				end
			end)

			if not v7.spots then
				if tick() - (v7.asked or 0) > 5 then
					v7.asked = tick()
					arg:FireServer("Init")
				end

				return "Waiting for the lava fissures"
			end

			local bonusMomentLocations = workspace.Map.Magma:FindFirstChild("BonusMoment_Locations")
			local v8 = nil
			local v9 = nil

			for k, spot in pairs(v7.spots) do
				if not v7.destroyed[k] then
					local v10 = localPlayer:DistanceFromCharacter(spot.Position)

					if not v8 or v10 < v8 then
						v8 = v10
						v9 = spot
					end
				end
			end

			if not v9 then
				return
			end

			if v8 > 10 then
				HiddenMove(v9 * CFrame.new(0, 4, 3))
				return "Go to the next lava fissure"
			end
			local v10 = ipairs
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:GetChildren() or {}
			local v11 = nil
			local v12 = nil

			for _, bonusMomentLocation in v10(bonusMomentLocations) do
				if bonusMomentLocation.Name == "Volcano Fissure" and bonusMomentLocation:IsA("BasePart") then
					local magnitude = (bonusMomentLocation.Position - v9.Position).Magnitude

					if not v11 or magnitude < v11 then
						v11 = magnitude
						v12 = bonusMomentLocation
					end
				end
			end

			HiddenHold(v9 * CFrame.new(0, 4, 3))
			EquipHiddenWeapon("Melee")
			HiddenModules.RegisterAttack:FireServer(0.3)
			local v13 = nil
			local v14 = nil

			for _, child in ipairs(workspace:GetChildren()) do
				if child.Name == "MagmaFissure" and child:IsA("Model") then
					local ok, result = pcall(child.GetPivot, child)
					ok = ok and (result.Position - v9.Position).Magnitude

					if ok and (not v13 or ok < v13) then
						v13 = ok
						v14 = child
					end
				end
			end

			if v14 and v13 < 25 then
				local flag = false

				for _, descendant in ipairs(v14:GetDescendants()) do
					if descendant:IsA("BasePart") then
						HiddenModules.RegisterHit:FireServer(descendant)
						flag = true
					end
				end

				if not flag then
					HiddenModules.RegisterHit:FireServer(v14)
				end
			elseif v12 then
				HiddenModules.RegisterHit:FireServer(v12)
			end

			pcall(getgenv().ClickM1)
			task.wait(0.35)
			return "Break the lava fissures"
		end)

		local Fountain = CreateBossQuest("Fountain", "Fountain Wire Repair", "Fountain City", { "Cyborg" }, function()
			if HitHiddenTriggers({ workspace._WorldOrigin:FindFirstChild("FountainWireNodes") }, true) then
				return "Repair the sparking wires"
			end
		end)

		local v8 = CreateBossQuest("Marine Fortress", "Fortress Under Fire", "Marine Fortress", { "Vice Admiral" }, function()
			local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("MainBase")
			if not bonusMomentLocations then
				return
			end
			local y = nil
			local v8 = nil

			for _, descendant in ipairs(bonusMomentLocations:GetDescendants()) do
				if descendant:IsA("BasePart") and descendant.Transparency < 1 and (descendant:HasTag("M1HitRegistry") or descendant.Name:find("Target")) then
					if not y or descendant.Position.Y > y then
						y = descendant.Position.Y
						v8 = descendant
					end
				end
			end

			local boundingBox, v9 = bonusMomentLocations:GetBoundingBox()
			if FireHiddenCannon(v8 and v8.Position or boundingBox.Position + Vector3.new(0, v9.Y / 4, 0)) then
				return "Shell the fortress building with the cannon"
			end
		end)

		local SkyArea2 = CreateBossQuest("SkyArea2", "The Tyrant Awakens", "Upper Skylands", { "Wysper", "Sky Warlord", "Tyrant" }, function()
			local skyArea2 = workspace.Map:FindFirstChild("SkyArea2")
			local v9 = HitHiddenTriggers
			local tbl10 = {}
			local tyrantClouds = skyArea2 and skyArea2:FindFirstChild("TyrantClouds")
			skyArea2 = skyArea2 and skyArea2:FindFirstChild("BonusMoment_Locations")
			tbl10[1] = tyrantClouds
			tbl10[2] = skyArea2
			if v9(tbl10) then
				return "Break the dark clouds"
			end
		end)

		local SkyArea22 = CreateBossQuest("SkyArea2", "Echoes Through the Clouds", "Upper Skylands", { "Thunder God", "Lightning God" }, function()
			local v9 = GetHiddenState("Echoes Through the Clouds", function(arg, arg2, arg3, arg4, arg5, arg6, arg7)
				if arg2 == "Listen" and type(arg3) == "table" and type(arg4) == "number" and type(arg5) == "number" then
					arg.round = { notes = arg3, start = arg4, beat = arg5, good = tonumber(arg7) or 0.7 }
					arg.listen = tick()
				elseif arg2 == "Finale" or arg2 == "Witness" or arg2 == "SetActive" then
					arg.round = nil
				end
			end)

			local goldenBell = workspace.Map:FindFirstChild("SkyArea2") and workspace.Map.SkyArea2:FindFirstChild("Golden Bell")

			if goldenBell then
				goldenBell = goldenBell:FindFirstChild("Bell", true) or goldenBell:FindFirstChildWhichIsA("BasePart", true)
			end

			if not goldenBell then
				return
			end

			if not HiddenSettle(goldenBell.Position + Vector3.new(0, 2, 7), 10) then
				return "Go to the Golden Bell"
			end
			local round = v9.round
			local flag

			if round then
				local n = round.start + #round.notes * round.beat
				flag = workspace:GetServerTimeNow() < n
			else
				flag = round
			end

			if flag then
				v9.round = nil
				PlayHiddenBellTune(round, goldenBell)
				return "Play the bell tune (" .. #round.notes .. " notes)"
			end

			local flag2 = tick() < (HiddenEvent.bellQuiet or 0)

			if not flag2 then
				flag2 = tick() - (v9.listen or 0) < 12
			end

			if flag2 then
				return "Listen to the bell"
			end
			EquipHiddenWeapon("Melee")
			HiddenModules.RegisterAttack:FireServer(0.3)
			HiddenModules.RegisterHit:FireServer(goldenBell)
			task.wait(1)
			return "Ring the Golden Bell"
		end)

		local v9 = CreateBossQuest("Underwater City", "Pearl of the Deep", "Underwater City", { "Fishman Lord" }, function(arg)
			if not HiddenEvent.clamListener then
				HiddenEvent.clamListener = ListenHiddenMoment("Pearl of the Deep", function(arg2, arg3)
					if arg2 == "ClamRespawned" and HiddenEvent.openedClams then
						HiddenEvent.openedClams[arg3] = nil
					elseif arg2 == "SetActive" or arg2 == "Loaded" then
						HiddenEvent.openedClams = {}
					end
				end)
			end

			HiddenEvent.openedClams = HiddenEvent.openedClams or {}
			if os.date("!*t").min >= 45 then
				return "Saving the clams for the XX:00 Fishman Lord window", true
			end
			local position = localPlayer.Character:GetPivot().Position

			for _, child in ipairs(workspace.Enemies:GetChildren()) do
				if IsHiddenTarget(child) and string.find(child.Name, "Mimic") and (child:GetPivot().Position - position).Magnitude < 300 then
					KillHiddenEnemy(child)
					return "Defeat the mimic clam"
				end
			end

			local v9 = nil
			local v10 = nil

			for _, v11 in ipairs(game:GetService("CollectionService"):GetTagged("PearlClam")) do
				local isBasePart = v11:IsA("BasePart") and v11 or v11:FindFirstChildWhichIsA("BasePart", true)

				if isBasePart and v11:IsDescendantOf(workspace) and not HiddenEvent.openedClams[v11] then
					local v12 = localPlayer:DistanceFromCharacter(isBasePart.Position)

					if not v9 or v12 < v9 then
						v9 = v12
						v10 = v11
					end
				end
			end

			if not v10 then
				local v11 = FindHiddenBoss({ "Fishman Lord" }, position)
				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat Fishman Lord while the clams refill"
				end
				return "Waiting for the clams to reappear", true
			end

			if HiddenSettle((v10:IsA("BasePart") and v10 or v10:FindFirstChildWhichIsA("BasePart", true)).CFrame * Vector3.new(0, 0, -3.5) + Vector3.new(0, 2, 0), 9) then
				local response = arg:InvokeServer("OpenClam", v10)
				HiddenEvent.openedClams[v10] = tick()
				HiddenEvent.arrived = nil

				if response == "Black" then
					task.wait(1.5)

					for i_ = 1, 5 do
						if arg:InvokeServer("ClaimPearl") == true then
							HiddenEvent.awakened["Pearl of the Deep"] = tick()
							HiddenNotify("Found the black pearl, the Fishman Lord awakens", nil, "found")
							break
						else
							task.wait(1)
						end
					end
				end
			end

			return "Search the clams for the black pearl"
		end)

		local v10 = CreateBossQuest("Pirate Village", "Chef's Kiss", "Pirate Village", { "Chef" }, RunChefsKiss, RunChefsKiss)

		local Prison = CreateBossQuest("Prison", "Lever Jailbreak", "Prison", { "Warden" }, function(arg)
			local bonusMomentLocations = workspace.Map.Prison:FindFirstChild("BonusMoment_Locations", true)
			bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("Levers")
			if not bonusMomentLocations then
				return
			end
			local tbl10 = {}

			for _, child in ipairs(bonusMomentLocations:GetChildren()) do
				local lever = child:FindFirstChild("Lever")

				if lever then
					table.insert(tbl10, lever)
				end
			end

			table.sort(tbl10, function(arg2, arg3)
				if math.abs(arg2.Position.X - arg3.Position.X) <= 0.001 then
					return arg2.Position.Z < arg3.Position.Z
				end
				return arg2.Position.X < arg3.Position.X
			end)

			local leverPuzzle = HiddenEvent.leverPuzzle or { known = {}, pulled = 0, wrong = {} }
			HiddenEvent.leverPuzzle = leverPuzzle
			local v11

			if leverPuzzle.pulled < #leverPuzzle.known then
				v11 = leverPuzzle.known[leverPuzzle.pulled + 1]
			else
				local tbl11 = { 2, 3, 4, 1 }

				for i_ = 1, #tbl10 do
					if not table.find(tbl11, i_) then
						table.insert(tbl11, i_)
					end
				end

				v11 = tbl11[#leverPuzzle.known + 1]
				local flag = v11 and v11 <= #tbl10 and not table.find(leverPuzzle.known, v11) and not leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v11]
				local v12 = nil

				if not flag then
					v11 = v12
				end

				for _, v13 in ipairs(tbl11) do
					if not v11 then
						if v13 <= #tbl10 and not table.find(leverPuzzle.known, v13) and not leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v13] then
							v11 = v13
						end

						continue
					end

					break
				end
			end

			if not v11 then
				HiddenEvent.leverPuzzle = nil
				return
			end
			local vector = Vector3.zero

			for _, v12 in ipairs(tbl10) do
				vector += v12.Position / #tbl10
			end

			HiddenEvent.stallGrace = tick() + 5

			if HiddenSettle(vector + Vector3.new(0, 3, 8), 12) then
				local response = arg:InvokeServer("Pull", v11)
				local result = type(response) == "table" and response.Result or response

				if result == "Accepted" then
					if leverPuzzle.pulled == #leverPuzzle.known then
						table.insert(leverPuzzle.known, v11)
					end

					leverPuzzle.pulled = leverPuzzle.pulled + 1
				elseif result == "Solved" then
					HiddenEvent.leverPuzzle = nil
				elseif result == "Reset" then
					if leverPuzzle.pulled == #leverPuzzle.known then
						leverPuzzle.wrong[#leverPuzzle.known + 1 .. ":" .. v11] = true
					end

					leverPuzzle.pulled = 0
				end

				task.wait(0.4)
			end

			return "Solve the lever puzzle (" .. #leverPuzzle.known .. "/" .. #tbl10 .. ")"
		end)

		tbl9[1] = Jungle
		tbl9[2] = v6
		tbl9[3] = v7
		tbl9[4] = Fountain
		tbl9[5] = v8
		tbl9[6] = SkyArea2
		tbl9[7] = SkyArea22
		tbl9[8] = v9
		tbl9[9] = v10
		tbl9[10] = Prison

		tbl9[11] = {
			Island = "Prison",
			Name = "Escape from Alcatraz",
			Run = function(arg)
				local prisoners = arg.MiscData and arg.MiscData.Prisoners
				prisoners = type(prisoners) == "table" and prisoners or {}
				local prisonerKey = HiddenEvent.prisonerKey
				local v11 = prisonerKey and prisoners[prisonerKey]

				if not v11 or typeof(v11.Model) ~= "Instance" or not v11.Model.Parent then
					local v12 = nil
					prisonerKey = nil
					v11 = nil

					for k, prisoner in pairs(prisoners) do
						local model = prisoner.Model

						if typeof(model) == "Instance" and model.Parent then
							local v13 = localPlayer:DistanceFromCharacter(model:GetPivot().Position)

							if not v12 or v13 < v12 then
								v12 = v13
								prisonerKey = k
								v11 = prisoner
							end
						end
					end

					HiddenEvent.prisonerKey = prisonerKey
				end

				if not v11 then
					return "Waiting for prisoners to escape", true
				end
				local model = v11.Model
				local flag = HiddenEvent.provoked == model

				if flag then
					flag = tick() - (HiddenEvent.provokedAt or 0) > 25
				end

				if flag then
					HiddenEvent.provoked = nil
				end

				if HiddenEvent.provoked ~= model then
					local n = model:GetPivot() * CFrame.new(0, 1.5, 6)

					if localPlayer:DistanceFromCharacter(model:GetPivot().Position) > 12 then
						HiddenMove(n)
					else
						HiddenHold(n)
						HiddenEvent.provokeTry = HiddenEvent.provokeTry or {}

						if tick() - (HiddenEvent.provokeTry[prisonerKey] or 0) > 1.5 then
							HiddenEvent.provokeTry[prisonerKey] = tick()
							arg:InvokeServer("Provoke", prisonerKey)
							local v12 = HiddenEvent
							local v13 = HiddenEvent
							local now = tick()
							v12.provoked = model
							v13.provokedAt = now
						end
					end

					return "Confront the escaping prisoner (" .. tostring(prisonerKey) .. ")"
				end

				HiddenEvent.stallGrace = tick() + 5
				local humanoidRootPart = model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart

				if humanoidRootPart then
					HitHiddenPart(humanoidRootPart)

					if model:FindFirstChildOfClass("Humanoid") then
						SizePart(model)
						pcall(BringMob, model)
						UsedualFlock()
						local cFrame = humanoidRootPart.CFrame
						getgenv().AimPos = cFrame
						HiddenMove(GetHiddenFarmCFrame(model))
						getgenv().ClickM1(model, true)
					end
				end

				return "Catch the prisoner (" .. tostring(prisonerKey) .. ")"
			end,
		}

		tbl9[12] = {
			Island = "Prison",
			Name = "Don Megalo",
			Run = function(arg)
				local v11 = GetHiddenState("Don Megalo", function(arg2, arg3, stage)
					if arg3 == "Stage" then
						arg2.stage = stage
					elseif arg3 == "GateUnlocked" then
						arg2.gateOpen = true
					end
				end)

				if tick() - (v11.initialized or 0) > 30 then
					v11.initialized = tick()
					arg:FireServer("Init")
					task.wait(1)
				end

				local v12 = FindHiddenEnemyMatch({ "Megalo Guard", "Bouncer" }, Vector3.new(5277, 5, 743), 900)
				if v12 then
					KillHiddenEnemy(v12)
					return "Defeat " .. v12.Name
				end
				local SharkCape = GetPrisonLocation("SharkCape")

				if SharkCape and v11.gateOpen then
					if HiddenSettle(SharkCape + Vector3.new(0, 1.5, 3), 8) then
						arg:FireServer("BouncerReady")
						local v13 = FindHiddenPromptNear({ workspace.Map.Prison, workspace._WorldOrigin }, SharkCape, 25)

						if v13 then
							HoldHiddenPrompt(v13)
						end

						if arg:InvokeServer("TakeCape") == true then
							arg:InvokeServer("ClaimCape")
							HiddenEvent.checked = 0
						end

						task.wait(1)
					end

					return "Hold to steal Don Megalo's coat"
				end

				local MegaloGate = GetPrisonLocation("MegaloGate")

				if MegaloGate and not v11.gateOpen then
					local Key = GetPrisonLocation("Key")

					if Key and not v11.hasKey then
						if HiddenSettle(Key + Vector3.new(0, 3, 3), 8) then
							v11.hasKey = arg:InvokeServer("TakeKey") == true
							task.wait(1)
						end

						return "Find the cell key"
					end

					if HiddenSettle(MegaloGate + Vector3.new(0, 3, 4), 8) then
						v11.gateOpen = arg:InvokeServer("Unlock") == true
						task.wait(1)
					end

					return "Unlock the tower gate"
				end

				return "Waiting for Don Megalo's tower", true
			end,
		}

		tbl9[13] = {
			Island = "Magma Village",
			Name = "Magma Ore Extraction",
			RetryDelay = 600,
			NoMoment = function()
				return RunMagmaOreCave()
			end,
			Run = function(arg)
				local v11 = RunMagmaOreCave()
				if v11 then
					return v11
				end
				local magmaOreExtraction = HiddenEvent.announced and HiddenEvent.announced["Magma Ore Extraction"]
				local flag = not arg.Active

				if flag then
					flag = not (magmaOreExtraction and tick() - magmaOreExtraction < 900)
				end

				if flag then
					return "Waiting for the drilling at Magma Village", true
				end
				local backArea = workspace.Map.Magma:FindFirstChild("BackArea")
				backArea = backArea and backArea:FindFirstChild("Elevator")
				backArea = backArea and backArea:FindFirstChild("Part")
				if not backArea then
					return "Waiting for the drilling at Magma Village", true
				end
				local humanoidRootPart = localPlayer.Character.HumanoidRootPart

				if HiddenGoTo(backArea.Position + Vector3.new(0, 4, 0), 6) then
					HiddenHold(CFrame.new(backArea.Position + Vector3.new(0, 4, 0)))
					pcall(firetouchinterest, humanoidRootPart, backArea, 0)
					task.wait(0.2)
					pcall(firetouchinterest, humanoidRootPart, backArea, 1)
					task.wait(3)
				end

				return "Take the mine elevator"
			end,
		}

		tbl9[14] = {
			Island = "Frozen Village",
			Name = "Snowman",
			Run = function(arg)
				return BuildHiddenSnowman(arg)
			end,
		}

		tbl9[15] = {
			Island = "Marine Fortress",
			Name = "Battle Plans",
			RetryDelay = 300,
			Run = function(arg)
				ListenHiddenRaidChat()

				local v11 = GetHiddenState("Battle Plans", function(arg2, arg3)
					if arg3 == "RaidStart" then
						arg2.raid = tick()
						arg2.failed = nil
					elseif arg3 == "Failed" then
						arg2.raid = nil
						arg2.failed = tick()
					end
				end)

				local position = workspace.Map.MarineBase:GetPivot().Position
				local bonusMomentLocations = workspace.Map.MarineBase:FindFirstChild("BonusMoment_Locations")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("PirateShip_Spawn")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations.Position or position
				local v12 = ListHiddenRaidShips(bonusMomentLocations)
				local battlePlans = (HiddenEvent.announced or {})["Battle Plans"]
				local raidWarn = HiddenEvent.raidWarn

				if raidWarn then
					local raidWarn2 = HiddenEvent.raidWarn
					raidWarn = tick() - raidWarn2 < 900
				end

				raidWarn = raidWarn or battlePlans and tick() - battlePlans < 900
				local raid = v11.raid

				if raid then
					local raid2 = v11.raid
					raid = tick() - raid2 < 900
				end

				if not arg.Active and not raid and not raidWarn and #v12 == 0 then
					LeaveHiddenCannon()
					return "Waiting for pirates to raid the Marine Fortress", true
				end
				HiddenEvent.stallGrace = tick() + 60
				local v13 = v12[1]

				if v13 and v13.model.Parent then
					local model = v13.model
					if not AimHiddenCannon(v13.pos) then
						return "Boarding the fortress cannon"
					end

					if ShootHiddenCannon(v13.pos) then
						return "Shelling " .. model.Name .. " (" .. #v12 .. " ships left)"
					end
					return "Aiming the cannon at " .. model.Name
				end

				if AimHiddenCannon(bonusMomentLocations + Vector3.new(0, 20, 0)) then
					return "Manning the cannon, waiting for the pirate fleet"
				end
				return "Go to the fortress cannon"
			end,
		}

		tbl9[16] = {
			Island = "Colosseum",
			Name = "Crowd Favorite",
			RetryDelay = 600,
			Run = function()
				local v11 = GetHiddenState("Crowd Favorite", function(arg, arg2, target, fill)
					if arg2 == "ShowTarget" then
						arg.target = target
					elseif arg2 == "Hit" then
						arg.fill = fill
					elseif arg2 == "SetActive" then
						arg.active = target == true
					end
				end)

				local target = v11.target or workspace:FindFirstChild("Ring")
				local v12 = ipairs
				local descendants = target and target.Parent and target:GetDescendants() or {}
				local v13 = nil

				for _, descendant in v12(descendants) do
					if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						v13 = descendant
						break
					else
						v13 = nil
					end
				end

				if not v13 then
					return "Waiting for a Colosseum target", true
				end
				HitHiddenPart(v13)
				if v11.active then
					return "Crowd show: " .. math.floor((tonumber(v11.fill) or 0) * 100) .. "%"
				end
				return "Hit the ring to start the show"
			end,
		}

		tbl9[17] = {
			Island = "SkyArea2",
			Name = "Temple Intel",
			Run = function(arg)
				return RunHiddenTempleIntel(arg)
			end,
		}

		tbl9[18] = {
			Island = "Pirate Village",
			Name = "Tavern Brawl",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("Tavern Brawl", function(arg2, arg3, arg4)
					if arg3 == "SetAvailable" then
						arg2.available = arg4 == true
					elseif arg3 == "BreachStart" then
						arg2.stage = "breach"
					elseif arg3 == "DoorsBurst" then
						arg2.stage = "inside"
					elseif arg3 == "FightStart" then
						arg2.stage = "fight"
					elseif arg3 == "GangUpStart" then
						arg2.stage = "gang"
					elseif arg3 == "BrawlersDefeated" then
						arg2.stage = "defeated"
					elseif arg3 == "ResetProgress" then
						arg2.stage = nil
						arg2.sent = {}
					end
				end)

				local tavernNEW = workspace.Map.Pirate:FindFirstChild("TavernNEW", true)
				tavernNEW = tavernNEW and tavernNEW:FindFirstChild("TavernDoor", true)
				local position = tavernNEW and tavernNEW:GetPivot().Position or Vector3.new(-1121, 14, 4121)

				if v11.stage == "defeated" then
					local tavernOwner = workspace.Terrain:FindFirstChild("Tavern Owner")

					if HiddenSettle(tavernOwner and (tavernOwner:GetPivot() * CFrame.new(0, 0, -4)).Position or position, 6) then
						arg:FireServer("ClaimReward")
						arg:FireServer("ExitTavern")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Take the brew from the Bartender"
				end

				v11.sent = v11.sent or {}

				if v11.stage and not v11.sent[v11.stage] then
					v11.sent[v11.stage] = true

					if v11.stage == "gang" then
						arg:FireServer("BeginGangUp")
					elseif v11.stage == "fight" or v11.stage == "inside" then
						arg:FireServer("BeginFight")
					elseif v11.stage == "breach" then
						arg:FireServer("TakeBreachSpot")
						task.wait(0.6)
						arg:FireServer("DoorsKicked")
					end

					task.wait(1)
					return "Start the tavern brawl (" .. v11.stage .. ")"
				end

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 120 and string.find(child.Name, "Tavern") then
						KillHiddenEnemy(child)
						return "Beat up the tavern punks"
					end
				end

				if v11.stage == "gang" or v11.stage == "fight" or v11.stage == "inside" or v11.stage == "breach" then
					if tick() - (v11.resent or 0) > 15 then
						v11.resent = tick()
						v11.sent[v11.stage] = nil
					end

					return "Waiting for the brawlers"
				end

				if not v11.available and not arg.Active then
					return "Waiting for the tavern brawl (strange winds)", true
				end

				if HiddenSettle(position + Vector3.new(0, 3, 6), 10) then
					arg:FireServer("Breach")
					task.wait(2)
				end

				return "Breach the shaking tavern door"
			end,
		}

		tbl9[19] = {
			Island = "Fountain",
			Name = "Sewer Gangs",
			RetryDelay = 600,
			Precheck = function()
				local clockTime = game:GetService("Lighting").ClockTime
				if clockTime >= 18 or clockTime < 6 then
					return true
				end
				return false, "waiting for night time"
			end,
			Run = function(arg)
				local v11 = GetHiddenState("Sewer Gangs", function(arg2, arg3, arg4)
					if arg3 == "TreasureReady" and typeof(arg4) == "CFrame" then
						arg2.chest = arg4.Position
					end
				end)

				if v11.chest then
					if HiddenSettle(v11.chest + Vector3.new(0, 3, 0), 5) then
						if arg:InvokeServer("ClaimTreasure") == true then
							v11.chest = nil
							HiddenEvent.checked = 0
						end

						task.wait(1)
					end

					return "Claim the gang's treasure"
				end

				local sewerSystem = workspace.Map:FindFirstChild("SewerSystem")

				if sewerSystem and (localPlayer:GetAttribute("CurrentLocation") == "Sewers" or localPlayer.Character:GetPivot().Position.Y < -300) then
					local position = localPlayer.Character:GetPivot().Position

					for _, child in ipairs(workspace.Enemies:GetChildren()) do
						if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 700 then
							KillHiddenEnemy(child)
							return "Fight Megalo's sewer gang"
						end
					end

					if HitHiddenTriggers({ sewerSystem:FindFirstChild("BreakableWalls", true) }) then
						return "Break through the sewer walls"
					end
					local sewerEnemyRooms = sewerSystem:FindFirstChild("SewerEnemyRooms", true)
					HiddenEvent.sewerRoom = (HiddenEvent.sewerRoom or 0) % math.max(#(sewerEnemyRooms and sewerEnemyRooms:GetChildren() or {}), 1) + 1
					local v12

					if sewerEnemyRooms then
						local sewerRoom = HiddenEvent.sewerRoom
						v12 = sewerEnemyRooms:GetChildren()[sewerRoom]
					else
						v12 = sewerEnemyRooms
					end

					if v12 then
						HiddenGoTo(v12:GetPivot().Position + Vector3.new(0, 5, 0), 20)
						task.wait(2)
					end

					return "Search the sewers"
				end

				local cranes = workspace.Map.Fountain:FindFirstChild("Cranes")
				local sewerEntrancePrompt = cranes and cranes:FindFirstChild("SewerEntrancePrompt", true)
				cranes = cranes and cranes:FindFirstChild("CraneBonus")
				local sewerEntrance = workspace.Map.Fountain:FindFirstChild("SewerEntrance")

				if cranes and sewerEntrance and cranes:GetAttribute("SewerEntranceLifted") then
					HiddenMove(CFrame.new(sewerEntrance.Position + Vector3.new(0, 1, 0)))
					local humanoidRootPart = localPlayer.Character.HumanoidRootPart

					pcall(function()
						firetouchinterest(humanoidRootPart, sewerEntrance, 0)
						firetouchinterest(humanoidRootPart, sewerEntrance, 1)
					end)

					task.wait(8)
					return "Drop into the sewer entrance"
				end

				if sewerEntrancePrompt and sewerEntrancePrompt.Enabled then
					if HiddenSettle(sewerEntrancePrompt.Parent.WorldPosition + Vector3.new(0, 3, 0), 6) then
						HoldHiddenPrompt(sewerEntrancePrompt)
						local now = tick()

						while true do
							task.wait(0.3)
							if not (cranes and cranes:GetAttribute("SewerEntranceLifted") or tick() - now > 5) then
								continue
							end
							break
						end

						task.wait(2.6)
					end

					return "Lift the crane over the sewer"
				end

				return "The sewers only open at night", true
			end,
		}

		tbl9[20] = {
			Island = "Jungle",
			Name = "The Thieving Monkey",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("The Thieving Monkey", function(arg2, arg3, footprints, arg4)
					if arg3 == "Footprints" then
						footprints = type(footprints) == "table" and footprints or nil
						arg2.footprints = footprints
					elseif arg3 == "HatState" then
						arg2.ownsHat = footprints == true

						if arg2.ownsHat then
							arg2.pickup = nil
						end
					elseif arg3 == "HatDropped" then
						local position = typeof(footprints) == "CFrame" and footprints.Position
						local flag

						if position then
							flag = position
						else
							flag = typeof(footprints) == "Vector3" and footprints
						end

						arg2.pickup = flag or typeof(arg4) == "CFrame" and arg4.Position or typeof(arg4) == "Vector3" and arg4 or nil
						arg2.dropped = tick()
					elseif arg3 == "ClearHatPickup" then
						arg2.pickup = nil
					elseif arg3 == "MonkeyFalling" then
						arg2.monkey = typeof(footprints) == "Instance" and footprints or arg2.monkey
						arg2.landed = tick()
					elseif arg3 == "MonkeyLanded" then
						arg2.landed = tick()
					elseif arg3 == "MonkeyRetreat" or arg3 == "MonkeyDefeated" then
						arg2.landed = nil
					end
				end)

				local flag = not v11.landed and not v11.pickup

				if flag then
					flag = tick() - (v11.initialized or 0) > 30
				end

				if flag then
					v11.initialized = tick()
					arg:FireServer("Initialize")
					task.wait(1)
				end

				if v11.ownsHat or localPlayer.Backpack:FindFirstChild("Adventurer's Hat") or localPlayer.Character:FindFirstChild("Adventurer's Hat") then
					v11.pickup = nil

					if HiddenSettle((GetNpcPosition("Adventurer") or Vector3.new(-1680, 48, 175)) + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("ReturnHat")
						task.wait(1)

						if not arg.Completed then
							pcall(TalkHiddenNpc, "Adventurer", { "Return the hat", "You're welcome." })
						end

						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Return the hat to the Adventurer"
				end

				local adventurerSHat = workspace._WorldOrigin:FindFirstChild("Adventurer's Hat")
				local handle = adventurerSHat and adventurerSHat:FindFirstChild("Handle")

				if handle then
					v11.pickup = v11.pickup or handle.Position
				end

				if v11.pickup then
					local position = handle and handle.Position or v11.pickup

					if HiddenGoTo(position + Vector3.new(0, 2, 0), 8) then
						HiddenHold(CFrame.new(position + Vector3.new(0, 2, 0)))
						handle = handle and handle:FindFirstChildOfClass("ProximityPrompt")

						if handle and handle.Enabled then
							pcall(fireproximityprompt, handle)
						else
							arg:FireServer("ClaimHat")
						end

						task.wait(1)
					end

					local flag2 = not adventurerSHat

					if flag2 then
						flag2 = tick() - (v11.dropped or 0) > 20
					end

					if flag2 then
						v11.pickup = nil
					end

					return "Pick up the Adventurer's Hat"
				end

				local v12 = nil

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					local flag2 = child.Name == "Monkey"

					if flag2 then
						local name_ = localPlayer.Name
						flag2 = child:GetAttribute("LocalEnemy") == name_
					end

					if flag2 then
						v12 = child
						break
					else
						v12 = nil
					end
				end

				local humanoidRootPart = v12 and v12:FindFirstChild("HumanoidRootPart")

				if humanoidRootPart and v11.landed then
					HiddenEvent.stallGrace = tick() + 5

					if HiddenGoTo(humanoidRootPart.Position + Vector3.new(0, 2, 4), 12) then
						HiddenHold(humanoidRootPart.CFrame * CFrame.new(0, 2, 4))
						EquipHiddenWeapon("Melee")

						if os.clock() - (HiddenEvent.lastHit or 0) >= 0.4 then
							HiddenEvent.lastHit = os.clock()
							HiddenModules.RegisterAttack:FireServer(0.3)
							HiddenModules.RegisterHit:FireServer(humanoidRootPart, { { v12, humanoidRootPart } })
						end
					end

					return "Catch the thieving monkey"
				end

				if not v11.footprints then
					return "Waiting for the monkey to steal the hat", true
				end
				local vector = Vector3.zero
				local n = 0

				for _, footprint in pairs(v11.footprints) do
					if typeof(footprint) == "CFrame" then
						vector += footprint.Position
						n += 1
					end
				end

				local position = n > 0 and vector / n or localPlayer.Character:GetPivot().Position
				local v13 = nil
				local v14 = nil

				for _, v15 in ipairs(game:GetService("CollectionService"):GetTagged("ValidMonkeyTree")) do
					local magnitude = (v15:GetPivot().Position - position).Magnitude

					if not v13 or magnitude < v13 then
						v13 = magnitude
						v14 = v15
					end
				end

				local v15 = ipairs
				local descendants = v14 and v14:GetDescendants() or {}
				local v16 = nil

				for _, descendant in v15(descendants) do
					if descendant.Name == "Leaves" and descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						if not v16 or (descendant.Position - position).Magnitude < (v16.Position - position).Magnitude then
							v16 = descendant
						end
					end
				end

				if v16 then
					if HiddenGoTo(v16.Position + Vector3.new(0, 0, 6), 10) then
						HiddenHold(CFrame.new(v16.Position + Vector3.new(0, 0, 6)))
						HitHiddenPart(v16)
					end

					return "Follow the footprints and shake the tree"
				end

				if v14 and HitHiddenTriggers({ v14 }) then
					return "Follow the footprints and shake the tree"
				end
				return "Follow the monkey footprints", true
			end,
		}

		tbl9[21] = {
			Island = "Underwater City",
			Name = "Fishman Karate",
			Run = function(arg)
				if arg:InvokeServer("Initialize") == true then
					arg:InvokeServer("Complete")
					HiddenEvent.checked = 0
					task.wait(2)
					return "Bend the light for the Water Kung Fu Teacher"
				end

				return "Waiting for the sealed door", true
			end,
		}

		tbl9[22] = {
			Island = "Underwater City",
			Name = "Beyond the Bubble",
			Run = function(arg)
				local v11 = FindHiddenEnemy({ "Evil Wraith" }, Vector3.new(61696, 532, -1420), 400)
				if v11 then
					KillHiddenEnemy(v11)
					return "Clear the evil from the cavern"
				end
				local v12 = game:GetService("CollectionService"):GetTagged("CursedChest")[1]

				if v12 then
					local isBasePart = v12:IsA("BasePart") and v12 or v12:FindFirstChildWhichIsA("BasePart", true)

					if isBasePart and HiddenSettle(isBasePart.Position + Vector3.new(0, 3, 0), 9) then
						arg:InvokeServer("OpenChest")
						HiddenEvent.checked = 0
						task.wait(2)
					end

					return "Open the cursed chest"
				end

				HiddenGoTo(Vector3.new(61696, 532, -1420), 30)
				return "Ride the bubble to the cavern", localPlayer:DistanceFromCharacter(Vector3.new(61696, 532, -1420)) < 40
			end,
		}

		tbl9[23] = {
			Island = "Magma Village",
			Name = "Evil Slimes",
			Run = function()
				local bonusMomentLocations = workspace.Map.Magma:FindFirstChild("BonusMoment_Locations")
				bonusMomentLocations = bonusMomentLocations and bonusMomentLocations:FindFirstChild("SlimeGeyser")
				if not bonusMomentLocations then
					return "Waiting for the slime geyser", true
				end
				local position = bonusMomentLocations:GetPivot().Position
				local v11 = nil

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if string.find(child.Name, "Slime") and IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 400 then
						v11 = child
						break
					else
						v11 = nil
					end
				end

				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat the Evil Slimes"
				end
				local tbl10 = {}

				for _, descendant in ipairs(bonusMomentLocations:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant:HasTag("M1HitRegistry") then
						table.insert(tbl10, descendant)
					end
				end

				if #tbl10 == 0 then
					return "Waiting for the slime geyser", true
				end

				table.sort(tbl10, function(arg, arg2)
					return localPlayer:DistanceFromCharacter(arg.Position) < localPlayer:DistanceFromCharacter(arg2.Position)
				end)

				HitHiddenPart(tbl10[1])
				return "Smash the strange geyser"
			end,
		}

		tbl9[24] = {
			Island = "Sky",
			Name = "Unexpected Guest",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("Unexpected Guest", function(arg2, arg3)
					if arg3 == "Cleared" then
						arg2.cleared = true
					elseif arg3 == "VaultGuards" or arg3 == "ArchOpen" then
						arg2.guards = true
					elseif arg3 == "AmbushCleared" then
						arg2.ambushCleared = true
					elseif arg3 == "VaultOpened" then
						arg2.vaultOpened = true
					elseif arg3 == "DoorSealed" or arg3 == "Occupants" then
						arg2.cleared = nil
						arg2.guards = nil
						arg2.ambushCleared = nil
						arg2.vaultOpened = nil
					end
				end)

				local skyCastle = workspace.Map.Sky:FindFirstChild("SkyCastle")
				if not skyCastle or not arg.Active then
					return "Waiting for strangers at the castle", true
				end
				local skyInterior = skyCastle:FindFirstChild("SkyInterior")
				local vault = skyInterior and skyInterior:FindFirstChild("Vault")

				if v11.vaultOpened then
					local angelicVaultChest = workspace:FindFirstChild("AngelicVaultChest")
					angelicVaultChest = angelicVaultChest and angelicVaultChest:GetPivot().Position or vault and vault:GetPivot().Position

					if angelicVaultChest and HiddenSettle(angelicVaultChest + Vector3.new(0, 3, 5), 10) then
						arg:InvokeServer("TakeChest")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Take the vault treasure"
				end

				local position = skyCastle:GetPivot().Position

				for _, child in ipairs(workspace.Enemies:GetChildren()) do
					if IsHiddenTarget(child) and (child:GetPivot().Position - position).Magnitude < 350 then
						KillHiddenEnemy(child)
						return "Clear out the castle intruders"
					end
				end

				if v11.code and v11.ambushCleared and vault then
					if HiddenSettle(vault:GetPivot().Position + Vector3.new(0, 3, 6), 12) then
						arg:InvokeServer("VaultCodes")
						arg:InvokeServer("TryCode", v11.code)
						task.wait(1.5)
					end

					return "Open the Angelic Vault (" .. v11.code .. ")"
				end

				skyInterior = skyInterior and skyInterior:FindFirstChild("Letter")

				if skyInterior and not v11.code then
					if HiddenSettle(skyInterior.Position + Vector3.new(0, 3, 3), 8) then
						local response = arg:InvokeServer("ReadLetter")
						v11.code = type(response) == "string" and response or nil
						task.wait(1)
					end

					return "Read the crumpled letter"
				end

				if v11.code and not v11.guards then
					arg:FireServer("CutsceneDone")
					arg:FireServer("GuardsOut")
					task.wait(2)
					return "Wait for the vault guards"
				end

				local secretDoor = skyCastle:FindFirstChild("SecretDoor")

				if secretDoor and v11.cleared then
					local n = 0
					local v12 = nil

					for _, descendant in ipairs(secretDoor:GetDescendants()) do
						if descendant:IsA("BasePart") and descendant.Size.X * descendant.Size.Y * descendant.Size.Z > n then
							n = descendant.Size.X * descendant.Size.Y * descendant.Size.Z
							v12 = descendant
						end
					end

					if v12 and HiddenSettle(v12.Position + Vector3.new(0, 0, 4), 10) then
						arg:FireServer("BreakDoor")
						task.wait(1.5)
					end

					return "Break the secret door"
				end

				HiddenGoTo(position + Vector3.new(0, 20, 0), 60)
				return "Search the castle", true
			end,
		}

		tbl9[25] = {
			Island = "Sky",
			Name = "The Clown's Jewels",
			RetryDelay = 600,
			Run = function(arg)
				local v11 = GetHiddenState("The Clown's Jewels", function(arg2, arg3, arg4, arg5)
					if arg3 == "CloudStruck" then
						arg2.chest = typeof(arg5) == "CFrame" and arg5.Position or nil
						arg2.provoked = nil
						arg2.ready = nil
					elseif arg3 == "Restore" then
						arg2.chest = typeof(arg4) == "CFrame" and arg4.Position or arg2.chest
					elseif arg3 == "ChestReady" then
						arg2.ready = typeof(arg4) == "CFrame" and arg4.Position or nil
					elseif arg3 == "Reset" or arg3 == "Setup" then
						arg2.chest = nil
						arg2.ready = nil
						arg2.provoked = nil
					end
				end)

				if v11.ready then
					if HiddenGoTo(v11.ready + Vector3.new(0, 3, 0), 4) then
						arg:FireServer("Collect")
						v11.ready = nil
						HiddenEvent.checked = 0
						task.wait(1)
					end

					return "Collect the Skylands treasure"
				end

				for _, v12 in ipairs(game:GetService("CollectionService"):GetTagged("ClownJewelsGuard")) do
					local name_ = localPlayer.Name
					if v12:GetAttribute("LocalEnemy") == name_ and IsHiddenTarget(v12) then
						KillHiddenEnemy(v12)
						return "Defeat the Sky Bandits"
					end
				end

				if v11.chest and localPlayer:DistanceFromCharacter(v11.chest) <= 25 then
					if workspace:FindFirstChild("ClownJewelsLockedChest") or workspace:FindFirstChild("ClownJewelsChest") then
						v11.missing = nil
					else
						v11.missing = v11.missing or tick()
						local missing = v11.missing

						if tick() - missing > 8 then
							v11.chest = nil
							v11.missing = nil
							v11.provoked = nil
						end
					end
				end

				if v11.chest then
					local flag = HiddenSettle(v11.chest + Vector3.new(0, 3, 6), 12)

					if flag then
						flag = tick() - (v11.provoked or 0) > 15
					end

					if flag then
						v11.provoked = tick()
						arg:FireServer("Provoke")
						task.wait(1)
						arg:FireServer("BeginFight")
					end

					return "Claim the chained chest"
				end

				if not arg.Active then
					return "The treasure clouds are quiet", true
				end
				local persistentParts = workspace._WorldOrigin:FindFirstChild("PersistentParts")
				local v12 = FindTaggedPartIn(persistentParts and persistentParts:FindFirstChild("ClownJewelsClouds"))
				if v12 then
					HitHiddenPart(v12)
					return "Break the treasure cloud"
				end
				return "Waiting for the treasure cloud", true
			end,
		}

		tbl9[26] = {
			Island = "Sky",
			Name = "Electric Fighting Teacher",
			Run = function()
				local v11 = GetChargedClouds()
				local electro = HiddenEvent.electro
				local flag = not electro
				local flag2

				if flag then
					flag2 = flag
				else
					local time_ = electro.time
					flag2 = tick() - time_ > 5
				end

				if flag2 then
					electro = { time = tick(), state = CommF:InvokeServer("ElectroQuestState") }
					HiddenEvent.electro = electro
				end

				local vector = GetNpcPosition("Mad Scientist") or Vector3.new(-4628.9, 12, -355.7)

				if electro.state == 4 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						if CommF:InvokeServer("DeliverLightningBolt") ~= 1 then
							CommF:InvokeServer("BuyElectro")
						end

						HiddenEvent.electro = nil
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Bring the Lightning Bolt to the Mad Scientist"
				end

				if electro.state ~= 1 and electro.state ~= 2 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						CommF:InvokeServer("AcceptElectroQuest")
						HiddenEvent.electro = nil
						task.wait(1)
					end

					return "Ask the Mad Scientist about Electric"
				end

				for k, v12 in pairs(v11) do
					local M1HitRegistry = nil

					for _, v13 in ipairs(v12) do
						if v13.Parent and v13:HasTag("M1HitRegistry") then
							M1HitRegistry = v13
							break
						else
							M1HitRegistry = nil
						end
					end

					M1HitRegistry = M1HitRegistry or k.Parent and k:HasTag("M1HitRegistry") and k

					if M1HitRegistry then
						HitHiddenPart(M1HitRegistry)
						HiddenEvent.electro.time = tick() - 4
						return "Strike the charged storm cloud"
					end

					v11[k] = nil
				end

				HiddenGoTo(Vector3.new(-5025, 820, -640), 200)
				return "Look for a charged storm cloud", true
			end,
		}

		tbl9[27] = {
			Island = "Fountain",
			Name = "Fountain Pipe Repair",
			Run = function(arg)
				local fountainPipeRepairState = arg.MiscData._fountainPipeRepairState
				local fountainPipeNodes = workspace._WorldOrigin:FindFirstChild("FountainPipeNodes")
				if not fountainPipeRepairState or not fountainPipeNodes or not fountainPipeRepairState.pipes then
					return "Waiting for the fountain pipes", true
				end

				if not fountainPipeRepairState.fullyRepaired then
					for _, child in ipairs(fountainPipeNodes:GetChildren()) do
						local attribute = child:GetAttribute("FountainPipeRepairId")
						local v11 = attribute and fountainPipeRepairState.pipes[attribute]
						if v11 and v11.currentSteps ~= 0 then
							HitHiddenPart(child)
							return "Rotate " .. attribute .. " (" .. fountainPipeRepairState.repairedCount .. "/" .. fountainPipeRepairState.totalPipes .. ")"
						end
					end

					return "Waiting for the water to flow", true
				end

				local boat = fountainPipeRepairState.boat
				boat = boat and boat:FindFirstChild("FakeVehicleSeat")

				if boat and HiddenSettle(boat.Position + Vector3.new(0, 3, 0), 5) then
					arg:InvokeServer("TurnIn")
					HiddenEvent.checked = 0
					task.wait(3)
				end

				return "Launch the stuck ship"
			end,
		}

		tbl9[28] = {
			Island = "Colosseum",
			Name = "King's Apprentice",
			Run = function(arg)
				local vector = GetNpcPosition("Colosseum Emperor") or Vector3.new(-1846.5, 90, -3333.6)
				local kingSApprentice = workspace:FindFirstChild("King's Apprentice")

				if arg.Progress == 1 then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("Report")
						task.wait(1.5)
						HiddenEvent.checked = 0
					end

					return "Report to the Emperor"
				end

				local v11 = kingSApprentice and FindHiddenEnemy({ "Gladiator", "Upgraded Gladiator", "Supreme Gladiator" }, kingSApprentice.StartMatchHitbox.Position, 250)
				if v11 then
					KillHiddenEnemy(v11)
					return "Defeat the gladiator waves"
				end

				if not arg.Active then
					if HiddenSettle(vector + Vector3.new(0, 1.5, 4), 8) then
						arg:FireServer("Interact")
						task.wait(1.5)
					end

					return "Accept the Emperor's challenge"
				end

				if kingSApprentice and HiddenSettle(kingSApprentice.StartMatchHitbox.Position + Vector3.new(0, 3, 0), 6) then
					if tick() - (HiddenEvent.matchStarted or 0) > 20 then
						HiddenEvent.matchStarted = tick()
						arg:FireServer("StartMatch")
					end
				end

				return "Step into the arena"
			end,
		}

		tbl9[29] = {
			Island = "Colosseum",
			Name = "Legendary Creator Statues",
			RetryDelay = 1800,
			Precheck = function()
				if not GetHiddenFruitM1() then
					local v11, v12 = EnsureHiddenFruit("Legendary Creator Statues")
					if not v11 then
						NotifyHiddenFruitM1("Legendary Creator Statues")
						return false, v12 or "needs an eaten Blox Fruit with M1 for the Fruit statue"
					end
				end

				return true
			end,
			Run = function()
				local podiumModels = workspace.Map.Colosseum:FindFirstChild("PodiumModels")
				if not podiumModels then
					return "Waiting for the statues", true
				end

				local v11 = GetHiddenState("Legendary Creator Statues", function(arg, arg2, arg3)
					if typeof(arg3) == "Instance" then
						arg3 = arg3.Name
					end

					if arg2 == "PodiumLit" then
						arg[arg3] = true
					elseif arg2 == "PodiumHit" then
						arg.seen = arg.seen or {}
						arg.seen[arg3] = (arg.seen[arg3] or 0) + 1
					elseif arg2 == "PodiumWrong" or arg2 == "Loaded" or arg2 == "Completed" then
						for _, v11 in ipairs({ "Melee", "Sword", "Fruit", "Gun" }) do
							arg[v11] = nil
						end

						arg.seen = nil
						arg.tries = nil
					end
				end)

				for _, v12 in ipairs({ "Sword", "Fruit", "Melee", "Gun" }) do
					local podiumTouchBox = podiumModels:FindFirstChild(v12)
					podiumTouchBox = podiumTouchBox and podiumTouchBox:FindFirstChild("PodiumTouchBox")

					if podiumTouchBox and not v11[v12] then
						if localPlayer:DistanceFromCharacter(podiumTouchBox.Position) > 12 then
							HiddenMove(podiumTouchBox.CFrame * CFrame.new(0, 3, 9))
						else
							if not HiddenSettle((podiumTouchBox.CFrame * CFrame.new(0, 3, 6)).Position, 10) then
								return "Go to the " .. v12 .. " statue"
							end

							if v12 == "Fruit" then
								if not GetHiddenFruitM1() then
									EnsureHiddenFruit("the Fruit statue")
								end

								if not GetHiddenFruitM1() or not EquipHiddenWeapon("Blox Fruit") then
									NotifyHiddenFruitM1("the Fruit statue")
									HiddenEvent.skipped["Legendary Creator Statues"] = tick() + 1800
									return "Need a Blox Fruit with M1 for the Fruit statue", true
								end

								UseHiddenSkillAt(podiumTouchBox)
							elseif v12 == "Gun" then
								if not ShootHiddenGunAt(podiumTouchBox) then
									return "Getting a gun for the Gun statue"
								end
							else
								if not EquipHiddenWeapon(v12) then
									return "Need a " .. v12 .. " weapon", true
								end

								if os.clock() - (HiddenEvent.lastHit or 0) >= 0.6 then
									HiddenEvent.lastHit = os.clock()
									HiddenModules.RegisterAttack:FireServer(0.3)
									HiddenModules.RegisterHit:FireServer(podiumTouchBox)
									v11.tries = v11.tries or {}
									v11.tries[v12] = (v11.tries[v12] or 0) + 1
									local flag = v11.tries[v12] >= 10

									if flag then
										flag = not (v11.seen and v11.seen[v12])
									end

									if flag then
										v11[v12] = true
									end
								end
							end
						end

						return "Power the " .. v12 .. " statue"
					end
				end

				HiddenEvent.checked = 0
				return "Waiting for the statues to answer", true
			end,
		}

		tbl9[30] = {
			Island = "Marine Fortress",
			Name = "Fortress Flagpole",
			Run = function(arg)
				local v11 = GetHiddenState("Fortress Flagpole", function(arg2, arg3, arg4, arg5, arg6, arg7)
					if arg3 == "Setup" then
						arg2.flag = typeof(arg4) == "CFrame" and arg4.Position or arg2.flag
						arg2.rope = typeof(arg5) == "CFrame" and arg5.Position or arg2.rope
						arg2.hasRope = arg7 == true
						arg2.time = tick()
					elseif arg3 == "Started" then
						arg2.rope = typeof(arg4) == "CFrame" and arg4.Position or arg2.rope
					elseif arg3 == "RopeTaken" then
						arg2.hasRope = true
					end
				end)

				local flag = not v11.time

				if not flag then
					local time_ = v11.time
					flag = tick() - time_ > 20
				end

				if flag then
					v11.time = tick()
					arg:FireServer("Init")
					task.wait(1.5)
					return "Check the flagpole"
				end

				if v11.hasRope and v11.flag then
					if HiddenSettle(v11.flag + Vector3.new(0, 3, 0), 3) then
						SetHiddenStep("Raise the flag and dodge the cannons")
						HoistHiddenFlag(arg, v11.flag + Vector3.new(0, 3, 0))
						v11.time = nil
					end

					return "Raise the flag and dodge the cannons"
				end

				if not arg.Active or not v11.rope then
					local Parlus = GetNpcPosition("Parlus")

					if Parlus and HiddenSettle(Parlus + Vector3.new(0, 1.5, 3), 8) then
						arg:FireServer("Start")
						task.wait(1.5)
					end

					return "Talk to Parlus"
				end

				if HiddenSettle(v11.rope + Vector3.new(0, 3, 0), 6) then
					arg:FireServer("TakeRope")
					task.wait(1.5)
					v11.time = nil
				end

				return "Take the hidden rope"
			end,
		}

		tbl9[31] = {
			Island = "Frozen Village",
			Name = "Breaking the Ice",
			Run = function()
				local iceberg = workspace:FindFirstChild("Iceberg")
				iceberg = iceberg and iceberg:FindFirstChild("IceRock")
				if not iceberg then
					return "Waiting for the frozen teacher", true
				end
				HitHiddenPart(iceberg)
				return "Break the ice around the Ability Teacher"
			end,
		}

		tbl9[32] = {
			Island = "Middle Town",
			Name = "Early Access",
			RetryDelay = 600,
			Run = function(arg)
				local earlyAccess = HiddenEvent.earlyAccess
				local flag = not earlyAccess

				if not flag then
					local time_ = earlyAccess.time
					flag = tick() - time_ > 8
				end

				if flag then
					earlyAccess = {
						time = tick(),
						available = arg:InvokeServer("IsAvailable") == true,
						stage = arg:InvokeServer("GetState"),
					}

					HiddenEvent.earlyAccess = earlyAccess
				end

				local n = tonumber(earlyAccess.stage) or 0

				local function fn(arg2, ...)
					if not HiddenSettle(arg2, 8) then
						return
					end

					for _, v11 in ipairs({ ... }) do
						local response, v12 = arg:InvokeServer(v11)

						if type(v12) == "number" then
							earlyAccess.stage = v12
						end

						task.wait(0.5)
					end

					earlyAccess.time = 0
				end

				local robotmegaSuperfan = workspace.NPCs:FindFirstChild("robotmega superfan")
				robotmegaSuperfan = robotmegaSuperfan and robotmegaSuperfan:GetPivot().Position + Vector3.new(0, 1.5, 3) or Vector3.new(-1044.5, 26, 1683)

				if n == 0 then
					if not earlyAccess.available then
						return "DevBros are not visiting Middle Town now", true
					end
					fn(robotmegaSuperfan, "InteractQuestGiver", "AcceptQuest")
					return "Talk to robotmega superfan"
				end

				if n == 1 then
					local earlyAccessBonusMomentAssets = workspace._WorldOrigin:FindFirstChild("EarlyAccessBonusMomentAssets")
					earlyAccessBonusMomentAssets = earlyAccessBonusMomentAssets and earlyAccessBonusMomentAssets:FindFirstChild("KeySpot")
					fn(earlyAccessBonusMomentAssets and earlyAccessBonusMomentAssets.Position + Vector3.new(0, 3, 0) or Vector3.new(-1052, 13, 1781), "CollectKey")
					return "Find the Rear Door Key"
				end

				if n == 2 then
					fn(Vector3.new(-1091.8, 14, 1806), "InteractMansionDoor")
					return "Open the rear door"
				end

				if n == 3 then
					HiddenEvent.infiltration = HiddenEvent.infiltration or tick()
					local infiltration = HiddenEvent.infiltration

					if tick() - infiltration > 9 then
						HiddenEvent.infiltration = nil
						fn(localPlayer.Character:GetPivot().Position, "FinishInfiltration")
					end

					return "Sneak into the dev room"
				end

				if n == 4 then
					fn(robotmegaSuperfan, "InteractQuestGiver", "ClaimReward")
					return "Report to robotmega superfan"
				end
				return "Waiting for Early Access", true
			end,
		}

		tbl9[33] = {
			Island = "Middle Town",
			Name = "Lookout",
			RetryDelay = 1200,
			Run = function(arg)
				local lookout = HiddenEvent.lookout
				local flag = not lookout

				if not flag then
					local time_ = lookout.time
					flag = tick() - time_ > 10
				end

				if flag then
					local response = arg:InvokeServer("GetProgress")
					lookout = { time = tick(), progress = type(response) == "table" and response or nil }
					HiddenEvent.lookout = lookout
				end

				local progress = lookout.progress
				if not progress then
					return "Waiting for Experienced Captain", true
				end

				if progress.Unlocked then
					local experiencedCaptain = workspace.NPCs:FindFirstChild("Experienced Captain")
					if experiencedCaptain and HiddenSettle(experiencedCaptain:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
						HiddenEvent.lookout = nil
						return RunHiddenLookout(arg)
					end
					return "Go to the Experienced Captain for lookout duty"
				end

				if (progress.SecondsRemaining or 0) > 0 then
					local time_ = lookout.time
					local n = progress.SecondsRemaining - tick() - time_

					if n > 300 then
						HiddenEvent.retryOverride = HiddenEvent.retryOverride or {}
						HiddenEvent.retryOverride.Lookout = n - 60
					end

					return "Captain needs time (" .. FormatMagnetTime(math.max(0, n)) .. ")", n > 300
				end

				local experiencedCaptain = workspace.NPCs:FindFirstChild("Experienced Captain")

				if experiencedCaptain and HiddenSettle(experiencedCaptain:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
					arg:InvokeServer("AdvanceIntroduction")
					HiddenEvent.lookout = nil
					task.wait(1)
				end

				return "Talk to Experienced Captain (" .. (progress.IntroVisits or 0) .. "/3)"
			end,
		}

		tbl9[34] = {
			Island = "Middle Town",
			Name = "X Marks The Spot",
			Run = function(arg)
				local v11 = GetHiddenState("X Marks The Spot", function(arg2, arg3, stage, arg4, arg5, arg6, arg7)
					if arg3 == "State" then
						arg2.stage = stage
						arg2.target = typeof(arg4) == "CFrame" and arg4.Position or nil
						arg2.piece = typeof(arg7) == "CFrame" and arg7.Position or nil
					elseif arg3 == "Setup" or arg3 == "MapDropped" then
						stage = arg3 == "Setup" and stage or arg4
						arg2.pickup = typeof(stage) == "CFrame" and stage.Position or arg2.pickup
					end
				end)

				local flag = not v11.stage

				if not flag then
					flag = tick() - (v11.initialized or 0) > 60
				end

				if flag then
					v11.initialized = tick()
					arg:FireServer("Initialize")
					task.wait(1.5)
					return "Read treasure map state"
				end

				if v11.stage == "Tree" then
					local v12 = FindTaggedPartIn(workspace.Map:FindFirstChild("Town"))

					if v12 then
						HitHiddenPart(v12)
					end

					return "Shake the tree for the map"
				end

				if v11.stage == "Pickup" and v11.pickup then
					if HiddenSettle(v11.pickup + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("PickupMap")
						task.wait(1.5)
					end

					return "Pick up Treasure Map"
				end

				if v11.stage == "Map" and v11.piece then
					if HiddenSettle(v11.piece + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("CollectCheckpoint")
						task.wait(1.5)
					end

					return "Collect broken map piece"
				end

				if v11.stage == "Dig" and v11.target then
					local v12 = FindTaggedPartNear(v11.target, 4)

					if v12 then
						HitHiddenPart(v12)
					else
						HiddenGoTo(v11.target + Vector3.new(0, 3, 5), 6)
					end

					return "Dig at the X"
				end

				if v11.stage == "Chest" then
					local persistentParts = workspace._WorldOrigin:FindFirstChild("PersistentParts")
					persistentParts = persistentParts and persistentParts:FindFirstChild("Buried Treasure")
					local openPrompt = persistentParts and persistentParts:FindFirstChild("OpenPrompt", true)

					if openPrompt and HiddenSettle(openPrompt.Parent.Position + Vector3.new(0, 2, 3), 6) then
						fireproximityprompt(openPrompt)
						task.wait(1.5)
					end

					return "Open Buried Treasure"
				end

				if v11.stage == "Enemies" then
					local v12 = FindHiddenEnemy({ "Desert Skeleton" }, v11.target or localPlayer.Character:GetPivot().Position, 300)

					if v12 then
						KillHiddenEnemy(v12)
					end

					return "Defeat treasure guards"
				end

				return "Waiting for treasure", true
			end,
		}

		tbl9[35] = {
			Island = "Pirate Village",
			Name = "Windmill Maintenance",
			Run = function()
				local windmillRig = workspace.Map.Pirate:FindFirstChild("WindmillRig")
				windmillRig = windmillRig and windmillRig:FindFirstChild("Windmill_rig")
				if not windmillRig then
					return "Waiting for windmill", true
				end

				if not EquipHiddenWeapon("Sword") then
					return "Need a sword to cut the ropes", true
				end

				if not HiddenEvent.windmill then
					HiddenEvent.windmill = { cut = {} }

					HiddenEvent.windmill.connection = ListenHiddenMoment("Windmill Maintenance", function(arg, arg2)
						if arg == "RopeCut" then
							HiddenEvent.windmill.cut[arg2] = true
						end
					end)
				end

				for i_ = 1, 5 do
					local v11 = windmillRig:FindFirstChild("Rope" .. i_ .. "A")

					if v11 and not HiddenEvent.windmill.cut["Rope" .. i_] and v11.Transparency < 1 then
						if localPlayer:DistanceFromCharacter(v11.Position) > 12 then
							HiddenMove(v11.CFrame * CFrame.new(0, 0, 5))
						elseif os.clock() - (HiddenEvent.lastHit or 0) >= 0.6 then
							HiddenEvent.lastHit = os.clock()
							HiddenModules.RegisterAttack:FireServer(0.3)
							HiddenModules.RegisterHit:FireServer(v11)
						end

						return "Cut windmill rope " .. i_ .. "/5"
					end
				end

				return "Waiting for windmill to spin", true
			end,
		}

		tbl9[36] = {
			Island = "Jungle",
			Name = "Zipline Repair",
			Run = function(arg)
				local zipline = HiddenEvent.zipline
				local flag = not zipline

				if not flag then
					local time_ = zipline.time
					flag = tick() - time_ > 30
				end

				if flag then
					local v11 = nil

					v11 = ListenHiddenMoment("Zipline Repair", function(arg2, arg3, arg4, arg5, arg6, arg7, arg8)
						if arg2 == "Setup" and typeof(arg3) == "CFrame" then
							HiddenEvent.zipline = { time = tick(), pickup = arg3.Position, target = arg7, source = arg8 }
							v11:Disconnect()
						end
					end)

					arg:FireServer("Initialize")
					task.wait(2)

					if v11.Connected then
						v11:Disconnect()
					end

					return "Locate grappling hook"
				end

				local character = localPlayer.Character
				local grapplingHook = character:FindFirstChild("Grappling Hook") or localPlayer.Backpack:FindFirstChild("Grappling Hook")

				if not grapplingHook then
					if HiddenSettle(zipline.pickup + Vector3.new(0, 2, 0), 6) then
						arg:FireServer("PickupTool")
						task.wait(1.5)
					end

					return "Pick up grappling hook"
				end

				if HiddenSettle(zipline.source + Vector3.new(0, 4, 0), 6) then
					if grapplingHook.Parent ~= character then
						character.Humanoid:EquipTool(grapplingHook)
						task.wait(0.5)
					end

					local position = character.HumanoidRootPart.Position
					local target = zipline.target
					local v11 = require(ReplicatedStorage.Util.Trajectory).getArcAim(position, target)
					arg:InvokeServer("Throw", "Grappling Hook", v11)
					HiddenEvent.checked = 0
					task.wait(2)
				end

				return "Throw hook to the zipline"
			end,
		}

		tbl9[37] = {
			Island = "Desert",
			Name = "Archaeologist's Tablet",
			Run = function()
				local archaeologistSTablet = workspace:FindFirstChild("Archaeologist's Tablet")
				if not archaeologistSTablet then
					return "Waiting for tablet", true
				end

				for _, child in ipairs(archaeologistSTablet.Pillars:GetChildren()) do
					local attribute = child:GetAttribute("NumHits") or 0
					if attribute < 3 then
						HitHiddenPart(child:FindFirstChild("SandLayer" .. attribute + 1) or child.SandLayer3)
						return "Clear sand " .. child.Name .. " (" .. attribute .. "/3)"
					end
				end

				return "Waiting for completion", true
			end,
		}

		tbl9[38] = {
			Island = "Desert",
			Name = "Rescue Hasan",
			RetryDelay = 600,
			Run = function(arg)
				local hasan = workspace.NPCs:FindFirstChild("Hasan")
				local position = hasan and hasan:GetPivot().Position or Vector3.new(1308, 23, 4492)

				if (arg.Progress or 0) >= 1 then
					hasan = hasan and HiddenSettle(position + Vector3.new(0, 1.5, 4), 10)

					if hasan then
						arg:FireServer("Interact")
						HiddenEvent.checked = 0
						task.wait(1.5)
					end

					return "Talk to Hasan"
				end

				local v11 = FindHiddenEnemy({ "Desert Skeleton" }, Vector3.new(1300, 15, 4460), 250)

				if v11 then
					HiddenEvent.farmHeight = 25
					KillHiddenEnemy(v11)
					HiddenEvent.farmHeight = nil
					HiddenEvent.hasanTries = 0
					HiddenEvent.waveStarted = tick()
					return "Kill Desert Skeleton"
				end

				local rescueHasan = workspace:FindFirstChild("Rescue Hasan")
				rescueHasan = rescueHasan and rescueHasan:FindFirstChild("CutsceneTrigger")
				if not rescueHasan then
					return "Waiting for the pyramid scene", true
				end

				if tick() - (HiddenEvent.hasanHelped or 0) < 90 then
					HiddenEvent.stallGrace = tick() + 20
					return "Waiting for Hasan's skeletons to come out of the coffins"
				end
				local flag = (HiddenEvent.hasanTries or 0) >= 2
				local flag2

				if flag then
					flag2 = (HiddenEvent.hasanTries or 0) < 4
				else
					flag2 = flag
				end

				if flag2 and hasan then
					if HiddenSettle(position + Vector3.new(0, 1.5, 4), 10) then
						arg:FireServer("Interact")
						HiddenEvent.checked = 0
						HiddenEvent.hasanTries = (HiddenEvent.hasanTries or 0) + 1
						task.wait(1.5)
					end

					return "Talk to Hasan to claim the reward"
				end

				if (HiddenEvent.hasanTries or 0) >= 4 then
					HiddenEvent.hasanTries = 0
					HiddenEvent.skipped["Rescue Hasan"] = tick() + 600
					HiddenEvent.waiting["Rescue Hasan"] = "Hasan's intro did not start"
					HiddenEvent.current = nil
					return "Hasan's intro did not start, trying again later", true
				end

				if not HiddenEvent.hasanEntering then
					if not HiddenSettle(rescueHasan.Position + Vector3.new(0, 5, 38), 8) then
						return "Go to the pyramid entrance"
					end
					HiddenRelease()
					StopTweenNow()
					task.wait(1.5)
					HiddenEvent.hasanEntering = tick()
					localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(rescueHasan.Position + Vector3.new(0, 4, 0))
				end

				HiddenEvent.stallGrace = tick() + 30
				local v12 = RunHiddenDialogue({ "Help Hasan" }, 14)
				HiddenEvent.hasanEntering = nil

				if v12 then
					HiddenEvent.hasanHelped = tick()
					HiddenEvent.hasanTries = 0
					return "Help Hasan"
				end

				HiddenEvent.hasanTries = (HiddenEvent.hasanTries or 0) + 1
				return "Walk into the pyramid again"
			end,
		}

		tbl9[39] = {
			Island = "Desert",
			Name = "Prickly Harvest",
			Requires = "Sea1/Desert/Rescue Hasan",
			RetryDelay = 900,
			Run = function(arg)
				local desertMerchant = workspace.NPCs:FindFirstChild("Desert Merchant")
				local flag = arg:InvokeServer("TurnInReady") == true

				if flag or not HiddenEvent.cactusStarted then
					if desertMerchant and HiddenSettle(desertMerchant:GetPivot().Position + Vector3.new(0, 1.5, 4), 10) then
						local response = arg:InvokeServer("Interact")
						HiddenEvent.cactusStarted = response == "StartQuest" or response == "InProgress"
						if response == "Unavailable" then
							return "Cacti not blooming yet", true
						end
					end

					return flag and "Turn in Cactus Petals" or "Talk to Desert Merchant"
				end

				local huge = math.huge
				local v11 = nil

				for _, child in ipairs(workspace.Map.Desert.Cacti:GetChildren()) do
					local trunk = child:FindFirstChild("Trunk")

					if trunk and trunk:HasTag("M1HitRegistry") then
						local v12 = localPlayer:DistanceFromCharacter(trunk.Position)

						if v12 < huge then
							huge = v12
							v11 = trunk
						end
					end
				end

				if v11 then
					HitHiddenPart(v11)
					return "Harvest cactus"
				end
				return "Waiting for cacti", true
			end,
		}

		HiddenQuests = tbl9
	end

	HiddenAnnouncements = {
		{ "pirate sails", "Battle Plans" },
		{ "drilling", "Magma Ore Extraction" },
		{ "bananas", "Banana Tree" },
		{ "curious smell", "Chef's Kiss" },
		{ "rumbling echoes", "One Last Eruption" },
		{ "dark energy", "Frozen Defense" },
		{ "alarm has sounded", "Fortress Under Fire" },
		{ "bell shimmers", "Echoes Through the Clouds" },
		{ "skyland castle", "Unexpected Guest" },
		{ "sewer", "Sewer Gangs" },
		{ "clouds", "The Clown's Jewels" },
		{ "cell", "Lever Jailbreak" },
		{ "tavern", "Tavern Brawl" },
		{ "snow heavily", "Snowman" },
		{ "stands are filling", "Crowd Favorite" },
		{ "crowd wants a show", "Crowd Favorite" },
		{ "storm brews", "The Tyrant Awakens" },
		{ "invaded skylands", "Unexpected Guest" },
		{ "water is stirring", "Pearl of the Deep" },
		{ "fishman lord has risen", "Pearl of the Deep" },
		{ "junkyard", "Fountain Wire Repair" },
		{ "magnetized", "Fountain Wire Repair" },
		{ "military weaponry", "Fortress Under Fire" },
		{ "loud drilling", "Magma Ore Extraction" },
		{ "overflowing with bananas", "Banana Tree" },
		{ "pirate sails", "Battle Plans" },
		{ "fleet will be", "Battle Plans" },
		{ "lookouts have spotted", "Battle Plans" },
		{ "roar of excitement", "Crowd Favorite" },
		{ "light of a full moon", "Sewer Gangs" },
		{ "secret cloud", "The Clown's Jewels" },
		{ "skylands castle", "Unexpected Guest" },
	}

	HiddenAnnounceDriven = {}

	for _, v6 in ipairs(HiddenAnnouncements) do
		HiddenAnnounceDriven[v6[2]] = true
	end

	HiddenRemoteChecks = {
		["Crowd Favorite"] = function()
			return workspace:FindFirstChild("Ring") ~= nil
		end,
		["Archaeologist's Tablet"] = function()
			return workspace:FindFirstChild("Archaeologist's Tablet") ~= nil
		end,
		["Breaking the Ice"] = function()
			local iceberg = workspace:FindFirstChild("Iceberg")
			return iceberg ~= nil and iceberg:FindFirstChild("IceRock") ~= nil
		end,
		["Rescue Hasan"] = function()
			local rescueHasan = workspace:FindFirstChild("Rescue Hasan")
			return rescueHasan ~= nil and rescueHasan:FindFirstChild("CutsceneTrigger") ~= nil
		end,
		["Battle Plans"] = function()
			local v6 = GetHiddenIsland("Marine Fortress")
			return v6 ~= nil and #ListHiddenRaidShips(v6.World.Position) > 0
		end,
	}

	for _, v6 in ipairs(HiddenQuests) do
		if v6.BossNames and not HiddenRemoteChecks[v6.Name] then
			local bossNames = v6.BossNames

			HiddenRemoteChecks[v6.Name] = function()
				return FindAwakenedBoss(nil, bossNames) ~= nil
			end
		end
	end

	SweepHiddenRemote = function(arg)
		if tick() - (HiddenEvent.remoteSweep or 0) < 5 then
			return
		end
		HiddenEvent.remoteSweep = tick()
		HiddenEvent.remoteSeen = HiddenEvent.remoteSeen or {}

		for _, v6 in ipairs(HiddenQuests) do
			local v7 = HiddenRemoteChecks[v6.Name]

			if v7 and arg["Sea1/" .. v6.Island .. "/" .. v6.Name] ~= true then
				local ok, result = pcall(v7)

				if ok and result then
					if not HiddenEvent.remoteSeen[v6.Name] then
						HiddenEvent.remoteSeen[v6.Name] = true
						HiddenEvent.skipped[v6.Name] = nil
						HiddenEvent.announced = HiddenEvent.announced or {}
						HiddenEvent.announced[v6.Name] = tick()
						HiddenNotify(v6.Name .. " is up (seen from afar), heading there", v6.Name .. "remote", "found")
					end
				else
					HiddenEvent.remoteSeen[v6.Name] = nil
				end
			end
		end
	end

	HiddenPresenceQuests = {
		["Battle Plans"] = "Marine Fortress",
		["Magma Ore Extraction"] = "Magma Village",
		["Crowd Favorite"] = "Colosseum",
		["Unexpected Guest"] = "Sky",
		["The Clown's Jewels"] = "Sky",
		Snowman = "Frozen Village",
		["Prickly Harvest"] = "Desert",
		["The Thieving Monkey"] = "Jungle",
		["Tavern Brawl"] = "Pirate Village",
		["Sewer Gangs"] = "Fountain",
	}

	NearestHiddenSpawn = function(arg)
		local playerSpawns = workspace._WorldOrigin:FindFirstChild("PlayerSpawns")
		local v6, v7, v8 = ipairs(playerSpawns and playerSpawns:GetDescendants() or {})
		local v9 = nil
		local v10 = nil

		for _, v11 in v6, v7, v8 do
			if v11:IsA("BasePart") then
				local magnitude = (v11.Position - arg).Magnitude

				if not v9 or magnitude < v9 then
					v9 = magnitude
					v10 = v11
				end
			end
		end

		return v10 and v10.Position + Vector3.new(0, 4, 0), v9
	end

	PickHiddenParkSpot = function(arg)
		local tbl9 = {}

		for _, v6 in ipairs(HiddenQuests) do
			local island = HiddenPresenceQuests[v6.Name] and v6.Island

			if island and arg["Sea1/" .. v6.Island .. "/" .. v6.Name] ~= true and (not v6.Requires or arg[v6.Requires] == true) and not table.find(tbl9, island) then
				table.insert(tbl9, island)
			end
		end

		local park = HiddenEvent.park
		local flag

		if park then
			flag = not table.find(tbl9, park.island)

			if not flag then
				local since = park.since
				flag = tick() - since > 900
			end
		else
			flag = park
		end

		if flag then
			local n = (table.find(tbl9, park.island) or 0) % math.max(#tbl9, 1) + 1
			park = tbl9[n] and { island = tbl9[n], since = tick() } or nil
		elseif not park and #tbl9 > 0 then
			park = { island = tbl9[1], since = tick() }
		end

		HiddenEvent.park = park

		if park then
			local v6 = GetHiddenIsland(park.island)

			if v6 then
				local v7, v8 = NearestHiddenSpawn(v6.World.Position)
				if v7 and v8 < 2500 then
					return v7
				end
				return v6.TeleportPoints[1].Position + Vector3.new(0, 4, 0)
			end
		end

		return NearestHiddenSpawn(localPlayer.Character:GetPivot().Position) or Vector3.new(-826, 30, 1613)
	end

	HiddenSkipFile = "ZyroxHub_hidden_skip.json"

	SaveHiddenSkip = function()
		if type(writefile) ~= "function" then
			return
		end
		local tbl9 = { user = localPlayer.UserId, skips = {} }

		for k, v6 in pairs(HiddenEvent.skipped) do
			if type(k) == "string" and not k:find("^Reward:") and v6 > tick() then
				local floor = math.floor
				tbl9.skips[k] = os.time() + floor(v6 - tick())
			end
		end

		pcall(function()
			writefile(HiddenSkipFile, game:GetService("HttpService"):JSONEncode(tbl9))
		end)
	end

	LoadHiddenSkip = function()
		if HiddenEvent.skipLoaded then
			return
		end
		HiddenEvent.skipLoaded = true

		pcall(function()
			if type(isfile) == "function" and isfile(HiddenSkipFile) then
				local data = game:GetService("HttpService"):JSONDecode(readfile(HiddenSkipFile))

				if data.user == localPlayer.UserId then
					local v6 = pairs
					local skips = data.skips or {}

					for k, skip in v6(skips) do
						local n = skip - os.time()

						if n > 0 and not HiddenEvent.skipped[k] then
							HiddenEvent.skipped[k] = tick() + n
						end
					end
				end
			end
		end)
	end

	HiddenRetryDelay = function(arg)
		local retryOverride = HiddenEvent.retryOverride and HiddenEvent.retryOverride[arg.Name]
		if retryOverride then
			HiddenEvent.retryOverride[arg.Name] = nil
			return math.max(retryOverride, 120)
		end
		local retryDelay = arg.RetryDelay or 420
		if HiddenAnnounceDriven[arg.Name] then
			return math.max(retryDelay, 3600)
		end
		return retryDelay
	end

	OnHiddenAnnouncement = function(arg)
		local v6 = string.lower(tostring(arg))

		for _, v7 in ipairs(HiddenAnnouncements) do
			if string.find(v6, v7[1], 1, true) then
				HiddenEvent.announced = HiddenEvent.announced or {}
				HiddenEvent.announced[v7[2]] = tick()
				HiddenEvent.skipped[v7[2]] = nil
			end
		end
	end

	WatchHiddenAnnouncements = function()
		if HiddenEvent.watching then
			return
		end
		HiddenEvent.watching = true
		HiddenEvent.momentEvent = {}

		ReplicatedStorage.Remotes.BonusMomentsRemoteEvent.OnClientEvent:Connect(function(arg)
			HiddenEvent.momentEvent[tostring(arg)] = tick()
		end)

		local notifications = localPlayer.PlayerGui:WaitForChild("Notifications", 10)

		if notifications then
			notifications.DescendantAdded:Connect(function(descendant)
				if descendant:IsA("TextLabel") then
					task.wait(0.1)
					OnHiddenAnnouncement(descendant.Text)
				end
			end)
		end

		pcall(function()
			game:GetService("TextChatService").MessageReceived:Connect(function(arg)
				if not arg.TextSource then
					OnHiddenAnnouncement(arg.Text)
				end
			end)
		end)
	end

	CheckHiddenStall = function()
		local current = HiddenEvent.current
		local humanoidRootPart = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
		if not current or not humanoidRootPart then
			HiddenEvent.stall = nil
			return
		end
		local stall = HiddenEvent.stall
		local position = humanoidRootPart.Position
		local parent = not stall or stall.quest ~= current or stall.step ~= HiddenEvent.step or (position - stall.position).Magnitude > 25 or HiddenEvent.fighting and HiddenEvent.fighting.Parent

		if not parent then
			parent = tick() < (HiddenEvent.stallGrace or 0)
		end

		local flag

		if parent then
			flag = parent
		else
			flag = tick() - (HiddenEvent.momentEvent and HiddenEvent.momentEvent[current] or 0) < 20
		end

		local flag2

		if flag then
			flag2 = flag
		else
			flag2 = tick() - (HiddenEvent.announced and HiddenEvent.announced[current] or 0) < 420
		end

		if flag2 then
			HiddenEvent.stall = { quest = current, step = HiddenEvent.step, position = position, time = tick() }
			return
		end

		if os.date("!*t").min < 8 and string.find(tostring(HiddenEvent.step), "awaken", 1, true) then
			return
		end
		local time_ = stall.time
		if tick() - time_ < 60 then
			return
		end
		HiddenEvent.stall = nil
		HiddenEvent.skipped[current] = tick() + 120
		HiddenEvent.current = nil
		HiddenEvent.arrived = nil
		HiddenEvent.islandArrived = nil
		HiddenEvent.waitingSince = nil
		LeaveHiddenCannon()
		pcall(require(ReplicatedStorage.DialogueController).close)
		HiddenNotify(current .. " got stuck on \"" .. tostring(stall.step) .. "\", trying another quest", current .. "stall", "warning")
	end

	AutoHiddenEvent = function()
		WatchHiddenAnnouncements()
		LoadHiddenSkip()
		local v6 = GetHiddenProgress()
		SweepHiddenRemote(v6)
		if ClaimHiddenReward() then
			return
		end
		local v7 = GetHiddenRaidHint()
		local flag = v7.State == "Arming" or v7.State == "Armed" or v7.State == "Triggered"

		if not flag then
			flag = (tonumber(v7.Seconds) or math.huge) < 300
		end

		local flag2 = v7.State ~= "Triggered"

		if flag2 then
			flag2 = (tonumber(v7.Seconds) or 0) > 180
		end

		local tbl9 = {}
		local tbl10 = {}
		local tbl11 = {}

		for k, v8 in pairs(v6) do
			local flag3 = v8 == true and string.match(k, "^Sea1/([^/]+)/")

			if flag3 then
				tbl11[flag3] = (tbl11[flag3] or 0) + 1
			end
		end

		for _, v8 in ipairs(HiddenQuests) do
			local active = GetHiddenMoment(v8.Name)
			local flag3 = v8.Name == "Rescue Hasan" and active

			if flag3 then
				flag3 = tick() - (HiddenEvent.hasanHelped or 0) < 150
			end

			if flag3 then
				tbl10[v8] = -2
				HiddenEvent.skipped[v8.Name] = nil
			else
				local hintIsland = v8.HintIsland

				if hintIsland then
					active = active and active.Active

					if active then
						local name_ = v8.Name
						hintIsland = not GetHiddenBossHour().checked[name_]
					else
						hintIsland = active
					end

					hintIsland = hintIsland or flag and not flag2 and IsHiddenBossHinted(v7, v8.HintIsland, v8.BossNames)
				end

				if hintIsland then
					tbl10[v8] = -1
					HiddenEvent.skipped[v8.Name] = nil
				elseif tick() - ((HiddenEvent.announced or {})[v8.Name] or 0) < 600 then
					tbl10[v8] = -0.5
				elseif v8.Name == HiddenEvent.current then
					tbl10[v8] = 0
				else
					local n = GetHiddenIsland(v8.Island)
					n = n and localPlayer:DistanceFromCharacter(n.World.Position) or 1000000

					if v8.Island == HiddenEvent.currentIsland then
						n *= 0.0001
					end

					tbl10[v8] = 1 + math.max(n - (tbl11[v8.Island] or 0) * 4000, 0)
				end
			end

			table.insert(tbl9, v8)
		end

		table.sort(tbl9, function(arg, arg2)
			return tbl10[arg] < tbl10[arg2]
		end)

		HiddenEvent.waiting = HiddenEvent.waiting or {}
		local n = 0

		for _, v8 in ipairs(tbl9) do
			local str2 = "Sea1/" .. v8.Island .. "/" .. v8.Name

			if v6[str2] ~= true then
				n += 1
			end

			local flag3 = v6[str2] ~= true and (not v8.Requires or v6[v8.Requires] == true)

			if flag3 then
				flag3 = tick() >= (HiddenEvent.skipped[v8.Name] or 0)
			end

			if flag3 then
				flag3 = not (tick() < (HiddenEvent.prepUntil or 0) and tbl10[v8] >= 1)
			end

			if flag3 then
				local v9 = GetHiddenMoment(v8.Name)
				local v10 = HiddenRemoteChecks[v8.Name]
				local flag4 = v10 and HiddenPresenceQuests[v8.Name] and not v8.HintIsland and not v9

				if flag4 then
					flag4 = tick() - ((HiddenEvent.announced or {})[v8.Name] or 0) > 900
				end

				if flag4 then
					local flag5 = v8.Name == "Rescue Hasan"

					if flag5 then
						flag5 = tick() - (HiddenEvent.hasanHelped or 0) < 150
					end

					flag4 = not flag5
				end

				local flag5 = true
				local awakenedBossQuests = nil

				if flag4 then
					local ok, result = pcall(v10)
					ok = ok and not result
					awakenedBossQuests = nil

					if ok then
						flag5 = false
						awakenedBossQuests = "not up yet (checked from afar)"
					end
				end

				if flag5 and v8.Precheck and (not v9 or v8.HintIsland and not v9.Active) then
					flag5, awakenedBossQuests = v8.Precheck(v7)
				end

				if not flag5 then
					if HiddenEvent.waiting[v8.Name] ~= awakenedBossQuests then
						if v8.HintIsland then
							HiddenNotify("Awakened boss quests: " .. awakenedBossQuests, "bosshint", "found")
						else
							HiddenNotify(v8.Name .. ": " .. awakenedBossQuests, v8.Name .. awakenedBossQuests)
						end
					end

					HiddenEvent.waiting[v8.Name] = awakenedBossQuests
					HiddenEvent.skipped[v8.Name] = tick() + 30
					continue
				end

				if HiddenEvent.current ~= v8.Name then
					HiddenEvent.current = v8.Name
					HiddenEvent.currentIsland = v8.Island
					HiddenEvent.waitingSince = nil
					HiddenEvent.arrived = nil
					HiddenEvent.islandArrived = nil
					HiddenNotify("Start " .. v8.Name .. " (" .. v8.Island .. ")", v8.Name, "start")
				end

				HiddenEvent.idleSince = nil
				local flag6 = not v9

				if flag6 and v8.BossNames then
					for _, child in ipairs(workspace.Enemies:GetChildren()) do
						if child:GetAttribute("BossIndicatorAwakened") and IsHiddenTarget(child) then
							for _, bossName in ipairs(v8.BossNames) do
								if string.find(child.Name, bossName, 1, true) and localPlayer:DistanceFromCharacter(child:GetPivot().Position) < 2500 then
									SetHiddenStep("Defeat the awakened " .. child.Name)
									KillHiddenEnemy(child)
									HiddenEvent.checked = 0
									return
								end
							end
						end
					end
				end

				if flag6 and v8.NoMoment then
					local v11 = v8.NoMoment()
					if v11 then
						SetHiddenStep(v11)
						return
					end
				end

				if flag6 then
					if HiddenGoToIsland(v8.Island) then
						HiddenEvent.islandArrived = HiddenEvent.islandArrived or tick()
						local islandArrived = HiddenEvent.islandArrived

						if tick() - islandArrived > 8 then
							HiddenEvent.islandArrived = nil

							if v8.HintIsland then
								local name_ = v8.Name
								GetHiddenBossHour().checked[name_] = true
							end

							HiddenEvent.skipped[v8.Name] = math.max(HiddenEvent.skipped[v8.Name] or 0, tick() + HiddenRetryDelay(v8))
							SaveHiddenSkip()
							HiddenEvent.waiting[v8.Name] = v8.Name .. " is not happening on " .. v8.Island
							HiddenEvent.current = nil
							HiddenNotify(HiddenEvent.waiting[v8.Name] .. " yet, checking again later", v8.Name .. "notloaded", "warning")
						end
					else
						HiddenEvent.islandArrived = nil
					end

					return
				end

				HiddenEvent.islandArrived = nil
				local v11, v12 = v8.Run(v9)
				SetHiddenStep(v11 or "Working")

				if v12 then
					HiddenEvent.waitingSince = HiddenEvent.waitingSince or tick()
					local announced = HiddenEvent.announced and HiddenEvent.announced[v8.Name]
					local waitingSince = HiddenEvent.waitingSince
					local n3 = tick() - waitingSince
					announced = announced and tick() - announced < 420

					if announced then
						announced = v9 and v9.Active and 420 or 60
					end

					if (announced or 6) < n3 then
						HiddenEvent.waiting[v8.Name] = v11
						HiddenEvent.skipped[v8.Name] = math.max(HiddenEvent.skipped[v8.Name] or 0, tick() + HiddenRetryDelay(v8))
						SaveHiddenSkip()
						HiddenEvent.current = nil
						local name_ = v8.Name
						HiddenNotify(v8.Name .. ": " .. tostring(v11) .. ", switching to another quest", name_ .. tostring(v11), "warning")
					end
				else
					HiddenEvent.waiting[v8.Name] = nil
					HiddenEvent.waitingSince = nil
				end

				return
			end
		end

		HiddenEvent.current = nil

		if n == 0 then
			SetHiddenStep("All 39 secrets are complete")
			SaveSettings("Auto Secret Quest", false)

			if getgenv().ToggleSecretQuest and getgenv().ToggleSecretQuest.SetStage then
				getgenv().ToggleSecretQuest:SetStage(false)
			end

			HiddenNotify("All 39 secret quests are done, turning off", "secretalldone", "success")
			return
		end

		HiddenEvent.idleSince = HiddenEvent.idleSince or tick()

		if tick() - (HiddenEvent.idleNotified or 0) > 300 then
			HiddenEvent.idleNotified = tick()
			HiddenNotify("No secret quest is available right now (" .. n .. " left), checking again soon", "idle", "warning")
		end

		local tbl12 = {}

		for k in pairs(HiddenEvent.waiting) do
			local str2 = nil

			for _, v8 in ipairs(HiddenQuests) do
				if v8.Name == k then
					str2 = "Sea1/" .. v8.Island .. "/" .. v8.Name
				end
			end

			if str2 and v6[str2] ~= true then
				table.insert(tbl12, k)
			end
		end

		local v8 = nil

		for _, v9 in pairs(HiddenEvent.skipped) do
			if v9 > tick() and (not v8 or v9 < v8) then
				v8 = v9
			end
		end

		if PrepareHiddenChef(v6) then
			return
		end
		local min = os.date("!*t").min
		local flag3 = Settings["Hidden Hop Dead Hour"] ~= false and min >= 50 and min <= 58

		if flag3 then
			flag3 = tick() - (HiddenEvent.hopAt or 0) > 100
		end

		if flag3 and not IsHiddenHourUseful(v6) then
			HiddenEvent.hopAt = tick()
			if HopHiddenServer() then
				SetHiddenStep("Next awakened boss is not needed here, switching server")
				return
			end
		end

		local park = HiddenEvent.park
		local flag4 = Settings["Hidden Hop Dead Hour"] ~= false and park
		local flag5

		if flag4 then
			flag5 = tick() - (HiddenEvent.idleSince or tick()) > 1200
		else
			flag5 = flag4
		end

		flag5 = flag5 and min >= 5 and min < 45

		if flag5 then
			flag5 = tick() - (HiddenEvent.hopAt or 0) > 1200
		end

		if flag5 then
			HiddenEvent.hopAt = tick()
			if HopHiddenServer() then
				SetHiddenStep("Nothing triggered on " .. park.island .. " for 20 min, switching server")
				return
			end
		end

		if localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local v9 = PickHiddenParkSpot(v6)
			HiddenEvent.idlePark = v9

			if HiddenGoTo(v9, 60) then
				HiddenHold(CFrame.new(v9))
			end
		end

		SetHiddenStep("Waiting " .. n .. " quests" .. (v8 and " (next check in " .. math.ceil(v8 - tick()) .. "s)" or "") .. ": " .. table.concat(tbl12, ", "))
	end

	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				if not SeaOnly(StatusHiddenQuest, "Title Quest", { 1 }) then
					SeaOnly(StatusHiddenStep, "Doing Quest", { 1 })
					SeaOnly(StatusHiddenBoss, "Title Awakened Boss", { 1 })
					return
				end

				local v6 = GetHiddenProgress()
				local n = 0
				local doneCount = 0

				for _, v7 in pairs(v6) do
					n += 1
					doneCount += v7 == true and 1 or 0
				end

				if HiddenEvent.doneCount ~= doneCount then
					HiddenEvent.doneCount = doneCount
					HiddenEvent.doneAt = tick()
				end

				StatusHiddenProgress.SetText(string.format("Secret Quest : %d/39 Quests", doneCount))
				StatusHiddenQuest.SetText("Title Quest : " .. (HiddenEvent.current or "None"))
				StatusHiddenStep.SetText("Doing Quest : " .. (Settings["Auto Secret Quest"] and HiddenEvent.step or "None"))

				if Place_Id.sea1() then
					local v7 = GetHiddenRaidHint()
					local setText = StatusHiddenBoss.SetText
					local boss = v7.Boss

					if boss then
						boss = v7.Boss .. " on " .. tostring(v7.Island) .. " in " .. FormatMagnetTime(tonumber(v7.Seconds) or 0)
					end

					setText("Title Awakened Boss : " .. (boss or "None"))
				end
			end)
		end
	end)

	HiddenEventSection.CreateToggle({
		Title = "Hop Server For Secret Quest",
		Desc = "Switch server when the next awakened boss is already done, or when nothing triggers on the island for 20 min",
		Default = Settings["Hidden Hop Dead Hour"] ~= false,
	}, function(arg)
		SaveSettings("Hidden Hop Dead Hour", arg)
	end)

	do
		local v6 = nil

		task.defer(function()
			getgenv().ToggleSecretQuest = v6
		end)

		local createToggle = HiddenEventSection.CreateToggle

		local tbl9 = {
			Title = "Auto Secret Quest",
			Desc = "Auto complete Sea 1 secret quests",
			Default = Settings["Auto Secret Quest"] or false,
		}

		local function fn(arg)
			if arg and not EnforceGate(v6, "Auto Secret Quest", Place_Id.sea1(), "Only works in Sea 1") then
				return
			end
			SaveSettings("Auto Secret Quest", arg)

			if not arg then
				HiddenEvent.current = nil
				HiddenEvent.fighting = nil
				HiddenEvent.walking = false
				HiddenEvent.farmHeight = nil
				getgenv().AimPos = nil
				SetHiddenStep("Idle")
				pcall(LeaveHiddenCannon)
				pcall(HiddenRelease)
				pcall(StopHiddenDodge)
				pcall(require(ReplicatedStorage.DialogueController).close)
				pcall(TweenManager.CancelCurrent)

				task.spawn(function()
					task.wait(0.2)
					local character = localPlayer.Character
					local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
					if not humanoidRootPart then
						return
					end
					humanoidRootPart.Anchored = false
					humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					local raycastParams = RaycastParams.new()
					raycastParams.FilterType = Enum.RaycastFilterType.Exclude
					raycastParams.FilterDescendantsInstances = { character, workspace.Characters, workspace.Enemies }
					local hit = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -900, 0), raycastParams)

					if hit and humanoidRootPart.Position.Y - hit.Position.Y > 25 then
						humanoidRootPart.CFrame = CFrame.new(hit.Position + Vector3.new(0, 4, 0))
						task.wait(0.2)
						humanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					elseif not hit then
						local v7 = travelFunctions.GetSpawnPosition(localPlayer.Data.LastSpawnPoint.Value)

						if v7 then
							humanoidRootPart.CFrame = CFrame.new(v7 + Vector3.new(0, 4, 0))
						end
					end

					local n = 0

					while HiddenEvent.running and n < 5 do
						task.wait(0.1)
						n += 0.1
					end

					ReleaseTweenPhysics()
				end)

				return
			end

			if not Place_Id.sea1() then
				HiddenNotify("Hidden Event only works in First Sea", nil, "warning")
				return
			end

			if HiddenEvent.running then
				return
			end
			HiddenEvent.running = true

			task.spawn(function()
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
				end)
			end)

			task.spawn(HiddenDialogueLoop)

			task.spawn(function()
				while Settings["Auto Secret Quest"] and task.wait(0.15) do
					local ok, result

					if StackFarmOther then
						ok, result = pcall(AutoHiddenEvent)
					else
						SetHiddenStep("Paused while another feature is running")
						ok = true
						result = nil
					end

					if not ok then
						print(result)
						HiddenEvent.lastError = tostring(result)
						HiddenEvent.errors = (HiddenEvent.errors or 0) + 1

						if HiddenEvent.errors % 20 == 1 then
							HiddenNotify("Error: " .. tostring(result):sub(1, 120), "error", "error")
						end
					end

					pcall(CheckHiddenStall)
					local anchored = HiddenEvent.anchored

					if anchored then
						anchored = tick() - (HiddenEvent.holdTime or 0) > 0.6
					end

					if anchored then
						HiddenRelease()
					end

					local str2 = tostring(HiddenEvent.step or "")

					if str2:find("^Waiting") or str2:find(" stirs on ") or str2 == "Idle" then
						task.wait(0.6)
					end
				end

				HiddenRelease()
				HiddenEvent.running = false
			end)
		end

		v6 = createToggle
		v6 = v6(tbl9, fn)
	end

	end)
	if not sqOk then
		warn("[SecretQuest] failed to load: " .. tostring(sqErr))
	end
end
-- ===================== FIM SECRET QUEST =====================

-- ===================== HALLOWEEN (protegido com pcall) =====================
do
	local okHallow, errHallow = pcall(function()
		-- Pumpkin Hunt: estilo antigo (cursor virtual) + clique mobile (SendTouchEvent)
		local RunService = game:GetService("RunService")
		local VirtualInputManager = game:GetService("VirtualInputManager")
		local UserInputService = game:GetService("UserInputService")

		local state = { on = false, noclip = nil, cursorGui = nil, cursor = nil, skip = {}, current = nil, currentAt = 0 }
		local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

		local GRP_Halloween = t15.Halloween:AddLeftGroupbox("Pumpkin Hunt")
		GRP_Halloween:AddLabel("Auto Collect Pumpkin\nClique fixo no centro da tela. Alinhe a abobora/botao no meio. Mobile: toque sem forcar desktop.")

		local notify = function(msg)
			pcall(function()
				lib:Notify({ Title = "Halloween", Description = msg, Duration = 4 })
			end)
		end

		local showCursor = function()
			if state.cursorGui then
				state.cursorGui.Enabled = true
				return
			end
			local gui = Instance.new("ScreenGui")
			gui.Name = "ZyroxHalloweenCursor"
			gui.ResetOnSpawn = false
			gui.IgnoreGuiInset = true
			gui.DisplayOrder = 999
			pcall(function()
				if syn and syn.protect_gui then
					syn.protect_gui(gui)
				end
			end)
			gui.Parent = (gethui and gethui()) or game:GetService("CoreGui")

			-- marcador fixo no centro (nao arrasta)
			local cursor = Instance.new("Frame")
			cursor.Name = "VirtualCursor"
			cursor.AnchorPoint = Vector2.new(0.5, 0.5)
			cursor.Position = UDim2.fromScale(0.5, 0.5)
			cursor.Size = UDim2.fromOffset(28, 28)
			cursor.BackgroundColor3 = Color3.fromRGB(255, 160, 40)
			cursor.BackgroundTransparency = 0.35
			cursor.BorderSizePixel = 0
			cursor.ZIndex = 10
			cursor.Active = false
			cursor.Parent = gui
			Instance.new("UICorner", cursor).CornerRadius = UDim.new(1, 0)
			local stroke = Instance.new("UIStroke")
			stroke.Color = Color3.fromRGB(255, 255, 255)
			stroke.Thickness = 1.5
			stroke.Parent = cursor

			state.cursorGui, state.cursor = gui, cursor
		end

		local hideCursor = function()
			if state.cursorGui then
				state.cursorGui.Enabled = false
			end
		end

		local applyMovers = function(char)
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if not hrp or not hum then
				return nil
			end
			pcall(function()
				local bodyClip = hrp:FindFirstChild("BodyClip")
				if bodyClip then
					bodyClip:Destroy()
				end
			end)
			if not hrp:FindFirstChild("FarmBodyVelocity") then
				local velocity = Instance.new("BodyVelocity")
				velocity.Name = "FarmBodyVelocity"
				velocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
				velocity.Velocity = Vector3.zero
				velocity.Parent = hrp
			end
			if not hrp:FindFirstChild("FarmBodyGyro") then
				local gyro = Instance.new("BodyGyro")
				gyro.Name = "FarmBodyGyro"
				gyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
				gyro.P = 3000
				gyro.Parent = hrp
			end
			hum.PlatformStand = true
			return hrp
		end

		local clearMovers = function()
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hrp then
				for _, name in ipairs({ "FarmBodyVelocity", "FarmBodyGyro", "BodyClip" }) do
					local m = hrp:FindFirstChild(name)
					if m then
						m:Destroy()
					end
				end
			end
			if hum then
				hum.PlatformStand = false
			end
		end

		local nearestPumpkin = function(hrp)
			local folder = workspace:FindFirstChild("PumpkinHunt")
			if not folder then
				return nil, nil
			end
			local best, bestObj, bestDist = nil, nil, math.huge
			for _, obj in ipairs(folder:GetChildren()) do
				if obj:GetAttribute("Collected") or obj:GetAttribute("Taken") or state.skip[obj] then
					-- skip
				else
					local pos
					if obj:IsA("Model") then
						pos = obj.PrimaryPart and obj.PrimaryPart.Position
						if not pos then
							local ok, pivot = pcall(function()
								return obj:GetPivot().Position
							end)
							pos = ok and pivot or nil
						end
					elseif obj:IsA("BasePart") then
						pos = obj.Position
					end
					if pos then
						local dist = (pos - hrp.Position).Magnitude
						if dist < bestDist then
							best, bestObj, bestDist = pos, obj, dist
						end
					end
				end
			end
			return best, bestObj
		end

		-- tenta prompt/clickdetector da abobora (melhor que input fake)
		local tryInteract = function(obj)
			if not obj then
				return false
			end
			local ok = false
			pcall(function()
				for _, d in ipairs(obj:GetDescendants()) do
					if d:IsA("ProximityPrompt") then
						fireproximityprompt(d)
						ok = true
					elseif d:IsA("ClickDetector") then
						fireclickdetector(d)
						ok = true
					end
				end
			end)
			return ok
		end

		-- clique na posicao do cursor virtual
		-- mobile: NAO usa GetMouseLocation / mouse move (isso empurra desktop mode)
		-- 1) ProximityPrompt/ClickDetector  2) toque se o executor expuser  3) mouse button sem move
		local fireAtCursor = function()
			-- sempre no meio da tela (cursor travado)
			local cam = workspace.CurrentCamera
			local vp = cam and cam.ViewportSize or Vector2.new(0, 0)
			local x = vp.X / 2
			local y = vp.Y / 2
			-- se o marcador existir, usa o centro absoluto dele (deve ser o meio)
			local cursor = state.cursor
			if cursor then
				local c = cursor.AbsolutePosition + (cursor.AbsoluteSize / 2)
				x, y = c.X, c.Y
			end

			-- tentativa de touch nativo (alguns executors)
			local touched = false
			pcall(function()
				if (isMobile or UserInputService.TouchEnabled) and type(VirtualInputManager.SendTouchEvent) == "function" then
					VirtualInputManager:SendTouchEvent(1, 0, x, y) -- down
					task.wait(0.03)
					VirtualInputManager:SendTouchEvent(1, 1, x, y) -- up
					touched = true
				end
			end)
			if touched then
				return
			end

			-- fallback: so button down/up, sem SendMouseMoveEvent (evita desktop mode)
			pcall(function()
				VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1)
				task.wait(0.03)
				VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1)
			end)
		end

		local collectDist = 8

		local flyTo = function(hrp, goal)
			local speed = tonumber(getgenv().TweenSpeedFar) or 270
			local dist = (hrp.Position - goal.Position).Magnitude
			local time = math.max(dist / speed, 0.05)
			local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), { CFrame = goal })
			local done = false
			tween.Completed:Connect(function()
				done = true
			end)
			tween:Play()
			local started = tick()
			while not done and state.on and tick() - started < time + 2 do
				task.wait(0.05)
			end
			pcall(function()
				tween:Cancel()
			end)
		end

		local start = function()
			if state.on then
				return
			end
			if not workspace:FindFirstChild("PumpkinHunt") then
				notify("PumpkinHunt nao encontrado (evento ativo?). Tentando mesmo assim.")
			end
			state.on = true
			state.skip = {}
			showCursor()
			notify("Clique no centro da tela — alinhe o alvo no meio")

			pcall(function()
				local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
				if hrp and hrp:FindFirstChild("BodyClip") then
					hrp.BodyClip:Destroy()
				end
			end)

			state.noclip = RunService.Stepped:Connect(function()
				local char = plr.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)

			-- auto interact + toque no cursor (~8/s)
			task.spawn(function()
				while state.on do
					pcall(function()
						if state.current then
							tryInteract(state.current)
						end
						fireAtCursor()
					end)
					task.wait(0.12)
				end
			end)

			-- movimento ate abobora
			task.spawn(function()
				while state.on do
					pcall(function()
						local char = plr.Character
						local hrp = char and char:FindFirstChild("HumanoidRootPart")
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if not hrp or not hum then
							return
						end

						if state.current and not state.current:IsDescendantOf(workspace) then
							state.skip[state.current] = true
							state.current = nil
						end

						if state.current and tick() - (state.currentAt or 0) > 20 then
							state.skip[state.current] = true
							state.current = nil
						end

						local target, targetObj = nearestPumpkin(hrp)
						if not state.current and targetObj then
							state.current, state.currentAt = targetObj, tick()
						end
						if state.current then
							pcall(function()
								local obj = state.current
								if obj:IsA("Model") then
									target = (obj.PrimaryPart and obj.PrimaryPart.Position) or obj:GetPivot().Position
								elseif obj:IsA("BasePart") then
									target = obj.Position
								end
							end)
						end

						if not target then
							clearMovers()
							return
						end

						local dist = (hrp.Position - target).Magnitude
						if dist > collectDist then
							applyMovers(char)
							local goal = CFrame.new(target + Vector3.new(0, 3, 0))
							if _G.HalloweenTween then
								flyTo(hrp, goal)
							else
								hrp.CFrame = goal
							end
						else
							clearMovers()
							tryInteract(state.current)
						end
					end)
					task.wait(0.35)
				end
			end)
		end

		local stop = function()
			state.on = false
			if state.noclip then
				state.noclip:Disconnect()
				state.noclip = nil
			end
			hideCursor()
			pcall(clearMovers)
		end

		GRP_Halloween:AddToggle("Halloween_Tween_Pumpkin", {
			Text = "Tween Pumpkin",
			Tooltip = "Voa ate as aboboras (Tween Speed) em vez de TP",
			Default = false,
			Callback = function(value)
				_G.HalloweenTween = value
			end
		})

		GRP_Halloween:AddToggle("Auto_Collect_Pumpkin", {
			Text = "Auto Collect Pumpkin",
			Default = false,
			Callback = function(value)
				if value then
					start()
				else
					stop()
				end
			end
		})
	-- ===== [Akuma] Auto Trick or Treat =====
	-- Evento: portas em varias ilhas (minuto :00 a :10 de cada hora). Bate na porta, escolhe "Treat" no dialogo
	-- (Candy Corn) e segue para a proxima. Se a porta disparar uma luta, mata os inimigos novos e continua.
	do
		local trick = { on = false, noclip = nil, flying = false, visited = {}, doors = {}, scannedAt = 0, warned = false, useBig = true }
		local GRP_Trick = t15.Halloween:AddLeftGroupbox("Trick or Treat")
		GRP_Trick:AddLabel("Auto Trick or Treat\nBate nas portas, escolhe Treat no dialogo e vai para a proxima casa. O evento roda do minuto :00 ate :10 de cada hora.")

		local keywords = { "knock", "trick", "treat" }
		local matchText = function(text)
			text = string.lower(tostring(text or ""))
			for _, key in ipairs(keywords) do
				if string.find(text, key, 1, true) then
					return true
				end
			end
			return false
		end

		-- o prompt/detector ou ate 4 ancestrais tem nome de porta do evento
		local isDoorObject = function(inst)
			local node, depth = inst, 0
			while node and node ~= workspace and depth < 5 do
				if matchText(node.Name) then
					return true
				end
				local name = string.lower(node.Name)
				if string.find(name, "halloween", 1, true) and string.find(name, "door", 1, true) then
					return true
				end
				node = node.Parent
				depth = depth + 1
			end
			return false
		end

		local objectPart = function(inst)
			local node = inst.Parent
			while node and node ~= workspace do
				if node:IsA("BasePart") then
					return node
				end
				if node:IsA("Attachment") and node.Parent and node.Parent:IsA("BasePart") then
					return node.Parent
				end
				if node:IsA("Model") then
					return node.PrimaryPart or node:FindFirstChildWhichIsA("BasePart", true)
				end
				node = node.Parent
			end
			return nil
		end

		-- porta grande (HalloweenDoor2) x normal (HalloweenDoor)
		local isBigDoor = function(inst)
			local node, depth = inst, 0
			while node and node ~= workspace and depth < 6 do
				if string.find(string.lower(node.Name), "halloweendoor2", 1, true) then
					return true
				end
				node = node.Parent
				depth = depth + 1
			end
			return false
		end

		-- posicao real do prompt (nao do PrimaryPart do modelo, que em porta grande fica longe)
		local doorPos = function(door)
			local p = door.inst.Parent
			if p then
				if p:IsA("Attachment") then
					return p.WorldPosition
				end
				if p:IsA("BasePart") then
					return p.Position
				end
			end
			return door.part.Position
		end

		-- mensagem "It seems like nobody is home..." na tela
		local nobodyHome = function()
			local ok, res = pcall(function()
				local pg = plr:FindFirstChildOfClass("PlayerGui")
				if not pg then
					return false
				end
				for _, g in ipairs(pg:GetDescendants()) do
					if g:IsA("TextLabel") and g.Visible and g.Text ~= "" and g.TextTransparency < 0.9 then
						local low = string.lower(g.Text)
						if string.find(low, "nobody is home", 1, true) or string.find(low, "nobody's home", 1, true) then
							return true
						end
					end
				end
				return false
			end)
			return ok and res
		end

		local scanDoors = function(maxAge)
			if tick() - trick.scannedAt < (maxAge or 120) then
				return trick.doors
			end
			trick.scannedAt = tick()
			local list, count = {}, 0
			for _, inst in ipairs(workspace:GetDescendants()) do
				if inst:IsA("ProximityPrompt") or inst:IsA("ClickDetector") then
					local text = ""
					if inst:IsA("ProximityPrompt") then
						text = inst.ActionText .. " " .. inst.ObjectText
					end
					if matchText(text) or isDoorObject(inst) then
						local part = objectPart(inst)
						if part then
							table.insert(list, { inst = inst, part = part, big = isBigDoor(inst) })
						end
					end
				end
				count = count + 1
				if count % 4000 == 0 then
					task.wait()
				end
			end
			trick.doors = list
			return list
		end

		local goTo = function(goal)
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then
				return
			end
			local dist = (hrp.Position - goal.Position).Magnitude
			if dist <= 8 then
				return
			end
			trick.flying = true
			if _G.HalloweenTween or dist > 400 then
				-- distancias grandes sempre por tween (teleporte longo e arriscado)
				applyMovers(char)
				local speed = tonumber(getgenv().TweenSpeedFar) or 270
				local time = math.max(dist / speed, 0.05)
				local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), { CFrame = goal })
				local done = false
				tween.Completed:Connect(function()
					done = true
				end)
				tween:Play()
				local started = tick()
				while not done and trick.on and tick() - started < time + 3 do
					task.wait(0.05)
				end
				tween:Cancel()
				clearMovers()
			else
				hrp.CFrame = goal
			end
			trick.flying = false
		end

		local triggerDoor = function(door)
			local inst = door.inst
			if inst:IsA("ProximityPrompt") then
				local oldHold = inst.HoldDuration
				pcall(function()
					inst.RequiresLineOfSight = false
					inst.MaxActivationDistance = math.max(inst.MaxActivationDistance, 30)
				end)
				pcall(function()
					inst.HoldDuration = 0
				end)
				local fired = false
				if fireproximityprompt then
					fired = pcall(fireproximityprompt, inst)
				end
				if not fired then
					-- reserva: aperta a tecla do prompt
					pcall(function()
						local key = inst.KeyboardKeyCode
						if key == Enum.KeyCode.Unknown then
							key = Enum.KeyCode.E
						end
						VirtualInputManager:SendKeyEvent(true, key, false, game)
						task.wait(0.2)
						VirtualInputManager:SendKeyEvent(false, key, false, game)
					end)
				end
				pcall(function()
					inst.HoldDuration = oldHold
				end)
			elseif fireclickdetector then
				pcall(fireclickdetector, inst)
			end
		end

		local optionText = function(option)
			local text = option._text
			if type(text) == "table" then
				text = table.concat(text, " ")
			end
			return string.lower(tostring(text))
		end

		-- conversa com o NPC da porta: escolhe "Treat" e avanca ate o dialogo fechar
		local handleDialogue = function()
			local okReq, DC = pcall(function()
				return require(game:GetService("ReplicatedStorage"):WaitForChild("DialogueController", 3))
			end)
			if not okReq or not DC then
				return false
			end
			local prefer = { "treat", "yes", "ok", "thank", "knock" }
			local decline = { "no thanks", "cancel", "bye", "leave", "nevermind", "never mind", "not now" }
			local started, seen = tick(), false
			while trick.on and tick() - started < 20 do
				task.wait(0.35)
				if not DC.Active and not seen and nobodyHome() then
					pcall(DC.close)
					return false, true
				end
				if DC.Active then
					seen = true
					local ok, active = pcall(DC.getActiveDialogue)
					local page = ok and active and active._pageStack and active._pageStack[#active._pageStack]
					if page then
						local options = page._options or {}
						if #options == 0 then
							pcall(DC.advance)
						else
							local pick
							for _, word in ipairs(prefer) do
								for _, option in ipairs(options) do
									if string.find(optionText(option), word, 1, true) then
										pick = option
										break
									end
								end
								if pick then
									break
								end
							end
							if not pick then
								for _, option in ipairs(options) do
									local text, bad = optionText(option), false
									for _, word in ipairs(decline) do
										if string.find(text, word, 1, true) then
											bad = true
										end
									end
									if not bad then
										pick = option
										break
									end
								end
							end
							pcall(DC.select, pick or options[1])
						end
					end
				elseif seen or tick() - started > 6 then
					break
				end
			end
			pcall(DC.close)
			return seen, false
		end

		-- luta contra o que a porta invocar (so inimigos que nao estavam la antes)
		local fightNew = function(before)
			local previous = _G.HalloweenFarm
			local started = tick()
			_G.HalloweenFarm = true
			pcall(function()
				while trick.on and tick() - started < 30 do
					local char = plr.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					local enemies = workspace:FindFirstChild("Enemies")
					if not hrp or not enemies then
						break
					end
					local target, best = nil, 90
					for _, mob in ipairs(enemies:GetChildren()) do
						local root = mob:FindFirstChild("HumanoidRootPart")
						if root and not before[mob] and t9.Alive(mob) then
							local dist = (root.Position - hrp.Position).Magnitude
							if dist < best then
								target, best = mob, dist
							end
						end
					end
					if not target then
						break
					end
					t9.Kill(target, true)
					task.wait()
				end
			end)
			_G.HalloweenFarm = previous
		end

		local doorPartOf = function(inst)
			if not (inst:IsA("ProximityPrompt") or inst:IsA("ClickDetector")) then
				return nil
			end
			local text = ""
			if inst:IsA("ProximityPrompt") then
				text = inst.ActionText .. " " .. inst.ObjectText
			end
			if matchText(text) or isDoorObject(inst) then
				return objectPart(inst)
			end
			return nil
		end

		local startTrick = function()
			if trick.on then
				return
			end
			trick.on = true
			trick.warned = false
			trick.scannedAt = 0
			trick.conn = workspace.DescendantAdded:Connect(function(inst)
				task.defer(function()
					pcall(function()
						local part = doorPartOf(inst)
						if part then
							table.insert(trick.doors, { inst = inst, part = part, big = isBigDoor(inst) })
						end
					end)
				end)
			end)
			trick.visited = {}
			notify("Auto Trick or Treat ligado. Procurando portas do evento...")

			trick.noclip = RunService.Stepped:Connect(function()
				if not trick.flying then
					return
				end
				local char = plr.Character
				if char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)

			task.spawn(function()
				while trick.on do
					pcall(function()
						local char = plr.Character
						local hrp = char and char:FindFirstChild("HumanoidRootPart")
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if not hrp or not hum or hum.Health <= 0 then
							return
						end

						-- porta disponivel mais proxima (cada porta so de novo depois de 60s)
						local best, bestDist
						for _, door in ipairs(scanDoors(120)) do
							local inst, part = door.inst, door.part
							if inst.Parent and part.Parent then
								local enabled = true
								if inst:IsA("ProximityPrompt") then
									enabled = inst.Enabled
								end
								local last = trick.visited[inst]
								if enabled and (not door.big or trick.useBig) and (not last or tick() - last > 60) then
									local dist = (doorPos(door) - hrp.Position).Magnitude + (door.big and 300 or 0)
									if not bestDist or dist < bestDist then
										best, bestDist = door, dist
									end
								end
							end
						end

						if not best then
							if not trick.warned then
								trick.warned = true
								notify("Nenhuma porta disponivel agora. O evento roda de :00 a :10 de cada hora; fico procurando.")
							end
							scanDoors(20)
							task.wait(3)
							return
						end
						trick.warned = false

						local part = best.part
						local dpos = doorPos(best)
						local stand = dpos + Vector3.new(0, 1, 0)
						local away = (hrp.Position - dpos) * Vector3.new(1, 0, 1)
						if away.Magnitude > 1 then
							stand = stand + away.Unit * 4
						end
						local stay = CFrame.lookAt(stand, dpos)
						goTo(stay)
						hrp.CFrame = stay

						local before = {}
						local enemies = workspace:FindFirstChild("Enemies")
						if enemies then
							for _, mob in ipairs(enemies:GetChildren()) do
								before[mob] = true
							end
						end

						trick.visited[best.inst] = tick()

						-- fica parado em frente a porta ate o dialogo/evento terminar (sair cancela: "You walked away")
						local held = true
						task.spawn(function()
							local lastSnap = 0
							while held and trick.on do
								local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
								-- so corrige se foi empurrado longe (>20) e no maximo 1x a cada 2s; nao zera velocidade
								if root and (root.Position - stay.Position).Magnitude > 20 and tick() - lastSnap > 2 then
									lastSnap = tick()
									root.CFrame = stay
								end
								task.wait(0.25)
							end
						end)

						local talked, empty = false, false
						local waitT = tick()
						while nobodyHome() and tick() - waitT < 3 do
							task.wait(0.2) -- espera sumir a mensagem da porta anterior
						end
						for _ = 1, 2 do
							local okDC, DCm = pcall(function()
								return require(game:GetService("ReplicatedStorage"):WaitForChild("DialogueController", 3))
							end)
							if not (okDC and DCm and DCm.Active) then
								triggerDoor(best)
							end
							talked, empty = handleDialogue()
							if empty then
								break
							end
							if talked then
								break
							end
							task.wait(0.8)
						end
						if talked then
							task.wait(2.5) -- deixa o evento da porta terminar antes de ir para a proxima
						end
						held = false
						if not talked then
							trick.visited[best.inst] = tick() + (empty and 300 or 120)
							pcall(function()
								local i = best.inst
								local info = (best.big and "[GRANDE] " or "[normal] ") .. i.Parent.Name .. "/" .. (i.Parent.Parent and i.Parent.Parent.Name or "?")
								if i:IsA("ProximityPrompt") then
									info = info .. " | " .. i.ActionText .. " | hold=" .. i.HoldDuration .. " | dist=" .. i.MaxActivationDistance .. " | on=" .. tostring(i.Enabled)
								else
									info = info .. " | ClickDetector"
								end
								notify((empty and "Sem ninguem em casa: " or "Sem dialogo: ") .. info)
							end)
						else
							fightNew(before)
						end
						task.wait(talked and 1.5 or 0.3)
					end)
					task.wait(0.5)
				end
			end)
		end

		local stopTrick = function()
			trick.on = false
			trick.flying = false
			if trick.conn then
				trick.conn:Disconnect()
				trick.conn = nil
			end
			if trick.noclip then
				trick.noclip:Disconnect()
				trick.noclip = nil
			end
			pcall(clearMovers)
		end

		GRP_Trick:AddToggle("Trick_Include_Big_Doors", {
			Text = "Incluir portas grandes (HalloweenDoor2)",
			Tooltip = "Normais sempre primeiro. Desligue se as grandes derem erro.",
			Default = true,
			Callback = function(value)
				trick.useBig = value
			end
		})

		GRP_Trick:AddToggle("Auto_Trick_Or_Treat", {
			Text = "Auto Trick or Treat",
			Tooltip = "Bate nas portas do evento, escolhe Treat e repete em todas as casas",
			Default = false,
			Callback = function(value)
				if value then
					startTrick()
				else
					stopTrick()
				end
			end
		})

	end

	-- ===== Auto Farm Halloween Boss (Unbound Werewolf) =====
	-- Procura o boss "Unbound Werewolf", voa ate ele, fica acima da cabeca e ataca com cliques ate matar.
	do
		local boss = { on = false, noclip = nil, hover = nil, target = nil, prevFarm = nil, warned = false, height = 25 }
		local GRP_Boss = t15.Halloween:AddRightGroupbox("Halloween Boss")
		GRP_Boss:AddLabel("Auto Farm Halloween Boss\nProcura o Unbound Werewolf, fica acima da cabeca dele e ataca com cliques ate matar.")

		local VirtualUser = game:GetService("VirtualUser")
		local TweenService = game:GetService("TweenService")

		local isBossName = function(name)
			name = string.lower(tostring(name or ""))
			return string.find(name, "unbound werewolf", 1, true) or string.find(name, "unbound werewol", 1, true)
				or string.find(name, "werewolf", 1, true)
		end

		local bossAlive = function(model)
			if not model or not model.Parent then
				return false
			end
			local hum = model:FindFirstChildOfClass("Humanoid")
			local root = model:FindFirstChild("HumanoidRootPart")
			return hum ~= nil and root ~= nil and hum.Health > 0
		end

		local findBoss = function()
			local enemies = workspace:FindFirstChild("Enemies")
			if enemies then
				for _, mob in ipairs(enemies:GetChildren()) do
					if isBossName(mob.Name) and bossAlive(mob) then
						return mob
					end
				end
			end
			for _, mob in ipairs(workspace:GetChildren()) do
				if mob:IsA("Model") and isBossName(mob.Name) and bossAlive(mob) then
					return mob
				end
			end
			return nil
		end

		local flyTo = function(goal)
			local char = plr.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			if not hrp then
				return
			end
			local dist = (hrp.Position - goal.Position).Magnitude
			if dist <= 60 then
				return
			end
			applyMovers(char)
			local time = math.max(dist / (tonumber(getgenv().TweenSpeedFar) or 270), 0.05)
			local tween = TweenService:Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), { CFrame = goal })
			local done = false
			tween.Completed:Connect(function()
				done = true
			end)
			tween:Play()
			local started = tick()
			while not done and boss.on and tick() - started < time + 3 do
				task.wait(0.05)
			end
			tween:Cancel()
		end

		local click = function()
			pcall(function()
				VirtualUser:CaptureController()
				VirtualUser:Button1Down(Vector2.new(1280, 672))
				task.wait(0.05)
				VirtualUser:Button1Up(Vector2.new(1280, 672))
			end)
		end

		local startBoss = function()
			if boss.on then
				return
			end
			boss.on = true
			boss.warned = false
			boss.target = nil
			boss.prevFarm = _G.HalloweenFarm
			_G.HalloweenFarm = true -- libera o ataque rapido do hub enquanto farma
			notify("Auto Farm Halloween Boss ligado. Procurando o Unbound Werewolf...")

			-- noclip enquanto farma
			boss.noclip = RunService.Stepped:Connect(function()
				local char = plr.Character
				if boss.target and char then
					for _, part in ipairs(char:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = false
						end
					end
				end
			end)

			-- mantem o personagem acima da cabeca do boss a cada frame
			boss.hover = RunService.Heartbeat:Connect(function()
				local target = boss.target
				if not target or not bossAlive(target) then
					return
				end
				local char = plr.Character
				local hrp = char and char:FindFirstChild("HumanoidRootPart")
				if not hrp then
					return
				end
				local root = target.HumanoidRootPart
				local pos = root.Position + Vector3.new(0, tonumber(boss.height) or 25, 0)
				hrp.CFrame = CFrame.lookAt(pos, root.Position, Vector3.new(0, 0, 1))
				hrp.AssemblyLinearVelocity = Vector3.zero
			end)

			task.spawn(function()
				while boss.on do
					pcall(function()
						local char = plr.Character
						local hrp = char and char:FindFirstChild("HumanoidRootPart")
						local hum = char and char:FindFirstChildOfClass("Humanoid")
						if not hrp or not hum or hum.Health <= 0 then
							boss.target = nil
							task.wait(1)
							return
						end

						if not bossAlive(boss.target) then
							boss.target = findBoss()
						end
						local target = boss.target
						if not target then
							if not boss.warned then
								boss.warned = true
								notify("Unbound Werewolf nao encontrado. Fico procurando...")
							end
							task.wait(2)
							return
						end
						boss.warned = false

						local root = target.HumanoidRootPart
						local above = CFrame.new(root.Position + Vector3.new(0, tonumber(boss.height) or 25, 0))
						local prev = boss.target
						boss.target = nil -- pausa o hover durante o voo
						flyTo(above)
						boss.target = prev
						applyMovers(char)

						pcall(function()
							EquipWeapon(_G.SelectWeapon)
						end)
						click()
					end)
					task.wait(0.1)
				end
			end)
		end

		local stopBoss = function()
			boss.on = false
			boss.target = nil
			if boss.hover then
				boss.hover:Disconnect()
				boss.hover = nil
			end
			if boss.noclip then
				boss.noclip:Disconnect()
				boss.noclip = nil
			end
			_G.HalloweenFarm = boss.prevFarm
			pcall(clearMovers)
		end

		GRP_Boss:AddSlider({
			Text = "Altura acima do boss",
			Min = 8,
			Max = 50,
			Default = 25,
			Rounding = 0,
			Callback = function(value)
				boss.height = value
			end
		})

		GRP_Boss:AddToggle("Auto_Farm_Halloween_Boss", {
			Text = "Auto Farm Halloween Boss",
			Tooltip = "Procura o Unbound Werewolf, fica acima dele e ataca com cliques ate matar",
			Default = false,
			Callback = function(value)
				if value then
					startBoss()
				else
					stopBoss()
				end
			end
		})
	end
	end)
	if not okHallow then
		warn("[Zyrox] Halloween block failed: " .. tostring(errHallow))
	end
end
-- ===================== FIM HALLOWEEN =====================





GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Awakening", {
	Text = "Auto Awakening",
	Default = false,
	Callback = function(p308)
		_G.Auto_Awakener = p308
	end
})
spawn(function()
	while wait(Sec) do
		pcall(function()
			if _G.Auto_Awakener then
				ReplicatedStorage2.Remotes.CommF_:InvokeServer("Awakener", "Check")
				ReplicatedStorage2.Remotes.CommF_:InvokeServer("Awakener", "Awaken")
			end
		end)
	end
end)
GRP_Raids_Dungeon_Event_Raiding:AddToggle("Auto_Teleport_To_Lab", {
	Text = "Auto Teleport To Lab",
	Default = false,
	Callback = function(p309)
		_G.TpLab = p309

		while _G.TpLab do
			wait()

			if _G.TpLab then
				if World2 and _G.TpLab then
					_tp(CFrame.new(-6438.73535, 250.645355, -4501.50684))
				elseif World3 and _G.TpLab then
					_tp(CFrame.lookAt(Vector3.new(-5046, 314, -2960), Vector3.new(-5055, 314, -2957)))
				end
			end
		end
	end
})
GRP_Raids_Items_Law_Order_Sword = t15.Raids:AddLeftGroupbox("Items Law/Order Sword")
GRP_Raids_Items_Law_Order_Sword:AddButton({
	Text = "Buy Microchip Law",
	Func = function()
	end
})
GRP_Raids_Items_Law_Order_Sword:AddButton({
	Text = "Start Law Raids",
	Func = function()
	end
})
GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Buy_Microchip_Law", {
	Text = "Auto Buy Microchip Law",
	Default = false,
	Callback = function(p310)
		_G.AutoLawKak = p310
	end
})

do
	spawn(function()
		while task.wait(1) do
			if getgenv().AutoBuyMicrochipLaw then
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Microchip", "2")
				end)
			end
		end
	end)
end

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Start_Law_Raids", {
	Text = "Auto Start Law Raids",
	Default = false,
	Callback = function(p311)
		getgenv().AutoStartLawRaids = p311
	end
})

do
	spawn(function()
		while task.wait(1) do
			if getgenv().AutoStartLawRaids then
				pcall(function()
					fireclickdetector(workspace.Map.CircleIsland.RaidSummon.Button.Main.ClickDetector)
				end)
			end
		end
	end)
end

GRP_Raids_Items_Law_Order_Sword:AddToggle("Auto_Kill_Law", {
	Text = "Auto Kill Law",
	Default = false,
	Callback = function(p312)
		_G.AutoLawKak = p312
	end
})

do
	spawn(function()
		while wait(Sec) do
			if _G.AutoLawKak then
				pcall(function()
					local Order = GetConnectionEnemies("Order")

					if Order then
						while true do
							task.wait()
							t9.Kill(Order, _G.AutoLawKak)

							if _G.AutoLawKak == false then
								break
							elseif not Order.Parent or Order.Humanoid.Health <= 0 then
								break
							end
						end
					else
						_tp(CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875))
					end
				end)
			end
		end
	end)
end

GRP_Raids_Raids_Dungeons = t15.Raids:AddLeftGroupbox("Raids Dungeons")

local LocalPlayer2 = game.Players.LocalPlayer

do
	local function v1275()
		local Character = LocalPlayer2.Character

		return Character and Character:FindFirstChild("HumanoidRootPart")
	end

	GRP_Raids_Raids_Dungeons:AddToggle("Auto_Farm_Dungeon", {
		Text = "Auto Farm Dungeon",
		Default = false,
		Callback = function(p313)
			_G.AutoFarmDungeon = p313
		end
	})
	spawn(function()
		while task.wait(0.15) do
			if _G.AutoFarmDungeon then
				pcall(function()
					local Character = game.Players.LocalPlayer.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

					if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
						return
					end

					for _, child in pairs(workspace.Enemies:GetChildren()) do
						if not _G.AutoFarmDungeon then
							break
						end

						local Humanoid2 = child:FindFirstChild("Humanoid")
						local HumanoidRootPart2 = child:FindFirstChild("HumanoidRootPart")

						if Humanoid2 and HumanoidRootPart2 and Humanoid2.Health > 0 and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 5000 then
							while true do
								task.wait()
								t9.Kill(child, true)

								if not _G.AutoFarmDungeon then
									break
								elseif not child.Parent or Humanoid2.Health <= 0 then
									break
								end
							end
						end
					end
				end)
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(1)", {
		Text = "TP Exit (1)",
		Default = false,
		Callback = function(p314)
			_G.TPFloor1 = p314
		end
	})

	local u1284 = false

	local function v1285()
		local v1286 = v1275()

		if not v1286 then
			return
		end

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

			if ExitTeleporter and ExitTeleporter:FindFirstChild("Root") and (v1286.Position - ExitTeleporter.Root.Position).Magnitude < 200 then
				return ExitTeleporter.Root
			end
		end
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor1 then
				if not u1284 then
					local v1290 = v1285()

					if v1290 then
						local cFrame = v1290.CFrame * CFrame.new(0, 3, 0)

						v1275().CFrame = cFrame
						u1284 = true
					end
				end
			else
				u1284 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(2)", {
		Text = "TP Exit (2)",
		Default = false,
		Callback = function(p315)
			_G.TPFloor2 = p315
		end
	})

	local u1292 = false

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor2 then
				if not u1292 then
					local v1293 = v1275()

					if v1293 then
						for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
							local EntranceTeleporter = child:FindFirstChild("EntranceTeleporter")
							local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

							if EntranceTeleporter and ExitTeleporter and EntranceTeleporter:FindFirstChild("Root") and ExitTeleporter:FindFirstChild("Root") and (v1293.Position - EntranceTeleporter.Root.Position).Magnitude < 100 then
								v1293.CFrame = ExitTeleporter.Root.CFrame * CFrame.new(0, 3, 0)
								u1292 = true

								break
							end
						end
					end
				end
			else
				u1292 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(3)", {
		Text = "TP Exit (3)",
		Default = false,
		Callback = function(p316)
			_G.TPFloor3 = p316
		end
	})

	local u1298 = false

	local function v1299()
		local v1300

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local v1303 = tonumber(child.Name)

			if v1303 and (not v1300 or tonumber(v1300.Name) < v1303) then
				v1300 = child
			end
		end

		return v1300
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor3 then
				if not u1298 then
					local v1304 = v1299()

					if v1304 and v1304:FindFirstChild("ExitTeleporter") then
						if v1304.ExitTeleporter:FindFirstChild("Root") then
							v1275().CFrame = v1304.ExitTeleporter.Root.CFrame * CFrame.new(0, 3, 0)
							u1298 = true
						end
					end
				end
			else
				u1298 = false
			end
		end
	end)
	GRP_Raids_Raids_Dungeons:AddToggle("TP_Exit_(4)", {
		Text = "TP Exit (4)",
		Default = false,
		Callback = function(p317)
			_G.TPFloor4 = p317
		end
	})

	local u1305 = false

	local function v1306()
		local v1307 = v1275()

		if not v1307 then
			return
		end

		local Root_
		local huge = math.huge

		for _, child in pairs(workspace.Map.Dungeon:GetChildren()) do
			local ExitTeleporter = child:FindFirstChild("ExitTeleporter")

			if ExitTeleporter and ExitTeleporter:FindFirstChild("Root") then
				local Magnitude = (v1307.Position - ExitTeleporter.Root.Position).Magnitude

				if Magnitude < huge then
					huge = Magnitude
					Root_ = ExitTeleporter.Root
				end
			end
		end

		return Root_
	end

	task.spawn(function()
		while task.wait(0.3) do
			if _G.TPFloor4 then
				if not u1305 then
					local v1314 = v1306()

					if v1314 then
						v1275().CFrame = v1314.CFrame * CFrame.new(0, 3, 0)
						u1305 = true
					end
				end
			else
				u1305 = false
			end
		end
	end)
end

GRP_Combat_Combat_AimBot = t15.Combat:AddLeftGroupbox("Combat / AimBot")

do
	local v1315 = GRP_Combat_Combat_AimBot:AddLabel("")

	spawn(function()
		while wait(Sec) do
			pcall(function()
				local v1316 = #game:GetService("Players"):GetPlayers()

				if v1316 == 12 then
					v1315:SetText("All Players : " .. v1316 .. " / 12 [Max]")
				else
					v1315:SetText("All Players : " .. v1316 .. " / 12")
				end
			end)
		end
	end)
end

do
	local v1317 = GRP_Combat_Combat_AimBot:AddLabel("")

	Checking_AimStatus = function()
		if _G.AimCam then
			return "Aimbot Camera"
		end

		if _G.AimbotGun then
			return "Aimbot Guns"
		end

		return ""
	end
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if not _G.AimMethod then
					v1317:SetText("Aimbot - Skills : False")
				elseif _G.AimCam or _G.AimbotGun then
					v1317:SetText("Aimbot - " .. Checking_AimStatus() .. " : True")
				else
					v1317:SetText("Aimbot - Skills : True")
				end
			end)
		end
	end)
end

do
	local t47 = {}
	local Players2 = game:GetService("Players")

	for _, child in pairs(Players2:GetChildren()) do
		table.insert(t47, child.Name)
	end

	GRP_Combat_Combat_AimBot:AddDropdown("Select_Players", {
		Text = "Select Players",
		Values = t47,
		Default = 1,
		Callback = function(p318)
			_G.PlayersList = p318
		end
	})
end

do
	GRP_Combat_Combat_AimBot:AddToggle("Teleport_To_Select_Players", {
		Text = "Teleport To Select Players",
		Default = false,
		Callback = function(p319)
			_G.TpPly = p319
			spawn(function()
				pcall(function()
					while _G.TpPly do
						wait()
						_tp(game:GetService("Players")[_G.PlayersList].Character.HumanoidRootPart.CFrame)
					end
				end)
			end)
		end
	})
end

do
	GRP_Combat_Combat_AimBot:AddToggle("Spectate_Select_Players", {
		Text = "Spectate Select Players",
		Default = false,
		Callback = function(p320)
			SpectatePlys = p320
			spawn(function()
				repeat
					task.wait(0.1)

					if _G.PlayersList then
						if game:GetService("Players"):FindFirstChild(_G.PlayersList) then
							workspace.Camera.CameraSubject = game:GetService("Players"):FindFirstChild(_G.PlayersList).Character.Humanoid
						end
					end
				until not SpectatePlys

				workspace.Camera.CameraSubject = LocalPlayer2.Character.Humanoid
			end)
		end
	})
end

do
	GRP_Combat_Combat_AimBot:AddDropdown("Select_Aim_Method", {
		Text = "Select Aim Method",
		Values = {
			"Aim Player",
			"Nearest Aim"
		},
		Default = 1,
		Callback = function(p321)
			ABmethod = p321
		end
	})
end

GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Method_Skills", {
	Text = "Aimbot Method Skills",
	Default = false,
	Callback = function(p322)
		_G.AimMethod = p322
	end
})

do
	spawn(function()
		while wait() do
			pcall(function()
				if _G.AimMethod and ABmethod == "Aim Player" then
					local v1322 = Players:FindFirstChild(getgenv().PlayersList)

					if v1322 and v1322.Character then
						if v1322.Character:FindFirstChild("HumanoidRootPart") and v1322.Team ~= LocalPlayer2.Team then
							MousePos = v1322.Character.HumanoidRootPart.Position
						end
					end
				end
			end)
		end
	end)
end

spawn(function()
	while wait() do
		pcall(function()
			if _G.AimMethod and ABmethod == "Nearest Aim" then
				local huge = math.huge

				for _, player in pairs(Players:GetPlayers()) do
					if player ~= LocalPlayer2 and player.Team ~= LocalPlayer2.Team and player.Character then
						if player.Character:FindFirstChild("HumanoidRootPart") then
							local Magnitude = (player.Character.HumanoidRootPart.Position - LocalPlayer2.Character.HumanoidRootPart.Position).Magnitude

							if Magnitude < huge then
								huge = Magnitude
								MousePos = player.Character.HumanoidRootPart.Position
							end
						end
					end
				end
			end
		end)
	end
end)
GRP_Combat_Combat_AimBot:AddToggle("Aimbot_Camera_Closet_Players", {
	Text = "Aimbot Camera Closet Players",
	Default = false,
	Callback = function(p323)
		_G.AimCam = p323
	end
})
task.spawn(function()
	while task.wait(Sec) do
		pcall(function()
			if _G.AimCam then
				local CurrentCamera = workspace.CurrentCamera

				closestplayer = function()
					local huge = math.huge
					local v1329
					local players, v1331 = ply:GetPlayers()

					for _, v1 in next, players, v1331 do
						if v1 ~= LocalPlayer2 and v1.Character then
							if v1.Character:FindFirstChild("Head") and _G.AimCam and v1.Character.Humanoid.Health > 0 then
								local Magnitude = (v1.Character.Head.Position - LocalPlayer2.Character.Head.Position).Magnitude

								if Magnitude < huge then
									huge = Magnitude
									v1329 = v1
								end
							end
						end
					end

					return v1329
				end

				while true do
					task.wait()
					CurrentCamera.CFrame = CFrame.new(CurrentCamera.CFrame.Position, closestplayer().Character.HumanoidRootPart.Position)

					if _G.AimCam == false then
						break
					elseif dist < Mag then
						break
					end
				end
			end
		end)
	end
end)
GRP_Combat_Quests_Players = t15.Combat:AddLeftGroupbox("Quests Players")
GRP_Combat_Quests_Players:AddButton({
	Text = "Get player quests",
	Func = function()
	end
})

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Get_PlayerQuest", {
		Text = "Auto Get PlayerQuest",
		Default = false,
		Callback = function(p324)
			_G.AutoReceivePlayerQuest = p324
		end
	})
end

spawn(function()
	while task.wait(1) do
		if _G.AutoReceivePlayerQuest then
			pcall(function()
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
			end)
		end
	end
end)
GRP_Combat_Quests_Players:AddToggle("Auto_Kill_Player_Quest", {
	Text = "Auto Kill Player Quest",
	Default = false,
	Callback = function(p325)
		_G.AutoPlayerHunter = p325
	end
})

do
	spawn(function()
		while task.wait() do
			if _G.AutoPlayerHunter then
				if game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false then
					task.wait(0.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")
				else
					for _, child in pairs(game:GetService("Workspace").Characters:GetChildren()) do
						if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, child.Name) then
							repeat
								task.wait()

								if AutoHaki then
									AutoHaki()
								end

								if EquipWeapon then
									EquipWeapon(_G.SelectWeapon)
								end

								Useskill = true
								_tp(child.HumanoidRootPart.CFrame * CFrame.new(1, 7, 3))
								child.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
								game:GetService("VirtualUser"):CaptureController()
								game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
							until _G.AutoPlayerHunter == false or child.Humanoid.Health <= 0

							Useskill = false
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
						end
					end
				end
			end
		end
	end)
end

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Enable_PvP", {
		Text = "Auto Enable PvP",
		Default = false,
		Callback = function(p326)
			_G.AutoPvP = p326
		end
	})
end

spawn(function()
	while task.wait(0.5) do
		if _G.AutoPvP then
			local PlayerGui = game.Players.LocalPlayer.PlayerGui

			if PlayerGui and PlayerGui.Main then
				if PlayerGui.Main:FindFirstChild("PvpDisabled") and PlayerGui.Main.PvpDisabled.Visible then
					pcall(function()
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
					end)
				end
			end
		end
	end
end)

do
	GRP_Combat_Quests_Players:AddToggle("Auto_Safe_Mode", {
		Text = "Auto Safe Mode",
		Default = false,
		Callback = function(p327)
			_G.SafeMode = p327
		end
	})
end

spawn(function()
	while task.wait(0.1) do
		if _G.SafeMode then
			local Character = game.Players.LocalPlayer.Character
			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				_tp(HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0))
			end
		end
	end
end)
GRP_Combat_LocalPlayer_Settings = t15.Combat:AddLeftGroupbox("LocalPlayer Settings")

do
	local Players2 = game:GetService("Players")

	game:GetService("UserInputService")

	local RunService = game:GetService("RunService")
	local LocalPlayer3 = Players2.LocalPlayer
	local u1343 = false
	local n7 = 50
	local connection
	local t48 = {
		f = 0,
		b = 0,
		l = 0,
		r = 0
	}
	local BodyGyro
	local BodyVelocity

	local function v1349()
		local function v1350()
			local Character = LocalPlayer3.Character

			if not Character then
				return
			end

			local Humanoid = Character:FindFirstChildOfClass("Humanoid")

			if not Humanoid then
				return
			end

			local MoveDirection = Humanoid.MoveDirection

			t48.f = 0
			t48.b = 0
			t48.l = 0
			t48.r = 0

			if MoveDirection.Z < -0.1 then
				t48.f = 1
			elseif MoveDirection.Z > 0.1 then
				t48.b = 1
			end

			if MoveDirection.X < -0.1 then
				t48.l = 1
			elseif MoveDirection.X > 0.1 then
				t48.r = 1
			end
		end

		local connection2

		connection2 = RunService.Heartbeat:Connect(function()
			if u1343 then
				v1350()
			elseif connection2 then
				connection2:Disconnect()
			end
		end)
	end
	local function v1355(p328)
		u1343 = p328

		if u1343 then
			if not LocalPlayer3.Character then
				return
			end

			local Humanoid = LocalPlayer3.Character:FindFirstChildOfClass("Humanoid")
			local Torso

			if LocalPlayer3.Character:FindFirstChild("Torso") then
				Torso = LocalPlayer3.Character.Torso
			else
				Torso = LocalPlayer3.Character.UpperTorso
			end

			if not Humanoid or not Torso then
				return
			end

			for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
				if descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.Massless = true
				end
			end

			LocalPlayer3.Character.DescendantAdded:Connect(function(descendant)
				if u1343 and descendant:IsA("BasePart") then
					descendant.CanCollide = false
					descendant.Massless = true
				end
			end)
			BodyGyro = Instance.new("BodyGyro", Torso)
			BodyGyro.P = 90000
			BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
			BodyGyro.cframe = Torso.CFrame
			BodyVelocity = Instance.new("BodyVelocity", Torso)
			BodyVelocity.velocity = Vector3.new(0, 0, 0)
			BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
			Humanoid.PlatformStand = true
			v1349()
			connection = RunService.Heartbeat:Connect(function()
				if not u1343 or not LocalPlayer3.Character then
					return
				end

				for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
					if descendant:IsA("BasePart") and descendant.CanCollide then
						descendant.CanCollide = false
					end
				end

				if t48.l + t48.r == 0 and t48.f + t48.b == 0 then
					BodyVelocity.velocity = Vector3.new(0, 0, 0)
				else
					BodyVelocity.velocity = (workspace.CurrentCamera.CoordinateFrame.lookVector * (t48.f + t48.b) + (workspace.CurrentCamera.CoordinateFrame * CFrame.new(t48.l + t48.r, (t48.f + t48.b) * 0.2, 0).p - workspace.CurrentCamera.CoordinateFrame.p)) * n7
				end

				BodyGyro.cframe = workspace.CurrentCamera.CoordinateFrame
			end)
		else
			if connection then
				connection:Disconnect()
				connection = nil
			end

			if LocalPlayer3.Character then
				local Humanoid = LocalPlayer3.Character:FindFirstChildOfClass("Humanoid")

				if Humanoid then
					Humanoid.PlatformStand = false
				end

				for _, descendant in ipairs(LocalPlayer3.Character:GetDescendants()) do
					if descendant:IsA("BasePart") then
						descendant.CanCollide = true
						descendant.Massless = false
					end
				end

				if BodyGyro then
					BodyGyro:Destroy()
				end

				if BodyVelocity then
					BodyVelocity:Destroy()
				end
			end

			t48 = {
				f = 0,
				b = 0,
				l = 0,
				r = 0
			}
		end
	end
	local function v1365(p329)
		n7 = p329
	end

	GRP_Combat_LocalPlayer_Settings:AddToggle("Enable_Fly", {
		Text = "Enable Fly",
		Default = false,
		Callback = function(p330)
			v1355(p330)
		end
	})
	GRP_Combat_LocalPlayer_Settings:AddSlider({
		Text = "Speed Fly Mode",
		Min = 10,
		Max = 200,
		Default = 50,
		Rounding = 0,
		Callback = function(p331)
			v1365(p331)
		end
	})
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Dash_No_Cooldown", {
	Text = "Dash No Cooldown",
	Default = false,
	Callback = function(p332)
		getgenv().DodgeNoCD = p332
	end
})

do
	local function v1366()
		local Dodge = game.Players.LocalPlayer.Character:WaitForChild("Dodge")
		local v1368, v1369 = getgc()

		for _, v1 in next, v1368, v1369 do
			if typeof(v1) == "function" and getfenv(v1).script == Dodge then
				local next_ = next
				local v1373, v1374 = getupvalues(v1)

				for k, v2 in next_, v1373, v1374 do
					if tostring(v2) == "0.4" then
						setupvalue(v1, k, 0)
					end
				end
			end
		end
	end
end

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Mink_V3_[_INF_]", {
		Text = "Instance Mink V3 [ INF ]",
		Default = false,
		Callback = function(p333)
			InfAblities = p333
		end
	})
end

do
	spawn(function()
		while wait(0.2) do
			pcall(function()
				if not InfAblities then
					LocalPlayer2.Character.HumanoidRootPart.Agility:Destroy()
				elseif not LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("Agility") then
					local clone = ReplicatedStorage2.FX.Agility:Clone()

					clone.Name = "Agility"
					clone.Parent = LocalPlayer2.Character.HumanoidRootPart
				end
			end)
		end
	end)
end

GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Energy_[_INF_]", {
	Text = "Instance Energy [ INF ]",
	Default = false,
	Callback = function(p334)
		infEnergy = p334

		if p334 then
			getInfinity_Ability("Energy", infEnergy)
		end
	end
})
GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Soru_[_INF_]", {
	Text = "Instance Soru [ INF ]",
	Default = false,
	Callback = function(p335)
		_G.InfSoru = p335

		if p335 then
			getInfinity_Ability("Soru", _G.InfSoru)
		end
	end
})
GRP_Combat_LocalPlayer_Settings:AddToggle("Instance_Observation_Range_[_INF_]", {
	Text = "Instance Observation Range [ INF ]",
	Default = false,
	Callback = function(p336)
		_G.InfiniteObRange = p336

		if p336 then
			getInfinity_Ability("Observation", _G.InfiniteObRange)
		end
	end
})

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Ignore_Same_Teams", {
		Text = "Ignore Same Teams",
		Default = false,
		Callback = function(p337)
			_G.NoAimTeam = p337
		end
	})
end

do
	GRP_Combat_LocalPlayer_Settings:AddToggle("Accept_Allies", {
		Text = "Accept Allies",
		Default = false,
		Callback = function(p338)
			_G.AcceptAlly = p338
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.AcceptAlly then
				pcall(function()
					for _, child in pairs(ply:GetChildren()) do
						if child.Name ~= LocalPlayer2.Name and child:FindFirstChild("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
							ReplicatedStorage2:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("AcceptAlly", child.Name)
						end
					end
				end)
			end
		end
	end)
end

GRP_Travel_Travel_Worlds = t15.Travel:AddLeftGroupbox("Travel - Worlds")
GRP_Travel_Travel_Worlds:AddButton({
	Text = "Travel East Blue (World 1)",
	Func = function()
	end
})
GRP_Travel_Travel_Worlds:AddButton({
	Text = "Travel Dressrosa (World 2)",
	Func = function()
	end
})
GRP_Travel_Travel_Worlds:AddButton({
	Text = "Travel Zou (World 3)",
	Func = function()
	end
})
GRP_Travel_Travel_Island = t15.Travel:AddLeftGroupbox("Travel - Island")
Location = {}

for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
	table.insert(Location, child.Name)
end

do
	Travelllll = GRP_Travel_Travel_Island:AddDropdown("Select_Travelling", {
		Text = "Select Travelling",
		Values = Location,
		Default = 1,
		Callback = function(p339)
			_G.Island = p339
		end
	})
end

do
	GoIsland = GRP_Travel_Travel_Island:AddToggle("Auto_Travel", {
		Text = "Auto Travel",
		Default = false,
		Callback = function(p340)
			_G.Teleport = p340

			if p340 then
				for _, child in pairs(workspace._WorldOrigin.Locations:GetChildren()) do
					if child.Name == _G.Island then
						while true do
							wait()
							_tp(child.CFrame * CFrame.new(0, 30, 0))

							if not _G.Teleport then
								break
							elseif Root.CFrame == child.CFrame then
								break
							end
						end
					end
				end
			end
		end
	})
end

GRP_Travel_Travel_Portal = t15.Travel:AddLeftGroupbox("Travel - Portal")

if World1 then
	Location_Portal = {
		"Sky",
		"UnderWater"
	}
elseif World2 then
	Location_Portal = {
		"SwanRoom",
		"Cursed Ship"
	}
elseif World3 then
	Location_Portal = {
		"Castle On The Sea",
		"Mansion Cafe",
		"Hydra Teleport",
		"Canvendish Room",
		"Temple of Time"
	}
end

do
	PortalTP = GRP_Travel_Travel_Portal:AddDropdown("Select_Portal", {
		Text = "Select Portal",
		Values = Location_Portal,
		Default = 1,
		Callback = function(p341)
			_G.Island_PT = p341
		end
	})
end

GRP_Travel_Travel_Portal:AddButton({
	Text = "requestEntrance",
	Func = function()
	end
})
GRP_Travel_Travel_NPCs = t15.Travel:AddLeftGroupbox("Travel - NPCs")

for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
	table.insert(NPCList, child.Name)
end

NPCsPos = GRP_Travel_Travel_NPCs:AddDropdown("Select_NPCs", {
	Text = "Select NPCs",
	Values = NPCList,
	Default = 1,
	Callback = function(p342)
		_G.TPNpc = p342
	end
})

do
	GoNPCs = GRP_Travel_Travel_NPCs:AddToggle("Auto_Tween_to_NPC", {
		Text = "Auto Tween to NPC",
		Default = false,
		Callback = function(p343)
			_G.TPNpc = p343
		end
	})
end

do
	spawn(function()
		while wait(Sec) do
			if _G.TPNpc then
				pcall(function()
					for _, child in pairs(ReplicatedStorage2.NPCs:GetChildren()) do
						if child.Name == NPClist then
							_tp(child.HumanoidRootPart.CFrame)
						end
					end
				end)
			end
		end
	end)
end

GRP_Shop_Shop_Options = t15.Shop:AddLeftGroupbox("Shop Options")
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Buso",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
	end
})
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Geppo",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
	end
})
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Soru",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
	end
})
GRP_Shop_Shop_Options:AddButton({
	Text = "Buy Ken",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
	end
})
GRP_Shop_Fighting_Style = t15.Shop:AddLeftGroupbox("Fighting - Style")

-- Fighting Shop (igual ao Vxeze): cada toggle vai ate o NPC e compra o estilo ao chegar a menos de 8 studs
do
	local localPlayer = plr
	local CommF = replicated.Remotes.CommF_
	local okNPC, NPCManager = pcall(function()
		return require(game:GetService("ReplicatedStorage").NPCManager)
	end)

	local DetectNpc
	DetectNpc = function(n)local L= localPlayer .Character and( localPlayer .Character:FindFirstChild("HumanoidRootPart"));if not L then return;end;local c,U,w,y=next,{workspace.NPCs,game:GetService("ReplicatedStorage").NPCs},1/0;for S,S in c,U,nil do local c,U,K=next,S:GetChildren();for S,R in c,U,K do if R:GetAttribute("NPCLoaded")and(R:GetAttribute("NPCReady"))and R.Name==n and(R:FindFirstChild("HumanoidRootPart"))then S=(L.Position-R.HumanoidRootPart.Position).Magnitude;if S<w then w,y=S,R;end;end;end;end;if not y then L=NPCManager.getNPCsByName(n)[1];return L and L._modelState and L._modelState._instance;end;return y,w;end

	-- { titulo, NPC, chamadas ao remote, intervalo do loop }
	local styles = {
		{ "Black Leg", "Dark Step Teacher", { { "BuyBlackLeg" } }, 0 },
		{ "Fishman Karate", "Water Kung-fu Teacher", { { "BuyFishmanKarate" } }, 0 },
		{ "Electro", "Mad Scientist", { { "BuyElectro" } }, 0.1 },
		{ "Dragon Breath", "Sabi", { { "BlackbeardReward", "DragonClaw", "1" }, { "BlackbeardReward", "DragonClaw", "2" } }, 0.1 },
		{ "SuperHuman", "Martial Arts Master", { { "BuySuperhuman" } }, 0.1 },
		{ "Death Step", "Phoeyu, the Reformed", { { "BuyDeathStep" } }, 0 },
		{ "Sharkman Karate", "Sharkman Teacher", { { "BuySharkmanKarate" } }, 0 },
		{ "Electric Claw", "Previous Hero", { { "BuyElectricClaw" } }, 0 },
		{ "Dragon Talon", "Uzoth", { { "BuyDragonTalon" } }, 0 },
		{ "God Human", "Ancient Monk", { { "BuyGodhuman" } }, 0 },
		{ "Sanguine Art", "Shafi", { { "BuySanguineArt" } }, 0 },
	}

	local notsave, running, lastWarn = {}, {}, {}

	for _, style in ipairs(styles) do
		local title, npcName, calls, interval = style[1], style[2], style[3], style[4]
		local id = "Buy_Style_" .. (title:gsub("%W", "_"))

		GRP_Shop_Fighting_Style:AddToggle(id, {
			Text = title,
			Default = false,
			Callback = function(v)
				notsave[title] = v
				local anyOn = false
				for _, on in pairs(notsave) do
					if on then
						anyOn = true
						break
					end
				end
				_G.FightShopActive = anyOn -- libera o _tp e o noclip do Zyrox (shouldTween)
				if v and not running[title] then
					running[title] = true
					task.spawn(function()
						while notsave[title] and task.wait(interval) do
							local ok, err = pcall(function()
								local npc = DetectNpc(npcName)
								if not npc or not npc:FindFirstChild("HumanoidRootPart") then
									return
								end
								if localPlayer:DistanceFromCharacter(npc.HumanoidRootPart.Position) < 8 then
									for _, args in ipairs(calls) do
										CommF:InvokeServer(table.unpack(args))
									end
								end
								_tp(npc.HumanoidRootPart.CFrame * CFrame.new(0, 4, 4))
							end)
							if not ok and tick() - (lastWarn[title] or 0) > 10 then
								lastWarn[title] = tick()
								warn("[FightingShop] " .. title .. ": " .. tostring(err))
							end
						end
						running[title] = nil
					end)
				end
			end,
		})
	end
end

GRP_Shop_Accessory = t15.Shop:AddLeftGroupbox("Accessory")

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Tomoe Ring",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Tomoe Ring")
		end
	})
end

GRP_Shop_Accessory:AddButton({
	Text = "Buy Black Cape",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Black Cape")
	end
})

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Swordsman Hat",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Swordsman Hat")
		end
	})
end

do
	GRP_Shop_Accessory:AddButton({
		Text = "Buy Bizarre Rifle",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 1)
		end
	})
end

GRP_Shop_Accessory:AddButton({
	Text = "Buy Ghoul Mask",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", "Buy", 2)
	end
})
GRP_Shop_Weapon_World1 = t15.Shop:AddLeftGroupbox("Weapon World1")
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Cutlass",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Cutlass")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Katana",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Katana")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Iron Mace",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Iron Mace")
	end
})
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Duel Katana",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Duel Katana")
	end
})
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Triple Katana",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Triple Katana")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Pipe",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Pipe")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Dual-Headed Blade",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Dual-Headed Blade")
	end
})
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Bisento",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Bisento")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Soul Cane",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Soul Cane")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Slingshot",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Slingshot")
	end
})
GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Musket",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Musket")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Dual Flintlock",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Flintlock",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Flintlock")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Refined Flintlock",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Refined Flintlock")
		end
	})
end

GRP_Shop_Weapon_World1:AddButton({
	Text = "Buy Cannon",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BuyItem", "Cannon")
	end
})

do
	GRP_Shop_Weapon_World1:AddButton({
		Text = "Buy Kabucha",
		Func = function()
			ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Slingshot", "2")
		end
	})
end

GRP_Shop_Fragments_shop = t15.Shop:AddLeftGroupbox("Fragments shop")
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Refund Stats",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
	end
})
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Reroll Race",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
	end
})
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Ghoul Race",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("Ectoplasm", " Change", 4)
	end
})
GRP_Shop_Fragments_shop:AddButton({
	Text = "Buy Cyborg Race (2.5k)",
	Func = function()
		ReplicatedStorage2.Remotes.CommF_:InvokeServer("CyborgTrainer", " Buy")
	end
})

do
	GRP_Shop_Fragments_shop:AddButton({
		Text = "Buy Draco Race",
		Func = function()
			task.spawn(function()
				_tp(CFrame.new(5814.42724609375, 1208.3267822265625, 884.57855224609375))

				local vector3 = Vector3.new(5814.42724609375, 1208.3267822265625, 884.57855224609375)

				while true do
					task.wait()

					if not LocalPlayer2.Character then
						continue
					end

					if LocalPlayer2.Character.HumanoidRootPart and (LocalPlayer2.Character.HumanoidRootPart.Position - vector3).Magnitude < 1 then
						break
					end
				end

				ReplicatedStorage2.Modules.Net:FindFirstChild("RF/InteractDragonQuest"):InvokeServer(unpack({ {
					NPC = "Dragon Wizard",
					Command = "DragonRace"
				} }))
			end)
		end
	})
end

GRP_Misc_Server_Function = t15.Misc:AddLeftGroupbox("Server - Function")

-- ===== Redeem All Codes (logica do Vxeze: acompanha o que ja foi resgatado e filtra por tamanho) =====
do
	local HttpService = game:GetService("HttpService")
	local busy = false
	local file = "ZyroxHub_RedeemedCodes.json"
	local staticCodes = {
		"LIGHTNINGABUSE",
		"1LOSTADMIN",
		"ADMINFIGHT",
		"GIFTING_HOURS",
		"NOMOREHACK",
		"BANEXPLOIT",
		"WildDares",
		"BossBuild",
		"GetPranked",
		"EARN_FRUITS",
		"SUB2GAMERROBOT_RESET1",
		"KITT_RESET",
		"Bignews",
		"CHANDLER",
		"Fudd10",
		"fudd10_v2",
		"Sub2UncleKizaru",
		"FIGHT4FRUIT",
		"kittgaming",
		"TRIPLEABUSE",
		"Sub2CaptainMaui",
		"Sub2Fer999",
		"Enyu_is_Pro",
		"Magicbus",
		"JCWK",
		"Starcodeheo",
		"Bluxxy",
		"SUB2GAMERROBOT_EXP1",
		"Sub2NoobMaster123",
		"Sub2Daigrock",
		"Axiore",
		"TantaiGaming",
		"StrawHatMaine",
		"Sub2OfficialNoobie",
		"TheGreatAce",
		"JULYUPDATE_RESET",
		"ADMINHACKED",
		"SEATROLLING",
		"24NOADMIN",
		"ADMIN_TROLL",
		"NEWTROLL",
		"SECRET_ADMIN",
		"staffbattle",
		"NOEXPLOIT",
		"NOOB2ADMIN",
		"CODESLIDE",
		"fruitconcepts",
		"krazydares"
	}

	local notify = function(msg)
		pcall(function()
			lib:Notify({ Title = "Redeem Code", Description = msg, Duration = 4 })
		end)
	end

	local loadDone = function()
		local ok, result = pcall(function()
			return HttpService:JSONDecode(readfile(file))
		end)
		return ok and type(result) == "table" and result or {}
	end

	local saveDone = function(tbl)
		pcall(function()
			writefile(file, HttpService:JSONEncode(tbl))
		end)
	end

	-- codigos novos da wiki (mesmo parser do Vxeze: <code>CODIGO</code>)
	local fetchWiki = function()
		local out = {}
		pcall(function()
			local body = HttpService:JSONDecode(game:HttpGet("https://blox-fruits.fandom.com/api.php?action=parse&page=Codes&prop=wikitext&format=json"))
			for match in body.parse.wikitext["*"]:gmatch("<code>([A-Za-z0-9_]+)</code>") do
				table.insert(out, match)
			end
		end)
		return out
	end

	local redeemAll = function()
		if busy then
			notify("Already redeeming, please wait")
			return
		end
		busy = true

		task.spawn(function()
			local ok, err = pcall(function()
				notify("Fetching the latest codes")
				local seen, codes = {}, {}
				for _, source in ipairs({ staticCodes, fetchWiki() }) do
					for _, code in ipairs(source) do
						if not seen[code:lower()] then
							seen[code:lower()] = true
							table.insert(codes, code)
						end
					end
				end

				local redeem = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("Redeem")
				if not redeem then
					notify("Redeem remote not found")
					return
				end

				local done = loadDone()
				local needLen, tried, worked = nil, 0, 0

				for _, code in ipairs(codes) do
					if needLen and #code ~= needLen then
						done[code] = true
					elseif not done[code] then
						tried = tried + 1
						local okc, result = pcall(function()
							return redeem:InvokeServer(code)
						end)

						if okc then
							local str = tostring(result):lower()
							local exact = str:match("exactly (%d+)")
							if exact then
								needLen = tonumber(exact)
								tried = tried - 1
								done[code] = true
							else
								done[code] = true
								if str:find("success") or str:find("redeemed") or str:find("reward") then
									worked = worked + 1
								end
							end
						end
						task.wait()
					end
				end

				saveDone(done)

				if worked > 0 then
					notify("Redeemed " .. worked .. " new codes")
				elseif tried == 0 then
					notify("No new codes to redeem")
				else
					notify("Checked " .. tried .. " codes, none were valid")
				end
			end)

			busy = false
			if not ok then
				notify("Failed: " .. tostring(err))
			end
		end)
	end

	GRP_Misc_Server_Function:AddButton({
		Text = "Redeem All Codes",
		Func = redeemAll
	})
end

local ReplicatedStorage3 = game:GetService("ReplicatedStorage")

-- ===== Servidores (logica do Vxeze: PickServer / HopTo / JoinServer, sem repetir servidor da ultima hora) =====
do
	local HttpService = game:GetService("HttpService")
	local TeleportService_ = game:GetService("TeleportService")
	local ServerBrowser = { list = {}, time = 0, busy = false, visited = {}, lastHop = 0, file = "ZyroxHub_Visited.json" }

	local notify = function(msg)
		pcall(function()
			lib:Notify({ Title = "Server", Description = msg, Duration = 4 })
		end)
	end

	pcall(function()
		local result = HttpService:JSONDecode(readfile(ServerBrowser.file))
		if type(result) == "table" then
			local now = os.time()
			for k, v in pairs(result) do
				if type(v) == "number" and now - v < 3600 then
					ServerBrowser.visited[k] = v
				end
			end
		end
	end)

	local saveVisited = function()
		pcall(function()
			writefile(ServerBrowser.file, HttpService:JSONEncode(ServerBrowser.visited))
		end)
	end

	local fetchServers = function(maxAge)
		if ServerBrowser.busy then
			repeat
				task.wait(0.1)
			until not ServerBrowser.busy
			return ServerBrowser.list
		end
		if #ServerBrowser.list > 0 and tick() - ServerBrowser.time < (maxAge or 30) then
			return ServerBrowser.list
		end

		ServerBrowser.busy = true
		local list, cursor = {}, nil
		pcall(function()
			for _ = 1, 3 do
				local url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100" .. (cursor and ("&cursor=" .. cursor) or "")
				local body = HttpService:JSONDecode(game:HttpGet(url))
				for _, server in ipairs(body.data or {}) do
					table.insert(list, {
						Job = server.id,
						Count = tonumber(server.playing) or 0,
						Max = tonumber(server.maxPlayers) or game.Players.MaxPlayers,
						Ping = tonumber(server.ping) or 9999,
					})
				end
				cursor = body.nextPageCursor
				if not cursor then
					break
				end
			end
		end)
		ServerBrowser.list = list
		ServerBrowser.time = tick()
		ServerBrowser.busy = false
		return list
	end

	local joinServer = function(job, msg)
		if type(job) ~= "string" or job == "" or job == game.JobId then
			return false
		end
		ServerBrowser.visited[job] = os.time()
		saveVisited()
		notify(msg or ("Joining " .. job:sub(1, 8)))
		return (pcall(function()
			TeleportService_:TeleportToPlaceInstance(game.PlaceId, job, LocalPlayer2)
		end))
	end

	local pickServer = function(mode)
		local candidates = {}
		for _, server in ipairs(fetchServers(30)) do
			if server.Job ~= game.JobId and not ServerBrowser.visited[server.Job] and server.Count > 0 and server.Count < server.Max then
				table.insert(candidates, server)
			end
		end
		if #candidates == 0 then
			return nil
		end
		if mode == "less" then
			table.sort(candidates, function(a, b)
				return a.Count < b.Count
			end)
			return candidates[math.random(1, math.min(5, #candidates))].Job
		elseif mode == "ping" then
			table.sort(candidates, function(a, b)
				return a.Ping < b.Ping
			end)
			return candidates[math.random(1, math.min(5, #candidates))].Job
		end
		return candidates[math.random(1, #candidates)].Job
	end

	local hopTo = function(mode, msg)
		if tick() - ServerBrowser.lastHop < 12 then
			return false
		end
		ServerBrowser.lastHop = tick()
		for _ = 1, 3 do
			local job = pickServer(mode)
			if not job then
				notify("No server to hop to right now")
				return false
			end
			joinServer(job, msg)
			local startedAt = tick()
			repeat
				task.wait(1)
			until tick() - startedAt > 15
		end
		return false
	end

	GRP_Misc_Server_Function:AddButton({
		Text = "Rejoin Server",
		Func = function()
			notify("Rejoining this server")
			pcall(function()
				TeleportService_:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer2)
			end)
		end
	})

	GRP_Misc_Server_Function:AddButton({
		Text = "Hop Server",
		Func = function()
			task.spawn(hopTo, "random", "Hopping to a new server")
		end
	})

	GRP_Misc_Server_Function:AddButton({
		Text = "Hop to Lowest Players",
		Func = function()
			task.spawn(hopTo, "less", "Hopping to a server with few players")
		end
	})

	GRP_Misc_Server_Function:AddButton({
		Text = "Hop to Lowest Pings Server",
		Func = function()
			task.spawn(hopTo, "ping", "Hopping to a low ping server")
		end
	})

	GRP_Misc_Server_Function:AddInput("Input_Job_Id", {
		Text = "Input Job Id",
		Default = "",
		Placeholder = "Job ID",
		Callback = function(p347)
			_G.JobIdInput = p347 -- antes usava _G.Rechat, que o toggle do chat sobrescrevia
		end
	})

	GRP_Misc_Server_Function:AddButton({
		Text = "Teleport [Job ID]",
		Func = function()
			if type(_G.JobIdInput) == "string" and _G.JobIdInput ~= "" then
				pcall(function()
					TeleportService_:TeleportToPlaceInstance(game.PlaceId, _G.JobIdInput, LocalPlayer2)
				end)
			end
		end
	})
end

GRP_Misc_Server_Function:AddButton({
	Text = "Copy JobID",
	Func = function()
		setclipboard(tostring(game.JobId))
	end
})
GRP_Misc_Player_Gui_Others = t15.Misc:AddLeftGroupbox("Player Gui / Others")
-- Abre uma janela do jogo dentro de PlayerGui.Main (busca segura, como no arquivo TSUO) e esconde o menu do hub,
-- que ficava por cima e cobria a janela aberta.
ZyroxOpenMainGui = function(names, label, beforeOpen)
	local main = LocalPlayer2:FindFirstChild("PlayerGui") and LocalPlayer2.PlayerGui:FindFirstChild("Main")
	local gui

	if main then
		for _, name in ipairs(names) do
			gui = main:FindFirstChild(name) or main:FindFirstChild(name, true)
			if gui then
				break
			end
		end
	end

	if not gui then
		pcall(function()
			lib:Notify({ Title = label, Description = "janela nao encontrada em PlayerGui.Main (" .. table.concat(names, " / ") .. ")", Duration = 5 })
		end)
		return
	end

	if beforeOpen then
		local ok, err = pcall(beforeOpen)
		if not ok then
			warn("[" .. label .. "] " .. tostring(err))
		end
	end

	-- garante que os pais tambem estao visiveis e abre a janela
	local node = gui
	while node and node ~= main.Parent do
		if node:IsA("GuiObject") then
			node.Visible = true
		elseif node:IsA("ScreenGui") then
			node.Enabled = true
		end
		node = node.Parent
	end

	if lib.HideUI then
		lib.HideUI()
	end
end

GRP_Misc_Player_Gui_Others:AddButton({
	Text = "Open Awakenings Expert",
	Func = function()
		ZyroxOpenMainGui({ "AwakeningToggler", "Awakening", "AwakeningExpert" }, "Awakenings")
	end
})

do
	GRP_Misc_Player_Gui_Others:AddButton({
		Text = "Open Title Selection",
		Func = function()
			ZyroxOpenMainGui({ "Titles" }, "Titles", function()
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("getTitles", true)
			end)
		end
	})
end

DisbleChat = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Chat_GUI", {
	Text = "Disable Chat GUI",
	Default = false,
	Callback = function(p348)
		_G.DisableChatGui = p348
		game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Chat, not p348)
	end
})
DisbleLeaderB = GRP_Misc_Player_Gui_Others:AddToggle("Disable_Leader_Board_GUI", {
	Text = "Disable Leader Board GUI",
	Default = false,
	Callback = function(p349)
		ReLeader = p349

		if ReLeader == true then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
		elseif ReLeader == false then
			game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, true)
		end
	end
})

do
	GRP_Misc_Player_Gui_Others:AddButton({
		Text = "Set Pirate Team",
		Func = function()
			ReplicatedStorage3.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
		end
	})
end

GRP_Misc_Player_Gui_Others:AddButton({
	Text = "Set Marine Team",
	Func = function()
		ReplicatedStorage3.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
	end
})
UnPortal = GRP_Misc_Player_Gui_Others:AddToggle("Unlock_All_Portals", {
	Text = "Unlock All Portals",
	Default = false,
	Callback = function(p350)
		_G.PortalUnLock = p350
	end
})

-- Pads de portal (dados do GatewayPads do Vxeze). Ao ficar a menos de 8 studs de um pad, pede a entrada.
do
	local pads = {
		{ Stand = Vector3.new(4050, 6, -1815), Dest = Vector3.new(61163.85, 11.6796875, 1819.7842) },
		{ Stand = Vector3.new(61170, 1, 1952), Dest = Vector3.new(3864.6885, 6.74402, -1926.2141) },
		{ Stand = Vector3.new(-6499, 91, -127), Dest = Vector3.new(923, 126, 32852) },
		{ Stand = Vector3.new(920, 155, 32838), Dest = Vector3.new(-6509, 89, -133) },
		{ Stand = Vector3.new(-5060.4116, 318.502, -3193.2249), Dest = Vector3.new(-12463.603, 378.32706, -7566.083) },
		{ Stand = Vector3.new(-12463.603, 378.32706, -7566.083), Dest = Vector3.new(-5060.4116, 318.502, -3193.2249) },
		{ Stand = Vector3.new(-5027.0303, 318.502, -3206.7036), Dest = Vector3.new(5650.9478, 1017.2748, -350.37918) },
		{ Stand = Vector3.new(5650.9478, 1017.2748, -350.37918), Dest = Vector3.new(-5027.0303, 318.502, -3206.7036) },
		{ Part = "WaterfallBossHitbox", Arg = "WaterfallBossHitbox" },
		{ Part = "TurtleEntranceBoss", Arg = "TurtleEntranceBoss" },
	}
	local partCache = {}
	local lastFire = 0
	local locked = false

	local padPosition = function(pad)
		if pad.Stand then
			return pad.Stand
		end
		local part = partCache[pad.Part]
		if not (part and part.Parent) then
			part = workspace:FindFirstChild(pad.Part, true)
			partCache[pad.Part] = part
		end
		if part then
			return part:IsA("BasePart") and part.Position or part:GetPivot().Position
		end
	end

	spawn(function()
		while wait(Sec) do
			if _G.PortalUnLock then
				pcall(function()
					local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
					if not root then
						return
					end

					local nearest, nearestPad = math.huge, nil
					for _, pad in ipairs(pads) do
						local pos = padPosition(pad)
						if pos then
							local d = (root.Position - pos).Magnitude
							if d < nearest then
								nearest, nearestPad = d, pad
							end
						end
					end

					-- evita ir e voltar: so libera de novo depois de sair de perto dos pads
					if locked then
						if nearest > 20 then
							locked = false
						end
						return
					end

					if nearestPad and nearest < 8 and tick() - lastFire > 1 then
						lastFire = tick()
						locked = true
						replicated.Remotes.CommF_:InvokeServer("requestEntrance", nearestPad.Arg or nearestPad.Dest)
					end
				end)
			end
		end
	end)
end
GRP_Misc_Graphics_Haki_Stats = t15.Misc:AddLeftGroupbox("Graphics / Haki Stats")

-- ===== FPS Counter (FPS + ping na tela) =====
do
	local RunService = game:GetService("RunService")
	local Stats = game:GetService("Stats")
	local fpsGui, fpsLabel, fpsConn
	local fpsRunning = false

	local fpsParent = function()
		local ok, holder = pcall(function()
			return (gethui and gethui()) or game:GetService("CoreGui")
		end)
		if ok and holder then
			return holder
		end
		return plr:WaitForChild("PlayerGui")
	end

	local fpsStop = function()
		fpsRunning = false
		if fpsConn then
			fpsConn:Disconnect()
			fpsConn = nil
		end
		if fpsGui then
			fpsGui:Destroy()
			fpsGui, fpsLabel = nil, nil
		end
	end

	local fpsStart = function()
		if fpsRunning then
			return
		end
		fpsRunning = true

		fpsGui = Instance.new("ScreenGui")
		fpsGui.Name = "ZyroxFpsCounter"
		fpsGui.ResetOnSpawn = false
		fpsGui.IgnoreGuiInset = true
		fpsGui.DisplayOrder = 999
		pcall(function()
			if syn and syn.protect_gui then
				syn.protect_gui(fpsGui)
			end
		end)
		fpsGui.Parent = fpsParent()

		fpsLabel = Instance.new("TextLabel")
		fpsLabel.Name = "Label"
		fpsLabel.AnchorPoint = Vector2.new(1, 0)
		fpsLabel.Position = UDim2.new(1, -12, 0, 12)
		fpsLabel.Size = UDim2.new(0, 150, 0, 26)
		fpsLabel.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		fpsLabel.BackgroundTransparency = 0.35
		fpsLabel.BorderSizePixel = 0
		fpsLabel.Font = Enum.Font.GothamBold
		fpsLabel.TextSize = 14
		fpsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
		fpsLabel.Text = "FPS: --"
		fpsLabel.Parent = fpsGui

		local corner = Instance.new("UICorner")
		corner.CornerRadius = UDim.new(0, 6)
		corner.Parent = fpsLabel

		local frames, lastTick = 0, tick()
		fpsConn = RunService.RenderStepped:Connect(function()
			frames = frames + 1
			local now = tick()
			local elapsed = now - lastTick
			if elapsed < 0.5 then
				return
			end

			local fps = math.floor(frames / elapsed + 0.5)
			frames, lastTick = 0, now

			local ping
			pcall(function()
				ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue() + 0.5)
			end)

			if fpsLabel then
				fpsLabel.Text = "FPS: " .. fps .. (ping and ("  |  " .. ping .. " ms") or "")
				if fps >= 50 then
					fpsLabel.TextColor3 = Color3.fromRGB(90, 255, 120)
				elseif fps >= 30 then
					fpsLabel.TextColor3 = Color3.fromRGB(255, 220, 80)
				else
					fpsLabel.TextColor3 = Color3.fromRGB(255, 90, 90)
				end
			end
		end)
	end

	GRP_Misc_Graphics_Haki_Stats:AddToggle("Show_FPS_Counter", {
		Text = "Show FPS Counter",
		Default = false,
		Callback = function(v)
			if v then
				fpsStart()
			else
				fpsStop()
			end
		end
	})
end
HakiSt = {
	"State 0",
	"State 1",
	"State 2",
	"State 3",
	"State 4",
	"State 5"
}

do
	HakiStat = GRP_Misc_Graphics_Haki_Stats:AddDropdown("Select_Haki_States", {
		Text = "Select Haki States",
		Values = HakiSt,
		Default = 1,
		Callback = function(p351)
			_G.SelectStateHaki = p351
		end
	})
end

do
	GRP_Misc_Graphics_Haki_Stats:AddButton({
		Text = "ChangeBusoStage",
		Func = function()
			if _G.SelectStateHaki == "State 0" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 0)
			elseif _G.SelectStateHaki == "State 1" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 1)
			elseif _G.SelectStateHaki == "State 2" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 2)
			elseif _G.SelectStateHaki == "State 3" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 3)
			elseif _G.SelectStateHaki == "State 4" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 4)
			elseif _G.SelectStateHaki == "State 5" then
				ReplicatedStorage3.Remotes.CommF_:InvokeServer("ChangeBusoStage", 5)
			end
		end
	})
end

rtxM = GRP_Misc_Graphics_Haki_Stats:AddToggle("Turn_on_RTX_Mode", {
	Text = "Turn on RTX Mode",
	Default = false,
	Callback = function(p352)
		_G.RTXMode = p352

		for _, child in pairs(game.Lighting:GetChildren()) do
			if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
				child:Destroy()
			end
		end

		if _G.RTXMode then
			local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting)

			ColorCorrectionEffect.Name = "RTXColorCorrection"

			local ColorCorrectionEffect2 = Instance.new("ColorCorrectionEffect", game.Lighting)

			ColorCorrectionEffect2.Name = "RTXTint"
			OldAmbient = game.Lighting.Ambient
			OldBrightness = game.Lighting.Brightness
			OldColorShift_Top = game.Lighting.ColorShift_Top
			OldBrightnessc = ColorCorrectionEffect.Brightness
			OldContrastc = ColorCorrectionEffect.Contrast
			OldTintColorc = ColorCorrectionEffect.TintColor
			OldTintColore = ColorCorrectionEffect2.TintColor
			ColorCorrectionEffect.Brightness = 0.176
			ColorCorrectionEffect.Contrast = 0.39
			ColorCorrectionEffect.TintColor = Color3.fromRGB(217, 145, 57)
			ColorCorrectionEffect2.TintColor = Color3.fromRGB(217, 145, 57)
			game.Lighting.FogEnd = 999
			spawn(function()
				while _G.RTXMode do
					wait()
					game.Lighting.Ambient = Color3.fromRGB(33, 33, 33)
					game.Lighting.Brightness = 0.3

					if not _G.RTXMode then
						break
					end

					if LocalPlayer2.Character then
						if LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") then
							if not LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("RTXPointLight") then
								local PointLight = Instance.new("PointLight")

								PointLight.Name = "RTXPointLight"
								PointLight.Parent = LocalPlayer2.Character.HumanoidRootPart
								PointLight.Range = 15
								PointLight.Color = Color3.fromRGB(217, 145, 57)
							end
						end
					end
				end
			end)
		else
			pcall(function()
				if OldAmbient then
					game.Lighting.Ambient = OldAmbient
				end

				if OldBrightness then
					game.Lighting.Brightness = OldBrightness
				end

				if OldColorShift_Top then
					game.Lighting.ColorShift_Top = OldColorShift_Top
				end

				game.Lighting.FogEnd = 2500
			end)

			for _, child in pairs(game.Lighting:GetChildren()) do
				if child.Name == "RTXColorCorrection" or child.Name == "RTXTint" then
					child:Destroy()
				end
			end

			if LocalPlayer2.Character then
				if LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") then
					local RTXPointLight = LocalPlayer2.Character.HumanoidRootPart:FindFirstChild("RTXPointLight")

					if RTXPointLight then
						RTXPointLight:Destroy()
					end
				end
			end
		end
	end
})
GRP_Misc_Graphics_Haki_Stats:AddButton({
	Text = "Turn on Fast Mode",
	Func = function()
		local descendants, v1431 = workspace:GetDescendants()

		for _, v1 in next, descendants, v1431 do
			if table.find(t2, v1.ClassName) then
				v1.Material = "Plastic"
			end
		end
	end
})

do
	GRP_Misc_Graphics_Haki_Stats:AddButton({
		Text = "Turn on Low CPU",
		Func = function()
			LowCpu()
		end
	})
end

do
	GRP_Misc_Graphics_Haki_Stats:AddButton({
		Text = "Turn on increase Boats",
		Func = function()
			for _, child in pairs(workspace.Boats:GetChildren()) do
				if tostring(child.Owner.Value) == tostring(LocalPlayer2.Name) then
					for _, descendant in pairs(child:GetDescendants()) do
						if descendant:IsA("VehicleSeat") then
							descendant.MaxSpeed = 350
							descendant.Torque = 0.2
							descendant.TurnSpeed = 5
							descendant.HeadsUpDisplay = true
						end
					end
				end
			end
		end
	})
end

GRP_Misc_Graphics_Haki_Stats:AddButton({
	Text = "Remove Sky Fog",
	Func = function()
		for _, child in pairs(game.Lighting:GetChildren()) do
			if child.Name == "Sky" or child.Name == "LightingLayers" or child.Name == "SeaTerrorCC" or child.Name == "FantasySky" then
				child:Destroy()
			end
		end
	end
})
GRP_Misc_Configure_God = t15.Misc:AddLeftGroupbox("Configure - God")
GRP_Misc_Configure_God:AddButton({
	Text = "Rain Fruits (Client)",
	Func = function()
		if ReplicatedStorage3:FindFirstChild("Assets") then
			if ReplicatedStorage3.Assets:FindFirstChild("Models") then
				local children = ReplicatedStorage3.Assets.Models:GetChildren()

				for _, child in pairs(children) do
					if child:IsA("Model") and child.Name ~= "IceSpikes4" then
						local clone = child:Clone()

						clone.Parent = workspace

						if clone:FindFirstChild("Float") then
							clone.Float:Destroy()
						end

						clone:SetPrimaryPartCFrame(CFrame.new(LocalPlayer2.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))))
					end
				end
			end
		end
	end
})

do
	local lighting = game:GetService("Lighting")
	local savedLight, fullBrightRunning = nil, false
	briggt1 = GRP_Misc_Configure_God:AddToggle("Turn_on_Full_Bright", {
		Text = "Turn on Full Bright",
		Default = false,
		Callback = function(p353)
			_G.FullBright = p353 -- antes gravava em _G.SelectDN e bagunçava o seletor Day/Night
			if p353 then
				savedLight = savedLight or {
					Brightness = lighting.Brightness,
					FogEnd = lighting.FogEnd,
					GlobalShadows = lighting.GlobalShadows,
					Ambient = lighting.Ambient,
					OutdoorAmbient = lighting.OutdoorAmbient,
				}
				if not fullBrightRunning then
					fullBrightRunning = true
					task.spawn(function()
						while _G.FullBright do
							lighting.Brightness = 2
							lighting.FogEnd = 100000
							lighting.GlobalShadows = false
							lighting.Ambient = Color3.fromRGB(178, 178, 178)
							lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
							task.wait(0.5)
						end
						fullBrightRunning = false
					end)
				end
			elseif savedLight then
				for k, v in pairs(savedLight) do
					pcall(function()
						lighting[k] = v
					end)
				end
				savedLight = nil
			end
		end
	})
end

DayN = GRP_Misc_Configure_God:AddDropdown("Select_Time", {
	Text = "Select Time",
	Values = {
		"Day",
		"Night"
	},
	Default = 1,
	Callback = function(p354)
		_G.SelectDN = p354
	end
})
dayornight = GRP_Misc_Configure_God:AddToggle("Turn_on_Time", {
	Text = "Turn on Time",
	Default = false,
	Callback = function(p355)
		_G.daylightN = p355
	end
})
task.spawn(function()
	while task.wait() do
		if _G.daylightN then
			if _G.SelectDN == "Day" then
				Lighting.ClockTime = 12
			elseif _G.SelectDN == "Night" then
				Lighting.ClockTime = 0
			end
		end
	end
end)
walkWater = GRP_Misc_Configure_God:AddToggle("Turn_on_Walk_on_Water", {
	Text = "Turn on Walk on Water",
	Default = true,
	Callback = function(p356)
		_G.WalkWater_Part = p356

		if _G.WalkWater_Part then
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 112, 1000)
		else
			game:GetService("Workspace").Map["WaterBase-Plane"].Size = Vector3.new(1000, 80, 1000)
		end
	end
})
iceWalk = GRP_Misc_Configure_God:AddToggle("Turn_on_Ice_Walk", {
	Text = "Turn on Ice Walk",
	Default = false,
	Callback = function(p357)
		_G.WalkWater = p357
	end
})
spawn(function()
	while task.wait() do
		if _G.WalkWater then
			pcall(function()
				if LocalPlayer2.Character then
					if LocalPlayer2.Character:FindFirstChild("LeftFoot") then
						local clone = ReplicatedStorage3.Assets.Models.IceSpikes4:Clone()

						clone.Parent = workspace
						clone.Size = Vector3.new(3 + math.random(10, 12), 1.7, 3 + math.random(10, 12))
						clone.Color = Color3.fromRGB(128, 187, 219)
						clone.CFrame = CFrame.new(LocalPlayer2.Character.Head.Position.X, -3.8, LocalPlayer2.Character.Head.Position.Z) * CFrame.Angles((math.random() - 0.5) * 0.06, math.random() * 7, (math.random() - 0.5) * 0.07)

						local t50 = {
							Size = Vector3.new(0, 0.3, 0)
						}
						local tween = TW:Create(clone, TweenInfo.new(2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), t50)

						tween.Completed:Connect(function()
							clone:Destroy()
						end)
						tween:Play()
					end
				end
			end)
		end
	end
end)

do
	local LocalPlayer3 = game.Players.LocalPlayer

	local function v1448(p358)
		if not p358 then
			return false
		end

		local Humanoid = p358:FindFirstChild("Humanoid")

		return Humanoid and Humanoid.Health > 0
	end
	local function v1450(p359, p360)
		local children = game:GetService("Workspace").Enemies:GetChildren()
		local players = game:GetService("Players"):GetPlayers()
		local t51 = {}
		local Position = p359:GetPivot().Position

		for _, child in ipairs(children) do
			local HumanoidRootPart = child:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart and v1448(child) and (HumanoidRootPart.Position - Position).Magnitude <= p360 then
				table.insert(t51, child)
			end
		end

		for _, player in ipairs(players) do
			if player ~= LocalPlayer3 and player.Character then
				local HumanoidRootPart = player.Character:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart and v1448(player.Character) and (HumanoidRootPart.Position - Position).Magnitude <= p360 then
					table.insert(t51, player.Character)
				end
			end
		end

		return t51
	end

	AttackNoCoolDown = function()
		local LocalPlayer4 = game:GetService("Players").LocalPlayer
		local Character = LocalPlayer4.Character

		if not Character then
			return
		end

		local v1463
		local v1464, v1465, v1466 = ipairs(Character:GetChildren())
		local v1467 = geniter(v1464, v1465, v1466)

		while true do
			local v1468 = table.pack(v1467())

			if v1468[1] then
				local v1469 = v1468[3]

				if v1469:IsA("Tool") then
					v1463 = v1469

					break
				end
			else
				break
			end
		end

		if not v1463 then
			return
		end

		local v1470 = v1450(Character, 60)

		if #v1470 == 0 then
			return
		end

		local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
		local Modules = ReplicatedStorage4:FindFirstChild("Modules")

		if not Modules then
			return
		end

		local RERegisterAttack = ReplicatedStorage4:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
		local RERegisterHit = ReplicatedStorage4:WaitForChild("Modules"):WaitForChild("Net"):WaitForChild("RE/RegisterHit")

		if not RERegisterAttack or not RERegisterHit then
			return
		end

		local t52 = {}
		local v1476
		local v1477, v1478, v1479 = ipairs(v1470)

		for _, v1 in v1477, v1478, v1479 do
			if not v1:GetAttribute("IsBoat") then
				local t53 = {
					"RightLowerArm",
					"RightUpperArm",
					"LeftLowerArm",
					"LeftUpperArm",
					"RightHand",
					"LeftHand"
				}
				local PrimaryPart = v1:FindFirstChild(t53[math.random(#t53)]) or v1.PrimaryPart

				if PrimaryPart then
					table.insert(t52, {
						v1,
						PrimaryPart
					})
					v1476 = PrimaryPart
				end
			end
		end

		if not v1476 then
			return
		end

		RERegisterAttack:FireServer(0)

		local PlayerScripts = LocalPlayer4:FindFirstChild("PlayerScripts")

		if not PlayerScripts then
			return
		end

		local LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")

		while not LocalScript do
			PlayerScripts.ChildAdded:Wait()
			LocalScript = PlayerScripts:FindFirstChildOfClass("LocalScript")
		end

		local SendHitsToServer

		if getsenv then
			local ok, result = pcall(getsenv, LocalScript)

			if ok and result then
				SendHitsToServer = result._G.SendHitsToServer
			end
		end

		local ok, result = pcall(function()
			return require(Modules.Flags).COMBAT_REMOTE_THREAD or false
		end)

		if ok and result and SendHitsToServer then
			SendHitsToServer(v1476, t52)
		elseif ok and not result then
			RERegisterHit:FireServer(v1476, t52)
		end
	end
end

CameraShakerR = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

do
	get_Monster = function()
		for _, child in pairs(workspace.Enemies:GetChildren()) do
			local UpperTorso = child:FindFirstChild("UpperTorso") or child:FindFirstChild("Head")

			if child:FindFirstChild("HumanoidRootPart", true) and UpperTorso and (child.Head.Position - LocalPlayer2.Character.HumanoidRootPart.Position).Magnitude <= 50 then
				return true, UpperTorso.Position
			end
		end

		for _, child in pairs(workspace.SeaBeasts:GetChildren()) do
			if child:FindFirstChild("HumanoidRootPart") and child:FindFirstChild("Health") and child.Health.Value > 0 then
				return true, child.HumanoidRootPart.Position
			end
		end

		for _, child in pairs(workspace.Enemies:GetChildren()) do
			if child:FindFirstChild("Health") and child.Health.Value > 0 and child:FindFirstChild("VehicleSeat") then
				return true, child.Engine.Position
			end
		end
	end
end

do
	Actived = function()
		local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
		local v1499, v1500 = getconnections(Tool.Activated)

		for _, v1 in next, v1499, v1500 do
			if typeof(v1.Function) == "function" then
				getupvalues(v1.Function)
			end
		end
	end
end

FarmAtivo = function()
	if getgenv().OnFarm or getgenv().AutoMaterial then
		return true
	end

	for _, flag in ipairs({
		"Level", "HalloweenFarm", "AutoFarmNear", "AutoFarmIsland", "FarmEliteHunt", "FarmEliteH", "AutoFarm_Bone",
		"FarmTyrant", "FarmPhaBinh", "FarmBoss", "AutoFarmAllBoss", "FarmMastery_Dev",
		"FarmMastery_G", "FarmMastery_S", "FarmBlazeEM"
	}) do
		if _G[flag] then
			return true
		end
	end

	return false
end

task.spawn(function()
	RunSer.Heartbeat:Connect(function()
		pcall(function()
			if not _G.Seriality or not FarmAtivo() then
				return
			end

			AttackNoCoolDown()

			local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
			local ToolTip = Tool.ToolTip
			local v1505 = get_Monster()

			if ToolTip == "Blox Fruit" and v1505 then
				local LeftClickRemote = Tool:FindFirstChild("LeftClickRemote")

				if LeftClickRemote then
					Actived()
					LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
					LeftClickRemote:FireServer(false)
				end
			end
		end)
	end)
end)

local t54 = {}
local t55 = {}

do
	local Players2 = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local ReplicatedStorage4 = game:GetService("ReplicatedStorage")
	local Workspace = game:GetService("Workspace")
	local LocalPlayer3 = Players2.LocalPlayer

	if not LocalPlayer3.Character then
		LocalPlayer3.CharacterAdded:Wait()
	end

	local function v1515(p361, p362)
		local _, result = pcall(function()
			return p361:WaitForChild(p362)
		end)

		return result
	end

	local enemies = v1515(Workspace, "Enemies")
	local characters = v1515(Workspace, "Characters")
	local modules = v1515(ReplicatedStorage4, "Modules")
	local net = v1515(modules, "Net")

	t54.Rate = 2e-09
	t54.Enabled = true
	t54.IsAlive = function(p363)
		local Humanoid = p363:FindFirstChild("Humanoid")

		if Humanoid and Humanoid.Health > 0 then
			return true
		end

		return false
	end
	t54.GetNearbyTargets = function(p364, p365)
		local Position = p364:GetPivot().Position
		local t56 = {}
		local children = p365:GetChildren()

		for i = 1, #children do
			local v1527 = children[i]
			local Humanoid = v1527:FindFirstChild("Humanoid")
			local HumanoidRootPart = v1527:FindFirstChild("HumanoidRootPart")

			if Humanoid and HumanoidRootPart and Humanoid.Health > 0 and (HumanoidRootPart.Position - Position).Magnitude <= 60 then
				table.insert(t56, v1527)
			end
		end

		return t56
	end

	local function getTargetParts(p366)
		local t57 = {}

		for i = 1, #p366 do
			local v1533 = p366[i]
			local Head = v1533:FindFirstChild("Head") or v1533.PrimaryPart

			if Head then
				table.insert(t57, {
					v1533,
					Head
				})
			end
		end

		return t57
	end

	t54.GetTargetParts = getTargetParts
	t54.GetAllTargets = function(p367)
		local v1535 = t54.GetNearbyTargets(p367, enemies)
		local v1536 = t54.GetNearbyTargets(p367, characters)
		local t58 = {}

		for i = 1, #v1535 do
			table.insert(t58, v1535[i])
		end

		for i = 1, #v1536 do
			table.insert(t58, v1536[i])
		end

		return t58
	end
	t54.ExecuteFastAttack = function()
		local Character = LocalPlayer3.Character

		if not Character then
			return
		end

		if not Character:FindFirstChildOfClass("Tool") then
			return
		end

		local v1541 = t54.GetAllTargets(Character)

		if #v1541 < 1 then
			return
		end

		local v1542 = t54.GetTargetParts(v1541)

		if #v1542 < 1 then
			return
		end

		local reRegisterHit = net["RE/RegisterHit"]

		net["RE/RegisterAttack"]:FireServer(t54.Rate)
		reRegisterHit:FireServer(v1542[1][2], v1542)
	end

	local u1544
	local attribute

	local function v1546()
		for _, v1 in ipairs({
			ReplicatedStorage4.Util,
			ReplicatedStorage4.Common,
			ReplicatedStorage4.Remotes,
			ReplicatedStorage4.Assets,
			ReplicatedStorage4.FX
		}) do
			local children = v1:GetChildren()

			for _, child in ipairs(children) do
				if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
					u1544 = child
					attribute = child:GetAttribute("Id")
				end
			end

			v1.ChildAdded:Connect(function(child)
				if child:IsA("RemoteEvent") and child:GetAttribute("Id") then
					u1544 = child
					attribute = child:GetAttribute("Id")
				end
			end)
		end
	end

	v1546()
	t55.Execute = function()
		local Character = LocalPlayer3.Character

		if not Character then
			return
		end

		local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return
		end

		local t59 = {}

		local function v1555(p368)
			local children = p368:GetChildren()

			for i = 1, #children do
				local v1558 = children[i]
				local Humanoid = v1558:FindFirstChild("Humanoid")
				local HumanoidRootPart2 = v1558:FindFirstChild("HumanoidRootPart")

				if Humanoid and HumanoidRootPart2 and Humanoid.Health > 0 and v1558 ~= Character and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 60 then
					local children2 = v1558:GetChildren()

					for _, v1 in ipairs(children2) do
						if v1:IsA("BasePart") then
							table.insert(t59, {
								v1558,
								v1
							})
						end
					end
				end
			end
		end

		v1555(enemies)
		v1555(characters)

		local Tool = Character:FindFirstChildOfClass("Tool")

		if #t59 > 0 and Tool and (Tool:GetAttribute("WeaponType") == "Melee" or Tool:GetAttribute("WeaponType") == "Sword") then
			local response = modules.Net.seed:InvokeServer()
			local reRegisterHit = net["RE/RegisterHit"]

			net["RE/RegisterAttack"]:FireServer()

			local Head = t59[1][1]:FindFirstChild("Head")

			if not Head then
				return
			end

			reRegisterHit:FireServer(Head, t59, {})

			if u1544 then
				local v1568 = math.floor(Workspace:GetServerTimeNow() / 10 % 10) + 1
				local RegisterHit = string.gsub("RE/RegisterHit", ".", function(p369)
					return string.char(bit32.bxor(string.byte(p369), v1568))
				end)
				local v1570 = bit32.bxor(attribute + 909090, response * 2)

				cloneref(u1544):FireServer(RegisterHit, v1570, Head, t59)
			end
		end
	end

	local function v1571()
		require(ReplicatedStorage4.Util.CameraShaker):Stop()
	end
	local function v1572()
		task.spawn(function()
			while task.wait(t54.Rate) do
				if FarmAtivo() then
					t54.ExecuteFastAttack()
				end
			end
		end)
		RunService.Heartbeat:Connect(function()
			if FarmAtivo() then
				pcall(t55.Execute)
			end
		end)
	end

	v1572()
end

-- ===================== KAITUN UI + motor =====================
getgenv().ZyroxKaitun = getgenv().ZyroxKaitun == true

local function ZyroxKaitunHas(name)
	if type(GetWP) == "function" and GetWP(name) then
		return true
	end
	local bp, ch = plr.Backpack, plr.Character
	if bp and bp:FindFirstChild(name) then
		return true
	end
	if ch and ch:FindFirstChild(name) then
		return true
	end
	local ok, inv = pcall(function()
		return replicated.Remotes.CommF_:InvokeServer("getInventory")
	end)
	if ok and type(inv) == "table" then
		for _, it in pairs(inv) do
			if it and it.Name == name then
				return true
			end
		end
	end
	return false
end

-- UI pequena do Kaitun
local function ZyroxKaitunBuildUI()
	local host = (gethui and gethui()) or game:GetService("CoreGui")
	pcall(function()
		local old = host:FindFirstChild("ZyroxKaitunUI")
		if old then
			old:Destroy()
		end
	end)

	local gui = Instance.new("ScreenGui")
	gui.Name = "ZyroxKaitunUI"
	gui.ResetOnSpawn = false
	gui.IgnoreGuiInset = true
	gui.DisplayOrder = 9990
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	pcall(function()
		if syn and syn.protect_gui then
			syn.protect_gui(gui)
		end
	end)
	gui.Parent = host

	local card = Instance.new("Frame")
	card.Name = "Card"
	card.AnchorPoint = Vector2.new(0, 0)
	card.Position = UDim2.fromOffset(16, 80)
	card.Size = UDim2.fromOffset(260, 118)
	card.BackgroundColor3 = Color3.fromRGB(14, 14, 18)
	card.BorderSizePixel = 0
	card.Parent = gui
	Instance.new("UICorner", card).CornerRadius = UDim.new(0, 12)
	local stroke = Instance.new("UIStroke")
	stroke.Color = Color3.fromRGB(255, 170, 40)
	stroke.Thickness = 1.2
	stroke.Transparency = 0.25
	stroke.Parent = card

	local accent = Instance.new("Frame")
	accent.Size = UDim2.new(0, 4, 1, -16)
	accent.Position = UDim2.fromOffset(8, 8)
	accent.BackgroundColor3 = Color3.fromRGB(255, 170, 40)
	accent.BorderSizePixel = 0
	accent.Parent = card
	Instance.new("UICorner", accent).CornerRadius = UDim.new(1, 0)

	local title = Instance.new("TextLabel")
	title.BackgroundTransparency = 1
	title.Position = UDim2.fromOffset(20, 10)
	title.Size = UDim2.new(1, -56, 0, 22)
	title.Font = Enum.Font.GothamBold
	title.TextSize = 15
	title.TextColor3 = Color3.fromRGB(255, 255, 255)
	title.TextXAlignment = Enum.TextXAlignment.Left
	title.Text = "Zyrox Hub Kaitun"
	title.Parent = card

	local status = Instance.new("TextLabel")
	status.Name = "Status"
	status.BackgroundTransparency = 1
	status.Position = UDim2.fromOffset(20, 36)
	status.Size = UDim2.new(1, -28, 0, 40)
	status.Font = Enum.Font.Gotham
	status.TextSize = 13
	status.TextColor3 = Color3.fromRGB(200, 205, 220)
	status.TextXAlignment = Enum.TextXAlignment.Left
	status.TextYAlignment = Enum.TextYAlignment.Top
	status.TextWrapped = true
	status.Text = "iniciando..."
	status.Parent = card

	local meta = Instance.new("TextLabel")
	meta.Name = "Meta"
	meta.BackgroundTransparency = 1
	meta.Position = UDim2.fromOffset(20, 80)
	meta.Size = UDim2.new(1, -28, 0, 28)
	meta.Font = Enum.Font.Gotham
	meta.TextSize = 11
	meta.TextColor3 = Color3.fromRGB(130, 135, 150)
	meta.TextXAlignment = Enum.TextXAlignment.Left
	meta.TextYAlignment = Enum.TextYAlignment.Top
	meta.TextWrapped = true
	meta.Text = "Lv — | Sea —"
	meta.Parent = card

	-- botao minimizar / fechar
	local stopBtn = Instance.new("TextButton")
	stopBtn.Size = UDim2.fromOffset(22, 22)
	stopBtn.Position = UDim2.new(1, -28, 0, 8)
	stopBtn.BackgroundColor3 = Color3.fromRGB(40, 30, 30)
	stopBtn.BorderSizePixel = 0
	stopBtn.Font = Enum.Font.GothamBold
	stopBtn.TextSize = 12
	stopBtn.TextColor3 = Color3.fromRGB(255, 120, 120)
	stopBtn.Text = "X"
	stopBtn.Parent = card
	Instance.new("UICorner", stopBtn).CornerRadius = UDim.new(0, 6)

	-- drag
	local dragging, dragStart, startPos
	card.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = card.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			card.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)

	stopBtn.MouseButton1Click:Connect(function()
		if getgenv().ZyroxKaitunStop then
			getgenv().ZyroxKaitunStop()
		end
	end)

	getgenv().ZyroxKaitunSetStatus = function(main, sub)
		pcall(function()
			if status and status.Parent then
				status.Text = tostring(main or "")
			end
			if sub and meta and meta.Parent then
				meta.Text = tostring(sub)
			end
		end)
	end

	return gui
end

local function ZyroxKaitunSet(main, sub)
	if getgenv().ZyroxKaitunSetStatus then
		getgenv().ZyroxKaitunSetStatus(main, sub)
	end
end

local function ZyroxKaitunClearSide()
	local flags = {
		"AutoSaber", "AutoFactory", "AutoEctoplasm", "AutoFarm_Bone", "FarmEliteH", "FarmEliteHunt",
		"Auto_Cake_Prince", "AutoSpawnCP", "Auto_Yama", "Auto_Tushita", "Auto_CDK", "CDK_TS", "CDK_YM", "CDK",
		"Auto_TTK", "Auto_Rainbow_Haki", "Auto_SuperHuman", "AutoDeathStep", "Auto_SharkMan_Karate",
		"Auto_Electric_Claw", "AutoDragonTalon", "Auto_God_Human", "AutoSanguineArt", "AutoPole", "AutoPoleV2",
		"Bartilo_Quest", "CitizenQuest", "AutoKenVTWO", "obsFarm", "StoreF", "InstanceF", "Random_Auto",
		"Auto_Awakener", "AutoFarmChest", "AutoBerry",
	}
	for _, f in ipairs(flags) do
		_G[f] = false
	end
end

local function ZyroxKaitunStart()
	if not getgenv().ZyroxKaitun then
		return
	end
	if getgenv().ZyroxKaitunRunning then
		return
	end
	getgenv().ZyroxKaitunRunning = true
	_G.ZyroxKaitun = true

	-- interface propria
	pcall(ZyroxKaitunBuildUI)
	ZyroxKaitunSet("preparando farms do Zyrox...", "Lv — | Sea —")

	-- esconde hub principal se Fluent minimiza
	pcall(function()
		if lib and lib.HideUI then
			lib.HideUI()
		elseif lib and lib.ToggleUI then
			-- deixa aberto mas status fica por cima
		end
	end)

	_G.Level = true
	_G.StoreF = true
	_G.Auto_Melee = true
	ZyroxKaitunSet("farmando level", nil)

	task.spawn(function()
		while getgenv().ZyroxKaitun and task.wait(6) do
			pcall(function()
				local pts = plr.Data and plr.Data.Points and plr.Data.Points.Value or 0
				if pts > 0 then
					replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", math.min(pts, 100))
				end
			end)
		end
	end)

	task.spawn(function()
		while getgenv().ZyroxKaitun and task.wait(10) do
			pcall(function()
				_G.StoreF = true
				for _, container in ipairs({ plr.Backpack, plr.Character }) do
					if container then
						for _, tool in ipairs(container:GetChildren()) do
							if tool:IsA("Tool") and string.find(string.lower(tool.Name), "fruit") then
								pcall(function()
									replicated.Remotes.CommF_:InvokeServer("StoreFruit", tool.Name, tool)
								end)
								task.wait(0.35)
							end
						end
					end
				end
			end)
		end
	end)

	task.spawn(function()
		local lastTravel = 0
		local meleeOrder = {
			{ flag = "Auto_SuperHuman", name = "Superhuman", min = 300 },
			{ flag = "AutoDeathStep", name = "Death Step", min = 400 },
			{ flag = "Auto_SharkMan_Karate", name = "Sharkman Karate", min = 450 },
			{ flag = "Auto_Electric_Claw", name = "Electric Claw", min = 500 },
			{ flag = "AutoDragonTalon", name = "Dragon Talon", min = 550 },
			{ flag = "Auto_God_Human", name = "Godhuman", min = 600 },
		}

		while getgenv().ZyroxKaitun and task.wait(1.2) do
			pcall(function()
				local lv = (plr.Data and plr.Data.Level and plr.Data.Level.Value) or 0
				local seaName = sea3 and "Sea 3" or sea2 and "Sea 2" or "Sea 1"
				local meta = string.format("Lv %d | %s", lv, seaName)
				_G.Level = true
				_G.Auto_Melee = true

				local action = "farmando level"

				if tick() - lastTravel > 30 then
					if lv >= 700 and sea1 then
						lastTravel = tick()
						action = "viajando para Sea 2..."
						ZyroxKaitunSet(action, meta)
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("TravelDressrosa")
						end)
					elseif lv >= 1500 and sea2 then
						lastTravel = tick()
						action = "viajando para Sea 3..."
						ZyroxKaitunSet(action, meta)
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("TravelZou")
						end)
						pcall(function()
							replicated.Remotes.CommF_:InvokeServer("F_", "TravelZou")
						end)
					end
				end

				if sea1 then
					if lv >= 200 and not ZyroxKaitunHas("Saber") then
						_G.AutoSaber = true
						action = "farmando Saber"
					else
						_G.AutoSaber = false
					end
					if lv >= 300 and not ZyroxKaitunHas("Pole") then
						_G.AutoPole = true
						if action == "farmando level" then
							action = "farmando Pole"
						end
					end
					if action == "farmando level" then
						action = "farmando level (Sea 1)"
					end
				end

				if sea2 then
					_G.AutoSaber = false
					_G.AutoFactory = lv >= 700
					_G.AutoEctoplasm = lv >= 900
					if lv >= 800 then
						_G.Bartilo_Quest = true
					end
					if _G.AutoFactory then
						action = "Factory Raid"
					elseif _G.AutoEctoplasm then
						action = "farmando Ectoplasm"
					elseif _G.Bartilo_Quest then
						action = "quest Bartilo"
					else
						action = "farmando level (Sea 2)"
					end
					for _, m in ipairs(meleeOrder) do
						if ZyroxKaitunHas(m.name) then
							_G[m.flag] = false
						elseif lv >= m.min then
							_G[m.flag] = true
							action = "melee: " .. m.name
							break
						else
							_G[m.flag] = false
						end
					end
				end

				if sea3 then
					_G.AutoFactory = false
					_G.AutoEctoplasm = false
					if lv >= 1500 then
						_G.FarmEliteHunt = true
						_G.AutoFarm_Bone = true
						action = "Elite + Bone"
					end
					if lv >= 2000 then
						_G.Auto_Cake_Prince = true
						_G.AutoSpawnCP = true
						action = "Cake Prince"
					end
					if lv >= 1600 and not ZyroxKaitunHas("Yama") then
						_G.Auto_Yama = true
						action = "farmando Yama"
					else
						_G.Auto_Yama = false
					end
					if lv >= 1800 and ZyroxKaitunHas("Yama") and not ZyroxKaitunHas("Tushita") then
						_G.Auto_Tushita = true
						action = "farmando Tushita"
					else
						_G.Auto_Tushita = false
					end
					if lv >= 2000 and not ZyroxKaitunHas("True Triple Katana") then
						_G.Auto_TTK = true
						action = "farmando TTK"
					else
						_G.Auto_TTK = false
					end
					if lv >= 2200 and ZyroxKaitunHas("Yama") and ZyroxKaitunHas("Tushita") and not ZyroxKaitunHas("Cursed Dual Katana") then
						_G.Auto_CDK = true
						action = "farmando CDK"
					else
						_G.Auto_CDK = false
					end
					if lv >= 1500 then
						_G.Auto_Rainbow_Haki = true
					end
					if lv >= 1700 then
						_G.AutoKenVTWO = true
						_G.obsFarm = true
					end
					if lv >= 2000 and not ZyroxKaitunHas("Godhuman") and not ZyroxKaitunHas("God Human") then
						_G.Auto_God_Human = true
						action = "melee: Godhuman"
					end
				end

				pcall(function()
					if lv >= 50 then
						replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
					end
					if lv >= 100 then
						replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
					end
					if lv >= 150 then
						replicated.Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
					end
					if lv >= 450 then
						replicated.Remotes.CommF_:InvokeServer("KenTalk", "Buy")
					end
				end)

				ZyroxKaitunSet(action, meta)
			end)
		end
	end)

	pcall(function()
		local vu = game:GetService("VirtualUser")
		plr.Idled:Connect(function()
			if getgenv().ZyroxKaitun then
				vu:CaptureController()
				vu:ClickButton2(Vector2.new())
			end
		end)
	end)
end

getgenv().ZyroxKaitunStop = function()
	getgenv().ZyroxKaitun = false
	getgenv().ZyroxKaitunRunning = false
	_G.ZyroxKaitun = false
	_G.Level = false
	pcall(ZyroxKaitunClearSide)
	ZyroxKaitunSet("parado", "Lv — | Sea —")
	task.delay(1.5, function()
		pcall(function()
			local host = (gethui and gethui()) or game:GetService("CoreGui")
			local ui = host:FindFirstChild("ZyroxKaitunUI")
			if ui then
				ui:Destroy()
			end
		end)
	end)
end

task.defer(function()
	task.wait(2)
	pcall(ZyroxKaitunStart)
end)

-- ===================== ESTATISTICAS DE EXECUCAO (webhook do Discord) =====================
-- Envia ao SEU webhook: nome do jogador, quantas vezes ele executou o hub e o link do servidor.
-- Desativar: getgenv().ZyroxAnalytics = false  (antes de executar)
task.spawn(function()
	local WEBHOOK_URL = getgenv().ZyroxWebhook
		or "https://discord.com/api/webhooks/1566289461027799110/r5Zl8-DgCp-einEGhcqTsyNJT_iS9EoOK8CDbIPvtQAFJQxk36We5k8GkYLDottJhlkC"

	if getgenv().ZyroxAnalytics == false then
		print("[Zyrox] webhook desativado (ZyroxAnalytics = false)")
		return
	end
	if type(WEBHOOK_URL) ~= "string" or not WEBHOOK_URL:find("^https://") then
		warn("[Zyrox] webhook URL invalida")
		return
	end

	local HttpService = game:GetService("HttpService")
	local request = (syn and syn.request)
		or (http and http.request)
		or http_request
		or request
		or (fluxus and fluxus.request)
	if type(request) ~= "function" then
		-- tenta game:HttpGet nao serve POST; sem request nao roda
		warn("[Zyrox] executor sem request/http_request — webhook nao enviou")
		return
	end

	local file = "ZyroxHub_Executions.json"
	local count, first = 1, os.time()
	pcall(function()
		if type(isfile) == "function" and isfile(file) then
			local saved = HttpService:JSONDecode(readfile(file))
			if type(saved) == "table" then
				count = (tonumber(saved.count) or 0) + 1
				first = tonumber(saved.first) or first
			end
		end
		if type(writefile) == "function" then
			writefile(file, HttpService:JSONEncode({ count = count, first = first, last = os.time() }))
		end
	end)

	local gameName = "Place " .. tostring(game.PlaceId)
	pcall(function()
		gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)

	local executor = "desconhecido"
	pcall(function()
		if identifyexecutor then
			executor = tostring((identifyexecutor()))
		end
	end)

	local avatar = string.format(
		"https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=420&height=420&format=png",
		plr.UserId
	)

	local serverLink = string.format(
		"https://www.roblox.com/games/start?placeId=%d&gameInstanceId=%s",
		game.PlaceId,
		tostring(game.JobId)
	)

	local players = game:GetService("Players")
	local payload = {
		username = "Zyrox Hub",
		avatar_url = "https://www.roblox.com/headshot-thumbnail/image?userId=1&width=150&height=150&format=png",
		embeds = {
			{
				title = "Zyrox Hub executado",
				color = 0xFF6A00,
				thumbnail = { url = avatar },
				fields = {
					{ name = "Jogador", value = string.format("%s (@%s)", plr.DisplayName, plr.Name), inline = true },
					{ name = "UserId", value = tostring(plr.UserId), inline = true },
					{ name = "Execucoes", value = tostring(count), inline = true },
					{ name = "Jogo", value = gameName, inline = false },
					{ name = "Servidor", value = "[Entrar no servidor](" .. serverLink .. ")", inline = false },
					{ name = "Jogadores", value = #players:GetPlayers() .. "/" .. tostring(players.MaxPlayers), inline = true },
					{ name = "Executor", value = executor, inline = true },
				},
				timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
			},
		},
	}

	local ok, res = pcall(function()
		return request({
			Url = WEBHOOK_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(payload),
		})
	end)

	if not ok then
		warn("[Zyrox] webhook falhou: " .. tostring(res))
	else
		local code = type(res) == "table" and (res.StatusCode or res.Status or res.statusCode) or nil
		print("[Zyrox] webhook enviado", code and ("status " .. tostring(code)) or "ok")
		if code and tonumber(code) and tonumber(code) >= 400 then
			warn("[Zyrox] Discord rejeitou: " .. tostring(code) .. " " .. tostring(res.Body or res.body or ""))
		end
	end
end)

lib:Notify({
			Title = "Zyrox hub",
			Description = "Estatisticas: este hub registra seu nome, nº de execucoes e o link do servidor. Para desativar: getgenv().ZyroxAnalytics = false",
			Duration = 8
		})
	end)

	local gameName = "Place " .. tostring(game.PlaceId)
	pcall(function()
		gameName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
	end)

	local executor = "desconhecido"
	pcall(function()
		if identifyexecutor then
			executor = tostring((identifyexecutor()))
		end
	end)

	-- link que abre o Roblox direto neste servidor
	local serverLink = string.format(
		"https://www.roblox.com/games/start?placeId=%d&gameInstanceId=%s",
		game.PlaceId, game.JobId
	)

	local players = game:GetService("Players")
	local payload = {
		username = "Zyrox Hub",
		embeds = { {
			title = "Zyrox Hub executado",
			color = 0xFF6A00,
			fields = {
				{ name = "Jogador", value = string.format("%s (@%s)", plr.DisplayName, plr.Name), inline = true },
				{ name = "UserId", value = tostring(plr.UserId), inline = true },
				{ name = "Execucoes", value = tostring(count), inline = true },
				{ name = "Jogo", value = gameName, inline = false },
				{ name = "Servidor", value = "[Entrar no servidor](" .. serverLink .. ")", inline = false },
				{ name = "Jogadores no servidor", value = #players:GetPlayers() .. "/" .. players.MaxPlayers, inline = true },
				{ name = "Executor", value = executor, inline = true },
			},
			timestamp = os.date("!%Y-%m-%dT%H:%M:%SZ"),
		} },
	}

	pcall(function()
		request({
			Url = WEBHOOK_URL,
			Method = "POST",
			Headers = { ["Content-Type"] = "application/json" },
			Body = HttpService:JSONEncode(payload),
		})
	end)
end)

lib:Notify({
	Title = "Zyrox hub",
	Description = getgenv().ZyroxKaitun and "Kaitun ativo — full auto" or "feito por havoc",
	Icon = "rbxassetid://108697676964602",
	Duration = 5
})
