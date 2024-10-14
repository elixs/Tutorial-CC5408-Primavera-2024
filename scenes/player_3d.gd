extends CharacterBody3D


var speed = 5.0
var acceleration = 100
var gravity = 10
const jump_speed = 4.5

@onready var pivot: Node3D = $Pivot
@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D


func _input(event: InputEvent) -> void:
	var mm = event as InputEventMouseMotion
	if mm and abs(mm.relative.x) > 0.1:
		pivot.rotate_y(-mm.relative.x * 0.01)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_speed

	var move_input := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (pivot.basis * Vector3(move_input.x, 0, move_input.y)).normalized()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)

	if !velocity.is_zero_approx():
		mesh_instance_3d.transform = mesh_instance_3d.transform.looking_at(pivot.global_position - pivot.transform.basis.x * 50)
	move_and_slide()
