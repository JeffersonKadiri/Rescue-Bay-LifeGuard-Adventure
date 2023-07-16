extends Control

onready var player_status = get_node("PlayerStatus")
onready var victim_status = get_node("VictimStatus")
onready var player_timer = get_node("PlayerStatus/HealthTime")
onready var victim_timer = get_node("VictimStatus/HealthTime")
onready var pause_title: Label = get_node("PauseOverlay/Label")
onready var pause_overlay: = get_node("PauseOverlay")
onready var scene_tree: = get_tree()
onready var save_timer: = get_node("SaveTimer")

const PLAYER_DIED_MESSAGE: = "Player Drowned"
const VICTIM_DIED_MESSAGE: = "Victim Drowned"
const ENEMY_KILL_MESSAGE: = "Enemy Killed You"

var paused: = false setget set_paused
var isLevelPassed: = false

func _ready():
	setNames()

func EnemyKilledPlayer():
	$EnemyKill.play()
	GameOver(ENEMY_KILL_MESSAGE)

func _on_Player_gameover():
	GameOver(PLAYER_DIED_MESSAGE)

func _on_Victim_gameover():
	GameOver(VICTIM_DIED_MESSAGE)

func GameOver(text: String) -> void:
	self.paused = true
	pause_title.text = text

func setNames() -> void:
	player_status.get_node("VBoxContainer/Name").text = "Player"
	victim_status.get_node("VBoxContainer/Name").text = "Victim"

func setLives(player: float, victim: float) -> void:
	player_status.setHealthTime(player)
	victim_status.setHealthTime(victim)

func startHealthTimer() -> void:
	player_timer.start()
	victim_timer.start()

func stopHealthTimer() -> void:
	player_timer.stop()
	victim_timer.stop()
	isLevelPassed = not isLevelPassed

func updateInterface() -> void:
	player_status.update_interface()
	victim_status.update_interface()

func AddExtraTime(extra_air: float, victim_saved: bool):
	player_status.ChangeHealthTime(extra_air)
	if victim_saved:
		victim_status.ChangeHealthTime(extra_air)

func ReduceHealthTime(air_damage: float, victim_saved: bool):
	player_status.ChangeHealthTime(-air_damage)
	if victim_saved:
		victim_status.ChangeHealthTime(-air_damage)

func _unhandled_input(event):
	if event.is_action_pressed("pause") and GameOverDisplayed():
		self.paused = not paused
		scene_tree.set_input_as_handled()

func GameOverDisplayed() -> bool:
	return !isLevelPassed and pause_title.text != PLAYER_DIED_MESSAGE and pause_title.text != VICTIM_DIED_MESSAGE and pause_title.text != ENEMY_KILL_MESSAGE

func set_paused(value: bool) -> void:
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value
	pauseStatusTimer(value)

func pauseStatusTimer(value: bool) -> void:
	player_timer.paused = value
	victim_timer.paused = value

func DisplaySaveMessage(message) -> void:
	save_timer.get_node("saveVictim").text = message
	save_timer.start()
	save_timer.get_node("saveVictim").show()

func _on_SaveTimer_timeout():
	save_timer.get_node("saveVictim").hide()
