extends Area2D

signal reduceHealth

export var area_effect: = 5.0

func _on_body_entered(_body):
	emit_signal("reduceHealth", area_effect)
