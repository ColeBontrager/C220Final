extends Area2D


var direction = Vector2(1, 0)
export var speed = 400
export var rotate_speed = 270
export var damage = 5
export var type = 1
onready var cloud = load("res://Poison/PoisonCloud.tscn")
onready var cloud2 = load("res://Poison/PoisonCloud2.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	position += direction * speed * delta
	rotation_degrees += rotate_speed * delta
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Poison_body_entered(body):
	if body.has_method("damage"):
		body.damage(damage)
		if type == 1:
			var cl = cloud.instance()
			body.add_child(cl)
		else:
			var cl = cloud2.instance()
			body.add_child(cl)
		
	queue_free()
