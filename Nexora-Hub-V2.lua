
-- PATCH NEXORA V4 - GARANTIDO
repeat task.wait(1) until _G.Main or getgenv().Main or (rawget(_G, "Main")) or Main
local MainWindow = _G.Main or getgenv().Main or Main or getgenv().A and getgenv().A.CreateMain and Main
-- fallback procura
if not MainWindow or not MainWindow.CreatePage then
    for _, v in pairs(getgenv()) do
        if type(v) == "table" and v.CreatePage then MainWindow = v break end
    end
end
if not MainWindow or not MainWindow.CreatePage then
    for _, v in pairs(_G) do
        if type(v) == "table" and v.CreatePage then MainWindow = v break end
    end
end

if not MainWindow then warn("Main nao encontrado") return end
print("Main encontrado:", MainWindow)

local HalloweenPage = MainWindow.CreatePage({ Page_Name = "Halloween Zyrox", Page_Title = "Halloween [ZYROX]" })
local HalloweenSection = HalloweenPage.CreateSection("Zyrox Halloween")

HalloweenSection.CreateToggle({ Title = "Auto Jack Hunt [ZYROX]", Desc = "Mata abobora", Default = false }, function(V)
    getgenv().AutoJackZyrox = V
    if V then
        task.spawn(function()
            while getgenv().AutoJackZyrox do
                pcall(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    local folder = workspace:FindFirstChild("PumpkinHunt")
                    if hrp and folder then
                        local best, dist = nil, math.huge
                        for _, o in ipairs(folder:GetChildren()) do
                            if not o:GetAttribute("Collected") then
                                local p = o:IsA("BasePart") and o.Position or o:GetPivot().Position
                                local d = (p-hrp.Position).Magnitude
                                if d < dist then best, dist = o, d end
                            end
                        end
                        if best then
                            local part = best:IsA("BasePart") and best or best:FindFirstChildWhichIsA("BasePart", true)
                            if part then
                                hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,5,0))
                                task.wait(0.1)
                                local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                                if tool then tool:Activate() end
                                game.ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterAttack"):FireServer(0)
                                game.ReplicatedStorage.Modules.Net:FindFirstChild("RE/RegisterHit"):FireServer(part, {{best, part}})
                            end
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end
end)

HalloweenSection.CreateToggle({ Title = "Auto Trick Treat [ZYROX]", Desc = "Porta a porta", Default = false }, function(V)
    getgenv().AutoTrickZyrox = V
    if V then
        task.spawn(function()
            while getgenv().AutoTrickZyrox do
                pcall(function()
                    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local best, d = nil, math.huge
                    for _, inst in ipairs(workspace:GetDescendants()) do
                        if inst:IsA("ProximityPrompt") then
                            local t = string.lower(inst.ActionText.." "..inst.ObjectText)
                            if t:find("knock") or t:find("trick") or t:find("treat") then
                                local part = inst.Parent:IsA("BasePart") and inst.Parent or inst.Parent:FindFirstChildWhichIsA("BasePart", true)
                                if part then
                                    local dist = (part.Position-hrp.Position).Magnitude
                                    if dist < d then best, d = {inst=inst, part=part}, dist end
                                end
                            end
                        end
                    end
                    if best then
                        hrp.CFrame = CFrame.new(best.part.Position + Vector3.new(0,3,3))
                        task.wait(0.5)
                        if fireproximityprompt then fireproximityprompt(best.inst) end
                    else
                        task.wait(2)
                    end
                end)
                task.wait(0.5)
            end
        end)
    end
end)

-- SECRET QUEST
local SecretPage = MainWindow.CreatePage({ Page_Name = "Secret Quest", Page_Title = "Secret Quest [ZYROX]" })
local SecretSection = SecretPage.CreateSection("Secret Quest - 39 Quests")

SecretSection.CreateToggle({ Title = "Auto Secret Quest", Desc = "Faz Bonus Moments", Default = false }, function(V)
    _G.AutoSecretQuest = V
    if V then
        task.spawn(function()
            while _G.AutoSecretQuest do
                pcall(function()
                    local data = game.ReplicatedStorage.Modules.Net["RF/RequestBonusMomentReplication"]:InvokeServer({Type="GetMomentProgress"})
                    if data and data.Data then
                        local done = 0
                        for _, q in pairs(data.Data) do if q.Completed then done+=1 end end
                        print("Secret Quest: "..done.."/39")
                    end
                end)
                task.wait(5)
            end
        end)
    end
end)

SecretSection.CreateLabel({ Title = "Zyrox Secret Quest injetado com sucesso!" })

print("Abas criadas!")
game.StarterGui:SetCore("SendNotification", {Title="Nexora Patch V4", Text="Halloween Zyrox + Secret Quest adicionados!", Duration=5})
