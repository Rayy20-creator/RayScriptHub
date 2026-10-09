local Players = game:GetService("Players")
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
