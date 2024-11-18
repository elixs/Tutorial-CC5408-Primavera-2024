extends Control

@export var ui_level_scene: PackedScene
@onready var ui_level_container: GridContainer = $VBoxContainer/UILevelContainer


func _ready() -> void:
	if not ui_level_scene:
		return
	for level_info in LevelManager.levels:
		var ui_level_inst = ui_level_scene.instantiate()
		ui_level_container.add_child(ui_level_inst)
		var locked = true
		for level_data in LevelManager.levels_data:
			if level_data.level == level_info.id:
				locked = level_data.locked
		ui_level_inst.setup(level_info, locked)
