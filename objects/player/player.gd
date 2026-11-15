extends CharacterBody2D

@export var SPEED = 200
const JUMP_VELOCITY = -450
signal new_line_point(pos:Vector2)
signal track_last_point(pos:Vector2)
@onready var camera_2d: Camera2D = $Camera2D


func _ready() -> void:
	new_line_point.emit(position)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and is_on_floor():
			velocity.y = JUMP_VELOCITY
			new_line_point.emit(position)


var last_vel_state:int = 0
var was_in_air:bool = false
func _physics_process(delta: float) -> void:
	# Add the gravity.
	track_last_point.emit(position)
	
	if not is_on_floor():
		was_in_air = true
		velocity += get_gravity() * delta
		if sign(velocity.y) != last_vel_state and sign(velocity.y) == 1: # and sign(velocity.y) != 0 and last_vel_state == 1 :
			new_line_point.emit(position)
		
		last_vel_state = sign(velocity.y)

	if was_in_air and is_on_floor():
		was_in_air = false
		new_line_point.emit(position)
	
	velocity.x = SPEED
	move_and_slide()
	
	#print(str(velocity))


func _on_coin_body_entered(body: Node2D) -> void:
	velocity.y = -1200
	new_line_point.emit(position)


func _on_intro_line_keyframes_generated() -> void:
	camera_2d.position = Global.intro_keyframes_nvda[1]
