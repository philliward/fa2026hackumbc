extends Node2D

signal exit


var STARTING_HAND:int = 11

var damage:int = 10

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
	$PassTurnButton.visible = false
	$Incoming.visible = false
	
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
				if drawn == 1: $CardZones/Hand.deck(1)
				else: $CardZones/Hand.deck(1)
			if drawn >= STARTING_HAND:
				current = state.PLAYER_TURN
				$PassTurnButton.visible = true
				$PassTurnButton.modulate[3] = 0.
				$Incoming.visible = true
				$Incoming.modulate[3] = 0.
				$Incoming.text = "incoming damage: " + str(damage)
				timestamp = time
			pass
		state.PLAYER_TURN:
			$PassTurnButton.modulate[3] = (4.*clamp(time-timestamp,0,1))
			$Incoming.modulate[3] = (4.*clamp(time-timestamp,0,1))
			pass
		state.PLAYER_TURN_END:
			pass
		state.ENEMY_TURN:
			pass
		state.ENEMY_TURN_END:
			pass
	pass



func _on_button_pressed() -> void:
	$CardZones/Hand.deck(1)
	#exit.emit()
	pass # Replace with function body.


func updatedamage(delta:int) -> void:
	damage += delta
	$Incoming.text = "incoming damage: " + str(damage)


func _on_pass_turn_button_button_gui_input(event: InputEvent) -> void:
	pass # Replace with function body.
