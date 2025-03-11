extends Node2D
@export var speed = 100
var screen_size
var score1
var score2
var ball_start_position
var level
signal adjust_speed(float)


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	new_game()
	
	
func new_game():
	$ColorRect.size = screen_size
	$ColorRect.position = Vector2.ZERO
	$Player1.position = Vector2(20, screen_size.y/2)
	$Player2.position = Vector2(screen_size.x - 20 , screen_size.y/2)
	ball_start_position = Vector2(screen_size.x/2, screen_size.y/2)
	
	$TopWall.position = Vector2(screen_size.x/2, 0)
	$TopWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	$BottomWall.position = Vector2(screen_size.x/2, screen_size.y)
	$BottomWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	
	score1 = 0
	score2 = 0
	level = 1
	reset_ball(level)
	
	$HUD.update_player1_score(score1)
	$HUD.update_player1_score(score2)
	$HUD.update_level(level)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $Ball.position.x > screen_size.x:
		score1 +=1
		$HUD.update_player1_score(score1)
		$Ball.position = ball_start_position
	if $Ball.position.x < 0:
		score2 +=1
		$HUD.update_player2_score(score2)
		$Ball.position = ball_start_position
	if score1 == 5 or score2 == 5:
		reset_and_raise_level()
#
func reset_and_raise_level():
	score1 = 0
	score2 = 0
	level += 1
	reset_ball(level)
	$HUD.update_player1_score(score1)
	$HUD.update_player1_score(score2)
	$HUD.update_level(level)
		
func reset_ball(new_level):
	var speed_change = 1 + .2 * new_level
	$Ball.position = ball_start_position
	adjust_speed.emit(speed_change)
