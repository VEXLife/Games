extends Node2D

signal no_health
signal health_changed(health)

export (int) var max_health = 1
onready var health setget set_health

func set_health(value):
	health = value
	emit_signal("health_changed", max(value, 0))
	if health <= 0:
		emit_signal("no_health")

func _ready():
	reset()

func reset():
	health = max_health
