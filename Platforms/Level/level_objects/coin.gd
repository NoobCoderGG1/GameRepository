extends Area2D


func player_entered(body):
	body.countMoney += 1
	queue_free()
