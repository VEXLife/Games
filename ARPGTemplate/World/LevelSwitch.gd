extends Area2D


export (PackedScene) var DestScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LevelSwitch_body_entered(body):
	if body.name == "Player":
		if DestScene:
			get_tree().change_scene_to(DestScene)
		else:
			var splashScreen = get_tree().current_scene.get_node("HUD/HUD/SplashScreen")
			splashScreen.show_message("恭喜通关！", "重玩", null, splashScreen.RESTART)
