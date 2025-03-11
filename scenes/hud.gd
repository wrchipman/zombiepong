extends CanvasLayer
	
func update_player1_score(score):
	$ScoreLabelPlayer1.text = str(score)
	
func update_player2_score(score):
	$ScoreLabelPlayer2.text = str(score)
	
func update_level(level):
	$LevelLabel.text = str(level)
