extends Button

func _on_gui_input(event):
	if event.is_pressed():
		release_focus()
		get_tree().root.remove_child(get_tree().root.get_node("inventory"))
