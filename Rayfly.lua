local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local flying = false
local noclip = false
local flySpeed = 50
local vertical = 0

local gui = Instance.new("ScreenGui")
gui.Name = "RayFlyNoclip"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 220, 0, 260)
frame.Position = UDim2.new(0.5, -110, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
frame.Active = true
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(80, 60, 180)
title.Text = "RAY | FLY + NOCLIP"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 16
title.Parent = frame

local function button(text, y)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.8, 0, 0, 35)
    b.Position = UDim2.new(0.1, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
    b.TextColor3 = Color3.new(1, 1, 1)
    b.TextSize = 14
    b.Text = text
    b.Parent = frame

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b

    return b
end

local flyBtn = button("FLY: OFF", 50)
local clipBtn = button("NOCLIP: OFF", 90)
local upBtn = button("UP ▲", 130)
local downBtn = button("DOWN ▼", 170)
local closeBtn = button("HIDE GUI", 210)

-- Menggeser GUI menggunakan sentuhan atau mouse
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPos = frame.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart

        frame.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

local function getCharacter()
    local char = player.Character
    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")

    if hum and root then
        return char, hum, root
    end
end

flyBtn.Activated:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "FLY: ON" or "FLY: OFF"
end)

clipBtn.Activated:Connect(function()
    noclip = not noclip
    clipBtn.Text = noclip and "NOCLIP: ON" or "NOCLIP: OFF"
end)

upBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        vertical = 1
    end
end)

downBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        vertical = -1
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        vertical = 0
    end
end)

RunService.Heartbeat:Connect(function()
    local char, hum, root = getCharacter()
    if not char then return end

    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = not noclip
        end
    end

    if flying then
        hum.PlatformStand = true

        local attachment = root:FindFirstChild("RayFlyAttachment")
        if not attachment then
            attachment = Instance.new("Attachment")
            attachment.Name = "RayFlyAttachment"
            attachment.Parent = root
        end

        local velocity = root:FindFirstChild("RayFlyVelocity")
        if not velocity then
            velocity = Instance.new("LinearVelocity")
            velocity.Name = "RayFlyVelocity"
            velocity.Attachment0 = attachment
            velocity.MaxForce = math.huge
            velocity.RelativeTo = Enum.ActuatorRelativeTo.World
            velocity.Parent = root
        end

        local camera = workspace.CurrentCamera
        local direction = Vector3.zero

        if UIS:IsKeyDown(Enum.KeyCode.W) then
            direction = camera.CFrame.LookVector * flySpeed
        end

        velocity.VectorVelocity =
            direction + Vector3.new(0, vertical * flySpeed, 0)
    else
        hum.PlatformStand = false

        local velocity = root:FindFirstChild("RayFlyVelocity")
        if velocity then
            velocity:Destroy()
        end

        local attachment = root:FindFirstChild("RayFlyAttachment")
        if attachment then
            attachment:Destroy()
        end
    end
end)

closeBtn.Activated:Connect(function()
    gui.Enabled = false
end)
