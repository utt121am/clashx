class_name FightingCamera
extends Camera3D

## Dedicated side-view fighting camera for CLASHX
## Dynamically frames two fighters and smoothly tracks their position.

@export var target1: Node3D
@export var target2: Node3D

@export_group("Framing")
@export var min_distance: float = 6.0
@export var max_distance: float = 14.0
@export var distance_multiplier: float = 0.85
@export var base_height: float = 1.6
@export var camera_z_offset: float = 6.0
@export var smooth_speed: float = 6.0

@export_group("Bounds")
@export var min_x: float = -12.0
@export var max_x: float = 12.0

func _process(delta: float) -> void:
	if not is_instance_valid(target1) or not is_instance_valid(target2):
		return

	var p1: Vector3 = target1.global_position
	var p2: Vector3 = target2.global_position

	# Calculate horizontal midpoint between fighters, clamped to arena bounds
	var mid_x: float = clampf((p1.x + p2.x) * 0.5, min_x, max_x)
	var mid_y: float = (p1.y + p2.y) * 0.5 + base_height

	# Dynamically zoom in/out based on distance between fighters along X
	var dist_x: float = absf(p1.x - p2.x)
	var target_z: float = clampf(camera_z_offset + dist_x * distance_multiplier, min_distance, max_distance)

	var target_position: Vector3 = Vector3(mid_x, mid_y, target_z)
	global_position = global_position.lerp(target_position, clampf(smooth_speed * delta, 0.0, 1.0))

	# Keep camera focused towards the midpoint on the fighting plane (Z = 0)
	var look_target: Vector3 = Vector3(mid_x, (p1.y + p2.y) * 0.5 + 1.0, 0.0)
	look_at(look_target, Vector3.UP)
