-- Modern Admin Menu - Drag & Drop + Smooth Fly
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- Modern UI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ModernAdminMenu"
screenGui.Parent = game.CoreGui

-- Ana Menü
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 350, 0, 500)
mainFrame.Position = UDim2.new(0, 50, 0, 50)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui

-- Köşe yuvarlaklığı
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Gölge efekti
local mainShadow = Instance.new("UIStroke")
mainShadow.Color = Color3.fromRGB(0, 150, 255)
mainShadow.Thickness = 2
mainShadow.Parent = mainFrame

-- Başlık (Sürükleme alanı)
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 50)
titleFrame.Position = UDim2.new(0, 0, 0, 0)
titleFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 12)
titleCorner.Parent = titleFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.Position = UDim2.new(0, 0, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Text = "⚡ MODERN ADMIN MENU ⚡"
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = titleFrame

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.Text = "X"
closeButton.TextSize = 16
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = titleFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeButton

-- İçerik alanı
local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, 0, 1, -50)
contentFrame.Position = UDim2.new(0, 0, 0, 50)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

-- Scroll frame
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, 0)
scrollFrame.Position = UDim2.new(0, 0, 0, 0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 6
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 600)
scrollFrame.Parent = contentFrame

-- Butonları oluştur
local buttons = {
    {"🚀 Uçma Modu", Color3.fromRGB(255, 150, 0), "Fly modunu aktif eder (WASD + Space/Shift)", 10},
    {"👻 NoClip Modu", Color3.fromRGB(255, 50, 100), "Duvarlardan geçmeyi sağlar", 70},
    {"🛡️ God Mode", Color3.fromRGB(0, 200, 100), "Ölümsüzlük verir", 130},
    {"⚡ Hız Ayarla", Color3.fromRGB(0, 150, 255), "Yürüme hızını artırır", 190},
    {"🎯 ESP", Color3.fromRGB(200, 0, 200), "Oyuncuları işaretler", 250},
    {"🔧 Tool Ver", Color3.fromRGB(255, 200, 0), "Admin tool'ları verir", 310},
    {"👁️ Görünmezlik", Color3.fromRGB(100, 100, 150), "Karakteri görünmez yapar", 370},
    {"🧹 Temizlik", Color3.fromRGB(150, 150, 150), "Oyunu temizler", 430},
    {"🔒 Anti-Kick", Color3.fromRGB(0, 180, 180), "Atılmayı engeller", 490}
}

local createdButtons = {}
local buttonStates = {}

for i, buttonData in ipairs(buttons) do
    local buttonFrame = Instance.new("Frame")
    buttonFrame.Size = UDim2.new(1, -20, 0, 50)
    buttonFrame.Position = UDim2.new(0, 10, 0, buttonData[4])
    buttonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    buttonFrame.BorderSizePixel = 0
    buttonFrame.Parent = scrollFrame
    
    local buttonCorner = Instance.new("UICorner")
    buttonCorner.CornerRadius = UDim.new(0, 8)
    buttonCorner.Parent = buttonFrame
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 1, 0)
    button.Position = UDim2.new(0, 0, 0, 0)
    button.BackgroundColor3 = buttonData[2]
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = buttonData[1]
    button.TextSize = 14
    button.Font = Enum.Font.GothamBold
    button.Parent = buttonFrame
    
    local buttonCorner2 = Instance.new("UICorner")
    buttonCorner2.CornerRadius = UDim.new(0, 8)
    buttonCorner2.Parent = button
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(1, -10, 0, 15)
    descLabel.Position = UDim2.new(0, 5, 1, -20)
    descLabel.BackgroundTransparency = 1
    descLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    descLabel.Text = buttonData[3]
    descLabel.TextSize = 10
    descLabel.Font = Enum.Font.Gotham
    descLabel.Parent = buttonFrame
    
    table.insert(createdButtons, button)
    buttonStates[button] = false
end

-- Değişkenler
local flying = false
local noclip = false
local godmode = false
local esp = false
local bodyVelocity
local bodyGyro

-- Menü sürükleme
local dragging = false
local dragInput, dragStart, startPos

titleFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

titleFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Kapat butonu
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)

-- Fly Fonksiyonu (Infinity Yield gibi)
createdButtons[1].MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        createdButtons[1].Text = "🚀 Uçma: AÇIK"
        createdButtons[1].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            local root = character:FindFirstChild("HumanoidRootPart")
            
            if humanoid and root then
                -- Fly moduna geç
                humanoid.PlatformStand = true
                
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(40000, 40000, 40000)
                bodyVelocity.Parent = root
                
                bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(50000, 0, 50000)
                bodyGyro.P = 1000
                bodyGyro.D = 50
                bodyGyro.CFrame = root.CFrame
                bodyGyro.Parent = root
            end
        end
    else
        createdButtons[1].Text = "🚀 Uçma Modu"
        createdButtons[1].BackgroundColor3 = Color3.fromRGB(255, 150, 0)
        
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.PlatformStand = false
            end
        end
        
        if bodyVelocity then
            bodyVelocity:Destroy()
            bodyVelocity = nil
        end
        if bodyGyro then
            bodyGyro:Destroy()
            bodyGyro = nil
        end
    end
end)

-- Noclip Fonksiyonu
createdButtons[2].MouseButton1Click:Connect(function()
    noclip = not noclip
    
    if noclip then
        createdButtons[2].Text = "👻 NoClip: AÇIK"
        createdButtons[2].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        createdButtons[2].Text = "👻 NoClip Modu"
        createdButtons[2].BackgroundColor3 = Color3.fromRGB(255, 50, 100)
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
                createdButtons[3].Text = "🛡️ God: AÇIK"
                createdButtons[3].BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            else
                createdButtons[3].Text = "🛡️ God Mode"
                createdButtons[3].BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
end)

-- Hız Ayarla
createdButtons[4].MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 50
        end
    end
end)

-- ESP
createdButtons[5].MouseButton1Click:Connect(function()
    esp = not esp
    
    if esp then
        createdButtons[5].Text = "🎯 ESP: AÇIK"
        createdButtons[5].BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        
        for _, otherPlayer in pairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.new(1, 0, 0)
                highlight.OutlineColor = Color3.new(1, 1, 0)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = otherPlayer.Character
            end
        end
    else
        createdButtons[5].Text = "🎯 ESP"
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
    for i = 1, 3 do
        local tool = Instance.new("Tool")
        tool.Name = "Admin Tool " .. i
        tool.Parent = player.Backpack
    end
end)

-- Görünmezlik
createdButtons[7].MouseButton1Click:Connect(function()
    local character = player.Character
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.8
            end
        end
    end
end)

-- Fly Kontrolleri (Infinity Yield gibi smooth)
RunService.Heartbeat:Connect(function()
    -- Fly kontrolü
    if flying and bodyVelocity and bodyGyro then
        local character = player.Character
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                -- Yön kontrolü
                bodyGyro.CFrame = CFrame.new(root.Position, root.Position + root.CFrame.LookVector)
                
                local direction = Vector3.new(0, 0, 0)
                local speed = 100
                
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
                
                if direction.Magnitude > 0 then
                    direction = direction.Unit * speed
                end
                
                bodyVelocity.Velocity = direction
            end
        end
    end
    
    -- Noclip kontrolü
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

print("🎮 Modern Admin Menu yüklendi! Menüyü sürükleyerek taşıyabilirsin.")
