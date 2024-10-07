extends Checkpoint


func action() -> void:
	super.action()
	queue_free()
