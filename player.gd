extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal shot_bullet(bul: Area2D)

@export var bullets: Array = []
var bulletI = 0

func _physics_process(delta: float) -> void:
	var mousePos = get_global_mouse_position()
	$Gun.look_at(mousePos)
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if bulletI < len(bullets) and Input.is_action_just_pressed("shoot"):
		var bul: Area2D = bullets[bulletI]
		bulletI += 1
		shot_bullet.emit(bul)
		bul.shoot($Gun/BulletStart.global_position, (mousePos-position).normalized())

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
