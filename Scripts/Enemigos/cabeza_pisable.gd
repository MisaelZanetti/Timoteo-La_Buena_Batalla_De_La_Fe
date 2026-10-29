extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if not body.is_in_group("Player"):
		return
	# Solo cuenta si viene cayendo y está por ENCIMA de la cabeza
	if body.velocity.y < 0 or body.global_position.y >= global_position.y:
		return
	var enemigo = get_parent()
	if enemigo.has_method("morir"):
		enemigo.morir()
	else:
		enemigo.queue_free()
	body.rebotar()
