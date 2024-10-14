extends MarginContainer

var slot_clicked
@onready var grid_container: GridContainer = %GridContainer
@onready var ui_dnd: Control = %UIDnD


func _ready() -> void:
	ui_dnd.hide()
	for slot in InventoryManager.items:
		var data = InventoryManager.items[slot]
		var ui_slot = grid_container.get_child(int(slot))
		ui_slot.add_item(data.item, data.quantity)
	for ui_slot in grid_container.get_children():
		ui_slot.click_pressed.connect(_on_slot_clicked.bind(ui_slot, true))
		ui_slot.click_released.connect(_on_slot_clicked.bind(ui_slot, false))
	
	
func _on_slot_clicked(ui_slot: UISlot, pressed: bool) -> void:
	Debug.log("slot clicked")
	#if pressed:
	if slot_clicked:	
		if slot_clicked == ui_slot:
			slot_clicked.drop()
			slot_clicked = null
			ui_dnd.hide()
			return
		if ui_slot.item:
			if slot_clicked.item == ui_slot.item:
				var item_data = InventoryManager.get_data(slot_clicked.item)
				var total = slot_clicked.quantity + ui_slot.quantity
				if total <= item_data.stack_size:
					ui_slot.quantity = total
					slot_clicked.clear()
					slot_clicked = null
					ui_dnd.hide()
				else:
					ui_slot.quantity = item_data.stack_size
					slot_clicked.quantity = total - item_data.stack_size
					slot_clicked = null
					ui_dnd.hide()
			else:
				var grabbed_item = slot_clicked.item
				var grabbed_quantity = slot_clicked.quantity
				slot_clicked.add_item(ui_slot.item, ui_slot.quantity)
				ui_slot.add_item(grabbed_item, grabbed_quantity)
				slot_clicked = null
				ui_dnd.hide()
		else:
			ui_slot.add_item(slot_clicked.item, slot_clicked.quantity)
			slot_clicked.clear()
			slot_clicked = null
			ui_dnd.hide()
	else:
		if ui_slot.item:
			ui_slot.pickup()
			var data = InventoryManager.get_data(ui_slot.item)
			ui_dnd.set_item(ui_slot.item, ui_slot.quantity)
			ui_dnd.show()
			slot_clicked = ui_slot
		else:
			# Nothing happens
			pass
			


func _process(delta: float) -> void:
	if ui_dnd.visible:
		ui_dnd.global_position = get_global_mouse_position()


func _on_gui_input(event: InputEvent) -> void:
	var emb = event as InputEventMouseButton
	if emb and emb.button_index == MOUSE_BUTTON_LEFT and emb.pressed:
		if slot_clicked:
			slot_clicked.drop()
			slot_clicked = null
			ui_dnd.hide()
			
