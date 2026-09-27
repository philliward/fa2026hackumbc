extends Node2D

signal button_gui_input(event:InputEvent)

@export var text:String = ""

func _ready() -> void:
	$BannerButton/Label.text = text

func _on_banner_button_gui_input(event: InputEvent) -> void:
	button_gui_input.emit(event)
	pass # Replace with function body.
