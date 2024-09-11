extends Area2D

@onready var target_sprite = $target_sprite
var hovered_body : Node


func _on_body_entered(body):
	if !hovered_body:
		if body.name != "player":
			self.modulate = "#d6005f"
			hovered_body = body
	
func _on_body_exited(_body):
	self.modulate = "#ffffff"
	if !pressed:
		hovered_body = null

func _physics_process(delta):
	if Input.is_action_just_released("ui_accept"):
		pressed = false
		drop()
	if Input.is_action_pressed("ui_accept"):
		pick_up()
		
var pressed : bool = false
func pick_up():
	if hovered_body:
		pressed = true
		hovered_body.new_direction = 4
		hovered_body.position = self.global_position

func drop():
	if hovered_body:
		hovered_body.find_areas_under()
