extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player 
var chase = false 

func _ready():
	get_node("AnimatedSprite2D").play("idle")
	
func _physics_process(delta):
	# Add the gravity.
	velocity.y += gravity * delta
	if chase == true:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("jump")
		player = get_node("../../player/player")
		var direction = (player.position - self.position).normalized()
		if direction.x > 0:
			get_node("AnimatedSprite2D").flip_h = true
		else:
			get_node("AnimatedSprite2D").flip_h = false
		velocity.x = direction.x * SPEED
	else:
		if get_node("AnimatedSprite2D").animation != "death":
			get_node("AnimatedSprite2D").play("idle")
		velocity.x = 0
	move_and_slide()

func _on_playerdetection_body_entered(body):
	if body.name == "player":
		chase = true 

func _on_playerdetection_body_exited(body):
	if body.name == "player":
		chase = false 

func _on_playerkill_body_entered(body):
	if body.name == "player":
		death()
	
func _on_playercollision_body_entered(body):
	if body.name == "player":
		Game.PlayerHP -= 3
		death()

#fungsi mengeksekusi animasi mati
func death():
	Game.Gold += 5
	Utils.SaveGame()
	chase = false 
	get_node("AnimatedSprite2D").play("death")
	await get_node("AnimatedSprite2D").animation_finished
	self.queue_free()
