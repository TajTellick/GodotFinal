extends Node2D

enum State {PlayerMain,PlayerCombat,CompMain,CompCombat,PlayerTurnEnd,CompTurnEnd,PlayerLoss,CompLoss}
var curstate=State.PlayerMain
var my_random_number =0
var deckCheck =1
var rng = RandomNumberGenerator.new()
var cardsInHand=[0,1,2,-1,-1,-1,-1]
var pinkCard = load("res://hand_card.tscn")
var ghostCard = load("res://ghost_card.tscn")
var oozeCard = load("res://ooze_card.tscn")
var fireballCard = load("res://fireball_card.tscn")
var lightningCard = load("res://lightning_bolt_card.tscn")
var pink_monster = load("res://pink_monster.tscn")
var ghost = load("res://ghost.tscn")
var ooze = load("res://ooze.tscn")
var fireball = load("res://fireball.tscn")
var lightning_bolt = load("res://lightning_bolt.tscn")
var evil_pink_monster = load("res://pink_monster.tscn")
var evil_ghost = load("res://ghost.tscn")
var evil_ooze = load("res://ooze.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	draw()
	draw()
	draw()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	my_random_number = rng.randf_range(1.0, 100.0)
	
func millCheck(deckCount):
	if(deckCheck==1&&deckCount==0):
		deckCheck=0
	elif(deckCheck==0&&curstate==State.CompMain):
		curstate=State.CompLoss
		get_node("Winner").text = "You Win"
	elif(deckCheck==0&&curstate==State.PlayerMain):
		curstate=State.PlayerLoss
		get_node("Winner").text = "You Win"
func lifeCheck():
	if(Global.compHealth<=0):
		curstate=State.CompLoss
		get_node("Winner").text = "You Win"
	elif(Global.playerHealth<=0):
		curstate=State.PlayerLoss
		get_node("Winner").text = "You Lose"
	#player will be returned 1 and computer 0
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
		if(Global.turnNumber<2):
			print(Global.turnNumber)
			evilPlayCard(0)
			print("hi")
			evilPlayCard(0)
		elif(Global.turnNumber<5):
			evilPlayCard(1)
			evilPlayCard(1)
		else:
			evilPlayCard(2)
			evilPlayCard(2)
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
	
func evilPlayCard(card):
	if(card==0):
		var epink=evil_pink_monster.instantiate()
		print("test")
		epink.global_position = Vector2(125+100*Global.compCardPlay,100)
		add_child(epink)
	if(card==1):
		var eghost=evil_ghost.instantiate()
		eghost.global_position = Vector2(125+100*Global.compCardPlay,100)
		add_child(eghost)
	if(card==2):
		var eooze=evil_ooze.instantiate()
		eooze.global_position = Vector2(125+100*Global.compCardPlay,100)
		add_child(eooze)
	Global.compCardPlay+=1
func playCard(card):
	Global.cardsPlayed+=1
	Global.cardsInPlay+=1
	if(card==0):
		var pink=pink_monster.instantiate()
		pink.global_position = Vector2(125+100*Global.cardsInPlay,400)
		add_child(pink)
	elif(card==1):
		var ooze2=ooze.instantiate()
		ooze2.global_position = Vector2(125+100*Global.cardsInPlay,400)
		add_child(ooze2)
	elif(card==2):
		var ghost2=ghost.instantiate()
		ghost2.global_position = Vector2(125+100*Global.cardsInPlay,400)
		add_child(ghost2)
	elif(card==3):
		Global.target=1
		var lightning=lightning_bolt.instantiate()
		lightning.global_position = Vector2(125+100*Global.cardsInPlay,400)
		add_child(lightning)
	elif(card==4):
		Global.target=1
		var fireball2=fireball.instantiate()
		fireball2.global_position = Vector2(125+100*Global.cardsInPlay,400)
		add_child(fireball2)
	for i in cardsInHand:
		if(cardsInHand[i]==card):
			cardsInHand[i]=-1
			break
func draw():
	if Global.turnNumber<3:
		if (my_random_number<=70):
			addToHand(0)
			var drawnCard0=pinkCard.instantiate()
			drawnCard0.global_position = Vector2(225,500)
			add_child(drawnCard0)
		elif (my_random_number>70):
			addToHand(1)
			var drawnCard1=oozeCard.instantiate()
			drawnCard1.global_position = Vector2(325,500)
			add_child(drawnCard1)
	elif Global.turnNumber<6:
		if (my_random_number<=10):
			addToHand(0)
			var drawnCard0=pinkCard.instantiate()
			drawnCard0.global_position = Vector2(225,500)
			add_child(drawnCard0)
		elif (my_random_number<=50):
			addToHand(1)
			var drawnCard1=oozeCard.instantiate()
			drawnCard1.global_position = Vector2(325,500)
			add_child(drawnCard1)
		elif (my_random_number>50):
			addToHand(3)
			var drawnCard3=lightningCard.instantiate()
			drawnCard3.global_position = Vector2(425,500)
			add_child(drawnCard3)
	elif Global.turnNumber<9:
		if (my_random_number<=70):
			addToHand(3)
			var drawnCard3=lightningCard.instantiate()
			drawnCard3.global_position = Vector2(425,500)
			add_child(drawnCard3)
		elif (my_random_number>70):
			addToHand(2)
			var drawnCard2=ghostCard.instantiate()
			drawnCard2.global_position = Vector2(525,500)
			add_child(drawnCard2)
	else:
		if (my_random_number<=70):
			addToHand(2)
			var drawnCard2=ghostCard.instantiate()
			drawnCard2.global_position = Vector2(525,500)
			add_child(drawnCard2)
		elif (my_random_number>70):
			addToHand(4)
			var drawnCard4=fireballCard.instantiate()
			drawnCard4.global_position = Vector2(625,500)
			add_child(drawnCard4)
func addToHand(newCard):
	for i in cardsInHand:
		if(cardsInHand[i]==-1):
			cardsInHand[i]=newCard
func _on_phase_mover_pressed():
	movePhases()


func _on_play_card_pressed():
	if (Global.selectedCard!=-1):
		playCard(Global.selectedCard)
		Global.selectedCard=-1
	else:
		print("No selected Card")


func _on_deck_draw():
	draw()
