extends Control

var virtual_player # Player
var weapon_inventory = [] # Weapon
var shop_weapons = [] # Weapon
var cursor = load("res://UI/Cursor.png")

func _ready():
	Input.set_custom_mouse_cursor(cursor) #Установка курсора
	virtual_player = $virtual_player.virtual_player.new()
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	var tmp_weapon = weapon_class.Weapon.new()
	# Weapon1
	tmp_weapon.icon = "res://UI/assets/Weapons/lazerGun.png"
	tmp_weapon.name = "LazerGun";	tmp_weapon.fire_rate = 200;	tmp_weapon.damage = 14.0; #Weapon1 --> LazerGun переименовал
	tmp_weapon.bullet_speed = 16.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 13
	shop_weapons.append(tmp_weapon)
	#Weapon2
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/diamond_sword.png"
	tmp_weapon.name = "Weapon2";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 20.0;
	tmp_weapon.bullet_speed = 50.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 20
	shop_weapons.append(tmp_weapon)
	#Weapon3
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://icon.svg"
	tmp_weapon.name = "Weapon3";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 100.0;
	tmp_weapon.bullet_speed = 100.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 20
	shop_weapons.append(tmp_weapon)
	#AK-47
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/ak-47.png"
	tmp_weapon.name = "AK-47";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 100.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 20
	shop_weapons.append(tmp_weapon)
