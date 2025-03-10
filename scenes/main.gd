extends Node2D
@export var speed = 100
var screen_size
var score1
var score2
var ball_start_position


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	print(screen_size)
	$ColorRect.size = screen_size
	$ColorRect.position = Vector2.ZERO
	$Player1.position = Vector2(20, screen_size.y/2)
	$Player2.position = Vector2(screen_size.x - 20 , screen_size.y/2)
	ball_start_position = Vector2(screen_size.x/2, screen_size.y/2)
	$Ball.position = ball_start_position
	$TopWall.position = Vector2(screen_size.x/2, 0)
	$TopWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	$BottomWall.position = Vector2(screen_size.x/2, screen_size.y)
	$BottomWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	
	score1 = 0
	score2 = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ball.position.x > screen_size.x:
		score1 +=1
		print("Score 1: ", score1)
		$Ball.position = ball_start_position
	if $Ball.position.x < 0:
		score2 +=1
		print("Score 2: ", score2)
		$Ball.position =ball_start_position
#	
