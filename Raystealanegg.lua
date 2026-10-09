local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama
local oldGui = playerGui:FindFirstChild("RayysiHub")
if oldGui then
    oldGui:Destroy()
end

-- GUI utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RayysiHub"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Frame utama
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 190)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -95)
mainFrame.BackgroundColor3 = Color3.fromRGB(135, 206, 250)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

-- Garis pinggir
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(50, 130, 220)
stroke.Thickness = 2
stroke.Parent = mainFrame

-- Judul
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -45, 0, 45)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "RAYYSI HUB"
title.TextColor3 = Color3.fromRGB(20, 65, 110)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = mainFrame

-- Tombol tutup
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -38, 0, 8)
closeButton.BackgroundColor3 = Color3.fromRGB(70, 160, 230)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.TextSize = 14
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = mainFrame

Instance.new("UICorner", closeButton).CornerRadius =
    UDim.new(0, 8)

-- Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.9, 0, 0, 50)
status.Position = UDim2.new(0.05, 0, 0.30, 0)
status.BackgroundTransparency = 1
status.Text = "Selamat datang di RAYYSI HUB!"
status.TextColor3 = Color3.fromRGB(20, 65, 110)
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.TextWrapped = true
status.Parent = mainFrame

-- Tombol cek status
local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 38)
button.Position = UDim2.new(0.1, 0, 0.70, 0)
button.BackgroundColor3 = Color3.fromRGB(70, 160, 230)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "CEK STATUS"
button.TextSize = 14
button.Font = Enum.Font.GothamBold
button.Parent = mainFrame

Instance.new("UICorner", button).CornerRadius =
    UDim.new(0, 8)

-- Fungsi tombol
button.Activated:Connect(function()
    status.Text = "RAYYSI HUB aktif!"
end)

closeButton.Activated:Connect(function()
    screenGui:Destroy()
end)

-- Geser GUI dengan mouse atau sentuhan
local dragging = false
local dragStart
local startPosition

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = mainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        mainFrame.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)
