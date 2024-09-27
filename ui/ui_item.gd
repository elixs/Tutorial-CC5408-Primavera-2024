extends HBoxContainer

@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect
@onready var quantity: Label = $Quantity


func setup(item: String) -> void:
	var item_data = InventoryManager.get_data(item)
	label.text = item_data.display_name
	texture_rect.texture = item_data.icon
	var item_info = InventoryManager.get_item(item)
	quantity.text = "x%d" % item_info.quantity
	if item_info.quantity <= 1:
		quantity.hide()
