extends HBoxContainer


export (int) var count = 0

func _ready():
	PlayerStats.connect("item_changed", self, "set_count")

func set_count(value, item_name):
	if item_name != self.name:
		return
	count = value
	$Count.text = str(value)
