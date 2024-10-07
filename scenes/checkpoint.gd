class_name Checkpoint
extends Area2D

@export var respawn_point: Node2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	if not respawn_point:
		return
	var player = body as Player
	if player:
		action()



func action() -> void:
	Game.last_checkpoint = respawn_point.global_position
	Game.valid_checkpoint = true
