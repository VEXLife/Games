extends StaticBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_HurtBox_area_entered(area):
	if area.name == "PlayerHitBox":
		$AnimatedSprite.play("default")


func _on_AnimatedSprite_animation_finished():
	PlayerStats.key_ss += randi() % 3
	PlayerStats.key_ys += randi() % 10
	PlayerStats.coins += randi() % 2
	PlayerStats.jewels += max(randi() % 20 - 18, 0)
	queue_free()
