extends CharacterBody2D


@export var speed = 100
@export var gravity = 1500
@export var acceleration = 2000
@onready var pivot: Node2D = $Pivot
@onready var ray_cast_2d: RayCast2D = $Pivot/RayCast2D


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	var direction = pivot.scale.x
	velocity.x = move_toward(velocity.x, direction * speed, acceleration *  delta)
	move_and_slide()
	
	if is_on_floor() and not ray_cast_2d.is_colliding():
		pivot.scale.x *= -1
	
