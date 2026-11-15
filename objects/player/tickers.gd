extends Control
@onready var ticker: RichTextLabel = $Ticker
@onready var percent: RichTextLabel = $Percent
@onready var goal: RichTextLabel = $Goal
@onready var end_text: RichTextLabel = $"end text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ticker.text = "Nvidia-" + str(roundi(-Global.pypos/15))
	percent.text = "-" + str(roundi((Global.pypos/15)+250)) + " (-" + str(100-roundi((-Global.pypos/15)/250*100)) + "%)"
	goal.text = "Peak-250"



func _on_camera_2d_end_text(end_text_but_actually) -> void:
	end_text.text = end_text_but_actually
