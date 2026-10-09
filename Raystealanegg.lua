local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LuminHubLoader"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 170)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -85)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius =
    UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "LUMIN HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local status = Instance.new("TextLabel")
status.Size = UDim2.new(0.9, 0, 0, 45)
status.Position = UDim2.new(0.05, 0, 0.32, 0)
status.BackgroundTransparency = 1
status.Text = "Siap digunakan"
status.TextColor3 = Color3.fromRGB(200, 200, 200)
status.TextSize = 12
status.TextWrapped = true
status.Parent = mainFrame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0.8, 0, 0, 40)
button.Position = UDim2.new(0.1, 0, 0.68, 0)
button.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
button.TextColor3 = Color3.new(1, 1, 1)
button.Text = "CEK SUMBER"
button.TextSize = 14
button.Font = Enum.Font.GothamBold
button.Parent = mainFrame

Instance.new("UICorner", button).CornerRadius =
    UDim.new(0, 8)

button.Activated:Connect(function()
    status.Text = "Silakan periksa URL sumber script."
    button.Text = "PERLU DIPERIKSA"
end)
