extends Node

@onready var new_enemy : PackedScene = preload("res://scenes/enemy.tscn")
@onready var enemies_group : Node = get_tree().get_first_node_in_group("enemies_group")

func spawn_enemy():
	if enemies_group.get_child_count() < 25:
		var new_enemy_instance = new_enemy.instantiate()
		new_enemy_instance.value = randi_range(1, 4 + PlayerData.player_level * 5)
		new_enemy_instance.position = Vector2(randi_range(0, get_viewport().get_visible_rect().size.x), randi_range(0, get_viewport().get_visible_rect().size.y))
		enemies_group.add_child.call_deferred(new_enemy_instance)
	else:
		enemies_group.get_child(0).queue_free()
