extends Control

var item: String
var quantity: int

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	label.hide()

func set_item(item: String, quantity: int) ->  void:
	var data = InventoryManager.get_data(item)
	texture_rect.texture = data.icon
	label.text = str(quantity)
	texture_rect.show()
	self.item = item
	self.quantity = quantity
	if quantity > 1:
		label.show()
