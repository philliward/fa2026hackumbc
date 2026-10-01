class_name Card
extends Node2D

# CARD INFORMATION
var mana:int = 1
var life = -1
var strength = -1

var marked:int = 0

var timestamp = 0
var time = 0

var Move:UIInterpElement = UIInterpElement.new()

signal start_hovering(id)
signal stop_hovering(id)
signal start_clicking(id)
signal stop_clicking(id)

signal marky(delta:int)

enum type {ADVISOR,SOLDIER}
var clas:type = type.SOLDIER

enum state {HOVERING,CLICKING,BATTLEFIELD}
var current:state = state.HOVERING

func assign(m,art,c,s,l,st):
	$Sprite2D.texture = ImageTexture.create_from_image(Image.load_from_file("res://assets/" + art))
	mana = m
	clas = c
	life = l
	current = s
	strength = st
	$Cost.text = str(mana)
	$Health.text = str(life) if life >=0 else ""
	$Strength.text = str(strength) if strength >=0 else ""
	$HealthSprite.visible = life>=0
	$StrengthSprite.visible = strength>=0
	
	$HealthSprite.position[0] = 14 if strength >= 0 else 1
	$Health.position[0] = 11 if strength >= 0 else -2
	
	pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale *= 3

func mark(mark:int):
	marky.emit(marked - mark)
	marked = mark
	$Health.text = str(life) + " " + str(marked)

func mouse_relative() -> Vector2:
	return transform.inverse()*get_local_mouse_position()

func is_mouse_hover() -> bool:
	return Rect2(Vector2(200,300),Vector2(-200,-300)).has_point(mouse_relative())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	position = Player.fit(Move.step(delta))
	pass


func _on_control_mouse_entered() -> void:
	pass

func _on_control_mouse_exited() -> void:
	pass

func pos_to_rad(pos:Vector2) -> Vector2:
	var d = get_viewport_rect().get_center() * Vector2(1,3) - pos
	return Vector2(rad_to_deg(atan2(d[0],d[1])),d.length()/-get_viewport_rect().get_center()[1]/-3*2)

func _on_control_gui_input(event: InputEvent) -> void:
	pass
