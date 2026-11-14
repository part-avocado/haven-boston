extends Node

@export var nextLevel: String

@onready var plr: Area2D = $Level/Player
@onready var actives: Node = $Level/ActiveBullets
@onready var enemies: Node = $Level/Enemies
@onready var control: Control = $Control

func _ready() -> void:
	plr.bullets = $Level/BulletStorage.get_children()
	plr.died.connect(_on_player_died)
	plr.shot_bullet.connect(_on_player_shot_bullet)
	$Control/VBoxContainer/StartButton.pressed.connect(_on_start_button_pressed)
	$Control/YouDied/Button.pressed.connect(_on_restart_button_pressed)
	enemies.child_exiting_tree.connect(_on_enemy_died)
	
	startLevel()

func _on_player_shot_bullet(bul: Area2D) -> void:
	bul.reparent(actives)
	bul.show()

func _process(_delta: float) -> void:
	if enemies.get_child_count() == 0:
		#print("testing")
		if nextLevel:
			get_tree().change_scene_to_file(nextLevel)

func startLevel() -> void:
	pass
	#$Level.process_mode = Node.PROCESS_MODE_INHERIT

func _on_start_button_pressed():
	control.hide()
	control.process_mode = Node.PROCESS_MODE_DISABLED
	$Level.process_mode = Node.PROCESS_MODE_INHERIT
	
func _on_restart_button_pressed():
	print("pressed?")
	#get_tree().change_scene_to_file("res://Level1.tscn")
	get_tree().reload_current_scene()
	

func _on_player_died():
	control.process_mode = Node.PROCESS_MODE_INHERIT
	$Level.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	$Control/VBoxContainer.hide()
	control.show()
	$Control/YouDied.show()

func _on_enemy_died(_node: Node):
	print("an enemy died")
	#if enemies.get_child_count() == 0:
		#print("testing")
		#if nextLevel:
			#get_tree().change_scene_to_packed(nextLevel)
