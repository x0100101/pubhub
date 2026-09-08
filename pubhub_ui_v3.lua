-- ═══════════════════════════════════════════════════════════════════════════
-- PubHub UI Library v3 — PROFESSIONAL EDITION
-- Linear/Raycast-grade minimalism. Dark, compact, purple accent.
-- ═══════════════════════════════════════════════════════════════════════════

local PubHubUI = {}
PubHubUI.__index = PubHubUI

local cloneref = cloneref or clonereference or function(x) return x end
local Players = cloneref(game:GetService("Players"))
local TweenService = cloneref(game:GetService("TweenService"))
local RunService = cloneref(game:GetService("RunService"))
local UIS = cloneref(game:GetService("UserInputService"))
local HttpService = cloneref(game:GetService("HttpService"))
local TextService = cloneref(game:GetService("TextService"))
local lp = Players.LocalPlayer

-- ═══ CENTRALIZED THEME ═══
local Theme = {
    MainColor        = Color3.fromRGB(13, 13, 17),   -- почти чёрный фон окна
    SecondaryColor   = Color3.fromRGB(19, 19, 25),   -- карточки / sidebar
    TertiaryColor    = Color3.fromRGB(25, 25, 33),   -- hover / elevated
    AccentColor      = Color3.fromRGB(139, 92, 246), -- violet accent
    AccentDim        = Color3.fromRGB(109, 72, 196), -- violet dimmed
    StrokeColor      = Color3.fromRGB(32, 32, 42),   -- тонкие границы
    TextColor        = Color3.fromRGB(237, 237, 242),-- основной текст
    SubtextColor     = Color3.fromRGB(148, 150, 163),-- вторичный текст
    MutedColor       = Color3.fromRGB(94, 96, 110),  -- приглушённый
    SuccessColor     = Color3.fromRGB(52, 211, 153),
    ErrorColor       = Color3.fromRGB(248, 113, 113),
    WarningColor     = Color3.fromRGB(251, 191, 36),
    ModuleTransparency = 0,
    Font             = Enum.Font.Gotham,
    FontMedium       = Enum.Font.GothamMedium,
    FontBold         = Enum.Font.GothamBold,
    CornerRadius     = UDim.new(0, 8),
    CornerRadiusSmall= UDim.new(0, 6),
    TweenFast        = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    TweenMed         = TweenInfo.new(0.2,  Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
}

-- Реестр для авто-обновления темы
local ThemeRegistry = {}  -- { {inst=Instance, prop="BackgroundColor3", key="MainColor"}, ... }
local function regColor(inst, prop, key)
    table.insert(ThemeRegistry, {inst=inst, prop=prop, key=key})
    pcall(function() inst[prop] = Theme[key] end)
end

function PubHubUI:SetTheme(overrides)
    for k, v in pairs(overrides) do Theme[k] = v end
    for _, r in ipairs(ThemeRegistry) do
        if r.inst and r.inst.Parent then
            pcall(function() r.inst[r.prop] = Theme[r.key] end)
        end
    end
end

function PubHubUI:GetTheme() return Theme end

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
    TweenService:Create(obj, info or Theme.TweenFast, props):Play()
end

local function corner(parent, radius)
    return new("UICorner", { Parent = parent, CornerRadius = radius or Theme.CornerRadius })
end

local function stroke(parent, thickness, transparency)
    local s = new("UIStroke", {
        Parent = parent,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    })
    regColor(s, "Color", "StrokeColor")
    return s
end

local function padding(parent, t, r, b, l)
    if type(t) == "number" and not r then r = t; b = t; l = t end
    return new("UIPadding", {
        Parent = parent,
        PaddingTop = UDim.new(0, t or 0),
        PaddingRight = UDim.new(0, r or 0),
        PaddingBottom = UDim.new(0, b or 0),
        PaddingLeft = UDim.new(0, l or 0),
    })
end

local function label(parent, opts)
    local l = new("TextLabel", {
        Parent = parent,
        BackgroundTransparency = 1,
        Font = opts.Font or Theme.Font,
        TextSize = opts.Size or 13,
        Text = opts.Text or "",
        TextXAlignment = opts.Align or Enum.TextXAlignment.Left,
        TextYAlignment = opts.VAlign or Enum.TextYAlignment.Center,
        TextWrapped = opts.Wrapped or false,
        Size = opts.Size2 or UDim2.new(1, 0, 1, 0),
        Position = opts.Position or UDim2.new(0, 0, 0, 0),
        ZIndex = opts.ZIndex or 2,
    })
    regColor(l, "TextColor3", opts.ColorKey or "TextColor")
    return l
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

-- Минималистичные иконки через текстовые глифы (без assetid — работают везде)
local Glyphs = {
    star = "★", zap = "⚡", box = "▣", globe = "◍", home = "⌂",
    user = "◯", info = "ℹ", message = "✉", help = "?", bell = "◉",
    eye = "◉", shield = "⛨", layers = "▤", settings = "⚙",
    target = "◎", list = "☰", grid = "▦", play = "▶",
    default = "▪",
}

-- ═══ CreateWindow ═══
function PubHubUI:CreateWindow(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local size = opts.Size or UDim2.fromOffset(700, 460)
    local toggleKey = opts.ToggleKey or Enum.KeyCode.RightShift
    local startMinimized = opts.StartMinimized or false

    local Window = { Tabs = {}, ActiveTab = nil, Visible = not startMinimized }

    local SG = new("ScreenGui", {
        Name = "PubHub_" .. HttpService:GenerateGUID(false):sub(1, 8),
        Parent = gethui(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 500,
        IgnoreGuiInset = true,
    })
    Window.Gui = SG

    -- Main frame
    local Main = new("Frame", {
        Parent = SG,
        Size = size,
        Position = UDim2.fromScale(0.5, 0.5),
        AnchorPoint = Vector2.new(0.5, 0.5),
        BorderSizePixel = 0,
        ClipsDescendants = true,
    })
    regColor(Main, "BackgroundColor3", "MainColor")
    Window.Frame = Main
    corner(Main, UDim.new(0, 10))
    stroke(Main, 1, 0)

    -- ─── Titlebar (44px) ───
    local Titlebar = new("Frame", {
        Parent = Main,
        Size = UDim2.new(1, 0, 0, 44),
        BorderSizePixel = 0,
        ZIndex = 10,
    })
    regColor(Titlebar, "BackgroundColor3", "SecondaryColor")
    -- mask bottom
    local tbMask = new("Frame", {
        Parent = Titlebar,
        Size = UDim2.new(1, 0, 0, 10),
        Position = UDim2.new(0, 0, 1, -10),
        BorderSizePixel = 0,
        ZIndex = 10,
    })
    regColor(tbMask, "BackgroundColor3", "SecondaryColor")
    -- bottom border line
    local tbLine = new("Frame", {
        Parent = Titlebar,
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1),
        BorderSizePixel = 0,
        ZIndex = 11,
    })
    regColor(tbLine, "BackgroundColor3", "StrokeColor")

    -- Logo text
    local Logo = label(Titlebar, {
        Text = title, Font = Theme.FontBold, Size = 15,
        Size2 = UDim2.fromOffset(200, 44), Position = UDim2.fromOffset(16, 0),
        ColorKey = "TextColor", ZIndex = 11,
    })
    -- Accent dot рядом с логотипом
    local dot = new("Frame", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(6, 6),
        Position = UDim2.fromOffset(16 + 12 * (#title) + 14, 19),
        BorderSizePixel = 0,
        ZIndex = 11,
    })
    regColor(dot, "BackgroundColor3", "AccentColor")
    corner(dot, UDim.new(1, 0))

    -- Search box (справа, перед кнопками)
    local SearchFrame = new("Frame", {
        Parent = Titlebar,
        Size = UDim2.fromOffset(180, 28),
        Position = UDim2.new(1, -272, 0, 8),
        BorderSizePixel = 0,
        ZIndex = 11,
    })
    regColor(SearchFrame, "BackgroundColor3", "MainColor")
    corner(SearchFrame, Theme.CornerRadiusSmall)
    stroke(SearchFrame, 1, 0)

    local SearchBox = new("TextBox", {
        Parent = SearchFrame,
        Size = UDim2.new(1, -28, 1, 0),
        Position = UDim2.fromOffset(10, 0),
        BackgroundTransparency = 1,
        Font = Theme.Font,
        TextSize = 12,
        Text = "",
        PlaceholderText = "Search...",
        ClearTextOnFocus = false,
        TextXAlignment = Enum.TextXAlignment.Left,
        ZIndex = 12,
    })
    regColor(SearchBox, "TextColor3", "TextColor")
    regColor(SearchBox, "PlaceholderColor3", "MutedColor")

    label(SearchFrame, {
        Text = "⌕", Size = 14, Font = Theme.FontBold,
        Size2 = UDim2.fromOffset(20, 28),
        Position = UDim2.new(1, -22, 0, 0),
        ColorKey = "MutedColor", ZIndex = 12,
    })

    -- Window buttons
    local function WinBtn(txt, xOff, cb)
        local b = new("TextButton", {
            Parent = Titlebar,
            Size = UDim2.fromOffset(28, 28),
            Position = UDim2.new(1, xOff, 0, 8),
            Font = Theme.FontBold,
            TextSize = 13,
            Text = txt,
            BorderSizePixel = 0,
            AutoButtonColor = false,
            ZIndex = 12,
        })
        regColor(b, "BackgroundColor3", "TertiaryColor")
        regColor(b, "TextColor3", "SubtextColor")
        corner(b, Theme.CornerRadiusSmall)
        b.MouseEnter:Connect(function()
            tween(b, Theme.TweenFast, { BackgroundTransparency = 0 })
            regColor(b, "TextColor3", "TextColor")
        end)
        b.MouseLeave:Connect(function()
            regColor(b, "BackgroundColor3", "TertiaryColor")
            regColor(b, "TextColor3", "SubtextColor")
        end)
        b.MouseButton1Click:Connect(cb)
        return b
    end

    WinBtn("−", -84, function() Window:Toggle() end)
    WinBtn("×", -48, function() Window:Toggle(false) end)

    -- Dragging
    local dragging, dragStart, startPos = false, nil, nil
    Titlebar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = Main.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- ─── Sidebar (160px) ───
    local Sidebar = new("Frame", {
        Parent = Main,
        Size = UDim2.new(0, 160, 1, -60),
        Position = UDim2.fromOffset(12, 52),
        BorderSizePixel = 0,
        ZIndex = 5,
    })
    regColor(Sidebar, "BackgroundColor3", "SecondaryColor")
    corner(Sidebar, Theme.CornerRadius)
    stroke(Sidebar, 1, 0)

    local SidebarScroll = new("ScrollingFrame", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ZIndex = 6,
    })
    new("UIListLayout", {
        Parent = SidebarScroll,
        Padding = UDim.new(0, 2),
        SortOrder = Enum.SortOrder.LayoutOrder,
    })
    padding(SidebarScroll, 8, 8, 8, 8)

    -- ─── Content (справа от sidebar) ───
    local Content = new("Frame", {
        Parent = Main,
        Size = UDim2.new(1, -196, 1, -60),
        Position = UDim2.fromOffset(184, 52),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 5,
    })
    Window.Content = Content

    -- Keybind toggle
    UIS.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == toggleKey then Window:Toggle() end
    end)

    -- Search filter
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local q = SearchBox.Text:lower()
        for _, tab in ipairs(Window.Tabs) do
            for _, el in ipairs(tab.Elements) do
                if el._searchText then
                    local vis = q == "" or el._searchText:lower():find(q, 1, true) ~= nil
                    if el._frame then el._frame.Visible = vis end
                end
            end
        end
    end)

    -- Entrance
    if not startMinimized then
        Main.Size = UDim2.fromOffset(size.X.Offset, 0)
        tween(Main, Theme.TweenMed, { Size = size })
    else
        Main.Visible = false
    end

    function Window:Toggle(force)
        local target = force
        if target == nil then target = not Window.Visible end
        Window.Visible = target
        if target then
            Main.Visible = true
            Main.Size = UDim2.fromOffset(size.X.Offset, 0)
            tween(Main, Theme.TweenMed, { Size = size })
        else
            tween(Main, Theme.TweenFast, { Size = UDim2.fromOffset(size.X.Offset, 0) })
            task.delay(0.15, function()
                if not Window.Visible then Main.Visible = false end
            end)
        end
    end

    function Window:Destroy() SG:Destroy() end

    function Window:SetKeybind(key) toggleKey = key end

    -- ═══ AddTab ═══
    function Window:AddTab(name, glyph)
        local Tab = { Name = name, Elements = {}, Cards = {} }

        local TabBtn = new("TextButton", {
            Parent = SidebarScroll,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundTransparency = 1,
            Font = Theme.FontMedium,
            TextSize = 13,
            Text = "",
            BorderSizePixel = 0,
            AutoButtonColor = false,
            LayoutOrder = #Window.Tabs + 1,
            ZIndex = 7,
        })
        corner(TabBtn, Theme.CornerRadiusSmall)

        local Indicator = new("Frame", {
            Parent = TabBtn,
            Size = UDim2.fromOffset(2, 0),
            Position = UDim2.fromOffset(0, 6),
            BorderSizePixel = 0,
            ZIndex = 8,
        })
        regColor(Indicator, "BackgroundColor3", "AccentColor")
        corner(Indicator, UDim.new(1, 0))

        local IcoLbl = label(TabBtn, {
            Text = Glyphs[glyph] or Glyphs.default,
            Size = 13, Font = Theme.FontBold,
            Size2 = UDim2.fromOffset(20, 32), Position = UDim2.fromOffset(10, 0),
            ColorKey = "SubtextColor", ZIndex = 8,
        })

        local NameLbl = label(TabBtn, {
            Text = name, Size = 13, Font = Theme.FontMedium,
            Size2 = UDim2.new(1, -36, 1, 0), Position = UDim2.fromOffset(32, 0),
            ColorKey = "SubtextColor", ZIndex = 8,
        })

        -- Tab content: две колонки
        local TabContent = new("Frame", {
            Parent = Content,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Visible = false,
            ZIndex = 6,
        })
        Tab.Content = TabContent

        -- Две колонки: Left и Right
        local function makeColumn(x)
            local col = new("ScrollingFrame", {
                Parent = TabContent,
                Size = UDim2.new(0.5, -4, 1, 0),
                Position = UDim2.new(x == 0 and 0 or 0.5, x == 0 and 0 or 4, 0, 0),
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                ScrollBarThickness = 2,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ZIndex = 7,
            })
            regColor(col, "ScrollBarImageColor3", "AccentColor")
            new("UIListLayout", {
                Parent = col,
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })
            return col
        end

        Tab.LeftCol = makeColumn(0)
        Tab.RightCol = makeColumn(1)

        local function setActive(active)
            if active then
                TabBtn.BackgroundTransparency = 0
                regColor(TabBtn, "BackgroundColor3", "TertiaryColor")
                regColor(NameLbl, "TextColor3", "TextColor")
                regColor(IcoLbl, "TextColor3", "AccentColor")
                tween(Indicator, Theme.TweenFast, { Size = UDim2.fromOffset(2, 20) })
                TabContent.Visible = true
                TabContent.Position = UDim2.fromOffset(8, 0)
                tween(TabContent, Theme.TweenFast, { Position = UDim2.fromOffset(0, 0) })
            else
                TabBtn.BackgroundTransparency = 1
                regColor(NameLbl, "TextColor3", "SubtextColor")
                regColor(IcoLbl, "TextColor3", "SubtextColor")
                tween(Indicator, Theme.TweenFast, { Size = UDim2.fromOffset(2, 0) })
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
                TabBtn.BackgroundTransparency = 0.5
                regColor(TabBtn, "BackgroundColor3", "TertiaryColor")
            end
        end)
        TabBtn.MouseLeave:Connect(function()
            if Window.ActiveTab ~= Tab then TabBtn.BackgroundTransparency = 1 end
        end)

        function Tab:SetActive(v) setActive(v) end

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then Tab:SetActive(true); Window.ActiveTab = Tab end

        -- ═══ AddCard — карточка-группа. side: "left"/"right"/"full" ═══
        function Tab:AddCard(title, side)
            local parent = Tab.LeftCol
            if side == "right" then parent = Tab.RightCol end

            local Card = new("Frame", {
                Parent = parent,
                Size = UDim2.new(1, 0, 0, 40),  -- auto-resize по контенту
                AutomaticSize = Enum.AutomaticSize.Y,
                BorderSizePixel = 0,
                LayoutOrder = #Tab.Cards + 1,
                ZIndex = 8,
            })
            regColor(Card, "BackgroundColor3", "SecondaryColor")
            corner(Card, Theme.CornerRadius)
            stroke(Card, 1, 0)

            -- Header
            local Header = new("Frame", {
                Parent = Card,
                Size = UDim2.new(1, 0, 0, 32),
                BackgroundTransparency = 1,
                ZIndex = 9,
            })
            label(Header, {
                Text = title, Size = 12, Font = Theme.FontBold,
                Size2 = UDim2.new(1, -16, 1, 0), Position = UDim2.fromOffset(14, 0),
                ColorKey = "TextColor", ZIndex = 9,
            })
            -- Разделитель
            local hLine = new("Frame", {
                Parent = Card,
                Size = UDim2.new(1, -28, 0, 1),
                Position = UDim2.fromOffset(14, 32),
                BorderSizePixel = 0,
                ZIndex = 9,
            })
            regColor(hLine, "BackgroundColor3", "StrokeColor")

            -- Container для элементов
            local Body = new("Frame", {
                Parent = Card,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.fromOffset(0, 36),
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                ZIndex = 9,
            })
            new("UIListLayout", {
                Parent = Body,
                Padding = UDim.new(0, 4),
                SortOrder = Enum.SortOrder.LayoutOrder,
            })
            padding(Body, 2, 10, 10, 10)

            local CardObj = { Frame = Card, Body = Body, Elements = {} }
            table.insert(Tab.Cards, CardObj)

            -- ─── Элементы внутри карточки ───

            function CardObj:AddToggle(o)
                o = o or {}
                local value = o.Default or false
                local T = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Toggle", Size = 12, Font = Theme.Font,
                    Size2 = UDim2.new(1, -52, 1, 0), Position = UDim2.fromOffset(4, 0),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local Switch = new("Frame", {
                    Parent = Row,
                    Size = UDim2.fromOffset(34, 18),
                    Position = UDim2.new(1, -38, 0.5, -9),
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                corner(Switch, UDim.new(1, 0))
                regColor(Switch, "BackgroundColor3", "MainColor")
                local ss = stroke(Switch, 1, 0)

                local Knob = new("Frame", {
                    Parent = Switch,
                    Size = UDim2.fromOffset(12, 12),
                    Position = UDim2.fromOffset(3, 3),
                    BorderSizePixel = 0,
                    ZIndex = 11,
                })
                corner(Knob, UDim.new(1, 0))
                regColor(Knob, "BackgroundColor3", "MutedColor")

                local function vis(anim)
                    local tPos = value and UDim2.fromOffset(19, 3) or UDim2.fromOffset(3, 3)
                    if anim then tween(Knob, Theme.TweenFast, { Position = tPos }) else Knob.Position = tPos end
                    if value then
                        regColor(Switch, "BackgroundColor3", "AccentColor")
                        regColor(Knob, "BackgroundColor3", "TextColor")
                    else
                        regColor(Switch, "BackgroundColor3", "MainColor")
                        regColor(Knob, "BackgroundColor3", "MutedColor")
                    end
                end

                local function set(v, skip)
                    value = v
                    vis(true)
                    if not skip and o.Callback then pcall(o.Callback, v) end
                end

                local Btn = new("TextButton", {
                    Parent = Row, Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1, Text = "", BorderSizePixel = 0, ZIndex = 12,
                })
                Btn.MouseButton1Click:Connect(function() set(not value) end)

                vis(false)
                function T:SetValue(v) set(v) end
                function T:GetValue() return value end
                setmetatable(T, { __index = function(_, k) if k == "Value" then return value end end,
                                   __newindex = function(_, k, v) if k == "Value" then value = v; vis(false) end end })
                T._frame = Row; T._searchText = o.Text
                table.insert(CardObj.Elements, T)
                table.insert(Tab.Elements, T)
                return T
            end

            function CardObj:AddButton(o)
                o = o or {}
                local Btn = new("TextButton", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 30),
                    Font = Theme.FontMedium,
                    TextSize = 12,
                    Text = o.Text or "Button",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })
                regColor(Btn, "BackgroundColor3", "TertiaryColor")
                regColor(Btn, "TextColor3", "TextColor")
                corner(Btn, Theme.CornerRadiusSmall)
                local bs = stroke(Btn, 1, 0)

                Btn.MouseEnter:Connect(function()
                    regColor(bs, "Color", "AccentColor")
                end)
                Btn.MouseLeave:Connect(function()
                    regColor(bs, "Color", "StrokeColor")
                end)
                Btn.MouseButton1Click:Connect(function()
                    tween(Btn, Theme.TweenFast, { Size = UDim2.new(1, -4, 0, 28) })
                    task.wait(0.08)
                    tween(Btn, Theme.TweenFast, { Size = UDim2.new(1, 0, 0, 30) })
                    if o.Callback then pcall(o.Callback) end
                end)
                local B = { _frame = Btn, _searchText = o.Text }
                table.insert(CardObj.Elements, B)
                table.insert(Tab.Elements, B)
                return B
            end

            function CardObj:AddSlider(o)
                o = o or {}
                local min, max = o.Min or 0, o.Max or 100
                local value = o.Default or min
                local S = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 42),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Slider", Size = 12,
                    Size2 = UDim2.new(1, -60, 0, 18), Position = UDim2.fromOffset(4, 2),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local ValLbl = label(Row, {
                    Text = tostring(value), Size = 12, Font = Theme.FontBold,
                    Size2 = UDim2.fromOffset(56, 18),
                    Position = UDim2.new(1, -60, 0, 2),
                    Align = Enum.TextXAlignment.Right,
                    ColorKey = "AccentColor", ZIndex = 10,
                })

                local Track = new("Frame", {
                    Parent = Row,
                    Size = UDim2.new(1, -8, 0, 4),
                    Position = UDim2.fromOffset(4, 28),
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                corner(Track, UDim.new(1, 0))
                regColor(Track, "BackgroundColor3", "MainColor")

                local Fill = new("Frame", {
                    Parent = Track,
                    Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
                    BorderSizePixel = 0,
                    ZIndex = 11,
                })
                corner(Fill, UDim.new(1, 0))
                regColor(Fill, "BackgroundColor3", "AccentColor")

                local Thumb = new("Frame", {
                    Parent = Track,
                    Size = UDim2.fromOffset(12, 12),
                    Position = UDim2.new((value - min) / (max - min), -6, 0.5, -6),
                    BorderSizePixel = 0,
                    ZIndex = 12,
                })
                corner(Thumb, UDim.new(1, 0))
                regColor(Thumb, "BackgroundColor3", "TextColor")

                local dragging = false
                local function upd(input)
                    local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                    value = math.floor(min + (max - min) * pos + 0.5)
                    ValLbl.Text = tostring(value)
                    Fill.Size = UDim2.new(pos, 0, 1, 0)
                    Thumb.Position = UDim2.new(pos, -6, 0.5, -6)
                    if o.Callback then pcall(o.Callback, value) end
                end

                Track.InputBegan:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true; upd(i) end
                end)
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
                end)
                UIS.InputChanged:Connect(function(i)
                    if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then upd(i) end
                end)

                function S:SetValue(v)
                    value = math.clamp(v, min, max)
                    ValLbl.Text = tostring(value)
                    local pos = (value - min) / (max - min)
                    Fill.Size = UDim2.new(pos, 0, 1, 0)
                    Thumb.Position = UDim2.new(pos, -6, 0.5, -6)
                end
                function S:GetValue() return value end
                S._frame = Row; S._searchText = o.Text
                table.insert(CardObj.Elements, S)
                table.insert(Tab.Elements, S)
                return S
            end

            function CardObj:AddDropdown(o)
                o = o or {}
                local values = o.Values or {}
                local multi = o.Multi or false
                local value = o.Default or (multi and {} or values[1])
                local open = false
                local D = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 46),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ClipsDescendants = false,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Dropdown", Size = 12,
                    Size2 = UDim2.new(1, -8, 0, 16), Position = UDim2.fromOffset(4, 0),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local function displayVal()
                    if multi then
                        local n = 0
                        for _ in pairs(value) do n = n + 1 end
                        return n == 0 and "None" or (n .. " selected")
                    end
                    return tostring(value)
                end

                local Cur = new("TextButton", {
                    Parent = Row,
                    Size = UDim2.new(1, -8, 0, 24),
                    Position = UDim2.fromOffset(4, 20),
                    Font = Theme.Font,
                    TextSize = 12,
                    Text = "  " .. displayVal(),
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 10,
                })
                regColor(Cur, "BackgroundColor3", "MainColor")
                regColor(Cur, "TextColor3", "SubtextColor")
                corner(Cur, Theme.CornerRadiusSmall)
                local cs = stroke(Cur, 1, 0)

                local Arrow = label(Cur, {
                    Text = "▾", Size = 11, Font = Theme.FontBold,
                    Size2 = UDim2.fromOffset(16, 24),
                    Position = UDim2.new(1, -20, 0, 0),
                    Align = Enum.TextXAlignment.Center,
                    ColorKey = "MutedColor", ZIndex = 11,
                })

                local OptFrame = new("Frame", {
                    Parent = Row,
                    Size = UDim2.new(1, -8, 0, 0),
                    Position = UDim2.fromOffset(4, 46),
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 200,
                    ClipsDescendants = true,
                })
                regColor(OptFrame, "BackgroundColor3", "MainColor")
                corner(OptFrame, Theme.CornerRadiusSmall)
                local os2 = stroke(OptFrame, 1, 0)
                regColor(os2, "Color", "AccentColor")

                new("UIListLayout", { Parent = OptFrame, Padding = UDim.new(0, 1), SortOrder = Enum.SortOrder.LayoutOrder })
                padding(OptFrame, 3, 3, 3, 3)

                local function isSelected(v)
                    if multi then return value[v] == true end
                    return value == v
                end

                local function rebuild()
                    for _, c in ipairs(OptFrame:GetChildren()) do
                        if c:IsA("TextButton") then c:Destroy() end
                    end
                    for i, v in ipairs(values) do
                        local sel = isSelected(v)
                        local OB = new("TextButton", {
                            Parent = OptFrame,
                            Size = UDim2.new(1, 0, 0, 24),
                            Font = Theme.Font,
                            TextSize = 12,
                            Text = (sel and "  ✓ " or "    ") .. tostring(v),
                            TextXAlignment = Enum.TextXAlignment.Left,
                            BorderSizePixel = 0,
                            AutoButtonColor = false,
                            LayoutOrder = i,
                            ZIndex = 201,
                        })
                        regColor(OB, "BackgroundColor3", sel and "TertiaryColor" or "MainColor")
                        regColor(OB, "TextColor3", sel and "AccentColor" or "TextColor")
                        corner(OB, UDim.new(0, 4))
                        OB.MouseEnter:Connect(function()
                            OB.BackgroundTransparency = 0.5
                        end)
                        OB.MouseLeave:Connect(function()
                            OB.BackgroundTransparency = 0
                        end)
                        OB.MouseButton1Click:Connect(function()
                            if multi then
                                value[v] = not value[v]
                                if not value[v] then value[v] = nil end
                            else
                                value = v
                                open = false
                                tween(OptFrame, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, 0) })
                                tween(Arrow, Theme.TweenFast, { Rotation = 0 })
                                task.delay(0.14, function() OptFrame.Visible = false end)
                            end
                            Cur.Text = "  " .. displayVal()
                            if o.Callback then pcall(o.Callback, value) end
                            rebuild()
                        end)
                    end
                end
                rebuild()

                Cur.MouseButton1Click:Connect(function()
                    open = not open
                    if open then
                        OptFrame.Visible = true
                        local h = math.min(#values * 25 + 6, 160)
                        tween(OptFrame, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, h) })
                        tween(Arrow, Theme.TweenFast, { Rotation = 180 })
                        regColor(cs, "Color", "AccentColor")
                    else
                        tween(OptFrame, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, 0) })
                        tween(Arrow, Theme.TweenFast, { Rotation = 0 })
                        regColor(cs, "Color", "StrokeColor")
                        task.delay(0.14, function() OptFrame.Visible = false end)
                    end
                end)

                function D:SetValue(v) value = v; Cur.Text = "  " .. displayVal(); rebuild() end
                function D:GetValue() return value end
                function D:SetValues(nv) values = nv; rebuild() end
                D._frame = Row; D._searchText = o.Text
                table.insert(CardObj.Elements, D)
                table.insert(Tab.Elements, D)
                return D
            end

            function CardObj:AddInput(o)
                o = o or {}
                local value = o.Default or ""
                local I = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 46),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Input", Size = 12,
                    Size2 = UDim2.new(1, -8, 0, 16), Position = UDim2.fromOffset(4, 0),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local Box = new("TextBox", {
                    Parent = Row,
                    Size = UDim2.new(1, -8, 0, 24),
                    Position = UDim2.fromOffset(4, 20),
                    Font = Theme.Font,
                    TextSize = 12,
                    Text = tostring(value),
                    PlaceholderText = o.Placeholder or "",
                    ClearTextOnFocus = false,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    BorderSizePixel = 0,
                    ZIndex = 10,
                })
                regColor(Box, "BackgroundColor3", "MainColor")
                regColor(Box, "TextColor3", "TextColor")
                regColor(Box, "PlaceholderColor3", "MutedColor")
                corner(Box, Theme.CornerRadiusSmall)
                local bstroke = stroke(Box, 1, 0)
                padding(Box, 0, 8, 0, 8)

                Box.Focused:Connect(function()
                    regColor(bstroke, "Color", "AccentColor")
                end)
                Box.FocusLost:Connect(function(enter)
                    regColor(bstroke, "Color", "StrokeColor")
                    if enter then
                        value = Box.Text
                        if o.Callback then pcall(o.Callback, value) end
                    end
                end)

                function I:SetValue(v) Box.Text = tostring(v); value = Box.Text end
                function I:GetValue() return value end
                I._frame = Row; I._searchText = o.Text
                table.insert(CardObj.Elements, I)
                table.insert(Tab.Elements, I)
                return I
            end

            function CardObj:AddKeybind(o)
                o = o or {}
                local key = o.Default or Enum.KeyCode.E
                local listening = false
                local K = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Keybind", Size = 12,
                    Size2 = UDim2.new(1, -90, 1, 0), Position = UDim2.fromOffset(4, 0),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local KeyBtn = new("TextButton", {
                    Parent = Row,
                    Size = UDim2.fromOffset(80, 22),
                    Position = UDim2.new(1, -84, 0.5, -11),
                    Font = Theme.FontMedium,
                    TextSize = 11,
                    Text = key.Name,
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 10,
                })
                regColor(KeyBtn, "BackgroundColor3", "MainColor")
                regColor(KeyBtn, "TextColor3", "SubtextColor")
                corner(KeyBtn, Theme.CornerRadiusSmall)
                local kstroke = stroke(KeyBtn, 1, 0)

                KeyBtn.MouseButton1Click:Connect(function()
                    listening = true
                    KeyBtn.Text = "..."
                    regColor(kstroke, "Color", "AccentColor")
                end)

                UIS.InputBegan:Connect(function(input, processed)
                    if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                        key = input.KeyCode
                        KeyBtn.Text = key.Name
                        listening = false
                        regColor(kstroke, "Color", "StrokeColor")
                        if o.Callback then pcall(o.Callback, key) end
                    elseif not processed and input.KeyCode == key and not listening then
                        if o.OnPress then pcall(o.OnPress) end
                    end
                end)

                function K:SetKey(k) key = k; KeyBtn.Text = k.Name end
                function K:GetKey() return key end
                K._frame = Row; K._searchText = o.Text
                table.insert(CardObj.Elements, K)
                table.insert(Tab.Elements, K)
                return K
            end

            function CardObj:AddColorPicker(o)
                o = o or {}
                local value = o.Default or Color3.fromRGB(139, 92, 246)
                local CP = {}

                local Row = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 28),
                    BackgroundTransparency = 1,
                    LayoutOrder = #CardObj.Elements + 1,
                    ClipsDescendants = false,
                    ZIndex = 10,
                })

                label(Row, {
                    Text = o.Text or "Color", Size = 12,
                    Size2 = UDim2.new(1, -60, 1, 0), Position = UDim2.fromOffset(4, 0),
                    ColorKey = "TextColor", ZIndex = 10,
                })

                local Preview = new("TextButton", {
                    Parent = Row,
                    Size = UDim2.fromOffset(48, 20),
                    Position = UDim2.new(1, -52, 0.5, -10),
                    Text = "",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 10,
                })
                Preview.BackgroundColor3 = value
                corner(Preview, Theme.CornerRadiusSmall)
                stroke(Preview, 1, 0)

                -- Простая палитра (grid цветов)
                local Palette = new("Frame", {
                    Parent = Row,
                    Size = UDim2.new(1, -8, 0, 0),
                    Position = UDim2.fromOffset(4, 30),
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 200,
                    ClipsDescendants = true,
                })
                regColor(Palette, "BackgroundColor3", "MainColor")
                corner(Palette, Theme.CornerRadiusSmall)
                stroke(Palette, 1, 0)
                padding(Palette, 6, 6, 6, 6)

                local Grid = new("UIGridLayout", {
                    Parent = Palette,
                    CellSize = UDim2.fromOffset(22, 22),
                    CellPadding = UDim2.fromOffset(4, 4),
                    SortOrder = Enum.SortOrder.LayoutOrder,
                })

                local presetColors = {
                    Color3.fromRGB(139, 92, 246), Color3.fromRGB(236, 72, 153),
                    Color3.fromRGB(59, 130, 246), Color3.fromRGB(34, 211, 238),
                    Color3.fromRGB(52, 211, 153), Color3.fromRGB(251, 191, 36),
                    Color3.fromRGB(248, 113, 113), Color3.fromRGB(255, 255, 255),
                    Color3.fromRGB(148, 163, 184), Color3.fromRGB(94, 96, 110),
                    Color3.fromRGB(30, 30, 40), Color3.fromRGB(0, 0, 0),
                }

                for i, c in ipairs(presetColors) do
                    local Sw = new("TextButton", {
                        Parent = Palette,
                        BackgroundColor3 = c,
                        Text = "",
                        BorderSizePixel = 0,
                        AutoButtonColor = false,
                        LayoutOrder = i,
                        ZIndex = 201,
                    })
                    corner(Sw, UDim.new(0, 4))
                    stroke(Sw, 1, 0.5)
                    Sw.MouseButton1Click:Connect(function()
                        value = c
                        Preview.BackgroundColor3 = c
                        Palette.Visible = false
                        Palette.Size = UDim2.new(1, -8, 0, 0)
                        if o.Callback then pcall(o.Callback, c) end
                    end)
                end

                local pOpen = false
                Preview.MouseButton1Click:Connect(function()
                    pOpen = not pOpen
                    if pOpen then
                        Palette.Visible = true
                        local rows = math.ceil(#presetColors / 8)
                        tween(Palette, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, rows * 26 + 12) })
                    else
                        tween(Palette, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, 0) })
                        task.delay(0.14, function() Palette.Visible = false end)
                    end
                end)

                function CP:SetValue(c) value = c; Preview.BackgroundColor3 = c end
                function CP:GetValue() return value end
                CP._frame = Row; CP._searchText = o.Text
                table.insert(CardObj.Elements, CP)
                table.insert(Tab.Elements, CP)
                return CP
            end

            function CardObj:AddLabel(text, centered)
                local L = label(Body, {
                    Text = text, Size = 12,
                    Size2 = UDim2.new(1, -8, 0, 20),
                    Position = UDim2.fromOffset(4, 0),
                    Align = centered and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
                    ColorKey = "SubtextColor",
                    Wrapped = true,
                    ZIndex = 10,
                })
                local LO = {}
                function LO:SetText(t) L.Text = t end
                function LO:GetText() return L.Text end
                LO._frame = L; LO._searchText = text
                table.insert(CardObj.Elements, LO)
                table.insert(Tab.Elements, LO)
                return LO
            end

            function CardObj:AddDivider()
                local D = new("Frame", {
                    Parent = Body,
                    Size = UDim2.new(1, 0, 0, 1),
                    BorderSizePixel = 0,
                    LayoutOrder = #CardObj.Elements + 1,
                    ZIndex = 10,
                })
                regColor(D, "BackgroundColor3", "StrokeColor")
                return D
            end

            return CardObj
        end

        -- Backward-compat: Tab:AddLeftGroupbox / AddRightGroupbox → AddCard
        function Tab:AddLeftGroupbox(title) return Tab:AddCard(title, "left") end
        function Tab:AddRightGroupbox(title) return Tab:AddCard(title, "right") end

        return Tab
    end

    return Window
end

-- ═══ Notify ═══
local NotifGui
function PubHubUI:Notify(opts)
    opts = opts or {}
    local title = opts.Title or "PubHub"
    local text = opts.Text or ""
    local duration = opts.Duration or 3
    local kind = opts.Type or "info"

    task.spawn(function()
        if not NotifGui or not NotifGui.Parent then
            NotifGui = new("ScreenGui", {
                Name = "PubHub_N_" .. HttpService:GenerateGUID(false):sub(1, 8),
                Parent = gethui(),
                ResetOnSpawn = false,
                ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
                DisplayOrder = 1000,
                IgnoreGuiInset = true,
            })
        end

        for _, c in ipairs(NotifGui:GetChildren()) do
            if c:IsA("Frame") then
                tween(c, Theme.TweenFast, { Position = UDim2.new(1, -330, 1, c.Position.Y.Offset - 70) })
            end
        end

        local accKey = "AccentColor"
        if kind == "success" then accKey = "SuccessColor"
        elseif kind == "error" then accKey = "ErrorColor"
        elseif kind == "warning" then accKey = "WarningColor" end

        local Frame = new("Frame", {
            Parent = NotifGui,
            Size = UDim2.fromOffset(310, 60),
            Position = UDim2.new(1, 330, 1, -80),
            BorderSizePixel = 0,
        })
        regColor(Frame, "BackgroundColor3", "SecondaryColor")
        corner(Frame, Theme.CornerRadius)
        local fs = stroke(Frame, 1, 0)
        regColor(fs, "Color", accKey)

        local Bar = new("Frame", {
            Parent = Frame,
            Size = UDim2.fromOffset(2, 60),
            BorderSizePixel = 0,
        })
        regColor(Bar, "BackgroundColor3", accKey)

        label(Frame, {
            Text = title, Size = 13, Font = Theme.FontBold,
            Size2 = UDim2.new(1, -24, 0, 18), Position = UDim2.fromOffset(14, 8),
            ColorKey = "TextColor",
        })
        label(Frame, {
            Text = text, Size = 12,
            Size2 = UDim2.new(1, -24, 0, 30), Position = UDim2.fromOffset(14, 26),
            ColorKey = "SubtextColor", VAlign = Enum.TextYAlignment.Top, Wrapped = true,
        })

        tween(Frame, Theme.TweenMed, { Position = UDim2.new(1, -330, 1, -80) })
        task.wait(duration)
        tween(Frame, Theme.TweenFast, { Position = UDim2.new(1, 330, 1, -80) })
        task.wait(0.15)
        pcall(function() Frame:Destroy() end)
    end)
end

return PubHubUI
