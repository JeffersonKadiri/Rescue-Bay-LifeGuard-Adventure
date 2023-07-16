extends Area2D

signal AddExtraTime

export var air_capacity: = 10.0

func _on_body_entered(_body):
	emit_signal("AddExtraTime", air_capacity)
	queue_free()
