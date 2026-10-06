extends Node

var volumen_SFX = 0
var volumen_Musica = 0

var escena_anterior: String = ""
var capa_actual: CanvasLayer = null

func ir_a(ruta: String, usar_capa: bool = false) -> void:
	if usar_capa:
		var capa = CanvasLayer.new()
		capa.layer = 10
		capa.process_mode = Node.PROCESS_MODE_ALWAYS
		
		get_tree().current_scene.add_child(capa)
		
		var escena = preload("res://Scenes/Menu/Opciones.tscn").instantiate()
		capa.add_child(escena)
		
		capa_actual = capa
	else:
		escena_anterior = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file(ruta)

func volver() -> void:
	if capa_actual != null:
		capa_actual.queue_free()
		capa_actual = null
	elif escena_anterior != "":
		var destino = escena_anterior
		escena_anterior = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file(destino)
