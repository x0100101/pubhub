-- PubHub v3.0 — Steal an Egg module (PubHub UI v3)
-- Premium script hub with key authentication

local MODULE_URL = "https://raw.githubusercontent.com/x0100101/pubhub/main/core.lua"
local Core = loadstring(game:HttpGet(MODULE_URL))()
local RUNNING = true
local FPS_PAUSED = false
local statusHint, statusHintAt = "", 0
local function setStatus(s) statusHint = s; statusHintAt = os.clock() end

local track, onClean, log, setMeta, guardMeta, findCandidates, apply, randomName, hiddenParent, hrp, tpTo, humanoid, reqmod, remoteFor, inv, fire, refreshField, eggRecord, save, myEggs, eggReady, placeEgg, stealAllowed, lockMove, unlockMove, assetInfo, eggRank, eggScale, canFuseCat, eggHasMutation, isUid, scanEggs, myCenterPoint, resolveOwnBase, gotoStraight, returnToOwnBase, travelOutToEgg, fieldEggModel, fieldSlotKey, grabEgg =
    Core.track, Core.onClean, Core.log, Core.setMeta, Core.guardMeta, Core.findCandidates, Core.apply, Core.randomName, Core.hiddenParent, Core.hrp, Core.tpTo, Core.humanoid, Core.reqmod, Core.remoteFor, Core.inv, Core.fire, Core.refreshField, Core.eggRecord, Core.save, Core.myEggs, Core.eggReady, Core.placeEgg, Core.stealAllowed, Core.lockMove, Core.unlockMove, Core.assetInfo, Core.eggRank, Core.eggScale, Core.canFuseCat, Core.eggHasMutation, Core.isUid, Core.scanEggs, Core.myCenterPoint, Core.resolveOwnBase, Core.gotoStraight, Core.returnToOwnBase, Core.travelOutToEgg, Core.fieldEggModel, Core.fieldSlotKey, Core.grabEgg
local cloneref, RS, Players, RunService, Workspace, PPS, TeleportService, HttpService, CollectionService, UIS, Lighting, lp, Nav, Shared, ClientF, DataF, Remotes, EggState, PlotState, Assets, SaveMod, NAME_MAP, RARITY_ORDER, RARITY_LIST, MUTATION_LIST, SAFE_ZONE, fireprompt =
    Core.cloneref, Core.RS, Core.Players, Core.RunService, Core.Workspace, Core.PPS, Core.TeleportService, Core.HttpService, Core.CollectionService, Core.UIS, Core.Lighting, Core.lp, Core.Nav, Core.Shared, Core.ClientF, Core.DataF, Core.Remotes, Core.EggState, Core.PlotState, Core.Assets, Core.SaveMod, Core.NAME_MAP, Core.RARITY_ORDER, Core.RARITY_LIST, Core.MUTATION_LIST, Core.SAFE_ZONE, Core.fireprompt
onClean(function() RUNNING = false end)

-- ═══ PubHub UI v3 ═══
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0100101/pubhub/main/pubhub_ui_v3.lua"))()

local Window = UI:CreateWindow({ Title = "PubHub", Size = UDim2.fromOffset(700, 480) })

-- Реестр toggles/options (backward compat с Obsidian API)
local Toggles = {}
local Opt = {}

local function notify(m) UI:Notify({ Title = "PubHub", Text = tostring(m), Type = "info" }) end

-- FPS Pause
local FPS_PAUSE_KEYS = { se_selected = true, se_bloom = true, se_incubate = true, se_autofuse = true, se_automutate = true, se_autodeposit = true, se_boss = true }
local function on(k)
    local t = Toggles[k]
    local v = t and t:GetValue()
    if v and FPS_PAUSED and FPS_PAUSE_KEYS[k] then return false end
    return v
end

-- selSet для multi-dropdown: v — это table { [val]=true, ... }
local function selSet(key)
    local dd = Opt[key]
    local v = dd and dd:GetValue()
    if type(v) ~= "table" then return nil end
    local set, any = {}, false
    for k, val in pairs(v) do
        if val == true then set[k] = true; any = true
        elseif type(val) == "string" then set[val] = true; any = true end
    end
    return any and set or nil
end
local function step(name) local s = selSet("se_steps"); return s and s[name] == true or false end

-- ═══ TAB: Steal ═══
local StealTab = Window:AddTab("Steal", "target")

local StealCard = StealTab:AddCard("Steal Eggs", "left")
Opt.se_areas = StealCard:AddDropdown({ Text = "Zones", Values = {}, Multi = true, Default = {} })
Opt.se_rarities = StealCard:AddDropdown({ Text = "Rarities", Values = RARITY_LIST, Multi = true, Default = {} })
Opt.se_mutations = StealCard:AddDropdown({ Text = "Mutations", Values = MUTATION_LIST, Multi = true, Default = {} })
Opt.se_priority = StealCard:AddDropdown({ Text = "Priority", Values = { "Nearest", "Highest Value", "Highest Weight" }, Default = "Nearest" })
Toggles.se_selected = StealCard:AddToggle({ Text = "Auto-Steal", Default = false, Callback = function(v) if v then inv("LeaveTread") end end })
Opt.se_steps = StealCard:AddDropdown({ Text = "Auto-Steps", Values = { "Place", "Hatch", "Sell", "Treadmill" }, Multi = true, Default = {} })
Opt.se_keepsell = StealCard:AddDropdown({ Text = "Don't Sell", Values = RARITY_LIST, Multi = true, Default = { Legendary = true, Mythic = true, Rainbow = true, Cosmic = true, Exclusive = true, Secret = true, Exotic = true, Eternal = true, Limited = true, Superior = true, Divine = true } })
Toggles.se_return = StealCard:AddToggle({ Text = "Auto-Return", Default = true })
StealCard:AddButton({ Text = "Leave Treadmill", Callback = function() inv("LeaveTread") end })

local InfoCard = StealTab:AddCard("Info", "right")
local statLabel = InfoCard:AddLabel("FPS: -")
local stateLabel = InfoCard:AddLabel("Status: Active")
InfoCard:AddButton({ Text = "Rescan Zones", Callback = function()
    local areas = {}
    for _, m in ipairs(scanEggs()) do local r = eggRecord(m.Name); if r and r.AreaId then areas[r.AreaId] = true end end
    local al = {}; for k in pairs(areas) do al[#al + 1] = k end; table.sort(al)
    pcall(function() Opt.se_areas:SetValues(al) end)
    notify(#al .. " zones found")
end })

local fps = 0
do
    local frames, t0 = 0, os.clock()
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        local now = os.clock()
        if now - t0 >= 0.5 then
            fps = math.floor(frames / (now - t0) + 0.5); frames = 0; t0 = now
            if fps < 15 then FPS_PAUSED = true elseif fps >= 25 then FPS_PAUSED = false end
        end
    end)
end

task.spawn(function()
    local last = 0
    while RUNNING do
        local areas, n = {}, 0
        for _, m in ipairs(scanEggs()) do local r = eggRecord(m.Name); if r and r.AreaId and not areas[r.AreaId] then areas[r.AreaId] = true; n = n + 1 end end
        if n > last then
            local al = {}; for k in pairs(areas) do al[#al + 1] = k end; table.sort(al)
            pcall(function() Opt.se_areas:SetValues(al) end); last = n
        end
        task.wait(3)
    end
end)

local function rebuildHumanoid()
    local c = lp.Character; if not c then return end
    local old = c:FindFirstChildOfClass("Humanoid"); if not old then return end
    local new = Instance.new("Humanoid")
    pcall(function()
        new.RigType = old.RigType; new.HipHeight = old.HipHeight; new.WalkSpeed = old.WalkSpeed
        new.JumpPower = old.JumpPower; new.JumpHeight = old.JumpHeight; new.MaxHealth = old.MaxHealth
        new.Health = old.Health; new.AutoRotate = old.AutoRotate
        new.NameDisplayDistance = old.NameDisplayDistance; new.HealthDisplayDistance = old.HealthDisplayDistance
        new.DisplayDistanceType = old.DisplayDistanceType
    end)
    old:Destroy(); new.Parent = c; task.wait()
    pcall(function() new:ChangeState(Enum.HumanoidStateType.GettingUp) end)
end

local function clearRagdoll()
    local c = lp.Character; if not c then return end
    for _, d in ipairs(c:GetDescendants()) do
        if d:GetAttribute("RagdollConstraint") ~= nil or d:GetAttribute("RagdollAttachment") ~= nil then pcall(function() d:Destroy() end)
        elseif d:IsA("Motor6D") and not d.Enabled then pcall(function() d.Enabled = true end) end
    end
    local hum = humanoid()
    if hum then if hum.PlatformStand then pcall(function() hum.PlatformStand = false end) end pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
    local h = hrp()
    if h then pcall(function() h.CanCollide = true end); pcall(function() h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end) end
end

local function getRoot(char)
    local h = char and char:FindFirstChildOfClass("Humanoid")
    return h and h.RootPart
end
local function suicide()
    local plr = lp
    local char = plr.Character
    local hum = char and char:FindFirstChildWhichIsA("Humanoid")
    if not char or not hum or not getRoot(char) then return end
    pcall(function()
        local archive = Workspace.FallenPartsDestroyHeight
        Workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
        Workspace.FallenPartsDestroyHeight = 0 / 0
        getRoot(char).Position = Vector3.yAxis * archive
        task.wait(plr:GetNetworkPing())
        Workspace.FallenPartsDestroyHeight = archive
        repeat task.wait() until not char.Parent or not hum.Parent or (hum and hum.Health <= 0)
        if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Dead, true) end
    end)
end

local fpCarrying, fpCarryUid = false, nil
pcall(function()
    EggState.CarryChanged:Connect(function(p)
        if type(p) == "table" and (p.CarrierUserId == nil or p.CarrierUserId == lp.UserId) then
            fpCarrying = (p.IsCarrying == true); fpCarryUid = fpCarrying and p.Uid or nil
        end
    end)
end)
local function nearestForest()
    local h = hrp(); if not h then return nil end
    local best, bestD
    for _, m in ipairs(scanEggs()) do
        local r = eggRecord(m.Name)
        if r and r.AreaId == "Forest" and (not r.State or r.State == "Slot") then
            local ok, p = pcall(function() return m:GetPivot().Position end)
            if ok and p then local d = (p - h.Position).Magnitude; if not bestD or d < bestD then best = { m = m, uid = m.Name, pos = p }; bestD = d end end
        end
    end
    return best
end

local hopping = false
local function httpGetJson(url)
    local body
    local req = (syn and syn.request) or (http and http.request) or (fluxus and fluxus.request)
        or http_request or request or (getgenv and getgenv().request)
    if req then
        local ok, res = pcall(req, { Url = url, Method = "GET" })
        if ok and type(res) == "table" then body = res.Body or res.body end
    end
    if not body or body == "" then
        local ok, res = pcall(function() return game:HttpGet(url) end)
        if ok then body = res end
    end
    if not body or body == "" then return nil end
    local ok, data = pcall(function() return HttpService:JSONDecode(body) end)
    if ok then return data end
    return nil
end
local function serverHop(pref)
    if hopping then return end
    hopping = true
    local placeId = game.PlaceId
    local list, cursor, scanned = {}, nil, 0
    for _ = 1, 10 do
        local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Asc&limit=100"):format(placeId)
        if cursor then url = url .. "&cursor=" .. cursor end
        local data = httpGetJson(url)
        if not data or type(data.data) ~= "table" then break end
        for _, s in ipairs(data.data) do
            scanned += 1
            if type(s.playing) == "number" and s.id ~= game.JobId and s.playing < (s.maxPlayers or 999) then
                list[#list + 1] = s
            end
        end
        if data.nextPageCursor and data.nextPageCursor ~= "" then cursor = data.nextPageCursor else break end
        task.wait(0.1)
    end
    if #list == 0 then
        notify(scanned == 0 and "Hop: API blocked (0 servers)" or "Hop: no servers, retry")
        hopping = false
        return
    end
    if pref == "Highest Players" then table.sort(list, function(a, b) return a.playing > b.playing end)
    else table.sort(list, function(a, b) return a.playing < b.playing end) end
    notify(("Hop: found %d servers"):format(#list))
    local idx = 0
    local conn
    local function tryNext()
        idx = idx + 1
        local s = list[idx]
        if not s then if conn then conn:Disconnect() end; hopping = false; notify("Hop: all failed, retry"); return end
        pcall(function() TeleportService:TeleportToPlaceInstance(placeId, s.id, lp) end)
    end
    conn = TeleportService.TeleportInitFailed:Connect(function(who)
        if who == lp then task.wait(0.5); tryNext() end
    end)
    tryNext()
    task.delay(25, function() if conn then conn:Disconnect() end; hopping = false end)
end

local VIM_SVC = game:GetService("VirtualInputManager")
local BAT_NUMKEYS = { Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five,
                      Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine, Enum.KeyCode.Zero }
local function isBatTool(t)
    return t:IsA("Tool") and (t:GetAttribute("IsBat") == true or t:FindFirstChild("HitAnim") ~= nil
        or tostring(t.Name):lower():find("bat") ~= nil)
end
local function heldBat()
    local c = lp.Character; if not c then return false end
    for _, t in ipairs(c:GetChildren()) do if isBatTool(t) then return true end end
    return false
end
local function equipBatInput(silent)
    if heldBat() then return true end
    local bp = lp:FindFirstChildOfClass("Backpack")
    local function owns() if bp then for _, t in ipairs(bp:GetChildren()) do if isBatTool(t) then return true end end end return false end
    if not owns() then
        local codex = Remotes and Remotes.Codex and Remotes.Codex.AskWearFieldBat
        if codex then pcall(function() codex:InvokeServer(lp:GetAttribute("AreaId")) end) end
        local t0 = os.clock(); while os.clock() - t0 < 1 and not (heldBat() or owns()) do task.wait(0.1) end
        if heldBat() then return true end
        if not owns() then if not silent then notify("No bat to equip") end return false end
    end
    for i = 1, 10 do
        pcall(function()
            VIM_SVC:SendKeyEvent(true, BAT_NUMKEYS[i], false, game); task.wait(0.03)
            VIM_SVC:SendKeyEvent(false, BAT_NUMKEYS[i], false, game)
        end)
        task.wait(0.08)
        if heldBat() then if not silent then notify("Bat equipped via slot " .. (i == 10 and 0 or i)) end return true end
    end
    if not silent then notify("Hotbar keys failed — keep Roblox focused") end
    return false
end

-- ═══ Movement Card ═══
local MoveCard = StealTab:AddCard("Movement", "right")
Toggles.se_tpwalk = MoveCard:AddToggle({ Text = "Walk Speed", Default = true })
Opt.se_walk = MoveCard:AddSlider({ Text = "Walk Speed", Min = 0, Max = 1000, Default = 409 })
Toggles.se_fly = MoveCard:AddToggle({ Text = "Fly", Default = false })
Opt.se_flyspeed = MoveCard:AddSlider({ Text = "Fly Speed", Min = 20, Max = 1000, Default = 60 })
Toggles.se_antikb = MoveCard:AddToggle({ Text = "Anti-Fling", Default = true })
Toggles.se_antihit = MoveCard:AddToggle({ Text = "Anti-Hit", Default = true })
Toggles.se_esp = MoveCard:AddToggle({ Text = "Egg ESP", Default = false })
MoveCard:AddButton({ Text = "Suicide", Callback = function() task.spawn(suicide) end })

local ServerCard = StealTab:AddCard("Server", "left")
Opt.se_hoppref = ServerCard:AddDropdown({ Text = "Hop Mode", Values = { "Lowest Players", "Highest Players" }, Default = "Lowest Players" })
ServerCard:AddButton({ Text = "Server Hop", Callback = function()
    local pref = (Opt.se_hoppref and Opt.se_hoppref:GetValue()) or "Lowest Players"
    task.spawn(function() serverHop(pref) end)
end })
ServerCard:AddButton({ Text = "Rejoin", Callback = function()
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end)
end })

RunService.Heartbeat:Connect(function(dt)
    if not RUNNING or not on("se_tpwalk") then return end
    local hum, h = humanoid(), hrp()
    if hum and h then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then h.CFrame = h.CFrame + dir * ((Opt.se_walk and Opt.se_walk:GetValue()) or 409) * dt end
    end
end)

local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local flyUp, flyDown, flyGui = false, false, nil
local flyWasOn = false
local function flyButtons(make)
    if make and not flyGui then
        flyGui = Instance.new("ScreenGui")
        flyGui.Name = randomName(); flyGui.ResetOnSpawn = false; flyGui.IgnoreGuiInset = true
        hiddenParent(flyGui)
        local function mk(t, yoff)
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(0, 70, 0, 70); b.AnchorPoint = Vector2.new(1, 1)
            b.Position = UDim2.new(1, -20, 1, yoff); b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            b.BackgroundTransparency = 0.35; b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.TextScaled = true; b.Text = t; b.Parent = flyGui
            return b
        end
        local up, dn = mk("UP", -110), mk("DOWN", -28)
        up.MouseButton1Down:Connect(function() flyUp = true end); up.MouseButton1Up:Connect(function() flyUp = false end)
        dn.MouseButton1Down:Connect(function() flyDown = true end); dn.MouseButton1Up:Connect(function() flyDown = false end)
    elseif not make and flyGui then
        flyGui:Destroy(); flyGui = nil
    end
end
onClean(function() if flyGui then pcall(function() flyGui:Destroy() end); flyGui = nil end end)
RunService.Heartbeat:Connect(function(dt)
    if not RUNNING then return end
    if not on("se_fly") then
        if flyGui then flyButtons(false) end
        if flyWasOn then flyWasOn = false; local hh = humanoid(); if hh then pcall(function() hh.PlatformStand = false; hh.AutoRotate = true end) end end
        return
    end
    flyWasOn = true
    local h, hum = hrp(), humanoid()
    if not h then return end
    if isMobile and not flyGui then flyButtons(true) end
    if hum then pcall(function() hum.PlatformStand = true; hum.AutoRotate = false end) end
    local cam = Workspace.CurrentCamera.CFrame
    local sp = (Opt.se_flyspeed and Opt.se_flyspeed:GetValue()) or 60
    local dir = Vector3.zero
    if isMobile then
        local mv = (hum and hum.MoveDirection) or Vector3.zero
        if mv.Magnitude > 0 then
            local fl = Vector3.new(cam.LookVector.X, 0, cam.LookVector.Z)
            if fl.Magnitude > 0 then fl = fl.Unit end
            dir += cam.LookVector * mv:Dot(fl)
        end
        if flyUp then dir += Vector3.yAxis end
        if flyDown then dir -= Vector3.yAxis end
    else
        if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.LookVector end
        if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.RightVector end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.yAxis end
        if UIS:IsKeyDown(Enum.KeyCode.Q) then dir -= Vector3.yAxis end
    end
    h.AssemblyLinearVelocity = Vector3.zero
    h.AssemblyAngularVelocity = Vector3.zero
    if dir.Magnitude > 0 then h.CFrame = h.CFrame + dir.Unit * sp * dt end
end)

task.spawn(function()
    local lastRagClear = 0
    while RUNNING do
        if on("se_antikb") then
            local rt = lp:GetAttribute("RagdollEndTime")
            local hum = humanoid()
            local ragged = (type(rt) == "number" and rt > Workspace:GetServerTimeNow()) or (hum and hum:GetState() == Enum.HumanoidStateType.Physics)
            if ragged and os.clock() - lastRagClear > 0.4 then clearRagdoll(); lastRagClear = os.clock() end
            task.wait(0.1)
        else task.wait(0.2) end
    end
end)

task.spawn(function() task.wait(0.5); pcall(rebuildHumanoid) end)
lp.CharacterAdded:Connect(function()
    if not RUNNING then return end
    unlockMove()
    task.wait(1.2); pcall(rebuildHumanoid)
end)

local RARITY_COLOR = {
    Common = Color3.fromRGB(200, 200, 200), Uncommon = Color3.fromRGB(90, 220, 90),
    Rare = Color3.fromRGB(70, 150, 255), SuperRare = Color3.fromRGB(70, 190, 255), Celestial = Color3.fromRGB(120, 230, 255),
    Epic = Color3.fromRGB(200, 90, 255), Mythic = Color3.fromRGB(255, 90, 200), Mythical = Color3.fromRGB(255, 90, 200),
    Legendary = Color3.fromRGB(255, 175, 40), Rainbow = Color3.fromRGB(255, 120, 220), Cosmic = Color3.fromRGB(150, 90, 255),
    Exclusive = Color3.fromRGB(255, 100, 100), Secret = Color3.fromRGB(255, 60, 60), Exotic = Color3.fromRGB(255, 130, 60),
    Eternal = Color3.fromRGB(255, 235, 120), Limited = Color3.fromRGB(120, 255, 200), Superior = Color3.fromRGB(255, 255, 255), Divine = Color3.fromRGB(255, 245, 200),
}
local function eggInfoText(m)
    local r = eggRecord(m.Name)
    if not r or not r.AssetCategory then return "Egg", Color3.fromRGB(0, 255, 128) end
    local info = assetInfo(r.AssetCategory)
    local rar = info.rarity or "?"
    local lines = { r.AssetCategory .. "  [" .. rar .. "]" }
    if info.weight and r.AssetScale then lines[#lines + 1] = string.format("%.2f kg", info.weight * (r.AssetScale ^ 3))
    elseif info.weight then lines[#lines + 1] = string.format("%.2f kg", info.weight) end
    if r.Mutations and #r.Mutations > 0 then lines[#lines + 1] = table.concat(r.Mutations, ", ") end
    return table.concat(lines, "\n"), (RARITY_COLOR[rar] or Color3.fromRGB(0, 255, 128))
end
local espCache = {}
local function makeEsp(m)
    local text, col = eggInfoText(m)
    local hl = Instance.new("Highlight")
    hl.FillColor = col; hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.55; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = m; hl.Parent = m
    local bb = Instance.new("BillboardGui")
    bb.Name = randomName(); bb.Size = UDim2.fromOffset(190, 52); bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true; bb.Adornee = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart"); bb.Parent = m
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.fromScale(1, 1); tl.BackgroundTransparency = 1; tl.TextColor3 = col
    tl.TextStrokeTransparency = 0.25; tl.Font = Enum.Font.GothamBold; tl.TextSize = 14; tl.Text = text; tl.Parent = bb
    return { hl = hl, bb = bb }
end
local function destroyEsp(e) pcall(function() e.hl:Destroy() end); pcall(function() e.bb:Destroy() end) end
onClean(function() for _, e in pairs(espCache) do destroyEsp(e) end; espCache = {} end)
task.spawn(function()
    while RUNNING do
        if on("se_esp") then
            local present = {}
            for _, m in ipairs(scanEggs()) do
                present[m] = true
                if not espCache[m] or not (espCache[m].hl and espCache[m].hl.Parent) then espCache[m] = makeEsp(m) end
            end
            for m, e in pairs(espCache) do if not present[m] then destroyEsp(e); espCache[m] = nil end end
        elseif next(espCache) then
            for m, e in pairs(espCache) do destroyEsp(e); espCache[m] = nil end
        end
        task.wait(0.5)
    end
end)

local function eggWeight(uid)
    local r = eggRecord(uid)
    if not r or not r.AssetCategory then return 0 end
    local info = assetInfo(r.AssetCategory)
    return (info.weight or 0) * ((tonumber(r.AssetScale) or 1) ^ 3)
end

local function passesFilters(uid, useRarityMut)
    local r = eggRecord(uid)
    local wantAreas = selSet("se_areas")
    if wantAreas and not (r and r.AreaId and wantAreas[r.AreaId]) then return false end
    if useRarityMut then
        local wantRar = selSet("se_rarities")
        if wantRar then
            local info = r and r.AssetCategory and assetInfo(r.AssetCategory)
            if not (info and info.rarity and wantRar[info.rarity]) then return false end
        end
        local wantMut = selSet("se_mutations")
        if wantMut and not eggHasMutation(uid, wantMut) then return false end
    end
    return true
end
local function sortByPriority(list)
    local pr = (Opt.se_priority and Opt.se_priority:GetValue()) or "Nearest"
    if pr == "Highest Value" then
        local rk = {}; for _, m in ipairs(list) do local r = eggRecord(m.Name); rk[m] = eggRank(r and r.AssetCategory) end
        table.sort(list, function(a, b) return (rk[a] or 0) > (rk[b] or 0) end)
    elseif pr == "Highest Weight" then
        local w = {}; for _, m in ipairs(list) do w[m] = eggWeight(m.Name) end
        table.sort(list, function(a, b) return (w[a] or 0) > (w[b] or 0) end)
    else
        local h = hrp(); local myPos = h and h.Position
        if myPos then
            local d = {}; for _, m in ipairs(list) do local ok, p = pcall(function() return m:GetPivot().Position end); d[m] = ok and (p - myPos).Magnitude or math.huge end
            table.sort(list, function(a, b) return (d[a] or 0) < (d[b] or 0) end)
        end
    end
end

task.spawn(function()
    while RUNNING do
        if step("Place") then
            for k, rec in pairs(myEggs()) do
                if not step("Place") then break end
                if type(rec) == "table" and rec.Placement == nil then placeEgg(rec.Uid or k); task.wait(0.2) end
            end
        end
        if step("Hatch") then
            for k, rec in pairs(myEggs()) do
                if not step("Hatch") then break end
                local uid = rec and rec.Uid or k
                if type(rec) == "table" and rec.Placement ~= nil and eggReady(uid) then
                    pcall(EggState.BeginHatch, uid); task.wait(0.2)
                    pcall(EggState.FinishHatch, uid); task.wait(0.15)
                end
            end
        end
        if step("Sell") then
            inv("EquipBest")
            task.wait(3)
            local s = save()
            if s and type(s.Inventory) == "table" then
                local equipped = {}
                for _, u in ipairs(s.EquippedAssets or {}) do equipped[u] = true end
                local sellList = {}
                local keepSet = selSet("se_keepsell")
                for uid, item in pairs(s.Inventory) do
                    if type(item) == "table" and not equipped[uid] and item.IsFavorite ~= true and item.InFuse ~= true then
                        local protectedRarity = false
                        if keepSet then local rar = assetInfo(item.Category).rarity; protectedRarity = rar ~= nil and keepSet[rar] == true end
                        if not protectedRarity then sellList[#sellList + 1] = uid end
                    end
                end
                if #sellList > 0 then fire("SellPets", sellList) end
            end
        end
        task.wait(1)
    end
end)

local stolen = 0
task.spawn(function()
    while RUNNING do
        pcall(function() statLabel:SetText("FPS: " .. fps) end)
        pcall(function()
            local disp
            if FPS_PAUSED then disp = "PAUSED - low FPS (" .. fps .. ")"
            elseif not stealAllowed() then disp = "Paused (eggs reset)"
            elseif os.clock() - statusHintAt < 2.5 then disp = statusHint
            elseif on("se_selected") or on("se_bloom") then disp = "Active"
            else disp = "Waiting" end
            stateLabel:SetText("Status: " .. tostring(disp))
        end)
        task.wait(0.5)
    end
end)

local TREAD = Remotes and Remotes.Treadmill
local onTread = false
local function targetEggsExist()
    for _, m in ipairs(scanEggs()) do if passesFilters(m.Name, true) then return true end end
    return false
end
local function treadTop()
    local r = Workspace:FindFirstChild("__ClientTreadmillRenders"); if not r then return nil end
    local h = hrp(); local hp = h and h.Position
    local best, bestD
    for _, p in ipairs(r:GetDescendants()) do
        if p:IsA("BasePart") and (p.Name == "Belt" or p.Name == "Runner" or p.Name == "Top" or p.Name == "Floor" or p.Name == "Tread") then
            local d = hp and (p.Position - hp).Magnitude or 0
            if not bestD or d < bestD then bestD = d; best = p end
        end
    end
    if best then return best end
    for _, m in ipairs(r:GetChildren()) do if m:IsA("Model") then local p = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart", true); if p then return p end end end
end
local function leaveTread() if onTread then onTread = false; pcall(function() if TREAD and TREAD.AskDoff then TREAD.AskDoff:InvokeServer() end end) end end
local lastDoffAt = 0
local function forceDoff()
    onTread = false
    if os.clock() - lastDoffAt < 2 then return end
    lastDoffAt = os.clock()
    pcall(function() if TREAD and TREAD.AskDoff then TREAD.AskDoff:InvokeServer() end end)
end
local function mountTread()
    local part = treadTop(); if not part then setStatus("Treadmill not found"); return end
    setStatus("Going to treadmill")
    Nav.tweenTo3D(part.Position + Vector3.new(0, 3, 0), function() return RUNNING and on("se_selected") and step("Treadmill") and not targetEggsExist() end, (Opt.se_walk and Opt.se_walk:GetValue()) or 300)
    if targetEggsExist() then return end
    if TREAD and TREAD.AskWearStill then pcall(function() TREAD.AskWearStill:InvokeServer() end) end
    onTread = true
    setStatus("On treadmill (no eggs)")
end

task.spawn(function()
    while RUNNING do
        if on("se_selected") and stealAllowed() and targetEggsExist() then
            local h = hrp()
            local top = h and treadTop()
            if h and top and (h.Position - top.Position).Magnitude < 12 then forceDoff() end
        end
        task.wait(0.4)
    end
end)

task.spawn(function()
    while RUNNING do
        local ok = pcall(function()
            if not on("se_selected") then leaveTread(); return end
            if not stealAllowed() then setStatus("Paused (eggs reset)"); return end
            local list = {}
            for _, m in ipairs(scanEggs()) do if passesFilters(m.Name, true) then list[#list + 1] = m end end
            if #list == 0 then
                if step("Treadmill") then mountTread() else forceDoff(); setStatus("Waiting for eggs") end
                return
            end
            forceDoff()
            sortByPriority(list)
            local keepGoing = function() return on("se_selected") and stealAllowed() end
            local m = list[1]
            local uid = m.Name
            local speed = (Opt.se_walk and Opt.se_walk:GetValue()) or 300
            local okp, pos = pcall(function() return m:GetPivot().Position end)
            if not okp or not pos then return end
            lockMove()
            local fr = nearestForest()
            if not fr then setStatus("No forest egg"); unlockMove(); return end
            setStatus("Preparing: forest egg")
            travelOutToEgg(fr.pos, keepGoing, 400)
            do local t0 = os.clock(); while os.clock() - t0 < 1.5 do grabEgg(fr.m, fr.uid); if fpCarrying or fieldEggModel(fr.uid) == nil then break end; task.wait(0.15) end end
            setStatus("Waiting for chicken hit...")
            local RAG = { [Enum.HumanoidStateType.Physics] = true, [Enum.HumanoidStateType.Ragdoll] = true, [Enum.HumanoidStateType.FallingDown] = true }
            local hit, conns, wasCarry = false, {}, fpCarrying
            local hum0 = humanoid()
            if hum0 then conns[#conns + 1] = hum0.StateChanged:Connect(function(_, s) if RAG[s] then hit = true end end) end
            local ch = lp.Character
            if ch then conns[#conns + 1] = ch.DescendantAdded:Connect(function(d)
                if d:IsA("BallSocketConstraint") or d:IsA("HingeConstraint") then hit = true
                elseif d:IsA("Attachment") and tostring(d.Name):find("Ragdoll") then hit = true end
            end) end
            local t1 = os.clock()
            while not hit and os.clock() - t1 < 25 and keepGoing() do
                local hh = humanoid()
                if hh then if hh.PlatformStand then hit = true end if RAG[hh:GetState()] then hit = true end end
                local rt = hrp(); if rt and rt.AssemblyLinearVelocity.Magnitude > 45 then hit = true end
                if wasCarry and not fpCarrying then hit = true end
                RunService.Heartbeat:Wait()
            end
            for _, c in ipairs(conns) do pcall(function() c:Disconnect() end) end
            if not hit then setStatus("Hit not detected in 25s"); unlockMove(); return end
            tpTo(pos); clearRagdoll()
            setStatus("Stealing target")
            local function haveIt() return fpCarrying == true and (fpCarryUid == nil or fpCarryUid == uid) end
            local tg = os.clock()
            while keepGoing() and not haveIt() and os.clock() - tg < 4 do
                clearRagdoll()
                local h = hrp()
                if h then
                    local flat = Vector3.new(pos.X, h.Position.Y, pos.Z)
                    if (flat - h.Position).Magnitude > 4 then h.CFrame = CFrame.new(flat) * (h.CFrame - h.CFrame.Position); h.AssemblyLinearVelocity = Vector3.zero end
                end
                grabEgg(fieldEggModel(uid) or m, uid); task.wait(0.15)
            end
            if not haveIt() then setStatus("Failed to grab target"); unlockMove(); return end
            stolen = stolen + 1
            if on("se_return") then
                local retSpeed = on("se_tpwalk") and ((Opt.se_walk and Opt.se_walk:GetValue()) or 409) or speed
                local delivered, guard = false, os.clock()
                while keepGoing() and not delivered and os.clock() - guard < 45 do
                    clearRagdoll()
                    if not fpCarrying then
                        local em = fieldEggModel(uid)
                        if not em then delivered = true; break end
                        if not on("se_antihit") then setStatus("Egg dropped (anti-hit off)"); break end
                        setStatus("Egg dropped -> returning for it")
                        local gg = os.clock()
                        while keepGoing() and not fpCarrying and fieldEggModel(uid) and os.clock() - gg < 8 do
                            clearRagdoll()
                            local em2 = fieldEggModel(uid)
                            local ep = em2 and select(2, pcall(function() return em2:GetPivot().Position end))
                            local h = hrp()
                            if h and typeof(ep) == "Vector3" then
                                local flat = Vector3.new(ep.X, h.Position.Y, ep.Z)
                                if (flat - h.Position).Magnitude > 4 then h.CFrame = CFrame.new(flat) * (h.CFrame - h.CFrame.Position); h.AssemblyLinearVelocity = Vector3.zero end
                            end
                            grabEgg(em2 or em, uid); task.wait(0.15)
                        end
                    else
                        setStatus("Returning to base")
                        returnToOwnBase(function() return keepGoing() and fpCarrying end, retSpeed)
                        if fpCarrying then inv("Place", { Uid = uid, LocalCFrame = CFrame.new(math.random(-8, 8), 0, math.random(-8, 8)) }); task.wait(0.15); delivered = true end
                    end
                end
            end
            unlockMove()
        end)
        if not ok then unlockMove(); setStatus("Recovering...") end
        task.wait(0.2)
    end
end)

-- ═══ TAB: Events ═══
local EventsTab = Window:AddTab("Events", "zap")

local BloomCard = EventsTab:AddCard("Sakura Bloom", "left")
Toggles.se_bloom = BloomCard:AddToggle({ Text = "Auto-Farm Bloom", Default = false })

local FuseCard = EventsTab:AddCard("Fusion Machine", "left")
Toggles.se_autofuse = FuseCard:AddToggle({ Text = "Auto-Fuse Pets", Default = false })

local IncCard = EventsTab:AddCard("Sakura Incubator", "right")
local crysLabel = IncCard:AddLabel("Crystals: 0")
Toggles.se_incubate = IncCard:AddToggle({ Text = "Auto-Incubate", Default = false })
Toggles.se_autodeposit = IncCard:AddToggle({ Text = "Auto-Deposit", Default = true })
Toggles.se_automutate = IncCard:AddToggle({ Text = "Auto-Mutate on Full", Default = true })

local BossCard = EventsTab:AddCard("Boss Event", "right")
Toggles.se_boss = BossCard:AddToggle({ Text = "Auto-Boss (enter + crystal hits)", Default = false })
local bossLabel = BossCard:AddLabel("Boss: waiting")
local bossCountLabel = BossCard:AddLabel("Next boss: --:--")

local BOSS = Remotes and Remotes.BossEvent
local function bossArena() return Workspace:FindFirstChild("BossArena", true) end
local function inArena() return lp:GetAttribute("InBossArena") == true end
local function crystalHitboxes()
    local a = bossArena(); if not a then return {} end
    local folder = a:FindFirstChild("CrystalTowers", true); if not folder then return {} end
    local out = {}
    for _, c in ipairs(folder:GetChildren()) do
        local hb = c:FindFirstChild("Hitbox")
        if hb and hb:IsA("BasePart") then
            local hpv = hb:GetAttribute("Health")
            if hpv == nil or (type(hpv) == "number" and hpv > 0) then out[#out + 1] = hb end
        end
    end
    return out
end
local function worldPosOf(inst)
    if not inst then return nil end
    if inst:IsA("BasePart") then return inst.Position end
    local ok, p = pcall(function() return inst.WorldPosition end); if ok and typeof(p) == "Vector3" then return p end
    local ok2, cf = pcall(function() return inst.WorldCFrame end); if ok2 and cf then return cf.Position end
    return nil
end
local function armTargets()
    local a = bossArena(); if not a then return {} end
    local bm = a:FindFirstChild("Boss", true); if not bm then return {} end
    local out = {}
    for _, d in ipairs(bm:GetDescendants()) do
        if (d:IsA("Bone") or d:IsA("BasePart")) and d:FindFirstChild("Health") ~= nil then out[#out + 1] = d end
    end
    return out
end
local function bossBodyPart()
    local a = bossArena(); if not a then return nil end
    local boss = a:FindFirstChild("Boss", true); if not boss then return nil end
    if boss:IsA("BasePart") then return boss end
    return boss.PrimaryPart or boss:FindFirstChild("HumanoidRootPart", true) or boss:FindFirstChildWhichIsA("BasePart", true)
end
local _bossSeq = 0
local function swingBat(faceAt)
    _bossSeq = _bossSeq + 1
    local id = ("%d:%d:%d"):format(lp.UserId, _bossSeq, math.floor(Workspace:GetServerTimeNow() * 1000))
    local h, tp = hrp(), worldPosOf(faceAt)
    if h and tp then
        local flat = Vector3.new(tp.X, h.Position.Y, tp.Z)
        pcall(function() if (flat - h.Position).Magnitude > 0.1 then h.CFrame = CFrame.lookAt(h.Position, flat) end end)
    end
    pcall(function() Remotes.BatSwing.Trigger:FireServer(nil, id) end)
end
local function orbitAndSwing(target, keep)
    local RADIUS = 7
    for step = 0, 5 do
        if not (keep() and target and target.Parent) then return end
        local c = worldPosOf(target); if not c then return end
        local ang = (step / 6) * math.pi * 2
        local pos = c + Vector3.new(math.cos(ang) * RADIUS, 3, math.sin(ang) * RADIUS)
        Nav.tweenTo3D(pos, keep, (Opt.se_walk and Opt.se_walk:GetValue()) or 300)
        if not (keep() and target and target.Parent) then return end
        swingBat(target)
        task.wait(0.5)
    end
end
task.spawn(function()
    while RUNNING do
        if on("se_boss") and BOSS then
            if not inArena() then
                pcall(function() bossLabel:SetText("Boss: entering") end)
                pcall(function() if BOSS.AskEnter then BOSS.AskEnter:InvokeServer() end end)
                task.wait(1)
            else
                if not heldBat() then equipBatInput(true) end
                local keep = function() return RUNNING and on("se_boss") and inArena() end
                local crystals = crystalHitboxes()
                if #crystals > 0 then
                    local h = hrp()
                    if h then table.sort(crystals, function(a, b) return (a.Position - h.Position).Magnitude < (b.Position - h.Position).Magnitude end) end
                    pcall(function() bossLabel:SetText("Boss: crystals (" .. #crystals .. " left)") end)
                    orbitAndSwing(crystals[1], keep)
                else
                    local arms = armTargets()
                    if #arms > 0 then
                        local h = hrp()
                        if h then table.sort(arms, function(a, b) return ((worldPosOf(a) or h.Position) - h.Position).Magnitude < ((worldPosOf(b) or h.Position) - h.Position).Magnitude end) end
                        pcall(function() bossLabel:SetText("Boss: arms (" .. #arms .. ")") end)
                        orbitAndSwing(arms[1], keep)
                    else
                        local body = bossBodyPart()
                        if body then
                            pcall(function() bossLabel:SetText("Boss: body (no arms)") end)
                            orbitAndSwing(body, keep)
                        else
                            pcall(function() bossLabel:SetText("Boss: waiting (phase)") end); task.wait(0.5)
                        end
                    end
                end
            end
        else
            task.wait(1)
        end
    end
end)
task.spawn(function()
    while RUNNING do
        local s = save()
        pcall(function() crysLabel:SetText("Crystals: " .. tostring(s and s.SakuraCrystals or 0)) end)
        task.wait(1)
    end
end)

task.spawn(function()
    while RUNNING do
        pcall(function()
            if inArena() then bossCountLabel:SetText("Boss: ACTIVE")
            else
                local secs = 1800 - Workspace:GetServerTimeNow() % 1800
                bossCountLabel:SetText(("Next boss ~%d:%02d"):format(math.floor(secs / 60), math.floor(secs % 60)))
            end
        end)
        task.wait(1)
    end
end)

task.spawn(function()
    local pausedByBoss = false
    while RUNNING do
        if inArena() then
            if Toggles.se_selected and Toggles.se_selected:GetValue() and not pausedByBoss then
                pausedByBoss = true
                pcall(function() Toggles.se_selected:SetValue(false) end)
            end
        elseif pausedByBoss then
            pausedByBoss = false
            pcall(function() if Toggles.se_selected then Toggles.se_selected:SetValue(true) end end)
        end
        task.wait(1)
    end
end)

do
    local noclipped = {}
    local function setNoclip(want)
        local c = lp.Character; if not c then return end
        if want then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.CanCollide then noclipped[p] = true; pcall(function() p.CanCollide = false end) end
            end
        else
            for p in pairs(noclipped) do if p and p.Parent then pcall(function() p.CanCollide = true end) end noclipped[p] = nil end
        end
    end
    task.spawn(function()
        local active = false
        while RUNNING do
            if on("se_boss") and inArena() then setNoclip(true); active = true
            elseif active then setNoclip(false); active = false end
            RunService.Stepped:Wait()
        end
        if active then setNoclip(false) end
    end)
end

local function bloomActive()
    local ends = Workspace:GetAttribute("GreatBloomEndsAt")
    return type(ends) == "number" and ends > os.time()
end
local function bloomGo() return on("se_bloom") and bloomActive() and stealAllowed() end

local lastBatAt = 0
task.spawn(function()
    while RUNNING do
        local ok = pcall(function()
            if not bloomGo() then return end
            setStatus("Farming bloom")
            if os.clock() - lastBatAt > 4 then lastBatAt = os.clock(); inv("WearBat", lp:GetAttribute("AreaId")) end
            for _, tree in ipairs(CollectionService:GetTagged("SakuraBloomTree")) do
                if not bloomGo() then break end
                local okp, pos = pcall(function() return tree:GetPivot().Position end)
                if okp and pos then
                    lockMove()
                    setStatus("Bloom: tree hits")
                    Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_walk and Opt.se_walk:GetValue()) or 200)
                    local t0 = os.clock()
                    while bloomGo() and tree.Parent and os.clock() - t0 < 15 do
                        fire("BloomHit", tree); task.wait(0.5)
                    end
                    unlockMove()
                end
            end
            for _, crys in ipairs(CollectionService:GetTagged("SakuraCrystal")) do
                if not bloomGo() then break end
                if crys:GetAttribute("Owner") == lp.UserId then
                    local okp, pos = pcall(function() return crys:GetPivot().Position end)
                    if okp and pos then
                        lockMove()
                        setStatus("Bloom: crystal collect")
                        Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_walk and Opt.se_walk:GetValue()) or 200)
                        pcall(function() inv("BloomGather", crys) end)
                        unlockMove()
                    end
                end
            end
        end)
        if not ok then unlockMove() end
        task.wait(0.4)
    end
end)

task.spawn(function()
    while RUNNING do
        if on("se_incubate") then
            local s = save()
            if s and type(s.Sakura) == "table" then
                local sak = s.Sakura
                if not sak.Egg or sak.Egg == false then
                    for k, rec in pairs(myEggs()) do
                        if type(rec) == "table" and rec.Placement == nil then inv("SakuraInsert", rec.Uid or k); break end
                    end
                else
                    local deposited = sak.Deposited or 0
                    local bal = s.SakuraCrystals or 0
                    if on("se_autodeposit") and deposited < 1000 and bal > 0 then
                        local amt = math.min(1000 - deposited, bal)
                        if amt > 0 then inv("SakuraDeposit", amt) end
                    elseif on("se_automutate") and deposited >= 1000 then
                        inv("SakuraMutate")
                    end
                end
            end
        end
        task.wait(2)
    end
end)

task.spawn(function()
    while RUNNING do
        if on("se_autofuse") then
            pcall(function()
                local s = save()
                if not s then return end
                if s.FusionEggReward ~= nil or s.FusionLocked == true then
                    inv("FuseFinish"); task.wait(1.2)
                    return
                end
                if s.FusionInfoAcknowledged ~= true then inv("FuseConfirm"); task.wait(0.3) end
                local slots = s.FusionSlots or {}
                local inSlot, loaded = {}, 0
                for _, u in pairs(slots) do loaded = loaded + 1; if type(u) == "string" then inSlot[u] = true end end
                if loaded >= 3 then
                    inv("FuseBegin"); task.wait(0.6)
                    inv("FuseFinish"); task.wait(1.2)
                    return
                end
                if type(s.Inventory) ~= "table" then return end
                local equipped = {}
                for _, u in ipairs(s.EquippedAssets or {}) do equipped[u] = true end
                local g = {}
                for uid, item in pairs(s.Inventory) do
                    if type(item) == "table" and not equipped[uid] and not inSlot[uid]
                        and item.IsFavorite ~= true and item.InFuse ~= true and canFuseCat(item.Category) then
                        g[item.Category] = g[item.Category] or {}
                        table.insert(g[item.Category], uid)
                    end
                end
                local pick
                for _, uids in pairs(g) do if #uids >= 3 then pick = uids; break end end
                if not pick then setStatus("No trio for fusion"); return end
                setStatus("Fusing pets")
                for i = 1, 3 do inv("FuseLoad", pick[i]); task.wait(0.3) end
                task.wait(0.2)
                inv("FuseBegin"); task.wait(0.6)
                inv("FuseFinish"); task.wait(1.2)
            end)
        end
        task.wait(1)
    end
end)

local antiLagConn
local function applyAntiLagOne(o)
    if o:IsA("ParticleEmitter") or o:IsA("Trail") or o:IsA("Beam") then pcall(function() o.Enabled = false end)
    elseif o:IsA("Smoke") or o:IsA("Fire") or o:IsA("Sparkles") then pcall(function() o:Destroy() end)
    elseif o:IsA("PointLight") or o:IsA("SpotLight") or o:IsA("SurfaceLight") then pcall(function() o.Enabled = false end)
    elseif o:IsA("BasePart") then pcall(function() o.Material = Enum.Material.SmoothPlastic end); pcall(function() o.Reflectance = 0 end); pcall(function() o.CastShadow = false end)
    elseif o:IsA("Decal") or o:IsA("Texture") then pcall(function() o.Transparency = 1 end) end
end
local function setAntiLag(state)
    if antiLagConn then antiLagConn:Disconnect(); antiLagConn = nil end
    if not state then return end
    pcall(function() Lighting.GlobalShadows = false end)
    pcall(function() Lighting.FogEnd = 9e9 end)
    pcall(function() Lighting.FogStart = 9e9 end)
    pcall(function() settings().Rendering.QualityLevel = 1 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04 end)
    for _, e in ipairs(Lighting:GetDescendants()) do if e:IsA("PostEffect") or e:IsA("Atmosphere") or e:IsA("Clouds") then pcall(function() e.Enabled = false end) end end
    pcall(function() Workspace.Clouds.Enabled = false end)
    pcall(function() local t = Workspace.Terrain; t.WaterWaveSize = 0; t.WaterWaveSpeed = 0; t.WaterReflectance = 0; t.WaterTransparency = 1; t.Decoration = false end)
    antiLagConn = Workspace.DescendantAdded:Connect(function(o) if RUNNING and on("se_antilag") then applyAntiLagOne(o) end end)
    onClean(function() if antiLagConn then pcall(function() antiLagConn:Disconnect() end) end end)
    task.spawn(function()
        local n = 0
        for _, o in ipairs(Workspace:GetDescendants()) do
            if not on("se_antilag") then break end
            applyAntiLagOne(o); n = n + 1; if n % 500 == 0 then RunService.Heartbeat:Wait() end
        end
    end)
end
RunService.RenderStepped:Connect(function()
    if not RUNNING then return end
    local t = Opt.se_timelock and Opt.se_timelock:GetValue()
    if t and t ~= "Off" then
        local ct = ({ Day = 14, Night = 0, Sunrise = 6.5, Sunset = 18 })[t]
        if ct then pcall(function() Lighting.ClockTime = ct end) end
    end
end)

-- ═══ TAB: Settings ═══
local SettingsTab = Window:AddTab("Settings", "settings")

local ProtCard = SettingsTab:AddCard("Protection", "left")
Toggles.se_antiafk = ProtCard:AddToggle({ Text = "Anti-AFK", Default = true })
Toggles.se_antilag = ProtCard:AddToggle({ Text = "Reduce Lag", Default = false, Callback = function(v) setAntiLag(v) end })
Opt.se_timelock = ProtCard:AddDropdown({ Text = "Lock Time", Values = { "Off", "Day", "Night", "Sunrise", "Sunset" }, Default = "Off" })

local VirtualUser = cloneref(game:GetService("VirtualUser"))
lp.Idled:Connect(function()
    if RUNNING and on("se_antiafk") then pcall(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end) end
end)

local MenuCard = SettingsTab:AddCard("Menu", "right")
MenuCard:AddButton({ Text = "Unload", Callback = function()
    for _, k in ipairs({ "se_selected", "se_bloom", "se_incubate", "se_tpwalk", "se_antikb", "se_esp" }) do
        local t = Toggles[k]; if t then pcall(function() t:SetValue(false) end) end
    end
    pcall(function() if Opt.se_steps then Opt.se_steps:SetValue({}) end end)
    pcall(function() if _G.__CW_CLEAN then _G.__CW_CLEAN() end end)
    pcall(function() Window:Destroy() end)
end })

-- ═══ TAB: Feedback ═══
local FeedbackTab = Window:AddTab("Feedback", "message")

local FBCard = FeedbackTab:AddCard("Feedback / Help", "left")
Opt.FeedbackType = FBCard:AddDropdown({ Text = "Type", Values = { "Suggestion", "Bug", "Help" }, Default = "Suggestion" })
Opt.FeedbackMsg = FBCard:AddInput({ Text = "Message", Placeholder = "Max 500 chars, no links" })
local fbStatus = FBCard:AddLabel("")

local DISCORD_INVITE = "https://discord.gg/pubhub"
local FEEDBACK_URL   = "https://pubhub-ruddy.vercel.app/feedback"
local FEEDBACK_VERSION = "pubhub-v3.0"
local _request = request or (syn and syn.request) or http_request
local function fbTrim(s) return (tostring(s or ""):gsub("^%s*(.-)%s*$", "%1")) end
local function fbHWID()
    local ok, id = pcall(function() return game:GetService("RbxAnalyticsService"):GetClientId() end)
    if ok and type(id) == "string" and id ~= "" then return id end
    return tostring(lp and lp.UserId or 0)
end
local FB_HWID = fbHWID()
local FB_ERRMAP = {
    empty = "Message is empty.", no_links = "Links not allowed.",
    too_long = "Message too long (max 500).",
    rate_limited = "Rate limited. Try later.",
    busy = "Server busy.", banned = "Not allowed.",
    discord_error = "Send failed.", network = "Network error.",
    no_request = "Executor cannot send requests.", bad_response = "Bad response.",
    unreachable = "Cannot connect (TLS). Try another executor.",
}
local function sendFeedback(ftype, msg)
    if not _request then return false, "no_request" end
    local ok, res = pcall(function()
        return _request({
            Url = FEEDBACK_URL, Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                type = ftype, message = msg, hwid = FB_HWID,
                placeId = tostring(game.PlaceId), username = lp and lp.Name or "?",
                version = FEEDBACK_VERSION,
            }),
        })
    end)
    if not ok or not res then return false, "network" end
    if type(res) == "string" then return false, "unreachable" end
    if type(res) ~= "table" then return false, "network" end
    local code = res.StatusCode or res.status_code or res.Status or res.status
    if type(code) == "number" and code ~= 200 and code ~= 201 and code ~= 204 then return false, "http_" .. tostring(code) end
    local body = res.Body or res.body
    if type(body) ~= "string" or body == "" then return false, "bad_response" end
    local dok, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not dok or type(data) ~= "table" then return false, "bad_response" end
    if data.success == true then return true end
    return false, tostring(data.error or "unknown")
end

local FEEDBACK_COOLDOWN, lastFeedback = 20, 0
FBCard:AddButton({ Text = "Send", Callback = function()
    local now = tick()
    if now - lastFeedback < FEEDBACK_COOLDOWN then
        pcall(function() fbStatus:SetText(string.format("Wait %d sec.", math.ceil(FEEDBACK_COOLDOWN - (now - lastFeedback)))) end)
        return
    end
    local ftype = tostring((Opt.FeedbackType and Opt.FeedbackType:GetValue()) or "Suggestion"):lower()
    local msg = fbTrim((Opt.FeedbackMsg and Opt.FeedbackMsg:GetValue()) or "")
    if msg == "" then pcall(function() fbStatus:SetText("Empty message.") end); return end
    if #msg > 500 then pcall(function() fbStatus:SetText("Too long (500 max).") end); return end
    local low = msg:lower()
    if low:find("http", 1, true) or low:find("discord.gg", 1, true) or low:find("www.", 1, true) or low:find(".gg/", 1, true) then
        pcall(function() fbStatus:SetText("No links allowed.") end); return
    end
    pcall(function() fbStatus:SetText("Sending...") end)
    task.spawn(function()
        local sok, err = sendFeedback(ftype, msg)
        if sok then
            lastFeedback = tick()
            pcall(function() fbStatus:SetText("Sent!") end)
            pcall(function() Opt.FeedbackMsg:SetValue("") end)
            notify("Feedback sent!")
        else
            pcall(function() fbStatus:SetText(FB_ERRMAP[err] or ("Failed: " .. tostring(err))) end)
        end
    end)
end })

local HelpCard = FeedbackTab:AddCard("Help / FAQ", "right")
HelpCard:AddButton({ Text = "Join Discord", Callback = function()
    pcall(function() setclipboard(DISCORD_INVITE) end)
    notify("Discord link copied")
end })
HelpCard:AddLabel("Have a suggestion or found a bug?\nChoose type, enter message, press Send.", true)

-- ═══ Gui Tab (interface settings) ═══
UI:BuildGuiTab(Window)

-- Watermark
UI:SetKeyData({ ExpiresAt = os.time() + 12*3600, Hours = 12 })

notify("PubHub v3.0 loaded")
