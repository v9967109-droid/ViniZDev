
-- PATCH UI Nexora - Transparente + Arredondado + Sem Sons + Sem Loading
-- Cole este bloco NO FINAL do seu arquivo, depois da linha 29142

task.spawn(function()
    task.wait(1.5) -- espera o hub carregar
    
    local function makeRoundedAndTransparent(gui)
        for _, v in pairs(gui:GetDescendants()) do
            if v:IsA("Frame") or v:IsA("CanvasGroup") or v:IsA("ScrollingFrame") then
                -- Mais transparente - mantendo mesmas cores
                if v.BackgroundTransparency < 0.5 then
                    v.BackgroundTransparency = 0.35 -- era 0, agora 0.35
                end
                -- Mais arredondado
                local hasCorner = false
                for _, c in pairs(v:GetChildren()) do if c:IsA("UICorner") then hasCorner = true end end
                if not hasCorner then
                    local corner = Instance.new("UICorner")
                    corner.CornerRadius = UDim.new(0, 18) -- bem arredondado
                    corner.Parent = v
                else
                    for _, c in pairs(v:GetChildren()) do
                        if c:IsA("UICorner") then
                            c.CornerRadius = UDim.new(0, 18)
                        end
                    end
                end
            end
            -- Toggles / Botões ainda mais redondos
            if v:IsA("TextButton") or v.Name:lower():find("toggle") then
                for _, c in pairs(v:GetChildren()) do
                    if c:IsA("UICorner") then
                        c.CornerRadius = UDim.new(0, 22)
                    end
                end
            end
            -- REMOVER SONS DE TOGGLE
            if v:IsA("Sound") then
                -- remove som de ativar toggle
                if v.Name:lower():find("toggle") or v.Name:lower():find("click") or v.SoundId:find("electronic") then
                    v:Destroy()
                end
            end
        end
    end

    -- 1. Remover tela de carregamento permanentemente
    local host = (gethui and gethui()) or game:GetService("CoreGui")
    local loading = host:FindFirstChild("NexoraLoading")
    if loading then loading:Destroy() end
    -- Impede ela de voltar
    getgenv().NexoraLoadingFinish = function() end

    -- 2. Aplicar em todos os GUIs do Hub
    for _, gui in pairs(host:GetChildren()) do
        if gui.Name:lower():find("nexora") then
            makeRoundedAndTransparent(gui)
        end
    end

    -- 3. Monitorar sons novos e deletar
    host.DescendantAdded:Connect(function(v)
        if v:IsA("Sound") then
            task.wait(0.05)
            if v.SoundId:find("electronic") or v.Name:lower():find("toggle") then
                v:Destroy()
            end
        end
    end)

    print("[PATCH] UI transparente + arredondada aplicada | Sons removidos | Loading removido")
end)

-- EDICAO MANUAL OPCIONAL (se quiser editar a source):
-- 1. Apague as linhas 1 até 72 (todo o do...end da tela de carregamento)
-- 2. Na função sfx (linha 18-26) troque para: function sfx() end  -- silencia tudo
-- 3. Troque GOLD = Color3.fromRGB(0,140,255) mantém a cor, só muda transparência
