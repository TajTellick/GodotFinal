extends CharacterBody2D


var cardNumber=3
var power=5

func damage(target):
	if(target=="0"):
		Global.playerHealth-=power
	elif(target=="1"):
		Global.compHealth-=power
	self.queue_free()
func _ready():
	damage(Global.target)
