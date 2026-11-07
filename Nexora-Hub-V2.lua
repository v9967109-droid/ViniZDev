-- ez crack skid night hub 😂
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local localPlayer = Players.LocalPlayer

if _G.NightDungeon and _G.NightDungeon.Stop then
	pcall(_G.NightDungeon.Stop)
	task.wait(0.35)
end

local nightDungeonConfig = _G.NightDungeonConfig or {}
_G.NightDungeonConfig = nightDungeonConfig

local function fn(arg, arg2)
	if nightDungeonConfig[arg] == nil then
		nightDungeonConfig[arg] = arg2
	end
end

fn("Difficulty", "Hard")
fn("Weapon", "Melee")
fn("HoverHeight", 250)
fn("KillHeight", 82)
fn("BossKillHeight", 88)
fn("TweenSpeed", 180)
fn("ArriveDistance", 14)
fn("JumpThreshold", 400)
fn("RescueSpeed", 6000)
fn("HitRadius", 100)
fn("AttackDelay", 0.07)
fn("BuffDelay", 0.45)
fn("FloorHeight", 90)
fn("DoorTouch", 30)
fn("PropMaxHP", 5000)
fn("PropRadius", 700)
fn("StallTime", 5)
fn("EnergyCost", 10)
fn("EnergyMax", 50)
fn("OutOnEmpty", true)
fn("OutDelay", 10)
fn("Kaitun", true)
local nightDungeonAll = _G.NightDungeonAll

if type(nightDungeonAll) ~= "table" then
	nightDungeonAll = {}
	_G.NightDungeonAll = nightDungeonAll
end

local n = 0

for i = #nightDungeonAll, 1, -1 do
	local v = nightDungeonAll[i]
	nightDungeonAll[i] = nil

	if type(v) == "table" and type(v.Stop) == "function" then
		n += 1
		pcall(v.Stop)
	end
end

if n > 0 then
	print("[NightDungeon] da dep " .. n .. " ban cu")
end

local flag = false
local nightDungeon = {}
_G.NightDungeon = nightDungeon
nightDungeonAll[#nightDungeonAll + 1] = nightDungeon
local flag2 = nightDungeonConfig.Kaitun ~= false

local state = {
	Farm = flag2,
	AutoStart = flag2,
	AutoBuff = flag2,
	FastAttack = flag2,
	Safe = false,
	Target = "-",
	Dist = -1,
	Stage = "Idle",
	Floor = 0,
	Here = -1,
	MaxFloor = 0,
	Dead = 0,
	Total = 0,
	TimeLeft = 0,
	Runs = 0,
	Kills = 0,
	Energy = 0,
	EnergyMax = 0,
	EnergyNeed = 0,
	Buffs = {},
	Started = os.clock(),
}

local tbl = {
	"AttackSpeedMultiplier",
	"Overflow",
	"Lifesteal",
	"AllCooldown",
	"Unbreakable",
	"Fortress",
	"Shadow",
	"FruitTAPCooldown",
	"Armor",
	"Defense",
	"Skyjumps",
	"RageGain",
	"RaceEnergy",
	"Sniper",
	"Size",
}

local tbl2 = {
	Melee = { "Melee", "MeleeCooldown", "MeleeZCooldown", "MeleeXCooldown", "MeleeCCooldown" },
	Sword = { "Sword", "SwordCooldown", "SwordZCooldown", "SwordXCooldown" },
	["Blox Fruit"] = {
		"Fruit",
		"FruitCooldown",
		"FruitZCooldown",
		"FruitXCooldown",
		"FruitVCooldown",
		"FruitCCooldown",
	},
	Gun = { "Gun", "GunCooldown", "GunZCooldown", "GunXCooldown" },
}

local net = ReplicatedStorage:WaitForChild("Modules"):WaitForChild("Net")
local reRegisterAttack = net:WaitForChild("RE/RegisterAttack")
local reRegisterHit = net:WaitForChild("RE/RegisterHit")
local commF = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_")
local dungeonShared = ReplicatedStorage:WaitForChild("DungeonShared")
local log = {}

local function fn2(arg)
	log[#log + 1] = arg

	if #log > 40 then
		table.remove(log, 1)
	end

	print("[NightDungeon] " .. arg)
end

local function fn3(stage)
	if state.Stage ~= stage then
		state.Stage = stage
	end
end

local function fn4()
	local character = localPlayer.Character
	if character and character.Parent and character:FindFirstChild("HumanoidRootPart") then
		return character
	end
	return nil
end

local function fn5()
	local v = fn4()
	return v and v:FindFirstChild("HumanoidRootPart") or nil
end

local function fn6()
	local v = fn4()
	return v and v:FindFirstChildOfClass("Humanoid") or nil
end

local function fn7()
	return localPlayer:FindFirstChildOfClass("Backpack")
end

local function fn8()
	return Workspace:GetAttribute("IsDungeonHub") == true
end

local function fn9()
	return Workspace:GetAttribute("IsDungeonInstance") == true or localPlayer:GetAttribute("ExplorerGUID") ~= nil
end

local v = nil
local n2 = 0

local tbl3 = {
	Map = true,
	Camera = true,
	Terrain = true,
	Enemies = true,
	Characters = true,
	Debris = true,
	Effect = true,
	Sounds = true,
	Particles = true,
	Projectiles = true,
}

local fn10 = nil

fn10 = function(arg, arg2)
	for _, child in ipairs(arg:GetChildren()) do
		if child:GetAttribute("CurrentExploredLevel") ~= nil then
			return child
		end
	end

	if arg2 <= 0 then
		return nil
	end

	for _, child in ipairs(arg:GetChildren()) do
		if (child:IsA("Folder") or child:IsA("Configuration")) and not tbl3[child.Name] then
			local v2 = fn10(child, arg2 - 1)
			if v2 then
				return v2
			end
		end
	end

	return nil
end

local function fn11()
	if v and v.Parent and v:GetAttribute("CurrentExploredLevel") ~= nil then
		return v
	end
	v = nil
	if not fn9() then
		return nil
	end

	if os.clock() - n2 < 3 then
		return nil
	end
	n2 = os.clock()
	v = fn10(Workspace, 2) or fn10(ReplicatedStorage, 2)
	return v
end

local function fn12()
	local map = Workspace:FindFirstChild("Map")
	return map and map:FindFirstChild("Dungeon") or nil
end

local function fn13(arg)
	local v2 = fn12()
	if not v2 or not arg then
		return nil
	end
	return v2:FindFirstChild(tostring(arg))
end

local function fn14(arg)
	if not arg then
		return nil
	end
	local attribute = arg:GetAttribute("BoundingCF")
	attribute = attribute and attribute.Position

	if not attribute then
		local ok

		ok, attribute = pcall(function()
			return arg:GetPivot().Position
		end)

		if not ok then
			return nil
		end
	end

	return CFrame.new(attribute.X, attribute.Y + nightDungeonConfig.FloorHeight, attribute.Z)
end

local function fn15()
	local v2 = fn12()
	if not v2 then
		return nil
	end
	local v3 = nil

	for _, child in ipairs(v2:GetChildren()) do
		local num = tonumber(child.Name)

		if num and (not v3 or num > v3) then
			v3 = num
		end
	end

	return v3
end

local function fn16(arg, arg2)
	local attribute = arg:GetAttribute("BoundingCF")
	local attribute2 = arg:GetAttribute("BoundingSize")
	if not attribute or not attribute2 then
		return false
	end
	local v2 = attribute:PointToObjectSpace(arg2)
	local n3 = attribute2.X * 0.5
	local flag3 = math.abs(v2.X) <= n3

	if flag3 then
		local n4 = attribute2.Y * 0.5
		flag3 = math.abs(v2.Y) <= n4
	end

	if flag3 then
		local n4 = attribute2.Z * 0.5
		flag3 = math.abs(v2.Z) <= n4
	end

	return flag3
end

local function fn17()
	local v2 = fn5()
	local v3 = fn12()
	if not v2 or not v3 then
		return nil
	end
	local position = v2.Position
	local v4, v5, v6 = ipairs(v3:GetChildren())
	local v7 = nil
	local v8 = nil

	for _, v9 in v4, v5, v6 do
		local num = tonumber(v9.Name)

		if num then
			if fn16(v9, position) then
				return num
			end
			local attribute = v9:GetAttribute("BoundingCF")

			if attribute then
				local magnitude = (attribute.Position - position).Magnitude

				if not v7 or magnitude < v7 then
					v7 = magnitude
					v8 = num
				end
			end
		end
	end

	return v8
end

local function fn18(arg, arg2)
	local v2 = fn13(arg)
	v2 = v2 and v2:FindFirstChild(arg2)
	return v2 and v2:FindFirstChild("Root") or nil
end

local function fn19(arg)
	return arg ~= nil and arg.Parent ~= nil and arg:FindFirstChild("TouchInterest") ~= nil
end

local n3 = 0

local function fn20(arg)
	if os.clock() - n3 < 0.6 then
		return
	end
	n3 = os.clock()
	local v2 = fn5()
	if not v2 or not arg or type(firetouchinterest) ~= "function" then
		return
	end
	pcall(firetouchinterest, v2, arg, 0)
	task.wait()
	pcall(firetouchinterest, v2, arg, 1)
end

local function fn21()
	local ok, result = pcall(function()
		return require(ReplicatedStorage.DungeonClient.ReplicatedPlayerData).get()
	end)

	if ok and type(result) == "table" then
		return result
	end
	return nil
end

local function fn22()
	state.EnergyMax = tonumber(nightDungeonConfig.EnergyMax) or 50
	local v2 = fn21()
	if not v2 then
		return 0
	end
	return math.floor(tonumber(v2.CurrentEnergy) or 0)
end

local flag3 = false

local function fn23()
	for _, v2 in ipairs({
		function()
			game:Shutdown()
		end,
		function()
			localPlayer:Kick("Night Hub: het energy")
		end,
		function()
			game:GetService("TeleportService"):Teleport(0, localPlayer)
		end,
	}) do
		if pcall(v2) then
			return true
		end
	end

	return false
end

local function fn24(arg, arg2)
	if flag3 then
		return
	end
	flag3 = true
	fn2("KHONG DU ENERGY (" .. arg .. "/" .. arg2 .. ") - out game sau " .. nightDungeonConfig.OutDelay .. "s")

	task.spawn(function()
		for i = nightDungeonConfig.OutDelay, 1, -1 do
			fn3("HET ENERGY " .. arg .. "/" .. arg2 .. " - out sau " .. i .. "s")
			task.wait(1)
		end

		fn23()
	end)
end

local cframe = nil
local connection = nil
local connection2 = nil
local tween = nil

local function fn25()
	if tween then
		pcall(function()
			tween:Cancel()
		end)

		tween = nil
	end
end

local tbl4 = {}
local v2 = nil
local n4 = 0

local function fn26(arg)
	if arg then
		if connection2 then
			return
		end
		tbl4 = {}
		v2 = nil

		connection2 = RunService.Stepped:Connect(function()
			local v3 = fn4()

			if not v3 then
				tbl4 = {}
				v2 = nil
				return
			end

			if v3 ~= v2 or os.clock() - n4 > 3 then
				v2 = v3
				n4 = os.clock()
				local tbl5 = {}

				for _, descendant in ipairs(v3:GetDescendants()) do
					if descendant:IsA("BasePart") then
						tbl5[#tbl5 + 1] = descendant
					end
				end

				tbl4 = tbl5
			end

			for _, v4 in ipairs(tbl4) do
				if v4.CanCollide then
					v4.CanCollide = false
				end
			end
		end)
	elseif connection2 then
		connection2:Disconnect()
		connection2 = nil
		tbl4 = {}
		v2 = nil
	end
end

local function fn27(arg)
	local v3 = fn4()
	if not v3 then
		return
	end
	local head = v3:FindFirstChild("Head") or v3:FindFirstChild("HumanoidRootPart")
	if not head then
		return
	end
	local nightVelocity = head:FindFirstChild("NightVelocity")

	if arg then
		if not nightVelocity then
			local bodyVelocity = Instance.new("BodyVelocity")
			bodyVelocity.Name = "NightVelocity"
			bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
			bodyVelocity.Velocity = Vector3.zero
			bodyVelocity.P = 1500
			bodyVelocity.Parent = head
		end
	elseif nightVelocity then
		nightVelocity:Destroy()
	end
end

local v3 = nil
local n5 = 0

local function fn28(arg)
	local v4 = fn5()
	if not v4 then
		return false
	end
	local v5 = fn6()
	if not v5 or v5.Health <= 0 then
		fn25()
		return false
	end

	if v5.Sit then
		v5.Sit = false
	end

	local magnitude = (arg.Position - v4.Position).Magnitude
	if magnitude <= nightDungeonConfig.ArriveDistance then
		fn25()
		return true
	end

	if tween and v3 and (v3.Position - arg.Position).Magnitude < 6 and tween.PlaybackState == Enum.PlaybackState.Playing then
		return false
	end
	local tweenSpeed = nightDungeonConfig.TweenSpeed

	if os.clock() < n5 then
		tweenSpeed = nightDungeonConfig.RescueSpeed
	end

	fn25()
	v3 = arg
	tween = TweenService:Create(v4, TweenInfo.new(math.max(magnitude / tweenSpeed, 0.05), Enum.EasingStyle.Linear), { CFrame = arg })
	tween:Play()
	return false
end

local v4 = nil
local n6 = 0
local physics = Enum.HumanoidStateType.Physics

local function fn29(arg)
	if arg then
		if connection then
			return
		end
		v4 = nil
		n6 = 0

		connection = RunService.Heartbeat:Connect(function()
			if not cframe then
				return
			end
			local v5 = fn5()
			if not v5 then
				v4 = nil
				return
			end
			local v6 = fn6()
			if not v6 or v6.Health <= 0 then
				v4 = nil
				return
			end
			local position = v5.Position

			if v4 and (position - v4).Magnitude > nightDungeonConfig.JumpThreshold then
				fn25()
				cframe = CFrame.new(position.X, position.Y + nightDungeonConfig.HoverHeight, position.Z)
				v4 = position
				return
			end

			v4 = position

			if v5.AssemblyAngularVelocity.Magnitude > 0.05 then
				v5.AssemblyAngularVelocity = Vector3.zero
			end

			if v6:GetState() ~= physics then
				v6:ChangeState(physics)
			end

			local now = os.clock()
			if now - n6 < 0.1 then
				return
			end
			n6 = now

			if v6.PlatformStand then
				v6.PlatformStand = false
			end

			local head = v5.Parent and (v5.Parent:FindFirstChild("Head") or v5)

			if head and not head:FindFirstChild("NightVelocity") then
				fn27(true)
			end

			fn28(cframe)
		end)
	elseif connection then
		connection:Disconnect()
		connection = nil
		fn25()
		v4 = nil
	end
end

local flag4 = false
local position = nil
local n7 = -100

local function fn30()
	local v5 = fn5()

	if v5 and v5.Position.Y > n7 then
		position = v5.Position
	end
end

local function fn31()
	local map = Workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Simulation Hub")
	map = map and map:FindFirstChild("Pads")

	if map then
		for _, child in ipairs(map:GetChildren()) do
			local pad = child:FindFirstChild("Pad")
			if pad and pad:IsA("BasePart") then
				return pad.Position
			end
		end
	end

	local spawnLocation = Workspace:FindFirstChild("SpawnLocation", true)
	if spawnLocation and spawnLocation:IsA("BasePart") then
		return spawnLocation.Position
	end

	for _, child in ipairs(Workspace:GetChildren()) do
		if child:IsA("BasePart") and child.Anchored and child.Position.Y > n7 then
			return child.Position
		end
	end

	return nil
end

local function fn32(arg)
	local v5 = fn5()
	if not v5 then
		return
	end

	if flag4 and cframe and connection and not arg then
		fn26(true)
		fn27(true)
		return
	end

	fn25()
	local position2 = v5.Position

	if position2.Y < n7 then
		position2 = position or fn31() or position2
	end

	cframe = CFrame.new(position2.X, position2.Y + nightDungeonConfig.HoverHeight, position2.Z)
	fn27(true)
	fn29(true)
	fn26(true)
	flag4 = true
	fn3("Treo cao")
end

local function fn33(arg)
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

local function fn34(arg)
	local v5 = fn33(arg)
	if not v5 then
		return false
	end
	local v6 = fn5()
	local v7 = fn6()
	if not v6 or not v7 or v7.Health <= 0 then
		fn25()
		return false
	end

	if v7.Sit then
		v7.Sit = false
	end

	fn26(true)
	fn27(true)
	flag4 = false

	if not cframe or (cframe.Position - v5.Position).Magnitude > 1 then
		cframe = v5
	end

	fn29(true)
	return (v5.Position - v6.Position).Magnitude <= nightDungeonConfig.ArriveDistance
end

local tbl5 = { "Melee", "Sword", "Blox Fruit", "Gun" }

local function fn35(arg)
	local v5 = fn4()
	local v6 = fn7()

	local function fn36(arg2)
		for _, v7 in ipairs(arg2) do
			if v7:IsA("Tool") and v7.ToolTip == arg then
				return v7.Name
			end
		end

		return nil
	end

	if v6 then
		local v7 = fn36(v6:GetChildren())
		if v7 then
			return v7
		end
	end

	if v5 then
		return (fn36(v5:GetChildren()))
	end
	return nil
end

local function fn36()
	local v5 = fn35(nightDungeonConfig.Weapon)
	if v5 then
		return v5, nightDungeonConfig.Weapon
	end

	for _, v6 in ipairs(tbl5) do
		local v7 = fn35(v6)
		if v7 then
			return v7, v6
		end
	end

	return nil, nil
end

local function fn37()
	local v5 = fn4()
	local humanoid = v5 and v5:FindFirstChildOfClass("Humanoid")
	if not humanoid then
		return
	end
	local v6 = fn36()
	if not v6 then
		return
	end
	local tool = v5:FindFirstChildOfClass("Tool")
	if tool and tool.Name == v6 then
		return
	end
	local v7 = fn7()
	v7 = v7 and v7:FindFirstChild(v6)

	if v7 then
		humanoid:EquipTool(v7)
	end
end

local n8 = 0

local function fn38()
	local v5 = fn4()
	if not v5 or v5:FindFirstChild("HasBuso") then
		return
	end

	if os.clock() - n8 < 4 then
		return
	end
	n8 = os.clock()

	pcall(function()
		commF:InvokeServer("Buso")
	end)
end

local tbl6 = {}
local n9 = 0
local n10 = 0

local function fn39()
	n9 = 0
	n10 = 0
end

local function fn40()
	if os.clock() - n9 < 3 and #tbl6 > 0 then
		return
	end
	n9 = os.clock()
	local tbl7 = {}
	local tbl8 = {}

	local function fn41(arg)
		if arg and arg.Parent and not tbl8[arg] then
			tbl8[arg] = true
			tbl7[#tbl7 + 1] = arg
		end
	end

	fn41(Workspace:FindFirstChild("Enemies"))
	fn41(Workspace:FindFirstChild("Characters"))

	for _, child in ipairs(Workspace:GetChildren()) do
		if child:IsA("Folder") or child:IsA("Model") then
			local name = child.Name

			if name:find("Enem") or name:find("Mob") or name:find("Monster") or name:find("Spawn") then
				fn41(child)
			end
		end
	end

	for _, v5 in ipairs(tbl6) do
		fn41(v5)
	end

	if os.clock() - n10 > 12 then
		n10 = os.clock()
		local v5 = fn12()

		if v5 then
			for _, child in ipairs(v5:GetChildren()) do
				for _, descendant in ipairs(child:GetDescendants()) do
					if descendant:IsA("Humanoid") then
						local parent = descendant.Parent

						if parent and parent:IsA("Model") then
							fn41(parent.Parent)
						end
					end
				end
			end
		end
	end

	tbl6 = tbl7
end

local function fn41(arg)
	if not arg or not arg.Parent then
		return false
	end

	if arg:FindFirstChild("VehicleSeat") then
		return false
	end
	local humanoid = arg:FindFirstChild("Humanoid")
	if not humanoid or humanoid.Health <= 0 then
		return false
	end
	return arg:FindFirstChild("HumanoidRootPart") ~= nil
end

local tbl7 = {}
local n11 = 0

local function fn42()
	if os.clock() - n11 < 0.3 then
		return tbl7
	end
	n11 = os.clock()
	fn40()
	local tbl8 = {}
	local tbl9 = {}

	for _, v5 in ipairs(tbl6) do
		if v5.Parent then
			for _, child in ipairs(v5:GetChildren()) do
				if child:IsA("Model") and not tbl9[child] and fn41(child) and not Players:GetPlayerFromCharacter(child) then
					tbl9[child] = true
					tbl8[#tbl8 + 1] = child
				end
			end
		end
	end

	tbl7 = tbl8
	return tbl8
end

local function fn43(arg)
	if arg:GetAttribute("IsBoss") or arg:GetAttribute("Boss") then
		return true
	end

	if arg.Name:find("Boss") or arg.Name:find("Zero") then
		return true
	end
	local humanoid = arg:FindFirstChild("Humanoid")
	return humanoid ~= nil and humanoid.MaxHealth >= 250000
end

local function fn44(arg)
	if arg.Name == "PropHitboxPlaceholder" then
		return true
	end
	local head = arg:FindFirstChild("Head")
	local humanoidRootPart = arg:FindFirstChild("HumanoidRootPart")
	if head and humanoidRootPart and head:IsA("BasePart") and humanoidRootPart:IsA("BasePart") and head.Size.Y <= 0.5 and humanoidRootPart.Size.X >= 6 then
		local humanoid = arg:FindFirstChild("Humanoid")
		return humanoid ~= nil and humanoid.MaxHealth > 0 and humanoid.MaxHealth <= nightDungeonConfig.PropMaxHP
	end
	return false
end

local v5 = nil
local n12 = 0
local n13 = 0

local function fn45(arg)
	local humanoid = arg and arg.Parent and arg:FindFirstChild("Humanoid")
	if not humanoid then
		v5 = nil
		return false
	end

	if arg ~= v5 then
		v5 = arg
		n12 = humanoid.Health
		n13 = os.clock()
		return false
	end

	if humanoid.Health < n12 - 1 then
		n12 = humanoid.Health
		n13 = os.clock()
		return false
	end

	local stallTime = nightDungeonConfig.StallTime
	return os.clock() - n13 > stallTime
end

local function fn46()
	local v6 = fn5()
	if not v6 then
		return nil
	end
	local v7 = fn42()
	if #v7 == 0 then
		return nil
	end
	local huge = math.huge
	local v8 = nil
	local huge2 = math.huge
	local v9 = nil
	local huge3 = math.huge
	local v10 = nil

	for _, v11 in ipairs(v7) do
		local humanoidRootPart = v11.Parent and v11:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart then
			local magnitude = (humanoidRootPart.Position - v6.Position).Magnitude

			if fn44(v11) then
				if magnitude < huge then
					huge = magnitude
					v8 = v11
				end
			elseif fn43(v11) then
				if magnitude < huge2 then
					huge2 = magnitude
					v9 = v11
				end
			elseif magnitude < huge3 then
				huge3 = magnitude
				v10 = v11
			end
		end
	end

	local flag5 = v10 and huge3 <= nightDungeonConfig.HitRadius
	local flag6 = false

	if not flag5 then
		if v9 then
			flag6 = true
			v10 = v9
		end
	end

	if v8 and huge <= nightDungeonConfig.PropRadius then
		if v10 == nil or fn45(v10) then
			return v8, false, true
		end
	else
		fn45(v10)
	end

	return v10, flag6, false
end

local flag5 = false
local n14 = 0

local function fn47()
	local v6 = fn4()
	if not v6 then
		return
	end
	local tool = v6:FindFirstChildOfClass("Tool")
	if not tool then
		return
	end
	local humanoidRootPart = v6:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
		return
	end
	local tbl8 = {}
	local hitRadius = nightDungeonConfig.HitRadius

	for _, v7 in ipairs(fn42()) do
		local humanoidRootPart2 = v7.Parent and v7:FindFirstChild("HumanoidRootPart")

		if humanoidRootPart2 and (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude <= hitRadius then
			tbl8[#tbl8 + 1] = { v7, humanoidRootPart2 }
		end
	end

	if #tbl8 == 0 then
		return
	end
	local toolTip = tool.ToolTip

	if toolTip == "Blox Fruit" then
		local leftClickRemote = tool:FindFirstChild("LeftClickRemote")

		if leftClickRemote and leftClickRemote:IsA("RemoteEvent") then
			leftClickRemote:FireServer(Vector3.new(0, -500, 0), math.random(1, 4), true)
			task.wait(0.01)
			leftClickRemote:FireServer(false)
		end

		return
	end

	if toolTip == "Melee" or toolTip == "Sword" then
		reRegisterAttack:FireServer(0)
		reRegisterHit:FireServer(tbl8[1][2], tbl8)
	end
end

task.spawn(function()
	while not flag do
		if flag5 and state.FastAttack then
			if os.clock() - n14 > 1.2 then
				flag5 = false
				task.wait(0.25)
			else
				pcall(fn47)
				task.wait(nightDungeonConfig.AttackDelay)
			end
		else
			task.wait(0.25)
		end
	end
end)

local obj = setmetatable({}, { __mode = "k" })

local function fn48(arg)
	if obj[arg] then
		return
	end
	obj[arg] = true
	local humanoid = arg:FindFirstChild("Humanoid")
	if not humanoid then
		return
	end
	local connection3 = nil

	connection3 = humanoid.Died:Connect(function()
		state.Kills = state.Kills + 1
		connection3:Disconnect()
	end)
end

local function fn49(arg, arg2)
	if not fn41(arg) then
		return false
	end
	fn48(arg)
	local v6 = fn6()
	if not v6 then
		return false
	end

	if v6.Sit then
		v6.Sit = false
	end

	arg2 = arg2 and nightDungeonConfig.BossKillHeight or nightDungeonConfig.KillHeight
	local tool = fn4() and fn4():FindFirstChildOfClass("Tool")

	if tool and tool.ToolTip == "Blox Fruit" then
		arg2 = 15
	end

	fn34(arg.HumanoidRootPart.CFrame * CFrame.new(-3, arg2, 0))
	fn37()
	fn38()
	flag5 = true
	n14 = os.clock()
	return true
end

local n15 = 0

local function fn50()
	local v6
	v6, v6 = fn36()
	return tbl2[v6 or nightDungeonConfig.Weapon] or {}
end

local function fn51(arg)
	for i, v6 in ipairs(tbl) do
		if v6 == arg then
			return i
		end
	end

	local v6 = fn50()

	for i, v7 in ipairs(v6) do
		if v7 == arg then
			return #tbl + i
		end
	end

	return 999
end

local function fn52(arg)
	local huge = math.huge
	local buffName = nil

	for _, v6 in ipairs(arg) do
		local buffName2 = type(v6) == "table" and v6.buffName or nil

		if buffName2 then
			local v7 = fn51(buffName2)

			if v7 < huge then
				huge = v7
				buffName = buffName2
			end
		end
	end

	if not buffName and arg[1] then
		buffName = arg[1].buffName
	end

	return buffName
end

local function fn53()
	if os.clock() - n15 < 1 then
		return
	end
	n15 = os.clock()
	local buffSelector = dungeonShared:FindFirstChild("BuffSelector")
	if not buffSelector or not buffSelector:IsA("RemoteFunction") then
		return
	end

	buffSelector.OnClientInvoke = function(arg)
		if not state.AutoBuff or type(arg) ~= "table" then
			return nil
		end
		local chonThe = fn52(arg)
		if not chonThe then
			return nil
		end
		fn2("chon the: " .. chonThe)
		task.wait(nightDungeonConfig.BuffDelay)
		return chonThe
	end
end

local connection3 = nil

local function fn54()
	if connection3 then
		return
	end
	local buffReplicator = dungeonShared:FindFirstChild("BuffReplicator")
	if not buffReplicator or not buffReplicator:IsA("RemoteEvent") then
		return
	end

	connection3 = buffReplicator.OnClientEvent:Connect(function(buffs)
		if type(buffs) == "table" then
			state.Buffs = buffs
		end
	end)
end

local function fn55()
	return 1 + (tonumber(state.Buffs.AttackSpeedMultiplier) or 0)
end

local function fn56()
	local lifesteal = state.Buffs.Lifesteal
	local n16 = 0

	for k in pairs(state.Buffs) do
		n16 += 1
	end

	return string.format("%d the | Leech %.0f%%", n16, (tonumber(lifesteal) or 0) * 100)
end

local function fn57()
	local map = Workspace:FindFirstChild("Map")
	map = map and map:FindFirstChild("Simulation Hub")
	map = map and map:FindFirstChild("Pads")
	if not map then
		return {}
	end
	local tbl8 = {}

	for _, child in ipairs(map:GetChildren()) do
		if child:FindFirstChild("DungeonSettingsChanged") and child:FindFirstChild("Pad") then
			tbl8[#tbl8 + 1] = child
		end
	end

	table.sort(tbl8, function(arg, arg2)
		return arg.Name < arg2.Name
	end)

	return tbl8
end

local function fn58(arg)
	return arg:GetAttribute("NumPlayersOnPad") or 0, arg:GetAttribute("MaxPlayers") or 4, arg:GetAttribute("Initiator")
end

local v6 = nil
local n16 = 0

local function fn59()
	local v7 = fn57()
	if #v7 == 0 then
		v6 = nil
		return nil
	end
	local n17 = -1
	local n18 = 0
	local v8 = nil

	for _, v9 in ipairs(v7) do
		local v10, v11, v12 = fn58(v9)

		if v10 < v11 then
			local n19 = v10 * 4

			if v12 == localPlayer.UserId then
				n19 += 2
			elseif v12 == nil then
				n19 += 1
			end

			if n17 < n19 then
				n17 = n19
				n18 = v10
				v8 = v9
			end
		end
	end

	if v6 and v6.Parent then
		local v9, v10 = fn58(v6)
		if v9 < v10 and (os.clock() < n16 or n18 <= v9 + 1) then
			return v6
		end
	end

	if v8 then
		if v8 ~= v6 then
			n16 = os.clock() + 6
		end

		v6 = v8
	end

	return v6 or v7[1]
end

local n17 = 0
local n18 = 0

local function fn60()
	return math.max(0, tonumber(nightDungeonConfig.EnergyCost) or 0)
end

local function fn61()
	local v7 = fn59()
	if not v7 then
		fn3("Khong thay pad")
		return
	end
	local pad = v7:FindFirstChild("Pad")
	if not pad then
		return
	end

	if not fn5() then
		return
	end

	if not localPlayer:FindFirstChild("TeleporterPadObjectReference") then
		local v8, v9 = fn58(v7)
		fn3("Di den pad " .. v7.Name .. " (" .. v8 .. "/" .. v9 .. ")")
		fn34(pad.CFrame * CFrame.new(0, 4, 0))
		return
	end

	if localPlayer:GetAttribute("IsTeleporting") or v7:GetAttribute("PreparingToTeleport") then
		fn3("Dang vao dungeon...")
		return
	end
	local dungeonSettingsChanged = v7:FindFirstChild("DungeonSettingsChanged")
	local userId = localPlayer.UserId
	local flag6 = v7:GetAttribute("Initiator") == userId

	if flag6 then
		local difficulty = nightDungeonConfig.Difficulty
		flag6 = v7:GetAttribute("Difficulty") ~= difficulty
	end

	if flag6 then
		if os.clock() - n17 > 2 then
			n17 = os.clock()
			dungeonSettingsChanged:FireServer("Difficulty", nightDungeonConfig.Difficulty)
			fn2("dat difficulty " .. nightDungeonConfig.Difficulty)
		end

		return
	end

	local attribute = v7:GetAttribute("NumPlayersOnPad") or 0
	local attribute2 = v7:GetAttribute("MinPlayers") or 1
	if attribute < attribute2 then
		fn3(string.format("Cho nguoi %d/%d", attribute, attribute2))
		return
	end
	local v8 = fn60()
	if v8 > 0 and state.Energy < v8 then
		fn3("Het energy " .. state.Energy .. "/" .. v8)
		return
	end

	if os.clock() - n18 > 4 then
		n18 = os.clock()
		fn3("Bam Start")
		dungeonSettingsChanged:FireServer("Start")
		fn2("fire Start tren " .. v7.Name)
	end
end

local function fn62()
	local v7 = fn11()

	if not v7 then
		state.Floor = 0
		state.Total = 0
		state.Dead = 0
		state.TimeLeft = 0
		return nil
	end

	local attribute = v7:GetAttribute("CurrentExploredLevel") or 0

	if attribute ~= state.Floor then
		fn39()
	end

	state.Floor = attribute
	state.Dead = v7:GetAttribute("DeadEnemies") or 0
	state.Total = v7:GetAttribute("TotalEnemies") or 0
	state.TimeLeft = v7:GetAttribute("TimeLeft") or 0
	local floors = v7:FindFirstChild("Floors")

	if floors then
		local maxFloor = 0

		for _, child in ipairs(floors:GetChildren()) do
			local num = tonumber(child.Name)

			if num and num > maxFloor then
				maxFloor = num
			end
		end

		state.MaxFloor = maxFloor
	end

	return v7
end

local function fn63(arg)
	if not arg then
		return false
	end
	local floors = arg:FindFirstChild("Floors")
	if not floors then
		return arg:GetAttribute("HasBoss") == true
	end
	local v7 = floors:FindFirstChild(tostring(state.Floor))
	return v7 ~= nil and v7:GetAttribute("HasBoss") == true
end

local flag6 = false
local tbl8 = {}

local function fn64()
	for _, v7 in ipairs({ "ResultsScreen", "ReturnToHub" }) do
		if not tbl8[v7] then
			local v8 = dungeonShared:FindFirstChild(v7)

			if v8 and v8:IsA("RemoteEvent") then
				tbl8[v7] = v8.OnClientEvent:Connect(function()
					flag6 = true
					flag5 = false
					fn2("dungeon ket thuc (" .. v7 .. ")")
				end)
			end
		end
	end
end

local function fn65()
	local v7 = fn62()
	fn53()
	fn54()
	fn64()

	if flag6 then
		fn3("Xong, cho ve hub")
		fn32()
		return
	end

	local v8 = fn6()
	if not v8 or v8.Health <= 0 then
		fn3("Cho hoi sinh")
		return
	end
	local v9, v10, v11 = fn46()

	if v9 then
		local v12 = fn5()
		local humanoidRootPart = v9:FindFirstChild("HumanoidRootPart") or v9.PrimaryPart
		state.Target = (v11 and "PART " or v10 and "BOSS " or "") .. v9.Name
		state.Dist = v12 and humanoidRootPart and math.floor((humanoidRootPart.Position - v12.Position).Magnitude) or -1

		if v11 then
			fn3("Pha part chan duong (" .. state.Dist .. "m)")
		else
			fn3(v10 and "Danh BOSS " .. v9.Name or "Danh " .. v9.Name)
		end

		fn49(v9, v10)
		return
	end

	flag5 = false
	state.Target = "-"
	state.Dist = -1
	local floor = state.Floor
	local v12 = fn17()
	state.Here = v12 or -1

	if v12 then
		local exitTeleporter = fn18(v12, "ExitTeleporter")

		if fn19(exitTeleporter) then
			local magnitude = fn5()
			magnitude = magnitude and (exitTeleporter.Position - magnitude.Position).Magnitude or 9999
			fn3("Vao cua tang " .. v12 .. " -> " .. v12 + 1 .. " " .. math.floor(magnitude) .. "m")

			if magnitude <= nightDungeonConfig.DoorTouch then
				fn20(exitTeleporter)
			end

			fn34(exitTeleporter.CFrame)
			return
		end

		if floor and floor > v12 then
			local entranceTeleporter = fn18(v12 + 1, "EntranceTeleporter")

			if entranceTeleporter then
				fn3("Theo cua sang tang " .. v12 + 1)
				fn34(entranceTeleporter.CFrame * CFrame.new(0, 10, 0))
				return
			end
		end
	end

	local v13 = fn13(v12) or fn13(floor) or fn13(fn15())

	if v13 then
		local v14 = fn14(v13)

		if v14 then
			local attribute = v13:GetAttribute("DisplayName") or v13.Name
			local magnitude = fn5()
			magnitude = magnitude and (v14.Position - magnitude.Position).Magnitude or 0

			if fn63(v7) then
				local v15 = fn3
				local v16 = tostring
				v12 = v12 or floor
				v15("Quet tang boss " .. v16(v12) .. " (" .. tostring(attribute) .. ")")
			else
				fn3("Quet tang " .. tostring(v12 or floor) .. " (" .. tostring(attribute) .. ") " .. math.floor(magnitude) .. "m")
			end

			fn34(v14)
			return
		end
	end

	fn3("Cho tang moi load")
	fn32()
end

local flag7 = false

local function fn66()
	state.Energy = fn22()
	fn30()
	local v7 = fn5()

	if v7 and v7.Position.Y < n7 and state.Farm then
		n5 = os.clock() + 3
		fn32(true)
		fn2("roi khoi map, keo len lai")
		return
	end

	if not state.Farm then
		flag5 = false
		fn29(false)
		fn26(false)
		fn27(false)
		flag4 = false
		fn3("Idle")
		return
	end

	if fn9() then
		if not flag7 then
			flag7 = true
			state.Runs = state.Runs + 1
			state.Dead = 0
			flag6 = false
			n15 = 0
			fn2("vao dungeon, luot #" .. state.Runs)
		end

		fn65()
		return
	end

	if flag7 then
		flag7 = false
		flag6 = false

		if connection3 then
			connection3:Disconnect()
			connection3 = nil
		end

		for k, v8 in pairs(tbl8) do
			v8:Disconnect()
			tbl8[k] = nil
		end

		state.Buffs = {}
	end

	if fn8() then
		local v8 = fn60()
		state.EnergyNeed = v8

		if nightDungeonConfig.OutOnEmpty and v8 > 0 and state.Energy < v8 then
			fn32()
			fn24(state.Energy, v8)
			return
		end

		if state.AutoStart then
			fn61()
		else
			fn32()
			fn3("Trong sanh")
		end

		return
	end

	fn32()
	fn3("Khong phai map Dungeons")
end

task.spawn(function()
	while not flag do
		local ok, result = pcall(fn66)

		if not ok then
			fn2("loi tick: " .. tostring(result))
		end

		task.wait(0.25)
	end
end)

local connection4 = localPlayer.CharacterAdded:Connect(function(character)
	character:WaitForChild("HumanoidRootPart", 10)
	task.wait(1)
	flag5 = false

	if state.Farm then
		fn32()
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")

	if humanoid then
		humanoid.Died:Connect(function()
			flag5 = false
			fn2("chet, cho respawn")
		end)
	end
end)

local v7 = fn6()

if v7 then
	v7.Died:Connect(function()
		flag5 = false
		fn2("chet, cho respawn")
	end)
end

local tbl9 = {
	Shell = Color3.fromRGB(13, 14, 22),
	Panel = Color3.fromRGB(21, 23, 35),
	Card = Color3.fromRGB(27, 30, 46),
	Head = Color3.fromRGB(17, 18, 28),
	Line = Color3.fromRGB(52, 58, 84),
	Gold = Color3.fromRGB(167, 139, 250),
	Violet = Color3.fromRGB(139, 124, 255),
	Cyan = Color3.fromRGB(94, 234, 212),
	Pink = Color3.fromRGB(244, 114, 182),
	Text = Color3.fromRGB(234, 238, 248),
	Sub = Color3.fromRGB(132, 141, 168),
	On = Color3.fromRGB(52, 211, 153),
	Off = Color3.fromRGB(248, 113, 113),
	Warn = Color3.fromRGB(251, 191, 36),
	Btn = Color3.fromRGB(46, 52, 78),
	BtnAlt = Color3.fromRGB(35, 40, 60),
}

local tbl10 = { Shell = 0.08, Panel = 0.1, Head = 0.07 }

local function fn67(arg, arg2, arg3)
	local instance = Instance.new(arg)
	local v8 = pairs
	local tbl11 = arg2 or {}

	for k, v9 in v8(tbl11) do
		if k ~= "Parent" then
			instance[k] = v9
		end
	end

	local v9 = ipairs
	arg3 = arg3 or {}

	for _, v10 in v9(arg3) do
		v10.Parent = instance
	end

	if arg2 and arg2.Parent then
		instance.Parent = arg2.Parent
	end

	return instance
end

local function fn68(arg)
	return fn67("UICorner", { CornerRadius = UDim.new(0, arg) })
end

local function fn69(arg, arg2, arg3)
	return fn67("UIStroke", {
		Color = arg,
		Thickness = arg2 or 1,
		Transparency = arg3 or 0,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local quart = Enum.EasingStyle.Quart
local back = Enum.EasingStyle.Back

local function fn70(arg, arg2, arg3, arg4, arg5)
	local tween2 = TweenService:Create(arg, TweenInfo.new(arg2, arg4 or quart, arg5 or Enum.EasingDirection.Out), arg3)
	tween2:Play()
	return tween2
end

local function fn71(arg, arg2, arg3, arg4, arg5)
	local tween2 = TweenService:Create(arg, TweenInfo.new(arg2, arg5 or Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, arg4 and true or false), arg3)
	tween2:Play()
	return tween2
end

local function fn72(arg, arg2, arg3, arg4)
	local tbl11

	if arg4 then
		tbl11 = {}
		local v8 = ColorSequenceKeypoint.new(0, arg2)
		local v9 = ColorSequenceKeypoint.new(0.5, arg3)
		tbl11[1] = v8
		tbl11[2] = v9

		do
			local values = table.pack(ColorSequenceKeypoint.new(1, arg4))
			table.move(values, 1, values.n, 3, tbl11)
		end
	else
		tbl11 = arg4
	end

	if not tbl11 then
		local new = ColorSequenceKeypoint.new
		tbl11 = { ColorSequenceKeypoint.new(0, arg2), new(1, arg3) }
	end

	return fn67("UIGradient", { Color = ColorSequence.new(tbl11), Rotation = arg or 0 })
end

local tbl11 = {}

local function fn73()
	local ok, result = pcall(function()
		return gethui()
	end)

	if not (ok and typeof(result) == "Instance") then
		result = localPlayer:WaitForChild("PlayerGui")
	end

	local ScreenGui = fn67("ScreenGui", {
		Name = "NightDungeonUI",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 999,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = result,
	})

	tbl11.Screen = ScreenGui
	local n19 = 528
	local n20 = 328

	local function fn74(arg, arg2, arg3, arg4)
		local v8 = fn67

		local tbl12 = {
			Name = "Shadow",
			BackgroundTransparency = 1,
			Image = "rbxassetid://6014261993",
			ImageColor3 = arg4 or Color3.new(0, 0, 0),
			ImageTransparency = 1,
			ScaleType = Enum.ScaleType.Slice,
			SliceCenter = Rect.new(49, 49, 450, 450),
			Size = UDim2.new(0, n19 + arg, 0, n20 + arg),
			Position = UDim2.new(0.5, 0, 0.5, arg2),
		}

		tbl12.AnchorPoint = Vector2.new(0.5, 0.5)
		tbl12.ZIndex = 0
		tbl12.Parent = ScreenGui
		return v8("ImageLabel", tbl12), arg3
	end

	local v8, v9 = fn74(150, 20, 0.72)
	local v10, v11 = fn74(70, 10, 0.34)
	local v12, v13 = fn74(108, 0, 0.88, tbl9.Violet)
	local shadows = { { v8, v9 }, { v10, v11 }, { v12, v13 } }
	tbl11.Shadows = shadows

	local Frame = fn67("Frame", {
		Name = "Root",
		BackgroundColor3 = tbl9.Shell,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 528, 0, 328),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Parent = ScreenGui,
	}, { fn68(18) })

	tbl11.Root = Frame
	local UIScale = fn67("UIScale", { Scale = 0.92, Parent = Frame })
	tbl11.Scale = UIScale

	local UIStroke = fn67("UIStroke", {
		Color = tbl9.Line,
		Thickness = 1.4,
		Transparency = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Parent = Frame,
	})

	fn72(90, tbl9.Violet, tbl9.Line, tbl9.Cyan).Parent = UIStroke
	tbl11.Edge = UIStroke

	Frame:GetPropertyChangedSignal("Position"):Connect(function()
		for _, shadow in ipairs(shadows) do
			shadow[1].Position = UDim2.new(Frame.Position.X.Scale, Frame.Position.X.Offset, Frame.Position.Y.Scale, Frame.Position.Y.Offset + (shadow[1] == v8 and 20 or shadow[1] == v10 and 10 or 0))
		end
	end)

	local Frame2 = fn67("Frame", {
		Name = "Header",
		BackgroundColor3 = tbl9.Head,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 48),
		Parent = Frame,
	}, { fn68(18) })

	tbl11.Header = Frame2

	local Frame3 = fn67("Frame", {
		BackgroundColor3 = tbl9.Head,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 18),
		Position = UDim2.new(0, 0, 1, -18),
		Parent = Frame2,
	})

	local Frame4 = fn67("Frame", {
		BackgroundColor3 = tbl9.Violet,
		BackgroundTransparency = 0.94,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Parent = Frame2,
	}, { fn68(18) })

	local v14 = fn72(0, tbl9.Head, tbl9.Violet, tbl9.Head)
	local numberSequence = NumberSequence.new
	local tbl12 = {}
	local v15 = NumberSequenceKeypoint.new(0, 1)
	local v16 = NumberSequenceKeypoint.new(0.5, 0.55)
	tbl12[1] = v15
	tbl12[2] = v16

	do
		local values = table.pack(NumberSequenceKeypoint.new(1, 1))
		table.move(values, 1, values.n, 3, tbl12)
	end

	v14.Transparency = numberSequence(tbl12)
	v14.Offset = Vector2.new(-1.2000000476837158, 0)
	v14.Parent = Frame4
	TweenService:Create(v14, TweenInfo.new(4.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 2.5), { Offset = Vector2.new(1.2000000476837158, 0) }):Play()

	local Frame5 = fn67("Frame", {
		BackgroundColor3 = tbl9.Violet,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, -28, 0, 2),
		Position = UDim2.new(0, 14, 1, -1),
		Parent = Frame2,
	}, { fn68(2) })

	local v17 = fn72(0, tbl9.Violet, tbl9.Cyan, tbl9.Pink)
	v17.Parent = Frame5
	fn71(v17, 6, { Offset = Vector2.new(0.60000002384185791, 0) }, true)
	tbl11.AccentBar = Frame5

	local TextLabel = fn67("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -120, 0, 22),
		Position = UDim2.new(0, 15, 0, 5),
		Font = Enum.Font.GothamBold,
		Text = "Night Hub  ·  Kaitun Dungeon",
		TextColor3 = Color3.fromRGB(255, 255, 255),
		TextSize = 15,
		TextXAlignment = Enum.TextXAlignment.Left,
		Parent = Frame2,
	})

	local v18 = fn72(0, tbl9.Violet, tbl9.Cyan, tbl9.Pink)
	v18.Parent = TextLabel
	fn71(v18, 5, { Offset = Vector2.new(0.34999999403953552, 0) }, true)
	tbl11.Title = TextLabel

	local TextLabel2 = fn67("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -120, 0, 15),
		Position = UDim2.new(0, 15, 0, 26),
		Font = Enum.Font.Gotham,
		Text = "Idle",
		TextColor3 = tbl9.Sub,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = Frame2,
	})

	tbl11.Sub = TextLabel2

	TextLabel2:GetPropertyChangedSignal("Text"):Connect(function()
		TextLabel2.TextTransparency = 0.7
		fn70(TextLabel2, 0.3, { TextTransparency = 0 })
	end)

	local function fn75(arg, arg2, arg3, arg4)
		local TextButton = fn67("TextButton", {
			BackgroundColor3 = arg3,
			BackgroundTransparency = 0.25,
			BorderSizePixel = 0,
			AutoButtonColor = false,
			Size = UDim2.new(0, 28, 0, 24),
			Position = UDim2.new(1, arg2, 0, 12),
			Font = Enum.Font.GothamBold,
			Text = arg,
			TextColor3 = tbl9.Sub,
			TextSize = 13,
			Parent = Frame2,
		}, { fn68(9) })

		TextButton.MouseEnter:Connect(function()
			fn70(TextButton, 0.16, { BackgroundTransparency = 0, TextColor3 = tbl9.Text, Size = UDim2.new(0, 30, 0, 26) })
		end)

		TextButton.MouseLeave:Connect(function()
			fn70(TextButton, 0.22, { BackgroundTransparency = 0.25, TextColor3 = tbl9.Sub, Size = UDim2.new(0, 28, 0, 24) })
		end)

		TextButton.MouseButton1Down:Connect(function()
			fn70(TextButton, 0.08, { Size = UDim2.new(0, 25, 0, 21) })
		end)

		TextButton.MouseButton1Click:Connect(function()
			fn70(TextButton, 0.18, { Size = UDim2.new(0, 30, 0, 26) }, back)
			arg4()
		end)

		return TextButton
	end

	local Frame6 = fn67("Frame", {
		Name = "Body",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 1, -106),
		Position = UDim2.new(0, 12, 0, 56),
		Parent = Frame,
	})

	tbl11.Body = Frame6
	local UIScale2 = fn67("UIScale", { Scale = 1, Parent = Frame6 })
	local flag8 = false

	fn75("X", -38, tbl9.Off, function()
		nightDungeon.Stop()
	end)

	fn75("–", -72, tbl9.Btn, function()
		flag8 = not flag8
		local n21 = flag8 and 48 or 328

		if flag8 then
			fn70(UIScale2, 0.16, { Scale = 0.94 })
			fn70(tbl11.Footer, 0.16, { Position = UDim2.new(0, 12, 1, -30) })

			task.delay(0.14, function()
				if flag8 then
					Frame6.Visible = false
					tbl11.Footer.Visible = false
				end
			end)
		else
			Frame6.Visible = true
			tbl11.Footer.Visible = true
			UIScale2.Scale = 0.94
			fn70(UIScale2, 0.3, { Scale = 1 }, back)
			fn70(tbl11.Footer, 0.3, { Position = UDim2.new(0, 12, 1, -44) })
		end

		fn70(Frame, 0.32, { Size = UDim2.new(0, 528, 0, n21) })

		for _, shadow in ipairs(shadows) do
			local n22 = shadow[1].Size.X.Offset - n19
			fn70(shadow[1], 0.32, { Size = UDim2.new(0, n19 + n22, 0, n21 + n22) })
		end
	end)

	local function fn76(arg, arg2, arg3, arg4)
		local line = tbl9.Line

		local Frame7 = fn67("Frame", {
			BackgroundColor3 = tbl9.Panel,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(0, arg2, 1, 0),
			Position = UDim2.new(0, arg, 0, 0),
			Parent = Frame6,
		}, { fn68(14), fn69(line, 1, 0.55) })

		fn70(Frame7, 0.45, { BackgroundTransparency = tbl10.Panel })

		fn67("Frame", {
			BackgroundColor3 = arg4,
			BorderSizePixel = 0,
			Size = UDim2.new(0, 3, 0, 14),
			Position = UDim2.new(0, 10, 0, 9),
			Parent = Frame7,
		}, { fn68(2) })

		fn67("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -28, 0, 20),
			Position = UDim2.new(0, 20, 0, 6),
			Font = Enum.Font.GothamBold,
			Text = arg3,
			TextColor3 = arg4,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = Frame7,
		})

		local Frame8 = fn67("Frame", {
			BackgroundColor3 = tbl9.Line,
			BorderSizePixel = 0,
			BackgroundTransparency = 0.3,
			Size = UDim2.new(1, -20, 0, 1),
			Position = UDim2.new(0, 10, 0, 28),
			Parent = Frame7,
		})

		local v19 = fn72(0, arg4, tbl9.Line)
		local new = NumberSequenceKeypoint.new
		v19.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), new(1, 0.85) })
		v19.Parent = Frame8

		return Frame7, (fn67("Frame", {
			BackgroundTransparency = 1,
			Size = UDim2.new(1, -20, 1, -40),
			Position = UDim2.new(0, 10, 0, 34),
			Parent = Frame7,
		}, {
			fn67("UIListLayout", {
				FillDirection = Enum.FillDirection.Vertical,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 3),
			}),
		}))
	end

	local dungeon, v19 = fn76(0, 246, "Dungeon", tbl9.Violet)
	local kaitun, v20 = fn76(256, 246, "Kaitun", tbl9.Cyan)
	local rows = {}

	local function fn77(arg, arg2, arg3, arg4)
		local Frame7 = fn67("Frame", {
			BackgroundColor3 = tbl9.Violet,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 0, 19),
			Parent = arg,
		}, { fn68(6) })

		fn67("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.46, 0, 1, 0),
			Font = Enum.Font.Gotham,
			Text = arg3,
			TextColor3 = tbl9.Sub,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = Frame7,
		})

		local TextLabel3 = fn67("TextLabel", {
			BackgroundTransparency = 1,
			Size = UDim2.new(0.54, 0, 1, 0),
			Position = UDim2.new(0.46, 0, 0, 0),
			Font = Enum.Font.GothamMedium,
			Text = "-",
			TextColor3 = tbl9.Text,
			TextSize = 12,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextTruncate = Enum.TextTruncate.AtEnd,
			Parent = Frame7,
		})

		rows[arg2] = TextLabel3

		if arg4 then
			TextLabel3:GetPropertyChangedSignal("Text"):Connect(function()
				Frame7.BackgroundTransparency = 0.86
				fn70(Frame7, 0.7, { BackgroundTransparency = 1 })
			end)
		end
	end

	fn77(v19, "place", "Vi tri")
	fn77(v19, "floor", "Tang", true)
	fn77(v19, "mobs", "Quai", true)
	fn77(v19, "boss", "Boss")
	fn77(v19, "time", "Con lai")
	fn77(v19, "hp", "HP")
	fn77(v19, "energy", "Energy", true)
	fn77(v19, "target", "Muc tieu", true)
	fn77(v19, "dist", "Khoang cach")
	fn77(v20, "mode", "Che do")
	fn77(v20, "weapon", "Vu khi")
	fn77(v20, "diff", "Difficulty")
	fn77(v20, "attack", "Fast attack")
	fn77(v20, "hyper", "HYPER", true)
	fn77(v20, "buff", "The bai", true)
	fn77(v20, "runs", "Luot / Kill", true)
	fn77(v20, "alt", "Do cao")
	fn77(v20, "uptime", "Uptime")

	local Frame7 = fn67("Frame", {
		Name = "Footer",
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -24, 0, 38),
		Position = UDim2.new(0, 12, 1, -44),
		Parent = Frame,
	})

	tbl11.Footer = Frame7

	local Frame8 = fn67("Frame", {
		BackgroundColor3 = tbl9.On,
		BackgroundTransparency = 0.6,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 9, 0, 9),
		Position = UDim2.new(0, 3, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Parent = Frame7,
	}, { fn68(20) })

	fn71(Frame8, 1.1, { Size = UDim2.new(0, 20, 0, 20), BackgroundTransparency = 1 }, false)
	tbl11.PipHalo = Frame8

	tbl11.Pip = fn67("Frame", {
		BackgroundColor3 = tbl9.On,
		BorderSizePixel = 0,
		Size = UDim2.new(0, 9, 0, 9),
		Position = UDim2.new(0, 3, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Parent = Frame7,
	}, { fn68(20) })

	local TextLabel3 = fn67("TextLabel", {
		BackgroundTransparency = 1,
		Size = UDim2.new(1, -22, 1, 0),
		Position = UDim2.new(0, 20, 0, 0),
		Font = Enum.Font.Gotham,
		Text = "san sang",
		TextColor3 = tbl9.Sub,
		TextSize = 11,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextTruncate = Enum.TextTruncate.AtEnd,
		Parent = Frame7,
	})

	tbl11.Foot = TextLabel3

	TextLabel3:GetPropertyChangedSignal("Text"):Connect(function()
		TextLabel3.TextTransparency = 0.75
		TextLabel3.Position = UDim2.new(0, 20, 0, 3)
		fn70(TextLabel3, 0.35, { TextTransparency = 0, Position = UDim2.new(0, 20, 0, 0) })
	end)

	local flag9 = false
	local position2 = nil
	local position3 = nil

	Frame2.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			flag9 = true
			position2 = input.Position
			position3 = Frame.Position
			fn70(UIScale, 0.18, { Scale = 1.012 })
			fn70(v8, 0.18, { ImageTransparency = 0.58 })
			fn70(v10, 0.18, { ImageTransparency = 0.2 })
			fn70(v12, 0.18, { ImageTransparency = 0.8 })
		end
	end)

	Frame2.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			if not flag9 then
				return
			end
			flag9 = false
			fn70(UIScale, 0.3, { Scale = 1 }, back)
			fn70(v8, 0.3, { ImageTransparency = v9 })
			fn70(v10, 0.3, { ImageTransparency = v11 })
			fn70(v12, 0.3, { ImageTransparency = v13 })
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if not flag9 then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			local n21 = input.Position - position2
			Frame.Position = UDim2.new(position3.X.Scale, position3.X.Offset + n21.X, position3.Y.Scale, position3.Y.Offset + n21.Y)
		end
	end)

	tbl11.Rows = rows
	fn70(UIScale, 0.42, { Scale = 1 }, back)
	fn70(Frame, 0.35, { BackgroundTransparency = tbl10.Shell })
	fn70(Frame2, 0.35, { BackgroundTransparency = tbl10.Head })
	fn70(Frame3, 0.35, { BackgroundTransparency = tbl10.Head })
	fn70(UIStroke, 0.5, { Transparency = 0.25 })
	fn70(Frame5, 0.5, { BackgroundTransparency = 0.15 })

	for _, shadow in ipairs(shadows) do
		fn70(shadow[1], 0.5, { ImageTransparency = shadow[2] })
	end
end

local function fn74(arg)
	local n19 = math.max(0, math.floor(arg))
	local n20 = math.floor(n19 / 3600)
	local n21 = math.floor(n19 % 3600 / 60)
	local n22 = n19 % 60
	if n20 > 0 then
		return string.format("%d:%02d:%02d", n20, n21, n22)
	end
	return string.format("%d:%02d", n21, n22)
end

local function fn75()
	if not tbl11.Rows then
		return
	end
	local rows = tbl11.Rows
	local v8 = fn6()
	local text

	if fn9() then
		text = "Trong dungeon"
	elseif fn8() then
		text = "Dungeon Hub"
	else
		text = "khong xac dinh"

		if Workspace:GetAttribute("MAP") then
			text = tostring(Workspace:GetAttribute("MAP"))
		end
	end

	local v9 = fn5()
	local v10 = fn11()
	local flag8 = v10 ~= nil and fn63(v10)
	rows.place.Text = text
	local text2 = state.MaxFloor > 0 and state.Floor .. " / " .. state.MaxFloor or tostring(state.Floor)

	if state.Here and state.Here > 0 and state.Here ~= state.Floor then
		text2 ..= "  [o " .. state.Here .. "]"
	end

	rows.floor.Text = text2
	rows.mobs.Text = state.Total > 0 and state.Dead .. " / " .. state.Total or "-"
	rows.boss.Text = flag8 and "tang nay CO boss" or "-"
	rows.boss.TextColor3 = flag8 and tbl9.Pink or tbl9.Text
	rows.time.Text = state.TimeLeft > 0 and fn74(state.TimeLeft) or "-"

	if v8 then
		local n19 = v8.MaxHealth > 0 and v8.Health / v8.MaxHealth or 0
		local floor = math.floor
		rows.hp.Text = string.format("%d / %d  (%d%%)", math.floor(v8.Health), math.floor(v8.MaxHealth), floor(n19 * 100))
		rows.hp.TextColor3 = n19 < 0.35 and tbl9.Off or n19 < 0.7 and tbl9.Gold or tbl9.On
	else
		rows.hp.Text = "-"
		rows.hp.TextColor3 = tbl9.Text
	end

	local energyMax = (state.EnergyMax or 0) > 0 and state.EnergyMax or 50
	local text3 = tostring(state.Energy) .. " / " .. energyMax

	if (state.EnergyNeed or 0) > 0 then
		text3 ..= "  (can " .. state.EnergyNeed .. ")"
	end

	rows.energy.Text = text3
	rows.target.Text = state.Target or "-"
	rows.dist.Text = state.Dist and state.Dist >= 0 and state.Dist .. " m" or "-"
	rows.mode.Text = state.Farm and "KAITUN dang chay" or "dung"
	rows.mode.TextColor3 = state.Farm and tbl9.On or tbl9.Off
	rows.weapon.Text = nightDungeonConfig.Weapon
	rows.diff.Text = nightDungeonConfig.Difficulty
	rows.attack.Text = flag5 and "dang danh" or state.FastAttack and "san sang" or "tat"
	rows.attack.TextColor3 = flag5 and tbl9.On or tbl9.Sub
	rows.hyper.Text = string.format("x%.2f", fn55())
	rows.hyper.TextColor3 = fn55() > 1.01 and tbl9.Gold or tbl9.Text
	rows.buff.Text = fn56()
	rows.runs.Text = state.Runs .. " / " .. state.Kills
	rows.alt.Text = v9 and math.floor(v9.Position.Y) .. " studs" or "-"
	local started = state.Started
	rows.uptime.Text = fn74(os.clock() - started)
	tbl11.Sub.Text = state.Stage
	tbl11.Sub.TextColor3 = state.Farm and tbl9.On or tbl9.Sub
	tbl11.Foot.Text = log[#log] or "san sang"
	tbl11.Pip.BackgroundColor3 = state.Farm and tbl9.On or tbl9.Off
end

fn73()

task.spawn(function()
	while not flag do
		pcall(fn75)
		task.wait(0.4)
	end
end)

nightDungeon.Stop = function()
	if flag then
		return
	end
	flag = true
	state.Farm = false
	flag5 = false
	fn25()
	fn29(false)
	fn26(false)

	if connection4 then
		connection4:Disconnect()
	end

	if connection3 then
		connection3:Disconnect()
	end

	local buffSelector = dungeonShared:FindFirstChild("BuffSelector")

	if buffSelector and buffSelector:IsA("RemoteFunction") then
		pcall(function()
			buffSelector.OnClientInvoke = nil
		end)
	end

	if tbl11.Screen then
		pcall(function()
			tbl11.Screen:Destroy()
		end)
	end

	_G.NightDungeon = nil
	print("[NightDungeon] da tat")
end

nightDungeon.Park = function()
	fn32()
end

nightDungeon.Set = function(arg, arg2)
	if state[arg] ~= nil then
		state[arg] = arg2
		return true
	end

	if nightDungeonConfig[arg] ~= nil then
		nightDungeonConfig[arg] = arg2
		return true
	end
	return false
end

nightDungeon.Dump = function()
	print("Stage=" .. state.Stage .. " Floor=" .. state.Floor .. "/" .. state.MaxFloor .. " Mobs=" .. state.Dead .. "/" .. state.Total)
	print("Farm=" .. tostring(state.Farm) .. " AutoStart=" .. tostring(state.AutoStart) .. " FastAttack=" .. tostring(state.FastAttack) .. " AutoBuff=" .. tostring(state.AutoBuff))
	print("Buffs: " .. fn56())

	for k, buff in pairs(state.Buffs) do
		print("   " .. tostring(k) .. " = " .. tostring(buff))
	end
end

nightDungeon.State = state
nightDungeon.Config = nightDungeonConfig
nightDungeon.Log = log

if flag2 then
	fn32(true)
	fn2("KAITUN ON - tu vao dungeon, tu danh, tu nhat the")
else
	fn2("Kaitun = false, dang dung")
end

return nightDungeon
