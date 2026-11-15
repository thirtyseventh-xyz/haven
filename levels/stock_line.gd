extends Node2D

var last_point:Vector2 = Vector2(0,0)
var line:Line2D

const RED_LINE_COLOUR = Color(1.0, 0.0, 0.0, 1.0)
const GREEN_LINE_COLOUR = Color(0.02, 0.435, 0.365, 1.0)
const YELLOW_LINE_COLOUR = Color(0.864, 0.564, 0.15, 1.0)

func _ready() -> void:
	new_point(Vector2(0,0))
	
	$PlayerLine.add_point(last_point)
	$PlayerLine.add_point(last_point)
	$PlayerLine.default_color = RED_LINE_COLOUR
	
	$PlayerLine.begin_cap_mode = 2
	$PlayerLine.end_cap_mode = 2

func new_point(pos:Vector2) -> void:
	line = Line2D.new()
	add_child(line)
	
	line.add_point(last_point)
	line.add_point(pos)
	
	line.begin_cap_mode = 2
	line.end_cap_mode = 2
	
	if pos.y < last_point.y:
		line.default_color = GREEN_LINE_COLOUR
	elif pos.y > last_point.y:
		line.default_color = RED_LINE_COLOUR
	else:
		line.default_color = YELLOW_LINE_COLOUR
	
	last_point = pos

func track_last_point(new_pos:Vector2) -> void:
	$PlayerLine.set_point_position(0,last_point)
	$PlayerLine.set_point_position(1,new_pos)
	
	if new_pos.y < last_point.y:
		$PlayerLine.default_color = GREEN_LINE_COLOUR
	elif new_pos.y > last_point.y:
		$PlayerLine.default_color = RED_LINE_COLOUR
	else:
		$PlayerLine.default_color = YELLOW_LINE_COLOUR
