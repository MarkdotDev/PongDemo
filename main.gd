extends Node2D

@onready var ball: CharacterBody2D = $Ball
const PADDLE_SPEED: int = 400
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_ball_timer_timeout() -> void:
	ball.initialize_ball()
