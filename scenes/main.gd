extends Node2D
@export var speed = 100
signal ball_position(Vector2)
var screen_size
var score1 = 0
var score2 = 0
var ball_start_position
var level = 1

var max_score_per_level = 5
var max_levels = 5
var player1_level = 0
var player2_level = 0
var game_over = false
var player1_scene = preload("res://scenes/player1.tscn")
var player2_scene = preload("res://scenes/player2.tscn")
var playerai_scene = preload("res://scenes/ai_opponent.tscn")
var ball_scene = preload("res://scenes/ball.tscn")
var player1
var player2
var ball
var three_played = false
var two_played = false
var one_played = false
#TODO
#Update Graphics 
#Add number of player selection
#Add AI for single player



# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
	$Background.position = Vector2(screen_size.x/2 - 10, screen_size.y/2)
	
	$TopWall.position = Vector2(screen_size.x/2, 0)
	$TopWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	
	$BottomWall.position = Vector2(screen_size.x/2, screen_size.y)
	$BottomWall/CollisionShape2D.shape.set_size(Vector2(screen_size.x, 1))
	
	$LeftGoal.position.x -= 100
	$RightGoal.position.x += screen_size.x + 100
	

func two_player_setup():
	player1 = player1_scene.instantiate()
	player2 = player2_scene.instantiate()
	call_deferred("add_child", player1)
	call_deferred("add_child", player2)
	player1.position = Vector2(60, screen_size.y/2)
	player2.position = Vector2(screen_size.x - 70 , screen_size.y/2)
	
func ball_setup():
	ball = ball_scene.instantiate()
	call_deferred("add_child", ball)
	ball.show()
	ball_start_position = Vector2(screen_size.x/2, screen_size.y/2)
	ball.position = ball_start_position
	
func ai_player_setup():
	player1 = player1_scene.instantiate()
	player2 = playerai_scene.instantiate()
	call_deferred("add_child", player1)
	call_deferred("add_child", player2)
	player1.position = Vector2(60, screen_size.y/2)
	player2.position = Vector2(screen_size.x - 70 , screen_size.y/2)
	var ai_level = $HUD.ai_level
	if ai_level == 0:
		player2.speed *= .75
	elif ai_level == 2:
		player2.speed *= 1.25 
		
func new_game(index):
	if index == 1:
		two_player_setup()
	else:
		ai_player_setup()
	$Timer.start()
	
	score1 = 0
	score2 = 0
	level = 1
	player1_level = 0
	player2_level = 0
	$HUD.restart_game()
	#$HUD/TitleLabel.hide()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not game_over and (player1_level>= 3 or player2_level >= 3):
		game_over = true
		end_game()
	if not game_over and (score1 == max_score_per_level or score2 == max_score_per_level):
		reset_and_raise_level()
	if ball:
		ball_position.emit(ball.position)
	if $Timer.time_left > 2:
		$HUD.update_title("3")
		if not three_played:
			three_played = true
			$AudioStreamPlayer2D.play()
	elif $Timer.time_left > 1:
		$HUD.update_title("2")
		if not two_played:
			two_played = true
			$AudioStreamPlayer2D.play()
	elif $Timer.time_left > 0:
		$HUD.update_title("1")
		if not one_played:
			one_played = true
			$AudioStreamPlayer2D.play()
	
	
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

	$HUD.update_player1_score(score1)
	$HUD.update_player2_score(score2)
	if level < 6:
		$HUD.update_level(level)
	
func end_game():
	game_over = true
	ball.queue_free()
	player2.queue_free()
	player1.queue_free()
	if player1_level > player2_level:
		$HUD.update_title("Game Over\nPlayer 1 Wins")
	else:
		$HUD.update_title("Game Over\nPlayer 2 Wins")
	$HUD/TitleLabel.show()
	$HUD/StartButton.show()
	$HUD/AILevelButton.show()
	
func _on_left_goal_body_entered(_body):
	#Player 2 scoring code
	score2 +=1
	$HUD.update_player2_score(score2)
	ball.queue_free()
	ball_setup()
	

func _on_right_goal_body_entered(_body):
	#Player1 scoring code
	score1 +=1
	$HUD.update_player1_score(score1)
	ball.queue_free()
	ball_setup()


func _on_timer_timeout():
	$HUD/TitleLabel.hide()
	ball_setup()
	game_over = false
