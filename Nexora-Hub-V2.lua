
-- NEXORA HALLOWEEN V4 - TRICK DIALOG FIX + JACK COLADO RAPIDO
pcall(function()
    if not Main then return end
    if HalloweenMain then pcall(function() HalloweenMain:Destroy() end) end
    
    HalloweenMain = Main.CreatePage({ Page_Name = "Halloween", Page_Title = "Halloween 2026 [V4 DIALOG]" })
    HalloweenSection = HalloweenMain.CreateSection("Fix Dialog + Jack Turbo")

    local lp = game.Players.LocalPlayer

    local function GetHRP()
        local c = lp.Character
        return c and c:FindFirstChild("HumanoidRootPart"), c and c:FindFirstChildOfClass("Humanoid"), c
    end

    local function EquipMelee()
        local hrp,hum,char = GetHRP() if not char then return nil end
        local name=nil pcall(function() name=NameWeapon("Melee") end)
        if name then pcall(function() equiptool(name) end) task.wait(0.2) return char:FindFirstChildOfClass("Tool") end
        for _,v in ipairs(lp.Backpack:GetChildren()) do if v:IsA("Tool") and v.ToolTip=="Melee" then pcall(function() equiptool(v.Name) end) task.wait(0.2) return char:FindFirstChildOfClass("Tool") end end
        for _,v in ipairs(lp.Backpack:GetChildren()) do if v:IsA("Tool") then pcall(function() equiptool(v.Name) end) task.wait(0.15) break end end
        return char:FindFirstChildOfClass("Tool")
    end

    -- ========== TRICK OR TREAT COM DIALOG ==========
    HalloweenSection.CreateToggle(
        { Title = "Auto Trick Or Treat", Desc = "FIX: Faz dialogo Trick or Treat + nao fica busy", Default = false },
        function(V)
            Settings["Auto Trick Or Treat"]=V _G.AutoTrick=V
            if V then task.spawn(function()
                local noclip=nil noclip=game:GetService("RunService").Stepped:Connect(function() if _G.AutoTrick and lp.Character then for _,p in ipairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end)
                local function IsBusy()
                    for _,gui in ipairs(lp.PlayerGui:GetDescendants()) do
                        if gui:IsA("TextLabel") and gui.Visible then
                            local t=string.lower(gui.Text or "")
                            if t:find("still busy") then return true end
                        end
                    end
                    return false
                end
                local function ClickDialog()
                    local clicked=false
                    -- Clica em "Trick or Treat!" primeiro
                    for _,gui in ipairs(lp.PlayerGui:GetDescendants()) do
                        if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
                            local txt=string.lower(gui.Text or gui.Name or "")
                            if txt:find("trick or treat") then
                                pcall(function() gui:Activate() end)
                                clicked=true
                            end
                        end
                    end
                    if clicked then task.wait(0.4) return true end
                    -- Depois clica outros
                    for _,gui in ipairs(lp.PlayerGui:GetDescendants()) do
                        if (gui:IsA("TextButton") or gui:IsA("ImageButton")) and gui.Visible then
                            local txt=string.lower(gui.Text or gui.Name or "")
                            if txt:find("grab") or txt:find("handful") or txt:find("yes") or txt:find("continue") or txt:find("collect") or txt:find("play") or txt:find("celestial") or txt:find("oni") or txt:find("open") or txt:find("ahoy") then
                                pcall(function() gui:Activate() end)
                                clicked=true
                            end
                        end
                    end
                    return clicked
                end
                local last={} local function IsVisited(pos) for i=#last,1,-1 do if tick()-last[i].t>20 then table.remove(last,i) else if (last[i].pos-pos).Magnitude<10 then return true end end end return false end
                local cur=nil
                while _G.AutoTrick do pcall(function()
                    local hrp=GetHRP() if not hrp then task.wait(0.5) return end
                    if IsBusy() then ClickDialog() task.wait(0.6) return end
                    if cur then
                        if (hrp.Position-cur.pos).Magnitude>14 then
                            if toTarget then toTarget(CFrame.new(cur.pos+Vector3.new(0,5,0))) else hrp.CFrame=CFrame.new(cur.pos+Vector3.new(0,5,0)) end
                            task.wait(0.25)
                        else
                            pcall(function() fireproximityprompt(cur.prompt) end)
                            task.wait(0.4)
                            for i=1,12 do
                                ClickDialog()
                                task.wait(0.3)
                                if not IsBusy() then break end
                            end
                            if not IsBusy() then table.insert(last,{pos=cur.pos,t=tick()}) cur=nil task.wait(0.5) end
                        end
                        return
                    end
                    -- boss
                    for _,en in ipairs(workspace.Enemies:GetChildren()) do local n=string.lower(en.Name) if n:find("werewolf") or n:find("hell") then local erp=en:FindFirstChild("HumanoidRootPart") if erp and (hrp.Position-erp.Position).Magnitude<600 then if toTarget then toTarget(erp.CFrame*CFrame.new(0,10,0)) else hrp.CFrame=erp.CFrame*CFrame.new(0,10,0) end task.wait(0.2) if BringMob then BringMob(en) end local melee=NameWeapon and NameWeapon("Melee") if melee then equiptool(melee) task.wait(0.15) end for i=1,5 do if ClickM1 then ClickM1(en,true) end task.wait(0.08) end return end end end
                    local doors={} for _,obj in ipairs(workspace:GetDescendants()) do if obj:IsA("ProximityPrompt") then local par=obj.Parent if par then local pos=nil pcall(function() if par:IsA("BasePart") then pos=par.Position else local bp=par:FindFirstChildWhichIsA("BasePart") if bp then pos=bp.Position else pos=par:GetPivot().Position end end end) if pos and (hrp.Position-pos).Magnitude<5000 and not IsVisited(pos) then local full=string.lower(par.Name.." "..obj.ObjectText.." "..par:GetFullName()) if full:find("trick") or full:find("treat") or full:find("door") or full:find("candy") then table.insert(doors,{pos=pos,prompt=obj}) end end end end end
                    if #doors>0 then table.sort(doors,function(a,b) return (hrp.Position-a.pos).Magnitude < (hrp.Position-b.pos).Magnitude end) cur=doors[1] else task.wait(0.8) end
                end) task.wait(0.15) end if noclip then noclip:Disconnect() end
            end) end
        end
    )

    -- ========== JACK O LANTERN HUNT V3 TURBO ==========
    HalloweenSection.CreateToggle(
        { Title = "Auto Jack O Lantern Hunt", Desc = "V3 Colado + Turbo + Jack 400 studs", Default = false },
        function(V)
            Settings["Auto Jack O Lantern Hunt"]=V _G.AutoJackHunt=V
            if V then task.spawn(function()
                local noclip=nil noclip=game:GetService("RunService").Stepped:Connect(function() if _G.AutoJackHunt and lp.Character then for _,p in ipairs(lp.Character:GetDescendants()) do if p:IsA("BasePart") then p.CanCollide=false end end end end)
                local function FindPumpkinFast()
                    local hrp=GetHRP() if not hrp then return nil end
                    local best=nil local bestDist=9999
                    local folder=workspace:FindFirstChild("PumpkinHunt")
                    if folder then
                        for _,obj in ipairs(folder:GetChildren()) do
                            local pos=nil pcall(function() if obj:IsA("BasePart") then pos=obj.Position else pos=obj:GetPivot().Position end end)
                            if pos and pos.Y>-50 then
                                local d=(hrp.Position-pos).Magnitude
                                if d<bestDist and d<6000 then bestDist=d best={obj=obj,pos=pos,dist=d} end
                            end
                        end
                        if best then return best end
                    end
                    for _,obj in ipairs(workspace:GetDescendants()) do
                        if obj:IsA("BasePart") then
                            local n=string.lower(obj.Name)
                            if n:find("pumpkin") and not n:find("hat") and obj.Transparency<1 and obj.Size.Magnitude>2 and obj.Size.Magnitude<60 then
                                if obj.Position.Y>-50 then
                                    local d=(hrp.Position-obj.Position).Magnitude
                                    if d<bestDist and d<6000 then bestDist=d best={obj=obj,pos=obj.Position,dist=d} end
                                end
                            end
                        end
                    end
                    return best
                end
                local function FindJackFast(posRef)
                    local hrp=GetHRP() if not hrp then return nil end
                    for _,container in ipairs({workspace.Enemies, workspace}) do
                        for _,en in ipairs(container:GetChildren()) do
                            if en:IsA("Model") and en:FindFirstChild("HumanoidRootPart") and en:FindFirstChildOfClass("Humanoid") then
                                local n=string.lower(en.Name)
                                if n:find("jack") or n:find("cursed") or n:find("pumpkin") or n:find("lantern") or n:find("flutuante") or n:find("tartaruga") then
                                    local eh=en:FindFirstChildOfClass("Humanoid")
                                    if eh and eh.Health>0 and en~=lp.Character then
                                        local erp=en.HumanoidRootPart
                                        local d=posRef and (erp.Position-posRef).Magnitude or (erp.Position-hrp.Position).Magnitude
                                        if d<400 then return en end
                                    end
                                end
                            end
                        end
                    end
                    return nil
                end
                while _G.AutoJackHunt do
                    local ok=pcall(function()
                        local hrp,hum,char=GetHRP() if not hrp or not hum then task.wait(0.3) return end
                        local jack=FindJackFast()
                        if jack then
                            local erp=jack:FindFirstChild("HumanoidRootPart") local eh=jack:FindFirstChildOfClass("Humanoid")
                            if erp and eh and eh.Health>0 then
                                while _G.AutoJackHunt and jack.Parent and eh.Health>0 do
                                    hrp,hum,char=GetHRP() if not hrp then break end
                                    if (hrp.Position-erp.Position).Magnitude>10 then if toTarget then toTarget(erp.CFrame*CFrame.new(0,8,2)) else hrp.CFrame=erp.CFrame*CFrame.new(0,8,2) end task.wait(0.08)
                                    else if BringMob then BringMob(jack) end if sizepart then sizepart(jack) end hrp.CFrame=CFrame.new(erp.Position+Vector3.new(0,8,0), erp.Position) local tool=EquipMelee() if tool then for i=1,3 do if not jack.Parent or eh.Health<=0 then break end if ClickM1 then ClickM1(jack,true) end tool:Activate() task.wait(0.07) end end end task.wait(0.05) end
                                return
                            end
                        end
                        local pumpkin=FindPumpkinFast() if not pumpkin then task.wait(0.3) return end
                        if pumpkin.dist>6 then
                            local goal=CFrame.new(pumpkin.pos.X, pumpkin.pos.Y+2, pumpkin.pos.Z)
                            if toTarget then toTarget(CFrame.new(goal.Position, pumpkin.pos)) else hrp.CFrame=CFrame.new(goal.Position, pumpkin.pos) end
                            task.wait(0.07)
                        else
                            local posBefore=pumpkin.pos local objBefore=pumpkin.obj
                            local st=tick()
                            while _G.AutoJackHunt and objBefore and objBefore.Parent and tick()-st<2.5 do
                                hrp,hum,char=GetHRP() if not hrp then break end
                                hrp.CFrame=CFrame.new(posBefore.X+math.random(-10,10)*0.05, posBefore.Y+1.5, posBefore.Z+math.random(-10,10)*0.05)
                                hrp.CFrame=CFrame.new(hrp.CFrame.Position, posBefore)
                                hrp.Velocity=Vector3.new(0,0,0)
                                local tool=EquipMelee()
                                if tool then
                                    tool:Activate()
                                    pcall(function() game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,true,game,0) task.wait() game:GetService("VirtualInputManager"):SendMouseButtonEvent(0,0,0,false,game,0) end)
                                    if ClickM1 then ClickM1(objBefore,true) end
                                    if objBefore:IsA("BasePart") then pcall(function() firetouchinterest(hrp, objBefore, 0) task.wait(0.01) firetouchinterest(hrp, objBefore, 1) end) end
                                end
                                task.wait(0.06)
                                if not objBefore.Parent then break end
                            end
                            local j=FindJackFast(posBefore)
                            if j then
                                local erp=j:FindFirstChild("HumanoidRootPart") local eh=j:FindFirstChildOfClass("Humanoid")
                                if erp and eh then
                                    while _G.AutoJackHunt and j.Parent and eh.Health>0 do
                                        hrp,hum,char=GetHRP() if not hrp then break end
                                        if (hrp.Position-erp.Position).Magnitude>10 then if toTarget then toTarget(erp.CFrame*CFrame.new(0,8,0)) else hrp.CFrame=erp.CFrame*CFrame.new(0,8,0) end task.wait(0.07)
                                        else if BringMob then BringMob(j) end if sizepart then sizepart(j) end hrp.CFrame=CFrame.new(erp.Position+Vector3.new(0,8,0),erp.Position) local tool=EquipMelee() if tool then for k=1,3 do if not j.Parent or eh.Health<=0 then break end if ClickM1 then ClickM1(j,true) end tool:Activate() task.wait(0.07) end end end task.wait(0.05) end
                                end
                            end
                        end
                    end)
                    if not ok then task.wait(0.15) end
                    task.wait(0.03)
                end
                if noclip then noclip:Disconnect() end
            end) end
        end
    )

    HalloweenSection.CreateLabel({ Title = "V4 DIALOG FIX: Trick or Treat! + Jack Turbo" })
    print("Halloween V4 carregado!")
end)
