extends Node2D


export (PackedScene) var StartLevel
var current_scene = null

func _ready():
	call_deferred("init_game")

func init_game():
	current_scene = StartLevel.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

func change_scene_to(target):
	call_deferred("_deffered_change_scene_to", target)
	
func _deffered_change_scene_to(target):
	current_scene.free()
	current_scene = target.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)
