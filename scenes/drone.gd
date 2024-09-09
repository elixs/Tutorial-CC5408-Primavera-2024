extends CharacterBody2D

@export var speed = 100
@export var acceleration = 2000
var target: Player
@onready var detection_area: Area2D = $DetectionArea

func _ready() -> void:
	detection_area.body_entered.connect(_on_detection_body_entered)
	detection_area.body_exited.connect(_on_detection_body_exited)


func _physics_process(delta: float) -> void:
	if not target:
		return
	var direction = global_position.direction_to(target.global_position)
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	move_and_slide()

func _on_detection_body_entered(body: Node) -> void:
	var player = body as Player
	if player:
		target = player


func _on_detection_body_exited(body: Node) -> void:
	if body == target:
		target = null
