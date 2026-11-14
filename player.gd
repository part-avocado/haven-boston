extends Area2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

signal shot_bullet(bul: Area2D)

var health = 3

@onready var shootTimer = $ShootTimer
@onready var damageTimer = $DamageTimer

@export var bullets: Array = []
var bulletI = 0

func hurt():
	if damageTimer.is_stopped():
		health -= 1
		damageTimer.start()

func _physics_process(delta: float) -> void:
	$RichTextLabel.text = "Health: " + str(health)
	var mousePos = get_global_mouse_position()
	$Gun.look_at(mousePos)
	
	if shootTimer.is_stopped() and bulletI < len(bullets) and Input.is_action_just_pressed("shoot"):
		shootTimer.start()
		var bul: Area2D = bullets[bulletI]
		bulletI += 1
		shot_bullet.emit(bul)
		bul.shoot($Gun/BulletStart.global_position, (mousePos-position).normalized())
