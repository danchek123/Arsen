getgenv().ServerHop = 14
getgenv().TaskWaitUntilHop = 5
getgenv().Message = ""
getgenv().webhook = "https://discordapp.com/api/webhooks/1131597516341792868/SiN1CkTQ35TsBw10YNQd43nibBCwsYzQKdT7It83niHj8zuRWFlfV-na9Y4oUcRqIeo1"
getgenv().ItemsToFarm = {
    --[[THE FORMAT IS // ФОРМАТ I

	["ITEM"] = {
        Max = ITEMAMOUNT, (сумма товара)
        Sell = true (Продать)
    },

    ]]--
	["Lucky Arrow"] = {
        Max = 10,
        Sell = false,
    },

    ["Lucky Stone Mask"] = {
        Max = 10,
        Sell = false,
    },


};

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer.Character

local HttpService = game:GetService("HttpService")
local url = getgenv().webhook

local function log(string)
    local message = {
        ["content"] = string
    }
    local atama = {
            ["content-type"] = "application/json"
    }
    
    local request_body_encoded = HttpService:JSONEncode(message)
    local request_payload = {Url=url, Body=request_body_encoded, Method="POST", Headers=atama}
    local request = http_request or request or HttpPost or syn.request or http.request
    request(request_payload)
end

local LocalPlayer = game.Players.LocalPlayer
local Character = LocalPlayer.Character
repeat task.wait() until Character:FindFirstChild("RemoteEvent") and Character:FindFirstChild("RemoteFunction")

local RemoteEvent = Character.RemoteEvent

local Hook;
Hook = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local args = {...}
    local namecallmethod =  getnamecallmethod()
    
    if (namecallmethod == "InvokeServer" or namecallmethod == "InvokeClient" or namecallmethod == "FireServer") and (args[1] == "Reset" or args[1] == "idklolbrah2de") then
        return "  ___XP DE KEY"
    end

    return Hook(self, ...)
end))


local serverToHop = "notYet"

local function serverHop()
    task.spawn(function()
        local file

        if isfile("NotSameServers.json") then
            file = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        else
            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode({game.JobId}))
            file = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
        end

        local Url = "https://games.roblox.com/v1/games/2809202155/servers/Public?sortOrder=Desc&limit=100"
        local Cursor = game:GetService("HttpService"):JSONDecode(game:HttpGet(Url)).nextPageCursor
        local Got = false

        repeat
            local Faster = game:GetService("HttpService"):JSONDecode(game:HttpGet(Url.."&cursor="..tostring(Cursor)))
            for _,server in next, Faster.data do
                if server.playing then
                    print(server.playing)
                        local clampedAmount = math.clamp(getgenv().ServerHop, (server.playing-1), (server.playing+1))
                        if clampedAmount <= getgenv().ServerHop and not table.find(file, server.id) then
                            table.insert(file, server.id)
                            writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(file))
                            Got = true
                            serverToHop = server.id
                            break
                        end
                    end
                end
            Cursor = Faster.nextPageCursor or Cursor
            task.wait(0.5)
        until Got == true
    end)

    game:GetService("TeleportService").TeleportInitFailed:Connect(function()
        serverToHop = "notyet"; serverHop()
        while serverToHop == "notyet" do
            task.wait()
        end
        game:GetService("TeleportService"):TeleportToPlaceInstance(2809202155, serverToHop, game.Players.LocalPlayer)
    end)
end

serverHop()

if not LocalPlayer.PlayerGui:FindFirstChild("HUD") then
    print("hiii")
    local HUD = game:GetService("ReplicatedStorage").Objects.HUD:Clone()
    HUD.Parent = LocalPlayer.PlayerGui
end

pcall(function()
    print("https://discord.gg/YrAa5ngDPv")
    RemoteEvent:FireServer("PressedPlay")

    LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen1"):Destroy()
    task.wait(0.5)
    LocalPlayer.PlayerGui:FindFirstChild("LoadingScreen"):Destroy()

    workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_6.Size = Vector3.new(2048, 89, 2048)
    workspace.Map.IMPORTANT.OceanFloor.OceanFloor_Sand_4.Size = Vector3.new(2048, 89, 2048)
end)

hookfunction(workspace.Raycast, function()
    return
end)

local function getitem(item)
    local gotItem = false
    local timeout = 5
    local itemPosition = item.PrimaryPart.CFrame - Vector3.new(0,0,0)

    LocalPlayer.Backpack.ChildAdded:Connect(function()
        gotItem = true
    end)
    
    task.spawn(function()
        while not gotItem do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = itemPosition
        end
    end)

    task.wait(0.5)
    fireproximityprompt(item.ProximityPrompt)
    
    task.spawn(function()
        for i=timeout, 1, -1 do
            task.wait(1)
        end

        if not gotItem then
            gotItem = true
            return
        end
    end)


    while not gotItem do
        task.wait()
    end
end

local function checkItem(item)
    local itemExists = item:FindFirstChild("ProximityPrompt")

    if not itemExists then
        return
    end
    local itemPP = item.ProximityPrompt
    if itemPP.MaxActivationDistance == 8 then
        item.Name = item.ProximityPrompt.ObjectText
    else
        print("NANI?! FAKE ".. item.ProximityPrompt.ObjectText.. " ITEM?! NAZE dank#0421-KUN?")
    end
end


--watcher
game.Workspace["Item_Spawns"].Items.DescendantAdded:Connect(function(descendant)
    if descendant:IsA("ProximityPrompt") then
        local itemInstance = descendant:FindFirstAncestorWhichIsA("Model")
        checkItem(itemInstance)
    end
end)

LocalPlayer.PlayerGui.ChildAdded:Connect(function(child)
	if child.Name == "ScreenGui" then
        print("fired")
        local screenGui = LocalPlayer.PlayerGui:WaitForChild("ScreenGui", 5)
        local part = screenGui:WaitForChild("Part")
    
        for _, button in pairs(part:GetDescendants()) do
            if button:FindFirstChild("Part") then
                if button:IsA("ImageButton") and button.Part.TextColor3 == Color3.new(0, 1, 0) then
                    repeat
                        firesignal(button.MouseEnter)
                        firesignal(button.MouseButton1Up)
                        firesignal(button.MouseButton1Click)
                        firesignal(button.Activated)
                        task.wait()
                    until not LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
                end
            end
        end
	end
end)


--hook here so descendantadded can have some time
local itemHook;

itemHook = hookfunction(getrawmetatable(game.Players.LocalPlayer.Character.HumanoidRootPart.Position).__index, function(p,i)
        if getcallingscript().Name == "ItemSpawn" and i:lower() == "magnitude" then
            return 0
        end
    return itemHook(p,i)
end)

--count items
local function checkIfFull(itemName, amount)
    local itemAmount = 0

    for _,item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name == itemName then
            itemAmount += 1;
        end
    end

    if amount then
        if itemAmount >= (amount) then
            return true
        else
			return false
		end
    end

    return itemAmount
end

--farm, repeats it
local function farmItem(item, amount, autoSell)
    local iteminstance = workspace.Item_Spawns.Items:FindFirstChild(item)

    if workspace.Item_Spawns.Items:WaitForChild(item, 5) then
        if checkIfFull(item, amount) then
            return true
        end

        if iteminstance then
            getitem(iteminstance)
            if autoSell then
                LocalPlayer.Character.Humanoid:EquipTool(LocalPlayer.Backpack:FindFirstChild(item))
                local dialogueToEnd = {
                    ["NPC"] = "Merchant",
                    ["Dialogue"] = "Dialogue5",
                    ["Option"] = "Option2"
                }
                RemoteEvent:FireServer("EndDialogue", dialogueToEnd)
            end
            farmItem(item, amount, autoSell)
        end
    else
        return true
    end
end


--failsafe
task.spawn(function()
    LocalPlayer.CharacterAdded:Connect(function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(2809202155, serverToHop, game.Players.LocalPlayer)
    end)
end)


local function countItems(item)
	local itemAmount = 0
	for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
 	   if v.Name == item then
     		itemAmount = itemAmount + 1
  	   end
	end
	return tostring(itemAmount)
end


--mainfunction
task.wait(getgenv().TaskWaitUntilHop)
local part = Instance.new("Part")
part.Anchored = true
part.Size = Vector3.new(25,1,25)
part.Parent = workspace
part.Position = Vector3.new(500, 2000, 500)

log(getgenv().PersonalizedMessage)
local itemsMessage = ""

for itemName, itemData in pairs(getgenv().ItemsToFarm) do
    local maxAmount = itemData.Max
    local shouldSell = itemData.Sell

    if shouldSell then
        farmItem(itemName, maxAmount, true)
    else
        farmItem(itemName, maxAmount)
    end

    itemsMessage = itemsMessage .. countItems(itemName) .. " " .. itemName .. ", "
    Character.HumanoidRootPart.CFrame = part.CFrame + Vector3.new(0,5,0)
end

itemsMessage = itemsMessage:sub(1, -3)
log(itemsMessage)



while serverToHop == "notyet" do
    task.wait(1)
end

game:GetService("TeleportService"):TeleportToPlaceInstance(2809202155, serverToHop, game.Players.LocalPlayer)
