extends Node

signal inventory_changed()
signal slot_changed(slot_index: int)

var slots: Array[Slot] = [
	Slot.new(0, "sword", 1),
	Slot.new(9, "bread", 5),
	Slot.new(12, "bread", 12),
]
var max_size := 15

# { id: Item }
var data := {}
var data_path := "res://items"



func _ready() -> void:
	load_data()


func get_data(item: String) -> Item:
	if item in data:
		return data[item]
	return null


func get_slot(slot_index: int) -> Slot:
	for slot in slots:
		if slot.index == slot_index:
			return slot
	return null


func add_item(item: String, quantity: int) -> bool:
	for slot in slots:
		if slot.item == item:
			# there is a slot with the same item
			var item_data = get_data(item)
			if slot.quantity == item_data.stack_size:
				continue
			var total = slot.quantity + quantity
			if total <= item_data.stack_size:
				slot.quantity = total
				slot_changed.emit(slot.index)
				return true
			else:
				slot.quantity = item_data.stack_size
				slot_changed.emit(slot.index)
				return add_item(item, total - item_data.stack_size)
	# no slot with the same item
	var index = _get_available_slot_index()
	if index >= 0:
		# there is a slot available
		slots.push_back(Slot.new(index, item, quantity))
		slot_changed.emit(index)
		return true
	else:
		# nothing happens
		return false


func remove_item(slot_index: int) -> void:
	for slot in slots:
		if slot.index == slot_index:
			slots.erase(slot)
			return


func move_item(from_slot_index: int, to_slot_index: int) -> void:
	if from_slot_index == to_slot_index:
		return
	var from_slot = get_slot(from_slot_index)
	var to_slot = get_slot(to_slot_index)
	if not from_slot:
		# nothing to move
		return
	if not to_slot:
		# move to empty slot
		from_slot.index = to_slot_index
	else:
		if from_slot.item == to_slot.item:
			# same item on both slots
			var item_data = get_data(from_slot.item)
			var total = from_slot.quantity + to_slot.quantity
			if total <= item_data.stack_size:
				to_slot.quantity = total
				remove_item(from_slot_index)
			else:
				to_slot.quantity = item_data.stack_size
				from_slot.quantity = total - item_data.stack_size
		else:
			# swap items
			from_slot.index = to_slot_index
			to_slot.index = from_slot_index
			slot_changed.emit(from_slot_index)
			slot_changed.emit(to_slot_index)
	
	slot_changed.emit(from_slot_index)
	slot_changed.emit(to_slot_index)


func load_data():
	var dir = DirAccess.open(data_path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				var id = file_name.split(".")[0]
				Debug.log("Item added: " + id)
				data[id] = load("%s/%s" % [data_path, file_name] )
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func save_game() -> void:
	var slot_data: Array[Dictionary] = []
	for slot in slots:
		slot_data.push_back(slot.to_dict())
	var data = JSON.stringify(slot_data)
	var file = FileAccess.open_encrypted_with_pass("user://inventory.data", FileAccess.WRITE, "1234")
	file.store_string(data)
	file.close()
	#
	## Create new ConfigFile object.
	#var config = ConfigFile.new()
#
	#config.set_value("Display", "font_size", 24)
	#config.set_value("Display", "brightness", 0.7)
	#config.set_value("Settings", "language", "es")
#
	#config.save("user://scores.cfg")


func load_game() -> void:
	var file = FileAccess.open_encrypted_with_pass("user://inventory.data", FileAccess.READ, "1234")
	slots = []
	var slot_data = JSON.parse_string(file.get_as_text())
	for data in slot_data:
		slots.push_back(Slot.from_dict(data))
	inventory_changed.emit()
	for i in max_size:
		slot_changed.emit(i)


func _get_available_slot_index() -> int:
	for i in max_size:
		var slot = get_slot(i)
		if not slot:
			return i
	return -1
