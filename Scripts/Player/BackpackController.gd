extends Node

#--------------------
# Handles wearing and taking off backpacks
# And storing items inside of it
#--------------------

class_name BackpackController

@onready var hands_controller: HandsController = get_node("../HandsController")

var backpack: BackpackItem
var opened_backpack: BackpackItem
var skip_one_frame: bool
var hand_is_switched: bool

signal is_on(backpack_item: BackpackItem)
signal is_removed(backpack_item: BackpackItem)

signal is_opened(backpackItem: BackpackItem)
signal is_closed()

signal item_is_packed_to_backpack()
signal item_is_removed_from_backpack()


func _process(_delta) -> void:
	if skip_one_frame:
		skip_one_frame = false
		return
	
	if Input.is_action_just_pressed("ui_use") and opened_backpack != null:
		close()
	if Input.is_action_just_pressed("ui_wear") and backpack != null:
		take_off()


func wear(new_backpack: BackpackItem) -> void:
	is_on.emit(new_backpack)
	backpack = new_backpack
	skip_one_frame = true


func take_off() -> void:
	if hands_controller.get_active_item() == null:
		var old_backpack = backpack
		backpack = null
		is_removed.emit(old_backpack)
		old_backpack.take_off(hands_controller)


func open(backpack_item: BackpackItem) -> void:
	if hands_controller.get_active_item() == backpack_item:
		hands_controller.switch_active_hand()
		hand_is_switched = true
	opened_backpack = backpack_item
	G.player.may_move = false
	hands_controller.may_use_hands = false
	is_opened.emit(backpack_item)
	skip_one_frame = true


func close() -> void:
	if hand_is_switched:
		hands_controller.switch_active_hand()
		hand_is_switched = false
	opened_backpack = null
	G.player.may_move = true
	hands_controller.may_use_hands = true
	is_closed.emit()


func get_item(id: int) -> void:
	var item = opened_backpack.container[id]
	item.visible = true
	G.player.hands.pick_item(item)
	opened_backpack.container.remove_at(id)
	item_is_removed_from_backpack.emit()


func put_active_item(backpack_to_put: BackpackItem) -> void:
	var item = G.player.hands.get_active_item()
	if item == null: return
	
	item.visible = false
	item.freeze_item(true)
	item.move_item_to_parent(G.player.get_parent())
	G.player.hands.set_active_item(null)
	
	if backpack_to_put != null:
		backpack_to_put.container.push_front(item)
	elif opened_backpack != null:
		opened_backpack.container.push_front(item)
	
	item_is_packed_to_backpack.emit()
