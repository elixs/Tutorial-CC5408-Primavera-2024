extends Control

@export var main: PackedScene

@onready var start: Button = %Start
@onready var credits: Button = %Credits
@onready var quit: Button = %Quit

#var main = preload("res://scenes/main.tscn")

func _ready() -> void:
	start.pressed.connect(_on_start_pressed)
	credits.pressed.connect(_on_credits_pressed)
	#quit.pressed.connect(func(): get_tree().quit())
	quit.pressed.connect(get_tree().quit)
	#var main_path = "res://scenes/main.tscn"
	#main = load(main_path)


func _on_start_pressed() -> void:
	#get_tree().change_scene_to_file("res://scenes/main.tscn")
	get_tree().change_scene_to_packed(main)


func _on_credits_pressed() -> void:
	Debug.log("TODO")
