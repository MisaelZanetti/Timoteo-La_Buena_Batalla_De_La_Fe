
extends Area2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var pickup_sound = $Coin

var recogida = false

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player") and not recogida:
		recogida = true
		body.add_coin()
		animated_sprite.visible = false
		collision.set_deferred("disabled", true)
		pickup_sound.play()

func _ready() -> void:
	pickup_sound.finished.connect(_on_sound_finished)

func _on_sound_finished() -> void:
	queue_free()
