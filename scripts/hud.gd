extends GridContainer

@onready var selected_rect = $item1/selected_rect
@onready var cursor_addition = preload("res://assets/target.png")
@onready var cursor_subtraction = preload("res://assets/target-minus.png")
@onready var cursor_multiplication = preload("res://assets/target-multi.png")
@onready var cursor_division = preload("res://assets/target-division.png")

var target : Node

func _ready():
	target = get_tree().get_first_node_in_group("target")

func _process(_delta):
	if Input.is_action_just_pressed("action1"):
		PlayerData.selected_equation = PlayerData.equations.ADDITION
		selected_rect.reparent(get_child(0))
		selected_rect.position = Vector2(0,0)
		target.target_sprite.texture = cursor_addition
		
	if Input.is_action_just_pressed("action2"):
		PlayerData.selected_equation = PlayerData.equations.SUBTRACTION
		selected_rect.reparent(get_child(1))
		selected_rect.position = Vector2(0,0)
		target.target_sprite.texture = cursor_subtraction
		
	if Input.is_action_just_pressed("action3"):
		PlayerData.selected_equation = PlayerData.equations.MULTIPLICATION
		selected_rect.reparent(get_child(2))
		selected_rect.position = Vector2(0,0)
		target.target_sprite.texture = cursor_multiplication
		
	if Input.is_action_just_pressed("action4"):
		PlayerData.selected_equation = PlayerData.equations.DIVISION
		selected_rect.reparent(get_child(3))
		selected_rect.position = Vector2(0,0)
		target.target_sprite.texture = cursor_division
