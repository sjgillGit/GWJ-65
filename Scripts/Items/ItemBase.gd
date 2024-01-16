extends RigidBody3D

#--------------------
# Base class for interactable items
# To create logic for item use
#   extend this class
#--------------------

class_name ItemBase

@export var code: String

func get_interaction_hint() -> String: 
	return Lang.get_item_data(code).name


func interact(tool: String) -> void:
	print("item is used by {tool}!".format({"tool": tool}))
