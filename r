-- Kendi Hile Menüm
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- GUI Oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0, 10, 0, 10)
mainFrame.BackgroundColor3 = Color3.new(0.1, 0.1, 0.1)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.2, 0.2, 0.6)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "🔥 HİLE MENÜSÜ 🔥"
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

-- Hız Ayarı
local speedBox = Instance.new("TextBox")
speedBox.Size = UDim2.new(0.6, 0, 0, 30)
speedBox.Position = UDim2.new(0.05, 0, 0, 50)
speedBox.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
speedBox.TextColor3 = Color3.new(1, 1, 1)
speedBox.Text = "16"
speedBox.PlaceholderText = "Hız değeri"
speedBox.Parent = mainFrame

local speedButton = Instance.new("TextButton")
speedButton.Size = UDim2.new(0.3, 0, 0, 30)
speedButton.Position = UDim2.new(0.67, 0, 0, 50)
speedButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
speedButton.TextColor3 = Color3.new(1, 1, 1)
speedButton.Text = "Hız Ayarla"
speedButton.Parent = mainFrame

-- Fly Butonu
local flyButton = Instance.new("TextButton")
flyButton.Size = UDim2.new(0.9, 0, 0, 40)
flyButton.Position = UDim2.new(0.05, 0, 0, 100)
flyButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0)
flyButton.TextColor3 = Color3.new(1, 1, 1)
flyButton.Text = "🚀 FLY: KAPALI"
flyButton.Parent = mainFrame

-- Noclip Butonu
local noclipButton = Instance.new("TextButton")
noclipButton.Size = UDim2.new(0.9, 0, 0, 40)
noclipButton.Position = UDim2.new(0.05, 0, 0, 150)
noclipButton.BackgroundColor3 = Color3.new(0.6, 0, 0)
noclipButton.TextColor3 = Color3.new(1, 1, 1)
noclipButton.Text = "👻 NOCLIP: KAPALI"
noclipButton.Parent = mainFrame

-- God Mode Butonu
local godButton = Instance.new("TextButton")
godButton.Size = UDim2.new(0.9, 0, 0, 40)
godButton.Position = UDim2.new(0.05, 0, 0, 200)
godButton.BackgroundColor3 = Color3.new(0, 0.4, 0)
godButton.TextColor3 = Color3.new(1, 1, 1)
godButton.Text = "🛡️ GOD MODE: KAPALI"
godButton.Parent = mainFrame

-- ESP Butonu
local espButton = Instance.new("TextButton")
espButton.Size = UDim2.new(0.9, 0, 0, 40)
espButton.Position = UDim2.new(0.05, 0, 0, 250)
espButton.BackgroundColor3 = Color3.new(0.4, 0, 0.4)
espButton.TextColor3 = Color3.new(1, 1, 1)
espButton.Text = "🎯 ESP: KAPALI"
espButton.Parent = mainFrame

-- Kapat Butonu
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0.9, 0, 0, 40)
closeButton.Position = UDim2.new(0.05, 0, 0, 320)
closeButton.BackgroundColor3 = Color3.new(0.4, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "❌ MENÜYÜ KAPAT"
closeButton.Parent = mainFrame

-- Değişkenler
local flying = false
local noclip = false
local godmode = false
local esp = false
local bodyVelocity

-- Hız Ayarla
speedButton.MouseButton1Click:Connect(function()
    local speed = tonumber(speedBox.Text)
    if speed and speed > 0 then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    end
end)

-- Fly Fonksiyonu
flyButton.MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        flyButton.BackgroundColor3 = Color3.new(0, 0.8, 0)
        flyButton.Text = "🚀 FLY: AÇIK"
        
        local character = game.Players.LocalPlayer.Character
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(0, 0, 0)
        
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                bodyVelocity.Parent = root
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
            end
        end
    else
        flyButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0)
        flyButton.Text = "🚀 FLY: KAPALI"
        
        if bodyVelocity then
            bodyVelocity:Destroy()
        end
    end
end)

-- Noclip Fonksiyonu
noclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    
    if noclip then
        noclipButton.BackgroundColor3 = Color3.new(0, 0.6, 0)
        noclipButton.Text = "👻 NOCLIP: AÇIK"
    else
        noclipButton.BackgroundColor3 = Color3.new(0.6, 0, 0)
        noclipButton.Text = "👻 NOCLIP: KAPALI"
    end
end)

-- God Mode Fonksiyonu
godButton.MouseButton1Click:Connect(function()
    godmode = not godmode
    
    if godmode then
        godButton.BackgroundColor3 = Color3.new(0, 0.8, 0)
        godButton.Text = "🛡️ GOD MODE: AÇIK"
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        game.Players.LocalPlayer.Character.Humanoid.Health = math.huge
    else
        godButton.BackgroundColor3 = Color3.new(0, 0.4, 0)
        godButton.Text = "🛡️ GOD MODE: KAPALI"
        game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100
        game.Players.LocalPlayer.Character.Humanoid.Health = 100
    end
end)

-- ESP Fonksiyonu
espButton.MouseButton1Click:Connect(function()
    esp = not esp
    
    if esp then
        espButton.BackgroundColor3 = Color3.new(0.8, 0, 0.8)
        espButton.Text = "🎯 ESP: AÇIK"
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player ~= game.Players.LocalPlayer then
                local highlight = Instance.new("Highlight")
                highlight.Parent = player.Character
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 0)
            end
        end
    else
        espButton.BackgroundColor3 = Color3.new(0.4, 0, 0.4)
        espButton.Text = "🎯 ESP: KAPALI"
        
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character then
                local highlight = player.Character:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Menüyü Kapat
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Fly Kontrolleri
game:GetService("RunService").Heartbeat:Connect(function()
    if flying and bodyVelocity then
        local character = game.Players.LocalPlayer.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                local direction = Vector3.new(0, 0, 0)
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then
                    direction = direction + root.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.S) then
                    direction = direction - root.CFrame.LookVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.A) then
                    direction = direction - root.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.D) then
                    direction = direction + root.CFrame.RightVector
                end
                if UIS:IsKeyDown(Enum.KeyCode.Space) then
                    direction = direction + Vector3.new(0, 1, 0)
                end
                if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                    direction = direction + Vector3.new(0, -1, 0)
                end
                
                bodyVelocity.Velocity = direction * 50
            end
        end
    end
    
    -- Noclip
    if noclip then
        local character = game.Players.LocalPlayer.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

print("✅ Hile menüsü yüklendi! Ekranda menüyü görebilirsin.")
