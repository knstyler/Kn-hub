local P,R,U,T=game:GetService("Players"),game:GetService("RunService"),game:GetService("UserInputService"),game:GetService("TweenService")
local L,C,V=P.LocalPlayer,workspace.CurrentCamera,game:GetService("VirtualUser")
local M=U.TouchEnabled and not U.KeyboardEnabled

-- Config: Aimbot FORTE, ESP profissional (só próximo)
local A={E=false,S=1.0,F=250,W=true,T=true,Y=true,H="Head"}
local E={E=false,B=true,N=true,H=true,D=100} -- D=distância máxima
local K=Color3.fromRGB(0,170,255)

-- Toggle Button
local G=Instance.new("ScreenGui",L:WaitForChild("PlayerGui"))
G.ResetOnSpawn=false
local B=Instance.new("TextButton",G)
B.Size=M and UDim2.new(0,50,0,50) or UDim2.new(0,40,0,40)
B.Position=UDim2.new(0,10,0,10)
B.BackgroundColor3=K
B.Text="KN"
B.TextColor3=Color3.new(1,1,1)
B.Font=Enum.Font.GothamBold
B.TextSize=M and 16 or 14
B.Active=true
Instance.new("UICorner",B).CornerRadius=UDim.new(1,0)

-- Main GUI
local S=Instance.new("ScreenGui",L:WaitForChild("PlayerGui"))
S.Enabled=false
S.ResetOnSpawn=false
local F=Instance.new("Frame",S)
F.Size=M and UDim2.new(0,300,0,200) or UDim2.new(0,340,0,240)
F.Position=UDim2.new(0.5,-F.Size.X.Offset/2,0.5,-F.Size.Y.Offset/2)
F.BackgroundColor3=Color3.fromRGB(0,0,0)
F.BorderSizePixel=0
F.Active=true
Instance.new("UICorner",F).CornerRadius=UDim.new(0,6)

-- Title
local X=Instance.new("Frame",F)
X.Size=UDim2.new(1,0,0,32)
X.BackgroundColor3=Color3.fromRGB(20,20,20)
Instance.new("UICorner",X).CornerRadius=UDim.new(0,6)
local Tf=Instance.new("Frame",X)
Tf.Size=UDim2.new(1,0,0.5,0)
Tf.Position=UDim2.new(0,0,0.5,0)
Tf.BackgroundColor3=Color3.fromRGB(20,20,20)

local Ti=Instance.new("TextLabel",X)
Ti.Text="KN HUB"
Ti.Size=UDim2.new(1,-50,1,0)
Ti.Position=UDim2.new(0,10,0,0)
Ti.BackgroundTransparency=1
Ti.TextColor3=K
Ti.Font=Enum.Font.GothamBold
Ti.TextSize=13
Ti.TextXAlignment=Enum.TextXAlignment.Left

-- Close
local Z=Instance.new("TextButton",X)
Z.Size=UDim2.new(0,22,0,22)
Z.Position=UDim2.new(1,-28,0.5,-11)
Z.BackgroundColor3=Color3.fromRGB(200,50,50)
Z.Text="×"
Z.TextColor3=Color3.new(1,1,1)
Z.Font=Enum.Font.GothamBold
Z.TextSize=14
Instance.new("UICorner",Z).CornerRadius=UDim.new(0,4)

-- Content
local Y=Instance.new("Frame",F)
Y.Size=UDim2.new(1,-10,1,-38)
Y.Position=UDim2.new(0,5,0,33)
Y.BackgroundColor3=Color3.fromRGB(10,10,10)
Instance.new("UICorner",Y).CornerRadius=UDim.new(0,4)

local W=Instance.new("ScrollingFrame",Y)
W.Size=UDim2.new(1,-10,1,-10)
W.Position=UDim2.new(0,5,0,5)
W.BackgroundTransparency=1
W.ScrollBarThickness=4
W.ScrollBarImageColor3=K
W.AutomaticCanvasSize=Enum.AutomaticSize.Y
Instance.new("UIListLayout",W).Padding=UDim.new(0,5)

-- Toggle Function
local function Tg(t,d,c)
    local f=Instance.new("Frame",W)
    f.Size=UDim2.new(1,0,0,36)
    f.BackgroundColor3=Color3.fromRGB(25,25,25)
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,3)
    
    local l=Instance.new("TextLabel",f)
    l.Text=t
    l.Size=UDim2.new(1,-60,1,0)
    l.Position=UDim2.new(0,10,0,0)
    l.BackgroundTransparency=1
    l.TextColor3=Color3.new(1,1,1)
    l.Font=Enum.Font.Gotham
    l.TextSize=12
    l.TextXAlignment=Enum.TextXAlignment.Left
    
    local s=Instance.new("TextButton",f)
    s.Size=UDim2.new(0,40,0,20)
    s.Position=UDim2.new(1,-50,0.5,-10)
    s.BackgroundColor3=d and K or Color3.fromRGB(50,50,50)
    s.Text=d and"ON"or"OFF"
    s.TextColor3=Color3.new(1,1,1)
    s.Font=Enum.Font.GothamBold
    s.TextSize=10
    s.AutoButtonColor=false
    Instance.new("UICorner",s).CornerRadius=UDim.new(0,3)
    
    local e=d
    s.MouseButton1Click:Connect(function()
        e=not e
        c(e)
        s.Text=e and"ON"or"OFF"
        T:Create(s,TweenInfo.new(.15),{BackgroundColor3=e and K or Color3.fromRGB(50,50,50)}):Play()
    end)
end

-- Slider Function
local function Sl(t,m,x,d,s,c)
    local f=Instance.new("Frame",W)
    f.Size=UDim2.new(1,0,0,48)
    f.BackgroundColor3=Color3.fromRGB(25,25,25)
    Instance.new("UICorner",f).CornerRadius=UDim.new(0,3)
    
    local l=Instance.new("TextLabel",f)
    l.Text=t
    l.Size=UDim2.new(1,-55,0,18)
    l.Position=UDim2.new(0,10,0,5)
    l.BackgroundTransparency=1
    l.TextColor3=Color3.new(1,1,1)
    l.Font=Enum.Font.Gotham
    l.TextSize=11
    
    local v=Instance.new("TextLabel",f)
    v.Text=tostring(d)..s
    v.Size=UDim2.new(0,45,0,18)
    v.Position=UDim2.new(1,-50,0,5)
    v.BackgroundTransparency=1
    v.TextColor3=K
    v.Font=Enum.Font.GothamBold
    v.TextSize=11
    
    local r=Instance.new("Frame",f)
    r.Size=UDim2.new(1,-20,0,4)
    r.Position=UDim2.new(0,10,1,-12)
    r.BackgroundColor3=Color3.fromRGB(40,40,40)
    Instance.new("UICorner",r).CornerRadius=UDim.new(1,0)
    
    local fl=Instance.new("Frame",r)
    fl.Size=UDim2.new((d-m)/(x-m),0,1,0)
    fl.BackgroundColor3=K
    Instance.new("UICorner",fl).CornerRadius=UDim.new(1,0)
    
    local k=Instance.new("Frame",r)
    k.Size=UDim2.new(0,10,0,10)
    k.Position=UDim2.new((d-m)/(x-m),-5,0.5,-5)
    k.BackgroundColor3=Color3.new(1,1,1)
    Instance.new("UICorner",k).CornerRadius=UDim.new(1,0)
    
    local g=false
    local function u(input)
        local pos=math.clamp((input.Position.X-r.AbsolutePosition.X)/r.AbsoluteSize.X,0,1)
        local val=math.floor(m+(pos*(x-m)))
        fl.Size=UDim2.new(pos,0,1,0)
        k.Position=UDim2.new(pos,-5,0.5,-5)
        v.Text=tostring(val)..s
        c(val)
    end
    
    r.InputBegan:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            g=true
            u(i)
        end
    end)
    
    U.InputChanged:Connect(function(i)
        if g and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
            u(i)
        end
    end)
    
    U.InputEnded:Connect(function(i)
        if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
            g=false
        end
    end)
end

-- UI Elements
Tg("Aimbot",false,function(v)A.E=v end)
Tg("Team Check",true,function(v)A.T=v end)
Tg("Wall Check",true,function(v)A.W=v end)
Sl("FOV",50,500,250,"px",function(v)A.F=v end)
Sl("Aim Speed",1,100,100,"%",function(v)A.S=v/100 end)
Tg("ESP",false,function(v)E.E=v end)
Tg("Boxes",true,function(v)E.B=v end)
Tg("Names",true,function(v)E.N=v end)
Tg("Health",true,function(v)E.H=v end)
Sl("ESP Range",10,200,100,"m",function(v)E.D=v end)

-- Toggle GUI
local O=false
local function Q()
    O=not O
    S.Enabled=O
    B.Text=O and"✓"or"KN"
    B.BackgroundColor3=O and Color3.fromRGB(0,255,100)or K
end

B.MouseButton1Click:Connect(Q)
Z.MouseButton1Click:Connect(Q)

-- Draggable
local D,SP=false,nil
X.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        D=true
        SP=i.Position-F.AbsolutePosition
    end
end)
U.InputChanged:Connect(function(i)
    if D and(i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch)then
        F.Position=UDim2.new(0,i.Position.X-SP.X,0,i.Position.Y-SP.Y)
    end
end)
U.InputEnded:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
        D=false
    end
end)

-- FOV Circle
local O1=Drawing.new("Circle")
O1.Transparency=.5
O1.Thickness=2
O1.Filled=false
O1.NumSides=64

-- ESP PROFISSIONAL - Caixas do tamanho exato do personagem, 1.5px fina
local J={}
local function N(p)
    if p==L then return end
    J[p]={
        Box=Drawing.new("Square"),
        Name=Drawing.new("Text"),
        Dist=Drawing.new("Text"),
        HealthBar=Drawing.new("Square"),
        HealthBg=Drawing.new("Square")
    }
    local o=J[p]
    
    -- Box fina 1.5px (só borda, tamanho exato do personagem)
    o.Box.Thickness=1.5
    o.Box.Filled=false
    o.Box.Transparency=1
    
    -- Texto limpo
    o.Name.Size=10
    o.Name.Center=true
    o.Name.Outline=true
    
    o.Dist.Size=9
    o.Dist.Center=true
    o.Dist.Outline=true
    
    -- Health bar fina
    o.HealthBar.Thickness=1
    o.HealthBar.Filled=true
    o.HealthBg.Thickness=1
    o.HealthBg.Filled=true
end

for _,p in pairs(P:GetPlayers())do N(p)end
P.PlayerAdded:Connect(N)
P.PlayerRemoving:Connect(function(p)
    if J[p]then
        for _,d in pairs(J[p])do d:Remove()end
        J[p]=nil
    end
end)

-- Aimbot
local function Gt()
    local n,d,ce=nil,math.huge,C.ViewportSize/2
    for _,p in pairs(P:GetPlayers())do
        if p~=L and p.Character then
            local h,hi=p.Character:FindFirstChild("Humanoid"),p.Character:FindFirstChild(A.H)
            if h and h.Health>0 and hi then
                if A.T and p.Team==L.Team then continue end
                
                local po,on=C:WorldToViewportPoint(hi.Position)
                if on then
                    local m=(Vector2.new(po.X,po.Y)-ce).Magnitude
                    if m<A.F and m<d then
                        if A.W then
                            local rp=RaycastParams.new()
                            rp.FilterDescendantsInstances={L.Character}
                            local r=workspace:Raycast(C.CFrame.Position,(hi.Position-C.CFrame.Position)*1.1,rp)
                            if r and not r.Instance:IsDescendantOf(p.Character)then continue end
                        end
                        d,m,n=m,m,p
                    end
                end
            end
        end
    end
    return n
end

local function Pr(t)
    if not A.Y then return t.Character[A.H].Position end
    local h,v=t.Character[A.H],t.Character:FindFirstChild("HumanoidRootPart")and t.Character.HumanoidRootPart.Velocity or Vector3.new()
    local d=(h.Position-C.CFrame.Position).Magnitude
    return h.Position+(v*math.clamp(d/100,.1,.5)*0.1)
end

-- Main Loop
R.RenderStepped:Connect(function()
    local t,ce=Gt(),C.ViewportSize/2
    O1.Position=ce
    O1.Radius=A.F
    O1.Visible=A.E
    O1.Color=t and Color3.fromRGB(0,255,100)or K
    
    -- Aimbot FORTE
    if A.E and t then
        local p=Pr(t)
        C.CFrame=CFrame.new(C.CFrame.Position,p)
    end
    
    -- ESP: Caixas do tamanho exato do personagem inimigo
    for p,o in pairs(J)do
        -- Só inimigos
        if p.Team==L.Team then
            for _,d in pairs(o)do d.Visible=false end
            continue
        end
        
        if not E.E or not p.Character or not p.Character:FindFirstChild("HumanoidRootPart")then
            for _,d in pairs(o)do d.Visible=false end
        else
            local hrp=p.Character.HumanoidRootPart
            local head=p.Character:FindFirstChild("Head")
            local hum=p.Character:FindFirstChild("Humanoid")
            local torso=p.Character:FindFirstChild("UpperTorso") or p.Character:FindFirstChild("Torso")
            
            if not head or not hum or not torso then
                for _,d in pairs(o)do d.Visible=false end
                continue
            end
            
            local dist=(hrp.Position-C.CFrame.Position).Magnitude
            
            -- SÓ MOSTRA SE ESTIVER PRÓXIMO (dentro do range)
            if dist > E.D then
                for _,d in pairs(o)do d.Visible=false end
                continue
            end
            
            -- Calcular posições exatas dos pontos do personagem
            local headPos=C:WorldToViewportPoint(head.Position)
            local rootPos=C:WorldToViewportPoint(hrp.Position)
            local torsoPos=C:WorldToViewportPoint(torso.Position)
            
            -- Calcular tamanho baseado nos bounds reais do personagem
            local characterHeight = (head.Position - hrp.Position).Magnitude * 2.5
            local characterWidth = 3 -- Largura padrão de um personagem Roblox
            
            -- Projetar para viewport
            local topPoint = C:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
            local bottomPoint = C:WorldToViewportPoint(hrp.Position - Vector3.new(0, 2.5, 0))
            
            -- Calcular largura proporcional à altura (aspect ratio do personagem)
            local heightInPixels = math.abs(bottomPoint.Y - topPoint.Y)
            local widthInPixels = heightInPixels * 0.4 -- Proporção realista do corpo
            
            local centerX = rootPos.X
            local topY = topPoint.Y
            local bottomY = bottomPoint.Y
            
            local co=Color3.fromRGB(255,80,80)
            local fade=math.clamp(1-(dist/E.D),0.4,1)
            
            -- Box EXATA do tamanho do personagem, 1.5px fina
            if E.B then
                o.Box.Size=Vector2.new(widthInPixels, heightInPixels)
                o.Box.Position=Vector2.new(centerX - widthInPixels/2, topY)
                o.Box.Color=co
                o.Box.Transparency=fade
                o.Box.Visible=true
            else
                o.Box.Visible=false
            end
            
            -- Nome (acima da cabeça)
            if E.N and dist < E.D*0.8 then
                o.Name.Position=Vector2.new(centerX, topY - 15)
                o.Name.Text=p.Name
                o.Name.Color=co
                o.Name.Transparency=fade
                o.Name.Visible=true
            else
                o.Name.Visible=false
            end
            
            -- Distância (embaixo da caixa)
            o.Dist.Position=Vector2.new(centerX, bottomY + 5)
            o.Dist.Text=math.floor(dist).."m"
            o.Dist.Color=Color3.fromRGB(200,200,200)
            o.Dist.Transparency=fade
            o.Dist.Visible=true
            
            -- Health bar fina na lateral esquerda da caixa
            if E.H then
                local barH=heightInPixels * 0.8
                local barW=2
                local barX=centerX - widthInPixels/2 - 6
                local barY=topY + (heightInPixels - barH)/2
                
                local hp=math.clamp(hum.Health/hum.MaxHealth,0,1)
                
                o.HealthBg.Size=Vector2.new(barW, barH)
                o.HealthBg.Position=Vector2.new(barX, barY)
                o.HealthBg.Color=Color3.fromRGB(40,40,40)
                o.HealthBg.Transparency=fade
                o.HealthBg.Visible=true
                
                o.HealthBar.Size=Vector2.new(barW, barH * hp)
                o.HealthBar.Position=Vector2.new(barX, barY + barH * (1 - hp))
                o.HealthBar.Color=Color3.fromRGB(255*(1-hp), 255*hp, 50)
                o.HealthBar.Transparency=fade
                o.HealthBar.Visible=true
            else
                o.HealthBar.Visible=false
                o.HealthBg.Visible=false
            end
        end
    end
end)

-- Hotkey
U.InputBegan:Connect(function(i,g)
    if not g and not M and i.KeyCode==Enum.KeyCode.Insert then
        Q()
    end
end)

print("KN HUB v3.1 - ESP Caixa Exata (1.5px) + Aimbot Forte!")
