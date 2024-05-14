extends Area2D

var is_fall = true

func player_entered(body):
	if body is CharacterBody2D:
		body.countMoney += 1
		queue_free()
	if body is TileMap or body is StaticBody2D:
		is_fall = false
	
func _physics_process(delta):
		if is_fall:
			position.y += gravity * 0.0005
