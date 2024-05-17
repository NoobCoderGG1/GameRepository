extends Node2D

@onready var parent = get_parent() #Получение level для рестарта игры
@onready var timerCount = get_node("UI/timerCount") #Подключение таймера начала игры для получения времени
var bullets = []
var spawn_positions = [Vector2(281, 271), Vector2(414, 322), Vector2(570, 177), Vector2(599, 299)
, Vector2(980, 249), Vector2(923, -38), Vector2(571, 69), Vector2(728, 69), Vector2(445, 78), 
Vector2(183, 228), Vector2(1229, 244)] #Список позиций спавна врагов
var slug_scene = preload("res://Level/Enemy/enemy.tscn") 
var boar_scene =  preload("res://Level/Enemy/Boar/boar.tscn") 
var ogre_scene =  preload("res://Level/Enemy/Ogre/ogre.tscn") 
var zombie_scene =  preload("res://Level/Enemy/Zombie/zombie.tscn") 
var gargoyle_scene =  preload("res://Level/Enemy/Gargoyle/gargoyle.tscn") 
var vampire_scene =  preload("res://Level/Enemy/Vampire/vampire.tscn")
var black_knight_scene = preload("res://Level/Enemy/Black_Knight/black_knight.tscn") 
var enemies = []

func spawn_timer(): #Спавн врагов по таймеру
	var enemy
	var boss_enemy
	var random_enemy = randi() % 12
	match random_enemy:
		0,1,2:
			enemy = zombie_scene.instantiate()
		3,4,5:
			enemy = slug_scene.instantiate()
		6,7:
			enemy = gargoyle_scene.instantiate()
		8,9:
			enemy = boar_scene.instantiate()
		10,11:
			enemy = ogre_scene.instantiate()
		12:
			enemy = vampire_scene.instantiate()
	var index_array = randi() % 5
	enemy.position = spawn_positions[index_array]
	match timerCount.min: 
		1: #Если прошла минута, то увеличиваем ХП врагов на 9
			enemy.HP += 9
		5:
			enemy.HP += 20
		10:
			enemy.HP += 40
			enemy.damage += 30
		15:
			enemy.HP += 40
			enemy.damage += 30
	add_child(enemy)
	enemies.append(enemy)
	
	#Добавление босса
	if timerCount.min % 2 == 0 and timerCount.sec == 0:
			boss_enemy = black_knight_scene.instantiate()
			boss_enemy.position = spawn_positions[index_array]
			add_child(boss_enemy)
			enemies.append(boss_enemy)
	
func _physics_process(delta):
	var player = $player
	$UI/PlayerHealthBar.value = player.HP
	for bullet in bullets: #Пробежка по списку выпущенных пуль
		if bullet == null: continue
		var bullet_dir : int = bullet.name.split("^")[1].to_int() #Направление пули
		var bullet_sprite = bullet.get_child(1)
		var cs = bullet.get_child(0)
		var ss = cs.shape
		var bullet_speed
		for w in player.inventory: #Проходимся по инвентарю для проверки, которая устанавливает скорость пули
			if w.name == bullet.name.split("~")[0]:
				bullet_speed = w.bullet_speed
				break
		ss.b = Vector2(ss.b.x + delta * bullet_speed * bullet_dir, ss.b.y)
		ss.a = Vector2(ss.b.x - 5, ss.b.y)
		bullet_sprite.position = Vector2(ss.b.x + delta * bullet_speed * bullet_dir, ss.b.y)

func restartBtn_pressed():
	parent.get_node("main_menu").virtual_player.player_money = parent.get_node("main_menu").virtual_player.player_money + ($player.countMoney * $UI/timerCount.min)
	$player.countMoney = 0
	var inventory = get_tree().root.get_node("main_menu").virtual_player.player_inventory
	for w in inventory:
		if w.name == "Knife":
			inventory.erase(w)
			break
	timerCount.time_counter = 0.0
	parent.remove_child(parent.get_node("Level"))
	parent.add_child(ResourceLoader.load("res://Level/level.tscn").instantiate()) 
	
