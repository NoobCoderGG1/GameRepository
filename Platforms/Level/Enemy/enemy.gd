class_name Enemy
extends CharacterBody2D

var SPEED : float = 50.0
var damage : float = 50
var HP = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var delay = 3.0
var lastHit : float = 0.0
var coin_scene = preload("res://Level/level_objects/coin.tscn")
@onready var animation = $enemySprite
@onready var level = $".."
@onready var dirEnemy = 1 #Направление взгляда Enemy, равняется -1 или 1

func _physics_process(delta):
	if HP <= 0: #Удаление врага в случае его смерти
		var coin = coin_scene.instantiate()
		coin.position = Vector2(position.x, position.y)
		get_tree().root.add_child(coin)
		level.enemies.erase(self)
		queue_free()
	var Velocity = velocity
	var target_velocity = Vector2()
	#Перемещение врага, если координаты не соответствуют установленным
	if abs(position.x - get_parent().get_node("player").position.x) > 25 or abs(position.y - get_parent().get_node("player").position.y) > 25:
		if position.x < get_parent().get_node("player").position.x:
			Velocity.x = 1
		else:
			if position.x > get_parent().get_node("player").position.x:
				Velocity.x = -1
		target_velocity.x = Velocity.x * SPEED
		dirEnemy = Velocity.x
	else: #В случае соответствии, производится атака
		if lastHit <= 0:
			get_parent().get_node("player").HP -= damage
			lastHit = delay
		else:
			lastHit -= delta

	if not is_on_floor():
		target_velocity.y += gravity * delta

	velocity = target_velocity
	move_and_slide()
