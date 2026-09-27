extends Node2D

signal exit

const STARTING_HAND:int = 7

var time: float = 0
var timestamp: float = 0
var deck = []
var drawn = 0
enum state {BEGIN,PLAYER_TURN,PLAYER_TURN_END,ENEMY_TURN,ENEMY_TURN_END}
var current:state = state.BEGIN

var mana = 8

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#deck = Player.deck
	#deck.shuffle()
	current = state.BEGIN
	timestamp = time
	drawn = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta
	var elapsed = time - timestamp
	match current:
		state.BEGIN:
			while drawn < 5 * (elapsed + -1) and drawn < STARTING_HAND:
				drawn+=1
				$Hand.add([1])
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
	$Hand.add([1])
	#exit.emit()
	pass # Replace with function body.


func _on_hand_played_card(card: Card) -> void:
	if card.mana <= mana and Player.space(Rect2(Vector2(0,0),Vector2(1,0.5)),get_global_mouse_position()):
		mana -= card.mana
		$Label.text = str(mana)
		card.transfer($Battlefield)
		$Battlefield.distribute()
	pass # Replace with function body.


func _on_button_2_pressed() -> void:
	if current == state.PLAYER_TURN:
		$Button2.visible = false
		current = state.PLAYER_TURN_END
	pass # Replace with function body.
