extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().get_center()
	scale = get_viewport_rect().size
	pass # Replace with function body.
