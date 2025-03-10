extends CharacterBody2D
@export var speed = 400


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("P1Down"):
		#print("down")
		velocity.y = speed
	elif Input.is_action_pressed("P1Up"):
		#print("up")
		velocity.y = -speed
	else:
		pass
	move_and_slide()
