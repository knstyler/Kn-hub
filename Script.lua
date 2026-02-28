-- KN HUB - Aimbot + ESP (Revised)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Configs
local Aimbot = {Enabled = false, Smooth = 1.0, FOV = 250, WallCheck = true, TeamCheck = true, Target = "Head"}
local ESP = {Enabled = false, Boxes = true, Names = true, Health = true, Color = Color3.fromRGB(255, 255, 255)} -- Branco
local Theme = Color3.fromRGB(147, 112, 219) -- Roxo moderno

-- UI
local Gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Gui.ResetOnSpawn = false
Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Botão flutuante estilizado
local Btn = Instance.new("TextButton", Gui)
Btn.Size = IsMobile and UDim2.new(0, 55, 0, 55) or UDim2.new(0, 45, 0, 45)
Btn.Position = UDim2.new(0, 20, 0, 20)
Btn.BackgroundColor3 = Theme
Btn.Text = "KN"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.GothamBlack
Btn.TextSize = IsMobile and 18 or 16
Btn.TextStrokeTransparency = 0.8

local Corner = Instance.new("UICorner", Btn)
Corner.CornerRadius = UDim.new(0, 12)

local Stroke = Instance.new("UIStroke", Btn)
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.5

-- Sombra do botão
local Shadow = Instance.new("ImageLabel", Btn)
Shadow.Size = UDim2.new(1, 8, 1, 8)
Shadow.Position = UDim2.new(0, -4, 0, -4)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 118, 118)
Shadow.ZIndex = -1

-- Menu principal
local Menu = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Menu.Enabled = false
Menu.ResetOnSpawn = false
Menu.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Frame principal com glassmorphism
local Frame = Instance.new("Frame", Menu)
Frame.Size = UDim2.new(0, 300, 0, 400)
Frame.Position = UDim2.new(0.5, -150, 0.5, -200)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BackgroundTransparency = 0.1
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.ClipsDescendants = true

local FrameCorner = Instance.new("UICorner", Frame)
FrameCorner.CornerRadius = UDim.new(0, 12)

local FrameStroke = Instance.new("UIStroke", Frame)
FrameStroke.Color = Theme
FrameStroke.Thickness = 1.5
FrameStroke.Transparency = 0.3

-- Header
local TitleBar = Instance.new("Frame", Frame)
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 12)

local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Text = "🔥 KN HUB"
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Color3.new(1, 1, 1)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local CloseBtn = Instance.new("TextButton", TitleBar)
CloseBtn.Size = UDim2.new(0, 28, 0, 28)
CloseBtn.Position = UDim2.new(1, -36, 0.5, -14)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14

local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Abas
local TabFrame = Instance.new("Frame", Frame)
TabFrame.Size = UDim2.new(1, 0, 0, 35)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabFrame.BorderSizePixel = 0

local TabLayout = Instance.new("UIListLayout", TabFrame)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.Padding = UDim.new(0, 10)

local function CreateTab(name, icon)
	local tab = Instance.new("TextButton", TabFrame)
	tab.Size = UDim2.new(0, 80, 1, -6)
	tab.Position = UDim2.new(0, 0, 0, 3)
	tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	tab.Text = icon .. " " .. name
	tab.TextColor3 = Color3.new(0.8, 0.8, 0.8)
	tab.Font = Enum.Font.GothamSemibold
	tab.TextSize = 11
	tab.AutoButtonColor = false
	
	local tabCorner = Instance.new("UICorner", tab)
	tabCorner.CornerRadius = UDim.new(0, 6)
	
	return tab
end

local AimbotTab = CreateTab("Aimbot", "🎯")
local ESPTab = CreateTab("ESP", "👁️")

-- Conteúdo scrollável
local Content = Instance.new("ScrollingFrame", Frame)
Content.Size = UDim2.new(1, -20, 1, -85)
Content.Position = UDim2.new(0, 10, 0, 80)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Theme
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y

local ContentLayout = Instance.new("UIListLayout", Content)
ContentLayout.Padding = UDim.new(0, 8)
ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Seções
local function CreateSection(title)
	local section = Instance.new("Frame", Content)
	section.Size = UDim2.new(1, 0, 0, 30)
	section.BackgroundTransparency = 1
	section.LayoutOrder = #Content:GetChildren()
	
	local label = Instance.new("TextLabel", section)
	label.Text = title:upper()
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Theme
	label.Font = Enum.Font.GothamBold
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	
	local line = Instance.new("Frame", section)
	line.Size = UDim2.new(1, 0, 0, 1)
	line.Position = UDim2.new(0, 0, 1, -5)
	line.BackgroundColor3 = Theme
	line.BackgroundTransparency = 0.5
	line.BorderSizePixel = 0
	
	return section
end

-- Toggle moderno
local function CreateToggle(text, default, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 40)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	f.LayoutOrder = #Content:GetChildren()
	
	local fCorner = Instance.new("UICorner", f)
	fCorner.CornerRadius = UDim.new(0, 8)
	
	local label = Instance.new("TextLabel", f)
	label.Text = text
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	
	-- Toggle switch
	local switch = Instance.new("TextButton", f)
	switch.Size = UDim2.new(0, 44, 0, 24)
	switch.Position = UDim2.new(1, -54, 0.5, -12)
	switch.BackgroundColor3 = default and Theme or Color3.fromRGB(60, 60, 60)
	switch.Text = ""
	switch.AutoButtonColor = false
	
	local switchCorner = Instance.new("UICorner", switch)
	switchCorner.CornerRadius = UDim.new(1, 0)
	
	local knob = Instance.new("Frame", switch)
	knob.Size = UDim2.new(0, 18, 0, 18)
	knob.Position = default and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	
	local knobCorner = Instance.new("UICorner", knob)
	knobCorner.CornerRadius = UDim.new(1, 0)
	
	local state = default
	switch.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		
		local targetPos = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
		local targetColor = state and Theme or Color3.fromRGB(60, 60, 60)
		
		TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPos}):Play()
		TweenService:Create(switch, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
	end)
	
	return f
end

-- Slider moderno
local function CreateSlider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 55)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	f.LayoutOrder = #Content:GetChildren()
	
	local fCorner = Instance.new("UICorner", f)
	fCorner.CornerRadius = UDim.new(0, 8)
	
	local label = Instance.new("TextLabel", f)
	label.Text = text
	label.Size = UDim2.new(1, -70, 0, 20)
	label.Position = UDim2.new(0, 12, 0, 8)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.new(1, 1, 1)
	label.Font = Enum.Font.GothamSemibold
	label.TextSize = 13
	label.TextXAlignment = Enum.TextXAlignment.Left
	
	local val = Instance.new("TextLabel", f)
	val.Text = tostring(default) .. suffix
	val.Size = UDim2.new(0, 50, 0, 20)
	val.Position = UDim2.new(1, -60, 0, 8)
	val.BackgroundTransparency = 1
	val.TextColor3 = Theme
	val.Font = Enum.Font.GothamBold
	val.TextSize = 13
	
	-- Track
	local track = Instance.new("Frame", f)
	track.Size = UDim2.new(1, -24, 0, 6)
	track.Position = UDim2.new(0, 12, 1, -18)
	track.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	track.BorderSizePixel = 0
	
	local trackCorner = Instance.new("UICorner", track)
	trackCorner.CornerRadius = UDim.new(1, 0)
	
	-- Fill
	local fill = Instance.new("Frame", track)
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = Theme
	fill.BorderSizePixel = 0
	
	local fillCorner = Instance.new("UICorner", fill)
	fillCorner.CornerRadius = UDim.new(1, 0)
	
	-- Knob
	local knob = Instance.new("Frame", track)
	knob.Size = UDim2.new(0, 14, 0, 14)
	knob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	knob.BorderSizePixel = 0
	knob.ZIndex = 2
	
	local knobCorner = Instance.new("UICorner", knob)
	knobCorner.CornerRadius = UDim.new(1, 0)
	
	local dragging = false
	local function update(input)
		local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local v = math.floor(min + (pos * (max - min)))
		fill.Size = UDim2.new(pos, 0, 1, 0)
		knob.Position = UDim2.new(pos, -7, 0.5, -7)
		val.Text = tostring(v) .. suffix
		callback(v)
	end
	
	track.InputBegan:Connect(function(i) 
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
			dragging = true 
			update(i) 
		end 
	end)
	
	UserInputService.InputChanged:Connect(function(i) 
		if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
			update(i) 
		end 
	end)
	
	UserInputService.InputEnded:Connect(function(i) 
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
			dragging = false 
		end 
	end)
	
	return f
end

-- Adicionar controles
CreateSection("Aimbot")
CreateToggle("Enable Aimbot", false, function(v) Aimbot.Enabled = v end)
CreateToggle("Team Check", true, function(v) Aimbot.TeamCheck = v end)
CreateToggle("Wall Check", true, function(v) Aimbot.WallCheck = v end)
CreateSlider("FOV Radius", 50, 500, 250, "px", function(v) Aimbot.FOV = v end)
CreateSlider("Smoothness", 1, 100, 100, "%", function(v) Aimbot.Smooth = v / 100 end)

CreateSection("ESP")
CreateToggle("Enable ESP", false, function(v) ESP.Enabled = v end)
CreateToggle("Corner Boxes", true, function(v) ESP.Boxes = v end)
CreateToggle("Show Names", true, function(v) ESP.Names = v end)
CreateToggle("Show Health", true, function(v) ESP.Health = v end)

-- Menu toggle
local open = false
function ToggleMenu()
	open = not open
	Menu.Enabled = open
	
	if open then
		Btn.Text = "✓"
		Btn.BackgroundColor3 = Color3.fromRGB(0, 255, 127)
		TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Back), {Size = UDim2.new(0, 300, 0, 400)}):Play()
	else
		Btn.Text = "KN"
		Btn.BackgroundColor3 = Theme
	end
end

Btn.MouseButton1Click:Connect(ToggleMenu)
CloseBtn.MouseButton1Click:Connect(ToggleMenu)

-- Animação hover no botão
Btn.MouseEnter:Connect(function()
	TweenService:Create(Btn, TweenInfo.new(0.2), {Size = UDim2.new(0, Btn.Size.X.Offset + 4, 0, Btn.Size.Y.Offset + 4)}):Play()
end)

Btn.MouseLeave:Connect(function()
	TweenService:Create(Btn, TweenInfo.new(0.2), {Size = IsMobile and UDim2.new(0, 55, 0, 55) or UDim2.new(0, 45, 0, 45)}):Play()
end)

-- Drag menu melhorado
local drag, offset = false, nil
TitleBar.InputBegan:Connect(function(i) 
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
		drag = true 
		offset = i.Position - Frame.AbsolutePosition 
	end 
end)

UserInputService.InputChanged:Connect(function(i) 
	if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then 
		Frame.Position = UDim2.new(0, i.Position.X - offset.X, 0, i.Position.Y - offset.Y) 
	end 
end)

UserInputService.InputEnded:Connect(function(i) 
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then 
		drag = false 
	end 
end)

-- FOV Circle
local Circle = Drawing.new("Circle")
Circle.Transparency = 0.3
Circle.Thickness = 2
Circle.Filled = false
Circle.NumSides = 64

-- ESP System - Corner Box
local ESPObjects = {}
function SetupESP(p)
	if p == LocalPlayer then return end
	ESPObjects[p] = {
		-- Corner lines (8 linhas para fazer os cantos)
		Lines = {},
		Name = Drawing.new("Text"),
		Health = Drawing.new("Square"),
		HealthBg = Drawing.new("Square")
	}
	
	local o = ESPObjects[p]
	
	-- Criar 8 linhas para corner box (2 por canto)
	for i = 1, 8 do
		o.Lines[i] = Drawing.new("Line")
		o.Lines[i].Thickness = 1.5
		o.Lines[i].Color = ESP.Color -- Branco
	end
	
	o.Name.Size = 11
	o.Name.Center = true
	o.Name.Outline = true
	o.Name.Color = ESP.Color -- Branco
	
	o.Health.Filled = true
	o.HealthBg.Filled = true
end

for _, p in pairs(Players:GetPlayers()) do SetupESP(p) end
Players.PlayerAdded:Connect(SetupESP)
Players.PlayerRemoving:Connect(function(p)
	if ESPObjects[p] then 
		for _, d in pairs(ESPObjects[p].Lines) do d:Remove() end
		ESPObjects[p].Name:Remove()
		ESPObjects[p].Health:Remove()
		ESPObjects[p].HealthBg:Remove()
		ESPObjects[p] = nil 
	end
end)

-- Get target
function GetTarget()
	local target, dist, center = nil, math.huge, Camera.ViewportSize / 2
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local hum, head = p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild(Aimbot.Target)
			if hum and hum.Health > 0 and head then
				if Aimbot.TeamCheck and p.Team == LocalPlayer.Team then continue end
				local pos, onScreen = Camera:WorldToViewportPoint(head.Position)
				if onScreen then
					local d = (Vector2.new(pos.X, pos.Y) - center).Magnitude
					if d < Aimbot.FOV and d < dist then
						if Aimbot.WallCheck then
							local rp = RaycastParams.new()
							rp.FilterDescendantsInstances = {LocalPlayer.Character}
							local r = workspace:Raycast(Camera.CFrame.Position, (head.Position - Camera.CFrame.Position) * 1.1, rp)
							if r and not r.Instance:IsDescendantOf(p.Character) then continue end
						end
						dist, target = d, p
					end
				end
			end
		end
	end
	return target
end

function Predict(t)
	local head = t.Character[Aimbot.Target]
	local vel = t.Character:FindFirstChild("HumanoidRootPart") and t.Character.HumanoidRootPart.Velocity or Vector3.new()
	local d = (head.Position - Camera.CFrame.Position).Magnitude
	return head.Position + (vel * math.clamp(d / 100, 0.1, 0.5) * 0.1)
end

-- Função para desenhar corner box
function DrawCornerBox(lines, topLeft, bottomRight, color)
	local cornerSize = 6
	local x1, y1 = topLeft.X, topLeft.Y
	local x2, y2 = bottomRight.X, bottomRight.Y
	
	-- Top left
	lines[1].From = Vector2.new(x1, y1)
	lines[1].To = Vector2.new(x1 + cornerSize, y1)
	lines[2].From = Vector2.new(x1, y1)
	lines[2].To = Vector2.new(x1, y1 + cornerSize)
	
	-- Top right
	lines[3].From = Vector2.new(x2, y1)
	lines[3].To = Vector2.new(x2 - cornerSize, y1)
	lines[4].From = Vector2.new(x2, y1)
	lines[4].To = Vector2.new(x2, y1 + cornerSize)
	
	-- Bottom left
	lines[5].From = Vector2.new(x1, y2)
	lines[5].To = Vector2.new(x1 + cornerSize, y2)
	lines[6].From = Vector2.new(x1, y2)
	lines[6].To = Vector2.new(x1, y2 - cornerSize)
	
	-- Bottom right
	lines[7].From = Vector2.new(x2, y2)
	lines[7].To = Vector2.new(x2 - cornerSize, y2)
	lines[8].From = Vector2.new(x2, y2)
	lines[8].To = Vector2.new(x2, y2 - cornerSize)
	
	for i = 1, 8 do
		lines[i].Color = color
		lines[i].Visible = true
	end
end

-- Main loop
RunService.RenderStepped:Connect(function()
	local target = GetTarget()
	local center = Camera.ViewportSize / 2
	
	Circle.Position = center
	Circle.Radius = Aimbot.FOV
	Circle.Visible = Aimbot.Enabled
	Circle.Color = target and Color3.fromRGB(0, 255, 100) or Theme
	
	if Aimbot.Enabled and target then
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, Predict(target))
	end
	
	for p, o in pairs(ESPObjects) do
		-- Team check
		if p.Team == LocalPlayer.Team then 
			for _, line in pairs(o.Lines) do line.Visible = false end
			o.Name.Visible = false
			o.Health.Visible = false
			o.HealthBg.Visible = false
			continue 
		end
		
		if not ESP.Enabled or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
			for _, line in pairs(o.Lines) do line.Visible = false end
			o.Name.Visible = false
			o.Health.Visible = false
			o.HealthBg.Visible = false
		else
			local hrp, head, hum = p.Character.HumanoidRootPart, p.Character:FindFirstChild("Head"), p.Character:FindFirstChild("Humanoid")
			local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
			
			if not head or not hum or not torso then 
				for _, line in pairs(o.Lines) do line.Visible = false end
				o.Name.Visible = false
				o.Health.Visible = false
				o.HealthBg.Visible = false
				continue 
			end
			
			local top = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
			local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.5, 0))
			
			if top.Z < 0 or bottom.Z < 0 then -- Behind camera
				for _, line in pairs(o.Lines) do line.Visible = false end
				o.Name.Visible = false
				o.Health.Visible = false
				o.HealthBg.Visible = false
				continue
			end
			
			local h = math.abs(bottom.Y - top.Y)
			local w = h * 0.45
			local cx = (top.X + bottom.X) / 2
			
			local topLeft = Vector2.new(cx - w/2, top.Y)
			local bottomRight = Vector2.new(cx + w/2, bottom.Y)
			
			if ESP.Boxes then
				DrawCornerBox(o.Lines, topLeft, bottomRight, ESP.Color)
			else 
				for _, line in pairs(o.Lines) do line.Visible = false end
			end
			
			if ESP.Names then
				o.Name.Position = Vector2.new(cx, top.Y - 15)
				o.Name.Text = p.Name
				o.Name.Color = ESP.Color
				o.Name.Visible = true
			else 
				o.Name.Visible = false 
			end
			
			if ESP.Health then
				local hh = h * 0.8
				local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
				
				o.HealthBg.Size = Vector2.new(3, hh)
				o.HealthBg.Position = Vector2.new(cx - w/2 - 8, top.Y + (h - hh)/2)
				o.HealthBg.Color = Color3.fromRGB(40, 40, 40)
				o.HealthBg.Visible = true
				
				o.Health.Size = Vector2.new(3, hh * hp)
				o.Health.Position = Vector2.new(cx - w/2 - 8, top.Y + (h - hh)/2 + hh * (1 - hp))
				o.Health.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 50)
				o.Health.Visible = true
			else 
				o.Health.Visible = false 
				o.HealthBg.Visible = false 
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, g) 
	if not g and not IsMobile and i.KeyCode == Enum.KeyCode.Insert then 
		ToggleMenu() 
	end 
end)

print("✅ KN HUB Loaded Successfully!")
