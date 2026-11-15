extends Node2D

var last_point:Vector2 = Vector2(0,0)
var line:Line2D

func _ready() -> void:
	new_point(Vector2(0,0))

func new_point(pos:Vector2) -> void:
	line = Line2D.new()
	add_child(line)
	
	line.add_point(last_point)
	line.add_point(pos)
	
	line.default_color = Color(1,0,0)
	
	last_point = pos
	

#func track_last_point(new_pos:Vector2) -> void:
	#line.set_point_position(created_points, new_pos)
