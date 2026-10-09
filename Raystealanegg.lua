-- RAYYSI HUB
-- GUI contoh untuk proyek Roblox milik sendiri
-- Jalankan sebagai LocalScript di Roblox Studio

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hapus GUI lama jika masih ada
local oldGui = playerGui:FindFirstChild("RayysiHub")
if oldGui then
    oldGui:Destroy()
end

-- WARNA
local BLUE = Color3.fromRGB(135, 206, 250)
local DARK_BLUE = Color3.fromRGB(30, 90, 140)
local BUTTON_BLUE = Color3.fromRGB(70, 160, 230)
local WHITE = Color3.fromRGB(255, 255, 255)
local CONTENT_COLOR = Color3.fromRGB(225, 243, 255)

-- SCREEN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "RayysiHub"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.Parent = playerGui

-- FRAME UTAMA
local main = Instance.new("Frame")
main.Name = "MainFrame"
main.Size = UDim2.fromOffset(320, 270)
main.Position = UDim2.new(0.5, -160, 0.5, -135)
main.BackgroundColor3 = BLUE
main.BorderSizePixel = 0
main.Active = true
main.Parent = gui

Instance.new("UICorner", main).CornerRadius =
    UDim.new(0, 12)

local stroke = Instance.new("UIStroke")
stroke.Color = DARK_BLUE
stroke.Thickness = 2
stroke.Parent = main

-- JUDUL
local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -90, 0, 42)
title.Position = UDim2.fromOffset(10, 0)
title.BackgroundTransparency = 1
title.Text = "RAYYSI HUB"
title.TextColor3 = DARK_BLUE
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = main

-- MINIMIZE
local minimize = Instance.new("TextButton")
minimize.Name = "Minimize"
minimize.Size = UDim2.fromOffset(32, 30)
minimize.Position = UDim2.new(1, -72, 0, 6)
minimize.BackgroundColor3 = BUTTON_BLUE
minimize.Text = "-"
minimize.TextColor3 = WHITE
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBold
minimize.Parent = main

Instance.new("UICorner", minimize).CornerRadius =
    UDim.new(0, 6)

-- CLOSE
local close = Instance.new("TextButton")
close.Name = "Close"
close.Size = UDim2.fromOffset(32, 30)
close.Position = UDim2.new(1, -36, 0, 6)
close.BackgroundColor3 = Color3.fromRGB(220, 80, 80)
close.Text = "X"
close.TextColor3 = WHITE
close.TextSize = 14
close.Font = Enum.Font.GothamBold
close.Parent = main

Instance.new("UICorner", close).CornerRadius =
    UDim.new(0, 6)

-- MENU KIRI
local menu = Instance.new("Frame")
menu.Name = "Menu"
menu.Size = UDim2.new(0, 95, 1, -55)
menu.Position = UDim2.fromOffset(8, 48)
menu.BackgroundColor3 = Color3.fromRGB(110, 190, 240)
menu.BorderSizePixel = 0
menu.Parent = main

Instance.new("UICorner", menu).CornerRadius =
    UDim.new(0, 8)

-- AREA KONTEN
local content = Instance.new("Frame")
content.Name = "Content"
content.Size = UDim2.new(1, -115, 1, -55)
content.Position = UDim2.fromOffset(108, 48)
content.BackgroundColor3 = CONTENT_COLOR
content.BorderSizePixel = 0
content.ClipsDescendants = true
content.Parent = main

Instance.new("UICorner", content).CornerRadius =
    UDim.new(0, 8)

-- FUNGSI LABEL
local function makeLabel(text, y, height)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -12, 0, height or 30)
    label.Position = UDim2.fromOffset(6, y)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = DARK_BLUE
    label.TextSize = 12
    label.Font = Enum.Font.Gotham
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

-- FUNGSI TOMBOL KONTEN
local function makeButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -12, 0, 32)
    button.Position = UDim2.fromOffset(6, y)
    button.BackgroundColor3 = BUTTON_BLUE
    button.TextColor3 = WHITE
    button.Text = text
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.Parent = content

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 6)

    button.Activated:Connect(callback)
    return button
end

-- HAPUS KONTEN LAMA
local function clearContent()
    for _, obj in ipairs(content:GetChildren()) do
        obj:Destroy()
    end
end

-- HOME
local function showHome()
    clearContent()
    makeLabel("Selamat datang!", 12, 28)
    makeLabel("RAYYSI HUB siap digunakan.", 45, 40)
    makeLabel("Pilih menu di sebelah kiri.", 90, 35)
end

-- PLAYER
local function showPlayer()
    clearContent()

    local character = player.Character
    local humanoid = character
        and character:FindFirstChildOfClass("Humanoid")

    makeLabel("PLAYER INFO", 8, 25)
    makeLabel("Nama: " .. player.Name, 38, 25)
    makeLabel("User ID: " .. player.UserId, 65, 25)
    makeLabel(
        "Health: " ..
        (humanoid and math.floor(humanoid.Health) or 0),
        92, 25
    )
    makeLabel(
        "WalkSpeed: " ..
        (humanoid and humanoid.WalkSpeed or 0),
        119, 25
    )

    makeButton("REFRESH", 155, showPlayer)
end

-- VISUAL
local function showVisual()
    clearContent()
    makeLabel("PENGATURAN VISUAL", 8, 30)

    makeButton("BIRU MUDA", 45, function()
        main.BackgroundColor3 = BLUE
    end)

    makeButton("BIRU", 83, function()
        main.BackgroundColor3 = BUTTON_BLUE
    end)

    makeButton("PUTIH", 121, function()
        main.BackgroundColor3 =
            Color3.fromRGB(240, 248, 255)
    end)
end

-- TELEPORT LOKAL
local savedPosition = nil

local function showTeleport()
    clearContent()

    makeLabel("TELEPORT", 8, 28)
    makeLabel("Simpan posisi karakter.", 38, 25)
    makeLabel("Lalu kembali ke posisi itu.", 63, 25)

    makeButton("SIMPAN POSISI", 98, function()
        local character = player.Character
        local root = character
            and character:FindFirstChild("HumanoidRootPart")

        if root then
            savedPosition = root.Position
            makeLabel("Posisi tersimpan!", 138, 22)
        else
            makeLabel("Karakter belum siap.", 138, 22)
        end
    end)

    makeButton("KEMBALI KE POSISI", 175, function()
        local character = player.Character
        local root = character
            and character:FindFirstChild("HumanoidRootPart")

        if root and savedPosition then
            root.CFrame =
                CFrame.new(savedPosition + Vector3.new(0, 3, 0))
        end
    end)
end

-- TOMBOL MENU
local function makeMenuButton(text, y, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 38)
    button.Position = UDim2.fromOffset(5, y)
    button.BackgroundColor3 = BUTTON_BLUE
    button.TextColor3 = WHITE
    button.Text = text
    button.TextSize = 11
    button.Font = Enum.Font.GothamBold
    button.Parent = menu

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 6)

    button.Activated:Connect(callback)
end

makeMenuButton("HOME", 8, showHome)
makeMenuButton("PLAYER", 52, showPlayer)
makeMenuButton("VISUAL", 96, showVisual)
makeMenuButton("TELEPORT", 140, showTeleport)

-- MINIMIZE DAN PULIHKAN
local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized

    menu.Visible = not minimized
    content.Visible = not minimized

    main.Size = minimized
        and UDim2.fromOffset(320, 42)
        or UDim2.fromOffset(320, 270)

    minimize.Text = minimized and "+" or "-"
end)

-- TUTUP GUI
close.Activated:Connect(function()
    gui:Destroy()
end)

-- DRAG DENGAN MOUSE ATAU SENTUHAN
local dragging = false
local dragStart = nil
local startPosition = nil
local dragInput = nil

title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart

        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- TAMPILKAN HALAMAN AWAL
showHome()
