-- ═══════════════════════════════════════════════════════════════════════════
-- PubHub UI Library v1.0
-- Профессиональный GUI движок для Roblox executor-скриптов
-- Стиль: dark glassmorphism + purple gradient accents + spring animations
--
-- Использование:
--   local UI = loadstring(game:HttpGet(".../pubhub_ui.lua"))()
--   local Win = UI:CreateWindow({ Title = "PubHub", Subtitle = "Steal an Egg" })
--   local Tab = Win:AddTab("Main", "star")
--   Tab:AddToggle({ Text = "Auto-farm", Default = false, Callback = fn(v) end })
--   Tab:AddButton({ Text = "Click me", Callback = fn() end })
--   Tab:AddSlider({ Text = "Speed", Min = 0, Max = 100, Default = 50, Callback = fn(v) end })
--   Tab:AddDropdown({ Text = "Mode", Values = {"A","B"}, Default = "A", Callback = fn(v) end })
--   Tab:AddInput({ Text = "Name", Placeholder = "...", Callback = fn(v) end })
--   UI:Notify({ Title = "Hi", Text = "...", Duration = 3 })
-- ═══════════════════════════════════════════════════════════════════════════

local PubHubUI = {}
PubHubUI.__index = PubHubUI

-- ─── Services ──────────────────────────────────────────────────────────────
local cloneref = cloneref or clonereference or function(x) return x end
local Players = cloneref(game:GetService("Players"))
local TweenService = cloneref(game:GetService("TweenService"))
local RunService = cloneref(game:GetService("RunService"))
local UIS = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local lp = Players.LocalPlayer

-- ─── Theme ─────────────────────────────────────────────────────────────────
local Theme = {
    -- Backgrounds
    BG_Dark       = Color3.fromRGB(10, 12, 20),
    BG_Medium     = Color3.fromRGB(16, 18, 32),
    BG_Light      = Color3.fromRGB(24, 27, 44),
    BG_Glass      = Color3.fromRGB(20, 22, 38),

    -- Accents
    Accent        = Color3.fromRGB(139, 92, 246),  -- violet
    Accent2       = Color3.fromRGB(236, 72, 153),  -- pink
    Accent3       = Color3.fromRGB(59, 130, 246),  -- blue
    Accent_Glow   = Color3.fromRGB(167, 139, 250),

    -- Text
    Text_Primary  = Color3.fromRGB(248, 250, 252),
    Text_Secondary= Color3.fromRGB(148, 163, 184),
    Text_Muted    = Color3.fromRGB(100, 116, 139),

    -- Status
    Success       = Color3.fromRGB(52, 211, 153),
    Warning       = Color3.fromRGB(251, 191, 36),
    Error         = Color3.fromRGB(248, 113, 113),

    -- Borders
    Border        = Color3.fromRGB(45, 48, 72),
    Border_Light  = Color3.fromRGB(71, 75, 110),

    -- Sizes
    CornerRadius  = UDim.new(0, 12),
    CornerRadiusSmall = UDim.new(0, 8),

    -- Animation
    TweenFast     = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    TweenMed      = TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TweenSlow     = TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    TweenSpring   = TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
    TweenElastic  = TweenInfo.new(0.8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out),
}

-- ─── Helpers ───────────────────────────────────────────────────────────────
local function new(className, props)
    local inst = Instance.new(className)
    for k, v in pairs(props or {}) do
        if k ~= "Parent" then
            pcall(function() inst[k] = v end)
        end
    end
    if props and props.Parent then inst.Parent = props.Parent end
    return inst
end

local function tween(obj, info, props)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

local function gradient(parent, c1, c2, rotation)
    return new("UIGradient", {
        Parent = parent,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, c1),
            ColorSequenceKeypoint.new(1, c2),
        }),
        Rotation = rotation or 45,
    })
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

local function corner(parent, radius)
    return new("UICorner", {
        Parent = parent,
        CornerRadius = radius or Theme.CornerRadius,
    })
end

local function padding(parent, all)
    return new("UIPadding", {
        Parent = parent,
        PaddingTop = UDim.new(0, all),
        PaddingBottom = UDim.new(0, all),
        PaddingLeft = UDim.new(0, all),
        PaddingRight = UDim.new(0, all),
    })
end

local function shadow(parent, intensity)
    -- Fake shadow: larger frame behind, darker, slightly offset
    local sh = new("Frame", {
        Parent = parent.Parent,
        Size = parent.Size + UDim2.fromOffset(intensity * 2, intensity * 2),
        Position = parent.Position + UDim2.fromOffset(-intensity, -intensity + 2),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        ZIndex = parent.ZIndex - 1,
    })
    corner(sh, Theme.CornerRadius + UDim.new(0, 4))
    return sh
end

local function ripple(btn)
    -- Click ripple effect
    local circle = new("Frame", {
        Parent = btn,
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.85,
        BorderSizePixel = 0,
        ZIndex = btn.ZIndex + 10,
    })
    corner(circle, UDim.new(1, 0))
    local maxSize = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 2
    tween(circle, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
        Size = UDim2.fromOffset(maxSize, maxSize),
        BackgroundTransparency = 1,
    })
    task.delay(0.5, function() pcall(function() circle:Destroy() end) end)
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

-- ─── Icons (Lucide SVG paths converted to rbx ImageLabels via asset ids) ──
-- Используем стандартные rbxassetid для простоты — Lucide имеет CDN:
-- https://cdn.jsdelivr.net/npm/lucide-static@latest/icons/<name>.svg
-- Для Roblox нужен pre-uploaded id. Хардкодим популярные:
local Icons = {
    star = "rbxassetid://6031075938",
    settings = "rbxassetid://6031280882",
    zap = "rbxassetid://6035047409",
    box = "rbxassetid://6026568198",
    globe = "rbxassetid://6031265976",
    home = "rbxassetid://6026568195",
    user = "rbxassetid://6034281935",
    info = "rbxassetid://6026568226",
    message = "rbxassetid://6031229361",
    help = "rbxassetid://6026568213",
    calendar = "rbxassetid://6026260003",
    bell = "rbxassetid://6031265976",
    -- fallback
    default = "rbxassetid://6026568198",
}

local function icon(parent, name, size)
    local id = Icons[name] or Icons.default
    return new("ImageLabel", {
        Parent = parent,
        Size = UDim2.fromOffset(size or 16, size or 16),
        BackgroundTransparency = 1,
        Image = id,
        ImageColor3 = Theme.Text_Secondary,
    })
end

-- ─── Window Constructor ────────────────────────────────────────────────────
function PubHubUI:CreateWindow(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local subtitle = opts.Subtitle or ""
    local size = opts.Size or UDim2.fromOffset(580, 460)
    local toggleKey = opts.ToggleKey or Enum.KeyCode.RightShift

    local Window = {}
    Window.Tabs = {}
    Window.ActiveTab = nil
    Window.Visible = true

    -- ScreenGui
    local SG = new("ScreenGui", {
        Name = "PubHub_UI_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Parent = gethui(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 500,
    })
    Window.Gui = SG

    -- Main frame with glow
    local GlowFrame = new("Frame", {
        Parent = SG,
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.Accent,
        BackgroundTransparency = 0.95,
        BorderSizePixel = 0,
        ZIndex = 0,
    })
    corner(GlowFrame, UDim.new(0, 20))
    gradient(GlowFrame, Theme.Accent, Theme.Accent2, 45)

    local MainFrame = new("Frame", {
        Parent = SG,
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Theme.BG_Dark,
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })
    Window.Frame = MainFrame
    corner(MainFrame, UDim.new(0, 16))
    stroke(MainFrame, Theme.Border, 1)

    -- Background gradient
    gradient(MainFrame, Theme.BG_Medium, Theme.BG_Dark, 90)

    -- ─── Titlebar ──────────────────────────────────────────────────────
    local Titlebar = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 52),
        BackgroundColor3 = Theme.BG_Glass,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
    })
    corner(Titlebar, UDim.new(0, 16))
    -- Cut off bottom corners of titlebar
    local TitlebarMask = new("Frame", {
        Parent = Titlebar,
        Size = UDim2.new(1, 0, 0, 16),
        Position = UDim2.new(0, 0, 1, -16),
        BackgroundColor3 = Theme.BG_Glass,
        BackgroundTransparency = 0.3,
        BorderSizePixel = 0,
    })

    -- Logo (gradient text)
    local Logo = new("TextLabel", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(140, 30),
        Position = UDim2.fromOffset(16, 6),
        BackgroundTransparency = 1,
        Font = Enum.Font.GothamBold,
        TextSize = 22,
        Text = title,
        TextColor3 = Theme.Text_Primary,
        TextXAlignment = Enum.TextXAlignment.Left,
    })
    gradient(Logo, Theme.Accent, Theme.Accent2, 0)

    -- Subtitle
    if subtitle ~= "" then
        new("TextLabel", {
            Parent = Titlebar,
            Size = UDim2.fromOffset(140, 14),
            Position = UDim2.fromOffset(16, 32),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 11,
            Text = subtitle,
            TextColor3 = Theme.Text_Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
        })
    end

    -- Close button
    local CloseBtn = new("TextButton", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(32, 32),
        Position = UDim2.new(1, -44, 0, 10),
        BackgroundColor3 = Theme.BG_Light,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        Text = "×",
        TextColor3 = Theme.Text_Secondary,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    })
    corner(CloseBtn, UDim.new(0, 8))
    CloseBtn.MouseEnter:Connect(function()
        tween(CloseBtn, Theme.TweenFast, { BackgroundColor3 = Theme.Error, TextColor3 = Theme.Text_Primary })
    end)
    CloseBtn.MouseLeave:Connect(function()
        tween(CloseBtn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Light, TextColor3 = Theme.Text_Secondary })
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        Window:Toggle(false)
    end)

    -- Minimize button
    local MinBtn = new("TextButton", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(32, 32),
        Position = UDim2.new(1, -84, 0, 10),
        BackgroundColor3 = Theme.BG_Light,
        Font = Enum.Font.GothamBold,
        TextSize = 18,
        Text = "−",
        TextColor3 = Theme.Text_Secondary,
        BorderSizePixel = 0,
        AutoButtonColor = false,
    })
    corner(MinBtn, UDim.new(0, 8))
    MinBtn.MouseEnter:Connect(function()
        tween(MinBtn, Theme.TweenFast, { BackgroundColor3 = Theme.Accent, TextColor3 = Theme.Text_Primary })
    end)
    MinBtn.MouseLeave:Connect(function()
        tween(MinBtn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Light, TextColor3 = Theme.Text_Secondary })
    end)
    MinBtn.MouseButton1Click:Connect(function()
        Window:Toggle()
    end)

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
            tween(MainFrame, TweenInfo.new(0.08), {
                Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                     startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            })
            tween(GlowFrame, TweenInfo.new(0.08), {
                Position = MainFrame.Position
            })
        end
    end)

    -- ─── Sidebar (tabs) ────────────────────────────────────────────────
    local Sidebar = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(0, 160, 1, -52),
        Position = UDim2.new(0, 0, 0, 52),
        BackgroundColor3 = Theme.BG_Medium,
        BackgroundTransparency = 0.5,
        BorderSizePixel = 0,
    })
    local SidebarList = new("UIListLayout", {
        Parent = Sidebar,
        Padding = UDim.new(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    padding(Sidebar, 12)

    -- ─── Content area ──────────────────────────────────────────────────
    local Content = new("Frame", {
        Parent = MainFrame,
        Size = UDim2.new(1, -180, 1, -72),
        Position = UDim2.new(0, 172, 0, 60),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    })
    Window.Content = Content

    -- ─── Toggle keybind ────────────────────────────────────────────────
    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == toggleKey then
            Window:Toggle()
        end
    end)

    -- ─── Entrance animation ────────────────────────────────────────────
    MainFrame.Size = UDim2.fromOffset(0, 0)
    MainFrame.BackgroundTransparency = 1
    GlowFrame.BackgroundTransparency = 1
    tween(MainFrame, Theme.TweenSpring, { Size = size, BackgroundTransparency = 0 })
    tween(GlowFrame, Theme.TweenSpring, { Size = size + UDim2.fromOffset(20, 20), BackgroundTransparency = 0.95 })

    -- ─── Methods ───────────────────────────────────────────────────────
    function Window:Toggle(force)
        local target = force
        if target == nil then target = not Window.Visible end
        Window.Visible = target
        if target then
            MainFrame.Visible = true
            GlowFrame.Visible = true
            tween(MainFrame, Theme.TweenSpring, { Size = size, BackgroundTransparency = 0 })
            tween(GlowFrame, Theme.TweenSpring, { BackgroundTransparency = 0.95 })
        else
            tween(MainFrame, Theme.TweenMed, { Size = UDim2.fromOffset(size.X.Offset, 0), BackgroundTransparency = 1 })
            tween(GlowFrame, Theme.TweenMed, { BackgroundTransparency = 1 })
            task.delay(0.35, function()
                if not Window.Visible then
                    MainFrame.Visible = false
                    GlowFrame.Visible = false
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

        -- Tab button in sidebar
        local TabBtn = new("TextButton", {
            Parent = Sidebar,
            Size = UDim2.new(1, -24, 0, 36),
            BackgroundColor3 = Theme.BG_Light,
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            Text = "",
            TextColor3 = Theme.Text_Secondary,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            LayoutOrder = #Window.Tabs + 1,
        })
        corner(TabBtn, UDim.new(0, 8))

        local TabIcon = icon(TabBtn, iconName or "box", 16)
        TabIcon.Position = UDim2.fromOffset(12, 10)

        local TabLabel = new("TextLabel", {
            Parent = TabBtn,
            Size = UDim2.new(1, -40, 1, 0),
            Position = UDim2.fromOffset(36, 0),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamMedium,
            TextSize = 13,
            Text = name,
            TextColor3 = Theme.Text_Secondary,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        -- Tab content
        local TabContent = new("ScrollingFrame", {
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Accent,
            ScrollBarImageTransparency = 0.5,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            Visible = false,
        })
        Tab.Content = TabContent

        local TabList = new("UIListLayout", {
            Parent = TabContent,
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
        })

        -- Activate/deactivate
        local function setActive(active)
            if active then
                tween(TabBtn, Theme.TweenFast, { BackgroundTransparency = 0 })
                tween(TabLabel, Theme.TweenFast, { TextColor3 = Theme.Text_Primary })
                tween(TabIcon, Theme.TweenFast, { ImageColor3 = Theme.Accent })
                TabContent.Visible = true
                -- Slide in
                TabContent.Position = UDim2.fromOffset(10, 0)
                tween(TabContent, Theme.TweenMed, { Position = UDim2.fromOffset(0, 0) })
            else
                tween(TabBtn, Theme.TweenFast, { BackgroundTransparency = 1 })
                tween(TabLabel, Theme.TweenFast, { TextColor3 = Theme.Text_Secondary })
                tween(TabIcon, Theme.TweenFast, { ImageColor3 = Theme.Text_Secondary })
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
            local Section = new("TextLabel", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 11,
                Text = string.upper(text),
                TextColor3 = Theme.Text_Muted,
                TextXAlignment = Enum.TextXAlignment.Left,
                LayoutOrder = #Tab.Elements + 1,
            })
            table.insert(Tab.Elements, Section)
            return Section
        end

        function Tab:AddButton(opts)
            opts = opts or {}
            local Btn = new("TextButton", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.BG_Light,
                Font = Enum.Font.GothamMedium,
                TextSize = 14,
                Text = opts.Text or "Button",
                TextColor3 = Theme.Text_Primary,
                BorderSizePixel = 0,
                AutoButtonColor = false,
                ClipsDescendants = true,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Btn)
            stroke(Btn, Theme.Border, 1)

            Btn.MouseEnter:Connect(function()
                tween(Btn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Glass })
            end)
            Btn.MouseLeave:Connect(function()
                tween(Btn, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Light })
            end)
            Btn.MouseButton1Click:Connect(function()
                ripple(Btn)
                tween(Btn, Theme.TweenFast, { Size = UDim2.new(1, -4, 0, 38) })
                task.wait(0.08)
                tween(Btn, Theme.TweenSpring, { Size = UDim2.new(1, 0, 0, 40) })
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
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.BG_Light,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(1, -60, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                Text = opts.Text or "Toggle",
                TextColor3 = Theme.Text_Primary,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            -- Switch
            local Switch = new("Frame", {
                Parent = Row,
                Size = UDim2.fromOffset(44, 22),
                Position = UDim2.new(1, -56, 0.5, -11),
                BackgroundColor3 = Theme.BG_Dark,
                BorderSizePixel = 0,
            })
            corner(Switch, UDim.new(1, 0))
            stroke(Switch, Theme.Border, 1)

            local Knob = new("Frame", {
                Parent = Switch,
                Size = UDim2.fromOffset(16, 16),
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = Theme.Text_Muted,
                BorderSizePixel = 0,
            })
            corner(Knob, UDim.new(1, 0))

            local function updateVisual(animate)
                local targetPos = value and UDim2.fromOffset(25, 3) or UDim2.fromOffset(3, 3)
                local targetColor = value and Theme.Accent or Theme.BG_Dark
                local knobColor = value and Theme.Text_Primary or Theme.Text_Muted
                if animate then
                    tween(Knob, Theme.TweenSpring, { Position = targetPos })
                    tween(Switch, Theme.TweenFast, { BackgroundColor3 = targetColor })
                    tween(Knob, Theme.TweenFast, { BackgroundColor3 = knobColor })
                else
                    Knob.Position = targetPos
                    Switch.BackgroundColor3 = targetColor
                    Knob.BackgroundColor3 = knobColor
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

            updateVisual(false)

            Toggle.Value = value
            function Toggle:SetValue(v) setValue(v) end
            function Toggle:GetValue() return value end

            -- Backward compat: .Value as readable
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
                Size = UDim2.new(1, 0, 0, 56),
                BackgroundColor3 = Theme.BG_Light,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(1, -80, 0, 20),
                Position = UDim2.fromOffset(14, 8),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                Text = opts.Text or "Slider",
                TextColor3 = Theme.Text_Primary,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local ValueLbl = new("TextLabel", {
                Parent = Row,
                Size = UDim2.fromOffset(60, 20),
                Position = UDim2.new(1, -70, 0, 8),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamBold,
                TextSize = 13,
                Text = tostring(value),
                TextColor3 = Theme.Accent,
                TextXAlignment = Enum.TextXAlignment.Right,
            })

            -- Track
            local Track = new("Frame", {
                Parent = Row,
                Size = UDim2.new(1, -28, 0, 6),
                Position = UDim2.new(0, 14, 0, 36),
                BackgroundColor3 = Theme.BG_Dark,
                BorderSizePixel = 0,
            })
            corner(Track, UDim.new(1, 0))

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
                Size = UDim2.fromOffset(16, 16),
                Position = UDim2.new((value - min) / (max - min), -8, 0.5, -8),
                BackgroundColor3 = Theme.Text_Primary,
                BorderSizePixel = 0,
                ZIndex = 2,
            })
            corner(Thumb, UDim.new(1, 0))
            stroke(Thumb, Theme.Accent, 2)

            local draggingSlider = false
            local function updateValue(input)
                local pos = (input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X
                pos = math.clamp(pos, 0, 1)
                value = math.floor(min + (max - min) * pos + 0.5)
                ValueLbl.Text = tostring(value)
                tween(Fill, Theme.TweenFast, { Size = UDim2.new(pos, 0, 1, 0) })
                tween(Thumb, Theme.TweenFast, { Position = UDim2.new(pos, -8, 0.5, -8) })
                if opts.Callback then pcall(opts.Callback, value) end
            end

            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = true
                    updateValue(input)
                end
            end)
            UIS.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    draggingSlider = false
                end
            end)
            UIS.InputChanged:Connect(function(input)
                if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
                    updateValue(input)
                end
            end)

            Slider.Value = value
            function Slider:SetValue(v)
                value = math.clamp(v, min, max)
                ValueLbl.Text = tostring(value)
                local pos = (value - min) / (max - min)
                Fill.Size = UDim2.new(pos, 0, 1, 0)
                Thumb.Position = UDim2.new(pos, -8, 0.5, -8)
            end
            function Slider:GetValue() return value end

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
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.BG_Light,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
                ClipsDescendants = false,
            })
            corner(Row)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(0.5, -14, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                Text = opts.Text or "Dropdown",
                TextColor3 = Theme.Text_Primary,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local CurrentBtn = new("TextButton", {
                Parent = Row,
                Size = UDim2.new(0.5, -20, 1, -12),
                Position = UDim2.new(0.5, 6, 0, 6),
                BackgroundColor3 = Theme.BG_Dark,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                Text = tostring(value) .. " ▼",
                TextColor3 = Theme.Text_Secondary,
                BorderSizePixel = 0,
                AutoButtonColor = false,
            })
            corner(CurrentBtn, UDim.new(0, 6))
            stroke(CurrentBtn, Theme.Border, 1)

            -- Options list
            local OptionsFrame = new("Frame", {
                Parent = Row,
                Size = UDim2.new(0.5, -20, 0, 0),
                Position = UDim2.new(0.5, 6, 1, 4),
                BackgroundColor3 = Theme.BG_Dark,
                BorderSizePixel = 0,
                Visible = false,
                ZIndex = 100,
                ClipsDescendants = true,
            })
            corner(OptionsFrame, UDim.new(0, 6))
            stroke(OptionsFrame, Theme.Border, 1)

            local OptionsList = new("UIListLayout", {
                Parent = OptionsFrame,
                Padding = UDim.new(0, 2),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })

            local function rebuildOptions()
                for _, c in ipairs(OptionsFrame:GetChildren()) do
                    if c:IsA("TextButton") then c:Destroy() end
                end
                for i, v in ipairs(values) do
                    local OptBtn = new("TextButton", {
                        Parent = OptionsFrame,
                        Size = UDim2.new(1, 0, 0, 28),
                        BackgroundColor3 = Theme.BG_Light,
                        BackgroundTransparency = 0.5,
                        Font = Enum.Font.Gotham,
                        TextSize = 12,
                        Text = tostring(v),
                        TextColor3 = v == value and Theme.Accent or Theme.Text_Primary,
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        LayoutOrder = i,
                        ZIndex = 101,
                    })
                    OptBtn.MouseButton1Click:Connect(function()
                        value = v
                        CurrentBtn.Text = tostring(v) .. " ▼"
                        open = false
                        tween(OptionsFrame, Theme.TweenFast, { Size = UDim2.new(0.5, -20, 0, 0) })
                        task.delay(0.15, function() OptionsFrame.Visible = false end)
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
                    local h = math.min(#values * 30, 150)
                    tween(OptionsFrame, Theme.TweenMed, { Size = UDim2.new(0.5, -20, 0, h) })
                else
                    tween(OptionsFrame, Theme.TweenFast, { Size = UDim2.new(0.5, -20, 0, 0) })
                    task.delay(0.15, function() OptionsFrame.Visible = false end)
                end
            end)

            Dropdown.Value = value
            function Dropdown:SetValue(v)
                value = v
                CurrentBtn.Text = tostring(v) .. " ▼"
                rebuildOptions()
            end
            function Dropdown:GetValue() return value end
            function Dropdown:SetValues(newValues)
                values = newValues
                rebuildOptions()
            end

            table.insert(Tab.Elements, Row)
            return Dropdown
        end

        function Tab:AddInput(opts)
            opts = opts or {}
            local value = opts.Default or ""
            local Input = {}

            local Row = new("Frame", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 40),
                BackgroundColor3 = Theme.BG_Light,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            corner(Row)

            new("TextLabel", {
                Parent = Row,
                Size = UDim2.new(0.4, -14, 1, 0),
                Position = UDim2.fromOffset(14, 0),
                BackgroundTransparency = 1,
                Font = Enum.Font.GothamMedium,
                TextSize = 13,
                Text = opts.Text or "Input",
                TextColor3 = Theme.Text_Primary,
                TextXAlignment = Enum.TextXAlignment.Left,
            })

            local Box = new("TextBox", {
                Parent = Row,
                Size = UDim2.new(0.6, -20, 1, -12),
                Position = UDim2.new(0.4, 6, 0, 6),
                BackgroundColor3 = Theme.BG_Dark,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                Text = tostring(value),
                PlaceholderText = opts.Placeholder or "",
                PlaceholderColor3 = Theme.Text_Muted,
                TextColor3 = Theme.Text_Primary,
                BorderSizePixel = 0,
                ClearTextOnFocus = false,
            })
            corner(Box, UDim.new(0, 6))
            stroke(Box, Theme.Border, 1)

            Box.Focused:Connect(function()
                tween(Box, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Medium })
            end)
            Box.FocusLost:Connect(function(enter)
                tween(Box, Theme.TweenFast, { BackgroundColor3 = Theme.BG_Dark })
                if enter then
                    value = Box.Text
                    if opts.Callback then pcall(opts.Callback, value) end
                end
            end)

            Input.Value = value
            function Input:SetValue(v) Box.Text = tostring(v); value = Box.Text end
            function Input:GetValue() return value end

            table.insert(Tab.Elements, Row)
            return Input
        end

        function Tab:AddLabel(text, centered)
            local Lbl = new("TextLabel", {
                Parent = TabContent,
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Font = Enum.Font.Gotham,
                TextSize = 12,
                Text = text,
                TextColor3 = Theme.Text_Secondary,
                TextXAlignment = centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
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
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Theme.Border,
                BackgroundTransparency = 0.5,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Elements + 1,
            })
            table.insert(Tab.Elements, Div)
            return Div
        end

        return Tab
    end

    return Window
end

-- ─── Global Notify (можно использовать без Window) ─────────────────────────
local NotifGui
function PubHubUI:Notify(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local text = opts.Text or ""
    local duration = opts.Duration or 3
    local kind = opts.Type or "info"  -- info / success / error / warning

    task.spawn(function()
        if not NotifGui or not NotifGui.Parent then
            NotifGui = new("ScreenGui", {
                Name = "PubHub_Notify_" .. HttpService:GenerateGUID(false):sub(1, 8),
                Parent = gethui(),
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 1000,
            })
        end

        -- Сдвигаем старые уведомления вверх
        for _, c in ipairs(NotifGui:GetChildren()) do
            if c:IsA("Frame") then
                local curY = c.Position.Y.Offset
                tween(c, Theme.TweenMed, { Position = UDim2.new(1, -340, 1, curY - 90) })
            end
        end

        local accentColor = Theme.Accent
        if kind == "success" then accentColor = Theme.Success
        elseif kind == "error" then accentColor = Theme.Error
        elseif kind == "warning" then accentColor = Theme.Warning end

        local Frame = new("Frame", {
            Parent = NotifGui,
            Size = UDim2.fromOffset(320, 80),
            Position = UDim2.new(1, 340, 1, -100),
            BackgroundColor3 = Theme.BG_Medium,
            BackgroundTransparency = 0.1,
            BorderSizePixel = 0,
        })
        corner(Frame, Theme.CornerRadius)
        stroke(Frame, accentColor, 1, 0.3)
        gradient(Frame, Theme.BG_Medium, Theme.BG_Dark, 90)

        -- Accent bar слева
        local AccentBar = new("Frame", {
            Parent = Frame,
            Size = UDim2.fromOffset(3, 0),
            Position = UDim2.fromOffset(0, 0),
            BackgroundColor3 = accentColor,
            BorderSizePixel = 0,
        })
        corner(AccentBar, UDim.new(1, 0))
        tween(AccentBar, Theme.TweenSpring, { Size = UDim2.fromOffset(3, 80) })

        new("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -30, 0, 20),
            Position = UDim2.fromOffset(20, 12),
            BackgroundTransparency = 1,
            Font = Enum.Font.GothamBold,
            TextSize = 14,
            Text = title,
            TextColor3 = Theme.Text_Primary,
            TextXAlignment = Enum.TextXAlignment.Left,
        })

        new("TextLabel", {
            Parent = Frame,
            Size = UDim2.new(1, -30, 0, 40),
            Position = UDim2.fromOffset(20, 34),
            BackgroundTransparency = 1,
            Font = Enum.Font.Gotham,
            TextSize = 12,
            Text = text,
            TextColor3 = Theme.Text_Secondary,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            TextWrapped = true,
        })

        -- Slide in
        tween(Frame, Theme.TweenSpring, { Position = UDim2.new(1, -340, 1, -100) })

        -- Auto-dismiss
        task.wait(duration)
        tween(Frame, Theme.TweenMed, { Position = UDim2.new(1, 340, 1, -100), BackgroundTransparency = 1 })
        task.wait(0.4)
        pcall(function() Frame:Destroy() end)
    end)
end

return PubHubUI
