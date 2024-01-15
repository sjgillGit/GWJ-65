extends RayCast3D

#--------------------
# Raycast based interaction
#--------------------

var interaction_hint: Label
var interaction_cross: ColorRect

@onready var player: Player = get_node("../../../")


func _ready():
	var interface_parent = player.interface_parent
	if interface_parent == null: 
		set_process(false)
		return
	
	interaction_hint = interface_parent.get_node("InteractionHint")
	interaction_cross = interface_parent.get_node("Cross")


func _process(_delta):
	var item = get_item_to_interact()
	interaction_cross.visible = item != null
	interaction_hint.visible = item != null
	if item != null:
		interaction_hint.text = item.get_interaction_hint()
		if Input.is_action_just_pressed("ui_interact"):
			item.interact(get_interaction_tool())


func get_item_to_interact():
	var item = get_collider()
	if item and item.has_method("get_interaction_hint"):
		return item
	return null


func get_interaction_tool() -> String:
	var item = player.inventory.get_active_item()
	return item.code if item != null else "none"
