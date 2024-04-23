extends CharacterBody2D

# Виртуальный игрок
# Все, что тут есть, нужно будет при загрузке карты
# сохранить в реальном игроке
class Player:
	var help_vector = [] # Vector2
	var player_money: int = 52
	var player_inventory = [] # Weapon
