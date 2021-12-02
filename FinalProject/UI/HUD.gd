extends CanvasLayer

var countdown = 60

func _ready():
	$Panel/Player1.value = (Global.player1_health/ Global.player1_maxhealth)*100
	$Panel/Player2.value = (Global.player2_health/ Global.player2_maxhealth)*100
	
func _physics_process(delta):
	$Panel/Player1.value = (Global.player1_health/ Global.player1_maxhealth)*100
	$Panel/Player2.value = (Global.player2_health/ Global.player2_maxhealth)*100



func _on_Timer_timeout():
	if countdown > 0:
		countdown -= 1
		$Panel/Time.text = str(countdown)
	else:
		Global.end_game()
