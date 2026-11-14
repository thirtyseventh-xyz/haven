extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and is_on_floor():
			velocity.y = JUMP_VELOCITY


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
