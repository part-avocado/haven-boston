extends Area2D

const SPEED = 500

#var direction = Vector2.RIGHT
var direction = Vector2(1.0/2, sqrt(3)/2)
var velocity = Vector2.ZERO

@onready var bCastX = $BouncerX
@onready var bCastY = $BouncerY
#var bCastMag = SPEED/100*2
var bCastMag = 10

func shoot(pos: Vector2, dir: Vector2):
	position = pos
	direction = dir
	bCastX.target_position = bCastMag*Vector2.RIGHT*sign(direction.x)
	bCastY.target_position = bCastMag*Vector2.DOWN*sign(direction.y)


func _ready() -> void:
	#print(sign(direction.x))
	bCastX.target_position = bCastMag*Vector2.RIGHT*sign(direction.x)
	bCastY.target_position = bCastMag*Vector2.DOWN*sign(direction.y)


func checkBounce() -> void:
	if bCastX.is_colliding():
		bCastX.target_position *= -1
		direction.x *= -1
	if bCastY.is_colliding():
		bCastY.target_position *= -1
		direction.y *= -1
		

func _physics_process(delta: float) -> void:
	#$directionig.target_position=direction*100
	checkBounce()
	$Sprite2D.look_at(position+direction)
	velocity = direction*SPEED
	position += velocity*delta


var bounceDebounce = false

func _on_body_entered(_body: Node2D) -> void:
	pass

func _on_body_exited(body: Node2D) -> void:
	#bounceDebounce = false
	pass
