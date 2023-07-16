extends Area2D

signal stuck
signal free

func _on_body_entered(_body):
	$StuckTimer.start()
	emit_signal("stuck")

func _on_StuckTimer_timeout():
	emit_signal("free")
	$AnimationPlayer.play("fade_out")
