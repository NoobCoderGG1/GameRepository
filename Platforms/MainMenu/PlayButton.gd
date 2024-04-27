extends Control

func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		var level: Node = ResourceLoader.load("res://Level/level.tscn").instantiate()
		get_tree().root.add_child(level)

