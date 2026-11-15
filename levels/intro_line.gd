extends Node2D
@onready var intro_line_line: Line2D = $IntroLineLine
var multiplier_thing_for_scale = 15
var nvda_peak = 250*multiplier_thing_for_scale
var num_intervals = 20
var y_val = 0
signal keyframes_generated()

func _ready() -> void:
	
	intro_line_line.set_point_position(0, Vector2(-((num_intervals+(num_intervals/2))*10*multiplier_thing_for_scale), 0))
	
	for i in range(num_intervals):
		if i == num_intervals-1:
			y_val = -nvda_peak
		else:
			y_val = randi_range(y_val+(nvda_peak/num_intervals)-10*multiplier_thing_for_scale, y_val+(-nvda_peak/num_intervals)-10*multiplier_thing_for_scale)
		intro_line_line.add_point(Vector2(
		((i+1)*10*multiplier_thing_for_scale)
		-((num_intervals+(num_intervals/2))*10*multiplier_thing_for_scale)
		,y_val))
	num_intervals /= 2
	for i in range(num_intervals):
		if i == num_intervals-1:
			y_val = 0*multiplier_thing_for_scale
		else:
			y_val = randi_range(y_val+(nvda_peak/num_intervals)+10*multiplier_thing_for_scale, y_val+(-nvda_peak/num_intervals)+10*multiplier_thing_for_scale)
		intro_line_line.add_point(Vector2(
		((2*num_intervals+(i+1))*10*multiplier_thing_for_scale)
		-((2*num_intervals+num_intervals)*10*multiplier_thing_for_scale)
		,y_val))
	
	Global.intro_keyframes_nvda = [Vector2((-num_intervals*3*10*multiplier_thing_for_scale),0),Vector2(-num_intervals*10*multiplier_thing_for_scale,-nvda_peak),Vector2(0,0)]
	keyframes_generated.emit()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
