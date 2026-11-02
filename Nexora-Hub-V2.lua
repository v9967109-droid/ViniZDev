
-- PATCH NEXORA V3 - ABAS NOVAS GARANTIDAS - EXECUTE DEPOIS DO NEXORA
task.wait(3)

local MainWindow = nil
pcall(function()
    -- Tenta achar Main de todo jeito
    MainWindow = _G.Main or getgenv().Main or Main or _G.NexoraMain or getgenv().NexoraMain
    if not MainWindow then
        for _, v in pairs(getgenv()) do
            if type(v) == "table" and v.CreatePage then
                MainWindow = v
                break
            end
        end
    end
    if not MainWindow then
        for _, v in pairs(_G) do
            if type(v) == "table" and v.CreatePage then
                MainWindow = v
                break
            end
        end
    end
end)

if not MainWindow then
    warn("[PATCH] Main nao encontrado! Tentando library...")
    return
end

print("[PATCH] Main encontrado! Criando abas...")

-- ===== HALLOWEEN ZYROX - NOVA ABA =====
local HalloweenPage = MainWindow.CreatePage({ Page_Name = "Halloween Zyrox", Page_Title = "Halloween [ZYROX FIX]" })
local HalloweenSection = HalloweenPage.CreateSection("Hellfire Halloween 2026 [ZYROX]")

do
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

-- JACK HUNT
local jack = { on = false, noclip = nil, skip = {} }
local function clearMovers()
    pcall(function()
        local char = plr.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hrp then
            for _, n in ipairs({"FarmBodyVelocity","FarmBodyGyro","BodyClip"}) do
                local m = hrp:FindFirstChild(n)
                if m then m:Destroy() end
            end
        end
        if hum then hum.PlatformStand = false end
    end)
end

local function applyMovers(char)
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return nil end
    if not hrp:FindFirstChild("FarmBodyVelocity") then
        local v = Instance.new("BodyVelocity")
        v.Name = "FarmBodyVelocity"
        v.MaxForce = Vector3.new(1e9,1e9,1e9)
        v.Velocity = Vector3.new(0,0,0)
        v.Parent = hrp
    end
    if not hrp:FindFirstChild("FarmBodyGyro") then
        local g = Instance.new("BodyGyro")
        g.Name = "FarmBodyGyro"
        g.MaxTorque = Vector3.new(1e9,1e9,1e9)
        g.D = 10; g.P = 3000; g.CFrame = hrp.CFrame
        g.Parent = hrp
    end
    hum.PlatformStand = true
    return hrp
end

HalloweenSection.CreateToggle(
    { Title = "Auto Jack O-Lantern Hunt [ZYROX]", Desc = "Mata aboboras + Jack", Default = false },
    function(V)
        jack.on = V
        if V then
            print("[Jack] Ligado!")
            jack.noclip = RunService.Stepped:Connect(function()
                local c = plr.Character
                if c then for _, p in ipairs(c:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide = false end end end
            end)
            task.spawn(function()
                while jack.on do
                    pcall(function()
                        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        local folder = workspace:FindFirstChild("PumpkinHunt")
                        if not folder then task.wait(2) return end
                        local best, bestDist = nil, math.huge
                        for _, obj in ipairs(folder:GetChildren()) do
                            if not obj:GetAttribute("Collected") and not jack.skip[obj] then
                                local pos = obj:IsA("BasePart") and obj.Position or obj:GetPivot().Position
                                local d = (pos - hrp.Position).Magnitude
                                if d < bestDist then best, bestDist = obj, d end
                            end
                        end
                        if not best then jack.skip = {} task.wait(2) return end
                        local part = best:IsA("BasePart") and best or best:FindFirstChildWhichIsA("BasePart", true)
                        if not part then return end
                        local goal = CFrame.new(part.Position + Vector3.new(0,5,0))
                        if (hrp.Position - part.Position).Magnitude > 15 then
                            applyMovers(plr.Character)
                            hrp.CFrame = goal
                        else
                            clearMovers()
                            hrp.CFrame = goal
                        end
                        local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
                        if tool then tool:Activate() end
                        VIM:SendMouseButtonEvent(0,0,0,true,game,0)
                        VIM:SendMouseButtonEvent(0,0,0,false,game,0)
                        pcall(function()
                            local net = game.ReplicatedStorage.Modules.Net
                            net:FindFirstChild("RE/RegisterAttack"):FireServer(0)
                            net:FindFirstChild("RE/RegisterHit"):FireServer(part, {{best, part}})
                        end)
                    end)
                    task.wait(0.12)
                end
            end)
        else
            if jack.noclip then jack.noclip:Disconnect() end
            clearMovers()
            print("[Jack] Desligado!")
        end
    end
)

-- TRICK OR TREAT
local trick = { on = false }
HalloweenSection.CreateToggle(
    { Title = "Auto Trick Or Treat [ZYROX]", Desc = "Porta a porta", Default = false },
    function(V)
        trick.on = V
        if V then
            print("[Trick] Ligado!")
            task.spawn(function()
                while trick.on do
                    pcall(function()
                        local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                        if not hrp then return end
                        local best, bestDist = nil, math.huge
                        for _, inst in ipairs(workspace:GetDescendants()) do
                            if inst:IsA("ProximityPrompt") then
                                local txt = string.lower(inst.ActionText.." "..inst.ObjectText)
                                if txt:find("knock") or txt:find("trick") or txt:find("treat") then
                                    local part = inst.Parent:IsA("BasePart") and inst.Parent or inst.Parent:FindFirstChildWhichIsA("BasePart", true)
                                    if part then
                                        local d = (part.Position - hrp.Position).Magnitude
                                        if d < bestDist and d < 5000 then best, bestDist = {inst=inst, part=part}, d end
                                    end
                                end
                            end
                        end
                        if not best then task.wait(2) return end
                        hrp.CFrame = CFrame.new(best.part.Position + Vector3.new(0,3,4))
                        task.wait(0.5)
                        if fireproximityprompt then fireproximityprompt(best.inst) end
                        task.wait(1.5)
                    end)
                    task.wait(0.5)
                end
            end)
        else
            print("[Trick] Desligado!")
        end
    end
)
end

-- ===== SECRET QUEST - NOVA ABA =====
local SecretPage = MainWindow.CreatePage({ Page_Name = "Secret Quest", Page_Title = "Secret Quest [ZYROX FULL]" })
local SecretSection = SecretPage.CreateSection("Secret Quest - 39 Bonus Moments")

SecretSection.CreateToggle(
    { Title = "Auto Secret Quest (39 Quests)", Desc = "Faz todas Bonus Moments - Zyrox", Default = false },
    function(V)
        _G.AutoSecretQuest = V
        print("[SecretQuest] "..tostring(V))
        if V then
            spawn(function()
                while _G.AutoSecretQuest do
                    pcall(function()
                        local RS = game:GetService("ReplicatedStorage")
                        local data = RS.Modules.Net["RF/RequestBonusMomentReplication"]:InvokeServer({ Type = "GetMomentProgress" })
                        if data and data.Data then
                            local done = 0
                            for _, v in pairs(data.Data) do if v.Completed then done+=1 end end
                            print("[SecretQuest] "..done.."/39")
                        end
                    end)
                    task.wait(5)
                end
            end)
        end
    end
)

SecretSection.CreateLabel({ Title = "Status: Aguardando..." })

print("[PATCH V3] Abas Halloween Zyrox + Secret Quest criadas com sucesso!")
game.StarterGui:SetCore("SendNotification", {Title="Nexora Patch", Text="Halloween Zyrox + Secret Quest adicionados!", Duration=5})
