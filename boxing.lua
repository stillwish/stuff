local Link = getgenv().Webhook

-- stole this from iku autofarm cause i forgot what they were LOL
repeat task.wait() until (game:GetService("Players").LocalPlayer.Character:FindFirstChild("FULLY_LOADED_CHAR"))
game:GetService("RunService"):Set3dRenderingEnabled(false)
pcall(function() UserSettings().GameSettings.MasterVolume = 0 end)
pcall(function() settings().Rendering.QualityLevel = "Level01" end)

local function Attack()
    if game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Combat") then
        pcall(function()
            game:GetService("Players").LocalPlayer.Backpack.Combat.Parent = game:GetService("Players").LocalPlayer.Character
        end)
    end
        
    local Combat = game:GetService("Players").LocalPlayer.Character:FindFirstChild("Combat")
    if Combat == nil then return print("no combat tool :(") end
        
    Combat:Activate()
    task.wait()
    Combat:Deactivate()
end

local function StartBoxing()
    local HumanoidRootPart = game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local Humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")

    HumanoidRootPart.CFrame = CFrame.new(-251, 22, -1135)
    repeat
        task.wait(0.1)
        Attack()
    until game:GetService("Players").LocalPlayer.DataFolder:WaitForChild("Information"):FindFirstChild("BoxingValue").Value == "2500"
    
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "".. game:GetService("Players").LocalPlayer.Name,
            ["description"] = "Account has reached max boxing value!",
            ["color"] = tonumber(0x2F3136),
            ["footer"] = {
                ["text"] = "account kicked / made by @stillwish"
            }
        }}
    }
    local response = request({Url=Link, Body=game:GetService("HttpService"):JSONEncode(data), Method = "POST", Headers={["content-type"] = "application/json"}})

    task.wait(0.3)
    HumanoidRootPart.CFrame = CFrame.new(-236, 19, -1141)
    local Moveset = workspace.Ignored.Shop["Boxing Moveset (Require: Max Box Stat) - $0"]
    fireclickdetector(Moveset.ClickDetector)
    print("boxing complete")
    game:GetService("Players").LocalPlayer:Kick("Boxing complete")

end

StartBoxing()
