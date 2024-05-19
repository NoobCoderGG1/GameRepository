extends Node

class Weapon:
	func to_copy(icon, name, fire_rate, damage, bullet_speed, status, current_bullet, capacity, cost, description, type, textureSize, bulletTexture):
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
		self.type = type
		self.textureSize = textureSize
		self.bulletTexture = bulletTexture
	
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
	var type #string, тип оружия: ближнего или дальнего боя
	var textureSize #Для размера спрайта оружия
	var bulletTexture
	
	func copy():
		var weapon = Weapon.new()
		weapon.icon = self.icon
		weapon.name = self.name
		weapon.fire_rate = self.fire_rate
		weapon.damage = self.damage
		weapon.bullet_speed = self.bullet_speed
		weapon.status = self.status
		weapon.current_bullet = self.current_bullet
		weapon.capacity = self.capacity
		weapon.cost = self.cost
		weapon.description = self.description
		weapon.type = self.type
		weapon.textureSize = self.textureSize
		weapon.bulletTexture = self.bulletTexture
		return weapon
