class_name Player
extends CharacterBody2D


@export var speed = 200
@export var run_speed = 400
@export var jump_speed = 600
@export var gravity = 1500
@export var acceleration = 2000
@export var attacking = false
@export var ball_scene: PackedScene
@export var jump_stream: AudioStream

var running := false

@onready var sprite_2d: Sprite2D = $Pivot/Sprite2D
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var playback = animation_tree.get("parameters/movement/playback")
@onready var pivot: Node2D = $Pivot
@onready var hitbox: Hitbox = $Pivot/Hitbox
@onready var jump_sound: AudioStreamPlayer = $JumpSound
@onready var ball_spawn: Marker2D = $Pivot/BallSpawn
@onready var fire_cooldown: Timer = $FireCooldown
@onready var auto_fire_timer: Timer = $AutoFireTimer
@onready var blink_timer: Timer = $BlinkTimer


func _ready() -> void:
	#sprite_2d.modulate = Color.BLUE
	animation_tree.active = true
	hitbox.damage_dealt.connect(_on_damage_dealt)
	auto_fire_timer.timeout.connect(fire)
	blink_timer.timeout.connect(_on_blink_timeout)
	Game.swapped.connect(_on_swapped)
	_on_swapped(Game.is_swapped)


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
		
	_handle_running()

	var move_input = Input.get_axis("move_left", "move_right")
	if attacking:
		move_input = 0
	var target_speed = run_speed if running else speed
	velocity.x = move_toward(velocity.x, target_speed *  move_input, acceleration * delta)
	
	if not attacking and is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -jump_speed
		AudioManager.play_stream(jump_stream)
	move_and_slide()
	
	if attacking:
		return
	
	if is_on_floor() and Input.is_action_just_pressed("attack"):
		animation_tree["parameters/attack/request"] = AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE
	if Input.is_action_just_pressed("fire"):
		fire()
	
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
	
	animation_tree["parameters/movement/run/blend_position"] = abs(velocity.x)


func taunt():
	Debug.log("· o ·)/")


func take_damage(damage: int):
	Debug.log("oh no")


func fire() -> void:
	if fire_cooldown.time_left:
		return
	if not ball_scene:
		Debug.log("I forgot to add a ball scene")
		return
	var ball_inst = ball_scene.instantiate()
	get_parent().add_child(ball_inst)
	ball_inst.global_position = ball_spawn.global_position + Vector2(randf_range(-100, 100), randf_range(-100, 100))
	fire_cooldown.start()


func pickup(item: String):
	Debug.log("I got a %s" % item)
	InventoryManager.add_item(item)

func _on_damage_dealt() -> void:
	Debug.log("We made damage")


func _on_blink_timeout() -> void:
	animation_tree["parameters/movement/idle/playback"].travel("blink")


func _handle_running():
	if is_on_floor() and not running and Input.is_action_pressed("run"):
		running = true
	if Input.is_action_just_released("run"):
		running = false

func _on_swapped(value: bool) -> void:
	#if value:
		#modulate = Color.GREEN
	#else:
		#modulate = Color.BLUE
	modulate = Color.GREEN if value else Color.BLUE
