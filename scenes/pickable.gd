@tool
extends Area2D


@export var item: Item:
	set(value):
		item = value
		_update()
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var sprite_2d: Sprite2D = $Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	_update()
	#if randi() % 2 == 0:
		#collision_shape_2d.shape.radius = 300


func _update() -> void:
	if sprite_2d and item:
		sprite_2d.texture = item.icon

func _on_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		if player.pickup(item.name):
			AudioManager.play_beep()
			queue_free()
