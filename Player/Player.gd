extends KinematicBody2D

onready var SM = $StateMachine

var velocity = Vector2.ZERO
var jump_power = Vector2.ZERO
var direction = 1

export var gravity = Vector2(0,30)

export var move_speed = 20.0
export var max_move = 300.0

export var jump_speed = 100
export var max_jump = 1000

export var leap_speed = 100
export var max_leap = 1000

var moving = false
var is_jumping = false
var should_direction_flip = true # wether or not player controls (left/right) can flip the player sprite
var animating = false

export var punch = 10


export var kick = 15

export var action = 1

var moves = []

func _ready():
	if action == 2:
		direction = -1
		
func _physics_process(_delta):
	velocity.x = clamp(velocity.x,-max_move,max_move)
		
	if should_direction_flip:
		if direction < 0 and not $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = true
		if direction > 0 and $AnimatedSprite.flip_h: $AnimatedSprite.flip_h = false
		var kick = get_node("Attack/Kick")
		var punch = get_node("Attack/Punch")
		if direction == 1:
			kick.rotation_degrees = 0
			punch.rotation_degrees = 0
		else:
			kick.rotation_degrees = 180
			punch.rotation_degrees = 180
	#print(moves)


func is_moving():
	if Input.is_action_pressed("left"+str(action)) or Input.is_action_pressed("right"+str(action)):
		return true
	return false

func move_vector():
	return Vector2(Input.get_action_strength("right"+str(action)) - Input.get_action_strength("left"+str(action)),1.0)

func _unhandled_input(event):
	if event.is_action_pressed("left"+str(action)) and Global.input_active:
		direction = -1
	if event.is_action_pressed("right"+str(action)) and Global.input_active:
		direction = 1

func set_animation(anim):
	animating = true
	if $AnimatedSprite.animation == anim: return
	if $AnimatedSprite.frames.has_animation(anim): $AnimatedSprite.play(anim)
	else: $AnimatedSprite.play()

func is_on_floor():
	var fl = $Floor.get_children()
	for f in fl:
		if f.is_colliding():
			return true
	return false

func die():
	queue_free()

func damage(damage):
	Global.update_damage(damage, action)
	if action == 1 and Global.player1_health <= 0:
		SM.set_state("KO")
	if action == 2 and Global.player2_health <= 0:
		SM.set_state("KO")

func _on_AnimatedSprite_animation_finished():
	animating = false
