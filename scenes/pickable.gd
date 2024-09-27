extends Area2D

@export var id = "item"
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	#if randi() % 2 == 0:
		#collision_shape_2d.shape.radius = 300


func _on_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		AudioManager.play_beep()
		player.pickup(id)
		queue_free()
