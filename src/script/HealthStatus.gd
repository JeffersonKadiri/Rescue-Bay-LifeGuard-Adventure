extends HBoxContainer

signal gameover

onready var health_timer: Timer = get_node("HealthTime")

func setHealthTime(time: float) -> void:
	health_timer.set_wait_time(time)

func time_left_to_live() -> Array:
	var time_left = health_timer.time_left
	var minutes = floor(time_left / 60)
	var seconds = int(time_left) % 60
	return [minutes, seconds]

func update_interface() -> void:
	$VBoxContainer/TimeLeft.text = "%02d:%02d" % time_left_to_live()

func ChangeHealthTime(extra_time: float) -> void:
	var time_left = health_timer.time_left
	health_timer.stop()
	setHealthTime(time_left + extra_time)
	health_timer.start()

func _on_timeout():
	$DeathSound.play()
	emit_signal("gameover")
