extends Area2D

signal MissionSuccessful

func _on_body_entered(_body):
	emit_signal("MissionSuccessful")
