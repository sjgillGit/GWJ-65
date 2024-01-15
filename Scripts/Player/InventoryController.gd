extends Node

#--------------------
# Handles storing and holding items
# Has left and right arm and one slot for backpack (WIP)
#--------------------

class_name Inventory

@onready var left_item_parent: Node3D = get_node("../CameraController/Camera/LeftItemParent")
@onready var right_item_parent: Node3D = get_node("../CameraController/Camera/RightItemParent")

var left_item: ItemBase
var right_item: ItemBase
var active_hand: Enums.HandType = Enums.HandType.LEFT

signal item_picked(hand_type: Enums.HandType, item_code: String)
signal item_dropped(hand_type: Enums.HandType)
signal active_hand_switched()


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_switch_hand"):
		switch_active_hand() 
	if Input.is_action_just_pressed("ui_drop"):
		drop_item()


func get_active_item() -> String:
	var active_item = left_item if active_hand == Enums.HandType.LEFT else right_item
	return active_item.code if active_item != null else ""


func pick_item(item: ItemBase) -> void:
	if active_hand == Enums.HandType.LEFT:
		left_item = item
		move_item_to_parent(left_item, left_item_parent, true)
	else:
		right_item = item
		move_item_to_parent(right_item, right_item_parent, true)
	
	item_picked.emit(active_hand, item.code)


func drop_item() -> void:
	var new_item_parent = G.player.get_parent()
	
	if active_hand == Enums.HandType.LEFT && left_item != null:
		move_item_to_parent(left_item, new_item_parent, false)		
		left_item = null
		item_dropped.emit(active_hand)
	elif right_item != null:
		move_item_to_parent(right_item, new_item_parent, false)
		right_item = null
		item_dropped.emit(active_hand)


func move_item_to_parent(item, new_parent: Node3D, to_player: bool) -> void:
	var old_position = item.global_position
	var old_rotation = item.global_rotation
	item.get_parent().remove_child(item)
	new_parent.add_child(item)
	item.global_position = old_position
	item.global_rotation = old_rotation
	
	item.freeze = to_player
	item.collision_layer = 0 if to_player else 1
	item.collision_mask = 0 if to_player else 1
	item.set_mesh_tools_layer(to_player)
	
	if to_player:
		item.position = Vector3.ZERO
		item.rotation = Vector3.ZERO


func switch_active_hand() -> void:
	active_hand = Enums.HandType.LEFT \
		if active_hand == Enums.HandType.RIGHT \
		else Enums.HandType.RIGHT
	
	active_hand_switched.emit()
