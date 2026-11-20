class_name Fighter
extends CharacterBody3D

## Combat and movement states for fighters in CLASHX
enum State {
	IDLE,
	MOVING,
	PUNCHING,
	KICKING,
	BLOCKING,
	HIT,
	KNOCKDOWN,
	DEFEATED
}

# ------------------------------------------------------------------------------
# Properties & Configuration
# ------------------------------------------------------------------------------

@export_group("Identity")
@export var player_id: int = 1:
	set(val):
		player_id = val
		sync_components()
@export var fighter_name: String = "Player 1"
@export var accent_color: Color = Color(0.2, 0.5, 1.0)
@export var opponent: CharacterBody3D

@export_group("Movement")
@export var move_speed_x: float = 5.5
@export var move_speed_z: float = 3.2
@export var acceleration: float = 45.0
@export var friction: float = 55.0
@export var gravity: float = 18.0

@export_group("Orientation")
## Facing direction: 1.0 = facing right (+X), -1.0 = facing left (-X)
@export var facing_direction: float = 1.0

## Current combat/movement state
var current_state: State = State.IDLE

# Node references
@onready var visual_root: Node3D = $Visuals
@onready var input_handler: FighterInput = $FighterInput as FighterInput
var anim_player: AnimationPlayer

# ------------------------------------------------------------------------------
# Lifecycle Methods
# ------------------------------------------------------------------------------

func _enter_tree() -> void:
	ensure_node_references()

func _ready() -> void:
	ensure_node_references()
	sync_components()
	play_default_animation()

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	handle_movement(delta)
	move_and_slide()
	update_facing_towards_opponent()

# ------------------------------------------------------------------------------
# Initialization & Setup
# ------------------------------------------------------------------------------

## Ensures references to internal child nodes are bound safely
func ensure_node_references() -> void:
	if visual_root == null:
		visual_root = get_node_or_null("Visuals") as Node3D
	if input_handler == null:
		input_handler = get_node_or_null("FighterInput") as FighterInput
	if anim_player == null and visual_root != null:
		anim_player = visual_root.find_child("AnimationPlayer", true, false) as AnimationPlayer

## Synchronizes fighter components with current player_id and configuration
func sync_components() -> void:
	ensure_node_references()
	if input_handler:
		input_handler.action_prefix = "p" + str(player_id) + "_"

	if opponent == null:
		var parent: Node = get_parent()
		if parent:
			var target_name: String = "Fighter2" if player_id == 1 else "Fighter1"
			opponent = parent.get_node_or_null(target_name) as CharacterBody3D

	apply_accent_color()
	update_facing_visual()

## Loops the default character animation if present on the imported model
func play_default_animation() -> void:
	ensure_node_references()
	if not anim_player:
		return

	var anim_name: String = ""
	if anim_player.has_animation("mixamo_com"):
		anim_name = "mixamo_com"
	elif anim_player.has_animation("Take 001"):
		anim_name = "Take 001"

	if anim_name != "":
		var anim: Animation = anim_player.get_animation(anim_name)
		anim.loop_mode = Animation.LOOP_LINEAR
		anim_player.play(anim_name)

# ------------------------------------------------------------------------------
# Movement & Physics
# ------------------------------------------------------------------------------

## Applies gravity when the fighter is airborne
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	elif velocity.y < 0.0:
		velocity.y = 0.0

## Computes horizontal and depth velocities based on player input
func handle_movement(delta: float) -> void:
	if current_state != State.IDLE and current_state != State.MOVING:
		velocity.x = move_toward(velocity.x, 0.0, friction * delta)
		velocity.z = move_toward(velocity.z, 0.0, friction * delta)
		return

	var input_vec: Vector2 = Vector2.ZERO
	if input_handler:
		input_vec = input_handler.get_movement_vector()

	var target_vx: float = input_vec.x * move_speed_x
	var target_vz: float = input_vec.y * move_speed_z

	# Apply acceleration towards input target or friction to stop
	velocity.x = move_toward(velocity.x, target_vx, (acceleration if absf(target_vx) > 0.01 else friction) * delta)
	velocity.z = move_toward(velocity.z, target_vz, (acceleration if absf(target_vz) > 0.01 else friction) * delta)

	# Update active state based on ground motion
	var speed_sq: float = velocity.x * velocity.x + velocity.z * velocity.z
	current_state = State.MOVING if speed_sq > 0.04 else State.IDLE

# ------------------------------------------------------------------------------
# Orientation & Visuals
# ------------------------------------------------------------------------------

## Automatically adjusts horizontal facing direction towards the opponent
func update_facing_towards_opponent() -> void:
	if is_instance_valid(opponent):
		var dx: float = opponent.global_position.x - global_position.x
		if absf(dx) > 0.1:
			set_facing(signf(dx))

## Sets horizontal facing direction (+1.0 = right, -1.0 = left)
func set_facing(dir: float) -> void:
	if is_zero_approx(dir):
		return
	var new_dir: float = signf(dir)
	if not is_equal_approx(facing_direction, new_dir):
		facing_direction = new_dir
		update_facing_visual()

## Updates visual 3D rotation along Y axis (+X = right, -X = left)
func update_facing_visual() -> void:
	if not visual_root:
		return
	# Native FBX character faces +Z.
	# Rotating +90 deg (PI/2) faces +X; -90 deg (-PI/2) faces -X.
	visual_root.rotation.y = (PI * 0.5) if facing_direction >= 0.0 else (-PI * 0.5)

## Applies player-specific team colors and materials
func apply_accent_color() -> void:
	if not visual_root:
		return

	# Emissive joint / accent material
	var accent_mat: StandardMaterial3D = StandardMaterial3D.new()
	accent_mat.albedo_color = accent_color
	accent_mat.roughness = 0.25
	accent_mat.metallic = 0.4
	accent_mat.emission_enabled = true
	accent_mat.emission = accent_color
	accent_mat.emission_energy_multiplier = 1.0

	var joints_mesh: MeshInstance3D = visual_root.find_child("Beta_Joints", true, false) as MeshInstance3D
	if joints_mesh:
		joints_mesh.set_surface_override_material(0, accent_mat)

	# Metallic tinted surface material
	var surface_mesh: MeshInstance3D = visual_root.find_child("Beta_Surface", true, false) as MeshInstance3D
	if surface_mesh:
		var body_mat: StandardMaterial3D = StandardMaterial3D.new()
		body_mat.albedo_color = Color(0.18, 0.2, 0.24, 1.0).lerp(accent_color, 0.15)
		body_mat.roughness = 0.5
		body_mat.metallic = 0.3
		surface_mesh.set_surface_override_material(0, body_mat)
