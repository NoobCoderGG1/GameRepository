extends Node2D

@onready var timerCount = get_node("UI/timerCount")
var bullets = []
var spawn_positions = [Vector2(0, 0), Vector2(25, -79), Vector2(147, -6), Vector2(179, -50), Vector2(197, -6)]
var enemy_scene = preload("res://Level/Enemy/enemy.tscn")
var coin_scene = preload("res://Level/level_objects/coin.tscn")
var enemies = []

func spawn_timer():
	var index_array = randi() % 5
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_positions[index_array]
	match timerCount.min:
		1:
			enemy.HP += 9 
	add_child(enemy)
	enemies.append(enemy)
	print("Заспавнился")

func _physics_process(delta):
	var player = $player
	for bullet in bullets:
		var cs = bullet.get_child(0)
		var ss = cs.shape
	   # ss.b = Vector2(ss.b.x + delta * player.inventory.find_position(lambda weap: weap.name == bullet.name.split("~")[0].bullet_speed, ss.b.y))
		ss.a = Vector2(ss.b.x - 5, ss.b.y)
