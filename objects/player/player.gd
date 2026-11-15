extends CharacterBody2D

@export var SPEED = 200
const JUMP_VELOCITY = -450
signal new_line_point(pos:Vector2)
signal track_last_point(pos:Vector2)
@onready var camera_2d: Camera2D = $Camera2D
var frozen = true
@onready var animation_player: AnimationPlayer = $AnimationPlayer

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
		if frozen == false:
			velocity += get_gravity() * delta
		if sign(velocity.y) != last_vel_state and sign(velocity.y) == 1: # and sign(velocity.y) != 0 and last_vel_state == 1 :
			new_line_point.emit(position)
		
		last_vel_state = sign(velocity.y)

	if was_in_air and is_on_floor():
		was_in_air = false
		new_line_point.emit(position)
	
	if frozen == false:
		velocity.x = SPEED
	move_and_slide()


func _on_coin_body_entered(body: Node2D) -> void:
	velocity.y = -1200
	new_line_point.emit(position)


func _on_intro_line_keyframes_generated() -> void:
	for i in range(3):
		animation_player.get_animation("nvda intro").track_set_key_value(0, i, Global.intro_keyframes_nvda[i])
	print(Global.intro_keyframes_nvda)
	animation_player.play("nvda intro")
