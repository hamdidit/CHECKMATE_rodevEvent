local memo={}
memo.memory = {
	test={
		img=""
		,name="This is a test!"
		,desc=`hi, im going to Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sollicitudin, lorem placerat mattis lacinia, ipsum metus dictum ante, vitae tempor metus massa id urna. Aliquam libero ligula, aliquet dignissim aliquet ut, facilisis vel dui. Donec in finibus risus, eu pharetra odio. Nunc varius odio eu erat efficitur consectetur. Praesent viverra turpis in ligula fermentum, id ullamcorper ligula feugiat. Nunc tortor ipsum, malesuada a mauris at, vulputate pulvinar lacus.`
		,type=""
	},
	['...']={
		img=""
		,name="empty..."
		,desc=`...`
		,type=""
	},
	['combine']={
		img=""
		,name="Connecting two memories"
		,desc=` it's useful if i see a logical explanation to connect them\n i could try every combination, but where's the fun in that?`
		,type="note"
	},
	['feelcomplete']={
		img=""
		,name=` i have every combination`
		,desc=`i feel like i have every combination right now, i'll confront her right now using "King's lie"`
		,type="important"
	},
	['askedevery']={
		img=""
		,name="i asked everything"
		,desc=`i asked her everything important enough, maybe i should try to connect them?`
		,type="important"
	},
	whiteking={
		img=""
		,name="I am white's king"
		,desc="Im the one who lead the white group"
		,type=""
	},
	blackqueen={
		img=""
		,name="She is a black's queen"
		,desc="a black's most trusted person, mostly the one does the king's dirty work"
		,type=""
	},
	intenttokill={
		img=""
		,name="She has an intent to kill me"
		,desc="i need a way to convince her to leave, but how?"
		,type=""
	},
	sober={
		img=""
		,name="i cant remember a single thing"
		,desc=" i should've not drank  that much, now look at you"
		,type=""
	},
	wkingkill={
		img=""
		,name="I love killing?"
		,desc="Is she lying? i dont even like and even hate killing people\n the people that we only kill the one who attack first"
		,type=""
	},
	blackking={
		img=""
		,name="Black king"
		,desc="he's the leader of our enemy group, black.\n i wonder how are we an enemy in the first place? "
		,type=""
	},
	kinglie={
		img=""
		,name="King's lie"
		,desc="the reason white and black can't be alliance, he always lie and break promises even if i gave a chance to"
		,type=""
	},
	herfamily={
		img=""
		,name="Her... family?"
		,desc='she mentioned "Her family" and her tone is really.. sad?'
		,type=""
	},
	notokfamily={
		img=""
		,name="She didnt wanted to answer"
		,desc=`it seems that she's avoiding the question about "her family"`
		,type=""
	},
	queenfamily={
		img=""
		,name="Black queen's family"
		,desc=`she doesn't deserve all this, i need a way to convince her that their death is not my fault`
		,type=""
	},
	falseaccusation = {
		img = ""
		,name = "False accusation"
		,desc = "she was told that i killed her family?\nwho, told her that? "
		,type=""
	}, 
	whitequeen={
		img = ""
		,name='i still see her...'
		,desc='i thought drinking would make it go away'
		,type=""
	},
	killpattern={
		img = ""
		,name=`Black king's kill signature`
		,desc=`Black king always cuts off his vicims upon killing them, is it some sort of intimidation or punishment?`
		,type=""
	},

	bbbb={
		img=""
		,name="gagaga"
		,desc="gagagagag"
		,type=""
	},
}
memo.combination={
	queenfamily			= {'notokfamily', 'herfamily'},
	falseaccusation1		= {'wkingkill', 'notokfamily'},
	falseaccusation2		= {'wkingkill', 'herfamily'},
	falseaccusation3		= {'wkingkill', 'queenfamily'},
	killpattern1		= {'blackking', 'herfamily'},
	killpattern2		= {'blackking', 'queenfamily'},
	kinglie							= {'falseaccusation', 'blackking'},
}
memo.vip={'combine','feelcomplete','askedevery'}
memo.list={}
for i,_ in memo.memory do
	table.insert(memo.list,i)
end

return memo
