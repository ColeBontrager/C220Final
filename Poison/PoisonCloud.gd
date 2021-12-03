extends Node2D


export var time = 2
export var damage = 5
export var slow = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().max_move *= slow


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_parent().damage(delta * damage)
	time -= delta
	if time <= 0:
		get_parent().max_move /= slow
		queue_free()
