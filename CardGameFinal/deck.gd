extends Node2D

var cardsLeft =12
var cardsInHand = 3
var mouse_in =0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	if Input.is_action_pressed("mouse_button_left") && mouse_in == 1:
		displayStats(Global.cardsPlayed)
	if Input.is_action_pressed("mouse_button_right") && mouse_in == 1&&Global.cardDrawn==0:
		emit_signal("draw")
		Global.cardDrawn+=1
		print("drawing card")
#eventually will be played when right clicking on deck
#will push to a text box when setup
func displayStats(cardsPlayed):
	print(str(cardsLeft-Global.turnNumber) +" cards left")
	print(str(cardsInHand+Global.turnNumber-cardsPlayed)+ " cards in hand")
 

func _on_area_2d_mouse_shape_exited(shape_idx):
	mouse_in=0


func _on_area_2d_mouse_shape_entered(shape_idx):
	mouse_in=1
