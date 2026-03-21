-- ==========================================
--        CB:RO BY BRATYXA (REPAIR V5)
-- ==========================================

local LPlayer = game.Players.LocalPlayer
local Mouse = LPlayer:GetMouse()
local Camera = game.Workspace.CurrentCamera
local UIS = game:GetService("UserInputService")

-- Глобальные переключатели
_G.AimEnabled = false
_G.EspEnabled = false
_G.BhopEnabled = false

-- СОЗДАНИЕ GUI (ЧЕРЕЗ CORE_GUI)
local Screen = Instance.new("ScreenGui")
Screen.Name = "BratyxaMenu"
Screen.Parent = game:GetService("CoreGui")
Screen.DisplayOrder = 999

local Main = Instance.new("Frame", Screen)
Main.Size = UDim2.new(0, 220, 0, 280)
Main.Position = UDim2.new(0.5, -110, 0.4, -140)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderSizePixel = 2
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "CB:RO BRATYXA FIX"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)

-- Функция создания кнопок с фиксом клика
local function AddButton(text, pos, callback)
    local btn = Instance.new("TextButton", Main)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, pos)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18

    btn.MouseButton1Click:Connect(function()
        callback(btn)
        -- Визуальный отклик
        btn.BackgroundColor3 = Color3.fromRGB(100, 30, 30)
        wait(0.1)
        btn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end)
end

-- Кнопки
AddButton("AIMBOT: OFF", 50, function(b)
    _G.AimEnabled = not _G.AimEnabled
    b.Text = _G.AimEnabled and "AIMBOT: ON" or "AIMBOT: OFF"
end)

AddButton("ESP: OFF", 105, function(b)
    _G.EspEnabled = not _G.EspEnabled
    b.Text = _G.EspEnabled and "ESP: ON" or "ESP: OFF"
end)

AddButton("BHOP: OFF", 160, function(b)
    _G.BhopEnabled = not _G.BhopEnabled
    b.Text = _G.BhopEnabled and "BHOP: ON" or "BHOP: OFF"
end)

-- Скрытие на F8
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F8 then Main.Visible = not Main.Visible end
end)

-- ЛОГИКА (RenderStepped)
game:GetService("RunService").RenderStepped:Connect(function()
    -- ESP Logic (Highlight)
    if _G.EspEnabled then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= LPlayer and p.Character and p.Team ~= LPlayer.Team then
                if not p.Character:FindFirstChild("EspHighlight") then
                    local h = Instance.new("Highlight", p.Character)
                    h.Name = "EspHighlight"
                    h.FillColor = Color3.new(1, 0, 0)
                    h.OutlineColor = Color3.new(1, 1, 1)
                    h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                end
            end
        end
    end

    -- BHOP (Velocity Method)
    if _G.BhopEnabled and UIS:IsKeyDown(Enum.KeyCode.Space) then
        if LPlayer.Character and LPlayer.Character:FindFirstChild("Humanoid") then
            if LPlayer.Character.Humanoid.FloorMaterial ~= Enum.Material.Air then
                LPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(LPlayer.Character.HumanoidRootPart.Velocity.X, 35, LPlayer.Character.HumanoidRootPart.Velocity.Z)
            end
        end
    end

    -- AIMBOT (Mouse Fix)
    if _G.AimEnabled and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = nil
        local dist = 200
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= LPlayer and v.Team ~= LPlayer.Team and v.Character and v.Character:FindFirstChild("Head") then
                local pos, vis = Camera:WorldToViewportPoint(v.Character.Head.Position)
                if vis then
                    local mdist = (Vector2.new(pos.X, pos.Y) - UIS:GetMouseLocation()).Magnitude
                    if mdist < dist then
                        dist = mdist
                        target = v
                    end
                end
            end
        end
        if target then
            local p = Camera:WorldToViewportPoint(target.Character.Head.Position)
            local m = UIS:GetMouseLocation()
            if mousemoverel then
                mousemoverel((p.X - m.X)/3, (p.Y - m.Y)/3)
            end
        end
    end
end)
