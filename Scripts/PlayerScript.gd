extends CharacterBody2D

const SPEED = 100.0
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	if GameController.playerInteragindo: return
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction.normalized() * SPEED
	move_and_slide()
	updateAnimation()

func updateAnimation():
	if velocity == Vector2.ZERO:
		sprite.play("default")
		return
	if abs(velocity.x) > abs(velocity.y):
		sprite.play("Side")
		if velocity.x > 0:
			sprite.flip_h = false
		else:
			sprite.flip_h = true
	elif abs(velocity.y) > abs(velocity.x):
		if velocity.y > 0:
			sprite.play("Down")
		else:
			sprite.play("Up")
	pass
