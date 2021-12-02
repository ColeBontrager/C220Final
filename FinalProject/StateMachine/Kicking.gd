extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Kicking")
	if Input.is_action_pressed("kick"+str(player.action)):
		player.moves.append("kick")
	else:
		player.moves =[]

func physics_process(_delta):
	if not player.animating:
		var kick = player.get_node("Attack/Kick")
		if kick.is_colliding():
			print("kicking")
			var enemy = kick.get_collider()
			if enemy.has_method("damage"):
				enemy.damage(player.kick)
		SM.set_state("Idle")
