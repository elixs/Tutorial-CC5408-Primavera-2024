class_name RestartZone
extends KillZone

func _ready() -> void:
	super._ready()

func action(player: Player) -> void:
	get_tree().reload_current_scene()
