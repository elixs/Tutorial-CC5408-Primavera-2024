extends Node

signal inventory_changed()

# {item: {quantity: 0}}
var items = {
	"sword":
	{
		"quantity": 1
	},
	"bread":
	{
		"quantity": 5
	},
}

# { id: Item }
var data := {}

var data_path = "res://items"

func _ready() -> void:
	load_data()


func get_data(item: String) -> Item:
	if item in data:
		return data[item]
	return null

func get_item(item: String) -> Dictionary:
	if item in items:
		return items[item]
	return {}

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

func add_item(item: String) -> void:
	if item in items:
		items[item].quantity += 1
	else:
		items[item] = {"quantity": 1}
	inventory_changed.emit()


func save_game() -> void:
	var data = JSON.stringify(items)
	var file = FileAccess.open_encrypted_with_pass("user://inventory.data", FileAccess.WRITE, "1234")
	file.store_string(data)
	file.close()
	
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	config.set_value("Display", "font_size", 24)
	config.set_value("Display", "brightness", 0.7)
	config.set_value("Settings", "language", "es")

	config.save("user://scores.cfg")


func load_game() -> void:
	var file = FileAccess.open_encrypted_with_pass("user://inventory.data", FileAccess.READ, "1234")
	var data = JSON.parse_string(file.get_as_text())
	items = data
	inventory_changed.emit()
	
