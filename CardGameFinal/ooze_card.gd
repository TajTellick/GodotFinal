extends CharacterBody2D
var power =2
var health =6
var mouse_in =0
var numberInHand = 1
func setPower(newPower):
	power=newPower
	get_node("PowerHealth").text= "Power: " + str(power)
func setHealth(newHealth):
	health=newHealth
	get_node("PowerHealth").text= "Power: " + str(power) + " Health: " + str(health) 
func setCardInHand(number):
	numberInHand=number

	
func _process(delta):
	get_node("PowerHealth").text= "Power: " + str(power) + " Health: " + str(health) 
	if Input.is_action_pressed("mouse_button_left") && mouse_in == 1:
		print("card selected")
		Global.selectedCard= numberInHand


func _on_area_2d_mouse_shape_exited(shape_idx):
	mouse_in=0


func _on_area_2d_mouse_shape_entered(shape_idx):
	mouse_in=1
