extends Node

@export var beep: AudioStream


func play_beep() -> void:
	var audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = beep
	audio_stream_player.bus = "SFX"
	add_child(audio_stream_player)
	audio_stream_player.play()
	await audio_stream_player.finished
	audio_stream_player.queue_free()



func play_stream(stream: AudioStream) -> void:
	if not stream:
		return
	var audio_stream_player = AudioStreamPlayer.new()
	audio_stream_player.stream = stream
	add_child(audio_stream_player)
	audio_stream_player.play()
	await audio_stream_player.finished
	audio_stream_player.queue_free()
	
