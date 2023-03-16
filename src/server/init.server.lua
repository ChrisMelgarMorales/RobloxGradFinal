print("Hello world, from server!")
-- Get a reference to the server script
local serverScript = game:GetService("ServerScriptService"):WaitForChild("Server")

-- Get a reference to the StringValue instance
local stringValue = serverScript:FindFirstChild("whitelist")

-- Check if the StringValue was found
local whitelistUserIDs = {}
if stringValue then
    -- Access the value of the StringValue
	local substrings = string.split(stringValue.Value, "\n")
	
	-- Convert each substring to a number and add it to an array
	
	for i, substring in ipairs(substrings) do
		whitelistUserIDs[i] = tonumber(substring)
	end
	
	-- Print the array of numbers
	print(table.concat(whitelistUserIDs, ", "))
else
    print("Could not find the whitelist.txt instance!")
end

-- Get a reference to the StringValue instance
local stringValue = serverScript:FindFirstChild("admins")

-- Check if the StringValue was found
local adminUserIDs = {}
if stringValue then
    -- Access the value of the StringValue
	local substrings = string.split(stringValue.Value, "\n")
	
	-- Convert each substring to a number and add it to an array
	
	for i, substring in ipairs(substrings) do
		adminUserIDs[i] = tonumber(substring)
	end
	
	-- Print the array of numbers
	print(table.concat(adminUserIDs, ", "))
else
    print("Could not find the admins.txt instance!")
end


local Players = game:GetService("Players")


Players.PlayerAdded:Connect(function(player)

	if not table.find(whitelistUserIDs,player.UserId) then --If the UserID value is not in the table this returns nil. In Lua nil equals false.
		player:Kick("You are not whitelisted on this server.")
	end

end)

local Commands = require(script.HostControls)
adminRank = 255

game.Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(msg)
        msg = string.lower(msg)
        local split = string.split(msg, ' ')
        local cmd  = split[1]
        if cmd:sub(1, 1) ~= "!" then return end
        if not table.find(adminUserIDs,player.UserId) then
            game:GetService("Chat"):Chat(player, "You do not have permission to use this command.")
            return
        end
        if Commands[cmd:sub(2,#cmd)] then 
            Commands[cmd:sub(2,#cmd)](player, split)
        end
    end)
end)
