class_name CameraWithShake
extends Camera2D


func shake(duration: float = 0.2, strength: float = 30, steps: int = 10) -> void:
	var initial_offset = offset
	var tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	var step_duration = duration / steps
	for i in steps:
		tween.tween_property(self, "offset", initial_offset + _get_rand_vector() * strength , step_duration)
	tween.tween_property(self, "offset", initial_offset, step_duration)


func _get_rand_vector() -> Vector2:
	return Vector2(randf(), randf())
