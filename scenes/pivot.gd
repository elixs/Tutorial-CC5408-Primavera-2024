extends Node2D

signal something_happend(health, defense)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("test"):
		something_happend.emit(1, 2)
