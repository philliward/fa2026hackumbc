extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Combat.position = Vector2(1000,0)
	$Timeline.position = Vector2(1000,0)
	$Timeline.position = Vector2(1000,0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mainmenu_start_game() -> void:
	$Mainmenu.position = Vector2(1000,0)
	$Combat.position = Vector2(0,0)
	pass # Replace with function body.


func _on_combat_exit() -> void:
	$Combat.position = Vector2(1000,0)
	$Mainmenu.position = Vector2(0,0)
	pass # Replace with function body.


func _on_mainmenu_combat() -> void:
	$Combat.position = Vector2(1000,0)
	$Mainmenu.position = Vector2(0,0)
	$Timeline.position = Vector2(0,0)
	pass # Replace with function body.
