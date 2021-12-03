extends Node

onready var SM = get_parent()
onready var player = get_node("../..")
onready var poison1 = load("res://Poison/Poison1.tscn")
onready var poison2 = load("res://Poison/Poison2.tscn")
var offset = Vector2(5, 0)

onready var container = get_node_or_null("/root/Game/poison_container")
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
		var proj = poison1
		if player.action == 2:
			proj = poison2
		var poison = proj.instance()
		container.add_child(poison)
		poison.global_position = player.global_position + Vector2(50 * player.direction, -8)
		poison.speed *= player.direction
		SM.set_state("Idle")
