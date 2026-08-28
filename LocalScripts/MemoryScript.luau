
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

local current=""
local combinedmemory={}
function istexttoolong(invstance:TextLabel,l_entgh)
	
	local vis=invstance:Clone()
	vis.Parent=invstance 
	vis.Size=UDim2.fromScale(1,1)
	vis.Position=UDim2.new(0,0,0,0)
	
	invstance.TextTransparency=1
	local ttroder=0
	
	local function dotext(idorder)
		ttroder=idorder
		local lentgh=l_entgh[1]
		local tt=invstance.Text
		local nextext=string.sub(tt,idorder,idorder+lentgh)
		if idorder>1 then -- do .. on first
			nextext=`..{nextext}`
		end
		if (idorder+lentgh)<#tt then -- do .. on last
			nextext=`{nextext}..`
		end
		
		vis.Text=nextext
	end
	local function cutext()
		dotext(ttroder)
	end
	
	local function rst()
		dotext(0)
	end
	invstance.MouseEnter:Connect(function()
				
	end)
	
	invstance.MouseLeave:Connect(function()
		rst()
	end)
	invstance:GetPropertyChangedSignal('Text'):Connect(cutext)
	invstance:GetPropertyChangedSignal('AbsoluteSize'):Connect(cutext)
	rst()
end

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

end 

function AddMemory(index)
	local IsMemory:typeof(MemMod.memory.test)=MemMod.memory[index]
	if not IsMemory or memcontainers:FindFirstChild(index) then return end
	local FRAME=TemplateF:Clone()
	FRAME.Name=index
	FRAME.LayoutOrder=-tick() -- newest -> oldest
	FRAME.Parent=memcontainers
	FRAME.txt.Text=IsMemory.name
	--istexttoolong(FRAME.txt,5)
	
	if not MemoFrame.Visible then
		NewStuff+=1
		MemoButton.TextLabel.Visible=true
	else
		MemoButton.TextLabel.Visible=false
		NewStuff=0
	end
	MemoButton.TextLabel.Text=NewStuff
	FRAME:SetAttribute('id',index)

	FRAME.Activated:Connect(function()
		if current==index then
			reset()
			return
		end
		detailsframe.interact.Visible=detailsframe.interact:GetAttribute('vis')==true
		current=index
		detailsframe.title.Text=IsMemory.name
		detailsframe.desc.Text=IsMemory.desc
		detailsframe.img.Image=IsMemory.img or ''
		--detailsframe.interact.qeustion.Text=`Use {IsMemory.name}`

		for _,chilldren in memcontainers:GetChildren() do
			local combineframe:Frame=chilldren:FindFirstChild('combine')
			if chilldren==FRAME then
				combineframe.Visible=false
				continue end

			if combineframe then
				local visible=true
				for _,get in combinedmemory do
					if  table.find(get,index)  and table.find(get,chilldren:GetAttribute('id'))  then
						visible=false
						break
					end
				end
				combineframe.Visible=visible
			end
		end 
	end)

	FRAME.combine.t.Activated:Connect(function()
		if current=="" or current==index then return end
		table.insert(combinedmemory,{index,current})
		for i,comb in MemMod.combination do
			if table.find(comb,current) and table.find(comb,index) then
				if AddMemory(i) then
					script.Correct:Play()
					return
				else
					break
				end
			end
		end


		--FAILED!
		FRAME.combine.Visible=false
		script.Wrong:Play()					
	end)	

	return true
end

game.ReplicatedStorage.Event.MemoryAdd.Event:Connect(AddMemory)
--AddMemory('sober')
detailsframe:WaitForChild('img').Activated:Connect(function() 
	Inspection.Visible=true
	Inspection.ImageLabel.Image=detailsframe.img.Image

end)

detailsframe.interact:WaitForChild('qeustion').Activated:Connect(function() 
	game.ReplicatedStorage.Event.UseMemory:Fire(current)
	MemoFrame.Visible=false
	reset()
end)
MemoButton.Activated:Connect(function()
	NewStuff=0
	MemoFrame.Visible=not MemoFrame.Visible
	MemoButton.TextLabel.Visible=false
end)

Inspection.Activated:Connect(function() Inspection.Visible=false end)
--istexttoolong(detailsframe.txt,5)


TemplateF.Parent=script
TemplateF:WaitForChild('combine').Visible=false
MemoFrame.Visible=false
reset()
