extends CharacterBody2D

const SPEED = 20.0
const CHASE_SPEED = 60.0

@onready var sprite = $AnimatedSprite2D
@onready var ray_cast_2d = $"Atencion Izq"
@onready var ray_cast_2d_2 = $"Atencion Der"
@onready var ray_pegar_izq = $"Pegar Izq"
@onready var ray_pegar_der = $"Pegar Der"
@onready var ray_pegar_arriba = $"Pegar Arriba"


var direction := 1

func _ready() -> void:
	sprite.play("Walk")

func _ve_posible_pegar(ray: RayCast2D) -> bool:
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider and collider.is_in_group("Player"):
			direction = int(sign(ray.target_position.x))
			return true
	return false

func _ve_al_player(ray: RayCast2D) -> bool:
	if ray.is_colliding():
		var collider = ray.get_collider()
		if collider and collider.is_in_group("Player"):
			direction = int(sign(ray.target_position.x))
			return true
	return false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var persiguiendo = (
		_ve_al_player(ray_cast_2d)
		or _ve_al_player(ray_cast_2d_2)
		)

	var pegando = (
		_ve_posible_pegar(ray_pegar_der)
		or _ve_posible_pegar(ray_pegar_izq)
		or _ve_posible_pegar(ray_pegar_arriba)
		)

	if pegando:
		if sprite.animation != "Attack":
			sprite.play("Attack")
	elif persiguiendo:
		if sprite.animation != "Run":
			sprite.play("Run")
	else:
		if sprite.animation != "Walk":
			sprite.play("Walk")

	if is_on_wall() and not persiguiendo:
		direction *= -1

	sprite.flip_h = direction < 0
	velocity.x = direction * (CHASE_SPEED if persiguiendo else SPEED)

	move_and_slide()

func _on_killzone_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().call_deferred("reload_current_scene")
