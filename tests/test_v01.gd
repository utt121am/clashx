extends SceneTree

## Automated validation test for Milestone V0.1 — Project Foundation

const FighterScript = preload("res://scripts/fighter/fighter.gd")
const FightingCameraScript = preload("res://scripts/camera/fighting_camera.gd")

func _init() -> void:
	print("--- Running V0.1 Foundation Tests ---")
	
	# 1. Load Main Scene
	var main_scene: PackedScene = load("res://scenes/main/main.tscn")
	assert(main_scene != null, "FAIL: Failed to load main scene res://scenes/main/main.tscn")
	var main_node: Node = main_scene.instantiate()
	assert(main_node != null, "FAIL: Failed to instantiate main scene")
	root.add_child(main_node)
	print("[PASS] Main scene loaded and instantiated.")

	# 2. Check Arena
	var arena: Node3D = main_node.get_node_or_null("Arena") as Node3D
	assert(arena != null, "FAIL: Arena node not found in Main scene")
	var floor_node: StaticBody3D = arena.get_node_or_null("Floor") as StaticBody3D
	assert(floor_node != null, "FAIL: Floor node not found in Arena")
	var floor_shape: CollisionShape3D = floor_node.get_node_or_null("CollisionShape3D") as CollisionShape3D
	assert(floor_shape != null, "FAIL: CollisionShape3D missing from Floor")
	var boundaries: StaticBody3D = arena.get_node_or_null("Boundaries") as StaticBody3D
	assert(boundaries != null, "FAIL: Boundaries node not found in Arena")
	print("[PASS] Arena and boundaries verified.")

	# 3. Check Fighters
	var f1: CharacterBody3D = main_node.get_node_or_null("Fighter1") as CharacterBody3D
	var f2: CharacterBody3D = main_node.get_node_or_null("Fighter2") as CharacterBody3D
	assert(f1 != null, "FAIL: Fighter1 not found in Main scene")
	assert(f2 != null, "FAIL: Fighter2 not found in Main scene")
	assert(f1.get_script() == FighterScript, "FAIL: Fighter1 script must be fighter.gd")
	assert(f2.get_script() == FighterScript, "FAIL: Fighter2 script must be fighter.gd")
	assert(f1.get("player_id") == 1, "FAIL: Fighter1 player_id must be 1")
	assert(f2.get("player_id") == 2, "FAIL: Fighter2 player_id must be 2")
	assert(f1.get("facing_direction") == 1.0, "FAIL: Fighter1 must face right (+1.0)")
	assert(f2.get("facing_direction") == -1.0, "FAIL: Fighter2 must face left (-1.0)")
	assert(f1.position.x < f2.position.x, "FAIL: Fighter1 must be positioned to the left of Fighter2")
	print("[PASS] Fighters (P1 & P2) instantiated with correct IDs, positions, and facing directions.")

	# 4. Check Fighter Components
	for f in [f1, f2]:
		var col: CollisionShape3D = f.get_node_or_null("CollisionShape3D") as CollisionShape3D
		assert(col != null, "FAIL: CollisionShape3D missing from Fighter")
		var vis: Node3D = f.get_node_or_null("Visuals") as Node3D
		assert(vis != null, "FAIL: Visuals node missing from Fighter")
	print("[PASS] Fighter collision shapes and visuals confirmed.")

	# 5. Check Fighting Camera
	var cam: Camera3D = main_node.get_node_or_null("FightingCamera") as Camera3D
	assert(cam != null, "FAIL: FightingCamera node not found in Main scene")
	assert(cam.get_script() == FightingCameraScript, "FAIL: FightingCamera script must be fighting_camera.gd")
	assert(cam.get("target1") == f1, "FAIL: Camera target1 must be Fighter1")
	assert(cam.get("target2") == f2, "FAIL: Camera target2 must be Fighter2")
	assert(cam.current == true, "FAIL: Camera must be set as current")
	print("[PASS] FightingCamera verified with target tracking.")

	# 6. Check Lighting and Environment
	var env: WorldEnvironment = main_node.get_node_or_null("WorldEnvironment") as WorldEnvironment
	var sun: DirectionalLight3D = main_node.get_node_or_null("SunLight") as DirectionalLight3D
	assert(env != null, "FAIL: WorldEnvironment missing")
	assert(sun != null, "FAIL: SunLight missing")
	print("[PASS] Lighting and WorldEnvironment verified.")

	print("\nALL V0.1 FOUNDATION ACCEPTANCE CRITERIA PASSED SUCCESSFULLY!")
	quit(0)
