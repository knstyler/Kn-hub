-- KN HUB - Aimbot + ESP
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
Frame.Size = UDim2.new(0, 280, 0, 180)
Frame.Position = UDim2.new(0.5, -140, 0.5, -90)
Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 6)

local Title = Instance.new("Frame", Frame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 6)

Instance.new("TextLabel", Title).Text = "KN HUB"
Instance.new("TextLabel", Title).Size = UDim2.new(1, -40, 1, 0)
Instance.new("TextLabel", Title).Position = UDim2.new(0, 10, 0, 0)
Instance.new("TextLabel", Title).BackgroundTransparency = 1
Instance.new("TextLabel", Title).TextColor3 = Theme
Instance.new("TextLabel", Title).Font = Enum.Font.GothamBold
Instance.new("TextLabel", Title).TextSize = 12
Instance.new("TextLabel", Title).TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 20, 0, 20)
Close.Position = UDim2.new(1, -25, 0.5, -10)
Close.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 4)

local Content = Instance.new("ScrollingFrame", Frame)
Content.Size = UDim2.new(1, -10, 1, -35)
Content.Position = UDim2.new(0, 5, 0, 32)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 3
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UIListLayout", Content).Padding = UDim.new(0, 4)

-- Toggle creator
local function Toggle(text, default, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 32)
	f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
	
	Instance.new("TextLabel", f).Text = text
	Instance.new("TextLabel", f).Size = UDim2.new(1, -50, 1, 0)
	Instance.new("TextLabel", f).Position = UDim2.new(0, 8, 0, 0)
	Instance.new("TextLabel", f).BackgroundTransparency = 1
	Instance.new("TextLabel", f).TextColor3 = Color3.new(1, 1, 1)
	Instance.new("TextLabel", f).Font = Enum.Font.Gotham
	Instance.new("TextLabel", f).TextSize = 11
	Instance.new("TextLabel", f).TextXAlignment = Enum.TextXAlignment.Left
	
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0, 36, 0, 18)
	b.Position = UDim2.new(1, -42, 0.5, -9)
	b.BackgroundColor3 = default and Theme or Color3.fromRGB(50, 50, 50)
	b.Text = default and "ON" or "OFF"
	b.TextColor3 = Color3.new(1, 1, 1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 9
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 3)
	
	local state = default
	b.MouseButton1Click:Connect(function()
		state = not state
		callback(state)
		b.Text = state and "ON" or "OFF"
		TweenService:Create(b, TweenInfo.new(.15), {BackgroundColor3 = state and Theme or Color3.fromRGB(50, 50, 50)}):Play()
	end)
end

-- Slider creator
local function Slider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, 0, 0, 42)
	f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 3)
	
	Instance.new("TextLabel", f).Text = text
	Instance.new("TextLabel", f).Size = UDim2.new(1, -50, 0, 16)
	Instance.new("TextLabel", f).Position = UDim2.new(0, 8, 0, 4)
	Instance.new("TextLabel", f).BackgroundTransparency = 1
	Instance.new("TextLabel", f).TextColor3 = Color3.new(1, 1, 1)
	Instance.new("TextLabel", f).Font = Enum.Font.Gotham
	Instance.new("TextLabel", f).TextSize = 10
	
	local val = Instance.new("TextLabel", f)
	val.Text = tostring(default) .. suffix
	val.Size = UDim2.new(0, 40, 0, 16)
	val.Position = UDim2.new(1, -45, 0, 4)
	val.BackgroundTransparency = 1
	val.TextColor3 = Theme
	val.Font = Enum.Font.GothamBold
	val.TextSize = 10
	
	local track = Instance.new("Frame", f)
	track.Size = UDim2.new(1, -16, 0, 3)
	track.Position = UDim2.new(0, 8, 1, -10)
	track.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)
	
	local fill = Instance.new("Frame", track)
	fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fill.BackgroundColor3 = Theme
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
	
	local knob = Instance.new("Frame", track)
	knob.Size = UDim2.new(0, 8, 0, 8)
	knob.Position = UDim2.new((default - min) / (max - min), -4, 0.5, -4)
	knob.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
	
	local dragging = false
	local function update(input)
		local pos = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
		local v = math.floor(min + (pos * (max - min)))
		fill.Size = UDim2.new(pos, 0, 1, 0)
		knob.Position = UDim2.new(pos, -4, 0.5, -4)
		val.Text = tostring(v) .. suffix
		callback(v)
	end
	
	track.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = true update(i) end end)
	UserInputService.InputChanged:Connect(function(i) if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then update(i) end end)
	UserInputService.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then dragging = false end end)
end

-- Add controls
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

-- Drag menu
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

-- ESP System
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
