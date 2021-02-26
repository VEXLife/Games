extends Node2D


func _on_PlayerDetectZone_body_entered(body):
	if body.name == "Player":
		PlayerStats.coins += 1
		queue_free()
