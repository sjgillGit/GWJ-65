extends Node

#--------------------
# Handles storing and holding items
# Has left and right arm
#--------------------

class_name HandsController

@onready var left_item_parent: Node3D = get_node("../CameraController/Camera/LeftItemParent")
@onready var right_item_parent: Node3D = get_node("../CameraController/Camera/RightItemParent")

@onready var backpack_controller: BackpackController = get_node("../BackpackController")

var left_item: PickableItem
var right_item: PickableItem
var active_hand: Enums.HandType = Enums.HandType.RIGHT

var may_use_hands: bool = true

signal item_picked(item_code: String)
signal item_dropped()
signal active_hand_switched()



func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_use"):
		use_item()
	if Input.is_action_just_pressed("ui_drop"):
		drop_item()
	if may_use_hands:
		if Input.is_action_just_pressed("ui_switch_hand"):
			switch_active_hand() 
		if Input.is_action_just_pressed("ui_wear"):
			wear_item()


func get_active_item() -> PickableItem:
	return left_item if active_hand == Enums.HandType.LEFT else right_item


func use_item() -> void:
	var item = get_active_item()
	if item != null && item.has_method("use"):
		item.use(self)


func wear_item() -> void:
	var item = get_active_item()
	if item != null && item.has_method("wear"):
		item.wear(self)


func pick_item(item: ItemBase) -> void:
	set_active_item(item)
	item.move_item_to_parent(get_active_hand_parent())
	item.freeze_item(true)
	item.set_mesh_tools_layer(true)
	item.position = Vector3.ZERO
	item.rotation = Vector3.ZERO
	item_picked.emit(item)


func drop_item() -> void:
	var active_item = get_active_item()
	if active_item == null: return
	
	active_item.move_item_to_parent(G.player.get_parent())
	active_item.freeze_item(false)
	active_item.set_mesh_tools_layer(false)
	active_item.global_position = G.player.interaction.get_look_at_point()
	set_active_item(null)
	
	item_dropped.emit()


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
