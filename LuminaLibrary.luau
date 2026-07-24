--[[
    Lumina Library - Complete Framework with Enhanced Tab Support
    Version: 1.0.0
    A modern, production-ready Roblox UI framework with full icon support
    
    Usage:
    local LuminaLib = loadstring(game:HttpGet("https://github.com/ugmoddev/LuminaLibrary/raw/refs/heads/main/LuminaLibrary.luau"))()
    local Window = LuminaLib:MakeWindow({...})
    local Tabs = {
        Info = Window:MakeTab({ Title = "Info And Status", Icon = "info" })
    }
]]

local LuminaLib = {}

-- ============================================================================
-- ICON SYSTEM
-- ============================================================================

local Icons = {
    -- Core Icons
    ["info"] = "rbxassetid://10723415903",
    ["home"] = "rbxassetid://10723407389",
    ["settings"] = "rbxassetid://10734950309",
    ["mountain"] = "rbxassetid://10734897956",
    ["flame"] = "rbxassetid://10723376114",
    ["tent"] = "rbxassetid://10734981750",
    ["apple"] = "rbxassetid://10709761889",
    ["shop"] = "rbxassetid://10734952479",
    
    -- Navigation
    ["arrowdown"] = "rbxassetid://10709767827",
    ["arrowleft"] = "rbxassetid://10709768114",
    ["arrowright"] = "rbxassetid://10709768347",
    ["arrowup"] = "rbxassetid://10709768939",
    ["chevronleft"] = "rbxassetid://10709791281",
    ["chevronright"] = "rbxassetid://10709791437",
    ["chevronup"] = "rbxassetid://10709791523",
    ["chevrondown"] = "rbxassetid://10709790948",
    
    -- Actions
    ["check"] = "rbxassetid://10709790644",
    ["checkcircle"] = "rbxassetid://10709790387",
    ["x"] = "rbxassetid://10747384394",
    ["xcircle"] = "rbxassetid://10747383819",
    ["plus"] = "rbxassetid://10734924532",
    ["minus"] = "rbxassetid://10734896206",
    ["edit"] = "rbxassetid://10734883598",
    ["delete"] = "rbxassetid://10709819059",
    ["copy"] = "rbxassetid://10709812159",
    ["save"] = "rbxassetid://10734941499",
    
    -- Communication
    ["mail"] = "rbxassetid://10734885430",
    ["mailopen"] = "rbxassetid://10723435342",
    ["send"] = "rbxassetid://10734943902",
    ["share"] = "rbxassetid://10734950813",
    ["link"] = "rbxassetid://10723426722",
    
    -- Media
    ["music"] = "rbxassetid://10734905958",
    ["video"] = "rbxassetid://10747374938",
    ["camera"] = "rbxassetid://10709789686",
    ["image"] = "rbxassetid://10723415040",
    ["film"] = "rbxassetid://10723374981",
    
    -- Files
    ["file"] = "rbxassetid://10723374641",
    ["folder"] = "rbxassetid://10723387563",
    ["folderopen"] = "rbxassetid://10723386277",
    ["download"] = "rbxassetid://10723344270",
    ["upload"] = "rbxassetid://10747366434",
    
    -- Social
    ["user"] = "rbxassetid://10747373176",
    ["users"] = "rbxassetid://10747373426",
    ["userplus"] = "rbxassetid://10747372702",
    ["userminus"] = "rbxassetid://10747372346",
    ["heart"] = "rbxassetid://10723406885",
    ["star"] = "rbxassetid://10734966248",
    
    -- Status
    ["alerttriangle"] = "rbxassetid://10709753149",
    ["alertcircle"] = "rbxassetid://10709752996",
    ["alertoctagon"] = "rbxassetid://10709753064",
    ["bell"] = "rbxassetid://10709775704",
    ["belloff"] = "rbxassetid://10709775320",
    ["clock"] = "rbxassetid://10709805144",
    ["calendar"] = "rbxassetid://10709789505",
    
    -- Devices
    ["monitor"] = "rbxassetid://10734896881",
    ["laptop"] = "rbxassetid://10723423881",
    ["smartphone"] = "rbxassetid://10734963940",
    ["tablet"] = "rbxassetid://10734976394",
    ["watch"] = "rbxassetid://10747376722",
    
    -- Misc
    ["search"] = "rbxassetid://10734943674",
    ["lock"] = "rbxassetid://10723434711",
    ["unlock"] = "rbxassetid://10747366027",
    ["key"] = "rbxassetid://10723416652",
    ["shield"] = "rbxassetid://10734951847",
    ["cog"] = "rbxassetid://10709810948",
    ["settings2"] = "rbxassetid://10734950020",
    ["globe"] = "rbxassetid://10723404337",
    ["map"] = "rbxassetid://10734886202",
    ["mappin"] = "rbxassetid://10734886004",
    ["compass"] = "rbxassetid://10709811445",
    ["rocket"] = "rbxassetid://10734934585",
    ["trophy"] = "rbxassetid://10747363809",
    ["award"] = "rbxassetid://10709769406",
    ["medal"] = "rbxassetid://10734887072",
    ["crown"] = "rbxassetid://10709818626",
    ["gem"] = "rbxassetid://10723396000",
    ["diamond"] = "rbxassetid://10709819149",
    ["coin"] = "rbxassetid://10709811110",
    ["wallet"] = "rbxassetid://10747376205",
    ["shoppingbag"] = "rbxassetid://10734952273",
    ["shoppingcart"] = "rbxassetid://10734952479",
    ["gift"] = "rbxassetid://10723396402",
    ["package"] = "rbxassetid://10734909540",
    ["box"] = "rbxassetid://10709782497",
    ["archive"] = "rbxassetid://10709762233",
    ["book"] = "rbxassetid://10709781824",
    ["bookmark"] = "rbxassetid://10709782154",
    ["library"] = "rbxassetid://10723425615",
    
    -- Weather
    ["sun"] = "rbxassetid://10734974297",
    ["moon"] = "rbxassetid://10734897102",
    ["cloud"] = "rbxassetid://10709806740",
    ["cloudrain"] = "rbxassetid://10709806277",
    ["cloudsnow"] = "rbxassetid://10709806374",
    ["wind"] = "rbxassetid://10747382750",
    ["snowflake"] = "rbxassetid://10734964600",
    ["umbrella"] = "rbxassetid://10747364971",
    
    -- Animals
    ["fish"] = "rbxassetid://10723345749",
    ["bug"] = "rbxassetid://10709782845",
    ["ghost"] = "rbxassetid://10723396107",
    ["skull"] = "rbxassetid://10734962068",
    ["paw"] = "rbxassetid://10709769732",
    
    -- Food
    ["coffee"] = "rbxassetid://10709810814",
    ["cake"] = "rbxassetid://10709783217",
    ["pizza"] = "rbxassetid://10734922774",
    ["beer"] = "rbxassetid://10709775167",
    ["icecream"] = "rbxassetid://10723414308",
    ["egg"] = "rbxassetid://10723345518",
    
    -- Tools
    ["wrench"] = "rbxassetid://10747383470",
    ["hammer"] = "rbxassetid://10723405360",
    ["sword"] = "rbxassetid://10734975486",
    ["shield"] = "rbxassetid://10734951847",
    ["scissors"] = "rbxassetid://10734942778",
    ["pencil"] = "rbxassetid://10734919691",
    ["eraser"] = "rbxassetid://10723346158",
    ["brush"] = "rbxassetid://10709782758",
    ["palette"] = "rbxassetid://10734910430",
    
    -- Building
    ["building"] = "rbxassetid://10709783051",
    ["home"] = "rbxassetid://10723407389",
    ["hospital"] = "rbxassetid://10709783051",
    ["church"] = "rbxassetid://10734981750",
    ["castle"] = "rbxassetid://10709783051",
}

-- ============================================================================
-- UTILITY MODULES
-- ============================================================================

-- Janitor Pattern
local Janitor = {}
Janitor.__index = Janitor

function Janitor.new()
    local self = setmetatable({}, Janitor)
    self._objects = {}
    self._connections = {}
    self._callbacks = {}
    return self
end

function Janitor:Add(obj)
    table.insert(self._objects, obj)
    return obj
end

function Janitor:AddConnection(connection)
    table.insert(self._connections, connection)
    return connection
end

function Janitor:AddCallback(callback)
    table.insert(self._callbacks, callback)
    return callback
end

function Janitor:Cleanup()
    for _, obj in ipairs(self._objects) do
        if obj.Destroy then
            pcall(function() obj:Destroy() end)
        end
    end
    for _, conn in ipairs(self._connections) do
        pcall(function() conn:Disconnect() end)
    end
    for _, cb in ipairs(self._callbacks) do
        pcall(cb)
    end
    self._objects = {}
    self._connections = {}
    self._callbacks = {}
end

-- Signal System
local Signal = {}
Signal.__index = Signal

function Signal.new()
    local self = setmetatable({}, Signal)
    self._listeners = {}
    self._onceListeners = {}
    return self
end

function Signal:Connect(callback)
    table.insert(self._listeners, callback)
    local connection = {
        Disconnect = function()
            for i, cb in ipairs(self._listeners) do
                if cb == callback then
                    table.remove(self._listeners, i)
                    break
                end
            end
        end
    }
    return connection
end

function Signal:ConnectOnce(callback)
    table.insert(self._onceListeners, callback)
    local connection = {
        Disconnect = function()
            for i, cb in ipairs(self._onceListeners) do
                if cb == callback then
                    table.remove(self._onceListeners, i)
                    break
                end
            end
        end
    }
    return connection
end

function Signal:Fire(...)
    local listeners = table.clone(self._listeners)
    for _, cb in ipairs(listeners) do
        task.spawn(cb, ...)
    end
    
    local onceListeners = table.clone(self._onceListeners)
    self._onceListeners = {}
    for _, cb in ipairs(onceListeners) do
        task.spawn(cb, ...)
    end
end

function Signal:Destroy()
    self._listeners = {}
    self._onceListeners = {}
end

-- Tween System
local Tween = {}

function Tween:Create(object, properties, duration, style, direction)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    return game:GetService("TweenService"):Create(object, tweenInfo, properties)
end

function Tween:Play(tween)
    tween:Play()
    return tween
end

-- ============================================================================
-- COLOR THEMES
-- ============================================================================

local Themes = {
    Dark = {
        Background = Color3.fromRGB(18, 18, 22),
        Surface = Color3.fromRGB(30, 30, 35),
        Surface2 = Color3.fromRGB(40, 40, 45),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(160, 160, 170),
        Border = Color3.fromRGB(50, 50, 55),
        Hover = Color3.fromRGB(45, 45, 50),
        Press = Color3.fromRGB(55, 55, 60),
        Accent = Color3.fromRGB(98, 0, 238),
    },
    Light = {
        Background = Color3.fromRGB(240, 240, 245),
        Surface = Color3.fromRGB(255, 255, 255),
        Surface2 = Color3.fromRGB(245, 245, 250),
        Text = Color3.fromRGB(0, 0, 0),
        TextSecondary = Color3.fromRGB(80, 80, 85),
        Border = Color3.fromRGB(220, 220, 225),
        Hover = Color3.fromRGB(235, 235, 240),
        Press = Color3.fromRGB(225, 225, 230),
        Accent = Color3.fromRGB(98, 0, 238),
    },
    Glass = {
        Background = Color3.fromRGB(20, 20, 30),
        Surface = Color3.fromRGB(40, 40, 55),
        Surface2 = Color3.fromRGB(50, 50, 65),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(190, 190, 200),
        Border = Color3.fromRGB(60, 60, 75),
        Hover = Color3.fromRGB(55, 55, 70),
        Press = Color3.fromRGB(65, 65, 80),
        Accent = Color3.fromRGB(98, 0, 238),
    },
}

-- ============================================================================
-- ENHANCED TAB CLASS
-- ============================================================================

local Tab = {}
Tab.__index = Tab

function Tab.new(options, parent)
    local self = setmetatable({}, Tab)
    self.Title = options.Title or "Tab"
    self.Icon = options.Icon or ""
    self.Parent = parent
    self.Button = nil
    self.Content = nil
    self.Visible = true
    self.IsSelected = false
    self.Badge = options.Badge or nil
    self.NotificationDot = options.NotificationDot or false
    return self
end

function Tab:CreateUI(tabContainer, contentContainer)
    -- Create tab button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 40)
    button.Position = UDim2.new(0, 5, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.BackgroundTransparency = 0.5
    button.Text = ""
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = tabContainer
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Icon handling
    local iconLabel = nil
    if self.Icon and self.Icon ~= "" then
        local iconPath = self.Icon
        -- Check if it's a string icon name
        if not string.match(iconPath, "^rbxassetid://") and not string.match(iconPath, "^rbxasset://") then
            iconPath = Icons[self.Icon] or iconPath
        end
        
        iconLabel = Instance.new("ImageLabel")
        iconLabel.Size = UDim2.new(0, 20, 0, 20)
        iconLabel.Position = UDim2.new(0, 10, 0.5, -10)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Image = iconPath
        iconLabel.Parent = button
    end
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.Position = UDim2.new(0, 40, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Title
    label.TextSize = 13
    label.TextColor3 = Color3.fromRGB(160, 160, 170)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Badge
    if self.Badge then
        local badge = Instance.new("Frame")
        badge.Size = UDim2.new(0, 20, 0, 20)
        badge.Position = UDim2.new(1, -30, 0.5, -10)
        badge.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        badge.BorderSizePixel = 0
        badge.Parent = button
        
        local badgeCorner = Instance.new("UICorner")
        badgeCorner.CornerRadius = UDim.new(1, 0)
        badgeCorner.Parent = badge
        
        local badgeText = Instance.new("TextLabel")
        badgeText.Size = UDim2.new(1, 0, 1, 0)
        badgeText.BackgroundTransparency = 1
        badgeText.Text = tostring(self.Badge)
        badgeText.TextSize = 10
        badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
        badgeText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        badgeText.Parent = badge
    end
    
    -- Notification dot
    if self.NotificationDot then
        local dot = Instance.new("Frame")
        dot.Size = UDim2.new(0, 8, 0, 8)
        dot.Position = UDim2.new(1, -15, 0, 5)
        dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        dot.BorderSizePixel = 0
        dot.Parent = button
        
        local dotCorner = Instance.new("UICorner")
        dotCorner.CornerRadius = UDim.new(1, 0)
        dotCorner.Parent = dot
    end
    
    -- Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Parent = contentContainer
    content.Visible = false
    
    -- Store references
    self.Button = button
    self.Label = label
    self.IconLabel = iconLabel
    self.Content = content
    self.Corner = corner
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if not self.IsSelected then
            button.BackgroundTransparency = 0.3
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not self.IsSelected then
            button.BackgroundTransparency = 0.5
        end
    end)
    
    -- Click handler
    button.MouseButton1Click:Connect(function()
        if self.Parent then
            self.Parent:SelectTab(self)
        end
    end)
    
    return button
end

function Tab:Select()
    self.IsSelected = true
    if self.Button then
        self.Button.BackgroundTransparency = 0
        self.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
        -- Accent border
        local border = Instance.new("Frame")
        border.Size = UDim2.new(1, 0, 0, 2)
        border.Position = UDim2.new(0, 0, 1, -2)
        border.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        border.BorderSizePixel = 0
        border.Name = "AccentBorder"
        border.Parent = self.Button
    end
    if self.Content then
        self.Content.Visible = true
    end
end

function Tab:Deselect()
    self.IsSelected = false
    if self.Button then
        self.Button.BackgroundTransparency = 0.5
        self.Button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(160, 160, 170)
        end
        -- Remove accent border
        local border = self.Button:FindFirstChild("AccentBorder")
        if border then
            border:Destroy()
        end
    end
    if self.Content then
        self.Content.Visible = false
    end
end

function Tab:SetTitle(title)
    self.Title = title
    if self.Label then
        self.Label.Text = title
    end
end

function Tab:SetIcon(icon)
    self.Icon = icon
    if self.IconLabel then
        local iconPath = icon
        if not string.match(iconPath, "^rbxassetid://") and not string.match(iconPath, "^rbxasset://") then
            iconPath = Icons[icon] or iconPath
        end
        self.IconLabel.Image = iconPath
    end
end

function Tab:SetBadge(text)
    self.Badge = text
    -- Update badge if exists
end

function Tab:Show()
    self.Visible = true
    if self.Button then
        self.Button.Visible = true
    end
end

function Tab:Hide()
    self.Visible = false
    if self.Button then
        self.Button.Visible = false
    end
    if self.Content then
        self.Content.Visible = false
    end
end

-- ============================================================================
-- WINDOW CLASS
-- ============================================================================

local Window = {}
Window.__index = Window

function Window.new(options)
    local self = setmetatable({}, Window)
    
    -- Properties
    self.Title = options.Title or "Lumina"
    self.SubTitle = options.SubTitle or ""
    self.SaveFolder = options.SaveFolder or "LuminaConfig.json"
    self.Size = options.Size or UDim2.new(0, 778, 0, 500)
    self.Position = options.Position or UDim2.new(0.1572, 0, 0.18194, 0)
    self.AccentColor = Color3.fromRGB(98, 0, 238)
    
    -- State
    self.IsVisible = true
    self.Tabs = {}
    self.ActiveTab = nil
    self._janitor = Janitor.new()
    
    -- Create GUI
    self:_createGUI()
    self:_setupDrag()
    
    return self
end

function Window:_createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "Lumina_" .. self.Title
    
    -- Main frame
    local frame = Instance.new("Frame")
    frame.Size = self.Size
    frame.Position = self.Position
    frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    -- Shadow
    local shadow = Instance.new("UIStroke")
    shadow.Thickness = 1
    shadow.Color = Color3.fromRGB(255, 255, 255)
    shadow.Transparency = 0.1
    shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadow.Parent = frame
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 50)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    titleBar.BackgroundTransparency = 0.05
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 12)
    titleCorner.Parent = titleBar
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.02, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextSize = 20
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    titleLabel.Parent = titleBar
    
    -- Subtitle
    local subtitleLabel = Instance.new("TextLabel")
    subtitleLabel.Size = UDim2.new(0.3, 0, 0.4, 0)
    subtitleLabel.Position = UDim2.new(0.02, 0, 0.6, 0)
    subtitleLabel.BackgroundTransparency = 1
    subtitleLabel.Text = self.SubTitle
    subtitleLabel.TextSize = 12
    subtitleLabel.TextColor3 = Color3.fromRGB(140, 140, 150)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    subtitleLabel.Parent = titleBar
    
    -- Window controls
    local controls = Instance.new("Frame")
    controls.Size = UDim2.new(0, 90, 0, 30)
    controls.Position = UDim2.new(1, -100, 0.5, -15)
    controls.BackgroundTransparency = 1
    controls.BorderSizePixel = 0
    controls.Parent = titleBar
    
    -- Minimize button
    local minimizeBtn = Instance.new("ImageButton")
    minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    minimizeBtn.Position = UDim2.new(0, 0, 0.5, -12)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Image = "rbxassetid://10747384394"
    minimizeBtn.ImageColor3 = Color3.fromRGB(200, 200, 210)
    minimizeBtn.Parent = controls
    
    -- Close button
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(0, 33, 0.5, -12)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://10747384394"
    closeBtn.ImageColor3 = Color3.fromRGB(255, 60, 60)
    closeBtn.Parent = controls
    
    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 160, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundColor3 = Color3.fromRGB(22, 22, 26)
    tabContainer.BackgroundTransparency = 0.03
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = frame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 12)
    tabCorner.Parent = tabContainer
    
    -- Tab list
    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 4)
    tabList.Parent = tabContainer
    
    -- Main content
    local mainContent = Instance.new("Frame")
    mainContent.Size = UDim2.new(1, -160, 1, -50)
    mainContent.Position = UDim2.new(0, 160, 0, 50)
    mainContent.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
    mainContent.BackgroundTransparency = 0.05
    mainContent.BorderSizePixel = 0
    mainContent.Parent = frame
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -20, 1, -20)
    contentContainer.Position = UDim2.new(0, 10, 0, 10)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainContent
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 6)
    contentLayout.Parent = contentContainer
    
    -- Store references
    self._gui = {
        ScreenGui = screenGui,
        Frame = frame,
        Corner = corner,
        TitleBar = titleBar,
        TitleLabel = titleLabel,
        SubtitleLabel = subtitleLabel,
        TabContainer = tabContainer,
        TabList = tabList,
        MainContent = mainContent,
        ContentContainer = contentContainer,
        ContentLayout = contentLayout,
        MinimizeBtn = minimizeBtn,
        CloseBtn = closeBtn,
        Controls = controls,
        Shadow = shadow,
    }
    
    -- Close button
    closeBtn.MouseButton1Click:Connect(function()
        self:Destroy()
    end)
    
    -- Minimize button
    minimizeBtn.MouseButton1Click:Connect(function()
        self:Hide()
    end)
    
    self._janitor:Add(screenGui)
end

function Window:_setupDrag()
    local frame = self._gui.Frame
    local dragging = false
    local dragStart = Vector2.new()
    local posStart = UDim2.new()
    
    self._gui.TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            posStart = frame.Position
        end
    end)
    
    self._gui.TitleBar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    self._gui.TitleBar.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                posStart.X.Scale,
                posStart.X.Offset + delta.X,
                posStart.Y.Scale,
                posStart.Y.Offset + delta.Y
            )
        end
    end)
end

function Window:MakeTab(options)
    -- Support both old format ({Title, Icon}) and new format ({Title = "...", Icon = "..."})
    local tabOptions = {}
    if options[1] then
        -- Old format
        tabOptions.Title = options[1]
        tabOptions.Icon = options[2] or ""
    else
        -- New format
        tabOptions = options
    end
    
    local tab = Tab.new(tabOptions, self)
    table.insert(self.Tabs, tab)
    
    -- Create UI
    tab:CreateUI(self._gui.TabContainer, self._gui.ContentContainer)
    
    -- Select first tab
    if #self.Tabs == 1 then
        self:SelectTab(tab)
    end
    
    return tab
end

function Window:SelectTab(tab)
    -- Deselect all tabs
    for _, t in ipairs(self.Tabs) do
        t:Deselect()
    end
    
    -- Select the tab
    tab:Select()
    self.ActiveTab = tab
    
    return tab
end

function Window:AddMinimizeButton(options)
    -- Already implemented
    return self._gui.MinimizeBtn
end

function Window:Show()
    self.IsVisible = true
    self._gui.Frame.Visible = true
end

function Window:Hide()
    self.IsVisible = false
    self._gui.Frame.Visible = false
end

function Window:Toggle()
    if self.IsVisible then
        self:Hide()
    else
        self:Show()
    end
end

function Window:Destroy()
    self._janitor:Cleanup()
    if self._gui and self._gui.ScreenGui then
        self._gui.ScreenGui:Destroy()
    end
end

function Window:SetTitle(title)
    self.Title = title
    if self._gui and self._gui.TitleLabel then
        self._gui.TitleLabel.Text = title
    end
end

function Window:SetSubtitle(subtitle)
    self.SubTitle = subtitle
    if self._gui and self._gui.SubtitleLabel then
        self._gui.SubtitleLabel.Text = subtitle
    end
end

function Window:Center()
    local screenSize = game:GetService("GuiService"):GetScreenSize()
    local frameSize = self._gui.Frame.AbsoluteSize
    self._gui.Frame.Position = UDim2.new(
        0.5, -frameSize.X / 2,
        0.5, -frameSize.Y / 2
    )
end

-- ============================================================================
-- COMPONENTS
-- ============================================================================

-- Button Component
local Button = {}
Button.__index = Button

function Button.new(options)
    local self = setmetatable({}, Button)
    self.Name = options.Name or "Button"
    self.Description = options.Description or ""
    self.Icon = options.Icon or ""
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.Button = nil
    return self
end

function Button:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 46)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -4)
    button.Position = UDim2.new(0, 0, 0, 2)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Icon
    if self.Icon and self.Icon ~= "" then
        local iconPath = self.Icon
        if not string.match(iconPath, "^rbxassetid://") and not string.match(iconPath, "^rbxasset://") then
            iconPath = Icons[self.Icon] or iconPath
        end
        
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = iconPath
        icon.Parent = button
    end
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 1, 0)
        desc.Position = UDim2.new(0.45, 0, 0, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Hover
    button.MouseEnter:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    button.MouseLeave:Connect(function()
        button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end)
    
    button.MouseButton1Click:Connect(function()
        self.Callback()
    end)
    
    self.Container = container
    self.Button = button
    
    return container
end

function Button:SetName(name)
    self.Name = name
    if self.Button then
        self.Button.Text = name
    end
end

-- Toggle Component
local Toggle = {}
Toggle.__index = Toggle

function Toggle.new(options)
    local self = setmetatable({}, Toggle)
    self.Name = options.Name or "Toggle"
    self.Description = options.Description or ""
    self.Default = options.Default or false
    self.Value = self.Default
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.Toggle = nil
    self.Indicator = nil
    self.Label = nil
    return self
end

function Toggle:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 42)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -2)
    button.Position = UDim2.new(0, 0, 0, 1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 1, 0)
        desc.Position = UDim2.new(0.45, 0, 0, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Toggle
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 44, 0, 24)
    toggleBg.Position = UDim2.new(1, -54, 0.5, -12)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = button
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 18, 0, 18)
    toggleDot.Position = UDim2.new(0, 3, 0.5, -9)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBg
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = toggleDot
    
    self.Container = container
    self.Toggle = toggleBg
    self.Indicator = toggleDot
    self.Label = label
    
    self:_updateToggle()
    
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Toggle:_updateToggle()
    if self.Value then
        self.Toggle.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        self.Indicator.Position = UDim2.new(1, -24, 0.5, -9)
    else
        self.Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        self.Indicator.Position = UDim2.new(0, 3, 0.5, -9)
    end
end

function Toggle:Toggle()
    self.Value = not self.Value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Set(value)
    self.Value = value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Get()
    return self.Value
end

-- Slider Component
local Slider = {}
Slider.__index = Slider

function Slider.new(options)
    local self = setmetatable({}, Slider)
    self.Name = options.Name or "Slider"
    self.Description = options.Description or ""
    self.Min = options.Min or 0
    self.Max = options.Max or 100
    self.Default = options.Default or 50
    self.Value = self.Default
    self.Integer = options.Integer or false
    self.Suffix = options.Suffix or ""
    self.Prefix = options.Prefix or ""
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.Fill = nil
    self.ValueLabel = nil
    return self
end

function Slider:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 52)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, -2)
    button.Position = UDim2.new(0, 0, 0, 1)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0.5, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.5, 0, 0.5, 0)
        desc.Position = UDim2.new(0.05, 0, 0.5, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 12
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Value
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 60, 1, 0)
    valueLabel.Position = UDim2.new(1, -70, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(self.Value)
    valueLabel.TextSize = 14
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    valueLabel.Parent = button
    
    -- Bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.35, 0, 0, 4)
    bar.Position = UDim2.new(0.5, -20, 0.8, 0)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    bar.BorderSizePixel = 0
    bar.Parent = button
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar
    
    -- Fill
    local fill = Instance.new("Frame")
    local percentage = (self.Value - self.Min) / (self.Max - self.Min)
    fill.Size = UDim2.new(percentage, 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
    fill.BorderSizePixel = 0
    fill.Parent = bar
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    self.Container = container
    self.Fill = fill
    self.ValueLabel = valueLabel
    
    -- Drag
    local dragging = false
    
    button.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    button.MouseButton1Up:Connect(function()
        dragging = false
    end)
    
    button.MouseLeave:Connect(function()
        dragging = false
    end)
    
    button.MouseMoved:Connect(function()
        if not dragging then return end
        local mouse = game:GetService("UserInputService"):GetMouseLocation()
        local absPos = button.AbsolutePosition
        local absSize = button.AbsoluteSize
        local relativeX = math.clamp((mouse.X - absPos.X) / absSize.X, 0, 1)
        
        local value = self.Min + (self.Max - self.Min) * relativeX
        if self.Integer then
            value = math.round(value)
        end
        value = math.clamp(value, self.Min, self.Max)
        
        self.Value = value
        self:_updateSlider()
        self.Callback(self.Value)
    end)
    
    return container
end

function Slider:_updateSlider()
    local percentage = (self.Value - self.Min) / (self.Max - self.Min)
    self.Fill.Size = UDim2.new(percentage, 0, 1, 0)
    self.ValueLabel.Text = self.Prefix .. tostring(self.Value) .. self.Suffix
end

function Slider:Set(value)
    value = math.clamp(value, self.Min, self.Max)
    if self.Integer then
        value = math.round(value)
    end
    self.Value = value
    self:_updateSlider()
    self.Callback(self.Value)
end

function Slider:Get()
    return self.Value
end

-- Dropdown Component
local Dropdown = {}
Dropdown.__index = Dropdown

function Dropdown.new(options)
    local self = setmetatable({}, Dropdown)
    self.Name = options.Name or "Dropdown"
    self.Description = options.Description or ""
    self.Options = options.Options or {}
    self.Default = options.Default or ""
    self.Value = self.Default
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.OptionsContainer = nil
    self.IsOpen = false
    self.ValueLabel = nil
    return self
end

function Dropdown:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 48)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 32)
    button.Position = UDim2.new(0, 0, 0, 2)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 1, 0)
    label.Position = UDim2.new(0.05, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Name
    label.TextSize = 14
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = button
    
    -- Value
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.45, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = self.Value or "Select..."
    valueLabel.TextSize = 13
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Left
    valueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    valueLabel.Parent = button
    
    -- Arrow
    local arrow = Instance.new("ImageLabel")
    arrow.Size = UDim2.new(0, 16, 0, 16)
    arrow.Position = UDim2.new(1, -24, 0.5, -8)
    arrow.BackgroundTransparency = 1
    arrow.Image = "rbxassetid://10709790948"
    arrow.ImageColor3 = Color3.fromRGB(150, 150, 160)
    arrow.Parent = button
    
    -- Options
    local optionsContainer = Instance.new("Frame")
    optionsContainer.Size = UDim2.new(1, 0, 0, 0)
    optionsContainer.Position = UDim2.new(0, 0, 0, 36)
    optionsContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    optionsContainer.BorderSizePixel = 0
    optionsContainer.ClipsDescendants = true
    optionsContainer.Visible = false
    optionsContainer.Parent = container
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 8)
    optionsCorner.Parent = optionsContainer
    
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = optionsContainer
    
    for _, option in ipairs(self.Options) do
        self:_createOption(optionsContainer, option)
    end
    
    self.Container = container
    self.OptionsContainer = optionsContainer
    self.ValueLabel = valueLabel
    self.Arrow = arrow
    
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Dropdown:_createOption(parent, optionText)
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 28)
    option.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    option.Text = optionText
    option.TextSize = 13
    option.TextColor3 = Color3.fromRGB(200, 200, 210)
    option.TextXAlignment = Enum.TextXAlignment.Left
    option.BorderSizePixel = 0
    option.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    option.Parent = parent
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = option
    
    option.MouseEnter:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    option.MouseLeave:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end)
    
    option.MouseButton1Click:Connect(function()
        self:Select(optionText)
    end)
    
    return option
end

function Dropdown:Toggle()
    self.IsOpen = not self.IsOpen
    self.OptionsContainer.Visible = self.IsOpen
    
    if self.IsOpen then
        self.Arrow.Rotation = 180
        self.OptionsContainer.Size = UDim2.new(1, 0, 0, math.min(#self.Options * 30, 150))
    else
        self.Arrow.Rotation = 0
        self.OptionsContainer.Size = UDim2.new(1, 0, 0, 0)
        task.wait(0.2)
        self.OptionsContainer.Visible = false
    end
end

function Dropdown:Select(option)
    self.Value = option
    self.ValueLabel.Text = option
    self.Callback(option)
    self:Toggle()
end

function Dropdown:Set(value)
    self.Value = value
    self.ValueLabel.Text = value
    self.Callback(value)
end

function Dropdown:Get()
    return self.Value
end

-- Textbox Component
local Textbox = {}
Textbox.__index = Textbox

function Textbox.new(options)
    local self = setmetatable({}, Textbox)
    self.Name = options.Name or "Textbox"
    self.Description = options.Description or ""
    self.Placeholder = options.Placeholder or "Enter text..."
    self.Default = options.Default or ""
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.TextBox = nil
    return self
end

function Textbox:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 48)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    if self.Name and self.Name ~= "" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.4, 0, 0.4, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = self.Name
        label.TextSize = 13
        label.TextColor3 = Color3.fromRGB(200, 200, 210)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        label.Parent = container
    end
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 32)
    textBox.Position = UDim2.new(0, 0, 0, 14)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    textBox.Text = self.Default
    textBox.TextSize = 14
    textBox.TextColor3 = Color3.fromRGB(200, 200, 210)
    textBox.TextXAlignment = Enum.TextXAlignment.Left
    textBox.PlaceholderText = self.Placeholder
    textBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    textBox.BorderSizePixel = 0
    textBox.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    textBox.ClearTextOnFocus = true
    textBox.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = textBox
    
    self.Container = container
    self.TextBox = textBox
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        self.Callback(textBox.Text)
    end)
    
    return container
end

function Textbox:Set(text)
    if self.TextBox then
        self.TextBox.Text = text
    end
    self.Callback(text)
end

function Textbox:Get()
    return self.TextBox and self.TextBox.Text or ""
end

-- Label Component
local Label = {}
Label.__index = Label

function Label.new(options)
    local self = setmetatable({}, Label)
    self.Text = options.Text or ""
    self.Size = options.Size or 14
    self.Color = options.Color or Color3.fromRGB(255, 255, 255)
    self.Container = nil
    self.Label = nil
    return self
end

function Label:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 1, 0)
    label.Position = UDim2.new(0, 5, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = self.Text
    label.TextSize = self.Size
    label.TextColor3 = self.Color
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    label.Parent = container
    
    self.Container = container
    self.Label = label
    
    return container
end

function Label:SetText(text)
    self.Text = text
    if self.Label then
        self.Label.Text = text
    end
end

-- Separator Component
local Separator = {}
Separator.__index = Separator

function Separator.new(options)
    local self = setmetatable({}, Separator)
    self.Text = options.Text or ""
    self.Container = nil
    return self
end

function Separator:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 32)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -20, 0, 1)
    line.Position = UDim2.new(0, 10, 0.5, 0)
    line.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    line.BorderSizePixel = 0
    line.Parent = container
    
    if self.Text and self.Text ~= "" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 100, 0, 20)
        label.Position = UDim2.new(0.5, -50, 0.5, -10)
        label.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
        label.Text = self.Text
        label.TextSize = 12
        label.TextColor3 = Color3.fromRGB(120, 120, 130)
        label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        label.Parent = container
    end
    
    self.Container = container
    return container
end

-- ============================================================================
-- WINDOW COMPONENT METHODS
-- ============================================================================

function Window:AddButton(options)
    local button = Button.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    button:CreateUI(parent)
    return button
end

function Window:AddToggle(options)
    local toggle = Toggle.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    toggle:CreateUI(parent)
    return toggle
end

function Window:AddSlider(options)
    local slider = Slider.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    slider:CreateUI(parent)
    return slider
end

function Window:AddDropdown(options)
    local dropdown = Dropdown.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    dropdown:CreateUI(parent)
    return dropdown
end

function Window:AddTextbox(options)
    local textbox = Textbox.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    textbox:CreateUI(parent)
    return textbox
end

function Window:AddLabel(options)
    local label = Label.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    label:CreateUI(parent)
    return label
end

function Window:AddSeparator(options)
    local separator = Separator.new(options)
    local parent = self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer
    separator:CreateUI(parent)
    return separator
end

-- ============================================================================
-- LUMINA API
-- ============================================================================

function LuminaLib:MakeWindow(options)
    return Window.new(options)
end

function LuminaLib:Notify(options)
    print("[Lumina Notification]", options.Title, options.Content)
    return { Close = function() end }
end

function LuminaLib:MakeNotification(options)
    return self:Notify({
        Title = options.Title,
        Content = options.Content,
        Duration = options.Time,
        Type = options.Type
    })
end

function LuminaLib:Toast(options)
    print("[Lumina Toast]", options.Content)
    return {}
end

function LuminaLib:Dialog(options)
    print("[Lumina Dialog]", options.Title, options.Content)
    if options.Callback and options.Buttons then
        options.Callback(options.Buttons[1] or "OK")
    end
end

function LuminaLib:GetIcon(name)
    return Icons[name]
end

function LuminaLib:GetIcons()
    return Icons
end

-- Backward compatibility
LuminaLib.MakeWindow = LuminaLib.MakeWindow
LuminaLib.MakeNotification = LuminaLib.MakeNotification
LuminaLib.Notify = LuminaLib.Notify

return LuminaLib
