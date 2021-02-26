extends Node2D

signal die
signal health_changed(health)
signal item_changed(value, item_name)

export (int) var max_health = 3
var health setget health_changed
var coins = 0 setget coin_changed
var jewels = 0 setget jewel_changed
var key_ss = 0 setget key_s_changed
var key_ys = 0 setget key_y_changed

func health_changed(value):
	health = value
	emit_signal("health_changed", max(value, 0))
	if value <= 0:
		emit_signal("die")

func coin_changed(value):
	coins = value
	emit_signal("item_changed",value,"Coin")
	
func jewel_changed(value):
	jewels = value
	emit_signal("item_changed",value,"Jewel")
	
func key_s_changed(value):
	key_ss = value
	emit_signal("item_changed",value,"Key_S")
	
func key_y_changed(value):
	key_ys = value
	emit_signal("item_changed",value,"Key_Y")

func _ready():
	reset()
	
func reset():
	health = max_health
