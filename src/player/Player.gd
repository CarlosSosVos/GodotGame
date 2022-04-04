extends KinematicBody2D

const MAX_SPEED = 140 		# pixel / s
const ACCELERATION = 800    # Funciona igual como fricción
const GRAVITY = 60*10       # Permite que la velocidad inter-frame sea GRAVITY / FPS
const MAX_FALL_SPEED = 250
const JUMP_SPEED = 60*230   

# ===========================================================================================
# Sean G y JS respectivamente GRAVITY Y JUMP_SPEED. Definamos el impulso de salto, I, como:
# 	I = (G - JS) / FPS
# Entonces, el desplazamiento máximo alcanzado por un salto es I^2 / (2G) pixeles, y la  
# duración completa del salto es 2I/G, en las unidades temporales en que estén I y G.
# ===========================================================================================

var velocity = Vector2.ZERO
onready var animationPlayer = $AnimationPlayer

func _physics_process(delta):
    move(delta)
    jump(delta)
    animation()
    velocity = move_and_slide(velocity, Vector2.UP)

func jump(delta):
    if Input.is_action_just_pressed('jump') and is_on_floor():
        print(velocity)
        velocity += Vector2.UP * JUMP_SPEED * delta  # Da un impulso de GRAVITY/FPS - JS/FPS = I
        print(velocity)

func move(delta): 
    var input = sign(Input.get_action_strength("right") - Input.get_action_strength("left"))
    velocity.x = move_toward(velocity.x, MAX_SPEED*input, delta*ACCELERATION)
    velocity.y = move_toward(velocity.y, MAX_FALL_SPEED, delta*GRAVITY)
    print(velocity)

func crouch():
    pass

func animation():
    if not is_on_floor():
        animationPlayer.play("jump")
        if velocity.x != 0:
            animationPlayer.flip_h = velocity.x < 0 
    elif velocity.x != 0 :
        animationPlayer.play("run")
        animationPlayer.flip_h = velocity.x < 0 
    else:
        animationPlayer.play("idle")

