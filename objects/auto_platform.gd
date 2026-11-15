extends StaticBody2D

var auto_plat:PackedScene = load("res://objects/auto-platform.tscn")
var coin:PackedScene = load("res://coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if randi_range(1,10) == 10:
		var new_coin = coin.instantiate()
		new_coin.position = Vector2(0,-48)
		add_child(new_coin)
	
	var spawn_type:int = randi_range(0,4) 
	Global.platforms_recursion += 1
	
	print("platform "+str(Global.platforms_recursion)+" replicating")
	
	if spawn_type != 0 and Global.platforms_recursion < 64: #only one new platform
		var platform := auto_plat.instantiate()
		var spawn_pos = Vector2(randf_range(350,400),randf_range(-120,80))
		platform.position = spawn_pos

		add_child(platform)
		#print("created new platform at "+str(spawn_pos)+" relative to this one! abs pos is "+str(platform.global_position))
		
	elif Global.platforms_recursion <64:
		var spawn_x = randf_range(350,400)
		
		var up_platform := auto_plat.instantiate()
		var up_pos  = Vector2(spawn_x,randf_range(-120,80)+125)
		up_platform.position = up_pos
		add_child(up_platform)
		
		var down_platform := auto_plat.instantiate()
		var down_pos  = Vector2(spawn_x,randf_range(-120,80)-125)
		down_platform.position = down_pos
		add_child(down_platform)
