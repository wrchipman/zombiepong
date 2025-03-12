extends Node2D
@export var speed = 100
var screen_size
var score1 = 0
var score2 = 0
var ball_start_position
var level = 1
signal adjust_speed(float)
var max_score_per_level = 2
var max_levels = 5
var player1_level = 0
var player2_level = 0
var game_over = false
#TODO
#Update Graphics 
#Add number of player selection
#Add AI for single player



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	$Background.position = Vector2(screen_size.x/2 - 10, screen_size.y/2)
	$Player1.position = Vector2(60, screen_size.y/2)
	$Player2.position = Vector2(screen_size.x - 70 , screen_size.y/2)
	ball_start_position = Vector2(screen_size.x/2, screen_size.y/2)
	$Ball.position = ball_start_position
	$TopWall.position = Vector2(screen_size.x/2, 0)
	$TopWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	$BottomWall.position = Vector2(screen_size.x/2, screen_size.y)
	$BottomWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	#$Ball.hide()
	
func new_game():
	$Ball.show()
	score1 = 0
	score2 = 0
	level = 1
	player1_level = 0
	player2_level = 0
	reset_ball(level)
	
	$HUD.update_player1_score(score1)
	$HUD.update_player1_score(score2)
	$HUD.update_level(level)
	$HUD/TitleLabel.hide()
	$HUD.restart_game()
	game_over = false
	
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
	if player1_level>= 3 or player2_level >= 3:
		game_over = true
	if not game_over and (score1 == max_score_per_level or score2 == max_score_per_level):
		print("in here")
		reset_and_raise_level()
		
#
func reset_and_raise_level():
	if score1 == max_score_per_level:
		player1_level += 1
		match player1_level:
			1:
				$HUD/P1LevelCoin1.show()
			2:
				$HUD/P1LevelCoin2.show()
			3:
				$HUD/P1LevelCoin3.show()
				end_game()
	else:
		player2_level += 1
		match player2_level:
			1:
				$HUD/P2LevelCoin1.show()
			2:
				$HUD/P2LevelCoin2.show()
			3:
				$HUD/P2LevelCoin3.show()
				end_game()
		
	score1 = 0
	score2 = 0
	level += 1
	
	
	reset_ball(level)
	$HUD.update_player1_score(score1)
	$HUD.update_player1_score(score2)
	if level < 6:
		$HUD.update_level(level)
	
func end_game():
	game_over = true
	$Ball.position = ball_start_position
	$Ball.stop_ball()
	#$Ball.hide()
	$HUD/TitleLabel.show()
	if player1_level > player2_level:
		$HUD.update_title("Game Over\nPLayer 1 Wins")
	else:
		$HUD.update_title("Game Over\nPLayer 2 Wins")
	$HUD/StartButton.show()
	
func reset_ball(new_level):
	print("called")
	var speed_change = 1 + .1 * new_level
	$Ball.position = ball_start_position
	adjust_speed.emit(speed_change)
