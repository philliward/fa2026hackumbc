extends Node2D

signal exit

var time: float = 0
var timestamp: float = 0

enum state {PLAYER_TURN,PLAYER_TURN_END,ENEMY_TURN,ENEMY_TURN_END}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	match state:
		"PLAYER_TURN":
			pass
		"PLAYER_TURN_END":
			pass
		"ENEMY_TURN":
			pass
		"ENEMY_TURN_END":
			pass
	pass



func _on_button_pressed() -> void:
	exit.emit()
	pass # Replace with function body.
