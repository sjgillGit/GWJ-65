extends ItemBase

#--------------------
# Class for pickable items
# Player can pick item only with empty hands
#--------------------

@onready var mesh: MeshInstance3D = $Mesh


func interact(tool: String) -> void:
	if tool != "none": 
		return
	G.player.inventory.pick_item(self)


func set_mesh_tools_layer(tools_layer: bool) -> void:
	mesh.layers = 2 if tools_layer else 1
