local debounce=false 
local Loaded=false
script.Parent.ClickDetector.MouseClick:Connect(function(Player)
	if debounce then return end
	debounce=true
	if not Loaded then
		Loaded=true
		for _,v in workspace:GetDescendants() do
			if v:IsA('BasePart') and not v.Anchored  then
				pcall(function() v:SetNetworkOwner(Player) end)
			end
		end

		for _,v in workspace.Character:GetChildren() do --idk, do stuff to load the character
			--very confusing ik
			if not v:HasTag('plr') then continue end
			v.Humanoid:ApplyDescriptionAsync(game.Players:GetHumanoidDescriptionFromUserIdAsync(Player.UserId))
		end
	end

	game.ReplicatedStorage.Remotes.Start:FireClient(Player)
	task.wait(12) -- no doubleclicking
	-- so ground breaking ik
	debounce=false
end) 
