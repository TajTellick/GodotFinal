extends CharacterBody2D


enum State {ALIVE, DEAD}

var health = 10
var curstate = State.ALIVE
var power =0
var rng = RandomNumberGenerator.new()
var cardNumber=2

func setStats(newPower,newHealth):
	power=newPower
	health=newHealth
func kill():
	if health==0:
		curstate=State.DEAD
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.play("death")
	elif curstate == State.DEAD:
		self.queue_free()
	else:
		print(health)
		
func callCardNumber():
	return cardNumber
	
func takingDamage(damage):
	var my_random_number = rng.randf_range(1, 100)
	if(my_random_number<6):
		health+=damage+2
	else:
		health+=damage
	kill()

