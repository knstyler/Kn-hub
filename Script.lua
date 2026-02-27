-- KN HUB
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Configs
local Aimbot = {Enabled = false, Smooth = 1.0, FOV = 250, WallCheck = true, TeamCheck = true, Target = "Head"}
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
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.BorderSizePixel = 0
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

local Title = Instance.new("Frame", Frame)
Title.Size = UDim2.new(1, 0, 0, 32)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 6)
Instance.new("Frame", Title).Size = UDim2.new(1, 0, 0.5, 0)
Instance.new("Frame", Title).Position = UDim2.new(0, 0, 0.5, 0)
Instance.new("Frame", Title).BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local TitleText = Instance.new("TextLabel", Title)
TitleText.Text = "KN HUB"
TitleText.Size = UDim2.new(1, -50, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Theme
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 13
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 22, 0, 22)
Close.Position = UDim2.new(1, -28, 0.5, -11)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 4)

local Content = Instance.new("Frame", Frame)
Content.Size = UDim2.new(1, -10, 1, -38)
Content.Position = UDim2.new(0, 5, 0, 33)
Content.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 4)

local Scroll = Instance.new("ScrollingFrame", Content)
Scroll.Size = UDim2.new(1, -10, 1, -10)
Scroll.Position = UDim2.new(0, 5, 0, 5)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.ScrollBarImageColor3 = Theme
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

-- Toggle
local function Toggle(text, default, callback)
	local f = Instance.new("Frame", Scroll)
	f.Size = UDim2.new(1, 0, 0, 36)
	f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -60, 1, 0)
	l.Position = UDim2.new(0, 10, 0, 0)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 12
	l.TextXAlignment = Enum.TextXAlignment.Left
	
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0, 40, 0, 20)
	b.Position = UDim2.new(1, -50, 0.5, -10)
	b.BackgroundColor3 = default and Theme or Color3.fromRGB(50, 50, 50)
	b.Text = default and "ON" or "OFF"
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 10
	b.AutoButtonColor = false
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
	
	local state = default
	b.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		b.Text = state and "ON" or "OFF"
		TweenService:Create(b, TweenInfo.new(.15), {BackgroundColor3 = state and Theme or Color3.fromRGB(50, 50, 50)}):Play()
	end)
end

-- Slider
local function Slider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Scroll)
	f.Size = UDim2.new(1, 0, 0, 48)
	f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -55, 0, 18)
	l.Position = UDim2.new(0, 10, 0, 5)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 11
	
	local v = Instance.new("TextLabel", f)
	v.Text = tostring(default) .. suffix
	v.Size = UDim2.new(0, 45, 0, 18)
	v.Position = UDim2.new(1, -50, 0, 5)
	v.BackgroundTransparency = 1
	v.TextColor3 = Theme
	v.Font = Enum.Font.GothamBold
	v.TextSize = 11
	
	local r = Instance.new("Frame", f)
	r.Size = UDim2.new(1, -20, 0, 4)
	r.Position = UDim2.new(0, 10, 1, -12)
	r.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
	
	local fl = Instance.new("Frame", r)
	fl.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fl.BackgroundColor3 = Theme
	Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)
	
	local k = Instance.new("Frame", r)
	k.Size = UDim2.new(0, 10, 0, 10)
	k.Position = UDim2.new((default - min) / (max - min), -5, 0.5, -5)
	k.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", k).CornerRadius = UDim.new(1, 0)
	
	local g = false
	local function u(input)
		local pos = math.clamp((input.Position.X - r.AbsolutePosition.X) / r.AbsoluteSize.X, 0, 1)
		local val = math.floor(min + (pos * (max - min)))
		fl.Size = UDim2.new(pos, 0, 1, 0)
		k.Position = UDim2.new(pos, -5, 0.5, -5)
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
Circle.Transparency = .5
Circle.Thickness = 2
Circle.Filled = false
Circle.NumSides = 64

-- ESP
local ESPObjects = {}
function SetupESP(p)
	if p == LocalPlayer then return end
	ESPObjects[p] = {
		Box = Drawing.new("Square"),
		Name = Drawing.new("Text"),
		Health = Drawing.new("Square"),
		HealthBg = Drawing.new("Square")
	}
	local o = ESPObjects[p]
	o.Box.Thickness = 1.5
	o.Box.Filled = false
	o.Name.Size = 10
	o.Name.Center = true
	o.Name.Outline = true
	o.Health.Filled = true
	o.HealthBg.Filled = true
end

for _, p in pairs(Players:GetPlayers()) do SetupESP(p) end
Players.PlayerAdded:Connect(SetupESP)
Players.PlayerRemoving:Connect(function(p)
	if ESPObjects[p] then for _, d in pairs(ESPObjects[p]) do d:Remove() end ESPObjects[p] = nil end
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
	return head.Position + (vel * math.clamp(d / 100, .1, .5) * .1)
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
		if p.Team == LocalPlayer.Team then for _, d in pairs(o) do d.Visible = false end continue end
		if not ESP.Enabled or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
			for _, d in pairs(o) do d.Visible = false end
		else
			local hrp, head, hum = p.Character.HumanoidRootPart, p.Character:FindFirstChild("Head"), p.Character:FindFirstChild("Humanoid")
			local torso = p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
			if not head or not hum or not torso then for _, d in pairs(o) do d.Visible = false end continue end
			
			local top = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, .5, 0))
			local bottom = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.5, 0))
			local h = math.abs(bottom.Y - top.Y)
			local w = h * .4
			local cx = (top.X + bottom.X) / 2
			
			if ESP.Boxes then
				o.Box.Size = Vector2.new(w, h)
				o.Box.Position = Vector2.new(cx - w/2, top.Y)
				o.Box.Color = ESP.Color
				o.Box.Visible = true
			else o.Box.Visible = false end
			
			if ESP.Names then
				o.Name.Position = Vector2.new(cx, top.Y - 12)
				o.Name.Text = p.Name
				o.Name.Color = ESP.Color
				o.Name.Visible = true
			else o.Name.Visible = false end
			
			if ESP.Health then
				local hh = h * .8
				local hp = math.clamp(hum.Health / hum.MaxHealth, 0, 1)
				o.HealthBg.Size = Vector2.new(2, hh)
				o.HealthBg.Position = Vector2.new(cx - w/2 - 5, top.Y + (h - hh)/2)
				o.HealthBg.Color = Color3.fromRGB(40, 40, 40)
				o.HealthBg.Visible = true
				o.Health.Size = Vector2.new(2, hh * hp)
				o.Health.Position = Vector2.new(cx - w/2 - 5, top.Y + (h - hh)/2 + hh * (1 - hp))
				o.Health.Color = Color3.fromRGB(255 * (1 - hp), 255 * hp, 50)
				o.Health.Visible = true
			else o.Health.Visible = false o.HealthBg.Visible = false end
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and not IsMobile and i.KeyCode == Enum.KeyCode.Insert then ToggleMenu() end end)

print("KN HUB loaded!")
