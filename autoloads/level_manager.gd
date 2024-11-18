extends Node


@export var main_menu_scene: PackedScene
@export var credits_scene: PackedScene
@export var levels: Array[LevelInfo]
var levels_data = [
	{
		"level": "level1",
		"locked": false
	},
	{
		"level": "level2",
		"locked": true
	}
]


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



func save_game() -> void:
	var data = JSON.stringify(
		[
			{
				"level": "level1",
				"locked": false
			},
			{
				"level": "level2",
				"locked": true
			}
		]
	)
	var file = FileAccess.open_encrypted_with_pass("user://level.data", FileAccess.WRITE, "1234")
	file.store_string(data)
	file.close()


func load_game() -> void:
	var file = FileAccess.open_encrypted_with_pass("user://level.data", FileAccess.READ, "1234")
	var dict = JSON.parse_string(file.get_as_text())
	levels_data = dict
