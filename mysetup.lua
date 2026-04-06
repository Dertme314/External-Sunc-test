--[[
    Fair Dunc Lab v4.6
    Setup script
]]

local ReStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local SSS = game:GetService("ServerScriptService")

-- Cleanup
local function cleanInstance(parent, name)
    local obj = parent:FindFirstChild(name)
    if obj then obj:Destroy() end
end

cleanInstance(workspace, "FairDuncLab")
cleanInstance(SSS, "LabServerHandler")
cleanInstance(StarterGui, "DuncScoreGui")
cleanInstance(ReStorage, "DUNC_GetToken")
cleanInstance(ReStorage, "DUNC_VerifyAnswers")
cleanInstance(game:GetService("StarterPlayer").StarterPlayerScripts, "DuncVerifyProbe")
cleanInstance(ReStorage, "DUNC_Verifier")

-- map

local lab = Instance.new("Folder")
lab.Name = "FairDuncLab"
lab.Parent = workspace

local floor = Instance.new("Part")
floor.Name = "Floor"
floor.Size = Vector3.new(100, 1, 100)
floor.Position = Vector3.new(0, -0.5, 0)
floor.Anchored = true
floor.BrickColor = BrickColor.new("Dark stone grey")
floor.Material = Enum.Material.SmoothPlastic
floor.Parent = lab

local function addBillboard(part, text)
    local bb = Instance.new("BillboardGui")
    bb.Size = UDim2.new(0, 200, 0, 50)
    bb.Adornee = part
    bb.StudsOffset = Vector3.new(0, 3, 0)
    bb.AlwaysOnTop = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Parent = bb
    bb.Parent = part
end

local function makeTestPart(name, position, size)
    local part = Instance.new("Part")
    part.Name = name
    part.Position = position
    part.Size = size or Vector3.new(4, 4, 4)
    part.Anchored = true
    part.BrickColor = BrickColor.new("Medium stone grey")
    part.Material = Enum.Material.SmoothPlastic
    part.Parent = lab
    return part
end

-- click
local clickPart = makeTestPart("ClickTestPart", Vector3.new(10, 2, 0))
local cd = Instance.new("ClickDetector")
cd.MaxActivationDistance = 200
cd.Parent = clickPart
addBillboard(clickPart, "Click Detector Test")

-- prompt
local promptPart = makeTestPart("PromptTestPart", Vector3.new(-10, 2, 0))
local prompt = Instance.new("ProximityPrompt")
prompt.MaxActivationDistance = 200
prompt.HoldDuration = 0
prompt.Parent = promptPart
addBillboard(promptPart, "Proximity Prompt Test")

-- touch
local touchPart = makeTestPart("TouchTestPart", Vector3.new(0, 2, 10))
touchPart.CanTouch = true
addBillboard(touchPart, "Touch Interest Test")

-- virtual input
local keypressPart = makeTestPart("KeypressTestPart", Vector3.new(-10, 2, 10))
addBillboard(keypressPart, "Virtual Keypress Test")

local mousePart = makeTestPart("MouseTestPart", Vector3.new(10, 2, -10))
addBillboard(mousePart, "Virtual Mouse Test")

-- helper

local localInputScript = Instance.new("LocalScript")
localInputScript.Name = "DuncInputVerifier"
localInputScript.Source = [==[
local UIS = game:GetService("UserInputService")
local lab = workspace:WaitForChild("FairDuncLab")

local keyPart = lab:WaitForChild("KeypressTestPart")
local mousePart = lab:WaitForChild("MouseTestPart")

local function flashColor(part, color)
    part.BrickColor = BrickColor.new(color)
    task.wait(1)
    part.BrickColor = BrickColor.new("Medium stone grey")
end

UIS.InputBegan:Connect(function(input, gpe)
    if input.KeyCode == Enum.KeyCode.Return then
        flashColor(keyPart, "Bright blue")
    elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
        flashColor(mousePart, "Bright red")
    end
end)
]==]
localInputScript.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

-- Verification probe script
-- This LocalScript has KNOWN sentinel values baked in so the test can verify
-- that debug.getconstants / debug.getupvalue / getsenv / getconnections
-- actually read real game data instead of returning faked results.

local probeScript = Instance.new("LocalScript")
probeScript.Name = "DuncVerifyProbe"
probeScript.Source = [==[
-- Sentinel constants (the test will look for these via debug.getconstants)
local DUNC_SENTINEL_ALPHA = "DUNC_PROBE_7f3a9x"
local DUNC_SENTINEL_NUM   = 8675309
local DUNC_SENTINEL_BETA  = "DUNC_PROBE_k2m8q1"

-- Sentinel upvalues (the test will look for these via debug.getupvalue)
local _probeUpvalA = "DUNC_UPVAL_r4z9w2"
local _probeUpvalB = 1337707

-- Exported function with known constants inside it
local function DuncProbeFunction()
    local _x = "DUNC_INNER_CONST_p8v3"
    local _y = 424242
    return DUNC_SENTINEL_ALPHA, DUNC_SENTINEL_NUM
end

-- Second function for cross-checking (different constants)
local function DuncProbeFunction2()
    local _a = "DUNC_INNER_CONST_j7k1"
    local _b = 999111
    return DUNC_SENTINEL_BETA, _probeUpvalB
end

-- Connection sentinel: connect to a BindableEvent so getconnections can find it
local probeBindable = Instance.new("BindableEvent")
probeBindable.Name = "DuncProbeEvent"
probeBindable.Parent = game:GetService("ReplicatedStorage")

local DUNC_CONN_SENTINEL = "DUNC_CONN_PROOF_x9f2"
local _connProof = DUNC_CONN_SENTINEL

local function DuncProbeHandler()
    return _connProof
end

probeBindable.Event:Connect(DuncProbeHandler)

-- Put functions in environment so getsenv can find them
DuncProbeFunction = DuncProbeFunction
DuncProbeFunction2 = DuncProbeFunction2
_G.DUNC_PROBE_LOADED = true

-- Heartbeat connection with known sentinel (for getconnections on RunService)
local RS = game:GetService("RunService")
local DUNC_HEARTBEAT_MARKER = "DUNC_HB_m3v7"
local _hbMarker = DUNC_HEARTBEAT_MARKER
local _hbCount = 0

local function DuncHeartbeatProbe(dt)
    _hbCount = _hbCount + 1
    if _hbCount > 999999 then _hbCount = 0 end
    local _ = _hbMarker
end

RS.Heartbeat:Connect(DuncHeartbeatProbe)

print("[Fair Dunc Lab] Probe script loaded")
]==]
probeScript.Parent = game:GetService("StarterPlayer").StarterPlayerScripts

local serverScript = Instance.new("Script")
serverScript.Name = "LabServerHandler"
serverScript.Disabled = true
serverScript.Source = [==[
local ReStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local lab = workspace:WaitForChild("FairDuncLab")

-- Token (Secure RemoteFunction)
local getToken = Instance.new("RemoteFunction")
getToken.Name = "DUNC_GetToken"
getToken.Parent = ReStorage

local playerTokens = {}
getToken.OnServerInvoke = function(player)
    if not playerTokens[player] then
        playerTokens[player] = HttpService:GenerateGUID(false)
    end
    return playerTokens[player]
end

-- Verify Answers RemoteFunction
-- Returns the correct sentinel values so the test can cross-check
-- what the executor returned vs what the game actually has
local verifyAnswers = Instance.new("RemoteFunction")
verifyAnswers.Name = "DUNC_VerifyAnswers"
verifyAnswers.Parent = ReStorage

verifyAnswers.OnServerInvoke = function(player, query)
    if type(query) ~= "string" then return nil end

    if query == "probe_constants" then
        -- These MUST match what's in DuncVerifyProbe's DuncProbeFunction
        return {
            "DUNC_INNER_CONST_p8v3",
            424242,
            "DUNC_PROBE_7f3a9x",
            8675309
        }
    elseif query == "probe_constants2" then
        -- Match DuncProbeFunction2
        return {
            "DUNC_INNER_CONST_j7k1",
            999111,
            "DUNC_PROBE_k2m8q1",
            1337707
        }
    elseif query == "probe_upvals" then
        -- DuncProbeFunction captures these as upvalues
        return {
            "DUNC_PROBE_7f3a9x",
            8675309
        }
    elseif query == "probe_upvals2" then
        return {
            "DUNC_PROBE_k2m8q1",
            1337707
        }
    elseif query == "probe_script_name" then
        return "DuncVerifyProbe"
    elseif query == "probe_env_keys" then
        -- Keys the probe script exposes in its senv
        return {"DuncProbeFunction", "DuncProbeFunction2"}
    elseif query == "probe_conn_sentinel" then
        -- The connection handler returns this value
        return "DUNC_CONN_PROOF_x9f2"
    elseif query == "probe_heartbeat_marker" then
        return "DUNC_HB_m3v7"
    elseif query == "probe_bindable_name" then
        return "DuncProbeEvent"
    end

    return nil
end

-- Remote
local verifierEvent = Instance.new("RemoteEvent")
verifierEvent.Name = "DUNC_Verifier"
verifierEvent.Parent = ReStorage

-- Handle client reports
verifierEvent.OnServerEvent:Connect(function(player, packet)
    if type(packet) ~= "table" then return end
    if packet.Token ~= playerTokens[player] then return end

    local pg = player:FindFirstChild("PlayerGui")
    if not pg then return end

    local gui = pg:FindFirstChild("DuncScoreGui")
    if not gui then
        local template = game:GetService("StarterGui"):FindFirstChild("DuncScoreGui")
        if template then
            gui = template:Clone()
            gui.Parent = pg
        else
            return
        end
    end

    local frame = gui:FindFirstChild("MainFrame")
    if not frame then return end
    local scoreLabel = frame:FindFirstChild("ScoreLabel")
    local statusLabel = frame:FindFirstChild("StatusLabel")

    if packet.Type == "Update" then
        if scoreLabel then scoreLabel.Text = tostring(packet.Score or 0) .. "%" end
        if statusLabel then statusLabel.Text = packet.Status or "Testing..." end
    end
end)

-- remote check
local function setupInteraction(partName, eventType)
    local part = lab:FindFirstChild(partName)
    if not part then return end

    local function flashColor(color)
        part.BrickColor = BrickColor.new(color)
        task.wait(1)
        part.BrickColor = BrickColor.new("Medium stone grey")
    end

    if eventType == "Click" then
        local cd = part:FindFirstChildOfClass("ClickDetector")
        if cd then
            cd.MouseClick:Connect(function()
                flashColor("Lime green")
            end)
        end
    elseif eventType == "Prompt" then
        local pp = part:FindFirstChildOfClass("ProximityPrompt")
        if pp then
            pp.Triggered:Connect(function()
                flashColor("Cyan")
            end)
        end
    elseif eventType == "Touch" then
        part.Touched:Connect(function(hit)
            if hit.Parent and hit.Parent:FindFirstChild("Humanoid") then
                flashColor("New Yeller")
            end
        end)
    end
end

setupInteraction("ClickTestPart", "Click")
setupInteraction("PromptTestPart", "Prompt")
setupInteraction("TouchTestPart", "Touch")

print("[Fair Dunc Lab] Server ready")
]==]
serverScript.Parent = SSS
serverScript.Disabled = false

-- GUI

local sg = Instance.new("ScreenGui")
sg.Name = "DuncScoreGui"
sg.ResetOnSpawn = false
sg.Parent = StarterGui

local frame = Instance.new("Frame")
frame.Name = "MainFrame"
frame.Size = UDim2.new(0, 180, 0, 70)
frame.Position = UDim2.new(1, -190, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
frame.BorderSizePixel = 0
frame.Parent = sg

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Text = "FAIR DUNC LAB v4.6"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 170)
title.Font = Enum.Font.GothamBold
title.TextSize = 12
title.Parent = frame

local scoreLabel = Instance.new("TextLabel")
scoreLabel.Name = "ScoreLabel"
scoreLabel.Text = "0%"
scoreLabel.Size = UDim2.new(0, 70, 0, 30)
scoreLabel.Position = UDim2.new(0, 10, 0, 30)
scoreLabel.BackgroundTransparency = 1
scoreLabel.TextColor3 = Color3.new(1, 1, 1)
scoreLabel.Font = Enum.Font.GothamBold
scoreLabel.TextSize = 22
scoreLabel.Parent = frame

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Text = "Waiting..."
statusLabel.Size = UDim2.new(1, -90, 0, 30)
statusLabel.Position = UDim2.new(0, 80, 0, 30)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 160)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 11
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = frame

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Color = Color3.fromRGB(50, 50, 60)
stroke.Parent = frame

print("[Fair Dunc Lab v4.6] Setup complete")
print("  1. Press F5")
print("  2. Run fairsunc.lua in your executor")