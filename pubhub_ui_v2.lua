-- ═══════════════════════════════════════════════════════════════════════════
-- PubHub UI Library v2 — GLASSMORPHISM EDITION
-- Анимированные orbs, mesh gradients, parallax, shimmer, depth-of-field
-- Визуальный уровень: Linear / Raycast / Arc
-- ═══════════════════════════════════════════════════════════════════════════

local PubHubUI = {}
PubHubUI.__index = PubHubUI

local cloneref = cloneref or clonereference or function(x) return x end
local Players = cloneref(game:GetService("Players"))
local TweenService = cloneref(game:GetService("TweenService"))
local RunService = cloneref(game:GetService("RunService"))
local UIS = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local lp = Players.LocalPlayer

-- ─── Theme ─────────────────────────────────────────────────────────────────
local Theme = {
    BG_0 = Color3.fromRGB(6, 8, 14),          -- deepest
    BG_1 = Color3.fromRGB(11, 13, 22),        -- main
    BG_2 = Color3.fromRGB(17, 20, 33),        -- card
    BG_3 = Color3.fromRGB(24, 28, 45),        -- elevated
    BG_Glass = Color3.fromRGB(20, 24, 40),    -- glass panel

    Accent = Color3.fromRGB(139, 92, 246),    -- violet
    Accent2 = Color3.fromRGB(236, 72, 153),   -- pink
    Accent3 = Color3.fromRGB(59, 130, 246),   -- blue
    Accent4 = Color3.fromRGB(34, 211, 238),   -- cyan

    Text_0 = Color3.fromRGB(248, 250, 252),   -- brightest
    Text_1 = Color3.fromRGB(203, 213, 225),   -- normal
    Text_2 = Color3.fromRGB(148, 163, 184),   -- dim
    Text_3 = Color3.fromRGB(100, 116, 139),   -- muted

    Success = Color3.fromRGB(52, 211, 153),
    Warning = Color3.fromRGB(251, 191, 36),
    Error = Color3.fromRGB(248, 113, 113),

    Border = Color3.fromRGB(38, 42, 68),
    Border_Light = Color3.fromRGB(71, 75, 110),

    TweenFast = TweenInfo.new(0.18, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TweenMed = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TweenSlow = TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TweenSpring = TweenInfo.new(0.7, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, false, 0),
    TweenElastic = TweenInfo.new(0.9, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
    TweenBounce = TweenInfo.new(0.5, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out),
}

-- ─── Helpers ───────────────────────────────────────────────────────────────
local function new(className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then pcall(function() inst[k] = v end) end
    end
    if props and props.Parent then inst.Parent = props.Parent end
    return inst
end

local function tween(obj, info, props)
    return TweenService:Create(obj, info, props):Play()
end

local function gradient(parent, colorStops, c2, rotation)
    -- Формы вызова:
    --   gradient(parent, { [0]=Color3, [1]=Color3 }, rotation)  — stops table
    --   gradient(parent, Color3, Color3, rotation)              — два цвета
    if typeof(colorStops) == "Color3" then
        colorStops = { [0] = colorStops, [1] = c2 or colorStops }
        rotation = c2 == nil and 45 or (typeof(c2) == "number" and c2 or rotation)
        if typeof(c2) == "number" then rotation = c2 end
    end
    local keypoints = {}
    local positions = {}
    for pos in pairs(colorStops) do table.insert(positions, pos) end
    table.sort(positions)
    for _, pos in ipairs(positions) do
        table.insert(keypoints, ColorSequenceKeypoint.new(pos, colorStops[pos]))
    end
    return new("UIGradient", {
        Parent = parent,
        Color = ColorSequence.new(keypoints),
        Rotation = rotation or 45,
    })
end

local function corner(parent, radius)
    return new("UICorner", { Parent = parent, CornerRadius = radius or UDim.new(0, 12) })
end

local function stroke(parent, color, thickness, transparency)
    return new("UIStroke", {
        Parent = parent,
        Color = color or Theme.Border,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
end

local function padding(parent, top, right, bottom, left)
    if type(top) == "number" and not right then
        right = top; bottom = top; left = top
    end
    return new("UIPadding", {
        Parent = parent,
        PaddingTop = UDim.new(0, top or 0),
        PaddingRight = UDim.new(0, right or 0),
        PaddingBottom = UDim.new(0, bottom or 0),
        PaddingLeft = UDim.new(0, left or 0),
    })
end

-- ─── Glassmorphism effect ──────────────────────────────────────────────────
local function glassify(frame, opts)
    opts = opts or {}
    -- Frame уже имеет полупрозрачный фон. Добавляем blur через UIGradient trick + stroke
    frame.BackgroundColor3 = opts.Color or Theme.BG_Glass
    frame.BackgroundTransparency = opts.Transparency or 0.4
    -- Inner glow через UIStroke с gradient (симуляция glass)
    local s = stroke(frame, Theme.Border_Light, 1, 0.5)
    local g = new("UIGradient", {
        Parent = s,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
            ColorSequenceKeypoint.new(0.5, Theme.Border),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
        }),
        Rotation = 135,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.7),
            NumberSequenceKeypoint.new(1, 0.95),
        }),
    })
    return frame
end

-- ─── Shimmer effect (бегущий блик по элементу) ────────────────────────────
local function shimmer(frame, duration)
    duration = duration or 3
    local shine = new("Frame", {
        Parent = frame,
        Size = UDim2.new(0.3, 0, 2, 0),
        Position = UDim2.fromScale(-0.5, -0.5),
        Rotation = 25,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.9,
        BorderSizePixel = 0,
        ZIndex = frame.ZIndex + 5,
    })
    gradient(shine, {
        [0] = Color3.fromRGB(255, 255, 255),
        [0.5] = Color3.fromRGB(255, 255, 255),
        [1] = Color3.fromRGB(255, 255, 255),
    }, 90).Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0.7),
        NumberSequenceKeypoint.new(1, 1),
    })
    task.spawn(function()
        while shine.Parent do
            tween(shine, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
                Position = UDim2.fromScale(1.5, -0.5)
            })
            task.wait(duration + 0.5)
            shine.Position = UDim2.fromScale(-0.5, -0.5)
        end
    end)
end

-- ─── Ripple effect ─────────────────────────────────────────────────────────
local function ripple(btn, x, y)
    local circle = new("Frame", {
        Parent = btn,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromOffset(x or btn.AbsoluteSize.X / 2, y or btn.AbsoluteSize.Y / 2),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        ZIndex = btn.ZIndex + 10,
    })
    corner(circle, UDim.new(1, 0))
    local maxSize = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2.5
    tween(circle, TweenInfo.new(0.6, Enum.EasingStyle.Quart), {
        Size = UDim2.fromOffset(maxSize, maxSize),
        BackgroundTransparency = 1,
    })
    task.delay(0.65, function() pcall(function() circle:Destroy() end) end)
end

-- ─── Floating orbs (фон) ───────────────────────────────────────────────────
local function spawnOrb(parent, color, size, speed)
    local orb = new("Frame", {
        Parent = parent,
        Size = UDim2.fromOffset(size, size),
        Position = UDim2.fromScale(math.random(), math.random()),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = color,
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        ZIndex = 0,
    })
    corner(orb, UDim.new(1, 0))
    -- Radial gradient blur effect
    gradient(orb, {
        [0] = color,
        [1] = color,
    }, 0).Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0.5),
        NumberSequenceKeypoint.new(0.7, 0.9),
        NumberSequenceKeypoint.new(1, 1),
    })
    -- Floating animation
    task.spawn(function()
        while orb.Parent do
            local tx = math.random()
            local ty = math.random()
            local duration = speed * (0.8 + math.random() * 0.4)
            tween(orb, TweenInfo.new(duration, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Position = UDim2.fromScale(tx, ty)
            })
            task.wait(duration)
        end
    end)
    return orb
end

local function gethui()
    local genv = (getgenv and getgenv()) or _G
    if type(genv.gethui) == "function" then
        local ok, r = pcall(genv.gethui)
        if ok and r then return r end
    end
    local ok2, cg = pcall(function() return cloneref(game:GetService("CoreGui")) end)
    if ok2 and cg then return cg end
    return lp:WaitForChild("PlayerGui")
end

local Icons = {
    star = "rbxassetid://6031075938", settings = "rbxassetid://6031280882",
    zap = "rbxassetid://6035047409", box = "rbxassetid://6026568198",
    globe = "rbxassetid://6031265976", home = "rbxassetid://6026568195",
    user = "rbxassetid://6034281935", info = "rbxassetid://6026568226",
    message = "rbxassetid://6031229361", help = "rbxassetid://6026568213",
    calendar = "rbxassetid://6026260003", bell = "rbxassetid://6031265976",
    target = "rbxassetid://6031075938", eye = "rbxassetid://6031265976",
    shield = "rbxassetid://6034281935", layers = "rbxassetid://6026568198",
    default = "rbxassetid://6026568198",
}

local function icon(parent, name, size, color)
    return new("ImageLabel", {
        Parent = parent,
        Size = UDim2.fromOffset(size or 16, size or 16),
        BackgroundTransparency = 1,
        Image = Icons[name] or Icons.default,
        ImageColor3 = color or Theme.Text_2,
    })
end

-- ─── CreateWindow ──────────────────────────────────────────────────────────
function PubHubUI:CreateWindow(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local subtitle = opts.Subtitle or ""
    local size = opts.Size or UDim2.fromOffset(680, 520)
    local toggleKey = opts.ToggleKey or Enum.KeyCode.RightShift

    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.Visible = true

    local SG = new("ScreenGui", {
        Name = "PubHub_UI_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Parent = gethui(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 500,
        IgnoreGuiInset = true,
    })
    Window.Gui = SG

    -- Animated background orbs (floating, blurred)
    local OrbsContainer = new("Frame", {
        Parent = SG,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 0,
    })
    spawnOrb(OrbsContainer, Theme.Accent, 300, 20)
    spawnOrb(OrbsContainer, Theme.Accent2, 250, 25)
    spawnOrb(OrbsContainer, Theme.Accent3, 350, 30)
    spawnOrb(OrbsContainer, Theme.Accent4, 200, 22)

    -- Outer glow (многослойный)
    local GlowOuter = new("Frame", {
        Parent = SG,
        Size = size + UDim2.fromOffset(80, 80),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.98,
        BorderSizePixel = 0,
        ZIndex = 1,
    })
    corner(GlowOuter, UDim.new(0, 40))
    gradient(GlowOuter, Theme.Accent, Theme.Accent2, 135)

    local GlowMid = new("Frame", {
        Parent = SG,
        Size = size + UDim2.fromOffset(30, 30),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.94,
        BorderSizePixel = 0,
        ZIndex = 2,
    })
    corner(GlowMid, UDim.new(0, 24))
    gradient(GlowMid, Theme.Accent, Theme.Accent3, 45)

    -- Main frame
    local MainFrame = new("Frame", {
        Parent = SG,
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.BG_1,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        ZIndex = 10,
    })
    Window.Frame = MainFrame
    corner(MainFrame, UDim.new(0, 20))

    -- Glass stroke
    local mainStroke = stroke(MainFrame, Theme.Border_Light, 1, 0.3)
    new("UIGradient", {
        Parent = mainStroke,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Theme.Accent),
            ColorSequenceKeypoint.new(0.5, Theme.Border_Light),
            ColorSequenceKeypoint.new(1, Theme.Accent2),
        }),
        Rotation = 45,
    })

    -- Background mesh gradient
    local bgGrad = gradient(MainFrame, {
        [0] = Theme.BG_1,
        [0.5] = Theme.BG_0,
        [1] = Color3.fromRGB(14, 10, 28),
    }, 135)

    -- Decorative orbs INSIDE main frame (за контентом)
    local InnerOrbs = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 1,
    })
    spawnOrb(InnerOrbs, Theme.Accent, 200, 25).Position = UDim2.fromScale(0.2, 0.3)
    spawnOrb(InnerOrbs, Theme.Accent2, 150, 30).Position = UDim2.fromScale(0.8, 0.7)

    -- ─── Titlebar ──────────────────────────────────────────────────────
    local Titlebar = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 64),
        BackgroundColor3 = Theme.BG_2,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 20,
    })
    corner(Titlebar, UDim.new(0, 20))
    -- mask bottom corners
    new("Frame", {
        Parent = Titlebar,
        Size = UDim2.new(1, 0, 0, 20),
        Position = UDim2.new(0, 0, 1, -20),
        BackgroundColor3 = Theme.BG_2,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
        ZIndex = 20,
    })

    -- Shimmer on titlebar
    shimmer(Titlebar, 4)

    -- Logo
    local Logo = new("TextLabel", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(180, 34),
        Position = UDim2.fromOffset(24, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 26,
        Text = title,
        TextColor3 = Theme.Text_0,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 21,
    })
    local logoGrad = gradient(Logo, {
        [0] = Theme.Accent4,
        [0.3] = Theme.Accent,
        [0.7] = Theme.Accent2,
        [1] = Theme.Accent3,
    }, 0)

    -- Animated logo gradient
    task.spawn(function()
        local dir = 1
        local offset = 0
        while Logo.Parent do
            offset = offset + dir * 0.005
            if offset > 0.3 then dir = -1 end
            if offset < -0.3 then dir = 1 end
            pcall(function() logoGrad.Offset = Vector2.new(offset, 0) end)
            task.wait(0.03)
        end
    end)

    if subtitle ~= "" then
        new("TextLabel", {
            Parent = Titlebar,
            Size = UDim2.fromOffset(200, 14),
            Position = UDim2.fromOffset(24, 40),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            Text = subtitle,
            TextColor3 = Theme.Text_3,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 21,
        })
    end

    -- Buttons (right side)
    local function MakeWindowBtn(iconChar, xOff, hoverColor, onClick)
        local Btn = new("TextButton", {
            Parent = Titlebar,
            Size = UDim2.fromOffset(36, 36),
            Position = UDim2.new(1, xOff, 0, 14),
            BackgroundColor3 = Theme.BG_3,
            Font = Enum.Font.GothamBold,
            TextSize = 18,
            Text = iconChar,
            TextColor3 = Theme.Text_2,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            ZIndex = 21,
        })
        corner(Btn, UDim.new(0, 10))
        stroke(Btn, Theme.Border, 1, 0.5)
        Btn.MouseEnter:Connect(function()
            tween(Btn, Theme.TweenFast, { BackgroundColor3 = hoverColor, TextColor3 = Theme.Text_0 })
            tween(Btn, Theme.TweenSpring, { Size = UDim2.fromOffset(40, 40) })
        end)
        Btn.MouseLeave:Connect(function()
            tween(Btn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_3, TextColor3 = Theme.Text_2 })
            tween(Btn, Theme.TweenSpring, { Size = UDim2.fromOffset(36, 36) })
        end)
        Btn.MouseButton1Click:Connect(function()
            ripple(Btn, 18, 18)
            pcall(onClick)
        end)
        return Btn
    end

    MakeWindowBtn("×", -50, Theme.Error, function() Window:Toggle(false) end)
    MakeWindowBtn("−", -95, Theme.Accent, function() Window:Toggle() end)

    -- Dragging
    local dragging, dragStart, startPos = false, nil, nil
    Titlebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                     startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            tween(MainFrame, TweenInfo.new(0.06), { Position = newPos })
            tween(GlowMid, TweenInfo.new(0.06), { Position = newPos })
            tween(GlowOuter, TweenInfo.new(0.06), { Position = newPos })
        end
    end)

    -- ─── Sidebar (tabs) ────────────────────────────────────────────────
    local Sidebar = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(0, 180, 1, -80),
        Position = UDim2.new(0, 16, 0, 72),
        BackgroundColor3 = Theme.BG_2,
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        ZIndex = 15,
    })
    corner(Sidebar, UDim.new(0, 16))
    stroke(Sidebar, Theme.Border, 1, 0.5)
    padding(Sidebar, 12)

    local SidebarList = new("UIListLayout", {
        Parent = Sidebar,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    -- ─── Content area ──────────────────────────────────────────────────
    local Content = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, -220, 1, -90),
        Position = UDim2.new(0, 208, 0, 76),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 15,
    })
    Window.Content = Content

    -- Toggle keybind
    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == toggleKey then Window:Toggle() end
    end)

    -- ─── Entrance animation ────────────────────────────────────────────
    MainFrame.Size = UDim2.fromOffset(0, 0)
    MainFrame.BackgroundTransparency = 1
    MainFrame.Rotation = -5
    GlowOuter.BackgroundTransparency = 1
    GlowMid.BackgroundTransparency = 1
    tween(MainFrame, Theme.TweenSpring, {
        Size = size,
        BackgroundTransparency = 0,
        Rotation = 0,
    })
    tween(GlowOuter, Theme.TweenSlow, { BackgroundTransparency = 0.98 })
    tween(GlowMid, Theme.TweenSlow, { BackgroundTransparency = 0.94 })

    -- ─── Methods ───────────────────────────────────────────────────────
    function Window:Toggle(force)
        local target = force
        if target == nil then target = not Window.Visible end
        Window.Visible = target
        if target then
            MainFrame.Visible = true
            GlowOuter.Visible = true
            GlowMid.Visible = true
            tween(MainFrame, Theme.TweenSpring, { Size = size, BackgroundTransparency = 0, Rotation = 0 })
            tween(GlowOuter, Theme.TweenSlow, { BackgroundTransparency = 0.98 })
            tween(GlowMid, Theme.TweenSlow, { BackgroundTransparency = 0.94 })
        else
            tween(MainFrame, Theme.TweenMed, {
                Size = UDim2.fromOffset(size.X.Offset, 0),
                BackgroundTransparency = 1,
                Rotation = 3,
            })
            tween(GlowOuter, Theme.TweenMed, { BackgroundTransparency = 1 })
            tween(GlowMid, Theme.TweenMed, { BackgroundTransparency = 1 })
            task.delay(0.4, function()
                if not Window.Visible then
                    MainFrame.Visible = false
                    GlowOuter.Visible = false
                    GlowMid.Visible = false
                end
            end)
        end
    end

    function Window:Destroy()
        SG:Destroy()
    end

    function Window:AddTab(name, iconName)
        local Tab = {}
        Tab.Name = name
        Tab.Elements = {}

        -- Tab button
        local TabBtn = new("TextButton", {
            Parent = Sidebar,
            Size = UDim2.new(1, 0, 0, 44),
            BackgroundColor3 = Theme.BG_3,
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = 14,
            Text = "",
            TextColor3 = Theme.Text_2,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            LayoutOrder = #Window.Tabs + 1,
            ZIndex = 16,
        })
        corner(TabBtn, UDim.new(0, 12))

        -- Active indicator (полоска слева)
        local Indicator = new("Frame", {
            Parent = TabBtn,
            Size = UDim2.fromOffset(3, 0),
            Position = UDim2.fromOffset(0, 8),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            ZIndex = 17,
        })
        corner(Indicator, UDim.new(1, 0))
        gradient(Indicator, Theme.Accent, Theme.Accent2, 90)

        local TabIcon = icon(TabBtn, iconName or "box", 18, Theme.Text_2)
        TabIcon.Position = UDim2.fromOffset(14, 13)
        TabIcon.ZIndex = 17

        local TabLabel = new("TextLabel", {
            Parent = TabBtn,
            Size = UDim2.new(1, -44, 1, 0),
            Position = UDim2.fromOffset(40, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = 14,
            Text = name,
            TextColor3 = Theme.Text_2,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 17,
        })

        -- Tab content (ScrollingFrame)
        local TabContent = new("ScrollingFrame", {
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            ScrollBarImageTransparency = 0.6,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
            ZIndex = 16,
        })
        Tab.Content = TabContent

        local TabList = new("UIListLayout", {
            Parent = TabContent,
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })
        padding(TabContent, 4)

        local function setActive(active)
            if active then
                tween(TabBtn, Theme.TweenMed, { BackgroundTransparency = 0 })
                tween(TabLabel, Theme.TweenFast, { TextColor3 = Theme.Text_0 })
                tween(TabIcon, Theme.TweenFast, { ImageColor3 = Theme.Accent })
                tween(Indicator, Theme.TweenSpring, { Size = UDim2.fromOffset(3, 28) })
                TabContent.Visible = true
                -- Stagger children in
                TabContent.Position = UDim2.fromOffset(15, 0)
                tween(TabContent, Theme.TweenMed, { Position = UDim2.fromOffset(0, 0) })
            else
                tween(TabBtn, Theme.TweenFast, { BackgroundTransparency = 1 })
                tween(TabLabel, Theme.TweenFast, { TextColor3 = Theme.Text_2 })
                tween(TabIcon, Theme.TweenFast, { ImageColor3 = Theme.Text_2 })
                tween(Indicator, Theme.TweenFast, { Size = UDim2.fromOffset(3, 0) })
                TabContent.Visible = false
            end
        end

        TabBtn.MouseButton1Click:Connect(function()
            for _, t in ipairs(Window.Tabs) do
                if t ~= Tab then t:SetActive(false) end
            end
            Tab:SetActive(true)
            Window.ActiveTab = Tab
        end)

        TabBtn.MouseEnter:Connect(function()
            if Window.ActiveTab ~= Tab then
                tween(TabBtn, Theme.TweenFast, { BackgroundTransparency = 0.5 })
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if Window.ActiveTab ~= Tab then
                tween(TabBtn, Theme.TweenFast, { BackgroundTransparency = 1 })
            end
        end)

        function Tab:SetActive(v) setActive(v) end

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then
            Tab:SetActive(true)
            Window.ActiveTab = Tab
        end

        -- ─── Element constructors ──────────────────────────────────────

        function Tab:AddSection(text)
            local Section = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 28),
                BackgroundTransparency = 1,
                LayoutOrder = #Tab.Elements + 1,
            })
            new("TextLabel", {
                Parent = Section,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Text = string.upper(text),
                TextColor3 = Theme.Text_3,
                TextXAlignment = Enum.TextXAlignment.Left,
            })
            local line = new("Frame", {
                Parent = Section,
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1),
                BackgroundColor3 = Theme.Border,
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
            })
            table.insert(Tab.Elements, Section)
            return Section
        end

        function Tab:AddButton(opts)
            opts = opts or {}
            local Btn = new("TextButton", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 44),
                BackgroundColor3 = Theme.BG_3,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = "",
                TextColor3 = Theme.Text_0,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ClipsDescendants = true,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Btn, UDim.new(0, 12))
            local s = stroke(Btn, Theme.Border, 1, 0.4)

            -- Gradient on hover
            local btnGrad = gradient(Btn, Theme.BG_3, Theme.BG_2, 90)
            btnGrad.Enabled = false

            local Label = new("TextLabel", {
                Parent = Btn,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Button",
                TextColor3 = Theme.Text_0,
                ZIndex = 2,
            })

            Btn.MouseEnter:Connect(function()
                btnGrad.Enabled = true
                tween(Btn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_2 })
                tween(s, Theme.TweenFast, { Color = Theme.Accent, Transparency = 0.3 })
                tween(Label, Theme.TweenFast, { TextColor3 = Theme.Accent4 })
            end)
            Btn.MouseLeave:Connect(function()
                btnGrad.Enabled = false
                tween(Btn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_3 })
                tween(s, Theme.TweenFast, { Color = Theme.Border, Transparency = 0.4 })
                tween(Label, Theme.TweenFast, { TextColor3 = Theme.Text_0 })
            end)
            Btn.MouseButton1Click:Connect(function()
                local mouse = UIS:GetMouseLocation()
                local relX = mouse.X - Btn.AbsolutePosition.X
                local relY = mouse.Y - Btn.AbsolutePosition.Y
                ripple(Btn, relX, relY)
                tween(Btn, Theme.TweenFast, { Size = UDim2.new(1, -6, 0, 42) })
                task.wait(0.08)
                tween(Btn, Theme.TweenSpring, { Size = UDim2.new(1, 0, 0, 44) })
                if opts.Callback then pcall(opts.Callback) end
            end)

            table.insert(Tab.Elements, Btn)
            return Btn
        end

        function Tab:AddToggle(opts)
            opts = opts or {}
            local value = opts.Default or false
            local Toggle = {}

            local Row = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundColor3 = Theme.BG_2,
                BackgroundTransparency = 0.6,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row, UDim.new(0, 12))
            local rowStroke = stroke(Row, Theme.Border, 1, 0.6)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(1, -80, 1, 0),
                Position = UDim2.fromOffset(16, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Toggle",
                TextColor3 = Theme.Text_0,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            -- Animated switch
            local Switch = new("Frame", {
                Parent = Row,
                Size = UDim2.fromOffset(52, 26),
                Position = UDim2.new(1, -68, 0.5, -13),
                BackgroundColor3 = Theme.BG_0,
                BorderSizePixel = 0,
            })
            corner(Switch, UDim.new(1, 0))
            local switchStroke = stroke(Switch, Theme.Border, 1, 0.5)

            -- Glow behind knob when on
            local KnobGlow = new("Frame", {
                Parent = Switch,
                Size = UDim2.fromOffset(20, 20),
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Theme.Accent,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ZIndex = 1,
            })
            corner(KnobGlow, UDim.new(1, 0))

            local Knob = new("Frame", {
                Parent = Switch,
                Size = UDim2.fromOffset(20, 20),
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Theme.Text_2,
                BorderSizePixel = 0,
                ZIndex = 2,
            })
            corner(Knob, UDim.new(1, 0))

            local function updateVisual(animate)
                local targetPos = value and UDim2.fromOffset(29, 3) or UDim2.fromOffset(3, 3)
                local targetColor = value and Theme.Accent or Theme.BG_0
                local knobColor = value and Theme.Text_0 or Theme.Text_2
                local glowTransp = value and 0.5 or 1
                local info = animate and Theme.TweenSpring or TweenInfo.new(0)
                tween(Knob, info, { Position = targetPos })
                tween(KnobGlow, info, { Position = targetPos, BackgroundTransparency = glowTransp })
                tween(Switch, Theme.TweenFast, { BackgroundColor3 = targetColor })
                tween(Knob, Theme.TweenFast, { BackgroundColor3 = knobColor })
                if value then
                    tween(switchStroke, Theme.TweenFast, { Color = Theme.Accent, Transparency = 0.2 })
                else
                    tween(switchStroke, Theme.TweenFast, { Color = Theme.Border, Transparency = 0.5 })
                end
            end

            local function setValue(v, skipCallback)
                value = v
                updateVisual(true)
                if not skipCallback and opts.Callback then pcall(opts.Callback, v) end
            end

            local ClickBtn = new("TextButton", {
                Parent = Row,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = "",
                BorderSizePixel = 0,
            })
            ClickBtn.MouseButton1Click:Connect(function()
                setValue(not value)
            end)
            ClickBtn.MouseEnter:Connect(function()
                tween(Row, Theme.TweenFast, { BackgroundTransparency = 0.4 })
            end)
            ClickBtn.MouseLeave:Connect(function()
                tween(Row, Theme.TweenFast, { BackgroundTransparency = 0.6 })
            end)

            updateVisual(false)

            function Toggle:SetValue(v) setValue(v) end
            function Toggle:GetValue() return value end
            Toggle.Value = value
            setmetatable(Toggle, {
                __index = function(t, k) if k == "Value" then return value end return rawget(t, k) end,
                __newindex = function(t, k, v) if k == "Value" then value = v; updateVisual(false) else rawset(t, k, v) end end,
            })

            table.insert(Tab.Elements, Row)
            return Toggle
        end

        function Tab:AddSlider(opts)
            opts = opts or {}
            local min = opts.Min or 0
            local max = opts.Max or 100
            local default = opts.Default or min
            local value = default
            local Slider = {}

            local Row = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 64),
                BackgroundColor3 = Theme.BG_2,
                BackgroundTransparency = 0.6,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row, UDim.new(0, 12))
            stroke(Row, Theme.Border, 1, 0.6)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(1, -90, 0, 20),
                Position = UDim2.fromOffset(16, 10),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Slider",
                TextColor3 = Theme.Text_0,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local ValueLbl = new("TextLabel", {
                Parent = Row,
                Size = UDim2.fromOffset(70, 20),
                Position = UDim2.new(1, -86, 0, 10),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 14,
                Text = tostring(value),
                TextColor3 = Theme.Accent,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            local Track = new("Frame", {
                Parent = Row,
                Size = UDim2.new(1, -32, 0, 8),
                Position = UDim2.new(0, 16, 0, 40),
                BackgroundColor3 = Theme.BG_0,
                BorderSizePixel = 0,
            })
            corner(Track, UDim.new(1, 0))
            stroke(Track, Theme.Border, 1, 0.5)

            local Fill = new("Frame", {
                Parent = Track,
                Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                BorderSizePixel = 0,
            })
            corner(Fill, UDim.new(1, 0))
            gradient(Fill, Theme.Accent, Theme.Accent2, 0)

            local Thumb = new("Frame", {
                Parent = Track,
                Size = UDim2.fromOffset(18, 18),
                Position = UDim2.new((value - min) / (max - min), -9, 0.5, -9),
                BackgroundColor3 = Theme.Text_0,
                BorderSizePixel = 0,
                ZIndex = 2,
            })
            corner(Thumb, UDim.new(1, 0))
            stroke(Thumb, Theme.Accent, 2)

            -- Glow behind thumb
            local ThumbGlow = new("Frame", {
                Parent = Track,
                Size = UDim2.fromOffset(30, 30),
                Position = UDim2.new((value - min) / (max - min), -15, 0.5, -15),
                BackgroundColor3 = Theme.Accent,
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                ZIndex = 1,
            })
            corner(ThumbGlow, UDim.new(1, 0))

            local draggingSlider = false
            local function updateValue(input)
                local pos = (input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
                pos = math.clamp(pos, 0, 1)
                value = math.floor(min + (max - min) * pos + 0.5)
                ValueLbl.Text = tostring(value)
                tween(Fill, Theme.TweenFast, { Size = UDim2.new(pos, 0, 1, 0) })
                tween(Thumb, Theme.TweenFast, { Position = UDim2.new(pos, -9, 0.5, -9) })
                tween(ThumbGlow, Theme.TweenFast, { Position = UDim2.new(pos, -15, 0.5, -15) })
                if opts.Callback then pcall(opts.Callback, value) end
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    tween(Thumb, Theme.TweenSpring, { Size = UDim2.fromOffset(24, 24) })
                    tween(ThumbGlow, Theme.TweenFast, { BackgroundTransparency = 0.4 })
                    updateValue(input)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 and draggingSlider then
                    draggingSlider = false
                    tween(Thumb, Theme.TweenSpring, { Size = UDim2.fromOffset(18, 18) })
                    tween(ThumbGlow, Theme.TweenFast, { BackgroundTransparency = 0.7 })
                end
            end)
            UIS.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateValue(input)
                end
            end)

            function Slider:SetValue(v)
                value = math.clamp(v, min, max)
                ValueLbl.Text = tostring(value)
                local pos = (value - min) / (max - min)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                Thumb.Position = UDim2.new(pos, -9, 0.5, -9)
                ThumbGlow.Position = UDim2.new(pos, -15, 0.5, -15)
            end
            function Slider:GetValue() return value end
            Slider.Value = value

            table.insert(Tab.Elements, Row)
            return Slider
        end

        function Tab:AddDropdown(opts)
            opts = opts or {}
            local values = opts.Values or {}
            local default = opts.Default or values[1]
            local value = default
            local open = false
            local Dropdown = {}

            local Row = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundColor3 = Theme.BG_2,
                BackgroundTransparency = 0.6,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ClipsDescendants = false,
            })
            corner(Row, UDim.new(0, 12))
            stroke(Row, Theme.Border, 1, 0.6)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(0.45, -16, 1, 0),
                Position = UDim2.fromOffset(16, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Dropdown",
                TextColor3 = Theme.Text_0,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local CurrentBtn = new("TextButton", {
                Parent = Row,
                Size = UDim2.new(0.55, -24, 1, -12),
                Position = UDim2.new(0.45, 8, 0, 6),
                BackgroundColor3 = Theme.BG_0,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                Text = "  " .. tostring(value),
                TextColor3 = Theme.Text_1,
                TextXAlignment = Enum.TextXAlignment.Left,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ZIndex = 2,
            })
            corner(CurrentBtn, UDim.new(0, 8))
            local currentStroke = stroke(CurrentBtn, Theme.Border, 1, 0.5)

            local Arrow = new("TextLabel", {
                Parent = CurrentBtn,
                Size = UDim2.fromOffset(20, 20),
                Position = UDim2.new(1, -24, 0.5, -10),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 12,
                Text = "▼",
                TextColor3 = Theme.Text_3,
            })

            local OptionsFrame = new("Frame", {
                Parent = Row,
                Size = UDim2.new(0.55, -24, 0, 0),
                Position = UDim2.new(0.45, 8, 1, 4),
                BackgroundColor3 = Theme.BG_1,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 100,
                ClipsDescendants = true,
            })
            corner(OptionsFrame, UDim.new(0, 10))
            stroke(OptionsFrame, Theme.Accent, 1, 0.3)

            local OptionsList = new("UIListLayout", {
                Parent = OptionsFrame,
                Padding = UDim.new(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })
            padding(OptionsFrame, 4)

            local function rebuildOptions()
                for _, c in ipairs(OptionsFrame:GetChildren()) do
                    if c:IsA("TextButton") then c:Destroy() end
                end
                for i, v in ipairs(values) do
                    local OptBtn = new("TextButton", {
                        Parent = OptionsFrame,
                        Size = UDim2.new(1, -8, 0, 32),
                        BackgroundColor3 = v == value and Theme.BG_3 or Theme.BG_2,
                        BackgroundTransparency = v == value and 0.3 or 0.7,
                        Font = Enum.Font.Gotham,
                        TextSize = 13,
                        Text = "  " .. tostring(v),
                        TextColor3 = v == value and Theme.Accent or Theme.Text_1,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        LayoutOrder = i,
                        ZIndex = 101,
                    })
                    corner(OptBtn, UDim.new(0, 6))
                    OptBtn.MouseEnter:Connect(function()
                        tween(OptBtn, Theme.TweenFast, { BackgroundTransparency = 0.2 })
                    end)
                    OptBtn.MouseLeave:Connect(function()
                        tween(OptBtn, Theme.TweenFast, { BackgroundTransparency = v == value and 0.3 or 0.7 })
                    end)
                    OptBtn.MouseButton1Click:Connect(function()
                        value = v
                        CurrentBtn.Text = "  " .. tostring(v)
                        open = false
                        tween(OptionsFrame, Theme.TweenFast, { Size = UDim2.new(0.55, -24, 0, 0) })
                        tween(Arrow, Theme.TweenFast, { Rotation = 0 })
                        task.delay(0.18, function() OptionsFrame.Visible = false end)
                        if opts.Callback then pcall(opts.Callback, v) end
                        rebuildOptions()
                    end)
                end
            end
            rebuildOptions()

            CurrentBtn.MouseButton1Click:Connect(function()
                open = not open
                if open then
                    OptionsFrame.Visible = true
                    local h = math.min(#values * 34 + 8, 200)
                    tween(OptionsFrame, Theme.TweenSpring, { Size = UDim2.new(0.55, -24, 0, h) })
                    tween(Arrow, Theme.TweenSpring, { Rotation = 180 })
                    tween(currentStroke, Theme.TweenFast, { Color = Theme.Accent, Transparency = 0.2 })
                else
                    tween(OptionsFrame, Theme.TweenFast, { Size = UDim2.new(0.55, -24, 0, 0) })
                    tween(Arrow, Theme.TweenFast, { Rotation = 0 })
                    tween(currentStroke, Theme.TweenFast, { Color = Theme.Border, Transparency = 0.5 })
                    task.delay(0.18, function() OptionsFrame.Visible = false end)
                end
            end)

            function Dropdown:SetValue(v)
                value = v
                CurrentBtn.Text = "  " .. tostring(v)
                rebuildOptions()
            end
            function Dropdown:GetValue() return value end
            function Dropdown:SetValues(newValues)
                values = newValues
                rebuildOptions()
            end
            Dropdown.Value = value

            table.insert(Tab.Elements, Row)
            return Dropdown
        end

        function Tab:AddInput(opts)
            opts = opts or {}
            local value = opts.Default or ""
            local Input = {}

            local Row = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 48),
                BackgroundColor3 = Theme.BG_2,
                BackgroundTransparency = 0.6,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row, UDim.new(0, 12))
            stroke(Row, Theme.Border, 1, 0.6)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(0.4, -16, 1, 0),
                Position = UDim2.fromOffset(16, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Input",
                TextColor3 = Theme.Text_0,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local BoxFrame = new("Frame", {
                Parent = Row,
                Size = UDim2.new(0.6, -24, 1, -12),
                Position = UDim2.new(0.4, 8, 0, 6),
                BackgroundColor3 = Theme.BG_0,
                BorderSizePixel = 0,
            })
            corner(BoxFrame, UDim.new(0, 8))
            local boxStroke = stroke(BoxFrame, Theme.Border, 1, 0.5)

            local Box = new("TextBox", {
                Parent = BoxFrame,
                Size = UDim2.new(1, -16, 1, 0),
                Position = UDim2.fromOffset(8, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                Text = tostring(value),
                PlaceholderText = opts.Placeholder or "",
                PlaceholderColor3 = Theme.Text_3,
                TextColor3 = Theme.Text_0,
                BorderSizePixel = 0,
                ClearTextOnFocus = false,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            Box.Focused:Connect(function()
                tween(BoxFrame, Theme.TweenFast, { BackgroundColor3 = Theme.BG_2 })
                tween(boxStroke, Theme.TweenFast, { Color = Theme.Accent, Transparency = 0.2 })
            end)
            Box.FocusLost:Connect(function(enter)
                tween(BoxFrame, Theme.TweenFast, { BackgroundColor3 = Theme.BG_0 })
                tween(boxStroke, Theme.TweenFast, { Color = Theme.Border, Transparency = 0.5 })
                if enter then
                    value = Box.Text
                    if opts.Callback then pcall(opts.Callback, value) end
                end
            end)

            function Input:SetValue(v) Box.Text = tostring(v); value = Box.Text end
            function Input:GetValue() return value end
            Input.Value = value

            table.insert(Tab.Elements, Row)
            return Input
        end

        function Tab:AddLabel(text, centered)
            local Lbl = new("TextLabel", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 22),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = 13,
                Text = text,
                TextColor3 = Theme.Text_2,
                TextXAlignment = centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                TextWrapped = true,
                LayoutOrder = #Tab.Elements + 1,
            })
            local LabelObj = {}
            function LabelObj:SetText(t) Lbl.Text = t end
            function LabelObj:GetText() return Lbl.Text end
            table.insert(Tab.Elements, Lbl)
            return LabelObj
        end

        function Tab:AddDivider()
            local Div = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = Theme.Border,
                BackgroundTransparency = 0.7,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Div, UDim.new(1, 0))
            table.insert(Tab.Elements, Div)
            return Div
        end

        return Tab
    end

    return Window
end

-- ─── Global Notify (усиленный) ─────────────────────────────────────────────
local NotifGui
function PubHubUI:Notify(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local text = opts.Text or ""
    local duration = opts.Duration or 3.5
    local kind = opts.Type or "info"

    task.spawn(function()
        if not NotifGui or not NotifGui.Parent then
            NotifGui = new("ScreenGui", {
                Name = "PubHub_Notify_" .. HttpService:GenerateGUID(false):sub(1, 8),
                Parent = gethui(),
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 1000,
                IgnoreGuiInset = true,
            })
        end

        -- Сдвигаем старые
        for _, c in ipairs(NotifGui:GetChildren()) do
            if c:IsA("Frame") then
                local curY = c.Position.Y.Offset
                tween(c, Theme.TweenMed, { Position = UDim2.new(1, -360, 1, curY - 100) })
            end
        end

        local accentColor = Theme.Accent
        if kind == "success" then accentColor = Theme.Success
        elseif kind == "error" then accentColor = Theme.Error
        elseif kind == "warning" then accentColor = Theme.Warning end

        -- Outer glow
        local Glow = new("Frame", {
            Parent = NotifGui,
            Size = UDim2.fromOffset(340, 90),
            Position = UDim2.new(1, 380, 1, -110),
            BackgroundColor3 = accentColor,
            BackgroundTransparency = 0.9,
            BorderSizePixel = 0,
        })
        corner(Glow, UDim.new(0, 16))

        local Frame = new("Frame", {
            Parent = NotifGui,
            Size = UDim2.fromOffset(340, 90),
            Position = UDim2.new(1, 380, 1, -110),
            BackgroundColor3 = Theme.BG_1,
            BackgroundTransparency = 0.05,
            BorderSizePixel = 0,
        })
        corner(Frame, UDim.new(0, 16))
        local fs = stroke(Frame, accentColor, 1.5, 0.2)
        gradient(fs, accentColor, Theme.Accent2, 45)

        -- Accent bar слева
        local AccentBar = new("Frame", {
            Parent = Frame,
            Size = UDim2.fromOffset(4, 0),
            Position = UDim2.fromOffset(0, 0),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
        })
        corner(AccentBar, UDim.new(1, 0))
        tween(AccentBar, Theme.TweenSpring, { Size = UDim2.fromOffset(4, 90) })

        -- Icon dot
        new("Frame", {
            Parent = Frame,
            Size = UDim2.fromOffset(8, 8),
            Position = UDim2.fromOffset(20, 22),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
        }).Parent = Frame
        local dot = Frame:GetChildren()[#Frame:GetChildren()]
        corner(dot, UDim.new(1, 0))

        new("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -50, 0, 22),
            Position = UDim2.fromOffset(36, 12),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextSize = 15,
            Text = title,
            TextColor3 = Theme.Text_0,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        new("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -50, 0, 44),
            Position = UDim2.fromOffset(36, 36),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 13,
            Text = text,
            TextColor3 = Theme.Text_2,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
        })

        -- Slide in
        tween(Glow, Theme.TweenSpring, { Position = UDim2.new(1, -360, 1, -110), BackgroundTransparency = 0.85 })
        tween(Frame, Theme.TweenSpring, { Position = UDim2.new(1, -360, 1, -110) })

        -- Pulse glow
        task.spawn(function()
            while Frame.Parent do
                tween(Glow, Theme.TweenMed, { BackgroundTransparency = 0.92 })
                task.wait(0.6)
                tween(Glow, Theme.TweenMed, { BackgroundTransparency = 0.85 })
                task.wait(0.6)
            end
        end)

        task.wait(duration)
        tween(Glow, Theme.TweenMed, { Position = UDim2.new(1, 380, 1, -110), BackgroundTransparency = 1 })
        tween(Frame, Theme.TweenMed, { Position = UDim2.new(1, 380, 1, -110), BackgroundTransparency = 1 })
        task.wait(0.4)
        pcall(function() Frame:Destroy() end)
        pcall(function() Glow:Destroy() end)
    end)
end

return PubHubUI
