extends CharacterBody2D

const SPEED = 500.0

const Bullet = preload("res://scenes/bullet.tscn")

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
							
	move_and_slide()

	if Input.is_action_just_pressed("shoot"):
		var  bullet = Bullet.instantiate()
		bullet.position = position - 10 * Vector2.UP
		bullet.direction = (Vector2.UP * bullet.bullet_speed + velocity) / bullet.bullet_speed
		get_parent().add_child(bullet)
