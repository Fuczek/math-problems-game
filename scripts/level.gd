extends Label

func _on_score_score_sufficient():
	await get_tree().create_timer(0.5).timeout
	text = "LEVEL: " + str(PlayerData.player_level)
