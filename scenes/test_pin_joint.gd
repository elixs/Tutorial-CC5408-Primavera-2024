extends Node2D
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D
@onready var character_body_2d: CharacterBody2D = $CharacterBody2D
@onready var timer: Timer = $Timer


func _ready() -> void:
	rigid_body_2d.add_collision_exception_with(character_body_2d)
	timer.timeout.connect(_on_timeout)
	timer.start(1)

func _on_timeout() -> void:
	timer.start(randf_range(1, 3))
	rigid_body_2d.apply_central_impulse(_get_rand_vector_2() * randf_range(2000, 5000))


func _get_rand_vector_2() -> Vector2:
	return Vector2(randf(), randf())
