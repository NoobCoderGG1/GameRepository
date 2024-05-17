class_name Enemy
extends CharacterBody2D

var SPEED : float = 50.0
var damage : float = 5
var HP = 20
var gravity = 10000#ProjectSettings.get_setting("physics/2d/default_gravity")
var delay = 0.5
var lastHit : float = 0.0
var JUMP_VELOCITY : float = -1000.0
var coin_scene = preload("res://Level/level_objects/coin.tscn")
@onready var animation = $enemySprite
@onready var level = $".."
@onready var dirEnemy = 1 #Направление взгляда Enemy, равняется -1 или 1

func _physics_process(delta):
	if HP <= 0: #Удаление врага в случае его смерти
		var randomNumber = randi() % 6 #Монета выпадет с определ. шансом (от 0 до 5 генерация числа)
		if randomNumber > 4:
			var coin = coin_scene.instantiate()
			coin.position = Vector2(position.x, position.y)
			get_tree().root.get_node("Level").add_child(coin)
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
		target_velocity.y = Velocity.y
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
	
func lvl_obj_detect(body):
	if body is TileMap and is_on_floor():
		velocity.y = JUMP_VELOCITY
