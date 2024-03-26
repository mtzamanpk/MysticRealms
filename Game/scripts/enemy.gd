extends CharacterBody2D

var speed = 15
var playerChase = false
var player = null

var health = 100
var playerInAttackRange = false
var canTakeDamage = true

func _physics_process(delta):
	takingDamage()
	updateHealth()
	
	
	if playerChase:
		position += (player.position - position).normalized()*speed*delta
		move_and_collide(Vector2(0,0))
		$AnimatedSprite2D.play("sideAttack")
		
		
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")


func _on_detection_area_body_entered(body):
	player = body
	playerChase = true


func _on_detection_area_body_exited(body):
	player = null
	playerChase = false

func enemy():
	pass


func _on_hitbox_body_entered(body):
	if body.has_method("player"):
		playerInAttackRange = true


func _on_hitbox_body_exited(body):
	if body.has_method("player"):
		playerInAttackRange = false

func takingDamage():
	if playerInAttackRange and global.playerCurrentAttack == true:
		if canTakeDamage == true:
			health = health - 20
			$AnimatedSprite2D.play("sideAttack")
			$recieveDamageCooldown.start()
			canTakeDamage = false
			print("goblin health:", health)
			if health <= 0:
				self.queue_free()


func _on_recieve_damage_cooldown_timeout():
	canTakeDamage = true

func updateHealth():
	var healthBar = $Healthbar
	healthBar.value = health
	
	if health >= 100:
		healthBar.visible = false
	else:
		healthBar.visible = true
