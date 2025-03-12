extends CanvasLayer
signal start_game
	
func update_player1_score(score):
	$ScoreLabelPlayer1.text = str(score)
	
func update_player2_score(score):
	$ScoreLabelPlayer2.text = str(score)
	
func update_level(level):
	$LevelLabel.text = str("Level: ", level)
	
func update_title(message):
	$TitleLabel.text = message


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	
func restart_game():
	$P1LevelCoin1.hide()
	$P1LevelCoin2.hide()
	$P1LevelCoin3.hide()
	$P2LevelCoin1.hide()
	$P2LevelCoin2.hide()
	$P2LevelCoin3.hide()
	
