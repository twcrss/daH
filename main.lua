 -- Load Rayfield Library
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Create Main Window with Custom Theme
local Window = Rayfield:CreateWindow({
   Name = "Da hood 🔫",
   Icon = 0,
   LoadingTitle = "Externalcists Interface",
   LoadingSubtitle = "Made by Andy",
   ShowText = "Twxerzz",
   Theme = {
      TextColor = Color3.fromRGB(46, 251, 224),
      Background = Color3.fromRGB(25, 25, 25),
      Topbar = Color3.fromRGB(34, 34, 34),
      Shadow = Color3.fromRGB(20, 20, 20),
      NotificationBackground = Color3.fromRGB(20, 20, 20),
      NotificationActionsBackground = Color3.fromRGB(230, 230, 230),
      TabBackground = Color3.fromRGB(80, 80, 80),
      TabStroke = Color3.fromRGB(85, 85, 85),
      TabBackgroundSelected = Color3.fromRGB(210, 210, 210),
      TabTextColor = Color3.fromRGB(240, 240, 240),
      SelectedTabTextColor = Color3.fromRGB(50, 50, 50),
      ElementBackground = Color3.fromRGB(35, 35, 35),
      ElementBackgroundHover = Color3.fromRGB(40, 40, 40),
      SecondaryElementBackground = Color3.fromRGB(25, 25, 25),
      ElementStroke = Color3.fromRGB(50, 50, 50),
      SecondaryElementStroke = Color3.fromRGB(40, 40, 40),
      SliderBackground = Color3.fromRGB(50, 138, 220),
      SliderProgress = Color3.fromRGB(50, 138, 220),
      SliderStroke = Color3.fromRGB(58, 163, 255),
      ToggleBackground = Color3.fromRGB(30, 30, 30),
      ToggleEnabled = Color3.fromRGB(0, 146, 214),
      ToggleDisabled = Color3.fromRGB(100, 100, 100),
      ToggleEnabledStroke = Color3.fromRGB(0, 170, 255),
      ToggleDisabledStroke = Color3.fromRGB(125, 125, 125),
      ToggleEnabledOuterStroke = Color3.fromRGB(100, 100, 100),
      ToggleDisabledOuterStroke = Color3.fromRGB(65, 65, 65),
      DropdownSelected = Color3.fromRGB(40, 40, 40),
      DropdownUnselected = Color3.fromRGB(30, 30, 30),
      InputBackground = Color3.fromRGB(30, 30, 30),
      InputStroke = Color3.fromRGB(65, 65, 65),
      PlaceholderColor = Color3.fromRGB(178, 178, 178)
   },
   ToggleUIKeybind = "K",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil,
      FileName = "Big Hub"
   },
   Discord = {
      Enabled = true,
      Invite = "rMxtFcfCCb",
      RememberJoins = true
   },
   KeySystem = true,
   KeySettings = {
      Title = "Externalcists Key System 🔑",
      Subtitle = "Key System",
      Note = "Join server in misc tab",
      FileName = "Externalcists Key",
      SaveKey=false,
      GrabKeyFromSite=false, -- disables easy grabbing
      Key=(function()
         local encoded_url = "\104\116\116\112\115\58\47\47\112\97\115\116\101\98\105\110\46\99\111\109\47\114\97\119\47\51\118\100\120\66\65\51\89"
         return {string.gsub(encoded_url, ".", function(c) return string.char(string.byte(c)) end)}
      end)()
   }
})

-- HOME TAB
local MainTab = Window:CreateTab("🏠 Home", nil)
local MainSection = MainTab:CreateSection("HitBox Extender")

_G.HitboxColor = Color3.fromRGB(0, 85, 255) -- Default blue hitbox color

Rayfield:Notify({
   Title = "Successfully executed Externalcists",
   Content = "Da hood bests script",
   Duration = 6.5,
})

-- Toggle Hitbox GUI
local Toggle = MainTab:CreateToggle({
   Name = "Toggle HitBox GUI",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
      _G.HitboxEnabled = Value
      if Value then
         spawn(function()
            while _G.HitboxEnabled do
               for _, player in pairs(game:GetService("Players"):GetPlayers()) do
                  if player ~= game:GetService("Players").LocalPlayer and player.Character then
                     pcall(function()
                        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp then
                           hrp.Size = Vector3.new(_G.HitboxSize or 8, _G.HitboxSize or 8, _G.HitboxSize or 8)
                           hrp.Transparency = 0.7
                           hrp.Color = _G.HitboxColor
                           hrp.Material = "Neon"
                           hrp.CanCollide = false
                        end
                     end)
                  end
               end
               task.wait(0.1)
            end
            -- Reset
            for _, player in pairs(game:GetService("Players"):GetPlayers()) do
               if player ~= game:GetService("Players").LocalPlayer and player.Character then
                  pcall(function()
                     local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                     if hrp then
                        hrp.Size = Vector3.new(2,2,1)
                        hrp.Transparency = 0
                        hrp.CanCollide = true
                     end
                  end)
               end
            end
         end)
      end
   end,
})

-- Hitbox Size
MainTab:CreateSlider({
   Name = "Hitbox Size",
   Range = {2, 40},
   Increment = 1,
   Suffix = "Size",
   CurrentValue = 8,
   Flag = "Slider1",
   Callback = function(Value)
      _G.HitboxSize = Value
   end,
})

-- Hitbox Color
MainTab:CreateColorPicker({
    Name = "Hitbox Color",
    Color = _G.HitboxColor,
    Flag = "ColorPicker1",
    Callback = function(Value)
        _G.HitboxColor = Value
    end
})

local MainDivider = MainTab:CreateDivider()

-- AIMBOT TAB
local MainSection = MainTab:CreateSection("Aimbot🎯")

local teamCheck = false
local fov = 90
local smoothing = 0.02
local predictionFactor = 0.08
local highlightEnabled = true
local lockPart = "HumanoidRootPart"
local ToggleMode = false
local ToggleKey = Enum.KeyCode.E

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local FOVring = Drawing.new("Circle")
FOVring.Visible = true
FOVring.Thickness = 1
FOVring.Radius = fov
FOVring.Transparency = 0.8
FOVring.Color = Color3.fromRGB(255, 128, 128)
FOVring.Position = workspace.CurrentCamera.ViewportSize / 2

local currentTarget = nil
local aimbotEnabled = false
local toggleState = false
local debounce = false

local function getClosest(cframe)
    local ray = Ray.new(cframe.Position, cframe.LookVector).Unit
    local target, mag = nil, math.huge
    local screenCenter = workspace.CurrentCamera.ViewportSize / 2

    for _, v in pairs(Players:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild(lockPart) and v.Character:FindFirstChild("HumanoidRootPart") and v ~= Players.LocalPlayer and (v.Team ~= Players.LocalPlayer.Team or not teamCheck) then
            local screenPoint, onScreen = workspace.CurrentCamera:WorldToViewportPoint(v.Character[lockPart].Position)
            local dist = (Vector2.new(screenPoint.X, screenPoint.Y) - screenCenter).Magnitude
            if onScreen and dist <= fov then
                local magBuf = (v.Character[lockPart].Position - ray:ClosestPoint(v.Character[lockPart].Position)).Magnitude
                if magBuf < mag then
                    mag, target = magBuf, v
                end
            end
        end
    end
    return target
end

local function updateFOVRing()
    FOVring.Position = workspace.CurrentCamera.ViewportSize / 2
    FOVring.Radius = fov
end

local function predictPosition(target)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local velocity = target.Character.HumanoidRootPart.Velocity
        local position = target.Character[lockPart].Position
        return position + (velocity * predictionFactor)
    end
end

local function handleToggle()
    if debounce then return end
    debounce = true
    toggleState = not toggleState
    task.wait(0.3)
    debounce = false
end

RunService.RenderStepped:Connect(function()
    if aimbotEnabled then
        updateFOVRing()
        local cam = workspace.CurrentCamera

        if ToggleMode then
            if UserInputService:IsKeyDown(ToggleKey) then
                handleToggle()
            end
        else
            toggleState = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        end

        if toggleState then
            if not currentTarget then
                currentTarget = getClosest(cam.CFrame)
            end
            if currentTarget and currentTarget.Character and currentTarget.Character:FindFirstChild(lockPart) then
                local predicted = predictPosition(currentTarget)
                if predicted then
                    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, predicted), smoothing)
                end
                FOVring.Color = Color3.fromRGB(0, 255, 0)
            else
                FOVring.Color = Color3.fromRGB(255, 128, 128)
            end
        else
            currentTarget = nil
            FOVring.Color = Color3.fromRGB(255, 128, 128)
        end
    else
        FOVring.Visible = false
    end
end)

-- AIMBOT CONTROLS
MainTab:CreateToggle({
   Name = "Enable Aimbot",
   CurrentValue = false,
   Flag = "AimbotToggle",
   Callback = function(Value)
      aimbotEnabled = Value
      FOVring.Visible = Value
   end
})

MainTab:CreateToggle({
   Name = "Team Check",
   CurrentValue = teamCheck,
   Flag = "TeamCheck",
   Callback = function(Value)
      teamCheck = Value
   end
})

MainTab:CreateToggle({
   Name = "Highlight Target",
   CurrentValue = highlightEnabled,
   Flag = "HighlightToggle",
   Callback = function(Value)
      highlightEnabled = Value
   end
})

MainTab:CreateToggle({
   Name = "Use Toggle Key (E) instead of Hold RMB",
   CurrentValue = ToggleMode,
   Flag = "ToggleMode",
   Callback = function(Value)
      ToggleMode = Value
   end
})

MainTab:CreateSlider({
   Name = "Smoothness",
   Range = {0.01, 0.2},
   Increment = 0.01,
   CurrentValue = smoothing,
   Flag = "SmoothSlider",
   Callback = function(Value)
      smoothing = Value
   end
})

MainTab:CreateSlider({
   Name = "FOV",
   Range = {10, 300},
   Increment = 5,
   CurrentValue = fov,
   Flag = "FOVSlider",
   Callback = function(Value)
      fov = Value
   end
})

-- ESP TAB
local EspTab = Window:CreateTab("Esp 👁", nil)
local EspSection = EspTab:CreateSection("Esp👀")

-- Default ESP values
_G.ESPColor = Color3.fromRGB(0, 255, 0)
_G.ESPBoxesEnabled = true
_G.ESPHealthEnabled = true
local ESP = {Enabled = true, MaxDistance = 5000}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local ESPObjects = {}

-- Create ESP function
local function CreateESPForPlayer(player)
    if player == LocalPlayer then return end
    local espObject = {}
    espObject.Box = Drawing.new("Square")
    espObject.Box.Visible = false
    espObject.Box.Thickness = 2
    espObject.Box.Filled = false

    espObject.Text = Drawing.new("Text")
    espObject.Text.Visible = false
    espObject.Text.Size = 14
    espObject.Text.Center = true
    espObject.Text.Outline = true

    espObject.HealthBG = Drawing.new("Square")
    espObject.HealthBG.Visible = false
    espObject.HealthBG.Filled = true
    espObject.HealthBG.Color = Color3.fromRGB(100,100,100)
    espObject.HealthBG.Transparency = 0.7

    espObject.HealthBar = Drawing.new("Square")
    espObject.HealthBar.Visible = false
    espObject.HealthBar.Filled = true
    espObject.HealthBar.Transparency = 0.7

    ESPObjects[player] = espObject

    player.AncestryChanged:Connect(function()
        if not player:IsDescendantOf(game) then
            for _, object in pairs(espObject) do object:Remove() end
            ESPObjects[player] = nil
        end
    end)
end

for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then CreateESPForPlayer(player) end
end
Players.PlayerAdded:Connect(CreateESPForPlayer)

local function GetHealthColor(health,maxHealth)
    local pct = health/maxHealth
    local r = math.clamp(2*(1-pct),0,1)
    local g = math.clamp(2*pct,0,1)
    return Color3.new(r,g,0)
end

RunService.RenderStepped:Connect(function()
    if not ESP.Enabled then
        for _, espObject in pairs(ESPObjects) do
            for _, drawing in pairs(espObject) do drawing.Visible = false end
        end
        return
    end

    for player, espObject in pairs(ESPObjects) do
        local character = player.Character
        if not character or not character:FindFirstChild("HumanoidRootPart") or not character:FindFirstChild("Humanoid") then
            for _, drawing in pairs(espObject) do drawing.Visible = false end
            continue
        end

        local hrp = character.HumanoidRootPart
        local humanoid = character.Humanoid
        local health,maxHealth = humanoid.Health,humanoid.MaxHealth

        local vector,onScreen = Camera:WorldToViewportPoint(hrp.Position)
        local distance = (hrp.Position-Camera.CFrame.Position).Magnitude

        if onScreen and distance<=ESP.MaxDistance then
            local top = hrp.Position+Vector3.new(0,3,0)
            local bottom = hrp.Position-Vector3.new(0,3,0)
            local topVector = Camera:WorldToViewportPoint(top)
            local bottomVector = Camera:WorldToViewportPoint(bottom)
            local height = math.abs(topVector.Y-bottomVector.Y)
            local width = height*0.6
            local boxPosition = Vector2.new(vector.X-width/2, vector.Y-height/2)
            local boxSize = Vector2.new(width,height)

            espObject.Box.Position = boxPosition
            espObject.Box.Size = boxSize
            espObject.Box.Color = _G.ESPColor
            espObject.Box.Visible = _G.ESPBoxesEnabled

            espObject.Text.Position = Vector2.new(vector.X,boxPosition.Y-20)
            espObject.Text.Text = string.format("%s [%.0f%%]",player.Name,(health/maxHealth)*100)
            espObject.Text.Color = _G.ESPColor
            espObject.Text.Visible = _G.ESPBoxesEnabled

            espObject.HealthBG.Position = Vector2.new(vector.X-50/2,boxPosition.Y-10)
            espObject.HealthBG.Size = Vector2.new(50,5)
            espObject.HealthBG.Visible = _G.ESPHealthEnabled

            espObject.HealthBar.Position = Vector2.new(vector.X-50/2,boxPosition.Y-10)
            espObject.HealthBar.Size = Vector2.new(50*(health/maxHealth),5)
            espObject.HealthBar.Color = GetHealthColor(health,maxHealth)
            espObject.HealthBar.Visible = _G.ESPHealthEnabled
        else
            for _, drawing in pairs(espObject) do drawing.Visible = false end
        end
    end
end)

-- ESP Toggles and Color Picker
EspTab:CreateToggle({
    Name = "Enable ESP Boxes",
    CurrentValue = true,
    Flag = "ESPBoxesToggle",
    Callback = function(Value) _G.ESPBoxesEnabled = Value end
})

EspTab:CreateToggle({
    Name = "Show Health Bars",
    CurrentValue = true,
    Flag = "ESPHealthToggle",
    Callback = function(Value) _G.ESPHealthEnabled = Value end
})

EspTab:CreateColorPicker({
    Name = "ESP Color",
    Color = _G.ESPColor,
    Flag = "ESPColorPicker",
    Callback = function(Value) _G.ESPColor = Value end
})

-- ESP Keybind
local ESPKeybind = Enum.KeyCode.RightShift
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == ESPKeybind then
        ESP.Enabled = not ESP.Enabled
        _G.ESPBoxesEnabled = ESP.Enabled
        _G.ESPHealthEnabled = ESP.Enabled

        for _, espObject in pairs(ESPObjects) do
            if espObject.Box then espObject.Box.Visible = ESP.Enabled end
            if espObject.HealthBar then espObject.HealthBar.Visible = ESP.Enabled end
            if espObject.HealthBG then espObject.HealthBG.Visible = ESP.Enabled end
            if espObject.Text then espObject.Text.Visible = ESP.Enabled end
        end

        Rayfield:Notify({
            Title = "ESP Toggled",
            Content = ESP.Enabled and "ESP Enabled" or "ESP Disabled",
            Duration = 3
        })
    end
end)

print("ESP Script loaded! Press Right Shift to toggle ESP.")

local EspDivider = EspTab:CreateDivider()

-- TRIGGERBOT TAB
local TriggerTab = Window:CreateTab("TriggerBot 🔫", nil)
local TriggerSection = TriggerTab:CreateSection("TriggerBot Settings")

-- Default triggerbot values
_G.TriggerBotEnabled = false
_G.TriggerBotDelay = 0.1 -- default delay in seconds

-- Toggle TriggerBot
TriggerTab:CreateToggle({
    Name = "Enable TriggerBot",
    CurrentValue = false,
    Flag = "TriggerBotToggle",
    Callback = function(Value)
        _G.TriggerBotEnabled = Value
        if Value then
            spawn(function()
                while _G.TriggerBotEnabled do
                    local Mouse = game.Players.LocalPlayer:GetMouse()
                    if Mouse.Target then
                        local targetPlayer = game:GetService("Players"):GetPlayerFromCharacter(Mouse.Target.Parent)
                        if targetPlayer and targetPlayer ~= game.Players.LocalPlayer then
                            -- Fire the click
                            game:GetService("VirtualUser"):CaptureController()
                            game:GetService("VirtualUser"):ClickButton1(Vector2.new())
                        end
                    end
                    task.wait(_G.TriggerBotDelay)
                end
            end)
        end
    end
})

-- TriggerBot Delay Slider
TriggerTab:CreateSlider({
    Name = "TriggerBot Delay",
    Range = {0.01, 1}, -- minimum 0.01s, maximum 1s
    Increment = 0.01,
    Suffix = "s",
    CurrentValue = _G.TriggerBotDelay,
    Flag = "TriggerBotDelay",
    Callback = function(Value)
        _G.TriggerBotDelay = Value
    end
})

--- Create Misc Tab
-- MISC TAB
local MiscTab = Window:CreateTab("Misc", nil)
local MiscSection = MiscTab:CreateSection("Miscellaneous Features")

-- Auto Jump Toggle
local autoJumpEnabled = false
MiscTab:CreateToggle({
    Name = "Auto Jump",
    CurrentValue = false,
    Flag = "AutoJumpToggle",
    Callback = function(Value)
        autoJumpEnabled = Value
        spawn(function()
            while autoJumpEnabled do
                local character = game.Players.LocalPlayer.Character
                local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
                task.wait(0.5)
            end
        end)
    end
})

-- WalkSpeed Slider
local walkSpeed = 16
MiscTab:CreateSlider({
    Name = "WalkSpeed",
    Range = {16, 250},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        walkSpeed = Value
        local character = game.Players.LocalPlayer.Character
        if character and character:FindFirstChildOfClass("Humanoid") then
            character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
        end
    end
})

-- Teleport Button Example
MiscTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local spawnLocation = workspace:FindFirstChild("SpawnLocation")
        if spawnLocation then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = spawnLocation.CFrame
            Rayfield:Notify({
                Title = "Teleport",
                Content = "Teleported to spawn!",
                Duration = 3
            })
        end
    end
})

-- Notification Button Example
MiscTab:CreateButton({
    Name = "Show Notification",
    Callback = function()
        Rayfield:Notify({
            Title = "Misc Tab",
            Content = "This is a notification from the Misc Tab!",
            Duration = 4
        })
    end
})

-- Divider (optional, just for UI separation)
local MiscSection = MiscTab:CreateSection("FE TOGGLES👀")
local MiscDivider = MiscTab:CreateDivider()

-- Toggle button
local MiscToggle = MiscTab:CreateToggle({
   Name = "Animation changer🚶‍♂",
   CurrentValue = false,
   Flag = "Toggle1", -- Make sure this flag is unique
   Callback = function(Value)
      if Value then
         -- Fixed loadstring link (make sure this is a valid raw link!)
	loadstring(game:HttpGet('https://raw.githubusercontent.com/RubyBoo4life/Scripts/main/animations.vis'))()
      end
   end,
})

