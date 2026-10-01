class_name UIInterpElement extends RefCounted

var target:Vector2 = Vector2(0,0)
var vel:Vector2 = Vector2(0,0)
var pos:Vector2 = Vector2(0,0)
var origin:Vector2 = Vector2(0,0)

var omega:float = 7

enum State {POLAR,XY}
var state:State = State.XY

# implicit origin at 0,0
func xy_to_polar(xy:Vector2) -> Vector2:
	return Vector2(atan2(xy.y,xy.x),xy.length())

func polar_to_xy(polar:Vector2) -> Vector2:
	return unit(polar.x)*polar.y

func unit(theta:float) -> Vector2:
	return Vector2(cos(theta),sin(theta))

func set_state(new:State,new_origin:Vector2 = Vector2(INF,INF)) -> void:
	match state:
		State.POLAR:
			var u:=unit(pos.x)
			vel = u*vel.y+Vector2(-u.y,u.x)*vel.x*pos.y
			pos = polar_to_xy(pos) + origin
	
	match new:
		State.POLAR:
			origin = new_origin if new_origin != Vector2(INF,INF) else origin
			pos = xy_to_polar(pos-origin)
			var u:=unit(pos.x)
			var v:=Vector2(-u.y,u.x)
			vel = Vector2(vel.dot(v),vel.dot(u))
	state = new

func get_pos() -> Vector2:
	match state:
		State.POLAR:
			return origin+polar_to_xy(pos)
		State.XY:
			return pos
	return Vector2(0,0)

# critically damped spring used for interpolation
func step(delta:float) -> Vector2:
	var x = pos-target
	var e = exp(-omega*delta)
	var d = vel + omega*x
	pos = target + (x + delta * d) * e
	vel = (vel - delta * omega * d) * e
	return get_pos()
