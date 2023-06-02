extends CharacterBody2D
var power =1
var health =3
var mouse_in =0
var numberInHand = 0
func setPower(newPower):
	power=newPower
	get_node("PowerHealth").text= "Power: " + str(power)
func setHealth(newHealth):
	health=newHealth
	get_node("PowerHealth").text= "Power: " + str(power) + " Health: " + str(health) 
func setCardInHand(number):
	numberInHand=number
func _on_mouse_shape_entered(shape_idx):
	mouse_in=1

func _on_mouse_shape_exited(shape_idx):
	mouse_in=0
func _process(delta):
	get_node("PowerHealth").text= "Power: " + str(power) + " Health: " + str(health) 
	if Input.is_action_pressed("mouse_button_left") && mouse_in == 1:
		Global.selectedCard= numberInHand
