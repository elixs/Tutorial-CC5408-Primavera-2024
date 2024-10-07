extends Panel

var item_id: int
var quantity: int


func _on_gui_input(event: InputEvent) -> void:
	var emb = event as InputEventMouseButton
	if emb and emb.button_index == MOUSE_BUTTON_LEFT and emb.pressed:
		Debug.log("click")

func pickup() -> void:
	pass

func drop() -> void:
	pass
