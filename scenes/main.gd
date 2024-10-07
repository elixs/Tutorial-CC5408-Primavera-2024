extends Node2D


@export var clouds: Texture
@export var godot: Texture
@onready var parallax_2d_2: Parallax2D = $Parallax2D2
@onready var parallax_2d: Parallax2D = $Parallax2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var spawn_point: Marker2D = $SpawnPoint
@onready var player: Player = $Player


func _ready() -> void:
	Game.swapped.connect(_on_swapped)
	_on_swapped(Game.is_swapped)
	if Game.valid_checkpoint:
		player.global_position = Game.last_checkpoint
	else:
		Game.last_checkpoint = spawn_point.global_position
		

#func _exit_tree() -> void:
	#Game.valid_checkpoint = false

func _process(delta: float) -> void:
	parallax_2d_2.scroll_offset.x += delta


func _on_swapped(value: bool) -> void:
	parallax_2d.modulate = Color.GREEN if value else Color.BLUE
	for child in parallax_2d_2.get_children():
		child.texture = godot if value else clouds
	_update_tilemap()


func _update_tilemap() -> void:
	var grass = tile_map_layer.get_used_cells_by_id(0, Vector2i(1, 0))
	var stone = tile_map_layer.get_used_cells_by_id(0, Vector2i(4, 2))
	for tile in grass:
		tile_map_layer.set_cell(tile, 0, Vector2i(4, 2))
	for tile in stone:
		tile_map_layer.set_cell(tile, 0, Vector2i(1, 0))
