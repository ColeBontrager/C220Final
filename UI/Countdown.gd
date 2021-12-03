extends Label


var time = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_CountdownTimer_timeout():
	time -= 1
	if time > 0:
		text = str(time)
	elif time == 0:
		text = "GO!"
	else:
		get_node_or_null("/root/Game/HUD/Panel/Timer").start()
		Global.input_active = true
		get_parent().queue_free()
		
