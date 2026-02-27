-- KN HUB - Professional
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Configs
local Aimbot = {Enabled = false, Smooth = 1, FOV = 250, WallCheck = true, TeamCheck = true}
local ESP = {Enabled = false}
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
Frame.Size = UDim2.new(0, 320, 0, 280)
Frame.Position = UDim2.new(0.5, -160, 0.5, -140)
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.BorderSizePixel = 0
Frame.Active = true
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 8)

local Shadow = Instance.new("ImageLabel", Frame)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://5554236805"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.6

local Title = Instance.new("Frame", Frame)
Title.Size = UDim2.new(1, 0, 0, 38)
Title.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 8)
local TitleFix = Instance.new("Frame", Title)
TitleFix.Size = UDim2.new(1, 0, 0.5, 0)
TitleFix.Position = UDim2.new(0, 0, 0.5, 0)
TitleFix.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local TitleText = Instance.new("TextLabel", Title)
TitleText.Text = "KN HUB"
TitleText.Size = UDim2.new(1, -60, 1, 0)
TitleText.Position = UDim2.new(0, 15, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.TextColor3 = Theme
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 16
TitleText.TextXAlignment = Enum.TextXAlignment.Left

local Close = Instance.new("TextButton", Title)
Close.Size = UDim2.new(0, 28, 0, 28)
Close.Position = UDim2.new(1, -36, 0.5, -14)
Close.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
Close.Text = "×"
Close.TextColor3 = Color3.new(1, 1, 1)
Close.Font = Enum.Font.GothamBold
Close.TextSize = 20
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

local Content = Instance.new("ScrollingFrame", Frame)
Content.Size = UDim2.new(1, -20, 1, -54)
Content.Position = UDim2.new(0, 10, 0, 46)
Content.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Content.BorderSizePixel = 0
Content.ScrollBarThickness = 4
Content.ScrollBarImageColor3 = Theme
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Instance.new("UICorner", Content).CornerRadius = UDim.new(0, 6)

local ListLayout = Instance.new("UIListLayout", Content)
ListLayout.Padding = UDim.new(0, 8)

-- Toggle
local function Toggle(text, default, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, -16, 0, 42)
	f.Position = UDim2.new(0, 8, 0, 0)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -80, 1, 0)
	l.Position = UDim2.new(0, 14, 0, 0)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 13
	l.TextXAlignment = Enum.TextXAlignment.Left
	
	local b = Instance.new("TextButton", f)
	b.Size = UDim2.new(0, 52, 0, 26)
	b.Position = UDim2.new(1, -66, 0.5, -13)
	b.BackgroundColor3 = default and Theme or Color3.fromRGB(60, 60, 60)
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
		TweenService:Create(b, TweenInfo.new(0.15), {BackgroundColor3 = state and Theme or Color3.fromRGB(60, 60, 60)}):Play()
	end)
end

-- Slider
local function Slider(text, min, max, default, suffix, callback)
	local f = Instance.new("Frame", Content)
	f.Size = UDim2.new(1, -16, 0, 58)
	f.Position = UDim2.new(0, 8, 0, 0)
	f.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	Instance.new("UICorner", f).CornerRadius = UDim.new(0, 6)
	
	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Size = UDim2.new(1, -80, 0, 24)
	l.Position = UDim2.new(0, 14, 0, 6)
	l.BackgroundTransparency = 1
	l.TextColor3 = Color3.new(1, 1, 1)
	l.Font = Enum.Font.Gotham
	l.TextSize = 12
	
	local v = Instance.new("TextLabel", f)
	v.Text = tostring(default) .. suffix
	v.Size = UDim2.new(0, 60, 0, 24)
	v.Position = UDim2.new(1, -70, 0, 6)
	v.BackgroundTransparency = 1
	v.TextColor3 = Theme
	v.Font = Enum.Font.GothamBold
	v.TextSize = 12
	
	local r = Instance.new("Frame", f)
	r.Size = UDim2.new(1, -28, 0, 6)
	r.Position = UDim2.new(0, 14, 1, -20)
	r.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Instance.new("UICorner", r).CornerRadius = UDim.new(1, 0)
	
	local fl = Instance.new("Frame", r)
	fl.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
	fl.BackgroundColor3 = Theme
	Instance.new("UICorner", fl).CornerRadius = UDim.new(1, 0)
	
	local k = Instance.new("Frame", r)
	k.Size = UDim2.new(0, 16, 0, 16)
	k.Position = UDim2.new((default - min) / (max - min), -8, 0.5, -8)
	k.BackgroundColor3 = Color3.new(1, 1, 1)
	Instance.new("UICorner", k).CornerRadius = UDim.new(1, 0)
	
	local g = false
	local function u(i)
		local p = math.clamp((i.Position.X - r.AbsolutePosition.X) / r.AbsoluteSize.X, 0, 1)
		local val = math.floor(min + (p * (max - min)))
		fl.Size = UDim2.new(p, 0, 1, 0)
		k.Position = UDim2.new(p, -8, 0.5, -8)
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

-- ESP - Caixas 2D vermelhas (funcionando)
local ESPBoxes = {}

function CreateESP(p)
	if p == LocalPlayer then return end
	ESPBoxes[p] = Drawing.new("Square")
	ESPBoxes[p].Thickness = 1.5
	ESPBoxes[p].Filled = false
	ESPBoxes[p].Color = Color3.fromRGB(255, 80, 80)
	ESPBoxes[p].Transparency = 1
end

for _, p in pairs(Players:GetPlayers()) do CreateESP(p) end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(function(p)
	if ESPBoxes[p] then
		ESPBoxes[p]:Remove()
		ESPBoxes[p] = nil
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
	
	-- ESP
	for p, box in pairs(ESPBoxes) do
		-- Só inimigos
		if p.Team == LocalPlayer.Team then 
			box.Visible = false
			continue 
		end
		
		if not ESP.Enabled or not p.Character then
			box.Visible = false
		else
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			local head = p.Character:FindFirstChild("Head")
			local hum = p.Character:FindFirstChild("Humanoid")
			
			if not hrp or not head or not hum or hum.Health <= 0 then
				box.Visible = false
			else
				local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
				local footPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
				
				if headPos.Z then
					local h = math.abs(footPos.Y - headPos.Y)
					local w = h * 0.5
					
					box.Size = Vector2.new(w, h)
					box.Position = Vector2.new(headPos.X - w/2, headPos.Y)
					box.Visible = true
				else
					box.Visible = false
				end
			end
		end
	end
end)

UserInputService.InputBegan:Connect(function(i, g) if not g and not IsMobile and i.KeyCode == Enum.KeyCode.Insert then ToggleMenu() end end)

print("KN HUB loaded!")
