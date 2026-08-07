local Lumina = loadstring(game:HttpGet("https://raw.githubusercontent.com/ugmoddev/LuminaLibrary/refs/heads/main/LuminaLibrary.luau"))()


local Window = Lumina:CreateWindow({
    Title = "Lumina Hub",
    Version = "v2.5 Premium",
    Size = UDim2.new(0, 750, 0, 480)
})

local MainTab = Window:MakeTab({ Title = "Main", Icon = "home" })
local CombatTab = Window:MakeTab({ Title = "Combat", Icon = "swords" })
local PlayerTab = Window:MakeTab({ Title = "Player", Icon = "user" })
local SettingsTab = Window:MakeTab({ Title = "Settings", Icon = "settings" })
local ShowcaseTab = Window:MakeTab({ Title = "Showcase", Icon = "grid" })
local ThemeTab = Window:MakeTab({ Title = "Theme", Icon = "palette" })

local MiscGroup = Window:MakeDropdownTab({ Title = "Misc Features" })
local InfoTab = MiscGroup:MakeTab({ Title = "Information" })
local CreditsTab = MiscGroup:MakeTab({ Title = "Credits" })

ThemeTab:AddSection({ Title = "Presets" })

ThemeTab:AddLabel({ Text = "Choose a built-in theme or tweak the custom one below." })

ThemeTab:AddDropdown({
    Title = "Theme Preset",
    Options = {
    "Dark", "Light", "Midnight", "Forest", "Emerald", "Mint", "Sage",
    "Ocean", "Sky", "DeepBlue", "Arctic", "Crimson", "Rose", "Cherry",
    "Pink", "Blush", "Violet", "Lavender", "Plum", "Sunset", "Amber",
    "Gold", "Peach", "Chocolate", "Coffee", "Cream", "PastelBlue",
    "PastelPink", "PastelGreen", "PastelPurple", "NeonBlue", "NeonGreen",
    "NeonPink", "NeonOrange", "Matrix", "Dracula", "Nord", "Solarized",
    "Gruvbox", "Paper", "Monochrome", "Silver", "Graphite", "Sakura",
    "Aurora", "Galaxy", "Candy", "Oceanic", "Desert", "Tropical", "Winter"
    }
    Default = "Dark",
    Callback = function(selected)
        Window:SetTheme(selected)
        Lumina:Notify({ Title = "Theme", Text = "Switched to " .. selected .. " theme.", Duration = 2 })
    end
})

ThemeTab:AddSection({ Title = "Custom Colors (RGB 0-255)" })

ThemeTab:AddLabel({ Text = "These only apply while the 'Custom' preset is active." })

local function AddColorSliders(tab, label, themeKey, defaultColor)
    tab:AddSection({ Title = label })
    local r, g, b = math.floor(defaultColor.R * 255), math.floor(defaultColor.G * 255), math.floor(defaultColor.B * 255)

    local function pushColor()
        Window:SetCustomColor(themeKey, Color3.fromRGB(r, g, b))
    end

    tab:AddSlider({
        Title = label .. " - Red",
        Min = 0, Max = 255, Default = r,
        Callback = function(v) r = v; pushColor() end
    })
    tab:AddSlider({
        Title = label .. " - Green",
        Min = 0, Max = 255, Default = g,
        Callback = function(v) g = v; pushColor() end
    })
    tab:AddSlider({
        Title = label .. " - Blue",
        Min = 0, Max = 255, Default = b,
        Callback = function(v) b = v; pushColor() end
    })
end

AddColorSliders(ThemeTab, "Accent", "Accent", Color3.fromRGB(85, 170, 255))
AddColorSliders(ThemeTab, "Background", "Main", Color3.fromRGB(30, 30, 35))
AddColorSliders(ThemeTab, "Sidebar", "Sidebar", Color3.fromRGB(25, 25, 30))

ThemeTab:AddSection({ Title = "Utility" })
ThemeTab:AddButton({
    Title = "Reset Custom Theme To Dark",
    Callback = function()
        Window:SetCustomColor("Main", Color3.fromRGB(30, 30, 35))
        Window:SetCustomColor("Sidebar", Color3.fromRGB(25, 25, 30))
        Window:SetCustomColor("Header", Color3.fromRGB(20, 20, 25))
        Window:SetCustomColor("Accent", Color3.fromRGB(85, 170, 255))
        Window:SetCustomColor("Element", Color3.fromRGB(40, 40, 45))
        Window:SetCustomColor("Outline", Color3.fromRGB(60, 60, 65))
        Lumina:Notify({ Title = "Theme", Text = "Custom theme reset.", Duration = 2 })
    end
})

InfoTab:AddSection({ Title = "Server Information" })

InfoTab:AddLabel({ Text = "This is a sub-tab inside a dropdown category!" })

InfoTab:AddButton({
    Title = "Copy Server Job-Id",
    Callback = function()
        local jobId = game.JobId ~= "" and game.JobId or "Studio"
        setclipboard(jobId)
        Lumina:Notify({ Title = "Copied", Text = "Job-Id copied to clipboard!", Duration = 3 })
    end
})

InfoTab:AddButton({
    Title = "Print Info",
    Callback = function()
        print("Info!")
    end
})

InfoTab:AddToggle({
    Title = "Show FPS Counter",
    Default = false,
    Callback = function(state)
        print("FPS Counter:", state)
    end
})

InfoTab:AddDropdown({
    Title = "Info Category",
    Options = {"Player", "Server", "Game"},
    Default = "Player",
    Callback = function(selected)
        print("Info category:", selected)
    end
})

CreditsTab:AddSection({ Title = "About" })

CreditsTab:AddLabel({ Text = "Developed with Luau" })
CreditsTab:AddLabel({ Text = "Lumina UI - Standalone Fluent Design" })

CreditsTab:AddButton({
    Title = "Join Discord Server",
    Callback = function()
        Lumina:Notify({ Title = "Discord", Text = "Discord link copied to clipboard!", Duration = 3 })
    end
})

CreditsTab:AddTextBox({
    Title = "Feedback",
    Placeholder = "Leave your feedback here...",
    Callback = function(txt)
        print("Feedback received: " .. txt)
        Lumina:Notify({ Title = "Thank You!", Text = "Your feedback has been recorded.", Duration = 3 })
    end
})

MainTab:AddSection({ Title = "General Features" })

MainTab:AddButton({
    Title = "Unlock All FPS",
    Callback = function()
        setfpscap(999)
        Lumina:Notify({ Title = "Success", Text = "FPS unlocked to 999!", Duration = 3 })
    end
})

MainTab:AddToggle({
    Title = "Auto Farm (Level)",
    Default = false,
    Callback = function(state)
        if state then
            Lumina:Notify({ Title = "Auto Farm", Text = "Started farming...", Duration = 3 })
        else
            Lumina:Notify({ Title = "Auto Farm", Text = "Stopped farming.", Duration = 3 })
        end
    end
})

MainTab:AddSection({ Title = "Targeting" })

MainTab:AddDropdown({
    Title = "Select Mob to Farm",
    Options = {"Bandit [Lv. 5]", "Monkey [Lv. 14]", "Gorilla [Lv. 20]", "Boss [Lv. 50]"},
    Default = "Bandit [Lv. 5]",
    Callback = function(selected)
        print("Đang target: " .. selected)
    end
})

CombatTab:AddSection({ Title = "PVP Settings" })

CombatTab:AddToggle({
    Title = "Aimbot",
    Default = false,
    Callback = function(state)
        print("Aimbot:", state)
    end
})

CombatTab:AddSlider({
    Title = "Hitbox Expander",
    Min = 1,
    Max = 50,
    Default = 5,
    Callback = function(value)
        print("Hitbox size set to:", value)
    end
})

CombatTab:AddSection({ Title = "Targeting" })

CombatTab:AddDropdown({
    Title = "Target Part",
    Options = {"Head", "Torso", "HumanoidRootPart"},
    Default = "Head",
    Callback = function(part)
        print("Targeting:", part)
    end
})

PlayerTab:AddSection({ Title = "Local Player Modifications" })

PlayerTab:AddSlider({
    Title = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end
})

PlayerTab:AddSlider({
    Title = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(value)
        local player = game.Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end
})

PlayerTab:AddSection({ Title = "Teleport" })

PlayerTab:AddTextBox({
    Title = "Teleport To Player",
    Placeholder = "Enter Player Name...",
    Callback = function(playerName)
        Lumina:Notify({ Title = "Teleport", Text = "Teleporting to " .. playerName .. "...", Duration = 4 })
    end
})

SettingsTab:AddSection({ Title = "UI Configuration" })

SettingsTab:AddButton({
    Title = "Unload UI",
    Callback = function()
        Lumina:Notify({ Title = "Unloaded", Text = "Destroying UI...", Duration = 2 })
        task.wait(2)
        -- Trong script thực tế, bạn có thể gọi DestroyUI() (bạn cần expose hàm này ra API)
    end
})

SettingsTab:AddSection({ Title = "Info" })

SettingsTab:AddLabel({
    Text = "Lumina Hub Premium - Developed by You"
})

ShowcaseTab:AddSection({ Title = "Buttons" })

ShowcaseTab:AddButton({
    Title = "Simple Button",
    Callback = function()
        print("Simple Button clicked!")
        Lumina:Notify({ Title = "Button", Text = "You clicked the simple button.", Duration = 3 })
    end
})

ShowcaseTab:AddButton({
    Title = "Another Action",
    Callback = function()
        print("Another Action executed!")
    end
})

ShowcaseTab:AddSection({ Title = "Toggles" })

ShowcaseTab:AddToggle({
    Title = "Basic Toggle",
    Default = false,
    Callback = function(state)
        print("Basic Toggle:", state)
    end
})

ShowcaseTab:AddToggle({
    Title = "Enabled By Default",
    Default = true,
    Callback = function(state)
        print("Enabled By Default:", state)
    end
})

ShowcaseTab:AddSection({ Title = "Sliders" })

ShowcaseTab:AddSlider({
    Title = "Basic Slider (0-100)",
    Min = 0,
    Max = 100,
    Default = 50,
    Callback = function(value)
        print("Basic Slider:", value)
    end
})

ShowcaseTab:AddSlider({
    Title = "Custom Range Slider (10-500)",
    Min = 10,
    Max = 500,
    Default = 100,
    Callback = function(value)
        print("Custom Range Slider:", value)
    end
})

ShowcaseTab:AddSection({ Title = "Dropdown" })

ShowcaseTab:AddDropdown({
    Title = "Choose An Option",
    Options = {"Option 1", "Option 2", "Option 3", "Option 4"},
    Default = "Option 1",
    Callback = function(selected)
        print("Choose An Option:", selected)
    end
})

ShowcaseTab:AddSection({ Title = "Text Input" })

ShowcaseTab:AddTextBox({
    Title = "Sample Input",
    Placeholder = "Type something...",
    Callback = function(txt)
        print("Sample Input:", txt)
        Lumina:Notify({ Title = "Input Received", Text = "You typed: " .. txt, Duration = 3 })
    end
})

ShowcaseTab:AddSection({ Title = "Labels" })

ShowcaseTab:AddLabel({ Text = "This is a simple label for displaying static text." })
ShowcaseTab:AddLabel({ Text = "You can add as many labels as needed." })


Window:SelectTab(1)

Lumina:Notify({ 
    Title = "Welcome!", 
    Text = "Lumina Hub loaded successfully.", 
    Duration = 5 
})
