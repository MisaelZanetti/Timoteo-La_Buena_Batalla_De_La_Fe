extends Area2D

@export_multiline var versiculo := "Escribí acá el versículo\n- Libro 0:00"
@export var monedas := 10
@export var duracion_versiculo := 5.0

@onready var sprite = $AnimatedSprite2D
@onready var collision = $CollisionShape2D
@onready var sonido = $Sonido

var recogida := false

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	sonido.finished.connect(queue_free)

func _on_body_entered(body: Node2D) -> void:
	if recogida or not body.is_in_group("Player"):
		return
	recogida = true
	body.add_coins(monedas)
	body.mostrar_versiculo(versiculo, duracion_versiculo)
	sprite.visible = false
	collision.set_deferred("disabled", true)
	sonido.play()
