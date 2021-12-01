extends KinematicBody2D

var health = 100.0
var max_health = 100.0

func _ready():
	pass #
	
func damage(d):
	health -= d
	$Sprite.modulate.a = health / max_health
	if health <= 0:
		queue_free()
	Global.player2_health -= d
	
