extends Node2D

const new = preload("res://card.tscn")

signal played_card(card:Card)

enum state {HOVERING,CLICKING}
var current:state = state.HOVERING
var ch

func _process(delta: float) -> void:
	match current:
		state.CLICKING:
			var d = (get_viewport_rect().get_center() * Vector2(1,3) - get_child(ch).position)
			var a = rad_to_deg(atan2(d[0],d[1]))
			var s = (20./get_child_count())
			for child in get_children():
				if child.get_index() != ch: 
					var e = Vector2(child.b[0]-s,child.b[0]+s)
					if a > e[0] and a < e[1]:
						child.freeze()
						var t = child.b
						child.b = get_child(ch).b
						get_child(ch).b = t
						
						
						get_child(ch).timestamp = get_child(ch).time
						child.timestamp = child.time
	pass
	
func click_card(id) -> void:
	match current:
		state.HOVERING:
			current = state.CLICKING
			ch = id
	pass

func release_card(id) -> void:
	match current:
		state.CLICKING:
			current = state.HOVERING
			ch = id
			if get_parent().can_interact():
				played_card.emit(get_child(id))
			add([])
	pass

func add(cards) -> void:
	for card in cards:
		var c:Card = new.instantiate()
		if card == 1:
			c.assign(3,"kingbullcard.png",c.type.ADVISOR)
		elif randf() > 0.5:
			c.assign(2,"bullcard.png",c.type.ADVISOR)
		else:
			c.assign(1,"queenantcard.png",c.type.SOLDIER)
		c.start_clicking.connect(click_card)
		c.stop_clicking.connect(release_card)
		c.b = Vector2(40,1.2)
		c.a = c.b
		c.b[1] = 1
		add_child(c)
		c._process(0)
	var r:float = get_child_count()
	var i = -0.5
	for child:Card in get_children():
		i+=1.0
		child.set_theta(((i/r)-0.5)*80)
	pass
