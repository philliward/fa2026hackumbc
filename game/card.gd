class_name Card
extends Node2D

# CARD INFORMATION
var mana:int = 1

var a:Vector2 = Vector2(0,1)
var b:Vector2 = Vector2(0,1)
var timestamp = 0
var time = 0

signal start_hovering
signal stop_hovering
signal start_clicking(id)
signal stop_clicking(id)

enum state {HOVERING,CLICKING,BATTLEFIELD}
var current:state = state.HOVERING

func interp(start,end,t):
	t = max(min(0.5,t),0)*2
	t = t*t*(3-2*t)
	return start*(1-t)+end*t

func freeze():
	a = interp(a,b,time-timestamp)

func set_theta(inp):
	freeze()
	b[0] = inp
	timestamp = time
	pass

func assign(data):
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale *= 3
	$Label.text = str(mana)

func transfer(parent: Node2D) -> void:
	current = state.BATTLEFIELD
	position = get_parent().to_global(position) - parent.position
	a = position
	reparent(parent)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta	
	match current:
		state.HOVERING:
			var center = get_viewport_rect().get_center()
			center[1] *= 3
			var c = interp(a,b,time-timestamp)
			c[0]=deg_to_rad(c[0])
			position = center + (Vector2(sin(c[0]),cos(c[0]))*c[1])*(-center[1]/2)
			pass
		state.CLICKING:
			position = get_global_mouse_position()
			pass
		state.BATTLEFIELD:
			var t = min(1,max(0,(time-timestamp)*2))
			t = t*t*(3-2*t)
			position = a*(1-t)+b*t
			pass
	pass


func _on_control_mouse_entered() -> void:
	if current != state.BATTLEFIELD and time - timestamp > .5:
		freeze()
		start_hovering.emit()
		b[1] = 1.06
		timestamp = time


func _on_control_mouse_exited() -> void:
	if current != state.BATTLEFIELD:
		freeze()
		stop_hovering.emit()
		b[1] = 1.0
		timestamp = time

func pos_to_rad(pos:Vector2) -> Vector2:
	var d = get_viewport_rect().get_center() * Vector2(1,3) - pos
	return Vector2(rad_to_deg(atan2(d[0],d[1])),d.length()/-get_viewport_rect().get_center()[1]/-3*2)

func _on_control_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		match current:
			state.HOVERING:
				start_clicking.emit(get_index())
				current = state.CLICKING
	elif event.is_action_released("click"):
		match current:
			state.CLICKING:
				current=state.HOVERING
				timestamp = time
				a = pos_to_rad(position)
				stop_clicking.emit(get_index())
	pass # Replace with function body.
