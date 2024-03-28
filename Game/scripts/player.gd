extends CharacterBody2D

const speed = 100
var current_direction = "name"

var enemyInAttackRange = false
var enemyAttackCooldown = true
var bossInAttackRange = false
var bossAttackCooldown = true
var health = 200
var playerAlive = true
var attackInProgress = false

func _ready():
	$AnimatedSprite2D.play("frontIdle")

func _physics_process(delta):
	player_movement(delta)
	enemyAttack()
	attack()
	updateHealth()
	
	if health <= 0:
		playerAlive = false #add end screen/respawn/menu 
		health = 0
		print("player has died")
		self.queue_free()

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
			if attackInProgress == false:
				animation.play("sideIdle")
	if direction == "left":
		animation.flip_h = true
		if movement == 1:
			animation.play("sideWalk")
		elif movement == 0:
			if attackInProgress == false:
				animation.play("sideIdle")
	if direction == "down":
		animation.flip_h = true
		if movement == 1:
			animation.play("frontWalk")
		elif movement == 0:
			if attackInProgress == false:
				animation.play("frontIdle")
	if direction == "up":
		animation.flip_h = true
		if movement == 1:
			animation.play("backWalk")
		elif movement == 0:
			if attackInProgress == false:
				animation.play("backIdle")

func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemyInAttackRange = true
	if body.has_method("boss"):
		bossInAttackRange = true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemyInAttackRange = false
	if body.has_method("boss"):
		bossInAttackRange = false

func enemyAttack():
	if enemyInAttackRange and enemyAttackCooldown == true:
		health = health -20
		enemyAttackCooldown = false
		$attackCooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemyAttackCooldown = true

func attack():
	var direction = current_direction
	if Input.is_action_just_pressed("attack"):
		global.playerCurrentAttack = true
		attackInProgress = true
		if direction == "right":
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("sideAttack")
			$attackTimer.start()
		if direction == "left":
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("sideAttack")
			$attackTimer.start()
		if direction == "down":
			$AnimatedSprite2D.play("frontAttack")
			$attackTimer.start()
		if direction == "up":
			$AnimatedSprite2D.play("backAttack")
			$attackTimer.start()

func _on_attack_timer_timeout():
	$attackTimer.stop()
	global.playerCurrentAttack = false
	attackInProgress = false


func currentCamera():
	if global.currentScene == "world":
		$worldCamera2D.enabled = true
		$desertCamera2D.enabled = false
	elif global.currentScene == "desert":
		$worldCamera2D.enabled = false
		$desertCamera2D.enabled = true

func updateHealth():
	var healthBar = $Healthbar
	healthBar.value = health
	
	if health >= 200:
		healthBar.visible = false
	else:
		healthBar.visible = true


func _on_regeneration_timer_timeout():
	if health < 200:
		health = health + 15
		if health > 200: 
			health = 200
	if health <= 0:
		health = 0
