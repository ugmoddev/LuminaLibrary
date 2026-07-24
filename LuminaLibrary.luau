--!strict
-- LuminaUI Framework - Single File Bundle

local Types, Utility, Theme, Config, BasicControls, DisplayControls, InputControls, DataControls, Notification, Tooltip, Loading, Tab, DropdownTab, Window, LibraryFactory

Types = (function()
    -- LuminaUI :: Core/Types.luau
    -- Centralised type definitions for the entire framework.
    -- ──────────────────────────────────────────────────────
    
    export type Color3Value = Color3
    
    -- ── Theme ──────────────────────────────────────────────
    export type ThemePalette = {
    	Background:          Color3Value,
    	BackgroundSecondary: Color3Value,
    	BackgroundTertiary:  Color3Value,
    	Surface:             Color3Value,
    	SurfaceHover:        Color3Value,
    	Border:              Color3Value,
    	BorderSubtle:        Color3Value,
    	Accent:              Color3Value,
    	AccentHover:         Color3Value,
    	AccentDim:           Color3Value,
    	Text:                Color3Value,
    	TextSecondary:       Color3Value,
    	TextDisabled:        Color3Value,
    	TextInverted:        Color3Value,
    	Success:             Color3Value,
    	Error:               Color3Value,
    	Warning:             Color3Value,
    	Info:                Color3Value,
    	Stroke:              Color3Value,
    	StrokeAccent:        Color3Value,
    	Scrollbar:           Color3Value,
    	Shadow:              Color3Value,
    }
    
    export type ThemeName = "Dark" | "Purple" | "Blue" | "Green" | "Custom"
    
    -- ── Animation ──────────────────────────────────────────
    export type EasingStyle   = Enum.EasingStyle
    export type EasingDirection = Enum.EasingDirection
    
    export type TweenConfig = {
    	Duration:  number,
    	Style:     EasingStyle,
    	Direction: EasingDirection,
    }
    
    -- ── Common Control Config ──────────────────────────────
    export type ControlConfig = {
    	Name:        string?,
    	Description: string?,
    	Tooltip:     string?,
    	Disabled:    boolean?,
    	Visible:     boolean?,
    	SaveToConfig: boolean?,
    }
    
    -- ── Button ─────────────────────────────────────────────
    export type ButtonConfig = ControlConfig & {
    	Callback: (() -> ())?
    }
    
    -- ── Toggle ─────────────────────────────────────────────
    export type ToggleConfig = ControlConfig & {
    	Default:  boolean?,
    	Callback: ((value: boolean) -> ())?
    }
    
    -- ── Slider ─────────────────────────────────────────────
    export type SliderConfig = ControlConfig & {
    	Min:      number?,
    	Max:      number?,
    	Default:  number?,
    	Step:     number?,
    	Suffix:   string?,
    	Callback: ((value: number) -> ())?
    }
    
    -- ── Dropdown ───────────────────────────────────────────
    export type DropdownOption = {
    	Value:       string,
    	DisplayName: string?,
    	Icon:        string?,
    }
    
    export type DropdownConfig = ControlConfig & {
    	Options:        {string | DropdownOption}?,
    	Default:        (string | {string})?,
    	MultiSelect:    boolean?,
    	Searchable:     boolean?,
    	MaxHeight:      number?,
    	Callback:       ((value: string | {string}) -> ())?
    }
    
    -- ── Textbox ────────────────────────────────────────────
    export type TextboxConfig = ControlConfig & {
    	Default:     string?,
    	Placeholder: string?,
    	ClearOnFocus:boolean?,
    	Callback:    ((value: string) -> ())?
    }
    
    -- ── Label ──────────────────────────────────────────────
    export type LabelConfig = {
    	Text:     string?,
    	Tooltip:  string?,
    	Visible:  boolean?,
    	TextSize: number?,
    }
    
    -- ── Paragraph ──────────────────────────────────────────
    export type ParagraphConfig = {
    	Title:   string?,
    	Content: string?,
    	Tooltip: string?,
    	Visible: boolean?,
    }
    
    -- ── Section ────────────────────────────────────────────
    export type SectionConfig = {
    	Name:    string?,
    	Visible: boolean?,
    }
    
    -- ── Separator ──────────────────────────────────────────
    export type SeparatorConfig = {
    	Text:    string?,
    	Visible: boolean?,
    }
    
    -- ── ColorPicker ────────────────────────────────────────
    export type ColorPickerConfig = ControlConfig & {
    	Default:  Color3Value?,
    	Callback: ((value: Color3Value) -> ())?
    }
    
    -- ── Keybind ────────────────────────────────────────────
    export type KeybindConfig = ControlConfig & {
    	Default:  Enum.KeyCode?,
    	Callback: ((key: Enum.KeyCode) -> ())?
    }
    
    -- ── ProgressBar ────────────────────────────────────────
    export type ProgressBarConfig = ControlConfig & {
    	Default:  number?,
    	Max:      number?,
    	Suffix:   string?,
    	Color:    Color3Value?,
    }
    
    -- ── Image ──────────────────────────────────────────────
    export type ImageConfig = {
    	Image:       string?,
    	Size:        UDim2?,
    	AspectRatio: number?,
    	Visible:     boolean?,
    }
    
    -- ── Tab ────────────────────────────────────────────────
    export type TabConfig = {
    	Name:    string,
    	Icon:    string?,
    	Visible: boolean?,
    	Order:   number?,
    }
    
    -- ── DropdownTab ────────────────────────────────────────
    export type DropdownTabConfig = {
    	Name:        string,
    	Icon:        string?,
    	DefaultOpen: boolean?,
    	Visible:     boolean?,
    	Order:       number?,
    }
    
    -- ── Window ─────────────────────────────────────────────
    export type WindowConfig = {
    	Title:       string?,
    	SubTitle:    string?,
    	Logo:        string?,
    	Version:     string?,
    	Size:        UDim2?,
    	Position:    UDim2?,
    	Theme:       ThemeName?,
    	MinSize:     Vector2?,
    	Draggable:   boolean?,
    	Resizable:   boolean?,
    	ShowStats:   boolean?,
    }
    
    -- ── Notification ───────────────────────────────────────
    export type NotificationType = "Success" | "Error" | "Warning" | "Info"
    
    export type NotificationConfig = {
    	Title:    string?,
    	Message:  string?,
    	Type:     NotificationType?,
    	Duration: number?,
    	Sound:    boolean?,
    	Callback: (() -> ())?
    }
    
    -- ── Dialog ─────────────────────────────────────────────
    export type DialogConfig = {
    	Title:    string?,
    	Message:  string?,
    	Buttons:  {string}?,
    	Callback: ((choice: string) -> ())?
    }
    
    -- ── Signal (lightweight typed event) ──────────────────
    export type SignalConnection = {
    	Disconnect: (self: SignalConnection) -> ()
    }
    
    export type Signal<T...> = {
    	Fire:    (self: Signal<T...>, T...) -> (),
    	Connect: (self: Signal<T...>, fn: (T...) -> ()) -> SignalConnection,
    	Once:    (self: Signal<T...>, fn: (T...) -> ()) -> SignalConnection,
    	DisconnectAll: (self: Signal<T...>) -> (),
    }
    
    -- ── Config Snapshot ────────────────────────────────────
    export type ConfigSnapshot = {
    	Theme:   ThemeName?,
    	Window:  {Position: {X: number, Y: number}?, Size: {X: number, Y: number}?}?,
    	Values:  {[string]: any}?,
    }
    
    return {}
    
end)()

Utility = (function()
    -- LuminaUI :: Core/Utility.luau
    -- Shared helpers: Signal, drag, resize, colour maths, instance shortcuts.
    -- ──────────────────────────────────────────────────────
    
    local UserInputService = game:GetService("UserInputService")
    local RunService       = game:GetService("RunService")
    local TweenService     = game:GetService("TweenService")
    
    local Utility = {}
    
    -- ══════════════════════════════════════════════════════
    -- § Signal  (lightweight typed event bus)
    -- ══════════════════════════════════════════════════════
    
    local SignalMeta = {}
    SignalMeta.__index = SignalMeta
    
    type SignalConnection = {
    	Connected: boolean,
    	Disconnect: (self: SignalConnection) -> (),
    }
    
    export type Signal<T...> = typeof(setmetatable({} :: {
    	_listeners: {{fn: (T...) -> (), once: boolean}},
    }, SignalMeta))
    
    function Utility.Signal<T...>(): Signal<T...>
    	local self = setmetatable({
    		_listeners = {} :: {{fn: (T...) -> (), once: boolean}},
    	}, SignalMeta)
    	return self :: any
    end
    
    function SignalMeta:Fire(...)
    	local toRemove: {number} = {}
    	for i, entry in ipairs(self._listeners) do
    		local ok, err = pcall(entry.fn, ...)
    		if not ok then
    			warn("[LuminaUI/Signal] Handler error:", err)
    		end
    		if entry.once then
    			table.insert(toRemove, 1, i) -- reverse order
    		end
    	end
    	for _, i in ipairs(toRemove) do
    		table.remove(self._listeners, i)
    	end
    end
    
    function SignalMeta:Connect(fn: (...any) -> ()): SignalConnection
    	local entry = {fn = fn, once = false}
    	table.insert(self._listeners, entry)
    	local conn: SignalConnection = {
    		Connected = true,
    		Disconnect = function(c)
    			c.Connected = false
    			local idx = table.find(self._listeners, entry)
    			if idx then table.remove(self._listeners, idx) end
    		end,
    	}
    	return conn
    end
    
    function SignalMeta:Once(fn: (...any) -> ()): SignalConnection
    	local entry = {fn = fn, once = true}
    	table.insert(self._listeners, entry)
    	local conn: SignalConnection = {
    		Connected = true,
    		Disconnect = function(c)
    			c.Connected = false
    			local idx = table.find(self._listeners, entry)
    			if idx then table.remove(self._listeners, idx) end
    		end,
    	}
    	return conn
    end
    
    function SignalMeta:DisconnectAll()
    	table.clear(self._listeners)
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Instance helpers
    -- ══════════════════════════════════════════════════════
    
    --- Create an Instance and set all properties at once.
    --- @param className string  — Roblox class name
    --- @param props     table   — property table
    --- @param parent    Instance? — optional parent
    function Utility.Create(className: string, props: {[string]: any}, parent: Instance?): Instance
    	local inst = Instance.new(className)
    	for k, v in pairs(props) do
    		(inst :: any)[k] = v
    	end
    	if parent then inst.Parent = parent end
    	return inst
    end
    
    --- Shorthand to apply a UICorner
    function Utility.Corner(radius: number, parent: Instance): UICorner
    	local c = Instance.new("UICorner")
    	c.CornerRadius = UDim.new(0, radius)
    	c.Parent = parent
    	return c
    end
    
    --- Shorthand to apply a UIStroke
    function Utility.Stroke(thickness: number, color: Color3, transparency: number?, parent: Instance): UIStroke
    	local s = Instance.new("UIStroke")
    	s.Thickness       = thickness
    	s.Color           = color
    	s.Transparency    = transparency or 0
    	s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    	s.Parent          = parent
    	return s
    end
    
    --- Shorthand UIPadding
    function Utility.Padding(top: number, right: number, bottom: number, left: number, parent: Instance): UIPadding
    	local p = Instance.new("UIPadding")
    	p.PaddingTop    = UDim.new(0, top)
    	p.PaddingRight  = UDim.new(0, right)
    	p.PaddingBottom = UDim.new(0, bottom)
    	p.PaddingLeft   = UDim.new(0, left)
    	p.Parent        = parent
    	return p
    end
    
    --- Shorthand UIListLayout (vertical by default)
    function Utility.ListLayout(
    	fillDir: Enum.FillDirection?,
    	sortOrder: Enum.SortOrder?,
    	padding: UDim?,
    	parent: Instance
    ): UIListLayout
    	local l = Instance.new("UIListLayout")
    	l.FillDirection      = fillDir  or Enum.FillDirection.Vertical
    	l.SortOrder          = sortOrder or Enum.SortOrder.LayoutOrder
    	l.Padding            = padding  or UDim.new(0, 6)
    	l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    	l.Parent             = parent
    	return l
    end
    
    --- UIGradient shorthand (vertical fade by default)
    function Utility.Gradient(
    	colorSequence: ColorSequence?,
    	rotation: number?,
    	transparency: NumberSequence?,
    	parent: Instance
    ): UIGradient
    	local g = Instance.new("UIGradient")
    	if colorSequence then g.Color       = colorSequence end
    	if transparency  then g.Transparency = transparency  end
    	g.Rotation = rotation or 0
    	g.Parent   = parent
    	return g
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Dragging
    -- ══════════════════════════════════════════════════════
    
    --- Make a GuiObject draggable via a handle.
    --- Returns a disconnect function.
    function Utility.MakeDraggable(handle: GuiObject, target: GuiObject): () -> ()
    	local dragging    = false
    	local dragStart   = Vector3.new()
    	local startPos    = UDim2.new()
    	local connections: {RBXScriptConnection} = {}
    
    	local function onInput(input: InputObject)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or
    		   input.UserInputType == Enum.UserInputType.Touch then
    			dragging  = true
    			dragStart = input.Position
    			startPos  = target.Position
    		end
    	end
    
    	local function onInputEnded(input: InputObject)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or
    		   input.UserInputType == Enum.UserInputType.Touch then
    			dragging = false
    		end
    	end
    
    	local function onMove(input: InputObject)
    		if dragging and (
    			input.UserInputType == Enum.UserInputType.MouseMovement or
    			input.UserInputType == Enum.UserInputType.Touch
    		) then
    			local delta = input.Position - dragStart
    			target.Position = UDim2.new(
    				startPos.X.Scale,
    				startPos.X.Offset + delta.X,
    				startPos.Y.Scale,
    				startPos.Y.Offset + delta.Y
    			)
    		end
    	end
    
    	table.insert(connections, handle.InputBegan:Connect(onInput))
    	table.insert(connections, handle.InputEnded:Connect(onInputEnded))
    	table.insert(connections, UserInputService.InputChanged:Connect(onMove))
    
    	return function()
    		for _, c in ipairs(connections) do
    			c:Disconnect()
    		end
    		table.clear(connections)
    	end
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Resizing
    -- ══════════════════════════════════════════════════════
    
    --- Attach a resize handle (bottom-right corner) to a frame.
    --- @param handle  GuiObject — visible resize grip element
    --- @param target  GuiObject — the frame to resize
    --- @param minSize Vector2   — minimum Width x Height
    --- @param maxSize Vector2?  — optional maximum
    --- Returns a disconnect function.
    function Utility.MakeResizable(
    	handle: GuiObject,
    	target: GuiObject,
    	minSize: Vector2,
    	maxSize: Vector2?
    ): () -> ()
    	local resizing   = false
    	local resizeStart = Vector3.new()
    	local startSize   = Vector2.new()
    	local connections: {RBXScriptConnection} = {}
    
    	local function onInput(input: InputObject)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 then
    			resizing    = true
    			resizeStart = input.Position
    			startSize   = Vector2.new(target.AbsoluteSize.X, target.AbsoluteSize.Y)
    		end
    	end
    
    	local function onInputEnded(input: InputObject)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 then
    			resizing = false
    		end
    	end
    
    	local function onMove(input: InputObject)
    		if resizing and input.UserInputType == Enum.UserInputType.MouseMovement then
    			local delta = input.Position - resizeStart
    			local newW = math.max(minSize.X, startSize.X + delta.X)
    			local newH = math.max(minSize.Y, startSize.Y + delta.Y)
    			if maxSize then
    				newW = math.min(maxSize.X, newW)
    				newH = math.min(maxSize.Y, newH)
    			end
    			local pos = target.Position
    			target.Size = UDim2.new(pos.X.Scale, newW, pos.Y.Scale, newH)
    		end
    	end
    
    	table.insert(connections, handle.InputBegan:Connect(onInput))
    	table.insert(connections, handle.InputEnded:Connect(onInputEnded))
    	table.insert(connections, UserInputService.InputChanged:Connect(onMove))
    
    	return function()
    		for _, c in ipairs(connections) do c:Disconnect() end
    		table.clear(connections)
    	end
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Colour helpers
    -- ══════════════════════════════════════════════════════
    
    function Utility.Lerp(a: Color3, b: Color3, t: number): Color3
    	return a:Lerp(b, t)
    end
    
    function Utility.ColorWithAlpha(c: Color3, alpha: number): Color3
    	-- Returns the colour unchanged; alpha must be managed via Transparency property.
    	return c
    end
    
    --- Convert a hex string (#RRGGBB or RRGGBB) to Color3.
    function Utility.HexToColor3(hex: string): Color3
    	hex = hex:gsub("#", "")
    	local r = tonumber(hex:sub(1, 2), 16) or 0
    	local g = tonumber(hex:sub(3, 4), 16) or 0
    	local b = tonumber(hex:sub(5, 6), 16) or 0
    	return Color3.fromRGB(r, g, b)
    end
    
    --- Convert Color3 → HSV
    function Utility.Color3ToHSV(c: Color3): (number, number, number)
    	return Color3.toHSV(c)
    end
    
    --- Convert HSV → Color3
    function Utility.HSVToColor3(h: number, s: number, v: number): Color3
    	return Color3.fromHSV(h, s, v)
    end
    
    -- ══════════════════════════════════════════════════════
    -- § String helpers
    -- ══════════════════════════════════════════════════════
    
    function Utility.Trim(s: string): string
    	return s:match("^%s*(.-)%s*$") or s
    end
    
    function Utility.ContainsCI(text: string, query: string): boolean
    	return text:lower():find(query:lower(), 1, true) ~= nil
    end
    
    function Utility.Truncate(s: string, maxLen: number): string
    	if #s > maxLen then
    		return s:sub(1, maxLen) .. "…"
    	end
    	return s
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Tween cache
    -- ══════════════════════════════════════════════════════
    
    local _tweenCache: {[string]: TweenInfo} = {}
    
    function Utility.TweenInfo(
    	duration: number,
    	style: Enum.EasingStyle?,
    	direction: Enum.EasingDirection?
    ): TweenInfo
    	local key = tostring(duration) .. tostring(style) .. tostring(direction)
    	if not _tweenCache[key] then
    		_tweenCache[key] = TweenInfo.new(
    			duration,
    			style     or Enum.EasingStyle.Quart,
    			direction or Enum.EasingDirection.Out
    		)
    	end
    	return _tweenCache[key]
    end
    
    --- Fire-and-forget tween helper.
    function Utility.Tween(obj: Instance, props: {[string]: any}, duration: number, style: Enum.EasingStyle?, dir: Enum.EasingDirection?): Tween
    	local info = Utility.TweenInfo(duration, style, dir)
    	local t = TweenService:Create(obj, info, props)
    	t:Play()
    	return t
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Misc
    -- ══════════════════════════════════════════════════════
    
    --- Deep-clone a plain table (no cyclic refs).
    function Utility.DeepCopy<T>(t: T): T
    	if type(t) ~= "table" then return t end
    	local copy: {[any]: any} = {}
    	for k, v in pairs(t :: any) do
    		copy[k] = Utility.DeepCopy(v)
    	end
    	return copy :: any
    end
    
    --- Safe disconnect helper for an optional connection.
    function Utility.SafeDisconnect(conn: RBXScriptConnection?)
    	if conn and conn.Connected then
    		conn:Disconnect()
    	end
    end
    
    --- Returns the current player name safely.
    function Utility.GetUsername(): string
    	local ok, name = pcall(function()
    		return game:GetService("Players").LocalPlayer.Name
    	end)
    	return ok and name or "Unknown"
    end
    
    --- Returns current executor identifier (heuristic).
    function Utility.GetExecutor(): string
    	if syn then return "Synapse X"
    	elseif KRNL_LOADED then return "Krnl"
    	elseif getgenv and getgenv().INFILTRATE_LOADED then return "Infiltrate"
    	elseif identifyexecutor then
    		local ok, name = pcall(identifyexecutor)
    		if ok then return name end
    	end
    	return "Unknown"
    end
    
    return Utility
    
end)()

Theme = (function()
    -- LuminaUI :: Core/Theme.luau
    -- Theme token engine — define palettes and apply them live.
    -- ──────────────────────────────────────────────────────
    
    local Types = Types
    
    -- ── Alias ──────────────────────────────────────────────
    type ThemePalette = Types.ThemePalette
    type ThemeName    = Types.ThemeName
    
    -- ── Signal (inline lightweight impl used only here) ─────
    type Listener = (palette: ThemePalette) -> ()
    local _listeners: {Listener} = {}
    
    -- ── Built-in Palettes ──────────────────────────────────
    local PALETTES: {[string]: ThemePalette} = {
    
    	Dark = {
    		Background          = Color3.fromHex("#0D0D0F"),
    		BackgroundSecondary = Color3.fromHex("#141416"),
    		BackgroundTertiary  = Color3.fromHex("#1A1A1D"),
    		Surface             = Color3.fromHex("#1E1E21"),
    		SurfaceHover        = Color3.fromHex("#252528"),
    		Border              = Color3.fromHex("#2E2E33"),
    		BorderSubtle        = Color3.fromHex("#232326"),
    		Accent              = Color3.fromHex("#7C5CBF"),
    		AccentHover         = Color3.fromHex("#9575D5"),
    		AccentDim           = Color3.fromHex("#3D2E60"),
    		Text                = Color3.fromHex("#F0F0F5"),
    		TextSecondary       = Color3.fromHex("#A0A0B0"),
    		TextDisabled        = Color3.fromHex("#555560"),
    		TextInverted        = Color3.fromHex("#0D0D0F"),
    		Success             = Color3.fromHex("#3DBE7A"),
    		Error               = Color3.fromHex("#E05252"),
    		Warning             = Color3.fromHex("#E09052"),
    		Info                = Color3.fromHex("#4D9DE0"),
    		Stroke              = Color3.fromHex("#2E2E33"),
    		StrokeAccent        = Color3.fromHex("#7C5CBF"),
    		Scrollbar           = Color3.fromHex("#3A3A40"),
    		Shadow              = Color3.fromHex("#000000"),
    	},
    
    	Purple = {
    		Background          = Color3.fromHex("#0E0A18"),
    		BackgroundSecondary = Color3.fromHex("#140E22"),
    		BackgroundTertiary  = Color3.fromHex("#1A122C"),
    		Surface             = Color3.fromHex("#1F1630"),
    		SurfaceHover        = Color3.fromHex("#281D3D"),
    		Border              = Color3.fromHex("#362848"),
    		BorderSubtle        = Color3.fromHex("#291E3D"),
    		Accent              = Color3.fromHex("#9D5CFF"),
    		AccentHover         = Color3.fromHex("#B580FF"),
    		AccentDim           = Color3.fromHex("#4D2880"),
    		Text                = Color3.fromHex("#EDE5FF"),
    		TextSecondary       = Color3.fromHex("#A890CC"),
    		TextDisabled        = Color3.fromHex("#5A4870"),
    		TextInverted        = Color3.fromHex("#0E0A18"),
    		Success             = Color3.fromHex("#3DBE7A"),
    		Error               = Color3.fromHex("#E05252"),
    		Warning             = Color3.fromHex("#E09052"),
    		Info                = Color3.fromHex("#5B8DEF"),
    		Stroke              = Color3.fromHex("#362848"),
    		StrokeAccent        = Color3.fromHex("#9D5CFF"),
    		Scrollbar           = Color3.fromHex("#4A3660"),
    		Shadow              = Color3.fromHex("#000000"),
    	},
    
    	Blue = {
    		Background          = Color3.fromHex("#080E18"),
    		BackgroundSecondary = Color3.fromHex("#0C1422"),
    		BackgroundTertiary  = Color3.fromHex("#101B2C"),
    		Surface             = Color3.fromHex("#132035"),
    		SurfaceHover        = Color3.fromHex("#1A2B45"),
    		Border              = Color3.fromHex("#1E3356"),
    		BorderSubtle        = Color3.fromHex("#162846"),
    		Accent              = Color3.fromHex("#3D8BFF"),
    		AccentHover         = Color3.fromHex("#5EA3FF"),
    		AccentDim           = Color3.fromHex("#1A4080"),
    		Text                = Color3.fromHex("#E0EEFF"),
    		TextSecondary       = Color3.fromHex("#7AAACF"),
    		TextDisabled        = Color3.fromHex("#365070"),
    		TextInverted        = Color3.fromHex("#080E18"),
    		Success             = Color3.fromHex("#3DBE7A"),
    		Error               = Color3.fromHex("#E05252"),
    		Warning             = Color3.fromHex("#E09052"),
    		Info                = Color3.fromHex("#3D8BFF"),
    		Stroke              = Color3.fromHex("#1E3356"),
    		StrokeAccent        = Color3.fromHex("#3D8BFF"),
    		Scrollbar           = Color3.fromHex("#2A4060"),
    		Shadow              = Color3.fromHex("#000000"),
    	},
    
    	Green = {
    		Background          = Color3.fromHex("#080F0C"),
    		BackgroundSecondary = Color3.fromHex("#0C1510"),
    		BackgroundTertiary  = Color3.fromHex("#101C16"),
    		Surface             = Color3.fromHex("#13201A"),
    		SurfaceHover        = Color3.fromHex("#1A2C22"),
    		Border              = Color3.fromHex("#1E3828"),
    		BorderSubtle        = Color3.fromHex("#162C20"),
    		Accent              = Color3.fromHex("#30C775"),
    		AccentHover         = Color3.fromHex("#4DDA8E"),
    		AccentDim           = Color3.fromHex("#155E38"),
    		Text                = Color3.fromHex("#DFFFEE"),
    		TextSecondary       = Color3.fromHex("#7ACCA0"),
    		TextDisabled        = Color3.fromHex("#365A48"),
    		TextInverted        = Color3.fromHex("#080F0C"),
    		Success             = Color3.fromHex("#30C775"),
    		Error               = Color3.fromHex("#E05252"),
    		Warning             = Color3.fromHex("#E09052"),
    		Info                = Color3.fromHex("#3D9BE0"),
    		Stroke              = Color3.fromHex("#1E3828"),
    		StrokeAccent        = Color3.fromHex("#30C775"),
    		Scrollbar           = Color3.fromHex("#2A4838"),
    		Shadow              = Color3.fromHex("#000000"),
    	},
    
    	-- Custom starts as a copy of Dark; call Theme.SetCustomPalette() to override.
    	Custom = {
    		Background          = Color3.fromHex("#0D0D0F"),
    		BackgroundSecondary = Color3.fromHex("#141416"),
    		BackgroundTertiary  = Color3.fromHex("#1A1A1D"),
    		Surface             = Color3.fromHex("#1E1E21"),
    		SurfaceHover        = Color3.fromHex("#252528"),
    		Border              = Color3.fromHex("#2E2E33"),
    		BorderSubtle        = Color3.fromHex("#232326"),
    		Accent              = Color3.fromHex("#7C5CBF"),
    		AccentHover         = Color3.fromHex("#9575D5"),
    		AccentDim           = Color3.fromHex("#3D2E60"),
    		Text                = Color3.fromHex("#F0F0F5"),
    		TextSecondary       = Color3.fromHex("#A0A0B0"),
    		TextDisabled        = Color3.fromHex("#555560"),
    		TextInverted        = Color3.fromHex("#0D0D0F"),
    		Success             = Color3.fromHex("#3DBE7A"),
    		Error               = Color3.fromHex("#E05252"),
    		Warning             = Color3.fromHex("#E09052"),
    		Info                = Color3.fromHex("#4D9DE0"),
    		Stroke              = Color3.fromHex("#2E2E33"),
    		StrokeAccent        = Color3.fromHex("#7C5CBF"),
    		Scrollbar           = Color3.fromHex("#3A3A40"),
    		Shadow              = Color3.fromHex("#000000"),
    	},
    }
    
    -- ── Module State ───────────────────────────────────────
    local _current: ThemeName = "Dark"
    
    -- ── Public API ─────────────────────────────────────────
    local Theme = {}
    Theme.__index = Theme
    
    --- Return the current palette.
    function Theme.Get(): ThemePalette
    	return PALETTES[_current]
    end
    
    --- Return a specific colour token from the active palette.
    function Theme.Color(key: string): Color3
    	local p = PALETTES[_current] :: any
    	return p[key] or Color3.new(1, 1, 1)
    end
    
    --- Set an active theme by name.
    function Theme.Set(name: ThemeName)
    	if PALETTES[name] then
    		_current = name
    		-- Notify listeners
    		local palette = PALETTES[name]
    		for _, fn in ipairs(_listeners) do
    			local ok, err = pcall(fn, palette)
    			if not ok then
    				warn("[LuminaUI/Theme] Listener error: " .. tostring(err))
    			end
    		end
    	else
    		warn("[LuminaUI/Theme] Unknown theme: " .. tostring(name))
    	end
    end
    
    --- Override the Custom palette and apply it.
    function Theme.SetCustomPalette(palette: ThemePalette)
    	PALETTES["Custom"] = palette
    	Theme.Set("Custom")
    end
    
    --- Register a listener that is called whenever the theme changes.
    --- Returns a disconnect function.
    function Theme.OnChanged(fn: Listener): () -> ()
    	table.insert(_listeners, fn)
    	return function()
    		local idx = table.find(_listeners, fn)
    		if idx then
    			table.remove(_listeners, idx)
    		end
    	end
    end
    
    --- Return the active theme name.
    function Theme.Current(): ThemeName
    	return _current
    end
    
    --- Return the full palettes table (read-only intent).
    function Theme.AllPalettes(): {[string]: ThemePalette}
    	return PALETTES
    end
    
    return Theme
    
end)()

Config = (function()
    -- LuminaUI :: Core/Config.luau
    -- Persist and restore control values, window state, and theme.
    -- Uses writefile/readfile if available (executor), otherwise a fallback in-memory store.
    -- ──────────────────────────────────────────────────────
    
    local Utility = Utility
    local Theme   = Theme
    
    -- ── Internal state ─────────────────────────────────────
    local _configName   = "LuminaUI_Config"
    local _values: {[string]: any}   = {}   -- key → value registry
    local _controls: {[string]: any} = {}   -- id → control ref (for SetValue on load)
    
    -- ── Serialise / Deserialise ────────────────────────────
    local function encode(data: any): string
    	-- Minimal JSON-compatible serialiser for basic Luau types.
    	local t = type(data)
    	if t == "string"  then return '"' .. data:gsub('"', '\\"') .. '"' end
    	if t == "number"  then return tostring(data) end
    	if t == "boolean" then return tostring(data) end
    	if t == "table"   then
    		-- Detect array vs dict
    		local isArray = (#data > 0)
    		if isArray then
    			local parts: {string} = {}
    			for _, v in ipairs(data) do
    				table.insert(parts, encode(v))
    			end
    			return "[" .. table.concat(parts, ",") .. "]"
    		else
    			local parts: {string} = {}
    			for k, v in pairs(data) do
    				table.insert(parts, '"' .. tostring(k) .. '":' .. encode(v))
    			end
    			return "{" .. table.concat(parts, ",") .. "}"
    		end
    	end
    	return "null"
    end
    
    -- Simple JSON decoder (handles string, number, bool, array, dict).
    local decode: (s: string, i: number?) -> (any, number)
    
    local function skipSpace(s: string, i: number): number
    	while i <= #s and s:sub(i, i):match("%s") do i += 1 end
    	return i
    end
    
    decode = function(s: string, i: number?): (any, number)
    	i = i or 1
    	i = skipSpace(s, i :: number)
    	local c = s:sub(i :: number, i :: number)
    	if c == '"' then
    		-- string
    		local j = i :: number + 1
    		local res = ""
    		while j <= #s do
    			local ch = s:sub(j, j)
    			if ch == "\\" then
    				j += 1
    				res ..= s:sub(j, j)
    			elseif ch == '"' then
    				return res, j + 1
    			else
    				res ..= ch
    			end
    			j += 1
    		end
    		return res, j
    	elseif c == "[" then
    		-- array
    		local arr: {any} = {}
    		local j = i :: number + 1
    		j = skipSpace(s, j)
    		if s:sub(j, j) == "]" then return arr, j + 1 end
    		while true do
    			local v: any
    			v, j = decode(s, j)
    			table.insert(arr, v)
    			j = skipSpace(s, j)
    			if s:sub(j, j) == "]" then return arr, j + 1 end
    			j += 1 -- skip comma
    		end
    	elseif c == "{" then
    		-- object
    		local obj: {[string]: any} = {}
    		local j = i :: number + 1
    		j = skipSpace(s, j)
    		if s:sub(j, j) == "}" then return obj, j + 1 end
    		while true do
    			local k: any
    			k, j = decode(s, j)
    			j = skipSpace(s, j)
    			j += 1 -- skip colon
    			local v: any
    			v, j = decode(s, j)
    			obj[tostring(k)] = v
    			j = skipSpace(s, j)
    			if s:sub(j, j) == "}" then return obj, j + 1 end
    			j += 1 -- skip comma
    		end
    	elseif c == "t" then return true,  i :: number + 4
    	elseif c == "f" then return false, i :: number + 5
    	elseif c == "n" then return nil,   i :: number + 4
    	else
    		-- number
    		local num, after = s:match("^(-?%d+%.?%d*[eE]?[+-]?%d*)()", i :: number)
    		return tonumber(num) or 0, after or i :: number + 1
    	end
    end
    
    -- ── File I/O wrappers ──────────────────────────────────
    local function fileWrite(name: string, data: string)
    	local ok, err = pcall(function()
    		if writefile then
    			writefile(name .. ".json", data)
    		end
    	end)
    	if not ok then
    		warn("[LuminaUI/Config] Write failed: " .. tostring(err))
    	end
    end
    
    local function fileRead(name: string): string?
    	local ok, result = pcall(function(): string?
    		if readfile and isfile and isfile(name .. ".json") then
    			return readfile(name .. ".json")
    		end
    		return nil
    	end)
    	if ok then return result end
    	return nil
    end
    
    local function fileDelete(name: string)
    	pcall(function()
    		if delfile and isfile and isfile(name .. ".json") then
    			delfile(name .. ".json")
    		end
    	end)
    end
    
    -- ── Public Config API ──────────────────────────────────
    local Config = {}
    Config.__index = Config
    
    --- Set the config file name prefix.
    function Config.SetName(name: string)
    	_configName = name
    end
    
    --- Register a control so Config can set its value on load.
    function Config.Register(id: string, control: any)
    	_controls[id] = control
    end
    
    --- Unregister a control.
    function Config.Unregister(id: string)
    	_controls[id] = nil
    end
    
    --- Internally set a value (called by controls).
    function Config.Set(id: string, value: any)
    	_values[id] = value
    end
    
    --- Internally get a stored value.
    function Config.GetValue(id: string): any
    	return _values[id]
    end
    
    --- Serialise all values + window state + theme to JSON string.
    function Config.Export(): string
    	local snapshot = {
    		theme  = Theme.Current(),
    		values = _values,
    	}
    	return encode(snapshot)
    end
    
    --- Restore from JSON string.
    function Config.Import(json: string)
    	local ok, data = pcall(decode, json, 1)
    	if not ok or type(data) ~= "table" then
    		warn("[LuminaUI/Config] Import failed: invalid JSON")
    		return
    	end
    	local snapshot = data :: {[string]: any}
    
    	-- Restore theme
    	if snapshot.theme and type(snapshot.theme) == "string" then
    		Theme.Set(snapshot.theme :: any)
    	end
    
    	-- Restore values
    	if snapshot.values and type(snapshot.values) == "table" then
    		for id, val in pairs(snapshot.values :: any) do
    			_values[id] = val
    			local ctrl = _controls[id]
    			if ctrl and ctrl.SetValue then
    				pcall(ctrl.SetValue, ctrl, val)
    			end
    		end
    	end
    end
    
    --- Persist current state to disk.
    function Config.Save()
    	fileWrite(_configName, Config.Export())
    end
    
    --- Load persisted state from disk.
    function Config.Load()
    	local raw = fileRead(_configName)
    	if raw then
    		Config.Import(raw)
    	end
    end
    
    --- Delete the config file.
    function Config.Delete()
    	fileDelete(_configName)
    	table.clear(_values)
    end
    
    return Config
    
end)()

BasicControls = (function()
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local Core = script.Parent.Parent.Parent.Core
    local Utility = Utility
    local Theme = Theme
    local Config = Config
    local Types = Types
    
    local Controls = {}
    
    -- [[ Helper: Base Control Class Methods ]]
    local function createBaseControl()
    	local self = {
    		_connections = {},
    		_locked = false,
    		_enabled = true,
    		_visible = true,
    		Value = nil,
    	}
    	return self
    end
    
    -- =======================================================================
    -- Button
    -- =======================================================================
    local Button = {}
    Button.__index = Button
    
    function Button.new(config)
    	local self = setmetatable(createBaseControl(), Button)
    	self._name = config.Name
    	self._callback = config.Callback
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Button_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 44),
    		BackgroundColor3 = Theme.Color("Surface"),
    		BackgroundTransparency = 0,
    		BorderSizePixel = 0,
    	})
    	Utility.Corner(frame, 8)
    	Utility.Stroke(frame, Theme.Color("Border"), 1)
    	Utility.Padding(frame, 10, 8)
    	
    	local title = Utility.Create("TextLabel", {
    		Name = "Title",
    		Parent = frame,
    		Size = UDim2.new(1, -110, 1, 0),
    		Position = UDim2.new(0, 0, 0, 0),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 14,
    		Font = Enum.Font.GothamMedium,
    		TextXAlignment = Enum.TextXAlignment.Left,
    	})
    	
    	local btnFrame = Utility.Create("Frame", {
    		Name = "BtnFrame",
    		Parent = frame,
    		Size = UDim2.new(0, 100, 1, 0),
    		Position = UDim2.new(1, -100, 0, 0),
    		BackgroundColor3 = Theme.Color("SurfaceHover"),
    	})
    	Utility.Corner(btnFrame, 6)
    	local uiScale = Utility.Create("UIScale", { Parent = btnFrame })
    	
    	local btn = Utility.Create("TextButton", {
    		Name = "Btn",
    		Parent = btnFrame,
    		Size = UDim2.new(1, 0, 1, 0),
    		BackgroundTransparency = 1,
    		Text = config.ButtonText or config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 13,
    		Font = Enum.Font.Gotham,
    		ClipsDescendants = true,
    	})
    	
    	self.Instance = frame
    	self.ButtonFrame = btnFrame
    	self.TitleLabel = title
    	self.ButtonInstance = btn
    	self.Scale = uiScale
    	
    	if config.Disabled then
    		self:Disable()
    	end
    	
    	table.insert(self._connections, btn.MouseEnter:Connect(function()
    		if not self._enabled then return end
    		Utility.Tween(btnFrame, {BackgroundColor3 = Theme.Color("Accent")}, 0.2)
    	end))
    	
    	table.insert(self._connections, btn.MouseLeave:Connect(function()
    		if not self._enabled then return end
    		Utility.Tween(btnFrame, {BackgroundColor3 = Theme.Color("SurfaceHover")}, 0.2)
    	end))
    	
    	table.insert(self._connections, btn.MouseButton1Down:Connect(function()
    		if not self._enabled then return end
    		Utility.Tween(uiScale, {Scale = 0.95}, 0.08)
    	end))
    	
    	table.insert(self._connections, btn.MouseButton1Up:Connect(function()
    		Utility.Tween(uiScale, {Scale = 1.0}, 0.08)
    	end))
    	
    	table.insert(self._connections, btn.MouseButton1Click:Connect(function()
    		if not self._enabled or self._locked then return end
    		
    		-- Ripple Effect
    		local mouseLocation = UserInputService:GetMouseLocation()
    		local ripple = Utility.Create("Frame", {
    			Parent = btn,
    			BackgroundColor3 = Color3.new(1, 1, 1),
    			BackgroundTransparency = 0.6,
    			Position = UDim2.new(0.5, 0, 0.5, 0),
    			Size = UDim2.new(0, 0, 0, 0),
    			AnchorPoint = Vector2.new(0.5, 0.5),
    		})
    		Utility.Corner(ripple, 50)
    		local t = Utility.Tween(ripple, {Size = UDim2.new(2, 0, 2, 0), BackgroundTransparency = 1}, 0.4)
    		task.delay(0.4, function() pcall(function() ripple:Destroy() end) end)
    		
    		if self._callback then
    			pcall(self._callback)
    		end
    	end))
    	
    	return self
    end
    
    function Button:SetValue(v) self.Value = v end
    function Button:GetValue() return self.Value end
    
    function Button:Destroy()
    	for _, c in ipairs(self._connections) do c:Disconnect() end
    	self.Instance:Destroy()
    end
    
    function Button:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Button:Enable()
    	self._enabled = true
    	self.TitleLabel.TextColor3 = Theme.Color("Text")
    	self.ButtonInstance.TextColor3 = Theme.Color("Text")
    	self.ButtonFrame.BackgroundColor3 = Theme.Color("SurfaceHover")
    end
    
    function Button:Disable()
    	self._enabled = false
    	self.TitleLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.ButtonInstance.TextColor3 = Theme.Color("TextDisabled")
    	self.ButtonFrame.BackgroundColor3 = Theme.Color("Surface")
    end
    
    function Button:Lock() self._locked = true end
    function Button:Unlock() self._locked = false end
    
    -- =======================================================================
    -- Toggle
    -- =======================================================================
    local Toggle = {}
    Toggle.__index = Toggle
    
    function Toggle.new(config)
    	local self = setmetatable(createBaseControl(), Toggle)
    	self._name = config.Name
    	self._callback = config.Callback
    	self.SaveToConfig = config.SaveToConfig
    	self.Value = config.Default or false
    	
    	if self.SaveToConfig then
    		local saved = Config.Get(self._name)
    		if saved ~= nil then self.Value = saved end
    	end
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Toggle_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 44),
    		BackgroundColor3 = Theme.Color("Surface"),
    		BackgroundTransparency = 0,
    		BorderSizePixel = 0,
    	})
    	Utility.Corner(frame, 8)
    	Utility.Stroke(frame, Theme.Color("Border"), 1)
    	Utility.Padding(frame, 10, 8)
    	
    	local title = Utility.Create("TextLabel", {
    		Name = "Title",
    		Parent = frame,
    		Size = UDim2.new(1, -50, 1, 0),
    		Position = UDim2.new(0, 0, 0, 0),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 14,
    		Font = Enum.Font.GothamMedium,
    		TextXAlignment = Enum.TextXAlignment.Left,
    	})
    	
    	local pill = Utility.Create("Frame", {
    		Name = "Pill",
    		Parent = frame,
    		Size = UDim2.new(0, 40, 0, 20),
    		Position = UDim2.new(1, -40, 0.5, -10),
    		BackgroundColor3 = self.Value and Theme.Color("Accent") or Theme.Color("Border"),
    	})
    	Utility.Corner(pill, 10)
    	
    	local circle = Utility.Create("Frame", {
    		Name = "Circle",
    		Parent = pill,
    		Size = UDim2.new(0, 16, 0, 16),
    		Position = UDim2.new(0, self.Value and 22 or 2, 0.5, -8),
    		BackgroundColor3 = Color3.new(1, 1, 1),
    	})
    	Utility.Corner(circle, 8)
    	
    	local btn = Utility.Create("TextButton", {
    		Name = "Hitbox",
    		Parent = frame,
    		Size = UDim2.new(1, 0, 1, 0),
    		BackgroundTransparency = 1,
    		Text = "",
    	})
    	
    	self.Instance = frame
    	self.TitleLabel = title
    	self.Pill = pill
    	self.Circle = circle
    	
    	if config.Disabled then
    		self:Disable()
    	end
    	
    	table.insert(self._connections, btn.MouseButton1Click:Connect(function()
    		if not self._enabled or self._locked then return end
    		self:SetValue(not self.Value)
    	end))
    	
    	return self
    end
    
    function Toggle:SetValue(v)
    	if self._locked then return end
    	self.Value = v
    	if self.SaveToConfig then
    		Config.Set(self._name, self.Value)
    	end
    	Utility.Tween(self.Pill, {BackgroundColor3 = self.Value and Theme.Color("Accent") or Theme.Color("Border")}, 0.2)
    	Utility.Tween(self.Circle, {Position = UDim2.new(0, self.Value and 22 or 2, 0.5, -8)}, 0.2)
    	if self._callback then
    		pcall(self._callback, self.Value)
    	end
    end
    
    function Toggle:GetValue() return self.Value end
    
    function Toggle:Destroy()
    	for _, c in ipairs(self._connections) do c:Disconnect() end
    	self.Instance:Destroy()
    end
    
    function Toggle:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Toggle:Enable()
    	self._enabled = true
    	self.TitleLabel.TextColor3 = Theme.Color("Text")
    	self.Pill.BackgroundTransparency = 0
    end
    
    function Toggle:Disable()
    	self._enabled = false
    	self.TitleLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.Pill.BackgroundTransparency = 0.5
    end
    
    function Toggle:Lock() self._locked = true end
    function Toggle:Unlock() self._locked = false end
    
    -- =======================================================================
    -- Slider
    -- =======================================================================
    local Slider = {}
    Slider.__index = Slider
    
    function Slider.new(config)
    	local self = setmetatable(createBaseControl(), Slider)
    	self._name = config.Name
    	self._callback = config.Callback
    	self.Min = config.Min or 0
    	self.Max = config.Max or 100
    	self.Step = config.Step or 1
    	self.Suffix = config.Suffix or ""
    	self.SaveToConfig = config.SaveToConfig
    	self.Value = config.Default or self.Min
    	
    	if self.SaveToConfig then
    		local saved = Config.Get(self._name)
    		if saved ~= nil then self.Value = saved end
    	end
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Slider_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 52),
    		BackgroundColor3 = Theme.Color("Surface"),
    		BorderSizePixel = 0,
    	})
    	Utility.Corner(frame, 8)
    	Utility.Stroke(frame, Theme.Color("Border"), 1)
    	Utility.Padding(frame, 10, 8)
    	
    	local title = Utility.Create("TextLabel", {
    		Name = "Title",
    		Parent = frame,
    		Size = UDim2.new(0.5, 0, 0, 16),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 14,
    		Font = Enum.Font.GothamMedium,
    		TextXAlignment = Enum.TextXAlignment.Left,
    	})
    	
    	local valLabel = Utility.Create("TextLabel", {
    		Name = "ValueLabel",
    		Parent = frame,
    		Size = UDim2.new(0.5, 0, 0, 16),
    		Position = UDim2.new(0.5, 0, 0, 0),
    		BackgroundTransparency = 1,
    		Text = tostring(self.Value) .. self.Suffix,
    		TextColor3 = Theme.Color("TextSecondary"),
    		TextSize = 13,
    		Font = Enum.Font.Gotham,
    		TextXAlignment = Enum.TextXAlignment.Right,
    	})
    	
    	local track = Utility.Create("Frame", {
    		Name = "Track",
    		Parent = frame,
    		Size = UDim2.new(1, 0, 0, 6),
    		Position = UDim2.new(0, 0, 1, -6),
    		BackgroundColor3 = Theme.Color("Border"),
    	})
    	Utility.Corner(track, 3)
    	
    	local fill = Utility.Create("Frame", {
    		Name = "Fill",
    		Parent = track,
    		Size = UDim2.new(0, 0, 1, 0),
    		BackgroundColor3 = Theme.Color("Accent"),
    	})
    	Utility.Corner(fill, 3)
    	
    	local thumb = Utility.Create("Frame", {
    		Name = "Thumb",
    		Parent = fill,
    		Size = UDim2.new(0, 14, 0, 14),
    		Position = UDim2.new(1, -7, 0.5, -7),
    		BackgroundColor3 = Color3.new(1, 1, 1),
    	})
    	Utility.Corner(thumb, 7)
    	
    	local btn = Utility.Create("TextButton", {
    		Name = "Hitbox",
    		Parent = track,
    		Size = UDim2.new(1, 0, 1, 16),
    		Position = UDim2.new(0, 0, 0.5, -8),
    		BackgroundTransparency = 1,
    		Text = "",
    	})
    	
    	self.Instance = frame
    	self.TitleLabel = title
    	self.ValueLabel = valLabel
    	self.Fill = fill
    	self.Track = track
    	
    	local function updateVisuals()
    		local percent = math.clamp((self.Value - self.Min) / (self.Max - self.Min), 0, 1)
    		self.ValueLabel.Text = tostring(self.Value) .. self.Suffix
    		Utility.Tween(self.Fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
    	end
    	
    	updateVisuals()
    	
    	local dragging = false
    	table.insert(self._connections, btn.InputBegan:Connect(function(input)
    		if not self._enabled or self._locked then return end
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			dragging = true
    			Utility.Tween(thumb, {Size = UDim2.new(0, 16, 0, 16), Position = UDim2.new(1, -8, 0.5, -8)}, 0.1)
    		end
    	end))
    	
    	table.insert(self._connections, UserInputService.InputEnded:Connect(function(input)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			if dragging then
    				dragging = false
    				Utility.Tween(thumb, {Size = UDim2.new(0, 14, 0, 14), Position = UDim2.new(1, -7, 0.5, -7)}, 0.1)
    			end
    		end
    	end))
    	
    	table.insert(self._connections, UserInputService.InputChanged:Connect(function(input)
    		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    			local mousePos = input.Position.X
    			local trackPos = track.AbsolutePosition.X
    			local trackSize = track.AbsoluteSize.X
    			local percent = math.clamp((mousePos - trackPos) / trackSize, 0, 1)
    			
    			local rawValue = self.Min + (percent * (self.Max - self.Min))
    			local snappedValue = math.round(rawValue / self.Step) * self.Step
    			snappedValue = math.clamp(snappedValue, self.Min, self.Max)
    			
    			if self.Value ~= snappedValue then
    				self:SetValue(snappedValue)
    			end
    		end
    	end))
    	
    	if config.Disabled then
    		self:Disable()
    	end
    	
    	return self
    end
    
    function Slider:SetValue(v)
    	if self._locked then return end
    	self.Value = math.clamp(v, self.Min, self.Max)
    	if self.SaveToConfig then
    		Config.Set(self._name, self.Value)
    	end
    	local percent = math.clamp((self.Value - self.Min) / (self.Max - self.Min), 0, 1)
    	self.ValueLabel.Text = tostring(self.Value) .. self.Suffix
    	Utility.Tween(self.Fill, {Size = UDim2.new(percent, 0, 1, 0)}, 0.1)
    	
    	if self._callback then
    		pcall(self._callback, self.Value)
    	end
    end
    
    function Slider:GetValue() return self.Value end
    
    function Slider:Destroy()
    	for _, c in ipairs(self._connections) do c:Disconnect() end
    	self.Instance:Destroy()
    end
    
    function Slider:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Slider:Enable()
    	self._enabled = true
    	self.TitleLabel.TextColor3 = Theme.Color("Text")
    	self.ValueLabel.TextColor3 = Theme.Color("TextSecondary")
    	self.Track.BackgroundColor3 = Theme.Color("Border")
    	self.Fill.BackgroundColor3 = Theme.Color("Accent")
    end
    
    function Slider:Disable()
    	self._enabled = false
    	self.TitleLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.ValueLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.Track.BackgroundColor3 = Theme.Color("Surface")
    	self.Fill.BackgroundColor3 = Theme.Color("Border")
    end
    
    function Slider:Lock() self._locked = true end
    function Slider:Unlock() self._locked = false end
    
    -- =======================================================================
    -- Dropdown
    -- =======================================================================
    local Dropdown = {}
    Dropdown.__index = Dropdown
    
    function Dropdown.new(config)
    	local self = setmetatable(createBaseControl(), Dropdown)
    	self._name = config.Name
    	self._callback = config.Callback
    	self.Options = config.Options or {}
    	self.MultiSelect = config.MultiSelect or false
    	self.Value = config.Default or (self.MultiSelect and {} or self.Options[1] or "")
    	self.SaveToConfig = config.SaveToConfig
    	self.MaxHeight = config.MaxHeight or 180
    	self._open = false
    	
    	if self.SaveToConfig then
    		local saved = Config.Get(self._name)
    		if saved ~= nil then self.Value = saved end
    	end
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Dropdown_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 44),
    		BackgroundColor3 = Theme.Color("Surface"),
    		BorderSizePixel = 0,
    	})
    	Utility.Corner(frame, 8)
    	Utility.Stroke(frame, Theme.Color("Border"), 1)
    	Utility.Padding(frame, 10, 8)
    	
    	local title = Utility.Create("TextLabel", {
    		Name = "Title",
    		Parent = frame,
    		Size = UDim2.new(1, -130, 1, 0),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 14,
    		Font = Enum.Font.GothamMedium,
    		TextXAlignment = Enum.TextXAlignment.Left,
    	})
    	
    	local selectorBtn = Utility.Create("TextButton", {
    		Name = "Selector",
    		Parent = frame,
    		Size = UDim2.new(0, 120, 1, 0),
    		Position = UDim2.new(1, -120, 0, 0),
    		BackgroundColor3 = Theme.Color("SurfaceHover"),
    		Text = "",
    	})
    	Utility.Corner(selectorBtn, 6)
    	Utility.Stroke(selectorBtn, Theme.Color("Border"), 1)
    	
    	local valLabel = Utility.Create("TextLabel", {
    		Name = "ValueLabel",
    		Parent = selectorBtn,
    		Size = UDim2.new(1, -20, 1, 0),
    		Position = UDim2.new(0, 8, 0, 0),
    		BackgroundTransparency = 1,
    		Text = self:GetDisplayValue(),
    		TextColor3 = Theme.Color("TextSecondary"),
    		TextSize = 13,
    		Font = Enum.Font.Gotham,
    		TextXAlignment = Enum.TextXAlignment.Left,
    		TextTruncate = Enum.TextTruncate.AtEnd,
    	})
    	
    	local icon = Utility.Create("TextLabel", {
    		Name = "Icon",
    		Parent = selectorBtn,
    		Size = UDim2.new(0, 20, 1, 0),
    		Position = UDim2.new(1, -20, 0, 0),
    		BackgroundTransparency = 1,
    		Text = "v",
    		TextColor3 = Theme.Color("TextSecondary"),
    		TextSize = 14,
    		Font = Enum.Font.GothamBold,
    	})
    	
    	self.Instance = frame
    	self.TitleLabel = title
    	self.SelectorBtn = selectorBtn
    	self.ValueLabel = valLabel
    	self.Icon = icon
    	
    	-- List Frame
    	local listFrame = Utility.Create("Frame", {
    		Name = "DropdownList",
    		Parent = frame, 
    		Size = UDim2.new(0, 120, 0, 0),
    		Position = UDim2.new(1, -120, 1, 4),
    		BackgroundColor3 = Theme.Color("SurfaceHover"),
    		ZIndex = 10,
    		Visible = false,
    		ClipsDescendants = true,
    	})
    	Utility.Corner(listFrame, 6)
    	Utility.Stroke(listFrame, Theme.Color("Border"), 1)
    	
    	local scrollFrame = Utility.Create("ScrollingFrame", {
    		Name = "Scroll",
    		Parent = listFrame,
    		Size = UDim2.new(1, 0, 1, 0),
    		BackgroundTransparency = 1,
    		ScrollBarThickness = 2,
    		ScrollBarImageColor3 = Theme.Color("Accent"),
    		CanvasSize = UDim2.new(0, 0, 0, 0),
    		ZIndex = 11,
    	})
    	Utility.ListLayout(scrollFrame, Enum.SortOrder.LayoutOrder, UDim.new(0, 2))
    	Utility.Padding(scrollFrame, 4, 4)
    	
    	self.ListFrame = listFrame
    	self.ScrollFrame = scrollFrame
    	
    	table.insert(self._connections, selectorBtn.MouseButton1Click:Connect(function()
    		if not self._enabled or self._locked then return end
    		self:ToggleList()
    	end))
    	
    	-- Close when clicking outside
    	table.insert(self._connections, UserInputService.InputBegan:Connect(function(input)
    		if self._open and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
    			local m = UserInputService:GetMouseLocation()
    			local lPos = listFrame.AbsolutePosition
    			local lSize = listFrame.AbsoluteSize
    			local sPos = selectorBtn.AbsolutePosition
    			local sSize = selectorBtn.AbsoluteSize
    			
    			local inList = (m.X >= lPos.X and m.X <= lPos.X + lSize.X and m.Y >= lPos.Y and m.Y <= lPos.Y + lSize.Y)
    			local inSel = (m.X >= sPos.X and m.X <= sPos.X + sSize.X and m.Y >= sPos.Y and m.Y <= sPos.Y + sSize.Y)
    			
    			if not inList and not inSel then
    				self:CloseList()
    			end
    		end
    	end))
    	
    	self:Refresh(self.Options)
    	
    	if config.Disabled then
    		self:Disable()
    	end
    	
    	return self
    end
    
    function Dropdown:GetDisplayValue()
    	if self.MultiSelect then
    		if type(self.Value) == "table" and #self.Value > 0 then
    			return table.concat(self.Value, ", ")
    		else
    			return "Select..."
    		end
    	else
    		return tostring(self.Value)
    	end
    end
    
    function Dropdown:ToggleList()
    	if self._open then
    		self:CloseList()
    	else
    		self:OpenList()
    	end
    end
    
    function Dropdown:OpenList()
    	self._open = true
    	self.ListFrame.Visible = true
    	local targetHeight = math.min(self.ScrollFrame.UIListLayout.AbsoluteContentSize.Y + 8, self.MaxHeight)
    	Utility.Tween(self.ListFrame, {Size = UDim2.new(0, 120, 0, targetHeight)}, 0.2)
    	Utility.Tween(self.Icon, {Rotation = 180}, 0.2)
    end
    
    function Dropdown:CloseList()
    	self._open = false
    	Utility.Tween(self.ListFrame, {Size = UDim2.new(0, 120, 0, 0)}, 0.2)
    	Utility.Tween(self.Icon, {Rotation = 0}, 0.2)
    	task.delay(0.2, function()
    		if not self._open then self.ListFrame.Visible = false end
    	end)
    end
    
    function Dropdown:Refresh(options)
    	self.Options = options
    	for _, child in ipairs(self.ScrollFrame:GetChildren()) do
    		if child:IsA("TextButton") then child:Destroy() end
    	end
    	
    	for _, opt in ipairs(self.Options) do
    		local btn = Utility.Create("TextButton", {
    			Name = "Opt_" .. tostring(opt),
    			Parent = self.ScrollFrame,
    			Size = UDim2.new(1, 0, 0, 24),
    			BackgroundColor3 = Theme.Color("Surface"),
    			Text = " " .. tostring(opt),
    			TextColor3 = Theme.Color("Text"),
    			TextSize = 13,
    			Font = Enum.Font.Gotham,
    			TextXAlignment = Enum.TextXAlignment.Left,
    			ZIndex = 12,
    		})
    		Utility.Corner(btn, 4)
    		
    		local selected = false
    		if self.MultiSelect then
    			if type(self.Value) == "table" and table.find(self.Value, opt) then selected = true end
    		else
    			if self.Value == opt then selected = true end
    		end
    		
    		if selected then
    			btn.TextColor3 = Theme.Color("Accent")
    		end
    		
    		btn.MouseButton1Click:Connect(function()
    			if self.MultiSelect then
    				local tbl = type(self.Value) == "table" and self.Value or {}
    				local idx = table.find(tbl, opt)
    				if idx then
    					table.remove(tbl, idx)
    					btn.TextColor3 = Theme.Color("Text")
    				else
    					table.insert(tbl, opt)
    					btn.TextColor3 = Theme.Color("Accent")
    				end
    				self:SetValue(tbl)
    			else
    				self:SetValue(opt)
    				self:CloseList()
    			end
    		end)
    	end
    	
    	self.ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, self.ScrollFrame.UIListLayout.AbsoluteContentSize.Y)
    end
    
    function Dropdown:SetValue(v)
    	if self._locked then return end
    	self.Value = v
    	if self.SaveToConfig then Config.Set(self._name, self.Value) end
    	self.ValueLabel.Text = self:GetDisplayValue()
    	
    	if not self.MultiSelect then
    		self:Refresh(self.Options)
    	end
    	
    	if self._callback then
    		pcall(self._callback, self.Value)
    	end
    end
    
    function Dropdown:GetValue() return self.Value end
    
    function Dropdown:Destroy()
    	for _, c in ipairs(self._connections) do c:Disconnect() end
    	self.Instance:Destroy()
    end
    
    function Dropdown:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Dropdown:Enable()
    	self._enabled = true
    	self.TitleLabel.TextColor3 = Theme.Color("Text")
    	self.SelectorBtn.BackgroundColor3 = Theme.Color("SurfaceHover")
    end
    
    function Dropdown:Disable()
    	self._enabled = false
    	self.TitleLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.SelectorBtn.BackgroundColor3 = Theme.Color("Surface")
    end
    
    function Dropdown:Lock() self._locked = true end
    function Dropdown:Unlock() self._locked = false end
    
    -- =======================================================================
    -- Section
    -- =======================================================================
    local Section = {}
    Section.__index = Section
    
    function Section.new(config)
    	local self = setmetatable(createBaseControl(), Section)
    	self._name = config.Name
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Section_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 32),
    		BackgroundTransparency = 1,
    	})
    	
    	local label = Utility.Create("TextLabel", {
    		Name = "Label",
    		Parent = frame,
    		Size = UDim2.new(1, 0, 1, 0),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("TextSecondary"),
    		TextSize = 11,
    		Font = Enum.Font.GothamBold,
    	})
    	
    	local lineL = Utility.Create("Frame", {
    		Name = "LineL",
    		Parent = frame,
    		Size = UDim2.new(0.5, -40, 0, 1),
    		Position = UDim2.new(0, 0, 0.5, 0),
    		BackgroundColor3 = Theme.Color("Border"),
    		BorderSizePixel = 0,
    	})
    	
    	local lineR = Utility.Create("Frame", {
    		Name = "LineR",
    		Parent = frame,
    		Size = UDim2.new(0.5, -40, 0, 1),
    		Position = UDim2.new(0.5, 40, 0.5, 0),
    		BackgroundColor3 = Theme.Color("Border"),
    		BorderSizePixel = 0,
    	})
    	
    	self.Instance = frame
    	self.Label = label
    	
    	return self
    end
    
    function Section:SetValue(v) end
    function Section:GetValue() return nil end
    
    function Section:Destroy()
    	self.Instance:Destroy()
    end
    
    function Section:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Section:Enable() end
    function Section:Disable() end
    function Section:Lock() end
    function Section:Unlock() end
    
    -- =======================================================================
    -- Separator
    -- =======================================================================
    local Separator = {}
    Separator.__index = Separator
    
    function Separator.new(config)
    	local self = setmetatable(createBaseControl(), Separator)
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Separator",
    		Size = UDim2.new(1, 0, 0, 20),
    		BackgroundTransparency = 1,
    	})
    	
    	local line = Utility.Create("Frame", {
    		Parent = frame,
    		Size = UDim2.new(1, 0, 0, 1),
    		Position = UDim2.new(0, 0, 0.5, 0),
    		BackgroundColor3 = Theme.Color("Border"),
    		BorderSizePixel = 0,
    	})
    	
    	self.Instance = frame
    	
    	return self
    end
    
    function Separator:SetValue(v) end
    function Separator:GetValue() return nil end
    
    function Separator:Destroy()
    	self.Instance:Destroy()
    end
    
    function Separator:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Separator:Enable() end
    function Separator:Disable() end
    function Separator:Lock() end
    function Separator:Unlock() end
    
    -- =======================================================================
    -- Textbox
    -- =======================================================================
    local Textbox = {}
    Textbox.__index = Textbox
    
    function Textbox.new(config)
    	local self = setmetatable(createBaseControl(), Textbox)
    	self._name = config.Name
    	self._callback = config.Callback
    	self.SaveToConfig = config.SaveToConfig
    	self.Value = config.Default or ""
    	
    	if self.SaveToConfig then
    		local saved = Config.Get(self._name)
    		if saved ~= nil then self.Value = saved end
    	end
    	
    	local frame = Utility.Create("Frame", {
    		Name = "Textbox_" .. config.Name,
    		Size = UDim2.new(1, 0, 0, 60),
    		BackgroundColor3 = Theme.Color("Surface"),
    		BorderSizePixel = 0,
    	})
    	Utility.Corner(frame, 8)
    	Utility.Stroke(frame, Theme.Color("Border"), 1)
    	Utility.Padding(frame, 10, 8)
    	
    	local title = Utility.Create("TextLabel", {
    		Name = "Title",
    		Parent = frame,
    		Size = UDim2.new(1, 0, 0, 16),
    		BackgroundTransparency = 1,
    		Text = config.Name,
    		TextColor3 = Theme.Color("Text"),
    		TextSize = 14,
    		Font = Enum.Font.GothamMedium,
    		TextXAlignment = Enum.TextXAlignment.Left,
    	})
    	
    	local inputBg = Utility.Create("Frame", {
    		Name = "InputBg",
    		Parent = frame,
    		Size = UDim2.new(1, 0, 0, 24),
    		Position = UDim2.new(0, 0, 1, -24),
    		BackgroundColor3 = Theme.Color("SurfaceHover"),
    	})
    	Utility.Corner(inputBg, 4)
    	local stroke = Utility.Stroke(inputBg, Theme.Color("Border"), 1)
    	
    	local input = Utility.Create("TextBox", {
    		Name = "Input",
    		Parent = inputBg,
    		Size = UDim2.new(1, -12, 1, 0),
    		Position = UDim2.new(0, 6, 0, 0),
    		BackgroundTransparency = 1,
    		Text = self.Value,
    		PlaceholderText = config.Placeholder or "Enter text...",
    		TextColor3 = Theme.Color("Text"),
    		PlaceholderColor3 = Theme.Color("TextDisabled"),
    		TextSize = 13,
    		Font = Enum.Font.Gotham,
    		TextXAlignment = Enum.TextXAlignment.Left,
    		ClearTextOnFocus = config.ClearOnFocus or false,
    	})
    	
    	self.Instance = frame
    	self.TitleLabel = title
    	self.Input = input
    	self.Stroke = stroke
    	
    	table.insert(self._connections, input.Focused:Connect(function()
    		if not self._enabled or self._locked then 
    			input:ReleaseFocus()
    			return 
    		end
    		Utility.Tween(stroke, {Color = Theme.Color("Accent")}, 0.2)
    	end))
    	
    	table.insert(self._connections, input.FocusLost:Connect(function()
    		Utility.Tween(stroke, {Color = Theme.Color("Border")}, 0.2)
    		self:SetValue(input.Text)
    	end))
    	
    	if config.Disabled then
    		self:Disable()
    	end
    	
    	return self
    end
    
    function Textbox:SetValue(v)
    	if self._locked then return end
    	self.Value = tostring(v)
    	self.Input.Text = self.Value
    	if self.SaveToConfig then Config.Set(self._name, self.Value) end
    	if self._callback then
    		pcall(self._callback, self.Value)
    	end
    end
    
    function Textbox:GetValue() return self.Value end
    
    function Textbox:Destroy()
    	for _, c in ipairs(self._connections) do c:Disconnect() end
    	self.Instance:Destroy()
    end
    
    function Textbox:SetVisible(bool)
    	self._visible = bool
    	self.Instance.Visible = bool
    end
    
    function Textbox:Enable()
    	self._enabled = true
    	self.TitleLabel.TextColor3 = Theme.Color("Text")
    	self.Input.TextEditable = true
    	self.Input.TextColor3 = Theme.Color("Text")
    end
    
    function Textbox:Disable()
    	self._enabled = false
    	self.TitleLabel.TextColor3 = Theme.Color("TextDisabled")
    	self.Input.TextEditable = false
    	self.Input.TextColor3 = Theme.Color("TextDisabled")
    end
    
    function Textbox:Lock() self._locked = true end
    function Textbox:Unlock() self._locked = false end
    
    Controls.Button = Button
    Controls.Toggle = Toggle
    Controls.Slider = Slider
    Controls.Dropdown = Dropdown
    Controls.Section = Section
    Controls.Separator = Separator
    Controls.Textbox = Textbox
    
    return Controls
    
end)()

DisplayControls = (function()
    
    local Utility = Utility
    local Theme = Theme
    local Types = Types
    
    local TweenService = game:GetService("TweenService")
    
    local DisplayControls = {}
    
    --------------------------------------------------------------------------------
    -- Label
    --------------------------------------------------------------------------------
    local Label = {}
    Label.__index = Label
    
    function Label.new(config: any)
        local self = setmetatable({}, Label)
        self._name = config.Text or ""
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "Label"
        container.Size = UDim2.new(1, 0, 0, 36)
        container.BackgroundTransparency = 1
        container.Visible = config.Visible ~= false
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Text"
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Position = UDim2.new(0, 0, 0, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = self._name
        textLabel.TextColor3 = Theme.Text
        textLabel.TextSize = config.TextSize or 13
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.Parent = container
        
        self.Instance = container
        self.TextLabel = textLabel
        self.Value = self._name
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function Label:SetValue(text: string)
        self.Value = text
        self.TextLabel.Text = text
        self._name = text
    end
    
    function Label:GetValue()
        return self.Value
    end
    
    function Label:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function Label:Enable()
        -- No interaction to enable
    end
    
    function Label:Disable()
        -- No interaction to disable
    end
    
    function Label:Lock()
        -- No interaction to lock
    end
    
    function Label:Unlock()
        -- No interaction to unlock
    end
    
    function Label:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.Label = Label
    
    --------------------------------------------------------------------------------
    -- Paragraph
    --------------------------------------------------------------------------------
    local Paragraph = {}
    Paragraph.__index = Paragraph
    
    function Paragraph.new(config: any)
        local self = setmetatable({}, Paragraph)
        self._name = config.Title or ""
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "Paragraph"
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundColor3 = Theme.Surface
        container.Visible = config.Visible ~= false
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = container
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 10)
        padding.PaddingBottom = UDim.new(0, 10)
        padding.PaddingLeft = UDim.new(0, 10)
        padding.PaddingRight = UDim.new(0, 10)
        padding.Parent = container
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)
        layout.Parent = container
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, 0, 0, 16)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = config.Title or ""
        titleLabel.TextColor3 = Theme.Text
        titleLabel.TextSize = 13
        titleLabel.Font = Enum.Font.GothamBold
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.LayoutOrder = 1
        titleLabel.Parent = container
        
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, 0, 0, 0)
        contentLabel.AutomaticSize = Enum.AutomaticSize.Y
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = config.Content or ""
        contentLabel.TextColor3 = Theme.SecondaryText
        contentLabel.TextSize = 12
        contentLabel.Font = Enum.Font.Gotham
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextWrapped = true
        contentLabel.LayoutOrder = 2
        contentLabel.Parent = container
        
        self.Instance = container
        self.TitleLabel = titleLabel
        self.ContentLabel = contentLabel
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function Paragraph:SetValue(value: any)
        if typeof(value) == "table" then
            if value.Title then
                self.TitleLabel.Text = value.Title
                self._name = value.Title
            end
            if value.Content then
                self.ContentLabel.Text = value.Content
            end
        end
    end
    
    function Paragraph:GetValue()
        return { Title = self.TitleLabel.Text, Content = self.ContentLabel.Text }
    end
    
    function Paragraph:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function Paragraph:Enable()
    end
    
    function Paragraph:Disable()
    end
    
    function Paragraph:Lock()
    end
    
    function Paragraph:Unlock()
    end
    
    function Paragraph:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.Paragraph = Paragraph
    
    --------------------------------------------------------------------------------
    -- ProgressBar
    --------------------------------------------------------------------------------
    local ProgressBar = {}
    ProgressBar.__index = ProgressBar
    
    function ProgressBar.new(config: any)
        local self = setmetatable({}, ProgressBar)
        self._name = config.Name or ""
        self.Max = config.Max or 100
        self.Suffix = config.Suffix or "%"
        self.Value = config.Default or 0
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "ProgressBar"
        container.Size = UDim2.new(1, 0, 0, 44)
        container.BackgroundTransparency = 1
        container.Visible = config.Visible ~= false
        
        local headerFrame = Instance.new("Frame")
        headerFrame.Name = "Header"
        headerFrame.Size = UDim2.new(1, 0, 0, 20)
        headerFrame.BackgroundTransparency = 1
        headerFrame.Parent = container
        
        local nameLabel = Instance.new("TextLabel")
        nameLabel.Name = "NameLabel"
        nameLabel.Size = UDim2.new(0.5, 0, 1, 0)
        nameLabel.Position = UDim2.new(0, 0, 0, 0)
        nameLabel.BackgroundTransparency = 1
        nameLabel.Text = self._name
        nameLabel.TextColor3 = Theme.Text
        nameLabel.TextSize = 13
        nameLabel.Font = Enum.Font.Gotham
        nameLabel.TextXAlignment = Enum.TextXAlignment.Left
        nameLabel.Parent = headerFrame
        
        local valueLabel = Instance.new("TextLabel")
        valueLabel.Name = "ValueLabel"
        valueLabel.Size = UDim2.new(0.5, 0, 1, 0)
        valueLabel.Position = UDim2.new(0.5, 0, 0, 0)
        valueLabel.BackgroundTransparency = 1
        valueLabel.Text = tostring(self.Value) .. self.Suffix
        valueLabel.TextColor3 = Theme.SecondaryText
        valueLabel.TextSize = 13
        valueLabel.Font = Enum.Font.Gotham
        valueLabel.TextXAlignment = Enum.TextXAlignment.Right
        valueLabel.Parent = headerFrame
        
        local track = Instance.new("Frame")
        track.Name = "Track"
        track.Size = UDim2.new(1, 0, 0, 8)
        track.Position = UDim2.new(0, 0, 0, 28)
        track.BackgroundColor3 = Theme.Border
        track.Parent = container
        
        local trackCorner = Instance.new("UICorner")
        trackCorner.CornerRadius = UDim.new(0, 4)
        trackCorner.Parent = track
        
        local fill = Instance.new("Frame")
        fill.Name = "Fill"
        local fillWidth = 0
        if self.Max > 0 then
            fillWidth = math.clamp(self.Value / self.Max, 0, 1)
        end
        fill.Size = UDim2.new(fillWidth, 0, 1, 0)
        fill.BackgroundColor3 = Color3.new(1, 1, 1) -- Gradient handles color
        fill.Parent = track
        
        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(0, 4)
        fillCorner.Parent = fill
        
        local baseColor = config.Color or Theme.Accent
        local h, s, v = baseColor:ToHSV()
        local lighter = Color3.fromHSV(h, math.clamp(s - 0.2, 0, 1), math.clamp(v + 0.2, 0, 1))
        local darker = Color3.fromHSV(h, math.clamp(s + 0.1, 0, 1), math.clamp(v - 0.1, 0, 1))
        
        local gradient = Instance.new("UIGradient")
        gradient.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, lighter),
            ColorSequenceKeypoint.new(1, darker)
        })
        gradient.Parent = fill
        
        self.Instance = container
        self.ValueLabel = valueLabel
        self.Fill = fill
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function ProgressBar:SetValue(value: number)
        self.Value = math.clamp(value, 0, self.Max)
        self.ValueLabel.Text = tostring(math.floor(self.Value)) .. self.Suffix
        
        local targetWidth = 0
        if self.Max > 0 then
            targetWidth = self.Value / self.Max
        end
        
        local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local tween = TweenService:Create(self.Fill, tweenInfo, { Size = UDim2.new(targetWidth, 0, 1, 0) })
        tween:Play()
    end
    
    function ProgressBar:GetValue()
        return self.Value
    end
    
    function ProgressBar:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function ProgressBar:Enable()
    end
    
    function ProgressBar:Disable()
    end
    
    function ProgressBar:Lock()
    end
    
    function ProgressBar:Unlock()
    end
    
    function ProgressBar:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.ProgressBar = ProgressBar
    
    --------------------------------------------------------------------------------
    -- Image
    --------------------------------------------------------------------------------
    local Image = {}
    Image.__index = Image
    
    function Image.new(config: any)
        local self = setmetatable({}, Image)
        self._name = "Image"
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "ImageContainer"
        container.Size = config.Size or UDim2.new(1, 0, 0, 150)
        container.BackgroundTransparency = 1
        container.Visible = config.Visible ~= false
        
        local imageLabel = Instance.new("ImageLabel")
        imageLabel.Name = "Image"
        imageLabel.Size = UDim2.new(1, 0, 1, 0)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = config.Image or ""
        imageLabel.ScaleType = Enum.ScaleType.Fit
        imageLabel.Parent = container
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = imageLabel
        
        if config.AspectRatio then
            local ratio = Instance.new("UIAspectRatioConstraint")
            ratio.AspectRatio = config.AspectRatio
            ratio.Parent = imageLabel
        end
        
        self.Instance = container
        self.ImageLabel = imageLabel
        self.Value = config.Image or ""
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function Image:SetValue(imageId: string)
        self.Value = imageId
        self.ImageLabel.Image = imageId
    end
    
    function Image:GetValue()
        return self.Value
    end
    
    function Image:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function Image:Enable()
    end
    
    function Image:Disable()
    end
    
    function Image:Lock()
    end
    
    function Image:Unlock()
    end
    
    function Image:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.Image = Image
    
    --------------------------------------------------------------------------------
    -- CodeBlock
    --------------------------------------------------------------------------------
    local CodeBlock = {}
    CodeBlock.__index = CodeBlock
    
    function CodeBlock.new(config: any)
        local self = setmetatable({}, CodeBlock)
        self._name = config.Title or ""
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "CodeBlock"
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundColor3 = Color3.fromRGB(20, 20, 22) -- #141416
        container.Visible = config.Visible ~= false
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = container
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 12)
        padding.PaddingBottom = UDim.new(0, 12)
        padding.PaddingLeft = UDim.new(0, 12)
        padding.PaddingRight = UDim.new(0, 12)
        padding.Parent = container
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 8)
        layout.Parent = container
        
        local headerFrame = Instance.new("Frame")
        headerFrame.Name = "Header"
        headerFrame.Size = UDim2.new(1, 0, 0, 20)
        headerFrame.BackgroundTransparency = 1
        headerFrame.LayoutOrder = 1
        headerFrame.Parent = container
        
        local titleLabel = Instance.new("TextLabel")
        titleLabel.Name = "Title"
        titleLabel.Size = UDim2.new(1, -30, 1, 0)
        titleLabel.BackgroundTransparency = 1
        titleLabel.Text = self._name
        titleLabel.TextColor3 = Theme.SecondaryText
        titleLabel.TextSize = 12
        titleLabel.Font = Enum.Font.Gotham
        titleLabel.TextXAlignment = Enum.TextXAlignment.Left
        titleLabel.Parent = headerFrame
        
        local copyBtn = Instance.new("TextButton")
        copyBtn.Name = "CopyBtn"
        copyBtn.Size = UDim2.new(0, 20, 0, 20)
        copyBtn.Position = UDim2.new(1, -20, 0, 0)
        copyBtn.BackgroundTransparency = 1
        copyBtn.Text = "C" -- Would normally be an icon, using text for fallback
        copyBtn.TextColor3 = Theme.Accent
        copyBtn.TextSize = 14
        copyBtn.Font = Enum.Font.GothamBold
        copyBtn.Parent = headerFrame
        
        local scroll = Instance.new("ScrollingFrame")
        scroll.Name = "Scroll"
        scroll.Size = UDim2.new(1, 0, 0, 100) -- Will adjust based on content
        scroll.BackgroundTransparency = 1
        scroll.ScrollBarThickness = 4
        scroll.ScrollBarImageColor3 = Theme.Border
        scroll.BorderSizePixel = 0
        scroll.LayoutOrder = 2
        scroll.Parent = container
        
        local contentLabel = Instance.new("TextLabel")
        contentLabel.Name = "Content"
        contentLabel.Size = UDim2.new(1, -10, 0, 0)
        contentLabel.AutomaticSize = Enum.AutomaticSize.Y
        contentLabel.BackgroundTransparency = 1
        contentLabel.Text = config.Code or ""
        contentLabel.TextColor3 = Theme.Text
        contentLabel.TextSize = 12
        contentLabel.Font = Enum.Font.Code
        contentLabel.TextXAlignment = Enum.TextXAlignment.Left
        contentLabel.TextYAlignment = Enum.TextYAlignment.Top
        contentLabel.TextWrapped = true
        contentLabel.Parent = scroll
        
        -- Adjust scroll size based on content
        table.insert(self.Connections, contentLabel:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
            local y = math.min(contentLabel.AbsoluteSize.Y, 300)
            scroll.Size = UDim2.new(1, 0, 0, y)
            scroll.CanvasSize = UDim2.new(0, 0, 0, contentLabel.AbsoluteSize.Y)
        end))
        
        self.Instance = container
        self.ContentLabel = contentLabel
        self.Value = config.Code or ""
        
        table.insert(self.Connections, copyBtn.MouseButton1Click:Connect(function()
            pcall(function()
                if setclipboard then
                    setclipboard(self.Value)
                end
            end)
        end))
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function CodeBlock:SetValue(code: string)
        self.Value = code
        self.ContentLabel.Text = code
    end
    
    function CodeBlock:GetValue()
        return self.Value
    end
    
    function CodeBlock:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function CodeBlock:Enable()
    end
    
    function CodeBlock:Disable()
    end
    
    function CodeBlock:Lock()
    end
    
    function CodeBlock:Unlock()
    end
    
    function CodeBlock:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.CodeBlock = CodeBlock
    
    --------------------------------------------------------------------------------
    -- RichText
    --------------------------------------------------------------------------------
    local RichText = {}
    RichText.__index = RichText
    
    function RichText.new(config: any)
        local self = setmetatable({}, RichText)
        self._name = "RichText"
        self.Connections = {}
        
        local container = Instance.new("Frame")
        container.Name = "RichTextContainer"
        container.Size = UDim2.new(1, 0, 0, 0)
        container.AutomaticSize = Enum.AutomaticSize.Y
        container.BackgroundTransparency = 1
        container.Visible = config.Visible ~= false
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Name = "Text"
        textLabel.Size = UDim2.new(1, 0, 0, 0)
        textLabel.AutomaticSize = Enum.AutomaticSize.Y
        textLabel.BackgroundTransparency = 1
        textLabel.RichText = true
        textLabel.Text = config.Text or ""
        textLabel.TextColor3 = Theme.Text
        textLabel.TextSize = 13
        textLabel.Font = Enum.Font.Gotham
        textLabel.TextXAlignment = Enum.TextXAlignment.Left
        textLabel.TextWrapped = true
        textLabel.Parent = container
        
        self.Instance = container
        self.TextLabel = textLabel
        self.Value = config.Text or ""
        
        if config.Tooltip then
            Utility:AddTooltip(self.Instance, config.Tooltip)
        end
        
        return self
    end
    
    function RichText:SetValue(richText: string)
        self.Value = richText
        self.TextLabel.Text = richText
    end
    
    function RichText:GetValue()
        return self.Value
    end
    
    function RichText:SetVisible(visible: boolean)
        self.Instance.Visible = visible
    end
    
    function RichText:Enable()
    end
    
    function RichText:Disable()
    end
    
    function RichText:Lock()
    end
    
    function RichText:Unlock()
    end
    
    function RichText:Destroy()
        for _, conn in pairs(self.Connections) do
            conn:Disconnect()
        end
        self.Instance:Destroy()
    end
    
    DisplayControls.RichText = RichText
    
    return DisplayControls
    
end)()

InputControls = (function()
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    
    local Core = script.Parent.Parent.Parent.Core
    local Utility = Utility :: any
    local Theme = Theme :: any
    local Config = Config :: any
    
    local InputControls = {}
    
    --------------------------------------------------------------------------------
    -- ColorPicker
    --------------------------------------------------------------------------------
    local ColorPicker = {}
    ColorPicker.__index = ColorPicker
    
    function ColorPicker.new(config: any)
    	local self = setmetatable({}, ColorPicker)
    	self._name = config.Name
    	self._callback = config.Callback
    	self._value = config.Default or Color3.new(1, 1, 1)
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._saveToConfig = config.SaveToConfig
    	self._expanded = false
    
    	local hue, sat, val = Color3.toHSV(self._value)
    	self._hue = hue
    	self._sat = sat
    	self._val = val
    
    	local container = Instance.new("Frame")
    	container.Name = "ColorPicker_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32)
    	self.Container = container
    
    	local row = Instance.new("Frame")
    	row.Name = "Row"
    	row.BackgroundTransparency = 1
    	row.Size = UDim2.new(1, 0, 0, 32)
    	row.Parent = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Size = UDim2.new(1, -50, 1, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.Parent = row
    	self.Label = label
    
    	local preview = Instance.new("TextButton")
    	preview.Name = "Preview"
    	preview.BackgroundColor3 = self._value
    	preview.Position = UDim2.new(1, -34, 0.5, -12)
    	preview.Size = UDim2.new(0, 24, 0, 24)
    	preview.Text = ""
    	preview.Parent = row
    	local previewCorner = Instance.new("UICorner")
    	previewCorner.CornerRadius = UDim.new(0, 4)
    	previewCorner.Parent = preview
    	local previewStroke = Instance.new("UIStroke")
    	previewStroke.Color = Color3.fromHex("#2E2E33")
    	previewStroke.Parent = preview
    	self.Preview = preview
    
    	local panel = Instance.new("Frame")
    	panel.Name = "Panel"
    	panel.BackgroundColor3 = Color3.fromHex("#1E1E21")
    	panel.Position = UDim2.new(0, 0, 0, 36)
    	panel.Size = UDim2.new(1, 0, 0, 220)
    	panel.Visible = false
    	panel.ClipsDescendants = true
    	panel.Parent = container
    	local panelCorner = Instance.new("UICorner")
    	panelCorner.CornerRadius = UDim.new(0, 6)
    	panelCorner.Parent = panel
    	local panelStroke = Instance.new("UIStroke")
    	panelStroke.Color = Color3.fromHex("#2E2E33")
    	panelStroke.Parent = panel
    	self.Panel = panel
    
    	-- Saturation/Value Picker
    	local svPicker = Instance.new("TextButton")
    	svPicker.Name = "SVPicker"
    	svPicker.BackgroundColor3 = Color3.fromHSV(self._hue, 1, 1)
    	svPicker.Position = UDim2.new(0, 10, 0, 10)
    	svPicker.Size = UDim2.new(1, -20, 0, 120)
    	svPicker.Text = ""
    	svPicker.AutoButtonColor = false
    	svPicker.Parent = panel
    	local svCorner = Instance.new("UICorner")
    	svCorner.CornerRadius = UDim.new(0, 4)
    	svCorner.Parent = svPicker
    	
    	local whiteGrad = Instance.new("UIGradient")
    	whiteGrad.Color = ColorSequence.new(Color3.new(1,1,1), Color3.new(1,1,1))
    	whiteGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)})
    	whiteGrad.Parent = svPicker
    
    	local blackOverlay = Instance.new("Frame")
    	blackOverlay.BackgroundColor3 = Color3.new(1, 1, 1)
    	blackOverlay.Size = UDim2.new(1, 0, 1, 0)
    	blackOverlay.BackgroundTransparency = 0
    	blackOverlay.Parent = svPicker
    	local boCorner = Instance.new("UICorner")
    	boCorner.CornerRadius = UDim.new(0, 4)
    	boCorner.Parent = blackOverlay
    	local blackGrad = Instance.new("UIGradient")
    	blackGrad.Color = ColorSequence.new(Color3.new(0,0,0), Color3.new(0,0,0))
    	blackGrad.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
    	blackGrad.Rotation = 90
    	blackGrad.Parent = blackOverlay
    
    	local svCursor = Instance.new("Frame")
    	svCursor.Size = UDim2.new(0, 8, 0, 8)
    	svCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    	svCursor.Position = UDim2.new(self._sat, 0, 1 - self._val, 0)
    	svCursor.BackgroundColor3 = Color3.new(1,1,1)
    	svCursor.Parent = svPicker
    	local curCorner = Instance.new("UICorner")
    	curCorner.CornerRadius = UDim.new(1, 0)
    	curCorner.Parent = svCursor
    	local curStroke = Instance.new("UIStroke")
    	curStroke.Color = Color3.new(0,0,0)
    	curStroke.Parent = svCursor
    
    	self.SVPicker = svPicker
    	self.SVCursor = svCursor
    
    	-- Hue Slider
    	local hueSlider = Instance.new("TextButton")
    	hueSlider.Name = "HueSlider"
    	hueSlider.BackgroundColor3 = Color3.new(1,1,1)
    	hueSlider.Position = UDim2.new(0, 10, 0, 140)
    	hueSlider.Size = UDim2.new(1, -20, 0, 12)
    	hueSlider.Text = ""
    	hueSlider.AutoButtonColor = false
    	hueSlider.Parent = panel
    	local hueCorner = Instance.new("UICorner")
    	hueCorner.CornerRadius = UDim.new(0, 4)
    	hueCorner.Parent = hueSlider
    	local hueGrad = Instance.new("UIGradient")
    	hueGrad.Color = ColorSequence.new({
    		ColorSequenceKeypoint.new(0, Color3.new(1,0,0)),
    		ColorSequenceKeypoint.new(0.167, Color3.new(1,1,0)),
    		ColorSequenceKeypoint.new(0.333, Color3.new(0,1,0)),
    		ColorSequenceKeypoint.new(0.5, Color3.new(0,1,1)),
    		ColorSequenceKeypoint.new(0.667, Color3.new(0,0,1)),
    		ColorSequenceKeypoint.new(0.833, Color3.new(1,0,1)),
    		ColorSequenceKeypoint.new(1, Color3.new(1,0,0))
    	})
    	hueGrad.Parent = hueSlider
    
    	local hueCursor = Instance.new("Frame")
    	hueCursor.Size = UDim2.new(0, 4, 1, 4)
    	hueCursor.AnchorPoint = Vector2.new(0.5, 0.5)
    	hueCursor.Position = UDim2.new(self._hue, 0, 0.5, 0)
    	hueCursor.BackgroundColor3 = Color3.new(1,1,1)
    	hueCursor.Parent = hueSlider
    	local hcurStroke = Instance.new("UIStroke")
    	hcurStroke.Color = Color3.new(0,0,0)
    	hcurStroke.Parent = hueCursor
    
    	self.HueSlider = hueSlider
    	self.HueCursor = hueCursor
    
    	-- Hex/RGB Inputs & OK
    	local inputsFrame = Instance.new("Frame")
    	inputsFrame.BackgroundTransparency = 1
    	inputsFrame.Position = UDim2.new(0, 10, 0, 162)
    	inputsFrame.Size = UDim2.new(1, -20, 0, 24)
    	inputsFrame.Parent = panel
    
    	local hexInput = Instance.new("TextBox")
    	hexInput.Size = UDim2.new(0.6, -5, 1, 0)
    	hexInput.BackgroundColor3 = Color3.fromHex("#151515")
    	hexInput.TextColor3 = Color3.fromHex("#F0F0F5")
    	hexInput.Font = Enum.Font.Gotham
    	hexInput.TextSize = 12
    	hexInput.Text = self._value:ToHex()
    	hexInput.Parent = inputsFrame
    	local hexCorner = Instance.new("UICorner")
    	hexCorner.CornerRadius = UDim.new(0, 4)
    	hexCorner.Parent = hexInput
    
    	local okButton = Instance.new("TextButton")
    	okButton.Size = UDim2.new(0.4, -5, 1, 0)
    	okButton.Position = UDim2.new(0.6, 5, 0, 0)
    	okButton.BackgroundColor3 = Color3.fromHex("#7C5CBF")
    	okButton.TextColor3 = Color3.fromHex("#F0F0F5")
    	okButton.Font = Enum.Font.GothamMedium
    	okButton.TextSize = 12
    	okButton.Text = "OK"
    	okButton.Parent = inputsFrame
    	local okCorner = Instance.new("UICorner")
    	okCorner.CornerRadius = UDim.new(0, 4)
    	okCorner.Parent = okButton
    	
    	self.HexInput = hexInput
    	self.OKButton = okButton
    
    	self:_setupConnections()
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function ColorPicker:_setupConnections()
    	table.insert(self._connections, self.Preview.MouseButton1Click:Connect(function()
    		if self._disabled or self._locked then return end
    		self._expanded = not self._expanded
    		self.Container.Size = self._expanded and UDim2.new(1, 0, 0, 260) or UDim2.new(1, 0, 0, 32)
    		self.Panel.Visible = self._expanded
    	end))
    
    	local draggingSV = false
    	local draggingHue = false
    
    	table.insert(self._connections, self.SVPicker.InputBegan:Connect(function(input)
    		if self._disabled or self._locked then return end
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			draggingSV = true
    			self:_updateSV(input.Position)
    		end
    	end))
    
    	table.insert(self._connections, self.HueSlider.InputBegan:Connect(function(input)
    		if self._disabled or self._locked then return end
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			draggingHue = true
    			self:_updateHue(input.Position)
    		end
    	end))
    
    	table.insert(self._connections, UserInputService.InputChanged:Connect(function(input)
    		if draggingSV and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    			self:_updateSV(input.Position)
    		elseif draggingHue and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
    			self:_updateHue(input.Position)
    		end
    	end))
    
    	table.insert(self._connections, UserInputService.InputEnded:Connect(function(input)
    		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
    			draggingSV = false
    			draggingHue = false
    		end
    	end))
    
    	table.insert(self._connections, self.HexInput.FocusLost:Connect(function()
    		local text = self.HexInput.Text
    		local success, result = pcall(function()
    			return Color3.fromHex(text)
    		end)
    		if success and result then
    			self:SetValue(result)
    		else
    			self.HexInput.Text = self._value:ToHex()
    		end
    	end))
    
    	table.insert(self._connections, self.OKButton.MouseButton1Click:Connect(function()
    		if self._disabled or self._locked then return end
    		self._expanded = false
    		self.Container.Size = UDim2.new(1, 0, 0, 32)
    		self.Panel.Visible = false
    		if self._callback then
    			self._callback(self._value)
    		end
    		if self._saveToConfig and Config then
    			Config:Set(self._name, self._value)
    		end
    	end))
    end
    
    function ColorPicker:_updateSV(inputPos: Vector3)
    	local absolutePos = self.SVPicker.AbsolutePosition
    	local absoluteSize = self.SVPicker.AbsoluteSize
    	local relX = math.clamp((inputPos.X - absolutePos.X) / absoluteSize.X, 0, 1)
    	local relY = math.clamp((inputPos.Y - absolutePos.Y) / absoluteSize.Y, 0, 1)
    
    	self._sat = relX
    	self._val = 1 - relY
    	self.SVCursor.Position = UDim2.new(relX, 0, relY, 0)
    	
    	self:_updateInternalColor()
    end
    
    function ColorPicker:_updateHue(inputPos: Vector3)
    	local absolutePos = self.HueSlider.AbsolutePosition
    	local absoluteSize = self.HueSlider.AbsoluteSize
    	local relX = math.clamp((inputPos.X - absolutePos.X) / absoluteSize.X, 0, 1)
    
    	self._hue = relX
    	self.HueCursor.Position = UDim2.new(relX, 0, 0.5, 0)
    	self.SVPicker.BackgroundColor3 = Color3.fromHSV(self._hue, 1, 1)
    	
    	self:_updateInternalColor()
    end
    
    function ColorPicker:_updateInternalColor()
    	local color = Color3.fromHSV(self._hue, self._sat, self._val)
    	self._value = color
    	self.Preview.BackgroundColor3 = color
    	self.HexInput.Text = color:ToHex()
    end
    
    function ColorPicker:SetValue(color: Color3)
    	self._value = color
    	local h, s, v = Color3.toHSV(color)
    	self._hue = h
    	self._sat = s
    	self._val = v
    
    	self.Preview.BackgroundColor3 = color
    	self.HexInput.Text = color:ToHex()
    	self.SVCursor.Position = UDim2.new(s, 0, 1 - v, 0)
    	self.HueCursor.Position = UDim2.new(h, 0, 0.5, 0)
    	self.SVPicker.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
    
    	if self._callback then
    		self._callback(self._value)
    	end
    end
    
    function ColorPicker:GetValue()
    	return self._value
    end
    
    function ColorPicker:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function ColorPicker:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	self.Preview.BackgroundTransparency = 0
    end
    
    function ColorPicker:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	self.Preview.BackgroundTransparency = 0.5
    end
    
    function ColorPicker:Lock()
    	self._locked = true
    end
    
    function ColorPicker:Unlock()
    	self._locked = false
    end
    
    function ColorPicker:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Keybind
    --------------------------------------------------------------------------------
    local Keybind = {}
    Keybind.__index = Keybind
    
    function Keybind.new(config: any)
    	local self = setmetatable({}, Keybind)
    	self._name = config.Name
    	self._callback = config.Callback
    	self._value = config.Default or Enum.KeyCode.F
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._saveToConfig = config.SaveToConfig
    	self._listening = false
    
    	local container = Instance.new("Frame")
    	container.Name = "Keybind_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32)
    	self.Container = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Size = UDim2.new(1, -120, 1, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.Parent = container
    	self.Label = label
    
    	local button = Instance.new("TextButton")
    	button.Name = "Button"
    	button.BackgroundColor3 = Color3.fromHex("#1E1E21")
    	button.Position = UDim2.new(1, -100, 0.5, -12)
    	button.Size = UDim2.new(0, 90, 0, 24)
    	button.Font = Enum.Font.Gotham
    	button.TextSize = 12
    	button.TextColor3 = Color3.fromHex("#F0F0F5")
    	button.Text = self._value.Name
    	button.Parent = container
    	local buttonCorner = Instance.new("UICorner")
    	buttonCorner.CornerRadius = UDim.new(0, 4)
    	buttonCorner.Parent = button
    	local buttonStroke = Instance.new("UIStroke")
    	buttonStroke.Color = Color3.fromHex("#2E2E33")
    	buttonStroke.Parent = button
    	self.Button = button
    
    	self:_setupConnections()
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function Keybind:_setupConnections()
    	table.insert(self._connections, self.Button.MouseButton1Click:Connect(function()
    		if self._disabled or self._locked then return end
    		self._listening = true
    		self.Button.Text = "..."
    		self.Button.TextColor3 = Color3.fromHex("#7C5CBF")
    	end))
    
    	table.insert(self._connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
    		if self._listening then
    			if input.UserInputType == Enum.UserInputType.Keyboard then
    				local key = input.KeyCode
    				if key == Enum.KeyCode.Escape then
    					self._listening = false
    					self.Button.Text = self._value.Name
    					self.Button.TextColor3 = Color3.fromHex("#F0F0F5")
    					return
    				end
    				self:SetValue(key)
    				self._listening = false
    			elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
    				self._listening = false
    				self.Button.Text = self._value.Name
    				self.Button.TextColor3 = Color3.fromHex("#F0F0F5")
    			end
    		end
    	end))
    end
    
    function Keybind:SetValue(key: Enum.KeyCode)
    	self._value = key
    	self.Button.Text = key.Name
    	self.Button.TextColor3 = Color3.fromHex("#F0F0F5")
    
    	if self._callback then
    		self._callback(self._value)
    	end
    	if self._saveToConfig and Config then
    		Config:Set(self._name, self._value.Name)
    	end
    end
    
    function Keybind:GetValue()
    	return self._value
    end
    
    function Keybind:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function Keybind:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	self.Button.TextTransparency = 0
    	self.Button.BackgroundTransparency = 0
    end
    
    function Keybind:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	self.Button.TextTransparency = 0.5
    	self.Button.BackgroundTransparency = 0.5
    end
    
    function Keybind:Lock()
    	self._locked = true
    end
    
    function Keybind:Unlock()
    	self._locked = false
    end
    
    function Keybind:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Switch
    --------------------------------------------------------------------------------
    local Switch = {}
    Switch.__index = Switch
    
    function Switch.new(config: any)
    	local self = setmetatable({}, Switch)
    	self._name = config.Name
    	self._callback = config.Callback
    	self._value = config.Default or false
    	self._tristate = config.Tristate or false
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._saveToConfig = config.SaveToConfig
    
    	local container = Instance.new("Frame")
    	container.Name = "Switch_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32)
    	self.Container = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Size = UDim2.new(1, -60, 1, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.Parent = container
    	self.Label = label
    
    	local track = Instance.new("TextButton")
    	track.Name = "Track"
    	track.BackgroundColor3 = Color3.fromHex("#2E2E33")
    	track.Position = UDim2.new(1, -44, 0.5, -10)
    	track.Size = UDim2.new(0, 34, 0, 20)
    	track.Text = ""
    	track.Parent = container
    	local trackCorner = Instance.new("UICorner")
    	trackCorner.CornerRadius = UDim.new(1, 0)
    	trackCorner.Parent = track
    	self.Track = track
    
    	local thumb = Instance.new("Frame")
    	thumb.Name = "Thumb"
    	thumb.BackgroundColor3 = Color3.fromHex("#F0F0F5")
    	thumb.AnchorPoint = Vector2.new(0, 0.5)
    	thumb.Position = UDim2.new(0, 2, 0.5, 0)
    	thumb.Size = UDim2.new(0, 16, 0, 16)
    	thumb.Parent = track
    	local thumbCorner = Instance.new("UICorner")
    	thumbCorner.CornerRadius = UDim.new(1, 0)
    	thumbCorner.Parent = thumb
    	self.Thumb = thumb
    
    	self:_updateVisuals(false)
    	self:_setupConnections()
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function Switch:_updateVisuals(animated: boolean)
    	local targetPos
    	local targetColor
    
    	if self._tristate then
    		if self._value == true then
    			targetPos = UDim2.new(1, -18, 0.5, 0)
    			targetColor = Color3.fromHex("#7C5CBF")
    		elseif self._value == false then
    			targetPos = UDim2.new(0, 2, 0.5, 0)
    			targetColor = Color3.fromHex("#2E2E33")
    		else
    			targetPos = UDim2.new(0.5, -8, 0.5, 0)
    			targetColor = Color3.fromHex("#555555")
    		end
    	else
    		if self._value then
    			targetPos = UDim2.new(1, -18, 0.5, 0)
    			targetColor = Color3.fromHex("#7C5CBF")
    		else
    			targetPos = UDim2.new(0, 2, 0.5, 0)
    			targetColor = Color3.fromHex("#2E2E33")
    		end
    	end
    
    	if animated then
    		Utility.Tween(self.Thumb, {Position = targetPos}, 0.2)
    		Utility.Tween(self.Track, {BackgroundColor3 = targetColor}, 0.2)
    	else
    		self.Thumb.Position = targetPos
    		self.Track.BackgroundColor3 = targetColor
    	end
    end
    
    function Switch:_setupConnections()
    	table.insert(self._connections, self.Track.MouseButton1Click:Connect(function()
    		if self._disabled or self._locked then return end
    		
    		if self._tristate then
    			if self._value == false then
    				self:SetValue(nil)
    			elseif self._value == nil then
    				self:SetValue(true)
    			else
    				self:SetValue(false)
    			end
    		else
    			self:SetValue(not self._value)
    		end
    	end))
    end
    
    function Switch:SetValue(val: any)
    	self._value = val
    	self:_updateVisuals(true)
    	if self._callback then
    		self._callback(self._value)
    	end
    	if self._saveToConfig and Config then
    		Config:Set(self._name, self._value)
    	end
    end
    
    function Switch:GetValue()
    	return self._value
    end
    
    function Switch:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function Switch:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	self.Track.BackgroundTransparency = 0
    	self.Thumb.BackgroundTransparency = 0
    end
    
    function Switch:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	self.Track.BackgroundTransparency = 0.5
    	self.Thumb.BackgroundTransparency = 0.5
    end
    
    function Switch:Lock()
    	self._locked = true
    end
    
    function Switch:Unlock()
    	self._locked = false
    end
    
    function Switch:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Radio
    --------------------------------------------------------------------------------
    local Radio = {}
    Radio.__index = Radio
    
    function Radio.new(config: any)
    	local self = setmetatable({}, Radio)
    	self._name = config.Name
    	self._options = config.Options or {}
    	self._callback = config.Callback
    	self._value = config.Default or self._options[1]
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._optionFrames = {}
    
    	local container = Instance.new("Frame")
    	container.Name = "Radio_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32 + (#self._options * 24))
    	self.Container = container
    	
    	local listLayout = Instance.new("UIListLayout")
    	listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    	listLayout.Padding = UDim.new(0, 4)
    	listLayout.Parent = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Size = UDim2.new(1, 0, 0, 24)
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.LayoutOrder = 0
    	label.Parent = container
    	self.Label = label
    
    	local labelPadding = Instance.new("UIPadding")
    	labelPadding.PaddingLeft = UDim.new(0, 10)
    	labelPadding.Parent = label
    
    	for i, option in ipairs(self._options) do
    		local optFrame = Instance.new("TextButton")
    		optFrame.Name = "Option_" .. option
    		optFrame.BackgroundTransparency = 1
    		optFrame.Size = UDim2.new(1, 0, 0, 20)
    		optFrame.Text = ""
    		optFrame.LayoutOrder = i
    		optFrame.Parent = container
    
    		local indicator = Instance.new("Frame")
    		indicator.Name = "Indicator"
    		indicator.BackgroundColor3 = Color3.fromHex("#1E1E21")
    		indicator.Position = UDim2.new(0, 10, 0.5, -7)
    		indicator.Size = UDim2.new(0, 14, 0, 14)
    		indicator.Parent = optFrame
    		local indCorner = Instance.new("UICorner")
    		indCorner.CornerRadius = UDim.new(1, 0)
    		indCorner.Parent = indicator
    		local indStroke = Instance.new("UIStroke")
    		indStroke.Color = Color3.fromHex("#2E2E33")
    		indStroke.Parent = indicator
    
    		local inner = Instance.new("Frame")
    		inner.Name = "Inner"
    		inner.AnchorPoint = Vector2.new(0.5, 0.5)
    		inner.Position = UDim2.new(0.5, 0, 0.5, 0)
    		inner.Size = UDim2.new(0, 0, 0, 0)
    		inner.BackgroundColor3 = Color3.fromHex("#7C5CBF")
    		inner.Parent = indicator
    		local innerCorner = Instance.new("UICorner")
    		innerCorner.CornerRadius = UDim.new(1, 0)
    		innerCorner.Parent = inner
    
    		local optLabel = Instance.new("TextLabel")
    		optLabel.BackgroundTransparency = 1
    		optLabel.Position = UDim2.new(0, 30, 0, 0)
    		optLabel.Size = UDim2.new(1, -30, 1, 0)
    		optLabel.Font = Enum.Font.Gotham
    		optLabel.TextSize = 13
    		optLabel.TextColor3 = Color3.fromHex("#F0F0F5")
    		optLabel.TextXAlignment = Enum.TextXAlignment.Left
    		optLabel.Text = option
    		optLabel.Parent = optFrame
    
    		self._optionFrames[option] = {Frame = optFrame, Indicator = indicator, Inner = inner, Label = optLabel}
    
    		table.insert(self._connections, optFrame.MouseButton1Click:Connect(function()
    			if self._disabled or self._locked then return end
    			self:SetValue(option)
    		end))
    	end
    
    	self:_updateVisuals(false)
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function Radio:_updateVisuals(animated: boolean)
    	for opt, data in pairs(self._optionFrames) do
    		local isSelected = (self._value == opt)
    		local targetSize = isSelected and UDim2.new(0, 8, 0, 8) or UDim2.new(0, 0, 0, 0)
    		if animated then
    			Utility.Tween(data.Inner, {Size = targetSize}, 0.2)
    		else
    			data.Inner.Size = targetSize
    		end
    	end
    end
    
    function Radio:SetValue(val: string)
    	if not self._optionFrames[val] then return end
    	self._value = val
    	self:_updateVisuals(true)
    	if self._callback then
    		self._callback(self._value)
    	end
    end
    
    function Radio:GetValue()
    	return self._value
    end
    
    function Radio:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function Radio:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	for _, data in pairs(self._optionFrames) do
    		data.Label.TextTransparency = 0
    		data.Indicator.BackgroundTransparency = 0
    	end
    end
    
    function Radio:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	for _, data in pairs(self._optionFrames) do
    		data.Label.TextTransparency = 0.5
    		data.Indicator.BackgroundTransparency = 0.5
    	end
    end
    
    function Radio:Lock()
    	self._locked = true
    end
    
    function Radio:Unlock()
    	self._locked = false
    end
    
    function Radio:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Checkbox
    --------------------------------------------------------------------------------
    local Checkbox = {}
    Checkbox.__index = Checkbox
    
    function Checkbox.new(config: any)
    	local self = setmetatable({}, Checkbox)
    	self._name = config.Name
    	self._callback = config.Callback
    	self._value = config.Default or false
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._saveToConfig = config.SaveToConfig
    
    	local container = Instance.new("Frame")
    	container.Name = "Checkbox_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32)
    	self.Container = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Size = UDim2.new(1, -40, 1, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.Parent = container
    	self.Label = label
    
    	local button = Instance.new("TextButton")
    	button.Name = "Button"
    	button.BackgroundColor3 = Color3.fromHex("#1E1E21")
    	button.Position = UDim2.new(1, -28, 0.5, -9)
    	button.Size = UDim2.new(0, 18, 0, 18)
    	button.Text = ""
    	button.Parent = container
    	local buttonCorner = Instance.new("UICorner")
    	buttonCorner.CornerRadius = UDim.new(0, 4)
    	buttonCorner.Parent = button
    	local buttonStroke = Instance.new("UIStroke")
    	buttonStroke.Color = Color3.fromHex("#2E2E33")
    	buttonStroke.Parent = button
    	self.Button = button
    	self.Stroke = buttonStroke
    
    	local check = Instance.new("TextLabel")
    	check.BackgroundTransparency = 1
    	check.Size = UDim2.new(1, 0, 1, 0)
    	check.Font = Enum.Font.GothamBold
    	check.TextSize = 14
    	check.TextColor3 = Color3.new(1, 1, 1)
    	check.Text = "✓"
    	check.TextTransparency = 1
    	check.Parent = button
    	self.Check = check
    
    	self:_updateVisuals(false)
    	self:_setupConnections()
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function Checkbox:_updateVisuals(animated: boolean)
    	local targetColor = self._value and Color3.fromHex("#7C5CBF") or Color3.fromHex("#1E1E21")
    	local targetAlpha = self._value and 0 or 1
    
    	if animated then
    		Utility.Tween(self.Button, {BackgroundColor3 = targetColor}, 0.2)
    		Utility.Tween(self.Check, {TextTransparency = targetAlpha}, 0.2)
    	else
    		self.Button.BackgroundColor3 = targetColor
    		self.Check.TextTransparency = targetAlpha
    	end
    end
    
    function Checkbox:_setupConnections()
    	table.insert(self._connections, self.Button.MouseButton1Click:Connect(function()
    		if self._disabled or self._locked then return end
    		self:SetValue(not self._value)
    	end))
    end
    
    function Checkbox:SetValue(val: boolean)
    	self._value = val
    	self:_updateVisuals(true)
    	if self._callback then
    		self._callback(self._value)
    	end
    	if self._saveToConfig and Config then
    		Config:Set(self._name, self._value)
    	end
    end
    
    function Checkbox:GetValue()
    	return self._value
    end
    
    function Checkbox:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function Checkbox:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	self.Button.BackgroundTransparency = 0
    	self.Stroke.Transparency = 0
    end
    
    function Checkbox:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	self.Button.BackgroundTransparency = 0.5
    	self.Stroke.Transparency = 0.5
    end
    
    function Checkbox:Lock()
    	self._locked = true
    end
    
    function Checkbox:Unlock()
    	self._locked = false
    end
    
    function Checkbox:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Input
    --------------------------------------------------------------------------------
    local Input = {}
    Input.__index = Input
    
    function Input.new(config: any)
    	local self = setmetatable({}, Input)
    	self._name = config.Name
    	self._inputType = config.InputType or "string"
    	self._callback = config.Callback
    	self._value = config.Default or ""
    	self._min = config.Min
    	self._max = config.Max
    	self._disabled = config.Disabled or false
    	self._locked = false
    	self._connections = {}
    	self._saveToConfig = config.SaveToConfig
    
    	local container = Instance.new("Frame")
    	container.Name = "Input_" .. self._name
    	container.BackgroundTransparency = 1
    	container.Size = UDim2.new(1, 0, 0, 32)
    	self.Container = container
    
    	local label = Instance.new("TextLabel")
    	label.Name = "Label"
    	label.BackgroundTransparency = 1
    	label.Position = UDim2.new(0, 10, 0, 0)
    	label.Size = UDim2.new(0.5, -15, 1, 0)
    	label.Font = Enum.Font.GothamMedium
    	label.TextSize = 14
    	label.TextColor3 = Color3.fromHex("#F0F0F5")
    	label.TextXAlignment = Enum.TextXAlignment.Left
    	label.Text = self._name
    	label.Parent = container
    	self.Label = label
    
    	local box = Instance.new("TextBox")
    	box.Name = "Box"
    	box.BackgroundColor3 = Color3.fromHex("#1E1E21")
    	box.Position = UDim2.new(0.5, 5, 0.5, -12)
    	box.Size = UDim2.new(0.5, -15, 0, 24)
    	box.Font = Enum.Font.Gotham
    	box.TextSize = 12
    	box.TextColor3 = Color3.fromHex("#F0F0F5")
    	box.PlaceholderText = config.Placeholder or ""
    	box.PlaceholderColor3 = Color3.fromHex("#555555")
    	box.Text = tostring(self._value)
    	box.ClearTextOnFocus = false
    	box.Parent = container
    	local boxCorner = Instance.new("UICorner")
    	boxCorner.CornerRadius = UDim.new(0, 4)
    	boxCorner.Parent = box
    	local boxStroke = Instance.new("UIStroke")
    	boxStroke.Color = Color3.fromHex("#2E2E33")
    	boxStroke.Parent = box
    	self.Box = box
    	self.Stroke = boxStroke
    
    	self:_setupConnections()
    
    	if self._disabled then
    		self:Disable()
    	end
    
    	return self
    end
    
    function Input:_setupConnections()
    	table.insert(self._connections, self.Box.FocusLost:Connect(function(enterPressed)
    		if self._disabled or self._locked then return end
    		local text = self.Box.Text
    		local valid, val = self:_validate(text)
    		
    		if valid then
    			self.Stroke.Color = Color3.fromHex("#2E2E33")
    			self:SetValue(val)
    		else
    			self.Stroke.Color = Color3.new(1, 0, 0)
    			self.Box.Text = tostring(self._value)
    			task.delay(1, function()
    				if self.Stroke then
    					self.Stroke.Color = Color3.fromHex("#2E2E33")
    				end
    			end)
    		end
    	end))
    end
    
    function Input:_validate(text: string): (boolean, any)
    	if self._inputType == "number" then
    		local num = tonumber(text)
    		if not num then return false, nil end
    		if self._min and num < self._min then return false, nil end
    		if self._max and num > self._max then return false, nil end
    		return true, num
    	elseif self._inputType == "integer" then
    		local num = tonumber(text)
    		if not num then return false, nil end
    		if math.floor(num) ~= num then return false, nil end
    		if self._min and num < self._min then return false, nil end
    		if self._max and num > self._max then return false, nil end
    		return true, num
    	else
    		return true, text
    	end
    end
    
    function Input:SetValue(val: any)
    	self._value = val
    	self.Box.Text = tostring(val)
    	if self._callback then
    		self._callback(self._value)
    	end
    	if self._saveToConfig and Config then
    		Config:Set(self._name, self._value)
    	end
    end
    
    function Input:GetValue()
    	return self._value
    end
    
    function Input:SetVisible(visible: boolean)
    	self.Container.Visible = visible
    end
    
    function Input:Enable()
    	self._disabled = false
    	self.Label.TextTransparency = 0
    	self.Box.TextTransparency = 0
    	self.Box.BackgroundTransparency = 0
    end
    
    function Input:Disable()
    	self._disabled = true
    	self.Label.TextTransparency = 0.5
    	self.Box.TextTransparency = 0.5
    	self.Box.BackgroundTransparency = 0.5
    end
    
    function Input:Lock()
    	self._locked = true
    end
    
    function Input:Unlock()
    	self._locked = false
    end
    
    function Input:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Container:Destroy()
    	setmetatable(self, nil)
    end
    
    --------------------------------------------------------------------------------
    -- Export
    --------------------------------------------------------------------------------
    InputControls.ColorPicker = ColorPicker
    InputControls.Keybind = Keybind
    InputControls.Switch = Switch
    InputControls.Radio = Radio
    InputControls.Checkbox = Checkbox
    InputControls.Input = Input
    
    return InputControls
    
end)()

DataControls = (function()
    local Utility = Utility
    local Theme = Theme
    local TweenService = game:GetService("TweenService")
    
    local COLORS = {
    	Surface = Color3.fromHex("#1E1E21"),
    	Background = Color3.fromHex("#0D0D0F"),
    	TerminalBg = Color3.fromHex("#141416"),
    	Accent = Color3.fromHex("#7C5CBF"),
    	Text = Color3.fromHex("#F0F0F5"),
    	Secondary = Color3.fromHex("#A0A0B0"),
    	Border = Color3.fromHex("#2E2E33"),
    	Log = {
    		INFO = Color3.fromHex("#4D9DE0"),
    		WARN = Color3.fromHex("#E09052"),
    		ERROR = Color3.fromHex("#E05252"),
    		SUCCESS = Color3.fromHex("#3DBE7A"),
    		DEFAULT = Color3.fromHex("#A0A0B0")
    	}
    }
    
    -- ==============================================================================
    -- TERMINAL
    -- ==============================================================================
    local Terminal = {}
    Terminal.__index = Terminal
    
    function Terminal.new(config: any)
    	local self = setmetatable({}, Terminal)
    	self._name = config.Name or "Terminal"
    	self._maxLines = config.MaxLines or 500
    	self._interactive = config.Interactive or false
    	self._callback = config.Callback
    	self._connections = {}
    	self._lines = {}
    	self._uiLines = {}
    	self._enabled = true
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, config.Height or 200)
    	self.Instance.BackgroundColor3 = COLORS.TerminalBg
    	self.Instance.BorderSizePixel = 1
    	self.Instance.BorderColor3 = COLORS.Border
    	
    	local uiCorner = Instance.new("UICorner")
    	uiCorner.CornerRadius = UDim.new(0, 4)
    	uiCorner.Parent = self.Instance
    	
    	self.Layout = Instance.new("UIListLayout")
    	self.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    	self.Layout.Parent = self.Instance
    	
    	self.Scroll = Instance.new("ScrollingFrame")
    	self.Scroll.Name = "Output"
    	self.Scroll.Size = UDim2.new(1, 0, 1, self._interactive and -30 or 0)
    	self.Scroll.BackgroundTransparency = 1
    	self.Scroll.ScrollBarThickness = 4
    	self.Scroll.ScrollBarImageColor3 = COLORS.Secondary
    	self.Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    	self.Scroll.Parent = self.Instance
    	
    	self.ScrollLayout = Instance.new("UIListLayout")
    	self.ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
    	self.ScrollLayout.Padding = UDim.new(0, 2)
    	self.ScrollLayout.Parent = self.Scroll
    	
    	local pad = Instance.new("UIPadding")
    	pad.PaddingLeft = UDim.new(0, 6)
    	pad.PaddingRight = UDim.new(0, 6)
    	pad.PaddingTop = UDim.new(0, 6)
    	pad.PaddingBottom = UDim.new(0, 6)
    	pad.Parent = self.Scroll
    	
    	table.insert(self._connections, self.ScrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    		self.Scroll.CanvasSize = UDim2.new(0, 0, 0, self.ScrollLayout.AbsoluteContentSize.Y + 12)
    		self.Scroll.CanvasPosition = Vector2.new(0, self.Scroll.CanvasSize.Y.Offset)
    	end))
    	
    	if self._interactive then
    		self.InputArea = Instance.new("Frame")
    		self.InputArea.Name = "InputArea"
    		self.InputArea.Size = UDim2.new(1, 0, 0, 30)
    		self.InputArea.BackgroundColor3 = COLORS.Surface
    		self.InputArea.BorderSizePixel = 0
    		self.InputArea.LayoutOrder = 2
    		self.InputArea.Parent = self.Instance
    		
    		local inPad = Instance.new("UIPadding")
    		inPad.PaddingLeft = UDim.new(0, 6)
    		inPad.PaddingRight = UDim.new(0, 6)
    		inPad.Parent = self.InputArea
    		
    		self.TextBox = Instance.new("TextBox")
    		self.TextBox.Size = UDim2.new(1, 0, 1, 0)
    		self.TextBox.BackgroundTransparency = 1
    		self.TextBox.TextColor3 = COLORS.Text
    		self.TextBox.PlaceholderText = "> Enter command..."
    		self.TextBox.PlaceholderColor3 = COLORS.Secondary
    		self.TextBox.Font = Enum.Font.Code
    		self.TextBox.TextSize = 13
    		self.TextBox.TextXAlignment = Enum.TextXAlignment.Left
    		self.TextBox.ClearTextOnFocus = false
    		self.TextBox.Parent = self.InputArea
    		
    		table.insert(self._connections, self.TextBox.FocusLost:Connect(function(enterPressed)
    			if enterPressed and self._enabled then
    				local txt = self.TextBox.Text
    				if txt ~= "" then
    					self.TextBox.Text = ""
    					self:Print("> " .. txt, "DEFAULT")
    					if self._callback then
    						self._callback(txt)
    					end
    				end
    			end
    		end))
    	end
    	
    	return self
    end
    
    function Terminal:Print(message: string, level: string?)
    	level = level or "INFO"
    	local color = COLORS.Log[level] or COLORS.Log.DEFAULT
    	local timestamp = string.format("[%02d:%02d:%02d]", os.date("*t").hour, os.date("*t").min, os.date("*t").sec)
    	local fullText = timestamp .. " [" .. tostring(level) .. "] " .. tostring(message)
    	
    	table.insert(self._lines, fullText)
    	
    	local lbl = Instance.new("TextLabel")
    	lbl.Size = UDim2.new(1, 0, 0, 16)
    	lbl.BackgroundTransparency = 1
    	lbl.Font = Enum.Font.Code
    	lbl.TextSize = 12
    	lbl.TextColor3 = color
    	lbl.Text = fullText
    	lbl.TextXAlignment = Enum.TextXAlignment.Left
    	lbl.TextWrapped = true
    	lbl.Parent = self.Scroll
    	
    	-- Auto adjust height
    	local textSize = game:GetService("TextService"):GetTextSize(fullText, 12, Enum.Font.Code, Vector2.new(self.Scroll.AbsoluteWindowSize.X - 12, math.huge))
    	lbl.Size = UDim2.new(1, 0, 0, math.max(16, textSize.Y))
    	
    	table.insert(self._uiLines, lbl)
    	
    	if #self._uiLines > self._maxLines then
    		local oldLines = #self._uiLines - self._maxLines
    		for i = 1, oldLines do
    			local oldUi = table.remove(self._uiLines, 1)
    			if oldUi then oldUi:Destroy() end
    			table.remove(self._lines, 1)
    		end
    	end
    end
    
    function Terminal:Clear()
    	self._lines = {}
    	for _, lbl in ipairs(self._uiLines) do
    		lbl:Destroy()
    	end
    	self._uiLines = {}
    end
    
    function Terminal:GetLines()
    	return self._lines
    end
    
    function Terminal:SetValue(val: any)
    	-- Not directly applicable
    end
    
    function Terminal:GetValue()
    	return self:GetLines()
    end
    
    function Terminal:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function Terminal:Enable()
    	self._enabled = true
    	if self.TextBox then self.TextBox.TextEditable = true end
    end
    
    function Terminal:Disable()
    	self._enabled = false
    	if self.TextBox then self.TextBox.TextEditable = false end
    end
    
    function Terminal:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Instance:Destroy()
    end
    
    -- ==============================================================================
    -- CHART
    -- ==============================================================================
    local Chart = {}
    Chart.__index = Chart
    
    function Chart.new(config: any)
    	local self = setmetatable({}, Chart)
    	self._name = config.Name or "Chart"
    	self._type = config.Type or "line"
    	self._height = config.Height or 160
    	self._enabled = true
    	self._connections = {}
    	self._data = {}
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, self._height)
    	self.Instance.BackgroundColor3 = COLORS.Surface
    	self.Instance.BorderSizePixel = 1
    	self.Instance.BorderColor3 = COLORS.Border
    	
    	local uiCorner = Instance.new("UICorner")
    	uiCorner.CornerRadius = UDim.new(0, 4)
    	uiCorner.Parent = self.Instance
    	
    	self.Title = Instance.new("TextLabel")
    	self.Title.Size = UDim2.new(1, -16, 0, 24)
    	self.Title.Position = UDim2.new(0, 8, 0, 4)
    	self.Title.BackgroundTransparency = 1
    	self.Title.Font = Enum.Font.GothamBold
    	self.Title.TextSize = 12
    	self.Title.TextColor3 = COLORS.Text
    	self.Title.Text = self._name
    	self.Title.TextXAlignment = Enum.TextXAlignment.Left
    	self.Title.Parent = self.Instance
    	
    	self.Canvas = Instance.new("Frame")
    	self.Canvas.Name = "Canvas"
    	self.Canvas.Size = UDim2.new(1, -32, 1, -48)
    	self.Canvas.Position = UDim2.new(0, 24, 0, 28)
    	self.Canvas.BackgroundTransparency = 1
    	self.Canvas.Parent = self.Instance
    	
    	self.XAxis = Instance.new("Frame")
    	self.XAxis.Size = UDim2.new(1, 0, 0, 1)
    	self.XAxis.Position = UDim2.new(0, 0, 1, 0)
    	self.XAxis.BackgroundColor3 = COLORS.Secondary
    	self.XAxis.BorderSizePixel = 0
    	self.XAxis.Parent = self.Canvas
    	
    	self.YAxis = Instance.new("Frame")
    	self.YAxis.Size = UDim2.new(0, 1, 1, 0)
    	self.YAxis.Position = UDim2.new(0, 0, 0, 0)
    	self.YAxis.BackgroundColor3 = COLORS.Secondary
    	self.YAxis.BorderSizePixel = 0
    	self.YAxis.Parent = self.Canvas
    	
    	self.PointsContainer = Instance.new("Frame")
    	self.PointsContainer.Size = UDim2.new(1, 0, 1, 0)
    	self.PointsContainer.BackgroundTransparency = 1
    	self.PointsContainer.Parent = self.Canvas
    	
    	table.insert(self._connections, self.Canvas:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    		self:_redraw()
    	end))
    	
    	return self
    end
    
    function Chart:SetData(dataTable)
    	self._data = {}
    	for i = 1, math.min(#dataTable, 20) do
    		table.insert(self._data, dataTable[i])
    	end
    	self:_redraw()
    end
    
    function Chart:_redraw()
    	for _, child in ipairs(self.PointsContainer:GetChildren()) do
    		child:Destroy()
    	end
    	
    	if #self._data == 0 then return end
    	
    	local maxVal = 0
    	for _, d in ipairs(self._data) do
    		if d.value > maxVal then maxVal = d.value end
    	end
    	if maxVal == 0 then maxVal = 1 end
    	
    	local width = self.Canvas.AbsoluteSize.X
    	local height = self.Canvas.AbsoluteSize.Y
    	local numPoints = #self._data
    	local spacing = numPoints > 1 and (width / (numPoints - 1)) or width
    	if self._type == "bar" then
    		spacing = width / numPoints
    	end
    	
    	local prevPoint = nil
    	
    	for i, d in ipairs(self._data) do
    		local valNorm = d.value / maxVal
    		local px = 0
    		local py = height - (valNorm * height)
    		
    		if self._type == "line" then
    			px = (i - 1) * spacing
    			
    			local dot = Instance.new("Frame")
    			dot.Size = UDim2.new(0, 6, 0, 6)
    			dot.Position = UDim2.new(0, px - 3, 0, py - 3)
    			dot.BackgroundColor3 = COLORS.Accent
    			dot.BorderSizePixel = 0
    			local corner = Instance.new("UICorner")
    			corner.CornerRadius = UDim.new(1, 0)
    			corner.Parent = dot
    			dot.Parent = self.PointsContainer
    			
    			local lbl = Instance.new("TextLabel")
    			lbl.Size = UDim2.new(0, 40, 0, 14)
    			lbl.Position = UDim2.new(0, px - 20, 1, 4)
    			lbl.BackgroundTransparency = 1
    			lbl.Text = tostring(d.label or "")
    			lbl.TextColor3 = COLORS.Secondary
    			lbl.Font = Enum.Font.Gotham
    			lbl.TextSize = 10
    			lbl.Parent = self.PointsContainer
    			
    			if prevPoint then
    				local line = Instance.new("Frame")
    				local dist = math.sqrt((px - prevPoint.X)^2 + (py - prevPoint.Y)^2)
    				local angle = math.atan2(py - prevPoint.Y, px - prevPoint.X)
    				
    				line.Size = UDim2.new(0, dist, 0, 2)
    				line.Position = UDim2.new(0, (px + prevPoint.X)/2 - dist/2, 0, (py + prevPoint.Y)/2 - 1)
    				line.Rotation = math.deg(angle)
    				line.BackgroundColor3 = COLORS.Accent
    				line.BorderSizePixel = 0
    				line.Parent = self.PointsContainer
    			end
    			prevPoint = {X = px, Y = py}
    			
    		elseif self._type == "bar" then
    			local barW = math.max(1, spacing * 0.8)
    			px = (i - 1) * spacing + (spacing - barW)/2
    			
    			local bar = Instance.new("Frame")
    			bar.Size = UDim2.new(0, barW, 0, valNorm * height)
    			bar.Position = UDim2.new(0, px, 0, py)
    			bar.BackgroundColor3 = COLORS.Accent
    			bar.BorderSizePixel = 0
    			bar.Parent = self.PointsContainer
    			
    			local lbl = Instance.new("TextLabel")
    			lbl.Size = UDim2.new(0, barW, 0, 14)
    			lbl.Position = UDim2.new(0, px, 1, 4)
    			lbl.BackgroundTransparency = 1
    			lbl.Text = tostring(d.label or "")
    			lbl.TextColor3 = COLORS.Secondary
    			lbl.Font = Enum.Font.Gotham
    			lbl.TextSize = 10
    			lbl.TextTruncate = Enum.TextTruncate.AtEnd
    			lbl.Parent = self.PointsContainer
    		end
    	end
    end
    
    function Chart:SetValue(val: any)
    	self:SetData(val)
    end
    
    function Chart:GetValue()
    	return self._data
    end
    
    function Chart:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function Chart:Enable()
    	self._enabled = true
    end
    
    function Chart:Disable()
    	self._enabled = false
    end
    
    function Chart:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Instance:Destroy()
    end
    
    -- ==============================================================================
    -- TREE
    -- ==============================================================================
    local Tree = {}
    Tree.__index = Tree
    
    function Tree.new(config: any)
    	local self = setmetatable({}, Tree)
    	self._name = config.Name or "Tree"
    	self._callback = config.Callback
    	self._enabled = true
    	self._connections = {}
    	self._data = config.Data or {}
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, config.Height or 200)
    	self.Instance.BackgroundColor3 = COLORS.Surface
    	self.Instance.BorderSizePixel = 1
    	self.Instance.BorderColor3 = COLORS.Border
    	
    	local uiCorner = Instance.new("UICorner")
    	uiCorner.CornerRadius = UDim.new(0, 4)
    	uiCorner.Parent = self.Instance
    	
    	self.Scroll = Instance.new("ScrollingFrame")
    	self.Scroll.Size = UDim2.new(1, 0, 1, 0)
    	self.Scroll.BackgroundTransparency = 1
    	self.Scroll.ScrollBarThickness = 4
    	self.Scroll.ScrollBarImageColor3 = COLORS.Secondary
    	self.Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    	self.Scroll.Parent = self.Instance
    	
    	self.Layout = Instance.new("UIListLayout")
    	self.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    	self.Layout.Parent = self.Scroll
    	
    	table.insert(self._connections, self.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    		self.Scroll.CanvasSize = UDim2.new(0, 0, 0, self.Layout.AbsoluteContentSize.Y)
    	end))
    	
    	self:SetData(self._data)
    	return self
    end
    
    function Tree:_buildNode(nodeData: any, depth: number, parentPath: string)
    	local hasChildren = nodeData.Children and #nodeData.Children > 0
    	local isExpanded = false
    	local myPath = parentPath == "" and nodeData.Label or (parentPath .. "/" .. nodeData.Label)
    	
    	local nodeFrame = Instance.new("Frame")
    	nodeFrame.Size = UDim2.new(1, 0, 0, 24)
    	nodeFrame.BackgroundTransparency = 1
    	
    	local btn = Instance.new("TextButton")
    	btn.Size = UDim2.new(1, 0, 1, 0)
    	btn.BackgroundTransparency = 1
    	btn.Text = ""
    	btn.Parent = nodeFrame
    	
    	local indent = depth * 16 + 8
    	
    	local arrow = Instance.new("TextLabel")
    	arrow.Size = UDim2.new(0, 16, 0, 24)
    	arrow.Position = UDim2.new(0, indent, 0, 0)
    	arrow.BackgroundTransparency = 1
    	arrow.Text = hasChildren and "▸" or " "
    	arrow.TextColor3 = COLORS.Secondary
    	arrow.Font = Enum.Font.Gotham
    	arrow.TextSize = 12
    	arrow.Parent = nodeFrame
    	
    	local lbl = Instance.new("TextLabel")
    	lbl.Size = UDim2.new(1, -(indent + 20), 0, 24)
    	lbl.Position = UDim2.new(0, indent + 20, 0, 0)
    	lbl.BackgroundTransparency = 1
    	lbl.Text = nodeData.Label or "Node"
    	lbl.TextColor3 = COLORS.Text
    	lbl.Font = Enum.Font.Gotham
    	lbl.TextSize = 12
    	lbl.TextXAlignment = Enum.TextXAlignment.Left
    	lbl.Parent = nodeFrame
    	
    	local childrenContainer = Instance.new("Frame")
    	childrenContainer.Size = UDim2.new(1, 0, 0, 0)
    	childrenContainer.BackgroundTransparency = 1
    	childrenContainer.ClipsDescendants = true
    	childrenContainer.Visible = false
    	
    	local clayout = Instance.new("UIListLayout")
    	clayout.SortOrder = Enum.SortOrder.LayoutOrder
    	clayout.Parent = childrenContainer
    	
    	local cconn
    	cconn = clayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    		if isExpanded then
    			childrenContainer.Size = UDim2.new(1, 0, 0, clayout.AbsoluteContentSize.Y)
    		end
    	end)
    	table.insert(self._connections, cconn)
    	
    	if hasChildren then
    		for _, child in ipairs(nodeData.Children) do
    			local cFrame = self:_buildNode(child, depth + 1, myPath)
    			cFrame.Parent = childrenContainer
    		end
    	end
    	
    	table.insert(self._connections, btn.MouseButton1Click:Connect(function()
    		if not self._enabled then return end
    		if hasChildren then
    			isExpanded = not isExpanded
    			arrow.Text = isExpanded and "▾" or "▸"
    			childrenContainer.Visible = isExpanded
    			childrenContainer.Size = UDim2.new(1, 0, 0, isExpanded and clayout.AbsoluteContentSize.Y or 0)
    		else
    			if self._callback then
    				self._callback(myPath)
    			end
    		end
    	end))
    	
    	local wrapper = Instance.new("Frame")
    	wrapper.Size = UDim2.new(1, 0, 0, 0)
    	wrapper.AutomaticSize = Enum.AutomaticSize.Y
    	wrapper.BackgroundTransparency = 1
    	nodeFrame.Parent = wrapper
    	childrenContainer.Position = UDim2.new(0, 0, 0, 24)
    	childrenContainer.Parent = wrapper
    	
    	return wrapper
    end
    
    function Tree:SetData(data: any)
    	self._data = data
    	for _, child in ipairs(self.Scroll:GetChildren()) do
    		if child:IsA("Frame") then child:Destroy() end
    	end
    	for _, node in ipairs(self._data) do
    		local uiNode = self:_buildNode(node, 0, "")
    		uiNode.Parent = self.Scroll
    	end
    end
    
    function Tree:SetValue(val: any)
    	self:SetData(val)
    end
    
    function Tree:GetValue()
    	return self._data
    end
    
    function Tree:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function Tree:Enable()
    	self._enabled = true
    end
    
    function Tree:Disable()
    	self._enabled = false
    end
    
    function Tree:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Instance:Destroy()
    end
    
    -- ==============================================================================
    -- DATATABLE
    -- ==============================================================================
    local DataTable = {}
    DataTable.__index = DataTable
    
    function DataTable.new(config: any)
    	local self = setmetatable({}, DataTable)
    	self._name = config.Name or "DataTable"
    	self._columns = config.Columns or {}
    	self._rows = config.Rows or {}
    	self._rowHeight = config.RowHeight or 30
    	self._enabled = true
    	self._connections = {}
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, config.Height or 200)
    	self.Instance.BackgroundColor3 = COLORS.Surface
    	self.Instance.BorderSizePixel = 1
    	self.Instance.BorderColor3 = COLORS.Border
    	self.Instance.ClipsDescendants = true
    	
    	local uiCorner = Instance.new("UICorner")
    	uiCorner.CornerRadius = UDim.new(0, 4)
    	uiCorner.Parent = self.Instance
    	
    	self.Scroll = Instance.new("ScrollingFrame")
    	self.Scroll.Size = UDim2.new(1, 0, 1, 0)
    	self.Scroll.BackgroundTransparency = 1
    	self.Scroll.ScrollBarThickness = 4
    	self.Scroll.ScrollBarImageColor3 = COLORS.Secondary
    	self.Scroll.CanvasSize = UDim2.new(2, 0, 0, 0) -- Horizontal scroll potential
    	self.Scroll.Parent = self.Instance
    	
    	self.Layout = Instance.new("UIListLayout")
    	self.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    	self.Layout.Parent = self.Scroll
    	
    	table.insert(self._connections, self.Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    		self.Scroll.CanvasSize = UDim2.new(self.Scroll.CanvasSize.X.Scale, self.Scroll.CanvasSize.X.Offset, 0, self.Layout.AbsoluteContentSize.Y)
    	end))
    	
    	self:_buildTable()
    	
    	return self
    end
    
    function DataTable:_createRow(data: any, isHeader: boolean, index: number)
    	local row = Instance.new("Frame")
    	row.Size = UDim2.new(1, 0, 0, self._rowHeight)
    	row.BackgroundColor3 = isHeader and Color3.fromHex("#252529") or (index % 2 == 0 and COLORS.Surface or COLORS.Background)
    	row.BorderSizePixel = isHeader and 1 or 0
    	row.BorderColor3 = COLORS.Border
    	
    	local colWidth = 1 / math.max(1, #self._columns)
    	
    	for i, val in ipairs(data) do
    		local cell = Instance.new("TextLabel")
    		cell.Size = UDim2.new(colWidth, -8, 1, 0)
    		cell.Position = UDim2.new((i-1)*colWidth, 8, 0, 0)
    		cell.BackgroundTransparency = 1
    		cell.Text = tostring(val)
    		cell.TextColor3 = isHeader and COLORS.Text or COLORS.Secondary
    		cell.Font = isHeader and Enum.Font.GothamBold or Enum.Font.Gotham
    		cell.TextSize = 12
    		cell.TextXAlignment = Enum.TextXAlignment.Left
    		cell.TextTruncate = Enum.TextTruncate.AtEnd
    		cell.Parent = row
    	end
    	
    	return row
    end
    
    function DataTable:_buildTable()
    	for _, child in ipairs(self.Scroll:GetChildren()) do
    		if child:IsA("Frame") then child:Destroy() end
    	end
    	
    	local header = self:_createRow(self._columns, true, 0)
    	header.LayoutOrder = 0
    	header.Parent = self.Scroll
    	
    	for i, rowData in ipairs(self._rows) do
    		local row = self:_createRow(rowData, false, i)
    		row.LayoutOrder = i
    		row.Parent = self.Scroll
    	end
    end
    
    function DataTable:SetRows(newRows: any)
    	self._rows = newRows
    	self:_buildTable()
    end
    
    function DataTable:AddRow(row: any)
    	table.insert(self._rows, row)
    	local r = self:_createRow(row, false, #self._rows)
    	r.LayoutOrder = #self._rows
    	r.Parent = self.Scroll
    end
    
    function DataTable:SetValue(val: any)
    	self:SetRows(val)
    end
    
    function DataTable:GetValue()
    	return self._rows
    end
    
    function DataTable:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function DataTable:Enable()
    	self._enabled = true
    end
    
    function DataTable:Disable()
    	self._enabled = false
    end
    
    function DataTable:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Instance:Destroy()
    end
    
    -- ==============================================================================
    -- ACCORDION
    -- ==============================================================================
    local Accordion = {}
    Accordion.__index = Accordion
    
    function Accordion.new(config: any)
    	local self = setmetatable({}, Accordion)
    	self._name = config.Name or "Accordion"
    	self._items = config.Items or {}
    	self._multiExpand = config.MultiExpand or false
    	self._enabled = true
    	self._connections = {}
    	self._sections = {}
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, 0)
    	self.Instance.AutomaticSize = Enum.AutomaticSize.Y
    	self.Instance.BackgroundTransparency = 1
    	
    	self.Layout = Instance.new("UIListLayout")
    	self.Layout.SortOrder = Enum.SortOrder.LayoutOrder
    	self.Layout.Padding = UDim.new(0, 4)
    	self.Layout.Parent = self.Instance
    	
    	for i, itemData in ipairs(self._items) do
    		self:_buildSection(itemData, i)
    	end
    	
    	return self
    end
    
    function Accordion:_buildSection(itemData: any, index: number)
    	local sec = {}
    	sec.IsOpen = false
    	
    	local frame = Instance.new("Frame")
    	frame.Size = UDim2.new(1, 0, 0, 32)
    	frame.BackgroundColor3 = COLORS.Surface
    	frame.BorderSizePixel = 1
    	frame.BorderColor3 = COLORS.Border
    	frame.LayoutOrder = index
    	frame.ClipsDescendants = true
    	
    	local corner = Instance.new("UICorner")
    	corner.CornerRadius = UDim.new(0, 4)
    	corner.Parent = frame
    	
    	local btn = Instance.new("TextButton")
    	btn.Size = UDim2.new(1, 0, 0, 32)
    	btn.BackgroundTransparency = 1
    	btn.Text = ""
    	btn.Parent = frame
    	
    	local arrow = Instance.new("TextLabel")
    	arrow.Size = UDim2.new(0, 32, 0, 32)
    	arrow.BackgroundTransparency = 1
    	arrow.Text = "▸"
    	arrow.TextColor3 = COLORS.Secondary
    	arrow.Font = Enum.Font.Gotham
    	arrow.TextSize = 14
    	arrow.Parent = btn
    	
    	local title = Instance.new("TextLabel")
    	title.Size = UDim2.new(1, -32, 0, 32)
    	title.Position = UDim2.new(0, 32, 0, 0)
    	title.BackgroundTransparency = 1
    	title.Text = itemData.Title or "Section"
    	title.TextColor3 = COLORS.Text
    	title.Font = Enum.Font.GothamBold
    	title.TextSize = 12
    	title.TextXAlignment = Enum.TextXAlignment.Left
    	title.Parent = btn
    	
    	local content = Instance.new("TextLabel")
    	content.Size = UDim2.new(1, -24, 0, 0)
    	content.Position = UDim2.new(0, 12, 0, 32)
    	content.BackgroundTransparency = 1
    	content.Text = itemData.Content or ""
    	content.TextColor3 = COLORS.Secondary
    	content.Font = Enum.Font.Gotham
    	content.TextSize = 12
    	content.TextXAlignment = Enum.TextXAlignment.Left
    	content.TextYAlignment = Enum.TextYAlignment.Top
    	content.TextWrapped = true
    	content.AutomaticSize = Enum.AutomaticSize.Y
    	content.Parent = frame
    	
    	sec.Frame = frame
    	sec.Arrow = arrow
    	sec.Content = content
    	
    	table.insert(self._connections, btn.MouseButton1Click:Connect(function()
    		if not self._enabled then return end
    		
    		if not self._multiExpand and not sec.IsOpen then
    			for _, other in ipairs(self._sections) do
    				if other.IsOpen and other ~= sec then
    					self:_toggleSection(other, false)
    				end
    			end
    		end
    		
    		self:_toggleSection(sec, not sec.IsOpen)
    	end))
    	
    	frame.Parent = self.Instance
    	table.insert(self._sections, sec)
    end
    
    function Accordion:_toggleSection(sec: any, open: boolean)
    	sec.IsOpen = open
    	sec.Arrow.Text = open and "▾" or "▸"
    	
    	local targetHeight = 32
    	if open then
    		targetHeight = 32 + sec.Content.AbsoluteSize.Y + 12
    	end
    	
    	TweenService:Create(sec.Frame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
    end
    
    function Accordion:SetValue(val: any)
    	-- Not applicable
    end
    
    function Accordion:GetValue()
    	return nil
    end
    
    function Accordion:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function Accordion:Enable()
    	self._enabled = true
    end
    
    function Accordion:Disable()
    	self._enabled = false
    end
    
    function Accordion:Destroy()
    	for _, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	self.Instance:Destroy()
    end
    
    -- ==============================================================================
    -- CANVAS
    -- ==============================================================================
    local Canvas = {}
    Canvas.__index = Canvas
    
    function Canvas.new(config: any)
    	local self = setmetatable({}, Canvas)
    	self._name = config.Name or "Canvas"
    	self._enabled = true
    	
    	self.Instance = Instance.new("Frame")
    	self.Instance.Name = self._name
    	self.Instance.Size = UDim2.new(1, 0, 0, config.Height or 200)
    	if config.BackgroundColor then
    		self.Instance.BackgroundColor3 = config.BackgroundColor
    		self.Instance.BackgroundTransparency = 0
    	else
    		self.Instance.BackgroundTransparency = 1
    	end
    	
    	return self
    end
    
    function Canvas:GetFrame()
    	return self.Instance
    end
    
    function Canvas:SetValue(val: any)
    	-- Not applicable
    end
    
    function Canvas:GetValue()
    	return nil
    end
    
    function Canvas:SetVisible(visible: boolean)
    	self.Instance.Visible = visible
    end
    
    function Canvas:Enable()
    	self._enabled = true
    end
    
    function Canvas:Disable()
    	self._enabled = false
    end
    
    function Canvas:Destroy()
    	self.Instance:Destroy()
    end
    
    return {
    	Terminal = Terminal,
    	Chart = Chart,
    	Tree = Tree,
    	DataTable = DataTable,
    	Accordion = Accordion,
    	Canvas = Canvas
    }
    
end)()

Notification = (function()
    local TweenService = game:GetService("TweenService")
    local SoundService = game:GetService("SoundService")
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    
    local LocalPlayer = Players.LocalPlayer
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    local THEME = {
    	Colors = {
    		Success = Color3.fromHex("#3DBE7A"),
    		Error = Color3.fromHex("#E05252"),
    		Warning = Color3.fromHex("#E09052"),
    		Info = Color3.fromHex("#4D9DE0"),
    		Background = Color3.fromHex("#1E1E21"),
    		Text = Color3.fromHex("#F0F0F5"),
    	},
    	Icons = {
    		Success = "✓",
    		Error = "✕",
    		Warning = "⚠",
    		Info = "ℹ",
    	},
    }
    
    -- Create ScreenGui
    local FeedbackGui = Instance.new("ScreenGui")
    FeedbackGui.Name = "LuminaUI_Feedback"
    FeedbackGui.ResetOnSpawn = false
    FeedbackGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    -- Optionally put in CoreGui if plugin/exploit, else PlayerGui
    local success = pcall(function()
    	FeedbackGui.Parent = PlayerGui
    end)
    if not success then
    	FeedbackGui.Parent = CoreGui
    end
    
    --------------------------------------------------------------------------------
    -- NOTIFICATION MANAGER
    --------------------------------------------------------------------------------
    
    export type NotificationConfig = {
    	Title: string,
    	Message: string,
    	Type: string?, -- "Success", "Error", "Warning", "Info"
    	Duration: number?,
    	Sound: boolean?,
    	Callback: (() -> ())?,
    }
    
    export type NotificationObject = {
    	Frame: Frame,
    	Disconnect: () -> (),
    	Destroy: () -> (),
    	Height: number,
    }
    
    local NotificationManager = {}
    NotificationManager.__index = NotificationManager
    
    function NotificationManager.new()
    	local self = setmetatable({}, NotificationManager)
    	
    	self.VisibleNotifications = {} :: {NotificationObject}
    	self.Queue = {} :: {NotificationConfig}
    	self.MaxVisible = 5
    	self.Spacing = 10
    	self.BasePosition = UDim2.new(1, -20, 1, -20) -- Bottom right start
    	
    	self.Container = Instance.new("Frame")
    	self.Container.Name = "NotificationContainer"
    	self.Container.Size = UDim2.new(0, 300, 1, 0)
    	self.Container.Position = UDim2.new(1, -320, 0, 0)
    	self.Container.BackgroundTransparency = 1
    	self.Container.Parent = FeedbackGui
    	
    	return self
    end
    
    function NotificationManager:RepositionNotifications()
    	local currentY = self.Container.AbsoluteSize.Y - 20
    	
    	for i = #self.VisibleNotifications, 1, -1 do
    		local notif = self.VisibleNotifications[i]
    		currentY = currentY - notif.Height
    		
    		local targetPos = UDim2.new(0, 0, 0, currentY)
    		local tween = TweenService:Create(notif.Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    			Position = targetPos
    		})
    		tween:Play()
    		
    		currentY = currentY - self.Spacing
    	end
    end
    
    function NotificationManager:ProcessQueue()
    	if #self.Queue > 0 and #self.VisibleNotifications < self.MaxVisible then
    		local config = table.remove(self.Queue, 1)
    		self:ShowNotification(config :: NotificationConfig)
    	end
    end
    
    function NotificationManager:ShowNotification(config: NotificationConfig)
    	local notifType = config.Type or "Info"
    	local duration = config.Duration or 5
    	local color = THEME.Colors[notifType] or THEME.Colors.Info
    	local iconChar = THEME.Icons[notifType] or THEME.Icons.Info
    	
    	local frame = Instance.new("Frame")
    	frame.Name = "Notification"
    	frame.Size = UDim2.new(1, 0, 0, 80)
    	frame.Position = UDim2.new(1, 20, 0, self.Container.AbsoluteSize.Y) -- Start off-screen right
    	frame.BackgroundColor3 = THEME.Colors.Background
    	frame.Parent = self.Container
    	
    	local corner = Instance.new("UICorner")
    	corner.CornerRadius = UDim.new(0, 10)
    	corner.Parent = frame
    	
    	local stroke = Instance.new("UIStroke")
    	stroke.Color = color
    	stroke.Thickness = 1
    	stroke.Parent = frame
    	
    	local accent = Instance.new("Frame")
    	accent.Name = "Accent"
    	accent.Size = UDim2.new(0, 4, 1, -20)
    	accent.Position = UDim2.new(0, 10, 0, 10)
    	accent.BackgroundColor3 = color
    	accent.BorderSizePixel = 0
    	accent.Parent = frame
    	
    	local accentCorner = Instance.new("UICorner")
    	accentCorner.CornerRadius = UDim.new(0, 2)
    	accentCorner.Parent = accent
    	
    	local icon = Instance.new("TextLabel")
    	icon.Name = "Icon"
    	icon.Size = UDim2.new(0, 24, 0, 24)
    	icon.Position = UDim2.new(0, 24, 0, 10)
    	icon.BackgroundTransparency = 1
    	icon.Text = iconChar
    	icon.TextColor3 = color
    	icon.TextSize = 20
    	icon.Font = Enum.Font.GothamBold
    	icon.Parent = frame
    	
    	local title = Instance.new("TextLabel")
    	title.Name = "Title"
    	title.Size = UDim2.new(1, -90, 0, 20)
    	title.Position = UDim2.new(0, 56, 0, 12)
    	title.BackgroundTransparency = 1
    	title.Text = config.Title
    	title.TextColor3 = THEME.Colors.Text
    	title.TextSize = 16
    	title.Font = Enum.Font.GothamBold
    	title.TextXAlignment = Enum.TextXAlignment.Left
    	title.Parent = frame
    	
    	local message = Instance.new("TextLabel")
    	message.Name = "Message"
    	message.Size = UDim2.new(1, -90, 0, 34)
    	message.Position = UDim2.new(0, 56, 0, 36)
    	message.BackgroundTransparency = 1
    	message.Text = config.Message
    	message.TextColor3 = THEME.Colors.Text
    	message.TextTransparency = 0.3
    	message.TextSize = 14
    	message.Font = Enum.Font.Gotham
    	message.TextXAlignment = Enum.TextXAlignment.Left
    	message.TextYAlignment = Enum.TextYAlignment.Top
    	message.TextWrapped = true
    	message.Parent = frame
    	
    	local closeBtn = Instance.new("TextButton")
    	closeBtn.Name = "Close"
    	closeBtn.Size = UDim2.new(0, 24, 0, 24)
    	closeBtn.Position = UDim2.new(1, -30, 0, 10)
    	closeBtn.BackgroundTransparency = 1
    	closeBtn.Text = "✕"
    	closeBtn.TextColor3 = THEME.Colors.Text
    	closeBtn.TextTransparency = 0.5
    	closeBtn.TextSize = 14
    	closeBtn.Font = Enum.Font.GothamBold
    	closeBtn.Parent = frame
    	
    	local progressContainer = Instance.new("Frame")
    	progressContainer.Name = "ProgressContainer"
    	progressContainer.Size = UDim2.new(1, -20, 0, 3)
    	progressContainer.Position = UDim2.new(0, 10, 1, -8)
    	progressContainer.BackgroundColor3 = THEME.Colors.Text
    	progressContainer.BackgroundTransparency = 0.9
    	progressContainer.BorderSizePixel = 0
    	progressContainer.Parent = frame
    	
    	local progressCorner = Instance.new("UICorner")
    	progressCorner.CornerRadius = UDim.new(1, 0)
    	progressCorner.Parent = progressContainer
    	
    	local progressBar = Instance.new("Frame")
    	progressBar.Name = "ProgressBar"
    	progressBar.Size = UDim2.new(1, 0, 1, 0)
    	progressBar.BackgroundColor3 = color
    	progressBar.BorderSizePixel = 0
    	progressBar.Parent = progressContainer
    	
    	local progressBarCorner = Instance.new("UICorner")
    	progressBarCorner.CornerRadius = UDim.new(1, 0)
    	progressBarCorner.Parent = progressBar
    	
    	if config.Sound then
    		local sound = Instance.new("Sound")
    		sound.SoundId = "rbxassetid://4590657391" -- Example ping sound
    		sound.Volume = 0.5
    		sound.Parent = SoundService
    		sound:Play()
    		game.Debris:AddItem(sound, 2)
    	end
    	
    	local connections = {}
    	local isClosing = false
    	
    	local function closeNotification()
    		if isClosing then return end
    		isClosing = true
    		
    		if config.Callback then
    			task.spawn(config.Callback)
    		end
    		
    		for _, conn in ipairs(connections) do
    			conn:Disconnect()
    		end
    		
    		local fadeTween = TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    			Position = UDim2.new(1, 20, 0, frame.Position.Y.Offset),
    			BackgroundTransparency = 1
    		})
    		
    		for _, child in ipairs(frame:GetDescendants()) do
    			if child:IsA("TextLabel") or child:IsA("TextButton") then
    				TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
    			elseif child:IsA("Frame") then
    				TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
    			elseif child:IsA("UIStroke") then
    				TweenService:Create(child, TweenInfo.new(0.3), {Transparency = 1}):Play()
    			end
    		end
    		
    		fadeTween:Play()
    		fadeTween.Completed:Connect(function()
    			frame:Destroy()
    		end)
    		
    		-- Remove from visible list
    		for i, notif in ipairs(self.VisibleNotifications) do
    			if notif.Frame == frame then
    				table.remove(self.VisibleNotifications, i)
    				break
    			end
    		end
    		
    		self:RepositionNotifications()
    		self:ProcessQueue()
    	end
    	
    	table.insert(connections, closeBtn.MouseButton1Click:Connect(closeNotification))
    	
    	local notifObj = {
    		Frame = frame,
    		Height = 80,
    		Disconnect = function()
    			for _, conn in ipairs(connections) do
    				conn:Disconnect()
    			end
    		end,
    		Destroy = function()
    			closeNotification()
    		end,
    	}
    	
    	table.insert(self.VisibleNotifications, notifObj)
    	self:RepositionNotifications()
    	
    	-- Slide in
    	local slideTween = TweenService:Create(frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    		Position = UDim2.new(0, 0, 0, frame.Position.Y.Offset)
    	})
    	slideTween:Play()
    	
    	-- Progress bar tween
    	local progressTween = TweenService:Create(progressBar, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
    		Size = UDim2.new(0, 0, 1, 0)
    	})
    	progressTween:Play()
    	
    	task.delay(duration, function()
    		if not isClosing then
    			closeNotification()
    		end
    	end)
    end
    
    function NotificationManager:Notify(config: NotificationConfig)
    	if #self.VisibleNotifications >= self.MaxVisible then
    		table.insert(self.Queue, config)
    	else
    		self:ShowNotification(config)
    	end
    end
    
    function NotificationManager:Destroy()
    	for _, notif in ipairs(self.VisibleNotifications) do
    		notif.Disconnect()
    		notif.Frame:Destroy()
    	end
    	self.VisibleNotifications = {}
    	self.Queue = {}
    	if self.Container then
    		self.Container:Destroy()
    	end
    end
    
    --------------------------------------------------------------------------------
    -- DIALOG MANAGER
    --------------------------------------------------------------------------------
    
    export type DialogConfig = {
    	Title: string,
    	Message: string,
    	Buttons: {string}?,
    	Callback: ((string) -> ())?,
    }
    
    local DialogManager = {}
    DialogManager.__index = DialogManager
    
    function DialogManager.new()
    	local self = setmetatable({}, DialogManager)
    	self.ActiveDialog = nil :: Frame?
    	self.Connections = {} :: {RBXScriptConnection}
    	return self
    end
    
    function DialogManager:Dialog(config: DialogConfig)
    	if self.ActiveDialog then
    		self:CloseActiveDialog()
    	end
    	
    	local buttons = config.Buttons or {"OK"}
    	
    	local overlay = Instance.new("Frame")
    	overlay.Name = "DialogOverlay"
    	overlay.Size = UDim2.new(1, 0, 1, 0)
    	overlay.BackgroundColor3 = Color3.new(0, 0, 0)
    	overlay.BackgroundTransparency = 1
    	overlay.Active = true
    	overlay.Parent = FeedbackGui
    	
    	local dialog = Instance.new("Frame")
    	dialog.Name = "DialogBox"
    	dialog.Size = UDim2.new(0, 400, 0, 200)
    	dialog.Position = UDim2.new(0.5, 0, 0.5, 0)
    	dialog.AnchorPoint = Vector2.new(0.5, 0.5)
    	dialog.BackgroundColor3 = THEME.Colors.Background
    	dialog.Parent = overlay
    	
    	local corner = Instance.new("UICorner")
    	corner.CornerRadius = UDim.new(0, 10)
    	corner.Parent = dialog
    	
    	local stroke = Instance.new("UIStroke")
    	stroke.Color = THEME.Colors.Info
    	stroke.Thickness = 1
    	stroke.Parent = dialog
    	
    	local scale = Instance.new("UIScale")
    	scale.Scale = 0.8
    	scale.Parent = dialog
    	
    	local title = Instance.new("TextLabel")
    	title.Name = "Title"
    	title.Size = UDim2.new(1, -40, 0, 30)
    	title.Position = UDim2.new(0, 20, 0, 20)
    	title.BackgroundTransparency = 1
    	title.Text = config.Title
    	title.TextColor3 = THEME.Colors.Text
    	title.TextSize = 20
    	title.Font = Enum.Font.GothamBold
    	title.TextXAlignment = Enum.TextXAlignment.Center
    	title.Parent = dialog
    	
    	local message = Instance.new("TextLabel")
    	message.Name = "Message"
    	message.Size = UDim2.new(1, -40, 1, -120)
    	message.Position = UDim2.new(0, 20, 0, 60)
    	message.BackgroundTransparency = 1
    	message.Text = config.Message
    	message.TextColor3 = THEME.Colors.Text
    	message.TextTransparency = 0.2
    	message.TextSize = 16
    	message.Font = Enum.Font.Gotham
    	message.TextXAlignment = Enum.TextXAlignment.Center
    	message.TextYAlignment = Enum.TextYAlignment.Top
    	message.TextWrapped = true
    	message.Parent = dialog
    	
    	local buttonContainer = Instance.new("Frame")
    	buttonContainer.Name = "ButtonContainer"
    	buttonContainer.Size = UDim2.new(1, -40, 0, 40)
    	buttonContainer.Position = UDim2.new(0, 20, 1, -60)
    	buttonContainer.BackgroundTransparency = 1
    	buttonContainer.Parent = dialog
    	
    	local layout = Instance.new("UIListLayout")
    	layout.FillDirection = Enum.FillDirection.Horizontal
    	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    	layout.VerticalAlignment = Enum.VerticalAlignment.Center
    	layout.Padding = UDim.new(0, 10)
    	layout.SortOrder = Enum.SortOrder.LayoutOrder
    	layout.Parent = buttonContainer
    	
    	-- Calculate total button width (for #buttons)
    	local numBtns = #buttons
    	local containerWidth = buttonContainer.AbsoluteSize.X
    	if containerWidth == 0 then containerWidth = 360 end -- Fallback for when sizes haven't updated
    	local btnWidth = (containerWidth - ((numBtns - 1) * 10)) / numBtns
    	if btnWidth > 120 then btnWidth = 120 end
    	
    	for i, btnText in ipairs(buttons) do
    		local btn = Instance.new("TextButton")
    		btn.Name = "Button_" .. btnText
    		btn.Size = UDim2.new(0, btnWidth, 1, 0)
    		btn.BackgroundColor3 = THEME.Colors.Info
    		btn.Text = btnText
    		btn.TextColor3 = THEME.Colors.Background
    		btn.TextSize = 16
    		btn.Font = Enum.Font.GothamBold
    		btn.LayoutOrder = i
    		btn.Parent = buttonContainer
    		
    		local btnCorner = Instance.new("UICorner")
    		btnCorner.CornerRadius = UDim.new(0, 6)
    		btnCorner.Parent = btn
    		
    		local conn = btn.MouseButton1Click:Connect(function()
    			self:CloseActiveDialog()
    			if config.Callback then
    				task.spawn(config.Callback, btnText)
    			end
    		end)
    		table.insert(self.Connections, conn)
    	end
    	
    	self.ActiveDialog = overlay
    	
    	-- Animate in
    	TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 0.5}):Play()
    	TweenService:Create(scale, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Scale = 1}):Play()
    end
    
    function DialogManager:CloseActiveDialog()
    	if self.ActiveDialog then
    		for _, conn in ipairs(self.Connections) do
    			conn:Disconnect()
    		end
    		self.Connections = {}
    		
    		local overlay = self.ActiveDialog
    		self.ActiveDialog = nil
    		
    		local dialog = overlay:FindFirstChild("DialogBox")
    		if dialog then
    			local scale = dialog:FindFirstChildOfClass("UIScale")
    			if scale then
    				TweenService:Create(scale, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Scale = 0.8}):Play()
    			end
    			local fade = TweenService:Create(overlay, TweenInfo.new(0.3), {BackgroundTransparency = 1})
    			fade:Play()
    			fade.Completed:Connect(function()
    				overlay:Destroy()
    			end)
    		else
    			overlay:Destroy()
    		end
    	end
    end
    
    function DialogManager:Destroy()
    	self:CloseActiveDialog()
    end
    
    --------------------------------------------------------------------------------
    -- EXPORT
    --------------------------------------------------------------------------------
    
    local activeNotificationManager = NotificationManager.new()
    local activeDialogManager = DialogManager.new()
    
    return {
    	Notification = activeNotificationManager,
    	Dialog = activeDialogManager,
    }
    
end)()

Tooltip = (function()
    
    local TweenService = game:GetService("TweenService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    
    local player = Players.LocalPlayer
    local playerGui = player and player:FindFirstChild("PlayerGui") or game:GetService("CoreGui")
    
    -- Configuration
    local ANIMATION_INFO = TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
    local BG_COLOR = Color3.fromRGB(26, 26, 29) -- #1A1A1D
    local BORDER_COLOR = Color3.fromRGB(46, 46, 51) -- #2E2E33
    local MENU_BG_COLOR = Color3.fromRGB(30, 30, 33) -- #1E1E21
    local HOVER_BG_COLOR = Color3.fromRGB(37, 37, 40) -- #252528
    local ACCENT_COLOR = Color3.fromRGB(149, 117, 213) -- #9575D5
    local TEXT_COLOR = Color3.fromRGB(255, 255, 255)
    
    --------------------------------------------------------------------------------
    -- TOOLTIP CLASS
    --------------------------------------------------------------------------------
    
    local Tooltip = {}
    
    local tooltipGui: ScreenGui? = nil
    local tooltipFrame: Frame? = nil
    local tooltipTextLabel: TextLabel? = nil
    local tooltipUiStroke: UIStroke? = nil
    
    local tooltipTweens = {}
    local activeTarget: GuiObject? = nil
    
    local function initTooltip()
        if tooltipGui then return end
        
        tooltipGui = Instance.new("ScreenGui")
        tooltipGui.Name = "LuminaUI_TooltipGui"
        tooltipGui.DisplayOrder = 9999
        tooltipGui.IgnoreGuiInset = true
        tooltipGui.Parent = playerGui
        
        tooltipFrame = Instance.new("Frame")
        tooltipFrame.Name = "TooltipFrame"
        tooltipFrame.BackgroundColor3 = BG_COLOR
        tooltipFrame.BackgroundTransparency = 1
        tooltipFrame.Position = UDim2.fromOffset(0, 0)
        tooltipFrame.ZIndex = 100
        tooltipFrame.Parent = tooltipGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = tooltipFrame
        
        tooltipUiStroke = Instance.new("UIStroke")
        tooltipUiStroke.Color = BORDER_COLOR
        tooltipUiStroke.Transparency = 1
        tooltipUiStroke.Parent = tooltipFrame
        
        local padding = Instance.new("UIPadding")
        padding.PaddingLeft = UDim.new(0, 8)
        padding.PaddingRight = UDim.new(0, 8)
        padding.PaddingTop = UDim.new(0, 6)
        padding.PaddingBottom = UDim.new(0, 6)
        padding.Parent = tooltipFrame
        
        tooltipTextLabel = Instance.new("TextLabel")
        tooltipTextLabel.Name = "Text"
        tooltipTextLabel.BackgroundTransparency = 1
        tooltipTextLabel.Size = UDim2.fromScale(1, 1)
        tooltipTextLabel.Font = Enum.Font.GothamMedium
        tooltipTextLabel.TextSize = 13
        tooltipTextLabel.TextColor3 = TEXT_COLOR
        tooltipTextLabel.TextTransparency = 1
        tooltipTextLabel.TextXAlignment = Enum.TextXAlignment.Left
        tooltipTextLabel.AutomaticSize = Enum.AutomaticSize.XY
        tooltipTextLabel.Parent = tooltipFrame
        
        tooltipFrame.AutomaticSize = Enum.AutomaticSize.XY
    end
    
    function Tooltip.UpdatePosition(position: Vector2)
        if not tooltipFrame or not tooltipGui then return end
        
        local screenSize = tooltipGui.AbsoluteSize
        local frameSize = tooltipFrame.AbsoluteSize
        
        local x = position.X + 15
        local y = position.Y + 15
        
        if x + frameSize.X > screenSize.X then
            x = position.X - frameSize.X - 15
        end
        
        if y + frameSize.Y > screenSize.Y then
            y = position.Y - frameSize.Y - 15
        end
        
        tooltipFrame.Position = UDim2.fromOffset(x, y)
    end
    
    function Tooltip.Show(text: string, position: Vector2)
        initTooltip()
        
        if not tooltipFrame or not tooltipTextLabel or not tooltipUiStroke then return end
        
        for _, tween in ipairs(tooltipTweens) do
            tween:Cancel()
        end
        table.clear(tooltipTweens)
        
        tooltipTextLabel.Text = text
        Tooltip.UpdatePosition(position)
        
        local t1 = TweenService:Create(tooltipFrame, ANIMATION_INFO, {BackgroundTransparency = 0})
        local t2 = TweenService:Create(tooltipUiStroke, ANIMATION_INFO, {Transparency = 0})
        local t3 = TweenService:Create(tooltipTextLabel, ANIMATION_INFO, {TextTransparency = 0})
        
        table.insert(tooltipTweens, t1)
        table.insert(tooltipTweens, t2)
        table.insert(tooltipTweens, t3)
        
        t1:Play()
        t2:Play()
        t3:Play()
    end
    
    function Tooltip.Hide()
        if not tooltipFrame or not tooltipTextLabel or not tooltipUiStroke then return end
        
        for _, tween in ipairs(tooltipTweens) do
            tween:Cancel()
        end
        table.clear(tooltipTweens)
        
        local t1 = TweenService:Create(tooltipFrame, ANIMATION_INFO, {BackgroundTransparency = 1})
        local t2 = TweenService:Create(tooltipUiStroke, ANIMATION_INFO, {Transparency = 1})
        local t3 = TweenService:Create(tooltipTextLabel, ANIMATION_INFO, {TextTransparency = 1})
        
        table.insert(tooltipTweens, t1)
        table.insert(tooltipTweens, t2)
        table.insert(tooltipTweens, t3)
        
        t1:Play()
        t2:Play()
        t3:Play()
    end
    
    function Tooltip.Attach(guiObject: GuiObject, text: string)
        local connections = {}
        
        table.insert(connections, guiObject.MouseEnter:Connect(function()
            activeTarget = guiObject
            local mousePos = UserInputService:GetMouseLocation()
            Tooltip.Show(text, mousePos)
        end))
        
        table.insert(connections, guiObject.MouseMoved:Connect(function(x, y)
            if activeTarget == guiObject then
                if tooltipFrame and tooltipFrame.BackgroundTransparency < 1 then
                    Tooltip.UpdatePosition(Vector2.new(x, y))
                end
            end
        end))
        
        table.insert(connections, guiObject.MouseLeave:Connect(function()
            if activeTarget == guiObject then
                activeTarget = nil
                Tooltip.Hide()
            end
        end))
        
        return function()
            for _, conn in ipairs(connections) do
                conn:Disconnect()
            end
            if activeTarget == guiObject then
                activeTarget = nil
                Tooltip.Hide()
            end
        end
    end
    
    --------------------------------------------------------------------------------
    -- CONTEXT MENU CLASS
    --------------------------------------------------------------------------------
    
    type MenuItem = {
        Label: string?,
        Icon: string?,
        Callback: (() -> ())?,
        Separator: boolean?,
        _instance: GuiObject?,
        _label: TextLabel?,
        _icon: TextLabel?
    }
    
    local ContextMenu = {}
    ContextMenu.__index = ContextMenu
    
    function ContextMenu.new(items: {MenuItem})
        local self = setmetatable({}, ContextMenu)
        
        self.Connections = {}
        
        self.Gui = Instance.new("ScreenGui")
        self.Gui.Name = "LuminaUI_ContextMenu"
        self.Gui.DisplayOrder = 10000
        self.Gui.IgnoreGuiInset = true
        self.Gui.Parent = playerGui
        self.Gui.Enabled = false
        
        self.Frame = Instance.new("Frame")
        self.Frame.Name = "ContextMenuFrame"
        self.Frame.BackgroundColor3 = MENU_BG_COLOR
        self.Frame.BackgroundTransparency = 1
        self.Frame.Position = UDim2.fromOffset(0, 0)
        self.Frame.Size = UDim2.fromOffset(160, 0)
        self.Frame.AutomaticSize = Enum.AutomaticSize.Y
        self.Frame.ZIndex = 100
        self.Frame.Parent = self.Gui
        self.Frame.ClipsDescendants = true
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = self.Frame
        
        self.Stroke = Instance.new("UIStroke")
        self.Stroke.Color = BORDER_COLOR
        self.Stroke.Transparency = 1
        self.Stroke.Parent = self.Frame
        
        local layout = Instance.new("UIListLayout")
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 2)
        layout.Parent = self.Frame
        
        local padding = Instance.new("UIPadding")
        padding.PaddingTop = UDim.new(0, 4)
        padding.PaddingBottom = UDim.new(0, 4)
        padding.PaddingLeft = UDim.new(0, 4)
        padding.PaddingRight = UDim.new(0, 4)
        padding.Parent = self.Frame
        
        for i, item in ipairs(items) do
            if item.Separator then
                local sepFrame = Instance.new("Frame")
                sepFrame.Name = "Separator"
                sepFrame.BackgroundColor3 = BORDER_COLOR
                sepFrame.BackgroundTransparency = 1
                sepFrame.Size = UDim2.new(1, 0, 0, 1)
                sepFrame.LayoutOrder = i
                sepFrame.Parent = self.Frame
                
                item._instance = sepFrame
            else
                local btn = Instance.new("TextButton")
                btn.Name = "Item_" .. i
                btn.BackgroundColor3 = HOVER_BG_COLOR
                btn.BackgroundTransparency = 1
                btn.Size = UDim2.new(1, 0, 0, 28)
                btn.Text = ""
                btn.AutoButtonColor = false
                btn.LayoutOrder = i
                btn.Parent = self.Frame
                
                local btnCorner = Instance.new("UICorner")
                btnCorner.CornerRadius = UDim.new(0, 4)
                btnCorner.Parent = btn
                
                local contentFrame = Instance.new("Frame")
                contentFrame.BackgroundTransparency = 1
                contentFrame.Size = UDim2.fromScale(1, 1)
                contentFrame.Parent = btn
                
                local contentLayout = Instance.new("UIListLayout")
                contentLayout.FillDirection = Enum.FillDirection.Horizontal
                contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
                contentLayout.Padding = UDim.new(0, 8)
                contentLayout.VerticalAlignment = Enum.VerticalAlignment.Center
                contentLayout.Parent = contentFrame
                
                local contentPadding = Instance.new("UIPadding")
                contentPadding.PaddingLeft = UDim.new(0, 8)
                contentPadding.PaddingRight = UDim.new(0, 8)
                contentPadding.Parent = contentFrame
                
                if item.Icon then
                    local iconLabel = Instance.new("TextLabel")
                    iconLabel.Name = "Icon"
                    iconLabel.BackgroundTransparency = 1
                    iconLabel.Size = UDim2.fromOffset(16, 16)
                    iconLabel.Font = Enum.Font.GothamMedium
                    iconLabel.TextSize = 14
                    iconLabel.TextColor3 = TEXT_COLOR
                    iconLabel.TextTransparency = 1
                    iconLabel.Text = item.Icon
                    iconLabel.LayoutOrder = 1
                    iconLabel.Parent = contentFrame
                    item._icon = iconLabel
                end
                
                local label = Instance.new("TextLabel")
                label.Name = "Label"
                label.BackgroundTransparency = 1
                label.Size = UDim2.new(1, item.Icon and -24 or 0, 1, 0)
                label.Font = Enum.Font.GothamMedium
                label.TextSize = 13
                label.TextColor3 = TEXT_COLOR
                label.TextTransparency = 1
                label.Text = item.Label or "Item"
                label.TextXAlignment = Enum.TextXAlignment.Left
                label.LayoutOrder = 2
                label.Parent = contentFrame
                
                item._instance = btn
                item._label = label
                
                table.insert(self.Connections, btn.MouseEnter:Connect(function()
                    TweenService:Create(btn, ANIMATION_INFO, {BackgroundTransparency = 0}):Play()
                    TweenService:Create(label, ANIMATION_INFO, {TextColor3 = ACCENT_COLOR}):Play()
                    if item._icon then
                        TweenService:Create(item._icon, ANIMATION_INFO, {TextColor3 = ACCENT_COLOR}):Play()
                    end
                end))
                
                table.insert(self.Connections, btn.MouseLeave:Connect(function()
                    TweenService:Create(btn, ANIMATION_INFO, {BackgroundTransparency = 1}):Play()
                    TweenService:Create(label, ANIMATION_INFO, {TextColor3 = TEXT_COLOR}):Play()
                    if item._icon then
                        TweenService:Create(item._icon, ANIMATION_INFO, {TextColor3 = TEXT_COLOR}):Play()
                    end
                end))
                
                table.insert(self.Connections, btn.MouseButton1Click:Connect(function()
                    self:Hide()
                    if item.Callback then
                        item.Callback()
                    end
                end))
            end
        end
        
        self.Items = items
        
        table.insert(self.Connections, UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if self.Gui.Enabled and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.MouseButton2 or input.UserInputType == Enum.UserInputType.Touch) then
                local mousePos = UserInputService:GetMouseLocation()
                local framePos = self.Frame.AbsolutePosition
                local frameSize = self.Frame.AbsoluteSize
                
                -- Check if click is outside
                if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y then
                    self:Hide()
                end
            end
        end))
        
        return self
    end
    
    function ContextMenu:Show(position: Vector2)
        self.Gui.Enabled = true
        
        local screenSize = self.Gui.AbsoluteSize
        local frameSize = self.Frame.AbsoluteSize
        if frameSize.Y == 0 then
            -- Force layout update if Y is 0
            self.Frame.Size = UDim2.fromOffset(160, 100) -- temporary size to get elements right
            task.wait()
            frameSize = self.Frame.AbsoluteSize
        end
        
        local x = position.X
        local y = position.Y
        
        if x + frameSize.X > screenSize.X then
            x = screenSize.X - frameSize.X - 5
        end
        
        if y + frameSize.Y > screenSize.Y then
            y = screenSize.Y - frameSize.Y - 5
        end
        
        self.Frame.Position = UDim2.fromOffset(x, y)
        
        TweenService:Create(self.Frame, ANIMATION_INFO, {BackgroundTransparency = 0}):Play()
        TweenService:Create(self.Stroke, ANIMATION_INFO, {Transparency = 0}):Play()
        
        for _, item in ipairs(self.Items) do
            if item.Separator and item._instance then
                TweenService:Create(item._instance, ANIMATION_INFO, {BackgroundTransparency = 0}):Play()
            else
                if item._label then
                    TweenService:Create(item._label, ANIMATION_INFO, {TextTransparency = 0}):Play()
                end
                if item._icon then
                    TweenService:Create(item._icon, ANIMATION_INFO, {TextTransparency = 0}):Play()
                end
            end
        end
    end
    
    function ContextMenu:Hide()
        local t1 = TweenService:Create(self.Frame, ANIMATION_INFO, {BackgroundTransparency = 1})
        TweenService:Create(self.Stroke, ANIMATION_INFO, {Transparency = 1}):Play()
        
        for _, item in ipairs(self.Items) do
            if item.Separator and item._instance then
                TweenService:Create(item._instance, ANIMATION_INFO, {BackgroundTransparency = 1}):Play()
            else
                if item._label then
                    TweenService:Create(item._label, ANIMATION_INFO, {TextTransparency = 1}):Play()
                end
                if item._icon then
                    TweenService:Create(item._icon, ANIMATION_INFO, {TextTransparency = 1}):Play()
                end
            end
        end
        
        t1:Play()
        t1.Completed:Connect(function()
            if self.Frame.BackgroundTransparency >= 0.99 then
                self.Gui.Enabled = false
            end
        end)
    end
    
    function ContextMenu:Destroy()
        for _, conn in ipairs(self.Connections) do
            conn:Disconnect()
        end
        table.clear(self.Connections)
        
        if self.Gui then
            self.Gui:Destroy()
        end
    end
    
    return {
        Tooltip = Tooltip,
        ContextMenu = ContextMenu
    }
    
end)()

Loading = (function()
    -- LuminaUI Loading Screen Component
    -- Provides a full-screen loading overlay with spinner and progress bar.
    
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local CoreGui = game:GetService("CoreGui")
    
    local COLORS = {
    	Background = Color3.fromHex("#0D0D0F"),
    	Accent = Color3.fromHex("#7C5CBF"),
    	Text = Color3.fromHex("#F0F0F5"),
    	BarBackground = Color3.fromHex("#1E1E21"),
    }
    
    export type LoadingConfig = {
    	Title: string?,
    	SubTitle: string?,
    	Version: string?,
    }
    
    local LoadingScreen = {}
    LoadingScreen.__index = LoadingScreen
    
    export type LoadingScreen = typeof(setmetatable({} :: {
    	_screenGui: ScreenGui,
    	_background: Frame,
    	_spinner: Frame,
    	_progressBarFill: Frame,
    	_statusText: TextLabel,
    	_connections: {RBXScriptConnection},
    	_fadeTween: Tween?,
    	_progressTween: Tween?,
    	Visible: boolean,
    }, LoadingScreen))
    
    -- Creates a new LoadingScreen instance
    function LoadingScreen.new(config: LoadingConfig?): LoadingScreen
    	config = config or {}
    	local title = config.Title or "LuminaUI"
    	local subTitle = config.SubTitle or "Loading..."
    	local version = config.Version or "v1.0.0"
    
    	local self = setmetatable({
    		_connections = {},
    		Visible = false,
    	}, LoadingScreen)
    
    	-- Main GUI
    	self._screenGui = Instance.new("ScreenGui")
    	self._screenGui.Name = "LuminaUILoadingScreen"
    	self._screenGui.IgnoreGuiInset = true
    	self._screenGui.DisplayOrder = 9999
    	self._screenGui.Enabled = false
    
    	pcall(function()
    		self._screenGui.Parent = CoreGui
    	end)
    	if not self._screenGui.Parent then
    		self._screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    	end
    
    	-- Background Overlay
    	self._background = Instance.new("Frame")
    	self._background.Name = "Background"
    	self._background.Size = UDim2.new(1, 0, 1, 0)
    	self._background.BackgroundColor3 = COLORS.Background
    	self._background.BackgroundTransparency = 1 -- Start fully transparent for fade-in
    	self._background.BorderSizePixel = 0
    	self._background.Parent = self._screenGui
    
    	-- Centered Container
    	local container = Instance.new("Frame")
    	container.Name = "Container"
    	container.Size = UDim2.new(0, 400, 0, 300)
    	container.Position = UDim2.new(0.5, 0, 0.5, 0)
    	container.AnchorPoint = Vector2.new(0.5, 0.5)
    	container.BackgroundTransparency = 1
    	container.Parent = self._background
    
    	local layout = Instance.new("UIListLayout")
    	layout.SortOrder = Enum.SortOrder.LayoutOrder
    	layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    	layout.VerticalAlignment = Enum.VerticalAlignment.Center
    	layout.Padding = UDim.new(0, 16)
    	layout.Parent = container
    
    	-- Title
    	local titleLabel = Instance.new("TextLabel")
    	titleLabel.Name = "Title"
    	titleLabel.Size = UDim2.new(1, 0, 0, 40)
    	titleLabel.BackgroundTransparency = 1
    	titleLabel.Font = Enum.Font.GothamBold
    	titleLabel.Text = title
    	titleLabel.TextColor3 = COLORS.Text
    	titleLabel.TextSize = 36
    	titleLabel.TextTransparency = 1
    	titleLabel.LayoutOrder = 1
    	titleLabel.Parent = container
    
    	-- SubTitle
    	local subTitleLabel = Instance.new("TextLabel")
    	subTitleLabel.Name = "SubTitle"
    	subTitleLabel.Size = UDim2.new(1, 0, 0, 20)
    	subTitleLabel.BackgroundTransparency = 1
    	subTitleLabel.Font = Enum.Font.Gotham
    	subTitleLabel.Text = subTitle
    	subTitleLabel.TextColor3 = COLORS.Text
    	subTitleLabel.TextSize = 16
    	subTitleLabel.TextTransparency = 1
    	subTitleLabel.LayoutOrder = 2
    	subTitleLabel.Parent = container
    
    	-- Spinner
    	local spinnerContainer = Instance.new("Frame")
    	spinnerContainer.Name = "SpinnerContainer"
    	spinnerContainer.Size = UDim2.new(0, 60, 0, 60)
    	spinnerContainer.BackgroundTransparency = 1
    	spinnerContainer.LayoutOrder = 3
    	spinnerContainer.Parent = container
    
    	self._spinner = Instance.new("Frame")
    	self._spinner.Name = "Spinner"
    	self._spinner.Size = UDim2.new(1, 0, 1, 0)
    	self._spinner.BackgroundColor3 = Color3.new(1, 1, 1)
    	self._spinner.BackgroundTransparency = 1 -- controlled via gradient
    	self._spinner.Parent = spinnerContainer
    
    	local spinnerCorner = Instance.new("UICorner")
    	spinnerCorner.CornerRadius = UDim.new(0.5, 0)
    	spinnerCorner.Parent = self._spinner
    
    	local spinnerStroke = Instance.new("UIStroke")
    	spinnerStroke.Color = Color3.new(1,1,1)
    	spinnerStroke.Thickness = 4
    	spinnerStroke.Parent = self._spinner
    
    	local spinnerGradient = Instance.new("UIGradient")
    	spinnerGradient.Color = ColorSequence.new(COLORS.Accent)
    	spinnerGradient.Transparency = NumberSequence.new({
    		NumberSequenceKeypoint.new(0, 1),
    		NumberSequenceKeypoint.new(0.5, 0),
    		NumberSequenceKeypoint.new(1, 1)
    	})
    	spinnerGradient.Parent = spinnerStroke
    
    	-- Progress Bar Background
    	local progressBarBg = Instance.new("Frame")
    	progressBarBg.Name = "ProgressBarBackground"
    	progressBarBg.Size = UDim2.new(0, 300, 0, 8)
    	progressBarBg.BackgroundColor3 = COLORS.BarBackground
    	progressBarBg.BorderSizePixel = 0
    	progressBarBg.LayoutOrder = 4
    	progressBarBg.Parent = container
    
    	local barBgCorner = Instance.new("UICorner")
    	barBgCorner.CornerRadius = UDim.new(1, 0)
    	barBgCorner.Parent = progressBarBg
    
    	-- Progress Bar Fill
    	self._progressBarFill = Instance.new("Frame")
    	self._progressBarFill.Name = "ProgressBarFill"
    	self._progressBarFill.Size = UDim2.new(0, 0, 1, 0)
    	self._progressBarFill.BackgroundColor3 = COLORS.Accent
    	self._progressBarFill.BorderSizePixel = 0
    	self._progressBarFill.Parent = progressBarBg
    
    	local barFillCorner = Instance.new("UICorner")
    	barFillCorner.CornerRadius = UDim.new(1, 0)
    	barFillCorner.Parent = self._progressBarFill
    
    	local fillGradient = Instance.new("UIGradient")
    	fillGradient.Color = ColorSequence.new({
    		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
    		ColorSequenceKeypoint.new(1, Color3.new(0.8, 0.8, 0.8))
    	})
    	fillGradient.Parent = self._progressBarFill
    
    	-- Status Text
    	self._statusText = Instance.new("TextLabel")
    	self._statusText.Name = "Status"
    	self._statusText.Size = UDim2.new(1, 0, 0, 20)
    	self._statusText.BackgroundTransparency = 1
    	self._statusText.Font = Enum.Font.Gotham
    	self._statusText.Text = "Initializing..."
    	self._statusText.TextColor3 = COLORS.Text
    	self._statusText.TextSize = 14
    	self._statusText.TextTransparency = 1
    	self._statusText.LayoutOrder = 5
    	self._statusText.Parent = container
    
    	-- Version Text
    	local versionLabel = Instance.new("TextLabel")
    	versionLabel.Name = "Version"
    	versionLabel.Size = UDim2.new(1, 0, 0, 20)
    	versionLabel.Position = UDim2.new(0, 0, 1, -30)
    	versionLabel.BackgroundTransparency = 1
    	versionLabel.Font = Enum.Font.Gotham
    	versionLabel.Text = version
    	versionLabel.TextColor3 = COLORS.Text
    	versionLabel.TextSize = 12
    	versionLabel.TextTransparency = 1
    	versionLabel.Parent = self._background
    
    	return self
    end
    
    -- Start rotating the spinner
    function LoadingScreen:_startSpinner()
    	local angle = 0
    	local connection = RunService.RenderStepped:Connect(function(dt)
    		angle = (angle + dt * 180) % 360
    		self._spinner.Rotation = angle
    	end)
    	table.insert(self._connections, connection)
    end
    
    -- Stop rotating the spinner
    function LoadingScreen:_stopSpinner()
    	for i, conn in ipairs(self._connections) do
    		conn:Disconnect()
    	end
    	table.clear(self._connections)
    end
    
    -- Fade all elements' transparency
    function LoadingScreen:_tweenTransparency(targetTrans: number, duration: number, callback: (() -> ())?)
    	local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    	
    	if self._fadeTween then
    		self._fadeTween:Cancel()
    	end
    
    	-- We only tween the background explicitly, and recursively tween other elements if needed.
    	-- Since they are children, we can just tween them separately.
    	self._fadeTween = TweenService:Create(self._background, tweenInfo, {BackgroundTransparency = targetTrans == 1 and 1 or 0.3})
    	
    	local function setTrans(instance: Instance)
    		if instance:IsA("TextLabel") then
    			TweenService:Create(instance, tweenInfo, {TextTransparency = targetTrans}):Play()
    		elseif instance:IsA("UIStroke") then
    			TweenService:Create(instance, tweenInfo, {Transparency = targetTrans}):Play()
    		elseif instance == self._spinner or instance == self._progressBarFill or instance.Name == "ProgressBarBackground" then
    			if instance:IsA("Frame") then
    				-- Handle specific transparencies
    				local t = targetTrans
    				if instance.Name == "Spinner" then t = 1 end
    				TweenService:Create(instance, tweenInfo, {BackgroundTransparency = t}):Play()
    			end
    		end
    		for _, child in ipairs(instance:GetChildren()) do
    			setTrans(child)
    		end
    	end
    	setTrans(self._background)
    
    	self._fadeTween.Completed:Connect(function()
    		if callback then
    			callback()
    		end
    	end)
    	self._fadeTween:Play()
    end
    
    -- Shows the loading screen (fades in)
    function LoadingScreen:Show()
    	if self.Visible then return end
    	self.Visible = true
    	self._screenGui.Enabled = true
    	
    	self:_startSpinner()
    	self:_tweenTransparency(0, 0.5)
    end
    
    -- Hides the loading screen (fades out then destroys)
    function LoadingScreen:Hide()
    	if not self.Visible then return end
    	self.Visible = false
    	
    	self:_tweenTransparency(1, 0.5, function()
    		self:Destroy()
    	end)
    end
    
    -- Updates the progress bar (0 to 1)
    function LoadingScreen:SetProgress(progress: number)
    	progress = math.clamp(progress, 0, 1)
    	
    	if self._progressTween then
    		self._progressTween:Cancel()
    	end
    	
    	local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    	self._progressTween = TweenService:Create(self._progressBarFill, tweenInfo, {
    		Size = UDim2.new(progress, 0, 1, 0)
    	})
    	self._progressTween:Play()
    end
    
    -- Updates the status text
    function LoadingScreen:SetStatus(text: string)
    	self._statusText.Text = text
    end
    
    -- Cleans up the loading screen
    function LoadingScreen:Destroy()
    	pcall(function()
    		self:_stopSpinner()
    		
    		if self._fadeTween then
    			self._fadeTween:Cancel()
    		end
    		if self._progressTween then
    			self._progressTween:Cancel()
    		end
    		
    		if self._screenGui then
    			self._screenGui:Destroy()
    		end
    	end)
    end
    
    return LoadingScreen
    
end)()

Tab = (function()
    -- LuminaUI :: Components/Navigation/Tab.luau
    -- Standard sidebar tab with icon, badge, tooltip, and content page management.
    -- ──────────────────────────────────────────────────────
    
    local TweenService = game:GetService("TweenService")
    local Utility = Utility
    local Theme   = Theme
    local Types   = Types
    
    -- ══════════════════════════════════════════════════════
    -- § Tab class
    -- ══════════════════════════════════════════════════════
    
    local Tab = {}
    Tab.__index = Tab
    
    export type TabObject = typeof(setmetatable({} :: {
    	_type:         string,
    	_name:         string,
    	_window:       any,
    	_tabButton:    TextButton,
    	_contentPage:  Frame,
    	_contentList:  UIListLayout,
    	_controls:     {any},
    	_connections:  {RBXScriptConnection},
    	_badge:        Frame?,
    	_badgeLabel:   TextLabel?,
    	_iconLabel:    TextLabel,
    	_selected:     boolean,
    	_visible:      boolean,
    	_order:        number,
    }, Tab))
    
    function Tab.new(config: Types.TabConfig, window: any): TabObject
    	local self = setmetatable({} :: any, Tab)
    	self._type        = "tab"
    	self._name        = config.Name or "Tab"
    	self._window      = window
    	self._controls    = {}
    	self._connections = {}
    	self._selected    = false
    	self._visible     = config.Visible ~= false
    	self._order       = config.Order or 0
    
    	local theme = Theme.Get()
    
    	-- ── Tab button in sidebar ──────────────────────────
    	local btn = Instance.new("TextButton")
    	btn.Name             = "TabBtn_" .. self._name
    	btn.Size             = UDim2.new(1, 0, 0, 38)
    	btn.BackgroundColor3 = theme.Surface
    	btn.BackgroundTransparency = 1
    	btn.Text             = ""
    	btn.AutoButtonColor  = false
    	btn.LayoutOrder      = self._order
    	btn.Visible          = self._visible
    	btn.ZIndex           = 3
    	btn.Parent           = window._sidebar
    	self._tabButton = btn
    	Utility.Corner(8, btn)
    
    	-- Inner layout
    	local inner = Instance.new("Frame")
    	inner.Size             = UDim2.new(1, 0, 1, 0)
    	inner.BackgroundTransparency = 1
    	inner.ZIndex           = 4
    	inner.Parent           = btn
    
    	local _innerLayout = Instance.new("UIListLayout")
    	_innerLayout.FillDirection     = Enum.FillDirection.Horizontal
    	_innerLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    	_innerLayout.Padding           = UDim.new(0, 8)
    	_innerLayout.Parent            = inner
    	Utility.Padding(0, 0, 0, 10, inner)
    
    	-- Icon
    	local iconLabel = Instance.new("TextLabel")
    	iconLabel.Size             = UDim2.new(0, 18, 1, 0)
    	iconLabel.BackgroundTransparency = 1
    	iconLabel.Text             = config.Icon or "◆"
    	iconLabel.TextColor3       = theme.TextSecondary
    	iconLabel.Font             = Enum.Font.Gotham
    	iconLabel.TextSize         = 14
    	iconLabel.ZIndex           = 5
    	iconLabel.Parent           = inner
    	self._iconLabel = iconLabel
    
    	-- Name label
    	local nameLabel = Instance.new("TextLabel")
    	nameLabel.Name             = "TabName"
    	nameLabel.Size             = UDim2.new(1, -40, 1, 0)
    	nameLabel.BackgroundTransparency = 1
    	nameLabel.Text             = self._name
    	nameLabel.TextColor3       = theme.TextSecondary
    	nameLabel.Font             = Enum.Font.Gotham
    	nameLabel.TextSize         = 13
    	nameLabel.TextXAlignment   = Enum.TextXAlignment.Left
    	nameLabel.ZIndex           = 5
    	nameLabel.Parent           = inner
    
    	-- Active accent bar (left edge)
    	local accentBar = Instance.new("Frame")
    	accentBar.Name             = "AccentBar"
    	accentBar.Size             = UDim2.new(0, 3, 0.6, 0)
    	accentBar.AnchorPoint      = Vector2.new(0, 0.5)
    	accentBar.Position         = UDim2.new(0, 0, 0.5, 0)
    	accentBar.BackgroundColor3 = theme.Accent
    	accentBar.BackgroundTransparency = 1
    	accentBar.ZIndex           = 6
    	accentBar.Parent           = btn
    	Utility.Corner(2, accentBar)
    
    	self._accentBar  = accentBar
    	self._nameLabel  = nameLabel
    
    	-- ── Content page ───────────────────────────────────
    	local page = Instance.new("Frame")
    	page.Name              = "TabContent_" .. self._name
    	page.Size              = UDim2.new(1, 0, 0, 0)
    	page.AutomaticSize     = Enum.AutomaticSize.Y
    	page.BackgroundTransparency = 1
    	page.Visible           = false
    	page.ZIndex            = 2
    	page.Parent            = window._contentArea
    	self._contentPage = page
    
    	local contentList = Utility.ListLayout(nil, nil, UDim.new(0, 6), page)
    	self._contentList = contentList
    
    	-- ── Hover / click animations ────────────────────────
    	table.insert(self._connections, btn.MouseEnter:Connect(function()
    		if not self._selected then
    			Utility.Tween(btn, {BackgroundTransparency = 0.85}, 0.12)
    			Utility.Tween(iconLabel, {TextColor3 = theme.Text}, 0.12)
    			Utility.Tween(nameLabel, {TextColor3 = theme.Text}, 0.12)
    		end
    	end))
    
    	table.insert(self._connections, btn.MouseLeave:Connect(function()
    		if not self._selected then
    			Utility.Tween(btn, {BackgroundTransparency = 1}, 0.12)
    			Utility.Tween(iconLabel, {TextColor3 = theme.TextSecondary}, 0.12)
    			Utility.Tween(nameLabel, {TextColor3 = theme.TextSecondary}, 0.12)
    		end
    	end))
    
    	table.insert(self._connections, btn.MouseButton1Click:Connect(function()
    		self:Select()
    	end))
    
    	-- Tooltip
    	if config.Tooltip then
    		local TooltipMod = Tooltip
    		TooltipMod.Tooltip.Attach(btn, config.Tooltip)
    	end
    
    	return self
    end
    
    -- ── Select (activate tab) ─────────────────────────────
    function Tab:Select()
    	-- Deselect all other tabs in window
    	for _, t in ipairs(self._window._tabs) do
    		if t ~= self and t._type == "tab" and t._selected then
    			t:Deselect()
    		end
    	end
    
    	self._selected = true
    	local theme = Theme.Get()
    
    	Utility.Tween(self._tabButton, {BackgroundColor3 = theme.AccentDim, BackgroundTransparency = 0}, 0.18)
    	Utility.Tween(self._accentBar, {BackgroundTransparency = 0}, 0.18)
    	Utility.Tween(self._iconLabel, {TextColor3 = theme.Accent}, 0.18)
    	Utility.Tween(self._nameLabel, {TextColor3 = theme.Text, Font = Enum.Font.GothamBold :: any}, 0.18)
    
    	-- Show content
    	self._window:SetActiveContent(self._contentPage)
    end
    
    function Tab:Deselect()
    	self._selected = false
    	local theme = Theme.Get()
    	Utility.Tween(self._tabButton, {BackgroundColor3 = theme.Surface, BackgroundTransparency = 1}, 0.18)
    	Utility.Tween(self._accentBar, {BackgroundTransparency = 1}, 0.18)
    	Utility.Tween(self._iconLabel, {TextColor3 = theme.TextSecondary}, 0.18)
    	Utility.Tween(self._nameLabel, {TextColor3 = theme.TextSecondary}, 0.18)
    end
    
    -- ── Badge ─────────────────────────────────────────────
    function Tab:SetBadge(count: number?)
    	if count and count > 0 then
    		if not self._badge then
    			local theme = Theme.Get()
    			local badge = Instance.new("Frame")
    			badge.Name             = "Badge"
    			badge.Size             = UDim2.new(0, 18, 0, 18)
    			badge.AnchorPoint      = Vector2.new(1, 0.5)
    			badge.Position         = UDim2.new(1, -8, 0.5, 0)
    			badge.BackgroundColor3 = theme.Error
    			badge.ZIndex           = 7
    			badge.Parent           = self._tabButton
    			Utility.Corner(9, badge)
    
    			local badgeLbl = Instance.new("TextLabel")
    			badgeLbl.Size             = UDim2.new(1, 0, 1, 0)
    			badgeLbl.BackgroundTransparency = 1
    			badgeLbl.TextColor3       = Color3.fromHex("#FFFFFF")
    			badgeLbl.Font             = Enum.Font.GothamBold
    			badgeLbl.TextSize         = 9
    			badgeLbl.ZIndex           = 8
    			badgeLbl.Parent           = badge
    			self._badge      = badge
    			self._badgeLabel = badgeLbl
    		end
    		self._badgeLabel.Text = tostring(math.min(count, 99))
    		self._badge.Visible   = true
    	else
    		if self._badge then
    			self._badge.Visible = false
    		end
    	end
    end
    
    -- ── Icon ──────────────────────────────────────────────
    function Tab:SetIcon(icon: string)
    	self._iconLabel.Text = icon
    end
    
    -- ── Visibility ────────────────────────────────────────
    function Tab:SetVisible(visible: boolean)
    	self._visible = visible
    	self._tabButton.Visible = visible
    end
    
    function Tab:_setVisible(visible: boolean)
    	self:SetVisible(visible)
    end
    
    -- ── Search within controls ────────────────────────────
    function Tab:_searchControls(query: string)
    	local q = query:lower()
    	local empty = q == ""
    	for _, ctrl in ipairs(self._controls) do
    		if ctrl._frame then
    			local name = tostring(ctrl._name or ""):lower()
    			local match = empty or name:find(q, 1, true) ~= nil
    			ctrl._frame.Visible = match
    			if match and not empty then
    				-- Highlight: tween background
    				Utility.Tween(ctrl._frame, {BackgroundColor3 = Theme.Color("AccentDim")}, 0.15)
    				task.delay(1.2, function()
    					if ctrl._frame then
    						Utility.Tween(ctrl._frame, {BackgroundColor3 = Theme.Color("Surface")}, 0.3)
    					end
    				end)
    				-- Select this tab if it's not active
    				if not self._selected then
    					self:Select()
    				end
    			end
    		end
    	end
    end
    
    -- ── Remove ────────────────────────────────────────────
    function Tab:Destroy()
    	for _, c in ipairs(self._connections) do
    		pcall(c.Disconnect, c)
    	end
    	table.clear(self._connections)
    	if self._tabButton then self._tabButton:Destroy() end
    	if self._contentPage then self._contentPage:Destroy() end
    end
    
    -- ── Control factory — delegate to BasicControls ───────
    local function _requireControls()
    	return BasicControls
    end
    local function _requireDisplay()
    	return DisplayControls
    end
    local function _requireInputCtrl()
    	return InputControls
    end
    local function _requireData()
    	return DataControls
    end
    
    local function _addControl(self: any, ctrl: any)
    	ctrl._frame.Parent = self._contentPage
    	table.insert(self._controls, ctrl)
    	return ctrl
    end
    
    function Tab:CreateButton(cfg: Types.ButtonConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Button.new(cfg :: Types.ButtonConfig))
    end
    function Tab:CreateToggle(cfg: Types.ToggleConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Toggle.new(cfg :: Types.ToggleConfig))
    end
    function Tab:CreateSlider(cfg: Types.SliderConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Slider.new(cfg :: Types.SliderConfig))
    end
    function Tab:CreateDropdown(cfg: Types.DropdownConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Dropdown.new(cfg :: Types.DropdownConfig))
    end
    function Tab:CreateTextbox(cfg: Types.TextboxConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Textbox.new(cfg :: Types.TextboxConfig))
    end
    function Tab:CreateLabel(cfg: Types.LabelConfig | string)
    	if type(cfg) == "string" then cfg = {Text = cfg} end
    	return _addControl(self, _requireDisplay().Label.new(cfg :: Types.LabelConfig))
    end
    function Tab:CreateParagraph(cfg: Types.ParagraphConfig)
    	return _addControl(self, _requireDisplay().Paragraph.new(cfg))
    end
    function Tab:CreateSection(cfg: Types.SectionConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Section.new(cfg :: Types.SectionConfig))
    end
    function Tab:CreateSeparator(cfg: Types.SeparatorConfig?)
    	return _addControl(self, _requireControls().Separator.new(cfg or {}))
    end
    function Tab:CreateColorPicker(cfg: Types.ColorPickerConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireInputCtrl().ColorPicker.new(cfg :: Types.ColorPickerConfig))
    end
    function Tab:CreateKeybind(cfg: Types.KeybindConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireInputCtrl().Keybind.new(cfg :: Types.KeybindConfig))
    end
    function Tab:CreateProgressBar(cfg: Types.ProgressBarConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireDisplay().ProgressBar.new(cfg :: Types.ProgressBarConfig))
    end
    function Tab:CreateImage(cfg: Types.ImageConfig)
    	return _addControl(self, _requireDisplay().Image.new(cfg))
    end
    function Tab:CreateCodeBlock(cfg: any)
    	return _addControl(self, _requireDisplay().CodeBlock.new(cfg))
    end
    function Tab:CreateRichText(cfg: any)
    	return _addControl(self, _requireDisplay().RichText.new(cfg))
    end
    function Tab:CreateSwitch(cfg: any)
    	return _addControl(self, _requireInputCtrl().Switch.new(cfg))
    end
    function Tab:CreateRadio(cfg: any)
    	return _addControl(self, _requireInputCtrl().Radio.new(cfg))
    end
    function Tab:CreateCheckbox(cfg: any)
    	return _addControl(self, _requireInputCtrl().Checkbox.new(cfg))
    end
    function Tab:CreateInput(cfg: any)
    	return _addControl(self, _requireInputCtrl().Input.new(cfg))
    end
    function Tab:CreateTerminal(cfg: any)
    	return _addControl(self, _requireData().Terminal.new(cfg))
    end
    function Tab:CreateChart(cfg: any)
    	return _addControl(self, _requireData().Chart.new(cfg))
    end
    function Tab:CreateTree(cfg: any)
    	return _addControl(self, _requireData().Tree.new(cfg))
    end
    function Tab:CreateTable(cfg: any)
    	return _addControl(self, _requireData().DataTable.new(cfg))
    end
    function Tab:CreateAccordion(cfg: any)
    	return _addControl(self, _requireData().Accordion.new(cfg))
    end
    function Tab:CreateCanvas(cfg: any)
    	return _addControl(self, _requireData().Canvas.new(cfg))
    end
    
    return Tab
    
end)()

DropdownTab = (function()
    -- LuminaUI :: Components/Navigation/DropdownTab.luau
    -- Collapsible nested sidebar tab group.
    -- Supports infinite depth, smooth animations, search integration.
    -- ──────────────────────────────────────────────────────
    
    local TweenService = game:GetService("TweenService")
    local Utility = Utility
    local Theme   = Theme
    local Types   = Types
    
    -- ══════════════════════════════════════════════════════
    -- § DropdownTab class
    -- ══════════════════════════════════════════════════════
    
    local DropdownTab = {}
    DropdownTab.__index = DropdownTab
    
    function DropdownTab.new(config: Types.DropdownTabConfig, window: any)
    	local self = setmetatable({} :: any, DropdownTab)
    	self._type        = "dropdowntab"
    	self._name        = config.Name or "Group"
    	self._window      = window
    	self._expanded    = if config.DefaultOpen ~= nil then config.DefaultOpen else true
    	self._controls    = {}
    	self._children    = {} -- nested DropdownTabs
    	self._connections = {}
    	self._visible     = config.Visible ~= false
    
    	local theme = Theme.Get()
    
    	-- ── Header button ─────────────────────────────────
    	local header = Instance.new("TextButton")
    	header.Name             = "DTHeader_" .. self._name
    	header.Size             = UDim2.new(1, 0, 0, 36)
    	header.BackgroundColor3 = theme.BackgroundTertiary
    	header.AutoButtonColor  = false
    	header.Text             = ""
    	header.LayoutOrder      = config.Order or 0
    	header.Visible          = self._visible
    	header.ZIndex           = 3
    	header.Parent           = window._sidebar
    	self._header = header
    	Utility.Corner(8, header)
    	Utility.Stroke(1, theme.BorderSubtle, 0, header)
    
    	-- Header inner layout
    	local inner = Instance.new("Frame")
    	inner.Size             = UDim2.new(1, 0, 1, 0)
    	inner.BackgroundTransparency = 1
    	inner.ZIndex           = 4
    	inner.Parent           = header
    
    	local _innerList = Instance.new("UIListLayout")
    	_innerList.FillDirection     = Enum.FillDirection.Horizontal
    	_innerList.VerticalAlignment = Enum.VerticalAlignment.Center
    	_innerList.Padding           = UDim.new(0, 7)
    	_innerList.Parent            = inner
    	Utility.Padding(0, 0, 0, 10, inner)
    
    	-- Icon
    	local iconLabel = Instance.new("TextLabel")
    	iconLabel.Size             = UDim2.new(0, 16, 1, 0)
    	iconLabel.BackgroundTransparency = 1
    	iconLabel.Text             = config.Icon or "▸"
    	iconLabel.TextColor3       = theme.Accent
    	iconLabel.Font             = Enum.Font.Gotham
    	iconLabel.TextSize         = 13
    	iconLabel.ZIndex           = 5
    	iconLabel.Parent           = inner
    	self._iconLabel = iconLabel
    
    	-- Name
    	local nameLabel = Instance.new("TextLabel")
    	nameLabel.Size             = UDim2.new(1, -52, 1, 0)
    	nameLabel.BackgroundTransparency = 1
    	nameLabel.Text             = self._name
    	nameLabel.TextColor3       = theme.Text
    	nameLabel.Font             = Enum.Font.GothamBold
    	nameLabel.TextSize         = 13
    	nameLabel.TextXAlignment   = Enum.TextXAlignment.Left
    	nameLabel.ZIndex           = 5
    	nameLabel.Parent           = inner
    	self._nameLabel = nameLabel
    
    	-- Arrow indicator
    	local arrow = Instance.new("TextLabel")
    	arrow.Size             = UDim2.new(0, 20, 1, 0)
    	arrow.AnchorPoint      = Vector2.new(1, 0.5)
    	arrow.Position         = UDim2.new(1, -8, 0.5, 0)
    	arrow.BackgroundTransparency = 1
    	arrow.Text             = "▾"
    	arrow.TextColor3       = theme.TextSecondary
    	arrow.Font             = Enum.Font.GothamBold
    	arrow.TextSize         = 12
    	arrow.ZIndex           = 5
    	arrow.Parent           = header
    	self._arrow = arrow
    
    	-- Badge
    	self._badge      = nil
    	self._badgeLabel = nil
    
    	-- ── Children container (in sidebar) ───────────────
    	local childContainer = Instance.new("Frame")
    	childContainer.Name             = "DTChildren_" .. self._name
    	childContainer.Size             = UDim2.new(1, 0, 0, 0) -- auto-sized
    	childContainer.BackgroundTransparency = 1
    	childContainer.ClipsDescendants = true
    	childContainer.Visible          = self._visible
    	childContainer.ZIndex           = 3
    	childContainer.Parent           = window._sidebar
    	self._childContainer = childContainer
    
    	Utility.Padding(0, 4, 0, 12, childContainer)
    	local childList = Utility.ListLayout(nil, nil, UDim.new(0, 4), childContainer)
    	self._childList = childList
    
    	-- Track content height to drive clip animation
    	local function updateHeight()
    		-- Small delay so layout has time to settle
    		task.defer(function()
    			if not childContainer.Parent then return end
    			local targetH = self._expanded and childList.AbsoluteContentSize.Y + 8 or 0
    			Utility.Tween(childContainer, {Size = UDim2.new(1, 0, 0, targetH)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    		end)
    	end
    
    	table.insert(self._connections,
    		childList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateHeight)
    	)
    
    	-- ── Content page (shared with sidebar page or own page) ─
    	-- DropdownTab controls render in their own ScrollingFrame
    	-- embedded inside a Tab page when nested, or directly in Window._contentArea.
    	-- For simplicity: they render inline in the sidebar's child container
    	-- (like standard sidebar groups). Controls live in a content scroll frame
    	-- that is shown when a child tab-button is selected.
    	--
    	-- Alternatively (and more flexibly), DropdownTabs own a
    	-- dedicated content page just like a Tab.
    	local page = Instance.new("Frame")
    	page.Name              = "DTContent_" .. self._name
    	page.Size              = UDim2.new(1, 0, 0, 0)
    	page.AutomaticSize     = Enum.AutomaticSize.Y
    	page.BackgroundTransparency = 1
    	page.Visible           = false
    	page.ZIndex            = 2
    	page.Parent            = window._contentArea
    	self._contentPage = page
    
    	local contentList = Utility.ListLayout(nil, nil, UDim.new(0, 6), page)
    	self._contentList = contentList
    
    	-- ── Header click: toggle expand/collapse ───────────
    	table.insert(self._connections, header.MouseButton1Click:Connect(function()
    		self:Toggle()
    		-- Also activate this tab's content page
    		self:_selectContent()
    	end))
    
    	-- Hover effect
    	table.insert(self._connections, header.MouseEnter:Connect(function()
    		Utility.Tween(header, {BackgroundColor3 = Theme.Color("Surface")}, 0.12)
    	end))
    	table.insert(self._connections, header.MouseLeave:Connect(function()
    		Utility.Tween(header, {BackgroundColor3 = Theme.Color("BackgroundTertiary")}, 0.12)
    	end))
    
    	-- Set initial collapsed state
    	if self._expanded then
    		childContainer.Size = UDim2.new(1, 0, 0, 300) -- large initial; will correct after layout
    		self._arrow.Rotation = 0
    	else
    		childContainer.Size = UDim2.new(1, 0, 0, 0)
    		self._arrow.Rotation = -90
    	end
    
    	-- Initialise with correct height after first render
    	task.defer(updateHeight)
    
    	return self
    end
    
    -- ── Select content page ───────────────────────────────
    function DropdownTab:_selectContent()
    	self._window:SetActiveContent(self._contentPage)
    end
    
    -- ── Toggle ────────────────────────────────────────────
    function DropdownTab:Toggle()
    	if self._expanded then
    		self:Collapse()
    	else
    		self:Expand()
    	end
    end
    
    function DropdownTab:Expand()
    	if self._expanded then return end
    	self._expanded = true
    	local targetH = self._childList.AbsoluteContentSize.Y + 8
    	Utility.Tween(self._childContainer, {Size = UDim2.new(1, 0, 0, targetH)}, 0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    	Utility.Tween(self._arrow, {Rotation = 0}, 0.2)
    end
    
    function DropdownTab:Collapse()
    	if not self._expanded then return end
    	self._expanded = false
    	Utility.Tween(self._childContainer, {Size = UDim2.new(1, 0, 0, 0)}, 0.22, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    	Utility.Tween(self._arrow, {Rotation = -90}, 0.2)
    end
    
    -- ── Badge ─────────────────────────────────────────────
    function DropdownTab:SetBadge(count: number?)
    	if count and count > 0 then
    		if not self._badge then
    			local badge = Instance.new("Frame")
    			badge.Size             = UDim2.new(0, 18, 0, 18)
    			badge.AnchorPoint      = Vector2.new(1, 0.5)
    			badge.Position         = UDim2.new(1, -26, 0.5, 0)
    			badge.BackgroundColor3 = Theme.Color("Error")
    			badge.ZIndex           = 7
    			badge.Parent           = self._header
    			Utility.Corner(9, badge)
    
    			local badgeLbl = Instance.new("TextLabel")
    			badgeLbl.Size             = UDim2.new(1, 0, 1, 0)
    			badgeLbl.BackgroundTransparency = 1
    			badgeLbl.TextColor3       = Color3.fromHex("#FFFFFF")
    			badgeLbl.Font             = Enum.Font.GothamBold
    			badgeLbl.TextSize         = 9
    			badgeLbl.ZIndex           = 8
    			badgeLbl.Parent           = badge
    			self._badge      = badge
    			self._badgeLabel = badgeLbl
    		end
    		(self._badgeLabel :: TextLabel).Text = tostring(math.min(count, 99))
    		(self._badge :: Frame).Visible = true
    	else
    		if self._badge then
    			(self._badge :: Frame).Visible = false
    		end
    	end
    end
    
    -- ── Icon ──────────────────────────────────────────────
    function DropdownTab:SetIcon(icon: string)
    	self._iconLabel.Text = icon
    end
    
    -- ── Visibility ────────────────────────────────────────
    function DropdownTab:SetVisible(visible: boolean)
    	self._visible = visible
    	self._header.Visible         = visible
    	self._childContainer.Visible = visible
    end
    
    -- ── Search integration ────────────────────────────────
    function DropdownTab:_searchControls(query: string)
    	local q = query:lower()
    	local empty = q == ""
    	local anyMatch = false
    
    	for _, ctrl in ipairs(self._controls) do
    		if ctrl._frame then
    			local name = tostring(ctrl._name or ""):lower()
    			local match = empty or name:find(q, 1, true) ~= nil
    			ctrl._frame.Visible = match
    			if match and not empty then
    				anyMatch = true
    				Utility.Tween(ctrl._frame, {BackgroundColor3 = Theme.Color("AccentDim")}, 0.15)
    				task.delay(1.5, function()
    					if ctrl._frame then
    						Utility.Tween(ctrl._frame, {BackgroundColor3 = Theme.Color("Surface")}, 0.3)
    					end
    				end)
    			end
    		end
    	end
    
    	-- Recurse into children
    	for _, child in ipairs(self._children) do
    		child:_searchControls(query)
    	end
    
    	-- Auto-expand if any match found
    	if anyMatch and not self._expanded then
    		self:Expand()
    		self:_selectContent()
    	end
    
    	-- Show/hide the whole group header
    	if not empty then
    		local headerVisible = anyMatch or Utility.ContainsCI(self._name, query)
    		self._header.Visible = headerVisible
    		self._childContainer.Visible = headerVisible
    	else
    		self._header.Visible = self._visible
    		self._childContainer.Visible = self._visible
    	end
    end
    
    -- ── Nested DropdownTab ────────────────────────────────
    function DropdownTab:CreateDropdownTab(config: Types.DropdownTabConfig | string)
    	local cfgTable: Types.DropdownTabConfig
    	if type(config) == "string" then
    		cfgTable = {Name = config}
    	else
    		cfgTable = config :: Types.DropdownTabConfig
    	end
    
    	-- Create a sub-group that renders inside childContainer rather than window._sidebar
    	local sub = setmetatable({} :: any, DropdownTab)
    	sub._type        = "dropdowntab"
    	sub._name        = cfgTable.Name or "SubGroup"
    	sub._window      = self._window
    	sub._expanded    = if cfgTable.DefaultOpen ~= nil then cfgTable.DefaultOpen else false
    	sub._controls    = {}
    	sub._children    = {}
    	sub._connections = {}
    	sub._visible     = cfgTable.Visible ~= false
    
    	local theme = Theme.Get()
    
    	-- Sub-header
    	local subHeader = Instance.new("TextButton")
    	subHeader.Size             = UDim2.new(1, 0, 0, 30)
    	subHeader.BackgroundColor3 = theme.Surface
    	subHeader.AutoButtonColor  = false
    	subHeader.Text             = ""
    	subHeader.ZIndex           = 4
    	subHeader.Parent           = self._childContainer
    	Utility.Corner(6, subHeader)
    
    	local subInner = Instance.new("Frame")
    	subInner.Size             = UDim2.new(1, 0, 1, 0)
    	subInner.BackgroundTransparency = 1
    	subInner.ZIndex           = 5
    	subInner.Parent           = subHeader
    
    	local _subLayout = Instance.new("UIListLayout")
    	_subLayout.FillDirection     = Enum.FillDirection.Horizontal
    	_subLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    	_subLayout.Padding           = UDim.new(0, 6)
    	_subLayout.Parent            = subInner
    	Utility.Padding(0, 0, 0, 8, subInner)
    
    	local subIcon = Instance.new("TextLabel")
    	subIcon.Size             = UDim2.new(0, 14, 1, 0)
    	subIcon.BackgroundTransparency = 1
    	subIcon.Text             = cfgTable.Icon or "◈"
    	subIcon.TextColor3       = theme.AccentHover
    	subIcon.Font             = Enum.Font.Gotham
    	subIcon.TextSize         = 11
    	subIcon.ZIndex           = 6
    	subIcon.Parent           = subInner
    
    	local subName = Instance.new("TextLabel")
    	subName.Size             = UDim2.new(1, -36, 1, 0)
    	subName.BackgroundTransparency = 1
    	subName.Text             = sub._name
    	subName.TextColor3       = theme.TextSecondary
    	subName.Font             = Enum.Font.GothamBold
    	subName.TextSize         = 12
    	subName.TextXAlignment   = Enum.TextXAlignment.Left
    	subName.ZIndex           = 6
    	subName.Parent           = subInner
    
    	local subArrow = Instance.new("TextLabel")
    	subArrow.Size             = UDim2.new(0, 16, 1, 0)
    	subArrow.AnchorPoint      = Vector2.new(1, 0.5)
    	subArrow.Position         = UDim2.new(1, -6, 0.5, 0)
    	subArrow.BackgroundTransparency = 1
    	subArrow.Text             = "▾"
    	subArrow.TextColor3       = theme.TextSecondary
    	subArrow.Font             = Enum.Font.GothamBold
    	subArrow.TextSize         = 10
    	subArrow.ZIndex           = 6
    	subArrow.Parent           = subHeader
    
    	-- Sub child container (inline in this parent's child container)
    	local subChildren = Instance.new("Frame")
    	subChildren.Size             = UDim2.new(1, 0, 0, 0)
    	subChildren.BackgroundTransparency = 1
    	subChildren.ClipsDescendants = true
    	subChildren.ZIndex           = 4
    	subChildren.Parent           = self._childContainer
    
    	Utility.Padding(0, 4, 0, 12, subChildren)
    	local subList = Utility.ListLayout(nil, nil, UDim.new(0, 4), subChildren)
    
    	sub._header         = subHeader
    	sub._arrow          = subArrow
    	sub._childContainer = subChildren
    	sub._childList      = subList
    	sub._iconLabel      = subIcon
    	sub._nameLabel      = subName
    	sub._badge          = nil
    	sub._badgeLabel     = nil
    
    	-- Sub uses parent's content page
    	sub._contentPage    = self._contentPage
    	sub._contentList    = self._contentList
    
    	-- Height recalculation
    	local function updateSubHeight()
    		task.defer(function()
    			if not subChildren.Parent then return end
    			local targetH = sub._expanded and subList.AbsoluteContentSize.Y + 8 or 0
    			Utility.Tween(subChildren, {Size = UDim2.new(1, 0, 0, targetH)}, 0.22)
    		end)
    	end
    	table.insert(sub._connections, subList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSubHeight))
    
    	table.insert(sub._connections, subHeader.MouseButton1Click:Connect(function()
    		sub:Toggle()
    	end))
    
    	if not sub._expanded then
    		subChildren.Size = UDim2.new(1, 0, 0, 0)
    		subArrow.Rotation = -90
    	end
    
    	table.insert(self._children, sub)
    	return sub
    end
    
    -- ── Control factory ───────────────────────────────────
    local function _requireControls()
    	return BasicControls
    end
    local function _requireDisplay()
    	return DisplayControls
    end
    local function _requireInputCtrl()
    	return InputControls
    end
    local function _requireData()
    	return DataControls
    end
    
    local function _addControl(self: any, ctrl: any)
    	-- Controls render in the contentPage, their frame just needs parenting there
    	ctrl._frame.Parent = self._contentPage
    	-- But also in childContainer for search-visible sidebar items? No.
    	-- The contentPage is the main content area. Controls show when this group is selected.
    	table.insert(self._controls, ctrl)
    	return ctrl
    end
    
    -- Override Select for DropdownTab - clicking header shows content
    function DropdownTab:_selectContent()
    	self._window:SetActiveContent(self._contentPage)
    end
    
    function DropdownTab:CreateButton(cfg: Types.ButtonConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Button.new(cfg :: Types.ButtonConfig))
    end
    function DropdownTab:CreateToggle(cfg: Types.ToggleConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Toggle.new(cfg :: Types.ToggleConfig))
    end
    function DropdownTab:CreateSlider(cfg: Types.SliderConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Slider.new(cfg :: Types.SliderConfig))
    end
    function DropdownTab:CreateDropdown(cfg: Types.DropdownConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Dropdown.new(cfg :: Types.DropdownConfig))
    end
    function DropdownTab:CreateTextbox(cfg: Types.TextboxConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Textbox.new(cfg :: Types.TextboxConfig))
    end
    function DropdownTab:CreateLabel(cfg: Types.LabelConfig | string)
    	if type(cfg) == "string" then cfg = {Text = cfg} end
    	return _addControl(self, _requireDisplay().Label.new(cfg :: Types.LabelConfig))
    end
    function DropdownTab:CreateParagraph(cfg: Types.ParagraphConfig)
    	return _addControl(self, _requireDisplay().Paragraph.new(cfg))
    end
    function DropdownTab:CreateSection(cfg: Types.SectionConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireControls().Section.new(cfg :: Types.SectionConfig))
    end
    function DropdownTab:CreateSeparator(cfg: Types.SeparatorConfig?)
    	return _addControl(self, _requireControls().Separator.new(cfg or {}))
    end
    function DropdownTab:CreateColorPicker(cfg: Types.ColorPickerConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireInputCtrl().ColorPicker.new(cfg :: Types.ColorPickerConfig))
    end
    function DropdownTab:CreateKeybind(cfg: Types.KeybindConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireInputCtrl().Keybind.new(cfg :: Types.KeybindConfig))
    end
    function DropdownTab:CreateProgressBar(cfg: Types.ProgressBarConfig | string)
    	if type(cfg) == "string" then cfg = {Name = cfg} end
    	return _addControl(self, _requireDisplay().ProgressBar.new(cfg :: Types.ProgressBarConfig))
    end
    function DropdownTab:CreateImage(cfg: Types.ImageConfig)
    	return _addControl(self, _requireDisplay().Image.new(cfg))
    end
    
    -- ── Destroy ───────────────────────────────────────────
    function DropdownTab:Destroy()
    	for _, c in ipairs(self._connections) do
    		pcall(c.Disconnect, c)
    	end
    	table.clear(self._connections)
    	if self._header then self._header:Destroy() end
    	if self._childContainer then self._childContainer:Destroy() end
    	if self._contentPage then self._contentPage:Destroy() end
    	for _, child in ipairs(self._children) do
    		pcall(child.Destroy, child)
    	end
    	table.clear(self._children)
    	table.clear(self._controls)
    end
    
    return DropdownTab
    
end)()

Window = (function()
    -- LuminaUI :: Components/Window.luau
    -- Main window: top bar, stats, drag, resize, minimize, maximize, close.
    -- ──────────────────────────────────────────────────────
    
    local RunService       = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local TweenService     = game:GetService("TweenService")
    local Players          = game:GetService("Players")
    local Stats            = game:GetService("Stats")
    
    local Utility = Utility
    local Theme   = Theme
    local Types   = Types
    
    type WindowConfig = Types.WindowConfig
    
    -- ══════════════════════════════════════════════════════
    -- § Window class
    -- ══════════════════════════════════════════════════════
    
    local Window = {}
    Window.__index = Window
    
    export type WindowObject = typeof(setmetatable({} :: {
    	-- internal refs
    	_screenGui:       ScreenGui,
    	_mainFrame:       Frame,
    	_topBar:          Frame,
    	_sidebar:         Frame,
    	_contentArea:     ScrollingFrame,
    	_resizeHandle:    Frame,
    	_minimized:       boolean,
    	_hidden:          boolean,
    	_locked:          boolean,
    	_connections:     {RBXScriptConnection},
    	_themeDisconnect: () -> (),
    	_tabs:            {any},
    	_activeTab:       any?,
    	_searchModule:    any?,
    	-- stat labels
    	_lblFPS:  TextLabel,
    	_lblPing: TextLabel,
    	_lblTime: TextLabel,
    	_lblUser: TextLabel,
    	_lblExec: TextLabel,
    	-- tween cache
    	_tweenMinimize:  Tween?,
    	_tweenMaximize:  Tween?,
    }, Window))
    
    -- ── Constructor ───────────────────────────────────────
    
    function Window.new(config: WindowConfig): WindowObject
    	config = config or {}
    	local self = setmetatable({} :: any, Window)
    
    	self._minimized = false
    	self._hidden    = false
    	self._locked    = false
    	self._connections = {}
    	self._tabs        = {}
    	self._activeTab   = nil
    
    	local theme = Theme.Get()
    	local winSize = config.Size or UDim2.new(0, 860, 0, 560)
    	local winPos  = config.Position or UDim2.new(0.5, -430, 0.5, -280)
    
    	-- ── ScreenGui ──────────────────────────────────────
    	local sg = Instance.new("ScreenGui")
    	sg.Name                    = "LuminaUI"
    	sg.ResetOnSpawn            = false
    	sg.ZIndexBehavior          = Enum.ZIndexBehavior.Sibling
    	sg.IgnoreGuiInset          = true
    	sg.DisplayOrder            = 100
    	sg.Parent                  = game:GetService("CoreGui")
    	self._screenGui = sg
    
    	-- ── Shadow frame ───────────────────────────────────
    	local shadow = Instance.new("ImageLabel")
    	shadow.Name                = "Shadow"
    	shadow.Size                = UDim2.new(1, 30, 1, 30)
    	shadow.Position            = UDim2.new(0, -15, 0, -15)
    	shadow.BackgroundTransparency = 1
    	shadow.Image               = "rbxassetid://1316045217" -- Roblox drop shadow asset
    	shadow.ImageColor3         = theme.Shadow
    	shadow.ImageTransparency   = 0.6
    	shadow.ScaleType           = Enum.ScaleType.Slice
    	shadow.SliceCenter         = Rect.new(10, 10, 118, 118)
    	shadow.ZIndex              = 0
    	shadow.Parent              = sg
    
    	-- ── Main Frame ─────────────────────────────────────
    	local main = Instance.new("Frame")
    	main.Name                  = "MainFrame"
    	main.Size                  = winSize
    	main.Position              = winPos
    	main.BackgroundColor3      = theme.Background
    	main.ClipsDescendants      = true
    	main.ZIndex                = 1
    	main.Parent                = sg
    	self._mainFrame = main
    
    	-- Attach shadow to main
    	shadow.Parent = main
    	Instance.new("UICorner").CornerRadius = UDim.new(0, 12)
    	local _mainCorner = Instance.new("UICorner")
    	_mainCorner.CornerRadius = UDim.new(0, 12)
    	_mainCorner.Parent = main
    
    	local _mainStroke = Instance.new("UIStroke")
    	_mainStroke.Thickness = 1
    	_mainStroke.Color     = theme.Border
    	_mainStroke.Parent    = main
    
    	-- ── Top Bar ────────────────────────────────────────
    	local topBar = Instance.new("Frame")
    	topBar.Name              = "TopBar"
    	topBar.Size              = UDim2.new(1, 0, 0, 48)
    	topBar.Position          = UDim2.new(0, 0, 0, 0)
    	topBar.BackgroundColor3  = theme.BackgroundSecondary
    	topBar.ZIndex            = 2
    	topBar.Parent            = main
    	self._topBar = topBar
    
    	local _topCorner = Instance.new("UICorner")
    	_topCorner.CornerRadius = UDim.new(0, 12)
    	_topCorner.Parent = topBar
    
    	-- Mask bottom corners of topbar
    	local topBarMask = Instance.new("Frame")
    	topBarMask.Name             = "BottomMask"
    	topBarMask.Size             = UDim2.new(1, 0, 0, 12)
    	topBarMask.Position         = UDim2.new(0, 0, 1, -12)
    	topBarMask.BackgroundColor3 = theme.BackgroundSecondary
    	topBarMask.BorderSizePixel  = 0
    	topBarMask.ZIndex           = 2
    	topBarMask.Parent           = topBar
    
    	-- Divider under topbar
    	local divider = Instance.new("Frame")
    	divider.Name             = "Divider"
    	divider.Size             = UDim2.new(1, 0, 0, 1)
    	divider.Position         = UDim2.new(0, 0, 0, 47)
    	divider.BackgroundColor3 = theme.Border
    	divider.ZIndex           = 2
    	divider.Parent           = main
    
    	-- ── Logo / Title ───────────────────────────────────
    	local logoFrame = Instance.new("Frame")
    	logoFrame.Name             = "LogoArea"
    	logoFrame.Size             = UDim2.new(0, 200, 1, 0)
    	logoFrame.BackgroundTransparency = 1
    	logoFrame.Position         = UDim2.new(0, 0, 0, 0)
    	logoFrame.ZIndex           = 3
    	logoFrame.Parent           = topBar
    
    	Utility.Padding(0, 0, 0, 14, logoFrame)
    
    	local _logoLayout = Instance.new("UIListLayout")
    	_logoLayout.FillDirection        = Enum.FillDirection.Horizontal
    	_logoLayout.VerticalAlignment    = Enum.VerticalAlignment.Center
    	_logoLayout.Padding              = UDim.new(0, 8)
    	_logoLayout.Parent               = logoFrame
    
    	-- Accent dot (logo placeholder)
    	local accentDot = Instance.new("Frame")
    	accentDot.Name             = "AccentDot"
    	accentDot.Size             = UDim2.new(0, 22, 0, 22)
    	accentDot.BackgroundColor3 = theme.Accent
    	accentDot.ZIndex           = 3
    	accentDot.Parent           = logoFrame
    	local _dotCorner = Instance.new("UICorner")
    	_dotCorner.CornerRadius = UDim.new(0, 6)
    	_dotCorner.Parent = accentDot
    
    	-- "L" letter in dot
    	local dotLabel = Instance.new("TextLabel")
    	dotLabel.Size             = UDim2.new(1, 0, 1, 0)
    	dotLabel.BackgroundTransparency = 1
    	dotLabel.Text             = "L"
    	dotLabel.TextColor3       = theme.TextInverted
    	dotLabel.Font             = Enum.Font.GothamBold
    	dotLabel.TextSize         = 13
    	dotLabel.ZIndex           = 4
    	dotLabel.Parent           = accentDot
    
    	if config.Logo and config.Logo ~= "" then
    		local logoImg = Instance.new("ImageLabel")
    		logoImg.Size              = UDim2.new(0, 22, 0, 22)
    		logoImg.BackgroundTransparency = 1
    		logoImg.Image             = config.Logo
    		logoImg.ZIndex            = 3
    		logoImg.Parent            = logoFrame
    		dotLabel.Visible = false
    		accentDot.BackgroundTransparency = 1
    	end
    
    	local titleLabel = Instance.new("TextLabel")
    	titleLabel.Name             = "Title"
    	titleLabel.Size             = UDim2.new(0, 140, 1, 0)
    	titleLabel.BackgroundTransparency = 1
    	titleLabel.Text             = config.Title or "LuminaUI"
    	titleLabel.TextColor3       = theme.Text
    	titleLabel.Font             = Enum.Font.GothamBold
    	titleLabel.TextSize         = 15
    	titleLabel.TextXAlignment   = Enum.TextXAlignment.Left
    	titleLabel.ZIndex           = 3
    	titleLabel.Parent           = logoFrame
    
    	if config.SubTitle and config.SubTitle ~= "" then
    		local subLabel = Instance.new("TextLabel")
    		subLabel.Name             = "SubTitle"
    		subLabel.Size             = UDim2.new(0, 100, 0, 14)
    		subLabel.BackgroundTransparency = 1
    		subLabel.Text             = config.SubTitle
    		subLabel.TextColor3       = theme.TextSecondary
    		subLabel.Font             = Enum.Font.Gotham
    		subLabel.TextSize         = 11
    		subLabel.TextXAlignment   = Enum.TextXAlignment.Left
    		subLabel.ZIndex           = 3
    		subLabel.Parent           = topBar
    		subLabel.Position         = UDim2.new(0, 60, 0, 28)
    	end
    
    	-- ── Stats row (center) ─────────────────────────────
    	local statsFrame = Instance.new("Frame")
    	statsFrame.Name             = "Stats"
    	statsFrame.Size             = UDim2.new(0, 300, 1, 0)
    	statsFrame.AnchorPoint      = Vector2.new(0.5, 0)
    	statsFrame.Position         = UDim2.new(0.5, 0, 0, 0)
    	statsFrame.BackgroundTransparency = 1
    	statsFrame.ZIndex           = 3
    	statsFrame.Parent           = topBar
    
    	local _statsLayout = Instance.new("UIListLayout")
    	_statsLayout.FillDirection      = Enum.FillDirection.Horizontal
    	_statsLayout.VerticalAlignment  = Enum.VerticalAlignment.Center
    	_statsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    	_statsLayout.Padding            = UDim.new(0, 18)
    	_statsLayout.Parent             = statsFrame
    
    	local function makeStat(icon: string, value: string): TextLabel
    		local f = Instance.new("Frame")
    		f.Size             = UDim2.new(0, 64, 0, 28)
    		f.BackgroundColor3 = theme.Surface
    		f.ZIndex           = 3
    		f.Parent           = statsFrame
    		local _fc = Instance.new("UICorner")
    		_fc.CornerRadius = UDim.new(0, 6)
    		_fc.Parent = f
    
    		local l = Instance.new("UIListLayout")
    		l.FillDirection     = Enum.FillDirection.Horizontal
    		l.VerticalAlignment = Enum.VerticalAlignment.Center
    		l.HorizontalAlignment = Enum.HorizontalAlignment.Center
    		l.Padding           = UDim.new(0, 4)
    		l.Parent            = f
    
    		local iconLbl = Instance.new("TextLabel")
    		iconLbl.Size             = UDim2.new(0, 14, 1, 0)
    		iconLbl.BackgroundTransparency = 1
    		iconLbl.Text             = icon
    		iconLbl.TextColor3       = theme.Accent
    		iconLbl.Font             = Enum.Font.Gotham
    		iconLbl.TextSize         = 11
    		iconLbl.ZIndex           = 4
    		iconLbl.Parent           = f
    
    		local valLbl = Instance.new("TextLabel")
    		valLbl.Name             = "Value"
    		valLbl.Size             = UDim2.new(0, 40, 1, 0)
    		valLbl.BackgroundTransparency = 1
    		valLbl.Text             = value
    		valLbl.TextColor3       = theme.Text
    		valLbl.Font             = Enum.Font.Gotham
    		valLbl.TextSize         = 11
    		valLbl.TextXAlignment   = Enum.TextXAlignment.Left
    		valLbl.ZIndex           = 4
    		valLbl.Parent           = f
    
    		return valLbl
    	end
    
    	self._lblFPS  = makeStat("⚡", "0 FPS")
    	self._lblPing = makeStat("📶", "0ms")
    	self._lblTime = makeStat("🕐", "00:00")
    
    	-- ── Window control buttons (right) ─────────────────
    	local controlsFrame = Instance.new("Frame")
    	controlsFrame.Name  = "Controls"
    	controlsFrame.Size  = UDim2.new(0, 120, 1, 0)
    	controlsFrame.AnchorPoint = Vector2.new(1, 0)
    	controlsFrame.Position = UDim2.new(1, 0, 0, 0)
    	controlsFrame.BackgroundTransparency = 1
    	controlsFrame.ZIndex = 3
    	controlsFrame.Parent = topBar
    
    	local _ctrlLayout = Instance.new("UIListLayout")
    	_ctrlLayout.FillDirection       = Enum.FillDirection.Horizontal
    	_ctrlLayout.VerticalAlignment   = Enum.VerticalAlignment.Center
    	_ctrlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    	_ctrlLayout.Padding             = UDim.new(0, 6)
    	_ctrlLayout.Parent              = controlsFrame
    	Utility.Padding(0, 12, 0, 0, controlsFrame)
    
    	local function makeCtrlBtn(icon: string, color: Color3): TextButton
    		local btn = Instance.new("TextButton")
    		btn.Size             = UDim2.new(0, 26, 0, 26)
    		btn.BackgroundColor3 = theme.Surface
    		btn.Text             = icon
    		btn.TextColor3       = color
    		btn.Font             = Enum.Font.GothamBold
    		btn.TextSize         = 13
    		btn.AutoButtonColor  = false
    		btn.ZIndex           = 4
    		btn.Parent           = controlsFrame
    		local _bc = Instance.new("UICorner")
    		_bc.CornerRadius = UDim.new(0, 6)
    		_bc.Parent = btn
    
    		local function onEnter()
    			Utility.Tween(btn, {BackgroundColor3 = theme.SurfaceHover}, 0.12)
    		end
    		local function onLeave()
    			Utility.Tween(btn, {BackgroundColor3 = theme.Surface}, 0.12)
    		end
    		table.insert(self._connections, btn.MouseEnter:Connect(onEnter))
    		table.insert(self._connections, btn.MouseLeave:Connect(onLeave))
    
    		return btn
    	end
    
    	-- Minimize button
    	local btnMinimize = makeCtrlBtn("−", theme.TextSecondary)
    	table.insert(self._connections, btnMinimize.MouseButton1Click:Connect(function()
    		self:Minimize()
    	end))
    
    	-- Maximize button
    	local btnMaximize = makeCtrlBtn("□", theme.TextSecondary)
    	table.insert(self._connections, btnMaximize.MouseButton1Click:Connect(function()
    		self:Maximize()
    	end))
    
    	-- Close button
    	local btnClose = makeCtrlBtn("✕", theme.Error)
    	table.insert(self._connections, btnClose.MouseButton1Click:Connect(function()
    		self:Destroy()
    	end))
    
    	-- ── Body: Sidebar + Content ─────────────────────────
    	local bodyFrame = Instance.new("Frame")
    	bodyFrame.Name             = "Body"
    	bodyFrame.Size             = UDim2.new(1, 0, 1, -48)
    	bodyFrame.Position         = UDim2.new(0, 0, 0, 48)
    	bodyFrame.BackgroundTransparency = 1
    	bodyFrame.ZIndex           = 2
    	bodyFrame.Parent           = main
    
    	-- Sidebar container
    	local sidebarFrame = Instance.new("ScrollingFrame")
    	sidebarFrame.Name              = "Sidebar"
    	sidebarFrame.Size              = UDim2.new(0, 190, 1, 0)
    	sidebarFrame.Position          = UDim2.new(0, 0, 0, 0)
    	sidebarFrame.BackgroundColor3  = theme.BackgroundSecondary
    	sidebarFrame.BorderSizePixel   = 0
    	sidebarFrame.ScrollBarThickness = 2
    	sidebarFrame.ScrollBarImageColor3 = theme.Scrollbar
    	sidebarFrame.CanvasSize        = UDim2.new(0, 0, 0, 0)
    	sidebarFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    	sidebarFrame.ClipsDescendants  = true
    	sidebarFrame.ZIndex            = 2
    	sidebarFrame.Parent            = bodyFrame
    	self._sidebar = sidebarFrame
    
    	Utility.Padding(8, 8, 8, 8, sidebarFrame)
    	local _sidebarList = Utility.ListLayout(nil, nil, UDim.new(0, 4), sidebarFrame)
    
    	-- Sidebar / content divider
    	local sideDivider = Instance.new("Frame")
    	sideDivider.Name             = "SideDivider"
    	sideDivider.Size             = UDim2.new(0, 1, 1, 0)
    	sideDivider.Position         = UDim2.new(0, 190, 0, 0)
    	sideDivider.BackgroundColor3 = theme.Border
    	sideDivider.ZIndex           = 3
    	sideDivider.Parent           = bodyFrame
    
    	-- Content ScrollingFrame
    	local contentArea = Instance.new("ScrollingFrame")
    	contentArea.Name              = "ContentArea"
    	contentArea.Size              = UDim2.new(1, -191, 1, 0)
    	contentArea.Position          = UDim2.new(0, 191, 0, 0)
    	contentArea.BackgroundColor3  = theme.Background
    	contentArea.BorderSizePixel   = 0
    	contentArea.ScrollBarThickness = 4
    	contentArea.ScrollBarImageColor3 = theme.Scrollbar
    	contentArea.CanvasSize        = UDim2.new(0, 0, 0, 0)
    	contentArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
    	contentArea.ClipsDescendants  = true
    	contentArea.ZIndex            = 2
    	contentArea.Parent            = bodyFrame
    	self._contentArea = contentArea
    
    	Utility.Padding(10, 12, 10, 12, contentArea)
    	local _contentList = Utility.ListLayout(nil, nil, UDim.new(0, 6), contentArea)
    
    	-- ── Resize handle ──────────────────────────────────
    	local resizeHandle = Instance.new("Frame")
    	resizeHandle.Name             = "ResizeHandle"
    	resizeHandle.Size             = UDim2.new(0, 14, 0, 14)
    	resizeHandle.AnchorPoint      = Vector2.new(1, 1)
    	resizeHandle.Position         = UDim2.new(1, 0, 1, 0)
    	resizeHandle.BackgroundColor3 = theme.Accent
    	resizeHandle.BackgroundTransparency = 0.6
    	resizeHandle.ZIndex           = 10
    	resizeHandle.Parent           = main
    	self._resizeHandle = resizeHandle
    	local _rhc = Instance.new("UICorner")
    	_rhc.CornerRadius = UDim.new(0, 4)
    	_rhc.Parent = resizeHandle
    
    	-- Resize grip icon
    	local gripLabel = Instance.new("TextLabel")
    	gripLabel.Size             = UDim2.new(1, 0, 1, 0)
    	gripLabel.BackgroundTransparency = 1
    	gripLabel.Text             = "⠿"
    	gripLabel.TextColor3       = theme.Accent
    	gripLabel.Font             = Enum.Font.Gotham
    	gripLabel.TextSize         = 9
    	gripLabel.ZIndex           = 11
    	gripLabel.Parent           = resizeHandle
    
    	-- ── Attach drag ────────────────────────────────────
    	local disconnectDrag = Utility.MakeDraggable(topBar, main)
    	self._themeDisconnect = Theme.OnChanged(function(p)
    		-- Update theme-sensitive properties
    		main.BackgroundColor3        = p.Background
    		topBar.BackgroundColor3      = p.BackgroundSecondary
    		topBarMask.BackgroundColor3  = p.BackgroundSecondary
    		divider.BackgroundColor3     = p.Border
    		sideDivider.BackgroundColor3 = p.Border
    		sidebarFrame.BackgroundColor3 = p.BackgroundSecondary
    		contentArea.BackgroundColor3 = p.Background
    		_mainStroke.Color            = p.Border
    		accentDot.BackgroundColor3   = p.Accent
    		self._lblFPS.TextColor3      = p.Text
    		self._lblPing.TextColor3     = p.Text
    		self._lblTime.TextColor3     = p.Text
    	end)
    
    	-- ── Attach resize ──────────────────────────────────
    	local disconnectResize = Utility.MakeResizable(
    		resizeHandle, main,
    		Vector2.new(600, 400),
    		Vector2.new(1200, 800)
    	)
    
    	-- ── FPS / Ping / Clock updater ─────────────────────
    	local fpsCount = 0
    	local fpsTimer = 0
    	local lastFPS  = 0
    
    	local updateConn = RunService.RenderStepped:Connect(function(dt)
    		fpsCount += 1
    		fpsTimer += dt
    		if fpsTimer >= 1 then
    			lastFPS    = fpsCount
    			fpsCount   = 0
    			fpsTimer   = 0
    			self._lblFPS.Text = lastFPS .. " FPS"
    
    			-- Ping
    			local ok, ping = pcall(function()
    				return math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString() + 0.5)
    			end)
    			self._lblPing.Text = (ok and tostring(ping) or "—") .. "ms"
    
    			-- Clock
    			local t = os.date("*t")
    			if t then
    				self._lblTime.Text = string.format("%02d:%02d", t.hour, t.min)
    			end
    		end
    	end)
    	table.insert(self._connections, updateConn)
    
    	-- ── User / exec stat labels ─────────────────────────
    	if config.ShowStats ~= false then
    		local userLabel = Instance.new("TextLabel")
    		userLabel.Name             = "UserLabel"
    		userLabel.Size             = UDim2.new(0, 160, 0, 18)
    		userLabel.Position         = UDim2.new(0, 14, 1, -22)
    		userLabel.BackgroundTransparency = 1
    		userLabel.Text             = "👤 " .. Utility.GetUsername()
    		userLabel.TextColor3       = theme.TextSecondary
    		userLabel.Font             = Enum.Font.Gotham
    		userLabel.TextSize         = 11
    		userLabel.TextXAlignment   = Enum.TextXAlignment.Left
    		userLabel.ZIndex           = 3
    		userLabel.Parent           = sidebarFrame
    		self._lblUser = userLabel
    
    		local execLabel = Instance.new("TextLabel")
    		execLabel.Name             = "ExecLabel"
    		execLabel.Size             = UDim2.new(0, 160, 0, 18)
    		execLabel.Position         = UDim2.new(0, 14, 1, -38)
    		execLabel.BackgroundTransparency = 1
    		execLabel.Text             = "⚙ " .. Utility.GetExecutor()
    		execLabel.TextColor3       = theme.TextSecondary
    		execLabel.Font             = Enum.Font.Gotham
    		execLabel.TextSize         = 11
    		execLabel.TextXAlignment   = Enum.TextXAlignment.Left
    		execLabel.ZIndex           = 3
    		execLabel.Parent           = sidebarFrame
    		self._lblExec = execLabel
    	end
    
    	-- Version label at bottom of sidebar
    	if config.Version then
    		local verLabel = Instance.new("TextLabel")
    		verLabel.Name             = "Version"
    		verLabel.Size             = UDim2.new(1, 0, 0, 16)
    		verLabel.AnchorPoint      = Vector2.new(0, 1)
    		verLabel.Position         = UDim2.new(0, 0, 1, -6)
    		verLabel.BackgroundTransparency = 1
    		verLabel.Text             = "v" .. config.Version
    		verLabel.TextColor3       = theme.TextDisabled
    		verLabel.Font             = Enum.Font.Gotham
    		verLabel.TextSize         = 10
    		verLabel.ZIndex           = 3
    		verLabel.Parent           = sidebarFrame
    	end
    
    	-- ── Search bar ─────────────────────────────────────
    	local searchFrame = Instance.new("Frame")
    	searchFrame.Name             = "SearchBar"
    	searchFrame.Size             = UDim2.new(1, -16, 0, 32)
    	searchFrame.Position         = UDim2.new(0, 8, 0, 8)
    	searchFrame.BackgroundColor3 = theme.Surface
    	searchFrame.ZIndex           = 3
    	searchFrame.Parent           = sidebarFrame
    	Utility.Corner(8, searchFrame)
    	Utility.Stroke(1, theme.Border, 0, searchFrame)
    
    	local searchIcon = Instance.new("TextLabel")
    	searchIcon.Size             = UDim2.new(0, 20, 1, 0)
    	searchIcon.Position         = UDim2.new(0, 6, 0, 0)
    	searchIcon.BackgroundTransparency = 1
    	searchIcon.Text             = "🔍"
    	searchIcon.TextSize         = 11
    	searchIcon.Font             = Enum.Font.Gotham
    	searchIcon.ZIndex           = 4
    	searchIcon.Parent           = searchFrame
    
    	local searchBox = Instance.new("TextBox")
    	searchBox.Name             = "SearchBox"
    	searchBox.Size             = UDim2.new(1, -52, 1, 0)
    	searchBox.Position         = UDim2.new(0, 28, 0, 0)
    	searchBox.BackgroundTransparency = 1
    	searchBox.PlaceholderText  = "Search..."
    	searchBox.PlaceholderColor3 = theme.TextDisabled
    	searchBox.Text             = ""
    	searchBox.TextColor3       = theme.Text
    	searchBox.Font             = Enum.Font.Gotham
    	searchBox.TextSize         = 12
    	searchBox.ClearTextOnFocus = false
    	searchBox.ZIndex           = 4
    	searchBox.Parent           = searchFrame
    
    	local clearBtn = Instance.new("TextButton")
    	clearBtn.Size             = UDim2.new(0, 20, 1, 0)
    	clearBtn.AnchorPoint      = Vector2.new(1, 0)
    	clearBtn.Position         = UDim2.new(1, -4, 0, 0)
    	clearBtn.BackgroundTransparency = 1
    	clearBtn.Text             = "✕"
    	clearBtn.TextColor3       = theme.TextDisabled
    	clearBtn.Font             = Enum.Font.GothamBold
    	clearBtn.TextSize         = 11
    	clearBtn.Visible          = false
    	clearBtn.ZIndex           = 4
    	clearBtn.Parent           = searchFrame
    
    	table.insert(self._connections, searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    		clearBtn.Visible = searchBox.Text ~= ""
    		self:_doSearch(searchBox.Text)
    	end))
    
    	table.insert(self._connections, clearBtn.MouseButton1Click:Connect(function()
    		searchBox.Text = ""
    	end))
    
    	-- Store disconnect helpers
    	table.insert(self._connections, {Disconnect = disconnectDrag} :: any)
    	table.insert(self._connections, {Disconnect = disconnectResize} :: any)
    
    	self._searchBox = searchBox
    
    	return self
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Internal search
    -- ══════════════════════════════════════════════════════
    
    function Window:_doSearch(query: string)
    	local q = query:lower()
    	local empty = q == ""
    
    	-- Iterate all registered tabs/controls
    	for _, tab in ipairs(self._tabs) do
    		if tab._type == "tab" then
    			local match = empty or Utility.ContainsCI(tab._name, query)
    			if tab._setVisible then
    				tab:_setVisible(empty or match)
    			end
    			-- Also search controls within tab
    			if tab._searchControls then
    				tab:_searchControls(query)
    			end
    		elseif tab._type == "dropdowntab" then
    			if tab._searchControls then
    				tab:_searchControls(query)
    			end
    		end
    	end
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Tab creation factory (forward reference populated by Tab module)
    -- ══════════════════════════════════════════════════════
    
    function Window:CreateTab(config: Types.TabConfig | string)
    	local Tab = Tab
    	local t: any
    	if type(config) == "string" then
    		t = Tab.new({Name = config}, self)
    	else
    		t = Tab.new(config :: Types.TabConfig, self)
    	end
    	table.insert(self._tabs, t)
    	-- Activate first tab automatically
    	if #self._tabs == 1 then
    		t:Select()
    	end
    	return t
    end
    
    function Window:CreateDropdownTab(config: Types.DropdownTabConfig | string)
    	local DropdownTab = DropdownTab
    	local t: any
    	if type(config) == "string" then
    		t = DropdownTab.new({Name = config}, self)
    	else
    		t = DropdownTab.new(config :: Types.DropdownTabConfig, self)
    	end
    	table.insert(self._tabs, t)
    	return t
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Window Actions
    -- ══════════════════════════════════════════════════════
    
    function Window:SetActiveContent(contentFrame: Frame)
    	-- Hide all tab content pages then show this one
    	for _, ch in ipairs(self._contentArea:GetChildren()) do
    		if ch:IsA("Frame") and ch.Name:find("TabContent") then
    			ch.Visible = false
    		end
    	end
    	contentFrame.Visible = true
    end
    
    function Window:Minimize()
    	if self._minimized then return end
    	self._minimized = true
    	Utility.Tween(self._mainFrame, {Size = UDim2.new(0, self._mainFrame.AbsoluteSize.X, 0, 48)}, 0.3)
    end
    
    function Window:Maximize()
    	if not self._minimized then return end
    	self._minimized = false
    	Utility.Tween(self._mainFrame, {Size = UDim2.new(0, self._mainFrame.AbsoluteSize.X, 0, 560)}, 0.3)
    end
    
    function Window:Hide()
    	self._hidden = true
    	Utility.Tween(self._mainFrame, {GroupTransparency = 1}, 0.2)
    	task.delay(0.25, function()
    		if self._mainFrame then
    			self._mainFrame.Visible = false
    		end
    	end)
    end
    
    function Window:Show()
    	self._hidden = false
    	self._mainFrame.Visible = true
    	Utility.Tween(self._mainFrame, {GroupTransparency = 0}, 0.2)
    end
    
    function Window:Toggle()
    	if self._hidden then self:Show() else self:Hide() end
    end
    
    function Window:LockPosition()
    	self._locked = true
    end
    
    function Window:UnlockPosition()
    	self._locked = false
    end
    
    function Window:Destroy()
    	-- Disconnect everything
    	for _, c in ipairs(self._connections) do
    		if type(c) == "table" and (c :: any).Disconnect then
    			pcall((c :: any).Disconnect, c)
    		elseif c and c.Connected then
    			pcall(c.Disconnect, c)
    		end
    	end
    	table.clear(self._connections)
    
    	if self._themeDisconnect then
    		pcall(self._themeDisconnect)
    	end
    
    	if self._screenGui then
    		self._screenGui:Destroy()
    	end
    end
    
    return Window
    
end)()

LibraryFactory = (function()
    -- LuminaUI :: Library.luau
    -- Root entry point. Creates the global Library object.
    -- Usage: local Library = LuminaUI
    -- ──────────────────────────────────────────────────────
    
    local Theme  = Theme
    local Config = Config
    local Types  = Types
    local Utility = Utility
    
    -- ── Lazy-loaded feedback modules ──────────────────────
    local _Notification: any = nil
    local _Dialog: any       = nil
    local _Loading: any      = nil
    
    local function getFeedback()
    	if not _Notification then
    		local m = Notification
    		_Notification = m.Notification
    		_Dialog       = m.Dialog
    	end
    	return _Notification, _Dialog
    end
    
    local function getLoading()
    	if not _Loading then
    		_Loading = Loading
    	end
    	return _Loading
    end
    
    -- ══════════════════════════════════════════════════════
    -- § Library
    -- ══════════════════════════════════════════════════════
    
    local Library = {}
    Library.__index = Library
    
    type LibraryObject = typeof(setmetatable({} :: {
    	_windows: {any},
    	_configName: string,
    }, Library))
    
    function Library.new(): LibraryObject
    	local self = setmetatable({} :: any, Library)
    	self._windows    = {}
    	self._configName = "LuminaUI"
    	return self
    end
    
    -- ── Window factory ─────────────────────────────────────
    function Library:CreateWindow(config: Types.WindowConfig | string?): any
    	local Window = Window
    	local cfg: Types.WindowConfig
    	if type(config) == "string" then
    		cfg = {Title = config}
    	elseif type(config) == "table" then
    		cfg = config :: Types.WindowConfig
    	else
    		cfg = {}
    	end
    	local w = Window.new(cfg)
    	table.insert(self._windows, w)
    	return w
    end
    
    -- ── Notification ──────────────────────────────────────
    function Library:Notify(config: Types.NotificationConfig)
    	local Notif, _ = getFeedback()
    	if Notif then
    		Notif.Push(config)
    	end
    end
    
    -- ── Dialog ────────────────────────────────────────────
    function Library:Dialog(config: Types.DialogConfig)
    	local _, Dlg = getFeedback()
    	if Dlg then
    		Dlg.Open(config)
    	end
    end
    
    -- ── Loading Screen ────────────────────────────────────
    function Library:CreateLoadingScreen(config: any): any
    	local Loading = getLoading()
    	return Loading.new(config)
    end
    
    -- ── Theme ─────────────────────────────────────────────
    function Library:SetTheme(name: Types.ThemeName)
    	Theme.Set(name)
    end
    
    function Library:SetCustomTheme(palette: Types.ThemePalette)
    	Theme.SetCustomPalette(palette)
    end
    
    function Library:GetTheme(): Types.ThemeName
    	return Theme.Current()
    end
    
    -- ── Config ────────────────────────────────────────────
    function Library:SetConfigName(name: string)
    	self._configName = name
    	Config.SetName(name)
    end
    
    function Library:SaveConfig()
    	Config.Save()
    end
    
    function Library:LoadConfig()
    	Config.Load()
    end
    
    function Library:DeleteConfig()
    	Config.Delete()
    end
    
    function Library:ExportConfig(): string
    	return Config.Export()
    end
    
    function Library:ImportConfig(json: string)
    	Config.Import(json)
    end
    
    -- ── Destroy everything ────────────────────────────────
    function Library:Destroy()
    	for _, w in ipairs(self._windows) do
    		pcall(w.Destroy, w)
    	end
    	table.clear(self._windows)
    end
    
    -- ── Singleton export ───────────────────────────────────
    local _instance: LibraryObject? = nil
    
    return function(): LibraryObject
    	if not _instance then
    		_instance = Library.new()
    	end
    	return _instance :: LibraryObject
    end
    
end)()

return LibraryFactory
