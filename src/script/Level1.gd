extends Node2D

onready var user_interface = $UserInterface/UserInterface
onready var player = get_node("Player")
onready var victim = get_node("Victim")

var victim_saved: = false
var Player_Speed 

func _ready():
	Player_Speed = player.speed
	user_interface.setLives(29, 20)
	PlayMovie()

func _on_Enemy_HitPlayer():
	user_interface.EnemyKilledPlayer()

func _on_Player_stuck():
	player.startPositioning($FishingNet.position)
	player.speed = 0

func _on_FishingNet_free():
	player.speed = Player_Speed

func _on_AddExtraTime(extra_life):
	user_interface.AddExtraTime(extra_life, victim_saved)

func _on_PollutedArea_Entered(reduce_life):
	user_interface.ReduceHealthTime(reduce_life, victim_saved)

func _on_Victim_saved():
	victim_saved = true
	user_interface.DisplaySaveMessage("Victim Saved")

func _on_MissionSuccessful():
	if victim_saved:
		EndLevel()
	else:
		user_interface.DisplaySaveMessage("Save Victim")

func _process(_delta):
	user_interface.updateInterface()

func PlayMovie() -> void:
	yield(get_tree().create_timer(2.0), "timeout")
	player.startPositioning($StartPosition.position)
	victim.get_node("Camera2D").current = false
	player.get_node("Camera2D").current = true
	user_interface.show()
	user_interface.startHealthTimer()

func EndLevel() -> void:
	user_interface.stopHealthTimer()
	user_interface.get_node("VictoryInterface").show()
	user_interface.get_node("VictoryInterface").get_node("VictorySound").play()
	get_tree().paused = true
