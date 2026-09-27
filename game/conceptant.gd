extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var s =  get_viewport_rect().size[1]/get_rect().size[1]
	scale = Vector2(s,s)
	position = get_viewport_rect().get_center() + Vector2(-((get_viewport_rect().size[0]/2.)-(s*get_rect().size[0]/2.)),0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var s =  get_viewport_rect().size[1]/get_rect().size[1]
	scale = Vector2(s,s)
	position = get_viewport_rect().get_center() - Vector2(-((get_viewport_rect().size[0]/2.)-(s*get_rect().size[0]/2.)),0)
pass
