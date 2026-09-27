extends Node2D

var time:float = 0
var timestamp:float = 0

var a:float = 1
var b:float = 1

signal gui_input(event:InputEvent)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var t = clamp(time-timestamp,0,0.25)*4
	var s = t*b+(1-t)*a
	scale = Vector2(s,s)
	pass


func _on_control_mouse_entered() -> void:
	timestamp = time
	a = scale[0]
	b = 1.1
	pass # Replace with function body.


func _on_control_mouse_exited() -> void:
	timestamp = time
	a = scale[0]
	b = 1
	pass # Replace with function body.


func _on_control_gui_input(event: InputEvent) -> void:
	gui_input.emit(event)
	pass # Replace with function body.
