extends Node2D

enum State {PlayerMain,PlayerCombat,CompMain,CompCombat,PlayerTurnEnd,CompTurnEnd,PlayerLoss,CompLoss}
var curstate=State.PlayerMain
var deckCheck =1

var cardsInHand=[0,1,2,null,null,null,null]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func millCheck(deckCount):
	if(deckCheck==1&&deckCount==0):
		deckCheck=0
	elif(deckCheck==0&&curstate==State.CompMain):
		curstate=State.CompLoss
	elif(deckCheck==0&&curstate==State.PlayerMain):
		curstate=State.PlayerLoss
		
func lifeCheck():
	if(Global.compHealth<=0):
		curstate=State.CompLoss
	elif(Global.playerHealth<=0):
		curstate=State.PlayerLoss
	#player will be returned 1 and computer 0
func playerDamage(damage,defendingPlayer):
	if (defendingPlayer==1):
		Global.playerHealth-=damage
	else:
		Global.compHealth-=damage
func Combat():
	lifeCheck()
func movePhases():
	if curstate==State.PlayerMain:
		millCheck(12-Global.turnNumber)
		curstate=State.PlayerCombat
	elif curstate==State.PlayerCombat:
		Combat()
		curstate=State.PlayerTurnEnd
	elif curstate==State.CompMain:
		millCheck(12-Global.turnNumber)
		curstate=State.CompCombat
	elif curstate==State.CompCombat:
		Combat()
		curstate=State.CompTurnEnd
	elif curstate == State.PlayerTurnEnd:
		curstate=State.CompMain
	elif curstate==State.CompTurnEnd:
		Global.turnNumber+=1
		Global.cardDrawn=0
		print(Global.turnNumber)
		curstate=State.PlayerMain
	

func playCard(card):
	Global.cardsPlayed+=1
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
func _on_phase_mover_pressed():
	movePhases()


func _on_play_card_pressed():
	if (Global.selectedCard!=null):
		playCard(Global.selectedCard)
		Global.selectedCard=null
	else:
		print("No selected Card")
