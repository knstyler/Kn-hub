-- KN HUB
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Configs
local Aimbot = {Enabled = false, Smooth = 1, FOV = 250, WallCheck = true, TeamCheck = true}
local ESP = {Enabled = false, Boxes = true, Names = true, Health = true, Color = Color3.fromRGB(255, 80, 80)}
local Theme = Color3.fromRGB(0, 170, 255)

-- UI
local Gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Gui.ResetOnSpawn = false

local Btn = Instance.new("TextButton", Gui)
Btn.Size = IsMobile and UDim2.new(0, 50, 0, 50) or UDim2.new(0, 40, 0, 40)
Btn.Position = UDim2.new(0, 10, 0, 10)
Btn.BackgroundColor3 = Theme
Btn.Text = "KN"
Btn.TextColor3 = Color3.new(1, 1, 1)
Btn.Font = Enum.Font.GothamBold
Btn.TextSize = IsMobile and 16 or 14
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

local Menu = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
Menu.Enabled = false
Menu.ResetOnSpawn = false

local Frame = Instance.new("Frame", Menu)
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.5, -150, 0.5, -125)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local Title = Instance.new("Frame", Frame)
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)
Instance.new("Frame", Title).Size = UDim2.new(1, 0, 0.5, 0)
Instance.new("Frame", Title).Position = UDim2.new(0, 0, 0.5, 0)
Instance.new("Frame", Title).BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local TitleText = Instance.new("TextLabel", Title)
TitleText.Text = "KN HUB"
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Theme
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 26, 0, 26)
Close.Position = UDim2.new(1, -32, 0.5, -13)
Close.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 18
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("ScrollingFrame", Frame)
Content.Size = UDim2.new(1, -16, 1, -51)
Content.Position = UDim2.new(0, 8, 0, 43)
Content.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Theme
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 6)
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 8)

-- Toggle
local function Toggle(text, default, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, -12, 0, 40)
	f.Position = UDim2.new(0, 6, 0, 0)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -70, 1, 0)
	l.Position = UDim2.new(0, 12, 0, 0)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 13
	l.TextXAlignment = Enum.TextXAlignment.Left
	
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0, 50, 0, 24)
	b.Position = UDim2.new(1, -62, 0.5, -12)
	b.BackgroundColor3 = default and Theme or Color3.fromRGB(70, 70, 70)
	b.Text = default and "ON" or "OFF"
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 11
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 4)
	
	local state = default
	b.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		b.Text = state and "ON" or "OFF"
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = state and Theme or Color3.fromRGB(70, 70, 70)}):Play()
	end)
end

-- Slider
local function Slider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, -12, 0, 55)
	f.Position = UDim2.new(0, 6, 0, 0)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -70, 0, 22)
	l.Position = UDim2.new(0, 12, 0, 6)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 12
	
	local v = Instance.new("TextLabel", f)
	v.Text = tostring(default) .. suffix
	v.Size = UDim2.new(0, 60, 0, 22)
	v.Position = UDim2.new(1, -68, 0, 6)
	v.BackgroundTransparency = 1
	v.TextColor3 = Theme
	v.Font = Enum.Font.GothamBold
	v.TextSize = 12
	
	local r = Instance.new("Frame", f)
	r.Size = UDim2.new(1, -24, 0, 6)
	r.Position = UDim2.new(0, 12, 1, -18)
	r.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
	
	local fl = Instance.new("Frame", r)
	fl.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fl.BackgroundColor3 = Theme
	Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)
	
	local k = Instance.new("Frame", r)
	k.Size = UDim2.new(0, 14, 0, 14)
	k.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
	k.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", k).CornerRadius = UDim.new(1, 0)
	
	local g = false
	local function u(i)
		local p = math.clamp((i.Position.X - r.AbsolutePosition.X) / r.AbsoluteSize.X, 0, 1)
		local val = math.floor(min + (p * (max - min)))
		fl.Size = UDim2.new(p, 0, 1, 0)
		k.Position = UDim2.new(p, -7, 0.5, -7)
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
Circle.Transparency = 0.5
Circle.Thickness = 2
Circle.Filled = false
Circle.NumSides = 64

-- ESP 2D (igual da foto)
local ESPObjects = {}

function SetupESP(p)
	if p == LocalPlayer then return end
	ESPObjects[p] = {
		Box = Drawing.new("Square"),
		Name = Drawing.new("Text"),
		Health = Drawing.new("Text"),
		Distance = Drawing.new("Text")
	}
	local o = ESPObjects[p]
	o.Box.Thickness = 1.5
	o.Box.Filled = false
	o.Name.Size = 12
	o.Name.Center = true
	o.Name.Outline = true
	o.Name.Font = 2
	o.Health.Size = 11
	o.Health.Center = true
	o.Health.Outline = true
	o.Health.Font = 2
	o.Distance.Size = 11
	o.Distance.Center = true
	o.Distance.Outline = true
	o.Distance.Font = 2
end

for _, p in pairs(Players:GetPlayers()) do SetupESP(p) end
Players.PlayerAdded:Connect(SetupESP)
Players.PlayerRemoving:Connect(function(p)
	if ESPObjects[p] then
		ESPObjects[p].Box:Remove()
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
			o.Box.Visible = false
			o.Name.Visible = false
			o.Health.Visible = false
			o.Distance.Visible = false
			continue 
		end
		
		if not ESP.Enabled or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
			o.Box.Visible = false
			o.Name.Visible = false
			o.Health.Visible = false
			o.Distance.Visible = false
		else
			local hrp, head, hum = p.Character.HumanoidRootPart, p.Character:FindFirstChild("Head"), p.Character:FindFirstChild("Humanoid")
			if not head or not hum then
				o.Box.Visible = false
				o.Name.Visible = false
				o.Health.Visible = false
				o.Distance.Visible = false
				continue
			end
			
			-- Posições 2D na tela
			local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
			local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
			
			if not headPos.Z then
				o.Box.Visible = false
				o.Name.Visible = false
				o.Health.Visible = false
				o.Distance.Visible = false
				continue
			end
			
			local h = math.abs(footPos.Y - headPos.Y)
			local w = h * 0.5
			local x = headPos.X - w / 2
			local y = headPos.Y
			
			local color = ESP.Color
			local hp = hum.Health / hum.MaxHealth
			local dist = (hrp.Position - Camera.CFrame.Position).Magnitude
			
			-- Box 2D (igual da foto)
			if ESP.Boxes then
				o.Box.Size = Vector2.new(w, h)
				o.Box.Position = Vector2.new(x, y)
				o.Box.Color = color
				o.Box.Visible = true
			else
				o.Box.Visible = false
			end
			
			-- Nome (vermelho, em cima)
			if ESP.Names then
				o.Name.Position = Vector2.new(headPos.X, y - 15)
				o.Name.Text = p.Name
				o.Name.Color = color
				o.Name.Visible = true
			else
				o.Name.Visible = false
			end
			
			-- HP (verde se cheio, vermelho se vazio)
			if ESP.Health then
				o.Health.Position = Vector2.new(headPos.X, y - 28)
				o.Health.Text = math.floor(hum.Health) .. " HP"
				o.Health.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 0)
				o.Health.Visible = true
			else
				o.Health.Visible = false
			end
			
			-- Distância (cinza, embaixo)
			o.Distance.Position = Vector2.new(headPos.X, footPos.Y + 5)
			o.Distance.Text = math.floor(dist) .. "m"
			o.Distance.Color = Color3.fromRGB(200, 200, 200)
			o.Distance.Visible = true
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and not IsMobile and i.KeyCode == Enum.KeyCode.Insert then ToggleMenu() end end)

print("KN HUB loaded!")
