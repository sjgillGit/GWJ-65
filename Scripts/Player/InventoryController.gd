extends Node

#--------------------
# Handles storing and holding items
# Has left and right arm and one slot for backpack
#--------------------

class_name Inventory

var left_item_code: String
var right_item_code: String
var active_hand: Enums.HandType = Enums.HandType.LEFT

signal item_picked(hand_type: Enums.HandType)
signal item_dropped(hand_type: Enums.HandType)
signal active_hand_switched()


func _process(_delta) -> void:
	if Input.is_action_just_pressed("ui_switch_hand"):
		switch_active_hand() 


func get_active_item() -> String:
	match active_hand:
		Enums.HandType.LEFT:
			return left_item_code
		Enums.HandType.RIGHT:
			return right_item_code
	return ""


func set_active_item(item_code: String) -> void:
	match active_hand:
		Enums.HandType.LEFT:
			left_item_code = item_code
		Enums.HandType.RIGHT:
			right_item_code = item_code
	
	item_picked.emit(item_code)


func switch_active_hand() -> void:
	if active_hand == Enums.HandType.LEFT:
		active_hand = Enums.HandType.RIGHT
	else:
		active_hand = Enums.HandType.LEFT
	
	active_hand_switched.emit()
