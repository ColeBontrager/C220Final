extends Node

var save_file = ConfigFile.new()
const SAVE_PATH = "res://settings.cfg"

onready var HUD = get_node_or_null("/root/Game/UI/HUD")
onready var Enemies = get_node_or_null("/root/Game/Enemy_Container")
onready var Game = load("res://Game.tscn")

var player1_health = 100.0
var player1_maxhealth = 100.0
var player2_health = 400.0
var player2_maxhealth = 400.0

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




func _unhandled_input(event):
	if event.is_action_pressed("quit"):
		get_tree().quit()
		

