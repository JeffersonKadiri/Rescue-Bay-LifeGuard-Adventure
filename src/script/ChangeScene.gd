tool
extends Button

export(String, FILE) var next_scene: = "" 

func _on_button_up():
	get_tree().change_scene(next_scene)

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""
