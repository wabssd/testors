-- Basit Admin Komutları
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local commandPrefix = ";"

-- Admin Komutları
local adminCommands = {
    kill = function(args)
        local target = getPlayer(args[1])
        if target and target.Character then
            target.Character:BreakJoints()
        end
    end,
    
    kick = function(args)
        local target = getPlayer(args[1])
        if target then
            target:Kick("Admin tarafından atıldın!")
        end
    end,
    
    ban = function(args)
        local target = getPlayer(args[1])
        if target then
            -- Basit ban sistemi
            print(target.Name .. " banlandı!")
        end
    end,
    
    fly = function(args)
        -- Fly kodu buraya
    end,
    
    noclip = function(args)
        -- Noclip kodu
    end,
    
    god = function(args)
        local target = getPlayer(args[1]) or player
        if target.Character then
            target.Character.Humanoid.MaxHealth = math.huge
            target.Character.Humanoid.Health = math.huge
        end
    end,
    
    speed = function(args)
        local target = getPlayer(args[1]) or player
        local speed = tonumber(args[2]) or 50
        if target.Character then
            target.Character.Humanoid.WalkSpeed = speed
        end
    end,
    
    jump = function(args)
        local target = getPlayer(args[1]) or player
        local power = tonumber(args[2]) or 100
        if target.Character then
            target.Character.Humanoid.JumpPower = power
        end
    end,
    
    tp = function(args)
        local target1 = getPlayer(args[1])
        local target2 = getPlayer(args[2])
        if target1 and target2 and target1.Character and target2.Character then
            target1.Character.HumanoidRootPart.CFrame = target2.Character.HumanoidRootPart.CFrame
        end
    end,
    
    bring = function(args)
        local target = getPlayer(args[1])
        if target and target.Character and player.Character then
            target.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
        end
    end,
    
    goto = function(args)
        local target = getPlayer(args[1])
        if target and target.Character and player.Character then
            player.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end,
    
    invis = function(args)
        local target = getPlayer(args[1]) or player
        if target.Character then
            for _, part in pairs(target.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end,
    
    visible = function(args)
        local target = getPlayer(args[1]) or player
        if target.Character then
            for _, part in pairs(target.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
            end
        end
    end,
    
    tools = function(args)
        local target = getPlayer(args[1]) or player
        for i = 1, 10 do
            local tool = Instance.new("Tool")
            tool.Name = "Admin Sword " .. i
            tool.Parent = target.Backpack
        end
    end,
    
    announce = function(args)
        local message = table.concat(args, " ")
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "[ADMIN] " .. message,
            Color = Color3.new(1, 0, 0),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18
        })
    end,
    
    credits = function(args)
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = "DarkAdmin v2.0 - Professional Admin Panel",
            Color = Color3.new(0, 1, 1),
            Font = Enum.Font.SourceSansBold,
            TextSize = 18
        })
    end
}

function getPlayer(name)
    name = name:lower()
    for _, plr in pairs(Players:GetPlayers()) do
        if plr.Name:lower():find(name) or plr.DisplayName:lower():find(name) then
            return plr
        end
    end
    return nil
end

-- Chat Listener
player.Chatted:Connect(function(message)
    if message:sub(1, 1) == commandPrefix then
        local args = {}
        for word in message:gmatch("%S+") do
            table.insert(args, word)
        end
        
        local command = args[1]:sub(2):lower()
        table.remove(args, 1)
        
        if adminCommands[command] then
            adminCommands[command](args)
        else
            warn("Komut bulunamadı: " .. command)
        end
    end
end)

-- GUI Oluştur
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = game.CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BackgroundTransparency = 0.3
frame.Parent = screenGui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundColor3 = Color3.new(0.2, 0, 0)
title.TextColor3 = Color3.new(1, 1, 1)
title.Text = "🛡️ DARK ADMIN v2.0 🛡️"
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.Parent = frame

local cmds = {
    ";kill [oyuncu] - Öldür",
    ";kick [oyuncu] - At",
    ";god [oyuncu] - God mode",
    ";fly - Uçma",
    ";noclip - Duvar geçme",
    ";speed [sayı] - Hız",
    ";tp [oyuncu1] [oyuncu2] - Işınlanma",
    ";bring [oyuncu] - Yanına getir",
    ";goto [oyuncu] - Yanına git",
    ";invis [oyuncu] - Görünmezlik",
    ";tools [oyuncu] - Tool ver",
    ";announce [mesaj] - Duyuru yap"
}

for i, cmd in pairs(cmds) do
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -10, 0, 25)
    label.Position = UDim2.new(0, 5, 0, 40 + (i * 25))
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = cmd
    label.TextSize = 12
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
end

print("🎯 DarkAdmin yüklendi! Komutlar:")
print(";kill, ;kick, ;god, ;fly, ;noclip, ;speed, ;tp, ;bring, ;goto, ;invis, ;tools, ;announce")
