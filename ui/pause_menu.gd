extends CanvasLayer

@onready var resume: Button = %Resume
@onready var retry: Button = %Retry
@onready var menu: Button = %Menu
@onready var quit: Button = %Quit
@onready var save_button: BeepButton = %Save
@onready var load_button: BeepButton = %Load
@onready var settings_button: BeepButton = %SettingsButton
@onready var pause: VBoxContainer = %Pause
@onready var settings: VBoxContainer = %Settings


func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	menu.pressed.connect(_on_menu_pressed)
	quit.pressed.connect(get_tree().quit)
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	settings_button.pressed.connect(_on_settings_pressed)
	settings.back_pressed.connect(_on_settings_back_pressed)
	pause.show()
	settings.hide()
	hide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
		if not visible:
			pause.show()
			settings.hide()
		visible = not visible
		get_tree().paused = visible


func _on_resume_pressed() -> void:
	hide()
	get_tree().paused = false


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_menu_pressed() -> void:
	get_tree().paused = false
	LevelManager.go_to_menu()


func _on_save_pressed() -> void:
	InventoryManager.save_game()
	Game.save_game()


func _on_load_pressed() -> void:
	InventoryManager.load_game()
	

func _on_settings_pressed() -> void:
	pause.hide()
	settings.show()

func _on_settings_back_pressed() -> void:
	pause.show()
	settings.hide()
