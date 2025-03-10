extends Node2D
@export var speed = 100
var screen_size
var player1
var player2

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	player1 = $Player1
	player2 = $Player2
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("P1Down"):
		velocity
		move_and_slide()
