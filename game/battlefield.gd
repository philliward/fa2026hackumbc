extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().get_center() * Vector2(1,0.85)
	pass # Replace with function body.

func distribute() -> void:
	var i = -0.5
	var v = get_child_count()
	for child:Card in get_children():
		i+=1
		child._process(0)
		child.a = child.position
		child.b = ((i/v)-.5)*Vector2(get_viewport_rect().size[0]*0.8,0)
		child.timestamp = child.time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = get_viewport_rect().get_center() * Vector2(1,0.85)
	pass
