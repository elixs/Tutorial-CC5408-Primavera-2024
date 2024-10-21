class_name Slot

var index: int
var item: String
var quantity: int


func _init(initial_index: int, initial_item: String, initial_quantity: int) -> void:
	index = initial_index
	item = initial_item
	quantity = initial_quantity


func to_dict() -> Dictionary:
	return {
		"index": index,
		"item": item,
		"quantity": quantity,
	}


static func from_dict(dict: Dictionary) -> Slot:
	return Slot.new(dict.index, dict.item, dict.quantity)


func _to_string() -> String:
	return "[index: %d, item: %s, quantity: %d]" % [index, item, quantity]
