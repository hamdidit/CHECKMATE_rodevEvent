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
	['shemad']={
		img=""
		,name="She has a bad temper"
		,desc=`I should be careful to not make her mad.... \n or  i'll be dead`
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
		,name="She's going to kill me"
		,desc="i need a way to convince her to not kill me, but how?"
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
  
	whitequeen={
		img = ""
		,name='i still see her...'
		,desc='i thought drinking would make it go away'
		,type=""
	},
	 
	falseaccusation = {
		img = "",
		name = "False accusation",
		desc = "she's told that i killed her family.\nbut... she doesn't trust people easily, even me...\nunless... someone who's she think is trustworthy enough",
		type = ""
	},

	killpattern = {
		img = "",
		name = "Black King's signature",
		desc = "thats it, he always cut off his victim's finger. still wondering if its some kind of intimdation or punishment\nand im sure enough he did that to her family",
		type = ""
	},

	kinglie = {
		img = "",
		name = "King's lie",
		desc = "it all makes sense. he killed her family, lies about it and blame it on the most reasonable person to blame\n this is my oppurtinity",
		type = ""
	},
	bbbb={
		img=""
		,name="gagaga"
		,desc="gagagagag"
		,type=""
	},
}
memo.combination={
	queenfamily       = {'notokfamily', 'herfamily'},

	falseaccusation1  = {'wkingkill', 'notokfamily'},
	falseaccusation2  = {'wkingkill', 'herfamily'},
	falseaccusation3  = {'wkingkill', 'queenfamily'},

	killpattern1      = {'blackking', 'falseaccusation'},  
	killpattern2      = {'blackking', 'queenfamily'},
	killpattern3      = {'blackking', 'wkingkill'},
	killpattern4      = {'blackking', 'herfamily'},

	kinglie1          = {'falseaccusation', 'killpattern'}, 
	kinglie2          = {'blackking', 'killpattern'},
	kinglie3          = {'blackking', 'falseaccusation'},
}

memo.list={}
for i,_ in memo.memory do
	table.insert(memo.list,i)
end

return memo
