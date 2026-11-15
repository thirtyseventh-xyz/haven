extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("scroll down"):
		zoom.x -= 0.05
		zoom.y -= 0.05

	if Input.is_action_pressed("scroll up"):
		zoom.x += 0.05
		zoom.y += 0.05
