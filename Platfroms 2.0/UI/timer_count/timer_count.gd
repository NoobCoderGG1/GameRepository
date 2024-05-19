extends Control

var time_counter = 0.0
var tmin = 0
var sec = 0
var attempt = false #mutex
var level

func _ready():
	level = $"../.."


func _physics_process(delta):
	if $"../../player".HP <= 0:
		return
	if sec == 4:
		$"../../player/Label".visible = false
		$"../../player/Sprite2D".visible = false
	time_counter += delta
	sec = int(time_counter) % 60
	tmin = int((int(time_counter) % 1000) / 60)
	var textTimer = "%02d" % tmin + ":" + "%02d" % sec
	$Label.text = textTimer
	
	if (sec == 1 and attempt):
		attempt = false
	elif tmin == 5 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif tmin == 10 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif tmin == 15 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
	elif tmin == 20 and sec == 0 and not attempt:
		for enemy in level.enemies:
			enemy.damage *= 2
			enemy.HP += 9.0
		attempt = true
