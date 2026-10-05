extends Control

@onready var panel_volumen = $Volumen
@onready var panel_otras_configuraciones = $Otros

func _ready() -> void:
	panel_otras_configuraciones.visible = false

func _on_jugar_pressed() -> void:
	panel_volumen.visible = true
	panel_otras_configuraciones.visible = false

func _on_opciones_pressed() -> void:
	panel_volumen.visible = false
	panel_otras_configuraciones.visible = true

func _on_atras_pressed() -> void:
	queue_free()
