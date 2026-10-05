extends CharacterBody2D


const SPEED = 125.0
const JUMP_VELOCITY = -180.0

@onready var anim = $Sprite2D
var coins = 0

@onready var hud = get_node('/root/Map/CanvasLayer');
func add_coin():
	coins += 1
	hud.set_coins(coins)

@onready var jump_sound = $Jump;

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.5

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_sound.play()

	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		anim.flip_h=direction<0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	if not is_on_floor() && velocity.y < 0:
		anim.play("Jump")
	elif direction != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
