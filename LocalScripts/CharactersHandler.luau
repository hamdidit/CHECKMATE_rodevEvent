local CharacterFolder=workspace.Character
local AnimationsFolder=script.Animations
local Characters:{[Instance]:{[any]:AnimationTrack}}={}

function PlayAnimation(Char,id,cmd)
	local Animations=Characters[Char]
	if not Animations then return end

	local Anim=Animations[id]
	if not Anim then return end

	if cmd=='play' then
		Anim:Play()
	elseif cmd=='stop' then
		Anim:Stop()
	end

end

function add(Char:Model)
	local Humanoid:Humanoid	=Char:WaitForChild('Humanoid')
	local Animator:Animator		=Humanoid:WaitForChild('Animator')

	local Animations:{[any]:AnimationTrack}={	}
	for _,anim in  AnimationsFolder:GetChildren() do
		local toload=nil
		if anim:IsA('Animation') then
			toload=anim			
		elseif anim:FindFirstChildWhichIsA('Animation') then
			toload=anim:FindFirstChildWhichIsA('Animation')
		end

		if toload then
			Animations[toload.Name]=Animator:LoadAnimation(toload)
		end
	end

	if Animations['idle'] then
		Animations['idle']:Play()
	end

	Humanoid.Running:Connect(function(s)
		if s>0 then
			if not Animations.walk.IsPlaying  then
				Animations['walk']:Play()
			end
			
		else

			if Animations['walk'].IsPlaying then
				Animations['walk']:Stop ()
			end
		end

	end)
	Characters[Char]=Animations
	
	if Char:HasTag('sit') then
		Animations.sit:Play()
		Animations.idle:Stop()
	end
end

for _,Char in CharacterFolder:GetChildren() do
	add(Char)
end
CharacterFolder.ChildAdded:Connect(add) -- making sure player wont miss something something..,.


game.ReplicatedStorage.Event.PlayAnimation.Event:Connect(PlayAnimation)

