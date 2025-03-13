extends RigidBody2D
@export var base_speed = 250
var ball_speed
var accel = 50
@export var rotation_speed = 1.5
var rotation_direction = 1
var wall_bounce_sound = preload("res://assets/sounds/wall_bounce.wav")
var paddle_bounce_sound = preload("res://assets/sounds/paddle_hit.wav")


# Called when the node enters the scene tree for the first time.
func _ready():
	var random_direction = randi_range(-1, 1)
	if random_direction == 0:
		random_direction = -1
	var x_speed = 300 * random_direction * randf_range(0.9, 1.2)
	var y_speed = 300 * -random_direction * randf_range(0.9, 1.2)
	ball_speed = Vector2(x_speed,y_speed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	rotation += rotation_direction * rotation_speed * delta
	var collision_info = move_and_collide(ball_speed * delta)
	if collision_info:
		ball_speed = ball_speed.bounce(collision_info.get_normal())
		if collision_info.get_collider().collision_layer == 2:	
			rotation_direction *= -1
			if ball_speed.y != 0:
				ball_speed += Vector2(0, accel * randf_range(0.9, 1.1) * (ball_speed.y / abs(ball_speed.y)))
			if ball_speed.x != 0:
				ball_speed += Vector2(accel * randf_range(0.9, 1.1) * (ball_speed.x / abs(ball_speed.x)), 0)
			$AudioStreamPlayer2D.set_stream(paddle_bounce_sound)
			$AudioStreamPlayer2D.play()
		else:
			$AudioStreamPlayer2D.set_stream(wall_bounce_sound)
			$AudioStreamPlayer2D.play()
