extends Node2D


@onready var rigid_body_2d_2: RigidBody2D = $RigidBody2D2
@onready var rigid_body_2d_4: RigidBody2D = $RigidBody2D4


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		#Input.warp_mouse(Vector2(100, 300))
		rigid_body_2d_2.apply_torque_impulse(5000)
		rigid_body_2d_4.apply_torque_impulse(-5000)
	
	if Input.is_action_pressed("fire"):
		rigid_body_2d_2.apply_torque_impulse(-5000)
		rigid_body_2d_4.apply_torque_impulse(5000)
		
	if Input.is_action_pressed("test"):
		rigid_body_2d_2.apply_central_impulse(rigid_body_2d_2.global_position.direction_to(get_global_mouse_position()) * 100)
		rigid_body_2d_4.apply_central_impulse(rigid_body_2d_4.global_position.direction_to(get_global_mouse_position()) * 100)
