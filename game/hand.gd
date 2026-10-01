extends Node2D

var cards:Array[Card]

var ring = Vector2(0.127,0.194)
var o:float
var d:float
var theta:Vector2

func move(new:Vector2) -> void:
	ring = new
	o = -((new.x-new.y)*(new.x+new.y)+new.y-0.25)/(2.*new.x)
	theta = Vector2(-atan2(o,-.5+ring.x),-atan2(o,.5-ring.x))
	d = o + ring.y

func _ready() -> void:
	move(Vector2(0.127,0.194))

func _process(_delta: float) -> void:
	var mouse := get_local_mouse_position()/get_viewport_rect().size
	var relative := mouse-Vector2(0.5,1+o)
	var thea := atan2(relative.y,relative.x)
	var v := cards.size()
	var i := 0
	if relative.length()/d > 0.8 and relative.length()/d < 1.3:
		var p := floorf(((thea - theta.x) / (theta.y-theta.x)) * v)
		var an := (1-((p+.5)/v))*theta.x + ((p+.5)/v)*theta.y
		var rang :=Vector2(theta.x*(1-.5/v)+theta.y*(.5/v),theta.x*(.5/v)+theta.y*(1-.5/v))
		var a:=Vector2(rang.x,max(rang.x,an-0.15))
		var b:=Vector2(min(rang.y,an+0.15),rang.y)
		for card in cards:
			if i < int(p):
				var t:float= (i)/p
				cards[i].Move.target = Vector2((1-t)*a.x+t*a.y,0.5)
			elif i > int(p):
				var t:float= (i-p)/(v-p-1)
				cards[i].Move.target = Vector2((1-t)*b.x+t*b.y,0.5)
			else:
				cards[i].Move.target = Vector2(an,0.525)
			i+=1
	else:	
		for card in cards:
			var t:= (i+.5)/v
			card.Move.target = Vector2((theta.x)*(1-t) + theta.y*t,.5)
			i+=1
	pass

func deck(count) -> void:
	
	for card in range(count):
		var c:Card = Player.newcard.instantiate()
		if randf() > 0.8:
			c.assign(2,"bullcard.png",c.type.ADVISOR,c.state.HOVERING,3,-1)
		elif randf() > 0.8:
			c.assign(1,"queenantcard.png",c.type.ADVISOR,c.state.HOVERING,1,-1)
		elif randf() > 0.8:
			c.assign(1,"lioncard.png",c.type.SOLDIER,c.state.HOVERING,1,2)
		elif randf() > 0.8:
			c.assign(1,"lion-b_card.png",c.type.SOLDIER,c.state.HOVERING,2,2)
		elif randf() > 0.8:
			c.assign(1,"ant-b_card.png",c.type.SOLDIER,c.state.HOVERING,1,1)
		else:
			c.assign(1,"ant-c_card.png",c.type.SOLDIER,c.state.HOVERING,1,1)
		
		c.position = Player.fit(Vector2(0.1,0.5))
		c.Move.pos = Vector2(0.1,0.5)
		
		c.Move.set_state(c.Move.State.POLAR,Vector2(0.5,1+o))
		c.Move.vel = Vector2(0,2)
		c.Move.target = Vector2(-PI/2.+0.2,o+ring.y)
		cards.append(c)
		get_parent().add_child(c)
	pass
