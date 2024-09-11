extends CharacterBody2D

@onready var value_label : Node = $value
@export var speed : int = 30
@export var accel : int = 10
@export var value : int = 5

signal add_to_score

enum direction {LEFT = 0, RIGHT = 1, UP = 2, DOWN = 3, NONE = 4}

var random_direction : int
var when_to_change_direction : int = 60
var new_direction

func _ready():
	random_direction = randi_range(0, 3)
	when_to_change_direction = 60
	value_label.text = str(value)
	value_label.label_settings.outline_color = Color.from_hsv(0.4 + 0.6 * value/40.0, 0.8, 0.8, 1.0)

func _physics_process(_delta):
	if when_to_change_direction < 60:
		when_to_change_direction += 1
	else:
		random_direction = randi_range(0, 3)
		when_to_change_direction = 0
		new_direction = direction.values()[random_direction]

	match new_direction:
		0:
			velocity.x = move_toward(velocity.x, speed * -1, accel)
		1:
			velocity.x = move_toward(velocity.x, speed * 1, accel)
		2:
			velocity.y = move_toward(velocity.y, speed * -1, accel)
		3:
			velocity.y = move_toward(velocity.y, speed * 1, accel)
		4:
			velocity = Vector2(0, 0)
	
	move_and_slide()

var enemy_under : Area2D

func _on_area_entered(area):
	if area.name != "target":
		enemy_under = area
		
func find_areas_under():
	if enemy_under:
		print('My value:', value, ' ', 'Under value: ', enemy_under.get_parent().value)
		var new_enemy = load("res://scenes/enemy.tscn")
		var new_enemy_instance = new_enemy.instantiate()
		
		
		var equation_result : int
		match PlayerData.selected_equation:
			PlayerData.equations.ADDITION:
				equation_result = value + enemy_under.get_parent().value
			PlayerData.equations.SUBTRACTION:
				equation_result = enemy_under.get_parent().value - value
				
			PlayerData.equations.MULTIPLICATION:
				equation_result = value * enemy_under.get_parent().value
			PlayerData.equations.DIVISION:
				if enemy_under.get_parent().value != 0:
					equation_result = enemy_under.get_parent().value / value
				else:
					equation_result = value + enemy_under.get_parent().value
					
		new_enemy_instance.value = equation_result
		new_enemy_instance.position = get_global_mouse_position()
		get_parent().add_child(new_enemy_instance)
		
		var score_node = get_tree().get_first_node_in_group("score")
		var moves_node = get_tree().get_first_node_in_group("moves")
		self.add_to_score.connect(score_node._update_score.bind(equation_result))
		self.add_to_score.connect(moves_node._update_moves)
		emit_signal("add_to_score")
		
		enemy_under.get_parent().queue_free()
		self.queue_free()

	else:
		print('no enemy under')
	
func _on_area_exited(_area):
	enemy_under = null


func _on_score_score_sufficient():
	pass # Replace with function body.
