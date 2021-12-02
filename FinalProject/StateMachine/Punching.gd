extends Node

var punch_sound = null

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Punching")
	if Input.is_action_pressed("punch"+str(player.action)):
		player.moves.append("punch")
	else:
		player.moves =[]
	
func physics_process(_delta):
	if not player.animating:
		var punch = player.get_node("Attack/Punch")
		if punch.is_colliding():
			print("punching")
			if punch_sound == null:
				punch_sound = get_node_or_null("root/Player/punch")
			if $punch_sound != null:
				$punch_sound.play()
			var enemy = punch.get_collider()
			if enemy.has_method("damage"):
				enemy.damage(player.punch)
		SM.set_state("Idle")
