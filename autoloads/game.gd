extends Node

signal swapped(value: bool)

var is_swapped := false :
	set(value):
		is_swapped = value
		swapped.emit(value)
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap"):
		is_swapped = !is_swapped
		
