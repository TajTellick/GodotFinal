extends Node2D

enum State {PlayerMain,PlayerCombat,CompMain,CompCombat,PlayerTurnEnd,CompTurnEnd}
var turnNumber =0
var playerHealth=10
var compHealth=10
var curstate=State.PlayerMain


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func Combat():
	return
func movePhases():
	if curstate==State.PlayerMain:
		curstate=State.PlayerCombat
	elif curstate==State.PlayerCombat:
		Combat()
		curstate=State.PlayerTurnEnd
	elif curstate==State.CompMain:
		curstate=State.CompCombat
	elif curstate==State.CompCombat:
		Combat()
		curstate=State.CompTurnEnd
	elif curstate == State.PlayerTurnEnd:
		curstate=State.CompMain
	elif curstate==State.CompTurnEnd:
		curstate=State.PlayerMain
	
