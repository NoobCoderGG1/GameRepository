extends Control

var virtual_player # Player
var weapon_inventory = [] # Weapon
var shop_weapons = [] # Weapon

func _ready():
	virtual_player = $virtual_player.Player.new()
	var weapon_class = ResourceLoader.load("res://Weapon.gd")
	var tmp_weapon = weapon_class.Weapon.new()
	# Weapon1
	tmp_weapon.name = "LazerGun";	tmp_weapon.fire_rate = 200;	tmp_weapon.damage = 14.0; #Weapon1 --> LazerGun переименовал
	tmp_weapon.bullet_speed = 16.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 13
	shop_weapons.append(tmp_weapon)
	#Weapon2
	tmp_weapon = weapon_class.Weapon.new()
	
	tmp_weapon.name = "Weapon2";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 20.0;
	tmp_weapon.bullet_speed = 10.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 20
	shop_weapons.append(tmp_weapon)
