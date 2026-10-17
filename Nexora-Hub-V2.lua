
-- NEXORA ULTRA - So com Farming e Status (200KB)

-- NEXORA HUB V2 -> REDZ V5 FINAL WORKING - BASEADO NO MINIMAL QUE ABRIU
local function SafeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res and #res > 100 then return res end
    if syn and syn.request then
        local s, r = pcall(function() return syn.request({Url=url, Method="GET"}).Body end)
        if s and r then return r end
    end
    if http and http.request then
        local s, r = pcall(function() return http.request({Url=url, Method="GET"}).Body end)
        if s and r then return r end
    end
    if request then
        local s, r = pcall(function() return request({Url=url, Method="GET"}).Body end)
        if s and r then return r end
    end
    return nil
end

local redzlib = nil
for _, u in ipairs({
    "https://raw.githubusercontent.com/XenTz-Z/RedzLibV5/refs/heads/main/Source.lua",
    "https://raw.githubusercontent.com/realredz/Library/refs/heads/main/redzlib.txt",
    "https://raw.githubusercontent.com/REDzHUB/LibraryV5/main/Source.lua"
}) do
    local src = SafeHttpGet(u)
    if src then
        local ok, lib = pcall(function() return loadstring(src)() end)
        if ok and lib then redzlib = lib break end
    end
end
if not redzlib then warn("RedzLib falhou") return end

local Window = redzlib:MakeWindow({Title="NEXORA HUB V2 • Redz V5", SubTitle="BLOX FRUITS • Final", SaveFolder="NexoraHubV2_Final"})

-- Loop manager anti-travamento
local Loops, Connections = {}, {}
local function AddConnection(n,c) if Connections[n] then pcall(function() Connections[n]:Disconnect() end) end Connections[n]=c end
local function StopLoop(n) Loops[n]=false if Connections[n] then pcall(function() Connections[n]:Disconnect() end) Connections[n]=nil end end
local function StartLoop(n,interval,fn) StopLoop(n) Loops[n]=true task.spawn(function() while Loops[n] do local ok,err=pcall(fn) if not ok then warn(err) end task.wait(interval) end end) end

-- Floating N (igual ao que abriu)
task.spawn(function()
    local host = game:GetService("CoreGui")
    pcall(function() host = (gethui and gethui()) or game:GetService("CoreGui") end)
    local old = host:FindFirstChild("NexoraFloatingToggle") if old then old:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "NexoraFloatingToggle" gui.ResetOnSpawn=false gui.DisplayOrder=100000 gui.Parent=host
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(52,52) btn.Position=UDim2.new(0,24,0.5,-26)
    btn.BackgroundColor3=Color3.fromRGB(18,18,22) btn.Text="N" btn.TextColor3=Color3.new(1,1,1) btn.TextSize=24 btn.Font=Enum.Font.GothamBlack btn.Active=true btn.Draggable=true btn.Parent=gui
    Instance.new("UICorner", btn).CornerRadius=UDim.new(1,0)
    local s=Instance.new("UIStroke", btn) s.Color=Color3.fromRGB(90,140,255) s.Thickness=2
    local function findWindowGui() return host:FindFirstChild("redz Library V5") end
    local target
    btn.Activated:Connect(function() target=target and target.Parent and target or findWindowGui() if target then target.Enabled=not target.Enabled end end)
end)

-- Main wrapper direto Redz (sem adapter)
local Main = {}
function Main.CreatePage(cfg)
    cfg=cfg or {} local name=cfg.Page_Title or cfg.Page_Name or "Page" local icon=cfg.Page_Icon or "Home"
    local tab=Window:MakeTab({name, icon})
    local Page={}
    function Page.CreateSection(secName)
        local sName=type(secName)=="string" and secName or tostring(secName or "Section")
        local section=tab:AddSection({sName})
        local Section={}
        function Section.CreateToggle(c2,cb) c2=c2 or {} local title=c2.Title or "Toggle" local def=c2.Default==true
            if type(_G.Settings)=="table" and type(_G.Settings[title])=="boolean" then def=_G.Settings[title] end
            local ctrl=tab:AddToggle({Name=title, Title=title, Default=def, Callback=function(v) if _G.Settings then _G.Settings[title]=v end pcall(function() if SaveSettings then SaveSettings(title,v) end end) if cb then task.spawn(function() pcall(cb,v) end) end end})
            local w={Object=ctrl} w.SetStage=function(_,v) if ctrl and ctrl.Set then pcall(ctrl.Set,ctrl,v) end end w.FunctionCreate=w return w end
        function Section.CreateButton(c2,cb) c2=c2 or {} local title=c2.Title or "Button" local function onPressed() if cb then task.spawn(function() local ok,err=pcall(cb) if not ok then warn(err) end end) end end local btn=tab:AddButton({Name=title, Title=title, Callback=onPressed}) return btn end
        function Section.CreateLabel(c2)
            local txt=type(c2)=="table" and (c2.Title or c2.Text or "") or tostring(c2 or "")
            local frame,label pcall(function() frame,label=tab:AddParagraph({txt, ""}) end) if not frame then frame=tab:AddParagraph({Title=txt, Content=""}) end
            local h={Object=frame, Label=label, _text=txt}
            h.SetText=function(s,mt) local v=mt~=nil and mt or s if type(v)=="table" then v=v._text or "" end v=tostring(v or "") h._text=v pcall(function() if h.Object and type(h.Object.SetTitle)=="function" then h.Object:SetTitle(v) end end) end
            h.GetText=function() return h._text end return h end
        function Section.CreateSlider(c2,cb) c2=c2 or {} local title=c2.Title or "Slider" local min=c2.Min or 0 local max=c2.Max or 100 local def=c2.Default or min local ctrl=tab:AddSlider({Name=title, Title=title, Min=min, Max=max, Default=def, Callback=function(v) if cb then task.spawn(function() pcall(cb,v) end) end end}) return ctrl end
        function Section.CreateDropdown(c2,cb)
            c2=c2 or {} local title=c2.Title or "Dropdown" local raw=c2.List or c2.Values or c2.Options or {} local values={}
            if type(raw)=="table" then if #raw>0 then for _,v in ipairs(raw) do table.insert(values,tostring(v)) end else for k in pairs(raw) do table.insert(values,tostring(k)) end table.sort(values) end end
            local multi=c2.Selected==true local def=c2.Default
            if multi then
                local selected={} if type(def)=="table" then for k,v in pairs(def) do if type(k)=="number" then selected[tostring(v)]=true elseif v==true then selected[tostring(k)]=true end end end for _,v in ipairs(values) do if selected[v]==nil then selected[v]=raw[v]==true end end def=selected
                local control={Items={}, Selected=def}
                for _,item in ipairs(values) do local itemName=title.." | "..item local itemControl=tab:AddToggle({Name=itemName, Title=itemName, Default=def[item]==true, Callback=function(v) def[item]=v control.Selected[item]=v if cb then task.spawn(function() pcall(cb,item,v) end) end end}) control.Items[item]=itemControl end
                return control
            else
                if def==nil then def=values[1] end
                local ctrl=tab:AddDropdown({Name=title, Title=title, Options=values, Default=def, Callback=function(v) if cb then task.spawn(function() pcall(cb,v) end) end end}) return ctrl end end
        function Section.CreateBox(c2,cb) c2=c2 or {} local title=c2.Title or "Box" local ph=c2.Placeholder or "" local ctrl=tab:AddTextBox({Name=title, Title=title, Placeholder=ph, Callback=function(v) if cb then task.spawn(function() pcall(cb,v) end) end end}) return ctrl end
        return Section
    end
    return Page
end

_G.Main=Main
if not _G.Settings then _G.Settings={} end
Settings=_G.Settings
function SaveSettings(k,v) _G.Settings[k]=v pcall(function() if writefile then writefile("NexoraHubV2_Settings.json", game:GetService("HttpService"):JSONEncode(_G.Settings)) end end) end
pcall(function() if isfile and isfile("NexoraHubV2_Settings.json") and readfile then _G.Settings=game:GetService("HttpService"):JSONDecode(readfile("NexoraHubV2_Settings.json")) Settings=_G.Settings end end)


PageShop = Main.CreatePage({ Page_Name = "Shop", Page_Title = "Shop" })
-- removed Options = {}
SectionShopMisc = PageShop.CreateSection("Misc Shop")
function Remote(a, s, X)
	if not a and X then
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(s, true)
	else
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer(a, s, X)
	end
end
getgenv().tablefruitausea3 = {}
whitelistedfruit = {}
TableDevilFruit = {}
local a, s, X = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
for g, g in a, s, X do
	if g.Price >= 1000000 then
		table.insert(whitelistedfruit, string.split(g.Name, "-")[1] .. " Fruit")
		getgenv().tablefruitausea3[g.Name] = g.Price
	end
	TableDevilFruit[g.Name] = false
end
getgenv().tablefruitausea3["Dragon (East)-Dragon (East)"] = 15000000
getgenv().tablefruitausea3["Dragon (West)-Dragon (West)"] = 15000000
ItemId = require(game.ReplicatedStorage.Economy.ItemId)
function CheckFruitReal(g)
	local G, f, K = next, game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetFruits", false)
	for R, R in G, f, K do
		if R.Name == g then
			return R
		end
	end
end
SkinFruit = {}
-- spawn(function()
--     for g, g in next, require(game:GetService("ReplicatedStorage").Modules.SkinUtil.FruitSkins).Grouped do
--         for G, G in next, g do
--             getgenv().tablefruitausea3[g.StorageName] = CheckFruitReal(G.Item).Price
--             table.insert(whitelistedfruit, G.StorageName .. " Fruit")
--             SkinFruit[G.StorageName .. " Fruit"] = true
--         end
--     end
-- end)
NameWorldMaterials = {
	Ectoplasm = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Magma Ore"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	Leather = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Scrap Metal"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Angel Wings"] = { [getgenv().CheckPlaceId3] = "TravelMain" },
	["Fish Tail"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Radioactive Material"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Vampire Fang"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Mystic Droplet"] = { [getgenv().CheckPlaceId2] = "TravelDressrosa" },
	["Mini Tusk"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	Gunpowder = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Demonic Wisp"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Dragon Scale"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	["Conjured Cocoa"] = { [getgenv().CheckPlaceId] = "TravelZou" },
	Bones = { [getgenv().CheckPlaceId] = "TravelZou" },
}
NameMaterials = {
	Ectoplasm = { "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer", "Cursed Captain" },
	["Magma Ore"] = { "Lava Pirate", "Magma Ninja" },
	Leather = { "Jungle Pirate", "Musketeer Pirate" },
	["Scrap Metal"] = { "Jungle Pirate" },
	["Angel Wings"] = { "God's Guard", "Shanda", "Royal Squad", "Royal Soldier" },
	["Fish Tail"] = { "Fishman Raider", "Fishman Captain" },
	["Radioactive Material"] = { "Factory Staff" },
	["Vampire Fang"] = { "Vampire" },
	["Mystic Droplet"] = { "Sea Soldier", "Water Fighter" },
	["Mini Tusk"] = { "Mythological Pirate" },
	Gunpowder = { "Pistol Billionaire" },
	["Demonic Wisp"] = { "Demonic Soul" },
	["Dragon Scale"] = { "Dragon Crew Archer", "Dragon Crew Warrior" },
	["Conjured Cocoa"] = { "Cocoa Warrior", "Chocolate Bar Battler" },
	Bones = { "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" },
}
TableMaterials = {}
for g, G in next, NameMaterials, nil do
	table.insert(TableMaterials, g)
end
REDEEM_CODES = {
	"EASTEREXP",
	"BANEXPLOIT",
	"NOMOREHACKS",
	"WildDares",
	"BossBuild",
	"GetPranked",
	"EARN_FRUITS",
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
	"SEATROLLIN",
	"24NOADMIN",
	"ADMIN_TROLL",
	"NEWTROLL",
	"SECRET_ADMIN",
	"staffbattle",
	"NOEXPLOIT",
	"NOOB2ADMIN",
	"CODESLIDE",
	"fruitconcepts",
}
SectionShopMisc.CreateButton({ Title = "Redeem Code" }, function()
	for _, v in REDEEM_CODES do
		game.ReplicatedStorage.Remotes.Redeem:InvokeServer(v)
	end
end)

SectionShopMisc.CreateButton({ Title = "Teleport Old World" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelMain" }))
end)

SectionShopMisc.CreateButton({ Title = "Teleport New World" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelDressrosa" }))
end)

SectionShopMisc.CreateButton({ Title = "Teleport Thid Sea" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "TravelZou" }))
end)

SectionShopMisc.CreateButton({ Title = "Buy Dual Flintlock" }, function()
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyItem", "Dual Flintlock")
end)

SectionShopMisc.CreateButton({ Title = "Reroll Race" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Reroll", "2")
end)

SectionShopMisc.CreateButton({ Title = "Buy Race Draco" }, function()
    -- One click: request Draco directly; do not teleport or walk to Hydra Island.
    local player = game:GetService("Players").LocalPlayer
    local data = player and player:FindFirstChild("Data")
    local race = data and data:FindFirstChild("Race")
    if race and tostring(race.Value) == "Draco" then
        -- removed({Title = "Nexora Hub", Desc = "You already have Draco Race", ShowTime = 5})
        return
    end

    local remote
    pcall(function()
        remote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")
    end)
    if not remote then
        -- removed({Title = "Nexora Hub", Desc = "Draco purchase remote unavailable", ShowTime = 5})
        return
    end

    local ok, result = pcall(function()
        return remote:InvokeServer({NPC = "Dragon Wizard", Command = "DragonRace"})
    end)
    task.wait(0.5)
    if race and tostring(race.Value) == "Draco" then
        -- removed({Title = "Nexora Hub", Desc = "You Equipped Draco Race", ShowTime = 5})
    elseif not ok then
        -- removed({Title = "Nexora Hub", Desc = "Draco purchase request failed", ShowTime = 5})
    else
        -- removed({Title = "Nexora Hub", Desc = "Game may require Draco prerequisites", ShowTime = 5})
    end
end)

SectionShopMisc.CreateButton({ Title = "Reset Stats" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "1")
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward", "Refund", "2")
end)

SectionShopMisc.CreateButton({ Title = "Buy Race Cyborg" }, function()
	game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CyborgTrainer", "Buy")
end)

SectionShopMisc.CreateButton({ Title = "Buy Race Ghoul" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "BuyCheck", 4)
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Ectoplasm", "Change", 4)
end)

SectionShopFighting = PageShop.CreateSection("Fighting Shop")
local g = {}
getgenv().notsave = g
local G = {
	BuyBlackLeg = "Dark Step Teacher",
	BuySuperhuman = "Martial Arts Master",
	BuySharkmanKarate = "Sharkman Teacher",
	DragonClaw = "Sabi",
	BuyDragonTalon = "Uzoth",
	BuyElectro = "Mad Scientist",
	BuyFishmanKarate = "Water Kung-fu Teacher",
	BuyDeathStep = "Phoeyu, the Reformed",
	BuyGodhuman = "Ancient Monk",
	BuyElectricClaw = "Previous Hero",
	BuySanguineArt = "Shafi",
}

SectionShopFighting.CreateToggle({ Title = "Black Leg", Desc = nil, Default = false }, function(f)
	g["Black Leg"] = f
	if f then spawn(function() while g["Black Leg"] and task.wait(0.3) do pcall(function() local R = DetectNpc(G.BuyBlackLeg) if not R or not R.HumanoidRootPart then return end if t:DistanceFromCharacter(R.HumanoidRootPart.Position) > 10 then toTarget(R.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyBlackLeg") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Fishman Karate", Desc = nil, Default = false }, function(f)
	g["Fishman Karate"] = f
	if f then spawn(function() while g["Fishman Karate"] and task.wait(0.3) do pcall(function() local R = DetectNpc(G.BuyFishmanKarate) if not R or not R.HumanoidRootPart then return end if t:DistanceFromCharacter(R.HumanoidRootPart.Position) > 10 then toTarget(R.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyFishmanKarate") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Electro", Desc = nil, Default = false }, function(f)
	g.Electro = f
	if f then spawn(function() while g.Electro and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuyElectro) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectro") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Dragon Breath", Desc = nil, Default = false }, function(f)
	g.DragonClaw = f
	g["Dragon Breath"] = f
	if f then spawn(function() while (g.DragonClaw or g["Dragon Breath"]) and task.wait(0.3) do pcall(function() local K = DetectNpc(G.DragonClaw) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "1") task.wait(0.3) game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BlackbeardReward", "DragonClaw", "2") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "SuperHuman", Desc = nil, Default = false }, function(f)
	g.SuperHuman = f
	if f then spawn(function() while g.SuperHuman and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuySuperhuman) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySuperhuman") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Death Step", Desc = nil, Default = false }, function(f)
	g["Death Step"] = f
	if f then spawn(function() while g["Death Step"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuyDeathStep) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDeathStep") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Sharkman Karate", Desc = nil, Default = false }, function(f)
	g["Sharkman Karate"] = f
	if f then spawn(function() while g["Sharkman Karate"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuySharkmanKarate) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySharkmanKarate") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Electric Claw", Desc = nil, Default = false }, function(f)
	g["Electric Claw"] = f
	if f then spawn(function() while g["Electric Claw"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuyElectricClaw) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyElectricClaw") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Dragon Talon", Desc = nil, Default = false }, function(f)
	g["Dragon Talon"] = f
	if f then spawn(function() while g["Dragon Talon"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuyDragonTalon) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyDragonTalon") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "God Human", Desc = nil, Default = false }, function(f)
	g["God Human"] = f
	if f then spawn(function() while g["God Human"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuyGodhuman) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyGodhuman") task.wait(1) end end) end end) end
end)

SectionShopFighting.CreateToggle({ Title = "Sanguine Art", Desc = nil, Default = false }, function(f)
	g["Sanguine Art"] = f
	if f then spawn(function() while g["Sanguine Art"] and task.wait(0.3) do pcall(function() local K = DetectNpc(G.BuySanguineArt) if not K or not K.HumanoidRootPart then return end if t:DistanceFromCharacter(K.HumanoidRootPart.Position) > 10 then toTarget(K.HumanoidRootPart.CFrame * CFrame.new(0,2,2)) else game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuySanguineArt") task.wait(1) end end) end end) end
end)


NPCManager = require(game:GetService("ReplicatedStorage").NPCManager)
function GetFarNpcCFrame(name, npc, inst)
	local RS = game:GetService("ReplicatedStorage")
	local function fromInstance(i)
		if typeof(i) ~= "Instance" then return nil end
		if i:IsA("BasePart") then return i.CFrame end
		if i:IsA("Model") then
			local p = i:FindFirstChild("HumanoidRootPart") or i.PrimaryPart or i:FindFirstChildWhichIsA("BasePart", true)
			if p then return p.CFrame end
			local ok, cf = pcall(function() return i:GetPivot() end)
			if ok and typeof(cf) == "CFrame" and cf.Position.Magnitude > 10 then return cf end
		end
	end
	local cf = fromInstance(inst)
	if cf then return cf end
	for _, root in ipairs({ workspace:FindFirstChild("NPCs"), RS:FindFirstChild("NPCs"), RS }) do
		local m = root and root:FindFirstChild(name, true)
		cf = fromInstance(m)
		if cf then return cf end
	end
	local seen = {}
	local function scan(v, depth)
		if depth > 3 then return nil end
		local tv = typeof(v)
		if tv == "CFrame" then return (v.Position.Magnitude > 10) and v or nil end
		if tv == "Vector3" then return (v.Magnitude > 10) and CFrame.new(v) or nil end
		if tv == "Instance" then return fromInstance(v) end
		if tv == "table" and not seen[v] then
			seen[v] = true
			for _, x in pairs(v) do
				local r = scan(x, depth + 1)
				if r then return r end
			end
		end
	end
	local ok, r = pcall(scan, npc, 0)
	return ok and r or nil
end
function DetectNpc(f)
	local K = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
	if not K then
		return
	end
	local R, m, E, l = next, { workspace.NPCs, game:GetService("ReplicatedStorage").NPCs }, 1 / 0
	for Q, Q in R, m, nil do
		local R, m, S = next, Q:GetChildren()
		for Q, L in R, m, S do
			if
				L:GetAttribute("NPCLoaded")
				and (L:GetAttribute("NPCReady"))
				and L.Name == f
				and (L:FindFirstChild("HumanoidRootPart"))
			then
				Q = (K.Position - L.HumanoidRootPart.Position).Magnitude
				if Q < E then
					E, l = Q, L
				end
			end
		end
	end
	if not l then
		local npc = NPCManager.getNPCsByName(f)[1]
		local inst = npc and npc._modelState and npc._modelState._instance
		if inst and inst:FindFirstChild("HumanoidRootPart") then return inst end
		-- NPC longe/não carregado: acha a posição guardada e devolve um objeto compatível com os toggles.
		local cf = GetFarNpcCFrame(f, npc, inst)
		if cf then return { HumanoidRootPart = { CFrame = cf, Position = cf.Position } } end
		return inst
	end
	return l, E
end














SectionShopAbilities = PageShop.CreateSection("Abilities Shop")
SectionShopAbilities.CreateButton({ Title = "Skyjump [ $10,000 Beli ]" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Geppo")
end)
SectionShopAbilities.CreateButton({ Title = "Buso Haki [ $25,000 Beli ]" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Buso")
end)
SectionShopAbilities.CreateButton({ Title = "Observation haki [ $750,000 Beli ]" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk", "Buy")
end)
SectionShopAbilities.CreateButton({ Title = "Soru [ $100,000 Beli ]" }, function()
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki", "Soru")
end)
PageStatusAndServer = Main.CreatePage({ Page_Name = "Status And Server", Page_Title = "Status And Server" })
SectionStatus = PageStatusAndServer.CreateSection("Status")
TimerLabel = SectionStatus.CreateLabel({ Title = "Timer" })
TimerServerLabel = SectionStatus.CreateLabel({ Title = "Timer Server" })
NextTimerServerLabel = SectionStatus.CreateLabel({ Title = "Next Time Spawn Fist of Darkness or God's Chalice" })
StatusEliteHunter = SectionStatus.CreateLabel({ Title = "Elite" })
StatusTyrant = SectionStatus.CreateLabel({ Title = "Eyes Summon Tyrant" })
StatusKatakuri = SectionStatus.CreateLabel({ Title = "Summon Katakuri" })
Statusspy = SectionStatus.CreateLabel({ Title = "Status SPY" })
StatusMirage = SectionStatus.CreateLabel({ Title = "Mirage" })
StatusKitsuneIsland = SectionStatus.CreateLabel({ Title = "Kitsune Island" })
StatusPrehistoricIsland = SectionStatus.CreateLabel({ Title = "Prehistoric Island" })
StatusFrozenDimension = SectionStatus.CreateLabel({ Title = "Frozen Dimension" })
StatusMoon = SectionStatus.CreateLabel({ Title = "Moon" })
StatusGear = SectionStatus.CreateLabel({ Title = "Acient One Status" })


-- ============================================
-- Fruit Stock & Player State (English) - Like Hub Vxeze Principal > Estado
-- Added to Status And Server
-- ============================================
do
    local 
-- STATUS AND SERVER - LISTAS ROLAVEIS (ADICIONADO)
do
    local NormalFruits = {"Rocket","Spin","Blade","Spring","Bomb","Smoke","Spike","Flame","Sand","Dark","Diamond","Light","Rubber","Barrier","Ghost","Magma","Quake","Buddha","Love","Spider","Sound","Phoenix","Portal","Lightning","Pain","Blizzard","Gravity","Dough","Shadow","Venom","Control","Gas","Spirit","Leopard","Yeti","Kitsune","Dragon"}
    local MirageFruits = {"Leopard","Yeti","Kitsune","Dragon","Spirit","Control","Gas","Venom","Shadow","Dough","Gravity","Blizzard"}
    local SectionDealerNormal = PageStatusAndServer.CreateSection("Dealer Normal - Stock Rolavel")
    local DealerNormalLabel = SectionDealerNormal.CreateLabel({Title="Normal Dealer: Carregando..."})
    SectionDealerNormal.CreateDropdown({Title="Filtrar Normal Dealer", List=NormalFruits, Default=NormalFruits[1]}, function(v) DealerNormalLabel.SetText(DealerNormalLabel, "Normal Selecionado: "..tostring(v)) end)
    for _, fruit in ipairs(NormalFruits) do SectionDealerNormal.CreateButton({Title="[Normal] "..fruit}, function() DealerNormalLabel.SetText(DealerNormalLabel, "Normal: "..fruit) end) end
    local SectionMirageDealer = PageStatusAndServer.CreateSection("Mirage Dealer - Stock Rolavel")
    local MirageLabel = SectionMirageDealer.CreateLabel({Title="Mirage Dealer: Carregando..."})
    SectionMirageDealer.CreateDropdown({Title="Filtrar Mirage Dealer", List=MirageFruits, Default=MirageFruits[1]}, function(v) MirageLabel.SetText(MirageLabel, "Mirage Selecionado: "..tostring(v)) end)
    for _, fruit in ipairs(MirageFruits) do SectionMirageDealer.CreateButton({Title="[Mirage] "..fruit}, function() MirageLabel.SetText(MirageLabel, "Mirage: "..fruit) end) end
end


SectionPlayer = PageStatusAndServer.CreateSection("Player - State")
    local LabelBeli = SectionPlayer.CreateLabel({ Title = "Beli: Loading..." })
    local LabelBounty = SectionPlayer.CreateLabel({ Title = "Bounty / Honor: Loading..." })
    local LabelFragments = SectionPlayer.CreateLabel({ Title = "Fragments: Loading..." })
    local LabelLevel = SectionPlayer.CreateLabel({ Title = "Level: Loading..." })
    
    spawn(function()
        local function FormatBounty(val)
            if val >= 1000000 then
                local mi = val / 1000000
                -- Formato brasileiro 2,5 mi
                local s = string.format("%.1f", mi):gsub("%.", ",")
                return s .. " mi (" .. tostring(val) .. ")"
            elseif val >= 1000 then
                return tostring(math.floor(val/1000)) .. "K (" .. tostring(val) .. ")"
            else
                return tostring(val)
            end
        end
        
        while task.wait(1.5) do
            pcall(function()
                local data = game.Players.LocalPlayer:FindFirstChild("Data")
                if data then
                    if data:FindFirstChild("Beli") then LabelBeli.SetText("Beli: " .. tostring(data.Beli.Value)) end
                    if data:FindFirstChild("Fragments") then LabelFragments.SetText("Fragments: " .. tostring(data.Fragments.Value)) end
                    if data:FindFirstChild("Level") then LabelLevel.SetText("Level: " .. tostring(data.Level.Value)) end
                    
                    -- Bounty/Honor verifica nas classificacoes detectando seu Nick (igual print)
                    local bountyVal = 0
                    local b = data:FindFirstChild("Bounty") or data:FindFirstChild("Honor")
                    if b then bountyVal = b.Value end
                    
                    -- Tenta pegar da Classificacao/Leaderboard tambem
                    pcall(function()
                        local leaderboard = game.Players.LocalPlayer:FindFirstChild("leaderstats")
                        if leaderboard then
                            local bountyStat = leaderboard:FindFirstChild("Bounty/Honor") or leaderboard:FindFirstChild("Bounty") or leaderboard:FindFirstChild("Honor")
                            if bountyStat and bountyStat.Value and bountyStat.Value > 0 then
                                bountyVal = bountyStat.Value
                            end
                        end
                    end)
                    
                    if bountyVal > 0 then
                        LabelBounty.SetText("Bounty / Honor: " .. FormatBounty(bountyVal))
                    end
                end
            end)
        end
    end)
    
    -- Fruit stock: keep each dealer in a fixed section and update a single
    -- multiline label. This avoids creating dozens of UI rows that push the
    -- rest of Status And Server down every time the stock changes.
    local SectionNormal = PageStatusAndServer.CreateSection("Normal Fruit Stock - Normal Dealer")
    local NormalStockLabel = SectionNormal.CreateLabel({ Title = "Loading normal dealer stock..." })

    local SectionAdvance = PageStatusAndServer.CreateSection("Advance Fruit Stock - Mirage Island Dealer")
    local AdvanceStockLabel = SectionAdvance.CreateLabel({ Title = "Loading Mirage dealer stock..." })

    local function ParseFruit(v)
        if type(v) == "table" then
            if v.OnSale == false or v.InStock == false or v.CanBuy == false then return nil, nil end
            if v.Stock == 0 or v.Amount == 0 then return nil, nil end
            local name = v.Name or v.name or v.FruitName or v[1]
            local price = v.Price or v.price or v.Cost or v[2] or 0
            if name then return tostring(name), tonumber(price) or 0 end
        elseif type(v) == "string" then
            return v, 0
        end
        return nil, nil
    end

    local function FormatPrice(price)
        price = tonumber(price) or 0
        if price <= 0 then return "" end
        local value = tostring(math.floor(price))
        while true do
            local changed
            value, changed = value:gsub("^(%-?%d+)(%d%d%d)", "%1,%2")
            if changed == 0 then break end
        end
        return " - $" .. value
    end

    local function UpdateStockLabel(label, stock, dealerName)
        if type(stock) ~= "table" then
            label.SetText(dealerName .. ": stock unavailable")
            return
        end
        local rows, seen = {}, {}
        for k, v in pairs(stock) do
            local name, price = ParseFruit(v)
            -- Some responses are keyed by fruit name, with the price as value.
            if not name and type(k) == "string" and (type(v) == "number" or type(v) == "string") then
                name, price = k, tonumber(v) or 0
            end
            if name and not seen[name] then
                seen[name] = true
                rows[#rows + 1] = { name = name, price = price or 0 }
            end
        end
        table.sort(rows, function(a, b) return a.name:lower() < b.name:lower() end)
        if #rows == 0 then
            label.SetText(dealerName .. ": no fruits available right now")
            return
        end
        local lines = { dealerName .. " (" .. #rows .. " fruits):" }
        for _, fruit in ipairs(rows) do
            lines[#lines + 1] = fruit.name .. FormatPrice(fruit.price)
        end
        -- One label per dealer; newline text stays in this stock section rather
        -- than inserting one UI component per fruit and shifting later sections.
        label.SetText(table.concat(lines, "\n"))
    end

    task.spawn(function()
        -- Refresh slowly; stock is not a per-frame value. Calls are sequential
        -- to avoid simultaneous remote requests adding load during gameplay.
        local firstRun = true
        while true do
            if not firstRun then task.wait(60) end
            firstRun = false
            local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
            local comm = remotes and remotes:FindFirstChild("CommF_")
            if comm then
                local normalStock
                local okNormal = pcall(function()
                    normalStock = comm:InvokeServer("GetFruits", false)
                end)
                if not okNormal or type(normalStock) ~= "table" then
                    pcall(function() normalStock = comm:InvokeServer("GetFruits") end)
                end
                UpdateStockLabel(NormalStockLabel, normalStock, "Normal Dealer")

                local mirageStock
                local okMirage = pcall(function()
                    mirageStock = comm:InvokeServer("GetFruits", true)
                end)
                if not okMirage or type(mirageStock) ~= "table" then
                    pcall(function() mirageStock = comm:InvokeServer("GetStock", "Mirage") end)
                end
                if type(mirageStock) ~= "table" then
                    pcall(function() mirageStock = comm:InvokeServer("GetFruits", "Mirage") end)
                end
                UpdateStockLabel(AdvanceStockLabel, mirageStock, "Mirage Dealer")
            end
        end
    end)
end

-- ===================== Status Boss Server =====================
-- Aba: bosses que nascem NORMALMENTE (por tempo). Cada boss mostra só uma bolinha:
--   🟢 = o script detectou o boss spawnado agora (vivo em Enemies ou ReplicatedStorage)
--   🔴 = o script não detectou o boss (não spawnado)
-- Bosses que nascem por ação do jogador (summon, raid etc.) não estão nesta lista.
do
	local BossPage = Main.CreatePage({ Page_Name = "Status Boss Server", Page_Title = "Status Boss Server" })
	local ReplicatedStorage = game:GetService("ReplicatedStorage")

	local Seas = {
		{
			title = "First Sea",
			here = function()
				return game.PlaceId == getgenv().CheckPlaceId3
			end,
			bosses = {
				"Gorilla King", "Bobby", "The Saw", "Yeti", "Mob Leader", "Vice Admiral", "Warden",
				"Magma Admiral", "Fishman Lord", "Wysper", "Thunder God", "Cyborg", "Ice Admiral", "Greybeard",
			},
		},
		{
			title = "Second Sea",
			here = function()
				return game.PlaceId == getgenv().CheckPlaceId2
			end,
			bosses = {
				"Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain",
				"Awakened Ice Admiral", "Tide Keeper",
			},
		},
		{
			title = "Third Sea",
			here = function()
				return game.PlaceId == getgenv().CheckPlaceId
			end,
			bosses = { "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Longma", "Cake Queen" },
		},
	}

	local Known, Order = {}, {}
	for _, sea in ipairs(Seas) do
		local section = BossPage.CreateSection(sea.title)
		for _, name in ipairs(sea.bosses) do
			local entry = { name = name, here = sea.here, shown = nil }
			entry.label = section.CreateLabel({ Title = "🔴 " .. name })
			Known[name] = entry
			Order[#Order + 1] = entry
		end
	end

	local function CleanName(n)
		n = n:gsub("%s*%[Lv%. [^%]]+%]", "")
		n = n:gsub("%s*%[Boss%]", "")
		return n
	end

	-- Bosses da lista vivos agora (Enemies + ReplicatedStorage). Retorna nome -> onde achou.
	local function ScanAlive()
		local alive = {}
		local function scan(container, where)
			if not container then
				return
			end
			for _, model in ipairs(container:GetDescendants()) do
				if model:IsA("Model") and not model.Name:find("%[Raid Boss%]") then
					local e = Known[CleanName(model.Name)]
					if e then
						local hum = model:FindFirstChildOfClass("Humanoid")
						if hum and hum.Health > 0 then
							alive[e.name] = where
						end
					end
				end
			end
		end
		scan(workspace:FindFirstChild("Enemies"), "mapa")
		scan(ReplicatedStorage, "ReplicatedStorage")
		return alive
	end

	getgenv().__BossStatusGen = (getgenv().__BossStatusGen or 0) + 1
	local Gen = getgenv().__BossStatusGen
	task.spawn(function()
		while task.wait(1) and getgenv().__BossStatusGen == Gen do
			pcall(function()
				local alive = ScanAlive()
				for _, e in ipairs(Order) do
					local text
					if alive[e.name] then
						text = "🟢 " .. e.name
					elseif e.here() then
						text = "🔴 " .. e.name
					else
						-- Boss de outro mar: o script não consegue ver, então fica vermelho.
						text = "🔴 " .. e.name .. " (outro mar)"
					end
					if text ~= e.shown then
						e.shown = text
						e.label.SetText(text)
					end
				end
			end)
		end
	end)

end
-- ===============================================================
SectionServer = PageStatusAndServer.CreateSection("Server")
SectionServer.CreateButton({ Title = "Open Gui Server Browser (Low Player and Ping)" }, function()
	local G = game:GetService("HttpService")
	game:GetService("TeleportService")
	local f, K = game:GetService("Players"), game:GetService("TweenService")
	local R, R, m = f.LocalPlayer, game.PlaceId, syn and syn.request or http_request or request
	if not m then
		return
	end
	if game.CoreGui:FindFirstChild("SB_UI") then
		game.CoreGui.SB_UI:Destroy()
	end
	local E, l, Q =
		{ servers = {}, cursor = nil, finished = false, lastUpdate = 0, pages = 0 },
		{
			CACHE_TIME = 60,
			MAX_SHOW = 50,
			PAGE_DELAY = 5,
			RETRY_MAX = 4,
			RETRY_BASE = 2,
			RETRY_JITTER = 5,
			RATE_COOLDOWN = 30,
		},
		{
			BG = Color3.fromRGB(10, 11, 16),
			SURFACE = Color3.fromRGB(13, 14, 20),
			ROW = Color3.fromRGB(16, 17, 26),
			ROW_HOVER = Color3.fromRGB(20, 22, 35),
			ROW_TOP = Color3.fromRGB(10, 22, 34),
			BORDER = Color3.fromRGB(28, 31, 48),
			BORDER_HOV = Color3.fromRGB(130, 12, 28),
			CYAN = Color3.fromRGB(0, 212, 255),
			CYAN_DIM = Color3.fromRGB(130, 12, 28),
			GREEN = Color3.fromRGB(0, 204, 102),
			GREEN_GLOW = Color3.fromRGB(0, 255, 136),
			AMBER = Color3.fromRGB(255, 45, 65),
			RED = Color3.fromRGB(255, 68, 85),
			TEXT_PRI = Color3.fromRGB(232, 234, 240),
			TEXT_SEC = Color3.fromRGB(80, 90, 120),
			TEXT_DIM = Color3.fromRGB(45, 52, 82),
		}
	local function S(L, d, I)
		local _ = Instance.new(L)
		for L, o in pairs(d or {}) do
			_[L] = o
		end
		if I then
			_.Parent = I
		end
		return _
	end
	local function L(d, I)
		return S("UICorner", { CornerRadius = UDim.new(0, d) }, I)
	end
	local function d(I, _, o, V)
		return S("UIStroke", { Thickness = I, Color = _, Transparency = o or 0 }, V)
	end
	local function I(_, o, V, N, y)
		K:Create(_, TweenInfo.new(V or 0.15, N or Enum.EasingStyle.Quad, y or Enum.EasingDirection.Out), o):Play()
	end
	local function K(_, o, V)
		_.MouseEnter:Connect(function()
			I(_, { BackgroundColor3 = V })
		end)
		_.MouseLeave:Connect(function()
			I(_, { BackgroundColor3 = o })
		end)
	end
	local function _()
		return math.random() * l.RETRY_JITTER
	end
	local o = S(
		"ScreenGui",
		{ Name = "SB_UI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling, IgnoreGuiInset = true },
		game.CoreGui
	)
	local V = S(
		"Frame",
		{
			Name = "Window",
			Size = UDim2.new(0, 580, 0, 500),
			Position = UDim2.new(0.5, -290, 0.5, -250),
			BackgroundColor3 = Q.SURFACE,
			BorderSizePixel = 0,
			ClipsDescendants = true,
		},
		o
	)
	L(4, V)
	d(1, Q.BORDER, 0, V)
	do
		local N, y, x
		V.InputBegan:Connect(function(k)
			if k.UserInputType == Enum.UserInputType.MouseButton1 then
				N = true
				y = k.Position
				x = V.Position
			end
		end)
		V.InputEnded:Connect(function(k)
			local P, e = k.UserInputType, Enum.UserInputType.MouseButton1
			if P == e then
				N = false
			end
		end)
		game:GetService("UserInputService").InputChanged:Connect(function(k)
			if N and k.UserInputType == Enum.UserInputType.MouseMovement then
				local N = k.Position - y
				V.Position = UDim2.new(x.X.Scale, x.X.Offset + N.X, x.Y.Scale, x.Y.Offset + N.Y)
			end
		end)
	end
	f = S("Frame", { Size = UDim2.new(1, 0, 0, 52), BackgroundColor3 = Q.BG, BorderSizePixel = 0 }, V)
	S(
		"TextLabel",
		{
			Size = UDim2.new(0, 300, 0, 18),
			Position = UDim2.new(0, 18, 0, 9),
			BackgroundTransparency = 1,
			Text = "SERVER BROWSER",
			TextColor3 = Q.TEXT_PRI,
			Font = Enum.Font.GothamBold,
			TextSize = 13,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
		f
	)
	S(
		"TextLabel",
		{
			Size = UDim2.new(0, 360, 0, 14),
			Position = UDim2.new(0, 18, 0, 30),
			BackgroundTransparency = 1,
			Text = "CACHE PAGE \194\183 LOAD MORE \194\183 LOWEST PLAYER / PING",
			TextColor3 = Q.TEXT_DIM,
			Font = Enum.Font.Gotham,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Left,
		},
		f
	)
	local N = S(
		"TextButton",
		{
			Size = UDim2.new(0, 28, 0, 28),
			Position = UDim2.new(1, -42, 0, 12),
			BackgroundColor3 = Color3.fromRGB(26, 13, 13),
			BorderSizePixel = 0,
			Text = "X",
			TextColor3 = Q.RED,
			Font = Enum.Font.GothamBold,
			TextSize = 11,
		},
		f
	)
	L(3, N)
	K(N, Color3.fromRGB(26, 13, 13), Color3.fromRGB(60, 20, 20))
	N.MouseButton1Click:Connect(function()
		o:Destroy()
	end)
	f = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 42),
			Position = UDim2.new(0, 0, 0, 52),
			BackgroundColor3 = Color3.fromRGB(5, 14, 35),
			BorderSizePixel = 0,
		},
		V
	)
	local o = S(
		"Frame",
		{
			Size = UDim2.new(0, 6, 0, 6),
			Position = UDim2.new(0, 14, 0.5, -3),
			BackgroundColor3 = Q.TEXT_DIM,
			BorderSizePixel = 0,
		},
		f
	)
	L(99, o)
	local N, y =
		S(
			"TextLabel",
			{
				Size = UDim2.new(1, -300, 1, 0),
				Position = UDim2.new(0, 26, 0, 0),
				BackgroundTransparency = 1,
				Text = "READY",
				TextColor3 = Q.TEXT_SEC,
				Font = Enum.Font.Gotham,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			f
		),
		S(
			"TextButton",
			{
				Size = UDim2.new(0, 82, 0, 26),
				Position = UDim2.new(1, -270, 0.5, -13),
				BackgroundColor3 = Color3.fromRGB(7, 24, 60),
				BorderSizePixel = 0,
				Text = "REFRESH",
				TextColor3 = Color3.fromRGB(100, 140, 200),
				Font = Enum.Font.GothamBold,
				TextSize = 10,
			},
			f
		)
	L(3, y)
	K(y, Color3.fromRGB(7, 24, 60), Color3.fromRGB(10, 30, 55))
	local x = S(
		"TextButton",
		{
			Size = UDim2.new(0, 82, 0, 26),
			Position = UDim2.new(1, -182, 0.5, -13),
			BackgroundColor3 = Color3.fromRGB(16, 32, 24),
			BorderSizePixel = 0,
			Text = "LOAD MORE",
			TextColor3 = Q.GREEN,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
		},
		f
	)
	L(3, x)
	K(x, Color3.fromRGB(16, 32, 24), Color3.fromRGB(10, 48, 28))
	local k = S(
		"TextButton",
		{
			Size = UDim2.new(0, 82, 0, 26),
			Position = UDim2.new(1, -94, 0.5, -13),
			BackgroundColor3 = Color3.fromRGB(38, 18, 18),
			BorderSizePixel = 0,
			Text = "RESET",
			TextColor3 = Q.RED,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
		},
		f
	)
	L(3, k)
	K(k, Color3.fromRGB(38, 18, 18), Color3.fromRGB(60, 20, 20))
	local P = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 24),
			Position = UDim2.new(0, 0, 0, 94),
			BackgroundColor3 = Color3.fromRGB(5, 14, 35),
			BorderSizePixel = 0,
		},
		V
	)
	local function e(Y, H, B)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, B, 1, 0),
				Position = UDim2.new(0, H, 0, 0),
				BackgroundTransparency = 1,
				Text = Y,
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.GothamBold,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			P
		)
	end
	e("#", 14, 28)
	e("JOB ID", 42, 170)
	e("PLAYERS", 220, 80)
	e("PING", 310, 60)
	local P = S(
		"ScrollingFrame",
		{
			Size = UDim2.new(1, -8, 1, -172),
			Position = UDim2.new(0, 4, 0, 118),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Q.CYAN_DIM,
			CanvasSize = UDim2.new(0, 0, 0, 0),
		},
		V
	)
	local e = S("UIListLayout", { Padding = UDim.new(0, 3), SortOrder = Enum.SortOrder.LayoutOrder }, P)
	S(
		"UIPadding",
		{
			PaddingTop = UDim.new(0, 6),
			PaddingLeft = UDim.new(0, 4),
			PaddingRight = UDim.new(0, 4),
			PaddingBottom = UDim.new(0, 6),
		},
		P
	)
	f = S(
		"Frame",
		{
			Size = UDim2.new(1, 0, 0, 30),
			Position = UDim2.new(0, 0, 1, -30),
			BackgroundColor3 = Color3.fromRGB(10, 11, 15),
			BorderSizePixel = 0,
		},
		V
	)
	local Y, H, B =
		S(
			"TextLabel",
			{
				Size = UDim2.new(0.5, 0, 1, 0),
				Position = UDim2.new(0, 14, 0, 0),
				BackgroundTransparency = 1,
				Text = "PLACE \194\183 " .. tostring(R),
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			f
		),
		S(
			"TextLabel",
			{
				Size = UDim2.new(0.5, -14, 1, 0),
				Position = UDim2.new(0.5, 0, 0, 0),
				BackgroundTransparency = 1,
				Text = "SHOWING 0 / 0",
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Right,
			},
			f
		),
		S(
			"Frame",
			{
				Size = UDim2.new(1, 0, 1, -52),
				Position = UDim2.new(0, 0, 0, 52),
				BackgroundColor3 = Q.SURFACE,
				BackgroundTransparency = 0.05,
				ZIndex = 20,
				Visible = false,
			},
			V
		)
	local f, Z =
		S(
			"TextLabel",
			{
				Size = UDim2.new(1, -20, 0, 36),
				Position = UDim2.new(0, 10, 0.5, 10),
				BackgroundTransparency = 1,
				Text = "SCANNING SERVERS...",
				TextColor3 = Q.CYAN,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Center,
				TextWrapped = true,
				ZIndex = 21,
			},
			B
		),
		S(
			"Frame",
			{
				Size = UDim2.new(1, -8, 0, 28),
				Position = UDim2.new(0, 4, 0, 118),
				BackgroundColor3 = Color3.fromRGB(38, 24, 6),
				BorderSizePixel = 0,
				ZIndex = 15,
				Visible = false,
			},
			V
		)
	L(3, Z)
	d(1, Q.AMBER, 0.4, Z)
	local C = S(
		"TextLabel",
		{
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 6, 0, 0),
			BackgroundTransparency = 1,
			Text = "\226\143\179 429 RATE LIMITED \226\128\148 WAITING...",
			TextColor3 = Q.AMBER,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Center,
			ZIndex = 16,
		},
		Z
	)
	local function J(F)
		C.Text = F
		Z.Visible = true
		P.Position = UDim2.new(0, 4, 0, 150)
		P.Size = UDim2.new(1, -8, 1, -204)
	end
	local function F()
		Z.Visible = false
		P.Position = UDim2.new(0, 4, 0, 118)
		P.Size = UDim2.new(1, -8, 1, -172)
	end
	local q = S(
		"Frame",
		{
			Size = UDim2.new(0, 360, 0, 36),
			Position = UDim2.new(0.5, -180, 1, -50),
			BackgroundColor3 = Color3.fromRGB(10, 26, 40),
			BorderSizePixel = 0,
			ZIndex = 30,
			Visible = false,
		},
		V
	)
	L(3, q)
	local V = S(
		"TextLabel",
		{
			Size = UDim2.new(1, -12, 1, 0),
			Position = UDim2.new(0, 6, 0, 0),
			BackgroundTransparency = 1,
			Text = "READY",
			TextColor3 = Q.CYAN,
			Font = Enum.Font.GothamBold,
			TextSize = 10,
			TextWrapped = true,
			ZIndex = 31,
		},
		q
	)
	local c
	local function D(r, n)
		if c then
			task.cancel(c)
		end
		V.Text = r
		V.TextColor3 = n or Q.CYAN
		q.Visible = true
		c = task.delay(3.5, function()
			q.Visible = false
		end)
	end
	local function V(q, c)
		N.Text = q
		o.BackgroundColor3 = c or Q.TEXT_DIM
	end
	local function o(N)
		return ({
			RATE_LIMIT = "429 RATE LIMITED \226\128\148 TOO MANY REQUESTS",
			FORBIDDEN = "403 FORBIDDEN \226\128\148 ACCESS BLOCKED",
			UNAUTHORIZED = "401 UNAUTHORIZED",
			SERVER_ERROR = "5xx ROBLOX SERVER ERROR",
			NETWORK_ERROR = "NETWORK / EXECUTOR ERROR",
			INVALID_JSON = "INVALID JSON RESPONSE",
			EMPTY_BODY = "EMPTY RESPONSE BODY",
		})[N] or "REQUEST FAILED: " .. tostring(N)
	end
	local function N(q, c)
		local r = 0
		for n = 0, l.RETRY_MAX, 1 do
			local u, W = pcall(function()
				return m({
					Url = q,
					Method = "GET",
					Headers = { ["User-Agent"] = "Mozilla/5.0", Accept = "application/json" },
				})
			end)
			if not u or not W then
				return nil, "NETWORK_ERROR"
			end
			u = W.StatusCode or W.Status or 0
			if u == 429 then
				r += 1
				if n >= l.RETRY_MAX then
					return nil, "RATE_LIMIT"
				end
				local m = if r >= 2 then l.RATE_COOLDOWN + _() else math.pow(l.RETRY_BASE, n + 1) + _()
				local _ = string.format(
					"\226\143\179 429 RATE LIMITED \226\128\148 WAITING %.0fs THEN RETRYING (%d/%d)",
					m,
					n + 1,
					l.RETRY_MAX
				)
				if c then
					J(_)
					B.Visible = false
				else
					B.Visible = true
					f.Text = _
				end
				V("RATE LIMITED \226\128\148 WAITING " .. math.floor(m) .. "s", Q.AMBER)
				D(string.format("\226\143\179 429 \226\128\148 RETRYING IN %.0fs", m), Q.AMBER)
				local _ = math.floor(m)
				task.spawn(function()
					while _ > 0 do
						task.wait(1)
						_ -= 1
						local q = string.format(
							"\226\143\179 429 RATE LIMITED \226\128\148 %.0fs REMAINING (%d/%d)",
							_,
							n + 1,
							l.RETRY_MAX
						)
						if c then
							if Z.Visible then
								C.Text = q
							end
						elseif B.Visible then
							f.Text = q
						end
					end
				end)
				task.wait(m)
				if c then
					F()
				end
				continue
			end
			if u == 403 then
				return nil, "FORBIDDEN"
			end
			if u == 401 then
				return nil, "UNAUTHORIZED"
			end
			if u >= 500 then
				return nil, "SERVER_ERROR"
			end
			if u ~= 200 and u ~= 0 then
				return nil, "HTTP_" .. tostring(u)
			end
			if not W.Body or W.Body == "" then
				return nil, "EMPTY_BODY"
			end
			local m, _ = pcall(G.JSONDecode, G, W.Body)
			if not m or not _ then
				return nil, "INVALID_JSON"
			end
			return _, nil
		end
		return nil, "RATE_LIMIT"
	end
	local function m()
		for _, _ in ipairs(P:GetChildren()) do
			if _:IsA("Frame") then
				_:Destroy()
			end
		end
	end
	local function _()
		table.sort(E.servers, function(Z, C)
			local q, c = Z.playing or 999, C.playing or 999
			if q ~= c then
				return q < c
			end
			return (Z.ping or 999) < (C.ping or 999)
		end)
	end
	local function Z(C)
		if C < 100 then
			return Q.GREEN_GLOW
		elseif C < 200 then
			return Q.AMBER
		else
			return Q.RED
		end
	end
	local function C(q)
		if q > 0.8 then
			return Q.RED
		elseif q > 0.5 then
			return Q.AMBER
		else
			return Q.CYAN
		end
	end
	local function q(c, r)
		local n = r == 1
		local u = n and Q.ROW_TOP or Q.ROW
		local W =
			S("Frame", { Size = UDim2.new(1, 0, 0, 48), BackgroundColor3 = u, BorderSizePixel = 0, LayoutOrder = r }, P)
		L(3, W)
		local O = d(1, n and Q.CYAN_DIM or Q.BORDER, 0, W)
		W.MouseEnter:Connect(function()
			I(W, { BackgroundColor3 = Q.ROW_HOVER })
			I(O, { Color = Q.BORDER_HOV })
		end)
		W.MouseLeave:Connect(function()
			I(W, { BackgroundColor3 = u })
			I(O, { Color = n and Q.CYAN_DIM or Q.BORDER })
		end)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 28, 1, 0),
				Position = UDim2.new(0, 10, 0, 0),
				BackgroundTransparency = 1,
				Text = string.format("%02d", r),
				TextColor3 = n and Q.CYAN or Q.TEXT_DIM,
				Font = Enum.Font.GothamBold,
				TextSize = 11,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 160, 0, 14),
				Position = UDim2.new(0, 44, 0, 8),
				BackgroundTransparency = 1,
				Text = tostring(c.id):sub(1, 18) .. "...",
				TextColor3 = Color3.fromRGB(60, 75, 110),
				Font = Enum.Font.Code,
				TextSize = 10,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		local d, I = c.playing or 0, c.maxPlayers or 20
		r = d / math.max(I, 1)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 80, 0, 14),
				Position = UDim2.new(0, 44, 0, 26),
				BackgroundTransparency = 1,
				Text = d .. "/" .. I .. " players",
				TextColor3 = Q.TEXT_DIM,
				Font = Enum.Font.Gotham,
				TextSize = 9,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 50, 0, 20),
				Position = UDim2.new(0, 210, 0, 4),
				BackgroundTransparency = 1,
				Text = tostring(d),
				TextColor3 = Q.TEXT_PRI,
				Font = Enum.Font.GothamBold,
				TextSize = 15,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		d = S(
			"Frame",
			{
				Size = UDim2.new(0, 50, 0, 2),
				Position = UDim2.new(0, 210, 0, 28),
				BackgroundColor3 = Color3.fromRGB(22, 24, 36),
				BorderSizePixel = 0,
			},
			W
		)
		L(1, d)
		L(
			1,
			S(
				"Frame",
				{ Size = UDim2.new(math.clamp(r, 0, 1), 0, 1, 0), BackgroundColor3 = C(r), BorderSizePixel = 0 },
				d
			)
		)
		d = c.ping or 999
		S(
			"TextLabel",
			{
				Size = UDim2.new(0, 55, 1, 0),
				Position = UDim2.new(0, 278, 0, 0),
				BackgroundTransparency = 1,
				Text = d .. "ms",
				TextColor3 = Z(d),
				Font = Enum.Font.GothamBold,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
			},
			W
		)
		d = S(
			"TextButton",
			{
				Size = UDim2.new(0, 72, 0, 28),
				Position = UDim2.new(1, -82, 0.5, -14),
				BackgroundColor3 = Color3.fromRGB(10, 30, 18),
				BorderSizePixel = 0,
				Text = "JOIN",
				TextColor3 = Q.GREEN,
				Font = Enum.Font.GothamBold,
				TextSize = 10,
			},
			W
		)
		L(3, d)
		K(d, Color3.fromRGB(10, 30, 18), Color3.fromRGB(8, 44, 24))
		d.MouseButton1Click:Connect(function()
			D("TELEPORTING TO " .. tostring(c.id):sub(1, 16) .. "...", Q.CYAN)
			local K, S = pcall(function()
				game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", c.id)
			end)
			if not K then
				D("TELEPORT FAILED: " .. tostring(S), Q.RED)
				V("TELEPORT FAILED", Q.RED)
			end
		end)
	end
	local function K()
		m()
		_()
		local S = #E.servers
		local L = math.min(S, l.MAX_SHOW)
		for d = 1, L, 1 do
			q(E.servers[d], d)
		end
		P.CanvasSize = UDim2.new(0, 0, 0, e.AbsoluteContentSize.Y + 16)
		H.Text = "SHOWING " .. L .. " / " .. S
		Y.Text = "PLACE \194\183 " .. tostring(R) .. " \194\183 PAGE " .. tostring(E.pages)
		if E.finished then
			V("CACHE DONE \226\128\148 " .. S .. " SERVERS", Q.GREEN_GLOW)
		else
			V("CACHE SAVED \226\128\148 " .. S .. " SERVERS \226\128\148 PAGE " .. E.pages, Q.CYAN)
		end
	end
	local function S()
		E.servers = {}
		E.cursor = nil
		E.finished = false
		E.lastUpdate = 0
		E.pages = 0
		F()
		m()
		H.Text = "SHOWING 0 / 0"
		Y.Text = "PLACE \194\183 " .. tostring(R)
		V("CACHE RESET", Q.RED)
		D("CACHE RESET", Q.RED)
	end
	local m = false
	local function L(d, I)
		if m then
			return
		end
		m = true
		if I then
			S()
		end
		y.Active = false
		x.Active = false
		k.Active = false
		y.Text = "LOADING"
		x.Text = "WAIT"
		local _, P = 0
		repeat
			if E.finished then
				break
			end
			_ += 1
			E.pages = E.pages + 1
			I = #E.servers > 0
			if I then
				B.Visible = false
			else
				B.Visible = true
				f.Text = "SCANNING PAGE " .. E.pages .. "\226\128\166"
			end
			V("PAGE " .. E.pages .. " \226\128\148 " .. #E.servers .. " FOUND", Q.AMBER)
			local e = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(R)
			local R, Y = N(if E.cursor then e .. "&cursor=" .. G:UrlEncode(E.cursor) else e, I)
			if not R then
				e = o(Y)
				if not I then
					f.Text = e
				end
				V(e, Q.RED)
				D(e, Q.RED)
				P = Y
				break
			end
			for G, G in ipairs(R.data or {}) do
				if G.id and G.id ~= game.JobId then
					e, Y = G.playing or 0, G.maxPlayers or 0
					if Y == 0 or e < Y then
						table.insert(E.servers, G)
					end
				end
			end
			E.cursor = R.nextPageCursor
			E.lastUpdate = tick()
			if not E.cursor or E.cursor == "" then
				E.finished = true
				E.cursor = nil
			end
			if not E.finished and _ < d then
				R = string.format("PAGE %d DONE \226\128\148 WAITING %.1fs\226\128\166", E.pages, l.PAGE_DELAY)
				if #E.servers > 0 then
					K()
					J(R)
				else
					f.Text = R
				end
				V(R, Q.CYAN)
				task.wait(l.PAGE_DELAY)
				F()
			end
		until _ >= d
		B.Visible = false
		F()
		K()
		if P then
			if #E.servers > 0 then
				D(o(P) .. " \226\128\148 SHOWING " .. #E.servers .. " CACHED", Q.AMBER)
				V(o(P) .. " | PARTIAL " .. #E.servers, Q.AMBER)
			else
				V(o(P), Q.RED)
			end
		elseif E.finished then
			V("FULL SCAN DONE \226\128\148 " .. #E.servers .. " SERVERS", Q.GREEN_GLOW)
			D("SCAN COMPLETE \226\128\148 " .. #E.servers .. " SERVERS", Q.GREEN_GLOW)
		else
			V("PAGE SAVED \226\128\148 CLICK LOAD MORE TO CONTINUE", Q.CYAN)
		end
		y.Active = true
		x.Active = true
		k.Active = true
		y.Text = "REFRESH"
		x.Text = "LOAD MORE"
		m = false
	end
	y.MouseButton1Click:Connect(function()
		task.spawn(function()
			local G = tick() - E.lastUpdate
			if #E.servers > 0 and G <= l.CACHE_TIME then
				K()
				D("CACHE STILL FRESH (" .. math.floor(l.CACHE_TIME - G) .. "s) \226\128\148 RESET TO RELOAD", Q.CYAN)
				return
			end
			L(2, true)
		end)
	end)
	x.MouseButton1Click:Connect(function()
		task.spawn(function()
			if E.finished then
				D("ALL PAGES LOADED \226\128\148 NO MORE SERVERS", Q.AMBER)
				V("NO MORE PAGES", Q.AMBER)
				return
			end
			L(2, false)
		end)
	end)
	k.MouseButton1Click:Connect(function()
		if not m then
			S()
		end
	end)
	task.spawn(function()
		L(2, true)
	end)
end)
StatusPlaceId = SectionServer.CreateLabel({ Title = "PlaceId: " .. game.PlaceId })
local G = ""
SectionServer.CreateBox(
	{ Title = "Input JobId Normal And JobId BananaCat", Placeholder = "Type here", Number = false, Default = nil },
	function(f)
		G = f
	end
)
SectionServer.CreateToggle({ Title = "Spam Join", Desc = nil, Default = Settings["Spam Join"] or false }, function(f)
	SaveSettings("Spam Join", f)
end)
if not (bit32 or bit) then
	({}).bxor = function(f, K)
		local R, m = 0, 1
		while f > 0 or K > 0 do
			local E, l = f % 2, K % 2
			f, K, R, m = (f - E) / 2, (K - l) / 2, if E ~= l then R + m else R, m * 2
		end
		return R
	end
end
-- ============================================================================
-- BANANA CAT JOB-ID CODEC — DEOBFUSCATED PASS 18
-- The original nested VM/string obfuscation is removed here.
-- This preserves the same binary key, 3-round transform, and custom Base64.
-- ============================================================================
local BananaCatJobIdKey = string.char(79,22,0,117,144,87,126,151,158,86,40,11,49,233,51,138,100,70,95,188,62,38,193,182,210,200,173,107,71,205,196,184)

local function BananaCatByte(s, i)
    return string.byte(s, i) or 0
end

local function BananaCatJoin(bytes)
    if #bytes == 0 then return "" end
    return string.char(table.unpack(bytes))
end

local function BananaCatKeyStream(keyMaterial, length)
    local stream, keyLength, state = {}, #keyMaterial, 0
    for i = 1, length do
        local position = ((i - 1) % keyLength) + 1
        local byte = BananaCatByte(keyMaterial, position)
        state = (state + byte + i + ((i * 11) % 256)) % 256
        stream[i] = (byte + state + (i * 17) + ((byte * 3) % 256)) % 256
    end
    return stream
end

local function BananaCatMixKeyMaterial(key, salt)
    local source = key .. salt .. key:reverse()
        .. string.char(#key % 256)
        .. string.char(#salt % 256)
    local out = {}
    for i = 1, #source do
        local byte = BananaCatByte(source, i)
        byte = bit32.bxor(byte, (i * 29) % 256)
        byte = (byte + ((i * 7) % 256)) % 256
        out[i] = string.char(byte)
    end
    return table.concat(out)
end

local function BananaCatDeriveStream(key, salt, length)
    return BananaCatKeyStream(
        BananaCatMixKeyMaterial(key, salt),
        length
    )
end

local function BananaCatRoundEncrypt(key, data, salt, roundIndex)
    local stream = BananaCatDeriveStream(key .. string.char(48 + roundIndex), salt, #data)
    local out = {}
    local state = (#key + #salt + roundIndex * 37 + 91) % 256

    for i = 1, #data do
        local dataByte = BananaCatByte(data, i)
        local saltByte = BananaCatByte(salt, ((i + roundIndex - 2) % 16) + 1)
        local keyByte = stream[i]

        state = (state + keyByte + saltByte + i + roundIndex) % 256
        local value = bit32.bxor(dataByte, keyByte)
        value = (value + state + saltByte) % 256
        value = bit32.bxor(value, ((i * 31) + saltByte + roundIndex * 9) % 256)
        value = (value + ((keyByte * 5) % 256)) % 256
        out[i] = string.char(value)
    end
    return table.concat(out)
end

local function BananaCatRoundDecrypt(key, data, salt, roundIndex)
    local stream = BananaCatDeriveStream(key .. string.char(48 + roundIndex), salt, #data)
    local out = {}
    local state = (#key + #salt + roundIndex * 37 + 91) % 256

    for i = 1, #data do
        local saltByte = BananaCatByte(salt, ((i + roundIndex - 2) % 16) + 1)
        local keyByte = stream[i]
        state = (state + keyByte + saltByte + i + roundIndex) % 256

        local value = BananaCatByte(data, i)
        value = (value - ((keyByte * 5) % 256)) % 256
        value = bit32.bxor(value, ((i * 31) + saltByte + roundIndex * 9) % 256)
        value = (value - state - saltByte) % 256
        value = bit32.bxor(value, keyByte)
        out[i] = string.char(value)
    end
    return table.concat(out)
end

local function BananaCatEncryptRounds(key, data, salt, rounds)
    local result = data
    rounds = rounds or 3
    for roundIndex = 1, rounds do
        result = BananaCatRoundEncrypt(key, result, salt, roundIndex)
    end
    return result
end

local function BananaCatDecryptRounds(key, data, salt, rounds)
    local result = data
    rounds = rounds or 3
    for roundIndex = rounds, 1, -1 do
        result = BananaCatRoundDecrypt(key, result, salt, roundIndex)
    end
    return result
end

local BananaCatBase64Alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local BananaCatBase64Reverse = {}
for i = 1, #BananaCatBase64Alphabet do
    BananaCatBase64Reverse[string.byte(BananaCatBase64Alphabet, i)] = i - 1
end

local function BananaCatBase64Encode(data)
    local out = {}
    local i = 1
    while i <= #data do
        local b1 = BananaCatByte(data, i)
        local b2 = i + 1 <= #data and BananaCatByte(data, i + 1) or 0
        local b3 = i + 2 <= #data and BananaCatByte(data, i + 2) or 0
        local n = b1 * 65536 + b2 * 256 + b3
        out[#out + 1] = string.sub(BananaCatBase64Alphabet, math.floor(n / 262144) % 64 + 1, math.floor(n / 262144) % 64 + 1)
        out[#out + 1] = string.sub(BananaCatBase64Alphabet, math.floor(n / 4096) % 64 + 1, math.floor(n / 4096) % 64 + 1)
        out[#out + 1] = i + 1 <= #data and string.sub(BananaCatBase64Alphabet, math.floor(n / 64) % 64 + 1, math.floor(n / 64) % 64 + 1) or "="
        out[#out + 1] = i + 2 <= #data and string.sub(BananaCatBase64Alphabet, n % 64 + 1, n % 64 + 1) or "="
        i = i + 3
    end
    return table.concat(out)
end

local function BananaCatBase64Decode(data)
    local out = {}
    local i = 1
    while i <= #data do
        local c1 = BananaCatByte(data, i)
        local c2 = BananaCatByte(data, i + 1)
        local c3 = BananaCatByte(data, i + 2)
        local c4 = BananaCatByte(data, i + 3)
        local n1 = c1 == 61 and 0 or (BananaCatBase64Reverse[c1] or 0)
        local n2 = c2 == 61 and 0 or (BananaCatBase64Reverse[c2] or 0)
        local n3 = c3 == 61 and 0 or (BananaCatBase64Reverse[c3] or 0)
        local n4 = c4 == 61 and 0 or (BananaCatBase64Reverse[c4] or 0)
        local n = n1 * 262144 + n2 * 4096 + n3 * 64 + n4
        out[#out + 1] = string.char(math.floor(n / 65536) % 256)
        if c3 ~= 61 then
            out[#out + 1] = string.char(math.floor(n / 256) % 256)
        end
        if c4 ~= 61 then
            out[#out + 1] = string.char(n % 256)
        end
        i = i + 4
    end
    return table.concat(out)
end

local function BananaCatRemovePrefix(value, prefix)
    if value:sub(1, #prefix) == prefix then
        return prefix == value and "" or value:sub(#prefix + 1)
    end
    return value
end

local function BananaCatGenerateSalt()
    local bytes = {}
    for i = 1, 16 do
        bytes[i] = string.char(math.random(0, 255))
    end
    return table.concat(bytes)
end

function BananaCatEncryptJobId(plainText)
    local salt = BananaCatGenerateSalt()
    local encrypted = BananaCatEncryptRounds(BananaCatJobIdKey, plainText, salt, 3)
    return "BananaCat-" .. BananaCatBase64Encode(salt .. encrypted)
end

function BananaCatDecryptJobId(encryptedValue)
    local decoded = BananaCatBase64Decode(
        BananaCatRemovePrefix(encryptedValue, "BananaCat-")
    )
    if #decoded < 16 then
        return ""
    end
    local salt = decoded:sub(1, 16)
    local encrypted = decoded:sub(17)
    return BananaCatDecryptRounds(BananaCatJobIdKey, encrypted, salt, 3)
end


Realm = require(game:GetService("ReplicatedStorage").Util.Realm)
function tryTeleport(K, R, m)
	local E, l = pcall(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(K, R, t)
	end)
	if E then
		m.done = true
	end
end
function teleportSmart(K)
	local R = Realm.safeGetCurrentSeaAsync()
	local m = {}
	local E = { done = false }
	for l, l in
		ipairs(
			if R == "Sea1"
				then { 2753915549, 85211729168715 }
				else if R == "Sea2"
					then { 4442272183, 79091703265657 }
					else if R == "Sea3" then { 7449423635, 100117331123089 } else m
		)
	do
		task.spawn(function()
			if not E.done then
				tryTeleport(l, K, E)
			end
		end)
	end
end
SectionServer.CreateButton({ Title = "Join JobId" }, function()
	if Settings["Spam Join"] then
		while task.wait() do
			local K = G
			local m = string.find
			game:GetService("ReplicatedStorage").__ServerBrowser
				:InvokeServer("teleport", if m(G, "BananaCat-") then BananaCatDecryptJobId(G) else K)
		end
	else
		local K = G
		local m = string.find
		game:GetService("ReplicatedStorage").__ServerBrowser
			:InvokeServer("teleport", if m(G, "BananaCat-") then BananaCatDecryptJobId(G) else K)
	end
end)
SectionServer.CreateButton({ Title = "Copy JobId" }, function()
	setclipboard(tostring(game.JobId))
end)
local G, K = {}, {}
if not pcall(function()
	readfile("Nexora Hub/Jobid.json")
end) then
	writefile("Nexora Hub/Jobid.json", game:GetService("HttpService"):JSONEncode(G))
end
if not pcall(function()
	readfile("Nexora Hub/NotSameServers.json")
end) then
	writefile("Nexora Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(G))
end
function CheckJobIdServer()
	local R, m, E, l = {}, next, game:GetService("HttpService"):JSONDecode(readfile("Nexora Hub/Jobid.json"))
	for Q, S in m, E, l do
		table.insert(R, Q)
	end
	return R
end
function HopServer(R)
	local function m()
		for E = 1, 100, 1 do
			for l, Q in pairs((game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(E))) do
				if l ~= game.JobId and not table.find(CheckJobIdServer(), l) then
					game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", l)
					pcall(function()
						writefile("Nexora Hub/Jobid.json", game:GetService("HttpService"):JSONEncode({ l }))
					end)
					pcall(function()
						getgenv().limit_type("clearAll")
					end)
					return
				end
			end
		end
	end
	local K = R or (Settings["Time Hop Server"] or 5)
	require(game:GetService("ReplicatedStorage").Notification)
		.new("<Color=Red>Nexora Hub : Wait " .. K .. "s [Hop Server]<Color=/>")
		:Display()
	while wait(K) do
		require(game:GetService("ReplicatedStorage").Notification)
			.new("<Color=Red>Nexora Hub : Hop Server<Color=/>")
			:Display()
		m()
	end
end
SectionServer.CreateButton({ Title = "Hop Server" }, function()
	HopServer()
end)
SectionServer.CreateButton({ Title = "Rejoin Server" }, function()
	-- Volta para o MESMO servidor (mesmo JobId).
	pcall(function()
		require(game:GetService("ReplicatedStorage").Notification)
			.new("<Color=Red>Nexora Hub : Rejoin Server<Color=/>")
			:Display()
	end)
	local ok = pcall(function()
		game:GetService("TeleportService"):TeleportToPlaceInstance(
			game.PlaceId,
			game.JobId,
			game:GetService("Players").LocalPlayer
		)
	end)
	if not ok then
		pcall(function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
		end)
	end
end)
function HopLessAll()
	require(game:GetService("ReplicatedStorage").Notification)
		.new("<Color=Red>Nexora Hub : Hop Server<Color=/>")
		:Display()
	local K, R, m, E = game.PlaceId, {}, "", os.date("!*t").hour
	if
		not pcall(function()
			R = game:GetService("HttpService"):JSONDecode(readfile("Nexora Hub/NotSameServers.json"))
		end)
	then
		table.insert(R, E)
		writefile("Nexora Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(R))
	end
	function HopServerLess()
		local l, Q =
			if m == ""
				then (game.HttpService:JSONDecode(
					game:HttpGet("https://games.roblox.com/v1/games/" .. K .. "/servers/Public?sortOrder=Asc&limit=100")
				))
				else (game.HttpService:JSONDecode(
					game:HttpGet(
						"https://games.roblox.com/v1/games/"
							.. K
							.. "/servers/Public?sortOrder=Asc&limit=100&cursor="
							.. m
					)
				)),
			""
		local K = l.nextPageCursor and l.nextPageCursor ~= "null" and l.nextPageCursor ~= nil
		if K then
			m = l.nextPageCursor
		end
		K = 0
		for m, S in pairs(l.data) do
			m = true
			Q = tostring(S.id)
			if tonumber(S.maxPlayers) > tonumber(S.playing) and tonumber(S.playing) <= 3 then
				for l, l in pairs(R) do
					if K ~= 0 then
						m = if Q == tostring(l) then false else m
					elseif tonumber(E) ~= tonumber(l) then
						pcall(function()
							delfile("Nexora Hub/NotSameServers.json")
							R = {}
							table.insert(R, E)
						end)
					end
					K += 1
				end
				if m == true then
					table.insert(R, Q)
					wait()
					pcall(function()
						writefile("Nexora Hub/NotSameServers.json", game:GetService("HttpService"):JSONEncode(R))
						wait()
						game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", Q)
						getgenv().limit_type("clearAll")
					end)
					wait(4)
				end
			end
		end
	end
	while wait() do
		HopServerLess()
	end
end
SectionServer.CreateButton({ Title = "Hop Server Less People" }, function()
	HopLessAll()
end)
function MoonTextureId()
	if game.PlaceId == getgenv().CheckPlaceId3 then
		return game:GetService("Lighting").Sky.MoonTextureId
	elseif game.PlaceId == getgenv().CheckPlaceId2 then
		return game:GetService("Lighting").FantasySky.MoonTextureId
	elseif game.PlaceId == getgenv().CheckPlaceId then
		return game:GetService("Lighting").Sky.MoonTextureId
	end
end
function CheckMoon()
	local K, R, m, E =
		"http://www.roblox.com/asset/?id=9709149431",
		"http://www.roblox.com/asset/?id=9709149052",
		MoonTextureId(),
		"Bad Moon"
	return if m == K or m == R then if m == K then "Full Moon" else if m == R then "Next Night" else E else E
end
function function6()
	return math.floor(game.Lighting.ClockTime)
end
function getServerTime()
	RealTime = tostring(math.floor(game.Lighting.ClockTime * 100) / 100)
	RealTime = tostring(game.Lighting.ClockTime)
	RealTimeTable = RealTime:split(".")
	Minute, Second = RealTimeTable[1], tonumber(0 + tonumber(RealTimeTable[2] / 100)) * 60
	return Minute, Second
end
function function8()
	local K = game.Lighting.ClockTime
	if CheckMoon() == "Full Moon" and K <= 5 then
		return tostring(function6()) .. " ( Will End Moon In " .. math.floor(5 - K) .. " Minutes )"
	elseif CheckMoon() == "Full Moon" and (K > 5 and K < 12) then
		return tostring(function6()) .. " ( Fake Moon )"
	elseif CheckMoon() == "Full Moon" and (K > 12 and K < 18) then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - K) .. " Minutes )"
	elseif CheckMoon() == "Full Moon" and (K > 18 and K <= 24) then
		return tostring(function6()) .. " ( Will End Moon In " .. math.floor(30 - K) .. " Minutes )"
	end
	if CheckMoon() == "Next Night" and K < 12 then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(18 - K) .. " Minutes )"
	elseif CheckMoon() == "Next Night" and K > 12 then
		return tostring(function6()) .. " ( Will Full Moon In " .. math.floor(30 - K) .. " Minutes )"
	end
	return tostring(function6())
end
function CheckAcientOneDracoStatus()
	if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
		if game.PlaceId == getgenv().CheckPlaceId then
			local K = game.workspace.HydraIslandClient.RemoteFunction:InvokeServer("Interacted")
			if K == 1 or K == 2 or K == 3 or K == 4 then
				return "Ready For Trial"
			end
		end
		return "You have yet to achieve greatness"
	end
	local K, R, m = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check", 2)
	if K == 1 then
		return "Required Train More"
	elseif K == 2 or K == 4 or K == 7 then
		return "Can Buy Gear With " .. m .. " Fragments"
	elseif K == 3 then
		return "Required Train More"
	elseif K == 5 then
		return "You Are Done Your Race."
	elseif K == 6 then
		return "Upgrades completed: " .. R - 2 .. "/3, Need Trains More"
	end
	if K ~= 8 then
		if K == 0 then
			return "Ready For Trial"
		else
			return "You have yet to achieve greatness"
		end
	end
	return "Remaining " .. 10 - R .. " training sessions."
end
do
	local function K()
		if not game.Players.LocalPlayer.Character:FindFirstChild("RaceTransformed") then
			return "You have yet to achieve greatness"
		end
		local R, m, E = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("UpgradeRace", "Check")
		if R == 1 then
			return "Required Train More"
		elseif R == 2 or R == 4 or R == 7 then
			return "Can Buy Gear With " .. E .. " Fragments"
		elseif R == 3 then
			return "Required Train More"
		elseif R == 5 then
			return "You Are Done Your Race."
		elseif R == 6 then
			return "Upgrades completed: " .. m - 2 .. "/3, Need Trains More"
		end
		if R ~= 8 then
			if R == 0 then
				return "Ready For Trial"
			else
				return "You have yet to achieve greatness"
			end
		end
		return "Remaining " .. 10 - m .. " training sessions."
	end
	local R
	local m = 0
	function CheckAcientOneStatus()
		if R and tick() - m < 1 then
			return R
		end
		R = K()
		m = tick()
		return R
	end
	function ResetRaceStatus()
		R = nil
	end
end
function CheckGoTrain()
	local K = CheckAcientOneStatus()
	if
		string.find(K, "Upgrades completed")
		or K == "Required Train More"
		or (string.find(K, "training sessions."))
		or (string.find(K, "Can Buy Gear"))
	then
		return true
	end
end
function CheckClockTime()
	local K = game.Lighting.ClockTime
	return if K >= 18 or K < 5 then "Night" else "Day"
end
function StatusCheckLeviathan()
	if game.PlaceId == getgenv().CheckPlaceId then
		if
			game:GetService("ReplicatedStorage")
				:WaitForChild("Remotes")
				:WaitForChild("CommF_")
				:InvokeServer("InfoLeviathan", "1") ~= -1
		then
			if
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("InfoLeviathan", "1") == 5
			then
				return "You can find leviathan now"
			else
				return "Buy Find leviathan"
			end
		else
			return "I DONT KNOW"
		end
	end
	return "Procurando..."
end
function IsMobAlive(K)
	if
		K
		and K.Parent
		and (K:FindFirstChild("HumanoidRootPart"))
		and (K:FindFirstChildWhichIsA("Humanoid"))
		and K.Humanoid.Health > 0
	then
		return true
	end
end
-- Helpers do Elite Hunter (compartilhados).
function EliteRequest()
	-- Vai na hora, sem espera dos 3 tracinhos
	getgenv().__EliteReq = tick()
	pcall(function()
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EliteHunter")
	end)
end
function EliteQuestOK(name)
	local txt, visible = "", false
	pcall(function()
		local G = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
		visible = G.Visible
		txt = G.Container.QuestTitle.Title.Text
	end)
	if visible then
		if name and string.find(txt, name, 1, true) then
			return true
		end
		for _, n in ipairs({ "Deandre", "Urban", "Diablo" }) do
			if string.find(txt, n, 1, true) then
				return true
			end
		end
	end
	-- Sem missão de elite: pede uma INSTANTANEO, sem esperar 5 segundos, já vai atrás
	getgenv().__EliteReq = tick()
	local R = game:GetService("ReplicatedStorage").Remotes.CommF_
	pcall(function()
		if visible then
			R:InvokeServer("AbandonQuest")
		end
		R:InvokeServer("EliteHunter")
	end)
	return false
end
local K = { "Deandre", "Urban", "Diablo" }
function DetectEliteHunter()
	local enemies = game:GetService("Workspace"):FindFirstChild("Enemies")
	if enemies then
		-- Caminho mais rápido: os Elites normalmente ficam diretamente em Workspace.Enemies.
		for _, name in ipairs(K) do
			local mob = enemies:FindFirstChild(name)
			if mob and mob:IsA("Model") and IsMobAlive(mob) then
				return mob
			end
		end
		-- Fallback para estruturas aninhadas.
		for _, mob in ipairs(enemies:GetDescendants()) do
			if mob:IsA("Model") and table.find(K, mob.Name) and IsMobAlive(mob) then
				return mob
			end
		end
	end
	local replicated = game:GetService("ReplicatedStorage")
	for _, name in ipairs(K) do
		local mob = replicated:FindFirstChild(name, true)
		if mob and mob:IsA("Model") and IsMobAlive(mob) then
			return mob
		end
	end
end
local K = 0
lastCheckTime = tick()
function GetOldestLocation()
	local R, m = 1 / 0
	for E, l in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
		E = l:GetAttribute("TimeIn")
		if E and E < R then
			R, m = E, l
		end
	end
	return m
end
task.spawn(function()
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local function setLabel(label, value)
		pcall(function() if label then label.SetText(tostring(value)) end end)
	end
	while task.wait(1) do
		-- Timers are independent so one unavailable remote/status cannot freeze the whole panel.
		pcall(function()
			local elapsed = math.max(0, workspace.DistributedGameTime)
			local h = math.floor(elapsed / 3600)
			local m = math.floor(elapsed % 3600 / 60)
			local sec = math.floor(elapsed % 60)
			setLabel(TimerLabel, string.format("Timer: %02dh %02dm %02ds", h, m, sec))
		end)
		pcall(function()
			local locations = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
			local oldest, oldestTime
			if locations then
				for _, loc in ipairs(locations:GetChildren()) do
					local t = loc:GetAttribute("TimeIn")
					if type(t) == "number" and (not oldestTime or t < oldestTime) then oldest, oldestTime = loc, t end
				end
			end
			if oldestTime then
				local elapsedServer = math.max(0, tick() - 25200 - oldestTime)
				local remain = 14400 - (elapsedServer % 14400)
				local sh, sm, ss = math.floor(elapsedServer / 3600), math.floor(elapsedServer % 3600 / 60), math.floor(elapsedServer % 60)
				local rh, rm, rs = math.floor(remain / 3600), math.floor(remain % 3600 / 60), math.floor(remain % 60)
				setLabel(TimerServerLabel, string.format("Server Timer: %02dh %02dm %02ds", sh, sm, ss))
				setLabel(NextTimerServerLabel, string.format("Next Time Spawn Fist of Darkness or God's Chalice: %02dh %02dm %02ds", rh, rm, rs))
				if rh == 0 and rm == 0 and rs <= 5 then getgenv().GoCollectChest = true end
			else
				setLabel(TimerServerLabel, "Server Timer: waiting for server time")
				setLabel(NextTimerServerLabel, "Next spawn estimate: waiting for server data")
			end
		end)
		pcall(function()
			setLabel(StatusEliteHunter, DetectEliteHunter() and "Elite: ✅ Spawned" or "Elite: ❌ Not spawned")
		end)
		pcall(function()
			local eyes = 0
			if game.PlaceId == getgenv().CheckPlaceId then
				local map = workspace:FindFirstChild("Map")
				local tiki = map and map:FindFirstChild("TikiOutpost")
				local island = tiki and tiki:FindFirstChild("IslandModel")
				if island then
					for i = 1, 4 do
						local eye = island:FindFirstChild("Eye" .. i, true)
						if eye and eye.Transparency == 1 then eyes = eyes + 1 end
					end
				end
			end
			K = eyes
			setLabel(StatusTyrant, "Tyrant Eyes: " .. tostring(eyes) .. "/4")
		end)
		pcall(function()
			local remote = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("CommF_")
			if remote then
				local result = remote:InvokeServer("CakePrinceSpawner", true)
				local text = tostring(result or "Unknown")
				setLabel(StatusKatakuri, "Cake Prince: " .. text:gsub("%D", "") .. " Mobs | " .. text)
				if text:find("open the portal now", 1, true) then remote:InvokeServer("CakePrinceSpawner") end
			end
		end)
		pcall(function() setLabel(Statusspy, "Leviathan: " .. tostring(StatusCheckLeviathan())) end)
		pcall(function()
			local map = workspace:FindFirstChild("Map")
			local found = map and map:FindFirstChild("MysticIsland")
			setLabel(StatusMirage, "Mirage Island: " .. (found and "✅ Spawned" or "❌ Not spawned"))
		end)
		pcall(function()
			local map = workspace:FindFirstChild("Map")
			local locs = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
			local found = (map and map:FindFirstChild("KitsuneIsland")) or (locs and locs:FindFirstChild("Kitsune Island"))
			setLabel(StatusKitsuneIsland, "Kitsune Island: " .. (found and "✅ Spawned" or "❌ Not spawned"))
		end)
		pcall(function()
			local map = workspace:FindFirstChild("Map")
			local found = map and map:FindFirstChild("PrehistoricIsland")
			setLabel(StatusPrehistoricIsland, "Prehistoric Island: " .. (found and "✅ Spawned" or "❌ Not spawned"))
		end)
		pcall(function()
			local locs = workspace:FindFirstChild("_WorldOrigin") and workspace._WorldOrigin:FindFirstChild("Locations")
			local found = locs and locs:FindFirstChild("Frozen Dimension")
			setLabel(StatusFrozenDimension, "Frozen Dimension: " .. (found and "✅ Spawned" or "❌ Not spawned"))
		end)
		pcall(function() setLabel(StatusGear, "Ancient One: " .. tostring(CheckAcientOneStatus())) end)
		pcall(function()
			if getgenv().StatusGearDraco then getgenv().StatusGearDraco.SetText("Draco: " .. tostring(CheckAcientOneDracoStatus())) end
		end)
		pcall(function() setLabel(StatusMoon, "Moon Phase: " .. tostring(CheckMoon()) .. " | " .. tostring(function8())) end)
	end
end)

LocalPlayerMain = Main.CreatePage({ Page_Name = "LocalPlayer", Page_Title = "LocalPlayer" })
SectionLocalPlayerMain = LocalPlayerMain.CreateSection("Local Player")
SectionLocalPlayerMain.CreateToggle(
	{
		Title = "Auto Translate",
		Desc = "It may take a bit longer to translate the first time.",
		Default = Settings["Auto Translate"] or false,
	},
	function(K)
		SaveSettings("Auto Translate", K)
	end
)
SectionLocalPlayerMain.CreateButton({ Title = "Stop Tween" }, function()
	getgenv().noclip = false
	TweenManager.CancelCurrent()
end)
SectionLocalPlayerMain.CreateButton({ Title = "Fix UI Button Game" }, function()
	require(game:GetService("ReplicatedStorage").Modules.LastInput).IsMobile = function()
		return true
	end
	wait(0.5)
	t.Character.Humanoid.Health = 0
end)
SectionLocalPlayerMain.CreateButton({ Title = "Load config in Web" }, function()
	local K = game:GetService("HttpService")
	game:GetService("RunService")
	local R, m, E = "https://cfg.banana-hub.xyz", getgenv().Key, game.Players.LocalPlayer.Name
	function ApplyConfigFromWeb(l)
		for Q, S in pairs(l) do
			if not S.name then
				continue
			end
			Q = Options[S.name]
			if Q and S then
				if S.value ~= nil and Q.type ~= "slider_dropdown" and Q.type ~= "priority_dropdown" then
					if Q.FunctionCreate and Q.FunctionCreate.SetValue then
						if Q.type == "box" then
							Q.FunctionCreate.SetValue(tostring(S.value))
						elseif Q.type == "dropdown" then
							Q.FunctionCreate.SetValue(S.value)
						elseif Q.type == "slider" then
							Q.FunctionCreate.SetValue(S.value)
						else
							Q.FunctionCreate:SetValue(S.value)
						end
					elseif Q.FunctionCreate and Q.FunctionCreate.SetStage then
						Q.FunctionCreate.SetStage(S.value)
					end
				end
				if Q.type == "priority_dropdown" and S.selected then
					if Q.FunctionCreate and Q.FunctionCreate.SetValue then
						Q.FunctionCreate.SetValue(S.selected)
					end
				end
				if Q.type == "slider_dropdown" and S.values then
					for l, L in pairs(S.values) do
						if Q.FunctionCreate and Q.FunctionCreate.SetSubValue then
							Q.FunctionCreate:SetSubValue(l, L)
						end
					end
				end
			end
		end
	end
	local l, Q = pcall(function()
		return request({
			Url = string.format("%s/config/get?authId=%s&userId=%s&roblox=true", R, K:UrlEncode(m), K:UrlEncode(E)),
			Method = "GET",
		})
	end)
	if l and Q.StatusCode == 200 then
		ApplyConfigFromWeb((K:JSONDecode(Q.Body)))
	end
end)
SectionLocalPlayerMain.CreateButton(
	{ Title = "Push Data To Web ( just push when join game,if push again plz rejoin )" },
	function()
		local K, R = game:GetService("HttpService"), "https://cfg.banana-hub.xyz"
		function BuildSchema()
			local m, E = {}, 1
			for l, Q in pairs(Options) do
				local S, L, d = Q.Page_Name or "Default Page", Q.Section_Name or "Default Section", tostring(E)
				if Q.type == "toggle" then
					m[d] = { name = l, type = "toggle", value = Q.value, page = S, section = L }
				elseif Q.type == "button" then
					m[d] = { name = l, type = "button", value = l, text = l, page = S, section = L }
				elseif Q.type == "textlabel" then
					local I = Q.FunctionCreate and Q.FunctionCreate.GetText and (Q.FunctionCreate.GetText())
						or Q.text
						or l
					m[d] = {
						name = l,
						type = "label",
						value = I,
						text = I,
						color = Q.color or "#B8B8B8",
						size = Q.size or "14px",
						bold = Q.bold or false,
						page = S,
						section = L,
					}
				elseif Q.type == "box" then
					m[d] = { name = l, type = "box", value = Q.value or "", page = S, section = L }
				elseif Q.type == "slider" then
					m[d] = {
						name = l,
						type = "slider",
						min = Q.min or 0,
						max = Q.max or 100,
						step = Q.step or 1,
						value = Q.value or Q.min or 0,
						page = S,
						section = L,
					}
				elseif Q.type == "dropdown" then
					m[d] = {
						name = l,
						type = "dropdown",
						options = table.clone(Q.list or {}),
						value = Q.value or Q.list and Q.list[1] or "",
						page = S,
						section = L,
					}
				elseif Q.type == "priority_dropdown" then
					local I = table.clone(Q.value or {})
					m[d] = {
						name = l,
						type = "priority_dropdown",
						options = table.clone(Q.list or {}),
						selected = I,
						value = I,
						page = S,
						section = L,
					}
				elseif Q.type == "multi_toggle" then
					m[d] = {
						name = l,
						type = "multi_toggle",
						options = table.clone(Q.list or {}),
						value = table.clone(Q.value or {}),
						page = S,
						section = L,
					}
				elseif Q.type == "slider_dropdown" then
					local I, _ = {}, {}
					for o, V in pairs(Q.list or {}) do
						I[o] = { min = V.min or 0, max = V.max or 100, step = V.step or 1 }
						_[o] = Q.value and Q.value[o] or V.Default or V.min or 0
					end
					m[d] = { name = l, type = "slider_dropdown", sliders = I, values = _, page = S, section = L }
				end
				E += 1
			end
			return m
		end
		function UploadSchemaToWeb(m, E)
			if not m or not E then
				return false
			end
			local l = BuildSchema()
			local Q, S = pcall(function()
				return request({
					Url = string.format("%s/schema/init?authId=%s&userId=%s", R, K:UrlEncode(m), K:UrlEncode(E)),
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = K:JSONEncode(l),
				})
			end)
			if Q and S.StatusCode == 200 then
				return true
			end
			if Q and S.StatusCode == 409 then
				return true
			end
			return false
		end
		function PushSchemaToWebupdate(m, E)
			if not m or not E then
				return
			end
			local l = BuildSchema()
			local Q, S = pcall(function()
				return request({
					Url = string.format("%s/schema/update?authId=%s&userId=%s", R, K:UrlEncode(m), K:UrlEncode(E)),
					Method = "POST",
					Headers = { ["Content-Type"] = "application/json" },
					Body = K:JSONEncode(l),
				})
			end)
			if Q and S.StatusCode == 200 then
			else
			end
		end
		local m, E = getgenv().Key, game.Players.LocalPlayer.Name
		request({
			Url = "https://cfg.banana-hub.xyz/config/get?authId=" .. m .. "&userId=" .. E .. "&roblox=true",
			Method = "GET",
		})
		function ForceResetSchema(l, Q)
			pcall(function()
				request({
					Url = string.format("%s/schema/delete?authId=%s&userId=%s", R, K:UrlEncode(l), K:UrlEncode(Q)),
					Method = "DELETE",
				})
			end)
			wait(0.5)
			return UploadSchemaToWeb(l, Q)
		end
		ForceResetSchema(m, E)
	end
)
local K = require(game.ReplicatedStorage:WaitForChild("Controllers"):WaitForChild("UI"):WaitForChild("Inventory"))
SectionLocalPlayerMain.CreateButton({ Title = "Show Item" }, function()
	if not game:GetService("CoreGui").ExperienceChat.bubbleChat:FindFirstChild("Right") then
		local R, m, E = game.Players.LocalPlayer, game:GetService("CoreGui"), game:GetService("ReplicatedStorage")
		if not K.IsOpen then
			K:Open()
			task.wait(2)
		end
		local l, Q, S = R.PlayerGui.Inventory.Frame.Main.PageContent.Inner.TileGrid.Inner.Container, {}, {}
		t.PlayerGui:WaitForChild("Inventory"):WaitForChild("Frame")
		l.CanvasPosition = Vector2.new(0, 0)
		local L, d = l.CanvasSize.Y.Offset - l.AbsoluteWindowSize.Y, 0
		while l.CanvasPosition.Y < L and (task.wait(0.1)) do
			l.CanvasPosition = Vector2.new(0, d)
			for I, _ in pairs(l:GetChildren()) do
				if _:FindFirstChild("Details") and (_.Details:FindFirstChild("Line-1")) then
					I = _.Details["Line-1"].ContentText
						.. (_.Details:FindFirstChild("Line-2") and _.Details["Line-2"].ContentText or "")
					if not Q[I] then
						Q[I] = true
						table.insert(S, _:Clone())
					end
				end
			end
			d += 20
		end
		Q = { "Left", "Right" }
		for I, I in ipairs(Q) do
			l = m.ExperienceChat.bubbleChat:FindFirstChild(I)
			if l then
				l:Destroy()
			end
		end
		L = Instance.new("Frame", m.ExperienceChat.bubbleChat)
		L.Name = "Left"
		L.BackgroundTransparency = 1
		L.Size = UDim2.new(0.5, 0, 1, 0)
		Q = Instance.new("Frame", m.ExperienceChat.bubbleChat)
		Q.Name = "Right"
		Q.BackgroundTransparency = 1
		Q.Position = UDim2.new(0.5, 0, 0, 0)
		Q.Size = UDim2.new(0.5, 0, 1, 0)
		local function I(_)
			local o = Instance.new("UIListLayout", _)
			o.FillDirection = Enum.FillDirection.Vertical
			o.HorizontalAlignment = Enum.HorizontalAlignment.Center
			o.SortOrder = Enum.SortOrder.LayoutOrder
			o.Padding = UDim.new(0, 10)
			return o
		end
		I(L)
		I(Q)
		local function _(o)
			local V = Instance.new("UIGridLayout", o)
			V.CellPadding = UDim2.new(0, 8, 0, 8)
			V.CellSize = UDim2.new(0, 70, 0, 70)
			V.FillDirectionMaxCells = 8
			V.FillDirection = Enum.FillDirection.Horizontal
			V.SortOrder = Enum.SortOrder.LayoutOrder
			return V
		end
		l = Instance.new("Frame", L)
		l.BackgroundTransparency = 1
		l.Size = UDim2.new(1, 0, 0, 0)
		l.AutomaticSize = Enum.AutomaticSize.Y
		l.LayoutOrder = 1
		_(l)
		L = Instance.new("Frame", Q)
		L.BackgroundTransparency = 1
		L.Size = UDim2.new(1, 0, 0, 0)
		L.AutomaticSize = Enum.AutomaticSize.Y
		L.LayoutOrder = 1
		_(L)
		d = { Vector2.new(218, 225), Vector2.new(436, 225) }
		for o, o in ipairs(S) do
			I = o.Details.Category.ContentText
			if I == "Blox Fruit" and (table.find(d, o.ImageRectOffset)) then
				o.Parent = L
			elseif I ~= "Blox Fruit" then
				o.Parent = l
			end
		end
		S = Instance.new("Frame", Q)
		S.BackgroundTransparency = 1
		S.Size = UDim2.new(1, 0, 0, 0)
		S.AutomaticSize = Enum.AutomaticSize.Y
		S.LayoutOrder = 100
		_(S)
		local L, d, I =
			{
				Superhuman = Vector2.new(3, 2),
				DeathStep = Vector2.new(4, 3),
				ElectricClaw = Vector2.new(2, 0),
				SharkmanKarate = Vector2.new(0, 0),
				DragonTalon = Vector2.new(1, 5),
				Godhuman = "rbxassetid://10338473987",
			},
			{},
			{}
		for o, V in pairs(L) do
			if E.Remotes.CommF_:InvokeServer("Buy" .. o, true) == 1 then
				l = Instance.new("ImageLabel", S)
				l.BackgroundTransparency = 1
				if type(V) == "string" then
					l.Image = V
				else
					l.Image = "rbxassetid://9945562382"
					l.ImageRectSize = Vector2.new(100, 100)
					l.ImageRectOffset = V * 100
				end
				I[o] = l
				table.insert(d, o)
			end
		end
		local function S()
			local L = Instance.new("TextLabel")
			L.BackgroundTransparency = 1
			L.Size = UDim2.new(0.5, 0, 0.5, 0)
			L.Position = UDim2.new(0.5, 0, 0.5, 0)
			L.Font = Enum.Font.GothamBold
			L.TextColor3 = Color3.fromRGB(255, 255, 255)
			L.TextSize = 10
			L.TextXAlignment = Enum.TextXAlignment.Right
			L.TextYAlignment = Enum.TextYAlignment.Bottom
			L.ZIndex = 5
			return L
		end
		local function L(o)
			for V, V in pairs(R.Backpack:GetChildren()) do
				if V.Name:gsub(" ", "") == o then
					return V
				end
			end
		end
		spawn(function()
			local o, V = #d, 0
			while V < o do
				for d, o in pairs(I) do
					if not o:FindFirstChild("Ditme") then
						E.Remotes.CommF_:InvokeServer("Buy" .. d)
						task.wait(0.1)
						local E = L(d)
						if E then
							E:WaitForChild("Level")
							local L = S()
							L.Name = "Ditme"
							L.Text = E.Level.Value
							L.Parent = o
							V += 1
						end
					end
				end
				task.wait()
			end
		end)
		task.wait(2)
		R.PlayerGui.Main.AwakeningToggler.Visible = true
		l = R.PlayerGui.Main.AwakeningToggler:Clone()
		l.LayoutOrder = 101
		R.PlayerGui.Main.AwakeningToggler.Visible = false
		l.Parent = Q
		l.Size = UDim2.new(1, 0, 0.3, 0)
		local function E(l)
			return tostring(l):reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
		end
		_ = R.PlayerGui.Main.Fragments:Clone()
		_.Parent = m.ExperienceChat.bubbleChat
		_.Position = UDim2.new(0, 6, 0.85799, 0)
		_.Text = "\198\146" .. E(R.Data.Fragments.Value)
		wait(2)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.MenuButton.Visible = false
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.HP.Visible = false
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Energy.Visible = false
		end)
		for R, R in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main:GetChildren()) do
			if R:IsA("ImageButton") then
				R.Visible = false
			end
		end
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Visible = false
		end)
		K:Close()
	else
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.MenuButton.Visible = true
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.HP.Visible = true
		end)
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Energy.Visible = true
		end)
		for K, K in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main:GetChildren()) do
			if K:IsA("ImageButton") then
				K.Visible = true
			end
		end
		pcall(function()
			game:GetService("Players").LocalPlayer.PlayerGui.Main.Compass.Visible = true
		end)
		for K, K in pairs(game:GetService("CoreGui").ExperienceChat.bubbleChat:GetChildren()) do
			if K.Name == "Left" or K.Name == "Right" or K.Name == "Fragments" then
				K:Destroy()
			end
		end
	end
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop" }, function()
	local K = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
	K.init()
	K:Open()
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Devil Fruit Shop Mirage" }, function()
	local K = require(game.ReplicatedStorage.Controllers.UI.FruitShop)
	K.init()
	K:Open("AdvancedFruitDealer")
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Title" }, function()
	game:GetService("Players").LocalPlayer.PlayerGui.Main.Titles.Visible = true
end)
SectionLocalPlayerMain.CreateButton({ Title = "Open Color" }, function()
	game:GetService("Players").LocalPlayer.PlayerGui.Main.Colors.Visible = true
end)
SectionLocalPlayerMain.CreateDropdown(
	{
		Title = "Select Stats",
		List = PrepareMultiSelectList(
			{ Melee = false, Defense = false, Sword = false, Gun = false, ["Demon Fruit"] = false },
			Settings["Select Stats"]
		),
		Search = true,
		Selected = true,
		Default = Settings["Select Stats"] or nil,
	},
	function(K, R)
		SaveSettings("Select Stats", K, R)
	end
)
SectionLocalPlayerMain.CreateToggle(
	{ Title = "Auto Stats", Desc = nil, Default = Settings["Auto Stats"] or false },
	function(K)
		spawn(function()
			while Settings["Auto Stats"] and (task.wait(0.3)) do
				pcall(function()
					for R, m in next, Settings["Select Stats"], nil do
						if
							m
							and game.Players.localPlayer.Data.Points.Value > 0
							and game:GetService("Players").LocalPlayer.Data.Stats[R].Level.Value < 2800
						then
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AddPoint", R, 9999)
							wait(3)
						end
					end
				end)
			end
		end)
		SaveSettings("Auto Stats", K)
	end
)
SectionLocalPlayerMain.CreateDropdown(
	{
		Title = "Select Team",
		List = { "Pirate", "Marine" },
		Search = true,
		Selected = false,
		Default = Settings["Select Team"] or nil,
	},
	function(K)
		SaveSettings("Select Team", K)
	end
)
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Change Team", List = { "Pirates", "Marines" }, Search = true, Selected = false, Default = nil },
	function(K)
		if K then
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack({ [1] = "SetTeam", [2] = K }))
		end
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Noclip", Desc = nil, Default = Settings.Noclip or false }, function(K)
	SaveSettings("Noclip", K)
end)
local K
function SetRobloxGUI(R)
	game.CoreGui.RobloxGui.Enabled = R
end
spawn(function()
	local R = tick()
	repeat
		wait(1)
		if tick() - R > 179 then
			game:Shutdown()
			wait(10)
		end
	until game:FindFirstChild("CoreGui") and game.Players.LocalPlayer and game.Players.LocalPlayer.Character
	R = tick()
	repeat
		wait(1)
		if tick() - R > 169 then
			game:Shutdown()
			wait(10)
		end
	until game.Players.LocalPlayer:FindFirstChild("Backpack") and (game.Players.LocalPlayer:GetMouse())
	R = Instance.new("ScreenGui")
	R.Parent = game:GetService("Players").LocalPlayer.PlayerGui
	R.ResetOnSpawn = false
	getgenv().SCGUI = R
	repeat
		wait(1)
	until SCGUI
	K = Instance.new("ImageLabel", SCGUI)
	K.BackgroundColor3 = Color3.fromRGB(4, 10, 26)
	K.Position = UDim2.new(0, 0, 0, -50)
	K.Size = UDim2.new(1, 0, 1, 50)
	K.Visible = false
	K.Name = "Black Screen"
	getgenv().BS_Text = Instance.new("TextLabel", K)
	BS_Text.TextSize = 30
	BS_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
	BS_Text.AnchorPoint = Vector2.new(0.5, 0)
	BS_Text.Position = UDim2.new(0.5, 0, 0.6, 0)
	BS_Text.Font = Enum.Font.SourceSansBold
	BS_Text.RichText = true
	BS_Default = '\10<font color="rgb(45, 45, 45)"><font size="20">Black Screen</font></font>'
	getgenv().UpdateBlackScreenText = function(R)
		BS_Text.Text = R .. BS_Default
	end
	UpdateBlackScreenText("")
	getgenv().DisableBlackScreen = false
end)
local R, m = {}, {}
for E, E in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
	if not string.find(E.Name, "Boat") and not string.find(E.Name, "Set Home") then
		table.insert(R, E.Name)
		table.insert(m, E)
	end
end
for E, E in pairs(game:GetService("ReplicatedStorage").NPCs:GetChildren()) do
	if not string.find(E.Name, "Boat") and not string.find(E.Name, "Set Home") then
		table.insert(R, E.Name)
		table.insert(m, E)
	end
end
local E = {}
if game.PlaceId == getgenv().CheckPlaceId3 then
	E = {
		["Start Island"] = CFrame.new(1071.2832, 16.3085976, 1426.86792),
		["Marine Start"] = CFrame.new(-2573.3374, 6.88881969, 2046.99817),
		["Middle Town"] = CFrame.new(-655.824158, 7.88708115, 1436.67908),
		Jungle = CFrame.new(-1249.77222, 11.8870859, 341.356476),
		["Pirate Village"] = CFrame.new(-1122.34998, 4.78708982, 3855.91992),
		Desert = CFrame.new(1094.14587, 6.47350502, 4192.88721),
		["Frozen Village"] = CFrame.new(1198.00928, 27.0074959, -1211.73376),
		MarineFord = CFrame.new(-4505.375, 20.687294, 4260.55908),
		Colosseum = CFrame.new(-1428.35474, 7.38933945, -3014.37305),
		["Sky 1st Floor"] = CFrame.new(-4970.21875, 717.707275, -2622.35449),
		["Sky 2st Floor"] = CFrame.new(-4813.0249, 903.708557, -1912.69055),
		["Sky 3st Floor"] = CFrame.new(-7952.31006, 5545.52832, -320.704956),
		Prison = CFrame.new(4854.16455, 5.68742752, 740.194641),
		["Magma Village"] = CFrame.new(-5231.75879, 8.61593437, 8467.87695),
		["UndeyWater City"] = CFrame.new(61163.8516, 11.7796879, 1819.78418),
		["Fountain City"] = CFrame.new(5132.7124, 4.53632832, 4037.8562),
		["House Cyborg's"] = CFrame.new(6262.72559, 71.3003616, 3998.23047),
		["Shank's Room"] = CFrame.new(-1442.16553, 29.8788261, -28.3547478),
		["Mob Island"] = CFrame.new(-2850.20068, 7.39224768, 5354.99268),
	}
elseif game.PlaceId == getgenv().CheckPlaceId2 then
	E = {
		["First Spot"] = CFrame.new(82.9490662, 18.0710983, 2834.98779),
		["Kingdom of Rose"] = game.Workspace._WorldOrigin.Locations["Kingdom of Rose"].CFrame,
		["Dark Ares"] = game.Workspace._WorldOrigin.Locations["Dark Arena"].CFrame,
		["Flamingo Mansion"] = CFrame.new(-390.096313, 331.886475, 673.464966),
		["Flamingo Room"] = CFrame.new(2302.19019, 15.1778421, 663.811035),
		["Green bit"] = CFrame.new(-2372.14697, 72.9919434, -3166.51416),
		Cafe = CFrame.new(-385.250916, 73.0458984, 297.388397),
		Factroy = CFrame.new(430.42569, 210.019623, -432.504791),
		Colosseum = CFrame.new(-1836.58191, 44.5890656, 1360.30652),
		["Ghost Island"] = CFrame.new(-5571.84424, 195.182297, -795.432922),
		["Ghost Island 2nd"] = CFrame.new(-5931.77979, 5.19706631, -1189.6908),
		["Snow Mountain"] = CFrame.new(1384.68298, 453.569031, -4990.09766),
		["Hot and Cold"] = CFrame.new(-6026.96484, 14.7461271, -5071.96338),
		["Magma Side"] = CFrame.new(-5478.39209, 15.9775667, -5246.9126),
		["Cursed Ship"] = CFrame.new(902.059143, 124.752518, 33071.8125),
		["Frosted Island"] = CFrame.new(5400.40381, 28.21698, -6236.99219),
		["Forgotten Island"] = CFrame.new(-3043.31543, 238.881271, -10191.5791),
		["Usoapp Island"] = CFrame.new(4748.78857, 8.35370827, 2849.57959),
		["Raids Low"] = CFrame.new(-5554.95313, 329.075623, -5930.31396),
		Minisky = CFrame.new(-260.358917, 49325.7031, -35259.3008),
	}
elseif game.PlaceId == getgenv().CheckPlaceId then
	E = {
		["Port Town"] = CFrame.new(-287, 30, 5388),
		["Hydar Island"] = CFrame.new(
			3399.32227,
			72.4142914,
			1572.99963,
			-0.809679806,
			-4.48284467E-8,
			0.586871922,
			2.42332163E-8,
			1,
			1.09818842E-7,
			-0.586871922,
			1.0313989E-7,
			-0.809679806
		),
		["Room Enma/Yama & Secret Temple"] = CFrame.new(5247, 7, 1097),
		["House Hydar Island"] = CFrame.new(5245, 602, 251),
		["Great Tree"] = CFrame.new(2443, 36, -6573),
		["Castle on the sea"] = CFrame.new(-5500, 314, -2855),
		Mansion = CFrame.new(-12548, 337, -7481),
		["Floating Turtle"] = CFrame.new(-10016, 332, -8326),
		["Haunted Castle"] = CFrame.new(-9509.34961, 142.130661, 5535.16309),
		["Peanut Island"] = CFrame.new(-2131, 38, -10106),
		["Ice Cream Island"] = CFrame.new(-950, 59, -10907),
		CakeLoaf = CFrame.new(-1762, 38, -11878),
		Tiki = CFrame.new(-16204.0810546875, 9.0863618850708, 479.2259521484375),
	}
end
b = {}
for l, Q in next, E, nil do
	table.insert(b, l)
end
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Select Npc", List = R, Search = true, Selected = false, Default = nil },
	function(l)
		g["Select Npc"] = l
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Npc", Desc = nil, Default = false }, function(l)
	g["Teleport To Npc"] = l
end)
SectionLocalPlayerMain.CreateDropdown(
	{ Title = "Select Island", List = b, Search = true, Selected = false, Default = nil },
	function(l)
		g["Select Island"] = l
	end
)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport To Island", Desc = nil, Default = false }, function(l)
	g["Teleport To Island"] = l
end)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Mirage", Desc = nil, Default = false }, function(l)
	g["Teleport Mirage"] = l
end)
SectionLocalPlayerMain.CreateToggle({ Title = "Teleport Prehistoric Island", Desc = nil, Default = false }, function(l)
	g["Teleport Prehistoric Island"] = l
end)
function DetectPrehistoricIsland()
	local l, Q, S = next, workspace._WorldOrigin.Locations:GetChildren()
	for L, L in l, Q, S do
		if L.Name == "Prehistoric Island" and (L:GetAttribute("CFrame")) then
			return L
		end
	end
end

function ResetAirState()
	pcall(function()
		getgenv().noclip = false
		if TweenManager and TweenManager.CancelCurrent then
			TweenManager.CancelCurrent()
		end
		local Players = game:GetService("Players")
		local LocalPlayer = Players.LocalPlayer
		local char = LocalPlayer and LocalPlayer.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then
					part.CanCollide = true
				end
			end
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				hum.PlatformStand = false
				pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
			end
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then
				for _, obj in ipairs(root:GetChildren()) do
					if obj.Name == "FloatForce" or obj:IsA("BodyVelocity") or obj:IsA("BodyForce") or obj:IsA("BodyGyro") or obj:IsA("BodyPosition") then
						obj:Destroy()
					end
				end
				root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end
		end
		-- Reseta barco também
		pcall(function()
			local boat = checkboat()
			if boat then
				TurnOffNoclipBoat(boat)
			end
		end)
	end)
end


-- FAILSAFE: Se desativar qualquer toggle e ficar preso no ar, volta ao normal INSTANTANEO
function ForceResetAirState()
	pcall(function()
		getgenv().noclip = false
		local char = game:GetService("Players").LocalPlayer.Character
		if not char then return end
		local root = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if root then
			root.AssemblyLinearVelocity = Vector3.new(0,0,0)
			root.AssemblyAngularVelocity = Vector3.new(0,0,0)
			for _, v in ipairs(root:GetChildren()) do
				if v:IsA("BodyVelocity") or v:IsA("BodyGyro") or v:IsA("BodyPosition") or v.Name == "FloatForce" then
					v:Destroy()
				end
			end
			for _, v in ipairs(char:GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = true
				end
			end
		end
		if hum then
			hum.PlatformStand = false
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)
end

-- Hook em TODAS as toggles: quando desativa, reseta na hora
pcall(function()
	local oldSave = SaveSettings
	if oldSave then
		_G.SaveSettings = function(name, value, ...)
			pcall(oldSave, name, value, ...)
			if value == false then
				task.spawn(function()
					task.wait(0.1)
					ForceResetAirState()
				end)
			end
		end
	end
end)

task.spawn(function()
	while task.wait(0.5) do
		pcall(function()
			local char = game:GetService("Players").LocalPlayer.Character
			if not char then return end
			local root = char:FindFirstChild("HumanoidRootPart")
			if not root then return end
			local anyActive = Settings["Raise Boat Manual Drive"] or Settings["Fly Boat"] or Settings["Start Farm"] or Settings["Auto Find Leviathan"] or Settings["Auto Find Prehistoric Island"] or Settings["Auto Multi Find Prehistoric Island"] or Settings["Auto Event Prehistoric Island"] or Settings["Auto Sea Event"] or Settings["Teleport To Fruit"] or Settings["Auto Farm Level"] or Settings["Tween Boat To Frozen Dimension"] or Settings["Multi Find Leviathan"] or Settings["Auto Farm Bone"] or Settings["Auto Farm Ectoplasm"] or Settings["Auto Elite Hunter"] or Settings["Auto Factory"] or Settings["Auto Raid"] or Settings["Tween Safe if have Items"] or Settings["Auto Present Event"] or Settings["Auto Celestial Soldier"] or Settings["Auto Attack Dungeon"] or Settings["Auto Fishing"] or Settings["Auto Get Ghoul"] or Settings["Auto Get Cyborg"] or Settings["Auto Trial"] or Settings["Auto Pull Lever"] or Settings["Drive Boat To Tiki"] or Settings["Drive Boat To Hydra"] or Settings["Auto Fire Shoot Heart Leviathan"]
			if not anyActive and getgenv().noclip then
				ForceResetAirState()
			end
		end)
	end
end)


function SetNoClip(l)
	getgenv().noclip = l
	local Q = t.Character
	if not Q then
		return
	end
	local S, L = Q:FindFirstChild("HumanoidRootPart"), Q:FindFirstChildOfClass("Humanoid")
	if not l then
		for l, l in ipairs(Q:GetDescendants()) do
			if l:IsA("BasePart") then
				l.CanCollide = true
			end
		end
		if L then
			L.PlatformStand = false
		end
		if S and (S:FindFirstChild("FloatForce")) and not ToggleNoclip() then
			S.FloatForce:Destroy()
		end
	end
end
function ToggleNoclip()
	if
		Settings["Auto Farm Active"]
		or Settings["Start Farm"]
		or Settings["Auto Present Event"]
		or Settings["Auto Celestial Soldier"]
		or Settings["Auto Rip Commander"]
		or Settings["Auto Event Halloween"]
		or Settings["Auto Attack Dungeon"]
		or Settings["Auto Fishing"]
		or Settings["Teleport To Fruit"]
		or Settings["Auto Factory"]
		or Settings["Auto Pirate Raid"]
		or Settings["Auto Elite Hunter"]
		or Settings["Auto Touch Pad Haki"]
		or Settings["Auto Summon Rip Indra"]
		or Settings["Attack Rip Indra"]
		or Settings["Attack Soul Reaper"]
		or Settings["Attack Dough King"]
		or Settings["Attack Darkbeard"]
		or Settings["Auto Raid"]
		or Settings["Auto Sea Event"]
		or Settings["Auto Shipwright"]
		or Settings["Teleport Acient Clock"]
		or Settings["Auto Upgrade Race V2-V3"]
		or Settings["Auto Trial"]
		or Settings["Auto Get Ghoul"]
		or Settings["Auto Get Cyborg"]
		or Settings["Auto Pull Lever"]
		or g["Teleport Mirage"]
		or g["Teleport To Island"]
		or g["Teleport To Npc"]
		or g["Teleport Prehistoric Island"]
		or g["Sanguine Art"]
		or g["God Human"]
		or g["Dragon Talon"]
		or g["Electric Claw"]
		or g["Sharkman Karate"]
		or g["Death Step"]
		or g.SuperHuman
		or g.DragonClaw
		or g.Electro
		or g["Fishman Karate"]
		or g["Black Leg"]
		or Settings["Teleport To Kitsune Island"]
		or Settings["Auto Spawn Kitsune Island"]
		or Settings["Auto Collect Soul Ember"]
		or Settings["Auto Summon Soul Ember"]
		or Settings["Auto Attack Leviathan"]
		or Settings["Auto Soul Guitar"]
		or Settings["Auto CDK"]
		or Settings["Auto Yama"]
		or Settings["Auto Tushita"]
		or Settings["Auto Upgrade Sword Inventory"]
		or Settings["Teleport Player"]
		or Settings["Auto Chest"]
		or Settings["Farm Observation"]
		or Settings["Auto Upgrade Gun Inventory"]
		or Settings["Kill Boss"]
		or Settings["Kill Mob"]
		or Settings["Auto UP Observation V2"]
		or Settings["Auto New World"]
		or Settings["Auto Third World"]
		or Settings["Tween Safe if have Items"]
		or Settings["Teleport Frozen Dimension"]
		or Settings["Auto Yoru Mini"]
		or Settings["Auto Quest Dojo Trainer"]
		or Settings["Auto Quest Dragon Hunter"]
		or Settings["Auto Crafting Volcanic Magnet"]
		or Settings["Auto Find Prehistoric Island"]
		or Settings["Auto Find Mirage"]
		or Settings["Auto Event Prehistoric Island"]
		or Settings["Auto Collect Bone"]
		or Settings["Auto Collect Berry"]
		or Settings["Auto Upgrade Race V2-V3 Draco"]
		or Settings["Auto Trial Draco"]
		or Settings["Auto Get Rainbow Haki"]
		or Settings["Follow Player Select"]
		or Settings["Auto Tween To Prehistoric Island"]
		or Settings["Auto Kill Golem"]
		or Settings["Auto Fix Volcano"]
		or Settings["Multi Find Leviathan"]
		or Settings["Fully Event Prehistoric Island"]
		or Settings["Auto Multi Raid"]
		or Settings["Auto Fire Shoot Heart Leviathan"]
		or Settings["Auto Buy Chip and Attack Law"]
		or Settings["Fully Trial Draco"]
		or Settings["Auto Finish Train Quest"]
		or Settings["Auto Destroy IDK"]
		or Settings["Auto Finish Train Draco Quest"]
		or Settings["Auto TTK"]
		or Settings["Auto Attack All Mob and Boss"]
		or Settings["Auto Collect Egg"]
		or Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
	then
		return true
	end

	-- Any enabled boolean option keeps character collision disabled while active.
	for _, value in pairs(Settings) do
		if type(value) == "boolean" and value then
			return true
		end
	end
end
-- Character + equipped Tool noclip enforcement.
do
    task.spawn(function()
        while task.wait() do
            if ToggleNoclip() then
                local Character = t.Character
                if Character then
                    for _, Part in ipairs(Character:GetDescendants()) do
                        if Part:IsA("BasePart") then
                            Part.CanCollide = false
                        end
                    end
                end
            end
        end
    end)
end
local l = game:GetService("TweenService")
getgenv().TweenManager = {
	currentTween = nil,
	currentPart = nil,
	currentGoal = nil,
	TweenRunning = false,
	CancelTweenOnly = function()
		local Q, S = TweenManager.currentTween, getgenv().Tween
		if Q then
			pcall(function()
				Q:Cancel()
				Q:Destroy()
			end)
		end
		if S and S ~= Q then
			pcall(function()
				S:Cancel()
				S:Destroy()
			end)
		end
		TweenManager.currentTween = nil
		TweenManager.currentPart = nil
		TweenManager.currentGoal = nil
		TweenManager.TweenRunning = false
		getgenv().Tween = nil
	end,
	PlayTween = function(Q, S, L, d)
		if not Q or not S or not L or not L.CFrame then
			return
		end
		local I = (d or {}).TargetEpsilon or 12
		if
			TweenManager.currentTween
			and TweenManager.currentPart == Q
			and TweenManager.currentGoal
			and I >= (TweenManager.currentGoal.Position - L.CFrame.Position).Magnitude
		then
			return TweenManager.currentTween
		end
		TweenManager.CancelTweenOnly()
		local d = l:Create(Q, S, L)
		TweenManager.currentTween = d
		TweenManager.currentPart = Q
		TweenManager.currentGoal = L.CFrame
		TweenManager.TweenRunning = true
		getgenv().Tween = d
		d.Completed:Connect(function()
			if TweenManager.currentTween == d then
				TweenManager.currentTween = nil
				TweenManager.currentPart = nil
				TweenManager.currentGoal = nil
				TweenManager.TweenRunning = false
				getgenv().Tween = nil
				pcall(function()
					d:Destroy()
				end)
			end
		end)
		d:Play()
		return d
	end,
	CancelCurrent = function()
		local l = t.Character
		local Q = l and (l:FindFirstChild("HumanoidRootPart"))
		if TweenManager.currentTween or getgenv().Tween or Q and (Q:FindFirstChild("FloatForce")) then
			TweenManager.CancelTweenOnly()
			pcall(function()
				if not l then
					return
				end
				for S, S in ipairs(l:GetDescendants()) do
					if S:IsA("BasePart") then
						S.CanCollide = true
					end
				end
				local S = l:FindFirstChildOfClass("Humanoid")
				if S then
					S.PlatformStand = false
				end
				if Q and (Q:FindFirstChild("FloatForce")) then
					Q.FloatForce:Destroy()
				end
			end)
		end
	end,
}
TweenManager = getgenv().TweenManager
local l, Q, S, L, d =
	{
		Sea1 = {
			Colosseum = Vector3.new(-2143.41333, 152.074326, -3025.54614),
			Desert = Vector3.new(1330.68298, 103.55368, 4489.30615),
			Fountain = Vector3.new(5420.33643, 431.04068, 4396.38721),
			Jungle = Vector3.new(-1340.21948, 136.020538, -101.374214),
			["Marine Fortress"] = Vector3.new(-5180.23828, 281.343445, 4383.03174),
			["Middle Town"] = Vector3.new(-703.16748, 9.55188751, 1575.1864),
			["Pirate Village"] = Vector3.new(-807.662109, 27.8020515, 4119.30127),
			Prison = Vector3.new(5270.56934, 163.508469, 844.72821),
			Sky = Vector3.new(-4808.76904, 721.326355, -2668.81787),
			Snow = Vector3.new(1394.46399, 39.0448875, -1321.63904),
			["Starter Island"] = Vector3.new(1038.29968, 112.1365051, 1287.83447),
			["Starter Marine"] = Vector3.new(-3096.51929, 231.443558, 2087.51929),
			Underwater = Vector3.new(61147.9766, 20.5708408, 1366.09839),
			["Upper Sky"] = Vector3.new(-7950.03662, 5815.68457, -1968.3374),
			Volcano = Vector3.new(-5513.97852, 64.4943161, 8577.40039),
		},
		Sea2 = {
			Cafe = Vector3.new(-382, 74, 356),
			Colosseum = Vector3.new(-1836, 46, 1642),
			["Dark Arena"] = Vector3.new(3948, 13, -3479),
			["Docks 1"] = Vector3.new(-923, 8, 1810),
			["Docks 2"] = Vector3.new(-13, 39, 2708),
			["Docks 3"] = Vector3.new(-1944, 9, -2594),
			["Docks 4"] = Vector3.new(-5798, 1, -5021),
			Doghouse = Vector3.new(-1984, 125, -82),
			Graveyard = Vector3.new(-5710, 126, -775),
			["Haunted Ship"] = Vector3.new(937, 125, 32879),
			Lab = Vector3.new(-5542, 335, -5924),
			Lava = Vector3.new(-5280, 7, -5618),
			Mansion = Vector3.new(-494, 339, 593),
			Raid = Vector3.new(-6503, 251, -4495),
			Remote = Vector3.new(4766, 8, 2911),
			Skull = Vector3.new(-2956.24341, 123.399323, -9981.06934),
			Snow = Vector3.new(1210, 429, -4663),
			["Winter Castle"] = Vector3.new(5544.71777, 60.1393852, -6359.08887),
		},
		Sea3 = {
			["Cake Land"] = Vector3.new(-2098.970458984375, 76.39494323730469, -12128.359375),
			["Chocolate Land"] = Vector3.new(379.1396179199219, 130.20599365234375, -12720.83984375),
			["Great Tree"] = Vector3.new(4345.09375, 575.0524291992188, -6159.00439453125),
			["Haunted Castle"] = Vector3.new(-9515.0009765625, 149.18876647949, 5534.0502929688),
			["Hydra Arena"] = Vector3.new(5020.94580078125, 174.08645629882812, -2011.18505859375),
			["Hydra Town"] = Vector3.new(5288.62158203125, 1011.6527709960938, 392.4296875),
			["Ice Cream Land"] = Vector3.new(-917.54852294922, 63.364143371582, -10858.696289062),
			["Peanut Land"] = Vector3.new(-2037.8001708984, 13.651118278503, -9948.2021484375),
			Port = Vector3.new(-342.4343566894531, 23.8315486907959, 5547.345703125),
			["Sea Castle"] = Vector3.new(-5502.1787109375, 323.6708984375, -2863.4616699219),
			["Tiki Outpost"] = Vector3.new(-16456.4629, 530.251953, 436.231812),
			["Turtle Center"] = Vector3.new(-12007.979492188, 339.15548706055, -9178.580078125),
			["Turtle Entrance"] = Vector3.new(-10163.96484375, 340.29028320313, -8320.767578125),
			["Turtle Mansion"] = Vector3.new(-12538.421875, 339.39358520508, -7817.0708007813),
			["Turtle Mountain"] = Vector3.new(-12856.61328125, 852.75360107422, -10715.23046875),
		},
	},
	{},
	game:GetService("CollectionService"),
	0,
	false
local function I()
	L = tick() + 1.5
	if not S:HasTag(t, "Teleporting") then
		S:AddTag(t, "Teleporting")
		d = true
	end
end
task.spawn(function()
	while task.wait(0.1) do
		if d and tick() >= L then
			S:RemoveTag(t, "Teleporting")
			d = false
		end
	end
end)
spawn(function()
	local S = (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables"))
	repeat
		task.wait()
		S = (game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetUnlockables"))
	until S
	if S.DefeatedIndraTrueForm and game.PlaceId == getgenv().CheckPlaceId then
		Q["Caslte On The Sea"] = Vector3.new(-4967.6826171875, 314.88238525390625, -3157.098388671875)
		Q.Hydra = Vector3.new(5661.5302734375, 1013.4113159179688, -334.9619140625)
		Q.Mansion = Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125)
	end
	if game.PlaceId == getgenv().CheckPlaceId then
		Q["Temple Clock"] = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)
	end
	if game.PlaceId == getgenv().CheckPlaceId2 then
		Q["122"] = Vector3.new(923.21252441406, 126.9760055542, 32852.83203125)
		Q["3032"] = Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
	end
	if S.FlamingoAccess and game.PlaceId == getgenv().CheckPlaceId2 then
		Q.Mansion = Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312)
		Q.Flamingo = Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625)
	end
	local S, L = game.PlaceId, getgenv().CheckPlaceId3
	if S == L then
		Q = {
			["1"] = Vector3.new(-7894.6201171875, 5545.49169921875, -380.2467346191406),
			["2"] = Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
			["3"] = Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
			["4"] = Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875),
		}
	end
end)
local S, L, d = game:GetService("Players"), game:GetService("ReplicatedStorage"), game:GetService("VirtualInputManager")

-- Portal helpers
-- The old implementation only worked when the player owned the Portal Fruit.
-- Keep it available as a fallback, but do not require the fruit for the setting itself.
local function _()
	local o = t.Data:FindFirstChild("DevilFruit")
	if not o or o.Value ~= "Portal-Portal" then
		return false
	end
	local V = t.PlayerGui.Main.Skills:FindFirstChild(o.Value)
	o = V and (V:FindFirstChild("C"))
	if not o or not o:IsA("Frame") then
		V = t.Character:FindFirstChild("Portal-Portal") or (t.Backpack:FindFirstChild("Portal-Portal"))
		if not V then
			return false
		end
		t.Character:FindFirstChildOfClass("Humanoid"):EquipTool(V)
		return false
	end
	V = o:FindFirstChild("Cooldown")
	return o.Title.TextColor3 == Color3.new(1, 1, 1)
		and (V.Size == UDim2.new(0, 0, 1, -1) or V.Size == UDim2.new(1, 0, 1, -1))
end
local function o(V)
	local N = t.Character:FindFirstChild("Portal-Portal") or (t.Backpack:FindFirstChild("Portal-Portal"))
	if not N then
		return false
	end
	t.Character:FindFirstChildOfClass("Humanoid"):EquipTool(N)
	N = t.PlayerGui.Main:FindFirstChild("Gateway")
	if not N then
		return false
	end
	d:SendKeyEvent(true, "C", false, game)
	d:SendKeyEvent(false, "C", false, game)
	local y = tick() + 3
	repeat
		task.wait(0.1)
	until N.Visible or tick() > y
	if not N.Visible then
		return false
	end
	y = N:FindFirstChild("MainContent")
	if not y then
		return false
	end
	N = y.ScrollingFrame:FindFirstChild(tostring(V))
	if N and N.MouseButton1Click then
		for V, V in pairs(getconnections(N.MouseButton1Click)) do
			pcall(function()
				V.Function()
			end)
		end
		return true
	end
	return false
end
G = {
	[Vector3.new(-16455.29, 527.75, 436.11)] = Vector3.new(-4967.68, 314.88, -3157.1),
	[Vector3.new(-9513.47, 142.1, 5528.84)] = Vector3.new(-4967.68, 314.88, -3157.1),
	[Vector3.new(-340.89, 20.6, 5549.8)] = Vector3.new(5661.53, 1013.41, -334.96),
	[Vector3.new(-2100.75, 69.98, -12128.27)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(380.74, 126.58, -12726.16)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(-916.08, 56.24, -10858.4)] = Vector3.new(28282.57, 14896.85, 105.1),
	[Vector3.new(-2039.6, 9.67, -9947.76)] = Vector3.new(28282.57, 14896.85, 105.1),
}
do
	local G = Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586)
	local function V()
		local N = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
		return N ~= nil and (N.Position - G).Magnitude < 1000
	end
	function BorrowTempleOfTime()
		local G = game.ReplicatedStorage.MapStash:FindFirstChild("Temple of Time")
		if not G then
			G = game.ReplicatedStorage:FindFirstChild("Temple of Time") or workspace.Map:FindFirstChild("Temple of Time")
			if not G then return end
		end
		pcall(function()
			G:SetAttribute("ClientBorrowed", true)
			if G.Parent ~= workspace.Map then
				G.Parent = workspace.Map
			end
		end)
		task.spawn(function()
			local N = tick() + 30
			repeat task.wait(0.25)
			until G.Parent ~= workspace.Map or (V()) or tick() > N
			pcall(function()
				G:SetAttribute("ClientBorrowed", nil)
				if not V() and G.Parent == workspace.Map then
					G.Parent = game.ReplicatedStorage.MapStash
				end
			end)
		end)
	end
	function JoinTempleOfTimeTrial()
		pcall(function()
			BorrowTempleOfTime()
			local temple = GetTempleOfTime() or workspace.Map:FindFirstChild("Temple of Time")
			if not temple then
				toTarget(CFrame.new(28282.5703125,14896.8505859375,105.1042709350586))
				return
			end
			-- Entra pela porta
			local door = temple:FindFirstChild("TempleDoor") or temple:FindFirstChild("Door") or temple:FindFirstChild("Prompt")
			if door and door:FindFirstChild("TouchInterest") then
				toTarget(door.CFrame)
			else
				toTarget(CFrame.new(28282.5703125,14896.8505859375,105.1042709350586))
			end
		end)
	end
	function GetTempleOfTime()
		local G = workspace.Map:FindFirstChild("Temple of Time")
		if G and not G:GetAttribute("ClientBorrowed") then
			return G
		end
	end
end
local G = false
getgenv().IsPlayerDead = function()
	if not t.Character or not t.Character:FindFirstChild("Humanoid") or t.Character.Humanoid.Health == 0 then
		return true
	end
end
CS = game:GetService("CollectionService")
cam = workspace.CurrentCamera
function LoadIslandByFakePoint(V)
	local N = Instance.new("Part")
	N.Transparency = 1
	N.CanCollide = false
	N.Anchored = true
	N.Size = Vector3.new(0, 0, 0)
	N.CFrame = CFrame.new(V:GetPivot().Position)
	CS:AddTag(N, "LoDPosition")
	N.Parent = cam
	return N
end
spawn(function()
	pcall(function()
		for V, V in ipairs(workspace:GetChildren()) do
			if V:IsA("Model") and (V:GetAttribute("LevelOfDetailDiameter")) then
				LoadIslandByFakePoint(V)
			end
		end
		for V, V in ipairs(workspace.Map:GetChildren()) do
			if V:IsA("Model") then
				LoadIslandByFakePoint(V)
			end
		end
		for V, V in ipairs(game:GetService("ReplicatedStorage").FakeIslands:GetChildren()) do
			if V:IsA("Model") then
				LoadIslandByFakePoint(V)
			end
		end
	end)
end)
getgenv().TweenGuidePart = nil
getgenv().TweenConnection = nil
getgenv().TweenInProgress = false
getgenv().lastTarget = nil
local function V(N)
	local y, x
	for k, P in ipairs(workspace._WorldOrigin.Locations:GetChildren()) do
		if P:IsA("BasePart") and not P:GetAttribute("IgnoreInTracking") then
			k = (P.Position - N).Magnitude
			if not y or k < y then
				y, x = k, P
			end
		end
	end
	return x
end
local function N(y)
	local x = V(y)
	if not x then
		return nil
	end
	local k = x:FindFirstChild("Mesh")
	if k then
		if k.Scale.X / 2 >= (x.Position - y).Magnitude then
			return x
		else
			return nil
		end
	end
	return x
end
function DetectNpcOni()
	local y = t.Character and (t.Character:FindFirstChild("HumanoidRootPart"))
	if not y then
		return
	end
	local x, k, P, e = next, { workspace.NPCs, game:GetService("ReplicatedStorage").NPCs }, 1 / 0
	for Y, H in x, k, nil do
		local x, k, B = next, H:GetChildren()
		for H, H in x, k, B do
			if
				H:GetAttribute("NPCLoaded")
				and (H:GetAttribute("NPCReady"))
				and H:GetAttribute("DisplayName") == "Celestial Member"
				and (H:FindFirstChild("HumanoidRootPart"))
			then
				Y = (y.Position - H.HumanoidRootPart.Position).Magnitude
				if Y < P then
					P, e = Y, H
				end
			end
		end
	end
	return e, P
end
CelestialDomainController =
	require(game:GetService("ReplicatedStorage").Controllers.MapServices.CelestialDomainController)
LocalPlayer = t
L = game:GetService("ReplicatedStorage")
WorldOrigin = workspace:WaitForChild("_WorldOrigin", 10)
travelFunctions = {}
PlayerSpawnsLot = {}
BypassTpLocation = {}
PlrData = game:GetService("Players").LocalPlayer.Data
localPlayerFunctions = {}
function localPlayerFunctions.IsAlive()
	local y = LocalPlayer.Character
	if not y then
		return false
	end
	local x = y:FindFirstChildOfClass("Humanoid")
	if not x then
		return false
	end
	return x.Health > 0
end
function getHRP()
	local y = LocalPlayer.Character
	if not y then
		return nil
	end
	return y:FindFirstChild("HumanoidRootPart") or (y:FindFirstChild("UpperTorso")) or (y:FindFirstChild("Torso"))
end
function travelFunctions.GetDistance(y, x)
	if not localPlayerFunctions.IsAlive() then
		return 1 / 0
	end
	if not x then
		local k = getHRP()
		if not k then
			return 1 / 0
		end
		x = k.Position
	end
	return (y - x).Magnitude
end
function travelFunctions.LoadBypassTPLocation()
	table.clear(PlayerSpawnsLot)
	table.clear(BypassTpLocation)
	local y, x = WorldOrigin:FindFirstChild("PlayerSpawns"), WorldOrigin:FindFirstChild("Locations")
	if not y or not x then
		return
	end
	for k, k in ipairs(y:GetChildren()) do
		for y, y in ipairs(k:GetChildren()) do
			if y:IsA("Model") then
				table.insert(PlayerSpawnsLot, { y.Name, y:GetModelCFrame() })
			end
		end
		k.ChildAdded:Connect(function(y)
			task.wait()
			if y:IsA("Model") then
				table.insert(PlayerSpawnsLot, { y.Name, y:GetModelCFrame() })
			end
		end)
	end
	local function y(k)
		if not k:IsA("BasePart") then
			return
		end
		BypassTpLocation[k.Name] = {}
		local P = k:FindFirstChildWhichIsA("SpecialMesh")
		local e = P and P.Scale.X or 1
		P = k.Size.X * e / 2
		for e, e in ipairs(PlayerSpawnsLot) do
			if (e[2].Position - k.Position).Magnitude <= P then
				table.insert(BypassTpLocation[k.Name], e)
			end
		end
	end
	for k, k in ipairs(x:GetChildren()) do
		y(k)
	end
	x.ChildAdded:Connect(function(x)
		task.wait(0.1)
		y(x)
	end)
end
function travelFunctions.GetTPLocation(y)
	local x = WorldOrigin:FindFirstChild("Locations")
	if not x then
		return nil
	end
	local k, P = 1 / 0
	for e, Y in ipairs(x:GetChildren()) do
		e = BypassTpLocation[Y.Name]
		if e then
			local x = Y:FindFirstChildWhichIsA("SpecialMesh")
			local H = x and x.Scale.X or 1
			if Y.Size.X * H / 2 >= travelFunctions.GetDistance(y, Y.Position) then
				for x, Y in ipairs(e) do
					x = travelFunctions.GetDistance(y, Y[2].Position)
					if x < k then
						k, P = x, Y[1]
					end
				end
			end
		end
	end
	return P
end
function travelFunctions.TweenBypass(y, x)
	x = x or 0
	if x >= 5 then
		return
	end
	local k, P = pcall(function()
		if not y then
			return
		end
		if not next(BypassTpLocation) then
			travelFunctions.LoadBypassTPLocation()
		end
		local e = LocalPlayer.Character
		if not e then
			return
		end
		if not getHRP() then
			return
		end
		local Y = {}
		for H, H in pairs(BypassTpLocation) do
			for B, B in ipairs(H) do
				if not table.find(Y, B[2]) then
					table.insert(Y, B[2])
				end
			end
		end
		if #Y == 0 then
			return
		end
		table.sort(Y, function(H, B)
			return travelFunctions.GetDistance(H.Position, y.Position)
				< travelFunctions.GetDistance(B.Position, y.Position)
		end)
		local H = e:FindFirstChild("LastSpawnPoint")
		if H then
			H.Disabled = true
		end
		task.wait()
		for B, Z in ipairs(Y) do
			B = travelFunctions.GetTPLocation(Z.Position)
			if B then
				local Y = travelFunctions.GetDistance(Z.Position, y.Position)
				if
					travelFunctions.GetDistance(y.Position) > Y + 500
					and travelFunctions.GetDistance(Z.Position) >= 1000
				then
					CommF:InvokeServer("SetLastSpawnPoint", B)
					if PlrData.LastSpawnPoint.Value == B then
						e.Humanoid.Health = 0
						repeat
							task.wait()
						until localPlayerFunctions.IsAlive()
						if H then
							H.Disabled = false
						end
						travelFunctions.TweenBypass(y, x + 1)
						return true
					end
				end
			end
		end
		if H then
			H.Disabled = false
		end
	end)
	return false
end
function ShouldResetTeleportSmart(y)
	-- Teleport Bypass is intentionally disabled.
	-- Keep this function so existing callers remain safe and the source structure does not break.
	return false
end
task.spawn(function()
	travelFunctions.LoadBypassTPLocation()
end)
BypassTp = travelFunctions
local function y(x)
	if x:FindFirstChild("FloatForce") then
		return
	end
	local k = Instance.new("BodyVelocity")
	k.Name = "FloatForce"
	k.Velocity = Vector3.new(0.0, 0.0, 0.0)
	k.MaxForce = Vector3.new(100000, 100000, 100000)
	k.P = 10000
	k.Parent = x
end
local x, k, P, e, Y =
	game:GetService("RunService"), { LastTP = 0, LastCF = nil, ActiveConnection = nil, LastCall = 0 }, 18, 120, 40
local function H()
	local B = getgenv().CharSpeed
	if not B then
		B = { cap = 1000, nextRaise = 0 }
		getgenv().CharSpeed = B
	end
	return B
end
local function B(Z, C, J, F)
	if not Z or typeof(C) ~= "CFrame" then
		return
	end
	local q = t.Character
	local c = q and (q:FindFirstChildOfClass("Humanoid"))
	if not q or Z.Parent ~= q or not c or c.Health <= 0 then
		return
	end
	if tick() - k.LastTP < 1 and C == k.LastCF then
		return
	end
	TweenManager.CancelTweenOnly()
	if k.ActiveConnection and coroutine.status(k.ActiveConnection) == "suspended" then
		pcall(coroutine.close, k.ActiveConnection)
	end
	J = math.max(tonumber(J) or 350, 1)
	F = tonumber(F) or 2.5
	k.LastTP = tick()
	k.LastCF = C
	local c, D = false
	local r = {}
	local function n()
		if k.ActiveConnection == D then
			k.ActiveConnection = nil
		end
		if TweenManager.currentTween == r then
			TweenManager.currentTween = nil
			TweenManager.currentPart = nil
			TweenManager.currentGoal = nil
			TweenManager.TweenRunning = false
		end
		if getgenv().Tween == r then
			getgenv().Tween = nil
		end
	end
	r.Pause = function(u)
		c = true
		if D and coroutine.status(D) == "suspended" then
			pcall(coroutine.close, D)
		end
	end
	r.Cancel = function(u)
		u:Pause()
		n()
	end
	r.Destroy = function(u)
		u:Cancel()
	end
	D = coroutine.create(function()
		local u, W = Z.Position, C.Position
		local O, z, U, h, p, w = (W - u).Magnitude, 1 / 0, (tick()), true
		while not c do
			local M = t.Character
			local j = M and (M:FindFirstChildOfClass("Humanoid"))
			if M ~= q or Z.Parent ~= M or not j or j.Health <= 0 or Z.Anchored or O <= F then
				break
			end
			local q, v0, T0 = x.Heartbeat:Wait(), H(), Z.Position
			M = (W - T0).Magnitude
			if M < z - 5 then
				z, U = M, (tick())
			else
				h = if tick() - U > 2.5 then false else h
			end
			if h and p and w and M > w + Y then
				v0.cap = math.max(v0.cap * 0.7, e)
				v0.nextRaise = tick() + 3
				u = T0
			else
				u = if h and p and (T0 - p).Magnitude > Y then T0 else u
			end
			j = W - u
			local e, Y = j.Magnitude, math.min(math.min(J, v0.cap) * q, P)
			if e > Y and tick() >= v0.nextRaise then
				v0.cap = math.min(v0.cap * 1.08, J)
				v0.nextRaise = tick() + 1.5
			end
			u = if e <= Y or e <= 0.05 then W else u + j / e * Y
			O = (W - u).Magnitude
			I()
			getgenv().noclip = true
			Z.CFrame = CFrame.new(u)
			Z.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
			Z.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
			p, w = u, M
		end
		if not c and Z.Parent == t.Character and (W - Z.Position).Magnitude <= F then
			Z.CFrame = C
			Z.AssemblyLinearVelocity = Vector3.new(0.0, 0.0, 0.0)
			Z.AssemblyAngularVelocity = Vector3.new(0.0, 0.0, 0.0)
		end
		n()
	end)
	k.ActiveConnection = D
	TweenManager.currentTween = r
	TweenManager.currentPart = Z
	TweenManager.currentGoal = C
	TweenManager.TweenRunning = true
	getgenv().Tween = r
	if not coroutine.resume(D) then
		r:Cancel()
		return
	end
	return r
end

function toTarget(P, e)
	if typeof(P) ~= "CFrame" then
		return
	end
	local Y = t.Character
	if not Y or not Y:FindFirstChild("HumanoidRootPart") then
		return
	end
	local H, Z = Y.HumanoidRootPart, Y:FindFirstChildOfClass("Humanoid")
	if not Z then
		return
	end
	k.LastCall = tick()
	if Z and Z.Sit then
		TweenManager.CancelCurrent()
		task.wait(0.1)
		getgenv().noclip = false
		d:SendKeyEvent(true, "Space", false, game)
		task.wait()
		d:SendKeyEvent(false, "Space", false, game)
		task.wait(0.1)
		if H:FindFirstChild("EffectsSY") then
			H.EffectsSY:Destroy()
		end
		Z.Jump = true
		task.wait(0.1)
		H.CFrame = H.CFrame * CFrame.new(0, 10, 0)
		return
	end
	if not H:FindFirstChild("FloatForce") then
		y(H)
	end
	Y = (P.Position - H.Position).Magnitude
	if Settings["Teleport Y"] then
		local d, y = Settings["% Health Player"] or 40, Z.Health / Z.MaxHealth
		local C = d / 100
		if y < C then
			G = true
		else
			d = Z.Health / Z.MaxHealth
			if d > 0.8 then
				G = false
			end
		end
	end
	if Y < (e and 8 or 150) and not G and not ReadyToDodge then
		TweenManager.CancelTweenOnly()
		I()
		H.CFrame = P
		return
	end
	if game.PlaceId ~= 122478697296975 then
		e = CFrame.new(28609.392578125, 14896.533203125, 106.4216537475586)
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - e.Position).Magnitude > 3000
			and (e.Position - H.Position).Magnitude <= 3000
		then
			B(H, e, 400, 8)
			if (e.Position - H.Position).Magnitude < 8 then
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("RaceV4Progress", "Check")
				game:GetService("ReplicatedStorage")
					:WaitForChild("Remotes")
					:WaitForChild("CommF_")
					:InvokeServer("RaceV4Progress", "TeleportBack")
				TweenManager.CancelCurrent()
			end
			return
		end
		Z = Vector3.new(11538.599609375, -2154.7021484375, 9827.3125)
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - Z).Magnitude <= 3000
			and (Z - H.Position).Magnitude > 3000
		then
			local d = CFrame.new(
				-16269.4082,
				23.9799957,
				1371.66235,
				-0.999388933,
				0,
				-0.0349550731,
				0,
				1,
				0,
				0.0349550731,
				0,
				-0.999388933
			)
			B(H, d, 350, 8)
			if (d.Position - H.Position).Magnitude < 8 then
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineWorkerSpeak")
					:InvokeServer(unpack({ [1] = "TravelToSubmergedIsland" }))
				game:GetService("ReplicatedStorage").Remotes.CommF_
					:InvokeServer(unpack({ [1] = "SetLastSpawnPoint", [2] = "SubmergedIsland" }))
				TweenManager.CancelCurrent()
			end
			return
		end
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (P.Position - Z).Magnitude > 3000
			and (Z - H.Position).Magnitude <= 3000
		then
			local d = CFrame.new(
				11427.9189,
				-2156.36401,
				9726.24023,
				-0.929097056,
				-7.17796156E-34,
				0.369835705,
				-7.17796156E-34,
				1,
				1.37611875E-34,
				-0.369835705,
				-1.37611875E-34,
				-0.929097056
			)
			B(H, d, 350, 8)
			if (d.Position - H.Position).Magnitude < 8 then
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineTransportation")
					:InvokeServer(unpack({ [1] = "GetAvailableLocations" }))
				game:GetService("ReplicatedStorage").Modules.Net
					:FindFirstChild("RF/SubmarineTransportation")
					:InvokeServer(unpack({ [1] = "InitiateTeleport", [2] = "Tiki Outpost" }))
				TweenManager.CancelCurrent()
			end
			return
		end

		local l, d, _
		if Y >= 3000 then
			for o, y in pairs(Q) do
				local Q = (P.Position - y).Magnitude
				if Q <= 3000 and (not _ or Q < _) then
					_, l, d = Q, o, y
				end
			end
		end
		if d then
			getgenv().noclip = true
			if l == "Temple Clock" then
				BorrowTempleOfTime()
			end
			I()
			game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", d)
			task.wait(0.1)
			return
		end
		local Q, I, o, y = N(H.Position), N(P.Position), V(P.Position), V(H.Position)
		if I and I.Name == "Celestial Domain" and (not Q or Q.Name ~= "Celestial Domain") then
			d = DetectNpcOni()
			if not d or not d:FindFirstChild("HumanoidRootPart") then
				return
			end
			_ = d.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
			B(H, _, 350, 12)
			if (_.Position - H.Position).Magnitude < 300 then
				game:GetService("ReplicatedStorage").Modules.Net
					:WaitForChild("RF/CelestialDomainTransportation")
					:InvokeServer("InitiateTeleportToTemple")
				CelestialDomainController:LoadMap()
				TweenManager.CancelCurrent()
				task.wait(1)
			end
			return
		end
		if o and (o.Name == "Celestial Domain (Interior)" or o.Name == "Celestial Domain <Interior>") then
			if Q and Q.Name == "Celestial Domain" then
				game:GetService("ReplicatedStorage").Modules.Net
					:WaitForChild("RF/CelestialDomainTransportation")
					:InvokeServer("InitiateTeleportToInterior")
				TweenManager.CancelCurrent()
				task.wait(1)
				return
			end
			l = y and (y.Name == "Celestial Domain (Interior)" or y.Name == "Celestial Domain <Interior>")
			if not Q or Q.Name ~= "Celestial Domain" and not l then
				_ = DetectNpcOni()
				if not _ or not _:FindFirstChild("HumanoidRootPart") then
					return
				end
				d = _.HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
				B(H, d, 350, 12)
				if (d.Position - H.Position).Magnitude < 300 then
					game:GetService("ReplicatedStorage").Modules.Net
						:WaitForChild("RF/CelestialDomainTransportation")
						:InvokeServer("InitiateTeleportToTemple")
					CelestialDomainController:LoadMap()
					TweenManager.CancelCurrent()
					task.wait(1)
					game:GetService("ReplicatedStorage").Modules.Net
						:WaitForChild("RF/CelestialDomainTransportation")
						:InvokeServer("InitiateTeleportToInterior")
				end
				return
			end
		end
		if
			y
			and (y.Name == "Celestial Domain (Interior)" or y.Name == "Celestial Domain <Interior>")
			and (not o or o.Name ~= "Celestial Domain (Interior)" and o.Name ~= "Celestial Domain <Interior>")
		then
			game:GetService("ReplicatedStorage").Modules.Net
				:WaitForChild("RF/CelestialDomainTransportation")
				:InvokeServer("Leave")
			TweenManager.CancelCurrent()
			task.wait(1)
			return
		end
		if Q and Q.Name == "Celestial Domain" and (not I or I.Name ~= "Celestial Domain") then
			game:GetService("ReplicatedStorage").Modules.Net
				:WaitForChild("RF/CelestialDomainTransportation")
				:InvokeServer("Leave")
			TweenManager.CancelCurrent()
			return
		end
		if
			game.PlaceId == getgenv().CheckPlaceId
			and (workspace.Map:FindFirstChild("CakeLoaf"))
			and (workspace.Map.CakeLoaf:FindFirstChild("BigMirror"))
			and (workspace.Map.CakeLoaf.BigMirror:FindFirstChild("Main"))
			and (Vector3.new(-1990.67, 4532.97, -14973.67) - P.Position).Magnitude <= 1000
			and (Vector3.new(-1990.67, 4532.97, -14973.67) - H.Position).Magnitude > 1000
		then
			B(H, workspace.Map.CakeLoaf.BigMirror.Main.CFrame, 400, 8)
			return
		end
	end
	if ShouldResetTeleportSmart(P) then
		if BypassTp.TweenBypass(P) then
			return
		end
	end
	if H.Position.Y < -60 and H.Position.Y > -100 then
		H.CFrame = H.CFrame * CFrame.new(0, 20, 0)
	end
	Z = CFrame.new()
	Z = if ReadyToDodge
		then (CFrame.new(0, 200, 0))
		else if G then (CFrame.new(0, Settings["Distance Teleport Y"] or 800, 0)) else Z
	Y, e = math.clamp(tonumber(Settings["Speed Tween "]) or 220, 0, 220), P * Z
	if (e.Position - H.Position).Magnitude < 3 and not ReadyToDodge and not G then
		TweenManager.CancelTweenOnly()
		H.CFrame = e
		return
	end
	B(H, e, Y)
end
getgenv().BackupTween = toTarget
spawn(function()
	while wait(0.25) do
		local G, G = pcall(function()
			if g["Teleport To Island"] then
				for l, Q in next, E, nil do
					if l == g["Select Island"] then
						toTarget(Q)
					end
				end
			end
			if g["Teleport To Npc"] then
				for E, E in next, m, nil do
					if E.Name == g["Select Npc"] then
						toTarget(E.HumanoidRootPart.CFrame)
					end
				end
			end
			if g["Teleport Mirage"] then
				if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
					local m = DetectNpc("Advanced Fruit Dealer")
					if m then
						toTarget(m.HumanoidRootPart.CFrame)
						return
					end
				end
			end
			if g["Teleport Prehistoric Island"] then
				if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
					local g = DetectNpc("Fossil Expert")
					if g then
						toTarget(g.HumanoidRootPart.CFrame)
						return
					end
				end
			end
			if Settings["Auto rejoin Disconnect"] then
				if
					not string.find(
						game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ErrorPrompt.MessageArea.ErrorFrame.ErrorMessage.Text,
						"Teleport"
					)
				then
					game:GetService("TeleportService")
						:TeleportToPlaceInstance(game.PlaceId, game.JobId, game.Players.LocalPlayer)
				end
			end
		end)
	end
end)
function equiptool(g)
	if g and (t:FindFirstChild("Backpack")) and (t.Backpack:FindFirstChild(g)) and not t.Character.Humanoid.Sit then
		t.Character.Humanoid:EquipTool(t.Backpack:FindFirstChild(g))
	end
end
function NameWeapon(g, G)
	local function m(E)
		local l, Q, d = next, E:GetChildren()
		for E, E in l, Q, d do
			if E:IsA("Tool") and E.ToolTip == g then
				return G and E or E.Name
			end
		end
	end
	return m(t.Backpack) or (m(t.Character))
end
local g, G, m, E =
	require(game:GetService("ReplicatedStorage").Mouse),
	require(game:GetService("ReplicatedStorage").Modules.CombatUtil),
	require(game:GetService("ReplicatedStorage").Modules.Net),
	game:GetService("ReplicatedStorage").Modules.Net:WaitForChild("RE/RegisterAttack")
local l = m:RemoteEvent("RegisterHit", true)
local function m(Q, d, I)
	local _ = {}
	for o, o in pairs(Q:GetChildren()) do
		if o:IsA("BasePart") and (o.Position - d).Magnitude <= I then
			table.insert(_, o)
		end
	end
	return _
end
local function Q(d)
	local I = {}
	for _, _ in pairs(game:GetService("Workspace"):WaitForChild("Enemies"):GetChildren()) do
		table.insert(I, _)
	end
	if d then
		for d, d in pairs(game:GetService("Workspace"):WaitForChild("Characters"):GetChildren()) do
			table.insert(I, d)
		end
	end
	return I
end
getgenv().getBladeHits = function(d, I, _, o)
	local V = {}
	for N, y in pairs(Q(o)) do
		if y:IsDescendantOf(Workspace) and y ~= d and (y:FindFirstChild("HumanoidRootPart")) then
			local Q, d = y.HumanoidRootPart, S:GetPlayerFromCharacter(y) and _ / 1.5 or _
			N = { Q.Position }
			if Q.Size.Y > 5 then
				table.insert(N, (Q.CFrame * CFrame.new(0, -Q.Size.Y * 1.5 + 3, 0)).Position)
			end
			for _, _ in pairs(N) do
				if (_ - I[1].Position).Magnitude < 10 + d + Q.Size.X / 2 then
					for _, _ in pairs(m(y, I[1].Position, d + Q.Size.X / 2)) do
						table.insert(V, _)
					end
					break
				end
			end
		end
	end
	return V
end
local m = {
	RightUpperArm = true,
	RightLowerArm = true,
	RightHand = true,
	RightUpperLeg = true,
	RightLowerLeg = true,
	RightFoot = true,
	LeftUpperArm = true,
	LeftLowerArm = true,
	LeftHand = true,
	LeftUpperLeg = true,
	LeftLowerLeg = true,
	LeftFoot = true,
	UpperTorso = true,
	LowerTorso = true,
	Head = true,
}
function AttackAOE(Q, d)
	local I, _, o, V, N = {}, {}, getgenv().getBladeHits, t.Character, { t.Character.HumanoidRootPart }
	for y, P in o(V, N, Q or 80, d) do
		y = G:GetRigOfHitPart(P)
		if y and not _[y] and m[P.Name] and (G:IsVulnerable(y)) then
			local m, Q = y:FindFirstChild("Summoner"), t.Character:FindFirstChild("Summoner")
			if
				y ~= t.Character
				and (not Q or y ~= Q.Value.Character)
				and (
					not S:GetPlayerFromCharacter(t.Character)
					or not m
					or m.Value ~= S:GetPlayerFromCharacter(t.Character)
				)
			then
				table.insert(I, { y, P })
				_[y] = true
			end
		end
	end
	return #I > 0 and I or nil
end
v_u_27 = 0
v_u_28 = false
v_u_33 = false
v_u_31 = nil
v_u_32 = 0
v_u_21 = 0
v_u_16 = 1
CameraShakerMain = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
function attackMelee(m)
	local Q = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
	if not Q then
		return
	end
	local d = AttackAOE(m, false)
	if not d then
		return
	end
	m = game.Players.LocalPlayer.Character.Humanoid
	local I = m and m.RootPart
	I = I and I.Parent
	local _ = G:GetMovesetAnimCache(m)
	if _ then
		m = G:GetWeaponName(Q)
		local Q = G:GetWeaponData(m)
		local o, V = Q.WeaponType, Q.Moveset
		if G:CanAttack(I, o) then
			v_u_33 = true
			v_u_32 = 5
			v_u_21 = os.clock()
			v_u_27 += 1
			if v_u_27 > #V.Basic then
				v_u_27 = 1
			end
			Q = _[G:GetPureWeaponName(m) .. "-basic" .. v_u_27]
			E:FireServer(Q.Length / (Q:GetAttribute("SpeedMult") or 1))
			l:FireServer(table.remove(d, 1)[2], d)
			Q:Play(0.100000001, 1, 1 * (Q:GetAttribute("SpeedMult") or 1))
			v_u_28 = true
			task.delay(Q.Length / (Q:GetAttribute("SpeedMult") or 1) * v_u_16, function()
				v_u_28 = false
			end)
			v_u_31 = Q
			table.clear(d)
		end
	end
end
AttackFunction = function(G)
	if t.Character.Stun.Value ~= 0 then
		return
	end
	if not Settings["Attack No Animation "] then
		attackMelee(G)
	else
		local m = AttackAOE(G, false)
		if not m then
			return
		end
		E:FireServer(0)
		l:FireServer(table.remove(m, 1)[2], m)
		table.clear(m)
	end
end
getgenv().AttackFunctionnhungSuperTrial = function()
	if t.Character.Stun.Value ~= 0 then
		return
	end
	local G = AttackAOE(80, true)
	if not G then
		return
	end
	E:FireServer(0)
	l:FireServer(table.remove(G, 1)[2], G)
	table.clear(G)
end
getgenv().AttackFunctionnhungSuper = getgenv().AttackFunctionnhungSuperTrial
local G = require(game:GetService("ReplicatedStorage").Mouse)
v_u_50 = nil
v_u_51 = 1
v_u_52 = time
v_u_53 = v_u_52()
FruitM1State = { Tool = nil, Combo = 0, LastFire = 0, LastCombo = 0, Busy = false, BusyAt = 0 }
local function m(E, l, Q)
	local d = t.Character
	local I = d and (d.PrimaryPart or d:FindFirstChild("HumanoidRootPart"))
	if not I or not E then
		return false
	end
	-- Target position: accepts Vector3, CFrame, Part or Model.
	local function GetPos(T)
		local ty = typeof(T)
		if ty == "Vector3" then
			return T
		elseif ty == "CFrame" then
			return T.Position
		elseif ty == "Instance" then
			if T:IsA("BasePart") then
				return T.Position
			elseif T:IsA("Model") then
				local r = T:FindFirstChild("HumanoidRootPart") or T.PrimaryPart
				return r and r.Position or T:GetPivot().Position
			end
		end
	end
	local TargetPos = GetPos(E)
	if not TargetPos then
		return false
	end
	local ok, result = pcall(function()
		local toolName = NameWeapon("Blox Fruit")
		if not toolName then
			return false
		end
		local tool = d:FindFirstChild(toolName)
		if not tool then
			-- Fruit still in the backpack: equip it and fire on the next cycle.
			local bp = t.Backpack:FindFirstChild(toolName)
			local hum = d:FindFirstChildOfClass("Humanoid")
			if bp and hum then
				hum:EquipTool(bp)
			end
			return false
		end
		-- Same guard as the melee attack: no clicks while stunned.
		local stun = d:FindFirstChild("Stun")
		if stun and stun.Value ~= 0 then
			return true
		end
		-- One shared pace for the farm loop and the turbo loop. A small floor keeps the
		-- remote queue from flooding (flooding is what made the clicks stop after a while).
		-- Adjust with getgenv().FruitM1Delay (seconds).
		local now = os.clock()
		local minDelay = getgenv().FruitM1Delay or 0.00001 -- 0.01 ms requested (actual speed is limited by frame/server timing)
		if now - FruitM1State.LastFire < minDelay then
			return true
		end
		-- Combo counter restarts after a pause or when the fruit changes (like a real click).
		if FruitM1State.Tool ~= tool or now - FruitM1State.LastFire > 1.2 then
			FruitM1State.Combo = 0
		end
		FruitM1State.Tool = tool
		FruitM1State.LastFire = now

		-- Lead the aim using the target velocity, from the real firing point.
		local origin = I.Position + Vector3.new(0, 1.5, 0)
		local aimPoint = TargetPos
		if typeof(E) == "Instance" then
			local tr = E:IsA("Model") and (E:FindFirstChild("HumanoidRootPart") or E.PrimaryPart) or E
			if tr and tr:IsA("BasePart") then
				local okV, vel = pcall(function()
					return tr.AssemblyLinearVelocity
				end)
				if okV and vel and vel.Magnitude < 120 then
					aimPoint = TargetPos + vel * math.clamp((aimPoint - origin).Magnitude / 300, 0, 0.25)
				end
			end
		end
		local ToTarget = aimPoint - origin
		local Aim = ToTarget.Magnitude < 0.001 and Vector3.new(0, 0, -1) or ToTarget.Unit
		local Flat = Vector3.new(Aim.X, 0, Aim.Z)
		Flat = Flat.Magnitude < 0.001 and Vector3.new(0, 0, -1) or Flat.Unit

		-- Lets the aim hooks used by the hub's skills point at the same target.
		getgenv().AimPos = CFrame.new(aimPoint)

		-- Direct remotes (no real click, no cooldown).
		local ClickRemote = tool:FindFirstChild("LeftClickRemote")
		local RemoteFn = tool:FindFirstChild("RemoteFunction")
		local RemoteEv = tool:FindFirstChild("RemoteEvent")
		if not ClickRemote and RemoteFn then
			if RemoteEv then
				RemoteEv:FireServer(aimPoint)
			end
			-- Only one invoke in flight (unbounded threads exhaust the queue); a hung
			-- invoke is released after 0.5s so the clicks never stay blocked.
			if not FruitM1State.Busy or now - FruitM1State.BusyAt > 0.5 then
				FruitM1State.Busy = true
				FruitM1State.BusyAt = now
				task.spawn(function()
					pcall(function()
						RemoteFn:InvokeServer("TAP")
					end)
					FruitM1State.Busy = false
				end)
			end
			return true
		end
		if ClickRemote and toolName == "Mammoth-Mammoth" then
			ClickRemote:FireServer(aimPoint)
			return true
		end
		if ClickRemote then
			FruitM1State.Combo = FruitM1State.Combo % 5 + 1
			ClickRemote:FireServer(Aim, FruitM1State.Combo)
			if l then
				ClickRemote:FireServer(Flat, FruitM1State.Combo)
			end
			return true
		end
		return true
	end)
	return ok and result == true
end
getgenv().UseFruitM1 = function(g, E)
	return m(g, E, false)
end
getgenv().UseFruitM1Boat = function(g, E)
	return m(g, E, true)
end
getgenv().PathClickM1 = {}
local function g(m)
	m.ChildAdded:Connect(function(m)
		if m:IsA("Tool") then
			task.wait(0.5)
			local E = m:FindFirstChild("RemoteFunction")
			if E then
				getgenv().PathClickM1[m.Name] = E
			end
		end
	end)
end
if t.Character then
	g(t.Character)
end
t.CharacterAdded:Connect(g)
local function m(E, Range)
	local Character = t.Character
	local CharacterRoot = Character and Character:FindFirstChild("HumanoidRootPart")
	if not CharacterRoot or not E then
		return false
	end

	local TargetRoot = E:FindFirstChild("HumanoidRootPart") or E.PrimaryPart
	local TargetPosition

	if TargetRoot then
		TargetPosition = TargetRoot.Position
	elseif E:IsA("Model") then
		TargetPosition = E:GetPivot().Position
	end

	if not TargetPosition then
		return false
	end

	local Humanoid = E:FindFirstChildOfClass("Humanoid")
	if Humanoid and Humanoid.Health <= 0 then
		return false
	end

	return (CharacterRoot.Position - TargetPosition).Magnitude < (Range or 70)
end
-- Fruit/Gun clicks use a long range so they do not stop when the mob is a bit far.
function M1Dispatch(E, l, Weapon)
	if Weapon ~= "Blox Fruit" and Weapon ~= "Gun" then
		return false
	end
	if not m(E, 300) then
		return true -- invalid/dead target: nothing to click, do not fall back to melee
	end
	-- Remembered so the turbo loop keeps clicking between farm iterations.
	getgenv().M1Target = E
	getgenv().M1TargetL = l
	getgenv().M1TargetWeapon = Weapon
	getgenv().M1TargetTime = os.clock()
	if Weapon == "Blox Fruit" then
		getgenv().UseFruitM1(E, l)
	else
		ShootM1(E)
	end
	return true
end
getgenv().ClickM1 = function(E, l)
	if M1Dispatch(E, l, Settings["Select Weapon"]) then
		return
	end
	if not m(E) then
		return
	end
	AttackFunction(l and 80 or 30)
end
getgenv().ClickM1Dungeon = function(E, l)
	if M1Dispatch(E, l, Settings["Select Weapon Dungeon"]) then
		return
	end
	if not m(E) then
		return
	end
	AttackFunction(l and 80 or 30)
end
getgenv().ClickM1Volcano = function(E, l)
	if M1Dispatch(E, l, Settings["Select Weapon Kill Golem"]) then
		return
	end
	if not m(E) then
		return
	end
	AttackFunction(l and 80 or 30)
end
-- Turbo: clicks every Heartbeat at the last farm target while the farm is active,
-- so the clicks never stop during teleports/waits of the farm loops.
function M1TurboStep()
	if getgenv().M1Turbo == false then
		return
	end
	local tgt = getgenv().M1Target
	if not tgt or os.clock() - (getgenv().M1TargetTime or 0) > 0.35 then
		return
	end
	if typeof(tgt) ~= "Instance" or not tgt.Parent then
		return
	end
	local hum = tgt:FindFirstChildOfClass("Humanoid")
	if hum and hum.Health <= 0 then
		return
	end
	-- Watchdog: if the fruit has not fired for 1s although there is a live target,
	-- release any stuck state so the clicks come back by themselves.
	if os.clock() - FruitM1State.LastFire > 1 then
		FruitM1State.Busy = false
		FruitM1State.Combo = 0
	end
	if getgenv().M1TargetWeapon == "Blox Fruit" then
		getgenv().UseFruitM1(tgt, getgenv().M1TargetL)
	elseif getgenv().M1TargetWeapon == "Gun" then
		ShootM1(tgt)
	end
end
if getgenv().M1TurboConn then
	pcall(function()
		getgenv().M1TurboConn:Disconnect()
	end)
end
getgenv().M1TurboConn = game:GetService("RunService").Heartbeat:Connect(function()
	pcall(M1TurboStep)
end)
local m = L:WaitForChild("Modules")
getgenv().SpamGunDragonStorm = function(E)
	local Q = t.Character
	local d = Q and (Q:FindFirstChild("Dragonstorm"))
	if not d or not E or not E.Position then
		return
	end
	local reloading = false
	pcall(function()
		reloading = require(m.CombatUtil):IsGunReloading(d)
	end)
	if reloading then
		return
	end
	-- Validação do jogo: depende de índices de upvalue que mudam a cada update.
	-- Antes um erro aqui impedia o tiro; agora é tentativa protegida e o tiro sai de qualquer forma.
	pcall(function()
		local l = getupvalues(require(L.Controllers.CombatController).Attack)[9]
		local I, _, o, V, N, y, P =
			debug.getupvalue(l, 15),
			debug.getupvalue(l, 13),
			debug.getupvalue(l, 16),
			debug.getupvalue(l, 17),
			debug.getupvalue(l, 14),
			debug.getupvalue(l, 12),
			debug.getupvalue(l, 18)
		local Q2 = y * _
		local d2 = ((N * _ + y * I) % o * o + Q2) % V
		N = math.floor(d2 / o)
		y = d2 - N * o
		P += 1
		debug.setupvalue(l, 15, I)
		debug.setupvalue(l, 13, _)
		debug.setupvalue(l, 16, o)
		debug.setupvalue(l, 17, V)
		debug.setupvalue(l, 14, N)
		debug.setupvalue(l, 12, y)
		debug.setupvalue(l, 18, P)
		L.Remotes.Validator2:FireServer(math.floor(d2 / V * 16777215), P)
	end)
	pcall(function()
		m.Net:FindFirstChild("RE/ShootGunEvent"):FireServer(E.Position, { E })
	end)
end
GunM1State = { Last = 0 }
-- Equipa uma tool só quando preciso: se já está na mão não faz nada, e as tentativas
-- têm intervalo (antes o turbo chamava EquipTool a cada frame e brigava com o farm).
function EquipOnlyIfNeeded(toolName, interval)
	local char = t.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not char or not hum or hum.Health <= 0 or hum.Sit or not toolName then
		return false
	end
	if char:FindFirstChild(toolName) then
		return true -- já equipada
	end
	local last = getgenv().__EquipLast or {}
	getgenv().__EquipLast = last
	if os.clock() - (last[toolName] or 0) < (interval or 1.5) then
		return false
	end
	local bp = t.Backpack:FindFirstChild(toolName)
	if not bp then
		return false
	end
	last[toolName] = os.clock()
	hum:EquipTool(bp)
	return false -- vai atirar no próximo ciclo
end
function DragonstormPhysicalClick(force)
	local now = os.clock()
	if not force and now - (getgenv().__DSClickLast or 0) < (getgenv().DSClickInterval or 0.5) then
		return false
	end
	getgenv().__DSClickLast = now
	task.spawn(function()
		pcall(function()
			local Camera = workspace.CurrentCamera
			if not Camera then
				return
			end
			local vp = Camera.ViewportSize
			-- Mouse reto para o TOPO da tela (centro horizontal) antes de clicar.
			local x, y = math.floor(vp.X / 2), 2
			local VIM = game:GetService("VirtualInputManager")
			VIM:SendMouseMoveEvent(x, y, game)
			task.wait(0.03)
			VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
			task.wait(0.05)
			VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
			-- Celular: o clique de mouse não vale, então manda também um toque (fora da barra do topo) e Activate na tool.
			pcall(function()
				local tx, ty = x, math.max(64, math.floor(vp.Y * 0.12))
				VIM:SendTouchEvent(1, 0, tx, ty)
				task.wait(0.04)
				VIM:SendTouchEvent(1, 2, tx, ty)
			end)
			pcall(function()
				local tool = t.Character and t.Character:FindFirstChild("Dragonstorm")
				if tool then tool:Activate() end
			end)
			pcall(function()
				local VU = game:GetService("VirtualUser")
				VU:CaptureController()
				VU:ClickButton1(Vector2.new(x, y))
			end)
		end)
	end)
	return true
end
function ShootM1(E)
	local char = t.Character
	if not char or not E then
		return false
	end
	local gunName = NameWeapon("Gun")
	local gun = gunName and char:FindFirstChild(gunName)
	if not gun then
		-- Gun fora da mão: equipa só quando preciso e atira no próximo ciclo.
		EquipOnlyIfNeeded(gunName, 1.5)
		return false
	end
	if gunName == "Dragonstorm" then
		DragonstormPhysicalClick()
	end
	-- Target part / position (accepts Model, BasePart, Vector3 or CFrame).
	local targetPart, targetPos
	if typeof(E) == "Instance" then
		if E:IsA("BasePart") then
			targetPart, targetPos = E, E.Position
		elseif E:IsA("Model") then
			targetPart = E:FindFirstChild("HumanoidRootPart") or E.PrimaryPart
			targetPos = targetPart and targetPart.Position or E:GetPivot().Position
		end
	elseif typeof(E) == "Vector3" then
		targetPos = E
	elseif typeof(E) == "CFrame" then
		targetPos = E.Position
	end
	if not targetPos then
		return false
	end
	-- Same guard as the melee attack: no shots while stunned.
	local stun = char:FindFirstChild("Stun")
	if stun and stun.Value ~= 0 then
		return true
	end
	-- No cooldown / no reload check, only a small floor so the remotes do not flood.
	-- Adjust with getgenv().GunM1Delay (seconds).
	local now = os.clock()
	local delay = getgenv().GunM1Delay or 0.05
	if now - GunM1State.Last < delay then
		return true
	end
	GunM1State.Last = now
	getgenv().AimPos = CFrame.new(targetPos)


	if gunName == "Skull Guitar" then
		if getgenv().SpamGunSkullGuitar then
			getgenv().SpamGunSkullGuitar(targetPart or targetPos)
		end
		return true
	end
	-- Remote shot.
	-- The validator uses upvalue indexes that change on game updates, so it is protected.
	pcall(function()
		local rs = game:GetService("ReplicatedStorage")
		local l = getupvalues(require(rs.Controllers.CombatController).Attack)[9]
		local Q, d, I, _, o, V, N =
			debug.getupvalue(l, 15),
			debug.getupvalue(l, 13),
			debug.getupvalue(l, 16),
			debug.getupvalue(l, 17),
			debug.getupvalue(l, 14),
			debug.getupvalue(l, 12),
			debug.getupvalue(l, 18)
		local y = V * d
		local P = ((o * d + V * Q) % I * I + y) % _
		o = math.floor(P / I)
		V = P - o * I
		N += 1
		debug.setupvalue(l, 15, Q)
		debug.setupvalue(l, 13, d)
		debug.setupvalue(l, 16, I)
		debug.setupvalue(l, 17, _)
		debug.setupvalue(l, 14, o)
		debug.setupvalue(l, 12, V)
		debug.setupvalue(l, 18, N)
		rs.Remotes.Validator2:FireServer(math.floor(P / _ * 16777215), N)
	end)
	pcall(function()
		local shoot = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RE/ShootGunEvent")
		if not shoot then
			return
		end
		if gunName == "Cannon" then
			shoot:FireServer(targetPos)
		else
			shoot:FireServer(targetPos, targetPart and { targetPart } or {})
		end
	end)
	return true
end
getgenv().SpamGunSkullGuitar = function(E)
	local combatUtil, character = require(m.CombatUtil), t.Character
	local gun = character and character:FindFirstChild("Skull Guitar")
	if not gun or not E or not character then
		return false
	end
	-- Tyrant's destructible Tree is a Model; aim at a real BasePart instead
	-- of the model pivot, which can be outside the hitbox.
	local targetPart, targetPosition
	if typeof(E) == "Instance" then
		if E:IsA("BasePart") then
			targetPart = E
		elseif E:IsA("Model") then
			targetPart = E:FindFirstChild("HumanoidRootPart", true)
				or E:FindFirstChild("Handle", true)
				or E:FindFirstChildWhichIsA("BasePart", true)
		end
		if targetPart then targetPosition = targetPart.Position end
	elseif typeof(E) == "CFrame" then
		targetPosition = E.Position
	elseif typeof(E) == "Vector3" then
		targetPosition = E
	end
	if not targetPosition then return false end
	-- Do not stop firing just because the reload helper briefly reports busy;
	-- the M1 loop retries on its next iteration. Keep calls throttled.
	local now = os.clock()
	if now - (getgenv().__SkullGuitarM1Last or 0) < 0.12 then return true end
	getgenv().__SkullGuitarM1Last = now
	getgenv().AimPos = CFrame.new(targetPosition)
	local stun = character:FindFirstChild("Stun")
	if stun and stun.Value ~= 0 then return true end
	-- Send the regular M1 shot first, with the destructible part as hit target.
	local sent = false
	pcall(function()
		local rs = game:GetService("ReplicatedStorage")
		local net = rs:FindFirstChild("Modules") and rs.Modules:FindFirstChild("Net")
		local shoot = net and net:FindFirstChild("RE/ShootGunEvent")
		if shoot and targetPart then
			shoot:FireServer(targetPosition, { targetPart })
			sent = true
		end
	end)
	-- Skull Guitar's TAP remote is retained as a fallback for game versions
	-- that route its basic shot through the tool remote.
	-- O TAP é o disparo próprio da Skull Guitar: sempre enviado, junto com o tiro normal.
	pcall(function()
		local remote = gun:FindFirstChild("RemoteEvent")
		if remote then remote:FireServer("TAP", targetPosition); sent = true end
	end)
	return sent
end
local function m(E, l)
	local Q, d, I, _, o, V, N =
		require(game:GetService("ReplicatedStorage").Modules.CombatUtil),
		getgenv().getBladeHits,
		E.Character,
		{ E.Character.HumanoidRootPart },
		1 / 0
	for y, P in d(I, _, l, true) do
		y = Q:GetRigOfHitPart(P)
		if y and (Q:IsVulnerable(y)) then
			local l = (E.Character.HumanoidRootPart.Position - P.Position).Magnitude
			if l < o then
				o, V, N = l, y, P
			end
		end
	end
	if V and N then
		return { V, N }
	end
	return nil
end
function DetectItemPlr(E)
	if t.Character:FindFirstChild(E) or (t.Backpack:FindFirstChild(E)) then
		return true
	end
end
function sizepart(E)
	AttackingMob = E
	if not E or not E.Parent or not E:FindFirstChild("HumanoidRootPart") then
		return
	end
	if t:DistanceFromCharacter(E.HumanoidRootPart.Position) <= 50 then
		local l, Q, d = next, E:GetDescendants()
		for E, E in l, Q, d do
			if (E:IsA("Part") or (E:IsA("MeshPart"))) and E.CanCollide then
				E.CanCollide = false
			end
		end
	end
end
local E, l
function DeleteIgnoredMob()
	for Q, Q in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
		if Q:IsA("Model") and (Q:FindFirstChild("Ignored")) then
			Q.Ignored:Destroy()
		end
	end
end
function DetectMob(Q)
	local d, I = 1 / 0
	for _, o in pairs(game.Workspace.Enemies:GetChildren()) do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			_ = (
				o.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position
			).magnitude
			if _ < d then
				d, I = _, o
			end
		end
	end
	return I
end
function CheckNameBoss(Q)
	local d, I, _ = next, game.ReplicatedStorage:GetChildren()
	for o, o in d, I, _ do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			return o
		end
	end
	d, _, I = next, game.Workspace.Enemies:GetChildren()
	for o, o in d, _, I do
		if (typeof(Q) == "table" and (table.find(Q, o.Name)) or o.Name == Q) and (IsMobAlive(o)) then
			return o
		end
	end
end
getgenv().TableMobSpawn = {}
spawn(function()
	for Q, Q in pairs(getnilinstances()) do
		if
			if Q:GetAttribute("DisplayName") and (string.find(Q:GetAttribute("DisplayName"), "Lv."))
				then (Q:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", ""))
				else nil
		then
			table.insert(TableMobSpawn, Q)
		end
	end
	for Q, Q in pairs(game:GetService("Workspace")._WorldOrigin.EnemySpawns:GetChildren()) do
		if
			if Q:GetAttribute("DisplayName") and (string.find(Q:GetAttribute("DisplayName"), "Lv."))
				then (Q:GetAttribute("DisplayName"):gsub(" %pLv. %d+%p", ""))
				else nil
		then
			table.insert(TableMobSpawn, Q)
		end
	end
end)
function getcenter(Q)
	if string.find(Q, "Lv.") then
		name1 = Q:gsub(" %pLv. %d+%p", "")
	end
	local d
	local I = 0
	for _, o in pairs(TableMobSpawn) do
		_ = if string.find(o.Name, "Lv.") then (o.Name:gsub(" %pLv. %d+%p", "")) else nil
		if o:IsA("Part") and (_ and _ == Q or Q == o.Name or name1 and o.Name == name1) then
			if d == nil then
				d, I = o.Position, I + 1
			else
				d, I = d + o.Position, I + 1
			end
		end
	end
	d /= I
	return CFrame.new(d)
end
function DetectPartMobBring(Q, d, I, _)
	local o, V = {}, if string.find(Q, "Lv.") then (Q:gsub(" %pLv. %d+%p", "")) else nil
	for N, y in pairs(TableMobSpawn) do
		N = if string.find(y.Name, "Lv.") then (y.Name:gsub(" %pLv. %d+%p", "")) else nil
		if y:IsA("Part") and (N and N == Q or Q == y.Name or V and y.Name == V) then
			table.insert(o, y)
		end
	end
	if I then
		Q, V = 1 / 0
		for I, N in next, o, nil do
			I = (d.HumanoidRootPart.Position - N.Position).Magnitude
			if Q > I then
				Q, V = I, N
			end
		end
		return V
	else
		local Q = {}
		for d, d in next, o, nil do
			if (_.Position - d.Position).Magnitude <= 200 then
				table.insert(Q, d)
			end
		end
		if #Q < #o then
			return true
		end
	end
end
function isnetworkowner2(Q)
	local d, I, _ = next, game.Workspace.Characters:GetChildren()
	for o, o in d, I, _ do
		if
			o.Name ~= t.Name
			and (o:FindFirstChild("HumanoidRootPart"))
			and (o.HumanoidRootPart.Position - Q.Position).Magnitude <= 300
		then
			return false
		end
	end
	return true
end
function BringMob(Q)
	if not Settings["Bring Mob"] then return end
	if not Q or not Q.Parent or not Q:FindFirstChild("HumanoidRootPart") then return end
	local Character = t.Character
	local Root = Character and Character:FindFirstChild("HumanoidRootPart")
	if not Root then return end
	if tick() - (getgenv().__BringLast or 0) < 0.25 then return end
	getgenv().__BringLast = tick()
	local anchor = Q.HumanoidRootPart.CFrame
	if (Root.Position - anchor.Position).Magnitude > 120 then return end
	pcall(function() sethiddenproperty(t, "SimulationRadius", math.huge) sethiddenproperty(t, "MaxSimulationRadius", math.huge) end)
	local count = math.clamp(tonumber(Settings["Bring Mob Count"]) or 2, 2, 6)
	local radius = count > 2 and 350 or 250
	local gathered = 1
	for _, mob in ipairs(workspace.Enemies:GetChildren()) do
		if gathered >= count then break end
		if mob ~= Q and mob.Name == Q.Name and not mob:FindFirstChild("Ignored") and IsMobAlive(mob) then
			local hrp = mob.HumanoidRootPart
			if (hrp.Position - anchor.Position).Magnitude <= radius then
				hrp.CFrame = anchor * CFrame.new(math.random(-3, 3), 0, math.random(-3, 3))
				hrp.CanCollide = false
				pcall(function() mob.Humanoid.WalkSpeed = 0 mob.Humanoid.JumpPower = 0 end)
				sizepart(mob)
				gathered += 1
				task.wait(0.15)
			end
		end
	end
end
task.wait(1)
SettingFarmMain = Main.CreatePage({ Page_Name = "Setting Farm", Page_Title = "Setting Farm" })
SettingFarmMainSection = SettingFarmMain.CreateSection("Setting Farm")
local Q, d =
	false,
	SettingFarmMainSection.CreateDropdown(
		{
			Title = "Select Weapon",
			List = { "Melee", "Sword", "Gun", "Blox Fruit" },
			Search = true,
			Selected = false,
			Default = Settings["Select Weapon"] or nil,
		},
		function(I)
			SaveSettings("Select Weapon", I)
		end
	)
SettingFarmMainSection.CreateToggle(
	{ Title = "Attack No Animation ", Desc = nil, Default = Settings["Attack No Animation "] or true },
	function(I)
		SaveSettings("Attack No Animation ", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{
		Title = "Kill Aura Only Raid And Volcano",
		Desc = nil,
		Default = Settings["Kill Aura Only Raid And Volcano"] or false,
	},
	function(I)
		SaveSettings("Kill Aura Only Raid And Volcano", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Time Delay Kill", Min = 0, Max = 5, Default = Settings["Time Delay Kill"] or 5, Precise = true },
	function(I)
		SaveSettings("Time Delay Kill", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Click", Desc = nil, Default = Settings["Auto Click"] or false },
	function(I)
		SaveSettings("Auto Click", I)
		if I then
			spawn(function()
				while Settings["Auto Click"] and (task.wait()) do
					local _, _ = pcall(function()
						local o = NameWeapon("Blox Fruit")
						if o and (t.Character:FindFirstChild(o)) then
							local o = AttackAOE(80, true)
							if not o then
								return
							end
							getgenv().UseFruitM1(o[1][1])
						else
							getgenv().AttackFunctionnhungSuperTrial()
						end
					end)
				end
			end)
		end
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Kill Aura With DragonStorm", Desc = nil, Default = Settings["Kill Aura With DragonStorm"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Kill Aura With DragonStorm"] and (wait()) do
					pcall(function()
						if t.Character:FindFirstChild("Dragonstorm") and getgenv().SpamGunDragonStorm then
							local _ = m(game.Players.LocalPlayer, 150)
							if _ then
								local m, o = _[1], _[2]
								SpamGunDragonStorm(m.PrimaryPart)
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Kill Aura With DragonStorm", I)
	end
)
function FFCMatch(m, I)
	for _, _ in pairs(m:GetChildren()) do
		if string.match(_.Name, I) then
			return _
		end
	end
	return nil
end
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On Buso", Desc = nil, Default = Settings["Auto Turn On Buso"] ~= false },
	function(m)
		SaveSettings("Auto Turn On Buso", m)
		if m then
			spawn(function()
				while Settings["Auto Turn On Buso"] and (wait(1)) do
					pcall(function()
						if not FFCMatch(t.Character, "_BusoLayer1") and not t.Character:FindFirstChild("HasBuso") then
							CommF:InvokeServer("Buso")
							task.wait(2)
						end
					end)
				end
			end)
		end
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On Observation", Desc = nil, Default = Settings["Auto Turn On Observation"] or false },
	function(m)
		SaveSettings("Auto Turn On Observation", m)
		if m then
			spawn(function()
				while Settings["Auto Turn On Observation"] and task.wait(0.5) do
					pcall(function()
						local blur = game:GetService("Lighting"):FindFirstChild("Blur")
						if not blur or not blur.Enabled then
							-- Clica no botão de ativar Haki da observação (tecla E)
							pcall(function()
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "E", false, game)
								task.wait(0.1)
								game:GetService("VirtualInputManager"):SendKeyEvent(false, "E", false, game)
							end)
							task.wait(0.3)
							pcall(function()
								game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
								task.wait(0.1)
								game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
							end)
							pcall(function()
								game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
							end)
						end
					end)
				end
			end)
		end
	end
)
function TurnOnV4()
	local m = t.Character
	local I, _ = m and (m:FindFirstChild("RaceEnergy")), m and (m:FindFirstChild("RaceTransformed"))
	if not I or I.Value < 1 or not _ or _.Value then
		return
	end
	_ = t.Backpack:FindFirstChild("Awakening") or (m:FindFirstChild("Awakening"))
	if _ then
		_.RemoteFunction:InvokeServer(true)
	end
end
local m = SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On V4", Desc = nil, Default = Settings["Auto Turn On V4"] or false },
	function(I)
		SaveSettings("Auto Turn On V4", I)
		if I then
			spawn(function()
				while Settings["Auto Turn On V4"] and (task.wait(1)) do
					pcall(TurnOnV4)
				end
			end)
		end
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Turn On V3", Desc = nil, Default = Settings["Auto Turn On V3"] or false },
	function(I)
		SaveSettings("Auto Turn On V3", I)
		if I then
			spawn(function()
				while Settings["Auto Turn On V3"] and (task.wait(1)) do
					game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
					wait(2)
				end
			end)
		end
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Auto Dodge Skill Mobs", Desc = nil, Default = Settings["Auto Dodge Skill Mobs"] or false },
	function(I)
		SaveSettings("Auto Dodge Skill Mobs", I)
	end
)
local I
game:GetService("Workspace").Enemies.DescendantAdded:Connect(function(_)
	if
		Settings["Auto Dodge Skill Mobs"]
		and I
		and I.Parent
		and not Doding
		and (_.Name == "BodyGyro" or _.Name == "BodyPosition" or _.Name == "KiBlastFireShort")
		and _.Parent.Parent.Name == I.Name
	then
		getgenv().Doding = true
		getgenv().ReadyToDodge = true
		local I = tick()
		repeat
			wait()
		until not _ or not _.Parent or tick() - I > 14
		if tick() - I < 2 then
			wait(0.5)
		end
		getgenv().Doding = false
		getgenv().ReadyToDodge = false
	end
end)


-- Auto Dodge Skill Mobs - FIX DEFINITIVO: não sobe, só desvia quando mob realmente usa skill perto
getgenv().Doding = false
getgenv().ReadyToDodge = false
if getgenv().DodgeConnection then getgenv().DodgeConnection:Disconnect() end
getgenv().DodgeConnection = game:GetService("Workspace").Enemies.DescendantAdded:Connect(function(skill)
	pcall(function()
		if not Settings["Auto Dodge Skill Mobs"] then return end
		if getgenv().Doding then return end
		if skill.Name ~= "BodyGyro" and skill.Name ~= "BodyPosition" and skill.Name ~= "BodyVelocity" then return end
		local parent = skill.Parent
		if not parent or parent.Name ~= "HumanoidRootPart" then return end
		local mob = parent.Parent
		if not mob or not mob:FindFirstChild("Humanoid") or not mob:FindFirstChild("HumanoidRootPart") then return end
		-- Só se for o mob que tá atacando você
		local attacking = getgenv().AttackingMob
		if attacking and mob.Name ~= attacking.Name then return end
		local char = game:GetService("Players").LocalPlayer.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		local dist = (root.Position - mob.HumanoidRootPart.Position).Magnitude
		if dist > 55 then return end
		-- Skill com P alto = skill real de ataque
		if skill:IsA("BodyGyro") and skill.P and skill.P < 500 then return end
		getgenv().Doding = true
		getgenv().ReadyToDodge = true
		local oldPos = root.Position
		local away = (root.Position - mob.HumanoidRootPart.Position)
		away = Vector3.new(away.X, 0, away.Z)
		if away.Magnitude < 1 then away = Vector3.new(math.random(-1,1), 0, math.random(-1,1)) end
		away = away.Unit * 20
		local targetPos = Vector3.new(oldPos.X + away.X, oldPos.Y, oldPos.Z + away.Z)
		pcall(function()
			root.CFrame = CFrame.new(targetPos.X, oldPos.Y, targetPos.Z)
			root.AssemblyLinearVelocity = Vector3.new(0,0,0)
		end)
		local start = tick()
		repeat task.wait(0.1) until not skill.Parent or tick()-start > 1.8
		task.wait(0.2)
		getgenv().Doding = false
		getgenv().ReadyToDodge = false
	end)
end)

SettingFarmMainSection.CreateToggle(
	{ Title = "Teleport Y if low health", Desc = nil, Default = Settings["Teleport Y"] or false },
	function(I)
		SaveSettings("Teleport Y", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "% Health Player", Min = 0, Max = 100, Default = Settings["% Health Player"] or 40, Precise = true },
	function(I)
		SaveSettings("% Health Player", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{
		Title = "Distance Teleport Y",
		Min = 0,
		Max = 10000,
		Default = Settings["Distance Teleport Y"] or 800,
		Precise = true,
	},
	function(I)
		SaveSettings("Distance Teleport Y", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Tween Safe if have Items", Desc = nil, Default = Settings["Tween Safe if have Items"] or false },
	function(I)
		if I then
			spawn(function()
				while Settings["Tween Safe if have Items"] and (wait(0.25)) do
					pcall(function()
						if CheckNameBoss("Darkbeard") and Settings["Attack Darkbeard"] then
							return
						end
						if DetectItemPlr("Fist of Darkness") and Settings["Summon Darkbeard"] then
							return
						end
						if
							(DetectItemPlr("Fist of Darkness") or (DetectItemPlr("God's Chalice")))
							and Settings["Tween Safe if have Items"]
						then
							if game.PlaceId == getgenv().CheckPlaceId2 then
								toTarget(CFrame.new(-385.250916, 73.0458984, 297.388397))
							else
								toTarget(CFrame.new(-12463, 374, -7523))
							end
						end
					end)
				end
			end)
		end
		SaveSettings("Tween Safe if have Items", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Time Hop Server", Min = 0, Max = 60, Default = Settings["Time Hop Server"] or 10, Precise = true },
	function(I)
		SaveSettings("Time Hop Server", I)
	end
)
SettingFarmMainSection.CreateSlider(
	{ Title = "Bring Mob Count", Min = 2, Max = 6, Default = Settings["Bring Mob Count"] or 2, Precise = true },
	function(I)
		SaveSettings("Bring Mob Count", I)
	end
)
SettingFarmMainSection.CreateToggle(
	{ Title = "Bring Mob", Desc = nil, Default = Settings["Bring Mob"] or true },
	function(I)
		SaveSettings("Bring Mob", I)
	end
)
SaveSettings("Speed Tween ", 220)
SettingFarmMainSection.CreateLabel({
	Title = "Speed Tween: 220",
})
SettingSkillMain =
	Main.CreatePage({ Page_Name = "Hold and Select Skill", Page_Title = "Setting Hold and Select Skill" })
SelectSkillsSection = SettingSkillMain.CreateSection("Select Skills")
local function I(_, o)
	local V, N = "Select Skills " .. _, {}
	for y, y in ipairs(o) do
		N[y] = false
	end
	EnsureAllTrueDefaults(V, o)
	_ = PrepareMultiSelectList(N, Settings[V], true)
	SelectSkillsSection.CreateDropdown(
		{ Title = V, List = _, Search = true, Selected = true, Default = Settings[V] or nil },
		function(_, o)
			SaveSettings(V, _, o)
		end
	)
end
I("Melee", { "Z", "X", "C" })
I("Sword", { "Z", "X" })
I("Gun", { "Z", "X" })
I("Blox Fruit", { "Z", "X", "C", "V", "F" })
HoldSkillsSection = SettingSkillMain.CreateSection("Hold Skills")
local function _(o, V)
	local N = {}
	for y, y in ipairs(V) do
		N[y] = {
			Title = y,
			KeyName = y,
			Min = 0,
			Max = 5,
			Default = Settings["Skill " .. y .. " " .. o] or 0.5,
			Precise = true,
		}
	end
	HoldSkillsSection.CreateDropdown({ Title = "Set Delay " .. o, List = N, Slider = true }, function(V, V)
		if V and V.KeyName then
			SaveSettings("Skill " .. V.KeyName .. " " .. o, V.Default)
		end
	end)
end
HoldSkillsSection.CreateToggle(
	{ Title = "Use skill fast dont hold", Desc = nil, Default = Settings["Use skill fast dont hold"] or false },
	function(o)
		SaveSettings("Use skill fast dont hold", o)
	end
)
_("Melee", { "Z", "X", "C" })
_("Sword", { "Z", "X" })
_("Gun", { "Z", "X" })
_("Blox Fruit", { "Z", "X", "C", "V", "F" })
FarmMain = Main.CreatePage({ Page_Name = "Farming", Page_Title = "Farming" })
SettingAutoFarmSection = FarmMain.CreateSection("Farming")
-- Individual farm toggles. Each method keeps its own state; no Select Method Farm dropdown.
local FarmToggleNames = {
	"Auto Farm Level",
	"Auto Farm Bones",
	"Auto Farm Katakuri",
	"Auto Farm Tyrant of the Skies",
	"Aura Farm",
}

local function GetSelectedIndividualFarm()
	for _, name in ipairs(FarmToggleNames) do
		if Settings[name] then
			return name
		end
	end
	return nil
end

local function SetIndividualFarm(name, enabled)
	-- Each farm toggle owns only its own setting; do not silently switch off the others.
	SaveSettings(name, enabled)
	SaveSettings("Auto Farm Active", GetSelectedIndividualFarm() ~= nil)
	-- Auto Quest handles quest NPC interaction; farm toggles handle target selection and combat.
end

SettingAutoFarmSection.CreateSlider(
	{
		Title = "Distance Farm Aura",
		Min = 0,
		Max = 1000,
		Default = Settings["Distance Farm Aura"] or 300,
		Precise = true,
	},
	function(o)
		SaveSettings("Distance Farm Aura", o)
	end
)
SettingAutoFarmSection.CreateToggle({ Title = "Auto Farm Level", Desc = nil, Default = Settings["Auto Farm Level"] or false }, function(v) SetIndividualFarm("Auto Farm Level", v) end)
SettingAutoFarmSection.CreateToggle({ Title = "Auto Farm Bones", Desc = nil, Default = Settings["Auto Farm Bones"] or false }, function(v) SetIndividualFarm("Auto Farm Bones", v) end)
SettingAutoFarmSection.CreateToggle({ Title = "Auto Farm Katakuri", Desc = nil, Default = Settings["Auto Farm Katakuri"] or false }, function(v) SetIndividualFarm("Auto Farm Katakuri", v) end)
SettingAutoFarmSection.CreateToggle({ Title = "Auto Farm Tyrant of the Skies", Desc = nil, Default = Settings["Auto Farm Tyrant of the Skies"] or false }, function(v) SetIndividualFarm("Auto Farm Tyrant of the Skies", v) end)
SettingAutoFarmSection.CreateToggle({ Title = "Aura Farm", Desc = nil, Default = Settings["Aura Farm"] or false }, function(v) SetIndividualFarm("Aura Farm", v) end)
SettingAutoFarmSection = FarmMain.CreateSection("Setting")
SettingAutoFarmSection.CreateToggle(
	{ Title = "Ignore Attack Katakuri", Desc = nil, Default = Settings["Ignore Attack Katakuri"] or false },
	function(o)
		SaveSettings("Ignore Attack Katakuri", o)
	end
)
SettingAutoFarmSection.CreateToggle(
	{ Title = "Hop Find Katakuri", Desc = nil, Default = Settings["Hop Find Katakuri"] or false },
	function(o)
		SaveSettings("Hop Find Katakuri", o)
	end
)
SettingAutoFarmSection.CreateToggle(
	{ Title = "Auto Quest", Desc = "Only accepts the quest of the selected farm (Level/Bones/Katakuri/Tyrant).", Default = true },
	function(V)
		if getgenv().__AQCycleSync then return end
		getgenv().__AQUserWants = V
		SaveSettings("Auto Quest [Katakuri/Bone/Tyrant]", V)
	end
)
-- Ciclo Auto Quest: 10s ligado e 75s desligado, somente na ilha do farm selecionado.
-- Fora da ilha correspondente, o ciclo fica pausado e não altera o toggle.
do
	getgenv().__AQToggleCycleGeneration = (getgenv().__AQToggleCycleGeneration or 0) + 1
	local cycleGeneration = getgenv().__AQToggleCycleGeneration
	local toggleKey = "Auto Quest [Katakuri/Bone/Tyrant]"
	local function SetAutoQuestToggle(value)
		if value and getgenv().__AQUserWants == false then return end
		getgenv().__AQCycleSync = true
		pcall(function() SaveSettings(toggleKey, value) end)
		pcall(function()
			local option = Options and Options["Auto Quest"]
			local control = option and option.FunctionCreate
			if control and control.SetValue then control:SetValue(value) end
		end)
		task.delay(0.25, function()
			if getgenv().__AQToggleCycleGeneration == cycleGeneration then
				getgenv().__AQCycleSync = false
			end
		end)
	end
	local function GetSelectedQuestNPCPosition()
		local selected = GetSelectedIndividualFarm and GetSelectedIndividualFarm()
		if not selected or selected == "Aura Farm" or Settings["Farm Material"] then return nil end
		local targetPosition
		if selected == "Auto Farm Level" then
			pcall(function()
				local info = GetLevelQuestInfo(t.Data.Level.Value)
				if info and info.Pos then
					targetPosition = typeof(info.Pos) == "CFrame" and info.Pos.Position or info.Pos
				end
			end)
		else
			local info = AutoQuestInfo and AutoQuestInfo[selected]
			local points = getgenv().questpoint
			local cf = info and points and points[info[2]]
			if cf then targetPosition = cf.Position end
		end
		return targetPosition
	end
	local function IsOnSelectedFarmIsland()
		local targetPosition = GetSelectedQuestNPCPosition()
		local root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
		if not root or not targetPosition then return false end
		-- Distância ampla para reconhecer que chegou à ilha correspondente.
		return (root.Position - targetPosition).Magnitude <= 2500
	end
	local function IsNearSelectedQuestNPC()
		local targetPosition = GetSelectedQuestNPCPosition()
		local root = t.Character and t.Character:FindFirstChild("HumanoidRootPart")
		if not root or not targetPosition then return false end
		-- O ciclo só começa quando o personagem chega perto do NPC da missão.
		return (root.Position - targetPosition).Magnitude <= 100
	end
	task.spawn(function()
		local isEnabled = true
		local startedAtNPC = false
		SetAutoQuestToggle(true)
		while getgenv().__AQToggleCycleGeneration == cycleGeneration do
			if IsOnSelectedFarmIsland() and (startedAtNPC or IsNearSelectedQuestNPC()) then
				startedAtNPC = true
				local duration = isEnabled and 10 or 75
				local deadline = tick() + duration
				while getgenv().__AQToggleCycleGeneration == cycleGeneration and IsOnSelectedFarmIsland() and tick() < deadline do
					task.wait(0.25)
				end
				if getgenv().__AQToggleCycleGeneration ~= cycleGeneration then break end
				if IsOnSelectedFarmIsland() then
					isEnabled = not isEnabled
					SetAutoQuestToggle(isEnabled)
				end
			else
				-- Na ilha, aguarda chegar perto do NPC; fora dela, também aguarda sem alterar o toggle.
				-- Farm desligado (ou ainda fora da ilha): o Auto Quest fica/volta ligado; só desliga se o usuário desligar.
				if (not GetSelectedIndividualFarm() or not IsOnSelectedFarmIsland()) and not Settings[toggleKey] and getgenv().__AQUserWants ~= false then
					SetAutoQuestToggle(true)
					isEnabled = true
					startedAtNPC = false
				end
				task.wait(1)
			end
		end
	end)
end
-- Mantém os toggles "Farm Mastery" e "Start Farm" visualmente iguais ao estado real.
function SyncMasteryToggle(title, v)
	if getgenv().__MasterySyncing then
		return
	end
	getgenv().__MasterySyncing = true
	pcall(function()
		local opt = Options and Options[title]
		if opt and opt.FunctionCreate and opt.FunctionCreate.SetValue then
			opt.FunctionCreate:SetValue(v)
		end
	end)
	task.delay(0.3, function()
		getgenv().__MasterySyncing = false
	end)
end
MasteryFarmSection = FarmMain.CreateSection("Mastery Farm")
MasteryFarmSection.CreateDropdown(
	{
		Title = "Select Method Farm Mastery",
		List = { "Blox Fruit", "Gun", "Sword" },
		Search = true,
		Selected = false,
		Default = Settings["Select Method Farm Mastery"] or nil,
	},
	function(V)
		SaveSettings("Select Method Farm Mastery", V)
	end
)
MasteryFarmSection.CreateSlider(
	{ Title = "Health %", Min = 0, Max = 100, Default = Settings["Health %"] or 40, Precise = true },
	function(V)
		SaveSettings("Health %", V)
	end
)
MasteryFarmSection.CreateToggle(
	{ Title = "Farm Mastery", Desc = "Enable mastery farming logic.", Default = Settings["Farm Mastery"] or false },
	function(V)
		SaveSettings("Farm Mastery", V)
		if not V then
			SaveSettings("Start Farm", false)
			-- Devolve o controle ao farm normal (antes ficava parado).
			SaveSettings("Auto Farm Active", GetSelectedIndividualFarm() ~= nil)
			SyncMasteryToggle("Start Farm", false)
		end
	end
)
MasteryFarmSection.CreateToggle(
	{ Title = "Start Farm", Desc = "Start Farm Mastery in Haunted Castle only.", Default = Settings["Start Farm"] or false },
	function(V)
		-- Start Farm is the only switch that activates Farm Mastery.
		SaveSettings("Farm Mastery", V)
		SaveSettings("Start Farm", V)
		-- Stops the running farm loops so they release control to Mastery.
		SaveSettings("Auto Farm Active", (not V) and GetSelectedIndividualFarm() ~= nil)
		SyncMasteryToggle("Farm Mastery", V)
	end
)
FarmingMaterialSection = FarmMain.CreateSection("Farming Material")
FarmingMaterialSection.CreateDropdown(
	{
		Title = "Select Material",
		List = TableMaterials,
		Search = true,
		Selected = false,
		Default = Settings["Select Material"] or nil,
	},
	function(V)
		SaveSettings("Select Material", V)
	end
)
FarmingMaterialSection.CreateToggle(
	{ Title = "Farm Material", Desc = nil, Default = Settings["Farm Material"] or false },
	function(V)
		SaveSettings("Farm Material", V)
		if V and not Settings["Start Farm"] then
			-- removed({ Title = "Nexora Hub", Desc = "Turn On Start Farm Plz", ShowTime = 5 })
		end
	end
)
local V, N, y, P, e, Y =
	{ "BartiloQuest", "Trainees", "MarineQuest", "CitizenQuest" },
	{},
	{ "Baking Staff", "Head Baker", "Cake Guard", "Cookie Crafter" },
	{ "Cocoa Warrior", "Chocolate Bar Battler", "Candy Rebel", "Sweet Thief" },
	{ "Reborn Skeleton", "Demonic Soul", "Living Zombie", "Posessed Mummy" },
	{ "Isle Champion", "Serpent Hunter", "Skull Slayer", "Sun-kissed Warrior" }
getgenv().NameMobQuest = ""
getgenv().NameQuest = ""
getgenv().IDQuest = 0
getgenv().questpoint = {}
local H = require(game.ReplicatedStorage.Quests)
local function B()
	local Z, C = t.Data.Level.Value, 0
	if Z >= 1450 and game.PlaceId == getgenv().CheckPlaceId2 then
		getgenv().NameMobQuest = "Water Fighter"
		getgenv().NameQuest = "ForgottenQuest"
		getgenv().IDQuest = 2
	elseif Z >= 700 and game.PlaceId == getgenv().CheckPlaceId3 then
		getgenv().NameMobQuest = "Galley Captain"
		getgenv().NameQuest = "FountainQuest"
		getgenv().IDQuest = 2
	else
		for J, F in pairs(H) do
			for q, c in pairs(F) do
				if not table.find(V, J) then
					local F = c.LevelReq
					for D, r in pairs(c.Task) do
						if Z >= F and F >= C and r > 1 then
							getgenv().NameMobQuest = D
							getgenv().NameQuest = J
							getgenv().IDQuest = q
							C = F
						end
					end
				end
			end
		end
	end
end
function CountQuest()
	local Z = {}
	for C, C in pairs(H) do
		for J, J in pairs(C) do
			for F, q in pairs(J.Task) do
				if F == getgenv().mobv then
					for J, J in pairs(C) do
						if J.LevelReq <= t.Data.Level.Value and J.Name ~= "Town Raid" then
							for C, F in pairs(J.Task) do
								if F > 1 then
									table.insert(Z, C)
								end
							end
						end
					end
				end
			end
		end
	end
	return Z
end
local Z = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
function DontQuest()
	return Z.Data and Z.Data.QuestData ~= nil
end
function GetNameDoubleQuest()
	if DontQuest() then
		for C, J in next, Z.Data.QuestData.Task, nil do
			return C
		end
	end
end
function DoubleQuest()
	wait(0.5)
	B()
	local B = {}
	if DontQuest() and GetNameDoubleQuest() == getgenv().NameMobQuest and #CountQuest() >= 2 then
		for C, J in pairs(H) do
			for F, F in pairs(J) do
				for q in pairs(F.Task) do
					if tostring(q) == getgenv().mobv then
						for F, q in pairs(J) do
							for J, c in pairs(q.Task) do
								if J ~= getgenv().mobv and c > 1 then
									B.Name = J
									B.NameQuest = C
									B.ID = F
									return B
								end
							end
						end
					end
				end
			end
		end
	else
		B.Name = getgenv().NameMobQuest
		B.NameQuest = getgenv().NameQuest
		B.ID = getgenv().IDQuest
	end
	return B
end
function CFrameQuest()
	local B = {}
	for C, J in next, H, nil do
		if C ~= "MarineQuest" then
			for F, F in next, J, nil do
				B[F.LevelReq] = C
			end
		end
	end
	getgenv().questpoint = {}
	for C, J in next, Z.Data.NPCList, nil do
		for F, q in next, J.Levels, nil do
			F = B[q]
			if C.Parent.Name ~= "Marine Leader" and F and not getgenv().questpoint[F] then
				getgenv().questpoint[F] = CFrame.new(J.Position)
			end
		end
	end
	getgenv().questpoint.SkyExp1Quest = CFrame.new(-7857.28516, 5544.34033, -382.321503)
end
local function B(C)
	local J = Z.Data.QuestData
	local F, q, c = J and (next(J.Task)), 0, {}
	for D, r in pairs(Z.Data.NPCList) do
		if not table.find(V, r.InternalQuestName) then
			for V, n in pairs(r.Levels) do
				D = H[r.InternalQuestName][V]
				if D then
					local u, W = next(D.Task)
					if W and W > 1 and n <= C and n >= q then
						c = {
							Level = n,
							Name = r.NPCName,
							QuestName = r.InternalQuestName,
							Pos = r.Position,
							Id = V,
							Mob = u,
						}
						if F == u and V > 1 then
							J = H[r.InternalQuestName][V - 1]
							if J and J.Task then
								for H, C in pairs(J.Task) do
									if H ~= F and C > 1 then
										c.Mob = H
										c.Id = V - 1
										break
									end
								end
							end
						end
						q = n
					end
				end
			end
		end
	end
	return c
end

GetLevelQuestInfo = B
TakeQuestLevel = function()
	local V = B(t.Data.Level.Value)
	if not V or not V.Pos then
		return
	end
	local H, B, C =
		typeof(V.Pos) == "CFrame" and V.Pos.Position or V.Pos,
		t.Character and (t.Character:FindFirstChild("HumanoidRootPart")),
		t.Character and (t.Character:FindFirstChild("Humanoid"))
	if not B or not C then
		return
	end
	if (H - B.Position).Magnitude <= 8 and C.Health > 0 then
		wait(2)
		CommF:InvokeServer("StartQuest", tostring(V.QuestName), V.Id)
		local timeout = tick() + 3
		repeat task.wait(0.1) until t.PlayerGui.Main:FindFirstChild("Quest") and t.PlayerGui.Main.Quest.Visible or tick() > timeout
	else
		toTarget(CFrame.new(H) * CFrame.new(0, 4, 2), true)
	end
end

function DetectPartSpawnMob(V, H)
	local function B(C)
		return C:gsub(" %p?Lv%.? %d+%p?", "")
	end
	local C = string.find(V, "Lv.") and (B(V)) or V
	for J, F in pairs(TableMobSpawn) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				return F
			end
		end
	end
	for J, F in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				table.insert(TableMobSpawn, F)
				return F
			end
		end
	end
	for J, F in pairs(getnilinstances()) do
		if F:IsA("Part") then
			J = string.find(F.Name, "Lv.") and (B(F.Name)) or F.Name
			if (J == V or J == C) and (not H or not F:FindFirstChild("Ignored")) then
				table.insert(TableMobSpawn, F)
				return F
			end
		end
	end
	return nil
end
function DeleteIgnoredMobSpawn()
	for V, V in pairs(TableMobSpawn) do
		if V:FindFirstChild("Ignored") then
			V.Ignored:Destroy()
		end
	end
end
function DetectNameTablePart(V)
	for H, H in next, V, nil do
		if not table.find(N, H) then
			return H
		end
	end
end
function TeleportSpawnMob(V)
	if typeof(V) == "table" then
		if #N >= #V then
			N = {}
			return
		end
		local H = DetectPartSpawnMob(DetectNameTablePart(V))
		if H then
			toTarget(H.CFrame * CFrame.new(0, 60, 0))
			wait(0.5)
		end
	else
		wait(0.5)
		local H = DetectPartSpawnMob(V, true)
		if H then
			if (H.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(V)) then
				Instance.new("IntValue", H).Name = "Ignored"
			end
			toTarget(H.CFrame * CFrame.new(0, 60, 0))
		else
			DeleteIgnoredMobSpawn()
		end
	end
end
function QuestBoneAndkatakuri(V, H)
	local B = getgenv().questpoint[V]
	if not B then
		CFrameQuest()
		task.wait(1.5)
		B = getgenv().questpoint[V]
		if not B then
			return
		end
	end
	local C, J =
		t.Character and (t.Character:FindFirstChild("HumanoidRootPart")),
		t.Character and (t.Character:FindFirstChildOfClass("Humanoid"))
	if not C or not J then
		return
	end
	if (B.Position - C.Position).Magnitude <= 8 then
		if J.Health > 0 then
			local ok = pcall(function()
				CommF:InvokeServer("StartQuest", V, H)
			end)
			task.wait(0.5)
			if ok and AQIsQuestActive() then
				return true
			end
		end
	else
		toTarget(B * CFrame.new(0, 4, 2), true)
	end
end
local V = { "Control-Control", "Buddha-Buddha", "Diamond-Diamond", "Falcon-Falcon" }
local function H(B, C)
	local J = t.PlayerGui.Main.Skills[B]:FindFirstChild(C)
	if not J then
		return false
	end
	return J:IsA("Frame") and J.Title.TextColor3 == Color3.new(1, 1, 1) and J.Cooldown.Size == UDim2.new(0, 0, 1, -1)
		or J.Cooldown.Size == UDim2.new(1, 0, 1, -1)
end
local function B(C)
	if H(C, "Z") then
		local H = game:GetService("VirtualInputManager")
		H:SendKeyEvent(true, "Z", false, game)
		H:SendKeyEvent(false, "Z", false, game)
	end
end
local function H(C)
	local J = t.PlayerGui.Main.Skills[C.Name]
	if not J then
		return nil
	end
	for F, F in ipairs(J:GetChildren()) do
		if
			F:IsA("Frame")
			and F.Name ~= "Template"
			and (F.Name ~= "Z" or F.Name == "Z" and not table.find(V, C.Name))
			and Settings["Select Skills " .. C.ToolTip]
			and Settings["Select Skills " .. C.ToolTip][F.Name]
			and (
				F.Title.TextColor3 == Color3.new(1, 1, 1) and F.Cooldown.Size == UDim2.new(0, 0, 1, -1)
				or F.Cooldown.Size == UDim2.new(1, 0, 1, -1)
			)
		then
			return F.Name
		end
	end
end
function UsedualFlock()
	equiptool(NameWeapon(Settings["Select Weapon"] or "Melee"))
end
function FarmMastery(V)
	if not V or not V:FindFirstChild("Humanoid") or not V:FindFirstChild("HumanoidRootPart") then
		return
	end
	getgenv().AimPos = V.HumanoidRootPart.CFrame
	if not Settings["Farm Mastery"] then
		UsedualFlock()
		return
	end
	if V.Humanoid.Health / V.Humanoid.MaxHealth > (Settings["Health %"] or 100) / 100 then
		UsedualFlock()
		return
	end
	local C = Settings["Select Method Farm Mastery"]
	local J, F = NameWeapon(C), NameWeapon(C, true)
	if not J or not F then
		return
	end
	if C == "Gun" and (t.Character:FindFirstChild(J)) then
		ShootM1(V)
	end
	equiptool(J)
	if J == "Control-Control" then
		C = workspace._WorldOrigin:FindFirstChild("Globe")
		if not C or t:DistanceFromCharacter(C.Position) > C.AB.CurveSize0 / 1.75 then
			B(J)
			return
		end
	elseif J == "Buddha-Buddha" then
		if not t.Character.HumanoidRootPart:FindFirstChild("Buddha") then
			B(J)
			return
		end
	elseif J == "Diamond-Diamond" then
		if not t.Character:FindFirstChild("DiamondBody")
print('ULTRA 200KB CARREGOU')