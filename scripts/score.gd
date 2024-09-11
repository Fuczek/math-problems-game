extends Label

@onready var score_anim = $score_anim

signal score_sufficient
var number_to_get

func _update_score(result):
	score_anim.play("score_update")
	text = str(result)
	check_if_sufficient(result)

func check_if_sufficient(value):
	if value == number_to_get:
		emit_signal("score_sufficient")
		score_anim.play("score_sufficient")
	
func _on_goal_transfer_new_number(value):
	number_to_get = value
