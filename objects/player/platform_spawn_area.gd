extends Node2D

@onready var platform_scene:PackedScene = load("res://objects/platform.tscn")
@onready var platform_coin_scene:PackedScene = load("res://objects/platform-coin.tscn")
@onready var spawners = [$PlatformSpawnArea]#,$PlatformSpawnArea2,$PlatformSpawnArea3]

var last_spawn_pos:Vector2

func spawn_platform() -> void:
	var i:int = 0
	for spawner in spawners:
		var spawn_height:float
		spawn_height = spawner.get_child(0).shape.get_rect().size.y
		
		var spawn_pos:Vector2
		var random_area = randi_range(1,3)
		if random_area != 4:
			spawn_pos = Vector2(spawner.global_position.x,spawner.global_position.y + randf_range(spawn_height*(2.0/3.0),spawn_height/3))
			if last_spawn_pos:
				print("distance to last position from new position is "+str(last_spawn_pos.distance_to(spawn_pos)))
				while (last_spawn_pos.distance_to(spawn_pos) > 350 or last_spawn_pos.distance_to(spawn_pos) < 200) and last_spawn_pos.distance_to(global_position) < 500:
					print("retrying platform creation, does not fit within bounds as distance is "+str(last_spawn_pos.distance_to(spawn_pos)))
					spawn_pos = Vector2(spawner.global_position.x,spawner.global_position.y + randf_range(spawn_height*(2.0/3.0),spawn_height/3))
		
		else:
			spawn_pos = Vector2(spawner.global_position.x,randf_range(0,spawn_height))
			if last_spawn_pos:
				print("distance to last position from new position is "+str(last_spawn_pos.distance_to(spawn_pos)))
		
				while (last_spawn_pos.distance_to(spawn_pos) > 250 or last_spawn_pos.distance_to(spawn_pos) < 200) and last_spawn_pos.distance_to(global_position) < 500:
					spawn_pos = Vector2(spawner.global_position.x,randf_range(0,spawn_height))
		last_spawn_pos = spawn_pos
		
		if randi_range(1,1) == 4:
			pass
		else:
			var platform
			if randi_range(1,20) == 20:
				platform = platform_coin_scene.instantiate()
			else:
				platform = platform_scene.instantiate()
			get_tree().root.add_child(platform)
			platform.global_position = spawn_pos
			
			platform.set_meta("Spawner",i)
			print("platform created at "+str(spawn_pos))
		i += 1

func trigger_spawn_from_old_platform(body:Node2D) -> void:
	if body is Platform and body.get_meta("Spawner") == 0:
		print("triggered replacement")
		spawn_platform()
