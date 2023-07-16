extends Area2D

signal saved

func _on_body_entered(body):
	if body.get_name() == "Player":
		queue_free()
		emit_signal("saved")
