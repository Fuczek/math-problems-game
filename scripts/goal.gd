extends Label

var number_to_get : int
signal transfer_new_number

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize_new_number()

func _on_score_score_sufficient():
	await get_tree().create_timer(0.5).timeout
	randomize_new_number()
	PlayerData.player_level += 1
	
func randomize_new_number():
	RandomNumberGenerator.new()
	number_to_get = randi_range(11 + 20 * PlayerData.player_level, 20 * PlayerData.player_level)
	text = "GOAL: " + str(number_to_get)
	emit_signal("transfer_new_number", number_to_get)
