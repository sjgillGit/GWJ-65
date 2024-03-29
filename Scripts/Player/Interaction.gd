extends RayCast3D

#--------------------
# Raycast based interaction
#--------------------

var interaction_hint: Label
var interaction_cross: ColorRect

@onready var player: Player = get_node("../../../")


func _ready() -> void:
	var interface_parent = player.interface_parent
	if interface_parent == null: 
		set_process(false)
		return
	
	interaction_hint = interface_parent.get_node("InteractionHint")
	interaction_cross = interface_parent.get_node("Cross")


func _process(_delta) -> void:
	var item = get_item_to_interact() if player.may_move else null
	interaction_cross.visible = item != null
	interaction_hint.visible = item != null
	if item != null:
		interaction_hint.text = item.get_interaction_hint()
		if Input.is_action_just_pressed("ui_interact"):
			item.interact(get_interaction_tool())
		if Input.is_action_just_pressed("ui_use") && item.has_method("use"):
			item.use(player.hands)


func get_item_to_interact() -> Node3D:
	var item = get_collider()
	if item and item.has_method("get_interaction_hint"):
		return item
	return null


func get_interaction_tool() -> String:
	var item = player.hands.get_active_item()
	return item.code if item != null else "none"


func get_look_at_point() -> Vector3:
	if is_colliding():
		return get_collision_point()
	return to_global(target_position)
