extends RayCast3D

#--------------------
# Raycast based interaction
#--------------------

var interaction_hint: Label
var interaction_cross: ColorRect

@onready
var player: Node3D = get_node("../../../")


func _ready():
	var interface_parent = player.interface_parent
	interaction_hint = interface_parent.get_node("InteractionHint")
	interaction_cross = interface_parent.get_node("Cross")


func _process(_delta):
	var item = get_item()
	interaction_cross.visible = item != null
	interaction_hint.visible = item != null
	if item != null:
		interaction_hint.text = item.get_item_name()
		if Input.is_action_just_pressed("ui_interact"):
			item.use()


func get_item() -> ItemBase:
	var item = get_collider()
	return item if item is ItemBase else null
