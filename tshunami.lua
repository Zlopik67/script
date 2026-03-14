local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("ESCAPE TSUNAMI HACK BY BRATYXANONE90BB", "BloodTheme")

-- ГЛАВНЫЙ РАЗДЕЛ
local Main = Window:NewTab("Main")
local Section = Main:NewSection("Ультра Хак")

-- СУПЕР СКОРОСТЬ
Section:NewSlider("MEGA SPEED", "Скорость света", 1000, 16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

-- БЕСМЕРТИЕ
Section:NewToggle("GOD MODE (Бессмертие)", "Тебя не убить", function(state)
    _G.GodMode = state
    while _G.GodMode do
        wait()
        pcall(function()
            game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
                game.Players.LocalPlayer.Character.Humanoid.Health = 100
            end
        end)
    end
end)

-- БРЕЙНРОТ ЛИМИТ
Section:NewButton("Взять 16 брейнротов", "Увеличивает вместимость предметов", function()
    -- Хак на инвентарь (пытаемся обойти лимит веса/количества)
    pcall(function()
        local backpack = game.Players.LocalPlayer:FindFirstChild("Backpack")
        local hum = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
        -- Попытка через кастомные атрибуты игры, если они есть
        hum:SetAttribute("MaxItems", 16)
        hum:SetAttribute("CarryLimit", 16)
        print("Лимит брейнротов изменен на 16!")
    end)
end)

-- ПОЛЕТ
Section:NewToggle("Fly Mode (Полет)", "Летай на Q", function(state)
    _G.Fly = state
    local player = game.Players.LocalPlayer
    local char = player.Character
    local mouse = player:GetMouse()
    
    if _G.Fly then
        local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Name = "BratyxaFly"
        
        task.spawn(function()
            while _G.Fly do
                bv.Velocity = mouse.Hit.lookVector * 100
                wait()
            end
            if char.HumanoidRootPart:FindFirstChild("BratyxaFly") then
                char.HumanoidRootPart.BratyxaFly:Destroy()
            end
        end)
    end
end)

-- НАСТРОЙКИ
local Settings = Window:NewTab("Settings")
local SetSection = Settings:NewSection("Управление")

SetSection:NewKeybind("Меню на INSERT", "Скрыть/Показать", Enum.KeyCode.Insert, function()
    Library:ToggleUI()
end)

print("--- [escape tsunami hack by bratyxanone90bb] ACTIVATED ---")
