extends Node

@onready var player = $musix

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	player.play()

func cambiar_musica(stream: AudioStream) -> void:
	if player.stream == stream and player.playing:
		return  # ya suena esa pista, no la reinicia
	player.stream = stream
	player.play()
