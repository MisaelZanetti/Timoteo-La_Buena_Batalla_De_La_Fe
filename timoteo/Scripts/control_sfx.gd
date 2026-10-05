extends HSlider

@export var musica_bus_name = "SFX"

var audio_bus_id

func _ready():
	audio_bus_id = AudioServer.get_bus_index("SFX")
	value = Autoload.volumen_SFX

func _on_value_changed(value: float) -> void:
	Autoload.volumen_SFX = value
	AudioServer.set_bus_volume_db(audio_bus_id, value)
