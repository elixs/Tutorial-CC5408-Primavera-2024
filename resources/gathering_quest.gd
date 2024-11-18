class_name GatheringQuest
extends Quest

@export var thing: String

func run(player: Player) -> void:
	if player.get(thing) > 2:
		Debug.log("I did it!")
