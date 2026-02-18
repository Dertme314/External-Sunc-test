--[[
    Fair Dunc Lab v4.5
    Setup — map, server handler, GUI
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
cleanInstance(ReStorage, "DUNC_Token")
cleanInstance(ReStorage, "DUNC_Verifier")

-- Map

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

-- 1. Click Detector
local clickPart = makeTestPart("ClickTestPart", Vector3.new(10, 2, 0))
local cd = Instance.new("ClickDetector")
cd.MaxActivationDistance = 200
cd.Parent = clickPart
addBillboard(clickPart, "Click Detector Test")

-- 2. Proximity Prompt
local promptPart = makeTestPart("PromptTestPart", Vector3.new(-10, 2, 0))
local prompt = Instance.new("ProximityPrompt")
prompt.MaxActivationDistance = 200
prompt.HoldDuration = 0
prompt.Parent = promptPart
addBillboard(promptPart, "Proximity Prompt Test")

-- 3. Touch
local touchPart = makeTestPart("TouchTestPart", Vector3.new(0, 2, 10))
touchPart.CanTouch = true
addBillboard(touchPart, "Touch Interest Test")

-- Server Script

local serverScript = Instance.new("Script")
serverScript.Name = "LabServerHandler"
serverScript.Source = [==[
local ReStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local lab = workspace:WaitForChild("FairDuncLab")

-- Token
local tokenValue = Instance.new("StringValue")
tokenValue.Name = "DUNC_Token"
tokenValue.Value = HttpService:GenerateGUID(false)
tokenValue.Parent = ReStorage

-- Remote
local verifierEvent = Instance.new("RemoteEvent")
verifierEvent.Name = "DUNC_Verifier"
verifierEvent.Parent = ReStorage

-- Handle client reports
verifierEvent.OnServerEvent:Connect(function(player, packet)
    if type(packet) ~= "table" then return end
    if packet.Token ~= tokenValue.Value then return end

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

-- Interaction handlers (these MUST be here to survive Play)
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
title.Text = "FAIR DUNC LAB v4.5"
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

print("[Fair Dunc Lab v4.5] Setup complete")
print("  1. Press F5")
print("  2. Run fairsunc.lua in your executor")