extends CanvasLayer

@onready var resume: Button = %Resume
@onready var retry: Button = %Retry
@onready var menu: Button = %Menu
@onready var quit: Button = %Quit
@onready var save_button: BeepButton = %Save
@onready var load_button: BeepButton = %Load


func _ready() -> void:
	resume.pressed.connect(_on_resume_pressed)
	retry.pressed.connect(_on_retry_pressed)
	menu.pressed.connect(_on_menu_pressed)
	quit.pressed.connect(get_tree().quit)
	save_button.pressed.connect(_on_save_pressed)
	load_button.pressed.connect(_on_load_pressed)
	hide()
	


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("menu"):
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


func _on_load_pressed() -> void:
	InventoryManager.load_game()
	
