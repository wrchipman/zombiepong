extends CharacterBody2D

var speed = 400.0
var b_position = Vector2(0, 324)

func _ready():
		# Get a reference to the emitter node
		var emitter_node = get_parent()
		# Connect the signal
		emitter_node.ball_position.connect(set_ball_position)
	
func set_ball_position(ball_position):
		# Code to execute when the signal is emitted
	b_position = ball_position


func _physics_process(delta):
	var move_by
	var dist = position.y - b_position.y
	if abs(dist) > speed * delta:
		if dist != 0:
			move_by = speed * delta * (dist / abs(dist))
	else: 
		move_by = dist
	
	position.y -= move_by	

	move_and_slide()
