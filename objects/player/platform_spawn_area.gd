extends Area2D

@onready var platform_scene:PackedScene = load("res://objects/platform.tscn")


func spawn_platform() -> void:
	var spawn_height:float
	spawn_height = $CollisionShape2D.shape.get_rect().size.y
	
	var spawn_pos:Vector2
	spawn_pos = Vector2(global_position.x,randf_range(0,spawn_height))
	
	var platform := platform_scene.instantiate()
	get_tree().root.add_child(platform)
	platform.position = spawn_pos
	
	print("platform created at "+str(spawn_pos))
	
