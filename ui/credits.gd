extends Control

@onready var button: Button = $Button
@onready var rich_text_label: RichTextLabel = $RichTextLabel

func _ready() -> void:
	await get_tree().create_timer(3).timeout
	LevelManager.go_to_menu()


func _process(delta: float) -> void:
	rich_text_label.get_v_scroll_bar().value += delta * 500
