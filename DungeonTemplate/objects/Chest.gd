extends StaticBody2D


var adjacent = false
var open = false
var locked = true

func _on_PlayerDetectBox_body_entered(body):
	if body.name == "Player":
		adjacent = true


func _on_PlayerDetectBox_body_exited(body):
	if body.name == "Player":
		adjacent = false
		if open:
			$AnimatedSprite.play("backward")

func _process(delta):
	if adjacent:
		if Input.is_action_just_pressed("ui_interact"):
			if locked:
				if "Chest_Y" in self.name and PlayerStats.key_ys > 0:
					PlayerStats.key_ys -= 1
					PlayerStats.coins += randi() % 10 + 5
					PlayerStats.jewels += randi() % 3
					locked = false
				elif "Chest_S" in self.name and PlayerStats.key_ss > 0:
					PlayerStats.key_ss -= 1
					PlayerStats.coins += randi() % 15 + 10
					PlayerStats.jewels += randi() % 5 + 2
					locked = false
				else:
					return
			if open:
				$AnimatedSprite.play("backward")
			else:
				$AnimatedSprite.play("forward")

func switch_open():
	open = not open
