extends CharacterBody2D


enum State {ALIVE, DEAD}

var health = 10
var curstate = State.ALIVE

func kill():
	if health==0:
		curstate=State.DEAD
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.play("death")
	elif curstate == State.DEAD:
		self.queue_free()
	else:
		print(health)
		

func takingDamage(damage):
	health+=damage
	kill()

