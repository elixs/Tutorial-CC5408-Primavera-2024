class_name UIDnD
extends Control


var slot_index: int:
	set(value):
		slot_index = value
		update()

@onready var texture_rect: TextureRect = %TextureRect
@onready var label: Label = %Label


func update() -> void:
	var slot_data = InventoryManager.get_slot(slot_index)
	if not slot_data:
		return
	var item_data = InventoryManager.get_data(slot_data.item)
	texture_rect.texture = item_data.icon
	texture_rect.show()
	label.text = str(slot_data.quantity)
	label.visible = slot_data.quantity > 1
