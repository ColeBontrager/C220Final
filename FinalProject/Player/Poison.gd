extends Node

onready var SM = get_parent()
onready var player = get_node("../..")

func _ready():
	yield(player, "ready")

func start():
	player.set_animation("Poison")
	if Input.is_action_pressed("poison"+str(player.action)):
		player.moves.append("poison")
	else:
		player.moves =[]

func physics_process(_delta):
	if not player.animating:
		SM.set_state("Idle")
