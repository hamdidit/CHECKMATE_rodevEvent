local Cams=workspace.Cams
local ChessBoardBlack=workspace.ChessBoard.Black
local Characters=workspace.Character
local Pathh=workspace.Path
local TIMEtextlabel=workspace:WaitForChild('THEDATe'):WaitForChild('SurfaceGui'):WaitForChild('TextLabel')
local TwServ=game:GetService(`TweenService`)
local GUI=game.Players.LocalPlayer.PlayerGui
local memorybuton=GUI:WaitForChild('START'):WaitForChild('MemoryButton')
local BindEvent=game.ReplicatedStorage:WaitForChild('Event')

local King=Characters:WaitForChild('King')
local Queen=Characters:WaitForChild('Queen')
local hershotgun=Queen:WaitForChild('Shotgun')

local skipping=false
local _DoDialogue=require(game.ReplicatedStorage.Modules.Dialogues)
local  CONFIG=require(game.ReplicatedStorage.Modules.Stats)
local  MEmRY=require(game.ReplicatedStorage.Modules.Memories)

local ALREADYquestioned={}
local CUTSSCENE={}
--local nodeaaf={"herfamily" ,'kinglie'}

-- they.. talk?!?!
function DoDialogue(id,txt)
	id=id or 'plr'
	local rig=(id=="wking" and King)
		or (id=='bqueen' and Queen) or nil
	_DoDialogue(id,txt,rig)
end

--make text yellow and
function oohyellow(text)
	return `<font face="DenkOne" color="#ffea00">{text}</font>`
end
function addmemo(id)
	BindEvent.MemoryAdd:Fire(id)
end
function getmemo():string
	GUI.START.MemoryFrame.Visible=true
	GUI.START.MemoryFrame.Details.interact:SetAttribute('vis',true)
	GUI.START.MemoryButton.BackgroundColor3=Color3.new(1,1,0)
	local MEMO=BindEvent.UseMemory.Event:Wait()
	GUI.START.MemoryButton.BackgroundColor3=Color3.new(1,1,1)

	GUI.START.MemoryFrame.Details.interact:SetAttribute('vis',false)
	return MEMO
end

local noexcuses={}
--positive = more angry / less patient  (<=0 is DEATH)
-- negative = less angry / more patient (CAPPED)
function ADDanger(add:number)
	add=-(add or 0)  -- reverseitcuzIMTOOLAZOGIEoiroiooi
	CONFIG.Patient=math.min(add+CONFIG.Patient,CONFIG._PatientMax)
	print(CONFIG.Patient)
	if CONFIG.Patient<=CONFIG._PatientSnap then---ooh angry!
		 return CUTSSCENE.oohshemad()
	end

	if CONFIG.Patient<=CONFIG._PatientSnap+1 then
		doanim(Queen,'bq_angry','play')
	else
		doanim(Queen,'bq_angry','stop')
	end
end

function LookAt(part:Part,CF)
	local thecf=part.CFrame
	for i=1,20 do
		part.CFrame=thecf:Lerp(CF,i/20)
		task.wait(.02)
	end
end
function MoveTo(rig:Model,position,WAT)
	if not (rig  and typeof(rig)=='Instance' and rig:IsA('Model'))then
		warn(`what the hell is {rig}`)
		return
	end
	if typeof(position)=="Instance" then
		position=position.Position
	end

	local Humanoid=rig:FindFirstChildWhichIsA(`Humanoid`)
	Humanoid:MoveTo(position)
	doanim(rig,'walk','play')

	if WAT then
		Humanoid.MoveToFinished:Wait()
		doanim(rig,'walk','stop')
	else
		task.spawn(function()
			Humanoid.MoveToFinished:Wait()
			doanim(rig,'walk','stop')
		end)
	end
	--doanim(rig,'walk','stop')
end

function doanim(rig,id,state)
	BindEvent.PlayAnimation:Fire(rig,id,state)
end

function setface(rig:Model,facename)
	if not rig then
		warn('no rig')
		return
	end

	local Head=rig:WaitForChild('Head')
	if not Head then
		warn('no head')
		return
	end
	for _,v in Head:GetChildren() do
		if v:IsA('Decal') and v:HasTag('eye') then
			v.Transparency=v.Name==facename and 0 or 1
		end
	end
end

function SetCam(CF)
	workspace.CurrentCamera.CFrame=CF or workspace.CurrentCamera.CFrame
end

function RESET()
	TIMEtextlabel.TextTransparency=0
	TIMEtextlabel.BackgroundTransparency=0.65
	King:PivotTo(Pathh:WaitForChild('verystart').CFrame)
	Queen:WaitForChild('HumanoidRootPart'):PivotTo(Pathh:WaitForChild('chilling').CFrame)-- WHY WONT YOU GO THERE
	Queen:WaitForChild('HumanoidRootPart'):PivotTo(Pathh:WaitForChild('chilling').CFrame)-- WHY WONT YOU GO THERE
	Queen:WaitForChild('HumanoidRootPart'):PivotTo(Pathh:WaitForChild('chilling').CFrame)-- WHY WONT YOU GO THERE
	Queen:WaitForChild('HumanoidRootPart'):PivotTo(Pathh:WaitForChild('chilling').CFrame)-- WHY WONT YOU GO THERE
	Queen:WaitForChild('HumanoidRootPart'):PivotTo(Pathh:WaitForChild('chilling').CFrame)-- WHY WONT YOU GO THERE
	ChessBoardBlack:WaitForChild('Queen').CFrame=ChessBoardBlack:WaitForChild('FromQueen').CFrame
	workspace:WaitForChild('ATTAAAAAACK').Transparency=1
	memorybuton.Visible=false
	Characters:WaitForChild('RUNNINGplayer'):PivotTo(Pathh:WaitForChild('run0').CFrame)
	Characters:WaitForChild('RUNNINGdude'):PivotTo(Pathh:WaitForChild('run0').CFrame)
	game.Lighting.Atmosphere.Density=0.5
	game.Lighting.Atmosphere.Density=.5

	doanim(Queen, 'bq_chill','play')
	doanim(Queen, 'bq_idle','play')
	doanim(Queen, 'idle','stop')
	doanim(Queen,'bq_angry','stop')

	King:WaitForChild('Head'):WaitForChild('scared').Transparency=1
	King.Head:WaitForChild('scaredidle').Transparency=1
	King.Head:WaitForChild('sad').Transparency=0
	hershotgun:WaitForChild('light').Transparency=1
	hershotgun.light:WaitForChild('light2').Transparency=1
	hershotgun.light:WaitForChild('PointLight').Enabled=false

	CONFIG.Patient=CONFIG._Patient 
end

RESET()
cc={Current="",}
cc.Cutscene = CUTSSCENE

function CUTSSCENE.Start()
	-- cam show the queen moving from out of frame into frame
	SetCam(Cams:WaitForChild('trauma').CFrame)
	DoDialogue(`player`,`this board still remind me of that one time`) 
	DoDialogue() 
	task.wait(1)
	script.Restaurant:Play() --bg noise

	SetCam(Cams:WaitForChild(`mainmenu`).CFrame)
	task.wait(2)
	SetCam(Cams:WaitForChild(`queenmate`).CFrame)
	-- cam show the queen moving from out of frame into frame
	DoDialogue(`dude`,`aaaand`) 
	local TW=TwServ:Create(ChessBoardBlack.Queen,TweenInfo.new(1),{CFrame=ChessBoardBlack:WaitForChild(`ToQueen`).CFrame})
	TW:Play() TW.Completed:Wait()
	task.wait(.5)
	SetCam(Cams:WaitForChild(`MyPov`).CFrame)
	-- now cam show `dude` from the player pov
	DoDialogue(`dude`,`checkmate!, i win`)
	SetCam(Cams:WaitForChild(`dudepov`).CFrame)

	DoDialogue(`player`,`no you did not win`)

	SetCam(Cams.queenmate.CFrame)
	-- now cam show the full board
	DoDialogue(`player`,`i can clearly see that my king is not -`)

	SetCam(Cams.MyPov.CFrame)
	-- now cam in player pov
	DoDialogue(`dude`,`dude, you know how to play chess right?`)
	DoDialogue(`player`,`yes?`)
	DoDialogue(`dude`,`whats your point then?`)
	SetCam(Cams.Game.CFrame)
	workspace:WaitForChild(`ATTAAAAAACK`).Transparency=0
	DoDialogue(`dude`,`if THIS isnt a check?`)
	SetCam(CFrame.new(Cams.MyPov.Position,ChessBoardBlack.Parent.White.King.Position))
	-- now cam in player pov but now looking at the white king piece
	workspace:WaitForChild(`ATTAAAAAACK`).Transparency=1
	DoDialogue(`player`,`well you see,`) 
	DoDialogue(``)
	-- slowly zooming and black screen is fading in 
	cc.Initiate(`ALMOSTstart`)

end

function CUTSSCENE.	ALMOSTstart() 
	script.Restaurant:Stop() -- no bg noise
	script["City Night Ambience 3 (SFX)"]:Play() --bg noise
	SetCam(Cams:WaitForChild(`START`).CFrame)
	--uhhh show the location and time
	task.wait(5)
	TIMEtextlabel.Transparency=1

	SetCam(Cams:WaitForChild(`INSIDE`).CFrame)
	task.wait(2)
	MoveTo(King,Pathh:WaitForChild('almoststart').Position,true)
	task.wait(.5)
	MoveTo(King,Pathh:WaitForChild('start').Position,true)
	script.open:Play()
	task.wait(.5)
	SetCam(Cams:WaitForChild(`DOOR`).CFrame)
	-- show an outdoor that seem like backsde of a building in city
	--task.wait(2)

	-- white king open the door and walking out
	MoveTo(King,Pathh.ends.Position,true)				
	script.close:Play()
	task.wait(1)
	MoveTo(King,Pathh.look.Position,true)
	task.wait(.5)
	-- white king stops in place, shocked about something
	setface(King,'scaredidle')
	task.wait(2)
	DoDialogue(`wking`,`...who\n are you?`) 
	SetCam(Cams:WaitForChild(`lookqueen`).CFrame)

	-- camera show the frame with white king and a black figure
	DoDialogue(`bqueen`,`you already knew me, "King"`) 
	DoDialogue(`wking`,`how did you-`) 
	SetCam(Cams:WaitForChild(`toqueen`).CFrame)

	DoDialogue(`wking`,`....{oohyellow('you')}`)
	addmemo('blackqueen') 

	task.delay(1.13,function() ---oooooh magic number ooooh
		hershotgun:WaitForChild('PumpSound'):Play()
	end)
	doanim(Queen,'bq_NOchill','play')
	task.wait(.1)
	doanim(Queen,'bq_chill','stop')

	DoDialogue(`bqueen`, `the reign of the {oohyellow("White King")} ends here`)
	DoDialogue(`bqueen`, `you have nowhere left to run`)
	doanim(Queen, 'bq_NOchill', 'stop')
	addmemo('whiteking')

	-- she's  closer
	MoveTo(Queen,Pathh.shecloser.Position)
	SetCam(Cams:WaitForChild(`startgame`).CFrame)

	DoDialogue(`bqueen`, `no reinforcements are coming`)
	DoDialogue(`bqueen`, `surrender... or become {oohyellow("a dead piece")}`)
	addmemo('shemad')
	setface(King,'scared')
	addmemo('intenttokill')

	DoDialogue(`wking`, `(why {oohyellow("now")} of all times...?)`)
	addmemo('sober')

	setface(King,'scaredidle')
	memorybuton.Visible = true
	DoDialogue(`wking`, `(i need to use my memories. \nQuestion everything she said... and {oohyellow("connect")} them logicly)`)
	addmemo('combine')
	DoDialogue(`wking`, `(it's the only way out of this)`)

	cc.Initiate('questionSTART')--start it!
end

function CUTSSCENE.questionSTART()  
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	--DoDialogue(`wking`,`(maybe ill start by asking her why she's trying to killing me)`)
	DoDialogue(`wking`,`can i..`)
	DoDialogue(`wking`,`ask you something before you do anything?`)
	DoDialogue(`bqueen`,`make it quick`)

	cc.Initiate('whykillme')
	--cc.Initiate('questionLoop')
end



function CUTSSCENE.whykillme() 
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue(`wking`,`why are you doing.. this?`)  
	DoDialogue('bqueen',`isn't it obvious?`)
	DoDialogue('bqueen',`<b>I</b> was tasked by the {oohyellow("king")},black's king, and <b>you</b> killed a lot of people`)
	addmemo('blackking')
	DoDialogue('bqueen',`you like to kill. especially innocent families who never deserved it`)
	addmemo('wkingkill')
	DoDialogue('bqueen',`you like watching their sons left helpless… forcing her to fend for herself in the city`)
	task.wait(1)	DoDialogue('bqueen',`you {oohyellow("killed her family")}, you-`,true)
	addmemo('herfamily')
	DoDialogue('bqueen',`...`) 
	DoDialogue('bqueen',`you dont deserve to live`) 
	DoDialogue(`wking`,`...`)  
	cc.Initiate('Loopstart')

end

function CUTSSCENE.Loopstart()
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue(`wking`,`(thats a lot of info, i might need a lot more than that)`) 
	DoDialogue(`wking`,`(i'll ask some more question then)`) 
	--DoDialogue(`wking`,`can i ask you about`) 
	cc.Initiate('questionLoop')
end

-- hint hint wink wink

-- question goes on and on and on
function CUTSSCENE.questionLoop()
	if CONFIG.Patient<=CONFIG._PatientSnap then
		-- bro dead
		return
	end
	SetCam(Cams:WaitForChild(`startgame`).CFrame)


	DoDialogue('wking','...')
	local memo=getmemo()
	local ISRepeated=table.find(ALREADYquestioned,memo)~=nil

	if ISRepeated  then
		--cc.Initiate('areyoudeaf')
	else 
		table.insert(ALREADYquestioned,memo)
	end



	if memo=="herfamily"  then
		DoDialogue(`wking`,`what you meant by "her family"`) 
		DoDialogue('bqueen',`...`) 
		if not ISRepeated then
			DoDialogue('bqueen',`its.. none of your bussiness`) 
			addmemo('notokfamily')
			DoDialogue(`wking`,`(well that didnt answer anything)`) 
			CUTSSCENE.gotit()
		end
	elseif memo=='notokfamily' then
		DoDialogue('wking',`(i shouldn't asked her this)`) 
	elseif memo=="queenfamily" then
		DoDialogue(`wking`,`do you meant by "her family"`) 
		DoDialogue(`wking`,`is it yours?`) 
		if not ISRepeated then
			DoDialogue('bqueen',`...`) 
		else
			DoDialogue('bqueen',`dont you dare`) 
			if ADDanger(1) then return end 
			DoDialogue('bqueen',`you know nothing`) 
		end
	elseif memo=='kinglie'  or memo=='killpattern' then
		--DoDialogue(`wking`,`about {oohyellow('him')}`) 
		cc.Initiate('kinglie')
		return
	elseif memo=='intenttokill' then
		--if not ISRepeated then
		--	cc.Initiate('whykillme')
		--else
			DoDialogue(`bqueen`,`first, king's order. second, you killed people`) 
			if ADDanger(1) then return end 
			DoDialogue(`bqueen`,`stop asking that`)  
		--end

	elseif memo=="whiteking" then

		DoDialogue(`wking`,`Do you know who i am?`) 
		DoDialogue(`bqueen`,`Are you threatening me?`) 
		if not ISRepeated then
			DoDialogue(`wking`,`N- no, i just wanted to make sure`) 
			DoDialogue(`bqueen`,`..You are my enemy`) 
		else
			DoDialogue(`wking`,`N- no, i just want t-`)  
			DoDialogue(`bqueen`,`i can press this trigger and kill you right now`) 
			if ADDanger(1) then return end 
			DoDialogue(`wking`,`.... sorry`)  
		end
	elseif memo=="blackqueen" then

		DoDialogue(`wking`,`who are you?`) 
		if not ISRepeated then

			DoDialogue(`bqueen`,`why do you care about my name?`) 
			DoDialogue(`bqueen`,`my name is not that important`) 
		else
			DoDialogue(`bqueen`,`... are you serious?`) 
			ADDanger(1)

		end
	elseif memo=="blackking" then

		DoDialogue(`wking`,`who's the black king`) 
		if not ISRepeated then

			DoDialogue(`bqueen`,`did you forgot who he is?`) 
			DoDialogue(`bqueen`,`he is your enemy, the one who control the "black" group`) 
			DoDialogue(`bqueen`,`the group that's your opposing currently`) 
		else
			DoDialogue(`bqueen`,`... are you serious?`) 
			ADDanger(1)
		end

	elseif memo=="wkingkill" or memo=='falseaccusation' then -- another branch!11

		DoDialogue(`wking`,`i didn't kill anyone for fun`) 
		DoDialogue(`wking`,`only who attack first`) 
		DoDialogue(`bqueen`,`lie`) 
		DoDialogue(`bqueen`,`you're talking nonsense`) 
		DoDialogue(`wking`,`i can proof it`) 
		memo=getmemo()
		if memo=='kinglie' then
			cc.Initiate('kinglie')
		else
			DoDialogue(`wking`,`...nevermind`) 
			DoDialogue(`bqueen`,`that's what i thought`) 
			ADDanger(1)
		end

	elseif memo=="sober" then
 
		DoDialogue(`wking`,`i am currently cannot think straight`) 
		if not ISRepeated then

			DoDialogue(`bqueen`,`...what?`) 
		else
			DoDialogue(`bqueen`,`you are not funny`) 
			ADDanger(1)

		end
	elseif memo=="aaaaaaaa" then

		DoDialogue(`bqueen`,`bcbcbcbcb`) 
		DoDialogue(`wking`,`adadad`) 
		if not ISRepeated then

		else

		end
		ADDanger(1)

	elseif memo=="" then

	else


		DoDialogue('wking',`do you know anything about "{MEmRY.memory[memo].name }?"`) 
		DoDialogue('bqueen',`..and what do you mean by that`) 
		DoDialogue('wking',`i honestly dont know`) 
		DoDialogue('wking',`it just came up on my mi-`) 
		ADDanger(1)
		DoDialogue('bqueen',`stop joking around`) 

	end 
	cc.Initiate('questionLoop')
end

function CUTSSCENE.gotit()
	DoDialogue('wking',`(i feel that's some important info from her )`)
end
--FINAL QUESTION!  
function CUTSSCENE.kinglie() 
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue(`wking`,`it seems that your king is lying about everything you knew.`) 
	DoDialogue('bqueen',`and what makes you say that?`) 
	DoDialogue('bqueen',`what is he possibly lying about?`) 

	local memo = getmemo()
	if memo ~= 'queenfamily' then
		DoDialogue('bqueen',`nothing? that's convinient`) 
		ADDanger(1)
		cc.Initiate('questionLoop')
		return true
	end
	DoDialogue(`wking`,`your family.`) 
	DoDialogue('bqueen',`...no`)  
	DoDialogue('bqueen',`...\n you're lying`)  
	DoDialogue('bqueen',`you dont even have any proof of that`)  
	DoDialogue('bqueen',`i've know him for years`)  
	--DoDialogue(`wking`,`(she might  )`) 

	--another gate
	memo = getmemo()
	if memo ~= 'killpattern' then 
		DoDialogue('bqueen',`you're playing with my feeling`) 
		DoDialogue('bqueen',`...stop that`) 
		ADDanger(1)
		cc.Initiate('questionLoop')
		return true
	end
	game.Lighting.Atmosphere.Density=0
	SetCam(Cams.deadfamily.CFrame)
	DoDialogue(`wking`,`do you know what happen to their body?`) 
	DoDialogue('bqueen',`...`)  
	DoDialogue(`wking`,`do one of their hand have no fingers?`) 
	DoDialogue('bqueen',`...yes`)  
	DoDialogue(`wking`,`and did  you  remember`) 
	SetCam(Cams.deadfamilyclose.CFrame)
	DoDialogue(`wking`,`who always does that to a corpse?`) 
	DoDialogue('bqueen',`...`)  
	DoDialogue('bqueen',`him..  `)  
	DoDialogue('bqueen',`but, he's not there when i see it`)  
	SetCam(Cams.lookatkillerking.CFrame)
	DoDialogue(`wking`,`maybe because you got there before he can dispose it?`) 
	DoDialogue('bqueen',`...`)  


	--DoDialogue('bqueen',`he...`)  
	--DoDialogue('bqueen',`told me it was you..`)  

	cc.Initiate('almostend')
end


--will die if wrong
function CUTSSCENE.oohshemad()
	SetCam(Cams.startgame.CFrame)
	DoDialogue('bqueen',`that's it`)
	setface(King,'scared')
	SetCam(Cams.queenpov.CFrame)
	DoDialogue('bqueen',`any last word before i kill you?`)
	local memo=getmemo()
	local THEREISEXCUSES=table.find(noexcuses,memo)~=nil
	if not  THEREISEXCUSES then

		table.insert(noexcuses,memo)
	end

	if memo=='sober' then
		DoDialogue('wking',`i.. cant think straight`)

		if not THEREISEXCUSES then
			cc.Initiate('empathcuzshedie')
		end
	else
		THEREISEXCUSES=true
	end

	if THEREISEXCUSES then
		--DoDialogue('bqueen',`same excuses, you can't get me twice`)
	else
		DoDialogue('wking',`(that almost got me killed)`)
		setface(King,'scaredidle')
		return
	end

	DoDialogue('wking',`i, dont have any... more.`)
	DoDialogue('bqueen',`that saves me time`)

	cc.Initiate('heDIE')
	--wking die!
	return true

end

function CUTSSCENE.heDIE()
	memorybuton.Visible = false
	SetCam(Cams.startgame.CFrame)
	hershotgun.light.Transparency=0	
	hershotgun.light.light2.Transparency=.7
	hershotgun.light.PointLight.Enabled=true	
	hershotgun:WaitForChild('FireSound'):Play()
	task.wait(.5)
	hershotgun:WaitForChild('FireSound'):Stop()
	SetCam(Cams.dudepov.CFrame)
	script["City Night Ambience 3 (SFX)"]:Stop() --bg noise
	DoDialogue(`player`,`wait no`)
	DoDialogue(`player`,`that's not supposed to happen`)
	DoDialogue(`dude`,`can't we just-`)
	DoDialogue(`player`,`okay where do i st-`)
	DoDialogue(`dude`,`HEY!`)
	DoDialogue(`player`,`what?`)
	CUTSSCENE.run()
end

--sober sober
function CUTSSCENE.empathcuzshedie()
	setface(King,'scaredidle')
	DoDialogue('wking',`it's because i've been drinking a lot... recently`)
	DoDialogue('wking',`trying to forget...`)
	DoDialogue('wking',`(something came out from my mind, but its seems hard to speak about it )`)
	DoDialogue('bqueen',`quit stalling`)
	DoDialogue('wking',`her...`)
	setface(King,'sad')
	addmemo('whitequeen')
	DoDialogue('wking',`(...)`)
	DoDialogue('wking',`white's queen\n she's...\n i can't.. why didn't i..`)
	DoDialogue('wking',`...`)
	SetCam(Cams.startgame.CFrame)
	DoDialogue('bqueen',`...`) -- ps: she know that wking's wife is dead, just being cold and all :)


	DoDialogue('bqueen',`being sad about it just make you look weak`)
	DoDialogue('bqueen',`you look pathetic`)

	DoDialogue('bqueen',`...fine`)
	ADDanger(-2)
	DoDialogue('bqueen',`i'll give you another chance`)
	DoDialogue('bqueen',`don't temp me`)
	--go go back to the og queustionlop
end

function CUTSSCENE.almostend() 
	memorybuton.Visible = false
	game.Lighting.Atmosphere.Density=0.5
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	--King:PivotTo(Pathh.look.CFrame)
	ADDanger(-3)
	DoDialogue('bqueen',`get out.`) 
	DoDialogue('bqueen',`Just... get out of my sight`) 

	-- king  walks away
	SetCam(Cams:WaitForChild(`kinggoaway`).CFrame)
	MoveTo(King,Pathh.farther1.Position,true)
	task.wait(1)
	SetCam(Cams:WaitForChild(`kinggoes`).CFrame)
	task.wait(1)
	King:PivotTo(King:GetPivot()*CFrame.Angles(0,math.rad(180),0))--spin
	task.wait(2) -- stare back
	DoDialogue('wking',`...`) 
	King:PivotTo(CFrame.new(King:GetPivot().Position,Pathh.farther2.Position))--spin
	task.wait(1) -- inhale
	MoveTo(King,Pathh.farther2.Position,true)


	SetCam(Cams:WaitForChild(`toqueen`).CFrame)
	DoDialogue('bqueen',`...`) 
	--happy ending!!
	cc.Initiate('ends')
end

-- after the whole stuff 
function CUTSSCENE.ends()
	script.Restaurant:Play() -- no bg noise
	script["City Night Ambience 3 (SFX)"]:Stop() --bg noise
	SetCam(Cams.dudepov.CFrame)

	DoDialogue(`player`,`and then the king is killed by his wife, and the queen finally avenged her family`)
	SetCam(Cams.MyPov.CFrame)
	DoDialogue(`dude`,`...`)
	SetCam(Cams.dudepov.CFrame)
	DoDialogue(`player`,`your king died, therefore i {oohyellow('win')}`)
	DoDialogue(`dude`,`...`)
	SetCam(Cams.MyPov.CFrame)
	DoDialogue(`dude`,`youre making stuff up`)
	SetCam(Cams.dudepov.CFrame)
	DoDialogue(`player`,`no`)
	cc.Initiate('run')
end

function CUTSSCENE.run()
	SetCam(Cams.MyPov.CFrame)
	DoDialogue(`dude`,`deal is a deal`)
	DoDialogue(`dude`,`now give me my 50$ for beating you`)
	SetCam(Cams.dudepov.CFrame)
	DoDialogue(`player`,`okay okay, let me just`)

	-- PLAYER RUN FOR THEIR LIFE!Aa
	--SetCam(Cams['1787925349.5332172'].CFrame)
	SetCam(Cams.RUN.CFrame)
	task.spawn(function()
		MoveTo(Characters:WaitForChild('RUNNINGplayer'),Pathh.run1.Position,true)
		MoveTo(Characters:WaitForChild('RUNNINGplayer'),Pathh.run2.Position,true)
		MoveTo(Characters:WaitForChild('RUNNINGplayer'),Pathh.run3.Position,true)

	end)
	DoDialogue(`dude`,`wh-`) 
	DoDialogue(`dude`,`HEY!`)
	DoDialogue(`dude`,`PAY BACK MY MONEY`)
	MoveTo(Characters:WaitForChild('RUNNINGdude'),Pathh.run1.Position,true)

	SetCam(CFrame.new(0,0,0))
	script.Restaurant:Stop()
	workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
	DoDialogue('player','oh yea, thats where did i  hate that game from') 
	if CONFIG.Patient<=CONFIG._PatientSnap then
		DoDialogue('player',`but i feel like, i didn't have time to re explain the story`) 
		DoDialogue('player',`maybe if i do that again without making the black queen upset?`) 
		DoDialogue('player',`MAYBE he will understand`) 
		DoDialogue('player',`..maybe`) 
		DoDialogue('player',`...`) 
		DoDialogue('player',`well i suppose i'll interact with the board  to do it again`) 
	end
	CONFIG.run=false
	DoDialogue('',' ')  


end

function cc.Initiate(index)
	if not CONFIG.run then
		return
	end
	workspace.CurrentCamera.CameraType=Enum.CameraType.Scriptable
	local Cutscene=cc.Cutscene[index]
	if not Cutscene then
		warn(`NO CUTSCENE WITH THE ID OF {index}`)
		return
	end
	cc.Current=index
	Cutscene()
end


BindEvent.Reset.Event:Connect(RESET)


return cc
