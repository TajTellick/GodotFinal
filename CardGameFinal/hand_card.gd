extends CharacterBody2D
var power =0
var health =0
var mouse_in =0
var numberInHand = null
func setPower(newPower):
	power=newPower
	get_node("PowerHealth").text= "Power: " + str(power)
func setHealth(newHealth):
	health=newHealth
	get_node("PowerHealth").text= "Power: " + str(power) + " Health: " + str(health) 
func setCardType(type):
	if(type=="pink_monster"):
		$AnimatedSprite2D.play("pink_monster")
	elif(type=="ooze"):
		$AnimatedSprite2D.play("ooze")
	elif(type=="ghost"):
		$AnimatedSprite2D.play("ghost")
	elif(type=="ooze"):
		$AnimatedSprite2D.play("fireball")
	elif(type=="lightning_bolt"):
		$AnimatedSprite2D.play("lightning_bolt")
func setCardInHand(number):
	numberInHand=number
func _on_mouse_shape_entered(shape_idx):
	mouse_in=1

func _on_mouse_shape_exited(shape_idx):
	mouse_in=0
func _process(delta):
	if Input.is_action_pressed("mouse_button_left") && mouse_in == 1:
		Global.selectedCard= numberInHand
