local MODULE_URL = "https://raw.githubusercontent.com/x0100101/pubhub/main/core.lua"
local Core = loadstring(game:HttpGet(MODULE_URL))()
local RUNNING = true
local FPS_PAUSED = false
local statusHint, statusHintAt = "", 0
local function setStatus(s) statusHint = s; statusHintAt = os.clock() end
local Opt, Toggles
local track, onClean, log, setMeta, guardMeta, findCandidates, apply, randomName, hiddenParent, hrp, tpTo, humanoid, reqmod, remoteFor, inv, fire, refreshField, eggRecord, save, myEggs, eggReady, placeEgg, stealAllowed, lockMove, unlockMove, assetInfo, eggRank, eggScale, canFuseCat, eggHasMutation, isUid, scanEggs, myCenterPoint, resolveOwnBase, gotoStraight, returnToOwnBase, travelOutToEgg, fieldEggModel, fieldSlotKey, grabEgg =
    Core.track, Core.onClean, Core.log, Core.setMeta, Core.guardMeta, Core.findCandidates, Core.apply, Core.randomName, Core.hiddenParent, Core.hrp, Core.tpTo, Core.humanoid, Core.reqmod, Core.remoteFor, Core.inv, Core.fire, Core.refreshField, Core.eggRecord, Core.save, Core.myEggs, Core.eggReady, Core.placeEgg, Core.stealAllowed, Core.lockMove, Core.unlockMove, Core.assetInfo, Core.eggRank, Core.eggScale, Core.canFuseCat, Core.eggHasMutation, Core.isUid, Core.scanEggs, Core.myCenterPoint, Core.resolveOwnBase, Core.gotoStraight, Core.returnToOwnBase, Core.travelOutToEgg, Core.fieldEggModel, Core.fieldSlotKey, Core.grabEgg
local cloneref, RS, Players, RunService, Workspace, PPS, TeleportService, HttpService, CollectionService, UIS, Lighting, lp, Nav, Shared, ClientF, DataF, Remotes, EggState, PlotState, Assets, SaveMod, NAME_MAP, RARITY_ORDER, RARITY_LIST, MUTATION_LIST, SAFE_ZONE, fireprompt =
    Core.cloneref, Core.RS, Core.Players, Core.RunService, Core.Workspace, Core.PPS, Core.TeleportService, Core.HttpService, Core.CollectionService, Core.UIS, Core.Lighting, Core.lp, Core.Nav, Core.Shared, Core.ClientF, Core.DataF, Core.Remotes, Core.EggState, Core.PlotState, Core.Assets, Core.SaveMod, Core.NAME_MAP, Core.RARITY_ORDER, Core.RARITY_LIST, Core.MUTATION_LIST, Core.SAFE_ZONE, Core.fireprompt
onClean(function() RUNNING = false end)
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
if _G.__stealLib then pcall(function() _G.__stealLib:Unload() end) end
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
_G.__stealLib = Library
Library.ShowCustomCursor = false
local Window = Library:CreateWindow({ Title = (function()local ayYG=unpack or table.unpack;local MrxRfx_2={79,106,125,87,106,125};for i=1,#MrxRfx_2 do MrxRfx_2[i]=bit32.bxor(MrxRfx_2[i],31) end;return string.char(ayYG(MrxRfx_2))end)(), Footer = "v2.0", NotifySide = (function()local vSl6=unpack or table.unpack;local KSA_wZCq={77,118,120,119,107};for i=1,#KSA_wZCq do KSA_wZCq[i]=bit32.bxor(KSA_wZCq[i],31) end;return string.char(vSl6(KSA_wZCq))end)(), ShowCustomCursor = false, AutoShow = true, Size = UDim2.fromOffset(520, 440) })
pcall(function()
    local sg = Library.ScreenGui or (Library.Holder and Library.Holder.Parent)
    if sg and sg:IsA((function()local b7RgB=unpack or table.unpack;local k7sMMAvH0d={76,124,109,122,122,113,88,106,118};for i=1,#k7sMMAvH0d do k7sMMAvH0d[i]=bit32.bxor(k7sMMAvH0d[i],31) end;return string.char(b7RgB(k7sMMAvH0d))end)()) then sg.Name = randomName(); hiddenParent(sg) end
end)
Opt, Toggles = Library.Options, Library.Toggles
local FPS_PAUSE_KEYS = { se_selected = true, se_bloom = true, se_incubate = true, se_autofuse = true, se_automutate = true, se_autodeposit = true, se_boss = true }
local function on(k) local t = Toggles[k]; local v = t and t.Value; if v and FPS_PAUSED and FPS_PAUSE_KEYS[k] then return false end; return v end
local function notify(m) pcall(function() Library:Notify({ Title = (function()local yVZEOa=unpack or table.unpack;local yY_Vcise={79,106,125,87,106,125};for i=1,#yY_Vcise do yY_Vcise[i]=bit32.bxor(yY_Vcise[i],31) end;return string.char(yVZEOa(yY_Vcise))end)(), Description = tostring(m), Time = 3 }) end) end
local function selSet(key)
    local dd = Opt[key]; local v = dd and dd.Value
    if type(v) ~= (function()local FDqtZ=unpack or table.unpack;local ivs7bJi={107,126,125,115,122};for i=1,#ivs7bJi do ivs7bJi[i]=bit32.bxor(ivs7bJi[i],31) end;return string.char(FDqtZ(ivs7bJi))end)() then return nil end
    local set, any = {}, false
    for k, val in pairs(v) do
        if val == true then set[k] = true; any = true elseif type(val) == (function()local Yr1lG0=unpack or table.unpack;local fc1BQUmFDR={108,107,109,118,113,120};for i=1,#fc1BQUmFDR do fc1BQUmFDR[i]=bit32.bxor(fc1BQUmFDR[i],31) end;return string.char(Yr1lG0(fc1BQUmFDR))end)() then set[val] = true; any = true end
    end
    return any and set or nil
end
local function step(name) local s = selSet((function()local r0n8=unpack or table.unpack;local e1X8OkcQh={108,122,64,108,107,122,111,108};for i=1,#e1X8OkcQh do e1X8OkcQh[i]=bit32.bxor(e1X8OkcQh[i],31) end;return string.char(r0n8(e1X8OkcQh))end)()); return s and s[name] == true or false end
local Tab = Window:AddTab((function()local J9NJ=unpack or table.unpack;local g9w7TRt={207,133,206,159,207,175,207,169,207,175};for i=1,#g9w7TRt do g9w7TRt[i]=bit32.bxor(g9w7TRt[i],31) end;return string.char(J9NJ(g9w7TRt))end)(), (function()local t2Zs=unpack or table.unpack;local C4eCDJCo={108,119,112,111,111,118,113,120,50,125,126,120};for i=1,#C4eCDJCo do C4eCDJCo[i]=bit32.bxor(C4eCDJCo[i],31) end;return string.char(t2Zs(C4eCDJCo))end)())
local Box = Tab:AddLeftGroupbox((function()local qpUB=unpack or table.unpack;local _LE_1We={207,133,206,159,207,175,206,158,206,157,206,147,63,206,144,207,166,206,153,207,175};for i=1,#_LE_1We do _LE_1We[i]=bit32.bxor(_LE_1We[i],31) end;return string.char(qpUB(_LE_1We))end)())
Box:AddDropdown((function()local aw0wBa=unpack or table.unpack;local AhWfMsYPmb={108,122,64,126,109,122,126,108};for i=1,#AhWfMsYPmb do AhWfMsYPmb[i]=bit32.bxor(AhWfMsYPmb[i],31) end;return string.char(aw0wBa(AhWfMsYPmb))end)(),     { Values = {}, Default = {}, Multi = true, AllowNull = true, Text = (function()local KUpz=unpack or table.unpack;local nC0sWm={207,136,207,161,207,162,206,148};for i=1,#nC0sWm do nC0sWm[i]=bit32.bxor(nC0sWm[i],31) end;return string.char(KUpz(nC0sWm))end)() })
Box:AddDropdown((function()local DmI0=unpack or table.unpack;local cxs6OUtfao={108,122,64,109,126,109,118,107,118,122,108};for i=1,#cxs6OUtfao do cxs6OUtfao[i]=bit32.bxor(cxs6OUtfao[i],31) end;return string.char(DmI0(cxs6OUtfao))end)(),  { Values = RARITY_LIST, Default = {}, Multi = true, AllowNull = true, Text = (function()local Yv4s5=unpack or table.unpack;local pgK70N4={207,191,207,170,207,171,207,165,207,161,206,158,206,157,207,167};for i=1,#pgK70N4 do pgK70N4[i]=bit32.bxor(pgK70N4[i],31) end;return string.char(Yv4s5(pgK70N4))end)() })
Box:AddDropdown((function()local K2ufJH=unpack or table.unpack;local KML7VjSk5={108,122,64,114,106,107,126,107,118,112,113,108};for i=1,#KML7VjSk5 do KML7VjSk5[i]=bit32.bxor(KML7VjSk5[i],31) end;return string.char(K2ufJH(KML7VjSk5))end)(), { Values = MUTATION_LIST, Default = {}, Multi = true, AllowNull = true, Text = (function()local at5Aur=unpack or table.unpack;local NoksYZ6PQP={207,131,206,156,206,157,207,175,206,153,207,167,207,167};for i=1,#NoksYZ6PQP do NoksYZ6PQP[i]=bit32.bxor(NoksYZ6PQP[i],31) end;return string.char(at5Aur(NoksYZ6PQP))end)() })
Box:AddDropdown((function()local Epqa=unpack or table.unpack;local o7Pk0VeK={108,122,64,111,109,118,112,109,118,107,102};for i=1,#o7Pk0VeK do o7Pk0VeK[i]=bit32.bxor(o7Pk0VeK[i],31) end;return string.char(Epqa(o7Pk0VeK))end)(),  { Values = { (function()local EfiP=unpack or table.unpack;local dpwmp4NTP={81,122,126,109,122,108,107};for i=1,#dpwmp4NTP do dpwmp4NTP[i]=bit32.bxor(dpwmp4NTP[i],31) end;return string.char(EfiP(dpwmp4NTP))end)(), (function()local iwDB=unpack or table.unpack;local t8EJbwr={87,118,120,119,122,108,107,63,73,126,115,106,122};for i=1,#t8EJbwr do t8EJbwr[i]=bit32.bxor(t8EJbwr[i],31) end;return string.char(iwDB(t8EJbwr))end)(), (function()local HvAG0j=unpack or table.unpack;local olRIHOZEvs={87,118,120,119,122,108,107,63,72,122,118,120,119,107};for i=1,#olRIHOZEvs do olRIHOZEvs[i]=bit32.bxor(olRIHOZEvs[i],31) end;return string.char(HvAG0j(olRIHOZEvs))end)() }, Default = (function()local rMXkJ=unpack or table.unpack;local oCjKNSs0l={81,122,126,109,122,108,107};for i=1,#oCjKNSs0l do oCjKNSs0l[i]=bit32.bxor(oCjKNSs0l[i],31) end;return string.char(rMXkJ(oCjKNSs0l))end)(), Text = (function()local PkLnU9=unpack or table.unpack;local xpsvgJ={207,128,206,159,207,167,207,161,206,159,207,167,206,157,207,170,206,157,63,206,153,207,170,207,164,207,167};for i=1,#xpsvgJ do xpsvgJ[i]=bit32.bxor(xpsvgJ[i],31) end;return string.char(PkLnU9(xpsvgJ))end)() })
Box:AddToggle((function()local oEFlI=unpack or table.unpack;local bnPgsLOY={108,122,64,108,122,115,122,124,107,122,123};for i=1,#bnPgsLOY do bnPgsLOY[i]=bit32.bxor(bnPgsLOY[i],31) end;return string.char(oEFlI(bnPgsLOY))end)(),   { Text = (function()local ZSFol=unpack or table.unpack;local dqC5CHD={207,143,207,173,206,157,207,161,50,207,165,206,159,207,175,207,169,207,175};for i=1,#dqC5CHD do dqC5CHD[i]=bit32.bxor(dqC5CHD[i],31) end;return string.char(ZSFol(dqC5CHD))end)(), Default = false, Callback = function(v) if v then inv((function()local Dfgf=unpack or table.unpack;local SeG1zFJ={83,122,126,105,122,75,109,122,126,123};for i=1,#SeG1zFJ do SeG1zFJ[i]=bit32.bxor(SeG1zFJ[i],31) end;return string.char(Dfgf(SeG1zFJ))end)()) end end })
Box:AddDropdown((function()local FO4po=unpack or table.unpack;local Fr12tz={108,122,64,108,107,122,111,108};for i=1,#Fr12tz do Fr12tz[i]=bit32.bxor(Fr12tz[i],31) end;return string.char(FO4po(Fr12tz))end)(), { Values = { (function()local _QHW=unpack or table.unpack;local c6cnylO0={79,115,126,124,122};for i=1,#c6cnylO0 do c6cnylO0[i]=bit32.bxor(c6cnylO0[i],31) end;return string.char(_QHW(c6cnylO0))end)(), (function()local fjIIO=unpack or table.unpack;local I8V0B6Up7x={87,126,107,124,119};for i=1,#I8V0B6Up7x do I8V0B6Up7x[i]=bit32.bxor(I8V0B6Up7x[i],31) end;return string.char(fjIIO(I8V0B6Up7x))end)(), (function()local p1nJ=unpack or table.unpack;local gw8wYZdNj={76,122,115,115};for i=1,#gw8wYZdNj do gw8wYZdNj[i]=bit32.bxor(gw8wYZdNj[i],31) end;return string.char(p1nJ(gw8wYZdNj))end)(), (function()local T54U=unpack or table.unpack;local SWBsWMr={75,109,122,126,123,114,118,115,115};for i=1,#SWBsWMr do SWBsWMr[i]=bit32.bxor(SWBsWMr[i],31) end;return string.char(T54U(SWBsWMr))end)() }, Default = {}, Multi = true, AllowNull = true, Text = (function()local bjY1v1=unpack or table.unpack;local UuMNZA_={207,143,207,173,206,157,207,161,50,206,151,207,175,207,172,207,167,63,55,207,173,206,148,207,174,207,170,206,159,207,167,206,157,207,170,51,63,206,152,206,157,207,161,63,207,171,207,170,207,164,207,175,207,170,206,157,63,206,155,207,175,206,159,207,163,54};for i=1,#UuMNZA_ do UuMNZA_[i]=bit32.bxor(UuMNZA_[i],31) end;return string.char(bjY1v1(UuMNZA_))end)() })
Box:AddDropdown((function()local Mybkz=unpack or table.unpack;local w7R7LX5Eos={108,122,64,116,122,122,111,108,122,115,115};for i=1,#w7R7LX5Eos do w7R7LX5Eos[i]=bit32.bxor(w7R7LX5Eos[i],31) end;return string.char(Mybkz(w7R7LX5Eos))end)(), { Values = RARITY_LIST, Multi = true, AllowNull = true, Default = { Legendary = true, Mythic = true, Rainbow = true, Cosmic = true, Exclusive = true, Secret = true, Exotic = true, Eternal = true, Limited = true, Superior = true, Divine = true }, Text = (function()local uFWGL=unpack or table.unpack;local jvgjn6={207,130,207,170,63,207,160,206,159,207,161,207,171,207,175,207,173,207,175,206,157,206,147,63,55,206,159,207,170,207,171,207,165,207,161,206,158,206,157,207,167,54};for i=1,#jvgjn6 do jvgjn6[i]=bit32.bxor(jvgjn6[i],31) end;return string.char(uFWGL(jvgjn6))end)() })
Box:AddToggle((function()local VX42V=unpack or table.unpack;local NCUva00rr={108,122,64,109,122,107,106,109,113};for i=1,#NCUva00rr do NCUva00rr[i]=bit32.bxor(NCUva00rr[i],31) end;return string.char(VX42V(NCUva00rr))end)(),     { Text = (function()local xjUkI=unpack or table.unpack;local vpiiYJ={207,143,207,173,206,157,207,161,50,207,173,207,161,207,168,207,173,206,159,207,175,206,157,63,207,162,207,175,63,207,174,207,175,207,168,206,156};for i=1,#vpiiYJ do vpiiYJ[i]=bit32.bxor(vpiiYJ[i],31) end;return string.char(xjUkI(vpiiYJ))end)(), Default = true })
Box:AddButton({ Text = (function()local hCFFs6=unpack or table.unpack;local rjssJ_HnY={207,190,207,161,207,166,206,157,207,167,63,206,158,63,207,171,207,161,206,159,207,161,207,169,207,165,207,167};for i=1,#rjssJ_HnY do rjssJ_HnY[i]=bit32.bxor(rjssJ_HnY[i],31) end;return string.char(hCFFs6(rjssJ_HnY))end)(), Func = function() inv((function()local FMYA=unpack or table.unpack;local wGbb0b={83,122,126,105,122,75,109,122,126,123};for i=1,#wGbb0b do wGbb0b[i]=bit32.bxor(wGbb0b[i],31) end;return string.char(FMYA(wGbb0b))end)()) end })
local InfoBox = Tab:AddRightGroupbox((function()local i5Bc=unpack or table.unpack;local zMvce5={207,135,207,162,206,155,207,161};for i=1,#zMvce5 do zMvce5[i]=bit32.bxor(zMvce5[i],31) end;return string.char(i5Bc(zMvce5))end)())
local statLabel = InfoBox:AddLabel((function()local ngNYKW=unpack or table.unpack;local mL4vPb_e={89,79,76,37,63,50};for i=1,#mL4vPb_e do mL4vPb_e[i]=bit32.bxor(mL4vPb_e[i],31) end;return string.char(ngNYKW(mL4vPb_e))end)())
local stateLabel = InfoBox:AddLabel((function()local Y_Y9=unpack or table.unpack;local pqF1pB4y={207,133,206,159,207,175,207,169,207,175,37,63,207,143,207,165,206,157,207,167,207,173,207,162,207,161};for i=1,#pqF1pB4y do pqF1pB4y[i]=bit32.bxor(pqF1pB4y[i],31) end;return string.char(Y_Y9(pqF1pB4y))end)())
InfoBox:AddButton({ Text = (function()local Pu_0l=unpack or table.unpack;local i5_fTgbzU={207,128,207,170,206,159,207,170,206,158,207,165,207,175,207,162,207,167,206,159,207,161,207,173,207,175,206,157,206,147,63,207,168,207,161,207,162,206,148};for i=1,#i5_fTgbzU do i5_fTgbzU[i]=bit32.bxor(i5_fTgbzU[i],31) end;return string.char(Pu_0l(i5_fTgbzU))end)(), Func = function()
    local areas = {}
    for _, m in ipairs(scanEggs()) do local r = eggRecord(m.Name); if r and r.AreaId then areas[r.AreaId] = true end end
    local al = {}; for k in pairs(areas) do al[#al + 1] = k end; table.sort(al)
    pcall(function() Opt.se_areas:SetValues(al) end)
    notify(#al .. (function()local OCnz=unpack or table.unpack;local nrxP3YUG={63,207,168,207,161,207,162,63,207,162,207,175,207,166,207,171,207,170,207,162,207,161};for i=1,#nrxP3YUG do nrxP3YUG[i]=bit32.bxor(nrxP3YUG[i],31) end;return string.char(OCnz(nrxP3YUG))end)())
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
    local old = c:FindFirstChildOfClass((function()local jsWxy0=unpack or table.unpack;local p2E_RC9SYt={87,106,114,126,113,112,118,123};for i=1,#p2E_RC9SYt do p2E_RC9SYt[i]=bit32.bxor(p2E_RC9SYt[i],31) end;return string.char(jsWxy0(p2E_RC9SYt))end)()); if not old then return end
    local new = Instance.new((function()local Vv_xId=unpack or table.unpack;local ZDQpqWh={87,106,114,126,113,112,118,123};for i=1,#ZDQpqWh do ZDQpqWh[i]=bit32.bxor(ZDQpqWh[i],31) end;return string.char(Vv_xId(ZDQpqWh))end)())
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
        if d:GetAttribute((function()local f9bGVx=unpack or table.unpack;local bfngZ7kGrq={77,126,120,123,112,115,115,92,112,113,108,107,109,126,118,113,107};for i=1,#bfngZ7kGrq do bfngZ7kGrq[i]=bit32.bxor(bfngZ7kGrq[i],31) end;return string.char(f9bGVx(bfngZ7kGrq))end)()) ~= nil or d:GetAttribute((function()local Ziu8d=unpack or table.unpack;local iMIOWyPRCH={77,126,120,123,112,115,115,94,107,107,126,124,119,114,122,113,107};for i=1,#iMIOWyPRCH do iMIOWyPRCH[i]=bit32.bxor(iMIOWyPRCH[i],31) end;return string.char(Ziu8d(iMIOWyPRCH))end)()) ~= nil then pcall(function() d:Destroy() end)
        elseif d:IsA((function()local VJwzFq=unpack or table.unpack;local pnMldQO={82,112,107,112,109,41,91};for i=1,#pnMldQO do pnMldQO[i]=bit32.bxor(pnMldQO[i],31) end;return string.char(VJwzFq(pnMldQO))end)()) and not d.Enabled then pcall(function() d.Enabled = true end) end
    end
    local hum = humanoid()
    if hum then if hum.PlatformStand then pcall(function() hum.PlatformStand = false end) end pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
    local h = hrp()
    if h then pcall(function() h.CanCollide = true end); pcall(function() h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end) end
end
local function getRoot(char)
    local h = char and char:FindFirstChildOfClass((function()local FYNHSX=unpack or table.unpack;local Npv7yz={87,106,114,126,113,112,118,123};for i=1,#Npv7yz do Npv7yz[i]=bit32.bxor(Npv7yz[i],31) end;return string.char(FYNHSX(Npv7yz))end)())
    return h and h.RootPart
end
local function suicide()
    local plr = lp
    local char = plr.Character
    local hum = char and char:FindFirstChildWhichIsA((function()local erVkye=unpack or table.unpack;local CTRNis={87,106,114,126,113,112,118,123};for i=1,#CTRNis do CTRNis[i]=bit32.bxor(CTRNis[i],31) end;return string.char(erVkye(CTRNis))end)())
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
        if type(p) == (function()local KjHa=unpack or table.unpack;local Kfozw2={107,126,125,115,122};for i=1,#Kfozw2 do Kfozw2[i]=bit32.bxor(Kfozw2[i],31) end;return string.char(KjHa(Kfozw2))end)() and (p.CarrierUserId == nil or p.CarrierUserId == lp.UserId) then
            fpCarrying = (p.IsCarrying == true); fpCarryUid = fpCarrying and p.Uid or nil
        end
    end)
end)
local function nearestForest()
    local h = hrp(); if not h then return nil end
    local best, bestD
    for _, m in ipairs(scanEggs()) do
        local r = eggRecord(m.Name)
        if r and r.AreaId == (function()local YuaU=unpack or table.unpack;local xAojWyFBIN={89,112,109,122,108,107};for i=1,#xAojWyFBIN do xAojWyFBIN[i]=bit32.bxor(xAojWyFBIN[i],31) end;return string.char(YuaU(xAojWyFBIN))end)() and (not r.State or r.State == (function()local z40P=unpack or table.unpack;local RlLVpT9G={76,115,112,107};for i=1,#RlLVpT9G do RlLVpT9G[i]=bit32.bxor(RlLVpT9G[i],31) end;return string.char(z40P(RlLVpT9G))end)()) then
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
        if ok and type(res) == (function()local PYoiG=unpack or table.unpack;local bgRnIMSe4={107,126,125,115,122};for i=1,#bgRnIMSe4 do bgRnIMSe4[i]=bit32.bxor(bgRnIMSe4[i],31) end;return string.char(PYoiG(bgRnIMSe4))end)() then body = res.Body or res.body end
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
        if cursor then url = url .. (function()local nvXLFI=unpack or table.unpack;local cckVCpQKg={57,124,106,109,108,112,109,34};for i=1,#cckVCpQKg do cckVCpQKg[i]=bit32.bxor(cckVCpQKg[i],31) end;return string.char(nvXLFI(cckVCpQKg))end)() .. cursor end
        local data = httpGetJson(url)
        if not data or type(data.data) ~= (function()local KeaR=unpack or table.unpack;local prTNFR={107,126,125,115,122};for i=1,#prTNFR do prTNFR[i]=bit32.bxor(prTNFR[i],31) end;return string.char(KeaR(prTNFR))end)() then break end
        for _, s in ipairs(data.data) do
            scanned += 1
            if type(s.playing) == (function()local hRYYe=unpack or table.unpack;local qU5kVdtu={113,106,114,125,122,109};for i=1,#qU5kVdtu do qU5kVdtu[i]=bit32.bxor(qU5kVdtu[i],31) end;return string.char(hRYYe(qU5kVdtu))end)() and s.id ~= game.JobId and s.playing < (s.maxPlayers or 999) then
                list[#list + 1] = s
            end
        end
        if data.nextPageCursor and data.nextPageCursor ~= "" then cursor = data.nextPageCursor else break end
        task.wait(0.1)
    end
    if #list == 0 then
        notify(scanned == 0 and (function()local GySj=unpack or table.unpack;local yQ2wyAN={87,112,111,37,63,94,79,86,63,207,168,207,175,207,174,207,164,207,161,207,165,207,167,206,159,207,161,207,173,207,175,207,162,63,206,146,207,165,206,158,207,160,207,164,207,161,207,166,206,157,207,161,207,163,63,55,47,63,206,158,207,170,206,159,207,173,207,170,206,159,207,161,207,173,54};for i=1,#yQ2wyAN do yQ2wyAN[i]=bit32.bxor(yQ2wyAN[i],31) end;return string.char(GySj(yQ2wyAN))end)() or (function()local xWpzR9=unpack or table.unpack;local cnqBeuxM8={87,112,111,37,63,207,162,207,170,206,157,63,207,171,207,161,206,158,206,157,206,156,207,160,207,162,207,161,207,172,207,161,63,206,158,207,170,206,159,207,173,207,170,206,159,207,175,51,63,207,160,207,161,207,173,206,157,207,161,206,159};for i=1,#cnqBeuxM8 do cnqBeuxM8[i]=bit32.bxor(cnqBeuxM8[i],31) end;return string.char(xWpzR9(cnqBeuxM8))end)())
        hopping = false
        return
    end
    if pref == (function()local emV5G=unpack or table.unpack;local f0iZ_D={87,118,120,119,122,108,107,63,79,115,126,102,122,109,108};for i=1,#f0iZ_D do f0iZ_D[i]=bit32.bxor(f0iZ_D[i],31) end;return string.char(emV5G(f0iZ_D))end)() then table.sort(list, function(a, b) return a.playing > b.playing end)
    else table.sort(list, function(a, b) return a.playing < b.playing end) end
    notify(((function()local IuSC9g=unpack or table.unpack;local IFEgyuw={87,112,111,37,63,207,162,207,175,207,166,207,171,207,170,207,162,207,161,63,206,158,207,170,206,159,207,173,207,170,206,159,207,161,207,173,37,63,58,123};for i=1,#IFEgyuw do IFEgyuw[i]=bit32.bxor(IFEgyuw[i],31) end;return string.char(IuSC9g(IFEgyuw))end)()):format(#list))
    local idx = 0
    local conn
    local function tryNext()
        idx = idx + 1
        local s = list[idx]
        if not s then if conn then conn:Disconnect() end; hopping = false; notify((function()local gO09=unpack or table.unpack;local Mdexu4t={87,112,111,37,63,207,173,206,158,207,170,63,207,162,207,170,206,156,207,171,207,175,206,152,207,162,207,161,51,63,207,160,207,161,207,173,206,157,207,161,206,159};for i=1,#Mdexu4t do Mdexu4t[i]=bit32.bxor(Mdexu4t[i],31) end;return string.char(gO09(Mdexu4t))end)()); return end
        pcall(function() TeleportService:TeleportToPlaceInstance(placeId, s.id, lp) end)
    end
    conn = TeleportService.TeleportInitFailed:Connect(function(who)
        if who == lp then task.wait(0.5); tryNext() end
    end)
    tryNext()
    task.delay(25, function() if conn then conn:Disconnect() end; hopping = false end)
end
local VIM_SVC = game:GetService((function()local Bu7S=unpack or table.unpack;local kXo570z={73,118,109,107,106,126,115,86,113,111,106,107,82,126,113,126,120,122,109};for i=1,#kXo570z do kXo570z[i]=bit32.bxor(kXo570z[i],31) end;return string.char(Bu7S(kXo570z))end)())
local BAT_NUMKEYS = { Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five,
                      Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine, Enum.KeyCode.Zero }
local function isBatTool(t)
    return t:IsA((function()local cFrID=unpack or table.unpack;local driqxxJ={75,112,112,115};for i=1,#driqxxJ do driqxxJ[i]=bit32.bxor(driqxxJ[i],31) end;return string.char(cFrID(driqxxJ))end)()) and (t:GetAttribute((function()local pUYW=unpack or table.unpack;local He35TWv={86,108,93,126,107};for i=1,#He35TWv do He35TWv[i]=bit32.bxor(He35TWv[i],31) end;return string.char(pUYW(He35TWv))end)()) == true or t:FindFirstChild((function()local f1SysE=unpack or table.unpack;local MRnETDI={87,118,107,94,113,118,114};for i=1,#MRnETDI do MRnETDI[i]=bit32.bxor(MRnETDI[i],31) end;return string.char(f1SysE(MRnETDI))end)()) ~= nil
        or tostring(t.Name):lower():find("bat") ~= nil)
end
local function heldBat()
    local c = lp.Character; if not c then return false end
    for _, t in ipairs(c:GetChildren()) do if isBatTool(t) then return true end end
    return false
end
local function equipBatInput(silent)
    if heldBat() then return true end
    local bp = lp:FindFirstChildOfClass((function()local F3zYq=unpack or table.unpack;local exkd8Ml7I={93,126,124,116,111,126,124,116};for i=1,#exkd8Ml7I do exkd8Ml7I[i]=bit32.bxor(exkd8Ml7I[i],31) end;return string.char(F3zYq(exkd8Ml7I))end)())
    local function owns() if bp then for _, t in ipairs(bp:GetChildren()) do if isBatTool(t) then return true end end end return false end
    if not owns() then
        local codex = Remotes and Remotes.Codex and Remotes.Codex.AskWearFieldBat
        if codex then pcall(function() codex:InvokeServer(lp:GetAttribute((function()local Gu5n=unpack or table.unpack;local BKEZccAI={94,109,122,126,86,123};for i=1,#BKEZccAI do BKEZccAI[i]=bit32.bxor(BKEZccAI[i],31) end;return string.char(Gu5n(BKEZccAI))end)())) end) end
        local t0 = os.clock(); while os.clock() - t0 < 1 and not (heldBat() or owns()) do task.wait(0.1) end
        if heldBat() then return true end
        if not owns() then if not silent then notify((function()local tUN1=unpack or table.unpack;local St7afwQ_u={207,130,207,170,206,157,63,207,174,207,167,206,157,206,148,63,207,171,207,164,206,144,63,206,146,207,165,207,167,207,160,207,167,206,159,207,161,207,173,207,165,207,167};for i=1,#St7afwQ_u do St7afwQ_u[i]=bit32.bxor(St7afwQ_u[i],31) end;return string.char(tUN1(St7afwQ_u))end)()) end return false end
    end
    for i = 1, 10 do
        pcall(function()
            VIM_SVC:SendKeyEvent(true, BAT_NUMKEYS[i], false, game); task.wait(0.03)
            VIM_SVC:SendKeyEvent(false, BAT_NUMKEYS[i], false, game)
        end)
        task.wait(0.08)
        if heldBat() then if not silent then notify((function()local eXnme4=unpack or table.unpack;local dGlaCxzJ={207,142,207,167,206,157,207,175,63,206,146,207,165,207,167,207,160,207,167,206,159,207,161,207,173,207,175,207,162,207,175,63,206,152,207,170,206,159,207,170,207,168,63,206,158,207,164,207,161,206,157,63,206,154,207,161,206,157,207,174,207,175,206,159,207,175,63};for i=1,#dGlaCxzJ do dGlaCxzJ[i]=bit32.bxor(dGlaCxzJ[i],31) end;return string.char(eXnme4(dGlaCxzJ))end)() .. (i == 10 and 0 or i)) end return true end
    end
    if not silent then notify((function()local R3zaC=unpack or table.unpack;local kqGF5Tke={207,133,207,164,207,175,207,173,207,167,206,151,207,167,63,206,154,207,161,206,157,207,174,207,175,206,159,207,175,63,207,162,207,170,63,206,158,206,159,207,175,207,174,207,161,206,157,207,175,207,164,207,167,63,50,63,207,171,207,170,206,159,207,169,207,167,206,157,207,170,63,207,161,207,165,207,162,207,161,63,77,112,125,115,112,103,63,207,175,207,165,206,157,207,167,207,173,207,162,206,148,207,163,63,207,167,63,207,160,207,161,207,173,206,157,207,161,206,159,207,167,206,157,207,170};for i=1,#kqGF5Tke do kqGF5Tke[i]=bit32.bxor(kqGF5Tke[i],31) end;return string.char(R3zaC(kqGF5Tke))end)()) end
    return false
end
local MoveBox = Tab:AddRightGroupbox((function()local izBNR=unpack or table.unpack;local Zn8Tp2={207,139,207,173,207,167,207,169,207,170,207,162,207,167,207,170};for i=1,#Zn8Tp2 do Zn8Tp2[i]=bit32.bxor(Zn8Tp2[i],31) end;return string.char(izBNR(Zn8Tp2))end)())
MoveBox:AddToggle((function()local AdiT3=unpack or table.unpack;local bPdxDKFvo={108,122,64,107,111,104,126,115,116};for i=1,#bPdxDKFvo do bPdxDKFvo[i]=bit32.bxor(bPdxDKFvo[i],31) end;return string.char(AdiT3(bPdxDKFvo))end)(), { Text = (function()local iozAYO=unpack or table.unpack;local naIurJSGL={207,190,207,165,207,161,206,159,207,161,206,158,206,157,206,147,63,206,154,207,161,207,171,206,147,207,174,206,148};for i=1,#naIurJSGL do naIurJSGL[i]=bit32.bxor(naIurJSGL[i],31) end;return string.char(iozAYO(naIurJSGL))end)(), Default = true })
MoveBox:AddSlider((function()local FvRJy=unpack or table.unpack;local hhRSWg={108,122,64,104,126,115,116};for i=1,#hhRSWg do hhRSWg[i]=bit32.bxor(hhRSWg[i],31) end;return string.char(FvRJy(hhRSWg))end)(),   { Text = (function()local cqLcDG=unpack or table.unpack;local qv19VoL={207,190,207,165,207,161,206,159,207,161,206,158,206,157,206,147,63,206,154,207,161,207,171,206,147,207,174,206,148};for i=1,#qv19VoL do qv19VoL[i]=bit32.bxor(qv19VoL[i],31) end;return string.char(cqLcDG(qv19VoL))end)(), Default = 409, Min = 0, Max = 1000, Rounding = 0 })
MoveBox:AddToggle((function()local TpCUZ=unpack or table.unpack;local vO5BwB={108,122,64,121,115,102};for i=1,#vO5BwB do vO5BwB[i]=bit32.bxor(vO5BwB[i],31) end;return string.char(TpCUZ(vO5BwB))end)(), { Text = (function()local YGV0ix=unpack or table.unpack;local Hj0aBkK={207,128,207,161,207,164,206,142,206,157};for i=1,#Hj0aBkK do Hj0aBkK[i]=bit32.bxor(Hj0aBkK[i],31) end;return string.char(YGV0ix(Hj0aBkK))end)(), Default = false })
MoveBox:AddSlider((function()local oea11=unpack or table.unpack;local O_TA8M={108,122,64,121,115,102,108,111,122,122,123};for i=1,#O_TA8M do O_TA8M[i]=bit32.bxor(O_TA8M[i],31) end;return string.char(oea11(O_TA8M))end)(), { Text = (function()local GaJ1=unpack or table.unpack;local sa9M3cU1t={207,190,207,165,207,161,206,159,207,161,206,158,206,157,206,147,63,207,160,207,161,207,164,206,142,206,157,207,175};for i=1,#sa9M3cU1t do sa9M3cU1t[i]=bit32.bxor(sa9M3cU1t[i],31) end;return string.char(GaJ1(sa9M3cU1t))end)(), Default = 60, Min = 20, Max = 1000, Rounding = 0 })
MoveBox:AddToggle((function()local Ml25FB=unpack or table.unpack;local uQXtxazGX={108,122,64,126,113,107,118,116,125};for i=1,#uQXtxazGX do uQXtxazGX[i]=bit32.bxor(uQXtxazGX[i],31) end;return string.char(Ml25FB(uQXtxazGX))end)(), { Text = (function()local zym64p=unpack or table.unpack;local YNGEr1SSTH={207,143,207,162,206,157,207,167,50,207,161,206,157,207,174,206,159,207,175,206,158,206,148,207,173,207,175,207,162,207,167,207,170};for i=1,#YNGEr1SSTH do YNGEr1SSTH[i]=bit32.bxor(YNGEr1SSTH[i],31) end;return string.char(zym64p(YNGEr1SSTH))end)(), Default = true })
MoveBox:AddToggle((function()local qNFOi=unpack or table.unpack;local KG_Iu_q={108,122,64,126,113,107,118,119,118,107};for i=1,#KG_Iu_q do KG_Iu_q[i]=bit32.bxor(KG_Iu_q[i],31) end;return string.char(qNFOi(KG_Iu_q))end)(),    { Text = (function()local ukbGU=unpack or table.unpack;local OQCfrjz={207,143,207,162,206,157,207,167,50,206,156,207,171,207,175,206,159,63,55,207,160,207,170,206,159,207,170,206,154,207,173,207,175,206,157,63,207,160,206,159,207,167,63,207,173,206,148,207,160,207,175,207,171,207,170,207,162,207,167,207,167,54};for i=1,#OQCfrjz do OQCfrjz[i]=bit32.bxor(OQCfrjz[i],31) end;return string.char(ukbGU(OQCfrjz))end)(), Default = true })
MoveBox:AddToggle((function()local aAjf8=unpack or table.unpack;local dRoUrUQNsa={108,122,64,122,108,111};for i=1,#dRoUrUQNsa do dRoUrUQNsa[i]=bit32.bxor(dRoUrUQNsa[i],31) end;return string.char(aAjf8(dRoUrUQNsa))end)(), { Text = (function()local Recg=unpack or table.unpack;local boxH2nfQya={90,76,79,63,206,144,207,167,206,153,63,55,207,173,206,158,207,170,63,206,144,207,166,206,153,207,175,54};for i=1,#boxH2nfQya do boxH2nfQya[i]=bit32.bxor(boxH2nfQya[i],31) end;return string.char(Recg(boxH2nfQya))end)(), Default = false })
MoveBox:AddButton({ Text = (function()local PqjlZ=unpack or table.unpack;local YNrrOI={206,158,207,175,207,163,207,161,206,156,207,174,207,167,207,166,206,158,206,157,207,173,207,161};for i=1,#YNrrOI do YNrrOI[i]=bit32.bxor(YNrrOI[i],31) end;return string.char(PqjlZ(YNrrOI))end)(), Func = function() task.spawn(suicide) end })
local ServerBox = Tab:AddRightGroupbox((function()local dgmR=unpack or table.unpack;local zC_QPZddN2={207,190,207,170,206,159,207,173,207,170,206,159};for i=1,#zC_QPZddN2 do zC_QPZddN2[i]=bit32.bxor(zC_QPZddN2[i],31) end;return string.char(dgmR(zC_QPZddN2))end)())
ServerBox:AddDropdown((function()local nomi=unpack or table.unpack;local CKkJD07={108,122,64,119,112,111,111,109,122,121};for i=1,#CKkJD07 do CKkJD07[i]=bit32.bxor(CKkJD07[i],31) end;return string.char(nomi(CKkJD07))end)(), { Values = { (function()local ECTVE3=unpack or table.unpack;local KCrCGhHLT={83,112,104,122,108,107,63,79,115,126,102,122,109,108};for i=1,#KCrCGhHLT do KCrCGhHLT[i]=bit32.bxor(KCrCGhHLT[i],31) end;return string.char(ECTVE3(KCrCGhHLT))end)(), (function()local IuHA=unpack or table.unpack;local yGCUcZw={87,118,120,119,122,108,107,63,79,115,126,102,122,109,108};for i=1,#yGCUcZw do yGCUcZw[i]=bit32.bxor(yGCUcZw[i],31) end;return string.char(IuHA(yGCUcZw))end)() }, Default = (function()local vHR8=unpack or table.unpack;local uTVo7Ay3={83,112,104,122,108,107,63,79,115,126,102,122,109,108};for i=1,#uTVo7Ay3 do uTVo7Ay3[i]=bit32.bxor(uTVo7Ay3[i],31) end;return string.char(vHR8(uTVo7Ay3))end)(), Text = (function()local HnYi35=unpack or table.unpack;local iOS0we={207,130,207,175,206,158,206,157,206,159,207,161,207,166,207,165,207,175,63,207,160,207,170,206,159,207,170,206,154,207,161,207,171,207,175};for i=1,#iOS0we do iOS0we[i]=bit32.bxor(iOS0we[i],31) end;return string.char(HnYi35(iOS0we))end)() })
ServerBox:AddButton({ Text = (function()local ZPYxV=unpack or table.unpack;local pjHBxYVe={207,190,207,163,207,170,207,162,207,167,206,157,206,147,63,206,158,207,170,206,159,207,173,207,170,206,159};for i=1,#pjHBxYVe do pjHBxYVe[i]=bit32.bxor(pjHBxYVe[i],31) end;return string.char(ZPYxV(pjHBxYVe))end)(), Func = function()
    local pref = (Opt.se_hoppref and Opt.se_hoppref.Value) or (function()local Jbu29J=unpack or table.unpack;local RBr2s8bdMo={83,112,104,122,108,107,63,79,115,126,102,122,109,108};for i=1,#RBr2s8bdMo do RBr2s8bdMo[i]=bit32.bxor(RBr2s8bdMo[i],31) end;return string.char(Jbu29J(RBr2s8bdMo))end)()
    task.spawn(function() serverHop(pref) end)
end })
ServerBox:AddButton({ Text = (function()local i__T=unpack or table.unpack;local AhcnxCJ={207,128,207,170,206,159,207,170,207,168,207,175,207,166,206,157,207,167};for i=1,#AhcnxCJ do AhcnxCJ[i]=bit32.bxor(AhcnxCJ[i],31) end;return string.char(i__T(AhcnxCJ))end)(), Func = function()
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end)
end })
RunService.Heartbeat:Connect(function(dt)
    if not RUNNING or not on((function()local u3P4z0=unpack or table.unpack;local wot_OzHJlj={108,122,64,107,111,104,126,115,116};for i=1,#wot_OzHJlj do wot_OzHJlj[i]=bit32.bxor(wot_OzHJlj[i],31) end;return string.char(u3P4z0(wot_OzHJlj))end)()) then return end
    local hum, h = humanoid(), hrp()
    if hum and h then
        local dir = hum.MoveDirection
        if dir.Magnitude > 0 then h.CFrame = h.CFrame + dir * ((Opt.se_walk and Opt.se_walk.Value) or 409) * dt end
    end
end)
local isMobile = UIS.TouchEnabled and not UIS.KeyboardEnabled
local flyUp, flyDown, flyGui = false, false, nil
local flyWasOn = false
local function flyButtons(make)
    if make and not flyGui then
        flyGui = Instance.new((function()local ywXO=unpack or table.unpack;local kcKKgaJU={76,124,109,122,122,113,88,106,118};for i=1,#kcKKgaJU do kcKKgaJU[i]=bit32.bxor(kcKKgaJU[i],31) end;return string.char(ywXO(kcKKgaJU))end)())
        flyGui.Name = randomName(); flyGui.ResetOnSpawn = false; flyGui.IgnoreGuiInset = true
        hiddenParent(flyGui)
        local function mk(t, yoff)
            local b = Instance.new((function()local qb8A=unpack or table.unpack;local jJ26_HLi={75,122,103,107,93,106,107,107,112,113};for i=1,#jJ26_HLi do jJ26_HLi[i]=bit32.bxor(jJ26_HLi[i],31) end;return string.char(qb8A(jJ26_HLi))end)())
            b.Size = UDim2.new(0, 70, 0, 70); b.AnchorPoint = Vector2.new(1, 1)
            b.Position = UDim2.new(1, -20, 1, yoff); b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            b.BackgroundTransparency = 0.35; b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.TextScaled = true; b.Text = t; b.Parent = flyGui
            return b
        end
        local up, dn = mk("UP", -110), mk((function()local QhAh=unpack or table.unpack;local Kf15v5r={91,80,72,81};for i=1,#Kf15v5r do Kf15v5r[i]=bit32.bxor(Kf15v5r[i],31) end;return string.char(QhAh(Kf15v5r))end)(), -28)
        up.MouseButton1Down:Connect(function() flyUp = true end); up.MouseButton1Up:Connect(function() flyUp = false end)
        dn.MouseButton1Down:Connect(function() flyDown = true end); dn.MouseButton1Up:Connect(function() flyDown = false end)
    elseif not make and flyGui then
        flyGui:Destroy(); flyGui = nil
    end
end
onClean(function() if flyGui then pcall(function() flyGui:Destroy() end); flyGui = nil end end)
RunService.Heartbeat:Connect(function(dt)
    if not RUNNING then return end
    if not on((function()local PpnBX=unpack or table.unpack;local ku9BVmwB={108,122,64,121,115,102};for i=1,#ku9BVmwB do ku9BVmwB[i]=bit32.bxor(ku9BVmwB[i],31) end;return string.char(PpnBX(ku9BVmwB))end)()) then
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
    local sp = (Opt.se_flyspeed and Opt.se_flyspeed.Value) or 60
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
        if on((function()local mT7Q=unpack or table.unpack;local c_FT4Mvh7Q={108,122,64,126,113,107,118,116,125};for i=1,#c_FT4Mvh7Q do c_FT4Mvh7Q[i]=bit32.bxor(c_FT4Mvh7Q[i],31) end;return string.char(mT7Q(c_FT4Mvh7Q))end)()) then
            local rt = lp:GetAttribute((function()local hXkIE=unpack or table.unpack;local eb6aagE={77,126,120,123,112,115,115,90,113,123,75,118,114,122};for i=1,#eb6aagE do eb6aagE[i]=bit32.bxor(eb6aagE[i],31) end;return string.char(hXkIE(eb6aagE))end)())
            local hum = humanoid()
            local ragged = (type(rt) == (function()local yLVg=unpack or table.unpack;local NO2tcf={113,106,114,125,122,109};for i=1,#NO2tcf do NO2tcf[i]=bit32.bxor(NO2tcf[i],31) end;return string.char(yLVg(NO2tcf))end)() and rt > Workspace:GetServerTimeNow()) or (hum and hum:GetState() == Enum.HumanoidStateType.Physics)
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
    if info.weight and r.AssetScale then lines[#lines + 1] = string.format((function()local Vqtdk=unpack or table.unpack;local ENWZ7Kmf4S={58,49,45,121,63,116,120};for i=1,#ENWZ7Kmf4S do ENWZ7Kmf4S[i]=bit32.bxor(ENWZ7Kmf4S[i],31) end;return string.char(Vqtdk(ENWZ7Kmf4S))end)(), info.weight * (r.AssetScale ^ 3))
    elseif info.weight then lines[#lines + 1] = string.format((function()local xmB63K=unpack or table.unpack;local t93slpY={58,49,45,121,63,116,120};for i=1,#t93slpY do t93slpY[i]=bit32.bxor(t93slpY[i],31) end;return string.char(xmB63K(t93slpY))end)(), info.weight) end
    if r.Mutations and #r.Mutations > 0 then lines[#lines + 1] = table.concat(r.Mutations, ", ") end
    return table.concat(lines, "\n"), (RARITY_COLOR[rar] or Color3.fromRGB(0, 255, 128))
end
local espCache = {}
local function makeEsp(m)
    local text, col = eggInfoText(m)
    local hl = Instance.new((function()local nIGjZf=unpack or table.unpack;local RZCqyNfv={87,118,120,119,115,118,120,119,107};for i=1,#RZCqyNfv do RZCqyNfv[i]=bit32.bxor(RZCqyNfv[i],31) end;return string.char(nIGjZf(RZCqyNfv))end)())
    hl.FillColor = col; hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.55; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = m; hl.Parent = m
    local bb = Instance.new((function()local hVutCn=unpack or table.unpack;local IojGZnnVqi={93,118,115,115,125,112,126,109,123,88,106,118};for i=1,#IojGZnnVqi do IojGZnnVqi[i]=bit32.bxor(IojGZnnVqi[i],31) end;return string.char(hVutCn(IojGZnnVqi))end)())
    bb.Name = randomName(); bb.Size = UDim2.fromOffset(190, 52); bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true; bb.Adornee = m.PrimaryPart or m:FindFirstChildWhichIsA((function()local vDQC=unpack or table.unpack;local BUJ2W_Rfn={93,126,108,122,79,126,109,107};for i=1,#BUJ2W_Rfn do BUJ2W_Rfn[i]=bit32.bxor(BUJ2W_Rfn[i],31) end;return string.char(vDQC(BUJ2W_Rfn))end)()); bb.Parent = m
    local tl = Instance.new((function()local UNNI=unpack or table.unpack;local xz0J1zJ={75,122,103,107,83,126,125,122,115};for i=1,#xz0J1zJ do xz0J1zJ[i]=bit32.bxor(xz0J1zJ[i],31) end;return string.char(UNNI(xz0J1zJ))end)())
    tl.Size = UDim2.fromScale(1, 1); tl.BackgroundTransparency = 1; tl.TextColor3 = col
    tl.TextStrokeTransparency = 0.25; tl.Font = Enum.Font.GothamBold; tl.TextSize = 14; tl.Text = text; tl.Parent = bb
    return { hl = hl, bb = bb }
end
local function destroyEsp(e) pcall(function() e.hl:Destroy() end); pcall(function() e.bb:Destroy() end) end
onClean(function() for _, e in pairs(espCache) do destroyEsp(e) end; espCache = {} end)
task.spawn(function()
    while RUNNING do
        if on((function()local rvpu=unpack or table.unpack;local Tv6a2a={108,122,64,122,108,111};for i=1,#Tv6a2a do Tv6a2a[i]=bit32.bxor(Tv6a2a[i],31) end;return string.char(rvpu(Tv6a2a))end)()) then
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
    local wantAreas = selSet((function()local ROfh6=unpack or table.unpack;local xJcXoll={108,122,64,126,109,122,126,108};for i=1,#xJcXoll do xJcXoll[i]=bit32.bxor(xJcXoll[i],31) end;return string.char(ROfh6(xJcXoll))end)())
    if wantAreas and not (r and r.AreaId and wantAreas[r.AreaId]) then return false end
    if useRarityMut then
        local wantRar = selSet((function()local qQPWu=unpack or table.unpack;local IW9kK65={108,122,64,109,126,109,118,107,118,122,108};for i=1,#IW9kK65 do IW9kK65[i]=bit32.bxor(IW9kK65[i],31) end;return string.char(qQPWu(IW9kK65))end)())
        if wantRar then
            local info = r and r.AssetCategory and assetInfo(r.AssetCategory)
            if not (info and info.rarity and wantRar[info.rarity]) then return false end
        end
        local wantMut = selSet((function()local HOAKZ=unpack or table.unpack;local A5KceMBhTQ={108,122,64,114,106,107,126,107,118,112,113,108};for i=1,#A5KceMBhTQ do A5KceMBhTQ[i]=bit32.bxor(A5KceMBhTQ[i],31) end;return string.char(HOAKZ(A5KceMBhTQ))end)())
        if wantMut and not eggHasMutation(uid, wantMut) then return false end
    end
    return true
end
local function sortByPriority(list)
    local pr = (Opt.se_priority and Opt.se_priority.Value) or (function()local qbEJy=unpack or table.unpack;local WBgNAVCuz={81,122,126,109,122,108,107};for i=1,#WBgNAVCuz do WBgNAVCuz[i]=bit32.bxor(WBgNAVCuz[i],31) end;return string.char(qbEJy(WBgNAVCuz))end)()
    if pr == (function()local K4qdK=unpack or table.unpack;local NC7plkK3m={87,118,120,119,122,108,107,63,73,126,115,106,122};for i=1,#NC7plkK3m do NC7plkK3m[i]=bit32.bxor(NC7plkK3m[i],31) end;return string.char(K4qdK(NC7plkK3m))end)() then
        local rk = {}; for _, m in ipairs(list) do local r = eggRecord(m.Name); rk[m] = eggRank(r and r.AssetCategory) end
        table.sort(list, function(a, b) return (rk[a] or 0) > (rk[b] or 0) end)
    elseif pr == (function()local tl8r=unpack or table.unpack;local mGDKEfLU={87,118,120,119,122,108,107,63,72,122,118,120,119,107};for i=1,#mGDKEfLU do mGDKEfLU[i]=bit32.bxor(mGDKEfLU[i],31) end;return string.char(tl8r(mGDKEfLU))end)() then
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
        if step((function()local hQ8N3N=unpack or table.unpack;local uGx5We8={79,115,126,124,122};for i=1,#uGx5We8 do uGx5We8[i]=bit32.bxor(uGx5We8[i],31) end;return string.char(hQ8N3N(uGx5We8))end)()) then
            for k, rec in pairs(myEggs()) do
                if not step((function()local OdjAm=unpack or table.unpack;local f5JeOG_T={79,115,126,124,122};for i=1,#f5JeOG_T do f5JeOG_T[i]=bit32.bxor(f5JeOG_T[i],31) end;return string.char(OdjAm(f5JeOG_T))end)()) then break end
                if type(rec) == (function()local p_vp=unpack or table.unpack;local gbWMz05Eeu={107,126,125,115,122};for i=1,#gbWMz05Eeu do gbWMz05Eeu[i]=bit32.bxor(gbWMz05Eeu[i],31) end;return string.char(p_vp(gbWMz05Eeu))end)() and rec.Placement == nil then placeEgg(rec.Uid or k); task.wait(0.2) end
            end
        end
        if step((function()local fTeHl=unpack or table.unpack;local H1Zpnwno={87,126,107,124,119};for i=1,#H1Zpnwno do H1Zpnwno[i]=bit32.bxor(H1Zpnwno[i],31) end;return string.char(fTeHl(H1Zpnwno))end)()) then
            for k, rec in pairs(myEggs()) do
                if not step((function()local HmbM=unpack or table.unpack;local rFJ2aws={87,126,107,124,119};for i=1,#rFJ2aws do rFJ2aws[i]=bit32.bxor(rFJ2aws[i],31) end;return string.char(HmbM(rFJ2aws))end)()) then break end
                local uid = rec and rec.Uid or k
                if type(rec) == (function()local jpVJ=unpack or table.unpack;local QNvY8u_0Zp={107,126,125,115,122};for i=1,#QNvY8u_0Zp do QNvY8u_0Zp[i]=bit32.bxor(QNvY8u_0Zp[i],31) end;return string.char(jpVJ(QNvY8u_0Zp))end)() and rec.Placement ~= nil and eggReady(uid) then
                    pcall(EggState.BeginHatch, uid); task.wait(0.2)
                    pcall(EggState.FinishHatch, uid); task.wait(0.15)
                end
            end
        end
        if step((function()local PsSRN=unpack or table.unpack;local X892fhG={76,122,115,115};for i=1,#X892fhG do X892fhG[i]=bit32.bxor(X892fhG[i],31) end;return string.char(PsSRN(X892fhG))end)()) then
            inv((function()local oZyz=unpack or table.unpack;local OKWoMX={90,110,106,118,111,93,122,108,107};for i=1,#OKWoMX do OKWoMX[i]=bit32.bxor(OKWoMX[i],31) end;return string.char(oZyz(OKWoMX))end)())
            task.wait(3)
            local s = save()
            if s and type(s.Inventory) == (function()local yLrSc=unpack or table.unpack;local vsV93n7Mzf={107,126,125,115,122};for i=1,#vsV93n7Mzf do vsV93n7Mzf[i]=bit32.bxor(vsV93n7Mzf[i],31) end;return string.char(yLrSc(vsV93n7Mzf))end)() then
                local equipped = {}
                for _, u in ipairs(s.EquippedAssets or {}) do equipped[u] = true end
                local sellList = {}
                local keepSet = selSet((function()local Nu2Xht=unpack or table.unpack;local kli5aMZNw={108,122,64,116,122,122,111,108,122,115,115};for i=1,#kli5aMZNw do kli5aMZNw[i]=bit32.bxor(kli5aMZNw[i],31) end;return string.char(Nu2Xht(kli5aMZNw))end)())
                for uid, item in pairs(s.Inventory) do
                    if type(item) == (function()local gjoW8=unpack or table.unpack;local HMv8ytt7={107,126,125,115,122};for i=1,#HMv8ytt7 do HMv8ytt7[i]=bit32.bxor(HMv8ytt7[i],31) end;return string.char(gjoW8(HMv8ytt7))end)() and not equipped[uid] and item.IsFavorite ~= true and item.InFuse ~= true then
                        local protectedRarity = false
                        if keepSet then local rar = assetInfo(item.Category).rarity; protectedRarity = rar ~= nil and keepSet[rar] == true end
                        if not protectedRarity then sellList[#sellList + 1] = uid end
                    end
                end
                if #sellList > 0 then fire((function()local cjbt=unpack or table.unpack;local NkrnKPYn8i={76,122,115,115,79,122,107,108};for i=1,#NkrnKPYn8i do NkrnKPYn8i[i]=bit32.bxor(NkrnKPYn8i[i],31) end;return string.char(cjbt(NkrnKPYn8i))end)(), sellList) end
            end
        end
        task.wait(1)
    end
end)
local stolen = 0
task.spawn(function()
    while RUNNING do
        pcall(function() statLabel:SetText((function()local GsQGz=unpack or table.unpack;local LfnjsK={89,79,76,37,63};for i=1,#LfnjsK do LfnjsK[i]=bit32.bxor(LfnjsK[i],31) end;return string.char(GsQGz(LfnjsK))end)() .. fps) end)
        pcall(function()
            local disp
            if FPS_PAUSED then disp = (function()local yudsGf=unpack or table.unpack;local coyf_Wa={207,128,207,143,207,188,207,136,207,143,63,50,63,207,162,207,167,207,168,207,165,207,167,207,166,63,89,79,76,63,55};for i=1,#coyf_Wa do coyf_Wa[i]=bit32.bxor(coyf_Wa[i],31) end;return string.char(yudsGf(coyf_Wa))end)() .. fps .. ")"
            elseif not stealAllowed() then disp = (function()local NCZpQ=unpack or table.unpack;local uyd08P={207,128,207,175,206,156,207,168,207,175,63,55,206,158,207,174,206,159,207,161,206,158,63,206,144,207,167,206,153,54};for i=1,#uyd08P do uyd08P[i]=bit32.bxor(uyd08P[i],31) end;return string.char(NCZpQ(uyd08P))end)()
            elseif os.clock() - statusHintAt < 2.5 then disp = statusHint
            elseif on((function()local ZkBFQ=unpack or table.unpack;local ZgBHAWD={108,122,64,108,122,115,122,124,107,122,123};for i=1,#ZgBHAWD do ZgBHAWD[i]=bit32.bxor(ZgBHAWD[i],31) end;return string.char(ZkBFQ(ZgBHAWD))end)()) or on((function()local X2Q3=unpack or table.unpack;local qOlSTf={108,122,64,125,115,112,112,114};for i=1,#qOlSTf do qOlSTf[i]=bit32.bxor(qOlSTf[i],31) end;return string.char(X2Q3(qOlSTf))end)()) then disp = (function()local hYzN7b=unpack or table.unpack;local Yl2OSLm={207,143,207,165,206,157,207,167,207,173,207,162,207,161};for i=1,#Yl2OSLm do Yl2OSLm[i]=bit32.bxor(Yl2OSLm[i],31) end;return string.char(hYzN7b(Yl2OSLm))end)()
            else disp = (function()local ZpoPkz=unpack or table.unpack;local f6okBOPp={207,129,207,169,207,167,207,171,207,175,207,162,207,167,207,170};for i=1,#f6okBOPp do f6okBOPp[i]=bit32.bxor(f6okBOPp[i],31) end;return string.char(ZpoPkz(f6okBOPp))end)() end
            stateLabel:SetText((function()local FnkG=unpack or table.unpack;local Wq_ScbQloM={207,190,206,157,207,175,206,157,206,156,206,158,37,63};for i=1,#Wq_ScbQloM do Wq_ScbQloM[i]=bit32.bxor(Wq_ScbQloM[i],31) end;return string.char(FnkG(Wq_ScbQloM))end)() .. tostring(disp))
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
    local r = Workspace:FindFirstChild((function()local uqI8=unpack or table.unpack;local CPpf4urB={64,64,92,115,118,122,113,107,75,109,122,126,123,114,118,115,115,77,122,113,123,122,109,108};for i=1,#CPpf4urB do CPpf4urB[i]=bit32.bxor(CPpf4urB[i],31) end;return string.char(uqI8(CPpf4urB))end)()); if not r then return nil end
    local h = hrp(); local hp = h and h.Position
    local best, bestD
    for _, p in ipairs(r:GetDescendants()) do
        if p:IsA((function()local PdiB=unpack or table.unpack;local twF_z35EZ={93,126,108,122,79,126,109,107};for i=1,#twF_z35EZ do twF_z35EZ[i]=bit32.bxor(twF_z35EZ[i],31) end;return string.char(PdiB(twF_z35EZ))end)()) and (p.Name == (function()local e2q3Mn=unpack or table.unpack;local nRV735D2hK={93,122,115,107};for i=1,#nRV735D2hK do nRV735D2hK[i]=bit32.bxor(nRV735D2hK[i],31) end;return string.char(e2q3Mn(nRV735D2hK))end)() or p.Name == (function()local ffJB=unpack or table.unpack;local rUHkO8={77,106,113,113,122,109};for i=1,#rUHkO8 do rUHkO8[i]=bit32.bxor(rUHkO8[i],31) end;return string.char(ffJB(rUHkO8))end)() or p.Name == "Top" or p.Name == (function()local qb3qc=unpack or table.unpack;local yAPAVe={89,115,112,112,109};for i=1,#yAPAVe do yAPAVe[i]=bit32.bxor(yAPAVe[i],31) end;return string.char(qb3qc(yAPAVe))end)() or p.Name == (function()local FnZK8=unpack or table.unpack;local Pkyq9WpMA={75,109,122,126,123};for i=1,#Pkyq9WpMA do Pkyq9WpMA[i]=bit32.bxor(Pkyq9WpMA[i],31) end;return string.char(FnZK8(Pkyq9WpMA))end)()) then
            local d = hp and (p.Position - hp).Magnitude or 0
            if not bestD or d < bestD then bestD = d; best = p end
        end
    end
    if best then return best end
    for _, m in ipairs(r:GetChildren()) do if m:IsA((function()local kXVSe=unpack or table.unpack;local CLTiUVrpU={82,112,123,122,115};for i=1,#CLTiUVrpU do CLTiUVrpU[i]=bit32.bxor(CLTiUVrpU[i],31) end;return string.char(kXVSe(CLTiUVrpU))end)()) then local p = m.PrimaryPart or m:FindFirstChildWhichIsA((function()local Rvpk=unpack or table.unpack;local dMvW5dF={93,126,108,122,79,126,109,107};for i=1,#dMvW5dF do dMvW5dF[i]=bit32.bxor(dMvW5dF[i],31) end;return string.char(Rvpk(dMvW5dF))end)(), true); if p then return p end end end
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
    local part = treadTop(); if not part then setStatus((function()local r4ov=unpack or table.unpack;local CnSZYCIkK0={207,139,207,161,206,159,207,161,207,169,207,165,207,175,63,207,162,207,170,63,207,162,207,175,207,166,207,171,207,170,207,162,207,175};for i=1,#CnSZYCIkK0 do CnSZYCIkK0[i]=bit32.bxor(CnSZYCIkK0[i],31) end;return string.char(r4ov(CnSZYCIkK0))end)()); return end
    setStatus((function()local TZr6=unpack or table.unpack;local K_PSM5Tu={207,135,207,171,206,156,63,207,165,63,207,171,207,161,206,159,207,161,207,169,207,165,207,170};for i=1,#K_PSM5Tu do K_PSM5Tu[i]=bit32.bxor(K_PSM5Tu[i],31) end;return string.char(TZr6(K_PSM5Tu))end)())
    Nav.tweenTo3D(part.Position + Vector3.new(0, 3, 0), function() return RUNNING and on((function()local aYAjQ=unpack or table.unpack;local jkPnIHd={108,122,64,108,122,115,122,124,107,122,123};for i=1,#jkPnIHd do jkPnIHd[i]=bit32.bxor(jkPnIHd[i],31) end;return string.char(aYAjQ(jkPnIHd))end)()) and step((function()local xZbh0=unpack or table.unpack;local tM1TiE={75,109,122,126,123,114,118,115,115};for i=1,#tM1TiE do tM1TiE[i]=bit32.bxor(tM1TiE[i],31) end;return string.char(xZbh0(tM1TiE))end)()) and not targetEggsExist() end, (Opt.se_speed and Opt.se_speed.Value) or 300)
    if targetEggsExist() then return end
    if TREAD and TREAD.AskWearStill then pcall(function() TREAD.AskWearStill:InvokeServer() end) end
    onTread = true
    setStatus((function()local DvDM=unpack or table.unpack;local H0g03BJ={207,130,207,175,63,207,171,207,161,206,159,207,161,207,169,207,165,207,170,63,55,207,162,207,170,206,157,63,206,144,207,167,206,153,54};for i=1,#H0g03BJ do H0g03BJ[i]=bit32.bxor(H0g03BJ[i],31) end;return string.char(DvDM(H0g03BJ))end)())
end
task.spawn(function()
    while RUNNING do
        if on((function()local iUW4=unpack or table.unpack;local enpsnqbw={108,122,64,108,122,115,122,124,107,122,123};for i=1,#enpsnqbw do enpsnqbw[i]=bit32.bxor(enpsnqbw[i],31) end;return string.char(iUW4(enpsnqbw))end)()) and stealAllowed() and targetEggsExist() then
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
            if not on((function()local OsMF2k=unpack or table.unpack;local z0MHpU={108,122,64,108,122,115,122,124,107,122,123};for i=1,#z0MHpU do z0MHpU[i]=bit32.bxor(z0MHpU[i],31) end;return string.char(OsMF2k(z0MHpU))end)()) then leaveTread(); return end
            if not stealAllowed() then setStatus((function()local Z7Uf=unpack or table.unpack;local kqRr3uu1y={207,128,207,175,206,156,207,168,207,175,63,55,206,158,207,174,206,159,207,161,206,158,63,206,144,207,167,206,153,54};for i=1,#kqRr3uu1y do kqRr3uu1y[i]=bit32.bxor(kqRr3uu1y[i],31) end;return string.char(Z7Uf(kqRr3uu1y))end)()); return end
            local list = {}
            for _, m in ipairs(scanEggs()) do if passesFilters(m.Name, true) then list[#list + 1] = m end end
            if #list == 0 then
                if step((function()local fFHMa=unpack or table.unpack;local XY89WEM={75,109,122,126,123,114,118,115,115};for i=1,#XY89WEM do XY89WEM[i]=bit32.bxor(XY89WEM[i],31) end;return string.char(fFHMa(XY89WEM))end)()) then mountTread() else forceDoff(); setStatus((function()local wkq6=unpack or table.unpack;local Bm4ztq={207,129,207,169,207,167,207,171,207,175,207,162,207,167,207,170,63,206,144,207,167,206,153};for i=1,#Bm4ztq do Bm4ztq[i]=bit32.bxor(Bm4ztq[i],31) end;return string.char(wkq6(Bm4ztq))end)()) end
                return
            end
            forceDoff()
            sortByPriority(list)
            local keepGoing = function() return on((function()local eUNq=unpack or table.unpack;local kQpIgl1YW={108,122,64,108,122,115,122,124,107,122,123};for i=1,#kQpIgl1YW do kQpIgl1YW[i]=bit32.bxor(kQpIgl1YW[i],31) end;return string.char(eUNq(kQpIgl1YW))end)()) and stealAllowed() end
            local m = list[1]
            local uid = m.Name
            local speed = (Opt.se_speed and Opt.se_speed.Value) or 300
            local okp, pos = pcall(function() return m:GetPivot().Position end)
            if not okp or not pos then return end
            lockMove()
            local fr = nearestForest()
            if not fr then setStatus((function()local bujfEM=unpack or table.unpack;local jlX5vv5Ax={207,130,207,170,206,157,63,207,164,207,170,206,158,207,162,207,161,207,172,207,161,63,206,144,207,166,206,153,207,175,63,207,171,207,164,206,144,63,207,160,207,161,207,171,207,172,207,161,206,157,207,161,207,173,207,165,207,167};for i=1,#jlX5vv5Ax do jlX5vv5Ax[i]=bit32.bxor(jlX5vv5Ax[i],31) end;return string.char(bujfEM(jlX5vv5Ax))end)()); unlockMove(); return end
            setStatus((function()local ONL_7m=unpack or table.unpack;local lwj211op7o={207,128,207,161,207,171,207,172,207,161,206,157,207,161,207,173,207,165,207,175,37,63,207,164,207,170,206,158,207,162,207,161,207,170,63,206,144,207,166,206,153,207,161};for i=1,#lwj211op7o do lwj211op7o[i]=bit32.bxor(lwj211op7o[i],31) end;return string.char(ONL_7m(lwj211op7o))end)())
            travelOutToEgg(fr.pos, keepGoing, 400)
            do local t0 = os.clock(); while os.clock() - t0 < 1.5 do grabEgg(fr.m, fr.uid); if fpCarrying or fieldEggModel(fr.uid) == nil then break end; task.wait(0.15) end end
            setStatus((function()local hG4O=unpack or table.unpack;local dCP2IEDPu={207,137,207,171,206,156,63,206,156,207,171,207,175,206,159,207,175,63,207,165,206,156,206,159,207,167,206,153,206,148,49,49,49};for i=1,#dCP2IEDPu do dCP2IEDPu[i]=bit32.bxor(dCP2IEDPu[i],31) end;return string.char(hG4O(dCP2IEDPu))end)())
            local RAG = { [Enum.HumanoidStateType.Physics] = true, [Enum.HumanoidStateType.Ragdoll] = true, [Enum.HumanoidStateType.FallingDown] = true }
            local hit, conns, wasCarry = false, {}, fpCarrying
            local hum0 = humanoid()
            if hum0 then conns[#conns + 1] = hum0.StateChanged:Connect(function(_, s) if RAG[s] then hit = true end end) end
            local ch = lp.Character
            if ch then conns[#conns + 1] = ch.DescendantAdded:Connect(function(d)
                if d:IsA((function()local oHkKAw=unpack or table.unpack;local OWysrZwqxR={93,126,115,115,76,112,124,116,122,107,92,112,113,108,107,109,126,118,113,107};for i=1,#OWysrZwqxR do OWysrZwqxR[i]=bit32.bxor(OWysrZwqxR[i],31) end;return string.char(oHkKAw(OWysrZwqxR))end)()) or d:IsA((function()local U7fBtX=unpack or table.unpack;local nOmTGzs0U={87,118,113,120,122,92,112,113,108,107,109,126,118,113,107};for i=1,#nOmTGzs0U do nOmTGzs0U[i]=bit32.bxor(nOmTGzs0U[i],31) end;return string.char(U7fBtX(nOmTGzs0U))end)()) then hit = true
                elseif d:IsA((function()local GxC62=unpack or table.unpack;local QN98C1cBgS={94,107,107,126,124,119,114,122,113,107};for i=1,#QN98C1cBgS do QN98C1cBgS[i]=bit32.bxor(QN98C1cBgS[i],31) end;return string.char(GxC62(QN98C1cBgS))end)()) and tostring(d.Name):find((function()local XHOtZv=unpack or table.unpack;local Jako5tsO={77,126,120,123,112,115,115};for i=1,#Jako5tsO do Jako5tsO[i]=bit32.bxor(Jako5tsO[i],31) end;return string.char(XHOtZv(Jako5tsO))end)()) then hit = true end
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
            if not hit then setStatus((function()local linr=unpack or table.unpack;local D_D5twnIl={207,188,207,171,207,175,206,159,63,207,162,207,170,63,207,161,207,174,207,162,207,175,206,159,206,156,207,169,207,170,207,162,63,207,168,207,175,63,45,42,206,158};for i=1,#D_D5twnIl do D_D5twnIl[i]=bit32.bxor(D_D5twnIl[i],31) end;return string.char(linr(D_D5twnIl))end)()); unlockMove(); return end
            tpTo(pos); clearRagdoll()
            setStatus((function()local Rzb74Z=unpack or table.unpack;local m8biFEE_k={207,133,206,159,207,175,207,169,207,175,63,206,153,207,170,207,164,207,167};for i=1,#m8biFEE_k do m8biFEE_k[i]=bit32.bxor(m8biFEE_k[i],31) end;return string.char(Rzb74Z(m8biFEE_k))end)())
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
            if not haveIt() then setStatus((function()local zckBX=unpack or table.unpack;local wOSkof={207,130,207,170,63,206,156,207,171,207,175,207,164,207,161,206,158,206,147,63,206,158,206,154,207,173,207,175,206,157,207,167,206,157,206,147,63,206,153,207,170,207,164,206,147};for i=1,#wOSkof do wOSkof[i]=bit32.bxor(wOSkof[i],31) end;return string.char(zckBX(wOSkof))end)()); unlockMove(); return end
            stolen = stolen + 1
            if on((function()local iBilH=unpack or table.unpack;local EjR8e1f={108,122,64,109,122,107,106,109,113};for i=1,#EjR8e1f do EjR8e1f[i]=bit32.bxor(EjR8e1f[i],31) end;return string.char(iBilH(EjR8e1f))end)()) then
                local retSpeed = on((function()local pIMon=unpack or table.unpack;local rr8uzk={108,122,64,107,111,104,126,115,116};for i=1,#rr8uzk do rr8uzk[i]=bit32.bxor(rr8uzk[i],31) end;return string.char(pIMon(rr8uzk))end)()) and ((Opt.se_walk and Opt.se_walk.Value) or 409) or speed
                local delivered, guard = false, os.clock()
                while keepGoing() and not delivered and os.clock() - guard < 45 do
                    clearRagdoll()
                    if not fpCarrying then
                        local em = fieldEggModel(uid)
                        if not em then delivered = true; break end
                        if not on((function()local kZMBJ=unpack or table.unpack;local B3UyYv5b={108,122,64,126,113,107,118,119,118,107};for i=1,#B3UyYv5b do B3UyYv5b[i]=bit32.bxor(B3UyYv5b[i],31) end;return string.char(kZMBJ(B3UyYv5b))end)()) then setStatus((function()local cw2o3=unpack or table.unpack;local k68gN7Z={207,176,207,166,206,153,207,161,63,207,173,206,148,207,160,207,175,207,164,207,161,63,55,207,175,207,162,206,157,207,167,50,206,156,207,171,207,175,206,159,63,207,173,206,148,207,165,207,164,54};for i=1,#k68gN7Z do k68gN7Z[i]=bit32.bxor(k68gN7Z[i],31) end;return string.char(cw2o3(k68gN7Z))end)()); break end
                        setStatus((function()local BsgJ=unpack or table.unpack;local cnGNR7Zi={207,176,207,166,206,153,207,161,63,207,173,206,148,207,160,207,175,207,164,207,161,63,50,33,63,207,173,207,161,207,168,207,173,206,159,207,175,206,150,207,175,206,145,206,158,206,147,63,207,168,207,175,63,207,162,207,167,207,163};for i=1,#cnGNR7Zi do cnGNR7Zi[i]=bit32.bxor(cnGNR7Zi[i],31) end;return string.char(BsgJ(cnGNR7Zi))end)())
                        local gg = os.clock()
                        while keepGoing() and not fpCarrying and fieldEggModel(uid) and os.clock() - gg < 8 do
                            clearRagdoll()
                            local em2 = fieldEggModel(uid)
                            local ep = em2 and select(2, pcall(function() return em2:GetPivot().Position end))
                            local h = hrp()
                            if h and typeof(ep) == (function()local iaPQ=unpack or table.unpack;local E9YYWl_={73,122,124,107,112,109,44};for i=1,#E9YYWl_ do E9YYWl_[i]=bit32.bxor(E9YYWl_[i],31) end;return string.char(iaPQ(E9YYWl_))end)() then
                                local flat = Vector3.new(ep.X, h.Position.Y, ep.Z)
                                if (flat - h.Position).Magnitude > 4 then h.CFrame = CFrame.new(flat) * (h.CFrame - h.CFrame.Position); h.AssemblyLinearVelocity = Vector3.zero end
                            end
                            grabEgg(em2 or em, uid); task.wait(0.15)
                        end
                    else
                        setStatus((function()local XJgfit=unpack or table.unpack;local FDIOOr={207,141,207,161,207,168,207,173,206,159,207,175,206,157,63,207,162,207,175,63,207,174,207,175,207,168,206,156};for i=1,#FDIOOr do FDIOOr[i]=bit32.bxor(FDIOOr[i],31) end;return string.char(XJgfit(FDIOOr))end)())
                        returnToOwnBase(function() return keepGoing() and fpCarrying end, retSpeed)
                        if fpCarrying then inv((function()local iIoK=unpack or table.unpack;local vkh31WuU={79,115,126,124,122};for i=1,#vkh31WuU do vkh31WuU[i]=bit32.bxor(vkh31WuU[i],31) end;return string.char(iIoK(vkh31WuU))end)(), { Uid = uid, LocalCFrame = CFrame.new(math.random(-8, 8), 0, math.random(-8, 8)) }); task.wait(0.15); delivered = true end
                    end
                end
            end
            unlockMove()
        end)
        if not ok then unlockMove(); setStatus((function()local hLR7uc=unpack or table.unpack;local OJHdSgVz={207,141,207,161,206,158,206,158,206,157,207,175,207,162,207,161,207,173,207,164,207,170,207,162,207,167,207,170,49,49,49};for i=1,#OJHdSgVz do OJHdSgVz[i]=bit32.bxor(OJHdSgVz[i],31) end;return string.char(hLR7uc(OJHdSgVz))end)()) end
        task.wait(0.2)
    end
end)
local EventsTab = Window:AddTab((function()local ZcDhzO=unpack or table.unpack;local p0XHgki8q={207,190,207,161,207,174,206,148,206,157,207,167,206,144};for i=1,#p0XHgki8q do p0XHgki8q[i]=bit32.bxor(p0XHgki8q[i],31) end;return string.char(ZcDhzO(p0XHgki8q))end)(), (function()local rtFF=unpack or table.unpack;local sRln3I4Gm={108,111,126,109,116,115,122,108};for i=1,#sRln3I4Gm do sRln3I4Gm[i]=bit32.bxor(sRln3I4Gm[i],31) end;return string.char(rtFF(sRln3I4Gm))end)())
local BloomBox = EventsTab:AddLeftGroupbox((function()local EJMII=unpack or table.unpack;local zrAagV2={207,141,207,170,207,164,207,167,207,165,207,161,207,170,63,206,153,207,173,207,170,206,157,207,170,207,162,207,167,207,170};for i=1,#zrAagV2 do zrAagV2[i]=bit32.bxor(zrAagV2[i],31) end;return string.char(EJMII(zrAagV2))end)())
BloomBox:AddToggle((function()local yYACP_=unpack or table.unpack;local TinBQICj={108,122,64,125,115,112,112,114};for i=1,#TinBQICj do TinBQICj[i]=bit32.bxor(TinBQICj[i],31) end;return string.char(yYACP_(TinBQICj))end)(), { Text = (function()local w2w2AE=unpack or table.unpack;local PnlVog={207,143,207,173,206,157,207,161,50,206,155,207,175,206,159,207,163,63,206,153,207,173,207,170,206,157,207,170,207,162,207,167,206,144};for i=1,#PnlVog do PnlVog[i]=bit32.bxor(PnlVog[i],31) end;return string.char(w2w2AE(PnlVog))end)(), Default = false })
local FuseBox = EventsTab:AddLeftGroupbox((function()local wtL2f=unpack or table.unpack;local FmVoiMD={207,131,207,175,206,151,207,167,207,162,207,175,63,206,158,207,164,207,167,206,144,207,162,207,167,206,144};for i=1,#FmVoiMD do FmVoiMD[i]=bit32.bxor(FmVoiMD[i],31) end;return string.char(wtL2f(FmVoiMD))end)())
FuseBox:AddToggle((function()local hL9_=unpack or table.unpack;local FLj3hR6R={108,122,64,126,106,107,112,121,106,108,122};for i=1,#FLj3hR6R do FLj3hR6R[i]=bit32.bxor(FLj3hR6R[i],31) end;return string.char(hL9_(FLj3hR6R))end)(), { Text = (function()local elKnZ7=unpack or table.unpack;local _s44aGfvWe={207,143,207,173,206,157,207,161,50,206,158,207,164,207,167,206,144,207,162,207,167,207,170,63,207,160,207,167,206,157,207,161,207,163,206,153,207,170,207,173};for i=1,#_s44aGfvWe do _s44aGfvWe[i]=bit32.bxor(_s44aGfvWe[i],31) end;return string.char(elKnZ7(_s44aGfvWe))end)(), Default = false })
local IncBox = EventsTab:AddRightGroupbox((function()local YuKW=unpack or table.unpack;local Eio1c_l={207,135,207,162,207,165,206,156,207,174,207,175,206,157,207,161,206,159,63,207,190,207,175,207,165,206,156,206,159,206,148};for i=1,#Eio1c_l do Eio1c_l[i]=bit32.bxor(Eio1c_l[i],31) end;return string.char(YuKW(Eio1c_l))end)())
local crysLabel = IncBox:AddLabel((function()local LMSr=unpack or table.unpack;local qVXU44rum={207,133,206,159,207,167,206,158,206,157,207,175,207,164,207,164,206,148,37,63,47};for i=1,#qVXU44rum do qVXU44rum[i]=bit32.bxor(qVXU44rum[i],31) end;return string.char(LMSr(qVXU44rum))end)())
IncBox:AddToggle((function()local vuPz=unpack or table.unpack;local i7NTPBbCjp={108,122,64,118,113,124,106,125,126,107,122};for i=1,#i7NTPBbCjp do i7NTPBbCjp[i]=bit32.bxor(i7NTPBbCjp[i],31) end;return string.char(vuPz(i7NTPBbCjp))end)(), { Text = (function()local LM_Z_2=unpack or table.unpack;local d24RHaZ={207,143,207,173,206,157,207,161,50,207,167,207,162,207,165,206,156,207,174,207,175,206,153,207,167,206,144};for i=1,#d24RHaZ do d24RHaZ[i]=bit32.bxor(d24RHaZ[i],31) end;return string.char(LM_Z_2(d24RHaZ))end)(), Default = false })
IncBox:AddToggle((function()local F_YWb_=unpack or table.unpack;local btTZ_XRb5L={108,122,64,126,106,107,112,123,122,111,112,108,118,107};for i=1,#btTZ_XRb5L do btTZ_XRb5L[i]=bit32.bxor(btTZ_XRb5L[i],31) end;return string.char(F_YWb_(btTZ_XRb5L))end)(), { Text = (function()local tIdZ=unpack or table.unpack;local twHQor={207,143,207,173,206,157,207,161,50,207,173,207,165,207,164,207,175,207,171,63,207,165,206,159,207,167,206,158,206,157,207,175,207,164,207,164,207,161,207,173};for i=1,#twHQor do twHQor[i]=bit32.bxor(twHQor[i],31) end;return string.char(tIdZ(twHQor))end)(), Default = true })
IncBox:AddToggle((function()local W6i5=unpack or table.unpack;local bDLJKUW={108,122,64,126,106,107,112,114,106,107,126,107,122};for i=1,#bDLJKUW do bDLJKUW[i]=bit32.bxor(bDLJKUW[i],31) end;return string.char(W6i5(bDLJKUW))end)(), { Text = (function()local FPsn_W=unpack or table.unpack;local daFnEWuqfB={207,143,207,173,206,157,207,161,50,207,163,206,156,206,157,207,175,206,153,207,167,206,144,63,207,160,206,159,207,167,63,207,168,207,175,207,160,207,161,207,164,207,162,207,170,207,162,207,167,207,167};for i=1,#daFnEWuqfB do daFnEWuqfB[i]=bit32.bxor(daFnEWuqfB[i],31) end;return string.char(FPsn_W(daFnEWuqfB))end)(), Default = true })
local BossBox = EventsTab:AddRightGroupbox((function()local qFwf=unpack or table.unpack;local F5cwXt={207,190,207,161,207,174,206,148,206,157,207,167,207,170,63,207,174,207,161,206,158,206,158,207,175};for i=1,#F5cwXt do F5cwXt[i]=bit32.bxor(F5cwXt[i],31) end;return string.char(qFwf(F5cwXt))end)())
BossBox:AddToggle((function()local MInY=unpack or table.unpack;local qWx0vjk={108,122,64,125,112,108,108};for i=1,#qWx0vjk do qWx0vjk[i]=bit32.bxor(qWx0vjk[i],31) end;return string.char(MInY(qWx0vjk))end)(), { Text = (function()local t_R7=unpack or table.unpack;local CpYxzFg={207,143,207,173,206,157,207,161,50,207,174,207,161,206,158,206,158,63,55,207,173,206,154,207,161,207,171,63,52,63,206,156,207,171,207,175,206,159,206,148,63,207,160,207,161,63,207,165,206,159,207,167,206,158,206,157,207,175,207,164,207,164,207,175,207,163,54};for i=1,#CpYxzFg do CpYxzFg[i]=bit32.bxor(CpYxzFg[i],31) end;return string.char(t_R7(CpYxzFg))end)(), Default = false })
local bossLabel = BossBox:AddLabel((function()local Dcck=unpack or table.unpack;local SLOmIZwE={207,142,207,161,206,158,206,158,37,63,207,161,207,169,207,167,207,171,207,175,207,162,207,167,207,170};for i=1,#SLOmIZwE do SLOmIZwE[i]=bit32.bxor(SLOmIZwE[i],31) end;return string.char(Dcck(SLOmIZwE))end)())
local bossCountLabel = BossBox:AddLabel((function()local ZEWj=unpack or table.unpack;local xziIDgGkt={207,190,207,164,207,170,207,171,206,156,206,145,206,150,207,167,207,166,63,207,174,207,161,206,158,206,158,37,63,50,50,37,50,50};for i=1,#xziIDgGkt do xziIDgGkt[i]=bit32.bxor(xziIDgGkt[i],31) end;return string.char(ZEWj(xziIDgGkt))end)())
local BOSS = Remotes and Remotes.BossEvent
local function bossArena() return Workspace:FindFirstChild((function()local ml3pYk=unpack or table.unpack;local DTW052={93,112,108,108,94,109,122,113,126};for i=1,#DTW052 do DTW052[i]=bit32.bxor(DTW052[i],31) end;return string.char(ml3pYk(DTW052))end)(), true) end
local function inArena() return lp:GetAttribute((function()local Dqql3L=unpack or table.unpack;local QadLBpzD={86,113,93,112,108,108,94,109,122,113,126};for i=1,#QadLBpzD do QadLBpzD[i]=bit32.bxor(QadLBpzD[i],31) end;return string.char(Dqql3L(QadLBpzD))end)()) == true end
local function crystalHitboxes()
    local a = bossArena(); if not a then return {} end
    local folder = a:FindFirstChild((function()local erkSI=unpack or table.unpack;local vZ8OnGzWja={92,109,102,108,107,126,115,75,112,104,122,109,108};for i=1,#vZ8OnGzWja do vZ8OnGzWja[i]=bit32.bxor(vZ8OnGzWja[i],31) end;return string.char(erkSI(vZ8OnGzWja))end)(), true); if not folder then return {} end
    local out = {}
    for _, c in ipairs(folder:GetChildren()) do
        local hb = c:FindFirstChild((function()local X_0yd=unpack or table.unpack;local Sd05mvhkOB={87,118,107,125,112,103};for i=1,#Sd05mvhkOB do Sd05mvhkOB[i]=bit32.bxor(Sd05mvhkOB[i],31) end;return string.char(X_0yd(Sd05mvhkOB))end)())
        if hb and hb:IsA((function()local Rqx2=unpack or table.unpack;local io9Ksl2HH={93,126,108,122,79,126,109,107};for i=1,#io9Ksl2HH do io9Ksl2HH[i]=bit32.bxor(io9Ksl2HH[i],31) end;return string.char(Rqx2(io9Ksl2HH))end)()) then
            local hpv = hb:GetAttribute((function()local WGwr2x=unpack or table.unpack;local xTo4pbTiAc={87,122,126,115,107,119};for i=1,#xTo4pbTiAc do xTo4pbTiAc[i]=bit32.bxor(xTo4pbTiAc[i],31) end;return string.char(WGwr2x(xTo4pbTiAc))end)())
            if hpv == nil or (type(hpv) == (function()local xT6q=unpack or table.unpack;local iLEYOVBC={113,106,114,125,122,109};for i=1,#iLEYOVBC do iLEYOVBC[i]=bit32.bxor(iLEYOVBC[i],31) end;return string.char(xT6q(iLEYOVBC))end)() and hpv > 0) then out[#out + 1] = hb end
        end
    end
    return out
end
local function worldPosOf(inst)
    if not inst then return nil end
    if inst:IsA((function()local nLCy=unpack or table.unpack;local jNNqnh={93,126,108,122,79,126,109,107};for i=1,#jNNqnh do jNNqnh[i]=bit32.bxor(jNNqnh[i],31) end;return string.char(nLCy(jNNqnh))end)()) then return inst.Position end
    local ok, p = pcall(function() return inst.WorldPosition end); if ok and typeof(p) == (function()local YiXn3E=unpack or table.unpack;local Cnkaimqh={73,122,124,107,112,109,44};for i=1,#Cnkaimqh do Cnkaimqh[i]=bit32.bxor(Cnkaimqh[i],31) end;return string.char(YiXn3E(Cnkaimqh))end)() then return p end
    local ok2, cf = pcall(function() return inst.WorldCFrame end); if ok2 and cf then return cf.Position end
    return nil
end
local function armTargets()
    local a = bossArena(); if not a then return {} end
    local bm = a:FindFirstChild((function()local okhNW5=unpack or table.unpack;local nW0mWz={93,112,108,108};for i=1,#nW0mWz do nW0mWz[i]=bit32.bxor(nW0mWz[i],31) end;return string.char(okhNW5(nW0mWz))end)(), true); if not bm then return {} end
    local out = {}
    for _, d in ipairs(bm:GetDescendants()) do
        if (d:IsA((function()local U2Y7Lv=unpack or table.unpack;local TwKHBkh={93,112,113,122};for i=1,#TwKHBkh do TwKHBkh[i]=bit32.bxor(TwKHBkh[i],31) end;return string.char(U2Y7Lv(TwKHBkh))end)()) or d:IsA((function()local O1dG=unpack or table.unpack;local OnygtHknI5={93,126,108,122,79,126,109,107};for i=1,#OnygtHknI5 do OnygtHknI5[i]=bit32.bxor(OnygtHknI5[i],31) end;return string.char(O1dG(OnygtHknI5))end)())) and d:FindFirstChild((function()local mUS2F=unpack or table.unpack;local WO0Np6M={87,122,126,115,107,119};for i=1,#WO0Np6M do WO0Np6M[i]=bit32.bxor(WO0Np6M[i],31) end;return string.char(mUS2F(WO0Np6M))end)()) ~= nil then out[#out + 1] = d end
    end
    return out
end
local function bossBodyPart()
    local a = bossArena(); if not a then return nil end
    local boss = a:FindFirstChild((function()local o3rff=unpack or table.unpack;local NkbUgu={93,112,108,108};for i=1,#NkbUgu do NkbUgu[i]=bit32.bxor(NkbUgu[i],31) end;return string.char(o3rff(NkbUgu))end)(), true); if not boss then return nil end
    if boss:IsA((function()local xhqBx=unpack or table.unpack;local x8Mt15fCK={93,126,108,122,79,126,109,107};for i=1,#x8Mt15fCK do x8Mt15fCK[i]=bit32.bxor(x8Mt15fCK[i],31) end;return string.char(xhqBx(x8Mt15fCK))end)()) then return boss end
    return boss.PrimaryPart or boss:FindFirstChild((function()local vVCkwg=unpack or table.unpack;local GuYABuH6W={87,106,114,126,113,112,118,123,77,112,112,107,79,126,109,107};for i=1,#GuYABuH6W do GuYABuH6W[i]=bit32.bxor(GuYABuH6W[i],31) end;return string.char(vVCkwg(GuYABuH6W))end)(), true) or boss:FindFirstChildWhichIsA((function()local pe3XW=unpack or table.unpack;local EEMqPJsG={93,126,108,122,79,126,109,107};for i=1,#EEMqPJsG do EEMqPJsG[i]=bit32.bxor(EEMqPJsG[i],31) end;return string.char(pe3XW(EEMqPJsG))end)(), true)
end
local _bossSeq = 0
local function swingBat(faceAt)
    _bossSeq = _bossSeq + 1
    local id = ((function()local cvKH1u=unpack or table.unpack;local VcY66G={58,123,37,58,123,37,58,123};for i=1,#VcY66G do VcY66G[i]=bit32.bxor(VcY66G[i],31) end;return string.char(cvKH1u(VcY66G))end)()):format(lp.UserId, _bossSeq, math.floor(Workspace:GetServerTimeNow() * 1000))
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
        Nav.tweenTo3D(pos, keep, (Opt.se_walk and Opt.se_walk.Value) or 300)
        if not (keep() and target and target.Parent) then return end
        swingBat(target)
        task.wait(0.5)
    end
end
task.spawn(function()
    while RUNNING do
        if on((function()local KiTXDg=unpack or table.unpack;local jF7QxC={108,122,64,125,112,108,108};for i=1,#jF7QxC do jF7QxC[i]=bit32.bxor(jF7QxC[i],31) end;return string.char(KiTXDg(jF7QxC))end)()) and BOSS then
            if not inArena() then
                pcall(function() bossLabel:SetText((function()local oUpY=unpack or table.unpack;local iJJ0b7u={207,142,207,161,206,158,206,158,37,63,207,173,206,154,207,161,207,171};for i=1,#iJJ0b7u do iJJ0b7u[i]=bit32.bxor(iJJ0b7u[i],31) end;return string.char(oUpY(iJJ0b7u))end)()) end)
                pcall(function() if BOSS.AskEnter then BOSS.AskEnter:InvokeServer() end end)
                task.wait(1)
            else
                if not heldBat() then equipBatInput(true) end
                local keep = function() return RUNNING and on((function()local hysT=unpack or table.unpack;local pvsM5Ivdy={108,122,64,125,112,108,108};for i=1,#pvsM5Ivdy do pvsM5Ivdy[i]=bit32.bxor(pvsM5Ivdy[i],31) end;return string.char(hysT(pvsM5Ivdy))end)()) and inArena() end
                local crystals = crystalHitboxes()
                if #crystals > 0 then
                    local h = hrp()
                    if h then table.sort(crystals, function(a, b) return (a.Position - h.Position).Magnitude < (b.Position - h.Position).Magnitude end) end
                    pcall(function() bossLabel:SetText((function()local C3dh=unpack or table.unpack;local Cu9k9bbBs={207,142,207,161,206,158,206,158,37,63,207,165,206,159,207,167,206,158,206,157,207,175,207,164,207,164,206,148,63,55};for i=1,#Cu9k9bbBs do Cu9k9bbBs[i]=bit32.bxor(Cu9k9bbBs[i],31) end;return string.char(C3dh(Cu9k9bbBs))end)() .. #crystals .. (function()local LlrozZ=unpack or table.unpack;local oqiH9U={63,207,161,206,158,206,157,207,175,207,164,207,161,206,158,206,147,54};for i=1,#oqiH9U do oqiH9U[i]=bit32.bxor(oqiH9U[i],31) end;return string.char(LlrozZ(oqiH9U))end)()) end)
                    orbitAndSwing(crystals[1], keep)
                else
                    local arms = armTargets()
                    if #arms > 0 then
                        local h = hrp()
                        if h then table.sort(arms, function(a, b) return ((worldPosOf(a) or h.Position) - h.Position).Magnitude < ((worldPosOf(b) or h.Position) - h.Position).Magnitude end) end
                        pcall(function() bossLabel:SetText((function()local Zatf=unpack or table.unpack;local Sq00_T={207,142,207,161,206,158,206,158,37,63,207,175,206,157,207,175,207,165,207,175,63,207,160,207,161,63,206,159,206,156,207,165,207,175,207,163,63,55};for i=1,#Sq00_T do Sq00_T[i]=bit32.bxor(Sq00_T[i],31) end;return string.char(Zatf(Sq00_T))end)() .. #arms .. ")") end)
                        orbitAndSwing(arms[1], keep)
                    else
                        local body = bossBodyPart()
                        if body then
                            pcall(function() bossLabel:SetText((function()local DY0J=unpack or table.unpack;local nkUmISNiN={207,142,207,161,206,158,206,158,37,63,207,175,206,157,207,175,207,165,207,175,63,207,160,207,161,63,207,174,207,161,206,158,206,158,206,156,63,55,207,162,207,170,206,157,63,206,159,206,156,207,165,54};for i=1,#nkUmISNiN do nkUmISNiN[i]=bit32.bxor(nkUmISNiN[i],31) end;return string.char(DY0J(nkUmISNiN))end)()) end)
                            orbitAndSwing(body, keep)
                        else
                            pcall(function() bossLabel:SetText((function()local chj1t=unpack or table.unpack;local mPnCHCe={207,142,207,161,206,158,206,158,37,63,207,161,207,169,207,167,207,171,207,175,207,162,207,167,207,170,63,55,206,158,207,163,207,170,207,162,207,175,63,206,155,207,175,207,168,206,148,54};for i=1,#mPnCHCe do mPnCHCe[i]=bit32.bxor(mPnCHCe[i],31) end;return string.char(chj1t(mPnCHCe))end)()) end); task.wait(0.5)
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
        pcall(function() crysLabel:SetText((function()local HLGAci=unpack or table.unpack;local PbJqawMX={207,133,206,159,207,167,206,158,206,157,207,175,207,164,207,164,206,148,37,63};for i=1,#PbJqawMX do PbJqawMX[i]=bit32.bxor(PbJqawMX[i],31) end;return string.char(HLGAci(PbJqawMX))end)() .. tostring(s and s.SakuraCrystals or 0)) end)
        task.wait(1)
    end
end)
task.spawn(function()
    while RUNNING do
        pcall(function()
            if inArena() then bossCountLabel:SetText((function()local UU_HC=unpack or table.unpack;local l0ILjkb={207,142,207,161,206,158,206,158,37,63,207,143,207,133,207,189,207,135,207,141,207,138,207,130,63,55,207,162,207,175,63,207,175,206,159,207,170,207,162,207,170,54};for i=1,#l0ILjkb do l0ILjkb[i]=bit32.bxor(l0ILjkb[i],31) end;return string.char(UU_HC(l0ILjkb))end)())
            else
                local secs = 1800 - Workspace:GetServerTimeNow() % 1800
                bossCountLabel:SetText(((function()local T_CGM=unpack or table.unpack;local Iz2sVg_1E={207,190,207,164,207,170,207,171,206,156,206,145,206,150,207,167,207,166,63,207,174,207,161,206,158,206,158,63,206,152,207,170,206,159,207,170,207,168,63,97,58,123,37,58,47,45,123};for i=1,#Iz2sVg_1E do Iz2sVg_1E[i]=bit32.bxor(Iz2sVg_1E[i],31) end;return string.char(T_CGM(Iz2sVg_1E))end)()):format(math.floor(secs / 60), math.floor(secs % 60)))
            end
        end)
        task.wait(1)
    end
end)
task.spawn(function()
    local pausedByBoss = false
    while RUNNING do
        if inArena() then
            if Toggles.se_selected and Toggles.se_selected.Value and not pausedByBoss then
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
                if p:IsA((function()local dwSx=unpack or table.unpack;local tuT8d49={93,126,108,122,79,126,109,107};for i=1,#tuT8d49 do tuT8d49[i]=bit32.bxor(tuT8d49[i],31) end;return string.char(dwSx(tuT8d49))end)()) and p.CanCollide then noclipped[p] = true; pcall(function() p.CanCollide = false end) end
            end
        else
            for p in pairs(noclipped) do if p and p.Parent then pcall(function() p.CanCollide = true end) end noclipped[p] = nil end
        end
    end
    task.spawn(function()
        local active = false
        while RUNNING do
            if on((function()local u9vO0=unpack or table.unpack;local ii9W486={108,122,64,125,112,108,108};for i=1,#ii9W486 do ii9W486[i]=bit32.bxor(ii9W486[i],31) end;return string.char(u9vO0(ii9W486))end)()) and inArena() then setNoclip(true); active = true
            elseif active then setNoclip(false); active = false end
            RunService.Stepped:Wait()
        end
        if active then setNoclip(false) end
    end)
end
local function bloomActive()
    local ends = Workspace:GetAttribute((function()local tFX7t=unpack or table.unpack;local WVTLrD={88,109,122,126,107,93,115,112,112,114,90,113,123,108,94,107};for i=1,#WVTLrD do WVTLrD[i]=bit32.bxor(WVTLrD[i],31) end;return string.char(tFX7t(WVTLrD))end)())
    return type(ends) == (function()local BiY0EU=unpack or table.unpack;local g5V_UXpK2j={113,106,114,125,122,109};for i=1,#g5V_UXpK2j do g5V_UXpK2j[i]=bit32.bxor(g5V_UXpK2j[i],31) end;return string.char(BiY0EU(g5V_UXpK2j))end)() and ends > os.time()
end
local function bloomGo() return on((function()local QWsFZ=unpack or table.unpack;local XYzwFANr={108,122,64,125,115,112,112,114};for i=1,#XYzwFANr do XYzwFANr[i]=bit32.bxor(XYzwFANr[i],31) end;return string.char(QWsFZ(XYzwFANr))end)()) and bloomActive() and stealAllowed() end
local lastBatAt = 0
task.spawn(function()
    while RUNNING do
        local ok = pcall(function()
            if not bloomGo() then return end
            setStatus((function()local s3kI5=unpack or table.unpack;local DJZnifxK={207,187,207,175,206,159,207,163,63,206,153,207,173,207,170,206,157,207,170,207,162,207,167,206,144};for i=1,#DJZnifxK do DJZnifxK[i]=bit32.bxor(DJZnifxK[i],31) end;return string.char(s3kI5(DJZnifxK))end)())
            if os.clock() - lastBatAt > 4 then lastBatAt = os.clock(); inv((function()local ZixXKZ=unpack or table.unpack;local RZoxEiu={72,122,126,109,93,126,107};for i=1,#RZoxEiu do RZoxEiu[i]=bit32.bxor(RZoxEiu[i],31) end;return string.char(ZixXKZ(RZoxEiu))end)(), lp:GetAttribute((function()local xv5mZJ=unpack or table.unpack;local EWUcjn9j7={94,109,122,126,86,123};for i=1,#EWUcjn9j7 do EWUcjn9j7[i]=bit32.bxor(EWUcjn9j7[i],31) end;return string.char(xv5mZJ(EWUcjn9j7))end)())) end
            for _, tree in ipairs(CollectionService:GetTagged((function()local wKvT=unpack or table.unpack;local khUEFk2m3v={76,126,116,106,109,126,93,115,112,112,114,75,109,122,122};for i=1,#khUEFk2m3v do khUEFk2m3v[i]=bit32.bxor(khUEFk2m3v[i],31) end;return string.char(wKvT(khUEFk2m3v))end)())) do
                if not bloomGo() then break end
                local okp, pos = pcall(function() return tree:GetPivot().Position end)
                if okp and pos then
                    lockMove()
                    setStatus((function()local CIyVp=unpack or table.unpack;local Pd1NI9li={93,115,112,112,114,37,63,206,156,207,171,207,175,206,159,206,148,63,207,160,207,161,63,207,171,207,170,206,159,207,170,207,173,206,156};for i=1,#Pd1NI9li do Pd1NI9li[i]=bit32.bxor(Pd1NI9li[i],31) end;return string.char(CIyVp(Pd1NI9li))end)())
                    Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_speed and Opt.se_speed.Value) or 200)
                    local t0 = os.clock()
                    while bloomGo() and tree.Parent and os.clock() - t0 < 15 do
                        fire((function()local Ao01mx=unpack or table.unpack;local vdr_ax={93,115,112,112,114,87,118,107};for i=1,#vdr_ax do vdr_ax[i]=bit32.bxor(vdr_ax[i],31) end;return string.char(Ao01mx(vdr_ax))end)(), tree); task.wait(0.5)
                    end
                    unlockMove()
                end
            end
            for _, crys in ipairs(CollectionService:GetTagged((function()local bO8eAP=unpack or table.unpack;local H_PMCO={76,126,116,106,109,126,92,109,102,108,107,126,115};for i=1,#H_PMCO do H_PMCO[i]=bit32.bxor(H_PMCO[i],31) end;return string.char(bO8eAP(H_PMCO))end)())) do
                if not bloomGo() then break end
                if crys:GetAttribute((function()local fWPI=unpack or table.unpack;local Z3WVDbqa_={80,104,113,122,109};for i=1,#Z3WVDbqa_ do Z3WVDbqa_[i]=bit32.bxor(Z3WVDbqa_[i],31) end;return string.char(fWPI(Z3WVDbqa_))end)()) == lp.UserId then
                    local okp, pos = pcall(function() return crys:GetPivot().Position end)
                    if okp and pos then
                        lockMove()
                        setStatus((function()local rf0T9=unpack or table.unpack;local hTWxCbW={93,115,112,112,114,37,63,206,158,207,174,207,161,206,159,63,207,165,206,159,207,167,206,158,206,157,207,175,207,164,207,164,207,175};for i=1,#hTWxCbW do hTWxCbW[i]=bit32.bxor(hTWxCbW[i],31) end;return string.char(rf0T9(hTWxCbW))end)())
                        Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_speed and Opt.se_speed.Value) or 200)
                        pcall(function() inv((function()local OtPcE=unpack or table.unpack;local yn4oDQ={93,115,112,112,114,88,126,107,119,122,109};for i=1,#yn4oDQ do yn4oDQ[i]=bit32.bxor(yn4oDQ[i],31) end;return string.char(OtPcE(yn4oDQ))end)(), crys) end)
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
        if on((function()local eSmDs=unpack or table.unpack;local sC9SBsDX={108,122,64,118,113,124,106,125,126,107,122};for i=1,#sC9SBsDX do sC9SBsDX[i]=bit32.bxor(sC9SBsDX[i],31) end;return string.char(eSmDs(sC9SBsDX))end)()) then
            local s = save()
            if s and type(s.Sakura) == (function()local ddLK=unpack or table.unpack;local XRE0Aq1C2={107,126,125,115,122};for i=1,#XRE0Aq1C2 do XRE0Aq1C2[i]=bit32.bxor(XRE0Aq1C2[i],31) end;return string.char(ddLK(XRE0Aq1C2))end)() then
                local sak = s.Sakura
                if not sak.Egg or sak.Egg == false then
                    for k, rec in pairs(myEggs()) do
                        if type(rec) == (function()local z6tY=unpack or table.unpack;local ekwG_YK6k={107,126,125,115,122};for i=1,#ekwG_YK6k do ekwG_YK6k[i]=bit32.bxor(ekwG_YK6k[i],31) end;return string.char(z6tY(ekwG_YK6k))end)() and rec.Placement == nil then inv((function()local MeRBt=unpack or table.unpack;local KfBelL={76,126,116,106,109,126,86,113,108,122,109,107};for i=1,#KfBelL do KfBelL[i]=bit32.bxor(KfBelL[i],31) end;return string.char(MeRBt(KfBelL))end)(), rec.Uid or k); break end
                    end
                else
                    local deposited = sak.Deposited or 0
                    local bal = s.SakuraCrystals or 0
                    if on((function()local yD717=unpack or table.unpack;local UvVj0unPR7={108,122,64,126,106,107,112,123,122,111,112,108,118,107};for i=1,#UvVj0unPR7 do UvVj0unPR7[i]=bit32.bxor(UvVj0unPR7[i],31) end;return string.char(yD717(UvVj0unPR7))end)()) and deposited < 1000 and bal > 0 then
                        local amt = math.min(1000 - deposited, bal)
                        if amt > 0 then inv((function()local ETs9C=unpack or table.unpack;local fXDh_VO={76,126,116,106,109,126,91,122,111,112,108,118,107};for i=1,#fXDh_VO do fXDh_VO[i]=bit32.bxor(fXDh_VO[i],31) end;return string.char(ETs9C(fXDh_VO))end)(), amt) end
                    elseif on((function()local nl98in=unpack or table.unpack;local S2RZxwza={108,122,64,126,106,107,112,114,106,107,126,107,122};for i=1,#S2RZxwza do S2RZxwza[i]=bit32.bxor(S2RZxwza[i],31) end;return string.char(nl98in(S2RZxwza))end)()) and deposited >= 1000 then
                        inv((function()local x3_Z=unpack or table.unpack;local X5iZ38Z={76,126,116,106,109,126,82,106,107,126,107,122};for i=1,#X5iZ38Z do X5iZ38Z[i]=bit32.bxor(X5iZ38Z[i],31) end;return string.char(x3_Z(X5iZ38Z))end)())
                    end
                end
            end
        end
        task.wait(2)
    end
end)
task.spawn(function()
    while RUNNING do
        if on((function()local oQ7VO=unpack or table.unpack;local ICVgz_Iff={108,122,64,126,106,107,112,121,106,108,122};for i=1,#ICVgz_Iff do ICVgz_Iff[i]=bit32.bxor(ICVgz_Iff[i],31) end;return string.char(oQ7VO(ICVgz_Iff))end)()) then
            pcall(function()
                local s = save()
                if not s then return end
                if s.FusionEggReward ~= nil or s.FusionLocked == true then
                    inv((function()local amsUYU=unpack or table.unpack;local W90noVa={89,106,108,122,89,118,113,118,108,119};for i=1,#W90noVa do W90noVa[i]=bit32.bxor(W90noVa[i],31) end;return string.char(amsUYU(W90noVa))end)()); task.wait(1.2)
                    return
                end
                if s.FusionInfoAcknowledged ~= true then inv((function()local hr3B3E=unpack or table.unpack;local x3b7Zzp={89,106,108,122,92,112,113,121,118,109,114};for i=1,#x3b7Zzp do x3b7Zzp[i]=bit32.bxor(x3b7Zzp[i],31) end;return string.char(hr3B3E(x3b7Zzp))end)()); task.wait(0.3) end
                local slots = s.FusionSlots or {}
                local inSlot, loaded = {}, 0
                for _, u in pairs(slots) do loaded = loaded + 1; if type(u) == (function()local ZmD4T=unpack or table.unpack;local dX6WPcb8={108,107,109,118,113,120};for i=1,#dX6WPcb8 do dX6WPcb8[i]=bit32.bxor(dX6WPcb8[i],31) end;return string.char(ZmD4T(dX6WPcb8))end)() then inSlot[u] = true end end
                if loaded >= 3 then
                    inv((function()local ap4MV=unpack or table.unpack;local m05NEw8I={89,106,108,122,93,122,120,118,113};for i=1,#m05NEw8I do m05NEw8I[i]=bit32.bxor(m05NEw8I[i],31) end;return string.char(ap4MV(m05NEw8I))end)()); task.wait(0.6)
                    inv((function()local dOISjd=unpack or table.unpack;local _qih9f={89,106,108,122,89,118,113,118,108,119};for i=1,#_qih9f do _qih9f[i]=bit32.bxor(_qih9f[i],31) end;return string.char(dOISjd(_qih9f))end)()); task.wait(1.2)
                    return
                end
                if type(s.Inventory) ~= (function()local HmvC=unpack or table.unpack;local fBSY4fivVL={107,126,125,115,122};for i=1,#fBSY4fivVL do fBSY4fivVL[i]=bit32.bxor(fBSY4fivVL[i],31) end;return string.char(HmvC(fBSY4fivVL))end)() then return end
                local equipped = {}
                for _, u in ipairs(s.EquippedAssets or {}) do equipped[u] = true end
                local g = {}
                for uid, item in pairs(s.Inventory) do
                    if type(item) == (function()local kouCr=unpack or table.unpack;local JIWfbrTX={107,126,125,115,122};for i=1,#JIWfbrTX do JIWfbrTX[i]=bit32.bxor(JIWfbrTX[i],31) end;return string.char(kouCr(JIWfbrTX))end)() and not equipped[uid] and not inSlot[uid]
                        and item.IsFavorite ~= true and item.InFuse ~= true and canFuseCat(item.Category) then
                        g[item.Category] = g[item.Category] or {}
                        table.insert(g[item.Category], uid)
                    end
                end
                local pick
                for _, uids in pairs(g) do if #uids >= 3 then pick = uids; break end end
                if not pick then setStatus((function()local rATUoF=unpack or table.unpack;local jq4IsFUtqd={207,130,207,170,206,157,63,206,157,206,159,207,161,207,166,207,165,207,167,63,207,171,207,164,206,144,63,206,158,207,164,207,167,206,144,207,162,207,167,206,144};for i=1,#jq4IsFUtqd do jq4IsFUtqd[i]=bit32.bxor(jq4IsFUtqd[i],31) end;return string.char(rATUoF(jq4IsFUtqd))end)()); return end
                setStatus((function()local tqw_Nx=unpack or table.unpack;local TkfnWbU={207,190,207,164,207,167,206,144,207,162,207,167,207,170,63,207,160,207,167,206,157,207,161,207,163,206,153,207,170,207,173};for i=1,#TkfnWbU do TkfnWbU[i]=bit32.bxor(TkfnWbU[i],31) end;return string.char(tqw_Nx(TkfnWbU))end)())
                for i = 1, 3 do inv((function()local DSZ93V=unpack or table.unpack;local TxIZBduaL={89,106,108,122,83,112,126,123};for i=1,#TxIZBduaL do TxIZBduaL[i]=bit32.bxor(TxIZBduaL[i],31) end;return string.char(DSZ93V(TxIZBduaL))end)(), pick[i]); task.wait(0.3) end
                task.wait(0.2)
                inv((function()local Ixsd8=unpack or table.unpack;local nS3W57P={89,106,108,122,93,122,120,118,113};for i=1,#nS3W57P do nS3W57P[i]=bit32.bxor(nS3W57P[i],31) end;return string.char(Ixsd8(nS3W57P))end)()); task.wait(0.6)
                inv((function()local yIpZ9=unpack or table.unpack;local muVfrgu9t={89,106,108,122,89,118,113,118,108,119};for i=1,#muVfrgu9t do muVfrgu9t[i]=bit32.bxor(muVfrgu9t[i],31) end;return string.char(yIpZ9(muVfrgu9t))end)()); task.wait(1.2)
            end)
        end
        task.wait(1)
    end
end)
local antiLagConn
local function applyAntiLagOne(o)
    if o:IsA((function()local uWjXZ=unpack or table.unpack;local FsKml_8={79,126,109,107,118,124,115,122,90,114,118,107,107,122,109};for i=1,#FsKml_8 do FsKml_8[i]=bit32.bxor(FsKml_8[i],31) end;return string.char(uWjXZ(FsKml_8))end)()) or o:IsA((function()local DZb51=unpack or table.unpack;local VRFj__DU={75,109,126,118,115};for i=1,#VRFj__DU do VRFj__DU[i]=bit32.bxor(VRFj__DU[i],31) end;return string.char(DZb51(VRFj__DU))end)()) or o:IsA((function()local VK1e=unpack or table.unpack;local vlnijgP03={93,122,126,114};for i=1,#vlnijgP03 do vlnijgP03[i]=bit32.bxor(vlnijgP03[i],31) end;return string.char(VK1e(vlnijgP03))end)()) then pcall(function() o.Enabled = false end)
    elseif o:IsA((function()local fzUAAK=unpack or table.unpack;local c6cVgkw={76,114,112,116,122};for i=1,#c6cVgkw do c6cVgkw[i]=bit32.bxor(c6cVgkw[i],31) end;return string.char(fzUAAK(c6cVgkw))end)()) or o:IsA((function()local UG60KT=unpack or table.unpack;local WAxtapENF={89,118,109,122};for i=1,#WAxtapENF do WAxtapENF[i]=bit32.bxor(WAxtapENF[i],31) end;return string.char(UG60KT(WAxtapENF))end)()) or o:IsA((function()local AuWocz=unpack or table.unpack;local zwbVO3={76,111,126,109,116,115,122,108};for i=1,#zwbVO3 do zwbVO3[i]=bit32.bxor(zwbVO3[i],31) end;return string.char(AuWocz(zwbVO3))end)()) then pcall(function() o:Destroy() end)
    elseif o:IsA((function()local FR_JAS=unpack or table.unpack;local GUXFWiYO={79,112,118,113,107,83,118,120,119,107};for i=1,#GUXFWiYO do GUXFWiYO[i]=bit32.bxor(GUXFWiYO[i],31) end;return string.char(FR_JAS(GUXFWiYO))end)()) or o:IsA((function()local N7LN=unpack or table.unpack;local KbiyDG={76,111,112,107,83,118,120,119,107};for i=1,#KbiyDG do KbiyDG[i]=bit32.bxor(KbiyDG[i],31) end;return string.char(N7LN(KbiyDG))end)()) or o:IsA((function()local zLwZs=unpack or table.unpack;local orV1wNWlz={76,106,109,121,126,124,122,83,118,120,119,107};for i=1,#orV1wNWlz do orV1wNWlz[i]=bit32.bxor(orV1wNWlz[i],31) end;return string.char(zLwZs(orV1wNWlz))end)()) then pcall(function() o.Enabled = false end)
    elseif o:IsA((function()local oaJp=unpack or table.unpack;local eIaZZpCef_={93,126,108,122,79,126,109,107};for i=1,#eIaZZpCef_ do eIaZZpCef_[i]=bit32.bxor(eIaZZpCef_[i],31) end;return string.char(oaJp(eIaZZpCef_))end)()) then pcall(function() o.Material = Enum.Material.SmoothPlastic end); pcall(function() o.Reflectance = 0 end); pcall(function() o.CastShadow = false end)
    elseif o:IsA((function()local ZbnASV=unpack or table.unpack;local q8LlVxXP={91,122,124,126,115};for i=1,#q8LlVxXP do q8LlVxXP[i]=bit32.bxor(q8LlVxXP[i],31) end;return string.char(ZbnASV(q8LlVxXP))end)()) or o:IsA((function()local NrBF=unpack or table.unpack;local u19sY4={75,122,103,107,106,109,122};for i=1,#u19sY4 do u19sY4[i]=bit32.bxor(u19sY4[i],31) end;return string.char(NrBF(u19sY4))end)()) then pcall(function() o.Transparency = 1 end) end
end
local function setAntiLag(state)
    if antiLagConn then antiLagConn:Disconnect(); antiLagConn = nil end
    if not state then return end
    pcall(function() Lighting.GlobalShadows = false end)
    pcall(function() Lighting.FogEnd = 9e9 end)
    pcall(function() Lighting.FogStart = 9e9 end)
    pcall(function() settings().Rendering.QualityLevel = 1 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04 end)
    for _, e in ipairs(Lighting:GetDescendants()) do if e:IsA((function()local hKQd=unpack or table.unpack;local FmrEcVK3AV={79,112,108,107,90,121,121,122,124,107};for i=1,#FmrEcVK3AV do FmrEcVK3AV[i]=bit32.bxor(FmrEcVK3AV[i],31) end;return string.char(hKQd(FmrEcVK3AV))end)()) or e:IsA((function()local xzMoLJ=unpack or table.unpack;local VksTdWD={94,107,114,112,108,111,119,122,109,122};for i=1,#VksTdWD do VksTdWD[i]=bit32.bxor(VksTdWD[i],31) end;return string.char(xzMoLJ(VksTdWD))end)()) or e:IsA((function()local jsr1BN=unpack or table.unpack;local xAImgOQA={92,115,112,106,123,108};for i=1,#xAImgOQA do xAImgOQA[i]=bit32.bxor(xAImgOQA[i],31) end;return string.char(jsr1BN(xAImgOQA))end)()) then pcall(function() e.Enabled = false end) end end
    pcall(function() Workspace.Clouds.Enabled = false end)
    pcall(function() local t = Workspace.Terrain; t.WaterWaveSize = 0; t.WaterWaveSpeed = 0; t.WaterReflectance = 0; t.WaterTransparency = 1; t.Decoration = false end)
    antiLagConn = Workspace.DescendantAdded:Connect(function(o) if RUNNING and on((function()local Ce4IBP=unpack or table.unpack;local dcuFY5jF={108,122,64,126,113,107,118,115,126,120};for i=1,#dcuFY5jF do dcuFY5jF[i]=bit32.bxor(dcuFY5jF[i],31) end;return string.char(Ce4IBP(dcuFY5jF))end)()) then applyAntiLagOne(o) end end)
    onClean(function() if antiLagConn then pcall(function() antiLagConn:Disconnect() end) end end)
    task.spawn(function()
        local n = 0
        for _, o in ipairs(Workspace:GetDescendants()) do
            if not on((function()local E0pLjs=unpack or table.unpack;local jOcAMHj={108,122,64,126,113,107,118,115,126,120};for i=1,#jOcAMHj do jOcAMHj[i]=bit32.bxor(jOcAMHj[i],31) end;return string.char(E0pLjs(jOcAMHj))end)()) then break end
            applyAntiLagOne(o); n = n + 1; if n % 500 == 0 then RunService.Heartbeat:Wait() end
        end
    end)
end
RunService.RenderStepped:Connect(function()
    if not RUNNING then return end
    local t = Opt.se_timelock and Opt.se_timelock.Value
    if t and t ~= "Off" then
        local ct = ({ Day = 14, Night = 0, Sunrise = 6.5, Sunset = 18 })[t]
        if ct then pcall(function() Lighting.ClockTime = ct end) end
    end
end)
local SettingsTab = Window:AddTab((function()local GLbW=unpack or table.unpack;local CJJLux6={207,130,207,175,206,158,206,157,206,159,207,161,207,166,207,165,207,167};for i=1,#CJJLux6 do CJJLux6[i]=bit32.bxor(CJJLux6[i],31) end;return string.char(GLbW(CJJLux6))end)(), (function()local RMJ0H=unpack or table.unpack;local mTTYteC8R={108,122,107,107,118,113,120,108};for i=1,#mTTYteC8R do mTTYteC8R[i]=bit32.bxor(mTTYteC8R[i],31) end;return string.char(RMJ0H(mTTYteC8R))end)())
local ProtBox = SettingsTab:AddLeftGroupbox((function()local e8tEH1=unpack or table.unpack;local LdfTb9mM={207,136,207,175,206,150,207,167,206,157,207,175};for i=1,#LdfTb9mM do LdfTb9mM[i]=bit32.bxor(LdfTb9mM[i],31) end;return string.char(e8tEH1(LdfTb9mM))end)())
ProtBox:AddToggle((function()local AGtG=unpack or table.unpack;local GXLXBoUci={108,122,64,126,113,107,118,126,121,116};for i=1,#GXLXBoUci do GXLXBoUci[i]=bit32.bxor(GXLXBoUci[i],31) end;return string.char(AGtG(GXLXBoUci))end)(), { Text = (function()local i43_A=unpack or table.unpack;local QNFDLDMZ={207,143,207,162,206,157,207,167,50,94,89,84};for i=1,#QNFDLDMZ do QNFDLDMZ[i]=bit32.bxor(QNFDLDMZ[i],31) end;return string.char(i43_A(QNFDLDMZ))end)(), Default = true })
ProtBox:AddToggle((function()local sgRAHb=unpack or table.unpack;local fNWkm5lmO={108,122,64,126,113,107,118,115,126,120};for i=1,#fNWkm5lmO do fNWkm5lmO[i]=bit32.bxor(fNWkm5lmO[i],31) end;return string.char(sgRAHb(fNWkm5lmO))end)(), { Text = (function()local YLXe=unpack or table.unpack;local W0ewtD={207,190,207,162,207,167,207,168,207,167,206,157,206,147,63,207,164,207,175,207,172,207,167};for i=1,#W0ewtD do W0ewtD[i]=bit32.bxor(W0ewtD[i],31) end;return string.char(YLXe(W0ewtD))end)(), Default = false, Callback = function(v) setAntiLag(v) end })
ProtBox:AddDropdown((function()local QqRJFj=unpack or table.unpack;local WUl49QECot={108,122,64,107,118,114,122,115,112,124,116};for i=1,#WUl49QECot do WUl49QECot[i]=bit32.bxor(WUl49QECot[i],31) end;return string.char(QqRJFj(WUl49QECot))end)(), { Values = { "Off", "Day", (function()local eSheaj=unpack or table.unpack;local tDkpwYn={81,118,120,119,107};for i=1,#tDkpwYn do tDkpwYn[i]=bit32.bxor(tDkpwYn[i],31) end;return string.char(eSheaj(tDkpwYn))end)(), (function()local pB583=unpack or table.unpack;local YCk1zViFeQ={76,106,113,109,118,108,122};for i=1,#YCk1zViFeQ do YCk1zViFeQ[i]=bit32.bxor(YCk1zViFeQ[i],31) end;return string.char(pB583(YCk1zViFeQ))end)(), (function()local iOITY=unpack or table.unpack;local jEjo3hm={76,106,113,108,122,107};for i=1,#jEjo3hm do jEjo3hm[i]=bit32.bxor(jEjo3hm[i],31) end;return string.char(iOITY(jEjo3hm))end)() }, Default = "Off", Text = (function()local DU9Zrw=unpack or table.unpack;local M7tjeAI={207,136,207,175,206,155,207,167,207,165,206,158,207,167,206,159,207,161,207,173,207,175,206,157,206,147,63,207,173,206,159,207,170,207,163,206,144};for i=1,#M7tjeAI do M7tjeAI[i]=bit32.bxor(M7tjeAI[i],31) end;return string.char(DU9Zrw(M7tjeAI))end)() })
local VirtualUser = cloneref(game:GetService((function()local VJlTc=unpack or table.unpack;local VnWc0FK={73,118,109,107,106,126,115,74,108,122,109};for i=1,#VnWc0FK do VnWc0FK[i]=bit32.bxor(VnWc0FK[i],31) end;return string.char(VJlTc(VnWc0FK))end)()))
lp.Idled:Connect(function()
    if RUNNING and on((function()local tZlwcI=unpack or table.unpack;local Vwe3myAv={108,122,64,126,113,107,118,126,121,116};for i=1,#Vwe3myAv do Vwe3myAv[i]=bit32.bxor(Vwe3myAv[i],31) end;return string.char(tZlwcI(Vwe3myAv))end)()) then pcall(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end) end
end)
local MenuBox = SettingsTab:AddRightGroupbox((function()local MgEMB=unpack or table.unpack;local yKwlmaK={207,131,207,170,207,162,206,145};for i=1,#yKwlmaK do yKwlmaK[i]=bit32.bxor(yKwlmaK[i],31) end;return string.char(MgEMB(yKwlmaK))end)())
MenuBox:AddButton({ Text = (function()local bLrcb=unpack or table.unpack;local DSx4P2={207,141,206,148,207,172,206,159,206,156,207,168,207,167,206,157,206,147};for i=1,#DSx4P2 do DSx4P2[i]=bit32.bxor(DSx4P2[i],31) end;return string.char(bLrcb(DSx4P2))end)(), Func = function()
    for _, k in ipairs({ (function()local ZIua=unpack or table.unpack;local Unmh4FA0LP={108,122,64,108,122,115,122,124,107,122,123};for i=1,#Unmh4FA0LP do Unmh4FA0LP[i]=bit32.bxor(Unmh4FA0LP[i],31) end;return string.char(ZIua(Unmh4FA0LP))end)(), (function()local GxvjeH=unpack or table.unpack;local Qj0xU1cE={108,122,64,125,115,112,112,114};for i=1,#Qj0xU1cE do Qj0xU1cE[i]=bit32.bxor(Qj0xU1cE[i],31) end;return string.char(GxvjeH(Qj0xU1cE))end)(), (function()local Z75bla=unpack or table.unpack;local ValJZRq5sU={108,122,64,118,113,124,106,125,126,107,122};for i=1,#ValJZRq5sU do ValJZRq5sU[i]=bit32.bxor(ValJZRq5sU[i],31) end;return string.char(Z75bla(ValJZRq5sU))end)(), (function()local a1g25=unpack or table.unpack;local fixw_Nw={108,122,64,107,111,104,126,115,116};for i=1,#fixw_Nw do fixw_Nw[i]=bit32.bxor(fixw_Nw[i],31) end;return string.char(a1g25(fixw_Nw))end)(), (function()local nGpmsC=unpack or table.unpack;local FB_0wXJQA={108,122,64,126,113,107,118,116,125};for i=1,#FB_0wXJQA do FB_0wXJQA[i]=bit32.bxor(FB_0wXJQA[i],31) end;return string.char(nGpmsC(FB_0wXJQA))end)(), (function()local sgdaK=unpack or table.unpack;local wtrKA3p={108,122,64,122,108,111};for i=1,#wtrKA3p do wtrKA3p[i]=bit32.bxor(wtrKA3p[i],31) end;return string.char(sgdaK(wtrKA3p))end)() }) do
        local t = Toggles[k]; if t then pcall(function() t:SetValue(false) end) end
    end
    pcall(function() if Opt.se_steps then Opt.se_steps:SetValue({}) end end)
    pcall(function() if _G.__CW_CLEAN then _G.__CW_CLEAN() end end)
    pcall(function() Library:Unload() end)
end })
MenuBox:AddLabel((function()local x_4GL=unpack or table.unpack;local yFt_jvV={207,128,207,170,206,159,207,170,207,165,207,164,206,145,206,152,207,167,206,157,206,147,63,207,163,207,170,207,162,206,145};for i=1,#yFt_jvV do yFt_jvV[i]=bit32.bxor(yFt_jvV[i],31) end;return string.char(x_4GL(yFt_jvV))end)()):AddKeyPicker((function()local tI2E9B=unpack or table.unpack;local bwk2a5E={82,122,113,106,84,122,102,125,118,113,123};for i=1,#bwk2a5E do bwk2a5E[i]=bit32.bxor(bwk2a5E[i],31) end;return string.char(tI2E9B(bwk2a5E))end)(), { Default = (function()local kCjia7=unpack or table.unpack;local B_QN0im9={77,118,120,119,107,76,119,118,121,107};for i=1,#B_QN0im9 do B_QN0im9[i]=bit32.bxor(B_QN0im9[i],31) end;return string.char(kCjia7(B_QN0im9))end)(), NoUI = true, Text = (function()local at7B=unpack or table.unpack;local H0IkauN9={207,128,207,170,206,159,207,170,207,165,207,164,206,145,206,152,207,167,206,157,206,147,63,207,163,207,170,207,162,206,145};for i=1,#H0IkauN9 do H0IkauN9[i]=bit32.bxor(H0IkauN9[i],31) end;return string.char(at7B(H0IkauN9))end)() })
Library.ToggleKeybind = Opt.MenuKeybind
SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ (function()local n1izR=unpack or table.unpack;local s35vGb8T={82,122,113,106,84,122,102,125,118,113,123};for i=1,#s35vGb8T do s35vGb8T[i]=bit32.bxor(s35vGb8T[i],31) end;return string.char(n1izR(s35vGb8T))end)(), (function()local qZOulw=unpack or table.unpack;local XZb0uH2k3={89,122,122,123,125,126,124,116,75,102,111,122};for i=1,#XZb0uH2k3 do XZb0uH2k3[i]=bit32.bxor(XZb0uH2k3[i],31) end;return string.char(qZOulw(XZb0uH2k3))end)(), (function()local GbRV=unpack or table.unpack;local weJDFV={89,122,122,123,125,126,124,116,82,108,120};for i=1,#weJDFV do weJDFV[i]=bit32.bxor(weJDFV[i],31) end;return string.char(GbRV(weJDFV))end)() })
ThemeManager:SetFolder((function()local j04k=unpack or table.unpack;local i_1ZD34x={79,106,125,87,106,125};for i=1,#i_1ZD34x do i_1ZD34x[i]=bit32.bxor(i_1ZD34x[i],31) end;return string.char(j04k(i_1ZD34x))end)())
SaveManager:SetFolder((function()local Bcykyd=unpack or table.unpack;local OT1xuiOtJz={79,106,125,87,106,125};for i=1,#OT1xuiOtJz do OT1xuiOtJz[i]=bit32.bxor(OT1xuiOtJz[i],31) end;return string.char(Bcykyd(OT1xuiOtJz))end)())
ThemeManager:ApplyToTab(SettingsTab)
pcall(function()
    Library.Scheme = Library.Scheme or {}
    local T = {
        BackgroundColor = Color3.fromRGB(13, 15, 26),
        MainColor       = Color3.fromRGB(18, 20, 34),
        AccentColor     = Color3.fromRGB(139, 92, 246),
        OutlineColor    = Color3.fromRGB(45, 48, 72),
        FontColor       = Color3.fromRGB(226, 232, 240),
        Font            = Enum.Font.Gotham,
    }
    for k, v in pairs(T) do
        pcall(function() Library.Scheme[k] = v end)
    end
    pcall(function() ThemeManager:ApplyTheme((function()local bfXs=unpack or table.unpack;local XIDQX4k1k_={91,122,121,126,106,115,107};for i=1,#XIDQX4k1k_ do XIDQX4k1k_[i]=bit32.bxor(XIDQX4k1k_[i],31) end;return string.char(bfXs(XIDQX4k1k_))end)()) end)
end)
SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadAutoloadConfig()
local DISCORD_INVITE = "https://discord.gg/pubhub"
local FEEDBACK_URL   = "https://YOUR-DOMAIN.com/feedback"
local FEEDBACK_VERSION = "pubhub-stealegg-2.0"
local _request = request or (syn and syn.request) or http_request
local function fbTrim(s) return (tostring(s or ""):gsub((function()local MB3uZ=unpack or table.unpack;local IpxDar3TM={65,58,108,53,55,49,50,54,58,108,53,59};for i=1,#IpxDar3TM do IpxDar3TM[i]=bit32.bxor(IpxDar3TM[i],31) end;return string.char(MB3uZ(IpxDar3TM))end)(), "%1")) end
local function fbHWID()
    local ok, id = pcall(function() return game:GetService((function()local UCpbM=unpack or table.unpack;local Tn9l0i8i={77,125,103,94,113,126,115,102,107,118,124,108,76,122,109,105,118,124,122};for i=1,#Tn9l0i8i do Tn9l0i8i[i]=bit32.bxor(Tn9l0i8i[i],31) end;return string.char(UCpbM(Tn9l0i8i))end)()):GetClientId() end)
    if ok and type(id) == (function()local jNoqo=unpack or table.unpack;local z6mV1rapZ={108,107,109,118,113,120};for i=1,#z6mV1rapZ do z6mV1rapZ[i]=bit32.bxor(z6mV1rapZ[i],31) end;return string.char(jNoqo(z6mV1rapZ))end)() and id ~= "" then return id end
    return tostring(lp and lp.UserId or 0)
end
local FB_HWID = fbHWID()
local FB_ERRMAP = {
    empty = (function()local B2QQC=unpack or table.unpack;local pwMQOOSfL={207,190,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170,63,207,160,206,156,206,158,206,157,207,161,207,170,49};for i=1,#pwMQOOSfL do pwMQOOSfL[i]=bit32.bxor(pwMQOOSfL[i],31) end;return string.char(B2QQC(pwMQOOSfL))end)(), no_links = (function()local dwxq6p=unpack or table.unpack;local NRLVnpmZ1I={207,190,206,158,206,148,207,164,207,165,207,167,63,207,162,207,170,63,206,159,207,175,207,168,206,159,207,170,206,151,207,170,207,162,206,148,49};for i=1,#NRLVnpmZ1I do NRLVnpmZ1I[i]=bit32.bxor(NRLVnpmZ1I[i],31) end;return string.char(dwxq6p(NRLVnpmZ1I))end)(),
    too_long = (function()local rmTPzr=unpack or table.unpack;local WGSBop6N={207,190,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170,63,206,158,207,164,207,167,206,151,207,165,207,161,207,163,63,207,171,207,164,207,167,207,162,207,162,207,161,207,170,63,55,207,163,207,175,207,165,206,158,207,167,207,163,206,156,207,163,63,42,47,47,63,206,158,207,167,207,163,207,173,207,161,207,164,207,161,207,173,54,49};for i=1,#WGSBop6N do WGSBop6N[i]=bit32.bxor(WGSBop6N[i],31) end;return string.char(rmTPzr(WGSBop6N))end)(),
    rate_limited = (function()local yT_u=unpack or table.unpack;local qcT7AvXUmZ={207,141,206,148,63,207,171,207,161,206,158,206,157,207,167,207,172,207,164,207,167,63,207,164,207,167,207,163,207,167,206,157,207,175,63,207,173,63,44,63,206,158,207,161,207,161,207,174,206,150,207,170,207,162,207,167,206,144,49,63,207,128,207,161,207,173,206,157,207,161,206,159,207,167,206,157,207,170,63,207,160,207,161,207,168,207,169,207,170,49};for i=1,#qcT7AvXUmZ do qcT7AvXUmZ[i]=bit32.bxor(qcT7AvXUmZ[i],31) end;return string.char(yT_u(qcT7AvXUmZ))end)(),
    busy = (function()local kP0p=unpack or table.unpack;local lPfFpviY7E={207,190,207,170,206,159,207,173,207,170,206,159,63,207,168,207,175,207,162,206,144,206,157,49,63,207,128,207,161,207,173,206,157,207,161,206,159,207,167,206,157,207,170,63,207,160,207,161,207,160,206,148,206,157,207,165,206,156,49};for i=1,#lPfFpviY7E do lPfFpviY7E[i]=bit32.bxor(lPfFpviY7E[i],31) end;return string.char(kP0p(lPfFpviY7E))end)(), banned = (function()local DNCa4=unpack or table.unpack;local MC5slrg={207,141,207,175,207,163,63,207,162,207,170,63,206,159,207,175,207,168,206,159,207,170,206,151,207,170,207,162,207,161,63,207,161,206,157,207,160,206,159,207,175,207,173,207,164,206,144,206,157,206,147,63,207,161,206,157,207,168,206,148,207,173,206,148,49};for i=1,#MC5slrg do MC5slrg[i]=bit32.bxor(MC5slrg[i],31) end;return string.char(DNCa4(MC5slrg))end)(),
    discord_error = (function()local SxAdjB=unpack or table.unpack;local bgI7hfzZF={207,129,206,157,207,160,206,159,207,175,207,173,207,165,207,175,63,207,162,207,170,63,206,156,207,171,207,175,207,164,207,175,206,158,206,147,49,63,207,128,207,161,207,173,206,157,207,161,206,159,207,167,206,157,207,170,63,207,160,207,161,207,160,206,148,206,157,207,165,206,156,49};for i=1,#bgI7hfzZF do bgI7hfzZF[i]=bit32.bxor(bgI7hfzZF[i],31) end;return string.char(SxAdjB(bgI7hfzZF))end)(), network = (function()local NEC4=unpack or table.unpack;local cQ5bKt={207,129,206,151,207,167,207,174,207,165,207,175,63,206,158,207,170,206,157,207,167,49};for i=1,#cQ5bKt do cQ5bKt[i]=bit32.bxor(cQ5bKt[i],31) end;return string.char(NEC4(cQ5bKt))end)(),
    no_request = (function()local k4ADU8=unpack or table.unpack;local pjkTiD4H1M={207,141,207,175,206,151,63,206,146,207,165,206,158,207,160,207,164,207,161,207,166,206,157,63,207,162,207,170,63,207,163,207,161,207,169,207,170,206,157,63,207,161,206,157,207,160,206,159,207,175,207,173,207,164,206,144,206,157,206,147,63,207,168,207,175,207,160,206,159,207,161,206,158,206,148,49};for i=1,#pjkTiD4H1M do pjkTiD4H1M[i]=bit32.bxor(pjkTiD4H1M[i],31) end;return string.char(k4ADU8(pjkTiD4H1M))end)(), bad_response = (function()local JrBKm=unpack or table.unpack;local W35BF7U6hS={207,190,207,170,206,159,207,173,207,170,206,159,63,207,173,207,170,206,159,207,162,206,156,207,164,63,207,162,207,170,207,161,207,169,207,167,207,171,207,175,207,162,207,162,206,148,207,166,63,207,161,206,157,207,173,207,170,206,157,49};for i=1,#W35BF7U6hS do W35BF7U6hS[i]=bit32.bxor(W35BF7U6hS[i],31) end;return string.char(JrBKm(W35BF7U6hS))end)(),
    unreachable = "Ваш эксплойт не может подключиться к серверу (ошибка TLS). Попробуйте другой эксплойт.",
}
local function sendFeedback(ftype, msg)
    if not _request then return false, (function()local GXYcEm=unpack or table.unpack;local SSCdCp={113,112,64,109,122,110,106,122,108,107};for i=1,#SSCdCp do SSCdCp[i]=bit32.bxor(SSCdCp[i],31) end;return string.char(GXYcEm(SSCdCp))end)() end
    local ok, res = pcall(function()
        return _request({
            Url = FEEDBACK_URL, Method = (function()local FRhL=unpack or table.unpack;local trFhH5S={79,80,76,75};for i=1,#trFhH5S do trFhH5S[i]=bit32.bxor(trFhH5S[i],31) end;return string.char(FRhL(trFhH5S))end)(),
            Headers = { [(function()local uLY5to=unpack or table.unpack;local FM7xLIL={92,112,113,107,122,113,107,50,75,102,111,122};for i=1,#FM7xLIL do FM7xLIL[i]=bit32.bxor(FM7xLIL[i],31) end;return string.char(uLY5to(FM7xLIL))end)()] = "application/json" },
            Body = HttpService:JSONEncode({
                type = ftype, message = msg, hwid = FB_HWID,
                placeId = tostring(game.PlaceId), username = lp and lp.Name or "?",
                version = FEEDBACK_VERSION,
            }),
        })
    end)
    if not ok or not res then return false, (function()local YGGl=unpack or table.unpack;local SFnBSZrT={113,122,107,104,112,109,116};for i=1,#SFnBSZrT do SFnBSZrT[i]=bit32.bxor(SFnBSZrT[i],31) end;return string.char(YGGl(SFnBSZrT))end)() end
    if type(res) == (function()local zFI7=unpack or table.unpack;local fqlLhZ={108,107,109,118,113,120};for i=1,#fqlLhZ do fqlLhZ[i]=bit32.bxor(fqlLhZ[i],31) end;return string.char(zFI7(fqlLhZ))end)() then return false, (function()local KpES=unpack or table.unpack;local f86Q9TkCJW={106,113,109,122,126,124,119,126,125,115,122};for i=1,#f86Q9TkCJW do f86Q9TkCJW[i]=bit32.bxor(f86Q9TkCJW[i],31) end;return string.char(KpES(f86Q9TkCJW))end)() end
    if type(res) ~= (function()local CcF3=unpack or table.unpack;local UbULyIvR={107,126,125,115,122};for i=1,#UbULyIvR do UbULyIvR[i]=bit32.bxor(UbULyIvR[i],31) end;return string.char(CcF3(UbULyIvR))end)() then return false, (function()local d8jXd=unpack or table.unpack;local r5gz4C={113,122,107,104,112,109,116};for i=1,#r5gz4C do r5gz4C[i]=bit32.bxor(r5gz4C[i],31) end;return string.char(d8jXd(r5gz4C))end)() end
    local code = res.StatusCode or res.status_code or res.Status or res.status
    if type(code) == (function()local E7Dk=unpack or table.unpack;local ScxaOAD={113,106,114,125,122,109};for i=1,#ScxaOAD do ScxaOAD[i]=bit32.bxor(ScxaOAD[i],31) end;return string.char(E7Dk(ScxaOAD))end)() and code ~= 200 and code ~= 201 and code ~= 204 then return false, "http_" .. tostring(code) end
    local body = res.Body or res.body
    if type(body) ~= (function()local mL7S=unpack or table.unpack;local DFEONj={108,107,109,118,113,120};for i=1,#DFEONj do DFEONj[i]=bit32.bxor(DFEONj[i],31) end;return string.char(mL7S(DFEONj))end)() or body == "" then return false, (function()local HboTHt=unpack or table.unpack;local OzftJG={125,126,123,64,109,122,108,111,112,113,108,122};for i=1,#OzftJG do OzftJG[i]=bit32.bxor(OzftJG[i],31) end;return string.char(HboTHt(OzftJG))end)() end
    local dok, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not dok or type(data) ~= (function()local L6HZ=unpack or table.unpack;local oQQ1M3zj={107,126,125,115,122};for i=1,#oQQ1M3zj do oQQ1M3zj[i]=bit32.bxor(oQQ1M3zj[i],31) end;return string.char(L6HZ(oQQ1M3zj))end)() then return false, (function()local lAJawa=unpack or table.unpack;local iNqMNR={125,126,123,64,109,122,108,111,112,113,108,122};for i=1,#iNqMNR do iNqMNR[i]=bit32.bxor(iNqMNR[i],31) end;return string.char(lAJawa(iNqMNR))end)() end
    if data.success == true then return true end
    return false, tostring(data.error or (function()local Nk2tR=unpack or table.unpack;local uZUl8uV={106,113,116,113,112,104,113};for i=1,#uZUl8uV do uZUl8uV[i]=bit32.bxor(uZUl8uV[i],31) end;return string.char(Nk2tR(uZUl8uV))end)())
end
local SuggestTab = Window:AddTab((function()local ZJ18sp=unpack or table.unpack;local tUVcDCHR={207,128,206,159,207,170,207,171,207,164,207,161,207,169,207,170,207,162,207,167,206,144};for i=1,#tUVcDCHR do tUVcDCHR[i]=bit32.bxor(tUVcDCHR[i],31) end;return string.char(ZJ18sp(tUVcDCHR))end)(), (function()local kMMv=unpack or table.unpack;local YxSrrqCQ={114,122,108,108,126,120,122,50,108,110,106,126,109,122};for i=1,#YxSrrqCQ do YxSrrqCQ[i]=bit32.bxor(YxSrrqCQ[i],31) end;return string.char(kMMv(YxSrrqCQ))end)())
local FG = SuggestTab:AddLeftGroupbox((function()local i03Oq=unpack or table.unpack;local ZssX8t6LtL={207,128,206,159,207,170,207,171,207,164,207,161,207,169,207,170,207,162,207,167,206,144,63,48,63,207,128,207,161,207,163,207,161,206,150,206,147};for i=1,#ZssX8t6LtL do ZssX8t6LtL[i]=bit32.bxor(ZssX8t6LtL[i],31) end;return string.char(i03Oq(ZssX8t6LtL))end)(), (function()local A4reg=unpack or table.unpack;local Z0VmZLJhU={114,122,108,108,126,120,122,50,108,110,106,126,109,122};for i=1,#Z0VmZLJhU do Z0VmZLJhU[i]=bit32.bxor(Z0VmZLJhU[i],31) end;return string.char(A4reg(Z0VmZLJhU))end)())
FG:AddDropdown((function()local baD4=unpack or table.unpack;local bJ5NqPyL={89,122,122,123,125,126,124,116,75,102,111,122};for i=1,#bJ5NqPyL do bJ5NqPyL[i]=bit32.bxor(bJ5NqPyL[i],31) end;return string.char(baD4(bJ5NqPyL))end)(), { Text = "Тип", Values = { (function()local smSg=unpack or table.unpack;local DjnnhU89={76,106,120,120,122,108,107,118,112,113};for i=1,#DjnnhU89 do DjnnhU89[i]=bit32.bxor(DjnnhU89[i],31) end;return string.char(smSg(DjnnhU89))end)(), "Bug", (function()local Xao2k=unpack or table.unpack;local k3UzaB={87,122,115,111};for i=1,#k3UzaB do k3UzaB[i]=bit32.bxor(k3UzaB[i],31) end;return string.char(Xao2k(k3UzaB))end)() }, Default = (function()local ftxK=unpack or table.unpack;local bYLbKAPBf={76,106,120,120,122,108,107,118,112,113};for i=1,#bYLbKAPBf do bYLbKAPBf[i]=bit32.bxor(bYLbKAPBf[i],31) end;return string.char(ftxK(bYLbKAPBf))end)(), Callback = function() end })
FG:AddInput((function()local WJpZY=unpack or table.unpack;local vSLoYIJ={89,122,122,123,125,126,124,116,82,108,120};for i=1,#vSLoYIJ do vSLoYIJ[i]=bit32.bxor(vSLoYIJ[i],31) end;return string.char(WJpZY(vSLoYIJ))end)(), { Default = "", Numeric = false, Finished = false, ClearTextOnFocus = false, Text = (function()local H9UE=unpack or table.unpack;local bsRNpn1={207,190,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170};for i=1,#bsRNpn1 do bsRNpn1[i]=bit32.bxor(bsRNpn1[i],31) end;return string.char(H9UE(bsRNpn1))end)(), Placeholder = (function()local h4bpg=unpack or table.unpack;local w_Xi3OJ={207,141,207,173,207,170,207,171,207,167,206,157,207,170,63,206,158,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170,63,55,207,163,207,175,207,165,206,158,207,167,207,163,206,156,207,163,63,42,47,47,63,206,158,207,167,207,163,207,173,207,161,207,164,207,161,207,173,51,63,207,174,207,170,207,168,63,206,158,206,158,206,148,207,164,207,161,207,165,54};for i=1,#w_Xi3OJ do w_Xi3OJ[i]=bit32.bxor(w_Xi3OJ[i],31) end;return string.char(h4bpg(w_Xi3OJ))end)() })
local fbStatus = FG:AddLabel("", true)
local FEEDBACK_COOLDOWN, lastFeedback = 20, 0
FG:AddButton({
    Text = (function()local M23u=unpack or table.unpack;local AcCH9ZPhX={207,129,206,157,207,160,206,159,207,175,207,173,207,167,206,157,206,147};for i=1,#AcCH9ZPhX do AcCH9ZPhX[i]=bit32.bxor(AcCH9ZPhX[i],31) end;return string.char(M23u(AcCH9ZPhX))end)(),
    Func = function()
        local now = tick()
        if now - lastFeedback < FEEDBACK_COOLDOWN then
            pcall(function() fbStatus:SetText(string.format((function()local pzyk=unpack or table.unpack;local fkO7_r={207,128,207,161,207,171,207,161,207,169,207,171,207,167,206,157,207,170,63,58,123,63,206,158,207,170,207,165,206,156,207,162,207,171,63,207,160,207,170,206,159,207,170,207,171,63,207,160,207,161,207,173,206,157,207,161,206,159,207,162,207,161,207,166,63,207,161,206,157,207,160,206,159,207,175,207,173,207,165,207,161,207,166,49};for i=1,#fkO7_r do fkO7_r[i]=bit32.bxor(fkO7_r[i],31) end;return string.char(pzyk(fkO7_r))end)(), math.ceil(FEEDBACK_COOLDOWN - (now - lastFeedback)))) end)
            return
        end
        local ftype = tostring((Opt.FeedbackType and Opt.FeedbackType.Value) or (function()local NL7HnE=unpack or table.unpack;local YccVSDrq={76,106,120,120,122,108,107,118,112,113};for i=1,#YccVSDrq do YccVSDrq[i]=bit32.bxor(YccVSDrq[i],31) end;return string.char(NL7HnE(YccVSDrq))end)()):lower()
        local msg = fbTrim((Opt.FeedbackMsg and Opt.FeedbackMsg.Value) or "")
        if msg == "" then pcall(function() fbStatus:SetText((function()local Yr7R=unpack or table.unpack;local UgZDAf6ff={207,190,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170,63,207,160,206,156,206,158,206,157,207,161,207,170,49};for i=1,#UgZDAf6ff do UgZDAf6ff[i]=bit32.bxor(UgZDAf6ff[i],31) end;return string.char(Yr7R(UgZDAf6ff))end)()) end); return end
        if #msg > 500 then pcall(function() fbStatus:SetText((function()local _K5O=unpack or table.unpack;local nJKAopFO={207,190,207,161,207,161,207,174,206,150,207,170,207,162,207,167,207,170,63,206,158,207,164,207,167,206,151,207,165,207,161,207,163,63,207,171,207,164,207,167,207,162,207,162,207,161,207,170,63,55,207,163,207,175,207,165,206,158,207,167,207,163,206,156,207,163,63,42,47,47,63,206,158,207,167,207,163,207,173,207,161,207,164,207,161,207,173,54,49};for i=1,#nJKAopFO do nJKAopFO[i]=bit32.bxor(nJKAopFO[i],31) end;return string.char(_K5O(nJKAopFO))end)()) end); return end
        local low = msg:lower()
        if low:find("http", 1, true) or low:find("discord.gg", 1, true) or low:find("www.", 1, true) or low:find(".gg/", 1, true) then
            pcall(function() fbStatus:SetText((function()local CYJu=unpack or table.unpack;local Ne4SoB5wE={207,190,206,158,206,148,207,164,207,165,207,167,63,207,162,207,170,63,206,159,207,175,207,168,206,159,207,170,206,151,207,170,207,162,206,148,49};for i=1,#Ne4SoB5wE do Ne4SoB5wE[i]=bit32.bxor(Ne4SoB5wE[i],31) end;return string.char(CYJu(Ne4SoB5wE))end)()) end); return
        end
        pcall(function() fbStatus:SetText((function()local NYR5=unpack or table.unpack;local QhHwawyUf={207,129,206,157,207,160,206,159,207,175,207,173,207,165,207,175,49,49,49};for i=1,#QhHwawyUf do QhHwawyUf[i]=bit32.bxor(QhHwawyUf[i],31) end;return string.char(NYR5(QhHwawyUf))end)()) end)
        task.spawn(function()
            local sok, err = sendFeedback(ftype, msg)
            if sok then
                lastFeedback = tick()
                pcall(function() fbStatus:SetText((function()local duTA=unpack or table.unpack;local lMcj2raoY={207,129,206,157,207,160,206,159,207,175,207,173,207,164,207,170,207,162,207,161,49,63,207,190,207,160,207,175,206,158,207,167,207,174,207,161,62};for i=1,#lMcj2raoY do lMcj2raoY[i]=bit32.bxor(lMcj2raoY[i],31) end;return string.char(duTA(lMcj2raoY))end)()) end)
                pcall(function() Opt.FeedbackMsg:SetValue("") end)
                notify((function()local l_2t4R=unpack or table.unpack;local UKsxfglc={207,141,207,175,206,151,63,207,161,206,157,207,168,206,148,207,173,63,207,161,206,157,207,160,206,159,207,175,207,173,207,164,207,170,207,162,49,63,207,190,207,160,207,175,206,158,207,167,207,174,207,161,62};for i=1,#UKsxfglc do UKsxfglc[i]=bit32.bxor(UKsxfglc[i],31) end;return string.char(l_2t4R(UKsxfglc))end)())
            else
                pcall(function() fbStatus:SetText(FB_ERRMAP[err] or ((function()local C95D=unpack or table.unpack;local JAxfGw9I={207,130,207,170,63,206,156,207,171,207,175,207,164,207,161,206,158,206,147,63,207,161,206,157,207,160,206,159,207,175,207,173,207,167,206,157,206,147,37,63};for i=1,#JAxfGw9I do JAxfGw9I[i]=bit32.bxor(JAxfGw9I[i],31) end;return string.char(C95D(JAxfGw9I))end)() .. tostring(err))) end)
            end
        end)
    end,
})
FG:AddLabel((function()local lZAl=unpack or table.unpack;local q1ardy={207,131,207,175,207,165,206,158,207,167,207,163,206,156,207,163,63,44,63,206,158,207,161,207,161,207,174,206,150,207,170,207,162,207,167,206,144,63,207,173,63,206,152,207,175,206,158,49,63,207,142,207,170,207,168,63,206,158,206,158,206,148,207,164,207,161,207,165,63,207,167,63,206,156,207,160,207,161,207,163,207,167,207,162,207,175,207,162,207,167,207,166,49};for i=1,#q1ardy do q1ardy[i]=bit32.bxor(q1ardy[i],31) end;return string.char(lZAl(q1ardy))end)(), true)
local HelpGroup = SuggestTab:AddRightGroupbox((function()local ifoqsS=unpack or table.unpack;local nYPvjY2uc={207,128,207,161,207,163,207,161,206,150,206,147,63,48,63,89,94,78};for i=1,#nYPvjY2uc do nYPvjY2uc[i]=bit32.bxor(nYPvjY2uc[i],31) end;return string.char(ifoqsS(nYPvjY2uc))end)(), (function()local PjSMS=unpack or table.unpack;local RgFsLdFk={115,118,121,122,50,125,106,112,102};for i=1,#RgFsLdFk do RgFsLdFk[i]=bit32.bxor(RgFsLdFk[i],31) end;return string.char(PjSMS(RgFsLdFk))end)())
HelpGroup:AddButton({
    Text = (function()local DqByG=unpack or table.unpack;local w3kwl2AUl={207,141,207,161,207,166,206,157,207,167,63,207,173,63,91,118,108,124,112,109,123};for i=1,#w3kwl2AUl do w3kwl2AUl[i]=bit32.bxor(w3kwl2AUl[i],31) end;return string.char(DqByG(w3kwl2AUl))end)(),
    Tooltip = DISCORD_INVITE,
    Func = function()
        pcall(function() setclipboard(DISCORD_INVITE) end)
        notify((function()local bqLgf=unpack or table.unpack;local tvSKcT2W={207,190,206,158,206,148,207,164,207,165,207,175,63,91,118,108,124,112,109,123,63,206,158,207,165,207,161,207,160,207,167,206,159,207,161,207,173,207,175,207,162,207,175,49,63,207,141,206,158,206,157,207,175,207,173,206,147,206,157,207,170,63,207,170,206,142,63,207,173,63,207,174,206,159,207,175,206,156,207,168,207,170,206,159,49};for i=1,#tvSKcT2W do tvSKcT2W[i]=bit32.bxor(tvSKcT2W[i],31) end;return string.char(bqLgf(tvSKcT2W))end)())
    end,
})
HelpGroup:AddDivider()
HelpGroup:AddLabel("Есть предложение или нашли баг?\nВыберите тип, введите сообщение и нажмите Отправить.", true)
notify((function()local DNf7w=unpack or table.unpack;local enTKg6L3={79,106,125,87,106,125,63,207,168,207,175,207,172,206,159,206,156,207,169,207,170,207,162};for i=1,#enTKg6L3 do enTKg6L3[i]=bit32.bxor(enTKg6L3[i],31) end;return string.char(DNf7w(enTKg6L3))end)())