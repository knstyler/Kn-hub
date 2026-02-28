-- KN HUB - Corner ESP + Professional UI
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- CONFIGS
local Aimbot = {
    Enabled = false,
    Smooth = 1,
    FOV = 250,
    WallCheck = true,
    TeamCheck = true
}

local ESP = {
    Enabled = false,
    Color = Color3.fromRGB(255, 255, 255),
    CornerSize = 0.25
}

local Theme = {
    Primary = Color3.fromRGB(220, 40, 40), -- Vermelho igual da logo
    Background = Color3.fromRGB(15, 15, 15),
    Surface = Color3.fromRGB(25, 25, 25),
    Text = Color3.new(1, 1, 1)
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KNHub"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Botão flutuante
local FloatButton = Instance.new("TextButton")
FloatButton.Name = "Toggle"
FloatButton.Parent = ScreenGui
FloatButton.Size = UDim2.new(0, 55, 0, 55)
FloatButton.Position = UDim2.new(0, 15, 0, 15)
FloatButton.BackgroundColor3 = Theme.Primary
FloatButton.Text = "KN"
FloatButton.TextColor3 = Theme.Text
FloatButton.Font = Enum.Font.GothamBold
FloatButton.TextSize = 18
Instance.new("UICorner", FloatButton).CornerRadius = UDim.new(0.3, 0)

-- Menu principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "Main"
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 380, 0, 450)
MainFrame.Position = UDim2.new(0.5, -190, 0.5, -225)
MainFrame.BackgroundColor3 = Theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)

-- Sombra
local Shadow = Instance.new("ImageLabel", MainFrame)
Shadow.Name = "Shadow"
Shadow.Size = UDim2.new(1, 60, 1, 60)
Shadow.Position = UDim2.new(0, -30, 0, -30)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://6015897843"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.4

-- Header com logo
local Header = Instance.new("Frame", MainFrame)
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 100)
Header.BackgroundColor3 = Theme.Surface
Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 16)

local HeaderFix = Instance.new("Frame", Header)
HeaderFix.Size = UDim2.new(1, 0, 0.5, 0)
HeaderFix.Position = UDim2.new(0, 0, 0.5, 0)
HeaderFix.BackgroundColor3 = Theme.Surface

-- LOGO IMAGE
local Logo = Instance.new("ImageLabel", Header)
Logo.Name = "Logo"
Logo.Size = UDim2.new(0, 70, 0, 70)
Logo.Position = UDim2.new(0.5, -35, 0.5, -35)
Logo.BackgroundTransparency = 1
Logo.Image = "rbxassetid://1000149325" -- Sua foto KS
Logo.ScaleType = Enum.ScaleType.Fit

-- Botão fechar
local CloseBtn = Instance.new("TextButton", Header)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -35)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Theme.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 22
Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

-- Container
local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, -30, 1, -120)
Container.Position = UDim2.new(0, 15, 0, 110)
Container.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Container.BorderSizePixel = 0
Container.ScrollBarThickness = 6
Container.ScrollBarImageColor3 = Theme.Primary
Container.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 12)

local ListLayout = Instance.new("UIListLayout", Container)
ListLayout.Padding = UDim.new(0, 12)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- FUNÇÕES UI
local function CreateToggle(name, default, callback)
    local Frame = Instance.new("Frame", Container)
    Frame.Size = UDim2.new(1, -20, 0, 55)
    Frame.Position = UDim2.new(0, 10, 0, 0)
    Frame.BackgroundColor3 = Theme.Surface
    Frame.LayoutOrder = #Container:GetChildren()
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Text = name
    Label.Size = UDim2.new(1, -100, 1, 0)
    Label.Position = UDim2.new(0, 18, 0, 0)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Theme.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 15
    Label.TextXAlignment = Enum.TextXAlignment.Left
    
    local Button = Instance.new("TextButton", Frame)
    Button.Size = UDim2.new(0, 65, 0, 32)
    Button.Position = UDim2.new(1, -82, 0.5, -16)
    Button.BackgroundColor3 = default and Theme.Primary or Color3.fromRGB(70, 70, 70)
    Button.Text = default and "ON" or "OFF"
    Button.TextColor3 = Theme.Text
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 13
    Button.AutoButtonColor = false
    Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
    
    local state = default
    Button.MouseButton1Click:Connect(function()
        state = not state
        callback(state)
        Button.Text = state and "ON" or "OFF"
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Theme.Primary or Color3.fromRGB(70, 70, 70)
        }):Play()
    end)
end

local function CreateSlider(name, min, max, default, suffix, callback)
    local Frame = Instance.new("Frame", Container)
    Frame.Size = UDim2.new(1, -20, 0, 75)
    Frame.Position = UDim2.new(0, 10, 0, 0)
    Frame.BackgroundColor3 = Theme.Surface
    Frame.LayoutOrder = #Container:GetChildren()
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 10)
    
    local Label = Instance.new("TextLabel", Frame)
    Label.Text = name
    Label.Size = UDim2.new(1, -100, 0, 28)
    Label.Position = UDim2.new(0, 18, 0, 10)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Theme.Text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 15
    
    local ValueLabel = Instance.new("TextLabel", Frame)
    ValueLabel.Text = tostring(default) .. suffix
    ValueLabel.Size = UDim2.new(0, 70, 0, 28)
    ValueLabel.Position = UDim2.new(1, -85, 0, 10)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.TextColor3 = Theme.Primary
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 15
    
    local Track = Instance.new("Frame", Frame)
    Track.Size = UDim2.new(1, -36, 0, 8)
    Track.Position = UDim2.new(0, 18, 1, -28)
    Track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
    
    local Fill = Instance.new("Frame", Track)
    Fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    Fill.BackgroundColor3 = Theme.Primary
    Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
    
    local Knob = Instance.new("Frame", Track)
    Knob.Size = UDim2.new(0, 20, 0, 20)
    Knob.Position = UDim2.new((default - min) / (max - min), -10, 0.5, -10)
    Knob.BackgroundColor3 = Color3.new(1, 1, 1)
    Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)
    
    local dragging = false
    local function update(input)
        local pos = math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1)
        local val = math.floor(min + (pos * (max - min)))
        Fill.Size = UDim2.new(pos, 0, 1, 0)
        Knob.Position = UDim2.new(pos, -10, 0.5, -10)
        ValueLabel.Text = tostring(val) .. suffix
        callback(val)
    end
    
    Track.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            update(input)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- CRIAR CONTROLES
CreateToggle("Aimbot", false, function(v) Aimbot.Enabled = v end)
CreateToggle("Team Check", true, function(v) Aimbot.TeamCheck = v end)
CreateToggle("Wall Check", true, function(v) Aimbot.WallCheck = v end)
CreateSlider("FOV", 50, 500, 250, "px", function(v) Aimbot.FOV = v end)
CreateSlider("Smooth", 1, 100, 100, "%", function(v) Aimbot.Smooth = v / 100 end)
CreateToggle("ESP", false, function(v) ESP.Enabled = v end)

-- SISTEMA DE MENU
local isOpen = false

local function ToggleMenu()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    FloatButton.Text = isOpen and "✓" or "KN"
    FloatButton.BackgroundColor3 = isOpen and Color3.fromRGB(0, 255, 100) or Theme.Primary
end

FloatButton.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(ToggleMenu)

-- ARRASTAR MENU
local dragging = false
local dragOffset = nil

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragOffset = input.Position - MainFrame.AbsolutePosition
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        MainFrame.Position = UDim2.new(0, input.Position.X - dragOffset.X, 0, input.Position.Y - dragOffset.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- FOV CIRCLE
local FOVCircle = Drawing.new("Circle")
FOVCircle.Transparency = 0.3
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.NumSides = 64
FOVCircle.Color = Theme.Primary

-- ESP CORNER BOX (8 linhas - 2 por canto)
local ESPObjects = {}

function CreateESP(player)
    if player == LocalPlayer then return end
    
    ESPObjects[player] = {
        TopLeft = {Drawing.new("Line"), Drawing.new("Line")},
        TopRight = {Drawing.new("Line"), Drawing.new("Line")},
        BottomLeft = {Drawing.new("Line"), Drawing.new("Line")},
        BottomRight = {Drawing.new("Line"), Drawing.new("Line")}
    }
    
    for cornerName, lines in pairs(ESPObjects[player]) do
        for _, line in ipairs(lines) do
            line.Thickness = 1.5
            line.Color = ESP.Color
            line.Transparency = 1
        end
    end
end

for _, player in ipairs(Players:GetPlayers()) do
    CreateESP(player)
end

Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(player)
    if ESPObjects[player] then
        for cornerName, lines in pairs(ESPObjects[player]) do
            for _, line in ipairs(lines) do
                line:Remove()
            end
        end
        ESPObjects[player] = nil
    end
end)

local function UpdateCornerESP(lines, topLeft, topRight, bottomLeft, bottomRight, size)
    local cornerLength = size * ESP.CornerSize
    
    lines.TopLeft[1].From = topLeft
    lines.TopLeft[1].To = Vector2.new(topLeft.X + cornerLength, topLeft.Y)
    lines.TopLeft[2].From = topLeft
    lines.TopLeft[2].To = Vector2.new(topLeft.X, topLeft.Y + cornerLength)
    
    lines.TopRight[1].From = topRight
    lines.TopRight[1].To = Vector2.new(topRight.X - cornerLength, topRight.Y)
    lines.TopRight[2].From = topRight
    lines.TopRight[2].To = Vector2.new(topRight.X, topRight.Y + cornerLength)
    
    lines.BottomLeft[1].From = bottomLeft
    lines.BottomLeft[1].To = Vector2.new(bottomLeft.X + cornerLength, bottomLeft.Y)
    lines.BottomLeft[2].From = bottomLeft
    lines.BottomLeft[2].To = Vector2.new(bottomLeft.X, bottomLeft.Y - cornerLength)
    
    lines.BottomRight[1].From = bottomRight
    lines.BottomRight[1].To = Vector2.new(bottomRight.X - cornerLength, bottomRight.Y)
    lines.BottomRight[2].From = bottomRight
    lines.BottomRight[2].To = Vector2.new(bottomRight.X, bottomRight.Y - cornerLength)
    
    for cornerName, linePair in pairs(lines) do
        for _, line in ipairs(linePair) do
            line.Visible = true
        end
    end
end

local function HideESP(lines)
    for cornerName, linePair in pairs(lines) do
        for _, line in ipairs(linePair) do
            line.Visible = false
        end
    end
end

local function GetTarget()
    local target = nil
    local closestDistance = math.huge
    local center = Camera.ViewportSize / 2
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            local head = player.Character:FindFirstChild("Head")
            
            if humanoid and humanoid.Health > 0 and head then
                if Aimbot.TeamCheck and player.Team == LocalPlayer.Team then
                    continue
                end
                
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                
                if onScreen then
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - center).Magnitude
                    
                    if distance < Aimbot.FOV and distance < closestDistance then
                        if Aimbot.WallCheck then
                            local rayParams = RaycastParams.new()
                            rayParams.FilterDescendantsInstances = {LocalPlayer.Character}
                            
                            local result = workspace:Raycast(
                                Camera.CFrame.Position,
                                (head.Position - Camera.CFrame.Position) * 1.1,
                                rayParams
                            )
                            
                            if result and not result.Instance:IsDescendantOf(player.Character) then
                                continue
                            end
                        end
                        
                        closestDistance = distance
                        target = player
                    end
                end
            end
        end
    end
    
    return target
end

RunService.RenderStepped:Connect(function()
    local center = Camera.ViewportSize / 2
    FOVCircle.Position = center
    FOVCircle.Radius = Aimbot.FOV
    FOVCircle.Visible = Aimbot.Enabled
    FOVCircle.Color = GetTarget() and Color3.fromRGB(0, 255, 100) or Theme.Primary
    
    if Aimbot.Enabled then
        local target = GetTarget()
        if target then
            local head = target.Character.Head
            local velocity = Vector3.new()
            
            if target.Character:FindFirstChild("HumanoidRootPart") then
                velocity = target.Character.HumanoidRootPart.Velocity
            end
            
            local distance = (head.Position - Camera.CFrame.Position).Magnitude
            local prediction = velocity * math.clamp(distance / 100, 0.1, 0.5) * 0.1
            
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position + prediction)
        end
    end
    
    for player, lines in pairs(ESPObjects) do
        if player.Team == LocalPlayer.Team then 
            HideESP(lines)
            continue
        end
        
        if not ESP.Enabled or not player.Character then
            HideESP(lines)
            continue
        end
        
        local humanoid = player.Character:FindFirstChild("Humanoid")
        local head = player.Character:FindFirstChild("Head")
        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        
        if not humanoid or not head or not hrp or humanoid.Health <= 0 then
            HideESP(lines)
            continue
        end
        
        local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
        local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
        
        if not headPos.Z then
            HideESP(lines)
            continue
        end
        
        local height = math.abs(footPos.Y - headPos.Y)
        local width = height * 0.5
        
        local topLeft = Vector2.new(headPos.X - width/2, headPos.Y)
        local topRight = Vector2.new(headPos.X + width/2, headPos.Y)
        local bottomLeft = Vector2.new(headPos.X - width/2, headPos.Y + height)
        local bottomRight = Vector2.new(headPos.X + width/2, headPos.Y + height)
        
        UpdateCornerESP(lines, topLeft, topRight, bottomLeft, bottomRight, width)
    end
end)

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and not IsMobile and input.KeyCode == Enum.KeyCode.Insert then
        ToggleMenu()
    end
end)

print("KN HUB Professional Loaded!")
