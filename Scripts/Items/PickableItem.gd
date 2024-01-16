extends ItemBase

class_name PickableItem

#--------------------
# Class for pickable items
# Player can pick item only with empty hands
#--------------------

@onready var mesh: MeshInstance3D = $Mesh


func interact(tool: String) -> void:
	if tool != "none": 
		return
	G.player.inventory.pick_item(self)


func move_item_to_parent(new_parent: Node3D) -> void:
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
