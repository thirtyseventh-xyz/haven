extends Area2D

func object_entered(body:Node2D) -> void:
	if body is Player:
		get_tree().change_scene_to_file("res://levels/lose.tscn")
