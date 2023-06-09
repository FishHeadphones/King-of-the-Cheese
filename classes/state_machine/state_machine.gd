extends Node
class_name StateMachine

@export var entity: Entity # Might change into Entity
@export var starting_state: NodePath

var current_state: BaseState


func change_state(new_state: BaseState) -> void:
	if current_state:
		current_state._exit()
	
	current_state = new_state
	current_state._enter()


func _ready() -> void:
	# Assigning entities
	if entity == null:
		printerr("Entity not assigned to StateMachine via @export")
	
	# Trusting that the child are valid states
	for child in get_children():
		var state = child as BaseState
		
		state.entity = entity
		state._ready_state()
		state.force_change_state.connect(on_force_change_state)
		
	
	change_state(get_node(starting_state))


# Pass through functions for the Player to call, handling state changes as needed
func _physics_process(delta: float) -> void:
	var new_state: BaseState = current_state._physics_process_state(delta)
	if new_state:
		change_state(new_state)


func _input(event: InputEvent) -> void:
	var new_state = current_state._input_state(event)
	if new_state:
		change_state(new_state)


func _process(delta: float) -> void:
	var new_state = current_state._process_state(delta)
	if new_state:
		change_state(new_state)


func on_force_change_state(state: BaseState) -> void:
	var new_state: BaseState = state
	if new_state:
		change_state(new_state)
