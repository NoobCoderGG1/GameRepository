extends Control


var virtual_player # Player
var weapon_inventory = [] # Weapon
var shop_weapons = [] # Weapon
var cursor = load("res://UI/Cursor.png")
var weapon_class = ResourceLoader.load("res://Weapon.gd")

func wcopy(item_array):
	var weapon = weapon_class.Weapon.new()
	weapon.icon = item_array[0]
	weapon.wname = item_array[1]
	weapon.fire_rate = item_array[2]
	weapon.damage = item_array[3]
	weapon.bullet_speed = item_array[4]
	weapon.status = item_array[5]
	weapon.capacity = item_array[6]
	weapon.current_bullet = item_array[7]
	weapon.cost = item_array[8]
	weapon.description = item_array[9]
	weapon.type = item_array[10]
	weapon.textureSize = item_array[11]
	weapon.bulletTexture = item_array[12]
	return weapon

func _ready():
	Input.set_custom_mouse_cursor(cursor) #Установка курсора
	virtual_player = $virtual_player.virtual_player.new()
	var tmp_weapon = weapon_class.Weapon.new()
	# LazerPistol
	tmp_weapon.icon = "res://UI/assets/Weapons/LazerPistol.png"
	tmp_weapon.wname = "LazerGun";	tmp_weapon.fire_rate = 200;	tmp_weapon.damage = 14.0;
	tmp_weapon.bullet_speed = 600.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 25
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 23
	tmp_weapon.type = "lazer"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/lazer.png"
	shop_weapons.append(tmp_weapon)
	#diamond_sword
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/diamond_sword.png"
	tmp_weapon.wname = "Diamond Sword";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 80.0;
	tmp_weapon.bullet_speed = 50.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 45
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.65,0.70);
	shop_weapons.append(tmp_weapon)
	#LazerGun
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/LaserGun.png"
	tmp_weapon.wname = "DragonFire";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 100.0;
	tmp_weapon.bullet_speed = 100.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 95
	tmp_weapon.type = "lazer"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Bow
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Bow.png"
	tmp_weapon.wname = "Bow";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 25.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 15
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 15
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#AK-47
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/ak-47.png"
	tmp_weapon.wname = "AK-47";	tmp_weapon.fire_rate = 50;	tmp_weapon.damage = 49.0;
	tmp_weapon.bullet_speed = 500.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 30
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 73
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(1,1);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Carrot
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Carrot.png"
	tmp_weapon.wname = "Carrot";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 5.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 5
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#ClawHammer
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/ClawHammer.png"
	tmp_weapon.wname = "Claw Hammer";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 25.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 15
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Club
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Club.png"
	tmp_weapon.wname = "Club";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 33.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 20
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Mosina
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Mosina.png"
	tmp_weapon.wname = "Mosina";	tmp_weapon.fire_rate = 500;	tmp_weapon.damage = 100.0;
	tmp_weapon.bullet_speed = 845.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 5
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 68
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(1,1);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Revolver
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Revolver.png"
	tmp_weapon.wname = "Revolver";	tmp_weapon.fire_rate = 450;	tmp_weapon.damage = 75.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 6
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 50
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Rock
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Rock.png"
	tmp_weapon.wname = "Rock";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 12.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 7
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Spear
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Spear.png"
	tmp_weapon.wname = "Spear";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 15.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 9
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#Stick
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/Stick.png"
	tmp_weapon.wname = "Stick";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 50.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 53
	tmp_weapon.type = "lazer"; tmp_weapon.textureSize = Vector2(0.379,0.344);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/lazer.png"
	shop_weapons.append(tmp_weapon)
	#StoneHammer
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/StoneHammer.png"
	tmp_weapon.wname = "Stone Hammer";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 49.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 32
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(1,1);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#StoneSword
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/StoneSword.png"
	tmp_weapon.wname = "Stone Sword";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 19.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 18
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#WoodenHammer
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/WoodenHammer.png"
	tmp_weapon.wname = "Wooden Hammer";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 16.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 16
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(1,1);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#WoodenPistol
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/WoodenPistol.png"
	tmp_weapon.wname = "Wooden Pistol";	tmp_weapon.fire_rate = 400;	tmp_weapon.damage = 18.0;
	tmp_weapon.bullet_speed = 150.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 12
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 11
	tmp_weapon.type = "ranged"; tmp_weapon.textureSize = Vector2(0.375,0.333);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)
	#WoodenSword
	tmp_weapon = weapon_class.Weapon.new()
	tmp_weapon.icon = "res://UI/assets/Weapons/WoodenSword.png"
	tmp_weapon.wname = "Wooden Sword";	tmp_weapon.fire_rate = 300;	tmp_weapon.damage = 14.0;
	tmp_weapon.bullet_speed = 400.0;	tmp_weapon.status = false;	tmp_weapon.capacity = 1
	tmp_weapon.current_bullet = tmp_weapon.capacity;			tmp_weapon.cost = 8
	tmp_weapon.type = "melee"; tmp_weapon.textureSize = Vector2(0.65,0.6);
	tmp_weapon.bulletTexture = "res://UI/assets/Weapons/Bullets/gold_bullet.png"
	shop_weapons.append(tmp_weapon)


