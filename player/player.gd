extends KinematicBody2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	var speed = 4000
	var velocity = Vector2()
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += speed
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= speed

	if Input.is_action_pressed("ui_left"):
		velocity.x -= speed
		
	if Input.is_action_pressed("ui_right"):
		velocity.x += speed
	
	move_and_slide(velocity * delta)
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
