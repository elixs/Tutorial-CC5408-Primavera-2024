class_name KillZone
extends Area2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		action(player)


func action(player: Player) -> void:
	player.die()
