extends Node2D

var cardsInHand=[0,1,2,null,null,null,null]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func playCard(card):
	for i in cardsInHand:
		if(cardsInHand[i]==card):
			cardsInHand[i]=null
#func draw():
	#if Global.turnNumber<3:
	#elif Global.turnNumber<6:
	#elif Global.turnNumber<9:
	#else:
func addToHand(newCard):
	for i in cardsInHand:
		if(cardsInHand[i]==null):
			cardsInHand[i]=newCard
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
