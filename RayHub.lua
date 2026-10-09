-- RayHub GUI Demo
-- Created by Rayy20-creator

local RayHub = {}

function RayHub.CreateMenu()
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer

    local gui = Instance.new("ScreenGui")
    gui.Name = "RayHubGUI"
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 250, 0, 160)
    frame.Position = UDim2.new(0.5, -125, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 0, 40)
    title.BackgroundTransparency = 1
    title.Text = "RAYHUB"
    title.TextColor3 = Color3.new(1, 1, 1)
    title.Parent = frame

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 40, 0, 35)
    close.Position = UDim2.new(1, -40, 0, 0)
    close.Text = "X"
    close.Parent = frame

    close.Activated:Connect(function()
        gui:Destroy()
    end)

    gui.Parent = player:WaitForChild("PlayerGui")
end

RayHub.CreateMenu()

return RayHub
