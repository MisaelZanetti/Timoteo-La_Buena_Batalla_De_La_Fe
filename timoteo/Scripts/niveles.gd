extends Control

func _ready() -> void:
		get_tree().paused = false

func _on_atras_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Menu/Menu.tscn')

func _on_nivel_1_pressed() -> void:
	get_tree().change_scene_to_file('res://Scenes/Niveles/Nivel_1.tscn')
