-- Premium Admin Menu - Key Sistemi ve Modern UI
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Key Sistemi
local correctKey = "PREMIUM2024"
local accessGranted = false

-- Modern UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumAdminMenu"
screenGui.Parent = game.CoreGui

-- Key Giriş Ekranı
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.new(0, 400, 0, 300)
keyFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
keyFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
keyFrame.BorderSizePixel = 0
keyFrame.Parent = screenGui

local keyCorner = Instance.new("UICorner")
keyCorner.CornerRadius = UDim.new(0, 15)
keyCorner.Parent = keyFrame

local keyStroke = Instance.new("UIStroke")
keyStroke.Color = Color3.fromRGB(0, 150, 255)
keyStroke.Thickness = 3
keyStroke.Parent = keyFrame

local keyTitle = Instance.new("TextLabel")
keyTitle.Size = UDim2.new(1, 0, 0, 80)
keyTitle.Position = UDim2.new(0, 0, 0, 0)
keyTitle.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
keyTitle.TextColor3 = Color3.new(1, 1, 1)
keyTitle.Text = "🔐 PREMIUM ADMIN 🔐"
keyTitle.TextSize = 24
keyTitle.Font = Enum.Font.GothamBold
keyTitle.Parent = keyFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 15)
titleCorner.Parent = keyTitle

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1, -40, 0, 40)
keyLabel.Position = UDim2.new(0, 20, 0, 100)
keyLabel.BackgroundTransparency = 1
keyLabel.TextColor3 = Color3.new(1, 1, 1)
keyLabel.Text = "Lütfen Premium Key girin:"
keyLabel.TextSize = 16
keyLabel.Font = Enum.Font.Gotham
keyLabel.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(1, -40, 0, 45)
keyBox.Position = UDim2.new(0, 20, 0, 150)
keyBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
keyBox.TextColor3 = Color3.new(1, 1, 1)
keyBox.PlaceholderText = "Key buraya yazın..."
keyBox.Text = ""
keyBox.TextSize = 18
keyBox.Font = Enum.Font.Gotham
keyBox.Parent = keyFrame

local keyBoxCorner = Instance.new("UICorner")
keyBoxCorner.CornerRadius = UDim.new(0, 8)
keyBoxCorner.Parent = keyBox

local keyButton = Instance.new("TextButton")
keyButton.Size = UDim2.new(1, -40, 0, 45)
keyButton.Position = UDim2.new(0, 20, 0, 210)
keyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
keyButton.TextColor3 = Color3.new(1, 1, 1)
keyButton.Text = "🔓 SİSTEME GİRİŞ YAP"
keyButton.TextSize = 18
keyButton.Font = Enum.Font.GothamBold
keyButton.Parent = keyFrame

local keyButtonCorner = Instance.new("UICorner")
keyButtonCorner.CornerRadius = UDim.new(0, 8)
keyButtonCorner.Parent = keyButton

-- Ana Menü (Başlangıçta gizli)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 0, 0, 0)
mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(0, 200, 255)
mainStroke.Thickness = 2
mainStroke.Parent = mainFrame

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, 0, 0, 70)
mainTitle.Position = UDim2.new(0, 0, 0, 0)
mainTitle.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
mainTitle.TextColor3 = Color3.new(1, 1, 1)
mainTitle.Text = "⚡ PREMIUM ADMIN PANEL ⚡"
mainTitle.TextSize = 20
mainTitle.Font = Enum.Font.GothamBold
mainTitle.Parent = mainFrame

local mainTitleCorner = Instance.new("UICorner")
mainTitleCorner.CornerRadius = UDim.new(0, 15)
mainTitleCorner.Parent = mainTitle

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -70)
contentFrame.Position = UDim2.new(0, 0, 0, 70)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Butonları oluştur
local buttons = {
    {"🚀 Fly Modu", Color3.fromRGB(255, 150, 0), 10},
    {"👻 Noclip Modu", Color3.fromRGB(255, 50, 50), 60},
    {"🛡️ God Mode", Color3.fromRGB(0, 200, 0), 110},
    {"⚡ Hız Ayarla", Color3.fromRGB(0, 150, 255), 160},
    {"🎯 ESP Aç", Color3.fromRGB(200, 0, 200), 210},
    {"🔧 Tool Ver", Color3.fromRGB(150, 150, 0), 260},
    {"👁️ Görünmezlik", Color3.fromRGB(100, 100, 100), 310},
    {"❌ Menüyü Kapat", Color3.fromRGB(200, 0, 0), 360}
}

local createdButtons = {}

for i, buttonData in ipairs(buttons) do
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -20, 0, 45)
    button.Position = UDim2.new(0, 10, 0, buttonData[3])
    button.BackgroundColor3 = buttonData[2]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = buttonData[1]
    button.TextSize = 16
    button.Font = Enum.Font.GothamBold
    button.Parent = contentFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = button
    
    table.insert(createdButtons, button)
end

-- Değişkenler
local flying = false
local noclip = false
local godmode = false
local esp = false
local bodyVelocity

-- Key Kontrolü
keyButton.MouseButton1Click:Connect(function()
    local enteredKey = keyBox.Text
    
    if enteredKey == correctKey then
        accessGranted = true
        
        -- Key giriş animasyonu
        local closeTween = TS:Create(keyFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 0, 0, 0),
            Position = UDim2.new(0.5, 0, 0.5, 0)
        })
        closeTween:Play()
        
        closeTween.Completed:Connect(function()
            keyFrame.Visible = false
            
            -- Ana menü açılış animasyonu
            mainFrame.Visible = true
            local openTween = TS:Create(mainFrame, TweenInfo.new(0.7, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 350, 0, 450),
                Position = UDim2.new(0.5, -175, 0.5, -225)
            })
            openTween:Play()
        end)
        
    else
        -- Yanlış key animasyonu
        keyBox.Text = ""
        keyBox.PlaceholderText = "❌ Yanlış Key! Tekrar dene..."
        
        local shakeTween = TS:Create(keyFrame, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 5, true), {
            Position = UDim2.new(0.5, -210, 0.5, -150)
        })
        shakeTween:Play()
    end
end)

-- Fly Fonksiyonu
createdButtons[1].MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        createdButtons[1].Text = "🚀 Fly Modu: AÇIK"
        createdButtons[1].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        local character = player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Parent = root
                
                local bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(50000, 0, 50000)
                bodyGyro.P = 1000
                bodyGyro.D = 50
                bodyGyro.Parent = root
            end
        end
    else
        createdButtons[1].Text = "🚀 Fly Modu: KAPALI"
        createdButtons[1].BackgroundColor3 = Color3.fromRGB(255, 150, 0)
        
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
    end
end)

-- Noclip Fonksiyonu
createdButtons[2].MouseButton1Click:Connect(function()
    noclip = not noclip
    
    if noclip then
        createdButtons[2].Text = "👻 Noclip: AÇIK"
        createdButtons[2].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        createdButtons[2].Text = "👻 Noclip: KAPALI"
        createdButtons[2].BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    end
end)

-- God Mode Fonksiyonu
createdButtons[3].MouseButton1Click:Connect(function()
    godmode = not godmode
    
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if godmode then
                createdButtons[3].Text = "🛡️ God Mode: AÇIK"
                createdButtons[3].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            else
                createdButtons[3].Text = "🛡️ God Mode: KAPALI"
                createdButtons[3].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
end)

-- Hız Ayarla
createdButtons[4].MouseButton1Click:Connect(function()
    local speed = 50
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
        end
    end
end)

-- ESP Aç
createdButtons[5].MouseButton1Click:Connect(function()
    esp = not esp
    
    if esp then
        createdButtons[5].Text = "🎯 ESP: AÇIK"
        createdButtons[5].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 0)
                highlight.Parent = otherPlayer.Character
            end
        end
    else
        createdButtons[5].Text = "🎯 ESP: KAPALI"
        createdButtons[5].BackgroundColor3 = Color3.fromRGB(200, 0, 200)
        
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer.Character then
                local highlight = otherPlayer.Character:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end
end)

-- Tool Ver
createdButtons[6].MouseButton1Click:Connect(function()
    for i = 1, 5 do
        local tool = Instance.new("Tool")
        tool.Name = "Admin Sword " .. i
        tool.Parent = player.Backpack
    end
end)

-- Görünmezlik
createdButtons[7].MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 1
            end
        end
    end
end)

-- Menüyü Kapat
createdButtons[8].MouseButton1Click:Connect(function()
    local closeTween = TS:Create(mainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    closeTween:Play()
    
    closeTween.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Fly Kontrolleri
RunService.Heartbeat:Connect(function()
    if flying and bodyVelocity then
        local character = player.Character
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
                
                bodyVelocity.Velocity = direction * 100
            end
        end
    end
    
    -- Noclip
    if noclip then
        local character = player.Character
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

print("🎮 Premium Admin Menu yüklendi! Key: PREMIUM2024")
