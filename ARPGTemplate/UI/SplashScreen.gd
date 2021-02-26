extends Control

onready var audioPlayer = get_node("../UIAudio")

enum {
	RESUME,
	RESTART
}
var buttonAction = RESUME

func _on_Button_pressed():
	get_tree().paused = false
	audioPlayer.stream = load("res://Music and Sounds/Unpause.wav")
	audioPlayer.play()
	self.hide()
	$"../HealthUI".show()
	if buttonAction == RESTART:
		PlayerStats.reset()
		get_tree().change_scene_to(get_node("/root/Global").StartLevel)

func _process(delta):
	if Input.is_action_just_pressed("ui_pause") and not get_tree().paused:
		self.show_message("已暂停。", "继续游戏", "res://Music and Sounds/Pause.wav")

func show_message(prompt, button_caption, music_path = null, button_action = RESUME):
	if music_path:
		audioPlayer.stream = load(music_path)
		audioPlayer.play()
	buttonAction = button_action
	get_tree().paused = true
	self.show()
	$"../HealthUI".hide()
	$Label.text = prompt
	$Button.text = button_caption
