extends RigidBody2D
@export var base_speed = 250
var ball_speed = Vector2.ZERO
@export var rotation_speed = 1.5
var rotation_direction = 1
var wall_bounce_sound = preload("res://assets/sounds/wall_bounce.wav")
var paddle_bounce_sound = preload("res://assets/sounds/paddle_hit.wav")



# Called when the node enters the scene tree for the first time.
func _ready():
	pass#stop_ball()

func stop_ball():
	ball_speed = Vector2.ZERO
	rotation = 0.0
	print("stopping ball")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if ball_speed == Vector2.ZERO:
		print(ball_speed)
	rotation += rotation_direction * rotation_speed * delta
	var collision_info = move_and_collide(ball_speed * delta)
	if collision_info:
		ball_speed = ball_speed.bounce(collision_info.get_normal())
		if collision_info.get_collider().collision_layer == 2:	
			rotation_direction *= -1
			$AudioStreamPlayer2D.set_stream(paddle_bounce_sound)
			$AudioStreamPlayer2D.play()
		else:
			$AudioStreamPlayer2D.set_stream(wall_bounce_sound)
			$AudioStreamPlayer2D.play()
	
			
		
func set_ball_speed(level_adjust):
	ball_speed = Vector2(base_speed * (randf()+level_adjust), base_speed * (randf()+level_adjust))
	
func _on_main_adjust_speed(adjust):
	set_ball_speed(adjust)
