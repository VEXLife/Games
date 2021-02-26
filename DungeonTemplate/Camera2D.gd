extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	limit_left = $TopLeft.global_position.x
	limit_top = $TopLeft.global_position.y
	limit_right = $BottomRight.global_position.x
	limit_bottom = $BottomRight.global_position.y


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
