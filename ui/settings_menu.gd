extends VBoxContainer

signal back_pressed

@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var fullscreen_check_box: CheckBox = %FullscreenCheckBox
@onready var back: BeepButton = %Back


func _ready() -> void:
	music_slider.value_changed.connect(_on_music_volume_changed)
	sfx_slider.drag_ended.connect(_on_sfx_volume_changed)
	fullscreen_check_box.toggled.connect(_on_fullscreen_toggled)
	back.pressed.connect(func(): back_pressed.emit())
	
	load_config()


func _on_music_volume_changed(value: float) -> void:
	var music_bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(music_bus, linear_to_db(value))
	save_config()


func _on_sfx_volume_changed(value_changed: bool) -> void:
	var sfx_bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_volume_db(sfx_bus, linear_to_db(sfx_slider.value))
	AudioManager.play_beep()
	save_config()


func _on_fullscreen_toggled(toggled_on: bool) -> void:
	get_window().mode = Window.MODE_FULLSCREEN if toggled_on else Window.MODE_WINDOWED
	save_config()


func save_config() -> void:
	var config = ConfigFile.new()

	config.set_value("Audio", "Music", music_slider.value)
	config.set_value("Audio", "SFX", sfx_slider.value)
	config.set_value("Video", "Fullscreen", fullscreen_check_box.button_pressed)

	config.save("user://settings.cfg")


func load_config() -> void:
	var config = ConfigFile.new()
	
	var err = config.load("user://settings.cfg")
	if err != OK:
		return
	
	var music = config.get_value("Audio", "Music")
	var sfx = config.get_value("Audio", "SFX")
	var fullscreen = config.get_value("Video", "Fullscreen")
	
	music_slider.value = music
	sfx_slider.value = sfx
	fullscreen_check_box.button_pressed = fullscreen
