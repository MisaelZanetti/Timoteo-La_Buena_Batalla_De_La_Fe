extends CanvasLayer


@onready var coin_label = $Control/MarginContainer/HBoxContainer/Label
@onready var boton_pausa = $Control/MarginContainer/HBoxContainer/Panel
@onready var boton_despausa = $Control/MarginContainer/HBoxContainer/Panel2
@onready var ui_pausa = $"UI Pausa"


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
