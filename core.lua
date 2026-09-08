if _G.__CW_CLEAN then pcall(_G.__CW_CLEAN) end
local RUNNING = true
local CONNS = {}
local CLEANERS = {}
local function track(c) if c then CONNS[#CONNS + 1] = c end return c end
local function onClean(fn) CLEANERS[#CLEANERS + 1] = fn end
_G.__CW_CLEAN = function()
    RUNNING = false
    for _, c in ipairs(CONNS) do pcall(function() c:Disconnect() end) end
    for _, fn in ipairs(CLEANERS) do pcall(fn) end
    CONNS = {}; CLEANERS = {}
end
local cloneref = cloneref or clonereference or function(x) return x end
local RS         = cloneref(game:GetService((function()local ErekzTB=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local eIv8oS8a=unpack or table.unpack; local JEQ4gdPgQ={46,25,12,16,21,31,29,8,25,24,47,8,19,14,29,27,25};for i=1,#JEQ4gdPgQ do JEQ4gdPgQ[i]=ErekzTB(JEQ4gdPgQ[i],124) end;return string.char(eIv8oS8a(JEQ4gdPgQ))end)()))
local Players    = cloneref(game:GetService((function()local hMPURg8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Pj_tdiu=unpack or table.unpack; local EMpH7Q={44,16,29,5,25,14,15};for i=1,#EMpH7Q do EMpH7Q[i]=hMPURg8(EMpH7Q[i],124) end;return string.char(Pj_tdiu(EMpH7Q))end)()))
local RunService = cloneref(game:GetService((function()local cD9rb0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local tT5rF2=unpack or table.unpack; local wpf_W98L={46,9,18,47,25,14,10,21,31,25};for i=1,#wpf_W98L do wpf_W98L[i]=cD9rb0(wpf_W98L[i],124) end;return string.char(tT5rF2(wpf_W98L))end)()))
local Workspace  = cloneref(game:GetService((function()local vxO_R0t_e1=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local yTWEwaM=unpack or table.unpack; local XgAVRqy={43,19,14,23,15,12,29,31,25};for i=1,#XgAVRqy do XgAVRqy[i]=vxO_R0t_e1(XgAVRqy[i],124) end;return string.char(yTWEwaM(XgAVRqy))end)()))
local PPS        = cloneref(game:GetService((function()local ZKL5pPMR=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local D5jfRzdPN=unpack or table.unpack; local aRpTDkf={44,14,19,4,21,17,21,8,5,44,14,19,17,12,8,47,25,14,10,21,31,25};for i=1,#aRpTDkf do aRpTDkf[i]=ZKL5pPMR(aRpTDkf[i],124) end;return string.char(D5jfRzdPN(aRpTDkf))end)()))
local TeleportService = cloneref(game:GetService((function()local uv6cByiz4b=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local SB1T1RsQ2=unpack or table.unpack; local i2ocEApUep={40,25,16,25,12,19,14,8,47,25,14,10,21,31,25};for i=1,#i2ocEApUep do i2ocEApUep[i]=uv6cByiz4b(i2ocEApUep[i],124) end;return string.char(SB1T1RsQ2(i2ocEApUep))end)()))
local HttpService     = cloneref(game:GetService((function()local wDkEUgABbx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local azjSBPCz8=unpack or table.unpack; local zfkdeE={52,8,8,12,47,25,14,10,21,31,25};for i=1,#zfkdeE do zfkdeE[i]=wDkEUgABbx(zfkdeE[i],124) end;return string.char(azjSBPCz8(zfkdeE))end)()))
local CollectionService = cloneref(game:GetService((function()local KxnjhId=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local vUQTZhz=unpack or table.unpack; local M6MCQZc={63,19,16,16,25,31,8,21,19,18,47,25,14,10,21,31,25};for i=1,#M6MCQZc do M6MCQZc[i]=KxnjhId(M6MCQZc[i],124) end;return string.char(vUQTZhz(M6MCQZc))end)()))
local UIS        = cloneref(game:GetService((function()local Y5wafUv=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local wu0J_CI=unpack or table.unpack; local L9uMsm0={41,15,25,14,53,18,12,9,8,47,25,14,10,21,31,25};for i=1,#L9uMsm0 do L9uMsm0[i]=Y5wafUv(L9uMsm0[i],124) end;return string.char(wu0J_CI(L9uMsm0))end)()))
local Lighting   = cloneref(game:GetService((function()local PgwRoOqKAS=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local neT_vKm9=unpack or table.unpack; local xGW2aEeZ8={48,21,27,20,8,21,18,27};for i=1,#xGW2aEeZ8 do xGW2aEeZ8[i]=PgwRoOqKAS(xGW2aEeZ8[i],124) end;return string.char(neT_vKm9(xGW2aEeZ8))end)()))
local lp         = Players.LocalPlayer
local Opt, Toggles, Nav
local NAMECHARS = (function()local cgaoTPxC=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fJ6aoF_08=unpack or table.unpack; local n77Dxhg={29,30,31,24,25,26,27,20,21,22,23,16,17,18,19,12,13,14,15,8,9,10,11,4,5,6,61,62,63,56,57,58,59,52,53,54,55,48,49,50,51,44,45,46,47,40,41,42,43,36,37,38,76,77,78,79,72,73,74,75,68,69};for i=1,#n77Dxhg do n77Dxhg[i]=cgaoTPxC(n77Dxhg[i],124) end;return string.char(fJ6aoF_08(n77Dxhg))end)()
local function randomName()
    local out = {}
    for i = 1, math.random(10, 18) do local k = math.random(1, #NAMECHARS); out[i] = NAMECHARS:sub(k, k) end
    return table.concat(out)
end
local function hiddenParent(gui)
    local h = gethui or get_hidden_gui
    if type(h) == (function()local HKKERV0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Gnpwsd7=unpack or table.unpack; local D0B59mST={26,9,18,31,8,21,19,18};for i=1,#D0B59mST do D0B59mST[i]=HKKERV0(D0B59mST[i],124) end;return string.char(Gnpwsd7(D0B59mST))end)() then local ok, dest = pcall(h); if ok and dest then gui.Parent = dest; return end end
    if syn and type(syn.protect_gui) == (function()local Rl1w05=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local khiqtKJYE=unpack or table.unpack; local ZvHBHgjY={26,9,18,31,8,21,19,18};for i=1,#ZvHBHgjY do ZvHBHgjY[i]=Rl1w05(ZvHBHgjY[i],124) end;return string.char(khiqtKJYE(ZvHBHgjY))end)() then pcall(function() syn.protect_gui(gui) end); gui.Parent = cloneref(game:GetService((function()local GoxRpT=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Dp1cec_zNl=unpack or table.unpack; local oTIeuE2={63,19,14,25,59,9,21};for i=1,#oTIeuE2 do oTIeuE2[i]=GoxRpT(oTIeuE2[i],124) end;return string.char(Dp1cec_zNl(oTIeuE2))end)())); return end
    if protectgui then pcall(function() protectgui(gui) end) end
    gui.Parent = lp:WaitForChild((function()local cNjwcA9D=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local VzsFFv=unpack or table.unpack; local bflNNA4_0f={44,16,29,5,25,14,59,9,21};for i=1,#bflNNA4_0f do bflNNA4_0f[i]=cNjwcA9D(bflNNA4_0f[i],124) end;return string.char(VzsFFv(bflNNA4_0f))end)())
end
local function hrp() local c = lp.Character; return c and c:FindFirstChild((function()local NKRanVyD=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local uraxA9q=unpack or table.unpack; local HplSYOJ={52,9,17,29,18,19,21,24,46,19,19,8,44,29,14,8};for i=1,#HplSYOJ do HplSYOJ[i]=NKRanVyD(HplSYOJ[i],124) end;return string.char(uraxA9q(HplSYOJ))end)()) end
local function tpTo(p) local h = hrp(); if h and typeof(p) == (function()local L4kUyT=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ZRSV92JS=unpack or table.unpack; local op5efR={42,25,31,8,19,14,79};for i=1,#op5efR do op5efR[i]=L4kUyT(op5efR[i],124) end;return string.char(ZRSV92JS(op5efR))end)() then h.CFrame = CFrame.new(p) * (h.CFrame - h.CFrame.Position); h.AssemblyLinearVelocity = Vector3.zero; h.AssemblyAngularVelocity = Vector3.zero end end
local function humanoid() local c = lp.Character; return c and c:FindFirstChildWhichIsA((function()local RdaV015=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Bul0Za=unpack or table.unpack; local eie8sL8zz={52,9,17,29,18,19,21,24};for i=1,#eie8sL8zz do eie8sL8zz[i]=RdaV015(eie8sL8zz[i],124) end;return string.char(Bul0Za(eie8sL8zz))end)()) end
local function reqmod(inst) if not inst then return nil end local ok, m = pcall(require, inst); if ok then return m end return nil end
local Shared  = RS:WaitForChild((function()local nVZTOEn=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local dopxeC=unpack or table.unpack; local NYoCNBYAA={47,20,29,14,25,24};for i=1,#NYoCNBYAA do NYoCNBYAA[i]=nVZTOEn(NYoCNBYAA[i],124) end;return string.char(dopxeC(NYoCNBYAA))end)(), 10) or RS:FindFirstChild((function()local gt4hGmpko=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local f9AOCpAo=unpack or table.unpack; local HjD08ua={47,20,29,14,25,24};for i=1,#HjD08ua do HjD08ua[i]=gt4hGmpko(HjD08ua[i],124) end;return string.char(f9AOCpAo(HjD08ua))end)())
local ClientF = RS:WaitForChild((function()local CtiL7IdF=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _M7WAv=unpack or table.unpack; local kbL1aRf={63,16,21,25,18,8};for i=1,#kbL1aRf do kbL1aRf[i]=CtiL7IdF(kbL1aRf[i],124) end;return string.char(_M7WAv(kbL1aRf))end)(), 10) or RS:FindFirstChild((function()local BuIGYtvZa5=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _8UaP4=unpack or table.unpack; local YQ57vZa={63,16,21,25,18,8};for i=1,#YQ57vZa do YQ57vZa[i]=BuIGYtvZa5(YQ57vZa[i],124) end;return string.char(_8UaP4(YQ57vZa))end)())
local DataF   = RS:WaitForChild((function()local IvegC6iS=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local xc589oN=unpack or table.unpack; local Rhk7c0g={56,29,8,29};for i=1,#Rhk7c0g do Rhk7c0g[i]=IvegC6iS(Rhk7c0g[i],124) end;return string.char(xc589oN(Rhk7c0g))end)(), 10) or RS:FindFirstChild((function()local dMeKj1=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local CBAAZ3=unpack or table.unpack; local q0vUmYMAp={56,29,8,29};for i=1,#q0vUmYMAp do q0vUmYMAp[i]=dMeKj1(q0vUmYMAp[i],124) end;return string.char(CBAAZ3(q0vUmYMAp))end)())
local Remotes  = reqmod(Shared and Shared:FindFirstChild((function()local VyzqrOV=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local AregYw=unpack or table.unpack; local heLzaoMBmn={46,25,17,19,8,25,15};for i=1,#heLzaoMBmn do heLzaoMBmn[i]=VyzqrOV(heLzaoMBmn[i],124) end;return string.char(AregYw(heLzaoMBmn))end)()))
local EggState = reqmod(ClientF and ClientF:FindFirstChild((function()local pGIQYa=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _qgoogea=unpack or table.unpack; local b0crG8IQ={57,27,27,47,8,29,8,25};for i=1,#b0crG8IQ do b0crG8IQ[i]=pGIQYa(b0crG8IQ[i],124) end;return string.char(_qgoogea(b0crG8IQ))end)()))
local PlotState = reqmod(ClientF and ClientF:FindFirstChild((function()local Vbrkaf=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local tBrQDquv=unpack or table.unpack; local IZk6hL={44,16,19,8,47,8,29,8,25};for i=1,#IZk6hL do IZk6hL[i]=Vbrkaf(IZk6hL[i],124) end;return string.char(tBrQDquv(IZk6hL))end)()))
local Assets   = reqmod(DataF and DataF:FindFirstChild((function()local qMO9zP=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local EtcF3G=unpack or table.unpack; local jxEnaNo={61,15,15,25,8,15};for i=1,#jxEnaNo do jxEnaNo[i]=qMO9zP(jxEnaNo[i],124) end;return string.char(EtcF3G(jxEnaNo))end)()))
local SaveMod  = reqmod(Shared and Shared:FindFirstChild((function()local TDDU5PLx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local j6QUmED=unpack or table.unpack; local TGWZs1cdDs={47,29,10,25};for i=1,#TGWZs1cdDs do TGWZs1cdDs[i]=TDDU5PLx(TGWZs1cdDs[i],124) end;return string.char(j6QUmED(TGWZs1cdDs))end)()))
local NAME_MAP = {
    [(function()local pMCe7s5f=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Mk8WbZW=unpack or table.unpack; local CKZUF633I={63,29,14,14,5};for i=1,#CKZUF633I do CKZUF633I[i]=pMCe7s5f(CKZUF633I[i],124) end;return string.char(Mk8WbZW(CKZUF633I))end)()]       = { (function()local q4zD_J=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local G7DGsT1G1r=unpack or table.unpack; local viCRw_={57,27,27,43,19,14,16,24};for i=1,#viCRw_ do viCRw_[i]=q4zD_J(viCRw_[i],124) end;return string.char(G7DGsT1G1r(viCRw_))end)(), (function()local N_ANj1H=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local omxtGF=unpack or table.unpack; local mnxojjuR={61,15,23,58,21,25,16,24,57,27,27,63,29,14,14,5};for i=1,#mnxojjuR do mnxojjuR[i]=N_ANj1H(mnxojjuR[i],124) end;return string.char(omxtGF(mnxojjuR))end)() },
    [(function()local p0BsdWvnwk=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local MLclDQuMRT=unpack or table.unpack; local _F4LP49_x={56,14,19,12};for i=1,#_F4LP49_x do _F4LP49_x[i]=p0BsdWvnwk(_F4LP49_x[i],124) end;return string.char(MLclDQuMRT(_F4LP49_x))end)()]        = { (function()local MNa1d248=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local BIgow0I=unpack or table.unpack; local Y3k5FHK={57,27,27,43,19,14,16,24};for i=1,#Y3k5FHK do Y3k5FHK[i]=MNa1d248(Y3k5FHK[i],124) end;return string.char(BIgow0I(Y3k5FHK))end)(), (function()local ebm1YJ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local NOwm_G6=unpack or table.unpack; local o570zAXV7={61,15,23,58,21,25,16,24,57,27,27,56,14,19,12};for i=1,#o570zAXV7 do o570zAXV7[i]=ebm1YJ(o570zAXV7[i],124) end;return string.char(NOwm_G6(o570zAXV7))end)() },
    [(function()local l7xe9u=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local S9xRlWFSP=unpack or table.unpack; local JrJLwP2Rlb={44,16,29,31,25};for i=1,#JrJLwP2Rlb do JrJLwP2Rlb[i]=l7xe9u(JrJLwP2Rlb[i],124) end;return string.char(S9xRlWFSP(JrJLwP2Rlb))end)()]       = { (function()local TJBCyyJQ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local BzvUpUe=unpack or table.unpack; local ryrJbK={57,27,27,43,19,14,16,24};for i=1,#ryrJbK do ryrJbK[i]=TJBCyyJQ(ryrJbK[i],124) end;return string.char(BzvUpUe(ryrJbK))end)(), (function()local OqPQbDx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local aaeBKYgUFB=unpack or table.unpack; local hdBotfk={61,15,23,44,16,29,31,25,57,27,27};for i=1,#hdBotfk do hdBotfk[i]=OqPQbDx(hdBotfk[i],124) end;return string.char(aaeBKYgUFB(hdBotfk))end)() },
    [(function()local ej5pHek=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local wWHtr0wP0g=unpack or table.unpack; local PDk227zu={47,18,29,12,15,20,19,8};for i=1,#PDk227zu do PDk227zu[i]=ej5pHek(PDk227zu[i],124) end;return string.char(wWHtr0wP0g(PDk227zu))end)()]    = { (function()local fD_VRWOo9u=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local PhnIXF5=unpack or table.unpack; local ozdoMzjNM={57,27,27,43,19,14,16,24};for i=1,#ozdoMzjNM do ozdoMzjNM[i]=fD_VRWOo9u(ozdoMzjNM[i],124) end;return string.char(PhnIXF5(ozdoMzjNM))end)(), (function()local zYSGhm2Y=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local GMUfPVbu3=unpack or table.unpack; local lYeLvCyz={61,15,23,58,21,25,16,24,57,27,27,47,18,29,12,15,20,19,8};for i=1,#lYeLvCyz do lYeLvCyz[i]=zYSGhm2Y(lYeLvCyz[i],124) end;return string.char(GMUfPVbu3(lYeLvCyz))end)() },
    [(function()local plkmhJx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local qnqVMv6u63=unpack or table.unpack; local PdALyoW={52,29,8,31,20};for i=1,#PdALyoW do PdALyoW[i]=plkmhJx(PdALyoW[i],124) end;return string.char(qnqVMv6u63(PdALyoW))end)()]       = { (function()local lxEOrTM=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local p3e3cXjd=unpack or table.unpack; local lp3IHK3={57,27,27,43,19,14,16,24};for i=1,#lp3IHK3 do lp3IHK3[i]=lxEOrTM(lp3IHK3[i],124) end;return string.char(p3e3cXjd(lp3IHK3))end)(), (function()local N71Js9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local b3VGYCp=unpack or table.unpack; local HSwJz5k4f={61,15,23,52,29,8,31,20};for i=1,#HSwJz5k4f do HSwJz5k4f[i]=N71Js9(HSwJz5k4f[i],124) end;return string.char(b3VGYCp(HSwJz5k4f))end)() },
    [(function()local k1oA_Jtq9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local VcrH4K=unpack or table.unpack; local g3q0YH4Z={58,21,18,21,15,20,52,29,8,31,20};for i=1,#g3q0YH4Z do g3q0YH4Z[i]=k1oA_Jtq9(g3q0YH4Z[i],124) end;return string.char(VcrH4K(g3q0YH4Z))end)()] = { (function()local HQQ2ZzU=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Qznd23BW8=unpack or table.unpack; local gRLBsDl2={57,27,27,43,19,14,16,24};for i=1,#gRLBsDl2 do gRLBsDl2[i]=HQQ2ZzU(gRLBsDl2[i],124) end;return string.char(Qznd23BW8(gRLBsDl2))end)(), (function()local yAnNIKFZ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local YAbiYA=unpack or table.unpack; local KkzV5Mi5Ik={61,15,23,58,21,18,21,15,20,52,29,8,31,20};for i=1,#KkzV5Mi5Ik do KkzV5Mi5Ik[i]=yAnNIKFZ(KkzV5Mi5Ik[i],124) end;return string.char(YAbiYA(KkzV5Mi5Ik))end)() },
    [(function()local LTP5PF=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local S3HXCyUq9=unpack or table.unpack; local TwPcaYeOld={48,25,29,10,25,40,14,25,29,24};for i=1,#TwPcaYeOld do TwPcaYeOld[i]=LTP5PF(TwPcaYeOld[i],124) end;return string.char(S3HXCyUq9(TwPcaYeOld))end)()]  = { (function()local uy1_X5n=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ueE47jtv=unpack or table.unpack; local tgQEJEH={40,14,25,29,24,17,21,16,16};for i=1,#tgQEJEH do tgQEJEH[i]=uy1_X5n(tgQEJEH[i],124) end;return string.char(ueE47jtv(tgQEJEH))end)(), (function()local GJHJnHIfEE=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local bTxqiF1=unpack or table.unpack; local M_sX3Iey5f={61,15,23,56,19,26,26};for i=1,#M_sX3Iey5f do M_sX3Iey5f[i]=GJHJnHIfEE(M_sX3Iey5f[i],124) end;return string.char(bTxqiF1(M_sX3Iey5f))end)() },
    [(function()local r4Iaqw426=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local kapGbSof=unpack or table.unpack; local yCC2IeJ={57,13,9,21,12,62,25,15,8};for i=1,#yCC2IeJ do yCC2IeJ[i]=r4Iaqw426(yCC2IeJ[i],124) end;return string.char(kapGbSof(yCC2IeJ))end)()]   = { (function()local Gd3dOE=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local u9R8hup=unpack or table.unpack; local RLUYUnLLa={52,29,9,16};for i=1,#RLUYUnLLa do RLUYUnLLa[i]=Gd3dOE(RLUYUnLLa[i],124) end;return string.char(u9R8hup(RLUYUnLLa))end)(), (function()local Z8CP9Pm=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local po6RvbBu3d=unpack or table.unpack; local SiHTKq9s={43,25,29,14,62,25,15,8};for i=1,#SiHTKq9s do SiHTKq9s[i]=Z8CP9Pm(SiHTKq9s[i],124) end;return string.char(po6RvbBu3d(SiHTKq9s))end)() },
    [(function()local d1JHSQBzG=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local T_7wZyJwEu=unpack or table.unpack; local hdAqApAcY2={47,25,16,16,44,25,8,15};for i=1,#hdAqApAcY2 do hdAqApAcY2[i]=d1JHSQBzG(hdAqApAcY2[i],124) end;return string.char(T_7wZyJwEu(hdAqApAcY2))end)()]    = { (function()local F7c76gw=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local RQNQ8xV9w5=unpack or table.unpack; local vJ7_PUTTi={44,25,8,47,29,8,31,20,25,16};for i=1,#vJ7_PUTTi do vJ7_PUTTi[i]=F7c76gw(vJ7_PUTTi[i],124) end;return string.char(RQNQ8xV9w5(vJ7_PUTTi))end)(), (function()local feEK3a0AR=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ZamSFqNS=unpack or table.unpack; local osPSRCP={47,25,16,16,57,10,25,14,5,44,25,8};for i=1,#osPSRCP do osPSRCP[i]=feEK3a0AR(osPSRCP[i],124) end;return string.char(ZamSFqNS(osPSRCP))end)() },
    [(function()local RRcJGA=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local oPsOK4Hdj=unpack or table.unpack; local iARPoc={62,16,19,19,17,52,21,8};for i=1,#iARPoc do iARPoc[i]=RRcJGA(iARPoc[i],124) end;return string.char(oPsOK4Hdj(iARPoc))end)()]    = { (function()local n1lgaU61M=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local jPvvDhW=unpack or table.unpack; local ZrSiLAvw={62,16,19,19,17,25,14,5};for i=1,#ZrSiLAvw do ZrSiLAvw[i]=n1lgaU61M(ZrSiLAvw[i],124) end;return string.char(jPvvDhW(ZrSiLAvw))end)(), (function()local jXBKyhPgQj=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local zkd0Yw=unpack or table.unpack; local OMf4XzQZ7V={61,15,23,47,8,14,21,23,25,40,14,25,25};for i=1,#OMf4XzQZ7V do OMf4XzQZ7V[i]=jXBKyhPgQj(OMf4XzQZ7V[i],124) end;return string.char(zkd0Yw(OMf4XzQZ7V))end)() },
    [(function()local qCDOPfc=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Bp0nfI6M=unpack or table.unpack; local QrmhZwBKeB={62,16,19,19,17,59,29,8,20,25,14};for i=1,#QrmhZwBKeB do QrmhZwBKeB[i]=qCDOPfc(QrmhZwBKeB[i],124) end;return string.char(Bp0nfI6M(QrmhZwBKeB))end)()] = { (function()local IlSwU0T0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local PzwwYb=unpack or table.unpack; local pkaGhF583m={62,16,19,19,17,25,14,5};for i=1,#pkaGhF583m do pkaGhF583m[i]=IlSwU0T0(pkaGhF583m[i],124) end;return string.char(PzwwYb(pkaGhF583m))end)(), (function()local kNoQuoU4n=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local E0jW0wcr=unpack or table.unpack; local OcaUhR={61,15,23,59,29,8,20,25,14,44,25,8,29,16};for i=1,#OcaUhR do OcaUhR[i]=kNoQuoU4n(OcaUhR[i],124) end;return string.char(E0jW0wcr(OcaUhR))end)() },
    [(function()local VByesI=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local W5FRi4=unpack or table.unpack; local uT3ZMUTJ3={47,29,23,9,14,29,53,18,15,25,14,8};for i=1,#uT3ZMUTJ3 do uT3ZMUTJ3[i]=VByesI(uT3ZMUTJ3[i],124) end;return string.char(W5FRi4(uT3ZMUTJ3))end)()] = { (function()local cgLHmSsCI=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local EaK_WJKSR=unpack or table.unpack; local MEKPlSs={62,16,19,19,17,25,14,5};for i=1,#MEKPlSs do MEKPlSs[i]=cgLHmSsCI(MEKPlSs[i],124) end;return string.char(EaK_WJKSR(MEKPlSs))end)(), (function()local YO6dPPji=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local gVMM3w3G=unpack or table.unpack; local qVqTnY={61,15,23,48,19,29,24,57,27,27};for i=1,#qVqTnY do qVqTnY[i]=YO6dPPji(qVqTnY[i],124) end;return string.char(gVMM3w3G(qVqTnY))end)() },
    [(function()local uuTJ0pe=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local s4Psf6=unpack or table.unpack; local JaDJL_={47,29,23,9,14,29,56,25,12,19,15,21,8};for i=1,#JaDJL_ do JaDJL_[i]=uuTJ0pe(JaDJL_[i],124) end;return string.char(s4Psf6(JaDJL_))end)()] = { (function()local Do9C5nq6fW=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local jZ9TIQ=unpack or table.unpack; local gdWHwqM={62,16,19,19,17,25,14,5};for i=1,#gdWHwqM do gdWHwqM[i]=Do9C5nq6fW(gdWHwqM[i],124) end;return string.char(jZ9TIQ(gdWHwqM))end)(), (function()local KNte9lYPE=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local n3GdRC9U=unpack or table.unpack; local blzjOqoYB={61,15,23,52,29,18,24,19,26,26};for i=1,#blzjOqoYB do blzjOqoYB[i]=KNte9lYPE(blzjOqoYB[i],124) end;return string.char(n3GdRC9U(blzjOqoYB))end)() },
    [(function()local vfITNgVuc_=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local t6JmPAncC=unpack or table.unpack; local POecLo0w={47,29,23,9,14,29,49,9,8,29,8,25};for i=1,#POecLo0w do POecLo0w[i]=vfITNgVuc_(POecLo0w[i],124) end;return string.char(t6JmPAncC(POecLo0w))end)()] = { (function()local DEoMnd=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local YC8yap=unpack or table.unpack; local ta1mvOCk={62,16,19,19,17,25,14,5};for i=1,#ta1mvOCk do ta1mvOCk[i]=DEoMnd(ta1mvOCk[i],124) end;return string.char(YC8yap(ta1mvOCk))end)(), (function()local QO1mj0_Hwu=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local DssqcfseoY=unpack or table.unpack; local a3C3sMK={61,15,23,49,9,8,29,8,25};for i=1,#a3C3sMK do a3C3sMK[i]=QO1mj0_Hwu(a3C3sMK[i],124) end;return string.char(DssqcfseoY(a3C3sMK))end)() },
    [(function()local IVMoje=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local S5t0bCz=unpack or table.unpack; local Ghfrsp={63,16,29,21,17,53,18,24,25,4};for i=1,#Ghfrsp do Ghfrsp[i]=IVMoje(Ghfrsp[i],124) end;return string.char(S5t0bCz(Ghfrsp))end)()]  = { (function()local ia6fig1A=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local jP_3xKn=unpack or table.unpack; local Khjgdz6Pb={63,19,24,25,4};for i=1,#Khjgdz6Pb do Khjgdz6Pb[i]=ia6fig1A(Khjgdz6Pb[i],124) end;return string.char(jP_3xKn(Khjgdz6Pb))end)(), (function()local JSXJvxemfB=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local hUKqaqsp=unpack or table.unpack; local gBmvGQS={61,15,23,46,25,24,25,25,17,61,16,16};for i=1,#gBmvGQS do gBmvGQS[i]=JSXJvxemfB(gBmvGQS[i],124) end;return string.char(hUKqaqsp(gBmvGQS))end)() },
    [(function()local K7W6Q9Pr=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local eJzs_IR=unpack or table.unpack; local BgNyZg9={43,25,29,14,62,29,8};for i=1,#BgNyZg9 do BgNyZg9[i]=K7W6Q9Pr(BgNyZg9[i],124) end;return string.char(eJzs_IR(BgNyZg9))end)()]     = { (function()local LmZOvBApw=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local M0B5l4=unpack or table.unpack; local jVoyeVM={63,19,24,25,4};for i=1,#jVoyeVM do jVoyeVM[i]=LmZOvBApw(jVoyeVM[i],124) end;return string.char(M0B5l4(jVoyeVM))end)(), (function()local G4qWUSa=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fOzspdr=unpack or table.unpack; local ncNwFYKH6h={61,15,23,43,25,29,14,58,21,25,16,24,62,29,8};for i=1,#ncNwFYKH6h do ncNwFYKH6h[i]=G4qWUSa(ncNwFYKH6h[i],124) end;return string.char(fOzspdr(ncNwFYKH6h))end)() },
    [(function()local pi76Ywc1S9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local aSFzpI_T=unpack or table.unpack; local w5VQxKe41={58,9,15,25,48,19,29,24};for i=1,#w5VQxKe41 do w5VQxKe41[i]=pi76Ywc1S9(w5VQxKe41[i],124) end;return string.char(aSFzpI_T(w5VQxKe41))end)()]    = { (function()local y8GrvgkfG=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local IdqfeW=unpack or table.unpack; local dfzppMFT4={58,9,15,25,14,5};for i=1,#dfzppMFT4 do dfzppMFT4[i]=y8GrvgkfG(dfzppMFT4[i],124) end;return string.char(IdqfeW(dfzppMFT4))end)(), (function()local ZKGxPimpbA=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Nsw1ca=unpack or table.unpack; local VvfjIQ={48,19,29,24,44,25,8};for i=1,#VvfjIQ do VvfjIQ[i]=ZKGxPimpbA(VvfjIQ[i],124) end;return string.char(Nsw1ca(VvfjIQ))end)() },
    [(function()local xm6Q6Mh=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fZegrD=unpack or table.unpack; local yfQAOgo={58,9,15,25,63,19,18,26,21,14,17};for i=1,#yfQAOgo do yfQAOgo[i]=xm6Q6Mh(yfQAOgo[i],124) end;return string.char(fZegrD(yfQAOgo))end)()] = { (function()local gSWL6GXp=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local KLJJqRRm=unpack or table.unpack; local z9j6ZdMxuE={58,9,15,25,14,5};for i=1,#z9j6ZdMxuE do z9j6ZdMxuE[i]=gSWL6GXp(z9j6ZdMxuE[i],124) end;return string.char(KLJJqRRm(z9j6ZdMxuE))end)(), (function()local m6G60_=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local UhwagR=unpack or table.unpack; local P4ZNRiQn={63,19,18,26,21,14,17,62,14,21,25,26,21,18,27};for i=1,#P4ZNRiQn do P4ZNRiQn[i]=m6G60_(P4ZNRiQn[i],124) end;return string.char(UhwagR(P4ZNRiQn))end)() },
    [(function()local jbtbIPp=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local uecdTbVzG=unpack or table.unpack; local WBP8Pk4z={58,9,15,25,62,25,27,21,18};for i=1,#WBP8Pk4z do WBP8Pk4z[i]=jbtbIPp(WBP8Pk4z[i],124) end;return string.char(uecdTbVzG(WBP8Pk4z))end)()]   = { (function()local se8C35k=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local GBL0Qag6=unpack or table.unpack; local If69CN0B={58,9,15,25,14,5};for i=1,#If69CN0B do If69CN0B[i]=se8C35k(If69CN0B[i],124) end;return string.char(GBL0Qag6(If69CN0B))end)(), (function()local FXvcVhe7a=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local D7ivaTw=unpack or table.unpack; local ZOVhDJs={62,25,27,21,18,58,9,15,25};for i=1,#ZOVhDJs do ZOVhDJs[i]=FXvcVhe7a(ZOVhDJs[i],124) end;return string.char(D7ivaTw(ZOVhDJs))end)() },
    [(function()local o7w1o8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local aTLO8RTy=unpack or table.unpack; local v_LCDdQp1f={58,9,15,25,58,21,18,21,15,20};for i=1,#v_LCDdQp1f do v_LCDdQp1f[i]=o7w1o8(v_LCDdQp1f[i],124) end;return string.char(aTLO8RTy(v_LCDdQp1f))end)()]  = { (function()local YrRlTs=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local f7szxlKHZr=unpack or table.unpack; local _W9d71S4={58,9,15,25,14,5};for i=1,#_W9d71S4 do _W9d71S4[i]=YrRlTs(_W9d71S4[i],124) end;return string.char(f7szxlKHZr(_W9d71S4))end)(), (function()local qLD2NcHdIA=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local qe2Xski=unpack or table.unpack; local TueEMn={58,21,18,21,15,20,46,25,10,25,29,16};for i=1,#TueEMn do TueEMn[i]=qLD2NcHdIA(TueEMn[i],124) end;return string.char(qe2Xski(TueEMn))end)() },
    [(function()local TIWRKcpID=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local evqbD9Z62a=unpack or table.unpack; local gU0IFz={58,9,15,25,57,22,25,31,8};for i=1,#gU0IFz do gU0IFz[i]=TIWRKcpID(gU0IFz[i],124) end;return string.char(evqbD9Z62a(gU0IFz))end)()]   = { (function()local be8Zm6NA=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local i8C73Co1=unpack or table.unpack; local zMN7CDBw8={58,9,15,25,14,5};for i=1,#zMN7CDBw8 do zMN7CDBw8[i]=be8Zm6NA(zMN7CDBw8[i],124) end;return string.char(i8C73Co1(zMN7CDBw8))end)(), (function()local H0lgJT=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local uo3hTkc=unpack or table.unpack; local YKFqHXbgOC={57,22,25,31,8,44,25,8};for i=1,#YKFqHXbgOC do YKFqHXbgOC[i]=H0lgJT(YKFqHXbgOC[i],124) end;return string.char(uo3hTkc(YKFqHXbgOC))end)() },
}
local function remoteFor(name)
    local e = NAME_MAP[name]; if not e or not Remotes then return nil end
    local g = Remotes[e[1]]; return g and g[e[2]]
end
local function inv(name, arg)
    local r = remoteFor(name); if not r then return end
    local ok, a = pcall(function() if arg == nil then return r:InvokeServer() else return r:InvokeServer(arg) end end)
    if ok then return a end
end
local function fire(name, arg)
    local r = remoteFor(name); if not r then return end
    pcall(function() if arg == nil then r:FireServer() else r:FireServer(arg) end end)
end
local fieldCache = {}
local function refreshField()
    local snap
    if Remotes and Remotes.EggWorld and Remotes.EggWorld.AskFieldEggSnapshot then
        local ok, s = pcall(function() return Remotes.EggWorld.AskFieldEggSnapshot:InvokeServer() end)
        if ok then snap = s end
    end
    local recs = snap and snap.Records
    if type(recs) == (function()local BTgluZlqdK=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local S9meZo=unpack or table.unpack; local UmtDQZ={8,29,30,16,25};for i=1,#UmtDQZ do UmtDQZ[i]=BTgluZlqdK(UmtDQZ[i],124) end;return string.char(S9meZo(UmtDQZ))end)() then
        local out = {}
        for _, rec in ipairs(recs) do if rec and rec.Uid then out[rec.Uid] = rec end end
        fieldCache = out
    elseif EggState and EggState.ReadFieldEggs then
        local ok, rows = pcall(function() return EggState.ReadFieldEggs() end)
        if ok and type(rows) == (function()local JbOG0dB=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local jIssYCTWC=unpack or table.unpack; local bQcuI5C6C={8,29,30,16,25};for i=1,#bQcuI5C6C do bQcuI5C6C[i]=JbOG0dB(bQcuI5C6C[i],124) end;return string.char(jIssYCTWC(bQcuI5C6C))end)() then fieldCache = rows end
    end
end
task.spawn(function() while RUNNING do pcall(refreshField); task.wait(2) end end)
local function eggRecord(uid) return fieldCache[uid] end
local cachedSave
task.spawn(function()
    while RUNNING do
        if SaveMod then
            local ok, s = pcall(function()
                if SaveMod.IsLocalDataLoaded and SaveMod.IsLocalDataLoaded() and SaveMod.Cache then return SaveMod.Cache()[lp] end
                return SaveMod.Get and SaveMod.Get()
            end)
            if ok and s then cachedSave = s end
        end
        task.wait(1)
    end
end)
local function save() return cachedSave end
local function myEggs()
    if EggState and EggState.ReadOwnerEggs then local o, r = pcall(EggState.ReadOwnerEggs, lp.UserId); if o and type(r) == (function()local Ebqnyz1=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local l4nvQUM=unpack or table.unpack; local subKg3CKB={8,29,30,16,25};for i=1,#subKg3CKB do subKg3CKB[i]=Ebqnyz1(subKg3CKB[i],124) end;return string.char(l4nvQUM(subKg3CKB))end)() then return r end end
    return {}
end
local function eggReady(uid)
    if EggState and EggState.IsReadyToHatch then local o, r = pcall(EggState.IsReadyToHatch, uid); if o then return r end end
    return false
end
local function placeEgg(uid)
    if not (EggState and EggState.PlantEgg and PlotState and PlotState.ResolvePlot) then return false end
    local ok, plot = pcall(PlotState.ResolvePlot)
    if not ok or type(plot) ~= (function()local j6Q09a=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local I7Glw3ciY=unpack or table.unpack; local Fq05NHn={8,29,30,16,25};for i=1,#Fq05NHn do Fq05NHn[i]=j6Q09a(Fq05NHn[i],124) end;return string.char(I7Glw3ciY(Fq05NHn))end)() or not plot.PetArea or not plot.CenterPoint then return false end
    local pa = plot.PetArea
    local lx = (math.random() - 0.5) * pa.Size.X * 0.8
    local lz = (math.random() - 0.5) * pa.Size.Z * 0.8
    local world = (pa.CFrame * CFrame.new(lx, pa.Size.Y * 0.5 + 1, lz)).Position
    local localCF = plot.CenterPoint.CFrame:ToObjectSpace(CFrame.new(world))
    return (pcall(EggState.PlantEgg, uid, localCF))
end
local resetUntilServer = 0
task.spawn(function()
    local sig = EggState and EggState.ResetCountdown
    if sig and sig.Connect then pcall(function() sig:Connect(function(p)
        if type(p) == (function()local LGTtPX2SN=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local BoDSzes_=unpack or table.unpack; local rRhsrX={8,29,30,16,25};for i=1,#rRhsrX do rRhsrX[i]=LGTtPX2SN(rRhsrX[i],124) end;return string.char(BoDSzes_(rRhsrX))end)() and type(p.DayStartsAt) == (function()local kuwy49v=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local J93Szc1z=unpack or table.unpack; local uKEGMyS={18,9,17,30,25,14};for i=1,#uKEGMyS do uKEGMyS[i]=kuwy49v(uKEGMyS[i],124) end;return string.char(J93Szc1z(uKEGMyS))end)() then
            resetUntilServer = p.DayStartsAt + 6.5
        else
            resetUntilServer = Workspace:GetServerTimeNow() + 20
        end
    end) end) end
end)
local function stealAllowed() return Workspace:GetServerTimeNow() >= resetUntilServer end
local moveLock = false
local function lockMove()
    local t0 = os.clock()
    while moveLock and os.clock() - t0 < 8 do task.wait(0.05) end
    moveLock = true
end
local function unlockMove() moveLock = false end
local RARITY_ORDER = {
    Common = 1, Basic = 1, Uncommon = 2, SuperRare = 2, Celestial = 2, Rare = 3, Epic = 4,
    Legendary = 5, Mythic = 6, Mythical = 6, Rainbow = 6, [(function()local XZKQeT9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Oh8fK_I8=unpack or table.unpack; local SIz514_={47,13,9,21,15,20,5,92,59,19,24};for i=1,#SIz514_ do SIz514_[i]=XZKQeT9(SIz514_[i],124) end;return string.char(Oh8fK_I8(SIz514_))end)()] = 6,
    Cosmic = 7, Exclusive = 7, Secret = 8, Exotic = 8, Eternal = 9, Limited = 9, Superior = 10, Divine = 10,
}
local RARITY_LIST   = { (function()local nIThrO2fU=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local i96qtG1n=unpack or table.unpack; local t3gYyv={63,19,17,17,19,18};for i=1,#t3gYyv do t3gYyv[i]=nIThrO2fU(t3gYyv[i],124) end;return string.char(i96qtG1n(t3gYyv))end)(), (function()local XvYNSQ4=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local pSPynkQ=unpack or table.unpack; local H2AMzb={41,18,31,19,17,17,19,18};for i=1,#H2AMzb do H2AMzb[i]=XvYNSQ4(H2AMzb[i],124) end;return string.char(pSPynkQ(H2AMzb))end)(), (function()local qAwaVF9sO=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local KrYsn7E=unpack or table.unpack; local vcwhHzNr={47,9,12,25,14,46,29,14,25};for i=1,#vcwhHzNr do vcwhHzNr[i]=qAwaVF9sO(vcwhHzNr[i],124) end;return string.char(KrYsn7E(vcwhHzNr))end)(), (function()local RmGcly8E=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local wtCCzs=unpack or table.unpack; local eHuwpm={63,25,16,25,15,8,21,29,16};for i=1,#eHuwpm do eHuwpm[i]=RmGcly8E(eHuwpm[i],124) end;return string.char(wtCCzs(eHuwpm))end)(), (function()local DTdFq9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local sBa0HDFiH_=unpack or table.unpack; local MkrWuC={46,29,14,25};for i=1,#MkrWuC do MkrWuC[i]=DTdFq9(MkrWuC[i],124) end;return string.char(sBa0HDFiH_(MkrWuC))end)(), (function()local qFss2b7Bpr=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local sZiED9=unpack or table.unpack; local xjsqYMUe={57,12,21,31};for i=1,#xjsqYMUe do xjsqYMUe[i]=qFss2b7Bpr(xjsqYMUe[i],124) end;return string.char(sZiED9(xjsqYMUe))end)(), (function()local XcWqYpnAZZ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local iQrufWzV=unpack or table.unpack; local OD7EgJO={48,25,27,25,18,24,29,14,5};for i=1,#OD7EgJO do OD7EgJO[i]=XcWqYpnAZZ(OD7EgJO[i],124) end;return string.char(iQrufWzV(OD7EgJO))end)(), (function()local lhNXYiPpl9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local jzUElhq=unpack or table.unpack; local bv8AbdeTfp={49,5,8,20,21,31};for i=1,#bv8AbdeTfp do bv8AbdeTfp[i]=lhNXYiPpl9(bv8AbdeTfp[i],124) end;return string.char(jzUElhq(bv8AbdeTfp))end)(), (function()local YB9pZv8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local lDxLVefr0=unpack or table.unpack; local Ige5ZpI={46,29,21,18,30,19,11};for i=1,#Ige5ZpI do Ige5ZpI[i]=YB9pZv8(Ige5ZpI[i],124) end;return string.char(lDxLVefr0(Ige5ZpI))end)(), (function()local QWZgZuS=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local oLe0LccJV=unpack or table.unpack; local _Sy8Dmc={63,19,15,17,21,31};for i=1,#_Sy8Dmc do _Sy8Dmc[i]=QWZgZuS(_Sy8Dmc[i],124) end;return string.char(oLe0LccJV(_Sy8Dmc))end)(), (function()local UxGodx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local xMJa3HV=unpack or table.unpack; local aSK_30={57,4,31,16,9,15,21,10,25};for i=1,#aSK_30 do aSK_30[i]=UxGodx(aSK_30[i],124) end;return string.char(xMJa3HV(aSK_30))end)(), (function()local m24r0AuQ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local WFpnaz9H=unpack or table.unpack; local V1QC0cgC={47,25,31,14,25,8};for i=1,#V1QC0cgC do V1QC0cgC[i]=m24r0AuQ(V1QC0cgC[i],124) end;return string.char(WFpnaz9H(V1QC0cgC))end)(), (function()local g4jjoY=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local a_dnSM=unpack or table.unpack; local tYQNh6F8YC={57,4,19,8,21,31};for i=1,#tYQNh6F8YC do tYQNh6F8YC[i]=g4jjoY(tYQNh6F8YC[i],124) end;return string.char(a_dnSM(tYQNh6F8YC))end)(), (function()local IKffwO7aNp=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local zPaA7CYyn=unpack or table.unpack; local xczaog={57,8,25,14,18,29,16};for i=1,#xczaog do xczaog[i]=IKffwO7aNp(xczaog[i],124) end;return string.char(zPaA7CYyn(xczaog))end)(), (function()local pHScWTaT=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Iyx37v3etF=unpack or table.unpack; local EWF99XBVo={48,21,17,21,8,25,24};for i=1,#EWF99XBVo do EWF99XBVo[i]=pHScWTaT(EWF99XBVo[i],124) end;return string.char(Iyx37v3etF(EWF99XBVo))end)(), (function()local olD5M0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ywIG7n65h=unpack or table.unpack; local qeN57SP={47,9,12,25,14,21,19,14};for i=1,#qeN57SP do qeN57SP[i]=olD5M0(qeN57SP[i],124) end;return string.char(ywIG7n65h(qeN57SP))end)(), (function()local qX_lMxam=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local j4Dgidk=unpack or table.unpack; local OwJA8wdU={56,21,10,21,18,25};for i=1,#OwJA8wdU do OwJA8wdU[i]=qX_lMxam(OwJA8wdU[i],124) end;return string.char(j4Dgidk(OwJA8wdU))end)() }
local MUTATION_LIST = { (function()local e7VTYR=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local GsmZ6DARZ=unpack or table.unpack; local L28_1R={46,29,21,18,30,19,11};for i=1,#L28_1R do L28_1R[i]=e7VTYR(L28_1R[i],124) end;return string.char(GsmZ6DARZ(L28_1R))end)(), (function()local M6CjAj1=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Mp_70db=unpack or table.unpack; local GziHEK={47,20,19,31,23,25,24};for i=1,#GziHEK do GziHEK[i]=M6CjAj1(GziHEK[i],124) end;return string.char(Mp_70db(GziHEK))end)(), (function()local DwoqyB=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local mtZV25An5g=unpack or table.unpack; local DcHU0x={43,21,18,24,15,8,14,9,31,23};for i=1,#DcHU0x do DcHU0x[i]=DwoqyB(DcHU0x[i],124) end;return string.char(mtZV25An5g(DcHU0x))end)(), (function()local fYuz67=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local M0PYtVV=unpack or table.unpack; local stjyGz6={56,29,11,18,30,19,9,18,24};for i=1,#stjyGz6 do stjyGz6[i]=fYuz67(stjyGz6[i],124) end;return string.char(M0PYtVV(stjyGz6))end)(), (function()local zN3c3bk=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local gHFKcD7peu=unpack or table.unpack; local WFDrpf={40,11,21,15,8,25,24};for i=1,#WFDrpf do WFDrpf[i]=zN3c3bk(WFDrpf[i],124) end;return string.char(gHFKcD7peu(WFDrpf))end)(), (function()local sP1UFf=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local JT5JZdy=unpack or table.unpack; local RgWcaJn={42,19,21,24,8,19,9,31,20,25,24};for i=1,#RgWcaJn do RgWcaJn[i]=sP1UFf(RgWcaJn[i],124) end;return string.char(JT5JZdy(RgWcaJn))end)(), (function()local ft6l6R=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local AqBUXlr_=unpack or table.unpack; local bXvnXP={43,25,8};for i=1,#bXvnXP do bXvnXP[i]=ft6l6R(bXvnXP[i],124) end;return string.char(AqBUXlr_(bXvnXP))end)(), (function()local YCUKsJpW8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local JKl0qySp7h=unpack or table.unpack; local Rx3E3uMLWw={63,20,21,16,16,25,24};for i=1,#Rx3E3uMLWw do Rx3E3uMLWw[i]=YCUKsJpW8(Rx3E3uMLWw[i],124) end;return string.char(JKl0qySp7h(Rx3E3uMLWw))end)(), (function()local xEYr5e=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fL7rRFJjtm=unpack or table.unpack; local UZ5zq4={58,14,19,6,25,18};for i=1,#UZ5zq4 do UZ5zq4[i]=xEYr5e(UZ5zq4[i],124) end;return string.char(fL7rRFJjtm(UZ5zq4))end)(), (function()local F1Vrp44Q3l=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local C08cfzEnl=unpack or table.unpack; local Mbj62CmSi={63,20,19,31};for i=1,#Mbj62CmSi do Mbj62CmSi[i]=F1Vrp44Q3l(Mbj62CmSi[i],124) end;return string.char(C08cfzEnl(Mbj62CmSi))end)(), (function()local OtNIcER=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ilHbvxc007=unpack or table.unpack; local HxlqeX={44,16,29,15,17,29};for i=1,#HxlqeX do HxlqeX[i]=OtNIcER(HxlqeX[i],124) end;return string.char(ilHbvxc007(HxlqeX))end)(), (function()local t6mBPbAcF=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fCFoes3u=unpack or table.unpack; local DU8zz8Vs5c={52,25,29,10,25,18,16,5};for i=1,#DU8zz8Vs5c do DU8zz8Vs5c[i]=t6mBPbAcF(DU8zz8Vs5c[i],124) end;return string.char(fCFoes3u(DU8zz8Vs5c))end)(), (function()local fBN17MafR=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local QmWuLX9=unpack or table.unpack; local dx2xnF2oY={63,29,18,24,5};for i=1,#dx2xnF2oY do dx2xnF2oY[i]=fBN17MafR(dx2xnF2oY[i],124) end;return string.char(QmWuLX9(dx2xnF2oY))end)(), (function()local MX90avTSac=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local HcLskmlC=unpack or table.unpack; local bZzHI4Fgqu={47,29,23,9,14,29};for i=1,#bZzHI4Fgqu do bZzHI4Fgqu[i]=MX90avTSac(bZzHI4Fgqu[i],124) end;return string.char(HcLskmlC(bZzHI4Fgqu))end)(), (function()local PFXmMrX=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local VGMI3qd=unpack or table.unpack; local sGOU6K={59,14,25,29,8,62,16,19,19,17};for i=1,#sGOU6K do sGOU6K[i]=PFXmMrX(sGOU6K[i],124) end;return string.char(VGMI3qd(sGOU6K))end)(), (function()local U_UEVPbx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local wMxXBkF=unpack or table.unpack; local SPB8ylD={62,9,14,18,8};for i=1,#SPB8ylD do SPB8ylD[i]=U_UEVPbx(SPB8ylD[i],124) end;return string.char(wMxXBkF(SPB8ylD))end)(), (function()local VXHeHBUlEJ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local KPeGNE=unpack or table.unpack; local CZ8i0v4={62,16,19,19,24,17,19,19,18};for i=1,#CZ8i0v4 do CZ8i0v4[i]=VXHeHBUlEJ(CZ8i0v4[i],124) end;return string.char(KPeGNE(CZ8i0v4))end)(), (function()local hKHCTMl8n=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local MmVACKWk=unpack or table.unpack; local lYLFcN3K={38,19,17,30,21,26,21,25,24};for i=1,#lYLFcN3K do lYLFcN3K[i]=hKHCTMl8n(lYLFcN3K[i],124) end;return string.char(MmVACKWk(lYLFcN3K))end)(), (function()local fR7IkP=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local oDZa15=unpack or table.unpack; local PKG3DWDW={63,25,16,25,15,8,21,29,16};for i=1,#PKG3DWDW do PKG3DWDW[i]=fR7IkP(PKG3DWDW[i],124) end;return string.char(oDZa15(PKG3DWDW))end)(), (function()local Stau2F=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Op1v37ppNd=unpack or table.unpack; local CESQIUA={52,19,18,25,5,59,16,29,6,25,24};for i=1,#CESQIUA do CESQIUA[i]=Stau2F(CESQIUA[i],124) end;return string.char(Op1v37ppNd(CESQIUA))end)(), (function()local yoECiQWf=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local UFQBm0=unpack or table.unpack; local p5Wi5hjxP={44,19,16,16,21,18,29,8,25,24};for i=1,#p5Wi5hjxP do p5Wi5hjxP[i]=yoECiQWf(p5Wi5hjxP[i],124) end;return string.char(UFQBm0(p5Wi5hjxP))end)(), (function()local zuZDa4A0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local WT58UG=unpack or table.unpack; local sSk6JsQlDB={61,16,12,20,29};for i=1,#sSk6JsQlDB do sSk6JsQlDB[i]=zuZDa4A0(sSk6JsQlDB[i],124) end;return string.char(WT58UG(sSk6JsQlDB))end)(), (function()local MEXjYnIx_e=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local zF79llgqBT=unpack or table.unpack; local aa7zVe_v9={59,19,16,24,25,18};for i=1,#aa7zVe_v9 do aa7zVe_v9[i]=MEXjYnIx_e(aa7zVe_v9[i],124) end;return string.char(zF79llgqBT(aa7zVe_v9))end)(), (function()local DfREdNLRk8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local heQFSNtb=unpack or table.unpack; local Xi1Gw0HT={49,29,27,17,29};for i=1,#Xi1Gw0HT do Xi1Gw0HT[i]=DfREdNLRk8(Xi1Gw0HT[i],124) end;return string.char(heQFSNtb(Xi1Gw0HT))end)(), (function()local ItXYFRO7=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local erGTuGF=unpack or table.unpack; local PJipaZ={47,21,16,10,25,14};for i=1,#PJipaZ do PJipaZ[i]=ItXYFRO7(PJipaZ[i],124) end;return string.char(erGTuGF(PJipaZ))end)(), (function()local UapHng9P0=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local x9eawK8K=unpack or table.unpack; local mi5o9pWmo={47,31,29,14,25,24};for i=1,#mi5o9pWmo do mi5o9pWmo[i]=UapHng9P0(mi5o9pWmo[i],124) end;return string.char(x9eawK8K(mi5o9pWmo))end)() }
local assetCache = {}
local function assetInfo(cat)
    if not cat then return { rarity = nil, weight = nil } end
    if assetCache[cat] then return assetCache[cat] end
    local info = { rarity = nil, weight = nil }
    pcall(function()
        local e = Assets and Assets.Directory and Assets.Directory[cat]
        if e then info.rarity = e.Rarity and (e.Rarity.DisplayName or e.Rarity.Name); info.weight = tonumber(e.ModelWeight) end
    end)
    assetCache[cat] = info
    return info
end
local function eggRank(cat)
    if not cat then return 0 end
    local info = assetInfo(cat)
    local nm = info.rarity
    return (type(nm) == (function()local jJbaCifBq=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local UmLzg1VIMk=unpack or table.unpack; local MKfVSxi1C={15,8,14,21,18,27};for i=1,#MKfVSxi1C do MKfVSxi1C[i]=jJbaCifBq(MKfVSxi1C[i],124) end;return string.char(UmLzg1VIMk(MKfVSxi1C))end)() and RARITY_ORDER[nm]) or 0
end
local function eggScale(uid) local r = eggRecord(uid); return r and tonumber(r.AssetScale) or 1 end
local function canFuseCat(cat)
    if not cat then return false end
    local e = Assets and Assets.Directory and Assets.Directory[cat]
    return not (e and e.CannotFuse == true)
end
local function eggHasMutation(uid, wantSet)
    local r = eggRecord(uid); if not r then return false end
    if r.BaseMutation and wantSet[r.BaseMutation] then return true end
    if r.Mutations then for _, mu in ipairs(r.Mutations) do if wantSet[mu] then return true end end end
    return false
end
local function isUid(n) return #n >= 20 and n:match((function()local Or10KBsEjx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local gn8tash2_N=unpack or table.unpack; local gyJEGqP={34,89,4,87,88};for i=1,#gyJEGqP do gyJEGqP[i]=Or10KBsEjx(gyJEGqP[i],124) end;return string.char(gn8tash2_N(gyJEGqP))end)()) ~= nil end
local function scanEggs()
    local out, seen = {}, {}
    local f = Workspace:FindFirstChild((function()local DuVCnxE=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local xhL2BVZp=unpack or table.unpack; local meh6nA={61,14,25,29,57,27,27,47,16,19,8,15,63,16,21,25,18,8};for i=1,#meh6nA do meh6nA[i]=DuVCnxE(meh6nA[i],124) end;return string.char(xhL2BVZp(meh6nA))end)())
    if f then for _, m in ipairs(f:GetChildren()) do if m:IsA((function()local QY6vVF=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local OhVf5X=unpack or table.unpack; local c7e2j_={49,19,24,25,16};for i=1,#c7e2j_ do c7e2j_[i]=QY6vVF(c7e2j_[i],124) end;return string.char(OhVf5X(c7e2j_))end)()) and not seen[m.Name] then seen[m.Name] = true; out[#out + 1] = m end end end
    for _, m in ipairs(Workspace:GetChildren()) do
        if m:IsA((function()local Sr8iPOWDVJ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local CLwDuMgM=unpack or table.unpack; local SoDr39={49,19,24,25,16};for i=1,#SoDr39 do SoDr39[i]=Sr8iPOWDVJ(SoDr39[i],124) end;return string.char(CLwDuMgM(SoDr39))end)()) and isUid(m.Name) and not seen[m.Name] then seen[m.Name] = true; out[#out + 1] = m end
    end
    return out
end
local homeCF
task.spawn(function() while not homeCF do local h = hrp(); if h then homeCF = h.CFrame end; task.wait(0.5) end end)
local function myCenterPoint()
    local plots = Workspace:FindFirstChild((function()local rHIUZS5=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _s5GlSOpD=unpack or table.unpack; local hxb0Clut={44,16,19,8,15};for i=1,#hxb0Clut do hxb0Clut[i]=rHIUZS5(hxb0Clut[i],124) end;return string.char(_s5GlSOpD(hxb0Clut))end)())
    if not plots then return nil end
    local ref = (homeCF and homeCF.Position) or (hrp() and hrp().Position)
    local best, bestd
    for _, plot in ipairs(plots:GetChildren()) do
        local cp = plot:FindFirstChild((function()local s0vamm=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fHTEPP=unpack or table.unpack; local afr57JId72={63,25,18,8,25,14,44,19,21,18,8};for i=1,#afr57JId72 do afr57JId72[i]=s0vamm(afr57JId72[i],124) end;return string.char(fHTEPP(afr57JId72))end)())
        if cp then
            if ref then local d = (cp.Position - ref).Magnitude; if not bestd or d < bestd then best, bestd = cp, d end
            else best = best or cp end
        end
    end
    return best
end
local function resolveOwnBase()
    if PlotState and PlotState.ResolvePlot then
        local ok, plot = pcall(PlotState.ResolvePlot)
        if ok and type(plot) == (function()local dEw0PWjZ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local tmbFtBSu=unpack or table.unpack; local v55buUk={8,29,30,16,25};for i=1,#v55buUk do v55buUk[i]=dEw0PWjZ(v55buUk[i],124) end;return string.char(tmbFtBSu(v55buUk))end)() then
            if plot.PetArea and plot.PetArea:IsA((function()local ZFpioge6pP=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local atNEX3x=unpack or table.unpack; local RRSm9D={62,29,15,25,44,29,14,8};for i=1,#RRSm9D do RRSm9D[i]=ZFpioge6pP(RRSm9D[i],124) end;return string.char(atNEX3x(RRSm9D))end)()) then
                local pa = plot.PetArea
                return CFrame.new(pa.Position + Vector3.new(0, pa.Size.Y * 0.5 + 3, 0))
            end
            if plot.CenterPoint and plot.CenterPoint:IsA((function()local T0S7l9=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local iv_ogwU=unpack or table.unpack; local SkMij4k={62,29,15,25,44,29,14,8};for i=1,#SkMij4k do SkMij4k[i]=T0S7l9(SkMij4k[i],124) end;return string.char(iv_ogwU(SkMij4k))end)()) then
                return CFrame.new(plot.CenterPoint.Position + Vector3.new(0, 4, 0))
            end
            if typeof(plot.RespawnPointCFrame) == (function()local enNIHX=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local AwnKubUW=unpack or table.unpack; local nB3qxE0={63,58,14,29,17,25};for i=1,#nB3qxE0 do nB3qxE0[i]=enNIHX(nB3qxE0[i],124) end;return string.char(AwnKubUW(nB3qxE0))end)() then return plot.RespawnPointCFrame end
        end
    end
    local cp = myCenterPoint()
    if cp then return CFrame.new(cp.Position + Vector3.new(0, 4, 0)) end
    return nil
end
local function gotoStraight(targetPos, keepGoing, sp)
    local deadline = os.clock() + 25
    while os.clock() < deadline do
        if keepGoing and not keepGoing() then return false end
        local h = hrp(); if not h then return false end
        local d = targetPos - h.Position
        local flat = Vector3.new(d.X, 0, d.Z)
        if flat.Magnitude <= 6 then return true end
        local dt = RunService.Heartbeat:Wait()
        if typeof(dt) ~= (function()local Gn1m4u22n=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local eX_kbO=unpack or table.unpack; local _27XYkxha={18,9,17,30,25,14};for i=1,#_27XYkxha do _27XYkxha[i]=Gn1m4u22n(_27XYkxha[i],124) end;return string.char(eX_kbO(_27XYkxha))end)() or dt <= 0 then dt = 1 / 60 end
        h.CFrame = h.CFrame + flat.Unit * math.min(flat.Magnitude, sp * dt)
    end
    return false
end
local SAFE_ZONE = Vector3.new(497.264, 70.673, -361.122)
local function returnToOwnBase(keepGoing, sp)
    local cf = resolveOwnBase()
    if not cf then return false end
    if Nav and Nav.travelToEggViaLane then Nav.travelToEggViaLane(SAFE_ZONE, keepGoing, sp) end
    return gotoStraight(cf.Position, keepGoing, sp)
end
local function travelOutToEgg(eggPos, keepGoing, sp)
    if typeof(eggPos) ~= (function()local kDcQU7=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local W9S6C7=unpack or table.unpack; local JsRJ45S={42,25,31,8,19,14,79};for i=1,#JsRJ45S do JsRJ45S[i]=kDcQU7(JsRJ45S[i],124) end;return string.char(W9S6C7(JsRJ45S))end)() then return false end
    gotoStraight(SAFE_ZONE, keepGoing, sp)
    if Nav and Nav.travelToEggViaLane then return Nav.travelToEggViaLane(eggPos, keepGoing, sp) end
    return false
end
Nav = {}
do
    Nav.Speed, Nav.ArriveDist, Nav.MoveTimeout = 80, 3, 8
    local _areas, _guard, _laneY, _laneZ
    local function areasFolder()
        if _areas and _areas.Parent then return _areas end
        local obj = Workspace:FindFirstChild((function()local Zx198W=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local fI7J1D9Fv=unpack or table.unpack; local U5XDY93={35,35,51,62,54,57,63,40,47};for i=1,#U5XDY93 do U5XDY93[i]=Zx198W(U5XDY93[i],124) end;return string.char(fI7J1D9Fv(U5XDY93))end)())
        _areas = obj and obj:FindFirstChild((function()local rE4XaNjeqD=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local VmrdTMN=unpack or table.unpack; local diTCtVM={61,14,25,29,15};for i=1,#diTCtVM do diTCtVM[i]=rE4XaNjeqD(diTCtVM[i],124) end;return string.char(VmrdTMN(diTCtVM))end)())
        if not _areas then for _, d in ipairs(Workspace:GetDescendants()) do if d:FindFirstChild((function()local SW0j8YnLE=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local GoSbYNj2X=unpack or table.unpack; local DWrWx1jo={59,29,17,25,12,16,29,5,38};for i=1,#DWrWx1jo do DWrWx1jo[i]=SW0j8YnLE(DWrWx1jo[i],124) end;return string.char(GoSbYNj2X(DWrWx1jo))end)()) or d:FindFirstChild((function()local Kl6pDTEIs=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local CRYQSIL=unpack or table.unpack; local O5bcQQ={47,25,12,29,14,29,8,21,19,18,48,21,18,25};for i=1,#O5bcQQ do O5bcQQ[i]=Kl6pDTEIs(O5bcQQ[i],124) end;return string.char(CRYQSIL(O5bcQQ))end)()) then _areas = d break end end end
        return _areas
    end
    local function guardAreas() if _guard and _guard.Parent then return _guard end local a = areasFolder(); _guard = a and a:FindFirstChild((function()local zWHMGWN4u=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ABx4eCfyE=unpack or table.unpack; local HK9u5SJsr={59,9,29,14,24,61,14,25,29,15};for i=1,#HK9u5SJsr do HK9u5SJsr[i]=zWHMGWN4u(HK9u5SJsr[i],124) end;return string.char(ABx4eCfyE(HK9u5SJsr))end)()); return _guard end
    local function findPart(c, name)
        if not c then return nil end
        local o = c:FindFirstChild(name) or c:FindFirstChild(name, true)
        if not o then return nil end
        if o:IsA((function()local xqXCI1=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local rBthReG=unpack or table.unpack; local nxnifvUzXo={62,29,15,25,44,29,14,8};for i=1,#nxnifvUzXo do nxnifvUzXo[i]=xqXCI1(nxnifvUzXo[i],124) end;return string.char(rBthReG(nxnifvUzXo))end)()) then return o end
        return o:FindFirstChild((function()local ewdgNNxk=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Bm9jniI=unpack or table.unpack; local CQBop3Jo={62,19,9,18,24,15};for i=1,#CQBop3Jo do CQBop3Jo[i]=ewdgNNxk(CQBop3Jo[i],124) end;return string.char(Bm9jniI(CQBop3Jo))end)()) or o:FindFirstChildWhichIsA((function()local RunpuqD=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local n5rft0xyv=unpack or table.unpack; local d_JgRDH5ZO={62,29,15,25,44,29,14,8};for i=1,#d_JgRDH5ZO do d_JgRDH5ZO[i]=RunpuqD(d_JgRDH5ZO[i],124) end;return string.char(n5rft0xyv(d_JgRDH5ZO))end)())
    end
    function Nav.getLaneY()
        if _laneY then return _laneY end
        local gz = findPart(areasFolder(), (function()local _OtBwIui2E=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local dE929xMy=unpack or table.unpack; local F3GCfJcv={59,29,17,25,12,16,29,5,38};for i=1,#F3GCfJcv do F3GCfJcv[i]=_OtBwIui2E(F3GCfJcv[i],124) end;return string.char(dE929xMy(F3GCfJcv))end)()); if gz then _laneY = gz.Position.Y + 3; return _laneY end
        return 73
    end
    function Nav.getLaneZ()
        if _laneZ then return _laneZ end
        local sl = findPart(areasFolder(), (function()local x8N7CQ0N2X=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Ui8ZjrB=unpack or table.unpack; local ro2BjgR={47,25,12,29,14,29,8,21,19,18,48,21,18,25};for i=1,#ro2BjgR do ro2BjgR[i]=x8N7CQ0N2X(ro2BjgR[i],124) end;return string.char(Ui8ZjrB(ro2BjgR))end)()) or findPart(areasFolder(), (function()local jCBY9XB3=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local IBJNuJy=unpack or table.unpack; local eGG7Ad={59,29,17,25,12,16,29,5,38};for i=1,#eGG7Ad do eGG7Ad[i]=jCBY9XB3(eGG7Ad[i],124) end;return string.char(IBJNuJy(eGG7Ad))end)())
        if sl then _laneZ = sl.Position.Z; return _laneZ end
        local r = hrp(); return (r and r.Position.Z) or -365.5
    end
    function Nav.getEntryPosition() local sa = findPart(areasFolder(), (function()local W2r323=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local uj2Ol2Eo=unpack or table.unpack; local hJriq5w4_={47,8,29,14,8,61,14,25,29};for i=1,#hJriq5w4_ do hJriq5w4_[i]=W2r323(hJriq5w4_[i],124) end;return string.char(uj2Ol2Eo(hJriq5w4_))end)()); return Vector3.new((sa and sa.Position.X) or 543.5, Nav.getLaneY(), Nav.getLaneZ()) end
    local function zones() local g = guardAreas(); return g and g:GetChildren() or {} end
    local function zonePart(z) if not z then return nil end if z:IsA((function()local l1Rpc59=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local ioDQxGSs=unpack or table.unpack; local JvMS9pJ={62,29,15,25,44,29,14,8};for i=1,#JvMS9pJ do JvMS9pJ[i]=l1Rpc59(JvMS9pJ[i],124) end;return string.char(ioDQxGSs(JvMS9pJ))end)()) then return z end return z:FindFirstChild((function()local k9fzaI=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local baYtLQ=unpack or table.unpack; local RktcsxV4={62,19,9,18,24,15};for i=1,#RktcsxV4 do RktcsxV4[i]=k9fzaI(RktcsxV4[i],124) end;return string.char(baYtLQ(RktcsxV4))end)()) or z:FindFirstChildWhichIsA((function()local rBX7AdcW5i=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local Vojtrw1AR3=unpack or table.unpack; local SEDIpDZDa={62,29,15,25,44,29,14,8};for i=1,#SEDIpDZDa do SEDIpDZDa[i]=rBX7AdcW5i(SEDIpDZDa[i],124) end;return string.char(Vojtrw1AR3(SEDIpDZDa))end)()) end
    local function zoneLaneCenter(z) local p = zonePart(z); if not p then return nil end return Vector3.new(p.Position.X, Nav.getLaneY(), Nav.getLaneZ()) end
    function Nav.getCorridorBounds()
        local minX, maxX, minZ, maxZ = math.huge, -math.huge, math.huge, -math.huge
        for _, z in ipairs(zones()) do
            local p = zonePart(z)
            if p then
                local hx, hz = p.Size.X * 0.5, p.Size.Z * 0.5
                minX = math.min(minX, p.Position.X - hx); maxX = math.max(maxX, p.Position.X + hx)
                minZ = math.min(minZ, p.Position.Z - hz); maxZ = math.max(maxZ, p.Position.Z + hz)
            end
        end
        local e = Nav.getEntryPosition(); minX = math.min(minX, e.X - 20)
        if minX == math.huge then return nil end
        return minX, maxX, minZ, maxZ
    end
    local function clampToCorridor(pos)
        local a, b, c, d = Nav.getCorridorBounds(); if not a then return pos end
        return Vector3.new(math.clamp(pos.X, a, b), pos.Y, math.clamp(pos.Z, c, d))
    end
    function Nav.groundY(x, z, fb)
        local laneY = Nav.getLaneY()
        local pr = RaycastParams.new(); pr.FilterType = Enum.RaycastFilterType.Exclude; pr.FilterDescendantsInstances = { lp.Character }
        local hit = Workspace:Raycast(Vector3.new(x, laneY + 40, z), Vector3.new(0, -160, 0), pr)
        if hit then return math.clamp(hit.Position.Y + 3, laneY - 2, laneY + 5) end
        return fb or laneY
    end
    function Nav.stealMoveTo(x, z, keepGoing, speed)
        local root = hrp(); if not root then return false end
        local hum = humanoid()
        speed = speed or Nav.Speed
        local deadline = os.clock() + Nav.MoveTimeout
        while RUNNING do
            if os.clock() >= deadline then return false end
            if keepGoing and not keepGoing() then return false end
            root = hrp(); if not root then return false end
            local gy = Nav.groundY(x, z, root.Position.Y)
            local target = Vector3.new(x, gy, z)
            local cur = root.Position
            local delta = target - cur
            local dist = delta.Magnitude
            if dist <= Nav.ArriveDist then
                root.CFrame = CFrame.new(target) * (root.CFrame - root.CFrame.Position)
                root.AssemblyLinearVelocity = Vector3.zero
                return true
            end
            local dt = RunService.Heartbeat:Wait()
            if typeof(dt) ~= (function()local SSiLrId5=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local klCs8Ajwb=unpack or table.unpack; local nppGZp={18,9,17,30,25,14};for i=1,#nppGZp do nppGZp[i]=SSiLrId5(nppGZp[i],124) end;return string.char(klCs8Ajwb(nppGZp))end)() or dt <= 0 then dt = 1 / 60 end
            local dir = delta.Unit
            local newPos = cur + dir * math.min(dist, speed * dt)
            local flat = Vector3.new(dir.X, 0, dir.Z)
            if flat.Magnitude > 0 then root.CFrame = CFrame.lookAt(newPos, newPos + flat)
            else root.CFrame = CFrame.new(newPos) * (root.CFrame - root.CFrame.Position) end
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
            if hum then pcall(function() hum.Sit = false; hum.PlatformStand = false end) end
        end
    end
    local function zoneIndexByX(x)
        local zs = zones(); local best, bestD = 1, math.huge
        for i, z in ipairs(zs) do local c = zoneLaneCenter(z); if c then local dd = math.abs(c.X - x); if dd < bestD then best, bestD = i, dd end end end
        return best
    end
    function Nav.buildLaneWaypoints(target)
        local laneZ, laneY = Nav.getLaneZ(), Nav.getLaneY()
        local root = hrp(); if not root then return {} end
        local wp = {}
        if math.abs(root.Position.Z - laneZ) > 6 then
            wp[#wp + 1] = Vector3.new(root.Position.X, laneY, laneZ)
        end
        wp[#wp + 1] = Vector3.new(target.X, laneY, laneZ)
        return wp
    end
    function Nav.travelToEggViaLane(eggPos, keepGoing, speed)
        local root = hrp()
        if root and (Vector3.new(eggPos.X, root.Position.Y, eggPos.Z) - root.Position).Magnitude <= 35 then
            return Nav.stealMoveTo(eggPos.X, eggPos.Z, keepGoing, speed)
        end
        for _, w in ipairs(Nav.buildLaneWaypoints(eggPos)) do
            if keepGoing and not keepGoing() then return false end
            Nav.stealMoveTo(w.X, w.Z, keepGoing, speed)
        end
        return Nav.stealMoveTo(eggPos.X, eggPos.Z, keepGoing, speed)
    end
    function Nav.returnToBaseViaLane(basePos, keepGoing, speed)
        if typeof(basePos) ~= (function()local CIGsCX=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local nLMDQ97upI=unpack or table.unpack; local g7ZrH9uePn={42,25,31,8,19,14,79};for i=1,#g7ZrH9uePn do g7ZrH9uePn[i]=CIGsCX(g7ZrH9uePn[i],124) end;return string.char(nLMDQ97upI(g7ZrH9uePn))end)() then return false end
        for _, w in ipairs(Nav.buildLaneWaypoints(basePos)) do
            if keepGoing and not keepGoing() then return false end
            Nav.stealMoveTo(w.X, w.Z, keepGoing, speed)
        end
        return Nav.stealMoveTo(basePos.X, basePos.Z, keepGoing, speed)
    end
    function Nav.tweenTo3D(target, keepGoing, speed)
        if typeof(target) ~= (function()local nFV3yre=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local hzPtTb3=unpack or table.unpack; local de7QG8={42,25,31,8,19,14,79};for i=1,#de7QG8 do de7QG8[i]=nFV3yre(de7QG8[i],124) end;return string.char(hzPtTb3(de7QG8))end)() then return false end
        speed = speed or Nav.Speed
        local deadline = os.clock() + 20
        while RUNNING do
            if os.clock() >= deadline then return false end
            if keepGoing and not keepGoing() then return false end
            local root = hrp(); if not root then return false end
            local delta = target - root.Position
            local dist = delta.Magnitude
            if dist <= 5 then return true end
            local dt = RunService.Heartbeat:Wait()
            if typeof(dt) ~= (function()local NsbsGtKzH=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local dGQR991=unpack or table.unpack; local YMMwfI1={18,9,17,30,25,14};for i=1,#YMMwfI1 do YMMwfI1[i]=NsbsGtKzH(YMMwfI1[i],124) end;return string.char(dGQR991(YMMwfI1))end)() or dt <= 0 then dt = 1 / 60 end
            local newPos = root.Position + delta.Unit * math.min(dist, speed * dt)
            root.CFrame = CFrame.new(newPos) * (root.CFrame - root.CFrame.Position)
            root.AssemblyLinearVelocity = Vector3.zero
            root.AssemblyAngularVelocity = Vector3.zero
        end
    end
    function Nav.returnViaLane(basePos, keepGoing, speed)
        if typeof(basePos) ~= (function()local fOApX4=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local tworAWLmgy=unpack or table.unpack; local ezLLxS_OFs={42,25,31,8,19,14,79};for i=1,#ezLLxS_OFs do ezLLxS_OFs[i]=fOApX4(ezLLxS_OFs[i],124) end;return string.char(tworAWLmgy(ezLLxS_OFs))end)() then return false end
        for _, w in ipairs(Nav.buildLaneWaypoints(basePos)) do
            if keepGoing and not keepGoing() then return false end
            Nav.stealMoveTo(w.X, w.Z, keepGoing, speed)
        end
        Nav.tweenTo3D(basePos, keepGoing, speed)
        local root = hrp()
        if root and (root.Position - basePos).Magnitude > 10 then
            Nav.tweenTo3D(basePos, keepGoing, speed)
            root = hrp()
            if root and (root.Position - basePos).Magnitude > 12 then
                root.CFrame = CFrame.new(basePos + Vector3.new(0, 3, 0)) * (root.CFrame - root.CFrame.Position)
                root.AssemblyLinearVelocity = Vector3.zero
            end
        end
        return true
    end
end
local lastCarryPrompt, lastCarryAt = nil, 0
pcall(function()
    PPS.PromptShown:Connect(function(p)
        pcall(function() p.HoldDuration = 0 end)
        local ok, nm = pcall(function() return p.Name end)
        if ok and (nm == (function()local prTXwwMJQJ=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local mYV2NN=unpack or table.unpack; local gYLF3rhU={63,29,14,14,5,61,14,25,29,57,27,27};for i=1,#gYLF3rhU do gYLF3rhU[i]=prTXwwMJQJ(gYLF3rhU[i],124) end;return string.char(mYV2NN(gYLF3rhU))end)() or (p.ObjectText and tostring(p.ObjectText):find((function()local shjbGNRr=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local f_UKdA1M=unpack or table.unpack; local brlpGc={57,27,27};for i=1,#brlpGc do brlpGc[i]=shjbGNRr(brlpGc[i],124) end;return string.char(f_UKdA1M(brlpGc))end)()))) then lastCarryPrompt = p; lastCarryAt = os.clock() end
    end)
end)
local fireprompt = fireproximityprompt or (getgenv and getgenv().fireproximityprompt)
local function fieldEggModel(uid)
    local f = Workspace:FindFirstChild((function()local pQ9AblO8=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local rYvLD5=unpack or table.unpack; local P0TPjfjK={61,14,25,29,57,27,27,47,16,19,8,15,63,16,21,25,18,8};for i=1,#P0TPjfjK do P0TPjfjK[i]=pQ9AblO8(P0TPjfjK[i],124) end;return string.char(rYvLD5(P0TPjfjK))end)())
    if f then local e = f:FindFirstChild(uid); if e then return e end end
    return Workspace:FindFirstChild(uid)
end
local function fieldSlotKey(uid)
    if type(uid) == (function()local y4bJX9l=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local dSTQga0uBR=unpack or table.unpack; local OT3KVzC_sg={15,8,14,21,18,27};for i=1,#OT3KVzC_sg do OT3KVzC_sg[i]=y4bJX9l(OT3KVzC_sg[i],124) end;return string.char(dSTQga0uBR(OT3KVzC_sg))end)() and uid:find((function()local PD8sXOwx=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _STHgyK=unpack or table.unpack; local _PxPYp0qd={58,21,14,15,8,61,14,25,29,57,27,27,35};for i=1,#_PxPYp0qd do _PxPYp0qd[i]=PD8sXOwx(_PxPYp0qd[i],124) end;return string.char(_STHgyK(_PxPYp0qd))end)(), 1, true) == 1 then return nil end
    local r = eggRecord(uid)
    if r and r.AreaId ~= nil and r.NestId ~= nil then return tostring(r.AreaId) .. (function()local ftZwNFr6=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local GqpPChy=unpack or table.unpack; local OeJog2Ky={70};for i=1,#OeJog2Ky do OeJog2Ky[i]=ftZwNFr6(OeJog2Ky[i],124) end;return string.char(GqpPChy(OeJog2Ky))end)() .. tostring(r.NestId) end
    return nil
end
local function grabEgg(m, uid)
    local slotKey = fieldSlotKey(uid)
    if EggState and EggState.CarryFieldEgg then
        pcall(EggState.CarryFieldEgg, uid, slotKey)
    else
        inv((function()local c4L6_94U=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local _MyVGK=unpack or table.unpack; local O7OBULTM={63,29,14,14,5};for i=1,#O7OBULTM do O7OBULTM[i]=c4L6_94U(O7OBULTM[i],124) end;return string.char(_MyVGK(O7OBULTM))end)(), { Uid = uid, FirstAreaSlotKey = slotKey })
    end
    if fireprompt then
        for _, d in ipairs(m:GetDescendants()) do
            if d:IsA((function()local HnoQ0C=bit32 and bit32.bxor or function(a,b) local r,m=0,1 while a>0 or b>0 do local aa,bb=a%2,b%2 if aa~=bb then r=r+m end a=(a-aa)/2 b=(b-bb)/2 m=m*2 end return r end; local R1XSRDXX=unpack or table.unpack; local ESkAzTE8I={44,14,19,4,21,17,21,8,5,44,14,19,17,12,8};for i=1,#ESkAzTE8I do ESkAzTE8I[i]=HnoQ0C(ESkAzTE8I[i],124) end;return string.char(R1XSRDXX(ESkAzTE8I))end)()) then
                local was = d.Enabled
                pcall(function() d.HoldDuration = 0; d.Enabled = true end)
                pcall(fireprompt, d)
                pcall(function() d.Enabled = was end)
            end
        end
        if lastCarryPrompt and lastCarryPrompt.Parent and (os.clock() - lastCarryAt) < 3 then pcall(function() lastCarryPrompt.HoldDuration = 0 end); pcall(fireprompt, lastCarryPrompt) end
    end
end
local M = {}
M.track=track M.onClean=onClean
M.randomName=randomName M.hiddenParent=hiddenParent M.hrp=hrp M.tpTo=tpTo M.humanoid=humanoid M.reqmod=reqmod M.remoteFor=remoteFor
M.inv=inv M.fire=fire M.refreshField=refreshField M.eggRecord=eggRecord M.save=save M.myEggs=myEggs M.eggReady=eggReady
M.placeEgg=placeEgg M.stealAllowed=stealAllowed M.lockMove=lockMove M.unlockMove=unlockMove M.assetInfo=assetInfo
M.eggRank=eggRank M.eggScale=eggScale M.canFuseCat=canFuseCat M.eggHasMutation=eggHasMutation M.isUid=isUid M.scanEggs=scanEggs
M.myCenterPoint=myCenterPoint M.resolveOwnBase=resolveOwnBase M.gotoStraight=gotoStraight M.returnToOwnBase=returnToOwnBase
M.travelOutToEgg=travelOutToEgg M.fieldEggModel=fieldEggModel M.fieldSlotKey=fieldSlotKey M.grabEgg=grabEgg
M.cloneref=cloneref M.RS=RS M.Players=Players M.RunService=RunService M.Workspace=Workspace M.PPS=PPS
M.TeleportService=TeleportService M.HttpService=HttpService M.CollectionService=CollectionService M.UIS=UIS M.Lighting=Lighting
M.lp=lp M.Nav=Nav M.Shared=Shared M.ClientF=ClientF M.DataF=DataF M.Remotes=Remotes M.EggState=EggState M.PlotState=PlotState
M.Assets=Assets M.SaveMod=SaveMod M.NAME_MAP=NAME_MAP M.RARITY_ORDER=RARITY_ORDER M.RARITY_LIST=RARITY_LIST
M.MUTATION_LIST=MUTATION_LIST M.SAFE_ZONE=SAFE_ZONE M.fireprompt=fireprompt
M.isRunning=function() return RUNNING end
M.cleanup=function() if _G.__CW_CLEAN then pcall(_G.__CW_CLEAN) end end
return M