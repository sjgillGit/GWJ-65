extends ItemBase

class_name PickableItem

#--------------------
# Class for pickable items
# Player can pick item only with empty hands
# When is in container - invisible but still exists in the world
#--------------------

@onready var mesh: MeshInstance3D = $Mesh

@export var is_in_container: bool


func _ready():
	assert(G.player != null, "please move player up in scene tree")
	if is_in_container:
		call_deferred("hide_item_in_backpack")


func interact(tool: String) -> void:
	if tool != "none": 
		return
	G.player.hands.pick_item(self)


func hide_item_in_backpack() -> void:
	visible = false
	move_item_to_parent(G.player.backpack_items_parent)
	freeze_item(true)


func move_item_to_parent(new_parent: Node) -> void:
	var old_position = global_position
	var old_rotation = global_rotation
	get_parent().remove_child(self)
	new_parent.add_child(self)
	global_position = old_position
	global_rotation = old_rotation


func freeze_item(make_freeze: bool) -> void:
	freeze = make_freeze
	collision_layer = 0 if make_freeze else 1
	collision_mask = 0 if make_freeze else 1


func set_mesh_tools_layer(tools_layer: bool) -> void:
	mesh.layers = 2 if tools_layer else 1
