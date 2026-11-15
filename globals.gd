extends Node

var intro_keyframes_nvda = []
var pxpos = 0
var pypos = 0
var lost_nvda = false
var platforms_recursion:int = 0
var frozen = true
var won_nvda = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func win():
	frozen = true
	won_nvda = true

func _process(delta: float) -> void:
	if Global.pypos <= -250*15 and frozen == false:
		win()
