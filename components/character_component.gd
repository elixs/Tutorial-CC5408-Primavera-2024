class_name CharacterComponent
extends HealthComponent

@export var attack: float = 2
@export var deffense: float = 2


func take_damage(damage: float) -> void:
	health -= damage / deffense


static func find(node: Node) -> CharacterComponent:
	if not is_instance_valid(node):
		return null
	for child in node.get_children():
		if child is CharacterComponent:
			return child
	return null
