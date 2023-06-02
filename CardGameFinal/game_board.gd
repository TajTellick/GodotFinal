extends Node2D

enum State {PlayerMain,PlayerCombat,CompMain,CompCombat,PlayerTurnEnd,CompTurnEnd,PlayerLoss,CompLoss}
var turnNumber =0
var curstate=State.PlayerMain
var deckCheck =1
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
		millCheck(12-turnNumber)
		curstate=State.PlayerCombat
	elif curstate==State.PlayerCombat:
		Combat()
		curstate=State.PlayerTurnEnd
	elif curstate==State.CompMain:
		millCheck(12-turnNumber)
		curstate=State.CompCombat
	elif curstate==State.CompCombat:
		Combat()
		curstate=State.CompTurnEnd
	elif curstate == State.PlayerTurnEnd:
		curstate=State.CompMain
	elif curstate==State.CompTurnEnd:
		curstate=State.PlayerMain
	


func _on_phase_mover_pressed():
	movePhases()
	print(curstate)
