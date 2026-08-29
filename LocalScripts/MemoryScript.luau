
local Parent=script.Parent
local Inspection=Parent:WaitForChild('inspectelement')
local MemoButton=Parent:WaitForChild('MemoryButton')
local MemoFrame=Parent:WaitForChild('MemoryFrame')
local memcontainers=MemoFrame:WaitForChild('memos'):WaitForChild('Frame')
local detailsframe=MemoFrame:WaitForChild('Details')

local TemplateF=memcontainers:WaitForChild('template')

local MemMod=require(game.ReplicatedStorage.Modules.Memories)
local Custscene=require(game.ReplicatedStorage.Modules.Cutscene)
local NewStuff=0
local IMPORTANT=false

local current=""
local combinedmemory={}

local stockreseter={}
function reset()
	detailsframe:WaitForChild('title').Text=""
	detailsframe:WaitForChild('img').Image=""
	detailsframe:WaitForChild('desc').Text="Select one of the memory on the right to get details from them\n or even combine them into a new memory"
	detailsframe:WaitForChild('interact').Visible=false
	current=""
	for _,chilldren in memcontainers:GetChildren() do
		local combineframe:Frame=chilldren:FindFirstChild('combine')
		if combineframe then
			combineframe.Visible=false
		end
	end

	for _,v in stockreseter do
		v()
	end

end 

local GETMEMOS={}
function TRUEreset()
	reset()
	for _,v in  memcontainers:GetChildren() do
		if v:IsA(TemplateF.ClassName) then
			v:Destroy()
		end
	end
	stockreseter={}
	combinedmemory={}
	NewStuff=0
	GETMEMOS={}
	--AddMemory('...')
	IMPORTANT=false
end


function AddMemory(index)
	local IsMemory:typeof(MemMod.memory.test)=MemMod.memory[index]
	if not IsMemory or memcontainers:FindFirstChild(index) then return end
	GETMEMOS[index]=true
	local FRAME=TemplateF:Clone()
	local uistr=FRAME:WaitForChild('uistr')
	FRAME.Name=index
	FRAME.LayoutOrder=-tick() -- newest -> oldest
	FRAME.Parent=memcontainers
	FRAME.txt.Text=`[NEW] {IsMemory.name}`
	if IsMemory.type=='important' then
		FRAME.txt.Text=`[IMPORTANT!] {IsMemory.name}`
		FRAME.BackgroundColor3=Color3.new(1,1,0)
		IMPORTANT=false
	elseif IsMemory.type=='note' then
		FRAME.txt.Text=`[note] {IsMemory.name}`
		FRAME.LayoutOrder=0
	else
		idk()
	end
	--istexttoolong(FRAME.txt,5)
	local hovery=false
	if not MemoFrame.Visible then
		NewStuff+=1
		MemoButton.TextLabel.Visible=true
	else
		MemoButton.TextLabel.Visible=false
		NewStuff=0
	end

	local function resetthestroke()


		if hovery then

			uistr.Transparency=.3
			uistr.Thickness=5
			uistr.Color=Color3.new(1,1,1)
		elseif current==index then

			uistr.Transparency=0
			uistr.Thickness=5
			uistr.Color=Color3.new(1,1,1) 

		else
			uistr.Transparency=.59
			uistr.Thickness=1
			uistr.Color=Color3.new(0,0,0)
		end
	end

	local function resetcombiner()
		--print(combinedmemory)
		for _,chilldren in memcontainers:GetChildren() do
			local combineframe:Frame=chilldren:FindFirstChild('combine')

			if not combineframe then continue end
			combineframe.Visible=true

			if chilldren==FRAME then combineframe.Visible=false continue end

			if not (MemMod.memory[chilldren.Name].type=="" and IsMemory.type=="") then combineframe.Visible=false continue end
			
			for _,get in combinedmemory do
				if  table.find(get,current)  and table.find(get,chilldren.Name)  then
					combineframe.Visible=false
					break
					
				end
			end
			
			if not combineframe.Visible then continue end
		end 
	end

	resetthestroke()
	stockreseter[#stockreseter+1]=resetthestroke
	MemoButton.TextLabel.Text=NewStuff 
	local conn={}
	conn[#conn+1]=FRAME.Activated:Connect(function()
		script.UI_3_Clicks_02_Hover:Play()
		resetthestroke()
		if current==index then
			reset()
			return
		end
		if IsMemory.type~='note' then
			FRAME.txt.Text=`{IsMemory.name}`
		end
		detailsframe.interact.Visible=detailsframe.interact:GetAttribute('vis')==true and IsMemory.type==""
		current=index
		detailsframe.title.Text=IsMemory.name
		detailsframe.desc.Text=IsMemory.desc
		detailsframe.img.Image=IsMemory.img or ''
		--detailsframe.interact.qeustion.Text=`Use {IsMemory.name}`

		for _,v in stockreseter do
			v()
		end

		resetcombiner()
	end)

	conn[#conn+1]=FRAME.combine.t.Activated:Connect(function()
		if current=="" or current==index then return end
		local gotit=false
		table.insert(combinedmemory,{index,current})
		for i:string,comb in MemMod.combination do
			if table.find(comb,current) and table.find(comb,index) then
				gotit= AddMemory(i:gsub('%d','')) 

				break
			end
		end


		if gotit then
			script.Correct:Play() 
		else
			--FAILED!
			script.Wrong:Play()					
		end

		resetcombiner()

	end)	

	conn[#conn+1]=FRAME.MouseEnter:Connect(function()
		script["ui-simple-button-click"]:Play()
		hovery=true
		resetthestroke()
	end)
	conn[#conn+1]=FRAME.MouseLeave:Connect(function()
		hovery=false
		resetthestroke()
	end)

	FRAME.Destroying:Once(function()
		for _,g in conn do
			g:Disconnect()
		end
	end)

	return true
end

function idk()
	local check1={'notokfamily','herfamily','wkingkill','blackking'}
	local check2={'queenfamily','falseaccusation','killpattern','kinglie'}

	for _,c in {check1,check2} do
		for i,v in c do
			if not GETMEMOS[v] then
				break
			end
			if i==#c then
				if c==check1 then if  not memcontainers:FindFirstChild('askedevery') then
						AddMemory('askedevery')  end
				else if  not memcontainers:FindFirstChild('feelcomplete') then
						AddMemory('feelcomplete') 
					end end
			end
		end
	end

end
game.ReplicatedStorage.Event.MemoryAdd.Event:Connect(AddMemory)
--AddMemory('sober')
detailsframe:WaitForChild('img').Activated:Connect(function() 
	Inspection.Visible=true
	Inspection.ImageLabel.Image=detailsframe.img.Image

end)

detailsframe.interact:WaitForChild('qeustion').Activated:Connect(function() 
	game.ReplicatedStorage.Event.UseMemory:Fire(current,GETMEMOS)
	MemoFrame.Visible=false
	reset()
end)
MemoButton.Activated:Connect(function()
	NewStuff=0
	MemoFrame.Visible=not MemoFrame.Visible
	IMPORTANT=false
	MemoButton.TextLabel.Visible=false
end)

Inspection.Activated:Connect(function() Inspection.Visible=false end)
--istexttoolong(detailsframe.txt,5)


TemplateF.Parent=script
TemplateF:WaitForChild('combine').Visible=false
MemoFrame.Visible=false
TRUEreset()
task.spawn(function()
	local H=MemoButton:WaitForChild('H') 
	while task.wait(.3) and true==not false do
		H.Visible=IMPORTANT and not H.Visible

	end
end)

game.ReplicatedStorage.Event.Reset.Event:Connect(TRUEreset)
