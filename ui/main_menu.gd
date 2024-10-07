extends Control

@export var main: PackedScene

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit
@onready var continue_button: BeepButton = %Continue
@onready var label: Label = $Label

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
	
	


func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(main)


func _on_credits_pressed() -> void:
	LevelManager.go_to_credits()

func _on_continue_pressed() -> void:
	Game.load_game()
	_on_start_pressed()
