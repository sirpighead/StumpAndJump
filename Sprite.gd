extends Sprite

const UP = Vector2(0,-1)
const GRAVITY = 20
const MAX_FALL_SPEED = 200
const MAXSPEED = 80

var motion = Vector2()
func _ready():
	pass

func _physics_process(delta):
	
	motion.y += GRAVITY
	if motion.y > MAX_FALL_SPEED:
		motion.y = MAX_FALL_SPEED
	
	if  Input.is_action_just_pressed("left"):
		motion.x = -MAXSPEED
	elif Input.is_action_just_pressed("right"):
		motion.x = MAXSPEED
	else:
		motion.x = 0
		
