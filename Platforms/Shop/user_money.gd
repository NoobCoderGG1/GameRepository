extends Label

func _ready():
	text = str(get_tree().root.get_node("main_menu").virtual_player.player_money)
