-- KN HUB v3
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Configs
local Aimbot = {Enabled = false, Smooth = 1, FOV = 250, WallCheck = true, TeamCheck = true}
local ESP = {Enabled = false, Boxes = true, Names = true, Health = true, Distance = true, Color = Color3.fromRGB(255, 70, 70)}
local Theme = Color3.fromRGB(0, 150, 255)

-- UI
local Gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Gui.ResetOnSpawn = false

local Btn = Instance.new("TextButton", Gui)
Btn.Size = IsMobile and UDim2.new(0, 45, 0, 45) or UDim2.new(0, 38, 0, 38)
Btn.Position = UDim2.new(0, 12, 0, 12)
Btn.BackgroundColor3 = Theme
Btn.Text = "KN"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = 14
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0.3, 0)

local Menu = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Menu.Enabled = false
Menu.ResetOnSpawn = false

local Frame = Instance.new("Frame", Menu)
Frame.Size = UDim2.new(0, 320, 0, 280)
Frame.Position = UDim2.new(0.5, -160, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local Shadow = Instance.new("ImageLabel", Frame)
Shadow.Size = UDim2.new(1, 30, 1, 30)
Shadow.Position = UDim2.new(0, -15, 0, -15)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6

local Title = Instance.new("Frame", Frame)
Title.Size = UDim2.new(1, 0, 0, 36)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)
Instance.new("Frame", Title).Size = UDim2.new(1, 0, 0.5, 0)
Instance.new("Frame", Title).Position = UDim2.new(0, 0, 0.5, 0)
Instance.new("Frame", Title).BackgroundColor3 = Color3.fromRGB(25, 25, 25)

Instance.new("TextLabel", Title).Text = "KN HUB"
Instance.new("TextLabel", Title).Size = UDim2.new(1, -50, 1, 0)
Instance.new("TextLabel", Title).Position = UDim2.new(0, 12, 0, 0)
Instance.new("TextLabel", Title).BackgroundTransparency = 1
Instance.new("TextLabel", Title).TextColor3 = Theme
Instance.new("TextLabel", Title).Font = Enum.Font.GothamBold
Instance.new("TextLabel", Title).TextSize = 14
Instance.new("TextLabel", Title).TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 24, 0, 24)
Close.Position = UDim2.new(1, -32, 0.5, -12)
Close.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 16
Instance.new("UICorner", Close).CornerRadius = UDim.new(0.3, 0)

local Content = Instance.new("ScrollingFrame", Frame)
Content.Size = UDim2.new(1, -16, 1, -48)
Content.Position = UDim2.new(0, 8, 0, 40)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 3
Content.ScrollBarImageColor3 = Theme
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 6)

-- Toggle
local function Toggle(text, default, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 38)
	f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	Instance.new("TextLabel", f).Text = text
	Instance.new("TextLabel", f).Size = UDim2.new(1, -70, 1, 0)
	Instance.new("TextLabel", f).Position = UDim2.new(0, 12, 0, 0)
	Instance.new("TextLabel", f).BackgroundTransparency = 1
	Instance.new("TextLabel", f).TextColor3 = Color3.new(1, 1, 1)
	Instance.new("TextLabel", f).Font = Enum.Font.Gotham
	Instance.new("TextLabel", f).TextSize = 12
	Instance.new("TextLabel", f).TextXAlignment = Enum.TextXAlignment.Left
	
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0, 44, 0, 22)
	b.Position = UDim2.new(1, -56, 0.5, -11)
	b.BackgroundColor3 = default and Theme or Color3.fromRGB(60, 60, 60)
	b.Text = default and "ON" or "OFF"
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
	
	local state = default
	b.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		b.Text = state and "ON" or "OFF"
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = state and Theme or Color3.fromRGB(60, 60, 60)}):Play()
	end)
end

-- Slider
local function Slider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 50)
	f.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	Instance.new("TextLabel", f).Text = text
	Instance.new("TextLabel", f).Size = UDim2.new(1, -60, 0, 20)
	Instance.new("TextLabel", f).Position = UDim2.new(0, 12, 0, 6)
	Instance.new("TextLabel", f).BackgroundTransparency = 1
	Instance.new("TextLabel", f).TextColor3 = Color3.new(1, 1, 1)
	Instance.new("TextLabel", f).Font = Enum.Font.Gotham
	Instance.new("TextLabel", f).TextSize = 11
	
	local v = Instance.new("TextLabel", f)
	v.Text = tostring(default) .. suffix
	v.Size = UDim2.new(0, 50, 0, 20)
	v.Position = UDim2.new(1, -58, 0, 6)
	v.BackgroundTransparency = 1
	v.TextColor3 = Theme
	v.Font = Enum.Font.GothamBold
	v.TextSize = 11
	
	local r = Instance.new("Frame", f)
	r.Size = UDim2.new(1, -24, 0, 4)
	r.Position = UDim2.new(0, 12, 1, -14)
	r.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
	
	local fl = Instance.new("Frame", r)
	fl.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fl.BackgroundColor3 = Theme
	Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)
	
	local k = Instance.new("Frame", r)
	k.Size = UDim2.new(0, 12, 0, 12)
	k.Position = UDim2.new((default - min) / (max - min), -6, 0.5, -6)
	k.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", k).CornerRadius = UDim.new(1, 0)
	
	local g = false
	local function u(i)
		local p = math.clamp((i.Position.X - r.AbsolutePosition.X) / r.AbsoluteSize.X, 0, 1)
		local val = math.floor(min + (p * (max - min)))
		fl.Size = UDim2.new(p, 0, 1, 0)
		k.Position = UDim2.new(p, -6, 0.5, -6)
		v.Text = tostring(val) .. suffix
		callback(val)
	end
	
	r.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then g = true u(i) end end)
	UserInputService.InputChanged:Connect(function(i) if g and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then u(i) end end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then g = false end end)
end

-- Controls
Toggle("Aimbot", false, function(v) Aimbot.Enabled = v end)
Toggle("Team Check", true, function(v) Aimbot.TeamCheck = v end)
Toggle("Wall Check", true, function(v) Aimbot.WallCheck = v end)
Slider("FOV", 50, 500, 250, "px", function(v) Aimbot.FOV = v end)
Slider("Smooth", 1, 100, 100, "%", function(v) Aimbot.Smooth = v / 100 end)
Toggle("ESP", false, function(v) ESP.Enabled = v end)
Toggle("Boxes", true, function(v) ESP.Boxes = v end)
Toggle("Names", true, function(v) ESP.Names = v end)
Toggle("Health", true, function(v) ESP.Health = v end)

-- Menu toggle
local open = false
function ToggleMenu()
	open = not open
	Menu.Enabled = open
	Btn.Text = open and "✓" or "KN"
	Btn.BackgroundColor3 = open and Color3.fromRGB(0, 255, 100) or Theme
end

Btn.MouseButton1Click:Connect(ToggleMenu)
Close.MouseButton1Click:Connect(ToggleMenu)

-- Drag
local drag, offset = false, nil
Title.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = true offset = i.Position - Frame.AbsolutePosition end end)
UserInputService.InputChanged:Connect(function(i) if drag and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then Frame.Position = UDim2.new(0, i.Position.X - offset.X, 0, i.Position.Y - offset.Y) end end)
UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then drag = false end end)

-- FOV Circle
local Circle = Drawing.new("Circle")
Circle.Transparency = 0.4
Circle.Thickness = 2
Circle.Filled = false
Circle.NumSides = 64

-- ESP 3D System (Corner Boxes igual da foto)
local ESPObjects = {}

function SetupESP(p)
	if p == LocalPlayer then return end
	ESPObjects[p] = {
		-- 8 linhas para corner box (2D na tela mas baseado em 3D)
		Lines = {},
		Name = Drawing.new("Text"),
		Health = Drawing.new("Text"),
		Distance = Drawing.new("Text")
	}
	
	-- Criar 8 linhas (4 cantos, 2 linhas cada)
	for i = 1, 8 do
		ESPObjects[p].Lines[i] = Drawing.new("Line")
		ESPObjects[p].Lines[i].Thickness = 1.5
	end
	
	local o = ESPObjects[p]
	o.Name.Size = 11
	o.Name.Center = true
	o.Name.Outline = true
	o.Name.Font = 2
	
	o.Health.Size = 10
	o.Health.Center = true
	o.Health.Outline = true
	
	o.Distance.Size = 10
	o.Distance.Center = true
	o.Distance.Outline = true
end

for _, p in pairs(Players:GetPlayers()) do SetupESP(p) end
Players.PlayerAdded:Connect(SetupESP)
Players.PlayerRemoving:Connect(function(p)
	if ESPObjects[p] then
		for i = 1, 8 do ESPObjects[p].Lines[i]:Remove() end
		ESPObjects[p].Name:Remove()
		ESPObjects[p].Health:Remove()
		ESPObjects[p].Distance:Remove()
		ESPObjects[p] = nil
	end
end)

-- Get target
function GetTarget()
	local target, dist, center = nil, math.huge, Camera.ViewportSize / 2
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character then
			local hum, head = p.Character:FindFirstChild("Humanoid"), p.Character:FindFirstChild("Head")
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

-- Main loop
RunService.RenderStepped:Connect(function()
	local target = GetTarget()
	local center = Camera.ViewportSize / 2
	
	Circle.Position = center
	Circle.Radius = Aimbot.FOV
	Circle.Visible = Aimbot.Enabled
	Circle.Color = target and Color3.fromRGB(0, 255, 100) or Theme
	
	if Aimbot.Enabled and target then
		local head = target.Character.Head
		local vel = target.Character:FindFirstChild("HumanoidRootPart") and target.Character.HumanoidRootPart.Velocity or Vector3.new()
		local d = (head.Position - Camera.CFrame.Position).Magnitude
		Camera.CFrame = CFrame.new(Camera.CFrame.Position, head.Position + (vel * math.clamp(d / 100, 0.1, 0.5) * 0.1))
	end
	
	for p, o in pairs(ESPObjects) do
		if p.Team == LocalPlayer.Team then 
			for i = 1, 8 do o.Lines[i].Visible = false end
			o.Name.Visible = false
			o.Health.Visible = false
			o.Distance.Visible = false
			continue 
		end
		
		if not ESP.Enabled or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
			for i = 1, 8 do o.Lines[i].Visible = false end
			o.Name.Visible = false
			o.Health.Visible = false
			o.Distance.Visible = false
		else
			local hrp, head, hum = p.Character.HumanoidRootPart, p.Character:FindFirstChild("Head"), p.Character:FindFirstChild("Humanoid")
			local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
			if not head or not hum or not torso then
				for i = 1, 8 do o.Lines[i].Visible = false end
				o.Name.Visible = false
				o.Health.Visible = false
				o.Distance.Visible = false
				continue
			end
			
			-- Calcular cantos 3D
			local cf = hrp.CFrame
			local size = Vector3.new(3, 5, 2) -- Tamanho do personagem
			
			local corners = {
				cf * CFrame.new(-size.X/2, size.Y/2, -size.Z/2),  -- Topo esquerdo tras
				cf * CFrame.new(size.X/2, size.Y/2, -size.Z/2),   -- Topo direito tras
				cf * CFrame.new(size.X/2, size.Y/2, size.Z/2),    -- Topo direito frente
				cf * CFrame.new(-size.X/2, size.Y/2, size.Z/2),   -- Topo esquerdo frente
				cf * CFrame.new(-size.X/2, -size.Y/2, -size.Z/2), -- Baixo esquerdo tras
				cf * CFrame.new(size.X/2, -size.Y/2, -size.Z/2),  -- Baixo direito tras
				cf * CFrame.new(size.X/2, -size.Y/2, size.Z/2),   -- Baixo direito frente
				cf * CFrame.new(-size.X/2, -size.Y/2, size.Z/2)   -- Baixo esquerdo frente
			}
			
			-- Projetar para 2D
			local points = {}
			for i, corner in ipairs(corners) do
				local pos, onScreen = Camera:WorldToViewportPoint(corner.Position)
				points[i] = Vector2.new(pos.X, pos.Y)
			end
			
			-- Calcular bounding box 2D
			local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
			for _, pt in ipairs(points) do
				minX = math.min(minX, pt.X)
				minY = math.min(minY, pt.Y)
				maxX = math.max(maxX, pt.X)
				maxY = math.max(maxY, pt.Y)
			end
			
			local w, h = maxX - minX, maxY - minY
			local cornerSize = math.min(w, h) * 0.25 -- Tamanho do canto
			
			local color = ESP.Color
			local hp = hum.Health / hum.MaxHealth
			
			if ESP.Boxes then
				-- Corner Box (4 cantos, 2 linhas cada)
				local lines = o.Lines
				
				-- Topo esquerdo
				lines[1].From = Vector2.new(minX, minY)
				lines[1].To = Vector2.new(minX + cornerSize, minY)
				lines[2].From = Vector2.new(minX, minY)
				lines[2].To = Vector2.new(minX, minY + cornerSize)
				
				-- Topo direito
				lines[3].From = Vector2.new(maxX, minY)
				lines[3].To = Vector2.new(maxX - cornerSize, minY)
				lines[4].From = Vector2.new(maxX, minY)
				lines[4].To = Vector2.new(maxX, minY + cornerSize)
				
				-- Baixo esquerdo
				lines[5].From = Vector2.new(minX, maxY)
				lines[5].To = Vector2.new(minX + cornerSize, maxY)
				lines[6].From = Vector2.new(minX, maxY)
				lines[6].To = Vector2.new(minX, maxY - cornerSize)
				
				-- Baixo direito
				lines[7].From = Vector2.new(maxX, maxY)
				lines[7].To = Vector2.new(maxX - cornerSize, maxY)
				lines[8].From = Vector2.new(maxX, maxY)
				lines[8].To = Vector2.new(maxX, maxY - cornerSize)
				
				for i = 1, 8 do
					lines[i].Color = color
					lines[i].Visible = true
				end
			else
				for i = 1, 8 do o.Lines[i].Visible = false end
			end
			
			-- Nome
			if ESP.Names then
				o.Name.Position = Vector2.new((minX + maxX) / 2, minY - 14)
				o.Name.Text = p.Name
				o.Name.Color = color
				o.Name.Visible = true
			else o.Name.Visible = false end
			
			-- Vida
			if ESP.Health then
				o.Health.Position = Vector2.new((minX + maxX) / 2, minY - 26)
				o.Health.Text = math.floor(hum.Health) .. " HP"
				o.Health.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 50)
				o.Health.Visible = true
			else o.Health.Visible = false end
			
			-- Distância
			if ESP.Distance then
				local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
				o.Distance.Position = Vector2.new((minX + maxX) / 2, maxY + 4)
				o.Distance.Text = math.floor(dist) .. "m"
				o.Distance.Color = Color3.fromRGB(200, 200, 200)
				o.Distance.Visible = true
			else o.Distance.Visible = false end
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and not IsMobile and i.KeyCode == Enum.KeyCode.Insert then ToggleMenu() end end)

print("KN HUB v3 loaded!")
