extends Node

## In-engine physics test runner for Milestone V0.2

var frame: int = 0
var f1: CharacterBody3D
var f2: CharacterBody3D
var in1: FighterInput
var in2: FighterInput

var initial_f1_pos: Vector3
var initial_f2_pos: Vector3

func _ready() -> void:
	print("--- Running V0.2 In-Engine Physics & Movement Tests ---")
	
	# 1. Verify InputMap Actions
	var required_actions: Array[String] = [
		"p1_move_left", "p1_move_right", "p1_move_forward", "p1_move_backward",
		"p1_punch", "p1_kick", "p1_block",
		"p2_move_left", "p2_move_right", "p2_move_forward", "p2_move_backward",
		"p2_punch", "p2_kick", "p2_block",
		"pause", "restart"
	]
	for action in required_actions:
		assert(InputMap.has_action(action), "FAIL: Missing InputMap action: " + action)
	print("[PASS] All required InputMap actions registered.")

	var main_node: Node = get_parent()
	f1 = main_node.get_node_or_null("Fighter1") as CharacterBody3D
	f2 = main_node.get_node_or_null("Fighter2") as CharacterBody3D
	assert(f1 != null and f2 != null, "FAIL: Fighter nodes not found")

	in1 = f1.get_node_or_null("FighterInput") as FighterInput
	in2 = f2.get_node_or_null("FighterInput") as FighterInput
	assert(in1 != null and in2 != null, "FAIL: FighterInput nodes not found")
	assert(in1.action_prefix == "p1_", "FAIL: Fighter 1 prefix must be p1_")
	assert(in2.action_prefix == "p2_", "FAIL: Fighter 2 prefix must be p2_")
	print("[PASS] Fighter instances and input mappings verified.")

	initial_f1_pos = f1.global_position
	initial_f2_pos = f2.global_position

func _physics_process(_delta: float) -> void:
	frame += 1

	if frame == 2:
		# Test Step 1: Player 1 moves right, Player 2 stays still
		in1.set_override_movement(Vector2(1.0, 0.0))
		in2.set_override_movement(Vector2.ZERO)

	elif frame == 20:
		assert(f1.velocity.x > 0.0, "FAIL: Fighter 1 should have positive X velocity")
		assert(f1.global_position.x > initial_f1_pos.x, "FAIL: Fighter 1 should have moved right")
		assert(is_equal_approx(f2.velocity.x, 0.0), "FAIL: Fighter 2 should be stationary")
		assert(is_equal_approx(f2.global_position.x, initial_f2_pos.x), "FAIL: Fighter 2 position should not change")
		print("[PASS] Independent horizontal movement verified (P1 moved, P2 untouched).")

		# Test Step 2: Player 2 moves forward into depth (-Z)
		in1.set_override_movement(Vector2.ZERO)
		in2.set_override_movement(Vector2(0.0, -1.0))

	elif frame == 40:
		assert(f2.velocity.z < 0.0, "FAIL: Fighter 2 should have negative Z velocity")
		assert(f2.global_position.z < initial_f2_pos.z, "FAIL: Fighter 2 should have moved forward into depth")
		print("[PASS] Depth lane movement (Z axis) verified.")

		# Test Step 3: Deceleration and friction
		in1.clear_override()
		in2.clear_override()

	elif frame == 75:
		assert(absf(f1.velocity.x) < 0.05, "FAIL: Fighter 1 did not stop with friction")
		assert(absf(f2.velocity.z) < 0.05, "FAIL: Fighter 2 did not stop with friction")
		assert(f1.get("current_state") == 0, "FAIL: Fighter 1 should be IDLE")
		assert(f2.get("current_state") == 0, "FAIL: Fighter 2 should be IDLE")
		print("[PASS] Deceleration and transition to IDLE verified.")

		# Test Step 4: Auto-facing when crossing positions
		# Move P1 to X = +5.0 (past P2 at X = 3.0)
		f1.global_position = Vector3(5.0, 0.0, 0.0)

	elif frame == 85:
		assert(f1.get("facing_direction") == -1.0, "FAIL: P1 at X=5 should face -1.0 towards P2 at X=3")
		assert(f2.get("facing_direction") == 1.0, "FAIL: P2 at X=3 should face +1.0 towards P1 at X=5")
		print("[PASS] Dynamic auto-facing orientation verified.")

		# Test Step 5: Arena boundary collision
		# Move P1 towards the right boundary wall at X = 11.5
		f1.global_position = Vector3(10.5, 0.0, 0.0)
		in1.set_override_movement(Vector2(1.0, 0.0))

	elif frame == 120:
		# The wall is at X = 11.5, fighter collision radius is 0.35 -> max center X ~ 11.15
		assert(f1.global_position.x < 11.4, "FAIL: Fighter 1 walked through the arena boundary wall! Pos: " + str(f1.global_position.x))
		assert(f1.global_position.x > 10.5, "FAIL: Fighter 1 did not move towards the wall")
		print("[PASS] Arena boundary collision verified (fighter blocked by wall).")

		print("\nALL V0.2 ACCEPTANCE CRITERIA PASSED IN REAL PHYSICS SIMULATION!")
		get_tree().quit(0)
