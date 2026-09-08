-- PubHub Loader v1.0
-- Entry point. Splash → Key GUI → Validate → Decrypt → Run main.
-- Этот файл = то, что юзер вставляет через loadstring(game:HttpGet(...))

local PUBHUB_API = "https://pubhub-ruddy.vercel.app"  -- Vercel serverless backend
local MAIN_PAYLOAD_URL = "https://raw.githubusercontent.com/x0100101/pubhub/main/main.lua"  -- obfuscated cheat

-- ─── SERVICE ───────────────────────────────────────────────────────────────
local cloneref = cloneref or clonereference or function(x) return x end
local Players = cloneref(game:GetService("Players"))
local TweenService = cloneref(game:GetService("TweenService"))
local HttpService = cloneref(game:GetService("HttpService"))
local RunService = cloneref(game:GetService("RunService"))
local lp = Players.LocalPlayer

-- ─── HWID ──────────────────────────────────────────────────────────────────
local function gethwid()
    local ok, id = pcall(function()
        local RbxAnalyticsService = cloneref(game:GetService("RbxAnalyticsService"))
        return RbxAnalyticsService:GetClientId()
    end)
    if ok and id and #id > 8 then return id end
    return tostring(lp.UserId) .. "-" .. string.sub(tostring(os.time()), -6)
end
local HWID = gethwid()

-- ─── HTTP ──────────────────────────────────────────────────────────────────
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

-- ─── CLEANUP PREV ──────────────────────────────────────────────────────────
pcall(function()
    local g = getgenv and getgenv() or _G
    if g.__PUBHUB_GUI then pcall(function() g.__PUBHUB_GUI:Destroy() end) end
    if g.__PUBHUB_CLEAN then pcall(g.__PUBHUB_CLEAN) end
end)

-- ─── PARENT ────────────────────────────────────────────────────────────────
local function gethui()
    local ok, r = pcall(function() return gethui() end)
    if ok and r then return r end
    local ok2, cg = pcall(function() return cloneref(game:GetService("CoreGui")) end)
    if ok2 and cg then return cg end
    return lp:WaitForChild("PlayerGui")
end

-- ─── SPLASH SCREEN ─────────────────────────────────────────────────────────
local SplashGui = Instance.new("ScreenGui")
SplashGui.Name = "PubHub_" .. HttpService:GenerateGUID(false):sub(1, 8)
SplashGui.ResetOnSpawn = false
SplashGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SplashGui.DisplayOrder = 999
SplashGui.Parent = gethui()
getgenv().__PUBHUB_GUI = SplashGui

local SplashFrame = Instance.new("Frame")
SplashFrame.Size = UDim2.fromOffset(360, 220)
SplashFrame.Position = UDim2.fromScale(0.5, 0.5)
SplashFrame.AnchorPoint = Vector2.new(0.5, 0.5)
SplashFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 24)
SplashFrame.BorderSizePixel = 0
SplashFrame.Parent = SplashGui

local SplashCorner = Instance.new("UICorner")
SplashCorner.CornerRadius = UDim.new(0, 16)
SplashCorner.Parent = SplashFrame

local SplashStroke = Instance.new("UIStroke")
SplashStroke.Color = Color3.fromRGB(139, 92, 246)
SplashStroke.Thickness = 2
SplashStroke.Transparency = 0
SplashStroke.Parent = SplashFrame

local SplashGradient = Instance.new("UIGradient")
SplashGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 16, 36)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 10, 18)),
})
SplashGradient.Rotation = 45
SplashGradient.Parent = SplashFrame

-- Logo
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.fromOffset(200, 50)
Logo.Position = UDim2.fromScale(0.5, 0.35)
Logo.AnchorPoint = Vector2.new(0.5, 0.5)
Logo.BackgroundTransparency = 1
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 36
Logo.Text = "PubHub"
Logo.TextColor3 = Color3.fromRGB(255, 255, 255)
Logo.TextTransparency = 1
Logo.Parent = SplashFrame

local LogoGrad = Instance.new("UIGradient")
LogoGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(236, 72, 153)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 130, 246)),
})
LogoGrad.Parent = Logo

-- Subtitle
local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.fromOffset(280, 20)
Subtitle.Position = UDim2.fromScale(0.5, 0.55)
Subtitle.AnchorPoint = Vector2.new(0.5, 0.5)
Subtitle.BackgroundTransparency = 1
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 13
Subtitle.Text = "Premium Script Hub"
Subtitle.TextColor3 = Color3.fromRGB(156, 163, 175)
Subtitle.TextTransparency = 1
Subtitle.Parent = SplashFrame

-- Progress bar bg
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.fromOffset(280, 6)
BarBg.Position = UDim2.fromScale(0.5, 0.78)
BarBg.AnchorPoint = Vector2.new(0.5, 0.5)
BarBg.BackgroundColor3 = Color3.fromRGB(28, 30, 46)
BarBg.BorderSizePixel = 0
BarBg.Parent = SplashFrame

local BarBgCorner = Instance.new("UICorner")
BarBgCorner.CornerRadius = UDim.new(1, 0)
BarBgCorner.Parent = BarBg

local Bar = Instance.new("Frame")
Bar.Size = UDim2.fromOffset(0, 6)
Bar.BackgroundColor3 = Color3.fromRGB(139, 92, 246)
Bar.BorderSizePixel = 0
Bar.Parent = BarBg

local BarCorner = Instance.new("UICorner")
BarCorner.CornerRadius = UDim.new(1, 0)
Bar.Parent = Bar

local BarGrad = Instance.new("UIGradient")
BarGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153)),
})
BarGrad.Parent = Bar

-- Status
local Status = Instance.new("TextLabel")
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

-- Splash animations
task.spawn(function()
    -- Entrance
    SplashFrame.GroupTransparency = 1
    SplashFrame.Size = UDim2.fromOffset(280, 170)
    TweenService:Create(SplashFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromOffset(360, 220)
    }):Play()

    TweenService:Create(Logo, TweenInfo.new(0.6, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    task.wait(0.2)
    TweenService:Create(Subtitle, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
    TweenService:Create(Status, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()

    -- Logo pulse
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

    -- Progress bar
    local steps = {
        {0.2, "Checking executor..."},
        {0.5, "Connecting to PubHub..."},
        {0.8, "Verifying HWID..."},
        {1.0, "Ready"},
    }
    for _, s in ipairs(steps) do
        TweenService:Create(Bar, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            Size = UDim2.fromOffset(280 * s[1], 6)
        }):Play()
        Status.Text = s[2]
        task.wait(0.4)
    end

    task.wait(0.3)
    -- Fade out
    TweenService:Create(SplashFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(340, 200),
        BackgroundTransparency = 1
    }):Play()
    for _, d in ipairs(SplashFrame:GetDescendants()) do
        if d:IsA("GuiObject") then
            pcall(function()
                TweenService:Create(d, TweenInfo.new(0.35), {Transparency = 1}):Play()
            end)
            if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                TweenService:Create(d, TweenInfo.new(0.35), {TextTransparency = 1}):Play()
            end
        end
    end
    TweenService:Create(SplashStroke, TweenInfo.new(0.35), {Transparency = 1}):Play()
    task.wait(0.45)
    SplashFrame:Destroy()
end)

task.wait(1.8)

-- ─── KEY GUI ───────────────────────────────────────────────────────────────
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "PubHub_Key_" .. HttpService:GenerateGUID(false):sub(1, 8)
KeyGui.ResetOnSpawn = false
KeyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
KeyGui.DisplayOrder = 998
KeyGui.Parent = gethui()

local Blur = Instance.new("Frame")
Blur.Size = UDim2.fromScale(1, 1)
Blur.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Blur.BackgroundTransparency = 1
Blur.BorderSizePixel = 0
Blur.Parent = KeyGui

local KeyFrame = Instance.new("Frame")
KeyFrame.Size = UDim2.fromOffset(420, 380)
KeyFrame.Position = UDim2.fromScale(0.5, 0.5)
KeyFrame.AnchorPoint = Vector2.new(0.5, 0.5)
KeyFrame.BackgroundColor3 = Color3.fromRGB(13, 15, 26)
KeyFrame.BorderSizePixel = 0
KeyFrame.ClipsDescendants = true
KeyFrame.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 20)
KeyCorner.Parent = KeyFrame

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(139, 92, 246)
KeyStroke.Thickness = 2
KeyStroke.Parent = KeyFrame

local KeyGradient = Instance.new("UIGradient")
KeyGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 18, 40)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 12, 20)),
})
KeyGradient.Rotation = 60
KeyGradient.Parent = KeyFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Position = UDim2.fromOffset(20, 16)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Text = "PubHub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = KeyFrame

local TitleGrad = Instance.new("UIGradient")
TitleGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(139, 92, 246)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(236, 72, 153)),
})
TitleGrad.Parent = Title

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1, -40, 0, 16)
Sub.Position = UDim2.fromOffset(20, 56)
Sub.BackgroundTransparency = 1
Sub.Font = Enum.Font.Gotham
Sub.TextSize = 12
Sub.Text = "Enter your key to continue"
Sub.TextColor3 = Color3.fromRGB(156, 163, 175)
Sub.TextXAlignment = Enum.TextXAlignment.Left
Sub.Parent = KeyFrame

-- Key input
local InputBg = Instance.new("Frame")
InputBg.Size = UDim2.new(1, -40, 0, 44)
InputBg.Position = UDim2.fromOffset(20, 90)
InputBg.BackgroundColor3 = Color3.fromRGB(22, 24, 38)
InputBg.BorderSizePixel = 0
InputBg.Parent = KeyFrame

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 10)
InputCorner.Parent = InputBg

local InputStroke = Instance.new("UIStroke")
InputStroke.Color = Color3.fromRGB(45, 48, 72)
InputStroke.Thickness = 1
InputStroke.Parent = InputBg

local KeyInput = Instance.new("TextBox")
KeyInput.Size = UDim2.new(1, -20, 1, 0)
KeyInput.Position = UDim2.fromOffset(10, 0)
KeyInput.BackgroundTransparency = 1
KeyInput.Font = Enum.Font.Code
KeyInput.TextSize = 14
KeyInput.Text = ""
KeyInput.PlaceholderText = "PUB-XXXX-XXXX-XXXX-XXXX"
KeyInput.PlaceholderColor3 = Color3.fromRGB(80, 85, 110)
KeyInput.TextColor3 = Color3.fromRGB(226, 232, 240)
KeyInput.TextXAlignment = Enum.TextXAlignment.Left
KeyInput.ClearTextOnFocus = false
KeyInput.Parent = InputBg

-- Focus effect
KeyInput.Focused:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(139, 92, 246)}):Play()
end)
KeyInput.FocusLost:Connect(function()
    TweenService:Create(InputStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(45, 48, 72)}):Play()
end)

-- Buttons container
local ButtonsY = 150
local function MakeButton(text, y, primary, onClick)
    local Btn = Instance.new("TextButton")
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

    local BC = Instance.new("UICorner")
    BC.CornerRadius = UDim.new(0, 10)
    BC.Parent = Btn

    local BS = Instance.new("UIStroke")
    BS.Color = primary and Color3.fromRGB(139, 92, 246) or Color3.fromRGB(45, 48, 72)
    BS.Thickness = 1
    BS.Transparency = primary and 0 or 0.5
    BS.Parent = Btn

    if primary then
        local BG = Instance.new("UIGradient")
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

local StatusLbl = Instance.new("TextLabel")
StatusLbl.Size = UDim2.new(1, -40, 0, 18)
StatusLbl.Position = UDim2.fromOffset(20, 320)
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

-- Close btn
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.fromOffset(32, 32)
CloseBtn.Position = UDim2.new(1, -44, 0, 12)
CloseBtn.BackgroundColor3 = Color3.fromRGB(28, 30, 46)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(156, 163, 175)
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = KeyFrame
local CCC = Instance.new("UICorner")
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

-- ─── KEY VALIDATION ────────────────────────────────────────────────────────
local VALIDATED = false
local KEY_DATA = nil

local function validateKey(key)
    setStatus("Checking key...", true)
    local url = string.format("%s/check?key=%s&hw=%s", PUBHUB_API,
        HttpService:UrlEncode(key), HttpService:UrlEncode(HWID))
    local body = httpget(url)
    local data = safejson(body)
    if not data then
        setStatus("Connection failed", false)
        return false
    end
    if data.valid then
        VALIDATED = true
        KEY_DATA = data
        setStatus(string.format("Key valid — %d hours left", math.floor((data.remaining or 0) / 3600)), true)
        return true
    else
        setStatus(data.error or "Invalid key", false)
        return false
    end
end

local function getLootlabsLink(checkpoints)
    setStatus(string.format("Generating %d-checkpoint link...", checkpoints), true)
    local url = string.format("%s/getlink?hw=%s&c=%d", PUBHUB_API,
        HttpService:UrlEncode(HWID), checkpoints)
    local body = httpget(url)
    local data = safejson(body)
    if not data then
        setStatus("Connection failed", false)
        return nil
    end
    if data.url then
        pcall(function() setclipboard(data.url) end)
        setStatus(string.format("Link copied! %d checkpoints = %d hours", checkpoints, data.hours or 0), true)
        return data.url
    else
        setStatus(data.error or "Failed to generate link", false)
        return nil
    end
end

local function proceedToMain()
    -- Fade key gui out
    TweenService:Create(KeyFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(0, 0),
        BackgroundTransparency = 1
    }):Play()
    task.wait(0.4)
    KeyGui:Destroy()
    SplashGui:Destroy()

    -- Fetch main payload через общий httpget (fallback-обёртку)
    local payload = httpget(MAIN_PAYLOAD_URL)
    if not payload or #payload < 100 then
        warn("[PubHub] Failed to fetch main payload")
        return
    end

    -- Payload уже обфусцированный самодостаточный скрипт — просто исполняем
    local fn, err = loadstring(payload)
    if not fn then
        warn("[PubHub] Payload load error: " .. tostring(err))
        return
    end
    local ok, runerr = pcall(fn)
    if not ok then
        warn("[PubHub] Payload runtime error: " .. tostring(runerr))
    end
end

-- Buttons
MakeButton("Validate Key", 150, true, function()
    local k = KeyInput.Text:gsub("%s+", ""):upper()
    if #k < 10 then
        setStatus("Key too short", false)
        return
    end
    if validateKey(k) then
        task.wait(0.5)
        proceedToMain()
    end
end)

MakeButton("Get Key — 12 hours (2 checkpoints)", 200, false, function()
    getLootlabsLink(2)
end)

MakeButton("Get Key — 24 hours (3 checkpoints)", 250, false, function()
    getLootlabsLink(3)
end)

MakeButton("Get Key — 48 hours (5 checkpoints)", 300, false, function()
    getLootlabsLink(5)
end)

-- Entrance animation
KeyFrame.Size = UDim2.fromOffset(0, 0)
KeyFrame.BackgroundTransparency = 1
TweenService:Create(Blur, TweenInfo.new(0.5), {BackgroundTransparency = 0.6}):Play()
TweenService:Create(KeyFrame, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.fromOffset(420, 380),
    BackgroundTransparency = 0
}):Play()

-- Dragging (только по Title-зоне, чтобы не ломать кнопки)
local UIS = cloneref(game:GetService("UserInputService"))
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
