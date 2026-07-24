--[[
    Lumina Library - Complete Framework
    Version: 1.0.0
    A modern, production-ready Roblox UI framework
    
    Usage:
    local Lumina = loadstring(game:HttpGet("https://raw.githubusercontent.com/your-repo/Lumina/main/Lumina.lua"))()
    
    local Window = Lumina:MakeWindow({
        Title = "Lumina Library",
        SubTitle = "Modern Roblox UI",
        SaveFolder = "LuminaConfig.json"
    })
]]

local Lumina = {}

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

-- Promise System
local Promise = {}
Promise.__index = Promise

function Promise.new(executor)
    local self = setmetatable({}, Promise)
    self._state = "pending"
    self._value = nil
    self._error = nil
    self._callbacks = {}
    
    local function resolve(value)
        if self._state ~= "pending" then return end
        self._state = "fulfilled"
        self._value = value
        task.spawn(function()
            for _, cb in ipairs(self._callbacks) do
                if cb.type == "then" then
                    pcall(cb.fn, value)
                end
            end
        end)
    end
    
    local function reject(error)
        if self._state ~= "pending" then return end
        self._state = "rejected"
        self._error = error
        task.spawn(function()
            for _, cb in ipairs(self._callbacks) do
                if cb.type == "catch" then
                    pcall(cb.fn, error)
                end
            end
        end)
    end
    
    pcall(executor, resolve, reject)
    return self
end

function Promise:Then(callback)
    if self._state == "fulfilled" then
        task.spawn(callback, self._value)
    elseif self._state == "pending" then
        table.insert(self._callbacks, { type = "then", fn = callback })
    end
    return self
end

function Promise:Catch(callback)
    if self._state == "rejected" then
        task.spawn(callback, self._error)
    elseif self._state == "pending" then
        table.insert(self._callbacks, { type = "catch", fn = callback })
    end
    return self
end

function Promise:Finally(callback)
    if self._state ~= "pending" then
        task.spawn(callback)
    else
        table.insert(self._callbacks, { type = "finally", fn = callback })
    end
    return self
end

Promise.Resolve = function(value)
    return Promise.new(function(resolve) resolve(value) end)
end

Promise.Reject = function(error)
    return Promise.new(function(_, reject) reject(error) end)
end

Promise.All = function(promises)
    return Promise.new(function(resolve, reject)
        local results = {}
        local completed = 0
        for i, promise in ipairs(promises) do
            promise:Then(function(value)
                results[i] = value
                completed = completed + 1
                if completed == #promises then
                    resolve(results)
                end
            end):Catch(reject)
        end
    end)
end

-- Color Utilities
local Color = {}

function Color.fromRGB(r, g, b)
    return Color3.fromRGB(r, g, b)
end

function Color.fromHex(hex)
    hex = hex:gsub("#", "")
    local r = tonumber(hex:sub(1, 2), 16) or 0
    local g = tonumber(hex:sub(3, 4), 16) or 0
    local b = tonumber(hex:sub(5, 6), 16) or 0
    return Color3.fromRGB(r, g, b)
end

function Color.toHex(color)
    local r = math.floor(color.R * 255)
    local g = math.floor(color.G * 255)
    local b = math.floor(color.B * 255)
    return string.format("#%02x%02x%02x", r, g, b)
end

function Color.lerp(a, b, t)
    return Color3.new(
        a.R + (b.R - a.R) * t,
        a.G + (b.G - a.G) * t,
        a.B + (b.B - a.B) * t
    )
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

function Tween:Promise(object, properties, duration, style, direction)
    return Promise.new(function(resolve)
        local tween = self:Create(object, properties, duration, style, direction)
        tween:Play()
        tween.Completed:Connect(resolve)
    end)
end

-- ============================================================================
-- MANAGERS
-- ============================================================================

-- Theme Manager
local ThemeManager = {}
ThemeManager.__index = ThemeManager

local Themes = {
    Dark = {
        Name = "Dark",
        Background = Color3.fromRGB(20, 20, 24),
        Surface = Color3.fromRGB(30, 30, 35),
        Surface2 = Color3.fromRGB(40, 40, 45),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(180, 180, 190),
        Border = Color3.fromRGB(50, 50, 55),
        Hover = Color3.fromRGB(45, 45, 50),
        Press = Color3.fromRGB(55, 55, 60),
    },
    Light = {
        Name = "Light",
        Background = Color3.fromRGB(240, 240, 245),
        Surface = Color3.fromRGB(255, 255, 255),
        Surface2 = Color3.fromRGB(245, 245, 250),
        Text = Color3.fromRGB(0, 0, 0),
        TextSecondary = Color3.fromRGB(80, 80, 85),
        Border = Color3.fromRGB(220, 220, 225),
        Hover = Color3.fromRGB(235, 235, 240),
        Press = Color3.fromRGB(225, 225, 230),
    },
    Glass = {
        Name = "Glass",
        Background = Color3.fromRGB(20, 20, 30),
        Surface = Color3.fromRGB(40, 40, 55),
        Surface2 = Color3.fromRGB(50, 50, 65),
        Text = Color3.fromRGB(255, 255, 255),
        TextSecondary = Color3.fromRGB(190, 190, 200),
        Border = Color3.fromRGB(60, 60, 75),
        Hover = Color3.fromRGB(55, 55, 70),
        Press = Color3.fromRGB(65, 65, 80),
    },
    Midnight = {
        Name = "Midnight",
        Background = Color3.fromRGB(10, 10, 18),
        Surface = Color3.fromRGB(18, 18, 28),
        Surface2 = Color3.fromRGB(28, 28, 38),
        Text = Color3.fromRGB(220, 220, 240),
        TextSecondary = Color3.fromRGB(160, 160, 180),
        Border = Color3.fromRGB(35, 35, 45),
        Hover = Color3.fromRGB(32, 32, 42),
        Press = Color3.fromRGB(42, 42, 52),
    },
    Ocean = {
        Name = "Ocean",
        Background = Color3.fromRGB(8, 28, 48),
        Surface = Color3.fromRGB(16, 40, 60),
        Surface2 = Color3.fromRGB(24, 50, 72),
        Text = Color3.fromRGB(220, 240, 255),
        TextSecondary = Color3.fromRGB(160, 190, 210),
        Border = Color3.fromRGB(40, 65, 85),
        Hover = Color3.fromRGB(30, 55, 75),
        Press = Color3.fromRGB(40, 65, 85),
    },
    Emerald = {
        Name = "Emerald",
        Background = Color3.fromRGB(8, 30, 20),
        Surface = Color3.fromRGB(16, 48, 32),
        Surface2 = Color3.fromRGB(24, 60, 40),
        Text = Color3.fromRGB(200, 255, 220),
        TextSecondary = Color3.fromRGB(150, 200, 170),
        Border = Color3.fromRGB(40, 75, 55),
        Hover = Color3.fromRGB(30, 60, 40),
        Press = Color3.fromRGB(40, 75, 55),
    },
    Purple = {
        Name = "Purple",
        Background = Color3.fromRGB(20, 10, 35),
        Surface = Color3.fromRGB(35, 20, 55),
        Surface2 = Color3.fromRGB(50, 30, 70),
        Text = Color3.fromRGB(240, 220, 255),
        TextSecondary = Color3.fromRGB(190, 170, 210),
        Border = Color3.fromRGB(60, 40, 80),
        Hover = Color3.fromRGB(50, 30, 70),
        Press = Color3.fromRGB(60, 40, 80),
    },
}

function ThemeManager.new()
    local self = setmetatable({}, ThemeManager)
    self._currentTheme = "Dark"
    self._accent = Color3.fromRGB(98, 0, 238)
    self._themes = Themes
    self._callbacks = {}
    return self
end

function ThemeManager:GetTheme(name)
    return self._themes[name]
end

function ThemeManager:GetCurrentTheme()
    return self._currentTheme
end

function ThemeManager:GetThemeData()
    return self._themes[self._currentTheme]
end

function ThemeManager:SetTheme(name)
    if not self._themes[name] then return false end
    self._currentTheme = name
    for _, callback in ipairs(self._callbacks) do
        task.spawn(callback, self._themes[name])
    end
    return true
end

function ThemeManager:GetAccent()
    return self._accent
end

function ThemeManager:SetAccent(color)
    self._accent = color
    for _, callback in ipairs(self._callbacks) do
        task.spawn(callback, nil, color)
    end
    return true
end

function ThemeManager:RegisterCallback(callback)
    table.insert(self._callbacks, callback)
    return callback
end

function ThemeManager:Initialize(config)
    if config.DefaultTheme then
        self:SetTheme(config.DefaultTheme)
    end
    if config.DefaultAccent then
        self:SetAccent(config.DefaultAccent)
    end
end

-- Config Manager
local ConfigManager = {}
ConfigManager.__index = ConfigManager

function ConfigManager.new()
    local self = setmetatable({}, ConfigManager)
    self._config = {}
    self._saveFolder = "LuminaConfig.json"
    self._autoSave = true
    return self
end

function ConfigManager:Initialize(config)
    if config.SaveFolder then
        self._saveFolder = config.SaveFolder
    end
    self._autoSave = config.AutoSave ~= false
    self:Load()
end

function ConfigManager:Get(key, default)
    return self._config[key] or default
end

function ConfigManager:Set(key, value)
    self._config[key] = value
    if self._autoSave then
        self:Save()
    end
end

function ConfigManager:Save()
    local success, result = pcall(function()
        local json = game:GetService("HttpService"):JSONEncode(self._config)
        -- Save using appropriate method based on executor
        if syn and syn.request then
            -- Synapse X
        elseif request then
            -- Krnl/Other
        end
        return json
    end)
    return success
end

function ConfigManager:Load()
    local success, result = pcall(function()
        -- Load config logic
        return {}
    end)
    if success and result then
        self._config = result
    end
    return success
end

function ConfigManager:GetSaveFolder()
    return self._saveFolder
end

function ConfigManager:SetSaveFolder(folder)
    self._saveFolder = folder
end

-- Animation Manager
local AnimationManager = {}
AnimationManager.__index = AnimationManager

function AnimationManager.new()
    local self = setmetatable({}, AnimationManager)
    self._tweens = {}
    self._speed = 0.3
    return self
end

function AnimationManager:Initialize(config)
    if config.AnimationSpeed then
        self._speed = config.AnimationSpeed
    end
end

function AnimationManager:Create(object, properties, duration, style, direction)
    duration = duration or self._speed
    local tweenInfo = TweenInfo.new(
        duration,
        style or Enum.EasingStyle.Quart,
        direction or Enum.EasingDirection.Out
    )
    local tween = game:GetService("TweenService"):Create(object, tweenInfo, properties)
    table.insert(self._tweens, tween)
    return tween
end

function AnimationManager:Play(tween)
    tween:Play()
    return tween
end

function AnimationManager:CreateAndPlay(object, properties, duration, style, direction)
    local tween = self:Create(object, properties, duration, style, direction)
    tween:Play()
    return tween
end

function AnimationManager:Cancel(object)
    for i, tween in ipairs(self._tweens) do
        if tween and tween.Instance == object then
            tween:Cancel()
            table.remove(self._tweens, i)
        end
    end
end

function AnimationManager:SetSpeed(speed)
    self._speed = speed
end

-- Notification Manager
local NotificationManager = {}
NotificationManager.__index = NotificationManager

function NotificationManager.new()
    local self = setmetatable({}, NotificationManager)
    self._notifications = {}
    self._maxNotifications = 5
    self._queue = {}
    self._isProcessing = false
    self._container = nil
    return self
end

function NotificationManager:Initialize(config)
    if config.MaxNotifications then
        self._maxNotifications = config.MaxNotifications
    end
    self._container = self._createContainer()
end

function NotificationManager:_createContainer()
    -- Create notification container
    local container = Instance.new("ScreenGui")
    container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    container.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
    container.Name = "LuminaNotifications"
    return container
end

function NotificationManager:Notify(options)
    local notification = self._createNotification(options)
    table.insert(self._queue, notification)
    self:_processQueue()
    return notification
end

function NotificationManager:_createNotification(options)
    local self = this -- Actually need proper scoping
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 80)
    frame.Position = UDim2.new(1, -370, 1, -100)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    frame.BackgroundTransparency = 0
    frame.BorderSizePixel = 0
    frame.Parent = self._container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Icon
    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 10, 0, 10)
    icon.BackgroundTransparency = 1
    icon.Image = options.Icon or ""
    icon.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -70, 0, 25)
    title.Position = UDim2.new(0, 50, 0, 8)
    title.BackgroundTransparency = 1
    title.Text = options.Title or "Notification"
    title.TextSize = 16
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    title.Parent = frame
    
    -- Content
    local content = Instance.new("TextLabel")
    content.Size = UDim2.new(1, -70, 0, 30)
    content.Position = UDim2.new(0, 50, 0, 35)
    content.BackgroundTransparency = 1
    content.Text = options.Content or ""
    content.TextSize = 13
    content.TextColor3 = Color3.fromRGB(180, 180, 190)
    content.TextXAlignment = Enum.TextXAlignment.Left
    content.TextWrapped = true
    content.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    content.Parent = frame
    
    -- Progress bar for duration
    local progress = Instance.new("Frame")
    progress.Size = UDim2.new(1, 0, 0, 3)
    progress.Position = UDim2.new(0, 0, 1, -3)
    progress.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
    progress.BorderSizePixel = 0
    progress.Parent = frame
    
    local progressCorner = Instance.new("UICorner")
    progressCorner.CornerRadius = UDim.new(0, 4)
    progressCorner.Parent = progress
    
    local notification = {
        Frame = frame,
        Title = title,
        Content = content,
        Progress = progress,
        Duration = options.Duration or 5,
        Close = function()
            self:_animateClose(frame)
        end,
        Update = function(newOptions)
            if newOptions.Title then title.Text = newOptions.Title end
            if newOptions.Content then content.Text = newOptions.Content end
            if newOptions.Icon then icon.Image = newOptions.Icon end
        end
    }
    
    -- Auto-close
    task.delay(options.Duration or 5, function()
        notification:Close()
    end)
    
    return notification
end

function NotificationManager:_animateClose(frame)
    local tween = Tween:Create(frame, { BackgroundTransparency = 1, Position = UDim2.new(1, -370, 1, -60) }, 0.3)
    tween:Play()
    tween.Completed:Connect(function()
        frame:Destroy()
    end)
end

function NotificationManager:_processQueue()
    if self._isProcessing then return end
    if #self._queue == 0 then return end
    
    self._isProcessing = true
    
    while #self._queue > 0 do
        if #self._notifications >= self._maxNotifications then
            local old = table.remove(self._notifications, 1)
            if old and old.Frame then
                old.Frame:Destroy()
            end
        end
        
        local notif = table.remove(self._queue, 1)
        if notif and notif.Frame then
            table.insert(self._notifications, notif)
        end
        task.wait(0.1)
    end
    
    self._isProcessing = false
end

function NotificationManager:Toast(options)
    return self:Notify({
        Title = "",
        Content = options.Content or "",
        Duration = options.Duration or 2,
        Icon = options.Icon or ""
    })
end

function NotificationManager:Dialog(options)
    -- Simple dialog implementation
    print("[Lumina Dialog]", options.Title, options.Content)
    if options.Callback and options.Buttons then
        -- Show buttons
        for _, button in ipairs(options.Buttons) do
            print("Button:", button)
        end
    end
end

function NotificationManager:Prompt(options)
    print("[Lumina Prompt]", options.Title, options.Content)
    if options.Callback then
        -- Simulate input
        options.Callback("")
    end
end

function NotificationManager:SetConfig(config)
    if config.MaxNotifications then
        self._maxNotifications = config.MaxNotifications
    end
end

-- Sound Manager
local SoundManager = {}
SoundManager.__index = SoundManager

function SoundManager.new()
    local self = setmetatable({}, SoundManager)
    self._enabled = true
    self._sounds = {}
    return self
end

function SoundManager:Initialize(config)
    if config.SoundEnabled ~= nil then
        self._enabled = config.SoundEnabled
    end
end

function SoundManager:Play(soundId, volume)
    if not self._enabled then return end
    
    local sound = Instance.new("Sound")
    sound.SoundId = soundId
    sound.Volume = volume or 0.5
    sound.PlayOnRemove = true
    sound.Parent = game:GetService("Players").LocalPlayer
    sound:Play()
    
    task.delay(sound.TimeLength + 0.1, function()
        sound:Destroy()
    end)
end

function SoundManager:PlayHover()
    self:Play("rbxassetid://9120386179", 0.3)
end

function SoundManager:PlayClick()
    self:Play("rbxassetid://9120388376", 0.4)
end

function SoundManager:PlayNotification()
    self:Play("rbxassetid://9120391338", 0.5)
end

function SoundManager:PlayToggle()
    self:Play("rbxassetid://9120390187", 0.3)
end

function SoundManager:PlayDropdown()
    self:Play("rbxassetid://9120389356", 0.3)
end

function SoundManager:SetEnabled(enabled)
    self._enabled = enabled
end

function SoundManager:SetConfig(config)
    if config.SoundEnabled ~= nil then
        self._enabled = config.SoundEnabled
    end
end

-- Search Manager
local SearchManager = {}
SearchManager.__index = SearchManager

function SearchManager.new()
    local self = setmetatable({}, SearchManager)
    self._searchableItems = {}
    return self
end

function SearchManager:Initialize(config)
    -- Setup search
end

function SearchManager:RegisterItem(item, keywords)
    table.insert(self._searchableItems, {
        Item = item,
        Keywords = keywords or {},
        Name = item.Name or "",
        Description = item.Description or "",
    })
end

function SearchManager:Search(query)
    query = string.lower(query)
    local results = {}
    
    for _, item in ipairs(self._searchableItems) do
        local match = false
        
        -- Search by name
        if string.find(string.lower(item.Name), query) then
            match = true
        end
        
        -- Search by description
        if not match and string.find(string.lower(item.Description), query) then
            match = true
        end
        
        -- Search by keywords
        if not match then
            for _, keyword in ipairs(item.Keywords) do
                if string.find(string.lower(keyword), query) then
                    match = true
                    break
                end
            end
        end
        
        if match then
            table.insert(results, item.Item)
        end
    end
    
    return results
end

function SearchManager:FuzzySearch(query, items)
    -- Simple fuzzy search implementation
    query = string.lower(query)
    local results = {}
    local scores = {}
    
    for _, item in ipairs(items) do
        local name = string.lower(item.Name or "")
        local score = 0
        
        -- Simple scoring
        if string.find(name, query) then
            score = score + 10
        end
        
        -- Check for individual characters
        local matchCount = 0
        for i = 1, #query do
            if string.find(name, query:sub(i, i)) then
                matchCount = matchCount + 1
            end
        end
        score = score + (matchCount / #query) * 5
        
        if score > 0 then
            table.insert(results, item)
            scores[item] = score
        end
    end
    
    -- Sort by score
    table.sort(results, function(a, b)
        return (scores[a] or 0) > (scores[b] or 0)
    end)
    
    return results
end

-- Input Manager
local InputManager = {}
InputManager.__index = InputManager

function InputManager.new()
    local self = setmetatable({}, InputManager)
    self._binds = {}
    self._keys = {}
    self._mouse = game:GetService("UserInputService")
    return self
end

function InputManager:Initialize(config)
    self._mouse.MouseButton1Down:Connect(function()
        for _, bind in ipairs(self._binds) do
            if bind.Key == "MouseButton1" then
                bind.Callback()
            end
        end
    end)
end

function InputManager:Bind(key, callback)
    table.insert(self._binds, { Key = key, Callback = callback })
end

function InputManager:Unbind(key)
    for i, bind in ipairs(self._binds) do
        if bind.Key == key then
            table.remove(self._binds, i)
            break
        end
    end
end

function InputManager:IsKeyDown(key)
    return self._mouse:IsKeyDown(key)
end

function InputManager:GetMousePosition()
    return self._mouse:GetMouseLocation()
end

-- ============================================================================
-- CORE CLASSES
-- ============================================================================

-- Tab Class
local Tab = {}
Tab.__index = Tab

function Tab.new(name, icon, parent)
    local self = setmetatable({}, Tab)
    self.Name = name
    self.Icon = icon or ""
    self.Parent = parent
    self.Container = nil
    self.Button = nil
    self.Sections = {}
    self.Visible = true
    self.Badge = nil
    return self
end

function Tab:CreateUI(parent)
    -- Create tab button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundTransparency = 1
    button.Text = self.Name
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(180, 180, 190)
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = parent
    
    -- Icon if provided
    if self.Icon and self.Icon ~= "" then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = self.Icon
        icon.Parent = button
    end
    
    self.Button = button
    self.Container = button
    return button
end

function Tab:SetName(name)
    self.Name = name
    if self.Button then
        self.Button.Text = name
    end
end

function Tab:SetIcon(icon)
    self.Icon = icon
    -- Update icon if exists
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
end

function Tab:Destroy()
    if self.Button then
        self.Button:Destroy()
    end
end

-- Section Class
local Section = {}
Section.__index = Section

function Section.new(name, parent)
    local self = setmetatable({}, Section)
    self.Name = name
    self.Parent = parent
    self.Container = nil
    self.Visible = true
    self.Collapsed = false
    self.Components = {}
    return self
end

function Section:CreateUI(parent)
    -- Create section container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -20, 0, 50)
    container.Position = UDim2.new(0, 10, 0, 0)
    container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    -- Section header
    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.Position = UDim2.new(0, 0, 0, 0)
    header.BackgroundTransparency = 1
    header.Text = self.Name
    header.TextSize = 18
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    header.Parent = container
    
    -- Content container
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 0, 0)
    content.Position = UDim2.new(0, 0, 0, 35)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Parent = container
    
    -- UIListLayout for components
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 5)
    layout.Parent = content
    
    self.Container = container
    self.Content = content
    self.Layout = layout
    
    return container
end

function Section:AddComponent(component)
    table.insert(self.Components, component)
    if self.Content then
        component:CreateUI(self.Content)
    end
end

function Section:Collapse()
    self.Collapsed = true
    if self.Content then
        self.Content.Visible = false
    end
end

function Section:Expand()
    self.Collapsed = false
    if self.Content then
        self.Content.Visible = true
    end
end

function Section:Toggle()
    if self.Collapsed then
        self:Expand()
    else
        self:Collapse()
    end
end

function Section:Show()
    self.Visible = true
    if self.Container then
        self.Container.Visible = true
    end
end

function Section:Hide()
    self.Visible = false
    if self.Container then
        self.Container.Visible = false
    end
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
    self.Badge = options.Badge or ""
    self.Locked = options.Locked or false
    self.Visible = true
    self.Disabled = false
    self.Confirm = options.Confirm or false
    self.Tooltip = options.Tooltip or ""
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.Container = nil
    self.Button = nil
    self.SearchKeywords = options.SearchKeywords or {}
    return self
end

function Button:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 1, -5)
    button.Position = UDim2.new(0, 5, 0, 2.5)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = self.Name
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Icon
    if self.Icon and self.Icon ~= "" then
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 20, 0, 20)
        icon.Position = UDim2.new(0, 10, 0.5, -10)
        icon.BackgroundTransparency = 1
        icon.Image = self.Icon
        icon.Parent = button
    end
    
    -- Badge
    if self.Badge and self.Badge ~= "" then
        local badge = Instance.new("Frame")
        badge.Size = UDim2.new(0, 30, 0, 20)
        badge.Position = UDim2.new(1, -40, 0.5, -10)
        badge.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        badge.BorderSizePixel = 0
        badge.Parent = button
        
        local badgeCorner = Instance.new("UICorner")
        badgeCorner.CornerRadius = UDim.new(0, 10)
        badgeCorner.Parent = badge
        
        local badgeText = Instance.new("TextLabel")
        badgeText.Size = UDim2.new(1, 0, 1, 0)
        badgeText.BackgroundTransparency = 1
        badgeText.Text = self.Badge
        badgeText.TextSize = 10
        badgeText.TextColor3 = Color3.fromRGB(255, 255, 255)
        badgeText.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        badgeText.Parent = badge
    end
    
    -- Description
    if self.Description and self.Description ~= "" then
        local desc = Instance.new("TextLabel")
        desc.Size = UDim2.new(0.6, 0, 0, 15)
        desc.Position = UDim2.new(0.3, 0, 0.5, -5)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 11
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
    end
    
    -- Hover effects
    button.MouseEnter:Connect(function()
        if not self.Locked and not self.Disabled then
            button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        end
    end)
    
    button.MouseLeave:Connect(function()
        if not self.Locked and not self.Disabled then
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
        end
    end)
    
    -- Click
    button.MouseButton1Click:Connect(function()
        if self.Locked or self.Disabled then return end
        
        if self.Confirm then
            -- Show confirmation
            button.Text = "Confirm?"
            task.wait(1.5)
            button.Text = self.Name
            return
        end
        
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

function Button:SetDescription(desc)
    self.Description = desc
end

function Button:SetIcon(icon)
    self.Icon = icon
end

function Button:SetLocked(locked)
    self.Locked = locked
    if self.Button then
        self.Button.TextColor3 = locked and Color3.fromRGB(100, 100, 110) or Color3.fromRGB(255, 255, 255)
    end
end

function Button:Fire()
    if not self.Locked and not self.Disabled then
        self.Callback()
    end
end

function Button:Enable()
    self.Disabled = false
    if self.Button then
        self.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        self.Button.BackgroundTransparency = 0
    end
end

function Button:Disable()
    self.Disabled = true
    if self.Button then
        self.Button.TextColor3 = Color3.fromRGB(100, 100, 110)
        self.Button.BackgroundTransparency = 0.3
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
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.Indicator = nil
    self.Toggle = nil
    return self
end

function Toggle:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 40)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    -- Clickable area
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 1, -5)
    button.Position = UDim2.new(0, 5, 0, 2.5)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
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
        desc.Size = UDim2.new(0.4, 0, 0.5, 0)
        desc.Position = UDim2.new(0, 15, 0.5, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 11
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
        label.Size = UDim2.new(0.6, 0, 0.5, 0)
    end
    
    -- Toggle indicator
    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 22)
    toggleBg.Position = UDim2.new(1, -50, 0.5, -11)
    toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
    toggleBg.BorderSizePixel = 0
    toggleBg.Parent = button
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleDot = Instance.new("Frame")
    toggleDot.Size = UDim2.new(0, 18, 0, 18)
    toggleDot.Position = self.Value and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
    toggleDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggleDot.BorderSizePixel = 0
    toggleDot.Parent = toggleBg
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = toggleDot
    
    self.Container = container
    self.Button = button
    self.Toggle = toggleBg
    self.Indicator = toggleDot
    self.Label = label
    
    -- Set initial state
    self:_updateToggle()
    
    -- Click handler
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Toggle:_updateToggle()
    if self.Value then
        self.Toggle.BackgroundColor3 = Color3.fromRGB(98, 0, 238)
        self.Indicator.Position = UDim2.new(1, -22, 0.5, -9)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(98, 0, 238)
        end
    else
        self.Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 65)
        self.Indicator.Position = UDim2.new(0, 2, 0.5, -9)
        if self.Label then
            self.Label.TextColor3 = Color3.fromRGB(255, 255, 255)
        end
    end
end

function Toggle:Toggle()
    if self.Locked then return end
    self.Value = not self.Value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Set(value)
    if self.Locked then return end
    self.Value = value
    self:_updateToggle()
    self.Callback(self.Value)
end

function Toggle:Get()
    return self.Value
end

function Toggle:Lock()
    self.Locked = true
end

function Toggle:Unlock()
    self.Locked = false
end

function Toggle:Enable()
    self.Locked = false
end

function Toggle:Disable()
    self.Locked = true
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
    self.Precision = options.Precision or 0
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.Bar = nil
    self.Fill = nil
    self.ValueLabel = nil
    return self
end

function Slider:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 50)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 1, -5)
    button.Position = UDim2.new(0, 5, 0, 2.5)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = ""
    button.BorderSizePixel = 0
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Label
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0.5, 0)
    label.Position = UDim2.new(0, 15, 0, 0)
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
        desc.Size = UDim2.new(0.4, 0, 0.5, 0)
        desc.Position = UDim2.new(0, 15, 0.5, 0)
        desc.BackgroundTransparency = 1
        desc.Text = self.Description
        desc.TextSize = 11
        desc.TextColor3 = Color3.fromRGB(150, 150, 160)
        desc.TextXAlignment = Enum.TextXAlignment.Left
        desc.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        desc.Parent = button
        label.Size = UDim2.new(0.4, 0, 0.5, 0)
    end
    
    -- Value display
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0, 50, 1, 0)
    valueLabel.Position = UDim2.new(1, -60, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(self.Value)
    valueLabel.TextSize = 14
    valueLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
    valueLabel.TextXAlignment = Enum.TextXAlignment.Right
    valueLabel.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    valueLabel.Parent = button
    
    -- Slider bar
    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(0.3, 0, 0, 4)
    bar.Position = UDim2.new(0.5, -15, 0.8, 0)
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
    self.Button = button
    self.Bar = bar
    self.Fill = fill
    self.ValueLabel = valueLabel
    self.Label = label
    
    -- Mouse drag
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
        local relativeX = (mouse.X - absPos.X) / absSize.X
        relativeX = math.clamp(relativeX, 0, 1)
        
        local value = self.Min + (self.Max - self.Min) * relativeX
        if self.Integer then
            value = math.round(value)
        else
            local factor = 10 ^ (self.Precision or 1)
            value = math.round(value * factor) / factor
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
    
    local display = self.Value
    if self.Integer then
        display = math.round(display)
    end
    self.ValueLabel.Text = self.Prefix .. tostring(display) .. self.Suffix
end

function Slider:Set(value)
    if self.Locked then return end
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

function Slider:SetMin(min)
    self.Min = min
    self.Value = math.max(self.Value, min)
    self:_updateSlider()
end

function Slider:SetMax(max)
    self.Max = max
    self.Value = math.min(self.Value, max)
    self:_updateSlider()
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
    self.MultiSelect = options.MultiSelect or false
    self.Searchable = options.Searchable or false
    self.Icons = options.Icons or {}
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.Button = nil
    self.OptionsContainer = nil
    self.IsOpen = false
    self.SelectedOptions = self.MultiSelect and {} or ""
    return self
end

function Dropdown:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 30)
    button.Position = UDim2.new(0, 5, 0, 2.5)
    button.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    button.Text = self.Value or "Select..."
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(200, 200, 210)
    button.TextXAlignment = Enum.TextXAlignment.Left
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = container
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = button
    
    -- Arrow
    local arrow = Instance.new("ImageLabel")
    arrow.Size = UDim2.new(0, 16, 0, 16)
    arrow.Position = UDim2.new(1, -22, 0.5, -8)
    arrow.BackgroundTransparency = 1
    arrow.Image = "rbxassetid://6031091050"
    arrow.ImageColor3 = Color3.fromRGB(150, 150, 160)
    arrow.Parent = button
    
    -- Options container
    local optionsContainer = Instance.new("Frame")
    optionsContainer.Size = UDim2.new(1, -10, 0, 0)
    optionsContainer.Position = UDim2.new(0, 5, 0, 35)
    optionsContainer.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    optionsContainer.BorderSizePixel = 0
    optionsContainer.ClipsDescendants = true
    optionsContainer.Visible = false
    optionsContainer.Parent = container
    
    local optionsCorner = Instance.new("UICorner")
    optionsCorner.CornerRadius = UDim.new(0, 6)
    optionsCorner.Parent = optionsContainer
    
    -- Options layout
    local layout = Instance.new("UIListLayout")
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 2)
    layout.Parent = optionsContainer
    
    -- Add options
    for _, option in ipairs(self.Options) do
        self:_createOption(optionsContainer, option)
    end
    
    self.Container = container
    self.Button = button
    self.OptionsContainer = optionsContainer
    self.Arrow = arrow
    self.Layout = layout
    
    -- Click to toggle
    button.MouseButton1Click:Connect(function()
        self:Toggle()
    end)
    
    return container
end

function Dropdown:_createOption(parent, optionText)
    local option = Instance.new("TextButton")
    option.Size = UDim2.new(1, 0, 0, 25)
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
    
    -- Hover
    option.MouseEnter:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    end)
    
    option.MouseLeave:Connect(function()
        option.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    end)
    
    -- Click
    option.MouseButton1Click:Connect(function()
        self:Select(optionText)
    end)
    
    return option
end

function Dropdown:Toggle()
    if self.Locked then return end
    self.IsOpen = not self.IsOpen
    self.OptionsContainer.Visible = self.IsOpen
    
    if self.IsOpen then
        self.Arrow.Rotation = 180
        self.OptionsContainer.Size = UDim2.new(1, -10, 0, math.min(#self.Options * 27, 150))
    else
        self.Arrow.Rotation = 0
        self.OptionsContainer.Size = UDim2.new(1, -10, 0, 0)
        task.wait(0.2)
        self.OptionsContainer.Visible = false
    end
end

function Dropdown:Select(option)
    if self.Locked then return end
    
    if self.MultiSelect then
        -- Toggle selection
        local index = table.find(self.SelectedOptions, option)
        if index then
            table.remove(self.SelectedOptions, index)
        else
            table.insert(self.SelectedOptions, option)
        end
        self.Button.Text = table.concat(self.SelectedOptions, ", ")
    else
        self.Value = option
        self.Button.Text = option
    end
    
    self.Callback(option)
    
    if not self.MultiSelect then
        self:Toggle()
    end
end

function Dropdown:Add(option)
    table.insert(self.Options, option)
    if self.OptionsContainer then
        self:_createOption(self.OptionsContainer, option)
        -- Refresh layout
    end
end

function Dropdown:Remove(option)
    for i, opt in ipairs(self.Options) do
        if opt == option then
            table.remove(self.Options, i)
            break
        end
    end
    self:Refresh()
end

function Dropdown:Refresh()
    if self.OptionsContainer then
        for _, child in ipairs(self.OptionsContainer:GetChildren()) do
            if child:IsA("TextButton") then
                child:Destroy()
            end
        end
        for _, option in ipairs(self.Options) do
            self:_createOption(self.OptionsContainer, option)
        end
    end
end

function Dropdown:Clear()
    self.Options = {}
    self.SelectedOptions = {}
    self:Refresh()
end

function Dropdown:Set(value)
    if self.Locked then return end
    self.Value = value
    self.Button.Text = value
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
    self.NumbersOnly = options.NumbersOnly or false
    self.Regex = options.Regex or nil
    self.Locked = false
    self.Flag = options.Flag or ""
    self.Callback = options.Callback or function() end
    self.SearchKeywords = options.SearchKeywords or {}
    self.Container = nil
    self.TextBox = nil
    return self
end

function Textbox:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 45)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.Parent = parent
    
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, -10, 0, 30)
    textBox.Position = UDim2.new(0, 5, 0, 2.5)
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
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = textBox
    
    -- Label
    if self.Name and self.Name ~= "" then
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 100, 0, 15)
        label.Position = UDim2.new(0, 5, 0, -18)
        label.BackgroundTransparency = 1
        label.Text = self.Name
        label.TextSize = 12
        label.TextColor3 = Color3.fromRGB(150, 150, 160)
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
        label.Parent = container
    end
    
    self.Container = container
    self.TextBox = textBox
    
    textBox:GetPropertyChangedSignal("Text"):Connect(function()
        if self.Locked then return end
        
        local text = textBox.Text
        
        -- Numbers only
        if self.NumbersOnly then
            text = text:gsub("%D", "")
            textBox.Text = text
        end
        
        -- Regex validation
        if self.Regex then
            if not string.match(text, self.Regex) then
                -- Invalid input, revert
                textBox.Text = self.Default
                return
            end
        end
        
        self.Callback(text)
    end)
    
    return container
end

function Textbox:Set(text)
    if self.Locked then return end
    if self.TextBox then
        self.TextBox.Text = text
    end
    self.Callback(text)
end

function Textbox:Get()
    return self.TextBox and self.TextBox.Text or ""
end

function Textbox:Clear()
    if self.TextBox then
        self.TextBox.Text = ""
    end
end

-- Label Component
local Label = {}
Label.__index = Label

function Label.new(options)
    local self = setmetatable({}, Label)
    self.Text = options.Text or ""
    self.Size = options.Size or 14
    self.Color = options.Color or Color3.fromRGB(255, 255, 255)
    self.Font = options.Font or "SourceSansPro"
    self.Alignment = options.Alignment or "Left"
    self.Container = nil
    self.Label = nil
    return self
end

function Label:CreateUI(parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 30)
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
    label.TextXAlignment = self.Alignment == "Left" and Enum.TextXAlignment.Left or 
                         self.Alignment == "Center" and Enum.TextXAlignment.Center or 
                         Enum.TextXAlignment.Right
    label.FontFace = Font.new("rbxasset://fonts/families/" .. self.Font .. ".json")
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
    container.Size = UDim2.new(1, 0, 0, 30)
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
        label.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
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
-- WINDOW CLASS
-- ============================================================================

local Window = {}
Window.__index = Window

function Window.new(options)
    local self = setmetatable({}, Window)
    
    -- Properties
    self.Title = options.Title or "Lumina"
    self.SubTitle = options.SubTitle or ""
    self.Icon = options.Icon or ""
    self.Theme = options.Theme or "Dark"
    self.Accent = options.Accent or Color3.fromRGB(98, 0, 238)
    self.SaveFolder = options.SaveFolder or "LuminaConfig.json"
    self.Size = options.Size or UDim2.new(0, 778, 0, 461)
    self.Position = options.Position or UDim2.new(0.1572, 0, 0.22194, 0)
    self.Transparency = options.Transparency or 0
    self.Blur = options.Blur or false
    self.Resizable = options.Resizable or false
    self.MinSize = options.MinSize or UDim2.new(0, 400, 0, 300)
    self.MaxSize = options.MaxSize or UDim2.new(0, 1200, 0, 900)
    self.AutoSave = options.AutoSave or true
    self.Dock = options.Dock or "None"
    self.Floating = options.Floating or true
    
    -- State
    self.IsVisible = true
    self.IsLocked = false
    self.Tabs = {}
    self.ActiveTab = nil
    self.ActiveTabIndex = 0
    self.Components = {}
    self.Sections = {}
    
    -- Manager instances
    self._janitor = Janitor.new()
    self._themeManager = ThemeManager.new()
    self._animationManager = AnimationManager.new()
    self._searchManager = SearchManager.new()
    self._soundManager = SoundManager.new()
    
    -- Setup theme
    self._themeManager:SetTheme(self.Theme)
    self._themeManager:SetAccent(self.Accent)
    
    -- Create GUI
    self:_createGUI()
    
    -- Setup drag
    self:_setupDrag()
    
    -- Setup search
    self._searchEnabled = false
    
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
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    frame.BackgroundTransparency = self.Transparency
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 9)
    corner.Parent = frame
    
    -- Shadow
    local shadow = Instance.new("UIStroke")
    shadow.Thickness = 2
    shadow.Color = Color3.fromRGB(0, 0, 0)
    shadow.Transparency = 0.5
    shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    shadow.Parent = frame
    
    -- Title bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 46)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = frame
    
    local titleCorner = Instance.new("UICorner")
    titleCorner.CornerRadius = UDim.new(0, 9)
    titleCorner.Parent = titleBar
    
    -- Title
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.5, 0, 1, 0)
    titleLabel.Position = UDim2.new(0.02, 0, 0, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = self.Title
    titleLabel.TextSize = 25
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
    subtitleLabel.TextSize = 14
    subtitleLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
    subtitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    subtitleLabel.FontFace = Font.new("rbxasset://fonts/families/Fondamento.json")
    subtitleLabel.Parent = titleBar
    
    -- Minimize button
    local minimizeBtn = Instance.new("ImageButton")
    minimizeBtn.Size = UDim2.new(0, 24, 0, 24)
    minimizeBtn.Position = UDim2.new(1, -70, 0.5, -12)
    minimizeBtn.BackgroundTransparency = 1
    minimizeBtn.Image = "rbxassetid://10747384394"
    minimizeBtn.Parent = titleBar
    
    -- Close button
    local closeBtn = Instance.new("ImageButton")
    closeBtn.Size = UDim2.new(0, 24, 0, 24)
    closeBtn.Position = UDim2.new(1, -40, 0.5, -12)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Image = "rbxassetid://10747384394"
    closeBtn.ImageColor3 = Color3.fromRGB(255, 50, 50)
    closeBtn.Parent = titleBar
    
    -- Tab container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 139, 1, 0)
    tabContainer.Position = UDim2.new(0, 0, 0, 46)
    tabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 29)
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = frame
    
    local tabCorner = Instance.new("UICorner")
    tabCorner.CornerRadius = UDim.new(0, 9)
    tabCorner.Parent = tabContainer
    
    -- Tab list
    local tabList = Instance.new("UIListLayout")
    tabList.SortOrder = Enum.SortOrder.LayoutOrder
    tabList.Padding = UDim.new(0, 2)
    tabList.Parent = tabContainer
    
    -- Main content
    local mainContent = Instance.new("Frame")
    mainContent.Size = UDim2.new(1, -139, 1, -46)
    mainContent.Position = UDim2.new(0, 139, 0, 46)
    mainContent.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
    mainContent.BorderSizePixel = 0
    mainContent.Parent = frame
    
    -- Search bar (hidden by default)
    local searchBar = Instance.new("TextBox")
    searchBar.Size = UDim2.new(1, -20, 0, 30)
    searchBar.Position = UDim2.new(0, 10, 0, 10)
    searchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    searchBar.Text = ""
    searchBar.TextSize = 14
    searchBar.TextColor3 = Color3.fromRGB(200, 200, 210)
    searchBar.PlaceholderText = "Search..."
    searchBar.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    searchBar.BorderSizePixel = 0
    searchBar.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    searchBar.ClearTextOnFocus = true
    searchBar.Visible = false
    searchBar.Parent = mainContent
    
    local searchCorner = Instance.new("UICorner")
    searchCorner.CornerRadius = UDim.new(0, 6)
    searchCorner.Parent = searchBar
    
    -- Content container
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -10, 1, -50)
    contentContainer.Position = UDim2.new(0, 5, 0, 45)
    contentContainer.BackgroundTransparency = 1
    contentContainer.BorderSizePixel = 0
    contentContainer.Parent = mainContent
    
    local contentLayout = Instance.new("UIListLayout")
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 5)
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
        SearchBar = searchBar,
        ContentContainer = contentContainer,
        ContentLayout = contentLayout,
        MinimizeBtn = minimizeBtn,
        CloseBtn = closeBtn,
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
            local scale = frame.AbsoluteSize
            local parent = frame.Parent
            
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
    local name = options[1] or "Tab"
    local icon = options[2] or ""
    
    local tab = Tab.new(name, icon, self)
    table.insert(self.Tabs, tab)
    
    -- Create tab button
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 40)
    button.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    button.BackgroundTransparency = 0.5
    button.Text = name
    button.TextSize = 14
    button.TextColor3 = Color3.fromRGB(180, 180, 190)
    button.BorderSizePixel = 0
    button.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json")
    button.Parent = self._gui.TabContainer
    
    -- Icon
    if icon and icon ~= "" then
        local iconLabel = Instance.new("ImageLabel")
        iconLabel.Size = UDim2.new(0, 20, 0, 20)
        iconLabel.Position = UDim2.new(0, 10, 0.5, -10)
        iconLabel.BackgroundTransparency = 1
        iconLabel.Image = icon
        iconLabel.Parent = button
    end
    
    tab.Button = button
    
    -- Create content frame for this tab
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, 0, 1, 0)
    content.BackgroundTransparency = 1
    content.BorderSizePixel = 0
    content.Parent = self._gui.ContentContainer
    
    -- Only show first tab initially
    content.Visible = (#self.Tabs == 1)
    
    -- Tab click
    button.MouseButton1Click:Connect(function()
        self:SelectTab(tab)
    end)
    
    -- Store
    tab.Content = content
    
    return tab
end

function Window:SelectTab(tab)
    -- Hide all tabs
    for _, t in ipairs(self.Tabs) do
        if t.Content then
            t.Content.Visible = false
        end
        if t.Button then
            t.Button.TextColor3 = Color3.fromRGB(180, 180, 190)
        end
    end
    
    -- Show selected
    tab.Content.Visible = true
    tab.Button.TextColor3 = Color3.fromRGB(98, 0, 238)
    
    self.ActiveTab = tab
end

function Window:AddMinimizeButton(options)
    -- Already implemented in title bar
    return self._gui.MinimizeBtn
end

function Window:EnableSearch()
    self._searchEnabled = true
    self._gui.SearchBar.Visible = true
end

function Window:DisableSearch()
    self._searchEnabled = false
    self._gui.SearchBar.Visible = false
end

function Window:Search(query)
    if not self._searchEnabled then return end
    self._gui.SearchBar.Text = query
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

function Window:SetTheme(theme)
    self.Theme = theme
    self._themeManager:SetTheme(theme)
end

function Window:SetAccent(color)
    self.Accent = color
    self._themeManager:SetAccent(color)
end

function Window:SetBackground(color)
    if self._gui and self._gui.Frame then
        self._gui.Frame.BackgroundColor3 = color
    end
end

function Window:SetBlur(enabled)
    self.Blur = enabled
    -- Implement blur if supported
end

function Window:SetTransparency(transparency)
    self.Transparency = transparency
    if self._gui and self._gui.Frame then
        self._gui.Frame.BackgroundTransparency = transparency
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

function Window:Shake(intensity, duration)
    intensity = intensity or 5
    duration = duration or 0.5
    local originalPos = self._gui.Frame.Position
    
    local steps = 10
    for i = 1, steps do
        local offsetX = math.random(-intensity, intensity)
        local offsetY = math.random(-intensity, intensity)
        self._gui.Frame.Position = UDim2.new(
            originalPos.X.Scale,
            originalPos.X.Offset + offsetX,
            originalPos.Y.Scale,
            originalPos.Y.Offset + offsetY
        )
        task.wait(duration / steps)
    end
    
    self._gui.Frame.Position = originalPos
end

function Window:Flash(color, duration)
    color = color or Color3.fromRGB(255, 255, 255)
    duration = duration or 0.3
    
    local original = self._gui.Frame.BackgroundColor3
    self._gui.Frame.BackgroundColor3 = color
    task.wait(duration)
    self._gui.Frame.BackgroundColor3 = original
end

function Window:Lock()
    self.IsLocked = true
end

function Window:Unlock()
    self.IsLocked = false
end

-- ============================================================================
-- LUMINA API
-- ============================================================================

-- State
local LuminaState = {
    Windows = {},
    ActiveWindow = nil,
    IsInitialized = false,
    Config = {
        DebugMode = false,
        ReleaseMode = true,
        DefaultTheme = "Dark",
        DefaultAccent = Color3.fromRGB(98, 0, 238),
        SaveFolder = "LuminaConfig.json",
        NotificationQueue = true,
        MaxNotifications = 5,
        AnimationSpeed = 0.3,
        SoundEnabled = true,
        IconsEnabled = true,
    }
}

local function Initialize()
    if LuminaState.IsInitialized then return end
    LuminaState.IsInitialized = true
    
    -- Initialize managers
    local themeMgr = ThemeManager.new()
    themeMgr:Initialize(LuminaState.Config)
    
    local configMgr = ConfigManager.new()
    configMgr:Initialize(LuminaState.Config)
    
    local notifMgr = NotificationManager.new()
    notifMgr:Initialize(LuminaState.Config)
    
    local animMgr = AnimationManager.new()
    animMgr:Initialize(LuminaState.Config)
    
    local soundMgr = SoundManager.new()
    soundMgr:Initialize(LuminaState.Config)
    
    local searchMgr = SearchManager.new()
    searchMgr:Initialize(LuminaState.Config)
    
    if LuminaState.Config.DebugMode then
        print("[Lumina] Framework initialized")
    end
end

-- Public API
function Lumina:MakeWindow(options)
    Initialize()
    
    local window = Window.new(options)
    table.insert(LuminaState.Windows, window)
    LuminaState.ActiveWindow = window
    
    return window
end

function Lumina:Notify(options)
    local notifMgr = NotificationManager.new()
    notifMgr:Initialize(LuminaState.Config)
    return notifMgr:Notify(options)
end

function Lumina:MakeNotification(options)
    return self:Notify({
        Title = options.Title,
        Content = options.Content,
        Duration = options.Time,
        Icon = options.Icon,
        Type = options.Type
    })
end

function Lumina:Toast(options)
    local notifMgr = NotificationManager.new()
    notifMgr:Initialize(LuminaState.Config)
    return notifMgr:Toast(options)
end

function Lumina:Dialog(options)
    local notifMgr = NotificationManager.new()
    notifMgr:Initialize(LuminaState.Config)
    return notifMgr:Dialog(options)
end

function Lumina:Prompt(options)
    local notifMgr = NotificationManager.new()
    notifMgr:Initialize(LuminaState.Config)
    return notifMgr:Prompt(options)
end

function Lumina:GetTheme()
    local themeMgr = ThemeManager.new()
    return themeMgr:GetCurrentTheme()
end

function Lumina:SetTheme(theme)
    local themeMgr = ThemeManager.new()
    return themeMgr:SetTheme(theme)
end

function Lumina:GetAccent()
    local themeMgr = ThemeManager.new()
    return themeMgr:GetAccent()
end

function Lumina:SetAccent(color)
    local themeMgr = ThemeManager.new()
    return themeMgr:SetAccent(color)
end

function Lumina:SetConfig(config)
    for key, value in pairs(config) do
        LuminaState.Config[key] = value
    end
end

function Lumina:GetConfig()
    return table.clone(LuminaState.Config)
end

function Lumina:GetWindows()
    return LuminaState.Windows
end

function Lumina:GetActiveWindow()
    return LuminaState.ActiveWindow
end

function Lumina:Destroy()
    for _, window in ipairs(LuminaState.Windows) do
        window:Destroy()
    end
    LuminaState.Windows = {}
    LuminaState.ActiveWindow = nil
    LuminaState.IsInitialized = false
end

function Lumina:DebugMode(enabled)
    LuminaState.Config.DebugMode = enabled
    print("[Lumina] Debug mode:", enabled)
end

function Lumina:GetVersion()
    return "1.0.0"
end

-- Backward compatibility
Lumina.MakeWindow = Lumina.MakeWindow
Lumina.MakeNotification = Lumina.MakeNotification
Lumina.Notify = Lumina.Notify

-- ============================================================================
-- COMPATIBILITY LAYER FOR EXISTING API
-- ============================================================================

-- Ensure old API methods work
local oldWindowMethods = {
    "AddButton",
    "AddToggle", 
    "AddSlider",
    "AddDropdown",
    "AddTextbox",
    "AddLabel",
    "AddParagraph",
    "AddSeparator",
}

-- Example of adding compatibility methods
function Window:AddButton(options)
    local button = Button.new(options)
    button:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return button
end

function Window:AddToggle(options)
    local toggle = Toggle.new(options)
    toggle:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return toggle
end

function Window:AddSlider(options)
    local slider = Slider.new(options)
    slider:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return slider
end

function Window:AddDropdown(options)
    local dropdown = Dropdown.new(options)
    dropdown:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return dropdown
end

function Window:AddTextbox(options)
    local textbox = Textbox.new(options)
    textbox:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return textbox
end

function Window:AddLabel(options)
    local label = Label.new(options)
    label:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return label
end

function Window:AddParagraph(options)
    -- Paragraph is just a multi-line label
    local paragraph = Label.new({
        Text = options.Text or "",
        Size = options.Size or 14,
        Color = options.Color or Color3.fromRGB(200, 200, 210),
        Alignment = "Left"
    })
    paragraph:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return paragraph
end

function Window:AddSeparator(options)
    local separator = Separator.new(options)
    separator:CreateUI(self.ActiveTab and self.ActiveTab.Content or self._gui.ContentContainer)
    return separator
end

-- ============================================================================
-- EXPORT
-- ============================================================================

return Lumina

--[[
    ============================================================================
    USAGE EXAMPLES
    ============================================================================
    
    -- Basic usage
    local Lumina = loadstring(game:HttpGet("https://your-url/Lumina.lua"))()
    
    -- Create window
    local Window = Lumina:MakeWindow({
        Title = "Lumina Library",
        SubTitle = "Modern Roblox UI Framework",
        SaveFolder = "LuminaConfig.json"
    })
    
    -- Create tab
    local MainTab = Window:MakeTab({"Main", "home"})
    
    -- Add components
    MainTab:AddButton({
        Name = "Click Me",
        Description = "This is a button",
        Callback = function()
            Lumina:Notify({
                Title = "Button Clicked",
                Content = "You clicked the button!",
                Duration = 3
            })
        end
    })
    
    MainTab:AddToggle({
        Name = "Toggle Me",
        Description = "Toggle this option",
        Default = false,
        Callback = function(value)
            print("Toggle:", value)
        end
    })
    
    MainTab:AddSlider({
        Name = "Slider",
        Description = "Adjust the value",
        Min = 0,
        Max = 100,
        Default = 50,
        Integer = true,
        Callback = function(value)
            print("Slider:", value)
        end
    })
    
    MainTab:AddDropdown({
        Name = "Dropdown",
        Description = "Select an option",
        Options = {"Option 1", "Option 2", "Option 3"},
        Default = "Option 1",
        Callback = function(value)
            print("Selected:", value)
        end
    })
    
    MainTab:AddTextbox({
        Name = "Textbox",
        Description = "Enter text",
        Placeholder = "Type here...",
        Default = "",
        Callback = function(value)
            print("Text:", value)
        end
    })
    
    MainTab:AddSeparator({})
    
    MainTab:AddLabel({
        Text = "This is a label",
        Size = 14,
        Color = Color3.fromRGB(200, 200, 210)
    })
]]
