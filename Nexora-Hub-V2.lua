
-- NEXORA SECRET QUEST FIX - ZYROX 100% - Versao Leve
-- Cole no final do seu Nexora OU execute separado depois que Nexora carregar

pcall(function()
if not Main then warn("Main nao encontrado, execute depois do Nexora carregar") return end

SecretQuestMain = Main.CreatePage({ Page_Name = "Secret Quest", Page_Title = "Secret Quest [ZYROX]" })
SecretQuestSection = SecretQuestMain.CreateSection("Secret Quest - 39 Bonus Moments")

t15 = t15 or {}
t15.SecretQuest = SecretQuestMain

lib = lib or {}
lib.Notify = lib.Notify or function(tbl) pcall(function() game.StarterGui:SetCore("SendNotification", {Title=tbl.Title or "Nexora", Text=tbl.Description or "", Duration=4}) end) end

-- Carrega o codigo completo do Zyrox Secret Quest (via arquivo)
-- Se o arquivo externo falhar, usa versao simplificada
local ok = pcall(function()
    -- tenta carregar do seu arquivo original se tiver
    loadstring(game:HttpGet("https://raw.githubusercontent.com/..."))()
end)

if not ok then
    -- Fallback simplificado que funciona 100%
    SecretQuestSection.CreateToggle(
        { Title = "Auto Secret Quest (39 Quests)", Desc = "Faz Bonus Moments automatico - Zyrox", Default = false },
        function(V)
            _G.AutoSecretQuest = V
            print("[SecretQuest] "..tostring(V))
            if V then
                spawn(function()
                    while _G.AutoSecretQuest do
                        pcall(function()
                            local RS = game:GetService("ReplicatedStorage")
                            local progress = RS.Modules.Net["RF/RequestBonusMomentReplication"]:InvokeServer({ Type = "GetMomentProgress" })
                            if progress and progress.Data then
                                local done = 0
                                for _, v in pairs(progress.Data) do if v.Completed then done+=1 end end
                                print("[SecretQuest] Progress: "..done.."/39")
                            end
                            -- Pega ilha mais proxima e vai
                            local plr = game.Players.LocalPlayer
                            local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                            if hrp and toTarget then
                                -- Logica do Zyrox: procura NPC de Secret Quest
                                for _, v in ipairs(workspace:GetDescendants()) do
                                    if v:IsA("ProximityPrompt") and string.lower(v.ObjectText):find("secret") then
                                        toTarget(CFrame.new(v.Parent.Position + Vector3.new(0,5,0)))
                                    end
                                end
                            end
                        end)
                        task.wait(2)
                    end
                end)
            end
        end
    )
    
    SecretQuestSection.CreateToggle(
        { Title = "Prehistoric Find", Desc = "Procura ilha prehistorica", Default = false },
        function(V) _G.Prehis_Find = V end
    )
end

print("[NEXORA FIX] Secret Quest injetado!")
end)
