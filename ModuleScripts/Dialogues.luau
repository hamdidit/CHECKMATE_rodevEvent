local ReplicatedStorage=game.ReplicatedStorage
local DialogueApperance=require(ReplicatedStorage.Modules.apperance)
local config=require(game.ReplicatedStorage.Modules.Stats)
local Parent=game.Players.LocalPlayer.PlayerGui:WaitForChild('Custence'):WaitForChild('Dialogue')
local TextLabel=Parent:WaitForChild('TextLabel')
local UISTROKE=Parent:WaitForChild('UIStroke')


local ShowPosition=Parent.Position
local HidePosition=ShowPosition+UDim2.fromOffset(0,250)
local IsVisible=false
local CurrentTextid=tick()
local SKIP=tick() -- uses tick 

local SpeedLetter={
	['.']=2,
	[',']=1,
	['!']=.5,
	['?']=.5,
	['-']=-99,
	[' ']=-99,
	['(']=-99,
	[')']=-99,


}

function createtween(a,T:{any},c)
	T=T or {}

	local b=TweenInfo.new(
		T[1] or 2
		,T[2] or Enum.EasingStyle.Linear
		,T[3]  or Enum.EasingDirection.In
		,T[4] or 0
	)
	return game.TweenService:Create(a,b,c)
end

function DialogueStart(IDApperance:string,text:string,rig:Model?)
	print(`{IDApperance}: "{text}"`)
	local Apperance:typeof(DialogueApperance.dude)=DialogueApperance[IDApperance]
	text=text or 'i forgot the script :( '

	if  not DialogueApperance[IDApperance] then
		IsVisible=false
		createtween(Parent,{1},{Position=HidePosition}):Play()
		return
	end

	TextLabel.MaxVisibleGraphemes=0
	TextLabel.Text=text

	do-- apperance change
		Parent.BackgroundColor3=Apperance.BackgroundColor
		TextLabel.TextColor3=Apperance.TextColor
		UISTROKE.Color=Apperance.OutlineColor
		TextLabel.Font=Apperance.Font
	end

	if not IsVisible then
		IsVisible=true
		local tw=createtween(Parent,{.5},{Position=ShowPosition})
		tw:Play() tw.Completed:Wait() tw:Destroy()

	end

	local VISIBLEtext= text:gsub("<.->", "") -- MAKING SURE no NAUGHTY richtext thing wont go through!
	local ID=tick()
	CurrentTextid=ID
	local Head=nil
	local Thought=false
	if rig then
		Head=rig:WaitForChild('Head')
	end
	local function mouthtalk(yes)
		if not Head then return end
		if not Head:FindFirstChild('close') or not Head:FindFirstChild('open') then return end
		Head.close.Transparency=yes and 1 or 0
		Head.open.Transparency=(yes and not Thought and 0) or 1
		if Head:FindFirstChild('thought') then
			Head.thought.Transparency=(yes and Thought and 0) or 1
		end
	end

	local lastskip=SKIP
	local i=0
	Parent.arrow.Visible=false
	for _imodif=1,#VISIBLEtext do
		i=math.max(_imodif,i)
		if ID~=CurrentTextid then
			return
		end
		TextLabel.MaxVisibleGraphemes=i
		local CurrentWait=1-- in letter, meant 1 letter
		local CurrentLetter=string.sub(VISIBLEtext,i,i)

		if CurrentLetter=="(" then
			Thought=true
		elseif CurrentLetter==")" then
			Thought=false
		elseif CurrentLetter=='-' and i==#VISIBLEtext then -- cutoff!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			SKIP=-1
			i=#VISIBLEtext
			task.wait(.3) 
		end
		if SpeedLetter[CurrentLetter] then
			CurrentWait+=SpeedLetter[CurrentLetter]
			mouthtalk(false)
		else
			local s:Sound=Apperance.Sound:Clone()
			s.Parent=script
			s.Volume+=CurrentLetter:upper()==CurrentLetter and .3 or 0 -- shouthing
			s:Play()
			mouthtalk(true)
			game.Debris:AddItem(s,s.TimeLength+1)
		end

		--too long, get skippped
		if lastskip~=SKIP then
			TextLabel.MaxVisibleGraphemes=-1 --show the full thingy
			break
		end


		if CurrentWait>0 then
			CurrentWait/=config.letter_Speed --gotta go fast
			local hwait=0
			while hwait<CurrentWait and ID==CurrentTextid and SKIP==lastskip do --custom waiting :sog:
				hwait+=game["Run Service"].RenderStepped:Wait()
			end
		end
	end
	mouthtalk(false)
	TextLabel.MaxVisibleGraphemes=-1 --show the full thingy

	local isid=ID==CurrentTextid

	if SKIP>=0 then -- does skip is being skipped?
		SKIP=lastskip -- wait for it!!
		Parent.arrow.Visible=true
		while task.wait(.03) and SKIP==lastskip do end --wait for inputt
		isid=ID==CurrentTextid
		Parent.arrow.Visible=false
	else
		SKIP=1
	end
	--e
	return isid
end

DialogueStart() -- hide the ui!
task.delay(1,function()
	Parent.Visible=true
end)
Parent:WaitForChild('SKIP').Activated:Connect(function()
	SKIP=tick()
end)

task.spawn(function()
	local ogpos=Parent:WaitForChild('arrow').Position
	while true~=false do
		local TWIN1=game.TweenService:Create(Parent.arrow,TweenInfo.new(1),{Position=ogpos-UDim2.fromOffset(15,0)})
		TWIN1:Play() TWIN1.Completed:Wait()
		local TWIN2=game.TweenService:Create(Parent.arrow,TweenInfo.new(1),{Position=ogpos})
		TWIN2:Play() TWIN2.Completed:Wait()
	end
end)

return DialogueStart
