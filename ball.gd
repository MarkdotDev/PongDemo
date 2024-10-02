extends CharacterBody2D

var window_size: Vector2
var ball_direction: Vector2
var ball_speed: int
const BALL_START_SPEED: int = 400
const ACCELERATION: int = 30

@onready var player: StaticBody2D = $"../Player"
@onready var computer: StaticBody2D = $"../Computer"
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
	window_size = get_viewport_rect().size

func initialize_ball() -> void:
	position = Vector2(window_size.x / 2, randf_range(200, window_size.y - 200))
	ball_speed = BALL_START_SPEED
	velocity = random_ball_direction() * ball_speed

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * delta)
	if collision:
		handle_collision(collision)

	handle_boundaries()

func handle_collision(collision: KinematicCollision2D) -> void:
	var collider = collision.get_collider()
	if collider in [player, computer]:
		ball_speed += ACCELERATION

	velocity = velocity.bounce(collision.get_normal())
	velocity = velocity.normalized() * ball_speed

func handle_boundaries() -> void:
	var rectangle = collision_shape.shape as RectangleShape2D
	var half_width = rectangle.size.x / 2
	var half_height = rectangle.size.y / 2

	if position.y - half_height < 0 or position.y + half_height > window_size.y:
		velocity.y = -velocity.y
		position.y = clamp(position.y, half_height, window_size.y - half_height)
	
	if position.x - half_width < 0 or position.x + half_width > window_size.x:
		initialize_ball()

func random_ball_direction() -> Vector2:
	var new_direction := Vector2()
	new_direction.x = [1, -1].pick_random()
	new_direction.y = randf_range(-1, 1)
	
	return new_direction.normalized()
