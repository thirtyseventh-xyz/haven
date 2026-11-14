extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0
signal new_line_point(pos:Vector2)
signal track_last_point(pos:Vector2)

func _ready() -> void:
	new_line_point.emit(position)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and is_on_floor():
			velocity.y = JUMP_VELOCITY
			new_line_point.emit(position)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	track_last_point.emit(position)
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	velocity.x = SPEED
	move_and_slide()
