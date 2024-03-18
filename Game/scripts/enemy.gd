extends CharacterBody2D

var speed = 15
var playerChase = false
var player = null

func _physics_process(delta):
	if playerChase:
		position += (player.position - position).normalized()*speed*delta
		move_and_collide(Vector2(0,0))
		$AnimatedSprite2D.play("walk")
		
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
