extends Node2D
@export var speed = 100
var screen_size
var score1 = 0
var score2 = 0
var ball_start_position
var level = 1
signal adjust_speed(float)
var max_score_per_level = 2
var max_levels = 1
#TODO
#Indicate player that won
#Track number of level wins per player. Maybe an icon next to score
#Update Graphics 
#Add Sound
#Add number of player selection
#Add AI for single player



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
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
	$Ball.hide()
	
func new_game():
	$Ball.show()
	score1 = 0
	score2 = 0
	level = 1
	reset_ball(level)
	
	$HUD.update_player1_score(score1)
	$HUD.update_player1_score(score2)
	$HUD.update_level(level)
	$HUD/TitleLabel.hide()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if $Ball.position.x > screen_size.x + 10:
		score1 +=1
		$HUD.update_player1_score(score1)
		$Ball.position = ball_start_position
	if $Ball.position.x < -10:
		score2 +=1
		$HUD.update_player2_score(score2)
		$Ball.position = ball_start_position
	if score1 == max_score_per_level or score2 == max_score_per_level:
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
	if level > max_levels:
		end_game()
	
func end_game():
	$Ball.position = ball_start_position
	$Ball.stop_ball()
	$Ball.hide()
	$HUD/TitleLabel.show()
	$HUD.update_title("Game Over")
	$HUD/StartButton.show()
	
func reset_ball(new_level):
	var speed_change = 1 + .1 * new_level
	$Ball.position = ball_start_position
	adjust_speed.emit(speed_change)
