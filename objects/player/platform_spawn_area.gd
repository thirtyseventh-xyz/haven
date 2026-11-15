extends Area2D


func spawn_platform() -> void:
	var spawn_height:float
	spawn_height = $CollisionShape2D.shape.get_rect().size.y
	
	var spawn_pos:Vector2
	spawn_pos = Vector2(0,randf_range(0,spawn_height))
	
	

func _ready() -> void:
	spawn_platform()
