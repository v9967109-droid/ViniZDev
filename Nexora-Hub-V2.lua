
-- NEXORA MINIMAL - TESTE DELTA (vai abrir 100%)
-- Se esse abrir, o problema é tamanho do arquivo completo

local function SafeHttpGet(url)
    local ok, res = pcall(function() return game:HttpGet(url) end)
    if ok and res and #res > 100 then return res end
    if syn and syn.request then
        local s, r = pcall(function() return syn.request({Url=url, Method="GET"}).Body end)
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

local Window = redzlib:MakeWindow({Title="NEXORA HUB V2 • Redz V5", SubTitle="TESTE - Se abriu, o FIX funciona", SaveFolder="NexoraHubV2_TESTE"})

-- Floating N
task.spawn(function()
    local host = game:GetService("CoreGui")
    pcall(function() host = (gethui and gethui()) or game:GetService("CoreGui") end)
    local old = host:FindFirstChild("NexoraFloatingToggle")
    if old then old:Destroy() end
    local gui = Instance.new("ScreenGui")
    gui.Name = "NexoraFloatingToggle"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 100000
    gui.Parent = host
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromOffset(52,52)
    btn.Position = UDim2.new(0,24,0.5,-26)
    btn.BackgroundColor3 = Color3.fromRGB(18,18,22)
    btn.Text = "N"
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextSize = 24
    btn.Font = Enum.Font.GothamBlack
    btn.Active = true
    btn.Draggable = true
    btn.Parent = gui
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1,0)
    local stroke = Instance.new("UIStroke", btn); stroke.Color = Color3.fromRGB(90,140,255); stroke.Thickness=2
    local function findWindowGui()
        return host:FindFirstChild("redz Library V5")
    end
    local target
    btn.Activated:Connect(function()
        target = target and target.Parent and target or findWindowGui()
        if target then target.Enabled = not target.Enabled end
    end)
end)

-- Tabs
local TabMain = Window:MakeTab({"Main", "Home"})
local TabStatus = Window:MakeTab({"Status And Server", "BarChart"})

TabMain:AddSection({"Status"})
TabMain:AddParagraph({"NEXORA MIGRADO", "Se voce esta vendo isso, a Redz V5 carregou!"})
TabMain:AddButton({"Testar Toggle", function() print("Botao funciona") end})

-- Status And Server com listas roláveis
TabStatus:AddSection({"Dealer Normal - Stock Rolável"})
local NormalFruits = {"Rocket","Spin","Blade","Spring","Bomb","Smoke","Spike","Flame","Sand","Dark","Diamond","Light","Rubber","Barrier","Ghost","Magma","Quake","Buddha","Love","Spider","Sound","Phoenix","Portal","Lightning","Pain","Blizzard","Gravity","Dough","Shadow","Venom","Control","Gas","Spirit","Leopard","Yeti","Kitsune","Dragon"}
local MirageFruits = {"Leopard","Yeti","Kitsune","Dragon","Spirit","Control","Gas","Venom","Shadow","Dough"}

TabStatus:AddDropdown({Name="Filtrar Normal Dealer", Options=NormalFruits, Default=NormalFruits[1], Callback=function(v) print("Normal:", v) end})
for _, f in ipairs(NormalFruits) do
    TabStatus:AddButton({Name="[Normal] "..f, Callback=function() print(f) end})
end

TabStatus:AddSection({"Mirage Dealer - Stock Rolável"})
TabStatus:AddDropdown({Name="Filtrar Mirage Dealer", Options=MirageFruits, Default=MirageFruits[1], Callback=function(v) print("Mirage:", v) end})
for _, f in ipairs(MirageFruits) do
    TabStatus:AddButton({Name="[Mirage] "..f, Callback=function() print(f) end})
end

TabStatus:AddSection({"Server Status"})
local fpsLabel = TabStatus:AddParagraph({"FPS / Ping", "Carregando..."})
task.spawn(function()
    while task.wait(5) do
        local fps = math.floor(1/0.016)
        pcall(function() fpsLabel:SetTitle("FPS: "..fps) end)
    end
end)

print("Nexora Minimal carregado!")
