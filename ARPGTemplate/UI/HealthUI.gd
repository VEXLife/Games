extends Control


var max_hearts
var hearts setget update_hearts

func _ready():
	max_hearts = PlayerStats.max_health
	update_hearts(PlayerStats.health)
	$HealthEmpty.rect_size.x = max_hearts * 15
	PlayerStats.connect("health_changed", self, "update_hearts")
	
func update_hearts(health):
	hearts = health
	$HealthFull.rect_size.x = hearts * 15
