extends Node2D
@export var speed = 100
var screen_size
var score1
var score2


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	score1 = 0
	score2 = 0
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Ball.position.x > 330:
		score1 +=1
		print("Score 1: ", score1)
		$Ball.position =Vector2(0, 0)
	if $Ball.position.x < -330:
		score2 +=1
		print("Score 2: ", score2)
		$Ball.position =Vector2(0, 0)
#	
