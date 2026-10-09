-- RayHub GUI Demo
-- Created by Rayy20-creator

local RayHub = {}

function RayHub.CreateMenu()
    local gui = Instance.new("ScreenGui")
    gui.Name = "RayHubGUI"

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 250, 0, 160)
    frame.Position = UDim2.new(0.5, -125, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    frame.Parent = gui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Text = "RAYHUB"
    title.Parent = frame

    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0, 50, 0, 30)
    close.Position = UDim2.new(1, -50, 0, 0)
    close.Text = "X"
    close.Parent = frame

    close.Activated:Connect(function()
        gui:Destroy()
    end)

    gui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
end

return RayHub
