class_name Hurtbox
extends Area2D

@export var immunity_time: float = 1
var hitboxs_inside: Array[Hitbox] = []
var _immune := false
var _immnity_delta = 0


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)


func _process(delta: float) -> void:
	if _immune:
		_immnity_delta += delta
		if _immnity_delta >= immunity_time:
			_immune = false
			_immnity_delta = 0
		else:
			return
	for hitbox in hitboxs_inside:
		if not is_instance_valid(hitbox):
			return
		var damage_multiplier = 1
		var character_component = CharacterComponent.find(hitbox.owner)
		if character_component:
			damage_multiplier = character_component.attack
		var damage = hitbox.damage * damage_multiplier
		if owner.has_method("take_damage"):
			owner.take_damage(damage)
			hitbox.damage_dealt.emit()
		var health_component = HealthComponent.find(owner)
		if health_component:
			health_component.take_damage(damage)
		_immune = true


func _on_area_entered(area: Area2D) -> void:
	var hitbox = area as Hitbox
	if hitbox:
		hitboxs_inside.push_back(hitbox)


func _on_area_exited(area: Area2D) -> void:
	if area in hitboxs_inside:
		hitboxs_inside.erase(area)
