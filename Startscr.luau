local CutsceneModule=require(game.ReplicatedStorage.Modules.Cutscene)

game.ReplicatedStorage.Remotes.Start.OnClientEvent:Connect(function()
	--CutsceneModule.Initiate('ALMOSTstart')
	--CutsceneModule.Initiate('ends')
	CutsceneModule.Initiate('Start')

end)
