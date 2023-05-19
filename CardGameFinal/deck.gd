extends Node2D

var cardsLeft =12
var cardsInHand = 3
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#eventually will be played when right clicking on deck
#will push to a text box when setup
func displayStats(turnNumber,cardsPlayed):
	print(cardsLeft-turnNumber)
	print(cardsInHand+turnNumber-cardsPlayed)
