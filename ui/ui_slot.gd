class_name UISlot
extends Panel

signal click_pressed
signal click_released

@export var empty_color: Color
@export var full_color: Color

var item: String
var quantity: int:
	set(value):
		quantity = value
		if label:
			label.text = str(quantity)
			label.visible = quantity > 1 
var grabbed := false

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var label: Label = $Label


func _ready() -> void:
	texture_rect.hide()
	label.hide()
	gui_input.connect(_on_gui_input)
	# set color to empty
	#add_theme_color_override("bg_color", full_color)

func _on_gui_input(event: InputEvent) -> void:
	#Debug.log(event)
	var emb = event as InputEventMouseButton
	if emb and emb.button_index == MOUSE_BUTTON_LEFT:
		if emb.pressed:
			click_pressed.emit()
		#else:
			#click_released.emit()


func add_item(item: String, quantity: int) -> void:
	var data = InventoryManager.get_data(item)
	texture_rect.texture = data.icon
	label.text = str(quantity)
	texture_rect.show()
	self.item = item
	self.quantity = quantity
	if quantity > 1:
		label.show()
	# set color to full

func pickup() -> void:
	texture_rect.hide()
	label.hide()
	grabbed = true

func drop() -> void:
	texture_rect.show()
	if quantity > 1:
		label.show()
	grabbed = false

func clear() -> void:
	item = ""
	quantity = 0
