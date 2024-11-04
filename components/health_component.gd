class_name HealthComponent
extends Node

signal died
signal health_changed(value)

@export var health: float = 100:
	set(value):
		health = clamp(value, 0, max_health)
		health_changed.emit(health)
		if health == 0:
			died.emit()

@export var max_health: float = 100

func take_damage(damage: float) -> void:
	health -= damage


static func find(node: Node) -> HealthComponent:
	if not is_instance_valid(node):
		return null
	for child in node.get_children():
		if child is HealthComponent:
			return child
	return null
