extends KinematicBody2D

var velocity = Vector2.ZERO
#managing constants here
const MAX_SPEED = 140
const MAX_ACCEL = 800
const FRICTION = 400
const GRAVITY = 600
const MAX_FALL_SPEED = 200
const JUMP_SPEED = 60*230

onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
	move(delta)
	jump(delta)
	animation()
	velocity = move_and_slide(velocity, Vector2.UP)

func jump(delta):
	if Input.is_action_just_pressed('jump') and is_on_floor():
		velocity += Vector2.UP * JUMP_SPEED * delta

func move(delta): 
	var input = sign(Input.get_action_strength("right") - Input.get_action_strength("left"))
	velocity.x = move_toward(velocity.x, MAX_SPEED*input, delta*MAX_ACCEL)
	velocity.y = move_toward(velocity.y, MAX_FALL_SPEED, delta*GRAVITY)

func crouch():
	pass

func animation():
	if not is_on_floor():
		animationPlayer.play("jump")
	elif velocity.x != 0 :
		animationPlayer.play("run")
		animationPlayer.flip_h = velocity.x < 0
	else:
		animationPlayer.play("idle")

