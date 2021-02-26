extends Node2D


func _ready():
	$Effect.frame=0
	$Effect.play("effect")


func _on_Effect_finished():
	queue_free()
