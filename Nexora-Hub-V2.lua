-- NEXORA HUB • DEBUG VERSION (mostra erro no console)
-- Essa versão é pequena e vai te falar o que deu errado

local function log(msg)
    print("[NEXORA DEBUG] "..tostring(msg))
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {Title="Nexora Debug", Text=tostring(msg), Duration=3})
    end)
end

log("Iniciando...")

-- Espera jogo carregar
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game:GetService("ReplicatedStorage")

log("Jogo carregado")

-- Host seguro
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local host
pcall(function() host = (gethui and gethui()) or game:GetService("CoreGui") end)
if not host then host = player:WaitForChild("PlayerGui") end

-- Limpa antigo
for _, n in ipairs({"NexoraTeddyUI","NexoraTeddyFloat","NexoraFluentFloat","XenonHub_UI"}) do
    pcall(function() 
        local old = host:FindFirstChild(n)
        if old then old:Destroy() end
    end)
end

log("Criando UI Teddy Light...")

-- CRIA UI ULTRA SIMPLES
local gui = Instance.new("ScreenGui")
gui.Name = "NexoraTeddyUI"
gui.ResetOnSpawn = false
gui.Parent = host

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(540, 360)
main.Position = UDim2.fromScale(0.5,0.5)
main.AnchorPoint = Vector2.new(0.5,0.5)
main.BackgroundColor3 = Color3.fromRGB(25,25,28)
main.BorderSizePixel = 0
main.Parent = gui
Instance.new("UICorner", {CornerRadius=UDim.new(0,8), Parent=main})

local top = Instance.new("Frame")
top.Size = UDim2.new(1,0,0,36)
top.BackgroundColor3 = Color3.fromRGB(35,35,40)
top.Parent = main
Instance.new("UICorner", {CornerRadius=UDim.new(0,8), Parent=top})

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Size = UDim2.new(1,-20,1,0)
title.Position = UDim2.fromOffset(10,0)
title.Text = "NEXORA HUB | DEBUG - Se apareceu, UI funciona"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

-- Sidebar
local sidebar = Instance.new("ScrollingFrame")
sidebar.Size = UDim2.new(0,120,1,-44)
sidebar.Position = UDim2.fromOffset(6,40)
sidebar.BackgroundColor3 = Color3.fromRGB(30,30,34)
sidebar.BorderSizePixel = 0
sidebar.ScrollBarThickness = 2
sidebar.Parent = main
Instance.new("UICorner", {CornerRadius=UDim.new(0,6), Parent=sidebar})
Instance.new("UIListLayout", {Padding=UDim.new(0,2), Parent=sidebar})
Instance.new("UIPadding", {PaddingTop=UDim.new(0,4), PaddingLeft=UDim.new(0,4), PaddingRight=UDim.new(0,4), PaddingBottom=UDim.new(0,4), Parent=sidebar})

-- Content
local content = Instance.new("ScrollingFrame")
content.Size = UDim2.new(1,-138,1,-44)
content.Position = UDim2.new(0,132,0,40)
content.BackgroundColor3 = Color3.fromRGB(30,30,34)
content.BorderSizePixel = 0
content.ScrollBarThickness = 2
content.Parent = main
Instance.new("UICorner", {CornerRadius=UDim.new(0,6), Parent=content})
Instance.new("UIListLayout", {Padding=UDim.new(0,4), Parent=content})
Instance.new("UIPadding", {PaddingTop=UDim.new(0,6), PaddingLeft=UDim.new(0,6), PaddingRight=UDim.new(0,6), PaddingBottom=UDim.new(0,6), Parent=content})

-- Função pra criar aba
local tabs = {}
local function createTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,26)
    btn.BackgroundColor3 = Color3.fromRGB(45,45,50)
    btn.Text = name
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.Parent = sidebar
    Instance.new("UICorner", {CornerRadius=UDim.new(0,4), Parent=btn})
    
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1,0,0,0)
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.BackgroundTransparency = 1
    container.Visible = false
    container.Parent = content
    Instance.new("UIListLayout", {Padding=UDim.new(0,4), Parent=container})
    
    tabs[name] = {btn=btn, container=container}
    
    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.container.Visible = false
            t.btn.BackgroundColor3 = Color3.fromRGB(45,45,50)
        end
        container.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(0,200,100)
    end)
    
    return container
end

-- Cria todas as abas
local allTabs = {"Shop","Status","LocalPlayer","Farming","Sea Event","ESP","PVP","Setting"}
local firstContainer = nil
for i, tn in ipairs(allTabs) do
    local cont = createTab(tn)
    if i==1 then firstContainer = cont end
end
if firstContainer then firstContainer.Visible = true tabs[allTabs[1]].btn.BackgroundColor3 = Color3.fromRGB(0,200,100) end

-- Adiciona alguns botões de teste no Shop
local shopCont = tabs["Shop"].container
for i=1,5 do
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,58)
    btn.Text = "Botão Teste "..i.." - Se aparece, funciona"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.Parent = shopCont
    Instance.new("UICorner", {CornerRadius=UDim.new(0,6), Parent=btn})
    btn.MouseButton1Click:Connect(function() log("Clicou no botão "..i) end)
end

-- Botão flutuante
local floatGui = Instance.new("ScreenGui")
floatGui.Name = "NexoraTeddyFloat"
floatGui.ResetOnSpawn = false
floatGui.Parent = host

local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.fromOffset(50,50)
floatBtn.Position = UDim2.new(0,15,0.5,-25)
floatBtn.BackgroundColor3 = Color3.fromRGB(25,25,28)
floatBtn.Text = "N"
floatBtn.TextColor3 = Color3.new(1,1,1)
floatBtn.Font = Enum.Font.GothamBlack
floatBtn.TextSize = 20
floatBtn.Active = true
floatBtn.Draggable = true
floatBtn.Parent = floatGui
Instance.new("UICorner", {CornerRadius=UDim.new(0,12), Parent=floatBtn})
Instance.new("UIStroke", {Color=Color3.new(1,1,1), Transparency=0.7, Thickness=1, Parent=floatBtn})

local isOpen = true
floatBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    gui.Enabled = isOpen
    floatBtn.Text = isOpen and "N" or "+"
end)

log("UI criada com sucesso! Se você vê essa UI, o problema é o tamanho do arquivo original")
log("Agora vou tentar carregar as funções...")

-- Tenta carregar GetFruits com pcall
task.spawn(function()
    local ok, err = pcall(function()
        local remotes = game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
        if not remotes then log("Remotes não encontrado") return end
        local comm = remotes:FindFirstChild("CommF_")
        if not comm then log("CommF_ não encontrado") return end
        log("Tentando GetFruits...")
        local res = comm:InvokeServer("GetFruits", false)
        log("GetFruits retornou: "..tostring(type(res)).." com "..tostring(#res).." itens")
    end)
    if not ok then
        log("Erro no GetFruits: "..tostring(err))
    end
end)
