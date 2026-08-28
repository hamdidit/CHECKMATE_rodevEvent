local memo={}
memo.memory = {
	test={
		img=""
		,name="This is a test!"
		,desc=`hi, im going to Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sollicitudin, lorem placerat mattis lacinia, ipsum metus dictum ante, vitae tempor metus massa id urna. Aliquam libero ligula, aliquet dignissim aliquet ut, facilisis vel dui. Donec in finibus risus, eu pharetra odio. Nunc varius odio eu erat efficitur consectetur. Praesent viverra turpis in ligula fermentum, id ullamcorper ligula feugiat. Nunc tortor ipsum, malesuada a mauris at, vulputate pulvinar lacus.`
	},
	whiteking={
		img=""
		,name="I am white's king"
		,desc="Im the one who lead the white group"
	},
	blackqueen={
		img=""
		,name="She is a black's queen"
		,desc="a black's most trusted person, mostly the one does the king's dirty work"
	},
	intenttokill={
		img=""
		,name="She has an intent to kill me"
		,desc="i need a way to convince her to leave, but how?"
	},
	sober={
		img=""
		,name="i cant remember a single thing"
		,desc=" i should've not drank  that much, now look at you"
	},
	wkingkill={
		img=""
		,name="I love killing?"
		,desc="Is she lying? i dont even like and even hate killing people\n the people that we only kill the one who attack first"
	},
	blackking={
		img=""
		,name="Black king"
		,desc="he's the leader of our enemy group, black.\n i wonder how are we an enemy in the first place? "
	},
	kinglie={
		img=""
		,name="King's lie"
		,desc="the reason white and black can't be alliance, he always lie and break promises even if i gave a chance to"
	},
	herfamily={
		img=""
		,name="Her... family?"
		,desc='she mentioned "Her family" and her tone is really.. sad?'
	},
	notokfamily={
		img=""
		,name="She didnt wanted to answer"
		,desc=`it seems that she's avoiding the question about "her family"`
	},
	queenfamily={
		img=""
		,name="Black queen's family"
		,desc=`she doesn't deserve all this, i need a way to convince her that their death is not my fault`
	},
	falseaccusation = {
		img = ""
		,name = "False accusation"
		,desc = "she was told that i killed her family?\nwho, told her that? "
	}, 
	whitequeen={
		img = ""
		,name='i still see her...'
		,desc='i thought drinking would make it go away'
	},

	bbbb={
		img=""
		,name="gagaga"
		,desc="gagagagag"
	},
}
memo.combination={
	queenfamily			= {'notokfamily', 'herfamily'},
	falseaccusation		= {'wkingkill', 'queenfamily'},
	kinglie							= {'falseaccusation', 'blackking'},
}

memo.list={}
for i,_ in memo.memory do
	table.insert(memo.list,i)
end

return memo
