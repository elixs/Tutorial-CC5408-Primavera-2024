extends Node


@export var main_menu_scene: PackedScene
@export var credits_scene: PackedScene


func go_to_menu() -> void:
	if not main_menu_scene:
		Debug.log("oh no")
		return
	get_tree().change_scene_to_packed(main_menu_scene)


func go_to_credits() -> void:
	if not credits_scene:
		Debug.log("oh no, credits!")
		return
	get_tree().change_scene_to_packed(credits_scene)
