extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerStats.connect("health_changed", self, "update_hearts")
	update_hearts(PlayerStats.health)
	$HBoxContainer/HP/EmptyHeart/Container.rect_size.x = 8 * PlayerStats.max_health

func update_hearts(health):
	$HBoxContainer/HP/FullHeart/Container.rect_size.x = 8 * health
