extends Area2D

@onready var platform_scene:PackedScene = load("res://objects/platform.tscn")


func spawn_platform() -> void:
	var spawn_height:float
	spawn_height = $CollisionShape2D.shape.get_rect().size.y
	
	var spawn_pos:Vector2
	var random_area = randi_range(1,4)
	if random_area != 4:
		spawn_pos = Vector2(global_position.x,randf_range(spawn_height*(2.0/3.0),spawn_height/3))
	else:
		spawn_pos = Vector2(global_position.x,randf_range(0,spawn_height))
	
	var platform := platform_scene.instantiate()
	get_tree().root.add_child(platform)
	platform.position = spawn_pos
	
	print("platform created at "+str(spawn_pos))

func trigger_spawn_from_old_platform(body:Node2D) -> void:
	if body is Platform:
		print("triggered replacement")
		spawn_platform()
