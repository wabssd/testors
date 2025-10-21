-- Modern Hile Menüsü (LocalScript - StarterPlayerScripts)
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

-- Değişkenler
local noclip = false
local flying = false
local godmode = false
local speed = 16
local flySpeed = 50
local bodyVelocity
local bodyGyro
local character = player.Character or player.CharacterAdded:Wait()

-- GUI'yi oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ModernHileMenu"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Aç/Kapat Butonu (Her zaman görünür)
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0, 20)
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Text = "☰"
ToggleButton.TextSize = 24
ToggleButton.ZIndex = 10
ToggleButton.Parent = ScreenGui

-- Köşe yuvarlaklığı
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = ToggleButton

-- Ana Menü
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 300, 0, 0) -- Başlangıçta kapalı
MainFrame.Position = UDim2.new(0, 90, 0, 20)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.ZIndex = 5
MainFrame.Parent = ScreenGui

-- Menü köşe yuvarlaklığı
local MenuCorner = Instance.new("UICorner")
MenuCorner.CornerRadius = UDim.new(0, 12)
MenuCorner.Parent = MainFrame

-- Menü çerçevesi
local MenuStroke = Instance.new("UIStroke")
MenuStroke.Color = Color3.fromRGB(80, 80, 80)
MenuStroke.Thickness = 2
MenuStroke.Parent = MainFrame

-- Başlık
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Text = "⚡ HİLE MENÜSÜ ⚡"
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.ZIndex = 6
Title.Parent = MainFrame

-- Başlık köşe yuvarlaklığı
local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- İçerik alanı
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -50)
ContentFrame.Position = UDim2.new(0, 0, 0, 50)
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 6
ContentFrame.Parent = MainFrame

-- Hız Ayarı
local SpeedFrame = Instance.new("Frame")
SpeedFrame.Size = UDim2.new(0.9, 0, 0, 70)
SpeedFrame.Position = UDim2.new(0.05, 0, 0, 10)
SpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SpeedFrame.BorderSizePixel = 0
SpeedFrame.ZIndex = 7
SpeedFrame.Parent = ContentFrame

local SpeedCorner = Instance.new("UICorner")
SpeedCorner.CornerRadius = UDim.new(0, 8)
SpeedCorner.Parent = SpeedFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(1, 0, 0, 30)
SpeedLabel.Position = UDim2.new(0, 0, 0, 0)
SpeedLabel.BackgroundTransparency = 1
SpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedLabel.Text = "🎯 OYUNCU HIZI"
SpeedLabel.TextSize = 14
SpeedLabel.Font = Enum.Font.GothamBold
SpeedLabel.ZIndex = 8
SpeedLabel.Parent = SpeedFrame

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.5, 0, 0, 30)
SpeedBox.Position = UDim2.new(0.05, 0, 0, 35)
SpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBox.Text = "16"
SpeedBox.PlaceholderText = "Hız"
SpeedBox.TextSize = 14
SpeedBox.ZIndex = 8
SpeedBox.Parent = SpeedFrame

local SpeedBoxCorner = Instance.new("UICorner")
SpeedBoxCorner.CornerRadius = UDim.new(0, 6)
SpeedBoxCorner.Parent = SpeedBox

local SpeedButton = Instance.new("TextButton")
SpeedButton.Size = UDim2.new(0.35, 0, 0, 30)
SpeedButton.Position = UDim2.new(0.6, 0, 0, 35)
SpeedButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedButton.Text = "Uygula"
SpeedButton.TextSize = 14
SpeedButton.ZIndex = 8
SpeedButton.Parent = SpeedFrame

local SpeedButtonCorner = Instance.new("UICorner")
SpeedButtonCorner.CornerRadius = UDim.new(0, 6)
SpeedButtonCorner.Parent = SpeedButton

-- Uçma Hızı
local FlySpeedFrame = Instance.new("Frame")
FlySpeedFrame.Size = UDim2.new(0.9, 0, 0, 70)
FlySpeedFrame.Position = UDim2.new(0.05, 0, 0, 90)
FlySpeedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
FlySpeedFrame.BorderSizePixel = 0
FlySpeedFrame.ZIndex = 7
FlySpeedFrame.Parent = ContentFrame

local FlySpeedCorner = Instance.new("UICorner")
FlySpeedCorner.CornerRadius = UDim.new(0, 8)
FlySpeedCorner.Parent = FlySpeedFrame

local FlySpeedLabel = Instance.new("TextLabel")
FlySpeedLabel.Size = UDim2.new(1, 0, 0, 30)
FlySpeedLabel.Position = UDim2.new(0, 0, 0, 0)
FlySpeedLabel.BackgroundTransparency = 1
FlySpeedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedLabel.Text = "🚀 UÇMA HIZI"
FlySpeedLabel.TextSize = 14
FlySpeedLabel.Font = Enum.Font.GothamBold
FlySpeedLabel.ZIndex = 8
FlySpeedLabel.Parent = FlySpeedFrame

local FlySpeedBox = Instance.new("TextBox")
FlySpeedBox.Size = UDim2.new(0.5, 0, 0, 30)
FlySpeedBox.Position = UDim2.new(0.05, 0, 0, 35)
FlySpeedBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
FlySpeedBox.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedBox.Text = "50"
FlySpeedBox.PlaceholderText = "Uçuş hızı"
FlySpeedBox.TextSize = 14
FlySpeedBox.ZIndex = 8
FlySpeedBox.Parent = FlySpeedFrame

local FlySpeedBoxCorner = Instance.new("UICorner")
FlySpeedBoxCorner.CornerRadius = UDim.new(0, 6)
FlySpeedBoxCorner.Parent = FlySpeedBox

local FlySpeedButton = Instance.new("TextButton")
FlySpeedButton.Size = UDim2.new(0.35, 0, 0, 30)
FlySpeedButton.Position = UDim2.new(0.6, 0, 0, 35)
FlySpeedButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
FlySpeedButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlySpeedButton.Text = "Uygula"
FlySpeedButton.TextSize = 14
FlySpeedButton.ZIndex = 8
FlySpeedButton.Parent = FlySpeedFrame

local FlySpeedButtonCorner = Instance.new("UICorner")
FlySpeedButtonCorner.CornerRadius = UDim.new(0, 6)
FlySpeedButtonCorner.Parent = FlySpeedButton

-- Butonlar
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.9, 0, 0, 40)
FlyButton.Position = UDim2.new(0.05, 0, 0, 170)
FlyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyButton.Text = "🚀 UÇMA: KAPALI"
FlyButton.TextSize = 14
FlyButton.ZIndex = 7
FlyButton.Parent = ContentFrame

local FlyButtonCorner = Instance.new("UICorner")
FlyButtonCorner.CornerRadius = UDim.new(0, 8)
FlyButtonCorner.Parent = FlyButton

local NoclipButton = Instance.new("TextButton")
NoclipButton.Size = UDim2.new(0.9, 0, 0, 40)
NoclipButton.Position = UDim2.new(0.05, 0, 0, 220)
NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipButton.Text = "👻 NOCLIP: KAPALI"
NoclipButton.TextSize = 14
NoclipButton.ZIndex = 7
NoclipButton.Parent = ContentFrame

local NoclipButtonCorner = Instance.new("UICorner")
NoclipButtonCorner.CornerRadius = UDim.new(0, 8)
NoclipButtonCorner.Parent = NoclipButton

local GodButton = Instance.new("TextButton")
GodButton.Size = UDim2.new(0.9, 0, 0, 40)
GodButton.Position = UDim2.new(0.05, 0, 0, 270)
GodButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
GodButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GodButton.Text = "🛡️ GOD MODE: KAPALI"
GodButton.TextSize = 14
GodButton.ZIndex = 7
GodButton.Parent = ContentFrame

local GodButtonCorner = Instance.new("UICorner")
GodButtonCorner.CornerRadius = UDim.new(0, 8)
GodButtonCorner.Parent = GodButton

-- Menü Animasyonu
local menuOpen = false

local function toggleMenu()
    menuOpen = not menuOpen
    
    if menuOpen then
        -- Menüyü aç
        local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 350)})
        tween:Play()
        ToggleButton.Text = "✕"
    else
        -- Menüyü kapat
        local tweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        local tween = TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 300, 0, 0)})
        tween:Play()
        ToggleButton.Text = "☰"
    end
end

-- Hız Ayarlama
local function setSpeed(speedValue)
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speedValue
        end
    end
end

SpeedButton.MouseButton1Click:Connect(function()
    local newSpeed = tonumber(SpeedBox.Text)
    if newSpeed and newSpeed > 0 then
        speed = newSpeed
        setSpeed(speed)
    else
        local originalText = SpeedBox.Text
        SpeedBox.Text = "Geçersiz!"
        wait(1)
        SpeedBox.Text = originalText
    end
end)

-- Uçma Hızı Ayarlama
FlySpeedButton.MouseButton1Click:Connect(function()
    local newFlySpeed = tonumber(FlySpeedBox.Text)
    if newFlySpeed and newFlySpeed > 0 then
        flySpeed = newFlySpeed
    else
        local originalText = FlySpeedBox.Text
        FlySpeedBox.Text = "Geçersiz!"
        wait(1)
        FlySpeedBox.Text = originalText
    end
end)

-- Noclip Fonksiyonu
local function noclipLoop()
    if noclip and character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end

NoclipButton.MouseButton1Click:Connect(function()
    noclip = not noclip
    if noclip then
        NoclipButton.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
        NoclipButton.Text = "👻 NOCLIP: AÇIK"
    else
        NoclipButton.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        NoclipButton.Text = "👻 NOCLIP: KAPALI"
        -- Collision'ı geri aç
        if character then
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- God Mode Fonksiyonu
GodButton.MouseButton1Click:Connect(function()
    godmode = not godmode
    
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            if godmode then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                GodButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
                GodButton.Text = "🛡️ GOD MODE: AÇIK"
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                GodButton.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
                GodButton.Text = "🛡️ GOD MODE: KAPALI"
            end
        end
    end
end)

-- Uçma Fonksiyonu
FlyButton.MouseButton1Click:Connect(function()
    flying = not flying
    
    if flying then
        FlyButton.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        FlyButton.Text = "🚀 UÇMA: AÇIK"
        
        -- BodyVelocity ve BodyGyro oluştur
        if character then
            local root = character:FindFirstChild("HumanoidRootPart")
            if root then
                bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 0, 0)
                bodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                bodyVelocity.Parent = root
                
                bodyGyro = Instance.new("BodyGyro")
                bodyGyro.MaxTorque = Vector3.new(50000, 0, 50000)
                bodyGyro.P = 1000
                bodyGyro.D = 50
                bodyGyro.Parent = root
            end
        end
    else
        FlyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        FlyButton.Text = "🚀 UÇMA: KAPALI"
        
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

-- Uçma Kontrolleri
local flyConnection
flyConnection = RunService.Heartbeat:Connect(function()
    -- Uçma kontrolü
    if flying and bodyVelocity and bodyGyro and character then
        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            -- Yön kontrolü
            bodyGyro.CFrame = CFrame.new(root.Position, root.Position + root.CFrame.LookVector)
            
            local direction = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                direction = direction + root.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                direction = direction - root.CFrame.LookVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                direction = direction - root.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                direction = direction + root.CFrame.RightVector
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                direction = direction + Vector3.new(0, 1, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                direction = direction + Vector3.new(0, -1, 0)
            end
            
            -- Yumuşak hareket
            if direction.Magnitude > 0 then
                direction = direction.Unit * flySpeed
            end
            
            bodyVelocity.Velocity = direction
        end
    end
    
    -- Noclip loop
    noclipLoop()
    
    -- God mode koruması
    if godmode and character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health < math.huge then
            humanoid.Health = math.huge
            humanoid.MaxHealth = math.huge
        end
    end
end)

-- Menü toggle
ToggleButton.MouseButton1Click:Connect(toggleMenu)

-- Karakter değişimlerini handle et
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    wait(1)
    
    -- Ayarları yeniden uygula
    setSpeed(speed)
    
    if godmode then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
        end
    end
    
    -- Uçma modunu resetle
    if flying then
        flying = false
        FlyButton.BackgroundColor3 = Color3.fromRGB(200, 100, 0)
        FlyButton.Text = "🚀 UÇMA: KAPALI"
        
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

print("✅ Modern hile menüsü yüklendi! Sol üst köşedeki mavi butona tıkla.")
