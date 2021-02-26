extends Node2D


export (int) var damage = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HitBox_area_entered(area):
	if area.name == "PlayerHurtBox":
		PlayerStats.health -= damage
		get_tree().current_scene.get_node("Player").hurt_anim()
