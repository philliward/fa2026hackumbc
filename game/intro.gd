extends Node2D

signal exit

func _on_button_pressed() -> void:
	exit.emit()
