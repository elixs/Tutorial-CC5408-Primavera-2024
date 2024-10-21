class_name UISlot
extends Panel

signal clicked

@export var empty_color: Color
@export var full_color: Color

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label


func _ready() -> void:
	gui_input.connect(_on_gui_input)
	InventoryManager.slot_changed.connect(_on_slot_changed)
	texture_rect.hide()
	label.hide()
	_update()
	# set color to empty
	#add_theme_color_override("bg_color", full_color)


func hide_content() -> void:
	texture_rect.hide()
	label.hide()


func show_content() -> void:
	_update()


func _on_gui_input(event: InputEvent) -> void:
	var emb = event as InputEventMouseButton
	if emb and emb.button_index == MOUSE_BUTTON_LEFT and emb.pressed:
		clicked.emit()


func _on_slot_changed(slot_index: int) -> void:
	if slot_index == get_index():
		_update()


func _update() -> void:
	var slot_data = InventoryManager.get_slot(get_index())
	if not slot_data:
		hide_content()
		return
	var item_data = InventoryManager.get_data(slot_data.item)
	texture_rect.texture = item_data.icon
	texture_rect.show()
	label.text = str(slot_data.quantity)
	label.visible = slot_data.quantity > 1
