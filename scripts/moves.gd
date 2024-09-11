extends Label

var moves : int = 0

func _update_moves():
	moves += 1
	text = "MOVES TAKEN: " + str(moves)

func reset_moves():
	moves = 0
	text = "MOVES TAKEN: " + str(moves)

func _on_goal_transfer_new_number(_value):
	reset_moves()
