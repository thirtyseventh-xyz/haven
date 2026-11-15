extends Area2D
signal lose_game_trigger()

func object_entered(body:Node2D) -> void:
	if body is Player:
		Global.frozen = true
		lose_game_trigger.emit()
