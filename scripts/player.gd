extends CharacterBody2D

@onready var target : Node = get_parent().get_node("target")
@export var speed : int = 600
@export var accel : int = 30

func _physics_process(_delta):
	var direction : Vector2 = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity.x = move_toward(velocity.x, speed * direction.x, accel)
	velocity.y = move_toward(velocity.y, speed * direction.y, accel)
	move_and_slide()

	target.position = get_global_mouse_position()
