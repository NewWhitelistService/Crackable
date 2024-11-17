--[[

▒██   ██▒ ██▀███   ██▓ ▒█████  
▒▒ █ █ ▒░▓██ ▒ ██▒▓██▒▒██▒  ██▒
░░  █   ░▓██ ░▄█ ▒▒██▒▒██░  ██▒
 ░ █ █ ▒ ▒██▀▀█▄  ░██░▒██   ██░
▒██▒ ▒██▒░██▓ ▒██▒░██░░ ████▓▒░
▒▒ ░ ░▓ ░░ ▒▓ ░▒▓░░▓  ░ ▒░▒░▒░ 
░░   ░▒ ░  ░▒ ░ ▒░ ▒ ░  ░ ▒ ▒░ 
 ░    ░    ░░   ░  ▒ ░░ ░ ░ ▒  
 ░    ░     ░      ░      ░ ░  

--]]


--[[

 ▄▄▄     ▄▄▄█████▓▄▄▄█████▓▓█████  ███▄    █ ▄▄▄█████▓ ██▓ ▒█████   ███▄    █ 
▒████▄   ▓  ██▒ ▓▒▓  ██▒ ▓▒▓█   ▀  ██ ▀█   █ ▓  ██▒ ▓▒▓██▒▒██▒  ██▒ ██ ▀█   █ 
▒██  ▀█▄ ▒ ▓██░ ▒░▒ ▓██░ ▒░▒███   ▓██  ▀█ ██▒▒ ▓██░ ▒░▒██▒▒██░  ██▒▓██  ▀█ ██▒
░██▄▄▄▄██░ ▓██▓ ░ ░ ▓██▓ ░ ▒▓█  ▄ ▓██▒  ▐▌██▒░ ▓██▓ ░ ░██░▒██   ██░▓██▒  ▐▌██▒
 ▓█   ▓██▒ ▒██▒ ░   ▒██▒ ░ ░▒████▒▒██░   ▓██░  ▒██▒ ░ ░██░░ ████▓▒░▒██░   ▓██░
 ▒▒   ▓▒█░ ▒ ░░     ▒ ░░   ░░ ▒░ ░░ ▒░   ▒ ▒   ▒ ░░   ░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ 
  ▒   ▒▒ ░   ░        ░     ░ ░  ░░ ░░   ░ ▒░    ░     ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░
  ░   ▒    ░        ░         ░      ░   ░ ░   ░       ▒ ░░ ░ ░ ▒     ░   ░ ░ 
      ░  ░                    ░  ░         ░           ░      ░ ░           ░ 
      
 **-- ATTENTION SKIDDERS --**  
This project was created by XR10 and contributors. Unauthorized copying, pasting, or modifying without proper credit is highly discouraged.  

If you're here to "skim and skid" content, please consider learning and creating your own work instead. Respect the effort and time put into developing this project.

]]--
do
local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}

local Detected, Kill

setthreadidentity(2)
--LPH_NO_VIRTUALIZE(function()
for i, v in getgc(true) do
    if typeof(v) == "table" then
        local DetectFunc = rawget(v, "Detected")
        local KillFunc = rawget(v, "Kill")
    
        if typeof(DetectFunc) == "function" and not Detected then
            Detected = DetectFunc
            
            local Old; Old = hookfunction(Detected, function(Action, Info, NoCrash)
                if Action ~= "_" then
                    if DEBUG then
                        warn(`Adonis AntiCheat flagged\nMethod: {Action}\nInfo: {Info}`)
                    end
                end
                
                return true
            end)

            table.insert(Hooked, Detected)
        end

        if rawget(v, "Variables") and rawget(v, "Process") and typeof(KillFunc) == "function" and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, function(Info)
                if DEBUG then
                    warn(`Adonis AntiCheat tried to kill (fallback): {Info}`)
                end
            end)

            table.insert(Hooked, Kill)
        end
    end
end

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...

    if Detected and LevelOrFunc == Detected then
        if DEBUG then
            warn(`Adonis Bypassed!`)
        end

        return coroutine.yield(coroutine.running())
    end
    
    return Old(...)
end))
--end)()
-- setthreadidentity(9)
setthreadidentity(7)
end

    --// Services
    local Debris = game:GetService('Debris')
    local EtherealParts = Instance.new('Folder', workspace)
    EtherealParts.Name  = 'EtherealParts'
    local Players = game:GetService("Players")
    local UserInputService = game:GetService("UserInputService")
    local Workspace = game:GetService("Workspace")
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")
    local TweenService = game:GetService("TweenService")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local CC = Workspace.CurrentCamera
    --// Variables
    local LocalPlayer = Players.LocalPlayer
    local Camera = Workspace:FindFirstChildWhichIsA("Camera")
    local Hitsounds = {}

    --// Script Table
    local XrgeTables = {
        Functions = {},
        Folders = {},
        Parts = {},
        Locals = {
            Target = nil,
            IsTargetting = false,
            Resolver = {
                OldTick = os.clock(),
                OldPos = Vector3.new(0, 0, 0),
                ResolvedVelocity = Vector3.new(0, 0, 0)
            },
            AutoSelectTick = tick(),
            AntiAimViewer = {
                MouseRemoteFound = false,
                MouseRemote = nil,
                MouseRemoteArgs = nil,
                MouseRemotePositionIndex = nil
            },
            HitEffect = {
                ["Bubble"] = nil,
                ["Crescent Slash"] = nil,
                ["Crescent Slash"] = nil,
                ["Cum"] = nil,
                ["Explosion"] = nil,
                ["Slash"] = nil,
                ["Atomic Effects"] = nil,
            },
            Gun = {
                PreviousGun = nil,
                PreviousAmmo = 999,
                Shotguns = {"[Double-Barrel SG]", "[TacticalShotgun]", "[Shotgun]"}
            },
            PlayerHealth = {},
            JumpOffset = 0,
            BulletPath = {
                [4312377180] = Workspace:FindFirstChild("MAP") and Workspace.MAP:FindFirstChild("Ignored") or nil,
                [1008451066] = Workspace:FindFirstChild("Ignored") and Workspace.Ignored:FindFirstChild("Siren") and Workspace.Ignored.Siren:FindFirstChild("Radius") or nil,
                [3985694250] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [5106782457] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [4937639028] = Workspace and Workspace:FindFirstChild("Ignored") or nil,
                [1958807588] = Workspace and Workspace:FindFirstChild("Ignored") or nil
            },
            World = {
                FogColor = Lighting.FogColor,
                FogStart = Lighting.FogStart,
                FogEnd = Lighting.FogEnd,
                Ambient = Lighting.Ambient,
                Brightness = Lighting.Brightness,
                ClockTime = Lighting.ClockTime,
                ExposureCompensation = Lighting.ExposureCompensation
            },
            SavedCFrame = nil,
            NetworkPreviousTick = tick(),
            NetworkShouldSleep = false,
            FFlags = {
      }
            ,OriginalVelocity = {},
            RotationAngle = 0
        },
        Utility = {
            Drawings = {},
            EspCache = {}
        },
        Connections = {
            GunConnections = {}
        },
        AuraIgnoreFolder = Instance.new("Folder", game:GetService("Workspace"))
    }

    --// Xrge Table
    local XrgeLol = {
        Combat = {
            Enabled = false,
            Skibidi = false,
            AimPart = "HumanoidRootPart",
            Silent = false,
            BetaAirshot = false,
            TriggerBot = {
                Enabled = false,
                Delay = 0,
                TargeyOnly = false,
                FOV = {
                    Show = true,
                    Size = 80
                }
            },
            TargetInfo = false,
            Camera = false,
            EasingStyle = "Sine",
            EasingDirection = "Out",
            Alerts = true,
            LookAt = false,
            Spectate = false,
            PingBased = false,
            UseIndex = false,
            AntiAimViewer = false,
            AutoSelect = {
                Enabled = false,
                Cooldown = {
                    Enabled = false,
                    Amount = 0.5
                }
            },
            Checks = {
                Enabled = false,
                Knocked = false,
                Crew = false,
                Wall = false,
                Grabbed = false,
                Vehicle = false
            },
            Smoothing = {
                Horizontal = 1,
                Vertical = 1
            },
            Prediction = {
                Horizontal = 0.134,
                Vertical = 0.134
            },
            Resolver = {
                Enabled = false,
                Smoothness = 0.5
            },
            Fov = {
                Visualize = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Radius = 80
            },
            Visuals = {
                Enabled = true,
                Tracer = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Thickness = 2
                },
                Dot = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1),
                    Filled = true,
                    Size = 6
                },
                Chams = {
                    Enabled = false,
                    Fill = {
                        Color = Color3.fromRGB(255,209,220),
                        Transparency = 0.5
                    },
                    Outline = {
                        Color = Color3.new(255,255,255),
                        Transparency = 0
                    }
                }
            },
            Air = {
                Enabled = true,
                AirAimPart = {
                    Enabled = false,
                    HitPart = "LowerTorso"
                },
                JumpOffset = {
                    Enabled = false,
                    Offset = 0
                }
            }
        },
        Visuals = {
            Backtrack = {
                Enabled = true,
                Color = Color3.fromRGB(255,255,255),
                Method = "Folllow",
                Transparency = 0.5,
                Material = "Plastic",
            },
            BulletTracers = {
                Enabled = false,
                Color = {
                    Gradient1 = Color3.new(1, 1, 1),
                    Gradient2 = Color3.new(0, 0, 0)
                },
                Duration = 1,
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            BulletImpacts = {
                Enabled = false,
                Color = Color3.new(1, 1, 1),
                Duration = 1,
                Size = 1,
                Material = "SmoothPlastic",
                Fade = {
                    Enabled = false,
                    Duration = 0.5
                }
            },
            OnHit = {
                Enabled = false,
                Effect = {
                    Enabled = false,
                    Color = Color3.new(1, 1, 1)
                },
                Sound = {
                    Enabled = false,
                    Volume = 5,
                    Value = "hentai4.wav"
                },
                Chams = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    Material = "ForceField",
                    Duration = 1
                }
            },
            World = {
                Enabled = false,
                Fog = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    End = 1000,
                    Start = 10000
                },
                Ambient = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220)
                },
                Brightness = {
                    Enabled = false,
                    Value = 0
                },
                ClockTime = {
                    Enabled = false,
                    Value = 24
                },
                WorldExposure = {
                    Enabled = false,
                    Value = -0.1
                }
            },
            Crosshair = {
                Enabled = false,
                StickToTarget = false,
                Color = Color3.new(1, 1, 1),
                Size = 10,
                Gap = 2,
                Rotation = {
                    Enabled = false,
                    Speed = 1
                }
            }
        },
        AntiAim = {
            XHAHAHAHA = false,
            XHAHAHAHA2 = false,
            XHAHAHAHA3 = false,
            VelocitySpoofer = {
                Enabled = false,
                Visualize = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220),
                    Prediction = 0.134
                },
                Type = "Underground",
                Roll = 0,
                Pitch = 0,
                Yaw = 0
            },
            CSync = {
                Enabled = false,
                Spoof = false,
                Type = "Target Strafe",
                Visualize = {
                    Enabled = false,
                    Color = Color3.fromRGB(255,209,220)
                },
                RandomDistance = 10,
                Custom = {
                    X = 0,
                    Y = 0,
                    Z = 0
                },
                TargetStrafe = {
                    Speed = 1,
                    Distance = 1,
                    Height = 1
                }
            },
            Network = {
                Enabled = false,
                WalkingCheck = false,
                Amount = 0.05
            },
            VelocityDesync = {
                Enabled = false,
                Range = 1
            },
            FFlagDesync = {
                Enabled = false,
                SetNew = false,
                FFlags = {"S2PhysicsSenderRate"}, 
                SetNewAmount = 1,
                Amount = 1
            },
        },
        Misc = {
            Movement = {
                Macro = {
                    Enabled = false,
                    Speed = 0.1,
                },
                Speed = {
                    Enabled = false,
                    Amount = 1
                },
            },
            Exploits = {
                Enabled = false,
                NoRecoil = false,
                NoJumpCooldown = false,
                NoSlowDown = false
            }
        }
    }

local HitEffectsHAHAHHA = "Cum"
local crosshair = loadstring(game:HttpGet("https://pastebin.com/raw/KzkwXZZT"))()
local NEINIGGANEINEI
local WOAHHH
do
local TriggerBotTarget
local TriggerBotFovCircle = Drawing.new("Circle")
TriggerBotFovCircle.Color = Color3.fromRGB(0,245,0)
TriggerBotFovCircle.Visible = XrgeLol.Combat.TriggerBot.FOV.Show and XrgeLol.Combat.TriggerBot.Enabled
TriggerBotFovCircle.Filled = false
TriggerBotFovCircle.Radius = XrgeLol.Combat.TriggerBot.FOV.Size*3
TriggerBotFovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)

function UpdateFOVCuh()
TriggerBotFovCircle.Color = Color3.fromRGB(100,0,0)
TriggerBotFovCircle.Visible = XrgeLol.Combat.TriggerBot.FOV.Show and XrgeLol.Combat.TriggerBot.Enabled
TriggerBotFovCircle.Filled = false
TriggerBotFovCircle.Radius = XrgeLol.Combat.TriggerBot.FOV.Size*3
TriggerBotFovCircle.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
end
local IgnoreList = {LocalPlayer.Character, Camera}
local function PartTrigguhVisible(Part)
    if Part and Part.Head then
        local Hit = workspace:FindPartOnRayWithIgnoreList(
            Ray.new(Camera.CFrame.Position, Part.Head.Position - Camera.CFrame.Position), IgnoreList)
        if Hit and Hit:IsDescendantOf(Part) then
            return true
        end
        return false
    else
        return true
    end
end
local function LocateTheseNiggas()
    local players = game:GetService("Players")
    local localPlayer = players.LocalPlayer
    local closestPlayer
    local closestDistance = math.huge
    for _, player in ipairs(players:GetPlayers()) do
        if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            if not XrgeLol.Combat.TriggerBot.TargetOnly or player == XrgeTables.Locals.Target and XrgeTables.Locals.IsTargetting then
            local part = player.Character.HumanoidRootPart
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local distanceToCenter = (TriggerBotFovCircle.Position - Vector2.new(screenPos.X, screenPos.Y)).Magnitude

                if PartTrigguhVisible(player.Character) and distanceToCenter < closestDistance and distanceToCenter <= TriggerBotFovCircle.Radius then
                    closestPlayer = player
                    closestDistance = distanceToCenter
                end
            end
        end
        end
    end
    return closestPlayer
end

game:GetService("RunService").RenderStepped:Connect(function()
    TriggerBotTarget = LocateTheseNiggas()
    UpdateFOVCuh()
    if XrgeLol.Combat.TriggerBot.Enabled then
    if TriggerBotTarget and LocalPlayer.Character:FindFirstChildWhichIsA("Tool") ~= nil then
    task.wait(XrgeLol.Combat.TriggerBot.Delay)
    LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
    end
    end
end)
end


local ZPred = tonumber(XrgeLol.Combat.Prediction.Horizontal)

local placemarker = Instance.new("Part", game.Workspace)
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        placemarker.Size = Vector3.new(0, 0, 0)
        placemarker.Transparency = 1
    end)
function makemarker(Parent, Adornee, Color, Size, Size2)
    local e = Instance.new("BillboardGui", Parent)
    e.Name = "PP"
    e.Adornee = Adornee
    e.Size = UDim2.new(Size, Size2, Size, Size2)
    e.AlwaysOnTop = true
    local a = Instance.new("Frame", e)
    a.Size = UDim2.new(0.5, 0, 0.5, 0)
    a.BackgroundTransparency = 0
    a.BackgroundColor3 = Color
    local z = Instance.new("UIStroke", a)
    z.Thickness = 1.5
    z.Color = Color3.new(255,255,255)
    local g = Instance.new("UICorner", a)
    g.CornerRadius = UDim.new(30, 30)
    return(e)
end

makemarker(placemarker, placemarker, Color3.fromRGB(255,209,220), 0.8, 0)



    --// Functions
    do
        --// Utility Functions
        do
            XrgeTables.Functions.WorldToScreen = function(Position: Vector3)
                if not Position then return end

                local ViewportPointPosition, OnScreen = Camera:WorldToViewportPoint(Position)
                local ScreenPosition = Vector2.new(ViewportPointPosition.X, ViewportPointPosition.Y)
                return {
                    Position = ScreenPosition,
                    OnScreen = OnScreen
                }
            end

            XrgeTables.Functions.Connection = function(ConnectionType: any, Function: any)
                local Connection = ConnectionType:Connect(Function)
                return Connection
            end

            XrgeTables.Functions.MoveMouse = function(Position: Vector2, SmoothingX: number, SmoothingY: number)
                local MousePosition = UserInputService:GetMouseLocation()

                mousemoverel((Position.X - MousePosition.X) / SmoothingX, (Position.Y - MousePosition.Y) / SmoothingY)
            end

            XrgeTables.Functions.CreateDrawing = function(DrawingType: string, Properties: any)
                local DrawingObject = Drawing.new(DrawingType)

                for Property, Value in pairs(Properties) do
                    DrawingObject[Property] = Value
                end
                return DrawingObject
            end

            XrgeTables.Functions.WallCheck = function(Part: any)
                local RayCastParams = RaycastParams.new()
                RayCastParams.FilterType = Enum.RaycastFilterType.Exclude
                RayCastParams.IgnoreWater = true
                RayCastParams.FilterDescendantsInstances = XrgeTables.AuraIgnoreFolder:GetChildren()

                local CameraPosition = Camera.CFrame.Position
                local Direction = (Part.Position - CameraPosition).Unit
                local RayCastResult = workspace:Raycast(CameraPosition, Direction * 10000, RayCastParams)

                return RayCastResult.Instance and RayCastResult.Instance == Part
            end

            XrgeTables.Functions.Create = function(ObjectType: string, Properties: any)
                local Object = Instance.new(ObjectType)

                for Property, Value in pairs(Properties) do
                    Object[Property] = Value
                end
                return Object
            end

            XrgeTables.Functions.GetGun = function(Player: any)
                local Info = {
                    Tool = nil,
                    Ammo = nil,
                    IsGunEquipped = false
                }

                local Tool = Player.Character:FindFirstChildWhichIsA("Tool")

                if not Tool then return end

                if game.GameId == 1958807588 then
                    local ArmoryGun = Player.Information.Armory:FindFirstChild(Tool.Name)
                    if ArmoryGun then
                        Info.Tool = Tool
                        Info.Ammo = ArmoryGun.Ammo.Normal
                        Info.IsGunEquipped = true
                    else
                        for _, Object in pairs(Tool:GetChildren()) do
                            if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") then
                                Info.Tool = Tool
                                Info.IsGunEquipped = true
                                Info.Ammo = Object
                            end
                        end
                    end
                elseif game.GameId == 3634139746 then
                    for _, Object in pairs(Tool:getdescendants()) do
                        if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") and not Object.Name:lower():find("no") then
                            Info.Tool = Tool
                            Info.Ammo = Object
                            Info.IsGunEquipped = true
                        end
                    end
                else
                    for _, Object in pairs(Tool:GetChildren()) do
                        if Object.Name:lower():find("ammo") and not Object.Name:lower():find("max") then
                            Info.Tool = Tool
                            Info.IsGunEquipped = true
                            Info.Ammo = Object
                        end
                    end
                end


                return Info
            end

            XrgeTables.Functions.Beam = function(StartPos: Vector3, EndPos: Vector3)
                local ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, XrgeLol.Visuals.BulletTracers.Color.Gradient1),
                    ColorSequenceKeypoint.new(1, XrgeLol.Visuals.BulletTracers.Color.Gradient2),
                })
                local Part = Instance.new("Part", XrgeTables.AuraIgnoreFolder)
                Part.Size = Vector3.new(0, 0, 0)
                Part.Massless = true
                Part.Transparency = 1
                Part.CanCollide = false
                Part.Position = StartPos
                Part.Anchored = true
                local Attachment = Instance.new("Attachment", Part)
                local Part2 = Instance.new("Part", XrgeTables.AuraIgnoreFolder)
                Part2.Size = Vector3.new(0, 0, 0)
                Part2.Transparency = 0
                Part2.CanCollide = false
                Part2.Position = EndPos
                Part2.Anchored = true
                Part2.Material = Enum.Material.ForceField
                Part2.Color = Color3.fromRGB(255, 0, 212)
                Part2.Massless = true
                local Attachment2 = Instance.new("Attachment", Part2)
                local Beam = Instance.new("Beam", Part)
                Beam.FaceCamera = true
                Beam.Color = ColorSequence
                Beam.Attachment0 = Attachment
                Beam.Attachment1 = Attachment2
                Beam.LightEmission = 6
                Beam.LightInfluence = 1
                Beam.Width0 = 1.5
                Beam.Width1 = 1.5
                Beam.Texture = "http://www.roblox.com/asset/?id=446111271"
                Beam.TextureSpeed = 2
                Beam.TextureLength = 1
                task.delay(XrgeLol.Visuals.BulletTracers.Duration, function()
                    if XrgeLol.Visuals.BulletTracers.Fade.Enabled then
                        local TweenValue = Instance.new("NumberValue")
                        TweenValue.Parent = Beam
                        local Tween = TweenService:Create(TweenValue, TweenInfo.new(XrgeLol.Visuals.BulletTracers.Fade.Duration), {Value = 1})
                        Tween:Play()

                        local Connection
                        Connection = XrgeTables.Functions.Connection(TweenValue:GetPropertyChangedSignal("Value"), function()
                            Beam.Transparency = NumberSequence.new(TweenValue.Value, TweenValue.Value)
                        end)

                        XrgeTables.Functions.Connection(Tween.Completed, function()
                            Connection:Disconnect()
                            Part:Destroy()
                            Part2:Destroy()
                        end)
                    else
                        Part:Destroy()
                        Part2:Destroy()
                    end
                end)
            end

            XrgeTables.Functions.Impact = function(Pos: Vector3)
                local Part = XrgeTables.Functions.Create("Part", {
                    Parent = XrgeTables.AuraIgnoreFolder,
                    Color = XrgeLol.Visuals.BulletImpacts.Color,
                    Size = Vector3.new(XrgeLol.Visuals.BulletImpacts.Size, XrgeLol.Visuals.BulletImpacts.Size, XrgeLol.Visuals.BulletImpacts.Size),
                    Position = Pos,
                    Anchored = true,
                    Material = Enum.Material[XrgeLol.Visuals.BulletImpacts.Material]
                })

                task.delay(XrgeLol.Visuals.BulletImpacts.Duration, function()
                    if XrgeLol.Visuals.BulletImpacts.Fade.Enabled then
                        local Tween = TweenService:Create(Part, TweenInfo.new(XrgeLol.Visuals.BulletImpacts.Fade.Duration), {Transparency = 1})
                        Tween:Play()

                        XrgeTables.Functions.Connection(Tween.Completed, function()
                            Part:Destroy()
                        end)
                    else
                        Part:Destroy()
                    end
                end)
            end

            XrgeTables.Functions.GetClosestPlayerDamage = function(Position: Vector3, MaxRadius: number)
                local Radius = MaxRadius
                local ClosestPlayer

                for PlayerName, Health in pairs(XrgeTables.Locals.PlayerHealth) do
                    local Player = Players:FindFirstChild(PlayerName)
                    if Player and Player.Character then
                        local PlayerPosition = Player.Character.PrimaryPart.Position
                        local Distance = (Position - PlayerPosition).Magnitude
                        local CurrentHealth = Player.Character.Humanoid.Health
                        if (Distance < Radius) and (CurrentHealth < Health) then
                            Radius = Distance
                            ClosestPlayer = Player
                        end
                    end
                end
                return ClosestPlayer
            end


            XrgeTables.Functions.Effect = function(Part, Color)
                local Clone = XrgeTables.Locals.HitEffect[HitEffectsHAHAHHA]:Clone()
                Clone.Parent = Part

                for _, Effect in pairs(Clone:GetChildren()) do
                    if Effect:IsA("ParticleEmitter") then
                        Effect.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                            ColorSequenceKeypoint.new(0.495, XrgeLol.Visuals.OnHit.Effect.Color),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
                        })
                        Effect:Emit()
                    end
                end

                task.delay(2, function()
                    Clone:Destroy()
                end)
            end

            XrgeTables.Functions.PlaySound = function(SoundId, Volume)
                local Sound = Instance.new("Sound")
                Sound.Parent = XrgeTables.AuraIgnoreFolder
                Sound.Volume = Volume
                Sound.SoundId = SoundId

                Sound:Play()

                XrgeTables.Functions.Connection(Sound.Ended, function()
                    Sound:Destroy()
                end)
            end

            XrgeTables.Functions.Hitcham = function(Player, Color)
      local Character = Player.Character
      local RootPart  = Character and Character:FindFirstChild('HumanoidRootPart')
              Character.Archivable  = true
              local Clone = Character:Clone()
              Clone.Parent = EtherealParts
              Clone.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
              local highlight = Instance.new("Highlight")
              highlight.Parent = Clone
              highlight.FillColor = Color
              highlight.OutlineColor = Color3.fromRGB(255,255,255)
              highlight.OutlineTransparency = 0
              highlight.FillTransparency = 0.5
              highlight.DepthMode = Enum.HighlightDepthMode.Occluded
              highlight.Adornee = Clone
              for _, v in pairs(Clone:GetDescendants()) do
                  if (v:IsA('MeshPart')) then
                      v.Material = Enum.Material.ForceField
                      v.Color = Color
                      v.CanCollide = false
                      v.Anchored = true
                      v.CanQuery = false
                      v.CanTouch = false
                  end
  
                  if (v:IsA('Accessory') or v:IsA('Tool')) then
                      v:Destroy()
                  end
              end
  
              for i,v in pairs(Character:GetDescendants()) do
                  if (v:IsA('MeshPart')) then
                      local ClonePart = Clone:FindFirstChild(v.Name)
  
                      if (ClonePart) then
                          ClonePart.CFrame = v.CFrame
                      end
                  end
              end
  
              Clone:PivotTo(Character.PrimaryPart.CFrame + Vector3.new(LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector.x * 1.5, 0, LocalPlayer.Character.HumanoidRootPart.CFrame.lookVector.z * 1.5))
  
              Character.Archivable = false
              Debris:AddItem(Clone, 2)
            end

            XrgeTables.Functions.Rotate = function(Vector, Origin, Angle)
                local CosA = math.cos(Angle)
                local SinA = math.sin(Angle)
                local X = Vector.X - Origin.X
                local Y = Vector.Y - Origin.Y
                local NewX = X * CosA - Y * SinA
                local NewY = X * SinA + Y * CosA
                return Vector2.new(NewX + Origin.x, NewY + Origin.y)
            end
        end
        --// General Functions
        do
            XrgeTables.Functions.GetClosestPlayerNumbah = function()
                local Radius = XrgeLol.Combat.AutoSelect.Enabled and XrgeLol.Combat.Fov.Radius or math.huge
                local ClosestPlayer
                local Mouse = UserInputService:GetMouseLocation()

                for _, Player in pairs(Players:GetPlayers()) do
                    if Player ~= LocalPlayer then
                        --// Variables
                        local ScreenPosition = XrgeTables.Functions.WorldToScreen(Player.Character.HumanoidRootPart.Position)
                        local Distance = ((workspace.CurrentCamera.ViewportSize * 0.5) - ScreenPosition.Position).Magnitude

                        --// OnScreen Check
                        if not ScreenPosition.OnScreen then continue end

                        --// Checks
                        if (XrgeLol.Combat.Checks.Enabled and (XrgeLol.Combat.Checks.Vehicle and Player.Character:FindFirstChild("[CarHitBox]")) or (XrgeLol.Combat.Checks.Knocked and Player.Character.BodyEffects["K.O"].Value == true) or (XrgeLol.Combat.Checks.Grabbed and Player.Character:FindFirstChild("GRABBING_CONSTRAINT")) or (XrgeLol.Combat.Checks.Crew and Player.DataFolder.Information.Crew.Value == LocalPlayer.DataFolder.Information.Crew.Value) or (XrgeLol.Combat.Checks.Wall and XrgeTables.Functions.WallCheck(Player.Character.PrimaryPart))) then continue end

                        if (Distance <= Radius) then
                            Radius = Distance
                            ClosestPlayer = Player
                        end
                    end
                end

                return ClosestPlayer
            end
            XrgeTables.Functions.GetClosestPlayer = function()
                local Radius = XrgeLol.Combat.AutoSelect.Enabled and XrgeLol.Combat.Fov.Radius or math.huge
                local ClosestPlayer
                local Mouse = UserInputService:GetMouseLocation()

                for _, Player in pairs(Players:GetPlayers()) do
                    if Player ~= LocalPlayer then
                        --// Variables
                        local ScreenPosition = XrgeTables.Functions.WorldToScreen(Player.Character.HumanoidRootPart.Position)
                        local Distance = (Mouse - ScreenPosition.Position).Magnitude

                        --// OnScreen Check
                        if not ScreenPosition.OnScreen then continue end

                        --// Checks
                        if (XrgeLol.Combat.Checks.Enabled and (XrgeLol.Combat.Checks.Vehicle and Player.Character:FindFirstChild("[CarHitBox]")) or (XrgeLol.Combat.Checks.Knocked and Player.Character.BodyEffects["K.O"].Value == true) or (XrgeLol.Combat.Checks.Grabbed and Player.Character:FindFirstChild("GRABBING_CONSTRAINT")) or (XrgeLol.Combat.Checks.Crew and Player.DataFolder.Information.Crew.Value == LocalPlayer.DataFolder.Information.Crew.Value) or (XrgeLol.Combat.Checks.Wall and XrgeTables.Functions.WallCheck(Player.Character.PrimaryPart))) then continue end

                        if (Distance < Radius) then
                            Radius = Distance
                            ClosestPlayer = Player
                        end
                    end
                end

                return ClosestPlayer
            end

            XrgeTables.Functions.GetTargetPredictedPosition = function()
                local BodyPart = XrgeTables.Locals.Target.Character[XrgeLol.Combat.AimPart]
                local Velocity = XrgeLol.Combat.Resolver.Enabled and Vector3.new(XrgeTables.Locals.Resolver.ResolvedVelocity.X*XrgeLol.Combat.Prediction.Horizontal, math.clamp(XrgeTables.Locals.Resolver.ResolvedVelocity.Y,-10,50)*XrgeLol.Combat.Prediction.Vertical,XrgeTables.Locals.Resolver.ResolvedVelocity.Z*ZPred) or Vector3.new(XrgeTables.Locals.Target.Character.HumanoidRootPart.AssemblyLinearVelocity.X*XrgeLol.Combat.Prediction.Horizontal,math.clamp(XrgeTables.Locals.Target.Character.HumanoidRootPart.AssemblyLinearVelocity.Y,-10,50)*XrgeLol.Combat.Prediction.Vertical,XrgeTables.Locals.Target.Character.HumanoidRootPart.AssemblyLinearVelocity.Z*ZPred)
                local Position = BodyPart.CFrame + Velocity

                if XrgeLol.Combat.Air.Enabled and XrgeLol.Combat.Air.JumpOffset.Enabled then
                    Position = Position + Vector3.new(0, XrgeTables.Locals.JumpOffset, 0)
                end
                return Position
            end

            XrgeTables.Functions.Resolve = function()
                if XrgeLol.Combat.Enabled and XrgeLol.Combat.Resolver.Enabled and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target then
                    local function lerp(a, b, t)
                        return a + (b - a) * t
                    end

                    XrgeTables.Locals.Resolver.OldPos = XrgeTables.Locals.Resolver.OldPos
                    XrgeTables.Locals.Resolver.OldTick = XrgeTables.Locals.Resolver.OldTick or os.clock()

                    local CurrentTime = os.clock()
                    task.wait(0.055)
                    local CurrentPosition = XrgeTables.Locals.Target.Character.HumanoidRootPart.Position
                    local NewTime = os.clock()

                    local TimeDifference = NewTime - XrgeTables.Locals.Resolver.OldTick
                    if TimeDifference == 0 then return end

                    local RawVelocity = (CurrentPosition - XrgeTables.Locals.Resolver.OldPos) / TimeDifference

                    XrgeTables.Locals.Resolver.ResolvedVelocity = XrgeTables.Locals.Resolver.ResolvedVelocity or RawVelocity
                    XrgeTables.Locals.Resolver.ResolvedVelocity = lerp(XrgeTables.Locals.Resolver.ResolvedVelocity, RawVelocity, XrgeLol.Combat.Resolver.Smoothness)
                    XrgeTables.Locals.Resolver.OldPos = CurrentPosition
                    XrgeTables.Locals.Resolver.OldTick = NewTime
                end
            end

            XrgeTables.Functions.MouseAim = function()
                if XrgeLol.Combat.Enabled and XrgeLol.Combat.Camera and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target then
                    local LalaPosition = (XrgeTables.Functions.GetTargetPredictedPosition().Position)
                    Smoothness = tonumber(XrgeLol.Combat.Smoothing.Horizontal)
                    LookPosition = CFrame.new(CC.CFrame.p, LalaPosition)
                    CC.CFrame = CC.CFrame:Lerp(LookPosition, Smoothness, Enum.EasingStyle[XrgeLol.Combat.EasingStyle], Enum.EasingDirection[XrgeLol.Combat.EasingDirection])
                end
            end

            XrgeTables.Functions.UpdateFieldOfView = function()
                XrgeTables.Utility.Drawings["FieldOfViewVisualizer"].Visible = XrgeLol.Combat.Enabled and XrgeLol.Combat.AutoSelect.Enabled and XrgeLol.Combat.Fov.Visualize.Enabled
                XrgeTables.Utility.Drawings["FieldOfViewVisualizer"].Filled = false
                XrgeTables.Utility.Drawings["FieldOfViewVisualizer"].Color = XrgeLol.Combat.Fov.Visualize.Color
                XrgeTables.Utility.Drawings["FieldOfViewVisualizer"].Radius = XrgeLol.Combat.Fov.Radius
                XrgeTables.Utility.Drawings["FieldOfViewVisualizer"].Position = workspace.CurrentCamera.ViewportSize * 0.5
            end

            XrgeTables.Functions.DotThingYes = function()
            if XrgeLol.Combat.Enabled and XrgeLol.Combat.Visuals.Enabled and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and XrgeLol.Combat.Visuals.Dot.Enabled then
            placemarker.CFrame = CFrame.new((XrgeTables.Functions.GetTargetPredictedPosition().Position))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
            end

            XrgeTables.Functions.UpdateTargetVisuals = function()
                --// ScreenPosition, Will be changed later
                local Position

                --// Variable to indicate if you"re targetting or not with a check if the target visuals are enabled
                local IsTargetting = XrgeLol.Combat.Enabled and XrgeLol.Combat.Visuals.Enabled and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target or false

                --// Change the position
                if IsTargetting then
                    local PredictedPosition = (XrgeTables.Functions.GetTargetPredictedPosition().Position)
                    Position = XrgeTables.Functions.WorldToScreen(PredictedPosition)
                end

                --// Variable to indicate if the drawing elements should show
                local TracerShow = IsTargetting and XrgeLol.Combat.Visuals.Tracer.Enabled and Position.OnScreen or false
                local DotShow = IsTargetting and crosshair.sticky or false
                local ChamsShow = IsTargetting and XrgeLol.Combat.Visuals.Chams.Enabled and XrgeTables.Locals.Target and XrgeTables.Locals.Target.Character or nil


                --// Set the drawing elements visibility
                XrgeTables.Utility.Drawings["TargetTracer"].Visible = TracerShow
                XrgeTables.Utility.Drawings["TargetDot"].Visible = DotShow
                XrgeTables.Utility.Drawings["TargetChams"].Parent = ChamsShow


                --// Update the drawing elements
                if TracerShow then
                    XrgeTables.Utility.Drawings["TargetTracer"].From = UserInputService:GetMouseLocation()
                    XrgeTables.Utility.Drawings["TargetTracer"].To = Position.Position
                    XrgeTables.Utility.Drawings["TargetTracer"].Color = XrgeLol.Combat.Visuals.Tracer.Color
                    XrgeTables.Utility.Drawings["TargetTracer"].Thickness = XrgeLol.Combat.Visuals.Tracer.Thickness
                end

                if DotShow then
                    crosshair.mode = 'custom'
                    crosshair.position = Position.Position
                else
                    crosshair.mode = "Middle"
                end

                if ChamsShow then
                    XrgeTables.Utility.Drawings["TargetChams"].FillColor = XrgeLol.Combat.Visuals.Chams.Fill.Color
                    XrgeTables.Utility.Drawings["TargetChams"].FillTransparency = XrgeLol.Combat.Visuals.Chams.Fill.Transparency
                    XrgeTables.Utility.Drawings["TargetChams"].OutlineTransparency = XrgeLol.Combat.Visuals.Chams.Outline.Transparency
                    XrgeTables.Utility.Drawings["TargetChams"].OutlineColor = XrgeLol.Combat.Visuals.Chams.Outline.Color
                end
            end

            XrgeTables.Functions.AutoSelect = function()
                if (XrgeLol.Combat.Enabled and XrgeLol.Combat.AutoSelect.Enabled) and (tick() - XrgeTables.Locals.AutoSelectTick >= XrgeLol.Combat.AutoSelect.Cooldown.Amount and XrgeLol.Combat.AutoSelect.Cooldown.Enabled or true) then
                    local NewTarget = XrgeTables.Functions.GetClosestPlayerNumbah()
                    XrgeTables.Locals.Target = NewTarget or nil
                    XrgeTables.Locals.IsTargetting =  NewTarget and true or false
                    XrgeTables.Locals.AutoSelectTick = tick()
                end
            end

            XrgeTables.Functions.GunEvents = function()
                local CurrentGun = XrgeTables.Functions.GetGun(LocalPlayer)
                if CurrentGun and CurrentGun.IsGunEquipped and CurrentGun.Tool then
                    if CurrentGun.Tool ~= XrgeTables.Locals.Gun.PreviousGun then
                        XrgeTables.Locals.Gun.PreviousGun = CurrentGun.Tool
                        XrgeTables.Locals.Gun.PreviousAmmo = 999
                        --// Connections
                        for _, Connection in pairs(XrgeTables.Connections.GunConnections) do
                            Connection:Disconnect()
                        end
                        XrgeTables.Connections.GunConnections = {}
                    end

                    if not XrgeTables.Connections.GunConnections["GunActivated"] and XrgeLol.Combat.Enabled and XrgeLol.Combat.Silent and XrgeTables.Locals.AntiAimViewer.MouseRemoteFound then
                        XrgeTables.Connections.GunConnections["GunActivated"] = XrgeTables.Functions.Connection(CurrentGun.Tool.Activated, function()
                            if XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target then
                                if XrgeLol.Combat.AntiAimViewer then
                                    local Arguments = XrgeTables.Locals.AntiAimViewer.MouseRemoteArgs

                                    Arguments[XrgeTables.Locals.AntiAimViewer.MouseRemotePositionIndex] = (XrgeTables.Functions.GetTargetPredictedPosition().Position)
                                    XrgeTables.Locals.AntiAimViewer.MouseRemote:FireServer(unpack(Arguments))
                                end
                            end
                        end)
                    end
                end
            end

            XrgeTables.Functions.HitShit = function()
            if WOAHHH and NEINIGGANEINEI then
                local NIGGAAA = WOAHHH
                if XrgeLol.Visuals.OnHit.Enabled then
                    local GRAHGRAHGRAHKEEPITASTACK = XrgeTables.Functions.GetClosestPlayerDamage(NIGGAAA[NEINIGGANEINEI], 20)
                    if GRAHGRAHGRAHKEEPITASTACK then
                        if XrgeLol.Visuals.OnHit.Sound.Enabled then
                            local Sound = string.format("hitsounds_stuff/%s", XrgeLol.Visuals.OnHit.Sound.Value)
                            XrgeTables.Functions.PlaySound(getcustomasset(Sound), XrgeLol.Visuals.OnHit.Sound.Volume)
                        end
                        
                        if XrgeLol.Visuals.OnHit.Effect.Enabled then
                            XrgeTables.Functions.Effect(GRAHGRAHGRAHKEEPITASTACK.Character.HumanoidRootPart)
                        end
                        if XrgeLol.Visuals.OnHit.Chams.Enabled then
                            XrgeTables.Functions.Hitcham(GRAHGRAHGRAHKEEPITASTACK, XrgeLol.Visuals.OnHit.Chams.Color)
                        end
                    end
                end
              end
           end

            XrgeTables.Functions.Air = function()
                if XrgeLol.Combat.Enabled and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and XrgeLol.Combat.Air.Enabled then
                    local Humanoid = XrgeTables.Locals.Target.Character.Humanoid

                    if Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                        if XrgeLol.Combat.BetaAirshot then
                        ZPred = 0
                    end
                        XrgeTables.Locals.JumpOffset = XrgeLol.Combat.Air.JumpOffset.Offset
                    else
                        ZPred = XrgeLol.Combat.Prediction.Horizontal
                        XrgeTables.Locals.JumpOffset = 0
                    end
                end
            end

            XrgeTables.Functions.VisualizeMovement = function()
                if XrgeLol.Combat.Skibidi then
                  local Character = LocalPlayer and (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait())
                  local RootPart = Character and Character.HumanoidRootPart
                  local Ball = Instance.new('Part') do
                      Ball.Anchored = true
                      Ball.Size = Vector3.new(0.5, 0.5, 0.5)
                      Ball.Transparency = -0.5
                      Ball.Shape = Enum.PartType.Ball
                      Ball.Color = Color3.fromRGB(255,209,220)
                      Ball.Material = Enum.Material.ForceField
                      Ball.Parent = Workspace
                      Ball.CFrame = RootPart.CFrame
                      Ball.CanCollide = false
                      local highlight = Instance.new("Highlight")
                      highlight.Adornee = Ball
                      highlight.FillColor = Color3.fromRGB(255,209,220)
                      highlight.OutlineColor = Color3.fromRGB(255,255,255)
                      highlight.Parent = Ball
                  end;
                  Debris:AddItem(Ball, 2)
                end
            end

            XrgeTables.Functions.UpdateHealth = function()
                if XrgeLol.Visuals.OnHit.Enabled then
                    for _, Player in pairs(Players:GetPlayers()) do
                        if Player.Character and Player.Character.Humanoid then
                            XrgeTables.Locals.PlayerHealth[Player.Name] = Player.Character.Humanoid.Health
                        end
                    end
                end
            end

            XrgeTables.Functions.UpdateAtmosphere = function()
                Lighting.FogColor = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.Fog.Enabled and XrgeLol.Visuals.World.Fog.Color or XrgeTables.Locals.World.FogColor
                Lighting.FogStart = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.Fog.Enabled and XrgeLol.Visuals.World.Fog.Start or XrgeTables.Locals.World.FogStart
                Lighting.FogEnd = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.Fog.Enabled and XrgeLol.Visuals.World.Fog.End or XrgeTables.Locals.World.FogEnd
                Lighting.Ambient = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.Ambient.Enabled and XrgeLol.Visuals.World.Ambient.Color or XrgeTables.Locals.World.Ambient
                Lighting.Brightness = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.Brightness.Enabled and XrgeLol.Visuals.World.Brightness.Value or XrgeTables.Locals.World.Brightness
                Lighting.ClockTime = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.ClockTime.Enabled and XrgeLol.Visuals.World.ClockTime.Value or XrgeTables.Locals.World.ClockTime
                Lighting.ExposureCompensation = XrgeLol.Visuals.World.Enabled and XrgeLol.Visuals.World.WorldExposure.Enabled and XrgeLol.Visuals.World.WorldExposure.Value or XrgeTables.Locals.World.ExposureCompensation
            end

            XrgeTables.Functions.VelocitySpoof = function()
                local ShowVisualizerDot = XrgeLol.AntiAim.VelocitySpoofer.Enabled and XrgeLol.AntiAim.VelocitySpoofer.Visualize.Enabled

                XrgeTables.Utility.Drawings["VelocityDot"].Visible = ShowVisualizerDot


                if XrgeLol.AntiAim.VelocitySpoofer.Enabled then
                    --// Variables
                    local Type = XrgeLol.AntiAim.VelocitySpoofer.Type
                    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                    local Velocity = HumanoidRootPart.Velocity

                    --// Main
                    if Type == "Underground" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(0, -XrgeLol.AntiAim.VelocitySpoofer.Yaw, 0)
                    elseif Type == "Sky" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(0, XrgeLol.AntiAim.VelocitySpoofer.Yaw, 0)
                    elseif Type == "Multiplier" then
                        HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + Vector3.new(XrgeLol.AntiAim.VelocitySpoofer.Yaw, XrgeLol.AntiAim.VelocitySpoofer.Pitch, XrgeLol.AntiAim.VelocitySpoofer.Roll)
                    elseif Type == "Custom" then
                        HumanoidRootPart.Velocity = Vector3.new(XrgeLol.AntiAim.VelocitySpoofer.Yaw, XrgeLol.AntiAim.VelocitySpoofer.Pitch, XrgeLol.AntiAim.VelocitySpoofer.Roll)
                    elseif Type == "Prediction Breaker" then
                        HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end

                    if ShowVisualizerDot then
                        local ScreenPosition = XrgeTables.Functions.WorldToScreen(LocalPlayer.Character.HumanoidRootPart.Position + LocalPlayer.Character.HumanoidRootPart.Velocity * XrgeLol.AntiAim.VelocitySpoofer.Visualize.Prediction)

                        XrgeTables.Utility.Drawings["VelocityDot"].Position = ScreenPosition.Position
                        XrgeTables.Utility.Drawings["VelocityDot"].Color = XrgeLol.AntiAim.VelocitySpoofer.Visualize.Color
                    end

                    RunService.RenderStepped:Wait()
                    HumanoidRootPart.Velocity = Velocity
                end
            end

            XrgeTables.Functions.CSync = function()
                XrgeTables.Utility.Drawings["CFrameVisualize"].Parent = XrgeLol.AntiAim.CSync.Visualize.Enabled and XrgeLol.AntiAim.CSync.Enabled and XrgeTables.AuraIgnoreFolder or nil

                if XrgeLol.AntiAim.CSync.Enabled then
                    local Type = XrgeLol.AntiAim.CSync.Type
                    local FakeCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    XrgeTables.Locals.SavedCFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                    if Type == "Target Strafe" and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and XrgeLol.Combat.Enabled then
                        local CurrentTime = tick()
                        FakeCFrame = CFrame.new(XrgeTables.Locals.Target.Character.HumanoidRootPart.Position) * CFrame.Angles(0, 2 * math.pi * CurrentTime * XrgeLol.AntiAim.CSync.TargetStrafe.Speed % (2 * math.pi), 0) * CFrame.new(0, XrgeLol.AntiAim.CSync.TargetStrafe.Height, XrgeLol.AntiAim.CSync.TargetStrafe.Distance)
                    elseif Type == "Random Target" and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and XrgeLol.Combat.Enabled then
                        FakeCFrame = CFrame.new(XrgeTables.Locals.Target.Character.HumanoidRootPart.Position + Vector3.new(math.random(-XrgeLol.AntiAim.CSync.RandomDistance, XrgeLol.AntiAim.CSync.RandomDistance), math.random(-0, XrgeLol.AntiAim.CSync.RandomDistance), math.random(-XrgeLol.AntiAim.CSync.RandomDistance, XrgeLol.AntiAim.CSync.RandomDistance))) * CFrame.Angles(math.rad(math.random(0, 360)), math.rad(math.random(0, 360)), math.rad(math.random(0, 360)))
                    end

                    XrgeTables.Utility.Drawings["CFrameVisualize"]:SetPrimaryPartCFrame(FakeCFrame)

                    for _, Part in pairs(XrgeTables.Utility.Drawings["CFrameVisualize"]:GetChildren()) do
                        Part.Color = XrgeLol.AntiAim.CSync.Visualize.Color
                    end
                    LocalPlayer.Character.HumanoidRootPart.CFrame = FakeCFrame
                    RunService.RenderStepped:Wait()
                    if XrgeLol.AntiAim.CSync.Spoof  then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = XrgeTables.Locals.SavedCFrame
                    end
                end
            end

            XrgeTables.Functions.Network = function()
                if XrgeLol.AntiAim.Network.Enabled then
                    if (tick() - XrgeTables.Locals.NetworkPreviousTick) >= ((XrgeLol.AntiAim.Network.Amount / math.pi) / 10000) or (XrgeLol.AntiAim.Network.WalkingCheck and LocalPlayer.Character.Humanoid.MoveDirection.Magnitude > 0) then
                        XrgeTables.Locals.NetworkShouldSleep = not XrgeTables.Locals.NetworkShouldSleep
                        XrgeTables.Locals.NetworkPreviousTick = tick()
                        sethiddenproperty(LocalPlayer.Character.HumanoidRootPart, "NetworkIsSleeping", XrgeTables.Locals.NetworkShouldSleep)
                    end
                end
            end

            XrgeTables.Functions.Speed = function()
                if XrgeLol.Misc.Movement.Speed.Enabled then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + LocalPlayer.Character.Humanoid.MoveDirection * XrgeLol.Misc.Movement.Speed.Amount
                end
            end

            XrgeTables.Functions.VelocityDesync = function()
                if XrgeLol.AntiAim.VelocityDesync.Enabled then
                    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart
                    local Velocity = HumanoidRootPart.Velocity
                    local Amount = XrgeLol.AntiAim.VelocityDesync.Range * 1000
                    HumanoidRootPart.Velocity = Vector3.new(math.random(-Amount, Amount), math.random(-Amount, Amount), math.random(-Amount, Amount))
                    RunService.RenderStepped:Wait()
                    HumanoidRootPart.Velocity = Velocity
                end
            end

            XrgeTables.Functions.XHAHAHAHA = function()
                if XrgeLol.AntiAim.XHAHAHAHA then
                    setfflag("S2PhysicsSenderRate", 1)
                    setfflag("VisualizationImprovements", 1)
                    setfflag("VisualizeAllPropertyChanges", 1)
                    setfflag("VisualizerTrackRotationPredictions", 1)
                    setfflag("EnableInterpolationVisualizer", 1)
                    RunService.RenderStepped:Wait()
                end
            end
            
            
            XrgeTables.Functions.FFlagDesync = function()
                if XrgeLol.AntiAim.FFlagDesync.Enabled then
                    for FFlag, _ in pairs(XrgeLol.AntiAim.FFlagDesync.FFlags) do
                        local Value = XrgeLol.AntiAim.FFlagDesync.Amount
                        setfflag(FFlag, tostring(Value))

                        RunService.RenderStepped:Wait()
                        if XrgeLol.AntiAim.FFlagDesync.SetNew then
                            setfflag(FFlag, XrgeLol.AntiAim.FFlagDesync.SetNewAmount)
                        end
                    end
                end
            end

            XrgeTables.Functions.NoSlowdown = function()
                if XrgeLol.Misc.Exploits.NoSlowDown then
                    for _, Slowdown in pairs(LocalPlayer.Character.BodyEffects.Movement:GetChildren()) do
                        Slowdown:Destroy()
                    end
                end
            end

            XrgeTables.Functions.UpdateLookAt = function()
                if XrgeLol.Combat.Enabled and XrgeLol.Combat.Silent and XrgeLol.Combat.LookAt and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and LocalPlayer then
                    LocalPlayer.Character.Humanoid.AutoRotate = false
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(LocalPlayer.Character.HumanoidRootPart.CFrame.Position, Vector3.new(XrgeTables.Locals.Target.Character.HumanoidRootPart.CFrame.X, LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y, XrgeTables.Locals.Target.Character.HumanoidRootPart.CFrame.Z))
                else
                    LocalPlayer.Character.Humanoid.AutoRotate = true
                end
            end

            XrgeTables.Functions.UpdateSpectate = function()
                if XrgeLol.Combat.Enabled and XrgeLol.Combat.Silent and XrgeLol.Combat.Spectate and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target then
                    Camera.CameraSubject = XrgeTables.Locals.Target.Character.Humanoid
                else
                    Camera.CameraSubject = LocalPlayer.Character.Humanoid
                end
            end
        end

        --// Esp Function
        do

        end
    end

    --// Drawing objects
    do
        XrgeTables.Utility.Drawings["FieldOfViewVisualizer"] = XrgeTables.Functions.CreateDrawing("Circle", {
            Visible = XrgeLol.Combat.Fov.Visualize.Enabled,
            Color = XrgeLol.Combat.Fov.Visualize.Color,
            Radius = XrgeLol.Combat.Fov.Radius
        })

        XrgeTables.Utility.Drawings["TargetTracer"] = XrgeTables.Functions.CreateDrawing("Line",{
            Visible = false,
            Color = XrgeLol.Combat.Visuals.Tracer.Color,
            Thickness = XrgeLol.Combat.Visuals.Tracer.Thickness
        })

        XrgeTables.Utility.Drawings["TargetDot"] = XrgeTables.Functions.CreateDrawing("Circle", {
            Visible = false,
            Color = XrgeLol.Combat.Visuals.Dot.Color,
            Radius = XrgeLol.Combat.Visuals.Dot.Size
        })

        XrgeTables.Utility.Drawings["VelocityDot"] = XrgeTables.Functions.CreateDrawing("Circle", {
            Visible = false,
            Color = XrgeLol.AntiAim.VelocitySpoofer.Visualize.Color,
            Radius = 6,
            Filled = true
        })

        XrgeTables.Utility.Drawings["TargetChams"] = XrgeTables.Functions.Create("Highlight", {
            Parent = nil,
            FillColor = XrgeLol.Combat.Visuals.Chams.Fill.Color,
            FillTransparency = XrgeLol.Combat.Visuals.Chams.Fill.Transparency,
            OutlineColor = XrgeLol.Combat.Visuals.Chams.Fill.Color,
            OutlineTransparency = XrgeLol.Combat.Visuals.Chams.Outline.Transparency
        })

        XrgeTables.Utility.Drawings["CrosshairTop"] = XrgeTables.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        XrgeTables.Utility.Drawings["CrosshairBottom"] = XrgeTables.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        XrgeTables.Utility.Drawings["CrosshairLeft"] = XrgeTables.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })

        XrgeTables.Utility.Drawings["CrosshairRight"] = XrgeTables.Functions.CreateDrawing("Line", {
            Color = Color3.fromRGB(255, 255, 255),
            Thickness = 1,
            Visible = false,
            ZIndex = 10000
        })


        XrgeTables.Utility.Drawings["CFrameVisualize"] = game:GetObjects("rbxassetid://9474737816")[1]; XrgeTables.Utility.Drawings["CFrameVisualize"].Head.Face:Destroy(); for _, v in pairs(XrgeTables.Utility.Drawings["CFrameVisualize"]:GetChildren()) do v.Transparency = v.Name == "HumanoidRootPart" and 1 or 0.70; v.Material = "Neon"; v.Color = XrgeLol.AntiAim.CSync.Visualize.Color; v.CanCollide = false; v.Anchored = false end
    end

    --// Hitsounds
    do
        --// Hitsounds
        Hitsounds = {
            ["hentai.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/hentai2.mp3",
            ["hentai2.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/hentai1.wav",
            ["hentai3.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/hentai3.mp3",
            ["moan.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/hentai4.wav",
            ["combobreak.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/combobreak.wav",
            ["applepay.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/applepay.wav",
            ["stony.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/stony.wav",
            ["amongus.wav"] = "https://github.com/LionTheGreatRealFrFr/hitsounds1/raw/refs/heads/master/amongus_kill.wav",
            ["bell.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/bell.wav?raw=true",
            ["bepis.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/bepis.wav?raw=true",
            ["bubble.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/bubble.wav?raw=true",
            ["cock.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/cock.wav?raw=true",
            ["cod.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/cod.wav?raw=true",
            ["fatality.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/fatality.wav?raw=true",
            ["phonk.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/phonk.wav?raw=true",
            ["sparkle.wav"] = "https://github.com/nyulachan/nyula/blob/main/Sounds/sparkle.wav?raw=true",
        }

        if not isfolder("hitsounds_stuff") then
            makefolder("hitsounds_stuff")
        end

        for Name, Url in pairs(Hitsounds) do
            local Path = "hitsounds_stuff" .. "/" .. Name
            if not isfile(Path) then
                writefile(Path, game:HttpGet(Url))
            end
        end
    end

    --// Hit Effects
    do
        
--// Crescent Slash

do
local Insane = Instance.new("Part")
Insane.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = Insane

XrgeTables.Locals.HitEffect["Crescent Slash"] = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(91, 177, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(115, 201, 255))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

local ShardsDark = Instance.new("ParticleEmitter")
ShardsDark.Name = "ShardsDark"
ShardsDark.Lifetime = NumberRange.new(0.19, 0.35)
ShardsDark.SpreadAngle = Vector2.new(-90, 90)
ShardsDark.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
ShardsDark.Drag = 10
ShardsDark.VelocitySpread = -90
ShardsDark.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
ShardsDark.Speed = NumberRange.new(97.7530136, 146.9970093)
ShardsDark.Brightness = 4
ShardsDark.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.290774, 0.6734411, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
ShardsDark.Enabled = false
ShardsDark.ZOffset = 0.5705321
ShardsDark.Rate = 50
ShardsDark.Texture = "rbxassetid://8030734851"
ShardsDark.Rotation = NumberRange.new(90, 90)
ShardsDark.Orientation = Enum.ParticleOrientation.VelocityParallel
ShardsDark.Parent = Attachment

local Specs = Instance.new("ParticleEmitter")
Specs.Name = "Specs"
Specs.Lifetime = NumberRange.new(0.33, 1.4)
Specs.SpreadAngle = Vector2.new(360, -1000)
Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
Specs.Drag = 10
Specs.VelocitySpread = 360
Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
Specs.Brightness = 7
Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
Specs.Enabled = false
Specs.Acceleration = Vector3.new(0, 36.74925231933594, 0)
Specs.Rate = 50
Specs.Texture = "rbxassetid://8030760338"
Specs.EmissionDirection = Enum.NormalId.Right
Specs.Parent = Attachment

local Specs1 = Instance.new("ParticleEmitter")
Specs1.Name = "Specs"
Specs1.Lifetime = NumberRange.new(0.33, 1.75)
Specs1.SpreadAngle = Vector2.new(90, -90)
Specs1.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
Specs1.Drag = 9
Specs1.VelocitySpread = 90
Specs1.Speed = NumberRange.new(42.2616425, 73.4985046)
Specs1.Brightness = 6
Specs1.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.210774, 0.3978962, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
Specs1.Enabled = false
Specs1.Acceleration = Vector3.new(0, -20.21208953857422, 0)
Specs1.ZOffset = 0.5144895
Specs1.Rate = 50
Specs1.Texture = "rbxassetid://8030760338"
Specs1.Parent = Attachment

local Specs2 = Instance.new("ParticleEmitter")
Specs2.Name = "Specs"
Specs2.Lifetime = NumberRange.new(0.19, 1.2)
Specs2.SpreadAngle = Vector2.new(360, -1000)
Specs2.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
Specs2.Drag = 10
Specs2.VelocitySpread = 360
Specs2.Speed = NumberRange.new(36.7492523, 146.9970093)
Specs2.Brightness = 7
Specs2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.200774, 2.0311937, 0.4363973), NumberSequenceKeypoint.new(1, 0)})
Specs2.Enabled = false
Specs2.Acceleration = Vector3.new(0, 36.74925231933594, 0)
Specs2.Rate = 50
Specs2.Texture = "rbxassetid://8030760338"
Specs2.EmissionDirection = Enum.NormalId.Right
Specs2.Parent = Attachment

local Specs21 = Instance.new("ParticleEmitter")
Specs21.Name = "Specs2"
Specs21.Lifetime = NumberRange.new(0.19, 1.35)
Specs21.SpreadAngle = Vector2.new(90, -90)
Specs21.Color = ColorSequence.new(Color3.fromRGB(106, 171, 255))
Specs21.Drag = 12
Specs21.VelocitySpread = 90
Specs21.Speed = NumberRange.new(42.2616425, 73.4985046)
Specs21.Brightness = 6
Specs21.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.216774, 0.5721694, 0.1855686), NumberSequenceKeypoint.new(1, 0)})
Specs21.Enabled = false
Specs21.Acceleration = Vector3.new(0, -20.21208953857422, 0)
Specs21.ZOffset = 0.5144895
Specs21.Rate = 50
Specs21.Texture = "rbxassetid://8030760338"
Specs21.Parent = Attachment

local ddddddddddddddddddd = Instance.new("ParticleEmitter")
ddddddddddddddddddd.Name = "ddddddddddddddddddd"
ddddddddddddddddddd.Lifetime = NumberRange.new(0.19, 0.37)
ddddddddddddddddddd.SpreadAngle = Vector2.new(90, -90)
ddddddddddddddddddd.LockedToPart = true
ddddddddddddddddddd.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.6429392, 0), NumberSequenceKeypoint.new(1, 0)})
ddddddddddddddddddd.LightEmission = 1
ddddddddddddddddddd.Color = ColorSequence.new(Color3.fromRGB(90, 184, 255), Color3.fromRGB(165, 251, 255))
ddddddddddddddddddd.Drag = 6
ddddddddddddddddddd.TimeScale = 0.7
ddddddddddddddddddd.VelocitySpread = 90
ddddddddddddddddddd.Speed = NumberRange.new(81.5833435, 110.2477646)
ddddddddddddddddddd.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.410774, 0.6711507, 0.3356177), NumberSequenceKeypoint.new(1, 0)})
ddddddddddddddddddd.Enabled = false
ddddddddddddddddddd.Acceleration = Vector3.new(0, -81.58334350585938, 0)
ddddddddddddddddddd.ZOffset = 0.8345273
ddddddddddddddddddd.Rate = 50
ddddddddddddddddddd.Texture = "rbxassetid://1053546634"
ddddddddddddddddddd.RotSpeed = NumberRange.new(-444, 166)
ddddddddddddddddddd.Rotation = NumberRange.new(-360, 360)
ddddddddddddddddddd.Parent = Attachment

local large_shard = Instance.new("ParticleEmitter")
large_shard.Name = "large_shard"
large_shard.Lifetime = NumberRange.new(0.19, 0.28)
large_shard.SpreadAngle = Vector2.new(-90, 90)
large_shard.Color = ColorSequence.new(Color3.fromRGB(108, 184, 255))
large_shard.Drag = 10
large_shard.VelocitySpread = -90
large_shard.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
large_shard.Speed = NumberRange.new(97.7530136, 146.9970093)
large_shard.Brightness = 4
large_shard.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.260774, 3.515605, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
large_shard.Enabled = false
large_shard.ZOffset = 0.5705321
large_shard.Rate = 50
large_shard.Texture = "rbxassetid://8030734851"
large_shard.Rotation = NumberRange.new(90, 90)
large_shard.Orientation = Enum.ParticleOrientation.VelocityParallel
large_shard.Parent = Attachment

local out_Specs = Instance.new("ParticleEmitter")
out_Specs.Name = "out_Specs"
out_Specs.Lifetime = NumberRange.new(0.19, 1)
out_Specs.SpreadAngle = Vector2.new(44, -1000)
out_Specs.Color = ColorSequence.new(Color3.fromRGB(98, 174, 255))
out_Specs.Drag = 10
out_Specs.VelocitySpread = 44
out_Specs.Speed = NumberRange.new(36.7492523, 146.9970093)
out_Specs.Brightness = 7
out_Specs.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.244774, 0.5469525, 0.1433053), NumberSequenceKeypoint.new(1, 0)})
out_Specs.Enabled = false
out_Specs.Acceleration = Vector3.new(0, -3.215559720993042, 0)
out_Specs.Rate = 50
out_Specs.Texture = "rbxassetid://8030760338"
out_Specs.EmissionDirection = Enum.NormalId.Right
out_Specs.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 1
Crescents.Color = ColorSequence.new(Color3.fromRGB(92, 161, 252))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 20
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

Insane.Parent = workspace
end

do --// Cosmic Explosion

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Name = "Attachment"
Attachment.Parent = Part

XrgeTables.Locals.HitEffect["Explosion"] = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"
Glow.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

local ParticleEmitter2 = Instance.new("ParticleEmitter")
ParticleEmitter2.Name = "ParticleEmitter2"
ParticleEmitter2.FlipbookFramerate = NumberRange.new(20, 20)
ParticleEmitter2.Lifetime = NumberRange.new(0.19, 0.38)
ParticleEmitter2.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
ParticleEmitter2.SpreadAngle = Vector2.new(360, 360)
ParticleEmitter2.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.209842, 0.5), NumberSequenceKeypoint.new(0.503842, 0.263333), NumberSequenceKeypoint.new(0.799842, 0.5), NumberSequenceKeypoint.new(1, 1)})
ParticleEmitter2.LightEmission = 1
ParticleEmitter2.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
ParticleEmitter2.VelocitySpread = 360
ParticleEmitter2.Speed = NumberRange.new(0.0161231, 0.0161231)
ParticleEmitter2.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 4.3125), NumberSequenceKeypoint.new(0.3985056, 7.9375), NumberSequenceKeypoint.new(1, 10)})
ParticleEmitter2.Enabled = false
ParticleEmitter2.ZOffset = 0.15
ParticleEmitter2.Rate = 100
ParticleEmitter2.Texture = "http://www.roblox.com/asset/?id=12394566430"
ParticleEmitter2.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
ParticleEmitter2.Rotation = NumberRange.new(39, 999)
ParticleEmitter2.Orientation = Enum.ParticleOrientation.VelocityParallel
ParticleEmitter2.Parent = Attachment

Part.Parent = workspace
end

do --// Cum

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

XrgeTables.Locals.HitEffect["Cum"] = Attachment

local Foam = Instance.new("ParticleEmitter")
Foam.Name = "Foam"
Foam.LightInfluence = 0.5
Foam.Lifetime = NumberRange.new(1, 1)
Foam.SpreadAngle = Vector2.new(360, -360)
Foam.VelocitySpread = 360
Foam.Squash = NumberSequence.new(1)
Foam.Speed = NumberRange.new(20, 20)
Foam.Brightness = 2.5
Foam.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.1016692, 0.6508875, 0.6508875), NumberSequenceKeypoint.new(0.6494689, 1.4201183, 0.4127519), NumberSequenceKeypoint.new(1, 0)})
Foam.Enabled = false
Foam.Acceleration = Vector3.new(0, -66.04029846191406, 0)
Foam.Rate = 100
Foam.Texture = "rbxassetid://8297030850"
Foam.Rotation = NumberRange.new(-90, -90)
Foam.Orientation = Enum.ParticleOrientation.VelocityParallel
Foam.Parent = Attachment

Part.Parent = workspace
end

do --// Slash
local Part = Instance.new("Part")
Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

XrgeTables.Locals.HitEffect["Slash"] = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 96, 255)), ColorSequenceKeypoint.new(0.3160622, Color3.fromRGB(160, 96, 255)), ColorSequenceKeypoint.new(0.5146805, Color3.fromRGB(154, 82, 255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 96, 255))})
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

Part.Parent = workspace
end

do --// Atomic Slash

local Part = Instance.new("Part")

Part.Parent = ReplicatedStorage

local Attachment = Instance.new("Attachment")
Attachment.Parent = Part

XrgeTables.Locals.HitEffect["Atomic Effects"] = Attachment

local Crescents = Instance.new("ParticleEmitter")
Crescents.Name = "Crescents"
Crescents.Lifetime = NumberRange.new(0.19, 0.38)
Crescents.SpreadAngle = Vector2.new(-360, 360)
Crescents.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1932907, 0), NumberSequenceKeypoint.new(0.778754, 0), NumberSequenceKeypoint.new(1, 1)})
Crescents.LightEmission = 10
Crescents.Color = ColorSequence.new(Color3.fromRGB(160, 96, 255))
Crescents.VelocitySpread = -360
Crescents.Speed = NumberRange.new(0.0826858, 0.0826858)
Crescents.Brightness = 4
Crescents.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.398774, 8.8026266, 2.2834616), NumberSequenceKeypoint.new(1, 11.477972, 1.860431)})
Crescents.Enabled = false
Crescents.ZOffset = 0.4542207
Crescents.Rate = 50
Crescents.Texture = "rbxassetid://12509373457"
Crescents.RotSpeed = NumberRange.new(800, 1000)
Crescents.Rotation = NumberRange.new(-360, 360)
Crescents.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Crescents.Parent = Attachment

local Glow = Instance.new("ParticleEmitter")
Glow.Name = "Glow"
Glow.Lifetime = NumberRange.new(0.16, 0.16)
Glow.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1421725, 0.6182796), NumberSequenceKeypoint.new(1, 1)})
Glow.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Glow.Speed = NumberRange.new(0, 0)
Glow.Brightness = 5
Glow.Size = NumberSequence.new(9.1873131, 16.5032349)
Glow.Enabled = false
Glow.ZOffset = -0.0565939
Glow.Rate = 50
Glow.Texture = "rbxassetid://8708637750"
Glow.Parent = Attachment

local Effect = Instance.new("ParticleEmitter")
Effect.Name = "Effect"
Effect.Lifetime = NumberRange.new(0.4, 0.7)
Effect.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4
Effect.SpreadAngle = Vector2.new(360, -360)
Effect.LockedToPart = true
Effect.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.1070999, 0.19375), NumberSequenceKeypoint.new(0.7761194, 0.88125), NumberSequenceKeypoint.new(1, 1)})
Effect.LightEmission = 1
Effect.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Effect.Drag = 1
Effect.VelocitySpread = 360
Effect.Speed = NumberRange.new(0.0036749, 0.0036749)
Effect.Brightness = 2.0999999
Effect.Size = NumberSequence.new(6.9680691, 9.9213123)
Effect.Enabled = false
Effect.ZOffset = 0.4777403
Effect.Rate = 50
Effect.Texture = "rbxassetid://9484012464"
Effect.RotSpeed = NumberRange.new(-150, -150)
Effect.FlipbookMode = Enum.ParticleFlipbookMode.OneShot
Effect.Rotation = NumberRange.new(50, 50)
Effect.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
Effect.Parent = Attachment

local Gradient1 = Instance.new("ParticleEmitter")
Gradient1.Name = "Gradient1"
Gradient1.Lifetime = NumberRange.new(0.3, 0.3)
Gradient1.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.15, 0.3), NumberSequenceKeypoint.new(1, 1)})
Gradient1.Color = ColorSequence.new(Color3.fromRGB(173, 82, 252))
Gradient1.Speed = NumberRange.new(0, 0)
Gradient1.Brightness = 6
Gradient1.Size = NumberSequence.new(0, 11.6261358)
Gradient1.Enabled = false
Gradient1.ZOffset = 0.9187313
Gradient1.Rate = 50
Gradient1.Texture = "rbxassetid://8196169974"
Gradient1.Parent = Attachment

local Shards = Instance.new("ParticleEmitter")
Shards.Name = "Shards"
Shards.Lifetime = NumberRange.new(0.19, 0.7)
Shards.SpreadAngle = Vector2.new(-90, 90)
Shards.Color = ColorSequence.new(Color3.fromRGB(179, 145, 253))
Shards.Drag = 10
Shards.VelocitySpread = -90
Shards.Squash = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.5705521, 0.4125001), NumberSequenceKeypoint.new(1, -0.9375)})
Shards.Speed = NumberRange.new(97.7530136, 146.9970093)
Shards.Brightness = 4
Shards.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.284774, 1.2389833, 0.1534118), NumberSequenceKeypoint.new(1, 0)})
Shards.Enabled = false
Shards.Acceleration = Vector3.new(0, -56.961341857910156, 0)
Shards.ZOffset = 0.5705321
Shards.Rate = 50
Shards.Texture = "rbxassetid://8030734851"
Shards.Rotation = NumberRange.new(90, 90)
Shards.Orientation = Enum.ParticleOrientation.VelocityParallel
Shards.Parent = Attachment

Part.Parent = workspace
end
        --// Nova
        do
            local Part = Instance.new("Part")
            Part.Parent = ReplicatedStorage

            local Attachment = Instance.new("Attachment")
            Attachment.Name = "Attachment"
            Attachment.Parent = Part

            XrgeTables.Locals.HitEffect["Nova Impact"] = Attachment

            local ParticleEmitter = Instance.new("ParticleEmitter")
            ParticleEmitter.Name = "ParticleEmitter"
            ParticleEmitter.Acceleration = Vector3.new(0, 0, 1)
            ParticleEmitter.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            })
            ParticleEmitter.Lifetime = NumberRange.new(0.5, 0.5)
            ParticleEmitter.LightEmission = 1
            ParticleEmitter.LockedToPart = true
            ParticleEmitter.Rate = 1
            ParticleEmitter.Rotation = NumberRange.new(0, 360)
            ParticleEmitter.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 10),
                NumberSequenceKeypoint.new(1, 1),
            })
            ParticleEmitter.Speed = NumberRange.new(0, 0)
            ParticleEmitter.Texture = "rbxassetid://1084991215"
            ParticleEmitter.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(0.534, 0.25),
                NumberSequenceKeypoint.new(1, 0.5),
                NumberSequenceKeypoint.new(1, 0),
            })
            ParticleEmitter.ZOffset = 1
            ParticleEmitter.Parent = Attachment
            local ParticleEmitter1 = Instance.new("ParticleEmitter")
            ParticleEmitter1.Name = "ParticleEmitter"
            ParticleEmitter1.Acceleration = Vector3.new(0, 1, -0.001)
            ParticleEmitter1.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                ColorSequenceKeypoint.new(0.495, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
            })
            ParticleEmitter1.Lifetime = NumberRange.new(0.5, 0.5)
            ParticleEmitter1.LightEmission = 1
            ParticleEmitter1.LockedToPart = true
            ParticleEmitter1.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
            ParticleEmitter1.Rate = 1
            ParticleEmitter1.Rotation = NumberRange.new(0, 360)
            ParticleEmitter1.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 1),
                NumberSequenceKeypoint.new(1, 10),
                NumberSequenceKeypoint.new(1, 1),
            })
            ParticleEmitter1.Speed = NumberRange.new(0, 0)
            ParticleEmitter1.Texture = "rbxassetid://1084991215"
            ParticleEmitter1.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(0, 0.1),
                NumberSequenceKeypoint.new(0.534, 0.25),
                NumberSequenceKeypoint.new(1, 0.5),
                NumberSequenceKeypoint.new(1, 0),
            })
            ParticleEmitter1.ZOffset = 1
            ParticleEmitter1.Parent = Attachment
        end
    end

    --// Connections
    do
        --// Combat Connections
        do
            XrgeTables.Functions.Connection(RunService.Heartbeat, function()
                XrgeTables.Functions.MouseAim()

                XrgeTables.Functions.Resolve()

                XrgeTables.Functions.Air()

                XrgeTables.Functions.UpdateLookAt()
            end)

            XrgeTables.Functions.Connection(RunService.RenderStepped, function()
                XrgeTables.Functions.UpdateFieldOfView()

                XrgeTables.Functions.DotThingYes()

                XrgeTables.Functions.UpdateTargetVisuals()

                XrgeTables.Functions.AutoSelect()

                XrgeTables.Functions.UpdateSpectate()
            end)
        end

        --// Visual Connections
        do
            XrgeTables.Functions.Connection(RunService.RenderStepped, function()
                XrgeTables.Functions.HitShit()

                XrgeTables.Functions.GunEvents()

                XrgeTables.Functions.UpdateAtmosphere()

                XrgeTables.Functions.UpdateHealth()
            end)
        end

        --// Anti Aim Connection
        do
            XrgeTables.Functions.Connection(RunService.Heartbeat, function()
                XrgeTables.Functions.XHAHAHAHA()
                
                XrgeTables.Functions.VisualizeMovement()
                
                XrgeTables.Functions.CSync()

                XrgeTables.Functions.Network()

                XrgeTables.Functions.VelocityDesync()

                XrgeTables.Functions.FFlagDesync()
            end)
        end

        --// Movement Connections
        do
            XrgeTables.Functions.Connection(RunService.Heartbeat, function()
                XrgeTables.Functions.Speed()

                XrgeTables.Functions.NoSlowdown()
            end)
        end
    end

    --// Hooks
    do
        local __namecall
        local __newindex
        local __index

        __index = hookmetamethod(game, "__index", newcclosure(function(Self, Index)
            if not checkcaller() and XrgeLol.AntiAim.CSync.Enabled and XrgeLol.AntiAim.CSync.Spoof and XrgeTables.Locals.SavedCFrame and Index == "CFrame" and Self == LocalPlayer.Character.HumanoidRootPart then
                return XrgeTables.Locals.SavedCFrame
            end
            return __index(Self, Index)
        end))

        __namecall = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
            local Arguments = {...}
            local Method = tostring(getnamecallmethod())

            if not checkcaller() and Method == "FireServer" then
                for _, Argument in pairs(Arguments) do
                    if typeof(Argument) == "Vector3" then
                        XrgeTables.Locals.AntiAimViewer.MouseRemote = Self
                        XrgeTables.Locals.AntiAimViewer.MouseRemoteFound = true
                        WOAHHH = Arguments
                        XrgeTables.Locals.AntiAimViewer.MouseRemoteArgs = Arguments
                        XrgeTables.Locals.AntiAimViewer.MouseRemotePositionIndex = _
                        NEINIGGANEINEI = _

                        if XrgeLol.Combat.Enabled and XrgeLol.Combat.Silent and not XrgeLol.Combat.AntiAimViewer and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and not XrgeLol.Combat.UseIndex then
                            Arguments[_] = (XrgeTables.Functions.GetTargetPredictedPosition().Position)
                        end

                        return __namecall(Self, unpack(Arguments))
                    end
                end
            end
            return __namecall(Self, ...)
        end))

local Sexy = {}
local ClientThinf = game:GetService("Players").LocalPlayer
Sexy[1] = hookmetamethod(ClientThinf:GetMouse(), "__index", newcclosure(function(self, index)
    if index == "Hit" and XrgeLol.Combat.Enabled and XrgeLol.Combat.Silent and not XrgeLol.Combat.AntiAimViewer and XrgeTables.Locals.IsTargetting and XrgeTables.Locals.Target and XrgeLol.Combat.UseIndex then
        
            local position = CFrame.new((XrgeTables.Functions.GetTargetPredictedPosition().Position))
            
            return position
    end
    return Sexy[1](self, index)
end))
    end
local library = loadstring(game:HttpGet("https://pastebin.com/raw/AJi1f0KC"))()

local window = library:Window({Name = "Xrge <font color=\"rgb(0, 255, 0)\">.lol</font>", Size = Vector2.new(300, 300)})
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextButton = Instance.new("TextButton")
local UITextSizeConstraint = Instance.new("UITextSizeConstraint")

ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BackgroundTransparency = 0
Frame.Position = UDim2.new(1, -120, 0, 0)
Frame.Size = UDim2.new(0, 100, 0, 50)

TextButton.Parent = Frame
TextButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
TextButton.BackgroundTransparency = 1
TextButton.Size = UDim2.new(1, 0, 1, 0)
TextButton.Font = Enum.Font.SourceSans
TextButton.Text = "Xrge"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.TextSize = 12
TextButton.TextStrokeColor3 = Color3.fromRGB(0, 255, 0)
TextButton.TextStrokeTransparency = 0
TextButton.TextWrapped = true

TextButton.MouseButton1Down:Connect(function()
    library:SetOpen(not library.Open)
    print("Library Open:", library.Open)
end)

local XRGECOMBAT = window:Page({Name = "Combat"})
local XRGEVISUALS = window:Page({Name = "Visuals"})

local main, trgt, cam = XRGECOMBAT:MultiSection({Sections = {"Main", "Target", "Cam"}, Zindex = 5, Side = "Left", Size = 315})

main:Toggle({Name = "Enable", Callback = function(v)
    XrgeLol.Combat.Enabled = v
end})

main:Toggle({Name = "Target Lock", Callback = function(v)
    XrgeLol.Combat.Silent = v
end})

main:Toggle({Name = "Camera Lock", Callback = function(v)
    XrgeLol.Combat.Camera = v
end})

main:Button({Name = "Load Button", Callback = function()
                if ButtonAlreadyLoaded then
                library:Notification("Already Loaded.", 5, library.Accent)
                return
                end
                ButtonAlreadyLoaded = true
do
local ScreeenGui = Instance.new("ScreenGui")
local Fraame = Instance.new("Frame")
local TeextButton = Instance.new("ImageButton")
local UIITextSizeConstraint = Instance.new("UITextSizeConstraint")
ScreeenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreeenGui.ResetOnSpawn = false
ScreeenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Fraame.Parent = ScreeenGui
Fraame.BackgroundColor3 = Color3.fromRGB(0,0,0)
Fraame.BackgroundTransparency = 0.8
Fraame.Position = UDim2.new(0.1, -75, 0.5, -25)
Fraame.Size = UDim2.new(0, 90, 0, 90)
Fraame.Draggable = true

TeextButton.Parent = Fraame
TeextButton.BackgroundColor3 = Color3.fromRGB(0,0,0)
TeextButton.BackgroundTransparency = 1
TeextButton.Size = UDim2.new(0, 75, 0, 75)
TeextButton.AnchorPoint = Vector2.new(0.5,0.5)
TeextButton.Position = UDim2.new(0.5, 0, 0.5, 0)
TeextButton.Image = "rbxassetid://135595871306427"

local uiiCorner = Instance.new("UICorner", Fraame)
uiiCorner.CornerRadius = UDim.new(0, 9)

TeextButton.MouseButton1Down:Connect(function()
                    if XrgeLol.Combat.Enabled then
                    XrgeTables.Locals.IsTargetting = not XrgeTables.Locals.IsTargetting
                        local NewTarget = XrgeTables.Functions.GetClosestPlayerNumbah()
                    XrgeTables.Locals.Target = XrgeTables.Locals.IsTargetting and NewTarget.Character and NewTarget or nil

                        if XrgeLol.Combat.Alerts and XrgeTables.Locals.Target ~= nil  then
                            library:Notification(string.format("Target: %s", XrgeTables.Locals.Target.Character.Humanoid.DisplayName), 5, library.Accent)
                        end
                    end
--//rbxassetid://10734985247
if XrgeTables.Locals.Target then
  TeextButton.Image = "rbxassetid://135595871306427"
else
  TeextButton.Image = "rbxassetid://135595871306427"
end
end)
                local inputService = game:GetService("UserInputService")
                UIITextSizeConstraint.Parent = TeextButton
                UIITextSizeConstraint.MaxTextSize = 30
                function draggable(a)
                    local b = inputService
                    local c
                    local d
                    local e
                    local f
                    local function g(h)
                        local i = h.Position - e
                        a.Position = UDim2.new(f.X.Scale, f.X.Offset + i.X, f.Y.Scale, f.Y.Offset + i.Y)
                    end
                    a.InputBegan:Connect(
                        function(h)
                            if
                                h.UserInputType == Enum.UserInputType.MouseButton1 or
                                    h.UserInputType == Enum.UserInputType.Touch
                             then
                                c = true
                                e = h.Position
                                f = a.Position
                                h.Changed:Connect(
                                    function()
                                        if h.UserInputState == Enum.UserInputState.End then
                                            c = false
                                        end
                                    end
                                )
                            end
                        end
                    )
                    a.InputChanged:Connect(
                        function(h)
                            if
                                h.UserInputType == Enum.UserInputType.MouseMovement or
                                    h.UserInputType == Enum.UserInputType.Touch
                             then
                                d = h
                            end
                        end
                    )
                    b.InputChanged:Connect(
                        function(h)
                            if h == d and c then
                                g(h)
                            end
                        end
                    )
                end
                draggable(Fraame)
end
                end})

main:List({
    Name = "Aim Part",
    Options = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "LeftLowerArm", "LeftHand", 
        "RightUpperArm", "RightLowerArm", "RightHand", 
        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
        "RightUpperLeg", "RightLowerLeg", "RightFoot",
        "HumanoidRootPart"
    },
    Default = "HumanoidRootPart",
    Callback = function(v)
        XrgeLol.Combat.AimPart = v
    end
})

main:Textbox({Name = "Horizontal Pred", Default = "0.22091", Callback = function(v)
    XrgeLol.Combat.Prediction.Horizontal = tonumber(v)
end})

main:Textbox({Name = "Vertical Pred", Default = "0.160829", Callback = function(v)
    XrgeLol.Combat.Prediction.Vertical = tonumber(v)
end})

main:Toggle({Name = "Auto Prediction", Callback = function(v)
    XrgeLol.Combat.PingBased = v
end})

RunService.Stepped:Connect(function()
    if XrgeLol.Combat.PingBased then
        local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
        local split = string.split(pingvalue, '(')
        local ping = tonumber(split[1])

        XrgeLol.Combat.Prediction.Vertical = tonumber(ping / 1500)
        if ping < 200 then
            XrgeLol.Combat.Prediction.Horizontal = 0.2298343243234332
        elseif ping < 170 then
            XrgeLol.Combat.Prediction.Horizontal = 0.2265713
        elseif ping < 160 then
            XrgeLol.Combat.Prediction.Horizontal = 0.17242928282920019171790
        elseif ping < 150 then
            XrgeLol.Combat.Prediction.Horizontal = 0.168041982
        elseif ping < 140 then
            XrgeLol.Combat.Prediction.Horizontal = 0.1608313
        elseif ping < 130 then
            XrgeLol.Combat.Prediction.Horizontal = 0.169202692
        elseif ping < 120 then
            XrgeLol.Combat.Prediction.Horizontal = 0.160283017
        elseif ping < 110 then
            XrgeLol.Combat.Prediction.Horizontal = 0.15165
        elseif ping < 100 then
            XrgeLol.Combat.Prediction.Horizontal = 0.1483987
        elseif ping < 80 then
            XrgeLol.Combat.Prediction.Horizontal = 0.1402632
        elseif ping < 60 then
            XrgeLol.Combat.Prediction.Horizontal = 0.122582
        elseif ping < 40 then
            XrgeLol.Combat.Prediction.Horizontal = 0.100353
        else
            XrgeLol.Combat.Prediction.Horizontal = 0.115859
        end
    end
end)

    trgt:Toggle({Name = "Look At", Callback = function(v)
        XrgeLol.Combat.LookAt = v
    end})

    trgt:Toggle({Name = "View At", Callback = function(v)
        XrgeLol.Combat.Spectate = v
    end})

    cam:List({
        Name = "Easing Style",
        Options = {"Linear","Sine","Bounce","Elastic","Back","Quad","Quart","Quint","Exponential","Circular","Cubic"},
        Default = "Sine",
        Callback = function(v)
            XrgeLol.Combat.EasingStyle = v
        end
    })

    cam:List({
        Name = "Easing Direction",
        Options = {'In', 'Out', 'InOut'},
        Default = "In",
        Callback = function(v)
            XrgeLol.Combat.EasingDirection = v
        end
    })

    cam:Textbox({Name = "Smoothing", Default = "1", Callback = function(v)
        XrgeLol.Combat.Smoothing.Horizontal = v
    end})

    local strafearea = XRGECOMBAT:Section({Name = " Target Strafe", Side = "Right", Size = 245})

    strafearea:Toggle({Name = "Enabled", Callback = function(v)
        XrgeLol.AntiAim.CSync.Enabled = v
    end})

    strafearea:Toggle({Name = "Visualizer", Callback = function(v)
        XrgeLol.AntiAim.CSync.Spoof = v
        XrgeLol.AntiAim.CSync.Visualize.Enabled = v
    end})

    strafearea:Toggle({Name = "Randomize", Callback = function(v)
        XrgeLol.AntiAim.CSync.Type = v and "Random Target" or "Target Strafe"
    end})

    strafearea:Textbox({Name = "Randomize Value", Default = "1", Callback = function(v)
        XrgeLol.AntiAim.CSync.RandomDistance = tonumber(v)
    end})

    strafearea:Textbox({Name = "Speed", Default = "1", Callback = function(v)
        XrgeLol.AntiAim.CSync.TargetStrafe.Speed = tonumber(v)
    end})

    strafearea:Textbox({Name = "Height", Default = "1", Callback = function(v)
        XrgeLol.AntiAim.CSync.TargetStrafe.Height = tonumber(v)
    end})

    strafearea:Textbox({Name = "Distance", Default = "1", Callback = function(v)
        XrgeLol.AntiAim.CSync.TargetStrafe.Distance = tonumber(v)
    end})

    local wrldstff = XRGEVISUALS:Section({Name = "World Settings", Side = "Left", Size = 340})

    wrldstff:Toggle({Name = "Enabled", Callback = function(v)
        XrgeLol.Visuals.World.Enabled = v
    end})

    wrldstff:Toggle({Name = "Ambient", Callback = function(v)
        XrgeLol.Visuals.World.Ambient.Enabled = v
    end}):Colorpicker({Name = "Color", Default = Color3.fromRGB(0, 209, 0), Callback = function(v)
        XrgeLol.Visuals.World.Ambient.Color = v
    end})

    wrldstff:Toggle({Name = "Clock Time", Callback = function(v)
        XrgeLol.Visuals.World.ClockTime.Enabled = v
    end})

    wrldstff:Textbox({Name = "Clock Time", Default = "1", Callback = function(v)
        XrgeLol.Visuals.World.ClockTime.Value = v
    end})

    wrldstff:Toggle({Name = "Brightness", Callback = function(v)
        XrgeLol.Visuals.World.Brightness.Enabled = v
    end})

    wrldstff:Textbox({Name = "Brightness Amount", Default = "0", Callback = function(v)
        XrgeLol.Visuals.World.Brightness.Value = v
    end})

    local onhtstff = XRGEVISUALS:Section({Name = "On Hit Effect", Side = "Right", Size = 225})

    onhtstff:Toggle({Name = "Enabled", Callback = function(v)
        XrgeLol.Visuals.OnHit.Enabled = v
    end})

    onhtstff:Toggle({Name = "Effect", Callback = function(v)
        XrgeLol.Visuals.OnHit.Effect.Enabled = v
    end}):Colorpicker({Name = "Color", Default = Color3.fromRGB(0, 255, 0), Callback = function(v)
        XrgeLol.Visuals.OnHit.Effect.Color = v
    end})

    onhtstff:List({
        Name = "Hit Effect",
        Options = {"Bubble","Slash","Crescent Slash","Cum","Explosion","Slash","Atomic Effects"},
        Default = "Cum",
        Callback = function(v)
            HitEffectsHAHAHHA = v
        end
    })

    onhtstff:Toggle({Name = "Sound", Callback = function(v)
        XrgeLol.Visuals.OnHit.Sound.Enabled = v
    end})

    onhtstff:Textbox({Name = "Volume", Default = "1", Callback = function(v)
        XrgeLol.Visuals.OnHit.Sound.Volume = v
    end})

    onhtstff:List({
        Name = "Hit Sound",
        Options = {"applepay.wav","moan.wav","bell.wav","fatality.wav","amongus.wav","cock.wav","bubble.wav","cod.wav","bepis.wav"},
        Default = "bubble.wav",
        Callback = function(v)
            XrgeLol.Visuals.OnHit.Sound.Value = v
        end
    })
