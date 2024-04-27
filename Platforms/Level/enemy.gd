extends CharacterBody2D

var SPEED : float = 50.0
var damage : float = 50
var HP = 100
var time
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var delay = 3.0
var lastHit : float = 0.0
#var coin_scene = load("res://coin.tscn")

func _physics_process(delta):
	if HP <= 0:
		#var coin = coin_scene.instance()
		#coin.position = Vector2(position.x, position.y)
		#get_tree().root.add_child(coin)
		#Level.enemies.remove(self) <-- Надо добавить список enemies в скрипт Level
		queue_free()

	var Velocity = velocity
	var target_velocity = Vector2()

	if abs(position.x - get_parent().get_node("player").position.x) > 25 or abs(position.y - get_parent().get_node("player").position.y) > 25:
		if position.x < get_parent().get_node("player").position.x:
			Velocity.x = 1
		else:
			if position.x > get_parent().get_node("player").position.x:
				Velocity.x = -1
		target_velocity.x = Velocity.x * SPEED
	else:
		# Attack bot
		if lastHit <= 0:
			get_parent().get_node("player").HP -= damage
			lastHit = delay
		else:
			lastHit -= delta

	if not is_on_floor():
		target_velocity.y += gravity * delta

	velocity = target_velocity
	move_and_slide()
