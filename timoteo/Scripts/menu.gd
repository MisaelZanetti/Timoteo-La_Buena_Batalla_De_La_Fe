extends Control


func _on_jugar_pressed() -> void:
	Autoload.ir_a("res://Scenes/Menu/Niveles.tscn")


func _on_opciones_pressed() -> void:
	var menu = preload("res://Scenes/Menu/Opciones.tscn").instantiate()
	get_tree().current_scene.add_child(menu)


func _on_salir_pressed() -> void:
	get_tree().quit()
