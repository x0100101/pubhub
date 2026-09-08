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
local Window = Library:CreateWindow({ Title = (function()local WYUVdD=unpack or table.unpack;local F88dFM_MFe={84,113,102,76,113,102};for i=1,#F88dFM_MFe do F88dFM_MFe[i]=bit32.bxor(F88dFM_MFe[i],4) end;return string.char(WYUVdD(F88dFM_MFe))end)(), Footer = "v2.0", NotifySide = (function()local LyW6ZN=unpack or table.unpack;local B2Lugj={86,109,99,108,112};for i=1,#B2Lugj do B2Lugj[i]=bit32.bxor(B2Lugj[i],4) end;return string.char(LyW6ZN(B2Lugj))end)(), ShowCustomCursor = false, AutoShow = true, Size = UDim2.fromOffset(520, 440) })
pcall(function()
    local sg = Library.ScreenGui or (Library.Holder and Library.Holder.Parent)
    if sg and sg:IsA((function()local yOjt=unpack or table.unpack;local uSACEjJT={87,103,118,97,97,106,67,113,109};for i=1,#uSACEjJT do uSACEjJT[i]=bit32.bxor(uSACEjJT[i],4) end;return string.char(yOjt(uSACEjJT))end)()) then sg.Name = randomName(); hiddenParent(sg) end
end)
Opt, Toggles = Library.Options, Library.Toggles
local FPS_PAUSE_KEYS = { se_selected = true, se_bloom = true, se_incubate = true, se_autofuse = true, se_automutate = true, se_autodeposit = true, se_boss = true }
local function on(k) local t = Toggles[k]; local v = t and t.Value; if v and FPS_PAUSED and FPS_PAUSE_KEYS[k] then return false end; return v end
local function notify(m) pcall(function() Library:Notify({ Title = (function()local hpWsje=unpack or table.unpack;local kFUf8E0JR={84,113,102,76,113,102};for i=1,#kFUf8E0JR do kFUf8E0JR[i]=bit32.bxor(kFUf8E0JR[i],4) end;return string.char(hpWsje(kFUf8E0JR))end)(), Description = tostring(m), Time = 3 }) end) end
local function selSet(key)
    local dd = Opt[key]; local v = dd and dd.Value
    if type(v) ~= (function()local FSFQ=unpack or table.unpack;local PuF8nYk={112,101,102,104,97};for i=1,#PuF8nYk do PuF8nYk[i]=bit32.bxor(PuF8nYk[i],4) end;return string.char(FSFQ(PuF8nYk))end)() then return nil end
    local set, any = {}, false
    for k, val in pairs(v) do
        if val == true then set[k] = true; any = true elseif type(val) == (function()local Iuee=unpack or table.unpack;local SD5TvhLA={119,112,118,109,106,99};for i=1,#SD5TvhLA do SD5TvhLA[i]=bit32.bxor(SD5TvhLA[i],4) end;return string.char(Iuee(SD5TvhLA))end)() then set[val] = true; any = true end
    end
    return any and set or nil
end
local function step(name) local s = selSet((function()local R9TTT=unpack or table.unpack;local WyUG_P0={119,97,91,119,112,97,116,119};for i=1,#WyUG_P0 do WyUG_P0[i]=bit32.bxor(WyUG_P0[i],4) end;return string.char(R9TTT(WyUG_P0))end)()); return s and s[name] == true or false end
local Tab = Window:AddTab((function()local Xm3KP=unpack or table.unpack;local MFykuAr={212,158,213,132,212,180,212,178,212,180};for i=1,#MFykuAr do MFykuAr[i]=bit32.bxor(MFykuAr[i],4) end;return string.char(Xm3KP(MFykuAr))end)(), (function()local bj5Py8=unpack or table.unpack;local DjLL3APkQ={119,108,107,116,116,109,106,99,41,102,101,99};for i=1,#DjLL3APkQ do DjLL3APkQ[i]=bit32.bxor(DjLL3APkQ[i],4) end;return string.char(bj5Py8(DjLL3APkQ))end)())
local Box = Tab:AddLeftGroupbox((function()local Domp=unpack or table.unpack;local FpaODHqHCh={212,158,213,132,212,180,213,133,213,134,213,136,36,213,139,212,189,213,130,212,180};for i=1,#FpaODHqHCh do FpaODHqHCh[i]=bit32.bxor(FpaODHqHCh[i],4) end;return string.char(Domp(FpaODHqHCh))end)())
Box:AddDropdown((function()local zjAXm4=unpack or table.unpack;local iIlwkME5={119,97,91,101,118,97,101,119};for i=1,#iIlwkME5 do iIlwkME5[i]=bit32.bxor(iIlwkME5[i],4) end;return string.char(zjAXm4(iIlwkME5))end)(),     { Values = {}, Default = {}, Multi = true, AllowNull = true, Text = (function()local LBB6P=unpack or table.unpack;local FzJA0jS9O={212,147,212,186,212,185,213,143};for i=1,#FzJA0jS9O do FzJA0jS9O[i]=bit32.bxor(FzJA0jS9O[i],4) end;return string.char(LBB6P(FzJA0jS9O))end)() })
Box:AddDropdown((function()local npb_=unpack or table.unpack;local SdpZzazc={119,97,91,118,101,118,109,112,109,97,119};for i=1,#SdpZzazc do SdpZzazc[i]=bit32.bxor(SdpZzazc[i],4) end;return string.char(npb_(SdpZzazc))end)(),  { Values = RARITY_LIST, Default = {}, Multi = true, AllowNull = true, Text = (function()local zvQbAD=unpack or table.unpack;local wLnYNFjT7={212,164,212,177,212,176,212,190,212,186,213,133,213,134,212,188};for i=1,#wLnYNFjT7 do wLnYNFjT7[i]=bit32.bxor(wLnYNFjT7[i],4) end;return string.char(zvQbAD(wLnYNFjT7))end)() })
Box:AddDropdown((function()local nIvC=unpack or table.unpack;local z9DXK_Zn={119,97,91,105,113,112,101,112,109,107,106,119};for i=1,#z9DXK_Zn do z9DXK_Zn[i]=bit32.bxor(z9DXK_Zn[i],4) end;return string.char(nIvC(z9DXK_Zn))end)(), { Values = MUTATION_LIST, Default = {}, Multi = true, AllowNull = true, Text = (function()local bFWo=unpack or table.unpack;local ZkbgCfv_s8={212,152,213,135,213,134,212,180,213,130,212,188,212,188};for i=1,#ZkbgCfv_s8 do ZkbgCfv_s8[i]=bit32.bxor(ZkbgCfv_s8[i],4) end;return string.char(bFWo(ZkbgCfv_s8))end)() })
Box:AddDropdown((function()local hHIc=unpack or table.unpack;local aS8_bIT={119,97,91,116,118,109,107,118,109,112,125};for i=1,#aS8_bIT do aS8_bIT[i]=bit32.bxor(aS8_bIT[i],4) end;return string.char(hHIc(aS8_bIT))end)(),  { Values = { (function()local S4mWa=unpack or table.unpack;local r5YBvf={74,97,101,118,97,119,112};for i=1,#r5YBvf do r5YBvf[i]=bit32.bxor(r5YBvf[i],4) end;return string.char(S4mWa(r5YBvf))end)(), (function()local GjY9D=unpack or table.unpack;local pV6sh9p2={76,109,99,108,97,119,112,36,82,101,104,113,97};for i=1,#pV6sh9p2 do pV6sh9p2[i]=bit32.bxor(pV6sh9p2[i],4) end;return string.char(GjY9D(pV6sh9p2))end)(), (function()local m8uzz=unpack or table.unpack;local txU8hSFvA={76,109,99,108,97,119,112,36,83,97,109,99,108,112};for i=1,#txU8hSFvA do txU8hSFvA[i]=bit32.bxor(txU8hSFvA[i],4) end;return string.char(m8uzz(txU8hSFvA))end)() }, Default = (function()local gQ0I=unpack or table.unpack;local ZghDeGp8={74,97,101,118,97,119,112};for i=1,#ZghDeGp8 do ZghDeGp8[i]=bit32.bxor(ZghDeGp8[i],4) end;return string.char(gQ0I(ZghDeGp8))end)(), Text = (function()local uMczO=unpack or table.unpack;local YgvmpW={212,155,213,132,212,188,212,186,213,132,212,188,213,134,212,177,213,134,36,213,130,212,177,212,191,212,188};for i=1,#YgvmpW do YgvmpW[i]=bit32.bxor(YgvmpW[i],4) end;return string.char(uMczO(YgvmpW))end)() })
Box:AddToggle((function()local Mo44=unpack or table.unpack;local OKTaShI={119,97,91,119,97,104,97,103,112,97,96};for i=1,#OKTaShI do OKTaShI[i]=bit32.bxor(OKTaShI[i],4) end;return string.char(Mo44(OKTaShI))end)(),   { Text = (function()local FKbhx=unpack or table.unpack;local lzit4vTDDY={212,148,212,182,213,134,212,186,41,212,190,213,132,212,180,212,178,212,180};for i=1,#lzit4vTDDY do lzit4vTDDY[i]=bit32.bxor(lzit4vTDDY[i],4) end;return string.char(FKbhx(lzit4vTDDY))end)(), Default = false, Callback = function(v) if v then inv((function()local C8QhaF=unpack or table.unpack;local McHPnhLw={72,97,101,114,97,80,118,97,101,96};for i=1,#McHPnhLw do McHPnhLw[i]=bit32.bxor(McHPnhLw[i],4) end;return string.char(C8QhaF(McHPnhLw))end)()) end end })
Box:AddDropdown((function()local Vsfujm=unpack or table.unpack;local MzYqfJM={119,97,91,119,112,97,116,119};for i=1,#MzYqfJM do MzYqfJM[i]=bit32.bxor(MzYqfJM[i],4) end;return string.char(Vsfujm(MzYqfJM))end)(), { Values = { (function()local k6CjC=unpack or table.unpack;local DDt18Bn0={84,104,101,103,97};for i=1,#DDt18Bn0 do DDt18Bn0[i]=bit32.bxor(DDt18Bn0[i],4) end;return string.char(k6CjC(DDt18Bn0))end)(), (function()local cbKK=unpack or table.unpack;local ZDzzSmo={76,101,112,103,108};for i=1,#ZDzzSmo do ZDzzSmo[i]=bit32.bxor(ZDzzSmo[i],4) end;return string.char(cbKK(ZDzzSmo))end)(), (function()local auDiq=unpack or table.unpack;local iDzEMH7sf={87,97,104,104};for i=1,#iDzEMH7sf do iDzEMH7sf[i]=bit32.bxor(iDzEMH7sf[i],4) end;return string.char(auDiq(iDzEMH7sf))end)(), (function()local FPlD_x=unpack or table.unpack;local rIRviorUe={80,118,97,101,96,105,109,104,104};for i=1,#rIRviorUe do rIRviorUe[i]=bit32.bxor(rIRviorUe[i],4) end;return string.char(FPlD_x(rIRviorUe))end)() }, Default = {}, Multi = true, AllowNull = true, Text = (function()local v3OEOd=unpack or table.unpack;local uoMLwxvG={212,148,212,182,213,134,212,186,41,213,140,212,180,212,183,212,188,36,44,212,182,213,143,212,181,212,177,213,132,212,188,213,134,212,177,40,36,213,131,213,134,212,186,36,212,176,212,177,212,191,212,180,212,177,213,134,36,213,128,212,180,213,132,212,184,45};for i=1,#uoMLwxvG do uoMLwxvG[i]=bit32.bxor(uoMLwxvG[i],4) end;return string.char(v3OEOd(uoMLwxvG))end)() })
Box:AddDropdown((function()local XLw0OI=unpack or table.unpack;local RjhfHy={119,97,91,111,97,97,116,119,97,104,104};for i=1,#RjhfHy do RjhfHy[i]=bit32.bxor(RjhfHy[i],4) end;return string.char(XLw0OI(RjhfHy))end)(), { Values = RARITY_LIST, Multi = true, AllowNull = true, Default = { Legendary = true, Mythic = true, Rainbow = true, Cosmic = true, Exclusive = true, Secret = true, Exotic = true, Eternal = true, Limited = true, Superior = true, Divine = true }, Text = (function()local vU80Z1=unpack or table.unpack;local _r9Nfz2t={212,153,212,177,36,212,187,213,132,212,186,212,176,212,180,212,182,212,180,213,134,213,136,36,44,213,132,212,177,212,176,212,190,212,186,213,133,213,134,212,188,45};for i=1,#_r9Nfz2t do _r9Nfz2t[i]=bit32.bxor(_r9Nfz2t[i],4) end;return string.char(vU80Z1(_r9Nfz2t))end)() })
Box:AddToggle((function()local z5Pq1t=unpack or table.unpack;local bHBMDdIK={119,97,91,118,97,112,113,118,106};for i=1,#bHBMDdIK do bHBMDdIK[i]=bit32.bxor(bHBMDdIK[i],4) end;return string.char(z5Pq1t(bHBMDdIK))end)(),     { Text = (function()local xl10=unpack or table.unpack;local euDvWl={212,148,212,182,213,134,212,186,41,212,182,212,186,212,179,212,182,213,132,212,180,213,134,36,212,185,212,180,36,212,181,212,180,212,179,213,135};for i=1,#euDvWl do euDvWl[i]=bit32.bxor(euDvWl[i],4) end;return string.char(xl10(euDvWl))end)(), Default = true })
Box:AddButton({ Text = (function()local Mtklz=unpack or table.unpack;local YRAxXqNT={212,165,212,186,212,189,213,134,212,188,36,213,133,36,212,176,212,186,213,132,212,186,212,178,212,190,212,188};for i=1,#YRAxXqNT do YRAxXqNT[i]=bit32.bxor(YRAxXqNT[i],4) end;return string.char(Mtklz(YRAxXqNT))end)(), Func = function() inv((function()local zu36V=unpack or table.unpack;local rZc_kVGT={72,97,101,114,97,80,118,97,101,96};for i=1,#rZc_kVGT do rZc_kVGT[i]=bit32.bxor(rZc_kVGT[i],4) end;return string.char(zu36V(rZc_kVGT))end)()) end })
local InfoBox = Tab:AddRightGroupbox((function()local pfLmQ_=unpack or table.unpack;local N08oYxY={212,156,212,185,213,128,212,186};for i=1,#N08oYxY do N08oYxY[i]=bit32.bxor(N08oYxY[i],4) end;return string.char(pfLmQ_(N08oYxY))end)())
local statLabel = InfoBox:AddLabel((function()local StzJBh=unpack or table.unpack;local Cf9knHccsd={66,84,87,62,36,41};for i=1,#Cf9knHccsd do Cf9knHccsd[i]=bit32.bxor(Cf9knHccsd[i],4) end;return string.char(StzJBh(Cf9knHccsd))end)())
local stateLabel = InfoBox:AddLabel((function()local RQxKYq=unpack or table.unpack;local XO1leN3E={212,158,213,132,212,180,212,178,212,180,62,36,212,148,212,190,213,134,212,188,212,182,212,185,212,186};for i=1,#XO1leN3E do XO1leN3E[i]=bit32.bxor(XO1leN3E[i],4) end;return string.char(RQxKYq(XO1leN3E))end)())
InfoBox:AddButton({ Text = (function()local ojqJ=unpack or table.unpack;local WU_JH0b={212,155,212,177,213,132,212,177,213,133,212,190,212,180,212,185,212,188,213,132,212,186,212,182,212,180,213,134,213,136,36,212,179,212,186,212,185,213,143};for i=1,#WU_JH0b do WU_JH0b[i]=bit32.bxor(WU_JH0b[i],4) end;return string.char(ojqJ(WU_JH0b))end)(), Func = function()
    local areas = {}
    for _, m in ipairs(scanEggs()) do local r = eggRecord(m.Name); if r and r.AreaId then areas[r.AreaId] = true end end
    local al = {}; for k in pairs(areas) do al[#al + 1] = k end; table.sort(al)
    pcall(function() Opt.se_areas:SetValues(al) end)
    notify(#al .. (function()local Rn21My=unpack or table.unpack;local Oar4Q3g={36,212,179,212,186,212,185,36,212,185,212,180,212,189,212,176,212,177,212,185,212,186};for i=1,#Oar4Q3g do Oar4Q3g[i]=bit32.bxor(Oar4Q3g[i],4) end;return string.char(Rn21My(Oar4Q3g))end)())
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
    local old = c:FindFirstChildOfClass((function()local cKr1=unpack or table.unpack;local pVYfTvzpTt={76,113,105,101,106,107,109,96};for i=1,#pVYfTvzpTt do pVYfTvzpTt[i]=bit32.bxor(pVYfTvzpTt[i],4) end;return string.char(cKr1(pVYfTvzpTt))end)()); if not old then return end
    local new = Instance.new((function()local PDT4Q7=unpack or table.unpack;local wIV__M={76,113,105,101,106,107,109,96};for i=1,#wIV__M do wIV__M[i]=bit32.bxor(wIV__M[i],4) end;return string.char(PDT4Q7(wIV__M))end)())
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
        if d:GetAttribute((function()local bVRh=unpack or table.unpack;local IjnYPDN0={86,101,99,96,107,104,104,71,107,106,119,112,118,101,109,106,112};for i=1,#IjnYPDN0 do IjnYPDN0[i]=bit32.bxor(IjnYPDN0[i],4) end;return string.char(bVRh(IjnYPDN0))end)()) ~= nil or d:GetAttribute((function()local XHO1n=unpack or table.unpack;local Y7kBReCoqy={86,101,99,96,107,104,104,69,112,112,101,103,108,105,97,106,112};for i=1,#Y7kBReCoqy do Y7kBReCoqy[i]=bit32.bxor(Y7kBReCoqy[i],4) end;return string.char(XHO1n(Y7kBReCoqy))end)()) ~= nil then pcall(function() d:Destroy() end)
        elseif d:IsA((function()local VIpRcJ=unpack or table.unpack;local XTCCtf={73,107,112,107,118,50,64};for i=1,#XTCCtf do XTCCtf[i]=bit32.bxor(XTCCtf[i],4) end;return string.char(VIpRcJ(XTCCtf))end)()) and not d.Enabled then pcall(function() d.Enabled = true end) end
    end
    local hum = humanoid()
    if hum then if hum.PlatformStand then pcall(function() hum.PlatformStand = false end) end pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end) end
    local h = hrp()
    if h then pcall(function() h.CanCollide = true end); pcall(function() h.AssemblyLinearVelocity = Vector3.new(0, h.AssemblyLinearVelocity.Y, 0) end) end
end
local function getRoot(char)
    local h = char and char:FindFirstChildOfClass((function()local N2ktDt=unpack or table.unpack;local XliMCfNpU2={76,113,105,101,106,107,109,96};for i=1,#XliMCfNpU2 do XliMCfNpU2[i]=bit32.bxor(XliMCfNpU2[i],4) end;return string.char(N2ktDt(XliMCfNpU2))end)())
    return h and h.RootPart
end
local function suicide()
    local plr = lp
    local char = plr.Character
    local hum = char and char:FindFirstChildWhichIsA((function()local HQyO=unpack or table.unpack;local jaOBhxk_={76,113,105,101,106,107,109,96};for i=1,#jaOBhxk_ do jaOBhxk_[i]=bit32.bxor(jaOBhxk_[i],4) end;return string.char(HQyO(jaOBhxk_))end)())
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
        if type(p) == (function()local pkne=unpack or table.unpack;local v7WqMzG={112,101,102,104,97};for i=1,#v7WqMzG do v7WqMzG[i]=bit32.bxor(v7WqMzG[i],4) end;return string.char(pkne(v7WqMzG))end)() and (p.CarrierUserId == nil or p.CarrierUserId == lp.UserId) then
            fpCarrying = (p.IsCarrying == true); fpCarryUid = fpCarrying and p.Uid or nil
        end
    end)
end)
local function nearestForest()
    local h = hrp(); if not h then return nil end
    local best, bestD
    for _, m in ipairs(scanEggs()) do
        local r = eggRecord(m.Name)
        if r and r.AreaId == (function()local x20qs6=unpack or table.unpack;local _4R9aSdC1={66,107,118,97,119,112};for i=1,#_4R9aSdC1 do _4R9aSdC1[i]=bit32.bxor(_4R9aSdC1[i],4) end;return string.char(x20qs6(_4R9aSdC1))end)() and (not r.State or r.State == (function()local SJoR=unpack or table.unpack;local dgOcZPG={87,104,107,112};for i=1,#dgOcZPG do dgOcZPG[i]=bit32.bxor(dgOcZPG[i],4) end;return string.char(SJoR(dgOcZPG))end)()) then
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
        if ok and type(res) == (function()local MD7h0=unpack or table.unpack;local xyfLBU={112,101,102,104,97};for i=1,#xyfLBU do xyfLBU[i]=bit32.bxor(xyfLBU[i],4) end;return string.char(MD7h0(xyfLBU))end)() then body = res.Body or res.body end
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
        if cursor then url = url .. (function()local olmeY=unpack or table.unpack;local SIlJVCglx4={34,103,113,118,119,107,118,57};for i=1,#SIlJVCglx4 do SIlJVCglx4[i]=bit32.bxor(SIlJVCglx4[i],4) end;return string.char(olmeY(SIlJVCglx4))end)() .. cursor end
        local data = httpGetJson(url)
        if not data or type(data.data) ~= (function()local twHbm=unpack or table.unpack;local y6Fk1vu2n={112,101,102,104,97};for i=1,#y6Fk1vu2n do y6Fk1vu2n[i]=bit32.bxor(y6Fk1vu2n[i],4) end;return string.char(twHbm(y6Fk1vu2n))end)() then break end
        for _, s in ipairs(data.data) do
            scanned += 1
            if type(s.playing) == (function()local zqo8v=unpack or table.unpack;local vqV4RYlkDh={106,113,105,102,97,118};for i=1,#vqV4RYlkDh do vqV4RYlkDh[i]=bit32.bxor(vqV4RYlkDh[i],4) end;return string.char(zqo8v(vqV4RYlkDh))end)() and s.id ~= game.JobId and s.playing < (s.maxPlayers or 999) then
                list[#list + 1] = s
            end
        end
        if data.nextPageCursor and data.nextPageCursor ~= "" then cursor = data.nextPageCursor else break end
        task.wait(0.1)
    end
    if #list == 0 then
        notify(scanned == 0 and (function()local lmcaXR=unpack or table.unpack;local Ihqaym2={76,107,116,62,36,69,84,77,36,212,179,212,180,212,181,212,191,212,186,212,190,212,188,213,132,212,186,212,182,212,180,212,185,36,213,137,212,190,213,133,212,187,212,191,212,186,212,189,213,134,212,186,212,184,36,44,52,36,213,133,212,177,213,132,212,182,212,177,213,132,212,186,212,182,45};for i=1,#Ihqaym2 do Ihqaym2[i]=bit32.bxor(Ihqaym2[i],4) end;return string.char(lmcaXR(Ihqaym2))end)() or (function()local xC4ROI=unpack or table.unpack;local r2wd_D={76,107,116,62,36,212,185,212,177,213,134,36,212,176,212,186,213,133,213,134,213,135,212,187,212,185,212,186,212,183,212,186,36,213,133,212,177,213,132,212,182,212,177,213,132,212,180,40,36,212,187,212,186,212,182,213,134,212,186,213,132};for i=1,#r2wd_D do r2wd_D[i]=bit32.bxor(r2wd_D[i],4) end;return string.char(xC4ROI(r2wd_D))end)())
        hopping = false
        return
    end
    if pref == (function()local YzDd=unpack or table.unpack;local maCuniQTo={76,109,99,108,97,119,112,36,84,104,101,125,97,118,119};for i=1,#maCuniQTo do maCuniQTo[i]=bit32.bxor(maCuniQTo[i],4) end;return string.char(YzDd(maCuniQTo))end)() then table.sort(list, function(a, b) return a.playing > b.playing end)
    else table.sort(list, function(a, b) return a.playing < b.playing end) end
    notify(((function()local HFu_UF=unpack or table.unpack;local HYD8YP={76,107,116,62,36,212,185,212,180,212,189,212,176,212,177,212,185,212,186,36,213,133,212,177,213,132,212,182,212,177,213,132,212,186,212,182,62,36,33,96};for i=1,#HYD8YP do HYD8YP[i]=bit32.bxor(HYD8YP[i],4) end;return string.char(HFu_UF(HYD8YP))end)()):format(#list))
    local idx = 0
    local conn
    local function tryNext()
        idx = idx + 1
        local s = list[idx]
        if not s then if conn then conn:Disconnect() end; hopping = false; notify((function()local f_jXBd=unpack or table.unpack;local Onrq5W={76,107,116,62,36,212,182,213,133,212,177,36,212,185,212,177,213,135,212,176,212,180,213,131,212,185,212,186,40,36,212,187,212,186,212,182,213,134,212,186,213,132};for i=1,#Onrq5W do Onrq5W[i]=bit32.bxor(Onrq5W[i],4) end;return string.char(f_jXBd(Onrq5W))end)()); return end
        pcall(function() TeleportService:TeleportToPlaceInstance(placeId, s.id, lp) end)
    end
    conn = TeleportService.TeleportInitFailed:Connect(function(who)
        if who == lp then task.wait(0.5); tryNext() end
    end)
    tryNext()
    task.delay(25, function() if conn then conn:Disconnect() end; hopping = false end)
end
local VIM_SVC = game:GetService((function()local kFvS1=unpack or table.unpack;local ZYHgAVzj={82,109,118,112,113,101,104,77,106,116,113,112,73,101,106,101,99,97,118};for i=1,#ZYHgAVzj do ZYHgAVzj[i]=bit32.bxor(ZYHgAVzj[i],4) end;return string.char(kFvS1(ZYHgAVzj))end)())
local BAT_NUMKEYS = { Enum.KeyCode.One, Enum.KeyCode.Two, Enum.KeyCode.Three, Enum.KeyCode.Four, Enum.KeyCode.Five,
                      Enum.KeyCode.Six, Enum.KeyCode.Seven, Enum.KeyCode.Eight, Enum.KeyCode.Nine, Enum.KeyCode.Zero }
local function isBatTool(t)
    return t:IsA((function()local xPbB1=unpack or table.unpack;local W1wJfZMo={80,107,107,104};for i=1,#W1wJfZMo do W1wJfZMo[i]=bit32.bxor(W1wJfZMo[i],4) end;return string.char(xPbB1(W1wJfZMo))end)()) and (t:GetAttribute((function()local w13d=unpack or table.unpack;local NfiAaCJf={77,119,70,101,112};for i=1,#NfiAaCJf do NfiAaCJf[i]=bit32.bxor(NfiAaCJf[i],4) end;return string.char(w13d(NfiAaCJf))end)()) == true or t:FindFirstChild((function()local OYNF=unpack or table.unpack;local XAQU1B6={76,109,112,69,106,109,105};for i=1,#XAQU1B6 do XAQU1B6[i]=bit32.bxor(XAQU1B6[i],4) end;return string.char(OYNF(XAQU1B6))end)()) ~= nil
        or tostring(t.Name):lower():find("bat") ~= nil)
end
local function heldBat()
    local c = lp.Character; if not c then return false end
    for _, t in ipairs(c:GetChildren()) do if isBatTool(t) then return true end end
    return false
end
local function equipBatInput(silent)
    if heldBat() then return true end
    local bp = lp:FindFirstChildOfClass((function()local ONR4oN=unpack or table.unpack;local VHihq0R={70,101,103,111,116,101,103,111};for i=1,#VHihq0R do VHihq0R[i]=bit32.bxor(VHihq0R[i],4) end;return string.char(ONR4oN(VHihq0R))end)())
    local function owns() if bp then for _, t in ipairs(bp:GetChildren()) do if isBatTool(t) then return true end end end return false end
    if not owns() then
        local codex = Remotes and Remotes.Codex and Remotes.Codex.AskWearFieldBat
        if codex then pcall(function() codex:InvokeServer(lp:GetAttribute((function()local S_6sWY=unpack or table.unpack;local PJW__pZ={69,118,97,101,77,96};for i=1,#PJW__pZ do PJW__pZ[i]=bit32.bxor(PJW__pZ[i],4) end;return string.char(S_6sWY(PJW__pZ))end)())) end) end
        local t0 = os.clock(); while os.clock() - t0 < 1 and not (heldBat() or owns()) do task.wait(0.1) end
        if heldBat() then return true end
        if not owns() then if not silent then notify((function()local gpVy7=unpack or table.unpack;local ADY4nhzSl={212,153,212,177,213,134,36,212,181,212,188,213,134,213,143,36,212,176,212,191,213,139,36,213,137,212,190,212,188,212,187,212,188,213,132,212,186,212,182,212,190,212,188};for i=1,#ADY4nhzSl do ADY4nhzSl[i]=bit32.bxor(ADY4nhzSl[i],4) end;return string.char(gpVy7(ADY4nhzSl))end)()) end return false end
    end
    for i = 1, 10 do
        pcall(function()
            VIM_SVC:SendKeyEvent(true, BAT_NUMKEYS[i], false, game); task.wait(0.03)
            VIM_SVC:SendKeyEvent(false, BAT_NUMKEYS[i], false, game)
        end)
        task.wait(0.08)
        if heldBat() then if not silent then notify((function()local hGktu=unpack or table.unpack;local lf8qrB4={212,149,212,188,213,134,212,180,36,213,137,212,190,212,188,212,187,212,188,213,132,212,186,212,182,212,180,212,185,212,180,36,213,131,212,177,213,132,212,177,212,179,36,213,133,212,191,212,186,213,134,36,213,129,212,186,213,134,212,181,212,180,213,132,212,180,36};for i=1,#lf8qrB4 do lf8qrB4[i]=bit32.bxor(lf8qrB4[i],4) end;return string.char(hGktu(lf8qrB4))end)() .. (i == 10 and 0 or i)) end return true end
    end
    if not silent then notify((function()local uf98vM=unpack or table.unpack;local p5AgagfFD={212,158,212,191,212,180,212,182,212,188,213,140,212,188,36,213,129,212,186,213,134,212,181,212,180,213,132,212,180,36,212,185,212,177,36,213,133,213,132,212,180,212,181,212,186,213,134,212,180,212,191,212,188,36,41,36,212,176,212,177,213,132,212,178,212,188,213,134,212,177,36,212,186,212,190,212,185,212,186,36,86,107,102,104,107,124,36,212,180,212,190,213,134,212,188,212,182,212,185,213,143,212,184,36,212,188,36,212,187,212,186,212,182,213,134,212,186,213,132,212,188,213,134,212,177};for i=1,#p5AgagfFD do p5AgagfFD[i]=bit32.bxor(p5AgagfFD[i],4) end;return string.char(uf98vM(p5AgagfFD))end)()) end
    return false
end
local MoveBox = Tab:AddRightGroupbox((function()local ya7h=unpack or table.unpack;local Bcd4BN_ick={212,144,212,182,212,188,212,178,212,177,212,185,212,188,212,177};for i=1,#Bcd4BN_ick do Bcd4BN_ick[i]=bit32.bxor(Bcd4BN_ick[i],4) end;return string.char(ya7h(Bcd4BN_ick))end)())
MoveBox:AddToggle((function()local _39PI=unpack or table.unpack;local DJXKe2EJ={119,97,91,112,116,115,101,104,111};for i=1,#DJXKe2EJ do DJXKe2EJ[i]=bit32.bxor(DJXKe2EJ[i],4) end;return string.char(_39PI(DJXKe2EJ))end)(), { Text = (function()local sChF=unpack or table.unpack;local VQEGfgj={212,165,212,190,212,186,213,132,212,186,213,133,213,134,213,136,36,213,129,212,186,212,176,213,136,212,181,213,143};for i=1,#VQEGfgj do VQEGfgj[i]=bit32.bxor(VQEGfgj[i],4) end;return string.char(sChF(VQEGfgj))end)(), Default = true })
MoveBox:AddSlider((function()local CL3M=unpack or table.unpack;local qsB7ctU_={119,97,91,115,101,104,111};for i=1,#qsB7ctU_ do qsB7ctU_[i]=bit32.bxor(qsB7ctU_[i],4) end;return string.char(CL3M(qsB7ctU_))end)(),   { Text = (function()local owWzZ=unpack or table.unpack;local BNMeIwZg5E={212,165,212,190,212,186,213,132,212,186,213,133,213,134,213,136,36,213,129,212,186,212,176,213,136,212,181,213,143};for i=1,#BNMeIwZg5E do BNMeIwZg5E[i]=bit32.bxor(BNMeIwZg5E[i],4) end;return string.char(owWzZ(BNMeIwZg5E))end)(), Default = 409, Min = 0, Max = 1000, Rounding = 0 })
MoveBox:AddToggle((function()local Rwknj=unpack or table.unpack;local vlP80E={119,97,91,98,104,125};for i=1,#vlP80E do vlP80E[i]=bit32.bxor(vlP80E[i],4) end;return string.char(Rwknj(vlP80E))end)(), { Text = (function()local q27AKZ=unpack or table.unpack;local bVrr7vWql2={212,155,212,186,212,191,213,149,213,134};for i=1,#bVrr7vWql2 do bVrr7vWql2[i]=bit32.bxor(bVrr7vWql2[i],4) end;return string.char(q27AKZ(bVrr7vWql2))end)(), Default = false })
MoveBox:AddSlider((function()local b1wjp=unpack or table.unpack;local lYIujFN={119,97,91,98,104,125,119,116,97,97,96};for i=1,#lYIujFN do lYIujFN[i]=bit32.bxor(lYIujFN[i],4) end;return string.char(b1wjp(lYIujFN))end)(), { Text = (function()local oMnwr=unpack or table.unpack;local ESmP6C={212,165,212,190,212,186,213,132,212,186,213,133,213,134,213,136,36,212,187,212,186,212,191,213,149,213,134,212,180};for i=1,#ESmP6C do ESmP6C[i]=bit32.bxor(ESmP6C[i],4) end;return string.char(oMnwr(ESmP6C))end)(), Default = 60, Min = 20, Max = 1000, Rounding = 0 })
MoveBox:AddToggle((function()local skHCyg=unpack or table.unpack;local KX_TBIBbqe={119,97,91,101,106,112,109,111,102};for i=1,#KX_TBIBbqe do KX_TBIBbqe[i]=bit32.bxor(KX_TBIBbqe[i],4) end;return string.char(skHCyg(KX_TBIBbqe))end)(), { Text = (function()local hI01n6=unpack or table.unpack;local PlBXl2dRW6={212,148,212,185,213,134,212,188,41,212,186,213,134,212,181,213,132,212,180,213,133,213,143,212,182,212,180,212,185,212,188,212,177};for i=1,#PlBXl2dRW6 do PlBXl2dRW6[i]=bit32.bxor(PlBXl2dRW6[i],4) end;return string.char(hI01n6(PlBXl2dRW6))end)(), Default = true })
MoveBox:AddToggle((function()local kSrv4o=unpack or table.unpack;local KUArk4E={119,97,91,101,106,112,109,108,109,112};for i=1,#KUArk4E do KUArk4E[i]=bit32.bxor(KUArk4E[i],4) end;return string.char(kSrv4o(KUArk4E))end)(),    { Text = (function()local qaXm=unpack or table.unpack;local hoJzOi7={212,148,212,185,213,134,212,188,41,213,135,212,176,212,180,213,132,36,44,212,187,212,177,213,132,212,177,213,129,212,182,212,180,213,134,36,212,187,213,132,212,188,36,212,182,213,143,212,187,212,180,212,176,212,177,212,185,212,188,212,188,45};for i=1,#hoJzOi7 do hoJzOi7[i]=bit32.bxor(hoJzOi7[i],4) end;return string.char(qaXm(hoJzOi7))end)(), Default = true })
MoveBox:AddToggle((function()local ZVK2=unpack or table.unpack;local Q9auIpgM7R={119,97,91,97,119,116};for i=1,#Q9auIpgM7R do Q9auIpgM7R[i]=bit32.bxor(Q9auIpgM7R[i],4) end;return string.char(ZVK2(Q9auIpgM7R))end)(), { Text = (function()local A8sM=unpack or table.unpack;local iCqQcc9Q={65,87,84,36,213,139,212,188,213,130,36,44,212,182,213,133,212,177,36,213,139,212,189,213,130,212,180,45};for i=1,#iCqQcc9Q do iCqQcc9Q[i]=bit32.bxor(iCqQcc9Q[i],4) end;return string.char(A8sM(iCqQcc9Q))end)(), Default = false })
MoveBox:AddButton({ Text = (function()local iF6G=unpack or table.unpack;local Ss4k2TT2F={213,133,212,180,212,184,212,186,213,135,212,181,212,188,212,189,213,133,213,134,212,182,212,186};for i=1,#Ss4k2TT2F do Ss4k2TT2F[i]=bit32.bxor(Ss4k2TT2F[i],4) end;return string.char(iF6G(Ss4k2TT2F))end)(), Func = function() task.spawn(suicide) end })
local ServerBox = Tab:AddRightGroupbox((function()local WC7w=unpack or table.unpack;local x2UTd4q={212,165,212,177,213,132,212,182,212,177,213,132};for i=1,#x2UTd4q do x2UTd4q[i]=bit32.bxor(x2UTd4q[i],4) end;return string.char(WC7w(x2UTd4q))end)())
ServerBox:AddDropdown((function()local rnoc=unpack or table.unpack;local ji8mu88QU={119,97,91,108,107,116,116,118,97,98};for i=1,#ji8mu88QU do ji8mu88QU[i]=bit32.bxor(ji8mu88QU[i],4) end;return string.char(rnoc(ji8mu88QU))end)(), { Values = { (function()local _Gpvc8=unpack or table.unpack;local DTJaMG={72,107,115,97,119,112,36,84,104,101,125,97,118,119};for i=1,#DTJaMG do DTJaMG[i]=bit32.bxor(DTJaMG[i],4) end;return string.char(_Gpvc8(DTJaMG))end)(), (function()local iZXi=unpack or table.unpack;local LqodLoRlA6={76,109,99,108,97,119,112,36,84,104,101,125,97,118,119};for i=1,#LqodLoRlA6 do LqodLoRlA6[i]=bit32.bxor(LqodLoRlA6[i],4) end;return string.char(iZXi(LqodLoRlA6))end)() }, Default = (function()local zPp6s1=unpack or table.unpack;local a6eClH={72,107,115,97,119,112,36,84,104,101,125,97,118,119};for i=1,#a6eClH do a6eClH[i]=bit32.bxor(a6eClH[i],4) end;return string.char(zPp6s1(a6eClH))end)(), Text = (function()local IxyR=unpack or table.unpack;local IJlr6suj={212,153,212,180,213,133,213,134,213,132,212,186,212,189,212,190,212,180,36,212,187,212,177,213,132,212,177,213,129,212,186,212,176,212,180};for i=1,#IJlr6suj do IJlr6suj[i]=bit32.bxor(IJlr6suj[i],4) end;return string.char(IxyR(IJlr6suj))end)() })
ServerBox:AddButton({ Text = (function()local TFRT=unpack or table.unpack;local Fq0N3T={212,165,212,184,212,177,212,185,212,188,213,134,213,136,36,213,133,212,177,213,132,212,182,212,177,213,132};for i=1,#Fq0N3T do Fq0N3T[i]=bit32.bxor(Fq0N3T[i],4) end;return string.char(TFRT(Fq0N3T))end)(), Func = function()
    local pref = (Opt.se_hoppref and Opt.se_hoppref.Value) or (function()local ugXo=unpack or table.unpack;local g2rAEE3={72,107,115,97,119,112,36,84,104,101,125,97,118,119};for i=1,#g2rAEE3 do g2rAEE3[i]=bit32.bxor(g2rAEE3[i],4) end;return string.char(ugXo(g2rAEE3))end)()
    task.spawn(function() serverHop(pref) end)
end })
ServerBox:AddButton({ Text = (function()local LlpiCN=unpack or table.unpack;local J0IYLGwOdT={212,155,212,177,213,132,212,177,212,179,212,180,212,189,213,134,212,188};for i=1,#J0IYLGwOdT do J0IYLGwOdT[i]=bit32.bxor(J0IYLGwOdT[i],4) end;return string.char(LlpiCN(J0IYLGwOdT))end)(), Func = function()
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp) end)
end })
RunService.Heartbeat:Connect(function(dt)
    if not RUNNING or not on((function()local ZB9A=unpack or table.unpack;local uPVKmDzcMw={119,97,91,112,116,115,101,104,111};for i=1,#uPVKmDzcMw do uPVKmDzcMw[i]=bit32.bxor(uPVKmDzcMw[i],4) end;return string.char(ZB9A(uPVKmDzcMw))end)()) then return end
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
        flyGui = Instance.new((function()local LnnmQ=unpack or table.unpack;local Db0iHJMjej={87,103,118,97,97,106,67,113,109};for i=1,#Db0iHJMjej do Db0iHJMjej[i]=bit32.bxor(Db0iHJMjej[i],4) end;return string.char(LnnmQ(Db0iHJMjej))end)())
        flyGui.Name = randomName(); flyGui.ResetOnSpawn = false; flyGui.IgnoreGuiInset = true
        hiddenParent(flyGui)
        local function mk(t, yoff)
            local b = Instance.new((function()local VBKUqG=unpack or table.unpack;local jYr8v81MHy={80,97,124,112,70,113,112,112,107,106};for i=1,#jYr8v81MHy do jYr8v81MHy[i]=bit32.bxor(jYr8v81MHy[i],4) end;return string.char(VBKUqG(jYr8v81MHy))end)())
            b.Size = UDim2.new(0, 70, 0, 70); b.AnchorPoint = Vector2.new(1, 1)
            b.Position = UDim2.new(1, -20, 1, yoff); b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            b.BackgroundTransparency = 0.35; b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.TextScaled = true; b.Text = t; b.Parent = flyGui
            return b
        end
        local up, dn = mk("UP", -110), mk((function()local F3Q1=unpack or table.unpack;local lUSXGIkM={64,75,83,74};for i=1,#lUSXGIkM do lUSXGIkM[i]=bit32.bxor(lUSXGIkM[i],4) end;return string.char(F3Q1(lUSXGIkM))end)(), -28)
        up.MouseButton1Down:Connect(function() flyUp = true end); up.MouseButton1Up:Connect(function() flyUp = false end)
        dn.MouseButton1Down:Connect(function() flyDown = true end); dn.MouseButton1Up:Connect(function() flyDown = false end)
    elseif not make and flyGui then
        flyGui:Destroy(); flyGui = nil
    end
end
onClean(function() if flyGui then pcall(function() flyGui:Destroy() end); flyGui = nil end end)
RunService.Heartbeat:Connect(function(dt)
    if not RUNNING then return end
    if not on((function()local avArV=unpack or table.unpack;local N1JWjMGh={119,97,91,98,104,125};for i=1,#N1JWjMGh do N1JWjMGh[i]=bit32.bxor(N1JWjMGh[i],4) end;return string.char(avArV(N1JWjMGh))end)()) then
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
        if on((function()local GOesK=unpack or table.unpack;local OWlQ45a={119,97,91,101,106,112,109,111,102};for i=1,#OWlQ45a do OWlQ45a[i]=bit32.bxor(OWlQ45a[i],4) end;return string.char(GOesK(OWlQ45a))end)()) then
            local rt = lp:GetAttribute((function()local IMkqkm=unpack or table.unpack;local T8T10uIUS={86,101,99,96,107,104,104,65,106,96,80,109,105,97};for i=1,#T8T10uIUS do T8T10uIUS[i]=bit32.bxor(T8T10uIUS[i],4) end;return string.char(IMkqkm(T8T10uIUS))end)())
            local hum = humanoid()
            local ragged = (type(rt) == (function()local CM338H=unpack or table.unpack;local ghuaHS3={106,113,105,102,97,118};for i=1,#ghuaHS3 do ghuaHS3[i]=bit32.bxor(ghuaHS3[i],4) end;return string.char(CM338H(ghuaHS3))end)() and rt > Workspace:GetServerTimeNow()) or (hum and hum:GetState() == Enum.HumanoidStateType.Physics)
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
    if info.weight and r.AssetScale then lines[#lines + 1] = string.format((function()local se7JA=unpack or table.unpack;local KozFPjKk={33,42,54,98,36,111,99};for i=1,#KozFPjKk do KozFPjKk[i]=bit32.bxor(KozFPjKk[i],4) end;return string.char(se7JA(KozFPjKk))end)(), info.weight * (r.AssetScale ^ 3))
    elseif info.weight then lines[#lines + 1] = string.format((function()local DttgG=unpack or table.unpack;local DATkgQ5R2j={33,42,54,98,36,111,99};for i=1,#DATkgQ5R2j do DATkgQ5R2j[i]=bit32.bxor(DATkgQ5R2j[i],4) end;return string.char(DttgG(DATkgQ5R2j))end)(), info.weight) end
    if r.Mutations and #r.Mutations > 0 then lines[#lines + 1] = table.concat(r.Mutations, ", ") end
    return table.concat(lines, "\n"), (RARITY_COLOR[rar] or Color3.fromRGB(0, 255, 128))
end
local espCache = {}
local function makeEsp(m)
    local text, col = eggInfoText(m)
    local hl = Instance.new((function()local Raio=unpack or table.unpack;local wrFb3IUr={76,109,99,108,104,109,99,108,112};for i=1,#wrFb3IUr do wrFb3IUr[i]=bit32.bxor(wrFb3IUr[i],4) end;return string.char(Raio(wrFb3IUr))end)())
    hl.FillColor = col; hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.55; hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Adornee = m; hl.Parent = m
    local bb = Instance.new((function()local y2r_=unpack or table.unpack;local vIZenfCLf={70,109,104,104,102,107,101,118,96,67,113,109};for i=1,#vIZenfCLf do vIZenfCLf[i]=bit32.bxor(vIZenfCLf[i],4) end;return string.char(y2r_(vIZenfCLf))end)())
    bb.Name = randomName(); bb.Size = UDim2.fromOffset(190, 52); bb.StudsOffset = Vector3.new(0, 4, 0)
    bb.AlwaysOnTop = true; bb.Adornee = m.PrimaryPart or m:FindFirstChildWhichIsA((function()local k856xR=unpack or table.unpack;local RXDX87pW0={70,101,119,97,84,101,118,112};for i=1,#RXDX87pW0 do RXDX87pW0[i]=bit32.bxor(RXDX87pW0[i],4) end;return string.char(k856xR(RXDX87pW0))end)()); bb.Parent = m
    local tl = Instance.new((function()local Rw2Bm_=unpack or table.unpack;local WEqwN2={80,97,124,112,72,101,102,97,104};for i=1,#WEqwN2 do WEqwN2[i]=bit32.bxor(WEqwN2[i],4) end;return string.char(Rw2Bm_(WEqwN2))end)())
    tl.Size = UDim2.fromScale(1, 1); tl.BackgroundTransparency = 1; tl.TextColor3 = col
    tl.TextStrokeTransparency = 0.25; tl.Font = Enum.Font.GothamBold; tl.TextSize = 14; tl.Text = text; tl.Parent = bb
    return { hl = hl, bb = bb }
end
local function destroyEsp(e) pcall(function() e.hl:Destroy() end); pcall(function() e.bb:Destroy() end) end
onClean(function() for _, e in pairs(espCache) do destroyEsp(e) end; espCache = {} end)
task.spawn(function()
    while RUNNING do
        if on((function()local esR2=unpack or table.unpack;local rtA5fQf={119,97,91,97,119,116};for i=1,#rtA5fQf do rtA5fQf[i]=bit32.bxor(rtA5fQf[i],4) end;return string.char(esR2(rtA5fQf))end)()) then
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
    local wantAreas = selSet((function()local UEiRaJ=unpack or table.unpack;local plqahVI={119,97,91,101,118,97,101,119};for i=1,#plqahVI do plqahVI[i]=bit32.bxor(plqahVI[i],4) end;return string.char(UEiRaJ(plqahVI))end)())
    if wantAreas and not (r and r.AreaId and wantAreas[r.AreaId]) then return false end
    if useRarityMut then
        local wantRar = selSet((function()local LmoBVe=unpack or table.unpack;local S07zWuxC={119,97,91,118,101,118,109,112,109,97,119};for i=1,#S07zWuxC do S07zWuxC[i]=bit32.bxor(S07zWuxC[i],4) end;return string.char(LmoBVe(S07zWuxC))end)())
        if wantRar then
            local info = r and r.AssetCategory and assetInfo(r.AssetCategory)
            if not (info and info.rarity and wantRar[info.rarity]) then return false end
        end
        local wantMut = selSet((function()local sMi_Um=unpack or table.unpack;local cRMfUWzOCf={119,97,91,105,113,112,101,112,109,107,106,119};for i=1,#cRMfUWzOCf do cRMfUWzOCf[i]=bit32.bxor(cRMfUWzOCf[i],4) end;return string.char(sMi_Um(cRMfUWzOCf))end)())
        if wantMut and not eggHasMutation(uid, wantMut) then return false end
    end
    return true
end
local function sortByPriority(list)
    local pr = (Opt.se_priority and Opt.se_priority.Value) or (function()local gzQvC=unpack or table.unpack;local NJoz7co={74,97,101,118,97,119,112};for i=1,#NJoz7co do NJoz7co[i]=bit32.bxor(NJoz7co[i],4) end;return string.char(gzQvC(NJoz7co))end)()
    if pr == (function()local xW3g=unpack or table.unpack;local YHC8p1={76,109,99,108,97,119,112,36,82,101,104,113,97};for i=1,#YHC8p1 do YHC8p1[i]=bit32.bxor(YHC8p1[i],4) end;return string.char(xW3g(YHC8p1))end)() then
        local rk = {}; for _, m in ipairs(list) do local r = eggRecord(m.Name); rk[m] = eggRank(r and r.AssetCategory) end
        table.sort(list, function(a, b) return (rk[a] or 0) > (rk[b] or 0) end)
    elseif pr == (function()local TNnBz=unpack or table.unpack;local lrvIFVpoY7={76,109,99,108,97,119,112,36,83,97,109,99,108,112};for i=1,#lrvIFVpoY7 do lrvIFVpoY7[i]=bit32.bxor(lrvIFVpoY7[i],4) end;return string.char(TNnBz(lrvIFVpoY7))end)() then
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
        if step((function()local LDI_H=unpack or table.unpack;local vyMV7e2lI={84,104,101,103,97};for i=1,#vyMV7e2lI do vyMV7e2lI[i]=bit32.bxor(vyMV7e2lI[i],4) end;return string.char(LDI_H(vyMV7e2lI))end)()) then
            for k, rec in pairs(myEggs()) do
                if not step((function()local jg3BV=unpack or table.unpack;local aYLpH3Rg1={84,104,101,103,97};for i=1,#aYLpH3Rg1 do aYLpH3Rg1[i]=bit32.bxor(aYLpH3Rg1[i],4) end;return string.char(jg3BV(aYLpH3Rg1))end)()) then break end
                if type(rec) == (function()local tcojx=unpack or table.unpack;local kkMpcATn={112,101,102,104,97};for i=1,#kkMpcATn do kkMpcATn[i]=bit32.bxor(kkMpcATn[i],4) end;return string.char(tcojx(kkMpcATn))end)() and rec.Placement == nil then placeEgg(rec.Uid or k); task.wait(0.2) end
            end
        end
        if step((function()local beWoz=unpack or table.unpack;local UurhVZO={76,101,112,103,108};for i=1,#UurhVZO do UurhVZO[i]=bit32.bxor(UurhVZO[i],4) end;return string.char(beWoz(UurhVZO))end)()) then
            for k, rec in pairs(myEggs()) do
                if not step((function()local FinnM=unpack or table.unpack;local A5BCtu5={76,101,112,103,108};for i=1,#A5BCtu5 do A5BCtu5[i]=bit32.bxor(A5BCtu5[i],4) end;return string.char(FinnM(A5BCtu5))end)()) then break end
                local uid = rec and rec.Uid or k
                if type(rec) == (function()local fMCM=unpack or table.unpack;local DUyz9xKxtk={112,101,102,104,97};for i=1,#DUyz9xKxtk do DUyz9xKxtk[i]=bit32.bxor(DUyz9xKxtk[i],4) end;return string.char(fMCM(DUyz9xKxtk))end)() and rec.Placement ~= nil and eggReady(uid) then
                    pcall(EggState.BeginHatch, uid); task.wait(0.2)
                    pcall(EggState.FinishHatch, uid); task.wait(0.15)
                end
            end
        end
        if step((function()local XiOXl=unpack or table.unpack;local pMgKmIcMCM={87,97,104,104};for i=1,#pMgKmIcMCM do pMgKmIcMCM[i]=bit32.bxor(pMgKmIcMCM[i],4) end;return string.char(XiOXl(pMgKmIcMCM))end)()) then
            inv((function()local cIsDbZ=unpack or table.unpack;local g2Z7A2ajCb={65,117,113,109,116,70,97,119,112};for i=1,#g2Z7A2ajCb do g2Z7A2ajCb[i]=bit32.bxor(g2Z7A2ajCb[i],4) end;return string.char(cIsDbZ(g2Z7A2ajCb))end)())
            task.wait(3)
            local s = save()
            if s and type(s.Inventory) == (function()local QqG2=unpack or table.unpack;local vH32T2mC={112,101,102,104,97};for i=1,#vH32T2mC do vH32T2mC[i]=bit32.bxor(vH32T2mC[i],4) end;return string.char(QqG2(vH32T2mC))end)() then
                local equipped = {}
                for _, u in ipairs(s.EquippedAssets or {}) do equipped[u] = true end
                local sellList = {}
                local keepSet = selSet((function()local Ksb1=unpack or table.unpack;local bao2X3p={119,97,91,111,97,97,116,119,97,104,104};for i=1,#bao2X3p do bao2X3p[i]=bit32.bxor(bao2X3p[i],4) end;return string.char(Ksb1(bao2X3p))end)())
                for uid, item in pairs(s.Inventory) do
                    if type(item) == (function()local Ln2wj6=unpack or table.unpack;local WYefyUh={112,101,102,104,97};for i=1,#WYefyUh do WYefyUh[i]=bit32.bxor(WYefyUh[i],4) end;return string.char(Ln2wj6(WYefyUh))end)() and not equipped[uid] and item.IsFavorite ~= true and item.InFuse ~= true then
                        local protectedRarity = false
                        if keepSet then local rar = assetInfo(item.Category).rarity; protectedRarity = rar ~= nil and keepSet[rar] == true end
                        if not protectedRarity then sellList[#sellList + 1] = uid end
                    end
                end
                if #sellList > 0 then fire((function()local fR8DLp=unpack or table.unpack;local vw9RzG4b={87,97,104,104,84,97,112,119};for i=1,#vw9RzG4b do vw9RzG4b[i]=bit32.bxor(vw9RzG4b[i],4) end;return string.char(fR8DLp(vw9RzG4b))end)(), sellList) end
            end
        end
        task.wait(1)
    end
end)
local stolen = 0
task.spawn(function()
    while RUNNING do
        pcall(function() statLabel:SetText((function()local dKvkbZ=unpack or table.unpack;local ZXPFonnr={66,84,87,62,36};for i=1,#ZXPFonnr do ZXPFonnr[i]=bit32.bxor(ZXPFonnr[i],4) end;return string.char(dKvkbZ(ZXPFonnr))end)() .. fps) end)
        pcall(function()
            local disp
            if FPS_PAUSED then disp = (function()local XGsl=unpack or table.unpack;local rMD_5A={212,155,212,148,212,167,212,147,212,148,36,41,36,212,185,212,188,212,179,212,190,212,188,212,189,36,66,84,87,36,44};for i=1,#rMD_5A do rMD_5A[i]=bit32.bxor(rMD_5A[i],4) end;return string.char(XGsl(rMD_5A))end)() .. fps .. ")"
            elseif not stealAllowed() then disp = (function()local VmPh=unpack or table.unpack;local q1A441Bh={212,155,212,180,213,135,212,179,212,180,36,44,213,133,212,181,213,132,212,186,213,133,36,213,139,212,188,213,130,45};for i=1,#q1A441Bh do q1A441Bh[i]=bit32.bxor(q1A441Bh[i],4) end;return string.char(VmPh(q1A441Bh))end)()
            elseif os.clock() - statusHintAt < 2.5 then disp = statusHint
            elseif on((function()local YKJN=unpack or table.unpack;local yce26NtZC={119,97,91,119,97,104,97,103,112,97,96};for i=1,#yce26NtZC do yce26NtZC[i]=bit32.bxor(yce26NtZC[i],4) end;return string.char(YKJN(yce26NtZC))end)()) or on((function()local s4jEc0=unpack or table.unpack;local _HvJ7GfIu8={119,97,91,102,104,107,107,105};for i=1,#_HvJ7GfIu8 do _HvJ7GfIu8[i]=bit32.bxor(_HvJ7GfIu8[i],4) end;return string.char(s4jEc0(_HvJ7GfIu8))end)()) then disp = (function()local c4IZNK=unpack or table.unpack;local iVaZwsHqQ={212,148,212,190,213,134,212,188,212,182,212,185,212,186};for i=1,#iVaZwsHqQ do iVaZwsHqQ[i]=bit32.bxor(iVaZwsHqQ[i],4) end;return string.char(c4IZNK(iVaZwsHqQ))end)()
            else disp = (function()local ulXS=unpack or table.unpack;local Rz5PNL5h={212,154,212,178,212,188,212,176,212,180,212,185,212,188,212,177};for i=1,#Rz5PNL5h do Rz5PNL5h[i]=bit32.bxor(Rz5PNL5h[i],4) end;return string.char(ulXS(Rz5PNL5h))end)() end
            stateLabel:SetText((function()local NKByj=unpack or table.unpack;local EZlepDp0Gw={212,165,213,134,212,180,213,134,213,135,213,133,62,36};for i=1,#EZlepDp0Gw do EZlepDp0Gw[i]=bit32.bxor(EZlepDp0Gw[i],4) end;return string.char(NKByj(EZlepDp0Gw))end)() .. tostring(disp))
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
    local r = Workspace:FindFirstChild((function()local WIgD=unpack or table.unpack;local wdRPLnXw_={91,91,71,104,109,97,106,112,80,118,97,101,96,105,109,104,104,86,97,106,96,97,118,119};for i=1,#wdRPLnXw_ do wdRPLnXw_[i]=bit32.bxor(wdRPLnXw_[i],4) end;return string.char(WIgD(wdRPLnXw_))end)()); if not r then return nil end
    local h = hrp(); local hp = h and h.Position
    local best, bestD
    for _, p in ipairs(r:GetDescendants()) do
        if p:IsA((function()local mP_nh=unpack or table.unpack;local GvaxsKg8P4={70,101,119,97,84,101,118,112};for i=1,#GvaxsKg8P4 do GvaxsKg8P4[i]=bit32.bxor(GvaxsKg8P4[i],4) end;return string.char(mP_nh(GvaxsKg8P4))end)()) and (p.Name == (function()local tLt5=unpack or table.unpack;local d8nX6daSsY={70,97,104,112};for i=1,#d8nX6daSsY do d8nX6daSsY[i]=bit32.bxor(d8nX6daSsY[i],4) end;return string.char(tLt5(d8nX6daSsY))end)() or p.Name == (function()local qACTKC=unpack or table.unpack;local lBCqCqU={86,113,106,106,97,118};for i=1,#lBCqCqU do lBCqCqU[i]=bit32.bxor(lBCqCqU[i],4) end;return string.char(qACTKC(lBCqCqU))end)() or p.Name == "Top" or p.Name == (function()local hMxOf=unpack or table.unpack;local bKs_6F9={66,104,107,107,118};for i=1,#bKs_6F9 do bKs_6F9[i]=bit32.bxor(bKs_6F9[i],4) end;return string.char(hMxOf(bKs_6F9))end)() or p.Name == (function()local _yoF_F=unpack or table.unpack;local _rzZ_Q={80,118,97,101,96};for i=1,#_rzZ_Q do _rzZ_Q[i]=bit32.bxor(_rzZ_Q[i],4) end;return string.char(_yoF_F(_rzZ_Q))end)()) then
            local d = hp and (p.Position - hp).Magnitude or 0
            if not bestD or d < bestD then bestD = d; best = p end
        end
    end
    if best then return best end
    for _, m in ipairs(r:GetChildren()) do if m:IsA((function()local DmOHL=unpack or table.unpack;local I6pKfMD={73,107,96,97,104};for i=1,#I6pKfMD do I6pKfMD[i]=bit32.bxor(I6pKfMD[i],4) end;return string.char(DmOHL(I6pKfMD))end)()) then local p = m.PrimaryPart or m:FindFirstChildWhichIsA((function()local AZRXgU=unpack or table.unpack;local yUf02lJfal={70,101,119,97,84,101,118,112};for i=1,#yUf02lJfal do yUf02lJfal[i]=bit32.bxor(yUf02lJfal[i],4) end;return string.char(AZRXgU(yUf02lJfal))end)(), true); if p then return p end end end
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
    local part = treadTop(); if not part then setStatus((function()local _u66AC=unpack or table.unpack;local nEOYYyL={212,144,212,186,213,132,212,186,212,178,212,190,212,180,36,212,185,212,177,36,212,185,212,180,212,189,212,176,212,177,212,185,212,180};for i=1,#nEOYYyL do nEOYYyL[i]=bit32.bxor(nEOYYyL[i],4) end;return string.char(_u66AC(nEOYYyL))end)()); return end
    setStatus((function()local DLLd=unpack or table.unpack;local rMFsamjj={212,156,212,176,213,135,36,212,190,36,212,176,212,186,213,132,212,186,212,178,212,190,212,177};for i=1,#rMFsamjj do rMFsamjj[i]=bit32.bxor(rMFsamjj[i],4) end;return string.char(DLLd(rMFsamjj))end)())
    Nav.tweenTo3D(part.Position + Vector3.new(0, 3, 0), function() return RUNNING and on((function()local JYvaPQ=unpack or table.unpack;local l61LMVSEr={119,97,91,119,97,104,97,103,112,97,96};for i=1,#l61LMVSEr do l61LMVSEr[i]=bit32.bxor(l61LMVSEr[i],4) end;return string.char(JYvaPQ(l61LMVSEr))end)()) and step((function()local yHgrQ=unpack or table.unpack;local Xi6orN={80,118,97,101,96,105,109,104,104};for i=1,#Xi6orN do Xi6orN[i]=bit32.bxor(Xi6orN[i],4) end;return string.char(yHgrQ(Xi6orN))end)()) and not targetEggsExist() end, (Opt.se_speed and Opt.se_speed.Value) or 300)
    if targetEggsExist() then return end
    if TREAD and TREAD.AskWearStill then pcall(function() TREAD.AskWearStill:InvokeServer() end) end
    onTread = true
    setStatus((function()local ku9jjZ=unpack or table.unpack;local eENfCapFd={212,153,212,180,36,212,176,212,186,213,132,212,186,212,178,212,190,212,177,36,44,212,185,212,177,213,134,36,213,139,212,188,213,130,45};for i=1,#eENfCapFd do eENfCapFd[i]=bit32.bxor(eENfCapFd[i],4) end;return string.char(ku9jjZ(eENfCapFd))end)())
end
task.spawn(function()
    while RUNNING do
        if on((function()local XKCyjJ=unpack or table.unpack;local hzMiW2QVRI={119,97,91,119,97,104,97,103,112,97,96};for i=1,#hzMiW2QVRI do hzMiW2QVRI[i]=bit32.bxor(hzMiW2QVRI[i],4) end;return string.char(XKCyjJ(hzMiW2QVRI))end)()) and stealAllowed() and targetEggsExist() then
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
            if not on((function()local C7b3z=unpack or table.unpack;local XV7uJq={119,97,91,119,97,104,97,103,112,97,96};for i=1,#XV7uJq do XV7uJq[i]=bit32.bxor(XV7uJq[i],4) end;return string.char(C7b3z(XV7uJq))end)()) then leaveTread(); return end
            if not stealAllowed() then setStatus((function()local Wmhf7=unpack or table.unpack;local dR0f03B={212,155,212,180,213,135,212,179,212,180,36,44,213,133,212,181,213,132,212,186,213,133,36,213,139,212,188,213,130,45};for i=1,#dR0f03B do dR0f03B[i]=bit32.bxor(dR0f03B[i],4) end;return string.char(Wmhf7(dR0f03B))end)()); return end
            local list = {}
            for _, m in ipairs(scanEggs()) do if passesFilters(m.Name, true) then list[#list + 1] = m end end
            if #list == 0 then
                if step((function()local eRA5j=unpack or table.unpack;local zl2YNg={80,118,97,101,96,105,109,104,104};for i=1,#zl2YNg do zl2YNg[i]=bit32.bxor(zl2YNg[i],4) end;return string.char(eRA5j(zl2YNg))end)()) then mountTread() else forceDoff(); setStatus((function()local kaTG=unpack or table.unpack;local zsRs_t={212,154,212,178,212,188,212,176,212,180,212,185,212,188,212,177,36,213,139,212,188,213,130};for i=1,#zsRs_t do zsRs_t[i]=bit32.bxor(zsRs_t[i],4) end;return string.char(kaTG(zsRs_t))end)()) end
                return
            end
            forceDoff()
            sortByPriority(list)
            local keepGoing = function() return on((function()local S8egAT=unpack or table.unpack;local L5KiTOq0_5={119,97,91,119,97,104,97,103,112,97,96};for i=1,#L5KiTOq0_5 do L5KiTOq0_5[i]=bit32.bxor(L5KiTOq0_5[i],4) end;return string.char(S8egAT(L5KiTOq0_5))end)()) and stealAllowed() end
            local m = list[1]
            local uid = m.Name
            local speed = (Opt.se_speed and Opt.se_speed.Value) or 300
            local okp, pos = pcall(function() return m:GetPivot().Position end)
            if not okp or not pos then return end
            lockMove()
            local fr = nearestForest()
            if not fr then setStatus((function()local Marb=unpack or table.unpack;local VxVv2g={212,153,212,177,213,134,36,212,191,212,177,213,133,212,185,212,186,212,183,212,186,36,213,139,212,189,213,130,212,180,36,212,176,212,191,213,139,36,212,187,212,186,212,176,212,183,212,186,213,134,212,186,212,182,212,190,212,188};for i=1,#VxVv2g do VxVv2g[i]=bit32.bxor(VxVv2g[i],4) end;return string.char(Marb(VxVv2g))end)()); unlockMove(); return end
            setStatus((function()local K3V1rU=unpack or table.unpack;local opvKq3={212,155,212,186,212,176,212,183,212,186,213,134,212,186,212,182,212,190,212,180,62,36,212,191,212,177,213,133,212,185,212,186,212,177,36,213,139,212,189,213,130,212,186};for i=1,#opvKq3 do opvKq3[i]=bit32.bxor(opvKq3[i],4) end;return string.char(K3V1rU(opvKq3))end)())
            travelOutToEgg(fr.pos, keepGoing, 400)
            do local t0 = os.clock(); while os.clock() - t0 < 1.5 do grabEgg(fr.m, fr.uid); if fpCarrying or fieldEggModel(fr.uid) == nil then break end; task.wait(0.15) end end
            setStatus((function()local ShPt_2=unpack or table.unpack;local HuNtMHA={212,146,212,176,213,135,36,213,135,212,176,212,180,213,132,212,180,36,212,190,213,135,213,132,212,188,213,130,213,143,42,42,42};for i=1,#HuNtMHA do HuNtMHA[i]=bit32.bxor(HuNtMHA[i],4) end;return string.char(ShPt_2(HuNtMHA))end)())
            local RAG = { [Enum.HumanoidStateType.Physics] = true, [Enum.HumanoidStateType.Ragdoll] = true, [Enum.HumanoidStateType.FallingDown] = true }
            local hit, conns, wasCarry = false, {}, fpCarrying
            local hum0 = humanoid()
            if hum0 then conns[#conns + 1] = hum0.StateChanged:Connect(function(_, s) if RAG[s] then hit = true end end) end
            local ch = lp.Character
            if ch then conns[#conns + 1] = ch.DescendantAdded:Connect(function(d)
                if d:IsA((function()local Nsky5=unpack or table.unpack;local QgHPv9Ug={70,101,104,104,87,107,103,111,97,112,71,107,106,119,112,118,101,109,106,112};for i=1,#QgHPv9Ug do QgHPv9Ug[i]=bit32.bxor(QgHPv9Ug[i],4) end;return string.char(Nsky5(QgHPv9Ug))end)()) or d:IsA((function()local utGl=unpack or table.unpack;local iAvC8vT9h={76,109,106,99,97,71,107,106,119,112,118,101,109,106,112};for i=1,#iAvC8vT9h do iAvC8vT9h[i]=bit32.bxor(iAvC8vT9h[i],4) end;return string.char(utGl(iAvC8vT9h))end)()) then hit = true
                elseif d:IsA((function()local UR_xF8=unpack or table.unpack;local bkcS8hLBJJ={69,112,112,101,103,108,105,97,106,112};for i=1,#bkcS8hLBJJ do bkcS8hLBJJ[i]=bit32.bxor(bkcS8hLBJJ[i],4) end;return string.char(UR_xF8(bkcS8hLBJJ))end)()) and tostring(d.Name):find((function()local QIXxJ=unpack or table.unpack;local qIZIlVsM1={86,101,99,96,107,104,104};for i=1,#qIZIlVsM1 do qIZIlVsM1[i]=bit32.bxor(qIZIlVsM1[i],4) end;return string.char(QIXxJ(qIZIlVsM1))end)()) then hit = true end
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
            if not hit then setStatus((function()local WABi5=unpack or table.unpack;local g5wooOvmb={212,167,212,176,212,180,213,132,36,212,185,212,177,36,212,186,212,181,212,185,212,180,213,132,213,135,212,178,212,177,212,185,36,212,179,212,180,36,54,49,213,133};for i=1,#g5wooOvmb do g5wooOvmb[i]=bit32.bxor(g5wooOvmb[i],4) end;return string.char(WABi5(g5wooOvmb))end)()); unlockMove(); return end
            tpTo(pos); clearRagdoll()
            setStatus((function()local ttpfT=unpack or table.unpack;local Egoy70etMW={212,158,213,132,212,180,212,178,212,180,36,213,130,212,177,212,191,212,188};for i=1,#Egoy70etMW do Egoy70etMW[i]=bit32.bxor(Egoy70etMW[i],4) end;return string.char(ttpfT(Egoy70etMW))end)())
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
            if not haveIt() then setStatus((function()local QGHc6X=unpack or table.unpack;local wNjJDxh5P={212,153,212,177,36,213,135,212,176,212,180,212,191,212,186,213,133,213,136,36,213,133,213,129,212,182,212,180,213,134,212,188,213,134,213,136,36,213,130,212,177,212,191,213,136};for i=1,#wNjJDxh5P do wNjJDxh5P[i]=bit32.bxor(wNjJDxh5P[i],4) end;return string.char(QGHc6X(wNjJDxh5P))end)()); unlockMove(); return end
            stolen = stolen + 1
            if on((function()local iV3dK=unpack or table.unpack;local p1dQ1c={119,97,91,118,97,112,113,118,106};for i=1,#p1dQ1c do p1dQ1c[i]=bit32.bxor(p1dQ1c[i],4) end;return string.char(iV3dK(p1dQ1c))end)()) then
                local retSpeed = on((function()local r2ax0g=unpack or table.unpack;local lcQTrKBxwE={119,97,91,112,116,115,101,104,111};for i=1,#lcQTrKBxwE do lcQTrKBxwE[i]=bit32.bxor(lcQTrKBxwE[i],4) end;return string.char(r2ax0g(lcQTrKBxwE))end)()) and ((Opt.se_walk and Opt.se_walk.Value) or 409) or speed
                local delivered, guard = false, os.clock()
                while keepGoing() and not delivered and os.clock() - guard < 45 do
                    clearRagdoll()
                    if not fpCarrying then
                        local em = fieldEggModel(uid)
                        if not em then delivered = true; break end
                        if not on((function()local WPHZ9l=unpack or table.unpack;local gW7_P8g4t={119,97,91,101,106,112,109,108,109,112};for i=1,#gW7_P8g4t do gW7_P8g4t[i]=bit32.bxor(gW7_P8g4t[i],4) end;return string.char(WPHZ9l(gW7_P8g4t))end)()) then setStatus((function()local Wk_Lq=unpack or table.unpack;local acmHoB1={212,171,212,189,213,130,212,186,36,212,182,213,143,212,187,212,180,212,191,212,186,36,44,212,180,212,185,213,134,212,188,41,213,135,212,176,212,180,213,132,36,212,182,213,143,212,190,212,191,45};for i=1,#acmHoB1 do acmHoB1[i]=bit32.bxor(acmHoB1[i],4) end;return string.char(Wk_Lq(acmHoB1))end)()); break end
                        setStatus((function()local xLg6PR=unpack or table.unpack;local MdwPWvv={212,171,212,189,213,130,212,186,36,212,182,213,143,212,187,212,180,212,191,212,186,36,41,58,36,212,182,212,186,212,179,212,182,213,132,212,180,213,141,212,180,213,138,213,133,213,136,36,212,179,212,180,36,212,185,212,188,212,184};for i=1,#MdwPWvv do MdwPWvv[i]=bit32.bxor(MdwPWvv[i],4) end;return string.char(xLg6PR(MdwPWvv))end)())
                        local gg = os.clock()
                        while keepGoing() and not fpCarrying and fieldEggModel(uid) and os.clock() - gg < 8 do
                            clearRagdoll()
                            local em2 = fieldEggModel(uid)
                            local ep = em2 and select(2, pcall(function() return em2:GetPivot().Position end))
                            local h = hrp()
                            if h and typeof(ep) == (function()local rf9h=unpack or table.unpack;local uYkYSSR5={82,97,103,112,107,118,55};for i=1,#uYkYSSR5 do uYkYSSR5[i]=bit32.bxor(uYkYSSR5[i],4) end;return string.char(rf9h(uYkYSSR5))end)() then
                                local flat = Vector3.new(ep.X, h.Position.Y, ep.Z)
                                if (flat - h.Position).Magnitude > 4 then h.CFrame = CFrame.new(flat) * (h.CFrame - h.CFrame.Position); h.AssemblyLinearVelocity = Vector3.zero end
                            end
                            grabEgg(em2 or em, uid); task.wait(0.15)
                        end
                    else
                        setStatus((function()local YaQAW=unpack or table.unpack;local G6X47PeoI={212,150,212,186,212,179,212,182,213,132,212,180,213,134,36,212,185,212,180,36,212,181,212,180,212,179,213,135};for i=1,#G6X47PeoI do G6X47PeoI[i]=bit32.bxor(G6X47PeoI[i],4) end;return string.char(YaQAW(G6X47PeoI))end)())
                        returnToOwnBase(function() return keepGoing() and fpCarrying end, retSpeed)
                        if fpCarrying then inv((function()local QFsL=unpack or table.unpack;local J1ANNR6Iz={84,104,101,103,97};for i=1,#J1ANNR6Iz do J1ANNR6Iz[i]=bit32.bxor(J1ANNR6Iz[i],4) end;return string.char(QFsL(J1ANNR6Iz))end)(), { Uid = uid, LocalCFrame = CFrame.new(math.random(-8, 8), 0, math.random(-8, 8)) }); task.wait(0.15); delivered = true end
                    end
                end
            end
            unlockMove()
        end)
        if not ok then unlockMove(); setStatus((function()local ky6w=unpack or table.unpack;local WHddXn={212,150,212,186,213,133,213,133,213,134,212,180,212,185,212,186,212,182,212,191,212,177,212,185,212,188,212,177,42,42,42};for i=1,#WHddXn do WHddXn[i]=bit32.bxor(WHddXn[i],4) end;return string.char(ky6w(WHddXn))end)()) end
        task.wait(0.2)
    end
end)
local EventsTab = Window:AddTab((function()local yhNnC1=unpack or table.unpack;local zCDaviKCjn={212,165,212,186,212,181,213,143,213,134,212,188,213,139};for i=1,#zCDaviKCjn do zCDaviKCjn[i]=bit32.bxor(zCDaviKCjn[i],4) end;return string.char(yhNnC1(zCDaviKCjn))end)(), (function()local ZUAI8=unpack or table.unpack;local sE_9k0zH={119,116,101,118,111,104,97,119};for i=1,#sE_9k0zH do sE_9k0zH[i]=bit32.bxor(sE_9k0zH[i],4) end;return string.char(ZUAI8(sE_9k0zH))end)())
local BloomBox = EventsTab:AddLeftGroupbox((function()local J0cpo9=unpack or table.unpack;local BWakWfj={212,150,212,177,212,191,212,188,212,190,212,186,212,177,36,213,130,212,182,212,177,213,134,212,177,212,185,212,188,212,177};for i=1,#BWakWfj do BWakWfj[i]=bit32.bxor(BWakWfj[i],4) end;return string.char(J0cpo9(BWakWfj))end)())
BloomBox:AddToggle((function()local a66r=unpack or table.unpack;local tVKou1F={119,97,91,102,104,107,107,105};for i=1,#tVKou1F do tVKou1F[i]=bit32.bxor(tVKou1F[i],4) end;return string.char(a66r(tVKou1F))end)(), { Text = (function()local KsoWUz=unpack or table.unpack;local KpBHCKBoW={212,148,212,182,213,134,212,186,41,213,128,212,180,213,132,212,184,36,213,130,212,182,212,177,213,134,212,177,212,185,212,188,213,139};for i=1,#KpBHCKBoW do KpBHCKBoW[i]=bit32.bxor(KpBHCKBoW[i],4) end;return string.char(KsoWUz(KpBHCKBoW))end)(), Default = false })
local FuseBox = EventsTab:AddLeftGroupbox((function()local iKVy_=unpack or table.unpack;local EwolH7l={212,152,212,180,213,140,212,188,212,185,212,180,36,213,133,212,191,212,188,213,139,212,185,212,188,213,139};for i=1,#EwolH7l do EwolH7l[i]=bit32.bxor(EwolH7l[i],4) end;return string.char(iKVy_(EwolH7l))end)())
FuseBox:AddToggle((function()local aVPn=unpack or table.unpack;local XMEc2eHWD={119,97,91,101,113,112,107,98,113,119,97};for i=1,#XMEc2eHWD do XMEc2eHWD[i]=bit32.bxor(XMEc2eHWD[i],4) end;return string.char(aVPn(XMEc2eHWD))end)(), { Text = (function()local ma60Aq=unpack or table.unpack;local eqxgYVs67={212,148,212,182,213,134,212,186,41,213,133,212,191,212,188,213,139,212,185,212,188,212,177,36,212,187,212,188,213,134,212,186,212,184,213,130,212,177,212,182};for i=1,#eqxgYVs67 do eqxgYVs67[i]=bit32.bxor(eqxgYVs67[i],4) end;return string.char(ma60Aq(eqxgYVs67))end)(), Default = false })
local IncBox = EventsTab:AddRightGroupbox((function()local D_43=unpack or table.unpack;local hUKDqfLqZv={212,156,212,185,212,190,213,135,212,181,212,180,213,134,212,186,213,132,36,212,165,212,180,212,190,213,135,213,132,213,143};for i=1,#hUKDqfLqZv do hUKDqfLqZv[i]=bit32.bxor(hUKDqfLqZv[i],4) end;return string.char(D_43(hUKDqfLqZv))end)())
local crysLabel = IncBox:AddLabel((function()local qJgI=unpack or table.unpack;local RsCO4OFfy={212,158,213,132,212,188,213,133,213,134,212,180,212,191,212,191,213,143,62,36,52};for i=1,#RsCO4OFfy do RsCO4OFfy[i]=bit32.bxor(RsCO4OFfy[i],4) end;return string.char(qJgI(RsCO4OFfy))end)())
IncBox:AddToggle((function()local YuO_=unpack or table.unpack;local yAwyGq1H={119,97,91,109,106,103,113,102,101,112,97};for i=1,#yAwyGq1H do yAwyGq1H[i]=bit32.bxor(yAwyGq1H[i],4) end;return string.char(YuO_(yAwyGq1H))end)(), { Text = (function()local uggSJX=unpack or table.unpack;local nl4FLdEnA={212,148,212,182,213,134,212,186,41,212,188,212,185,212,190,213,135,212,181,212,180,213,130,212,188,213,139};for i=1,#nl4FLdEnA do nl4FLdEnA[i]=bit32.bxor(nl4FLdEnA[i],4) end;return string.char(uggSJX(nl4FLdEnA))end)(), Default = false })
IncBox:AddToggle((function()local wPcI=unpack or table.unpack;local d4tEOyep6={119,97,91,101,113,112,107,96,97,116,107,119,109,112};for i=1,#d4tEOyep6 do d4tEOyep6[i]=bit32.bxor(d4tEOyep6[i],4) end;return string.char(wPcI(d4tEOyep6))end)(), { Text = (function()local xIRQlA=unpack or table.unpack;local soPsQ83Rz={212,148,212,182,213,134,212,186,41,212,182,212,190,212,191,212,180,212,176,36,212,190,213,132,212,188,213,133,213,134,212,180,212,191,212,191,212,186,212,182};for i=1,#soPsQ83Rz do soPsQ83Rz[i]=bit32.bxor(soPsQ83Rz[i],4) end;return string.char(xIRQlA(soPsQ83Rz))end)(), Default = true })
IncBox:AddToggle((function()local oBxq5=unpack or table.unpack;local Usx4Nv={119,97,91,101,113,112,107,105,113,112,101,112,97};for i=1,#Usx4Nv do Usx4Nv[i]=bit32.bxor(Usx4Nv[i],4) end;return string.char(oBxq5(Usx4Nv))end)(), { Text = (function()local itl5t=unpack or table.unpack;local mCdfT1={212,148,212,182,213,134,212,186,41,212,184,213,135,213,134,212,180,213,130,212,188,213,139,36,212,187,213,132,212,188,36,212,179,212,180,212,187,212,186,212,191,212,185,212,177,212,185,212,188,212,188};for i=1,#mCdfT1 do mCdfT1[i]=bit32.bxor(mCdfT1[i],4) end;return string.char(itl5t(mCdfT1))end)(), Default = true })
local BossBox = EventsTab:AddRightGroupbox((function()local oESMWa=unpack or table.unpack;local G7lAX_Vc={212,165,212,186,212,181,213,143,213,134,212,188,212,177,36,212,181,212,186,213,133,213,133,212,180};for i=1,#G7lAX_Vc do G7lAX_Vc[i]=bit32.bxor(G7lAX_Vc[i],4) end;return string.char(oESMWa(G7lAX_Vc))end)())
BossBox:AddToggle((function()local LMHD0l=unpack or table.unpack;local BWmgi2BAS={119,97,91,102,107,119,119};for i=1,#BWmgi2BAS do BWmgi2BAS[i]=bit32.bxor(BWmgi2BAS[i],4) end;return string.char(LMHD0l(BWmgi2BAS))end)(), { Text = (function()local tGyR=unpack or table.unpack;local EnjQXSLas={212,148,212,182,213,134,212,186,41,212,181,212,186,213,133,213,133,36,44,212,182,213,129,212,186,212,176,36,47,36,213,135,212,176,212,180,213,132,213,143,36,212,187,212,186,36,212,190,213,132,212,188,213,133,213,134,212,180,212,191,212,191,212,180,212,184,45};for i=1,#EnjQXSLas do EnjQXSLas[i]=bit32.bxor(EnjQXSLas[i],4) end;return string.char(tGyR(EnjQXSLas))end)(), Default = false })
local bossLabel = BossBox:AddLabel((function()local E8FQ=unpack or table.unpack;local OIIu3c={212,149,212,186,213,133,213,133,62,36,212,186,212,178,212,188,212,176,212,180,212,185,212,188,212,177};for i=1,#OIIu3c do OIIu3c[i]=bit32.bxor(OIIu3c[i],4) end;return string.char(E8FQ(OIIu3c))end)())
local bossCountLabel = BossBox:AddLabel("Следующий босс:
local BOSS = Remotes and Remotes.BossEvent
local function bossArena() return Workspace:FindFirstChild("BossArena(function()local hSdfqK=unpack or table.unpack;local Gfp8H7={40,36,112,118,113,97,45,36,97,106,96,14,104,107,103,101,104,36,98,113,106,103,112,109,107,106,36,109,106,69,118,97,106,101,44,45,36,118,97,112,113,118,106,36,104,116,62,67,97,112,69,112,112,118,109,102,113,112,97,44};for i=1,#Gfp8H7 do Gfp8H7[i]=bit32.bxor(Gfp8H7[i],4) end;return string.char(hSdfqK(Gfp8H7))end)()InBossArena") == true end
local function crystalHitboxes()
    local a = bossArena(); if not a then return {} end
    local folder = a:FindFirstChild("CrystalTowers", true); if not folder then return {} end
    local out = {}
    for _, c in ipairs(folder:GetChildren()) do
        local hb = c:FindFirstChild("Hitbox(function()local qhjIC=unpack or table.unpack;local w7lDSe={45,14,36,36,36,36,36,36,36,36,109,98,36,108,102,36,101,106,96,36,108,102,62,77,119,69,44};for i=1,#w7lDSe do w7lDSe[i]=bit32.bxor(w7lDSe[i],4) end;return string.char(qhjIC(w7lDSe))end)()BasePart(function()local n7bp5O=unpack or table.unpack;local EhpmA6D={45,36,112,108,97,106,14,36,36,36,36,36,36,36,36,36,36,36,36,104,107,103,101,104,36,108,116,114,36,57,36,108,102,62,67,97,112,69,112,112,118,109,102,113,112,97,44};for i=1,#EhpmA6D do EhpmA6D[i]=bit32.bxor(EhpmA6D[i],4) end;return string.char(n7bp5O(EhpmA6D))end)()Health(function()local eoZYu=unpack or table.unpack;local Zr3MrC0y={45,14,36,36,36,36,36,36,36,36,36,36,36,36,109,98,36,108,116,114,36,57,57,36,106,109,104,36,107,118,36,44,112,125,116,97,44,108,116,114,45,36,57,57,36};for i=1,#Zr3MrC0y do Zr3MrC0y[i]=bit32.bxor(Zr3MrC0y[i],4) end;return string.char(eoZYu(Zr3MrC0y))end)()number" and hpv > 0) then out[#out + 1] = hb end
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
        if (d:IsA("Bone(function()local F48l=unpack or table.unpack;local kgrFkB7Mr={45,36,107,118,36,96,62,77,119,69,44};for i=1,#kgrFkB7Mr do kgrFkB7Mr[i]=bit32.bxor(kgrFkB7Mr[i],4) end;return string.char(F48l(kgrFkB7Mr))end)()BasePart(function()local t9S_g3=unpack or table.unpack;local bg0CFy9={45,45,36,101,106,96,36,96,62,66,109,106,96,66,109,118,119,112,71,108,109,104,96,44};for i=1,#bg0CFy9 do bg0CFy9[i]=bit32.bxor(bg0CFy9[i],4) end;return string.char(t9S_g3(bg0CFy9))end)()Health") ~= nil then out[#out + 1] = d end
    end
    return out
end
local function bossBodyPart()
    local a = bossArena(); if not a then return nil end
    local boss = a:FindFirstChild("Boss(function()local qDWJAr=unpack or table.unpack;local BsAIC4H={40,36,112,118,113,97,45,63,36,109,98,36,106,107,112,36,102,107,119,119,36,112,108,97,106,36,118,97,112,113,118,106,36,106,109,104,36,97,106,96,14,36,36,36,36,109,98,36,102,107,119,119,62,77,119,69,44};for i=1,#BsAIC4H do BsAIC4H[i]=bit32.bxor(BsAIC4H[i],4) end;return string.char(qDWJAr(BsAIC4H))end)()BasePart(function()local o8R5=unpack or table.unpack;local z5BKmN={45,36,112,108,97,106,36,118,97,112,113,118,106,36,102,107,119,119,36,97,106,96,14,36,36,36,36,118,97,112,113,118,106,36,102,107,119,119,42,84,118,109,105,101,118,125,84,101,118,112,36,107,118,36,102,107,119,119,62,66,109,106,96,66,109,118,119,112,71,108,109,104,96,44};for i=1,#z5BKmN do z5BKmN[i]=bit32.bxor(z5BKmN[i],4) end;return string.char(o8R5(z5BKmN))end)()HumanoidRootPart(function()local LYw75Y=unpack or table.unpack;local L1CFC0_R={40,36,112,118,113,97,45,36,107,118,36,102,107,119,119,62,66,109,106,96,66,109,118,119,112,71,108,109,104,96,83,108,109,103,108,77,119,69,44};for i=1,#L1CFC0_R do L1CFC0_R[i]=bit32.bxor(L1CFC0_R[i],4) end;return string.char(LYw75Y(L1CFC0_R))end)()BasePart", true)
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
        Nav.tweenTo3D(pos, keep, (Opt.se_walk and Opt.se_walk.Value) or 300)
        if not (keep() and target and target.Parent) then return end
        swingBat(target)
        task.wait(0.5)
    end
end
task.spawn(function()
    while RUNNING do
        if on("se_boss") and BOSS then
            if not inArena() then
                pcall(function() bossLabel:SetText("Босс: вход") end)
                pcall(function() if BOSS.AskEnter then BOSS.AskEnter:InvokeServer() end end)
                task.wait(1)
            else
                if not heldBat() then equipBatInput(true) end
                local keep = function() return RUNNING and on("se_boss") and inArena() end
                local crystals = crystalHitboxes()
                if #crystals > 0 then
                    local h = hrp()
                    if h then table.sort(crystals, function(a, b) return (a.Position - h.Position).Magnitude < (b.Position - h.Position).Magnitude end) end
                    pcall(function() bossLabel:SetText("Босс: кристаллы ((function()local x8jR0=unpack or table.unpack;local R3RziqEyY={36,42,42,36,39,103,118,125,119,112,101,104,119,36,42,42,36};for i=1,#R3RziqEyY do R3RziqEyY[i]=bit32.bxor(R3RziqEyY[i],4) end;return string.char(x8jR0(R3RziqEyY))end)() осталось)") end)
                    orbitAndSwing(crystals[1], keep)
                else
                    local arms = armTargets()
                    if #arms > 0 then
                        local h = hrp()
                        if h then table.sort(arms, function(a, b) return ((worldPosOf(a) or h.Position) - h.Position).Magnitude < ((worldPosOf(b) or h.Position) - h.Position).Magnitude end) end
                        pcall(function() bossLabel:SetText("Босс: атака по рукам ((function()local uRYU=unpack or table.unpack;local XHF6qMN={36,42,42,36,39,101,118,105,119,36,42,42,36};for i=1,#XHF6qMN do XHF6qMN[i]=bit32.bxor(XHF6qMN[i],4) end;return string.char(uRYU(XHF6qMN))end)())") end)
                        orbitAndSwing(arms[1], keep)
                    else
                        local body = bossBodyPart()
                        if body then
                            pcall(function() bossLabel:SetText("Босс: атака по боссу (нет рук)") end)
                            orbitAndSwing(body, keep)
                        else
                            pcall(function() bossLabel:SetText("Босс: ожидание (смена фазы)") end); task.wait(0.5)
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
        pcall(function() crysLabel:SetText("Кристаллы: " .. tostring(s and s.SakuraCrystals or 0)) end)
        task.wait(1)
    end
end)
task.spawn(function()
    while RUNNING do
        pcall(function()
            if inArena() then bossCountLabel:SetText("Босс: АКТИВЕН (на арене)")
            else
                local secs = 1800 - Workspace:GetServerTimeNow() % 1800
                bossCountLabel:SetText(("Следующий босс через ~%d:%02d"):format(math.floor(secs / 60), math.floor(secs % 60)))
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
    local ends = Workspace:GetAttribute("GreatBloomEndsAt(function()local GEARcX=unpack or table.unpack;local e6Rg6A4v={45,14,36,36,36,36,118,97,112,113,118,106,36,112,125,116,97,44,97,106,96,119,45,36,57,57,36};for i=1,#e6Rg6A4v do e6Rg6A4v[i]=bit32.bxor(e6Rg6A4v[i],4) end;return string.char(GEARcX(e6Rg6A4v))end)()number(function()local QOw9mk=unpack or table.unpack;local OyRogA={36,101,106,96,36,97,106,96,119,36,58,36,107,119,42,112,109,105,97,44,45,14,97,106,96,14,104,107,103,101,104,36,98,113,106,103,112,109,107,106,36,102,104,107,107,105,67,107,44,45,36,118,97,112,113,118,106,36,107,106,44};for i=1,#OyRogA do OyRogA[i]=bit32.bxor(OyRogA[i],4) end;return string.char(QOw9mk(OyRogA))end)()se_bloom") and bloomActive() and stealAllowed() end
local lastBatAt = 0
task.spawn(function()
    while RUNNING do
        local ok = pcall(function()
            if not bloomGo() then return end
            setStatus("Фарм цветения(function()local yK3zE=unpack or table.unpack;local yXYXkpXbh={45,14,36,36,36,36,36,36,36,36,36,36,36,36,109,98,36,107,119,42,103,104,107,103,111,44,45,36,41,36,104,101,119,112,70,101,112,69,112,36,58,36,48,36,112,108,97,106,36,104,101,119,112,70,101,112,69,112,36,57,36,107,119,42,103,104,107,103,111,44,45,63,36,109,106,114,44};for i=1,#yXYXkpXbh do yXYXkpXbh[i]=bit32.bxor(yXYXkpXbh[i],4) end;return string.char(yK3zE(yXYXkpXbh))end)()WearBat(function()local MB_enI=unpack or table.unpack;local tnlgwq={40,36,104,116,62,67,97,112,69,112,112,118,109,102,113,112,97,44};for i=1,#tnlgwq do tnlgwq[i]=bit32.bxor(tnlgwq[i],4) end;return string.char(MB_enI(tnlgwq))end)()AreaId(function()local vcdjEU=unpack or table.unpack;local BN2mU6={45,45,36,97,106,96,14,36,36,36,36,36,36,36,36,36,36,36,36,98,107,118,36,91,40,36,112,118,97,97,36,109,106,36,109,116,101,109,118,119,44,71,107,104,104,97,103,112,109,107,106,87,97,118,114,109,103,97,62,67,97,112,80,101,99,99,97,96,44};for i=1,#BN2mU6 do BN2mU6[i]=bit32.bxor(BN2mU6[i],4) end;return string.char(vcdjEU(BN2mU6))end)()SakuraBloomTree")) do
                if not bloomGo() then break end
                local okp, pos = pcall(function() return tree:GetPivot().Position end)
                if okp and pos then
                    lockMove()
                    setStatus("Bloom: удары по дереву")
                    Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_speed and Opt.se_speed.Value) or 200)
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
                        setStatus("Bloom: сбор кристалла")
                        Nav.tweenTo3D(pos + Vector3.new(0, 3, 0), bloomGo, (Opt.se_speed and Opt.se_speed.Value) or 200)
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
        if on("se_incubate(function()local ITyv_=unpack or table.unpack;local F_wFGyk={45,36,112,108,97,106,14,36,36,36,36,36,36,36,36,36,36,36,36,104,107,103,101,104,36,119,36,57,36,119,101,114,97,44,45,14,36,36,36,36,36,36,36,36,36,36,36,36,109,98,36,119,36,101,106,96,36,112,125,116,97,44,119,42,87,101,111,113,118,101,45,36,57,57,36};for i=1,#F_wFGyk do F_wFGyk[i]=bit32.bxor(F_wFGyk[i],4) end;return string.char(ITyv_(F_wFGyk))end)()table" then
                local sak = s.Sakura
                if not sak.Egg or sak.Egg == false then
                    for k, rec in pairs(myEggs()) do
                        if type(rec) == "table(function()local XyZr=unpack or table.unpack;local lqhLkjHOPK={36,101,106,96,36,118,97,103,42,84,104,101,103,97,105,97,106,112,36,57,57,36,106,109,104,36,112,108,97,106,36,109,106,114,44};for i=1,#lqhLkjHOPK do lqhLkjHOPK[i]=bit32.bxor(lqhLkjHOPK[i],4) end;return string.char(XyZr(lqhLkjHOPK))end)()SakuraInsert", rec.Uid or k); break end
                    end
                else
                    local deposited = sak.Deposited or 0
                    local bal = s.SakuraCrystals or 0
                    if on("se_autodeposit") and deposited < 1000 and bal > 0 then
                        local amt = math.min(1000 - deposited, bal)
                        if amt > 0 then inv("SakuraDeposit(function()local WxSJH=unpack or table.unpack;local mCLfyFa={40,36,101,105,112,45,36,97,106,96,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,97,104,119,97,109,98,36,107,106,44};for i=1,#mCLfyFa do mCLfyFa[i]=bit32.bxor(mCLfyFa[i],4) end;return string.char(WxSJH(mCLfyFa))end)()se_automutate(function()local RXPgX=unpack or table.unpack;local QOIkrs={45,36,101,106,96,36,96,97,116,107,119,109,112,97,96,36,58,57,36,53,52,52,52,36,112,108,97,106,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,109,106,114,44};for i=1,#QOIkrs do QOIkrs[i]=bit32.bxor(QOIkrs[i],4) end;return string.char(RXPgX(QOIkrs))end)()SakuraMutate")
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
                    inv("FuseBegin(function()local qcMmSm=unpack or table.unpack;local ylFNtqll={45,63,36,112,101,119,111,42,115,101,109,112,44,52,42,50,45,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,109,106,114,44};for i=1,#ylFNtqll do ylFNtqll[i]=bit32.bxor(ylFNtqll[i],4) end;return string.char(qcMmSm(ylFNtqll))end)()FuseFinish"); task.wait(1.2)
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
                if not pick then setStatus("Нет тройки для слияния(function()local WqzbZ=unpack or table.unpack;local gt8OdWHl9y={45,63,36,118,97,112,113,118,106,36,97,106,96,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,119,97,112,87,112,101,112,113,119,44};for i=1,#gt8OdWHl9y do gt8OdWHl9y[i]=bit32.bxor(gt8OdWHl9y[i],4) end;return string.char(WqzbZ(gt8OdWHl9y))end)()Слияние питомцев(function()local tFpPn=unpack or table.unpack;local KoFGCZ190={45,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,98,107,118,36,109,36,57,36,53,40,36,55,36,96,107,36,109,106,114,44};for i=1,#KoFGCZ190 do KoFGCZ190[i]=bit32.bxor(KoFGCZ190[i],4) end;return string.char(tFpPn(KoFGCZ190))end)()FuseLoad", pick[i]); task.wait(0.3) end
                task.wait(0.2)
                inv("FuseBegin(function()local f3AOR=unpack or table.unpack;local Mgpoff={45,63,36,112,101,119,111,42,115,101,109,112,44,52,42,50,45,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,109,106,114,44};for i=1,#Mgpoff do Mgpoff[i]=bit32.bxor(Mgpoff[i],4) end;return string.char(f3AOR(Mgpoff))end)()FuseFinish"); task.wait(1.2)
            end)
        end
        task.wait(1)
    end
end)
local antiLagConn
local function applyAntiLagOne(o)
    if o:IsA("ParticleEmitter(function()local Sqcd=unpack or table.unpack;local ePp9m6ZcfU={45,36,107,118,36,107,62,77,119,69,44};for i=1,#ePp9m6ZcfU do ePp9m6ZcfU[i]=bit32.bxor(ePp9m6ZcfU[i],4) end;return string.char(Sqcd(ePp9m6ZcfU))end)()Trail(function()local XmP4R=unpack or table.unpack;local TZGgs_Hwq={45,36,107,118,36,107,62,77,119,69,44};for i=1,#TZGgs_Hwq do TZGgs_Hwq[i]=bit32.bxor(TZGgs_Hwq[i],4) end;return string.char(XmP4R(TZGgs_Hwq))end)()Beam(function()local mvii5a=unpack or table.unpack;local VdhIKw3={45,36,112,108,97,106,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,107,42,65,106,101,102,104,97,96,36,57,36,98,101,104,119,97,36,97,106,96,45,14,36,36,36,36,97,104,119,97,109,98,36,107,62,77,119,69,44};for i=1,#VdhIKw3 do VdhIKw3[i]=bit32.bxor(VdhIKw3[i],4) end;return string.char(mvii5a(VdhIKw3))end)()Smoke(function()local NQgy=unpack or table.unpack;local vnQ1t52D2={45,36,107,118,36,107,62,77,119,69,44};for i=1,#vnQ1t52D2 do vnQ1t52D2[i]=bit32.bxor(vnQ1t52D2[i],4) end;return string.char(NQgy(vnQ1t52D2))end)()Fire(function()local mGpVn=unpack or table.unpack;local c27po6oA={45,36,107,118,36,107,62,77,119,69,44};for i=1,#c27po6oA do c27po6oA[i]=bit32.bxor(c27po6oA[i],4) end;return string.char(mGpVn(c27po6oA))end)()Sparkles(function()local bhi_C=unpack or table.unpack;local FHs0jbTI={45,36,112,108,97,106,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,107,62,64,97,119,112,118,107,125,44,45,36,97,106,96,45,14,36,36,36,36,97,104,119,97,109,98,36,107,62,77,119,69,44};for i=1,#FHs0jbTI do FHs0jbTI[i]=bit32.bxor(FHs0jbTI[i],4) end;return string.char(bhi_C(FHs0jbTI))end)()PointLight(function()local zoFD1=unpack or table.unpack;local ugszxv={45,36,107,118,36,107,62,77,119,69,44};for i=1,#ugszxv do ugszxv[i]=bit32.bxor(ugszxv[i],4) end;return string.char(zoFD1(ugszxv))end)()SpotLight(function()local GZ7jw=unpack or table.unpack;local Q7Evax5b={45,36,107,118,36,107,62,77,119,69,44};for i=1,#Q7Evax5b do Q7Evax5b[i]=bit32.bxor(Q7Evax5b[i],4) end;return string.char(GZ7jw(Q7Evax5b))end)()SurfaceLight(function()local Y71KTq=unpack or table.unpack;local rKtfeu7X={45,36,112,108,97,106,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,107,42,65,106,101,102,104,97,96,36,57,36,98,101,104,119,97,36,97,106,96,45,14,36,36,36,36,97,104,119,97,109,98,36,107,62,77,119,69,44};for i=1,#rKtfeu7X do rKtfeu7X[i]=bit32.bxor(rKtfeu7X[i],4) end;return string.char(Y71KTq(rKtfeu7X))end)()BasePart") then pcall(function() o.Material = Enum.Material.SmoothPlastic end); pcall(function() o.Reflectance = 0 end); pcall(function() o.CastShadow = false end)
    elseif o:IsA("Decal(function()local pJFnO=unpack or table.unpack;local kB_pXEXl={45,36,107,118,36,107,62,77,119,69,44};for i=1,#kB_pXEXl do kB_pXEXl[i]=bit32.bxor(kB_pXEXl[i],4) end;return string.char(pJFnO(kB_pXEXl))end)()Texture") then pcall(function() o.Transparency = 1 end) end
end
local function setAntiLag(state)
    if antiLagConn then antiLagConn:Disconnect(); antiLagConn = nil end
    if not state then return end
    pcall(function() Lighting.GlobalShadows = false end)
    pcall(function() Lighting.FogEnd = 9e9 end)
    pcall(function() Lighting.FogStart = 9e9 end)
    pcall(function() settings().Rendering.QualityLevel = 1 end)
    pcall(function() settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level04 end)
    for _, e in ipairs(Lighting:GetDescendants()) do if e:IsA("PostEffect(function()local Kdfb=unpack or table.unpack;local RMW1oKbs3q={45,36,107,118,36,97,62,77,119,69,44};for i=1,#RMW1oKbs3q do RMW1oKbs3q[i]=bit32.bxor(RMW1oKbs3q[i],4) end;return string.char(Kdfb(RMW1oKbs3q))end)()Atmosphere(function()local CAdsq=unpack or table.unpack;local qHxRQeL={45,36,107,118,36,97,62,77,119,69,44};for i=1,#qHxRQeL do qHxRQeL[i]=bit32.bxor(qHxRQeL[i],4) end;return string.char(CAdsq(qHxRQeL))end)()Clouds") then pcall(function() e.Enabled = false end) end end
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
    local t = Opt.se_timelock and Opt.se_timelock.Value
    if t and t ~= "Off" then
        local ct = ({ Day = 14, Night = 0, Sunrise = 6.5, Sunset = 18 })[t]
        if ct then pcall(function() Lighting.ClockTime = ct end) end
    end
end)
local SettingsTab = Window:AddTab("Настройки", "settings(function()local jIc0b=unpack or table.unpack;local UF38dXH={45,14,104,107,103,101,104,36,84,118,107,112,70,107,124,36,57,36,87,97,112,112,109,106,99,119,80,101,102,62,69,96,96,72,97,98,112,67,118,107,113,116,102,107,124,44};for i=1,#UF38dXH do UF38dXH[i]=bit32.bxor(UF38dXH[i],4) end;return string.char(jIc0b(UF38dXH))end)()Защита(function()local BqZo=unpack or table.unpack;local mGgisAcp5O={45,14,84,118,107,112,70,107,124,62,69,96,96,80,107,99,99,104,97,44};for i=1,#mGgisAcp5O do mGgisAcp5O[i]=bit32.bxor(mGgisAcp5O[i],4) end;return string.char(BqZo(mGgisAcp5O))end)()se_antiafk(function()local b3aO=unpack or table.unpack;local cKmkhE5azA={40,36,127,36,80,97,124,112,36,57,36};for i=1,#cKmkhE5azA do cKmkhE5azA[i]=bit32.bxor(cKmkhE5azA[i],4) end;return string.char(b3aO(cKmkhE5azA))end)()Анти-AFK(function()local fOHXj=unpack or table.unpack;local u5CP1l={40,36,64,97,98,101,113,104,112,36,57,36,112,118,113,97,36,121,45,14,84,118,107,112,70,107,124,62,69,96,96,80,107,99,99,104,97,44};for i=1,#u5CP1l do u5CP1l[i]=bit32.bxor(u5CP1l[i],4) end;return string.char(fOHXj(u5CP1l))end)()se_antilag(function()local jNHc6=unpack or table.unpack;local QnifAJH2u={40,36,127,36,80,97,124,112,36,57,36};for i=1,#QnifAJH2u do QnifAJH2u[i]=bit32.bxor(QnifAJH2u[i],4) end;return string.char(jNHc6(QnifAJH2u))end)()Снизить лаги", Default = false, Callback = function(v) setAntiLag(v) end })
ProtBox:AddDropdown("se_timelock(function()local tLi4x=unpack or table.unpack;local QRdW2Ud={40,36,127,36,82,101,104,113,97,119,36,57,36,127,36};for i=1,#QRdW2Ud do QRdW2Ud[i]=bit32.bxor(QRdW2Ud[i],4) end;return string.char(tLi4x(QRdW2Ud))end)()Off", "Day", "Night", "Sunrise", "Sunset(function()local jEkH=unpack or table.unpack;local vbbJ_Ub8={36,121,40,36,64,97,98,101,113,104,112,36,57,36};for i=1,#vbbJ_Ub8 do vbbJ_Ub8[i]=bit32.bxor(vbbJ_Ub8[i],4) end;return string.char(jEkH(vbbJ_Ub8))end)()Off(function()local bX6eN=unpack or table.unpack;local lGZnzSa={40,36,80,97,124,112,36,57,36};for i=1,#lGZnzSa do lGZnzSa[i]=bit32.bxor(lGZnzSa[i],4) end;return string.char(bX6eN(lGZnzSa))end)()Зафиксировать время(function()local CN_jM=unpack or table.unpack;local ZIcnuR={36,121,45,14,104,107,103,101,104,36,82,109,118,112,113,101,104,81,119,97,118,36,57,36,103,104,107,106,97,118,97,98,44,99,101,105,97,62,67,97,112,87,97,118,114,109,103,97,44};for i=1,#ZIcnuR do ZIcnuR[i]=bit32.bxor(ZIcnuR[i],4) end;return string.char(CN_jM(ZIcnuR))end)()VirtualUser(function()local b4Vc5=unpack or table.unpack;local Y7NhXVuekZ={45,45,14,104,116,42,77,96,104,97,96,62,71,107,106,106,97,103,112,44,98,113,106,103,112,109,107,106,44,45,14,36,36,36,36,109,98,36,86,81,74,74,77,74,67,36,101,106,96,36,107,106,44};for i=1,#Y7NhXVuekZ do Y7NhXVuekZ[i]=bit32.bxor(Y7NhXVuekZ[i],4) end;return string.char(b4Vc5(Y7NhXVuekZ))end)()se_antiafk") then pcall(function() VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end) end
end)
local MenuBox = SettingsTab:AddRightGroupbox("Меню(function()local rRGGJi=unpack or table.unpack;local Kfk13JE={45,14,73,97,106,113,70,107,124,62,69,96,96,70,113,112,112,107,106,44,127,36,80,97,124,112,36,57,36};for i=1,#Kfk13JE do Kfk13JE[i]=bit32.bxor(Kfk13JE[i],4) end;return string.char(rRGGJi(Kfk13JE))end)()Выгрузить(function()local gS0lup=unpack or table.unpack;local snlcEc81_={40,36,66,113,106,103,36,57,36,98,113,106,103,112,109,107,106,44,45,14,36,36,36,36,98,107,118,36,91,40,36,111,36,109,106,36,109,116,101,109,118,119,44,127,36};for i=1,#snlcEc81_ do snlcEc81_[i]=bit32.bxor(snlcEc81_[i],4) end;return string.char(gS0lup(snlcEc81_))end)()se_selected", "se_bloom", "se_incubate", "se_tpwalk", "se_antikb", "se_esp" }) do
        local t = Toggles[k]; if t then pcall(function() t:SetValue(false) end) end
    end
    pcall(function() if Opt.se_steps then Opt.se_steps:SetValue({}) end end)
    pcall(function() if _G.__CW_CLEAN then _G.__CW_CLEAN() end end)
    pcall(function() Library:Unload() end)
end })
MenuBox:AddLabel("Переключить меню(function()local P9Tzj=unpack or table.unpack;local fDyuRP={45,62,69,96,96,79,97,125,84,109,103,111,97,118,44};for i=1,#fDyuRP do fDyuRP[i]=bit32.bxor(fDyuRP[i],4) end;return string.char(P9Tzj(fDyuRP))end)()MenuKeybind(function()local jxb0=unpack or table.unpack;local _oR5qij={40,36,127,36,64,97,98,101,113,104,112,36,57,36};for i=1,#_oR5qij do _oR5qij[i]=bit32.bxor(_oR5qij[i],4) end;return string.char(jxb0(_oR5qij))end)()RightShift(function()local x7Vs=unpack or table.unpack;local dNZTH3SG={40,36,74,107,81,77,36,57,36,112,118,113,97,40,36,80,97,124,112,36,57,36};for i=1,#dNZTH3SG do dNZTH3SG[i]=bit32.bxor(dNZTH3SG[i],4) end;return string.char(x7Vs(dNZTH3SG))end)()Переключить меню" })
Library.ToggleKeybind = Opt.MenuKeybind
SaveManager:SetLibrary(Library)
ThemeManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({ "MenuKeybind", "FeedbackType", "FeedbackMsg(function()local xx7TDe=unpack or table.unpack;local jItcWQt={36,121,45,14,80,108,97,105,97,73,101,106,101,99,97,118,62,87,97,112,66,107,104,96,97,118,44};for i=1,#jItcWQt do jItcWQt[i]=bit32.bxor(jItcWQt[i],4) end;return string.char(xx7TDe(jItcWQt))end)()PubHub(function()local a8q2oK=unpack or table.unpack;local MGZblT={45,14,87,101,114,97,73,101,106,101,99,97,118,62,87,97,112,66,107,104,96,97,118,44};for i=1,#MGZblT do MGZblT[i]=bit32.bxor(MGZblT[i],4) end;return string.char(a8q2oK(MGZblT))end)()PubHub")
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
    pcall(function() ThemeManager:ApplyTheme("Default") end)
end)
SaveManager:BuildConfigSection(SettingsTab)
SaveManager:LoadAutoloadConfig()
local DISCORD_INVITE = "https://discord.gg/pubhub(function()local OvcdVc=unpack or table.unpack;local Cqi36JqNlG={14,104,107,103,101,104,36,66,65,65,64,70,69,71,79,91,81,86,72,36,36,36,57,36};for i=1,#Cqi36JqNlG do Cqi36JqNlG[i]=bit32.bxor(Cqi36JqNlG[i],4) end;return string.char(OvcdVc(Cqi36JqNlG))end)()https://YOUR-DOMAIN.com/feedback(function()local Q8PqMZ=unpack or table.unpack;local R92dbkgUIb={14,104,107,103,101,104,36,66,65,65,64,70,69,71,79,91,82,65,86,87,77,75,74,36,57,36};for i=1,#R92dbkgUIb do R92dbkgUIb[i]=bit32.bxor(R92dbkgUIb[i],4) end;return string.char(Q8PqMZ(R92dbkgUIb))end)()pubhub-stealegg-2.0"
local _request = request or (syn and syn.request) or http_request
local function fbTrim(s) return (tostring(s or "(function()local oKS_G=unpack or table.unpack;local SXZZgfZe={45,62,99,119,113,102,44};for i=1,#SXZZgfZe do SXZZgfZe[i]=bit32.bxor(SXZZgfZe[i],4) end;return string.char(oKS_G(SXZZgfZe))end)()^%s*(.-)%s*$", "%1")) end
local function fbHWID()
    local ok, id = pcall(function() return game:GetService("RbxAnalyticsService(function()local oDyhB=unpack or table.unpack;local YY5uT_7Mz={45,62,67,97,112,71,104,109,97,106,112,77,96,44,45,36,97,106,96,45,14,36,36,36,36,109,98,36,107,111,36,101,106,96,36,112,125,116,97,44,109,96,45,36,57,57,36};for i=1,#YY5uT_7Mz do YY5uT_7Mz[i]=bit32.bxor(YY5uT_7Mz[i],4) end;return string.char(oDyhB(YY5uT_7Mz))end)()string(function()local N1Ub=unpack or table.unpack;local iGmWmQ={36,101,106,96,36,109,96,36,122,57,36};for i=1,#iGmWmQ do iGmWmQ[i]=bit32.bxor(iGmWmQ[i],4) end;return string.char(N1Ub(iGmWmQ))end)()" then return id end
    return tostring(lp and lp.UserId or 0)
end
local FB_HWID = fbHWID()
local FB_ERRMAP = {
    empty = "Сообщение пустое.(function()local KLcPf=unpack or table.unpack;local J2SPQVh={40,36,106,107,91,104,109,106,111,119,36,57,36};for i=1,#J2SPQVh do J2SPQVh[i]=bit32.bxor(J2SPQVh[i],4) end;return string.char(KLcPf(J2SPQVh))end)()Ссылки не разрешены.(function()local o5_2m=unpack or table.unpack;local pE1qDfe={40,14,36,36,36,36,112,107,107,91,104,107,106,99,36,57,36};for i=1,#pE1qDfe do pE1qDfe[i]=bit32.bxor(pE1qDfe[i],4) end;return string.char(o5_2m(pE1qDfe))end)()Сообщение слишком длинное (максимум 500 символов).(function()local lpbgc=unpack or table.unpack;local c1VyPkwset={40,14,36,36,36,36,118,101,112,97,91,104,109,105,109,112,97,96,36,57,36};for i=1,#c1VyPkwset do c1VyPkwset[i]=bit32.bxor(c1VyPkwset[i],4) end;return string.char(lpbgc(c1VyPkwset))end)()Вы достигли лимита в 3 сообщения. Повторите позже.(function()local Xq7_3=unpack or table.unpack;local zpdRLBD3={40,14,36,36,36,36,102,113,119,125,36,57,36};for i=1,#zpdRLBD3 do zpdRLBD3[i]=bit32.bxor(zpdRLBD3[i],4) end;return string.char(Xq7_3(zpdRLBD3))end)()Сервер занят. Повторите попытку.(function()local caeA=unpack or table.unpack;local ZfcBDoB7={40,36,102,101,106,106,97,96,36,57,36};for i=1,#ZfcBDoB7 do ZfcBDoB7[i]=bit32.bxor(ZfcBDoB7[i],4) end;return string.char(caeA(ZfcBDoB7))end)()Вам не разрешено отправлять отзывы.(function()local tbhZ=unpack or table.unpack;local WtVqzG71X={40,14,36,36,36,36,96,109,119,103,107,118,96,91,97,118,118,107,118,36,57,36};for i=1,#WtVqzG71X do WtVqzG71X[i]=bit32.bxor(WtVqzG71X[i],4) end;return string.char(tbhZ(WtVqzG71X))end)()Отправка не удалась. Повторите попытку.(function()local JpVJi=unpack or table.unpack;local LqYgv1b3={40,36,106,97,112,115,107,118,111,36,57,36};for i=1,#LqYgv1b3 do LqYgv1b3[i]=bit32.bxor(LqYgv1b3[i],4) end;return string.char(JpVJi(LqYgv1b3))end)()Ошибка сети.(function()local cmJ_Xj=unpack or table.unpack;local uTkZz8M07={40,14,36,36,36,36,106,107,91,118,97,117,113,97,119,112,36,57,36};for i=1,#uTkZz8M07 do uTkZz8M07[i]=bit32.bxor(uTkZz8M07[i],4) end;return string.char(cmJ_Xj(uTkZz8M07))end)()Ваш эксплойт не может отправлять запросы.(function()local YrEv=unpack or table.unpack;local icVBs6P={40,36,102,101,96,91,118,97,119,116,107,106,119,97,36,57,36};for i=1,#icVBs6P do icVBs6P[i]=bit32.bxor(icVBs6P[i],4) end;return string.char(YrEv(icVBs6P))end)()Сервер вернул неожиданный ответ.(function()local bPa7=unpack or table.unpack;local _tH3J1Sl={40,14,36,36,36,36,113,106,118,97,101,103,108,101,102,104,97,36,57,36};for i=1,#_tH3J1Sl do _tH3J1Sl[i]=bit32.bxor(_tH3J1Sl[i],4) end;return string.char(bPa7(_tH3J1Sl))end)()Ваш эксплойт не может подключиться к серверу (ошибка TLS). Попробуйте другой эксплойт.",
}
local function sendFeedback(ftype, msg)
    if not _request then return false, "no_request" end
    local ok, res = pcall(function()
        return _request({
            Url = FEEDBACK_URL, Method = "POST(function()local rs9I=unpack or table.unpack;local clNLjC7ZP={40,14,36,36,36,36,36,36,36,36,36,36,36,36,76,97,101,96,97,118,119,36,57,36,127,36,95};for i=1,#clNLjC7ZP do clNLjC7ZP[i]=bit32.bxor(clNLjC7ZP[i],4) end;return string.char(rs9I(clNLjC7ZP))end)()Content-Type(function()local UgzNht=unpack or table.unpack;local DhSLr5o2xu={89,36,57,36};for i=1,#DhSLr5o2xu do DhSLr5o2xu[i]=bit32.bxor(DhSLr5o2xu[i],4) end;return string.char(UgzNht(DhSLr5o2xu))end)()application/json" },
            Body = HttpService:JSONEncode({
                type = ftype, message = msg, hwid = FB_HWID,
                placeId = tostring(game.PlaceId), username = lp and lp.Name or "?",
                version = FEEDBACK_VERSION,
            }),
        })
    end)
    if not ok or not res then return false, "network(function()local Mv0ry=unpack or table.unpack;local CQnfREBq={36,97,106,96,14,36,36,36,36,109,98,36,112,125,116,97,44,118,97,119,45,36,57,57,36};for i=1,#CQnfREBq do CQnfREBq[i]=bit32.bxor(CQnfREBq[i],4) end;return string.char(Mv0ry(CQnfREBq))end)()string(function()local bCoF=unpack or table.unpack;local tMCDTj={36,112,108,97,106,36,118,97,112,113,118,106,36,98,101,104,119,97,40,36};for i=1,#tMCDTj do tMCDTj[i]=bit32.bxor(tMCDTj[i],4) end;return string.char(bCoF(tMCDTj))end)()unreachable(function()local Db__k=unpack or table.unpack;local FkXuYKHYn2={36,97,106,96,14,36,36,36,36,109,98,36,112,125,116,97,44,118,97,119,45,36,122,57,36};for i=1,#FkXuYKHYn2 do FkXuYKHYn2[i]=bit32.bxor(FkXuYKHYn2[i],4) end;return string.char(Db__k(FkXuYKHYn2))end)()table(function()local B3UmiF=unpack or table.unpack;local R9qWkRnQud={36,112,108,97,106,36,118,97,112,113,118,106,36,98,101,104,119,97,40,36};for i=1,#R9qWkRnQud do R9qWkRnQud[i]=bit32.bxor(R9qWkRnQud[i],4) end;return string.char(B3UmiF(R9qWkRnQud))end)()network" end
    local code = res.StatusCode or res.status_code or res.Status or res.status
    if type(code) == "number(function()local hGY8=unpack or table.unpack;local BiwX5M={36,101,106,96,36,103,107,96,97,36,122,57,36,54,52,52,36,101,106,96,36,103,107,96,97,36,122,57,36,54,52,53,36,101,106,96,36,103,107,96,97,36,122,57,36,54,52,48,36,112,108,97,106,36,118,97,112,113,118,106,36,98,101,104,119,97,40,36};for i=1,#BiwX5M do BiwX5M[i]=bit32.bxor(BiwX5M[i],4) end;return string.char(hGY8(BiwX5M))end)()http_" .. tostring(code) end
    local body = res.Body or res.body
    if type(body) ~= "string(function()local K52t=unpack or table.unpack;local LGDliUnb15={36,107,118,36,102,107,96,125,36,57,57,36};for i=1,#LGDliUnb15 do LGDliUnb15[i]=bit32.bxor(LGDliUnb15[i],4) end;return string.char(K52t(LGDliUnb15))end)()(function()local IxPb=unpack or table.unpack;local FdSydEcZSG={36,112,108,97,106,36,118,97,112,113,118,106,36,98,101,104,119,97,40,36};for i=1,#FdSydEcZSG do FdSydEcZSG[i]=bit32.bxor(FdSydEcZSG[i],4) end;return string.char(IxPb(FdSydEcZSG))end)()bad_response" end
    local dok, data = pcall(function() return HttpService:JSONDecode(body) end)
    if not dok or type(data) ~= "table(function()local sPzPS=unpack or table.unpack;local nvGsPtohl={36,112,108,97,106,36,118,97,112,113,118,106,36,98,101,104,119,97,40,36};for i=1,#nvGsPtohl do nvGsPtohl[i]=bit32.bxor(nvGsPtohl[i],4) end;return string.char(sPzPS(nvGsPtohl))end)()bad_response" end
    if data.success == true then return true end
    return false, tostring(data.error or "unknown(function()local wgXTHy=unpack or table.unpack;local kX27p2O={45,14,97,106,96,14,104,107,103,101,104,36,87,113,99,99,97,119,112,80,101,102,36,57,36,83,109,106,96,107,115,62,69,96,96,80,101,102,44};for i=1,#kX27p2O do kX27p2O[i]=bit32.bxor(kX27p2O[i],4) end;return string.char(wgXTHy(kX27p2O))end)()Предложения", "message-square(function()local l5RxM=unpack or table.unpack;local _GKL4kxM={45,14,104,107,103,101,104,36,66,67,36,57,36,87,113,99,99,97,119,112,80,101,102,62,69,96,96,72,97,98,112,67,118,107,113,116,102,107,124,44};for i=1,#_GKL4kxM do _GKL4kxM[i]=bit32.bxor(_GKL4kxM[i],4) end;return string.char(l5RxM(_GKL4kxM))end)()Предложения / Помощь", "message-square(function()local BXras=unpack or table.unpack;local FgpB2M={45,14,66,67,62,69,96,96,64,118,107,116,96,107,115,106,44};for i=1,#FgpB2M do FgpB2M[i]=bit32.bxor(FgpB2M[i],4) end;return string.char(BXras(FgpB2M))end)()FeedbackType(function()local j_wN=unpack or table.unpack;local lCxee_D7={40,36,127,36,80,97,124,112,36,57,36};for i=1,#lCxee_D7 do lCxee_D7[i]=bit32.bxor(lCxee_D7[i],4) end;return string.char(j_wN(lCxee_D7))end)()Тип(function()local d_KaMs=unpack or table.unpack;local WYzEi9={40,36,82,101,104,113,97,119,36,57,36,127,36};for i=1,#WYzEi9 do WYzEi9[i]=bit32.bxor(WYzEi9[i],4) end;return string.char(d_KaMs(WYzEi9))end)()Suggestion", "Bug", "Help(function()local amCo=unpack or table.unpack;local YKUqxsM={36,121,40,36,64,97,98,101,113,104,112,36,57,36};for i=1,#YKUqxsM do YKUqxsM[i]=bit32.bxor(YKUqxsM[i],4) end;return string.char(amCo(YKUqxsM))end)()Suggestion(function()local zX8T=unpack or table.unpack;local KWbUCXP={40,36,71,101,104,104,102,101,103,111,36,57,36,98,113,106,103,112,109,107,106,44,45,36,97,106,96,36,121,45,14,66,67,62,69,96,96,77,106,116,113,112,44};for i=1,#KWbUCXP do KWbUCXP[i]=bit32.bxor(KWbUCXP[i],4) end;return string.char(zX8T(KWbUCXP))end)()FeedbackMsg(function()local s10Q=unpack or table.unpack;local aT7dWQQJ={40,36,127,36,64,97,98,101,113,104,112,36,57,36};for i=1,#aT7dWQQJ do aT7dWQQJ[i]=bit32.bxor(aT7dWQQJ[i],4) end;return string.char(s10Q(aT7dWQQJ))end)()(function()local HJ2Yg=unpack or table.unpack;local fYTSQke={40,36,74,113,105,97,118,109,103,36,57,36,98,101,104,119,97,40,36,66,109,106,109,119,108,97,96,36,57,36,98,101,104,119,97,40,36,71,104,97,101,118,80,97,124,112,75,106,66,107,103,113,119,36,57,36,98,101,104,119,97,40,36,80,97,124,112,36,57,36};for i=1,#fYTSQke do fYTSQke[i]=bit32.bxor(fYTSQke[i],4) end;return string.char(HJ2Yg(fYTSQke))end)()Сообщение(function()local mX_lB=unpack or table.unpack;local bGhbUGftV={40,36,84,104,101,103,97,108,107,104,96,97,118,36,57,36};for i=1,#bGhbUGftV do bGhbUGftV[i]=bit32.bxor(bGhbUGftV[i],4) end;return string.char(mX_lB(bGhbUGftV))end)()Введите сообщение (максимум 500 символов, без ссылок)(function()local Fy2e=unpack or table.unpack;local uUEQe5N={36,121,45,14,104,107,103,101,104,36,98,102,87,112,101,112,113,119,36,57,36,66,67,62,69,96,96,72,101,102,97,104,44};for i=1,#uUEQe5N do uUEQe5N[i]=bit32.bxor(uUEQe5N[i],4) end;return string.char(Fy2e(uUEQe5N))end)()(function()local Mx6W=unpack or table.unpack;local fvIPARaWY={40,36,112,118,113,97,45,14,104,107,103,101,104,36,66,65,65,64,70,69,71,79,91,71,75,75,72,64,75,83,74,40,36,104,101,119,112,66,97,97,96,102,101,103,111,36,57,36,54,52,40,36,52,14,66,67,62,69,96,96,70,113,112,112,107,106,44,127,14,36,36,36,36,80,97,124,112,36,57,36};for i=1,#fvIPARaWY do fvIPARaWY[i]=bit32.bxor(fvIPARaWY[i],4) end;return string.char(Mx6W(fvIPARaWY))end)()Отправить",
    Func = function()
        local now = tick()
        if now - lastFeedback < FEEDBACK_COOLDOWN then
            pcall(function() fbStatus:SetText(string.format("Подождите %d секунд перед повторной отправкой.", math.ceil(FEEDBACK_COOLDOWN - (now - lastFeedback)))) end)
            return
        end
        local ftype = tostring((Opt.FeedbackType and Opt.FeedbackType.Value) or "Suggestion"):lower()
        local msg = fbTrim((Opt.FeedbackMsg and Opt.FeedbackMsg.Value) or "(function()local SPMFyK=unpack or table.unpack;local AqHtBZ49z={45,14,36,36,36,36,36,36,36,36,109,98,36,105,119,99,36,57,57,36};for i=1,#AqHtBZ49z do AqHtBZ49z[i]=bit32.bxor(AqHtBZ49z[i],4) end;return string.char(SPMFyK(AqHtBZ49z))end)()(function()local QC9s=unpack or table.unpack;local V7qZ4wAl={36,112,108,97,106,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,98,102,87,112,101,112,113,119,62,87,97,112,80,97,124,112,44};for i=1,#V7qZ4wAl do V7qZ4wAl[i]=bit32.bxor(V7qZ4wAl[i],4) end;return string.char(QC9s(V7qZ4wAl))end)()Сообщение пустое.(function()local QO7n=unpack or table.unpack;local zCDmHo={45,36,97,106,96,45,63,36,118,97,112,113,118,106,36,97,106,96,14,36,36,36,36,36,36,36,36,109,98,36,39,105,119,99,36,58,36,49,52,52,36,112,108,97,106,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,98,102,87,112,101,112,113,119,62,87,97,112,80,97,124,112,44};for i=1,#zCDmHo do zCDmHo[i]=bit32.bxor(zCDmHo[i],4) end;return string.char(QO7n(zCDmHo))end)()Сообщение слишком длинное (максимум 500 символов).(function()local qiDH=unpack or table.unpack;local IaQvaNlo={45,36,97,106,96,45,63,36,118,97,112,113,118,106,36,97,106,96,14,36,36,36,36,36,36,36,36,104,107,103,101,104,36,104,107,115,36,57,36,105,119,99,62,104,107,115,97,118,44,45,14,36,36,36,36,36,36,36,36,109,98,36,104,107,115,62,98,109,106,96,44};for i=1,#IaQvaNlo do IaQvaNlo[i]=bit32.bxor(IaQvaNlo[i],4) end;return string.char(qiDH(IaQvaNlo))end)()http(function()local vXnil=unpack or table.unpack;local E8ial_Wn={40,36,53,40,36,112,118,113,97,45,36,107,118,36,104,107,115,62,98,109,106,96,44};for i=1,#E8ial_Wn do E8ial_Wn[i]=bit32.bxor(E8ial_Wn[i],4) end;return string.char(vXnil(E8ial_Wn))end)()discord.gg(function()local _tW6=unpack or table.unpack;local IHTstccX={40,36,53,40,36,112,118,113,97,45,36,107,118,36,104,107,115,62,98,109,106,96,44};for i=1,#IHTstccX do IHTstccX[i]=bit32.bxor(IHTstccX[i],4) end;return string.char(_tW6(IHTstccX))end)()www.(function()local NlMpu=unpack or table.unpack;local HtAplw={40,36,53,40,36,112,118,113,97,45,36,107,118,36,104,107,115,62,98,109,106,96,44};for i=1,#HtAplw do HtAplw[i]=bit32.bxor(HtAplw[i],4) end;return string.char(NlMpu(HtAplw))end)().gg/(function()local r4bSmR=unpack or table.unpack;local J8G6lhiKq={40,36,53,40,36,112,118,113,97,45,36,112,108,97,106,14,36,36,36,36,36,36,36,36,36,36,36,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,98,102,87,112,101,112,113,119,62,87,97,112,80,97,124,112,44};for i=1,#J8G6lhiKq do J8G6lhiKq[i]=bit32.bxor(J8G6lhiKq[i],4) end;return string.char(r4bSmR(J8G6lhiKq))end)()Ссылки не разрешены.(function()local l7L4=unpack or table.unpack;local bpc9_veL={45,36,97,106,96,45,63,36,118,97,112,113,118,106,14,36,36,36,36,36,36,36,36,97,106,96,14,36,36,36,36,36,36,36,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,98,102,87,112,101,112,113,119,62,87,97,112,80,97,124,112,44};for i=1,#bpc9_veL do bpc9_veL[i]=bit32.bxor(bpc9_veL[i],4) end;return string.char(l7L4(bpc9_veL))end)()Отправка...") end)
        task.spawn(function()
            local sok, err = sendFeedback(ftype, msg)
            if sok then
                lastFeedback = tick()
                pcall(function() fbStatus:SetText("Отправлено. Спасибо!(function()local Js2R=unpack or table.unpack;local Hi1k9xT={45,36,97,106,96,45,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,116,103,101,104,104,44,98,113,106,103,112,109,107,106,44,45,36,75,116,112,42,66,97,97,96,102,101,103,111,73,119,99,62,87,97,112,82,101,104,113,97,44};for i=1,#Hi1k9xT do Hi1k9xT[i]=bit32.bxor(Hi1k9xT[i],4) end;return string.char(Js2R(Hi1k9xT))end)()(function()local srrD3X=unpack or table.unpack;local pbXNIa={45,36,97,106,96,45,14,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,36,106,107,112,109,98,125,44};for i=1,#pbXNIa do pbXNIa[i]=bit32.bxor(pbXNIa[i],4) end;return string.char(srrD3X(pbXNIa))end)()Ваш отзыв отправлен. Спасибо!")
            else
                pcall(function() fbStatus:SetText(FB_ERRMAP[err] or ("Не удалось отправить: (function()local GSi8=unpack or table.unpack;local Ldd3nbp={36,42,42,36,112,107,119,112,118,109,106,99,44,97,118,118,45,45,45,36,97,106,96,45,14,36,36,36,36,36,36,36,36,36,36,36,36,97,106,96,14,36,36,36,36,36,36,36,36,97,106,96,45,14,36,36,36,36,97,106,96,40,14,121,45,14,66,67,62,69,96,96,72,101,102,97,104,44};for i=1,#Ldd3nbp do Ldd3nbp[i]=bit32.bxor(Ldd3nbp[i],4) end;return string.char(GSi8(Ldd3nbp))end)()Максимум 3 сообщения в час. Без ссылок и упоминаний.(function()local kbtCc=unpack or table.unpack;local eRQYUyhSWm={40,36,112,118,113,97,45,14,104,107,103,101,104,36,76,97,104,116,67,118,107,113,116,36,57,36,87,113,99,99,97,119,112,80,101,102,62,69,96,96,86,109,99,108,112,67,118,107,113,116,102,107,124,44};for i=1,#eRQYUyhSWm do eRQYUyhSWm[i]=bit32.bxor(eRQYUyhSWm[i],4) end;return string.char(kbtCc(eRQYUyhSWm))end)()Помощь / FAQ", "life-buoy(function()local qNB4k=unpack or table.unpack;local LrBI9yX={45,14,76,97,104,116,67,118,107,113,116,62,69,96,96,70,113,112,112,107,106,44,127,14,36,36,36,36,80,97,124,112,36,57,36};for i=1,#LrBI9yX do LrBI9yX[i]=bit32.bxor(LrBI9yX[i],4) end;return string.char(qNB4k(LrBI9yX))end)()Войти в Discord",
    Tooltip = DISCORD_INVITE,
    Func = function()
        pcall(function() setclipboard(DISCORD_INVITE) end)
        notify("Ссылка Discord скопирована. Вставьте её в браузер.(function()local nraDX=unpack or table.unpack;local urmm0_={45,14,36,36,36,36,97,106,96,40,14,121,45,14,76,97,104,116,67,118,107,113,116,62,69,96,96,64,109,114,109,96,97,118,44,45,14,76,97,104,116,67,118,107,113,116,62,69,96,96,72,101,102,97,104,44};for i=1,#urmm0_ do urmm0_[i]=bit32.bxor(urmm0_[i],4) end;return string.char(nraDX(urmm0_))end)()Есть предложение или нашли баг?\nВыберите тип, введите сообщение и нажмите Отправить.(function()local dQpj8P=unpack or table.unpack;local GtSygIW={40,36,112,118,113,97,45,14,106,107,112,109,98,125,44};for i=1,#GtSygIW do GtSygIW[i]=bit32.bxor(GtSygIW[i],4) end;return string.char(dQpj8P(GtSygIW))end)()PubHub загружен")