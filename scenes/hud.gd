extends CanvasLayer
signal start_game(int)

var ai_level = 1

func _ready():
	restart_game()
	
func update_player1_score(score):
	$ScoreLabelPlayer1.text = str(score)
	
func update_player2_score(score):
	$ScoreLabelPlayer2.text = str(score)
	
func update_level(level):
	$LevelLabel.text = str("Level: ", level)
	
func update_title(message):
	$TitleLabel.text = message
	
func restart_game():
	hide_level_coins()
	update_level(1)
	update_player1_score(0)
	update_player2_score(0)
	$StartButton.text = "Choose Players"
	$AILevelButton.text = "AI Level"
	
func hide_level_coins():
	$P1LevelCoin1.hide()
	$P1LevelCoin2.hide()
	$P1LevelCoin3.hide()
	$P2LevelCoin1.hide()
	$P2LevelCoin2.hide()
	$P2LevelCoin3.hide()
	

func _on_start_button_item_selected(index):
	$StartButton.hide()
	$AILevelButton.hide()
	start_game.emit(index)


func _on_ai_level_button_item_selected(index):
	ai_level = index
