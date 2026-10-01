extends Node2D

var time:float
var timestamp:float

enum State {RESTING,TO_COMBAT,TO_INTRO}
var state:State = State.RESTING
var to:int
const curtains = preload("res://curtains.tscn")

var scenes:Array[Node2D]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes = [$Combat,$Mainmenu,$Intro]
	for scene in scenes:
		scene.visible = false

	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	$Mainmenu.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	match state:
		State.TO_INTRO:
			$Mainmenu.find_child("MenuMusic").volume_linear = clamp(1-(time - timestamp),0,1)
			if time - timestamp > 1:
				state = State.RESTING
				$Mainmenu.visible = false
				$Intro.visible = true
				#$Combat.find_child("FightMusic").play()
				$Mainmenu.find_child("MenuMusic").stop()
		State.TO_COMBAT:
			$Combat.find_child("FightMusic").volume_linear = clamp(time - timestamp,0,1)
			if time - timestamp > 1:
				state = State.RESTING
				$Intro.visible = false
				$Combat.visible = true
				$Combat.enter()
				#$Combat.find_child("FightMusic").play()
				$Mainmenu.find_child("MenuMusic").stop()
	pass



func _on_mainmenu_start_game() -> void:
	timestamp = time
	state = State.TO_INTRO
	add_child(curtains.instantiate())
	pass # Replace with function body.


func _on_combat_exit() -> void:
	pass # Replace with function body.


func _on_mainmenu_combat() -> void:
	pass # Replace with function body.


func _on_intro_exit() -> void:
	timestamp = time
	state = State.TO_COMBAT
	add_child(curtains.instantiate())
	pass # Replace with function body.
