extends Node2D

signal start_game
signal combat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func idk() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	start_game.emit()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	combat.emit()
	pass # Replace with function body.
