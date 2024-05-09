extends Node

class Weapon:
	func to_copy(icon, name, fire_rate, damage, bullet_speed, status, current_bullet, capacity, cost, description):
		self.icon = icon
		self.name = name
		self.fire_rate = fire_rate
		self.damage = damage
		self.bullet_speed = bullet_speed
		self.status = status
		self.capacity = capacity
		if current_bullet == 0:
			self.current_bullet = capacity
		else:
			self.current_bullet = current_bullet
		self.cost = cost
		self.description = description
	
	var icon # String path
	var name # String
	var fire_rate: int # в миллисекундах
	var damage: float
	var bullet_speed: float
	var status: bool
	var current_bullet: int
	var capacity: int
	var cost: float
	var description # String
	
	func copy():
		var weapon = Weapon.new()
		weapon.to_copy(self.icon, self.name, self.fire_rate, self.damage, self.bullet_speed, self.status, self.current_bullet, self.capacity, self.cost, self.description)
		return weapon
