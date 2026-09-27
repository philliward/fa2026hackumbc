extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	pass 


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_mouse_entered():
	$Label.show()
	pass

func _on_mouse_exited():
	$Label.hide()
	pass 
