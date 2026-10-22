extends CanvasLayer


@onready var coin_label = $Control/MarginContainer/HBoxContainer/Label
@onready var boton_pausa = $Control/MarginContainer/HBoxContainer/Panel
@onready var boton_despausa = $Control/MarginContainer/HBoxContainer/Panel2
@onready var ui_pausa = $"UI Pausa"
@onready var panel_versiculo = $PanelVersiculo
@onready var label_versiculo = $PanelVersiculo/Label
var tween_versiculo: Tween

func _ready() -> void:
	if get_tree().paused:
		boton_pausa.visible = false
		boton_despausa.visible = true
		ui_pausa.visible = true
	elif not get_tree().paused:
		boton_despausa.visible = false
		boton_pausa.visible = true
		ui_pausa.visible = false

func set_coins(cantidad):
	coin_label.text = str(cantidad)

func _on_panel_pressed() -> void:
	get_tree().paused = true
	boton_pausa.visible = false
	boton_despausa.visible = true
	ui_pausa.visible = true

func _on_panel_2_pressed() -> void:
	get_tree().paused = false
	boton_despausa.visible = false
	boton_pausa.visible = true
	ui_pausa.visible = false

func mostrar_versiculo(texto: String, duracion := 5.0) -> void:
	label_versiculo.text = texto
	if tween_versiculo:
		tween_versiculo.kill()
	panel_versiculo.modulate.a = 0.0
	panel_versiculo.visible = true
	tween_versiculo = create_tween()
	tween_versiculo.tween_property(panel_versiculo, "modulate:a", 1.0, 0.4)
	tween_versiculo.tween_interval(duracion)
	tween_versiculo.tween_property(panel_versiculo, "modulate:a", 0.0, 0.6)
	tween_versiculo.tween_callback(func(): panel_versiculo.visible = false)
