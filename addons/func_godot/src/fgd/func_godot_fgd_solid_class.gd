@tool
## FGD SolidClass entity definition, used to define brush entities.
## A [MeshInstance3D] will be generated by FuncGodotMap according to this definition's Visual Build settings. If FuncGodotFGDSolidClass [member node_class] inherits [CollisionObject3D] then one or more [CollisionShape3D] nodes will be generated according to Collision Build settings.
class_name FuncGodotFGDSolidClass
extends FuncGodotFGDEntityClass

enum SpawnType {
	WORLDSPAWN = 0, ## Is worldspawn
	MERGE_WORLDSPAWN = 1, ## Should be combined with worldspawn
	ENTITY = 2, ## Is its own separate entity
}

enum OriginType {
	AVERAGED = 0, ## Use averaged brush vertices for positioning. This is the old Qodot behavior.
	ABSOLUTE = 1, ## Use origin property in global coordinates as the position center.
	RELATIVE = 2, ## Calculate position center using origin as an offset to the entity's bounding box center.
	BRUSH = 3, ## Use origin based on the center of the brushes which have the special 'origin' texture.
	BOUNDS_CENTER = 4, ## Use the center of the entity's bounding box for position center. This is the default option and recommended for most entities.
	BOUNDS_MINS = 5, ## Use the lowest bounding box coordinates for position center. This is standard Quake and Half-Life brush entity behavior.
	BOUNDS_MAXS = 6, ## Use the highest bounding box coordinates for position center.
}

enum CollisionShapeType {
	NONE, ## No collision shape is built. Useful for decorative geometry like vines, hanging wires, grass, etc...
	CONVEX, ## Will build a Convex CollisionShape3D for each brush used to make this Solid Class. Required for non-[StaticBody3D] nodes like [Area3D].
	CONCAVE ## Should have a concave collision shape
}

## Controls whether this Solid Class is the worldspawn, is combined with the worldspawn, or is spawned as its own free-standing entity.
@export var spawn_type: SpawnType = SpawnType.ENTITY
## Controls how this Solid Class utilizes the `origin` key value pair to find its position.
@export var origin_type: OriginType = OriginType.BOUNDS_CENTER

@export_group("Visual Build")
## Controls whether a [MeshInstance3D] is built for this Solid Class.
@export var build_visuals : bool = true
## Sets generated [MeshInstance3D] to be available for UV2 unwrapping after [FuncGodotMap] build. Utilized in baked lightmapping.
@export var use_in_baked_light : bool = true
## Shadow casting setting allows for further lightmapping customization.
@export var shadow_casting_setting : GeometryInstance3D.ShadowCastingSetting = GeometryInstance3D.SHADOW_CASTING_SETTING_ON
## Automatically build [OccluderInstance3D] for this entity.
@export var build_occlusion : bool = false
## This Solid Class' [MeshInstance3D] will only be visible for [Camera3D]s whose cull mask includes any of these render layers.
@export_flags_3d_render var render_layers: int = 1

@export_group("Collision Build")
## Controls how collisions are built for this Solid Class.
@export var collision_shape_type: CollisionShapeType = CollisionShapeType.CONVEX
## The physics layers this Solid Class can be detected in.
@export_flags_3d_physics var collision_layer: int = 1
## The physics layers this Solid Class scans.
@export_flags_3d_physics var collision_mask: int = 1
## The priority used to solve colliding when penetration occurs. The higher the priority is, the lower the penetration into the Solid Class will be. This can for example be used to prevent the player from breaking through the boundaries of a level.
@export var collision_priority: float = 1.0
## The collision margin for the Solid Class' collision shapes. Not used in Godot Physics. See [Shape3D] for details.
@export var collision_shape_margin: float = 0.04

@export_group("Scripting")
## An optional script file to attach to the node generated on map build.
@export var script_class: Script

func _init():
	prefix = "@SolidClass"
