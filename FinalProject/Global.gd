extends Node

var save_file = ConfigFile.new()
const SAVE_PATH = "res://settings.cfg"

onready var HUD = get_node_or_null("/root/Game/UI/HUD")
onready var Enemies = get_node_or_null("/root/Game/Enemy_Container")
onready var end = get_node_or_null("/root/Game/End")
onready var Game = load("res://Game.tscn")

var player1_health = 100.0
var player1_maxhealth = 100.0
var player2_health = 100.0
var player2_maxhealth = 100.0

var input_active = false

var save_data = {
	"general": {
		"enemy_health": 400
		,"health":100
		,"enemy": []
		

	}
}

func save_game():

	save_data["general"]["enemy"] = []
	for e in Enemies.get_children():
		save_data["general"]["enemy"].append(e.position)
	for section in save_data.keys():
		for key in save_data[section]:
			save_file.set_value(section, key, save_data[section][key])
	save_file.save(SAVE_PATH)
	
func load_game():
	var error = save_file.load(SAVE_PATH)
	if error != OK:
		print("Failed loading file")
		return
	
	save_data["general"]["enemy"] = []
	for section in save_data.keys():
		for key in save_data[section]:
			save_data[section][key] = save_file.get_value(section, key, null)
	var _scene = get_tree().change_scene_to(Game)
	call_deferred("restart_level")

func update_damage(damage, player):
	if player == 1:
		player1_health -= damage
	elif player == 2:
		player2_health -= damage
	if player1_health <= 0 || player2_health <= 0:
		end_game()

func end_game():
	end = get_node_or_null("/root/Game/End")
	get_node_or_null("/root/Game/HUD/Panel/Timer").stop()
	end.show()
	input_active = false
	if player1_health < player2_health:
		end.get_child(2).text = "PLAYER 2 WON"
	else:
		end.get_child(2).text = "PLAYER 1 WON"
		
		

