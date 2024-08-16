class_name Player
extends CharacterBody2D



@export var speed = 400
@export var jump_speed = 1000
@export var gravity = 1500
@export var acceleration = 2000
@export var attacking = false

@onready var sprite_2d: Sprite2D = $Pivot/Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/playback")
@onready var pivot: Node2D = $Pivot
@onready var attack_area: Area2D = $Pivot/AttackArea
@onready var hitbox: Hitbox = $Pivot/Hitbox

func _ready() -> void:
	#sprite_2d.modulate = Color.BLUE
	animation_tree.active = true
	hitbox.damage_dealt.connect(_on_damage_dealt)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta

	var move_input = Input.get_axis("move_left", "move_right")
	if attacking:
		move_input = 0
	velocity.x = move_toward(velocity.x, speed *  move_input, acceleration * delta)
	
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
	move_and_slide()
	
	if  is_on_floor() and Input.is_action_just_pressed("attack"):
		playback.travel("attack")
		return
	
	if move_input != 0:
		pivot.scale.x = sign(move_input)
	
	if is_on_floor():
		if abs(velocity.x) > 10 or move_input:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")


func taunt():
	Debug.log("· o ·)/")



func take_damage(damage: int):
	Debug.log("oh no")


func _on_damage_dealt() -> void:
	Debug.log("We made damage")
