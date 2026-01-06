local player = game:GetService("Players").LocalPlayer
local character = player.Character or player.CharacterAdded:wait()
local rootpart = character:WaitForChild("HumanoidRootPart")

local teleportoffset = Vector3.new(0,3,0)
local collectionrange = 15
local checkdelay 0.6 
local healthvaluename = "Health"

local function teleportto(target)
     if target and target:IsA("BasePart") then
     rootpart.CFrame = CFrame.new(target.Position + teleportoffset)
     task.wait(0.6)
    end
end

local function collectnearbycash()
    local cashfolder = workspace:FindFirstChild("Cash")
    if cashfolder then 
       for _, cash in ipairs(cashfolder:GetChildren()) do
           if (cash.Position - rootpart.Position).Magnitiude <= collectionrange then
                local prompt = cash:FindFirstChildWhichIsA("ProximityPrompt")
                if prompt then 
                    fireproximityprompt(prompt)
                end
            end
        end
    end
end

local function istargetdestroyed(targetobj)
     if not targetobj or not targetobj.Parent then return true end
    
     local healthvalue = targetobj:FindFirstChild(healthvaluename)
     if healthvalue:IsA("IntValue") then
    return healthvalue.Value <= 0
        end
    end 
    return false
end 

local function findnewtarget() 
local damageables = workspace:FindFirstChild("Damageables")
   if not damageables then return nil end
   end 
   for _, (obj.Name == "ATM" or obj.Name == "CashRegister") then
    local part = obj:FindFirstChildWhichIsA("BasePart")
    local healthvalue = obj:FindFirstChild(healthvaluename)
    if part and (not healthvalue or (healthvalue:IsA("IntValue") and healthvalue.Value > 0)) then
    return part, obj end
      end
   end
   return nil
end

while true do 
       collectnearbycash()
       
       local targetpart, targetobj, = findnewtarget()
       if targetpart then teleportto(targetpart)
        repeat
            collectnearbycash()
            task.wait(checkdelay)
        until istargetdestroyed(targetobj)
    else
        task.wait(checkdelay)
     end
end
