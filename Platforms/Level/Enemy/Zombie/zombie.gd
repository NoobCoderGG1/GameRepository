extends Enemy

func _on_ready():
	SPEED = 30
	damage = 25
	HP = 100
	delay = 5.0
	lastHit = 0.0
	gravity = 10000
	animation = $enemySprite

