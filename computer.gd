extends StaticBody2D

var window_height: int
var paddle_height: int
var ball_position: Vector2
var distance_to_ball: int
var distance: int

@onready var color_rect: ColorRect = $ColorRect
@onready var ball: CharacterBody2D = $"../Ball"

func _ready() -> void:
	window_height = get_viewport_rect().size.y
	paddle_height = color_rect.get_size().y

func _process(delta: float) -> void:
	ball_position = ball.position
	distance = position.y - ball_position.y
	
	if abs(distance) > get_parent().PADDLE_SPEED * delta:
		distance_to_ball = get_parent().PADDLE_SPEED * delta * (distance / abs(distance))
	else:
		distance_to_ball = distance
	
	position.y -= distance_to_ball

	position.y = clamp(position.y, paddle_height / 2, window_height - paddle_height / 2)
