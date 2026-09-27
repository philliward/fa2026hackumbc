extends Node2D

var del:Vector2 = Vector2(2000,0)

var time:float = 0
var timestamp:float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	snap($Sprite2D,1)
	snap($Sprite2D2,-1)
	$Sprite2D.position -= del
	$Sprite2D.position += del
	pass # Replace with function body.

func snap(sp:Sprite2D,sig:int):
	var s =  get_viewport_rect().size[1]/sp.get_rect().size[1]
	sp.scale = Vector2(s,s)
	sp.position = get_viewport_rect().get_center() + Vector2(sig*(-(get_viewport_rect().size[0]/2.)+(s*sp.get_rect().size[0]/2.)),0)


func smootherstep(t:float):
	t = clamp(t,0,2)
	if t > 1:t = 2-t
	return t*t*t*((6.*t-15.)*t+10.)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	snap($Sprite2D,1)
	snap($Sprite2D2,-1)
	$Sprite2D.position-=(1-smootherstep(time))*del
	$Sprite2D2.position+=(1-smootherstep(time))*del
	$Sprite2D3.position=get_viewport_rect().get_center()
	$Sprite2D3.scale=get_viewport_rect().size
	var grad = $Sprite2D3.texture
	grad.gradient.colors = PackedColorArray([Color(0,0,0,(min(2-time,time)*min(2-time,time)))])
	$Sprite2D3.texture = grad
	if time > 2: free()
	pass
