extends CharacterBody2D

@onready var character_component: CharacterComponent = $CharacterComponent
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	character_component.health_changed.connect(func(value): progress_bar.value = value)
	progress_bar.value = character_component.health
	progress_bar.max_value = character_component.max_health
	
	timer.timeout.connect(attack)


func attack() -> void:
	animation_player.play("attack")
