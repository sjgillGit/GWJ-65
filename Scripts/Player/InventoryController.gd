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
var active_hand: Enums.HandType = Enums.HandType.RIGHT

var backpack: BackpackItem

signal item_picked(hand_type: Enums.HandType, item_code: String)
signal item_dropped(hand_type: Enums.HandType)
signal active_hand_switched()

signal wear_backpack(hand_type: Enums.HandType, item_code: String)
signal take_off_backpack(hand_type: Enums.HandType, backpack_code: String)


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_switch_hand"):
		switch_active_hand() 
	if Input.is_action_just_pressed("ui_drop"):
		drop_item()
	if Input.is_action_just_pressed("ui_wear"):
		wear_item()


func get_active_item() -> ItemBase:
	return left_item if active_hand == Enums.HandType.LEFT else right_item


func wear_item() -> void:
	var item = get_active_item()
	if item != null:
		if item.has_method("wear"):
			set_active_item(null)
			item.wear(self)
			wear_backpack.emit(active_hand, item.code)
			backpack = item
	
	elif backpack != null:
		backpack.take_off(self)
		set_active_item(backpack)
		take_off_backpack.emit(active_hand, backpack.code)
		backpack = null


func pick_item(item: ItemBase) -> void:
	set_active_item(item)
	item.move_item_to_parent(get_active_hand_parent())
	item.freeze_item(true)
	item.set_mesh_tools_layer(true)
	item.position = Vector3.ZERO
	item.rotation = Vector3.ZERO
	item_picked.emit(active_hand, item.code)


func drop_item() -> void:
	var active_item = get_active_item()
	if active_item == null: return
	
	active_item.move_item_to_parent(G.player.get_parent())
	active_item.freeze_item(false)
	active_item.set_mesh_tools_layer(false)
	set_active_item(null)
	
	item_dropped.emit(active_hand)


func get_active_hand_parent() -> Node3D:
	if active_hand == Enums.HandType.LEFT:
		return left_item_parent
	return right_item_parent


func set_active_item(new_item: ItemBase) -> void:
	if active_hand == Enums.HandType.LEFT:
		left_item = new_item
	else:
		right_item = new_item


func switch_active_hand() -> void:
	active_hand = Enums.HandType.LEFT \
		if active_hand == Enums.HandType.RIGHT \
		else Enums.HandType.RIGHT
	
	active_hand_switched.emit()
