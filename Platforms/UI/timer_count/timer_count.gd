extends Control

static var time_counter = 0.0
static var min = 0
static var sec = 0
var attempt = false #mutex
@onready var level = $"../.."

func _physics_process(delta):
	if $"../../player".HP <= 0:
		return
	if sec == 3:
		$"../../player/Label".visible = false
	time_counter += delta
	sec = int(time_counter) % 60
	min = int((int(time_counter) % 1000) / 60)
	var textTimer = "%02d" % min+ ":" + "%02d" % sec
	$Label.text = textTimer
	
	if (sec == 1 and attempt):
		attempt = false
	elif min == 5 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif min == 10 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif min == 15 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif min == 20 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
