extends Node

signal swapped(value: bool)

var valid_checkpoint := false
var last_checkpoint: Vector2


func _ready() -> void:
	load_config()


var is_swapped := false :
	set(value):
		is_swapped = value
		swapped.emit(value)
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("swap"):
		is_swapped = !is_swapped
		

func get_data() -> Dictionary:
	return {
		"valid_checkpoint": valid_checkpoint,
		"last_checkpoint_x": last_checkpoint.x,
		"last_checkpoint_y": last_checkpoint.y
	}


func load_data(dict: Dictionary) -> void:
	valid_checkpoint = dict["valid_checkpoint"]
	last_checkpoint.x = dict["last_checkpoint_x"]
	last_checkpoint.y = dict["last_checkpoint_y"]


func save_game() -> void:
	var data = JSON.stringify(get_data())
	var file = FileAccess.open_encrypted_with_pass("user://game.data", FileAccess.WRITE, "1234")
	file.store_string(data)
	file.close()


func load_game() -> void:
	var file = FileAccess.open_encrypted_with_pass("user://game.data", FileAccess.READ, "1234")
	var dict = JSON.parse_string(file.get_as_text())
	load_data(dict)



func load_config() -> void:
	var config = ConfigFile.new()
	
	var err = config.load("user://settings.cfg")
	if err != OK:
		return
	
	var music = config.get_value("Audio", "Music")
	var sfx = config.get_value("Audio", "SFX")
	var fullscreen = config.get_value("Video", "Fullscreen")
	
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(music))
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(sfx))
	get_window().mode = Window.MODE_FULLSCREEN if fullscreen else Window.MODE_WINDOWED
