extends Node2D

var time:float
var timestamp:float

enum state {NULL,TO_COMBAT}
var current:state = state.NULL
var to:int
const curtains = preload("res://curtains.tscn")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Combat.visible = false
	$Mainmenu.visible = true
	$Timeline.visible = false
	DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	match current:
		state.TO_COMBAT:
			$Mainmenu.find_child("MenuMusic").volume_linear = clamp(1-(time - timestamp),0,1)
			$Combat.find_child("FightMusic").volume_linear = clamp(time - timestamp,0,1)
			if time - timestamp > 1:
				current = state.NULL
				$Mainmenu.visible = false
				$Combat.visible = true
				$Combat.enter()
				#$Combat.find_child("FightMusic").play()
				$Mainmenu.find_child("MenuMusic").stop()
	pass



func _on_mainmenu_start_game() -> void:
	timestamp = time
	current = state.TO_COMBAT
	add_child(curtains.instantiate())
	pass # Replace with function body.


func _on_combat_exit() -> void:
	pass # Replace with function body.


func _on_mainmenu_combat() -> void:
	pass # Replace with function body.
