extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Combat.visible = false
	$Mainmenu.visible = true
	$Timeline.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mainmenu_start_game() -> void:
	$Mainmenu.visible = false
	$Combat.visible = true
	pass # Replace with function body.


func _on_combat_exit() -> void:
	pass # Replace with function body.


func _on_mainmenu_combat() -> void:
	pass # Replace with function body.
