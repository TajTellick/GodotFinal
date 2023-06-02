extends Player 


enum State {ALIVE, DEAD}
enum State2 {SITTING, JUMP_LEFT, JUMP_UP, JUMP_RIGHT, JUMP_DOWN, DYING, DEAD}
const JUMP_STATES = [State2.JUMP_DOWN, State2.JUMP_LEFT, State2.JUMP_RIGHT, State2.JUMP_UP]
var health = 6
var curstate = State.ALIVE
var power =2
var rng = RandomNumberGenerator.new()
var cardNumber=2
var curstate2 = State2.SITTING
var state_time = 0.0
func setStats(newPower,newHealth):
	power=newPower
	health=newHealth
func kill():
	if health<=0:
		curstate=State.DEAD
		$AnimatedSprite2D.frame = 0
		$AnimatedSprite2D.play("death")
	elif curstate == State.DEAD:
		self.queue_free()
	else:
		print(health)
		
func callCardNumber():
	return cardNumber
func attack(target,targetHealth,targetPower):
	targetHealth-power
	takingDamage(targetPower)
func attackPlayer(play):
	if(play=="player"):
		Global.playerHealth-=power
	elif(play=="comp"):
		Global.compHealth-=power
func takingDamage(damage):
	var my_random_number = rng.randf_range(1, 100)
	if(my_random_number<6):
		health-=damage-2
	else:
		health-=damage
	kill()


const JUMP_VECTORS = {
	State2.JUMP_UP: [Vector2.ZERO, Vector2.ZERO, Vector2(0, -75), Vector2(0, -75), Vector2(0, -75), Vector2.ZERO, Vector2.ZERO],
	State2.JUMP_DOWN: [Vector2.ZERO, Vector2.ZERO, Vector2(0, 75), Vector2(0, 75), Vector2(0, 75), Vector2.ZERO, Vector2.ZERO],
	State2.JUMP_LEFT: [Vector2.ZERO, Vector2.ZERO, Vector2(-75, 0), Vector2(-100, 0), Vector2(-75, 0), Vector2.ZERO, Vector2.ZERO],
	State2.JUMP_RIGHT: [Vector2.ZERO, Vector2.ZERO, Vector2(75, 0), Vector2(100, 0), Vector2(75, 0), Vector2.ZERO, Vector2.ZERO],
}



# Called when the node enters the scene tree for the first time.
func _ready():
	switch_to(State2.SITTING)

# Called when you switch to a new state
# Handles starting the proper animation, reseting the timers and
# removing yourself once dead
func switch_to(new_state: State2):
	# Prevent invalid transitions, once you start dying, you can't go back to jumping
	if curstate2 == State2.DYING and new_state != State2.DEAD:
		return
		
	curstate = new_state
	state_time = 0.0
	
func _physics_process(delta):
	# Update the amount of time you spent in the current state
	state_time += delta
	
	if (Global.compCardPlay>0):
		var player = get_tree().get_root().find_child("Player",true,false)
		var dir = player.position -self.position
		var ang = rad_to_deg(dir.angle())
		if curstate2 == State2.SITTING and state_time> 2.0:
			if ang >-45 and ang <=45:
				switch_to(State2.JUMP_LEFT)
			elif ang>45 and ang <=135:
				switch_to(State2.JUMP_UP)
			elif ang<-45 and ang >=-135:
				switch_to(State2.JUMP_DOWN)
			else:
				switch_to(State2.JUMP_RIGHT)
			if curstate in JUMP_STATES:
				move_and_collide(JUMP_VECTORS[curstate][$AnimatedSprite2D.frame] * delta)
