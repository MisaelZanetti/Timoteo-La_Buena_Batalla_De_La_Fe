extends Control

func _ready() -> void:
		get_tree().paused = false

func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Menu/Menu.tscn')

func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Niveles/Nivel 1/Nivel_1.tscn')

func _on_button_2_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Niveles/Nivel 2/Summer.tscn')
