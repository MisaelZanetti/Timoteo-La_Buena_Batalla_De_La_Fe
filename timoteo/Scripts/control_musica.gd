extends HSlider

@export var musica_bus_name = 'Musica'

var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index("Musica")
	value = Autoload.volumen_Musica

func _on_value_changed(value: float) -> void:
	Autoload.volumen_Musica = value
	AudioServer.set_bus_volume_db(audio_bus_id, value)
