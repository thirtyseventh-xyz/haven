extends Camera2D

signal end_text()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

var slow_pan = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.won_nvda == true or Global.lost_nvda == true:
		if zoom.x > 0.1:
			zoom.x -= 0.01
			zoom.y -= 0.01
		
		if slow_pan == false:
			if Global.won_nvda:
				if position.x > -3000:
					position.x -= 50
				if position.y > -1500:
					position.y -= 100
			else:
				if position.x > -6000:
					position.x -= 50
				if position.y > -3000:
					position.y -= 100
		if (position.y <= -1500 and position.x <= -3000) or slow_pan == true:
			slow_pan = true
			position.x += 5
		
		if Global.won_nvda == true:
			end_text.emit("You bounced NVIDIA back to its prime! (ew)")
		else:
			end_text.emit("You failure")

func _input(event: InputEvent) -> void:
	if Input.is_action_pressed("scroll down") and zoom.x - 0.04 >= 0.2:
		zoom.x -= 0.04
		zoom.y -= 0.04

	if Input.is_action_pressed("scroll up") and zoom.x + 0.04 <= 2:
		zoom.x += 0.04
		zoom.y += 0.04

func _on_death_box_lose_game_trigger() -> void:
	Global.lost_nvda = true
