extends Control

@export var main: PackedScene

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit
@onready var continue_button: BeepButton = %Continue
@onready var label: Label = %Label
@onready var title_label: Label = %TitleLabel
@onready var levels: BeepButton = %Levels


@onready var menu: VBoxContainer = %Menu
@onready var settings: VBoxContainer = %Settings
@onready var settings_button: BeepButton = %SettingsButton

#var main = preload("res://scenes/main.tscn")

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credits_pressed)
	#quit.pressed.connect(func(): get_tree().quit())
	quit.pressed.connect(get_tree().quit)
	#var main_path = "res://scenes/main.tscn"
	#main = load(main_path)
	continue_button.pressed.connect(_on_continue_pressed)
	var tween = create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(label, "scale:x", 4, 3)
	tween.tween_property(label, "scale:x", 1, 2)
	tween.parallel().tween_property(label, "scale:y", 3, 2)
	tween.tween_property(label, "scale:y", 1, 1)
	tween.set_loops()
	menu.show()
	settings.hide()
	settings_button.pressed.connect(_on_settings_pressed)
	settings.back_pressed.connect(_on_settings_back_pressed)
	update_language()
	levels.pressed.connect(func(): get_tree().change_scene_to_file("res://ui/levels_menu.tscn"))


func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(main)


func _on_credits_pressed() -> void:
	LevelManager.go_to_credits()


func _on_continue_pressed() -> void:
	Game.load_game()
	_on_start_pressed()


func _on_settings_pressed() -> void:
	menu.hide()
	settings.show()
	label.hide()


func _on_settings_back_pressed() -> void:
	menu.show()
	settings.hide()
	label.show()


func update_language() -> void:
	label.text = tr("MAIN_LABEL")
	title_label.text = tr("MAIN_TITLE")
