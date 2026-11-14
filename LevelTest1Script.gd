extends Node2D

@onready var plr = $Player
@onready var actives = $ActiveBullets

func _ready() -> void:
	plr.bullets = $BulletStorage.get_children()
	#plr.bullets = [$Bullet]

func _on_player_shot_bullet(bul: Area2D) -> void:
	bul.reparent(actives)
	bul.show()
