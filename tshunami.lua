-- escape tsunami hack by bratyxanone90bb
local L = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local W = L.CreateLib("ESCAPE TSUNAMI HACK BY BRATYXANONE90BB", "BloodTheme")
local M = W:NewTab("Main"):NewSection("Bratyxa Ultra")
M:NewSlider("MEGA SPEED", "", 1000, 16, function(s) game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s end)
M:NewToggle("GOD MODE", "", function(t) _G.G = t while _G.G do task.wait() pcall(function() game.Players.LocalPlayer.Character.Humanoid.Health = 100 end) end end)
M:NewButton("16 BRAINROTS", "", function() pcall(function() local h = game.Players.LocalPlayer.Character.Humanoid h:SetAttribute("MaxItems", 16) h:SetAttribute("CarryLimit", 16) end) end)
M:NewToggle("Fly Mode", "", function(t) _G.F = t local p = game.Players.LocalPlayer local r = p.Character.HumanoidRootPart if _G.F then local v = Instance.new("BodyVelocity", r) v.MaxForce = Vector3.new(1e9, 1e9, 1e9) v.Name = "BFly" task.spawn(function() while _G.F do v.Velocity = p:GetMouse().Hit.lookVector * 150 task.wait() end if r:FindFirstChild("BFly") then r.BFly:Destroy() end end) end end)
W:NewTab("Settings"):NewSection("Keys"):NewKeybind("Menu Toggle", "", Enum.KeyCode.Insert, function() L:ToggleUI() end)
