extends Node2D

enum State {PlayerMain,PlayerCombat,CompMain,CompCombat,PlayerTurnEnd,CompTurnEnd,PlayerLoss,CompLoss}
var curstate=State.PlayerMain
var my_random_number =0
var deckCheck =1
var rng = RandomNumberGenerator.new()
var cardsInHand=[0,1,2,null,null,null,null]
var pinkCard = load("res://hand_card.tscn")
var ghostCard = load("res://ghost_card.tscn")
var oozeCard = load("res://ooze_card.tscn")
var fireballCard = load("res://fireball_card.tscn")
var lightningCard = load("res://lightning_bolt_card.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	my_random_number = rng.randf_range(1.0, 100.0)
	
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
		if(Global.cardDrawn==1):
			millCheck(12-Global.turnNumber)
			curstate=State.PlayerCombat
		else:
			print("please draw a card first")
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
			break
func draw():
	
	if Global.turnNumber<3:
		if (my_random_number<=70):
			addToHand(0)
			var drawnCard=pinkCard.instance()
			add_child(drawnCard)
		elif (my_random_number>70):
			addToHand(1)
			var drawnCard=oozeCard.instance()
			add_child(drawnCard)
	elif Global.turnNumber<6:
		if (my_random_number<=10):
			addToHand(0)
			var drawnCard=pinkCard.instance()
			add_child(drawnCard)
		elif (my_random_number<=50):
			addToHand(1)
			var drawnCard=oozeCard.instance()
			add_child(drawnCard)
		elif (my_random_number>50):
			addToHand(4)
			var drawnCard=lightningCard.instance()
			add_child(drawnCard)
	elif Global.turnNumber<9:
		if (my_random_number<=70):
			addToHand(3)
			var drawnCard=lightningCard.instance()
			add_child(drawnCard)
		elif (my_random_number>70):
			addToHand(2)
			var drawnCard=ghostCard.instance()
			add_child(drawnCard)
	else:
		if (my_random_number<=70):
			addToHand(2)
			var drawnCard=ghostCard.instance()
			add_child(drawnCard)
		elif (my_random_number>70):
			addToHand(4)
			var drawnCard=fireballCard.instance()
			add_child(drawnCard)
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
