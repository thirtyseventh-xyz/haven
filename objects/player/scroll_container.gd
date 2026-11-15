extends ScrollContainer

var mouse_in = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("lmb") and mouse_in == 1 and not(get_tree().current_scene.scene_file_path == "res://levels/level_1.tscn"):
		get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_texture_rect_mouse_entered() -> void:
	mouse_in = 1


func _on_texture_rect_mouse_exited() -> void:
	mouse_in = 0
