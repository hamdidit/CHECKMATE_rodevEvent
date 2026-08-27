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

local ALREADYquestioned={}
local nodeaaf={"herfamily" ,'kinglie'}

function DoDialogue(id,txt)
	local rig=(id=="wking" and Characters.King)
		or (id=='bqueen' and Characters.Queen) or nil
	_DoDialogue(id,txt,rig)
end
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


function LookAt(part:Part,CF)
	local thecf=part.CFrame
	for i=1,20 do
		part.CFrame=thecf:Lerp(CF,i/20)
		task.wait(.02)
	end
end
function MoveTo(rig:Model,position)
	local Humanoid=rig:FindFirstChildWhichIsA(`Humanoid`)
	Humanoid:MoveTo(position)
	--doanim(rig,'walk','play')
	Humanoid.MoveToFinished:Wait()
	--doanim(rig,'walk','stop')
end

function doanim(rig,id,state)
	BindEvent.PlayAnimation:Fire(rig,id,state)
end

function setface(rig:Model,facename)
	local Head=rig:WaitForChild('Head')
	for _,v in Head:GetChildren() do
		if v:IsA('Decal') and v:HasTag('eye') then
			v.Transparency=v.Name==facename and 0 or 1
		end
	end
end

function SetCam(CF)
	workspace.CurrentCamera.CFrame=CF
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
end

RESET()
cc={}
cc.Cutscene = {
	Start={

		{
			Cam=Cams:WaitForChild(`trauma`).CFrame,
			Start=function()
				-- cam show the queen moving from out of frame into frame
				DoDialogue(`player`,`this board still remind me of that one time`) 
				DoDialogue() 
				task.wait(1)

			end,

		},		 
		{
			Cam=Cams:WaitForChild(`mainmenu`).CFrame,
			Start=function()
				task.wait(2)
			end,

		},		 
		{
			Cam=Cams:WaitForChild(`queenmate`).CFrame,
			Start=function()
				-- cam show the queen moving from out of frame into frame
				DoDialogue(`dude`,`aaaand`) 
				local TW=TwServ:Create(ChessBoardBlack.Queen,TweenInfo.new(1),{CFrame=ChessBoardBlack:WaitForChild(`ToQueen`).CFrame})
				TW:Play() TW.Completed:Wait()
				task.wait(.5)
			end,

		},		 

		{
			Cam=Cams:WaitForChild(`MyPov`).CFrame,
			Start=function()
				-- now cam show `dude` from the player pov
				DoDialogue(`dude`,`checkmate!, i win`)
			end
		},
		{
			Cam=Cams:WaitForChild(`dudepov`).CFrame,
			Start=function()

				DoDialogue(`player`,`no you did not win`)

			end,

		},

		{
			Cam=Cams.queenmate.CFrame,
			Start=function()
				-- now cam show the full board
				DoDialogue(`player`,`i can clearly see that my king is not -`)

			end,

		},


		{
			Cam=Cams.MyPov.CFrame,
			Start=function() 
				-- now cam in player pov
				DoDialogue(`dude`,`dude, you know how to play chess right?`)
				DoDialogue(`player`,`yes?`)
				DoDialogue(`dude`,`whats your point then?`)
			end,

		},

		{
			Cam=Cams.Game.CFrame,
			Start=function()
				workspace:WaitForChild(`ATTAAAAAACK`).Transparency=0
				DoDialogue(`dude`,`if THIS isnt a check?`)
			end,

		},
		{
			Cam=CFrame.new(Cams.MyPov.Position,ChessBoardBlack.Parent.White.King.Position),
			Start=function() 
				-- now cam in player pov but now looking at the white king piece
				workspace:WaitForChild(`ATTAAAAAACK`).Transparency=1
				DoDialogue(`player`,`well you see,`) 
				DoDialogue(``)
				-- slowly zooming and black screen is fading in 
				cc.Initiate(`ALMOSTstart`)

			end,
		},

	},

	ALMOSTstart={

		{
			Cam=Cams:WaitForChild(`START`).CFrame,
			Start=function() 
				--uhhh show the location and time
				doanim(Characters.Queen, 'bq_chill','play')
				doanim(Characters.Queen, 'bq_idle','play')
				doanim(Characters.Queen, 'idle','stop')
				task.wait(5)
				TIMEtextlabel.Transparency=1
			end,
		},
		{
			Cam=Cams:WaitForChild(`INSIDE`).CFrame,
			Start=function() 
				task.wait(2)
				MoveTo(Characters.King,Pathh:WaitForChild('almoststart').Position)
				task.wait(.5)
				MoveTo(Characters.King,Pathh:WaitForChild('start').Position)
				script.open:Play()
				task.wait(.5)
			end,
		},

		{
			Cam=Cams:WaitForChild(`DOOR`).CFrame,
			Start=function() 
				-- show an outdoor that seem like backsde of a building in city
				--task.wait(2)

				-- white king open the door and walking out
				MoveTo(Characters.King,Pathh.ends.Position)				
				script.close:Play()
				task.wait(1)
				MoveTo(Characters.King,Pathh.look.Position)
				task.wait(.5)
				-- white king stops in place, shocked about something
				setface(Characters.King,'scared')
				task.wait(2)
				DoDialogue(`wking`,`uhhh, can i help you?`) 
			end,

		},
		{
			Cam=Cams:WaitForChild(`lookqueen`).CFrame,
			Start=function() 

				-- camera show the frame with white king and a black figure
				DoDialogue(`bqueen`,`you already knew me,"King"`) 
				DoDialogue(`wking`,`how did you-`) 
			end,

		},
		{
			Cam=Cams:WaitForChild(`toqueen`).CFrame,
			Start=function() 
				setface(Characters.King,'scaredidle')

				DoDialogue(`wking`,`oh, {oohyellow('you')}`)
				addmemo('blackqueen') 

				doanim(Characters.Queen,'bq_NOchill','play')
				task.wait(.1)
				doanim(Characters.Queen,'bq_chill','stop')

				DoDialogue(`bqueen`,`a "{oohyellow('white king')}" reign ends here, you have nowhere to go `)
				doanim(Characters.Queen,'bq_NOchill','stop')
				addmemo('whiteking')

				Characters.Queen.Humanoid:MoveTo(Pathh.shecloser.Position) 
			end},
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function()  
				DoDialogue(`bqueen`,`and you have no reinforcement coming `) 
				DoDialogue(`bqueen`,`surrender or you will be {oohyellow('a dead cheese')} `) 
				addmemo('intenttokill')

				DoDialogue(`wking`,`(why {oohyellow("now")} out of all thing)`)
				addmemo('sober')

				memorybuton.Visible=true
				DoDialogue(`wking`,`(i should use my memory and question thing she talked about, and try to connect those thing together )`) 
				DoDialogue(`wking`,`(its the only way my out of this situation )`)
				cc.Initiate('questionSTART')--start it!
			end},

	},
	questionSTART={
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function()  
				DoDialogue(`wking`,`(maybe ill ask her why she's trying to killing me)`)
				local memo=getmemo()
				if memo~='intenttokill' then
					cc.Initiate('notmakesense')
					cc.Initiate('questionSTART')--repeat...
					return true
				end
				DoDialogue(`wking`,`i, need to tell something`)  
				DoDialogue(`bqueen`,`make it quick`) 
				cc.Initiate('whykillme')

			end},

	},

	whykillme={
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function() 
				DoDialogue(`wking`,`why, are you doing this?`)  
				DoDialogue('bqueen',`isn't it obvious?`)
				DoDialogue('bqueen',`<b>I</b> was tasked by the {oohyellow("king")}, and you killed a lot of people`)
				addmemo('blackking')
				DoDialogue('bqueen',`{oohyellow("you like to kill")} people, a lot of them\n especially innocent family who doesn't deserve to die`)
				addmemo('wkingkill')
				DoDialogue('bqueen',`you like to see their son, to be helpless, and make her fend herself off in the city`)task.wait(1)
				DoDialogue('bqueen',`you {oohyellow("killed her family")}, you-`,true)
				addmemo('herfamily')
				DoDialogue('bqueen',`...`) 
				DoDialogue('bqueen',`you dont deserve to live`) 
				cc.Initiate('Loopstart')

			end,
		}
	},

	Loopstart={
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function()
				DoDialogue(`wking`,`(thats a lot of info, i might need a lot more than that)`) 
				DoDialogue(`wking`,`(i'll ask some that's not obvious to not make her frustated)`) 
				DoDialogue(`wking`,`can i ask you about`) 
				cc.Initiate('questionLoop')
			end
		},
	},
	questionLoop={
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function()
				local memo=getmemo()
				local ISRepeated=table.find(ALREADYquestioned,memo)~=nil

				if ISRepeated and   not table.find(nodeaaf,memo)then
					cc.Initiate('areyoudeaf')
				end

				if memo=="herfamily"  then
					DoDialogue(`wking`,`what you meant by "her family"`) 

					DoDialogue('bqueen',`...`) 
					if not ISRepeated then
						DoDialogue('bqueen',`its.. none of your bussiness`) 
					end
				elseif memo=='kinglie' then
					--DoDialogue(`wking`,`about {oohyellow('him')}`) 
					cc.Initiate('kinglie')
					return
				else
					cc.Initiate('notmakesense')
				end
				cc.Initiate('questionLoop')
			end
		},
	},


	kinglie={ --FINAL QUESTION!
		{
			Cam=Cams:WaitForChild(`startgame`).CFrame,
			Start=function()  
				DoDialogue(`wking`,`It seems that your king is lying about everything you knew.`) 
				DoDialogue('bqueen',`And what makes you say that?`) 

				local memo = getmemo()
				if memo ~= 'queenfamily' then
					cc.Initiate('notmakesense')
					cc.Initiate('questionLoop')
					return true
				end

				DoDialogue('bqueen',`...He told me it was White.`) 
				DoDialogue('bqueen',`He looked me in the eyes and told me it was you.`)  

				DoDialogue('bqueen',`Get out.`) 
				DoDialogue('bqueen',`Just... get out of my sight.`) 

				-- she turns and walks away
				cc.Initiate('almostend')
			end},

	},

	notmakesense={ -- for picking a not corelated memory!
		{
			Cam=Cams:WaitForChild(`toqueen`).CFrame,
			Start=function() 
				DoDialogue('bqueen','.. and what do you mean by that?') 

				DoDialogue('wking',' i, honestly dont know')  
				DoDialogue('wking',' it just came up on my mind') 
				--mad >:)
				DoDialogue('bqueen',`you're wasting my time`)

			end,
		}
	},
	areyoudeaf={ -- if the question is already asked, punsihes!
		{
			Cam=Cams:WaitForChild(`toqueen`).CFrame,
			Start=function() 
				DoDialogue('bqueen','did you not hear just what i said?')
				DoDialogue('wking',' i just forgot') 
				DoDialogue('bqueen',`you're pissing me off`)
				--mad >:)
				DoDialogue('bqueen',`i'll repeat it again for you`)
				-- go go another question
			end,
		}
	},

	almostend={
		{
			Cam=Cams:WaitForChild(`toqueen`).CFrame,
			Start=function() 
				DoDialogue('bqueen',`i hate you`)
				--she move away from the camera

				DoDialogue('wking',`...`)
				DoDialogue('wking',`that was close`)
				DoDialogue('wking',`hope she deserve a better life than this`)
				--happy ending!!
				cc.Initiate('ends')
			end,
		}
	},
	ends={
		-- after the whole stuff

		{
			Cam=Cams.dudepov.CFrame,
			Start=function() 

				DoDialogue(`player`,`and then the king is killed by his wife, the queen`)
				DoDialogue(`dude`,`...`)
				DoDialogue(`player`,`therefore i win`)
				DoDialogue(`dude`,`...`)
				DoDialogue(`dude`,`youre making stuff up`)
				DoDialogue(`player`,`no`).
					DoDialogue(`dude`,`deal is a deal`)
				DoDialogue(`dude`,`now give me my 50$ for beating you`)
				DoDialogue(`player`,`okay okay, let me just`)

				-- PLAYER RUN FOR THEIR LIFE!
				DoDialogue(`dude`,`wh-`) 
				DoDialogue(`dude`,`HEY!`)
				DoDialogue(`dude`,`PAY BACK MY MONEY`)

			end,

		},

		{
			Cam=CFrame.new(0,0,0),
			Start=function() 
				workspace.CurrentCamera.CameraType=Enum.CameraType.Custom
				DoDialogue('player','oh yea, thats where did i  hate that game from') 
				DoDialogue('',' ')  
			end},

	},
}

function cc.Initiate(index)
	workspace.CurrentCamera.CameraType=Enum.CameraType.Scriptable
	local Cutscene=cc.Cutscene[index]
	if not Cutscene then
		warn(`NO CUTSCENE WITH THE ID OF {index}`)
		return
	end

	for _,v in Cutscene do
		workspace.CurrentCamera.CFrame=v.Cam
		if v.Start() then
			break
		end
	end
end


BindEvent.Reset.Event:Connect(RESET)


return cc
