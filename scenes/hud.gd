extends CanvasLayer
signal start_game
	
func update_player1_score(score):
	$ScoreLabelPlayer1.text = str(score)
	
func update_player2_score(score):
	$ScoreLabelPlayer2.text = str(score)
	
func update_level(level):
	$LevelLabel.text = str(level)
	
func update_title(message):
	$TitleLabel.text = message


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
