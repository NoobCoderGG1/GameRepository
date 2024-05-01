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
	var vplayer_commonShoot =  get_tree().root.get_node("main_menu").virtual_player
	var indx = player.currentWeaponeIndex
	for bullet in bullets:
		if bullet == null: continue
		var cs = bullet.get_child(0)
		var ss = cs.shape
		var current_bullet = vplayer_commonShoot.player_inventory[indx].name + "~" + str(vplayer_commonShoot.player_inventory[indx].current_bullet)
		var bullet_speed = 5
		for w in player.inventory:
			if w.name == bullet.name.split("~")[0]: #if w.name + "~" + str(w.current_bullet+1) == bullet.name:
				bullet_speed = w.bullet_speed
				break
		ss.b = Vector2(ss.b.x + delta * bullet_speed, ss.b.y)
		ss.a = Vector2(ss.b.x - 5, ss.b.y)
