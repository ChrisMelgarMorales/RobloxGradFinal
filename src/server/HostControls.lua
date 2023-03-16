local Commands = {}

function Commands.begin(player, args)
    local seats = game.Workspace.EventModel.Seating:GetChildren()
    for i,v in ipairs(game.Players:GetPlayers()) do
        if (v.Character and v ~= player) then 
            local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Sit == false then
                -- Teleport the player to the seat's position
				player.Character:SetPrimaryPartCFrame(CFrame.new(seats[1].Position + Vector3.new(0, 5, 0)))
                humanoid.Sit = true
            end
        end
    end
end
return Commands