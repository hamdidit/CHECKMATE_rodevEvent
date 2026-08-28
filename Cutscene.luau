local Cams=workspace.Cams
local ChessBoardBlack=workspace.ChessBoard.Black
local Characters=workspace.Character
local Pathh=workspace.Path
local TIMEtextlabel=workspace:WaitForChild('THEDATe'):WaitForChild('SurfaceGui'):WaitForChild('TextLabel')
local TwServ=game:GetService(`TweenService`)
local GUI=game.Players.LocalPlayer.PlayerGui
local memorybuton=GUI:WaitForChild('START'):WaitForChild('MemoryButton')
local BindEvent=game.ReplicatedStorage:WaitForChild('Event')

local skipping=false
local _DoDialogue=require(game.ReplicatedStorage.Modules.Dialogues)
local  CONFIG=require(game.ReplicatedStorage.Modules.Stats)

local ALREADYquestioned={}
--local nodeaaf={"herfamily" ,'kinglie'}

function DoDialogue(id,txt)
	id=id or 'plr'
	local rig=(id=="wking" and Characters.King)
		or (id=='bqueen' and Characters.Queen) or nil
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
	local MEMO=BindEvent.UseMemory.Event:Wait()

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
		cc.Initiate('oohshemad')
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
	--doanim(rig,'walk','play')
	if WAT then
		Humanoid.MoveToFinished:Wait()
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
	Characters:WaitForChild('King'):PivotTo(workspace.Path:WaitForChild('verystart').CFrame)
	Characters:WaitForChild('Queen'):PivotTo(workspace.Path:WaitForChild('chilling').CFrame)
	ChessBoardBlack:WaitForChild('Queen').CFrame=workspace.ChessBoard.Black:WaitForChild('FromQueen').CFrame
	workspace:WaitForChild('ATTAAAAAACK').Transparency=1
	memorybuton.Visible=false

	Characters.King:WaitForChild('Head'):WaitForChild('scared').Transparency=1
	Characters.King.Head:WaitForChild('scaredidle').Transparency=1
	Characters.King.Head:WaitForChild('sad').Transparency=0

	CONFIG.Patient=CONFIG._Patient
end

RESET()
cc={}
local CUTSSCENE={}
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
	doanim(Characters.Queen, 'bq_chill','play')
	doanim(Characters.Queen, 'bq_idle','play')
	doanim(Characters.Queen, 'idle','stop')
	task.wait(5)
	TIMEtextlabel.Transparency=1

	SetCam(Cams:WaitForChild(`INSIDE`).CFrame)
	task.wait(2)
	MoveTo(Characters.King,Pathh:WaitForChild('almoststart').Position,true)
	task.wait(.5)
	MoveTo(Characters.King,Pathh:WaitForChild('start').Position,true)
	script.open:Play()
	task.wait(.5)
	SetCam(Cams:WaitForChild(`DOOR`).CFrame)
	-- show an outdoor that seem like backsde of a building in city
	--task.wait(2)

	-- white king open the door and walking out
	MoveTo(Characters.King,Pathh.ends.Position,true)				
	script.close:Play()
	task.wait(1)
	MoveTo(Characters.King,Pathh.look.Position,true)
	task.wait(.5)
	-- white king stops in place, shocked about something
	setface(Characters.King,'scaredidle')
	task.wait(2)
	DoDialogue(`wking`,`...who\n are you?`) 
	SetCam(Cams:WaitForChild(`lookqueen`).CFrame)

	-- camera show the frame with white king and a black figure
	DoDialogue(`bqueen`,`you already knew me, "King"`) 
	DoDialogue(`wking`,`how did you-`) 
	SetCam(Cams:WaitForChild(`toqueen`).CFrame)

	DoDialogue(`wking`,`....{oohyellow('you')}`)
	addmemo('blackqueen') 

	doanim(Characters.Queen,'bq_NOchill','play')
	task.wait(.1)
	doanim(Characters.Queen,'bq_chill','stop')

	DoDialogue(`bqueen`, `the reign of the {oohyellow("White King")} ends here`)
	DoDialogue(`bqueen`, `you have nowhere left to run`)
	doanim(Characters.Queen, 'bq_NOchill', 'stop')
	addmemo('whiteking')

	-- she's  closer
	MoveTo(Characters.Queen,Pathh.shecloser.Position)
	SetCam(Cams:WaitForChild(`startgame`).CFrame)

	DoDialogue(`bqueen`, `no reinforcements are coming`)
	DoDialogue(`bqueen`, `surrender... or become {oohyellow("a dead piece")}`)
	setface(Characters.King,'scared')
	addmemo('intenttokill')

	DoDialogue(`wking`, `(why {oohyellow("now")} of all times...?)`)
	addmemo('sober')

	setface(Characters.King,'scaredidle')
	memorybuton.Visible = true
	DoDialogue(`wking`, `(i need to use my memories. \nQuestion everything she said... and connect them logicly)`)
	DoDialogue(`wking`, `(it's the only way out of this)`)

	cc.Initiate('questionSTART')--start it!
end

function CUTSSCENE.questionSTART()  
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue(`wking`,`(maybe ill start by asking her why she's trying to killing me)`)
	DoDialogue(`wking`,`can i..`)
	DoDialogue(`wking`,`ask you something before you do anything?`)
	DoDialogue(`bqueen`,`make it quick`)

	cc.Initiate('questionLoop')
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
	--cc.Initiate('questionLoop')
end

-- question goes on and on and on
function CUTSSCENE.questionLoop()
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	local memo=getmemo()
	local ISRepeated=table.find(ALREADYquestioned,memo)~=nil

	if ISRepeated  then
		--cc.Initiate('areyoudeaf')
	else 
		table.insert(ALREADYquestioned,memo)
	end

	if memo=="wkingkill" then

	end


	if memo=="herfamily"  then
		DoDialogue(`wking`,`what you meant by "her family"`) 
		DoDialogue('bqueen',`...`) 
		if not ISRepeated then
			DoDialogue('bqueen',`its.. none of your bussiness`) 
			addmemo('notokfamily')
			DoDialogue(`wking`,`(well that didnt answer anything)`) 
		end
	elseif memo=='notokfamily' then
		DoDialogue('wking',`(i shouldn't asked her this)`) 
	elseif memo=="queenfamily" then
		DoDialogue(`wking`,`do you meant by "her family"`) 
		DoDialogue(`wking`,`is it yours?`) 
		DoDialogue('bqueen',`dont you dare`) 
		DoDialogue('bqueen',`you know nothing`) 
		ADDanger(1)

	elseif memo=='kinglie' then
		--DoDialogue(`wking`,`about {oohyellow('him')}`) 
		cc.Initiate('kinglie')
		return
	elseif memo=='intenttokill' then
		if not ISRepeated then
			cc.Initiate('whykillme')
		else
			DoDialogue(`bqueen`,`first, king's order. second, you killed people`) 
			DoDialogue(`bqueen`,`stop asking that`) 
			ADDanger(1)
		end

	else 
		CUTSSCENE.notmakesense()
	end
	cc.Initiate('questionLoop')
end
--FINAL QUESTION!  
function CUTSSCENE.kinglie()
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue(`wking`,`it seems that your king is lying about everything you knew.`) 
	DoDialogue('bqueen',`and what makes you say that?`) 

	local memo = getmemo()
	if memo ~= 'queenfamily' then
		cc.Initiate('notmakesense')
		DoDialogue('bqueen',`nothing? that's convinient`) 
		cc.Initiate('questionLoop')
		return true
	end


	--another gate

	DoDialogue('bqueen',`he...`)  
	DoDialogue('bqueen',`told me it was you..`)  

	cc.Initiate('almostend')
end

-- for picking a not corelated memory!
function CUTSSCENE.notmakesense() 
	SetCam(Cams:WaitForChild(`toqueen`).CFrame)
	DoDialogue('wking',`(that doesn't make sense to ask)`)
	ADDanger(1)

end 

--will die if wrong
function CUTSSCENE.oohshemad()
	setface(Characters.King,'scared')
	DoDialogue('bqueen',`that's it`)
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
		DoDialogue('bqueen',`same excuses, you can't get me twice`)
	else
		DoDialogue('wking',`(that almost got me killed)`)
		return
	end

	DoDialogue('wking',`i, dont have any... more.`)
	DoDialogue('bqueen',`that saves me time`)

	--wking die!

end

--sober sober
function CUTSSCENE.empathcuzshedie()
	setface(Characters.King,'scaredidle')
	DoDialogue('wking',`it's because i've been drinking a lot... recently`)
	DoDialogue('wking',`trying to forget...`)
	DoDialogue('wking',`(something came out from my mind, but its seems hard to speak about it )`)
	DoDialogue('bqueen',`quit stalling`)
	DoDialogue('wking',`her...`)
	setface(Characters.King,'sad')
	addmemo('whitequeen')
	DoDialogue('wking',`(...)`)
	DoDialogue('wking',`white's queen\n she's...\n i can't.. why didn't i..`)
	DoDialogue('wking',`...`)
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
	SetCam(Cams:WaitForChild(`startgame`).CFrame)
	DoDialogue('bqueen',`get out.`) 
	DoDialogue('bqueen',`Just... get out of my sight`) 

	-- king  walks away
	SetCam(Cams:WaitForChild(`queenpov`).CFrame)
	MoveTo(Characters.King,Pathh.farther1.Position,true)
	Characters.King:PivotTo(Characters.King:GetPivot()*CFrame.Angles(0,math.rad(180),0))--spin
	task.wait(5) -- stare back
	DoDialogue('wking',`...`) 
	Characters.King:PivotTo(Characters.King:GetPivot()*CFrame.Angles(0,math.rad(180),0))--spin
	task.wait(1) -- inhale
	MoveTo(Characters.King,Pathh.farther2.Position)


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

	DoDialogue(`player`,`and then the king is killed by his wife, the queen`)
	SetCam(Cams.MyPov.CFrame)
	DoDialogue(`dude`,`...`)
	SetCam(Cams.dudepov.CFrame)
	DoDialogue(`player`,`therefore i {oohyellow('win')}`)
	DoDialogue(`dude`,`...`)
	SetCam(Cams.MyPov.CFrame)
	DoDialogue(`dude`,`youre making stuff up`)
	SetCam(Cams.dudepov.CFrame)
	DoDialogue(`player`,`no`)
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

	end)
	DoDialogue(`dude`,`wh-`) 
	DoDialogue(`dude`,`HEY!`)
	DoDialogue(`dude`,`PAY BACK MY MONEY`)
	MoveTo(Characters:WaitForChild('RUNNINGdude'),Pathh.run1.Position,true)

	SetCam(CFrame.new(0,0,0))
	workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
	DoDialogue('player','oh yea, thats where did i  hate that game from') 
	DoDialogue('',' ')  
end


-- has literally 1 check to avoid nil :sog;
function cc.Initiate(index)
	workspace.CurrentCamera.CameraType=Enum.CameraType.Scriptable
	local Cutscene=cc.Cutscene[index]
	if not Cutscene then
		warn(`NO CUTSCENE WITH THE ID OF {index}`)
		return
	end
	Cutscene()
end


BindEvent.Reset.Event:Connect(RESET)


return cc
