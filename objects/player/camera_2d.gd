extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("scroll down") and zoom.x - 0.04 >= 0.2:
		zoom.x -= 0.04
		zoom.y -= 0.04

	if Input.is_action_pressed("scroll up") and zoom.x + 0.04 <= 2:
		zoom.x += 0.04
		zoom.y += 0.04
  
