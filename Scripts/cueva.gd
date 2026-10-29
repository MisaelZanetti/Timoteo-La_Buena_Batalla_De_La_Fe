extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('Player'):
		$"../CanvasLayer3/AnimatedSprite2D".play("Oscuro 2")
