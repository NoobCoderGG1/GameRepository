extends Control

static var time_counter = 50.0
static var min = 0
static var sec = 0
var attempt = false #mutex
@onready var level = $"../.."

func _physics_process(delta):
	time_counter += delta
	sec = int(time_counter) % 60
	min = int((int(time_counter) % 1000) / 60)
	var textTimer = "%02d" % min+ ":" + "%02d" % sec
	$Label.text = textTimer
	
	if sec == 1 and attempt:
		attempt = false
	elif min == 1 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
