extends KinematicBody2D

var motion = Vector2(0,0)
#managing constants here
const SPEED = 450
const GRAVITY = 100
const UP = Vector2(0,-1)
const JUMP_SPEED = 1500

signal animate

func _physics_process(delta):
	apply_gravity()
	jump()
	move()
	animation()
	crouch()
	move_and_slide(motion, UP)


func crouch():
	pass


func jump():
	if Input.is_action_pressed('jump') and is_on_floor():
		motion.y -= JUMP_SPEED


func move(): 
	if Input.is_action_pressed('left') and not Input.is_action_pressed('right') :	
		motion.x = -SPEED
	elif Input.is_action_pressed('right') and not Input.is_action_pressed('left'):
		motion.x = SPEED
	else:
		motion.x = 0


func apply_gravity():
	if is_on_floor():
		motion.y = 0
	elif is_on_ceiling():
		motion.y = 1
	else:
		motion.y += GRAVITY
		pass


func animation():
	emit_signal("animate",motion)

