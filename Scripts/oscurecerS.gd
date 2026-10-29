extends Area2D

@onready var capa: TileMapLayer = $"../Summer"

@export var color_oscuro := Color(0.263, 0.263, 0.263, 1.0)
@export var duracion := 0.4

var tween: Tween

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_fade(color_oscuro)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		_fade(Color.WHITE)

func _fade(objetivo: Color) -> void:
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(capa, "modulate", objetivo, duracion)
