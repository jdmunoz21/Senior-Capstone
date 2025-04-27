extends CharacterBody2D

const SPEED = 500.0
var direction = "none"

func _ready():
	play_animation(0)

func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	if Input.is_action_pressed("right"):
		direction = "right"
		play_animation(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("left"):
		direction = "left"
		play_animation(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("up"):
		direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -SPEED
	elif Input.is_action_pressed("down"):
		direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = SPEED
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()
	
func play_animation(movement):
	var anim = $AnimatedSprite2D
	
	if direction == "right":
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if direction == "left":
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if direction == "up":
		anim.flip_h = false
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	if direction == "down":
		anim.flip_h = false
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")
	if direction == "none":
		anim.play("front_idle")
