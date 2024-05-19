extends KinematicBody2D

# Виртуальный игрок
# Все, что тут есть, нужно будет при загрузке карты
# сохранить в реальном игроке
class virtual_player:
	var help_vector = [] # Vector2
	var player_money: int = 200
	var player_inventory = [] # Weapon
	var weapon_count : int = 0 #Сколько оружия игрок набрал в инвенторе
