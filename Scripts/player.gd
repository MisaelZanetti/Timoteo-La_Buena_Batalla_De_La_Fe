
extends CharacterBody2D

const SPEED = 125.0
const JUMP_VELOCITY = -300.0

@onready var anim = $Sprite2D
@onready var hud = get_node("/root/Map/CanvasLayer")
@onready var jump_sound = $Jump

var coins = 0

func add_coin():
	coins += 1
	hud.set_coins(coins)

func _physics_process(delta: float) -> void:
	# Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.5

	# Saltar con W
	if Input.is_key_pressed(KEY_W) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	# Movimiento con A y D
	var direction := Input.get_axis("ui_left", "ui_right")

	if Input.is_key_pressed(KEY_A):
		direction = -1
	elif Input.is_key_pressed(KEY_D):
		direction = 1

	if direction != 0:
		velocity.x = direction * SPEED
		anim.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# Animaciones
	if not is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif direction != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
