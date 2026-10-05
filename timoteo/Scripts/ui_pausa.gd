extends Control

func _on_opciones_pressed() -> void:
	Autoload.ir_a("res://Scenes/Menu/Opciones.tscn", true)

func _on_salir_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menu/Niveles.tscn")
