class_name FighterInput
extends Node

## Handles input detection for a fighter using configurable action prefixes
@export var action_prefix: String = "p1_"

## Optional input override for automated testing and AI control
var override_movement: Vector2 = Vector2.ZERO
var use_override: bool = false

func _ready() -> void:
	sync_with_parent()

## Automatically sync action prefix with parent fighter's player_id
func sync_with_parent() -> void:
	var parent: Node = get_parent()
	if parent and "player_id" in parent:
		action_prefix = "p" + str(parent.get("player_id")) + "_"

## Returns movement vector: x = horizontal (-1 left, +1 right), y = depth (-1 forward, +1 backward)
func get_movement_vector() -> Vector2:
	if use_override:
		return override_movement

	var left_action: String = action_prefix + "move_left"
	var right_action: String = action_prefix + "move_right"
	var forward_action: String = action_prefix + "move_forward"
	var backward_action: String = action_prefix + "move_backward"

	var input_x: float = Input.get_axis(left_action, right_action)
	var input_z: float = Input.get_axis(forward_action, backward_action)

	return Vector2(input_x, input_z)

## Injects movement vector for testing or programmatic control
func set_override_movement(movement: Vector2) -> void:
	use_override = true
	override_movement = movement

## Clears testing override and restores keyboard input
func clear_override() -> void:
	use_override = false
	override_movement = Vector2.ZERO
