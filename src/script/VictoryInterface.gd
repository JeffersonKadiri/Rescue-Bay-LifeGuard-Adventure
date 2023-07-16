tool
extends Control

export var next_scene: PackedScene

const WIN_MESSAGE: Array = ["Mission was a Success", "Level Cleared! Good Job", "You are a hero!!!"]

func _ready():
	randomize()
	$Label.text = WIN_MESSAGE[randi() % WIN_MESSAGE.size()]

func _on_button_up():
	get_tree().paused = false
	get_tree().change_scene_to(next_scene)

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""
