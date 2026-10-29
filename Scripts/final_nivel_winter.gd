extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		$"../CanvasLayer2/ColorRect/AnimationPlayer".play("new_animation")
		await get_tree().create_timer(1.5).timeout
		get_tree().change_scene_to_file('res://Scenes/Niveles/Nivel 2/Autum.tscn')
