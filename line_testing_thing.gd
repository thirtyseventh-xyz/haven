extends Node2D
@onready var line_2d: Line2D = $Line2D
var nvda_peak = 250
var num_intervals = 20
var y_val = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in range(num_intervals):
		if i == num_intervals-1:
			y_val = -nvda_peak
		else:
			y_val = randi_range(y_val+(250/num_intervals)-10, y_val+(-250/num_intervals)-10)
		line_2d.add_point(Vector2((i*10),y_val))
	print(line_2d.points)
	num_intervals /= 2
	for i in range(num_intervals):
		if i == num_intervals-1:
			y_val = -50
		else:
			y_val = randi_range(y_val+(250/num_intervals)+10, y_val+(-250/num_intervals)+10)
		line_2d.add_point(Vector2(((2*num_intervals+i)*10),y_val))
	print(line_2d.points)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
