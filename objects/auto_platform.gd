extends StaticBody2D

var auto_plat:PackedScene = load("res://objects/auto-platform.tscn")
var coin:PackedScene = load("res://coin.tscn")
const max_replicas:int = 64

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(1,10) == 10:
		var new_coin = coin.instantiate()
		new_coin.position = Vector2(0,-48)
		add_child(new_coin)
	
	var spawn_type:int = randi_range(1,32) 
	var meta_index:int = get_meta("Index")
	
	if not Global.platforms_recursion.get(meta_index):
		Global.platforms_recursion.append(0)

	
	Global.platforms_recursion[meta_index] += 1
	
	print("platform "+str(Global.platforms_recursion[meta_index])+" replicating")
	#spawn_type = 0
	if spawn_type != 0 and Global.platforms_recursion[meta_index] < max_replicas: #only one new platform
		print("straight")
		var platform := auto_plat.instantiate()
		var spawn_pos = Vector2(randf_range(350,400),randf_range(-120,80))
		platform.position = spawn_pos + position
		platform.set_meta("Index",meta_index)

		add_sibling.call_deferred(platform)
		print("created new platform at "+str(spawn_pos)+" relative to this one! abs pos is "+str(platform.global_position))
		
	elif Global.platforms_recursion[meta_index] < max_replicas:
		print("me")
		
		var up_platform := auto_plat.instantiate()
		var up_pos  = Vector2(randf_range(350,550),randf_range(-240,160)+125)
		up_platform.position = up_pos
		add_sibling.call_deferred(up_platform)
		
		var down_platform := auto_plat.instantiate()
		var down_pos  = Vector2(randf_range(350,550),randf_range(-240,160)-125)
		down_platform.position = down_pos
		add_sibling.call_deferred(down_platform)
