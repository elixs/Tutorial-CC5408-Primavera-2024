extends CanvasLayer

@onready var item_container: VBoxContainer = %ItemContainer

@export var ui_item_scene: PackedScene

func _ready() -> void:
	InventoryManager.inventory_changed.connect(_on_inventory_changed)
	_fill_inventory()


func _on_inventory_changed() -> void:
	_clear_inventory()
	_fill_inventory()


func _clear_inventory() -> void:
	for child in item_container.get_children():
		item_container.remove_child(child)
		child.queue_free()
	
func _add_item(item: String) -> void:
	if not ui_item_scene:
		return
	var ui_item_inst = ui_item_scene.instantiate()
	item_container.add_child(ui_item_inst)
	ui_item_inst.setup(item)

func _fill_inventory() -> void:
	for item in InventoryManager.items:
		_add_item(item)
