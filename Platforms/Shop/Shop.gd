extends Control

var virtual_player

func _ready():
	virtual_player = get_tree().root.get_node("main_menu").virtual_player
	$user_money.text = str(virtual_player.player_money)
