extends Node2D

signal exit




const STARTING_HAND:int = 7

var time: float = 0
var timestamp: float = 0
var deck = []
var drawn = 0
enum state {STALL,BEGIN,PLAYER_TURN,PLAYER_TURN_END,ENEMY_TURN,ENEMY_TURN_END}
var current:state = state.STALL


func can_interact() -> bool:
	return current == state.PLAYER_TURN or current == state.ENEMY_TURN_END
	
var mana = 9999

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#deck = Player.deck
	#deck.shuffle()
	current = state.STALL
	timestamp = time
	drawn = 0
	
	pass # Replace with function body.


func enter() -> void:
	current = state.BEGIN
	timestamp = time


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$CombatBackground.position = get_viewport_rect().get_center()
	var sca = get_viewport_rect().size[1]/$CombatBackground.get_rect().size[1]
	$CombatBackground.scale = Vector2(sca,sca)
	time += delta
	var elapsed = time - timestamp
	match current:
		state.BEGIN:
			while drawn < 5 * (elapsed + -1) and drawn < STARTING_HAND:
				drawn+=1
				if drawn == 1: $Hand.add([1])
				else: $Hand.add([0])
				if drawn == STARTING_HAND:
					spawn_monarch()
			if drawn >= STARTING_HAND:
				current = state.PLAYER_TURN
			pass
		state.PLAYER_TURN:
			pass
		state.PLAYER_TURN_END:
			pass
		state.ENEMY_TURN:
			pass
		state.ENEMY_TURN_END:
			pass
	pass



func _on_button_pressed() -> void:
	$Hand.add([0])
	#exit.emit()
	pass # Replace with function body.


func _on_hand_played_card(card: Card) -> void:
	if card.mana <= mana and Player.space(Rect2(Vector2(0,0),Vector2(1,0.5)),get_global_mouse_position()):
		mana -= card.mana
		$Label.text = str(mana)
		if card.clas == card.type.SOLDIER:card.transfer($Battlefield)
		else: card.transfer($Cabinet)
		$Battlefield.distribute()
		$Cabinet.distribute()
	pass # Replace with function body.


func spawn_monarch() -> void:
	var child:Card = Player.newcard.instantiate()
	child.assign(6,"kingbullcard.png",child.type.ADVISOR,child.state.BATTLEFIELD,8,-1)
	child.b = Vector2(0,0)
	child.a = Vector2(0,-200)
	$Cabinet.add_child(child)
	child._process(0)
	pass


func _on_pass_turn_button_button_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if current == state.PLAYER_TURN:
			$PassTurnButton.visible = false
			current = state.PLAYER_TURN_END
	pass # Replace with function body.
