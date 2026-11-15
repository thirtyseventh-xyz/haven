extends CharacterBody2D
class_name Player

@export var SPEED = 300
var this_jump_from_coin:bool = false
var is_paused:bool = false
const JUMP_VELOCITY = -550
signal new_line_point(pos:Vector2)
signal track_last_point(pos:Vector2)
@onready var camera_2d: Camera2D = $Camera2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var auto_platform:PackedScene = load("res://objects/auto-platform.tscn")

func _ready() -> void:
	new_line_point.emit(position)

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE and is_on_floor():
			velocity.y = JUMP_VELOCITY
			new_line_point.emit(position)
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT and is_on_floor():
			velocity.y = JUMP_VELOCITY
			new_line_point.emit(position)


var last_vel_state:int = 0
var was_in_air:bool = false
func _physics_process(delta: float) -> void:
	if Global.frozen == true:
		velocity.x = 0
		velocity.y = 0
	Global.pxpos = position.x
	Global.pypos = position.y
	
	# Add the gravity.
	if Input.is_key_pressed(KEY_SHIFT):
		is_paused = true
		$PlatformSpawnTrigger/SpawnTimer.paused = true
	else:
		is_paused = false
	if not is_paused:
		track_last_point.emit(position)
		
		if not is_on_floor():
			was_in_air = true
			if Global.frozen == false:
				velocity += get_gravity() * delta
			if sign(velocity.y) != last_vel_state and sign(velocity.y) == 1: # and sign(velocity.y) != 0 and last_vel_state == 1 :
				new_line_point.emit(position)
				
				if this_jump_from_coin:
					this_jump_from_coin = false
					var new_platform = auto_platform.instantiate()
					new_platform.position = Vector2(position.x+75,position.y+75)
					new_platform.set_meta("Index",len(Global.platforms_recursion))
					add_sibling.call_deferred(new_platform)
					
			last_vel_state = sign(velocity.y)

		if was_in_air and is_on_floor():
			was_in_air = false
			new_line_point.emit(position)
		
		if Global.frozen == false:
			velocity.x = SPEED
		move_and_slide()

func get_coin() -> void:
	velocity.y = -1500
	this_jump_from_coin = true
	new_line_point.emit(position)

func _on_intro_line_keyframes_generated() -> void:
	for i in range(3):
		$AnimationPlayer.get_animation("nvda intro").track_set_key_value(0, i, Global.intro_keyframes_nvda[i])
	$AnimationPlayer.play("nvda intro")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	Global.frozen = false
