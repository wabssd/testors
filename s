local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Bildirim
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "INFINITY FLY",
    Text = "Fly aktif! X tuşu ile aç/kapa",
    Duration = 3
})

-- INFINITY YIELD TARZI FLY SISTEMI
local flying = false
local flySpeed = 2
local flyPos = Vector3.new(0, 0, 0)
local flyDebounce = false

-- Fly fonksiyonu
local function fly()
    if flying then return end
    
    flying = true
    flyDebounce = true
    
    local bodyVelocity = Instance.new("BodyVelocity")
    local bodyGyro = Instance.new("BodyGyro")
    
    bodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
    bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
    
    bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
    bodyGyro.CFrame = rootPart.CFrame
    
    bodyVelocity.Parent = rootPart
    bodyGyro.Parent = rootPart
    
    humanoid.PlatformStand = true
    
    -- Fly loop (Infinity Yield tarzı)
    local flyConnection
    flyConnection = RunService.Heartbeat:Connect(function()
        if not flying or not bodyVelocity or not bodyGyro or not rootPart then
            if flyConnection then
                flyConnection:Disconnect()
            end
            return
        end
        
        -- Kamera yönü
        local cam = workspace.CurrentCamera
        bodyGyro.CFrame = cam.CFrame
        
        -- Hareket vektörü
        local moveVector = Vector3.new(0, 0, 0)
        
        -- Klavye kontrolleri
        if UserInputService:IsKeyDown(Enum.Key.W) then
            moveVector = moveVector + Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
        end
        if UserInputService:IsKeyDown(Enum.Key.S) then
            moveVector = moveVector - Vector3.new(cam.CFrame.LookVector.X, 0, cam.CFrame.LookVector.Z)
        end
        if UserInputService:IsKeyDown(Enum.Key.A) then
            moveVector = moveVector - Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
        end
        if UserInputService:IsKeyDown(Enum.Key.D) then
            moveVector = moveVector + Vector3.new(cam.CFrame.RightVector.X, 0, cam.CFrame.RightVector.Z)
        end
        if UserInputService:IsKeyDown(Enum.Key.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.Key.LeftControl) or UserInputService:IsKeyDown(Enum.Key.LeftShift) then
            moveVector = moveVector + Vector3.new(0, -1, 0)
        end
        
        -- Hızı uygula
        if moveVector.Magnitude > 0 then
            bodyVelocity.Velocity = moveVector.Unit * (flySpeed * 50)
        else
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        end
    end)
    
    wait(0.2)
    flyDebounce = false
end

-- Fly durdurma
local function unfly()
    if not flying then return end
    if flyDebounce then return end
    
    flying = false
    
    -- Temizlik
    for _, v in pairs(rootPart:GetChildren()) do
        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
            v:Destroy()
        end
    end
    
    humanoid.PlatformStand = false
    humanoid:ChangeState(Enum.HumanoidStateType.Landed)
end

-- X tuşu ile aç/kapa
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.Key.X then
        if flying then
            unfly()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "FLY KAPATILDI",
                Text = "Infinity Fly devre dışı",
                Duration = 2
            })
        else
            fly()
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "FLY AKTIF",
                Text = "Infinity Fly aktif!",
                Duration = 2
            })
        end
    end
end)

-- Hız kontrolü için F tuşları
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.Key.F then
        flySpeed = math.min(flySpeed + 0.5, 5)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FLY HIZI",
            Text = "Hız: " .. tostring(flySpeed),
            Duration = 1
        })
    elseif input.KeyCode == Enum.Key.G then
        flySpeed = math.max(flySpeed - 0.5, 0.5)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "FLY HIZI",
            Text = "Hız: " .. tostring(flySpeed),
            Duration = 1
        })
    end
end)

-- Karakter değişince
player.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    
    if flying then
        unfly()
        wait(1)
        fly()
    end
end)

print("Infinity Fly yüklendi!")
print("X tuşu - Fly aç/kapa")
print("F tuşu - Hızı arttır")
print("G tuşu - Hızı azalt")
print("WASD - Hareket")
print("Space - Yukarı")
print("Ctrl/Shift - Aşağı")
