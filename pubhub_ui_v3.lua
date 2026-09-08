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
                        -- Поднимаем ZIndex всей карточки чтобы dropdown был поверх следующих
                        local function raiseZ(inst, delta)
                            for _, d in ipairs(inst:GetDescendants()) do
                                if d:IsA("GuiObject") then d.ZIndex = d.ZIndex + delta end
                            end
                            if inst:IsA("GuiObject") then inst.ZIndex = inst.ZIndex + delta end
                        end
                        pcall(function() raiseZ(Card, 200) end)
                        OptFrame.Visible = true
                        local h = math.min(#values * 25 + 6, 160)
                        tween(OptFrame, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, h) })
                        tween(Arrow, Theme.TweenFast, { Rotation = 180 })
                        regColor(cs, "Color", "AccentColor")
                    else
                        tween(OptFrame, Theme.TweenFast, { Size = UDim2.new(1, -8, 0, 0) })
                        tween(Arrow, Theme.TweenFast, { Rotation = 0 })
                        regColor(cs, "Color", "StrokeColor")
                        task.delay(0.14, function()
                            OptFrame.Visible = false
                            -- Возвращаем ZIndex
                            local function lowerZ(inst, delta)
                                for _, d in ipairs(inst:GetDescendants()) do
                                    if d:IsA("GuiObject") then d.ZIndex = math.max(1, d.ZIndex - delta) end
                                end
                                if inst:IsA("GuiObject") then inst.ZIndex = math.max(1, inst.ZIndex - delta) end
                            end
                            pcall(function() lowerZ(Card, 200) end)
                        end)
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

                -- Popup ColorPicker окно
                local Popup = new("Frame", {
                    Parent = SG,
                    Size = UDim2.fromOffset(240, 200),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BorderSizePixel = 0,
                    Visible = false,
                    ZIndex = 500,
                })
                regColor(Popup, "BackgroundColor3", "SecondaryColor")
                corner(Popup, UDim.new(0, 10))
                stroke(Popup, 1, 0)

                -- Gradient hue bar
                local HueBar = new("Frame", {
                    Parent = Popup,
                    Size = UDim2.new(1, -20, 0, 20),
                    Position = UDim2.fromOffset(10, 10),
                    BorderSizePixel = 0,
                    ZIndex = 501,
                })
                corner(HueBar, UDim.new(0, 6))
                new("UIGradient", {
                    Parent = HueBar,
                    Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                        ColorSequenceKeypoint.new(0.17, Color3.fromRGB(255, 255, 0)),
                        ColorSequenceKeypoint.new(0.33, Color3.fromRGB(0, 255, 0)),
                        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                        ColorSequenceKeypoint.new(0.67, Color3.fromRGB(0, 0, 255)),
                        ColorSequenceKeypoint.new(0.83, Color3.fromRGB(255, 0, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0)),
                    }),
                })

                local hue = 0
                local sat = 1
                local val = 1

                local HueSlider = new("TextButton", {
                    Parent = HueBar,
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    Text = "",
                    ZIndex = 502,
                })

                local HueMarker = new("Frame", {
                    Parent = HueBar,
                    Size = UDim2.fromOffset(4, 20),
                    Position = UDim2.new(0, 0, 0, 0),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 503,
                })
                corner(HueMarker, UDim.new(0, 2))

                -- Saturation/Value box
                local SVBox = new("Frame", {
                    Parent = Popup,
                    Size = UDim2.new(1, -20, 0, 80),
                    Position = UDim2.fromOffset(10, 40),
                    BorderSizePixel = 0,
                    ZIndex = 501,
                })
                corner(SVBox, UDim.new(0, 6))

                local SVGrad = new("UIGradient", {
                    Parent = SVBox,
                    Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1), Color3.fromHSV(hue, 1, 1)),
                })

                local SVCross = new("Frame", {
                    Parent = SVBox,
                    Size = UDim2.fromOffset(10, 10),
                    Position = UDim2.fromScale(0.5, 0.5),
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    BackgroundColor3 = Color3.new(1, 1, 1),
                    BorderSizePixel = 0,
                    ZIndex = 503,
                })
                corner(SVCross, UDim.new(1, 0))

                -- HEX input
                local HexBox = new("TextBox", {
                    Parent = Popup,
                    Size = UDim2.new(1, -20, 0, 24),
                    Position = UDim2.fromOffset(10, 130),
                    Font = Theme.Font,
                    TextSize = 12,
                    Text = colorToHex(value),
                    PlaceholderText = "#FFFFFF",
                    BorderSizePixel = 0,
                    ZIndex = 501,
                })
                regColor(HexBox, "BackgroundColor3", "MainColor")
                regColor(HexBox, "TextColor3", "TextColor")
                regColor(HexBox, "PlaceholderColor3", "MutedColor")
                corner(HexBox, Theme.CornerRadiusSmall)
                stroke(HexBox, 1, 0)
                padding(HexBox, 0, 8, 0, 8)

                -- RGB labels
                local rgbLbl = label(Popup, {
                    Text = "RGB: 139, 92, 246",
                    Size = 11,
                    Size2 = UDim2.new(1, -20, 0, 16),
                    Position = UDim2.fromOffset(10, 160),
                    ColorKey = "SubtextColor",
                    ZIndex = 501,
                })

                -- Apply button
                local ApplyBtn = new("TextButton", {
                    Parent = Popup,
                    Size = UDim2.new(1, -20, 0, 24),
                    Position = UDim2.fromOffset(10, 178),
                    Font = Theme.FontMedium,
                    TextSize = 12,
                    Text = "Apply",
                    BorderSizePixel = 0,
                    AutoButtonColor = false,
                    ZIndex = 501,
                })
                regColor(ApplyBtn, "BackgroundColor3", "AccentColor")
                regColor(ApplyBtn, "TextColor3", "TextColor")
                corner(ApplyBtn, Theme.CornerRadiusSmall)

                local function updateColor()
                    value = Color3.fromHSV(hue, sat, val)
                    Preview.BackgroundColor3 = value
                    HexBox.Text = colorToHex(value)
                    rgbLbl.Text = string.format("RGB: %d, %d, %d",
                        math.floor(value.R * 255),
                        math.floor(value.G * 255),
                        math.floor(value.B * 255))
                    if o.Callback then pcall(o.Callback, value) end
                end

                local hueDragging = false
                HueSlider.MouseButton1Down:Connect(function()
                    hueDragging = true
                end)
                UIS.InputEnded:Connect(function(i)
                    if i.UserInputType == Enum.UserInputType.MouseButton1 then hueDragging = false end
                end)
                UIS.InputChanged:Connect(function(i)
                    if hueDragging and i.UserInputType == Enum.UserInputType.MouseMovement then
                        local pos = math.clamp((i.Position.X - HueBar.AbsolutePosition.X) / HueBar.AbsoluteSize.X, 0, 1)
                        hue = pos
                        HueMarker.Position = UDim2.new(pos, -2, 0, 0)
                        SVGrad.Color = ColorSequence.new(Color3.fromHSV(hue, 1, 1), Color3.fromHSV(hue, 1, 1))
                        updateColor()
                    end
                end)

                HexBox.FocusLost:Connect(function(enter)
                    if enter then
                        local c = hexToColor(HexBox.Text)
                        if c then
                            value = c
                            local h, s, v = c:ToHSV()
                            hue, sat, val = h, s, v
                            HueMarker.Position = UDim2.new(hue, -2, 0, 0)
                            updateColor()
                        end
                    end
                end)

                ApplyBtn.MouseButton1Click:Connect(function()
                    Popup.Visible = false
                end)

                Preview.MouseButton1Click:Connect(function()
                    Popup.Visible = not Popup.Visible
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

-- ═══ CONFIG PERSISTENCE ═══
local CONFIG_FILE = "pubhub_ui_config.json"

local function saveConfig(cfg)
    pcall(function()
        if writefile then
            -- Сериализуем Color3 в {r,g,b}
            local out = {}
            for k, v in pairs(cfg) do
                if typeof(v) == "Color3" then
                    out[k] = { __c = true, r = v.R, g = v.G, b = v.B }
                elseif typeof(v) == "EnumItem" then
                    out[k] = { __e = true, name = v.Name }
                else
                    out[k] = v
                end
            end
            writefile(CONFIG_FILE, HttpService:JSONEncode(out))
        end
    end)
end

local function loadConfig()
    local ok, raw = pcall(function()
        if readfile and isfile and isfile(CONFIG_FILE) then
            return readfile(CONFIG_FILE)
        end
    end)
    if not ok or not raw then return {} end
    local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then return {} end
    local out = {}
    for k, v in pairs(data) do
        if type(v) == "table" and v.__c then
            out[k] = Color3.new(v.r, v.g, v.b)
        elseif type(v) == "table" and v.__e then
            pcall(function() out[k] = Enum.KeyCode[v.name] end)
        else
            out[k] = v
        end
    end
    return out
end

-- Сохранённые настройки (загружаются при старте)
local SavedConfig = loadConfig()

-- Дефолтная тема (для ResetTheme)
local DefaultTheme = {}
for k, v in pairs(Theme) do DefaultTheme[k] = v end

function PubHubUI:ResetTheme()
    for k in pairs(Theme) do Theme[k] = nil end
    for k, v in pairs(DefaultTheme) do Theme[k] = v end
    for _, r in ipairs(ThemeRegistry) do
        if r.inst and r.inst.Parent then
            pcall(function() r.inst[r.prop] = Theme[r.key] end)
        end
    end
end

function PubHubUI:SaveConfig() saveConfig(SavedConfig) end
function PubHubUI:LoadConfig() SavedConfig = loadConfig(); return SavedConfig end
function PubHubUI:GetConfig() return SavedConfig end

-- ═══ HEX <-> Color3 ═══
local function colorToHex(c)
    return string.format("#%02X%02X%02X",
        math.floor(c.R * 255 + 0.5),
        math.floor(c.G * 255 + 0.5),
        math.floor(c.B * 255 + 0.5))
end

local function hexToColor(hex)
    hex = hex:gsub("#", "")
    if #hex ~= 6 then return nil end
    local r = tonumber(hex:sub(1, 2), 16)
    local g = tonumber(hex:sub(3, 4), 16)
    local b = tonumber(hex:sub(5, 6), 16)
    if not r or not g or not b then return nil end
    return Color3.fromRGB(r, g, b)
end

-- ═══ Gui Tab builder — вызывается из main-скрипта ═══
-- Создаёт вкладку "Gui" со всеми настройками интерфейса
function PubHubUI:BuildGuiTab(Window)
    local GuiTab = Window:AddTab("Gui", "settings")

    -- Ссылки для авто-обновления
    Window._guiState = Window._guiState or {}
    local State = Window._guiState
    State.HideOnMinimized = SavedConfig.HideOnMinimized or false
    State.StartMinimized = SavedConfig.StartMinimized or false
    State.CompactMinimized = SavedConfig.CompactMinimized or false
    State.KeybindList = SavedConfig.KeybindList or false
    State.ToggleKey = SavedConfig.ToggleKey or Enum.KeyCode.RightShift
    State.Media = SavedConfig.Media or "None"
    State.MediaOpacity = SavedConfig.MediaOpacity or 45
    State.MediaURL = SavedConfig.MediaURL or ""
    State.NotifPosition = SavedConfig.NotifPosition or "Right Bottom"

    -- ═══ LEFT COLUMN ═══

    -- ─── Card: Interface ───
    local Iface = GuiTab:AddCard("Interface", "left")

    Iface:AddToggle({
        Text = "Hide on minimized",
        Default = State.HideOnMinimized,
        Callback = function(v)
            State.HideOnMinimized = v
            SavedConfig.HideOnMinimized = v
            saveConfig(SavedConfig)
        end,
    })

    Iface:AddToggle({
        Text = "Start minimized",
        Default = State.StartMinimized,
        Callback = function(v)
            State.StartMinimized = v
            SavedConfig.StartMinimized = v
            saveConfig(SavedConfig)
        end,
    })

    Iface:AddToggle({
        Text = "Compact when minimized",
        Default = State.CompactMinimized,
        Callback = function(v)
            State.CompactMinimized = v
            SavedConfig.CompactMinimized = v
            saveConfig(SavedConfig)
        end,
    })

    Iface:AddToggle({
        Text = "Keybind list",
        Default = State.KeybindList,
        Callback = function(v)
            State.KeybindList = v
            SavedConfig.KeybindList = v
            saveConfig(SavedConfig)
            -- TODO: toggle keybind list overlay
        end,
    })

    Iface:AddKeybind({
        Text = "Toggle key",
        Default = State.ToggleKey,
        Callback = function(k)
            State.ToggleKey = k
            SavedConfig.ToggleKey = k
            Window:SetKeybind(k)
            saveConfig(SavedConfig)
        end,
    })

    -- ─── Card: Background ───
    local Bg = GuiTab:AddCard("Background", "left")

    Bg:AddDropdown({
        Text = "Media",
        Values = { "None", "Image", "Video" },
        Default = State.Media,
        Callback = function(v)
            State.Media = v
            SavedConfig.Media = v
            saveConfig(SavedConfig)
        end,
    })

    Bg:AddSlider({
        Text = "Media Opacity",
        Min = 0, Max = 100, Default = State.MediaOpacity,
        Callback = function(v)
            State.MediaOpacity = v
            SavedConfig.MediaOpacity = v
            saveConfig(SavedConfig)
            -- Apply transparency к main frame
            local target = v / 100
            if Window.Frame then
                Window.Frame.BackgroundTransparency = target * 0.9
            end
        end,
    })

    Bg:AddInput({
        Text = "Media URL",
        Placeholder = "https://... or rbxassetid://",
        Default = State.MediaURL,
        Callback = function(v)
            State.MediaURL = v
            SavedConfig.MediaURL = v
            saveConfig(SavedConfig)
        end,
    })

    Bg:AddInput({
        Text = "Save as",
        Placeholder = "Name for the file",
        Callback = function(v)
            State.MediaSaveAs = v
        end,
    })

    Bg:AddButton({
        Text = "Download and use",
        Callback = function()
            if State.MediaURL == "" then
                PubHubUI:Notify({ Title = "Background", Text = "Enter a URL first", Type = "warning" })
                return
            end
            PubHubUI:Notify({ Title = "Background", Text = "Downloading...", Type = "info" })
            task.spawn(function()
                local ok, data = pcall(function() return game:HttpGet(State.MediaURL) end)
                if ok and data then
                    local fname = (State.MediaSaveAs or "bg") .. ".png"
                    pcall(function() writefile(fname, data) end)
                    PubHubUI:Notify({ Title = "Background", Text = "Saved as " .. fname, Type = "success" })
                else
                    PubHubUI:Notify({ Title = "Background", Text = "Download failed", Type = "error" })
                end
            end)
        end,
    })

    Bg:AddButton({
        Text = "Refresh list",
        Callback = function()
            PubHubUI:Notify({ Title = "Background", Text = "Refreshed", Type = "info" })
        end,
    })

    Bg:AddButton({
        Text = "Delete Background",
        Callback = function()
            State.MediaURL = ""
            SavedConfig.MediaURL = ""
            saveConfig(SavedConfig)
            if Window.Frame then Window.Frame.BackgroundTransparency = 0 end
            PubHubUI:Notify({ Title = "Background", Text = "Cleared", Type = "info" })
        end,
    })

    -- ═══ RIGHT COLUMN ═══

    -- ─── Card: Notifications ───
    local Notif = GuiTab:AddCard("Notifications", "right")

    Notif:AddDropdown({
        Text = "Position",
        Values = { "Right Bottom", "Right Top", "Left Bottom", "Left Top", "Top Center" },
        Default = State.NotifPosition,
        Callback = function(v)
            State.NotifPosition = v
            SavedConfig.NotifPosition = v
            saveConfig(SavedConfig)
        end,
    })

    Notif:AddButton({
        Text = "Preview",
        Callback = function()
            PubHubUI:Notify({ Title = "Preview", Text = "This is a test notification", Type = "info" })
        end,
    })

    Notif:AddButton({
        Text = "Preview (Content)",
        Callback = function()
            PubHubUI:Notify({
                Title = "Preview",
                Text = "This is a longer notification with more content to show how text wraps and the notification looks with real content inside it.",
                Type = "success",
                Duration = 5,
            })
        end,
    })

    -- ─── Card: Appearance ───
    local App = GuiTab:AddCard("Appearance", "right")

    local function makeColorRow(label, themeKey)
        App:AddColorPicker({
            Text = label,
            Default = Theme[themeKey],
            Callback = function(c)
                Theme[themeKey] = c
                SavedConfig[themeKey] = c
                PubHubUI:SetTheme({ [themeKey] = c })
                saveConfig(SavedConfig)
            end,
        })
    end

    makeColorRow("Main color", "MainColor")
    makeColorRow("Secondary", "SecondaryColor")
    makeColorRow("Accent", "AccentColor")
    makeColorRow("Stroke", "StrokeColor")
    makeColorRow("Text", "TextColor")
    makeColorRow("Subtext", "SubtextColor")

    App:AddSlider({
        Text = "Module transparency",
        Min = 0, Max = 100, Default = math.floor((Theme.ModuleTransparency or 0) * 100),
        Callback = function(v)
            local t = v / 100
            Theme.ModuleTransparency = t
            SavedConfig.ModuleTransparency = t
            saveConfig(SavedConfig)
        end,
    })

    App:AddButton({
        Text = "Restore default theme",
        Callback = function()
            PubHubUI:ResetTheme()
            -- Чистим saved colors
            for _, k in ipairs({"MainColor","SecondaryColor","AccentColor","StrokeColor","TextColor","SubtextColor","ModuleTransparency"}) do
                SavedConfig[k] = nil
            end
            saveConfig(SavedConfig)
            PubHubUI:Notify({ Title = "Theme", Text = "Default theme restored", Type = "success" })
        end,
    })

    -- ─── Card: Watermark ───
    local Wm = GuiTab:AddCard("Watermark", "left")
    local WC = PubHubUI.WatermarkConfig

    Wm:AddToggle({ Text = "Enable Watermark", Default = WC.Enabled, Callback = function(v)
        WC.Enabled = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.WatermarkFrame then PubHubUI.WatermarkFrame.Visible = v end
    end })

    Wm:AddDropdown({
        Text = "Position",
        Values = { "Top Left", "Top Center", "Top Right", "Bottom Left", "Bottom Center", "Bottom Right" },
        Default = WC.Position:gsub("(%u)", " %1"):gsub("^ ", ""),
        Callback = function(v)
            WC.Position = v:gsub(" ", "")
            SavedConfig.Watermark = WC; saveConfig(SavedConfig)
            if PubHubUI.RepositionWatermark then PubHubUI.RepositionWatermark() end
        end,
    })

    Wm:AddToggle({ Text = "Compact Mode", Default = WC.CompactMode, Callback = function(v)
        WC.CompactMode = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })

    Wm:AddToggle({ Text = "Show Username", Default = WC.ShowUsername, Callback = function(v)
        WC.ShowUsername = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Key Time", Default = WC.ShowKeyTime, Callback = function(v)
        WC.ShowKeyTime = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Clock", Default = WC.ShowClock, Callback = function(v)
        WC.ShowClock = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show FPS", Default = WC.ShowFPS, Callback = function(v)
        WC.ShowFPS = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Ping", Default = WC.ShowPing, Callback = function(v)
        WC.ShowPing = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Server", Default = WC.ShowServer, Callback = function(v)
        WC.ShowServer = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Game", Default = WC.ShowGame, Callback = function(v)
        WC.ShowGame = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Session Time", Default = WC.ShowSessionTime, Callback = function(v)
        WC.ShowSessionTime = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Executor", Default = WC.ShowExecutor, Callback = function(v)
        WC.ShowExecutor = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })
    Wm:AddToggle({ Text = "Show Version", Default = WC.ShowVersion, Callback = function(v)
        WC.ShowVersion = v; SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.RebuildWatermark then PubHubUI.RebuildWatermark() end
    end })

    Wm:AddSlider({ Text = "Transparency", Min = 0, Max = 90, Default = math.floor(WC.Transparency * 100), Callback = function(v)
        WC.Transparency = v / 100
        SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.WatermarkFrame then PubHubUI.WatermarkFrame.BackgroundTransparency = WC.Transparency end
    end })

    Wm:AddSlider({ Text = "Scale (%)", Min = 50, Max = 200, Default = math.floor(WC.Scale * 100), Callback = function(v)
        WC.Scale = v / 100
        SavedConfig.Watermark = WC; saveConfig(SavedConfig)
        if PubHubUI.WatermarkFrame then
            PubHubUI.WatermarkFrame.Size = UDim2.fromOffset(320 * WC.Scale, PubHubUI.WatermarkFrame.Size.Y.Offset)
        end
    end })

    return GuiTab
end

-- ═══ WATERMARK ═══
PubHubUI.WatermarkConfig = SavedConfig.Watermark or {
    Enabled = true,
    Position = "TopLeft",
    ShowUsername = true,
    ShowKeyTime = true,
    ShowClock = true,
    ShowFPS = true,
    ShowPing = true,
    ShowServer = true,
    ShowGame = false,
    ShowSessionTime = false,
    ShowExecutor = false,
    ShowVersion = true,
    Transparency = 0,
    Scale = 1,
    CompactMode = false,
}

-- SetKeyData — вызывается из loader после валидации
-- PubHubUI:SetKeyData({ ExpiresAt = 1788919861, Hours = 12 })
PubHubUI._keyData = nil
function PubHubUI:SetKeyData(kd) PubHubUI._keyData = kd end

local _wmGui, _wmFrame, _wmLabels = nil, nil, {}
local _wmStartTime = os.clock()
local _wmFps, _wmLastFpsT, _wmFrames = 0, os.clock(), 0

-- FPS counter
RunService.RenderStepped:Connect(function()
    _wmFrames = _wmFrames + 1
    local now = os.clock()
    if now - _wmLastFpsT >= 1 then
        _wmFps = math.floor(_wmFrames / (now - _wmLastFpsT) + 0.5)
        _wmFrames = 0
        _wmLastFpsT = now
    end
end)

local function getPing()
    local ok, p = pcall(function()
        return math.floor(lp:GetNetworkPing() * 1000)
    end)
    return ok and p or 0
end

local function getExecutor()
    local ok, name = pcall(function()
        return identifyexecutor and identifyexecutor() or "Unknown"
    end)
    return ok and tostring(name) or "Unknown"
end

local function getGameName()
    local ok, name = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name
    end)
    return ok and name or "Game"
end

local function getServerRegion()
    -- Нет прямого API. Эвристика: смотрим на JobId / просто "Global"
    return "Global"
end

local function formatKeyTime()
    if not PubHubUI._keyData then return "No Key" end
    local exp = PubHubUI._keyData.ExpiresAt
    if not exp then return "Lifetime" end
    local remaining = exp - os.time()
    if remaining <= 0 then return "Expired" end
    local d = math.floor(remaining / 86400)
    local h = math.floor((remaining % 86400) / 3600)
    local m = math.floor((remaining % 3600) / 60)
    if d > 0 then return string.format("%dd %dh %dm", d, h, m) end
    if h > 0 then return string.format("%dh %dm", h, m) end
    return string.format("%dm", m)
end

local function keyColor()
    if not PubHubUI._keyData or not PubHubUI._keyData.ExpiresAt then return Theme.TextColor end
    local remaining = PubHubUI._keyData.ExpiresAt - os.time()
    if remaining <= 0 then return Theme.ErrorColor end
    if remaining < 86400 then return Theme.ErrorColor end
    if remaining < 7 * 86400 then return Theme.WarningColor end
    return Theme.SuccessColor
end

local function fpsColor(fps)
    if fps >= 120 then return Theme.SuccessColor end
    if fps >= 60 then return Theme.TextColor end
    return Theme.WarningColor
end

local function pingColor(ping)
    if ping < 50 then return Theme.SuccessColor end
    if ping < 100 then return Theme.TextColor end
    return Theme.WarningColor
end

local function wmPosition(pos)
    local map = {
        TopLeft     = { anchor = Vector2.new(0, 0),   pos = UDim2.new(0, 16, 0, 16) },
        TopCenter   = { anchor = Vector2.new(0.5, 0), pos = UDim2.new(0.5, 0, 0, 16) },
        TopRight    = { anchor = Vector2.new(1, 0),   pos = UDim2.new(1, -16, 0, 16) },
        BottomLeft  = { anchor = Vector2.new(0, 1),   pos = UDim2.new(0, 16, 1, -16) },
        BottomCenter= { anchor = Vector2.new(0.5, 1), pos = UDim2.new(0.5, 0, 1, -16) },
        BottomRight = { anchor = Vector2.new(1, 1),   pos = UDim2.new(1, -16, 1, -16) },
    }
    return map[pos] or map.TopLeft
end

function PubHubUI.RebuildWatermark()
    if _wmFrame then pcall(function() _wmFrame:Destroy() end) end
    if _wmGui then pcall(function() _wmGui:Destroy() end) end
    _wmLabels = {}

    local WC = PubHubUI.WatermarkConfig
    if not WC.Enabled then return end

    _wmGui = new("ScreenGui", {
        Name = "PubHub_WM_" .. HttpService:GenerateGUID(false):sub(1, 6),
        Parent = gethui(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 900,
        IgnoreGuiInset = true,
    })

    local posInfo = wmPosition(WC.Position)
    local baseW = math.floor(320 * WC.Scale)
    local baseH = WC.CompactMode and 32 or 64

    _wmFrame = new("Frame", {
        Parent = _wmGui,
        Size = UDim2.fromOffset(baseW, baseH),
        Position = posInfo.pos,
        AnchorPoint = posInfo.anchor,
        BorderSizePixel = 0,
        BackgroundTransparency = WC.Transparency,
        Active = true,
        ZIndex = 900,
    })
    regColor(_wmFrame, "BackgroundColor3", "SecondaryColor")
    corner(_wmFrame, Theme.CornerRadius)
    stroke(_wmFrame, 1, 0)
    PubHubUI.WatermarkFrame = _wmFrame

    -- Accent bar слева
    local Bar = new("Frame", {
        Parent = _wmFrame,
        Size = UDim2.fromOffset(2, 1),
        BorderSizePixel = 0,
        ZIndex = 901,
    })
    regColor(Bar, "BackgroundColor3", "AccentColor")
    corner(Bar, UDim.new(1, 0))

    local Inner = new("Frame", {
        Parent = _wmFrame,
        Size = UDim2.new(1, -16, 1, 0),
        Position = UDim2.fromOffset(12, 0),
        BackgroundTransparency = 1,
        ZIndex = 901,
    })

    local function mkLbl(yOff, size, font, colorKey)
        local l = label(Inner, {
            Text = "", Size = size, Font = font,
            Size2 = UDim2.new(1, 0, 0, size + 4),
            Position = UDim2.fromOffset(0, yOff),
            ColorKey = colorKey or "SubtextColor",
            ZIndex = 902,
        })
        return l
    end

    -- Row 1: PubHub • Username
    local row1 = mkLbl(6, 13, Theme.FontBold, "TextColor")
    _wmLabels.row1 = row1

    if not WC.CompactMode then
        -- Divider
        local div = new("Frame", {
            Parent = Inner,
            Size = UDim2.new(1, 0, 0, 1),
            Position = UDim2.fromOffset(0, 26),
            BorderSizePixel = 0,
            ZIndex = 902,
        })
        regColor(div, "BackgroundColor3", "StrokeColor")

        -- Row 2: Key + Clock
        _wmLabels.row2 = mkLbl(30, 11, Theme.Font, "SubtextColor")
        -- Row 3: FPS + Ping + Server
        _wmLabels.row3 = mkLbl(44, 11, Theme.Font, "SubtextColor")
    end

    -- Dragging
    local wmDrag, wmDragStart, wmStartPos = false, nil, nil
    _wmFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            wmDrag = true; wmDragStart = input.Position; wmStartPos = _wmFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    wmDrag = false
                    -- Сохраняем custom позицию
                    WC.CustomPos = { X = _wmFrame.Position.X.Offset, Y = _wmFrame.Position.Y.Offset,
                                     XS = _wmFrame.Position.X.Scale, YS = _wmFrame.Position.Y.Scale }
                    SavedConfig.Watermark = WC
                    saveConfig(SavedConfig)
                end
            end)
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if wmDrag and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - wmDragStart
            _wmFrame.Position = UDim2.new(wmStartPos.X.Scale, wmStartPos.X.Offset + delta.X,
                                          wmStartPos.Y.Scale, wmStartPos.Y.Offset + delta.Y)
        end
    end)

    -- Восстановление custom позиции
    if WC.CustomPos then
        _wmFrame.AnchorPoint = Vector2.new(0, 0)
        _wmFrame.Position = UDim2.new(WC.CustomPos.XS, WC.CustomPos.X, WC.CustomPos.YS, WC.CustomPos.Y)
    end

    -- Entrance
    _wmFrame.BackgroundTransparency = 1
    tween(_wmFrame, Theme.TweenMed, { BackgroundTransparency = WC.Transparency })

    PubHubUI.RepositionWatermark = function()
        if not WC.CustomPos and _wmFrame then
            local p = wmPosition(WC.Position)
            _wmFrame.AnchorPoint = p.anchor
            _wmFrame.Position = p.pos
        end
    end
end

-- Watermark update loop (1 секунда)
task.spawn(function()
    while true do
        task.wait(1)
        local WC = PubHubUI.WatermarkConfig
        if not WC.Enabled or not _wmFrame or not _wmFrame.Parent then continue end

        -- Row 1: PubHub • Username
        local parts1 = { "PubHub" }
        if WC.ShowUsername then table.insert(parts1, lp.Name) end
        if WC.ShowVersion then table.insert(parts1, "v2.0") end
        _wmLabels.row1.Text = table.concat(parts1, "  •  ")

        if WC.CompactMode then
            -- Compact: row1 only + key + clock
            if WC.ShowKeyTime then table.insert(parts1, formatKeyTime()) end
            if WC.ShowClock then table.insert(parts1, os.date("%H:%M")) end
            _wmLabels.row1.Text = table.concat(parts1, "  •  ")
        else
            -- Row 2: Key + Clock
            local parts2 = {}
            if WC.ShowKeyTime then
                local kt = formatKeyTime()
                _wmLabels.row2.TextColor3 = keyColor()
                table.insert(parts2, "Key: " .. kt)
            end
            if WC.ShowClock then table.insert(parts2, os.date("%H:%M")) end
            if WC.ShowSessionTime then
                local st = math.floor(os.clock() - _wmStartTime)
                table.insert(parts2, string.format("%dm %ds", st // 60, st % 60))
            end
            if _wmLabels.row2 then _wmLabels.row2.Text = table.concat(parts2, "  •  ") end

            -- Row 3: FPS + Ping + Server
            local parts3 = {}
            if WC.ShowFPS then
                table.insert(parts3, tostring(_wmFps) .. " FPS")
                if _wmLabels.row3 then _wmLabels.row3.TextColor3 = fpsColor(_wmFps) end
            end
            if WC.ShowPing then table.insert(parts3, getPing() .. "ms") end
            if WC.ShowServer then table.insert(parts3, getServerRegion()) end
            if WC.ShowGame then table.insert(parts3, getGameName()) end
            if WC.ShowExecutor then table.insert(parts3, getExecutor()) end
            if _wmLabels.row3 then _wmLabels.row3.Text = table.concat(parts3, "  •  ") end
        end
    end
end)

-- Auto-spawn watermark
task.delay(0.5, function()
    PubHubUI.RebuildWatermark()
end)

return PubHubUI
