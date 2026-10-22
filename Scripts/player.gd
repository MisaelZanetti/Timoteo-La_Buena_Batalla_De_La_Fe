extends CharacterBody2D

const SPEED = 125.0
const JUMP_VELOCITY = -180.0

# --- Wall jump (todos ajustables) ---
const WALL_SLIDE_SPEED = 40.0    # velocidad máxima de caída pegado a la pared
const WALL_JUMP_PUSH = 140.0     # empuje horizontal, siempre alejándose de la pared
const WALL_JUMP_LOCK = 0.15      # segundos sin control horizontal tras el wall jump
const WALL_COYOTE_TIME = 0.15    # ventana para saltar después de soltar la pared

var wall_lock := 0.0             # cuenta regresiva del bloqueo horizontal
var wall_coyote := 0.0           # cuenta regresiva del coyote time
var coyote_wall_x := 0.0         # lado de la última pared tocada (normal.x: -1 o 1)
var last_jump_wall_x := 0.0      # pared de la que saltaste por última vez (0 = ninguna)
var is_wall_sliding := false

var coins = 0

@onready var anim = $Sprite2D
@onready var hud = get_tree().current_scene.get_node_or_null("CanvasLayer")
@onready var jump_sound = $Jump

func add_coin() -> void:
	add_coins(1)

func add_coins(cantidad: int) -> void:
	coins += cantidad
	if hud:
		hud.set_coins(coins)

func mostrar_versiculo(texto: String, duracion := 5.0) -> void:
	if hud:
		hud.mostrar_versiculo(texto, duracion)

func rebotar(factor := 0.8) -> void:
	velocity.y = JUMP_VELOCITY * factor

func _physics_process(delta: float) -> void:
	var direction := Input.get_axis("ui_left", "ui_right")
	is_wall_sliding = false

	# --- Gravedad / reset al tocar el piso ---
	if not is_on_floor():
		velocity += get_gravity() * delta * 0.5
	else:
		last_jump_wall_x = 0.0   # en el piso se puede volver a cualquier pared
		wall_coyote = 0.0

	# --- Detección de pared ---
	if is_on_wall_only():
		var wall_x := signf(get_wall_normal().x)
		# Solo cuenta si NO es la pared de la que acabás de saltar
		if wall_x != last_jump_wall_x:
			coyote_wall_x = wall_x
			wall_coyote = WALL_COYOTE_TIME
			# Wall slide: cayendo y empujando hacia la pared
			if velocity.y > 0 and direction * wall_x < 0:
				is_wall_sliding = true
				velocity.y = min(velocity.y, WALL_SLIDE_SPEED)

	wall_coyote = max(wall_coyote - delta, 0.0)

	# --- Salto ---
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			jump_sound.play()
		elif wall_coyote > 0.0:
			# Wall jump: siempre en dirección opuesta a la pared
			velocity.y = JUMP_VELOCITY
			velocity.x = coyote_wall_x * WALL_JUMP_PUSH
			last_jump_wall_x = coyote_wall_x
			wall_coyote = 0.0
			wall_lock = WALL_JUMP_LOCK
			anim.flip_h = coyote_wall_x < 0
			jump_sound.play()

	# --- Movimiento horizontal ---
	wall_lock = max(wall_lock - delta, 0.0)
	if wall_lock == 0.0:
		if direction:
			velocity.x = direction * SPEED
			anim.flip_h = direction < 0
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

	# --- Animaciones ---
	if is_wall_sliding:
		anim.play("Wall-jump")
	elif not is_on_floor() and velocity.y < 0:
		anim.play("Jump")
	elif direction != 0:
		anim.play("Walk")
	else:
		anim.play("Idle")
