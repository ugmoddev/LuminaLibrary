local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()


local LuminaState = {
    CurrentTheme = "Dark",
    Tabs = {},
    ActiveTab = nil,
    Connections = {},
    Notifications = {},
    Toggled = true,
    HoverColorMultiplier = 0.1,
    ThemedInstances = {}, -- registry of {instance = inst, prop = "BackgroundColor3", key = "Main"} for live re-theming
    ElementOrigin = {}, -- [instance] = {Parent = TabContent, TabName = "Main"} used to restore position after a global search
}

local Themes = {
    Dark = {
        Main = Color3.fromRGB(30, 30, 35),
        Sidebar = Color3.fromRGB(25, 25, 30),
        Header = Color3.fromRGB(20, 20, 25),
        Text = Color3.fromRGB(240, 240, 240),
        SubText = Color3.fromRGB(180, 180, 180),
        Accent = Color3.fromRGB(85, 170, 255),
        Element = Color3.fromRGB(40, 40, 45),
        ElementHover = Color3.fromRGB(50, 50, 55),
        Outline = Color3.fromRGB(60, 60, 65),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Light = {
        Main = Color3.fromRGB(245, 245, 250),
        Sidebar = Color3.fromRGB(235, 235, 240),
        Header = Color3.fromRGB(225, 225, 230),
        Text = Color3.fromRGB(20, 20, 20),
        SubText = Color3.fromRGB(80, 80, 80),
        Accent = Color3.fromRGB(0, 120, 215),
        Element = Color3.fromRGB(255, 255, 255),
        ElementHover = Color3.fromRGB(240, 240, 245),
        Outline = Color3.fromRGB(210, 210, 215),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Midnight = {
        Main = Color3.fromRGB(15, 15, 20),
        Sidebar = Color3.fromRGB(10, 10, 15),
        Header = Color3.fromRGB(5, 5, 10),
        Text = Color3.fromRGB(230, 230, 240),
        SubText = Color3.fromRGB(160, 160, 170),
        Accent = Color3.fromRGB(138, 43, 226),
        Element = Color3.fromRGB(25, 25, 30),
        ElementHover = Color3.fromRGB(35, 35, 40),
        Outline = Color3.fromRGB(45, 45, 50),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    -- === 47 THEMES MỚI ===
    
    -- THEMES XANH LÁ
    Forest = {
        Main = Color3.fromRGB(30, 45, 35),
        Sidebar = Color3.fromRGB(25, 40, 30),
        Header = Color3.fromRGB(20, 35, 25),
        Text = Color3.fromRGB(220, 240, 220),
        SubText = Color3.fromRGB(160, 190, 160),
        Accent = Color3.fromRGB(76, 175, 80),
        Element = Color3.fromRGB(40, 55, 45),
        ElementHover = Color3.fromRGB(50, 65, 55),
        Outline = Color3.fromRGB(55, 70, 60),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Emerald = {
        Main = Color3.fromRGB(20, 50, 40),
        Sidebar = Color3.fromRGB(15, 42, 33),
        Header = Color3.fromRGB(10, 35, 27),
        Text = Color3.fromRGB(220, 255, 235),
        SubText = Color3.fromRGB(150, 210, 180),
        Accent = Color3.fromRGB(0, 230, 160),
        Element = Color3.fromRGB(30, 62, 50),
        ElementHover = Color3.fromRGB(40, 75, 60),
        Outline = Color3.fromRGB(50, 85, 70),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Mint = {
        Main = Color3.fromRGB(35, 55, 50),
        Sidebar = Color3.fromRGB(28, 48, 43),
        Header = Color3.fromRGB(22, 42, 37),
        Text = Color3.fromRGB(230, 255, 245),
        SubText = Color3.fromRGB(170, 215, 200),
        Accent = Color3.fromRGB(100, 220, 200),
        Element = Color3.fromRGB(45, 68, 62),
        ElementHover = Color3.fromRGB(55, 80, 72),
        Outline = Color3.fromRGB(65, 92, 84),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Sage = {
        Main = Color3.fromRGB(45, 55, 45),
        Sidebar = Color3.fromRGB(38, 48, 38),
        Header = Color3.fromRGB(32, 42, 32),
        Text = Color3.fromRGB(235, 245, 230),
        SubText = Color3.fromRGB(175, 195, 170),
        Accent = Color3.fromRGB(160, 200, 140),
        Element = Color3.fromRGB(55, 68, 55),
        ElementHover = Color3.fromRGB(65, 80, 65),
        Outline = Color3.fromRGB(75, 92, 75),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES XANH DƯƠNG
    Ocean = {
        Main = Color3.fromRGB(20, 35, 50),
        Sidebar = Color3.fromRGB(15, 28, 42),
        Header = Color3.fromRGB(10, 22, 35),
        Text = Color3.fromRGB(220, 235, 250),
        SubText = Color3.fromRGB(155, 185, 215),
        Accent = Color3.fromRGB(60, 150, 220),
        Element = Color3.fromRGB(30, 48, 65),
        ElementHover = Color3.fromRGB(40, 60, 80),
        Outline = Color3.fromRGB(50, 72, 95),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Sky = {
        Main = Color3.fromRGB(35, 55, 70),
        Sidebar = Color3.fromRGB(28, 48, 62),
        Header = Color3.fromRGB(22, 42, 55),
        Text = Color3.fromRGB(235, 245, 255),
        SubText = Color3.fromRGB(180, 210, 230),
        Accent = Color3.fromRGB(100, 180, 250),
        Element = Color3.fromRGB(48, 68, 85),
        ElementHover = Color3.fromRGB(60, 80, 100),
        Outline = Color3.fromRGB(72, 92, 112),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    DeepBlue = {
        Main = Color3.fromRGB(10, 15, 35),
        Sidebar = Color3.fromRGB(5, 10, 28),
        Header = Color3.fromRGB(0, 5, 22),
        Text = Color3.fromRGB(210, 215, 245),
        SubText = Color3.fromRGB(140, 150, 200),
        Accent = Color3.fromRGB(50, 80, 220),
        Element = Color3.fromRGB(20, 25, 48),
        ElementHover = Color3.fromRGB(30, 35, 60),
        Outline = Color3.fromRGB(40, 45, 75),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Arctic = {
        Main = Color3.fromRGB(45, 60, 75),
        Sidebar = Color3.fromRGB(38, 52, 68),
        Header = Color3.fromRGB(32, 45, 60),
        Text = Color3.fromRGB(240, 248, 255),
        SubText = Color3.fromRGB(190, 210, 230),
        Accent = Color3.fromRGB(140, 200, 240),
        Element = Color3.fromRGB(58, 75, 90),
        ElementHover = Color3.fromRGB(70, 88, 105),
        Outline = Color3.fromRGB(82, 100, 118),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES ĐỎ - HỒNG
    Crimson = {
        Main = Color3.fromRGB(50, 15, 20),
        Sidebar = Color3.fromRGB(42, 10, 15),
        Header = Color3.fromRGB(35, 5, 10),
        Text = Color3.fromRGB(245, 210, 215),
        SubText = Color3.fromRGB(200, 140, 145),
        Accent = Color3.fromRGB(220, 50, 60),
        Element = Color3.fromRGB(65, 25, 30),
        ElementHover = Color3.fromRGB(80, 35, 40),
        Outline = Color3.fromRGB(95, 45, 50),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Rose = {
        Main = Color3.fromRGB(55, 25, 30),
        Sidebar = Color3.fromRGB(48, 18, 23),
        Header = Color3.fromRGB(40, 12, 17),
        Text = Color3.fromRGB(250, 220, 225),
        SubText = Color3.fromRGB(210, 155, 165),
        Accent = Color3.fromRGB(230, 90, 110),
        Element = Color3.fromRGB(70, 35, 42),
        ElementHover = Color3.fromRGB(85, 45, 55),
        Outline = Color3.fromRGB(100, 55, 68),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Cherry = {
        Main = Color3.fromRGB(60, 10, 20),
        Sidebar = Color3.fromRGB(52, 5, 15),
        Header = Color3.fromRGB(45, 0, 10),
        Text = Color3.fromRGB(255, 200, 210),
        SubText = Color3.fromRGB(210, 130, 145),
        Accent = Color3.fromRGB(240, 30, 60),
        Element = Color3.fromRGB(75, 20, 32),
        ElementHover = Color3.fromRGB(90, 30, 45),
        Outline = Color3.fromRGB(105, 40, 58),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Pink = {
        Main = Color3.fromRGB(55, 25, 40),
        Sidebar = Color3.fromRGB(48, 18, 33),
        Header = Color3.fromRGB(40, 12, 27),
        Text = Color3.fromRGB(250, 215, 235),
        SubText = Color3.fromRGB(210, 155, 185),
        Accent = Color3.fromRGB(255, 100, 180),
        Element = Color3.fromRGB(70, 35, 52),
        ElementHover = Color3.fromRGB(85, 45, 65),
        Outline = Color3.fromRGB(100, 55, 78),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Blush = {
        Main = Color3.fromRGB(60, 35, 40),
        Sidebar = Color3.fromRGB(52, 28, 33),
        Header = Color3.fromRGB(45, 22, 27),
        Text = Color3.fromRGB(252, 235, 238),
        SubText = Color3.fromRGB(215, 185, 190),
        Accent = Color3.fromRGB(255, 150, 170),
        Element = Color3.fromRGB(75, 48, 55),
        ElementHover = Color3.fromRGB(90, 60, 68),
        Outline = Color3.fromRGB(105, 72, 82),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES TÍM
    Violet = {
        Main = Color3.fromRGB(35, 20, 50),
        Sidebar = Color3.fromRGB(28, 15, 42),
        Header = Color3.fromRGB(22, 10, 35),
        Text = Color3.fromRGB(235, 220, 250),
        SubText = Color3.fromRGB(185, 160, 215),
        Accent = Color3.fromRGB(160, 90, 230),
        Element = Color3.fromRGB(48, 30, 65),
        ElementHover = Color3.fromRGB(60, 40, 80),
        Outline = Color3.fromRGB(72, 50, 95),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Lavender = {
        Main = Color3.fromRGB(50, 40, 60),
        Sidebar = Color3.fromRGB(42, 33, 52),
        Header = Color3.fromRGB(35, 27, 45),
        Text = Color3.fromRGB(245, 235, 255),
        SubText = Color3.fromRGB(200, 185, 220),
        Accent = Color3.fromRGB(180, 140, 240),
        Element = Color3.fromRGB(65, 52, 78),
        ElementHover = Color3.fromRGB(78, 64, 92),
        Outline = Color3.fromRGB(92, 76, 108),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Plum = {
        Main = Color3.fromRGB(40, 15, 40),
        Sidebar = Color3.fromRGB(33, 10, 33),
        Header = Color3.fromRGB(27, 5, 27),
        Text = Color3.fromRGB(245, 215, 245),
        SubText = Color3.fromRGB(195, 145, 195),
        Accent = Color3.fromRGB(200, 70, 200),
        Element = Color3.fromRGB(53, 25, 53),
        ElementHover = Color3.fromRGB(68, 35, 68),
        Outline = Color3.fromRGB(83, 45, 83),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES CAM - VÀNG
    Sunset = {
        Main = Color3.fromRGB(55, 30, 15),
        Sidebar = Color3.fromRGB(48, 23, 10),
        Header = Color3.fromRGB(40, 17, 5),
        Text = Color3.fromRGB(255, 235, 215),
        SubText = Color3.fromRGB(220, 190, 155),
        Accent = Color3.fromRGB(255, 150, 50),
        Element = Color3.fromRGB(70, 40, 22),
        ElementHover = Color3.fromRGB(85, 50, 30),
        Outline = Color3.fromRGB(100, 60, 38),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Amber = {
        Main = Color3.fromRGB(50, 35, 15),
        Sidebar = Color3.fromRGB(42, 28, 10),
        Header = Color3.fromRGB(35, 22, 5),
        Text = Color3.fromRGB(255, 245, 215),
        SubText = Color3.fromRGB(220, 200, 155),
        Accent = Color3.fromRGB(255, 190, 50),
        Element = Color3.fromRGB(65, 45, 22),
        ElementHover = Color3.fromRGB(80, 55, 30),
        Outline = Color3.fromRGB(95, 65, 38),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Gold = {
        Main = Color3.fromRGB(45, 38, 15),
        Sidebar = Color3.fromRGB(38, 30, 10),
        Header = Color3.fromRGB(30, 22, 5),
        Text = Color3.fromRGB(255, 248, 210),
        SubText = Color3.fromRGB(215, 205, 150),
        Accent = Color3.fromRGB(255, 215, 0),
        Element = Color3.fromRGB(58, 48, 22),
        ElementHover = Color3.fromRGB(72, 58, 30),
        Outline = Color3.fromRGB(86, 68, 38),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Peach = {
        Main = Color3.fromRGB(60, 38, 28),
        Sidebar = Color3.fromRGB(52, 30, 20),
        Header = Color3.fromRGB(45, 23, 13),
        Text = Color3.fromRGB(255, 240, 230),
        SubText = Color3.fromRGB(225, 195, 180),
        Accent = Color3.fromRGB(255, 180, 130),
        Element = Color3.fromRGB(75, 50, 38),
        ElementHover = Color3.fromRGB(90, 62, 48),
        Outline = Color3.fromRGB(105, 74, 58),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES NÂU - BE
    Chocolate = {
        Main = Color3.fromRGB(40, 25, 15),
        Sidebar = Color3.fromRGB(33, 18, 10),
        Header = Color3.fromRGB(27, 12, 5),
        Text = Color3.fromRGB(240, 225, 210),
        SubText = Color3.fromRGB(190, 170, 150),
        Accent = Color3.fromRGB(180, 120, 80),
        Element = Color3.fromRGB(53, 35, 22),
        ElementHover = Color3.fromRGB(68, 45, 30),
        Outline = Color3.fromRGB(83, 55, 38),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Coffee = {
        Main = Color3.fromRGB(35, 22, 15),
        Sidebar = Color3.fromRGB(28, 16, 10),
        Header = Color3.fromRGB(22, 10, 5),
        Text = Color3.fromRGB(235, 220, 205),
        SubText = Color3.fromRGB(180, 160, 145),
        Accent = Color3.fromRGB(160, 110, 70),
        Element = Color3.fromRGB(48, 32, 22),
        ElementHover = Color3.fromRGB(62, 42, 30),
        Outline = Color3.fromRGB(76, 52, 38),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Cream = {
        Main = Color3.fromRGB(55, 48, 38),
        Sidebar = Color3.fromRGB(48, 40, 30),
        Header = Color3.fromRGB(40, 32, 22),
        Text = Color3.fromRGB(250, 245, 235),
        SubText = Color3.fromRGB(200, 190, 175),
        Accent = Color3.fromRGB(220, 200, 160),
        Element = Color3.fromRGB(68, 60, 48),
        ElementHover = Color3.fromRGB(82, 72, 58),
        Outline = Color3.fromRGB(96, 84, 68),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES PASTEL
    PastelBlue = {
        Main = Color3.fromRGB(55, 65, 85),
        Sidebar = Color3.fromRGB(48, 58, 78),
        Header = Color3.fromRGB(42, 52, 72),
        Text = Color3.fromRGB(240, 245, 255),
        SubText = Color3.fromRGB(190, 200, 220),
        Accent = Color3.fromRGB(130, 180, 240),
        Element = Color3.fromRGB(68, 78, 100),
        ElementHover = Color3.fromRGB(80, 90, 115),
        Outline = Color3.fromRGB(92, 102, 128),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    PastelPink = {
        Main = Color3.fromRGB(75, 55, 65),
        Sidebar = Color3.fromRGB(68, 48, 58),
        Header = Color3.fromRGB(62, 42, 52),
        Text = Color3.fromRGB(255, 240, 248),
        SubText = Color3.fromRGB(220, 190, 200),
        Accent = Color3.fromRGB(255, 160, 190),
        Element = Color3.fromRGB(90, 68, 80),
        ElementHover = Color3.fromRGB(105, 80, 95),
        Outline = Color3.fromRGB(118, 92, 108),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    PastelGreen = {
        Main = Color3.fromRGB(55, 75, 60),
        Sidebar = Color3.fromRGB(48, 68, 53),
        Header = Color3.fromRGB(42, 62, 47),
        Text = Color3.fromRGB(240, 255, 245),
        SubText = Color3.fromRGB(190, 215, 200),
        Accent = Color3.fromRGB(140, 220, 160),
        Element = Color3.fromRGB(68, 90, 75),
        ElementHover = Color3.fromRGB(80, 105, 88),
        Outline = Color3.fromRGB(92, 118, 100),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    PastelPurple = {
        Main = Color3.fromRGB(65, 55, 80),
        Sidebar = Color3.fromRGB(58, 48, 73),
        Header = Color3.fromRGB(52, 42, 67),
        Text = Color3.fromRGB(248, 240, 255),
        SubText = Color3.fromRGB(205, 190, 225),
        Accent = Color3.fromRGB(190, 150, 240),
        Element = Color3.fromRGB(80, 68, 98),
        ElementHover = Color3.fromRGB(95, 80, 115),
        Outline = Color3.fromRGB(108, 92, 130),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES NEON
    NeonBlue = {
        Main = Color3.fromRGB(10, 10, 30),
        Sidebar = Color3.fromRGB(5, 5, 25),
        Header = Color3.fromRGB(0, 0, 20),
        Text = Color3.fromRGB(200, 220, 255),
        SubText = Color3.fromRGB(130, 160, 230),
        Accent = Color3.fromRGB(0, 150, 255),
        Element = Color3.fromRGB(20, 20, 45),
        ElementHover = Color3.fromRGB(30, 30, 60),
        Outline = Color3.fromRGB(40, 40, 75),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    NeonGreen = {
        Main = Color3.fromRGB(10, 30, 10),
        Sidebar = Color3.fromRGB(5, 25, 5),
        Header = Color3.fromRGB(0, 20, 0),
        Text = Color3.fromRGB(200, 255, 200),
        SubText = Color3.fromRGB(130, 230, 130),
        Accent = Color3.fromRGB(0, 255, 100),
        Element = Color3.fromRGB(20, 45, 20),
        ElementHover = Color3.fromRGB(30, 60, 30),
        Outline = Color3.fromRGB(40, 75, 40),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    NeonPink = {
        Main = Color3.fromRGB(30, 10, 25),
        Sidebar = Color3.fromRGB(25, 5, 20),
        Header = Color3.fromRGB(20, 0, 15),
        Text = Color3.fromRGB(255, 200, 240),
        SubText = Color3.fromRGB(230, 130, 200),
        Accent = Color3.fromRGB(255, 0, 200),
        Element = Color3.fromRGB(45, 20, 38),
        ElementHover = Color3.fromRGB(60, 30, 50),
        Outline = Color3.fromRGB(75, 40, 62),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    NeonOrange = {
        Main = Color3.fromRGB(30, 15, 5),
        Sidebar = Color3.fromRGB(25, 10, 0),
        Header = Color3.fromRGB(20, 5, 0),
        Text = Color3.fromRGB(255, 230, 200),
        SubText = Color3.fromRGB(230, 180, 130),
        Accent = Color3.fromRGB(255, 150, 0),
        Element = Color3.fromRGB(45, 25, 10),
        ElementHover = Color3.fromRGB(60, 35, 15),
        Outline = Color3.fromRGB(75, 45, 20),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES TỐI ĐẶC BIỆT
    Matrix = {
        Main = Color3.fromRGB(5, 10, 5),
        Sidebar = Color3.fromRGB(0, 5, 0),
        Header = Color3.fromRGB(0, 0, 0),
        Text = Color3.fromRGB(0, 255, 65),
        SubText = Color3.fromRGB(0, 180, 45),
        Accent = Color3.fromRGB(0, 255, 100),
        Element = Color3.fromRGB(10, 20, 10),
        ElementHover = Color3.fromRGB(15, 30, 15),
        Outline = Color3.fromRGB(0, 50, 20),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Dracula = {
        Main = Color3.fromRGB(28, 28, 35),
        Sidebar = Color3.fromRGB(23, 23, 30),
        Header = Color3.fromRGB(18, 18, 25),
        Text = Color3.fromRGB(248, 248, 242),
        SubText = Color3.fromRGB(189, 189, 189),
        Accent = Color3.fromRGB(255, 85, 85),
        Element = Color3.fromRGB(40, 40, 50),
        ElementHover = Color3.fromRGB(52, 52, 62),
        Outline = Color3.fromRGB(68, 68, 78),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Nord = {
        Main = Color3.fromRGB(46, 52, 64),
        Sidebar = Color3.fromRGB(38, 43, 55),
        Header = Color3.fromRGB(30, 35, 47),
        Text = Color3.fromRGB(236, 239, 244),
        SubText = Color3.fromRGB(180, 190, 200),
        Accent = Color3.fromRGB(136, 192, 208),
        Element = Color3.fromRGB(56, 62, 75),
        ElementHover = Color3.fromRGB(66, 72, 85),
        Outline = Color3.fromRGB(76, 82, 95),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES SÁNG ĐẶC BIỆT
    Solarized = {
        Main = Color3.fromRGB(253, 246, 227),
        Sidebar = Color3.fromRGB(238, 232, 213),
        Header = Color3.fromRGB(220, 215, 198),
        Text = Color3.fromRGB(101, 123, 131),
        SubText = Color3.fromRGB(147, 161, 161),
        Accent = Color3.fromRGB(38, 139, 210),
        Element = Color3.fromRGB(255, 255, 255),
        ElementHover = Color3.fromRGB(245, 240, 230),
        Outline = Color3.fromRGB(210, 205, 195),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Gruvbox = {
        Main = Color3.fromRGB(251, 241, 199),
        Sidebar = Color3.fromRGB(235, 219, 178),
        Header = Color3.fromRGB(218, 200, 158),
        Text = Color3.fromRGB(60, 56, 54),
        SubText = Color3.fromRGB(102, 92, 84),
        Accent = Color3.fromRGB(215, 153, 33),
        Element = Color3.fromRGB(255, 255, 255),
        ElementHover = Color3.fromRGB(245, 235, 200),
        Outline = Color3.fromRGB(200, 190, 170),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Paper = {
        Main = Color3.fromRGB(250, 250, 245),
        Sidebar = Color3.fromRGB(240, 240, 235),
        Header = Color3.fromRGB(230, 230, 225),
        Text = Color3.fromRGB(30, 30, 25),
        SubText = Color3.fromRGB(80, 80, 70),
        Accent = Color3.fromRGB(180, 130, 80),
        Element = Color3.fromRGB(255, 255, 255),
        ElementHover = Color3.fromRGB(245, 245, 240),
        Outline = Color3.fromRGB(215, 215, 210),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES MÀU ĐƠN SẮC
    Monochrome = {
        Main = Color3.fromRGB(35, 35, 35),
        Sidebar = Color3.fromRGB(28, 28, 28),
        Header = Color3.fromRGB(22, 22, 22),
        Text = Color3.fromRGB(230, 230, 230),
        SubText = Color3.fromRGB(160, 160, 160),
        Accent = Color3.fromRGB(180, 180, 180),
        Element = Color3.fromRGB(45, 45, 45),
        ElementHover = Color3.fromRGB(55, 55, 55),
        Outline = Color3.fromRGB(65, 65, 65),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Silver = {
        Main = Color3.fromRGB(60, 60, 65),
        Sidebar = Color3.fromRGB(52, 52, 57),
        Header = Color3.fromRGB(45, 45, 50),
        Text = Color3.fromRGB(240, 240, 245),
        SubText = Color3.fromRGB(180, 180, 190),
        Accent = Color3.fromRGB(200, 200, 210),
        Element = Color3.fromRGB(72, 72, 78),
        ElementHover = Color3.fromRGB(84, 84, 90),
        Outline = Color3.fromRGB(96, 96, 102),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Graphite = {
        Main = Color3.fromRGB(25, 25, 28),
        Sidebar = Color3.fromRGB(18, 18, 22),
        Header = Color3.fromRGB(12, 12, 16),
        Text = Color3.fromRGB(235, 235, 240),
        SubText = Color3.fromRGB(165, 165, 175),
        Accent = Color3.fromRGB(140, 140, 150),
        Element = Color3.fromRGB(35, 35, 40),
        ElementHover = Color3.fromRGB(45, 45, 52),
        Outline = Color3.fromRGB(55, 55, 64),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    
    -- THEMES THEO CHỦ ĐỀ
    Sakura = {
        Main = Color3.fromRGB(60, 35, 45),
        Sidebar = Color3.fromRGB(52, 28, 38),
        Header = Color3.fromRGB(45, 22, 32),
        Text = Color3.fromRGB(255, 235, 245),
        SubText = Color3.fromRGB(220, 185, 200),
        Accent = Color3.fromRGB(255, 130, 160),
        Element = Color3.fromRGB(75, 48, 58),
        ElementHover = Color3.fromRGB(90, 60, 72),
        Outline = Color3.fromRGB(105, 72, 86),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Aurora = {
        Main = Color3.fromRGB(20, 30, 45),
        Sidebar = Color3.fromRGB(15, 23, 38),
        Header = Color3.fromRGB(10, 17, 32),
        Text = Color3.fromRGB(220, 240, 255),
        SubText = Color3.fromRGB(160, 190, 220),
        Accent = Color3.fromRGB(100, 200, 180),
        Element = Color3.fromRGB(30, 43, 60),
        ElementHover = Color3.fromRGB(40, 55, 75),
        Outline = Color3.fromRGB(50, 67, 88),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Galaxy = {
        Main = Color3.fromRGB(15, 10, 30),
        Sidebar = Color3.fromRGB(10, 5, 25),
        Header = Color3.fromRGB(5, 0, 20),
        Text = Color3.fromRGB(225, 215, 250),
        SubText = Color3.fromRGB(170, 155, 210),
        Accent = Color3.fromRGB(150, 100, 220),
        Element = Color3.fromRGB(25, 18, 45),
        ElementHover = Color3.fromRGB(35, 28, 60),
        Outline = Color3.fromRGB(45, 38, 75),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Candy = {
        Main = Color3.fromRGB(60, 30, 50),
        Sidebar = Color3.fromRGB(52, 23, 42),
        Header = Color3.fromRGB(45, 17, 35),
        Text = Color3.fromRGB(255, 230, 250),
        SubText = Color3.fromRGB(225, 180, 215),
        Accent = Color3.fromRGB(255, 100, 150),
        Element = Color3.fromRGB(75, 42, 65),
        ElementHover = Color3.fromRGB(90, 55, 78),
        Outline = Color3.fromRGB(105, 68, 90),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Oceanic = {
        Main = Color3.fromRGB(15, 30, 45),
        Sidebar = Color3.fromRGB(10, 23, 38),
        Header = Color3.fromRGB(5, 17, 32),
        Text = Color3.fromRGB(215, 235, 250),
        SubText = Color3.fromRGB(155, 185, 215),
        Accent = Color3.fromRGB(50, 160, 200),
        Element = Color3.fromRGB(25, 43, 60),
        ElementHover = Color3.fromRGB(35, 55, 75),
        Outline = Color3.fromRGB(45, 67, 88),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Desert = {
        Main = Color3.fromRGB(55, 42, 30),
        Sidebar = Color3.fromRGB(48, 35, 23),
        Header = Color3.fromRGB(40, 28, 17),
        Text = Color3.fromRGB(245, 235, 220),
        SubText = Color3.fromRGB(200, 185, 165),
        Accent = Color3.fromRGB(210, 160, 100),
        Element = Color3.fromRGB(70, 55, 40),
        ElementHover = Color3.fromRGB(85, 68, 50),
        Outline = Color3.fromRGB(100, 80, 60),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Tropical = {
        Main = Color3.fromRGB(20, 45, 40),
        Sidebar = Color3.fromRGB(13, 38, 33),
        Header = Color3.fromRGB(7, 32, 27),
        Text = Color3.fromRGB(225, 250, 240),
        SubText = Color3.fromRGB(170, 215, 200),
        Accent = Color3.fromRGB(255, 180, 50),
        Element = Color3.fromRGB(32, 60, 52),
        ElementHover = Color3.fromRGB(45, 75, 65),
        Outline = Color3.fromRGB(58, 88, 78),
        Shadow = Color3.fromRGB(0, 0, 0)
    },
    Winter = {
        Main = Color3.fromRGB(35, 40, 55),
        Sidebar = Color3.fromRGB(28, 33, 48),
        Header = Color3.fromRGB(22, 27, 42),
        Text = Color3.fromRGB(235, 240, 255),
        SubText = Color3.fromRGB(185, 195, 225),
        Accent = Color3.fromRGB(140, 200, 240),
        Element = Color3.fromRGB(48, 55, 72),
        ElementHover = Color3.fromRGB(60, 68, 88),
        Outline = Color3.fromRGB(72, 80, 102),
        Shadow = Color3.fromRGB(0, 0, 0)
    }
}

Themes.Custom = {
    Main = Themes.Dark.Main,
    Sidebar = Themes.Dark.Sidebar,
    Header = Themes.Dark.Header,
    Text = Themes.Dark.Text,
    SubText = Themes.Dark.SubText,
    Accent = Themes.Dark.Accent,
    Element = Themes.Dark.Element,
    ElementHover = Themes.Dark.ElementHover,
    Outline = Themes.Dark.Outline,
    Shadow = Themes.Dark.Shadow
}

local function GetTheme()
    return Themes[LuminaState.CurrentTheme] or Themes.Dark
end

local function Create(className, properties)
    local instance = Instance.new(className)
    for k, v in pairs(properties) do
        if type(k) == "number" then
            v.Parent = instance
        else
            instance[k] = v
        end
    end
    return instance
end

-- Registers an instance/property pair so that it gets updated automatically
-- whenever the active theme (or a custom theme color) changes.
-- themeKey is one of the keys in the Themes.Dark table (e.g. "Main", "Accent", ...)
local function RegisterThemed(instance, propName, themeKey)
    table.insert(LuminaState.ThemedInstances, {
        Instance = instance,
        Prop = propName,
        Key = themeKey
    })
    return instance
end

local function ApplyTween(instance, properties, duration, style, direction)
    duration = duration or 0.2
    style = style or Enum.EasingStyle.Sine
    direction = direction or Enum.EasingDirection.Out
    local tweenInfo = TweenInfo.new(duration, style, direction)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

-- Re-applies the current theme's colors to every registered instance.
-- Called after switching presets or editing a custom color.
local function RefreshTheme()
    local Theme = GetTheme()
    for _, entry in ipairs(LuminaState.ThemedInstances) do
        if entry.Instance and entry.Instance.Parent then
            local color = Theme[entry.Key]
            if color then
                local ok = pcall(function()
                    ApplyTween(entry.Instance, {[entry.Prop] = color}, 0.25)
                end)
            end
        end
    end
end

local function MakeDraggable(topbar, target)
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        ApplyTween(target, {Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)}, 0.1)
    end
    
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = target.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- corner: "TopLeft", "TopRight", "BottomLeft", "BottomRight"
-- Assumes target's AnchorPoint is (0, 0) (top-left)
local function MakeResizable(handle, target, corner, minSize, maxSize)
    minSize = minSize or Vector2.new(400, 300)
    maxSize = maxSize or Vector2.new(1400, 900)
    
    local resizing = false
    local dragStart, startSize, startPos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            resizing = true
            dragStart = input.Position
            startSize = target.Size
            startPos = target.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    resizing = false
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            
            local startW, startH = startSize.X.Offset, startSize.Y.Offset
            local posX, posY = startPos.X.Offset, startPos.Y.Offset
            
            local newW, newH = startW, startH
            
            if corner == "BottomRight" then
                newW = math.clamp(startW + delta.X, minSize.X, maxSize.X)
                newH = math.clamp(startH + delta.Y, minSize.Y, maxSize.Y)
            elseif corner == "BottomLeft" then
                newW = math.clamp(startW - delta.X, minSize.X, maxSize.X)
                newH = math.clamp(startH + delta.Y, minSize.Y, maxSize.Y)
                posX = startPos.X.Offset + (startW - newW)
            elseif corner == "TopRight" then
                newW = math.clamp(startW + delta.X, minSize.X, maxSize.X)
                newH = math.clamp(startH - delta.Y, minSize.Y, maxSize.Y)
                posY = startPos.Y.Offset + (startH - newH)
            elseif corner == "TopLeft" then
                newW = math.clamp(startW - delta.X, minSize.X, maxSize.X)
                newH = math.clamp(startH - delta.Y, minSize.Y, maxSize.Y)
                posX = startPos.X.Offset + (startW - newW)
                posY = startPos.Y.Offset + (startH - newH)
            end
            
            target.Size = UDim2.new(0, newW, 0, newH)
            target.Position = UDim2.new(startPos.X.Scale, posX, startPos.Y.Scale, posY)
        end
    end)
end

-- =====================================================================
-- 4. CORE GUI CONSTRUCTORS
-- =====================================================================

local GUI_NAME = "LuminaStandaloneUI"
local MainGui

local function DestroyUI()
    if CoreGui:FindFirstChild(GUI_NAME) then
        CoreGui[GUI_NAME]:Destroy()
    end
    if LocalPlayer.PlayerGui:FindFirstChild(GUI_NAME) then
        LocalPlayer.PlayerGui[GUI_NAME]:Destroy()
    end
    for _, conn in pairs(LuminaState.Connections) do
        conn:Disconnect()
    end
    LuminaState.Connections = {}
    LuminaState.ThemedInstances = {}
    LuminaState.ElementOrigin = {}
end

local function GetParentGui()
    local success, _ = pcall(function() return CoreGui.Name end)
    return success and CoreGui or LocalPlayer:WaitForChild("PlayerGui")
end

local Lumina = {}

function Lumina:CreateWindow(config)
    config = config or {}
    local Title = config.Title or "Lumina UI"
    local Version = config.Version or "v1.0"
    local Size = config.Size or UDim2.new(0, 750, 0, 480)
    
    DestroyUI()
    
    MainGui = Create("ScreenGui", {
        Name = GUI_NAME,
        Parent = GetParentGui(),
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        IgnoreGuiInset = true
    })
    
    local Theme = GetTheme()
    
    local MainFrame = Create("Frame", {
        Name = "MainFrame",
        Parent = MainGui,
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0.5, -Size.X.Offset / 2, 0.5, -Size.Y.Offset / 2),
        Size = Size,
        BackgroundColor3 = Theme.Main,
        BorderSizePixel = 0,
        ClipsDescendants = true,
        Create("UICorner", { CornerRadius = UDim.new(0, 8) }),
        Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
    })
    RegisterThemed(MainFrame, "BackgroundColor3", "Main")
    RegisterThemed(MainFrame.UIStroke, "Color", "Outline")
    
    -- Drop Shadow
    Create("ImageLabel", {
        Name = "Shadow",
        Parent = MainFrame,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Size = UDim2.new(1, 60, 1, 60),
        BackgroundTransparency = 1,
        Image = "rbxassetid://1316045217",
        ImageColor3 = Theme.Shadow,
        ImageTransparency = 0.5,
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(10, 10, 118, 118),
        ZIndex = -1
    })

    -- Removing FloatingBtn as per request
    
    local ResizeHandles = {}
    
    -- Header
    local Header = Create("Frame", {
        Name = "Header",
        Parent = MainFrame,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 2,
        Create("UICorner", { CornerRadius = UDim.new(0, 8) })
    })
    RegisterThemed(Header, "BackgroundColor3", "Header")
    
    Create("Frame", {
        Name = "Filler",
        Parent = Header,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    RegisterThemed(Header.Filler, "BackgroundColor3", "Header")
    
    Create("Frame", {
        Name = "Divider",
        Parent = Header,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.Outline,
        BorderSizePixel = 0,
        ZIndex = 3
    })
    RegisterThemed(Header.Divider, "BackgroundColor3", "Outline")
    
    MakeDraggable(Header, MainFrame)
    
    -- Title (name only, no version baked in anymore)
    local TitleLbl = Create("TextLabel", {
        Name = "Title",
        Parent = Header,
        Position = UDim2.new(0, 15, 0, 2),
        Size = UDim2.new(0, 220, 0, 20),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Center,
        RichText = true,
        ZIndex = 4
    })
    RegisterThemed(TitleLbl, "TextColor3", "Text")
    
    -- Version, now rendered as a small SubTitle beneath the main title
    local SubTitleLbl = Create("TextLabel", {
        Name = "SubTitle",
        Parent = Header,
        Position = UDim2.new(0, 15, 0, 21),
        Size = UDim2.new(0, 220, 0, 14),
        BackgroundTransparency = 1,
        Text = Version,
        TextColor3 = Theme.SubText,
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        RichText = true,
        ZIndex = 4
    })
    RegisterThemed(SubTitleLbl, "TextColor3", "SubText")
    
    local CloseBtn = Create("TextButton", {
        Name = "Close",
        Parent = Header,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -10, 0.5, 0),
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundTransparency = 1,
        Text = "✕",
        TextColor3 = Theme.SubText,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        ZIndex = 4,
        Create("UICorner", { CornerRadius = UDim.new(0, 4) })
    })
    
    CloseBtn.MouseEnter:Connect(function() ApplyTween(CloseBtn, {TextColor3 = Color3.fromRGB(255, 80, 80), BackgroundTransparency = 0.8}, 0.2) end)
    CloseBtn.MouseLeave:Connect(function() ApplyTween(CloseBtn, {TextColor3 = GetTheme().SubText, BackgroundTransparency = 1}, 0.2) end)
    CloseBtn.MouseButton1Click:Connect(function() DestroyUI() end)
    
    local MinBtn = Create("TextButton", {
        Name = "Minimize",
        Parent = Header,
        AnchorPoint = Vector2.new(1, 0.5),
        Position = UDim2.new(1, -38, 0.5, 0),
        Size = UDim2.new(0, 24, 0, 24),
        BackgroundTransparency = 1,
        Text = "-",
        TextColor3 = Theme.SubText,
        TextSize = 18,
        Font = Enum.Font.Gotham,
        ZIndex = 4,
        Create("UICorner", { CornerRadius = UDim.new(0, 4) })
    })
    
    MinBtn.MouseEnter:Connect(function() ApplyTween(MinBtn, {TextColor3 = Theme.Text, BackgroundTransparency = 0.8}, 0.2) end)
    MinBtn.MouseLeave:Connect(function() ApplyTween(MinBtn, {TextColor3 = GetTheme().SubText, BackgroundTransparency = 1}, 0.2) end)
    local isMinimized = false
    local CollapsedHeight = 40
    local PreMinimizeSize = Size
    MinBtn.MouseButton1Click:Connect(function()
        isMinimized = not isMinimized
        local currentSize = MainFrame.Size
        
        if isMinimized then
            -- Remember the current (possibly resized) size so we restore to it later
            PreMinimizeSize = currentSize
            for _, h in pairs(ResizeHandles) do h.Visible = false end
            ApplyTween(MainFrame, {
                Size = UDim2.new(0, currentSize.X.Offset, 0, CollapsedHeight)
            }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
        else
            local tween = ApplyTween(MainFrame, {
                Size = PreMinimizeSize
            }, 0.3, Enum.EasingStyle.Back, Enum.EasingDirection.InOut)
            tween.Completed:Connect(function()
                for _, h in pairs(ResizeHandles) do h.Visible = true end
            end)
        end
    end)
    
    -- Sidebar
    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = MainFrame,
        Position = UDim2.new(0, 0, 0, 40),
        Size = UDim2.new(0, 160, 1, -40),
        BackgroundColor3 = Theme.Sidebar,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    RegisterThemed(Sidebar, "BackgroundColor3", "Sidebar")
    
    Create("Frame", {
        Name = "Divider",
        Parent = Sidebar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        BackgroundColor3 = Theme.Outline,
        BorderSizePixel = 0,
        ZIndex = 3
    })
    RegisterThemed(Sidebar.Divider, "BackgroundColor3", "Outline")
    
    local SearchBox = Create("TextBox", {
        Name = "SearchBox",
        Parent = Sidebar,
        Position = UDim2.new(0, 10, 0, 10),
        Size = UDim2.new(1, -20, 0, 26),
        BackgroundColor3 = Theme.Element,
        Text = "",
        PlaceholderText = "Search...",
        TextColor3 = Theme.Text,
        PlaceholderColor3 = Theme.SubText,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
        Create("UIStroke", { Color = Theme.Outline, Thickness = 1 }),
        Create("UIPadding", {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8)
        })
    })
    RegisterThemed(SearchBox, "BackgroundColor3", "Element")
    RegisterThemed(SearchBox, "TextColor3", "Text")
    RegisterThemed(SearchBox.UIStroke, "Color", "Outline")
    
    -- GLOBAL SEARCH: actually pulls matching elements in from every tab into
    -- one combined results view, so the user sees everything at once instead
    -- of having to click through tabs to find it themselves.
    local function IsElementInstance(child)
        return child:IsA("GuiObject")
            and child.Name ~= "UIListLayout"
            and child.Name ~= "UIPadding"
            and child.Name ~= "Section" -- section headers are structural, not searchable results
    end

    local function GetSearchableText(child)
        local titleLbl = child:FindFirstChild("Title")
        if titleLbl and titleLbl:IsA("TextLabel") then
            return titleLbl.Text
        end
        return nil
    end

    -- Forward-declared so the closures below (defined before the actual
    -- SearchResultsFrame instance is created further down) correctly close
    -- over this upvalue instead of silently resolving to a nil global,
    -- which was the reason global search never did anything.
    local SearchResultsFrame

    local searchGroupHeaders = {} -- temporary "Tab Name" headers created while search is active

    local function ClearSearchGroupHeaders()
        for _, hdr in ipairs(searchGroupHeaders) do
            hdr:Destroy()
        end
        searchGroupHeaders = {}
    end

    -- Restores every reparented element back to its original tab, in its original order.
    local function RestoreAllElements()
        for inst, origin in pairs(LuminaState.ElementOrigin) do
            if inst.Parent == SearchResultsFrame then
                inst.LayoutOrder = origin.LayoutOrder
                inst.Parent = origin.Parent
                inst.Visible = true
            end
        end
        ClearSearchGroupHeaders()
    end

    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local query = SearchBox.Text:lower()
        local ThemeNow = GetTheme()

        if query == "" then
            -- Restore normal single-tab view
            RestoreAllElements()
            SearchResultsFrame.Visible = false
            if LuminaState.ActiveTab then
                LuminaState.ActiveTab.Visible = true
            end
            for _, tabData in pairs(LuminaState.Tabs) do
                if tabData.Content == LuminaState.ActiveTab then
                    ApplyTween(tabData.Btn, {TextColor3 = ThemeNow.Accent, BackgroundTransparency = 0}, 0.15)
                else
                    ApplyTween(tabData.Btn, {TextColor3 = ThemeNow.SubText, BackgroundTransparency = 1}, 0.15)
                end
            end
            return
        end

        -- Query is non-empty: pull matches from every tab into SearchResultsFrame
        RestoreAllElements() -- reset from any previous search pass first, keeps ordering correct
        if LuminaState.ActiveTab then
            LuminaState.ActiveTab.Visible = false
        end
        SearchResultsFrame.Visible = true

        local orderCounter = 0
        local anyMatches = false

        for _, tabData in pairs(LuminaState.Tabs) do
            local matchesInTab = {}
            for _, child in pairs(tabData.Content:GetChildren()) do
                if IsElementInstance(child) then
                    local text = GetSearchableText(child)
                    if text and string.find(text:lower(), query) then
                        table.insert(matchesInTab, child)
                    end
                end
            end

            if #matchesInTab > 0 then
                anyMatches = true
                ApplyTween(tabData.Btn, {TextColor3 = ThemeNow.Accent, BackgroundTransparency = 0.85}, 0.15)

                orderCounter = orderCounter + 1
                local header = Create("TextLabel", {
                    Name = "SearchGroupHeader",
                    Parent = SearchResultsFrame,
                    LayoutOrder = orderCounter,
                    Size = UDim2.new(1, 0, 0, 20),
                    BackgroundTransparency = 1,
                    Text = tabData.Btn.Name:gsub("Tab$", ""),
                    TextColor3 = ThemeNow.Accent,
                    TextSize = 13,
                    Font = Enum.Font.GothamBold,
                    TextXAlignment = Enum.TextXAlignment.Left
                })
                table.insert(searchGroupHeaders, header)

                for _, matchInst in ipairs(matchesInTab) do
                    orderCounter = orderCounter + 1
                    matchInst.LayoutOrder = orderCounter
                    matchInst.Parent = SearchResultsFrame
                    matchInst.Visible = true
                end
            else
                ApplyTween(tabData.Btn, {TextColor3 = ThemeNow.SubText, BackgroundTransparency = 1}, 0.15)
            end
        end

        if not anyMatches then
            orderCounter = orderCounter + 1
            local noResults = Create("TextLabel", {
                Name = "SearchGroupHeader",
                Parent = SearchResultsFrame,
                LayoutOrder = orderCounter,
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1,
                Text = "No results found",
                TextColor3 = ThemeNow.SubText,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            table.insert(searchGroupHeaders, noResults)
        end
    end)

    LuminaState.RestoreAllSearchElements = RestoreAllElements
    
    local PROFILE_BAR_HEIGHT = 52
    
    local TabList = Create("ScrollingFrame", {
        Name = "TabList",
        Parent = Sidebar,
        Position = UDim2.new(0, 0, 0, 46),
        Size = UDim2.new(1, 0, 1, -46 - PROFILE_BAR_HEIGHT),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Create("UIListLayout", {
            Padding = UDim.new(0, 4),
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    })
    
    TabList.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabList.CanvasSize = UDim2.new(0, 0, 0, TabList.UIListLayout.AbsoluteContentSize.Y)
    end)
    
    -- Profile bar (avatar + username) pinned to the bottom of the sidebar.
    -- This frame sits exactly on the GUI's bottom-left corner, so it needs its
    -- own UICorner to match MainFrame's rounding (ClipsDescendants does not
    -- automatically round opaque children, which was causing the square
    -- corner artifact).
    local ProfileBar = Create("Frame", {
        Name = "ProfileBar",
        Parent = Sidebar,
        AnchorPoint = Vector2.new(0, 1),
        Position = UDim2.new(0, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, PROFILE_BAR_HEIGHT),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 2,
        Create("UICorner", { CornerRadius = UDim.new(0, 8) })
    })
    RegisterThemed(ProfileBar, "BackgroundColor3", "Header")
    
    -- Masks the top two corners of ProfileBar (which UICorner rounds by
    -- default) since only the bottom-left corner is an actual GUI edge —
    -- the top edge just touches the tab list above and should stay square.
    Create("Frame", {
        Name = "TopFiller",
        Parent = ProfileBar,
        Size = UDim2.new(1, 0, 0, 8),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    RegisterThemed(ProfileBar.TopFiller, "BackgroundColor3", "Header")
    
    Create("Frame", {
        Name = "TopDivider",
        Parent = ProfileBar,
        Size = UDim2.new(1, 0, 0, 1),
        BackgroundColor3 = Theme.Outline,
        BorderSizePixel = 0,
        ZIndex = 3
    })
    RegisterThemed(ProfileBar.TopDivider, "BackgroundColor3", "Outline")

    -- Masks the right-side rounded corners of ProfileBar (top-right and
    -- bottom-right). That edge sits in the middle of the GUI, against
    -- Sidebar's right divider/ContentContainer, not a real screen corner —
    -- only the bottom-left corner of ProfileBar should stay rounded to
    -- match MainFrame's rounded corner there.
    Create("Frame", {
        Name = "RightFiller",
        Parent = ProfileBar,
        AnchorPoint = Vector2.new(1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        Size = UDim2.new(0, 8, 1, 0),
        BackgroundColor3 = Theme.Header,
        BorderSizePixel = 0,
        ZIndex = 2
    })
    RegisterThemed(ProfileBar.RightFiller, "BackgroundColor3", "Header")
    
    Create("ImageLabel", {
        Name = "Avatar",
        Parent = ProfileBar,
        AnchorPoint = Vector2.new(0, 0.5),
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(0, 34, 0, 34),
        BackgroundColor3 = Theme.Element,
        Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(LocalPlayer.UserId) .. "&w=150&h=150",
        ZIndex = 3,
        Create("UICorner", { CornerRadius = UDim.new(1, 0) }),
        Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
    })
    RegisterThemed(ProfileBar.Avatar, "BackgroundColor3", "Element")
    RegisterThemed(ProfileBar.Avatar.UIStroke, "Color", "Outline")
    
    Create("TextLabel", {
        Name = "DisplayName",
        Parent = ProfileBar,
        Position = UDim2.new(0, 54, 0, 6),
        Size = UDim2.new(1, -64, 0, 18),
        BackgroundTransparency = 1,
        Text = LocalPlayer.DisplayName,
        TextColor3 = Theme.Text,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 3
    })
    RegisterThemed(ProfileBar.DisplayName, "TextColor3", "Text")
    
    Create("TextLabel", {
        Name = "Username",
        Parent = ProfileBar,
        Position = UDim2.new(0, 54, 0, 25),
        Size = UDim2.new(1, -64, 0, 16),
        BackgroundTransparency = 1,
        Text = "@" .. LocalPlayer.Name,
        TextColor3 = Theme.SubText,
        TextSize = 11,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        ZIndex = 3
    })
    RegisterThemed(ProfileBar.Username, "TextColor3", "SubText")
    
    local ContentContainer = Create("Frame", {
        Name = "ContentContainer",
        Parent = MainFrame,
        Position = UDim2.new(0, 160, 0, 40),
        Size = UDim2.new(1, -160, 1, -40),
        BackgroundTransparency = 1,
        ZIndex = 1
    })
    
    -- Holds search results pulled in from every tab at once, so the user
    -- doesn't have to click through tabs one by one to find something.
    SearchResultsFrame = Create("ScrollingFrame", {
        Name = "SearchResults",
        Parent = ContentContainer,
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Theme.Outline,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Visible = false,
        Create("UIPadding", {
            PaddingTop = UDim.new(0, 15),
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15)
        }),
        Create("UIListLayout", {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder
        })
    })
    RegisterThemed(SearchResultsFrame, "ScrollBarImageColor3", "Outline")
    SearchResultsFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        SearchResultsFrame.CanvasSize = UDim2.new(0, 0, 0, SearchResultsFrame.UIListLayout.AbsoluteContentSize.Y + 30)
    end)
    LuminaState.SearchResultsFrame = SearchResultsFrame
    
    -- Resize handles (drag corners to resize the GUI)
    local HANDLE_SIZE = 16
    
    local function CreateResizeHandle(corner)
        local anchor, position
        if corner == "TopLeft" then
            anchor = Vector2.new(0, 0)
            position = UDim2.new(0, 0, 0, 0)
        elseif corner == "TopRight" then
            anchor = Vector2.new(1, 0)
            position = UDim2.new(1, 0, 0, 0)
        elseif corner == "BottomLeft" then
            anchor = Vector2.new(0, 1)
            position = UDim2.new(0, 0, 1, 0)
        else -- BottomRight
            anchor = Vector2.new(1, 1)
            position = UDim2.new(1, 0, 1, 0)
        end
        
        local Handle = Create("Frame", {
            Name = corner .. "Handle",
            Parent = MainFrame,
            AnchorPoint = anchor,
            Position = position,
            Size = UDim2.new(0, HANDLE_SIZE, 0, HANDLE_SIZE),
            BackgroundTransparency = 1,
            ZIndex = 10
        })
        
        MakeResizable(Handle, MainFrame, corner, Vector2.new(500, 350), Vector2.new(1400, 900))
        table.insert(ResizeHandles, Handle)
        return Handle
    end
    
    CreateResizeHandle("TopLeft")
    CreateResizeHandle("TopRight")
    CreateResizeHandle("BottomLeft")
    CreateResizeHandle("BottomRight")
    
    LuminaState.MainGui = MainGui
    LuminaState.MainFrame = MainFrame
    LuminaState.TabList = TabList
    LuminaState.ContentContainer = ContentContainer
    
    local WindowObj = {}
        function WindowObj:SelectTab(index)
            local tabData = LuminaState.Tabs[index]
            if tabData then
                for _, otherData in pairs(LuminaState.Tabs) do
                    if otherData.Content == tabData.Content then
                        LuminaState.ActiveTab = tabData.Content
                        otherData.Content.Visible = true
                        ApplyTween(otherData.Btn, {BackgroundTransparency = 0, TextColor3 = GetTheme().Accent}, 0.2)
                        ApplyTween(otherData.Indicator, {Size = UDim2.new(0, 3, 0, 16)}, 0.2)
                    else
                        otherData.Content.Visible = false
                        ApplyTween(otherData.Btn, {BackgroundTransparency = 1, TextColor3 = GetTheme().SubText}, 0.2)
                        ApplyTween(otherData.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.2)
                    end
                end
            end
        end

        function WindowObj:AddMinimizeButton()
             -- Logic to toggle MainFrame.Visible
        end

        -- Exposes the live re-theme so a Theme tab (or any external script) can trigger it.
        function WindowObj:RefreshTheme()
            RefreshTheme()
        end

        function WindowObj:SetTheme(themeName)
            if Themes[themeName] then
                LuminaState.CurrentTheme = themeName
                RefreshTheme()
            end
        end

        function WindowObj:SetCustomColor(themeKey, color3)
            if Themes.Custom[themeKey] ~= nil then
                Themes.Custom[themeKey] = color3
                if LuminaState.CurrentTheme == "Custom" then
                    RefreshTheme()
                end
            end
        end
    
    function WindowObj:MakeDropdownTab(config)
        local Title = config.Title or "Dropdown"
        
        local GroupFrame = Create("Frame", {
            Name = Title .. "Group",
            Parent = TabList,
            Size = UDim2.new(1, 0, 0, 32),
            BackgroundTransparency = 1,
            ClipsDescendants = true
        })
        
        local TopBtn = Create("TextButton", {
            Name = "TopBtn",
            Parent = GroupFrame,
            Size = UDim2.new(1, -20, 0, 32),
            Position = UDim2.new(0, 10, 0, 0),
            BackgroundColor3 = Theme.Element,
            BackgroundTransparency = 1,
            Text = "  " .. Title,
            TextColor3 = Theme.Text,
            TextSize = 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            Create("UICorner", { CornerRadius = UDim.new(0, 6) })
        })
        RegisterThemed(TopBtn, "TextColor3", "Text")
        
        local Arrow = Create("TextLabel", {
            Name = "Arrow",
            Parent = TopBtn,
            AnchorPoint = Vector2.new(1, 0.5),
            Position = UDim2.new(1, -10, 0.5, 0),
            Size = UDim2.new(0, 12, 0, 12),
            BackgroundTransparency = 1,
            Text = "▼",
            TextColor3 = Theme.SubText,
            TextSize = 10,
            Font = Enum.Font.Gotham
        })
        RegisterThemed(Arrow, "TextColor3", "SubText")
        
        local SubTabContainer = Create("Frame", {
            Name = "SubTabs",
            Parent = GroupFrame,
            Position = UDim2.new(0, 0, 0, 32),
            Size = UDim2.new(1, 0, 1, -32),
            BackgroundTransparency = 1,
            Create("UIListLayout", {
                Padding = UDim.new(0, 2),
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
        
        local isOpen = false
        local subTabCount = 0
        
        TopBtn.MouseButton1Click:Connect(function()
            isOpen = not isOpen
            if isOpen then
                ApplyTween(GroupFrame, {Size = UDim2.new(1, 0, 0, 32 + (subTabCount * 30))}, 0.2)
                ApplyTween(Arrow, {Rotation = 180}, 0.2)
            else
                ApplyTween(GroupFrame, {Size = UDim2.new(1, 0, 0, 32)}, 0.2)
                ApplyTween(Arrow, {Rotation = 0}, 0.2)
            end
        end)
        
        local GroupObj = {}
        function GroupObj:MakeTab(tabConfig)
            subTabCount = subTabCount + 1
            tabConfig.ParentContainer = SubTabContainer
            tabConfig.IsSubTab = true
            
            if isOpen then
                ApplyTween(GroupFrame, {Size = UDim2.new(1, 0, 0, 32 + (subTabCount * 30))}, 0.2)
            end
            
            return WindowObj:MakeTab(tabConfig)
        end
        return GroupObj
    end

    function WindowObj:MakeTab(tabConfig)
        local TabName = tabConfig.Title or "Tab"
        local ParentContainer = tabConfig.ParentContainer or TabList
        local IsSubTab = tabConfig.IsSubTab or false
        
        local TabBtn = Create("TextButton", {
            Name = TabName .. "Tab",
            Parent = ParentContainer,
            Size = UDim2.new(1, -20, 0, IsSubTab and 28 or 32),
            BackgroundColor3 = Theme.Element,
            BackgroundTransparency = 1,
            Text = (IsSubTab and "    " or "  ") .. TabName,
            TextColor3 = Theme.SubText,
            TextSize = IsSubTab and 12 or 13,
            Font = Enum.Font.GothamMedium,
            TextXAlignment = Enum.TextXAlignment.Left,
            AutoButtonColor = false,
            Create("UICorner", { CornerRadius = UDim.new(0, 6) })
        })
        
        local TabIndicator = Create("Frame", {
            Name = "Indicator",
            Parent = TabBtn,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, -5, 0.5, 0),
            Size = UDim2.new(0, 3, 0, 0),
            BackgroundColor3 = Theme.Accent,
            BorderSizePixel = 0,
            Create("UICorner", { CornerRadius = UDim.new(1, 0) })
        })
        RegisterThemed(TabIndicator, "BackgroundColor3", "Accent")
        
        local TabContent = Create("ScrollingFrame", {
            Name = TabName .. "Content",
            Parent = ContentContainer,
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            ScrollBarThickness = 4,
            ScrollBarImageColor3 = Theme.Outline,
            CanvasSize = UDim2.new(0, 0, 0, 0),
            Visible = false,
            Create("UIPadding", {
                PaddingTop = UDim.new(0, 15),
                PaddingBottom = UDim.new(0, 15),
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15)
            }),
            Create("UIListLayout", {
                Padding = UDim.new(0, 8),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
        RegisterThemed(TabContent, "ScrollBarImageColor3", "Outline")
        
        TabContent.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 30)
        end)
        
        table.insert(LuminaState.Tabs, {
            Btn = TabBtn,
            Content = TabContent,
            Indicator = TabIndicator
        })
        
        TabBtn.MouseEnter:Connect(function()
            if LuminaState.ActiveTab ~= TabContent then
                ApplyTween(TabBtn, {BackgroundTransparency = 0.8}, 0.2)
            end
        end)
        
        TabBtn.MouseLeave:Connect(function()
            if LuminaState.ActiveTab ~= TabContent then
                ApplyTween(TabBtn, {BackgroundTransparency = 1}, 0.2)
            end
        end)
        
        TabBtn.MouseButton1Click:Connect(function()
            if SearchBox and SearchBox.Text ~= "" then
                SearchBox.Text = ""
            end
            for _, tabData in pairs(LuminaState.Tabs) do
                if tabData.Content == TabContent then
                    LuminaState.ActiveTab = TabContent
                    tabData.Content.Visible = true
                    ApplyTween(tabData.Btn, {BackgroundTransparency = 0, TextColor3 = GetTheme().Accent}, 0.2)
                    ApplyTween(tabData.Indicator, {Size = UDim2.new(0, 3, 0, 16)}, 0.2)
                else
                    tabData.Content.Visible = false
                    ApplyTween(tabData.Btn, {BackgroundTransparency = 1, TextColor3 = GetTheme().SubText}, 0.2)
                    ApplyTween(tabData.Indicator, {Size = UDim2.new(0, 3, 0, 0)}, 0.2)
                end
            end
        end)
        
        -- Select first tab by default
        if #LuminaState.Tabs == 1 then
            LuminaState.ActiveTab = TabContent
            TabContent.Visible = true
            TabBtn.BackgroundTransparency = 0
            TabBtn.TextColor3 = Theme.Accent
            TabIndicator.Size = UDim2.new(0, 3, 0, 16)
        end
        
        local TabObj = {}
        local orderCounter = 0
        local function NextOrder()
            orderCounter = orderCounter + 1
            return orderCounter
        end
        
        function TabObj:AddButton(btnConfig)
            local Title = btnConfig.Title or "Button"
            local Callback = btnConfig.Callback or function() end
            
            local BtnFrame = Create("TextButton", {
                Name = "Button",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.Element,
                Text = "",
                AutoButtonColor = false,
                Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
            })
            RegisterThemed(BtnFrame, "BackgroundColor3", "Element")
            RegisterThemed(BtnFrame.UIStroke, "Color", "Outline")
            LuminaState.ElementOrigin[BtnFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = BtnFrame.LayoutOrder}
            
            local BtnTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = BtnFrame,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -24, 1, 0),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(BtnTitleLbl, "TextColor3", "Text")
            
            local BtnIcon = Create("ImageLabel", {
                Name = "Icon",
                Parent = BtnFrame,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.new(0, 16, 0, 16),
                BackgroundTransparency = 1,
                Image = "rbxassetid://6022668888",
                ImageColor3 = Theme.SubText
            })
            RegisterThemed(BtnIcon, "ImageColor3", "SubText")
            
            BtnFrame.MouseEnter:Connect(function() ApplyTween(BtnFrame, {BackgroundColor3 = GetTheme().ElementHover}, 0.2) end)
            BtnFrame.MouseLeave:Connect(function() ApplyTween(BtnFrame, {BackgroundColor3 = GetTheme().Element}, 0.2) end)
            
            BtnFrame.MouseButton1Click:Connect(function()
                Callback()
            end)
        end
        
        function TabObj:AddToggle(togConfig)
            local Title = togConfig.Title or "Toggle"
            local Default = togConfig.Default or false
            local Callback = togConfig.Callback or function() end
            
            local state = Default
            
            local TogFrame = Create("TextButton", {
                Name = "Toggle",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.Element,
                Text = "",
                AutoButtonColor = false,
                Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
            })
            RegisterThemed(TogFrame, "BackgroundColor3", "Element")
            RegisterThemed(TogFrame.UIStroke, "Color", "Outline")
            LuminaState.ElementOrigin[TogFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = TogFrame.LayoutOrder}
            
            local TogTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = TogFrame,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(TogTitleLbl, "TextColor3", "Text")
            
            local Switch = Create("Frame", {
                Name = "Switch",
                Parent = TogFrame,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.new(0, 36, 0, 18),
                BackgroundColor3 = state and Theme.Accent or Theme.Outline,
                Create("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            
            local Circle = Create("Frame", {
                Name = "Circle",
                Parent = Switch,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, state and 18 or 2, 0.5, 0),
                Size = UDim2.new(0, 14, 0, 14),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Create("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            
            TogFrame.MouseEnter:Connect(function() ApplyTween(TogFrame, {BackgroundColor3 = GetTheme().ElementHover}, 0.2) end)
            TogFrame.MouseLeave:Connect(function() ApplyTween(TogFrame, {BackgroundColor3 = GetTheme().Element}, 0.2) end)
            
            TogFrame.MouseButton1Click:Connect(function()
                state = not state
                if state then
                    ApplyTween(Switch, {BackgroundColor3 = GetTheme().Accent}, 0.2)
                    ApplyTween(Circle, {Position = UDim2.new(0, 20, 0.5, 0)}, 0.2)
                else
                    ApplyTween(Switch, {BackgroundColor3 = GetTheme().Outline}, 0.2)
                    ApplyTween(Circle, {Position = UDim2.new(0, 2, 0.5, 0)}, 0.2)
                end
                Callback(state)
            end)
            
            -- Call initially
            task.spawn(function() Callback(state) end)
        end
        
        function TabObj:AddSlider(sldConfig)
            local Title = sldConfig.Title or "Slider"
            local Min = sldConfig.Min or 0
            local Max = sldConfig.Max or 100
            local Default = sldConfig.Default or Min
            local Callback = sldConfig.Callback or function() end
            
            local Value = math.clamp(Default, Min, Max)
            
            local SldFrame = Create("Frame", {
                Name = "Slider",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 56),
                BackgroundColor3 = Theme.Element,
                Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
            })
            RegisterThemed(SldFrame, "BackgroundColor3", "Element")
            RegisterThemed(SldFrame.UIStroke, "Color", "Outline")
            LuminaState.ElementOrigin[SldFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = SldFrame.LayoutOrder}
            
            local SldTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = SldFrame,
                Position = UDim2.new(0, 12, 0, 8),
                Size = UDim2.new(1, -24, 0, 16),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(SldTitleLbl, "TextColor3", "Text")
            
            local ValueLabel = Create("TextLabel", {
                Name = "Value",
                Parent = SldFrame,
                Position = UDim2.new(1, -50, 0, 8),
                Size = UDim2.new(0, 38, 0, 16),
                BackgroundTransparency = 1,
                Text = tostring(Value),
                TextColor3 = Theme.SubText,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            RegisterThemed(ValueLabel, "TextColor3", "SubText")
            
            local Track = Create("TextButton", {
                Name = "Track",
                Parent = SldFrame,
                Position = UDim2.new(0, 12, 0, 34),
                Size = UDim2.new(1, -24, 0, 6),
                BackgroundColor3 = Theme.Outline,
                Text = "",
                AutoButtonColor = false,
                Create("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            RegisterThemed(Track, "BackgroundColor3", "Outline")
            
            local Fill = Create("Frame", {
                Name = "Fill",
                Parent = Track,
                Size = UDim2.new((Value - Min) / (Max - Min), 0, 1, 0),
                BackgroundColor3 = Theme.Accent,
                Create("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            RegisterThemed(Fill, "BackgroundColor3", "Accent")
            
            local Knob = Create("Frame", {
                Name = "Knob",
                Parent = Fill,
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(1, 0, 0.5, 0),
                Size = UDim2.new(0, 14, 0, 14),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Create("UICorner", { CornerRadius = UDim.new(1, 0) })
            })
            
            local dragging = false
            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
                Value = math.floor(Min + ((Max - Min) * pos))
                ValueLabel.Text = tostring(Value)
                ApplyTween(Fill, {Size = UDim2.new(pos, 0, 1, 0)}, 0.05)
                Callback(Value)
            end
            
            Track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)
            
            task.spawn(function() Callback(Value) end)
        end
        
        function TabObj:AddDropdown(dpConfig)
            local Title = dpConfig.Title or "Dropdown"
            local Options = dpConfig.Options or {}
            local Default = dpConfig.Default or Options[1]
            local Callback = dpConfig.Callback or function() end
            
            local selected = Default
            local isOpen = false
            
            local DpFrame = Create("Frame", {
                Name = "Dropdown",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.Element,
                ClipsDescendants = true,
                Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
            })
            RegisterThemed(DpFrame, "BackgroundColor3", "Element")
            RegisterThemed(DpFrame.UIStroke, "Color", "Outline")
            LuminaState.ElementOrigin[DpFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = DpFrame.LayoutOrder}
            
            local TopBtn = Create("TextButton", {
                Name = "TopBtn",
                Parent = DpFrame,
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundTransparency = 1,
                Text = "",
                AutoButtonColor = false
            })
            
            local DpTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = TopBtn,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(1, -60, 1, 0),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(DpTitleLbl, "TextColor3", "Text")
            
            local ValueLabel = Create("TextLabel", {
                Name = "Value",
                Parent = TopBtn,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -30, 0.5, 0),
                Size = UDim2.new(0, 100, 0, 20),
                BackgroundTransparency = 1,
                Text = tostring(selected),
                TextColor3 = Theme.SubText,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Right
            })
            RegisterThemed(ValueLabel, "TextColor3", "SubText")
            
            local Icon = Create("TextLabel", {
                Name = "Icon",
                Parent = TopBtn,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.new(0, 12, 0, 12),
                BackgroundTransparency = 1,
                Text = "▼",
                TextColor3 = Theme.SubText,
                TextSize = 10,
                Font = Enum.Font.Gotham
            })
            RegisterThemed(Icon, "TextColor3", "SubText")
            
            local ListContainer = Create("ScrollingFrame", {
                Name = "List",
                Parent = DpFrame,
                Position = UDim2.new(0, 0, 0, 36),
                Size = UDim2.new(1, 0, 1, -36),
                BackgroundTransparency = 1,
                ScrollBarThickness = 2,
                ScrollBarImageColor3 = Theme.Outline,
                CanvasSize = UDim2.new(0, 0, 0, 0),
                Create("UIListLayout", {
                    SortOrder = Enum.SortOrder.LayoutOrder
                })
            })
            
            local function populate()
                for _, child in pairs(ListContainer:GetChildren()) do
                    if child:IsA("TextButton") then child:Destroy() end
                end
                
                local y = 0
                local ThemeNow = GetTheme()
                for _, opt in pairs(Options) do
                    local optBtn = Create("TextButton", {
                        Name = opt,
                        Parent = ListContainer,
                        Size = UDim2.new(1, 0, 0, 30),
                        BackgroundColor3 = ThemeNow.Element,
                        BackgroundTransparency = 1,
                        Text = "  " .. tostring(opt),
                        TextColor3 = selected == opt and ThemeNow.Accent or ThemeNow.Text,
                        TextSize = 13,
                        Font = Enum.Font.Gotham,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        AutoButtonColor = false
                    })
                    
                    optBtn.MouseEnter:Connect(function() ApplyTween(optBtn, {BackgroundTransparency = 0.5}, 0.2) end)
                    optBtn.MouseLeave:Connect(function() ApplyTween(optBtn, {BackgroundTransparency = 1}, 0.2) end)
                    
                    optBtn.MouseButton1Click:Connect(function()
                        selected = opt
                        ValueLabel.Text = tostring(opt)
                        isOpen = false
                        ApplyTween(DpFrame, {Size = UDim2.new(1, 0, 0, 36)}, 0.2)
                        ApplyTween(Icon, {Rotation = 0}, 0.2)
                        populate()
                        Callback(selected)
                    end)
                    y = y + 30
                end
                ListContainer.CanvasSize = UDim2.new(0, 0, 0, y)
            end
            
            populate()
            
            TopBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    local h = math.min(#Options * 30, 150)
                    ApplyTween(DpFrame, {Size = UDim2.new(1, 0, 0, 36 + h)}, 0.2)
                    ApplyTween(Icon, {Rotation = 180}, 0.2)
                else
                    ApplyTween(DpFrame, {Size = UDim2.new(1, 0, 0, 36)}, 0.2)
                    ApplyTween(Icon, {Rotation = 0}, 0.2)
                end
            end)
            
            task.spawn(function() Callback(selected) end)

            -- expose so a Theme tab can refresh option colors after switching themes
            local DropdownObj = { Refresh = populate }
            return DropdownObj
        end
        
        function TabObj:AddTextBox(tbConfig)
            local Title = tbConfig.Title or "TextBox"
            local Default = tbConfig.Default or ""
            local Placeholder = tbConfig.Placeholder or "Type here..."
            local Callback = tbConfig.Callback or function() end
            
            local TbFrame = Create("Frame", {
                Name = "TextBox",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 36),
                BackgroundColor3 = Theme.Element,
                Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 })
            })
            RegisterThemed(TbFrame, "BackgroundColor3", "Element")
            RegisterThemed(TbFrame.UIStroke, "Color", "Outline")
            LuminaState.ElementOrigin[TbFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = TbFrame.LayoutOrder}
            
            local TbTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = TbFrame,
                Position = UDim2.new(0, 12, 0, 0),
                Size = UDim2.new(0.5, -12, 1, 0),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Text,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(TbTitleLbl, "TextColor3", "Text")
            
            local InputBox = Create("TextBox", {
                Name = "Input",
                Parent = TbFrame,
                AnchorPoint = Vector2.new(1, 0.5),
                Position = UDim2.new(1, -12, 0.5, 0),
                Size = UDim2.new(0.5, -24, 0, 24),
                BackgroundColor3 = Theme.Main,
                Text = Default,
                PlaceholderText = Placeholder,
                TextColor3 = Theme.Text,
                PlaceholderColor3 = Theme.SubText,
                TextSize = 12,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextTruncate = Enum.TextTruncate.AtEnd,
                ClearTextOnFocus = false,
                Create("UICorner", { CornerRadius = UDim.new(0, 4) }),
                Create("UIStroke", { Color = Theme.Outline, Thickness = 1 }),
                Create("UIPadding", {
                    PaddingLeft = UDim.new(0, 8),
                    PaddingRight = UDim.new(0, 8)
                })
            })
            RegisterThemed(InputBox, "BackgroundColor3", "Main")
            RegisterThemed(InputBox, "TextColor3", "Text")
            RegisterThemed(InputBox.UIStroke, "Color", "Outline")
            
            InputBox.FocusLost:Connect(function(enterPressed)
                Callback(InputBox.Text)
            end)
        end
        
        function TabObj:AddSection(secConfig)
            local Title = secConfig.Title or "Section"
            
            local SecFrame = Create("Frame", {
                Name = "Section",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 24),
                BackgroundTransparency = 1
            })
            
            local SecTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = SecFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = Title,
                TextColor3 = Theme.Accent,
                TextSize = 14,
                Font = Enum.Font.GothamBold,
                TextXAlignment = Enum.TextXAlignment.Left
            })
            RegisterThemed(SecTitleLbl, "TextColor3", "Accent")
            
            local SecLine = Create("Frame", {
                Name = "Line",
                Parent = SecFrame,
                AnchorPoint = Vector2.new(0, 1),
                Position = UDim2.new(0, 0, 1, -2),
                Size = UDim2.new(1, 0, 0, 1),
                BackgroundColor3 = Theme.Outline,
                BorderSizePixel = 0
            })
            RegisterThemed(SecLine, "BackgroundColor3", "Outline")
        end
        
        function TabObj:AddLabel(lblConfig)
            local Text = lblConfig.Text or "Label"
            
            local LblFrame = Create("Frame", {
                Name = "Label",
                Parent = TabContent,
                LayoutOrder = NextOrder(),
                Size = UDim2.new(1, 0, 0, 20),
                BackgroundTransparency = 1
            })
            
            local LblTitleLbl = Create("TextLabel", {
                Name = "Title",
                Parent = LblFrame,
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 1,
                Text = Text,
                TextColor3 = Theme.SubText,
                TextSize = 13,
                Font = Enum.Font.Gotham,
                TextXAlignment = Enum.TextXAlignment.Left,
                RichText = true
            })
            RegisterThemed(LblTitleLbl, "TextColor3", "SubText")
            LuminaState.ElementOrigin[LblFrame] = {Parent = TabContent, TabName = TabName, LayoutOrder = LblFrame.LayoutOrder}
        end
        
        return TabObj
    end
    
    return WindowObj
end

function Lumina:Notify(notifConfig)
    local Title = notifConfig.Title or "Notification"
    local Text = notifConfig.Text or ""
    local Duration = notifConfig.Duration or 3
    
    local Theme = GetTheme()
    
    if not CoreGui:FindFirstChild("LuminaNotifications") then
        Create("ScreenGui", {
            Name = "LuminaNotifications",
            Parent = GetParentGui(),
            ResetOnSpawn = false
        })
        
        Create("Frame", {
            Name = "Container",
            Parent = GetParentGui().LuminaNotifications,
            AnchorPoint = Vector2.new(1, 1),
            Position = UDim2.new(1, -20, 1, -20),
            Size = UDim2.new(0, 250, 1, 0),
            BackgroundTransparency = 1,
            Create("UIListLayout", {
                VerticalAlignment = Enum.VerticalAlignment.Bottom,
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
    end
    
    local Container = GetParentGui().LuminaNotifications.Container
    
    local NotifFrame = Create("Frame", {
        Name = "Notif",
        Parent = Container,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundColor3 = Theme.Element,
        BackgroundTransparency = 1,
        Create("UICorner", { CornerRadius = UDim.new(0, 6) }),
        Create("UIStroke", { Color = Theme.Outline, Thickness = 1, Transparency = 1 })
    })
    
    local TitleLbl = Create("TextLabel", {
        Name = "Title",
        Parent = NotifFrame,
        Position = UDim2.new(0, 15, 0, 10),
        Size = UDim2.new(1, -30, 0, 16),
        BackgroundTransparency = 1,
        Text = Title,
        TextColor3 = Theme.Text,
        TextTransparency = 1,
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local TextLbl = Create("TextLabel", {
        Name = "Text",
        Parent = NotifFrame,
        Position = UDim2.new(0, 15, 0, 28),
        Size = UDim2.new(1, -30, 0, 16),
        BackgroundTransparency = 1,
        Text = Text,
        TextColor3 = Theme.SubText,
        TextTransparency = 1,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    ApplyTween(NotifFrame, {BackgroundTransparency = 0}, 0.3)
    ApplyTween(NotifFrame.UIStroke, {Transparency = 0}, 0.3)
    ApplyTween(TitleLbl, {TextTransparency = 0}, 0.3)
    ApplyTween(TextLbl, {TextTransparency = 0}, 0.3)
    
    task.spawn(function()
        task.wait(Duration)
        ApplyTween(NotifFrame, {BackgroundTransparency = 1}, 0.3)
        ApplyTween(NotifFrame.UIStroke, {Transparency = 1}, 0.3)
        ApplyTween(TitleLbl, {TextTransparency = 1}, 0.3)
        local out = ApplyTween(TextLbl, {TextTransparency = 1}, 0.3)
        out.Completed:Wait()
        NotifFrame:Destroy()
    end)
end

return Lumina
