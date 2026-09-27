extends Node2D

const c = preload("res://card.tscn")
const m = preload("res://picker.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = get_viewport_rect().get_center() * Vector2(1,0.9)
	pass # Replace with function body.


func start_hover(id:int):
	var p = m.instantiate()
	print(p.name)
	p.val = get_child(id).marked
	get_child(id).add_child(p)
	p.changeval.connect(get_child(id).mark)
	get_child(id).marky.connect(get_parent().updatedamage)
	pass


func connectchildren() -> void:
	for child in get_children():
		child.start_hovering.connect(start_hover)


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
	position = get_viewport_rect().get_center() * Vector2(1,0.9)
	pass
