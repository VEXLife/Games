extends Node2D

const GrassDeath = preload("res://Effects/GrassDeath.tscn")

func kill_grass():
	var grassDeath = GrassDeath.instance()
	get_parent().add_child(grassDeath)
	grassDeath.global_position = global_position


func _on_kill_grass(area):
	kill_grass()
	queue_free()
