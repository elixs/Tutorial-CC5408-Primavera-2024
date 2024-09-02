extends Node2D

@onready var parallax_2d_2: Parallax2D = $Parallax2D2



func _process(delta: float) -> void:
	parallax_2d_2.scroll_offset.x += delta
