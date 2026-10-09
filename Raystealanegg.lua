local Players = game:GetService("Players")
local player = Players.LocalPlayer

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "LuminHubLoader"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 150)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1
title.Text = "LUMIN HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.Parent = mainFrame

local loadButton = Instance.new("TextButton")
loadButton.Size = UDim2.new(0.8, 0, 0, 45)
loadButton.Position = UDim2.new(0.1, 0, 0.5, 0)
loadButton.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
loadButton.TextColor3 = Color3.new(1, 1, 1)
loadButton.Text = "LOAD HUB"
loadButton.TextSize = 14
loadButton.Font = Enum.Font.GothamBold
loadButton.Parent = mainFrame

local buttonCorner = Instance.new("UICorner")
buttonCorner.CornerRadius = UDim.new(0, 8)
buttonCorner.Parent = loadButton

loadButton.MouseButton1Click:Connect(function()
loadButton.Text = "LOADING..."

local success, err = pcall(function()  
    loadstring(game:HttpGet(  
        "https://rawscripts.net/raw/Steal-An-Egg-Raysi[Rayyansisi]-Hub-223771"  
    ))()  
end)  

if success then  
    screenGui:Destroy()  
else  
    loadButton.Text = "FAILED TO LOAD"  
    warn(err)  
end

end)("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local SPEED = 50
local flying = false
local vertical = 0

RunService.RenderStepped:Connect(function()
    if not flying then return end

    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    local root = character:FindFirstChild("HumanoidRootPart")
    local camera = workspace.CurrentCamera

    if not humanoid or not root or not camera then return end

    -- Mengikuti joystick HP dan arah kamera
    local move = humanoid.MoveDirection
    local direction = Vector3.new(move.X, 0, move.Z)

    root.AssemblyLinearVelocity =
        direction * SPEED + Vector3.new(0, vertical * SPEED, 0)
end)

-- Hubungkan tombol GUI milikmu:
-- Fly ON: flying = true
-- Fly OFF: flying = false
-- UP: vertical = 1
-- DOWN: vertical = -1
-- Lepas tombol naik/turun: vertical = 0
