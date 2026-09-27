extends Node2D

signal changeval(new:int)
var val = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Container/Label.text = str(val)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _increase() -> void:
	val +=1
	$Container/Label.text = str(val)
	changeval.emit(val)
	pass # Replace with function body.


func _decrease() -> void:
	val -=1
	$Container/Label.text = str(val)
	changeval.emit(val)
	pass # Replace with function body.


func _on_container_mouse_exited() -> void:
	queue_free()
	pass # Replace with function body.
