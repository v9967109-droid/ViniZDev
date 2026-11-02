-- Tela de carregamento (Nexora Hub): pequena e rápida. O resto do script só roda depois dela terminar.
do
	pcall(function()
		local TS = game:GetService("TweenService")
		local host = (gethui and gethui()) or game:GetService("CoreGui")
		local oldLoad = host:FindFirstChild("NexoraLoading")
		if oldLoad then oldLoad:Destroy() end
		local gui = Instance.new("ScreenGui")
		gui.Name = "NexoraLoading"; gui.ResetOnSpawn = false; gui.IgnoreGuiInset = true; gui.DisplayOrder = 10000
		gui.Parent = host
		local GOLD, GOLD_L, GRAY = Color3.fromRGB(0, 140, 255), Color3.fromRGB(80, 180, 255), Color3.fromRGB(165,165,174)
		local function mk(class, props, parent)
			local o = Instance.new(class)
			for k, v in pairs(props) do o[k] = v end
			o.Parent = parent
			return o
		end
		local function sfx(id, vol, speed) return end -- SFX REMOVIDO DIRETO
		local card = mk("CanvasGroup", {AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.5), Size=UDim2.fromOffset(230,128), BackgroundColor3=Color3.fromRGB(8,8,11), BorderSizePixel=0, GroupTransparency=1}, gui)
		mk("UICorner", {CornerRadius = UDim.new(0, 24)}, card)
		mk("UIStroke", {Color=GOLD, Thickness=1, Transparency=0.55}, card)
		local sc = mk("UIScale", {Scale=0.9}, card)
		local logo = mk("Frame", {AnchorPoint=Vector2.new(.5,0), Position=UDim2.new(.5,0,0,12), Size=UDim2.fromOffset(46,46), BackgroundColor3=Color3.fromRGB(8,8,10), BorderSizePixel=0}, card)
		mk("UICorner", {CornerRadius=UDim.new(1,0)}, logo)
		mk("UIStroke", {Color=GOLD, Thickness=2}, logo)
		mk("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(0,0,0,2), Size=UDim2.new(1,0,0,13), Text="♛", TextColor3=Color3.fromRGB(80, 180, 255), Font=Enum.Font.Fantasy, TextSize=12}, logo)
		local n = mk("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(0,0,0,10), Size=UDim2.new(1,0,1,-12), Text="N", TextColor3=Color3.fromRGB(0, 140, 255), Font=Enum.Font.Arcade, TextSize=26}, logo)
		mk("UIGradient", {Rotation=90, Color=ColorSequence.new(Color3.fromRGB(80, 180, 255), Color3.fromRGB(0, 140, 255))}, n)
		mk("TextLabel", {AnchorPoint=Vector2.new(.5,0), Position=UDim2.new(.5,0,0,62), Size=UDim2.fromOffset(220,20), BackgroundTransparency=1, Text="NEXORA HUB", TextColor3=Color3.fromRGB(0, 140, 255), Font=Enum.Font.Arcade, TextSize=16}, card)
		mk("TextLabel", {AnchorPoint=Vector2.new(.5,0), Position=UDim2.new(.5,0,0,80), Size=UDim2.fromOffset(220,14), BackgroundTransparency=1, Text="BLOX FRUITS • ViniZDev", TextColor3=Color3.fromRGB(165,165,174), Font=Enum.Font.Code, TextSize=11}, card)
		local track = mk("Frame", {AnchorPoint=Vector2.new(.5,0), Position=UDim2.new(.5,0,0,92), Size=UDim2.fromOffset(150,3), BackgroundColor3=Color3.fromRGB(30,28,24), BorderSizePixel=0}, card)
		mk("UICorner", {CornerRadius=UDim.new(1,0)}, track)
		local fill = mk("Frame", {Size=UDim2.new(0,0,1,0), BackgroundColor3=GOLD, BorderSizePixel=0}, track)
		mk("UICorner", {CornerRadius=UDim.new(1,0)}, fill)
		mk("UIGradient", {Color=ColorSequence.new(Color3.fromRGB(0, 140, 255), Color3.fromRGB(80, 180, 255))}, fill)
		local status = mk("TextLabel", {AnchorPoint=Vector2.new(.5,0), Position=UDim2.new(.5,0,0,102), Size=UDim2.fromOffset(220,14), BackgroundTransparency=1, Text="Carregando...", TextColor3=GRAY, Font=Enum.Font.SourceSansBold, TextSize=10}, card)
		-- entrada rápida + som de abertura
		TS:Create(card, TweenInfo.new(.18, Enum.EasingStyle.Quad), {GroupTransparency=0}):Play()
		TS:Create(sc, TweenInfo.new(.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play()
		local PING = "rbxasset://sounds/electronicpingshort.wav"
		sfx(PING, 0.5, 1.0)
		task.delay(.09, function() sfx(PING, 0.45, 1.26) end)
		task.delay(.18, function() sfx(PING, 0.4, 1.5) end)
		-- progresso curto (~1,3s) bloqueando o resto do script até terminar
		local steps = { {0,"Carregando..."}, {0.45,"Preparando interface..."}, {0.8,"Quase pronto..."} }
		local DURATION, startT = 1.3, tick()
		while true do
			local p = math.clamp((tick() - startT) / DURATION, 0, 1)
			fill.Size = UDim2.new(1 - (1 - p) ^ 2, 0, 1, 0)
			for _, st in ipairs(steps) do if p >= st[1] then status.Text = st[2] end end
			if p >= 1 then break end
			task.wait()
		end
		status.Text = "Pronto!"
		sfx(PING, 0.55, 1.5)
		task.delay(.1, function() sfx(PING, 0.5, 2.0) end)
		task.wait(0.12)
		local out = TS:Create(card, TweenInfo.new(.22, Enum.EasingStyle.Quad), {GroupTransparency=1})
		out:Play()
		TS:Create(sc, TweenInfo.new(.22, Enum.EasingStyle.Quad), {Scale=0.94}):Play()
		task.delay(.3, function() gui:Destroy() end)
	end)
	-- compatibilidade: o fim do script ainda chama isto, mas a tela já terminou.
	getgenv().NexoraLoadingFinish = function() end
end

-- ===================== NEXORA ANTI SHAKE SYSTEM (NO TREME TELA) =====================
-- Trava o tremor de tela de Skull Guitar, Dragonstorm, Sanguine, Godhuman, etc
do
    task.spawn(function()
        local Players = game:GetService("Players")
        local RunService = game:GetService("RunService")
        local LocalPlayer = Players.LocalPlayer
        
        -- 1. Desativa o CameraShaker do Blox Fruits
        pcall(function()
            local CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
            -- Hook no Shake pra nao tremer
            local oldShake = CameraShaker.Shake
            local oldShakeOnce = CameraShaker.ShakeOnce
            local oldShakeSustain = CameraShaker.ShakeSustain
            
            CameraShaker.Shake = function(self, ...) return end
            CameraShaker.ShakeOnce = function(self, ...) return end
            CameraShaker.ShakeSustain = function(self, ...) return end
            
            -- Tenta no Main tambem
            local Main = require(game:GetService("ReplicatedStorage").Util.CameraShaker.Main)
            if Main then
                Main.Shake = function() return end
                Main.ShakeOnce = function() return end
            end
        end)
        
        -- 2. Trava Humanoid CameraOffset (usado por algumas skills pra tremer)
        pcall(function()
            RunService:BindToRenderStep("NexoraNoShake", Enum.RenderPriority.Camera.Value + 10, function()
                local char = LocalPlayer.Character
                if char then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    if hum then
                        if hum.CameraOffset ~= Vector3.new(0,0,0) then
                            hum.CameraOffset = Vector3.new(0,0,0)
                        end
                    end
                end
                -- Trava o CurrentCamera CFrame jitter
                local cam = workspace.CurrentCamera
                if cam then
                    -- Remove o tremor mantendo a posicao
                    -- Nao mexe no CFrame, so impede shake
                end
            end)
        end)
        
        -- 3. Hook no Combat Framework que chama Shake
        pcall(function()
            for i,v in pairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "CameraShaker") then
                    v.CameraShaker = {
                        Shake = function() return end,
                        ShakeOnce = function() return end,
                        ShakeSustain = function() return end,
                        Start = function() return end,
                    }
                end
                if type(v) == "function" and debug.getinfo(v).name == "Shake" then
                    -- Tenta hookar funcoes Shake soltas
                end
            end
        end)
        
        -- 4. Remove Screen Shake de habilidades especificas (Skull Guitar, etc)
        pcall(function()
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            -- Bloqueia remotes que causam shake visual
            local oldNamecall
            oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
                local method = getnamecallmethod()
                local args = {...}
                -- Bloqueia Shake remote se existir
                if tostring(self):lower():find("shake") and (method == "FireServer" or method == "Fire") then
                    return nil
                end
                return oldNamecall(self, ...)
            end)
        end)
        
        print("[Nexora Anti-Shake] Sistema anti-treme ativado! Skull Guitar, Godhuman, etc nao vai tremer mais.")
    end)
end
-- ===================== FIM ANTI SHAKE =====================


-- Registro de erros (diagnóstico): guarda erros que o pcall engole e erros do console,
-- para descobrir por que uma toggle não faz nada. Botão "Copy Error Log" em Settings.
do
	local env = getgenv()
	if not env.__NexoraPcallHooked then
		env.__NexoraPcallHooked = true
		env.NexoraErrors = {}
		local seen, count = {}, 0
		local rawPcall = pcall
		local function log(prefix, err)
			err = tostring(err)
			if seen[err] or count >= 80 then return end
			seen[err] = true
			count = count + 1
			table.insert(env.NexoraErrors, os.date("%H:%M:%S") .. " " .. prefix .. err)
			rawPcall(function() if writefile then writefile("NexoraHub_errors.txt", table.concat(env.NexoraErrors, "\n")) end end)
		end
		local function pass(ok, ...)
			if not ok then log("", (...)) end
			return ok, ...
		end
		pcall = function(fn, ...) return pass(rawPcall(fn, ...)) end
		rawPcall(function()
			game:GetService("LogService").MessageOut:Connect(function(msg, kind)
				if kind == Enum.MessageType.MessageError and string.find(msg, ":%d+:") then log("[console] ", msg) end
			end)
		end)
		env.NexoraDumpErrors = function()
			local txt = table.concat(env.NexoraErrors, "\n")
			rawPcall(function() if setclipboard then setclipboard(txt) end end)
			return txt
		end
	end
end

AutoFarmLevel = true

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
	local K = game:GetService("HttpService")
	local R = "https://cfg.banana-hub.xyz"
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
	local K = game:GetService("HttpService")
	local R = "https://cfg.banana-hub.xyz"
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

function ForceResetSchema(l, Q)
	local K = game:GetService("HttpService")
	local R = "https://cfg.banana-hub.xyz"
	pcall(function()
		request({
			Url = string.format("%s/schema/delete?authId=%s&userId=%s", R, K:UrlEncode(l), K:UrlEncode(Q)),
			Method = "DELETE",
		})
	end)
	wait(0.5)
	return UploadSchemaToWeb(l, Q)
end


if getgenv().__BF_LOADED then
	return getgenv().__BF_RESULT
end

Settings = {}
HttpService = game:GetService("HttpService")
FolderName = "Nexora Hub"
SaveFileNameGame = "-BloxFruitBNNC.json"
SaveFileName = game.Players.LocalPlayer.Name .. SaveFileNameGame
function SaveSettings(b, t, A)
	if A ~= nil then
		Settings[b] = Settings[b] or {}
		Settings[b][t] = A
	elseif b ~= nil then
		Settings[b] = t
		if t == false then
			pcall(function()
				-- QUANDO DESATIVAR QUALQUER TOGGLE, VOLTA AO NORMAL PRA NÃO FICAR PRESO NO AR
				ResetAirState()
			end)
			pcall(function()
				if TweenManager and TweenManager.CancelCurrent then
					TweenManager.CancelCurrent()
				end
				getgenv().noclip = false
				local character = game.Players.LocalPlayer.Character
				local root = character and character:FindFirstChild("HumanoidRootPart")
				local humanoid = character and character:FindFirstChildOfClass("Humanoid")
				if root then
					root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
					root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
					local float = root:FindFirstChild("FloatForce")
					if float then float:Destroy() end
				end
				if humanoid then
					humanoid.PlatformStand = false
					humanoid.AutoRotate = true
					humanoid.Jump = false
				end
			end)
		end
	end
	if not isfolder(FolderName) then
		makefolder(FolderName)
	end
	writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings))
end
if getgenv().Config then
	Settings = getgenv().Config
	SaveSettings()
end
function ReadSetting()
	local b, t = pcall(function()
		if not isfolder(FolderName) then
			makefolder(FolderName)
		end
		return HttpService:JSONDecode(readfile(FolderName .. "/" .. SaveFileName))
	end)
	if b then
		return t
	else
		SaveSettings()
		return ReadSetting()
	end
end
Settings = ReadSetting()
getgenv().Settings = Settings
function PrepareMultiSelectList(b, t, A)
	local a = {}
	for s in pairs(b) do
		local b = t and t[s]
		if b == nil then
			a[s] = A and true or false
		else
			a[s] = b
		end
	end
	return a
end
function EnsureAllTrueDefaults(b, t)
	if type(Settings[b]) ~= "table" then
		Settings[b] = {}
	end
	local A = false
	for a, a in ipairs(t) do
		if Settings[b][a] == nil then
			Settings[b][a] = true
			A = true
		end
	end
	if A then
		for t, A in pairs(Settings[b]) do
			SaveSettings(b, t, A)
		end
	end
end
repeat
	wait()
until game:FindFirstChild("CoreGui")
repeat
	wait()
until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen")
repeat
	wait()
until game:IsLoaded() and (game.Players.LocalPlayer:FindFirstChild("DataLoaded"))
function FireButton(b)
	b.Selectable = true
	game:GetService("GuiService").SelectedObject = b
	game:GetService("VirtualInputManager"):SendKeyEvent(true, "Return", false, b)
	game:GetService("VirtualInputManager"):SendKeyEvent(false, "Return", false, b)
	b.Activated:Connect(function()
		game:GetService("GuiService").SelectedObject = nil
	end)
end
repeat
	wait()
until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
	or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"))
local b = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
	or (game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main"))
repeat
	wait()
until b:FindFirstChild("ChooseTeam")
repeat
	task.wait()
	pcall(function()
		if Settings["Select Team"] == "Pirate" then
			FireButton(
				game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"].ChooseTeam.Container.Pirates.Frame.TextButton
			)
			wait(1)
		else
			FireButton(
				game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"].ChooseTeam.Container.Marines.Frame.TextButton
			)
			wait(1)
		end
	end)
until game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
		and (game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"]:FindFirstChild("ChooseTeam"))
		and not game:GetService("Players").LocalPlayer.PlayerGui["Main (minimal)"]:WaitForChild("ChooseTeam").Visible
	or game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main")
		and (game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam"))
		and not game:GetService("Players").LocalPlayer.PlayerGui.Main:WaitForChild("ChooseTeam").Visible
game:GetService("GuiService").SelectedObject = nil
repeat
	wait()
until game:IsLoaded() and game.Players.LocalPlayer
repeat
	wait()
until game:FindFirstChild("CoreGui")
getgenv().ExploitReq = syn and syn.request
	or identifyexecutor() == "Fluxus" and request
	or http_request
	or http.request
	or requests
if getgenv().LoadScript then
	return
end
getgenv().CheckPlaceId = game.PlaceId == 100117331123089 and 100117331123089 or 7449423635
getgenv().CheckPlaceId2 = game.PlaceId == 4442272183 and 4442272183 or 79091703265657
getgenv().CheckPlaceId3 = game.PlaceId == 2753915549 and 2753915549 or 85211729168715

-- PASS24: source-compatible world flags required by the recovered CheckQuest.
OldWorld = game.PlaceId == getgenv().CheckPlaceId3
NewWorld = game.PlaceId == getgenv().CheckPlaceId2
ThreeWorld = game.PlaceId == getgenv().CheckPlaceId


-- PASS25: exact source-correlated recovery
function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton1(Vector2.new(-1,1))
end

-- PASS25: exact source-correlated recovery
function EquipWeapon(ToolSe)
    if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
        local tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
        wait(.4)
        game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
    end
end

-- PASS25: exact source-correlated recovery
function AutoFarm()
    GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
    GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
    MyLevelNow = game.Players.LocalPlayer.Data.Level.Value
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
    if OldWorld and MyLevelNow >= 700 and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
        if HaveSaber then
            if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0 then
                if Workspace.Map.Ice.Door.Transparency == 1 then
                    if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 250 then
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                            local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                            wait(.4)
                            game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                        end
                        DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                            if DoorNewWorldTween then
                                DoorNewWorldTween:Stop()
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                        end
                    elseif game.Workspace.Enemies:FindFirstChild("Ice Admiral [Lv. 700] [Boss]") and game.Workspace.Map.Ice.Door.CanCollide == false and game.Workspace.Map.Ice.Door.Transparency == 1 and (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                        if DoorNewWorldTween then
                            DoorNewWorldTween:Stop()
                        end
                        CheckBoss = true
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if CheckBoss and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Ice Admiral [Lv. 700] [Boss]" then
                                repeat wait()
                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                        Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Farmtween then
                                            Farmtween:Stop()
                                        end
                                        EquipWeapon(SelectToolWeapon)
                                        Usefastattack = true
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                        Click()
                                    end 
                                until not CheckBoss or not v.Parent or v.Humanoid.Health <= 0 or AutoFarmLevel== false
                                Usefastattack = false
                                repeat wait()
                                    a = 2
                                    local args = {
                                        [1] = "TravelDressrosa" -- OLD WORLD to NEW WORLD
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                until a == 1
                            end
                        end
                        CheckBoss = false
                    end 
                else
                    if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") or game.Players.LocalPlayer.Character:FindFirstChild("Key") then
                        DoorNewWorldTween = toTarget(CFrame.new(1347.7124, 37.3751602, -1325.6488))
                        if (CFrame.new(1347.7124, 37.3751602, -1325.6488).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                            if DoorNewWorldTween then
                                DoorNewWorldTween:Stop()
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1347.7124, 37.3751602, -1325.6488)
                            local args = {
                                [1] = "DressrosaQuestProgress",
                                [2] = "Detective"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            wait(0.5)
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                                wait(.4)
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                            end
                        end
                    else
                        AutoNewWorldTween = toTarget(CFrame.new(4849.29883, 5.65138149, 719.611877))
                        if (CFrame.new(4849.29883, 5.65138149, 719.611877).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
                            if AutoNewWorldTween then
                                AutoNewWorldTween:Stop()
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(4849.29883, 5.65138149, 719.611877)
                            local args = {
                                [1] = "DressrosaQuestProgress",
                                [2] = "Detective"
                            }
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            wait(0.5)
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Key") then
                                local tool = game.Players.LocalPlayer.Backpack:FindFirstChild("Key")
                                wait(.4)
                                game.Players.LocalPlayer.Character.Humanoid:EquipTool(tool)
                            end
                        end
                    end
                end
            else
                local args = {
                    [1] = "TravelDressrosa" -- OLD WORLD to NEW WORLD
                }
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            end
        else
            if game.Workspace.Map.Jungle.Final.Part.CanCollide == false then
                if game.Workspace.Enemies:FindFirstChild("Saber Expert [Lv. 200] [Boss]") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if AutoFarmLevel and v.Name == "Saber Expert [Lv. 200] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            repeat wait()
                                if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                    Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                    if Farmtween then
                                        Farmtween:Stop()
                                    end
                                    EquipWeapon(SelectToolWeapon)
                                    Usefastattack = true
                                    if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                        local args = {
                                            [1] = "Buso"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
                                    Click()
                                end
                            until not AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0
                            local BuyAll = {
                                "Soru",
                                "Buso",
                                "Geppo"
                            }
                            for i,v in pairs(BuyAll) do
                                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BuyHaki", v)
                            end
                            Usefastattack = false
                        end
                    end
                else
                    Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055))
                    if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                        if Questtween then
                            Questtween:Stop()
                        end
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
                    end
                end
            elseif game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") and game.Players.localPlayer.Data.Level.Value >= 200 then
                EquipWeapon("Relic")
                wait(0.5)
                Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055))
                if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                    if Questtween then
                        Questtween:Stop()
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055, 0.885240912, 3.52892613e-08, 0.465132833, -6.60881128e-09, 1, -6.32913171e-08, -0.465132833, 5.29540891e-08, 0.885240912)
                end
            else
                if Workspace.Map.Jungle.QuestPlates.Door.CanCollide == false then
                    if game.Workspace.Map.Desert.Burn.Part.CanCollide == false then
                        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") == 0 then
                            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 0 then
                                if game.Workspace.Enemies:FindFirstChild("Mob Leader [Lv. 120] [Boss]") then
                                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                                        if AutoFarmLevel and v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 and v.Name == "Mob Leader [Lv. 120] [Boss]" then
                                            repeat
                                                pcall(function() wait() 
                                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                                        Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                                    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                                        if Farmtween then
                                                            Farmtween:Stop()
                                                        end
                                                        EquipWeapon(SelectToolWeapon)
                                                        Usefastattack = true
                                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                                            local args = {
                                                                [1] = "Buso"
                                                            }
                                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                                        end
                                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
                                                        Click()
                                                    end
                                                end)
                                            until not AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0
                                            Usefastattack = false
                                        end
                                    end
                                else
                                    Questtween = toTarget(CFrame.new(-2848.59399, 7.4272871, 5342.44043))
                                    if (CFrame.new(-2848.59399, 7.4272871, 5342.44043).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Questtween then
                                            Questtween:Stop()
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2848.59399, 7.4272871, 5342.44043, -0.928248107, -8.7248246e-08, 0.371961564, -7.61816636e-08, 1, 4.44474857e-08, -0.371961564, 1.29216433e-08, -0.928248107)
                                    end
                                end
                            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","RichSon") == 1 then
                                if game.Players.LocalPlayer.Backpack:FindFirstChild("Relic") or game.Players.LocalPlayer.Character:FindFirstChild("Relic") then
                                    EquipWeapon("Relic")
                                    wait(0.5)
                                    Questtween = toTarget(CFrame.new(-1405.41956, 29.8519993, 5.62435055))
                                    if (CFrame.new(-1405.41956, 29.8519993, 5.62435055).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Questtween then
                                            Questtween:Stop()
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1405.41956, 29.8519993, 5.62435055)
                                    end
                                else
                                    Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624))
                                    if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Questtween then
                                            Questtween:Stop()
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624, 0.00685182028, -1.53155766e-09, -0.999976516, 9.15205245e-09, 1, -1.46888401e-09, 0.999976516, -9.14177267e-09, 0.00685182028)
                                        wait(.5)
                                        local args = {
                                            [1] = "ProQuestProgress",
                                            [2] = "RichSon"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                end
                            else
                                Questtween = toTarget(CFrame.new(-910.979736, 13.7520342, 4078.14624))
                                if (CFrame.new(-910.979736, 13.7520342, 4078.14624).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                    if Questtween then
                                        Questtween:Stop()
                                    end
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-910.979736, 13.7520342, 4078.14624)
                                    local args = {
                                        [1] = "ProQuestProgress",
                                        [2] = "RichSon"
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                            end
                        else
                            if game.Players.LocalPlayer.Backpack:FindFirstChild("Cup") or game.Players.LocalPlayer.Character:FindFirstChild("Cup") then
                                EquipWeapon("Cup")
                                if game.Players.LocalPlayer.Character.Cup.Handle:FindFirstChild("TouchInterest") then
                                    Questtween = toTarget(CFrame.new(1397.229, 37.3480148, -1320.85217))
                                    if (CFrame.new(1397.229, 37.3480148, -1320.85217).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Questtween then
                                            Questtween:Stop()
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1397.229, 37.3480148, -1320.85217, -0.11285457, 2.01368788e-08, 0.993611455, 1.91641178e-07, 1, 1.50028845e-09, -0.993611455, 1.90586206e-07, -0.11285457)
                                    end
                                else
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1458.54285, 88.2521744, -1390.34912, -0.00596274994, 1.13679788e-09, -0.999982238, 7.28181793e-10, 1, 1.132476e-09, 0.999982238, -7.21416205e-10, -0.00596274994)
                                    wait(0.5)
                                    if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress","SickMan") ~= 0 then
                                        local args = {
                                            [1] = "ProQuestProgress",
                                            [2] = "SickMan"
                                        }
                                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                    end
                                end
                            else
                                Questtween = toTarget(game.Workspace.Map.Desert.Cup.CFrame)
                                if (game.Workspace.Map.Desert.Cup.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                    if Questtween then
                                        Questtween:Stop()
                                    end
                                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = game.Workspace.Map.Desert.Cup.CFrame
                                end
                            end
                        end
                    else
                        if game.Players.LocalPlayer.Backpack:FindFirstChild("Torch") or game.Players.LocalPlayer.Character:FindFirstChild("Torch") then
                            EquipWeapon("Torch")
                            Questtween = toTarget(CFrame.new(1114.87708, 4.9214654, 4349.8501))
                            if (CFrame.new(1114.87708, 4.9214654, 4349.8501).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                if Questtween then
                                    Questtween:Stop()
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1114.87708, 4.9214654, 4349.8501, -0.612586915, -9.68697833e-08, 0.790403247, -1.2634203e-07, 1, 2.4638446e-08, -0.790403247, -8.47679615e-08, -0.612586915)
                            end
                        else
                            Questtween = toTarget(CFrame.new(-1610.00757, 11.5049858, 164.001587))
                            if (CFrame.new(-1610.00757, 11.5049858, 164.001587).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                if Questtween then
                                    Questtween:Stop()
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1610.00757, 11.5049858, 164.001587, 0.984807551, -0.167722285, -0.0449818149, 0.17364943, 0.951244235, 0.254912198, 3.42372805e-05, -0.258850515, 0.965917408)
                            end
                        end
                    end
                else
                    for i,v in pairs(Workspace.Map.Jungle.QuestPlates:GetChildren()) do
                        if v:IsA("Model") then wait()
                            if v.Button.BrickColor ~= BrickColor.new("Camo") then
                                repeat wait()
                                    Questtween = toTarget(v.Button.CFrame)
                                    if (v.Button.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
                                        if Questtween then Questtween:Stop() end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.Button.CFrame
                                    end
                                until not AutoFarmLevel or v.Button.BrickColor == BrickColor.new("Camo")
                            end
                        end
                    end    
                end
            end
        end
    elseif NewWorld and MyLevelNow >= 850 and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 or game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2) then
        if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 0 then
            if string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == true then 
                if game.Workspace.Enemies:FindFirstChild("Swan Pirate [Lv. 775]") then
                    for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                        if v.Name == "Swan Pirate [Lv. 775]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            pcall(function()
                                repeat wait()
                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                        Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Farmtween then Farmtween:Stop() end
                                        EquipWeapon(SelectToolWeapon)
                                        Usefastattack = true
                                        PosMon = v.HumanoidRootPart.CFrame
                                        StartMagnetAutoFarmLevel = true
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                        Click()
                                    end 
                                until not v.Parent or v.Humanoid.Health <= 0 or AutoFarmLevel == false or game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible == false
                                Usefastattack = false
                                StartMagnetAutoFarmLevel = false
                            end)
                        end
                    end
                else
                    StartMagnetAutoFarmLevel = false
                    Questtween = toTarget(CFrame.new(1057.92761, 137.614319, 1242.08069))
                    if (CFrame.new(1057.92761, 137.614319, 1242.08069).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                        if Questtween then
                            Questtween:Stop()
                        end
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(1057.92761, 137.614319, 1242.08069)
                    end
                end
            else
                Bartilotween = toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966))
                if ( CFrame.new(-456.28952, 73.0200958, 299.895966).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                    if Bartilotween then Bartilotween:Stop() end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame =  CFrame.new(-456.28952, 73.0200958, 299.895966)
                    local args = {
                        [1] = "StartQuest",
                        [2] = "BartiloQuest",
                        [3] = 1
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                end
            end 
        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 1 then
            StartMagnetAutoFarmLevel = false
            if game.Workspace.Enemies:FindFirstChild("Jeremy [Lv. 850] [Boss]") then
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if v.Name == "Jeremy [Lv. 850] [Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        repeat wait()
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                            elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                if Farmtween then Farmtween:Stop() end
                                EquipWeapon(SelectToolWeapon)
                                Usefastattack = true
                                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                    local args = {
                                        [1] = "Buso"
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                Click()
                            end 
                        until not v.Parent or v.Humanoid.Health <= 0 or AutoFarmLevel == false
                        Usefastattack = false
                    end
                end
            else
                Bartilotween = toTarget(CFrame.new(2099.88159, 448.931, 648.997375))
                if (CFrame.new(2099.88159, 448.931, 648.997375).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                    if Bartilotween then Bartilotween:Stop() end
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2099.88159, 448.931, 648.997375)
                end
            end
        elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress","Bartilo") == 2 then
            if (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                Bartilotween = toTarget(CFrame.new(-1836, 11, 1714))
            elseif (CFrame.new(-1836, 11, 1714).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                if Bartilotween then Bartilotween:Stop() end
                game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1836, 11, 1714)
                wait(.5)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1850.49329, 13.1789551, 1750.89685)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.87305, 19.3777466, 1712.01807)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1803.94324, 16.5789185, 1750.89685)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1858.55835, 16.8604317, 1724.79541)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1869.54224, 15.987854, 1681.00659)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1800.0979, 16.4978027, 1684.52368)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1819.26343, 14.795166, 1717.90625)
                wait(1)
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-1813.51843, 14.8604736, 1724.79541)
            end
        end
    elseif NewWorld and MyLevelNow >= 1500 then
        if AutoRengoku and game:GetService("Workspace").Map.IceCastle:FindFirstChild("RengokuChest") and not HaveRengoku then
            if game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or  game.Players.LocalPlayer.Character:FindFirstChild("Hidden Key") then
                EquipWeapon("Hidden Key")
                if (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                    Farmtween = toTarget(CFrame.new(6571.81885, 296.689758, -6966.76514))
                elseif (CFrame.new(6571.81885, 296.689758, -6966.76514).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                    if Farmtween then
                        Farmtween:Stop()
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6571.81885, 296.689758, -6966.76514, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
                end 
            elseif game.Workspace.Enemies:FindFirstChild("Snow Lurker [Lv. 1375]") then
                for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                    if AutoFarmLevel and v.Name == "Snow Lurker [Lv. 1375]" and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                        repeat wait()
                            if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                StartMagnetAutoFarmLevel = false
                            elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                if Farmtween then
                                    Farmtween:Stop()
                                end
                                PosMon = v.HumanoidRootPart.CFrame
                                EquipWeapon(SelectToolWeapon)
                                Usefastattack = true
                                StartMagnetAutoFarmLevel = true
                                if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                    local args = {
                                        [1] = "Buso"
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                end
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
                                Click()
                            end 
                        until game.Players.LocalPlayer.Backpack:FindFirstChild("Hidden Key") or AutoFarmLevel == false or not v.Parent or v.Humanoid.Health <= 0
                        StartMagnetAutoFarmLevel = false
                        Usefastattack = false
                        if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                            Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518))
                        elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                            if Farmtween then
                                Farmtween:Stop()
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5518.00684, 60.5559731, -6828.80518, 0.825126112, 8.412257e-10, 0.564948559, -2.42370835e-08, 1, 3.39100339e-08, -0.564948559, -4.16727595e-08, 0.825126112)
                        end 
                    end
                end
            else
                StartMagnetAutoFarmLevel = false
                if (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                    Farmtween = toTarget(CFrame.new(5518.00684, 60.5559731, -6828.80518))
                elseif (CFrame.new(5518.00684, 60.5559731, -6828.80518).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                    if Farmtween then
                        Farmtween:Stop()
                    end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(5518.00684, 60.5559731, -6828.80518, -0.650781393, -3.64292951e-08, 0.759265184, -4.07668654e-09, 1, 4.44854642e-08, -0.759265184, 2.58550248e-08, -0.650781393)
                end 
            end
        else
            local args = {
                [1] = "TravelZou" -- OLD WORLD to NEW WORLD
            }
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                for i,v in pairs(game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("getInventoryFruits")) do
                    if v.Price >= 1000000 then 
                        HaveDevilFruitSea3 = true
                    end
                end
                if HaveDevilFruitSea3 and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then
                    TabelDevilFruitStore = {}
                    TabelDevilFruitOpen = {}

                    for i,v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventoryFruits")) do
                        for i1,v1 in pairs(v) do
                            if i1 == "Name" then 
                                table.insert(TabelDevilFruitStore,v1)
                            end
                        end
                    end

                    for i,v in next,game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("GetFruits") do
                        if v.Price >= 1000000 then  
                            table.insert(TabelDevilFruitOpen,v.Name)
                        end
                    end

                    for i,DevilFruitOpenDoor in pairs(TabelDevilFruitOpen) do
                        for i1,DevilFruitStore in pairs(TabelDevilFruitStore) do
                            if DevilFruitOpenDoor == DevilFruitStore and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetUnlockables").FlamingoAccess == nil then    
                                if not game.Players.LocalPlayer.Backpack:FindFirstChild(DevilFruitStore) then   
                                    local string_1 = "LoadFruit";
                                    local string_2 = DevilFruitStore;
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                    UseThireWorld = true wait(.1)
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "1";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "2";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "3";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                else
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "1";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "2";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                    local string_1 = "TalkTrevor";
                                    local string_2 = "3";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    Target:InvokeServer(string_1, string_2);
                                end
                            end
                        end
                    end
                    local string_1 = "TalkTrevor";
                    local string_2 = "1";
                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                    Target:InvokeServer(string_1, string_2);
                    local string_1 = "TalkTrevor";
                    local string_2 = "2";
                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                    Target:InvokeServer(string_1, string_2);
                    local string_1 = "TalkTrevor";
                    local string_2 = "3";
                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                    Target:InvokeServer(string_1, string_2);
                else
                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do
                        if v:IsA("Tool") and string.find(v.Name,"Fruit") then 
                            firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Handle,0)    
                            EquipWeapon(SelectToolWeapon)
                            for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                                if string.find(v.Name,"Fruit") then
                                    local FruitName = RemoveSpaces(v.Name)
                                    if v.Name == "Bird: Falcon Fruit" then
                                        NameFruit = "Bird-Bird: Falcon"
                                    elseif v.Name == "Bird: Phoenix Fruit" then
                                        NameFruit = "Bird-Bird: Phoenix"
                                    elseif v.Name == "Human: Buddha Fruit" then
                                        NameFruit = "Human-Human: Buddha"
                                    else
                                        NameFruit = FruitName.."-"..FruitName
                                    end
                
                                    local string_1 = "getInventoryFruits";
                                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                    for i1,v1 in pairs(Target:InvokeServer(string_1)) do
                                        if v1.Name == NameFruit then
                                            HaveFruitInStore = true
                                        end
                                    end
                                    if not HaveFruitInStore then
                                        local string_1 = "StoreFruit";
                                        local string_2 = NameFruit;
                                        local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                                        Target:InvokeServer(string_1, string_2);
                                    end
                                    HaveFruitInStore = false
                                end
                            end
                        end
                    end
                    wait(.5)
                    library:Notification("Server Hop")
                    ServerHop:Teleport()
                end
            else
                if game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 0 then
                    if game.Workspace.Enemies:FindFirstChild("rip_indra [Lv. 1500] [Boss]") then 	
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "rip_indra [Lv. 1500] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat wait()
                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                        Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Farmtween then
                                            Farmtween:Stop()
                                        end
                                        EquipWeapon(SelectToolWeapon)
                                        Usefastattack = true
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                        Click()
                                    end 
                                until not AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0 
                                wait(.5)
                                asmrqq = 2
                                repeat wait()
                                    local args = {
                                        [1] = "TravelZou" -- OLD WORLD to NEW WORLD
                                    }
                                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                until asmrqq == 1
                                Usefastattack = false
                            end
                        end
                    else -- SlashHit : rbxassetid://2453605589
                        local string_1 = "ZQuestProgress";
                        local string_2 = "Check";
                        local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                        Target:InvokeServer(string_1, string_2);
                        wait()
                        local string_1 = "ZQuestProgress";
                        local string_2 = "Begin";
                        local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                        Target:InvokeServer(string_1, string_2);
                    end
                elseif game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("ZQuestProgress", "Check") == 1 then
                    local args = {
                        [1] = "TravelZou" -- OLD WORLD to NEW WORLD
                    }
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                else
                    if game.Workspace.Enemies:FindFirstChild("Don Swan [Lv. 1000] [Boss]") then 	
                        for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                            if v.Name == "Don Swan [Lv. 1000] [Boss]" and v:FindFirstChild("Humanoid")and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                                repeat wait()
                                    if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                                        Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                                    elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                                        if Farmtween then
                                            Farmtween:Stop()
                                        end
                                        EquipWeapon(SelectToolWeapon)
                                        Usefastattack = true
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                        Click()
                                    end 
                                until not AutoFarmLevel or not v.Parent or v.Humanoid.Health <= 0 
                                Usefastattack = false
                            end
                        end
                    else -- SlashHit : rbxassetid://2453605589
                        TweenDonSwanthireworld = toTarget(CFrame.new(2288.802, 15.1870775, 863.034607))
                        if (CFrame.new(2288.802, 15.1870775, 863.034607).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                            if TweenDonSwanthireworld then
                                TweenDonSwanthireworld:Stop()
                                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(2288.802, 15.1870775, 863.034607)
                            end
                        end
                    end
                end
            end
        end
    elseif AutoKillCakePrince and game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") or game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
        if game:GetService("Workspace").Enemies:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]") then
            for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
                if AutoFarmLevel and AutoKillCakePrince and v.Name == "Cake Prince [Lv. 2300] [Raid Boss]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                    repeat wait()
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 300 then
                            Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                            Usefastattack = false
                        elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                            if Farmtween then
                                Farmtween:Stop()
                            end
                            PosFarmBone = v.HumanoidRootPart.CFrame
                            EquipWeapon(SelectToolWeapon)
                            Usefastattack = true
                            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                local args = {
                                    [1] = "Buso"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                            Click()
                        end
                    until not AutoFarmLevel or not AutoKillCakePrince or not v.Parent or v.Humanoid.Health <= 0 or game.ReplicatedStorage:FindFirstChild("Cake Prince [Lv. 2300] [Raid Boss]")
                    Usefastattack = false
                end
            end
        else
            Usefastattack = false
            Questtween = toTarget(CFrame.new(-2151.82153, 149.315704, -12404.9053))
            if (CFrame.new(-2151.82153, 149.315704, -12404.9053).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
                if Questtween then Questtween:Stop() end
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-2151.82153, 149.315704, -12404.9053)
            end
        end
    else
        if game.ReplicatedStorage:FindFirstChild("Core") and game.ReplicatedStorage:FindFirstChild("Core"):FindFirstChild("Humanoid") then
            GOtween = toTarget(CFrame.new(448.46756, 199.356781, -441.389252))
            if NewWorld and game.ReplicatedStorage:FindFirstChild("Core") and (CFrame.new(448.46756, 199.356781, -441.389252).Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
                if Questtween then Questtween:Stop() end
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
            elseif (CFrame.new(448.46756, 199.356781, -441.389252).Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                if Farmtween then GOtween:Stop()end
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(448.46756, 199.356781, -441.389252)
            end
        elseif game.Workspace.Enemies:FindFirstChild("Core") then
            for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                if AutoFarmLevel and v.Name == "Core" and v.Humanoid.Health > 0 then
                    repeat wait(.1)
                        if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 350 then
                            Farmtween = toTarget(v.HumanoidRootPart.CFrame)
                        elseif (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                            if Farmtween then Farmtween:Stop() end
                            EquipWeapon(SelectToolWeapon)
                            Usefastattack = true
                            if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                local args = {
                                    [1] = "Buso"
                                }
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                            end
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 10, 10)
                            Click()
                        end
                    until not AutoFarmLevel or v.Humanoid.Health <= 0 or Factory == false
                    Usefastattack = false
                end
            end
        else
            if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
            if GetQuest.Visible == false then
                Usefastattack = false
                StartMagnetAutoFarmLevel = false
                Questtween = toTarget(CFrameQuest) wait(.1)
                if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
                if OldWorld and (Ms == "Fishman Commando [Lv. 400]" or Ms == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
                    if Questtween then Questtween:Stop() end wait(.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                elseif OldWorld and not (Ms == "Fishman Commando [Lv. 400]" or Ms == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
                    if Questtween then Questtween:Stop() end wait(.5)
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.8515625, 6.6796875, -1926.7841796875))
                elseif NewWorld and string.find(Ms, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
                    if Questtween then Questtween:Stop() end
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                elseif NewWorld and not string.find(Ms, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
                    if Questtween then Questtween:Stop() end
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
                elseif (CFrameQuest.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                    if Questtween then Questtween:Stop() end
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameQuest
                    wait(1)
                    local string_1 = "StartQuest";
                    local string_2 = NameQuest;
                    local number_1 = LevelQuest;
                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                    Target:InvokeServer(string_1, string_2, number_1);
                    local string_1 = "SetSpawnPoint";
                    local Target = game:GetService("ReplicatedStorage").Remotes["CommF_"];
                    Target:InvokeServer(string_1);
                end
            elseif GetQuest.Visible == true then
                if game:GetService("Workspace").Enemies:FindFirstChild(Ms) then
                    for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if AutoFarmLevel and v.Name == Ms and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                            if string.find(GetQuestTitle.Text, NameMon) then
                                repeat wait()
                                    if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
                                    FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0,30,0))
                                    if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                                        if FarmtoTarget then FarmtoTarget:Stop() end
                                        Usefastattack = true
                                        EquipWeapon(SelectToolWeapon)
                                        StartMagnetAutoFarmLevel = true
                                        PosMon = v.HumanoidRootPart.CFrame
                                        if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
                                            local args = {
                                                [1] = "Buso"
                                            }
                                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
                                        end
                                        if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
                                            game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
                                            game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
                                        end
                                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
                                        Click()
                                    end
                                until not game:GetService("Workspace").Enemies:FindFirstChild(Ms) or not AutoFarmLevel or not string.find(GetQuestTitle.Text, NameMon) or v.Humanoid.Health <= 0 or not v.Parent
                                if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
                                Usefastattack = false
                                StartMagnetAutoFarmLevel = false
                            else
                                game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest");
                            end
                        end
                    end
                else
                    StartMagnetAutoFarmLevel = false
                    Usefastattack = false
                    if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
                    Modstween = toTarget(CFrameMon)
                    if OldWorld and (Ms == "Fishman Commando [Lv. 400]" or Ms == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
                        if Modstween then Modstween:Stop() end wait(.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
                    elseif OldWorld and not (Ms == "Fishman Commando [Lv. 400]" or Ms == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
                        if Modstween then Modstween:Stop() end wait(.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.8515625, 6.6796875, -1926.7841796875))
                    elseif NewWorld and string.find(Ms, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
                        if Modstween then Modstween:Stop() end wait(.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
                    elseif NewWorld and not string.find(Ms, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
                        if Modstween then Modstween:Stop() end wait(.5)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
                    elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 350 then
                        if Modstween then Modstween:Stop() end wait(.5)
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
                    end 
                end
            end
        end
    end
end

-- PASS25: exact source-correlated recovery
function GetDistance(position, origin)
    if localPlayerFunctions and localPlayerFunctions.IsAlive
        and not localPlayerFunctions.IsAlive() then
        return math.huge
    end

    if not origin then
        local root = getHRP and getHRP() or nil
        if not root then
            return math.huge
        end
        origin = root.Position
    end

    return (position - origin).Magnitude
end

-- PASS25: exact source-correlated recovery
function PlrData()
    local player = game:GetService("Players").LocalPlayer
    return player and player:FindFirstChild("Data")
end

-- PASS25: exact source-correlated recovery
function Minute()
    local hour = math.floor(game:GetService("Lighting").ClockTime)
    return hour
end

-- PASS24: exact source-correlated CheckQuest recovered from the target-specific corpus.
function CheckQuest()
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if OldWorld then
		if MyLevel == 1 or MyLevel <= 9 then -- Bandit
			Ms = "Bandit [Lv. 5]"
			NameQuest = "BanditQuest1"
			LevelQuest = 1
			NameMon = "Bandit"
			CFrameQuest = CFrame.new(1059.37195, 15.4495068, 1550.4231, 0.939700544, -0, -0.341998369, 0, 1, -0, 0.341998369, 0, 0.939700544)
			CFrameMon = CFrame.new(1353.44885, 3.40935516, 1376.92029, 0.776053488, -6.97791975e-08, 0.630666852, 6.99138596e-08, 1, 2.4612488e-08, -0.630666852, 2.49917598e-08, 0.776053488)
		elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
			Ms = "Monkey [Lv. 14]"
			NameQuest = "JungleQuest"
			LevelQuest = 1
			NameMon = "Monkey"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-1402.74609, 98.5633316, 90.6417007, 0.836947978, 0, 0.547282517, -0, 1, -0, -0.547282517, 0, 0.836947978)
		elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
			Ms = "Gorilla [Lv. 20]"
			NameQuest = "JungleQuest"
			LevelQuest = 2
			NameMon = "Gorilla"
			CFrameQuest = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(-1267.89001, 66.2034225, -531.818115, -0.813996196, -5.25169774e-08, -0.580869019, -5.58769671e-08, 1, -1.21082593e-08, 0.580869019, 2.26011476e-08, -0.813996196)
		elseif MyLevel == 30 or MyLevel <= 39 then -- Pirate
			Ms = "Pirate [Lv. 35]"
			NameQuest = "BuggyQuest1"
			LevelQuest = 1
			NameMon = "Pirate"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(-1311.44727, 4.77785587, 3878.10913, -0.266229719, 2.94305789e-08, -0.963909626, -1.10684184e-07, 1, 6.11032362e-08, 0.963909626, 1.22957047e-07, -0.266229719)
		elseif MyLevel == 40 or MyLevel <= 59 then -- Brute
			Ms = "Brute [Lv. 45]"
			NameQuest = "BuggyQuest1"
			LevelQuest = 2
			NameMon = "Brute"
			CFrameQuest = CFrame.new(-1141.07483, 4.10001802, 3831.5498, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(-1349.54773, 4.77724838, 4440.31836, 0.905865192, -0.000296127051, -0.423566043, -1.13833148e-05, 0.999999762, -0.000723473262, 0.423566163, 0.000660190824, 0.905864954)
		elseif MyLevel == 60 or MyLevel <= 74 then -- Desert Bandit
			Ms = "Desert Bandit [Lv. 60]"
			NameQuest = "DesertQuest"
			LevelQuest = 1
			NameMon = "Desert Bandit"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
			CFrameMon = CFrame.new(1054.46924, 28.8281326, 4487.78516, 0.095742099, 9.99517002e-09, 0.995405734, 3.27853407e-08, 1, -1.31947298e-08, -0.995405734, 3.38979973e-08, 0.095742099)
		elseif MyLevel == 75 or MyLevel <= 89 then -- Desert Officre
			Ms = "Desert Officer [Lv. 70]"
			NameQuest = "DesertQuest"
			LevelQuest = 2
			NameMon = "Desert Officer"
			CFrameQuest = CFrame.new(894.488647, 5.14000702, 4392.43359, 0.819155693, -0, -0.573571265, 0, 1, -0, 0.573571265, 0, 0.819155693)
			CFrameMon = CFrame.new(1539.19324, 1.63675952, 4372.31982, 0.367986321, -7.58386349e-08, -0.929831564, -1.96705994e-08, 1, -8.93464929e-08, 0.929831564, 5.11685769e-08, 0.367986321)
		elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits
			Ms = "Snow Bandit [Lv. 90]"
			NameQuest = "SnowQuest"
			LevelQuest = 1
			NameMon = "Snow Bandits"
			CFrameQuest = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
			CFrameMon = CFrame.new(1412.92346, 55.3503647, -1260.62036, -0.246266365, -0.0169920288, -0.969053388, 0.000432241941, 0.999844253, -0.0176417865, 0.969202161, -0.00476344163, -0.246220857)
		elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman
			Ms = "Snowman [Lv. 100]"
			NameQuest = "SnowQuest"
			LevelQuest = 2
			NameMon = "Snowman"
			CFrameQuest = CFrame.new(1389.74451, 86.6520844, -1298.90796, -0.342042685, 0, 0.939684391, 0, 1, 0, -0.939684391, 0, -0.342042685)
			CFrameMon = CFrame.new(1376.86401, 97.2779999, -1396.93115, -0.986755967, 7.71178321e-08, -0.162211925, 7.71531674e-08, 1, 6.08143536e-09, 0.162211925, -6.51427134e-09, -0.986755967)
		elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer
			Ms = "Chief Petty Officer [Lv. 120]"
			NameQuest = "MarineQuest2"
			LevelQuest = 1
			NameMon = "Chief Petty Officer"
			CFrameQuest = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-4882.8623, 22.6520386, 4255.53516, 0.273695946, -5.40380647e-08, -0.96181643, 4.37720793e-08, 1, -4.37274998e-08, 0.96181643, -3.01326679e-08, 0.273695946)
		elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit
			Ms = "Sky Bandit [Lv. 150]"
			NameQuest = "SkyQuest"
			LevelQuest = 1
			NameMon = "Sky Bandit"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-4959.51367, 365.39267, -2974.56812, 0.964867651, 7.74418396e-08, 0.262737453, -6.95931988e-08, 1, -3.91783708e-08, -0.262737453, 1.95171506e-08, 0.964867651)
		elseif MyLevel == 175 or MyLevel <= 249 then -- Dark Master
			Ms = "Dark Master [Lv. 175]"
			NameQuest = "SkyQuest"
			LevelQuest = 2
			NameMon = "Dark Master"
			CFrameQuest = CFrame.new(-4839.53027, 716.368591, -2619.44165, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-5079.98096, 376.477356, -2194.17139, 0.465965867, -3.69776352e-08, 0.884802461, 3.40249851e-09, 1, 4.00000886e-08, -0.884802461, -1.56281423e-08, 0.465965867)
		elseif MyLevel == 255 or MyLevel <= 274 then -- Toga Warrior
			Ms = "Toga Warrior [Lv. 250]"
			NameQuest = "ColosseumQuest"
			LevelQuest = 1
			NameMon = "Toga Warrior"
			CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
			CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474, 0.984437346, 4.10396339e-08, 0.175734788, -3.62286876e-08, 1, -3.05844168e-08, -0.175734788, 2.3741821e-08, 0.984437346)
		elseif MyLevel == 275 or MyLevel <= 299 then -- Gladiato
			Ms = "Gladiator [Lv. 275]"
			NameQuest = "ColosseumQuest"
			LevelQuest = 2
			NameMon = "Gladiato"
			CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762, 0.576966345, 1.22114863e-09, 0.816767931, -3.58496594e-10, 1, -1.24185606e-09, -0.816767931, 4.2370063e-10, 0.576966345)
			CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309, 0.464524001, 6.21005611e-08, 0.885560572, -4.80449414e-09, 1, -6.76054768e-08, -0.885560572, 2.71497012e-08, 0.464524001)
		elseif MyLevel == 300 or MyLevel <= 329 then -- Military Soldier
			Ms = "Military Soldier [Lv. 300]"
			NameQuest = "MagmaQuest"
			LevelQuest = 1
			NameMon = "Military Soldier"
			CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
			CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266, -0.578253984, -3.29503091e-10, 0.815856814, 9.11209668e-08, 1, 6.498761e-08, -0.815856814, 1.11920997e-07, -0.578253984)
		elseif MyLevel == 330 or MyLevel <= 374 then -- Military Spy
			Ms = "Military Spy [Lv. 325]"
			NameQuest = "MagmaQuest"
			LevelQuest = 2
			NameMon = "Military Spy"
			CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998, 0.588437557, -1.37880001e-08, -0.808542669, -2.10116209e-08, 1, -3.23446478e-08, 0.808542669, 3.60215964e-08, 0.588437557)
			CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293, -0.188358366, -1.84706277e-08, 0.982100308, -1.23782129e-07, 1, -4.93306951e-09, -0.982100308, -1.22495649e-07, -0.188358366)
		elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior
			Ms = "Fishman Warrior [Lv. 375]"
			NameQuest = "FishmanQuest"
			LevelQuest = 1
			NameMon = "Fishman Warrior"
			CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504, 0.893533468, 3.95251609e-09, 0.448996574, -2.34327455e-08, 1, 3.78297464e-08, -0.448996574, -4.43233645e-08, 0.893533468)
			CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.91687, -0.0817126185, 8.90751153e-08, 0.996655822, 2.00889794e-08, 1, -8.77269599e-08, -0.996655822, 1.28533992e-08, -0.0817126185)
		elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando
			Ms = "Fishman Commando [Lv. 400]"
			NameQuest = "FishmanQuest"
			LevelQuest = 2
			NameMon = "Fishman Commando"
			CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504)
			CFrameMon = CFrame.new(60946.6094, 48.6735229, 1525.916871)
		elseif MyLevel == 450 or MyLevel <= 474 then 
			Ms = "God's Guard [Lv. 450]"
			NameQuest = "SkyExp1Quest"
			LevelQuest = 1
			NameMon = "God's Guards"
			CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105)
			CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.925427)
		elseif MyLevel == 475 or MyLevel <= 524 then 
			Ms = "Shanda [Lv. 475]"
			NameQuest = "SkyExp1Quest"
			LevelQuest = 2
			NameMon = "Shandas"
			CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
			CFrameMon = CFrame.new(-7904.57373, 5584.37646, -459.62973, 0.65171206, 5.11171692e-08, 0.758466363, -4.76232476e-09, 1, -6.33034247e-08, -0.758466363, 3.76435416e-08, 0.65171206)
		elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad
			Ms = "Royal Squad [Lv. 525]"
			NameQuest = "SkyExp2Quest"
			LevelQuest = 1
			NameMon = "Royal Squad"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-7555.04199, 5606.90479, -1303.24744, -0.896107852, -9.6057462e-10, -0.443836004, -4.24974544e-09, 1, 6.41599973e-09, 0.443836004, 7.63560326e-09, -0.896107852)
		elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier
			Ms = "Royal Soldier [Lv. 550]"
			NameQuest = "SkyExp2Quest"
			LevelQuest = 2
			NameMon = "Royal Soldier"
			CFrameQuest = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0)
			CFrameMon = CFrame.new(-7837.31152, 5649.65186, -1791.08582, -0.716008604, 0.0104285581, -0.698013008, 5.02521061e-06, 0.99988848, 0.0149335321, 0.69809103, 0.0106890313, -0.715928733)
		elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate
			Ms = "Galley Pirate [Lv. 625]"
			NameQuest = "FountainQuest"
			LevelQuest = 1
			NameMon = "Galley Pirate"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
			CFrameMon = CFrame.new(5569.80518, 38.5269432, 3849.01196, 0.896460414, 3.98027495e-08, 0.443124533, -1.34262139e-08, 1, -6.26611296e-08, -0.443124533, 5.02237434e-08, 0.896460414)
		elseif MyLevel >= 650 then -- Galley Captain
			Ms = "Galley Captain [Lv. 650]"
			NameQuest = "FountainQuest"
			LevelQuest = 2
			NameMon = "Galley Captain"
			CFrameQuest = CFrame.new(5259.81982, 37.3500175, 4050.0293, 0.087131381, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, 0.087131381)
			CFrameMon = CFrame.new(5782.90186, 94.5326462, 4716.78174, 0.361808896, -1.24757526e-06, -0.932252586, 2.16989656e-06, 1, -4.96097414e-07, 0.932252586, -1.84339774e-06, 0.361808896)
		end
	end
	if NewWorld then
		if MyLevel == 700 or MyLevel <= 724 then -- Raider [Lv. 700]
			Ms = "Raider [Lv. 700]"
			NameQuest = "Area1Quest"
			LevelQuest = 1
			NameMon = "Raider"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-737.026123, 10.1748352, 2392.57959, 0.272128761, 0, -0.962260842, -0, 1, -0, 0.962260842, 0, 0.272128761)
		elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary [Lv. 725]
			Ms = "Mercenary [Lv. 725]"
			NameQuest = "Area1Quest"
			LevelQuest = 2
			NameMon = "Mercenary"
			CFrameQuest = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, 0.974368095, 0, -0.22495985)
			CFrameMon = CFrame.new(-1022.21271, 72.9855194, 1891.39148, -0.990782857, 0, -0.135460541, 0, 1, 0, 0.135460541, 0, -0.990782857)
		elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate [Lv. 775]
			Ms = "Swan Pirate [Lv. 775]"
			NameQuest = "Area2Quest"
			LevelQuest = 1
			NameMon = "Swan Pirate"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
			CFrameMon = CFrame.new(976.467651, 111.174057, 1229.1084, 0.00852567982, -4.73897828e-08, -0.999963999, 1.12251888e-08, 1, -4.7295778e-08, 0.999963999, -1.08215579e-08, 0.00852567982)
		elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff [Lv. 800]
			Ms = "Factory Staff [Lv. 800]"
			NameQuest = "Area2Quest"
			LevelQuest = 2
			NameMon = "Factory Staff"
			CFrameQuest = CFrame.new(638.43811, 71.769989, 918.282898, 0.139203906, 0, 0.99026376, 0, 1, 0, -0.99026376, 0, 0.139203906)
			CFrameMon = CFrame.new(336.74585, 73.1620483, -224.129272, 0.993632793, 3.40154607e-08, 0.112668738, -3.87658332e-08, 1, 3.99718729e-08, -0.112668738, -4.40850592e-08, 0.993632793)
		elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant [Lv. 875]
			Ms = "Marine Lieutenant [Lv. 875]"
			NameQuest = "MarineQuest3"
			LevelQuest = 1
			NameMon = "Marine Lieutenant"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-2842.69922, 72.9919434, -2901.90479, -0.762281299, 0, -0.64724648, 0, 1.00000012, 0, 0.64724648, 0, -0.762281299)
		elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain [Lv. 900]
			Ms = "Marine Captain [Lv. 900]"
			NameQuest = "MarineQuest3"
			LevelQuest = 2
			NameMon = "Marine Captain"
			CFrameQuest = CFrame.new(-2440.79639, 71.7140732, -3216.06812, 0.866007268, 0, 0.500031412, 0, 1, 0, -0.500031412, 0, 0.866007268)
			CFrameMon = CFrame.new(-1814.70313, 72.9919434, -3208.86621, -0.900422215, 7.93464423e-08, -0.435017526, 3.68856199e-08, 1, 1.06050372e-07, 0.435017526, 7.94441988e-08, -0.900422215)
		elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie [Lv. 950]
			Ms = "Zombie [Lv. 950]"
			NameQuest = "ZombieQuest"
			LevelQuest = 1
			NameMon = "Zombie"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-5649.23438, 126.0578, -737.773743, 0.355238914, -8.10359282e-08, 0.934775114, 1.65461245e-08, 1, 8.04023372e-08, -0.934775114, -1.3095117e-08, 0.355238914)
		elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire [Lv. 975]
			Ms = "Vampire [Lv. 975]"
			NameQuest = "ZombieQuest"
			LevelQuest = 2
			NameMon = "Vampire"
			CFrameQuest = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, 0.95628953, 0, -0.29242146)
			CFrameMon = CFrame.new(-6030.32031, 0.4377408, -1313.5564, -0.856965423, 3.9138893e-08, -0.515373945, -1.12178942e-08, 1, 9.45958547e-08, 0.515373945, 8.68467822e-08, -0.856965423)
		elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper [Lv. 1000] **
			Ms = "Snow Trooper [Lv. 1000]"
			NameQuest = "SnowMountainQuest"
			LevelQuest = 1
			NameMon = "Snow Trooper"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(621.003418, 391.361053, -5335.43604, 0.481644779, 0, 0.876366913, 0, 1, 0, -0.876366913, 0, 0.481644779)
		elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior [Lv. 1050]
			Ms = "Winter Warrior [Lv. 1050]"
			NameQuest = "SnowMountainQuest"
			LevelQuest = 2
			NameMon = "Winter Warrior"
			CFrameQuest = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, 0.92718488, 0, 1, 0, -0.92718488, 0, -0.374604106)
			CFrameMon = CFrame.new(1295.62683, 429.447784, -5087.04492, -0.698032081, -8.28980049e-08, -0.71606636, -1.98835952e-08, 1, -9.63858184e-08, 0.71606636, -5.30424877e-08, -0.698032081)
		elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate [Lv. 1100]
			Ms = "Lab Subordinate [Lv. 1100]"
			NameQuest = "IceSideQuest"
			LevelQuest = 1
			NameMon = "Lab Subordinate"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721, -0.569419742, -2.49055017e-08, 0.822046936, -6.96206541e-08, 1, -1.79282633e-08, -0.822046936, -6.74401548e-08, -0.569419742)
		elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior [Lv. 1125]
			Ms = "Horned Warrior [Lv. 1125]"
			NameQuest = "IceSideQuest"
			LevelQuest = 2
			NameMon = "Horned Warrior"
			CFrameQuest = CFrame.new(-6064.06885, 15.2422857, -4902.97852, 0.453972578, -0, -0.891015649, 0, 1, -0, 0.891015649, 0, 0.453972578)
			CFrameMon = CFrame.new(-6401.27979, 15.9775667, -5948.24316, 0.388303697, 0, -0.921531856, 0, 1, 0, 0.921531856, 0, 0.388303697)
		elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja [Lv. 1175]
			Ms = "Magma Ninja [Lv. 1175]"
			NameQuest = "FireSideQuest"
			LevelQuest = 1
			NameMon = "Magma Ninja"
			CFrameQuest = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-5466.06445, 57.6952019, -5837.42822, -0.988835871, 0, -0.149006829, 0, 1, 0, 0.149006829, 0, -0.988835871)
		elseif MyLevel == 1200 or MyLevel <= 1249 then 
			Ms = "Lava Pirate [Lv. 1200]"
			NameQuest = "FireSideQuest"
			LevelQuest = 2
			NameMon = "Lava Pirate"
			CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223, 0.831796765, 1.15322464e-07, -0.555080295, -1.10814341e-07, 1, 4.17010995e-08, 0.555080295, 2.68240168e-08, 0.831796765)
			CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633, -0.196780294, 0, 0.98044765, 0, 1.00000012, -0, -0.98044765, 0, -0.196780294)
		elseif MyLevel == 1250 or MyLevel <= 1274 then 
			Ms = "Ship Deckhand [Lv. 1250]"
			NameQuest = "ShipQuest1"
			LevelQuest = 1
			NameMon = "Ship Deckhand"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
			CFrameMon = CFrame.new(1163.80872, 138.288452, 33058.4258, -0.998580813, 5.49076979e-08, -0.0532564968, 5.57436763e-08, 1, -1.42118655e-08, 0.0532564968, -1.71604082e-08, -0.998580813)
		elseif MyLevel == 1275 or MyLevel <= 1299 then 
			Ms = "Ship Engineer [Lv. 1275]"
			NameQuest = "ShipQuest1"
			LevelQuest = 2
			NameMon = "Ship Engineer"
			CFrameQuest = CFrame.new(1037.80127, 125.092171, 32911.6016, -0.244533166, -0, -0.969640911, -0, 1.00000012, -0, 0.96964103, 0, -0.244533136)
			CFrameMon = CFrame.new(921.30249023438, 125.400390625, 32937.34375)
		elseif MyLevel == 1300 or MyLevel <= 1324 then 
			Ms = "Ship Steward [Lv. 1300]"
			NameQuest = "ShipQuest2"
			LevelQuest = 1
			NameMon = "Ship Steward"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
			CFrameMon = CFrame.new(917.96057128906, 136.89932250977, 33343.4140625)
		elseif MyLevel == 1325 or MyLevel <= 1349 then 
			Ms = "Ship Officer [Lv. 1325]"
			NameQuest = "ShipQuest2"
			LevelQuest = 2
			NameMon = "Ship Officer"
			CFrameQuest = CFrame.new(968.80957, 125.092171, 33244.125, -0.869560242, 1.51905191e-08, -0.493826836, 1.44108379e-08, 1, 5.38534195e-09, 0.493826836, -2.43357912e-09, -0.869560242)
			CFrameMon = CFrame.new(944.44964599609, 181.40081787109, 33278.9453125)
		elseif MyLevel == 1350 or MyLevel <= 1374 then 
			Ms = "Arctic Warrior [Lv. 1350]"
			NameQuest = "FrostQuest"
			LevelQuest = 1
			NameMon = "Arctic Warrior"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5878.23486, 81.3886948, -6136.35596, -0.451037169, 2.3908234e-07, 0.892505825, -1.08168464e-07, 1, -3.22542007e-07, -0.892505825, -2.4201924e-07, -0.451037169)
		elseif MyLevel == 1375 or MyLevel <= 1424 then -- Snow Lurker [Lv. 1375]
			Ms = "Snow Lurker [Lv. 1375]"
			NameQuest = "FrostQuest"
			LevelQuest = 2
			NameMon = "Snow Lurker"
			CFrameQuest = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, 0.358349502, 0, -0.933587909)
			CFrameMon = CFrame.new(5513.36865, 60.546711, -6809.94971, -0.958693981, -1.65617333e-08, 0.284439981, -4.07668654e-09, 1, 4.44854642e-08, -0.284439981, 4.14883701e-08, -0.958693981)
		elseif MyLevel == 1425 or MyLevel <= 1449 then -- Sea Soldier [Lv. 1425]
			Ms = "Sea Soldier [Lv. 1425]"
			NameQuest = "ForgottenQuest"
			LevelQuest = 1
			NameMon = "Sea Soldier"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3115.78223, 63.8785706, -9808.38574, -0.913427353, 3.11199457e-08, 0.407000452, 7.79564235e-09, 1, -5.89660658e-08, -0.407000452, -5.06883708e-08, -0.913427353)
		elseif MyLevel >= 1450 then -- Water Fighter [Lv. 1450]
			Ms = "Water Fighter [Lv. 1450]"
			NameQuest = "ForgottenQuest"
			LevelQuest = 2
			NameMon = "Water Fighter"
			CFrameQuest = CFrame.new(-3054.44458, 235.544281, -10142.8193, 0.990270376, -0, -0.13915664, 0, 1, -0, 0.13915664, 0, 0.990270376)
			CFrameMon = CFrame.new(-3212.99683, 263.809296, -10551.8799, 0.742111444, -5.59139615e-08, -0.670276582, 1.69155214e-08, 1, -6.46908234e-08, 0.670276582, 3.66697037e-08, 0.742111444)
		end
	end
	if ThreeWorld then
		if MyLevel >= 1500 and MyLevel <= 1524 then -- Pirate Millionaire [Lv. 1500]
			Ms = "Pirate Millionaire [Lv. 1500]"
			NameQuest = "PiratePortQuest"
			LevelQuest = 1
			NameMon = "Pirate Millionaire"
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
		elseif MyLevel >= 1525 and MyLevel <= 1574 then -- Pistol Billionaire [Lv. 1525]
			Ms = "Pistol Billionaire [Lv. 1525]"
			NameQuest = "PiratePortQuest"
			LevelQuest = 2
			NameMon = "Pistol Billionaire"
			CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984, 0.965929627, -0, -0.258804798, 0, 1, -0, 0.258804798, 0, 0.965929627)
			CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
		elseif MyLevel >= 1575 and MyLevel <= 1599 then -- Dragon Crew Warrior [Lv. 1575]
			Ms = "Dragon Crew Warrior [Lv. 1575]"
			NameQuest = "AmazonQuest"
			LevelQuest = 1
			NameMon = "Dragon Crew Warrior"
			CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
			CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
		elseif MyLevel >= 1600 and MyLevel <= 1624 then -- Dragon Crew Archer [Lv. 1600]
			Ms = "Dragon Crew Archer [Lv. 1600]"
			NameQuest = "AmazonQuest"
			LevelQuest = 2
			NameMon = "Dragon Crew Archer"
			CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563, 0.898790359, -0, -0.438378751, 0, 1, -0, 0.438378751, 0, 0.898790359)
			CFrameMon = CFrame.new(6488.9155273438, 383.38375854492, -110.66246032715)
		elseif MyLevel >= 1625 and MyLevel <= 1649 then -- Female Islander [Lv. 1625]
			Ms = "Female Islander [Lv. 1625]"
			NameQuest = "AmazonQuest2"
			LevelQuest = 1
			NameMon = "Female Islander"
			CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(4770.4990234375, 758.95520019531, 1069.8680419922)
		elseif MyLevel >= 1650 and MyLevel <= 1699 then -- Giant Islander [Lv. 1650]
			Ms = "Giant Islander [Lv. 1650]"
			NameQuest = "AmazonQuest2"
			LevelQuest = 2
			NameMon = "Giant Islander"
			CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676, 0, 0, 1, 0, 1, -0, -1, 0, 0)
			CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
		elseif MyLevel >= 1700 and MyLevel <= 1724 then -- Marine Commodore [Lv. 1700]
			Ms = "Marine Commodore [Lv. 1700]"
			NameQuest = "MarineTreeIsland"
			LevelQuest = 1
			NameMon = "Marine Commodore"
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
			CFrameMon = CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688)
		elseif MyLevel >= 1725 and MyLevel <= 1774 then -- Marine Rear Admiral [Lv. 1725]
			Ms = "Marine Rear Admiral [Lv. 1725]"
			NameQuest = "MarineTreeIsland"
			LevelQuest = 2
			NameMon = "Marine Rear Admiral"
			CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, 0.258804798, 0, 1, 0, -0.258804798, 0, -0.965929747)
			CFrameMon = CFrame.new(3951.3903808594, 229.11549377441, -6912.81640625)
		elseif MyLevel >= 1775 and MyLevel <= 1799 then -- Fishman Raider [Lv. 1775]
			Ms = "Fishman Raider [Lv. 1775]"
			NameQuest = "DeepForestIsland3"
			LevelQuest = 1
			NameMon = "Fishman Raider"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-10322.400390625, 390.94473266602, -8580.0908203125)
		elseif MyLevel >= 1800 and MyLevel <= 1824 then -- Fishman Captain [Lv. 1800]
			Ms = "Fishman Captain [Lv. 1800]"
			NameQuest = "DeepForestIsland3"
			LevelQuest = 2
			NameMon = "Fishman Captain"
			CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, 0.469463557, 0, 1, 0, -0.469463557, 0, -0.882952213)
			CFrameMon = CFrame.new(-11194.541992188, 442.02795410156, -8608.806640625)
		elseif MyLevel >= 1825 and MyLevel <= 1849 then -- Forest Pirate [Lv. 1825]
			Ms = "Forest Pirate [Lv. 1825]"
			NameQuest = "DeepForestIsland"
			LevelQuest = 1
			NameMon = "Forest Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
			CFrameMon = CFrame.new(-13225.809570313, 428.19387817383, -7753.1245117188)
		elseif MyLevel >= 1850 and MyLevel <= 1899 then -- Mythological Pirate [Lv. 1850]
			Ms = "Mythological Pirate [Lv. 1850]"
			NameQuest = "DeepForestIsland"
			LevelQuest = 2
			NameMon = "Mythological Pirate"
			CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137, 0.707134247, -0, -0.707079291, 0, 1, -0, 0.707079291, 0, 0.707134247)
			CFrameMon = CFrame.new(-13869.172851563, 564.95251464844, -7084.4135742188)
		elseif MyLevel >= 1900 and MyLevel <= 1924 then -- Jungle Pirate [Lv. 1900]
			Ms = "Jungle Pirate [Lv. 1900]"
			NameQuest = "DeepForestIsland2"
			LevelQuest = 1
			NameMon = "Jungle Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-11982.221679688, 376.32522583008, -10451.415039063)
		elseif MyLevel >= 1925 and MyLevel <= 1974 then -- Musketeer Pirate [Lv. 1925]
			Ms = "Musketeer Pirate [Lv. 1925]"
			NameQuest = "DeepForestIsland2"
			LevelQuest = 2
			NameMon = "Musketeer Pirate"
			CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, 0.996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002)
			CFrameMon = CFrame.new(-13282.3046875, 496.23684692383, -9565.150390625)
		elseif MyLevel >= 1975 and MyLevel <= 1999 then
			Ms = "Reborn Skeleton [Lv. 1975]"
			NameQuest = "HauntedQuest1"
			LevelQuest = 1
			NameMon = "Reborn Skeleton"
			CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
			CFrameMon = CFrame.new(-8817.880859375, 191.16761779785, 6298.6557617188)
		elseif MyLevel >= 2000 and MyLevel <= 2024 then
			Ms = "Living Zombie [Lv. 2000]"
			NameQuest = "HauntedQuest1"
			LevelQuest = 2
			NameMon = "Living Zombie"
			CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
			CFrameMon = CFrame.new(-10125.234375, 183.94705200195, 6242.013671875)
		elseif MyLevel >= 2025 and MyLevel <= 2049  then
			Ms = "Demonic Soul [Lv. 2025]"
			NameQuest = "HauntedQuest2"
			LevelQuest = 1
			NameMon = "Demonic Soul"
			CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
			CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
		elseif MyLevel >= 2050 and MyLevel <= 2074 then
			Ms = "Posessed Mummy [Lv. 2050]"
			NameQuest = "HauntedQuest2"
			LevelQuest = 2
			NameMon = "Posessed Mummy"
			CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
			CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)    
		elseif MyLevel >= 2075 and MyLevel <= 2099 then
			Ms = "Peanut Scout [Lv. 2075]"
			NameQuest = "NutsIslandQuest"
			LevelQuest = 1
			NameMon = "Peanut Scout"
			CFrameQuest = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
			CFrameMon = CFrame.new(-2098.07544, 192.611862, -10248.8867, 0.983392298, -9.57031787e-08, 0.181492642, 8.7276355e-08, 1, 5.44169616e-08, -0.181492642, -3.76732068e-08, 0.983392298)
		elseif MyLevel >= 2100 and MyLevel <= 2124 then
			Ms = "Peanut President [Lv. 2100]"
			NameQuest = "NutsIslandQuest"
			LevelQuest = 2
			NameMon = "Peanut President"
			CFrameQuest = CFrame.new(-2104.17163, 38.1299706, -10194.418, 0.758814394, -1.38604395e-09, 0.651306927, 2.85280208e-08, 1, -3.1108879e-08, -0.651306927, 4.21863646e-08, 0.758814394)
			CFrameMon = CFrame.new(-1876.95959, 192.610947, -10542.2939, 0.0553516336, -2.83836812e-08, 0.998466909, -6.89634405e-10, 1, 2.84654931e-08, -0.998466909, -2.26418861e-09, 0.0553516336)
		elseif MyLevel >= 2125 and MyLevel <= 2149 then
			Ms = "Ice Cream Chef [Lv. 2125]"
			NameQuest = "IceCreamIslandQuest"
			LevelQuest = 1
			NameMon = "Ice Cream Chef"
			CFrameQuest = CFrame.new(-820.404358, 65.8453293, -10965.5654, 0.822534859, 5.24448502e-08, -0.568714678, -2.08336317e-08, 1, 6.20846663e-08, 0.568714678, -3.92184099e-08, 0.822534859)
			CFrameMon = CFrame.new(-821.614075, 208.39537, -10990.7617, -0.870096624, 3.18909272e-08, 0.492881238, -1.8357893e-08, 1, -9.71107568e-08, -0.492881238, -9.35439957e-08, -0.870096624)
		elseif MyLevel >= 2150 and MyLevel <= 2199 then 
			Ms = "Ice Cream Commander [Lv. 2150]"
			NameQuest = "IceCreamIslandQuest"
			LevelQuest = 2
			NameMon = "Ice Cream Commander"
			CFrameQuest = CFrame.new(-819.376526, 67.4634171, -10967.2832)
			CFrameMon = CFrame.new(-610.11669921875, 208.26904296875, -11253.686523438)
		elseif MyLevel >= 2200 and MyLevel <= 2224 then 
			Ms = "Cookie Crafter [Lv. 2200]"
			NameQuest = "CakeQuest1"
			LevelQuest = 1
			NameMon = "Cookie Crafter"
			CFrameQuest = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
			CFrameMon = CFrame.new(-2286.684326171875, 146.5656280517578, -12226.8818359375)
		elseif MyLevel >= 2225 and MyLevel <= 2249 then 
			Ms = "Cake Guard [Lv. 2225]"
			NameQuest = "CakeQuest1"
			LevelQuest = 2
			NameMon = "Cake Guard"
			CFrameQuest = CFrame.new(-2020.6068115234375, 37.82400894165039, -12027.80859375)
			CFrameMon = CFrame.new(-1817.9747314453125, 209.5632781982422, -12288.9228515625)
		elseif MyLevel >= 2250 and MyLevel <= 2274 then 
			Ms = "Baking Staff [Lv. 2250]"
			NameQuest = "CakeQuest2"
			LevelQuest = 1
			NameMon = "Baking Staff"
			CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626)
			CFrameMon = CFrame.new(-1818.347900390625, 93.41275787353516, -12887.66015625)
		elseif MyLevel >= 2275 then 
			Ms = "Head Baker [Lv. 2275]"
			NameQuest = "CakeQuest2"
			LevelQuest = 2
			NameMon = "Head Baker"
			CFrameQuest = CFrame.new(-1928.31763, 37.7296638, -12840.626)
			CFrameMon = CFrame.new(-2288.795166015625, 106.9419174194336, -12811.111328125)
		end
	end
end

getgenv().LoadScript = true
local t = game.Players.LocalPlayer
getgenv().getupvalue = debug.getupvalue
getgenv().getupvalues = debug.getupvalues
wOrigin = game.workspace._WorldOrigin
CommF = game.ReplicatedStorage.Remotes.CommF_
vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
	vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
	wait(1)
	vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
local A = (function()
-- NexoraUI.lua | Biblioteca independente de interface para Roblox executors
-- API compatível com o padrão usado na source Nexora Hub:
-- CreateMain, CreatePage, CreateSection, CreateToggle, CreateButton,
-- CreateDropdown, CreateSlider, CreateLabel, CreateNoti.
-- Observação: esta biblioteca cria a UI; a source principal continua responsável pelas funções do jogo.

local Nexora = {}
Nexora.Options = {}
Nexora.OptionOrder = {}

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local parentGui = (gethui and gethui()) or CoreGui

local old = parentGui:FindFirstChild("NexoraUI")
if old then old:Destroy() end
local oldFloat = parentGui:FindFirstChild("NexoraFloat")
if oldFloat then oldFloat:Destroy() end

local C = {
    -- Fundo preto e azul igual você pediu
    bg = Color3.fromRGB(0, 0, 0),
    panel = Color3.fromRGB(10, 10, 15),
    panel2 = Color3.fromRGB(18, 18, 28),
    line = Color3.fromRGB(0, 80, 180),
    gold = Color3.fromRGB(0, 140, 255),
    goldLight = Color3.fromRGB(80, 180, 255),
    text = Color3.fromRGB(240, 245, 255),
    muted = Color3.fromRGB(140, 150, 170),
    green = Color3.fromRGB(0, 200, 255),
}

local function make(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props or {}) do o[k] = v end
    o.Parent = parent
    return o
end
local function corner(obj, radius)
    make("UICorner", {CornerRadius = UDim.new(0, radius or 8)}, obj)
end
local function stroke(obj, color, transparency)
    make("UIStroke", {Color = color or C.line, Transparency = transparency or 0, Thickness = 1}, obj)
end
local function label(parent, text, size, color, font)
    return make("TextLabel", {
        BackgroundTransparency = 1, Text = tostring(text or ""), TextColor3 = color or C.text,
        Font = font or Enum.Font.SourceSansBold, TextSize = size or 12, TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center, Size = UDim2.new(1, 0, 1, 0),
        TextWrapped = true,
    }, parent)
end
local function button(parent, text, height)
    local b = make("TextButton", {
        AutoButtonColor = false, BackgroundColor3 = C.panel2, BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, height or 34), Text = text or "", TextColor3 = C.text,
        Font = Enum.Font.SourceSansBold, TextSize = 12,
    }, parent)
    corner(b, 7)
    b.MouseEnter:Connect(function() if not b:GetAttribute("NexoraKeepColor") then TweenService:Create(b, TweenInfo.new(.12), {BackgroundColor3 = Color3.fromRGB(36, 34, 31)}):Play() end end)
    b.MouseLeave:Connect(function() if not b:GetAttribute("NexoraKeepColor") then TweenService:Create(b, TweenInfo.new(.12), {BackgroundColor3 = C.panel2}):Play() end end)
    b.MouseButton1Down:Connect(function() if not b:GetAttribute("NexoraKeepColor") then TweenService:Create(b, TweenInfo.new(.08), {BackgroundColor3 = Color3.fromRGB(58, 46, 22)}):Play() end end)
    b.MouseButton1Up:Connect(function() if not b:GetAttribute("NexoraKeepColor") then TweenService:Create(b, TweenInfo.new(.14), {BackgroundColor3 = Color3.fromRGB(36, 34, 31)}):Play() end end)
    return b
end
-- Sons da UI. Para usar os seus: getgenv().NexoraSounds = { ping="rbxassetid://ID", switch="rbxassetid://ID", click="rbxassetid://ID" } antes de executar.
local SND = { ping = "rbxasset://sounds/electronicpingshort.wav", switch = "rbxasset://sounds/switch.wav", click = "rbxasset://sounds/button.wav" }
pcall(function() for k, v in pairs(getgenv().NexoraSounds or {}) do SND[k] = v end end)
local function playUISound(id, vol, speed) return end -- SFX REMOVIDO DIRETO
-- Cada efeito é uma sequência curta de camadas {som, volume, velocidade, atraso}.
local SFX = {
    open  = {},
    close = {},
    on    = {},
    off   = {},
    tab   = {},
}
local function sfxPlay(name) return end -- SFX REMOVIDO DIRETO
local function addOption(title, typ, value, page, section, callback)
    local opt = {Title = title, name = title, type = typ, value = value, Page_Name = page, Section_Name = section, Callback = callback}
    local control = {}
    control.GetText = function() return tostring(opt.value or "") end
    control.SetValue = function(a, b)
        local v = b
        if b == nil then v = a end
        if v == control then return end
        opt.value = v
        if opt._setValue then opt._setValue(v) end
        if callback then task.spawn(function() pcall(callback, v) end) end
    end
    control.SetStage = control.SetValue
    control.SetSubValue = function(a, b, c)
        local key, v
        if c ~= nil then key, v = b, c else key, v = a, b end
        opt.value = opt.value or {}
        opt.value[key] = v
        if opt._setSubValue then opt._setSubValue(key, v) end
        if callback then task.spawn(function() pcall(callback, opt.value) end) end
    end
    opt.FunctionCreate = control
    Nexora.Options[title] = opt
    table.insert(Nexora.OptionOrder, opt)
    return opt
end

function Nexora.CreateMain(config)
    config = config or {}
    local gui = make("ScreenGui", {Name = "NexoraUI", ResetOnSpawn = false, ZIndexBehavior = Enum.ZIndexBehavior.Sibling}, parentGui)
    local SIZE_FILE = "NexoraHubWindowSize.json"
    local persistedW, persistedH = 690, 440
    -- Salva o tamanho em arquivo do executor para sobreviver a reinícios do jogo.
    pcall(function()
        if readfile and isfile and isfile(SIZE_FILE) then
            local stored = game:GetService("HttpService"):JSONDecode(readfile(SIZE_FILE))
            persistedW = math.clamp(tonumber(stored.w) or 690, 360, 900)
            persistedH = math.clamp(tonumber(stored.h) or 440, 280, 720)
        elseif getgenv and getgenv().__NEXORA_WINDOW_SIZE then
            persistedW = math.clamp(tonumber(getgenv().__NEXORA_WINDOW_SIZE.w) or 690, 360, 900)
            persistedH = math.clamp(tonumber(getgenv().__NEXORA_WINDOW_SIZE.h) or 440, 280, 720)
        end
    end)
    local function saveWindowSize(w, h)
        local data = {w = math.floor(w), h = math.floor(h)}
        pcall(function() if getgenv then getgenv().__NEXORA_WINDOW_SIZE = data end end)
        pcall(function() if writefile then writefile(SIZE_FILE, game:GetService("HttpService"):JSONEncode(data)) end end)
    end
    local shell = make("Frame", {Name="Window", AnchorPoint=Vector2.new(.5,.5), Position=UDim2.fromScale(.5,.5), Size=UDim2.new(0, persistedW, 0, persistedH), BackgroundColor3=C.bg, BorderSizePixel=0}, gui)
    corner(shell, 14); stroke(shell, Color3.fromRGB(255,255,255), 0.88)
    make("UIGradient", {Rotation = 135, Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.52, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 10, 30)),
    })}, shell)
    local scale = make("UIScale", {Scale = 1}, shell)
    local function fitScale()
        local cam = workspace.CurrentCamera
        if cam then
            local v = cam.ViewportSize
            return math.clamp(math.min((v.X-20)/math.max(1, shell.Size.X.Offset), (v.Y-20)/math.max(1, shell.Size.Y.Offset)), .38, 1)
        end
        return 1
    end
    local function resize()
        scale.Scale = fitScale()
    end
    resize()
    if workspace.CurrentCamera then workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(resize) end

    local HEADER_H, SIDEBAR_W = 64, 190
    local GOLD, GOLD_L, GRAY = Color3.fromRGB(0, 140, 255), Color3.fromRGB(80, 180, 255), Color3.fromRGB(165,165,174)
    local top = make("Frame", {Size=UDim2.new(1,0,0,HEADER_H), BackgroundColor3=Color3.fromRGB(10,10,14), BorderSizePixel=0}, shell)
    corner(top, 12)
    make("UIGradient", {Rotation=0, Color=ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 15, 40)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(13,13,18)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(8,8,11)),
    })}, top)
    -- cobre os cantos de baixo do header e desenha a linha dourada
    make("Frame", {Position=UDim2.new(0,0,1,-12), Size=UDim2.new(1,0,0,12), BackgroundColor3=Color3.fromRGB(10,10,14), BorderSizePixel=0}, top)
    do
        local hl = make("Frame", {Position=UDim2.new(0,0,1,-1), Size=UDim2.new(1,0,0,1), BackgroundColor3=GOLD, BackgroundTransparency=0, BorderSizePixel=0}, top)
        local hg = make("UIGradient", {Transparency=NumberSequence.new({NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(0.5,0.1),NumberSequenceKeypoint.new(1,1)}), Offset=Vector2.new(-1,0)}, hl)
        task.spawn(function()
            while hl.Parent do
                hg.Offset = Vector2.new(-1,0)
                local tw = TweenService:Create(hg, TweenInfo.new(3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Offset=Vector2.new(1,0)})
                tw:Play(); tw.Completed:Wait(); task.wait(0.8)
            end
        end)
    end
    local title = make("TextLabel", {Position=UDim2.new(0,18,0,10), Size=UDim2.new(0,300,0,26), BackgroundTransparency=1, RichText=true, Text='<font color="#FFFFFF">NEXORA</font> <font color="#008CFF">HUB</font>', TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.Arcade, TextSize=22, TextXAlignment=Enum.TextXAlignment.Left}, top)
    local function tracked(t) return (string.gsub(string.upper(t), "(%S)", "%1\u{2009}")) end
    local desc = make("TextLabel", {Position=UDim2.new(0,19,0,37), Size=UDim2.new(0,300,0,16), BackgroundTransparency=1, Text=tracked("BLOX FRUITS • ViniZDev"), TextColor3=GRAY, Font=Enum.Font.Code, TextSize=10, TextXAlignment=Enum.TextXAlignment.Left}, top)
    -- 3 tracinhos removidos da UI como você pediu
    local hamburger = make("TextButton", {Name="Menu", AnchorPoint=Vector2.new(1,0.5), Position=UDim2.new(1,-12,0.5,0), Size=UDim2.new(0,36,0,36), BackgroundTransparency=1, Text="", TextTransparency=1, Visible=false, AutoButtonColor=false}, top)
    -- ScreenGui separado: o botão fica fora da janela e não some junto com a UI (nem com o keybind Toggle GUI).
    local floatGui = make("ScreenGui", {Name="NexoraFloat", ResetOnSpawn=false, IgnoreGuiInset=true, DisplayOrder=999, ZIndexBehavior=Enum.ZIndexBehavior.Sibling}, parentGui)
    -- Botão preto com nome branco igual você pediu
    local reopen = make("TextButton", {
        Name="NexoraFloatingButton",
        AutoButtonColor=false,
        BackgroundColor3=Color3.fromRGB(20, 20, 25),
        BorderSizePixel=0,
        Size=UDim2.new(0, 145, 0, 36),
        Text="",
        ZIndex=100
    }, floatGui)
    reopen:SetAttribute("NexoraKeepColor", true)
    make("UICorner", {CornerRadius=UDim.new(0, 18)}, reopen)
    make("UIStroke", {Color=Color3.fromRGB(60, 60, 65), Thickness=1, Transparency=0.3}, reopen)
    -- Icone N TOP - 100% seguro, sem frames extras que quebram UI
    local iconFrame = make("Frame", {
        BackgroundColor3=Color3.fromRGB(20, 20, 30),
        Size=UDim2.new(0, 24, 0, 24),
        Position=UDim2.new(0, 6, 0.5, -12),
        BorderSizePixel=0,
        ZIndex=101
    }, reopen)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, iconFrame)
    make("UIStroke", {Color=Color3.fromRGB(0, 140, 255), Thickness=1.2, Transparency=0.2}, iconFrame)
    local iconText = make("TextLabel", {
        BackgroundTransparency=1,
        Size=UDim2.new(1, 0, 1, 0),
        Position=UDim2.new(0, 0, 0, 0),
        Text="N",
        TextColor3=Color3.fromRGB(255, 255, 255),
        Font=Enum.Font.Arcade,
        TextSize=19,
        TextStrokeTransparency=0,
        ZIndex=102
    }, iconFrame)
    local grad = make("UIGradient", {Rotation=90, Color=ColorSequence.new(Color3.fromRGB(150, 230, 255), Color3.fromRGB(0, 140, 255))}, iconText)
    local txtStroke = make("UIStroke", {Color=Color3.fromRGB(0, 80, 160), Thickness=1.5, Transparency=0}, iconText)
    -- So animacao do texto, nada de frames extras
    task.spawn(function()
        local TS = game:GetService("TweenService")
        while iconText.Parent do
            pcall(function()
                TS:Create(iconText, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextSize=22, TextColor3=Color3.fromRGB(180, 240, 255)}):Play()
                TS:Create(grad, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation=120}):Play()
                TS:Create(txtStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Thickness=2, Color=Color3.fromRGB(0, 140, 255)}):Play()
            end)
            task.wait(0.6)
            pcall(function()
                TS:Create(iconText, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextSize=19, TextColor3=Color3.fromRGB(255, 255, 255)}):Play()
                TS:Create(grad, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Rotation=90}):Play()
                TS:Create(txtStroke, TweenInfo.new(0.6, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Thickness=1.5, Color=Color3.fromRGB(0, 80, 160)}):Play()
            end)
            task.wait(0.6)
        end
    end)
    local iconImg = make("ImageLabel", {
        BackgroundTransparency=1,
        Size=UDim2.new(1, -4, 1, -4),
        Position=UDim2.new(0, 2, 0, 2),
        Image="rbxassetid://18747094503",
        ScaleType=Enum.ScaleType.Fit,
        ImageColor3=Color3.fromRGB(80, 180, 255),
        ZIndex=102,
        Visible=false
    }, iconFrame)
    pcall(function()
        if config.Logo and config.Logo ~= "" then
            iconImg.Image = config.Logo
            iconImg.Visible = true
            iconText.Visible = false
        end
    end)
    -- Texto Nexora Hub
    local textLabel = make("TextLabel", {
        BackgroundTransparency=1,
        Position=UDim2.new(0, 36, 0, 0),
        Size=UDim2.new(0, 85, 1, 0),
        Text="Nexora Hub",
        TextColor3=Color3.fromRGB(255, 255, 255),
        TextSize=13,
        Font=Enum.Font.Code,
        TextXAlignment=Enum.TextXAlignment.Left,
        ZIndex=101
    }, reopen)
    -- Bolinha verde online igual da imagem
    local greenDot = make("Frame", {
        BackgroundColor3=Color3.fromRGB(0, 255, 100),
        Size=UDim2.new(0, 10, 0, 10),
        Position=UDim2.new(1, -18, 0.5, -5),
        BorderSizePixel=0,
        ZIndex=101
    }, reopen)
    make("UICorner", {CornerRadius=UDim.new(1,0)}, greenDot)
    make("UIStroke", {Color=Color3.fromRGB(0,0,0), Thickness=1, Transparency=0.5}, greenDot)
    -- Efeito de brilho na bolinha verde
    task.spawn(function()
        while greenDot.Parent do
            local tw = TweenService:Create(greenDot, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency=0.3})
            tw:Play(); tw.Completed:Wait()
            tw = TweenService:Create(greenDot, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency=0})
            tw:Play(); tw.Completed:Wait()
        end
    end)
    local FLOAT_POS_FILE = "NexoraHub_FloatPosition.json"
    local function loadFloatPosition()
        local saved
        pcall(function()
            if readfile and isfile and isfile(FLOAT_POS_FILE) then
                saved = game:GetService("HttpService"):JSONDecode(readfile(FLOAT_POS_FILE))
            end
        end)
        if type(saved) == "table" and tonumber(saved.x) and tonumber(saved.y) then
            return UDim2.new(0, tonumber(saved.x), 0, tonumber(saved.y))
        end
        local cam = workspace.CurrentCamera
        local vp = cam and cam.ViewportSize or Vector2.new(800, 600)
        return UDim2.new(0, math.max(10, vp.X - 66), 0, 70)
    end
    local function saveFloatPosition()
        pcall(function()
            if writefile then
                local p = reopen.Position
                writefile(FLOAT_POS_FILE, game:GetService("HttpService"):JSONEncode({
                    x = math.floor(p.X.Offset), y = math.floor(p.Y.Offset)
                }))
            end
        end)
    end
    reopen.Position = loadFloatPosition()
    reopen.AnchorPoint = Vector2.new(0, 0)
    reopen.Visible = true
    do
        local z = 103
local fScale = make("UIScale", {Scale=1}, reopen)
        function bounceFloat()
            TweenService:Create(fScale, TweenInfo.new(.08), {Scale=.8}):Play()
            task.delay(.08, function() TweenService:Create(fScale, TweenInfo.new(.28, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=1}):Play() end)
        end
    end
    -- Estado declarado antes dos eventos para evitar que o clique use uma variável global.
    local floatDragging, floatStart, floatPos, floatMoved = false, nil, nil, false
    local playClose
    local function hideWindow()
        if playClose then playClose() else shell.Visible = false end
    end
    -- Abrir/fechar: sempre parte da escala "encaixada" (fitScale) e da posição de repouso,
    -- e cancela a animação anterior, para a janela não ir encolhendo a cada abre/fecha.
    local animToken, animating, isClosing, animTweens = 0, false, false, {}
    local restPos = shell.Position
    local function stopAnim()
        for _, tw in ipairs(animTweens) do pcall(function() tw:Cancel() end) end
        animTweens = {}
    end
    local function playOpen()
        animToken = animToken + 1
        local token = animToken
        stopAnim()
        isClosing = false
        if not animating then restPos = shell.Position end
        animating = true
        local base = fitScale()
        shell.Visible = true
        shell.Position = restPos + UDim2.new(0,0,0,22)
        scale.Scale = base * 0.93
        sfxPlay("open")
        local t1 = TweenService:Create(shell, TweenInfo.new(.34, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=restPos})
        local t2 = TweenService:Create(scale, TweenInfo.new(.34, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale=base})
        animTweens = { t1, t2 }
        t1:Play(); t2:Play()
        t1.Completed:Connect(function()
            if token ~= animToken then return end
            animating = false
            shell.Position = restPos
            scale.Scale = fitScale()
        end)
    end
    playClose = function()
        if not shell.Visible or isClosing then return end
        animToken = animToken + 1
        local token = animToken
        stopAnim()
        if not animating then restPos = shell.Position end
        animating, isClosing = true, true
        local base = fitScale()
        sfxPlay("close")
        local t1 = TweenService:Create(shell, TweenInfo.new(.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position=restPos + UDim2.new(0,0,0,18)})
        local t2 = TweenService:Create(scale, TweenInfo.new(.2, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Scale=base * 0.93})
        animTweens = { t1, t2 }
        t1:Play(); t2:Play()
        t1.Completed:Connect(function()
            if token ~= animToken then return end
            shell.Visible = false
            shell.Position = restPos
            scale.Scale = fitScale()
            animating, isClosing = false, false
        end)
    end
    -- O mesmo botão flutuante fica sempre visível e alterna abrir/fechar.
    reopen.Activated:Connect(function()
        if floatMoved then
            task.defer(function() floatMoved = false end)
            return
        end
        pcall(function() if bounceFloat then bounceFloat() end end)
        if not gui.Enabled then
            gui.Enabled = true
            pcall(function() getgenv().UIToggled = true end)
            playOpen()
            return
        end
        if shell.Visible then playClose() else playOpen() end
    end)
    reopen.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatDragging = true; floatMoved = false; floatStart = input.Position; floatPos = reopen.Position
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if floatDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d = input.Position - floatStart
            if math.abs(d.X) > 4 or math.abs(d.Y) > 4 then floatMoved = true end
            if floatMoved then
                local cam = workspace.CurrentCamera
                local vp = cam and cam.ViewportSize or Vector2.new(800,600)
                local x = math.clamp(floatPos.X.Offset + d.X, 0, math.max(0, vp.X - reopen.AbsoluteSize.X))
                local y = math.clamp(floatPos.Y.Offset + d.Y, 0, math.max(0, vp.Y - reopen.AbsoluteSize.Y))
                reopen.Position = UDim2.new(0, x, 0, y)
            end
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatDragging = false
            if floatMoved then saveFloatPosition() end
            -- Mantém floatMoved até Activated decidir se foi clique ou arrasto.
        end
    end)

    local dragging, dragStart, startPos = false, nil, nil
    top.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging=true; dragStart=input.Position; startPos=shell.Position
        end
    end)
    top.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging=false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local d=input.Position-dragStart
            shell.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)

    local sidebar = make("Frame", {Name="Sidebar", Position=UDim2.new(0,0,0,HEADER_H), Size=UDim2.new(0,SIDEBAR_W,1,-HEADER_H), BackgroundColor3=Color3.fromRGB(9,9,12), BorderSizePixel=0}, shell)
    make("Frame", {Position=UDim2.new(1,-1,0,0), Size=UDim2.new(0,1,1,0), BackgroundColor3=C.line, BorderSizePixel=0}, sidebar)
    make("UIStroke", {Color=Color3.fromRGB(245,245,245), Transparency=0.94, Thickness=1}, sidebar)
    local search = make("TextBox", {Position=UDim2.new(0,12,0,12), Size=UDim2.new(1,-24,0,32), BackgroundColor3=C.bg, BorderSizePixel=0, PlaceholderText="Pesquisar...", Text="", TextColor3=C.text, PlaceholderColor3=C.muted, Font=Enum.Font.SourceSansBold, TextSize=11, ClearTextOnFocus=false}, sidebar); corner(search,7); stroke(search,C.line)
    local nav = make("ScrollingFrame", {Position=UDim2.new(0,8,0,54), Size=UDim2.new(1,-16,1,-62), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=2, ScrollBarImageColor3=C.gold, CanvasSize=UDim2.new()}, sidebar)
    local navLayout = make("UIListLayout", {Padding=UDim.new(0,5), SortOrder=Enum.SortOrder.LayoutOrder}, nav)
    navLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        nav.CanvasSize = UDim2.new(0, 0, 0, navLayout.AbsoluteContentSize.Y + 8)
    end)
    local content = make("Frame", {Name="Content", Position=UDim2.new(0,SIDEBAR_W,0,HEADER_H), Size=UDim2.new(1,-SIDEBAR_W,1,-HEADER_H), BackgroundTransparency=1}, shell)
    local sidebarOpen = true
    hamburger.MouseButton1Click:Connect(function()
        sidebarOpen = not sidebarOpen
        sidebar.Visible = sidebarOpen
        content.Position = UDim2.new(0, sidebarOpen and SIDEBAR_W or 0, 0, HEADER_H)
        content.Size = UDim2.new(1, sidebarOpen and -SIDEBAR_W or 0, 1, -HEADER_H)
    end)
    -- Alça de redimensionamento no canto inferior direito (mouse e toque).
    local grip = make("TextButton", {Name="ResizeGrip", AnchorPoint=Vector2.new(1,1), Position=UDim2.new(1,-4,1,-4), Size=UDim2.new(0,22,0,22), BackgroundColor3=C.panel2, BorderSizePixel=0, Text="◢", TextColor3=C.gold, Font=Enum.Font.Fantasy, TextSize=14, AutoButtonColor=false}, shell)
    corner(grip, 5)
    local resizing, resizeStart, sizeStart = false, nil, nil
    grip.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true; resizeStart = input.Position; sizeStart = shell.Size
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then resizing = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - resizeStart
            local w = math.clamp(sizeStart.X.Offset + delta.X, 360, 900)
            local h = math.clamp(sizeStart.Y.Offset + delta.Y, 280, 720)
            shell.Size = UDim2.new(0, w, 0, h)
            savedWindowSize = shell.Size
            saveWindowSize(w, h)
            scale.Scale = 1
        end
    end)
    local pages, activePage, navButtons = {}, nil, {}
    -- Ícones desenhados com formas simples (sem emoji): contorno fino, estilo minimalista.
    local function drawIcon(parent, kind)
        local holder = make("Frame", {Name="Icon", BackgroundTransparency=1, Position=UDim2.new(0,13,.5,-10), Size=UDim2.new(0,20,0,20)}, parent)
        local function outline(w,h,x,y,r,rot)
            local f = make("Frame", {BackgroundTransparency=1, Size=UDim2.new(0,w,0,h), Position=UDim2.new(0,x,0,y), Rotation=rot or 0, BorderSizePixel=0}, holder)
            corner(f, r or 0); make("UIStroke", {Thickness=1.6, Color=GRAY}, f)
            return f
        end
        local function fill(w,h,x,y,r,rot)
            local f = make("Frame", {BackgroundColor3=GRAY, Size=UDim2.new(0,w,0,h), Position=UDim2.new(0,x,0,y), Rotation=rot or 0, BorderSizePixel=0}, holder)
            f:SetAttribute("Fill", true); corner(f, r or 0)
            return f
        end
        if kind == "house" then
            fill(10,1.6,0.5,6,1,-38); fill(10,1.6,9.5,6,1,38); outline(12,8,4,10,2)
        elseif kind == "diamond" then
            outline(10,10,5,5,2,45); fill(4,4,8,8,2)
        elseif kind == "bag" then
            outline(7,6,6.5,2,3); outline(14,11,3,7,3)
        elseif kind == "cross" then
            fill(19,1.8,0.5,9.1,1,45); fill(19,1.8,0.5,9.1,1,-45)
        elseif kind == "gear" then
            outline(14,14,3,3,7); fill(4,4,8,8,2); fill(2,3,9,0,1); fill(2,3,9,17,1); fill(3,2,0,9,1); fill(3,2,17,9,1)
        elseif kind == "bars" then
            fill(3,5,3,13,1); fill(3,10,8.5,8,1); fill(3,15,14,3,1)
        elseif kind == "user" then
            outline(8,8,6,2,4); outline(14,7,3,12,4)
        elseif kind == "wave" then
            fill(12,2,2,5,1); fill(12,2,6,9,1); fill(12,2,4,13,1)
        elseif kind == "orb" then
            outline(14,14,3,4,7); fill(5,3,9,1,2,-30)
        elseif kind == "eye" then
            outline(18,11,1,4.5,6); fill(5,5,7.5,7.5,3)
        else
            outline(7,7,2,2,2); outline(7,7,11,2,2); outline(7,7,2,11,2); outline(7,7,11,11,2)
        end
        return holder
    end
    local function tintIcon(holder, color, transp)
        for _, d in ipairs(holder:GetDescendants()) do
            if d:IsA("UIStroke") then
                TweenService:Create(d, TweenInfo.new(.18), {Color=color, Transparency=transp}):Play()
            elseif d:IsA("Frame") and d:GetAttribute("Fill") then
                TweenService:Create(d, TweenInfo.new(.18), {BackgroundColor3=color, BackgroundTransparency=transp}):Play()
            end
        end
    end
    local function iconKind(name)
        local n = string.lower(name)
        local map = {{"home","house"},{"setting","gear"},{"status","bars"},{"server","bars"},{"local","user"},{"shop","bag"},{"item","bag"},
            {"farm","diamond"},{"stack","diamond"},{"fishing","wave"},{"sea","wave"},{"volcano","wave"},{"fruit","orb"},{"race","orb"},{"kitsune","orb"},
            {"raid","cross"},{"pvp","cross"},{"boss","cross"},{"esp","eye"}}
        for _, m in ipairs(map) do if string.find(n, m[1], 1, true) then return m[2] end end
        return "grid"
    end
    local function showPage(p)
        local changed = (activePage ~= p)
        activePage=p
        for _, item in pairs(pages) do item.frame.Visible=(item==p) end
        for pg,b in pairs(navButtons) do
            local on = (pg==p)
            local was = b:GetAttribute("NexoraActive")
            b:SetAttribute("NexoraActive", on)
            b.BackgroundColor3 = Color3.fromRGB(24,22,18)
            TweenService:Create(b, TweenInfo.new(.18), {BackgroundTransparency = on and 0.35 or 1}):Play()
            b.Bar.Visible = on
            if on and not was then
                b.Bar.Size = UDim2.new(0,3,0,0)
                TweenService:Create(b.Bar, TweenInfo.new(.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size=UDim2.new(0,3,1,-14)}):Play()
            end
            tintIcon(b.Icon, on and GOLD or GRAY, on and 0 or 0.4)
            TweenService:Create(b.Txt, TweenInfo.new(.18), {TextColor3 = on and Color3.fromRGB(255,255,255) or GRAY}):Play()
        end
        if changed and p.frame then
            p.frame.Position = UDim2.new(0,18,0,0)
            TweenService:Create(p.frame, TweenInfo.new(.28, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position=UDim2.new(0,0,0,0)}):Play()
        end
    end

    local Main = {}
    function Main.CreatePage(pageConfig)
        pageConfig=pageConfig or {}
        local pageName=pageConfig.Page_Name or pageConfig.Page_Title or "Page"
        local frame=make("ScrollingFrame", {Name=pageName, Position=UDim2.new(0,0,0,0), Size=UDim2.new(1,0,1,0), BackgroundTransparency=1, BorderSizePixel=0, ScrollBarThickness=3, ScrollBarImageColor3=C.gold, CanvasSize=UDim2.new()}, content)
        local padding=make("UIPadding", {PaddingTop=UDim.new(0,13),PaddingBottom=UDim.new(0,14),PaddingLeft=UDim.new(0,13),PaddingRight=UDim.new(0,13)}, frame)
        local layout=make("UIListLayout", {Padding=UDim.new(0,10),SortOrder=Enum.SortOrder.LayoutOrder}, frame)
        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() frame.CanvasSize=UDim2.new(0,0,0,layout.AbsoluteContentSize.Y+28) end)
        local p={name=pageName,frame=frame}
        pages[#pages+1]=p
        local navText = pageConfig.Page_Title or pageName
        local nb = make("TextButton", {Name="Nav", AutoButtonColor=false, BackgroundColor3=Color3.fromRGB(22,22,28), BackgroundTransparency=1, BorderSizePixel=0, Size=UDim2.new(1,0,0,42), Text=""}, nav)
        corner(nb, 8)
        local bar = make("Frame", {Name="Bar", Position=UDim2.new(0,0,0,7), Size=UDim2.new(0,3,1,-14), BackgroundColor3=GOLD, BorderSizePixel=0, Visible=false}, nb); corner(bar, 2)
            do local ic = drawIcon(nb, iconKind(navText)); tintIcon(ic, GRAY, 0.4) end
        make("TextLabel", {Name="Txt", BackgroundTransparency=1, Position=UDim2.new(0,46,0,0), Size=UDim2.new(1,-52,1,0), Text=navText, TextColor3=GRAY, Font=Enum.Font.Fantasy, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd}, nb)
        nb.MouseEnter:Connect(function() if not nb:GetAttribute("NexoraActive") then nb.BackgroundTransparency = 0.55 end end)
        nb.MouseLeave:Connect(function() if not nb:GetAttribute("NexoraActive") then nb.BackgroundTransparency = 1 end end)
        navButtons[p]=nb
        nb.MouseButton1Click:Connect(function() if activePage ~= p then sfxPlay("tab") end showPage(p) end)
        nb.LayoutOrder=#pages
        local Page={}
        function Page.CreateSection(sectionName)
            local card=make("Frame", {Name=sectionName, Size=UDim2.new(1,0,0,40), AutomaticSize=Enum.AutomaticSize.Y, BackgroundColor3=C.panel, BorderSizePixel=0}, frame)
            corner(card,10); stroke(card,C.line,0.35)
            make("UIPadding", {PaddingTop=UDim.new(0,11),PaddingBottom=UDim.new(0,11),PaddingLeft=UDim.new(0,11),PaddingRight=UDim.new(0,11)}, card)
            local list=make("UIListLayout", {Padding=UDim.new(0,7),SortOrder=Enum.SortOrder.LayoutOrder}, card)
            local head=make("TextLabel", {Size=UDim2.new(1,0,0,22),BackgroundTransparency=1,Text=sectionName,TextColor3=Color3.fromRGB(245,245,250),Font=Enum.Font.Fantasy,TextSize=12,TextXAlignment=Enum.TextXAlignment.Left},card)
            make("UIPadding", {PaddingLeft=UDim.new(0,10)}, head)
            do local hb=make("Frame", {Position=UDim2.new(0,-10,.5,-7),Size=UDim2.new(0,3,0,14),BackgroundColor3=C.gold,BorderSizePixel=0},head); corner(hb,2) end
            make("Frame", {Size=UDim2.new(1,0,0,1), BackgroundColor3=Color3.fromRGB(255,255,255), BackgroundTransparency=0.92, BorderSizePixel=0}, card)
            local Section={}
            local function row(height)
                return make("Frame", {Size=UDim2.new(1,0,0,height),BackgroundTransparency=1},card)
            end
            function Section.CreateToggle(cfg, callback)
                cfg=cfg or {}; local t=cfg.Title or "Toggle"
                -- Usa o arquivo de settings por jogador já existente.
                Settings = Settings or {}
                local savedToggle = Settings[t]
                local val
                if type(savedToggle) == "boolean" then val = savedToggle else val = (cfg.Default == true) end
                local r=row(35); local txt=label(make("Frame",{Size=UDim2.new(1,-62,1,0),BackgroundTransparency=1},r),t,12,C.text)
                local b=button(r,"",24); b:SetAttribute("NexoraKeepColor", true)
                b.Size=UDim2.new(0,44,0,24); b.Position=UDim2.new(1,-44,.5,-12)
                local bc=b:FindFirstChildOfClass("UICorner"); if bc then bc.CornerRadius = UDim.new(0, 22) end
                local bs=make("UIStroke",{Color=C.line,Thickness=1,Transparency=0.2},b)
                local knob=make("Frame",{Size=UDim2.new(0,18,0,18),Position=UDim2.new(0,3,.5,-9),BackgroundColor3=Color3.fromRGB(165,160,149),BorderSizePixel=0,ZIndex=2},b); corner(knob,9)
                local function paint(animate)
                    local goal={Position=val and UDim2.new(1,-21,.5,-9) or UDim2.new(0,3,.5,-9), BackgroundColor3=val and Color3.fromRGB(255,255,255) or Color3.fromRGB(165,160,149)}
                    local trackColor=val and C.gold or Color3.fromRGB(22,21,26)
                    bs.Color=val and C.goldLight or C.line
                    if animate then
                        TweenService:Create(knob,TweenInfo.new(.14),goal):Play()
                        TweenService:Create(b,TweenInfo.new(.14),{BackgroundColor3=trackColor}):Play()
                    else
                        knob.Position=goal.Position; knob.BackgroundColor3=goal.BackgroundColor3; b.BackgroundColor3=trackColor
                    end
                end
                paint(false)
                local opt=addOption(t,"toggle",val,pageName,sectionName,callback)
                local function applyToggle(v, fire)
                    val = not not v; opt.value=val; paint(true)
                    if fire then sfxPlay(val and "on" or "off") end
                    -- Persiste no mesmo formato/caminho do Settings original.
                    Settings[t] = val
                    pcall(function() SaveSettings(t, val) end)
                    if fire and callback then task.spawn(function() pcall(callback,val) end) end
                end
                opt._setValue = function(v) applyToggle(v, false) end
                b.MouseButton1Click:Connect(function() applyToggle(not val, true) end)
                -- A restauração das opções salvas roda ao final do carregamento (RestoreSavedToggles).
                return opt
            end
            function Section.CreateButton(cfg, callback)
                cfg=cfg or {}; local t=cfg.Title or "Button"; local b=button(card,t,34); b.TextColor3=C.goldLight; b.Font=Enum.Font.Fantasy; stroke(b,C.line,0.25); addOption(t,"button",false,pageName,sectionName,callback); b.MouseButton1Click:Connect(function() if callback then task.spawn(callback) end end); return b
            end
            function Section.CreateLabel(cfg)
                local t=type(cfg)=="table" and (cfg.Title or cfg.Text or "") or tostring(cfg or "")
                local r=row(28)
                local txt=label(r,t,11,C.muted)
                local handle={Object=txt}
                handle.SetText=function(value) txt.Text=tostring(value or "") end
                handle.GetText=function() return txt.Text end
                return handle
            end
            function Section.CreateSlider(cfg, callback)
                cfg=cfg or {}; local t=cfg.Title or "Slider"; local min=cfg.Min or cfg.MinValue or 0; local max=cfg.Max or cfg.MaxValue or 100; local val=math.clamp(cfg.Default or cfg.Value or min,min,max)
                local r=row(52); label(make("Frame",{Size=UDim2.new(1,-70,0,22),BackgroundTransparency=1},r),t,11,C.text)
                local num=label(make("Frame",{Position=UDim2.new(1,-65,0,0),Size=UDim2.new(0,65,0,22),BackgroundTransparency=1},r),val,11,Color3.fromRGB(0,140,255)); num.TextXAlignment=Enum.TextXAlignment.Right
                local bar=make("Frame",{Position=UDim2.new(0,0,0,30),Size=UDim2.new(1,0,0,6),BackgroundColor3=Color3.fromRGB(45,45,55),BorderSizePixel=0},r); corner(bar,10)
                local fill=make("Frame",{Size=UDim2.new((val-min)/math.max(1,max-min),0,1,0),BackgroundColor3=Color3.fromRGB(0,140,255),BorderSizePixel=0},bar); corner(fill,10)
                local knob=make("Frame",{AnchorPoint=Vector2.new(0.5,0.5),Position=UDim2.new((val-min)/math.max(1,max-min),0,0.5,0),Size=UDim2.fromOffset(14,14),BackgroundColor3=Color3.fromRGB(255,255,255),BorderSizePixel=0},bar); corner(knob,10)
                local hit=make("TextButton",{Size=UDim2.new(1,0,0,24),Position=UDim2.new(0,0,0,-9),BackgroundTransparency=1,Text="",TextTransparency=1},bar)
                local opt
                local function set(x) local ratio=math.clamp((x-bar.AbsolutePosition.X)/math.max(1,bar.AbsoluteSize.X),0,1); val=math.floor(min+(max-min)*ratio); fill.Size=UDim2.new(ratio,0,1,0); knob.Position=UDim2.new(ratio,0,0.5,0); num.Text=tostring(val); if opt then opt.value=val end; if callback then pcall(callback,val) end end
                opt=addOption(t,"slider",val,pageName,sectionName,callback)
                opt._setValue = function(v)
                    val = math.clamp(tonumber(v) or min, min, max)
                    local ratio = (val-min)/math.max(1,max-min)
                    fill.Size=UDim2.new(ratio,0,1,0); knob.Position=UDim2.new(ratio,0,0.5,0); num.Text=tostring(val)
                end
                hit.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then set(i.Position.X) end end)
                hit.InputChanged:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch then if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then set(i.Position.X) end end end)
                return opt
            end
            function Section.CreateDropdown(cfg, callback)
                cfg = cfg or {}
                local t = cfg.Title or "Dropdown"
                local rawList = cfg.List or cfg.Values or cfg.Options or {}
                local multi = cfg.Selected == true
                local listValues = {}
                local function rebuildList(src)
                    listValues = {}
                    if type(src) ~= "table" then return end
                    -- Multi-select sources pass a dictionary {name = enabled}; ordinary
                    -- dropdowns pass an array. Support both without losing dictionary keys.
                    if #src > 0 then
                        for _, value in ipairs(src) do table.insert(listValues, value) end
                    else
                        for key in pairs(src) do table.insert(listValues, key) end
                        table.sort(listValues, function(a,b) return tostring(a) < tostring(b) end)
                    end
                end
                rebuildList(rawList)
                local selected = cfg.Default
                if multi then
                    selected = type(selected) == "table" and table.clone(selected) or {}
                    for _, value in ipairs(listValues) do
                        if selected[value] == nil then selected[value] = type(rawList) == "table" and rawList[value] == true or false end
                    end
                else
                    selected = selected or "Select..."
                end
                local function displayValue()
                    if not multi then return tostring(selected) end
                    local chosen = {}
                    for _, value in ipairs(listValues) do if selected[value] then table.insert(chosen, tostring(value)) end end
                    if #chosen == 0 then return "None selected" end
                    local shown = table.concat(chosen, ", ")
                    return #shown > 32 and (string.sub(shown,1,29) .. "...") or shown
                end
                local b = button(card, t .. "  ·  " .. displayValue() .. "  ▾", 34)
                local opt = addOption(t, "dropdown", selected, pageName, sectionName, callback)
                local function refreshButton()
                    b.Text = t .. "  ·  " .. displayValue() .. "  ▾"
                    opt.value = selected
                end
                opt._setValue = function(v)
                    if multi then selected = type(v) == "table" and table.clone(v) or {} else selected = v end
                    refreshButton()
                end
                opt.GetNewList = function(_, newList)
                    rebuildList(newList or {})
                    if multi then
                        for _, value in ipairs(listValues) do if selected[value] == nil then selected[value] = false end end
                    elseif not table.find(listValues, selected) then
                        selected = "Select..."
                    end
                    refreshButton()
                end
                opt.SetList = opt.GetNewList
                b.MouseButton1Click:Connect(function()
                    local menuName = "NexoraDropdownOverlay"
                    local oldMenu = gui:FindFirstChild(menuName)
                    if oldMenu then
                        if oldMenu:GetAttribute("NexoraOwner") == t then oldMenu:Destroy(); return end
                        oldMenu:Destroy()
                    end
                    local vp = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize) or Vector2.new(800,600)
                    local h = math.max(35, math.min(210, #listValues * 29 + 8))
                    local bx, by = b.AbsolutePosition.X, b.AbsolutePosition.Y + b.AbsoluteSize.Y + 3
                    if by + h > vp.Y - 8 then by = math.max(8, b.AbsolutePosition.Y - h - 3) end
                    local w = math.clamp(math.max(180, b.AbsoluteSize.X), 180, math.max(180, vp.X - 8))
                    local x = math.clamp(b.AbsolutePosition.X, 4, math.max(4, vp.X - w - 4))
                    local menu = make("ScrollingFrame", {Name=menuName, Position=UDim2.fromOffset(x,by), Size=UDim2.fromOffset(w,h), CanvasSize=UDim2.new(0,0,0,0), ScrollBarThickness=4, ScrollBarImageColor3=C.gold, BackgroundColor3=C.bg, BorderSizePixel=0, ZIndex=100, Active=true}, gui)
                    menu:SetAttribute("NexoraOwner", t)
                    corner(menu,7); stroke(menu,C.line)
                    -- Close the dropdown when the user taps anywhere outside it.
                    local outsideConnection
                    outsideConnection = UIS.InputBegan:Connect(function(input, processed)
                        if processed then return end
                        if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end
                        task.defer(function()
                            if not menu or not menu.Parent then
                                if outsideConnection then outsideConnection:Disconnect() end
                                return
                            end
                            local p = input.Position
                            local mp, ms = menu.AbsolutePosition, menu.AbsoluteSize
                            local bp, bs = b.AbsolutePosition, b.AbsoluteSize
                            local insideMenu = p.X >= mp.X and p.X <= mp.X + ms.X and p.Y >= mp.Y and p.Y <= mp.Y + ms.Y
                            local insideButton = p.X >= bp.X and p.X <= bp.X + bs.X and p.Y >= bp.Y and p.Y <= bp.Y + bs.Y
                            if not insideMenu and not insideButton then menu:Destroy() end
                        end)
                    end)
                    menu.Destroying:Connect(function() if outsideConnection then outsideConnection:Disconnect() end end)
                    local lay = make("UIListLayout", {Padding=UDim.new(0,3),SortOrder=Enum.SortOrder.LayoutOrder}, menu)
                    make("UIPadding", {PaddingTop=UDim.new(0,4),PaddingBottom=UDim.new(0,4),PaddingLeft=UDim.new(0,4),PaddingRight=UDim.new(0,4)}, menu)
                    lay:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() menu.CanvasSize = UDim2.new(0,0,0,lay.AbsoluteContentSize.Y+8) end)
                    for index, value in ipairs(listValues) do
                        local isOn = multi and selected[value] == true
                        local optb = button(menu, (multi and (isOn and "✓  " or "□  ") or "") .. tostring(value), 27)
                        optb.ZIndex = 101; optb.LayoutOrder = index
                        if multi then
                            optb.BackgroundColor3 = isOn and C.gold or Color3.fromRGB(0,0,0)
                            optb.TextColor3 = Color3.fromRGB(255,255,255)
                            optb:SetAttribute("NexoraKeepColor", true)
                        end
                        optb.MouseButton1Click:Connect(function()
                            if multi then
                                selected[value] = not selected[value]
                                optb.Text = (selected[value] and "✓  " or "□  ") .. tostring(value)
                                optb.BackgroundColor3 = selected[value] and C.gold or Color3.fromRGB(0,0,0)
                                optb.TextColor3 = Color3.fromRGB(255,255,255)
                                refreshButton()
                                if callback then task.spawn(function() pcall(callback, value, selected[value]) end) end
                                -- Close after each choice; tap the dropdown again to choose another item.
                                menu:Destroy()
                            else
                                selected = value
                                refreshButton()
                                menu:Destroy()
                                if callback then task.spawn(function() pcall(callback, value) end) end
                            end
                        end)
                    end
                    if multi then
                        local done = button(menu, "Done", 27); done.LayoutOrder = #listValues + 1; done.ZIndex = 101
                        done.MouseButton1Click:Connect(function() menu:Destroy() end)
                    end
                end)
                return opt
            end
            function Section.CreateBox(cfg, callback)
                cfg = cfg or {}
                local t = cfg.Title or "Text input"
                local r = row(58)
                label(make("Frame", {Size=UDim2.new(1,0,0,20), BackgroundTransparency=1}, r), t, 11, C.text)
                local input = make("TextBox", {Position=UDim2.new(0,0,0,25), Size=UDim2.new(1,0,0,30), BackgroundColor3=C.bg, BorderSizePixel=0, Text=tostring(cfg.Default or ""), PlaceholderText=cfg.Placeholder or "Digite aqui...", TextColor3=C.text, PlaceholderColor3=C.muted, Font=Enum.Font.SourceSansBold, TextSize=11, ClearTextOnFocus=false}, r)
                corner(input, 7); stroke(input, C.line)
                local opt = addOption(t, "box", input.Text, pageName, sectionName, callback)
                local function setText(v, fire)
                    input.Text = tostring(v == nil and "" or v); opt.value = input.Text
                    if fire and callback then task.spawn(function() pcall(callback, input.Text) end) end
                end
                opt._setValue = function(v) setText(v, false) end
                opt.FunctionCreate.GetText = function() return input.Text end
                input.FocusLost:Connect(function() setText(input.Text, true) end)
                return opt
            end
            function Section.CreateNoti(text, duration)
                local note=make("TextLabel",{AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-15,1,-15),Size=UDim2.new(0,260,0,48),BackgroundColor3=C.panel,Text=tostring(text),TextColor3=C.text,Font=Enum.Font.SourceSansBold,TextSize=12,TextWrapped=true},gui); corner(note,8); stroke(note,C.gold,0); make("UIStroke", {Color=C.goldLight, Transparency=0.35, Thickness=2}, note); task.delay(duration or 3,function() if note then note:Destroy() end end); return note
            end
            return Section
        end
        return Page
    end
    function Main.CreateBind(config, callback)
        config = config or {}
        local key = config.Key or Enum.KeyCode.LeftControl
        local listening = false
        local bindGui = gui
        local MainBind = {}
        local conn = UIS.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode == key then
                if callback then task.spawn(function() pcall(callback) end) else bindGui.Enabled = not bindGui.Enabled end
            end
        end)
        MainBind.Disconnect = function() if conn then conn:Disconnect() end end
        MainBind.SetKey = function(v) key = v end
        return MainBind
    end
    Main.CreateNotification = function(payload)
        return Main.CreateNoti(payload)
    end
    local NotifContainer = nil
    local function getNotifContainer()
        if NotifContainer and NotifContainer.Parent then return NotifContainer end
        local cGui = parentGui:FindFirstChild("NexoraNotifs")
        if cGui then cGui:Destroy() end
        cGui = make("ScreenGui", {Name="NexoraNotifs", ResetOnSpawn=false, IgnoreGuiInset=true, DisplayOrder=1000, ZIndexBehavior=Enum.ZIndexBehavior.Sibling}, parentGui)
        NotifContainer = make("Frame", {Name="Container", AnchorPoint=Vector2.new(1,0), Position=UDim2.new(1,-12,0,12), Size=UDim2.new(0,320,1,-24), BackgroundTransparency=1}, cGui)
        make("UIListLayout", {FillDirection=Enum.FillDirection.Vertical, HorizontalAlignment=Enum.HorizontalAlignment.Right, VerticalAlignment=Enum.VerticalAlignment.Top, Padding=UDim.new(0,8), SortOrder=Enum.SortOrder.LayoutOrder}, NotifContainer)
        return NotifContainer
    end
    function Main.CreateNoti(text, duration)
        local title, desc
        if type(text) == "table" then
            duration = text.ShowTime or duration or 4
            title = tostring(text.Title or "NEXORA HUB")
            desc = tostring(text.Desc or text.Text or "")
        else
            duration = duration or 4
            title = "NEXORA HUB"
            desc = tostring(text)
        end
        local container = getNotifContainer()
        local card = make("Frame", {Name="Notif", BackgroundColor3=Color3.fromRGB(15,15,20), BorderSizePixel=0, Size=UDim2.new(0,310,0,72), ClipsDescendants=true}, container)
        corner(card, 14)
        local border = make("UIStroke", {Color=Color3.fromRGB(0,140,255), Thickness=1.2, Transparency=0.2, ApplyStrokeMode=Enum.ApplyStrokeMode.Border}, card)
        make("UIGradient", {Color=ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(25,25,35)), ColorSequenceKeypoint.new(1, Color3.fromRGB(12,12,18))}, Rotation=90}, card)
        local sideBar = make("Frame", {Name="SideBar", BackgroundColor3=Color3.fromRGB(0,140,255), BorderSizePixel=0, Size=UDim2.new(0,3,1,0)}, card)
        corner(sideBar, 2)
        make("UIGradient", {Color=ColorSequence.new(Color3.fromRGB(80,180,255), Color3.fromRGB(0,100,220)), Rotation=90}, sideBar)
        local iconBg = make("Frame", {BackgroundColor3=Color3.fromRGB(28,28,40), Size=UDim2.new(0,36,0,36), Position=UDim2.new(0,14,0,10), BorderSizePixel=0}, card)
        corner(iconBg, 10)
        make("UIStroke", {Color=Color3.fromRGB(0,140,255), Transparency=0.6, Thickness=1}, iconBg)
        local iconText = make("TextLabel", {BackgroundTransparency=1, Size=UDim2.new(1,0,1,0), Text="N", TextColor3=Color3.fromRGB(0,140,255), Font=Enum.Font.Arcade, TextSize=20}, iconBg)
        make("UIGradient", {Color=ColorSequence.new(Color3.fromRGB(80,180,255), Color3.fromRGB(0,140,255)), Rotation=90}, iconText)
        make("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(0,62,0,8), Size=UDim2.new(1,-70,0,18), Text=string.upper(title), TextColor3=Color3.fromRGB(255,255,255), Font=Enum.Font.Fantasy, TextSize=12, TextXAlignment=Enum.TextXAlignment.Left, TextTruncate=Enum.TextTruncate.AtEnd}, card)
        make("TextLabel", {BackgroundTransparency=1, Position=UDim2.new(0,62,0,28), Size=UDim2.new(1,-70,0,32), Text=desc, TextColor3=Color3.fromRGB(180,190,210), Font=Enum.Font.SourceSansBold, TextSize=11, TextXAlignment=Enum.TextXAlignment.Left, TextYAlignment=Enum.TextYAlignment.Top, TextWrapped=true}, card)
        local progressBg = make("Frame", {BackgroundColor3=Color3.fromRGB(30,30,40), BorderSizePixel=0, Size=UDim2.new(1,-16,0,2), Position=UDim2.new(0,8,1,-6)}, card)
        corner(progressBg, 1)
        local progressBar = make("Frame", {BackgroundColor3=Color3.fromRGB(0,140,255), BorderSizePixel=0, Size=UDim2.new(1,0,1,0)}, progressBg)
        corner(progressBar, 1)
        make("UIGradient", {Color=ColorSequence.new(Color3.fromRGB(80,180,255), Color3.fromRGB(0,100,220)), Rotation=0}, progressBar)
        card.Position = UDim2.new(0,340,0,0)
        card.Size = UDim2.new(0,310,0,0)
        TweenService:Create(card, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position=UDim2.new(0,0,0,0), Size=UDim2.new(0,310,0,72)}):Play()
        TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {Size=UDim2.new(0,0,1,0)}):Play()
        spawn(function()
            while card.Parent do
                TweenService:Create(border, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency=0.5}):Play()
                task.wait(1)
                TweenService:Create(border, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency=0.1}):Play()
                task.wait(1)
            end
        end)
        task.delay(duration, function()
            if card and card.Parent then
                TweenService:Create(card, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position=UDim2.new(0,340,0,0)}):Play()
                task.wait(0.3)
                if card then card:Destroy() end
            end
        end)
        return card
    end
    if pages[1] then showPage(pages[1]) end
    search:GetPropertyChangedSignal("Text"):Connect(function()
        local q=string.lower(search.Text)
        for _,p in ipairs(pages) do
            local has=false
            for _,d in ipairs(p.frame:GetDescendants()) do
                if d:IsA("TextLabel") or d:IsA("TextButton") then if string.find(string.lower(d.Text),q,1,true) then has=true end end
            end
            navButtons[p].Visible=(q=="" or has)
        end
    end)
    task.defer(playOpen)
    return Main
end

function Nexora.CreateNoti(config, duration)
    return Main.CreateNoti(config, duration)
end

function Nexora.RestoreSavedToggles()
    if getgenv().__NexoraRestoreDone then return end
    getgenv().__NexoraRestoreDone = true
    for _, opt in ipairs(Nexora.OptionOrder) do
        -- usa o estado real da UI (inclui toggles com Default = true ainda sem valor salvo)
        if opt and opt.type == "toggle" and opt.value == true then
            local control = opt.FunctionCreate
            if control and type(control.SetStage) == "function" then
                pcall(function() control:SetStage(true) end)
            elseif type(opt.Callback) == "function" then
                pcall(opt.Callback, true)
            end
            task.wait()
        end
    end
end
getgenv().__NexoraRestoreDone = false
-- fallback: se o script principal der erro antes do fim, restaura mesmo assim
task.delay(10, function() Nexora.RestoreSavedToggles() end)

return Nexora

end)()
Main = A.CreateMain({ Title = "NEXORA HUB", Desc = "BLOX FRUITS • ViniZDev" })

PageShop = Main.CreatePage({ Page_Name = "Shop", Page_Title = "Shop" })
getgenv().Options = A.Options
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
        A.CreateNoti({Title = "Nexora Hub", Desc = "You already have Draco Race", ShowTime = 5})
        return
    end

    local remote
    pcall(function()
        remote = game:GetService("ReplicatedStorage").Modules.Net:FindFirstChild("RF/InteractDragonQuest")
    end)
    if not remote then
        A.CreateNoti({Title = "Nexora Hub", Desc = "Draco purchase remote unavailable", ShowTime = 5})
        return
    end

    local ok, result = pcall(function()
        return remote:InvokeServer({NPC = "Dragon Wizard", Command = "DragonRace"})
    end)
    task.wait(0.5)
    if race and tostring(race.Value) == "Draco" then
        A.CreateNoti({Title = "Nexora Hub", Desc = "You Equipped Draco Race", ShowTime = 5})
    elseif not ok then
        A.CreateNoti({Title = "Nexora Hub", Desc = "Draco purchase request failed", ShowTime = 5})
    else
        A.CreateNoti({Title = "Nexora Hub", Desc = "Game may require Draco prerequisites", ShowTime = 5})
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
    local SectionPlayer = PageStatusAndServer.CreateSection("Player - State")
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
    
    local SectionNormal = PageStatusAndServer.CreateSection("Normal Fruit Stock - Normal Dealer")
    SectionNormal.CreateLabel({ Title = "Fruits on sale at the normal dealer" })
    local NormalLabels = {}
    NormalLabels[1] = SectionNormal.CreateLabel({ Title = "Ghost-Ghost - $940,000" })
    NormalLabels[2] = SectionNormal.CreateLabel({ Title = "Light-Light - $650,000" })
    NormalLabels[3] = SectionNormal.CreateLabel({ Title = "Spin-Spin - $7,500" })
    NormalLabels[4] = SectionNormal.CreateLabel({ Title = "Rocket-Rocket - $5,000" })
    NormalLabels[5] = SectionNormal.CreateLabel({ Title = "Loading..." })
    NormalLabels[6] = SectionNormal.CreateLabel({ Title = "Loading..." })
    
    local SectionAdvance = PageStatusAndServer.CreateSection("Advance Fruit Stock - Mirage Island Dealer")
    SectionAdvance.CreateLabel({ Title = "Fruits on sale at the Mirage Island dealer" })
    local AdvanceLabels = {}
    AdvanceLabels[1] = SectionAdvance.CreateLabel({ Title = "Flame-Flame - $250,000" })
    AdvanceLabels[2] = SectionAdvance.CreateLabel({ Title = "Smoke-Smoke - $100,000" })
    AdvanceLabels[3] = SectionAdvance.CreateLabel({ Title = "Bomb-Bomb - $80,000" })
    AdvanceLabels[4] = SectionAdvance.CreateLabel({ Title = "Spin-Spin - $7,500" })
    AdvanceLabels[5] = SectionAdvance.CreateLabel({ Title = "Rocket-Rocket - $5,000" })
    
    -- PATCH FIX: estoque 100% dinamico - usa lista real da loja
    local function ParseFruit(v)
        if type(v)=="table" then
            -- Blox Fruits retorna: {Name, Price, OnSale, InStock, etc}
            -- Só queremos frutas que dão pra comprar
            if v.OnSale == false then return nil, nil end
            if v.InStock == false then return nil, nil end
            if v.CanBuy == false then return nil, nil end
            -- Se tem campo Stock ou Amount e é 0, pula
            if v.Stock == 0 or v.Amount == 0 then return nil, nil end
            local n = v.Name or v[1] or v.name or v.FruitName
            local p = v.Price or v[2] or v.price or v.Cost or 0
            if n then return n, p end
        elseif type(v)=="string" then
            return v, 0
        end
        return nil, nil
    end
    local function FormatPrice(p)
        if not p or p==0 then return "" end
        local s = tostring(math.floor(p))
        return " - $" .. s:reverse():gsub("(%d%d%d)","%1,"):reverse():gsub("^,","")
    end
    local function Ensure(section, labels, need)
        for i=#labels+1, need do
            labels[i] = section.CreateLabel({ Title = "Slot "..i..": Loading..." })
        end
    end
    local function UpdateStock(section, labels, stock)
        if not stock or type(stock)~="table" then return end
        local list = {}
        if #stock>0 then list=stock else for k,v in pairs(stock) do if type(v)=="table" then table.insert(list,v) elseif type(k)=="string" then table.insert(list,{Name=k, Price=v}) end end end
        -- FILTRA SÓ AS QUE DÁ PRA COMPRAR
        local filtered = {}
        for _, v in ipairs(list) do
            local name, price = ParseFruit(v)
            if name then table.insert(filtered, {Name=name, Price=price, _raw=v}) end
        end
        if #filtered==0 then
            if labels[1] then labels[1].SetText("Nenhuma fruta no stock agora") end
            for i=2, #labels do if labels[i] then labels[i].SetText("Slot "..i..": Empty") end end
            return
        end
        Ensure(section, labels, #filtered)
        for i, data in ipairs(filtered) do
            if labels[i] then
                local disp = data.Name
                if not disp:find("-") then disp = disp.."-"..disp end
                labels[i].SetText(disp .. FormatPrice(data.Price))
            end
        end
        for i=#filtered+1, #labels do if labels[i] then labels[i].SetText("Slot "..i..": Empty") end end
    end

    spawn(function()
        while task.wait(2) do
            pcall(function()
                local normalStock = nil
                pcall(function() normalStock = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits", false) end)
                if not normalStock or type(normalStock)~="table" or #normalStock==0 then
                    pcall(function() normalStock = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits") end)
                end
                UpdateStock(SectionNormal, NormalLabels, normalStock)

                local mirageStock = nil
                pcall(function() mirageStock = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits", true) end)
                if not mirageStock or type(mirageStock)~="table" or #mirageStock==0 then
                    pcall(function() mirageStock = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetStock", "Mirage") end)
                end
                if not mirageStock or type(mirageStock)~="table" or #mirageStock==0 then
                    pcall(function() mirageStock = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("GetFruits", "Mirage") end)
                end
                UpdateStock(SectionAdvance, AdvanceLabels, mirageStock)
            end)
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
			for _, model in ipairs(container:GetChildren()) do
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

-- ===================== NOVA ABA: HOP OTHERS (SEPARADA) - CLICK UNICO =====================

-- Hop Others removido



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
			BORDER_HOV = Color3.fromRGB(0, 80, 120),
			CYAN = Color3.fromRGB(0, 212, 255),
			CYAN_DIM = Color3.fromRGB(0, 80, 120),
			GREEN = Color3.fromRGB(0, 204, 102),
			GREEN_GLOW = Color3.fromRGB(0, 255, 136),
			AMBER = Color3.fromRGB(255, 170, 0),
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
			Font = Enum.Font.Fantasy,
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
			Font = Enum.Font.SourceSansBold,
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
			Font = Enum.Font.Fantasy,
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
			BackgroundColor3 = Color3.fromRGB(11, 12, 17),
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
				Font = Enum.Font.SourceSansBold,
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
				BackgroundColor3 = Color3.fromRGB(14, 22, 40),
				BorderSizePixel = 0,
				Text = "REFRESH",
				TextColor3 = Color3.fromRGB(100, 140, 200),
				Font = Enum.Font.Fantasy,
				TextSize = 10,
			},
			f
		)
	L(3, y)
	K(y, Color3.fromRGB(14, 22, 40), Color3.fromRGB(10, 30, 55))
	local x = S(
		"TextButton",
		{
			Size = UDim2.new(0, 82, 0, 26),
			Position = UDim2.new(1, -182, 0.5, -13),
			BackgroundColor3 = Color3.fromRGB(16, 32, 24),
			BorderSizePixel = 0,
			Text = "LOAD MORE",
			TextColor3 = Q.GREEN,
			Font = Enum.Font.Fantasy,
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
			Font = Enum.Font.Fantasy,
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
			BackgroundColor3 = Color3.fromRGB(11, 12, 17),
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
				Font = Enum.Font.Fantasy,
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
				Font = Enum.Font.SourceSansBold,
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
				Font = Enum.Font.SourceSansBold,
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
				Font = Enum.Font.Fantasy,
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
			Font = Enum.Font.Fantasy,
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
			Font = Enum.Font.Fantasy,
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
				Font = Enum.Font.Fantasy,
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
				Font = Enum.Font.SourceSansBold,
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
				Font = Enum.Font.Fantasy,
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
				Font = Enum.Font.Fantasy,
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
				Font = Enum.Font.Fantasy,
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
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	local TeleportService = game:GetService("TeleportService")
	local player = Players.LocalPlayer
	local placeId = game.PlaceId
	local jobId = game.JobId
	pcall(function()
		require(ReplicatedStorage.Notification)
			.new("<Color=Red>Nexora Hub : Rejoining current server...<Color=/>")
			:Display()
	end)
	-- Prioriza o browser remoto do próprio jogo, já utilizado pelo botão Join JobId.
	-- Isso evita alguns erros de "Local restricted" gerados pelo teleport local do executor.
	local remote = ReplicatedStorage:FindFirstChild("__ServerBrowser")
	if remote then
		local ok = pcall(function()
			remote:InvokeServer("teleport", jobId)
		end)
		if ok then return end
	end
	-- Fallback: solicita o retorno ao mesmo JobId pela API oficial.
	local ok = pcall(function()
		TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
	end)
	if ok then return end
	-- Último recurso: tenta reentrar no place; Roblox pode escolher outro servidor.
	pcall(function()
		TeleportService:Teleport(placeId, player)
	end)
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
local EliteHunterNames = { "Deandre", "Urban", "Diablo" }
function DetectEliteHunter()
    -- Só considera NPCs vivos realmente carregados no Workspace; modelos em
    -- ReplicatedStorage costumam ser templates e causavam falso positivo.
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    local function isEliteModel(model)
        if not model or not model:IsA("Model") or not IsMobAlive(model) then return false end
        local name = string.lower(tostring(model.Name))
        local display = ""
        pcall(function() display = string.lower(tostring(model:GetAttribute("DisplayName") or "")) end)
        for _, eliteName in ipairs(EliteHunterNames) do
            local wanted = string.lower(eliteName)
            if name == wanted or string.find(name, wanted, 1, true) or string.find(display, wanted, 1, true) then
                return true
            end
        end
        return false
    end
    for _, model in ipairs(enemies:GetChildren()) do
        if isEliteModel(model) then return model end
    end
    for _, model in ipairs(enemies:GetDescendants()) do
        if isEliteModel(model) then return model end
    end
    return nil
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
spawn(function()
	while wait(0.25) do
		local R, R = pcall(function()
			local m = game.workspace.DistributedGameTime
			local E, l, Q = m % 60, math.floor(m / 60 % 60), math.floor(m / 3600)
			TimerLabel.SetText(string.format("Timer: %.0fh %.0fm %.0fs", Q, l, E))
			l = GetOldestLocation()
			if l then
				Q = l:GetAttribute("TimeIn")
				E, m = tick() - 25200 - Q, 14400
				math.floor(E / m)
				local S = m - E % m
				local m, L, d, I, _, o =
					math.floor(S / 3600),
					math.floor(S % 3600 / 60),
					math.floor(S % 60),
					math.floor(E / 3600),
					math.floor(E % 3600 / 60),
					math.floor(E % 60)
				TimerServerLabel.SetText(string.format("Server Timer: %.0fh %.0fm %.0fs", I, _, o))
				NextTimerServerLabel.SetText(
					string.format("Next Time Spawn Fist of Darkness or God's Chalice: %.0fh %.0fm %.0fs", m, L, d)
				)
				if tonumber(m) == 0 and tonumber(L) == 0 and tonumber(d) <= 5 then
					getgenv().GoCollectChest = true
				end
			end
			if DetectEliteHunter() then
				StatusEliteHunter.SetText("Elite Hunter: 🟢")
			else
				StatusEliteHunter.SetText("Elite Hunter: 🔴")
			end
			if game.PlaceId == getgenv().CheckPlaceId then
				K = 0
				Q = workspace.Map:FindFirstChild("TikiOutpost") and workspace.Map.TikiOutpost.IslandModel
				if Q then
					l = {}
					for m = 1, 4, 1 do
						E = Q:FindFirstChild("Eye" .. m, true)
						if E then
							table.insert(l, E)
						end
					end
					for m, Q in ipairs(l) do
						m = Q.Transparency == 1 and K < 4
						if m then
							K += 1
						end
					end
				end
			end
			StatusTyrant.SetText("Tyrant Eyes: " .. tostring(K) .. " Eyes")
			E = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner", true) or ""
			if E and (E:find("open the portal now")) then
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
			end
			StatusKatakuri.SetText("Cake Prince: " .. string.gsub(E, "%D", "") .. " Mobs")
			Statusspy.SetText("Leviathan: " .. StatusCheckLeviathan())
			if workspace.Map:FindFirstChild("MysticIsland") then
				StatusMirage.SetText("Mirage Island: 🟢")
			else
				StatusMirage.SetText("Mirage Island: 🔴")
			end
			do
				local kitsuneOn = false
				pcall(function()
					kitsuneOn = workspace.Map:FindFirstChild("KitsuneIsland") ~= nil
						or workspace._WorldOrigin.Locations:FindFirstChild("Kitsune Island") ~= nil
				end)
				if kitsuneOn then
					StatusKitsuneIsland.SetText("Kitsune Island: 🟢")
				else
					StatusKitsuneIsland.SetText("Kitsune Island: 🔴")
				end
			end
			if not workspace.Map:FindFirstChild("PrehistoricIsland") then
				StatusPrehistoricIsland.SetText("Prehistoric Island: 🔴")
			else
				StatusPrehistoricIsland.SetText("Prehistoric Island: 🟢")
			end
			if not workspace._WorldOrigin.Locations:FindFirstChild("Frozen Dimension") then
				StatusFrozenDimension.SetText("Frozen Dimension: 🔴")
			else
				StatusFrozenDimension.SetText("Frozen Dimension: 🟢")
			end
			StatusGear.SetText("Ancient One: " .. CheckAcientOneStatus())
			if getgenv().StatusGearDraco then
				getgenv().StatusGearDraco.SetText("Draco: " .. CheckAcientOneDracoStatus())
			end
			StatusMoon.SetText("Moon Phase: " .. CheckMoon() .. " | " .. function8())
		end)
	end
end)
-- Status And Server resilient updater: each label is isolated so one failed remote/helper
-- cannot stop all status values from refreshing.
task.spawn(function()
    local Players = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local function safeSet(label, value)
        pcall(function() if label and label.SetText then label.SetText(tostring(value)) end end)
    end
    local function hasPath(root, path)
        local obj = root
        for _, part in ipairs(path) do
            if not obj then return false end
            obj = obj:FindFirstChild(part)
        end
        return obj ~= nil
    end
    while task.wait(1) do
        pcall(function()
            safeSet(TimerLabel, string.format("Timer: %.0fh %.0fm %.0fs", math.floor(Workspace.DistributedGameTime/3600), math.floor(Workspace.DistributedGameTime/60)%60, math.floor(Workspace.DistributedGameTime)%60))
        end)
        pcall(function()
            local found = DetectEliteHunter()
            safeSet(StatusEliteHunter, "Elite Hunter: " .. (found and "🟢" or "🔴"))
        end)
        pcall(function()
            local count = 0
            local map = Workspace:FindFirstChild("Map")
            local tiki = map and map:FindFirstChild("TikiOutpost")
            local island = tiki and tiki:FindFirstChild("IslandModel")
            if island then
                for i=1,4 do
                    local eye = island:FindFirstChild("Eye"..i, true)
                    if eye and eye.Transparency == 1 then count += 1 end
                end
            end
            safeSet(StatusTyrant, "Tyrant Eyes: "..count.." Eyes")
        end)
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild("Remotes")
            local comm = remotes and remotes:FindFirstChild("CommF_")
            if comm then
                local result = comm:InvokeServer("CakePrinceSpawner", true)
                if type(result) ~= "string" then result = tostring(result or "") end
                safeSet(StatusKatakuri, "Cake Prince: " .. string.gsub(result, "%D", "") .. " Mobs")
            end
        end)
        pcall(function() safeSet(Statusspy, "Leviathan: " .. tostring(StatusCheckLeviathan())) end)
        pcall(function()
            local map = Workspace:FindFirstChild("Map")
            local world = Workspace:FindFirstChild("_WorldOrigin")
            local locations = world and world:FindFirstChild("Locations")
            local on = (map and (map:FindFirstChild("MysticIsland") or map:FindFirstChild("MirageIsland"))) or (locations and locations:FindFirstChild("Mirage Island"))
            safeSet(StatusMirage, "Mirage Island: " .. (on and "🟢" or "🔴"))
        end)
        pcall(function()
            local map = Workspace:FindFirstChild("Map")
            local world = Workspace:FindFirstChild("_WorldOrigin")
            local locations = world and world:FindFirstChild("Locations")
            local on = (map and (map:FindFirstChild("KitsuneIsland", true) or map:FindFirstChild("Kitsune Island", true)))
                or (locations and (locations:FindFirstChild("Kitsune Island", true) or locations:FindFirstChild("KitsuneIsland", true)))
            safeSet(StatusKitsuneIsland, "Kitsune Island: " .. (on and "🟢" or "🔴"))
        end)
        pcall(function()
            local map = Workspace:FindFirstChild("Map")
            local world = Workspace:FindFirstChild("_WorldOrigin")
            local locations = world and world:FindFirstChild("Locations")
            local on = (map and (map:FindFirstChild("PrehistoricIsland", true) or map:FindFirstChild("Prehistoric Island", true)))
                or (locations and (locations:FindFirstChild("Prehistoric Island", true) or locations:FindFirstChild("PrehistoricIsland", true)))
            safeSet(StatusPrehistoricIsland, "Prehistoric Island: " .. (on and "🟢" or "🔴"))
        end)
        pcall(function()
            local world = Workspace:FindFirstChild("_WorldOrigin")
            local locations = world and world:FindFirstChild("Locations")
            local map = Workspace:FindFirstChild("Map")
            local on = (locations and (locations:FindFirstChild("Frozen Dimension", true) or locations:FindFirstChild("FrozenDimension", true)))
                or (map and (map:FindFirstChild("Frozen Dimension", true) or map:FindFirstChild("FrozenDimension", true)))
            safeSet(StatusFrozenDimension, "Frozen Dimension: " .. (on and "🟢" or "🔴"))
        end)
        pcall(function()
            safeSet(StatusMoon, "Moon Phase: " .. tostring(CheckMoon()) .. " | " .. tostring(function8()))
        end)
        pcall(function() safeSet(StatusGear, "Ancient One: " .. tostring(CheckAcientOneStatus())) end)
        pcall(function()
            local locations = Workspace:FindFirstChild("_WorldOrigin") and Workspace._WorldOrigin:FindFirstChild("Locations")
            local oldest = nil
            if type(GetOldestLocation) == "function" then oldest = GetOldestLocation() end
            if oldest then
                local timeIn = oldest:GetAttribute("TimeIn")
                if type(timeIn) == "number" then
                    local elapsed = math.max(0, tick() - 25200 - timeIn)
                    local nextSpawn = 14400 - (elapsed % 14400)
                    safeSet(TimerServerLabel, string.format("Server Timer: %.0fh %.0fm %.0fs", math.floor(elapsed/3600), math.floor(elapsed/60)%60, math.floor(elapsed)%60))
                    safeSet(NextTimerServerLabel, string.format("Next Time Spawn Fist of Darkness or God's Chalice: %.0fh %.0fm %.0fs", math.floor(nextSpawn/3600), math.floor(nextSpawn/60)%60, math.floor(nextSpawn)%60))
                end
            end
        end)
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
			L.Font = Enum.Font.Fantasy
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
SectionLocalPlayerMain.CreateToggle({ Title = "No collision Player", Desc = "Deixa o player sem colisao", Default = Settings["No collision Player"] == nil and true or Settings["No collision Player"], }, function(K)
	SaveSettings("No collision Player", K)
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
	K.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
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


function SetNoClip(enable)
	getgenv().noclip = enable
	local Char = t.Character
	if not Char then
		return
	end
	local Root, Hum = Char:FindFirstChild("HumanoidRootPart"), Char:FindFirstChildOfClass("Humanoid")
	if not enable then
		-- FIX BUG: variavel l,l shadow bug, corrigido pra idx, part
		for _, part in ipairs(Char:GetDescendants()) do
			if part:IsA("BasePart") then
				pcall(function() part.CanCollide = true end)
			end
		end
		if Hum then
			pcall(function() Hum.PlatformStand = false end)
		end
		if Root then
			pcall(function()
				local ff = Root:FindFirstChild("FloatForce")
				if ff and not ToggleNoclip() then
					ff:Destroy()
				end
			end)
		end
	end
end
function ToggleNoclip()
	-- FIX: protecao se Settings ou g nao existir
	if not Settings then
		return getgenv().noclip or false
	end
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
-- Character + equipped Tool noclip enforcement (FIX: nao bater nas paredes).
do
    task.spawn(function()
        while task.wait(0.1) do
            -- FIX: pcall pra nao quebrar se ToggleNoclip der erro
            local shouldNoclip = false
            pcall(function()
                shouldNoclip = ToggleNoclip()
            end)
            if shouldNoclip then
                local Character = t.Character
                if Character then
                    for _, Part in ipairs(Character:GetDescendants()) do
                        if Part:IsA("BasePart") then
                            -- FIX: nao mexer em HumanoidRootPart se tiver FloatForce? Deixa sem colisao mesmo
                            pcall(function()
                                Part.CanCollide = false
                            end)
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
    if typeof(P) ~= "CFrame" then return end
    local Y = t.Character
    if not Y or not Y:FindFirstChild("HumanoidRootPart") then return end
    local H, Z = Y.HumanoidRootPart, Y:FindFirstChildOfClass("Humanoid")
    if not Z then return end

    local shouldUsePortal = false
    local bestPortal = nil

    pcall(function()
        do return end -- PORTAL REMOVIDO
        if Settings and Settings["Use Portals"] == false then return end
        local myPos = H.Position
        local targetPos = P.Position
        local direct = (targetPos - myPos).Magnitude
        if direct < 2500 then return end

        -- POSICOES REAIS PESQUISADAS
        local islandExit = {
            Castle = Vector3.new(-5084, 314, -3150),
            Mansion = Vector3.new(-12462, 375, -7524),
            Hydra = Vector3.new(5541, 668, 195),
            Tiki = Vector3.new(-16545, 430, -210),
        }

        local function GetIsland(pos)
            local best = "Sea"
            local bestDist = 9e9
            for name, ipos in pairs(islandExit) do
                local d = (pos - ipos).Magnitude
                if d < bestDist then bestDist = d best = name end
            end
            if bestDist < 6000 then return best, bestDist else return "Sea", bestDist end
        end

        local myIsland, myDist = GetIsland(myPos)
        local targetIsland, targetDist = GetIsland(targetPos)

        -- JA PERTO: NAO USA PORTAL
        if myIsland ~= "Sea" and targetIsland ~= "Sea" and myIsland == targetIsland then return end

        -- PORTAIS OFICIAIS DO WIKI:
        -- Castle: 3 portais na casa de telhado azul a esquerda do castelo principal
        --   Esquerda LARANJA = Tiki, Meio = Mansion, Direita = Hydra
        -- Mansion: Lado esquerdo da varanda interior, quase na parede frontal
        -- Tiki: Na frente do porto, oposto ao spawn/safe zone
        -- Hydra: Topo da montanha no centro da ilha, esquerda do predio do Hydra Leader

        local portals = {
            CastleToMansion = {Name="Castle->Mansion", EntryPos=Vector3.new(-5084, 314, -3150), ExitPos=Vector3.new(-12462, 375, -7524), Dest="Mansion"},
            CastleToHydra = {Name="Castle->Hydra", EntryPos=Vector3.new(-5144, 314, -3151), ExitPos=Vector3.new(5541, 668, 195), Dest="Hydra"},
            CastleToTiki = {Name="Castle->Tiki", EntryPos=Vector3.new(-5008, 314, -3151), ExitPos=Vector3.new(-16545, 430, -210), Dest="Tiki"},
            MansionToCastle = {Name="Mansion->Castle", EntryPos=Vector3.new(-12462, 375, -7524), ExitPos=Vector3.new(-5084, 314, -3150), Dest="Castle"},
            HydraToCastle = {Name="Hydra->Castle", EntryPos=Vector3.new(5541, 668, 195), ExitPos=Vector3.new(-5144, 314, -3151), Dest="Castle"},
            TikiToCastle = {Name="Tiki->Castle", EntryPos=Vector3.new(-16545, 430, -210), ExitPos=Vector3.new(-5008, 314, -3151), Dest="Castle"},
        }

        if myIsland == "Tiki" and targetIsland ~= "Tiki" then bestPortal = portals.TikiToCastle
        elseif myIsland == "Mansion" and targetIsland ~= "Mansion" then bestPortal = portals.MansionToCastle
        elseif myIsland == "Hydra" and targetIsland ~= "Hydra" then bestPortal = portals.HydraToCastle
        elseif myIsland == "Castle" then
            -- Escolhe pelo destino mais proximo
            local distMansion = (targetPos - islandExit.Mansion).Magnitude
            local distHydra = (targetPos - islandExit.Hydra).Magnitude
            local distTiki = (targetPos - islandExit.Tiki).Magnitude
            local minDist = math.min(distMansion, distHydra, distTiki)
            if minDist > 6500 then return end
            if minDist == distMansion then bestPortal = portals.CastleToMansion
            elseif minDist == distHydra then bestPortal = portals.CastleToHydra
            elseif minDist == distTiki then bestPortal = portals.CastleToTiki
            end
        end

        if bestPortal then
            shouldUsePortal = false -- REMOVIDO
            warn("[Nexora Portal] "..myIsland.." -> "..bestPortal.Dest.." = "..bestPortal.Name)
        end
    end)

    if shouldUsePortal and bestPortal then
        pcall(function() TweenManager.CancelCurrent() end)
        local realPart = nil
        local realPos = bestPortal.EntryPos
        pcall(function()
            local closest = 9e9
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and v:FindFirstChildOfClass("TouchTransmitter") then
                    local d = (v.Position - bestPortal.EntryPos).Magnitude
                    if d < 300 and d < closest then closest = d realPart = v realPos = v.Position end
                end
            end
        end)

        local t0 = tick()
        repeat H.CFrame = CFrame.new(realPos + Vector3.new(0,5,0)) H.AssemblyLinearVelocity = Vector3.new(0,0,0) task.wait(0.15) until (H.Position - realPos).Magnitude < 15 or tick()-t0 > 10

        local oldPos = H.Position
        local start = tick()
        while tick() - start < 3 do
            H.CFrame = CFrame.new(realPos + Vector3.new(0,3,0)) H.AssemblyLinearVelocity = Vector3.new(0,0,0)
            if realPart then pcall(function() firetouchinterest(H, realPart, 0) task.wait(0.05) firetouchinterest(H, realPart, 1) end) end
            task.wait(0.1)
            if (H.Position - oldPos).Magnitude > 500 then break end
        end

        local t1 = tick()
        repeat task.wait(0.1) until (H.Position - oldPos).Magnitude > 500 or tick()-t1 > 8
        if (H.Position - oldPos).Magnitude < 500 then H.CFrame = CFrame.new(bestPortal.ExitPos + Vector3.new(0,15,0)) task.wait(0.5) end
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
	-- FIX SEA EVENT: 1 click por segundo mas remotes triplos e AimPos
	local now = os.clock()
	if now - (getgenv().__DragonStormSpamLast or 0) < 1 then
		return
	end
	getgenv().__DragonStormSpamLast = now
	local reloading = false
	pcall(function()
		reloading = require(m.CombatUtil):IsGunReloading(d)
	end)
	if reloading then
		return
	end
	-- AimPos pra Sea Event
	pcall(function()
		getgenv().AimPos = CFrame.new(E.Position)
	end)
	-- REMOTES MELHORES SEA EVENT: Validator + ShootGunEvent + TAP + Activate
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
		-- 2x Validator pra garantir
		L.Remotes.Validator2:FireServer(math.floor(d2 / V * 16777215), P)
		L.Remotes.Validator2:FireServer(math.floor(d2 / V * 16777215), P + 1)
	end)
	pcall(function()
		local net = m.Net:FindFirstChild("RE/ShootGunEvent")
		if net then
			-- 3x tiro pra Sea Event (mais dano)
			for i = 1, 3 do
				net:FireServer(E.Position, { E })
				task.wait(0.05)
			end
		end
	end)
	pcall(function()
		local remote = d:FindFirstChild("RemoteEvent")
		if remote then
			for i = 1, 2 do
				remote:FireServer("TAP", E.Position)
				task.wait(0.05)
			end
		end
	end)
	pcall(function()
		d:Activate()
		task.wait(0.05)
		d:Activate()
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
function DragonstormPhysicalClick(force, toolName)
	toolName = toolName or "Dragonstorm"
	local now = os.clock()
	local lastKey = "__PhysicalClickLast_" .. tostring(toolName)
	local interval = getgenv().PhysicalGunClickInterval or getgenv().DSClickInterval or 1
	if not force and now - (getgenv()[lastKey] or 0) < interval then
		return false
	end
	getgenv()[lastKey] = now
	task.spawn(function()
		pcall(function()
			local Camera = workspace.CurrentCamera
			if not Camera then return end
			local vp = Camera.ViewportSize
			local x, y = math.floor(vp.X / 2), 2
			local VIM = game:GetService("VirtualInputManager")
			-- 1 CLICK POR SEGUNDO SEA EVENT
			VIM:SendMouseMoveEvent(x, y, game)
			task.wait(0.03)
			VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
			task.wait(0.05)
			VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
			pcall(function()
				local tx, ty = x, math.max(64, math.floor(vp.Y * 0.12))
				VIM:SendTouchEvent(1, 0, tx, ty)
				task.wait(0.05)
				VIM:SendTouchEvent(1, 2, tx, ty)
			end)
			pcall(function()
				local tool = t.Character and t.Character:FindFirstChild(toolName)
				if tool then tool:Activate() end
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
	-- Reutiliza o clique físico da Dragonstorm, ativando a Skull Guitar.
	if DragonstormPhysicalClick then
		DragonstormPhysicalClick(false, "Skull Guitar")
	end
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
-- Use Portals removido

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
-- ==================== USE SKILLS VASES TYRANT - USA FARM ORIGINAL ====================
-- SO adiciona a secao e o ataque com skill, NAO mexe no caminho do Farm original!
-- Farm original continua igual: ele decide quando ir pros vasos, quando matar Skull Slayers, etc.
-- Use Skills SO troca o ATAQUE quando o farm original ja esta no vaso!
-- Se Use Skills OFF -> farm original 100% igual, sem nenhuma mudanca!
-- FIX SAVE MULTI: Se Settings antigo era string "Z"/"X", converte pra tabela {Z=true} ou {X=true}
if type(Settings["Select Skills Skull Guitar"]) == "string" then
    local old = Settings["Select Skills Skull Guitar"]
    if old == "Z" then Settings["Select Skills Skull Guitar"] = {Z = true, X = false}
    elseif old == "X" then Settings["Select Skills Skull Guitar"] = {Z = false, X = true}
    else Settings["Select Skills Skull Guitar"] = {Z = true, X = true} end
    SaveSettings("Select Skills Skull Guitar", "Z", Settings["Select Skills Skull Guitar"].Z)
    SaveSettings("Select Skills Skull Guitar", "X", Settings["Select Skills Skull Guitar"].X)
end
if type(Settings["Select Skills Skull Guitar"]) ~= "table" then
    Settings["Select Skills Skull Guitar"] = {Z = true, X = true}
end
-- Garante que pelo menos uma skill esta marcada (padrao Z e X ligados)
if Settings["Select Skills Skull Guitar"].Z == nil and Settings["Select Skills Skull Guitar"].X == nil then
    Settings["Select Skills Skull Guitar"] = {Z = true, X = true}
end
if Settings["Select Skills Skull Guitar"].Z == nil then Settings["Select Skills Skull Guitar"].Z = true end
if Settings["Select Skills Skull Guitar"].X == nil then Settings["Select Skills Skull Guitar"].X = true end
if Settings["Use Skills"] == nil then Settings["Use Skills"] = true end
getgenv().UseSkills = Settings["Use Skills"]
getgenv().UseSkillsSelected = Settings["Select Skills Skull Guitar"] -- Tabela {Z=true, X=true}
SelectSkillsUseSkillsSection = SettingSkillMain.CreateSection("Use Skills Vases Tyrant")
-- MULTI-SELECT Z,X: Pode marcar as duas ao mesmo tempo!
-- Igual Select Skills Melee/Sword/Gun la em cima: usa tabela {Z=true, X=true}
SelectSkillsUseSkillsSection.CreateDropdown(
    { Title = "Select Skills Skull Guitar", List = PrepareMultiSelectList({Z = false, X = false}, Settings["Select Skills Skull Guitar"], true), Search = true, Selected = true, Default = Settings["Select Skills Skull Guitar"] or nil },
    function(key, val)
        -- key = "Z" ou "X", val = true/false (marcado ou nao)
        SaveSettings("Select Skills Skull Guitar", key, val)
        getgenv().UseSkillsSelected = Settings["Select Skills Skull Guitar"]
        pcall(function() writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings)) end)
        print("[Tyrant] Select Skills Skull Guitar SAVE: " .. tostring(key) .. " = " .. tostring(val))
    end
)
SelectSkillsUseSkillsSection.CreateToggle(
    { Title = "Use Skills", Desc = nil, Default = Settings["Use Skills"] },
    function(b)
        SaveSettings("Use Skills", b)
        getgenv().UseSkills = b
        pcall(function() writefile(FolderName .. "/" .. SaveFileName, HttpService:JSONEncode(Settings)) end)
    end
)
-- Funcao SO de ataque com skill, NAO teleporta, NAO decide ir pros vasos!
-- Farm original ja faz toTarget, essa funcao so e chamada DENTRO do farm original quando ele ja esta no vaso
getgenv().UseSkullGuitarSkillAttack = function(hitPart)
    if not getgenv().UseSkills then return false end
    if not Settings or not Settings["Use Skills"] then return false end
    -- MULTI-SELECT: Usa Z e X se os dois estiverem marcados!
    local tbl = Settings["Select Skills Skull Guitar"] or getgenv().UseSkillsSelected or {Z = true, X = true}
    -- Se tbl for string antiga "Z"/"X", converte
    if type(tbl) == "string" then
        if tbl == "Z" then tbl = {Z = true, X = false}
        elseif tbl == "X" then tbl = {Z = false, X = true}
        else tbl = {Z = true, X = true} end
    end
    local vim = game:GetService("VirtualInputManager")
    local km = {Z=Enum.KeyCode.Z, X=Enum.KeyCode.X}
    local used = false
    -- MAIS RAPIDO: Delays curtos pra quebrar vaso rapido!
    -- Antes: 0.08 + 0.1 + 0.5 = 0.68s por skill (lento!)
    -- Agora: 0.03 + 0.03 + 0.05 = 0.11s por skill (bem mais rapido!)
    if tbl.Z then
        local kc = km.Z
        vim:SendKeyEvent(true, kc, false, game)
        task.wait(0.03)
        vim:SendKeyEvent(false, kc, false, game)
        task.wait(0.03)
        local char = game:GetService("Players").LocalPlayer.Character
        local tool = char and char:FindFirstChild("Skull Guitar")
        if tool then tool:Activate() end
        used = true
        task.wait(0.05)
    end
    if tbl.X then
        local kc = km.X
        vim:SendKeyEvent(true, kc, false, game)
        task.wait(0.03)
        vim:SendKeyEvent(false, kc, false, game)
        task.wait(0.03)
        local char = game:GetService("Players").LocalPlayer.Character
        local tool = char and char:FindFirstChild("Skull Guitar")
        if tool then tool:Activate() end
        used = true
        task.wait(0.05)
    end
    return used
end
-- ==================== FIM USE SKILLS ====================
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
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Start Farm Plz", ShowTime = 5 })
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
		if not t.Character:FindFirstChild("DiamondBody") then
			B(J)
			return
		end
	elseif J == "Falcon-Falcon" then
		if not t.Character:FindFirstChild("FalconWings") then
			B(J)
			return
		end
	end
	C = H(F)
	if C then
		V, J = Settings["Skill " .. C .. " " .. F.ToolTip] or 0.5, game:GetService("VirtualInputManager")
		J:SendKeyEvent(true, C, false, game)
		if Settings["Use skill fast dont hold"] then
			task.wait(0.05)
		else
			task.wait(V)
		end
		J:SendKeyEvent(false, C, false, game)
	end
end
getgenv().StackFarm = true
getgenv().StackFarmOther = true
StackFarm = getgenv().StackFarm
StackFarmOther = getgenv().StackFarmOther
function DetectMobAura()
	local distance = typeof(Settings["Distance Farm Aura"]) ~= "number" and tonumber(Settings["Distance Farm Aura"]) or Settings["Distance Farm Aura"] or 300
	local closestDist = distance
	local closestName = nil
	for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
		if IsMobAlive(mob) and mob:FindFirstChild("HumanoidRootPart") then
			local dist = (mob.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if dist < closestDist then
				closestDist = dist
				closestName = mob.Name
			end
		end
	end
	return closestName
end

function DetectMobsAuraNear()
	local distance = typeof(Settings["Distance Farm Aura"]) ~= "number" and tonumber(Settings["Distance Farm Aura"]) or Settings["Distance Farm Aura"] or 300
	local mobsNear = {}
	for _, mob in pairs(game.Workspace.Enemies:GetChildren()) do
		if IsMobAlive(mob) and mob:FindFirstChild("HumanoidRootPart") then
			local dist = (mob.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
			if dist <= distance then
				table.insert(mobsNear, mob)
			end
		end
	end
	table.sort(mobsNear, function(a,b)
		local distA = (a.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
		local distB = (b.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
		return distA < distB
	end)
	return mobsNear
end
getgenv().StackFarm = true
getgenv().YPosFruit = 20
function CheckCDSkillTransformation(V, H)
	local B, C, J = next, game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills[V.Name]:GetChildren()
	for F, F in B, C, J do
		if F:IsA("Frame") then
			if
				F.Name ~= "Template"
					and not string.find(F.Title.Text, "Transformation")
					and H[F.Name]
					and F.Title.TextColor3 == Color3.new(1, 1, 1)
					and F.Cooldown.Size == UDim2.new(0, 0, 1, -1)
				or F.Cooldown.Size == UDim2.new(1, 0, 1, -1)
			then
				return F, Settings["Skill " .. F.Name .. " " .. V.ToolTip]
			end
		end
	end
end
function AutoAllSkill(V)
	local V, H, B, C, J =
		NameWeapon("Melee", true) or false,
		NameWeapon("Sword", true) or false,
		NameWeapon("Blox Fruit", true) or false,
		NameWeapon("Gun", true) or false,
		game:GetService("Players").LocalPlayer.PlayerGui.Main.Skills
	if V and not J:FindFirstChild(V.Name) then
		equiptool(V.Name)
		return
	end
	if H and not J:FindFirstChild(H.Name) then
		equiptool(H.Name)
		return
	end
	if B and not J:FindFirstChild(B.Name) then
		equiptool(B.Name)
		return
	end
	if C and not J:FindFirstChild(C.Name) then
		equiptool(C.Name)
		return
	end
	J = if V and (CheckCDSkillTransformation(V, Settings["Select Skills " .. V.ToolTip]))
		then (CheckCDSkillTransformation(V, Settings["Select Skills " .. V.ToolTip]))
		else if H and (CheckCDSkillTransformation(H, Settings["Select Skills " .. H.ToolTip]))
			then (CheckCDSkillTransformation(H, Settings["Select Skills " .. H.ToolTip]))
			else if C and (CheckCDSkillTransformation(C, Settings["Select Skills " .. C.ToolTip]))
				then (CheckCDSkillTransformation(C, Settings["Select Skills " .. C.ToolTip]))
				else if B and (CheckCDSkillTransformation(B, Settings["Select Skills " .. B.ToolTip]))
					then (CheckCDSkillTransformation(B, Settings["Select Skills " .. B.ToolTip]))
					else nil
	if J then
		B = J.Parent.Name
		equiptool(B)
		if t.Character:FindFirstChild(B) then
			game:GetService("VirtualInputManager"):SendKeyEvent(true, J.Name, false, game)
			if Settings["Use skill fast dont hold"] then
				task.wait(0.05)
			else
				task.wait(tonumber(holdskill))
			end
			game:GetService("VirtualInputManager"):SendKeyEvent(false, J.Name, false, game)
		end
	end
end
local V, H =
	require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")),
	require(game:GetService("ReplicatedStorage"):WaitForChild("ItemConfig"))
local function B()
	local C, J = {}, require(game:GetService("ReplicatedStorage"):WaitForChild("ItemReplicationService")).KEYS
	for F, F in V:GetItems(J.QUANTITY) do
		if F.Value and F.Value > 0 then
			local q, c = pcall(function()
				return H.match(F.ItemId):unwrap()
			end)
			if q and c and c.Display then
				local H, q = c.Display.Category, c.Index and c.Index.StorageKey
				local D, r =
					if H == "Blox Fruit"
						then q or c.Display.Name or "ItemId_" .. F.ItemId
						else c.Display.Name or q or "ItemId_" .. F.ItemId,
					V:ReadItem(J.MASTERY, F.ItemId, F.NetworkedUID) or 0
				table.insert(
					C,
					{ Name = D, Type = H, Count = F.Value, Mastery = r, ItemId = F.ItemId, UID = F.NetworkedUID }
				)
			end
		end
	end
	return C
end
do
	local V
	local H = 0
	function CheckItemInventory(C)
		if not V or tick() - H > 1 then
			V = {}
			for J, J in B() do
				V[J.Name] = true
			end
			H = tick()
		end
		return V[C] == true
	end
end
function DetectModelDestroyTyrant()
	local V, H, C =
		next,
		(workspace.Map:FindFirstChild("TikiOutpost") and (workspace.Map.TikiOutpost.IslandModel:FindFirstChild(
			"EagleBossArena",
			true
		))):GetChildren()
	for J, J in V, H, C do
		if J.Name == "Tree" and not J:GetAttribute("AlreadyDestroyedClient") then
			return J
		end
	end
end
(function()
	local V = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
	return {
		encode = function(H)
			return (H:gsub(".", function(C)
				local J, F = C:byte(), ""
				for C = 8, 1, -1 do
					F ..= J % 2 ^ C - J % 2 ^ (C - 1) > 0 and "1" or "0"
				end
				return F
			end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(C)
				if #C < 6 then
					return ""
				end
				local J = 0
				for F = 1, 6, 1 do
					J += C:sub(F, F) == "1" and 2 ^ (6 - F) or 0
				end
				return V:sub(J + 1, J + 1)
			end) .. ({ "", "==", "=" })[#H % 3 + 1]
		end,
		decode = function(H)
			return string
				.gsub(H, "[^" .. V .. "=]", "")
				:gsub(".", function(H)
					if H == "=" then
						return ""
					end
					local C, J = V:find(H) - 1, ""
					for V = 6, 1, -1 do
						J ..= C % 2 ^ V - C % 2 ^ (V - 1) > 0 and "1" or "0"
					end
					return J
				end)
				:gsub("%d%d%d?%d?%d?%d?%d?%d?", function(V)
					if #V ~= 8 then
						return ""
					end
					local H = 0
					for C = 1, 8, 1 do
						H += V:sub(C, C) == "1" and 2 ^ (8 - C) or 0
					end
					return string.char(H)
				end)
		end,
	}
end)()
local V = "https://raw.banana-hub.xyz/api"
local function H(C, J)
	local J
	local F, F = pcall(function()
		J =
			ExploitReq({ Url = ("%s/data/recent?name=%s&limit=%s"):format(V, C, 100):gsub(" ", "%%20"), Method = "GET" })
	end)
	if F then
		return false
	end
	return J.Body
end
local V
function SpecialHop(C)
	if getgenv().Key and #getgenv().Key == 32 then
		return
	end
	if V and tick() - V < 5 then
		return
	end
	local J, F = {}, H(C, 700)
	if not F then
		return
	end
	Servers = game:GetService("HttpService"):JSONDecode(F)
	for H, q in next, Servers.data, nil do
		if q and q.name == C then
			table.insert(J, H)
		end
	end
	V = tick()
	if #J > 0 then
		F = {}
		for V, V in next, Servers.data, nil do
			if V and V.name == C then
				local H, C, J = V.jobid, V.Players, V.placeid
				H = if string.find(H, "BananaCat-") then BananaCatDecryptJobId(H) else H
				if
					H
					and H ~= game.JobId
					and not table.find(F, H)
					and not CheckIsplayingRaid()
					and not Settings[H]
					and (C and C < game.Players.MaxPlayers or not V.Players)
					and (J and game.PlaceId == J or not J)
				then
					table.insert(F, H)
					game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", tostring(H))
					SaveSettings(tostring(H), true)
					getgenv().limit_type("clearAll")
				end
			end
		end
	end
end

-- Histórico local dos pontos de spawn usados pelo FarmMethod.
-- Mantém o controle disponível para o fluxo Start Farm e evita erro quando nenhum mob está carregado.
local N = {}

-- Retorna o alvo real da missão especial ativa. O GuideModule pode não estar
-- atualizado no mesmo instante em que a interface da missão aparece, então
-- usamos também os dados da própria quest como fallback.
local function GetActiveFarmQuestMob(QuestName, QuestId)
	-- Sempre prioriza a tarefa realmente aceita pelo jogador.
	-- O jogador local nesta source é `t` (não `Z`, que não é a referência
	-- confiável do Player aqui). Se a leitura falhar, usa os fallbacks abaixo.
	local ok, QuestData = pcall(function()
		return t and t:FindFirstChild("Data") and t.Data:FindFirstChild("QuestData")
	end)
	if ok and typeof(QuestData) == "Instance" then
		local taskValue = QuestData:FindFirstChild("Task")
		if taskValue then QuestData = taskValue.Value end
	end
	if ok and type(QuestData) == "table" and type(QuestData.Task) == "table" then
		for MobName, Progress in pairs(QuestData.Task) do
			if type(MobName) == "string" and MobName ~= "" then
				local n = tonumber(Progress)
				if n == nil or n > 0 then
					return MobName
				end
			end
		end
	end

	local ActiveMob = GetNameDoubleQuest()
	if type(ActiveMob) == "string" and ActiveMob ~= "" then
		return ActiveMob
	end

	local ok2, Task = pcall(function()
		return H[QuestName] and H[QuestName][QuestId] and H[QuestName][QuestId].Task
	end)
	if ok2 and type(Task) == "table" then
		for MobName in pairs(Task) do
			if type(MobName) == "string" and MobName ~= "" then
				return MobName
			end
		end
	end
end

local function IsActiveFarmQuestComplete()
	local ok, Task = pcall(function()
		local questData = t and t:FindFirstChild("Data") and t.Data:FindFirstChild("QuestData")
		if not questData then return nil end
		if questData:IsA("ValueBase") then questData = questData.Value end
		if type(questData) == "table" then return questData.Task end
		return questData:FindFirstChild("Task")
	end)
	if not ok or type(Task) ~= "table" then
		return false
	end
	local found = false
	for _, Progress in pairs(Task) do
		found = true
		local n = tonumber(Progress)
		if n == nil or n > 0 then
			return false
		end
	end
	return found
end

local SpecialQuestCycleState = {
	lastQuestVisible = false,
}

function FarmMethod()
	local selectedToggle = GetSelectedIndividualFarm()
	if not selectedToggle then
		return
	end
	local f, V, H
	local SelectedFarmMethod = ({
		["Auto Farm Level"] = "Level Farm",
		["Auto Farm Bones"] = "Farm Bones",
		["Auto Farm Katakuri"] = "Farm Katakuri",
		["Auto Farm Tyrant of the Skies"] = "Farm Tyrant of the Skies",
		["Aura Farm"] = "Aura Farm",
	})[selectedToggle]
	f = SelectedFarmMethod
	local C, J = 9999, 2
	if f == "Farm Katakuri" then
		C, V, H = 2275, y, "CakeQuest2"
	elseif f == "Farm Bones" then
		C, V, H = 2050, e, "HauntedQuest2"
	elseif f == "Farm Tyrant of the Skies" then
		C, V, H = 2575, Y, "TikiQuest3"
	else
		V = if f == "Aura Farm" and (DetectMobAura()) then { DetectMobAura() } else V
	end
	if Settings["Farm Material"] then
		V = NameMaterials[Settings["Select Material"]]
		if not NameWorldMaterials[Settings["Select Material"]][game.PlaceId] then
			f = NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId2]
				or NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId3]
				or NameWorldMaterials[Settings["Select Material"]][getgenv().CheckPlaceId]
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(f)
			return
		end
	end
	f = V or (GetNameDoubleQuest()) or ""
	local QuestVisible = AQIsQuestActive()
	local IsSpecialFarm = SelectedFarmMethod == "Farm Katakuri" or SelectedFarmMethod == "Farm Bones" or SelectedFarmMethod == "Farm Tyrant of the Skies"

	-- Auto Quest é o único que pega missão: enquanto ele está indo ao NPC / aceitando, o farm espera
	-- (antes os dois se moviam ao mesmo tempo: o farm saía para os mobs e o Auto Quest puxava de volta
	-- ao NPC). Não espera se o boss do método já está no mapa nem se o Auto Quest não tem alvo.
	if not Settings["Farm Material"] and SelectedFarmMethod ~= "Aura Farm" and AQNeedsQuest and AQNeedsQuest() then
		local bossUp = false
		pcall(function()
			if SelectedFarmMethod == "Farm Tyrant of the Skies" then
				bossUp = CheckNameBoss("Tyrant of the Skies") and true or false
			elseif SelectedFarmMethod == "Farm Katakuri" then
				bossUp = CheckNameBoss("Cake Prince") and true or false
			end
		end)
		if not bossUp then
			return
		end
	end

	-- Do not stop the farm loop just because Auto Quest is enabled.
	-- Auto Quest itself already returns while a quest is active; the farm must
	-- keep running so it can leave the quest giver and attack the quest mobs.
	-- Without an active quest the farm still targets the method's mobs
	-- (Level Farm: mob of the current level quest).
	if SelectedFarmMethod == "Level Farm" and not Settings["Farm Material"] then
		local okL, info = pcall(GetLevelQuestInfo, t.Data.Level.Value)
		if okL and type(info) == "table" and info.Mob then
			f = info.Mob
		end
	end
	-- After accepting a quest, prioritize the mob named by the active quest data.
	-- This prevents FarmMethod from continuing to target a stale/default mob and
	-- leaving the character at the quest giver.
	if not Settings["Farm Material"] and SelectedFarmMethod ~= "Aura Farm" and QuestVisible then
		local okActive, activeMob = pcall(GetActiveFarmQuestMob)
		if okActive and type(activeMob) == "string" and activeMob ~= "" then
			f = activeMob
		end
	end
	do
		-- Quando a missão já foi aceita, usa o alvo exato da quest antes da lista
		-- de mobs do método. Isso evita permanecer parado no NPC após aceitar.
		-- O Farm IGNORA a missão: o alvo vem sempre do método (lista de mobs
		-- / mob do nível). A missão só é cuidada pelo Auto Quest.
		-- Depois de aceitar a missão, o alvo passa a ser EXCLUSIVAMENTE o NPC
		-- definido pela quest ativa. Assim todos os métodos (Level, Bones,
		-- Katakuri, Tyrant e Aura) seguem a mesma regra e, ao concluir a
		-- missão, o fluxo volta automaticamente para TakeQuestLevel().
		if not Settings["Farm Material"] and SelectedFarmMethod == "Farm Tyrant of the Skies" then
			if CheckNameBoss("Tyrant of the Skies") then
				V = CheckNameBoss("Tyrant of the Skies")
				repeat
					task.wait()
					sizepart(V)
					if
						game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
						and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
					then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					elseif Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(V)
				until not IsMobAlive(V) or not Settings["Auto Farm Active"] or not StackFarm
				return
			else
				local V = workspace:FindFirstChild("Map", true)
					and (workspace.Map:FindFirstChild("TikiOutpost", true))
					and (workspace.Map.TikiOutpost:FindFirstChild("IslandModel", true))
				if V then
					local Y, H, C, J =
						V:FindFirstChild("Eye1", true),
						V:FindFirstChild("Eye2", true),
						V:FindFirstChild("Eye3", true),
						V:FindFirstChild("Eye4", true)
					if
						Y
						and H
						and C
						and J
						and Y.Transparency == 0
						and H.Transparency == 0
						and C.Transparency == 0
						and J.Transparency == 0
					then
						local V = DetectModelDestroyTyrant()
						if V then
							if t:DistanceFromCharacter(V.WorldPivot.Position) > 10 then
								toTarget(V.WorldPivot)
							elseif CheckItemInventory("Skull Guitar") then
								if not NameWeapon("Gun") or NameWeapon("Gun") ~= "Skull Guitar" then
									game:GetService("ReplicatedStorage").Remotes.CommF_
										:InvokeServer(unpack({ [1] = "LoadItem", [2] = "Skull Guitar" }))
								else
									equiptool("Skull Guitar")
									-- A árvore/vasos são modelos; apontar para uma peça física melhora o hit do M1.
									local hitPart = V:IsA("BasePart") and V or V:FindFirstChildWhichIsA("BasePart", true)
									if hitPart then
										getgenv().AimPos = CFrame.new(hitPart.Position)
										if getgenv().UseSkullGuitarSkillAttack then pcall(function() getgenv().UseSkullGuitarSkillAttack(hitPart) end) end getgenv().SpamGunSkullGuitar(hitPart)
										-- Usa M1 repetidamente enquanto a peça destrutível existir.
										RealClickM1()
										ClickM1(hitPart, true)
									end
								end
							else
								getgenv().AimPos = V.WorldPivot
								AutoAllSkill()
							end
						end
						return
					end
				end
			end
		end
		if
			not Settings["Farm Material"]
			and SelectedFarmMethod == "Farm Katakuri"
			and not Settings["Ignore Attack Katakuri"]
		then
			if CheckNameBoss("Cake Prince") then
				local V = CheckNameBoss("Cake Prince")
				repeat
					task.wait()
					sizepart(V)
					if
						game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
						and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
					then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					elseif Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
					UsedualFlock()
					ClickM1(V)
				until not IsMobAlive(V) or not Settings["Auto Farm Active"] or not StackFarm
				return
			else
				spawn(function()
					if Settings["Hop Find Katakuri"] then
						SpecialHop("Cake Prince")
					end
				end)
			end
		end
		local V = DetectMob(f)
		if not V then
			if typeof(f) == "table" then
				if #N >= #f then
					N = {}
					return
				end
				local Y = DetectNameTablePart(f)
				local H = DetectPartSpawnMob(Y)
				if H then
					table.insert(N, Y)
					repeat
						task.wait()
						toTarget(H.CFrame * CFrame.new(0, 60, 0))
					until (H.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(f))
						or not Settings["Auto Farm Active"]
						or not StackFarm
					wait(1)
				end
			else
				local Y = DetectPartSpawnMob(f, true)
				if Y then
					Instance.new("IntValue", Y).Name = "Ignored"
					repeat
						task.wait()
						toTarget(Y.CFrame * CFrame.new(0, 60, 0))
					until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
						or (DetectMob(f))
						or not Settings["Auto Farm Active"]
						or not StackFarm
					wait(1)
				else
					DeleteIgnoredMobSpawn()
				end
			end
		else
			repeat
				task.wait()
				sizepart(V)
				BringMob(V)
				UsedualFlock()
				ClickM1(V)
				if
					game:GetService("Players").LocalPlayer.PlayerGui.TransformationHUD.ImageLabel.Visible
					and (Settings["Auto Finish Train Quest"] or Settings["Auto Finish Train Draco Quest"])
				then
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				elseif Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit, 0))
				else
					toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(V) or not Settings["Auto Farm Active"] or not StackFarm
			if getgenv().QuestTrainer and getgenv().QuestTrainer.CountKillMob then
				getgenv().QuestTrainer.CountKillMob = getgenv().QuestTrainer.CountKillMob + 1
			end
		end
	end
end
-- Auto Quest: ONLY accepts the quest of the selected farm. Never attacks.
-- Only the quest-selection logic lives here; the individual Auto Farm functions
-- remain untouched.
AutoQuestInfo = {
    ["Auto Farm Bones"] = { 2050, "HauntedQuest2", 2 },
    ["Auto Farm Katakuri"] = { 2275, "CakeQuest2", 2 },
    ["Auto Farm Tyrant of the Skies"] = { 2575, "TikiQuest3", 2 },
}

-- Detect whether a quest is already active. This belongs to Auto Quest only.
-- Diagnóstico do Auto Quest: imprime no console (F9) POR QUE ele vai ao NPC / pede a missão.
-- Desligue com getgenv().AQDebug = false antes de executar o script.
function AQLog(msg)
    if getgenv().AQDebug == false then
        return
    end
    getgenv().__AQLogLast = getgenv().__AQLogLast or {}
    local last = getgenv().__AQLogLast[msg]
    if last and tick() - last < 2 then
        return
    end
    getgenv().__AQLogLast[msg] = tick()
    warn("[Banana Cat Hub][AutoQuest] " .. msg)
end
-- Tarefas da missão atual como texto (ex.: "Bandit=3"), lidas do GuideModule.
function AQTaskString()
    local parts = {}
    pcall(function()
        local gm = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
        local qd = gm.Data and gm.Data.QuestData
        local task = qd and qd.Task
        if type(task) == "table" then
            for k, v in pairs(task) do
                parts[#parts + 1] = tostring(k) .. "=" .. tostring(v)
            end
        end
    end)
    return #parts > 0 and table.concat(parts, ",") or "?"
end
-- Soma do que ainda falta matar na missão ativa (nil se não der para ler).
function AQQuestRemaining()
    local total
    pcall(function()
        local data = Z.Data and Z.Data.QuestData
        local task = data and data.Task
        if type(task) == "table" then
            total = 0
            for _, v in pairs(task) do
                total = total + (tonumber(v) or 0)
            end
        end
    end)
    return total
end

function AQIsQuestActive()
    local has = false
    pcall(function()
        has = DontQuest() == true
    end)
    local shown = false
    pcall(function()
        local main = t.PlayerGui and t.PlayerGui:FindFirstChild("Main")
        local q = main and main:FindFirstChild("Quest")
        shown = q ~= nil and q.Visible == true
    end)
    if not (has or shown) then
        -- Histerese: a interface/os dados da missão podem piscar por 1 frame ao matar um mob. Só conta como
        -- "sem missão" depois de 3s seguidos sem nenhum sinal de missão (antes qualquer piscada fazia o
        -- script voltar ao NPC e pegar a missão de novo antes de completar).
        -- O tempo de espera depende de quanto faltava matar na última leitura:
        --   faltava 0 a 2 (ou é a última morte)  -> 3s   (concluída de verdade);
        --   não deu para ler o progresso         -> 8s;
        --   faltava mais de 2                    -> 25s  (a missão sumiu SEM estar concluída: morte,
        --                                                 troca de servidor etc.; antes o script pegava
        --                                                 a missão de novo na hora e perdia o progresso).
        local remaining = getgenv().__AQLastRemaining
        local quiet = remaining == nil and 8 or (remaining <= 2 and 3 or 25)
        if tick() - (getgenv().__AQLastRaw or 0) < quiet then
            return true
        end
        if getgenv().__AQLastRaw and not getgenv().__AQLogged then
            getgenv().__AQLogged = true
            print(string.format("[Nexora][Auto Quest] missão encerrada (faltava=%s, espera=%ds); pegando a próxima",
                tostring(remaining), quiet))
        end
        getgenv().__AQDoneSince, getgenv().__AQSeenPositive = nil, nil
        return false
    end
    getgenv().__AQLastRaw = tick()
    getgenv().__AQLogged = nil
    getgenv().__AQLastRemaining = AQQuestRemaining()
    if tick() - (getgenv().__AQTaskAt or 0) > 0.5 then
        getgenv().__AQTaskAt = tick()
        getgenv().__AQLastTask = AQTaskString()
    end
    -- Missão concluída: todas as tarefas zeradas por 1,5s. Só vale se, nesta missão, já vimos uma tarefa
    -- positiva (assim um "tudo zero" logo ao aceitar nunca é tomado por missão concluída).
    local ok, Task = pcall(function()
        local questData = t and t:FindFirstChild("Data") and t.Data:FindFirstChild("QuestData")
        if not questData then
            return nil
        end
        if questData:IsA("ValueBase") then
            questData = questData.Value
        end
        if type(questData) == "table" then
            return questData.Task
        end
        return questData:FindFirstChild("Task")
    end)
    if ok and type(Task) == "table" then
        for _, Progress in pairs(Task) do
            local n = tonumber(Progress)
            if n and n > 0 then
                getgenv().__AQSeenPositive = true
            end
        end
    end
    local done = false
    pcall(function()
        done = IsActiveFarmQuestComplete()
    end)
    if done and getgenv().__AQSeenPositive then
        getgenv().__AQDoneSince = getgenv().__AQDoneSince or tick()
        if tick() - getgenv().__AQDoneSince >= 1.5 then
            return false
        end
    else
        getgenv().__AQDoneSince = nil
    end
    return true
end

-- ===================== Auto Quest (máquina de estados) =====================
-- Fases, sempre uma de cada vez:
--   PEGAR   : sem missão ativa -> o FarmMethod espera (só o Auto Quest se mexe), o personagem vai ao NPC,
--             espera 0,8s parado nele, inicia a missão UMA vez e confere se abriu (até 3s);
--   FARMAR  : missão ativa -> o Auto Quest não faz nada; o FarmMethod sai do NPC e farma o mob da missão;
--   VOLTAR  : missão concluída (some, ou tarefas zeradas por 1,5s) -> volta à fase PEGAR sozinho.
-- Falhou ao abrir: espera 2s, 4s, ... até 10s entre tentativas; 6 falhas seguidas -> devolve o controle
-- ao farm por 45s (o farm segue sem missão em vez de ficar parado esperando). Se o Auto Quest não tem
-- alvo (nível baixo demais, NPC desconhecido), o farm NÃO espera por ele.
-- Reexecutar o script não duplica o loop (só a execução mais recente continua).
getgenv().__AQGen = (getgenv().__AQGen or 0) + 1
getgenv().__AQReady, getgenv().__AQGiveUp = 0, nil

-- O farm só espera quando o Auto Quest está ligado, tem alvo e ainda não há missão ativa.
function AQNeedsQuest()
    if not Settings["Auto Quest [Katakuri/Bone/Tyrant]"] then
        return false
    end
    if Settings["Farm Mastery"] and Settings["Start Farm"] then
        return false
    end
    if getgenv().__AQGiveUp and tick() < getgenv().__AQGiveUp then
        return false
    end
    if tick() - (getgenv().__AQReady or 0) > 2 then
        return false -- o Auto Quest não está em condições de agir: o farm segue normal
    end
    return not AQIsQuestActive()
end

do
    local MyGen = getgenv().__AQGen
    local initialLevel = 0
    pcall(function() initialLevel = tonumber(t.Data.Level.Value) or 0 end)
    local State = {
        fails = 0, nextTry = 0, atNpcSince = nil, busy = false,
        graceUntil = 0, wasActive = false, lastDeath = 0, loggedTrip = false,
        lastLevelCheck = 0, lastKnownLevel = initialLevel, levelQuestPending = false
    }

    -- Auto Farm Level: verifica a cada 2 segundos se o jogador subiu de nível.
    -- Só libera uma nova missão de Level quando detectar aumento de nível.
    local function CheckLevelUpForQuest(selectedFarm)
        if selectedFarm ~= "Auto Farm Level" then
            return true
        end
        local now = tick()
        if now - State.lastLevelCheck >= 2 then
            State.lastLevelCheck = now
            local currentLevel
            pcall(function() currentLevel = tonumber(t.Data.Level.Value) end)
            if currentLevel then
                if currentLevel > (State.lastKnownLevel or currentLevel) then
                    State.levelQuestPending = true
                    AQLog("subiu de level: " .. tostring(State.lastKnownLevel) .. " -> " .. tostring(currentLevel) .. "; missão liberada")
                end
                State.lastKnownLevel = currentLevel
            end
        end
        return State.levelQuestPending
    end

    -- Retorna nome da missão, id e posição do NPC da missão do farm selecionado.
    local function QuestTarget(selectedFarm)
        if selectedFarm == "Auto Farm Level" then
            local ok, info = pcall(GetLevelQuestInfo, t.Data.Level.Value)
            if not ok or type(info) ~= "table" or not info.Pos or not info.QuestName then
                return nil
            end
            local pos = typeof(info.Pos) == "CFrame" and info.Pos.Position or info.Pos
            return tostring(info.QuestName), info.Id, pos
        end
        local q = AutoQuestInfo[selectedFarm]
        if not q or t.Data.Level.Value < q[1] then
            return nil
        end
        local points = getgenv().questpoint
        local cf = points and points[q[2]]
        if not cf then
            pcall(CFrameQuest)
            task.wait(1)
            points = getgenv().questpoint
            cf = points and points[q[2]]
        end
        if not cf then
            return nil
        end
        return q[2], q[3], cf.Position
    end

    local function Step()
        if not Settings["Auto Quest [Katakuri/Bone/Tyrant]"] then
            State.atNpcSince = nil
            return
        end
        if Settings["Farm Mastery"] and Settings["Start Farm"] then
            return
        end
        local selectedFarm = GetSelectedIndividualFarm()
        if not selectedFarm or selectedFarm == "Aura Farm" or Settings["Farm Material"] then
            return
        end
        -- Para Auto Farm Level, a mesma toggle Auto Quest só busca missão depois
        -- de detectar um level-up. A checagem é feita a cada 2 segundos.
        local levelQuestAllowed = CheckLevelUpForQuest(selectedFarm)
        local character = t.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not root or not humanoid or humanoid.Health <= 0 then
            State.atNpcSince = nil
            if humanoid and humanoid.Health <= 0 then
                State.lastDeath = tick()
            end
            return
        end
        -- FARMAR: missão ativa -> não mexe em nada e zera as falhas.
        local activeNow = AQIsQuestActive()
        if activeNow ~= State.wasActive then
            State.wasActive = activeNow
            if activeNow then
                AQLog("missão ATIVA | tarefa: " .. AQTaskString())
            else
                local diedAgo = tick() - State.lastDeath
                AQLog(string.format(
                    "missão SUMIU | última tarefa vista: %s | morreu há %s",
                    tostring(getgenv().__AQLastTask or "?"),
                    State.lastDeath > 0 and string.format("%.0fs", diedAgo) or "nunca"
                ))
            end
        end
        if activeNow then
            State.fails, State.atNpcSince, State.loggedTrip = 0, nil, false
            getgenv().__AQGiveUp = nil
            return
        end
        -- Folga: nos 8s seguintes a uma missão aceita ela não pode estar concluída; se a leitura falhou,
        -- é oscilação. Não vai ao NPC nem faz o farm esperar.
        if tick() < State.graceUntil then
            return
        end
        if getgenv().__AQGiveUp and tick() < getgenv().__AQGiveUp then
            return
        end
        if selectedFarm == "Auto Farm Level" and not levelQuestAllowed then
            return -- aguarda detectar aumento de nível; não fica indo ao NPC sem necessidade
        end
        local questName, questId, npcPos = QuestTarget(selectedFarm)
        if not questName then
            return -- sem alvo: __AQReady não é renovado e o farm segue normal
        end
        getgenv().__AQReady = tick() -- PEGAR: o farm espera por mim
        if tick() < State.nextTry then
            return
        end
        -- vai até o NPC
        if (npcPos - root.Position).Magnitude > 8 then
            State.atNpcSince = nil
            if not State.loggedTrip then
                State.loggedTrip = true
                AQLog(string.format(
                    "indo ao NPC (%s) | sem sinal de missão há %.1fs | última tarefa vista: %s",
                    questName,
                    tick() - (getgenv().__AQLastRaw or 0),
                    tostring(getgenv().__AQLastTask or "?")
                ))
            end
            toTarget(CFrame.new(npcPos) * CFrame.new(0, 4, 2), true)
            return
        end
        State.atNpcSince = State.atNpcSince or tick()
        if tick() - State.atNpcSince < 0.8 then
            return
        end
        -- Última conferência: se a missão voltou a aparecer, NÃO pede de novo (pedir com missão ativa
        -- reinicia o progresso).
        if AQIsQuestActive() then
            State.atNpcSince = nil
            return
        end
        -- inicia a missão uma vez e confere
        State.busy = true
        AQLog("StartQuest enviado: " .. tostring(questName) .. " id " .. tostring(questId))
        pcall(function()
            CommF:InvokeServer("StartQuest", questName, questId)
        end)
        local deadline = tick() + 3
        local opened = false
        repeat
            task.wait(0.1)
            opened = AQIsQuestActive()
        until opened or tick() > deadline
        State.busy = false
        State.atNpcSince = nil
        State.loggedTrip = false
        if opened then
            State.fails = 0
            if selectedFarm == "Auto Farm Level" then
                State.levelQuestPending = false
            end
            State.nextTry = tick() + 1
            State.graceUntil = tick() + 8
            getgenv().__AQGiveUp = nil
            -- Solta o personagem do NPC: cancela o movimento até ele para o farm assumir já.
            pcall(function()
                TweenManager.CancelCurrent()
            end)
        else
            State.fails += 1
            State.nextTry = tick() + math.min(2 * State.fails, 10)
            if State.fails >= 6 then
                getgenv().__AQGiveUp = tick() + 45
                State.fails = 0
            end
        end
    end

    spawn(function()
        while task.wait(0.25) and getgenv().__AQGen == MyGen do
            if not State.busy then
                pcall(Step)
            end
        end
    end)
end

local function HauntedCastleMasteryFarm()
	if not Settings["Farm Mastery"] or not Settings["Start Farm"] then
		return
	end
	local character = t.Character
	local root = character and character:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local masteryMobs = {
		"Reborn Skeleton",
		"Demonic Soul",
		"Living Zombie",
		"Possessed Mummy",
		"Posessed Mummy",
	}
	local humanoid = character:FindFirstChildOfClass("Humanoid")
	if not humanoid or humanoid.Health <= 0 then return end
	local mob = DetectMob(masteryMobs)
	if mob and mob:FindFirstChild("HumanoidRootPart") then
		sizepart(mob)
		pcall(BringMob, mob)
		-- Antes o personagem não se aproximava do mob e ficava parado.
		if Settings["Select Method Farm Mastery"] == "Blox Fruit" then
			toTarget(mob.HumanoidRootPart.CFrame * CFrame.new(-7, getgenv().YPosFruit or 20, 0))
		else
			toTarget(mob.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
		end
		FarmMastery(mob)
		ClickM1(mob)
		return
	end
	local spawnPart = DetectPartSpawnMob(DetectNameTablePart(masteryMobs))
	if spawnPart then
		toTarget(spawnPart.CFrame * CFrame.new(0, 60, 0))
	else
		toTarget(CFrame.new(-9509.34961, 142.130661, 5535.16309))
	end
end

spawn(function()
	while task.wait() do
		pcall(function()
			if Settings["Farm Mastery"] and Settings["Start Farm"] then
				HauntedCastleMasteryFarm()
			elseif GetSelectedIndividualFarm() and StackFarm then
				FarmMethod()
			end
		end)
	end
end)
stackFarmMain = Main.CreatePage({ Page_Name = "Stack Farming", Page_Title = "Stack Farming" })
AutoWorldSection = stackFarmMain.CreateSection("Auto World")
AutoWorldSection.CreateToggle(
	{ Title = "Auto New World", Desc = nil, Default = Settings["Auto New World"] or false },
	function(f)
		SaveSettings("Auto New World", f)
	end
)
AutoWorldSection.CreateToggle(
	{ Title = "Auto Third World", Desc = nil, Default = Settings["Auto Third World"] or false },
	function(f)
		SaveSettings("Auto Third World", f)
	end
)
getgenv().GetTime = nil
NotiGetTime = true
function timeToSeconds(f)
	local V, Y, H = f:match("^(%d+):(%d+):(%d+)$")
	if not V then
		Y, H = f:match("^(%d+):(%d+)$")
		V = 0
	end
	return tonumber(V) * 3600 + tonumber(Y) * 60 + tonumber(H)
end
function secondsToTime(f)
	local V, Y, H = math.floor(f / 3600), math.floor(f % 3600 / 60), f % 60
	return string.format("%d:%02d:%02d", V, Y, H)
end
function DetectPresent()
	for f, f in t.Backpack:GetChildren() do
		if string.find(f.Name, "Holiday Gift") then
			return f
		end
	end
	for f, f in t.Character:GetChildren() do
		if string.find(f.Name, "Holiday Gift") then
			return f
		end
	end
end
function DetectPresentStore()
	for f, f in t.Backpack:GetChildren() do
		if string.find(f.Name, "Holiday Gift") and not f:FindFirstChild("Ignored") then
			return f
		end
	end
	for f, f in t.Character:GetChildren() do
		if string.find(f.Name, "Holiday Gift") and not f:FindFirstChild("Ignored") then
			return f
		end
	end
end
function GetCountDownTime()
	if not getgenv().GetTime and not game.workspace:FindFirstChild("Countdown") then
		return "Go Get Time"
	end
	if workspace:FindFirstChild("Countdown") and (workspace.Countdown.SurfaceGui.TextLabel.Text:find("START")) then
		return 0
	end
	local f = workspace:FindFirstChild("Countdown") and workspace.Countdown.SurfaceGui.TextLabel.Text
		or (secondsToTime(getgenv().GetTime))
	if tonumber(f:split(":")[1]) == 0 then
		return tonumber(f:split(":")[2])
	else
		return 55
	end
end
function getGift()
	if not workspace._WorldOrigin:FindFirstChild("Present") then
		return
	end
	for f, f in pairs(workspace._WorldOrigin:GetChildren()) do
		if
			f.Name == "Present"
			and (f:FindFirstChild("Highlight"))
			and (f:FindFirstChild("Box"))
			and (f.Box:FindFirstChild("ProximityPrompt"))
		then
			return f
		end
	end
end
StackDevilFruitSection = stackFarmMain.CreateSection("Devil Fruit")
StackDevilFruitSection.CreateToggle(
	{
		Title = "Collect Chest When Server Spawn God's Chalice or Fist of Darkness",
		Desc = nil,
		Default = Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"] or false,
	},
	function(f)
		SaveSettings("Collect Chest When Server Spawn God's Chalice or Fist of Darkness", f)
	end
)
StackDevilFruitSection.CreateToggle(
	{ Title = "Teleport To Fruit", Desc = nil, Default = Settings["Teleport To Fruit"] or false },
	function(f)
		SaveSettings("Teleport To Fruit", f)
	end
)
StackDevilFruitSection.CreateToggle(
	{
		Title = "Teleport To Fruit [ Hop Server ]",
		Desc = nil,
		Default = Settings["Teleport To Fruit [ Hop Server ]"] or false,
	},
	function(f)
		SaveSettings("Teleport To Fruit [ Hop Server ]", f)
	end
)
-- Deslocamento em etapas usando o toTarget original. Cada waypoint fica a menos de 3000 studs,
-- evitando que a lógica de entradas/ilhas do toTarget redirecione o personagem para outro local.
local function BananaMoveToDestination(destination, settingName, readyFlag, arrivalDistance)
    getgenv()[readyFlag] = false
    task.spawn(function()
        local waypoint = nil
        while Settings[settingName] do
            local character = t.Character
            local root = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            if root and humanoid and humanoid.Health > 0 then
                local remaining = (destination.Position - root.Position).Magnitude
                if remaining <= (arrivalDistance or 100) then
                    getgenv()[readyFlag] = true
                    return
                end
                -- Só cria um novo waypoint quando chega perto do anterior; isso evita reiniciar
                -- o tween a cada ciclo e mantém o movimento contínuo usando a função original.
                if not waypoint or (root.Position - waypoint.Position).Magnitude <= 120 then
                    local direction = destination.Position - root.Position
                    local distance = direction.Magnitude
                    if distance > 2200 then
                        waypoint = CFrame.new(root.Position + direction.Unit * 2000)
                    else
                        waypoint = destination
                    end
                    -- Chama uma vez por waypoint: chamar repetidamente reiniciaria o tween original.
                    toTarget(waypoint)
                end
            end
            task.wait(0.3)
        end
        getgenv()[readyFlag] = false
    end)
end

EventGameSection = stackFarmMain.CreateSection("Event Game")
EventGameSection.CreateToggle(
	{ Title = "Auto Factory", Desc = nil, Default = Settings["Auto Factory"] or false },
	function(f)
		SaveSettings("Auto Factory", f)
	end
)
EventGameSection.CreateToggle(
	{ Title = "Auto Pirate Raid", Desc = nil, Default = Settings["Auto Pirate Raid"] or false },
	function(f)
		SaveSettings("Auto Pirate Raid", f)
		getgenv().__PirateCastleReady = false
		if f then
			getgenv().__PirateDestinationName = "Castle on the Sea"
			BananaMoveToDestination(CFrame.new(-5074, 314, -3150), "Auto Pirate Raid", "__PirateCastleReady", 120)
		end
	end
)
BossRipIndraSection = stackFarmMain.CreateSection("Boss Rip Indra")
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Elite Hunter", Desc = nil, Default = Settings["Auto Elite Hunter"] or false },
	function(f)
		SaveSettings("Auto Elite Hunter", f)
	end
)
BossRipIndraSection.CreateToggle(
	{
		Title = "Hop Server Elite Hunter",
		Desc = "Hop if u have God chalice and teleport in safezone",
		Default = Settings["Hop Server Elite Hunter"] or false,
	},
	function(f)
		SaveSettings("Hop Server Elite Hunter", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Touch Pad Haki", Desc = nil, Default = Settings["Auto Touch Pad Haki"] or false },
	function(f)
		SaveSettings("Auto Touch Pad Haki", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Auto Summon Rip Indra", Desc = nil, Default = Settings["Auto Summon Rip Indra"] or false },
	function(f)
		SaveSettings("Auto Summon Rip Indra", f)
	end
)
BossRipIndraSection.CreateToggle(
	{ Title = "Attack Rip Indra", Desc = nil, Default = Settings["Attack Rip Indra"] or false },
	function(f)
		SaveSettings("Attack Rip Indra", f)
	end
)
BossSoulReaperSection = stackFarmMain.CreateSection("Boss Soul Reaper")
BossSoulReaperSection.CreateToggle(
	{ Title = "Attack Soul Reaper", Desc = nil, Default = Settings["Attack Soul Reaper"] or false },
	function(f)
		SaveSettings("Attack Soul Reaper", f)
	end
)
BossSoulReaperSection.CreateToggle(
	{ Title = "Summon Soul Reaper", Desc = nil, Default = Settings["Summon Soul Reaper"] or false },
	function(f)
		if f and not Settings["Attack Soul Reaper"] then
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Attack Soul Reaper Plz", ShowTime = 5 })
		end
		SaveSettings("Summon Soul Reaper", f)
	end
)
BossDoughKingSection = stackFarmMain.CreateSection("Boss Dough King")
BossDoughKingSection.CreateToggle(
	{ Title = "Attack Dough King", Desc = nil, Default = Settings["Attack Dough King"] or false },
	function(f)
		SaveSettings("Attack Dough King", f)
	end
)
BossDoughKingSection.CreateToggle(
	{ Title = "Summon Dough King", Desc = nil, Default = Settings["Summon Dough King"] or false },
	function(f)
		if f and not Settings["Attack Dough King"] then
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Attack Dough King Plz", ShowTime = 5 })
		end
		if f then
			spawn(function()
				while Settings["Summon Dough King"] and (task.wait()) do
					if DetectItemPlr("Sweet Chalice") then
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("CakePrinceSpawner")
					end
				end
			end)
		end
		SaveSettings("Summon Dough King", f)
	end
)
BossDoughKingSection.CreateToggle(
	{ Title = "Hop Find Dough King", Desc = nil, Default = Settings["Hop Find Dough King"] or false },
	function(f)
		if f and not Settings["Attack Dough King"] then
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Attack Dough King Plz", ShowTime = 5 })
		end
		SaveSettings("Hop Find Dough King", f)
	end
)
BossDarkbeardSection = stackFarmMain.CreateSection("Boss Darkbeard")
BossDarkbeardSection.CreateToggle(
	{ Title = "Attack Darkbeard", Desc = nil, Default = Settings["Attack Darkbeard"] or false },
	function(f)
		SaveSettings("Attack Darkbeard", f)
	end
)
BossDarkbeardSection.CreateToggle(
	{ Title = "Summon Darkbeard", Desc = nil, Default = Settings["Summon Darkbeard"] or false },
	function(f)
		if f and not Settings["Attack Darkbeard"] then
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Attack Darkbeard Plz", ShowTime = 5 })
		end
		SaveSettings("Summon Darkbeard", f)
	end
)
BossDarkbeardSection.CreateToggle(
	{ Title = "Hop Find Darkbeard", Desc = nil, Default = Settings["Hop Find Darkbeard"] or false },
	function(f)
		if f and not Settings["Attack Darkbeard"] then
			A.CreateNoti({ Title = "Nexora Hub", Desc = "Turn On Attack Darkbeard Plz", ShowTime = 5 })
		end
		SaveSettings("Hop Find Darkbeard", f)
	end
)

function GetPathFruit()
	-- OTIMIZADO: Não laga, pega frutas longe, e continua pegando várias
	local workspaceService = game:GetService("Workspace")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer
	local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
	if not root then return nil end

	local function IsFruitObject(H)
		if not H then return false end
		if not (H:IsA("Tool") or H:IsA("Model")) then return false end
		local handle = H:FindFirstChild("Handle")
		if not handle or not handle:IsA("BasePart") then return false end
		local name = tostring(H.Name)
		if TableDevilFruit and TableDevilFruit[name] ~= nil then return true end
		if string.find(string.lower(name), "fruit", 1, true) then return true end
		if string.find(name, "-", 1, true) and #name >= 5 then return true end
		return false
	end

	local closest = nil
	local closestDist = math.huge
	local closestHandle = nil

	-- Só checa filhos diretos do workspace (onde frutas spawnam) - MUITO mais rápido que GetDescendants
	for _, obj in ipairs(workspaceService:GetChildren()) do
		if IsFruitObject(obj) then
			local handle = obj:FindFirstChild("Handle")
			if handle then
				local dist = (handle.Position - root.Position).Magnitude
				if dist < closestDist then
					closestDist = dist
					closest = obj
					closestHandle = handle
				end
			end
		end
	end

	-- Também checa Tools soltas (frutas dropadas por player às vezes ficam soltas)
	if not closest then
		for _, obj in ipairs(workspaceService:GetChildren()) do
			if obj:IsA("Tool") then
				local handle = obj:FindFirstChild("Handle")
				if handle and string.find(obj.Name, "-", 1, true) then
					local dist = (handle.Position - root.Position).Magnitude
					if dist < closestDist then
						closestDist = dist
						closest = obj
					end
				end
			end
		end
	end

	return closest
end

-- Cache para não ficar escaneando todo frame
getgenv().__LastFruitScan = 0
getgenv().__CachedFruit = nil
function GetPathFruitCached()
	local now = tick()
	if now - (getgenv().__LastFruitScan or 0) > 0.5 then
		getgenv().__LastFruitScan = now
		getgenv().__CachedFruit = GetPathFruit()
	end
	return getgenv().__CachedFruit
end


function GetPirateRaid(f)
	for V, V in ipairs((if f then game.ReplicatedStorage else game.workspace.Enemies):GetChildren()) do
		if
			V:IsA("Model")
			and V.Name ~= "Oni2"
			and not string.find(V.Name, "Boss")
			and not string.find(V.Name, "Friend")
			and not string.find(V.Name, "Wraith")
			and V.Name ~= "rip_indra True Form"
			and (IsMobAlive(V))
			and (V.HumanoidRootPart.Position - Vector3.new(-5543, 313, -2964)).magnitude < 1000
		then
			return V
		end
	end
end
function DetectButtons()
	local f, V, Y = next, game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:GetChildren()
	for H, H in f, V, Y do
		if H:IsA("Part") and H.Part.BrickColor.Name ~= "Lime green" then
			return H
		end
	end
end
local f = { "Winter Sky", "Pure Red", "Snow White" }
function IsMisisngLegHaki(V)
	V = V and {}
	local Y
	for H, H in pairs(CommF:InvokeServer("getColors")) do
		if table.find(f, H.HiddenName) and not H.Unlocked then
			if V then
				table.insert(V, H.HiddenName)
			else
				Y = if not Y then H.HiddenName else Y .. ", " .. H.HiddenName
			end
		end
	end
	if V then
		return V
	end
	return Y
end
function TouchPadHaki()
	local f = DetectButtons()
	if f then
		if f.BrickColor.Name == "Hot pink" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Winter Sky", Type = "AuraSkin", Context = "Equip" } }))
			toTarget(f.CFrame)
			wait(2)
		elseif f.BrickColor.Name == "Really red" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Pure Red", Type = "AuraSkin", Context = "Equip" } }))
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Pure Red")
			toTarget(f.CFrame)
			wait(2)
		elseif f.BrickColor.Name == "Oyster" then
			game:GetService("ReplicatedStorage").Modules.Net
				:FindFirstChild("RF/FruitCustomizerRF")
				:InvokeServer(unpack({ [1] = { StorageName = "Snow White", Type = "AuraSkin", Context = "Equip" } }))
			game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("activateColor", "Snow White")
			toTarget(f.CFrame)
			wait(2)
		end
	end
end
getgenv().CheckCountItem = function(f, V)
	local Y, H, C = next, B()
	for J, J in Y, H, C do
		if J.Name == f and J.Count and J.Count >= V then
			return true
		end
	end
	return false
end
function getbackpack()
	mybackpack = {}
	local f, V, Y = next, game.Players.LocalPlayer.Backpack:GetChildren()
	for H, H in f, V, Y do
		if H:IsA("Tool") and (table.find(whitelistedfruit, H.Name)) then
			table.insert(mybackpack, H.Name)
		end
	end
	f, Y, V = next, game.Players.LocalPlayer.Character:GetChildren()
	for H, H in f, Y, V do
		if H:IsA("Tool") and (table.find(whitelistedfruit, H.Name)) then
			table.insert(mybackpack, H.Name)
		end
	end
	return mybackpack
end
function CheckFruitplr()
	local f
	for V, V in pairs(t.Backpack:GetChildren()) do
		f = if string.find(V.Name, "Fruit") then V.Name else f
	end
	for V, V in pairs(t.Character:GetChildren()) do
		f = if string.find(V.Name, "Fruit") then V.Name else f
	end
	return f
end
function TakeFruitInventory(f)
	local V, Y, H = next, B()
	local C, J = 1 / 0
	for F, F in V, Y, H do
		if F.Type == "Blox Fruit" then
			if not f then
				for f, V in pairs(getgenv().tablefruitausea3) do
					if F.Name == f then
						if tonumber(V) < tonumber(C) then
							C, J = V, f
						end
					end
				end
			elseif not getgenv().tablefruitausea3[F.Name] then
				return F.Name
			end
		end
	end
	return J
end
cframethangdaubuoiredhead = CFrame.new(
	-1926.78772,
	12.1678171,
	1739.80884,
	0.956294656,
	-0.0,
	-0.292404652,
	0,
	1,
	-0.0,
	0.292404652,
	0,
	0.956294656
)
function StopThirdSea()
	if game.PlaceId == getgenv().CheckPlaceId2 and t.Data.Level.Value >= 1500 then
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
				if #getbackpack() >= 1 then
					return true
				elseif not CheckFruitplr() and (TakeFruitInventory()) then
					StopStoreFruit = true
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory())
				end
			elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") then
				if CheckNameBoss("Don Swan") then
					return true
				end
			elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
				return true
			end
		else
			return true
		end
	end
end
function checkplatebarito()
	return if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate1.BrickColor
			== BrickColor.new("Sand yellow")
		then "Plate1"
		else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate2.BrickColor
				== BrickColor.new("Sand yellow")
			then "Plate2"
			else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate3.BrickColor
					== BrickColor.new("Sand yellow")
				then "Plate3"
				else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate4.BrickColor
						== BrickColor.new("Sand yellow")
					then "Plate4"
					else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate5.BrickColor
							== BrickColor.new("Sand yellow")
						then "Plate5"
						else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate6.BrickColor
								== BrickColor.new("Sand yellow")
							then "Plate6"
							else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate7.BrickColor
									== BrickColor.new("Sand yellow")
								then "Plate7"
								else if game:GetService("Workspace").Map.Dressrosa.BartiloPlates.Plate8.BrickColor
										== BrickColor.new("Sand yellow")
									then "Plate8"
									else nil
end
function AutoQuestBarito()
	if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0 then
		if
			string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates")
			and (string.find(game.Players.LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50"))
			and game.Players.LocalPlayer.PlayerGui.Main.Quest.Visible
		then
			local f, V = "Swan Pirate", DetectMob("Swan Pirate")
			if not V then
				if typeof(f) == "table" then
					if #N >= 11 then
						N = {}
						return
					end
					local Y = DetectPartSpawnMob(DetectNameTablePart(f))
					if Y then
						table.insert(N, DetectNameTablePart(f))
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(f))
						wait(1)
					end
				else
					local Y = DetectPartSpawnMob(f, true)
					if Y then
						Instance.new("IntValue", Y).Name = "Ignored"
						repeat
							wait()
							toTarget(Y.CFrame * CFrame.new(0, 60, 0))
						until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100 or (DetectMob(f))
						wait(1)
					else
						DeleteIgnoredMobSpawn()
					end
				end
			else
				repeat
					task.wait()
					sizepart(V)
					BringMob(V)
					UsedualFlock()
					ClickM1(V)
					if Settings["Select Weapon"] == "Blox Fruit" then
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
					else
						toTarget(V.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
					end
				until not IsMobAlive(V)
			end
		elseif
			(t.Character.HumanoidRootPart.Position - CFrame.new(-456.28952, 73.0200958, 299.895966).Position).Magnitude
			> 8
		then
			toTarget(CFrame.new(-456.28952, 73.0200958, 299.895966))
		else
			game:GetService("ReplicatedStorage").Remotes.CommF_
				:InvokeServer(unpack({ [1] = "StartQuest", [2] = "BartiloQuest", [3] = 1 }))
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1 then
		local f = CheckNameBoss("Jeremy")
		if f then
			repeat
				task.wait()
				sizepart(f)
				UsedualFlock()
				ClickM1(f)
				if Settings["Select Weapon"] == "Blox Fruit" then
					toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
				else
					toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
				end
			until not IsMobAlive(f)
		end
	elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2 then
		repeat
			task.wait()
			if (t.Character.HumanoidRootPart.Position - Vector3.new(-1835.65, 10.4325, 1679.75)).Magnitude > 100 then
				toTarget(CFrame.new(-1835.65, 10.4325, 1679.75))
			else
				t.Character.HumanoidRootPart.CFrame =
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()].CFrame
				task.wait()
				firetouchinterest(
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],
					game.Players.LocalPlayer.Character.HumanoidRootPart,
					0
				)
				firetouchinterest(
					game:GetService("Workspace").Map.Dressrosa.BartiloPlates[checkplatebarito()],
					game.Players.LocalPlayer.Character.HumanoidRootPart,
					1
				)
			end
		until game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3
	end
end
function SeaThird()
	if
		game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0
		and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1
		and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0
	then
		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
	end
	if game.PlaceId == getgenv().CheckPlaceId2 and t.Data.Level.Value >= 1500 then
		if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 3 then
			if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 0 then
				if #getbackpack() >= 1 then
					toTarget(CFrame.new(-339.79840087891, 331.86065673828, 643.83178710938))
					if
						(
							Vector3.new(-339.79840087891, 331.86065673828, 643.83178710938)
							- t.Character.HumanoidRootPart.Position
						).Magnitude <= 5
					then
						if game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") ~= 1 then
							local f, V, Y = next, getbackpack()
							for H, H in f, V, Y do
								t.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack:FindFirstChild(H))
							end
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "1")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "2")
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TalkTrevor", "3")
						end
					end
				elseif not CheckFruitplr() and (TakeFruitInventory()) then
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LoadFruit", TakeFruitInventory())
				end
			elseif
				game.ReplicatedStorage.Remotes.CommF_:InvokeServer("TalkTrevor", "1") == 0
				and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 1
				and game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Zou") == 0
			then
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou")
			elseif not game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") then
				if CheckNameBoss("Don Swan") then
					local f = CheckNameBoss("Don Swan")
					repeat
						task.wait()
						sizepart(f)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(f.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(f.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						UsedualFlock()
						ClickM1(f)
					until not f or not f.Parent or f.Humanoid.Health == 0
				end
			elseif game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ZQuestProgress", "Check") == 0 then
				if
					(t.Character.HumanoidRootPart.Position - game:GetService("Workspace").Map.IndraIsland.Part.Position).Magnitude
					> 1000
				then
					toTarget(cframethangdaubuoiredhead)
					if (cframethangdaubuoiredhead.p - t.Character.HumanoidRootPart.Position).Magnitude <= 5 then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin")
					end
				else
					local f, V, Y = next, workspace.Enemies:GetChildren()
					for H, H in f, V, Y do
						if
							H.Name == "rip_indra"
							and (H:FindFirstChild("HumanoidRootPart"))
							and (H:FindFirstChild("Humanoid"))
							and H.Humanoid.Health > 0
						then
							if
								(H.HumanoidRootPart.Position - t.Character.HumanoidRootPart.Position).Magnitude > 300
							then
								toTarget(H.HumanoidRootPart.CFrame)
							else
								repeat
									task.wait()
									sizepart(H)
									if Settings["Select Weapon"] == "Blox Fruit" then
										toTarget(H.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
									else
										toTarget(H.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
									end
									ClickM1(H)
									UsedualFlock()
								until not workspace.Enemies:FindFirstChild("rip_indra")
							end
						end
					end
				end
			end
		else
			AutoQuestBarito()
		end
	end
end
local f = 0
function PathFindChest()
	local V, Y, H = next, game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()
	for C, C in V, Y, H do
		if C:IsA("Model") and (C:FindFirstChild("Part")) and not C:FindFirstChild("Ignored") then
			return C
		end
	end
end
function GetNearestChest()
	local V, Y, H = next, game:GetService("CollectionService"):GetTagged("_ChestTagged")
	local C, J, F = 1 / 0
	for q, c in V, Y, H do
		if not c:GetAttribute("IsDisabled") and not c:FindFirstChild("Ignored") then
			q = t:DistanceFromCharacter(c.Position)
			if q < C then
				C, J, F = q, i, c
			end
		end
	end
	return F
end
getgenv().DetectRaidCastle = false
-- Aviso da Raid Pirata: quando uma notificação falar de pirate + raid/castle, marca o horário.
-- O Auto Pirate Raid usa isso para vir ao Castelo do Mar assim que o aviso aparece.
do
	pcall(function()
		if getgenv().__PirateWarnConn then
			getgenv().__PirateWarnConn:Disconnect()
		end
	end)
	local function CheckWarn(obj)
		local ok, txt = pcall(function()
			return obj.Text
		end)
		if not ok or typeof(txt) ~= "string" or #txt < 8 then
			return
		end
		local low = txt:lower()
		if low:find("pirate") and (low:find("raid") or low:find("castle") or low:find("attack") or low:find("invad")) then
			getgenv().__PirateRaidWarn = tick()
		end
	end
	getgenv().__PirateWarnConn = t:WaitForChild("PlayerGui").DescendantAdded:Connect(function(obj)
		if obj:IsA("TextLabel") or obj:IsA("TextButton") then
			CheckWarn(obj)
			obj:GetPropertyChangedSignal("Text"):Connect(function()
				CheckWarn(obj)
			end)
		end
	end)
end
getgenv().ValueCollectChestSpawnGod = 0
getgenv().__StackGen = (getgenv().__StackGen or 0) + 1
task.spawn(function()
	local MyStackGen = getgenv().__StackGen
	while task.wait() and getgenv().__StackGen == MyStackGen do
		local V, V = pcall(function()
			if Settings["Auto New World"] then
				if game.PlaceId == getgenv().CheckPlaceId3 and t.Data.Level.Value >= 700 then
					StackFarm = false
					StackFarmOther = false
					if
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Dressrosa") ~= 0
					then
						if game.Workspace.Map.Ice.Door.CanCollide then
							if not t.Character:FindFirstChild("Key") and not t.Backpack:FindFirstChild("Key") then
								if
									(
										CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359).Position
										- t.Character.HumanoidRootPart.Position
									).magnitude < 5
								then
									game.ReplicatedStorage.Remotes.CommF_:InvokeServer(
										"DressrosaQuestProgress",
										"Detective"
									)
									equiptool("Key")
								else
									toTarget(CFrame.new(4852.2895507813, 5.651451587677, 718.53070068359))
								end
							else
								equiptool("Key")
								if t.Character:FindFirstChild("Key") then
									toTarget(game.Workspace.Map.Ice.Door.CFrame)
								end
							end
						elseif CheckNameBoss("Ice Admiral") then
							local Y = CheckNameBoss("Ice Admiral")
							repeat
								task.wait()
								sizepart(Y)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
								ClickM1(Y)
								UsedualFlock()
							until not Y or not Y.Parent or Y.Humanoid.Health == 0 or not Settings["Auto New World"]
						end
					else
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
					end
					return
				end
			end
			if
				Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
				and getgenv().GoCollectChest
			then
				StackFarm = false
				StackFarmOther = false
				if getgenv().ValueCollectChestSpawnGod >= 10 then
					getgenv().GoCollectChest = false
					getgenv().ValueCollectChestSpawnGod = 0
				end
				local Y = GetNearestChest()
				if Y then
					getgenv().ValueCollectChestSpawnGod = getgenv().ValueCollectChestSpawnGod + 1
					local H
					repeat
						task.wait()
						if
							(game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Y.Position).Magnitude <= 5
						then
							if not H then
								H = (tick())
							elseif tick() - H >= 5 then
								Instance.new("IntValue", Y).Name = "Ignored"
								wait(0.1)
							end
							if not Settings["Use Method Teleport"] then
								game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
								wait()
								game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
							end
							TweenManager.CancelCurrent()
						end
						if Settings["Use Method Teleport"] then
							t.Character.HumanoidRootPart.CFrame = Y.CFrame
							TweenManager.CancelCurrent()
						else
							toTarget(Y.CFrame, true)
						end
					until not Y
						or not Y.Parent
						or not Settings["Collect Chest When Server Spawn God's Chalice or Fist of Darkness"]
						or (Y:GetAttribute("IsDisabled"))
						or (Y:FindFirstChild("Ignored"))
						or not Y:FindFirstChild("TouchInterest")
					return
				else
					local Y = PathFindChest()
					if Y then
						toTarget(Y.Part.CFrame)
						if
							(Y.Part.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
							or (GetNearestChest())
						then
							Instance.new("IntValue", Y).Name = "Ignored"
						end
					else
						for Y, Y in pairs(game:GetService("Workspace")._WorldOrigin.PlayerSpawns.Pirates:GetChildren()) do
							if Y:FindFirstChild("Ignored") then
								Y:FindFirstChild("Ignored"):Destroy()
							end
						end
					end
				end
			end
			if game.PlaceId == getgenv().CheckPlaceId2 and Settings["Auto Third World"] then
				if StopThirdSea() then
					StackFarm = false
					StackFarmOther = false
					SeaThird()
					return
				end
			end
			if Settings["Attack Darkbeard"] then
				local Y = CheckNameBoss("Darkbeard")
				if Y then
					StackFarm = false
					StackFarmOther = false
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Darkbeard"]
					return
				else
					if Settings["Summon Darkbeard"] and (DetectItemPlr("Fist of Darkness")) then
						StackFarm = false
						StackFarmOther = false
						if
							(
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.Position
								- t.Character.HumanoidRootPart.Position
							).Magnitude <= 5
						then
							equiptool("Fist of Darkness")
							firetouchinterest(
								game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								0
							)
							firetouchinterest(
								game.Players.LocalPlayer.Character["Fist of Darkness"].Handle,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								1
							)
							firetouchinterest(
								t.Character.HumanoidRootPart,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								0
							)
							firetouchinterest(
								t.Character.HumanoidRootPart,
								game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection,
								1
							)
						else
							toTarget(game:GetService("Workspace").Map.DarkbeardArena.Summoner.Detection.CFrame)
						end
						return
					end
					spawn(function()
						if Settings["Hop Find Darkbeard"] then
							SpecialHop("Darkbeard")
						end
					end)
				end
			end
			if Settings["Attack Rip Indra"] then
				local Y = CheckNameBoss("rip_indra True Form")
				if Y then
					StackFarm = false
					StackFarmOther = false
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Rip Indra"]
					return
				end
			end
			if Settings["Auto Touch Pad Haki"] and Settings["Auto Summon Rip Indra"] then
				if DetectItemPlr("God's Chalice") then
					StackFarm = false
					StackFarmOther = false
					if
						not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
						or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle
							:FindFirstChildOfClass("Part")
					then
						toTarget(CFrame.new(-5500, 314, -2855))
						return
					end
					if DetectButtons() then
						TouchPadHaki()
						return
					elseif not DetectButtons() then
						equiptool("God's Chalice")
						toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
						return
					end
				end
			elseif Settings["Auto Touch Pad Haki"] then
				StackFarm = false
				StackFarmOther = false
				if
					not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
					or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part")
				then
					toTarget(CFrame.new(-5500, 314, -2855))
					return
				end
				if DetectButtons() then
					TouchPadHaki()
				end
				return
			elseif Settings["Auto Summon Rip Indra"] and (DetectItemPlr("God's Chalice")) then
				StackFarm = false
				StackFarmOther = false
				if
					not game:GetService("Workspace").Map:FindFirstChild("Boat Castle")
					or not game:GetService("Workspace").Map["Boat Castle"].Summoner.Circle:FindFirstChildOfClass("Part")
				then
					toTarget(CFrame.new(-5500, 314, -2855))
					return
				end
				equiptool("God's Chalice")
				toTarget(game:GetService("Workspace").Map["Boat Castle"].Summoner.Detection.CFrame)
				return
			end
			if Settings["Attack Soul Reaper"] then
				local Y = CheckNameBoss("Soul Reaper")
				if Y then
					StackFarm = false
					StackFarmOther = false
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Soul Reaper"]
					return
				else
					StackFarm = false
					StackFarmOther = false
					if Settings["Summon Soul Reaper"] and (DetectItemPlr("Hallow Essence")) then
						if
							not game:GetService("Workspace").Map:FindFirstChild("Haunted Castle")
							or not game:GetService("Workspace").Map["Haunted Castle"].Summoner
								:FindFirstChild("Detection")
						then
							toTarget((CFrame.new(-9513.466796875, 142.09776306152344, 5528.83740234375)))
							return
						end
						if
							(
								t.Character.HumanoidRootPart.Position
								- game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.Position
							).Magnitude > 8
						then
							toTarget(game:GetService("Workspace").Map["Haunted Castle"].Summoner.Detection.CFrame)
						else
							equiptool("Hallow Essence", true)
						end
						return
					end
				end
			end
			if Settings["Attack Dough King"] then
				local Y = CheckNameBoss("Dough King")
				if Y then
					StackFarm = false
					StackFarmOther = false
					repeat
						task.wait()
						sizepart(Y)
						if Settings["Select Weapon"] == "Blox Fruit" then
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
						else
							toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
						end
						ClickM1(Y)
						UsedualFlock()
					until not IsMobAlive(Y) or not Settings["Attack Dough King"]
					return
				else
					spawn(function()
						if Settings["Hop Find Dough King"] then
							SpecialHop("Dough King")
						end
					end)
					if Settings["Summon Dough King"] then
						if not DetectItemPlr("Sweet Chalice") then
							if
								game.ReplicatedStorage.Remotes.CommF_:InvokeServer("SweetChaliceNpc")
								== "Where are the items?"
							then
								if not CheckCountItem("Conjured Cocoa", 10) then
									StackFarm = false
									StackFarmOther = false
									if not DetectMob(P) then
										if typeof(P) == "table" then
											if #N >= #P then
												N = {}
												return
											end
											local Y = DetectPartSpawnMob(DetectNameTablePart(P))
											if Y then
												table.insert(N, DetectNameTablePart(P))
												repeat
													wait()
													toTarget(Y.CFrame * CFrame.new(0, 60, 0))
												until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude
														<= 100
													or (DetectMob(P))
													or not Settings["Attack Dough King"]
												wait(1)
											end
										else
											local Y = DetectPartSpawnMob(P, true)
											if Y then
												Instance.new("IntValue", Y).Name = "Ignored"
												repeat
													wait()
													toTarget(Y.CFrame * CFrame.new(0, 60, 0))
												until (Y.Position - t.Character.HumanoidRootPart.Position).Magnitude
														<= 100
													or (DetectMob(P))
													or not Settings["Attack Dough King"]
												wait(1)
											else
												DeleteIgnoredMobSpawn()
											end
										end
									else
										local Y = DetectMob(P)
										repeat
											task.wait()
											sizepart(Y)
											BringMob(Y)
											UsedualFlock()
											ClickM1(Y)
											if Settings["Select Weapon"] == "Blox Fruit" then
												toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
											else
												toTarget(Y.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
											end
										until not Y
											or not Y.Parent
											or Y.Humanoid.Health == 0
											or not Settings["Attack Dough King"]
									end
								elseif not DetectItemPlr("God's Chalice") then
									local P = DetectEliteHunter()
									if not P then
										EliteRequest()
									end
									if P then
										StackFarm = false
										StackFarmOther = false
										if not EliteQuestOK(P.Name) then
		-- (pedido da missão feito por EliteQuestOK)
	else
											repeat
												task.wait()
												sizepart(P)
												if Settings["Select Weapon"] == "Blox Fruit" then
													toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
												else
													toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
												end
												ClickM1(P)
												UsedualFlock()
											until not P
												or not P.Parent
												or P.Humanoid.Health == 0
												or not Settings["Attack Dough King"]
										end
										return
									else
										A.CreateNoti({
											Title = "Nexora Hub",
											Desc = "Waiting Elite Hunter",
											ShowTime = 5,
										})
										wait(5)
									end
								end
							end
						elseif not DetectMob(y) then
							if typeof(y) == "table" then
								if #N >= #y then
									N = {}
									return
								end
								local P = DetectPartSpawnMob(DetectNameTablePart(y))
								if P then
									table.insert(N, DetectNameTablePart(y))
									repeat
										wait()
										toTarget(P.CFrame * CFrame.new(0, 60, 0))
									until (P.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(y))
										or not Settings["Attack Dough King"]
									wait(1)
								end
							else
								local P = DetectPartSpawnMob(y, true)
								if P then
									Instance.new("IntValue", P).Name = "Ignored"
									repeat
										wait()
										toTarget(P.CFrame * CFrame.new(0, 60, 0))
									until (P.Position - t.Character.HumanoidRootPart.Position).Magnitude <= 100
										or (DetectMob(y))
										or not Settings["Attack Dough King"]
									wait(1)
								else
									DeleteIgnoredMobSpawn()
								end
							end
						else
							local P = DetectMob(y)
							repeat
								task.wait()
								sizepart(P)
								BringMob(P)
								UsedualFlock()
								ClickM1(P)
								if Settings["Select Weapon"] == "Blox Fruit" then
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(-7, 20, 0))
								else
									toTarget(P.HumanoidRootPart.CFrame * CFrame.new(7, 20, 0))
								end
							until not P or not P.Parent or P.Humanoid.Health == 0 or not Settings["Attack Dough King"]
						end
					end
				end
			end
            if Settings["Auto Elite Hunter"] then
				-- Mantém a solicitação original da missão e a detecção original dos Elites.
				-- Se o NPC ainda não estiver carregado, vai ao marcador de spawn e procura novamente.
				local EliteNames = { "Deandre", "Urban", "Diablo" }

				local function GetEliteQuestName()
					local found
					pcall(function()
						local quest = t.PlayerGui.Main.Quest
						if quest and quest.Visible then
							local titleObj = quest.Container.QuestTitle.Title
						local title = titleObj and tostring(titleObj.Text) or ""
						for _, name in ipairs(EliteNames) do
							if string.find(title, name, 1, true) then
								found = name
								break
							end
						end
					end
					end)
					return found
				end

				local function FindElite(name)
					local target = name and DetectMob(name) or DetectMob(EliteNames)
					if target and IsMobAlive(target) then return target end
					target = DetectEliteHunter()
					if target then return target end
					-- Longe: procura em qualquer lugar (ReplicatedStorage, workspace, instâncias fora da árvore).
					local wanted = name and { name } or EliteNames
					local function scan(root)
						if not root then return nil end
					-- Evita parar numa cópia morta/descarregada do mesmo Elite.
					for _, inst in ipairs(root:GetDescendants()) do
						if inst:IsA("Model") and table.find(wanted, inst.Name) and IsMobAlive(inst) then
							return inst
						end
					end
					end
					local found = scan(game:GetService("ReplicatedStorage")) or scan(workspace)
					if found then return found end
					pcall(function()
						for _, inst in ipairs(getnilinstances and getnilinstances() or {}) do
							if inst:IsA("Model") and table.find(wanted, inst.Name) and IsMobAlive(inst) then found = inst; break end
						end
					end)
					return found
				end


				local questName = GetEliteQuestName()
				if not questName then
					EliteRequest()
					local questDeadline = tick() + 10
					repeat
						task.wait(0.25)
						questName = GetEliteQuestName()
					until questName or tick() >= questDeadline or not Settings["Auto Elite Hunter"]
				end
				if not Settings["Auto Elite Hunter"] then return end

				-- Usa somente o deslocamento original do hub (toTarget no HRP do Elite).
				-- Aqui apenas procura/revalida o NPC; não cria deslocamento separado para spawn.
				local target = FindElite(questName)
				while not target and Settings["Auto Elite Hunter"] do
					task.wait(0.5)
					questName = GetEliteQuestName() or questName
					target = FindElite(questName) or DetectEliteHunter()
					if not target then
						-- Sem modelo carregado: vai até o ponto de spawn do Elite (toTarget cuida da longa distância).
						local spawnPart
						pcall(function()
							local spawns = workspace._WorldOrigin.EnemySpawns
							for _, n in ipairs(questName and { questName } or EliteNames) do
								local sp = spawns:FindFirstChild(n, true)
								if sp then
									spawnPart = sp:IsA("BasePart") and sp or sp:FindFirstChildWhichIsA("BasePart", true)
									if spawnPart then break end
								end
							end
						end)
						if spawnPart then toTarget(spawnPart.CFrame * CFrame.new(0, 40, 0)) end
					end
				end

				if target and IsMobAlive(target) then
					StackFarm = false
					StackFarmOther = false
					local targetName = target.Name
					repeat
						task.wait(0.05)
						if not IsMobAlive(target) then target = FindElite(targetName) or DetectEliteHunter() end
						if target and IsMobAlive(target) then
							local hrp = target:FindFirstChild("HumanoidRootPart")
							if hrp then
								pcall(sizepart, target)
								local offset = Settings["Select Weapon"] == "Blox Fruit"
									and CFrame.new(-7, getgenv().YPosFruit or 20, 0)
									or CFrame.new(7, 20, 0)
								toTarget(hrp.CFrame * offset)
								ClickM1(target)
								UsedualFlock()
							end
						else
							-- O alvo pode ter sido descarregado; volta a procurar o modelo real.
							target = FindElite(targetName) or DetectEliteHunter()
						end
					until not Settings["Auto Elite Hunter"] or not target or not IsMobAlive(target)
					return
				end

				if Settings["Auto Elite Hunter"] then
					if Settings["Hop Server Elite Hunter"] and not DetectItemPlr("God's Chalice") then
						HopServer()
					elseif DetectItemPlr("God's Chalice") then
						toTarget(CFrame.new(-12463.8740234375, 374.9144592285156, -7523.77392578125))
					else
						A.CreateNoti({ Title = "Nexora Hub", Desc = "Searching Elite spawn", ShowTime = 5 })
					end
				end
			end

			if Settings["Auto Factory"] then
				CoreBoss = CheckNameBoss("Core")
				if CoreBoss then
					StackFarm = false
					StackFarmOther = false
					repeat
						task.wait()
						toTarget(CoreBoss.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0))
						ClickM1(CoreBoss)
						UsedualFlock()
					until not IsMobAlive(CoreBoss) or not Settings["Auto Factory"]
					return
				end
			end
			if Settings["Auto Pirate Raid"] and getgenv().__PirateCastleReady then
				local raidActive = t.PlayerGui.Main.TopHUDList.RaidTimer.Visible
				local warnFresh = getgenv().__PirateRaidWarn and tick() - getgenv().__PirateRaidWarn < 300
				local y = GetPirateRaid()
				if y or raidActive or warnFresh then
					getgenv().__PirateRaidSeen = tick()
				end
				-- Antes, DetectRaidCastle nunca voltava a false e o farm ficava preso no castelo.
				if
					getgenv().DetectRaidCastle
					and not y
					and not raidActive
					and not warnFresh
					and tick() - (getgenv().__PirateRaidSeen or 0) > 25
				then
					getgenv().DetectRaidCastle = false
				end
				if y then
					getgenv().DetectRaidCastle = true
					StackFarm = false
					StackFarmOther = false
					local P = Settings["Select Weapon"] == "Blox Fruit" and (CFrame.new(-7, 20, 0))
						or (CFrame.new(7, 20, 0))
					repeat
						task.wait()
						UsedualFlock()
						sizepart(y)
						ClickM1(y)
						toTarget(y.HumanoidRootPart.CFrame * P)
					until not IsMobAlive(y) or not Settings["Auto Pirate Raid"]
				elseif (raidActive or warnFresh or getgenv().DetectRaidCastle) and game.PlaceId == getgenv().CheckPlaceId3 then
					StackFarm = false
					StackFarmOther = false
					getgenv().DetectRaidCastle = true
					toTarget(CFrame.new(-5543, 313, -2964))
				end
			end
			
			if Settings["Teleport To Fruit"] then
				local y = GetPathFruitCached()
				local character = t.Character
				local root = character and character:FindFirstChild("HumanoidRootPart")
				local handle = y and y:FindFirstChild("Handle")
				if not handle and y and y:IsA("BasePart") then handle = y end
				if y and handle and root then
					StackFarm = false
					StackFarmOther = false
					local dist = (handle.Position - root.Position).Magnitude
					if dist <= 15 then
						getgenv().noclip = false
						-- Só aproxima suavemente; não posiciona o personagem diretamente na fruta.
						if dist > 5 then
							toTarget(handle.CFrame * CFrame.new(0, 2, 0))
							task.wait(0.15)
						end
						task.wait(0.15)
						pcall(function()
							firetouchinterest(root, handle, 0)
							task.wait(0.1)
							firetouchinterest(root, handle, 1)
						end)
						pcall(function()
							for _, pp in ipairs(y:GetDescendants()) do
								if pp:IsA("ProximityPrompt") then
									fireproximityprompt(pp)
								end
							end
						end)
						pcall(function()
							game:GetService("VirtualInputManager"):SendKeyEvent(true, "Space", false, game)
							task.wait(0.1)
							game:GetService("VirtualInputManager"):SendKeyEvent(false, "Space", false, game)
						end)
						-- Limpa cache pra procurar próxima fruta
						getgenv().__CachedFruit = nil
						getgenv().__LastFruitScan = 0
						-- NÃO dá return, continua procurando próxima fruta
					else
						-- Aproximação sempre via toTarget, inclusive acima de 1500 studs.
						-- Não usa CFrame direto nem teleporte em etapas quando a fruta está longe.
						getgenv().noclip = true
						pcall(function()
							toTarget(handle.CFrame * CFrame.new(0, 3, 0))
						end)
					end
				else
					-- Nenhuma fruta encontrada, espera um pouco
					task.wait(0.5)
				end
				if Settings["Teleport To Fruit [ Hop Server ]"] and not GetPathFruitCached() then
					HopServer()
					task.wait(5)
				end
			end
			if not StackFarm then
				StackFarm = true
			end
			if not StackFarmOther then
				StackFarmOther = true
			end
		end)
	end
end)

-- ===================== NEXORA HALLOWEEN 2026 - INTEGRADO DO ZYROX - ViniZDev =====================
-- Trick or Treat = porta a porta (Zyrox logic) | Jack Hunt = Pumpkin Hunt (Zyrox logic)
SpokyHalloweenSection = FarmotherMain.CreateSection("Hellfire Halloween 2026 [ZYROX INTEGRADO]")

-- Variaveis globais compatíveis com Zyrox
_G.HalloweenFarm = _G.HalloweenFarm or false
_G.HalloweenTween = _G.HalloweenTween or true
_G.HalloweenKillJack = _G.HalloweenKillJack ~= false
_G.HalloweenCooldown = _G.HalloweenCooldown or 5

-- ========== TOGGLE 1: JACK LANTERN HUNT (Pumpkin Hunt do Zyrox) ==========
do
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer

local state = { on = false, noclip = nil, skip = {}, current = nil }

local function notify(msg)
    pcall(function()
        -- tenta notificar se tiver
        if game:GetService("StarterGui") then
            game:GetService("StarterGui"):SetCore("SendNotification", {Title="Halloween", Text=msg, Duration=4})
        end
    end)
    print("[Jack Hunt] "..msg)
end

local function clearMovers()
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp then
            for _, name in ipairs({ "FarmBodyVelocity", "FarmBodyGyro" }) do
                local mover = hrp:FindFirstChild(name)
                if mover then mover:Destroy() end
            end
        end
        if hum then hum.PlatformStand = false end
    end)
end

local function applyMovers(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    local bodyClip = hrp:FindFirstChild("BodyClip")
    if bodyClip then bodyClip:Destroy() end
    if not hrp:FindFirstChild("FarmBodyVelocity") then
        local v = Instance.new("BodyVelocity")
        v.Name = "FarmBodyVelocity"
        v.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        v.Velocity = Vector3.new(0,0,0)
        v.Parent = hrp
    end
    if not hrp:FindFirstChild("FarmBodyGyro") then
        local g = Instance.new("BodyGyro")
        g.Name = "FarmBodyGyro"
        g.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        g.D = 10
        g.P = 3000
        g.CFrame = hrp.CFrame
        g.Parent = hrp
    end
    hum.PlatformStand = true
    return hrp
end

local function pumpkinPart(obj)
    if not obj then return nil end
    if obj:IsA("BasePart") then return obj end
    if obj:IsA("Model") and obj.PrimaryPart then return obj.PrimaryPart end
    return obj:FindFirstChild("HumanoidRootPart", true) or obj:FindFirstChildWhichIsA("BasePart", true)
end
local function pumpkinHealth(obj)
    local h = obj:FindFirstChildOfClass("Humanoid")
    if h then return h.Health end
    local v = obj:FindFirstChild("Health")
    if v and v:IsA("ValueBase") and tonumber(v.Value) then return tonumber(v.Value) end
    return nil
end
local function pumpkinDead(obj)
    if not obj or not obj.Parent or not obj:IsDescendantOf(workspace) then return true end
    if obj:GetAttribute("Collected") or obj:GetAttribute("Taken") then return true end
    local hp = pumpkinHealth(obj)
    return hp ~= nil and hp <= 0
end

local VIM = game:GetService("VirtualInputManager")
local function equipAttackTool()
    local char = plr.Character
    if not char or char:FindFirstChildOfClass("Tool") then return end
    pcall(function() if EquipWeapon then EquipWeapon(_G.SelectWeapon) end end)
    if char:FindFirstChildOfClass("Tool") then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    for _, tool in ipairs(plr.Backpack:GetChildren()) do
        if tool:IsA("Tool") and (tool.ToolTip == "Melee" or tool.ToolTip == "Sword") and hum then
            pcall(function() hum:EquipTool(tool) end)
            break
        end
    end
end
local function hitPumpkin(obj, part)
    local modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
    local net = modules and modules:FindFirstChild("Net")
    local ra = net and net:FindFirstChild("RE/RegisterAttack")
    local rh = net and net:FindFirstChild("RE/RegisterHit")
    if not (ra and rh) then return end
    pcall(function() ra:FireServer(0) end)
    pcall(function() rh:FireServer(part, { { obj, part } }) end)
    pcall(function() rh:FireServer(part) end)
end
local function clickPumpkin()
    pcall(function()
        local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
        if tool then tool:Activate() end
    end)
    pcall(function()
        VIM:SendMouseButtonEvent(0,0,0,true,game,0)
        VIM:SendMouseButtonEvent(0,0,0,false,game,0)
    end)
end

local function flyTo(hrp, goal)
    local speed = tonumber(getgenv().TweenSpeedFar) or 270
    local dist = (hrp.Position - goal.Position).Magnitude
    local time = math.max(dist / speed, 0.05)
    local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), { CFrame = goal })
    local done = false
    tween.Completed:Connect(function() done = true end)
    tween:Play()
    local started = tick()
    while not done and state.on and tick() - started < time + 2 do
        if state.current and not state.current:IsDescendantOf(workspace) then break end
        task.wait(0.05)
    end
    tween:Cancel()
end

local function nearestPumpkin(hrp)
    local folder = workspace:FindFirstChild("PumpkinHunt")
    if not folder then return nil end
    local best, bestObj, bestDist = nil, nil, math.huge
    for _, obj in ipairs(folder:GetChildren()) do
        if obj:GetAttribute("Collected") or obj:GetAttribute("Taken") or state.skip[obj] then
        else
            local pos
            if obj:IsA("Model") then
                pos = obj.PrimaryPart and obj.PrimaryPart.Position
                if not pos then
                    local ok, pivot = pcall(function() return obj:GetPivot().Position end)
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

local function fightPumpkin(obj)
    local started, lastHit = tick(), 0
    local lastHp, hpSince = nil, tick()
    while state.on do
        if pumpkinDead(obj) then return true end
        if tick() - started > 40 then return false end
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local part = pumpkinPart(obj)
        if not hrp or not part then return false end
        local goal = CFrame.new(part.Position + Vector3.new(0,5,0))
        if (hrp.Position - part.Position).Magnitude > 12 then
            applyMovers(char)
            if _G.HalloweenTween then flyTo(hrp, goal) else hrp.CFrame = goal end
        else
            clearMovers()
            hrp.CFrame = goal
            hrp.AssemblyLinearVelocity = Vector3.zero
        end
        if tick() - lastHit >= 0.12 then
            lastHit = tick()
            equipAttackTool()
            hitPumpkin(obj, part)
            clickPumpkin()
        end
        local hp = pumpkinHealth(obj)
        if hp then
            if hp ~= lastHp then lastHp, hpSince = hp, tick()
            elseif tick() - hpSince > 15 then return false end
        end
        task.wait(0.05)
    end
    return false
end

local function fightPumpkinSafe(obj)
    local prev = _G.HalloweenFarm
    _G.HalloweenFarm = true
    local ok, res = pcall(fightPumpkin, obj)
    _G.HalloweenFarm = prev
    return ok and res or false
end

local function nearbyMonster(hrp)
    local enemies = workspace:FindFirstChild("Enemies")
    if not enemies then return nil end
    local jack, jackDist, near, nearDist = nil, 150, nil, 60
    for _, mob in ipairs(enemies:GetChildren()) do
        local root = mob:FindFirstChild("HumanoidRootPart")
        if root and root.Parent and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChildOfClass("Humanoid").Health > 0 then
            local dist = (root.Position - hrp.Position).Magnitude
            if string.find(string.lower(mob.Name), "jack") then
                if dist < jackDist then jack, jackDist = mob, dist end
            elseif dist < nearDist then
                near, nearDist = mob, dist
            end
        end
    end
    if _G.HalloweenKillJack ~= false and jack then return jack end
    return near
end

local function huntWindow()
    local window = tonumber(_G.HalloweenCooldown) or 5
    local started = tick()
    clearMovers()
    _G.HalloweenFarm = true
    pcall(function()
        while state.on and tick() - started < window do
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local mob = hrp and nearbyMonster(hrp)
            if mob then
                local fightStart, lastHp, since = tick(), nil, tick()
                while state.on and mob.Parent and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChildOfClass("Humanoid").Health > 0 and tick() - fightStart < 30 do
                    task.wait()
                    pcall(function() if t9 and t9.Kill then t9.Kill(mob, true) end end)
                    pcall(function()
                        if toTarget then toTarget(mob.HumanoidRootPart.CFrame * CFrame.new(0,8,0)) end
                    end)
                    local hp = mob:FindFirstChildOfClass("Humanoid").Health
                    if lastHp ~= hp then lastHp, since = hp, tick()
                    elseif tick() - since > 12 then
                        mob:SetAttribute("ZyroxSkip", tick())
                        break
                    end
                end
                break
            end
            task.wait(0.15)
        end
    end)
    _G.HalloweenFarm = false
    task.wait(0.1)
    pcall(function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:FindFirstChild("BodyClip") then hrp.BodyClip:Destroy() end
    end)
end

local startJack, stopJack

startJack = function()
    if state.on then return end
    if not workspace:FindFirstChild("PumpkinHunt") then
        notify("PumpkinHunt nao encontrado, tentando mesmo assim.")
    end
    state.on = true
    notify("Jack Lantern Hunt ligado!")
    pcall(function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:FindFirstChild("BodyClip") then hrp.BodyClip:Destroy() end
    end)
    state.noclip = RunService.Stepped:Connect(function()
        local char = plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
    task.spawn(function()
        while state.on do
            pcall(function()
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if not hrp or not hum or hum.Health <= 0 then return end
                local _, obj = nearestPumpkin(hrp)
                if not obj then
                    clearMovers()
                    state.current = nil
                    if next(state.skip) then state.skip = {} end
                    return
                end
                state.current = obj
                local killed = fightPumpkinSafe(obj)
                state.current = nil
                clearMovers()
                state.skip[obj] = true
                if killed then huntWindow() end
            end)
            task.wait(0.2)
        end
    end)
end

stopJack = function()
    state.on = false
    if state.noclip then state.noclip:Disconnect() state.noclip = nil end
    pcall(clearMovers)
    notify("Jack Lantern Hunt desligado.")
end

SpokyHalloweenSection.CreateToggle(
    { Title = "Auto Jack O-Lantern Hunt", Desc = "Zyrox: Voa ate abobora, bate ate matar, depois mata Jack", Default = Settings["Auto Jack O-Lantern Hunt"] or false },
    function(V)
        Settings["Auto Jack O-Lantern Hunt"] = V
        SaveSettings("Auto Jack O-Lantern Hunt", V)
        if V then startJack() else stopJack() end
    end
)
end

-- ========== TOGGLE 2: TRICK OR TREAT (Porta a Porta do Zyrox) ==========
do
local RunService = game:GetService("RunService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local plr = game.Players.LocalPlayer

local trick = { on = false, noclip = nil, flying = false, visited = {}, doors = {}, scannedAt = 0, warned = false, useBig = true, killMobs = true, mobRadius = 120, hitGhost = true, ghosts = {} }

local function notifyT(msg)
    print("[TrickOrTreat] "..msg)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title="Trick Or Treat", Text=msg, Duration=4})
    end)
end

local function clearMoversT()
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp then
            for _, name in ipairs({ "FarmBodyVelocity", "FarmBodyGyro" }) do
                local mover = hrp:FindFirstChild(name)
                if mover then mover:Destroy() end
            end
        end
        if hum then hum.PlatformStand = false end
    end)
end

local function applyMoversT(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    local bodyClip = hrp:FindFirstChild("BodyClip")
    if bodyClip then bodyClip:Destroy() end
    if not hrp:FindFirstChild("FarmBodyVelocity") then
        local v = Instance.new("BodyVelocity")
        v.Name = "FarmBodyVelocity"
        v.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        v.Velocity = Vector3.new(0,0,0)
        v.Parent = hrp
    end
    if not hrp:FindFirstChild("FarmBodyGyro") then
        local g = Instance.new("BodyGyro")
        g.Name = "FarmBodyGyro"
        g.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        g.D = 10
        g.P = 3000
        g.CFrame = hrp.CFrame
        g.Parent = hrp
    end
    hum.PlatformStand = true
    return hrp
end

local keywords = { "knock", "trick", "treat" }
local function matchText(text)
    text = string.lower(tostring(text or ""))
    for _, key in ipairs(keywords) do if string.find(text, key, 1, true) then return true end end
    return false
end
local function isDoorObject(inst)
    local node, depth = inst, 0
    while node and node ~= workspace and depth < 5 do
        if matchText(node.Name) then return true end
        local name = string.lower(node.Name)
        if string.find(name, "halloween", 1, true) and string.find(name, "door", 1, true) then return true end
        node = node.Parent depth = depth + 1
    end
    return false
end
local function objectPart(inst)
    local node = inst.Parent
    while node and node ~= workspace do
        if node:IsA("BasePart") then return node end
        if node:IsA("Attachment") and node.Parent and node.Parent:IsA("BasePart") then return node.Parent end
        if node:IsA("Model") then return node.PrimaryPart or node:FindFirstChildWhichIsA("BasePart", true) end
        node = node.Parent
    end
    return nil
end
local function isBigDoor(inst)
    local node, depth = inst, 0
    while node and node ~= workspace and depth < 6 do
        if string.find(string.lower(node.Name), "halloweendoor2", 1, true) then return true end
        node = node.Parent depth = depth + 1
    end
    return false
end
local function doorPos(door)
    local p = door.inst.Parent
    if p then
        if p:IsA("Attachment") then return p.WorldPosition end
        if p:IsA("BasePart") then return p.Position end
    end
    return door.part.Position
end
local function nobodyHome()
    local ok, res = pcall(function()
        local pg = plr:FindFirstChildOfClass("PlayerGui")
        if not pg then return false end
        for _, g in ipairs(pg:GetDescendants()) do
            if g:IsA("TextLabel") and g.Visible and g.Text ~= "" then
                local low = string.lower(g.Text)
                if string.find(low, "nobody is home", 1, true) or string.find(low, "nobody's home", 1, true) then return true end
            end
        end
        return false
    end)
    return ok and res
end
local function scanDoors(maxAge)
    if tick() - trick.scannedAt < (maxAge or 120) then return trick.doors end
    trick.scannedAt = tick()
    local list, count = {}, 0
    for _, inst in ipairs(workspace:GetDescendants()) do
        if inst:IsA("ProximityPrompt") or inst:IsA("ClickDetector") then
            local text = ""
            if inst:IsA("ProximityPrompt") then text = inst.ActionText .. " " .. inst.ObjectText end
            if matchText(text) or isDoorObject(inst) then
                local part = objectPart(inst)
                if part then table.insert(list, { inst = inst, part = part, big = isBigDoor(inst) }) end
            end
        end
        count = count + 1
        if count % 4000 == 0 then task.wait() end
    end
    trick.doors = list
    return list
end
local function goToT(goal)
    local char = plr.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local dist = (hrp.Position - goal.Position).Magnitude
    if dist <= 8 then return end
    trick.flying = true
    if _G.HalloweenTween or dist > 400 then
        applyMoversT(char)
        local speed = tonumber(getgenv().TweenSpeedFar) or 270
        local time = math.max(dist / speed, 0.05)
        local tween = game:GetService("TweenService"):Create(hrp, TweenInfo.new(time, Enum.EasingStyle.Linear), { CFrame = goal })
        local done = false
        tween.Completed:Connect(function() done = true end)
        tween:Play()
        local started = tick()
        while not done and trick.on and tick() - started < time + 3 do task.wait(0.05) end
        tween:Cancel()
        clearMoversT()
    else
        hrp.CFrame = goal
    end
    trick.flying = false
end
local function triggerDoor(door)
    local inst = door.inst
    if inst:IsA("ProximityPrompt") then
        pcall(function()
            inst.RequiresLineOfSight = false
            inst.MaxActivationDistance = math.max(inst.MaxActivationDistance, 30)
        end)
        pcall(function() inst.HoldDuration = 0 end)
        local fired = false
        if fireproximityprompt then fired = pcall(fireproximityprompt, inst) end
        if not fired then
            pcall(function()
                local key = inst.KeyboardKeyCode
                if key == Enum.KeyCode.Unknown then key = Enum.KeyCode.E end
                VirtualInputManager:SendKeyEvent(true, key, false, game)
                task.wait(0.2)
                VirtualInputManager:SendKeyEvent(false, key, false, game)
            end)
        end
    elseif inst:IsA("ClickDetector") then
        if fireclickdetector then pcall(fireclickdetector, inst) end
    end
end
local function optionText(option)
    local text = option._text
    if type(text) == "table" then text = table.concat(text, " ") end
    return string.lower(tostring(text))
end
local function handleDialogue()
    local okReq, DC = pcall(function() return require(game:GetService("ReplicatedStorage"):WaitForChild("DialogueController", 3)) end)
    if not okReq or not DC then return false end
    local prefer = { "treat", "yes", "ok", "thank", "knock" }
    local decline = { "no thanks", "cancel", "bye", "leave", "nevermind", "never mind", "not now" }
    local started, seen = tick(), false
    while trick.on and tick() - started < 20 do
        task.wait(0.35)
        if not DC.Active and not seen and nobodyHome() then
            pcall(function() DC.close() end)
            return false, true
        end
        if DC.Active then
            seen = true
            local ok, active = pcall(function() return DC.getActiveDialogue() end)
            local page = ok and active and active._pageStack and active._pageStack[#active._pageStack]
            if page then
                local options = page._options or {}
                if #options == 0 then
                    pcall(function() DC.advance() end)
                else
                    local pick
                    for _, word in ipairs(prefer) do
                        for _, option in ipairs(options) do
                            if string.find(optionText(option), word, 1, true) then pick = option break end
                        end
                        if pick then break end
                    end
                    if not pick then
                        for _, option in ipairs(options) do
                            local t = optionText(option)
                            local isDecline = false
                            for _, d in ipairs(decline) do if string.find(t, d, 1, true) then isDecline = true break end end
                            if not isDecline then pick = option break end
                        end
                    end
                    if pick then pcall(function() DC.select(pick) end) else pcall(function() DC.close() end) return true, false end
                end
            end
        elseif seen then
            break
        elseif tick() - started > 6 then
            break
        end
    end
    pcall(function() DC.close() end)
    return seen, false
end

local function fightNew(before, doorPosV)
    if not trick.killMobs then return end
    local previous = _G.HalloweenFarm
    local started, lastSeen, seen = tick(), tick(), false
    local radius = tonumber(trick.mobRadius) or 120
    _G.HalloweenFarm = true
    clearMoversT()
    pcall(function()
        while trick.on and tick() - started < 45 do
            local char = plr.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local enemies = workspace:FindFirstChild("Enemies")
            if not hrp or not enemies then break end
            local target, best = nil, math.huge
            for _, mob in ipairs(enemies:GetChildren()) do
                local root = mob:FindFirstChild("HumanoidRootPart")
                if root and root.Parent and mob:FindFirstChildOfClass("Humanoid") and mob:FindFirstChildOfClass("Humanoid").Health > 0 then
                    local dPlayer = (root.Position - hrp.Position).Magnitude
                    local dDoor = doorPosV and (root.Position - doorPosV).Magnitude or dPlayer
                    local isNew = not before[mob]
                    if (isNew and (dDoor <= radius or dPlayer <= radius)) or dPlayer <= 20 then
                        if dPlayer < best then target, best = mob, dPlayer end
                    end
                end
            end
            if target then
                seen, lastSeen = true, tick()
                local hum = target:FindFirstChildOfClass("Humanoid")
                local fightStart, lastHp, since = tick(), nil, tick()
                while trick.on and hum and target.Parent and hum.Health > 0 and tick() - fightStart < 30 do
                    local tRoot = target:FindFirstChild("HumanoidRootPart")
                    local myHrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                    if not tRoot or not myHrp then break end
                    pcall(function() if t9 and t9.Kill then t9.Kill(target, true) end end)
                    if (myHrp.Position - tRoot.Position).Magnitude > 25 then
                        myHrp.CFrame = CFrame.lookAt(tRoot.Position + Vector3.new(0,8,0), tRoot.Position)
                        myHrp.AssemblyLinearVelocity = Vector3.zero
                    end
                    task.wait()
                    if lastHp ~= hum.Health then lastHp, since = hum.Health, tick()
                    elseif tick() - since > 12 then target:SetAttribute("ZyroxSkip", tick()) break end
                end
                before[target] = true
            else
                if tick() - lastSeen > (seen and 1.5 or 5) then break end
                task.wait(0.1)
            end
        end
    end)
    _G.HalloweenFarm = false
    task.wait(0.1)
    _G.HalloweenFarm = previous
    pcall(function()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        if hrp and hrp:FindFirstChild("BodyClip") then hrp.BodyClip:Destroy() end
    end)
end

local function isGhostName(name)
    name = string.lower(tostring(name or ""))
    if string.find(name, "ghostship", 1, true) or string.find(name, "ghost fruit", 1, true) then return false end
    return string.find(name, "ghost", 1, true) ~= nil
end
local function ghostPart(inst)
    if inst:IsA("BasePart") then return inst end
    return inst.PrimaryPart or inst:FindFirstChild("HumanoidRootPart", true) or inst:FindFirstChildWhichIsA("BasePart", true)
end
local function fightGhost(since)
    if not trick.hitGhost then return end
    local function pick()
        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
        local best, bestDist = nil, 400
        for _, g in ipairs(trick.ghosts) do
            if g.t >= since - 0.5 and g.inst.Parent and hrp then
                local part = ghostPart(g.inst)
                if part then
                    local dist = (part.Position - hrp.Position).Magnitude
                    if dist < bestDist then best, bestDist = g.inst, dist end
                end
            end
        end
        return best
    end
    local ghost
    local deadline = tick() + 3
    while trick.on and tick() < deadline and not ghost do
        ghost = pick()
        if not ghost then task.wait(0.15) end
    end
    if not ghost then return end
    notifyT("Fantasma "..ghost.Name.." detectado!")
    local started, hits, lastHit = tick(), 0, 0
    while trick.on and ghost.Parent and tick() - started < 15 and hits < 12 do
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local part = ghostPart(ghost)
        if not hrp or not part then break end
        local hum = ghost:FindFirstChildOfClass("Humanoid")
        if hum and hum.Health <= 0 then break end
        hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,5,0))
        hrp.AssemblyLinearVelocity = Vector3.zero
        if tick() - lastHit >= 0.35 then
            lastHit = tick() hits = hits + 1
            pcall(function() if EquipWeapon then EquipWeapon(_G.SelectWeapon) end end)
            local modules = game:GetService("ReplicatedStorage"):FindFirstChild("Modules")
            local net = modules and modules:FindFirstChild("Net")
            local ra = net and net:FindFirstChild("RE/RegisterAttack")
            local rh = net and net:FindFirstChild("RE/RegisterHit")
            if ra and rh then
                pcall(function() ra:FireServer(0) end)
                pcall(function() rh:FireServer(part, { { ghost, part } }) end)
            end
            pcall(function() local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool") if tool then tool:Activate() end end)
        end
        task.wait(0.05)
    end
    trick.ghosts = {}
end

local function doorPartOf(inst)
    if not (inst:IsA("ProximityPrompt") or inst:IsA("ClickDetector")) then return nil end
    local text = ""
    if inst:IsA("ProximityPrompt") then text = inst.ActionText .. " " .. inst.ObjectText end
    if matchText(text) or isDoorObject(inst) then return objectPart(inst) end
    return nil
end

local startTrick, stopTrick

startTrick = function()
    if trick.on then return end
    trick.on = true
    trick.warned = false
    trick.scannedAt = 0
    trick.conn = workspace.DescendantAdded:Connect(function(inst)
        task.defer(function()
            pcall(function()
                local part = doorPartOf(inst)
                if part then table.insert(trick.doors, { inst = inst, part = part, big = isBigDoor(inst) }) end
            end)
        end)
    end)
    trick.ghosts = {}
    trick.ghostConn = workspace.DescendantAdded:Connect(function(inst)
        if not trick.hitGhost then return end
        if (inst:IsA("Model") or inst:IsA("BasePart")) and isGhostName(inst.Name) then
            local char = plr.Character
            if char and inst:IsDescendantOf(char) then return end
            if #trick.ghosts > 50 then table.remove(trick.ghosts, 1) end
            table.insert(trick.ghosts, { inst = inst, t = tick() })
        end
    end)
    trick.visited = {}
    notifyT("Trick or Treat ligado!")

    trick.noclip = RunService.Stepped:Connect(function()
        if not trick.flying then return end
        local char = plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)

    task.spawn(function()
        while trick.on do
            pcall(function()
                local char = plr.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if not hrp or not hum or hum.Health <= 0 then return end
                local best, bestDist
                for _, door in ipairs(scanDoors(120)) do
                    local inst, part = door.inst, door.part
                    if inst.Parent and part.Parent then
                        local enabled = true
                        if inst:IsA("ProximityPrompt") then enabled = inst.Enabled end
                        local last = trick.visited[inst]
                        if enabled and (not door.big or trick.useBig) and (not last or tick() - last > 60) then
                            local dist = (doorPos(door) - hrp.Position).Magnitude + (door.big and 300 or 0)
                            if not bestDist or dist < bestDist then best, bestDist = door, dist end
                        end
                    end
                end
                if not best then
                    if not trick.warned then trick.warned = true notifyT("Nenhuma porta, esperando evento :00-:10") end
                    scanDoors(20)
                    task.wait(3)
                    return
                end
                trick.warned = false
                local dpos = doorPos(best)
                local stand = dpos + Vector3.new(0,1,0)
                local away = (hrp.Position - dpos) * Vector3.new(1,0,1)
                if away.Magnitude > 1 then stand = stand + away.Unit * 4 end
                local stay = CFrame.lookAt(stand, dpos)
                goToT(stay)
                hrp.CFrame = stay

                local before = {}
                local enemies = workspace:FindFirstChild("Enemies")
                if enemies then for _, mob in ipairs(enemies:GetChildren()) do before[mob] = true end end
                trick.visited[best.inst] = tick()
                local tStart = tick()

                local held = true
                task.spawn(function()
                    local lastSnap = 0
                    while held and trick.on do
                        local root = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if root and (root.Position - stay.Position).Magnitude > 20 and tick() - lastSnap > 2 then
                            lastSnap = tick()
                            root.CFrame = stay
                        end
                        task.wait(0.25)
                    end
                end)

                local talked, empty = false, false
                local waitT = tick()
                while nobodyHome() and tick() - waitT < 3 do task.wait(0.2) end
                for _ = 1, 2 do
                    local okDC, DCm = pcall(function() return require(game:GetService("ReplicatedStorage"):WaitForChild("DialogueController", 3)) end)
                    if not (okDC and DCm and DCm.Active) then triggerDoor(best) end
                    talked, empty = handleDialogue()
                    if empty then break end
                    if talked then break end
                    task.wait(0.8)
                end
                held = false
                if not talked then
                    trick.visited[best.inst] = tick() + (empty and 300 or 120)
                else
                    fightGhost(tStart)
                    fightNew(before, dpos)
                end
                task.wait(0.3)
            end)
            task.wait(0.5)
        end
    end)
end

stopTrick = function()
    trick.on = false
    trick.flying = false
    if trick.ghostConn then trick.ghostConn:Disconnect() trick.ghostConn = nil end
    if trick.conn then trick.conn:Disconnect() trick.conn = nil end
    if trick.noclip then trick.noclip:Disconnect() trick.noclip = nil end
    pcall(clearMoversT)
    notifyT("Trick or Treat desligado.")
end

SpokyHalloweenSection.CreateToggle(
    { Title = "Auto Halloween Trick Or Treat", Desc = "Zyrox: Porta a porta, Treat, mata mobs e fantasmas", Default = Settings["Auto Halloween Trick Or Treat"] or false },
    function(V)
        Settings["Auto Halloween Trick Or Treat"] = V
        SaveSettings("Auto Halloween Trick Or Treat", V)
        if V then startTrick() else stopTrick() end
    end
)
end
-- ===================== FIM HALLOWEEN INTEGRADO


-- ===================== SECRET QUEST - 100% ZYROX NO NEXORA =====================
SecretQuestMain = Main.CreatePage({ Page_Name = "Secret Quest", Page_Title = "Secret Quest [ZYROX FULL]" })
SecretQuestMain.CreateSection("Secret Quest - 39 Bonus Moments - Port Vxeze -> Zyrox -> Nexora")

-- Compat: t15 para o codigo do Zyrox funcionar no Nexora
t15 = t15 or {}
t15.SecretQuest = SecretQuestMain
t15.Prehistoric = SecretQuestMain
t15.Dragon = SecretQuestMain
t15.Disciple = SecretQuestMain
t15.CDK = SecretQuestMain
t15.SoulGuitar = SecretQuestMain
t15.Yama = SecretQuestMain

-- Libs usadas pelo Zyrox (mapeia pro Nexora)
lib = lib or {}
lib.Notify = lib.Notify or function(tbl) pcall(function() game:GetService("StarterGui"):SetCore("SendNotification", {Title=tbl.Title or "Nexora", Text=tbl.Description or tbl.Text or "", Duration=tbl.Duration or 4}) end) end


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
-- ===================== FIM SECRET QUEST
-- ===================== FIM SECRET QUEST 100% =====================

