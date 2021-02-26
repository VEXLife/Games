extends Node2D

export (String) var level_info = "关卡名字"
const HitEffect = preload("res://Effects/HitEffect.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var pos_x = $Background.position.x
	var pos_y = $Background.position.y
	if $Background.centered:
		pos_x -= $Background.region_rect.size.x / 2
		pos_y -= $Background.region_rect.size.y / 2
	$Camera2D.limit_left = pos_x
	$Camera2D.limit_top = pos_y
	$Camera2D.limit_right = pos_x + $Background.region_rect.size.x
	$Camera2D.limit_bottom = pos_y + $Background.region_rect.size.y
	$HUD/HUD/SplashScreen.show_message(level_info, "开始游戏")
	randomize()


func _on_Player_die():
	$PlayerDeathAudio.play()
	$HUD/HUD/SplashScreen.show_message("你死了！", "重来", null, $HUD/HUD/SplashScreen.RESTART)
