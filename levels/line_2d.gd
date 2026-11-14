extends Line2D

var created_points:int = 0

func _ready() -> void:
	add_point(position)

func new_point(pos:Vector2) -> void:
	add_point(pos)
	created_points += 1

func track_last_point(new_pos:Vector2) -> void:
	set_point_position(created_points, new_pos)
	print("set point "+str(created_points)+"  to position "+str(new_pos))
