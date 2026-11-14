extends Area2D

const SPEED = 700

#var direction = Vector2.RIGHT
var direction = Vector2(1.0/2, sqrt(3)/2)
var velocity = Vector2.ZERO

@onready var bCastX = $BouncerX
@onready var bCastY = $BouncerY
#var bCastMag = SPEED/100*2
var bCastMag = 15

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

func _on_area_entered(area: Node2D) -> void:
	if area.name == "Player":
		area.hurt()
	if area.name.substr(0,5) == "Enemy":
		area.kill()

func _on_area_exited(_area: Node2D) -> void:
	#bounceDebounce = false
	pass
