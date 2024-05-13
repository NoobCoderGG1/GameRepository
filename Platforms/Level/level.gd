extends Node2D

@onready var timerCount = get_node("UI/timerCount") #Подключение таймера начала игры для получения времени
var bullets = []
var spawn_positions = [Vector2(30, -9), Vector2(39, -9), Vector2(46, -17), Vector2(57, -10), Vector2(11, -13)] #Список позиций спавна врагов
var enemy_scene = preload("res://Level/Enemy/enemy.tscn") 
var coin_scene = preload("res://Level/level_objects/coin.tscn")
var enemies = []

func spawn_timer(): #Спавн врагов по таймеру
	var index_array = randi() % 5
	var enemy = enemy_scene.instantiate()
	enemy.position = spawn_positions[index_array]
	match timerCount.min: 
		1: #Если прошла минута, то увеличиваем ХП врагов на 9
			enemy.HP += 9 
	add_child(enemy)
	enemies.append(enemy)
	
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
