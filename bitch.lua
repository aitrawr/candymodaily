-- UI LIB
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/0x"))()
local w1 = library:Window("Candy / Gift TP")

-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")

-- SETTINGS
local offset = Vector3.new(0, 3, 0)
local nudge = Vector3.new(1.5, 0, 0) -- 👈 anti-stuck movement
local teleportDelay = 0.5

local enabled = false

print("[DEBUG] Teleporter loaded")

-- UTIL
local function getModelPart(model)
	if model.PrimaryPart then
		return model.PrimaryPart
	end

	for _, v in ipairs(model:GetDescendants()) do
		if v:IsA("BasePart") then
			return v
		end
	end

	return nil
end

local function teleportToModel(model)
	if not model or not model:IsA("Model") then return end

	local part = getModelPart(model)
	if not part then
		print("[DEBUG] No BasePart in model:", model.Name)
		return
	end

	print("[DEBUG] TP ->", model.Name)

	-- teleport
	root.CFrame = CFrame.new(part.Position + offset)
	task.wait(0.1)

	-- anti-stick nudge
	root.CFrame = root.CFrame + nudge
	task.wait(teleportDelay)
end

-- LOOP
task.spawn(function()
	while true do
		if enabled then
			local candy = workspace:FindFirstChild("Candy")
			if candy then
				teleportToModel(candy)
			end

			local gift = workspace:FindFirstChild("Gift")
			if gift then
				teleportToModel(gift)
			end
		end

		task.wait(0.5)
	end
end)

-- UI TOGGLE
w1:Toggle(
	"Enable Candy/Gift TP",
	"cgtp",
	false,
	function(t)
		enabled = t
		print("[DEBUG] Teleporter enabled:", t)
	end
)

w1:Button(
	"Destroy GUI",
	function()
		for _, v in pairs(game.CoreGui:GetChildren()) do
			if v:FindFirstChild("Top") then
				v:Destroy()
			end
		end
	end
)
