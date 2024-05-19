extends Node

class Weapon:
	func to_copy(icon, wname, fire_rate, damage, bullet_speed, status, current_bullet, capacity, cost, description, type, textureSize, bulletTexture):
		self.icon = icon
		self.wname = wname
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
	var wname # String
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
		return [self.icon, self.wname, self.fire_rate, self.damage, self.bullet_speed, self.status, self.capacity, self.current_bullet, self.cost, self.description, self.type, self.textureSize, self.bulletTexture]
