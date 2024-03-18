extends CharacterBody2D

const speed = 100
var current_direction = "name"
func _physics_process(delta):
	player_movement(delta)

func player_movement(delta):
	velocity = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.y = -speed
		velocity.x = 0
	else: 
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
	
	move_and_slide()

func play_animation(movement):
	var direction = current_direction
	var animation = $AnimatedSprite2D
	
	if direction == "right":
		animation.flip_h = false
		if movement == 1:
			animation.play("sideWalk")
		elif movement == 0:
			animation.play("sideIdle")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("sideWalk")
		elif movement == 0:
			animation.play("sideIdle")
	if direction == "down":
		animation.flip_h = true
		if movement == 1:
			animation.play("frontWalk")
		elif movement == 0:
			animation.play("frontIdle")
	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("backWalk")
		elif movement == 0:
			animation.play("backIdle")
