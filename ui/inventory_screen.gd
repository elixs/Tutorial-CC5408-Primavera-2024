extends MarginContainer

var dnd_slot: UISlot
@onready var grid_container: GridContainer = %GridContainer
@onready var ui_dnd: UIDnD = %UIDnD


func _ready() -> void:
	ui_dnd.hide()
	for ui_slot in grid_container.get_children():
		ui_slot.clicked.connect(_on_slot_clicked.bind(ui_slot))


func _process(delta: float) -> void:
	if ui_dnd.visible:
		ui_dnd.global_position = get_global_mouse_position()


func _on_slot_clicked(clicked_slot: UISlot) -> void:
	if not dnd_slot:
		var slot_data = InventoryManager.get_slot(clicked_slot.get_index())
		if slot_data:
			clicked_slot.hide_content()
			dnd_slot = clicked_slot
			ui_dnd.slot_index = dnd_slot.get_index()
			ui_dnd.show()
	else:
		InventoryManager.move_item(dnd_slot.get_index(), clicked_slot.get_index())
		var dnd_slot_data = InventoryManager.get_slot(dnd_slot.get_index())
		var clicked_slot_data = InventoryManager.get_slot(clicked_slot.get_index())
		if dnd_slot != clicked_slot and  dnd_slot_data and clicked_slot_data and \
			dnd_slot_data.item == clicked_slot_data.item:
			# if items are the same but different slots
			ui_dnd.update()
			dnd_slot.hide_content()
		else:
			dnd_slot.show_content()
			dnd_slot = null
			ui_dnd.hide()


func _on_gui_input(event: InputEvent) -> void:
	var emb = event as InputEventMouseButton
	if emb and emb.button_index == MOUSE_BUTTON_LEFT and emb.pressed:
		if dnd_slot:
			dnd_slot.show_content()
			dnd_slot = null
			ui_dnd.hide()
